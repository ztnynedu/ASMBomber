using UnityEngine;
using System;
using System.Collections;
using System.Collections.Generic;
using UnityEngine.Rendering;

/// <summary>
/// Attach this script to your main camera if you are using the LushLODTree "Ultra" quality setting. This will perform a full-screen post processing effect
/// that removes the dithering checkerbox pattern from the trees, and creates a nice transparency that enables smooth transitions from billboards to high quality
/// tree models. Once attached to a camera, this script will automatically enable / disable itself as it continually checks to see if the manager is set
/// to use Ultra quality.
/// </summary>
public class _LushLODPostProcessor : MonoBehaviour
{

    /// <summary>
    /// Gives us the option to do our final blit on a PostRender rather than the command buffer.
    /// Because OnPostRender() calls actually occur after CommandBuffers, so this allows us to perform our
    /// final blit later in the rendering pineline than a commandbuffer would enable us to.
    /// </summary>
    public enum finalBlitEvent
    {
        UseCameraEvent,
        OnRenderImage,
        OnPostRender,
        OnEndOfFrame
    }

    private CameraEvent ForwardCameraEvent1_PREVIOUS = CameraEvent.BeforeImageEffects;
    private CameraEvent ForwardCameraEvent2_PREVIOUS = CameraEvent.AfterEverything;
    private CameraEvent DeferredCameraEvent1_PREVIOUS = CameraEvent.BeforeImageEffectsOpaque;
    private CameraEvent DeferredCameraEvent2_PREVIOUS = CameraEvent.AfterEverything;

    public CameraEvent ForwardCameraEvent1 = CameraEvent.BeforeImageEffects;
    public CameraEvent ForwardCameraEvent2 = CameraEvent.AfterEverything;
    public CameraEvent DeferredCameraEvent1 = CameraEvent.BeforeImageEffectsOpaque;
    public CameraEvent DeferredCameraEvent2 = CameraEvent.AfterEverything;

    private finalBlitEvent FinalBlitEvent_PREVIOUS = finalBlitEvent.UseCameraEvent;
    public finalBlitEvent FinalBlitEvent = finalBlitEvent.UseCameraEvent;

    private CommandBuffer cmdBuffer;
    private CommandBuffer cmdBuffer2;
    private Material ReapplySavedAlphaChannel;
    private Material ReapplySavedAlphaChannel_OnPostRender;
    private Material MakeNonStencilPixelsOpaque;
    private Material SmoothDitheringPostProcess;
    private Material SmoothDitheringPostProcess_OnPostRender;
    private Camera ThisCam;
    private RenderingPath ActualPath = RenderingPath.Forward;

    private RenderTexture StencilTexturePermanent;
    private RenderTexture OriginalTexturePermanent3;

    private RenderTargetIdentifier StencilTargetID;// = new RenderTargetIdentifier(StencilTexturePermanent);
    private RenderTargetIdentifier OriginalTargetID3;// = new RenderTargetIdentifier(OriginalTexturePermanent);

    private int PreviousScreenW = -1;
    private int PreviousScreenH = -1;

    private bool WarnedNoManager = false;

    //static Mesh s_Quad;
    //public static Mesh quad
    //{
    //    get
    //    {
    //        if (s_Quad != null)
    //            return s_Quad;

    //        var vertices = new[]
    //        {
    //            new Vector3(-0.5f, -0.5f, 0f),
    //            new Vector3(0.5f,  0.5f, 0f),
    //            new Vector3(0.5f, -0.5f, 0f),
    //            new Vector3(-0.5f,  0.5f, 0f)
    //        };

    //        var uvs = new[]
    //        {
    //            new Vector2(0f, 0f),
    //            new Vector2(1f, 1f),
    //            new Vector2(1f, 0f),
    //            new Vector2(0f, 1f)
    //        };

    //        var indices = new[] { 0, 1, 2, 1, 0, 3 };

    //        s_Quad = new Mesh
    //        {
    //            vertices = vertices,
    //            uv = uvs,
    //            triangles = indices
    //        };
    //        s_Quad.RecalculateNormals();
    //        s_Quad.RecalculateBounds();

    //        return s_Quad;
    //    }
    //}


