using UnityEngine;
using System.Collections;
using System.Collections.Generic;
using UnityEngine.SceneManagement;

/// <summary>
/// This script / class controls all the buttons on the uGUI panel that appears along the left side of the
/// screen in the various demo scenes included with LustLOD Trees. NOTE: This is a very dumbed-down version of
/// script that is actually used to control the trees. The main script that controls the trees is called _LushLODTreesManager.cs,
/// but it is used almost exclusively in the Unity EDITOR. This script simply steals some of the functionality of that manager,
/// and puts it into a Unity GUI panel which can be displayed in the game while the game is running, which allows the trees to
/// be controlled during the game, by an end user. If you are trying to control the trees, and you are using the Unity editor, you
/// shouldn't be trying to control the trees using this script, or by using any of the buttons or sliders that appear in the panel
/// that is located along the left side of the game window. Rather, if you are using the Unity editor to control your trees, you
/// should be looking at the _LushLODTreesManager window. To find it, look in your scene's hierarchy for a gameobject called
/// _LushLODTreesManager, and click it, and then look at the inspector window, and you'll see all the options to control the trees.
/// The _LushLODTreesManager can be used in the editor to control the trees both while the game is running, and while it isn't 
/// running. But it only works in the editor.
/// However, for controling the trees during the final build of the game (where the Unity editor isn't available), this script
/// works for most of the features.
/// </summary>
public class _LushLODTreesUI : MonoBehaviour {

    /// <summary>
    /// Contains a reference to the tree manager. This is where any changes to the trees will need to be enacted.
    /// </summary>
    public _LushLODTreesManager Manager;
    /// <summary>
    /// There are two buttons to control the color of the trees. Both buttons open the color selection window. This
    /// variable simply saves which button the user clicked on. The value of 1 == high quality tree colors. The value of
    /// 2 == billboard tree colors.
    /// </summary>
    public int ColorBeingSelected = 0;
    /// <summary>
    /// This is a reference to the Color Picker window.
    /// </summary>
    public GameObject ColorPicker;
    /// <summary>
    /// This is a reference to a little panel that appears directly below the high quality tree color selection button. This
    /// panel does nothing except it displays the adjustment color that's being applied to the high quality tree models.
    /// </summary>
    public UnityEngine.UI.Image Panel1;
    /// <summary>
    /// This is a reference to a little panel that appears directly below the billboard tree color selection button. This
    /// panel does nothing except it displays the adjustment color that's being applied to the billboard tree models.
    /// </summary>
    public UnityEngine.UI.Image Panel2;
    /// <summary>
    /// This is a reference to the slider bar that controls the LOD distance for the trees.
    /// </summary>
    public UnityEngine.UI.Slider LODSlider;
    /// <summary>
    /// This is a reference to the text that appears next to the LOD Slider bar.
    /// </summary>
    public UnityEngine.UI.Text LODText;
    /// <summary>
    /// This is a reference to the billboard quality slider bar.
    /// </summary>
    public UnityEngine.UI.Slider BillboardQualitySlider;
    /// <summary>
    /// This is a reference t the text that's next to the billboard quality slider bar.
    /// </summary>
    public UnityEngine.UI.Text BillboardQualityText;
    /// <summary>
    /// This is a reference to the billboard settings drop-down box.
    /// </summary>
    public UnityEngine.UI.Dropdown BillboardSetting;
    /// <summary>
    /// This is a reference to the shadow settings drop-down box.
    /// </summary>
    public UnityEngine.UI.Dropdown ShadowsSetting;
    /// <summary>
    /// Toggles the scene's fog on or off.
    /// </summary>
    public UnityEngine.UI.Toggle FogToggle;
    /// <summary>
    /// Toggles the scene's fog on or off.
    /// </summary>
    public UnityEngine.UI.Toggle WindToggle;
    /// <summary>
    /// This is a reference to the wind zone in the scene.
    /// </summary>
    public WindZone WindZone;
    /// <summary>
    /// This is a reference to the directional light in the scene.
    /// </summary>
    public Light DirectionalLight;
    /// <summary>
    /// This is a reference to the text that displays the Frames Per Second (FPS), 
    /// which is on the upper right corner of the game window.
    /// </summary>
    public UnityEngine.UI.Text FPSText;
    /// <summary>
    /// This varible keeps track of what kind of scene we are in. If we are in a scene that ends with the text: "_baked" or
    /// "_baked2", then we know we're in a scene that has baked shadows. This is all part of the demo.
    /// </summary>
    private bool CurrentlyShadowsBaked = true;
    /// <summary>
    /// This float is used to calculate the frames per second.
    /// </summary>
    float deltaTime = 0.0f;


    List<Color> ColorsArray = new List<Color>();
    


