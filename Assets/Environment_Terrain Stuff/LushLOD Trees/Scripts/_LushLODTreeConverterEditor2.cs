#if UNITY_EDITOR
using UnityEngine;
using UnityEditor;

/// <summary> 
/// The only real reson this class is needed is because its file is saved in an Editor folder, which gives it access to the
/// TreeEditor.TreeData class, which it needs to access so that it can save the tree data.
/// 
/// EDIT: As of Unity 2017.1, this script can no longer be attached to a gameobject, if this script is placed inside an "Editor" folder.
/// Because of this, I have to move this script out of the Editor folder, and into a regular folder. This means that this script is no
/// longer able to access the TreeEditor.TreeData class, which means we no longer are able to save the tree data. This is kind of a
/// bummer.
/// 
/// </summary>
public class _LushLODTreeConverterEditor2 : MonoBehaviour
{

    public _LushLODTreeConverter Converter;
    public bool Finished = false;

    void OnDestroy()
    {
        EditorUtility.ClearProgressBar();
    }

    void Update()
    {

        if (Application.isPlaying != true) return;

        if (Finished == true ||
            Converter == null ||
            ReferenceEquals(Converter, null) ||
            Converter.Equals(null) ||
            Converter.CONVERSION_FINISHED != true)
        {
            return;
        }

        Finished = true;

        for (int i = 0; i < Converter.NewTrees.Length; i++)
        {
            //Save the tree data. This is for potential future use.
            //EDIT: I have to remove this feature in Unity 2017, see comments above for explanation.
            //_LushLODTreeConverter.TreeConverting tree = Converter.NewTrees[i];
            //TreeEditor.TreeData treeData = (TreeEditor.TreeData)tree.HQTreeObj.GetComponent<Tree>().data;
            //treeData.mesh = tree.HQMesh;
            //treeData.optimizedSolidMaterial = tree.OptimizedBarkMaterial;
            //treeData.optimizedCutoutMaterial = tree.OptimizedLeafMaterial;
            //AssetDatabase.CreateAsset(Instantiate(treeData), "Assets/" + Converter.exportPath + "/Trees/" + tree.exportName + "/Lod0/Mesh/TreeData.asset");
        }

        AssetDatabase.SaveAssets();
        AssetDatabase.Refresh();

        Debug.Log("Conversion of trees is finished. New prefabs are located at: Assets/" + Converter.exportPath);
        EditorUtility.DisplayDialog("Finished", "Conversion of trees is finished.\nNew prefabs are located at:\nAssets/" + Converter.exportPath, "Okay");

        UnityEditor.EditorApplication.isPlaying = false;

    }

}

#endif