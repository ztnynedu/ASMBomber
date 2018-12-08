// Shader created with Shader Forge v1.38 
// Shader Forge (c) Neat Corporation / Joachim Holmer - http://www.acegikmo.com/shaderforge/
// Note: Manually altering this data may prevent you from opening it in Shader Forge
/*SF_DATA;ver:1.38;sub:START;pass:START;ps:flbk:,iptp:0,cusa:True,bamd:0,cgin:QwBHAEkAbgBjAGwAdQBkAGUAcwAvAEEAbgBnAHUAbABhAHIAQwBvAHIAcgBlAGMAdABpAG8AbgB8AEMARwBJAG4AYwBsAHUAZABlAHMALwBEAGkAdABoAGUAcgBpAG4AZwA=,lico:0,lgpr:1,limd:0,spmd:1,trmd:0,grmd:0,uamb:True,mssp:True,bkdf:False,hqlp:False,rprd:False,enco:False,rmgx:True,imps:True,rpth:0,vtps:0,hqsc:True,nrmq:1,nrsp:0,vomd:0,spxs:False,tesm:0,olmd:1,culm:2,bsrc:0,bdst:1,dpts:2,wrdp:True,dith:0,atcv:False,rfrpo:False,rfrpn:Refraction,coma:15,ufog:True,aust:False,igpj:False,qofs:51,qpre:2,rntp:3,fgom:False,fgoc:False,fgod:False,fgor:False,fgmd:0,fgcr:0.5,fgcg:0.5,fgcb:0.5,fgca:1,fgde:0.01,fgrn:0,fgrf:300,stcl:False,atwp:False,stva:128,stmr:255,stmw:255,stcp:6,stps:0,stfa:0,stfz:0,ofsf:0,ofsu:0,f2p0:False,fnsp:False,fnfb:True,fsmp:False;n:type:ShaderForge.SFN_Final,id:2865,x:36584,y:31697,varname:node_2865,prsc:2|custl-7126-OUT,clip-8508-OUT;n:type:ShaderForge.SFN_Color,id:6665,x:30493,y:32095,ptovrint:False,ptlb:Color,ptin:_Color,varname:_Color,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,c1:0.5019608,c2:0.5019608,c3:0.5019608,c4:1;n:type:ShaderForge.SFN_Tex2d,id:7736,x:31988,y:32180,ptovrint:False,ptlb:MainTex,ptin:_MainTex,varname:_MainTex,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,ntxv:0,isnm:False;n:type:ShaderForge.SFN_Slider,id:5916,x:30447,y:32324,ptovrint:False,ptlb:Cutoff,ptin:_Cutoff,varname:_Cutoff,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,min:0,cur:0.7,max:1;n:type:ShaderForge.SFN_ViewVector,id:628,x:30449,y:31580,varname:node_628,prsc:2;n:type:ShaderForge.SFN_Dot,id:1391,x:30655,y:31643,cmnt:Check if view is opposite the direction of sunlight,varname:node_1391,prsc:2,dt:4|A-628-OUT,B-7281-OUT;n:type:ShaderForge.SFN_Code,id:8508,x:35774,y:32415,cmnt:Shadow or Main Pass?,varname:node_8508,prsc:2,code:IwBpAGYAIABkAGUAZgBpAG4AZQBkACgAVQBOAEkAVABZAF8AUABBAFMAUwBfAFMASABBAEQATwBXAEMAQQBTAFQARQBSACkACgAJAHIAZQB0AHUAcgBuACAAUwBIAEEARABPAFcAXwBBAEwAUABIAEEAXwBDAEwASQBQADsACgAjAGUAbABzAGUACgAJAHIAZQB0AHUAcgBuACAATQBBAEkATgBfAEEATABQAEgAQQBfAEMATABJAFAAOwAKACMAZQBuAGQAaQBmAA==,output:0,fname:Check_If_Shadow_Pass2,width:340,height:128,input:0,input:0,input_1_label:SHADOW_ALPHA_CLIP,input_2_label:MAIN_ALPHA_CLIP|A-8572-OUT,B-7769-OUT;n:type:ShaderForge.SFN_Set,id:3191,x:32590,y:32286,varname:TexAlpha,prsc:2|IN-9472-OUT;n:type:ShaderForge.SFN_Set,id:7766,x:30788,y:32323,varname:Param_Cutoff,prsc:2|IN-5916-OUT;n:type:ShaderForge.SFN_Set,id:55,x:33055,y:31956,cmnt:Used to fade away billboards parallel to view,varname:Angular_Correction_MAINPASS,prsc:2|IN-2508-OUT;n:type:ShaderForge.SFN_Set,id:6838,x:31416,y:32689,varname:DITHER_MAINPASS,prsc:2|IN-3203-OUT;n:type:ShaderForge.SFN_Get,id:7769,x:35486,y:32471,varname:node_7769,prsc:2|IN-6838-OUT;n:type:ShaderForge.SFN_Set,id:6719,x:31038,y:31735,cmnt:Darkens the trees when viewed from the back side.,varname:Backside_Darkening_Amount,prsc:2|IN-1391-OUT;n:type:ShaderForge.SFN_Set,id:7375,x:30907,y:32099,varname:Param_Color,prsc:2|IN-720-OUT;n:type:ShaderForge.SFN_Get,id:8572,x:35486,y:32418,varname:node_8572,prsc:2|IN-3191-OUT;n:type:ShaderForge.SFN_Multiply,id:720,x:30705,y:32099,cmnt:Inputting 0.5 will multiply by 1 which has no effect. Less than 0.5 will darken from 0 to 1 and above 0.5 will brighten by multiplying from 1 to 2x.,varname:node_720,prsc:2|A-6665-RGB,B-221-OUT;n:type:ShaderForge.SFN_Vector1,id:221,x:30500,y:32002,varname:node_221,prsc:2,v1:2;n:type:ShaderForge.SFN_RemapRange,id:3460,x:30861,y:31696,cmnt:Rescales it to 0.7 to 1 multiplied by 0.75 which yields 0.525 to 0.75,varname:node_3460,prsc:2,frmn:-1,frmx:1,tomn:0.525,tomx:0.75|IN-1391-OUT;n:type:ShaderForge.SFN_Set,id:8909,x:32227,y:30990,varname:LightIN,prsc:2|IN-6402-OUT;n:type:ShaderForge.SFN_Vector4Property,id:7226,x:31336,y:31287,ptovrint:False,ptlb:_LushLODTreeMainLightDir,ptin:_LushLODTreeMainLightDir,cmnt:The W is set via script in _LushLODTreesManager.cs,varname:node_8259,prsc:2,glob:True,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,v1:0.5,v2:0.5,v3:0.5,v4:1;n:type:ShaderForge.SFN_Color,id:5673,x:31336,y:30991,ptovrint:False,ptlb:LushLODTreeMainLightCol,ptin:_LushLODTreeMainLightCol,cmnt:This works even with lightmaps,varname:node_349,prsc:2,glob:True,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,c1:0.5,c2:0.5,c3:0.5,c4:1;n:type:ShaderForge.SFN_ValueProperty,id:1162,x:31336,y:31172,ptovrint:False,ptlb:LushLODTreeMainLightIntensity,ptin:_LushLODTreeMainLightIntensity,cmnt:This works even with lightmaps,varname:node_5384,prsc:2,glob:True,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,v1:1;n:type:ShaderForge.SFN_Set,id:9065,x:31592,y:31288,varname:LightDir,prsc:2|IN-7226-XYZ;n:type:ShaderForge.SFN_Dot,id:8664,x:32847,y:31252,cmnt:Is the sun above the horizon?,varname:node_8664,prsc:2,dt:0|A-726-OUT,B-9695-OUT;n:type:ShaderForge.SFN_Get,id:9695,x:32614,y:31298,varname:node_9695,prsc:2|IN-9065-OUT;n:type:ShaderForge.SFN_Vector3,id:726,x:32614,y:31185,cmnt:Checks if the light is shining straight down,varname:node_726,prsc:2,v1:0,v2:1,v3:0;n:type:ShaderForge.SFN_Clamp01,id:7376,x:33411,y:31256,varname:node_7376,prsc:2|IN-6044-OUT;n:type:ShaderForge.SFN_Clamp01,id:8562,x:33875,y:31100,varname:node_8562,prsc:2|IN-7331-OUT;n:type:ShaderForge.SFN_Set,id:6950,x:34413,y:31136,cmnt:This is an optional lighting adjustment you can remove this if your scene doesnt benefit from this.,varname:TimeOfDayIntensity,prsc:2|IN-6660-OUT;n:type:ShaderForge.SFN_Add,id:6044,x:33226,y:31256,cmnt:This makes the trees not get dark until the sun is somewhat BELOW the horizon.,varname:node_6044,prsc:2|A-8664-OUT,B-1561-OUT;n:type:ShaderForge.SFN_Vector1,id:1561,x:33038,y:31290,varname:node_1561,prsc:2,v1:0.25;n:type:ShaderForge.SFN_RemapRangeAdvanced,id:7331,x:33674,y:31100,cmnt:Rescales it from 01 to about 03 to make it get brigher faster as the sun comes up. This effect is significantly stronger on the sunny side via backside darkening.,varname:node_7331,prsc:2|IN-7376-OUT,IMIN-6071-OUT,IMAX-6491-OUT,OMIN-4685-OUT,OMAX-8937-OUT;n:type:ShaderForge.SFN_Vector1,id:6071,x:33411,y:30951,varname:node_6071,prsc:2,v1:0;n:type:ShaderForge.SFN_Vector1,id:6491,x:33411,y:31000,varname:node_6491,prsc:2,v1:1;n:type:ShaderForge.SFN_Vector1,id:4685,x:33411,y:31055,varname:node_4685,prsc:2,v1:0;n:type:ShaderForge.SFN_Vector1,id:7655,x:33208,y:31011,varname:node_7655,prsc:2,v1:1.3;n:type:ShaderForge.SFN_Add,id:8937,x:33411,y:31105,varname:node_8937,prsc:2|A-7655-OUT,B-6695-OUT;n:type:ShaderForge.SFN_Get,id:7771,x:33031,y:31013,varname:node_7771,prsc:2|IN-6719-OUT;n:type:ShaderForge.SFN_Multiply,id:6695,x:33208,y:31077,varname:node_6695,prsc:2|A-7771-OUT,B-3751-OUT;n:type:ShaderForge.SFN_Vector1,id:3751,x:33031,y:31096,varname:node_3751,prsc:2,v1:2;n:type:ShaderForge.SFN_Get,id:7281,x:30449,y:31750,varname:node_7281,prsc:2|IN-9065-OUT;n:type:ShaderForge.SFN_ViewVector,id:1768,x:32113,y:31930,varname:node_1768,prsc:2;n:type:ShaderForge.SFN_ViewReflectionVector,id:660,x:32113,y:31808,varname:node_660,prsc:2;n:type:ShaderForge.SFN_Code,id:2508,x:32567,y:31871,cmnt:Note GetAngularCorrection is in AngularCorrection.cginc,varname:node_2508,prsc:2,code:cgBlAHQAdQByAG4AIABHAGUAdABBAG4AZwB1AGwAYQByAEMAbwByAHIAZQBjAHQAaQBvAG4ACgAJACgACQAKAAkACQBWAGkAZQB3AFIAZQBmACwACgAJAAkAVgBpAGUAdwBEAGkAcgBlAGMACgAJACkAOwA=,output:0,fname:GetAngularCorrection_Caller,width:338,height:134,input:2,input:2,input_1_label:ViewRef,input_2_label:ViewDirec|A-660-OUT,B-1768-OUT;n:type:ShaderForge.SFN_Code,id:9472,x:32249,y:32287,varname:node_9472,prsc:2,code:YwBsAGkAcAAoAFQAZQB4AEEAbABwAGgAYQAgAC0AIABDAHUAdABvAGYAZgApADsACgByAGUAdAB1AHIAbgAgAFQAZQB4AEEAbABwAGgAYQA7AA==,output:0,fname:ClipMe,width:247,height:112,input:0,input:0,input_1_label:TexAlpha,input_2_label:Cutoff|A-7736-A,B-9168-OUT;n:type:ShaderForge.SFN_Get,id:9168,x:31997,y:32347,varname:node_9168,prsc:2|IN-7766-OUT;n:type:ShaderForge.SFN_Code,id:3203,x:30749,y:32687,varname:node_3203,prsc:2,code:cgBlAHQAdQByAG4AIABHAGUAdABBAG4AZwB1AGwAYQByAE4AbwBUAHIAYQBuAHMAcABhAHIAZQBuAGMAeQBfAE0AQQBJAE4AUABBAFMAUwAoAFMAYwByAGUAZQBuAFAAbwBzACwAIABBAG4AZwB1AGwAYQByAEMAbwByAHIAZQBjAHQAaQBvAG4AKQA7AA==,output:0,fname:AngularNoTransparency_Caller,width:562,height:112,input:1,input:0,input_1_label:ScreenPos,input_2_label:AngularCorrection|A-2018-UVOUT,B-4564-OUT;n:type:ShaderForge.SFN_Get,id:4564,x:30433,y:32783,varname:node_4564,prsc:2|IN-55-OUT;n:type:ShaderForge.SFN_ScreenPos,id:2018,x:30454,y:32614,varname:node_2018,prsc:2,sctp:0;n:type:ShaderForge.SFN_Get,id:7407,x:33703,y:31696,cmnt:The main texture color with some modifications for things like seams blending.,varname:node_7407,prsc:2|IN-736-OUT;n:type:ShaderForge.SFN_Get,id:5356,x:33532,y:31992,cmnt:The color of the main diretional light,varname:node_5356,prsc:2|IN-8909-OUT;n:type:ShaderForge.SFN_Get,id:2175,x:33996,y:32541,cmnt:The shadows value,varname:node_2175,prsc:2|IN-6719-OUT;n:type:ShaderForge.SFN_Get,id:7907,x:35499,y:31706,varname:node_7907,prsc:2|IN-6950-OUT;n:type:ShaderForge.SFN_Add,id:3448,x:33849,y:32014,varname:node_3448,prsc:2|A-5356-OUT,B-3948-RGB;n:type:ShaderForge.SFN_Multiply,id:3954,x:34109,y:31957,cmnt:The final texture color with all lights but no shadows yet,varname:node_3954,prsc:2|A-7407-OUT,B-3448-OUT;n:type:ShaderForge.SFN_Lerp,id:9900,x:34714,y:32141,cmnt:The final color with the shadows and ambient tint applied to the shadows,varname:node_9900,prsc:2|A-7248-OUT,B-3954-OUT,T-759-OUT;n:type:ShaderForge.SFN_Multiply,id:7248,x:34343,y:32328,varname:node_7248,prsc:2|A-4593-OUT,B-3495-OUT;n:type:ShaderForge.SFN_Blend,id:4593,x:34131,y:32249,cmnt:The color of the shadow is based entirely off the texture color and the ambient light color,varname:node_4593,prsc:2,blmd:1,clmp:False|SRC-3948-RGB,DST-7407-OUT;n:type:ShaderForge.SFN_Vector1,id:3495,x:34105,y:32424,varname:node_3495,prsc:2,v1:0.8;n:type:ShaderForge.SFN_Get,id:7184,x:34200,y:31740,varname:node_7184,prsc:2|IN-7375-OUT;n:type:ShaderForge.SFN_Max,id:6001,x:34714,y:31809,cmnt:Finds the highest input color value,varname:node_6001,prsc:2|A-5519-R,B-5519-G,C-5519-B;n:type:ShaderForge.SFN_Min,id:9936,x:34714,y:31967,cmnt:Finds how much LESS than WHITE the input color is,varname:node_9936,prsc:2|A-5519-R,B-5519-G,C-5519-B;n:type:ShaderForge.SFN_ComponentMask,id:5519,x:34415,y:31740,cmnt:The input color,varname:node_5519,prsc:2,cc1:0,cc2:1,cc3:2,cc4:-1|IN-7184-OUT;n:type:ShaderForge.SFN_Multiply,id:6419,x:34742,y:31500,cmnt:The input color multiplied by the texture color to give the input color a texture so that it doesnt look flat,varname:node_6419,prsc:2|A-7407-OUT,B-5519-OUT;n:type:ShaderForge.SFN_Multiply,id:2590,x:35072,y:31728,cmnt:Darkens the final color based on the input ccolor,varname:node_2590,prsc:2|A-9900-OUT,B-5519-OUT;n:type:ShaderForge.SFN_Lerp,id:9719,x:35082,y:31526,cmnt:Lerps towards the input color based on how much the input color is LESS than WHITE,varname:node_9719,prsc:2|A-6419-OUT,B-9900-OUT,T-9936-OUT;n:type:ShaderForge.SFN_Subtract,id:4645,x:35243,y:31874,cmnt:Finds the difference between the highest and lowest color value. This is used to detect if our iput color is simply a shade of grey and has no color,varname:node_4645,prsc:2|A-6001-OUT,B-9936-OUT;n:type:ShaderForge.SFN_Lerp,id:6168,x:35520,y:31575,varname:node_6168,prsc:2|A-2590-OUT,B-9719-OUT,T-4645-OUT;n:type:ShaderForge.SFN_Multiply,id:7126,x:35853,y:31615,varname:node_7126,prsc:2|A-6168-OUT,B-7907-OUT;n:type:ShaderForge.SFN_Clamp,id:759,x:34304,y:32543,cmnt:This lets the user adjust te maximum shadow. A value of 0.5 will limit it to half.,varname:node_759,prsc:2|IN-2175-OUT,MIN-7830-OUT,MAX-9572-OUT;n:type:ShaderForge.SFN_Vector1,id:9572,x:33996,y:32637,varname:node_9572,prsc:2,v1:1;n:type:ShaderForge.SFN_ValueProperty,id:1052,x:33875,y:32748,ptovrint:False,ptlb:_LushLODTreeShadowDarkness,ptin:_LushLODTreeShadowDarkness,cmnt:_LusLODSadowDarkness... this is cotrolled by the manager in its Update function,varname:node_2612,prsc:2,glob:True,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,v1:1;n:type:ShaderForge.SFN_OneMinus,id:7830,x:34074,y:32748,varname:node_7830,prsc:2|IN-1052-OUT;n:type:ShaderForge.SFN_Lerp,id:6660,x:34184,y:31218,cmnt:Lets the user adjust the tie of day correction,varname:node_6660,prsc:2|A-8923-OUT,B-8562-OUT,T-4408-OUT;n:type:ShaderForge.SFN_ValueProperty,id:4408,x:33962,y:31315,ptovrint:False,ptlb:LushLODTreeTimeOfDay,ptin:_LushLODTreeTimeOfDay,varname:node_5174,prsc:2,glob:True,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,v1:1;n:type:ShaderForge.SFN_Vector1,id:8923,x:33962,y:31233,varname:node_8923,prsc:2,v1:1;n:type:ShaderForge.SFN_Set,id:736,x:32287,y:32181,varname:MainTexIN,prsc:2|IN-7736-RGB;n:type:ShaderForge.SFN_Multiply,id:6402,x:32020,y:30990,varname:node_6402,prsc:2|A-5673-RGB,B-31-OUT;n:type:ShaderForge.SFN_Divide,id:31,x:31807,y:31066,varname:node_31,prsc:2|A-1162-OUT,B-2401-OUT;n:type:ShaderForge.SFN_Vector1,id:2401,x:31542,y:31055,varname:node_2401,prsc:2,v1:1.2;n:type:ShaderForge.SFN_Color,id:3948,x:33553,y:32201,ptovrint:False,ptlb:_LushLODTreeAmbientColor,ptin:_LushLODTreeAmbientColor,cmnt:_LushLODTreeAmbientColor... this value is set in the manager,varname:_LushLODTreeAmbientColor_copy,prsc:2,glob:True,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,c1:0.5,c2:0.5,c3:0.5,c4:1;proporder:6665-5916-7736;pass:END;sub:END;*/

