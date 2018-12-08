using System;
using UnityEngine;

namespace LushLODTreeGaiaDemo.UnityStandardAssets.Water
{
    [ExecuteInEditMode]
    public class _L_WaterTile : MonoBehaviour
    {
        public _L_PlanarReflection reflection;
        public _L_WaterBase waterBase;


        public void Start()
        {
            AcquireComponents();
        }


        void AcquireComponents()
        {
            if (!reflection)
            {
                if (transform.parent)
                {
                    reflection = transform.parent.GetComponent<_L_PlanarReflection>();
                }
                else
                {
                    reflection = transform.GetComponent<_L_PlanarReflection>();
                }
            }

            if (!waterBase)
            {
                if (transform.parent)
                {
                    waterBase = transform.parent.GetComponent<_L_WaterBase>();
                }
                else
                {
                    waterBase = transform.GetComponent<_L_WaterBase>();
                }
            }
        }


#if UNITY_EDITOR
        public void Update()
        {
            AcquireComponents();
        }
#endif


        public void OnWillRenderObject()
        {
            if (reflection)
            {
                reflection.WaterTileBeingRendered(transform, Camera.current);
            }
            if (waterBase)
            {
                waterBase.WaterTileBeingRendered(transform, Camera.current);
            }
        }
    }
}