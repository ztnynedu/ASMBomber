using System.Collections.Generic;
using UnityEngine;
#if UNITY_EDITOR
using UnityEditor;
#endif 

public class _LushLODTreeSceneConverter : MonoBehaviour {
    
    public enum ConversionStages
    {
        NotStarted,
        SelectingTree,
        Finished
    }

    [HideInInspector]
    public ConversionStages ConversionStage = ConversionStages.NotStarted;
    [HideInInspector]
    public Terrain[] AllTerrains;
    [HideInInspector]
    public List<Tree> UniqueTreesFound;
    [HideInInspector]
    public int TreeLoop = 0;
    [HideInInspector]
    public GameObject NewTreesRoot;
    [HideInInspector]
    public int WaitFrame;
    [HideInInspector]
    public bool CreatedManager = false;
    [HideInInspector]
    public bool UseLossyScale = false;

}
#if UNITY_EDITOR
// Custom Editor using SerializedProperties.
// Automatic handling of multi-object editing, undo, and prefab overrides.
[CustomEditor(typeof(_LushLODTreeSceneConverter))]
//[CanEditMultipleObjects]
public class _LushLODTreeSceneConverter_Editor : Editor
{

    void Enable()
    {

    }

    // Custom GUILayout progress bar.
    void ProgressBar(float value, string label)
    {
        // Get a rect for the progress bar using the same margins as a textfield:
        Rect rect = GUILayoutUtility.GetRect(18, 18, "TextField");
        EditorGUI.ProgressBar(rect, value, label);
        EditorGUILayout.Space();
    }


