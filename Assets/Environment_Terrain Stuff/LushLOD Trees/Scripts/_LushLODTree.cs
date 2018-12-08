using System.Collections.Generic;
using System.Threading;
using UnityEngine;
#if UNITY_EDITOR
using UnityEditor;
#endif 

/// <summary>
/// This script / class is attached to every LushLOD tree in the game.
/// </summary>
public class _LushLODTree : MonoBehaviour
{

    /// <summary>
    /// This is a global variable found in the _LushLODTree.cs file, and can be accessed from anywhere by typing _LushLODTree.TreesManager. This is simply a reference to the gameobject called _LushLODTreesManager, or more specifically, the script that's running on that gameobject. This allows the trees to quickly access the manager, and also ensures that the tree's do NOT display a button to create another manager.
    /// </summary>
    public static _LushLODTreesManager TreesManager;
    
    /// <summary>
    /// Used to check if the shaders may have been changed by a change in settings that
    /// occured in the manager. If this value increments in the manager, we will force a full
    /// update to the shaders used by this tree, to ensure that the correct shaders are
    /// being used.
    /// </summary>
    public int ShaderSettingsChanged = -1;

    /// <summary>
    /// This class will be initilized a maximum of one time, and when it is initilized, it will
    /// search for and find all of the billboard shaders, and create references to those
    /// shaders. This helps to ensure that we don't use Shader.Find() more than once for
    /// each shader. This will help improve performance.
    /// </summary>
    public class Shader_References
    {
        public bool ShaderRefrencesSetup = false;

        //Billboard shaders:
        public Shader Tree_Leaves_Ultra;
        public Shader Tree_Leaves2;
        public Shader Tree_Leaves3;
        public Shader Tree_Leaves4;
        public Shader Tree_Leaves_Far_Ultra;
        public Shader Tree_Leaves_Far_Ultra_BB;
        public Shader Tree_Leaves_Far2;
        public Shader Tree_Leaves_Far3;
        public Shader Tree_Leaves_Far4;

        //Special shaders for deferred rendering mode:
        public Shader Tree_Leaves_Ultra_Deferred;
        public Shader Tree_Leaves_Far_Ultra_Deferred;
        public Shader Tree_Leaves_Far_Ultra_BB_Deferred;
        public Shader Tree_Leaves_Far2_Deferred;
        public Shader Tree_Leaves_Far3_Deferred;
        public Shader Tree_Leaves_Far4_Deferred;
        public Shader Tree_Leaves2_Deferred;
        public Shader Tree_Leaves3_Deferred;
        public Shader Tree_Leaves4_Deferred;

        /// <summary>
        /// Constructor. This is automatically called when we initilize this class.
        /// </summary>
        public Shader_References()
        {
            Tree_Leaves_Ultra_Deferred = Shader.Find("Hidden/LushLODTree/Tree_Leaves_Ultra_Deferred"); //<-- this is the billboard shader for "Ultra" quality, used ONLY during the transitioning phase where the billboard is transitioning into the high quality tree models.
            Tree_Leaves_Far_Ultra_Deferred = Shader.Find("Hidden/LushLODTree/Tree_Leaves_Far_Ultra_Deferred"); //<-- this is the billboard shader for "Ultra" quality, used ONLY when the billboards are far away from the camera, outside of the transition range.
            Tree_Leaves_Far_Ultra_BB_Deferred = Shader.Find("Hidden/LushLODTree/Tree_Leaves_Far_Ultra_BB_Deferred"); //<-- this is the billboard shader for "Ultra" quality, used ONLY when Billboard Setting is set to "Billboard Only" mode. This shader adds angular correction.
            Tree_Leaves2_Deferred = Shader.Find("Hidden/LushLODTree/Tree_Leaves2_Deferred"); //<-- this is the billboard shader for "Great" quality, used ONLY during the transitioning phase where the billboard is transitioning into the high quality tree models.
            Tree_Leaves3_Deferred = Shader.Find("Hidden/LushLODTree/Tree_Leaves3_Deferred"); //<-- this is the billboard shader for "Medium" quality, used ONLY during the transitioning phase where the billboard is transitioning into the high quality tree models.
            Tree_Leaves4_Deferred = Shader.Find("Hidden/LushLODTree/Tree_Leaves4_Deferred"); //<-- this is the billboard shader for "Low" quality, used ONLY during the transitioning phase where the billboard is transitioning into the high quality tree models.
            Tree_Leaves_Far2_Deferred = Shader.Find("Hidden/LushLODTree/Tree_Leaves_Far2_Deferred"); //<-- this is the billboard shader for "Great" quality, used ONLY when the billboards are far away from the camera, outside of the transition range.
            Tree_Leaves_Far3_Deferred = Shader.Find("Hidden/LushLODTree/Tree_Leaves_Far3_Deferred"); //<-- this is the billboard shader for "Medium" quality, used ONLY when the billboards are far away from the camera, outside of the transition range.
            Tree_Leaves_Far4_Deferred = Shader.Find("Hidden/LushLODTree/Tree_Leaves_Far4_Deferred"); //<-- this is the billboard shader for "Low" quality, used ONLY when the billboards are far away from the camera, outside of the transition range.

            Tree_Leaves2 = Shader.Find("Hidden/LushLODTree/Tree_Leaves2"); //<-- this is the billboard shader for "Great" quality, used ONLY during the transitioning phase where the billboard is transitioning into the high quality tree models.
            Tree_Leaves3 = Shader.Find("Hidden/LushLODTree/Tree_Leaves3"); //<-- this is the billboard shader for "Medium" quality, used ONLY during the transitioning phase where the billboard is transitioning into the high quality tree models.
            Tree_Leaves4 = Shader.Find("Hidden/LushLODTree/Tree_Leaves4"); //<-- this is the billboard shader for "Low" quality, used ONLY during the transitioning phase where the billboard is transitioning into the high quality tree models.
            Tree_Leaves_Ultra = Shader.Find("Hidden/LushLODTree/Tree_Leaves_Ultra"); //<-- this is the billboard shader for "Ultra" quality, used ONLY during the transitioning phase where the billboard is transitioning into the high quality tree models.
            Tree_Leaves_Far_Ultra = Shader.Find("Hidden/LushLODTree/Tree_Leaves_Far_Ultra"); //<-- this is the billboard shader for "Ultra" quality, used ONLY when the billboards are far away from the camera, outside of the transition range.
            Tree_Leaves_Far_Ultra_BB = Shader.Find("Hidden/LushLODTree/Tree_Leaves_Far_Ultra_BB"); //<-- this is the billboard shader for "Ultra" quality, used ONLY when Billboard Setting is set to "Billboard Only" mode. This shader adds angular correction.
            Tree_Leaves_Far2 = Shader.Find("Hidden/LushLODTree/Tree_Leaves_Far2"); //<-- this is the billboard shader for "Great" quality, used ONLY when the billboards are far away from the camera, outside of the transition range.
            Tree_Leaves_Far3 = Shader.Find("Hidden/LushLODTree/Tree_Leaves_Far3"); //<-- this is the billboard shader for "Medium" quality, used ONLY when the billboards are far away from the camera, outside of the transition range.
            Tree_Leaves_Far4 = Shader.Find("Hidden/LushLODTree/Tree_Leaves_Far4.b"); //<-- this is the billboard shader for "Low" quality, used ONLY when the billboards are far away from the camera, outside of the transition range.
        }
    }

    /// <summary>
    /// This class will be initilized a maximum of one time, and when it is initilized, it will
    /// search for and find all of the billboard shaders, and create references to those
    /// shaders. This helps to ensure that we don't use Shader.Find() more than once for
    /// each shader. This will help improve performance.
    /// </summary>
    public static Shader_References ShaderReferences;

    /// <summary>
    /// This class is accessed through a List found
    /// at _LushLODTree.Materials_FullyOpaque_static.
    /// One copy of this class will be opened for each 
    /// unique atlas found in the scene.
    /// This enables support for multiple atlas textures.
    /// </summary>
    public class Material_FullyOpaque_References
    {

        /// <summary>
        /// This constructor can be used to easily set up new static materials
        /// </summary>
        /// <param name="Material_NotInstance_FullyOpaque">Pass in the specific tree's reference to the Not Instanced material. This is _LushLODTree.Material_NotInstance_FullyOpaque</param>
        /// <param name="Material_File_ID">Pass in the specific tree's reference to Material_File_ID. This is _LushLODTree.Material_File_ID</param>
       public Material_FullyOpaque_References(Material Material_NotInstance_FullyOpaque, int Material_File_ID)
        {
            //This is where the static material is actually instantiated. This is the only place where we ever instantiate this material like this:
            this.Material_FullyOpaque_static = Instantiate(Material_NotInstance_FullyOpaque);
            //Here is where we keep a record of exactly which atlas material this was:
            this.Material_File_ID = Material_File_ID;
            //Set the materials name. This is only used to help us identify this material when we're looking at it in the inspector.
            this.Material_FullyOpaque_static.name = "Static_FullyOpaque_Far_Instanced_No." + Material_File_ID;
        }

        /// <summary>
        /// Loops through all of the static FullyOpaque materials, and sets their color to the color specified
        /// </summary>
        public static void SetColor(Color color)
        {
            foreach (Material_FullyOpaque_References refs in _LushLODTree.Materials_FullyOpaque_static)
            {
                refs.Material_FullyOpaque_static.color = color;
            }
        }

        /// <summary>
        /// Loops through all of the static FullyOpaque materials, and sets their shader to the shader specified
        /// </summary>
        public static void SetShader(Shader shader)
        {
            foreach (Material_FullyOpaque_References refs in _LushLODTree.Materials_FullyOpaque_static)
            {
                refs.Material_FullyOpaque_static.shader = shader;
            }
        }

        /// <summary>
        /// This is a global reference to a specific atlas material.
        /// This is contained within a class, and the class is listed in a List found 
        /// at _LustLODTree.Materials_FullyOpaque_static. One copy of this class will
        /// be opened for each unique atlas texture (in case the scene is using more than
        /// one atlas texture).
        /// </summary>
        public Material Material_FullyOpaque_static;
        /// <summary>
        /// This file ID can be used to uniquely identify this atlas material file, and ensure that
        /// we only Instantiate a maximum of ONE static material for each atlas file.
        /// This will ensure that all trees that use that atlas will share the same material,
        /// and only create 1 draw call. But it also ensures that if multiple atlas texture
        /// files exist, then one material for each atlas will be Instantiated, and the
        /// trees will not argue with each other or overwrite each other's static material reference.
        /// </summary>
        public int Material_File_ID;
    }

    /// <summary>
    /// This List will be initilized and will contain a list of references
    /// to a class that will hold references to Instantiated copies of the atlas texture
    /// material. One static copy of said material will be opened for each unique atlas texture file
    /// on the hard drive. This partly ensures that each atlas only has one material, and all distant
    /// trees will share that material, which enables batching. But it also ensures that if the user
    /// is using multiple atlases, then each atlas will get 1 material, and 1 draw call for each atlas.
    /// </summary>
    public static List<Material_FullyOpaque_References> Materials_FullyOpaque_static;

    /// <summary>
    /// If the user is adding trees to the game while the game is running, then we will display a warning in the console to
    /// inform the user that the tree must find itself a parent. This is done automatically, however, it creates a big of lag when
    /// adding trees to the game while the game is running. It's better to add trees to the scene while the game isn't running, but
    /// that isn't always an option. So we DO support the ability to add trees to the scene while the game is running. But a 
    /// warning will appear in the console (only if the game is running in the editor). This bool is global, and 
    /// ensures that this warning will never appear more than once. 
    /// This avoids spamming the console, if the user adds a lot of trees during the game.
    /// </summary>
    private static bool warnedaboutdynamicTrees = false;

    /// <summary>
    /// This is a global reference to the Tree Creator Leaves Fast Optimized shader. NOTE: If you are trying to determine which shader to use
    /// for a particular tree, you probably should get that information by calling the tree's GetLeavesShader() or GetBarkShader() function.
    /// </summary>
    public static Shader TreeCreatorLeavesOptimized_FAST;
    /// <summary>
    /// This is a global reference to the Tree Creator Leaves Optimized shader. NOTE: If you are trying to determine which shader to use
    /// for a particular tree, you probably should get that information by calling the tree's GetLeavesShader() or GetBarkShader() function.
    /// </summary>
    public static Shader TreeCreatorLeavesOptimized;
    /// <summary>
    /// This is a global reference to the Tree Creator Leaves Fast Optimized Simple Shadows shader. NOTE: If you are trying to determine which shader to use
    /// for a particular tree, you probably should get that information by calling the tree's GetLeavesShader() or GetBarkShader() function.
    /// </summary>
    public static Shader TreeCreatorLeavesOptimized_FAST_SimpleShadows;
    /// <summary>
    /// This is a global reference to the Tree Creator Leaves Optimized Simple Shadows shader. NOTE: If you are trying to determine which shader to use
    /// for a particular tree, you probably should get that information by calling the tree's GetLeavesShader() or GetBarkShader() function.
    /// </summary>
    public static Shader TreeCreatorLeavesOptimized_SimpleShadows;
    /// <summary>
    /// This is a global reference to the Tree Creator Bark Fast Optimized shader. NOTE: If you are trying to determine which shader to use
    /// for a particular tree, you probably should get that information by calling the tree's GetLeavesShader() or GetBarkShader() function.
    /// </summary>
    public static Shader TreeCreatorBarkOptimized_FAST;
    /// <summary>
    /// This is a global reference to the Tree Creator Bark Optimized shader. NOTE: If you are trying to determine which shader to use
    /// for a particular tree, you probably should get that information by calling the tree's GetLeavesShader() or GetBarkShader() function.
    /// </summary>
    public static Shader TreeCreatorBarkOptimized;
    /// <summary>
    /// This is a global reference to the Tree Creator Bark Fast Optimized Simple Shadows shader. NOTE: If you are trying to determine which shader to use
    /// for a particular tree, you probably should get that information by calling the tree's GetLeavesShader() or GetBarkShader() function.
    /// </summary>
    public static Shader TreeCreatorBarkOptimized_FAST_SimpleShadows;
    /// <summary>
    /// This is a global reference to the Tree Creator Bark Optimized Simple Shadows shader. NOTE: If you are trying to determine which shader to use
    /// for a particular tree, you probably should get that information by calling the tree's GetLeavesShader() or GetBarkShader() function.
    /// </summary>
    public static Shader TreeCreatorBarkOptimized_SimpleShadows;

    /// <summary>
    /// This is a reference to this tree's static material. It is possible that multiple atlases may be used
    /// in the scene, but every tree will know which atlas they will use, because it is referenced right here.
    /// </summary>
    public Material_FullyOpaque_References Material_FullyOpaque_static;

