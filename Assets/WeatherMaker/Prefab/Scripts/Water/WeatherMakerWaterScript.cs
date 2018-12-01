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

using System;
using System.Collections.Generic;

using UnityEngine;

namespace DigitalRuby.WeatherMaker
{


    [ExecuteInEditMode]
    [RequireComponent(typeof(MeshRenderer), typeof(MeshFilter), typeof(BoxCollider))]
    public class WeatherMakerWaterScript : MonoBehaviour
    {
        [Header("Profile")]
        [Tooltip("Water Profile")]
        public WeatherMakerWaterProfileScript WaterProfile;

        [Header("Underwater")]
        [Tooltip("Underwater audio source (loops while underwater)")]
        public AudioSource UnderwaterAudioSource;

        [Tooltip("Splash audio source (when entering / exiting the water)")]
        public AudioSource SplashAudioSource;

        /// <summary>
        /// Callback when a camera goes underwater
        /// </summary>
        public System.Action<WeatherMakerWaterScript, Camera, bool> UnderwaterCallback { get; set; }

        /// <summary>
        /// Water mesh renderer
        /// </summary>
        public MeshRenderer MeshRenderer { get; private set; }

        private readonly HashSet<Camera> underwaterCameras = new HashSet<Camera>();

        private WeatherMakerReflectionScript reflection;
        private BoxCollider waterCollider;
        private WeatherMakerDepthCameraScript depthScript;
        private bool isUnderwater;
        private Material lastWaterProfileMaterial;

        private void Awake()
        {
            MeshRenderer = GetComponent<MeshRenderer>();
            reflection = GetComponent<WeatherMakerReflectionScript>();
            waterCollider = GetComponent<BoxCollider>();
            depthScript = GetComponent<WeatherMakerDepthCameraScript>();
            if (depthScript != null)
            {
                depthScript.Renderer = MeshRenderer;
            }
            UpdateProfile();
        }

        private void Cleanup()
        {
            if (MeshRenderer.sharedMaterial.name.IndexOf("(clone)", StringComparison.OrdinalIgnoreCase) >= 0)
            {
                GameObject.DestroyImmediate(MeshRenderer.sharedMaterial);
            }
        }

        private void UpdateProfile()
        {
            if (WaterProfile != null && WaterProfile.Material != null && WaterProfile.Material != lastWaterProfileMaterial)
            {
                Cleanup();
                lastWaterProfileMaterial = WaterProfile.Material;
                MeshRenderer.sharedMaterial = (Application.isPlaying ? GameObject.Instantiate(WaterProfile.Material) as Material : WaterProfile.Material);
                if (depthScript != null)
                {
                    depthScript.Dirty = true;
                }
            }
        }

        private void OnEnable()
        {
            Camera.onPreCull += CameraPreCull;
        }

        private void OnDisable()
        {
            underwaterCameras.Clear();
            Camera.onPreCull -= CameraPreCull;
        }

        private void OnDestroy()
        {
            Cleanup();
        }

        private void Update()
        {
            UpdateWind();
            UpdateShader();
            UpdateDepthScript();
        }

        private void PrecomputeWaves(string waveName, string wavePrecomputeName, string waveParam1Name)
        {
            Vector4 waveVar = MeshRenderer.sharedMaterial.GetVector(waveName);
            Vector4 waveParam1 = MeshRenderer.sharedMaterial.GetVector(waveParam1Name);
            float speed = waveParam1.x;
            waveVar.x = 2.0f * (Mathf.PI / waveVar.w); //float k = 2 * UNITY_PI / wavelength;
            waveVar.y = Mathf.Sqrt(9.8f / waveVar.x) * speed * Time.timeSinceLevelLoad; //float c = sqrt(9.8 / k);
            waveVar.z = waveVar.z / waveVar.x; //float a = steepness / k;
            waveVar.w = 0.0f;
            MeshRenderer.sharedMaterial.SetVector(wavePrecomputeName, waveVar);
        }

        protected void UpdateWind()
        {
            if (MeshRenderer.sharedMaterial == null)
            {
                return;
            }

            MeshRenderer.sharedMaterial.SetFloat("_WaterWaveMultiplier", 1.0f);
            if (WaterProfile == null || !WaterProfile.WindAffectsWaves || WeatherMakerWindScript.Instance == null || WeatherMakerWindScript.Instance.WindProfile == null ||
                WeatherMakerWindScript.Instance.WindZone == null)
            {
                return;
            }

            MeshRenderer.sharedMaterial.SetFloat("_WaterWaveMultiplier", WeatherMakerWindScript.Instance.WindZone.windMain * 5.0f);
        }

