//This script is simply a copy of all the code produced by the Partials/SeamsBlending_Angular.shader
//This is the most complex form of seams blending, as it performs angular correction on the blend.
//This is meant for shaders which also import AngularCorrection.cginc
//The FRAG function from Partials/SeamsBlending_Angular.shader has been renamed to GetSeamsBlending(),
//And the various global variables such as _BiTanDirIN have been changed to be inputs for GetSeamsBlending(),
//And I deleted all the vertex shader stuff.
//So feel free to open Partials/SeamsBlending_Angular.shader in Shader Forge. And if you edit it, be sure to copy those
//edits to this .cginc file. This file is loaded by our shaders that use Seams Blending.

float3 WorldToTangent(float3 Vec, float3 X, float3 Y, float3 Z) {
	float3x3 tangentTransform = float3x3(X, Y, Z);
	return mul(tangentTransform, Vec.rgb).xyz.rgb.rgb;
}

float3 WorldToTangent2(float3 Vec, float3 X, float3 Y, float3 Z) {
	float3x3 tangentTransform = float3x3(X, Y, Z);
	return mul(tangentTransform, Vec.rgb).xyz.rgb.rgb;
}

float4 GetSeamsBlending_Angular(float3 _BiTanDirIN,
							 float3 _NormalIN,
							 float3 _WorldPosCenterIN,
							 float _PlaneNumberIN,
							 float3 _FinalColorIN,
							 float4 _UV3ColorIN,
							 float4 _UV4ColorIN,
							 float3 _WorldPosIN,
							 float3 _ViewDirIN,
							 float3 _TanDirIN) {

	float PlaneNumber = _PlaneNumberIN; // A number identifying which plane this is
	float node_9472_if_leA = step(PlaneNumber,2.0);
	float node_9472_if_leB = step(2.0,PlaneNumber);
	float3 UV4_Color = _UV4ColorIN.rgb;
	float3 FinalColorIN = _FinalColorIN.rgb;
	float TexAlphaUV4 = _UV4ColorIN.a;
	float node_8231_if_leA = step(TexAlphaUV4,0.97);
	float node_8231_if_leB = step(0.97,TexAlphaUV4);
	float node_1018 = 1.0;
	float3 WorldPos = _WorldPosIN.rgb;
	float3 BiTanDir = _BiTanDirIN.rgb;
	float3 NormalIN = _NormalIN.rgb;
	float3 TanDir = _TanDirIN.rgb;
	float3 node_572 = WorldToTangent(WorldPos , BiTanDir , NormalIN , TanDir).rgb;
	float3 WorldPosCenter = _WorldPosCenterIN.rgb;
	float3 node_5678 = WorldToTangent2(WorldPosCenter , BiTanDir , NormalIN , TanDir).rgb;
	float node_2544 = (abs((node_572.b - node_5678.b))*0.15);
	float3 ViewDir = _ViewDirIN.rgb;
	float3 node_8082 = ViewDir;
	float node_4125_if_leA = step(PlaneNumber,2.0);
	float node_4125_if_leB = step(2.0,PlaneNumber);
	float3 Z_WorldSpaceVector = lerp((node_4125_if_leA*NormalIN) + (node_4125_if_leB*TanDir),BiTanDir,node_4125_if_leA*node_4125_if_leB); // Local Z direction in world space
	float Z_Correction_MAINPASS = saturate((smoothstep(0.5, 1.0, dot(reflect(node_8082,Z_WorldSpaceVector),node_8082))*4.0 + -3.0)); // Used to fade away line Z
	float3 node_6312 = ViewDir;
	float node_513_if_leA = step(PlaneNumber,2.0);
	float node_513_if_leB = step(2.0,PlaneNumber);
	float3 Y_WorldSpaceVector = lerp((node_513_if_leA*TanDir) + (node_513_if_leB*NormalIN),TanDir,node_513_if_leA*node_513_if_leB); // Local Y direction in world space
	float XZ_Correction = saturate((smoothstep(0.4, 1.0, dot(reflect(node_6312,Y_WorldSpaceVector),node_6312))*4.0 + -3.0)); // Used to fade away line X
	float node_7385_if_leA = step(TexAlphaUV4,0.97);
	float node_7385_if_leB = step(0.97,TexAlphaUV4);
	float node_8871 = 0.0;
	float node_972 = abs((node_572.r - node_5678.r));
	float3 node_5052 = ViewDir;
	float node_2197_if_leA = step(PlaneNumber,2.0);
	float node_2197_if_leB = step(2.0,PlaneNumber);
	float3 X_WorldSpaceVector = lerp((node_2197_if_leA*BiTanDir) + (node_2197_if_leB*BiTanDir),NormalIN,node_2197_if_leA*node_2197_if_leB); // Local X direction in world space
	float X_Correction_MAINPASS = saturate((smoothstep(0.5, 1.0, dot(reflect(node_5052,X_WorldSpaceVector),node_5052))*4.0 + -3.0)); // Used to fade away line X
	float node_7385 = lerp((node_7385_if_leA*node_8871) + (node_7385_if_leB*(1.0 - saturate(((node_972*0.3) + X_Correction_MAINPASS)))),node_8871,node_7385_if_leA*node_7385_if_leB); // Avoids blending transparent pixels
	float TexAlphaUV3 = _UV3ColorIN.a;
	float node_9347_if_leA = step(TexAlphaUV3,0.97);
	float node_9347_if_leB = step(0.97,TexAlphaUV3);
	float node_535 = 0.0;
	float node_9659 = abs((node_572.b - node_5678.b));
	float node_9347 = lerp((node_9347_if_leA*node_535) + (node_9347_if_leB*(1.0 - saturate(((node_9659*0.3) + Z_Correction_MAINPASS)))),node_535,node_9347_if_leA*node_9347_if_leB); // Avoids blending transparent pixels
	float node_6230_if_leA = step(TexAlphaUV4,0.97);
	float node_6230_if_leB = step(0.97,TexAlphaUV4);
	float4 node_7679 = float4(FinalColorIN,0.0); // alpha value of 0 means the circle is not affecting this pixel
	float node_2828_if_leA = step(TexAlphaUV3,0.97);
	float node_2828_if_leB = step(0.97,TexAlphaUV3);
	float4 node_7486 = float4(FinalColorIN,0.0); // Alpha value of 0 means the circle is not affecting this pixel
	float3 UV3_Color = _UV3ColorIN.rgb;
	float4 node_7244 = lerp(lerp((node_6230_if_leA*node_7679) + (node_6230_if_leB*float4(UV4_Color,1.0)),node_7679,node_6230_if_leA*node_6230_if_leB),lerp((node_2828_if_leA*node_7486) + (node_2828_if_leB*float4(UV3_Color,1.0)),node_7486,node_2828_if_leA*node_2828_if_leB),smoothstep((-5.0), 5.0, (node_972 - node_9659))); // Mixes between the X and Z axis colors
	float3 node_1206 = ViewDir;
	float Cir_Correction_MAINPASS = (1.0 - saturate((smoothstep((-0.5), 1.0, dot(reflect(node_1206,Y_WorldSpaceVector),(-1 * node_1206)))*4.0 + -3.0))); // Used to fade away the circle
	float CircleShape = ((1.0 - saturate(((distance(WorldPosCenter,WorldPos)*0.1) + 0.1)))*Cir_Correction_MAINPASS);
	float node_6451 = (node_7244.a*CircleShape); // Intensity of the circle on this pixel
	float node_749 = saturate((max(max(node_7385,node_9347),node_6451) / (node_7385 + node_9347 + node_6451))); // This is RATIO see CircleCrossNotes
	float node_1257_if_leA = step(TexAlphaUV4,0.97);
	float node_1257_if_leB = step(0.97,TexAlphaUV4);
	float node_3593 = 1.0;
	float3 FinalColor_Corrected = lerp((node_9472_if_leA*lerp(UV4_Color,FinalColorIN,lerp((node_8231_if_leA*node_1018) + (node_8231_if_leB*saturate((node_2544 + Z_Correction_MAINPASS + XZ_Correction + 0.5))),node_1018,node_8231_if_leA*node_8231_if_leB))) + (node_9472_if_leB*(((((UV4_Color - FinalColorIN)*(node_7385*node_749)) + ((UV3_Color - FinalColorIN)*(node_9347*node_749)) + ((node_7244.rgb - FinalColorIN)*(CircleShape*node_749))) / 2.0) + FinalColorIN)),lerp(UV4_Color,FinalColorIN,lerp((node_1257_if_leA*node_3593) + (node_1257_if_leB*saturate((node_2544 + X_Correction_MAINPASS + XZ_Correction + 0.5))),node_3593,node_1257_if_leA*node_1257_if_leB)),node_9472_if_leA*node_9472_if_leB);
	float3 finalColor = FinalColor_Corrected;
	return fixed4(finalColor,1);
}