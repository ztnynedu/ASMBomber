// Upgrade NOTE: replaced '_Object2World' with 'unity_ObjectToWorld'

Shader "Hidden/LushLODTree/Tree Creator Leaves Fast Optimized Simple Shadows" {
	Properties{
		_Color("Main Color", Color) = (1,1,1,1)
		_TranslucencyColor("Translucency Color", Color) = (0.73,0.85,0.41,1) // (187,219,106,255)
		_Cutoff("Alpha cutoff", Range(0,1)) = 0.3
		_TranslucencyViewDependency("View dependency", Range(0,1)) = 0.7
		_ShadowStrength("Shadow Strength", Range(0,1)) = 0.8 //<- Modified for LushLOD trees.
		_Transparency("Opacity", Range(0, 1)) = 1.0 //<- Added for LushLOD trees.

		_MainTex("Base (RGB) Alpha (A)", 2D) = "white" {}
		_ShadowTex("Shadow (RGB)", 2D) = "white" {}

		_ShadowMapFront("ShadowMapFront", 2D) = "white" {} //<- Added for LushLOD trees.
		_ShadowMapRight("ShadowMapRight", 2D) = "white" {} //<- Added for LushLOD trees.

		// These are here only to provide default values
		[HideInInspector] _TreeInstanceColor("TreeInstanceColor", Vector) = (1,1,1,1)
		[HideInInspector] _TreeInstanceScale("TreeInstanceScale", Vector) = (1,1,1,1)
		[HideInInspector] _SquashAmount("Squash", Float) = 1
	}

		SubShader{
			Tags {
				"IgnoreProjector" = "True"
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
				#pragma multi_compile_fwdbase nolightmap// noforwardadd noambient //<-- no ambient added for LushLOD Trees
				#pragma multi_compile_fog
				#pragma target 3.0

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
			//sampler2D _ShadowMapTexture; //<-- Removed for LushLOD Trees.
			sampler2D _ShadowMapFront; //<- Added for LushLOD trees.
			sampler2D _ShadowMapRight; //<- Added for LushLOD trees.
			float4 _ShadowMapFront_ST; //<- Added for LushLOD trees.
			float4 _ShadowMapRight_ST; //<- Added for LushLOD trees.

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

			struct v2f_leaf {
				float4 pos : SV_POSITION;
				fixed4 diffuse : COLOR0;
				//#if defined(SHADOWS_SCREEN)
				//	fixed4 mainLight : COLOR1;
				//#endif
					float2 uv : TEXCOORD0;
					//#if defined(SHADOWS_SCREEN)
					//	float4 screenPos : TEXCOORD1;
					//#endif
						float2 uv3_ShadowMapFront : TEXCOORD3; //<- Added for LushLOD trees.
						float2 uv4_ShadowMapRight : TEXCOORD4; //<- Added for LushLOD trees.
						float3 worldPos : TEXCOORD1; //<- Added for LushLOD trees.
						UNITY_FOG_COORDS(2)
					};

					v2f_leaf VertexLeaf(appdata_full v)
					{
						v2f_leaf o;
						TreeVertLeaf(v);
						o.pos = UnityObjectToClipPos(v.vertex);

						fixed ao = v.color.a;
						//ao += 0.1; ao = saturate(ao * ao * ao); // emphasize AO

						fixed3 color = v.color.rgb * (ao * _LushLODTreeAO);

						float3 worldN = UnityObjectToWorldNormal(v.normal);

						////////	fixed4 mainLight;
						////////	mainLight.rgb = ShadeTranslucentMainLight (v.vertex, worldN) * color;
						////////	mainLight.a = v.color.a;
						////////	o.diffuse.rgb = ShadeTranslucentLights (v.vertex, worldN) * color;
						////////	o.diffuse.a = v.color.a;//1;
						//////////#if defined(SHADOWS_SCREEN)
						//////////	o.mainLight = mainLight;
						//////////	o.screenPos = ComputeScreenPos (o.pos);
						//////////#else
						////////	o.diffuse += mainLight;
						//////////#endif			

							o.diffuse.rgb = color;
							o.diffuse.a = 1;

							o.worldPos = mul(unity_ObjectToWorld, v.vertex).xyz; //<-- Added for LushLOD Trees
							o.uv3_ShadowMapFront = TRANSFORM_TEX(v.texcoord2, _ShadowMapFront); //<-- Added for LushLOD Trees
							o.uv4_ShadowMapRight = TRANSFORM_TEX(v.texcoord3, _ShadowMapRight); //<-- Added for LushLOD Trees

							o.uv = TRANSFORM_TEX(v.texcoord, _MainTex);
							UNITY_TRANSFER_FOG(o,o.pos);
							return o;
						}

						fixed4 FragmentLeaf(v2f_leaf i) : SV_Target
						{
							fixed4 c = tex2D(_MainTex, i.uv); //<-- Modified for LushLOD Trees
							fixed alpha = c.a; //<-- Modified for LushLOD Trees


							//*************************************
							//START of code added for LushLOD Trees
							//*************************************

				#if UNITY_UV_STARTS_AT_TOP
							float grabSign = -_ProjectionParams.x;
				#else
							float grabSign = _ProjectionParams.x;
				#endif

							float2 uv_MainTex = i.uv;
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

										  //START OF SIMPLE SHADOWS CODE:

							_ShadowStrength *= 0.75; //<-- this FAST shader is always a little too strong on the shadow compared to the non-Fast shader. So this should even them out a bit. Feel free to comment out this line if it makes you mad.

							float3 viewDirection = normalize(_WorldSpaceCameraPos.xyz - i.worldPos.xyz);
							//float3 lightDirection = normalize(_WorldSpaceLightPos0.xyz);
							float3 _MainTex_var = c.rgb * i.diffuse.rgb; //<-- modified for FAST shader.



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
							//float LightAtten = (saturate((ShadowMapDarkeningVal*2.5 + -1.5))*TimeOfDayIntensity*_LushLODTreeTranslucency); // Used in our custom LightModel to create the translucency effect

							//DELETE: All the code below this line that
							//has to do with "LightAtten", as it is not needed
							//by this Fast Shader.


														
							//END OF SIMPLE SHADOWS CODE

							//finalColor = finalColor * saturate(i.diffuse.a + saturate(1.0 - _Transparency)); //<-- Added for LushLOD Trees

							//*************************************
							//END of code added for LushLOD Trees
							//*************************************

							//clip (alpha - _Cutoff); //<-- Removed for LushLOD Trees

							//REMOVED THE FOLLOWING LINES for LushLOD Trees:

							//#if defined(SHADOWS_SCREEN)
							//	half4 light = i.mainLight;
							//	half atten = tex2Dproj(_ShadowMapTexture, UNITY_PROJ_COORD(i.screenPos)).r;
							//	light.rgb *= lerp(1, atten, _ShadowStrength);
							//	light.rgb += i.diffuse.rgb;
							//#else
							//	half4 light = i.diffuse;
							//#endif

							//	fixed4 col = fixed4 (albedo.rgb * light, 0.0);
							//	UNITY_APPLY_FOG(i.fogCoord, col);
							//	return col;


							//float3 LightIN = (CheckLightmap(_LightColor0.rgb, _LushLODTreeMainLightDir.a) + _LushLODTreeAmbientColor.rgb);


							////TIME OF DAY CODE (copied from Tree_Leaves_Far2.shader):
							//float TimeOfDayIntensity2 = saturate(((saturate((dot(float3(0, 1, 0), LightDir) + 0.25)) * (1.3 + (BackView01*2.0))) / 1.0)); // This is an optional lighting adjustment you can remove this if your scene doesnt benefit from this.
							//finalColor.rgb *= TimeOfDayIntensity2;
							//finalColor.rgb *= LightIN;

							UNITY_APPLY_FOG(i.fogCoord, finalColor);

							return fixed4(finalColor.rgb, 1.0); //<-- Added for LushLOD Trees
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

							v2f_surf vert_surf(appdata_full v) {
								v2f_surf o;
								TreeVertLeaf(v);
								o.hip_pack0.xy = TRANSFORM_TEX(v.texcoord, _MainTex);
								TRANSFER_SHADOW_CASTER_NORMALOFFSET(o)
								return o;
							}

							fixed _Cutoff;

							half4 frag_surf(v2f_surf i) : SV_Target {
								fixed alpha = tex2D(_MainTex, i.hip_pack0.xy).a;

							//////////*************************************
							//////////START of code added for LushLOD Trees
							//////////*************************************

					#if UNITY_UV_STARTS_AT_TOP
							float grabSign = -_ProjectionParams.x;
					#else
							float grabSign = _ProjectionParams.x;
					#endif

							float2 texPos = i.hip_pack0;
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

								//clip (alpha - _Cutoff);
								SHADOW_CASTER_FRAGMENT(i)
							}

						ENDCG

						}

		}

			Dependency "BillboardShader" = "Hidden/Nature/Tree Creator Leaves Rendertex"
}