        private void UpdateShader()
        {
            if (WaterProfile == null || MeshRenderer.sharedMaterial == null)
            {
                return;
            }
            UpdateProfile();
            if (WaterProfile.RenderMode == WeatherMakerWaterRenderingMode.OnePass)
            {
                if (MeshRenderer.sharedMaterial.IsKeywordEnabled("WATER_LIGHT_FORWARD_BASE"))
                {
                    MeshRenderer.sharedMaterial.DisableKeyword("WATER_LIGHT_FORWARD_BASE");
                }
                MeshRenderer.sharedMaterial.SetShaderPassEnabled("ForwardAdd", false);
            }
            else if (!MeshRenderer.sharedMaterial.IsKeywordEnabled("WATER_LIGHT_FORWARD_BASE"))
            {
                MeshRenderer.sharedMaterial.EnableKeyword("WATER_LIGHT_FORWARD_BASE");
                MeshRenderer.sharedMaterial.SetShaderPassEnabled("ForwardAdd", true);
            }

            MeshRenderer.sharedMaterial.SetFloat("_WaterDepthThreshold", (WaterProfile.WaterDepthThreshold <= 0.0f ? float.MinValue : WaterProfile.WaterDepthThreshold / transform.lossyScale.y));
            if (isUnderwater)
            {
                MeshRenderer.sharedMaterial.DisableKeyword("WATER_REFLECTIVE");
                MeshRenderer.sharedMaterial.EnableKeyword("WATER_UNDERWATER");
            }
            else if (reflection != null && reflection.enabled)
            {
                MeshRenderer.sharedMaterial.EnableKeyword("WATER_REFLECTIVE");
                MeshRenderer.sharedMaterial.DisableKeyword("WATER_UNDERWATER");
            }
            else
            {
                MeshRenderer.sharedMaterial.DisableKeyword("WATER_REFLECTIVE");
                MeshRenderer.sharedMaterial.DisableKeyword("WATER_UNDERWATER");
            }

            if (isUnderwater)
            {
                MeshRenderer.sharedMaterial.SetInt("_Cull", (int)UnityEngine.Rendering.CullMode.Front);
                MeshRenderer.sharedMaterial.SetInt("_ZTest", (int)UnityEngine.Rendering.CompareFunction.Always);
                MeshRenderer.sharedMaterial.SetInt("_Zwrite", 0);
            }
            else
            {
                MeshRenderer.sharedMaterial.SetInt("_Cull", (int)UnityEngine.Rendering.CullMode.Back);
                MeshRenderer.sharedMaterial.SetInt("_ZTest", (int)UnityEngine.Rendering.CompareFunction.LessEqual);
                MeshRenderer.sharedMaterial.SetInt("_Zwrite", 1);
            }

            MeshRenderer.sharedMaterial.SetInt("_SrcBlendMode", (int)UnityEngine.Rendering.BlendMode.SrcAlpha);
            MeshRenderer.sharedMaterial.SetInt("_DstBlendMode", (int)UnityEngine.Rendering.BlendMode.OneMinusSrcAlpha);
            MeshRenderer.sharedMaterial.SetVector("_FogBoxMax", transform.position);

            PrecomputeWaves("_WaterWave1", "_WaterWave1_Precompute", "_WaterWave1_Params1");
            PrecomputeWaves("_WaterWave2", "_WaterWave2_Precompute", "_WaterWave2_Params1");
            PrecomputeWaves("_WaterWave3", "_WaterWave3_Precompute", "_WaterWave3_Params1");
            PrecomputeWaves("_WaterWave4", "_WaterWave4_Precompute", "_WaterWave4_Params1");
            PrecomputeWaves("_WaterWave5", "_WaterWave5_Precompute", "_WaterWave5_Params1");
            PrecomputeWaves("_WaterWave6", "_WaterWave6_Precompute", "_WaterWave6_Params1");
            PrecomputeWaves("_WaterWave7", "_WaterWave7_Precompute", "_WaterWave7_Params1");
            PrecomputeWaves("_WaterWave8", "_WaterWave8_Precompute", "_WaterWave8_Params1");
        }

        private void UpdateDepthScript()
        {
            if (depthScript != null)
            {
                Bounds bounds = MeshRenderer.bounds;
                depthScript.OrthographicSize = bounds.size.z * 0.5f;
                depthScript.AspectRatio = bounds.size.x / bounds.size.z;
            }
        }

