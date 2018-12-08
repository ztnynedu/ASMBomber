// Shader created with Shader Forge v1.38 
// Shader Forge (c) Neat Corporation / Joachim Holmer - http://www.acegikmo.com/shaderforge/
// Note: Manually altering this data may prevent you from opening it in Shader Forge
/*SF_DATA;ver:1.38;sub:START;pass:START;ps:flbk:,iptp:0,cusa:False,bamd:0,cgin:,lico:0,lgpr:1,limd:1,spmd:1,trmd:0,grmd:0,uamb:True,mssp:True,bkdf:False,hqlp:False,rprd:False,enco:False,rmgx:True,imps:True,rpth:0,vtps:0,hqsc:True,nrmq:1,nrsp:0,vomd:0,spxs:False,tesm:0,olmd:1,culm:0,bsrc:0,bdst:1,dpts:2,wrdp:True,dith:0,atcv:False,rfrpo:False,rfrpn:Refraction,coma:15,ufog:True,aust:False,igpj:False,qofs:0,qpre:1,rntp:1,fgom:False,fgoc:False,fgod:False,fgor:False,fgmd:0,fgcr:0.5657439,fgcg:0.6941743,fgcb:0.8014706,fgca:1,fgde:0.01,fgrn:0,fgrf:300,stcl:False,atwp:False,stva:128,stmr:255,stmw:255,stcp:6,stps:2,stfa:0,stfz:0,ofsf:0,ofsu:0,f2p0:False,fnsp:False,fnfb:True,fsmp:False;n:type:ShaderForge.SFN_Final,id:8808,x:33060,y:32754,varname:node_8808,prsc:2|diff-2758-OUT,clip-6252-OUT;n:type:ShaderForge.SFN_Slider,id:7344,x:30676,y:32755,ptovrint:False,ptlb:Transparency,ptin:_Transparency,varname:_Transparency,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,min:0,cur:0,max:1;n:type:ShaderForge.SFN_Tex2d,id:3166,x:30699,y:32412,ptovrint:False,ptlb:MainTex,ptin:_MainTex,varname:_MainTex,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,ntxv:0,isnm:False;n:type:ShaderForge.SFN_Set,id:970,x:31017,y:32646,varname:Param_Cutoff,prsc:2|IN-2469-OUT;n:type:ShaderForge.SFN_Slider,id:2469,x:30676,y:32647,ptovrint:False,ptlb:Cutoff,ptin:_Cutoff,varname:_Cutoff,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,min:0,cur:0.7,max:1;n:type:ShaderForge.SFN_Set,id:9043,x:31017,y:32748,varname:Param_Transparency,prsc:2|IN-7344-OUT;n:type:ShaderForge.SFN_Color,id:6756,x:31342,y:32507,ptovrint:False,ptlb:Color,ptin:_Color,varname:_Color,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,c1:1,c2:1,c3:1,c4:1;n:type:ShaderForge.SFN_Multiply,id:2758,x:31804,y:32345,varname:node_2758,prsc:2|A-3166-RGB,B-6756-RGB;n:type:ShaderForge.SFN_Code,id:4362,x:30896,y:33103,varname:node_4362,prsc:2,code:ZgBsAG8AYQB0ADQAeAA0ACAAbQB0AHgAIAA9ACAAZgBsAG8AYQB0ADQAeAA0ACgACgAJAGYAbABvAGEAdAA0ACgAMQAsACAAOQAsACAAMwAsACAAMQAxACkAIAAvACAAMQA3AC4AMAAsAAoACQBmAGwAbwBhAHQANAAoADEAMwAsACAANQAsACAAMQA1ACwAIAA3ACkAIAAvACAAMQA3AC4AMAAsAAoACQBmAGwAbwBhAHQANAAoADQALAAgADEAMgAsACAAMgAsACAAMQAwACkAIAAvACAAMQA3AC4AMAAsAAoACQBmAGwAbwBhAHQANAAoADEANgAsACAAOAAsACAAMQA0ACwAIAA2ACkAIAAvACAAMQA3AC4AMAAKACkAOwAKAGYAbABvAGEAdAAyACAAcAB4ACAAPQAgAGYAbABvAG8AcgAoAF8AUwBjAHIAZQBlAG4AUABhAHIAYQBtAHMALgB4AHkAIAAqACAAcwBjAHIAZQBlAG4AVQBWAHMAKQA7AAoAaQBuAHQAIAB4AFMAbQBwACAAPQAgAGYAbQBvAGQAKABwAHgALgB4ACwAIAA0ACkAOwAKAGkAbgB0ACAAeQBTAG0AcAAgAD0AIABmAG0AbwBkACgAcAB4AC4AeQAsACAANAApADsACgBmAGwAbwBhAHQANAAgAHgAVgBlAGMAIAA9ACAAMQAgAC0AIABzAGEAdAB1AHIAYQB0AGUAKABhAGIAcwAoAGYAbABvAGEAdAA0ACgAMAAsACAAMQAsACAAMgAsACAAMwApACAALQAgAHgAUwBtAHAAKQApADsACgBmAGwAbwBhAHQANAAgAHkAVgBlAGMAIAA9ACAAMQAgAC0AIABzAGEAdAB1AHIAYQB0AGUAKABhAGIAcwAoAGYAbABvAGEAdAA0ACgAMAAsACAAMQAsACAAMgAsACAAMwApACAALQAgAHkAUwBtAHAAKQApADsACgBmAGwAbwBhAHQANAAgAHAAeABNAHUAbAB0ACAAPQAgAGYAbABvAGEAdAA0ACgAZABvAHQAKABtAHQAeABbADAAXQAsACAAeQBWAGUAYwApACwAIABkAG8AdAAoAG0AdAB4AFsAMQBdACwAIAB5AFYAZQBjACkALAAgAGQAbwB0ACgAbQB0AHgAWwAyAF0ALAAgAHkAVgBlAGMAKQAsACAAZABvAHQAKABtAHQAeABbADMAXQAsACAAeQBWAGUAYwApACkAOwAKAHIAZQB0AHUAcgBuACAAZABvAHQAKABwAHgATQB1AGwAdAAsACAAeABWAGUAYwApADsA,output:0,fname:BinaryDither4x4_FOR_MAIN_PASS,width:760,height:213,input:1,input_1_label:screenUVs|A-6672-OUT;n:type:ShaderForge.SFN_Code,id:6672,x:30341,y:33102,varname:node_6672,prsc:2,code:IwBpAGYAIABVAE4ASQBUAFkAXwBVAFYAXwBTAFQAQQBSAFQAUwBfAEEAVABfAFQATwBQAA0ACgAJAGYAbABvAGEAdAAgAGcAcgBhAGIAUwBpAGcAbgAgAD0AIAAtAF8AUAByAG8AagBlAGMAdABpAG8AbgBQAGEAcgBhAG0AcwAuAHgAOwANAAoAIwBlAGwAcwBlAA0ACgAJAGYAbABvAGEAdAAgAGcAcgBhAGIAUwBpAGcAbgAgAD0AIABfAFAAcgBvAGoAZQBjAHQAaQBvAG4AUABhAHIAYQBtAHMALgB4ADsADQAKACMAZQBuAGQAaQBmAAoAcgBlAHQAdQByAG4AIABmAGwAbwBhAHQAMgAoADEALAAgAGcAcgBhAGIAUwBpAGcAbgApACoAcwBjAHIAZQBlAG4AUABvAHMALgB4AHkAKgAwAC4ANQAgACsAIAAwAC4ANQA7AA==,output:1,fname:GimmeScreenSpaceUV_MAINPASS,width:445,height:148,input:1,input_1_label:screenPos|A-8908-UVOUT;n:type:ShaderForge.SFN_ScreenPos,id:8908,x:30051,y:33089,varname:node_8908,prsc:2,sctp:0;n:type:ShaderForge.SFN_Code,id:6252,x:32053,y:33091,varname:node_6252,prsc:2,code:ZgBsAG8AYQB0ACAAQwBvAHMAZQByAHAAXwBSAGUAcwB1AGwAdAAgAD0AIAAoADEALgAwACAALQAgAGMAbwBzACgAKAB0AHIAYQBuAHMAKgAzAC4AMQA0ADEANQA5ADIANgA1ADQAKgAwAC4ANQApACkAKQA7ACAALwAvADwALQAtACAAcwBhAG0AZQAgAHQAaABpAG4AZwAgAGEAcwAgAE0AYQB0AGgAZgAuAEMAbwBzAGUAcgBwACgAKQAsACAAcwBlAGUAIABHAG8AbwBnAGwAZQAuACAAVABoAGkAcwAgAGgAZQBsAHAAcwAgAGYAYQBkAGUAIABpAG4AIAB0AGgAZQAgAGwAZQBhAHYAZQBzACAAbQBvAHIAZQAgAGcAcgBhAGQAdQBhAGwAbAB5ACAAYQB0ACAAZgBpAHIAcwB0ACwAIABpAG4AcwB0AGUAYQBkACAAbwBmACAAdABoAGUAbQAgAGEAcABwAGUAYQByAGkAbgBnACAAcwBvACAAcwB1AGQAZABlAG4AbAB5AC4ADQAKAGYAbABvAGEAdAAgAHIAZQBzAGMAYQBsAGUAZAAgAD0AIABsAGUAcgBwACgAMAAuADAANQA4ADgALAAgADEALgAwACwAIABDAG8AcwBlAHIAcABfAFIAZQBzAHUAbAB0ACkAOwAgAC8ALwA8AC0ALQAgAHIAZQBzAGMAYQBsAGUAcwAgAHQAaABlACAAdAByAGEAbgBzAGkAdABpAG8AbgAgAHQAbwAgAHIAYQBuAGcAZQAgAGYAcgBvAG0AIAAwAC4AMAA1ADgAOAAgAHQAbwAgADEALAAgAGkAbgBzAHQAZQBhAGQAIABvAGYAIABmAHIAbwBtACAAMAAgAHQAbwAgADEALAAgAHQAbwAgAHQAcgBpAG0AIABhACAAbABpAHQAdABsAGUAIAB3AGEAcwB0AGUAZAAgAGMAdQByAHYAZQAgAHMAcABhAGMAZQAgAG8AZgBmACAAdABoAGUAIABiAGUAZwBpAG4AbgBpAG4AZwAsACAAdABvACAAZQBuAHMAdQByAGUAIAB0AGgAYQB0ACAAdABoAGUAIABsAGUAYQB2AGUAcwAgAGIAZQBnAGkAbgAgAHQAbwAgAGEAcABwAGUAYQByACAAYQBzACAAcwBvAG8AbgAgAGEAcwAgAF8AVAByAGEAbgBzAHAAYQByAGUAbgBjAHkAIABpAHMAIABlAHYAZQBuACAAcwBsAGkAZwBoAHQAbAB5ACAAYQBiAG8AdgBlACAAegBlAHIAbwAgACgAbwB0AGgAZQByAHcAaQBzAGUAIAB0AGgAZQB5ACAAZABvAG4AJwB0ACAAZQB2AGUAbgAgAHMAdABhAHIAdAAgAHQAbwAgAGEAcABwAGUAYQByACAAdQBuAHQAaQBsACAAXwBUAHIAYQBuAHMAcABhAHIAZQBuAGMAeQAgAGkAcwAgAG4AZQBhAHIAbAB5ACAAMAAuADIAIQApAC4AIABFAEQASQBUADoAIAA5ADkAIAB3AG8AcgBrAHMAIABiAGUAdAB0AGUAcgAgAHQAaABhAG4AIAAxAC4ALgAuACAAaQB0ACAAZQBuAHMAdQByAGUAcwAgAGkAdAAgAGUAbgBkAHMAIAB1AHAAIABmAHUAbABsAHkAIABvAHAAYQBxAHUAZQAgAHcAaQB0AGgAIABuAG8AIABkAGkAdABoAGUAcgBpAG4AZwAgAHMAdABpAGwAbAAgAGwAaQBuAGcAZQByAGkAbgBnAC4ADQAKAGYAbABvAGEAdAAgAGQAaQB0AGgAZQByACAAPQAgAG0AYQB0AHIAaQB4AEkATgAgACsAIAAoAHIAZQBzAGMAYQBsAGUAZAAgAC0AIAAxAC4ANQApADsAIAAvAC8APAAtAC0AIABjAGEAbABjAHUAbABhAHQAZQBzACAAdABoAGUAIABkAGkAdABoAGUAcgBpAG4AZwAuAAoAcgBlAHQAdQByAG4AIABkAGkAdABoAGUAcgAgACsAIAAxAC4AMAA7AA==,output:0,fname:Dither_FOR_MAIN_PASS,width:863,height:128,input:0,input:0,input:0,input_1_label:matrixIN,input_2_label:cut_off,input_3_label:trans|A-4362-OUT,B-5765-OUT,C-671-OUT;n:type:ShaderForge.SFN_Get,id:671,x:31833,y:33202,varname:node_671,prsc:2|IN-9043-OUT;n:type:ShaderForge.SFN_Get,id:5765,x:31833,y:33148,varname:node_5765,prsc:2|IN-970-OUT;proporder:7344-3166-2469-6756;pass:END;sub:END;*/