    /// <summary>
    /// This function is called when the game first starts.
    /// </summary>
    void Start()
    {
        //Check if we are currently in a scene, where the name of the scene ends with "_baked" or "_baked2",
        //because if we are, then we know the shadows in this scene are baked shadows:
        CurrentlyShadowsBaked = UnityEngine.SceneManagement.SceneManager.GetActiveScene().name.EndsWith("scene_baked2") ||
                                UnityEngine.SceneManagement.SceneManager.GetActiveScene().name.EndsWith("Demo") ||
                                UnityEngine.SceneManagement.SceneManager.GetActiveScene().name.EndsWith("Demo Fast");

        Panel1.color = Manager.maincolor_HQTrees_PREVIOUS;
        Panel2.color = Manager.maincolor_LQTrees_PREVIOUS;

        ColorsArray.Add(Color.black);
        ColorsArray.Add(Color.blue);
        ColorsArray.Add(Color.cyan);
        ColorsArray.Add(Color.gray);
        ColorsArray.Add(Color.green);
        ColorsArray.Add(Color.magenta);
        ColorsArray.Add(Color.red);
        ColorsArray.Add(Color.white);
        ColorsArray.Add(Color.yellow);

        //Load just some of the settings from the manager, in case they are different:
        if (BillboardQualitySlider.value != (int)Manager.billboard_quality_PREVIOUS)
        {
            BillboardQualitySlider.value = (int)Manager.billboard_quality_PREVIOUS;
            BillboardQualityChanged();
        }
        if (BillboardSetting.value != (int)Manager.BillBoardSetting_PREVIOUS)
        {
            BillboardSetting.value = (int)Manager.BillBoardSetting_PREVIOUS;
            BillboardSettingChanged();
        }
        if (LODSlider.value != Manager.LOD_adjust_PREVIOUS)
        {
            LODSlider.value = Manager.LOD_adjust_PREVIOUS;
            LODChanged();
        }

        WindZone.gameObject.SetActive(WindToggle.isOn);
        RenderSettings.fog = FogToggle.isOn;
        SceneManager.activeSceneChanged += SceneChanged;

        this.Invoke("meh", 0.001f);

    }

    void meh()
    {
        ColorPicker.SetActive(false);
    }

    /// <summary>
    /// This function is called on every frame.
    /// </summary>
    void Update()
    {
        //calculate and display the frames per second:
        deltaTime += (Time.deltaTime - deltaTime) * 0.1f;
        float fps = 1.0f / deltaTime;
        FPSText.text = "FPS: " + (int)fps;

        if (Input.GetKeyDown(KeyCode.Escape) && Application.isPlaying == true)
        {
            //The user hit the ESC key on their keyboard while the game is playing. Quit the game.
            //Note: This doesn't work in the Unity editor.
            Application.Quit();
        }
    }

    void LateUpdate()
    {
        if (_LushLODTree.TreesManager.RealTimeShadowSetting_PREVIOUS == _LushLODTreesManager.RealTimeShadowSettings.RealtimeShadowsOff)
        {
            if (_LushLODGaiaDemoMainDirLight.LightRef.shadows != LightShadows.None) _LushLODGaiaDemoMainDirLight.LightRef.shadows = LightShadows.None;
        }
        else
        {
            if (_LushLODGaiaDemoMainDirLight.LightRef.shadows != LightShadows.Soft) _LushLODGaiaDemoMainDirLight.LightRef.shadows = LightShadows.Soft;
        }
    }
    
    public void SceneChanged(Scene a, Scene b)
    {
        FogChanged();
        WindChanged();
        Manager.MainDirectionalLight = GameObject.Find("Directional Light").GetComponent<Light>();

    }

    /// <summary>
    /// This function is called whenever the user clicks the Transparency checkbox, which is located in the game view in
    /// most of the demo scenes inclued with LushLOD Trees.
    /// </summary>
    public void FogChanged()
    {
        RenderSettings.fog = FogToggle.isOn;
    }

    /// <summary>
    /// 
    /// </summary>
    public void WindChanged()
    {
        WindZone.gameObject.SetActive(WindToggle.isOn);
    }

    /// <summary>
    /// This function is called by the two color-adjustment buttons that appear at the top left corner of the game window.
    /// Those buttons are in most of the demo scenes inclued with LushLOD Trees.
    /// </summary>
    /// <param name="which">which button was clicked? Set to 1 if it was the high quality tree colors button, or 2 if it was
    /// the button for the billboard tree colors.</param>
    public void SetColorBeingSelected(int which)
    {
        ColorBeingSelected = which;
    }

    /// <summary>
    /// When you click one of the little square color selection boxes, this function is called.
    /// </summary>
    public void OnColorChanged(int Color)
    {
        switch (ColorBeingSelected) //<-- check which button was used to open the color selection window.
        {
            case 1: //<-- high quality tree colors:
                Panel1.color = ColorsArray[Color];
                break;
            case 2: //<-- billboard tree colors:
                Panel2.color = ColorsArray[Color];
                break;
        }
    }

