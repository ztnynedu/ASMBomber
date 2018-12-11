using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.Networking;

public class CameraController : NetworkBehaviour
{
	public GameObject cam;

	// Use this for initialization
	void Start ()
    {
		if(isLocalPlayer)
			cam.SetActive(true);
    }
	
	// Update is called once per frame
	void Update ()
    {
		
	}
}
