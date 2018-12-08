// Shader created with Shader Forge v1.38 
// Shader Forge (c) Neat Corporation / Joachim Holmer - http://www.acegikmo.com/shaderforge/
// Note: Manually altering this data may prevent you from opening it in Shader Forge
/*SF_DATA;ver:1.38;sub:START;pass:START;ps:flbk:,iptp:0,cusa:False,bamd:0,cgin:,lico:0,lgpr:1,limd:3,spmd:0,trmd:0,grmd:0,uamb:True,mssp:True,bkdf:False,hqlp:False,rprd:False,enco:False,rmgx:True,imps:True,rpth:1,vtps:0,hqsc:True,nrmq:1,nrsp:0,vomd:0,spxs:False,tesm:0,olmd:1,culm:0,bsrc:0,bdst:1,dpts:2,wrdp:True,dith:0,atcv:False,rfrpo:False,rfrpn:Refraction,coma:15,ufog:True,aust:True,igpj:False,qofs:0,qpre:2,rntp:3,fgom:False,fgoc:False,fgod:False,fgor:False,fgmd:0,fgcr:0.5657439,fgcg:0.6941743,fgcb:0.8014706,fgca:1,fgde:0.01,fgrn:0,fgrf:300,stcl:False,atwp:False,stva:128,stmr:255,stmw:255,stcp:6,stps:2,stfa:0,stfz:0,ofsf:0,ofsu:0,f2p0:False,fnsp:False,fnfb:True,fsmp:False;n:type:ShaderForge.SFN_Final,id:8808,x:32719,y:32712,varname:node_8808,prsc:2|diff-2371-OUT,spec-64-OUT,amdfl-8011-RGB,clip-6252-OUT;n:type:ShaderForge.SFN_Slider,id:7344,x:30676,y:32755,ptovrint:False,ptlb:Transparency,ptin:_Transparency,varname:_Transparency,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,min:0,cur:0,max:1;n:type:ShaderForge.SFN_Tex2d,id:3166,x:30699,y:32412,ptovrint:False,ptlb:MainTex,ptin:_MainTex,varname:_MainTex,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,ntxv:0,isnm:False;n:type:ShaderForge.SFN_Set,id:970,x:31017,y:32646,varname:Param_Cutoff,prsc:2|IN-2469-OUT;n:type:ShaderForge.SFN_Slider,id:2469,x:30676,y:32647,ptovrint:False,ptlb:Cutoff,ptin:_Cutoff,varname:_Cutoff,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,min:0,cur:0.7,max:1;n:type:ShaderForge.SFN_Set,id:9043,x:31017,y:32748,varname:Param_Transparency,prsc:2|IN-7344-OUT;n:type:ShaderForge.SFN_Color,id:6756,x:31342,y:32507,ptovrint:False,ptlb:Color,ptin:_Color,varname:_Color,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,c1:1,c2:1,c3:1,c4:1;n:type:ShaderForge.SFN_Multiply,id:2758,x:31804,y:32345,varname:node_2758,prsc:2|A-3166-RGB,B-6756-RGB;n:type:ShaderForge.SFN_Code,id:4362,x:30896,y:33103,varname:node_4362,prsc:2,code:ZgBsAG8AYQB0ADQAeAA0ACAAbQB0AHgAIAA9ACAAZgBsAG8AYQB0ADQAeAA0ACgACgAJAGYAbABvAGEAdAA0ACgAMQAsACAAOQAsACAAMwAsACAAMQAxACkAIAAvACAAMQA3AC4AMAAsAAoACQBmAGwAbwBhAHQANAAoADEAMwAsACAANQAsACAAMQA1ACwAIAA3ACkAIAAvACAAMQA3AC4AMAAsAAoACQBmAGwAbwBhAHQANAAoADQALAAgADEAMgAsACAAMgAsACAAMQAwACkAIAAvACAAMQA3AC4AMAAsAAoACQBmAGwAbwBhAHQANAAoADEANgAsACAAOAAsACAAMQA0ACwAIAA2ACkAIAAvACAAMQA3AC4AMAAKACkAOwAKAGYAbABvAGEAdAAyACAAcAB4ACAAPQAgAGYAbABvAG8AcgAoAF8AUwBjAHIAZQBlAG4AUABhAHIAYQBtAHMALgB4AHkAIAAqACAAcwBjAHIAZQBlAG4AVQBWAHMAKQA7AAoAaQBuAHQAIAB4AFMAbQBwACAAPQAgAGYAbQBvAGQAKABwAHgALgB4ACwAIAA0ACkAOwAKAGkAbgB0ACAAeQBTAG0AcAAgAD0AIABmAG0AbwBkACgAcAB4AC4AeQAsACAANAApADsACgBmAGwAbwBhAHQANAAgAHgAVgBlAGMAIAA9ACAAMQAgAC0AIABzAGEAdAB1AHIAYQB0AGUAKABhAGIAcwAoAGYAbABvAGEAdAA0ACgAMAAsACAAMQAsACAAMgAsACAAMwApACAALQAgAHgAUwBtAHAAKQApADsACgBmAGwAbwBhAHQANAAgAHkAVgBlAGMAIAA9ACAAMQAgAC0AIABzAGEAdAB1AHIAYQB0AGUAKABhAGIAcwAoAGYAbABvAGEAdAA0ACgAMAAsACAAMQAsACAAMgAsACAAMwApACAALQAgAHkAUwBtAHAAKQApADsACgBmAGwAbwBhAHQANAAgAHAAeABNAHUAbAB0ACAAPQAgAGYAbABvAGEAdAA0ACgAZABvAHQAKABtAHQAeABbADAAXQAsACAAeQBWAGUAYwApACwAIABkAG8AdAAoAG0AdAB4AFsAMQBdACwAIAB5AFYAZQBjACkALAAgAGQAbwB0ACgAbQB0AHgAWwAyAF0ALAAgAHkAVgBlAGMAKQAsACAAZABvAHQAKABtAHQAeABbADMAXQAsACAAeQBWAGUAYwApACkAOwAKAHIAZQB0AHUAcgBuACAAZABvAHQAKABwAHgATQB1AGwAdAAsACAAeABWAGUAYwApADsA,output:0,fname:BinaryDither4x4_FOR_MAIN_PASS,width:760,height:213,input:1,input_1_label:screenUVs|A-6672-OUT;n:type:ShaderForge.SFN_Code,id:6672,x:30341,y:33102,varname:node_6672,prsc:2,code:IwBpAGYAIABVAE4ASQBUAFkAXwBVAFYAXwBTAFQAQQBSAFQAUwBfAEEAVABfAFQATwBQAA0ACgAJAGYAbABvAGEAdAAgAGcAcgBhAGIAUwBpAGcAbgAgAD0AIAAtAF8AUAByAG8AagBlAGMAdABpAG8AbgBQAGEAcgBhAG0AcwAuAHgAOwANAAoAIwBlAGwAcwBlAA0ACgAJAGYAbABvAGEAdAAgAGcAcgBhAGIAUwBpAGcAbgAgAD0AIABfAFAAcgBvAGoAZQBjAHQAaQBvAG4AUABhAHIAYQBtAHMALgB4ADsADQAKACMAZQBuAGQAaQBmAAoAcgBlAHQAdQByAG4AIABmAGwAbwBhAHQAMgAoADEALAAgAGcAcgBhAGIAUwBpAGcAbgApACoAcwBjAHIAZQBlAG4AUABvAHMALgB4AHkAKgAwAC4AMAAxADUAIAArACAAMAAuADAAMQA1ADsA,output:1,fname:GimmeScreenSpaceUV_MAINPASS,width:445,height:148,input:1,input_1_label:screenPos|A-6709-UVOUT;n:type:ShaderForge.SFN_ScreenPos,id:8908,x:30051,y:33089,varname:node_8908,prsc:2,sctp:0;n:type:ShaderForge.SFN_Code,id:6252,x:32053,y:33091,varname:node_6252,prsc:2,code:ZgBsAG8AYQB0ACAAQwBvAHMAZQByAHAAXwBSAGUAcwB1AGwAdAAgAD0AIAAoADEALgAwACAALQAgAGMAbwBzACgAKAB0AHIAYQBuAHMAKgAzAC4AMQA0ADEANQA5ADIANgA1ADQAKgAwAC4ANQApACkAKQA7ACAALwAvADwALQAtACAAcwBhAG0AZQAgAHQAaABpAG4AZwAgAGEAcwAgAE0AYQB0AGgAZgAuAEMAbwBzAGUAcgBwACgAKQAsACAAcwBlAGUAIABHAG8AbwBnAGwAZQAuACAAVABoAGkAcwAgAGgAZQBsAHAAcwAgAGYAYQBkAGUAIABpAG4AIAB0AGgAZQAgAGwAZQBhAHYAZQBzACAAbQBvAHIAZQAgAGcAcgBhAGQAdQBhAGwAbAB5ACAAYQB0ACAAZgBpAHIAcwB0ACwAIABpAG4AcwB0AGUAYQBkACAAbwBmACAAdABoAGUAbQAgAGEAcABwAGUAYQByAGkAbgBnACAAcwBvACAAcwB1AGQAZABlAG4AbAB5AC4ADQAKAGYAbABvAGEAdAAgAHIAZQBzAGMAYQBsAGUAZAAgAD0AIABsAGUAcgBwACgAMAAuADAANQA4ADgALAAgADEALgAwACwAIABDAG8AcwBlAHIAcABfAFIAZQBzAHUAbAB0ACkAOwAgAC8ALwA8AC0ALQAgAHIAZQBzAGMAYQBsAGUAcwAgAHQAaABlACAAdAByAGEAbgBzAGkAdABpAG8AbgAgAHQAbwAgAHIAYQBuAGcAZQAgAGYAcgBvAG0AIAAwAC4AMAA1ADgAOAAgAHQAbwAgADEALAAgAGkAbgBzAHQAZQBhAGQAIABvAGYAIABmAHIAbwBtACAAMAAgAHQAbwAgADEALAAgAHQAbwAgAHQAcgBpAG0AIABhACAAbABpAHQAdABsAGUAIAB3AGEAcwB0AGUAZAAgAGMAdQByAHYAZQAgAHMAcABhAGMAZQAgAG8AZgBmACAAdABoAGUAIABiAGUAZwBpAG4AbgBpAG4AZwAsACAAdABvACAAZQBuAHMAdQByAGUAIAB0AGgAYQB0ACAAdABoAGUAIABsAGUAYQB2AGUAcwAgAGIAZQBnAGkAbgAgAHQAbwAgAGEAcABwAGUAYQByACAAYQBzACAAcwBvAG8AbgAgAGEAcwAgAF8AVAByAGEAbgBzAHAAYQByAGUAbgBjAHkAIABpAHMAIABlAHYAZQBuACAAcwBsAGkAZwBoAHQAbAB5ACAAYQBiAG8AdgBlACAAegBlAHIAbwAgACgAbwB0AGgAZQByAHcAaQBzAGUAIAB0AGgAZQB5ACAAZABvAG4AJwB0ACAAZQB2AGUAbgAgAHMAdABhAHIAdAAgAHQAbwAgAGEAcABwAGUAYQByACAAdQBuAHQAaQBsACAAXwBUAHIAYQBuAHMAcABhAHIAZQBuAGMAeQAgAGkAcwAgAG4AZQBhAHIAbAB5ACAAMAAuADIAIQApAC4AIABFAEQASQBUADoAIAA5ADkAIAB3AG8AcgBrAHMAIABiAGUAdAB0AGUAcgAgAHQAaABhAG4AIAAxAC4ALgAuACAAaQB0ACAAZQBuAHMAdQByAGUAcwAgAGkAdAAgAGUAbgBkAHMAIAB1AHAAIABmAHUAbABsAHkAIABvAHAAYQBxAHUAZQAgAHcAaQB0AGgAIABuAG8AIABkAGkAdABoAGUAcgBpAG4AZwAgAHMAdABpAGwAbAAgAGwAaQBuAGcAZQByAGkAbgBnAC4ADQAKAGYAbABvAGEAdAAgAGQAaQB0AGgAZQByACAAPQAgAG0AYQB0AHIAaQB4AEkATgAgACsAIAAoAHIAZQBzAGMAYQBsAGUAZAAgAC0AIAAxAC4ANQApADsAIAAvAC8APAAtAC0AIABjAGEAbABjAHUAbABhAHQAZQBzACAAdABoAGUAIABkAGkAdABoAGUAcgBpAG4AZwAuAAoAcgBlAHQAdQByAG4AIABkAGkAdABoAGUAcgAgACsAIAAxAC4AMAA7AA==,output:0,fname:Dither_FOR_MAIN_PASS,width:505,height:128,input:0,input:0,input:0,input_1_label:matrixIN,input_2_label:cut_off,input_3_label:trans|A-4362-OUT,B-5765-OUT,C-671-OUT;n:type:ShaderForge.SFN_Get,id:671,x:31833,y:33202,varname:node_671,prsc:2|IN-9043-OUT;n:type:ShaderForge.SFN_Get,id:5765,x:31833,y:33148,varname:node_5765,prsc:2|IN-970-OUT;n:type:ShaderForge.SFN_TexCoord,id:6709,x:29982,y:32933,varname:node_6709,prsc:2,uv:0,uaff:False;n:type:ShaderForge.SFN_Vector1,id:64,x:32459,y:32812,varname:node_64,prsc:2,v1:0;n:type:ShaderForge.SFN_Get,id:1439,x:32108,y:32489,varname:node_1439,prsc:2|IN-1663-OUT;n:type:ShaderForge.SFN_Multiply,id:2371,x:32373,y:32432,cmnt:Applies the time of day,varname:node_2371,prsc:2|A-2758-OUT,B-1439-OUT;n:type:ShaderForge.SFN_Vector3,id:4088,x:31133,y:31245,cmnt:Checks if the light is shining straight down,varname:node_4088,prsc:2,v1:0,v2:1,v3:0;n:type:ShaderForge.SFN_Get,id:1879,x:31133,y:31361,varname:node_1879,prsc:2|IN-9393-OUT;n:type:ShaderForge.SFN_Dot,id:3909,x:31370,y:31291,cmnt:Is ths sun above the horizon?,varname:node_3909,prsc:2,dt:0|A-4088-OUT,B-1879-OUT;n:type:ShaderForge.SFN_Vector1,id:9595,x:31558,y:31344,varname:node_9595,prsc:2,v1:0.25;n:type:ShaderForge.SFN_Add,id:9053,x:31740,y:31290,cmnt:This makes the trees not get dark  until the sun is somewhat BELOW the horizon,varname:node_9053,prsc:2|A-3909-OUT,B-9595-OUT;n:type:ShaderForge.SFN_Clamp01,id:4981,x:31941,y:31290,varname:node_4981,prsc:2|IN-9053-OUT;n:type:ShaderForge.SFN_Multiply,id:1186,x:31723,y:31073,varname:node_1186,prsc:2|A-9361-OUT,B-3182-OUT;n:type:ShaderForge.SFN_Vector1,id:3182,x:31541,y:31097,varname:node_3182,prsc:2,v1:2;n:type:ShaderForge.SFN_Get,id:9361,x:31520,y:30992,varname:node_9361,prsc:2|IN-9187-OUT;n:type:ShaderForge.SFN_Vector1,id:7875,x:31723,y:31012,varname:node_7875,prsc:2,v1:1.3;n:type:ShaderForge.SFN_Add,id:248,x:31941,y:31094,varname:node_248,prsc:2|A-7875-OUT,B-1186-OUT;n:type:ShaderForge.SFN_Vector1,id:8205,x:31941,y:31038,varname:node_8205,prsc:2,v1:0;n:type:ShaderForge.SFN_Vector1,id:6777,x:31941,y:30979,varname:node_6777,prsc:2,v1:1;n:type:ShaderForge.SFN_Vector1,id:8555,x:31941,y:30919,varname:node_8555,prsc:2,v1:0;n:type:ShaderForge.SFN_RemapRangeAdvanced,id:8382,x:32203,y:31082,cmnt:Rescales it from 01 to about 03 to make it get brighter faster as the sun comes up. This effect is significantly stronger on the sunyn side via backside darkening.,varname:node_8382,prsc:2|IN-4981-OUT,IMIN-8555-OUT,IMAX-6777-OUT,OMIN-8205-OUT,OMAX-248-OUT;n:type:ShaderForge.SFN_Clamp01,id:4847,x:32401,y:31082,varname:node_4847,prsc:2|IN-8382-OUT;n:type:ShaderForge.SFN_Set,id:1663,x:32997,y:31130,cmnt:This is an optional lighting adjustment you can remove this if your scene doesnt benefit from this,varname:TimeOfDayIntensity,prsc:2|IN-6515-OUT;n:type:ShaderForge.SFN_ViewVector,id:6496,x:30857,y:31585,varname:node_6496,prsc:2;n:type:ShaderForge.SFN_Get,id:3872,x:30857,y:31722,varname:node_3872,prsc:2|IN-9393-OUT;n:type:ShaderForge.SFN_Dot,id:9994,x:31070,y:31676,cmnt:Check if view is opposite the direction of sunlight,varname:node_9994,prsc:2,dt:4|A-6496-OUT,B-3872-OUT;n:type:ShaderForge.SFN_RemapRange,id:3931,x:31247,y:31712,cmnt:Rescales it to 0.7 to 1 multiplied by 0.75 which yields 0.525 to 0.75,varname:node_3931,prsc:2,frmn:-1,frmx:1,tomn:0.525,tomx:0.75|IN-9994-OUT;n:type:ShaderForge.SFN_Set,id:9187,x:31451,y:31742,cmnt:This value ranges from 0 to 0.2,varname:BacksideDarkening,prsc:2|IN-9994-OUT;n:type:ShaderForge.SFN_Vector4Property,id:765,x:30779,y:31017,ptovrint:False,ptlb:_LushLODTreeMainLightDir,ptin:_LushLODTreeMainLightDir,cmnt:The W is set via script in _LushLODTreesManager.cs,varname:node_8259,prsc:2,glob:True,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,v1:0.5,v2:0.5,v3:0.5,v4:1;n:type:ShaderForge.SFN_Set,id:9393,x:31004,y:31017,varname:LightDir,prsc:2|IN-765-XYZ;n:type:ShaderForge.SFN_Color,id:8011,x:32053,y:32914,ptovrint:False,ptlb:_LushLODTreeAmbientColor,ptin:_LushLODTreeAmbientColor,cmnt:_LushLODTreeAmbientColor... this value is set in the manager,varname:_LushLODTreeAmbientColor_copy,prsc:2,glob:True,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,c1:0.5,c2:0.5,c3:0.5,c4:1;n:type:ShaderForge.SFN_Lerp,id:6515,x:32738,y:31226,cmnt:Lets the user adjust the tie of day correction,varname:node_6515,prsc:2|A-2013-OUT,B-4847-OUT,T-3271-OUT;n:type:ShaderForge.SFN_Vector1,id:2013,x:32491,y:31226,varname:node_2013,prsc:2,v1:1;n:type:ShaderForge.SFN_ValueProperty,id:3271,x:32491,y:31298,ptovrint:False,ptlb:LushLODTreeTimeOfDay,ptin:_LushLODTreeTimeOfDay,varname:node_5174,prsc:2,glob:True,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,v1:1;proporder:7344-3166-2469-6756;pass:END;sub:END;*/

