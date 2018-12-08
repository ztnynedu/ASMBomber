using UnityEngine;
#if UNITY_EDITOR
using UnityEditor;
#endif 
using System.Collections;
using System.Collections.Generic;

/// <summary>
/// This script / class is (or should be) attached to a gameobject in the scene's heirarchy, 
/// which should also be named "_LushLODTreesManager". It can automatically be added to the scene
/// by any _LushLODTree in the scene.
///
/// This is the LushLOD Trees Manager,
/// which allows you to control some useful settings for all the trees
/// in your scene. No more clicking through every tree just to
/// make a simple adjustment. The manager can be used to quickly test
/// framerate-critical options, allowing you to modify:
/// 1) The colors for the far and near trees.
/// 2) The LOD Distance.
/// 3) Billboard settings.
/// 4) Quality settings.
/// 5) Shadow settings.
/// 6) More options coming soon!
///
/// With all these options availale, you'll be able to tweak the
/// settings to get the exact balance you need between quality and
/// framerate. Perfect for multiplatform releases and mobile!
/// </summary>
[ExecuteInEditMode] //<-- hover mouse to see description.
public class _LushLODTreesManager : MonoBehaviour
{

#if UNITY_EDITOR
    /// <summary>
    /// This lets you set the quality for the trees while working in edit mode in the Unity editor.
    /// For large forests of thousands of trees, you may want to set the quality to billboards or even to None,
    /// so that the trees do not slow you down while you are editing other assets in your scene.
    /// </summary>
    [System.Serializable]
    public enum previewMode
    {
        HighQuality,
        Billboards,
        None
    }
    /// <summary>
    /// This lets you set the quality for the trees while working in edit mode in the Unity editor.
    /// For large forests of thousands of trees, you may want to set the quality to billboards or even to None,
    /// so that the trees do not slow you down while you are editing other assets in your scene.
    /// </summary>
    [HideInInspector]
    public previewMode PreviewMode = previewMode.HighQuality;

    /// <summary>
    /// This variable contains the value on the previous frame. Used to detect if we changed the value.
    /// </summary>
    [HideInInspector]
    public previewMode PreviewMode_PREVIOUS = previewMode.HighQuality;
#endif

    /// <summary>
    /// This variable is incremented if any changes were made in the manager which would
    /// result in different shaders being applied to the materials on the trees in the scene.
    /// If this number is incremented, the _LushLODTree.cs script will detect it, and update
    /// all the trees in the scene to use new shaders that match the settings found in the
    /// manager.
    /// </summary>
    [HideInInspector]
    public int ShaderSettingsChanged = 0;

    /// <summary>
    /// This variable allows the manager to detect that a change has occured in the
    /// ShaderSettingsChanged variable. There is no need to use this variable elsewhere.
    /// </summary>
    [HideInInspector]
    private int ShaderSettingsChanged_PREVIOUS = 0;

    /// <summary>
    /// This variable lets us adjust the contrast of the shadows.
    /// </summary>
    [HideInInspector]
    public float ShadowContrast = 2.0f;
    [HideInInspector]
    public float ShadowContrast_PREVIOUS = 2.0f;

    /// <summary>
    /// This variable lets us adjust the way the trees respond to the sun when it is near or below the horizon.
    /// </summary>
    [HideInInspector]
    public float TimeOfDay = 1.0f;
    [HideInInspector]
    public float TimeOfDay_PREVIOUS = 1.0f;

    /// <summary>
    /// This variable lets us adjust the translucency of the leaves when views from the back (makes te leaves glow when the sun is shining through them)
    /// </summary>
    [HideInInspector]
    public float Translucency = 0.5f;
    [HideInInspector]
    public float Translucency_PREVIOUS = 0.5f;

    /// <summary>
    /// This variable lets us adjust the sharpness of the shadows when using Simple Shadows mode.
    /// </summary>
    [HideInInspector]
    public float TranslucencySharpen = 0f;
    [HideInInspector]
    public float TranslucencySharpen_PREVIOUS = 0f;

    /// <summary>
    /// This variable lets us adjust the darkness of the shadows when using Simple Shadows mode.
    /// </summary>
    [HideInInspector]
    public float ShadowClip = 1f;
    [HideInInspector]
    public float ShadowClip_PREVIOUS = 1f;

    /// <summary>
    /// This variable lets us adjust the amount of ambient occlusion in the leaves.
    /// </summary>
    [HideInInspector]
    public float AmbientOcclusion = 1f;
    [HideInInspector]
    public float AmbientOcclusion_PREVIOUS = 1f;

    /// <summary>
    /// This variable lets us add to the maximum shadow strength when usig Simple Shadows mode.
    /// </summary>
    [HideInInspector]
    public float ShadowSize = 0f;
    [HideInInspector]
    public float ShadowSize_PREVIOUS = 0f;

    /// <summary>
    /// This is the default lod distance for trees. This is used during the conversion process (used by _LusHLODTreeConverter.cs)
    /// If you would like newly created LushLODTrees to default to some other lod distance, you can change this value here.
    /// NOTE: The default lod distance is 250.
    /// </summary>
    public static float DefaultLodDistance = 250f;

    /// <summary>
    /// This variable keeps track of the average scale of the LushLOD Trees in the scene. When you recalculate parents, the scale of all the
    /// trees in the scene will be checked again, and this variable will be updated. Therefore, it is necessary to recalculate parents anytime
    /// you adjust the scale of the trees in your scene. This average scale variable will affect the LOD distances, and also will affect the
    /// distance at which trees will be parented with each other. When the trees in your scene are scaled down to a smaller size, for example,
    /// their LOD distances will also be scaled down, and the distance at which they will be parented together with each other will likewise be
    /// scaled down, using this variable.
    /// </summary>
    [HideInInspector]
    public float AverageTreeScale = 1.0f;


    private static Light PreviousLight = null;

    /// <summary>
    /// This bool can be used to enable or disable Unity's builtin Undo system for the manager. Disabling undo can help to improve the manager's speed when working with a large number of trees,
    /// since the manager will no longer need to write undo information to the undo stack. This option has no affect whatsoever on performance when the game is running, it only affects the
    /// speed of the manager when working in the Unity editor.
    /// </summary>
    [HideInInspector]
    public bool EnableUndo = true;
    
    /// <summary>
    /// This is a list of all the parent trees. Parent trees are the only trees that measure their distance to the camera.
    /// </summary>
    [HideInInspector]
    public List<_LushLODTree> AllParents;

    /// <summary>
    /// This is the root gameobject that holds all the trees.
    /// </summary>
    public GameObject TreesRoot;
    private bool PrentsRootNotSet = true;

    [HideInInspector]
    public _LushLODTree FirstTreeFound;

    /// <summary>
    /// These are the possible quality levels for the billboards, ranging from Ultra to Low quality.
    /// </summary>
    [System.Serializable]
    public enum BillboardQualitySettings
    {
        Low,
        Medium,
        Great,
        Ultra
    }

    /// <summary>
    /// This enum is used by the drop-down box in the inspector, to select whether or not billboards will be displayed, or high quality models only, or both.
    /// </summary>
    [System.Serializable]
    public enum BillBoardSettings
    {
        UseBoth,
        BillboardsOnly,
        HighQualityModelsOnly
    }

    /// <summary>
    /// This enum is used by the drop-down box in the inspector, to select the quality level of shadows received by the high quality trees.
    /// </summary>
    [System.Serializable]
    public enum ShadowReceiveSettings
    {
        AllShadows,
        SimpleShadows,
        NoShadows
    }

    /// <summary>
    /// This enum is used by the drop-down box in the inspector, to select whether or not to display no shadows or Billboard shadows.
    /// This is the shadow casting settings.
    /// </summary>
    [System.Serializable]
    public enum RealTimeShadowSettings
    {
        UseBoth,
        BillboardOnly,
        RealtimeShadowsOff
    }

    /// <summary>
    /// This enum is used by the drop-down box in the inspector, to select the type of rendering mode that the user is using.
    /// </summary>
    [System.Serializable]
    public enum RenderingModes
    {
        Forward,
        Deferred
    }

    /// <summary>
    /// This bool saves if we are currently in shadow baking mode or not. Setting this to "true" will not turn on shadow baking mode. Rather, when we DO turn on shadow baking mode (using the button in the GUI), then we set this to true so that the GUI will remember that we are in shadow baking mode, and so that it will then provide us with a button to turn shadow baking mode off.
    /// </summary>
    [HideInInspector]
    public bool ShadowBakingReady = false;

    /// <summary>
    /// This enum is used by the drop-down box in the inspector, to select whether or not to display no shadows or Billboard shadows.
    /// This is the shadow casting settings.
    /// </summary>
    [HideInInspector]
    public RealTimeShadowSettings RealTimeShadowSetting;
    /// <summary>
    /// This variable contains the value on the previous frame. Used to detect if we changed the value.
    /// </summary>
    [HideInInspector]
    public RealTimeShadowSettings RealTimeShadowSetting_PREVIOUS;


    /// <summary>
    /// This enum is used by the drop-down box in the inspector, to select the type of rendering mode that the user is using.
    /// </summary>
    [HideInInspector]
    public RenderingModes RenderingMode;
    /// <summary>
    /// This variable contains the value on the previous frame. Used to detect if we changed the value.
    /// </summary>
    [HideInInspector]
    public RenderingModes RenderingMode_PREVIOUS;

    /// <summary>
    /// This enum is used by the drop-down box in the inspector, to select whether or not billboards will be displayed, or high quality models only, or both.
    /// </summary>
    [HideInInspector]
    public BillBoardSettings BillBoardSetting;
    /// <summary>
    /// This variable contains the value on the previous frame. Used to detect if we changed the value.
    /// </summary>
    [HideInInspector]
    public BillBoardSettings BillBoardSetting_PREVIOUS;

    /// <summary>
    /// This enum is used by the drop-down box in the inspector, to select whether or not billboards will be displayed, or high quality models only, or both.
    /// </summary>
    [HideInInspector]
    public ShadowReceiveSettings ShadowReceiveSetting;
    /// <summary>
    /// This variable contains the value on the previous frame. Used to detect if we changed the value.
    /// </summary>
    [HideInInspector]
    public ShadowReceiveSettings ShadowReceiveSetting_PREVIOUS;

    /// <summary>
    /// This is the color of the Ambient Light.
    /// </summary>
    [HideInInspector]
    public Color ambientColor = Color.clear;

    /// <summary>
    /// This variable contains the value on the previous frame. Used to detect if we changed the value.
    /// </summary>
    [HideInInspector]
    public Color ambientColor_PREVIOUS = Color.clear;

    /// <summary>
    /// This is the color to add or remove from the high quality trees. If any of the color values are above 0.5, then color will be added. If any are below 0.5, then that amount will be subtracted. So, for example, setting this to {0.5f, 0.5f, 0.5f, 0.5f} will change nothing, since all 4 color values are exactly 0.5. But setting it to {0f, 0.5f, 0.5f, 0.5f} will remove half the value of the RED color from the high quality trees.
    /// </summary>
    [HideInInspector]
    public Color maincolor_HQTrees = new Color(0.5f, 0.5f, 0.5f, 0.5f);
    /// <summary>
    /// This is the color to add or remove from the low quality trees. If any of the color values are above 0.5, then color will be added. If any are below 0.5, then that amount will be subtracted. So, for example, setting this to {0.5f, 0.5f, 0.5f, 0.5f} will change nothing, since all 4 color values are exactly 0.5. But setting it to {0f, 0.5f, 0.5f, 0.5f} will remove half the value of the RED color from the low quality trees.
    /// </summary>
    [HideInInspector]
    public Color maincolor_LQTrees = new Color(0.5f, 0.5f, 0.5f, 0.5f);
    /// <summary>
    /// This variable contains the value on the previous frame. Used to detect if we changed the value.
    /// </summary>
    [HideInInspector]
    public Color maincolor_LQTrees_PREVIOUS = new Color(0.5f, 0.5f, 0.5f, 0.5f);
    /// <summary>
    /// This variable contains the value on the previous frame. Used to detect if we changed the value.
    /// </summary>
    [HideInInspector]
    public Color maincolor_HQTrees_PREVIOUS = new Color(0.5f, 0.5f, 0.5f, 0.5f);

    /// <summary>
    /// This variable contains the original color of the low quality (billboard) material. This should never be changed.
    /// </summary>
    [HideInInspector]
    public readonly Color maincolor_LQTrees_ORIGINAL = new Color(0.5f, 0.5f, 0.5f, 1f);

    /// <summary>
    /// This float controls the distance for the transition where the high quality trees transition into the billboard models. Setting this to a higher value will make the trees transition at a further distance. Setting it to a lower value will make them transition more close to the camera.
    /// </summary>
    [HideInInspector]
    public float LOD_adjust = _LushLODTreesManager.DefaultLodDistance;
    /// <summary>
    /// This variable contains the value on the previous frame. Used to detect if we changed the value.
    /// </summary>
    [HideInInspector]
    public float LOD_adjust_PREVIOUS = _LushLODTreesManager.DefaultLodDistance;
    /// <summary>
    /// This float contains the value used by the slider bar that controls which billboard shader we are using. 
    /// It can be one of 4 values, including Low, Medium, Great and Ultra. The default value is Great.
    /// </summary>
    [HideInInspector]
    public BillboardQualitySettings billboard_quality = BillboardQualitySettings.Great;
    /// <summary>
    /// This variable contains the value on the previous frame. Used to detect if we changed the value.
    /// </summary>
    [HideInInspector]
    public BillboardQualitySettings billboard_quality_PREVIOUS = BillboardQualitySettings.Great;
        
    /// <summary>
    /// This variable is set to True whenever the user clicks on the Reset Colors button, to force the colors to be reset even
    /// if the manager doesn't have any reason to believe that the colors need to be reset...
    /// </summary>
    [HideInInspector]
    public bool DoColorReset = false;

    [HideInInspector]
    public bool should_recalculate_parents = false;

    /// <summary>
    /// A float that saves where the 50% transition point is.
    /// </summary>
    [HideInInspector]
    public float halfsqrTransition;

    /// <summary>
    /// Copied from builtin_shaders-5.4.1f1\Editor\StandardShaderGUI.cs
    /// This needs to be kept update-to-date. If they make any changes to the standard shader,
    /// this will need to be updated accordingly.
    /// </summary>
    [HideInInspector]
    [System.Serializable]
    enum BlendMode
    {
        Opaque,
        Cutout,
        Fade, 
        Transparent
    }

    /// <summary>
    /// This class is used to store some values from the manager before we turn shadow baking mode on.
    /// Then, when we turn shadow baking mode off, we can read from these values in order to 
    /// put the settings back the way they were before.
    /// </summary>
    [System.Serializable]
    public class Settings_BeforeBake
    {
        /// <summary>
        /// This variable contains the value prior to entering shadow baking mode. Used to detect if we changed the value.
        /// </summary>
        [HideInInspector]
        public BillboardQualitySettings billboard_quality_BEFOREBAKE = BillboardQualitySettings.Great;
        /// <summary>
        /// This variable contains the value prior to entering shadow baking mode. Used to detect if we changed the value.
        /// </summary>
        [HideInInspector]
        public BillBoardSettings BillBoardSetting_BEFOREBAKE = BillBoardSettings.UseBoth;
        /// <summary>
        /// This variable contains the value prior to entering shadow baking mode. Used to detect if we changed the value.
        /// </summary>
        [HideInInspector]
        public Material AtlasMaterial;

        [HideInInspector]
        public bool LOD0_isStatic = false;
        [HideInInspector]
        public bool LOD1_isStatic = false;
        [HideInInspector]
        public bool Tree_isStatic = false;

        [HideInInspector]
        public UnityEngine.Rendering.ShadowCastingMode LOD1_shadowCastingMode = UnityEngine.Rendering.ShadowCastingMode.TwoSided;
        [HideInInspector]
        public bool LOD1_receiveShadows = false;
        [HideInInspector]
        public bool LOD1_enabled = true;
        [HideInInspector]
        public MaterialGlobalIlluminationFlags LOD1_globalIlluminationFlags = MaterialGlobalIlluminationFlags.None;
    }

    [HideInInspector]
    public Settings_BeforeBake BeforeBakeSettings;

    /// <summary>
    /// Holds a reference to the main directional light for the scene. This is required if the directional lights in the scene have been baked.
    /// </summary>
    [HideInInspector]
    public Light MainDirectionalLight;
    private Color PreviousLightColor = Color.black;
    private float PreviousLightIntensity = -1;
    private Vector3 PreviousLightDir = new Vector4(-1f, -1f, -1f);

    /// <summary>
    /// 0 means this value hasn't been set. 1 means false. 2 means true.
    /// </summary>
    [HideInInspector]
    public int UsingLinearColor = 0;


    private System.DateTime nowee;


    /// <summary>
    /// This function returns true if we are currently using the Ultra quality setting.
    /// </summary>
    /// <returns></returns>
    /// <param name="UsePrevious">Use previous is good in some cases as it ensures that this function won't use a setting that the user may have selected in the drop-down box
    /// in the manager, but which the user has not yet clicked the ApplyAll button. However, if the user has clicked the ApplyAll button, it's most likely best to NOT use the
    /// previous value as that may not match the setting that is about to be applied.</param>
    /// <returns></returns>
    public bool UsingUltraShader(bool UsePrevious)
    {
        BillboardQualitySettings SettingsToCheck = UsePrevious ? billboard_quality_PREVIOUS : billboard_quality;
        if (SettingsToCheck == BillboardQualitySettings.Ultra)
            return true;
        else
            return false;
    }

    /// <summary>
    /// Returns true if the supplied tree is using either a fast leaves or fast bark shader. Returns false if neither of shaders are fast.
    /// </summary>
    /// <param name="FirstTree">Tree to check</param>
    public bool UsingFastShader(_LushLODTree FirstTree)
    {
        if (FirstTree == null ||
            ReferenceEquals(FirstTree, null) == true ||
            FirstTree.Equals(null))
        {
            return false;
        }
        else 
            return FirstTree.UsingFastLeavesShader || FirstTree.UsingFastBarkShader ? true : false;
    }

    /// <summary>
    /// Loops through all LushLOD trees and tries to find one that is using the fast leaves or bark shaders. Returns the first such tree found, otherwise returns null.
    /// </summary>
    public _LushLODTree FindTreeUsingFastShader(GameObject TreeRootToSearch = null)
    {

        //Get a list of all the trees in the scene. They should all be children of the TreesRoot gameobject:
        _LushLODTree[] allTrees = TreeRootToSearch.GetComponentsInChildren<_LushLODTree>();
             
        if (allTrees.Length == 0)
        {
            return null;
        }

        foreach (_LushLODTree FirstTree in allTrees)
        {
            if (FirstTree.UsingFastLeavesShader || FirstTree.UsingFastBarkShader)
            {
                return FirstTree;
            }
        }

        return null; //<-- couldn't find a tree using the fast shaders.
    }

    /// <summary>
    /// This function returns the current shadow casting mode for the billboards. 
    /// </summary>
    /// <param name="UsePrevious">Use previous is good in some cases as it ensures that this function won't use a setting that the user may have selected in the drop-down box
    /// in the manager, but which the user has not yet clicked the ApplyAll button. However, if the user has clicked the ApplyAll button, it's most likely best to NOT use the
    /// previous value as that may not match the setting that is about to be applied.</param>
    /// <returns></returns>
    public UnityEngine.Rendering.ShadowCastingMode GetBillboardShadowCastingMode(bool UsePrevious)
    {
        UnityEngine.Rendering.ShadowCastingMode returningMode = UnityEngine.Rendering.ShadowCastingMode.TwoSided;
        RealTimeShadowSettings SettingsToCheck = UsePrevious ? RealTimeShadowSetting_PREVIOUS : RealTimeShadowSetting;
        switch (SettingsToCheck) //<-- use PREVIOUS
        {
            case RealTimeShadowSettings.UseBoth:
                returningMode = UnityEngine.Rendering.ShadowCastingMode.TwoSided;
                break;
            case RealTimeShadowSettings.BillboardOnly:
                returningMode = UnityEngine.Rendering.ShadowCastingMode.TwoSided;
                break;
            case RealTimeShadowSettings.RealtimeShadowsOff:
                returningMode = UnityEngine.Rendering.ShadowCastingMode.Off;
                break;
        }
        return returningMode;
    }

    /// <summary>
    /// This function returns the current shadow casting mode for the high quality tree models. 
    /// </summary>
    /// <param name="UsePrevious">Use previous is good in some cases as it ensures that this function won't use a setting that the user may have selected in the drop-down box
    /// in the manager, but which the user has not yet clicked the ApplyAll button. However, if the user has clicked the ApplyAll button, it's most likely best to NOT use the
    /// previous value as that may not match the setting that is about to be applied.</param>
    /// <returns></returns>
    public UnityEngine.Rendering.ShadowCastingMode GetHighQualityShadowCastingMode(bool UsePrevious)
    {
        UnityEngine.Rendering.ShadowCastingMode returningMode = UnityEngine.Rendering.ShadowCastingMode.TwoSided;
        RealTimeShadowSettings SettingsToCheck = UsePrevious ? RealTimeShadowSetting_PREVIOUS : RealTimeShadowSetting;
        switch (SettingsToCheck) //<-- use PREVIOUS
        {
            case RealTimeShadowSettings.UseBoth:
                returningMode = UnityEngine.Rendering.ShadowCastingMode.On;
                break;
            case RealTimeShadowSettings.BillboardOnly:
                returningMode = UnityEngine.Rendering.ShadowCastingMode.Off;
                break;
            case RealTimeShadowSettings.RealtimeShadowsOff:
                returningMode = UnityEngine.Rendering.ShadowCastingMode.Off;
                break;
        }
        return returningMode;
    }
    
    public void OnDestroyParentS()
    {
        should_recalculate_parents = true;
    }

    public void OnDestroyParent()
    {
        CancelInvoke("OnDestroyParent");
#if UNITY_EDITOR
        if (Application.isPlaying == false)
        UnityEngine.Debug.LogWarning("LushLOD Trees: Parents being recalculated because you deleted a tree from the scene.");
#endif
        ReCalculateParents(false); //<-- false == we don't do automatic recalculation of parents during gameplay.
    }

    /// <summary>
    /// Calculates halfway point in the transition. Used for shadow transitions.
    /// </summary>
    /// <param name="UsePrevious">Use previous is good in some cases as it ensures that this function won't use a setting that the user may have selected in the drop-down box
    /// in the manager, but which the user has not yet clicked the ApplyAll button. However, if the user has clicked the ApplyAll button, it's most likely best to NOT use the
    /// previous value as that may not match the setting that is about to be applied.</param>
    /// <returns></returns>
    public void SetupHalfSrqTransition(bool UsePrevious)
    {
        float[] sqrTransition = CalculateLODDistances(LOD_adjust, UsePrevious, AverageTreeScale);
        if (_LushLODTree.TreesManager.UsingUltraShader(UsePrevious))
        {
            halfsqrTransition = Mathf.Lerp(sqrTransition[0], sqrTransition[3], 0.5f);
        }
        else
        {
            halfsqrTransition = sqrTransition[1];
        }
    }

    /// <summary>
    /// This variable saves the transition distance that was last calculated, so that we don't need to calculate it again:
    /// </summary>
    private static float[] sqrTransition_PREVIOUS;
    /// <summary>
    /// This variable saves the previous LOD distance that we last calculated, so that we don't calculate it again:
    /// </summary>
    private static float lodDistance_PREVIOUS = -9999f;
    /// <summary>
    /// This variable saves the previous tree scale that we last calculated, so that we don't calculate it again:
    /// </summary>
    private static float AverageTreeScale_PREVIOUS = -9999f;

