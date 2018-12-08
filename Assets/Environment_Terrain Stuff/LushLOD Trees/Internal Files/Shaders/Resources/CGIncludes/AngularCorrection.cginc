//This script is simply a copy of all the code produced by the Partials/AngularCorrection.shader
//Angular Correction simply fades away the billboards that are parallel to view, which helps to prevent
//the appearance of hard lines across the billboards. Unfortunantly, it is not always possible to use
//Angular Correction, as it can also cut a hole straight through the entire mesh allowing you to see through
//the mesh. This glitch happens in deferred rendering. Also, in Ultra quality where both the billboard and the
//high qualit tree model are visible, it is impossible to use Angular Correction because the billboard's pixels
//must be shifted to the side so that you can see the high quality tree model behind it. But if Angular Correction
//was used, it would need to be possible to see not only the high quality model, and the part of the billboard that is
//behind, and the angular-corrected part of the billboard that is in front... meaning we would need to see 3 pixels
//instead of just 2. And our checkerdbox concept really only supports the idea of shifting pixels over to allow you
//to see two pixels, not 3. So in short, you can't use Angular Correction in Ultra quality except in billboard only
//mode, in which case the 2 pixels are used to see both parts of the billboard.

//The FRAG function from Partials/AngularCorrection.shader has been renamed to GetAngularCorrection(),
//And the various global variables such as _ViewReflec have been changed to be inputs for GetAngularCorrection(),
//And I deleted all the vertex shader stuff.
//Also, I set this function output a single float instead of a float3 or a float4.
//So feel free to open Partials/AngularCorrection.shader in Shader Forge. And if you edit it, be sure to copy those
//edits to this .cginc file. This file is loaded by our shaders that use Angular Correction.

float GetAngularCorrection(float3 _ViewReflec,
						   float3 _ViewDirec) {

	float3 ViewReflection = _ViewReflec;
	float3 ViewDirection = _ViewDirec;
	float AngularCorrection = saturate(((smoothstep((-1.4), 1.0, dot(ViewReflection, ViewDirection))*6.0) + (-0.3))); // Used to fade away billboards parallel to view
	return AngularCorrection;
}