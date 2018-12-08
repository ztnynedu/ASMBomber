#if UNITY_EDITOR
using UnityEngine;
using System.Collections;
using System.Collections.Generic;
using System.Text;
using System.Text.RegularExpressions;
using System;


using System.Linq;

using System.IO;
using UnityEditor;

/// <summary>
/// This class converts the high quality Unity Tree Creator trees into LushLODTrees.
/// However, this class has no access to the class located at TreeEditor.TreeData
/// Therefore, this class doesn't attempt to export the TreeData. Instead, it exports everything else,
/// and then the _LushLODTreeConverterEditor2 class takes over from there, and it exports the TreeData.
/// </summary>
public class _LushLODTreeConverter : MonoBehaviour {

    /// <summary>
    /// This variable is read by the _LushLODTreeConverterEditor2.cs script, so that it knows when the conversion process is done.
    /// </summary>
    [HideInInspector]
    public bool CONVERSION_FINISHED = false;

    public Light pZ;
    public Light pX;
    public Light nZ;
    public Light nX;

    [HideInInspector]
    public string exportPath;

    /// <summary>
    /// This is the physical material that will be assigned to the mesh collider for each tree.
    /// </summary>
    public PhysicMaterial PhysicMat;

    /// <summary>
    /// This camera isn't actually needed for any reason except to let the user see the trees better.
    /// </summary>
    public Camera MainCam;

    /// <summary>
    /// This will be set to true if the trees will have their verts merged.
    /// </summary>
    private int MergeVerts = -1;

    /// <summary>
    /// This camera actually takes the screenshots of the trees, it's the more important camera.
    /// </summary>
    public Camera BillboardCamera;

    /// <summary>
    /// This is the GameObject in the hierarchy where all the trees must be located for the conversion process.
        /// </summary>
    public Transform Trees_Parent;

    /// <summary>
    /// Just a x/y data holder, but differs from Vector2 because it is ints, instead of floats. Use this instead of vector2 if you
    /// are working with integers and you want to avoid floating point errors.
    /// </summary>
    [HideInInspector]
    public struct Vector2i
    {
        public int x;
        public int y;
        public Vector2i(int x, int y)
        {
            this.x = x;
            this.y = y;
        }
    }

    /// <summary>
    /// This is the size of the textures that will be used for the billboards. Default: 128.
    /// Other options: 32, 64, 128, 256, 512, 1024, 2048, 4096.
    /// </summary>
    public int BillboardTextureSize = 128;

    /// <summary>
    /// This class contains variables used during the tree conversion process.
    /// </summary>
    public class TreeConverting
    {
        /// <summary>
        /// This is the name of the GameObject for the high quality Unity Tree Creator tree.
        /// </summary>
        public string exportName;
        /// <summary>
        /// This is the GameObject for the high quality Unity Tree Creator tree.
        /// </summary>
        public GameObject HQTreeObj;
        /// <summary>
        /// This is the local position of the billboard. Sometimes it's local Y axis is adjusted up or down slightly to make it align with the high quality tree model.
        /// </summary>
        public Vector2 Lod1_LocalPosition;
        /// <summary>
        /// This is the shadow map texture for the front axis, used by the billboard shaders to render Simple Shadows.
        /// </summary>
        public Texture2D ShadowMapFront;
        /// <summary>
        /// This is the shadow map texture for the right axis, used by the billboard shaders to render Simple Shadows.
        /// </summary>
        public Texture2D ShadowMapRight;
        /// <summary>
        /// This is the Optimized tree Leaf shader that will be used by the LushLODTree for the high quality tree model leaves.
        /// </summary>
        public Shader LeavesShader;
        /// <summary>
        /// This is the Optimized bark shader that will be used by the LushLODTree for the high quality tree model bark.
        /// </summary>
        public Shader BarkShader;
        /// <summary>
        /// This is the billboard mesh.
        /// </summary>
        public Mesh BillboardMesh;
        /// <summary>
        /// This is the high quality Unity Tree Creator tree mesh, modified with additional UV data, to work with LushLODTrees.
        /// </summary>
        public Mesh HQMesh;
        /// <summary>
        /// This is the Optimized Leaf Material.
        /// </summary>
        public Material OptimizedLeafMaterial;
        /// <summary>
        /// This is the Optimized Bark Material.
        /// </summary>
        public Material OptimizedBarkMaterial;
        /// <summary>
        /// This bool will be true if the original Unity Tree Creator tree was using the "Fast" Optimized Bark shader before it was converted to a LushLODTree.
        /// </summary>
        public bool UsingFastBarkShader;
        /// <summary>
        /// This bool will be true if the original Unity Tree Creator tree was using the "Fast" Optimized Leaf shader before it was converted to a LushLODTree.
        /// </summary>
        public bool UsingFastLeavesShader;
        /// <summary>
        /// This will contain the default shadow receiving settings for the LushLODTree.
        /// </summary>
        public _LushLODTreesManager.ShadowReceiveSettings ShadowReceiveSetting;
        /// <summary>
        /// This will contain the default shadow casting settings for the LushLODTree.
        /// </summary>
        public _LushLODTreesManager.RealTimeShadowSettings RealTimeShadowSetting;
        /// <summary>
        /// This float contains the original value for "_ShadowStrength", which is one of the variables in the shader for Unity's tree creator tree leaves.
        /// </summary>
        public float Original_ShadowStrength;
        /// <summary>
        /// This list of colors. Two colors will be stored here, both from the "_Color" value in the shaders for the high quality trees. One for the leaves, and one for the bark.
        /// </summary>
        public List<Color> maincolor_HQTrees_ORIGINALS;
        /// <summary>
        /// This color saves the average color of the leaves.
        /// </summary>
        public Color AverageColor_Leaves;
        /// <summary>
        /// This color saves the average color of the bark.
        /// </summary>
        public Color AverageColor_Bark;
        /// <summary>
        /// This float contains a number which will be used to determine the distance where the billboards will transition in and out.
        /// </summary>
        public float lodDistance;
        /// <summary>
        /// This string contains the path where the TreeData will be saved.
        /// </summary>
        public string TreeDataPath;
    }

    /// <summary>
    /// This is the unique export number for this export. This number should never be the same twice.
    /// </summary>
    private int UniqueExportNumber;

    /// <summary>
    /// This is an array of all the trees that will be converted.
    /// </summary>
    public TreeConverting[] NewTrees;

    /// <summary>
    /// This is the atlas texture used by the billboards. Atlas textures are partly what enable the trees to be batched, which manes faster framerate.
    /// </summary>
    private Texture2D tex_atlas;

    /// <summary>
    /// Stores the current position where we are drawing textures into the atlas for the billboards.
    /// </summary>
    [HideInInspector]
    public Vector2i tex_atlas_currentPosition;

    /// <summary>
    /// This is the size of the billboard textures, in pixels, for the width (or height).
    /// </summary>
    int TX_size;

    Material Material_NotInstance_FullyOpaque;
    Material Material_Transitioning;

    void ExitApplication()
    {
        UnityEditor.EditorApplication.isPlaying = false;
    }

    void OnDestroy()
    {
        EditorUtility.ClearProgressBar();
    }

    void Start()
    {

        Application.runInBackground = true; //<-- Now you can tab out of the unity editor while it is working on a conversion.

        UniqueExportNumber = new {
             DateTime.Now.Year,
             DateTime.Now.Month,
             DateTime.Now.Day,
             DateTime.Now.Hour,
             DateTime.Now.Minute,
             DateTime.Now.Second,
             DateTime.Now.Millisecond}.GetHashCode();

        exportPath = "LushLOD Trees/Output/Output on " +
         DateTime.Now.Year.ToString() + "_" +
         DateTime.Now.Month.ToString() + "_" +
         DateTime.Now.Day.ToString() + " " +
         UniqueExportNumber.ToString();

        Material_NotInstance_FullyOpaque = new Material(Shader.Find("Hidden/LushLODTree/Tree_Leaves_Far2"));
        Material_Transitioning = new Material(Shader.Find("Hidden/LushLODTree/Tree_Leaves2"));

        // Setup Camera
        BillboardCamera.allowMSAA = false;
        BillboardCamera.backgroundColor = new Color32(0, 0, 0, 254);
        BillboardCamera.farClipPlane = 10000f;
        
        NewTrees = new TreeConverting[Trees_Parent.childCount];

        List<string> UniqueTreeNames = new List<string>();

        List<int> BillboardAllowedSizes = new List<int>(new int[] { 32, 64, 128, 256, 512, 1024 });
        if (BillboardAllowedSizes.Contains(BillboardTextureSize) == false)
        {
            EditorUtility.DisplayDialog("Conversion Failed", "You have selected a billboard size that isn't allowed. The allowed billboard sizes are 32, 64, 128, 256, 512 or 1024. Please change your billboard texture size to one of these values and try again.", "Okay");
            UnityEngine.Debug.LogError("You have selected a billboard size that isn't allowed. The allowed billboard sizes are 32, 64, 128, 256, 512 or 1024. Please change your billboard texture size to one of these values and try again.");
            UnityEditor.Selection.activeObject = this.gameObject;
            UnityEditor.EditorApplication.isPlaying = false;
            InvokeRepeating("ExitApplication", 1f, 1f);
            return;
        }

        //Set up the lights in case the user is using Linear color space:
        //NOTE: At the time I wrote the code, 
        //all 4 of these lights have a default intensity of 0.5 which works pretty good for Gamma color space.
        if (PlayerSettings.colorSpace == ColorSpace.Linear &&
            pZ.intensity < 0.85f &&
            pX.intensity < 0.85f &&
            nZ.intensity < 0.85f &&
            nX.intensity < 0.85f)
        {
            if (EditorUtility.DisplayDialog("Linear Color Space", "Your project is currently set to Linear color space. However, the lighting in this scene was designed for Gamma color space. If you wish to continue, I can help you run this scene in Linear color space. :) Continue?", "Yes", "Cancel") == false)
            {
                UnityEditor.EditorApplication.isPlaying = false;
                InvokeRepeating("ExitApplication", 1f, 1f);
                return;
            }
            if (EditorUtility.DisplayDialog("Linear Color Space", "In Linear color space, the lighting in this scene may be too dark and the resulting billboards may look faded. I can increase the intensity of the lights in the scene which may help produce better results. You probably don't want to do this if you've already adjusted the lights yourself. Should I adjust the lights?", "Yes", "No") == true)
            {
                //User wants to turn up the lights, let's do that now.
                pZ.intensity = 0.85f;
                pX.intensity = 0.85f;
                nZ.intensity = 0.85f;
                nX.intensity = 0.85f;
            }

        }

        if (BillboardCamera.actualRenderingPath != RenderingPath.Forward ||
            MainCam.actualRenderingPath != RenderingPath.Forward)
        {
            if (EditorUtility.DisplayDialog("Non-Forward Rendering", "At least one of the cameras in this scene is NOT rendering in Forward rendering mode. This tree converter was designed to work in Forward rendering mode. Other rendering paths have never been tested and I can't guarantee the conversion will look correct. If this is unexpected, please check the cameras in your scene to ensure that they are rendering in Forward mode. Do you wish to continue the conversion?", "Yes", "Cancel") == false)
            {
                UnityEditor.EditorApplication.isPlaying = false;
                InvokeRepeating("ExitApplication", 1f, 1f);
                return;
            }
        }

        GameObject TreeUsingFastShader = FindTreeUsingFastShader(Trees_Parent.gameObject);
        if (TreeUsingFastShader != null &&
            ReferenceEquals(TreeUsingFastShader, null) == false)
        {
            if (EditorUtility.DisplayDialog("Limited Support Warning", "You are converting a tree named \"" + TreeUsingFastShader.name + "\" that is using one of the Fast shaders. In this beta version, the LushLOD Tree Ultra quality mode currently does not support the TreeCreatorLeavesFAST or TreeCreatorBarkFAST shaders. Currently, only the Low, Medium and Great quality modes work with these \"Fast\" shaders. Expect this to be fixed soon. For now, if you wish to use Ultra quality, you must ensure that no parts of any of your Unity trees are using any of Unity's \"Fast\" Tree shaders. This needs to be done prior to converting your trees to LushLOD trees, and cannot be done after conversion. Do you wish to continue with the conversion anyway?", "Yes", "Cancel") == false)
            {
                UnityEditor.EditorApplication.isPlaying = false;
                InvokeRepeating("ExitApplication", 1f, 1f);
                return;
            }
        }

        //We use a layer named "Screenshots". Make sure that layer exists.
        CreateLayer();

        int childindex = 0;
        foreach (Transform Tree in Trees_Parent)
        {
            NewTrees[childindex] = new TreeConverting();
            NewTrees[childindex].HQTreeObj = Tree.gameObject;
            NewTrees[childindex].exportName = Tree.name;

            if (NewTrees[childindex].HQTreeObj.isStatic == true)
            {
                EditorUtility.DisplayDialog("Conversion Failed", "One of your trees named \"" + NewTrees[childindex].exportName + "\" is set to static. This converter cannot access the mesh data if the tree is set to static, so you must turn static off before conversion. Please check the inspector window on this tree (and all of your trees) and ensure that they are not set to static, and then try the coversion again.", "Okay");
                UnityEngine.Debug.LogError("One of your trees named \"" + NewTrees[childindex].exportName + "\" is set to static. This converter cannot access the mesh data if the tree is set to static, so you must turn static off before conversion. Please check the inspector window on this tree (and all of your trees) and ensure that they are not set to static, and then try the coversion again.");
                UnityEditor.EditorApplication.isPlaying = false;
                InvokeRepeating("ExitApplication", 1f, 1f);
                return;
            }

            // Get tree name, ready for writing to the hard drive:
            NewTrees[childindex].exportName = Regex.Replace(NewTrees[childindex].exportName, "[^\\w\\._]", " ");
            while (NewTrees[childindex].exportName.Length > 0 && NewTrees[childindex].exportName[NewTrees[childindex].exportName.Length - 1] == ' ')
                NewTrees[childindex].exportName = NewTrees[childindex].exportName.Remove(NewTrees[childindex].exportName.Length - 1, 1);
            if (NewTrees[childindex].exportName.Length > 0 && NewTrees[childindex].exportName[0] == ' ')
            {
                NewTrees[childindex].exportName = NewTrees[childindex].exportName.Remove(0, 1);
                NewTrees[childindex].exportName = NewTrees[childindex].exportName.Insert(0, "_");
            }
            if (NewTrees[childindex].exportName == "" ||
                UniqueTreeNames.Contains(NewTrees[childindex].exportName))
            {
                EditorUtility.DisplayDialog("Conversion Failed", "You have more than one tree with the name \"" + NewTrees[childindex].exportName + "\". Please give each tree's gameObject a unique name (in the hierarchy window), and try again.", "Okay");
                UnityEngine.Debug.LogError("You have more than one tree with the name \"" + NewTrees[childindex].exportName + "\". Please give each tree's gameObject a unique name (in the hierarchy window), and try again.");
                UnityEditor.EditorApplication.isPlaying = false;
                InvokeRepeating("ExitApplication", 1f, 1f);
                return;
            }
            else
            {
                UniqueTreeNames.Add(NewTrees[childindex].exportName);
            }

            //Make sure the converter will only convert trees, and not other types of stuff.
            Tree checkTree = NewTrees[childindex].HQTreeObj.GetComponentInChildren<Tree>();
            MeshFilter[] checkMeshes = NewTrees[childindex].HQTreeObj.GetComponentsInChildren<MeshFilter>();
            Renderer[] checkRenderer = NewTrees[childindex].HQTreeObj.GetComponentsInChildren<Renderer>();

            if (checkTree == null ||
                ReferenceEquals(checkTree, null) ||
                checkTree.Equals(null))
            {
                //No tree found.
                EditorUtility.DisplayDialog("Conversion Failed", "A GameObject named \"" + NewTrees[childindex].exportName + "\" was found which has no Unity Tree Creator \"Tree\" Component. Please ensure that only Unity Tree Creator Trees are being converted, and remove all other types of gameobjects from the list.", "Okay");
                UnityEngine.Debug.LogError("A GameObject named \"" + NewTrees[childindex].exportName + "\" was found which has no Unity Tree Creator \"Tree\" Component. Please ensure that only Unity Tree Creator Trees are being converted, and remove all other types of gameobjects from the list.");
                UnityEditor.EditorApplication.isPlaying = false;
                InvokeRepeating("ExitApplication", 1f, 1f);
                return;
            }

            if (checkMeshes == null ||
                ReferenceEquals(checkMeshes, null) ||
                checkMeshes.Equals(null) ||
                checkMeshes.Length != 1)
            {
                //no meshes or wrong number of meshes found.
                EditorUtility.DisplayDialog("Conversion Failed", "A GameObject named \"" + NewTrees[childindex].exportName + "\" was found which has more or less than one MeshFilter component attached to it or its children. This tree converter currently only supports Unity Tree Creator Trees, which should have only one MeshFilter. Please ensure that you are only converting Unity Tree Creator Trees, and remove all other types of gameobjects from the list.", "Okay");
                UnityEngine.Debug.LogError("A GameObject named \"" + NewTrees[childindex].exportName + "\" was found which has more or less than one MeshFilter component attached to it or its children. This tree converter currently only supports Unity Tree Creator Trees, which should have only one MeshFilter. Please ensure that you are only converting Unity Tree Creator Trees, and remove all other types of gameobjects from the list.");
                UnityEditor.EditorApplication.isPlaying = false;
                InvokeRepeating("ExitApplication", 1f, 1f);
                return;
            }

            Mesh HQMesh = NewTrees[childindex].HQTreeObj.GetComponent<MeshFilter>().sharedMesh;
            if (CheckIfMeshContainsDuplicateVerts(HQMesh) == true)
            {
                //This tree contains duplicate verts.
                //Let's ask the user what he wants to do.
                if (MergeVerts == -1)
                {
                    if (EditorUtility.DisplayDialog("Duplicate Verts Warning", "You are converting a tree named \"" + NewTrees[childindex].exportName + "\" which appears to have many duplicate vertices. Duplicate verticies occur when a tree has multiple points of triangles in the exact same spots. Usually one triangle will face one direction, and the other triangle will face the other direction. However, LushLOD shaders are set to render both sides of every triangle, so it is slower and often unnecessary to have duplicate veritices. Also it is faster in Unity to render both sides of a single triangle, than to render one culled side of two triangles. This converter can attempt to merge all the duplicate verticies in your tree(s). This may work with no problems, but in some cases this may distort the UVs and cause the textures to warp. Your origonal tree(s) will NOT be modified. Only the newly coverted tree(s) will have their verticies merged. If you are converting multiple trees, This will be done for each tree. Would you like to merge all duplicate verticies found in each of your tree(s)?", "Yes", "No") == false)
                    {
                        MergeVerts = 0; // User said NOT to merge verts.
                        EditorUtility.DisplayDialog("Duplicate Verts Warning", "You have opted to not merge the duplicate verticies. Be aware that the LushLOD leaf shaders are set to render both sides of the triangles, which may create an unwanted flickering effect in your tree(s). To fix this, you may need to edit the LushLOD high quality leaf shaders (not the billboard shaders) and comment out ALL occurances of the line that says \"Cull Off\", which will stop the flickering from occuring in the leaves of the high quality tree models which have double sided triangles. However, this will only work correctly if ALL your trees use double sided triangles. If you need help, don't hesitate to ask me any question on the support website.", "Ok");
                    }
                    else
                    {
                        MergeVerts = 1; // User said YES to merge verts.
                    }
                }
            }


            if (checkRenderer == null ||
                ReferenceEquals(checkRenderer, null) ||
                checkRenderer.Equals(null) ||
                checkRenderer.Length != 1)
            {
                //No renderer or wrong number of renderers found.
                EditorUtility.DisplayDialog("Conversion Failed", "A GameObject named \"" + NewTrees[childindex].exportName + "\" was found which has more or less than one Renderer component attached to it or its children. This tree converter currently only supports Unity Tree Creator Trees, which should have only one Renderer. Please ensure that you are only converting Unity Tree Creator Trees, and remove all other types of gameobjects from the list.", "Okay");
                UnityEngine.Debug.LogError("A GameObject named \"" + NewTrees[childindex].exportName + "\" was found which has more or less than one Renderer component attached to it or its children. This tree converter currently only supports Unity Tree Creator Trees, which should have only one Renderer. Please ensure that you are only converting Unity Tree Creator Trees, and remove all other types of gameobjects from the list.");
                UnityEditor.EditorApplication.isPlaying = false;
                InvokeRepeating("ExitApplication", 1f, 1f);
                return;
            }

            childindex += 1;
            Tree.gameObject.layer = LayerMask.NameToLayer("Screenshots");
        }

        BillboardCamera.cullingMask = LayerMask.GetMask(new string[] { "Screenshots" });

        StartCoroutine(GenerateBillboards());

    }