    /// <summary>
    /// Calculates staggered LOD distances for each step in the transition process between billboards and high quality tree models.
    /// </summary>
    /// <param name="lodDistance">The bases of the LOD distance</param>
    /// <param name="UsePrevious">Use previous is good in some cases as it ensures that this function won't use a setting that the user may have selected in the drop-down box
    /// in the manager, but which the user has not yet clicked the ApplyAll button. However, if the user has clicked the ApplyAll button, it's most likely best to NOT use the
    /// previous value as that may not match the setting that is about to be applied.</param>
    /// <param name="AverageTreeScale">The average scale of the trees. This is saved in a variable in the manager after you recalculate parents.</param>
    /// <returns></returns>
    public static float[] CalculateLODDistances(float lodDistance, bool UsePrevious, float AverageTreeScale)
    {
        if (lodDistance == lodDistance_PREVIOUS && AverageTreeScale == AverageTreeScale_PREVIOUS)
        {
            //We already calculated this particular LOD distance, no need to claculate it again:
            return sqrTransition_PREVIOUS;
        }
        float[] sqrTransition = new float[5];
        float sqrDistance = lodDistance * lodDistance;//<-- this just calculates a distance. Could use Vector3.Distance() to probably do something similar.
        if (_LushLODTree.TreesManager.UsingUltraShader(UsePrevious))
        {
            //sqrTransition[0] //<-- When the camera is LESS THAN this, the HQ trees are fully opaque, and the LQ trees are fully invisible, and the LQ shadows are always transitioning.
            sqrTransition[0] = sqrDistance - 0.95f * sqrDistance; //<-- When the camera is further away than this, the HQ trees are fully opaque, and the LQ trees are transitioning.
            sqrTransition[1] = sqrDistance - 0.95f * sqrDistance; //<-- When the camera is further away than this, both the HQ and the LQ trees are transitioning.
            sqrTransition[2] = sqrDistance + 0.95f * sqrDistance; //<-- When the camera is further away than this, the HQ trees are transitioning, and the LQ trees are fully opaque.
            sqrTransition[3] = sqrDistance + 0.95f * sqrDistance; //<-- When the camera is further away than this, the HQ tree renderers are turned off, and the LQ trees are full opaque.
            sqrTransition[4] = sqrTransition[3] * 2.5f; //<--2.5x further than the [3] value, trees further than this will have their scripts turned off to improve framefrates.
        }
        else
        {
            //sqrTransition[0] //<-- When the camera is LESS THAN this, the HQ trees are fully opaque, and the LQ trees are fully invisible, and the LQ shadows are always transitioning.
            sqrTransition[0] = sqrDistance - 0.95f * sqrDistance; //<-- When the camera is further away than this, the HQ trees are fully opaque, and the LQ trees are transitioning.
            sqrTransition[1] = sqrDistance - 0f * sqrDistance; //<-- When the camera is further away than this, both the HQ and the LQ trees are transitioning.
            sqrTransition[2] = sqrDistance - 0f * sqrDistance; //<-- When the camera is further away than this, the HQ trees are transitioning, and the LQ trees are fully opaque.
            sqrTransition[3] = sqrDistance + 0.95f * sqrDistance; //<-- When the camera is further away than this, the HQ tree renderers are turned off, and the LQ trees are full opaque.
            sqrTransition[4] = sqrTransition[3] * 2.5f; //<--2.5x further than the [3] value, trees further than this will have their scripts turned off to improve framefrates.
        }
        sqrTransition[0] *= AverageTreeScale;
        sqrTransition[1] *= AverageTreeScale;
        sqrTransition[2] *= AverageTreeScale;
        sqrTransition[3] *= AverageTreeScale;
        sqrTransition[4] *= AverageTreeScale;

        sqrTransition_PREVIOUS = sqrTransition;
        lodDistance_PREVIOUS = lodDistance;
        AverageTreeScale_PREVIOUS = AverageTreeScale;

        return sqrTransition;
    }

    /// <summary>
    /// This function updates the trees in the scene to a new preview quality level. Works in editor mode only (while game is NOT running).
    /// </summary>
    /// <param name="SpecificTree">A reference to a specific tree you'd like to update. Set this value as null to update all trees.</param>
    /// <param name="AllowUndo">Set to false if you want to prevent this function from writing anything to the undo buffer.</param>
    /// <param name="AllowSettingUndoGroupName">Set to false if you want to prevent this function from setting the name of the undo group.
    /// Definitely set this to false if this function was called automatically by another function, and that other function should set the name
    /// of the undo group, rather than this one.</param>
    public void UpdateTreesPreview(_LushLODTree SpecificTree = null, bool AllowUndo = true, bool AllowSettingUndoGroupName = true)
    {
#if UNITY_EDITOR //<-- make sure we're in editor.
        if (!Application.isPlaying) //<-- make sure game isn't running.
        {
            if (TreesRoot == null ||
                ReferenceEquals(TreesRoot, null) ||
                TreesRoot.Equals(null))
            {
                UnityEngine.Debug.LogError("You must set up the TreesRoot first before you can UpdateTreesPreview()");
                return;
            }
            _LushLODTree[] allTrees = FindObjectsOfType<_LushLODTree>();

            if (EnableUndo == true && AllowUndo == true)
            {
                if (allTrees.Length > 0)
                {
                    string Desc = "";
                    switch (PreviewMode_PREVIOUS)
                    {
                        case previewMode.HighQuality:
                            Desc = "Set High Quality Preview Mode";
                            break;
                        case previewMode.Billboards:
                            Desc = "Set Billboard Preview Mode";
                            break;
                        case previewMode.None:
                            Desc = "Set None Preview Mode";
                            break;
                    }

                    Undo.RegisterCompleteObjectUndo(_LushLODTree.TreesManager.gameObject, Desc);
                    Undo.RecordObject(_LushLODTree.TreesManager, Desc);

                    Undo.RegisterFullObjectHierarchyUndo(TreesRoot, Desc);

                    if (SpecificTree == null)
                    {
                        foreach (_LushLODTree tree in allTrees)
                        {
                            Undo.RegisterCompleteObjectUndo(tree.lod0Rend.sharedMaterials, Desc);
                            Undo.RegisterCompleteObjectUndo(tree.lod1Rend.sharedMaterials, Desc);
                            Undo.RegisterCompleteObjectUndo(tree.lod0Rend, Desc);
                            Undo.RegisterCompleteObjectUndo(tree.lod1Rend, Desc);
                        }
                    }
                    else
                    {
                        Undo.RegisterCompleteObjectUndo(SpecificTree.lod0Rend.sharedMaterials, Desc);
                        Undo.RegisterCompleteObjectUndo(SpecificTree.lod1Rend.sharedMaterials, Desc);
                        Undo.RegisterCompleteObjectUndo(SpecificTree.lod0Rend, Desc);
                        Undo.RegisterCompleteObjectUndo(SpecificTree.lod1Rend, Desc);
                    }
                    if (AllowSettingUndoGroupName == true) Undo.SetCurrentGroupName(Desc);
                }
            }

            foreach (_LushLODTree tree in allTrees)
            {
                _LushLODTree ThisTree = tree;
                if (SpecificTree != null &&
                    ReferenceEquals(SpecificTree, null) != true)
                {
                    ThisTree = SpecificTree;
                }

                switch (PreviewMode_PREVIOUS)
                {
                    case previewMode.HighQuality:
                        if (GetBillboardShadowCastingMode(true) != UnityEngine.Rendering.ShadowCastingMode.Off)
                        {
                            ThisTree.lod1Rend.enabled = true;
                            ThisTree.lod1Rend.shadowCastingMode = UnityEngine.Rendering.ShadowCastingMode.ShadowsOnly;
                            ThisTree.lod0Rend.enabled = true;
                        }
                        else
                        {
                            ThisTree.lod1Rend.enabled = false;
                            ThisTree.lod1Rend.shadowCastingMode = UnityEngine.Rendering.ShadowCastingMode.Off;
                            ThisTree.lod0Rend.enabled = true;
                        }
                        break;
                    case previewMode.Billboards:
                        ThisTree.lod1Rend.enabled = true;
                        ThisTree.lod1Rend.sharedMaterial.SetFloat("_Transparency", 1f);
                        ThisTree.lod1Rend.shadowCastingMode = GetBillboardShadowCastingMode(true) != UnityEngine.Rendering.ShadowCastingMode.Off ? UnityEngine.Rendering.ShadowCastingMode.TwoSided : UnityEngine.Rendering.ShadowCastingMode.Off;
                        ThisTree.lod0Rend.enabled = false;
                        break;
                    case previewMode.None:
                        ThisTree.lod1Rend.enabled = false;
                        ThisTree.lod0Rend.enabled = false;
                        break;
                }

                if (SpecificTree != null &&
                    ReferenceEquals(SpecificTree, null) != true)
                {
                    break;
                }
            }
        }
#endif
    }

    /// <summary>
    /// This is a helper function that will find all _LushLODTree's in the scene, and move them to the tree's root.
    /// Use this function if, for example, you spawned your trees with a tool such as Gaia, and you need to move
    /// all of the spawned trees to the tree's root gameobject so that they'll work with the LushLOD Trees manager.
    /// </summary>
    /// <param name="DisplayDialogs">Set this to false if you don't want a dialog box to appear telling the user how many trees were rooted (or not rooted).</param>
    public void RootAllTrees(bool DisplayDialogs = true)
    {
        if (TreesRoot == null ||
            ReferenceEquals(TreesRoot, null) ||
            TreesRoot.Equals(null))
        {
            UnityEngine.Debug.LogError("You must set up the TreesRoot first before you can RootAllTrees()");
            return;
        }
        _LushLODTree[] allTrees = FindObjectsOfType<_LushLODTree>();

        foreach (_LushLODTree tree in allTrees)
        {
#if UNITY_EDITOR
            if (Application.isPlaying == false && EnableUndo == true)
            {
                if (tree.transform.parent != TreesRoot.transform)
                {
                    Undo.SetTransformParent(tree.transform, TreesRoot.transform, "Root All Trees");
                }
            }
#endif 
            tree.transform.parent = TreesRoot.transform;
        }

        if (DisplayDialogs == true)
        {

            if (allTrees.Length == 0)
            {
#if UNITY_EDITOR
                EditorUtility.DisplayDialog("No trees found", "No _LushLODTree's were found in your scene. You should add some trees, and try again.", "Okay");
#endif
            }

#if UNITY_EDITOR
            EditorUtility.DisplayDialog("Moved Trees", "Found " + allTrees.Length + " _LushLODTrees in your scene, and moved them all to your TreeRoot gameobject. You should probably recalculate parents now.", "Okay");
#endif

        }
    }

    void OnDestroy()
    {
#if UNITY_EDITOR
        EditorUtility.ClearProgressBar();
#endif
    }

