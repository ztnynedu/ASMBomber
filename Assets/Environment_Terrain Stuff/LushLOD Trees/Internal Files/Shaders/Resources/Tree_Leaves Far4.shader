// Shader created with Shader Forge v1.38 
// Shader Forge (c) Neat Corporation / Joachim Holmer - http://www.acegikmo.com/shaderforge/
// Note: Manually altering this data may prevent you from opening it in Shader Forge
/*SF_DATA;ver:1.38;sub:START;pass:START;ps:flbk:,iptp:0,cusa:True,bamd:0,cgin:QwBHAEkAbgBjAGwAdQBkAGUAcwAvAEQAaQB0AGgAZQByAGkAbgBnAA==,lico:0,lgpr:1,limd:0,spmd:1,trmd:0,grmd:0,uamb:True,mssp:True,bkdf:False,hqlp:False,rprd:False,enco:False,rmgx:True,imps:True,rpth:0,vtps:0,hqsc:True,nrmq:1,nrsp:0,vomd:0,spxs:False,tesm:0,olmd:1,culm:2,bsrc:0,bdst:1,dpts:2,wrdp:True,dith:0,atcv:False,rfrpo:False,rfrpn:Refraction,coma:15,ufog:True,aust:False,igpj:False,qofs:51,qpre:2,rntp:3,fgom:False,fgoc:False,fgod:False,fgor:False,fgmd:0,fgcr:0.5,fgcg:0.5,fgcb:0.5,fgca:1,fgde:0.01,fgrn:0,fgrf:300,stcl:False,atwp:False,stva:128,stmr:255,stmw:255,stcp:6,stps:0,stfa:0,stfz:0,ofsf:0,ofsu:0,f2p0:False,fnsp:False,fnfb:True,fsmp:False;n:type:ShaderForge.SFN_Final,id:2865,x:37280,y:31168,varname:node_2865,prsc:2|custl-4246-OUT,clip-1773-OUT;n:type:ShaderForge.SFN_Color,id:6665,x:32826,y:31887,ptovrint:False,ptlb:Color,ptin:_Color,varname:_Color,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,c1:0.5,c2:0.5,c3:0.5,c4:1;n:type:ShaderForge.SFN_Tex2d,id:7736,x:32775,y:32360,ptovrint:False,ptlb:MainTex,ptin:_MainTex,varname:_MainTex,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,ntxv:0,isnm:False;n:type:ShaderForge.SFN_Slider,id:5916,x:32780,y:32116,ptovrint:False,ptlb:Cutoff,ptin:_Cutoff,varname:_Cutoff,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,min:0,cur:0.7,max:1;n:type:ShaderForge.SFN_Set,id:3191,x:33366,y:32468,varname:TexAlpha,prsc:2|IN-7068-OUT;n:type:ShaderForge.SFN_Set,id:7766,x:33121,y:32115,varname:Param_Cutoff,prsc:2|IN-5916-OUT;n:type:ShaderForge.SFN_Set,id:4973,x:33103,y:32365,varname:MainTexIN,prsc:2|IN-7736-RGB;n:type:ShaderForge.SFN_Set,id:7375,x:33218,y:31887,varname:Param_Color,prsc:2|IN-5134-OUT;n:type:ShaderForge.SFN_ViewVector,id:161,x:33218,y:31517,varname:node_161,prsc:2;n:type:ShaderForge.SFN_Dot,id:9680,x:33424,y:31580,cmnt:Check if view is opposite the direction of sunlight,varname:node_9680,prsc:2,dt:4|A-161-OUT,B-1900-OUT;n:type:ShaderForge.SFN_Set,id:8421,x:33807,y:31654,cmnt:Darkens the trees when viewed from the back side.,varname:BacksideDarkening,prsc:2|IN-9680-OUT;n:type:ShaderForge.SFN_Multiply,id:5134,x:33039,y:31887,cmnt:Inputting 0.5 will multiply by 1 which has no effect. Less than 0.5 will darken from 0 to 1 and above 0.5 will brighten by multiplying from 1 to 2x.,varname:node_5134,prsc:2|A-6665-RGB,B-4317-OUT;n:type:ShaderForge.SFN_Vector1,id:4317,x:32834,y:31790,varname:node_4317,prsc:2,v1:2;n:type:ShaderForge.SFN_RemapRange,id:1317,x:33618,y:31610,cmnt:Rescales it to 0.7 to 1 multiplied by 0.75 which yields 0.525 to 0.75,varname:node_1317,prsc:2,frmn:-1,frmx:1,tomn:0.525,tomx:0.75|IN-9680-OUT;n:type:ShaderForge.SFN_Set,id:1610,x:33881,y:30827,varname:LightIN,prsc:2|IN-4142-OUT;n:type:ShaderForge.SFN_Vector4Property,id:53,x:32881,y:31147,ptovrint:False,ptlb:_LushLODTreeMainLightDir,ptin:_LushLODTreeMainLightDir,cmnt:The W is set via script in _LushLODTreesManager.cs,varname:node_8259,prsc:2,glob:True,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,v1:0.5,v2:0.5,v3:0.5,v4:1;n:type:ShaderForge.SFN_Color,id:1033,x:32881,y:30851,ptovrint:False,ptlb:LushLODTreeMainLightCol,ptin:_LushLODTreeMainLightCol,cmnt:This works even with lightmaps,varname:node_349,prsc:2,glob:True,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,c1:0.5,c2:0.5,c3:0.5,c4:1;n:type:ShaderForge.SFN_ValueProperty,id:135,x:32881,y:31032,ptovrint:False,ptlb:LushLODTreeMainLightIntensity,ptin:_LushLODTreeMainLightIntensity,cmnt:This works even with lightmaps,varname:node_5384,prsc:2,glob:True,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,v1:1;n:type:ShaderForge.SFN_Set,id:544,x:33150,y:31145,varname:LightDir,prsc:2|IN-53-XYZ;n:type:ShaderForge.SFN_Get,id:1900,x:33218,y:31652,varname:node_1900,prsc:2|IN-544-OUT;n:type:ShaderForge.SFN_Code,id:7068,x:33024,y:32469,varname:node_7068,prsc:2,code:YwBsAGkAcAAoAFQAZQB4AEEAbABwAGgAYQAgAC0AIABDAHUAdABvAGYAZgApADsACgByAGUAdAB1AHIAbgAgAFQAZQB4AEEAbABwAGgAYQA7AA==,output:0,fname:ClipMe,width:247,height:112,input:0,input:0,input_1_label:TexAlpha,input_2_label:Cutoff|A-7736-A,B-5934-OUT;n:type:ShaderForge.SFN_Get,id:5934,x:32772,y:32529,varname:node_5934,prsc:2|IN-7766-OUT;n:type:ShaderForge.SFN_Code,id:1773,x:36304,y:31847,varname:node_1773,prsc:2,code:cgBlAHQAdQByAG4AIABHAGUAdABUAGUAeABBAGwAcABoAGEAVAByAGkAbQBtAGUAZABfAEIATwBUAEgAUABBAFMAUwAoAFQAZQB4AEEAbABwAGgAYQApADsA,output:0,fname:GetTexAlphaTrimmed_Caller,width:371,height:112,input:0,input_1_label:TexAlpha|A-2845-OUT;n:type:ShaderForge.SFN_Get,id:2845,x:36058,y:31849,varname:node_2845,prsc:2|IN-3191-OUT;n:type:ShaderForge.SFN_Multiply,id:4142,x:33648,y:30827,varname:node_4142,prsc:2|A-1033-RGB,B-9780-OUT;n:type:ShaderForge.SFN_Divide,id:9780,x:33380,y:30926,varname:node_9780,prsc:2|A-135-OUT,B-6315-OUT;n:type:ShaderForge.SFN_Vector1,id:6315,x:33130,y:30895,varname:node_6315,prsc:2,v1:1.2;n:type:ShaderForge.SFN_Multiply,id:3749,x:35136,y:31104,varname:node_3749,prsc:2|A-9421-OUT,B-9863-OUT;n:type:ShaderForge.SFN_Get,id:9863,x:34766,y:31259,varname:node_9863,prsc:2|IN-7375-OUT;n:type:ShaderForge.SFN_Get,id:8886,x:35890,y:31481,varname:node_8886,prsc:2|IN-1610-OUT;n:type:ShaderForge.SFN_Get,id:6975,x:34761,y:31619,cmnt:The shadows value,varname:node_6975,prsc:2|IN-8421-OUT;n:type:ShaderForge.SFN_Clamp,id:1094,x:35047,y:31627,cmnt:This lets the user adjust te maximum shadow. A value of 0.5 will limit it to half.,varname:node_1094,prsc:2|IN-6975-OUT,MIN-4892-OUT,MAX-5903-OUT;n:type:ShaderForge.SFN_Vector1,id:5903,x:34761,y:31715,varname:node_5903,prsc:2,v1:1;n:type:ShaderForge.SFN_ValueProperty,id:5709,x:34640,y:31826,ptovrint:False,ptlb:_LushLODTreeShadowDarkness,ptin:_LushLODTreeShadowDarkness,cmnt:_LusLODSadowDarkness... this is cotrolled by the manager in its Update function,varname:node_2612,prsc:2,glob:True,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,v1:1;n:type:ShaderForge.SFN_OneMinus,id:4892,x:34839,y:31826,varname:node_4892,prsc:2|IN-5709-OUT;n:type:ShaderForge.SFN_Multiply,id:9407,x:36217,y:31257,cmnt:Darkens the ambient by up to 20 when not being viewed on the sunny side.,varname:node_9407,prsc:2|A-5470-RGB,B-6162-OUT;n:type:ShaderForge.SFN_Multiply,id:4246,x:36906,y:31129,varname:node_4246,prsc:2|A-3749-OUT,B-8122-OUT;n:type:ShaderForge.SFN_Vector1,id:1176,x:35031,y:31259,varname:node_1176,prsc:2,v1:0.8;n:type:ShaderForge.SFN_Multiply,id:9829,x:36103,y:31510,varname:node_9829,prsc:2|A-8886-OUT,B-1094-OUT;n:type:ShaderForge.SFN_Add,id:8122,x:36494,y:31349,varname:node_8122,prsc:2|A-9407-OUT,B-9829-OUT;n:type:ShaderForge.SFN_Clamp01,id:6162,x:35944,y:31270,varname:node_6162,prsc:2|IN-584-OUT;n:type:ShaderForge.SFN_Add,id:584,x:35725,y:31270,varname:node_584,prsc:2|A-1176-OUT,B-450-OUT;n:type:ShaderForge.SFN_Subtract,id:9067,x:35297,y:31440,cmnt:This begins to remove the darkening of the ambient when we are more than 80 percent viewing the tree from the sunny side.,varname:node_9067,prsc:2|A-1094-OUT,B-1176-OUT;n:type:ShaderForge.SFN_Clamp01,id:450,x:35499,y:31440,varname:node_450,prsc:2|IN-9067-OUT;n:type:ShaderForge.SFN_Code,id:1050,x:35365,y:30955,varname:node_1050,prsc:2,code:LwAvAFQAaABlACAAYwBvAGQAZQAgAGgAZQByAGUAIABoAGEAbgBkAGwAZQBzACAAdABoAGUAIABhAG0AYgBpAGUAbgB0ACAAbABpAGcAaAB0ACAAYQBuAGQAIABzAGgAYQBkAG8AdwBzAC4ACgAvAC8ASQBUACAASQBTACAATgBPAFQAIABUAEgARQAgAFMAQQBNAEUAIABhAHMAIABmAG8AdQBuAGQAIABpAG4AIAB0AGgAZQAgAG8AdABoAGUAcgAgAGgAaQBnAGUAcgAgAHEAdQBhAGkAdAB5ACAAbABlAHYAZQBsAHMALgAKAC8ALwBJACAAZABpAGQAIABhACAAcwBvAG0AZQB3AGgAYQB0ACAAcgBlAGQAdQBjAGUAZAAgAHYAZQByAHMAaQBvAG4AIABoAGUAcgBlACAAdwBoAGkAYwBoACAAdQBzAGUAcwAgAGYAZQB3AGUAcgAKAC8ALwBtAHUAbAB0AGkAcABsAGkAYwBhAHQAaQBvAG4AcwAgAGEAbgBkACAAbgBvACAAbABlAHIAcABzACAAYQB0ACAAYQBsAGwALgAgAFQAaABhAHQAJwBzACAAYgBlAGMAYQB1AHMAZQAgAHQAaABpAHMAIABpAHMAIAAKAC8ALwB0AGgAZQAgAGwAbwB3AGUAcwB0ACAAcQB1AGEAbABpAHQAeQAgAHMAaABhAGQAZQByACwAIABzAG8AIABJACAAdAByAGkAZQBkACAAdABvACAAbQBhAGsAZQAgAGkAdAAgAGYAYQBzAHQAIABoAGUAcgBlAC4ACgAvAC8AUwBvACAAZABvAG4AJwB0ACAAZQB4AHAAZQBjAHQAIAB0AGgAaQBzACAAcwBoAGEAZABlAHIAIAB0AG8AIABoAGEAbgBkAGwAZQAgAHQAaABlACAAYQBtAGIAaQBlAG4AdAAgAGwAaQBnAGgAdAAKAC8ALwBlAHgAYQBjAHQAbAB5ACAAdABoAGUAIABzAGEAbQBlACAAYQBzACAAdABoAGUAIABvAHQAaABlAHIAIABzAGEAZABlAHIAcwAsACAAYgBlAGMAYQB1AHMAZQAgAGkAdAAgAHcAbwBuACcAdAAuAA==,output:2,fname:Read_Me_23957205,width:478,height:280;n:type:ShaderForge.SFN_Get,id:9421,x:34682,y:31054,varname:node_9421,prsc:2|IN-4973-OUT;n:type:ShaderForge.SFN_Color,id:5470,x:35944,y:31145,ptovrint:False,ptlb:_LushLODTreeAmbientColor,ptin:_LushLODTreeAmbientColor,cmnt:_LushLODTreeAmbientColor... this value is set in the manager,varname:_LushLODTreeAmbientColor_copy,prsc:2,glob:True,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,c1:0.5,c2:0.5,c3:0.5,c4:1;proporder:6665-5916-7736;pass:END;sub:END;*/

