using System;
using UnityEngine;

namespace LushLODTreeGaiaDemo.UnityStandardAssets.Water
{
    [ExecuteInEditMode]
    [RequireComponent(typeof(_L_WaterBase))]
    public class _L_Displace : MonoBehaviour
    {
        public void Awake()
        {
            if (enabled)
            {
                OnEnable();
            }
            else
            {
                OnDisable();
            }
        }


        public void OnEnable()
        {
            Shader.EnableKeyword("WATER_VERTEX_DISPLACEMENT_ON");
            Shader.DisableKeyword("WATER_VERTEX_DISPLACEMENT_OFF");
        }


        public void OnDisable()
        {
            Shader.EnableKeyword("WATER_VERTEX_DISPLACEMENT_OFF");
            Shader.DisableKeyword("WATER_VERTEX_DISPLACEMENT_ON");
        }
    }
}