    /// <summary>
    /// This function will recalculate all the parents for all the trees. Eventually I will update this function to do a
    /// much better job of calculating the optimal location for parents, so that we can have fewer parents, and yet they'll
    /// accomplish the same thing, only faster. Parents are the only trees that measure their distance to the camera 
    /// continually. If a parent detects that the camera is getting close, then the parent will turn on all its children,
    /// and once they turn on, they will also begin measuring their distance to the camera. But if the parent detects the
    /// camera is far away, it'll turn off all its children, and they will stop measuring their distance to the camera.
    /// By turning them off, we save tuns of unnecessary calculations. This greatly reduces CPU usage and improves framerate.
    /// TODO: Improve the parents calculation algorythm, so it does a "much better job" when the game isn't running.
    /// </summary>    
    /// <param name="DuringGame">Set this to TRUE if you want to recalculate the parents EVEN IF the game is currently running.
    /// Otherwise, set this to false. Note, setting this variable to either true or false makes no difference if the game
    /// isn't running. Default: false.</param>
    /// <param name="AllowDialogs">Set this to false to prevent this function from displaying any dialog boxes.</param>
    public bool ReCalculateParents(bool DuringGame = false, bool AllowDialogs = true)
    {

        CancelInvoke("OnDestroyParent");
        should_recalculate_parents = false;
        
        if (TreesRoot == null || 
            ReferenceEquals(TreesRoot, null) ||
            TreesRoot.Equals(null))
        {
            UnityEngine.Debug.LogError("You must set up the TreesRoot first before you can ReCalculate Parents.");
            return false;
        }

        //Get a list of all the trees in the scene. They should all be children of the TreesRoot gameobject:
        _LushLODTree[] allTrees = TreesRoot.GetComponentsInChildren<_LushLODTree>();

        if (allTrees.Length == 0)
        {
#if UNITY_EDITOR
            if (AllowDialogs == true)
            {
                if (EditorUtility.DisplayDialog("No trees found", "No trees were found in your TreesRoot. Would you like to find all _LushLODTrees in your scene and move them to your TreesRoot?", "Yes please", "No thanks"))
                {
                    RootAllTrees();
                    return false;
                }
            }
#else
            UnityEngine.Debug.LogError("Cannot recalculate parents, because no trees were found in your TreesRoot. Please spawn some _LushLODTrees, or move your _LushLODTrees to your TreesRoot gameobject.");
#endif
            return false;
        }

#if UNITY_EDITOR

        if (Application.isPlaying == true && DuringGame == false)
        {
            //The game is running, and we didn't pass the variable to give this function
            //permission to recalculate parents during the game. So we will exit here.
            return false;
        }

        if (Application.isPlaying == false && EnableUndo == true)
        {
            string Desc = "ReCalculate Parents";
            Undo.RegisterCompleteObjectUndo(_LushLODTree.TreesManager.gameObject, Desc);
            Undo.RecordObject(_LushLODTree.TreesManager, Desc);
            Undo.RegisterFullObjectHierarchyUndo(TreesRoot, Desc);
            Undo.SetCurrentGroupName(Desc);
        }
#endif 

        _LushLODTree.TreesManager.FirstTreeFound = allTrees[0];
        
        //Calculate the average scale of all the trees in the scene.
        AverageTreeScale = 0f;
        foreach (_LushLODTree tree in allTrees)
        {
            float ThisTreeScale = ((tree.gameObject.transform.lossyScale.x +
                                    tree.gameObject.transform.lossyScale.y +
                                    tree.gameObject.transform.lossyScale.z) / 3f);
            AverageTreeScale += ThisTreeScale;
        }
        AverageTreeScale = AverageTreeScale / allTrees.Length; //<-- gets the average scale of all the trees.

        //Clear the variables that hold any information about the parents:
        _LushLODTree.TreesManager.AllParents = null;
        foreach (_LushLODTree tree in allTrees)
        {
            tree.MyChildren = new List<_LushLODTree>();
            tree.MyChildrenEnabled = true;
            tree.MyParent = null;
            tree.IsParent = false;
            tree.enabled = true;
            tree.lodDistance = this.LOD_adjust_PREVIOUS; //<-- make sure the trees all have the correct LOD distance.
        }

        //Loop through every tree, and rebuild the parents list:
        foreach (_LushLODTree tree in allTrees)
        {
            if (_LushLODTree.TreesManager.AllParents == null ||
                ReferenceEquals(_LushLODTree.TreesManager.AllParents, null) ||
                _LushLODTree.TreesManager.AllParents.Equals(null) ||
                _LushLODTree.TreesManager.AllParents.Count == 0)
            {
                //There aren't any parents at all yet, 
                //so make this tree to be the first parent:
                _LushLODTree.TreesManager.AllParents = new List<_LushLODTree>();
                _LushLODTree.TreesManager.AllParents.Add(tree);
                tree.MyChildren = new List<_LushLODTree>();
                tree.IsParent = true;
            }
            else
            {
                //We have some parents, 
                //so check this tree to see if it is close to any of those parents:

                float ClosestPDist = float.MaxValue; //<-- This will hold the distance between this tree and the nearest parent.
                _LushLODTree ClosestP = _LushLODTree.TreesManager.AllParents[0]; //<-- this will eventually hold the nearest parent.

                //Calculate the transition ranges:
                tree.sqrTransition = CalculateLODDistances(tree.lodDistance, true, AverageTreeScale);
                
                //Now we loop through every parent tree:
                foreach (_LushLODTree p in _LushLODTree.TreesManager.AllParents)
                {

                    if (p == null || 
                        ReferenceEquals(p, null) ||
                        p.Equals(null)) continue;

                    //Here we check the distance between the subject tree, and this parent:
                    float curDistance = (tree.gameObject.transform.position - p.gameObject.transform.position).sqrMagnitude;

                    //Check if this parent is closer than any other parent we previously found:
                    if (curDistance < ClosestPDist)
                    {
                        //Yes, this parent was closer than any other parent we previously found,
                        //so save this parent as the closest parent we've found so far:
                        ClosestPDist = curDistance; //<-- save the distance between the subject tree, and this parent.
                        ClosestP = p; //<-- save a reference to the parent.
                    }
                }

                //Now, check to see if our parent tree is very close to us:
                if (ClosestPDist < tree.sqrTransition[1]) //<- used to be: if (ClosestPDist < tree.sqrTransition.x)
                {
                    //we're close to this parent, so let's make it to be the parent of this tree:
                    tree.MyParent = ClosestP; //<-- set the subject tree's parent.
                    ClosestP.MyChildren.Add(tree); //<-- add the subject tree to this parent's list of children.
                    tree.IsParent = false; //<-- ensure that the subject tree is NOT a parent.
                }
                else
                {
                    //Every parent is too far from us. So we set the subject tree to be a parent then.
                    _LushLODTree.TreesManager.AllParents.Add(tree); //<-- add the subject tree to the global list of parents.
                    tree.MyChildren = new List<_LushLODTree>(); //<-- initiate its list of children. Note: it doesn't have any children yet. But other trees will now be able to add themselves to it's list of children later.
                    tree.IsParent = true; //<-- this tree is now a parent, ready to receive children.
                }
            }

#if UNITY_EDITOR

            if (Application.isPlaying != true)
            {
                PrefabType checkme = PrefabUtility.GetPrefabType(tree.gameObject);
                if (checkme.ToString() == "PrefabInstance")
                {
                    PrefabUtility.DisconnectPrefabInstance(tree.gameObject);
                }
            }

            EditorUtility.SetDirty(tree);
#endif
        }
        return true;
    }

#if UNITY_EDITOR
    /// <summary>
    /// This function turns on or off shadow baking mode.
    /// </summary>
    /// <param name="rdy">Set this to true to turn on shadow baking mode. False to turn shadow baking mode off.</param>
    public void ShadowBaking(bool rdy)
    {

        //Make sure they've got the TreesRoot gameobject reference established:
        if (_LushLODTree.TreesManager.TreesRoot == null || _LushLODTree.TreesManager.TreesRoot.Equals(null))
        {
            EditorUtility.DisplayDialog("No TreesRoot", "You must set up the TreesRoot first, before you can make any changes to your shadow baking mode.", "Okay");
            UnityEngine.Debug.LogError("You must set up the TreesRoot first.");
            return;
        }

        //Make sure they have calculated parents:
        if (ReferenceEquals(_LushLODTree.TreesManager.AllParents, null) || _LushLODTree.TreesManager.AllParents.Count == 0)
        {
            EditorUtility.DisplayDialog("No parents found", "You must set up the Parents first, before you can make any changes to your shadow baking mode.", "Okay");
            UnityEngine.Debug.LogError("You must set up the Parents first.");
            return;
        }

        //Make sure there are trees:
        _LushLODTree[] allTrees = _LushLODTree.TreesManager.TreesRoot.GetComponentsInChildren<_LushLODTree>();

#if UNITY_EDITOR
        if (Application.isPlaying == false && EnableUndo == true)
        {
            if (allTrees.Length > 0)
            {
                string Desc = "Shadow Baking ";
                if (rdy == true)
                    Desc += "On";
                else
                    Desc += "Off";


                Undo.RegisterCompleteObjectUndo(_LushLODTree.TreesManager.gameObject, Desc);
                Undo.RecordObject(_LushLODTree.TreesManager, Desc);

                Undo.RegisterFullObjectHierarchyUndo(TreesRoot, Desc);

                foreach (_LushLODTree tree in allTrees)
                {
                    Undo.RegisterCompleteObjectUndo(tree.lod0Rend.sharedMaterials, Desc);
                    Undo.RegisterCompleteObjectUndo(tree.lod1Rend.sharedMaterials, Desc);
                }

                Undo.SetCurrentGroupName(Desc);
            }
        }
#endif 

        if (allTrees == null || allTrees.Equals(null) || ReferenceEquals(allTrees, null) || allTrees.Length == 0)
        {
            EditorUtility.DisplayDialog("No Trees Found", "Couldn't find any trees in your scene. Please add some _LushLODTrees to your scene.", "Okay");
            UnityEngine.Debug.LogError("Couldn't find any trees in your scene.");
            return;
        }

        if (Application.isPlaying)
        {
            EditorUtility.DisplayDialog("Currently in game", "You are currently in game. Please exit the game before you make any changes to your shadow baking mode.", "Okay");
            UnityEngine.Debug.LogError("Currently in game, can't edit shadow baking mode.");
        }

        if (BeforeBakeSettings == null ||
            ReferenceEquals(BeforeBakeSettings, null) ||
            BeforeBakeSettings.Equals(null))
        {
            BeforeBakeSettings = new Settings_BeforeBake();
        }

        if (rdy)
        {

            //turn on ShadowBaking mode.
            //This mode is still being beta tested, to find the options that work best with Unity's Baking GI.

            //Save all the settings we are about to mess with, so that we can put them all back afterwards:
            BeforeBakeSettings.BillBoardSetting_BEFOREBAKE = BillBoardSetting_PREVIOUS;
            BeforeBakeSettings.billboard_quality_BEFOREBAKE = billboard_quality_PREVIOUS;
            BeforeBakeSettings.LOD0_isStatic = allTrees[0].lod0Rend.gameObject.isStatic;
            BeforeBakeSettings.LOD1_isStatic = allTrees[0].lod1Rend.gameObject.isStatic;
            BeforeBakeSettings.Tree_isStatic = allTrees[0].gameObject.isStatic;
            BeforeBakeSettings.LOD1_shadowCastingMode = allTrees[0].lod1Rend.shadowCastingMode;
            BeforeBakeSettings.LOD1_receiveShadows = allTrees[0].lod1Rend.receiveShadows;
            BeforeBakeSettings.LOD1_enabled = allTrees[0].lod1Rend.enabled;
            BeforeBakeSettings.LOD1_globalIlluminationFlags = allTrees[0].lod1Rend.sharedMaterial.globalIlluminationFlags;
            BeforeBakeSettings.AtlasMaterial = allTrees[0].lod1Rend.sharedMaterial;

            //1) It'll set the trees to billboard only.
            BillBoardSetting = BillBoardSettings.BillboardsOnly;
            billboard_quality = BillboardQualitySettings.Low;
            _LushLODTree.TreesManager.ApplyAll(null, true); //<-- force full update, to ensure all trees are set to loq quality billboard mode.

            //2) It'll set the tree's to standard(baked & alphaclip) shader.
            //3) It'll set the tree's to static.
            
            //We'll use the full oaque, geometry shader for the billboards:
            Material StandardShaderMaterial_Tmp = new Material(Shader.Find("Standard"));
            StandardShaderMaterial_Tmp.globalIlluminationFlags = MaterialGlobalIlluminationFlags.EmissiveIsBlack;
            StandardShaderMaterial_Tmp.SetFloat("_Cutoff", BeforeBakeSettings.AtlasMaterial.GetFloat("_Cutoff"));
            StandardShaderMaterial_Tmp.SetTexture("_MainTex", BeforeBakeSettings.AtlasMaterial.GetTexture("_MainTex"));
            StandardShaderMaterial_Tmp.SetFloat("_Glossiness", 0f);

            //Set the standard shader to render in alpha clip queue.
            // Copied from builtin_shaders-5.4.1f1\Editor\StandardShaderGUI.cs -> SetupMaterialWithBlendMode()
            // This needs to be kept update-to-date. If they make any changes to the standard shader,
            // this will need to be updated accordingly.
            StandardShaderMaterial_Tmp.SetFloat("_Mode", (float)BlendMode.Cutout);
            StandardShaderMaterial_Tmp.SetOverrideTag("RenderType", "TransparentCutout");
            StandardShaderMaterial_Tmp.SetInt("_SrcBlend", (int)UnityEngine.Rendering.BlendMode.One);
            StandardShaderMaterial_Tmp.SetInt("_DstBlend", (int)UnityEngine.Rendering.BlendMode.Zero);
            StandardShaderMaterial_Tmp.SetInt("_ZWrite", 1);
            StandardShaderMaterial_Tmp.EnableKeyword("_ALPHATEST_ON");
            StandardShaderMaterial_Tmp.DisableKeyword("_ALPHABLEND_ON");
            StandardShaderMaterial_Tmp.DisableKeyword("_ALPHAPREMULTIPLY_ON");
            StandardShaderMaterial_Tmp.renderQueue = (int)UnityEngine.Rendering.RenderQueue.AlphaTest;
            StandardShaderMaterial_Tmp.name = "_LushLODShadowBakingMat";

            foreach (_LushLODTree tree in allTrees)
            {

                //Turn on the billboard trees, set them to double-sided shadows, set them to static, etc etc:
                tree.lod1Rend.shadowCastingMode = UnityEngine.Rendering.ShadowCastingMode.TwoSided;
                tree.lod1Rend.receiveShadows = false;
                tree.lod1Rend.enabled = true;
                tree.lod1Rend.sharedMaterial = StandardShaderMaterial_Tmp;
                tree.ShadowBakingReady = true;

                tree.lod0Rend.gameObject.isStatic = false;
                tree.lod1Rend.gameObject.isStatic = true;
                tree.gameObject.isStatic = false;

                EditorUtility.SetDirty(tree);
            }
        }
        else
        {
            //turn off ShadowBaking mode
            //This just reverses everything we did above.

            foreach (_LushLODTree tree in allTrees)
            {
                //Turn on the billboard trees, set them to double-sided shadows, set them to static, etc etc:
                tree.lod1Rend.shadowCastingMode = BeforeBakeSettings.LOD1_shadowCastingMode;
                tree.lod1Rend.receiveShadows = BeforeBakeSettings.LOD1_receiveShadows;
                tree.lod1Rend.enabled = BeforeBakeSettings.LOD1_enabled;

                if (tree.lod1Rend.sharedMaterial != null &&
                    ReferenceEquals(tree.lod1Rend.sharedMaterial, null) == false &&
                    tree.lod1Rend.sharedMaterial.Equals(null) == false &&
                    tree.lod1Rend.sharedMaterial.name == "_LushLODShadowBakingMat")
                {
                    DestroyImmediate(tree.lod1Rend.sharedMaterial);
                }

                if (BeforeBakeSettings.AtlasMaterial != null ||
                    ReferenceEquals(BeforeBakeSettings, null) != true)
                {
                    tree.lod1Rend.sharedMaterial = BeforeBakeSettings.AtlasMaterial;
                }
                else
                {
                    tree.lod1Rend.sharedMaterial = tree.Material_NotInstance_FullyOpaque; //<-- this will be over-ridden in a moment.
                }
                tree.ShadowBakingReady = false;

                tree.lod0Rend.gameObject.isStatic = BeforeBakeSettings.LOD0_isStatic;
                tree.lod1Rend.gameObject.isStatic = BeforeBakeSettings.LOD1_isStatic;
                tree.gameObject.isStatic = BeforeBakeSettings.Tree_isStatic;

                EditorUtility.SetDirty(tree);
            }
                        
            BillBoardSetting = BeforeBakeSettings.BillBoardSetting_BEFOREBAKE;
            billboard_quality = BeforeBakeSettings.billboard_quality_BEFOREBAKE;
            _LushLODTree.TreesManager.ApplyAll(null, true); //<-- force full update
          

        }
    }
#endif



#if UNITY_EDITOR
    /// <summary>
    /// This function reverts all trees (or a specific tree) to its prefab. It does not affect the position, rotation or scale of the trees.
    /// If prefabPath is included, then the tree will reconnect to the prefab found at the specified path (only if it isn't already connected to a prefab).
    /// If upgradePrefab is set to true, then the SpecificTree will revert to the prefab found at the prefabPath, even if the SpecificTree is already connected to a prefab.
    /// </summary>
    /// <param name="SpecificTree">[Optional] Will revert ALL instances of this tree to its prefab, but will skip all other trees. If this variable is null, then all trees will be reverted to their prefabs (if they are connected to a prefab).</param>
    /// <param name="prefabPath">[Optional] The path to the SpecificTree's prefab. If no SpecificTree is specified, then this variable will do nothing.</param>
    /// <param name="upgradePrefab">[Optional] If set to true, then the SpecificTree will be upgraded to the prefab located at the specified prefabPath, even if the SpecificTree is already connected to a different prefab.</param>
    /// <returns>Returns TRUE if the RevertAll was completed successfully, otherwise returns false if nothing was reverted.</returns>
    public bool RevertAll(_LushLODTree SpecificTree = null, string prefabPath = null, bool upgradePrefab = false)
    {
        //Checks that we have set the TreesRoot.
        if (TreesRoot == null ||
            ReferenceEquals(TreesRoot, null) ||
            TreesRoot.Equals(null))
        {
            UnityEngine.Debug.LogError("You must set up the TreesRoot first before you can Revert or Upgrade prefabs.");
            return false;
        }

        if (UnityEditor.SceneManagement.EditorSceneManager.GetActiveScene().isDirty || UnityEditor.SceneManagement.EditorSceneManager.GetActiveScene().path == "")
        {
            EditorUtility.DisplayDialog("Unsaved Scenes", "Your currently active scene is unsaved. Please save your scene, and make a backup before you revert or upgrade your prefabs.", "Okay");
            return false;
        }

        if (UnityEditor.SceneManagement.EditorSceneManager.loadedSceneCount != 1)
        {
            EditorUtility.DisplayDialog("Unsupported", "You currently have more or less than exactly 1 scene open. Please ensure that you have exactly one scene open before you revert or upgrade your prefabs.", "Okay");
            return false;
        }

        //Checks that we have calculated parents at least once.
        if (_LushLODTree.TreesManager.AllParents == null ||
            ReferenceEquals(_LushLODTree.TreesManager.AllParents, null) ||
            _LushLODTree.TreesManager.AllParents.Equals(null) ||
            _LushLODTree.TreesManager.AllParents.Count == 0)
        {
            EditorUtility.DisplayDialog("Setup not completed", "You must set up the Parents first before you can revert or upgrade prefabs. Do this by clicking the Calculate Parents button on the _LushLODTreesManager.", "Okay");
            UnityEngine.Debug.LogError("You must set up the Parents first before you can revert or upgrade prefabs. Do this by clicking the Calculate Parents button on the _LushLODTreesManager.");
            return false;
        }

        string methoddesc = "";
        switch (upgradePrefab)
        {
            case true:
                if (SpecificTree == null ||
                    ReferenceEquals(SpecificTree, null) ||
                    SpecificTree.Equals(null))
                {
                    UnityEngine.Debug.LogError("LushLODTree called a function incorrectly.");
                    return false; //<-- this should not happen, ever. We specified that we wanted to upgrade the prefab, but we didn't specify a specifictree.
                }
                else
                {
                    methoddesc = "Are you sure you want to upgrade this tree to the selected prefab?";
                }
                break;
            case false:
                if (SpecificTree == null ||
                    ReferenceEquals(SpecificTree, null) ||
                    SpecificTree.Equals(null))
                {
                    methoddesc = "Are you sure you want to revert all LushLODTrees to their prefabs?";
                }
                else
                {
                    methoddesc = "Are you sure you want to revert this tree to its prefab?";
                }
                break;
        }


        if (!EditorUtility.DisplayDialog("Please confirm", methoddesc + " This process cannot be undone. Please make a backup copy of your scene before you do this.", "Yes -- I made a backup of my scene", "Cancel")) return false;
       
        //Gets a array of all trees in the scene.
        //Note: Don't use List<_LushLODTree>, because the upgrade process
        //Can delete trees, which could delete a tree that's in the list while
        //the list is still being processed, which will create errors:
        _LushLODTree[] allTrees = TreesRoot.GetComponentsInChildren<_LushLODTree>();

        //Ensures that we actually have some trees in the scene:
        if (allTrees == null ||
            ReferenceEquals(allTrees, null) ||
            allTrees.Equals(null) ||
            allTrees.Length == 0)
        {
            UnityEngine.Debug.LogError("Couldn't find any trees in your scene. Have you added trees? The number of _LushLODTree's found in all children of your TreesRoot gameobject was zero.");
            return false;
        }

        //Get the SpecificTree's prefab:
        Object SpecificTreePrefab = null;
        string SpecificTreeUniqueID = "";
        if (SpecificTree != null &&
            ReferenceEquals(SpecificTree, null) != true &&
            SpecificTree.Equals(null) != true)
        {
            SpecificTreePrefab = PrefabUtility.GetCorrespondingObjectFromSource(SpecificTree.gameObject);
            SpecificTreeUniqueID = SpecificTree.Original_UniqueID;
        }

        if (prefabPath != null && prefabPath != "")
        {
            //We've been supplied with a path to the new prefab file. Check that this prefab is a _LushLODTree
            UnityEngine.Object newPrefab = AssetDatabase.LoadAssetAtPath(prefabPath.Replace(Application.dataPath, "Assets"), (typeof(UnityEngine.Object))) as UnityEngine.Object;
            _LushLODTree checkTree = ((GameObject)newPrefab).GetComponent<_LushLODTree>();
            if (checkTree == null ||
                ReferenceEquals(checkTree, null) ||
                checkTree.Equals(null))
            {
                //The prefab they selected isn't a LushLODTree!
                EditorUtility.DisplayDialog("Prefabs missing", "The prefab you selected is not a LushLOD Tree. Please try again.", "Okay");
                return false;
            }
            else
            {
                if (SpecificTree.Original_TreeName.ToLower().Trim() != checkTree.Original_TreeName.ToLower().Trim())
                {
                    //Name of prefab files doesn't match, get confimation from user.
                    if (!EditorUtility.DisplayDialog("Please confirm", "The name of the tree in the prefab file you selected is \"" + checkTree.Original_TreeName + "\" which is different than the name of the tree you are applied the changes to, which is \"" + SpecificTree.Original_TreeName + "\" are you sure you selected the correct prefab?", "Yes - use this prefab", "Cancel"))
                    {
                        return false;
                    }
                }
            }
        }

        List<string> TreeNamesWithoutPrefabs = new List<string>(); //<-- this will contain names of trees that didn't have prefabs.
        List<GameObject> TreesWithoutPrefabs = new List<GameObject>();
        List<GameObject> SpecicTreesWithoutPrefabs = new List<GameObject>();

        GameObject SpecificTreeNewPrefab = null;

        if (prefabPath != null && prefabPath != "")
        {
            SpecificTreeNewPrefab = (GameObject)(AssetDatabase.LoadAssetAtPath(prefabPath.Replace(Application.dataPath, "Assets"), (typeof(UnityEngine.Object))) as UnityEngine.Object);
        }

        EditorUtility.ClearProgressBar();


        //Loop through all trees.
        //Don't use foreach, because trees can be deleted/replaced during this loop:
        for (int t = 0; t < allTrees.Length; t++) {

            //EditorUtility.DisplayProgressBar("Progress", "Modifying Prefabs", ((float)t / allTrees.Length));
            if (EditorUtility.DisplayCancelableProgressBar("Progress", "Modifying Prefabs", ((float)t / allTrees.Length)) == true)
            {
                EditorUtility.ClearProgressBar();
                if (!EditorUtility.DisplayDialog("Please confirm", "Cancel the prefab modification? Any changes which were already made will NOT be undone, and to undo the changes you may need to restore the backup of your scene that you (hopefully) made.", "NO - Don't Cancel", "Yes - Cancel"))
                {
                    EditorUtility.DisplayDialog("Canceled", "You have canceled the prefab modification while it was in progress. Your scene may be damaged. You should restore the backup of your scene that you (hopefully) made.", "Okay");
                    return false;
                }
            }

            _LushLODTree tree = allTrees[t];

            //Check to ensure that this tree has a prefab
            if ((SpecificTree == null ||
                ReferenceEquals(SpecificTree, null) ||
                SpecificTree.Equals(null)) 
                &&
                (prefabPath == null || prefabPath == ""))
            {
                //This code will only run if we are reverting ALL trees, and not a specific tree.
                if (PrefabUtility.GetPrefabType(tree.gameObject) == PrefabType.None)
                {
                    //This tree is totally not connected to a prefab. Unfortunantly, this can't be easily fixed.
                    //Report this to the user so they know about this problem.

                    if (TreeNamesWithoutPrefabs.Contains(tree.Original_TreeName) == false)
                    {
                        TreeNamesWithoutPrefabs.Add(tree.Original_TreeName);
                        TreesWithoutPrefabs.Add(tree.gameObject); //<-- contains a list of the gameobjects for the FIRST tree of each type found.
                    }
                    continue; //<-- skip this tree since it is missing its prefab, we can't do anything with it.
                }
            }

            //Check if we are modifying a specific tree.
            if (SpecificTree != null &&
                ReferenceEquals(SpecificTree, null) != true &&
                SpecificTree.Equals(null) != true)
            {
                //We are modifying a specific tree. Skip all other trees.

                if (PrefabUtility.GetPrefabType(tree.gameObject) == PrefabType.None || upgradePrefab == true)
                {
                    if (tree.Original_UniqueID == SpecificTreeUniqueID)
                    {
                        //This is most likely to be the same tree (could be a different instance, but the same original tree).
                        if (prefabPath != null && prefabPath != "" && SpecificTreeNewPrefab != null && ReferenceEquals(SpecificTreeNewPrefab, null) == false)
                        {
                            ////We've been supplied with a path to the new prefab file. We can now attempt to reconnect.
                            Vector3 treePos = tree.transform.localPosition;
                            Quaternion treeRot = tree.transform.localRotation;
                            Vector3 treeScale = tree.transform.localScale;
                            GameObject treeParent = tree.transform.parent.gameObject;

                            GameObject ThisTree = PrefabUtility.ConnectGameObjectToPrefab(tree.gameObject, SpecificTreeNewPrefab);

                            PrefabUtility.RevertPrefabInstance(ThisTree);
                            PrefabUtility.DisconnectPrefabInstance(ThisTree);

                            ThisTree.transform.localPosition = treePos;
                            ThisTree.transform.localRotation = treeRot;
                            ThisTree.transform.localScale = treeScale;
                            ThisTree.transform.parent = treeParent.transform;

                            _LushLODTree NewtreeScript = ThisTree.GetComponent<_LushLODTree>();

                            _LushLODTree.TreesManager.ApplyAll(NewtreeScript, false, true); //<-- calls the function in the _LustLODTreesManager.cs to apply all changes 
                                                                                            //that were made in the manager, but for THIS specific tree only.

                            //The above call to ApplyAll will put this tree into sync with the manager, so the tree is
                            //now finished being set up, so let's mark it as such:
                            NewtreeScript.TreeIsSetup = true;

                            #if UNITY_EDITOR
                                EditorUtility.SetDirty(NewtreeScript);
                            #endif

                            if (SpecificTree == null ||
                                ReferenceEquals(SpecificTree, null) ||
                                SpecificTree.Equals(null))
                            {
                                //Yep we just nulled our reference to the tree we're looking for.
                                //This will cause the remainder of this loop to break because it'll think we aren't looking for a specific tree.
                                SpecificTree = NewtreeScript; //<-- dummy reference, this isn't the correct tree (the tree we were looking for is GONE).
                                Selection.objects = new Object[] { NewtreeScript.gameObject }; //<-- select the new tre, since the selection was lost.
                            }
                        }
                        else
                        {
                            //We found an instance of this specific tree, and this instance that we found
                            //has no connection to its prefab, and we didn't supply a path to the prefab file,
                            //so this is a fatal error. Count this, so we can tell the user about this.
                            SpecicTreesWithoutPrefabs.Add(tree.gameObject);
                        }
                    }
                }
                else
                {
                    if (PrefabUtility.GetCorrespondingObjectFromSource(tree.gameObject) == SpecificTreePrefab)
                    {
                        //PrefabUtility.ReconnectToLastPrefab(tree.gameObject);
                        PrefabUtility.RevertPrefabInstance(tree.gameObject);
                        PrefabUtility.DisconnectPrefabInstance(tree.gameObject);

                        _LushLODTree.TreesManager.ApplyAll(tree, false, true); //<-- calls the function in the _LustLODTreesManager.cs to apply all changes 
                                                                               //    that were made in the manager, but for THIS specific tree only.
                    }
                }
            }
            else
            {
                //We are modifying all trees.
                if (PrefabUtility.GetPrefabType(tree.gameObject) != PrefabType.None)
                {
                    //PrefabUtility.ReconnectToLastPrefab(tree.gameObject);
                    PrefabUtility.RevertPrefabInstance(tree.gameObject);
                    PrefabUtility.DisconnectPrefabInstance(tree.gameObject);

                    tree.TreeIsSetup = true; //<-- prevent this tree from loading the settings from the manager onto itself.
                                             //    Because we actually want the reverse to happen. We want the manager to load the
                                             //    settings from the trees, since all trees are being reverted to their prefabs.

                    if (Application.isPlaying)
                        tree.RunStart(); //<-- for a call to the tree's Start() function to ensure it gets set up properly.
                }
            }
        }

        EditorUtility.ClearProgressBar();
        
        if (TreeNamesWithoutPrefabs.Count > 0)
        {
            if (EditorUtility.DisplayDialog("Prefabs missing", "A total of " + TreeNamesWithoutPrefabs.Count + " different types of trees have lost their connection to their prefabs, and cannot be reverted. To fix these trees, please select them in your scene and see what solutions are available in their _LushLODTree script. Would you like to select the first instance found of each of these types of trees in your hierarchy?", "Yes please", "No thanks"))
            {
                Selection.objects = TreesWithoutPrefabs.ToArray();
            }
        }

        if (SpecicTreesWithoutPrefabs.Count > 0)
        {
            if (EditorUtility.DisplayDialog("Prefabs missing", "A total of " + SpecicTreesWithoutPrefabs.Count + " trees of this same type were found which have lost their connection to their prefabs, and cannot be reverted. Would you like to select these trees in your hierarchy?", "Yes please", "No thanks"))
            {
                //Select the objects for the user to see.
                Selection.objects = SpecicTreesWithoutPrefabs.ToArray();
            }
        }

        _LushLODTree TreeUsingFastShader = FindTreeUsingFastShader(TreesRoot);
        if (TreeUsingFastShader != null &&
            ReferenceEquals(TreeUsingFastShader, null) == false &&
            (billboard_quality == BillboardQualitySettings.Ultra || billboard_quality_PREVIOUS == BillboardQualitySettings.Ultra) &&
            (!(BillBoardSetting == BillBoardSettings.BillboardsOnly && BillBoardSetting_PREVIOUS == BillBoardSettings.BillboardsOnly))) //<-- and if we are NOT using billboards only
        {
            billboard_quality = _LushLODTreesManager.BillboardQualitySettings.Great;
            EditorUtility.DisplayDialog("Not Supported Yet", "One of your trees named \"" + TreeUsingFastShader.Original_TreeName + "\" (instance \"" + TreeUsingFastShader.name + "\") has been upgraded or reverted, and it is now using the Fast shader. In this beta version, the Ultra quality level currently does not support the TreeCreatorLeavesFAST or TreeCreatorBarkFAST shaders. Only the non-fast shaders are supported. Expect this to be fixed soon. For now, if you wish to use Ultra quality, you must ensure that no parts of any of your Unity trees are using any of Unity's \"Fast\" Tree shaders. This needs to be done prior to converting your trees to LushLOD trees, and cannot be done after conversion. You can easily upgrade your scene to use the new trees after you re-convert them (All LushLOD trees in your scene have an upgrade button).", "Okay");
            _LushLODTree.TreesManager.ApplyAll(null, false, true); //<-- sets the billboard quality down to Great instead of Ultra.
            EditorUtility.DisplayDialog("Not Supported Yet", "The billboard quality level has automatically been lowered from Ultra to Great. Please check your _LushLODTreesManager (it's in your scene's hierarchy) to see this change.", "Okay");
        }

        //Probably should recalculate parents now.
        ReCalculateParents(true);

        TreeNamesWithoutPrefabs.Clear();
        TreesWithoutPrefabs.Clear();
        SpecicTreesWithoutPrefabs.Clear();
        TreeNamesWithoutPrefabs = null;
        TreesWithoutPrefabs = null;
        SpecicTreesWithoutPrefabs = null;

        UnityEditor.Selection.activeObject = null; //<-- to fix a console error
        nowee = System.DateTime.Now; //<-- to fix a console error
        EditorApplication.update += UpdateInEditor; //<-- to fix a console error

        return true; //<-- Revert was successful, I guess.

    }

    /// <summary>
    /// Used internally by the manager.
    /// </summary>
    void UpdateInEditor()
    {
        if ((System.DateTime.Now - nowee).TotalMilliseconds >= 100)
        {
            EditorApplication.update -= UpdateInEditor;  //<-- to fix a console error
            UnityEditor.SceneManagement.EditorSceneManager.MarkAllScenesDirty();
            UnityEditor.SceneManagement.EditorSceneManager.SaveOpenScenes(); //<-- save all open scenes.
            //Reload the scene. This clears the undo buffer, which ensures that the user doesn't attempt to undo anything that just happened:
            UnityEditor.SceneManagement.EditorSceneManager.OpenScene(UnityEditor.SceneManagement.EditorSceneManager.GetActiveScene().path, UnityEditor.SceneManagement.OpenSceneMode.Single);
        }
    }
#endif