    public override void OnInspectorGUI()
    {

        _LushLODTreeSceneConverter GetTHIS = ((_LushLODTreeSceneConverter)this.target);

        // Update the serializedProperty - always do this in the beginning of OnInspectorGUI.
        serializedObject.Update();

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

        GUIStyle PreviewStyle = new GUIStyle(GUI.skin.label);
        GUIStyle PreviewLabel = new GUIStyle(GUI.skin.label);

        GUIStyle RegularStyleColorUSEME = new GUIStyle(GUI.skin.label);
        GUIStyle RegularStyleBox = new GUIStyle(GUI.skin.box);

        RegularStyleBox.normal.background = RegularStyleColorUSEME.normal.background;
        RegularStyleBox.normal.textColor = RegularStyleColorUSEME.normal.textColor;
        RegularStyleBox.alignment = TextAnchor.UpperLeft;

        PreviewStyle.alignment = TextAnchor.MiddleCenter;
        PreviewLabel.alignment = TextAnchor.MiddleCenter;
        
        Redstyle.normal.textColor = Color.red;
        BoldRedstyle.normal.textColor = Color.red;
        BoldRedstyle.fontStyle = FontStyle.Bold;
        BoldRedstyleButton.normal.textColor = Color.red;
        BoldRedstyleButton.fontStyle = FontStyle.Bold;

        Orangestyle.normal.textColor = new Color(1f, 0.6f, 0.2f);
        BoldOrangestyle.normal.textColor = new Color(1f, 0.6f, 0.2f);
        BoldOrangestyle.fontStyle = FontStyle.Bold;
        BoldOrangestyleButton.normal.textColor = new Color(1f, 0.6f, 0.2f);
        BoldOrangestyleButton.fontStyle = FontStyle.Bold;

        BoldStyle.fontStyle = FontStyle.Bold;
        Greenstyle.normal.textColor = new Color(0f, 0.4f, 0f);
        Greenstyle.fontStyle = FontStyle.Bold;
        style.fontStyle = FontStyle.Bold;

        if (Application.isPlaying == true)
        {
            GUILayout.Box("Please exit play mode to do a scene conversion", Redstyle);
            return;
        }

        switch (GetTHIS.ConversionStage)
        {
            case _LushLODTreeSceneConverter.ConversionStages.NotStarted:

                GUILayout.Box("Use the button below to begin converting the current scene.", RegularStyleBox);

                if (GUILayout.Button("Begin Converting Scene", style))
                {

                    if (UnityEditor.SceneManagement.EditorSceneManager.loadedSceneCount != 1)
                    {
                        EditorUtility.DisplayDialog("Unsupported", "You currently have more or less than exactly 1 scene open. Please ensure that you have exactly one scene open before you begin a scene conversion.", "Okay");
                        return;
                    }

                    if (UnityEditor.SceneManagement.EditorSceneManager.GetActiveScene().isDirty || UnityEditor.SceneManagement.EditorSceneManager.GetActiveScene().path == "")
                    {
                        EditorUtility.DisplayDialog("Unsaved Scenes", "Your currently active scene is unsaved. Please save your scene, and make a backup before you begin a scene conversion.", "Okay");
                        return;
                    }

                    if (!EditorUtility.DisplayDialog("Backup Recommended", "This script will convert all the Unity Trees in your scene into LushLOD Trees. It is highly recommended that you create a backup copy of your scene first. There is NO UNDO for this process.", "Continue -- I made a backup!", "Cancel"))
                    {
                        // Apply changes to the serializedProperty - always do this in the end of OnInspectorGUI.
                        serializedObject.ApplyModifiedProperties();
                        return;
                    }

                    GetTHIS.WaitFrame = 0;
                    GetTHIS.TreeLoop = 0;
                    GetTHIS.CreatedManager = false;
                    GetTHIS.UseLossyScale = false;

                    GetTHIS.AllTerrains = GameObject.FindObjectsOfType<Terrain>();

                    //Find all unique trees in their entire scene.

                    Tree[] TempTrees = GameObject.FindObjectsOfType<Tree>();
                    GetTHIS.UniqueTreesFound = new List<Tree>();

                    foreach (Tree tree in TempTrees)
                    {
                        bool FoundIt = false;

                        if (tree.data == null) continue; //<-- it's probably a LushLOD Tree.

                        foreach (Tree tree2 in GetTHIS.UniqueTreesFound)
                        {
                            if (tree.data == tree2.data)
                            {
                                FoundIt = true;
                            }
                        }
                        if (FoundIt == false)
                        {
                            GetTHIS.UniqueTreesFound.Add(tree);

                            //Let's check this tree for possible screwed up scaling (basically, if its parent is scaled, then it has screwd up scaling):

                            if (tree.transform.parent != null)
                            {
                                if (tree.transform.parent.lossyScale != Vector3.one)
                                {
                                    GetTHIS.UseLossyScale = true;
                                }
                            }

                        }
                    }

                    foreach (Terrain terr in GetTHIS.AllTerrains)
                    {

                        if (terr.terrainData.treeInstanceCount == 0) continue; //<-- this terrain has no trees, skip it.

                        foreach (TreePrototype treeproto in terr.terrainData.treePrototypes)
                        {
                            Tree tree = treeproto.prefab.GetComponent<Tree>();

                            if (tree == null ||
                                ReferenceEquals(tree, null) == true)
                            {
                                //Couldn't find a TREE component on this tree. What is this?
                                EditorUtility.DisplayDialog("Whoops", "We found a tree named \"" + treeproto.prefab.gameObject.name + "\" on a terrain named \"" + terr.gameObject.name + "\" which is not a standard Unity Tree (it has no \"Tree\" Component). Unfortunantly, this scene converter can only convert standard Unity Trees.", "Okay");
                                {
                                    // Apply changes to the serializedProperty - always do this in the end of OnInspectorGUI.
                                    serializedObject.ApplyModifiedProperties();
                                    return;
                                }
                            }

                            bool FoundIt = false;
                            foreach (Tree tree2 in GetTHIS.UniqueTreesFound)
                            {
                                if (tree.data == tree2.data)
                                {
                                    FoundIt = true;
                                }
                            }
                            if (FoundIt == false)
                            {
                                GetTHIS.UniqueTreesFound.Add(tree);
                            }
                        }
                    }

                    if (GetTHIS.UniqueTreesFound.Count > 0)
                    {
                        if (!EditorUtility.DisplayDialog("Scene Conversion", "Before you run the scene converter, you first need to run the TREE converter. During the scene conversion, you will be asked to select the LushLOD Tree prefab files that were created by the tree converter. We found a total of " + GetTHIS.UniqueTreesFound.Count + " unique types of trees in your scene, and you should convert all " + GetTHIS.UniqueTreesFound.Count + " of them into LushLOD Trees before you continue with this scene converter. Please see the Quick Start guide for instructions on how to use the tree converter.", "Continue -- I already ran the tree converter!", "Cancel"))
                        {
                            // Apply changes to the serializedProperty - always do this in the end of OnInspectorGUI.
                            serializedObject.ApplyModifiedProperties();
                            return;
                        }
                        EditorUtility.DisplayDialog("Scene Conversion", "Great! Now let's begin.", "Okay");

                        EditorUtility.DisplayDialog("Scene Conversion", "We found a total of " + GetTHIS.UniqueTreesFound.Count + " unique types of trees in your scene. We will now loop through each unique tree type, and you will be asked to select the LushLOD prefab file for each. To help you identify each tree, we will show you a preview image of each tree we found in your scene, along with its name.", "Okay");

                        //Let's set up our manager and trees root as needed.
                        if (_LushLODTree.TreesManager == null)
                        {
                            //The manager doesn't exist, so create it.
                            _LushLODTree.CreateTreeManager(false, false, null);

                            GetTHIS.CreatedManager = true;

                            //Create a TreesRoot if we don't have one yet.
                            if (GetTHIS.NewTreesRoot == null)
                            {
                                GetTHIS.NewTreesRoot = new GameObject("TreesRoot");
                            }

                            //Setup the manager.
                            _LushLODTree.TreesManager.TreesRoot = GetTHIS.NewTreesRoot;
                            _LushLODTree.TreesManager.RootAllTrees(false);
                        }
                        else if (_LushLODTree.TreesManager.TreesRoot == null)
                        {
                            //The manger exists, but doesn't have a TreesRoot yet.

                            //Setup our TreesRoot if we don't already have it (the manager doesn't have it).
                            if (GetTHIS.NewTreesRoot == null)
                            {
                                GetTHIS.NewTreesRoot = new GameObject("TreesRoot");
                            }
                            _LushLODTree.TreesManager.TreesRoot = GetTHIS.NewTreesRoot;
                            _LushLODTree.TreesManager.RootAllTrees(false);
                        }
                        else
                        {
                            //The manager exists, and it has a TreesRoot already set up, so use it:
                            GetTHIS.NewTreesRoot = _LushLODTree.TreesManager.TreesRoot;
                            _LushLODTree.TreesManager.RootAllTrees(false);
                        }

                        GetTHIS.ConversionStage = _LushLODTreeSceneConverter.ConversionStages.SelectingTree;
                    }
                    else
                    {
                        EditorUtility.DisplayDialog("Scene Conversion", "We couldn't find any standard Unity Trees in your scene. If you believe this message is an error, please let me know by posting a support request on the support website.", "Okay");
                    }
                }

                break;
            case _LushLODTreeSceneConverter.ConversionStages.SelectingTree:

                if (GetTHIS.TreeLoop >= GetTHIS.UniqueTreesFound.Count)
                {
                    //We're done with the conversion.
                    EditorUtility.DisplayDialog("Scene Conversion", "The LushLOD Trees have been spawned on top of the original Unity Trees in your scene. The LushLOD Trees are in your hierarchy under the \"" + GetTHIS.NewTreesRoot.gameObject.name + "\" GameObject. Feel free to take a look. If you are satisfied with the conversion, you can click the \"Delete Unity Trees\" button to delete the old trees (and keep just the LushLOD Trees). Otherwise, you can simply delete the \"" + GetTHIS.NewTreesRoot.gameObject.name + "\" GameObject to delete all the trees we just spawned, and your scene will be back to the way it was before.", "Okay");
                    EditorUtility.DisplayDialog("Scene Conversion", "Don't forget to click \"Delete Unity Trees\" if you are satisfied with the conversion. :)", "Okay");
                    GetTHIS.WaitFrame = 0;
                    GetTHIS.ConversionStage = _LushLODTreeSceneConverter.ConversionStages.Finished;

                    Repaint();

                    _LushLODTree.TreesManager.RootAllTrees(false);
                    _LushLODTree.TreesManager.UpdateTreesPreview(null, false, false);
                    _LushLODTree.TreesManager.ReCalculateParents(false, false);

                    // Apply changes to the serializedProperty - always do this in the end of OnInspectorGUI.
                    serializedObject.ApplyModifiedProperties();
                    return;
                }

                Tree ThisTree = GetTHIS.UniqueTreesFound[GetTHIS.TreeLoop];

                string prefabPath2 = AssetDatabase.GetAssetPath(ThisTree.data);
                UnityEngine.Object newPrefab2 = AssetDatabase.LoadAssetAtPath(prefabPath2.Replace(Application.dataPath, "Assets"), (typeof(UnityEngine.Object))) as UnityEngine.Object;

                Texture2D preview = AssetPreview.GetAssetPreview(newPrefab2);

                GUILayout.Box("Current Tree:", RegularStyleBox);
                GUILayout.Label(preview, PreviewStyle);
                GUILayout.Label(ThisTree.name, PreviewLabel);
                GUILayout.Space(10f);
                ProgressBar(GetTHIS.TreeLoop / (float)GetTHIS.UniqueTreesFound.Count, "Tree " + (GetTHIS.TreeLoop + 1) + " of " + GetTHIS.UniqueTreesFound.Count);

                this.Repaint();

                if (GetTHIS.WaitFrame > 1)
                {
                    tryagain1:

                    EditorUtility.DisplayDialog("Selection Info", "Next, select the LushLOD Tree prefab file for the " + ThisTree.name + " tree. You should see a small preview of this tree in the Inspector, which may help you to identify which tree this is, so that you can select the correct prefab file. LushLOD Tree prefab files are usually saved in the Assets/LushLOD Trees/Output folder.", "Open File Select Dialog");

                    string prefabPath = EditorUtility.OpenFilePanelWithFilters("Select LushLOD Tree Prefab file", "Assets/", new string[] { "Unity Prefab", "prefab", });
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
                            if (EditorUtility.DisplayDialog("Selection Failed", "The prefab file you selected is not a LushLOD Tree. If you need help, please see the Quick Start guide for instructions, or feel free to ask for assistance on the support website. Would you like to try again?", "Try Again", "Stop the conversion"))
                            {
                                goto tryagain1;
                            }
                            else
                            {
                                GetTHIS.ConversionStage = _LushLODTreeSceneConverter.ConversionStages.NotStarted;
                                // Apply changes to the serializedProperty - always do this in the end of OnInspectorGUI.
                                serializedObject.ApplyModifiedProperties();
                                return;
                            }
                        }
                        else
                        {
                            if (ThisTree.gameObject.name.ToLower().Trim() != checkTree.Original_TreeName.ToLower().Trim())
                            {
                                //Name of prefab files doesn't match, get confimation from user.
                                if (!EditorUtility.DisplayDialog("Please confirm", "The name of the tree in the prefab file you selected is \"" + checkTree.Original_TreeName + "\". The name of the tree we are converting is \"" + ThisTree.gameObject.name + "\". All other trees of the same type will also be part of this conversion. Continue?", "Yes - use this prefab", "No -- give me more options"))
                                {
                                    if (EditorUtility.DisplayDialog("Please confirm", "Would you like to select a different prefab?", "Yes -- Try Again", "No -- Stop the conversion"))
                                    {
                                        goto tryagain1;
                                    }
                                    else
                                    {
                                        GetTHIS.ConversionStage = _LushLODTreeSceneConverter.ConversionStages.NotStarted;
                                        // Apply changes to the serializedProperty - always do this in the end of OnInspectorGUI.
                                        serializedObject.ApplyModifiedProperties();
                                        return;
                                    }
                                }
                            }

                            //Perform the conversion!
                            int TotalConverted = 0;
                            Tree[] TempTrees = GameObject.FindObjectsOfType<Tree>();
                            foreach (Tree tree in TempTrees)
                            {
                                if (tree.data == ThisTree.data)
                                {
                                    GameObject ReplacingTree = (GameObject)PrefabUtility.InstantiatePrefab(newPrefab);
                                    ReplacingTree.transform.position = tree.transform.position;
                                    ReplacingTree.transform.rotation = tree.transform.rotation;
                                    if (GetTHIS.UseLossyScale == true)
                                    {
                                        ReplacingTree.transform.localScale = tree.transform.lossyScale;
                                    }
                                    else
                                    {
                                        ReplacingTree.transform.localScale = tree.transform.localScale;
                                    }
                                    ReplacingTree.transform.parent = GetTHIS.NewTreesRoot.transform;
                                    TotalConverted += 1;
                                }
                            }

                            foreach (Terrain terr in GetTHIS.AllTerrains)
                            {

                                if (terr.terrainData.treeInstanceCount == 0) continue; //<-- this terrain has no trees, skip it.

                                foreach (TreeInstance TreeInst in terr.terrainData.treeInstances)
                                {
                                    Tree tree = terr.terrainData.treePrototypes[TreeInst.prototypeIndex].prefab.GetComponent<Tree>();

                                    if (tree.data == ThisTree.data)
                                    {
                                        GameObject ReplacingTree = (GameObject)PrefabUtility.InstantiatePrefab(newPrefab);
                                        ReplacingTree.transform.position = Vector3.Scale(TreeInst.position, terr.terrainData.size) + terr.transform.position;
                                        ReplacingTree.transform.localScale = new Vector3(TreeInst.widthScale, TreeInst.heightScale, TreeInst.widthScale);
                                        ReplacingTree.transform.rotation = Quaternion.AngleAxis(TreeInst.rotation * Mathf.Rad2Deg, Vector3.up);
                                        ReplacingTree.transform.parent = GetTHIS.NewTreesRoot.transform;
                                        TotalConverted += 1;
                                    }
                                }
                            }

                            if (TotalConverted > 0)
                            {
                                EditorUtility.DisplayDialog("Converted", "Converted " + TotalConverted + " trees.", "Continue");
                            }
                            else
                            {
                                EditorUtility.DisplayDialog("Warning", "We couldn't find any trees of this type (" + checkTree.Original_TreeName + ") to convert. Nothing was converted.", "Continue");
                            }

                            _LushLODTree.TreesManager.RootAllTrees(false);
                            _LushLODTree.TreesManager.UpdateTreesPreview(null, false, false);

                            GetTHIS.WaitFrame = 0;
                            GetTHIS.TreeLoop += 1; //<-- The next frame will convert the next tree, until we are done.

                        }
                    }
                    else
                    {
                        if (EditorUtility.DisplayDialog("Selection Failed", "You did not select a valid LushLOD Tree prefab file. If you need help, please see the Quick Start guide for instructions, or feel free to ask for assistance on the support website. Would you like to try again?", "Try Again", "Stop the conversion"))
                        {
                            goto tryagain1;
                        }
                        else
                        {
                            GetTHIS.ConversionStage = _LushLODTreeSceneConverter.ConversionStages.NotStarted;
                            // Apply changes to the serializedProperty - always do this in the end of OnInspectorGUI.
                            serializedObject.ApplyModifiedProperties();
                            return;
                        }
                    }
                }
                else
                {
                    if (Event.current.type == EventType.Repaint) GetTHIS.WaitFrame += 1;
                }

