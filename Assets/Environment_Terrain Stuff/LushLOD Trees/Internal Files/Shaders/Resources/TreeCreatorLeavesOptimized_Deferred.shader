// Upgrade NOTE: replaced 'mul(UNITY_MATRIX_MVP,*)' with 'UnityObjectToClipPos(*)'

Shader "Hidden/LushLODTree/Tree Creator Leaves Optimized Deferred" {
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

	_ShadowMapFront("Shadow (RGB)", 2D) = "white" {}
	_ShadowMapRight("Shadow (RGB)", 2D) = "white" {}

	_BumpSpecMap("Normalmap (GA) Spec (R) Shadow Offset (B)", 2D) = "bump" {}
	_TranslucencyMap("Trans (B) Gloss(A)", 2D) = "white" {}

	// These are here only to provide default values
	[HideInInspector] _TreeInstanceColor("TreeInstanceColor", Vector) = (1,1,1,1)
		[HideInInspector] _TreeInstanceScale("TreeInstanceScale", Vector) = (1,1,1,1)
		[HideInInspector] _SquashAmount("Squash", Float) = 1
	}

		SubShader{
		Tags{
		"IgnoreProjector" = "True"
		"RenderType" = "TreeLeaf"
		"DisableBatching" = "True" //<- Added for LushLOD trees.
	}

		Cull Off //<- Added for LushLOD trees.
		LOD 200

		CGPROGRAM
#pragma surface surf TreeLeaf vertex:TreeVertLeaf nolightmap noforwardadd  //<-- removed "alphatest:_Cutoff" for LushLOD trees, since we calculate the cutoff below.
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
	sampler2D _BumpSpecMap;
	sampler2D _TranslucencyMap;
	uniform float _Transparency; //<- Added for LushLOD trees.
	fixed _Cutoff; //<- Added for LushLOD trees.

	struct Input {
		float2 uv_MainTex;
		fixed4 color : COLOR; // color.a = AO
		//float4 screenPos; //<- Added for LushLOD trees.
	};

	void surf(Input IN, inout LeafSurfaceOutput o) {
		fixed4 c = tex2D(_MainTex, IN.uv_MainTex);

		//*************************************
		//START of code added for LushLOD Trees
		//*************************************

#if UNITY_UV_STARTS_AT_TOP
		float grabSign = -_ProjectionParams.x;
#else
		float grabSign = _ProjectionParams.x;
#endif
		half alpha = c.a;

		IN.uv_MainTex.y *= _ProjectionParams.x;

		float2 sceneUVs = float2(1, grabSign)*IN.uv_MainTex*0.005 + 0.005;  //float2 sceneUVs = float2(1, grabSign)*i.screenPos.xy*0.5 + 0.5;
		float Clipped_alpha = alpha >= _Cutoff ? alpha : -1.0; //<-- this clips the transparent parts of the texture, and we do that here first, to get that out of the way.
		float Coserp_Result = (Clipped_alpha * 1.0 - cos((_Transparency*3.141592654*0.5))); //<-- same thing as Mathf.Coserp(), see Google. This helps fade in the leaves more gradually at first, instead of them appearing so suddenly.

		//float rescaled = lerp(0.0588, 99, Coserp_Result); //<-- rescales the transition to range from 0.0588 to 99, instead of from 0 to 1.
		float rescaled2 = lerp(0.0588, 1, Coserp_Result); //<-- rescales the transition to range from 0.0588 to 1, instead of from 0 to 1, to trim a little wasted curve space off the beginning.
		float rescaled3 = lerp(0.0588, 3, Coserp_Result); //<-- rescales the transition to range from 0.0588 to 3, instead of from 0 to 1 -- this ensures the dithering is fully GONE when _Transparency is 1.
		float rescaled4 = lerp(rescaled2, rescaled3, _Transparency); //<-- "rescaled2" helps bring the dithering in more slowly at first, but leaves some dithering still remaining. "rescaled3" remedies that.

		float dither = BinaryDither4x4(rescaled4 - 1.5, sceneUVs); //<-- calculates the dithering.
		clip(dither); //<-- THIS FIRST CLIP is based on TEXTURE SPACE dithering. It is "chunky" in apperance. Leaves begin to appear in chunks in the center of the tree first, where leaves are the most dense.

		//IN.screenPos.y *= _ProjectionParams.x;
		//IN.screenPos = float4(IN.screenPos.xy / IN.screenPos.w, 0, 0);
		//float2 screenUVs = float2(1, grabSign)*IN.screenPos.xy * 1 + 1;

		//float dither2 = BinaryDither2x2(rescaled4 - 1.5, screenUVs); //<-- calculates the dithering.		
		//clip(dither2); //<-- THIS SECOND CLIP is based on SCREEN SPACE dithering. It is very finely pixelated, and helps further soften the transition.
			
		//*************************************
		//END of code added for LushLOD Trees
		//*************************************


		o.Albedo = c.rgb * IN.color.rgb * saturate(IN.color.a + saturate(1.0 - _Transparency)); //<-- Modified for LushLOD Trees

				fixed4 trngls = tex2D(_TranslucencyMap, IN.uv_MainTex);
				o.Translucency = trngls.b;
				o.Gloss = trngls.a * _Color.r;
				o.Alpha = c.a;

				half4 norspc = tex2D(_BumpSpecMap, IN.uv_MainTex);
				o.Specular = norspc.r;
				o.Normal = UnpackNormalDXT5nm(norspc);		

			}
			ENDCG

				// Pass to render object as a shadow caster
				Pass{
				Name "ShadowCaster"
				Tags{ "LightMode" = "ShadowCaster" }

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

			struct Input {
				float2 uv_MainTex;
				//float4 screenPos; //<- Added for LushLOD trees.
			};

			struct v2f_surf {
				V2F_SHADOW_CASTER;
				float2 texPos : TEXCOORD2;
				float2 hip_pack0 : TEXCOORD1;
				//float4 screenPos : TEXCOORD3; //<- Added for LushLOD trees.
			};
			float4 _MainTex_ST;
			v2f_surf vert_surf(appdata_full v) {
				v2f_surf o;
				TreeVertLeaf(v);
				o.hip_pack0.xy = TRANSFORM_TEX(v.texcoord, _MainTex);
				o.pos = UnityObjectToClipPos(v.vertex);
				o.texPos = o.hip_pack0;
				//o.screenPos = o.pos;
				//o.screenPos = ComputeScreenPos(v.vertex);

				//o.pos = mul(UNITY_MATRIX_MVP, v.vertex); //<- Added for LushLOD trees.
				//o.screenPos = ComputeScreenPos(o.pos); //<- Added for LushLOD trees.


				TRANSFER_SHADOW_CASTER_NORMALOFFSET(o)
					return o;
			}
			fixed _Cutoff;
			float4 frag_surf(v2f_surf IN) : SV_Target{
				half alpha = tex2D(_MainTex, IN.texPos).a;


			//////////*************************************
			//////////START of code added for LushLOD Trees
			//////////*************************************

			#if UNITY_UV_STARTS_AT_TOP
				float grabSign = -_ProjectionParams.x;
			#else
				float grabSign = _ProjectionParams.x;
			#endif

				IN.texPos.y *= _ProjectionParams.x;

				float2 sceneUVs = float2(1, grabSign)*IN.texPos*0.005 + 0.005;

				float Clipped_alpha = alpha >= _Cutoff ? alpha : -1.0; //<-- this clips the transparent parts of the texture, and we do that here first, to get that out of the way.
				float Coserp_Result = (Clipped_alpha * 1.0 - cos((_Transparency*3.141592654*0.5))); //<-- same thing as Mathf.Coserp(), see Google. This helps fade in the leaves more gradually at first, instead of them appearing so suddenly.

				float rescaled2 = lerp(0.0588, 1, Coserp_Result); //<-- rescales the transition to range from 0.0588 to 1, instead of from 0 to 1, to trim a little wasted curve space off the beginning.
				float rescaled3 = lerp(0.0588, 3, Coserp_Result); //<-- rescales the transition to range from 0.0588 to 3, instead of from 0 to 1 -- this ensures the dithering is fully GONE when _Transparency is 1.
				float rescaled4 = lerp(rescaled2, rescaled3, _Transparency); //<-- "rescaled2" helps bring the dithering in more slowly at first, but leaves some dithering still remaining. "rescaled3" remedies that.

				float dither = BinaryDither4x4(rescaled4 - 1.5, sceneUVs); //<-- calculates the dithering.
				clip(dither); //<-- THIS FIRST CLIP is based on TEXTURE SPACE dithering. It is "chunky" in apperance. Leaves begin to appear in chunks in the center of the tree first, where leaves are the most dense.

				//IN.screenPos.y *= _ProjectionParams.x;
				//IN.screenPos = float4(IN.screenPos.xy / IN.screenPos.w, 0, 0);
				//float2 screenUVs = float2(1, grabSign)*IN.screenPos.xy * 1 + 1;

				//float dither2 = BinaryDither2x2(rescaled4 - 1.5, screenUVs); //<-- calculates the dithering.		
				//clip(dither2); //<-- THIS SECOND CLIP is based on SCREEN SPACE dithering. It is very finely pixelated, and helps further soften the transition.
	
				//*************************************
				//END of code added for LushLOD Trees
				//*************************************

				SHADOW_CASTER_FRAGMENT(IN)

				}
					ENDCG
				}

	}

		Dependency "BillboardShader" = "Hidden/Nature/Tree Creator Leaves Rendertex"
}