    /// <summary>
    /// This function loops through every tree (or a specific tree), and applies any changes we made to the trees.
    /// This function is called whenever you click the "apply all" button in the _LushLODTreesManager window.
    /// You can also call this function fully from code. You can see an example of this by looking at LushLODTreesUI.cs.
    /// </summary>
    /// <param name="SpecificTree">Optional. Specifies that changes should only be made to a specific tree.
    /// This is useful if, for example, you add a new tree to the scene at runtime, and you want that new tree to
    /// be set to be updated to match whatever is your current settings that you've previously applied to all your
    /// other trees, but which hasn't yet been applied to the new tree you just added to the scene at runtime.</param>
    /// <param name="ForceFullUpdate">Set this to true to force this call to NOT check if settings were actually 
    /// changed, and to re-apply all settings found in the manage to all the _LushLODTree's in the scene. This is useful
    /// if you believe the trees have somehow gotten out-of-sync with the manager's settings, and you want to force
    /// a full update of the manager's settings to be applied to all the trees.</param>
    /// <param name="NoUndo">Set this to true if you wish to force this function to not be undoable. Useful if you are performing
    /// an operation that would hog a lot of space in the undo buffer, and the undo would take a long time to store.
    /// <param name="WasManagerButtonClick">Set this to true if this function was called by an actual click of the
    /// Apply All button in the manager. This changes not except that certain dialog error boxes may appear if it was an actual
    /// click by the user that called this function. Otherwise if this function was called automatically by a script, the dialog
    /// box should not appear and instead any errors will be displayed via a message in the console.</param>
    public void ApplyAll(_LushLODTree SpecificTree = null, bool ForceFullUpdate = false, bool NoUndo = false, bool WasManagerButtonClick = false)
    {

        _LushLODTree TreeUsingFastShader = FindTreeUsingFastShader(TreesRoot);
        if (TreeUsingFastShader != null &&
            ReferenceEquals(TreeUsingFastShader, null) == false &&
            billboard_quality == BillboardQualitySettings.Ultra &&
            BillBoardSetting != _LushLODTreesManager.BillBoardSettings.BillboardsOnly)
        {
            billboard_quality = BillboardQualitySettings.Great;
            if (WasManagerButtonClick)
            {
                string ErrorMsg923 = "You have a tree named \"" + TreeUsingFastShader.Original_TreeName + "\" (instance \"" + TreeUsingFastShader.name + "\") that is using one of the Fast shaders. In this beta version, the Ultra quality level currently does not support the TreeCreatorLeavesFAST or TreeCreatorBarkFAST shaders. Only the non-fast shaders are supported. Expect this to be fixed soon. For now, if you wish to use Ultra quality, you must ensure that no parts of any of your Unity trees are using any of Unity's \"Fast\" Tree shaders. This needs to be done prior to converting your trees to LushLOD trees, and cannot be done after conversion. You can easily upgrade your scene to use the new trees after you re-convert them (All LushLOD trees in your scene have an upgrade button).";
#if UNITY_EDITOR
                EditorUtility.DisplayDialog("Fast Shaders Issue", ErrorMsg923, "Okay");
#else
                UnityEngine.Debug.LogError(ErrorMsg923);
#endif
                return;
            }
            else
            {
                UnityEngine.Debug.LogError("You have a tree named \"" + TreeUsingFastShader.Original_TreeName + "\" (instance \"" + TreeUsingFastShader.name + "\") that is using one of the Fast shaders. In this beta version, the Ultra quality level currently does not support the TreeCreatorLeavesFAST or TreeCreatorBarkFAST shaders. Only the non-fast shaders are supported. Expect this to be fixed soon. For now, if you wish to use Ultra quality, you must ensure that no parts of any of your Unity trees are using any of Unity's \"Fast\" Tree shaders. This needs to be done prior to converting your trees to LushLOD trees, and cannot be done after conversion. You can easily upgrade your scene to use the new trees after you re-convert them (All LushLOD trees in your scene have an upgrade button).");
            }
        }


        bool UpdatingSpecificTreeONLY = false; //<-- this is only set to true if we are processing a SpecificTree. Normally, trees are only updated if we actually change a setting in the GUI. But when we process a SpecificTree, we want to bypass that check, and force a full update to the tree even if we didn't change any setting in the GUI. That's what this bool does.
        if (ReferenceEquals(SpecificTree, null) == false) UpdatingSpecificTreeONLY = true; //<-- bypass the checks. See comments above for details.

        //Checks that we havve set the TreesRoot.
        if (TreesRoot == null ||
            ReferenceEquals(TreesRoot, null) ||
            TreesRoot.Equals(null))
        {
            UnityEngine.Debug.LogError("You must set up the TreesRoot first before you can ApplyAll().");
            return;
        }

        //Checks that we have calculated parents at least once.
        if (_LushLODTree.TreesManager.AllParents == null ||
            ReferenceEquals(_LushLODTree.TreesManager.AllParents, null) ||
            _LushLODTree.TreesManager.AllParents.Equals(null) ||
            _LushLODTree.TreesManager.AllParents.Count == 0)
        {
            UnityEngine.Debug.LogError("You must set up the Parents first before you can ApplyAll(). Do this by clicking the Calculate Parents button.");
            return;
        }

        //Gets a list of all trees in the scene:
        _LushLODTree[] allTrees = TreesRoot.GetComponentsInChildren<_LushLODTree>();

#if UNITY_EDITOR

        //Check for damaged LushLOD Trees, and if found, provide user with some options to select the damaged trees.
        List<GameObject> DamagedTrees = new List<GameObject>();
        foreach (_LushLODTree tree in allTrees)
        {
            if (tree.lod0Rend == null || tree.lod1Rend == null)
            {
                DamagedTrees.Add(tree.gameObject);
            }
        }
        if (DamagedTrees.Count > 0)
        {
            if (WasManagerButtonClick == true)
            {
                if (EditorUtility.DisplayDialog("Damaged Trees Found!", "Some of the LushLOD Trees in your scene have been damaged, and are missing their LOD_0 or LOD_1 renderers. This most likely happened because you selected and deleted part of a tree, but not all of it. To resolve this error, you need to delete the leftover part of the tree(s), or undo the part of the tree(s) you deleted, so that they have their LOD_0 and LOD_1 GameObjects attached to them again. To see which trees are casuing this message to appear, I can automatically select them for you. Would you like to automatically select all the trees in the scene with this error?", "Yes", "No") == true)
                {
                    Selection.objects = DamagedTrees.ToArray();
                    EditorUtility.DisplayDialog("Damaged Trees Selected", DamagedTrees.Count.ToString() + " tree(s) has been selected. Please check the Hierarchy window to see them. These trees are damaged (possibly missing one or both of their LOD_0 or LOD_1 components), and should be deleted or fixed.", "Okay");
                }
                else
                {
                    EditorUtility.DisplayDialog("Damaged Trees Found!", "To avoid errors, your previous click of \"ApplyAll\" has been canceled and the trees have not been modified. Please correct the damaged trees, or click ApplyAll again to see these messages again.", "Okay");
                }
                return;
            }
            else
            {
                Debug.LogError("Damaged LushLOD Trees are in your scene! To avoid errors, the trees are not being updated by the _LushLODTreesManager. To fix this error, click the ApplyAll button in the _LushLODTreesManager.");
                return;
            }
        }

        if (Application.isPlaying == false && EnableUndo == true)
        {
            string Desc = "Apply All";
            if (NoUndo == false)
            {
                Undo.RegisterCompleteObjectUndo(_LushLODTree.TreesManager.gameObject, Desc);
                Undo.RecordObject(_LushLODTree.TreesManager, Desc);

                Undo.RegisterFullObjectHierarchyUndo(TreesRoot, Desc);

                foreach (_LushLODTree tree in allTrees)
                {
                    Undo.RegisterCompleteObjectUndo(tree.lod0Rend.sharedMaterials, Desc);
                    Undo.RegisterCompleteObjectUndo(tree.lod1Rend.sharedMaterials, Desc);
                }

                Undo.SetCurrentGroupName(Desc);
            }
        }
#endif

        //Ensures that we actually have some trees in the scene:
        if (allTrees == null ||
            ReferenceEquals(allTrees, null) ||
            allTrees.Equals(null) ||
            allTrees.Length == 0)
        {
            UnityEngine.Debug.LogError("Couldn't find any trees in your scene. Have you added trees? The number of _LushLODTree's found in all children of your TreesRoot gameobject was zero.");
            return;
        }

        _LushLODTree.TreesManager.FirstTreeFound = allTrees[0];


        //################ apply Color ####################:

        if (ambientColor != ambientColor_PREVIOUS)
        {
            if (!(UpdatingSpecificTreeONLY == true)) //<-- if we are NOT processing a specific tree, then:
            {
                ambientColor_PREVIOUS = ambientColor;
                Shader.SetGlobalColor("_LushLODTreeAmbientColor", ambientColor);
            }
        }

        if (maincolor_LQTrees != maincolor_LQTrees_PREVIOUS //<-- check if user is requesting to change the color of the billboards
            || maincolor_HQTrees != maincolor_HQTrees_PREVIOUS //<-- check if the user is requesting to change the color of the high quality trees.
            || UpdatingSpecificTreeONLY //<-- check if the user is updating a specific tree, in which case we always enter.
            || ForceFullUpdate //<-- forces us to enter all update areas, and do a full update.
            || DoColorReset)
        {

            DoColorReset = false; //<-- We're in. So this no longer needs to be true.

            if (!(UpdatingSpecificTreeONLY == true)) //<-- if we are NOT processing a specific tree, then:
            {
                //Now that we've finished applying the new color, save it to _PREVIOUS so that we'll remember this:
                maincolor_LQTrees_PREVIOUS = maincolor_LQTrees;
                maincolor_HQTrees_PREVIOUS = maincolor_HQTrees;
            }

            Color NewHQColorApply = maincolor_HQTrees; //<-- now get the new color that we want to apply to the high quality tree models.
            NewHQColorApply.r -= 0.5f; //<-- (Red) subtract 0.5 from each color value. This will give us a negative number if the value was below 0.5, and a positive number if the value was above 0.5.
            NewHQColorApply.g -= 0.5f; //<-- (Green)
            NewHQColorApply.b -= 0.5f; //<-- (Blue)
            NewHQColorApply.a -= 0.5f; //<-- (alpha)
            Color NewLQColorApply = maincolor_LQTrees; //<-- now get the new color that we want to apply to the billboard tree models.
            NewLQColorApply.r -= 0.5f; //<-- (Red) subtract 0.5 from each color value. This will give us a negative number if the value was below 0.5, and a positive number if the value was above 0.5.
            NewLQColorApply.g -= 0.5f; //<-- (Green)
            NewLQColorApply.b -= 0.5f; //<-- (Blue)
            NewLQColorApply.a -= 0.5f; //<-- (alpha)

            if (Application.isPlaying) //<-- check if the game is playing.
            {

                //The game is currently playing. This means we have instantiated some of the materials. Instantiated materials are
                //only temporarily held in the memory, and are lost when the game ends. This is why changes made while the game
                //is running are not permanent.

                //So, since the game is running, we need to modify the color of the _static variable.
                //Hover your mouse over these variables to get more information about them:
                _LushLODTree.Material_FullyOpaque_References.SetColor(
                                        maincolor_LQTrees_ORIGINAL //<-- the original color of the billboards.
                                        + NewLQColorApply); //<-- add the new color adjustment that we now want to make.

                //Loop through every tree
                foreach (_LushLODTree tree2 in allTrees)
                {

                    //Check if we are modifying a "SpecificTree":
                    _LushLODTree tree = tree2;
                    if (ReferenceEquals(SpecificTree, null) == false)
                    {
                        //We are modifying a specific tree.
                        tree = SpecificTree;
                    }

                    if (tree.Material_Instance_Transitioning.HasProperty("_Color")) //<-- this is the billboards colors.
                        tree.Material_Instance_Transitioning.color = //<-- the new color will be:
                            maincolor_LQTrees_ORIGINAL //<-- the original color of the billboards.
                            + NewLQColorApply; //<-- the new color. Note that we didn't remove the previous color.


                    //Now let's apply color changes to the high quality tree models:

                    //Loop through every material in the renderer for the high quality tree model:
                    for (int i = 0; i < tree.lod0Rend.materials.Length; i++) //<-- inst it, because the game is running, so changes shouldn't be permanent.
                    {
                        Material mt = tree.lod0Rend.materials[i]; //<-- instantiate it, because the game is running, 
                                                                  //    so changes shouldn't be permanent. Note: using .materials[]
                                                                  //    instead of .sharedmaterials creates an instance of the material.
                        mt.color = //<-- new color will be:
                            tree.maincolor_HQTrees_ORIGINALS[i] //<-- the original color. This is saved on the prefab itself.
                            + NewHQColorApply; //<-- plus the new color to add.
                    }

#if UNITY_EDITOR
                    EditorUtility.SetDirty(tree);
#endif

                    //If we were suppose to be processing just one SpecificTree, then exit the loop now:
                    if (ReferenceEquals(SpecificTree, null) == false) break;
                }
            }
            else// if (Application.isEditor)
            {

                //If the game isn't running, then we won't create instances of the materials, we will instead apply the color
                //changes in a way that will be permanent:

                if (allTrees[0].lod1Rend.sharedMaterial.HasProperty("_Color")) //<-- This is the color for the billboard trees.
                                                                               //    Use .sharedmaterial, so that we don't create
                                                                               //    an instance of the material.
                    allTrees[0].lod1Rend.sharedMaterial.color = //<-- the new color will be:
                        maincolor_LQTrees_ORIGINAL //<-- the original color of the billboards.
                        + NewLQColorApply; //<-- the new color to add.

                //Modify the opaque billboard color. Note that we're not using the _static version of this variable, like we did
                //above if the game is running. Hover your mouse over this variable to get more information:
                allTrees[0].Material_NotInstance_FullyOpaque.color = //<-- the new color will be:
                    maincolor_LQTrees_ORIGINAL //<-- the original color of the billboards.
                    + NewLQColorApply; //<-- plus the new color to add.

                //Modify the transitioning color also.
                allTrees[0].Material_Instance_Transitioning.color = //<-- the new color will be:
                    maincolor_LQTrees_ORIGINAL //<-- the original color of the billboards.
                    + NewLQColorApply; //<-- the new color to add.

                //Now comes the complex part. Since the game isn't running, we will be modifying the same materials that are
                //saved to the hard drive, and not modifying the instantiated materials. So it's important that we only modify
                //a specific material's color more than once. But we're looping through every tree, and so we may encounter the
                //same material multiple times. Which means we would modify the same material multiple times, if we modify it
                //every time we encounter it. To avoid this, we need to build a list of every unique material we find:
                List<Material> UniqueLOD0MaterialsFound = new List<Material>(); //<-- list of every unique material we find.

                //Loop through every tree:
                foreach (_LushLODTree tree2 in allTrees)
                {

                    //check if we are modifying a specific tree:
                    _LushLODTree tree = tree2;
                    if (ReferenceEquals(SpecificTree, null) == false) tree = SpecificTree; //<-- modify the specific tree.

                    //loop through every material in the renderer for the HQ tree model:
                    for (int i = 0; i < tree.lod0Rend.sharedMaterials.Length; i++) //<-- we use .sharedMaterals[], instead of .materials[]. This will avoid creating any new instances of the materials, so that we will be modifying the materials in a permanent way, since the game ins't currently running.
                    {
                        Material mt = tree.lod0Rend.sharedMaterials[i];

                        //Check if we've ever encountered this material before:
                        if (UniqueLOD0MaterialsFound.Contains(mt) == false)
                        {
                            //We haven't modified this material yet. So let's apply the color changes to it.
                            UniqueLOD0MaterialsFound.Add(mt); //<-- ensures that we don't modify this material more than once.
                            mt.color = //<-- the new color will be:
                                tree.maincolor_HQTrees_ORIGINALS[i] //<-- the original color. This is saved on the prefab itself.
                                + NewHQColorApply; //<-- plus the new color to add.
                        }
                    }

#if UNITY_EDITOR
                    EditorUtility.SetDirty(tree);
#endif

                    //If we were suppose to be processing just one SpecificTree, then exit the loop now:
                    if (ReferenceEquals(SpecificTree, null) == false) break;
                }

                UniqueLOD0MaterialsFound.Clear();
                UniqueLOD0MaterialsFound = null;
            }
        }

        //####### LOD #######
        bool LODchnged = false; //<-- temporary variable, saves if we changed the LOD or not.
        if (Mathf.Approximately(LOD_adjust, LOD_adjust_PREVIOUS) != true) //<-- check if we are requesting a new LOD distance.
        {
            //Yes, new LOD distance.
            LOD_adjust_PREVIOUS = LOD_adjust;
            LODchnged = true; //<-- we will indeed be changing the LOD. So save that fact.
        }


        if (LODchnged == true // <-- if we requested a new LOD, then yes, let's change the LOD.
            || UpdatingSpecificTreeONLY == true //<-- or, if we are changing a specific tree, then yes, let's check its LOD.
            || ForceFullUpdate == true)  //<-- or, we are requesting a full update
        {

            //Don't spam the SetupHalfSrqTransition function if we are updating a specific tree...
            if (LODchnged == true || ForceFullUpdate == true || halfsqrTransition == 0f)
                SetupHalfSrqTransition(false);

            //Loop through every tree:
            foreach (_LushLODTree tree2 in allTrees)
            {
                _LushLODTree tree = tree2;

                //If we're changing a specific tree, then change that tree isntead:
                if (ReferenceEquals(SpecificTree, null) == false) tree = SpecificTree;

                tree.lodDistance = Mathf.RoundToInt(LOD_adjust); //<-- hover your mouse to see what this does.
                tree.Reset(); //<-- hover your mouse to see what this does.

#if UNITY_EDITOR
                EditorUtility.SetDirty(tree);
#endif
                if (ReferenceEquals(SpecificTree, null) == false) break;

            }

            if (LODchnged)
            {
                if (Application.isPlaying)
                {
                    UnityEngine.Debug.LogWarning("You changed the LOD Distance during the game. Changing the LOD Distance requires a full recalculation of the parents, which will freeze the game momentarily. You may want to adjust the LOD Distance when the game isn't running (in the Unity editor).");
                }
                _LushLODTree.TreesManager.ReCalculateParents(true);
            }
        }

        bool UltraQualtyChanged = false;

        if (billboard_quality == billboard_quality_PREVIOUS && billboard_quality == BillboardQualitySettings.Ultra &&
            ((BillBoardSetting == BillBoardSettings.BillboardsOnly && BillBoardSetting_PREVIOUS != BillBoardSettings.BillboardsOnly) ||
            (BillBoardSetting != BillBoardSettings.BillboardsOnly && BillBoardSetting_PREVIOUS == BillBoardSettings.BillboardsOnly)))
        {
            //If we're using Ultra quality setting,
            //but we change to or from "billboard only" mode, 
            //then we need to enter the next area to change the Ultra shader for the billboards.
            UltraQualtyChanged = true;
        }



        if (billboard_quality != billboard_quality_PREVIOUS //<-- check for changes in angular correction.
            || UpdatingSpecificTreeONLY == true //<-- check if we are processing a specific tree, in which case, we enter this area of code.
            || ForceFullUpdate == true  //<-- or, we are requesting a full update
            || UltraQualtyChanged == true)
        {
            if (!(UpdatingSpecificTreeONLY == true)) //<-- if we are NOT processing a specific tree, then:
            {

                if (billboard_quality != billboard_quality_PREVIOUS)
                {
                    if ((billboard_quality == BillboardQualitySettings.Ultra && billboard_quality_PREVIOUS != BillboardQualitySettings.Ultra)
                        ||
                        (billboard_quality != BillboardQualitySettings.Ultra && billboard_quality_PREVIOUS == BillboardQualitySettings.Ultra))
                    {
                        //User has entered or is leaving the ultra quality setting. In this case, we need to change the HQ shader as well.
                        //So to make sure this happens, let's force an update to that part of the code, which happens below.
                        SetupHalfSrqTransition(false);
                        UltraQualtyChanged = true;
                    }
                }

                //we are NOT processing a specific tree, so we must have changed something in the settings (otherwise, how did we get here?)
                //So save that:
                billboard_quality_PREVIOUS = billboard_quality;
            }

            //Increment this variable. This will trigger all the trees in the scene to
            //update their shaders to match the settings seen in the manager.
            if (UpdatingSpecificTreeONLY == false) ShaderSettingsChanged += 1;

            bool UsePrevious = UpdatingSpecificTreeONLY ? true : false; //<-- if we are bypassing checks for changed values, then use the previous value.

            //ToDo: a lot of code relating to editing the tree materials was removed
            //from this location, and moved into the _LushLODTree.cs file. But this
            //change has only been finished for Unity 5.5+, and I did not yet perform
            //this change on earlier Unity versions.

            if (Application.isPlaying)
            {

                //Loop through every tree:
                foreach (_LushLODTree tree2 in allTrees)
                {
                    _LushLODTree tree = tree2;
                    if (ReferenceEquals(SpecificTree, null) == false) tree = SpecificTree; //<-- explained many times above.

                    //explained above:
                    tree.billboard_quality_PREVIOUS = billboard_quality;

                    //Calculate the transition ranges:
                    //NOTE: We already updated the lodDistance above, so we don't have to worry about that being out of date.
                    tree.sqrTransition = CalculateLODDistances(tree.lodDistance, UsePrevious, AverageTreeScale);

                    //ToDo: a lot of code relating to editing the tree materials was removed
                    //from this location, and moved into the _LushLODTree.cs file. But this
                    //change has only been finished for Unity 5.5+, and I did not yet perform
                    //this change on earlier Unity versions.

#if UNITY_EDITOR
                    EditorUtility.SetDirty(tree);
#endif

                    //Break this loop if we are only processing a specific tree:
                    if (ReferenceEquals(SpecificTree, null) == false) break;

                }
            }
            else
            {
                //The game isn't running. as explained above many times, this affects which materials we modify.
                //Loop throughe very tree:
                foreach (_LushLODTree tree2 in allTrees)
                {
                    _LushLODTree tree = tree2;
                    if (ReferenceEquals(SpecificTree, null) == false) tree = SpecificTree;

                    //These lines of code were already explained above:
                    tree.billboard_quality_PREVIOUS = billboard_quality;

                    //Calculate the transition ranges:
                    //NOTE: We already updated the lodDistance above, so we don't have to worry about that being out of date.
                    tree.sqrTransition = CalculateLODDistances(tree.lodDistance, UsePrevious, AverageTreeScale);

                    //ToDo: a lot of code relating to editing the tree materials was removed
                    //from this location, and moved into the _LushLODTree.cs file. But this
                    //change has only been finished for Unity 5.6+, and I did not yet perform
                    //this change on earlier Unity versions.

#if UNITY_EDITOR
                    EditorUtility.SetDirty(tree);
#endif

                    //break this loop if we are only processing a specific tree:
                    if (ReferenceEquals(SpecificTree, null) == false) break;

                }
            }
        }
        //////////////}

        if (RenderingMode != RenderingMode_PREVIOUS)
        {
            RenderingMode_PREVIOUS = RenderingMode; //<-- save that the user requested, and that we applied, a change.

            //Increment this variable. This will trigger all the trees in the scene to
            //update their shaders to match the settings seen in the manager.
            if (UpdatingSpecificTreeONLY == false) ShaderSettingsChanged += 1;
        }

        //#### RECEIVE SHADOW SETTINGS #####
        if (ShadowReceiveSetting != ShadowReceiveSetting_PREVIOUS //<-- check if the user requested to change the shadow receiving settings.
            || UpdatingSpecificTreeONLY == true //<-- check if we are processing a specific tree.
            || ForceFullUpdate == true   //<-- or, we are requesting a full update
            || UltraQualtyChanged == true)  //<-- or, if we changed the ultra quality setting, then we need to enter this area to update the HQ shaders.
        {
            if (!(UpdatingSpecificTreeONLY == true)) //<-- if we are NOT processing a specific tree, then...
                ShadowReceiveSetting_PREVIOUS = ShadowReceiveSetting; //<-- save that the user requested, and that we applied, a change.

            //Increment this variable. This will trigger all the trees in the scene to
            //update their shaders to match the settings seen in the manager.
            if (UpdatingSpecificTreeONLY == false) ShaderSettingsChanged += 1;

            //Loop through every tree:
            foreach (_LushLODTree tree2 in allTrees)
            {
                //these two lines of code have already been explained many times:
                _LushLODTree tree = tree2;
                if (ReferenceEquals(SpecificTree, null) == false) tree = SpecificTree;

                //ToDo: a lot of code relating to editing the tree shaders was removed
                //from this location, and moved into the _LushLODTree.cs file. But this
                //change has only been finished for Unity 5.5+, and I did not yet perform
                //this change on earlier Unity versions.

                switch (ShadowReceiveSetting) //<-- select our billboard setting.
                {
                    case ShadowReceiveSettings.AllShadows:
                        //User is requesting to use Unity's built in shadow receiving system:

                        tree.ShadowReceiveSetting = ShadowReceiveSettings.AllShadows;

                        tree.lod0Rend.receiveShadows = true; //<-- set the HQ tree to receive shadows.

                        //ToDo: a lot of code relating to editing the tree shaders was removed
                        //from this location, and moved into the _LushLODTree.cs file. But this
                        //change has only been finished for Unity 5.5+, and I did not yet perform
                        //this change on earlier Unity versions.


                        break;
                    case ShadowReceiveSettings.SimpleShadows:
                        //User is requesting to use LushLOD's Simple Shadows system:

                        tree.ShadowReceiveSetting = ShadowReceiveSettings.SimpleShadows;

                        //Loop through all the high quality model renderers:

                        tree.lod0Rend.receiveShadows = false; //<-- set the tree to NOT receive shadows. The simple shadow system turns this off to increase framerate.

                        //ToDo: a lot of code relating to editing the tree shaders was removed
                        //from this location, and moved into the _LushLODTree.cs file. But this
                        //change has only been finished for Unity 5.6+, and I did not yet perform
                        //this change on earlier Unity versions.

                        break;
                    case ShadowReceiveSettings.NoShadows:
                        //User is requesting the high quality trees will not receive any shadows at all:

                        tree.ShadowReceiveSetting = ShadowReceiveSettings.NoShadows;

                        //Loop through all the high quality model renderers:

                        tree.lod0Rend.receiveShadows = false; //<-- set the tree to receive no shadows.

                        //ToDo: a lot of code relating to editing the tree shaders was removed
                        //from this location, and moved into the _LushLODTree.cs file. But this
                        //change has only been finished for Unity 5.6+, and I did not yet perform
                        //this change on earlier Unity versions.

                        break;

                }

#if UNITY_EDITOR
                EditorUtility.SetDirty(tree);
#endif

                //If we are processing a specific tree, then break the loop now:
                if (ReferenceEquals(SpecificTree, null) == false) break;

            }
        }


        //#### Billboard settings #####
        if (BillBoardSetting != BillBoardSetting_PREVIOUS //<-- check if the user requested to change the billboard settings.
            || UpdatingSpecificTreeONLY == true //<-- check if we are processing a specific tree.
            || ForceFullUpdate == true)  //<-- or, we are requesting a full update
        {

            if (!(UpdatingSpecificTreeONLY == true)) //<-- if we are NOT processing a specific tree, then...
                BillBoardSetting_PREVIOUS = BillBoardSetting; //<-- save that the user requested, and that we applied, a change.

            //Loop through every tree:
            foreach (_LushLODTree tree2 in allTrees)
            {
                //these two lines of code have already been explained many times:
                _LushLODTree tree = tree2;
                if (ReferenceEquals(SpecificTree, null) == false) tree = SpecificTree;

                switch (BillBoardSetting) //<-- select our billboard setting.
                {
                    case BillBoardSettings.BillboardsOnly:
                        //User has requested to display and use billboards only. 
                        //This will do several things. 
                        //1) It will turn off the high quality models.
                        //2) It will switch the billboards to a material / shader that doesn't support transitioning.
                        //3) It will deactivate all the _LushLODTree.cs scripts that are running on every tree,
                        //because there is no need for the trees to be calculating their distance to the camera anymore.
                        tree.BillBoardSetting = BillBoardSettings.BillboardsOnly; //<-- save this directly into the tree. This is useful if the user deletes the _LushLODTreesManager.cs from the scene, then we won't forget the current setting, because we saved it into the trees themselves.
                        tree.lod1Rend.enabled = true;
                        if (Application.isPlaying)
                        {
                            //game is running:
                            if (tree.lod1Rend.sharedMaterial != tree.Material_FullyOpaque_static.Material_FullyOpaque_static)
                            {
                                tree.lod1Rend.sharedMaterial = tree.Material_FullyOpaque_static.Material_FullyOpaque_static; //<-- no inst
                                tree.lod1Rend.enabled = true;
                            }

                            //We are using billboards only, so the scripts that are attached to every tree should simply
                            //be disabled, so that they won't calculate their distance to the camera anymore.
                            tree.enabled = false;
                            tree.MyChildrenEnabled = false; //<-- because EVERY tree is being disabled.
                        }
                        else
                        {
                            //game isn't running:
                            if (tree.lod1Rend.sharedMaterial != tree.Material_NotInstance_FullyOpaque)
                            {
                                tree.lod1Rend.sharedMaterial = tree.Material_NotInstance_FullyOpaque; //<-- no inst
                                tree.lod1Rend.enabled = true;
                            }
                            //We are using billboards only, so the scripts that are attached to every tree should simply
                            //be disabled, so that they won't calculate their distance to the camera anymore.
                            tree.enabled = true; //<-- the script must still run, but it'll disble itself.
                        }

                        //disable the renderer in the high quality tree model:
                        tree.lod0Rend.enabled = false;

                        break;
                    case BillBoardSettings.HighQualityModelsOnly:
                        //User has requested to display and use high quality tree models only. 

                        tree.BillBoardSetting = BillBoardSettings.HighQualityModelsOnly; //<-- save this directly into the tree. This is useful if the user deletes the _LushLODTreesManager.cs from the scene, then we won't forget the current setting, because we saved it into the trees themselves.

                        tree.lod1Rend.enabled = false; //<-- new as of 9/3/2016. I think this is what needs to be done here.

                        tree.lod0Rend.enabled = true; //<-- hover mouse to see description.
                        tree.rendIs1 = true; //<-- hover mouse to see description.
                        tree.rendIsFloat = 1f; //<-- hover mouse to see description.
                        if (Application.isPlaying)
                        {
                            //if the game is running, we use ".materials", which creates an instance.
                            foreach (Material mat in tree.lod0Rend.materials) //<-- inst
                            {
                                mat.SetFloat("_Transparency", 1f); //<-- fully opaque, but doesn't cast shadows.
                            }

                            //We are using high quality models only, so the scripts that are attached to every tree should simply
                            //be disabled, so that they won't calculate their distance to the camera anymore.
                            tree.enabled = false;
                            tree.MyChildrenEnabled = false; //<-- because EVERY tree is being disabled.
                        }
                        else
                        {
                            //The game isn't running. So in this case, we'll actuall leave the script turned on.
                            //But it will turn itself off as soon as the game starts. The only reason it is enabled is so
                            //that it will run all of its initilization code when the game first starts. But it will turn
                            //itself off on the first call to Update(). 
                            tree.enabled = true; //<-- the script must still run, but it'll disble itself.
                        }
                        break;
                    case BillBoardSettings.UseBoth:
                        //User has requested to display and use both high quality tree models, and billboards in the distance.
                        //This is the default setting.

                        tree.BillBoardSetting = BillBoardSettings.UseBoth; //<-- save this directly into the tree. This is useful if the user deletes the _LushLODTreesManager.cs from the scene, then we won't forget the current setting, because we saved it into the trees themselves.

                        if (Application.isPlaying)
                        {
                            if (tree.IsParent == true)
                            {
                                //It'll decide if its children should be turned on or not.
                                tree.CheckChildren = true; //<-- hover mouse to see description.
                                tree.enabled = true; //<-- hover mouse to see description.
                            }
                        }
                        else
                        {
                            //Game isn't running.
                            tree.lod1Rend.enabled = true; //<-- updated 9/14/2016: I think this is all that needs to be done here.
                            tree.lod0Rend.enabled = true; //<-- hover mouse to see description.
                            tree.enabled = true;
                            tree.MyChildrenEnabled = true; //<-- every tree is being turned on.
                        }
                        break;
                }

#if UNITY_EDITOR
                EditorUtility.SetDirty(tree);
#endif

                //If we are processing a specific tree, then break the loop now:
                if (ReferenceEquals(SpecificTree, null) == false) break;

            }
        }

        //########### ADVANCED SIMPLE SHADOWS SETTINGS ##########
        if (TranslucencySharpen != TranslucencySharpen_PREVIOUS
            || ShadowSize != ShadowSize_PREVIOUS
            || ShadowClip != ShadowClip_PREVIOUS
            || AmbientOcclusion != AmbientOcclusion_PREVIOUS
            || ShadowContrast != ShadowContrast_PREVIOUS
            || TimeOfDay != TimeOfDay_PREVIOUS
            || Translucency != Translucency_PREVIOUS
            || UpdatingSpecificTreeONLY == true //<--- or, we are processing a specific tree.
            || ForceFullUpdate == true)
        {
            if (!(UpdatingSpecificTreeONLY == true)) //<-- if we are NOT processing a specific tree, then:
            {
                TranslucencySharpen_PREVIOUS = TranslucencySharpen; //<-- save the fact that we applied this new shadow setting.
                ShadowSize_PREVIOUS = ShadowSize; //<-- save the fact that we applied this new shadow setting.
                ShadowClip_PREVIOUS = ShadowClip; //<-- save the fact that we applied this new shadow setting.
                AmbientOcclusion_PREVIOUS = AmbientOcclusion; //<-- save the fact that we applied this new shadow setting.
                ShadowContrast_PREVIOUS = ShadowContrast; //<-- save the fact that we applied this new shadow setting.
                TimeOfDay_PREVIOUS = TimeOfDay; //<-- save the fact that we applied this new shadow setting.
                Translucency_PREVIOUS = Translucency; //<-- save the fact that we applied this new shadow setting.
            }
            //Loop through every tree:
            foreach (_LushLODTree tree2 in allTrees)
            {
                //These lines of code are explained around, above.
                _LushLODTree tree = tree2;
                if (ReferenceEquals(SpecificTree, null) == false) tree = SpecificTree;

                //All we do here is SAVE the values to the tree. 
                //No settings is actually adjusted here. We do that in this managers Start() and Update() functions.
                
                //Saving the settings here is what will allow our manager to load these settings later, if needed.
                tree.TranslucencySharpen = TranslucencySharpen;
                tree.ShadowSize = ShadowSize;
                tree.ShadowClip = ShadowClip;
                tree.AmbientOcclusion = AmbientOcclusion;
                tree.ShadowContrast = ShadowContrast;
                tree.TimeOfDay = TimeOfDay;
                tree.Translucency = Translucency;

#if UNITY_EDITOR
                EditorUtility.SetDirty(tree);
#endif

                //If we are processing a specific tree, then break the loop here:
                if (ReferenceEquals(SpecificTree, null) == false) break;
            }
        }

        // ########## Shadow settings ################
        if (RealTimeShadowSetting != RealTimeShadowSetting_PREVIOUS //<-- if the user requested a different shadow setting.
            || UpdatingSpecificTreeONLY == true //<--- or, we are processing a specific tree.
            || ForceFullUpdate == true)  //<-- or, we are requesting a full update
        {

            if (!(UpdatingSpecificTreeONLY == true)) //<-- if we are NOT processing a specific tree, then:
                RealTimeShadowSetting_PREVIOUS = RealTimeShadowSetting; //<-- save the fact that we applied this new shadow setting.

            //Loop through every tree:
            foreach (_LushLODTree tree2 in allTrees)
            {
                //These lines of code are explained around, above.
                _LushLODTree tree = tree2;
                if (ReferenceEquals(SpecificTree, null) == false) tree = SpecificTree;

                switch (RealTimeShadowSetting) //<-- hover mouse to see description.
                {
                    case RealTimeShadowSettings.UseBoth:

                        //User is requesting to use both high quality and billboard shadows.
                        //It will smoothly transition between them.

                        tree.RealTimeShadowSetting = RealTimeShadowSettings.UseBoth; //<-- save this to the tree itself, in case the user deletes the _LushLODTreeManager from the scene, we'll still remember the setting because we're saving it to the trees.

                        //Turn on billboard shadows:
                        tree.lod1Rend.shadowCastingMode = UnityEngine.Rendering.ShadowCastingMode.TwoSided;

                        //Turn on high quality tree shadows:
                        tree.lod0Rend.shadowCastingMode = UnityEngine.Rendering.ShadowCastingMode.On;

                        break;
                    case RealTimeShadowSettings.BillboardOnly:

                        //User is requesting Billboard shadows.

                        tree.RealTimeShadowSetting = RealTimeShadowSettings.BillboardOnly; //<-- save this to the tree itself, in case the user deletes the _LushLODTreeManager from the scene, we'll still remember the setting because we're saving it to the trees.

                        //Turn on billboard shadows:
                        tree.lod1Rend.shadowCastingMode = UnityEngine.Rendering.ShadowCastingMode.TwoSided;

                        //Turn off high quality tree shadows:
                        tree.lod0Rend.shadowCastingMode = UnityEngine.Rendering.ShadowCastingMode.Off;

                        //Set the transparency of the billboard.
                        if (Application.isPlaying)
                        {

                            if (BillBoardSetting_PREVIOUS != BillBoardSettings.HighQualityModelsOnly)
                            {
                                //Don't turn on the billboards here, if we're currently supposed to display high quality tree models only!
                                if (tree.lod1Rend.enabled != true)
                                    tree.lod1Rend.enabled = true;
                            }

                            if (tree.enabled == false) //<-- if the tree *is* enambed, then it will set its own transparency... no need for us to do it here.
                                tree.lod1Rend.sharedMaterial.SetFloat("_Transparency", 1f);

                            tree.lod1Rend.sharedMaterial.SetFloat("_ShadowTransparency", 1f);
                        }
                       
                        break;
                    case RealTimeShadowSettings.RealtimeShadowsOff:
                        //Turning shadows off.
                        tree.RealTimeShadowSetting = RealTimeShadowSettings.RealtimeShadowsOff; //<-- save it to the tree itself.

                        //Turn off billboard shadows:
                        tree.lod1Rend.shadowCastingMode = UnityEngine.Rendering.ShadowCastingMode.Off;

                        //Turn off high quality tree shadows:
                        tree.lod0Rend.shadowCastingMode = UnityEngine.Rendering.ShadowCastingMode.Off;
                                               
                        break;
                }

#if UNITY_EDITOR
                EditorUtility.SetDirty(tree);
#endif

                //If we are processing a specific tree, then break the loop here:
                if (ReferenceEquals(SpecificTree, null) == false) break;
            }
        }

        if (Application.isPlaying == true)
        {
            if (ShaderSettingsChanged_PREVIOUS != ShaderSettingsChanged)
            {
                ShaderSettingsChanged_PREVIOUS = ShaderSettingsChanged;
                //Loop through all the trees in the scene, and call their DoShaderUpdate()
                //function. This will apply and changes needed to the shaders, which are
                //necessary to get the trees in sync with the settings in the manager.

                //Loop through every tree
                foreach (_LushLODTree tree in allTrees)
                {
                    if (tree.ShaderSettingsChanged != ShaderSettingsChanged)
                    {
                        tree.DoShaderUpdate();

#if UNITY_EDITOR
                        EditorUtility.SetDirty(tree);
#endif

                    }
                }
            }
        }

        //### FINISH TREES SETUP ###
        if (Application.isPlaying == false)
        {
            //Game isn't running.
            if (ReferenceEquals(SpecificTree, null))
            {
                //We're not processing a specific tree, which means all trees have
                //finished being set up (meaning they've received an applyall() from the
                //manager at least once, so they are not out-of-sync with the manager)

                //So let's set them all to not be in setup mode anymore:

                //Loop through every tree
                foreach (_LushLODTree tree in allTrees)
                {
                    tree.TreeIsSetup = true;

#if UNITY_EDITOR
                    EditorUtility.SetDirty(tree);
#endif
                }
            }
        }
    }



