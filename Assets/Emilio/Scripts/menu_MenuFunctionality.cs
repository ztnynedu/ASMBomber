using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.SceneManagement;
using UnityEngine.UI;
using UnityEngine.EventSystems;
using UnityEngine.Events;

public class menu_MenuFunctionality : MonoBehaviour {

    [SerializeField]
    GameObject MainMenu;
    [SerializeField]
    GameObject ModeSelect;
    [SerializeField]
    GameObject Credits;

    public GameObject InGameUI;
    public GameObject PauseMenu;
    public GameObject OptionsMenu;

    [SerializeField]
    public bool Paused;

    // [Is This Scene GamePlay or No?]
    [SerializeField]
    public bool IsMainMenu;

    // Use this for initialization
    void Start () {

        // [Is This Scene GamePlay or No?]
		if (IsMainMenu == true)
        {
            MainMenuActivate();
        }
        else if (IsMainMenu == false)
        {
            InGameUIActivate();
        }
	}
	
	// Update is called once per frame
	void Update () {
        WasGamePaused();
	}

    // [All Menu UI Activations Below. Yes I know, this is messy.]
    public void MainMenuActivate()
    {
            Credits.SetActive(false);
            PauseMenu.SetActive(false);
            InGameUI.SetActive(false);
            OptionsMenu.SetActive(false);
            ModeSelect.SetActive(false);

        MainMenu.SetActive(true);
    }
    public void ModeSelectActivate()
    {
            Credits.SetActive(false);
            PauseMenu.SetActive(false);
            InGameUI.SetActive(false);
            OptionsMenu.SetActive(false);
            MainMenu.SetActive(false);

        ModeSelect.SetActive(true);
    }
    public void CreditsActivate()
    {
            PauseMenu.SetActive(false);
            InGameUI.SetActive(false);
            OptionsMenu.SetActive(false);
            ModeSelect.SetActive(false);
            MainMenu.SetActive(false);

        Credits.SetActive(true);
    }
    public void OptionsMenuActivate()
    {
            Credits.SetActive(false);
            PauseMenu.SetActive(false);
            InGameUI.SetActive(false);
            ModeSelect.SetActive(false);
            MainMenu.SetActive(false);

        OptionsMenu.SetActive(true);
    }
    public void InGameUIActivate()
    {
            Credits.SetActive(false);
            PauseMenu.SetActive(false);
            OptionsMenu.SetActive(false);
            ModeSelect.SetActive(false);
            MainMenu.SetActive(false);

        InGameUI.SetActive(true);
    }
    public void PauseActivate()
    {
            Credits.SetActive(false);
            InGameUI.SetActive(false);
            OptionsMenu.SetActive(false);
            ModeSelect.SetActive(false);
            MainMenu.SetActive(false);

        PauseMenu.SetActive(true);
    }

    // [PauseChecker]
    public void WasGamePaused()
    {
        if (PauseMenu.activeSelf == true)
        {
            if(Paused == false)
            {
                Paused = true;
                Time.timeScale = 0;
            }
        }
        else if (PauseMenu.activeSelf == false)
        {
            if (Paused == true)
            {
                Paused = false;
                Time.timeScale = 1;
            }
        }
    }

}
