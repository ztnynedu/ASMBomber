using UnityEngine;
using System.Collections;

public class _LushLODGaiaDemoMainDirLight : MonoBehaviour {

    public static Light LightRef;

	// Use this for initialization
	void Start () {
        LightRef = this.GetComponent<Light>();
	}

    void Awake()
    {
        LightRef = this.GetComponent<Light>();
    }

    void OnEnable()
    {
        LightRef = this.GetComponent<Light>();
    }

    void Update()
    {
        if (LightRef == null ||
            ReferenceEquals(LightRef, null) == true)
        {
            LightRef = this.GetComponent<Light>();
        }
    }
}