    /// <summary>
    /// Loops through all trees and tries to find one that is using the fast leaves or bark shaders. Returns the first such tree found, otherwise returns null.
    /// </summary>
    private GameObject FindTreeUsingFastShader(GameObject TreeRootToSearch = null)
    {

        //Get a list of all the trees in the scene. They should all be children of the TreesRoot gameobject:
        Tree[] allTrees = TreeRootToSearch.GetComponentsInChildren<Tree>();

        if (allTrees.Length == 0)
        {
            return null;
        }

        foreach (Tree FirstTree in allTrees)
        {
            Material[] lod0Mats = FirstTree.GetComponent<Renderer>().materials;
            foreach (Material matloop in lod0Mats)
            {
                if (matloop.shader.name.Contains("Leaves"))
                {
                    if (matloop.shader.name.Contains("Fast"))
                        return FirstTree.gameObject;
                }
                else
                {
                    //This should be the bark shader.
                    if (matloop.shader.name.Contains("Fast"))
                        return FirstTree.gameObject;
                }
            }
        }

        return null; //<-- couldn't find a tree using the fast shaders.
    }

    void CreateLayer()
    {
        //  https://forum.unity3d.com/threads/adding-layer-by-script.41970/#post-2904413
        SerializedObject tagManager = new SerializedObject(AssetDatabase.LoadAllAssetsAtPath("ProjectSettings/TagManager.asset")[0]);
        SerializedProperty layers = tagManager.FindProperty("layers");

        for (int i = 8; i < layers.arraySize; i++)
        {
            SerializedProperty layerSP = layers.GetArrayElementAtIndex(i);
            
            if (layerSP.stringValue == "Screenshots")
            {
                return;
            }

        }
        bool Success = false;
        for (int j = 8; j < layers.arraySize; j++)
        {
            SerializedProperty layerSP = layers.GetArrayElementAtIndex(j);
            if (layerSP.stringValue == "")
            {
                layerSP.stringValue = "Screenshots";
                tagManager.ApplyModifiedProperties();
                Success = true;
                break;
            }
        }

        if (Success == false)
        {
            EditorUtility.DisplayDialog("Conversion Failed", "Unable to create a layer named \"Screenshots\". Please create a Layer named \"Screenshots\" and try again.", "Okay");
            UnityEngine.Debug.LogError("Unable to create a layer named \"Screenshots\". Please create a Layer named \"Screenshots\" and try again.");
        }
    }


    System.Collections.IEnumerator GenerateBillboards()
    {

        yield return new WaitForSeconds(2); //<-- wait 2 seconds, to ensure that the lights have been updated.

        //Let's make the atlas(s) for the the original models. These are high definition, potentially complex atlas..

        if (ReferenceEquals(NewTrees, null) || NewTrees.Length == 0)
        {
            UnityEngine.Debug.LogError("You haven't added any objects to the list to convert!");
            yield break;
        }

        //Calculate the size of the atlas for NewTrees:
        float atlas_sizef = Mathf.Sqrt(3f * NewTrees.Length);
        int atlas_size = 1;
        while (atlas_sizef > atlas_size) atlas_size *= 2;
        atlas_size *= BillboardTextureSize;

        // Init Atlas for NewTrees
        tex_atlas = new Texture2D(atlas_size, atlas_size, TextureFormat.ARGB32, true);
        Color alpha = new Color(0f, 0f, 0f, 0f);
        for (int y = 0; y < tex_atlas.height; y++)
        {
            for (int x = 0; x < tex_atlas.width; x++)
            {
                tex_atlas.SetPixel(x, y, alpha);
            }
        }
        tex_atlas.wrapMode = TextureWrapMode.Clamp;
        tex_atlas.filterMode = FilterMode.Point;// = FilterMode.Bilinear; //<-- for now, use point to avoid any possible color bleeding.
        tex_atlas.Apply();
        TX_size = BillboardTextureSize;
        tex_atlas_currentPosition = new Vector2i(TX_size, 0);
        tex_atlas.name = "Atlas";

        Material_NotInstance_FullyOpaque.name = "Material_FullyOpaque";
        Material_NotInstance_FullyOpaque.SetTexture("_MainTex", tex_atlas);
        Material_NotInstance_FullyOpaque.SetFloat("_Cutoff", 0.5f);
        Material_NotInstance_FullyOpaque.SetFloat("_Transparency", 1f);

        Material_Transitioning.name = "Material_Transitioning";
        Material_Transitioning.SetTexture("_MainTex", tex_atlas);
        Material_Transitioning.SetFloat("_Cutoff", 0.5f);
        Material_Transitioning.SetFloat("_Transparency", 1f);
        Material_Transitioning.SetFloat("_ShadowTransparency", 1f);

        // Disactivate the generated output so they don't interfere with screen shots

        foreach (TreeConverting tree in NewTrees)
        {
            if (!tree.HQTreeObj)
            {
                Debug.Log("Cannot create LushLOD Trees! No trees found!");
                continue;
            }

            tree.HQTreeObj.SetActive(false);
        }

        for (int i = 0; i < NewTrees.Length; i++)
        {
            TreeConverting tree = NewTrees[i];
            if (!tree.HQTreeObj)
            {
                Debug.Log("Cannot create LushLOD Trees! No trees found!");
                continue;
            }

            EditorUtility.DisplayProgressBar("Progress", "Creating LushLODTrees", ((float)i / NewTrees.Length) / 2f);

            yield return StartCoroutine(CreateBillboard(tree));
        }





        //Alpha padd the whole atlas image:
        yield return new WaitForSeconds(0.5f); //<-- wait 0.5 seconds
        yield return new WaitForEndOfFrame();

        Material BlitCopy = new Material(Shader.Find("Hidden/BlitCopy"));
        Material BackgroundClippedCopy = new Material(Shader.Find("Hidden/LushLODTree/BackgroundClippedCopy"));

        BackgroundClippedCopy.SetColor("_Background", Color.black);
        RenderTexture AtlasPic_PaddedAlphaRT = new RenderTexture(tex_atlas.width, tex_atlas.height, 0, RenderTextureFormat.ARGB32);
        RenderTexture AtlasPic_OriginalRT = new RenderTexture(tex_atlas.width, tex_atlas.height, 0, RenderTextureFormat.ARGB32);
        RenderTexture AtlasPic_WorkingRT = new RenderTexture(tex_atlas.width, tex_atlas.height, 0, RenderTextureFormat.ARGB32);
        AtlasPic_PaddedAlphaRT.antiAliasing = 1;
        AtlasPic_PaddedAlphaRT.filterMode = FilterMode.Point;
        AtlasPic_PaddedAlphaRT.autoGenerateMips = false;
        AtlasPic_PaddedAlphaRT.useMipMap = false;
        AtlasPic_OriginalRT.antiAliasing = 1;
        AtlasPic_OriginalRT.filterMode = FilterMode.Point;
        AtlasPic_OriginalRT.autoGenerateMips = false;
        AtlasPic_OriginalRT.useMipMap = false;
        AtlasPic_WorkingRT.antiAliasing = 1;
        AtlasPic_WorkingRT.filterMode = FilterMode.Point;
        AtlasPic_WorkingRT.autoGenerateMips = false;
        AtlasPic_WorkingRT.useMipMap = false;

        Graphics.Blit(tex_atlas, AtlasPic_OriginalRT); //AtlasPic_OriginalRT contains the pixels of our original image (before blur effects)
        Graphics.Blit(AtlasPic_OriginalRT, AtlasPic_PaddedAlphaRT); //<-- initial setup
        Graphics.Blit(AtlasPic_OriginalRT, AtlasPic_WorkingRT); //<-- initial setup

        for (int LoopTimes = 0; LoopTimes < 20; LoopTimes++)
        {
            DoAlphaPadding(2, 10f, 4, AtlasPic_WorkingRT, AtlasPic_PaddedAlphaRT); //<-- perform blur #1
            Graphics.Blit(AtlasPic_PaddedAlphaRT, AtlasPic_WorkingRT); //<-- save blur #1 to working RT
            Graphics.Blit(AtlasPic_OriginalRT, AtlasPic_WorkingRT, BackgroundClippedCopy); //<-- copy the original, skips background pixels. This gives us a blurred image where the original pixels are unaffected.
        }

        for (int LoopTimes = 0; LoopTimes < 20; LoopTimes++)
        {
            DoAlphaPadding(2, 0f, 4, AtlasPic_WorkingRT, AtlasPic_PaddedAlphaRT); //<-- perform blur #2
            Graphics.Blit(AtlasPic_PaddedAlphaRT, AtlasPic_WorkingRT); //<-- save blur #2 to working RT
            Graphics.Blit(AtlasPic_OriginalRT, AtlasPic_WorkingRT, BackgroundClippedCopy); //<-- copy the original, skips background pixels. This gives us a blurred image where the original pixels are unaffected.
        }

        for (int LoopTimes = 0; LoopTimes < 20; LoopTimes++)
        {
            DoAlphaPadding(0, 0f, 4, AtlasPic_WorkingRT, AtlasPic_PaddedAlphaRT); //<-- perform blur #3
            Graphics.Blit(AtlasPic_PaddedAlphaRT, AtlasPic_WorkingRT); //<-- save blur #3 to working RT
            Graphics.Blit(AtlasPic_OriginalRT, AtlasPic_WorkingRT, BackgroundClippedCopy); //<-- copy the original, skips background pixels. This gives us a blurred image where the original pixels are unaffected.
        }

        Graphics.Blit(AtlasPic_WorkingRT, AtlasPic_PaddedAlphaRT); //Final blit
        RenderTexture.active = AtlasPic_PaddedAlphaRT; //<-- prepare to read from our blurred texture, instead of the screen.
        tex_atlas.ReadPixels(new Rect(0, 0, tex_atlas.width, tex_atlas.height), 0, 0); //<-- read
        tex_atlas.Apply();
        RenderTexture.active = null; //<-- set it back to read from the screen again.

        Graphics.Blit(tex_atlas, BlitCopy); //<-- just for entertainment, blit the blurred image to the screen so that we can see it.
        yield return new WaitForEndOfFrame();
        Graphics.Blit(tex_atlas, BlitCopy); //<-- just for entertainment, blit the blurred image to the screen so that we can see it.

        tex_atlas.filterMode = FilterMode.Bilinear; //<-- we had set this to "point" earlier to avoid color bleeding.
        // Create mipmaps
        tex_atlas.SetPixels(tex_atlas.GetPixels());
        tex_atlas.Apply();


        StartCoroutine(Export());

        yield return null;
    }

    /// <summary>
    /// This function will increment and calculate 
    /// </summary>
    /// <returns></returns>
    public Vector2i NextatlasPosition(Texture2D atlas, Vector2i CurrentPos, int TextureSize)
    {
        Vector2i ReturningPosition = CurrentPos;
        ReturningPosition.x += TextureSize;
        if (ReturningPosition.x > atlas.width - TextureSize)
        {
            ReturningPosition.x = 0;
            ReturningPosition.y += TextureSize;
        }
        return ReturningPosition;
    }

    public List<Vector2> GetNextUVs(int TextureSize)
    {
        List<Vector2> BuildingList = new List<Vector2>();
        Vector2 newUV = new Vector2(0f, 0f);
        newUV.x = Mathf.Min(1f, (tex_atlas_currentPosition.x + 0.1f) / tex_atlas.width);
        newUV.y = Mathf.Min(1f, (tex_atlas_currentPosition.y + 0.1f) / tex_atlas.height);
        BuildingList.Add(newUV);
        newUV.x = Mathf.Min(1f, ((tex_atlas_currentPosition.x - 0.1f) + TextureSize) / tex_atlas.width);
        newUV.y = Mathf.Min(1f, (tex_atlas_currentPosition.y + 0.1f) / tex_atlas.height);
        BuildingList.Add(newUV);
        newUV.x = Mathf.Min(1f, (tex_atlas_currentPosition.x + 0.1f) / tex_atlas.width);
        newUV.y = Mathf.Min(1f, ((tex_atlas_currentPosition.y - 0.1f) + TextureSize) / tex_atlas.height);
        BuildingList.Add(newUV);
        newUV.x = Mathf.Min(1f, ((tex_atlas_currentPosition.x - 0.1f) + TextureSize) / tex_atlas.width);
        newUV.y = Mathf.Min(1f, ((tex_atlas_currentPosition.y - 0.1f) + TextureSize) / tex_atlas.height);
        BuildingList.Add(newUV);
        return BuildingList;
    }

