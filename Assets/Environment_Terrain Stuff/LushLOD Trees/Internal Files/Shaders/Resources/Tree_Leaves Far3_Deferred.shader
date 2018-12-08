// Shader created with Shader Forge v1.38 
// Shader Forge (c) Neat Corporation / Joachim Holmer - http://www.acegikmo.com/shaderforge/
// Note: Manually altering this data may prevent you from opening it in Shader Forge
/*SF_DATA;ver:1.38;sub:START;pass:START;ps:flbk:,iptp:0,cusa:True,bamd:0,cgin:,lico:0,lgpr:1,limd:3,spmd:1,trmd:0,grmd:0,uamb:True,mssp:True,bkdf:False,hqlp:False,rprd:False,enco:False,rmgx:True,imps:True,rpth:1,vtps:0,hqsc:True,nrmq:1,nrsp:0,vomd:0,spxs:False,tesm:0,olmd:1,culm:2,bsrc:0,bdst:1,dpts:2,wrdp:True,dith:0,atcv:False,rfrpo:False,rfrpn:Refraction,coma:15,ufog:True,aust:True,igpj:False,qofs:0,qpre:2,rntp:3,fgom:False,fgoc:False,fgod:False,fgor:False,fgmd:0,fgcr:0.5,fgcg:0.5,fgcb:0.5,fgca:1,fgde:0.01,fgrn:0,fgrf:300,stcl:False,atwp:False,stva:128,stmr:255,stmw:255,stcp:6,stps:0,stfa:0,stfz:0,ofsf:0,ofsu:0,f2p0:False,fnsp:False,fnfb:True,fsmp:False;n:type:ShaderForge.SFN_Final,id:2865,x:35617,y:31902,varname:node_2865,prsc:2|emission-6871-OUT,clip-8572-OUT;n:type:ShaderForge.SFN_Color,id:6665,x:30493,y:32095,ptovrint:False,ptlb:Color,ptin:_Color,varname:_Color,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,c1:0.5019608,c2:0.5019608,c3:0.5019608,c4:1;n:type:ShaderForge.SFN_Tex2d,id:7736,x:31687,y:32262,ptovrint:False,ptlb:MainTex,ptin:_MainTex,varname:_MainTex,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,ntxv:0,isnm:False;n:type:ShaderForge.SFN_Slider,id:5916,x:30447,y:32324,ptovrint:False,ptlb:Cutoff,ptin:_Cutoff,varname:_Cutoff,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,min:0,cur:0.7,max:1;n:type:ShaderForge.SFN_ViewVector,id:628,x:30449,y:31580,varname:node_628,prsc:2;n:type:ShaderForge.SFN_Dot,id:1391,x:30655,y:31643,cmnt:Check if view is opposite the direction of sunlight,varname:node_1391,prsc:2,dt:4|A-628-OUT,B-7281-OUT;n:type:ShaderForge.SFN_Set,id:3191,x:32238,y:32532,varname:TexAlpha,prsc:2|IN-8723-OUT;n:type:ShaderForge.SFN_Set,id:7766,x:30788,y:32323,varname:Param_Cutoff,prsc:2|IN-5916-OUT;n:type:ShaderForge.SFN_Set,id:6719,x:31038,y:31735,cmnt:Darkens the trees when viewed from the back side.,varname:Backside_Darkening_Amount,prsc:2|IN-1391-OUT;n:type:ShaderForge.SFN_Set,id:7375,x:30907,y:32099,varname:Param_Color,prsc:2|IN-720-OUT;n:type:ShaderForge.SFN_Get,id:8572,x:35108,y:32477,varname:node_8572,prsc:2|IN-3191-OUT;n:type:ShaderForge.SFN_Multiply,id:720,x:30705,y:32099,cmnt:Inputting 0.5 will multiply by 1 which has no effect. Less than 0.5 will darken from 0 to 1 and above 0.5 will brighten by multiplying from 1 to 2x.,varname:node_720,prsc:2|A-6665-RGB,B-221-OUT;n:type:ShaderForge.SFN_Vector1,id:221,x:30500,y:32002,varname:node_221,prsc:2,v1:2;n:type:ShaderForge.SFN_RemapRange,id:3460,x:30861,y:31696,cmnt:Rescales it to 0.7 to 1 multiplied by 0.75 which yields 0.525 to 0.75,varname:node_3460,prsc:2,frmn:-1,frmx:1,tomn:0.525,tomx:0.75|IN-1391-OUT;n:type:ShaderForge.SFN_Set,id:8909,x:32303,y:31011,varname:LightIN,prsc:2|IN-7201-OUT;n:type:ShaderForge.SFN_Vector4Property,id:7226,x:31336,y:31287,ptovrint:False,ptlb:_LushLODTreeMainLightDir,ptin:_LushLODTreeMainLightDir,cmnt:The W is set via script in _LushLODTreesManager.cs,varname:node_8259,prsc:2,glob:True,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,v1:0.5,v2:0.5,v3:0.5,v4:1;n:type:ShaderForge.SFN_Color,id:5673,x:31336,y:30991,ptovrint:False,ptlb:LushLODTreeMainLightCol,ptin:_LushLODTreeMainLightCol,cmnt:This works even with lightmaps,varname:node_349,prsc:2,glob:True,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,c1:0.5,c2:0.5,c3:0.5,c4:1;n:type:ShaderForge.SFN_ValueProperty,id:1162,x:31336,y:31172,ptovrint:False,ptlb:LushLODTreeMainLightIntensity,ptin:_LushLODTreeMainLightIntensity,cmnt:This works even with lightmaps,varname:node_5384,prsc:2,glob:True,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,v1:1;n:type:ShaderForge.SFN_Set,id:9065,x:31581,y:31290,varname:LightDir,prsc:2|IN-7226-XYZ;n:type:ShaderForge.SFN_Dot,id:8664,x:32847,y:31252,cmnt:Is the sun above the horizon?,varname:node_8664,prsc:2,dt:0|A-726-OUT,B-9695-OUT;n:type:ShaderForge.SFN_Get,id:9695,x:32614,y:31298,varname:node_9695,prsc:2|IN-9065-OUT;n:type:ShaderForge.SFN_Vector3,id:726,x:32614,y:31185,cmnt:Checks if the light is shining straight down,varname:node_726,prsc:2,v1:0,v2:1,v3:0;n:type:ShaderForge.SFN_Clamp01,id:7376,x:33411,y:31256,varname:node_7376,prsc:2|IN-6044-OUT;n:type:ShaderForge.SFN_Clamp01,id:8562,x:33875,y:31100,varname:node_8562,prsc:2|IN-7331-OUT;n:type:ShaderForge.SFN_Set,id:6950,x:34455,y:31134,cmnt:This is an optional lighting adjustment you can remove this if your scene doesnt benefit from this.,varname:TimeOfDayIntensity,prsc:2|IN-9380-OUT;n:type:ShaderForge.SFN_Add,id:6044,x:33226,y:31256,cmnt:This makes the trees not get dark until the sun is somewhat BELOW the horizon.,varname:node_6044,prsc:2|A-8664-OUT,B-1561-OUT;n:type:ShaderForge.SFN_Vector1,id:1561,x:33038,y:31290,varname:node_1561,prsc:2,v1:0.25;n:type:ShaderForge.SFN_RemapRangeAdvanced,id:7331,x:33674,y:31100,cmnt:Rescales it from 01 to about 03 to make it get brigher faster as the sun comes up. This effect is significantly stronger on the sunny side via backside darkening.,varname:node_7331,prsc:2|IN-7376-OUT,IMIN-6071-OUT,IMAX-6491-OUT,OMIN-4685-OUT,OMAX-8937-OUT;n:type:ShaderForge.SFN_Vector1,id:6071,x:33411,y:30951,varname:node_6071,prsc:2,v1:0;n:type:ShaderForge.SFN_Vector1,id:6491,x:33411,y:31000,varname:node_6491,prsc:2,v1:1;n:type:ShaderForge.SFN_Vector1,id:4685,x:33411,y:31055,varname:node_4685,prsc:2,v1:0;n:type:ShaderForge.SFN_Vector1,id:7655,x:33208,y:31011,varname:node_7655,prsc:2,v1:1.3;n:type:ShaderForge.SFN_Add,id:8937,x:33411,y:31105,varname:node_8937,prsc:2|A-7655-OUT,B-6695-OUT;n:type:ShaderForge.SFN_Get,id:7771,x:33031,y:31013,varname:node_7771,prsc:2|IN-6719-OUT;n:type:ShaderForge.SFN_Multiply,id:6695,x:33208,y:31077,varname:node_6695,prsc:2|A-7771-OUT,B-3751-OUT;n:type:ShaderForge.SFN_Vector1,id:3751,x:33031,y:31096,varname:node_3751,prsc:2,v1:2;n:type:ShaderForge.SFN_Get,id:7281,x:30449,y:31750,varname:node_7281,prsc:2|IN-9065-OUT;n:type:ShaderForge.SFN_Code,id:8723,x:31917,y:32477,varname:node_8723,prsc:2,code:YwBsAGkAcAAoAFQAZQB4AEEAbABwAGgAYQAgAC0AIABDAHUAdABvAGYAZgApADsACgByAGUAdAB1AHIAbgAgAFQAZQB4AEEAbABwAGgAYQA7AA==,output:0,fname:ClipMe,width:247,height:112,input:0,input:0,input_1_label:TexAlpha,input_2_label:Cutoff|A-7736-A,B-7773-OUT;n:type:ShaderForge.SFN_Get,id:7773,x:31665,y:32537,varname:node_7773,prsc:2|IN-7766-OUT;n:type:ShaderForge.SFN_Multiply,id:7201,x:32077,y:31011,varname:node_7201,prsc:2|A-5673-RGB,B-5489-OUT;n:type:ShaderForge.SFN_Get,id:4560,x:32746,y:31855,cmnt:The main texture color with some modifications for things like seams blending.,varname:node_4560,prsc:2|IN-5422-OUT;n:type:ShaderForge.SFN_Get,id:9532,x:32575,y:32151,cmnt:The color of the main diretional light,varname:node_9532,prsc:2|IN-8909-OUT;n:type:ShaderForge.SFN_Get,id:2007,x:33039,y:32700,cmnt:The shadows value,varname:node_2007,prsc:2|IN-6719-OUT;n:type:ShaderForge.SFN_Get,id:9684,x:34542,y:31865,varname:node_9684,prsc:2|IN-6950-OUT;n:type:ShaderForge.SFN_Add,id:1810,x:32892,y:32173,varname:node_1810,prsc:2|A-9532-OUT,B-6849-RGB;n:type:ShaderForge.SFN_Multiply,id:7633,x:33152,y:32116,cmnt:The final texture color with all lights but no shadows yet,varname:node_7633,prsc:2|A-4560-OUT,B-1810-OUT;n:type:ShaderForge.SFN_Lerp,id:1553,x:33757,y:32300,cmnt:The final color with the shadows and ambient tint applied to the shadows,varname:node_1553,prsc:2|A-225-OUT,B-7633-OUT,T-3855-OUT;n:type:ShaderForge.SFN_Multiply,id:225,x:33386,y:32487,varname:node_225,prsc:2|A-5460-OUT,B-7784-OUT;n:type:ShaderForge.SFN_Blend,id:5460,x:33174,y:32408,cmnt:The color of the shadow is based entirely off the texture color and the ambient light color,varname:node_5460,prsc:2,blmd:1,clmp:False|SRC-6849-RGB,DST-4560-OUT;n:type:ShaderForge.SFN_Vector1,id:7784,x:33148,y:32583,varname:node_7784,prsc:2,v1:0.8;n:type:ShaderForge.SFN_Get,id:6213,x:33243,y:31899,varname:node_6213,prsc:2|IN-7375-OUT;n:type:ShaderForge.SFN_Max,id:5044,x:33757,y:31968,cmnt:Finds the highest input color value,varname:node_5044,prsc:2|A-3670-R,B-3670-G,C-3670-B;n:type:ShaderForge.SFN_Min,id:5979,x:33757,y:32126,cmnt:Finds how much LESS than WHITE the input color is,varname:node_5979,prsc:2|A-3670-R,B-3670-G,C-3670-B;n:type:ShaderForge.SFN_ComponentMask,id:3670,x:33458,y:31899,cmnt:The input color,varname:node_3670,prsc:2,cc1:0,cc2:1,cc3:2,cc4:-1|IN-6213-OUT;n:type:ShaderForge.SFN_Multiply,id:5826,x:33785,y:31659,cmnt:The input color multiplied by the texture color to give the input color a texture so that it doesnt look flat,varname:node_5826,prsc:2|A-4560-OUT,B-3670-OUT;n:type:ShaderForge.SFN_Multiply,id:2762,x:34115,y:31887,cmnt:Darkens the final color based on the input ccolor,varname:node_2762,prsc:2|A-1553-OUT,B-3670-OUT;n:type:ShaderForge.SFN_Lerp,id:8450,x:34125,y:31685,cmnt:Lerps towards the input color based on how much the input color is LESS than WHITE,varname:node_8450,prsc:2|A-5826-OUT,B-1553-OUT,T-5979-OUT;n:type:ShaderForge.SFN_Subtract,id:1865,x:34286,y:32033,cmnt:Finds the difference between the highest and lowest color value. This is used to detect if our iput color is simply a shade of grey and has no color,varname:node_1865,prsc:2|A-5044-OUT,B-5979-OUT;n:type:ShaderForge.SFN_Lerp,id:8202,x:34563,y:31734,varname:node_8202,prsc:2|A-2762-OUT,B-8450-OUT,T-1865-OUT;n:type:ShaderForge.SFN_Multiply,id:6871,x:34896,y:31774,varname:node_6871,prsc:2|A-8202-OUT,B-9684-OUT;n:type:ShaderForge.SFN_Clamp,id:3855,x:33347,y:32702,cmnt:This lets the user adjust te maximum shadow. A value of 0.5 will limit it to half.,varname:node_3855,prsc:2|IN-2007-OUT,MIN-7472-OUT,MAX-9078-OUT;n:type:ShaderForge.SFN_Vector1,id:9078,x:33039,y:32796,varname:node_9078,prsc:2,v1:1;n:type:ShaderForge.SFN_ValueProperty,id:6658,x:32918,y:32907,ptovrint:False,ptlb:_LushLODTreeShadowDarkness,ptin:_LushLODTreeShadowDarkness,cmnt:_LusLODSadowDarkness... this is cotrolled by the manager in its Update function,varname:node_2612,prsc:2,glob:True,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,v1:1;n:type:ShaderForge.SFN_OneMinus,id:7472,x:33117,y:32907,varname:node_7472,prsc:2|IN-6658-OUT;n:type:ShaderForge.SFN_Lerp,id:9380,x:34215,y:31239,cmnt:Lets the user adjust the tie of day correction,varname:node_9380,prsc:2|A-8309-OUT,B-8562-OUT,T-562-OUT;n:type:ShaderForge.SFN_Vector1,id:8309,x:33967,y:31255,varname:node_8309,prsc:2,v1:1;n:type:ShaderForge.SFN_ValueProperty,id:562,x:33967,y:31327,ptovrint:False,ptlb:LushLODTreeTimeOfDay,ptin:_LushLODTreeTimeOfDay,varname:node_5174,prsc:2,glob:True,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,v1:1;n:type:ShaderForge.SFN_Set,id:5422,x:31980,y:32274,varname:MainTexIN,prsc:2|IN-7736-RGB;n:type:ShaderForge.SFN_Divide,id:5489,x:31793,y:31067,varname:node_5489,prsc:2|A-1162-OUT,B-7920-OUT;n:type:ShaderForge.SFN_Vector1,id:7920,x:31529,y:31057,varname:node_7920,prsc:2,v1:1.2;n:type:ShaderForge.SFN_Color,id:6849,x:32613,y:32341,ptovrint:False,ptlb:_LushLODTreeAmbientColor,ptin:_LushLODTreeAmbientColor,cmnt:_LushLODTreeAmbientColor... this value is set in the manager,varname:_LushLODTreeAmbientColor_copy,prsc:2,glob:True,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,c1:0.5,c2:0.5,c3:0.5,c4:1;proporder:6665-5916-7736;pass:END;sub:END;*/

