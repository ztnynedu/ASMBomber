// Shader created with Shader Forge v1.38 
// Shader Forge (c) Neat Corporation / Joachim Holmer - http://www.acegikmo.com/shaderforge/
// Note: Manually altering this data may prevent you from opening it in Shader Forge
/*SF_DATA;ver:1.38;sub:START;pass:START;ps:flbk:,iptp:0,cusa:False,bamd:0,cgin:,lico:0,lgpr:1,limd:1,spmd:1,trmd:0,grmd:0,uamb:True,mssp:True,bkdf:False,hqlp:False,rprd:False,enco:False,rmgx:True,imps:True,rpth:0,vtps:0,hqsc:True,nrmq:1,nrsp:0,vomd:0,spxs:False,tesm:0,olmd:1,culm:0,bsrc:0,bdst:1,dpts:2,wrdp:True,dith:0,atcv:False,rfrpo:False,rfrpn:Refraction,coma:15,ufog:True,aust:False,igpj:False,qofs:51,qpre:2,rntp:3,fgom:False,fgoc:False,fgod:False,fgor:False,fgmd:0,fgcr:0.5657439,fgcg:0.6941743,fgcb:0.8014706,fgca:1,fgde:0.01,fgrn:0,fgrf:300,stcl:True,atwp:False,stva:191,stmr:255,stmw:255,stcp:6,stps:2,stfa:0,stfz:0,ofsf:0,ofsu:0,f2p0:False,fnsp:False,fnfb:True,fsmp:False;n:type:ShaderForge.SFN_Final,id:8808,x:32559,y:32640,varname:node_8808,prsc:2|diff-2758-OUT,alpha-3976-OUT,clip-9176-OUT;n:type:ShaderForge.SFN_Slider,id:7344,x:30676,y:32755,ptovrint:False,ptlb:Transparency,ptin:_Transparency,varname:_Transparency,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,min:0,cur:0,max:1;n:type:ShaderForge.SFN_Tex2d,id:3166,x:30699,y:32412,ptovrint:False,ptlb:MainTex,ptin:_MainTex,varname:_MainTex,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,ntxv:0,isnm:False;n:type:ShaderForge.SFN_Get,id:7770,x:30837,y:33042,varname:node_7770,prsc:2|IN-9043-OUT;n:type:ShaderForge.SFN_Set,id:4219,x:31248,y:33042,varname:Alpha_Smoothing,prsc:2|IN-956-OUT;n:type:ShaderForge.SFN_Clamp01,id:956,x:31063,y:33042,varname:node_956,prsc:2|IN-7770-OUT;n:type:ShaderForge.SFN_Set,id:3152,x:31496,y:32104,varname:Dither,prsc:2|IN-6752-OUT;n:type:ShaderForge.SFN_Code,id:6752,x:30885,y:32082,varname:node_6752,prsc:2,code:ZgBsAG8AYQB0ACAAQwBvAHMAZQByAHAAXwBSAGUAcwB1AGwAdAAgAD0AIAAoADEALgAwACAALQAgAGMAbwBzACgAKAB0AHIAYQBuAHMAKgAzAC4AMQA0ADEANQA5ADIANgA1ADQAKgAwAC4ANQApACkAKQA7ACAALwAvADwALQAtACAAcwBhAG0AZQAgAHQAaABpAG4AZwAgAGEAcwAgAE0AYQB0AGgAZgAuAEMAbwBzAGUAcgBwACgAKQAsACAAcwBlAGUAIABHAG8AbwBnAGwAZQAuACAAVABoAGkAcwAgAGgAZQBsAHAAcwAgAGYAYQBkAGUAIABpAG4AIAB0AGgAZQAgAGwAZQBhAHYAZQBzACAAbQBvAHIAZQAgAGcAcgBhAGQAdQBhAGwAbAB5ACAAYQB0ACAAZgBpAHIAcwB0ACwAIABpAG4AcwB0AGUAYQBkACAAbwBmACAAdABoAGUAbQAgAGEAcABwAGUAYQByAGkAbgBnACAAcwBvACAAcwB1AGQAZABlAG4AbAB5AC4ADQAKAGYAbABvAGEAdAAgAHIAZQBzAGMAYQBsAGUAZAAgAD0AIABsAGUAcgBwACgAMAAuADAANQA4ADgALAAgADEALgAwACwAIABDAG8AcwBlAHIAcABfAFIAZQBzAHUAbAB0ACkAOwAgAC8ALwA8AC0ALQAgAHIAZQBzAGMAYQBsAGUAcwAgAHQAaABlACAAdAByAGEAbgBzAGkAdABpAG8AbgAgAHQAbwAgAHIAYQBuAGcAZQAgAGYAcgBvAG0AIAAwAC4AMAA1ADgAOAAgAHQAbwAgADEALAAgAGkAbgBzAHQAZQBhAGQAIABvAGYAIABmAHIAbwBtACAAMAAgAHQAbwAgADEALAAgAHQAbwAgAHQAcgBpAG0AIABhACAAbABpAHQAdABsAGUAIAB3AGEAcwB0AGUAZAAgAGMAdQByAHYAZQAgAHMAcABhAGMAZQAgAG8AZgBmACAAdABoAGUAIABiAGUAZwBpAG4AbgBpAG4AZwAsACAAdABvACAAZQBuAHMAdQByAGUAIAB0AGgAYQB0ACAAdABoAGUAIABsAGUAYQB2AGUAcwAgAGIAZQBnAGkAbgAgAHQAbwAgAGEAcABwAGUAYQByACAAYQBzACAAcwBvAG8AbgAgAGEAcwAgAF8AVAByAGEAbgBzAHAAYQByAGUAbgBjAHkAIABpAHMAIABlAHYAZQBuACAAcwBsAGkAZwBoAHQAbAB5ACAAYQBiAG8AdgBlACAAegBlAHIAbwAgACgAbwB0AGgAZQByAHcAaQBzAGUAIAB0AGgAZQB5ACAAZABvAG4AJwB0ACAAZQB2AGUAbgAgAHMAdABhAHIAdAAgAHQAbwAgAGEAcABwAGUAYQByACAAdQBuAHQAaQBsACAAXwBUAHIAYQBuAHMAcABhAHIAZQBuAGMAeQAgAGkAcwAgAG4AZQBhAHIAbAB5ACAAMAAuADIAIQApAC4AIABFAEQASQBUADoAIAA5ADkAIAB3AG8AcgBrAHMAIABiAGUAdAB0AGUAcgAgAHQAaABhAG4AIAAxAC4ALgAuACAAaQB0ACAAZQBuAHMAdQByAGUAcwAgAGkAdAAgAGUAbgBkAHMAIAB1AHAAIABmAHUAbABsAHkAIABvAHAAYQBxAHUAZQAgAHcAaQB0AGgAIABuAG8AIABkAGkAdABoAGUAcgBpAG4AZwAgAHMAdABpAGwAbAAgAGwAaQBuAGcAZQByAGkAbgBnAC4ADQAKAGYAbABvAGEAdAAgAGQAaQB0AGgAZQByACAAPQAgAG0AYQB0AHIAaQB4AEkATgAgACsAIAByAGUAcwBjAGEAbABlAGQAOwAgAC8ALwA8AC0ALQAgAGMAYQBsAGMAdQBsAGEAdABlAHMAIAB0AGgAZQAgAGQAaQB0AGgAZQByAGkAbgBnAC4ACgByAGUAdAB1AHIAbgAgAGQAaQB0AGgAZQByADsA,output:0,fname:Dither_SMOOTHING,width:505,height:128,input:0,input:0,input:0,input_1_label:matrixIN,input_2_label:cut_off,input_3_label:trans|A-267-OUT,B-3935-OUT,C-1026-OUT;n:type:ShaderForge.SFN_Get,id:3935,x:30625,y:32163,varname:node_3935,prsc:2|IN-970-OUT;n:type:ShaderForge.SFN_Get,id:2567,x:30625,y:32262,varname:node_2567,prsc:2|IN-4219-OUT;n:type:ShaderForge.SFN_Code,id:267,x:30142,y:32081,varname:node_267,prsc:2,code:ZgBsAG8AYQB0ADIAIABwAHgAIAA9ACAAZgBsAG8AbwByACgAXwBTAGMAcgBlAGUAbgBQAGEAcgBhAG0AcwAuAHgAeQAgACoAIABzAGMAcgBlAGUAbgBVAFYAcwApADsACgByAGUAdAB1AHIAbgAgACgAZgBtAG8AZAAoAHAAeAAuAHgAIAArACAAcAB4AC4AeQAsACAAMgApACAAPQA9ACAAMQApACAAPwAgAC0AMAAuADQANQAgADoAIAAxADsA,output:0,fname:XYtest,width:377,height:132,input:1,input_1_label:screenUVs|A-7831-UVOUT;n:type:ShaderForge.SFN_ScreenPos,id:7831,x:29927,y:32078,varname:node_7831,prsc:2,sctp:2;n:type:ShaderForge.SFN_Set,id:970,x:31017,y:32646,varname:Param_Cutoff,prsc:2|IN-2469-OUT;n:type:ShaderForge.SFN_Slider,id:2469,x:30676,y:32647,ptovrint:False,ptlb:Cutoff,ptin:_Cutoff,varname:_Cutoff,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,min:0,cur:0.7,max:1;n:type:ShaderForge.SFN_Set,id:9043,x:31017,y:32748,varname:Param_Transparency,prsc:2|IN-7344-OUT;n:type:ShaderForge.SFN_Get,id:9176,x:32305,y:32936,varname:node_9176,prsc:2|IN-3152-OUT;n:type:ShaderForge.SFN_Color,id:6756,x:31306,y:32648,ptovrint:False,ptlb:Color,ptin:_Color,varname:_Color,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,c1:1,c2:1,c3:1,c4:1;n:type:ShaderForge.SFN_Multiply,id:2758,x:31768,y:32486,varname:node_2758,prsc:2|A-3166-RGB,B-6756-RGB;n:type:ShaderForge.SFN_Set,id:4952,x:31921,y:33042,varname:AlphaToPostProcessor,prsc:2|IN-2321-OUT;n:type:ShaderForge.SFN_Get,id:3976,x:32305,y:32863,varname:node_3976,prsc:2|IN-4952-OUT;n:type:ShaderForge.SFN_RemapRange,id:2321,x:31734,y:33042,varname:node_2321,prsc:2,frmn:0,frmx:1,tomn:0.01,tomx:0.95|IN-3511-OUT;n:type:ShaderForge.SFN_Get,id:3511,x:31515,y:33042,varname:node_3511,prsc:2|IN-9043-OUT;n:type:ShaderForge.SFN_Get,id:1026,x:30625,y:32213,varname:node_1026,prsc:2|IN-9043-OUT;proporder:7344-3166-2469-6756;pass:END;sub:END;*/