    static Mesh s_Quad;
    public static Mesh quad
    {
        get
        {
            if (s_Quad != null)
                return s_Quad;

            var vertices = new[]
            {
                new Vector3(-0.5f, -0.5f, 0f),
                new Vector3(0.5f,  0.5f, 0f),
                new Vector3(0.5f, -0.5f, 0f),
                new Vector3(-0.5f,  0.5f, 0f)
            };

            var uvs = new[]
            {
                new Vector2(0f, 0f),
                new Vector2(1f, 1f),
                new Vector2(1f, 0f),
                new Vector2(0f, 1f)
            };

            var indices = new[] { 0, 1, 2, 1, 0, 3 };

            s_Quad = new Mesh
            {
                vertices = vertices,
                uv = uvs,
                triangles = indices
            };
            s_Quad.RecalculateNormals();
            s_Quad.RecalculateBounds();

            return s_Quad;
        }
    }

    System.Collections.IEnumerator CreateBillboard(TreeConverting ExportData)
    {

        // Create objects:
        GameObject lod0 = (GameObject)Instantiate(ExportData.HQTreeObj); lod0.name = "Lod_0";
        GameObject renderParent = new GameObject(ExportData.exportName); renderParent.name = ExportData.exportName;

        //The game is running, so instance the material of the high quality trees, so that we don't make any permanent changes to it.
        Material[] lod0Mats = lod0.GetComponent<Renderer>().materials;

        lod0.SetActive(true);

        lod0.transform.position = Vector3.zero;
        lod0.transform.parent = renderParent.transform;

        if (BillboardTextureSize <= 0)
        {
            Debug.Log("Could not create LushLOD Tree: " + ExportData.exportName + " \"Tile Size\" too small! Use a value such as \"32\"");
            yield break;
        }
        if (BillboardTextureSize > Mathf.Min(Screen.width, Screen.height))
        {
            Debug.Log("Could not create LushLOD Tree: " + ExportData.exportName + " \"Tile Size\" is larger than screen area! Please resize editor window or reduce the tile size!");
            yield break;
        }

        Mesh BillboardMesh = new Mesh();

        // Init Bounds
        renderParent.SetActive(true);
        Bounds bounds = GetBounds(renderParent);

        // Transform Render Obj to occupy in Unit Cube
        renderParent.transform.localScale = new Vector3((1f / bounds.size.x),
                                                         (1f / bounds.size.y),
                                                         (1f / bounds.size.z));

        // Recalculate Cube Bounds
        Bounds cubeBounds = GetBounds(renderParent);

        // Init Camera
        BillboardCamera.transform.position = cubeBounds.center;
        BillboardCamera.transform.rotation = Quaternion.LookRotation(Vector3.left, Vector3.up);
        BillboardCamera.transform.localScale = Vector3.one;
        BillboardCamera.orthographic = true;
        BillboardCamera.orthographicSize = 0.5f;
        BillboardCamera.nearClipPlane = -1f;
        BillboardCamera.farClipPlane = 1f;
        BillboardCamera.rect = new Rect(0f, 0f, (float)BillboardTextureSize / Screen.width, (float)BillboardTextureSize / Screen.height);
        BillboardCamera.enabled = true;
        Selection.activeGameObject = BillboardCamera.gameObject;

        MainCam.transform.position = cubeBounds.center;
        MainCam.transform.rotation = Quaternion.LookRotation(Vector3.left, Vector3.up);
        MainCam.transform.localScale = Vector3.one;
        MainCam.orthographic = true;
        MainCam.orthographicSize = 0.5f;
        MainCam.nearClipPlane = -1f;
        MainCam.farClipPlane = 1f;

        // Setup Billboard Mesh
        Vector3[] vertices = new Vector3[12];
        int[] tri = new int[18];
        Vector3[] normals = new Vector3[12];
        Vector4[] tangents = new Vector4[12];
        Vector2[] uv = new Vector2[12];
        Vector2[] uv2 = new Vector2[12];
        Vector2[] uv3 = new Vector2[12];
        Vector2[] uv4 = new Vector2[12];

        //Before we make any modifications to the shader being used by the high quality tree, we need to permanently record
        //which shader the high quality tree was using at this point (aka before the tree was converted). The tree could either be
        //using the regular "Optimized" shaders, or it could be using the "Fast Optimized" shaders. These are built-in unity shaders.
        //So let's check which of these shaders the tree is using now, and make a permanent record of it:

        foreach (Material matloop in lod0Mats)
        {
            if (matloop.shader.name.Contains("Leaves"))
            {
                if (matloop.shader.name.Contains("Fast"))
                    ExportData.UsingFastLeavesShader = true;
                else
                    ExportData.UsingFastLeavesShader = false;
            }
            else
            {
                //This should be the bark shader.
                if (matloop.shader.name.Contains("Fast"))
                    ExportData.UsingFastBarkShader = true;
                else
                    ExportData.UsingFastBarkShader = false;
            }
        }


        //Before we can take screenshots, set the trees to use the LushLODTree/Tree Creator Optimized shaders.
        //This simple ensures that the billboards will look as much as possible like the high quality trees.
        foreach (Material matloop in lod0Mats)
        {
            if (matloop.shader.name.Contains("Leaves"))
            {
                matloop.shader = _LushLODTree.GetLeavesShader(false, ExportData.UsingFastLeavesShader, false, false, ExportData.UsingFastLeavesShader == true ? 1 : 0);
            }
            else
            {
                matloop.shader = _LushLODTree.GetBarkShader(false, false, false);
            }
        }

        //First, we need to take two pictures of the tree with NO BARK visible.
        //These two pictures are used during the shadow map creation process.

        //Turn off the bark:
        foreach (Material matloop in lod0Mats)
        {
            if (matloop.shader.name.Contains("Bark"))
            {
                matloop.SetFloat("_Transparency", 0f);
            }
            else
            {
                //Just to be sure the leaves aren't transparent, turn them fully on:
                matloop.SetFloat("_Transparency", 1f);
            }
        }

        //Side without bark:
        BillboardCamera.transform.rotation = Quaternion.LookRotation(Vector3.left);
        MainCam.transform.rotation = Quaternion.LookRotation(Vector3.left);
        yield return new WaitForSeconds(0.5f); //<-- wait 0.5 seconds for bark to update.
        yield return new WaitForEndOfFrame();
        Texture2D SidePic_NoBark = new Texture2D(BillboardTextureSize, BillboardTextureSize);
        SidePic_NoBark.ReadPixels(new Rect(0, 0, BillboardTextureSize, BillboardTextureSize), 0, 0);
        SidePic_NoBark.Apply();

        //Front without bark:
        BillboardCamera.transform.rotation = Quaternion.LookRotation(Vector3.forward);
        MainCam.transform.rotation = Quaternion.LookRotation(Vector3.forward);
        yield return new WaitForSeconds(0.5f); //<-- wait 0.5 seconds for camera to update?
        yield return new WaitForEndOfFrame();
        Texture2D FrontPic_NoBark = new Texture2D(BillboardTextureSize, BillboardTextureSize);
        FrontPic_NoBark.ReadPixels(new Rect(0, 0, BillboardTextureSize, BillboardTextureSize), 0, 0);
        FrontPic_NoBark.Apply();

        //Turn the bark (and leaves, why not) back on:
        foreach (Material matloop in lod0Mats)
        {
            matloop.SetFloat("_Transparency", 1f);
        }


        //Next, we need to take two pictures of the tree with NO LEAVES visible.
        //These two pictures are used along with the "no bark" pictures to get
        //the average color of the leaves, and the average color of the bark. This
        //is needed by the post processing effect to correct issues where colors can
        //be lost, and in such cases we will use these two colors to fill in where
        //color data has been lost during certain situations (it's complicated).

        //Turn off the leaves:
        foreach (Material matloop in lod0Mats)
        {
            if (matloop.shader.name.Contains("Bark"))
            {
                matloop.SetFloat("_Transparency", 1f);
            }
            else
            {
                matloop.SetFloat("_Transparency", 0f);
            }
        }

        //Side without leaves:
        BillboardCamera.transform.rotation = Quaternion.LookRotation(Vector3.left);
        MainCam.transform.rotation = Quaternion.LookRotation(Vector3.left);
        yield return new WaitForSeconds(0.5f); //<-- wait 0.5 seconds for bark to update.
        yield return new WaitForEndOfFrame();
        Texture2D SidePic_NoLeaves = new Texture2D(BillboardTextureSize, BillboardTextureSize);
        SidePic_NoLeaves.ReadPixels(new Rect(0, 0, BillboardTextureSize, BillboardTextureSize), 0, 0);
        SidePic_NoLeaves.Apply();

        //Front without leaves:
        BillboardCamera.transform.rotation = Quaternion.LookRotation(Vector3.forward);
        MainCam.transform.rotation = Quaternion.LookRotation(Vector3.forward);
        yield return new WaitForSeconds(0.5f); //<-- wait 0.5 seconds for camera to update?
        yield return new WaitForEndOfFrame();
        Texture2D FrontPic_NoLeaves = new Texture2D(BillboardTextureSize, BillboardTextureSize);
        FrontPic_NoLeaves.ReadPixels(new Rect(0, 0, BillboardTextureSize, BillboardTextureSize), 0, 0);
        FrontPic_NoLeaves.Apply();

        //Turn the bark (and leaves, why not) back on:
        foreach (Material matloop in lod0Mats)
        {
            matloop.SetFloat("_Transparency", 1f);
        }

        Color AverageColor_Side_WithoutLeaves = GetAverageColor(SidePic_NoLeaves);
        Color AverageColor_Front_WithoutLeaves = GetAverageColor(FrontPic_NoLeaves);
        Color AverageColor_Bark = (AverageColor_Side_WithoutLeaves + AverageColor_Front_WithoutLeaves) / 2;

        Color AverageColor_Side_WithoutBark = GetAverageColor(SidePic_NoBark);
        Color AverageColor_Front_WithoutBark = GetAverageColor(FrontPic_NoBark);
        Color AverageColor_Leaves = (AverageColor_Side_WithoutBark + AverageColor_Front_WithoutBark) / 2;

        Material BlitCopy = new Material(Shader.Find("Hidden/BlitCopy"));
        Material BackgroundClippedCopy = new Material(Shader.Find("Hidden/LushLODTree/BackgroundClippedCopy"));
        BackgroundClippedCopy.SetColor("_Background", BillboardCamera.backgroundColor);
        
        // Mesh Generate Data
        // Front
        vertices[0] = new Vector3(0f, 0f, 0.5f);
        vertices[1] = new Vector3(1f, 0f, 0.5f);
        vertices[2] = new Vector3(0f, 1f, 0.5f);
        vertices[3] = new Vector3(1f, 1f, 0.5f);
        tri[0] = 0; tri[1] = 2; tri[2] = 1;
        tri[3] = 2; tri[4] = 3; tri[5] = 1;
        normals[0] = Vector3.forward;
        normals[1] = Vector3.forward;
        normals[2] = Vector3.forward;
        normals[3] = Vector3.forward;
        tangents[0] = new Vector4(0f, 1f, 0f, -1f); //<-- same as Vector3.up... the 4th digit (.w) is set to -1f which turns the bitangent direction in the opposite direction.
        tangents[1] = new Vector4(0f, 1f, 0f, -1f); //<-- same as Vector3.up... the 4th digit (.w) is set to -1f which turns the bitangent direction in the opposite direction.
        tangents[2] = new Vector4(0f, 1f, 0f, -1f); //<-- same as Vector3.up... the 4th digit (.w) is set to -1f which turns the bitangent direction in the opposite direction.
        tangents[3] = new Vector4(0f, 1f, 0f, -1f); //<-- same as Vector3.up... the 4th digit (.w) is set to -1f which turns the bitangent direction in the opposite direction.
        List<Vector2> newUVs = GetNextUVs(TX_size);
        Vector2[] forwardUVs = newUVs.ToArray();
        Vector2i forward_tex_atlas_currentPosition = tex_atlas_currentPosition;
        uv[0] = newUVs[0];
        uv[1] = newUVs[1];
        uv[2] = newUVs[2];
        uv[3] = newUVs[3];

        BillboardCamera.transform.rotation = Quaternion.LookRotation(Vector3.forward);
        MainCam.transform.rotation = Quaternion.LookRotation(Vector3.forward);
        yield return new WaitForSeconds(0.5f); //<-- wait 0.5 seconds for bark to update.
        yield return new WaitForEndOfFrame();
        Texture2D FrontPic = new Texture2D(BillboardTextureSize, BillboardTextureSize);
        FrontPic.ReadPixels(new Rect(0, 0, BillboardTextureSize, BillboardTextureSize), 0, 0);
        FrontPic.Apply();

        Texture2D FrontPic_PaddedAlpha = new Texture2D(BillboardTextureSize, BillboardTextureSize);
        RenderTexture FrontPic_PaddedAlphaRT = new RenderTexture(BillboardTextureSize, BillboardTextureSize, 0, RenderTextureFormat.ARGB32);
        RenderTexture FrontPic_OriginalRT = new RenderTexture(BillboardTextureSize, BillboardTextureSize, 0, RenderTextureFormat.ARGB32);
        RenderTexture FrontPic_WorkingRT = new RenderTexture(BillboardTextureSize, BillboardTextureSize, 0, RenderTextureFormat.ARGB32);
        FrontPic_PaddedAlphaRT.antiAliasing = 1;
        FrontPic_PaddedAlphaRT.filterMode = FilterMode.Point;
        FrontPic_PaddedAlphaRT.autoGenerateMips = false;
        FrontPic_PaddedAlphaRT.useMipMap = false;
        FrontPic_OriginalRT.antiAliasing = 1;
        FrontPic_OriginalRT.filterMode = FilterMode.Point;
        FrontPic_OriginalRT.autoGenerateMips = false;
        FrontPic_OriginalRT.useMipMap = false;
        FrontPic_WorkingRT.antiAliasing = 1;
        FrontPic_WorkingRT.filterMode = FilterMode.Point;
        FrontPic_WorkingRT.autoGenerateMips = false;
        FrontPic_WorkingRT.useMipMap = false;

        Graphics.Blit(FrontPic, FrontPic_OriginalRT); //FrontPic_OriginalRT contains the pixels of our original image (before blur effects)
        Graphics.Blit(FrontPic_OriginalRT, FrontPic_PaddedAlphaRT); //<-- initial setup
        Graphics.Blit(FrontPic_OriginalRT, FrontPic_WorkingRT); //<-- initial setup

        for (int LoopTimes = 0; LoopTimes < 10; LoopTimes++)
        {
            DoAlphaPadding(2, 10f, 4, FrontPic_WorkingRT, FrontPic_PaddedAlphaRT); //<-- perform blur #1
            Graphics.Blit(FrontPic_PaddedAlphaRT, FrontPic_WorkingRT); //<-- save blur #1 to working RT
            Graphics.Blit(FrontPic_OriginalRT, FrontPic_WorkingRT, BackgroundClippedCopy); //<-- copy the original, skips background pixels. This gives us a blurred image where the original pixels are unaffected.
        }

        for (int LoopTimes = 0; LoopTimes < 10; LoopTimes++)
        {
            DoAlphaPadding(2, 0f, 4, FrontPic_WorkingRT, FrontPic_PaddedAlphaRT); //<-- perform blur #2
            Graphics.Blit(FrontPic_PaddedAlphaRT, FrontPic_WorkingRT); //<-- save blur #2 to working RT
            Graphics.Blit(FrontPic_OriginalRT, FrontPic_WorkingRT, BackgroundClippedCopy); //<-- copy the original, skips background pixels. This gives us a blurred image where the original pixels are unaffected.
        }

        for (int LoopTimes = 0; LoopTimes < 10; LoopTimes++)
        {
            DoAlphaPadding(0, 0f, 4, FrontPic_WorkingRT, FrontPic_PaddedAlphaRT); //<-- perform blur #3
            Graphics.Blit(FrontPic_PaddedAlphaRT, FrontPic_WorkingRT); //<-- save blur #3 to working RT
            Graphics.Blit(FrontPic_OriginalRT, FrontPic_WorkingRT, BackgroundClippedCopy); //<-- copy the original, skips background pixels. This gives us a blurred image where the original pixels are unaffected.
        }

        Graphics.Blit(FrontPic_WorkingRT, FrontPic_PaddedAlphaRT); //Final blit
        RenderTexture.active = FrontPic_PaddedAlphaRT; //<-- prepare to read from our blurred texture, instead of the screen.
        FrontPic_PaddedAlpha.ReadPixels(new Rect(0, 0, BillboardTextureSize, BillboardTextureSize), 0, 0); //<-- read
        FrontPic_PaddedAlpha.Apply();
        RenderTexture.active = null; //<-- set it back to read from the screen again.
        //Graphics.Blit(FrontPic_PaddedAlphaRT, BlitCopy); //<-- just for entertainment, blit the blurred image to the screen so that we can see it.
        Graphics.Blit(tex_atlas, BlitCopy); //<-- just for entertainment, blit the blurred image to the screen so that we can see it.

        yield return StartCoroutine(Screenshot(FrontPic, FrontPic_PaddedAlpha, tex_atlas, BillboardTextureSize, BillboardTextureSize, 1));
        Texture2D ShadowMapFront;
        ShadowMapFront = new Texture2D(BillboardTextureSize, BillboardTextureSize);
        yield return StartCoroutine(ShadowTexture(FrontPic, FrontPic_NoBark, ShadowMapFront));
        

        // Side
        vertices[4] = new Vector3(0.5f, 0f, 0f);
        vertices[5] = new Vector3(0.5f, 0f, 1f);
        vertices[6] = new Vector3(0.5f, 1f, 0f);
        vertices[7] = new Vector3(0.5f, 1f, 1f);
        tri[6] = 4; tri[7] = 6; tri[8] = 5;
        tri[9] = 6; tri[10] = 7; tri[11] = 5;
        normals[4] = Vector3.right;
        normals[5] = Vector3.right;
        normals[6] = Vector3.right;
        normals[7] = Vector3.right;
        tangents[4] = new Vector4(0f, 1f, 0f, 1f); //<-- same as Vector3.up... the 4th digit (.w) is set to 1f which turns the bitangent direction in the default direction.
        tangents[5] = new Vector4(0f, 1f, 0f, 1f); //<-- same as Vector3.up... the 4th digit (.w) is set to 1f which turns the bitangent direction in the default direction.
        tangents[6] = new Vector4(0f, 1f, 0f, 1f); //<-- same as Vector3.up... the 4th digit (.w) is set to 1f which turns the bitangent direction in the default direction.
        tangents[7] = new Vector4(0f, 1f, 0f, 1f); //<-- same as Vector3.up... the 4th digit (.w) is set to 1f which turns the bitangent direction in the default direction.
        newUVs = GetNextUVs(TX_size);
        Vector2[] rightUVs = newUVs.ToArray();
        Vector2i right_tex_atlas_currentPosition = tex_atlas_currentPosition;
        uv[4] = newUVs[0];
        uv[5] = newUVs[1];
        uv[6] = newUVs[2];
        uv[7] = newUVs[3];

        BillboardCamera.transform.rotation = Quaternion.LookRotation(Vector3.left);
        MainCam.transform.rotation = Quaternion.LookRotation(Vector3.left);
        yield return new WaitForEndOfFrame();
        Texture2D SidePic = new Texture2D(BillboardTextureSize, BillboardTextureSize);
        SidePic.ReadPixels(new Rect(0, 0, BillboardTextureSize, BillboardTextureSize), 0, 0);
        SidePic.Apply();

        Texture2D SidePic_PaddedAlpha = new Texture2D(BillboardTextureSize, BillboardTextureSize);
        RenderTexture SidePic_PaddedAlphaRT = new RenderTexture(BillboardTextureSize, BillboardTextureSize, 0, RenderTextureFormat.ARGB32);
        RenderTexture SidePic_OriginalRT = new RenderTexture(BillboardTextureSize, BillboardTextureSize, 0, RenderTextureFormat.ARGB32);
        RenderTexture SidePic_WorkingRT = new RenderTexture(BillboardTextureSize, BillboardTextureSize, 0, RenderTextureFormat.ARGB32);
        SidePic_PaddedAlphaRT.antiAliasing = 1;
        SidePic_PaddedAlphaRT.filterMode = FilterMode.Point;
        SidePic_PaddedAlphaRT.autoGenerateMips = false;
        SidePic_PaddedAlphaRT.useMipMap = false;
        SidePic_OriginalRT.antiAliasing = 1;
        SidePic_OriginalRT.filterMode = FilterMode.Point;
        SidePic_OriginalRT.autoGenerateMips = false;
        SidePic_OriginalRT.useMipMap = false;
        SidePic_WorkingRT.antiAliasing = 1;
        SidePic_WorkingRT.filterMode = FilterMode.Point;
        SidePic_WorkingRT.autoGenerateMips = false;
        SidePic_WorkingRT.useMipMap = false;

        Graphics.Blit(SidePic, SidePic_OriginalRT); //SidePic_OriginalRT contains the pixels of our original image (before blur effects)
        Graphics.Blit(SidePic_OriginalRT, SidePic_PaddedAlphaRT); //<-- initial setup
        Graphics.Blit(SidePic_OriginalRT, SidePic_WorkingRT); //<-- initial setup

        for (int LoopTimes = 0; LoopTimes < 10; LoopTimes++)
        {
            DoAlphaPadding(2, 10f, 4, SidePic_WorkingRT, SidePic_PaddedAlphaRT); //<-- perform blur #1
            Graphics.Blit(SidePic_PaddedAlphaRT, SidePic_WorkingRT); //<-- save blur #1 to working RT
            Graphics.Blit(SidePic_OriginalRT, SidePic_WorkingRT, BackgroundClippedCopy); //<-- copy the original, skips background pixels. This gives us a blurred image where the original pixels are unaffected.
        }

        for (int LoopTimes = 0; LoopTimes < 10; LoopTimes++)
        {
            DoAlphaPadding(2, 0f, 4, SidePic_WorkingRT, SidePic_PaddedAlphaRT); //<-- perform blur #2
            Graphics.Blit(SidePic_PaddedAlphaRT, SidePic_WorkingRT); //<-- save blur #2 to working RT
            Graphics.Blit(SidePic_OriginalRT, SidePic_WorkingRT, BackgroundClippedCopy); //<-- copy the original, skips background pixels. This gives us a blurred image where the original pixels are unaffected.
        }

        for (int LoopTimes = 0; LoopTimes < 10; LoopTimes++)
        {
            DoAlphaPadding(0, 0f, 4, SidePic_WorkingRT, SidePic_PaddedAlphaRT); //<-- perform blur #3
            Graphics.Blit(SidePic_PaddedAlphaRT, SidePic_WorkingRT); //<-- save blur #3 to working RT
            Graphics.Blit(SidePic_OriginalRT, SidePic_WorkingRT, BackgroundClippedCopy); //<-- copy the original, skips background pixels. This gives us a blurred image where the original pixels are unaffected.
        }

        Graphics.Blit(SidePic_WorkingRT, SidePic_PaddedAlphaRT); //Final blit
        RenderTexture.active = SidePic_PaddedAlphaRT; //<-- prepare to read from our blurred texture, instead of the screen.
        SidePic_PaddedAlpha.ReadPixels(new Rect(0, 0, BillboardTextureSize, BillboardTextureSize), 0, 0); //<-- read
        SidePic_PaddedAlpha.Apply();
        RenderTexture.active = null; //<-- set it back to read from the screen again.
        //Graphics.Blit(SidePic_PaddedAlphaRT, BlitCopy); //<-- just for entertainment, blit the blurred image to the screen so that we can see it.
        Graphics.Blit(tex_atlas, BlitCopy); //<-- just for entertainment, blit the blurred image to the screen so that we can see it.
                                            //Graphics.DrawTexture(BillboardCamera.rect, SidePic_PaddedAlpha); //<-- just for entertainment, blit the blurred image to the screen so that we can see it.


        yield return StartCoroutine(Screenshot(SidePic, SidePic_PaddedAlpha, tex_atlas, BillboardTextureSize, BillboardTextureSize, 2));
        Texture2D ShadowMapRight;
        ShadowMapRight = new Texture2D(BillboardTextureSize, BillboardTextureSize);
        yield return StartCoroutine(ShadowTexture(SidePic, SidePic_NoBark, ShadowMapRight));

        //Now calculate Y axis (vertical) position of the horizontal (top) billboard face.
        //We check the two other planes (forward and right), and look for the row
        //of pixels that has the most leaf pixels (the widest row of leaf pixels),
        //and we will assume that row is the spot where the leaves in the tree are the widest.
        //And we will put the horizontal plane at that spot, so that it will as much as possible be
        //in the widest part of the tree. So, for example, on a Christmas Tree it will probably be at
        //the very bottom of the tree, where the branches are the widest. But on a Palm tree, it will 
        //likely be near the very top, where palm tree branches are found.
        int WidestFrontY = 0;
        int WidestFrontY_width = 0;
        int WidestSideY = 0;
        int WidestSideY_width = 0;
        for (int y = 0; y < FrontPic.height; y++)
        {
            int ThisWidthPix = 0;
            for (int x = 0; x < FrontPic.width; x++)
            {
                Color c = FrontPic.GetPixel(x, y);
                if (c.r > 0f || c.g > 0f || c.b > 0f)
                {
                    ThisWidthPix++;
                }
            }
            if (ThisWidthPix > WidestFrontY_width)
            {
                WidestFrontY_width = ThisWidthPix;
                WidestFrontY = y;
            }
        }
        for (int y = 0; y < SidePic.height; y++)
        {
            int ThisWidthPix = 0;
            for (int x = 0; x < SidePic.width; x++)
            {
                Color c = SidePic.GetPixel(x, y);
                if (c.r > 0f || c.g > 0f || c.b > 0f)
                {
                    ThisWidthPix++;
                }
            }
            if (ThisWidthPix > WidestSideY_width)
            {
                WidestSideY_width = ThisWidthPix;
                WidestSideY = y;
            }
        }

        float Yloc = ((WidestFrontY + WidestSideY) / 2f) / BillboardTextureSize;
        
        float TotalY_World = bounds.size.y;
        float MaximumY_World = bounds.max.y;
        float Yloc_Minimum = (TotalY_World - (MaximumY_World - 1.5f)) / TotalY_World;

        if (Yloc < Yloc_Minimum) Yloc = Yloc_Minimum; //<-- ensures that the horizontal plane isn't less than 1.5 world units above the ground.

        // Top
        vertices[8] = new Vector3(0f, Yloc, 0f);
        vertices[9] = new Vector3(1f, Yloc, 0f);
        vertices[10] = new Vector3(0f, Yloc, 1f);
        vertices[11] = new Vector3(1f, Yloc, 1f);
        tri[12] = 8; tri[13] = 10; tri[14] = 9;
        tri[15] = 10; tri[16] = 11; tri[17] = 9;
        normals[8] = Vector3.up;
        normals[9] = Vector3.up;
        normals[10] = Vector3.up;
        normals[11] = Vector3.up;
        tangents[8] = new Vector4(0f, 0f, 1f, 1f); //<-- same as Vector3.forward... the 4th digit (.w) is set to 1f which turns the bitangent direction in the default direction.
        tangents[9] = new Vector4(0f, 0f, 1f, 1f); //<-- same as Vector3.forward... the 4th digit (.w) is set to 1f which turns the bitangent direction in the default direction.
        tangents[10] = new Vector4(0f, 0f, 1f, 1f); //<-- same as Vector3.forward... the 4th digit (.w) is set to 1f which turns the bitangent direction in the default direction.
        tangents[11] = new Vector4(0f, 0f, 1f, 1f); //<-- same as Vector3.forward... the 4th digit (.w) is set to 1f which turns the bitangent direction in the default direction.
        newUVs = GetNextUVs(TX_size);
        Vector2[] topUVs = newUVs.ToArray();
        Vector2i top_tex_atlas_currentPosition = tex_atlas_currentPosition;

        uv[8] = newUVs[0]; // = Lower left corner
        uv[9] = newUVs[1]; // = lower right corner
        uv[10] = newUVs[2];// = upper left corner
        uv[11] = newUVs[3];// = upper right corner

        //Create a UV2 and set all the points on the horizontal (top) panel to form a thin line across the texture used by the Z axis.For all the points in the other two panels, set all their UV2 points to the top left corner(dummy points).
        float yLocation = Yloc;
        float yLocationi_forward = forward_tex_atlas_currentPosition.y;
        float yLocationi_right = right_tex_atlas_currentPosition.y;
        float yInc = 0.1f / tex_atlas.height;
        float xInc = 0.1f / tex_atlas.width;
        float yCenterIntersectionUVPoint_Forward = (yLocationi_forward / tex_atlas.height) + ((yLocation * TX_size) / tex_atlas.height) + yInc;
        float yCenterIntersectionUVPoint_Right = (yLocationi_right / tex_atlas.height) + ((yLocation * TX_size) / tex_atlas.height) + yInc;

        uv3[0] = new Vector2(0f, 0f); //(dummy points)
        uv3[1] = new Vector2(0f, 0f); //(dummy points)
        uv3[2] = new Vector2(0f, 0f); //(dummy points)
        uv3[3] = new Vector2(0f, 0f); //(dummy points)

        uv3[4] = new Vector2(0f, 0f); //(dummy points)
        uv3[5] = new Vector2(0f, 0f); //(dummy points)
        uv3[6] = new Vector2(0f, 0f); //(dummy points)
        uv3[7] = new Vector2(0f, 0f); //(dummy points)

        //THE NEXT 4 UV's are used exclusively by the HORIZONTAL PLANE to form LINE Z:
        uv3[8] = new Vector2(forwardUVs[0].x, yCenterIntersectionUVPoint_Forward); //form a thin line across the texture used by the Z (forward) axis
        uv3[9] = new Vector2(forwardUVs[1].x, yCenterIntersectionUVPoint_Forward); //form a thin line across the texture used by the Z (forward) axis
        uv3[10] = new Vector2(forwardUVs[2].x, yCenterIntersectionUVPoint_Forward); //form a thin line across the texture used by the Z (forward) axis
        uv3[11] = new Vector2(forwardUVs[3].x, yCenterIntersectionUVPoint_Forward); //form a thin line across the texture used by the Z (forward) axis

        //THE NEXT 4 UV's are used exclusively by the HORIZONTAL PLANE to form LINE X:
        uv4[8] = new Vector2(rightUVs[2].x, yCenterIntersectionUVPoint_Right); //form a thin line across the texture used by the X (right) axis. NOTE: This (top) plane's lower left corner links to the (right) planes upper left corner.
        uv4[9] = new Vector2(rightUVs[0].x, yCenterIntersectionUVPoint_Right); //form a thin line across the texture used by the X (right) axis. NOTE: This (top) plane's lower right corner links to the (right) planes lower left corner.
        uv4[10] = new Vector2(rightUVs[3].x, yCenterIntersectionUVPoint_Right); //form a thin line across the texture used by the X (right) axis. NOTE: This (top) plane's upper left corner links to the (right) planes upper right corner.
        uv4[11] = new Vector2(rightUVs[1].x, yCenterIntersectionUVPoint_Right); //form a thin line across the texture used by the X (right) axis. NOTE: This (top) plane's upper right corner links to the (right) planes lower right corner.

        //THE NEXT 4 UV's are used exclusively by the FORWARD PLANE to find ITS LINE across the HORIZONTAL PLANE's texture:
        yLocation = ((0f - bounds.min.z) / bounds.size.z);
        float yLocationi_top = top_tex_atlas_currentPosition.y;
        float yCenterIntersectionUVPoint_Top = (yLocationi_top / tex_atlas.height) + ((yLocation * TX_size) / tex_atlas.height) + yInc;
        uv4[0] = new Vector2(topUVs[0].x, yCenterIntersectionUVPoint_Top); //all the points on the Z panel to form a thin line across the texture used by the horizontal panel
        uv4[1] = new Vector2(topUVs[1].x, yCenterIntersectionUVPoint_Top); //all the points on the Z panel to form a thin line across the texture used by the horizontal panel
        uv4[2] = new Vector2(topUVs[2].x, yCenterIntersectionUVPoint_Top); //all the points on the Z panel to form a thin line across the texture used by the horizontal panel
        uv4[3] = new Vector2(topUVs[3].x, yCenterIntersectionUVPoint_Top); //all the points on the Z panel to form a thin line across the texture used by the horizontal panel

        //THE NEXT 4 UV's are used exclusively by the RIGHT PLANE to find ITS LINE across the HORIZONTAL PLANE's texture:
        float xLocation = ((0f - bounds.min.x) / bounds.size.x);
        float xLocationi_top = top_tex_atlas_currentPosition.x;
        float xCenterIntersectionUVPoint_Top = (xLocationi_top / tex_atlas.width) + ((xLocation * TX_size) / tex_atlas.width) + xInc;
        uv4[4] = new Vector2(xCenterIntersectionUVPoint_Top, topUVs[1].y); //all points on the X panel to also form a line across the texture used by the horizontal panel. NOTE: This (right) plane's lower left corner links to the horizontal (top) planes lower right corner.
        uv4[5] = new Vector2(xCenterIntersectionUVPoint_Top, topUVs[3].y); //all points on the X panel to also form a line across the texture used by the horizontal panel. NOTE: This (right) plane's lower right corner links to the horizontal (top) planes upper right corner.
        uv4[6] = new Vector2(xCenterIntersectionUVPoint_Top, topUVs[0].y); //all points on the X panel to also form a line across the texture used by the horizontal panel. NOTE: This (right) plane's upper left corner links to the horizontal (top) planes lower left corner.
        uv4[7] = new Vector2(xCenterIntersectionUVPoint_Top, topUVs[2].y); //all points on the X panel to also form a line across the texture used by the horizontal panel. NOTE: This (right) plane's upper right corner links to the horizontal (top) planes upper left corner.

        //WARNING on 9/15/2016: The comments below may be slightly outdated. :)

        //The next set of UV2's are very complex, they hold 4 numbers instead of just two. 
        // UV2.x saves both UVcenter.x and UVcenter.y
        // UV2.y saves both ratio.x and ratio.y

        //To compress both the UVCenter.x and UVCenter.y values into a single float, to be saved into UV2.x:

        //To save a value of both 0.5601 and 0.6992, we would do:
        //trunc(0.5601 * 1000) = 560
        //Then add on the second decimal, to get: 560.6992.
        //Note: For the UVCenter, we'll mutiply it by 1000. But for the ratio, we'll multiply it by 10000, since it is a very tiny number. This gives us
        //four digits of precision on it, instead of just 3.

        //The shader would then trunc that value, to get 560. Subtract that from 560.6992 to
        //get 0.6992, which is the second part of the data we need. Then divide 560 by 1000 to get
        //0.560, which is the first part of the data we needed, accurate to the third digit. Good enough.

        //UVCenter is the UV vector where the intersection point is located, in UV space, not in world space. This vector is or can be different for
        //each plane, and it is likely to not be at exactly the center of the UV. Remember: The UV is in an atlas.

        //Ratio.x is the length of the part of the atlas UV that holds this texture, divided by the WORLD SPACE length of this plane along the same
        //direction that the "x" axis of the texture is drawn. This ratio can then be used to convert a length of UV space to world space for the
        //UV's X axis.

        //Ratio.y is the same as Ratio.x, only it is for the Y axis. Remmeber, the textures in the atlas are always perfectly square, but the planes
        //can be rectangular with different lengths on each side.

        //Using these values, the shader can then calculate the center point in world space where all three planes intersect, using the following logic:
        //1) Shader knows the world position of the pixel it is working on.
        //2) Shader knows the UV space position of the pixel it is working on.
        //3) We canculate the angle and distance, in UV space, to the UVCenter position which we saved here in UV2.
        //4) The shander knows the direction of this UV's Y axis... for all three planes, the TANGENT DIRECTION points in the direction of UV.y
        //5) The shader knows the direction of this UV's X axis... for all three planes, the BITANGENT DIRECTION points in the direction of UV.x
        //6) So create a vector3, and set it to the position of this pixel that the shader is working on.
        //7) Move that vector through world space in the direction of TANGENT, which is UV.y, an amount equal to (((UV.y - UVCenter.y) / Ratio.y) * TangentDir)
        //8) Move that vector through world space in the direction of BITANGENT, which is UVx, an amount equal to (((UV.x - UVCenter.x) / Ratio.x) * BiTangentDir)
        //9) The vector3 should not be located, in world space, in the very center of the tree where all three planes intersect. And best of all, it
        //should fully support any rotation of the tree, AND it supports BATCHING OF THE MESH!! :)

        //The shader can also calculate the direction of all three planes.

        //If shader is processing the forward plane, then: X_WorldSpaceVector=BiTangentDir, Y_WorldSpaceVector=TangentDir, Z_WorldSpaceVector=NormalDir
        //If shader is processing the right plane, then: X_WorldSpaceVector=NormalDir, Y_WorldSpaceDir=TangentDir, Z_WorldSpaceVector=BiTangentDir
        //If shader is processing the top plane, then: X_WorldSpaceVector=BiTangentDir, Y_WorldSpaceVector=NormalDir, Z_WorldSpaceVector=TangentDir

        //The shader figures out which plane it is, by reading the alpha channel of the pixel.
        //For the forward plane, all its pixels will have an alpha value of 0.1 (clipped) or 0.98 (opaque).
        //For the right plane, all its pixels will have an alpha value of 0.02 (clipped) or 0.99 (opaque).
        //For the top plane, all its pixels will have an alpha value of 0.03 (clipped) or 1.0 (opaque).

        //TOP: Normal = local Y axis, Tangent = local Z axis, Bitangent = local X axis
        //FORWARD: Normal = local Z axis, Tangent = local Y axis, Bitangent = local X axis
        //RIGHT: Normal = local X axis, Tangent = local Y axis, Bitangent = local Z axis

        float TX_scale_Y = TX_size / (float)tex_atlas.height;
        float TX_scale_X = TX_size / (float)tex_atlas.width;


        //THE NEXT 4 UV's are used exclusively by the FORWARD PLANE to find the CENTER POINT in WORLD SPACE where all three planes intersect:
        float xCenterIntersectionUVPoint_Forward = (xCenterIntersectionUVPoint_Top - topUVs[0].x) //<-- Take distance from TOP plane's buttom edge to TOP planes UVCenter.y
                                                   + forwardUVs[0].x; //<-- add FORWARD plane's left edge
        Vector2 FORWARD_UVCenter = new Vector2(xCenterIntersectionUVPoint_Forward, yCenterIntersectionUVPoint_Forward);
        Vector2 FORWARD_Ratio = new Vector2((TX_scale_X / bounds.size.z), //<-- for the FORWARD plane, its UV.x axis aligns to local space Z axis.
                                            (TX_scale_Y / bounds.size.y)); //<-- for the FORWARD plane, its UV.y axis aligns to local space Y axis.
        Vector2 FORWARD_UV2 = new Vector2((Mathf.Round(FORWARD_UVCenter.x * 1000) + FORWARD_UVCenter.y), (Mathf.Round(FORWARD_Ratio.x * 10000) + FORWARD_Ratio.y));
        uv2[0] = new Vector2(FORWARD_UV2.x, FORWARD_UV2.y);
        uv2[1] = new Vector2(FORWARD_UV2.x, FORWARD_UV2.y);
        uv2[2] = new Vector2(FORWARD_UV2.x, FORWARD_UV2.y);
        uv2[3] = new Vector2(FORWARD_UV2.x, FORWARD_UV2.y);

        //THE NEXT 4 UV's are used exclusively by the RIGHT PLANE to find the CENTER POINT in WORLD SPACE where all three planes intersect:
        float xCenterIntersectionUVPoint_Right = (yCenterIntersectionUVPoint_Top - topUVs[0].y) //<-- Take distance from TOP plane's left edge to TOP planes UVCenter.x
                                                 + rightUVs[0].x; //<-- add RIGHT plane's left edge.
        Vector2 RIGHT_UVCenter = new Vector2(xCenterIntersectionUVPoint_Right, yCenterIntersectionUVPoint_Right);
        Vector2 RIGHT_Ratio = new Vector2((TX_scale_X / bounds.size.x), //<-- for the RIGHT plane, its UV.x axis aligns to local space X axis.
                                          (TX_scale_Y / bounds.size.y)); //<-- for the RIGHT plane, its UV.y axis aligns to local space Y axis.
        Vector2 RIGHT_UV2 = new Vector2((Mathf.Round(RIGHT_UVCenter.x * 1000) + RIGHT_UVCenter.y), (Mathf.Round(RIGHT_Ratio.x * 10000) + RIGHT_Ratio.y));
        uv2[4] = new Vector2(RIGHT_UV2.x, RIGHT_UV2.y);
        uv2[5] = new Vector2(RIGHT_UV2.x, RIGHT_UV2.y);
        uv2[6] = new Vector2(RIGHT_UV2.x, RIGHT_UV2.y);
        uv2[7] = new Vector2(RIGHT_UV2.x, RIGHT_UV2.y);

        //THE NEXT 4 UV's are used exclusively by the HORIZONTAL PLANE to find CENTER POINT in WORLD SPACE where all three planes intersect:
        Vector2 TOP_UVCenter = new Vector2(xCenterIntersectionUVPoint_Top, yCenterIntersectionUVPoint_Top); //<-- same as what we calculated earlier.
        Vector2 TOP_Ratio = new Vector2((TX_scale_X / bounds.size.x),  //<-- for the TOP plane, its UV.x axis aligns to local space X axis.
                                        (TX_scale_Y / bounds.size.z)); //<-- for the TOP plane, its UV.y axis aligns to local space Z axis.
        Vector2 TOP_UV2 = new Vector2((Mathf.Round(TOP_UVCenter.x * 1000) + TOP_UVCenter.y), (Mathf.Round(TOP_Ratio.x * 10000) + TOP_Ratio.y));
        uv2[8] = new Vector2(TOP_UV2.x, TOP_UV2.y);
        uv2[9] = new Vector2(TOP_UV2.x, TOP_UV2.y);
        uv2[10] = new Vector2(TOP_UV2.x, TOP_UV2.y);
        uv2[11] = new Vector2(TOP_UV2.x, TOP_UV2.y);

        BillboardCamera.transform.rotation = Quaternion.LookRotation(Vector3.down);
        MainCam.transform.rotation = Quaternion.LookRotation(Vector3.down);
        yield return new WaitForEndOfFrame();
        Texture2D TopPic = new Texture2D(BillboardTextureSize, BillboardTextureSize);
        TopPic.ReadPixels(new Rect(0, 0, BillboardTextureSize, BillboardTextureSize), 0, 0);
        TopPic.Apply();

        Texture2D TopPic_PaddedAlpha = new Texture2D(BillboardTextureSize, BillboardTextureSize);
        RenderTexture TopPic_PaddedAlphaRT = new RenderTexture(BillboardTextureSize, BillboardTextureSize, 0, RenderTextureFormat.ARGB32);
        RenderTexture TopPic_OriginalRT = new RenderTexture(BillboardTextureSize, BillboardTextureSize, 0, RenderTextureFormat.ARGB32);
        RenderTexture TopPic_WorkingRT = new RenderTexture(BillboardTextureSize, BillboardTextureSize, 0, RenderTextureFormat.ARGB32);
        TopPic_PaddedAlphaRT.antiAliasing = 1;
        TopPic_PaddedAlphaRT.filterMode = FilterMode.Point;
        TopPic_PaddedAlphaRT.autoGenerateMips = false;
        TopPic_PaddedAlphaRT.useMipMap = false;
        TopPic_OriginalRT.antiAliasing = 1;
        TopPic_OriginalRT.filterMode = FilterMode.Point;
        TopPic_OriginalRT.autoGenerateMips = false;
        TopPic_OriginalRT.useMipMap = false;
        TopPic_WorkingRT.antiAliasing = 1;
        TopPic_WorkingRT.filterMode = FilterMode.Point;
        TopPic_WorkingRT.autoGenerateMips = false;
        TopPic_WorkingRT.useMipMap = false;

        Graphics.Blit(TopPic, TopPic_OriginalRT); //TopPic_OriginalRT contains the pixels of our original image (before blur effects)
        Graphics.Blit(TopPic_OriginalRT, TopPic_PaddedAlphaRT); //<-- initial setup
        Graphics.Blit(TopPic_OriginalRT, TopPic_WorkingRT); //<-- initial setup

        for (int LoopTimes = 0; LoopTimes < 10; LoopTimes++)
        {
            DoAlphaPadding(2, 10f, 4, TopPic_WorkingRT, TopPic_PaddedAlphaRT); //<-- perform blur #1
            Graphics.Blit(TopPic_PaddedAlphaRT, TopPic_WorkingRT); //<-- save blur #1 to working RT
            Graphics.Blit(TopPic_OriginalRT, TopPic_WorkingRT, BackgroundClippedCopy); //<-- copy the original, skips background pixels. This gives us a blurred image where the original pixels are unaffected.
        }

        for (int LoopTimes = 0; LoopTimes < 10; LoopTimes++)
        {
            DoAlphaPadding(2, 0f, 4, TopPic_WorkingRT, TopPic_PaddedAlphaRT); //<-- perform blur #2
            Graphics.Blit(TopPic_PaddedAlphaRT, TopPic_WorkingRT); //<-- save blur #2 to working RT
            Graphics.Blit(TopPic_OriginalRT, TopPic_WorkingRT, BackgroundClippedCopy); //<-- copy the original, skips background pixels. This gives us a blurred image where the original pixels are unaffected.
        }

        for (int LoopTimes = 0; LoopTimes < 10; LoopTimes++)
        {
            DoAlphaPadding(0, 0f, 4, TopPic_WorkingRT, TopPic_PaddedAlphaRT); //<-- perform blur #3
            Graphics.Blit(TopPic_PaddedAlphaRT, TopPic_WorkingRT); //<-- save blur #3 to working RT
            Graphics.Blit(TopPic_OriginalRT, TopPic_WorkingRT, BackgroundClippedCopy); //<-- copy the original, skips background pixels. This gives us a blurred image where the original pixels are unaffected.
        }

        Graphics.Blit(TopPic_WorkingRT, TopPic_PaddedAlphaRT); //Final blit
        RenderTexture.active = TopPic_PaddedAlphaRT; //<-- prepare to read from our blurred texture, instead of the screen.
        TopPic_PaddedAlpha.ReadPixels(new Rect(0, 0, BillboardTextureSize, BillboardTextureSize), 0, 0); //<-- read
        TopPic_PaddedAlpha.Apply();
        RenderTexture.active = null; //<-- set it back to read from the screen again.
        Graphics.Blit(TopPic_PaddedAlphaRT, BlitCopy); //<-- just for entertainment, blit the blurred image to the screen so that we can see it.
        Graphics.Blit(tex_atlas, BlitCopy); //<-- just for entertainment, blit the blurred image to the screen so that we can see it.
        //Graphics.DrawTexture(BillboardCamera.rect, TopPic_PaddedAlpha); //<-- just for entertainment, blit the blurred image to the screen so that we can see it.

        yield return StartCoroutine(Screenshot(TopPic, TopPic_PaddedAlpha, tex_atlas, BillboardTextureSize, BillboardTextureSize, 3));

        // Transform the geometry (for the forward plane)
        for (int i = 0; i < 4; i++)
        {
            vertices[i].x = Mathf.Lerp(bounds.min.x, bounds.max.x, vertices[i].x);
            vertices[i].y = Mathf.Lerp(0f, bounds.max.y - bounds.min.y, vertices[i].y);
            vertices[i].z = 0f;
        }

        // Transform the geometry (for the right plane)
        for (int i = 4; i < 8; i++)
        {
            vertices[i].x = 0f;
            vertices[i].y = Mathf.Lerp(0f, bounds.max.y - bounds.min.y, vertices[i].y);
            vertices[i].z = Mathf.Lerp(bounds.min.z, bounds.max.z, vertices[i].z);
        }

        // Transform the geometry (for the top plane)
        for (int i = 8; i < 12; i++)
        {
            vertices[i].x = Mathf.Lerp(bounds.min.x, bounds.max.x, vertices[i].x);
            vertices[i].y = Mathf.Lerp(0f, bounds.max.y - bounds.min.y, vertices[i].y);
            vertices[i].z = Mathf.Lerp(bounds.min.z, bounds.max.z, vertices[i].z);
        }

        //// Create mipmaps
        //tex_atlas.SetPixels(tex_atlas.GetPixels());
        //tex_atlas.Apply();

        // Set mesh data
        BillboardMesh.vertices = vertices;
        BillboardMesh.triangles = tri;
        BillboardMesh.normals = normals;
        BillboardMesh.tangents = tangents;
        BillboardMesh.uv = uv;
        BillboardMesh.uv2 = uv2;
        BillboardMesh.uv3 = uv3;
        BillboardMesh.uv4 = uv4;



        Destroy(renderParent); //<-- screenshots are done.

        List<Color> HQColors = new List<Color>();
        ExportData.Original_ShadowStrength = 1f;
        foreach (Material matloop in lod0Mats)
        {
            HQColors.Add(matloop.GetColor("_Color"));
            if (matloop.shader.name.Contains("Leaves"))
            {
                ExportData.LeavesShader = _LushLODTree.GetLeavesShader(true, ExportData.UsingFastLeavesShader, false, false, ExportData.UsingFastLeavesShader == true ? 1 : 0);
                ExportData.Original_ShadowStrength = matloop.GetFloat("_ShadowStrength");
            }
            else
            {
                ExportData.BarkShader = _LushLODTree.GetBarkShader(true, false, false);
            }
        }

        Mesh HQMesh = Instantiate(lod0.GetComponent<MeshFilter>().sharedMesh);

        if (MergeVerts == 1)
        {
            MergeDuplicateVerts(HQMesh);
        }

        Vector3[] HQVecs = HQMesh.vertices;

        Vector2[] HQ_uv3 = new Vector2[HQVecs.Length]; //<-- this will hold the shadow map data for the forward axis.
        Vector2[] HQ_uv4 = new Vector2[HQVecs.Length]; //<-- this will hold the shadow map data for the right axis.

        Vector3 HQ_Ratios = new Vector3(TX_size / bounds.size.x, TX_size / bounds.size.y, TX_size / bounds.size.z);

        for (int i = 0; i < HQVecs.Length; i++)
        {
            float newX = ((HQVecs[i].x - bounds.min.x) * HQ_Ratios.x) / TX_size;
            float newY = ((HQVecs[i].y - bounds.min.y) * HQ_Ratios.y) / TX_size;
            float newZ = ((HQVecs[i].z - bounds.min.z) * HQ_Ratios.z) / TX_size;

            HQ_uv3[i] = new Vector2(newX, newY); //<-- this will be the shadow map data for the forward plane.
            HQ_uv4[i] = new Vector2(newZ, newY); //<-- this will be the shadow map data for the right plane.

        }

        HQMesh.uv3 = HQ_uv3;
        HQMesh.uv4 = HQ_uv4;

        //Prepare the remaining parts of the exported data:
        ExportData.BillboardMesh = BillboardMesh;
        ExportData.HQMesh = HQMesh;
        ExportData.Lod1_LocalPosition = new Vector3(0f, bounds.min.y, 0f);
        ExportData.lodDistance = _LushLODTreesManager.DefaultLodDistance;
        ExportData.maincolor_HQTrees_ORIGINALS = HQColors;
        ExportData.AverageColor_Bark = AverageColor_Bark;
        ExportData.AverageColor_Leaves = AverageColor_Leaves;
        ExportData.RealTimeShadowSetting = _LushLODTreesManager.RealTimeShadowSettings.BillboardOnly;
        ExportData.ShadowReceiveSetting = _LushLODTreesManager.ShadowReceiveSettings.SimpleShadows; //<-- by default, our trees will use the Simple Shadows.
        ExportData.ShadowMapFront = ShadowMapFront;
        ExportData.ShadowMapRight = ShadowMapRight;

        //Lastly, we need to strip the TREE component off of the LushLOD Trees. 
        //The reason for this is: it can for seemingly no reason REBUILD the mesh when
        //you select the tree, even if you do not change any of the settings. This rebuild would
        //delete the UV3 and UV4 from the mesh, which would mess up the simple shadows shader.

        //Plus, the user shouldn't mess with the tree's appearance after the billboards have been created,
        //because then the billboards won't match the appearance of the tree anymore. So to modify the
        //tree, they need to go back to the converter scene and convert the tree(s) again, so that a new
        //atlas can be made for all the trees in their scene, and then import the updated trees into their
        //main scene to apply any changes they made.

        //However, if we simply remove the TREE component, the tree will no longer work with wind zones.
        //I looked everywhere inside of Unity's source code, and I could not find where exactly the "tree" component
        //enables the wind to work. But here is what I learned.

        //First of all, the Tree component doesn't appear to ACTUALLY be necessary for the tree to work with wind.
        //Because all of the necessary data for the wind is recorded into the mesh's vertice colors, and also into
        //the Mesh's UV2.

        //Yet still, the engine seems to ignore the tree if the "tree" componenet isn't attached. That said, you can simply
        //remove the "Tree Data" object from the tree, and it will no longer display any options to modify the tree...
        //it basically appears to kill the tree if you remove the tree data. Put since all the necessary wind zone data is
        //still recorded into the mesh's UV2 and vertice colors... the wind still works, even though the "treedata" object
        //was removed.

        //So my solution here is to remove the tree data, and leave the "tree" component. It won't function in any way whatsoever,
        //except that if the user turns on a wind zone, the tree will animate. Again, I looked everywhere, but I couldn't find
        //where or how or why the tree component has to be attached for the wind to work.

        //Additionally, here is my notes that I took while I was trying to track down the how the tree component is needed for 
        //the wind zones to work:

        //First thing: You can decompile the Unity source code using ILSpy. I was looking at code in these locations:
        //  PROGRAM FILES DIRECTORY/Editor/Data/Managed/UnityEngine.dll
        //  PROGRAM FILES DIRECTORY/Editor/Data/Managed/UnityEditor.dll
        //  PROGRAM FILES DIRECTORY/Editor/Data/UnityExtensions/Unity/TreeEditor/Editor/UnityEditor.TreeEditor.dll

        //Here's my notes:

        //1) It is definately being processed by the shader
        //1.1) The shader is using:
        //  TreeVertLeaf(inout appdata_full v) from UnityBuiltin3xTreeLibrary.cginc
        //  v.vertex = AnimateVertex(v.vertex, v.normal, float4(v.color.xy, v.texcoord1.xy));
        //  AnimateVertex(float4 pos, float3 normal, float4 animParams) from TerrainEngine.cginc
        //      // animParams stored in color
        //      // animParams.x = branch phase (I think this is vertex.color.r)
        //      // animParams.y = edge flutter factor (I think this is vertex.color.g)
        //      // animParams.z = primary factor (I think this is UV2.x)
        //      // animParams.w = secondary factor (I think this is UV2.y)
        //2) It definately requires the tree component to be attached
        //3) It definately requires the wind zone to be active
        //4) It definately is recording the wind into the vertex colors, and into UV2
        //5) It appears to calculate animation of vectors in TreeEditor.TreeVertex.Lerp4()
        //6) It stores the animation factors in TreeEditor.TreeVertex.SetAnimationProperties()
        //7) That lerp4 is only called by one function: UpdateNodeMesh() in TreeEditor.TreeGroupLeaf.cs
        //7.1) SetAnimationProperties() is found in: TreeVertex.cs and RingLoop.cs
        //8) SetAnimationProperties is called from: UpdateNodeMesh() in TreeEditor.TreeGroupLeaf.cs
        //9) SetAnimationProperties is called from: UpdateNodeMesh() in TreeEditor.TreeGroupBranch.cs
        //10) UpdateNodeMesh() is only called from: UpdateMesh(), in each of the above classes.
        //11) UpdateMesh() is called from:
        //      TreeEditor.TreeData.PreviewMesh()
        //      TreeEditor.TreeEditor.CreateNewTree()
        //      TreeEditor.TreeEditor.DuplicateSelected()
        //      TreeEditor.TreeEditor.OnCheckHotkeys()
        //      TreeEditor.TreeEditor.OnSceneGUI()...requires various "mouse up" type events
        //      TreeEditor.TreeEditor.InspectorHierarchy()...requires "refresh" button click
        //      TreeEditor.TreeEditor.OnInspectorGUI()...requires selection
        // CONCLUSION: The UV2 and vertex colors are only changed when you are actually editing
        //              the tree, since all calls to UpdateMesh() require some kind of action
        //              from the user such as a mouse click, or something selected.
        // THEREFORE: It would appear that the animParams that are put into the vertices DOES NOT CHANGE.
        //Meaning, there is no need to continually recalculate the UV2 or the vertex colors,
        //once those values are put into the mesh once, they will work with ANY wind.
        //However, for some reason which I simply cannot figure out, the tree component still is
        //required to enable the wind. Nevertheless, all you have to do is simply strip out the
        //TREE DATA from the tree component, and bingo, it is "dead" but the wind will animate
        //the tree because the mesh itself still contains the required data.

        //Note: we will simply add a "Tree" component, with no treedata, to the exported prefab.
        //This will be done later.

    }

