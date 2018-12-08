The scenes in the folder named "Gaia Demo scene2" and "Gaia Demo scene_baked2" 
are partial scenes which are not meant to be loaded directly. Rather, they are 
loaded by a script that runs on the main "Gaia Demo" scene.

If you wish to change the shadow settings in the "Gaia Demo" scene, you'll need 
to add both the partial scenes in this folder to the build settings. Unfortunantly, 
there is no easy way for me to do this for you, so you'll have to do it yourself manually.
Your project build settings can be found in the Unity Editor's main menu under 
File->Build Settings. From there, you can find a list of "Scenes in Build", 
and you should add these two scenes, along with the main "Gaia Demo" scene as well. 
If you don't do this, then you may see some errors in the Gaia Demo relating to 
"scene not found", if you try to change the shadow settings while the Demo is running.