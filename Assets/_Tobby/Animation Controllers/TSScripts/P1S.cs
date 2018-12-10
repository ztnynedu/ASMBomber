using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class P1S : MonoBehaviour
{

    CharacterController player;

    private Vector3 moveDirection;

    //Gravity floats
   public float gravity = 20.0F;

    //Grounded floats
    public float groundedStandardSpeed = 7.5F;
    public float groundedSpecialSpeed = 13.0f;

    //Dodging floats
    public float dodgeDistance = 50f;
    public float dodgeSpeed = 5f;
    int dodgeAmount = 0;

    //Jumping Uppercut floats
    public float jumpDistance = 0;
    public float jumpSpeed = 25f;

    //Slamming Uppercut floats
    public float slammingUppercutSpeed = 50f;

    // Use this for initialization
    void Start()
    {
        player = GetComponent<CharacterController>();
    }

    // Update is called once per frame
    void Update()
    {
        Movement();
    }

    private void Movement()
    {

        if (player.isGrounded)
        {
            GroundedMovement();
            DodgeInput();
            JumpInput();
            dodgeAmount = 0;
        }

        if (!player.isGrounded && dodgeAmount <= 0)
        {
            DodgeInput();
        }

        moveDirection.y -= gravity * Time.deltaTime;
        player.Move(moveDirection * Time.deltaTime);
    }

    private void GroundedMovement()
    {
        moveDirection = new Vector3(Input.GetAxis("Horizontal"), 0, Input.GetAxis("Vertical"));
        moveDirection = transform.TransformDirection(moveDirection);
        moveDirection *= groundedStandardSpeed;
    }

    private void DodgeInput()
    {
        if (Input.GetKeyDown(KeyCode.LeftShift))
        {
            Dodge();
        }
    }

    private void JumpInput()
    {
        if (Input.GetKeyDown(KeyCode.Space))
        {
            Jump();
        }
    }

    private void Dodge()
    {
        dodgeAmount++;
        Movement(dodgeDistance, dodgeSpeed);
    }

    private void Jump()
    {
        Movement(jumpDistance, jumpSpeed);
    }

    private void Movement(float speed, float ySpeed)
    {
        moveDirection = new Vector3(Input.GetAxis("Horizontal"), 0, Input.GetAxis("Vertical"));
        moveDirection = transform.TransformDirection(moveDirection);
        moveDirection *= speed;
        moveDirection.y = ySpeed;
    }



}