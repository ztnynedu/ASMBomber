//This script is simply a copy of all the code produced by the Partials/WorldPositionCenter.shader
//WorldPositionCenter is the very center point where all 3 planes of the billboard intersect. We need to know this
//location so that we can perform certain shader calculations such as angular correction or seams blending.
//However, when the billboards are batched, we are unable to get each individual billboard's position, because the
//position that we get is the center of the ENTIRE batch of billboards! So to get the center of each billboard we 
//use this fancy little function. This function basically takes the worldposition of the specific pixel that the shader
//is working on, and then calculates from there how much UV distance (in UV space) to the WorldPositionCenter, and then
//converts that UV space distance into World Space distance using a UV-to-world ratio that we saved into each mesh's
//UV space. It's quite a lot of trouble just to get the center of the mesh in world space. More information can be read 
//in the shader if you open Partials/WorldPositionCenter.shader in shader forge, and the comments in _LushLODTreeConverter.cs.

//The FRAG function from Partials/WorldPositionCenter.shader has been renamed to GetWorldPositionCenter(),
//And the various global variables such as _BiTanDirIN have been changed to be inputs for GetWorldPositionCenter(),
//And I deleted all the vertex shader stuff.
//So feel free to open Partials/WorldPositionCenter.shader in Shader Forge. And if you edit it, be sure to copy those
//edits to this .cginc file. This file is loaded by our shaders that use WorldPositionCenter.

float4 GetWorldPositionCenter(float3 _BiTanDirIN,
							  float3 _WorldPosIN,
							  float3 _TanDirIN,
							  float2 _UV1,
							  float2 _UV0) {

	float3 WorldPos = _WorldPosIN.rgb;
	float2 UV0_IN = float2(_UV0.r, _UV0.g);
	float2 node_8853 = UV0_IN;
	float2 UV1_IN = float2(_UV1.r, _UV1.g);
	float2 node_7020 = UV1_IN.rg;
	float node_6594 = trunc(node_7020.r);
	float2 node_5723 = (node_8853 - float2((node_6594 / 1000.0), (node_7020.r - node_6594))).rg;
	float node_3029 = trunc(node_7020.g);
	float3 BiTanDir = _BiTanDirIN.rgb;
	float3 TanDir = _TanDirIN.rgb;
	float3 WorldPosCenter = ((WorldPos + ((node_5723.r / (node_3029 / 10000.0))*BiTanDir)) + ((node_5723.g / (node_7020.g - node_3029))*TanDir));
	float3 finalColor = WorldPosCenter;
	return fixed4(finalColor, 1);
}