    /// <summary>
    /// This version number will be incremented with each new release of LushLODTrees. This number will be recorded into any prefabs that are generated
    /// by this script, and it may be used in the future to help upgrade trees that were made using an older version of the script.
    /// </summary>
    public string LushLODTree_VersionNumber;

    /// <summary>
    /// This is a reference to the _LushLODTreesManager that's running on the _LustLODTreesManager gameobject. Unlike the static version of this variable, this one is saved to every tree and it works like a backup reference to the manager, in case the static variable is null for whatever reason.
    /// </summary>
    public _LushLODTreesManager TreesManager_ref;
    
    /// <summary>
    /// This contains an ID number which can be used to identify which atlas material file this specific tree uses.
    /// The value for this string is permanently saved into the prefab during the tree's creation and it should never be changed.
    /// </summary>
    public int Material_File_ID;

    /// <summary>
    /// While the game is OR isn't running, this is a non-instanced, non-cloned reference to the 
    /// original fully opaque material, which is saved directly to the hard drive. 
    /// Therefore, changing anything about this material (such as its _Color, or its shader) will be permanent, 
    /// as such changes will be saved directly the hard drive.
    /// However, when the game is running, we don't use this material, we use the _static copy of this material.
    /// This material is used anytime we need the billboards to be full opaque, such as:
    /// 1) When the billboards are far away from the camera.
    /// 2) When we are on "billboards only" mode.
    /// </summary>
    public Material Material_NotInstance_FullyOpaque;

    /// <summary>
    /// Unlike the fully transparent and the fully opaque materials, we do not have a seperate _static variable
    /// for this transitioning material. So, whether the game is running or not, we use this variable. However, when the
    /// game starts, EVERY TREE will create their own cloned copy of this material, and each tree will use that cloned copy
    /// instead of using or modifying the original material that's saved to the hard drive. That way, when the game ends,
    /// any changes they make to their cloned copy of the material will not be permanent.
    /// But it is important to note: the reason every tree makes a cloned copy of this material, and they do not share a single
    /// instance of this material, is beause we want to: 1) Ensure that every tree gets its own personal copy of this material,
    /// and more importantly, the _Transparency slider bar that's attached to this material, so that every tree can transition
    /// independently and they will not argue with each other like they would if they were all sharing the same instance of the
    /// same material. This also means that the billboards that are in the transition phase will not have reduced draw calls, but
    /// they will generate 1 draw call for every billboard tree in the transition phase, and this cannot be helped.
    /// </summary>
    public Material Material_Instance_Transitioning;

    /// <summary>
    /// This is a copy of the current BillBoard Settings, same thing that's saved in the _LushLODTreesManager, 
    /// but in this case, it's saved to this specific tree. This is useful in case the user deletes the 
    /// _LushLODTreesManager out of the scene, in which case, we would still remember the current settings 
    /// because we save it to the trees as well. Therefore, when the _LushLODTreesManager is created again, 
    /// it will read this value from the first tree it finds in the scene, and it will know what the current setting was.
    /// </summary>
    public _LushLODTreesManager.BillBoardSettings BillBoardSetting;

    /// <summary>
    /// This is a copy of the current Shadow Receive Settings, same thing that's saved in the _LushLODTreesManager, 
    /// but in this case, it's saved to this specific tree. This is useful in case the user deletes the 
    /// _LushLODTreesManager out of the scene, in which case, we would still remember the current settings 
    /// because we save it to the trees as well. Therefore, when the _LushLODTreesManager is created again, 
    /// it will read this value from the first tree it finds in the scene, and it will know what the current setting was.
    /// </summary>
    public _LushLODTreesManager.ShadowReceiveSettings ShadowReceiveSetting;

    /// <summary>
    /// This is a copy of the current Ambient Occlusion setting, same thig that's saved in the _LushLODTreesManager,
    /// but i this case, it's saved to this specific tree. This is useful in case the user deletes the _LushLODTreeManager
    /// out of the scene, in which case, we would still remember the current settings because we saed
    /// it to the trees as well. Therefore, when the _LushLODTreesManager is created again,
    /// it will read this vale fro the first tree it finds in the scene, and it will know what the current setting was.
    /// </summary>
    public float AmbientOcclusion = 1f;

    /// <summary>
    /// This is a copy of the current ShadowContrast setting, same thig that's saved in the _LushLODTreesManager,
    /// but i this case, it's saved to this specific tree. This is useful in case the user deletes the _LushLODTreeManager
    /// out of the scene, in which case, we would still remember the current settings because we saed
    /// it to the trees as well. Therefore, when the _LushLODTreesManager is created again,
    /// it will read this vale fro the first tree it finds in the scene, and it will know what the current setting was.
    /// </summary>
    public float ShadowContrast = 2.0f;

    /// <summary>
    /// This is a copy of the current TimeOfDay setting, same thig that's saved in the _LushLODTreesManager,
    /// but i this case, it's saved to this specific tree. This is useful in case the user deletes the _LushLODTreeManager
    /// out of the scene, in which case, we would still remember the current settings because we saed
    /// it to the trees as well. Therefore, when the _LushLODTreesManager is created again,
    /// it will read this vale fro the first tree it finds in the scene, and it will know what the current setting was.
    /// </summary>
    public float TimeOfDay = 1f;

    /// <summary>
    /// This is a copy of the current Translucency setting, same thig that's saved in the _LushLODTreesManager,
    /// but i this case, it's saved to this specific tree. This is useful in case the user deletes the _LushLODTreeManager
    /// out of the scene, in which case, we would still remember the current settings because we saed
    /// it to the trees as well. Therefore, when the _LushLODTreesManager is created again,
    /// it will read this vale fro the first tree it finds in the scene, and it will know what the current setting was.
    /// </summary>
    public float Translucency = 0.5f;

    /// <summary>
    /// This is a copy of the current TranslucencySharpen setting, same thig that's saved in the _LushLODTreesManager,
    /// but i this case, it's saved to this specific tree. This is useful in case the user deletes the _LushLODTreeManager
    /// out of the scene, in which case, we would still remember the current settings because we saed
    /// it to the trees as well. Therefore, when the _LushLODTreesManager is created again,
    /// it will read this vale fro the first tree it finds in the scene, and it will know what the current setting was.
    /// </summary>
    public float TranslucencySharpen = 0f;
    /// <summary>
    /// This is a copy of the current ShadowClip setting, same thig that's saved in the _LushLODTreesManager,
    /// but i this case, it's saved to this specific tree. This is useful in case the user deletes the _LushLODTreeManager
    /// out of the scene, in which case, we would still remember the current settings because we saed
    /// it to the trees as well. Therefore, when the _LushLODTreesManager is created again,
    /// it will read this vale fro the first tree it finds in the scene, and it will know what the current setting was.
    /// </summary>
    public float ShadowClip = 1f;
    /// <summary>
    /// This is a copy of the current Maximum Shadow Add setting, same thig that's saved in the _LushLODTreesManager,
    /// but i this case, it's saved to this specific tree. This is useful in case the user deletes the _LushLODTreeManager
    /// out of the scene, in which case, we would still remember the current settings because we saed
    /// it to the trees as well. Therefore, when the _LushLODTreesManager is created again,
    /// it will read this vale fro the first tree it finds in the scene, and it will know what the current setting was.
    /// </summary>
    public float ShadowSize = 0f;

    /// <summary>
    /// This is a copy of the current Realtime Shadow Settings, same thing that's saved in the _LushLODTreesManager, 
    /// but in this case, it's saved to this specific tree. This is useful in case the user deletes the 
    /// _LushLODTreesManager out of the scene, in which case, we would still remember the current settings 
    /// because we save it to the trees as well. Therefore, when the _LushLODTreesManager is created again, 
    /// it will read this value from the first tree it finds in the scene, and it will know what the current setting was.
    /// </summary>
    public _LushLODTreesManager.RealTimeShadowSettings RealTimeShadowSetting;

    /// <summary>
    /// This variable saves whatever was the original color of this tree's high quality material color.
    /// This value is not used by the tree itself, but it is used by the manager. Whenever the manager makes a change to this
    /// tree's color value, it will first UNDO the previous color adjustment by setting the material to this original color, 
    /// which is saved right here, before making the next color adjustment. This ensures that color adjustments don't stack up, 
    /// and it ensures that there is never more than one color adjustment in effect, and ensures that we can undo all color adjustments.
    /// This color value is saved in the prefab, and it should never be changed.
    /// </summary>
    public List<Color> maincolor_HQTrees_ORIGINALS; //<-- this color is set in the prefab. It should never be changed.

    /// <summary>
    /// This variable saves the average color of the bark. Used by the post processor to correct certain situations where it may lose
    /// color data during transitions.
    /// </summary>
    public Color AverageColor_Bark; //<-- this color is set in the prefab. It should never be changed.
    /// <summary>
    /// This variable saves the average color of the leaves. Used by the post processor to correct certain situations where it may lose
    /// color data during transitions.
    /// </summary>
    public Color AverageColor_Leaves; //<-- this color is set in the prefab. It should never be changed.

    /// <summary>
    /// This variable isn't used by the tree. But it is set and used by the _LustLODTreesManager to save whether or not this tree
    /// is currently in shadow baking mode. This is usefuly if, for example, the user deletes the _LustLODTreesManager out of their
    /// scene. When the manager is created again, it will read from the first tree it finds in the scene, and know if the trees were
    /// in shadow baking mode. If they were, and this variale is set to true, then the manager will display the necessary button to 
    /// exit shadow baking mode.
    /// </summary>
    public bool ShadowBakingReady = false;

    /// <summary>
    ///Instructs this tree to check its children in the Update() loop, to see if they need to be turned on or off,
    ///even if it normally wouldn't check them. This is used if, for example, the _LustLODTreesManager has done something to
    ///the children (such as turn them on or off), and this parent may not be aware of what happened. Once the manager is
    ///finished messing around with this tree's children, and the manager wants this tree to take full control again, then the
    ///manager will probably set this variable to true, to instruct this tree to check its children.
    /// </summary>
    public bool CheckChildren = false;

    /// <summary>
    /// This variable is simply used to detect if the value of the LOD distance has changed. If it does change, then
    /// the tree will run the Reset() function.
    /// </summary>
    private float LodDistance_PREVIOUS = _LushLODTreesManager.DefaultLodDistance;

    /// <summary>
    /// This variable contains a number that is used to determine the distance where the trees will transition from billboards
    /// into high quality tree models. Higher values will make the transition occur further away. Lower values will make it occur
    /// closer. This variable also directly affects the parents. Setting this variable to a lower value will cause children to
    /// only connect to parents that are closer to them. Therefore, setting this varible to a lower value will result in the need
    /// for MORE parents to exist in your scene, as each parent will only be able to control chilren that are closer to them.
    /// Parent trees will call their Update() function frequently if billboard mode is set to "Use Both" in the _LustLODTreesManager.
    /// So setting this to a lower value, with "use both" set to true, may cause increased CPU usage as the increased number of
    /// parents will result in more calls to Update(). However, setting this variable to a very high value will cause
    /// more high quality trees to be rendered to the screen, resulting in increased GPU usage. Find the setting that has the
    /// best balance for your game. This variable should ONLY be changed in the trees manager. 
    /// Changing this variable will require the parents to be fully recalculated. Failure to recalculate the parents 
    /// after making a significant change to this variable will result in the trees not transitioning correctly.
    /// </summary>
    public float lodDistance = _LushLODTreesManager.DefaultLodDistance;

    /// <summary>
    /// This variable contains the previous angular correction setting. This isn't used by the tree itself. But it is set and used
    /// by the _LustLODTreesManager in the scene. When the user changes the angular correction setting in the editor, it will be
    /// saved to this variable right here. Then, if the manager gets deleted and added again to the scene, it'll read from the first
    /// tree it finds in the scene, and read the value of this variable, to know what the current angular correction setting is.
    /// </summary>
    public _LushLODTreesManager.BillboardQualitySettings billboard_quality_PREVIOUS = _LushLODTreesManager.BillboardQualitySettings.Great;

    /// <summary>
    /// This variable contains a reference to this trees parent. Not used for much, except to determine if this tree is a child.
    /// </summary>
    public _LushLODTree MyParent;
    /// <summary>
    /// This variable is used in some places to check if this tree is a parent and can accept children.
    /// </summary>
    public bool IsParent = false;
    /// <summary>
    /// This is a list of children trees. If this tree is a parent, and has children in this list, it will control those children
    /// by turning them OFF when the parent is far away from the camera, and turning them ON when the parent gets close to the
    /// camera. By turning them off, they will no longer call their Update() functions and waste CPU useage. This greatly improves
    /// framerate.
    /// </summary>
    public List<_LushLODTree> MyChildren;
    /// <summary>
    /// This is a quick and easy way for the parent and the manager to determine if this parent has turned its children on or off.
    /// We use this, rather than looping through all the children to check if they are on or off. So if this parent turns its
    /// children off, it will set this variable to false. If the parent turns its childrne on, it will set this variable to true.
    /// When the game isn't running, this variable's default value is true, since every tree is ON until the game runs.
    /// </summary>
    public bool MyChildrenEnabled = true;

    /// <summary>
    /// This will contain the original value for _ShadowStrength in the high quality tree model's leaf material. We use this original
    /// value to allow us to revert it back to the original state if need be.
    /// </summary>
    public float Original_ShadowStrength;

    /// <summary>
    /// This will contain the modified value for _ShadowStrength. This is adjustabe by the slider bar that is attached to this tree, in 
    /// the inspector window. 
    /// </summary>
    public float Modified_ShadowStrength;

    /// <summary>
    /// This will contian the original gameobject name for the high quality tree before it was converted to a lushLODtree. This is
    /// useful to help us remember the name of this tree in case it changes.
    /// </summary>
    public string Original_TreeName;

    /// <summary>
    /// This will contain a hash of the original high quality tree gameobject before it was converted to a
    /// LushLODTree. This hash can be used to identify this tree and compare this tree to others to see if they were converted from the same 
    /// original tree. This is useful in case the tree loses its connection its prefab, and we need to find all instances of it in
    /// the scene... we can simply look at this hash and know if it is the tree we are looking for.
    /// </summary>
    public string Original_UniqueID;


    /// <summary>
    /// This float[5] contains the distances where the different transition regions will begin and end for the trees.
    /// These 5 transition regions are used to stagger the transition. By staggering, I mean for example that the billboard shadows
    /// fully fade in, before the HQ tree shadows begin fade out. This ensures that the shadows never partially disappear
    /// at any point during the transition. This staggering also occurs on the main rendering of the trees, to ensure the trees do
    /// not partially disappear during the transition. NOTE: Ultra quality setting only staggers the
    /// shadow transitions.
    /// </summary>
    public float[] sqrTransition;

    /// <summary>
    /// This variable contains a reference to the renderer for the HQ tree model.
    /// </summary>
    public Renderer lod0Rend;     // High quality mesh renderer(s)
    /// <summary>
    /// This variable contains a reference to the renderer for the billboard tree model.
    /// </summary>
    public Renderer lod1Rend;     // billboard renderer