    void Awake()
    {

        WarnedNoManager = false;

        ThisCam = GetComponent<Camera>();

        int texID_Original3 = Shader.PropertyToID("_LushLODOriginalPixels3"); //<-- can be accessed by shaders as global texture named _LushLODOriginalPixels.
        int texID_Stencil = Shader.PropertyToID("_LushLODStencilPixels"); //<-- can be accessed by shaders as global texture named _LushLODStencilPixels.

        MakeNonStencilPixelsOpaque = new Material(Shader.Find("Hidden/LushLODTree/MakeNonStencilPixelsOpaque"));
        SmoothDitheringPostProcess = new Material(Shader.Find("Hidden/LushLODTree/SmoothTheDithering"));
        SmoothDitheringPostProcess_OnPostRender = new Material(Shader.Find("Hidden/LushLODTree/SmoothTheDithering_OnPostRender"));
        ReapplySavedAlphaChannel = new Material(Shader.Find("Hidden/LushLODTree/ReapplySavedAlphaChannel"));
        ReapplySavedAlphaChannel_OnPostRender = new Material(Shader.Find("Hidden/LushLODTree/ReapplySavedAlphaChannel_OnPostRender"));

        //Clean up the resources if necessary:
        if (StencilTexturePermanent != null)
        {
            StencilTexturePermanent.Release();
            OriginalTexturePermanent3.Release();
        }

        StencilTexturePermanent = new RenderTexture(ThisCam.pixelWidth, ThisCam.pixelHeight, 24, RenderTextureFormat.ARGB32, RenderTextureReadWrite.Default);
        OriginalTexturePermanent3 = new RenderTexture(ThisCam.pixelWidth, ThisCam.pixelHeight, 24, RenderTextureFormat.ARGB32, RenderTextureReadWrite.Default);

        StencilTargetID = new RenderTargetIdentifier(StencilTexturePermanent);
         OriginalTargetID3 = new RenderTargetIdentifier(OriginalTexturePermanent3);

        Shader.SetGlobalTexture(texID_Stencil, StencilTexturePermanent);
        Shader.SetGlobalTexture(texID_Original3, OriginalTexturePermanent3);

        PreviousScreenH = ThisCam.pixelHeight;
        PreviousScreenW = ThisCam.pixelWidth;

    }

    void OnPreRender()
    {
        Shader.SetGlobalFloat("_LushLODTreeDisableFarDithering", 1f);
        if (_LushLODTree.TreesManager != null)
        {
            Shader.SetGlobalFloat("_LushLODTreeDisableHQ", _LushLODTree.TreesManager.BillBoardSetting_PREVIOUS == _LushLODTreesManager.BillBoardSettings.BillboardsOnly ? 0f : 1f);
            if (cmdBuffer == null && _LushLODTree.TreesManager != null && _LushLODTree.TreesManager.billboard_quality_PREVIOUS == _LushLODTreesManager.BillboardQualitySettings.Ultra)
            {
                //Obviously this post processor is enabled, because how else could we be here?
                //Yet the cmdBuffer is null, which means it isn't working.
                //But the Manager indicates that we are using Ultra quality, so we need the cmdBuffer to be enabled.
                OnEnable2(); //<- enable the cmd buffer.
            }
            else if (cmdBuffer != null && _LushLODTree.TreesManager != null && _LushLODTree.TreesManager.billboard_quality_PREVIOUS != _LushLODTreesManager.BillboardQualitySettings.Ultra)
            {
                //The cmdBuffer is active,
                //But the manager indicates that we are NOT using ultra quality. So we need to turn the cmdBuffer off.
                //Otherwise it will waste precious frame rate.
                OnDisable(); //<- disable the cmd buffer.
            }
        }
        else
        {
            Shader.SetGlobalFloat("_LushLODTreeDisableHQ", 1f);
        }

        if (ThisCam == null) ThisCam = GetComponent<Camera>();
        //ThisCam.forceIntoRenderTexture = true;
        if (PreviousScreenH != ThisCam.pixelHeight || PreviousScreenW != ThisCam.pixelWidth)
        {
            //Screen size changed. This will wreck our permanent render textures. Let's remake them.
            Awake();
            OnDisable();
            OnEnable();
        }

    }