Shader "Hidden/LushLODTree/HQTreeBark_Ultra" {
    Properties {
        _Transparency ("Transparency", Range(0, 1)) = 0
        _MainTex ("MainTex", 2D) = "white" {}
        _Cutoff ("Cutoff", Range(0, 1)) = 0.7
        _Color ("Color", Color) = (1,1,1,1)
        [HideInInspector]_Cutoff ("Alpha cutoff", Range(0,1)) = 0.5
    }
    SubShader {
        Tags {
            "Queue"="AlphaTest+51"
            "RenderType"="TransparentCutout"
        }
        LOD 100
        Pass {
            Name "FORWARD"
            Tags {
                "LightMode"="ForwardBase"
            }
            
            
            Stencil {
                Ref 191
                Pass Replace
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
            float Dither_SMOOTHING( float matrixIN , float cut_off , float trans ){
            float Coserp_Result = (1.0 - cos((trans*3.141592654*0.5))); //<-- same thing as Mathf.Coserp(), see Google. This helps fade in the leaves more gradually at first, instead of them appearing so suddenly.
            float rescaled = lerp(0.0588, 1.0, Coserp_Result); //<-- rescales the transition to range from 0.0588 to 1, instead of from 0 to 1, to trim a little wasted curve space off the beginning, to ensure that the leaves begin to appear as soon as _Transparency is even slightly above zero (otherwise they don't even start to appear until _Transparency is nearly 0.2!). EDIT: 99 works better than 1... it ensures it ends up fully opaque with no dithering still lingering.
            float dither = matrixIN + rescaled; //<-- calculates the dithering.
            return dither;
            }
            
            float XYtest( float2 screenUVs ){
            float2 px = floor(_ScreenParams.xy * screenUVs);
            return (fmod(px.x + px.y, 2) == 1) ? -0.45 : 1;
            }
            
            uniform float _Cutoff;
            uniform float4 _Color;
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
                float Dither = Dither_SMOOTHING( XYtest( sceneUVs.rg ) , Param_Cutoff , Param_Transparency );
                clip(Dither - 0.5);
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
                float AlphaToPostProcessor = (Param_Transparency*0.94+0.01);
                fixed4 finalRGBA = fixed4(finalColor,AlphaToPostProcessor);
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
            float Dither_SMOOTHING( float matrixIN , float cut_off , float trans ){
            float Coserp_Result = (1.0 - cos((trans*3.141592654*0.5))); //<-- same thing as Mathf.Coserp(), see Google. This helps fade in the leaves more gradually at first, instead of them appearing so suddenly.
            float rescaled = lerp(0.0588, 1.0, Coserp_Result); //<-- rescales the transition to range from 0.0588 to 1, instead of from 0 to 1, to trim a little wasted curve space off the beginning, to ensure that the leaves begin to appear as soon as _Transparency is even slightly above zero (otherwise they don't even start to appear until _Transparency is nearly 0.2!). EDIT: 99 works better than 1... it ensures it ends up fully opaque with no dithering still lingering.
            float dither = matrixIN + rescaled; //<-- calculates the dithering.
            return dither;
            }
            
            float XYtest( float2 screenUVs ){
            float2 px = floor(_ScreenParams.xy * screenUVs);
            return (fmod(px.x + px.y, 2) == 1) ? -0.45 : 1;
            }
            
            uniform float _Cutoff;
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
                float Dither = Dither_SMOOTHING( XYtest( sceneUVs.rg ) , Param_Cutoff , Param_Transparency );
                clip(Dither - 0.5);
                SHADOW_CASTER_FRAGMENT(i)
            }
            ENDCG
        }
    }
    CustomEditor "ShaderForgeMaterialInspector"
}