    private float timeSkip;
    private float curDistance;
    private Vector3 curPosition;

    /// <summary>
    /// This variable saves whether or not the high quality tree models's transparency value is currently set to 1, or not. This is
    /// provides a small speed increase, since we will not set the transparency to 1 if it is already set to 1.
    /// </summary>
    public bool rendIs1 = true;
    /// <summary>
    /// Tis variable saves the current value of the high quality tree model's transparency. This provides a small speed increase,
    /// since we will not set the transparency if it is already correct.
    /// </summary>
    public float rendIsFloat = 1f;

    public float lastShadowStr = -1;

    public bool ShadowsOnlyIsSet = false;
        
    /// <summary>
    /// This bool simply records whether or not this tree has been setup yet. When a tree is first added to a scene, this bool will be false at first.
    /// (In other words, this bool is set to "false" in the prefab). 
    /// THIS BOOL ONLY DOES ONE THING: 
    /// If this bool is set to false then next time this tree runs its Start() function, or its OnInspectorGUI() function, it will apply all of the current
    /// settings in the manager to itself, and then set this bool to "true" to prevent the same thing from happening again on this instance.
    /// </summary>
    public bool TreeIsSetup = false;

    /// <summary>
    /// This bool simply records whether or not this tree has finished being created by the tree converter script found in _LushLODTreeConverter.cs
    /// </summary>
    public bool TreeCreationFinished = false;

    /// <summary>
    /// This will be set to true if the tree was using the Tree Creator Leaves Optimized FAST shader at the time when it was converted to a LushLOD Tree.
    /// If this is set to true, then the tree will continue to use the fast version of the shader for leaves.
    /// </summary>
    public bool UsingFastLeavesShader = false;
    /// <summary>
    /// This will be set to true if the tree was using the Tree Creator Bark Optimized FAST shader at the time when it was converted to a LushLOD Tree.
    /// If this is set to true, then the tree will continue to use the fast version of the shader for bark.
    /// </summary>
    public bool UsingFastBarkShader = false;
        
    /// <summary>
    /// This function gets the current billboard leaves shader that should be used by the
    /// billboards that are NOT far away from the camera.
    /// </summary>
    /// <param name="billboard_quality">Pass a reference to the manager's BillboardQualitySettings variable.</param>
    /// <returns></returns>
    public static Shader GetBillboardLeavesShader(_LushLODTreesManager.BillboardQualitySettings billboard_quality, _LushLODTreesManager.RenderingModes RenderingMode)
    {

        //Ensure we got references setup to the shaders.
        if (ShaderReferences == null || ReferenceEquals(ShaderReferences, null))
        {
            ShaderReferences = new Shader_References();
        }

        Shader Tree_Leaves_Using = ShaderReferences.Tree_Leaves_Ultra; //<-- this is just a placeholder. We will overwrite this value below.

        if (RenderingMode == _LushLODTreesManager.RenderingModes.Forward)
        {
            //Now, let's pick which shader we will use:
            switch (billboard_quality) //<-- check quality.
            {
                case _LushLODTreesManager.BillboardQualitySettings.Low: //<-- All corrections off, no dithering at all
                    Tree_Leaves_Using = ShaderReferences.Tree_Leaves4;
                    break;
                case _LushLODTreesManager.BillboardQualitySettings.Medium: //<-- Angular Correction
                    Tree_Leaves_Using = ShaderReferences.Tree_Leaves3;
                    break;
                case _LushLODTreesManager.BillboardQualitySettings.Great: //<-- Angular Correction + Blending
                    Tree_Leaves_Using = ShaderReferences.Tree_Leaves2;
                    break;
                case _LushLODTreesManager.BillboardQualitySettings.Ultra: //<-- Angular Correction (only in "Billboards Only" mode) + Blending + Post Processing Effect for Transparency
                    Tree_Leaves_Using = ShaderReferences.Tree_Leaves_Ultra;
                    break;
            }//
        }
        else if (RenderingMode == _LushLODTreesManager.RenderingModes.Deferred)
        {
            //Now, let's pick which shader we will use:
            switch (billboard_quality) //<-- check quality.
            {
                case _LushLODTreesManager.BillboardQualitySettings.Low: //<-- All corrections off, no dithering at all
                    Tree_Leaves_Using = ShaderReferences.Tree_Leaves4_Deferred;
                    break;
                case _LushLODTreesManager.BillboardQualitySettings.Medium: //<-- Angular Correction
                    Tree_Leaves_Using = ShaderReferences.Tree_Leaves3_Deferred;
                    break;
                case _LushLODTreesManager.BillboardQualitySettings.Great: //<-- Angular Correction + Blending
                    Tree_Leaves_Using = ShaderReferences.Tree_Leaves2_Deferred;
                    break;
                case _LushLODTreesManager.BillboardQualitySettings.Ultra: //<-- Angular Correction (only in "Billboards Only" mode) + Blending + Post Processing Effect for Transparency
                    Tree_Leaves_Using = ShaderReferences.Tree_Leaves_Ultra_Deferred;
                    break;
            }
        }
        
        return Tree_Leaves_Using;
    }

    /// <summary>
    /// This function gets the current billboard leaves shader that should be used by the
    /// billboards that are far away from the camera.
    /// </summary>
    /// <param name="billboard_quality">Pass a reference to the manager's BillboardQualitySettings variable.</param>
    /// <param name="BillBoardSetting">Pass a reference to the manager's BillboardSetting variable.</param>
    public static Shader GetBillboardLeavesFarShader(_LushLODTreesManager.BillboardQualitySettings billboard_quality, _LushLODTreesManager.BillBoardSettings BillBoardSetting, _LushLODTreesManager.RenderingModes RenderingMode)
    {

        //Ensure we got references setup to the shaders.
        if (ShaderReferences == null || ReferenceEquals(ShaderReferences, null))
        {
            ShaderReferences = new Shader_References();
        }

        Shader Tree_Leaves_Far_Using = ShaderReferences.Tree_Leaves_Far_Ultra; //<-- this is just a placeholder. We will overwrite this value below.

        if (RenderingMode == _LushLODTreesManager.RenderingModes.Forward)
        {
            //Now, let's pick which shader we will use:
            switch (billboard_quality) //<-- check quality.
            {
                case _LushLODTreesManager.BillboardQualitySettings.Low: //<-- All corrections off, no dithering at all
                    Tree_Leaves_Far_Using = ShaderReferences.Tree_Leaves_Far4;
                    break;
                case _LushLODTreesManager.BillboardQualitySettings.Medium: //<-- Angular Correction
                    Tree_Leaves_Far_Using = ShaderReferences.Tree_Leaves_Far3;
                    break;
                case _LushLODTreesManager.BillboardQualitySettings.Great: //<-- Angular Correction + Blending
                    Tree_Leaves_Far_Using = ShaderReferences.Tree_Leaves_Far2;
                    break;
                case _LushLODTreesManager.BillboardQualitySettings.Ultra: //<-- Angular Correction (only in "Billboards Only" mode) + Blending + Post Processing Effect for Transparency

                    if (BillBoardSetting == _LushLODTreesManager.BillBoardSettings.BillboardsOnly)
                    {
                        //When in "Billboards Only" mode, we can use angular correction for even better looking billboards.
                        //The even pixels will be used for the billboard plane that faces toward the camera, and the odd pixels will be used for the
                        //angular corrected pixels (the plane(s) that face away from the camera).
                        Tree_Leaves_Far_Using = ShaderReferences.Tree_Leaves_Far_Ultra_BB;
                    }
                    else
                    {
                        //Unfortunantly, we can't use angular correction in "Ultra" quality mode, and still be able to smoothly
                        //transition between billboards and high quality tree models. This is because, for everything to be
                        //seen correctly, the billboard plane that faces toward the camera would need to use the even pixels, 
                        //and the angular corrected billboard plane(s) would need to use the odd pixels. But then the high quality 
                        //tree model would also need to use either the even or the odd pixels during the transitions. 
                        //This means the high quality tree would over-write some portion of the billboard, which results in a 
                        //deadfully horrible visual glitch.                        
                        //So for now, I'm turning off angular correction in this shader.
                        //So in this shader, the even pixels will be used for the billboard, and the odd pixels will be
                        //used for the high quality tree model.
                        Tree_Leaves_Far_Using = ShaderReferences.Tree_Leaves_Far_Ultra;
                    }
                    break;
            }
        }
        else if (RenderingMode == _LushLODTreesManager.RenderingModes.Deferred)
        {
            //Now, let's pick which shader we will use:
            switch (billboard_quality) //<-- check quality.
            {
                case _LushLODTreesManager.BillboardQualitySettings.Low: //<-- All corrections off, no dithering at all
                    Tree_Leaves_Far_Using = ShaderReferences.Tree_Leaves_Far4_Deferred;
                    break;
                case _LushLODTreesManager.BillboardQualitySettings.Medium: //<-- Angular Correction
                    Tree_Leaves_Far_Using = ShaderReferences.Tree_Leaves_Far3_Deferred;
                    break;
                case _LushLODTreesManager.BillboardQualitySettings.Great: //<-- Angular Correction + Blending
                    Tree_Leaves_Far_Using = ShaderReferences.Tree_Leaves_Far2_Deferred;
                    break;
                case _LushLODTreesManager.BillboardQualitySettings.Ultra: //<-- Angular Correction (only in "Billboards Only" mode) + Blending + Post Processing Effect for Transparency

                    if (BillBoardSetting == _LushLODTreesManager.BillBoardSettings.BillboardsOnly)
                    {
                        //When in "Billboards Only" mode, we can use angular correction for even better looking billboards.
                        //The even pixels will be used for the billboard plane that faces toward the camera, and the odd pixels will be used for the
                        //angular corrected pixels (the plane(s) that face away from the camera).
                        Tree_Leaves_Far_Using = ShaderReferences.Tree_Leaves_Far_Ultra_BB_Deferred;
                    }
                    else
                    {
                        //Unfortunantly, we can't use angular correction in "Ultra" quality mode, and still be able to smoothly
                        //transition between billboards and high quality tree models. This is because, for everything to be
                        //seen correctly, the billboard plane that faces toward the camera would need to use the even pixels, 
                        //and the angular corrected billboard plane(s) would need to use the odd pixels. But then the high quality 
                        //tree model would also need to use either the even or the odd pixels during the transitions. 
                        //This means the high quality tree would over-write some portion of the billboard, which results in a 
                        //deadfully horrible visual glitch.                        
                        //So for now, I'm turning off angular correction in this shader.
                        //So in this shader, the even pixels will be used for the billboard, and the odd pixels will be
                        //used for the high quality tree model.
                        Tree_Leaves_Far_Using = ShaderReferences.Tree_Leaves_Far_Ultra_Deferred;
                    }
                    break;
            }
        }
       
        return Tree_Leaves_Far_Using;
    }

    /// <summary>
    /// This function returns either the Tree Creator Leaves Fast Optimized shader, or the Tree Creator Leaves Optimized shader.
    /// It returns whichever one of these two shaders the tree was originally using at the time when it was converted into a LushLOD Tree.
    /// </summary>
    /// <param name="SimpleShadows">Set this to true to get the Simple Shadows version of the appropriate shader.</param>
    /// <param name="UsingFastLeavesShader">Set this to true if tree.UsingFastLeavesShader is true.</param>
    /// <param name="ForceFastState">This is mainly used during the conversion by _LushLODTreesConverter.cs</param>
    /// <returns></returns>
    public static Shader GetLeavesShader(bool GetSimpleShadows, bool UsingFastLeavesShader, bool Ultra, bool Deferred, int ForceFastState = -1)
    {
        bool FastState = ForceFastState == 1 ? true : ForceFastState == 0 ? false : UsingFastLeavesShader;
        string UltraStr = "";
        string DeferredStr = "";
        if (Ultra && FastState == false) UltraStr = " Ultra"; //<--- TODO: Remove the "&& FastState == false" once I finish creating the ultra versions of the fast shaders.
        if (Ultra && Deferred && FastState == false) DeferredStr = " Deferred"; //<--- TODO: Remove the "&& FastState == false" once I finish creating the deferred versions of the fast shaders. Note, I currenly only have deferred version of the ultra shader.
        if (GetSimpleShadows)
        {
            if (FastState)
            {
                //TODO: Probably should consolidate these Shader.Find() calls so that they
                //occur in the ShaderReferences class, where all the other Shader.Find()
                //calls are located... just to make things look cleaner.
                if (TreeCreatorLeavesOptimized_FAST_SimpleShadows == null ||
                    ReferenceEquals(TreeCreatorLeavesOptimized_FAST_SimpleShadows, null) ||
                    TreeCreatorLeavesOptimized_FAST_SimpleShadows.Equals(null) ||
                    (Ultra != TreeCreatorLeavesOptimized_FAST_SimpleShadows.name.Contains(UltraStr)) ||
                    (Deferred != TreeCreatorLeavesOptimized_FAST_SimpleShadows.name.Contains(DeferredStr)))
                    TreeCreatorLeavesOptimized_FAST_SimpleShadows = Shader.Find("Hidden/LushLODTree/Tree Creator Leaves Fast Optimized Simple Shadows" + UltraStr + DeferredStr);
                return TreeCreatorLeavesOptimized_FAST_SimpleShadows;
            }
            else
            {
                if (TreeCreatorLeavesOptimized_SimpleShadows == null ||
                    ReferenceEquals(TreeCreatorLeavesOptimized_SimpleShadows, null) ||
                    TreeCreatorLeavesOptimized_SimpleShadows.Equals(null) ||
                    (Ultra != TreeCreatorLeavesOptimized_SimpleShadows.name.Contains(UltraStr)) ||
                    (Deferred != TreeCreatorLeavesOptimized_SimpleShadows.name.Contains(DeferredStr)))
                    TreeCreatorLeavesOptimized_SimpleShadows = Shader.Find("Hidden/LushLODTree/Tree Creator Leaves Optimized Simple Shadows" + UltraStr + DeferredStr);
                return TreeCreatorLeavesOptimized_SimpleShadows;
            }
        }
        else
        {
            if (FastState)
            {
                if (TreeCreatorLeavesOptimized_FAST == null ||
                    ReferenceEquals(TreeCreatorLeavesOptimized_FAST, null) ||
                    TreeCreatorLeavesOptimized_FAST.Equals(null) ||
                    (Ultra != TreeCreatorLeavesOptimized_FAST.name.Contains(UltraStr)) ||
                    (Deferred != TreeCreatorLeavesOptimized_FAST.name.Contains(DeferredStr)))
                    TreeCreatorLeavesOptimized_FAST = Shader.Find("Hidden/LushLODTree/Tree Creator Leaves Fast Optimized" + UltraStr + DeferredStr);
                return TreeCreatorLeavesOptimized_FAST;
            }
            else
            {
                if (TreeCreatorLeavesOptimized == null ||
                    ReferenceEquals(TreeCreatorLeavesOptimized, null) ||
                    TreeCreatorLeavesOptimized.Equals(null) ||
                    (Ultra != TreeCreatorLeavesOptimized.name.Contains(UltraStr)) ||
                    (Deferred != TreeCreatorLeavesOptimized.name.Contains(DeferredStr)))
                    TreeCreatorLeavesOptimized = Shader.Find("Hidden/LushLODTree/Tree Creator Leaves Optimized" + UltraStr + DeferredStr);
                return TreeCreatorLeavesOptimized;
            }
        }
    }