    /// <summary>
    /// This function exports the LushLODTrees (saves them and all their various parts to the hard drive):
    /// </summary>
    /// <returns></returns>
    System.Collections.IEnumerator Export()
    {
#if UNITY_EDITOR
                
        byte[] bytes;

        Directory.CreateDirectory(Application.dataPath + "/" + exportPath);
        Directory.CreateDirectory(Application.dataPath + "/" + exportPath + "/Atlas/");
        Directory.CreateDirectory(Application.dataPath + "/" + exportPath + "/Atlas/Materials");
        Directory.CreateDirectory(Application.dataPath + "/" + exportPath + "/Atlas/Texture");

        bytes = tex_atlas.EncodeToPNG();
        System.IO.File.WriteAllBytes(Application.dataPath + "/" + exportPath + "/Atlas/Texture/Atlas.png", bytes);

        AssetDatabase.SaveAssets();
        AssetDatabase.Refresh();

        TextureImporter tImporter = AssetImporter.GetAtPath("Assets/" + exportPath + "/Atlas/Texture/Atlas.png") as TextureImporter;
        if (tImporter != null)
        {
            tImporter.alphaIsTransparency = false; //<-- don't set this to true, it would overwrite our alpha padding effect.
            AssetDatabase.ImportAsset("Assets/" + exportPath + "/Atlas/Texture/Atlas.png", ImportAssetOptions.ForceUpdate);
        }

        Texture2D readAtlasTex;
        readAtlasTex = AssetDatabase.LoadAssetAtPath("Assets/" + exportPath + "/Atlas/Texture/Atlas.png", typeof(Texture2D)) as Texture2D;

        Material Save_Material_NotInstance_FullyOpaque = new Material(Material_NotInstance_FullyOpaque);
        Material Save_Material_Transitioning = new Material(Material_Transitioning);

        Save_Material_NotInstance_FullyOpaque.SetTexture("_MainTex", readAtlasTex);
        Save_Material_Transitioning.SetTexture("_MainTex", readAtlasTex);

        Save_Material_Transitioning.SetFloat("_Transparency", 1f); //Turn the billboards fully on (in case it isn't)
        
        AssetDatabase.CreateAsset(Save_Material_NotInstance_FullyOpaque, "Assets/" + exportPath + "/Atlas/Materials/Material_NotInstance_FullyOpaque.mat");
        AssetDatabase.CreateAsset(Save_Material_Transitioning, "Assets/" + exportPath + "/Atlas/Materials/Material_Transitioning.mat");

        AssetDatabase.SaveAssets();
        AssetDatabase.Refresh();

        Save_Material_NotInstance_FullyOpaque = AssetDatabase.LoadAssetAtPath("Assets/" + exportPath + "/Atlas/Materials/Material_NotInstance_FullyOpaque.mat", typeof(Material)) as Material;
        Save_Material_Transitioning = AssetDatabase.LoadAssetAtPath("Assets/" + exportPath + "/Atlas/Materials/Material_Transitioning.mat", typeof(Material)) as Material;

        EditorUtility.ClearProgressBar();

        for (int i = 0; i < NewTrees.Length; i++)
        {
            TreeConverting tree = NewTrees[i];

            EditorUtility.DisplayProgressBar("Progress", "Saving Prefabs", 0.5f + (((float)i / NewTrees.Length) / 2f));


            string TreeName = tree.exportName;
            GameObject lod0 = tree.HQTreeObj;

            Directory.CreateDirectory(Application.dataPath + "/" + exportPath + "/Trees/" + TreeName);
            Directory.CreateDirectory(Application.dataPath + "/" + exportPath + "/Trees/" + TreeName + "/Lod0");
            Directory.CreateDirectory(Application.dataPath + "/" + exportPath + "/Trees/" + TreeName + "/Lod0/Materials");
            Directory.CreateDirectory(Application.dataPath + "/" + exportPath + "/Trees/" + TreeName + "/Lod0/Textures");
            Directory.CreateDirectory(Application.dataPath + "/" + exportPath + "/Trees/" + TreeName + "/Lod0/Mesh");

            //duplicate asset files for:
            //1) HQ tree... 4 different leaf textures

            string diffuse_path = AssetDatabase.GetAssetPath(lod0.GetComponent<Renderer>().sharedMaterials[1].GetTexture("_MainTex"));
            string normal_specular_path = AssetDatabase.GetAssetPath(lod0.GetComponent<Renderer>().sharedMaterials[1].GetTexture("_BumpSpecMap"));
            string shadow_path = AssetDatabase.GetAssetPath(lod0.GetComponent<Renderer>().sharedMaterials[1].GetTexture("_ShadowTex"));
            string translucency_gloss_path = AssetDatabase.GetAssetPath(lod0.GetComponent<Renderer>().sharedMaterials[1].GetTexture("_TranslucencyMap"));

            AssetDatabase.CopyAsset(diffuse_path, "Assets/" + exportPath + "/Trees/" + TreeName + "/Lod0/Textures/diffuse.png");
            AssetDatabase.CopyAsset(normal_specular_path, "Assets/" + exportPath + "/Trees/" + TreeName + "/Lod0/Textures/normal_specular.png");
            AssetDatabase.CopyAsset(shadow_path, "Assets/" + exportPath + "/Trees/" + TreeName + "/Lod0/Textures/shadow.png");
            AssetDatabase.CopyAsset(translucency_gloss_path, "Assets/" + exportPath + "/Trees/" + TreeName + "/Lod0/Textures/translucency_gloss.png");

            AssetDatabase.SaveAssets();
            AssetDatabase.Refresh();

            //Create asset files for:
            //1) HQ tree... 2 different shadow map textures
            //3) HQ tree... HQ mesh

            bytes = tree.ShadowMapFront.EncodeToPNG();
            System.IO.File.WriteAllBytes(Application.dataPath + "/" + exportPath + "/Trees/" + TreeName + "/Lod0/Textures/ShadowMapFront.png", bytes);
            bytes = tree.ShadowMapRight.EncodeToPNG();
            System.IO.File.WriteAllBytes(Application.dataPath + "/" + exportPath + "/Trees/" + TreeName + "/Lod0/Textures/ShadowMapRight.png", bytes);

            AssetDatabase.SaveAssets();
            AssetDatabase.Refresh();

            Mesh HQMesh = tree.HQMesh; //<-- the HQ mesh was already generated earlier (with added UV3 and UV4), and saved here.
            SaveMeshToFile(HQMesh, "Assets/" + exportPath + "/Trees/" + TreeName + "/Lod0/Mesh/HQMesh.asset");

            //Create 2 materials, and link them to the texture files we saved.
            Material HQBarkMat = null;
            Material HQLeavesMat = null;
            
            //Get the HQ materials:
            foreach (Material matloop in lod0.GetComponent<Renderer>().sharedMaterials)
            {
                if (matloop.shader.name.Contains("Bark"))
                {
                    HQBarkMat = matloop;
                }
                else
                {
                    HQLeavesMat = matloop;
                }
            }

            if (HQBarkMat == null || HQLeavesMat == null)
            {
                //Something wen't wrong.
                UnityEngine.Debug.LogError("Tree conversion failed for " + tree.exportName + ": Unable to locate bark or leaf material on your tree.");
                yield return null;
            }

            Material LeavesMat = new Material(HQLeavesMat);
            Material BarkMat = new Material(HQBarkMat);

            LeavesMat.shader = tree.LeavesShader;
            BarkMat.shader = tree.BarkShader;

            Texture2D readTex;
            readTex = AssetDatabase.LoadAssetAtPath("Assets/" + exportPath + "/Trees/" + TreeName + "/Lod0/Textures/diffuse.png", typeof(Texture2D)) as Texture2D;
            LeavesMat.SetTexture("_MainTex", readTex);
            BarkMat.SetTexture("_MainTex", readTex);
            readTex = AssetDatabase.LoadAssetAtPath("Assets/" + exportPath + "/Trees/" + TreeName + "/Lod0/Textures/normal_specular.png", typeof(Texture2D)) as Texture2D;
            LeavesMat.SetTexture("_BumpSpecMap", readTex);
            BarkMat.SetTexture("_BumpSpecMap", readTex);
            readTex = AssetDatabase.LoadAssetAtPath("Assets/" + exportPath + "/Trees/" + TreeName + "/Lod0/Textures/shadow.png", typeof(Texture2D)) as Texture2D;
            LeavesMat.SetTexture("_ShadowTex", readTex);
            readTex = AssetDatabase.LoadAssetAtPath("Assets/" + exportPath + "/Trees/" + TreeName + "/Lod0/Textures/translucency_gloss.png", typeof(Texture2D)) as Texture2D;
            LeavesMat.SetTexture("_TranslucencyMap", readTex);
            BarkMat.SetTexture("_TranslucencyMap", readTex);
            readTex = AssetDatabase.LoadAssetAtPath("Assets/" + exportPath + "/Trees/" + TreeName + "/Lod0/Textures/ShadowMapFront.png", typeof(Texture2D)) as Texture2D;
            LeavesMat.SetTexture("_ShadowMapFront", readTex);
            BarkMat.SetTexture("_ShadowMapFront", readTex);
            readTex = AssetDatabase.LoadAssetAtPath("Assets/" + exportPath + "/Trees/" + TreeName + "/Lod0/Textures/ShadowMapRight.png", typeof(Texture2D)) as Texture2D;
            LeavesMat.SetTexture("_ShadowMapRight", readTex);
            BarkMat.SetTexture("_ShadowMapRight", readTex);

            BarkMat.SetFloat("_Transparency", 1f); //Turn the HQ bark fully on (in case it isn't)
            LeavesMat.SetFloat("_Transparency", 1f); //Turn the HQ leaves fully on (in case it isn't)

            //Save the two materials to the disk
            AssetDatabase.CreateAsset(LeavesMat, "Assets/" + exportPath + "/Trees/" + TreeName + "/Lod0/Materials/Optimized Leaf Material.mat");
            AssetDatabase.CreateAsset(BarkMat, "Assets/" + exportPath + "/Trees/" + TreeName + "/Lod0/Materials/Optimized Bark Material.mat");

            AssetDatabase.SaveAssets();
            AssetDatabase.Refresh();

            //Reload the materials from the disk
            LeavesMat = AssetDatabase.LoadAssetAtPath("Assets/" + exportPath + "/Trees/" + TreeName + "/Lod0/Materials/Optimized Leaf Material.mat", typeof(Material)) as Material;
            BarkMat = AssetDatabase.LoadAssetAtPath("Assets/" + exportPath + "/Trees/" + TreeName + "/Lod0/Materials/Optimized Bark Material.mat", typeof(Material)) as Material;

            //Create a gameobject called newlod0
            GameObject newLOD0 = new GameObject("Lod_0");

            //Add the warning message.
            newLOD0.AddComponent<_LushLODTreeWarning>();

            //Add a mesh filter to that game object
            newLOD0.AddComponent<MeshFilter>();

            //Link the mesh filter to the HQ mesh file we saved.
            Mesh readMesh = AssetDatabase.LoadAssetAtPath("Assets/" + exportPath + "/Trees/" + TreeName + "/Lod0/Mesh/HQMesh.asset", typeof(Mesh)) as Mesh;
            newLOD0.GetComponent<MeshFilter>().sharedMesh = readMesh;

            //Add mesh renderer to the lod0 gameobject
            newLOD0.AddComponent<MeshRenderer>();

            //Add the two materials to the mesh renderer.
            List<Material> newMats = new List<Material>();
            newMats.Add(BarkMat);
            newMats.Add(LeavesMat);
            newLOD0.GetComponent<MeshRenderer>().sharedMaterials = newMats.ToArray();
            newLOD0.GetComponent<MeshRenderer>().receiveShadows = false;
            newLOD0.GetComponent<MeshRenderer>().shadowCastingMode = UnityEngine.Rendering.ShadowCastingMode.Off;

            //Add tree component 
            newLOD0.AddComponent<Tree>();

            //Now, make copy of everything relating to lod1 (the billboard):

            Directory.CreateDirectory(Application.dataPath + "/" + exportPath + "/Trees/" + TreeName + "/Lod1");
            Directory.CreateDirectory(Application.dataPath + "/" + exportPath + "/Trees/" + TreeName + "/Lod1/Mesh");

            Mesh LQMesh = tree.BillboardMesh;
            SaveMeshToFile(LQMesh, "Assets/" + exportPath + "/Trees/" + TreeName + "/Lod1/Mesh/BillboardMesh.asset");

            AssetDatabase.SaveAssets();
            AssetDatabase.Refresh();

            //Create a gameobject called newlod1
            GameObject newLOD1 = new GameObject("Lod_1");

            //Add the warning message.
            newLOD1.AddComponent<_LushLODTreeWarning>();

            //Add a mesh filter to that game object
            newLOD1.AddComponent<MeshFilter>();

            //Link the mesh filter to the HQ mesh file we saved.
            Mesh readMesh2 = AssetDatabase.LoadAssetAtPath("Assets/" + exportPath + "/Trees/" + TreeName + "/Lod1/Mesh/BillboardMesh.asset", typeof(Mesh)) as Mesh;
            newLOD1.GetComponent<MeshFilter>().sharedMesh = readMesh2;

            //Add mesh renderer to the lod1 gameobject
            newLOD1.AddComponent<MeshRenderer>();

            //Add the material to the mesh renderer.
            newLOD1.GetComponent<MeshRenderer>().sharedMaterial = Save_Material_Transitioning;
            newLOD1.GetComponent<MeshRenderer>().receiveShadows = false;
            newLOD1.GetComponent<MeshRenderer>().shadowCastingMode = UnityEngine.Rendering.ShadowCastingMode.TwoSided;

            //Create the LushLOD Tree:
            GameObject NewLushLODTree = new GameObject(TreeName);

            //Must set the transform parents BEFORE we save the prefab, or else it gives errors:
            newLOD0.transform.parent = NewLushLODTree.transform;
            newLOD1.transform.parent = NewLushLODTree.transform;

            newLOD1.transform.localPosition = tree.Lod1_LocalPosition;

            //Create prefab:
            newLOD0.SetActive(true);
            newLOD1.SetActive(true);
            NewLushLODTree.SetActive(true);

            //Add a mesh collider.
            newLOD0.AddComponent<MeshCollider>();
            if (PhysicMat != null) newLOD0.GetComponent<MeshCollider>().material = PhysicMat;

            //Save and also load the prefab from the disk:
            NewLushLODTree = PrefabUtility.CreatePrefab("Assets/" + exportPath + "/" + TreeName + ".prefab", NewLushLODTree);

            //Add the LushLODTree script:
            //NOTE: This must be done AFTER we save the prefab, or else it gives weird "!go->IsActive()" error.
            NewLushLODTree.AddComponent<_LushLODTree>();
            _LushLODTree ThisNewTree = NewLushLODTree.GetComponent<_LushLODTree>();

            //Save some variables into the prefab. Note that some more variables will be added later by _LushLODTreeConverterEditor2.cs.
            ThisNewTree.UsingFastBarkShader = tree.UsingFastBarkShader;
            ThisNewTree.UsingFastLeavesShader = tree.UsingFastLeavesShader;
            ThisNewTree.ShadowReceiveSetting = tree.ShadowReceiveSetting;
            ThisNewTree.RealTimeShadowSetting = tree.RealTimeShadowSetting;
            ThisNewTree.Original_ShadowStrength = tree.Original_ShadowStrength;
            ThisNewTree.Material_NotInstance_FullyOpaque = Save_Material_NotInstance_FullyOpaque;
            ThisNewTree.Material_Instance_Transitioning = Save_Material_Transitioning;
            ThisNewTree.maincolor_HQTrees_ORIGINALS = tree.maincolor_HQTrees_ORIGINALS;
            ThisNewTree.AverageColor_Bark = tree.AverageColor_Bark;
            ThisNewTree.AverageColor_Leaves = tree.AverageColor_Leaves;
            ThisNewTree.lodDistance = tree.lodDistance;
            ThisNewTree.lod1Rend = ThisNewTree.transform.Find("Lod_1").gameObject.GetComponent<MeshRenderer>();
            ThisNewTree.lod0Rend = ThisNewTree.transform.Find("Lod_0").gameObject.GetComponent<MeshRenderer>();
            ThisNewTree.Material_File_ID = UniqueExportNumber;
            ThisNewTree.Original_TreeName = TreeName;
            ThisNewTree.Original_UniqueID = new
            {
                TreeName,
                HQMesh.vertexCount,
                diffuse_path
            }.GetHashCode().ToString();
            ThisNewTree.LushLODTree_VersionNumber = "0.8";
            ThisNewTree.TreeCreationFinished = true;

            //Note: the prefab is already saved, the above lines of code were modifying the prefab on the disk!

            //Pass some variables to _LushLODTreeConverterEditor2.cs:
            tree.TreeDataPath = "Assets/" + exportPath + "/Trees/" + TreeName + "/Lod0/Mesh/TreeData.asset";
            tree.HQMesh = readMesh;
            tree.OptimizedLeafMaterial = LeavesMat;
            tree.OptimizedBarkMaterial = BarkMat;

        }

        AssetDatabase.SaveAssets();
        AssetDatabase.Refresh();

        EditorUtility.ClearProgressBar();

#endif

        CONVERSION_FINISHED = true; //<-- The _LushLODTreesConverterEditor.cs script will see this and finish up.

        yield return null;
    }

