using UnityEngine;
using System;
using System.Collections;
using System.Collections.Generic;
using UnityEngine.Rendering;

/// <summary>
/// This script is a helper function which can restore a previously saved copy of the screen's alpha color values.
/// This is useful because some of LushLOD Tree's post processing effects rely on alpha color values for the tree pixels.
/// If you've created a copy of the screen, you can run post processing effects that might overwrite the alpha values of the pixels,
/// and this run this script afterwards to put those alpha values back on the screen again, if needed.
/// 
/// NOTE: This script restores the copy of the screen named _LushLODTreesScreenCopy2. A typical way to create this copy of the screen
/// is by using the script named _LushLODPostProcessor_CopyScreen.cs, which would be attached to the camera, and set to save a copy of
/// the screen to the name "Lush LOD Trees Screen Copy 2". This will create a global variable named _LushLODTreesScreenCopy2, which is
/// the variable that this script looks for. This script will restore the alpha values from _LushLODTreesScreenCopy2, putting them
/// back onto the screen at the selected spot in the rendering pipeline.
/// 
/// Select (using the Inspector window) a desired RestoreScreenEvent option. If you select the UseCameraEvent option, then be sure to
/// select a Forward or Deferred Camera Event using the drop down selectors. If you use the Camera Event option, then it doesn't matter
/// where this script is placed on the camera, it just needs to be attached to the camera. However, if you use any other option besides
/// RestoreScreenEvent, such as OnPreRender or OnEndOfFrame, you will need to place this script on the camera either ABOVE or BELOW the
/// other post processing effect(s) that you are working with. If you place it ABOVE, this script will run first. If you place this script
/// BELOW the others, then this script will run after them. But if you select UseCameraEvent, then it doesn't matter if this script is
/// above or below them, unless they also use CommandBuffers.
/// 
/// Note that this script is typically used alongside the _LushLODPostProcessor_CopyScreen.cs script, to both copy the screen and then
/// restore the alpha values of that copy at another point in the rendering pipeline. And this is usually only necessary if you are trying
/// to get LushLOD Trees to work correctly with another 3rd party post processing effect that is potentially overwriting the alpha values
/// of the screen pixels which are written by LushLOD Trees.
/// </summary>
public class _LushLODPostProcessor_RestoreAlpha : MonoBehaviour
{

    /// <summary>
    /// Gives us the option to capture the screen at various points in the rendering pipeline.
    /// </summary>
    public enum restoreScreenEvent
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

    private CameraEvent ForwardCameraEvent_PREVIOUS = CameraEvent.AfterEverything;
    private CameraEvent DeferredCameraEvent_PREVIOUS = CameraEvent.AfterEverything;

    public CameraEvent ForwardCameraEvent = CameraEvent.AfterEverything;
    public CameraEvent DeferredCameraEvent = CameraEvent.AfterEverything;

    private restoreScreenEvent RestoreScreenEvent_PREVIOUS = restoreScreenEvent.UseCameraEvent;
    public restoreScreenEvent RestoreScreenEvent = restoreScreenEvent.UseCameraEvent;

    private flipScreenY FlipScreenY_PREVIOUS = flipScreenY.No;
    public flipScreenY FlipScreenY = flipScreenY.No;

    private CommandBuffer cmdBuffer;
    private Material BlitCopyAlphaFlippable;
    private Camera ThisCam;
    private RenderingPath ActualPath = RenderingPath.Forward;
    
    void Awake()
    {             
        BlitCopyAlphaFlippable = new Material(Shader.Find("Hidden/LushLODTree/BlitCopyAlphaFlippable"));
    }

    void OnPreRender()
    {
        if (RestoreScreenEvent == restoreScreenEvent.OnPreRender)
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
                        Debug.LogError("LushLOD Post Processor Restore Alpha: unexpected rendering path.");
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
                RestoreScreenEvent_PREVIOUS != RestoreScreenEvent ||
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
            RestoreScreenEvent_PREVIOUS = RestoreScreenEvent;
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
                        Debug.LogError("LushLOD Post Processor Restore Alpha: unexpected rendering path.");
                        break;
                }
            } else if (ThisCam.actualRenderingPath != ActualPath)
            {
                ActualPath = ThisCam.actualRenderingPath;
            }

            cmdBuffer = new CommandBuffer();
            cmdBuffer.name = "cmdBuffer";

            cmdBuffer.SetGlobalFloat("_LushLODTreeFlipY", FlipScreenY_PREVIOUS == flipScreenY.Yes ? -1 : 1);
            cmdBuffer.Blit(null, BuiltinRenderTextureType.CameraTarget, BlitCopyAlphaFlippable); //<-- Copy alpha values from previously saved texture.

            if (RestoreScreenEvent == restoreScreenEvent.UseCameraEvent)
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
        Graphics.Blit(null, destination, BlitCopyAlphaFlippable);  //<-- Copy from screen to RT to "save" the stencil image. This is now available globally as _LushLODTreesScreenCopy.
    }

    //This function will be used if you set the value of RestoreScreenEvent to UseOnPostRender or OnEndOfFrame.
    //You can set the value of RestoreScreenEvent using the inspector.
    IEnumerator OnPostRender()
    {
        if (RestoreScreenEvent == restoreScreenEvent.OnPostRender)
        {
            DoRenderEvent();
        }
        else if (RestoreScreenEvent == restoreScreenEvent.OnEndOfFrame)
        {
            yield return new WaitForEndOfFrame(); //<-- helps ensure that this function runs after every other image effect.
            DoRenderEvent();
        }
    }

    //This function will be used if you set the value of RestoreScreenEvent to OnRenderImage.
    //You can set the value of RestoreScreenEvent using the inspector.
    void OnRenderImage(RenderTexture source, RenderTexture destination)
    {
        if (RestoreScreenEvent == restoreScreenEvent.OnRenderImage)
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