        private void PlaySplashSound()
        {
            if (SplashAudioSource != null && WaterProfile != null && WaterProfile.SplashAudioClips != null && WaterProfile.SplashAudioClips.Length != 0)
            {
                SplashAudioSource.PlayOneShot(WaterProfile.SplashAudioClips[UnityEngine.Random.Range(0, WaterProfile.SplashAudioClips.Length)]);
            }
        }

        private void PlayUnderwaterSound()
        {
            if (UnderwaterAudioSource != null && WaterProfile != null && WaterProfile.UnderwaterAudioClip != null)
            {
                UnderwaterAudioSource.clip = WaterProfile.UnderwaterAudioClip;
                UnderwaterAudioSource.Play();
            }
        }

        private bool ShouldProcessCamera(Camera camera)
        {
            return (camera != null && waterCollider != null && waterCollider.enabled &&
                !WeatherMakerScript.ShouldIgnoreCamera(this, camera) && WeatherMakerScript.IsLocalPlayer(camera.transform));
        }

        private void CameraPreCull(Camera camera)
        {
            if (!Application.isPlaying || !ShouldProcessCamera(camera))
            {
                return;
            }

            bool intersectsCamera = false;
            bool hasWaterNullZone = false;
            if (WeatherMakerScript.IsLocalPlayer(camera.transform))
            {
                int hits = Physics.OverlapSphereNonAlloc(camera.transform.position, 0.001f, WeatherMakerScript.tempColliders);
                for (int i = 0; i < hits; i++)
                {
                    if (WeatherMakerScript.tempColliders[i] == waterCollider)
                    {
                        intersectsCamera = true;
                    }
                    else
                    {
                        WeatherMakerNullZoneScript script = WeatherMakerScript.tempColliders[i].GetComponent<WeatherMakerNullZoneScript>();
                        hasWaterNullZone |= (script != null && script.CurrentState != null && (script.CurrentState.RenderMask & NullZoneRenderMask.Water) != NullZoneRenderMask.Water);
                    }
                }
            }

            if (intersectsCamera && !hasWaterNullZone)
            {
                if (underwaterCameras.Add(camera))
                {
                    // transition to being underwater
                    Debug.Log("Went underwater: " + camera.name);
                    PlayUnderwaterSound();
                    PlaySplashSound();
                    if (UnderwaterCallback != null)
                    {
                        UnderwaterCallback.Invoke(this, camera, true);
                    }

                    // TODO: Activate any post processing volume
                }

                // render surface after precipitation and other alpha effects if under water
                MeshRenderer.sharedMaterial.renderQueue = 3000;
                MeshRenderer.sharedMaterial.EnableKeyword("WATER_UNDERWATER");
                isUnderwater = true;

                // reduce sun light as camera goes further down in the water
                if (WeatherMakerLightManagerScript.Instance != null)
                {
                    float density = MeshRenderer.sharedMaterial.GetFloat("_WaterFogDensity");
                    float depth = Mathf.Max(0.0f, transform.position.y - camera.transform.position.y);
                    float atten = (1.0f / (density * density * depth * depth));
                    atten = Mathf.Clamp(atten, 0.0f, 1.0f);
                    WeatherMakerLightManagerScript.Instance.DirectionalLightIntensityMultipliers["WeatherMakerWaterScript" + GetInstanceID()] = atten;
                }
            }
            else
            {
                if (underwaterCameras.Contains(camera))
                {
                    // transition away from being underwater
                    Debug.Log("No longer underwater: " + camera.name);
                    underwaterCameras.Remove(camera);
                    if (UnderwaterAudioSource != null)
                    {
                        UnderwaterAudioSource.Pause();
                    }
                    PlaySplashSound();
                    if (UnderwaterCallback != null)
                    {
                        UnderwaterCallback.Invoke(this, camera, false);
                    }
                    if (WeatherMakerLightManagerScript.Instance != null)
                    {
                        WeatherMakerLightManagerScript.Instance.DirectionalLightIntensityMultipliers.Remove("WeatherMakerWaterScript" + GetInstanceID());
                    }

                    // TODO: Deactivate any prost processing volume
                }

                // default render queue if above water
                MeshRenderer.sharedMaterial.renderQueue = -1;
                MeshRenderer.sharedMaterial.DisableKeyword("WATER_UNDERWATER");
                isUnderwater = false;
            }
        }
    }
}