using System.Collections;
using System.Collections.Generic;
using UnityEngine;

namespace DigitalRuby.WeatherMaker
{
    public interface IWeatherMakerNetworkScript
    {
        bool IsServer { get; }
    }

    public class WeatherMakerNullNetworkScript : IWeatherMakerNetworkScript
    {
        public bool IsServer { get { return true; } }
    }
}
