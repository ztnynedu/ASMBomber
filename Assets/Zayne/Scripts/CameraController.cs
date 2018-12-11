using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.Networking;

public class CameraController : NetworkBehaviour
{
    public Camera cam;

	// Use this for initialization
	void Start ()
    {
        cam.setactive(true);
    }
	
	// Update is called once per frame
	void Update ()
    {
		
	}
}
