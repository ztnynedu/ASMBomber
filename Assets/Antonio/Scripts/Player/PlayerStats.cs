using System;
using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.Networking;

[Serializable]
public class PlayerStats
{
    [SerializeField]
    private PlayerHealthBar bar;

    [SerializeField]
    private float maxValue;

    [SerializeField]
    private float currentValue;

    public float CurrentValue
    {
        get
        {
            return currentValue;
        }

        set
        {
            currentValue = Mathf.Clamp(value, 0, MaxValue);
            bar.Value = currentValue;
        }
    }

    public float MaxValue
    {
        get
        {
            return maxValue;
        }

        set
        {
            maxValue = value;
            bar.MaxValue = maxValue;
        }
    }

    public void Initialize ()
    {
        MaxValue = maxValue;
        CurrentValue = currentValue;
    }
}