    /// <summary>
    /// This function is called by a button located at the bottom of the color selection window.
    /// </summary>
    public void FinalizeColor()
    {
        switch (ColorBeingSelected) //<-- check which button was used to open the color selection window.
        {
            case 1: //<-- high quality tree colors:
                Manager.maincolor_HQTrees = Panel1.color; //<-- modify the manager's color for the high quality trees.
                Manager.maincolor_HQTrees.a = 0.5f; //<-- set the alpha to 0.5f, so that we don't change the alpha any.
                Manager.ApplyAll(); //<-- tell the manager to update all the trees.
                break;
            case 2: //<-- billboard tree colors:
                Manager.maincolor_LQTrees = Panel2.color; //<-- modify the manager's color for the billboard trees.
                Manager.maincolor_LQTrees.a = 0.5f; //<-- set the alpha to 0.5f, so that we don't change the alpha any.
                Manager.ApplyAll(); //<-- tell the manager to update all the trees.
                break;
        }
    }

     /// <summary>
    /// This function is called as an action that occurs on the "On Changed()" event of the Reset Colors button.
    /// To confirm this, select the Reset Colors button in any of the demo scenes included
    /// with LushLOD Trees. Then in the inspector, scroll down and you'll see where it calls this function.
    /// </summary>
    public void ResetColors()
    {
        Manager.maincolor_HQTrees = new Color(0.5f, 0.5f, 0.5f, 0.5f); //<-- Hover your mouse to see descriptions.
        Manager.maincolor_LQTrees = new Color(0.5f, 0.5f, 0.5f, 0.5f); //<-- Hover your mouse to see descriptions.
        Panel1.color = new Color(0.5f, 0.5f, 0.5f, 0.5f); //<-- Hover your mouse to see descriptions.
        Panel2.color = new Color(0.5f, 0.5f, 0.5f, 0.5f); //<-- Hover your mouse to see descriptions.
        Manager.ApplyAll(); //<-- Hover your mouse to see descriptions.
    }

    /// <summary>
    /// This function is called by the LOD Distance slider bar in the uGUI panel on the left side of the game window,
    /// which is found in most of the demo scenes included with LushLOD Trees.
    /// </summary>
    public void LODChanged()
    {
        CancelInvoke(); //<-- stops any previous LOD change from occuring.
        LODText.text = "LOD Distance:\n(" + (int)LODSlider.value + ")"; //<-- updates the text to show the LOD value.
        InvokeRepeating("LODChanged2", 1f, 99f); //<-- schedules this LOD to be applied in exactly 1 second.
                                                 //This helps ensure that we don't try to change the LOD while the user
                                                 //is still moving the slider bar, unless the stop for a whole second.
    }

    /// <summary>
    /// This function is called by LODChanged().
    /// </summary>
    public void LODChanged2()
    {
        CancelInvoke(); //<-- this is a function built in to Unity. Probably best way to learn about it, is to use Google.
        Manager.LOD_adjust = LODSlider.value; //<-- hover your mouse to see descriptions.
        Manager.ApplyAll(); //<-- hover your mouse to see descriptions.
    }