Shader "Hidden/LushLODTree/Tree_Leaves_Far3_Deferred" {
    Properties {
        _Color ("Color", Color) = (0.5019608,0.5019608,0.5019608,1)
        _Cutoff ("Cutoff", Range(0, 1)) = 0.7
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
            #pragma fragmentoption ARB_precision_hint_fastest
            #pragma multi_compile_shadowcaster
            #pragma multi_compile ___ UNITY_HDR_ON
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
                clip(TexAlpha - 0.5);
////// Lighting:
////// Emissive:
                float3 MainTexIN = _MainTex_var.rgb;
                float3 node_4560 = MainTexIN; // The main texture color with some modifications for things like seams blending.
                float3 LightIN = (_LushLODTreeMainLightCol.rgb*(_LushLODTreeMainLightIntensity/1.2));
                float3 LightDir = _LushLODTreeMainLightDir.rgb;
                float node_1391 = 0.5*dot(viewDirection,LightDir)+0.5; // Check if view is opposite the direction of sunlight
                float Backside_Darkening_Amount = node_1391; // Darkens the trees when viewed from the back side.
                float3 node_1553 = lerp(((_LushLODTreeAmbientColor.rgb*node_4560)*0.8),(node_4560*(LightIN+_LushLODTreeAmbientColor.rgb)),clamp(Backside_Darkening_Amount,(1.0 - _LushLODTreeShadowDarkness),1.0)); // The final color with the shadows and ambient tint applied to the shadows
                float3 Param_Color = (_Color.rgb*2.0);
                float3 node_3670 = Param_Color.rgb; // The input color
                float node_5979 = min(min(node_3670.r,node_3670.g),node_3670.b); // Finds how much LESS than WHITE the input color is
                float node_6071 = 0.0;
                float node_4685 = 0.0;
                float TimeOfDayIntensity = lerp(1.0,saturate((node_4685 + ( (saturate((dot(float3(0,1,0),LightDir)+0.25)) - node_6071) * ((1.3+(Backside_Darkening_Amount*2.0)) - node_4685) ) / (1.0 - node_6071))),_LushLODTreeTimeOfDay); // This is an optional lighting adjustment you can remove this if your scene doesnt benefit from this.
                float3 emissive = (lerp((node_1553*node_3670),lerp((node_4560*node_3670),node_1553,node_5979),(max(max(node_3670.r,node_3670.g),node_3670.b)-node_5979))*TimeOfDayIntensity);
                float3 finalColor = emissive;
                outDiffuse = half4( 0, 0, 0, 1 );
                outSpecSmoothness = half4(0,0,0,0);
                outNormal = half4( normalDirection * 0.5 + 0.5, 1 );
                outEmission = half4( (lerp((node_1553*node_3670),lerp((node_4560*node_3670),node_1553,node_5979),(max(max(node_3670.r,node_3670.g),node_3670.b)-node_5979))*TimeOfDayIntensity), 1 );
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
                clip(TexAlpha - 0.5);
////// Lighting:
////// Emissive:
                float3 MainTexIN = _MainTex_var.rgb;
                float3 node_4560 = MainTexIN; // The main texture color with some modifications for things like seams blending.
                float3 LightIN = (_LushLODTreeMainLightCol.rgb*(_LushLODTreeMainLightIntensity/1.2));
                float3 LightDir = _LushLODTreeMainLightDir.rgb;
                float node_1391 = 0.5*dot(viewDirection,LightDir)+0.5; // Check if view is opposite the direction of sunlight
                float Backside_Darkening_Amount = node_1391; // Darkens the trees when viewed from the back side.
                float3 node_1553 = lerp(((_LushLODTreeAmbientColor.rgb*node_4560)*0.8),(node_4560*(LightIN+_LushLODTreeAmbientColor.rgb)),clamp(Backside_Darkening_Amount,(1.0 - _LushLODTreeShadowDarkness),1.0)); // The final color with the shadows and ambient tint applied to the shadows
                float3 Param_Color = (_Color.rgb*2.0);
                float3 node_3670 = Param_Color.rgb; // The input color
                float node_5979 = min(min(node_3670.r,node_3670.g),node_3670.b); // Finds how much LESS than WHITE the input color is
                float node_6071 = 0.0;
                float node_4685 = 0.0;
                float TimeOfDayIntensity = lerp(1.0,saturate((node_4685 + ( (saturate((dot(float3(0,1,0),LightDir)+0.25)) - node_6071) * ((1.3+(Backside_Darkening_Amount*2.0)) - node_4685) ) / (1.0 - node_6071))),_LushLODTreeTimeOfDay); // This is an optional lighting adjustment you can remove this if your scene doesnt benefit from this.
                float3 emissive = (lerp((node_1553*node_3670),lerp((node_4560*node_3670),node_1553,node_5979),(max(max(node_3670.r,node_3670.g),node_3670.b)-node_5979))*TimeOfDayIntensity);
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
                clip(TexAlpha - 0.5);
                SHADOW_CASTER_FRAGMENT(i)
            }
            ENDCG
        }
    }
    CustomEditor "ShaderForgeMaterialInspector"
}