    /// <summary>
    /// This function returns either the Tree Creator Bark Optimized shader, or the Tree Creator Bark Optimized Simple Shadows shader.
    /// As of 9/15/2016 there is no "Fast" shader for the bark.
    /// </summary>
    /// <param name="SimpleShadows">Set this to true to get the Simple Shadows version of the appropriate shader.</param>
    /// <returns></returns>
    public static Shader GetBarkShader(bool GetSimpleShadows, bool Ultra, bool Deferred)
    {
        string UltraStr = "";
        string DeferredStr = "";
        if (Ultra) UltraStr = "_Ultra";
        if (Deferred) DeferredStr = "_Deferred";
        if (GetSimpleShadows)
        {
            if (TreeCreatorBarkOptimized_SimpleShadows == null ||
                ReferenceEquals(TreeCreatorBarkOptimized_SimpleShadows, null) ||
                TreeCreatorBarkOptimized_SimpleShadows.Equals(null) ||
                (Ultra != TreeCreatorBarkOptimized_SimpleShadows.name.Contains(UltraStr)) ||
                (Deferred != TreeCreatorBarkOptimized_SimpleShadows.name.Contains(DeferredStr)))
                TreeCreatorBarkOptimized_SimpleShadows = Shader.Find("Hidden/LushLODTree/HQTreeBark_SimpleShadows" + UltraStr + DeferredStr);
            return TreeCreatorBarkOptimized_SimpleShadows;
        }
        else
        {
            if (TreeCreatorBarkOptimized == null ||
                ReferenceEquals(TreeCreatorBarkOptimized, null) ||
                TreeCreatorBarkOptimized.Equals(null) ||
                (Ultra != TreeCreatorBarkOptimized.name.Contains(UltraStr)) ||
                (Deferred != TreeCreatorBarkOptimized.name.Contains(DeferredStr)))
                TreeCreatorBarkOptimized = Shader.Find("Hidden/LushLODTree/HQTreeBark" + UltraStr + DeferredStr);
            return TreeCreatorBarkOptimized;
        }
    }
    
    void OnDestroy()
    {
        if (IsParent)
        {
            //This tree is being destroyed, but it was a parent. This will put a "null" into the list of parents, which will
            //potentially generated null exceptions, not to mention that some children will have no parents...
            _LushLODTree.TreesManager.OnDestroyParentS();
        }
    }

    /// <summary>
    /// This simply forces a call to the Start() function for this tree.
    /// </summary>
    public void RunStart()
    {
        Start();
    }

    /// <summary>
    /// Trees need to start with certain settings every game, every time. Let's make sure that's the case.
    /// </summary>
    private void LoadSaneStartingSettings()
    {
        this.lod0Rend.enabled = true;
        this.lod0Rend.gameObject.SetActive(true);
        this.lod1Rend.enabled = true;
        this.lod1Rend.gameObject.SetActive(true);

        this.lod0Rend.shadowCastingMode = TreesManager.GetHighQualityShadowCastingMode(true);
        this.lod1Rend.shadowCastingMode = TreesManager.GetBillboardShadowCastingMode(true);

        this.lod1Rend.receiveShadows = false;

        //Load the current shadow strength from the material:
        if (this.lod0Rend != null)
        {
            Material[] mats = lod0Rend.sharedMaterials;
            float GetShadowStrength = -5f;
            foreach (Material matLoop in mats)
            {
                if (matLoop.shader.name.Contains("Leaves") == true)
                {
                    //this should be the leaves shader.
                    GetShadowStrength = matLoop.GetFloat("_ShadowStrength");
                    break;
                }
            }
            if (GetShadowStrength != -5f)
            {
                Modified_ShadowStrength = GetShadowStrength;
            }
        }
    }

    /// <summary>
    /// This function is called when the game first begins. It is called by every tree, whether its a parent, or a child tree.
    /// </summary>
    void Start()
    {

        if (TreeCreationFinished == false) return;


#if UNITY_EDITOR

        PrefabType checkme = PrefabUtility.GetPrefabType(this.gameObject);
        if (checkme.ToString() == "PrefabInstance")
        {
            PrefabUtility.DisconnectPrefabInstance(this.gameObject);
        }

        EditorUtility.SetDirty(this);


        //Check for damaged LushLOD Trees
        if (this.lod0Rend == null || this.lod1Rend == null)
        {
            Debug.LogError("Damaged _LushLODTrees are in your scene! This will generate console errors. To fix this error, click the ApplyAll button in the _LushLODTreesManager.");
        }

#endif

        Transform MyParentInHierarchyTransform = this.transform.parent;
        GameObject MyParentInHierarchy = null;
        if (MyParentInHierarchyTransform != null &&
            ReferenceEquals(MyParentInHierarchyTransform, null) != true && 
            MyParentInHierarchyTransform.Equals(null) != true)
        {
            MyParentInHierarchy = MyParentInHierarchyTransform.gameObject;
        }

        CreateTreeManager(false, false, MyParentInHierarchy);

        LoadSaneStartingSettings();

        if (this.lodDistance != TreesManager.LOD_adjust_PREVIOUS)
        {
            //This tree doesn't have the correct LOD distance.
            //We need to trigger a full recalculation of parents to fix this.
            if (warnedaboutdynamicTrees == false)
            {
                warnedaboutdynamicTrees = true;
                //User either hasn't finished setting up their trees manager, or else they are dynamically adding trees at runtime.
                UnityEngine.Debug.LogWarning("Long Warning message: Tree doesn't have correct LOD distance! This can happen if you either: (a) haven't finished setting up your parents in your tree manager, or (b) you are spawning new trees during the game. If (a) is true, then go set up your tree manager before you start the game (see the documentation if you need help with that). If (b) is true, please note that after all your trees have finished being spawned, moved, and scaled, you MUST click the \"Re-Calculate Parents\" button in the manager, or call its underlying function through your scripts. Re-Calculation of parents does not happen automatically if the game is running, you must do it yourself. Any trees that you spawn while the game is running may not work correctly until you re-calculate parents. End of long warning message!");
            }
            this.lodDistance = TreesManager.LOD_adjust_PREVIOUS;
            TreesManager.ReCalculateParents(false); //<-- false == we don't automatically recalculate parents if the game is running.
        }

        if (IsParent == false &&
                (MyParent == null ||
                ReferenceEquals(MyParent, null) ||
                MyParent.Equals(null))
           )
        {

            //This tree isn't a parent, and also doesn't have a parent.
            if (warnedaboutdynamicTrees == false)
            {
                warnedaboutdynamicTrees = true;
                //User either hasn't finished setting up their trees manager, or else they are dynamically adding trees at runtime.
                UnityEngine.Debug.LogWarning("Long Warning message: Tree doesn't have any parent! This can happen if you either: (a) haven't finished setting up your parents in your tree manager, or (b) you are spawning new trees during the game. If (a) is true, then go set up your tree manager before you start the game (see the documentation if you need help with that). If (b) is true, please note that after all your trees have finished being spawned, moved, and scaled, you MUST click the \"Re-Calculate Parents\" button in the manager, or call its underlying function through your scripts. Re-Calculation of parents does not happen automatically if the game is running, you must do it yourself. Any trees that you spawn while the game is running may not work correctly until you re-calculate parents. End of long warning message!");
            }

            //The code commented out above has been replaced with this one line:
            TreesManager.ReCalculateParents(); //<-- false == we don't automatically recalculate parents if the game is running.

        }

        Reset(); //<-- Hover your mouse to see a description of this.

        if (TreeIsSetup == false) //<-- this is only true, if the game was running and this tree hasn't been set up yet.
        {
            //apply all the current tree settings from the manager, to this tree:
            if (_LushLODTree.TreesManager != null &&
                ReferenceEquals(_LushLODTree.TreesManager, null) != true &&
                _LushLODTree.TreesManager.Equals(null) != true)
            {
                //The tree's manager exists.
                this.TreesManager_ref = _LushLODTree.TreesManager; //<-- set this tree's reference to the manager.
                if (_LushLODTree.TreesManager.TreesRoot != null &&
                    ReferenceEquals(_LushLODTree.TreesManager.TreesRoot, null) != true &&
                    _LushLODTree.TreesManager.TreesRoot.Equals(null) != true)
                {
                    //The TreesRoot gameobject isn't null, in the manager.
                    if (this.transform.parent == null ||
                        this.transform.parent.gameObject != TreesManager.TreesRoot)
                    {
                        //This tree is placed outside of the TreesRoot gameobject, in the scene's hierarchy. 
                        //This tree won't function properly if it isn't a child of that TreesRoot gameobject,
                        //and the player added this tree to the scene while the game was running, but didn't put it
                        //into the right place in the hierarchy. Before we can call the .applyall() function below, we
                        //must first fix this now, because the manager will expect this tree to be a child of the
                        //TreesRoot gameobject:
                        this.transform.parent = TreesManager.TreesRoot.transform;
                    }

                    TreesManager.ApplyAll(this); //<-- calls the function in the _LustLODTreesManager.cs to apply all changes that were made
                                                 //    in the manager, but for THIS specific tree only.
                }
            }
        }
    }

    /// <summary>
    /// This function will create the _LushLODTreesManager, if it doesn't already exist in the scene's hierarchy.
    /// </summary>
    /// <param name="WarnIfalreadyexists">If this is true, then a warning will appear in the console if the manager already exists in the scene heirarchy. Otherwise, the console warning will be skipped.</param>
    /// <param name="DoNotCreate">[Optional] Set this to true if you would like to try to find the manager, but NOT create it if it isn't found.</param>
    /// <param name="newManagersnewParentRoot">[Optional] Set this to the GameObject that will be the ParentsRoot, if you know it.</param>
    public static void CreateTreeManager(bool WarnIfalreadyexists, bool DoNotCreate = false, GameObject newManagersnewParentRoot = null)
    {
        if (TreesManager == null || ReferenceEquals(TreesManager, null) || TreesManager.Equals(null))
        {
            //The global reference to the trees manager is null, but that doesn't necessarily mean the trees manager doesn't
            //exist in the hierarchy. It could simply mean that we lost the reference to it. Let's check further:
            GameObject TreesManagerGO = GameObject.Find("_LushLODTreesManager"); //<-- try to find it this way.
            if (ReferenceEquals(TreesManagerGO, null) == false)
            {
                //Found it!
                TreesManager = TreesManagerGO.GetComponent<_LushLODTreesManager>(); //<-- try to find the script running on it.
                if (ReferenceEquals(TreesManager, null))
                {
                    //D'oh, the script got deleted off the gameobject.
                    //Let's add the script again:
                    TreesManager = TreesManagerGO.AddComponent<_LushLODTreesManager>();

#if UNITY_EDITOR
                    if (Application.isPlaying == false)
                        Undo.AddComponent<_LushLODTreesManager>(TreesManagerGO);
#endif

                    if (_LushLODTree.TreesManager.TreesRoot != null &&
                        ReferenceEquals(_LushLODTree.TreesManager.TreesRoot, null) != true &&
                        _LushLODTree.TreesManager.TreesRoot.Equals(null) != true)
                    {
                        //TreesRoot is NOT null in the manager.
                        //Not sure if this code is even reachable?
                        _LushLODTree[] allTrees = _LushLODTree.TreesManager.TreesRoot.GetComponentsInChildren<_LushLODTree>();

#if UNITY_EDITOR
                        if (Application.isPlaying == false)
                        {
                            string Desc = "Create Manager";
                            Undo.RegisterFullObjectHierarchyUndo(_LushLODTree.TreesManager.TreesRoot, Desc);
                        }
#endif

                        foreach (_LushLODTree tree in allTrees)
                        {
                            tree.TreesManager_ref = TreesManager;
                        }
                    }
                }
                else
                {
                    if (WarnIfalreadyexists)
                    {
                        UnityEngine.Debug.LogWarning("_LushLODTreesManager already exists in your scene. We found it. Everything is better now.");
                    }
                }
            }
            else
            {

                if (DoNotCreate) return; //<-- if we do not want to automatically create the manager, then exit now before we create it.

                //Couldn't find the tree's manager gameobject in the scene's hierarchy.
                //Probably because it doesn't exist. So let's add it now:
                TreesManager = new GameObject().AddComponent<_LushLODTreesManager>(); //<-- this creages both the gameobject, and also adds the necessary script to it, in one line of code.
                TreesManager.gameObject.name = "_LushLODTreesManager"; //<--- give it its name.

                if (_LushLODTree.TreesManager.TreesRoot != null &&
                    ReferenceEquals(_LushLODTree.TreesManager.TreesRoot, null) != true &&
                    _LushLODTree.TreesManager.TreesRoot.Equals(null) != true)
                {
                    //TreesRoot is NOT null in the manager.
                    //Not sure if this code is even reachable?
                    _LushLODTree[] allTrees = _LushLODTree.TreesManager.TreesRoot.GetComponentsInChildren<_LushLODTree>();

#if UNITY_EDITOR
                    if (Application.isPlaying == false)
                    {
                        string Desc = "Created Manager";
                        Undo.RegisterFullObjectHierarchyUndo(_LushLODTree.TreesManager.TreesRoot, Desc);
                    }
#endif 

                    foreach (_LushLODTree tree in allTrees)
                    {
                        tree.TreesManager_ref = TreesManager;
                    }
                }

                if (Application.isPlaying)
                {
                    //Since we added the manager dynamically to the scene, let's set its TreesRoot gameobjet to whatever is the
                    //parent gameobject for this tree.
                    if (newManagersnewParentRoot != null &&
                        ReferenceEquals(newManagersnewParentRoot, null) != true &&
                        newManagersnewParentRoot.Equals(null) != true)
                    {
                        TreesManager.TreesRoot = newManagersnewParentRoot;
                        TreesManager.ReCalculateParents();
                    }
                    else
                    {
                        //Ugh. User is trying to add trees to the game, while the game is running, and there was no manager 
                        //yet, and they are adding trees to the root of the hierarchy (with no parent
                        //gameobject above them). We added the manager above, but we can't automatically set its TreesRoot
                        //gameobject, because this tree doesn't have a parent gameobject.
                        //Dear user, if this error message is making you mad, you can simply comment it out. :)
                        //Just be aware that nothing will function correctly until the manager has its TreesRoot reference set
                        //to something other than "null", and the parents have been calculated.
                        UnityEngine.Debug.LogError("Your scene has no _LushLODTreesManager, and you appear to be adding trees to the scene, while the game is running, and you are adding trees to the root of the hierarchy. The _LushLODTreesManager has been automatically added to the scene, but its TreesRoot gameobject could not be automatically set because your tree was added to the root of the hierarchy. When you add trees to the scene, please make sure they are added as children of at least one gameobject above them in the hierarchy.");
                    }
                }

                if (Application.isPlaying)
                {
                    UnityEngine.Debug.LogWarning("Could not find _LushLODTreesManager! Creating it at runtime (this creates a delay loading the scene). To get rid of this delay, you should set up your tree manager before you start the game. To do this, exit the game, and select one of your trees, and click the button to create the LushLOD Trees Manager. Once that's done, then select it in your hierarchy, and follow the instructions to finish setting up your trees.");
                }

#if UNITY_EDITOR
                if (Application.isPlaying == false)
                    Undo.RegisterCreatedObjectUndo(TreesManager.gameObject, "Created Trees Manager");
#endif 

            }
        }
        else if (WarnIfalreadyexists)
        {
            UnityEngine.Debug.LogWarning("_LushLODTreesManager already exists in your scene. We found it. Everything is better now.");
        }

    }