    /// <summary>
    /// This function is called by the Shadow Settings drop-down box in the uGUI panel on the left side of the game window,
    /// which is found in most of the demo scenes included with LushLOD Trees.
    /// </summary>
    public void ShadowsSettingChanged()
    {
        switch (ShadowsSetting.value)
        {

            //Note: When the user switches from baked shadows to realtime shadows, the scene must be re-loaded.
            //This is required by Unity. However, it takes way too long to reload all the thousands of trees in the
            //demo scene. So to make the scene load much faster, we set the trees, and the tree manager, and the uGUI
            //panels, to NOT be destroyed when the scene changes. But this means we can't then be loading a new scene
            //that also has the trees in it, because then there would be TWO copies of all the trees in the scene!

            //So to solve this situation, I've created some copies of the scene. The main scene which is loaded first
            //is called Gaia Demo. The shadows are baked in this scene. From there, if the user switches to realtime
            //shadows, it loads the scene called "scene2". This is a non-baked scene. This scene2 has no trees in it,
            //and no manager, and no uGUI. However, since we told the trees NOT to be destroyed, then those things will
            //still exist in the game when the new scene is loaded. What changed? The terrain will have change, and that
            //main directional light will be different in scene2. The baked shadows will be gone, because they're only
            //baked into the terrain, and not into the trees.

            //The same is true when switching back to baked shadows from realtime shadows. We can't load the scene_baked
            //again, because it would load a second copy of all the trees in the scene. So instead, we would load the
            //scene_baked2 scene, which reloads only the terrain with baked shadows, and the main directional light with
            //shadow baking mode turned on.

            case 0: //<-- baked shadows.
                Manager.RealTimeShadowSetting = _LushLODTreesManager.RealTimeShadowSettings.RealtimeShadowsOff;
                Manager.ApplyAll(); //<-- set the tree to cast NO shadows. The manager will enact this change.
                if (CurrentlyShadowsBaked == false)
                {
                    CurrentlyShadowsBaked = true;
                    UnityEngine.SceneManagement.SceneManager.LoadScene("Gaia Demo scene_baked2"); //<-- load the baked terrain, and the baked directional light.
                }
                break;
            case 1: //<-- use both.
                Manager.RealTimeShadowSetting = _LushLODTreesManager.RealTimeShadowSettings.UseBoth;
                Manager.ApplyAll(); //<-- set the tree to cast shadows from both HQ and LQ tree models. The manager will enact this change.
                if (CurrentlyShadowsBaked == true)
                {
                    CurrentlyShadowsBaked = false;
                    UnityEngine.SceneManagement.SceneManager.LoadScene("Gaia Demo scene2"); //<-- load the non-baked terrain, and the non-baked directional light.
                    return;
                }
                break;

            case 2: //<-- billboard only
                Manager.RealTimeShadowSetting = _LushLODTreesManager.RealTimeShadowSettings.BillboardOnly;
                Manager.ApplyAll(); //<-- set the tree to cast shadows only from billboards. The manager will enact this change.
                if (CurrentlyShadowsBaked == true)
                {
                    CurrentlyShadowsBaked = false;
                    UnityEngine.SceneManagement.SceneManager.LoadScene("Gaia Demo scene2"); //<-- load the non-baked terrain, and the non-baked directional light.
                    return;
                }
                break;
            case 3: //<-- off
                Manager.RealTimeShadowSetting = _LushLODTreesManager.RealTimeShadowSettings.RealtimeShadowsOff;
                Manager.ApplyAll(); //<-- set the tree to cast NO shadows. The manager will enact this change.
                if (CurrentlyShadowsBaked == true)
                {
                    CurrentlyShadowsBaked = false;
                    UnityEngine.SceneManagement.SceneManager.LoadScene("Gaia Demo scene2"); //<-- load the non-baked terrain, and the non-baked directional light.
                    return;
                }
                break;
        }
    }

    /// <summary>
    /// This function is called by the Billboard Settings drop-down box in the uGUI panel on the left side of the game window,
    /// which is found in most of the demo scenes included with LushLOD Trees.
    /// </summary>
    public void BillboardSettingChanged()
    {
        switch (BillboardSetting.value) //<-- check which option the user selected.
        {
            case (int)_LushLODTreesManager.BillBoardSettings.UseBoth: //<-- this is the option for "Use Both"
                Manager.BillBoardSetting = _LushLODTreesManager.BillBoardSettings.UseBoth;
                BillboardQualitySlider.interactable = true; //<-- this option supports angular correction.
                break;
            case (int)_LushLODTreesManager.BillBoardSettings.BillboardsOnly: //<-- this is the dropdown option for "Billboards Only"
                Manager.BillBoardSetting = _LushLODTreesManager.BillBoardSettings.BillboardsOnly;
                BillboardQualitySlider.interactable = true; //<-- this option supports angular correction.
                break;
            case (int)_LushLODTreesManager.BillBoardSettings.HighQualityModelsOnly: //<-- this is the dropdown option for "HQ Models Only"
                Manager.BillBoardSetting = _LushLODTreesManager.BillBoardSettings.HighQualityModelsOnly;
                BillboardQualitySlider.interactable = false; //<-- the high quality trees do NOT support angular correction.
                                                            //So we'll just turn off the angular correction slider.
                break;
        }
        Manager.ApplyAll(); //<-- tell the manager to apply the above changes to all the trees in the scene.
    }

    /// <summary>
    /// This function is called whenever the user moves the Angle Correction slider, which is located in the game view in
    /// most of the demo scenes inclued with LushLOD Trees.
    /// </summary>
    public void BillboardQualityChanged()
    {
        CancelInvoke();
        BillboardQualityText.text = "Billboard Quality:\n(" + (_LushLODTreesManager.BillboardQualitySettings)(int)BillboardQualitySlider.value + ")";
        InvokeRepeating("BillboardQualityChanged2", 1f, 99f); //<-- wait 1 full second  before applying this change.
    }

    public void BillboardQualityChanged2()
    {
        CancelInvoke();
        Manager.billboard_quality = (_LushLODTreesManager.BillboardQualitySettings)(int)BillboardQualitySlider.value;
        Manager.ApplyAll(); //<-- apply this new angular correction to every tree. The manager will do this.
    }

}
