// Shader created with Shader Forge v1.38 
// Shader Forge (c) Neat Corporation / Joachim Holmer - http://www.acegikmo.com/shaderforge/
// Note: Manually altering this data may prevent you from opening it in Shader Forge
/*SF_DATA;ver:1.38;sub:START;pass:START;ps:flbk:,iptp:0,cusa:True,bamd:0,cgin:QwBHAEkAbgBjAGwAdQBkAGUAcwAvAEQAaQB0AGgAZQByAGkAbgBnAA==,lico:0,lgpr:1,limd:0,spmd:1,trmd:0,grmd:0,uamb:True,mssp:True,bkdf:False,hqlp:False,rprd:False,enco:False,rmgx:True,imps:True,rpth:0,vtps:0,hqsc:True,nrmq:1,nrsp:0,vomd:0,spxs:False,tesm:0,olmd:1,culm:2,bsrc:0,bdst:1,dpts:2,wrdp:True,dith:0,atcv:False,rfrpo:False,rfrpn:Refraction,coma:15,ufog:True,aust:False,igpj:False,qofs:51,qpre:2,rntp:3,fgom:False,fgoc:False,fgod:False,fgor:False,fgmd:0,fgcr:0.5,fgcg:0.5,fgcb:0.5,fgca:1,fgde:0.01,fgrn:0,fgrf:300,stcl:False,atwp:False,stva:128,stmr:255,stmw:255,stcp:6,stps:0,stfa:0,stfz:0,ofsf:0,ofsu:0,f2p0:False,fnsp:False,fnfb:True,fsmp:False;n:type:ShaderForge.SFN_Final,id:2865,x:36168,y:31730,varname:node_2865,prsc:2|custl-5199-OUT,clip-7451-OUT;n:type:ShaderForge.SFN_Color,id:6665,x:31738,y:31926,ptovrint:False,ptlb:Color,ptin:_Color,varname:_Color,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,c1:0.5019608,c2:0.5019608,c3:0.5019608,c4:1;n:type:ShaderForge.SFN_Tex2d,id:7736,x:32324,y:31352,ptovrint:False,ptlb:MainTex,ptin:_MainTex,varname:_MainTex,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,ntxv:0,isnm:False;n:type:ShaderForge.SFN_Slider,id:6832,x:31582,y:32333,ptovrint:False,ptlb:Transparency,ptin:_Transparency,varname:_Transparency,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,min:0,cur:1,max:1;n:type:ShaderForge.SFN_Slider,id:5916,x:31594,y:32233,ptovrint:False,ptlb:Cutoff,ptin:_Cutoff,varname:_Cutoff,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,min:0,cur:0.7,max:1;n:type:ShaderForge.SFN_Slider,id:1495,x:31594,y:32106,ptovrint:False,ptlb:ShadowTransparency,ptin:_ShadowTransparency,varname:_ShadowTransparency,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,min:0,cur:0,max:1;n:type:ShaderForge.SFN_Set,id:3191,x:32913,y:31553,varname:TexAlpha,prsc:2|IN-3025-OUT;n:type:ShaderForge.SFN_Set,id:8286,x:31935,y:32348,varname:Param_Transparency_MAINPASS,prsc:2|IN-6832-OUT;n:type:ShaderForge.SFN_Set,id:7766,x:31935,y:32232,varname:Param_Cutoff,prsc:2|IN-5916-OUT;n:type:ShaderForge.SFN_Set,id:7143,x:31935,y:32109,varname:Param_ShadowTrans_SHADOWPASS,prsc:2|IN-1495-OUT;n:type:ShaderForge.SFN_Set,id:47,x:31387,y:32677,varname:DITHER_SHADOWPASS,prsc:2|IN-2845-OUT;n:type:ShaderForge.SFN_Set,id:7375,x:32120,y:31952,varname:Param_Color,prsc:2|IN-1526-OUT;n:type:ShaderForge.SFN_ViewVector,id:5913,x:29946,y:32209,varname:node_5913,prsc:2;n:type:ShaderForge.SFN_Dot,id:4719,x:30152,y:32272,cmnt:Check if view is opposite the direction of sunlight,varname:node_4719,prsc:2,dt:4|A-5913-OUT,B-4631-OUT;n:type:ShaderForge.SFN_Set,id:3529,x:30574,y:32366,cmnt:Darkens the trees when viewed from the back side,varname:Backside_Darkening,prsc:2|IN-4719-OUT;n:type:ShaderForge.SFN_Multiply,id:1526,x:31935,y:31926,cmnt:Inputting 0.5 will multiply by 1 which has no effect. Less than 0.5 will darken from 0 to 1 and above 0.5 will brighten by multiplying from 1 to 2x.,varname:node_1526,prsc:2|A-6665-RGB,B-3750-OUT;n:type:ShaderForge.SFN_Vector1,id:3750,x:31752,y:31829,varname:node_3750,prsc:2,v1:2;n:type:ShaderForge.SFN_RemapRange,id:2519,x:30371,y:32324,cmnt:Rescales it to 0.7 to 1 multiplied by 0.75 which yields 0.525 to 0.75,varname:node_2519,prsc:2,frmn:-1,frmx:1,tomn:0.525,tomx:0.75|IN-4719-OUT;n:type:ShaderForge.SFN_Set,id:8949,x:31582,y:31550,varname:LightIN,prsc:2|IN-4954-OUT;n:type:ShaderForge.SFN_Vector4Property,id:4553,x:30572,y:31920,ptovrint:False,ptlb:_LushLODTreeMainLightDir,ptin:_LushLODTreeMainLightDir,cmnt:The W is set via script in _LushLODTreesManager.cs,varname:node_8259,prsc:2,glob:True,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,v1:0.5,v2:0.5,v3:0.5,v4:1;n:type:ShaderForge.SFN_Color,id:7646,x:30522,y:31582,ptovrint:False,ptlb:LushLODTreeMainLightCol,ptin:_LushLODTreeMainLightCol,cmnt:This works even with lightmaps,varname:node_349,prsc:2,glob:True,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,c1:0.5,c2:0.5,c3:0.5,c4:1;n:type:ShaderForge.SFN_ValueProperty,id:117,x:30522,y:31763,ptovrint:False,ptlb:LushLODTreeMainLightIntensity,ptin:_LushLODTreeMainLightIntensity,cmnt:This works even with lightmaps,varname:node_5384,prsc:2,glob:True,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,v1:1;n:type:ShaderForge.SFN_Set,id:1300,x:30854,y:31918,varname:LightDir,prsc:2|IN-4553-XYZ;n:type:ShaderForge.SFN_Get,id:4631,x:29925,y:32359,varname:node_4631,prsc:2|IN-1300-OUT;n:type:ShaderForge.SFN_Multiply,id:9019,x:34073,y:31891,varname:node_9019,prsc:2|A-7736-RGB,B-1547-OUT;n:type:ShaderForge.SFN_Get,id:1547,x:33703,y:32046,varname:node_1547,prsc:2|IN-7375-OUT;n:type:ShaderForge.SFN_Get,id:6632,x:34827,y:32268,varname:node_6632,prsc:2|IN-8949-OUT;n:type:ShaderForge.SFN_Code,id:3025,x:32587,y:31496,varname:node_3025,prsc:2,code:YwBsAGkAcAAoAFQAZQB4AEEAbABwAGgAYQAgAC0AIABDAHUAdABvAGYAZgApADsACgByAGUAdAB1AHIAbgAgAFQAZQB4AEEAbABwAGgAYQA7AA==,output:0,fname:ClipMe,width:247,height:112,input:0,input:0,input_1_label:TexAlpha,input_2_label:Cutoff|A-7736-A,B-1093-OUT;n:type:ShaderForge.SFN_Get,id:1093,x:32303,y:31516,varname:node_1093,prsc:2|IN-7766-OUT;n:type:ShaderForge.SFN_TexCoord,id:5354,x:30530,y:32609,varname:node_5354,prsc:2,uv:0,uaff:False;n:type:ShaderForge.SFN_Code,id:2845,x:30828,y:32673,varname:node_2845,prsc:2,code:cgBlAHQAdQByAG4AIABHAGUAdABEAGkAdABoAGUAcgBTAGgAYQBkAG8AdwBzAF8AQgBPAFQASABQAEEAUwBTACgAVQBWADAAXwBJAE4ALAAgAFQAcgBhAG4AcwBwAGEAcgBlAG4AYwB5ACkAOwA=,output:0,fname:GetDitherShadows_Caller,width:453,height:128,input:1,input:0,input_1_label:UV0_IN,input_2_label:Transparency|A-5354-UVOUT,B-1172-OUT;n:type:ShaderForge.SFN_Get,id:1172,x:30509,y:32757,varname:node_1172,prsc:2|IN-7143-OUT;n:type:ShaderForge.SFN_Get,id:2595,x:34727,y:32578,varname:node_2595,prsc:2|IN-47-OUT;n:type:ShaderForge.SFN_Get,id:6287,x:34727,y:32518,cmnt:Attaching this forces ClipME to run in both passes,varname:node_6287,prsc:2|IN-3191-OUT;n:type:ShaderForge.SFN_Min,id:7451,x:34952,y:32518,varname:node_7451,prsc:2|A-6287-OUT,B-2595-OUT;n:type:ShaderForge.SFN_Get,id:7091,x:33698,y:32406,cmnt:The shadows value,varname:node_7091,prsc:2|IN-3529-OUT;n:type:ShaderForge.SFN_Clamp,id:511,x:33984,y:32414,cmnt:This lets the user adjust te maximum shadow. A value of 0.5 will limit it to half.,varname:node_511,prsc:2|IN-7091-OUT,MIN-8099-OUT,MAX-3349-OUT;n:type:ShaderForge.SFN_Vector1,id:3349,x:33698,y:32502,varname:node_3349,prsc:2,v1:1;n:type:ShaderForge.SFN_ValueProperty,id:9400,x:33577,y:32613,ptovrint:False,ptlb:_LushLODTreeShadowDarkness,ptin:_LushLODTreeShadowDarkness,cmnt:_LusLODSadowDarkness... this is cotrolled by the manager in its Update function,varname:node_2612,prsc:2,glob:True,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,v1:1;n:type:ShaderForge.SFN_OneMinus,id:8099,x:33776,y:32613,varname:node_8099,prsc:2|IN-9400-OUT;n:type:ShaderForge.SFN_Multiply,id:4954,x:31383,y:31550,varname:node_4954,prsc:2|A-7646-RGB,B-5390-OUT;n:type:ShaderForge.SFN_Multiply,id:9930,x:35154,y:32044,cmnt:Darkens the ambient by up to 20 when not being viewed on the sunny side.,varname:node_9930,prsc:2|A-9164-RGB,B-7590-OUT;n:type:ShaderForge.SFN_Multiply,id:5199,x:35843,y:31916,varname:node_5199,prsc:2|A-9019-OUT,B-6897-OUT;n:type:ShaderForge.SFN_Vector1,id:5653,x:33968,y:32046,varname:node_5653,prsc:2,v1:0.8;n:type:ShaderForge.SFN_Multiply,id:9758,x:35040,y:32297,varname:node_9758,prsc:2|A-6632-OUT,B-511-OUT;n:type:ShaderForge.SFN_Add,id:6897,x:35431,y:32136,varname:node_6897,prsc:2|A-9930-OUT,B-9758-OUT;n:type:ShaderForge.SFN_Divide,id:5390,x:31080,y:31611,varname:node_5390,prsc:2|A-117-OUT,B-6315-OUT;n:type:ShaderForge.SFN_Vector1,id:6315,x:30757,y:31750,varname:node_6315,prsc:2,v1:1.2;n:type:ShaderForge.SFN_Clamp01,id:7590,x:34881,y:32057,varname:node_7590,prsc:2|IN-4968-OUT;n:type:ShaderForge.SFN_Add,id:4968,x:34662,y:32057,varname:node_4968,prsc:2|A-5653-OUT,B-2725-OUT;n:type:ShaderForge.SFN_Subtract,id:3880,x:34234,y:32227,cmnt:This begins to remove the darkening of the ambient when we are more than 80 percent viewing the tree from the sunny side.,varname:node_3880,prsc:2|A-511-OUT,B-5653-OUT;n:type:ShaderForge.SFN_Clamp01,id:2725,x:34436,y:32227,varname:node_2725,prsc:2|IN-3880-OUT;n:type:ShaderForge.SFN_Code,id:114,x:34302,y:31742,varname:node_114,prsc:2,code:LwAvAFQAaABlACAAYwBvAGQAZQAgAGgAZQByAGUAIABoAGEAbgBkAGwAZQBzACAAdABoAGUAIABhAG0AYgBpAGUAbgB0ACAAbABpAGcAaAB0ACAAYQBuAGQAIABzAGgAYQBkAG8AdwBzAC4ACgAvAC8ASQBUACAASQBTACAATgBPAFQAIABUAEgARQAgAFMAQQBNAEUAIABhAHMAIABmAG8AdQBuAGQAIABpAG4AIAB0AGgAZQAgAG8AdABoAGUAcgAgAGgAaQBnAGUAcgAgAHEAdQBhAGkAdAB5ACAAbABlAHYAZQBsAHMALgAKAC8ALwBJACAAZABpAGQAIABhACAAcwBvAG0AZQB3AGgAYQB0ACAAcgBlAGQAdQBjAGUAZAAgAHYAZQByAHMAaQBvAG4AIABoAGUAcgBlACAAdwBoAGkAYwBoACAAdQBzAGUAcwAgAGYAZQB3AGUAcgAKAC8ALwBtAHUAbAB0AGkAcABsAGkAYwBhAHQAaQBvAG4AcwAgAGEAbgBkACAAbgBvACAAbABlAHIAcABzACAAYQB0ACAAYQBsAGwALgAgAFQAaABhAHQAJwBzACAAYgBlAGMAYQB1AHMAZQAgAHQAaABpAHMAIABpAHMAIAAKAC8ALwB0AGgAZQAgAGwAbwB3AGUAcwB0ACAAcQB1AGEAbABpAHQAeQAgAHMAaABhAGQAZQByACwAIABzAG8AIABJACAAdAByAGkAZQBkACAAdABvACAAbQBhAGsAZQAgAGkAdAAgAGYAYQBzAHQAIABoAGUAcgBlAC4ACgAvAC8AUwBvACAAZABvAG4AJwB0ACAAZQB4AHAAZQBjAHQAIAB0AGgAaQBzACAAcwBoAGEAZABlAHIAIAB0AG8AIABoAGEAbgBkAGwAZQAgAHQAaABlACAAYQBtAGIAaQBlAG4AdAAgAGwAaQBnAGgAdAAKAC8ALwBlAHgAYQBjAHQAbAB5ACAAdABoAGUAIABzAGEAbQBlACAAYQBzACAAdABoAGUAIABvAHQAaABlAHIAIABzAGEAZABlAHIAcwAsACAAYgBlAGMAYQB1AHMAZQAgAGkAdAAgAHcAbwBuACcAdAAuAA==,output:2,fname:Read_Me_23957205,width:478,height:280;n:type:ShaderForge.SFN_Color,id:9164,x:34870,y:31928,ptovrint:False,ptlb:_LushLODTreeAmbientColor,ptin:_LushLODTreeAmbientColor,cmnt:_LushLODTreeAmbientColor... this value is set in the manager,varname:_LushLODTreeAmbientColor_copy,prsc:2,glob:True,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,c1:0.5,c2:0.5,c3:0.5,c4:1;proporder:6665-6832-5916-1495-7736;pass:END;sub:END;*/

