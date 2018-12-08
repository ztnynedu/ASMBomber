using UnityEngine;

/// <summary>
/// This script calculates and displays a Frame Per Second counter.
/// </summary>
public class _LushLODTreesFPS : MonoBehaviour {

 
    /// <summary>
    /// This is a reference to the text that displays the Frames Per Second (FPS), 
    /// which is on the upper right corner of the game window.
    /// </summary>
    public UnityEngine.UI.Text FPSText;
    /// <summary>
    /// This float is used to calculate the frames per second.
    /// </summary>
    float deltaTime = 0.0f;
         

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


}
