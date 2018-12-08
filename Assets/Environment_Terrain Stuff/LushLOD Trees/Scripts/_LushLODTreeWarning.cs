using UnityEngine;

#if UNITY_EDITOR
using UnityEditor;
#endif

[ExecuteInEditMode]
public class _LushLODTreeWarning : MonoBehaviour
{

#if UNITY_EDITOR

    void OnDestroy()
    {
        //Make sure the whole tree is being destroyed, and not just part of it.
        if (this.transform.parent != null)
        {
            if (this.transform.parent.gameObject != null)
            {
                _LushLODTree parentTree = this.transform.parent.gameObject.GetComponent<_LushLODTree>();
                if (parentTree != null)
                {
                    bool FoundMe = false;
                    bool FoundParent = false;
                    foreach (Object selectedStuffLoop in Selection.objects)
                    {
                        if (selectedStuffLoop == this.gameObject) FoundMe = true;
                        if (selectedStuffLoop == this.transform.parent.gameObject) FoundParent = true;
                    }
                    if (FoundMe == true && FoundParent == false)
                    {
                        //Whoops, they have this part of the tree selected, but they don't have the parent gameobject of this tree selected.
                        //This may mean that only part of the tree is going to be deleted.
                        Debug.LogError("WARNING: You've deleted the " + this.transform.gameObject.name + " child gameobject of a _LushLOD Tree named " + parentTree.Original_TreeName + ", but you may not have deleted the entire tree!");
                    }
                }
            }
        }
    }

    //Here will will have some function to help us upgrade our trees in the event that the user is
    //using an older version of a tree, and a problem exists as a result. In such a case, the most likely thing to happen
    //is that the user will CLICK on the tree. If they do, this script will run which will check to ensure that nothing is screwed up.

    public void CheckTree()
    {
        if (this.gameObject.name.ToLower() == "lod_0" || this.gameObject.name.ToLower() == "lod_1")
        {
            _LushLODTree ThisTree = null;
            ThisTree = this.gameObject.transform.parent.GetComponent<_LushLODTree>();
            if (ThisTree != null &&
                ReferenceEquals(ThisTree, null) != true &&
                ThisTree.Equals(null) == false)
            {
                if (float.Parse(ThisTree.LushLODTree_VersionNumber) < 0.75f)
                {
                    //User is upgrading from before 0.75.

                    //Issues that can exist:
                    //1) I renamed _MainTex2 to _MainTex. This broke all references.

                    //Solutions needed:
                    //1) Check if _MainTex is missing its reference, and if it is, try to find the atlas texture.

                    Texture2D MainTex_FullyOpaque = (Texture2D)ThisTree.Material_NotInstance_FullyOpaque.GetTexture("_MainTex");
                    Texture2D MainTex_Transitioning = (Texture2D)ThisTree.Material_Instance_Transitioning.GetTexture("_MainTex");
                    Texture2D Billboard_Texture = (Texture2D)ThisTree.lod1Rend.sharedMaterial.GetTexture("_MainTex");

                    if (MainTex_FullyOpaque == null || MainTex_Transitioning == null || Billboard_Texture == null)
                    {
                        string AssetPath = AssetDatabase.GetAssetPath(ThisTree.Material_NotInstance_FullyOpaque);
                        //It was originally saved at: "Assets/" + exportPath + "/Atlas/Materials/Material_NotInstance_FullyOpaque.mat"

                        if (AssetPath.EndsWith("/Atlas/Materials/Material_NotInstance_FullyOpaque.mat"))
                        {
                            //The directory structure is as expected. Let's try to find the atlas texture then.
                            string AssetTexturePath = AssetPath.Replace("/Atlas/Materials/Material_NotInstance_FullyOpaque.mat", "");
                            AssetTexturePath = AssetTexturePath + "/Atlas/Texture/Atlas.png";

                            Texture2D FindAtlasTexture = AssetDatabase.LoadAssetAtPath(AssetTexturePath, typeof(Texture2D)) as Texture2D;

                            if (FindAtlasTexture != null)
                            {
                                if (MainTex_FullyOpaque == null)
                                    ThisTree.Material_Instance_Transitioning.SetTexture("_MainTex", FindAtlasTexture);
                                if (MainTex_Transitioning == null)
                                    ThisTree.Material_Instance_Transitioning.SetTexture("_MainTex", FindAtlasTexture);
                                if (Billboard_Texture == null)
                                    ThisTree.lod1Rend.sharedMaterial.SetTexture("_MainTex", FindAtlasTexture);
                            }
                        }
                    }
                }
            }
        }
    }
#endif

}

#if UNITY_EDITOR
// Custom Editor using SerializedProperties.
// Automatic handling of multi-object editing, undo, and prefab overrides.
[CustomEditor(typeof(_LushLODTreeWarning))]
[CanEditMultipleObjects]
public class _LushLODTreeWarning_Editor : Editor
{
    void OnEnable()
    {
        //Check the tree to make sure it isn't messed up as a result of an upgrade.
        ((_LushLODTreeWarning)this.target).CheckTree();
    }

    public override void OnInspectorGUI()
    {
        // Update the serializedProperty - always do this in the beginning of OnInspectorGUI.
        serializedObject.Update();
        
        var Redstyle = new GUIStyle(GUI.skin.box);
        Redstyle.normal.textColor = Color.red;

        var Greenstyle = new GUIStyle(GUI.skin.box);
        Greenstyle.normal.textColor = Color.blue;
        Greenstyle.fontStyle = FontStyle.Bold;

        //Set up some text styles, such as red text, bold red text, etc:
        var style = new GUIStyle(GUI.skin.button);
        style.fontStyle = FontStyle.Bold;
        var BoldRedstyle = new GUIStyle(GUI.skin.box);
        BoldRedstyle.normal.textColor = Color.red;
        BoldRedstyle.fontStyle = FontStyle.Bold;

        GUILayout.Space(10f);

        GUILayout.Box("STOP! STOP! STOP!", BoldRedstyle);
        GUILayout.Box("HI! This is a LushLOD Tree! If you're looking to modify this tree's shader, materials, renderers or other settings, you can change most settings using the _LushLODTreesManager found in your scene's Hierarchy. You should not manually change the tree's settings below, because if you do, you could create errors. To change the tree's settings, please use the _LushLODTreesManager found in your hierarchy. Thanks!", Redstyle);

        GUILayout.Space(20f);

    }
}

#endif 