    [ExecuteInEditMode] //<-- hover mouse to see description.
    void Start()
    {

        ShaderSettingsChanged = 0;
        ShaderSettingsChanged_PREVIOUS = 0;

        if (_LushLODTree.TreesManager != null) SetupHalfSrqTransition(true);

        if (UsingLinearColor == 2)
        {
            //Color space is Linear.
            UsingLinearColor = 2;
            Shader.SetGlobalFloat("_LushLODTreeLinear", 0.8f);
        }
        else if (UsingLinearColor == 1)
        {
            //Color space is NOT Linear.
            UsingLinearColor = 1;
            Shader.SetGlobalFloat("_LushLODTreeLinear", 0f);
        }
        else if (UsingLinearColor == 0)
        {
            //Color space hasn't been set up yet. So, we'll "assume" it is Gamma.
            UsingLinearColor = 1;
            Shader.SetGlobalFloat("_LushLODTreeLinear", 0f);
        }

        Shader.SetGlobalFloat("_LushLODTreeTranslucencySharpen", TranslucencySharpen);
        Shader.SetGlobalFloat("_LushLODTreeMaxShadowAdd", ShadowSize);
        Shader.SetGlobalFloat("_LushLODTreeShadowDarkness", ShadowClip);
        Shader.SetGlobalFloat("_LushLODTreeAO", AmbientOcclusion);
        Shader.SetGlobalFloat("_LushLODTreeShadowContrast", ShadowContrast);
        Shader.SetGlobalFloat("_LushLODTreeTimeOfDay", TimeOfDay);
        Shader.SetGlobalFloat("_LushLODTreeTranslucency", Translucency);
        Shader.SetGlobalColor("_LushLODTreeAmbientColor", ambientColor);

        Update();
    }

    [ExecuteInEditMode] //<-- hover mouse to see description.
    void OnEnable()
    {
        if (_LushLODTree.TreesManager != null) SetupHalfSrqTransition(true);
        Update();
    }

    // Update is called once per frame
    [ExecuteInEditMode] //<-- hover mouse to see description.
    void Update()
    {

        if (Application.isPlaying)
        {
            CancelInvoke("Update");
        }
        else
        {
            CancelInvoke("Update");
            InvokeRepeating("Update", 5f, 5f);
        }

#if UNITY_EDITOR

        //This code only works if we're in the Unity Editor.
        //If we are NOT in the Unity editor, then the _LushLODTreeLinear global shader variable will
        //only be set once, which happens in this manager's Start() function. That should be good enough
        //since, outside of the Unity Editor, it shouldn't be possible for the color mode to be changed.
        //And if it can't change, then there is no need to keep checking it here in this Update() function.

        if (PlayerSettings.colorSpace == ColorSpace.Linear && UsingLinearColor != 2)
        {
            //Color space is Linear.
            UsingLinearColor = 2;
            Shader.SetGlobalFloat("_LushLODTreeLinear", 0.8f);
        }
        else if (PlayerSettings.colorSpace != ColorSpace.Linear && UsingLinearColor != 1)
        {
            //Color space is NOT Linear.
            UsingLinearColor = 1;
            Shader.SetGlobalFloat("_LushLODTreeLinear", 0f);
        }

        //
        //These values probably only need to be adjusted once, at the start of the game.
        //Or, if this script is being run from withinn the Unity Editor, then these shader updates will
        //be run frequently in case the user adjusts anything.
        Shader.SetGlobalFloat("_LushLODTreeTranslucencySharpen", TranslucencySharpen);
        Shader.SetGlobalFloat("_LushLODTreeMaxShadowAdd", ShadowSize);
        Shader.SetGlobalFloat("_LushLODTreeShadowDarkness", ShadowClip);
        Shader.SetGlobalFloat("_LushLODTreeAO", AmbientOcclusion);
        Shader.SetGlobalFloat("_LushLODTreeShadowContrast", ShadowContrast);
        Shader.SetGlobalFloat("_LushLODTreeTimeOfDay", TimeOfDay);
        Shader.SetGlobalFloat("_LushLODTreeTranslucency", Translucency);
        Shader.SetGlobalColor("_LushLODTreeAmbientColor", ambientColor);

#endif


        if (!(MainDirectionalLight == null ||
                    ReferenceEquals(MainDirectionalLight, null) ||
                    MainDirectionalLight.Equals(null)))
        {
            Light TheLight = MainDirectionalLight;
            Vector3 LightDir = -(TheLight.transform.rotation * Vector3.forward);//. .eulerAngles;
            if (PreviousLight != TheLight ||
                PreviousLightColor != TheLight.color ||
                PreviousLightIntensity != TheLight.intensity ||
                PreviousLightDir != LightDir)
            {
                PreviousLight = TheLight;
                PreviousLightColor = TheLight.color;
                PreviousLightIntensity = TheLight.intensity;
                PreviousLightDir = LightDir;
                Vector3 LightDirNormalized = LightDir.normalized;
                Shader.SetGlobalColor("_LushLODTreeMainLightCol", TheLight.color);
                Shader.SetGlobalFloat("_LushLODTreeMainLightIntensity", TheLight.intensity);
                //The .w value of 2f tells the shader that we did indeed set this variable, and it is not "undefined" anymore:
                Shader.SetGlobalVector("_LushLODTreeMainLightDir", new Vector4(LightDirNormalized.x, LightDirNormalized.y, LightDirNormalized.z, 2f));
            }
        }

        //The tree's have exactly two static variables. If this code is recompiled, those static variables
        //will be set to null which can cause null reference exceptions, or other bugs. To fix this, we check
        //here in the manager to make sure those static variables haven't lost their values.
        if (_LushLODTree.TreesManager == null || 
            ReferenceEquals(_LushLODTree.TreesManager, null) ||
            _LushLODTree.TreesManager.Equals(null))
        {
            _LushLODTree.TreesManager = this;

            SetupHalfSrqTransition(true);

            if (TreesRoot != null &&
                ReferenceEquals(TreesRoot, null) != true &&
                TreesRoot.Equals(null) != true)
            {
                //Gets a list of all trees in the scene:
                _LushLODTree[] allTrees = TreesRoot.GetComponentsInChildren<_LushLODTree>();
                //Loop through every tree
                foreach (_LushLODTree tree in allTrees)
                {
                    //Instantiate the static material, if it isn't already instantiated:
                    //This has to be done on every tree, since they may not share the same material.
                    //The tree's will do this for themselves, in their Update() loop, but that only works if their
                    //update loop is actually turned on. Which it isn't, if the trees are set to billboard mode, for example.
                    //So just to be sure, we also do it from here.

                    //Check that we still have our static reference to our atlas material:
                    if (tree.Material_FullyOpaque_static == null)
                    {
                        _LushLODTree.SetupStaticMaterial(tree);
                    }

                }
            }
        }

        if (PrentsRootNotSet &&
            TreesRoot != null &&
            ReferenceEquals(TreesRoot, null) != true &&
            TreesRoot.Equals(null) != true)
        {
            PrentsRootNotSet = false; //<-- can't remember what is the purpose of this.
            //I guess this ensures we don't enter this area of code every single frame,
            //which could lock up unity as this area of code involves a big call to GetComponentsInChildren, below.
            if (ReferenceEquals(_LushLODTree.TreesManager, null))
            {
                _LushLODTree[] allTrees = TreesRoot.GetComponentsInChildren<_LushLODTree>();
                //Loop through every tree, and set their personal reference to this manager.
                foreach (_LushLODTree tree in allTrees)
                {
                    tree.TreesManager_ref = this;

#if UNITY_EDITOR
                    EditorUtility.SetDirty(tree);
#endif
                }
            }
        }

        if (should_recalculate_parents)
        {
            should_recalculate_parents = false;
            CancelInvoke("OnDestroyParent");
            Invoke("OnDestroyParent", 3f); //<-- wait 3 full second before applying this change. This will avoid a situation where we recalculate the parents a zillion times while the game is shutting down, or when the user tries to delete a large number of trees from the scene.
        }


    }
}

#if UNITY_EDITOR
/// <summary>
/// This script / class is (or should be) attached to a gameobject in the scene's heirarchy, 
/// which should also be named "_LushLODTreesManager". It can automatically be added to the scene
/// by any _LushLODTree in the scene.
///
/// This is the LushLOD Trees Manager,
/// which allows you to control some useful settings for all the trees
/// in your scene. No more clicking through every tree just to
/// make a simple adjustment. The manager can be used to quickly test
/// framerate-critical options, allowing you to modify:
/// 1) The colors for the far and near trees.
/// 2) The LOD Distance.
/// 3) Billboard settings.
/// 4) Quality settings.
/// 5) Shadow settings.
/// 6) More options coming soon!
///
/// With all these options availale, you'll be able to tweak the
/// settings to get the exact balance you need between quality and
/// framerate. Perfect for multiplatform releases and mobile!
/// </summary>
// Custom Editor using SerializedProperties.
// Automatic handling of multi-object editing, undo, and prefab overrides.
[CustomEditor(typeof(_LushLODTreesManager))]
//[CanEditMultipleObjects]
public class _LushLODTreesManager_Editor : Editor
{

    //Used to check for the presence of the post-processing script, but not every frame.
    [SerializeField]
    private float timeSkip_checkPostProcessor;
    [SerializeField]
    private float timeSkip_checkRenderingPath;
    [SerializeField]
    private float timeSkip_checkDirectionalLight;
    [SerializeField]
    private bool MissingPostProcess = false;
    [SerializeField]
    private bool CameraIsUsingForward = false;
    [SerializeField]
    private bool AllLightsAreBaked = false;

    [SerializeField]
    Color TestAmbientColor = Color.clear;
    private bool AmbientChanged = false;
    private bool AmbientDifferent = false;

    /// <summary>
    /// This bool determines if changes made by the manager can be undone using Unity's "Undo" system. Turning this option off may be necessary if you have thousands of trees in your scene, as the "Undo" stack can start to get extremely bogged down and slow.
    /// </summary>
    SerializedProperty EnableUndo;