Shader "Hidden/LushLODTree/HQTreeBark_Deferred" {
    Properties {
        _Transparency ("Transparency", Range(0, 1)) = 0
        _MainTex ("MainTex", 2D) = "white" {}
        _Cutoff ("Cutoff", Range(0, 1)) = 0.7
        _Color ("Color", Color) = (1,1,1,1)
        [HideInInspector]_Cutoff ("Alpha cutoff", Range(0,1)) = 0.5
    }
    SubShader {
        Tags {
            "Queue"="AlphaTest"
            "RenderType"="TransparentCutout"
        }
        LOD 100
        Pass {
            Name "DEFERRED"
            Tags {
                "LightMode"="Deferred"
            }
            
            
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
            return float2(1, grabSign)*screenPos.xy*0.015 + 0.015;
            }
            
            float Dither_FOR_MAIN_PASS( float matrixIN , float cut_off , float trans ){
            float Coserp_Result = (1.0 - cos((trans*3.141592654*0.5))); //<-- same thing as Mathf.Coserp(), see Google. This helps fade in the leaves more gradually at first, instead of them appearing so suddenly.
            float rescaled = lerp(0.0588, 1.0, Coserp_Result); //<-- rescales the transition to range from 0.0588 to 1, instead of from 0 to 1, to trim a little wasted curve space off the beginning, to ensure that the leaves begin to appear as soon as _Transparency is even slightly above zero (otherwise they don't even start to appear until _Transparency is nearly 0.2!). EDIT: 99 works better than 1... it ensures it ends up fully opaque with no dithering still lingering.
            float dither = matrixIN + (rescaled - 1.5); //<-- calculates the dithering.
            return dither + 1.0;
            }
            
            uniform float4 _LushLODTreeMainLightDir;
            uniform float4 _LushLODTreeAmbientColor;
            uniform float _LushLODTreeTimeOfDay;
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
                out half4 outEmission : SV_Target3 )
            {
                i.normalDir = normalize(i.normalDir);
                float3 viewDirection = normalize(_WorldSpaceCameraPos.xyz - i.posWorld.xyz);
                float3 normalDirection = i.normalDir;
                float3 viewReflectDirection = reflect( -viewDirection, normalDirection );
                float Param_Cutoff = _Cutoff;
                float Param_Transparency = _Transparency;
                clip(Dither_FOR_MAIN_PASS( BinaryDither4x4_FOR_MAIN_PASS( GimmeScreenSpaceUV_MAINPASS( i.uv0 ) ) , Param_Cutoff , Param_Transparency ) - 0.5);
////// Lighting:
                float Pi = 3.141592654;
                float InvPi = 0.31830988618;
///////// Gloss:
                float gloss = 0.5;
                float perceptualRoughness = 1.0 - 0.5;
                float roughness = perceptualRoughness * perceptualRoughness;
/////// GI Data:
                UnityLight light; // Dummy light
                light.color = 0;
                light.dir = half3(0,1,0);
                light.ndotl = max(0,dot(normalDirection,light.dir));
                UnityGIInput d;
                d.light = light;
                d.worldPos = i.posWorld.xyz;
                d.worldViewDir = viewDirection;
                d.atten = 1;
                Unity_GlossyEnvironmentData ugls_en_data;
                ugls_en_data.roughness = 1.0 - gloss;
                ugls_en_data.reflUVW = viewReflectDirection;
                UnityGI gi = UnityGlobalIllumination(d, 1, normalDirection, ugls_en_data );
////// Specular:
                float node_64 = 0.0;
                float3 specularColor = float3(node_64,node_64,node_64);
                float specularMonochrome;
                float4 _MainTex_var = tex2D(_MainTex,TRANSFORM_TEX(i.uv0, _MainTex));
                float3 LightDir = _LushLODTreeMainLightDir.rgb;
                float node_8555 = 0.0;
                float node_8205 = 0.0;
                float node_9994 = 0.5*dot(viewDirection,LightDir)+0.5; // Check if view is opposite the direction of sunlight
                float BacksideDarkening = node_9994; // This value ranges from 0 to 0.2
                float TimeOfDayIntensity = lerp(1.0,saturate((node_8205 + ( (saturate((dot(float3(0,1,0),LightDir)+0.25)) - node_8555) * ((1.3+(BacksideDarkening*2.0)) - node_8205) ) / (1.0 - node_8555))),_LushLODTreeTimeOfDay); // This is an optional lighting adjustment you can remove this if your scene doesnt benefit from this
                float3 diffuseColor = ((_MainTex_var.rgb*_Color.rgb)*TimeOfDayIntensity); // Need this for specular when using metallic
                diffuseColor = EnergyConservationBetweenDiffuseAndSpecular(diffuseColor, specularColor, specularMonochrome);
                specularMonochrome = 1.0-specularMonochrome;
                float NdotV = max(0.0,dot( normalDirection, viewDirection ));
/////// Diffuse:
                float3 indirectDiffuse = float3(0,0,0);
                indirectDiffuse += _LushLODTreeAmbientColor.rgb; // Diffuse Ambient Light
                diffuseColor *= 1-specularMonochrome;
/// Final Color:
                outDiffuse = half4( diffuseColor, 1 );
                outSpecSmoothness = half4( specularColor, 0.5 );
                outNormal = half4( normalDirection * 0.5 + 0.5, 1 );
                outEmission = half4(0,0,0,1);
                outEmission.rgb += indirectDiffuse * diffuseColor;
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
            
            
            CGPROGRAM
            #pragma vertex vert
            #pragma fragment frag
            #define UNITY_PASS_FORWARDBASE
            #include "UnityCG.cginc"
            #include "AutoLight.cginc"
            #include "UnityPBSLighting.cginc"
            #include "UnityStandardBRDF.cginc"
            #pragma multi_compile_fwdbase_fullshadows
            #pragma multi_compile_fog
            #pragma target 3.0
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
            return float2(1, grabSign)*screenPos.xy*0.015 + 0.015;
            }
            
            float Dither_FOR_MAIN_PASS( float matrixIN , float cut_off , float trans ){
            float Coserp_Result = (1.0 - cos((trans*3.141592654*0.5))); //<-- same thing as Mathf.Coserp(), see Google. This helps fade in the leaves more gradually at first, instead of them appearing so suddenly.
            float rescaled = lerp(0.0588, 1.0, Coserp_Result); //<-- rescales the transition to range from 0.0588 to 1, instead of from 0 to 1, to trim a little wasted curve space off the beginning, to ensure that the leaves begin to appear as soon as _Transparency is even slightly above zero (otherwise they don't even start to appear until _Transparency is nearly 0.2!). EDIT: 99 works better than 1... it ensures it ends up fully opaque with no dithering still lingering.
            float dither = matrixIN + (rescaled - 1.5); //<-- calculates the dithering.
            return dither + 1.0;
            }
            
            uniform float4 _LushLODTreeMainLightDir;
            uniform float4 _LushLODTreeAmbientColor;
            uniform float _LushLODTreeTimeOfDay;
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
                LIGHTING_COORDS(3,4)
                UNITY_FOG_COORDS(5)
            };
            VertexOutput vert (VertexInput v) {
                VertexOutput o = (VertexOutput)0;
                o.uv0 = v.texcoord0;
                o.normalDir = UnityObjectToWorldNormal(v.normal);
                o.posWorld = mul(unity_ObjectToWorld, v.vertex);
                float3 lightColor = _LightColor0.rgb;
                o.pos = UnityObjectToClipPos( v.vertex );
                UNITY_TRANSFER_FOG(o,o.pos);
                TRANSFER_VERTEX_TO_FRAGMENT(o)
                return o;
            }
            float4 frag(VertexOutput i) : COLOR {
                i.normalDir = normalize(i.normalDir);
                float3 viewDirection = normalize(_WorldSpaceCameraPos.xyz - i.posWorld.xyz);
                float3 normalDirection = i.normalDir;
                float3 viewReflectDirection = reflect( -viewDirection, normalDirection );
                float Param_Cutoff = _Cutoff;
                float Param_Transparency = _Transparency;
                clip(Dither_FOR_MAIN_PASS( BinaryDither4x4_FOR_MAIN_PASS( GimmeScreenSpaceUV_MAINPASS( i.uv0 ) ) , Param_Cutoff , Param_Transparency ) - 0.5);
                float3 lightDirection = normalize(_WorldSpaceLightPos0.xyz);
                float3 lightColor = _LightColor0.rgb;
                float3 halfDirection = normalize(viewDirection+lightDirection);
////// Lighting:
                float attenuation = LIGHT_ATTENUATION(i);
                float3 attenColor = attenuation * _LightColor0.xyz;
                float Pi = 3.141592654;
                float InvPi = 0.31830988618;
///////// Gloss:
                float gloss = 0.5;
                float perceptualRoughness = 1.0 - 0.5;
                float roughness = perceptualRoughness * perceptualRoughness;
                float specPow = exp2( gloss * 10.0 + 1.0 );
/////// GI Data:
                UnityLight light;
                #ifdef LIGHTMAP_OFF
                    light.color = lightColor;
                    light.dir = lightDirection;
                    light.ndotl = LambertTerm (normalDirection, light.dir);
                #else
                    light.color = half3(0.f, 0.f, 0.f);
                    light.ndotl = 0.0f;
                    light.dir = half3(0.f, 0.f, 0.f);
                #endif
                UnityGIInput d;
                d.light = light;
                d.worldPos = i.posWorld.xyz;
                d.worldViewDir = viewDirection;
                d.atten = attenuation;
                Unity_GlossyEnvironmentData ugls_en_data;
                ugls_en_data.roughness = 1.0 - gloss;
                ugls_en_data.reflUVW = viewReflectDirection;
                UnityGI gi = UnityGlobalIllumination(d, 1, normalDirection, ugls_en_data );
                lightDirection = gi.light.dir;
                lightColor = gi.light.color;
////// Specular:
                float NdotL = saturate(dot( normalDirection, lightDirection ));
                float LdotH = saturate(dot(lightDirection, halfDirection));
                float node_64 = 0.0;
                float3 specularColor = float3(node_64,node_64,node_64);
                float specularMonochrome;
                float4 _MainTex_var = tex2D(_MainTex,TRANSFORM_TEX(i.uv0, _MainTex));
                float3 LightDir = _LushLODTreeMainLightDir.rgb;
                float node_8555 = 0.0;
                float node_8205 = 0.0;
                float node_9994 = 0.5*dot(viewDirection,LightDir)+0.5; // Check if view is opposite the direction of sunlight
                float BacksideDarkening = node_9994; // This value ranges from 0 to 0.2
                float TimeOfDayIntensity = lerp(1.0,saturate((node_8205 + ( (saturate((dot(float3(0,1,0),LightDir)+0.25)) - node_8555) * ((1.3+(BacksideDarkening*2.0)) - node_8205) ) / (1.0 - node_8555))),_LushLODTreeTimeOfDay); // This is an optional lighting adjustment you can remove this if your scene doesnt benefit from this
                float3 diffuseColor = ((_MainTex_var.rgb*_Color.rgb)*TimeOfDayIntensity); // Need this for specular when using metallic
                diffuseColor = EnergyConservationBetweenDiffuseAndSpecular(diffuseColor, specularColor, specularMonochrome);
                specularMonochrome = 1.0-specularMonochrome;
                float NdotV = abs(dot( normalDirection, viewDirection ));
                float NdotH = saturate(dot( normalDirection, halfDirection ));
                float VdotH = saturate(dot( viewDirection, halfDirection ));
                float visTerm = SmithJointGGXVisibilityTerm( NdotL, NdotV, roughness );
                float normTerm = GGXTerm(NdotH, roughness);
                float specularPBL = (visTerm*normTerm) * UNITY_PI;
                #ifdef UNITY_COLORSPACE_GAMMA
                    specularPBL = sqrt(max(1e-4h, specularPBL));
                #endif
                specularPBL = max(0, specularPBL * NdotL);
                #if defined(_SPECULARHIGHLIGHTS_OFF)
                    specularPBL = 0.0;
                #endif
                specularPBL *= any(specularColor) ? 1.0 : 0.0;
                float3 directSpecular = attenColor*specularPBL*FresnelTerm(specularColor, LdotH);
                float3 specular = directSpecular;
/////// Diffuse:
                NdotL = max(0.0,dot( normalDirection, lightDirection ));
                half fd90 = 0.5 + 2 * LdotH * LdotH * (1-gloss);
                float nlPow5 = Pow5(1-NdotL);
                float nvPow5 = Pow5(1-NdotV);
                float3 directDiffuse = ((1 +(fd90 - 1)*nlPow5) * (1 + (fd90 - 1)*nvPow5) * NdotL) * attenColor;
                float3 indirectDiffuse = float3(0,0,0);
                indirectDiffuse += UNITY_LIGHTMODEL_AMBIENT.rgb; // Ambient Light
                indirectDiffuse += _LushLODTreeAmbientColor.rgb; // Diffuse Ambient Light
                diffuseColor *= 1-specularMonochrome;
                float3 diffuse = (directDiffuse + indirectDiffuse) * diffuseColor;
/// Final Color:
                float3 finalColor = diffuse + specular;
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
            #define UNITY_PASS_SHADOWCASTER
            #include "UnityCG.cginc"
            #include "Lighting.cginc"
            #include "UnityPBSLighting.cginc"
            #include "UnityStandardBRDF.cginc"
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
            return float2(1, grabSign)*screenPos.xy*0.015 + 0.015;
            }
            
            float Dither_FOR_MAIN_PASS( float matrixIN , float cut_off , float trans ){
            float Coserp_Result = (1.0 - cos((trans*3.141592654*0.5))); //<-- same thing as Mathf.Coserp(), see Google. This helps fade in the leaves more gradually at first, instead of them appearing so suddenly.
            float rescaled = lerp(0.0588, 1.0, Coserp_Result); //<-- rescales the transition to range from 0.0588 to 1, instead of from 0 to 1, to trim a little wasted curve space off the beginning, to ensure that the leaves begin to appear as soon as _Transparency is even slightly above zero (otherwise they don't even start to appear until _Transparency is nearly 0.2!). EDIT: 99 works better than 1... it ensures it ends up fully opaque with no dithering still lingering.
            float dither = matrixIN + (rescaled - 1.5); //<-- calculates the dithering.
            return dither + 1.0;
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
            float4 frag(VertexOutput i) : COLOR {
                float Param_Cutoff = _Cutoff;
                float Param_Transparency = _Transparency;
                clip(Dither_FOR_MAIN_PASS( BinaryDither4x4_FOR_MAIN_PASS( GimmeScreenSpaceUV_MAINPASS( i.uv0 ) ) , Param_Cutoff , Param_Transparency ) - 0.5);
                SHADOW_CASTER_FRAGMENT(i)
            }
            ENDCG
        }
    }
    CustomEditor "ShaderForgeMaterialInspector"
}
