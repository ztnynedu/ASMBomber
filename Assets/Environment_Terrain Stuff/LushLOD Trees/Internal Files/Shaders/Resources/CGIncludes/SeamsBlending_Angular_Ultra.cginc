//This script is simply a copy of all the code produced by the Partials/SeamsBlending_Angular_Ultra.shader
//This is the most complex form of seams blending, as it performs angular correction on the blend.
//This is meant for shaders which also import AngularCorrection.cginc
//The FRAG function from Partials/SeamsBlending_Angular_Ultra.shader has been renamed to GetSeamsBlending_Angular_Ultra(),
//And the various global variables such as _BiTanDirIN have been changed to be inputs for GetSeamsBlending_Angular_Ultra(),
//And I deleted all the vertex shader stuff.
//So feel free to open Partials/SeamsBlending_Angular_Ultra.shader in Shader Forge. And if you edit it, be sure to copy those
//edits to this .cginc file. This file is loaded by our shaders that use Seams Blending.

float3 WorldToTangent(float3 Vec, float3 X, float3 Y, float3 Z) {
	float3x3 tangentTransform = float3x3(X, Y, Z);
	return mul(tangentTransform, Vec.rgb).xyz.rgb.rgb;
}

float3 WorldToTangent2(float3 Vec, float3 X, float3 Y, float3 Z) {
	float3x3 tangentTransform = float3x3(X, Y, Z);
	return mul(tangentTransform, Vec.rgb).xyz.rgb.rgb;
}

float Function_node_7307(float IN, float Alpha) {
	return Alpha > 0.97 ? IN : 0;
}

float Function_node_7306(float IN, float Alpha) {
	return Alpha > 0.97 ? IN : 0;
}

float4 Function_node_7305(float4 One, float4 Zero, float Alpha) {
	return Alpha > 0.97 ? One : Zero;
}

float4 Function_node_7304(float4 One, float4 Zero, float Alpha) {
	return Alpha > 0.97 ? One : Zero;
}

float Function_node_7303(float IN, float Alpha) {
	return Alpha > 0.97 ? IN : 1;
}

float3 Function_node_7302(float3 ON, float3 OFF, float PN) {
	return PN == 3 ? ON : OFF;
}

float4 GetSeamsBlending_Angular_Ultra(float3 _BiTanDirIN,
							 float3 _NormalIN,
							 float3 _WorldPosCenterIN,
							 float _PlaneNumberIN,
							 float3 _FinalColorIN,
							 float4 _UV3ColorIN,
							 float4 _UV4ColorIN,
							 float3 _WorldPosIN,
							 float3 _ViewDirIN,
							 float3 _TanDirIN) {

	float3 UV4_Color = _UV4ColorIN.rgb;
	float3 FinalColorIN = _FinalColorIN.rgb;
	float3 WorldPos = _WorldPosIN.rgb;
	float3 BiTanDir = _BiTanDirIN.rgb;
	float3 NormalIN = _NormalIN.rgb;
	float3 TanDir = _TanDirIN.rgb;
	float3 node_4755 = WorldToTangent(WorldPos, BiTanDir, NormalIN, TanDir).rgb;
	float3 WorldPosCenter = _WorldPosCenterIN.rgb;
	float3 node_3140 = WorldToTangent2(WorldPosCenter, BiTanDir, NormalIN, TanDir).rgb;
	float node_77 = abs((node_4755.r - node_3140.r));
	float TexAlphaUV4 = _UV4ColorIN.a;
	float node_980 = Function_node_7306((1.0 - saturate((node_77*0.3))), TexAlphaUV4);
	float node_9739 = abs((node_4755.b - node_3140.b));
	float TexAlphaUV3 = _UV3ColorIN.a;
	float node_5670 = Function_node_7307((1.0 - saturate((node_9739*0.3))), TexAlphaUV3);
	float4 node_3047 = float4(FinalColorIN, 0.0); // alpha value of 0 means the circle is not affecting this pixel
	float3 UV3_Color = _UV3ColorIN.rgb;
	float4 node_4627 = lerp(Function_node_7305(float4(UV4_Color, 1.0), node_3047, TexAlphaUV4), Function_node_7304(float4(UV3_Color, 1.0), node_3047, TexAlphaUV3), smoothstep((-5.0), 5.0, (node_77 - node_9739))); // Mixes between the X and Z axis colors
	float3 ViewDir = _ViewDirIN.rgb;
	float3 node_2648 = ViewDir;
	float PlaneNumber = _PlaneNumberIN; // A number identifying which plane this is
	float node_513_if_leA = step(PlaneNumber, 2.0);
	float node_513_if_leB = step(2.0, PlaneNumber);
	float3 Y_WorldSpaceVector = lerp((node_513_if_leA*TanDir) + (node_513_if_leB*NormalIN), TanDir, node_513_if_leA*node_513_if_leB); // Local Y direction in world space
	float node_624 = dot(reflect(node_2648, Y_WorldSpaceVector), node_2648);
	float Cir_Correction = (1.0 - saturate((smoothstep((-0.5), 1.0, (-1 * node_624))*4.0 + -3.0))); // Used to fade away the circle
	float CircleShape = ((1.0 - saturate(((distance(WorldPosCenter, WorldPos)*0.1) + 0.1)))*Cir_Correction);
	float node_1668 = saturate((max(max(node_980, node_5670), (node_4627.a*CircleShape)) / (node_980 + node_5670))); // This is RATIO see CircleCrossNotes
	float XZ_Correction = saturate((smoothstep(0.4, 1.0, node_624)*4.0 + -3.0)); // Used to fade away line X
	float3 FinalColor_Corrected = Function_node_7302((((((UV4_Color - FinalColorIN)*(node_980*node_1668)) + ((UV3_Color - FinalColorIN)*(node_5670*node_1668)) + ((node_4627.rgb - FinalColorIN)*(CircleShape*node_1668))) / 2.0) + FinalColorIN), lerp(UV4_Color, FinalColorIN, Function_node_7303(saturate(((abs((node_4755.b - node_3140.b))*0.15) + XZ_Correction + 0.5)), TexAlphaUV4)), PlaneNumber);
	float3 finalColor = FinalColor_Corrected;
	return fixed4(finalColor, 1);
}