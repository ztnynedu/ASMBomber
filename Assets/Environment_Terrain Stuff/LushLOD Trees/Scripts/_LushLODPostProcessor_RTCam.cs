using UnityEngine;
using UnityEngine.Rendering;

/// <summary>
/// Attach this script to a camera that is rendering to a render texture, to tell that camera to perform the LushLODTree Post Processing effect.
/// This is expensive, and you should only do this if the camera is rendering a very important texture in high resolution. For low resolution cameras, such as certain
/// water reflection cameras, it's much cheaper and will probably look better to simply turn the dithering off for that camera. To turn the dithering off, attach the
/// other script named _LushLODPostProcessor_DisableFarDithering.cs to the camera.
/// </summary>
public class _LushLODPostProcessor_RTCam : MonoBehaviour
{
    private Material SmoothDitheringPostProcess;
    private Material MakeNonStencilPixelsOpaque;
    private Material BlitCopy;
    private RenderTexture OriginalPixels;
    private RenderTexture StencilPixels;

    void DontHogSoMuchMemory()
    {
        //Every time we resize the window, it instances another window-size rendetexture.
        //So dragging around the window in the Unity editor can spam dozens of instances of
        //render textures, which would eat up all the RAM on the computer if we don't destroy them. :)
        if (OriginalPixels != null ||
            StencilPixels != null)
        {
            if (OriginalPixels != null) Destroy(OriginalPixels);
            if (StencilPixels != null) Destroy(StencilPixels);
        }
    }

    void Update()
    {
        if (OriginalPixels.width != Screen.width || OriginalPixels.height != Screen.height)
        {
            DontHogSoMuchMemory();
            OriginalPixels = new RenderTexture(Screen.width, Screen.height, 24, RenderTextureFormat.ARGB32);
            StencilPixels = new RenderTexture(Screen.width, Screen.height, 24, RenderTextureFormat.ARGB32);
        }
    }

    void OnEnable()
    {
        Start();
    }

    void OnPreRender()
    {
        Shader.SetGlobalInt("_LushLODTreeDisableFarDithering", 1); //<-- turn the dithering and HQ trees on, in case any other script has turned them off.
        Shader.SetGlobalInt("_LushLODTreeDisableHQ", _LushLODTree.TreesManager.BillBoardSetting_PREVIOUS == _LushLODTreesManager.BillBoardSettings.BillboardsOnly ? 0 : 1);
    }

    void Start()
    {
        DontHogSoMuchMemory();
        MakeNonStencilPixelsOpaque = new Material(Shader.Find("Hidden/LushLODTree/MakeNonStencilPixelsOpaque"));
        SmoothDitheringPostProcess = new Material(Shader.Find("Hidden/LushLODTree/SmoothTheDithering"));
        BlitCopy = new Material(Shader.Find("Hidden/BlitCopy")); //<-- Use Unity's builtin Internal_BlitCopy shader.
        OriginalPixels = new RenderTexture(Screen.width, Screen.height, 24, RenderTextureFormat.ARGB32);
        StencilPixels = new RenderTexture(Screen.width, Screen.height, 24, RenderTextureFormat.ARGB32);
    }

    void OnRenderImage(RenderTexture src, RenderTexture dest)
    {
        if (_LushLODTree.TreesManager != null && _LushLODTree.TreesManager.billboard_quality_PREVIOUS == _LushLODTreesManager.BillboardQualitySettings.Ultra)
        {
            Graphics.Blit(src, OriginalPixels, BlitCopy); //<-- make a copy of the texture before we mess with it.
            Shader.SetGlobalTexture("_LushLODOriginalPixels", OriginalPixels);
            Graphics.Blit(src, StencilPixels, MakeNonStencilPixelsOpaque); //<-- make the stencil texture
            Graphics.Blit(StencilPixels, dest, SmoothDitheringPostProcess); //<-- _MainTex will be the stencil texture, and original pixels will be _LushLODOriginalPixels
        }
        else
        {
            Graphics.Blit(src, dest);
        }
    }
}