    /// <summary>
    /// This static function makes sure that the static material reference(s) are properly instantiated.
    /// </summary>
    /// <param name="SpecificTree">Pass a reference to the specific _LushLODTree that will be using this atlas material.</param>
     public static void SetupStaticMaterial(_LushLODTree SpecificTree)
    {

        if (Materials_FullyOpaque_static == null ||
            ReferenceEquals(Materials_FullyOpaque_static, null) ||
            Materials_FullyOpaque_static.Equals(null) ||
            Materials_FullyOpaque_static.Count == 0)
        {
            //This is the first atlas material to be instantiated. So just do it.
            Materials_FullyOpaque_static = new List<Material_FullyOpaque_References>();
            Material_FullyOpaque_References newRef = new Material_FullyOpaque_References(SpecificTree.Material_NotInstance_FullyOpaque, SpecificTree.Material_File_ID);
            Materials_FullyOpaque_static.Add(newRef);
            SpecificTree.Material_FullyOpaque_static = newRef;
        }
        else if (Materials_FullyOpaque_static.Count > 0)
        {
            //We need to loop through the materials, and see if the static copy for this tree's atlas material has been instanted yet.
            //And if it hasn't, we'll instantiate it. And if it has (or hasn't), we will set this tree's reference to it. <-- need to create a public Material_Fully
            bool FoundIt = false;
            foreach (Material_FullyOpaque_References refs in Materials_FullyOpaque_static)
            {
                if (refs.Material_File_ID == SpecificTree.Material_File_ID)
                {
                    //We found our static material already in the list. Give this tree a reference to it.
                    FoundIt = true;
                    SpecificTree.Material_FullyOpaque_static = refs;
                    break;
                }
            }
            if (FoundIt == false)
            {
                //We didn't find our reference in the list. So add ours to the list.
                Material_FullyOpaque_References newRef = new Material_FullyOpaque_References(SpecificTree.Material_NotInstance_FullyOpaque, SpecificTree.Material_File_ID);
                SpecificTree.Material_FullyOpaque_static = newRef;
                Materials_FullyOpaque_static.Add(newRef);
            }
        }
    }

    /// <summary>
    /// This function is called when the game starts, and it is called if the LOD distance variable is changed.
    /// This function sets some of the initial values of some of the variables used by this tree, most importantly it
    /// calculates the LOD distances, and it also instantiates the materials used by this tree, if they aren't already 
    /// instantiated. This function should never be executed while the game isn't running.
    /// </summary>
    public void Reset()
    {

        if (TreeCreationFinished == false) return;

        curPosition = gameObject.transform.position;

        LodDistance_PREVIOUS = lodDistance; //<-- used to determine if the LOD distance has changed since the last time Reset() was run.

        //Temporary variables used to find the gameobjects for:
        GameObject lod0 = null; //<-- the high quality tree.
        GameObject lod1 = null; //<-- the billboard tree.

        if (transform.Find("Lod_0")) lod0 = transform.Find("Lod_0").gameObject; //<-- the high quality tree.
        if (transform.Find("Lod_1")) lod1 = transform.Find("Lod_1").gameObject; //<-- the billboard tree.

        //Calculate the transition ranges:
        sqrTransition = _LushLODTreesManager.CalculateLODDistances(lodDistance, true, TreesManager.AverageTreeScale);

        // Find the renderers:
        lod0Rend = lod0.GetComponent<Renderer>(); //<-- Gets the renderer for the high quality tree.
        lod1Rend = lod1.GetComponent<Renderer>(); //<-- gets the renderer for the billboard model of the tree.

        //Instantiate the static material, if it isn't already instantiated:
        SetupStaticMaterial(this);

        if (Application.isPlaying == true)
        {
            //The game is playing, so let's ensure that we have instantiated the various materials.
            //This ensures that when the game ends, the changes we make to these materials will not be permanent.

            if (Material_Instance_Transitioning.name != this.GetInstanceID().ToString())
            {
                //This is a cheap and ez way to ensure that this transitioning texture is being used by THIS tree and ONLY THIS TREE.
                //We set its material name to the InstanceID number of this tree. Then, if any other tree tries to use this material,
                //we will know because their InstanceID number won't match the material name. That will trigger those trees to create their own
                //instance of the material, which ensures that every tree has its own instance of it.
                Material_Instance_Transitioning = GameObject.Instantiate(Material_Instance_Transitioning); //<-- inst.
                Material_Instance_Transitioning.name = this.GetInstanceID().ToString();
                Material_Instance_Transitioning.shader = lod1Rend.sharedMaterial.shader;
            }

        }
    }

    /// <summary>
    /// Make sure this function is called anytime the ShaderSettingsChanged variable is
    /// incremented in the manager. Also, call this function at least once when the game
    /// first starts.
    /// </summary>
    public void DoShaderUpdate()
    {
        //Check that we still have our static reference to our atlas material:
        if (Material_FullyOpaque_static == null)
        {
            SetupStaticMaterial(this);
        }

        //Check if the shaders may have been changed due to a change in settings in the manager:
        if (ShaderSettingsChanged != TreesManager.ShaderSettingsChanged)
        {
            ShaderSettingsChanged = TreesManager.ShaderSettingsChanged;

            //---------------------------
            //Update all shaders:
            //---------------------------

            Shader Tree_Leaves_Using = GetBillboardLeavesShader(TreesManager.billboard_quality_PREVIOUS, TreesManager.RenderingMode_PREVIOUS);
            Shader Tree_Leaves_Far_Using = GetBillboardLeavesFarShader(TreesManager.billboard_quality_PREVIOUS, TreesManager.BillBoardSetting_PREVIOUS, TreesManager.RenderingMode_PREVIOUS);

            //Make extra certain we've instantiated our material!
            if (Material_Instance_Transitioning.name != this.GetInstanceID().ToString())
            {
                //This is a cheap and ez way to ensure that this transitioning texture is being used by THIS tree and ONLY THIS TREE.
                //We set its material name to the InstanceID number of this tree. Then, if any other tree tries to use this material,
                //we will know because their InstanceID number won't match the material name. That will trigger those trees to create their own
                //instance of the material, which ensures that every tree has its own instance of it.
                Material_Instance_Transitioning = GameObject.Instantiate(Material_Instance_Transitioning); //<-- inst.
                Material_Instance_Transitioning.name = this.GetInstanceID().ToString();
                Material_Instance_Transitioning.shader = lod1Rend.sharedMaterial.shader;
            }

            if (lod1Rend.sharedMaterial.shader.name.Contains("Far") == false)
            {

                //Make sure lod1 is actually using the instantiated material!
                if (lod1Rend.sharedMaterial.name != Material_Instance_Transitioning.name)
                {
                    lod1Rend.sharedMaterial = Material_Instance_Transitioning;
                }

                //Here, we don't change the "far" shader. We'll change the far shader below.
                //NOTE: The far shader is for trees that are far away from the camera, so they use a simplier shader that
                //skips the math on _Tranpsarency, to squeeze out maybe a little extra framerate, and most importantly,
                //to help ensure that the distant trees all share a single material, so that they'll be batched
                //together into a single draw call.
                //lod1Rend.sharedMaterial.shader = Tree_Leaves_Using;
            }
            else if (lod1Rend.sharedMaterial.shader.name.Contains("Far"))
            {

                //Make sure lod1 is actually using the instantiated material!
                if (lod1Rend.sharedMaterial.name != Material_FullyOpaque_static.Material_FullyOpaque_static.name)
                {
                    lod1Rend.sharedMaterial = Material_FullyOpaque_static.Material_FullyOpaque_static;
                }

                //This is the far shader, so set it to the far shader we selected above:
                //lod1Rend.sharedMaterial.shader = Tree_Leaves_Far_Using;
            }

            //Since the is running, the Material_Instance_Transitioning material was instanced for each tree.
            //Update this material to the new shader. This should NOT be permanent, and when the game ends this
            //should not be saved:
            Material_Instance_Transitioning.shader = Tree_Leaves_Using;

            //Update the shader for the "far" away trees also:
            Material_FullyOpaque_static.Material_FullyOpaque_static.shader = Tree_Leaves_Far_Using;

            Shader Leaves_SimpleShadows = GetLeavesShader(true, UsingFastLeavesShader, TreesManager.UsingUltraShader(true), TreesManager.RenderingMode_PREVIOUS == _LushLODTreesManager.RenderingModes.Deferred);//<-- this is the shader for simple shadows.
            Shader Leaves_AllShadows = GetLeavesShader(false, UsingFastLeavesShader, TreesManager.UsingUltraShader(true), TreesManager.RenderingMode_PREVIOUS == _LushLODTreesManager.RenderingModes.Deferred);//<-- this is the shader for high quality, but expensive shadows.
            Shader Bark_SimpleShadows = GetBarkShader(true, TreesManager.UsingUltraShader(true), TreesManager.RenderingMode_PREVIOUS == _LushLODTreesManager.RenderingModes.Deferred);//<-- this is the shader for simple shadows.
            Shader Bark_AllShadows = GetBarkShader(false, TreesManager.UsingUltraShader(true), TreesManager.RenderingMode_PREVIOUS == _LushLODTreesManager.RenderingModes.Deferred);//<-- this is the shader for high quality, but expensive shadows.

            switch (TreesManager.ShadowReceiveSetting_PREVIOUS) //<-- select our billboard setting.
            {
                case _LushLODTreesManager.ShadowReceiveSettings.AllShadows:
                    //User is requesting to use Unity's built in shadow receiving system:

                    //if the game is running, we use ".materials", which creates an instance.
                    foreach (Material mat in lod0Rend.materials) //<-- inst
                    {
                        if (mat.shader.name.Contains("Leaves"))
                            mat.shader = Leaves_AllShadows; //<-- high quality shadows.
                        else
                            mat.shader = Bark_AllShadows; //<-- high quality shadows.
                    }

                    break;
                case _LushLODTreesManager.ShadowReceiveSettings.SimpleShadows:
                    //User is requesting to use LushLOD's Simple Shadows system:

                    //if the game is running, we use ".materials", which creates an instance.
                    foreach (Material mat in lod0Rend.materials) //<-- inst
                    {
                        if (mat.shader.name.Contains("Leaves"))
                            mat.shader = Leaves_SimpleShadows; //<-- lower quality shadows (but fast!)
                        else
                            mat.shader = Bark_SimpleShadows; //<-- lower quality shadows (but fast!)
                    }
                    break;
                case _LushLODTreesManager.ShadowReceiveSettings.NoShadows:
                    //User is requesting the high quality trees will not receive any shadows at all:

                    //We must now also switch to the regular Unity shader, and not the simple shader, because
                    //the simple shader doesn't have the option to not receive shadows:

                    //if the game is running, we use ".materials", which creates an instance.
                    foreach (Material mat in lod0Rend.materials) //<-- inst
                    {
                        if (mat.shader.name.Contains("Leaves"))
                            mat.shader = Leaves_AllShadows; //<-- shadows were turned off above.
                        else
                            mat.shader = Bark_AllShadows; //<-- shadows were turned off above.
                    }
                    break;
            }
        }
    }