    /// <summary>
    /// This is the ambient light color.
    /// </summary>
    SerializedProperty ambientColor;
    /// <summary>
    /// This variable otais the value on the previous frame. Used to detect if we changed the value.
    /// </summary>
    SerializedProperty ambientColor_PREVIOUS;

    /// <summary>
    /// This is the color to add or remove from the high quality trees. If any of the color values are above 0.5, then color will be added. If any are below 0.5, then that amount will be subtracted. So, for example, setting this to {0.5f, 0.5f, 0.5f, 0.5f} will change nothing, since all 4 color values are exactly 0.5. But setting it to {0f, 0.5f, 0.5f, 0.5f} will remove half the value of the RED color from the high quality trees.
    /// </summary>
    SerializedProperty mainColor_HQTrees;
    /// <summary>
    /// This is the color to add or remove from the low quality trees. If any of the color values are above 0.5, then color will be added. If any are below 0.5, then that amount will be subtracted. So, for example, setting this to {0.5f, 0.5f, 0.5f, 0.5f} will change nothing, since all 4 color values are exactly 0.5. But setting it to {0f, 0.5f, 0.5f, 0.5f} will remove half the value of the RED color from the low quality trees.
    /// </summary>
    SerializedProperty mainColor_LQTrees;
    /// <summary>
    /// This variable contains the value on the previous frame. Used to detect if we changed the value.
    /// </summary>
    SerializedProperty mainColor_LQTrees_PREVIOUS;
    /// <summary>
    /// This variable contains the value on the previous frame. Used to detect if we changed the value.
    /// </summary>
    SerializedProperty mainColor_HQTrees_PREVIOUS;
    /// <summary>
    /// This float controls the distance for the transition where the high quality trees transition into the billboard models. Setting this to a higher value will make the trees transition at a further distance. Setting it to a lower value will make them transition more close to the camera.
    /// </summary>
    SerializedProperty LOD_adjust;
    /// <summary>
    /// This variable contains the value on the previous frame. Used to detect if we changed the value.
    /// </summary>
    SerializedProperty LOD_adjust_PREVIOUS;
    /// <summary>
    /// This float contains the value used by the slider bar that controls which angular correction mode we are using. It can be one of three values, including -1, 0 and 1. The meaning of these values is: -1 is "Off", 0 is "Medium" and 1 is "Best". The default value is 1, which is "Best" for angular correction.
    /// </summary>
    SerializedProperty billboard_quality;
    /// <summary>
    /// This variable contains the value on the previous frame. Used to detect if we changed the value.
    /// </summary>
    SerializedProperty billboard_quality_PREVIOUS;
    /// <summary>
    /// This enum is used by the drop-down box in the inspector, to select whether or not billboards will be displayed, or high quality models only, or both.
    /// </summary>
    SerializedProperty BillBoardSetting;
    /// <summary>
    /// This variable contains the value on the previous frame. Used to detect if we changed the value.
    /// </summary>
    SerializedProperty BillBoardSetting_PREVIOUS;
    /// <summary>
    /// This variable is used by the slider in the inspector.
    /// </summary>
    SerializedProperty ShadowContrast;
    /// <summary>
    /// This variable contains the value on the previous frame. Used to detet if we changed the value.
    /// </summary>
    SerializedProperty ShadowContrast_PREVIOUS;
    /// <summary>
    /// This variable is used by the slider in the inspector.
    /// </summary>
    SerializedProperty TimeOfDay;
    /// <summary>
    /// This variable contains the value on the previous frame. Used to detet if we changed the value.
    /// </summary>
    SerializedProperty TimeOfDay_PREVIOUS;
    /// <summary>
    /// This variable is used by the slider in the inspector.
    /// </summary>
    SerializedProperty Translucency;
    /// <summary>
    /// This variable contains the value on the previous frame. Used to detet if we changed the value.
    /// </summary>
    SerializedProperty Translucency_PREVIOUS;
    /// <summary>
    /// This variable is used by the slider in the inspector, to adjust the sharpness of the shadows when using Simple Shadows mode.
    /// </summary>
    SerializedProperty TranslucencySharpen;
    /// <summary>
    /// This variable contains the value on the previous frame. Used to detet if we changed the value.
    /// </summary>
    SerializedProperty TranslucencySharpen_PREVIOUS;
    /// <summary>
    /// This variable is used by the slider in the inspector, to adjust the sharpness of the shadows when using Simple Shadows mode.
    /// </summary>
    SerializedProperty ShadowClip;
    /// <summary>
    /// This variable contains the value on the previous frame. Used to detet if we changed the value.
    /// </summary>
    SerializedProperty ShadowClip_PREVIOUS;
    /// <summary>
    /// This variable is used by the slider in the inspector, to adjust the sharpness of the shadows when using Simple Shadows mode.
    /// </summary>
    SerializedProperty AmbientOcclusion;
    /// <summary>
    /// This variable contains the value on the previous frame. Used to detet if we changed the value.
    /// </summary>
    SerializedProperty AmbientOcclusion_PREVIOUS;
    /// <summary>
    /// This variable is used by the slider in the inspector
    /// </summary>
    SerializedProperty ShadowSize;
    /// <summary>
    /// This variable contains the value on the previous frame. Used to detet if we changed the value.
    /// </summary>
    SerializedProperty ShadowSize_PREVIOUS;
    /// <summary>
    /// This enum is used by the drop-down box in the inspector, to select whether or not billboards will be displayed, or high quality models only, or both.
    /// </summary>
    SerializedProperty ShadowReceiveSetting;
    /// <summary>
    /// This variable contains the value on the previous frame. Used to detect if we changed the value.
    /// </summary>
    SerializedProperty ShadowReceiveSetting_PREVIOUS;
    /// <summary>
    /// This enum is used by the drop-down box in the inspector, to select whether or not to display no shadows or Billboard shadows.
    /// </summary>
    SerializedProperty RealTimeShadowSetting;
    /// <summary>
    /// This variable contains the value on the previous frame. Used to detect if we changed the value.
    /// </summary>
    SerializedProperty RealTimeShadowSetting_PREVIOUS;
    /// <summary>
    /// This enum is used by the drop-down box in the inspector, to select the quality for the trees while working in editor mode (game NOT running).
    /// </summary>
    SerializedProperty PreviewMode;
    /// <summary>
    /// This variable contains the value on the previous frame. Used to detect if we changed the value.
    /// </summary>
    SerializedProperty PreviewMode_PREVIOUS;


    /// <summary>
    /// This enum is used by the drop-down box in the inspector, to select the type of rendering mode that the user is using.
    /// </summary>
    SerializedProperty RenderingMode;
    /// <summary>
    /// This variable contains the value on the previous frame. Used to detect if we changed the value.
    /// </summary>
    SerializedProperty RenderingMode_PREVIOUS;

    /// <summary>
    /// This bool is used to ensure that we don't spam the console with warnings about being in shadow baking mode while the game is running.
    /// </summary>
    bool warnedaboutshadowmode = false;
    /// <summary>
    /// This bool saves if we are currently in shadow baking mode or not. Setting this to "true" will not turn on shadow baking mode. Rather, when we DO turn on shadow baking mode (using the button in the GUI), then we set this to true so that the GUI will remember that we are in shadow baking mode, and so that it will then provide us with a button to turn shadow baking mode off.
    /// </summary>
    SerializedProperty ShadowBakingReady;
    /// <summary>
    /// This variable is set to True whenever the user clicks on the Reset Colors button, to force the colors to be reset even if the manager doesn't
    /// have any reason to believe that the colors need to be reset...
    /// </summary>
    SerializedProperty DoColorReset;
        /// <summary>
    /// The main directional light. Only necessary if the scene is baked.
    /// </summary>
    SerializedProperty MainDirectionalLight;
    /// <summary>
    /// This bool is not set to true until the user has finished setting up the TreesRoot gameobject in the manager GUI,
    /// and finished calculating the parents at least once. When this bool is false, the OnEnable() function will exit early,
    /// which is explained below.
    /// </summary>
    [SerializeField]
    bool setupFinished = false;
    [SerializeField]
    bool OnEnableNeeded = false;

    /// <summary>
    /// Called when user performs and undo or redo operation in the editor.
    /// Simply instructs the manage to run its setup code to ensure everything is kept in sync.
    /// </summary>
    void MyUndoCallback()
    {
        OnEnableNeeded = true;
    }

    //This function is called whenever the Tree's manager is enabled. It's also called anytime you recompile this code, etc.
    void OnEnable()
    {

        OnEnableNeeded = false;
        Undo.undoRedoPerformed += MyUndoCallback;

        //The tree's have a global, static reference to this manager. If that reference is still null, then set it now.
        if (ReferenceEquals(_LushLODTree.TreesManager, null))
        {
            _LushLODTree.TreesManager = (_LushLODTreesManager)this.target;
        }

        //as explained above, if the user hasn't calculated the parents yet, then exit this function now.
        //We do this because, without the parents array, some of the code below would generate errors.
        if (setupFinished == false) return;

        MissingPostProcess = false; //<-- Just an initial value. We'll check this in a moment.
        CameraIsUsingForward = false; //<-- Just an initial value. We'll check this in a moment.

        // Setup the SerializedProperties.
        EnableUndo = serializedObject.FindProperty("EnableUndo");

        //See the Unity documentation on what all this does, because this is simply Unity's builtin functionality.

        ambientColor = serializedObject.FindProperty("ambientColor");
        ambientColor_PREVIOUS = serializedObject.FindProperty("ambientColor_PREVIOUS");

        mainColor_HQTrees = serializedObject.FindProperty("maincolor_HQTrees");
        mainColor_LQTrees = serializedObject.FindProperty("maincolor_LQTrees");
        mainColor_LQTrees_PREVIOUS = serializedObject.FindProperty("maincolor_LQTrees_PREVIOUS");
        mainColor_HQTrees_PREVIOUS = serializedObject.FindProperty("maincolor_HQTrees_PREVIOUS");

        LOD_adjust = serializedObject.FindProperty("LOD_adjust");
        LOD_adjust_PREVIOUS = serializedObject.FindProperty("LOD_adjust_PREVIOUS");

        billboard_quality = serializedObject.FindProperty("billboard_quality");
        billboard_quality_PREVIOUS = serializedObject.FindProperty("billboard_quality_PREVIOUS");

        BillBoardSetting = serializedObject.FindProperty("BillBoardSetting");
        BillBoardSetting_PREVIOUS = serializedObject.FindProperty("BillBoardSetting_PREVIOUS");

        ShadowReceiveSetting = serializedObject.FindProperty("ShadowReceiveSetting");
        ShadowReceiveSetting_PREVIOUS = serializedObject.FindProperty("ShadowReceiveSetting_PREVIOUS");

        ShadowContrast = serializedObject.FindProperty("ShadowContrast");
        ShadowContrast_PREVIOUS = serializedObject.FindProperty("ShadowContrast_PREVIOUS");

        TimeOfDay = serializedObject.FindProperty("TimeOfDay");
        TimeOfDay_PREVIOUS = serializedObject.FindProperty("TimeOfDay_PREVIOUS");

        Translucency = serializedObject.FindProperty("Translucency");
        Translucency_PREVIOUS = serializedObject.FindProperty("Translucency_PREVIOUS");

        TranslucencySharpen = serializedObject.FindProperty("TranslucencySharpen");
        TranslucencySharpen_PREVIOUS = serializedObject.FindProperty("TranslucencySharpen_PREVIOUS");

        AmbientOcclusion = serializedObject.FindProperty("AmbientOcclusion");
        AmbientOcclusion_PREVIOUS = serializedObject.FindProperty("AmbientOcclusion_PREVIOUS");

        ShadowClip = serializedObject.FindProperty("ShadowClip");
        ShadowClip_PREVIOUS = serializedObject.FindProperty("ShadowClip_PREVIOUS");

        ShadowSize = serializedObject.FindProperty("ShadowSize");
        ShadowSize_PREVIOUS = serializedObject.FindProperty("ShadowSize_PREVIOUS");

        RealTimeShadowSetting = serializedObject.FindProperty("RealTimeShadowSetting");
        RealTimeShadowSetting_PREVIOUS = serializedObject.FindProperty("RealTimeShadowSetting_PREVIOUS");

        PreviewMode = serializedObject.FindProperty("PreviewMode");
        PreviewMode_PREVIOUS = serializedObject.FindProperty("PreviewMode_PREVIOUS");

        RenderingMode = serializedObject.FindProperty("RenderingMode");
        RenderingMode_PREVIOUS = serializedObject.FindProperty("RenderingMode_PREVIOUS");

        ShadowBakingReady = serializedObject.FindProperty("ShadowBakingReady");
        MainDirectionalLight = serializedObject.FindProperty("MainDirectionalLight");

        DoColorReset = serializedObject.FindProperty("DoColorReset");

        //Set up our starting colors:
        if (mainColor_HQTrees.colorValue == Color.clear &&
            mainColor_LQTrees.colorValue == Color.clear)
        {
            ResetColors();
        }

        //Now we're going to load settings such as billboard and shadow settings. We saved these values directly to the
        //trees themselves. So find and load the first tree we can find:
        _LushLODTree FirstTree = _LushLODTree.TreesManager.TreesRoot.GetComponentInChildren<_LushLODTree>();
        if (FirstTree != null &&
            FirstTree.Equals(null) != true &&
            ReferenceEquals(FirstTree, null) != true)
        {

            //We found a tree. Use whatever values we saved to it, and that's what our manager will start with.
            //This is done in case the trees were modified by the manager, and then the manager was deleted from the scene,
            //and then the manager was added again to the scene. In such a case, the code here will load some settings from
            //the trees to ensure the manager stays in sync with the trees.

            _LushLODTree.TreesManager.FirstTreeFound = FirstTree;

            //Load the billboard settings:
            BillBoardSetting.enumValueIndex = (int)FirstTree.BillBoardSetting;
            BillBoardSetting_PREVIOUS.enumValueIndex = BillBoardSetting.enumValueIndex;

            ShadowReceiveSetting.enumValueIndex = (int)FirstTree.ShadowReceiveSetting;
            ShadowReceiveSetting_PREVIOUS.enumValueIndex = ShadowReceiveSetting.enumValueIndex;

            //Load the shadow settings:
            RealTimeShadowSetting.enumValueIndex = (int)FirstTree.RealTimeShadowSetting;
            RealTimeShadowSetting_PREVIOUS.enumValueIndex = RealTimeShadowSetting.enumValueIndex;

            ShadowContrast.floatValue = FirstTree.ShadowContrast;
            ShadowContrast_PREVIOUS.floatValue = ShadowContrast.floatValue;

            TimeOfDay.floatValue = FirstTree.TimeOfDay;
            TimeOfDay_PREVIOUS.floatValue = TimeOfDay.floatValue;

            Translucency.floatValue = FirstTree.Translucency;
            Translucency_PREVIOUS.floatValue = Translucency.floatValue;


            TranslucencySharpen.floatValue = FirstTree.TranslucencySharpen;
            TranslucencySharpen_PREVIOUS.floatValue = TranslucencySharpen.floatValue;

            ShadowClip.floatValue = FirstTree.ShadowClip;
            ShadowClip_PREVIOUS.floatValue = ShadowClip.floatValue;

            AmbientOcclusion.floatValue = FirstTree.AmbientOcclusion;
            AmbientOcclusion_PREVIOUS.floatValue = AmbientOcclusion.floatValue;

            ShadowSize.floatValue = FirstTree.ShadowSize;
            ShadowSize_PREVIOUS.floatValue = ShadowSize.floatValue;

            //Load the LOD distance value:
            LOD_adjust.floatValue = FirstTree.lodDistance;
            LOD_adjust_PREVIOUS.floatValue = LOD_adjust.floatValue;

            //Load the quality/correction setting:
            billboard_quality.enumValueIndex = (int)FirstTree.billboard_quality_PREVIOUS;
            billboard_quality_PREVIOUS.enumValueIndex = billboard_quality.enumValueIndex;

            //by any chance, were we in shadow baking mode? If so, make sure the manager starts out in shadow baking mode,
            //so the button will be there to turn shadow baking mode off:
            ShadowBakingReady.boolValue = FirstTree.ShadowBakingReady;
        }

        //Load the setting that's actually in effect at the moment:
        //I think it is safe to do this here, and not save/load it from FirstTreeFound like all the variables above,
        //because the RenderingMode should not in any way modify the trees while the game isn't running. However, if I ever change
        //it so that it does modify the trees while the game isn't running, then I'll need to load and save this from FirstTreeFound
        //to prevent the manager from ever getting out of sync with the trees.
        RenderingMode.enumValueIndex = RenderingMode_PREVIOUS.enumValueIndex;

        PreviewMode.enumValueIndex = PreviewMode_PREVIOUS.enumValueIndex;

        // Apply changes to the serializedProperty - always do this in the end of OnInspectorGUI.
        serializedObject.ApplyModifiedProperties(); //<-- this is a builtin Unity function.

    }

    void ResetColors()
    {
        //The color values of 0.5 effectively mean "neither add nor remove any color".
        //Because less than 0.5 would subtract color, and more than 0.5 would add color.
        //So setting the initial values to 0.5 is setting them to a neutral value.
        mainColor_HQTrees.colorValue = new Color(0.5f, 0.5f, 0.5f, 0.5f);
        mainColor_LQTrees.colorValue = new Color(0.5f, 0.5f, 0.5f, 0.5f);
        mainColor_LQTrees_PREVIOUS.colorValue = new Color(0.5f, 0.5f, 0.5f, 0.5f);
        mainColor_HQTrees_PREVIOUS.colorValue = new Color(0.5f, 0.5f, 0.5f, 0.5f);
    }

    private Texture2D MakeTex(int width, int height, Color col)
    {
        Color[] pix = new Color[width * height];
        for (int i = 0; i < pix.Length; ++i)
        {
            pix[i] = col;
        }
        Texture2D result = new Texture2D(width, height);
        result.SetPixels(pix);
        result.Apply();
        return result;
    }

