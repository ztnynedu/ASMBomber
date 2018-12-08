// Shader created with Shader Forge v1.38 
// Shader Forge (c) Neat Corporation / Joachim Holmer - http://www.acegikmo.com/shaderforge/
// Note: Manually altering this data may prevent you from opening it in Shader Forge
/*SF_DATA;ver:1.38;sub:START;pass:START;ps:flbk:,iptp:0,cusa:True,bamd:0,cgin:QwBHAEkAbgBjAGwAdQBkAGUAcwAvAEQAaQB0AGgAZQByAGkAbgBnAA==,lico:0,lgpr:1,limd:3,spmd:1,trmd:0,grmd:0,uamb:True,mssp:True,bkdf:False,hqlp:False,rprd:False,enco:False,rmgx:True,imps:True,rpth:1,vtps:0,hqsc:True,nrmq:1,nrsp:0,vomd:0,spxs:False,tesm:0,olmd:1,culm:2,bsrc:0,bdst:1,dpts:2,wrdp:True,dith:0,atcv:False,rfrpo:False,rfrpn:Refraction,coma:15,ufog:True,aust:True,igpj:False,qofs:0,qpre:2,rntp:3,fgom:False,fgoc:False,fgod:False,fgor:False,fgmd:0,fgcr:0.5,fgcg:0.5,fgcb:0.5,fgca:1,fgde:0.01,fgrn:0,fgrf:300,stcl:False,atwp:False,stva:128,stmr:255,stmw:255,stcp:6,stps:0,stfa:0,stfz:0,ofsf:0,ofsu:0,f2p0:False,fnsp:False,fnfb:True,fsmp:False;n:type:ShaderForge.SFN_Final,id:2865,x:36467,y:31878,varname:node_2865,prsc:2|emission-1632-OUT,clip-7653-OUT;n:type:ShaderForge.SFN_Color,id:6665,x:31738,y:31926,ptovrint:False,ptlb:Color,ptin:_Color,varname:_Color,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,c1:0.5019608,c2:0.5019608,c3:0.5019608,c4:1;n:type:ShaderForge.SFN_Tex2d,id:7736,x:32683,y:31634,ptovrint:False,ptlb:MainTex,ptin:_MainTex,varname:_MainTex,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,ntxv:0,isnm:False;n:type:ShaderForge.SFN_Slider,id:6832,x:31582,y:32333,ptovrint:False,ptlb:Transparency,ptin:_Transparency,varname:_Transparency,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,min:0,cur:1,max:1;n:type:ShaderForge.SFN_Slider,id:5916,x:31594,y:32233,ptovrint:False,ptlb:Cutoff,ptin:_Cutoff,varname:_Cutoff,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,min:0,cur:0.7,max:1;n:type:ShaderForge.SFN_Slider,id:1495,x:31594,y:32106,ptovrint:False,ptlb:ShadowTransparency,ptin:_ShadowTransparency,varname:_ShadowTransparency,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,min:0,cur:0,max:1;n:type:ShaderForge.SFN_Set,id:3191,x:33372,y:31874,varname:TexAlpha,prsc:2|IN-7381-OUT;n:type:ShaderForge.SFN_Set,id:8286,x:31935,y:32348,varname:Param_Transparency_MAINPASS,prsc:2|IN-6832-OUT;n:type:ShaderForge.SFN_Set,id:7766,x:31935,y:32232,varname:Param_Cutoff,prsc:2|IN-5916-OUT;n:type:ShaderForge.SFN_Set,id:7143,x:31935,y:32109,varname:Param_ShadowTrans_SHADOWPASS,prsc:2|IN-1495-OUT;n:type:ShaderForge.SFN_Set,id:47,x:31373,y:32661,varname:DITHER_SHADOWPASS,prsc:2|IN-2799-OUT;n:type:ShaderForge.SFN_Set,id:7375,x:32120,y:31952,varname:Param_Color,prsc:2|IN-1526-OUT;n:type:ShaderForge.SFN_ViewVector,id:5913,x:29946,y:32209,varname:node_5913,prsc:2;n:type:ShaderForge.SFN_Dot,id:4719,x:30152,y:32272,cmnt:Check if view is opposite the direction of sunlight,varname:node_4719,prsc:2,dt:4|A-5913-OUT,B-4631-OUT;n:type:ShaderForge.SFN_Set,id:3529,x:30574,y:32366,cmnt:Darkens the trees when viewed from the back side,varname:Backside_Darkening,prsc:2|IN-4719-OUT;n:type:ShaderForge.SFN_Multiply,id:1526,x:31935,y:31926,cmnt:Inputting 0.5 will multiply by 1 which has no effect. Less than 0.5 will darken from 0 to 1 and above 0.5 will brighten by multiplying from 1 to 2x.,varname:node_1526,prsc:2|A-6665-RGB,B-3750-OUT;n:type:ShaderForge.SFN_Vector1,id:3750,x:31752,y:31829,varname:node_3750,prsc:2,v1:2;n:type:ShaderForge.SFN_RemapRange,id:2519,x:30364,y:32325,cmnt:Rescales it to 0.7 to 1 multiplied by 0.75 which yields 0.525 to 0.75,varname:node_2519,prsc:2,frmn:-1,frmx:1,tomn:0.525,tomx:0.75|IN-4719-OUT;n:type:ShaderForge.SFN_Set,id:8949,x:31485,y:31605,varname:LightIN,prsc:2|IN-2927-OUT;n:type:ShaderForge.SFN_Vector4Property,id:4553,x:30522,y:31878,ptovrint:False,ptlb:_LushLODTreeMainLightDir,ptin:_LushLODTreeMainLightDir,cmnt:The W is set via script in _LushLODTreesManager.cs,varname:node_8259,prsc:2,glob:True,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,v1:0.5,v2:0.5,v3:0.5,v4:1;n:type:ShaderForge.SFN_Color,id:7646,x:30522,y:31582,ptovrint:False,ptlb:LushLODTreeMainLightCol,ptin:_LushLODTreeMainLightCol,cmnt:This works even with lightmaps,varname:node_349,prsc:2,glob:True,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,c1:0.5,c2:0.5,c3:0.5,c4:1;n:type:ShaderForge.SFN_ValueProperty,id:117,x:30522,y:31763,ptovrint:False,ptlb:LushLODTreeMainLightIntensity,ptin:_LushLODTreeMainLightIntensity,cmnt:This works even with lightmaps,varname:node_5384,prsc:2,glob:True,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,v1:1;n:type:ShaderForge.SFN_Set,id:1300,x:30832,y:31900,varname:LightDir,prsc:2|IN-4553-XYZ;n:type:ShaderForge.SFN_Get,id:4631,x:29925,y:32359,varname:node_4631,prsc:2|IN-1300-OUT;n:type:ShaderForge.SFN_Code,id:7381,x:33029,y:31765,varname:node_7381,prsc:2,code:YwBsAGkAcAAoAFQAZQB4AEEAbABwAGgAYQAgAC0AIABDAHUAdABvAGYAZgApADsACgByAGUAdAB1AHIAbgAgAFQAZQB4AEEAbABwAGgAYQA7AA==,output:0,fname:ClipMe,width:247,height:112,input:0,input:0,input_1_label:TexAlpha,input_2_label:Cutoff|A-7736-A,B-1262-OUT;n:type:ShaderForge.SFN_Get,id:1262,x:32762,y:31854,varname:node_1262,prsc:2|IN-7766-OUT;n:type:ShaderForge.SFN_TexCoord,id:2469,x:30516,y:32590,varname:node_2469,prsc:2,uv:0,uaff:False;n:type:ShaderForge.SFN_Code,id:2799,x:30814,y:32654,varname:node_2799,prsc:2,code:cgBlAHQAdQByAG4AIABHAGUAdABEAGkAdABoAGUAcgBTAGgAYQBkAG8AdwBzAF8AQgBPAFQASABQAEEAUwBTACgAVQBWADAAXwBJAE4ALAAgAFQAcgBhAG4AcwBwAGEAcgBlAG4AYwB5ACkAOwA=,output:0,fname:GetDitherShadows_Caller,width:453,height:128,input:1,input:0,input_1_label:UV0_IN,input_2_label:Transparency|A-2469-UVOUT,B-3847-OUT;n:type:ShaderForge.SFN_Get,id:3847,x:30495,y:32734,varname:node_3847,prsc:2|IN-7143-OUT;n:type:ShaderForge.SFN_Get,id:1146,x:35816,y:32534,varname:node_1146,prsc:2|IN-47-OUT;n:type:ShaderForge.SFN_Get,id:1565,x:35816,y:32474,cmnt:Attaching this forces ClipME to run in both passes,varname:node_1565,prsc:2|IN-3191-OUT;n:type:ShaderForge.SFN_Min,id:7653,x:36041,y:32474,varname:node_7653,prsc:2|A-1565-OUT,B-1146-OUT;n:type:ShaderForge.SFN_Multiply,id:2927,x:31253,y:31593,varname:node_2927,prsc:2|A-7646-RGB,B-4044-OUT;n:type:ShaderForge.SFN_Multiply,id:997,x:34160,y:31826,varname:node_997,prsc:2|A-7736-RGB,B-928-OUT;n:type:ShaderForge.SFN_Get,id:928,x:33790,y:32011,varname:node_928,prsc:2|IN-7375-OUT;n:type:ShaderForge.SFN_Get,id:5777,x:34914,y:32233,varname:node_5777,prsc:2|IN-8949-OUT;n:type:ShaderForge.SFN_Get,id:9722,x:33785,y:32371,cmnt:The shadows value,varname:node_9722,prsc:2|IN-3529-OUT;n:type:ShaderForge.SFN_Clamp,id:5581,x:34071,y:32379,cmnt:This lets the user adjust te maximum shadow. A value of 0.5 will limit it to half.,varname:node_5581,prsc:2|IN-9722-OUT,MIN-9677-OUT,MAX-3474-OUT;n:type:ShaderForge.SFN_Vector1,id:3474,x:33785,y:32467,varname:node_3474,prsc:2,v1:1;n:type:ShaderForge.SFN_ValueProperty,id:1579,x:33664,y:32578,ptovrint:False,ptlb:_LushLODTreeShadowDarkness,ptin:_LushLODTreeShadowDarkness,cmnt:_LusLODSadowDarkness... this is cotrolled by the manager in its Update function,varname:node_2612,prsc:2,glob:True,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,v1:1;n:type:ShaderForge.SFN_OneMinus,id:9677,x:33863,y:32578,varname:node_9677,prsc:2|IN-1579-OUT;n:type:ShaderForge.SFN_Multiply,id:5022,x:35241,y:32009,cmnt:Darkens the ambient by up to 20 when not being viewed on the sunny side.,varname:node_5022,prsc:2|A-3607-RGB,B-7049-OUT;n:type:ShaderForge.SFN_Multiply,id:1632,x:35947,y:31876,varname:node_1632,prsc:2|A-997-OUT,B-7379-OUT;n:type:ShaderForge.SFN_Vector1,id:6065,x:34055,y:32011,varname:node_6065,prsc:2,v1:0.8;n:type:ShaderForge.SFN_Multiply,id:1785,x:35127,y:32262,varname:node_1785,prsc:2|A-5777-OUT,B-5581-OUT;n:type:ShaderForge.SFN_Add,id:7379,x:35518,y:32101,varname:node_7379,prsc:2|A-5022-OUT,B-1785-OUT;n:type:ShaderForge.SFN_Clamp01,id:7049,x:34968,y:32022,varname:node_7049,prsc:2|IN-6444-OUT;n:type:ShaderForge.SFN_Add,id:6444,x:34749,y:32022,varname:node_6444,prsc:2|A-6065-OUT,B-7211-OUT;n:type:ShaderForge.SFN_Subtract,id:8094,x:34321,y:32192,cmnt:This begins to remove the darkening of the ambient when we are more than 80 percent viewing the tree from the sunny side.,varname:node_8094,prsc:2|A-5581-OUT,B-6065-OUT;n:type:ShaderForge.SFN_Clamp01,id:7211,x:34523,y:32192,varname:node_7211,prsc:2|IN-8094-OUT;n:type:ShaderForge.SFN_Code,id:4650,x:34384,y:31667,varname:node_4650,prsc:2,code:LwAvAFQAaABlACAAYwBvAGQAZQAgAGgAZQByAGUAIABoAGEAbgBkAGwAZQBzACAAdABoAGUAIABhAG0AYgBpAGUAbgB0ACAAbABpAGcAaAB0ACAAYQBuAGQAIABzAGgAYQBkAG8AdwBzAC4ACgAvAC8ASQBUACAASQBTACAATgBPAFQAIABUAEgARQAgAFMAQQBNAEUAIABhAHMAIABmAG8AdQBuAGQAIABpAG4AIAB0AGgAZQAgAG8AdABoAGUAcgAgAGgAaQBnAGUAcgAgAHEAdQBhAGkAdAB5ACAAbABlAHYAZQBsAHMALgAKAC8ALwBJACAAZABpAGQAIABhACAAcwBvAG0AZQB3AGgAYQB0ACAAcgBlAGQAdQBjAGUAZAAgAHYAZQByAHMAaQBvAG4AIABoAGUAcgBlACAAdwBoAGkAYwBoACAAdQBzAGUAcwAgAGYAZQB3AGUAcgAKAC8ALwBtAHUAbAB0AGkAcABsAGkAYwBhAHQAaQBvAG4AcwAgAGEAbgBkACAAbgBvACAAbABlAHIAcABzACAAYQB0ACAAYQBsAGwALgAgAFQAaABhAHQAJwBzACAAYgBlAGMAYQB1AHMAZQAgAHQAaABpAHMAIABpAHMAIAAKAC8ALwB0AGgAZQAgAGwAbwB3AGUAcwB0ACAAcQB1AGEAbABpAHQAeQAgAHMAaABhAGQAZQByACwAIABzAG8AIABJACAAdAByAGkAZQBkACAAdABvACAAbQBhAGsAZQAgAGkAdAAgAGYAYQBzAHQAIABoAGUAcgBlAC4ACgAvAC8AUwBvACAAZABvAG4AJwB0ACAAZQB4AHAAZQBjAHQAIAB0AGgAaQBzACAAcwBoAGEAZABlAHIAIAB0AG8AIABoAGEAbgBkAGwAZQAgAHQAaABlACAAYQBtAGIAaQBlAG4AdAAgAGwAaQBnAGgAdAAKAC8ALwBlAHgAYQBjAHQAbAB5ACAAdABoAGUAIABzAGEAbQBlACAAYQBzACAAdABoAGUAIABvAHQAaABlAHIAIABzAGEAZABlAHIAcwAsACAAYgBlAGMAYQB1AHMAZQAgAGkAdAAgAHcAbwBuACcAdAAuAA==,output:2,fname:Read_Me_23957205,width:478,height:280;n:type:ShaderForge.SFN_Divide,id:4044,x:30958,y:31665,varname:node_4044,prsc:2|A-117-OUT,B-6252-OUT;n:type:ShaderForge.SFN_Vector1,id:6252,x:30699,y:31637,varname:node_6252,prsc:2,v1:1.2;n:type:ShaderForge.SFN_Color,id:3607,x:34968,y:31882,ptovrint:False,ptlb:_LushLODTreeAmbientColor,ptin:_LushLODTreeAmbientColor,cmnt:_LushLODTreeAmbientColor... this value is set in the manager,varname:_LushLODTreeAmbientColor_copy,prsc:2,glob:True,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,c1:0.5,c2:0.5,c3:0.5,c4:1;proporder:6665-6832-5916-1495-7736;pass:END;sub:END;*/

