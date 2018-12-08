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
using UnityEngine.Rendering;

namespace DigitalRuby.WeatherMaker
{
    [CreateAssetMenu(fileName = "WeatherMakerFogProfile", menuName = "WeatherMaker/Fog Profile", order = 60)]
    public class WeatherMakerFogProfileScript : ScriptableObject
    {
        [Header("Fog appearance")]
        [Tooltip("Fog mode")]
        public WeatherMakerFogMode FogMode = WeatherMakerFogMode.Exponential;

        [Tooltip("Fog density")]
        [Range(0.0f, 1.0f)]
        public float FogDensity = 0.0f;

        [Tooltip("Multiply the computed fog factor by this value")]
        [Range(1.0f, 100.0f)]
        public float FogFactorMultiplier = 1.0f;

        [Tooltip("Fog color")]
        public Color FogColor = Color.white;

        [Tooltip("Fog emission color, alpha is intensity")]
        public Color FogEmissionColor = Color.black;

        [Range(0.0f, 10.0f)]
        [Tooltip("Fog light absorption - lower values absorb more light, higher values scatter and intensify light more.")]
        public float FogLightAbsorption = 1.0f;

        [Tooltip("Maximum fog factor, where 1 is the maximum allowed fog.")]
        [Range(0.0f, 1.0f)]
        public float MaxFogFactor = 1.0f;

        [Header("Fog noise")]
        [Tooltip("Fog noise scale. Lower values get less tiling. 0 to disable noise.")]
        [Range(0.0f, 1.0f)]
        public float FogNoiseScale = 0.01f;

        [Tooltip("Controls how the noise value is calculated. Negative values allow areas of no noise, higher values increase the intensity of the noise.")]
        [Range(-1.0f, 1.0f)]
        public float FogNoiseAdder = 0.0f;

        [Tooltip("How much the noise effects the fog.")]
        [Range(0.0f, 10.0f)]
        public float FogNoiseMultiplier = 0.0f;

        [Tooltip("Fog noise velocity, determines how fast the fog moves. Not all fog scripts support 3d velocity, some only support 2d velocity (x and y).")]
        public Vector3 FogNoiseVelocity = new Vector3(0.01f, 0.01f, 0.0f);
        internal Vector3 fogNoiseVelocityAccum;

        [Tooltip("Fog noise rotation speed in radians per second. W is rotation radius.")]
        public Vector4 FogNoiseVelocityRotation;

        [Tooltip("True to have wind affect fog noise velocity, false otherwise. This does require scanning for wind zones, so disable if you see any performance issues.")]
        public bool WindEffectsFogNoiseVelocity;

        [Tooltip("Number of samples to take for 3D fog. If the player will never enter the fog, this can be a lower value. If the player can move through the fog, 40 or higher is better, but will cost some performance.")]
        [Range(1, 100)]
        public int FogNoiseSampleCount = 40;

        [Tooltip("Dithering level. 0 to disable dithering.")]
        [Range(0.0f, 1.0f)]
        public float DitherLevel = 0.005f;

        [Header("Fog shadows (sun only)")]
        [Tooltip("Number of shadow samples, 0 to disable fog shadows. Requires EnableFogLights be true.")]
        [Range(0, 500)]
        public int FogShadowSampleCount = 0;

        [Tooltip("Max ray length for fog shadows.")]
        [Range(10.0f, 1000.0f)]
        public float FogShadowMaxRayLength = 300.0f;

        [Tooltip("Multiplier for fog shadow lighting. Higher values make brighter light rays.")]
        [Range(0.0f, 32.0f)]
        public float FogShadowMultiplier = 8.0f;

        [Tooltip("Controls how light falls off from the light source. Higher values fall off faster. Setting this to a value that is a power of two is recommended.")]
        [Range(0.0f, 128.0f)]
        public float FogShadowPower = 64.0f;

        [Tooltip("Controls brightness of light in the fog vs in shadow.")]
        [Range(0.01f, 10.0f)]
        public float FogShadowBrightness = 1.0f;