    void Update()
    {

        if (cmdBuffer != null)
        {
            if (ThisCam == null) ThisCam = GetComponent<Camera>();

            //If the user changes the rendering path, then restart the command buffer.
            if (_LushLODTree.TreesManager != null)
            {
                //Use the manager to set the rendering path.
                switch (_LushLODTree.TreesManager.RenderingMode_PREVIOUS)
                {
                    case _LushLODTreesManager.RenderingModes.Forward:
                        if (ActualPath != RenderingPath.Forward)
                        {
                            ActualPath = RenderingPath.Forward;
                            OnDisable();
                            OnEnable();
                        }
                        break;
                    case _LushLODTreesManager.RenderingModes.Deferred:
                        if (ActualPath != RenderingPath.DeferredShading)
                        {
                            ActualPath = RenderingPath.DeferredShading;
                            OnDisable();
                            OnEnable();
                        }
                        break;
                    default:
                        Debug.LogError("LushLOD Post Processor: unexpected rendering path.");
                        break;
                }
            }
            else if (ThisCam.actualRenderingPath != ActualPath)
            {
                ActualPath = ThisCam.actualRenderingPath;
                OnDisable();
                OnEnable();
                return;
            }

            if (ForwardCameraEvent1_PREVIOUS != ForwardCameraEvent1 ||
                ForwardCameraEvent2_PREVIOUS != ForwardCameraEvent2 ||
                DeferredCameraEvent1_PREVIOUS != DeferredCameraEvent1 ||
                DeferredCameraEvent2_PREVIOUS != DeferredCameraEvent2 ||
                FinalBlitEvent_PREVIOUS != FinalBlitEvent)
            {
                OnDisable();
                OnEnable();
                return;
            }               

        }
    }
    
