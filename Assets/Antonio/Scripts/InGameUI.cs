using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.SceneManagement;
using UnityEngine.UI;
using UnityEngine.EventSystems;
using UnityEngine.Events;

public class InGameUI : MonoBehaviour {

    public static InGameUI MF;
    public GameObject MainMenu;
    public GameObject ModeSelect;
    public GameObject GameUI;
    public GameObject PauseMenu;
    public GameObject OptionsMenu;

    [SerializeField]
    public bool Paused;

    // [Is This Scene GamePlay or No?]
    [SerializeField]
    public bool IsMainMenu;

    private void Awake()
    {
        InGameUIActivate();

        if (MF == null)
        {
            MF = this;
        }
        else
        {
            Destroy(menu_MenuFunctionality.MF.gameObject);
        }

        DontDestroyOnLoad(gameObject);
    }
	
	// Update is called once per frame
	void Update ()
    {
        PauseButtonActivate();
        WasGamePaused();
    }

    // [All Menu UI Activations Below. Yes I know, this is messy.]
    public void MainMenuActivate()
    {
        PauseMenu.SetActive(false);
        GameUI.SetActive(false);
        OptionsMenu.SetActive(false);
        ModeSelect.SetActive(false);

        Time.timeScale = 1;

        MainMenu.SetActive(true);
    }

    public void OptionsMenuActivate()
    {
            PauseMenu.SetActive(false);
            GameUI.SetActive(false);
            OptionsMenu.SetActive(true);
    }

    public void InGameUIActivate()
    {
            PauseMenu.SetActive(false);
            OptionsMenu.SetActive(false);
            GameUI.SetActive(true);
    }

    public void PauseActivate()
    {
            GameUI.SetActive(false);
            OptionsMenu.SetActive(false);
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
        if (Input.GetKeyDown(KeyCode.P))
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
