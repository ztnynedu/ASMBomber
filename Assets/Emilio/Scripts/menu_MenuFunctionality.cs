using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.SceneManagement;
using UnityEngine.UI;
using UnityEngine.EventSystems;
using UnityEngine.Events;

public class menu_MenuFunctionality : MonoBehaviour {

    public static menu_MenuFunctionality MF;

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

    private void Awake()
    {
        if (MF == null)
        {
            MF = this;
        }
        else
        {
            Destroy(menu_MenuFunctionality.MF.gameObject);
        }
        DontDestroyOnLoad(this.gameObject);
    }
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
        PauseButtonActivate();
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

        Time.timeScale = 1;

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

        Debug.Log("OptionsMenu");

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

        PauseMenu.SetActive(!PauseMenu.activeSelf);
        Paused = true;
    }
    public void QuitGame()
    {
        Application.Quit();
    }

    // [PauseChecker]
    public void WasGamePaused()
    {
        if (PauseMenu.activeSelf == true)
        {
            if(Paused == true)
            {
                Paused = false;
                Debug.Log("Game Is Paused");
                Cursor.lockState = CursorLockMode.None;
                Cursor.visible = true;
                Time.timeScale = 0;
            }
        }
        else
        {
            if (Paused == true)
            {
                Paused = false;
                Cursor.lockState = CursorLockMode.Locked;
                Cursor.visible = false;
                InGameUIActivate();

                Debug.Log("Game Is Unpaused");
                Time.timeScale = 1;
            }
        }
    }

    // [Pause The Game Ho]
    public void PauseButtonActivate()
    {
        if (Input.GetKeyUp(KeyCode.P))
        {
            PauseActivate();
        
        }
    }

    // [Loads Test Scene]
    public void LoadTest(string Test)
    {
        SceneManager.LoadScene(Test);
        Destroy(gameObject);
    }

    // [Loads Menu Scene]
    public void LoadMainMenu(string WeOutHereTesting)
    {
        SceneManager.LoadScene(WeOutHereTesting);
        MainMenuActivate();
        Destroy(gameObject);
        //SceneManager.UnloadScene(Test);
    }
}
