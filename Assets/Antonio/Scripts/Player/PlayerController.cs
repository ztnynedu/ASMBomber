using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class PlayerController : MonoBehaviour 
{
    public GameObject grenadePrefab;
    public float throwForce;

	// Use this for initialization
	void Start () {
		
	}
	
	// Update is called once per frame
	void Update ()
    {
        ThrowGrenade();
	}

    void ThrowGrenade()
    {
        if (Input.GetMouseButtonDown(0))
        {
            GameObject grenade = Instantiate(grenadePrefab, transform.position + new Vector3(1, 0), transform.rotation);
            Rigidbody rb = grenade.GetComponent<Rigidbody>();
            rb.AddForce(transform.forward * throwForce, ForceMode.VelocityChange);
        }
    }
}