    void Update()
    {

#if UNITY_EDITOR

        //Check for damaged LushLOD Trees
        if (this.lod0Rend == null || this.lod1Rend == null)
        {
            Debug.LogError("Damaged _LushLODTrees are in your scene! This will generate console errors. To fix this error, click the ApplyAll button in the _LushLODTreesManager.");
            //this.enabled = false;
            return;
        }
#endif


        if (TreesManager.billboard_quality_PREVIOUS == _LushLODTreesManager.BillboardQualitySettings.Ultra)
        {
            if (Time.time < timeSkip) return;
            timeSkip = Time.time + Random.Range(0.03f, 0.06f) + Time.deltaTime;
        }

        if (TreeCreationFinished == false) return;

        //Check if the shaders may have been changed due to a change in settings in the manager:
        if (ShaderSettingsChanged != TreesManager.ShaderSettingsChanged)
        {
            DoShaderUpdate();
        }

        //If the billboard settings in the manager is set to anything other than "Use Both", then all the trees are
        //supposed to be disabled:
        if (BillBoardSetting != _LushLODTreesManager.BillBoardSettings.UseBoth)
        {
            //Turn myself off!
            this.enabled = false;
            this.MyChildrenEnabled = false; //<-- because EVERY tree is being disabled.
            return; //<-- exit this function.
        }
        
        if (LodDistance_PREVIOUS != lodDistance) Reset(); //<-- hover your mouse, I say!

        //Get the current distance from the camera to this tree. Probably the same as using Vector3.Distance():
        if (Camera.main == null) return;
        curDistance = (curPosition - Camera.main.transform.position).sqrMagnitude;

        //if (curDistance < LastDistance + 1 && curDistance > LastDistance - 1) return;
        //LastDistance = curDistance;
       
        if (curDistance < sqrTransition[4]) //<-- This is something I added. It's 2.5x the distance of where the shadow fading starts.
        {

            //Yes, this tree is remotely near the camera.
            //Now let's check exactly how close it is to the camera.

            //<--2.5x further than the [3] value, trees further than this will have their
            //scripts turned off to improve framefrates.

            if (curDistance > sqrTransition[3])
            {

                //NOTE on 9/15/2016: The next few lines of comments may be outdated and no longer completely accurate.

                //<-- [3] is where the HQ tree finishes fading away (fully invisible).
                //The LQ trees are fully opaque here.

                //The distance is beyond the transition / fade range,
                //So set only the billboard tree model to be visible:

                if (lod1Rend.enabled != true)
                    lod1Rend.enabled = true; //<-- turns on the billboard tree model.
                if (lod1Rend.sharedMaterial != Material_FullyOpaque_static.Material_FullyOpaque_static) //<-- no new instance is created here. The instance was already created earlier, in Reset().
                {
                    //Set the material for the billboard to use the fully opaque material / shader,
                    //as that's the material and shader that we use for far away trees, since they don't
                    //need the _Transparency slider, because they aren't transitioning.
                    //Hover your mouse over all this stuff around here, it's all commented with intellisense! :)
                    lod1Rend.sharedMaterial = Material_FullyOpaque_static.Material_FullyOpaque_static; //<-- no new instance is created here. The instance was already created earlier, in Reset().
                }

                if (ShadowsOnlyIsSet == true)
                {
                    ShadowsOnlyIsSet = false;
                    if (TreesManager.GetBillboardShadowCastingMode(true) != UnityEngine.Rendering.ShadowCastingMode.Off)
                    {
                        lod1Rend.shadowCastingMode = UnityEngine.Rendering.ShadowCastingMode.TwoSided;
                    }
                    else
                    {
                        lod1Rend.shadowCastingMode = UnityEngine.Rendering.ShadowCastingMode.Off;
                    }
                }

                //Disable the HQ tree renderer, since only the billboards should be visible at this great distance.
                if (lod0Rend.enabled != false)
                    lod0Rend.enabled = false;
            }
            else if (curDistance > sqrTransition[2])
            {

                //NOTE on 9/15/2016: The next few lines of comments may be outdated and no longer completely accurate.

                //<-- [2] is where the LQ tree finishes fading in, and is now fully opaque. 
                //And the HQ trees are still transitioning here.

                if (lod1Rend.enabled != true)
                    lod1Rend.enabled = true;
                if (lod1Rend.sharedMaterial != Material_FullyOpaque_static.Material_FullyOpaque_static) //<-- no new instance is created here. The instance was already created earlier, in Reset().
                {
                    //Set the material for the billboard to use the fully opaque material / shader,
                    //as that's the material and shader that we use for far away trees, since they don't
                    //need the _Transparency slider, because they aren't transitioning.
                    //Hover your mouse over all this stuff around here, it's all commented with intellisense! :)
                    lod1Rend.sharedMaterial = Material_FullyOpaque_static.Material_FullyOpaque_static; //<-- no new instance is created here. The instance was already created earlier, in Reset().
                }

                if (ShadowsOnlyIsSet == true)
                {
                    ShadowsOnlyIsSet = false;
                    if (TreesManager.GetBillboardShadowCastingMode(true) != UnityEngine.Rendering.ShadowCastingMode.Off)
                    {
                        lod1Rend.shadowCastingMode = UnityEngine.Rendering.ShadowCastingMode.TwoSided;
                    }
                    else
                    {
                        lod1Rend.shadowCastingMode = UnityEngine.Rendering.ShadowCastingMode.Off;
                    }
                }

                float s = Mathf.InverseLerp(sqrTransition[3], sqrTransition[1], curDistance);

                //Now similar for the high quality tree model.
                if (lod0Rend.enabled != true)
                    lod0Rend.enabled = true; //<-- turn them on also. Both the billboards and the high quality trees will be on.
                if (rendIsFloat != s) //<-- check if the transparency is already correct. I did this to improve speed, but I didn't actually benchmark this to see if it made any difference. Feel free to check if this is even helpful or not.
                {
                    rendIs1 = false; //<-- transparency probably won't be exactly 1.
                    rendIsFloat = s; //<-- save what the transparency will be.
                    float shadowStr = Mathf.Clamp01(Modified_ShadowStrength - Mathf.Clamp01(0.5f - s));
                    lastShadowStr = billboard_quality_PREVIOUS == _LushLODTreesManager.BillboardQualitySettings.Ultra ? Mathf.Max(1f, shadowStr) : shadowStr;
                    foreach (Material mat in lod0Rend.materials) //<-- we'll use ".materials", which will create instances
                                                                //of all the materials for the high quality tree, if they aren't
                                                                //already instances, then it will clone them. This is necessary
                                                                //because otherwise if all the high quality trees share the same 
                                                                //instance of any of their materials, then whenever one of them
                                                                //modifies the transparency, it would affect them all. Which isn't
                                                                //what we want. We want every tree to have a different level of
                                                                //transparency as they transition. Unfortunantly, by instantiating
                                                                //their materials like this, we lose the batching that Unity
                                                                //would do, so the high quality trees will generate one draw call
                                                                //for each of their high quality materials. That cannot be helped.
                    {
                        //Set the transparency of the high quality tree. It'll be the inverse of the transparency of the
                        //billboards. In this case, the billboards are set to "1 minus s", so the high quality trees will be
                        //the inverse of this, which is simply "s" (without the "1 minus").
                        mat.SetFloat("_Transparency", s);
                        mat.SetFloat("_ShadowStrength", lastShadowStr);
                    }
                }

            }
            else if (curDistance > sqrTransition[1])
            {

                //NOTE on 9/15/2016: The next few lines of comments may be outdated and no longer completely accurate.

                //<-- [1] is where the HQ tree finishes fading in (fully opaque).
                //And the LQ trees are still transitioning here. 
                //Also The LQ shadows fade between ZERO distance from the camera
                //(fully invisible), and this point (fully opaque).

                float s = Mathf.InverseLerp(sqrTransition[3], sqrTransition[1], curDistance); //<-- transition range for HQ trees.
                float s2 = Mathf.InverseLerp(sqrTransition[2], sqrTransition[0], curDistance); //<-- transition range for LQ trees.
                float s3 = s;

                if (billboard_quality_PREVIOUS == _LushLODTreesManager.BillboardQualitySettings.Ultra)
                {
                    s3 = Mathf.InverseLerp(TreesManager.halfsqrTransition, 0f, curDistance); //<-- transition range for LQ tree shadows.
                }

                if (lod1Rend.enabled != true)
                    lod1Rend.enabled = true;
                if (lod1Rend.sharedMaterial != Material_Instance_Transitioning) //<-- hover your mouse to see description.
                {
                    //Set the billboard to use the "transitioning" material / shader.
                    //Unlike the fully opaque material, this transitioning material must be instantiated, which is
                    //explained if you hover your mouse over it here.
                    //HOWEVER, we already instantiated it, in the Reset() function. So there is no need to 
                    //instantiate it again here. So we will use the .sharedMaterial here, to avoid instantiating
                    //it again. Note: .sharedMaterial is a feature builtin to Unity, so I won't explain it here.
                    lod1Rend.sharedMaterial = Material_Instance_Transitioning; //<-- must inst it (instance was made earlier)
                }

                //Set the transparency of the billboard, it'll be 1 minus "s2", which we calculated above:
                lod1Rend.sharedMaterial.SetFloat("_Transparency", 1 - s2); //<-- (instance was made earlier). 

                if (ShadowsOnlyIsSet == true)
                {
                    ShadowsOnlyIsSet = false;
                    if (TreesManager.GetBillboardShadowCastingMode(true) != UnityEngine.Rendering.ShadowCastingMode.Off)
                    {
                        lod1Rend.shadowCastingMode = UnityEngine.Rendering.ShadowCastingMode.TwoSided;
                    }
                    else
                    {
                        lod1Rend.shadowCastingMode = UnityEngine.Rendering.ShadowCastingMode.Off;
                    }
                }

                switch (RealTimeShadowSetting)
                {
                    case _LushLODTreesManager.RealTimeShadowSettings.UseBoth:
                        if (billboard_quality_PREVIOUS == _LushLODTreesManager.BillboardQualitySettings.Ultra)
                        {
                            lod1Rend.sharedMaterial.SetFloat("_ShadowTransparency", 1 - s3); //<-- (instance was made earlier)
                        }
                        else
                        {
                            //lod1Rend.sharedMaterial.SetFloat("_ShadowTransparency", 1 - s2); //<-- (instance was made earlier)
                            lod1Rend.sharedMaterial.SetFloat("_ShadowTransparency", 1f); //<-- (instance was made earlier)
                        }
                        break;
                    case _LushLODTreesManager.RealTimeShadowSettings.BillboardOnly:
                        lod1Rend.sharedMaterial.SetFloat("_ShadowTransparency", 1f); //<-- (instance was made earlier)
                        break;
                    case _LushLODTreesManager.RealTimeShadowSettings.RealtimeShadowsOff:
                        //lod1Rend.sharedMaterial.SetFloat("_ShadowTransparency", 0f); //<-- (instance was made earlier)

                        if (billboard_quality_PREVIOUS == _LushLODTreesManager.BillboardQualitySettings.Ultra)
                        {
                            lod1Rend.sharedMaterial.SetFloat("_ShadowTransparency", 1 - s3); //<-- (instance was made earlier)
                        }
                        else
                        {
                            lod1Rend.sharedMaterial.SetFloat("_ShadowTransparency", 1 - s2); //<-- (instance was made earlier)
                            //lod1Rend.sharedMaterial.SetFloat("_ShadowTransparency", 0f); //<-- (instance was made earlier)
                        }

                        break;                  
                }

                //Now similar for the high quality tree model.
                if (lod0Rend.enabled != true)
                    lod0Rend.enabled = true; //<-- turn them on also. Both the billboards and the high quality trees will be on.
                if (rendIsFloat != s) //<-- check if the transparency is already correct. I did this to improve speed, but I didn't actually benchmark this to see if it made any difference. Feel free to check if this is even helpful or not.
                {
                    rendIs1 = false; //<-- transparency probably won't be exactly 1.
                    rendIsFloat = s; //<-- save what the transparency will be.
                    float shadowStr = Mathf.Clamp01(Modified_ShadowStrength - Mathf.Clamp01(0.5f - s3));
                    lastShadowStr = billboard_quality_PREVIOUS == _LushLODTreesManager.BillboardQualitySettings.Ultra ? Mathf.Max(1f, shadowStr) : shadowStr;
                    foreach (Material mat in lod0Rend.materials) //<-- we'll use ".materials", which will create instances
                                                                //of all the materials for the high quality tree, if they aren't
                                                                //already instances, then it will clone them. This is necessary
                                                                //because otherwise if all the high quality trees share the same 
                                                                //instance of any of their materials, then whenever one of them
                                                                //modifies the transparency, it would affect them all. Which isn't
                                                                //what we want. We want every tree to have a different level of
                                                                //transparency as they transition. Unfortunantly, by instantiating
                                                                //their materials like this, we lose the batching that Unity
                                                                //would do, so the high quality trees will generate one draw call
                                                                //for each of their high quality materials. That cannot be helped.
                    {
                        //Set the transparency of the high quality tree. It'll be the inverse of the transparency of the
                        //billboards. In this case, the billboards are set to "1 minus s", so the high quality trees will be
                        //the inverse of this, which is simply "s" (without the "1 minus").
                        mat.SetFloat("_Transparency", s);
                        mat.SetFloat("_ShadowStrength", lastShadowStr);
                    }
                }
            }
            else if (curDistance > sqrTransition[0])
            {

                //NOTE on 9/15/2016: The next few lines of comments may be outdated and no longer completely accurate.

                //<-- [0] is where the LQ tree finishes fading away, and is now fully
                //invisible. And the LQ shadows are still transitioning here.

                float s2 = Mathf.InverseLerp(sqrTransition[2], sqrTransition[0], curDistance); //<-- transition range for LQ trees.
                float s3 = Mathf.InverseLerp(TreesManager.halfsqrTransition, 0f, curDistance); //<-- transition range for LQ tree shadows;

                //float s2 = Mathf.InverseLerp(sqrTransition[2], sqrTransition[0], curDistance); //<-- transition range for LQ trees.

                if (lod1Rend.enabled != true)
                    lod1Rend.enabled = true;

                if (lod1Rend.sharedMaterial != Material_Instance_Transitioning) //<-- hover your mouse to see description.
                {
                    //Set the billboard to use the "transitioning" material / shader.
                    //Unlike the fully opaque material, this transitioning material must be instantiated, which is
                    //explained if you hover your mouse over it here.
                    //HOWEVER, we already instantiated it, in the Reset() function. So there is no need to 
                    //instantiate it again here. So we will use the .sharedMaterial here, to avoid instantiating
                    //it again. Note: .sharedMaterial is a feature builtin to Unity, so I won't explain it here.
                    lod1Rend.sharedMaterial = Material_Instance_Transitioning; //<-- must inst it (instance was made earlier)
                }

                //Set the transparency of the billboard, it'll be 1 minus "s2", which we calculated above:
                lod1Rend.sharedMaterial.SetFloat("_Transparency", 1 - s2); //<-- (instance was made earlier). 

                if (ShadowsOnlyIsSet == true)
                {
                    ShadowsOnlyIsSet = false;
                    if (TreesManager.GetBillboardShadowCastingMode(true) != UnityEngine.Rendering.ShadowCastingMode.Off)
                    {
                        lod1Rend.shadowCastingMode = UnityEngine.Rendering.ShadowCastingMode.TwoSided;
                    }
                    else
                    {
                        lod1Rend.shadowCastingMode = UnityEngine.Rendering.ShadowCastingMode.Off;
                    }
                }

                switch (RealTimeShadowSetting)
                {
                    case _LushLODTreesManager.RealTimeShadowSettings.UseBoth:
                        //float s = Mathf.InverseLerp(TreesManager.halfsqrTransition, 0f, curDistance); //<-- transition range for LQ tree shadows.
                        //lod1Rend.sharedMaterial.SetFloat("_ShadowTransparency", 1 - s3); //<-- (instance was made earlier)

                        if (billboard_quality_PREVIOUS == _LushLODTreesManager.BillboardQualitySettings.Ultra)
                        {
                            lod1Rend.sharedMaterial.SetFloat("_ShadowTransparency", 1 - s3); //<-- (instance was made earlier)
                        }
                        else
                        {
                            lod1Rend.sharedMaterial.SetFloat("_ShadowTransparency", 1 - s2); //<-- (instance was made earlier)
                            //lod1Rend.sharedMaterial.SetFloat("_ShadowTransparency", 0f); //<-- (instance was made earlier)
                        }

                        break;
                    case _LushLODTreesManager.RealTimeShadowSettings.BillboardOnly:
                        lod1Rend.sharedMaterial.SetFloat("_ShadowTransparency", 1f); //<-- (instance was made earlier)
                        break;
                    case _LushLODTreesManager.RealTimeShadowSettings.RealtimeShadowsOff:
                        //lod1Rend.sharedMaterial.SetFloat("_ShadowTransparency", 0f); //<-- (instance was made earlier)

                        if (billboard_quality_PREVIOUS == _LushLODTreesManager.BillboardQualitySettings.Ultra)
                        {
                            lod1Rend.sharedMaterial.SetFloat("_ShadowTransparency", 1 - s3); //<-- (instance was made earlier)
                        }
                        else
                        {
                            lod1Rend.sharedMaterial.SetFloat("_ShadowTransparency", 1 - s2); //<-- (instance was made earlier)
                            //lod1Rend.sharedMaterial.SetFloat("_ShadowTransparency", 0f); //<-- (instance was made earlier)
                        }
                        break;
                }

                //Now similar for the high quality tree model.
                if (lod0Rend.enabled != true)
                    lod0Rend.enabled = true; //<-- turn them on also. Both the billboards and the high quality trees will be on.
                if (rendIs1 != true)
                {
                    rendIs1 = true; //<-- transparency is now 1.
                    rendIsFloat = 1f; //<-- save what the transparency will be.
                    lastShadowStr = billboard_quality_PREVIOUS == _LushLODTreesManager.BillboardQualitySettings.Ultra ? Mathf.Max(1f, Modified_ShadowStrength) : Modified_ShadowStrength;
                    //TODO: I think the code below could actually NOT instance the material, since the transparency
                    //is always going to be set to exactly "1". So instead we maybe could use a
                    //shared global insance of each high quality material, and possibly doing so would allow the high
                    //quality trees to be batched to fewer draw calls when they are very close to the camera.
                    foreach (Material mat in lod0Rend.materials) //<-- makes an inst
                    {
                        mat.SetFloat("_Transparency", 1f); //<-- fully opaque.
                        mat.SetFloat("_ShadowStrength", lastShadowStr);
                    }
                }
            }
            else
            {
                //NOTE on 9/15/2016: The next few lines of comments may be outdated and no longer completely accurate.

                //The distance is between the camera itself, and [0],
                //so set the LQ trees to fully invisible, the HQ trees to fully opaque,
                //and transition the LQ shadows.

                if (lod1Rend.enabled != true)
                    lod1Rend.enabled = true;
                if (lod1Rend.sharedMaterial != Material_Instance_Transitioning) //<-- hover your mouse to see description.
                {
                    //Set the billboard to use the "transitioning" material / shader.
                    //Unlike the fully opaque material, this transitioning material must be instantiated, which is
                    //explained if you hover your mouse over it here.
                    //HOWEVER, we already instantiated it, in the Reset() function. So there is no need to 
                    //instantiate it again here. So we will use the .sharedMaterial here, to avoid instantiating
                    //it again. Note: .sharedMaterial is a feature builtin to Unity, so I won't explain it here.
                    lod1Rend.sharedMaterial = Material_Instance_Transitioning; //<-- must inst it (instance was made earlier)
                }

                //Set the transparency of the billboard.
                lod1Rend.sharedMaterial.SetFloat("_Transparency", 0f); //<-- (instance was made earlier). This sets the LQ tree to fully invisible, while we fade out its shadows.

                ShadowsOnlyIsSet = true;
                UnityEngine.Rendering.ShadowCastingMode GetMode = TreesManager.GetBillboardShadowCastingMode(true);
                if (GetMode != UnityEngine.Rendering.ShadowCastingMode.Off &&
                    _LushLODPostProcessor_DisableHQ.DisablingHQ == false) //<-- don't disable the LQ trees, if we are running a script that disables the HQ trees, otherwise both would be disabled!
                {
                    lod1Rend.shadowCastingMode = UnityEngine.Rendering.ShadowCastingMode.ShadowsOnly;
                }
                else
                {
                    //lod1Rend.shadowCastingMode = UnityEngine.Rendering.ShadowCastingMode.Off;
                    lod1Rend.shadowCastingMode = GetMode;
                }

                switch (RealTimeShadowSetting)
                {
                    case _LushLODTreesManager.RealTimeShadowSettings.UseBoth:
                        //float s = Mathf.InverseLerp(TreesManager.halfsqrTransition, 0f, curDistance); //<-- transition range for LQ tree shadows.
                        lod1Rend.sharedMaterial.SetFloat("_ShadowTransparency", 0f);// 1 - s); //<-- (instance was made earlier). This fades out the shadows of the LQ tree, which is the only thing we're doing in this area of code.
                        break;
                    case _LushLODTreesManager.RealTimeShadowSettings.BillboardOnly:
                        lod1Rend.sharedMaterial.SetFloat("_ShadowTransparency", 1f); //<-- (instance was made earlier)
                        break;
                    case _LushLODTreesManager.RealTimeShadowSettings.RealtimeShadowsOff:
                        lod1Rend.sharedMaterial.SetFloat("_ShadowTransparency", 0f); //<-- (instance was made earlier)
                        break;
                }

                //Now similar for the high quality tree model.
                if (lod0Rend.enabled != true)
                    lod0Rend.enabled = true; //<-- turn them on also. Both the billboards and the high quality trees will be on.
                if (rendIs1 != true)
                {
                    rendIs1 = true; //<-- transparency is now 1.
                    rendIsFloat = 1f; //<-- save what the transparency will be.
                    lastShadowStr = billboard_quality_PREVIOUS == _LushLODTreesManager.BillboardQualitySettings.Ultra ? Mathf.Max(1f, Modified_ShadowStrength) : Modified_ShadowStrength;
                    //TODO: I think the code below could actually NOT instance the material, since the transparency
                    //is always going to be set to exactly "1". So instead we maybe could use a
                    //shared global insance of each high quality material, and possibly doing so would allow the high
                    //quality trees to be batched to fewer draw calls when they are very close to the camera.
                    foreach (Material mat in lod0Rend.materials) //<-- makes an inst
                    {
                        mat.SetFloat("_Transparency", 1f); //<-- fully opaque.
                        mat.SetFloat("_ShadowStrength", lastShadowStr);
                    }
                }
            }

            //My children should be enabled:
            if (MyChildrenEnabled == false || CheckChildren == true) //<-- hover mouse to see descriptions.
            {
                if (MyChildren != null && 
                    ReferenceEquals(MyChildren, null) != true && 
                    MyChildren.Equals(null) != true && 
                    MyChildren.Count > 0)
                {
                    foreach (_LushLODTree child in MyChildren)
                    {

                        if (child == null ||
                            ReferenceEquals(child, null) ||
                            child.Equals(null))
                        {
                            //Ugh, we seem to have lost a referece to a child. Perhaps the user deleted a tree?
                            if (_LushLODTree.TreesManager.should_recalculate_parents == false &&
                                _LushLODTree.TreesManager.IsInvoking("OnDestroyParent") == false)
                            {
                                //This will simply trigger the parents to be recalculated after a short delay.
                                _LushLODTree.TreesManager.OnDestroyParentS();
                            }
                            return;
                        }

                        if (child.enabled != true)
                            child.enabled = true;
                    }
                }
                CheckChildren = false;
                MyChildrenEnabled = true;
            }
        }
        else
        {
            //The camera is very far away, beyond the range of any range we care about.
            //In this case, we'll display only a fully opaque billboard,
            //and if this tree is a parent, it'll turn its children completely off.

            if (lod1Rend.enabled != true)
                lod1Rend.enabled = true; //<-- turns on the billboard.
            if (lod1Rend.sharedMaterial != Material_FullyOpaque_static.Material_FullyOpaque_static)
            {
                //Set the billboard to use the fully opaque material.
                lod1Rend.sharedMaterial = Material_FullyOpaque_static.Material_FullyOpaque_static; //<-- no new instance is created here. The instance was already created earlier, in Reset().
            }

            if (ShadowsOnlyIsSet == true)
            {
                ShadowsOnlyIsSet = false;
                if (TreesManager.GetBillboardShadowCastingMode(true) != UnityEngine.Rendering.ShadowCastingMode.Off)
                {
                    lod1Rend.shadowCastingMode = UnityEngine.Rendering.ShadowCastingMode.TwoSided;
                }
                else
                {
                    lod1Rend.shadowCastingMode = UnityEngine.Rendering.ShadowCastingMode.Off;
                }
            }

            //Disable the renderer for the high quality tree:
            if (lod0Rend.enabled != false)
                lod0Rend.enabled = false; //<-- turns off the high quality tree model.

            //My children should be disabled:
            if (MyChildrenEnabled == true || CheckChildren == true)
            {
                if (MyChildren != null && 
                    ReferenceEquals(MyChildren, null) != true && 
                    MyChildren.Equals(null) != true && 
                    MyChildren.Count > 0)
                {
                    //We can't just "turn off" the chilren, because they might not be displaying billboards yet.
                    //So first, we must make sure that they are displaying fully opaque billboards.
                    //Then we'll turn their scripts off.

                    //Loop through all our children trees:
                    foreach (_LushLODTree child in MyChildren) //<-- hover mouse to see description.
                    {

                        if (child == null ||
                            ReferenceEquals(child, null) ||
                            child.Equals(null))
                        {
                            //Ugh, we seem to have lost a referece to a child. Perhaps the user deleted a tree?
                            if (_LushLODTree.TreesManager.should_recalculate_parents == false &&
                               _LushLODTree.TreesManager.IsInvoking("OnDestroyParent") == false)
                            {
                                //This will simply trigger the parents to be recalculated after a short delay.
                                _LushLODTree.TreesManager.OnDestroyParentS();
                            }
                            return;
                        }

                        if (child.lod1Rend.enabled != true)
                            child.lod1Rend.enabled = true; //<-- turn this child's billboard renderer ON.
                        if (child.lod1Rend.sharedMaterial != child.Material_FullyOpaque_static.Material_FullyOpaque_static)
                        {
                            //Set this child's billboard to use the fully opaque material.
                            //Don't forget to use .child here, or else we'll set this child to use OUR material, and our material may not be the same one. :)
                            child.lod1Rend.sharedMaterial = child.Material_FullyOpaque_static.Material_FullyOpaque_static; //<-- no new instance is created here. The instance was already created earlier, in Reset().
                        }
                        //Disable this child tree's high quality tree renderer:
                        if (child.lod0Rend.enabled != false)
                            child.lod0Rend.enabled = false; //<-- high qualty tree renderer = off.

                        //Turn the child's _LustLODTree.cs script OFF, so it won't waste CPU useage calling it's Update() anymore.
                        if (child.enabled != false)
                            child.enabled = false; //<-- say hello to faster framerate.
                    }
                }
                CheckChildren = false;
                MyChildrenEnabled = false;
            }
        }
    }
}

