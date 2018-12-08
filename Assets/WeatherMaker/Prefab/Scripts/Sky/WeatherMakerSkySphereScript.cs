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
using System.Collections;

namespace DigitalRuby.WeatherMaker
{
    [ExecuteInEditMode]
    [RequireComponent(typeof(MeshFilter), typeof(MeshRenderer))]
    public class WeatherMakerSkySphereScript : WeatherMakerSphereCreatorScript
    {
        [Header("Sky sphere profile")]
        public WeatherMakerSkyProfileScript SkySphereProfile;

        private void OnEnable()
        {
            Camera.onPreCull += CameraPreCull;
        }

        private void OnDisable()
        {
            Camera.onPreCull -= CameraPreCull;
        }

        protected override void LateUpdate()
        {
            base.LateUpdate();
            if (Application.isPlaying && SkySphereProfile != null && WeatherMakerDayNightCycleManagerScript.Instance != null &&
                (SkySphereProfile.SkyMode == WeatherMakeSkyMode.ProceduralPreethamStyle || SkySphereProfile.SkyMode == WeatherMakeSkyMode.ProceduralUnityStyle) &&
                WeatherMakerDayNightCycleManagerScript.Instance.DayNightProfile != null && SkySphereProfile.RotateAxis != Vector3.zero)
            {
                float seconds = WeatherMakerDayNightCycleManagerScript.Instance.TimeOfDay;
                transform.rotation = Quaternion.AngleAxis(Mathf.Lerp(0.0f, 360.0f, seconds / WeatherMakerDayNightCycleProfileScript.SecondsPerDay), SkySphereProfile.RotateAxis);
            }
        }

        private void CameraPreCull(Camera camera)
        {
            if (WeatherMakerScript.ShouldIgnoreCamera(this, camera))
            {
                return;
            }

#if UNITY_EDITOR

            if (Application.isPlaying)
            {

#endif

                if (SkySphereProfile != null && camera != null && isActiveAndEnabled)
                {
                    SkySphereProfile.UpdateSkySphere(camera, MeshRenderer.sharedMaterial, gameObject);
                }

#if UNITY_EDITOR

            }

#endif

        }

#if UNITY_EDITOR

        protected override void OnWillRenderObject()
        {
            base.OnWillRenderObject();

            if (!Application.isPlaying && Camera.current != null && SkySphereProfile != null)
            {
                SkySphereProfile.UpdateSkySphere(Camera.current, MeshRenderer.sharedMaterial, gameObject);
            }
        }

        protected override void Start()
        {
            base.Start();

            if (SkySphereProfile == null)
            {
                SkySphereProfile = Resources.Load<WeatherMakerSkyProfileScript>("WeatherMakerSkyProfile_Procedural");
            }
        }

#endif

        private static WeatherMakerSkySphereScript instance;
        /// <summary>
        /// Shared instance of sky sphere script
        /// </summary>
        public static WeatherMakerSkySphereScript Instance
        {
            get
            {
                if (instance == null)
                {
                    foreach (WeatherMakerSkySphereScript script in GameObject.FindObjectsOfType<WeatherMakerSkySphereScript>())
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