Shader "Hidden/LushLODTree/Tree_Leaves_Far3" {
    Properties {
        _Color ("Color", Color) = (0.5019608,0.5019608,0.5019608,1)
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
            #define UNITY_PASS_FORWARDBASE
            #include "UnityCG.cginc"
            #include "CGIncludes/AngularCorrection.cginc"
            #include "CGIncludes/Dithering.cginc"
            #pragma multi_compile_fwdbase_fullshadows
            #pragma multi_compile_fog
            #pragma target 3.0
            uniform float4 _Color;
            uniform sampler2D _MainTex; uniform float4 _MainTex_ST;
            uniform float _Cutoff;
            float Check_If_Shadow_Pass2( float SHADOW_ALPHA_CLIP , float MAIN_ALPHA_CLIP ){
            #if defined(UNITY_PASS_SHADOWCASTER)
            	return SHADOW_ALPHA_CLIP;
            #else
            	return MAIN_ALPHA_CLIP;
            #endif
            }
            
            uniform float4 _LushLODTreeMainLightDir;
            uniform float4 _LushLODTreeMainLightCol;
            uniform float _LushLODTreeMainLightIntensity;
            float GetAngularCorrection_Caller( float3 ViewRef , float3 ViewDirec ){
            return GetAngularCorrection
            	(	
            		ViewRef,
            		ViewDirec
            	);
            }
            
            float ClipMe( float TexAlpha , float Cutoff ){
            clip(TexAlpha - Cutoff);
            return TexAlpha;
            }
            
            float AngularNoTransparency_Caller( float2 ScreenPos , float AngularCorrection ){
            return GetAngularNoTransparency_MAINPASS(ScreenPos, AngularCorrection);
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
                float4 projPos : TEXCOORD3;
                UNITY_FOG_COORDS(4)
            };
            VertexOutput vert (VertexInput v) {
                VertexOutput o = (VertexOutput)0;
                o.uv0 = v.texcoord0;
                o.normalDir = UnityObjectToWorldNormal(v.normal);
                o.posWorld = mul(unity_ObjectToWorld, v.vertex);
                o.pos = UnityObjectToClipPos( v.vertex );
                UNITY_TRANSFER_FOG(o,o.pos);
                o.projPos = ComputeScreenPos (o.pos);
                COMPUTE_EYEDEPTH(o.projPos.z);
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
                float2 sceneUVs = (i.projPos.xy / i.projPos.w);
                float4 _MainTex_var = tex2D(_MainTex,TRANSFORM_TEX(i.uv0, _MainTex));
                float Param_Cutoff = _Cutoff;
                float TexAlpha = ClipMe( _MainTex_var.a , Param_Cutoff );
                float Angular_Correction_MAINPASS = GetAngularCorrection_Caller( viewReflectDirection , viewDirection ); // Used to fade away billboards parallel to view
                float DITHER_MAINPASS = AngularNoTransparency_Caller( (sceneUVs * 2 - 1).rg , Angular_Correction_MAINPASS );
                clip(Check_If_Shadow_Pass2( TexAlpha , DITHER_MAINPASS ) - 0.5);
////// Lighting:
                float3 MainTexIN = _MainTex_var.rgb;
                float3 node_7407 = MainTexIN; // The main texture color with some modifications for things like seams blending.
                float3 LightIN = (_LushLODTreeMainLightCol.rgb*(_LushLODTreeMainLightIntensity/1.2));
                float3 LightDir = _LushLODTreeMainLightDir.rgb;
                float node_1391 = 0.5*dot(viewDirection,LightDir)+0.5; // Check if view is opposite the direction of sunlight
                float Backside_Darkening_Amount = node_1391; // Darkens the trees when viewed from the back side.
                float3 node_9900 = lerp(((_LushLODTreeAmbientColor.rgb*node_7407)*0.8),(node_7407*(LightIN+_LushLODTreeAmbientColor.rgb)),clamp(Backside_Darkening_Amount,(1.0 - _LushLODTreeShadowDarkness),1.0)); // The final color with the shadows and ambient tint applied to the shadows
                float3 Param_Color = (_Color.rgb*2.0);
                float3 node_5519 = Param_Color.rgb; // The input color
                float node_9936 = min(min(node_5519.r,node_5519.g),node_5519.b); // Finds how much LESS than WHITE the input color is
                float node_6071 = 0.0;
                float node_4685 = 0.0;
                float TimeOfDayIntensity = lerp(1.0,saturate((node_4685 + ( (saturate((dot(float3(0,1,0),LightDir)+0.25)) - node_6071) * ((1.3+(Backside_Darkening_Amount*2.0)) - node_4685) ) / (1.0 - node_6071))),_LushLODTreeTimeOfDay); // This is an optional lighting adjustment you can remove this if your scene doesnt benefit from this.
                float3 finalColor = (lerp((node_9900*node_5519),lerp((node_7407*node_5519),node_9900,node_9936),(max(max(node_5519.r,node_5519.g),node_5519.b)-node_9936))*TimeOfDayIntensity);
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
            #include "CGIncludes/AngularCorrection.cginc"
            #include "CGIncludes/Dithering.cginc"
            #pragma fragmentoption ARB_precision_hint_fastest
            #pragma multi_compile_shadowcaster
            #pragma multi_compile_fog
            #pragma target 3.0
            uniform sampler2D _MainTex; uniform float4 _MainTex_ST;
            uniform float _Cutoff;
            float Check_If_Shadow_Pass2( float SHADOW_ALPHA_CLIP , float MAIN_ALPHA_CLIP ){
            #if defined(UNITY_PASS_SHADOWCASTER)
            	return SHADOW_ALPHA_CLIP;
            #else
            	return MAIN_ALPHA_CLIP;
            #endif
            }
            
            float GetAngularCorrection_Caller( float3 ViewRef , float3 ViewDirec ){
            return GetAngularCorrection
            	(	
            		ViewRef,
            		ViewDirec
            	);
            }
            
            float ClipMe( float TexAlpha , float Cutoff ){
            clip(TexAlpha - Cutoff);
            return TexAlpha;
            }
            
            float AngularNoTransparency_Caller( float2 ScreenPos , float AngularCorrection ){
            return GetAngularNoTransparency_MAINPASS(ScreenPos, AngularCorrection);
            }
            
            struct VertexInput {
                float4 vertex : POSITION;
                float3 normal : NORMAL;
                float2 texcoord0 : TEXCOORD0;
            };
            struct VertexOutput {
                V2F_SHADOW_CASTER;
                float2 uv0 : TEXCOORD1;
                float4 posWorld : TEXCOORD2;
                float3 normalDir : TEXCOORD3;
                float4 projPos : TEXCOORD4;
            };
            VertexOutput vert (VertexInput v) {
                VertexOutput o = (VertexOutput)0;
                o.uv0 = v.texcoord0;
                o.normalDir = UnityObjectToWorldNormal(v.normal);
                o.posWorld = mul(unity_ObjectToWorld, v.vertex);
                o.pos = UnityObjectToClipPos( v.vertex );
                o.projPos = ComputeScreenPos (o.pos);
                COMPUTE_EYEDEPTH(o.projPos.z);
                TRANSFER_SHADOW_CASTER(o)
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
                float2 sceneUVs = (i.projPos.xy / i.projPos.w);
                float4 _MainTex_var = tex2D(_MainTex,TRANSFORM_TEX(i.uv0, _MainTex));
                float Param_Cutoff = _Cutoff;
                float TexAlpha = ClipMe( _MainTex_var.a , Param_Cutoff );
                float Angular_Correction_MAINPASS = GetAngularCorrection_Caller( viewReflectDirection , viewDirection ); // Used to fade away billboards parallel to view
                float DITHER_MAINPASS = AngularNoTransparency_Caller( (sceneUVs * 2 - 1).rg , Angular_Correction_MAINPASS );
                clip(Check_If_Shadow_Pass2( TexAlpha , DITHER_MAINPASS ) - 0.5);
                SHADOW_CASTER_FRAGMENT(i)
            }
            ENDCG
        }
    }
    CustomEditor "ShaderForgeMaterialInspector"
}
