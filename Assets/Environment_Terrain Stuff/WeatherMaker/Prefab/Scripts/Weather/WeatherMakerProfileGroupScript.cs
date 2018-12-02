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
    [System.Serializable]
    public class WeatherMakerProfileAndWeight
    {
        [Header("Profile and Weight")]
        [Tooltip("Profile name")]
        public string Name;

        [Tooltip("Profile settings")]
        public WeatherMakerProfileScript Profile;

        [Tooltip("Weight")]
        [Range(0.0f, 1000.0f)]
        public int Weight;

        [Header("Profile Overrides")]
        [Tooltip("Override cloud profile (set to null to not override)")]
        public WeatherMakerCloudProfileScript CloudProfile;

        [Tooltip("Override precipitation profile (set to null to not override)")]
        public WeatherMakerPrecipitationProfileScript PrecipitationProfile;

        [Tooltip("Override fog profile (set to null to not override)")]
        public WeatherMakerFullScreenFogProfileScript FogProfile;

        [Tooltip("Override wind profile (set to null to not override)")]
        public WeatherMakerWindProfileScript WindProfile;

        [Tooltip("Override lightning profile (set to null to not override)")]
        public WeatherMakerLightningProfileScript LightningProfile;

        [Tooltip("Override sound profile (set null to not override)")]
        public WeatherMakerSoundProfileScript SoundProfile;

        [SingleLine("Override random duration for profile to transition in, set to 0 to use the profile group transition duration.")]
        public RangeOfFloats TransitionDuration = new RangeOfFloats { Minimum = 0, Maximum = 0 };

        [SingleLine("Override random duration for profile to hold before transition to another profile, set to 0 to use the profile group transition duration.")]
        public RangeOfFloats HoldDuration = new RangeOfFloats { Minimum = 0, Maximum = 0 };

        public WeatherMakerProfileScript GetProfile()
        {
            return WeatherMakerProfileGroupScript.OverrideProfile(Profile, CloudProfile, PrecipitationProfile, FogProfile, WindProfile, LightningProfile, SoundProfile, TransitionDuration, HoldDuration);
        }
    }

    [CreateAssetMenu(fileName = "WeatherMakerProfileGroup", menuName = "WeatherMaker/Weather Profile Group", order = 20)]
    public class WeatherMakerProfileGroupScript : WeatherMakerBaseScriptableObjectScript, IComparer<WeatherMakerProfileAndWeight>
    {
        [Tooltip("Profiles. A random profile is chosen using the weight of all profiles.")]
        public WeatherMakerProfileAndWeight[] Profiles;

        [Header("Profile Overrides")]
        [Tooltip("Override cloud profile (set to null to not override)")]
        public WeatherMakerCloudProfileScript CloudProfile;

        [Tooltip("Override precipitation profile (set to null to not override)")]
        public WeatherMakerPrecipitationProfileScript PrecipitationProfile;

        [Tooltip("Override fog profile (set to null to not override)")]
        public WeatherMakerFullScreenFogProfileScript FogProfile;

        [Tooltip("Override wind profile (set to null to not override)")]
        public WeatherMakerWindProfileScript WindProfile;

        [Tooltip("Override lightning profile (set to null to not override)")]
        public WeatherMakerLightningProfileScript LightningProfile;

        [Tooltip("Override sound profile (set to null to not override)")]
        public WeatherMakerSoundProfileScript SoundProfile;

        [SingleLine("Override random duration for profiles to transition in, set to 0 to use the weather zone transition duration.")]
        public RangeOfFloats TransitionDuration = new RangeOfFloats { Minimum = 0, Maximum = 0 };

        [SingleLine("Override random duration for profiles to hold before transition to another profile, set to 0 to use the weather zone hold duration.")]
        public RangeOfFloats HoldDuration = new RangeOfFloats { Minimum = 0, Maximum = 0 };

        /// <summary>
        /// Pick a random profile based on weights of the profiles
        /// </summary>
        /// <returns>Random weighted profile or null if no profiles setup</returns>
        public WeatherMakerProfileScript PickWeightedProfile()
        {
            if (Profiles == null || Profiles.Length == 0)
            {
                return null;
            }

            int sum = 0;
            int maxWeight = 0;

            // get the max weight (sum of all weights)
            foreach (WeatherMakerProfileAndWeight w in Profiles)
            {
                if (!w.Profile.Disabled)
                {
                    maxWeight += Mathf.Max(1, w.Weight);
                }
            }

            // pick a weight that we need to exceed to pick a profile
            int randomWeight = UnityEngine.Random.Range(1, maxWeight + 1);

            // ensure profiles are sorted by weight ascending
            System.Array.Sort(Profiles, this);

            // interate all profiles, as we sum up the weight and it crosses are random weight, we have our profile
            for (int i = 0; i < Profiles.Length; i++)
            {
                if (!Profiles[i].Profile.Disabled)
                {
                    sum += Profiles[i].Weight;
                    if (sum >= randomWeight)
                    {
                        WeatherMakerProfileScript profile = Profiles[i].GetProfile();
                        return OverrideProfile(profile, CloudProfile, PrecipitationProfile, FogProfile, WindProfile, LightningProfile, SoundProfile, TransitionDuration, HoldDuration);
                    }
                }
            }

            // shouldn't get here
            Debug.LogError("Error in PickWeightedProfile algorithm, should not return null here");
            return null;
        }

        private static void AssignOverride<T>(ref T field, T fieldOverrideIfNotNull)
        {
            field = (fieldOverrideIfNotNull == null ? field : fieldOverrideIfNotNull);
        }

        public static WeatherMakerProfileScript OverrideProfile(
            WeatherMakerProfileScript profile,
            WeatherMakerCloudProfileScript cloudProfile,
            WeatherMakerPrecipitationProfileScript precipitationProfile,
            WeatherMakerFullScreenFogProfileScript fogProfile,
            WeatherMakerWindProfileScript windProfile,
            WeatherMakerLightningProfileScript lightningProfile,
            WeatherMakerSoundProfileScript soundProfile,
            RangeOfFloats transitionDuration,
            RangeOfFloats holdDuration)
        {
            // check for overrides, if so clone the profile
            if (cloudProfile != null || precipitationProfile != null || fogProfile != null || windProfile != null || lightningProfile != null ||
                soundProfile != null || transitionDuration.Maximum > 0.0f || holdDuration.Maximum > 0.0f)
            {
                if (profile.name.IndexOf("(clone)", System.StringComparison.OrdinalIgnoreCase) < 0)
                {
                    profile = ScriptableObject.Instantiate(profile);
                }
                AssignOverride(ref profile.CloudProfile, cloudProfile);
                AssignOverride(ref profile.PrecipitationProfile, precipitationProfile);
                AssignOverride(ref profile.FogProfile, fogProfile);
                AssignOverride(ref profile.WindProfile, windProfile);
                AssignOverride(ref profile.LightningProfile, lightningProfile);
                AssignOverride(ref profile.SoundProfile, soundProfile);
                if (transitionDuration.Maximum > 0.0f)
                {
                    profile.TransitionDuration = transitionDuration;
                }
                if (holdDuration.Maximum > 0.0f)
                {
                    profile.HoldDuration = holdDuration;
                }
            }

            return profile;
        }

        int IComparer<WeatherMakerProfileAndWeight>.Compare(WeatherMakerProfileAndWeight x, WeatherMakerProfileAndWeight y)
        {
            return x.Weight.CompareTo(y.Weight);
        }
    }
}
