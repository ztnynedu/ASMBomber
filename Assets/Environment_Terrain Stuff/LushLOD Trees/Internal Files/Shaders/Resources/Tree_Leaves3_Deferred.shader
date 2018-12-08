// Shader created with Shader Forge v1.38 
// Shader Forge (c) Neat Corporation / Joachim Holmer - http://www.acegikmo.com/shaderforge/
// Note: Manually altering this data may prevent you from opening it in Shader Forge
/*SF_DATA;ver:1.38;sub:START;pass:START;ps:flbk:,iptp:0,cusa:True,bamd:0,cgin:QwBHAEkAbgBjAGwAdQBkAGUAcwAvAEQAaQB0AGgAZQByAGkAbgBnAA==,lico:0,lgpr:1,limd:3,spmd:1,trmd:0,grmd:0,uamb:True,mssp:True,bkdf:False,hqlp:False,rprd:False,enco:False,rmgx:True,imps:True,rpth:1,vtps:0,hqsc:True,nrmq:1,nrsp:0,vomd:0,spxs:False,tesm:0,olmd:1,culm:2,bsrc:0,bdst:1,dpts:2,wrdp:True,dith:0,atcv:False,rfrpo:False,rfrpn:Refraction,coma:15,ufog:True,aust:True,igpj:False,qofs:0,qpre:2,rntp:3,fgom:False,fgoc:False,fgod:False,fgor:False,fgmd:0,fgcr:0.5,fgcg:0.5,fgcb:0.5,fgca:1,fgde:0.01,fgrn:0,fgrf:300,stcl:False,atwp:False,stva:128,stmr:255,stmw:255,stcp:6,stps:0,stfa:0,stfz:0,ofsf:0,ofsu:0,f2p0:False,fnsp:False,fnfb:True,fsmp:False;n:type:ShaderForge.SFN_Final,id:2865,x:36283,y:31315,varname:node_2865,prsc:2|emission-2045-OUT,clip-6949-OUT;n:type:ShaderForge.SFN_Slider,id:6832,x:30194,y:32305,ptovrint:False,ptlb:Transparency,ptin:_Transparency,varname:_Transparency,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,min:0,cur:1,max:1;n:type:ShaderForge.SFN_Slider,id:5916,x:30206,y:32205,ptovrint:False,ptlb:Cutoff,ptin:_Cutoff,varname:_Cutoff,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,min:0,cur:0.7,max:1;n:type:ShaderForge.SFN_Slider,id:1495,x:30206,y:32078,ptovrint:False,ptlb:ShadowTransparency,ptin:_ShadowTransparency,varname:_ShadowTransparency,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,min:0,cur:0,max:1;n:type:ShaderForge.SFN_ViewVector,id:628,x:30104,y:31399,varname:node_628,prsc:2;n:type:ShaderForge.SFN_Dot,id:1391,x:30310,y:31462,cmnt:Check if view is opposite the direction of sunlight,varname:node_1391,prsc:2,dt:4|A-628-OUT,B-2684-OUT;n:type:ShaderForge.SFN_Set,id:3191,x:32153,y:31813,varname:TexAlpha,prsc:2|IN-6098-OUT;n:type:ShaderForge.SFN_Set,id:8286,x:30547,y:32320,varname:Param_Transparency_MAINPASS,prsc:2|IN-6832-OUT;n:type:ShaderForge.SFN_Set,id:7766,x:30547,y:32204,varname:Param_Cutoff,prsc:2|IN-5916-OUT;n:type:ShaderForge.SFN_RemapRange,id:694,x:30523,y:31514,cmnt:Rescales it to 0.7 to 1 multiplied by 0.75 which yields 0.525 to 0.75,varname:node_694,prsc:2,frmn:-1,frmx:1,tomn:0.525,tomx:0.75|IN-1391-OUT;n:type:ShaderForge.SFN_Set,id:7143,x:30547,y:32081,varname:Param_ShadowTrans_SHADOWPASS,prsc:2|IN-1495-OUT;n:type:ShaderForge.SFN_Set,id:47,x:32172,y:32201,varname:DITHER_SHADOWPASS,prsc:2|IN-1402-OUT;n:type:ShaderForge.SFN_Set,id:4973,x:31931,y:31501,varname:MainTexIN,prsc:2|IN-5992-RGB;n:type:ShaderForge.SFN_Set,id:6719,x:30722,y:31546,cmnt:Darkens the billboards when viewed from the back side,varname:Backside_Darkening_Amount,prsc:2|IN-1391-OUT;n:type:ShaderForge.SFN_Set,id:7375,x:30779,y:31934,varname:Param_Color,prsc:2|IN-9349-OUT;n:type:ShaderForge.SFN_Multiply,id:9349,x:30568,y:31888,cmnt:Inputting 0.5 will multiply by 1 which has no effect. Less than 0.5 will darken from 0 to 1 and above 0.5 will brighten by multiplying from 1 to 2x.,varname:node_9349,prsc:2|A-5196-RGB,B-1948-OUT;n:type:ShaderForge.SFN_Vector1,id:1948,x:30363,y:31791,varname:node_1948,prsc:2,v1:2;n:type:ShaderForge.SFN_Color,id:5196,x:30363,y:31888,ptovrint:False,ptlb:Color,ptin:_Color,varname:_Color,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,c1:0.5,c2:0.5,c3:0.5,c4:1;n:type:ShaderForge.SFN_Set,id:3624,x:31332,y:30632,varname:LightIN,prsc:2|IN-6445-OUT;n:type:ShaderForge.SFN_Vector4Property,id:1476,x:30388,y:30943,ptovrint:False,ptlb:_LushLODTreeMainLightDir,ptin:_LushLODTreeMainLightDir,cmnt:The W is set via script in _LushLODTreesManager.cs,varname:node_8259,prsc:2,glob:True,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,v1:0.5,v2:0.5,v3:0.5,v4:1;n:type:ShaderForge.SFN_Color,id:5159,x:30388,y:30647,ptovrint:False,ptlb:LushLODTreeMainLightCol,ptin:_LushLODTreeMainLightCol,cmnt:This works even with lightmaps,varname:node_349,prsc:2,glob:True,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,c1:0.5,c2:0.5,c3:0.5,c4:1;n:type:ShaderForge.SFN_ValueProperty,id:3152,x:30388,y:30828,ptovrint:False,ptlb:LushLODTreeMainLightIntensity,ptin:_LushLODTreeMainLightIntensity,cmnt:This works even with lightmaps,varname:node_5384,prsc:2,glob:True,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,v1:1;n:type:ShaderForge.SFN_Set,id:3598,x:30719,y:30936,varname:LightDir,prsc:2|IN-1476-XYZ;n:type:ShaderForge.SFN_Dot,id:7605,x:31899,y:30908,cmnt:Is the sun above the horizon?,varname:node_7605,prsc:2,dt:0|A-3477-OUT,B-9675-OUT;n:type:ShaderForge.SFN_Get,id:9675,x:31666,y:30954,varname:node_9675,prsc:2|IN-3598-OUT;n:type:ShaderForge.SFN_Vector3,id:3477,x:31666,y:30841,cmnt:Checks if the light is shining straight down,varname:node_3477,prsc:2,v1:0,v2:1,v3:0;n:type:ShaderForge.SFN_Clamp01,id:7024,x:32463,y:30912,varname:node_7024,prsc:2|IN-5533-OUT;n:type:ShaderForge.SFN_Clamp01,id:4084,x:32927,y:30756,varname:node_4084,prsc:2|IN-4176-OUT;n:type:ShaderForge.SFN_Set,id:7369,x:33485,y:30777,cmnt:This is an optional lighting adjustment you can remove this if your scene doesnt benefit from this.,varname:TimeOfDayIntensity,prsc:2|IN-7102-OUT;n:type:ShaderForge.SFN_Add,id:5533,x:32278,y:30912,cmnt:This makes the trees not get dark until the sun is somewhat BELOW the horizon.,varname:node_5533,prsc:2|A-7605-OUT,B-7696-OUT;n:type:ShaderForge.SFN_Vector1,id:7696,x:32090,y:30946,varname:node_7696,prsc:2,v1:0.25;n:type:ShaderForge.SFN_RemapRangeAdvanced,id:4176,x:32726,y:30756,cmnt:Rescales it from 01 to about 03 to make it get brigher faster as the sun comes up. This effect is significantly stronger on the sunny side via backside darkening.,varname:node_4176,prsc:2|IN-7024-OUT,IMIN-1942-OUT,IMAX-2352-OUT,OMIN-4292-OUT,OMAX-1039-OUT;n:type:ShaderForge.SFN_Vector1,id:1942,x:32463,y:30607,varname:node_1942,prsc:2,v1:0;n:type:ShaderForge.SFN_Vector1,id:2352,x:32463,y:30656,varname:node_2352,prsc:2,v1:1;n:type:ShaderForge.SFN_Vector1,id:4292,x:32463,y:30711,varname:node_4292,prsc:2,v1:0;n:type:ShaderForge.SFN_Vector1,id:3524,x:32260,y:30667,varname:node_3524,prsc:2,v1:1.3;n:type:ShaderForge.SFN_Add,id:1039,x:32463,y:30761,varname:node_1039,prsc:2|A-3524-OUT,B-5703-OUT;n:type:ShaderForge.SFN_Get,id:1024,x:32083,y:30669,varname:node_1024,prsc:2|IN-6719-OUT;n:type:ShaderForge.SFN_Multiply,id:5703,x:32260,y:30733,varname:node_5703,prsc:2|A-1024-OUT,B-7717-OUT;n:type:ShaderForge.SFN_Vector1,id:7717,x:32083,y:30752,varname:node_7717,prsc:2,v1:2;n:type:ShaderForge.SFN_Get,id:2684,x:30083,y:31539,varname:node_2684,prsc:2|IN-3598-OUT;n:type:ShaderForge.SFN_Tex2d,id:5992,x:31649,y:31511,ptovrint:False,ptlb:MainTex,ptin:_MainTex,varname:_MainTex,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,ntxv:0,isnm:False;n:type:ShaderForge.SFN_Code,id:6098,x:31781,y:31745,varname:node_6098,prsc:2,code:YwBsAGkAcAAoAFQAZQB4AEEAbABwAGgAYQAgAC0AIABDAHUAdABvAGYAZgApADsACgByAGUAdAB1AHIAbgAgAFQAZQB4AEEAbABwAGgAYQA7AA==,output:0,fname:ClipMe,width:247,height:112,input:0,input:0,input_1_label:TexAlpha,input_2_label:Cutoff|A-5992-A,B-7880-OUT;n:type:ShaderForge.SFN_Get,id:7880,x:31545,y:31757,varname:node_7880,prsc:2|IN-7766-OUT;n:type:ShaderForge.SFN_TexCoord,id:3664,x:31303,y:32138,varname:node_3664,prsc:2,uv:0,uaff:False;n:type:ShaderForge.SFN_Code,id:1402,x:31601,y:32202,varname:node_1402,prsc:2,code:cgBlAHQAdQByAG4AIABHAGUAdABEAGkAdABoAGUAcgBTAGgAYQBkAG8AdwBzAF8AQgBPAFQASABQAEEAUwBTACgAVQBWADAAXwBJAE4ALAAgAFQAcgBhAG4AcwBwAGEAcgBlAG4AYwB5ACkAOwA=,output:0,fname:GetDitherShadows_Caller,width:453,height:128,input:1,input:0,input_1_label:UV0_IN,input_2_label:Transparency|A-3664-UVOUT,B-121-OUT;n:type:ShaderForge.SFN_Get,id:121,x:31282,y:32288,varname:node_121,prsc:2|IN-7143-OUT;n:type:ShaderForge.SFN_Get,id:9776,x:35418,y:31908,varname:node_9776,prsc:2|IN-47-OUT;n:type:ShaderForge.SFN_Get,id:8115,x:35418,y:31848,cmnt:Attaching this forces ClipME to run in both passes,varname:node_8115,prsc:2|IN-3191-OUT;n:type:ShaderForge.SFN_Min,id:6949,x:35643,y:31848,varname:node_6949,prsc:2|A-8115-OUT,B-9776-OUT;n:type:ShaderForge.SFN_Multiply,id:6445,x:31141,y:30632,varname:node_6445,prsc:2|A-5159-RGB,B-8570-OUT;n:type:ShaderForge.SFN_Get,id:566,x:33474,y:31179,cmnt:The main texture color with some modifications for things like seams blending.,varname:node_566,prsc:2|IN-4973-OUT;n:type:ShaderForge.SFN_Get,id:3300,x:33303,y:31475,cmnt:The color of the main diretional light,varname:node_3300,prsc:2|IN-3624-OUT;n:type:ShaderForge.SFN_Get,id:3843,x:33767,y:32024,cmnt:The shadows value,varname:node_3843,prsc:2|IN-6719-OUT;n:type:ShaderForge.SFN_Get,id:6126,x:35270,y:31189,varname:node_6126,prsc:2|IN-7369-OUT;n:type:ShaderForge.SFN_Add,id:7347,x:33620,y:31497,varname:node_7347,prsc:2|A-3300-OUT,B-5369-RGB;n:type:ShaderForge.SFN_Multiply,id:6549,x:33880,y:31440,cmnt:The final texture color with all lights but no shadows yet,varname:node_6549,prsc:2|A-566-OUT,B-7347-OUT;n:type:ShaderForge.SFN_Lerp,id:9340,x:34485,y:31624,cmnt:The final color with the shadows and ambient tint applied to the shadows,varname:node_9340,prsc:2|A-2623-OUT,B-6549-OUT,T-1464-OUT;n:type:ShaderForge.SFN_Multiply,id:2623,x:34114,y:31811,varname:node_2623,prsc:2|A-6606-OUT,B-8354-OUT;n:type:ShaderForge.SFN_Blend,id:6606,x:33902,y:31732,cmnt:The color of the shadow is based entirely off the texture color and the ambient light color,varname:node_6606,prsc:2,blmd:1,clmp:False|SRC-5369-RGB,DST-566-OUT;n:type:ShaderForge.SFN_Vector1,id:8354,x:33876,y:31907,varname:node_8354,prsc:2,v1:0.8;n:type:ShaderForge.SFN_Get,id:3850,x:33971,y:31223,varname:node_3850,prsc:2|IN-7375-OUT;n:type:ShaderForge.SFN_Max,id:7618,x:34485,y:31292,cmnt:Finds the highest input color value,varname:node_7618,prsc:2|A-861-R,B-861-G,C-861-B;n:type:ShaderForge.SFN_Min,id:9450,x:34485,y:31450,cmnt:Finds how much LESS than WHITE the input color is,varname:node_9450,prsc:2|A-861-R,B-861-G,C-861-B;n:type:ShaderForge.SFN_ComponentMask,id:861,x:34186,y:31223,cmnt:The input color,varname:node_861,prsc:2,cc1:0,cc2:1,cc3:2,cc4:-1|IN-3850-OUT;n:type:ShaderForge.SFN_Multiply,id:5418,x:34513,y:30983,cmnt:The input color multiplied by the texture color to give the input color a texture so that it doesnt look flat,varname:node_5418,prsc:2|A-566-OUT,B-861-OUT;n:type:ShaderForge.SFN_Multiply,id:9080,x:34843,y:31211,cmnt:Darkens the final color based on the input ccolor,varname:node_9080,prsc:2|A-9340-OUT,B-861-OUT;n:type:ShaderForge.SFN_Lerp,id:8445,x:34853,y:31009,cmnt:Lerps towards the input color based on how much the input color is LESS than WHITE,varname:node_8445,prsc:2|A-5418-OUT,B-9340-OUT,T-9450-OUT;n:type:ShaderForge.SFN_Subtract,id:5288,x:35014,y:31357,cmnt:Finds the difference between the highest and lowest color value. This is used to detect if our iput color is simply a shade of grey and has no color,varname:node_5288,prsc:2|A-7618-OUT,B-9450-OUT;n:type:ShaderForge.SFN_Lerp,id:8717,x:35291,y:31058,varname:node_8717,prsc:2|A-9080-OUT,B-8445-OUT,T-5288-OUT;n:type:ShaderForge.SFN_Multiply,id:2045,x:35624,y:31098,varname:node_2045,prsc:2|A-8717-OUT,B-6126-OUT;n:type:ShaderForge.SFN_Clamp,id:1464,x:34075,y:32026,cmnt:This lets the user adjust te maximum shadow. A value of 0.5 will limit it to half.,varname:node_1464,prsc:2|IN-3843-OUT,MIN-7684-OUT,MAX-3646-OUT;n:type:ShaderForge.SFN_Vector1,id:3646,x:33767,y:32120,varname:node_3646,prsc:2,v1:1;n:type:ShaderForge.SFN_ValueProperty,id:4922,x:33646,y:32231,ptovrint:False,ptlb:_LushLODTreeShadowDarkness,ptin:_LushLODTreeShadowDarkness,cmnt:_LusLODSadowDarkness... this is cotrolled by the manager in its Update function,varname:node_2612,prsc:2,glob:True,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,v1:1;n:type:ShaderForge.SFN_OneMinus,id:7684,x:33845,y:32231,varname:node_7684,prsc:2|IN-4922-OUT;n:type:ShaderForge.SFN_Lerp,id:7102,x:33250,y:30891,cmnt:Lets the user adjust the tie of day correction,varname:node_7102,prsc:2|A-3627-OUT,B-4084-OUT,T-5584-OUT;n:type:ShaderForge.SFN_ValueProperty,id:5584,x:33003,y:30963,ptovrint:False,ptlb:LushLODTreeTimeOfDay,ptin:_LushLODTreeTimeOfDay,varname:node_5174,prsc:2,glob:True,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,v1:1;n:type:ShaderForge.SFN_Vector1,id:3627,x:33003,y:30891,varname:node_3627,prsc:2,v1:1;n:type:ShaderForge.SFN_Divide,id:8570,x:30829,y:30708,varname:node_8570,prsc:2|A-3152-OUT,B-198-OUT;n:type:ShaderForge.SFN_Vector1,id:198,x:30608,y:30707,varname:node_198,prsc:2,v1:1.2;n:type:ShaderForge.SFN_Color,id:5369,x:33339,y:31681,ptovrint:False,ptlb:_LushLODTreeAmbientColor,ptin:_LushLODTreeAmbientColor,cmnt:_LushLODTreeAmbientColor... this value is set in the manager,varname:_LushLODTreeAmbientColor_copy,prsc:2,glob:True,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,c1:0.5,c2:0.5,c3:0.5,c4:1;proporder:6832-5916-1495-5196-5992;pass:END;sub:END;*/

