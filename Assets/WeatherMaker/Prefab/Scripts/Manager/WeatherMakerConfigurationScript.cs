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
    public class WeatherMakerConfigurationScript : MonoBehaviour
    {
        public bool ShowFPS = true;
        public bool ShowTimeOfDay = true;
        public bool AutoAddLightsOnStart = true;
        public GameObject ConfigurationPanel;
        public UnityEngine.UI.Text LabelFPS;
        public UnityEngine.UI.Slider TransitionDurationSlider;
        public UnityEngine.UI.Slider IntensitySlider;
        public UnityEngine.UI.Toggle MouseLookEnabledCheckBox;
        public UnityEngine.UI.Toggle FlashlightToggle;
        public UnityEngine.UI.Toggle TimeOfDayEnabledCheckBox;
        public UnityEngine.UI.Toggle CollisionToggle;
        public UnityEngine.UI.Slider DawnDuskSlider;
        public UnityEngine.UI.Text TimeOfDayText;
        public UnityEngine.UI.Text TimeOfDayCategoryText;
        public UnityEngine.UI.Dropdown CloudDropdown;
        public UnityEngine.EventSystems.EventSystem EventSystem;
        public GameObject SidePanel;

        private int frameCount = 0;
        private float nextFrameUpdate = 0.0f;
        private float fps = 0.0f;
        private float frameUpdateRate = 4.0f; // 4 per second
        private int frameCounter;
        private WeatherMakerCloudType clouds;
        private WeatherMakerCloudType lastClouds;

        private void UpdateTimeOfDay()
        {
            DawnDuskSlider.value = WeatherMakerDayNightCycleManagerScript.Instance.TimeOfDay;
            if (TimeOfDayText.IsActive() && ShowTimeOfDay)
            {
                System.TimeSpan t = System.TimeSpan.FromSeconds(WeatherMakerDayNightCycleManagerScript.Instance.TimeOfDay);
                TimeOfDayText.text = string.Format("{0:00}:{1:00}:{2:00}", t.Hours, t.Minutes, t.Seconds);
            }
            TimeOfDayCategoryText.text = WeatherMakerDayNightCycleManagerScript.Instance.TimeOfDayCategory.ToString();
        }

        private void DisplayFPS()
        {
            if (LabelFPS != null && ShowFPS)
            {
                frameCount++;
                if (Time.time > nextFrameUpdate)
                {
                    nextFrameUpdate += (1.0f / frameUpdateRate);
                    fps = (int)Mathf.Floor((float)frameCount * frameUpdateRate);
                    LabelFPS.text = "FPS: " + fps;
                    frameCount = 0;
                }
            }
        }

        private void Start()
        {
            WeatherMakerPrecipitationManagerScript.Instance.PrecipitationIntensity = IntensitySlider.value = 0.5f;
            DawnDuskSlider.value = WeatherMakerDayNightCycleManagerScript.Instance.TimeOfDay;
            nextFrameUpdate = Time.time;
            CollisionToggle.isOn = WeatherMakerScript.Instance.EnablePrecipitationCollision;
            if (UnityEngine.EventSystems.EventSystem.current == null && ConfigurationPanel != null && ConfigurationPanel.activeInHierarchy)
            {
                EventSystem.gameObject.SetActive(true);
                UnityEngine.EventSystems.EventSystem.current = EventSystem;
            }
            if (AutoAddLightsOnStart)
            {
                foreach (Light light in GameObject.FindObjectsOfType<Light>())
                {
                    if (light.type != LightType.Directional && light.type != LightType.Area && !WeatherMakerLightManagerScript.Instance.AutoAddLights.Contains(light))
                    {
                        WeatherMakerLightManagerScript.Instance.AutoAddLights.Add(light);
                    }
                }
            }
        }

        private void Update()
        {
            DisplayFPS();
            if (Input.GetKeyDown(KeyCode.B))
            {
                LightningStrikeButtonClicked();
            }
            if (Input.GetKeyDown(KeyCode.BackQuote) && (Input.GetKey(KeyCode.LeftControl) || Input.GetKey(KeyCode.RightControl)))
            {
                // Unity bug, disabling or setting transform scale to 0 will break any projectors in the scene
                RectTransform r = SidePanel.GetComponent<RectTransform>();
                Vector2 ap = r.anchoredPosition;
                if (r.anchoredPosition.x < 0.0f)
                {
                    ap.x = 110.0f;
                }
                else
                {
                    ap.x = -9999.0f;
                }
                r.anchoredPosition = ap;
            }
            if (Input.GetKeyDown(KeyCode.Escape) && Input.GetKey(KeyCode.LeftShift))
            {
                UnityEngine.SceneManagement.SceneManager.LoadScene(0);
            }
            UpdateTimeOfDay();
            frameCounter++;
        }

        // Weather configuration...

        private void UpdateClouds()
        {
            if (clouds == lastClouds)
            {
                return;
            }
            lastClouds = clouds;
            if (WeatherMakerLegacyCloudScript2D.Instance != null)
            {
                if (clouds == WeatherMakerCloudType.None)
                {
                    WeatherMakerLegacyCloudScript2D.Instance.RemoveClouds();
                }
                else if (clouds != WeatherMakerCloudType.Custom)
                {
                    WeatherMakerLegacyCloudScript2D.Instance.CreateClouds();
                }
            }
            else if (WeatherMakerFullScreenCloudsScript.Instance != null)
            {
                float duration = WeatherMakerPrecipitationManagerScript.Instance.PrecipitationChangeDuration;
                if (clouds == WeatherMakerCloudType.None)
                {
                    WeatherMakerFullScreenCloudsScript.Instance.HideCloudsAnimated(duration);
                }
                // float cover, float density = -1.0f, float sharpness = -1.0f, float lightAbsorption = -1.0f, Color? color = null
                else if (clouds == WeatherMakerCloudType.Light)
                {
                    // cover, density, sharpness, lightAbsorption
                    // 0.17f, 0.0f, -1.0f, 0.5f
                    WeatherMakerFullScreenCloudsScript.Instance.ShowCloudsAnimated(duration, "WeatherMakerCloudProfile_Light");
                }
                else if (clouds == WeatherMakerCloudType.Medium)
                {
                    // 0.34f, 0.0f, -1.0f, 0.3f
                    WeatherMakerFullScreenCloudsScript.Instance.ShowCloudsAnimated(duration, "WeatherMakerCloudProfile_Medium");
                }
                else if (clouds == WeatherMakerCloudType.Heavy)
                {
                    // 0.75f, 0.2f, -1.0f, 0.11f
                    WeatherMakerFullScreenCloudsScript.Instance.ShowCloudsAnimated(duration, "WeatherMakerCloudProfile_HeavyDark");
                }
                else if (clouds == WeatherMakerCloudType.HeavyBright)
                {
                    // 0.68f, 0.0f, -1.0f, 0.125f
                    WeatherMakerFullScreenCloudsScript.Instance.ShowCloudsAnimated(duration, "WeatherMakerCloudProfile_HeavyBright");
                }
                else if (clouds == WeatherMakerCloudType.Storm)
                {
                    // 1.0f, 0.8f, -1.0f, 0.1f,
                    WeatherMakerFullScreenCloudsScript.Instance.ShowCloudsAnimated(duration, "WeatherMakerCloudProfile_Storm");
                }
                else
                {
                    // custom clouds, do not modify current cloud script state
                }
            }
        }

        public void RainToggleChanged(bool isOn)
        {
            WeatherMakerPrecipitationManagerScript.Instance.Precipitation = (isOn ? WeatherMakerPrecipitationType.Rain : WeatherMakerPrecipitationType.None);
            WeatherMakerPrecipitationManagerScript.Instance.PrecipitationIntensity = IntensitySlider.value;
        }

        public void SnowToggleChanged(bool isOn)
        {
            WeatherMakerPrecipitationManagerScript.Instance.Precipitation = (isOn ? WeatherMakerPrecipitationType.Snow : WeatherMakerPrecipitationType.None);
            WeatherMakerPrecipitationManagerScript.Instance.PrecipitationIntensity = IntensitySlider.value;
        }

        public void HailToggleChanged(bool isOn)
        {
            WeatherMakerPrecipitationManagerScript.Instance.Precipitation = (isOn ? WeatherMakerPrecipitationType.Hail : WeatherMakerPrecipitationType.None);
            WeatherMakerPrecipitationManagerScript.Instance.PrecipitationIntensity = IntensitySlider.value;
        }

        public void SleetToggleChanged(bool isOn)
        {
            WeatherMakerPrecipitationManagerScript.Instance.Precipitation = (isOn ? WeatherMakerPrecipitationType.Sleet : WeatherMakerPrecipitationType.None);
            WeatherMakerPrecipitationManagerScript.Instance.PrecipitationIntensity = IntensitySlider.value;
        }

        public void CloudToggleChanged()
        {
            clouds = (WeatherMakerCloudType)CloudDropdown.value;
            UpdateClouds();
        }

        public void LightningToggleChanged(bool isOn)
        {
            WeatherMakerThunderAndLightningScript.Instance.EnableLightning = isOn;
        }

        public void CollisionToggleChanged(bool isOn)
        {
            WeatherMakerScript.Instance.EnablePrecipitationCollision = isOn;
        }

        public void WindToggleChanged(bool isOn)
        {
            float duration = WeatherMakerPrecipitationManagerScript.Instance.PrecipitationChangeDuration;
            if (isOn)
            {
                // make a copy to avoid changes during runtime, drag in a profile to inspector manually to edit at runtime
                WeatherMakerWindScript.Instance.SetWindProfileAnimated(Resources.Load<WeatherMakerWindProfileScript>("WeatherMakerWindProfile_MediumWind"), 0.0f, duration);
            }
            else
            {
                WeatherMakerWindScript.Instance.SetWindProfileAnimated(Resources.Load<WeatherMakerWindProfileScript>("WeatherMakerWindProfile_None"), 0.0f, duration);
            }
        }

        public void TransitionDurationSliderChanged(float val)
        {
            WeatherMakerPrecipitationManagerScript.Instance.PrecipitationChangeDuration = val;
        }

        public void IntensitySliderChanged(float val)
        {
            WeatherMakerPrecipitationManagerScript.Instance.PrecipitationIntensity = val;
        }

        public void MouseLookEnabledChanged(bool val)
        {
            MouseLookEnabledCheckBox.isOn = val;
            foreach (GameObject obj in GameObject.FindGameObjectsWithTag("Player"))
            {
                UnityEngine.Networking.NetworkBehaviour network = obj.GetComponent<UnityEngine.Networking.NetworkBehaviour>();
                if (network == null || network.isLocalPlayer)
                {
                    WeatherMakerPlayerControllerScript controller = obj.GetComponent<WeatherMakerPlayerControllerScript>();
                    if (controller != null)
                    {
                        controller.EnableMouseLook = val;
                    }
                }
            }
        }

        public void FlashlightChanged(bool val)
        {
            foreach (GameObject obj in GameObject.FindGameObjectsWithTag("Player"))
            {
                UnityEngine.Networking.NetworkBehaviour network = obj.GetComponent<UnityEngine.Networking.NetworkBehaviour>();
                if (network == null || network.isLocalPlayer)
                {
                    Light[] lights = obj.GetComponentsInChildren<Light>();
                    foreach (Light light in lights)
                    {
                        if (light.name == "Flashlight")
                        {
                            light.enabled = val;
                            break;
                        }
                    }
                }
            }
            if (FlashlightToggle != null)
            {
                FlashlightToggle.isOn = val;
            }
        }

        public void FogChanged(bool val)
        {
            if (WeatherMakerFullScreenFogScript.Instance == null || WeatherMakerFullScreenFogScript.Instance.FogProfile == null)
            {
                Debug.LogError("Fog is not setup. If using 2D, fog is not yet supported.");
            }
            else
            {
                // if fog is not active, set the start fog density to 0, otherwise start at whatever density it is at
                float startFogDensity = WeatherMakerFullScreenFogScript.Instance.FogProfile.FogDensity;
                float endFogDensity = (startFogDensity == 0.0f ? 0.007f : 0.0f);
                WeatherMakerFullScreenFogScript.Instance.TransitionFogDensity(startFogDensity, endFogDensity, TransitionDurationSlider.value);
            }
        }

        public void ManagerChanged(bool val)
        {
            Transform parent = WeatherMakerScript.Instance.transform;
            for (int i = 0; i < parent.childCount; i++)
            {
                Transform t = parent.GetChild(i);
                if (t.GetComponent<WeatherMakerWeatherZoneScript>() != null)
                {
                    t.gameObject.SetActive(val);
                    break;
                }
            }
        }

        public void TimeOfDayEnabledChanged(bool val)
        {
            WeatherMakerDayNightCycleManagerScript.Instance.Speed = WeatherMakerDayNightCycleManagerScript.Instance.NightSpeed = (val ? 10.0f : 0.0f);
        }

        public void LightningStrikeButtonClicked()
        {
            WeatherMakerThunderAndLightningScript.Instance.CallIntenseLightning();
        }

        public void DawnDuskSliderChanged(float val)
        {
            WeatherMakerDayNightCycleManagerScript.Instance.TimeOfDay = val;
        }
    }
}
