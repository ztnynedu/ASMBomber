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
    /// Interface for custom orbits
    /// </summary>
    public interface IWeatherMakerCelestialObjectCustomOrbit
    {
        /// <summary>
        /// Calculate a custom orbit for a celestial object
        /// </summary>
        /// <param name="obj">Celestial object</param>
        /// <returns>Normalized (unit) vector pointing down from the sky to origin (0,0,0) for object position in sky</returns>
        Vector3 CalculatePosition(WeatherMakerCelestialObjectScript obj);
    }

    /// <summary>
    /// Makes a directional light a celestial object
    /// </summary>
    [ExecuteInEditMode]
    [RequireComponent(typeof(Light))]
    public class WeatherMakerCelestialObjectScript : MonoBehaviour
    {
        [Tooltip("Whether this is a sun (false if moon)")]
        public bool IsSun;

        [Tooltip("Hint to have the object render in fast mode. Useful for mobile, but not all shaders support it.")]
        public bool RenderHintFast;

        [Tooltip("Rotation about y axis - changes how the celestial body orbits over the scene")]
        public float RotateYDegrees;

        [Tooltip("The orbit type. Only from Earth orbit is currently supported.")]
        public WeatherMakerOrbitType OrbitType = WeatherMakerOrbitType.FromEarth;

        [Tooltip("Script to use if OrbitType is custom, otherwise ignored.")]
        public MonoBehaviour OrbitTypeCustomScript;

        [Range(0.0f, 1.0f)]
        [Tooltip("The scale of the object. For the sun, this is shader specific. For moons, this is a percentage of camera far plane.")]
        public float Scale = 0.02f;

        [Tooltip("Light color")]
        public Color LightColor = new Color(1.0f / 254.0f, 1.0f / 255.0f, 1.0f / 201.0f, 1.0f);

        [Range(0.0f, 128.0f)]
        [Tooltip("Light power, controls how intense the light lights up the clouds, etc. near the object. Lower values reduce the radius and increase the intensity.")]
        public float LightPower = 8.0f;

        [Tooltip("The intensity of the light of the object at default (full) intensity")]
        [Range(0.0f, 3.0f)]
        public float LightBaseIntensity = 1.0f;

        [Tooltip("The shadow strength of the light of the object at default (full) shadow intensity")]
        [Range(0.0f, 1.0f)]
        public float LightBaseShadowStrength = 0.8f;

        [Range(0.0f, 3.0f)]
        [Tooltip("Light multiplier")]
        public float LightMultiplier = 1.0f;

        [Tooltip("Tint color of the object.")]
        public Color TintColor = Color.white;

        [Range(0.0f, 4.0f)]
        [Tooltip("Tint intensity")]
        public float TintIntensity = 1.0f;

        /// <summary>
        /// The light for this celestial object
        /// </summary>
        public Light Light { get; private set; }

        /// <summary>
        /// The renderer for this celestial object
        /// </summary>
        public Renderer Renderer { get; private set; }

        /// <summary>
        /// The collider for this celestial object
        /// </summary>
        public Collider Collider { get; private set; }

        /// <summary>
        /// Whether the object is active
        /// </summary>
        public bool IsActive
        {
            get { return gameObject.activeInHierarchy && Scale > 0.0f; }
        }

        /// <summary>
        /// Whether the light for this object is active. A light that is not active is not on.
        /// </summary>
        public bool LightIsActive
        {
            get { return Light != null && Light.enabled && IsActive; }
        }

        /// <summary>
        /// Whether the light is on. An active light can have a light that is off.
        /// </summary>
        public bool LightIsOn
        {
            get { return LightIsActive && Light.intensity > 0.0f && LightMultiplier > 0.0001f && Light.color.r > 0.0001f && Light.color.g > 0.0001f && Light.color.b > 0.0001f; }
        }

        /// <summary>
        /// Gets the viewport positions of the object.
        /// </summary>
        public Vector3 ViewportPosition
        {
            get; internal set;
        }

        private void UpdateInternal()
        {
            if (WeatherMakerLightManagerScript.Instance != null)
            {
                if (IsSun)
                {
                    WeatherMakerLightManagerScript.Instance.Moons.Remove(this);
                    if (!WeatherMakerLightManagerScript.Instance.Suns.Contains(this))
                    {
                        WeatherMakerLightManagerScript.Instance.Suns.Add(this);
                    }
                }
                else
                {
                    if (!WeatherMakerLightManagerScript.Instance.Moons.Contains(this))
                    {
                        WeatherMakerLightManagerScript.Instance.Moons.Add(this);
                    }
                    WeatherMakerLightManagerScript.Instance.Suns.Remove(this);
                }
            }
            Light = (Light == null ? GetComponent<Light>() : Light);
            Renderer = (Renderer == null ? GetComponent<Renderer>() : Renderer);
            Collider = (Collider == null ? GetComponent<Collider>() : Collider);
        }

        private void Awake()
        {
            UpdateInternal();
        }

        private void Update()
        {

#if UNITY_EDITOR

            UpdateInternal();

#endif

        }
    }
}