        [Tooltip("Controls how light falls off from the light source. Lower values fall off faster.")]
        [Range(0.0f, 1.0f)]
        public float FogShadowDecay = 0.95f;

        [Tooltip("Fog shadow dither multiplier. Higher values dither more.")]
        [Range(0.0f, 3.0f)]
        public float FogShadowDither = 0.4f;

        [Tooltip("Magic numbers for fog shadow dithering. Tweak if you don't like the dithering appearance.")]
        public Vector4 FogShadowDitherMagic = new Vector4(0.73f, 1.665f, 1024.0f, 1024.0f);

        [Header("Volume smoothing (ignored for full screen fog)")]
        [Tooltip("Fog edge smooth factor. Ignored for full screen fog.")]
        [Range(0.0f, 1.0f)]
        public float FogEdgeSmoothFactor = 0.25f;

        [Tooltip("Fog height falloff power. Ignored for full screen fog.")]
        [Range(0.0f, 1.0f)]
        public float FogHeightFalloffPower = 0.75f;

        [Tooltip("Fog edge falloff power. Ignored for full screen fog.")]
        [Range(0.0f, 128.0f)]
        public float FogEdgeFalloffPower = 0.75f;

        /// <summary>
        /// Density of fog for scattering reduction
        /// </summary>
        private float fogScatterReduction = 1.0f;
        public float FogScatterReduction { get { return fogScatterReduction; } }

        /// <summary>
        /// Whether this fog profile will render noise in the fog
        /// </summary>
        public bool HasNoise { get { return FogNoiseScale > 0.0f && FogNoiseMultiplier > 0.0f && WeatherMakerLightManagerScript.NoiseTexture3DInstance != null; } }

        internal Vector3 fogNoisePositionOffset;
        internal float fogNoisePercent = 1.0f;