Shader "Hidden/LushLODTree/Tree_Leaves4" {
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
            #define UNITY_PASS_FORWARDBASE
            #include "UnityCG.cginc"
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
                float Param_ShadowTrans_SHADOWPASS = _ShadowTransparency;
                float DITHER_SHADOWPASS = GetDitherShadows_Caller( i.uv0 , Param_ShadowTrans_SHADOWPASS );
                clip(min(TexAlpha,DITHER_SHADOWPASS) - 0.5);
////// Lighting:
                float3 Param_Color = (_Color.rgb*2.0);
                float node_5653 = 0.8;
                float3 LightDir = _LushLODTreeMainLightDir.rgb;
                float node_4719 = 0.5*dot(viewDirection,LightDir)+0.5; // Check if view is opposite the direction of sunlight
                float Backside_Darkening = node_4719; // Darkens the trees when viewed from the back side
                float node_511 = clamp(Backside_Darkening,(1.0 - _LushLODTreeShadowDarkness),1.0); // This lets the user adjust te maximum shadow. A value of 0.5 will limit it to half.
                float3 LightIN = (_LushLODTreeMainLightCol.rgb*(_LushLODTreeMainLightIntensity/1.2));
                float3 finalColor = ((_MainTex_var.rgb*Param_Color)*((_LushLODTreeAmbientColor.rgb*saturate((node_5653+saturate((node_511-node_5653)))))+(LightIN*node_511)));
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