                break;

            case _LushLODTreeSceneConverter.ConversionStages.Finished:

                if (GetTHIS.WaitFrame < 1)
                {
                    if (Event.current.type == EventType.Repaint) GetTHIS.WaitFrame += 1;
                    return;
                }

                GUILayout.Box("Conversion in progress.", RegularStyleBox);
                GUILayout.Box("IF YOU ARE SATISFIED with the placement of the new trees, click the Delete Unity Trees button below to finish the conversion.", RegularStyleBox);
                GUILayout.Box("IF YOU ARE NOT SATISFIED with the conversion, simply delete the NewTreesRoot GameObject, which will remove all the new LusHLOD Trees from your scene, and then click \"Start a new Conversion\" if you would like to try again.", RegularStyleBox);

                if (GUILayout.Button("Delete Unity Trees", style))
                {
                    if (!EditorUtility.DisplayDialog("Last Warning", "There is NO UNDO for this process.", "Continue -- I made a backup of this scene!", "Cancel"))
                    {
                        // Apply changes to the serializedProperty - always do this in the end of OnInspectorGUI.
                        serializedObject.ApplyModifiedProperties();
                        return;
                    }

                    //Perform the conversion!
                    Tree[] TempTrees = GameObject.FindObjectsOfType<Tree>();
                    foreach (Tree tree in TempTrees)
                    {
                        if (tree.data != null)
                        {
                            //It's a tree, but not a LushLOD Tree, let's ZAP IT! Arrrgh!
                            GameObject.DestroyImmediate(tree.gameObject, false);
                        }
                    }

                    foreach (Terrain terr in GetTHIS.AllTerrains)
                    {
                        if (terr.terrainData.treeInstanceCount == 0) continue; //<-- this terrain has no trees, skip it.
                        foreach (TreeInstance TreeInst in terr.terrainData.treeInstances)
                        {
                            terr.terrainData.treeInstances = new TreeInstance[0]; //<-- should simply zap all trees on this whole terrain.
                        }
                    }

                    if (_LushLODTree.TreesManager != null)
                    {
                        switch (GetTHIS.CreatedManager)
                        {
                            case true:
                                EditorUtility.DisplayDialog("Manager Created", "A new GameObject named \"_LushLODTreesManager\" has been added to your scene's Hierarchy. Please select it, and follow any additional setup instructions there.", "Okay");
                                break;
                            case false:
                                EditorUtility.DisplayDialog("Manager Created", "Please check your _LushLODTreesManager to ensure that all the new trees are properly setup the way you want them.", "Okay");
                                break;
                        }
                        _LushLODTree.TreesManager.RootAllTrees(false);
                        _LushLODTree.TreesManager.UpdateTreesPreview(null, false, false);
                        _LushLODTree.TreesManager.ReCalculateParents(false, false);
                    }
                    else
                    {
                        EditorUtility.DisplayDialog("Completed", "Scene Conversion Finished.", "Okay");
                    }

                    GetTHIS.ConversionStage = _LushLODTreeSceneConverter.ConversionStages.NotStarted;
                }

                if (GUILayout.Button("Start a new Conversion", style))
                {
                    GetTHIS.ConversionStage = _LushLODTreeSceneConverter.ConversionStages.NotStarted;

                    if (_LushLODTree.TreesManager != null)
                    {
                        if (GetTHIS.CreatedManager == true)
                        {
                            EditorUtility.DisplayDialog("Manager was created", "During the previous conversion process, a new GameObject named _LushLODTreesManager was added to your scene's Hierarchy. If you aren't planning to use LushLOD Trees in your scene, you can simply delete this manager.", "Okay");
                        }

                        _LushLODTree.TreesManager.RootAllTrees(false);
                        _LushLODTree.TreesManager.UpdateTreesPreview(null, false, false);
                        _LushLODTree.TreesManager.ReCalculateParents(false, false);
                    }
                }
                break;
        }

        // Apply changes to the serializedProperty - always do this in the end of OnInspectorGUI.
        serializedObject.ApplyModifiedProperties();
    }
}
#endif