    void OnEnable2()
    {
        CancelInvoke("OnEnable2");

        if (_LushLODTree.TreesManager == null)
        {
            OnDisable();
            return;
        }
        else if (_LushLODTree.TreesManager.billboard_quality_PREVIOUS != _LushLODTreesManager.BillboardQualitySettings.Ultra)
        {
            OnDisable();
            return;
        }

        if (cmdBuffer == null)
        {

            ThisCam = GetComponent<Camera>();

            ForwardCameraEvent1_PREVIOUS = ForwardCameraEvent1;
            ForwardCameraEvent2_PREVIOUS = ForwardCameraEvent2;
            DeferredCameraEvent1_PREVIOUS = DeferredCameraEvent1;
            DeferredCameraEvent2_PREVIOUS = DeferredCameraEvent2;
            FinalBlitEvent_PREVIOUS = FinalBlitEvent;

            if (_LushLODTree.TreesManager != null)
            {
                //Use the manager to set the rendering path.
                switch(_LushLODTree.TreesManager.RenderingMode_PREVIOUS)
                {
                    case _LushLODTreesManager.RenderingModes.Forward:
                        ActualPath = RenderingPath.Forward;
                        break;
                    case _LushLODTreesManager.RenderingModes.Deferred:
                        ActualPath = RenderingPath.DeferredShading;
                        break;
                    default:
                        Debug.LogError("LushLOD Post Processor: unexpected rendering path.");
                        break;
                }
            } else if (ThisCam.actualRenderingPath != ActualPath)
            {
                ActualPath = ThisCam.actualRenderingPath;
            }
                  
            cmdBuffer = new CommandBuffer();
            cmdBuffer.name = "cmdBuffer";

            cmdBuffer2 = new CommandBuffer();
            cmdBuffer2.name = "cmdBuffer2";

            //*********************************************************************************************************************************************************
            // As of 9/25/2016, the following 4 blits are necessary due to bugs and other problems with CommandBuffer.Blit()
            // See my threads for more details:
            // http://forum.unity3d.com/threads/commandbuffer-blit-isnt-stencil-buffer-friendly.432776/
            // http://forum.unity3d.com/threads/commandbuffer-blit-with-no-custom-shader-commandbuffer-blit-with-internal_blitcopy-shader.432699/
            // http://forum.unity3d.com/threads/has-anyone-ever-gotten-a-stencil-buffer-to-copy-with-commandbuffer-blit.432503/
            // And my bug report: https://fogbugz.unity3d.com/default.asp?834634_utcuq9n1gbgpbit3
            //*********************************************************************************************************************************************************

            //1)    If you blit from the screen to a rendertexture, you can't use a custom shader... or else the resulting render texture is blank.
            //Also, it never copies the stencil to any render texture. I believe both these issues are bugs.

            //2)    If you blit from a render texture, to another render texture, the stencil can't be access in the shader. Probably because as I said in #1, 
            //stencils aren't copied to render textures. I believe this is a bug.

            //3)    If you blit from a render texture to the screen, everything works including the stencil (weee!!), 
            //but now you just over - written the picture on the screen. You'd then have to fix that, I suppose with another blit to put the picture back again.

            //4)    You can't blit from screen to screen, or from one render texture to itself, unless your shader specifically uses a global texture (not _MainTex). 
            //Otherwise result is blank picture.

            //5)    Any attempt to render the camera to a render texuture will result in no ability to access or use the stencil buffer, due to issue #1 above.

            //*********************************************************************************************************************************************************


            //How this post processor works:

            //-> For LushLOD Tree's Ultra quality setting, we can use two command buffers to perform a post processing effect on the whole screen.
            //-> The purpose of this post processing effect is to get rid of the ugly checkerdbox pattern in the LushLOD Trees.
            //-> It blends and removes the checkerdbox pattern using a full-screen shader called "SmoothTheDithering.shader" (which is fully editable in Shader Force by the way)
            //-> This shader reads from each of the pixels affected by the checkerdbox pattern, and also reads the surrounding pixels, and blends them together to give the LushLOD Trees their transparency.
            //-> The checkerdbox pattern simply removes every other pixel from both the high quality tree models, and from the billboards.
            //-> But to allow us to actually see the billboard pixels through the high quality tree models, the billboards draw their checkerdbox pattern with every pixel shifted one pixel to the side.
            //-> So during transitions, every EVEN pixel will be a billboard, and every ODD pixel will be the high quality tree model (or vise versa), so we can somewhat see both trees simultaniously.
            //-> We use a "stencil buffer" to mark each and every pixel that was drawn by the LushLOD Trees. The stencil buffer helps us FIND the LushLOD Tree checkerdbox patterns that need blending,
            //      so that we don't blend the whole screen.
            //-> We also use an alpha value, which is saved into the color of each pixel drawn by LushLOD Trees. And the alpha value tells us how visible those pixels are supposed to be. 
            //-> So using the checkerdbox pattern, which lets us see both the billboard and the high quality tree model, we can see their alpha values to know how visible each of them are supposed to be.
            //-> Our post processing then reads those alpha values, and blends between the pixels of the high quality tree, and its billboard, creating the final effect of a smooth transition.
            //-> The first CommandBuffer will attempt to save a copy of the screen that has both the stencil and the alpha values we need, as EARLY AS POSSIBLE in the rendering pipeline, 
            //      preferably before other transparent objects or image effects have a chance to overwrite our stencil or alpha color values, because that would be bad.
            //      Note that it may not always be easy to capture a copy of the screen before another object or effect overwrites our stencil or alpha values, but that early screen capture is our GOAL.
            //-> The second CommandBuffer will perform the actual post processing effect, and typically you will want to run it as LATE AS POSSIBLE in the rendering pipeline, 
            //      so that it performs the final blend (to remove the checkerdbox pattern) after all other post processing effects have finished. However, some other 3rd party post processing 
            //      effects may not work right and may perform very poorly if there are checkerdbox patterns on the screen, and so you can make it run this post processing effect to remove the
            //      checkerdbox pattern either after OR BEFORE other 3rd party effects run, to make it more compatible with your other 3rd party post processing effects.
            //      Note that this LushLOD Post processing effect only blends and removes the checkerdbox pattern from the COLORS on the SCREEN, similar to photoshopping the screen, and it does not take
            //      into account the depth buffer AT ALL, or any 3D shadow data, lightmap data, or ANYTHING 3-dimentional whatsoever. So the checkerdbox pattern will appear to be gone on the screen, but
            //      it may still have a checkerdbox pattern in the depth buffers, so other 3rd party post image effects that look at the depth or shadow buffers may still "see" the
            //      checkerdbox pattern, and could react to it in an undesirable way, EVEN AFTER this LushLOD post processing effect blends and removes it from the screen.
            //-> You can select which point the first commandBuffer runs by setting the value of ForwardEvent1 in the inspector (or DeferredEvent1 if you are using Deferred rendering).
            //-> And you can select which point in the rendering pipeline the second commandBuffer runs by setting ForwardEvent2 (or DeferredEvent2 for deferred rendering).

            //Note: OnPostRender() runs after all CommandBuffers have finished, including CommandBuffers that use CameraEvent.AfterEverything!
            //So some image effects could potentially run after this command buffer is finished. If that's not what you want, you can use the inspector to set
            //the value of FinalBlitEvent to "UseOnPostRender", which will cause us to do our final post processing blit using the OnPostRender() call in the next function below.

            int Tmp1 = Shader.PropertyToID("_LushLODTreeTempRT1");
            int Tmp2 = Shader.PropertyToID("_LushLODTreeTempRT2");

            //Use temporary RT's for anything we don't need to be saved permanently, because temporary rendertextures are supposedly faster.
            cmdBuffer.GetTemporaryRT(Tmp1, ThisCam.pixelWidth, ThisCam.pixelHeight, 24, FilterMode.Bilinear, RenderTextureFormat.ARGB32);
        
            cmdBuffer.Blit(BuiltinRenderTextureType.CameraTarget, Tmp1); //<-- Copy from screen to RT with no shader. See Issue #1 above for reasoning.
            cmdBuffer.Blit(Tmp1, BuiltinRenderTextureType.CameraTarget, MakeNonStencilPixelsOpaque); // Sets all non-stencil pixels to fully opaque.
            cmdBuffer.Blit(BuiltinRenderTextureType.CameraTarget, StencilTargetID); //<-- Copy from screen to RT to "save" the stencil image. Necessary due to issue #4 above.
            cmdBuffer.Blit(Tmp1, BuiltinRenderTextureType.CameraTarget); //<-- Put original picture back on the screen.

            cmdBuffer.ReleaseTemporaryRT(Tmp1);

            cmdBuffer2.Blit(BuiltinRenderTextureType.CameraTarget, OriginalTargetID3); //<-- Copy from screen to RT with no shader. This gets the color of the pixels AFTER other transparent objects and/or other post processing effects have finished.

            cmdBuffer2.GetTemporaryRT(Tmp2, ThisCam.pixelWidth, ThisCam.pixelHeight, 24, FilterMode.Bilinear, RenderTextureFormat.ARGB32);
            cmdBuffer2.Blit(StencilTexturePermanent, Tmp2, ReapplySavedAlphaChannel);  //<-- Testing method.
               
            cmdBuffer2.Blit(Tmp2, BuiltinRenderTextureType.CameraTarget, SmoothDitheringPostProcess); // Do post processing. OriginalTexturePermanent2 will be _MainTex.
                        
            cmdBuffer2.ReleaseTemporaryRT(Tmp2);

            switch (ActualPath)
            {
                case RenderingPath.Forward:

                    ThisCam.AddCommandBuffer(ForwardCameraEvent1_PREVIOUS, cmdBuffer);
                    if (FinalBlitEvent == finalBlitEvent.UseCameraEvent)
                        ThisCam.AddCommandBuffer(ForwardCameraEvent2_PREVIOUS, cmdBuffer2);

                    break;
                case RenderingPath.DeferredShading:

                    ThisCam.AddCommandBuffer(DeferredCameraEvent1_PREVIOUS, cmdBuffer);
                    if (FinalBlitEvent == finalBlitEvent.UseCameraEvent)
                        ThisCam.AddCommandBuffer(DeferredCameraEvent2_PREVIOUS, cmdBuffer2);
                    
                    break;
                default:
                    //LushLOD Trees currently doesn't support this rendering path. But, we need to do something here.
                    UnityEngine.Debug.LogError("LushLOD Trees Ultra quality only works on Forward or Deferred rendering path. Please set your main camera to render to either Forward or Deferred mode, or switch to different LushLOD Tree quality setting (other than Ultra).");
                    break;
            }
        }
    }

