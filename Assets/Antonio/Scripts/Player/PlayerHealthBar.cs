using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.UI;
using UnityEngine.Networking; // Zayne

public class PlayerHealthBar : NetworkBehaviour // Zayne
{
	//[SyncVar(hook = "OnChangeHealth")] // Zayne
	[SerializeField]
    private float fillAmount;

	//[SyncVar] // Zayne
	[SerializeField]
    private float lerpSpeed;

	//[SyncVar] // Zayne
	[SerializeField]
    private Image content;

	//[SyncVar] // Zayne
	[SerializeField]
    private Text valueText;

	//[SyncVar] // Zayne
	[SerializeField]
    private Color fullColor, lowColor;

	//[SyncVar] // Zayne
	[SerializeField]
    private bool lerpColors;

    public float MaxValue { get; set; }

    public float Value
    {
        set
        {
            string[] tmp = valueText.text.Split(':');
            valueText.text = tmp[0] + ": " + value;
            fillAmount = Map(value, 0, MaxValue, 0, 1);
        }
    }

    // Use this for initialization
    void Start()
    {
        if (lerpColors)
        {
            content.color = fullColor;
        }
    }

    // Update is called once per frame
    void Update()
    {
		//// Zayne
		//if(!isServer)
		//{
		//	return;
		//}

        HandleBar();
    }

    private void HandleBar()
    {
        if (fillAmount != content.fillAmount)
        {
            content.fillAmount = Mathf.Lerp(content.fillAmount, fillAmount, Time.deltaTime * lerpSpeed);
        }

        if (lerpColors)
        {
            content.color = Color.Lerp(lowColor, fullColor, fillAmount);
        }
    }

    private float Map (float value, float inMin, float inMax, float outMin, float outMax)
    {
        return (value - inMin) * (outMax - outMin) / (inMax - inMin) + outMin;
    }

	//// Zayne
	//void OnChangeHealth (float fillAmount)
	//{
	//	if (fillAmount != content.fillAmount)
	//	{
	//		content.fillAmount = Mathf.Lerp(content.fillAmount, fillAmount, Time.deltaTime * lerpSpeed);
	//	}

	//	if (lerpColors)
	//	{
	//		content.color = Color.Lerp(lowColor, fullColor, fillAmount);
	//	}
	//}
}