Shader "Hidden/LushLODTree/HQTreeBark" {
    Properties {
        _Transparency ("Transparency", Range(0, 1)) = 0
        _MainTex ("MainTex", 2D) = "white" {}
        _Cutoff ("Cutoff", Range(0, 1)) = 0.7
        _Color ("Color", Color) = (1,1,1,1)
        [HideInInspector]_Cutoff ("Alpha cutoff", Range(0,1)) = 0.5
    }
    SubShader {
        Tags {
            "RenderType"="Opaque"
        }
        LOD 100
        Pass {
            Name "FORWARD"
            Tags {
                "LightMode"="ForwardBase"
            }
            
            
            CGPROGRAM
            #pragma vertex vert
            #pragma fragment frag
			#ifndef UNITY_PASS_FORWARDBASE //<-- fixes really weird bug.
			#define UNITY_PASS_FORWARDBASE
			#endif
            #include "UnityCG.cginc"
            #include "AutoLight.cginc"
            #pragma multi_compile_fwdbase_fullshadows
            #pragma multi_compile_fog
            #pragma target 3.0
            uniform float4 _LightColor0;
            uniform float _Transparency;
            uniform sampler2D _MainTex; uniform float4 _MainTex_ST;
            uniform float _Cutoff;
            uniform float4 _Color;
            float BinaryDither4x4_FOR_MAIN_PASS( float2 screenUVs ){
            float4x4 mtx = float4x4(
            	float4(1, 9, 3, 11) / 17.0,
            	float4(13, 5, 15, 7) / 17.0,
            	float4(4, 12, 2, 10) / 17.0,
            	float4(16, 8, 14, 6) / 17.0
            );
            float2 px = floor(_ScreenParams.xy * screenUVs);
            int xSmp = fmod(px.x, 4);
            int ySmp = fmod(px.y, 4);
            float4 xVec = 1 - saturate(abs(float4(0, 1, 2, 3) - xSmp));
            float4 yVec = 1 - saturate(abs(float4(0, 1, 2, 3) - ySmp));
            float4 pxMult = float4(dot(mtx[0], yVec), dot(mtx[1], yVec), dot(mtx[2], yVec), dot(mtx[3], yVec));
            return dot(pxMult, xVec);
            }
            
            float2 GimmeScreenSpaceUV_MAINPASS( float2 screenPos ){
            #if UNITY_UV_STARTS_AT_TOP
            	float grabSign = -_ProjectionParams.x;
            #else
            	float grabSign = _ProjectionParams.x;
            #endif
            return float2(1, grabSign)*screenPos.xy*0.5 + 0.5;
            }
            
            float Dither_FOR_MAIN_PASS( float matrixIN , float cut_off , float trans ){
            float Coserp_Result = (1.0 - cos((trans*3.141592654*0.5))); //<-- same thing as Mathf.Coserp(), see Google. This helps fade in the leaves more gradually at first, instead of them appearing so suddenly.
            float rescaled = lerp(0.0588, 1.0, Coserp_Result); //<-- rescales the transition to range from 0.0588 to 1, instead of from 0 to 1, to trim a little wasted curve space off the beginning, to ensure that the leaves begin to appear as soon as _Transparency is even slightly above zero (otherwise they don't even start to appear until _Transparency is nearly 0.2!). EDIT: 99 works better than 1... it ensures it ends up fully opaque with no dithering still lingering.
            float dither = matrixIN + (rescaled - 1.5); //<-- calculates the dithering.
            return dither + 1.0;
            }
            
            struct VertexInput {
                float4 vertex : POSITION;
                float3 normal : NORMAL;
                float2 texcoord0 : TEXCOORD0;
            };
            struct VertexOutput {
                float4 pos : SV_POSITION;
                float2 uv0 : TEXCOORD0;
                float4 posWorld : TEXCOORD1;
                float3 normalDir : TEXCOORD2;
                float4 projPos : TEXCOORD3;
                LIGHTING_COORDS(4,5)
                UNITY_FOG_COORDS(6)
            };
            VertexOutput vert (VertexInput v) {
                VertexOutput o = (VertexOutput)0;
                o.uv0 = v.texcoord0;
                o.normalDir = UnityObjectToWorldNormal(v.normal);
                o.posWorld = mul(unity_ObjectToWorld, v.vertex);
                float3 lightColor = _LightColor0.rgb;
                o.pos = UnityObjectToClipPos( v.vertex );
                UNITY_TRANSFER_FOG(o,o.pos);
                o.projPos = ComputeScreenPos (o.pos);
                COMPUTE_EYEDEPTH(o.projPos.z);
                TRANSFER_VERTEX_TO_FRAGMENT(o)
                return o;
            }
            float4 frag(VertexOutput i) : COLOR {
                i.normalDir = normalize(i.normalDir);
                float3 normalDirection = i.normalDir;
                float2 sceneUVs = (i.projPos.xy / i.projPos.w);
                float Param_Cutoff = _Cutoff;
                float Param_Transparency = _Transparency;
                clip(Dither_FOR_MAIN_PASS( BinaryDither4x4_FOR_MAIN_PASS( GimmeScreenSpaceUV_MAINPASS( (sceneUVs * 2 - 1).rg ) ) , Param_Cutoff , Param_Transparency ) - 0.5);
                float3 lightDirection = normalize(_WorldSpaceLightPos0.xyz);
                float3 lightColor = _LightColor0.rgb;
////// Lighting:
                float attenuation = LIGHT_ATTENUATION(i);
                float3 attenColor = attenuation * _LightColor0.xyz;
/////// Diffuse:
                float NdotL = max(0.0,dot( normalDirection, lightDirection ));
                float3 directDiffuse = max( 0.0, NdotL) * attenColor;
                float3 indirectDiffuse = float3(0,0,0);
                indirectDiffuse += UNITY_LIGHTMODEL_AMBIENT.rgb; // Ambient Light
                float4 _MainTex_var = tex2D(_MainTex,TRANSFORM_TEX(i.uv0, _MainTex));
                float3 diffuseColor = (_MainTex_var.rgb*_Color.rgb);
                float3 diffuse = (directDiffuse + indirectDiffuse) * diffuseColor;
/// Final Color:
                float3 finalColor = diffuse;
                fixed4 finalRGBA = fixed4(finalColor,1);
                UNITY_APPLY_FOG(i.fogCoord, finalRGBA);
                return finalRGBA;
            }
            ENDCG
        }
        Pass {
            Name "ShadowCaster"
            Tags {
                "LightMode"="ShadowCaster"
            }
            Offset 1, 1
            Cull Back
            
            CGPROGRAM
            #pragma vertex vert
            #pragma fragment frag
			#ifndef UNITY_PASS_SHADOWCASTER //<-- fixes really weird bug.
			#define UNITY_PASS_SHADOWCASTER
			#endif
            #include "UnityCG.cginc"
            #include "Lighting.cginc"
            #pragma fragmentoption ARB_precision_hint_fastest
            #pragma multi_compile_shadowcaster
            #pragma multi_compile_fog
            #pragma target 3.0
            uniform float _Transparency;
            uniform float _Cutoff;
            float BinaryDither4x4_FOR_MAIN_PASS( float2 screenUVs ){
            float4x4 mtx = float4x4(
            	float4(1, 9, 3, 11) / 17.0,
            	float4(13, 5, 15, 7) / 17.0,
            	float4(4, 12, 2, 10) / 17.0,
            	float4(16, 8, 14, 6) / 17.0
            );
            float2 px = floor(_ScreenParams.xy * screenUVs);
            int xSmp = fmod(px.x, 4);
            int ySmp = fmod(px.y, 4);
            float4 xVec = 1 - saturate(abs(float4(0, 1, 2, 3) - xSmp));
            float4 yVec = 1 - saturate(abs(float4(0, 1, 2, 3) - ySmp));
            float4 pxMult = float4(dot(mtx[0], yVec), dot(mtx[1], yVec), dot(mtx[2], yVec), dot(mtx[3], yVec));
            return dot(pxMult, xVec);
            }
            
            float2 GimmeScreenSpaceUV_MAINPASS( float2 screenPos ){
            #if UNITY_UV_STARTS_AT_TOP
            	float grabSign = -_ProjectionParams.x;
            #else
            	float grabSign = _ProjectionParams.x;
            #endif
            return float2(1, grabSign)*screenPos.xy*0.5 + 0.5;
            }
            
            float Dither_FOR_MAIN_PASS( float matrixIN , float cut_off , float trans ){
            float Coserp_Result = (1.0 - cos((trans*3.141592654*0.5))); //<-- same thing as Mathf.Coserp(), see Google. This helps fade in the leaves more gradually at first, instead of them appearing so suddenly.
            float rescaled = lerp(0.0588, 1.0, Coserp_Result); //<-- rescales the transition to range from 0.0588 to 1, instead of from 0 to 1, to trim a little wasted curve space off the beginning, to ensure that the leaves begin to appear as soon as _Transparency is even slightly above zero (otherwise they don't even start to appear until _Transparency is nearly 0.2!). EDIT: 99 works better than 1... it ensures it ends up fully opaque with no dithering still lingering.
            float dither = matrixIN + (rescaled - 1.5); //<-- calculates the dithering.
            return dither + 1.0;
            }
            
            struct VertexInput {
                float4 vertex : POSITION;
            };
            struct VertexOutput {
                V2F_SHADOW_CASTER;
                float4 projPos : TEXCOORD1;
            };
            VertexOutput vert (VertexInput v) {
                VertexOutput o = (VertexOutput)0;
                o.pos = UnityObjectToClipPos( v.vertex );
                o.projPos = ComputeScreenPos (o.pos);
                COMPUTE_EYEDEPTH(o.projPos.z);
                TRANSFER_SHADOW_CASTER(o)
                return o;
            }
            float4 frag(VertexOutput i) : COLOR {
                float2 sceneUVs = (i.projPos.xy / i.projPos.w);
                float Param_Cutoff = _Cutoff;
                float Param_Transparency = _Transparency;
                clip(Dither_FOR_MAIN_PASS( BinaryDither4x4_FOR_MAIN_PASS( GimmeScreenSpaceUV_MAINPASS( (sceneUVs * 2 - 1).rg ) ) , Param_Cutoff , Param_Transparency ) - 0.5);
                SHADOW_CASTER_FRAGMENT(i)
            }
            ENDCG
        }
    }
    CustomEditor "ShaderForgeMaterialInspector"
}