    //This function is called on every frame, if the Manager's GUI window is open and visible:
    public override void OnInspectorGUI()
    {
        // Update the serializedProperty - always do this in the beginning of OnInspectorGUI.
        serializedObject.Update(); //<-- this is a Unity builtin function.

        //Set up some text styles, such as red text, bold red text, etc:
        GUIStyle Redstyle = new GUIStyle(GUI.skin.box);
        GUIStyle BoldRedstyle = new GUIStyle(GUI.skin.box);
        GUIStyle BoldRedstyleButton = new GUIStyle(GUI.skin.button);

        GUIStyle Orangestyle = new GUIStyle(GUI.skin.box);
        GUIStyle BoldOrangestyle = new GUIStyle(GUI.skin.box);
        GUIStyle BoldOrangestyleButton = new GUIStyle(GUI.skin.button);


        GUIStyle BoldStyle = new GUIStyle(GUI.skin.label);
        GUIStyle Greenstyle = new GUIStyle(GUI.skin.box);
        GUIStyle style = new GUIStyle(GUI.skin.button);

        GUIStyle RegularStyleColorUSEME = new GUIStyle(GUI.skin.label);
        GUIStyle RegularStyleBox = new GUIStyle(GUI.skin.box);

        RegularStyleBox.normal.background = RegularStyleColorUSEME.normal.background;
        RegularStyleBox.normal.textColor = RegularStyleColorUSEME.normal.textColor;
        RegularStyleBox.alignment = TextAnchor.UpperLeft;
        RegularStyleBox.padding = new RectOffset(5, 5, 5, 5);

        Redstyle.normal.textColor = Color.red;
        BoldRedstyle.normal.textColor = Color.red;
        BoldRedstyle.fontStyle = FontStyle.Bold;
        BoldRedstyleButton.normal.textColor = Color.red;
        BoldRedstyleButton.fontStyle = FontStyle.Bold;

        Orangestyle.normal.textColor = new Color(1f, 0.6f, 0.2f);
        Orangestyle.normal.background = MakeTex(2, 2, new Color(0.1764f, 0.1764f, 0.1764f, 1f)); //<-- box should be approximatly the color of PRO version of Unity.

        BoldOrangestyle.normal.textColor = new Color(1f, 0.6f, 0.2f);
        BoldOrangestyle.normal.background = MakeTex(2, 2, new Color(0.1764f, 0.1764f, 0.1764f, 1f)); //<-- box should be approximatly the color of PRO version of Unity.
        BoldOrangestyle.fontStyle = FontStyle.Bold;
        BoldOrangestyleButton.normal.textColor = new Color(1f, 0.6f, 0.2f);
        BoldOrangestyleButton.fontStyle = FontStyle.Bold;

        BoldStyle.fontStyle = FontStyle.Bold;
        Greenstyle.normal.textColor = new Color(0f, 0.4f, 0f);
        Greenstyle.normal.background = MakeTex(2, 2, new Color(0.1764f, 0.1764f, 0.1764f, 1f)); //<-- box should be approximatly the color of PRO version of Unity.

        Greenstyle.fontStyle = FontStyle.Bold;
        style.fontStyle = FontStyle.Bold;

        GUILayout.Space(10f); //<-- adds a little space at the top of the GUI.

        if (_LushLODTree.TreesManager == null ||
            ReferenceEquals(_LushLODTree.TreesManager, null) ||
            _LushLODTree.TreesManager.Equals(null))
        {
            //Set the tree's global, static reference to this manager, if it isn't already set.
            _LushLODTree.TreesManager = (_LushLODTreesManager)this.target;
        }

        if (Camera.main == null ||
            ReferenceEquals(Camera.main, null) == true)
        {
            GUILayout.Label("Setup Needed:", BoldStyle);
            GUILayout.Box("You have no main camera enabled. Please enable a camera.", Redstyle);
            return;
        }

        if (_LushLODTree.TreesManager.TreesRoot == null ||
            ReferenceEquals(_LushLODTree.TreesManager.TreesRoot, null) ||
            _LushLODTree.TreesManager.TreesRoot.Equals(null))
        {
            //The user hasn't drag/dropped the TreesRoot gameobject into the manager.
            //So tell them to do that:
            GUILayout.Label("Setup Needed:", BoldStyle);
            GUILayout.Box("You haven't set up your TreesRoot yet. Please add trees to your scene as needed, and group them all into a single parent gameobject in your Hierarchy (if they arent already), and drag that gameobject into the TreesRoot box (found below) to continue. If you need help doing this, please just click the button below and I'll do it for you.", Redstyle);

            if (GUILayout.Button("Setup Trees Root", style))
            {
                string Desc = "Created Trees Root";
                GameObject NewTreesRoot = new GameObject("TreesRoot");

                //WE NEED TO GET THE ENABLEUNDO variable before we can continue...
                EnableUndo = serializedObject.FindProperty("EnableUndo");
                serializedObject.ApplyModifiedProperties(); //<-- this is a builtin Unity function.

                if (Application.isPlaying == false && EnableUndo.boolValue == true)
                {
                    Undo.RegisterCompleteObjectUndo(_LushLODTree.TreesManager.gameObject, Desc);
                    Undo.RecordObject(_LushLODTree.TreesManager, Desc);
                    Undo.RegisterCreatedObjectUndo(NewTreesRoot, Desc);
                }

                ((_LushLODTreesManager)this.target).TreesRoot = NewTreesRoot;
                _LushLODTree.TreesManager.RootAllTrees();
                return;
            }
        }
        else if (_LushLODTree.TreesManager.AllParents == null ||
                 ReferenceEquals(_LushLODTree.TreesManager.AllParents, null) ||
                 _LushLODTree.TreesManager.AllParents.Count == 0)
        {
            //The user hasn't calculated the parents yet.
            //So tell them to do that:
            GUILayout.Label("Setup Needed:", BoldStyle);

            if (GUILayout.Button("Root All Trees"))
                _LushLODTree.TreesManager.RootAllTrees(); //<-- helper function to find all trees in the scene, and move them to the trees root.
            GUILayout.Box("The above button will find all _LushLODTree's in the scene, and move them to the TreesRoot gameobject. Use this button if, for example, you spawned your trees with a tool such as Gaia.", RegularStyleBox);

            if (GUILayout.Button("Calculate Parents"))
                _LushLODTree.TreesManager.ReCalculateParents(true); //<-- hover mouse to see description.
            GUILayout.Box("You must calculate parent trees, by clicking the above button. Nearyby trees will become children to the closest parent tree. To improve framerate, only the parent trees will measure their distance to the camera every few frames. If the camera comes close, the parent will activate all their children.", Redstyle);
            GUILayout.Box("Note: You need to click the above button to continue the setup.", Redstyle);
        }
        else
        {

            if (_LushLODTree.TreesManager.should_recalculate_parents)
            {
                _LushLODTree.TreesManager.should_recalculate_parents = false;
                _LushLODTree.TreesManager.OnDestroyParent();
            }

            //The user has finished calculating parents.
            if (setupFinished == false || OnEnableNeeded == true)
            {
                setupFinished = true; //<-- hover mouse to see description.

                if (_LushLODTree.TreesManager == null ||
                    ReferenceEquals(_LushLODTree.TreesManager, null) ||
                    _LushLODTree.TreesManager.Equals(null))
                {
                    //Set the tree's global, static reference to this manager, if it isn't already set.
                    _LushLODTree.TreesManager = (_LushLODTreesManager)this.target;
                }

                //Loop through every tree:
                _LushLODTree[] allTrees = _LushLODTree.TreesManager.TreesRoot.GetComponentsInChildren<_LushLODTree>();
                foreach (_LushLODTree tree in allTrees)
                {
                    //Ensure that the trees have a link to this manager.
                    tree.TreesManager_ref = (_LushLODTreesManager)this.target;

#if UNITY_EDITOR
                    EditorUtility.SetDirty(tree);
#endif
                }

                OnEnable(); //<-- force a call to the OnEnable(),
                            //since up till now, it hasn't been able to run OnEnable(), 
                            //because setFinished was false until now.
            }

            if (setupFinished == true)
            {
                //Setup our initial ambient light.
                if (ambientColor.colorValue == Color.clear)
                {
                    if (RenderSettings.ambientMode == UnityEngine.Rendering.AmbientMode.Flat)
                    {
                        ambientColor.colorValue = RenderSettings.ambientLight;
                    }
                    else if (RenderSettings.ambientMode == UnityEngine.Rendering.AmbientMode.Trilight)
                    {
                        ambientColor.colorValue = ((RenderSettings.ambientSkyColor + RenderSettings.ambientGroundColor + RenderSettings.ambientEquatorColor) / 3);
                    }
                    else if (RenderSettings.ambientLight != Color.clear)
                    {
                        ambientColor.colorValue = RenderSettings.ambientLight;
                    }
                    else
                    {
                        ambientColor.colorValue = new Color(0.3f, 0.3f, 0.3f, 1f);
                    }
                    AmbientChanged = false;
                    // Apply changes to the serializedProperty - always do this in the end of OnInspectorGUI.
                    serializedObject.ApplyModifiedProperties();
                    // Apply change:
                    _LushLODTree.TreesManager.ApplyAll();
                }
            }

            //Get a reference to the main directional light:
            Light TheLight = ((_LushLODTreesManager)MainDirectionalLight.serializedObject.targetObject).MainDirectionalLight;

            if (TheLight == null || TheLight.Equals(null) || ReferenceEquals(TheLight, null))
            {
                GUILayout.Label("Setup Needed:", BoldStyle);
                EditorGUILayout.PropertyField(MainDirectionalLight, new GUIContent("Main Directional Light"));
                GUILayout.Box("Drag and drop your main directional light from your Hierarchy into the slot above. If your scene has multiple directional lights, pick whichever one you want to be your \"main\" one.", Redstyle);
                // Apply changes to the serializedProperty - always do this in the end of OnInspectorGUI.
                serializedObject.ApplyModifiedProperties();
                return;
            }

            if (Application.isPlaying && ShadowBakingReady.boolValue == true)
            {
                GUILayout.Box("Warning! You started the game while in Shadow Baking mode. You might want to stop the game and turn off shadow baking mode!", Redstyle);

                if (warnedaboutshadowmode == false)
                {
                    warnedaboutshadowmode = true; //<-- hover mouse to see description.
                    UnityEngine.Debug.LogWarning("Warning! You started the game while in Shadow Baking mode. You might want to stop the game and turn off shadow baking mode by going to _LushLODTreesManager in your Hierarchy, and clicking the button to finish shadow baking.");
                }

                return;
            }
            else if (ShadowBakingReady.boolValue == true)
            {
                if (GUILayout.Button("Finished Shadow Baking"))
                {

                    //Turn off shadow baking mode.
                    _LushLODTree.TreesManager.ShadowBaking(false);
                    serializedObject.Update();
                    ShadowBakingReady.boolValue = false;

                    //When we exit shadow baking mode, the trees really ought to appear as high quality, or else the user might freak out and think something went wrong with their trees:
                    PreviewMode.enumValueIndex = (int)_LushLODTreesManager.previewMode.HighQuality;
                    PreviewMode_PREVIOUS.enumValueIndex = (int)_LushLODTreesManager.previewMode.HighQuality;

                    // Apply changes to the serializedProperty - always do this in the end of OnInspectorGUI.
                    serializedObject.ApplyModifiedProperties();
                    // Apply change:
                    _LushLODTree.TreesManager.UpdateTreesPreview(null, true, false);
                }
                GUILayout.Box("Your tree shadows are ready to be baked. Use the options under Window -> Lighting to bake the shadows as needed. You'll still need to properly set up your lighting and other settings for this to work correctly. Please see the documentation for further steps you may need to take. When you are finished, click the button above to turn off shadow baking mode.", RegularStyleBox);

                return;
            }
            warnedaboutshadowmode = false; //<-- hover mouse to see description.

            GUILayout.Label("Tree Parents:", BoldStyle);
            if (Application.isPlaying == true)
            {
                GUILayout.Box("Note: Tree parent changes are not saved while the game is running.", Orangestyle);
            }

            if (GUILayout.Button("Re-Calculate Parents"))
                _LushLODTree.TreesManager.ReCalculateParents(true);
            GUILayout.Box("The above button will re-build the list of parent trees. Click this button anytime you add or remove trees from the scene, and anytime you make any changes affecting the global position or scale of any tree in your scene. Learn more about parent trees in the documentation.", RegularStyleBox);

            if (GUILayout.Button("Root All Trees"))
                _LushLODTree.TreesManager.RootAllTrees(); //<-- helper function to find all trees in the scene, and move them to the trees root.
            GUILayout.Box("The above button will find all _LushLODTree's in the scene, and move them to the TreesRoot gameobject. Use this button if, for example, you spawned your trees with a tool such as Gaia.", RegularStyleBox);


            //COLORS:
            GUILayout.Space(10f);
            GUILayout.Label("Colors:", BoldStyle);

            if (Application.isPlaying == true)
            {
                GUILayout.Box("Note: Color changes are not saved while the game is running.", Orangestyle);
            }

            if (!(RenderSettings.ambientMode == UnityEngine.Rendering.AmbientMode.Flat) &&
                !(RenderSettings.ambientMode == UnityEngine.Rendering.AmbientMode.Trilight))
            {
                //The user has selected something other than "color" for their environment light mode.
                //Unfortunantly, the billboard trees can't get data for environment probe lights (needed for skybox environment mode).
                //This seems to be a limitation in Unity? Or am I missing something?
                //Warn the user that the environment mode needs to either be set to "color", or else
                //they will probably need to tweak the color of the billboards to make them look right.
                GUILayout.Box("Warning: You using something other than \"Color\" or \"Gradient\" for your environment light source. You may need to adjust your \"Color LQ\" setting (below) to get the billboards to match the color of the high quality tree models.", BoldRedstyle);
                if (GUILayout.Button("Check Environment Light Settings", BoldRedstyleButton))
                {
                    //RenderSettings.ambientMode = UnityEngine.Rendering.AmbientMode.Flat;
                    //RenderSettings.ambientLight = Color.white;
                    //RenderSettings.ambientIntensity = 1f;
                    UnityEditor.EditorApplication.ExecuteMenuItem("Window/Lighting/Settings");
                    EditorUtility.DisplayDialog("Window/Lighting Opened", "The Lighting Window (\"Window->Lighting\") has been opened.", "Okay");
                }
                GUILayout.Space(10f);
            }


            EditorGUILayout.PropertyField(mainColor_HQTrees, new GUIContent("Color HQ"));
            EditorGUILayout.PropertyField(mainColor_LQTrees, new GUIContent("Color LQ"));
            GUILayout.Box("The above color values will be blended as Linear Light to the tree's original _MainColor value. So to darken the trees, reduce the color values below 50% gray. To brighten, increase them above 50% gray.", RegularStyleBox);
            if (GUILayout.Button("Reset Colors"))
            {
                mainColor_HQTrees.colorValue = new Color(0.5f, 0.5f, 0.5f, 0.5f);
                mainColor_LQTrees.colorValue = new Color(0.5f, 0.5f, 0.5f, 0.5f);
                DoColorReset.boolValue = true;
            }
            GUILayout.Space(10f);

            GUILayout.Label("Ambient Light:", BoldStyle);
            EditorGUILayout.PropertyField(ambientColor, new GUIContent("Ambient Color"));

            GUIStyle AmbientUpdateStyle = style;
            AmbientUpdateStyle.fontStyle = FontStyle.Normal;
            if (RenderSettings.ambientMode == UnityEngine.Rendering.AmbientMode.Flat)
            {
                TestAmbientColor = RenderSettings.ambientLight;
            }
            else if (RenderSettings.ambientMode == UnityEngine.Rendering.AmbientMode.Trilight)
            {
                TestAmbientColor = ((RenderSettings.ambientSkyColor + RenderSettings.ambientGroundColor + RenderSettings.ambientEquatorColor) / 3);
            }
            else if (RenderSettings.ambientLight != Color.clear)
            {
                TestAmbientColor = RenderSettings.ambientLight;
            }
            else
            {
                TestAmbientColor = new Color(0.3f, 0.3f, 0.3f, 1f);
            }

            //To avoid making changes to the GUI outside of the layout event (which creates errors), we
            //need to check to ensure that we are in the layout event, before we make some of the layout changes
            //we are about to make:
            if (Event.current.type == EventType.Layout)
            {
                if (ambientColor.colorValue == ambientColor_PREVIOUS.colorValue)
                {
                    AmbientChanged = false;
                }
                else
                {
                    AmbientChanged = true;
                }
                if (TestAmbientColor == ambientColor.colorValue)
                {
                    AmbientDifferent = false;
                }
                else
                {
                    AmbientDifferent = true;
                }
            }


            if (AmbientChanged == false)
            {
                if (AmbientDifferent == true)
                {
                    AmbientUpdateStyle = BoldRedstyleButton;
                    AmbientUpdateStyle.normal.textColor = new Color(1f, 0.6f, 0.2f);
                    GUILayout.Box("Warning: The ambient color shown above may not match the color of your current environment's ambient light. This is not an error (you are allowed to do this). However, the trees may not match the scene's ambient color. See options below for possible solutions.", Orangestyle);

                    if (GUILayout.Button("Open Lighting Wndow...", AmbientUpdateStyle))
                    {
                        UnityEditor.EditorApplication.ExecuteMenuItem("Window/Lighting/Settings");
                    }
                }
            }
            else
            {
                GUILayout.Box("Don't forget to click \"Apply All\" button near the bottom of this widow, or else your changes will not be saved permanently.", BoldRedstyle);

                if (AmbientDifferent == true)
                {
                    AmbientUpdateStyle = BoldRedstyleButton;
                    AmbientUpdateStyle.normal.textColor = new Color(1f, 0.6f, 0.2f);
                    GUILayout.Box("Warning: The ambient color shown above may not match the color of your current environment's ambient light. This is not an error (you are allowed to do this). However, the trees may not match the scene's ambient color. See options below for possible solutions.", Orangestyle);

                    if (GUILayout.Button("Open Lighting Wndow...", AmbientUpdateStyle))
                    {
                        UnityEditor.EditorApplication.ExecuteMenuItem("Window/Lighting/Settings");
                    }
                }
            }

            if (GUILayout.Button("Update Ambient Color", AmbientUpdateStyle))
            {
                ambientColor.colorValue = TestAmbientColor;
                // Apply changes to the serializedProperty - always do this in the end of OnInspectorGUI.
                serializedObject.ApplyModifiedProperties();
                // Apply change:
                _LushLODTree.TreesManager.ApplyAll();

                if (RenderSettings.ambientMode == UnityEngine.Rendering.AmbientMode.Trilight)
                {
                    EditorUtility.DisplayDialog("Trilight Ambient", "Your current environment is set to use three colors (otherwise called a \"Trilight\") for its ambient light color. LushLOD Trees only support a single ambient light color, so we've automatically created an average of the three ambient colors from your environment.", "Okay");
                }

                EditorUtility.DisplayDialog("Window/Lighting Opened", "The Lighting Window (\"Window->Lighting\") has also been opened, so you can take a look at your environment's ambient light if you wish.", "Okay");
                UnityEditor.EditorApplication.ExecuteMenuItem("Window/Lighting/Settings");
            }


            GUILayout.Space(10f);

            //QUaLITY:
            GUILayout.Label("Quality:", BoldStyle);

            if (Application.isPlaying == true)
            {
                GUILayout.Box("Note: Quality changes are not saved while the game is running.", Orangestyle);
            }

            GUILayout.BeginHorizontal();
            GUILayout.Label("LOD Distance (" + LOD_adjust.floatValue + ")", BoldStyle);
            LOD_adjust.floatValue = Mathf.RoundToInt(GUILayout.HorizontalSlider(LOD_adjust.floatValue, 10f, 500f));
            
            GUILayout.EndHorizontal();

            if (Application.isPlaying == false)
            {
                GUILayout.Box("The above slider will set the distance where the billboards transition in and out. Higher values may look better, but they may reduce the framerate. Default is " + _LushLODTreesManager.DefaultLodDistance + ". NOTE: Changing this triggers a full recalculation of parents.", RegularStyleBox);
            }
            else
            {
                GUILayout.Box("The above slider will set the distance where the billboards transition in and out. Higher values may look better, but they may reduce the framerate. Default is " + _LushLODTreesManager.DefaultLodDistance + ". NOTE: Changing this triggers a full recalculation of parents, which may cause the game to freeze up momentarily.", RegularStyleBox);
            }

            EditorGUILayout.PropertyField(BillBoardSetting, new GUIContent("BillBoard Setting"));

            switch (BillBoardSetting.enumValueIndex)
            {
                case (int)_LushLODTreesManager.BillBoardSettings.UseBoth:
                    GUILayout.Box("Use Both will smoothly transitions between the billboards and the high quality tree models as the camera gets closer. This is the default option.", RegularStyleBox);
                    break;
                case (int)_LushLODTreesManager.BillBoardSettings.BillboardsOnly:
                    GUILayout.Box("Billboards Only will cause only the billboards to be displayed, even when the camera is very close. Also the script responsibile for billboard transitions will be turned off. This is the best option for fastest frame rates. Consider using this option for mobile games, flight sims or race car games.", RegularStyleBox);
                    break;
                case (int)_LushLODTreesManager.BillBoardSettings.HighQualityModelsOnly:
                    GUILayout.Box("High Quality Models Only will cause only the high quality tree models will be displayed, and the billboards will be turned off. Also the script responsible for billboard transitions will be turned off. This is the most expensive option and it is not recommended.", RegularStyleBox);
                    if (RealTimeShadowSetting.enumValueIndex == (int)_LushLODTreesManager.RealTimeShadowSettings.BillboardOnly)
                    {
                        GUILayout.Box("WARNING: Billboards cannot cast any shadows in this mode. Check your selection for \"Cast Shadows\" below.", Redstyle);
                    }
                    break;
            }


            EditorGUILayout.PropertyField(RenderingMode, new GUIContent("Rendering Mode:"));
            int secondsSinceEpoch2 = (int)(System.DateTime.UtcNow - new System.DateTime(2016, 1, 1)).TotalSeconds;
            switch (RenderingMode.enumValueIndex)
            {
                case (int)_LushLODTreesManager.RenderingModes.Forward:
                    //This just gets the total number of seconds since 1970;
                    if (secondsSinceEpoch2 > timeSkip_checkRenderingPath)
                    {
                        timeSkip_checkRenderingPath = secondsSinceEpoch2 + 1;
                        RenderingPath checkit = Camera.main.actualRenderingPath;
                        UnityEditor.Rendering.TierSettings checkit2 = new UnityEditor.Rendering.TierSettings();
                        if (checkit == RenderingPath.Forward ||
                            (checkit == RenderingPath.UsePlayerSettings && checkit2.renderingPath == RenderingPath.Forward))
                        {
                            GUILayout.Box("Your main camera is set to Forward rendering.", RegularStyleBox);
                            CameraIsUsingForward = true;
                        }
                        else
                        {
                            GUILayout.Box("Warning: Your main camera is not rendering in Forward mode, but your manager is set to use Forward rendering. This may cause unwanted glitches in the trees.", Redstyle);
                            CameraIsUsingForward = false;
                        }
                    }
                    else {
                        if (CameraIsUsingForward == true)
                        {
                            GUILayout.Box("Your main camera is set to Forward rendering.", RegularStyleBox);
                        }
                        else
                        {
                            GUILayout.Box("Warning: Your main camera is not rendering in Forward mode, but your manager is set to use Forward rendering. This may cause unwanted glitches in the trees.", Redstyle);
                        }
                    }
                    break;
                case (int)_LushLODTreesManager.RenderingModes.Deferred:
                    //This just gets the total number of seconds since 1970;
                    if (secondsSinceEpoch2 > timeSkip_checkRenderingPath)
                    {
                        timeSkip_checkRenderingPath = secondsSinceEpoch2 + 1;
                        RenderingPath checkit = Camera.main.actualRenderingPath;
                        UnityEditor.Rendering.TierSettings checkit2 = new UnityEditor.Rendering.TierSettings();
                        if (checkit != RenderingPath.Forward ||
                            (checkit == RenderingPath.UsePlayerSettings && checkit2.renderingPath != RenderingPath.Forward))
                        {
                            GUILayout.Box("Your main camera is set to Deferred rendering.", RegularStyleBox);
                            CameraIsUsingForward = false;
                        }
                        else
                        {
                            GUILayout.Box("Warning: Your main camera is not rendering in Deferred mode, but your manager is set to use Deferred rendering. This may cause unwanted glitches in the trees.", Redstyle);
                            CameraIsUsingForward = true;
                        }
                    } else {
                        if (CameraIsUsingForward == false)
                        {
                            GUILayout.Box("Your main camera is set to Deferred rendering.", RegularStyleBox);
                        }
                        else
                        {
                            GUILayout.Box("Warning: Your main camera is not rendering in Deferred mode, but your manager is set to use Deferred rendering. This may cause unwanted glitches in the trees.", Redstyle);
                        }
                    }
                    break;
            }

            GUILayout.Space(10f);//

            //switch (RenderingMode.enumValueIndex)
            //{
            //    case (int)_LushLODTreesManager.RenderingModes.Forward:
            //        GUILayout.Box("Blah blah blah.");
            //        break;
            //    case (int)_LushLODTreesManager.RenderingModes.Deferred:
            //        GUILayout.Box("Blah blah blah.");
            //        break;
            //}

            //billboard_quality
            GUILayout.BeginHorizontal();
            GUILayout.Label("Billboard Quality (" + new string[] { "Low", "Medium", "Great", "Ultra" }[Mathf.RoundToInt(billboard_quality.enumValueIndex)] + ")", BoldStyle);
            billboard_quality.enumValueIndex = Mathf.RoundToInt(GUILayout.HorizontalSlider(billboard_quality.enumValueIndex, 0f, 3f));
            GUILayout.EndHorizontal();

            switch (billboard_quality.enumValueIndex)
            {
                case (int)_LushLODTreesManager.BillboardQualitySettings.Low:
                    GUILayout.Box("Low quality is the fastest option. It turns off most corrections and quality improvements for the billboards, which gives the billboards a very faceted look.", RegularStyleBox);
                    break;
                case (int)_LushLODTreesManager.BillboardQualitySettings.Medium:
                    GUILayout.Box("Medium quality performs angular correction, which hides the billboard faces that are angled permendicular to the camera. This greatly diminishes the appearance of sharp lines near the center of the billboards.", RegularStyleBox);
                    break;
                case (int)_LushLODTreesManager.BillboardQualitySettings.Great:
                    GUILayout.Box("Great quality will perform angular correction, and also cause the shader to blend the seams where the billboards intersect, and it is very fast.", RegularStyleBox);
                    break;
                case (int)_LushLODTreesManager.BillboardQualitySettings.Ultra:
                    GUILayout.Box("Ultra quality is the most expensive. It will blend seams where the billboards intersect, and also uses a full screen post-processing effect to create realistic transparency in the trees and smoother transitions.", RegularStyleBox);
                    //This just gets the total number of seconds since 1970;
                    int secondsSinceEpoch = (int)(System.DateTime.UtcNow - new System.DateTime(2016, 1, 1)).TotalSeconds;
                    if (secondsSinceEpoch > timeSkip_checkPostProcessor)
                    {
                        timeSkip_checkPostProcessor = secondsSinceEpoch + 1;
                        _LushLODPostProcessor checkit = Camera.main.GetComponent<_LushLODPostProcessor>();
                        if (checkit == null ||
                            ReferenceEquals(checkit, null) ||
                            checkit.Equals(null))
                        {
                            MissingPostProcess = true;
                            GUILayout.Box("Warning: Ultra Quality requires that you attach the _LushLODPostProcessor.cs script to your main camera. If you do not attach this script, your trees will look ugly. Please see the documentation if you need help with this.", Redstyle);
                        }
                        else
                        {
                            MissingPostProcess = false;
                        }
                    }
                    else
                    {
                        if (MissingPostProcess)
                        {
                            GUILayout.Box("Warning: Ultra Quality requires that you attach the _LushLODPostProcessor.cs script to your main camera. If you do not attach this script, your trees will look ugly. Please see the documentation if you need help with this.", Redstyle);
                        }
                    }

                    if (BillBoardSetting.enumValueIndex == (int)_LushLODTreesManager.BillBoardSettings.HighQualityModelsOnly &&
                        BillBoardSetting_PREVIOUS.enumValueIndex == (int)_LushLODTreesManager.BillBoardSettings.HighQualityModelsOnly)
                    {
                        GUILayout.Box("WARNING: You are displaying high quality tree models only, so you should set your billboard quality to something less than \"Ultra\". Having billboards set to ultra will also cause the high quality tree models to use the Ultra quality shader, and also cases the Ultra-quality post-processing effect to be run, which supports beautiful billboard transitions but it is a waste of processing power if you are only displaying the high quality tree models.", Redstyle);

                        GUILayout.Space(10f);
                        if (GUILayout.Button("Fix This", BoldRedstyleButton))
                        {
                            billboard_quality.enumValueIndex = (int)_LushLODTreesManager.BillboardQualitySettings.Great;
                            // Apply changes to the serializedProperty - always do this in the end of OnInspectorGUI.
                            serializedObject.ApplyModifiedProperties();
                            // Apply change:
                            _LushLODTree.TreesManager.ApplyAll();
                        }
                        GUILayout.Space(10f);
                    }

                    if (Application.isPlaying == false && !MissingPostProcess)
                    {
                        GUILayout.Box("Note: The post processing effect only works when the game is running.", RegularStyleBox);
                    }

                    break;
            }

            //RealTimeShadowSetting
            GUILayout.Space(10f);//
            GUILayout.Label("Realtime Shadows:", BoldStyle);

            if (Application.isPlaying == true)
            {
                GUILayout.Box("Note: Realtime Shadow changes are not saved while the game is running.", Orangestyle);
            }

            EditorGUILayout.PropertyField(RealTimeShadowSetting, new GUIContent("Cast Shadows:"));

            switch (RealTimeShadowSetting.enumValueIndex)
            {
                case (int)_LushLODTreesManager.RealTimeShadowSettings.UseBoth:
                    GUILayout.Box("Use Both will cause the High Quality tree models to cast shadows when the trees are close to the camera, and the Billboards (if they are enabled) will cast the shadows when the trees are far away from the camera.", RegularStyleBox);
                    if (!(TheLight == null || TheLight.Equals(null) || ReferenceEquals(TheLight, null)))
                    {
                        if (TheLight.bakingOutput.isBaked)
                        {
                            GUILayout.Box("Note: If you are using baked shadows, this option will not do anything.", Redstyle);
                        }
                    }
                    if ((CameraIsUsingForward == false || RenderingMode.enumValueIndex == (int)_LushLODTreesManager.RenderingModes.Deferred) &&
                        billboard_quality.enumValueIndex == (int)_LushLODTreesManager.BillboardQualitySettings.Ultra &&
                        BillBoardSetting.enumValueIndex == (int)_LushLODTreesManager.BillBoardSettings.UseBoth)
                    {
                        GUILayout.Box("WARNING: Sorry, but realtime shadow casting doesn't work correctly on Ultra quality with Deferred rendering mode. This is due to limitations in Deferred rendering's shadow alpha clipping. If you wish to cast realtime shadows on Ultra quality, you will need to switch to Forward rendering mode. Otherwise, to cast shadows using Deferred rendering on Ultra quality, you'll need to bake your tree's casted shadows and then turn realtime shadows off. Please see the documentation for instructions on how to bake your casted shadows.", Redstyle);
                    }
                    break;
                case (int)_LushLODTreesManager.RealTimeShadowSettings.BillboardOnly:
                    GUILayout.Box("Billboard Only will cause only the billboards to cast shadows, even when the trees are close to the camera. This helps improve the speed of the real time shadows.", RegularStyleBox);
                    if (!(TheLight == null || TheLight.Equals(null) || ReferenceEquals(TheLight, null)))
                    {
                        if (TheLight.bakingOutput.isBaked)
                        {
                            GUILayout.Box("Note: If you are using baked shadows, this option will not do anything.", Redstyle);
                        }
                    }
                    if (BillBoardSetting.enumValueIndex == (int)_LushLODTreesManager.BillBoardSettings.HighQualityModelsOnly)
                    {
                        GUILayout.Box("WARNING: Billboards cannot cast any shadows because you turned billboards off in your billboard settings. Check your selection for \"Billboard Setting\" above.", Redstyle);
                    }
                    if ((CameraIsUsingForward == false || RenderingMode.enumValueIndex == (int)_LushLODTreesManager.RenderingModes.Deferred) &&
                        BillBoardSetting.enumValueIndex == (int)_LushLODTreesManager.BillBoardSettings.UseBoth)
                    {
                        GUILayout.Box("WARNING: Billboards Only shadow casting mode doesn't work in deferred rendering (the billboards will NOT transition correctly!). Please switch to Forward rendering, or pick a different shadow casting mode!", Redstyle);
                    }
                    if ((CameraIsUsingForward == false || RenderingMode.enumValueIndex == (int)_LushLODTreesManager.RenderingModes.Deferred) &&
                        billboard_quality.enumValueIndex == (int)_LushLODTreesManager.BillboardQualitySettings.Ultra &&
                        BillBoardSetting.enumValueIndex == (int)_LushLODTreesManager.BillBoardSettings.UseBoth)
                    {
                        GUILayout.Box("WARNING: Sorry, but realtime shadow casting doesn't transition correctly on Ultra quality with Deferred rendering mode. This is due to limitations in Deferred rendering's shadow alpha clipping. If you wish to cast transitioning realtime shadows on Ultra quality, you will need to switch to Forward rendering mode. Otherwise, to cast shadows using Deferred rendering on Ultra quality, you can bake your tree's casted shadows and then turn realtime shadows off. Please see the documentation for instructions on how to bake your casted shadows. Note that this limitation does not negatively affect shadows received by the trees, only shadows cast by the trees.", Redstyle);
                    }
                    break;
                case (int)_LushLODTreesManager.RealTimeShadowSettings.RealtimeShadowsOff:
                    GUILayout.Box("Realtime Shadows Off will cause realtime shadows to be turned off. Use this setting if you have baked your shadows, or you don't want your trees to cast any shadows at all.", RegularStyleBox);
                    break;
            }

            EditorGUILayout.PropertyField(ShadowReceiveSetting, new GUIContent("Receive Shadows:"));

            switch (ShadowReceiveSetting.enumValueIndex)
            {
                case (int)_LushLODTreesManager.ShadowReceiveSettings.AllShadows:
                    GUILayout.Box("All Shadows is the most expensive option, and uses Unity's built in shadow system to receive shadows from all objects in the scene. Note: This mode only activates when the game is running.", RegularStyleBox);
                    GUILayout.BeginHorizontal();
                    GUILayout.Label("Billboard Sunset / Sunrise Awareness (" + TimeOfDay.floatValue + ")");
                    TimeOfDay.floatValue = float.Parse(GUILayout.HorizontalSlider(TimeOfDay.floatValue, 0f, 1f).ToString("#0.00"));
                    GUILayout.EndHorizontal();
                    GUILayout.BeginHorizontal();
                    GUILayout.Label("Shadow Clip (" + ShadowClip.floatValue + ")");
                    ShadowClip.floatValue = float.Parse(GUILayout.HorizontalSlider(ShadowClip.floatValue, 0f, 1f).ToString("#0.00"));
                    GUILayout.EndHorizontal();
                    if (!(TheLight == null || TheLight.Equals(null) || ReferenceEquals(TheLight, null)))
                    {
                        if (TheLight.bakingOutput.isBaked)
                        {
                            GUILayout.Box("WARNING: Your main light is baked. All Shadows mode probably won't look right unless you included your trees as static objects in your bake (which isn't common). You may see better results by switching to Simple Shadows mode.", BoldRedstyle);
                        }
                    }
                   if (RealTimeShadowSetting.enumValueIndex != (int)_LushLODTreesManager.RealTimeShadowSettings.RealtimeShadowsOff)
                        GUILayout.Box("WARNING: The billboards will cast shadows onto the high quality tree models in All Shadows mode, which may create dark lines across your trees. Check the forum to discuss possible work-arounds for this issue.", Redstyle);
                    break;
                case (int)_LushLODTreesManager.ShadowReceiveSettings.SimpleShadows:
                    GUILayout.Box("Simple Shadows uses fully baked shadow maps to enable the high quality trees to cast and receive shadows upon themselves, and it is very fast. But they will not receive shadows from other trees, nor from any other objects such as clouds. It is possible to manually darken the trees and create additional shadow-like effects that would work in this mode, see the forum to discuss ideas. This is the default option.", RegularStyleBox);
                    break;
                case (int)_LushLODTreesManager.ShadowReceiveSettings.NoShadows:
                    GUILayout.Box("Shadows will not be received by the trees at all. This can be used to create cartoon-like effects. Note: This mode only activates when the game is running.", RegularStyleBox);
                    GUILayout.BeginHorizontal();
                    GUILayout.Label("Billboard Sunset / Sunrise Awareness (" + TimeOfDay.floatValue + ")");
                    TimeOfDay.floatValue = float.Parse(GUILayout.HorizontalSlider(TimeOfDay.floatValue, 0f, 1f).ToString("#0.00"));
                    GUILayout.EndHorizontal();
                    GUILayout.BeginHorizontal();
                    GUILayout.Label("Billboard Shadow Clip (" + ShadowClip.floatValue + ")");
                    ShadowClip.floatValue = float.Parse(GUILayout.HorizontalSlider(ShadowClip.floatValue, 0f, 1f).ToString("#0.00"));
                    GUILayout.EndHorizontal();
                    if (!(TheLight == null || TheLight.Equals(null) || ReferenceEquals(TheLight, null)))
                    {
                        if (TheLight.bakingOutput.isBaked)
                        {
                            GUILayout.Box("WARNING: Your main light is baked. No Shadows mode uses Unity's builtin tree shader, which expects real lighting data that probably won't exist unless you included your trees as static objects in your bake (which isn't common). You may see better results by switching to Simple Shadows mode.", BoldRedstyle);
                        }
                    }
                    break;
            }


            if (ShadowReceiveSetting.enumValueIndex != (int)_LushLODTreesManager.ShadowReceiveSettings.SimpleShadows &&                
                billboard_quality.enumValueIndex == (int)_LushLODTreesManager.BillboardQualitySettings.Ultra &&
                BillBoardSetting.enumValueIndex != (int)_LushLODTreesManager.BillBoardSettings.BillboardsOnly)
            {
                billboard_quality.enumValueIndex = (int)_LushLODTreesManager.BillboardQualitySettings.Great;
                EditorUtility.DisplayDialog("Not Supported Yet", "In this beta version, the Ultra quality level currently only supports Simple Shadows mode. Expect this to be fixed soon. For now, if you wish to use Ultra quality, you must use Simple Shadows.", "Okay");
            }
 
            if (_LushLODTree.TreesManager.UsingFastShader(_LushLODTree.TreesManager.FirstTreeFound) == true &&
                billboard_quality.enumValueIndex == (int)_LushLODTreesManager.BillboardQualitySettings.Ultra &&
                BillBoardSetting.enumValueIndex != (int)_LushLODTreesManager.BillBoardSettings.BillboardsOnly)
            {
                billboard_quality.enumValueIndex = (int)_LushLODTreesManager.BillboardQualitySettings.Great;
                EditorUtility.DisplayDialog("Not Supported Yet", "In this beta version, the Ultra quality level currently does not support the TreeCreatorLeavesFAST or TreeCreatorBarkFAST shaders. Only the non-fast shaders are supported. Expect this to be fixed soon. For now, if you wish to use Ultra quality, you must ensure that no parts of any of your Unity trees are using any of Unity's \"Fast\" Tree shaders. This needs to be done prior to converting your trees to LushLOD trees, and cannot be done after conversion. You can easily upgrade your scene to use the new trees after you re-convert them (All LushLOD trees in your scene have an upgrade button).", "Okay");
            }

            if (ShadowReceiveSetting.enumValueIndex == (int)_LushLODTreesManager.ShadowReceiveSettings.SimpleShadows)
            {
                GUILayout.Label("Simple Shadows Advanced Settings:", BoldStyle);

                if (GUILayout.Button("Reset Simple Shadow Advanced Settings", style))
                {
                    if (EditorUtility.DisplayDialog("Please confirm", "Are you sure you want to reset the Simple Shadows Advanced settings to their default values? This only affects the Simple Shadows.", "Yes", "No"))
                    {
                        string Desc = "Created Trees Root";
                        GameObject NewTreesRoot = new GameObject("TreesRoot");

                        //WE NEED TO GET THE ENABLEUNDO variable before we can continue...
                        EnableUndo = serializedObject.FindProperty("EnableUndo");
                        serializedObject.ApplyModifiedProperties(); //<-- this is a builtin Unity function.

                        if (Application.isPlaying == false && EnableUndo.boolValue == true)
                        {
                            Undo.RegisterCompleteObjectUndo(_LushLODTree.TreesManager.gameObject, Desc);
                            Undo.RecordObject(_LushLODTree.TreesManager, Desc);
                            Undo.RegisterCreatedObjectUndo(NewTreesRoot, Desc);
                        }

                        ShadowContrast.floatValue = 2.0f;
                        TimeOfDay.floatValue = 1.0f;
                        Translucency.floatValue = 0.5f;
                        TranslucencySharpen.floatValue = 0f;
                        ShadowClip.floatValue = 1f;
                        AmbientOcclusion.floatValue = 1f;
                        ShadowSize.floatValue = 0f;
                    }
                }
                GUILayout.BeginHorizontal();
                
                //GUILayout.Label("Ambient Occlusion (" + AmbientOcclusion.floatValue + ")");
                //AmbientOcclusion.floatValue = float.Parse(GUILayout.HorizontalSlider(AmbientOcclusion.floatValue, 0f, 2f).ToString("#0.00"));

                EditorGUILayout.Slider(AmbientOcclusion, 0f, 2f, "Ambient Occlusion");
                
                GUILayout.EndHorizontal();
                GUILayout.BeginHorizontal();
                //GUILayout.Label("Sunset / Sunrise Awareness (" + TimeOfDay.floatValue + ")");
                //TimeOfDay.floatValue = float.Parse(GUILayout.HorizontalSlider(TimeOfDay.floatValue, 0f, 1f).ToString("#0.00"));

                EditorGUILayout.Slider(TimeOfDay, 0f, 1f, "Sunset / Sunrise Awareness");

                GUILayout.EndHorizontal();
                GUILayout.BeginHorizontal();
                //GUILayout.Label("Translucency (" + Translucency.floatValue + ")");
                //Translucency.floatValue = float.Parse(GUILayout.HorizontalSlider(Translucency.floatValue, 0f, 1f).ToString("#0.00"));

                EditorGUILayout.Slider(Translucency, 0f, 1f, "Translucency");

                GUILayout.EndHorizontal();
                GUILayout.BeginHorizontal();
                //GUILayout.Label("Translucency Contrast (" + TranslucencySharpen.floatValue + ")");
                //TranslucencySharpen.floatValue = float.Parse(GUILayout.HorizontalSlider(TranslucencySharpen.floatValue, 0f, 1f).ToString("#0.00"));

                EditorGUILayout.Slider(TranslucencySharpen, 0f, 1f, "Translucency Contrast");

                GUILayout.EndHorizontal();
                GUILayout.BeginHorizontal();
                //GUILayout.Label("Shadow Size (" + ShadowSize.floatValue + ")");
                //ShadowSize.floatValue = float.Parse(GUILayout.HorizontalSlider(ShadowSize.floatValue, -1f, 3f).ToString("#0.00"));

                EditorGUILayout.Slider(ShadowSize, -1f, 3f, "Shadow Size");

                GUILayout.EndHorizontal();
                if (ShadowSize.floatValue < 0f)
                {
                    GUILayout.Box("Warning: You have turned down the shadow size. This is not an error, you are allowed to do this. However, if you are trying to reduce the intensity of the shadows, you may want to use the Shadow Clip option below instead. This is because the billboard's shadows respond correctly to the Shadow Clip value, but the billboards do not respond at all to the Shadow Size.", Orangestyle);
                }
                GUILayout.BeginHorizontal();
                //GUILayout.Label("Shadow Contrast (" + ShadowContrast.floatValue + ")");
                //ShadowContrast.floatValue = float.Parse(GUILayout.HorizontalSlider(ShadowContrast.floatValue, 1f, 10f).ToString("#0.00"));

                EditorGUILayout.Slider(ShadowContrast, 1f, 10f, "Shadow Contrast");

                GUILayout.EndHorizontal();
                GUILayout.BeginHorizontal();
                //GUILayout.Label("Shadow Clip (" + ShadowClip.floatValue + ")");
                //ShadowClip.floatValue = float.Parse(GUILayout.HorizontalSlider(ShadowClip.floatValue, 0f, 1f).ToString("#0.00"));

                EditorGUILayout.Slider(ShadowClip, 0f, 1f, "Shadow Clip");

                GUILayout.EndHorizontal();

                if (ShadowSize.floatValue != ShadowSize_PREVIOUS.floatValue
                    || TranslucencySharpen.floatValue != TranslucencySharpen_PREVIOUS.floatValue
                    || ShadowClip.floatValue != ShadowClip_PREVIOUS.floatValue
                    || AmbientOcclusion.floatValue != AmbientOcclusion_PREVIOUS.floatValue
                    || ShadowContrast.floatValue != ShadowContrast_PREVIOUS.floatValue
                    || TimeOfDay.floatValue != TimeOfDay_PREVIOUS.floatValue
                    || Translucency.floatValue != Translucency_PREVIOUS.floatValue
                    )
                {
                    GUILayout.Space(10f);
                    GUILayout.Box("Don't forget to click \"Apply All\" button below, or else your changes will not be saved permanently.", BoldRedstyle);
                 }
            }


            GUILayout.Space(20f);
            GUILayout.Label("Made changes above? Be sure to apply:", BoldStyle);
            if (Application.isPlaying == false)
            {
                GUILayout.Box("Note: Some changes may not appear until you start the game.", RegularStyleBox);
            }
            if (GUILayout.Button("\nApply All\n", style))
            {
                _LushLODTree.TreesManager.ApplyAll(null, false, false, true);

                // Sometimes ApplyAll can undo the current preview setting. Put it back:
                PreviewMode_PREVIOUS.enumValueIndex = PreviewMode.enumValueIndex;
                // Apply changes to the serializedProperty - always do this in the end of OnInspectorGUI.
                serializedObject.ApplyModifiedProperties();
                // Apply change:
                _LushLODTree.TreesManager.UpdateTreesPreview(null, true, false);
            }

            if (Application.isPlaying == false)
            {
                EnableUndo.boolValue = GUILayout.Toggle(EnableUndo.boolValue, new GUIContent("Enable Undo"));
                if (EnableUndo.boolValue == true)
                {
                    GUILayout.Box("If clicking the Apply All button takes too long, you can disable Undo which may improve editing speed.", RegularStyleBox);
                }
                else
                {
                    GUILayout.Box("Warning: Unity's builtin Undo system is currently disabled for the manager. This can improve editing speed if you have thousands of trees, but you may not be able to undo everything. This option only affects performance in edit mode, and it has no affect on anything when the game is running.", RegularStyleBox);
                }
            }


            GUILayout.Space(10f);
            GUILayout.Label("Shadow Baking:", BoldStyle);

            EditorGUILayout.PropertyField(MainDirectionalLight, new GUIContent("Main Directional Light"));
            if (TheLight == null || TheLight.Equals(null) || ReferenceEquals(TheLight, null))
            {
                GUILayout.Box("Drag and drop your main directional light from your Hierarchy into the slot above. If your scene has multiple directional lights, pick whichever one you want to be your \"main\" one.", RegularStyleBox);
                if (LightmapSettings.lightmaps.Length > 0 && Lightmapping.bakedGI)
                {
                    //This just gets the total number of seconds since 1970;
                    int secondsSinceEpoch = (int)(System.DateTime.UtcNow - new System.DateTime(2016, 1, 1)).TotalSeconds;
                    if (secondsSinceEpoch > timeSkip_checkDirectionalLight)
                    {
                        timeSkip_checkDirectionalLight = secondsSinceEpoch + 5;
                        Light[] checkit = FindObjectsOfType<Light>();
                        bool FoundNonBakedLight = false;
                        foreach(Light L in checkit)
                        {
                            if (L.bakingOutput.isBaked == false && L.type == LightType.Directional)
                            {
                                FoundNonBakedLight = true;
                                break;
                            }
                        }

                        if (FoundNonBakedLight == false)
                        {
                            AllLightsAreBaked = true;
                            GUILayout.Box("Warning: You either have no directional lights, or your directional lights are all baked. You need to drag and drop one of them into the slot above, or else your billboards will not render correctly.", BoldRedstyle);
                        }
                        else
                        {
                            AllLightsAreBaked = false;
                        }
                    }
                    else
                    {
                        if (AllLightsAreBaked)
                        {
                            GUILayout.Box("Warning: You either have no directional lights, or your directional lights are all baked. You need to drag and drop one of them into the slot above, or else your billboards will not render correctly.", BoldRedstyle);
                        }
                    }
                }
            }
            else
            {
                GUILayout.Box("The simple shadows, and other shadow-like effects on the _LushLODTrees in your scene will be aligned to the directional light in the slot above.", RegularStyleBox);
            }

            if (!Application.isPlaying)
            {
                if (GUILayout.Button("Ready Shadow Baking"))
                {
                    _LushLODTree.TreesManager.ShadowBaking(true);
                    serializedObject.Update();
                    //BeforeBakeSettings = serializedObject.FindProperty("BeforeBakeSettings");
                    ShadowBakingReady.boolValue = true;
                }
                GUILayout.Box("Use the above button to enter shadow baking mode. In this mode, your trees will be temporarily optimized to improve the performance specifically for baking the shadows. Note: If you bake your shadows, you can then turn realtime shadows off, and enjoy beautiful tree shadows with no framerate cost. Baking shadows only works if your directional lights will not rotate during the game. To learn more about shadow baking, see the documentation.", RegularStyleBox);
            }

            if (!Application.isPlaying)
            {
                GUILayout.Space(20f);
                EditorGUILayout.PropertyField(PreviewMode, new GUIContent("Tree Preview Quality:"));
                GUILayout.Box("Here you can set the preview quality for the trees during edit mode. This only affects the trees while the game is NOT running. If the trees are slowing down your scene while you are working with other assets, you can choose to preview the trees as Billboards or even use \"None\" to make them invisible. When the game is running, this setting has no effect.", RegularStyleBox);
                if (GUILayout.Button("Update Trees Preview Quality"))
                {
                    PreviewMode_PREVIOUS.enumValueIndex = PreviewMode.enumValueIndex;
                    // Apply changes to the serializedProperty - always do this in the end of OnInspectorGUI.
                    serializedObject.ApplyModifiedProperties();
                    // Apply change:
                    _LushLODTree.TreesManager.UpdateTreesPreview(null, true, true);
                }
            }

            if (!Application.isPlaying)
            {
                //DO NOT ALLOW the player to upgrade or revert prefabs while the game is running.
                //Because for whatever reason, it creates an instance of the NotInstanced atlas material,
                //and that gets all kinds of buggy stuff happening.

                GUILayout.Space(20f);
                GUILayout.Label("Revert to Prefabs:", BoldStyle);
                GUILayout.Box("If you want to revert all the trees back to their prefabs, click the revert button below. This will NOT affect the position, rotation or scale of any of your trees.", RegularStyleBox);
                GUILayout.Box("NOTE: Clicking the button below will also revert the manager's settings to whatever settings are found in the first LushLODTree prefab that gets processed by this button.", RegularStyleBox);
                if (GUILayout.Button("Revert All", style))
                {
                    if (_LushLODTree.TreesManager.RevertAll() == true) //<-- It will be true only if the RevertAll() was successful and did something.
                    {
                        OnEnable(); //<-- force a call to the OnEnable(), to load data from the first tree found, since it probably just changed.
                        ResetColors(); //<-- because the color values do not get reset when we load OnEnable()
                                       // Apply changes to the serializedProperty - always do this in the end of OnInspectorGUI.
                        serializedObject.ApplyModifiedProperties();
                        _LushLODTree.TreesManager.ApplyAll(null, true); //<-- now, make sure every tree is in sync with the manager (and with each other).

                        //When we revert, let's set the preview mode to High Quality, which is typically the default setting:
                        PreviewMode.enumValueIndex = (int)_LushLODTreesManager.previewMode.HighQuality;
                        PreviewMode_PREVIOUS.enumValueIndex = (int)_LushLODTreesManager.previewMode.HighQuality;

                        // Apply changes to the serializedProperty - always do this in the end of OnInspectorGUI.
                        serializedObject.ApplyModifiedProperties();
                        // Apply change:
                        _LushLODTree.TreesManager.UpdateTreesPreview(null, true, false);
                    }
                }
            }
            else
            {
                //Application is running. Let the user know they can't mess with the prefabs while game is running.
                //See reason for this in the comment above.
                GUILayout.Space(20f);
                GUILayout.Label("Revert to Prefabs:", BoldStyle);
                GUILayout.Box("You cannot revert to prefabs while the game is running.", RegularStyleBox);
            }

            GUILayout.Space(10f);
        }
        GUILayout.Space(10f);

        // Apply changes to the serializedProperty - always do this in the end of OnInspectorGUI.
        serializedObject.ApplyModifiedProperties();

        // Show default inspector property editor
        DrawDefaultInspector();

    }
}
#endif