    /// <summary>
    /// This function saves a mesh to the hard drive.
    /// </summary>
    /// <param name="theMesh">The mesh to save</param>
    /// <param name="toPath">The path to save it at. Must be relative to the Asset folder.</param>
    public void SaveMeshToFile(Mesh theMesh, string toPath)
    {
        if (theMesh == null || ReferenceEquals(theMesh, null) || theMesh.Equals(null))
        {
            UnityEngine.Debug.LogError("No mesh to save.");
            return;
        }
        Mesh asset = Instantiate(theMesh);
        AssetDatabase.CreateAsset(asset, toPath);
        AssetDatabase.SaveAssets();
    }

    Bounds GetBounds(GameObject obj)
    {
        bool newBounds = true;
        Bounds bounds = new Bounds();

        Renderer[] renderers = obj.GetComponentsInChildren<Renderer>();

        foreach (Renderer renderer in renderers)
        {
            if (newBounds)
            {
                newBounds = false;
                bounds = renderer.bounds;
            }
            else
                bounds.Encapsulate(renderer.bounds);
        }

        return bounds;
    }

    /// <summary>
    /// This function will loop through all pixels in the supplied texture, and calculate their average color.
    /// </summary>
    /// <param name="ScreenShotPic">The picture to find the average color of</param>
    /// <returns>Returns the average color.</returns>
    Color GetAverageColor(Texture2D ScreenShotPic)
    {
        Color background = BillboardCamera.backgroundColor;
        Vector3 totalColors = new Vector3();        
        Color[] GetPixs = ScreenShotPic.GetPixels();
        int totalCount = 0;      
        for (int y = 0; y < ScreenShotPic.height; y++)
            for (int x = 0; x < ScreenShotPic.width; x++)
            {

                int PixLoc = 0;
                PixLoc = (y * ScreenShotPic.width + x);
                Color col = GetPixs[PixLoc];

                if (!(col.r == background.r && col.g == background.g && col.b == background.b))
                {

                    totalColors.x += col.r;
                    totalColors.y += col.g;
                    totalColors.z += col.b;

                    totalCount += 1;
                }
            }

        Color c = Color.black;
        c.r = totalColors.x / totalCount;
        c.g = totalColors.y / totalCount;
        c.b = totalColors.z / totalCount;
        return c;
    }

