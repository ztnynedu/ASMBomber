// Upgrade NOTE: replaced '_Object2World' with 'unity_ObjectToWorld'

Shader "Hidden/LushLODTree/Tree Creator Leaves Fast Optimized" {
Properties {
	_Color ("Main Color", Color) = (1,1,1,1)
	_TranslucencyColor ("Translucency Color", Color) = (0.73,0.85,0.41,1) // (187,219,106,255)
	_Cutoff ("Alpha cutoff", Range(0,1)) = 0.3
	_TranslucencyViewDependency ("View dependency", Range(0,1)) = 0.7
	_ShadowStrength("Shadow Strength", Range(0,1)) = 1.0
	_Transparency("Opacity", Range(0, 1)) = 1.0 //<- Added for LushLOD trees.

	_MainTex ("Base (RGB) Alpha (A)", 2D) = "white" {}
	_ShadowTex ("Shadow (RGB)", 2D) = "white" {}

	_ShadowMapFront("ShadowMapFront", 2D) = "white" {} //<- Added for LushLOD trees.
	_ShadowMapRight("ShadowMapRight", 2D) = "white" {} //<- Added for LushLOD trees.

	// These are here only to provide default values
	[HideInInspector] _TreeInstanceColor ("TreeInstanceColor", Vector) = (1,1,1,1)
	[HideInInspector] _TreeInstanceScale ("TreeInstanceScale", Vector) = (1,1,1,1)
	[HideInInspector] _SquashAmount ("Squash", Float) = 1
}

SubShader { 
	Tags {
		"IgnoreProjector"="True"
		"RenderType" = "TreeLeaf"
		"DisableBatching" = "True" //<- Added for LushLOD trees.
	}
		Cull Off //<- Added for LushLOD trees.
		LOD 200

	Pass {
		Tags { "LightMode" = "ForwardBase" }
		Name "ForwardBase"

	CGPROGRAM

		#pragma vertex VertexLeaf
		#pragma fragment FragmentLeaf
		#pragma multi_compile_fwdbase nolightmap
		#pragma multi_compile_fog

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

		sampler2D _MainTex;
		float4 _MainTex_ST;

		fixed _Cutoff;
		sampler2D _ShadowMapTexture;
		uniform float _Transparency; //<- Added for LushLOD trees.

		struct v2f_leaf {
			float4 pos : SV_POSITION;
			fixed4 diffuse : COLOR0;
		#if defined(SHADOWS_SCREEN)
			fixed4 mainLight : COLOR1;
		#endif
			float2 uv : TEXCOORD0;
		#if defined(SHADOWS_SCREEN)
			float4 screenPos : TEXCOORD1;
		#endif
			UNITY_FOG_COORDS(2)
		};

		v2f_leaf VertexLeaf (appdata_full v)
		{
			v2f_leaf o;
			TreeVertLeaf(v);
			o.pos = UnityObjectToClipPos(v.vertex);

			fixed ao = v.color.a;
			ao += 0.1; ao = saturate(ao * ao * ao); // emphasize AO

			fixed3 color = v.color.rgb * ao;
			
			float3 worldN = UnityObjectToWorldNormal(v.normal);

			fixed4 mainLight;
			mainLight.rgb = ShadeTranslucentMainLight (v.vertex, worldN) * color;
			mainLight.a = v.color.a;
			o.diffuse.rgb = ShadeTranslucentLights (v.vertex, worldN) * color;
			o.diffuse.a = 1;
		#if defined(SHADOWS_SCREEN)
			o.mainLight = mainLight;
			o.screenPos = ComputeScreenPos (o.pos);
		#else
			o.diffuse += mainLight;
		#endif			
			o.uv = TRANSFORM_TEX(v.texcoord, _MainTex);
			UNITY_TRANSFER_FOG(o,o.pos);
			return o;
		}

		fixed4 FragmentLeaf (v2f_leaf IN) : SV_Target
		{
			fixed4 albedo = tex2D(_MainTex, IN.uv);
			fixed alpha = albedo.a;


			//*************************************
			//START of code added for LushLOD Trees
			//*************************************

#if UNITY_UV_STARTS_AT_TOP
			float grabSign = -_ProjectionParams.x;
#else
			float grabSign = _ProjectionParams.x;
#endif
			//half alpha = c.a;

			float2 uv_MainTex = IN.uv;
			uv_MainTex.y *= _ProjectionParams.x;

			float2 sceneUVs = float2(1, grabSign)*uv_MainTex*0.005 + 0.005;  //float2 sceneUVs = float2(1, grabSign)*i.screenPos.xy*0.5 + 0.5;
			float Clipped_alpha = alpha >= _Cutoff ? alpha : -1.0; //<-- this clips the transparent parts of the texture, and we do that here first, to get that out of the way.
			float Coserp_Result = (Clipped_alpha * 1.0 - cos((_Transparency*3.141592654*0.5))); //<-- same thing as Mathf.Coserp(), see Google. This helps fade in the leaves more gradually at first, instead of them appearing so suddenly.

																								//float rescaled = lerp(0.0588, 99, Coserp_Result); //<-- rescales the transition to range from 0.0588 to 99, instead of from 0 to 1.
			float rescaled2 = lerp(0.0588, 1, Coserp_Result); //<-- rescales the transition to range from 0.0588 to 1, instead of from 0 to 1, to trim a little wasted curve space off the beginning.
			float rescaled3 = lerp(0.0588, 3, Coserp_Result); //<-- rescales the transition to range from 0.0588 to 3, instead of from 0 to 1 -- this ensures the dithering is fully GONE when _Transparency is 1.
			float rescaled4 = lerp(rescaled2, rescaled3, _Transparency); //<-- "rescaled2" helps bring the dithering in more slowly at first, but leaves some dithering still remaining. "rescaled3" remedies that.

			float dither = BinaryDither4x4(rescaled4 - 1.5, sceneUVs); //<-- calculates the dithering.
			clip(dither); //<-- THIS FIRST CLIP is based on TEXTURE SPACE dithering. It is "chunky" in apperance. Leaves begin to appear in chunks in the center of the tree first, where leaves are the most dense.


			//*************************************
			//END of code added for LushLOD Trees
			//*************************************

			//clip (alpha - _Cutoff); //<-- Removed for LushLOD Trees

		#if defined(SHADOWS_SCREEN)
			half4 light = IN.mainLight;
			half atten = tex2Dproj(_ShadowMapTexture, UNITY_PROJ_COORD(IN.screenPos)).r;
			light.rgb *= lerp(1, atten, _ShadowStrength);
			light.rgb += IN.diffuse.rgb;
		#else
			half4 light = IN.diffuse;
		#endif

			fixed4 col = fixed4 (albedo.rgb * light, 0.0);
			UNITY_APPLY_FOG(IN.fogCoord, col);
			return col;
		}

	ENDCG
	}

	// Pass to render object as a shadow caster
	Pass {
		Name "ShadowCaster"
		Tags { "LightMode" = "ShadowCaster" }
		
		ZWrite On ZTest LEqual
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

		sampler2D _MainTex;
		uniform float _Transparency;

		struct v2f_surf {
			V2F_SHADOW_CASTER;
			float2 hip_pack0 : TEXCOORD1;
		};
		
		float4 _MainTex_ST;
		
		v2f_surf vert_surf (appdata_full v) {
			v2f_surf o;
			TreeVertLeaf (v);
			o.hip_pack0.xy = TRANSFORM_TEX(v.texcoord, _MainTex);
			TRANSFER_SHADOW_CASTER_NORMALOFFSET(o)
			return o;
		}
		
		fixed _Cutoff;
		
		half4 frag_surf (v2f_surf IN) : SV_Target {
			fixed alpha = tex2D(_MainTex, IN.hip_pack0.xy).a;

		//////////*************************************
		//////////START of code added for LushLOD Trees
		//////////*************************************

#if UNITY_UV_STARTS_AT_TOP
		float grabSign = -_ProjectionParams.x;
#else
		float grabSign = _ProjectionParams.x;
#endif

		float2 texPos = IN.hip_pack0;
		texPos.y *= _ProjectionParams.x;

		float2 sceneUVs = float2(1, grabSign)*texPos*0.005 + 0.005;

		float Clipped_alpha = alpha >= _Cutoff ? alpha : -1.0; //<-- this clips the transparent parts of the texture, and we do that here first, to get that out of the way.
		float Coserp_Result = (Clipped_alpha * 1.0 - cos((_Transparency*3.141592654*0.5))); //<-- same thing as Mathf.Coserp(), see Google. This helps fade in the leaves more gradually at first, instead of them appearing so suddenly.

																							//float rescaled = lerp(0.0588, 99, Coserp_Result); //<-- rescales the transition to range from 0.0588 to 99, instead of from 0 to 1.
		float rescaled2 = lerp(0.0588, 1, Coserp_Result); //<-- rescales the transition to range from 0.0588 to 1, instead of from 0 to 1, to trim a little wasted curve space off the beginning.
		float rescaled3 = lerp(0.0588, 3, Coserp_Result); //<-- rescales the transition to range from 0.0588 to 3, instead of from 0 to 1 -- this ensures the dithering is fully GONE when _Transparency is 1.
		float rescaled4 = lerp(rescaled2, rescaled3, _Transparency); //<-- "rescaled2" helps bring the dithering in more slowly at first, but leaves some dithering still remaining. "rescaled3" remedies that.

		float dither = BinaryDither4x4(rescaled4 - 1.5, sceneUVs); //<-- calculates the dithering.
		clip(dither); //<-- THIS FIRST CLIP is based on TEXTURE SPACE dithering. It is "chunky" in apperance. Leaves begin to appear in chunks in the center of the tree first, where leaves are the most dense.


		//*************************************
		//END of code added for LushLOD Trees
		//*************************************


			//clip (alpha - _Cutoff); //<-- Removed for LushLOD Trees
			SHADOW_CASTER_FRAGMENT(IN)
		}

	ENDCG

	}

}

Dependency "BillboardShader" = "Hidden/Nature/Tree Creator Leaves Rendertex"
}
