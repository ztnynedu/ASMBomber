using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class PlayerLook : MonoBehaviour
{
    private Transform CharacterTransform;

    [SerializeField]private float mouseSensitivity = 80.0f;
    private float clampAngle = 87.5f;
    private float smoothTime = 8.5f;

    private float rotY;
    private float rotX; 

    void Start()
    {
        //Get attached to Character Transform
        CharacterTransform = transform.root.transform;

        //Get base Rotation
        Vector3 rot = transform.localRotation.eulerAngles;
        rotY = rot.y;
        rotX = rot.x;

        //Lock Cursor
        Cursor.lockState = CursorLockMode.Locked;
    }

    void Update()
    {
        //Detect Mouse Input
        float mouseXInput = Input.GetAxis("Mouse X");
        float mouseYInput = -Input.GetAxis("Mouse Y");

        //Determine Rotation based on Mouse Sensitivity
        rotY += mouseXInput * mouseSensitivity * Time.deltaTime;
        rotX += mouseYInput * mouseSensitivity * Time.deltaTime;

        //Clamp Mouse Rotation
        rotX = Mathf.Clamp(rotX, -clampAngle, clampAngle);

        //Get Target Rotations
        Quaternion cameraTargetRotation = Quaternion.Euler(rotX, 0.0f, 0.0f);
        Quaternion characterTargetRotation = Quaternion.Euler(0.0f, rotY, 0.0f);

        //Slerp to Target Rotations
        transform.localRotation = Quaternion.Slerp(transform.localRotation, cameraTargetRotation, smoothTime * Time.deltaTime);
        CharacterTransform.rotation = Quaternion.Slerp(CharacterTransform.rotation, characterTargetRotation, smoothTime * Time.deltaTime);
    }
}