Shader "Hidden/LushLODTree/Tree_Leaves4_Deferred" {
    Properties {
        _Color ("Color", Color) = (0.5019608,0.5019608,0.5019608,1)
        _Transparency ("Transparency", Range(0, 1)) = 1
        _Cutoff ("Cutoff", Range(0, 1)) = 0.7
        _ShadowTransparency ("ShadowTransparency", Range(0, 1)) = 0
        _MainTex ("MainTex", 2D) = "white" {}
        [HideInInspector]_Cutoff ("Alpha cutoff", Range(0,1)) = 0.5
    }
    SubShader {
        Tags {
            "Queue"="AlphaTest"
            "RenderType"="TransparentCutout"
            "CanUseSpriteAtlas"="True"
        }
        Pass {
            Name "DEFERRED"
            Tags {
                "LightMode"="Deferred"
            }
            Cull Off
            
            
            CGPROGRAM
            #pragma vertex vert
            #pragma fragment frag
            #define UNITY_PASS_DEFERRED
            #include "UnityCG.cginc"
            #include "UnityPBSLighting.cginc"
            #include "UnityStandardBRDF.cginc"
            #include "CGIncludes/Dithering.cginc"
            #pragma fragmentoption ARB_precision_hint_fastest
            #pragma multi_compile_shadowcaster
            #pragma multi_compile ___ UNITY_HDR_ON
            #pragma multi_compile_fog
            #pragma target 3.0
            uniform float4 _Color;
            uniform sampler2D _MainTex; uniform float4 _MainTex_ST;
            uniform float _Cutoff;
            uniform float _ShadowTransparency;
            uniform float4 _LushLODTreeMainLightDir;
            uniform float4 _LushLODTreeMainLightCol;
            uniform float _LushLODTreeMainLightIntensity;
            float ClipMe( float TexAlpha , float Cutoff ){
            clip(TexAlpha - Cutoff);
            return TexAlpha;
            }
            
            float GetDitherShadows_Caller( float2 UV0_IN , float Transparency ){
            return GetDitherShadows_BOTHPASS(UV0_IN, Transparency);
            }
            
            uniform float _LushLODTreeShadowDarkness;
            uniform float4 _LushLODTreeAmbientColor;
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
            };
            VertexOutput vert (VertexInput v) {
                VertexOutput o = (VertexOutput)0;
                o.uv0 = v.texcoord0;
                o.normalDir = UnityObjectToWorldNormal(v.normal);
                o.posWorld = mul(unity_ObjectToWorld, v.vertex);
                o.pos = UnityObjectToClipPos( v.vertex );
                return o;
            }
            void frag(
                VertexOutput i,
                out half4 outDiffuse : SV_Target0,
                out half4 outSpecSmoothness : SV_Target1,
                out half4 outNormal : SV_Target2,
                out half4 outEmission : SV_Target3,
                float facing : VFACE )
            {
                float isFrontFace = ( facing >= 0 ? 1 : 0 );
                float faceSign = ( facing >= 0 ? 1 : -1 );
                i.normalDir = normalize(i.normalDir);
                i.normalDir *= faceSign;
                float3 viewDirection = normalize(_WorldSpaceCameraPos.xyz - i.posWorld.xyz);
                float3 normalDirection = i.normalDir;
                float3 viewReflectDirection = reflect( -viewDirection, normalDirection );
                float4 _MainTex_var = tex2D(_MainTex,TRANSFORM_TEX(i.uv0, _MainTex));
                float Param_Cutoff = _Cutoff;
                float TexAlpha = ClipMe( _MainTex_var.a , Param_Cutoff );
                float Param_ShadowTrans_SHADOWPASS = _ShadowTransparency;
                float DITHER_SHADOWPASS = GetDitherShadows_Caller( i.uv0 , Param_ShadowTrans_SHADOWPASS );
                clip(min(TexAlpha,DITHER_SHADOWPASS) - 0.5);
////// Lighting:
////// Emissive:
                float3 Param_Color = (_Color.rgb*2.0);
                float node_6065 = 0.8;
                float3 LightDir = _LushLODTreeMainLightDir.rgb;
                float node_4719 = 0.5*dot(viewDirection,LightDir)+0.5; // Check if view is opposite the direction of sunlight
                float Backside_Darkening = node_4719; // Darkens the trees when viewed from the back side
                float node_5581 = clamp(Backside_Darkening,(1.0 - _LushLODTreeShadowDarkness),1.0); // This lets the user adjust te maximum shadow. A value of 0.5 will limit it to half.
                float3 LightIN = (_LushLODTreeMainLightCol.rgb*(_LushLODTreeMainLightIntensity/1.2));
                float3 emissive = ((_MainTex_var.rgb*Param_Color)*((_LushLODTreeAmbientColor.rgb*saturate((node_6065+saturate((node_5581-node_6065)))))+(LightIN*node_5581)));
                float3 finalColor = emissive;
                outDiffuse = half4( 0, 0, 0, 1 );
                outSpecSmoothness = half4(0,0,0,0);
                outNormal = half4( normalDirection * 0.5 + 0.5, 1 );
                outEmission = half4( ((_MainTex_var.rgb*Param_Color)*((_LushLODTreeAmbientColor.rgb*saturate((node_6065+saturate((node_5581-node_6065)))))+(LightIN*node_5581))), 1 );
                #ifndef UNITY_HDR_ON
                    outEmission.rgb = exp2(-outEmission.rgb);
                #endif
            }
            ENDCG
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
            #define UNITY_PASS_FORWARDBASE
            #include "UnityCG.cginc"
            #include "UnityPBSLighting.cginc"
            #include "UnityStandardBRDF.cginc"
            #include "CGIncludes/Dithering.cginc"
            #pragma multi_compile_fwdbase_fullshadows
            #pragma multi_compile_fog
            #pragma target 3.0
            uniform float4 _Color;
            uniform sampler2D _MainTex; uniform float4 _MainTex_ST;
            uniform float _Cutoff;
            uniform float _ShadowTransparency;
            uniform float4 _LushLODTreeMainLightDir;
            uniform float4 _LushLODTreeMainLightCol;
            uniform float _LushLODTreeMainLightIntensity;
            float ClipMe( float TexAlpha , float Cutoff ){
            clip(TexAlpha - Cutoff);
            return TexAlpha;
            }
            
            float GetDitherShadows_Caller( float2 UV0_IN , float Transparency ){
            return GetDitherShadows_BOTHPASS(UV0_IN, Transparency);
            }
            
            uniform float _LushLODTreeShadowDarkness;
            uniform float4 _LushLODTreeAmbientColor;
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
                UNITY_FOG_COORDS(3)
            };
            VertexOutput vert (VertexInput v) {
                VertexOutput o = (VertexOutput)0;
                o.uv0 = v.texcoord0;
                o.normalDir = UnityObjectToWorldNormal(v.normal);
                o.posWorld = mul(unity_ObjectToWorld, v.vertex);
                o.pos = UnityObjectToClipPos( v.vertex );
                UNITY_TRANSFER_FOG(o,o.pos);
                return o;
            }
            float4 frag(VertexOutput i, float facing : VFACE) : COLOR {
                float isFrontFace = ( facing >= 0 ? 1 : 0 );
                float faceSign = ( facing >= 0 ? 1 : -1 );
                i.normalDir = normalize(i.normalDir);
                i.normalDir *= faceSign;
                float3 viewDirection = normalize(_WorldSpaceCameraPos.xyz - i.posWorld.xyz);
                float3 normalDirection = i.normalDir;
                float3 viewReflectDirection = reflect( -viewDirection, normalDirection );
                float4 _MainTex_var = tex2D(_MainTex,TRANSFORM_TEX(i.uv0, _MainTex));
                float Param_Cutoff = _Cutoff;
                float TexAlpha = ClipMe( _MainTex_var.a , Param_Cutoff );
                float Param_ShadowTrans_SHADOWPASS = _ShadowTransparency;
                float DITHER_SHADOWPASS = GetDitherShadows_Caller( i.uv0 , Param_ShadowTrans_SHADOWPASS );
                clip(min(TexAlpha,DITHER_SHADOWPASS) - 0.5);
////// Lighting:
////// Emissive:
                float3 Param_Color = (_Color.rgb*2.0);
                float node_6065 = 0.8;
                float3 LightDir = _LushLODTreeMainLightDir.rgb;
                float node_4719 = 0.5*dot(viewDirection,LightDir)+0.5; // Check if view is opposite the direction of sunlight
                float Backside_Darkening = node_4719; // Darkens the trees when viewed from the back side
                float node_5581 = clamp(Backside_Darkening,(1.0 - _LushLODTreeShadowDarkness),1.0); // This lets the user adjust te maximum shadow. A value of 0.5 will limit it to half.
                float3 LightIN = (_LushLODTreeMainLightCol.rgb*(_LushLODTreeMainLightIntensity/1.2));
                float3 emissive = ((_MainTex_var.rgb*Param_Color)*((_LushLODTreeAmbientColor.rgb*saturate((node_6065+saturate((node_5581-node_6065)))))+(LightIN*node_5581)));
                float3 finalColor = emissive;
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
            #define UNITY_PASS_SHADOWCASTER
            #include "UnityCG.cginc"
            #include "Lighting.cginc"
            #include "UnityPBSLighting.cginc"
            #include "UnityStandardBRDF.cginc"
            #include "CGIncludes/Dithering.cginc"
            #pragma fragmentoption ARB_precision_hint_fastest
            #pragma multi_compile_shadowcaster
            #pragma multi_compile_fog
            #pragma target 3.0
            uniform sampler2D _MainTex; uniform float4 _MainTex_ST;
            uniform float _Cutoff;
            uniform float _ShadowTransparency;
            float ClipMe( float TexAlpha , float Cutoff ){
            clip(TexAlpha - Cutoff);
            return TexAlpha;
            }
            
            float GetDitherShadows_Caller( float2 UV0_IN , float Transparency ){
            return GetDitherShadows_BOTHPASS(UV0_IN, Transparency);
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
                float Param_ShadowTrans_SHADOWPASS = _ShadowTransparency;
                float DITHER_SHADOWPASS = GetDitherShadows_Caller( i.uv0 , Param_ShadowTrans_SHADOWPASS );
                clip(min(TexAlpha,DITHER_SHADOWPASS) - 0.5);
                SHADOW_CASTER_FRAGMENT(i)
            }
            ENDCG
        }
    }
    CustomEditor "ShaderForgeMaterialInspector"
}
