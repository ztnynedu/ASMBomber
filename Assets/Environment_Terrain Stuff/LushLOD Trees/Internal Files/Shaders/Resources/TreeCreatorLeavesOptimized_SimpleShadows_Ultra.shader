// Upgrade NOTE: replaced 'mul(UNITY_MATRIX_MVP,*)' with 'UnityObjectToClipPos(*)'

Shader "Hidden/LushLODTree/Tree Creator Leaves Optimized Simple Shadows Ultra" {

	Properties{
		_Color("Main Color", Color) = (1,1,1,1)
		_TranslucencyColor("Translucency Color", Color) = (0.73,0.85,0.41,1) // (187,219,106,255)
		_Cutoff("Alpha cutoff", Range(0,1)) = 0.3
		_TranslucencyViewDependency("View dependency", Range(0,1)) = 0.7
		_ShadowStrength("Shadow Strength", Range(0,1)) = 0.8
		_ShadowOffsetScale("Shadow Offset Scale", Float) = 1
		_Transparency("Opacity", Range(0, 1)) = 1.0 //<- Added for LushLOD trees.

		_MainTex("Base (RGB) Alpha (A)", 2D) = "white" {}
	_ShadowTex("Shadow (RGB)", 2D) = "white" {}

	_ShadowMapFront("ShadowMapFront", 2D) = "white" {} //<- Added for LushLOD trees.
	_ShadowMapRight("ShadowMapRight", 2D) = "white" {} //<- Added for LushLOD trees.

	_BumpSpecMap("Normalmap (GA) Spec (R) Shadow Offset (B)", 2D) = "bump" {}
	_TranslucencyMap("Trans (B) Gloss(A)", 2D) = "white" {}

	// These are here only to provide default values
	[HideInInspector] _TreeInstanceColor("TreeInstanceColor", Vector) = (1,1,1,1)
		[HideInInspector] _TreeInstanceScale("TreeInstanceScale", Vector) = (1,1,1,1)
		[HideInInspector] _SquashAmount("Squash", Float) = 1
	}

		SubShader{
		Tags{
		"Queue" = "AlphaTest+51"
		"IgnoreProjector" = "True"
		"RenderType" = "TreeLeaf"
		"DisableBatching" = "True" //<- Added for LushLOD trees.
	}
		Cull Off //<- Added for LushLOD trees.
		LOD 200

		Stencil{
		Ref 191
		Pass Replace
		}

		CGPROGRAM
#pragma surface surf LushLODTree vertex:LushLODTreeVert nolightmap noforwardadd noambient noshadow keepalpha //<-- removed "alphatest:_Cutoff" for LushLOD trees, since we calculate the cutoff below. I haven't tested "noshadow" yet.
#pragma target 3.0
#include "UnityBuiltin3xTreeLibrary.cginc"

		sampler2D _MainTex;
	sampler2D _BumpSpecMap;
	sampler2D _TranslucencyMap;
	sampler2D _ShadowMapFront; //<- Added for LushLOD trees.
	sampler2D _ShadowMapRight; //<- Added for LushLOD trees.
	uniform float _Transparency; //<- Added for LushLOD trees.
	//uniform float _LushLODTreeLinear; //<- Added for LushLOD trees.
	uniform float _LushLODTreeTimeOfDay; //<- Added for LushLOD trees.
	uniform float _LushLODTreeTranslucency; //<- Added for LushLOD trees.
	uniform float _LushLODTreeShadowContrast; //<- Added for LushLOD trees.
	uniform float _LushLODTreeMaxShadowAdd; //<- Added for LushLOD trees.
	uniform float _LushLODTreeTranslucencySharpen; //<- Added for LushLOD trees.
	uniform float _LushLODTreeShadowDarkness; //<- Added for LushLOD trees.
	uniform float _LushLODTreeAO; //<- Added for LushLOD trees.
	uniform float4 _LushLODTreeAmbientColor;  //<- Added for LushLOD trees.
	float _LushLODTreeDisableHQ; //<- Added for LushLOD trees. This is a global variable set by one of the post processor scripts to disable HQ trees.
	fixed _Cutoff; //<- Added for LushLOD trees.

	float Dither_SMOOTHING(half alpha, float matrixIN, float cut_off, float trans) {
		//////float Clipped_alpha;// = alpha >= cut_off ? alpha : -1.0; //<-- this clips the transparent parts of the texture, and we do that here first, to get that out of the way.
		cut_off += (1 - _LushLODTreeDisableHQ); //<-- clips the whole HQ tree if the _LushLODTreeDisableHQ global variable is set to zero.
		clip(alpha - cut_off); //<-- EDIT: Instead of the line above, we can just clip it now (looks slightly better?)
		//////Clipped_alpha = 1; //<-- we clipped it, so everything left is solid 1 alpha.
		//////float Coserp_Result = (Clipped_alpha * 1.0 - cos((trans*3.141592654*0.5))); //<-- same thing as Mathf.Coserp(), see Google. This helps fade in the leaves more gradually at first, instead of them appearing so suddenly.
		//////float rescaled = lerp(0.0588, 1.0, Coserp_Result); //<-- rescales the transition to range from 0.0588 to 1, instead of from 0 to 1, to trim a little wasted curve space off the beginning, to ensure that the leaves begin to appear as soon as _Transparency is even slightly above zero (otherwise they don't even start to appear until _Transparency is nearly 0.2!). EDIT: 99 works better than 1... it ensures it ends up fully opaque with no dithering still lingering.
		//////float dither = matrixIN + rescaled; //<-- calculates the dithering.
		//clip(trans < 1 ? matrixIN - 0.5 : 1);
		clip(matrixIN - 0.5);
		float dither = 1;// trans * matrixIN;
		return dither;

	}

	float XYtest(float2 screenUVs) {
		//float2 px = floor(_ScreenParams.xy * screenUVs);
		//return (fmod(px.x + px.y, 2) == 1) ? 0 : 1;// -0.45 : 1;

		screenUVs.xy = _ScreenParams.xy * screenUVs.xy;
		screenUVs.xy = floor(screenUVs.xy) * 0.5;
		return -frac(screenUVs.r + screenUVs.g) < 0 ? 0 : 1;
	}

	uniform float4 _LushLODTreeMainLightDir; //<- Added for LushLOD trees.
	//float3 MainLightDir(float3 lightDir, float3 LightD, float w) { //<- Added for LushLOD trees.
	//															   //Check if we defined our light in our manager:
	//	return w == 2 ? LightD : lightDir;
	//}

	uniform float4 _LushLODTreeMainLightCol; //<- Added for LushLOD trees.
	uniform float _LushLODTreeMainLightIntensity; //<- Added for LushLOD trees.
	//float3 CheckLightmap(float3 lightCol, float w) { //<- Added for LushLOD trees.
	//	return w == 2 ? (_LushLODTreeMainLightCol * _LushLODTreeMainLightIntensity).rgb : lightCol.rgb;
	//}

	float _LightAtten; //<- Added for LushLOD trees.
	half CheckLightAtten(half atten, float w)
	{
		return w == 2 ? _LightAtten : atten;
	}

	struct Input {
		float2 uv_MainTex;
		float4 screenPosition;  //<- Added for LushLOD trees.
		fixed4 color : COLOR; // color.a = AO
		float3 worldPos; //<- Added for LushLOD trees.
		float2 uv3_ShadowMapFront; //<- Added for LushLOD trees.
		float2 uv4_ShadowMapRight; //<- Added for LushLOD trees.
	};

	//Added for LushLOD Trees:
	//This was copied from TreeLeafVert, from UnityBuiltin3xTreeLibrary.cginc
	//Modified to set the screenPosition the way Shader Forge thinks it should be set.
	void LushLODTreeVert(inout appdata_full v, out Input o)
	{
		UNITY_INITIALIZE_OUTPUT(Input, o);

		TreeVertLeaf(v);

		o.screenPosition = UnityObjectToClipPos(v.vertex); //<-- this is the way Shader Forge thinks it should be set.

	}


	//Added for LushLOD trees:
	//This was copied from TreeLeaf, from UnityBuiltin3xTreeLibrary.cginc
	//Modified somewhat to work better with lightmaps.
	inline half4 LightingLushLODTree(LeafSurfaceOutput s, half3 lightDir, half3 viewDir, half atten)
	{

		//Fix the lights in case of missing lightmap data:
		_LightColor0.rgb = _LushLODTreeMainLightCol.rgb;// CheckLightmap(_LightColor0.rgb, _LushLODTreeMainLightDir.a);// + _LushLODTreeAmbientColor.rgb);
		lightDir = _LushLODTreeMainLightDir.rgb;// MainLightDir(lightDir, _LushLODTreeMainLightDir.rgb, _LushLODTreeMainLightDir.a);	
		atten = CheckLightAtten(atten, _LushLODTreeMainLightDir.a);

		half3 h = normalize(lightDir + viewDir);

		half nl = dot(s.Normal, lightDir);

		half nh = max(0, dot(s.Normal, h));
		half spec = pow(nh, s.Specular * 128.0) * s.Gloss;

		// view dependent back contribution for translucency
		fixed backContrib = saturate(dot(viewDir, -lightDir));

		// normally translucency is more like -nl, but looks better when it's view dependent
		backContrib = lerp(saturate(-nl), backContrib, _TranslucencyViewDependency);

		fixed3 translucencyColor = backContrib * s.Translucency * _TranslucencyColor;

		// wrap-around diffuse
		//nl = max(0, nl * 0.6 + 0.4);

		fixed4 c;
		/////@TODO: what is is this multiply 2x here???
		c.rgb = s.Albedo * (translucencyColor * 2);// +nl);
		c.rgb = c.rgb * _LightColor0.rgb + spec;

		// For directional lights, apply less shadow attenuation
		// based on shadow strength parameter.
#if defined(DIRECTIONAL) || defined(DIRECTIONAL_COOKIE)
		c.rgb *= lerp(1, atten, _ShadowStrength);
#else
		c.rgb *= atten;
#endif

		c.a = 0;

		return c + float4(s.Albedo, s.Alpha);
		//return float4(s.Albedo, s.Alpha);
	}



	void surf(Input i, inout LeafSurfaceOutput o) {
		fixed4 c = tex2D(_MainTex, i.uv_MainTex);

		//*************************************
		//START of code added for LushLOD Trees
		//*************************************

#if UNITY_UV_STARTS_AT_TOP
		float grabSign = -_ProjectionParams.x;
#else
		float grabSign = _ProjectionParams.x;
#endif
		half alpha = c.a;

		i.uv_MainTex.y *= _ProjectionParams.x;

		//float2 sceneUVs = float2(1, grabSign)*i.uv_MainTex*0.005 + 0.005;  //float2 sceneUVs = float2(1, grabSign)*i.screenPosition.xy*0.5 + 0.5;
		//float Clipped_alpha = alpha >= _Cutoff ? alpha : -1.0; //<-- this clips the transparent parts of the texture, and we do that here first, to get that out of the way.
		//float Coserp_Result = (Clipped_alpha * 1.0 - cos((_Transparency*3.141592654*0.5))); //<-- same thing as Mathf.Coserp(), see Google. This helps fade in the leaves more gradually at first, instead of them appearing so suddenly.

		//float rescaled2 = lerp(0.0588, 1, Coserp_Result); //<-- rescales the transition to range from 0.0588 to 1, instead of from 0 to 1, to trim a little wasted curve space off the beginning.
		//float rescaled3 = lerp(0.0588, 3, Coserp_Result); //<-- rescales the transition to range from 0.0588 to 3, instead of from 0 to 1 -- this ensures the dithering is fully GONE when _Transparency is 1.
		//float rescaled4 = lerp(rescaled2, rescaled3, _Transparency); //<-- "rescaled2" helps bring the dithering in more slowly at first, but leaves some dithering still remaining. "rescaled3" remedies that.

		//float dither = BinaryDither4x4(rescaled4 - 1.5, sceneUVs); //<-- calculates the dithering.
		//clip(dither); //<-- THIS FIRST CLIP is based on TEXTURE SPACE dithering. It is "chunky" in apperance. Leaves begin to appear in chunks in the center of the tree first, where leaves are the most dense.

		////i.screenPosition.y *= _ProjectionParams.x;
		////i.screenPosition = float4(i.screenPosition.xy / i.screenPosition.w, 0, 0);
		////float2 screenUVs = float2(1, grabSign)*i.screenPosition.xy * 1 + 1;

		////float dither2 = BinaryDither2x2(rescaled4 - 1.5, screenUVs); //<-- calculates the dithering.		
		////clip(dither2); //<-- THIS SECOND CLIP is based on SCREEN SPACE dithering. It is very finely pixelated, and helps further soften the transition.


		i.screenPosition = float4(i.screenPosition.xy / i.screenPosition.w, 0, 0);
		i.screenPosition.y *= _ProjectionParams.x;
		float2 sceneUVs = float2(1, grabSign)*i.screenPosition.xy*0.5 + 0.5;
		float Tex_Alpha = c.a;
		float Param_Cutoff = _Cutoff;
		float Param_Transparency = _Transparency;
		float Alpha_Smoothing = saturate(min(Param_Transparency, Tex_Alpha));
		float Dither = Dither_SMOOTHING(Tex_Alpha, XYtest(sceneUVs.rg), Param_Cutoff, Param_Transparency); // Send to post processing shader.
																										//clip(Dither - 0.5);


																										//START OF SIMPLE SHADOWS CODE (copied from Simple Shadows.shader. Open that shader in shader forge to see the nodes):

		float3 viewDirection = normalize(_WorldSpaceCameraPos.xyz - i.worldPos.xyz);
		//float3 lightDirection = normalize(_WorldSpaceLightPos0.xyz);
		float3 _MainTex_var = c.rgb * i.color.rgb;

		////// Lighting:
		float3 LightIN = (_LushLODTreeMainLightCol.rgb*(_LushLODTreeMainLightIntensity / 1.2));
		float4 _ShadowMapFront_var = tex2D(_ShadowMapFront, i.uv3_ShadowMapFront); // Must rename i.uv2 to i.uv3_ShadowMapFront
		float3 LightDir = _LushLODTreeMainLightDir.rgb;
		float node_6270 = lerp(_ShadowMapFront_var.r, _ShadowMapFront_var.b, saturate((0.5*dot(mul(unity_ObjectToWorld, float4(float3(1, 0, 0), 0)).xyz.rgb, LightDir) + 0.5*1.5 + -0.25))); // Fades between light coming from the RIGHT or LEFT side when viewed from the Z axis
		float4 _ShadowMapRight_var = tex2D(_ShadowMapRight, i.uv4_ShadowMapRight); // Must rename i.uv3 to i.uv4_ShadowMapRight
		float node_2028 = lerp(_ShadowMapRight_var.r, _ShadowMapRight_var.b, saturate((0.5*dot(mul(unity_ObjectToWorld, float4(float3(0, 0, 1), 0)).xyz.rgb, LightDir) + 0.5*1.5 + -0.25))); // Fades between the light coming from the RIGHT or LEFT side when viewed from the X axis
		float node_9362 = lerp(0.0, ((_ShadowMapFront_var.g + _ShadowMapRight_var.g) / 2.0), saturate((0.5*dot(mul(unity_ObjectToWorld, float4(float3(0, 1, 0), 0)).xyz.rgb, LightDir) + 0.5*1.5 + -0.25))); // Fades between maximum shadowing if the light is directly above OR zero shadowing if the light is coming from direction under the tree
		float MaximumShadows = (_ShadowStrength + _LushLODTreeMaxShadowAdd);
		float node_8575 = (saturate((1.0 - (1.0 - (1.0 - (1.0 - node_6270)*(1.0 - node_2028)))*(1.0 - node_9362)))*MaximumShadows);
		float node_8084 = 0.0;
		float node_7978 = 1.0;
		float node_8622 = (node_8084 - _LushLODTreeTranslucencySharpen);
		float node_1780 = 0.5*dot(viewDirection, LightDir) + 0.5; // Check if view is opposite the direction of sunlight
		float Backside_Darkening_Amount = node_1780;
		float FinalBeforeRescale = lerp(saturate((node_8622 + ((node_8575 - node_8084) * ((node_7978 + _LushLODTreeTranslucencySharpen) - node_8622)) / (node_7978 - node_8084))), node_8575, saturate((Backside_Darkening_Amount*2.0)));
		float node_4965 = 0.0;
		float node_9894 = (1.0 - _LushLODTreeShadowContrast);
		float ShadowMapDarkeningVal = saturate(clamp((node_9894 + (((1.0 - FinalBeforeRescale) - node_4965) * (_LushLODTreeShadowContrast - node_9894)) / (1.0 - node_4965)), (1.0 - _LushLODTreeShadowDarkness), 1.0));
		float3 node_3797 = lerp(((_LushLODTreeAmbientColor.rgb*_MainTex_var.rgb)*0.8), (_MainTex_var.rgb*(LightIN + _LushLODTreeAmbientColor.rgb)), ShadowMapDarkeningVal); // The final color with the shadows and the ambient tint applied to the shadows
		float node_4284 = min(min(_Color.r, _Color.g), _Color.b); // Finds how much LESS than WHITE the iput color is
		float node_424 = 0.0;
		float node_1563 = 0.0;
		float TimeOfDayIntensity = lerp(1.0, saturate((node_1563 + ((saturate((dot(float3(0, 1, 0), LightDir) + 0.25)) - node_424) * ((1.3 + (Backside_Darkening_Amount*2.0)) - node_1563)) / (1.0 - node_424))), _LushLODTreeTimeOfDay); // This is an optional lighting adjustment you can remove this if your scene doesnt benefit from this.
		float3 finalColor = (lerp((node_3797*_Color.rgb), lerp((_MainTex_var.rgb*_Color.rgb), node_3797, node_4284), (max(max(_Color.r, _Color.g), _Color.b) - node_4284))*TimeOfDayIntensity);
		float LightAtten = (saturate((ShadowMapDarkeningVal*2.5 + -1.5))*TimeOfDayIntensity*_LushLODTreeTranslucency); // Used in our custom LightModel to create the translucency effect

		//END OF SIMPLE SHADOWS CODE

		//START OF TIME OF DAY CODE:

		_LightAtten = LightAtten;

		//END OF TIME OF DAY CODE:

		//The following code helps reduce the amount of translucency, mostly near the tops of the trees:
		//float FinalShadowVal = (RGBtoHSV.b*ShadowMapDarkeningVal);
		//FinalShadowVal = FinalShadowVal;
		//_TranslucencyViewDependency *= FinalShadowVal;
		//_TranslucencyColor *= FinalShadowVal;
		//_TranslucencyColor.r = max(0.5, _TranslucencyColor.r);
		//_TranslucencyColor.g = max(0.5, _TranslucencyColor.g);
		//_TranslucencyColor.b = max(0.5, _TranslucencyColor.b);

		//*************************************
		//END of code added for LushLOD Trees//
		//*************************************

		o.Albedo = finalColor * saturate(((i.color.a * _LushLODTreeAO) - (_LushLODTreeAO - 1)) + saturate(1.0 - _Transparency)); //<-- Modified for LushLOD Trees
		
		fixed4 trngls = tex2D(_TranslucencyMap, i.uv_MainTex);
		o.Translucency = trngls.b;
		o.Gloss = trngls.a * _Color.r;
		//o.Alpha = c.a;

		half4 norspc = tex2D(_BumpSpecMap, i.uv_MainTex);
		o.Specular = norspc.r;
		o.Normal = UnpackNormalDXT5nm(norspc);

		//float3 LightIN = (CheckLightmap(_LightColor0.rgb, _LushLODTreeMainLightDir.a) + _LushLODTreeAmbientColor.rgb);


		////TIME OF DAY CODE (copied from Tree_Leaves_Far2.shader):
		//float TimeOfDayIntensity2 = saturate(((saturate((dot(float3(0, 1, 0), LightDir) + 0.25)) * (1.3 + (BackView01*2.0))) / 1.0)); // This is an optional lighting adjustment you can remove this if your scene doesnt benefit from this.
		//o.Albedo *= TimeOfDayIntensity2;
		//o.Albedo *= LightIN;

		float Alpha_Output = Param_Transparency;
		o.Alpha = (Alpha_Output*0.94 + 0.01); //<-- range from 0.01 to 0.95. Must not range from 0 to 0.95, because 0 is reserved for the "far" leaves. And 1 is reserved for the background pixels. See comments in the post processor shader. But we use 0.95 instead of 1 because some graphics cards can't compare close numbers. But the post processing shader rescales it from (0.01 to 0.95) to (0 to 1).
	}
	ENDCG

		// Pass to render object as a shadow caster
		Pass{
		Name "ShadowCaster"
		Tags{ "LightMode" = "ShadowCaster" }

		Cull Off //<- Added for LushLOD trees.


		CGPROGRAM
#pragma vertex vert_surf
#pragma fragment frag_surf
#pragma multi_compile_shadowcaster
#include "HLSLSupport.cginc"
#include "UnityCG.cginc"
#include "Lighting.cginc"

#define INTERNAL_DATA
#define WorldReflectionVector(data,normal) data.worldRefl

#include "UnityBuiltin3xTreeLibrary.cginc"

		// Dithering function, to use with scene UVs (screen pixel coords)
		//This was added for LushLOD trees. Credits: Shader Forge http://acegikmo.com/shaderforge/
		// 4x4 Bayer matrix, based on https://en.wikipedia.org/wiki/Ordered_dithering
		float BinaryDither4x4(float value, float2 sceneUVs) {
		float4x4 mtx = float4x4(
			float4(1, 9, 3, 11) / 17.0,
			float4(13, 5, 15, 7) / 17.0,
			float4(4, 12, 2, 10) / 17.0,
			float4(16, 8, 14, 6) / 17.0
			);
		float2 px = floor(_ScreenParams.xy * sceneUVs);
		int xSmp = fmod(px.x, 4);
		int ySmp = fmod(px.y, 4);
		float4 xVec = 1 - saturate(abs(float4(0, 1, 2, 3) - xSmp));
		float4 yVec = 1 - saturate(abs(float4(0, 1, 2, 3) - ySmp));
		float4 pxMult = float4(dot(mtx[0], yVec), dot(mtx[1], yVec), dot(mtx[2], yVec), dot(mtx[3], yVec));
		return round(value + dot(pxMult, xVec));
	}

float _LushLODTreeDisableHQ; //<- Added for LushLOD trees. This is a global variable set by one of the post processor scripts to disable HQ trees.
float Dither_SMOOTHING(half alpha, float matrixIN, float cut_off, float trans) {
	//////float Clipped_alpha;// = alpha >= cut_off ? alpha : -1.0; //<-- this clips the transparent parts of the texture, and we do that here first, to get that out of the way.
	cut_off += (1 - _LushLODTreeDisableHQ); //<-- clips the whole HQ tree if the _LushLODTreeDisableHQ global variable is set to zero.
	clip(alpha - cut_off); //<-- EDIT: Instead of the line above, we can just clip it now (looks slightly better?)
	//////Clipped_alpha = 1; //<-- we clipped it, so everything left is solid 1 alpha.
	//////float Coserp_Result = (Clipped_alpha * 1.0 - cos((trans*3.141592654*0.5))); //<-- same thing as Mathf.Coserp(), see Google. This helps fade in the leaves more gradually at first, instead of them appearing so suddenly.
	//////float rescaled = lerp(0.0588, 1.0, Coserp_Result); //<-- rescales the transition to range from 0.0588 to 1, instead of from 0 to 1, to trim a little wasted curve space off the beginning, to ensure that the leaves begin to appear as soon as _Transparency is even slightly above zero (otherwise they don't even start to appear until _Transparency is nearly 0.2!). EDIT: 99 works better than 1... it ensures it ends up fully opaque with no dithering still lingering.
	//////float dither = matrixIN + rescaled; //<-- calculates the dithering.
	clip(matrixIN - 0.5);
	float dither = 1;// trans * matrixIN;
	return dither;
}

float XYtest(float2 screenUVs) {
	//float2 px = floor(_ScreenParams.xy * screenUVs);
	//return (fmod(px.x + px.y, 2) == 1) ? 0 : 1;// -0.45 : 1;

	//screenUVs.xy = _ScreenParams.xy * screenUVs.xy;
	screenUVs.xy = floor(screenUVs.xy) * 0.5;
	return -frac(screenUVs.r + screenUVs.g) < 0 ? 0 : 1;
}

sampler2D _MainTex;
uniform float _Transparency;

//struct Input {
//	//float2 uv_MainTex;
//	//float4 screenPos; //<- Added for LushLOD trees.
//};

struct v2f_surf {
	V2F_SHADOW_CASTER_NOPOS
		//float2 texPos : TEXCOORD2;
		float2 uv : TEXCOORD1;
	//float4 screenPos : TEXCOORD3; //<- Added for LushLOD trees.
};
float4 _MainTex_ST;
v2f_surf vert_surf(appdata_full v, out float4 opos : SV_POSITION) {
	v2f_surf o;
	TreeVertLeaf(v);
	o.uv.xy = TRANSFORM_TEX(v.texcoord, _MainTex);
	//o.pos = mul(UNITY_MATRIX_MVP, v.vertex);
	//o.texPos = o.hip_pack0;
	//o.screenPos = o.pos;
	//o.screenPos = ComputeScreenPos(v.vertex);

	//o.pos = mul(UNITY_MATRIX_MVP, v.vertex); //<- Added for LushLOD trees.
	//o.screenPos = ComputeScreenPos(o.pos); //<- Added for LushLOD trees.

	//TRANSFER_SHADOW_CASTER_NORMALOFFSET(o)
	TRANSFER_SHADOW_CASTER_NOPOS(o, opos);

		return o;
}
fixed _Cutoff;
float4 frag_surf(v2f_surf i, UNITY_VPOS_TYPE screenPos : VPOS) : SV_Target{
	half alpha = tex2D(_MainTex, i.uv).a;



//////////*************************************
//////////START of code added for LushLOD Trees
//////////*************************************

#if UNITY_UV_STARTS_AT_TOP
	float grabSign = -_ProjectionParams.x;
#else
	float grabSign = _ProjectionParams.x;
#endif

	i.uv.y *= _ProjectionParams.x;

	float2 sceneUVs = float2(1, grabSign)*i.uv*0.005 + 0.005;

	float Clipped_alpha = alpha >= _Cutoff ? alpha : -1.0; //<-- this clips the transparent parts of the texture, and we do that here first, to get that out of the way.
	float Coserp_Result = (Clipped_alpha * 1.0 - cos((_Transparency*3.141592654*0.5))); //<-- same thing as Mathf.Coserp(), see Google. This helps fade in the leaves more gradually at first, instead of them appearing so suddenly.

	float rescaled2 = lerp(0.0588, 1, Coserp_Result); //<-- rescales the transition to range from 0.0588 to 1, instead of from 0 to 1, to trim a little wasted curve space off the beginning.
	float rescaled3 = lerp(0.0588, 3, Coserp_Result); //<-- rescales the transition to range from 0.0588 to 3, instead of from 0 to 1 -- this ensures the dithering is fully GONE when _Transparency is 1.
	float rescaled4 = lerp(rescaled2, rescaled3, _Transparency); //<-- "rescaled2" helps bring the dithering in more slowly at first, but leaves some dithering still remaining. "rescaled3" remedies that.

	float dither = BinaryDither4x4(rescaled4 - 1.5, sceneUVs); //<-- calculates the dithering.
	clip(dither); //<-- THIS FIRST CLIP is based on TEXTURE SPACE dithering. It is "chunky" in apperance. Leaves begin to appear in chunks in the center of the tree first, where leaves are the most dense.

				  //*************************************
				  //END of code added for LushLOD Trees
				  //*************************************


	SHADOW_CASTER_FRAGMENT(i)

	}
		ENDCG
	}

	}

		Dependency "BillboardShader" = "Hidden/Nature/Tree Creator Leaves Rendertex"
}