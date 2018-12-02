using System.Collections;
using System.Collections.Generic;
using System.Globalization;
using System.Linq;

using UnityEngine;
using UnityEngine.Networking;

namespace DigitalRuby.WeatherMaker
{
    [RequireComponent(typeof(NetworkIdentity))]
    [AddComponentMenu("Weather Maker/Extensions/UNet", 1)]
    public class WeatherMakerUNetScript : NetworkBehaviour, IWeatherMakerNetworkScript
    {
        private void Cleanup()
        {
            // new
            if (WeatherMakerScript.Instance != null)
            {
                WeatherMakerScript.Instance.NetworkManager = null;
                WeatherMakerScript.Instance.WeatherProfileChanged -= WeatherProfileChanged;
            }
        }

        private void OnEnable()
        {
            // new
            if (WeatherMakerScript.Instance != null)
            {
                WeatherMakerScript.Instance.InstanceIsServer = IsServer;
                WeatherMakerScript.Instance.NetworkManager = this;
                WeatherMakerScript.Instance.WeatherProfileChanged += WeatherProfileChanged;
            }
        }

        private void OnDisable()
        {
            Cleanup();
        }

        private void OnDestroy()
        {
            Cleanup();
        }

        private void LateUpdate()
        {
            if (IsServer)
            {
                if (WeatherMakerDayNightCycleManagerScript.Instance != null)
                {
                    RpcSetTimeOfDay(WeatherMakerDayNightCycleManagerScript.Instance.TimeOfDay);
                }
            }
            else if (WeatherMakerDayNightCycleManagerScript.Instance != null)
            {
                // disable day night speed, the server will be syncing the day / night
                WeatherMakerDayNightCycleManagerScript.Instance.Speed = WeatherMakerDayNightCycleManagerScript.Instance.NightSpeed = 0.0f;
            }
        }

        [ClientRpc]
        private void RpcSetTimeOfDay(float timeOfDay)
        {
            if (!IsServer && WeatherMakerDayNightCycleManagerScript.Instance != null)
            {
                WeatherMakerDayNightCycleManagerScript.Instance.TimeOfDay = timeOfDay;
            }
        }

        [ClientRpc]
        private void RpcWeatherProfileChanged(string oldName, string newName, float transitionDuration, string[] clientIds)
        {
            if (!IsServer && WeatherMakerScript.Instance != null && (clientIds == null || clientIds.Contains(WeatherMakerScript.ClientId)))
            {
                WeatherMakerProfileScript oldProfile = Resources.Load<WeatherMakerProfileScript>(oldName);
                WeatherMakerProfileScript newProfile = Resources.Load<WeatherMakerProfileScript>(newName);

                // notify any listeners of the change - hold duration is -1.0 meaning the server will send another profile when it is ready (hold duration unknown to client)
                WeatherMakerScript.Instance.RaiseWeatherProfileChanged(oldProfile, newProfile, transitionDuration, -1.0f, true, null);
            }
        }

        private void WeatherProfileChanged(WeatherMakerProfileScript oldProfile, WeatherMakerProfileScript newProfile, float transitionDuration, string[] clientIds)
        {
            // send the profile change to clients
            if (IsServer)
            {
                RpcWeatherProfileChanged(oldProfile.name, newProfile.name, transitionDuration, clientIds);
            }
        }

        public override void OnStartServer()
        {
            base.OnStartServer();
        }

        public override void OnStartClient()
        {
            base.OnStartClient();
            if (WeatherMakerScript.Instance != null)
            {
                WeatherMakerScript.Instance.InstanceClientId = (netId.IsEmpty() ? null : netId.Value.ToString(CultureInfo.InvariantCulture));
            }
        }

        public bool IsServer { get { return isServer; } }
    }
}