#if UNITY_EDITOR
// Custom Editor using SerializedProperties.
// Automatic handling of multi-object editing, undo, and prefab overrides.
[CustomEditor(typeof(_LushLODTree))]
//[CanEditMultipleObjects] <-- noooooo, the prefab upgrade / revert buttons wouldn't work right.
public class LushLODTree_Editor : Editor
{

    SerializedProperty TreeIsSetup;

    private float ShadowStrength;
    private float ShadowStrength_PREVIOUS;

    void OnDestroy()
    {
        if (((_LushLODTree)this.target) == null
            || ReferenceEquals(((_LushLODTree)this.target), null) 
            || ((_LushLODTree)this.target).Equals(null))
        {
            //This tree is being destroyed, and I suppose we have no way to detect if it was a parent or not. 
            //If it was a parent, this will put a "null" into the list of parents, which will
            //potentially generated null exceptions, not to mention that some children will have no parents...
            if (_LushLODTree.TreesManager != null &&
                ReferenceEquals(_LushLODTree.TreesManager, null) != true &&
                _LushLODTree.TreesManager.Equals(null) != true)
            {
                _LushLODTree.TreesManager.OnDestroyParentS();
            }
        }
    }

    void OnEnable()
    {

        TreeIsSetup = serializedObject.FindProperty("TreeIsSetup");

        PrefabType checkme = PrefabUtility.GetPrefabType(((_LushLODTree)this.target).gameObject);
        
        if (checkme.ToString() == "Prefab")
        {
            return; //<-- the user probably has selected the actual prefab file, on the hard drive, in the project view
                    //    Selecting the prefab file in the project view window DOES trigger this OnEnable() function, which is stupid.
                    //    Don't edit this file, or else we would damage the prefab. So we exit here.
        }

        if (_LushLODTree.TreesManager == null || 
            ReferenceEquals(_LushLODTree.TreesManager, null) || 
            _LushLODTree.TreesManager.Equals(null))
        {

            if (((_LushLODTree)this.target).TreesManager_ref != null)
            {
                _LushLODTree.TreesManager = ((_LushLODTree)this.target).TreesManager_ref;
            }
            else
            {
                //Try to find the manager, but do not create it automatically:
                _LushLODTree.CreateTreeManager(false, true);
            }
        }

        if (TreeIsSetup.boolValue == false)
        {

            //run some setup code on this tree.

            if (checkme.ToString() == "PrefabInstance")
            {
                PrefabUtility.DisconnectPrefabInstance(((_LushLODTree)this.target).gameObject);
            }
            else if (checkme.ToString() == "Prefab")
            {
                return; //<-- the user probably has selected the actual prefab file, on the hard drive, in the project view. Don't edit this file.
            }

            EditorUtility.SetDirty(((_LushLODTree)this.target));

            //Instantiate the static material, if it isn't already instantiated:
            _LushLODTree.SetupStaticMaterial(((_LushLODTree)this.target));

            //apply all the current tree settings from the manager, to this tree:
            if (_LushLODTree.TreesManager != null &&
                ReferenceEquals(_LushLODTree.TreesManager, null) != true &&
                _LushLODTree.TreesManager.Equals(null) != true)
            {
                //The tree's manager exists.
                ((_LushLODTree)this.target).TreesManager_ref = _LushLODTree.TreesManager; //<-- set this tree's reference to the manager.
                if (_LushLODTree.TreesManager.TreesRoot != null &&
                    ReferenceEquals(_LushLODTree.TreesManager.TreesRoot, null) != true &&
                    _LushLODTree.TreesManager.TreesRoot.Equals(null) != true)
                {
                    //The TreesRoot gameobject isn't null, in the manager.
                    if (((_LushLODTree)this.target).transform.parent == null ||
                        ((_LushLODTree)this.target).transform.parent.gameObject != _LushLODTree.TreesManager.TreesRoot)
                    {
                        //This tree is placed outside of the TreesRoot gameobject, in the scene's hierarchy. 
                        //This tree won't function properly if it isn't a child of that TreesRoot gameobject,
                        //and the player added this tree to the scene while the game was running, but didn't put it
                        //into the right place in the hierarchy. Before we can call the .applyall() function below, we
                        //must first fix this now, because the manager will expect this tree to be a child of the
                        //TreesRoot gameobject:
                        ((_LushLODTree)this.target).transform.parent = _LushLODTree.TreesManager.TreesRoot.transform;
                    }

                    _LushLODTree.TreesManager.ApplyAll(((_LushLODTree)this.target)); //<-- calls the function in the _LustLODTreesManager.cs to apply all changes that were made
                                                                                     //    in the manager, but for THIS specific tree only.
                    
                    //Set the tree to the correct preview mode.
                    _LushLODTree.TreesManager.UpdateTreesPreview(((_LushLODTree)this.target), true, false);

                    _LushLODTree.TreesManager.ReCalculateParents(false); //<-- false == we don't recalculate parents if the game is running.

                    // Update the serializedProperty - this loads the changes that were made by the above call to applyall().
                    serializedObject.Update();

                    //This has to be called AFTER serializedObject.Update(), or else it gets set back to false again.
                    TreeIsSetup.boolValue = true;

                }
            }
        }

        if (Application.isPlaying == false)
        {
            //Load the current shadow strength from the material:
            Material[] mats = ((_LushLODTree)this.target).lod0Rend.sharedMaterials;
            float GetShadowStrength =  5f;
            foreach (Material matLoop in mats)
            {
                if (matLoop.shader.name.Contains("Leaves") == true)
                {
                    //this should be the leaves shader.
                    GetShadowStrength = matLoop.GetFloat("_ShadowStrength");
                    break;
                }
            }
            if (GetShadowStrength != -5f)
            {
                ShadowStrength = GetShadowStrength;
                ShadowStrength_PREVIOUS = GetShadowStrength;
                ((_LushLODTree)this.target).Modified_ShadowStrength = GetShadowStrength;
            }
        }


        // Apply changes to the serializedProperty - always do this in the end of OnInspectorGUI.
        serializedObject.ApplyModifiedProperties(); //<-- this is a builtin Unity function.

    }

