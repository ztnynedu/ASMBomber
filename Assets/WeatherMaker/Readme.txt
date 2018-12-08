Weather Maker, (c) 2016 Digital Ruby, LLC
http://www.digitalruby.com
Created by Jeff Johnson

Current Version : 4.3.2

For Change Log, See ChangeLog.txt.

Welcome to Weather Maker! I'm Jeff Johnson, and I've spent thousands of hours on this asset. I hope it serves you well for all your weather, sky, fog, water, audio and volumetric effect needs.

Please send me your suggestions, feedback and bug reports to support@digitalruby.com.

What is Weather Maker? Weather Maker is a complete environment effects system for Unity. Clouds, precipitation, ambient audio, lights, fog, storms, wind, sound effects, water and much more are built in.

*** IMPORTANT ***
As of Weather Maker 4.0.0, Weather Maker has weather zones and prefab changes, but this required some breaking changes. If you have issues with this version, please contact me and I can get you the previous version.
*****************

Setup Instructions
--------------------------------------------------

Project / Scene Setup:
- Install Unity 5.6.6 or newer with latest patch release.
- You may need to delete the WeatherMaker folder and re-download the asset if you see errors, as scripts and shaders are renamed or moved from time to time.
- Delete Rain Maker from your project if it is loaded. It is not compatible in the same project with Weather Maker, and is not needed anyway.
- If you want to use the demo scenes, import standard assets -> environment (for Unity 2018 or newer, download from http://demo.digitalruby.com/WeatherMaker/download/StandardAssets.zip).
- If you want clouds or sky sphere, change camera settings to clear as solid color, black (0,0,0,0). Camera set as skybox clear might render over top of clouds and sky sphere. Alternatively, set full screen cloud script to render after skybox and disable sky sphere to use your own custom skybox.
- Change light settings: Skybox material -> WeatherMakerSkyboxMaterial, sun source: Sun (from weather maker prefab).
- Change light settings: Environment lighting source: Color or Gradient, Environment reflections source: custom.
- Change player settings -> color space to linear if your platform supports it. Linear looks MUCH better than gamma.
- For 3D, if you will be using storm lightning, set your main camera far plane to 2000+.
- For 3D, if you are using tree billboarding, you can enable the full screen fog aware tree billboard shader by enabling WeatherMakerTreeBillboardShader.shader (see top of that file for instructions).
- Add null zones anywhere you want to block weather from rendering (caves, indoors, etc.). See null zone section down below.
- For troubleshooting/performance, see that section at the very bottom of this document.

Prefab Setup:
- Drag the Prefab/WeatherMakerPrefab (or WeatherMakerPrefab2D for 2D) into your first scene. Call DontDestroyOnLoad on the root game object. This object can be deactivated if you don't need Weather Maker for certain scenes.
- *NEW* Add any additional allow cameras that you want weather maker to render in. See WeatherMakerScript at root of prefab object. Default is to allow the main camera.
- If you want global/random weather, you can activate the GlobalWeatherZone object underneath the WeatherMakerPrefab object. See the weather zone tutorial video below.
- Set the manager interfaces on WeatherMakerScript to your own scripts if you want to provide your own manager / rendering of precipitation, clouds, fog, wind, etc.
- By default the prefab contains a sun (and moon for 3D). If you want additional celestial objects, add WeatherMakerCelestialObjectScript to your directional lights.
- Customize and properties on the sun and moon such as base light intensity, etc.
- You can deactivate pieces that you don't need, but you must at a minimum enable the root prefab, audio manager, day night cycle and light manager. You can set the day night profile day and night speed to 0 if you don't want dynamic time of day.
- If you want a simple test GUI, drag WeatherMakerConfigurationCanvasPrefab into the root of your scene. Be careful if you are using another canvas as they might conflict with each other.

Player Setup:
- Add MainCamera tag to your main camera. Unity does this by default, but you should double check this.
- Make the main camera a child of a Player object with a Player tag. Put your first person controller, etc. scripts on this parent object.
- Ensure the main camera object has an audio listener component that is enabled.
- Add a kinematic rigid body to the main camera object.
- Add a tiny sphere collider (radius of 0.001) to the camera object and make sure the 'trigger' checkbox is selected. This ensures that OnTriggerEnter is properly called in Weather Maker scripts.
- Add a WeatherMakerSoundZoneScript to your main camera if you want to use sound zones (ambient sound).
- For network players, please keep the main camera and audio listener components, but make sure they are disabled. These components are used to detect a player object versus some other object. Unity Network network identity script can tell you if the object is a local player or not. If not local, disable the audio listener and camera.
- The Player prefab object is setup like this if you need an example (Demo/DemoResources/Player.prefab).

Workflow
--------------------------------------------------
Weather Maker is built on scriptable object profiles. Most profiles are cloned upon running / playing to avoid accidental changes.

To change a profile during play mode, press play and then drag the profile in from the project view to the inspector and configure the profile as you like.

Materials work in a similar way. For example, water clones the material upon play to avoid accidental changes to the original material. You can drag a water material onto the water script during play mode to modify the original material.

Tutorial Videos
--------------------------------------------------
- New Weather Maker 4 Videos:
	- Complete Setup Guide: https://youtu.be/DHNnS6f85rM
	- Quick Start Guide: https://youtu.be/5IACGZULiDw
	- New Prefab Overview: https://youtu.be/hWJF5v0s4gc
	- Weather Zones: https://youtu.be/11QoMD_qhHw
	- Null Zones: https://youtu.be/ZPBum2YcgB8

- Overlays
    - Full Screen Snow: https://www.youtube.com/watch?v=b5j2wVHVxq0

- Water
    - Full Overview: https://www.youtube.com/watch?v=oAQ4UFxa-X0

- Fog
    - Full Overview: https://www.youtube.com/watch?v=k-dC2EPd4no
    - Fog Shadow Map Lighting: https://www.youtube.com/watch?v=PTIC1oQzxno
    - Volumetric Lighting and Fog: https://www.youtube.com/watch?v=D9MUloqUQjU
    - Older Fog Videos
        - Full Screen Fog: https://www.youtube.com/watch?v=1_w9C8hWTXw
        - Fog Volumes: https://www.youtube.com/watch?v=jJ_tx0Vog0o

- Sound
    - Scene / Ambient Sounds: https://www.youtube.com/watch?v=LdnALY4eCU4

- Sky
    - Setup: https://www.youtube.com/watch?v=QE3VZHWkVec
    - Clouds: https://www.youtube.com/watch?v=1YM1Z7ap0FU
    - Procedural Sky: https://www.youtube.com/watch?v=sB7U-yz-i6k
    - Suns and Moons: https://www.youtube.com/watch?v=neVZMeljYIQ
    - Day/Night Cycle: https://www.youtube.com/watch?v=M6PTyr52a00

- Precipitation
    - Rain Inside: https://www.youtube.com/watch?v=zFT2KVoR3ro (deprecated, use null zone instead)
    - Ripple effect: https://www.youtube.com/watch?v=7V1ykljE9N8

- Older Videos
    - 3D Demo: https://www.youtube.com/watch?v=25XEdmHFXQY
    - 2D Demo: https://www.youtube.com/watch?v=oX0Sa2IC2D4
    - Multiple Cameras: https://www.youtube.com/watch?v=6y5U37p4RpE

Weather Zones
--------------------------------------------------
New in Weather Maker 4.0.0 are weather zones. These allow different types of weather mapped to a collider. Combined with the new post processing stack v2, you can create some amazing effects.

Weather zones require a collider. I would suggest to make a child object of your collider object. Select the game object, right click and add an empty game object as a child. Then add a collider. Finally click Unity menu -> component -> weather maker -> weather zone.

Now you can setup a group profile (for random weather, i.e. temperate or snow) or you can simply assign a single weather profile for a static weather type.

If you are using post processing, create a new weather layer and assign it to the weather zone, and make sure your post processing layer has this layer set in the mask.

Weather zones require that an audio listener be attached to the camera game object, along with a tiny trigger collider (use a sphere trigger collider with radius 0.001). For networked, non-local players, simply disable the camera and the audio listener components (do not delete them).

Null Zones
--------------------------------------------------
Sometimes you don't want precipitation, fog, snow overlay and water fog to render in certain areas.

Let's say you have an open building, cave or other structure in your scene. You don't want the rain, ripples, fog, snow overlay, etc. rendering in this area - great time to add a null zone script and box collider.

Only box collider is supported at this time. Null zones can be scaled and rotated. You can use the null zone mask to determine what types of things to not render.

Let's say you want the snow overlay, but you don't want it to appear on the players hands, armor or weapon, horse, etc. Put a null zone around those objects and change the mask to only block the overlay, leaving precipitation, fog and water to render around it.

Use the NullZoneFade property to control how rendering happens near the edges of null zones. Move this to the max value (100) to disable the fade completely. Lower values fade more.

If null zone fade is <= 0 then special overlay handling will be done. As the camera nears the zone, overlay in the zone will fade out. This is most useful for open buildings. The speed of fade out is determined by abs(fade). Precipitation and fog will use abs(fade) with normal fade handling.

In order to customize the null zone, you will need to create a null zone profile. Right click in project, Weather Maker -> Null Zone Profile. Then assign the profile to your null zone script.

Dampening Zones
--------------------------------------------------
The WeatherMakerDampeningZone script can be used to reduce precipitation intensity, sound volume and light intensity when the player has moved into the collider area.

You can use the built in prefabs (WeatherMakerDampeningZone or WeatherMakerNullZoneClosed), or build your own. Ensure that a collider is added and markets as a trigger, and that the main camera has an audio listener and a tiny collider marked as trigger (a sphere collider with 0.001 radius).

Whenever the trigger is entered by an object with an active audio listener, the new dampening values are smoothly transitioned to from the current values. When the trigger is exited, the dampening values smoothly go back to 1.

Precipitation
--------------------------------------------------
Weather Maker comes with 4 precipitation types: rain, snow, hail and sleet. Each are very similar in their setup, but contain different material, textures and parameters.

All the precipitation scripts derive from WeatherMakerFallingParticleScript. Each has the concept of four stages: none, light, medium and heavy.

Precipitation objects are underneath the WeatherMakerPrefab object.

You can use a custom precipitation prefab / script. Set your precipitation profile to use custom precipitation and ensure you have assigned the custom precipitation scripts:
WeatherMakerScript.Instance.PrecipitationManager.CustomPrecipitationScript = yourCustomPrecipitationScript;

Properties:
- Loop Source Light, Medium and Heavy: The audio source to play as the prefab changes to different stages. Each sound fades in and out nicely.
- Sound Intensity Threshold: Change at what point the intensity will go to a new stage. Intensity of 0 is always the none stage.
- Intensity: Change the overall intensity of the precipitation.
- Intensity Multiplier: Change the intensity even more - watch out for performance problems if you go above 1.
- Secondary Intensity Multiplier: Change the secondary intensity even more - watch out for performance problems if you go above 1.
- Mist Intensity Multiplier: Make the mist less or more intense - again watch out for performance problems if you go above 1.
- Base Emission Rate: Base number of particles to emit per second
- Base Emission Rate Secondary: Base number of secondary particles to emit per second
- Base Emission Rate Mist: Base number of mist particles to emit per second
- Particle System: The main particle system.
- Particle System Secondary: The secondary particle system, if available
- Mist Particle System: The mist particle system.
- Explosion Particle System: Only used in 2D. For 3D, the explosion particle system is a child object of the particle system.
- Secondary Threshold: Once the intensity gets higher than this, secondary particles (if available) start to appear.
- Mist Threshold: Once the intensity gets higher than this, mist starts to appear.

3D Properties:
- IsFirstPerson: True if the precipitation will anchor around each rendered camera, false if it will be static (i.e. precipitation zone).
- Height: The down-pour particles will start at this height from the camera.
- Forward Offset: Offset the particle system this many world units in front of the camera.
- SecondaryHeight: Secondary particles will start at this height from the camera.
- SecondaryForwardOffset: Offset secondary particles this many world units in front of the camera.
- Mist Height: How high the mist will start falling from.
- For collisions, the weather maker prefab itself has a collisions property.
- Ripples:
	- Rain and sleet allow an animated ripple texture. Set AnimatedTextureRendererIntensityThreshold to be the full intensity where this should start showing up.
	- Set AnimatedTextureRendererPositionOffset to determine where the plane for the ripples offsets from the hit point closest underneath the camera.
	- Ripple effect will turn off if a collider is hit above the camera, i.e. the camera is indoors.

2D Properties:
- Height Multiplier: Particles will start at y value of the screen height + (world height * value). A value of 0.15 would make the particles start 15% higher than the screen height.
- Width Multiplier: The particle field will be this much wider than the screen width.
- Collision Mask: What should the particles collide with? The weather maker prefab can control this value globally so don't change this.
- Collision Life Time: About how long particle should live when they collide.
- Explosion Emission Life Time Maximum: When particles collide and have a life time higher than this value, they may emit an explosion.
- Mist Collision Velocity Multiplier: The mist speed is multiplied by this value whenever it collides with something.
- Mist Collision Life Time Multiplier: The mist life time is multiplied by this value whenever it collides with something.

Some snow precipitation particles uses local simulation space. Snow is tricky because if you use world space, the player can move fast enough to out run the snow if it is falling slowly. But you can set the paticle systems to world space and try your luck. Set all to local or world depending on speed of player and situation.

Weather Manager
--------------------------------------------------
The weather manager was replaced in Weather Maker 4.0.0 with weather zones. On the WeatherMakerPrefab is a GlobalWeatherZone object. Simply replace the profile on this object with any weather profile group to change the type of weather for the entire game. Additional weather zones with different weather group profiles may be added throughout your game that override this global weather.

Precipitation Zones
--------------------------------------------------
See DemoScenePrecipitationZones. These allow static precipitation that does not move. You will most likely need to tune the particle emission properties, emission shape and size, and probably the sound settings to work for the scale and look of your scene and game.

The properties on the precipitation zone prefabs are identical to the first person precipitation objects in the Weather Maker prefab, with some tweaks and IsFirstPerson is set to false.

Full Screen Overlay Effect
--------------------------------------------------
WeatherMakerFullScreenOverlayScript.cs implements a full screen overlay effect. This will cause an overlay on the entire world, using the normal y values.

This effect is highly customizable, please review the tutorial video (link at top of this file) and all properties of the script for full details.

This effect can link up to the snow intensity. Set AutoIntensityMultiplier on WeatherMakerPrefab -> Full Screen Effects -> Snow -> Auto Intensity Multiplier to desired value.

Full screen overlay looks best with deferred shading.

If your grass looks funny with the snow overlay, you can enable the grass override shaders. Choose one of the WeatherMakerWavingGrass* shaders and swap the top line to the Unity namespace. Then in your terrain select the details section and click refresh.

Virtual Reality
--------------------------------------------------
Weather Maker supports VR. For best performance, ensure that the stereo rendering mode is single pass (fast). Unity menu -> edit -> player -> other settings -> XR settings -> stereo rendering method.

Multi-pass, single pass and single pass instanced / multi-view are all supported. For single pass instanced / multi-view, please use Unity 2018.2 or newer.

Audio / Sound Volume Modifier
--------------------------------------------------
WeatherMakerAudioManagerScript.cs contains a VolumeModifierDictionary that determines the final volumes for sound.

Wind
--------------------------------------------------
New in Weather Maker 4.0.0 - use a wind profile. This is now a property on the wind script, which has all the same properties you are used to.

The wind script allows you to have wind randomly blow in your scene, which will affect the rain, snow, mist, etc. The WindScript is where the wind profile is set.

To enable or disable wind, set the WindIntensity property on WeatherMakerWindScript.

Wind affects fog velocity. This can be disabled by setting FogVelocityMultiplier to 0 on the wind script.

Wind direction is set either randomly, or using the transform of the Wind object. To disable random wind direction, set the WindMaximumChangeRotation property on the WeatherMakerWindScript to zeroes.

Please see the properties in WeatherMakerWindScript.cs (wind profile) for a full list of what is available. Each property has a tooltip description that explains the property.

Sun
--------------------------------------------------
The weather maker light manager contains a Sun object. This object should stay enabled. It's also very important that the sun intensity not be changed by anything external to the Weather Maker scripts, otherwise artifacts may occur.

If you need to change the sun intensity, the day night cycle script has a DirectionalLightIntensityMultipliers property which is a dictionary of a key and mutliplier that will affect sun and moon light intensity.

Although the light manager has a Suns array, only one sun is currently supported. Multiple suns may be supported in the future.

The sun must not be deactivated.

Moon
--------------------------------------------------
Earths moon is on by default in 3D mode. I don't have it always facing the right way, but it still looks pretty good. Accurate moon phases for the lat, lon, date and time are included.

Moon phase increases moon lighting intensity as well.

The moon is a directional light. Moon base intensity is set on the day night script. Moon lighting power and tint color, etc. is set on the sky sphere script.

Multiple moons are supported using the Moons property of WeatherMakerLightManagerScript.

You can deactivate the moon object if you don't want moons.

Clouds
--------------------------------------------------
In 3D, clouds are created using the cloud script. In 2D, clouds are created using the LegacyCloudScript2D. See CloudToggleChanged in WeatherMakerConfigurationScript.cs for how to set clouds.

3D clouds used to be run on the sky sphere. This has changed and they are now a full screen command buffer using cloud profiles, which will allow better performance and much nicer looking clouds in the future. Wherever you see sky sphere cloud properties being referenced, simply refer to the same properties in the cloud profile.

The cloud script now uses a cloud profile as of Weather Maker 3.0, all the cloud properties are in the cloud profile scriptable object and cloud layer profiles.

Cloud Shadows:
Cloud shadows were removed due to performance issue. I am looking at a more performant way to do cloud shadows. Stay tuned.

For 2D clouds, set up and play and test your cloud with orthographic size 4. Once they look correct, then you can change the orthographic size and they will adapt.

Lightning
--------------------------------------------------
- Located in WeatherMakerPrefab/ThunderAndLightningPrefab and WeatherMakerPrefab/ThunderAndLightningPrefab/LightningBoltPrefab.
- I've included the core of my Procedural Lightning asset (http://u3d.as/f1c) to power Weather Maker lightning.

ThunderAndLightningPrefab Setup
Ideally this script will work as is. Lightning will be created randomly in a hemisphere around the main camera. Lightning can also be forced visible, which means the script will try to make the bolt appear in the camera field of view.

Lightning light effects are less visible during the day and brighter at night. For best results, ensure that you create clouds before turning the lightning on.

This script has the concept of "Intense" vs. "Normal" lightning. Intense lightning will be created close to the player, be brighter and play a random intense sound very soon after the lightning strike, which will be loud. Normal lightning is further away, plays quieter sounds and those sounds take longer before playing.

WeatherMakerThunderAndLightning Properties:
- Lightning Bolt Script: The lightning bolt script used to generate the lightning. Leave as the default.
- Camera: The camera lightning should be created around. Default is the main camera.
- Lightning Interval Time Range: Random range in seconds between lightning.
- Lightning Intense Probability: Percent change that lightning will be intense (close and loud).
- Thunder Sounds Normal: List of sounds for normal lightning.
- Thunder Sounds Intense: List of sounds for intense lightning.
- Start Y Base: The base y value for lightning to start at.
- Start X Variance: Vary the x start position
- Start Y Variance: Vary the y start position
- Start Z Variance: Vary the z start position
- End X Variance: Vary the x end position
- End Y Variance: Vary the y end position. Lightning will ray-trace to the ground, so the end position may change.
- End Z Variance: Vary the z end position.
- Lightning forced visibility probability: The chance that the lightning bolt will attempt to be visible in the camera.
- Ground lightning chance: The chance that lightning will strike the ground.
- Cloud lightning chance: The chance that lightning will only be visible in the clouds.
- Sun: Used to lessen the lightning brightness during the day.
- Normal Distance: Force lightning away from the camera by this range of distance for normal lightning.
- Intense Distance: Force lightning away from the camera by this range of distance for intense lightning.
- *Note lightning will always be at least normal or intense distance minimum distance from the camera, regardless of Start / End variance settings.

Here are the properties you are most likely to want to change on LightningBoltPrefab (WeatherMakerLightningBoltPrefabScript):
- Duration Range: Range of how long, in seconds, that each lightning bolt will be displayed.
- Trunk width range: Range of possible width, in world units, of the trunk.
- Glow tint color: Change the outer color of the lightning.
- Generations: Change how many line segments the lightning has.
- Glow Intensity: How bright the glow is.
- Glow Width Multiplier: How wide the glow is.
- Lights: To turn off lights, set LightPercent to 0.

To get notified of lightning bolt start and end events, use WeatherMakerThunderAndLightningScript.Instance.LightningStartedCallback and WeatherMakerThunderAndLightningScript.Instance.LightningEndedCallback.
To get notified of thunder audio events, see WeatherMakerThunderAndLightningScript.Instance.ThunderSoundPlayed.

Sky Sphere
--------------------------------------------------
- Located in WeatherMakerPrefab/SkySphere.
- Not used in 2D mode, for 2D see the Sky Plane section.
- If you see any edges in the sky, increase the resolution property.
- Uses WeatherMakerSkyProfileScript.cs for the profile.

Sun / Moon:
- Celestial bodies are managed on WeatherScript, using the Suns and Moons properties. Only 1 sun is supported. Up to 8 moons are supported. Set the lighting properties on these scripts (Sun/Moons properties of WeatherMakerLightManagerScript.cs), do not modify the Light object itself as it will get overwritten by the Weather Maker scripts. Orbit defaults to Earth based orbit, but can also be set to a custom orbit (see WeatherMakerLightManagerScript.cs, OrbitTypeCustomScript property).
- Sun is rendererd with it's own mesh now, look for it in the prefab, just search for the Sun object.

SkyMode:
- Procedural: Sky is fully procedural and day and dawn dusk sky sphere textures are ignored. Night texture is used as the sun goes below the horizon.
- Procedural Preetham: A slightly different lighting model, the sunset / sunrise look a little more vibrant, sun is more scattered.
- Procedural Textured: Default, blends a procedural sky with the textures you specify. Your day and dawn/dusk textures should contain transparent areas with translucent clouds, make sure the import settings for the textures allows transparency. Night texture should still be opaque. The night texture will be hidden by any areas of the dawn/dusk texture that are opaque.
- Procedural Textured Preetham: Same as procedural textured, but with preetham lighting.
- Textured: Sky is fully textured and not procedural. If you need to convert a cubemap to a sphere/panorama map, try this Google search: https://www.google.com/search?q=unity+cubemap+to+panorama&oq=unity+cubemap+to+pano&aqs=chrome.1.69i57j0.11805j0j4&sourceid=chrome&ie=UTF-8#q=unity+cubemap+to+equirectangular.
- Note: Setting the player color space to linear may give a more Earth-like sky color for procedural modes. Procedural Preetham mode doesn't need very many sky vertices.

Texture Modes:
- If you are using SkyMode "Textured" or "Procedural Textured", there are texture options:
- Set texture type to "Advanced". Then disable all settings or set to defaults. Then set wrap mode to clamp, filter mode to bilinear, aniso level 1, set max size to appropriate value and format to automatic truecolor for best appearance.
- Sphere: Texture should be about 2:1 aspect ratio. Top half is upper part (sky), bottom half is the ground.
- Panorama: Entire texture is the upper half of the sky sphere only. Great for higher resolution sky when the player won't ever look below the horizon.
- Panorama Mirror Down: Same as Panorama, except that the texture mirrors down to the bottom half of the sky sphere.
- Dome: Texture maps such that the center of the texture is the top of the sky sphere, and the edges of the circle are the horizon. This produces the best looking sky but requires pre-processing of the texture before importing into Unity.
- Dome Mirror Down: Same as dome except that the texture mirros down to the bottom half of the sky sphere.
- Dome Double: Same as dome except the texture contains two domes. The left half is the bottom dome, the right half is the top dome.
- Fish Eye Mirrored: Maps the fish eye to the front of the sky sphere and mirrors it to the back. Not suitable for 360 degree viewing.
- Fish Eye 360: Maps the fish eye to the entire sky sphere. There is a slight distortion at one end of the sky sphere so this is not suitable for full 360 degree viewing.
- *NOTE* If you will be using the procedural sky option, you can null out the day and dawn/dusk texture properties to save some disk space.
All sky sphere modes come with example textures (WeatherMaker/Prefab/Textures/SkySphere).

Night Sky:
- Night sky intensity can be changed via script parameter on the sky sphere script.
- NightVisibilityThreshold controls which pixels are visible. For a city or high light pollution scene, you could raise this value so only bright stars are visible.
- The night sky stars twinkle by default. There are several parameters that control how the sky twinkles. See the night sky twinkle section in the inspector of the sky sphere script. You can turn off the twinkle by setting the randomness and twinkle variance to 0.

Rotation:
- Sky sphere can be rotated with day/night cycle by setting rotation axis to non-zero. Requires procedural (non-textured) sky mode. There is no performance overhead, the night sky textures are NOT cubemaps.

Sky Plane
--------------------------------------------------
In 2D, a Sky Plane is used for procedural sky. Most parameters are the same as the sky sphere.

The Sky Plane renders in the default sorting queue at int.MinValue.

See DemoScene2D for an example.

Day Night Cycle Manager
--------------------------------------------------
WeatherMakerDayNightCycleManagerScript.cs contains full sun, moons and ambient color capabilities. This script uses a profile (WeatherMakerDayNightCycleProfileScript.cs) to manager settings.

Speed - The speed of the cycle during the day. Negative values are allowed. A value of 1 matches real time.
NightSpeed - The speed of the cycle at night. Negative values are allowed, but should match the sign of the Speed parameter. A value of 1 matches real time.
UpdateInterval - How often (in seconds) the cycle updates. 0 is the default which is every frame. Increase this if you are seeing flickering shadows, etc.
TimeOfDay - The time of day in local time, in seconds.
Year - the current year, this is currently only used for sun positioning.
Month - the current month, this is currently only used for sun positioning.
Day - the current day of month, this is currently only used for sun positioning.
TimeZoneOffsetSeconds - Used to convert TimeOfDay to UTC time. You should look this up once and set it based on your longitude, year, month and day. Set to -1111 for auto-detect. During editor mode, -1111 will cause a web service query to get you the right timezone for you location and date.
Latitude - Latitude on the planet in degrees (0 - 90)
Longitude - Longitude on the planet in decimal degrees (-180 to 180)
AxisTilt - The tilt of the planet in degrees (earth is about 23.439 degrees)
RotateYDegrees - Rotate around the up vector, useful for something besides an East/West cycle
DayDawnDuskNightGradient - Determines when it is day, dawn or dusk, or night. Green = day, red = dawn/dusk, blue = night. Center of gradient is sun at horizon.
SunIntensityGradient - Allow setting sun intensity multiplier, where center of gradient is sun at horizon.
SunShadowStrengthGradient - Allow setting sun shadow strength multiplier, where center of gradient is sun at horizon.

Ambient Colors:
- Day, dusk and night ambient colors and intensities are confiurable in the day/night script.

Ambient Sounds / Weather Sounds
--------------------------------------------------
You can create any number of sounds to play during dawn, day, dusk and night or even particular hours in the day and/or in zones. Weather Maker uses scriptable objects to allow you to setup a sound profile.

Right click in the project window and select create -> Weather Maker -> Sound Group, and name your profile. Then do the same and create Sound objects for each type of sound you want. In the sound you can set the audio clip, whether it loops, interval, duration and fade time. See WeatherMakerSoundScript.cs for more details.

When you are ready to add your sound groups to Weather Maker, simply drag in WeatherMakerSoundZone prefab into your scene. If the sounds will be active in the whole scene, put the prefab inside your player object (so the trigger will always be entered), otherwise find a nice place in your scene for the particular sounds in the group you created.

The sounds are not meant to be 3D and will have the chance to play as long as the trigger zone has been entered.

To debug sounds, uncomment the first line in WeatherMakerSoundScript.cs which will log start / stop sounds to the console.

As always, please watch the sound tutorial in the tutorial list at the top of this file.

You can add a sound zone script to your main camera, add a kinematic rigid body and tiny collider to have the sound zone follow the player. Ensure that the camera is a child of another game object with a collider that contains it. See Player prefab for setup.

Sound zones can be nested, but should never have more than two sound zones overlap. Sound zones should use 2D sound. If you want ambient sounds in 3D space, use AudioSource with 3D sound properties and sprinkler game objects around your scene.

Fog
--------------------------------------------------
Fog is only supported in 3D non-orthographic currently. Turn fog on and off by calling WeatherMakerFullScreenFogScript.Instance.TransitionFogDensity(fromIntensity, toIntensity, transitionSeconds). Ensure you have a fog profile set.

Fog Details:
- Highly performant and very configurable.
- Play around with the noise settings, density and fog types to get the look you want.
- You can set the fog height for ground fog.
- The noise scale, noise adder and noise multiplier will determine the variance and appearance of the fog. Please set these to appropriate values for the scale and feel of your game.
- *NOTE*: Fog noise height and warping has been removed in favor of true 3D fog noise. Set the fog adder property into the negatives to get a more varied fog appearance with holes.
- *NOTE*: For fog noise to work properly, it is important that the WeatherMakerLightManagerScript 'NoiseTexture3D' property is set. If you don't need fog noise, you can null out this property and save a few MB of disk space.
- FogNoiseSampleCount defines how many samples are taken for fog noise. You may need to adjust this for your platform, especially if you are targetting mobile devices.
- Fog contains shadow map capability. If fog shadow sample count is > 0, fog shadows will be used for sun only. Be careful about performance, and tune the settings. Watch the tutorial (see link at top) for best results.
- For full screen fog, a sun shaft sample count > 0 will add sun shafts. Tweak sample count and other parameters to your liking. 32 is a good value I have found.
- Tweak the dithering level if you see banding in low density fog.
- If you must use billboard trees (please don't though) but if you must, you can enable the full screen fog aware tree billboard shader by modifying WeatherMakerTreeBillboardShader.shader (see top of that file).
- Please watch the tutorial videos (at the top of this readme file). It covers most parameters.
- Email support@digitalruby.com with questions.

If you are seeing rendering artifacts, try changing the FogRenderQueue of the WeatherMakerFullScreenFogScript.cs in the inspector. It's at the bottom in the full screen settings.

A volumetric fog sphere and fog cube prefab is available to try out, and are in the DemoScene under the world object, but are deactivated by default. The fog sphere and cube require a WeatherMakerPrefab be in your scene and setup properly.

Volumetric Lights:
Point and spot lights can be enabled in the fog by setting EnableFogLights to true on WeatherMakerScript. Lights must be added to the light manager (please see the light manager section). The easiest way is to add your lights to the light manager script 'AutoAddLights' list.

Please test that performance is adequate before shipping your game with this turned on. The demo scene is setup automatically to add the flash light, point light and a spot light. Volumetric lights work best in Linear color space.

Water
--------------------------------------------------
A water prefab is included. Water now uses water profiles (see water profile property of WeatherMakerWaterScript).

Water has two rendering modes - one pass and forward base plus add. In one pass, all lights are rendered in a single draw call (huge performance boost for mobile and VR). In forward base plus add, the water uses one draw call per light.

Water fog can be configured to give water density and reduce light. If you are going underwater, you will want to make sure you set this up to look right for your water.

Water material inv fade parameter x value can be set to less than 100 to fade the shore, but this will make refraction have artifacts. Set to more than 100 if you prefer to have refraction look 100% correct and can deal with a harder shore line.

Water material inv fade parameter y value controls how normals fade out as camera is higher above water

Water material inv fade parameter z value controls reflection strength.

Water material inv fade parameter w value controls how normals fade out as water vertex is further away from the camera.

Water has a sparkle mode. This is setup on the clear water material. You can turn off sparkles by setting the _SparkleScale.w to 0 on the water material.

Water caustics are also configurable, see water material caustics section.

Up to eight waves can be configured for the water using the WaterWave1 - WaterWave8 parameters: x and y are wave direction, z is wave amplitude and w is wave length. Set all to 0 for no wave.

Each wave has extra parameters, x = speed, y = height reducer (how much smaller height reduces the wave).

Wave heights and water fade are controlled by a water height depth map. Shorter depths to the floor of the water volume result in more fade and smaller waves (this is configurable). The water prefab uses WeatherMakerDepthCameraScript to snapshot this texture once. You can configure which layers are included in the depth map. You should only include mesh terrain, Unity terrain or other static volumes that represent the water volume, do not include boats and other dynamic object layers. Set the height parameter if you have mountains or other higher volumes above your water that do not have a floor inside (if the camera is inside a mountain for example, it will get max depth). Set Direty to true if you have changed the static water volume and it will recompute the depth map once, as this requires a re-render of the depth map (expensive).

The water profile has an option to allow wind to affect the waves. If this is enabled, there will be no waves unless there is wind.

Water foam can be configured via the water foam properties. You can set scale, intensity, depth fade (more foam in smaller depth) and wave factor (more foam on waves), along with foam velocity and specular reduction.

Underwater mode is supported. For Unity 2018.2+ you can add a post processing layer to your camera object and a post processing volume to the water object to further customize the apperance. Color grading and depth of field really add extra pop.

Water has tesselated and non-tesselated modes. For tesselated water, you can tweak TesselationParams x to control number of vertices, y should be set to max displacement (waves) for proper culling.

Displacement options are also available for tesselated water to add finer detailed waves.

I would suggest to keep your water at least 2 world units below the flat ground around the water as the water null zone can fade up through the ground. Or you can change the water null zone profile fade to be higher values.

Volumetric light and shadows for water will be returning in a future version once performance is acceptable.

Orthographic Size
--------------------------------------------------
For 2D Weather Maker, clouds and lightning might need a little tweaking, depending on your orthographic size. Please be sure to set the cloud anchor offset along with the lightning trunk width and light range to appropriate values for your orthographic size.

Light Manager
--------------------------------------------------
Weather Maker contains a Light Manager script. This script can keep track of the lights you want to use in the various Weather Maker shaders such as fog, clouds, etc. in WeatherMakerLightManagerScript.cs, SetLightsToShader sets up all the shader parameters for the lights in world space. These are set as global shader variables, so you can use them in your own shaders if you like.

The light manager automatically adds all sun, moon and lightning lights, you do not need to do this yourself.

The light manager can auto-find all lights in your scene, but this may be a performance problem, so if it is, you must manually add and remove lights that you want to be used for cloud and fog lighting, etc. or add them to the AutoAddLights list.

Real-time area lights are supported. You can turn this off by setting the area light quadratic attenuation to 0.

Area lights use the lossy scale of the light for the area size, since area size is an editor only property.

The light manager contains two dictionaries to modify directional light intensity and shadow strength. If you need to temporarily change the intensity of directional lights, this is a good place to do it.

Shaders
--------------------------------------------------
Weather Maker contains a number of shaders. Some of the global shader variables may be useful to you if you have your own customer shaders. See WeatherMakerShader.cginc for a list of the globals and information about them.

Integrations
--------------------------------------------------
If you are integrating Weather Maker into your own asset, use a #if WEATHER_MAKER_PRESENT ... #endif around your code.

Weather Maker has integration with some other assets. Add via Component -> Weather Maker -> Extensions -> ...
If you do not have the correct asset or define in the project, these scripts might become invisible.
- Vegetation Studio Pro
	- You can customize snow and rain buildup / melt speeds.
- UNET (Unity Networking)
	- Nothing to customize.
- AQUAS - water asset (deprecated)
	- *NOTE* Weather Maker now has water built in and it is fully integrated with Weather Maker lights - even area lights! No need for another water asset.
	- You must define AQUAS_PRESENT under player settings -> other settings -> scripting define symbols.
	- If you are using fog, set the full screen fog render queue to after forward alpha. AQUAS water does not work if it renders before the transparent queue, so this is currently the only workaround.
	- You can set cloud specular and reflection reduction on the AQUAS integration script.
- Uber - standard shader ultra
	- You must define UBER_STANDARD_SHADER_ULTRA_PRESENT under player settings -> other settings -> scripting define symbols.
	- Add an UBER_GlobalParams script somewhere in your scene and turn off the "User Particle System" option.
	- Configure global params to get the effect you want.
	- Set the minimum water level and minimum wetness on the WeatherMakerExtensionUberScript on the Weather Maker prefab -> extensions object.
	- Weather Maker will set RainIntensity, WaterLevel, WetnessAmount and SnowLevel automatically.
- RTP - Relief Terrain Pack
	- You must define RELIEF_TERRAIN_PACK_PRESENT under player settings -> other settings -> scripting define symbols.
	- Weather maker will set wetness and snow.
- CTS (Complete Terrain Shader):
	- Weather Maker will set the rain and snow on the terrain when there is precipitation and set the season based on latitude/longitude/date/time.
	- You can control which of these features are on.
- Gaia
	- In the Gaia manager under the GX tab, Digital Ruby, LLC -> Weather Maker are a number of useful options including setting location, moon and/or time of day. This is only available in the Unity editor.

Performance Considerations
--------------------------------------------------
Here is a list of things to try if performance is not adequate:

- Lower the emission value of the particle systems, especially snow, which is the most CPU intensive.
- Turn off mist by raising the mist threshold to 1.
- Turn off per pixel lighting by setting WeatherMakerScript.PerPixelLighting to false.
- Set EnableFogLights to false on the fog scripts (disables volumetric light).
- Turn off collisions for particles (CollisionEnabled) property of the WeatherMakerPrefab object.
- Reduce lightning generations and turn off lights (WeatherMakerPrafab/Precipitation/ThunderAndLightning). Turn off lightning glow (set glow intensity to 0).
- Turn off soft particles in quality settings. This will cause hard edges, so it's a trade-off.
- Double check that your terrain and collidable objects are setup as efficient as possible. For example, very large terrain can cause performance issues. Use a collision plane if possible.
- Reduce the MaximumLightCount constant in WeatherMakerLightManagerScript.cs if GPU is pegged and you have many lights in your scene.
- Turn off CheckForEclipse on the sky sphere if you are seeing CPU spikes. These can be caused by a Unity bug.
- Reduce null zone count.
- Turn off sun shafts (set sample count to 0 on full screen fog script), or reduce sun shaft sample count and reduce sun shaft down sampling value.
- Change render scale of full screen effects to 0.5 or even 0.25.

Troubleshooting / FAQ
--------------------------------------------------
- When your mouse leaves Unity and comes back or you unfocus the editor, the sky might go black. To fix, deactivate and reactivate the weather maker prefab. Unity command buffer bug is responsible. They have been notified and are aware of the bug.
- If getting script or shader errors with Weather Maker files, delete scripts and shaders folders and re-import just those folders from the asset.
- Ensure you are using the latest supported Unity version - 5.6.6+.
- If rain, snow, etc. is flying up instead of down, double check all the velocity over time values on the particle systems. Everything except the explosions should have negative y values.
- Fog is not showing or is all white - Double check that the WeatherMakerPrefab is setup in your scene properly and the Sun object is enabled.
- If you see shadow flickering, try adding some wind to vary the trees up a bit or increase the day CelestialObjectRotationUpdateInterval value on the day night script. For the fog, consider disabling shadows if it is enabled, or lowering the shadow map resolution in quality settings.
- The Unity post processing stack is highly recommended to cleanup any additional banding or aliasing, etc. Temporal anti-alising really helps, along with the right level of bloom.
- I see weird depth buffer issues at night with particle systems: Try setting the dest blend mode of the mist particle systems to 1 (add) if you have a very dark / night scene.
- Trees get covered by fog or are in front of fog: Tree billboards need to have WeatherMakerTreeBillboardShader enabled (see top of that file for instructions).
- Sun shafts and other effects aren't working in player: Make sure scene tab isn't showing, hide the tab. Not sure why this causes problems but until I figure it out this is the fix.
- For ultimate survival or other custom camera assets, try tweaking the clear flags or culling mask if you see display glitches.
- Shader errors? Try deleting the shader cache folder, restarting machine.
- Reflection probes - make sure to not use box projection, this is not supported. Set mode to realtime as well if you want to show moving clouds, lightning, etc.
- RenderToCubemap doesn't work - set WeatherMakerCommandBufferManagerScript.CubemapCamera to your camera, call RenderToCubemap, then set WeatherMakerCommandBufferManagerScript.CubemapCamera back to null.

Known Issues
--------------------------------------------------
- Sky sphere may have some slight distortion at the poles when using sphere or panorama mode. This is easily fixed by using dome or double dome mode, or by correcting the texture.
- Fish Eye 360 has some distortion at the side pole of the sphere. I have as of yet been unable to fix this. I welcome suggestions and feedback on how to fix this.
- Sun can shine through the bottom as it dips below the horizon. Fix this by adding a large shadow casting cube as the base of your world. Find the LargeGroundAndSunHorizonBlocker object in the demo scene for an example.
- It is recommended to disable Odin serialization for Weather Maker, as this has some weird bugs.

Wrap Up
--------------------------------------------------
I'm Jeff Johnson, I created Weather Maker just for you. Please email support@digitalruby.com with any feedback, bug reports or suggestions.

- Jeff

Credits:
https://catlikecoding.com/unity/tutorials/flow/looking-through-water/
http://soundbible.com/1718-Hailstorm.html
http://blenderartists.org/forum/archive/index.php/t-24038.html
https://www.binpress.com/tutorial/creating-an-octahedron-sphere/162
http://freesound.org/
http://www.orangefreesounds.com/meditation-music-for-relaxation-and-dreaming/
https://opengameart.org/content/seamless-animated-raindrop-ripples-texture
https://freesound.org/people/akemov/sounds/255597/
https://freesound.org/people/InspectorJ/sounds/398700/