        /// <summary>
        /// Update a fog material with fog properties from this object
        /// </summary>
        /// <param name="material">Fog material</param>
        /// <param name="camera">Camera</param>
        public virtual void UpdateMaterialProperties(Material material, Camera camera)
        {
            if (WeatherMakerLightManagerScript.Instance == null)
            {
                return;
            }

            bool gamma = (QualitySettings.activeColorSpace == ColorSpace.Gamma);
            float scatterCover = (WeatherMakerFullScreenCloudsScript.Instance.enabled && WeatherMakerFullScreenCloudsScript.Instance.CloudProfile != null ? WeatherMakerFullScreenCloudsScript.Instance.CloudProfile.CloudCoverTotal : 0.0f);
            material.SetColor("_FogColor", FogColor);
            Color tmp = FogEmissionColor * FogEmissionColor.a;
            tmp.a = FogEmissionColor.a;
            material.SetColor("_FogEmissionColor", tmp);
            material.SetFloat("_FogLightAbsorption", FogLightAbsorption);
            material.SetFloat("_FogNoisePercent", fogNoisePercent);
            material.SetFloat("_FogNoiseScale", FogNoiseScale);
            material.SetFloat("_FogNoiseAdder", FogNoiseAdder);
            material.SetFloat("_FogNoiseMultiplier", FogNoiseMultiplier);
            material.SetVector("_FogNoiseVelocity", fogNoiseVelocityAccum);
            material.SetFloat("_FogNoiseSampleCount", (float)FogNoiseSampleCount);
            material.SetFloat("_FogNoiseSampleCountInverse", 1.0f / (float)FogNoiseSampleCount);
            material.SetVector("_FogNoisePositionOffset", fogNoisePositionOffset);
            material.SetFloat("_MaxFogFactor", MaxFogFactor);
            material.SetInt("_FogMode", (int)FogMode);
            if (!(this is WeatherMakerFullScreenFogProfileScript) || FogMode == WeatherMakerFogMode.None || FogDensity <= 0.0f || MaxFogFactor <= 0.001f)
            {
                fogScatterReduction = 1.0f;
            }
            else if (FogMode == WeatherMakerFogMode.Exponential)
            {
                fogScatterReduction = Mathf.Clamp(1.0f - ((FogDensity + scatterCover) * 0.5f), 0.15f, 1.0f);
            }
            else if (FogMode == WeatherMakerFogMode.Linear)
            {
                fogScatterReduction = Mathf.Clamp((1.0f - ((FogDensity + scatterCover) * 0.25f)), 0.15f, 1.0f);
            }
            else if (FogMode == WeatherMakerFogMode.ExponentialSquared)
            {
                fogScatterReduction = Mathf.Clamp((1.0f - ((FogDensity + scatterCover) * 0.75f)), 0.15f, 1.0f);
            }
            else if (FogMode == WeatherMakerFogMode.Constant)
            {
                fogScatterReduction = Mathf.Clamp(1.0f - (FogDensity + scatterCover), 0.5f, 1.0f);
            }
            material.SetFloat("_FogDensityScatter", fogScatterReduction);
            material.SetInt("_FogNoiseEnabled", HasNoise ? 1 : 0);
            if (WeatherMakerScript.Instance == null || WeatherMakerScript.Instance.EnableFogLights)
            {
                if (FogShadowSampleCount > 0 && WeatherMakerLightManagerScript.Instance.Sun.Light.intensity > 0.0f)
                {
                    float brightness = Mathf.Lerp(0.0f, 1.0f, (WeatherMakerLightManagerScript.Instance.Sun.Light.intensity - 0.6f) / 0.4f);
                    material.SetInt("_FogVolumetricLightMode", 2);
                    material.SetFloat("_FogLightShadowSampleCount", (float)FogShadowSampleCount);
                    material.SetFloat("_FogLightShadowInvSampleCount", 1.0f / (float)FogShadowSampleCount);
                    material.SetFloat("_FogLightShadowMaxRayLength", FogShadowMaxRayLength);
                    material.SetFloat("_FogLightShadowMultiplier", FogShadowMultiplier);
                    material.SetFloat("_FogLightShadowPower", FogShadowPower);
                    material.SetFloat("_FogLightShadowBrightness", brightness * FogShadowBrightness);
                    material.SetFloat("_FogLightShadowDecay", FogShadowDecay);
                    material.SetFloat("_FogLightShadowDither", FogShadowDither);
                    material.SetVector("_FogLightShadowDitherMagic", FogShadowDitherMagic);
                }
                else
                {
                    material.SetInt("_FogVolumetricLightMode", 1);
                }
            }
            else
            {
                material.SetInt("_FogVolumetricLightMode", 0);
            }
            material.SetFloat("_FogDitherLevel", (gamma ? DitherLevel : DitherLevel * 0.5f));
            material.SetFloat("_FogDensity", FogDensity);
            material.SetFloat("_FogFactorMultiplier", FogFactorMultiplier);
        }

        public void Update()
        {
            fogNoiseVelocityAccum += (FogNoiseVelocity * Time.deltaTime * 0.005f);

            if (FogNoiseVelocityRotation.x != 0.0f || FogNoiseVelocityRotation.y != 0.0f || FogNoiseVelocityRotation.z != 0.0f)
            {
                fogNoisePositionOffset = new Vector3(FogNoiseVelocityRotation.w, FogNoiseVelocityRotation.w, FogNoiseVelocityRotation.w);
                fogNoisePositionOffset = Quaternion.Euler((Vector3)FogNoiseVelocityRotation * Time.time) * fogNoisePositionOffset;
            }
        }

        public virtual void CopyStateTo(WeatherMakerFogProfileScript profile)
        {
            profile.fogNoiseVelocityAccum = fogNoiseVelocityAccum;
            profile.fogNoisePercent = fogNoisePercent;
        }
    }

    public enum WeatherMakerFogMode
    {
        None,
        Constant,
        Linear,
        Exponential,
        ExponentialSquared
    }
}
