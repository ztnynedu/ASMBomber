using System;
using UnityEngine;

namespace LushLODTreeGaiaDemo.UnityStandardAssets.Water
{
    [RequireComponent(typeof(_L_WaterBase))]
    [ExecuteInEditMode]
    public class _L_SpecularLighting : MonoBehaviour
    {
        public Transform specularLight;
        private _L_WaterBase m_WaterBase;


        public void Start()
        {
            m_WaterBase = (_L_WaterBase)gameObject.GetComponent(typeof(_L_WaterBase));
        }


        public void Update()
        {
            if (!m_WaterBase)
            {
                m_WaterBase = (_L_WaterBase)gameObject.GetComponent(typeof(_L_WaterBase));
            }

            if (specularLight && m_WaterBase.sharedMaterial)
            {
                m_WaterBase.sharedMaterial.SetVector("_WorldLightDir", specularLight.transform.forward);
            }
        }
    }
}