    /// <summary>
    /// This function processes the screenshot that was taken.
    /// </summary>
    /// <param name="ScreenShotPic">The picture that holds the screenshot that was already taken.</param>
    /// <param name="tex">The atlas texture</param>
    /// <param name="tileWidth">The size in width</param>
    /// <param name="tileHeight">The size in height</param>
    /// <param name="PlaneNumber">A number designating the billboard plane that this texture will apply to. This is written into the alpha channel, and read by the shader.</param>
    /// <returns></returns>
    System.Collections.IEnumerator Screenshot(Texture2D ScreenShotPic, Texture2D ScreenShotPic_PaddedAlpha, Texture2D tex, int tileWidth, int tileHeight, int PlaneNumber)
    {

        int destX = tex_atlas_currentPosition.x;
        int destY = tex_atlas_currentPosition.y;

        Color background = BillboardCamera.backgroundColor;
        float alpha = 0.0f;
        float opaque = 1.0f;

        switch (PlaneNumber)
        {
            case 1:
                alpha = 0.01f; //<-- tells the shader that this is the FORWARD plane
                opaque = 0.98f; //<-- tells the shader that this is the FORWARD plane
                break;
            case 2:
                alpha = 0.02f; //<-- tells the shader that this is the RIGHT plane
                opaque = 0.99f; //<-- tells the shader that this is the RIGHT plane
                break;
            case 3:
                alpha = 0.03f; //<-- tells the shader that this is the TOP plane
                opaque = 1f; //<-- tells the shader that this is the TOP plane
                break;
        }

        for (int y = 0; y < tileHeight; y++)
            for (int x = 0; x < tileWidth; x++)
            {
                Color c = ScreenShotPic.GetPixel(x, y); //<-- gets the color from the original screenshot, without the alpha padding (no blur).
                Color c_padded = ScreenShotPic_PaddedAlpha.GetPixel(x, y); //<-- with alpha padding (the blur).
                if (c.r == background.r && c.g == background.g && c.b == background.b)
                {
                    //Draw the padded color, but use the fully transparent alpha value that holds the appropriate PlaneNumber:
                    c_padded.a = alpha;
                    tex.SetPixel(x + destX, y + destY, c_padded);
                }
                else
                {
                    //Draw the padded color, but use the fully opaque alpha value that holds the appropriate PlaneNumber:
                    c_padded.a = opaque;
                    tex.SetPixel(x + destX, y + destY, c_padded);
                }
            }

        tex.Apply();

        // Get next position to draw to in the atlas
        tex_atlas_currentPosition = NextatlasPosition(tex_atlas, tex_atlas_currentPosition, TX_size);

        yield break;

    }

