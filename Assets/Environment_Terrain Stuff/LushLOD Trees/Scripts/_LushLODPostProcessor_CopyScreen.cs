using UnityEngine;
using System;
using System.Collections;
using System.Collections.Generic;
using UnityEngine.Rendering;

/// <summary>
/// This script is a helper function which simply saves a full copy of the screen at a specified spot in the rendering pipeline.
/// The copy of the screen is saved by default to a variable named _LushLODTreesScreenCopy which can be accessed globally by any
/// shader by simply adding the following text: uniform sampler2D _LushLODTreesScreenCopy; uniform float4 _LushLODTreesScreenCopy_ST;
/// (the above text should be placed somewhere above the fragment or surface shader functions).
/// This is a texture which can then be read by the shader to get the screen's pixels at the time where the LushLOD Trees had just finished
/// being drawn to the screen, before other transparent or post processing effects had an opportunity to "mess with" the pixels.
/// This can be used, for example, to save a copy of the alpha values of the LushLOD Tree pixels, for use later in a post processing effect.
/// </summary>
public class _LushLODPostProcessor_CopyScreen : MonoBehaviour
{

    /// <summary>
    /// Gives us the option to capture the screen at various points in the rendering pipeline.
    /// </summary>
    public enum copyScreenEvent
    {
        UseCameraEvent,
        OnPreRender,
        OnRenderImage,
        OnPostRender,
        OnEndOfFrame
    }

    public enum flipScreenY
    {
        No,
        Yes
    }

    public enum globalVariableName
    {
        _LushLODTreesScreenCopy,
        _LushLODTreesScreenCopy2
    }

    private CameraEvent ForwardCameraEvent_PREVIOUS = CameraEvent.BeforeImageEffects;
    private CameraEvent DeferredCameraEvent_PREVIOUS = CameraEvent.BeforeImageEffectsOpaque;

    public CameraEvent ForwardCameraEvent = CameraEvent.BeforeImageEffects;
    public CameraEvent DeferredCameraEvent = CameraEvent.BeforeImageEffectsOpaque;

    private copyScreenEvent CopyScreenEvent_PREVIOUS = copyScreenEvent.UseCameraEvent;
    public copyScreenEvent CopyScreenEvent = copyScreenEvent.UseCameraEvent;

    private globalVariableName GlobalShaderVariableName_PREVIOUS = globalVariableName._LushLODTreesScreenCopy;
    public globalVariableName GlobalShaderVariableName = globalVariableName._LushLODTreesScreenCopy;

    private flipScreenY FlipScreenY_PREVIOUS = flipScreenY.No;
    public flipScreenY FlipScreenY = flipScreenY.No;

    private CommandBuffer cmdBuffer;
    private Material BlitCopyFlippable;
    private Camera ThisCam;
    private RenderingPath ActualPath = RenderingPath.Forward;

    private RenderTexture OutputTexturePermanent;
    private RenderTargetIdentifier OutputTargetID;

    private int PreviousScreenW = -1;
    private int PreviousScreenH = -1;

    void Awake()
    {

        ThisCam = GetComponent<Camera>();

        //ThisCam.forceIntoRenderTexture = true;
        
        BlitCopyFlippable = new Material(Shader.Find("Hidden/LushLODTree/BlitCopyFlippable"));
    
        //Clean up the resources if necessary:
        if (OutputTexturePermanent != null)
        {
            OutputTexturePermanent.Release();
        }

        OutputTexturePermanent = new RenderTexture(ThisCam.pixelWidth, ThisCam.pixelHeight, 24, RenderTextureFormat.ARGB32, RenderTextureReadWrite.Default);

        OutputTargetID = new RenderTargetIdentifier(OutputTexturePermanent);

        PreviousScreenH = ThisCam.pixelHeight;
        PreviousScreenW = ThisCam.pixelWidth;

    }