    void DoRenderEvent()
    {
        Graphics.Blit(StencilTexturePermanent, ReapplySavedAlphaChannel_OnPostRender);  //<-- This shader uses SceneColor to grab the current picture off the screen. Since I couldn't figure out how else to get it from OnPostRender(). This means we are missing _LushLODOriginalPixels3.
        Graphics.Blit((RenderTexture)null, SmoothDitheringPostProcess_OnPostRender); //<-- won't be able to use _LushLODOriginalPixels3 in the shader, since we didn't (couldn't?) set it here, see comment above. This means we can't put the original alpha values back on the screen.
     }

    //This function will be used if you set the value of FinalBlitEvent to UseOnPostRender or OnEndOfFrame.
    //You can set the value of FinalBlitEvent using the inspector.
    IEnumerator OnPostRender()
    {
        if (_LushLODTree.TreesManager == null)
        {
            if (WarnedNoManager == false)
            {
                WarnedNoManager = true;
                Debug.LogWarning("There is no _LushLODTreesManger in your scene, but the _LushLODTreesPostProcessor is RUNNING on your Camera!");
            }
            if (cmdBuffer != null || cmdBuffer2 != null) OnDisable();
            yield break;
        }
        else if (_LushLODTree.TreesManager.billboard_quality_PREVIOUS != _LushLODTreesManager.BillboardQualitySettings.Ultra)
        {
            if (cmdBuffer != null || cmdBuffer2 != null) OnDisable();
            yield break;
        }

        if (FinalBlitEvent == finalBlitEvent.OnPostRender)
        {
            DoRenderEvent();
        }

        yield return new WaitForEndOfFrame(); //<-- helps ensure that this function runs after every other image effect.

        if (FinalBlitEvent == finalBlitEvent.OnEndOfFrame)
        {
            DoRenderEvent();
        }
    }

