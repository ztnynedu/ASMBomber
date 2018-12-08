using UnityEngine;
using System;
using System.Linq;

[AddComponentMenu("Camera-Control/Mouse Orbit")]

public class _LushLODTreesMouseOrbit : MonoBehaviour {
    public Transform target;
    public float distance = 10f;

    public float xSpeed = 250.0f;
	public float ySpeed = 120.0f;
	
	public int yMinLimit = -20;
	public int yMaxLimit = 80;
		
	float x = 0.0f;
	float y = 0.0f;
		
	public void Awake() {
	    Vector3 angles = transform.eulerAngles;
	    x = angles.y;
	    y = angles.x;
	    
		// Make the rigid body not change rotation
	   	if (GetComponent<Rigidbody>() != null)
			GetComponent<Rigidbody>().freezeRotation = true;
	}
	
	public void LateUpdate() {
		if (target != null) {
			if(Input.GetKey(KeyCode.Mouse1)) {
		        x += Input.GetAxis("Mouse X") * xSpeed * 0.02f;
		        y -= Input.GetAxis("Mouse Y") * ySpeed * 0.02f;
            }
            float deadZone = 0.01f;
			if (Input.GetAxis("Mouse ScrollWheel") < -deadZone || Input.GetAxis("Mouse ScrollWheel") > deadZone) {
				distance -= Input.GetAxis("Mouse ScrollWheel")*5.0f;
			}
		 	y = ClampAngle(y, (float)yMinLimit, (float)yMaxLimit);
			Quaternion rotation = Quaternion.Euler(y, x, 0.0f);
			
			Vector3 position = rotation * new Vector3(0.0f, 0.0f, -distance) + target.position;
			transform.rotation = rotation;
			transform.position = position;
		}
	}
	
	public static float ClampAngle(float angle,float min,float max) {
		if (angle < -360)
			angle += 360.0f;
		if (angle > 360)
			angle -= 360.0f;
		return Mathf.Clamp (angle, min, max);
	}
}