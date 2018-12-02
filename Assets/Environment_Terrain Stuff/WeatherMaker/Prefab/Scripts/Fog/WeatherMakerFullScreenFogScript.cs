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

using UnityEngine;
using UnityEngine.Rendering;

using System;
using System.Collections.Generic;

namespace DigitalRuby.WeatherMaker
{
    public class WeatherMakerFullScreenFogScript : WeatherMakerFogScript<WeatherMakerFullScreenFogProfileScript>
    {
        [Header("Full screen fog rendering")]
        [Tooltip("Material to render the fog full screen after it has been calculated")]
        public Material FogFullScreenMaterial;

        [Tooltip("Down sample scale.")]
        [Range(0.01f, 1.0f)]
        public float DownSampleScale = 1.0f;

        [Tooltip("Fog Blur Material.")]
        public Material FogBlurMaterial;

        [Tooltip("Fog Blur Shader Type.")]
        public BlurShaderType BlurShader;

        [Tooltip("Render fog in this render queue for the command buffer.")]
        public CameraEvent FogRenderQueue = CameraEvent.BeforeForwardAlpha;

        [Tooltip("Whether to render fog in reflection cameras.")]
        public bool AllowReflections = true;

        [Tooltip("Control how fog reduces shadow stength. Larger values reduce shadow strength more.")]
        [Range(0.0f, 0.02f)]
        public float FogShadowStrengthFactor = 0.005f;

        private WeatherMakerFullScreenEffect effect;
        private System.Action<WeatherMakerCommandBuffer> updateShaderPropertiesAction;

        private const string commandBufferName = "WeatherMakerFullScreenFogScript";

        private void UpdateFogProperties()
        {
            if (FogProfile == null || WeatherMakerScript.Instance == null)
            {
                return;
            }

            // global fog params, individual material can override
            // useful for hacks like the tree billboard shader override that account for full screen fog
            Shader.SetGlobalInt("_FogMode", (int)FogProfile.FogMode);
            Shader.SetGlobalFloat("_FogDensity", FogProfile.FogDensity);
            Shader.SetGlobalFloat("_MaxFogFactor", FogProfile.MaxFogFactor);

            // reduce shadow strength as the fog blocks out dir lights
            float multiplier;
            float h;
            switch (FogProfile.FogMode)
            {
                case WeatherMakerFogMode.Constant:
                    multiplier = 1.0f - Mathf.Min(1.0f, FogProfile.FogDensity * 1.2f);
                    break;

                case WeatherMakerFogMode.Linear:
                    h = (FogProfile.FogHeight < Mathf.Epsilon ? 1000.0f : FogProfile.FogHeight) * FogShadowStrengthFactor;
                    multiplier = 1.0f - (FogProfile.FogDensity * 16.0f * h);
                    break;

                case WeatherMakerFogMode.Exponential:
                    h = (FogProfile.FogHeight < Mathf.Epsilon ? 1000.0f : FogProfile.FogHeight) * FogShadowStrengthFactor * 2.0f;
                    multiplier = 1.0f - Mathf.Min(1.0f, Mathf.Pow(FogProfile.FogDensity * 32.0f * h, 0.5f));
                    break;

                case WeatherMakerFogMode.ExponentialSquared:
                    h = (FogProfile.FogHeight < Mathf.Epsilon ? 1000.0f : FogProfile.FogHeight) * FogShadowStrengthFactor * 4.0f;
                    multiplier = 1.0f - Mathf.Min(1.0f, Mathf.Pow(FogProfile.FogDensity * 64.0f * h, 0.5f));
                    break;

                default:
                    multiplier = 1.0f;
                    break;
            }
            if (WeatherMakerLightManagerScript.Instance != null)
            {
                WeatherMakerLightManagerScript.Instance.DirectionalLightShadowIntensityMultipliers["WeatherMakerFullScreenFogScript"] = Mathf.Clamp(multiplier, 0.0f, 1.0f);
            }
            effect.SetupEffect(FogMaterial, FogFullScreenMaterial, FogBlurMaterial, BlurShader, DownSampleScale,
                (FogProfile.SunShaftSampleCount <= 0 ? 0.0f : FogProfile.SunShaftDownSampleScale), updateShaderPropertiesAction,
                (FogProfile.FogDensity > Mathf.Epsilon && FogProfile.FogMode != WeatherMakerFogMode.None));
            UpdateWind();
        }

