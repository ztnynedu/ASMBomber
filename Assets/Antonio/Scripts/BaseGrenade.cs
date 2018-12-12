using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class BaseGrenade : MonoBehaviour
{
    private PlayerController playerInfo;

    [SerializeField] GameObject explosionEffect;
    [SerializeField] float blastRadius, explosionForce, delay;

    [SerializeField]GameObject Player;

    public int damage;

    float countdown;
    float dist;

    bool hasExploded;

	// Use this for initialization
	void Start ()
    {
        playerInfo = Player.GetComponent<PlayerController>();
        countdown = delay;
        hasExploded = false;
	}
	
	// Update is called once per frame
	void Update () 
    {
        countdown -= Time.deltaTime;

        if (countdown <= 0 && !hasExploded)
        {
            Explode();
            hasExploded = true;
        }
	}

    private void Explode ()
    {
        Instantiate(explosionEffect, transform.position, transform.rotation);

        Collider[] colliders = Physics.OverlapSphere(transform.position, blastRadius);

        foreach (Collider nearbyObject in colliders)
        {
            Rigidbody rb = nearbyObject.GetComponent<Rigidbody>();
            if (rb != null)
            {
                rb.AddExplosionForce(explosionForce, transform.position, blastRadius);
            }

            if (nearbyObject.tag == "Player")
            {
                DamagePlayer();
            }
        }

        Destroy(gameObject);
    }

    void DamagePlayer()
    {
        dist = Vector3.Distance(Player.transform.position, transform.position);

        if (dist <= blastRadius)
        {
            playerInfo.Damage();
        }
    }
}
