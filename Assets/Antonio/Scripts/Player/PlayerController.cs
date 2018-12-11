using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.Networking; // Zayne

public class PlayerController : NetworkBehaviour // Zayne
{
    [SerializeField]
    private PlayerStats health;

    [SerializeField]
    private BaseGrenade grenade;

    public GameObject grenadePrefab;
    public Transform grenadeSpawnLocation;
    public float throwForce;

    private void Awake()
    {
        health.Initialize();
    }
    // Use this for initialization
    void Start ()
    {
       
	}
	
	// Update is called once per frame
	void Update ()
    {
		// Zayne
		if(!isLocalPlayer)
		{
			return;
		}

        if (Input.GetMouseButtonDown(0))
        {
            CmdFire();
        }
	}

	[Command]
    void CmdFire()
    {
        // Create the Bullet from the Bullet Prefab
        var bullet = (GameObject)Instantiate(grenadePrefab, grenadeSpawnLocation.position, grenadeSpawnLocation.rotation);

        // Add velocity to the bullet
        bullet.GetComponent<Rigidbody>().AddForce(Camera.main.transform.forward * throwForce, ForceMode.Impulse);

		// Zayne
		NetworkServer.Spawn(bullet);
    }

    public void Damage()
    {
        health.CurrentValue -= grenade.damage;
    }

    //void ThrowGrenade()
    //{
    //    if (Input.GetMouseButtonDown(0))
    //    {
    //        GameObject grenade = Instantiate(grenadePrefab, transform.position + new Vector3(1, 0), transform.rotation);
    //        Rigidbody rb = grenade.GetComponent<Rigidbody>();
    //        rb.AddForce(transform.forward * throwForce, ForceMode.VelocityChange);
    //    }
    //}

	// Zayne
	public override void OnStartLocalPlayer()
	{
		GetComponent<MeshRenderer>().material.color = Color.blue;
	}
}