    //This function will be used if you set the value of FinalBlitEvent to OnRenderImage.
    //You can set the value of FinalBlitEvent using the inspector.
    void OnRenderImage(RenderTexture source, RenderTexture destination)
    {
        if (_LushLODTree.TreesManager == null)
        {
            if (WarnedNoManager == false)
            {
                WarnedNoManager = true;
                Debug.LogWarning("There is no _LushLODTreesManger in your scene, but the _LushLODTreesPostProcessor is RUNNING on your Camera!");
            }
            if (cmdBuffer != null || cmdBuffer2 != null) OnDisable();
            Graphics.Blit(source, destination);
            return;
        }
        else if (_LushLODTree.TreesManager.billboard_quality_PREVIOUS != _LushLODTreesManager.BillboardQualitySettings.Ultra)
        {
            if (cmdBuffer != null || cmdBuffer2 != null) OnDisable();
            Graphics.Blit(source, destination);
            return;
        }

        if (FinalBlitEvent == finalBlitEvent.OnRenderImage)
        {
            Graphics.Blit(source, destination);
            DoRenderEvent();
        }
        else
        {
            Graphics.Blit(source, destination);
         }
    }

    void OnEnable()
    {
        InvokeRepeating("OnEnable2", 1f, 99f); //<-- schedules this LOD to be applied in exactly 1 second.
                                                 //This helps ensure that we don't try to change the LOD while the user
                                                 //is still moving the slider bar, unless the stop for a whole second.  
    }

    void OnDisable()
    {
        CancelInvoke("OnEnable2");
        ThisCam = GetComponent<Camera>();
        if (ThisCam != null && ReferenceEquals(ThisCam, null) == false)
        {
            if (cmdBuffer != null)
                ThisCam.RemoveCommandBuffer(ForwardCameraEvent1_PREVIOUS, cmdBuffer);
            if (cmdBuffer != null)
                ThisCam.RemoveCommandBuffer(DeferredCameraEvent1_PREVIOUS, cmdBuffer);
            if (cmdBuffer2 != null)
                ThisCam.RemoveCommandBuffer(ForwardCameraEvent2_PREVIOUS, cmdBuffer2);
            if (cmdBuffer2 != null)
                ThisCam.RemoveCommandBuffer(DeferredCameraEvent2_PREVIOUS, cmdBuffer2);
        }
        cmdBuffer = null;
        cmdBuffer2 = null;
    }
}

//#if UNITY_EDITOR
//// Custom Editor using SerializedProperties.
//// Automatic handling of multi-object editing, undo, and prefab overrides.
//[CustomEditor(typeof(_LushLODPostProcessor))]
////[CanEditMultipleObjects]
//public class _LushLODPostProcessor_Editor : Editor
//{
//    public override void OnInspectorGUI()
//    {
//        // Update the serializedProperty - always do this in the beginning of OnInspectorGUI.
//        serializedObject.Update();

//        var Redstyle = new GUIStyle(GUI.skin.box);
//        Redstyle.normal.textColor = Color.green;

//        GUILayout.Space(10f);
        
//        GUILayout.Box("HI! This is a LushLOD Post Processor script!", Redstyle);

//        GUILayout.Space(10f);

//        DrawDefaultInspector();

//    }
//}

//#endif