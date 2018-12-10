using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class AnimMove : MonoBehaviour
{
    Animator nim;
    int jumpHash = Animator.StringToHash("isJumping");
    int dashHash = Animator.StringToHash("isDashing");
    int crouchHash = Animator.StringToHash("isCrouching");
    int attackHash = Animator.StringToHash("isAttacking");

    void Start()
    {
        nim = this.GetComponent<Animator>();
    }
    void Update()
    {
        float move = Input.GetAxis("Vertical");
        float strafe = Input.GetAxis("Horizontal");
        nim.SetFloat("InputX", move);       
        nim.SetFloat("InputY", strafe);

        if (Input.GetKeyDown(KeyCode.Space))
        {
            nim.SetTrigger(jumpHash);
        }

        if (Input.GetKeyDown(KeyCode.LeftShift))
        {
            nim.SetTrigger(dashHash);
        }
        if (Input.GetKeyDown(KeyCode.LeftControl))
        {
            nim.SetTrigger(crouchHash);

        }
        if (Input.GetKeyDown(KeyCode.Mouse0))
        {
            nim.SetTrigger(attackHash);
        }
    }
}