Shader "Hidden/LushLODTree/Tree_Leaves_Far4.b" {
    Properties {
        _Color ("Color", Color) = (0.5,0.5,0.5,1)
        _Cutoff ("Cutoff", Range(0, 1)) = 0.7
        _MainTex ("MainTex", 2D) = "white" {}
        [HideInInspector]_Cutoff ("Alpha cutoff", Range(0,1)) = 0.5
    }
    SubShader {
        Tags {
            "Queue"="AlphaTest+51"
            "RenderType"="TransparentCutout"
            "CanUseSpriteAtlas"="True"
        }
        Pass {
            Name "FORWARD"
            Tags {
                "LightMode"="ForwardBase"
            }
            Cull Off
            
            
            CGPROGRAM
            #pragma vertex vert
            #pragma fragment frag
			#ifndef UNITY_PASS_FORWARDBASE //<-- fixes really weird bug.
			#define UNITY_PASS_FORWARDBASE
			#endif
            #include "UnityCG.cginc"
            #include "CGIncludes/Dithering.cginc"
            #pragma multi_compile_fwdbase_fullshadows
            #pragma multi_compile_fog
            #pragma target 3.0
            uniform float4 _Color;
            uniform sampler2D _MainTex; uniform float4 _MainTex_ST;
            uniform float _Cutoff;
            uniform float4 _LushLODTreeMainLightDir;
            uniform float4 _LushLODTreeMainLightCol;
            uniform float _LushLODTreeMainLightIntensity;
            float ClipMe( float TexAlpha , float Cutoff ){
            clip(TexAlpha - Cutoff);
            return TexAlpha;
            }
            
            float GetTexAlphaTrimmed_Caller( float TexAlpha ){
            return GetTexAlphaTrimmed_BOTHPASS(TexAlpha);
            }
            
            uniform float _LushLODTreeShadowDarkness;
            uniform float4 _LushLODTreeAmbientColor;
            struct VertexInput {
                float4 vertex : POSITION;
                float2 texcoord0 : TEXCOORD0;
            };
            struct VertexOutput {
                float4 pos : SV_POSITION;
                float2 uv0 : TEXCOORD0;
                float4 posWorld : TEXCOORD1;
                UNITY_FOG_COORDS(2)
            };
            VertexOutput vert (VertexInput v) {
                VertexOutput o = (VertexOutput)0;
                o.uv0 = v.texcoord0;
                o.posWorld = mul(unity_ObjectToWorld, v.vertex);
                o.pos = UnityObjectToClipPos( v.vertex );
                UNITY_TRANSFER_FOG(o,o.pos);
                return o;
            }
            float4 frag(VertexOutput i, float facing : VFACE) : COLOR {
                float isFrontFace = ( facing >= 0 ? 1 : 0 );
                float faceSign = ( facing >= 0 ? 1 : -1 );
                float3 viewDirection = normalize(_WorldSpaceCameraPos.xyz - i.posWorld.xyz);
                float4 _MainTex_var = tex2D(_MainTex,TRANSFORM_TEX(i.uv0, _MainTex));
                float Param_Cutoff = _Cutoff;
                float TexAlpha = ClipMe( _MainTex_var.a , Param_Cutoff );
                clip(GetTexAlphaTrimmed_Caller( TexAlpha ) - 0.5);
////// Lighting:
                float3 MainTexIN = _MainTex_var.rgb;
                float3 Param_Color = (_Color.rgb*2.0);
                float node_1176 = 0.8;
                float3 LightDir = _LushLODTreeMainLightDir.rgb;
                float node_9680 = 0.5*dot(viewDirection,LightDir)+0.5; // Check if view is opposite the direction of sunlight
                float BacksideDarkening = node_9680; // Darkens the trees when viewed from the back side.
                float node_1094 = clamp(BacksideDarkening,(1.0 - _LushLODTreeShadowDarkness),1.0); // This lets the user adjust te maximum shadow. A value of 0.5 will limit it to half.
                float3 LightIN = (_LushLODTreeMainLightCol.rgb*(_LushLODTreeMainLightIntensity/1.2));
                float3 finalColor = ((MainTexIN*Param_Color)*((_LushLODTreeAmbientColor.rgb*saturate((node_1176+saturate((node_1094-node_1176)))))+(LightIN*node_1094)));
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
            Cull Off
            
            CGPROGRAM
            #pragma vertex vert
            #pragma fragment frag
			#ifndef UNITY_PASS_SHADOWCASTER //<-- fixes really weird bug.
            #define UNITY_PASS_SHADOWCASTER
			#endif
            #include "UnityCG.cginc"
            #include "Lighting.cginc"
            #include "CGIncludes/Dithering.cginc"
            #pragma fragmentoption ARB_precision_hint_fastest
            #pragma multi_compile_shadowcaster
            #pragma multi_compile_fog
            #pragma target 3.0
            uniform sampler2D _MainTex; uniform float4 _MainTex_ST;
            uniform float _Cutoff;
            float ClipMe( float TexAlpha , float Cutoff ){
            clip(TexAlpha - Cutoff);
            return TexAlpha;
            }
            
            float GetTexAlphaTrimmed_Caller( float TexAlpha ){
            return GetTexAlphaTrimmed_BOTHPASS(TexAlpha);
            }
            
            struct VertexInput {
                float4 vertex : POSITION;
                float2 texcoord0 : TEXCOORD0;
            };
            struct VertexOutput {
                V2F_SHADOW_CASTER;
                float2 uv0 : TEXCOORD1;
            };
            VertexOutput vert (VertexInput v) {
                VertexOutput o = (VertexOutput)0;
                o.uv0 = v.texcoord0;
                o.pos = UnityObjectToClipPos( v.vertex );
                TRANSFER_SHADOW_CASTER(o)
                return o;
            }
            float4 frag(VertexOutput i, float facing : VFACE) : COLOR {
                float isFrontFace = ( facing >= 0 ? 1 : 0 );
                float faceSign = ( facing >= 0 ? 1 : -1 );
                float4 _MainTex_var = tex2D(_MainTex,TRANSFORM_TEX(i.uv0, _MainTex));
                float Param_Cutoff = _Cutoff;
                float TexAlpha = ClipMe( _MainTex_var.a , Param_Cutoff );
                clip(GetTexAlphaTrimmed_Caller( TexAlpha ) - 0.5);
                SHADOW_CASTER_FRAGMENT(i)
            }
            ENDCG
        }
    }
    CustomEditor "ShaderForgeMaterialInspector"
}
