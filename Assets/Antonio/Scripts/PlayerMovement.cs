using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class PlayerMovement : MonoBehaviour
{
    CharacterController PlayerController;

    private Vector3 moveDirection;

    #region private floats

    //Gravity floats
    private float gravity = 20.0F;

    //Special Move Timer
    private float specialMoveRechargeTime = 0.25f;
    private float specialMoveRechargeTimeTimer;

    //Grounded floats
    private float groundedStandardSpeed = 7.5F;
    private float groundedSpecialSpeed = 13.0f;

    //Striking Slash floats
    private float strikingSlashSpeed = 35f;
    private float strikingJumpSpeed = 0.0f;

    //Dodging Slash floats
    private float dodgingSlashSpeed = 50f;
    private float dodgingJumpSpeed = 5f;

    //Slamming Stab floats 
    private float slammingStabSpeed = 25f;
    private float fallingStabSpeed = 100f;

    //Jumping Uppercut floats
    private float uppercutFlyingSpeed = 0;
    private float uppercutJumpSpeed = 25f;

    //Slamming Uppercut floats
    private float slammingUppercutSpeed = 50f;

    #endregion


    // Use this for initialization
    void Start ()
    {
        PlayerController = GetComponent<CharacterController>();

        specialMoveRechargeTimeTimer = specialMoveRechargeTime;
    }

    // Update is called once per frame
    void Update()
    {
        DoPlayerMovement();
    }

    public void DoPlayerMovement()
    {
        specialMoveRechargeTimeTimer += Time.deltaTime;

        if(PlayerController.isGrounded)
        {
            GroundedMovement();
        }

        if(specialMoveRechargeTimeTimer >= specialMoveRechargeTime)
        {
            CheckSpecialInputs();
        }

        moveDirection.y -= gravity * Time.deltaTime;
        PlayerController.Move(moveDirection * Time.deltaTime);
    }

    private void CheckSpecialInputs()
    {
        //Tail Slash
        if(Input.GetKeyDown(KeyCode.LeftShift))
        {
            specialMoveRechargeTimeTimer = 0;

            DodgingSlash();
        }

        else if(Input.GetKeyDown(KeyCode.Space))
        {
            specialMoveRechargeTimeTimer = 0;

            JumpingUppercut();
        }
    }

    private void GroundedMovement()
    {
        moveDirection = new Vector3(Input.GetAxis("Horizontal"), 0, Input.GetAxis("Vertical"));
        moveDirection = transform.TransformDirection(moveDirection);
        moveDirection *= groundedStandardSpeed;
    }

    private void DodgingSlash()
    {
        DoSpecialMove(dodgingSlashSpeed, dodgingJumpSpeed);
    }

    private void JumpingUppercut()
    {
        DoSpecialMove(uppercutFlyingSpeed, uppercutJumpSpeed);
    }

    private void DoSpecialMove(float speed, float ySpeed)
    {
        moveDirection = new Vector3(Input.GetAxis("Horizontal"), 0, Input.GetAxis("Vertical"));
        moveDirection = transform.TransformDirection(moveDirection);
        moveDirection *= speed;
        moveDirection.y = ySpeed;
    }

    private void DoSpecialMoveY(float ySpeed)
    {
        moveDirection.y = ySpeed;
    }
}