    /// <summary>
    /// This function creates the shadow maps.
    /// </summary>
    /// <param name="ScreenShotPic">The texture containing the screenshot that was already taken.</param>
    /// <param name="GetPixs">The pixels that were already read, and already partially processed.</param>
    /// <param name="SetPixs">This is an OUT variable... the results from this function will be sent out through here.</param>
    /// <param name="background">The background color of the billboard texture, used to determine if a pixel is transparent.</param>
    /// <param name="ShadowRatio">This float helps normalize the shadows so that thin trees have just as much shadow as thick round trees.</param>
    /// <param name="SkipBackgroundPixels">A bool that we use to tell this function to skip background pixels.</param>
    public void ShadowTextureLoop(Texture2D ScreenShotPic, Color[] GetPixs, out Color[] SetPixs, Color background, float ShadowRatio, bool SkipBackgroundPixels = false)
    {
        SetPixs = new Color[GetPixs.Length];
        for (int y = 0; y < ScreenShotPic.height; y++)
            for (int x = 0; x < ScreenShotPic.width; x++)
            {

                int PixLoc = 0;
                PixLoc = (y * ScreenShotPic.width + x);
                Color col = GetPixs[PixLoc];

                if (SkipBackgroundPixels)
                {
                    if (!(col.r == background.r && col.g == background.g && col.b == background.b))
                    {
                        SetPixs[PixLoc] = background;
                        SetPixs[PixLoc].a = 0f; //<-- sets alpha to zero so that we can remember which pixels were transparent.
                        continue; //<-- skip this pixel because we are skipping background pixels.
                    }
                }

                float Red_Left = 0f;
                float Green_Up = 0f;
                float Blue_Right = 0f;

                //*****************************************************************
                //STEP 1: FIND HOW MANY LEAF PIXELS ARE TO THE LEFT OF THIS PIXEL.
                //*****************************************************************

                int LOOP_X = x - 1;
                int LOOP_Y = y + 1;
                int LEFT_LOOP_LeafyPixels1 = 0;

                //Look at a 45 degree angle towards upper left direction:
                while (LOOP_X >= 0 && LOOP_Y < ScreenShotPic.height) //<-- looks in an upper left direction
                {
                    PixLoc = (LOOP_Y * ScreenShotPic.width + LOOP_X);
                    Color c = GetPixs[PixLoc];
                    if (!(c.r == background.r && c.g == background.g && c.b == background.b))
                        LEFT_LOOP_LeafyPixels1 += 1; //<-- found a leafy pixel that would block the sunlight in this direction.

                    //Continue looking at a 45 degree angle: upper left direction.
                    LOOP_X -= 1;
                    LOOP_Y += 1;
                }

                LOOP_X = x - 1;
                LOOP_Y = y;
                int LEFT_LOOP_LeafyPixels2 = 0;

                //Look straight to the left
                while (LOOP_X >= 0) //<-- looks to the left
                {
                    PixLoc = (LOOP_Y * ScreenShotPic.width + LOOP_X);
                    Color c = GetPixs[PixLoc];
                    if (!(c.r == background.r && c.g == background.g && c.b == background.b))
                        LEFT_LOOP_LeafyPixels2 += 1; //<-- found a leafy pixel that would block the sunlight in this direction.

                    //Continue looking straight to the left
                    LOOP_X -= 1;
                }

                LOOP_X = x - 1;
                LOOP_Y = y - 1;
                int LEFT_LOOP_LeafyPixels3 = 0;

                //Look at a 45 degree angle towards lower left direction:
                while (LOOP_X >= 0 && LOOP_Y >= 0) //<-- looks in an lower left direction
                {
                    PixLoc = (LOOP_Y * ScreenShotPic.width + LOOP_X);
                    Color c = GetPixs[PixLoc];
                    if (!(c.r == background.r && c.g == background.g && c.b == background.b))
                        LEFT_LOOP_LeafyPixels3 += 1; //<-- found a leafy pixel that would block the sunlight in this direction.

                    //Continue looking at a 45 degree angle: lower left direction.
                    LOOP_X -= 1;
                    LOOP_Y -= 1;
                }

                float Final_LeafyPixels_Left = (LEFT_LOOP_LeafyPixels1 + LEFT_LOOP_LeafyPixels2 + LEFT_LOOP_LeafyPixels3) / 3;
                Final_LeafyPixels_Left = Final_LeafyPixels_Left / TX_size; //<-- remaps it to a range from 0 to 1. This will be the RED color.
                Red_Left = Final_LeafyPixels_Left;


                //*****************************************************************
                //STEP 2: FIND HOW MANY LEAF PIXELS ARE TO THE TOP OF THIS PIXEL.
                //*****************************************************************

                //Look at a 45 degree angle towards upper left direction:
                int TOP_LOOP_LeafyPixels1 = LEFT_LOOP_LeafyPixels1;

                LOOP_X = x;
                LOOP_Y = y + 1;
                int TOP_LOOP_LeafyPixels2 = 0;

                //Look straight to the top
                while (LOOP_Y < ScreenShotPic.height) //<-- looks to the top
                {
                    PixLoc = (LOOP_Y * ScreenShotPic.width + LOOP_X);
                    Color c = GetPixs[PixLoc];
                    if (!(c.r == background.r && c.g == background.g && c.b == background.b))
                        TOP_LOOP_LeafyPixels2 += 1; //<-- found a leafy pixel that would block the sunlight in this direction.

                    //Continue looking straight to the top
                    LOOP_Y += 1;
                }

                LOOP_X = x + 1;
                LOOP_Y = y + 1;
                int TOP_LOOP_LeafyPixels3 = 0;

                //Look at a 45 degree angle towards upper right direction:
                while (LOOP_X < ScreenShotPic.width && LOOP_Y < ScreenShotPic.height) //<-- looks in an upper right direction
                {
                    PixLoc = (LOOP_Y * ScreenShotPic.width + LOOP_X);
                    Color c = GetPixs[PixLoc];
                    if (!(c.r == background.r && c.g == background.g && c.b == background.b))
                        TOP_LOOP_LeafyPixels3 += 1; //<-- found a leafy pixel that would block the sunlight in this direction.

                    //Continue looking at a 45 degree angle: upper right direction.
                    LOOP_X += 1;
                    LOOP_Y += 1;
                }

                float Final_LeafyPixels_Top = (TOP_LOOP_LeafyPixels1 + TOP_LOOP_LeafyPixels2 + TOP_LOOP_LeafyPixels3) / 3;
                Final_LeafyPixels_Top = Final_LeafyPixels_Top / TX_size; //<-- remaps it to a range from 0 to 1. This will be the RED color.
                Green_Up = Final_LeafyPixels_Top;

                //*****************************************************************
                //STEP 3: FIND HOW MANY LEAF PIXELS ARE TO THE RIGHT OF THIS PIXEL.
                //*****************************************************************

                LOOP_X = x + 1;
                LOOP_Y = y + 1;
                int RIGHT_LOOP_LeafyPixels1 = 0;

                //Look at a 45 degree angle towards upper right direction:
                while (LOOP_X < ScreenShotPic.width && LOOP_Y < ScreenShotPic.height) //<-- looks in an upper right direction
                {

                    PixLoc = (LOOP_Y * ScreenShotPic.width + LOOP_X);
                    Color c = GetPixs[PixLoc];
                    if (!(c.r == background.r && c.g == background.g && c.b == background.b))
                        RIGHT_LOOP_LeafyPixels1 += 1; //<-- found a leafy pixel that would block the sunlight in this direction.

                    //Continue looking at a 45 degree angle: upper right direction.
                    LOOP_X += 1;
                    LOOP_Y += 1;
                }

                LOOP_X = x + 1;
                LOOP_Y = y;
                int RIGHT_LOOP_LeafyPixels2 = 0;

                //Look straight to the Right
                while (LOOP_X < ScreenShotPic.width) //<-- looks to the Right
                {
                    PixLoc = (LOOP_Y * ScreenShotPic.width + LOOP_X);
                    Color c = GetPixs[PixLoc];
                    if (!(c.r == background.r && c.g == background.g && c.b == background.b))
                        RIGHT_LOOP_LeafyPixels2 += 1; //<-- found a leafy pixel that would block the sunlight in this direction.

                    //Continue looking straight to the Right
                    LOOP_X += 1;
                }

                LOOP_X = x + 1;
                LOOP_Y = y - 1;
                int RIGHT_LOOP_LeafyPixels3 = 0;

                //Look at a 45 degree angle towards lower right direction:
                while (LOOP_X < ScreenShotPic.width && LOOP_Y >= 0) //<-- looks in an lower right direction
                {
                    PixLoc = (LOOP_Y * ScreenShotPic.width + LOOP_X);
                    Color c = GetPixs[PixLoc];
                    if (!(c.r == background.r && c.g == background.g && c.b == background.b))
                        RIGHT_LOOP_LeafyPixels3 += 1; //<-- found a leafy pixel that would block the sunlight in this direction.

                    //Continue looking at a 45 degree angle: lower right direction.
                    LOOP_X += 1;
                    LOOP_Y -= 1;
                }

                float Final_LeafyPixels_Right = (RIGHT_LOOP_LeafyPixels1 + RIGHT_LOOP_LeafyPixels2 + RIGHT_LOOP_LeafyPixels3) / 3;
                Final_LeafyPixels_Right = Final_LeafyPixels_Right / TX_size; //<-- remaps it to a range from 0 to 1. This will be the RED color.
                Blue_Right = Final_LeafyPixels_Right;

                //*****************************************************************
                //STEP 4: Create this Shadow Texture color.
                //*****************************************************************

                Color newShadowTexColor;
                PixLoc = (y * ScreenShotPic.width + x);

                if (!(col.r == background.r && col.g == background.g && col.b == background.b))
                    newShadowTexColor = new Color(Red_Left, Green_Up, Blue_Right, 0f); //<-- sets alpha to zero so that we can remember which pixels were transparent.
                else
                    newShadowTexColor = new Color(Red_Left, Green_Up, Blue_Right, 1f); //<-- sets alpha to one so that we remember that this was not a background pixel.

                if (ShadowRatio > 0f)
                {
                    SetPixs[PixLoc] = newShadowTexColor / ShadowRatio; //<-- The shadow ratio is a number calculator earlier, which intensifies the shadows.
                }
                else
                {
                    SetPixs[PixLoc] = newShadowTexColor;
                }

            }
    }