Shader "Hidden/LushLODTree/Tree_Leaves3_Deferred" {
    Properties {
        _Transparency ("Transparency", Range(0, 1)) = 1
        _Cutoff ("Cutoff", Range(0, 1)) = 0.7
        _ShadowTransparency ("ShadowTransparency", Range(0, 1)) = 0
        _Color ("Color", Color) = (0.5,0.5,0.5,1)
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
            uniform float _Cutoff;
            uniform float _ShadowTransparency;
            uniform float4 _Color;
            uniform float4 _LushLODTreeMainLightDir;
            uniform float4 _LushLODTreeMainLightCol;
            uniform float _LushLODTreeMainLightIntensity;
            uniform sampler2D _MainTex; uniform float4 _MainTex_ST;
            float ClipMe( float TexAlpha , float Cutoff ){
            clip(TexAlpha - Cutoff);
            return TexAlpha;
            }
            
            float GetDitherShadows_Caller( float2 UV0_IN , float Transparency ){
            return GetDitherShadows_BOTHPASS(UV0_IN, Transparency);
            }
            
            uniform float _LushLODTreeShadowDarkness;
            uniform float _LushLODTreeTimeOfDay;
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
                float3 MainTexIN = _MainTex_var.rgb;
                float3 node_566 = MainTexIN; // The main texture color with some modifications for things like seams blending.
                float3 LightIN = (_LushLODTreeMainLightCol.rgb*(_LushLODTreeMainLightIntensity/1.2));
                float3 LightDir = _LushLODTreeMainLightDir.rgb;
                float node_1391 = 0.5*dot(viewDirection,LightDir)+0.5; // Check if view is opposite the direction of sunlight
                float Backside_Darkening_Amount = node_1391; // Darkens the billboards when viewed from the back side
                float3 node_9340 = lerp(((_LushLODTreeAmbientColor.rgb*node_566)*0.8),(node_566*(LightIN+_LushLODTreeAmbientColor.rgb)),clamp(Backside_Darkening_Amount,(1.0 - _LushLODTreeShadowDarkness),1.0)); // The final color with the shadows and ambient tint applied to the shadows
                float3 Param_Color = (_Color.rgb*2.0);
                float3 node_861 = Param_Color.rgb; // The input color
                float node_9450 = min(min(node_861.r,node_861.g),node_861.b); // Finds how much LESS than WHITE the input color is
                float node_1942 = 0.0;
                float node_4292 = 0.0;
                float TimeOfDayIntensity = lerp(1.0,saturate((node_4292 + ( (saturate((dot(float3(0,1,0),LightDir)+0.25)) - node_1942) * ((1.3+(Backside_Darkening_Amount*2.0)) - node_4292) ) / (1.0 - node_1942))),_LushLODTreeTimeOfDay); // This is an optional lighting adjustment you can remove this if your scene doesnt benefit from this.
                float3 emissive = (lerp((node_9340*node_861),lerp((node_566*node_861),node_9340,node_9450),(max(max(node_861.r,node_861.g),node_861.b)-node_9450))*TimeOfDayIntensity);
                float3 finalColor = emissive;
                outDiffuse = half4( 0, 0, 0, 1 );
                outSpecSmoothness = half4(0,0,0,0);
                outNormal = half4( normalDirection * 0.5 + 0.5, 1 );
                outEmission = half4( (lerp((node_9340*node_861),lerp((node_566*node_861),node_9340,node_9450),(max(max(node_861.r,node_861.g),node_861.b)-node_9450))*TimeOfDayIntensity), 1 );
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
            uniform float _Cutoff;
            uniform float _ShadowTransparency;
            uniform float4 _Color;
            uniform float4 _LushLODTreeMainLightDir;
            uniform float4 _LushLODTreeMainLightCol;
            uniform float _LushLODTreeMainLightIntensity;
            uniform sampler2D _MainTex; uniform float4 _MainTex_ST;
            float ClipMe( float TexAlpha , float Cutoff ){
            clip(TexAlpha - Cutoff);
            return TexAlpha;
            }
            
            float GetDitherShadows_Caller( float2 UV0_IN , float Transparency ){
            return GetDitherShadows_BOTHPASS(UV0_IN, Transparency);
            }
            
            uniform float _LushLODTreeShadowDarkness;
            uniform float _LushLODTreeTimeOfDay;
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
                float3 MainTexIN = _MainTex_var.rgb;
                float3 node_566 = MainTexIN; // The main texture color with some modifications for things like seams blending.
                float3 LightIN = (_LushLODTreeMainLightCol.rgb*(_LushLODTreeMainLightIntensity/1.2));
                float3 LightDir = _LushLODTreeMainLightDir.rgb;
                float node_1391 = 0.5*dot(viewDirection,LightDir)+0.5; // Check if view is opposite the direction of sunlight
                float Backside_Darkening_Amount = node_1391; // Darkens the billboards when viewed from the back side
                float3 node_9340 = lerp(((_LushLODTreeAmbientColor.rgb*node_566)*0.8),(node_566*(LightIN+_LushLODTreeAmbientColor.rgb)),clamp(Backside_Darkening_Amount,(1.0 - _LushLODTreeShadowDarkness),1.0)); // The final color with the shadows and ambient tint applied to the shadows
                float3 Param_Color = (_Color.rgb*2.0);
                float3 node_861 = Param_Color.rgb; // The input color
                float node_9450 = min(min(node_861.r,node_861.g),node_861.b); // Finds how much LESS than WHITE the input color is
                float node_1942 = 0.0;
                float node_4292 = 0.0;
                float TimeOfDayIntensity = lerp(1.0,saturate((node_4292 + ( (saturate((dot(float3(0,1,0),LightDir)+0.25)) - node_1942) * ((1.3+(Backside_Darkening_Amount*2.0)) - node_4292) ) / (1.0 - node_1942))),_LushLODTreeTimeOfDay); // This is an optional lighting adjustment you can remove this if your scene doesnt benefit from this.
                float3 emissive = (lerp((node_9340*node_861),lerp((node_566*node_861),node_9340,node_9450),(max(max(node_861.r,node_861.g),node_861.b)-node_9450))*TimeOfDayIntensity);
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
            uniform float _Cutoff;
            uniform float _ShadowTransparency;
            uniform sampler2D _MainTex; uniform float4 _MainTex_ST;
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
