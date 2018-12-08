//
// Weather Maker for Unity
// (c) 2016 Digital Ruby, LLC
// Source code may be used for personal or commercial projects.
// Source code may NOT be redistributed or sold.
// 
// *** A NOTE ABOUT PIRACY ***
// 
// If you got this asset off of leak forums or any other horrible evil pirate site, please consider buying it from the Unity asset store at https ://www.assetstore.unity3d.com/en/#!/content/60955?aid=1011lGnL. This asset is only legally available from the Unity Asset Store.
// 
// I'm a single indie dev supporting my family by spending hundreds and thousands of hours on this and other assets. It's very offensive, rude and just plain evil to steal when I (and many others) put so much hard work into the software.
// 
// Thank you.
//
// *** END NOTE ABOUT PIRACY ***
//

using System.Collections;
using System.Collections.Generic;

using UnityEngine;

namespace DigitalRuby.WeatherMaker
{
    /// <summary>
    /// Water rendering modes
    /// </summary>
    public enum WeatherMakerWaterRenderingMode
    {
        /// <summary>
        /// Render water in a single pass with all lights
        /// </summary>
        OnePass,

        /// <summary>
        /// Render water in a forward base + forward add pass
        /// </summary>
        ForwardBasePlusAdd
    }

    [CreateAssetMenu(fileName = "WeatherMakerWaterProfile", menuName = "WeatherMaker/Water Profile", order = 68)]
    public class WeatherMakerWaterProfileScript : ScriptableObject
    {
        [Header("Rendering")]
        [Tooltip("Water Material")]
        public Material Material;

        [Tooltip("Water rendering mode. One pass does all lights in one pass using custom shader. Underwater always uses one pass.")]
        public WeatherMakerWaterRenderingMode RenderMode = WeatherMakerWaterRenderingMode.OnePass;

        [Tooltip("Enable depth write for water surface. The depth buffer is this many units below the water. 0 for no depth write. " +
            "Turn this on if you have fog or other depth effects over deep water.")]
        [Range(0.0f, 10000.0f)]
        public float WaterDepthThreshold = 0.0f;

        [Tooltip("Whether wind affects waves")]
        public bool WindAffectsWaves = true;

        [Header("Underwater")]
        [Tooltip("Underwater audio clip (loops while underwater)")]
        public AudioClip UnderwaterAudioClip;

        [Tooltip("Splash audio clips (when entering / exiting the water)")]
        public AudioClip[] SplashAudioClips;
    }
}
