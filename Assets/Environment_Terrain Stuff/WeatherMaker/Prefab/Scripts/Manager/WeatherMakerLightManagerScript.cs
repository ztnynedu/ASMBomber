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
    public enum AutoFindLightsMode
    {
        None,
        Once,
        EveryFrame
    }

    public enum WeatherMakerOrbitType
    {
        /// <summary>
        /// Orbit as viewed from Earth
        /// </summary>
        FromEarth = 0,

        /// <summary>
        /// Orbit is controlled by script implementing IWeatherMakerCustomOrbit interface
        /// </summary>
        Custom
    }

    public enum BlurShaderType
    {
        None,
        GaussianBlur7,
        GaussianBlur17
    }

    /// <summary>
    /// Manages lights in world space for use in shaders - you do not need to add the directional light to the Lights list, it is done automatically
    /// </summary>
    [ExecuteInEditMode]
    public class WeatherMakerLightManagerScript : MonoBehaviour
    {
        [Header("Lights")]
        [Tooltip("Whether to find all lights in the scene automatically if no Lights were added programatically. If none, you must manually add / remove lights using the AutoAddLights property. " +
            "To ensure correct behavior, do not change in script, set it once in the inspector and leave it. If this is set to EveryFrame, AddLight and RemoveLight do nothing.")]
        public AutoFindLightsMode AutoFindLights;

        [Tooltip("A list of lights to automatically add to the light manager. Only used if AutoFindLights is false.")]
        public List<Light> AutoAddLights;

        [Tooltip("A list of lights to always ignore, regardless of other settings.")]
        public List<Light> IgnoreLights;

        [Tooltip("How often to update shader state in seconds for each object (camera, collider, etc.), 0 for every frame.")]
        [Range(0.0f, 1.0f)]
        public float ShaderUpdateInterval = (30.0f / 1000.0f); // 30 fps
        private readonly Dictionary<Component, float> shaderUpdateCounter = new Dictionary<Component, float>();
        private Component lastShaderUpdateComponent;

        [Tooltip("Spot light quadratic attenuation.")]
        [Range(0.0f, 1000.0f)]
        public float SpotLightQuadraticAttenuation = 25.0f;

        [Tooltip("Point light quadratic attenuation.")]
        [Range(0.0f, 1000.0f)]
        public float PointLightQuadraticAttenuation = 25.0f;

        [Tooltip("Area light quadratic attenuation. Set to 0 to turn off all area lights.")]
        [Range(0.0f, 1000.0f)]
        public float AreaLightQuadraticAttenuation = 50.0f;

        [Tooltip("Multiplier for area light. Spreads and fades light out over x and y size.")]
        [Range(1.0f, 20.0f)]
        public float AreaLightAreaMultiplier = 10.0f;

        [Tooltip("Falloff for area light, as light moves away from center it falls off more as this increases.")]
        [Range(0.0f, 3.0f)]
        public float AreaLightFalloff = 0.5f;

        [Tooltip("How intense is the scatter of directional light in the fog.")]
        [Range(0.0f, 100.0f)]
        public float FogDirectionalLightScatterIntensity = 2.0f;

        [Tooltip("How quickly fog point lights falloff from the center radius. High values fall-off more.")]
        [Range(0.0f, 4.0f)]
        public float FogSpotLightRadiusFalloff = 1.2f;

        [Tooltip("How much the sun reduces fog lights. As sun intensity approaches 1, fog light intensity is reduced by this value.")]
        [Range(0.0f, 1.0f)]
        public float FogLightSunIntensityReducer = 0.8f;

        [Tooltip("Noise texture for fog and other 3D effects.")]
        public Texture3D NoiseTexture3D;

        /// <summary>
        /// First object in Suns
        /// </summary>
        public WeatherMakerCelestialObjectScript Sun { get { return (Suns == null || Suns.Count == 0 ? null : Suns[0]); } }

        [Header("Celestial objects")]
        [Tooltip("Suns (only one supported for now)")]
        public List<WeatherMakerCelestialObjectScript> Suns = new List<WeatherMakerCelestialObjectScript>();

        [Tooltip("Moons (up to eight are supported)")]
        public List<WeatherMakerCelestialObjectScript> Moons = new List<WeatherMakerCelestialObjectScript>();

        /// <summary>
        /// Directional light intensity multipliers - all are applied to the final directional light intensities
        /// </summary>
        [NonSerialized]
        public readonly Dictionary<string, float> DirectionalLightIntensityMultipliers = new Dictionary<string, float>();

        /// <summary>
        /// Directional light shadow intensity multipliers - all are applied to the final directional light shadow intensities
        /// </summary>
        [NonSerialized]
        public readonly Dictionary<string, float> DirectionalLightShadowIntensityMultipliers = new Dictionary<string, float>();

        /// <summary>
        /// The planes of the current camera view frustum
        /// </summary>
        [HideInInspector]
        public readonly Plane[] CurrentCameraFrustumPlanes = new Plane[6];

        /// <summary>
        /// The current bounds if checking a collider and not a camera
        /// </summary>
        [HideInInspector]
        public Bounds CurrentBounds;

        /// <summary>
        /// Null zones - this is handled automatically as null zone scripts are added
        /// </summary>
        public readonly List<WeatherMakerNullZoneScript> NullZones = new List<WeatherMakerNullZoneScript>();

        private readonly Vector4[] nullZoneArrayMin = new Vector4[MaximumNullZones];
        private readonly Vector4[] nullZoneArrayMax = new Vector4[MaximumNullZones];
        private readonly Vector4[] nullZoneArrayCenter = new Vector4[MaximumNullZones];
        private readonly Vector4[] nullZoneArrayQuaternion = new Vector4[MaximumNullZones];

        /// <summary>
        /// Global shared copy of NoiseTexture3D
        /// </summary>
        public static Texture3D NoiseTexture3DInstance { get; private set; }

        /// <summary>
        /// Max number of null zones - the n closest will be sent to shaders.
        /// </summary>
        public const int MaximumNullZones = 16;

        /// <summary>
        /// Maximum number of lights to send to the Weather Maker shaders - reduce if you are having performance problems
        /// This should match the constant 'MAX_LIGHT_COUNT' in WeatherMakerShader.cginc
        /// </summary>
        public const int MaximumLightCount = 16;

        /// <summary>
        /// Max number of moons supported. This should match the constant in WeatherMakerShader.cginc.
        /// </summary>
        public const int MaxMoonCount = 8;

        // dir lights
        private readonly Vector4[] lightPositionsDir = new Vector4[MaximumLightCount];
        private readonly Vector4[] lightDirectionsDir = new Vector4[MaximumLightCount];
        private readonly Vector4[] lightColorsDir = new Vector4[MaximumLightCount];
        private readonly Vector4[] lightViewportPositionsDir = new Vector4[MaximumLightCount];
        private readonly Vector4[] lightPowerDir = new Vector4[MaximumLightCount];
        private readonly Vector4[] lightQuaternionDir = new Vector4[MaximumLightCount];

        // point lights
        private readonly Vector4[] lightPositionsPoint = new Vector4[MaximumLightCount];
        private readonly Vector4[] lightDirectionsPoint = new Vector4[MaximumLightCount];
        private readonly Vector4[] lightColorsPoint = new Vector4[MaximumLightCount];
        private readonly Vector4[] lightAttenPoint = new Vector4[MaximumLightCount];
        private readonly Vector4[] lightViewportPositionsPoint = new Vector4[MaximumLightCount];
        private readonly Vector4[] lightPowerPoint = new Vector4[MaximumLightCount];

        // spot lights
        private readonly Vector4[] lightPositionsSpot = new Vector4[MaximumLightCount];
        private readonly Vector4[] lightDirectionsSpot = new Vector4[MaximumLightCount];
        private readonly Vector4[] lightEndsSpot = new Vector4[MaximumLightCount];
        private readonly Vector4[] lightColorsSpot = new Vector4[MaximumLightCount];
        private readonly Vector4[] lightAttenSpot = new Vector4[MaximumLightCount];
        private readonly Vector4[] lightViewportPositionsSpot = new Vector4[MaximumLightCount];
        private readonly Vector4[] lightPowerSpot = new Vector4[MaximumLightCount];

        // area lights
        private readonly Vector4[] lightPositionsArea = new Vector4[MaximumLightCount];
        private readonly Vector4[] lightPositionsEndArea = new Vector4[MaximumLightCount];
        private readonly Vector4[] lightPositionsMinArea = new Vector4[MaximumLightCount];
        private readonly Vector4[] lightPositionsMaxArea = new Vector4[MaximumLightCount];
        private readonly Vector4[] lightRotationArea = new Vector4[MaximumLightCount];
        private readonly Vector4[] lightDirectionArea = new Vector4[MaximumLightCount];
        private readonly Vector4[] lightColorsArea = new Vector4[MaximumLightCount];
        private readonly Vector4[] lightAttenArea = new Vector4[MaximumLightCount];
        private readonly Vector4[] lightViewportPositionsArea = new Vector4[MaximumLightCount];
        private readonly Vector4[] lightPowerArea = new Vector4[MaximumLightCount];

        private readonly Vector4[] moonDirectionUpShaderBuffer = new Vector4[MaxMoonCount];
        private readonly Vector4[] moonDirectionDownShaderBuffer = new Vector4[MaxMoonCount];
        private readonly Vector4[] moonLightColorShaderBuffer = new Vector4[MaxMoonCount];
        private readonly Vector4[] moonLightPowerShaderBuffer = new Vector4[MaxMoonCount];
        private readonly Vector4[] moonTintColorShaderBuffer = new Vector4[MaxMoonCount];
        private readonly Vector4[] moonVar1ShaderBuffer = new Vector4[MaxMoonCount];

        // unused, but needed for GetLightProperties when result is unused
        private Vector4 tempVec = Vector3.zero;

        /// <summary>
        /// A list of all the lights, sorted by importance of light
        /// </summary>
        private readonly List<Light> lights = new List<Light>();

        private bool autoFoundLights;
        private Vector3 currentLightSortPosition;

        // state for intersection test
        private delegate bool IntersectsFuncDelegate(ref Bounds bounds);
        private IntersectsFuncDelegate intersectsFuncCurrentCamera;
        private IntersectsFuncDelegate intersectsFuncCurrentBounds;
        private IntersectsFuncDelegate intersectsFunc;

        private void NormalizePlane(ref Plane plane)
        {
            float length = plane.normal.magnitude;
            plane.normal /= length;
            plane.distance /= length;
        }

        private void CalculateFrustumPlanes(Camera camera)
        {
            Matrix4x4 mat = camera.projectionMatrix * camera.worldToCameraMatrix;

            // left
            CurrentCameraFrustumPlanes[0].normal = new Vector3(mat.m30 + mat.m00, mat.m31 + mat.m01, mat.m32 + mat.m02);
            CurrentCameraFrustumPlanes[0].distance = mat.m33 + mat.m03;

            // right
            CurrentCameraFrustumPlanes[1].normal = new Vector3(mat.m30 - mat.m00, mat.m31 - mat.m01, mat.m32 - mat.m02);
            CurrentCameraFrustumPlanes[1].distance = mat.m33 - mat.m03;

            // bottom
            CurrentCameraFrustumPlanes[2].normal = new Vector3(mat.m30 + mat.m10, mat.m31 + mat.m11, mat.m32 + mat.m12);
            CurrentCameraFrustumPlanes[2].distance = mat.m33 + mat.m13;

            // top
            CurrentCameraFrustumPlanes[3].normal = new Vector3(mat.m30 - mat.m10, mat.m31 - mat.m11, mat.m32 - mat.m12);
            CurrentCameraFrustumPlanes[3].distance = mat.m33 - mat.m13;

            // near
            CurrentCameraFrustumPlanes[4].normal = new Vector3(mat.m30 + mat.m20, mat.m31 + mat.m21, mat.m32 + mat.m22);
            CurrentCameraFrustumPlanes[4].distance = mat.m33 + mat.m23;

            // far
            CurrentCameraFrustumPlanes[5].normal = new Vector3(mat.m30 - mat.m20, mat.m31 - mat.m21, mat.m32 - mat.m22);
            CurrentCameraFrustumPlanes[5].distance = mat.m33 - mat.m23;

            // normalize
            NormalizePlane(ref CurrentCameraFrustumPlanes[0]);
            NormalizePlane(ref CurrentCameraFrustumPlanes[1]);
            NormalizePlane(ref CurrentCameraFrustumPlanes[2]);
            NormalizePlane(ref CurrentCameraFrustumPlanes[3]);
            NormalizePlane(ref CurrentCameraFrustumPlanes[4]);
            NormalizePlane(ref CurrentCameraFrustumPlanes[5]);
        }

        private bool IntersectsFunctionCurrentCamera(ref Bounds bounds)
        {
            return GeometryUtility.TestPlanesAABB(CurrentCameraFrustumPlanes, bounds);
        }

        private bool IntersectsFunctionCurrentBounds(ref Bounds bounds)
        {
            return CurrentBounds.Intersects(bounds);
        }

        private bool PointLightIntersect(Light light)
        {
            float range = light.range + 1.0f;
            Bounds lightBounds = new Bounds { center = light.transform.position, extents = new Vector3(range, range, range) };
            return intersectsFunc(ref lightBounds);
        }

        private bool SpotLightIntersect(Light light)
        {
            float range = light.range + 1.0f;
            Bounds lightBounds = new Bounds { center = light.transform.position + (light.transform.forward * range * 0.5f), extents = new Vector3(range, range, range) };
            return intersectsFunc(ref lightBounds);
        }

        private bool AreaLightIntersect(ref Bounds lightBounds)
        {
            return intersectsFunc(ref lightBounds);
        }

        public WeatherMakerCelestialObjectScript GetCelestialObject(Light light)
        {
            return light.GetComponent<WeatherMakerCelestialObjectScript>();
        }

        private bool ProcessLightProperties(Light light, Camera camera, ref Vector4 pos, ref Vector4 pos2, ref Vector4 pos3, ref Vector4 atten, ref Vector4 color, ref Vector4 dir, ref Vector4 dir2, ref Vector4 end, ref Vector4 viewportPos, ref Vector4 lightPower)
        {
            if (light == null || !light.enabled || light.color.a <= 0.001f || light.intensity <= 0.001f || light.range <= 0.001f)
            {
                return false;
            }

            SetShaderViewportPosition(light, camera, ref viewportPos);
            color = new Vector4(light.color.r, light.color.g, light.color.b, light.intensity);
            lightPower = Vector4.zero;
            pos2 = lightPower;
            dir2 = lightPower;

            switch (light.type)
            {
                case LightType.Directional:
                    {
                        WeatherMakerCelestialObjectScript obj = GetCelestialObject(light);
                        pos = -light.transform.forward;
                        pos.w = -1.0f;
                        dir = light.transform.forward;
                        dir.w = 1.0f;
                        end = Vector4.zero;
                        atten = new Vector4(-1.0f, 1.0f, 0.0f, 0.0f);
                        if (light.shadows == LightShadows.None)
                        {
                            if (obj == null)
                            {
                                lightPower = new Vector4(1.0f, 1.0f, light.shadowStrength, 1.0f);
                            }
                            else
                            {
                                lightPower = new Vector4(obj.LightPower, obj.LightMultiplier, light.shadowStrength, 1.0f);
                            }
                        }
                        else if (obj == null)
                        {
                            lightPower = new Vector4(1.0f, 1.0f, light.shadowStrength, 1.0f - light.shadowStrength);
                        }
                        else
                        {
                            lightPower = new Vector4(obj.LightPower, obj.LightMultiplier, light.shadowStrength, 1.0f - light.shadowStrength);
                        }
                        return true;
                    }

                case LightType.Spot:
                    {
                        if (!SpotLightIntersect(light))
                        {
                            return false;
                        }

                        float radius = light.range * Mathf.Tan(0.5f * light.spotAngle * Mathf.Deg2Rad);
                        end = light.transform.position + (light.transform.forward * light.range); // center of cone base
                        float rangeSquared = Mathf.Sqrt((radius * radius) + (light.range * light.range));
                        end.w = rangeSquared * rangeSquared; // slant length squared
                        rangeSquared = light.range * light.range;
                        float outerCutOff = Mathf.Cos(light.spotAngle * 0.5f * Mathf.Deg2Rad);
                        float cutOff = 1.0f / (Mathf.Cos(light.spotAngle * 0.25f * Mathf.Deg2Rad) - outerCutOff);
                        atten = new Vector4(outerCutOff, cutOff, SpotLightQuadraticAttenuation / rangeSquared, 1.0f / rangeSquared);
                        pos = light.transform.position; // apex
                        pos.w = Mathf.Pow(light.spotAngle * Mathf.Deg2Rad / Mathf.PI, 0.5f); // falloff resistor, thinner angles do not fall off at edges
                        dir = light.transform.forward; // direction cone is facing from apex
                        dir.w = radius * radius; // radius at base squared
                        return true;
                    }

                case LightType.Point:
                    {
                        if (!PointLightIntersect(light))
                        {
                            return false;
                        }

                        float rangeSquared = light.range * light.range;
                        pos = light.transform.position;
                        pos.w = rangeSquared;
                        dir = light.transform.position.normalized;
                        end = Vector4.zero;
                        atten = new Vector4(-1.0f, 1.0f, PointLightQuadraticAttenuation / rangeSquared, 1.0f / rangeSquared);
                        return true;
                    }

                case LightType.Area:
                    {
                        if (AreaLightQuadraticAttenuation > 0.0f)
                        {
                            float range = light.range;
                            float rangeSquared = range * range;
                            dir2 = light.transform.forward;
                            dir2.w = 0.0f;
                            pos = light.transform.position;
                            pos2 = (Vector3)pos + ((Vector3)dir2 * range);
                            Quaternion rot = light.transform.rotation;
                            Vector2 areaSize = light.transform.lossyScale * AreaLightAreaMultiplier;
                            Vector3 minOffset = (Vector3)pos + (new Vector3(-0.5f * areaSize.x, -0.5f * areaSize.y, 0.0f));
                            Vector3 maxOffset = (Vector3)pos + (new Vector3(0.5f * areaSize.x, 0.5f * areaSize.y, range));
                            float maxValue = Mathf.Max(areaSize.x, areaSize.y);
                            maxValue = Mathf.Max(maxValue, range);
                            Bounds bounds = new Bounds((Vector3)pos + ((Vector3)dir2 * light.range * 0.5f), Vector3.one * maxValue);
                            if (!AreaLightIntersect(ref bounds))
                            {
                                return false;
                            }
                            pos.w = rangeSquared;
                            dir = new Vector4(rot.x, rot.y, rot.z, rot.w);
                            pos3 = minOffset - (Vector3)pos;
                            pos3.w = 0.0f;
                            end = maxOffset - (Vector3)pos;
                            end.w = 0.0f;
                            float attenAvg = (areaSize.x + areaSize.y) * 0.5f;
                            float radiusSquared = (attenAvg * AreaLightFalloff);
                            radiusSquared *= radiusSquared;
                            atten = new Vector4(1.0f / radiusSquared, attenAvg, AreaLightQuadraticAttenuation / rangeSquared, 1.0f / rangeSquared);
                            return true;
                        } break;
                    }
            }
            return false;
        }

        private System.Comparison<Light> lightSorterReference;
        private int LightSorter(Light light1, Light light2)
        {
            int compare = 0;

            if (light1 == light2)
            {
                return compare;
            }
            compare = light1.type.CompareTo(light2.type);
            if (compare == 0)
            {
                if (light1.type == LightType.Directional)
                {
                    // shadow casting dir lights have higher priority
                    compare = light2.shadows.CompareTo(light1.shadows);
                    if (compare == 0)
                    {
                        compare = light2.intensity.CompareTo(light1.intensity);
                    }
                }
                else
                {
                    // compare by distance, then by intensity
                    float mag1 = Mathf.Max(0.0f, Vector3.Distance(light1.transform.position, currentLightSortPosition) - light1.range);
                    float mag2 = Mathf.Max(0.0f, Vector3.Distance(light2.transform.position, currentLightSortPosition) - light2.range);
                    compare = mag1.CompareTo(mag2);
                    if (compare == 0)
                    {
                        compare = light2.intensity.CompareTo(light1.intensity);
                    }
                }
            }
            return compare;
        }

        private System.Comparison<WeatherMakerNullZoneScript> nullZoneSorterReference;
        private int NullZoneSorter(WeatherMakerNullZoneScript b1, WeatherMakerNullZoneScript b2)
        {
            // sort by distance from camera
            float d1 = Vector3.SqrMagnitude(b1.bounds.center - currentLightSortPosition);
            float d2 = Vector3.SqrMagnitude(b2.bounds.center - currentLightSortPosition);
            return d1.CompareTo(d2);
        }

        private void SetLightsByTypeToShader(Camera camera, Material m)
        {
            int dirLightCount = 0;
            int pointLightCount = 0;
            int spotLightCount = 0;
            int areaLightCount = 0;

            for (int i = 0; i < lights.Count; i++)
            {
                Light light = lights[i];
                if (light == null)
                {
                    lights.RemoveAt(i--);
                    continue;
                }

                switch (light.type)
                {
                    case LightType.Directional:
                        if (dirLightCount < MaximumLightCount && ProcessLightProperties(light, camera, ref lightPositionsDir[dirLightCount], ref tempVec, ref tempVec, ref tempVec, ref lightColorsDir[dirLightCount], ref lightDirectionsDir[dirLightCount], ref tempVec, ref tempVec, ref lightViewportPositionsDir[dirLightCount], ref lightPowerDir[dirLightCount]))
                        {
                            Quaternion rot = light.transform.rotation;
                            lightQuaternionDir[dirLightCount] = new Vector4(rot.x, rot.y, rot.z, rot.w);
                            dirLightCount++;
                        }
                        break;

                    case LightType.Point:
                        if (pointLightCount < MaximumLightCount && ProcessLightProperties(light, camera, ref lightPositionsPoint[pointLightCount], ref tempVec, ref tempVec, ref lightAttenPoint[pointLightCount], ref lightColorsPoint[pointLightCount], ref lightDirectionsPoint[pointLightCount], ref tempVec, ref tempVec, ref lightViewportPositionsPoint[pointLightCount], ref lightPowerPoint[pointLightCount]))
                        {
                            pointLightCount++;
                        }
                        break;

                    case LightType.Spot:
                        if (spotLightCount < MaximumLightCount && ProcessLightProperties(light, camera, ref lightPositionsSpot[spotLightCount], ref tempVec, ref tempVec, ref lightAttenSpot[spotLightCount], ref lightColorsSpot[spotLightCount], ref lightDirectionsSpot[spotLightCount], ref tempVec, ref lightEndsSpot[spotLightCount], ref lightViewportPositionsSpot[spotLightCount], ref lightPowerSpot[spotLightCount]))
                        {
                            spotLightCount++;
                        }
                        break;

                    case LightType.Area:
                        if (areaLightCount < MaximumLightCount && ProcessLightProperties(light, camera, ref lightPositionsArea[areaLightCount], ref lightPositionsEndArea[areaLightCount], ref lightPositionsMinArea[areaLightCount], ref lightAttenArea[areaLightCount], ref lightColorsArea[areaLightCount], ref lightRotationArea[areaLightCount], ref lightDirectionArea[areaLightCount], ref lightPositionsMaxArea[areaLightCount], ref lightViewportPositionsArea[areaLightCount], ref lightPowerArea[areaLightCount]))
                        {
                            areaLightCount++;
                        }
                        break;

                    default:
                        break;
                }
            }

            if (m == null)
            {
                // dir lights
                Shader.SetGlobalInt("_WeatherMakerDirLightCount", dirLightCount);
                Shader.SetGlobalVectorArray("_WeatherMakerDirLightPosition", lightPositionsDir);
                Shader.SetGlobalVectorArray("_WeatherMakerDirLightDirection", lightDirectionsDir);
                Shader.SetGlobalVectorArray("_WeatherMakerDirLightColor", lightColorsDir);
                Shader.SetGlobalVectorArray("_WeatherMakerDirLightViewportPosition", lightViewportPositionsDir);
                Shader.SetGlobalVectorArray("_WeatherMakerDirLightPower", lightPowerDir);
                Shader.SetGlobalVectorArray("_WeatherMakerDirLightQuaternion", lightQuaternionDir);

                // point lights
                Shader.SetGlobalInt("_WeatherMakerPointLightCount", pointLightCount);
                Shader.SetGlobalVectorArray("_WeatherMakerPointLightPosition", lightPositionsPoint);
                Shader.SetGlobalVectorArray("_WeatherMakerPointLightDirection", lightDirectionsPoint);
                Shader.SetGlobalVectorArray("_WeatherMakerPointLightColor", lightColorsPoint);
                Shader.SetGlobalVectorArray("_WeatherMakerPointLightAtten", lightAttenPoint);
                Shader.SetGlobalVectorArray("_WeatherMakerPointLightViewportPosition", lightViewportPositionsPoint);

                // spot lights
                Shader.SetGlobalInt("_WeatherMakerSpotLightCount", spotLightCount);
                Shader.SetGlobalVectorArray("_WeatherMakerSpotLightPosition", lightPositionsSpot);
                Shader.SetGlobalVectorArray("_WeatherMakerSpotLightColor", lightColorsSpot);
                Shader.SetGlobalVectorArray("_WeatherMakerSpotLightAtten", lightAttenSpot);
                Shader.SetGlobalVectorArray("_WeatherMakerSpotLightDirection", lightDirectionsSpot);
                Shader.SetGlobalVectorArray("_WeatherMakerSpotLightSpotEnd", lightEndsSpot);
                Shader.SetGlobalVectorArray("_WeatherMakerSpotLightViewportPosition", lightViewportPositionsSpot);

                // area lights
                Shader.SetGlobalInt("_WeatherMakerAreaLightCount", areaLightCount);
                Shader.SetGlobalVectorArray("_WeatherMakerAreaLightPosition", lightPositionsArea);
                Shader.SetGlobalVectorArray("_WeatherMakerAreaLightPositionEnd", lightPositionsEndArea);
                Shader.SetGlobalVectorArray("_WeatherMakerAreaLightMinPosition", lightPositionsMinArea);
                Shader.SetGlobalVectorArray("_WeatherMakerAreaLightMaxPosition", lightPositionsMaxArea);
                Shader.SetGlobalVectorArray("_WeatherMakerAreaLightColor", lightColorsArea);
                Shader.SetGlobalVectorArray("_WeatherMakerAreaLightAtten", lightAttenArea);
                Shader.SetGlobalVectorArray("_WeatherMakerAreaLightRotation", lightRotationArea);
                Shader.SetGlobalVectorArray("_WeatherMakerAreaLightDirection", lightDirectionArea);
                Shader.SetGlobalVectorArray("_WeatherMakerAreaLightViewportPosition", lightViewportPositionsArea);
            }
            else
            {
                // dir lights
                m.SetInt("_WeatherMakerDirLightCount", dirLightCount);
                m.SetVectorArray("_WeatherMakerDirLightPosition", lightPositionsDir);
                m.SetVectorArray("_WeatherMakerDirLightDirection", lightDirectionsDir);
                m.SetVectorArray("_WeatherMakerDirLightColor", lightColorsDir);
                m.SetVectorArray("_WeatherMakerDirLightViewportPosition", lightViewportPositionsDir);
                m.SetVectorArray("_WeatherMakerDirLightPower", lightPowerDir);
                m.SetVectorArray("_WeatherMakerDirLightQuaternion", lightQuaternionDir);

                // point lights
                m.SetInt("_WeatherMakerPointLightCount", pointLightCount);
                m.SetVectorArray("_WeatherMakerPointLightPosition", lightPositionsPoint);
                m.SetVectorArray("_WeatherMakerPointLightDirection", lightDirectionsPoint);
                m.SetVectorArray("_WeatherMakerPointLightColor", lightColorsPoint);
                m.SetVectorArray("_WeatherMakerPointLightAtten", lightAttenPoint);
                m.SetVectorArray("_WeatherMakerPointLightViewportPosition", lightViewportPositionsPoint);

                // spot lights
                m.SetInt("_WeatherMakerSpotLightCount", spotLightCount);
                m.SetVectorArray("_WeatherMakerSpotLightPosition", lightPositionsSpot);
                m.SetVectorArray("_WeatherMakerSpotLightColor", lightColorsSpot);
                m.SetVectorArray("_WeatherMakerSpotLightAtten", lightAttenSpot);
                m.SetVectorArray("_WeatherMakerSpotLightDirection", lightDirectionsSpot);
                m.SetVectorArray("_WeatherMakerSpotLightSpotEnd", lightEndsSpot);
                m.SetVectorArray("_WeatherMakerSpotLightViewportPosition", lightViewportPositionsSpot);

                // area lights
                m.SetInt("_WeatherMakerAreaLightCount", areaLightCount);
                m.SetVectorArray("_WeatherMakerAreaLightPosition", lightPositionsArea);
                m.SetVectorArray("_WeatherMakerAreaLightPositionEnd", lightPositionsEndArea);
                m.SetVectorArray("_WeatherMakerAreaLightMinPosition", lightPositionsMinArea);
                m.SetVectorArray("_WeatherMakerAreaLightMaxPosition", lightPositionsMaxArea);
                m.SetVectorArray("_WeatherMakerAreaLightColor", lightColorsArea);
                m.SetVectorArray("_WeatherMakerAreaLightAtten", lightAttenArea);
                m.SetVectorArray("_WeatherMakerAreaLightRotation", lightRotationArea);
                m.SetVectorArray("_WeatherMakerAreaLightDirection", lightDirectionArea);
                m.SetVectorArray("_WeatherMakerAreaLightViewportPosition", lightViewportPositionsArea);
            }
        }

        private void Create3DNoiseTexture()
        {

#if UNITY_EDITOR

            /*
            TextAsset data = Resources.Load("WeatherMakerTextureFogNoise3D") as TextAsset;
            if (data == null)
            {
                return;
            }

            byte[] bytes = data.bytes;
            uint height = BitConverter.ToUInt32(data.bytes, 12);
            uint width = BitConverter.ToUInt32(data.bytes, 16);
            uint pitch = BitConverter.ToUInt32(data.bytes, 20);
            uint depth = BitConverter.ToUInt32(data.bytes, 24);
            uint formatFlags = BitConverter.ToUInt32(data.bytes, 20 * 4);
            uint fourCC = BitConverter.ToUInt32(data.bytes, 21 * 4);
            uint bitdepth = BitConverter.ToUInt32(data.bytes, 22 * 4);
            if (bitdepth == 0)
            {
                bitdepth = pitch / width * 8;
            }

            Texture3D t = new Texture3D((int)width, (int)height, (int)depth, TextureFormat.Alpha8, false);
            t.filterMode = FilterMode.Bilinear;
            t.wrapMode = TextureWrapMode.Repeat;
            t.name = "Noise 3D (Weather Maker)";

            Color32[] c = new Color32[width * height * depth];

            uint index = 128;
            if (data.bytes[21 * 4] == 'D' && data.bytes[21 * 4 + 1] == 'X' && data.bytes[21 * 4 + 2] == '1' &&
                data.bytes[21 * 4 + 3] == '0' && (formatFlags & 0x4) != 0)
            {
                uint format = BitConverter.ToUInt32(data.bytes, (int)index);
                if (format >= 60 && format <= 65)
                {
                    bitdepth = 8;
                }
                else if (format >= 48 && format <= 52)
                {
                    bitdepth = 16;
                }
                else if (format >= 27 && format <= 32)
                {
                    bitdepth = 32;
                }
                index += 20;
            }

            uint byteDepth = bitdepth / 8;
            pitch = (width * bitdepth + 7) / 8;

            for (int d = 0; d < depth; ++d)
            {
                for (int h = 0; h < height; ++h)
                {
                    for (int w = 0; w < width; ++w)
                    {
                        byte v = bytes[index + w * byteDepth];
                        c[w + h * width + d * width * height] = new Color32(v, v, v, v);
                    }

                    index += pitch;
                }
            }

            t.SetPixels32(c);
            t.Apply();
            */

#endif

        }

        private void CleanupCelestialObjects()
        {
            for (int i = Suns.Count - 1; i >= 0; i--)
            {
                if (Suns[i] == null)
                {
                    Suns.RemoveAt(i);
                }
            }
            for (int i = 0; i < Moons.Count; i++)
            {
                if (Moons[i] == null)
                {
                    Moons.RemoveAt(i);
                }
            }
        }

        private void UpdateAllLights()
        {
            CleanupCelestialObjects();

            // if no user lights specified, find all the lights in the scene and sort them
            if ((AutoFindLights == AutoFindLightsMode.Once && !autoFoundLights) || AutoFindLights == AutoFindLightsMode.EveryFrame)
            {
                autoFoundLights = true;
                Light[] allLights = GameObject.FindObjectsOfType<Light>();
                lights.Clear();
                foreach (Light light in allLights)
                {
                    if (light != null && light.enabled && light.intensity > 0.0001f && light.color.a > 0.0001f && (IgnoreLights == null || !IgnoreLights.Contains(light)))
                    {
                        lights.Add(light);
                    }
                }
            }
            else
            {
                if (Sun != null)
                {
                    // add the sun if it is on, else remove it
                    if (Sun.LightIsOn)
                    {
                        AddLight(Sun.Light);
                    }
                    else
                    {
                        RemoveLight(Sun.Light);
                    }
                }
                if (Moons != null)
                {
                    // add each moon if it is on, else remove it
                    foreach (WeatherMakerCelestialObjectScript moon in Moons)
                    {
                        if (moon.LightIsOn)
                        {
                            AddLight(moon.Light);
                        }
                        else
                        {
                            RemoveLight(moon.Light);
                        }
                    }
                }

                if (AutoAddLights != null)
                {
                    // add each auto-add light if it is on, else remove it
                    for (int i = AutoAddLights.Count - 1; i >= 0; i--)
                    {
                        Light light = AutoAddLights[i];
                        if (light == null)
                        {

#if UNITY_EDITOR

                            if (Application.isPlaying)

#endif

                            {
                                AutoAddLights.RemoveAt(i);
                            }
                        }
                        else if (light.intensity == 0.0f || !light.enabled || !light.gameObject.activeInHierarchy)
                        {
                            RemoveLight(light);
                        }
                        else
                        {
                            AddLight(light);
                        }
                    }
                }
            }
        }

        private void UpdateNullZones(Material m)
        {

#if UNITY_EDITOR

            if (!Application.isPlaying)
            {
                return;
            }

#endif

            int nullZoneCount = 0;

            // take out null/disabled fog zones
            for (int i = NullZones.Count - 1; i >= 0; i--)
            {
                if (NullZones[i] == null || !NullZones[i].enabled)
                {
                    NullZones.RemoveAt(i);
                }
            }

            NullZones.Sort(nullZoneSorterReference);
            for (int i = 0; i < NullZones.Count && nullZoneCount < MaximumNullZones; i++)
            {
                if (NullZones[i].NullZoneProfile == null)
                {
                    continue;
                }

                Bounds nullZoneBounds = NullZones[i].bounds;
                Bounds nullZoneBoundsInflated = NullZones[i].inflatedBounds;
                int mask = NullZones[i].CurrentMask;
                if (intersectsFunc(ref nullZoneBoundsInflated))
                {
                    float fade = NullZones[i].CurrentFade;
                    Quaternion r = NullZones[i].transform.rotation;
                    Vector3 center = nullZoneBounds.center;
                    float centerW;
                    if (r == Quaternion.identity)
                    {
                        centerW = 0.0f;
                    }
                    else
                    {
                        // it will be up to the shaders to detect that center w is 1.0 and
                        // perform quaternion rotation on any ray cast, point intersect, etc.
                        centerW = 1.0f;

                        // recompute bounds with no rotation - Unity bounds is the largest box that will contain,
                        // not what we want here, we want an AABB with no rotation centered on 0,0,0.
                        NullZones[i].transform.rotation = Quaternion.identity;
                        nullZoneBounds = NullZones[i].BoxCollider.bounds;
                        NullZones[i].transform.rotation = r;
                        nullZoneBounds.center = Vector3.zero;
                    }
                    nullZoneArrayMin[nullZoneCount] = nullZoneBounds.min;
                    nullZoneArrayMin[nullZoneCount].w = mask;
                    nullZoneArrayMax[nullZoneCount] = nullZoneBounds.max;
                    nullZoneArrayMax[nullZoneCount].w = fade;
                    nullZoneArrayCenter[nullZoneCount] = center;
                    nullZoneArrayCenter[nullZoneCount].w = centerW;
                    nullZoneArrayQuaternion[nullZoneCount] = new Vector4(r.x, r.y, r.z, r.w);
                    nullZoneCount++;
                }
            }
            if (m == null)
            {
                Shader.SetGlobalInt("_NullZoneCount", nullZoneCount);
                Shader.SetGlobalVectorArray("_NullZonesMin", nullZoneArrayMin);
                Shader.SetGlobalVectorArray("_NullZonesMax", nullZoneArrayMax);
                Shader.SetGlobalVectorArray("_NullZonesCenter", nullZoneArrayCenter);
                Shader.SetGlobalVectorArray("_NullZonesQuaternion", nullZoneArrayQuaternion);
            }
            else
            {
                m.SetInt("_NullZoneCount", nullZoneCount);
                m.SetVectorArray("_NullZonesMin", nullZoneArrayMin);
                m.SetVectorArray("_NullZonesMax", nullZoneArrayMax);
                m.SetVectorArray("_NullZonesCenter", nullZoneArrayCenter);
                m.SetVectorArray("_NullZonesQuaternion", nullZoneArrayQuaternion);
            }
        }

#if CREATE_DITHER_TEXTURE_FOR_WEATHER_MAKER_LIGHT_MANAGER

        private void CreateDitherTexture()
        {
            if (DitherTextureInstance != null)
            {
                return;
            }

#if DITHER_4_4

            int size = 4;

#else

            int size = 8;

#endif

            DitherTextureInstance = new Texture2D(size, size, TextureFormat.Alpha8, false, true);
            DitherTextureInstance.filterMode = FilterMode.Point;
            Color32[] c = new Color32[size * size];

            byte b;

#if DITHER_4_4

            b = (byte)(0.0f / 16.0f * 255); c[0] = new Color32(b, b, b, b);
            b = (byte)(8.0f / 16.0f * 255); c[1] = new Color32(b, b, b, b);
            b = (byte)(2.0f / 16.0f * 255); c[2] = new Color32(b, b, b, b);
            b = (byte)(10.0f / 16.0f * 255); c[3] = new Color32(b, b, b, b);

            b = (byte)(12.0f / 16.0f * 255); c[4] = new Color32(b, b, b, b);
            b = (byte)(4.0f / 16.0f * 255); c[5] = new Color32(b, b, b, b);
            b = (byte)(14.0f / 16.0f * 255); c[6] = new Color32(b, b, b, b);
            b = (byte)(6.0f / 16.0f * 255); c[7] = new Color32(b, b, b, b);

            b = (byte)(3.0f / 16.0f * 255); c[8] = new Color32(b, b, b, b);
            b = (byte)(11.0f / 16.0f * 255); c[9] = new Color32(b, b, b, b);
            b = (byte)(1.0f / 16.0f * 255); c[10] = new Color32(b, b, b, b);
            b = (byte)(9.0f / 16.0f * 255); c[11] = new Color32(b, b, b, b);

            b = (byte)(15.0f / 16.0f * 255); c[12] = new Color32(b, b, b, b);
            b = (byte)(7.0f / 16.0f * 255); c[13] = new Color32(b, b, b, b);
            b = (byte)(13.0f / 16.0f * 255); c[14] = new Color32(b, b, b, b);
            b = (byte)(5.0f / 16.0f * 255); c[15] = new Color32(b, b, b, b);

#else

            int i = 0;
            b = (byte)(1.0f / 65.0f * 255); c[i++] = new Color32(b, b, b, b);
            b = (byte)(49.0f / 65.0f * 255); c[i++] = new Color32(b, b, b, b);
            b = (byte)(13.0f / 65.0f * 255); c[i++] = new Color32(b, b, b, b);
            b = (byte)(61.0f / 65.0f * 255); c[i++] = new Color32(b, b, b, b);
            b = (byte)(4.0f / 65.0f * 255); c[i++] = new Color32(b, b, b, b);
            b = (byte)(52.0f / 65.0f * 255); c[i++] = new Color32(b, b, b, b);
            b = (byte)(16.0f / 65.0f * 255); c[i++] = new Color32(b, b, b, b);
            b = (byte)(64.0f / 65.0f * 255); c[i++] = new Color32(b, b, b, b);

            b = (byte)(33.0f / 65.0f * 255); c[i++] = new Color32(b, b, b, b);
            b = (byte)(17.0f / 65.0f * 255); c[i++] = new Color32(b, b, b, b);
            b = (byte)(45.0f / 65.0f * 255); c[i++] = new Color32(b, b, b, b);
            b = (byte)(29.0f / 65.0f * 255); c[i++] = new Color32(b, b, b, b);
            b = (byte)(36.0f / 65.0f * 255); c[i++] = new Color32(b, b, b, b);
            b = (byte)(20.0f / 65.0f * 255); c[i++] = new Color32(b, b, b, b);
            b = (byte)(48.0f / 65.0f * 255); c[i++] = new Color32(b, b, b, b);
            b = (byte)(32.0f / 65.0f * 255); c[i++] = new Color32(b, b, b, b);

            b = (byte)(9.0f / 65.0f * 255); c[i++] = new Color32(b, b, b, b);
            b = (byte)(57.0f / 65.0f * 255); c[i++] = new Color32(b, b, b, b);
            b = (byte)(5.0f / 65.0f * 255); c[i++] = new Color32(b, b, b, b);
            b = (byte)(53.0f / 65.0f * 255); c[i++] = new Color32(b, b, b, b);
            b = (byte)(12.0f / 65.0f * 255); c[i++] = new Color32(b, b, b, b);
            b = (byte)(60.0f / 65.0f * 255); c[i++] = new Color32(b, b, b, b);
            b = (byte)(8.0f / 65.0f * 255); c[i++] = new Color32(b, b, b, b);
            b = (byte)(56.0f / 65.0f * 255); c[i++] = new Color32(b, b, b, b);

            b = (byte)(41.0f / 65.0f * 255); c[i++] = new Color32(b, b, b, b);
            b = (byte)(25.0f / 65.0f * 255); c[i++] = new Color32(b, b, b, b);
            b = (byte)(37.0f / 65.0f * 255); c[i++] = new Color32(b, b, b, b);
            b = (byte)(21.0f / 65.0f * 255); c[i++] = new Color32(b, b, b, b);
            b = (byte)(44.0f / 65.0f * 255); c[i++] = new Color32(b, b, b, b);
            b = (byte)(28.0f / 65.0f * 255); c[i++] = new Color32(b, b, b, b);
            b = (byte)(40.0f / 65.0f * 255); c[i++] = new Color32(b, b, b, b);
            b = (byte)(24.0f / 65.0f * 255); c[i++] = new Color32(b, b, b, b);

            b = (byte)(3.0f / 65.0f * 255); c[i++] = new Color32(b, b, b, b);
            b = (byte)(51.0f / 65.0f * 255); c[i++] = new Color32(b, b, b, b);
            b = (byte)(15.0f / 65.0f * 255); c[i++] = new Color32(b, b, b, b);
            b = (byte)(63.0f / 65.0f * 255); c[i++] = new Color32(b, b, b, b);
            b = (byte)(2.0f / 65.0f * 255); c[i++] = new Color32(b, b, b, b);
            b = (byte)(50.0f / 65.0f * 255); c[i++] = new Color32(b, b, b, b);
            b = (byte)(14.0f / 65.0f * 255); c[i++] = new Color32(b, b, b, b);
            b = (byte)(62.0f / 65.0f * 255); c[i++] = new Color32(b, b, b, b);

            b = (byte)(35.0f / 65.0f * 255); c[i++] = new Color32(b, b, b, b);
            b = (byte)(19.0f / 65.0f * 255); c[i++] = new Color32(b, b, b, b);
            b = (byte)(47.0f / 65.0f * 255); c[i++] = new Color32(b, b, b, b);
            b = (byte)(31.0f / 65.0f * 255); c[i++] = new Color32(b, b, b, b);
            b = (byte)(34.0f / 65.0f * 255); c[i++] = new Color32(b, b, b, b);
            b = (byte)(18.0f / 65.0f * 255); c[i++] = new Color32(b, b, b, b);
            b = (byte)(46.0f / 65.0f * 255); c[i++] = new Color32(b, b, b, b);
            b = (byte)(30.0f / 65.0f * 255); c[i++] = new Color32(b, b, b, b);

            b = (byte)(11.0f / 65.0f * 255); c[i++] = new Color32(b, b, b, b);
            b = (byte)(59.0f / 65.0f * 255); c[i++] = new Color32(b, b, b, b);
            b = (byte)(7.0f / 65.0f * 255); c[i++] = new Color32(b, b, b, b);
            b = (byte)(55.0f / 65.0f * 255); c[i++] = new Color32(b, b, b, b);
            b = (byte)(10.0f / 65.0f * 255); c[i++] = new Color32(b, b, b, b);
            b = (byte)(58.0f / 65.0f * 255); c[i++] = new Color32(b, b, b, b);
            b = (byte)(6.0f / 65.0f * 255); c[i++] = new Color32(b, b, b, b);
            b = (byte)(54.0f / 65.0f * 255); c[i++] = new Color32(b, b, b, b);

            b = (byte)(43.0f / 65.0f * 255); c[i++] = new Color32(b, b, b, b);
            b = (byte)(27.0f / 65.0f * 255); c[i++] = new Color32(b, b, b, b);
            b = (byte)(39.0f / 65.0f * 255); c[i++] = new Color32(b, b, b, b);
            b = (byte)(23.0f / 65.0f * 255); c[i++] = new Color32(b, b, b, b);
            b = (byte)(42.0f / 65.0f * 255); c[i++] = new Color32(b, b, b, b);
            b = (byte)(26.0f / 65.0f * 255); c[i++] = new Color32(b, b, b, b);
            b = (byte)(38.0f / 65.0f * 255); c[i++] = new Color32(b, b, b, b);
            b = (byte)(22.0f / 65.0f * 255); c[i++] = new Color32(b, b, b, b);
#endif

            DitherTextureInstance.SetPixels32(c);
            DitherTextureInstance.Apply();
        }

#endif


        private void SetShaderViewportPosition(Light light, Camera camera, ref Vector4 viewportPosition)
        {
            if (camera == null || WeatherMakerFullScreenEffect.GetCameraType(camera) != WeatherMakerCameraType.Normal)
            {
                return;
            }

            viewportPosition = camera.WorldToViewportPoint(light.transform.position);

            // as dir light leaves viewport or goes below horizon, fade out
            Vector2 viewportCenter = new Vector2((camera.rect.min.x + camera.rect.max.x) * 0.5f, (camera.rect.min.y + camera.rect.max.y) * 0.5f);
            float distanceFromCenterViewport = ((Vector2)viewportPosition - viewportCenter).magnitude * 0.5f;
            float distanceFromHorizon = Mathf.Max(0.0f, -light.transform.forward.y);
            viewportPosition.w = light.intensity * Mathf.SmoothStep(1.0f, 0.0f, distanceFromCenterViewport) * distanceFromHorizon;
            if (Sun != null && light == Sun.Light)
            {
                Sun.ViewportPosition = viewportPosition;
                Shader.SetGlobalVector("_WeatherMakerSunViewportPosition", viewportPosition);
                return;
            }
            if (Moons != null)
            {
                foreach (WeatherMakerCelestialObjectScript obj in Moons)
                {
                    if (obj.Light != null && obj.Light == light)
                    {
                        obj.ViewportPosition = viewportPosition;
                        break;
                    }
                }
            }
        }

        private void SetGlobalShaders()
        {
            if (Sun != null)
            {
                // reduce volumetric point/spot lights based on sun strength
                if (Sun.Light != null)
                {
                    float volumetricLightMultiplier = Mathf.Max(0.0f, (1.0f - (Sun.Light.intensity * FogLightSunIntensityReducer)));
                    Shader.SetGlobalFloat("_WeatherMakerVolumetricPointSpotMultiplier", volumetricLightMultiplier);
                }

                // Sun
                Vector3 sunForward = Sun.transform.forward;
                Vector3 sunForward2D = Quaternion.AngleAxis(-90.0f, Vector3.right) * Sun.transform.forward;
                Shader.SetGlobalVector("_WeatherMakerSunDirectionUp", -sunForward);
                Shader.SetGlobalVector("_WeatherMakerSunDirectionUp2D", -sunForward2D);
                Shader.SetGlobalVector("_WeatherMakerSunDirectionDown", Sun.transform.forward);
                Shader.SetGlobalVector("_WeatherMakerSunDirectionDown2D", sunForward2D);
                Shader.SetGlobalVector("_WeatherMakerSunPositionNormalized", Sun.transform.position.normalized);
                Shader.SetGlobalVector("_WeatherMakerSunPositionWorldSpace", Sun.transform.position);
                SunColor = new Vector4(Sun.Light.color.r, Sun.Light.color.g, Sun.Light.color.b, Sun.Light.intensity);
                Shader.SetGlobalVector("_WeatherMakerSunColor", SunColor);
                SunTintColor = new Vector4(Sun.TintColor.r, Sun.TintColor.g, Sun.TintColor.b, Sun.TintColor.a * Sun.TintIntensity);
                Shader.SetGlobalVector("_WeatherMakerSunTintColor", SunTintColor);
                float sunHorizonScaleMultiplier = Mathf.Clamp(Mathf.Abs(Sun.transform.forward.y) * 3.0f, 0.5f, 1.0f);
                sunHorizonScaleMultiplier = Mathf.Min(1.0f, Sun.Scale / sunHorizonScaleMultiplier);
                Shader.SetGlobalVector("_WeatherMakerSunLightPower", new Vector4(Sun.LightPower, Sun.LightMultiplier, Sun.Light.shadowStrength, 1.0f - Sun.Light.shadowStrength));
                Shader.SetGlobalVector("_WeatherMakerSunVar1", new Vector4(sunHorizonScaleMultiplier, Mathf.Pow(Sun.Light.intensity, 0.5f), Mathf.Pow(Sun.Light.intensity, 0.75f), Sun.Light.intensity * Sun.Light.intensity));

                if (Sun.Renderer != null)
                {
                    Sun.Renderer.enabled = (Sun.Light.intensity > 0.0f);
                    if (Sun.RenderHintFast)
                    {
                        Sun.Renderer.sharedMaterial.EnableKeyword("RENDER_HINT_FAST");
                    }
                    else
                    {
                        Sun.Renderer.sharedMaterial.DisableKeyword("RENDER_HINT_FAST");
                    }
                }
            }

            // Moons
            Shader.SetGlobalInt("_WeatherMakerMoonCount", Moons.Count);
            if (Moons != null)
            {
                for (int i = 0; i < Moons.Count; i++)
                {
                    WeatherMakerCelestialObjectScript moon = Moons[i];
                    if (moon != null && moon.Renderer != null && moon.Light != null)
                    {
                        moon.Renderer.sharedMaterial.SetFloat("_MoonIndex", i);
                        moonDirectionUpShaderBuffer[i] = -moon.transform.forward;
                        moonDirectionDownShaderBuffer[i] = moon.transform.forward;
                        moonLightColorShaderBuffer[i] = (moon.LightIsOn ? new Vector4(moon.Light.color.r, moon.Light.color.g, moon.Light.color.b, moon.Light.intensity) : Vector4.zero);
                        moonLightPowerShaderBuffer[i] = new Vector4(moon.LightPower, moon.LightMultiplier, moon.Light.shadowStrength, 1.0f - moon.Light.shadowStrength);
                        moonTintColorShaderBuffer[i] = new Vector4(moon.TintColor.r, moon.TintColor.g, moon.TintColor.b, moon.TintColor.a * moon.TintIntensity);
                        moonVar1ShaderBuffer[i] = new Vector4(moon.Scale, 0.0f, 0.0f, 0.0f);
                    }
                }

                Shader.SetGlobalVectorArray(WeatherMakerShaderIds.ArrayWeatherMakerMoonDirectionUp, moonDirectionUpShaderBuffer);
                Shader.SetGlobalVectorArray(WeatherMakerShaderIds.ArrayWeatherMakerMoonDirectionDown, moonDirectionDownShaderBuffer);
                Shader.SetGlobalVectorArray(WeatherMakerShaderIds.ArrayWeatherMakerMoonLightColor, moonLightColorShaderBuffer);
                Shader.SetGlobalVectorArray(WeatherMakerShaderIds.ArrayWeatherMakerMoonLightPower, moonLightPowerShaderBuffer);
                Shader.SetGlobalVectorArray(WeatherMakerShaderIds.ArrayWeatherMakerMoonTintColor, moonTintColorShaderBuffer);
                Shader.SetGlobalVectorArray(WeatherMakerShaderIds.ArrayWeatherMakerMoonVar1, moonVar1ShaderBuffer);
            }

            float t = Time.timeSinceLevelLoad;
            Shader.SetGlobalVector("_WeatherMakerTime", new Vector4(t * 0.05f, t, (float)System.Math.Truncate(t * 0.05f), (float)System.Math.Truncate(t)));
            Shader.SetGlobalVector("_WeatherMakerTimeSin", new Vector4(Mathf.Sin(t * 0.05f), Mathf.Sin(t), Mathf.Sin(t * 2.0f), Mathf.Sin(t * 3.0f)));
        }

        private void Initialize()
        {
            // Create3DNoiseTexture();
            // CreateDitherTexture();
            NoiseTexture3DInstance = NoiseTexture3D;
            Shader.SetGlobalTexture("_WeatherMakerNoiseTexture3D", NoiseTexture3D);
            nullZoneSorterReference = NullZoneSorter;
            lightSorterReference = LightSorter;
            intersectsFuncCurrentCamera = IntersectsFunctionCurrentCamera;
            intersectsFuncCurrentBounds = IntersectsFunctionCurrentBounds;
            intersectsFunc = intersectsFuncCurrentCamera;
        }

        private void Update()
        {
            NullZones.Clear();
        }

        private void LateUpdate()
        {
            Shader.SetGlobalFloat("_WeatherMakerFogDirectionalLightScatterIntensity", FogDirectionalLightScatterIntensity);
            Shader.SetGlobalVector("_WeatherMakerFogLightFalloff", new Vector4(FogSpotLightRadiusFalloff, 0.0f, 0.0f, 0.0f));
            Shader.SetGlobalFloat("_WeatherMakerFogLightSunIntensityReducer", FogLightSunIntensityReducer);
            if (QualitySettings.shadows == ShadowQuality.All)
            {
                Shader.EnableKeyword("WEATHER_MAKER_SHADOWS_SOFT");
                Shader.DisableKeyword("WEATHER_MAKER_SHADOWS_HARD");
            }
            else if (QualitySettings.shadows == ShadowQuality.HardOnly)
            {
                Shader.EnableKeyword("WEATHER_MAKER_SHADOWS_HARD");
                Shader.DisableKeyword("WEATHER_MAKER_SHADOWS_SOFT");
            }
            else
            {
                Shader.DisableKeyword("WEATHER_MAKER_SHADOWS_SOFT");
                Shader.DisableKeyword("WEATHER_MAKER_SHADOWS_HARD");
            }
            if (QualitySettings.shadowCascades < 2)
            {
                Shader.EnableKeyword("WEATHER_MAKER_SHADOWS_ONE_CASCADE");
            }
            else
            {
                Shader.DisableKeyword("WEATHER_MAKER_SHADOWS_ONE_CASCADE");
            }
            SetGlobalShaders();

#if UNITY_EDITOR

            if (!Application.isPlaying && Camera.main != null)
            {
                CameraPreRender(Camera.main);
            }

#endif

        }

        private void OnEnable()
        {
            Initialize();
            Camera.onPreRender += CameraPreRender;
        }

        private void OnDisable()
        {
            Camera.onPreRender -= CameraPreRender;
        }

        /// <summary>
        /// Add a light, unless AutoFindLights is true
        /// </summary>
        /// <param name="l">Light to add</param>
        /// <returns>True if light added, false if not</returns>
        public bool AddLight(Light l)
        {
            if (l != null && AutoFindLights == AutoFindLightsMode.None && !lights.Contains(l) && IgnoreLights != null && !IgnoreLights.Contains(l))
            {
                lights.Add(l);
                return true;
            }
            return false;
        }

        /// <summary>
        /// Remove a light, unless AutoFindLights is true
        /// </summary>
        /// <param name="l"></param>
        /// <returns>True if light removed, false if not</returns>
        public bool RemoveLight(Light l)
        {
            if (l != null && AutoFindLights == AutoFindLightsMode.None)
            {
                return lights.Remove(l);
            }
            return false;
        }

        /// <summary>
        /// Called when a camera is about to render - sets up shader and light properties, etc.
        /// </summary>
        /// <param name="camera">The current camera</param>
        private void CameraPreRender(Camera camera)
        {
            if (WeatherMakerScript.ShouldIgnoreCamera(this, camera) || WeatherMakerScript.CameraStack > 1)
            {
                return;
            }
            UpdateShaderVariables(null, camera);
        }

        /// <summary>
        /// Update shader variables for an object.
        /// </summary>
        /// <param name="m">Material (null for global shader variables)</param>
        /// <param name="obj">Object -  Camera and Collider are possible objects.</param>
        public void UpdateShaderVariables(Material m, UnityEngine.Component obj)
        {
            if (obj == null)
            {
                return;
            }
            Camera camera = obj as Camera;
            if (camera != null)
            {
                intersectsFunc = intersectsFuncCurrentCamera;
                CalculateFrustumPlanes(camera);
            }
            else
            {
                Collider collider = obj as Collider;
                if (collider != null)
                {
                    intersectsFunc = intersectsFuncCurrentBounds;
                    CurrentBounds = collider.bounds;
                }
                else
                {
                    Debug.LogError("Must pass camera or collider to this method");
                    return;
                }
            }
            currentLightSortPosition = obj.transform.position;

            // *** NOTE: if getting warnings about array sizes changing, simply restart the Unity editor ***
            float elapsed;
            if (!shaderUpdateCounter.TryGetValue(obj, out elapsed) || elapsed >= ShaderUpdateInterval || lastShaderUpdateComponent != obj)
            {
                shaderUpdateCounter[obj] = 0.0f;
                UpdateAllLights();
                lights.Sort(lightSorterReference);

                // update null zones
                UpdateNullZones(m);
            }
            else
            {
                shaderUpdateCounter[obj] += Time.unscaledDeltaTime;
            }
            lastShaderUpdateComponent = obj;

            // add lights for each type
            SetLightsByTypeToShader(camera, m);
        }

        /// <summary>
        /// Get a color for a gradient given sun position
        /// </summary>
        /// <param name="gradient">Gradient</param>
        /// <returns>Color</returns>
        public static Color GetGradientColorForSun(Gradient gradient)
        {
            if (gradient == null || Instance == null || Instance.Sun == null)
            {
                return EvaluateGradient(gradient, 1.0f);
            }
            float sunGradientLookup = GetGradientLookupValueSun();
            return EvaluateGradient(gradient, sunGradientLookup);
        }

        /// <summary>
        /// Get a gradient lookup value for the sun
        /// </summary>
        /// <returns>Value</returns>
        public static float GetGradientLookupValueSun()
        {
            return GetGradientLookupValue((Instance == null || Instance.Sun == null ? null : Instance.Sun.transform));
        }

        /// <summary>
        /// Get a lookup value for a camera and transform
        /// </summary>
        /// <param name="transform">Transform</param>
        /// <returns>Value</returns>
        public static float GetGradientLookupValue(Transform transform)
        {
            if (transform == null || Instance == null)
            {
                return 1.0f;
            }
            float sunGradientLookup;
            CameraMode mode = WeatherMakerScript.ResolveCameraMode();
            if (mode == CameraMode.OrthographicXY)
            {
                sunGradientLookup = transform.forward.z;
            }
            else if (mode == CameraMode.OrthographicXZ)
            {
                sunGradientLookup = transform.forward.x;
            }
            else
            {
                sunGradientLookup = -transform.forward.y;
            }
            sunGradientLookup = ((sunGradientLookup + 1.0f) * 0.5f);
            return sunGradientLookup;
        }

        /// <summary>
        /// Get a color for a gradient given a lookup value on the gradient
        /// </summary>
        /// <param name="gradient">Gradient</param>
        /// <param name="lookup">Lookup value (0 - 1)</param>
        /// <returns>Color</returns>
        public static Color EvaluateGradient(Gradient gradient, float lookup)
        {
            if (gradient == null)
            {
                return Color.white;
            }
            Color color = gradient.Evaluate(lookup);
            float a = color.a;
            color *= color.a;
            color.a = a;
            return color;
        }

        /// <summary>
        /// Get sun mie dot
        /// </summary>
        /// <returns>Sun mie dot</returns>
        public static float GetSunMieDot()
        {
            if (Instance == null || Instance.Sun == null)
            {
                return 1.0f;
            }
            return Mathf.Pow(1.0f - Vector3.Dot(Vector3.up, -Instance.Sun.transform.forward), 5.0f);
        }

        /// <summary>
        /// Current set of lights
        /// </summary>
        public IEnumerable<Light> Lights { get { return lights; } }

        /// <summary>
        /// Sun color
        /// </summary>
        public Vector4 SunColor { get; private set; }

        /// <summary>
        /// Sun tint color
        /// </summary>
        public Vector4 SunTintColor { get; private set; }

        private static WeatherMakerLightManagerScript instance;
        /// <summary>
        /// Shared instance of light manager script
        /// </summary>
        public static WeatherMakerLightManagerScript Instance
        {
            get
            {
                if (instance == null)
                {
                    foreach (WeatherMakerLightManagerScript script in GameObject.FindObjectsOfType<WeatherMakerLightManagerScript>())
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
