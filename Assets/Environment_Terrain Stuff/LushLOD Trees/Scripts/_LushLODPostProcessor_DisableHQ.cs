using UnityEngine;
using UnityEngine.Rendering;

//If you are using the LushLODTree "Ultra" quality setting, and one of your cameras is rendering the trees and they look terrible, attach this script to the camera to completely disable the
//high quality trees for THAT CAMERA ONLY. The camera will only render the "far" version of the billboard trees only, with no dithering. This should solve almost any imaginable visual
//glitches on that camera. Works best if that camera is rendering a non-important, blurry, or low resolution imagine, where you won't be able to notice that it isn't using the high quality
//tree models at all.
/// <summary>
/// Attach this script to a camera to force it to render only the billboard versions of the LushLOD Trees, with no dithering. This can be useful if you are seeing large checkerbox patterns on a particular
/// camera, such as a water reflection camera.
/// </summary>
public class _LushLODPostProcessor_DisableHQ : MonoBehaviour
{

    public static bool DisablingHQ = false;

    void OnEnable()
    {
        DisablingHQ = true;
    }

    void OnDisable()
    {
        DisablingHQ = false;
    }

    void Start()
    {
        DisablingHQ = true;
    }

    void OnPreRender()
    {
        Shader.SetGlobalInt("_LushLODTreeDisableFarDithering", 0); //<-- turn the dithering off, just before this camera begins to render.
        Shader.SetGlobalInt("_LushLODTreeDisableHQ", 0); //<-- turn the high quality tree models off.
    }
    void OnPostRender()
    {
        Shader.SetGlobalInt("_LushLODTreeDisableFarDithering", 1); //<-- turn the dithering back on, so other cameras will not be affected.
        Shader.SetGlobalInt("_LushLODTreeDisableHQ", 1); //<-- turn the high quality tree models back on.
    }
}