    public override void OnInspectorGUI()
    {

        // Update the serializedProperty - always do this in the beginning of OnInspectorGUI.
        serializedObject.Update();

        //Set up some text styles, such as red text, bold red text, etc:
        GUIStyle Redstyle = new GUIStyle(GUI.skin.box);
        GUIStyle Greenstyle = new GUIStyle(GUI.skin.box);
        GUIStyle style = new GUIStyle(GUI.skin.button);
        GUIStyle BoldRedstyle = new GUIStyle(GUI.skin.box);
        Redstyle.normal.textColor = Color.red;
        Greenstyle.normal.textColor = Color.blue;
        Greenstyle.fontStyle = FontStyle.Bold;
        style.fontStyle = FontStyle.Bold;
        BoldRedstyle.normal.textColor = Color.red;
        BoldRedstyle.fontStyle = FontStyle.Bold;

        GUIStyle RegularStyleColorUSEME = new GUIStyle(GUI.skin.label);
        GUIStyle RegularStyleBox = new GUIStyle(GUI.skin.box);

        RegularStyleBox.normal.background = RegularStyleColorUSEME.normal.background;
        RegularStyleBox.normal.textColor = RegularStyleColorUSEME.normal.textColor;
        RegularStyleBox.alignment = TextAnchor.UpperLeft;
        RegularStyleBox.padding = new RectOffset(5, 5, 5, 5);


        PrefabType checkme = PrefabUtility.GetPrefabType(((_LushLODTree)this.target).gameObject);
        if (checkme.ToString() == "Prefab")
        {

            GUILayout.Box("HI! This is a Prefab for a LushLOD Tree! You can drag and drop this tree into your scene.", Greenstyle);

            GUILayout.Box("This prefab was created my the LushLODTree converter script. Please do not modify the prefab directly, unless you know how prefabs work and you want the changes to be permanent!", Redstyle);

            // Apply changes to the serializedProperty - always do this in the end of OnInspectorGUI.
            serializedObject.ApplyModifiedProperties();

            // Show default inspector property editor
            //DrawDefaultInspector();

            return; //<-- the user probably has selected the actual prefab file, on the hard drive, in the project view. 
                    //    Selecting the prefab file in the project view window DOES trigger this OnEnable() function, which is stupid.
                    //    Don't edit this file, or else we would damage the prefab. So we exit here.
        }

        if (_LushLODTree.TreesManager == null || 
            ReferenceEquals(_LushLODTree.TreesManager, null) ||
            _LushLODTree.TreesManager.Equals(null))
        {

            if (((_LushLODTree)this.target).TreesManager_ref != null)
            {
                _LushLODTree.TreesManager = ((_LushLODTree)this.target).TreesManager_ref;
            }
            else
            {
                GUILayout.Space(10f);
                GUILayout.Label("Setup:");

                Transform MyParentInHierarchyTransform = ((_LushLODTree)this.target).transform.parent;
                GameObject MyParentInHierarchy = null;
                if (MyParentInHierarchyTransform != null && 
                    ReferenceEquals(MyParentInHierarchyTransform, null) != true && 
                    MyParentInHierarchyTransform.Equals(null) != true)
                {
                    MyParentInHierarchy = MyParentInHierarchyTransform.gameObject;
                }


                if (GUILayout.Button("Create _LushLODTreesManager"))
                {
                    _LushLODTree.CreateTreeManager(true, false, MyParentInHierarchy);
                    UnityEditor.Selection.activeObject = _LushLODTree.TreesManager.gameObject;
                }

                GUILayout.Space(10f);

            }

            GUILayout.Box("_LushLODTreesManager not found in your hierarchy.", Redstyle);
            GUILayout.Box("HI! This is a LushLOD Tree! If you're looking to modify this tree's shader, materials, renderers or other settings, you can change most settings using the _LushLODTreesManager found in your scene's Hierarchy. Thanks!", Redstyle);

        }
        else
        {
            GUILayout.Box("_LushLODTreesManager is in your hierarchy.", Greenstyle);

            if (((_LushLODTree)this.target).transform.parent == null ||
                _LushLODTree.TreesManager.TreesRoot == null ||
                ReferenceEquals(_LushLODTree.TreesManager.TreesRoot, null) ||
                _LushLODTree.TreesManager.TreesRoot.Equals(null) ||
                ((_LushLODTree)this.target).transform.parent.gameObject != _LushLODTree.TreesManager.TreesRoot)
            {
                //This tree is placed outside of the TreesRoot gameobject, in the scene's hierarchy. 

                if (((_LushLODTree)this.target).transform.parent == null)
                {
                    GUILayout.Box("Warning: This tree has no parent in the scene's Hierarchy! Please create a TreesRoot GameObject, and put this tree into it. If you don't know how to do this, please see the Quick Start guide in the documentation.", Redstyle);
                }
                else if (_LushLODTree.TreesManager.TreesRoot == null ||
                    ReferenceEquals(_LushLODTree.TreesManager.TreesRoot, null) ||
                    _LushLODTree.TreesManager.TreesRoot.Equals(null))
                {
                    GUILayout.Box("Warning: Your trees manager isn't finished being set up. Please check your tree manager, and finish setting up your TreesRoot. For more information about how to correctly set up the tree's root, please see the documentation.", Redstyle);
                }
                else
                {
                    GUILayout.Box("Warning: This tree is not a child of the TreesRoot GameObject associated with your trees manager, or you trees manager isn't set up correctly. Please check your tree manager's TreesRoot, and ensure it is set to this tree's parent. For more information about how to correctly set up the tree's root, please see the documentation.", Redstyle);
                }
                GUILayout.Box("HI! This is a LushLOD Tree! If you're looking to modify this tree's shader, materials, renderers or other settings, you can change most settings using the _LushLODTreesManager found in your scene's Hierarchy. Thanks!", Redstyle);

            }
            else
            {
                GUILayout.Box("This tree's parent GameObject is correctly linked to the Manager's TreesRoot.", Greenstyle);

                GUILayout.Space(10f);
                GUILayout.Box("HI! This is a LushLOD Tree! If you're looking to modify this tree's shader, materials, renderers or other settings, you can change most settings using the _LushLODTreesManager found in your scene's Hierarchy. Thanks!", Redstyle);

                if (!Application.isPlaying && _LushLODTree.TreesManager.ShadowBakingReady != true)
                {

                    GUILayout.Space(20f);
                    GUILayout.Label("Shadow Settings:");
                    GUILayout.Box("While most shadow settings are controlled in the LushLOD Tree's manager, it may be helpful to seperately adjust the shadow for each type of tree. Use the slider below to adjust the Shadow Size for this tree. Note that you can adjust the Shadow Size for all of your trees simultaniously, using the LushLOD Tree's manager. Also note that this feature is part of the Simple Shadows system, and this has NO affect unless you have \"Simple Shadows\" mode enabled in the manager. Also note that this tree is called an \"" + ((_LushLODTree)this.target).Original_TreeName + "\", and this change will affect ALL trees of this same type that are in your scene. Also please be aware that the billbord is unaffected by Shadow Size, so doing over drastic changes to the Shadow Size can make the billboards no longer match the appearance of the high quality trees. The only option to adjust the amount of shadows in the billboards is to use the Shadow Clip option, which is in the manager.", RegularStyleBox);
                    GUILayout.BeginHorizontal();
                    //GUILayout.Label("Shadow Size (" + ShadowStrength + ")");
                    //ShadowStrength = float.Parse(GUILayout.HorizontalSlider(ShadowStrength, -1f, 2f).ToString("#0.00"));

                    EditorGUILayout.Slider("Shadow Size", ShadowStrength, -1f, 2f);

                    GUILayout.EndHorizontal();

                    if (ShadowStrength != ShadowStrength_PREVIOUS)
                    {
                        ShadowStrength_PREVIOUS = ShadowStrength;
                        ((_LushLODTree)this.target).Modified_ShadowStrength = ShadowStrength;
                        //Update the material. Only if the game is not running.
                        Material[] mats = ((_LushLODTree)this.target).lod0Rend.sharedMaterials;
                        foreach (Material matLoop in mats)
                        {
                            if (matLoop.shader.name.Contains("Leaves") == true)
                            {
                                //this should be the leaves shader.
                                matLoop.SetFloat("_ShadowStrength", ShadowStrength);
                                break;
                            }
                        }
                    }

                    if (GUILayout.Button("\nReset Shadow Size\n", style))
                    {
                        float OriginalShadowSize = ((_LushLODTree)this.target).Original_ShadowStrength;
                        ShadowStrength = OriginalShadowSize;
                        ShadowStrength_PREVIOUS = OriginalShadowSize;
                        ((_LushLODTree)this.target).Modified_ShadowStrength = OriginalShadowSize;
                        //Update the material. Only if the game is not running.
                        Material[] mats = ((_LushLODTree)this.target).lod0Rend.sharedMaterials;
                        foreach (Material matLoop in mats)
                        {
                            if (matLoop.shader.name.Contains("Leaves") == true)
                            {
                                //this should be the leaves shader.
                                matLoop.SetFloat("_ShadowStrength", ShadowStrength);
                                break;
                            }
                        }
                    }


                    //DO NOT ALLOW the player to upgrade or revert prefabs while the game is running.
                    //Because for whatever reason, it creates an instance of the NotInstanced atlas material,
                    //and that gets all kinds of buggy stuff happening.
                    if (PrefabUtility.GetPrefabType((_LushLODTree)this.target) != PrefabType.None)
                    {
                        GUILayout.Space(20f);
                        GUILayout.Label("Upgrade Prefab:");
                        GUILayout.Box("Use this if you have a newer, better and more awesome prefab for this tree, and you want all instances of this tree to be switched to the new prefab. This will not affect the position, rotation or scale of this tree.", RegularStyleBox);
                        GUILayout.Box("NOTE: Clicking the button below will NOT change the settings in your _LushLODTreeManager. Any settings in your manager will be applied to this tree after it is reloaded and reinstanced from the prefab. The prefab file itself will not be modified.", RegularStyleBox);
                        if (GUILayout.Button("\nUpgrade Prefab\n", style))
                        {

                            if (UnityEditor.SceneManagement.EditorSceneManager.GetActiveScene().isDirty || UnityEditor.SceneManagement.EditorSceneManager.GetActiveScene().path == "")
                            {
                                EditorUtility.DisplayDialog("Unsaved Scenes", "Your currently active scene is unsaved. Please save your scene, and make a backup of your .scene file before you upgrade your prefab.", "Okay");
                                return;
                            }

                            if (!EditorUtility.DisplayDialog("Backup Recommended", "There is NO undo for the following operation. Please create a backup of your .scene file before you continue.", "Continue -- I made a backup!", "Cancel"))
                            {
                                return;
                            }
                            string prefabPath = EditorUtility.OpenFilePanelWithFilters("Select prefab file", "Assets/", new string[] { "Unity Prefab", "prefab", });
                            if (prefabPath != null && prefabPath != "")
                            {
                                _LushLODTree.TreesManager.RevertAll((_LushLODTree)this.target, prefabPath, true);
                                _LushLODTree.TreesManager.UpdateTreesPreview(null, false, false);
                                return;
                            }
                        }
                    }
                    else
                    {
                        GUILayout.Space(20f);
                        GUILayout.Label("Reconnect to Prefabs:");
                        GUILayout.Box("This tree has lost its connection to its prefab file. The original name of this tree is \"" + ((_LushLODTree)this.target).Original_TreeName + "\". If you know where this tree's prefab file is, you can reconnect it using the button below. This will reconnect ALL instances of this tree that have lost connection to the prefab file.");
                        GUILayout.Box("WARNING: This will probably break any and all custom references that you've made to any instances of this tree in your project, and there is NO UNDO.", BoldRedstyle);
                        if (GUILayout.Button("\nReconnect to Prefab\n", style))
                        {
                            if (!EditorUtility.DisplayDialog("Backup Recommended", "There is NO undo for the following operation. Please create a backup of your .scene file before you continue.", "Continue -- I made a backup!", "Cancel"))
                            {
                                return;
                            }
                            string prefabPath = EditorUtility.OpenFilePanelWithFilters("Select prefab file", "Assets/", new string[] { "Unity Prefab", "prefab", });
                            if (prefabPath != null && prefabPath != "")
                            {
                                _LushLODTree.TreesManager.RevertAll((_LushLODTree)this.target, prefabPath);
                                _LushLODTree.TreesManager.UpdateTreesPreview(null, false, false);
                                if (this.target == null ||
                                    ReferenceEquals(this.target, null))
                                {
                                    return; //<-- this tree was reverted to its prefab, and that means it got deleted, which
                                    //means we are editing a tree that doesn't exist anymore, so get out of here quick before
                                    //we spam the console with errors.
                                }
                            }
                        }
                    }
                }
                else
                {
                    //Application is running. Let the user know they can't mess with the prefabs while game is running.
                    //See reason for this in the comment above.
                    GUILayout.Space(20f);
                    GUILayout.Label("Upgrade / Revert Prefab:");
                    GUILayout.Box("You cannot upgrade or revert to the prefab file while the game is running, or while the manager is in shadow baking mode.");
                }
            }
        }

        // Apply changes to the serializedProperty - always do this in the end of OnInspectorGUI.
        serializedObject.ApplyModifiedProperties();

        // Show default inspector property editor
        //DrawDefaultInspector();
    }
}
#endif