        private void UpdateShaderProperties(WeatherMakerCommandBuffer b)
        {
            // temp turn off fog lights for reflection camera and save a lot of performance
            bool origFogLights = (WeatherMakerScript.Instance == null || WeatherMakerScript.Instance.EnableFogLights);
            bool origFogShafts = (WeatherMakerScript.Instance == null || WeatherMakerScript.Instance.EnableFogFullScreenSunShafts);
            WeatherMakerCameraType camType = WeatherMakerFullScreenEffect.GetCameraType(b.Camera);
            bool tempFogLights = origFogLights && (camType == WeatherMakerCameraType.Normal);
            bool tempFogShafts = origFogShafts && (camType == WeatherMakerCameraType.Normal);
            float density = FogProfile.FogDensity;
            if (camType == WeatherMakerCameraType.Reflection)
            {
                // HACK: reflection camera hack, density is not correct but this compensates
                // TODO: figure out why fog formula is wrong in reflection camera
                FogProfile.FogDensity = Mathf.Min(1.0f, density * 100.0f);
            }
            if (WeatherMakerScript.Instance != null)
            {
                WeatherMakerScript.Instance.EnableFogLights = tempFogLights;
                WeatherMakerScript.Instance.EnableFogFullScreenSunShafts = tempFogShafts;
            }
            FogProfile.UpdateMaterialProperties(b.Material, b.Camera);
            FogProfile.FogDensity = density;
            if (WeatherMakerScript.Instance != null)
            {
                WeatherMakerScript.Instance.EnableFogLights = origFogLights;
                WeatherMakerScript.Instance.EnableFogFullScreenSunShafts = origFogShafts;
            }
        }

        protected override void Awake()
        {
            // create fog profile now, base.Start will also create it but uses a non-full screen profile default
            if (FogProfile == null)
            {
                FogProfile = Resources.Load<WeatherMakerFullScreenFogProfileScript>("WeatherMakerFullScreenFogProfile_Default");
            }
            updateShaderPropertiesAction = UpdateShaderProperties;

            base.Awake();

            effect = new WeatherMakerFullScreenEffect
            {
                CommandBufferName = commandBufferName,
                DownsampleRenderBufferTextureName = "_MainTex2",
                RenderQueue = FogRenderQueue
            };

#if UNITY_EDITOR

            if (Application.isPlaying)
            {

#endif

                FogFullScreenMaterial = new Material(FogFullScreenMaterial);
                FogBlurMaterial = new Material(FogBlurMaterial);

#if UNITY_EDITOR

            }

#endif

        }

        protected override void LateUpdate()
        {
            base.LateUpdate();
            UpdateFogProperties();
        }

        protected override void OnDestroy()
        {
            base.OnDestroy();
            if (effect != null)
            {
                effect.Dispose();
            }
        }

        protected override void OnEnable()
        {
            base.OnEnable();
            Camera.onPreCull += CameraPreCull;
        }

        protected override void OnDisable()
        {
            base.OnDisable();
            if (effect != null)
            {
                effect.Dispose();
            }
            Camera.onPreCull -= CameraPreCull;
        }

        protected override void UpdateFogMaterialFromProfile()
        {
            // no need to call base class as we set material properties elsewhere
        }

        private void CameraPreCull(Camera camera)
        {
            if (effect != null && !WeatherMakerScript.ShouldIgnoreCamera(this, camera, !AllowReflections))
            {
                effect.SetupCamera(camera);
            }
        }

        private static WeatherMakerFullScreenFogScript instance;
        /// <summary>
        /// Shared instance of full screen fog script
        /// </summary>
        public static WeatherMakerFullScreenFogScript Instance
        {
            get
            {
                if (instance == null)
                {
                    foreach (WeatherMakerFullScreenFogScript script in GameObject.FindObjectsOfType<WeatherMakerFullScreenFogScript>())
                    {
                        if (script.enabled)
                        {
                            instance = script;
                            break;
                        }
                    }
                }
                return instance;
            }
        }
    }
}