    void OnPreRender()
    {
        if (ThisCam == null) ThisCam = GetComponent<Camera>();
        if (PreviousScreenH != ThisCam.pixelHeight || PreviousScreenW != ThisCam.pixelWidth)
        {
            //Screen size changed. This will wreck our permanent render textures. Let's remake them.
            Awake();
            OnDisable();
            OnEnable();
        }
        if (CopyScreenEvent == copyScreenEvent.OnPreRender)
        {
            DoRenderEvent();
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
                        Debug.LogError("LushLOD Post Processor Copy Screen: unexpected rendering path.");
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

            if (ForwardCameraEvent_PREVIOUS != ForwardCameraEvent ||
                DeferredCameraEvent_PREVIOUS != DeferredCameraEvent ||
                CopyScreenEvent_PREVIOUS != CopyScreenEvent ||
                GlobalShaderVariableName_PREVIOUS != GlobalShaderVariableName ||
                FlipScreenY_PREVIOUS != FlipScreenY)
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

        if (cmdBuffer == null)
        {

            ThisCam = GetComponent<Camera>();

            ForwardCameraEvent_PREVIOUS = ForwardCameraEvent;
            DeferredCameraEvent_PREVIOUS = DeferredCameraEvent;
            CopyScreenEvent_PREVIOUS = CopyScreenEvent;
            GlobalShaderVariableName_PREVIOUS = GlobalShaderVariableName;
            FlipScreenY_PREVIOUS = FlipScreenY;

            if (_LushLODTree.TreesManager != null)
            {
                //Use the manager to set the rendering path.
                switch (_LushLODTree.TreesManager.RenderingMode_PREVIOUS)
                {
                    case _LushLODTreesManager.RenderingModes.Forward:
                        ActualPath = RenderingPath.Forward;
                        break;
                    case _LushLODTreesManager.RenderingModes.Deferred:
                        ActualPath = RenderingPath.DeferredShading;
                        break;
                    default:
                        Debug.LogError("LushLOD Post Processor Copy Screen: unexpected rendering path.");
                        break;
                }
            } else if (ThisCam.actualRenderingPath != ActualPath)
            {
                ActualPath = ThisCam.actualRenderingPath;
            }

            cmdBuffer = new CommandBuffer();
            cmdBuffer.name = "cmdBuffer";
                    
            int texID_Output = Shader.PropertyToID(GlobalShaderVariableName_PREVIOUS.ToString()); //<-- can be accessed by shaders as global texture named _LushLODTreesScreenCopy (default name).
            Debug.Log(GlobalShaderVariableName_PREVIOUS.ToString());

            cmdBuffer.SetGlobalFloat("_LushLODTreeFlipY", FlipScreenY_PREVIOUS == flipScreenY.Yes ? -1 : 1);
            cmdBuffer.Blit(BuiltinRenderTextureType.CameraTarget, OutputTargetID, BlitCopyFlippable); //<-- Copy from screen to RT to "save" the stencil image.  This is now available globally as _LushLODTreesScreenCopy (default name).
            cmdBuffer.SetGlobalTexture(texID_Output, OutputTexturePermanent);
        
        
            if (CopyScreenEvent == copyScreenEvent.UseCameraEvent)
            {
                switch (ActualPath)
                {
                    case RenderingPath.Forward:
                        ThisCam.AddCommandBuffer(ForwardCameraEvent_PREVIOUS, cmdBuffer);
                        break;
                    case RenderingPath.DeferredShading:
                        ThisCam.AddCommandBuffer(DeferredCameraEvent_PREVIOUS, cmdBuffer);
                        break;
                    default:
                        //LushLOD Trees currently doesn't support this rendering path. But, we need to do something here.
                        ThisCam.AddCommandBuffer(ForwardCameraEvent_PREVIOUS, cmdBuffer); //<-- guess we'll use forward.
                        break;
                }
            }
        }
    }

    void DoRenderEvent(RenderTexture source = null, RenderTexture destination = null)
    {
        Shader.SetGlobalFloat("_LushLODTreeFlipY", FlipScreenY_PREVIOUS == flipScreenY.Yes ? -1 : 1);
        Graphics.Blit(source, OutputTexturePermanent, BlitCopyFlippable);  //<-- Copy from screen to RT to "save" the stencil image. This is now available globally as _LushLODTreesScreenCopy (default name).
        int texID_Output = Shader.PropertyToID(GlobalShaderVariableName_PREVIOUS.ToString()); //<-- can be accessed by shaders as global texture named _LushLODTreesScreenCopy (default name).
        Shader.SetGlobalTexture(texID_Output, OutputTexturePermanent);
    }

    //This function will be used if you set the value of CopyScreenEvent to UseOnPostRender or OnEndOfFrame.
    //You can set the value of CopyScreenEvent using the inspector.
    IEnumerator OnPostRender()
    {
        if (CopyScreenEvent == copyScreenEvent.OnPostRender)
        {
            DoRenderEvent();
        }
        else if (CopyScreenEvent == copyScreenEvent.OnEndOfFrame)
        {
            yield return new WaitForEndOfFrame(); //<-- helps ensure that this function runs after every other image effect.
            DoRenderEvent();
        }
    }

    //This function will be used if you set the value of CopyScreenEvent to OnRenderImage.
    //You can set the value of CopyScreenEvent using the inspector.
    void OnRenderImage(RenderTexture source, RenderTexture destination)
    {
        if (CopyScreenEvent == copyScreenEvent.OnRenderImage)
        {
            DoRenderEvent(source, destination);
            Graphics.Blit(source, destination); //<-- Put original picture back on the screen.
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
                ThisCam.RemoveCommandBuffer(ForwardCameraEvent_PREVIOUS, cmdBuffer);
            if (cmdBuffer != null)
                ThisCam.RemoveCommandBuffer(DeferredCameraEvent_PREVIOUS, cmdBuffer);
        }
        cmdBuffer = null;
    }
}