    /// <summary>
    /// This function creates a color map for shadows that the tree will cast upon its own self. Each pixel in this texture will have three
    /// color values used (red, green and blue), which will record how much light can probably reach that pixel from each of three different
    /// directions (left, top and right respectively). For the red color, it checks for obstruction of light to the left of the pixel, looking
    /// at a 45 degree angle upwards, and to the left, and at a 45 degree angle downwards -- to the left. It then picks whichever of those three
    /// directions to the left were the LEAST obstructed by leaves, and uses that amount to determine how much sunlight can reach the subject pixel
    /// from the left... and records that amount into the RED value of the pixel. It then does the same thing for GREEN (up) and BLUE (right).
    /// 
    /// Two of these shadow map textures will be created for the HQ tree... one from the FORWARD axis and one for the RIGHT axis. Using these two
    /// maps, we should be able to determine how much light can reach the pixel from any direction.
    /// 
    /// IF I decide to, I can set the FORWARD image's GREEN color to look up, and the RIGHT axis image's GREEN color to look down, and then I would
    /// have a complete map that would include every direction, even light coming from the bottom of the tree.
    /// </summary>
    /// <param name="ScreenShotPic">The screenshot that was taken of the tree WITH the bark visible.</param>
    /// <param name="ScreenShotPic_NoBark">The screenshot that was taken of the tree without bark visible. Used to avoid letting the bark cast shadows on the leaves.</param>
    /// <param name="ShadowTex">The texture to render to</param>
    /// <returns></returns>
    System.Collections.IEnumerator ShadowTexture(Texture2D ScreenShotPic, Texture2D ScreenShotPic_NoBark, Texture2D ShadowTex)
    {

        Color background = BillboardCamera.backgroundColor;

        Color[] GetPixs_NoBark = ScreenShotPic_NoBark.GetPixels();
        Color[] SetPixs_NoBark = new Color[GetPixs_NoBark.Length];

        ShadowTextureLoop(ScreenShotPic_NoBark, GetPixs_NoBark, out SetPixs_NoBark, background, -1f, true);

        decimal TotalShadowValue = 0m;
        int TotalPixelCount = 0;
        foreach (Color color in SetPixs_NoBark)
        {
            if (color.a == 0f) continue; //<-- skip background pixels.
            TotalShadowValue += (decimal)(color.r + color.g + color.b);
            TotalPixelCount += 1;
        }

        //Now calculate how much shadow is the average shadow value on every pixel that isn't
        //a background pixel:

        decimal AverageShadowValue = TotalShadowValue / TotalPixelCount;
        float AverageShadowRatio = (float)(AverageShadowValue / 0.3m); //<-- 0.3 is the average amount of shadow that we want.
        if (AverageShadowRatio >= 1f) AverageShadowRatio = -1; //<-- Negative 1 turns it off, and it will not be used.

        Color[] GetPixs = ScreenShotPic.GetPixels();
        Color[] SetPixs = new Color[GetPixs.Length];

        ShadowTextureLoop(ScreenShotPic, GetPixs, out SetPixs, background, AverageShadowRatio);

        ShadowTex.SetPixels(SetPixs);
        ShadowTex.Apply();
        yield break;

    }

    //Code mostly copied from Unity's BlurOptimized.cs
    void DoAlphaPadding(int downsample, float blurSize, int blurIterations, RenderTexture source, RenderTexture destination)
    {
            
        Material blurMaterial = new Material(Shader.Find("Hidden/LushLODTree/MobileBlur"));

        float widthMod = 1.0f / (1.0f * (1 << downsample));

        blurMaterial.SetVector("_Parameter", new Vector4(blurSize * widthMod, -blurSize * widthMod, 0.0f, 0.0f));
        source.filterMode = FilterMode.Bilinear;

        int rtW = source.width >> downsample;
        int rtH = source.height >> downsample;

        // downsample
        RenderTexture rt = RenderTexture.GetTemporary(rtW, rtH, 0, source.format);

        rt.filterMode = FilterMode.Bilinear;
        Graphics.Blit(source, rt, blurMaterial, 0);

        for (int i = 0; i < blurIterations; i++)
        {
            float iterationOffs = (i * 1.0f);
            blurMaterial.SetVector("_Parameter", new Vector4(blurSize * widthMod + iterationOffs, -blurSize * widthMod - iterationOffs, 0.0f, 0.0f));

            // vertical blur
            RenderTexture rt2 = RenderTexture.GetTemporary(rtW, rtH, 0, source.format);
            rt2.filterMode = FilterMode.Bilinear;
            Graphics.Blit(rt, rt2, blurMaterial, 1);
            RenderTexture.ReleaseTemporary(rt);
            rt = rt2;

            // horizontal blur
            rt2 = RenderTexture.GetTemporary(rtW, rtH, 0, source.format);
            rt2.filterMode = FilterMode.Bilinear;
            Graphics.Blit(rt, rt2, blurMaterial, 2);
            RenderTexture.ReleaseTemporary(rt);
            rt = rt2;
        }

        Graphics.Blit(rt, destination);

        RenderTexture.ReleaseTemporary(rt);
    }

    /// <summary>
    /// This function will check if there are duplicate verticies in the mesh.
    /// Returns true if the mesh contains duplicate verts.
    /// </summary>
    /// <param name="mesh">The mesh to perform work on.</param>
    /// <param name="minDist">The minimum distance between verticies.</param>
    public bool CheckIfMeshContainsDuplicateVerts(Mesh mesh, float minDist = 0.001f)
    {
        Vector3[] verts = mesh.vertices;
        List<Vector3> verts_new = new List<Vector3>();
        for (int z = 0; z < verts.Length; z++)
        {
            Vector3 vert = verts[z];
            bool doesExist = false;
            foreach (Vector3 checkvert in verts_new)
            {
                float checkDist = Vector3.Distance(vert, checkvert);
                if (checkDist < minDist)
                {
                    doesExist = true;
                    break;
                }
            }

            if (doesExist == false)
            {
                verts_new.Add(vert);
            }
        }

        //This will return true only if there are ~25% duplicate verticies or more...
        return (verts_new.Count < (mesh.vertices.Length * 0.75));
    }

    /// <summary>
    /// This function will attempt to merge duplicate verticies in the tree.
    /// </summary>
    /// <param name="mesh">The mesh to perform work on.</param>
    /// <param name="minDist">The minimum distance between verticies.</param>
    public void MergeDuplicateVerts(Mesh mesh, float minDist = 0.001f)
    {
        bool uv_exists = (mesh.uv.Length > 0);
        bool uv2_exists = (mesh.uv2.Length > 0);
        bool uv3_exists = (mesh.uv3.Length > 0);
        bool uv4_exists = (mesh.uv4.Length > 0);

        bool colors_exists = (mesh.colors.Length > 0);
        bool tangents_exists = (mesh.tangents.Length > 0);
        bool boneweights_exists = (mesh.boneWeights.Length > 0);
        Vector3[] verts = mesh.vertices;
        Matrix4x4[] bindposes = mesh.bindposes;
        int[] submeshes = new int[mesh.subMeshCount];
        for (int z = 0; z < mesh.subMeshCount; z++)
        {
            submeshes[z] = mesh.GetTriangles(z).Length;
        }
        List<Vector3> verts_new = new List<Vector3>();
        List<Vector2> uv_new = new List<Vector2>();
        List<Vector2> uv2_new = new List<Vector2>();
        List<Vector2> uv3_new = new List<Vector2>();
        List<Vector2> uv4_new = new List<Vector2>();
        List<Color> colors_new = new List<Color>();
        List<Vector3> normals_new = new List<Vector3>();
        List<Vector4> tangents_new = new List<Vector4>();
        List<BoneWeight> boneweights_new = new List<BoneWeight>();

        for (int z = 0; z < verts.Length; z++)
        {
            Vector3 vert = verts[z];
            bool doesExist = false;
            foreach (Vector3 checkvert in verts_new)
            {
                float checkDist = Vector3.Distance(vert, checkvert);
                if (checkDist <= minDist)
                {
                    doesExist = true;
                    break;
                }
            }

            if (doesExist == false)
            {
                verts_new.Add(vert);
                if (uv_exists)
                {
                    uv_new.Add(mesh.uv[z]);
                }
                if (uv2_exists)
                {
                    uv2_new.Add(mesh.uv2[z]);
                }
                if (uv3_exists)
                {
                    uv3_new.Add(mesh.uv3[z]);
                }
                if (uv4_exists)
                {
                    uv4_new.Add(mesh.uv4[z]);
                }
                normals_new.Add(mesh.normals[z]);
                if (colors_exists) { colors_new.Add(mesh.colors[z]); }
                if (tangents_exists) { tangents_new.Add(mesh.tangents[z]); }
                if (boneweights_exists) { boneweights_new.Add(mesh.boneWeights[z]); }
            }
        }
        int[] triangles = mesh.triangles;
        for (int z = 0; z < triangles.Length; z++)
        {
            int x = 0;
            foreach (Vector3 vert in verts_new)
            {
                if (Vector3.Distance(vert, verts[triangles[z]]) <= minDist)
                {
                    triangles[z] = x;
                    break;
                }
                x++;
            }
        }
        mesh.Clear();
        mesh.vertices = verts_new.ToArray();
        mesh.normals = normals_new.ToArray();
        if (uv_exists)
        {
            mesh.uv = uv_new.ToArray();
        }
        if (uv2_exists)
        {
            mesh.uv2 = uv2_new.ToArray();
        }
        if (colors_exists)
        {
            mesh.colors = colors_new.ToArray();
        }
        if (uv3_exists)
        {
            mesh.uv3 = uv3_new.ToArray();
        }
        if (uv4_exists)
        {
            mesh.uv4 = uv4_new.ToArray();
        }
        if (boneweights_exists)
        {
            mesh.boneWeights = boneweights_new.ToArray();
        }
        if (tangents_exists)
        {
            mesh.tangents = tangents_new.ToArray();
        }
        mesh.bindposes = bindposes;
        mesh.subMeshCount = submeshes.Length;
        int count = 0;
        for (int z = 0; z < submeshes.Length; z++)
        {
            List<int> newTriangles = triangles.Skip(count).ToList<int>();
            newTriangles = newTriangles.Take(submeshes[z]).ToList<int>();
            mesh.SetTriangles(newTriangles, z);
            count = count + submeshes[z];
        }
    }

}
#endif
