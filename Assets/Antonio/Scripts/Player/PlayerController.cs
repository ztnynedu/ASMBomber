using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.Networking; // Zayne

public class PlayerController : NetworkBehaviour // Zayne
{
    [SerializeField]
	private PlayerStats health;

    [SerializeField]
    private PlayerMovement movement;

    [SerializeField]
    private BaseGrenade grenade;

    public GameObject grenadePrefab, megaBombPrefab, forceBombPrefab;
    public Transform grenadeSpawnLocation;
    public float throwForce;
    private float timer;
    private int grenadeType = 1;

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
        timer += Time.deltaTime;

		// Zayne
		if(!isLocalPlayer)
		{
			return;
		}

        switch (grenadeType)
        {
            case 1:
                CmdBasicGrenadeFire();
                break;
            case 2:
                CmdForceGrenadeFire();
                break;
            case 3:
                CmdMegaBombGrenadeFire();
                break;
            default:
                CmdBasicGrenadeFire();
                break;
        }

        if (Input.GetMouseButtonDown(0))
        {
            CmdBasicGrenadeFire();
        }
	}

    private void OnTriggerEnter(Collider entity)
    {
        if (entity.tag == "MegaBombPowerup")
        {

            Destroy(entity.gameObject);
        }

        if (entity.tag == "ForceBombPowerup")
        {

            Destroy(entity.gameObject);
        }

        if (entity.tag == "HealthPickup")
        {
            health.CurrentValue += 50;
            Destroy(entity.gameObject);
        }

        if (entity.tag == "SpeedPickup")
        {
            timer = 0;
            movement.groundedStandardSpeed = 10.0f;
            Destroy(entity.gameObject);

            SpeedWait();
        }
    }

    [Command]
    void CmdBasicGrenadeFire()
    {
        // Create the Bullet from the Bullet Prefab
        var bullet1 = (GameObject)Instantiate(grenadePrefab, grenadeSpawnLocation.position, grenadeSpawnLocation.rotation);

        // Add velocity to the bullet
        bullet1.GetComponent<Rigidbody>().AddForce(Camera.main.transform.forward * throwForce, ForceMode.Impulse);

		// Zayne
		NetworkServer.Spawn(bullet1);
    }

    [Command]
    void CmdMegaBombGrenadeFire()
    {
        // Create the Bullet from the Bullet Prefab
        var bullet2 = (GameObject)Instantiate(megaBombPrefab, grenadeSpawnLocation.position, grenadeSpawnLocation.rotation);

        // Add velocity to the bullet
        bullet2.GetComponent<Rigidbody>().AddForce(Camera.main.transform.forward * throwForce, ForceMode.Impulse);

        // Zayne
        NetworkServer.Spawn(bullet2);
    }

    [Command]
    void CmdForceGrenadeFire()
    {
        // Create the Bullet from the Bullet Prefab
        var bullet3 = (GameObject)Instantiate(forceBombPrefab, grenadeSpawnLocation.position, grenadeSpawnLocation.rotation);

        // Add velocity to the bullet
        bullet3.GetComponent<Rigidbody>().AddForce(Camera.main.transform.forward * throwForce, ForceMode.Impulse);

        // Zayne
        NetworkServer.Spawn(bullet3);
    }

    public void Damage()
    {
		if(!isServer)
		{
			return;
		}

        health.CurrentValue -= grenade.damage;
    }

    private void SpeedWait()
    {
        if (timer >= 5)
        {
            movement.groundedStandardSpeed = 7.5f;
        }
    }

	// Zayne
	public override void OnStartLocalPlayer()
	{
		GetComponent<MeshRenderer>().material.color = Color.blue;
	}
}