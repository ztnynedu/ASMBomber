// Shader created with Shader Forge v1.38 
// Shader Forge (c) Neat Corporation / Joachim Holmer - http://www.acegikmo.com/shaderforge/
// Note: Manually altering this data may prevent you from opening it in Shader Forge
/*SF_DATA;ver:1.38;sub:START;pass:START;ps:flbk:,iptp:0,cusa:True,bamd:0,cgin:,lico:0,lgpr:1,limd:0,spmd:1,trmd:0,grmd:0,uamb:True,mssp:True,bkdf:False,hqlp:False,rprd:False,enco:False,rmgx:True,imps:True,rpth:0,vtps:0,hqsc:True,nrmq:1,nrsp:0,vomd:0,spxs:False,tesm:0,olmd:1,culm:2,bsrc:0,bdst:1,dpts:2,wrdp:False,dith:0,atcv:False,rfrpo:False,rfrpn:Refraction,coma:15,ufog:False,aust:False,igpj:False,qofs:0,qpre:4,rntp:0,fgom:False,fgoc:False,fgod:False,fgor:False,fgmd:0,fgcr:0.5,fgcg:0.5,fgcb:0.5,fgca:1,fgde:0.01,fgrn:0,fgrf:300,stcl:False,atwp:False,stva:191,stmr:255,stmw:255,stcp:6,stps:2,stfa:0,stfz:0,ofsf:0,ofsu:0,f2p0:False,fnsp:True,fnfb:True,fsmp:False;n:type:ShaderForge.SFN_Final,id:2865,x:32232,y:31905,varname:node_2865,prsc:2|custl-1983-OUT;n:type:ShaderForge.SFN_Set,id:9204,x:31754,y:32039,varname:UV1_IN,prsc:2|IN-8134-OUT;n:type:ShaderForge.SFN_Set,id:7710,x:31040,y:32122,varname:BiTanDir,prsc:2|IN-3908-XYZ;n:type:ShaderForge.SFN_Get,id:1983,x:31992,y:32139,varname:node_1983,prsc:2|IN-9193-OUT;n:type:ShaderForge.SFN_Vector4Property,id:3908,x:30819,y:32122,ptovrint:False,ptlb:_BiTanDirIN,ptin:_BiTanDirIN,varname:node_3908,prsc:2,glob:True,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,v1:0.5,v2:0.5,v3:0.5,v4:1;n:type:ShaderForge.SFN_Set,id:2554,x:31040,y:31932,varname:TanDir,prsc:2|IN-4512-XYZ;n:type:ShaderForge.SFN_Vector4Property,id:1064,x:30815,y:32326,ptovrint:False,ptlb:_WorldPosIN,ptin:_WorldPosIN,varname:_BiTanDir_copy_copy,prsc:2,glob:True,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,v1:0.5,v2:0.5,v3:0.5,v4:1;n:type:ShaderForge.SFN_Set,id:853,x:31036,y:32326,varname:WorldPos,prsc:2|IN-1064-XYZ;n:type:ShaderForge.SFN_Vector4Property,id:4512,x:30819,y:31932,ptovrint:False,ptlb:TanDirIN,ptin:_TanDirIN,varname:node_4512,prsc:2,glob:True,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,v1:0.5,v2:0.5,v3:0.5,v4:1;n:type:ShaderForge.SFN_Set,id:9193,x:30491,y:32323,varname:WorldPosCenter,prsc:2|IN-6042-OUT;n:type:ShaderForge.SFN_Code,id:3551,x:27208,y:32019,varname:node_3551,prsc:2,code:VABoAGUAIABjAG8AZABlACAAdABvACAAdABoAGUAIAByAGkAZwBoAHQAIABjAGEAbABjAHUAbABhAHQAZQBzACAAdABoAGUACgB3AG8AcgBsAGQAIABzAHAAYQBjAGUAIABwAG8AcwBpAHQAaQBvAG4AIABvAGYAIAB0AGgAZQAgAGMAZQBuAHQAZQByAAoAcwBwAG8AdAAgAHcAaABlAHIAZQAgAGEAbABsACAAdABoAHIAZQBlACAAcABsAGEAbgBlAHMAIABvAGYAIAB0AGgAZQAKAGIAaQBsAGwAYgBvAGEAcgBkACAAaQBuAHQAZQByAHMAZQBjAHQALgAgAFQAaABpAHMAIABpAHMAIABjAG8AbQBwAGwAZQB4ACwACgBhAG4AZAAgAGEAIABiAGUAdAB0AGUAcgAgAGQAZQBzAGMAcgBpAHAAdABpAG8AbgAgAGkAcwAgAHAAcgBvAGIAYQBiAGwAeQAKAHcAcgBpAHQAdABlAG4AIABpAG4AIAB0AGgAZQAgAGMAbwBtAG0AZQBuAHQAcwAgAGkAbgAgAAoATAB1AHMAaABMAE8ARABUAHIAZQBlAEMAbwBuAHYAZQByAHQAZQByAC4AYwBzAAoACgBUAGgAZQByAGUAIABhAHIAZQAgAG0AdQBjAGgAIABlAGEAcwBpAGUAcgAgAHcAYQB5AHMAIAB0AG8AIABkAG8AIAB0AGgAaQBzAAoAYwBhAGwAYwB1AGwAYQB0AGkAbwBuACAAaQBmACAAeQBvAHUAIAB1AHMAZQAgAHQAaABlACAAbwBiAGoAZQBjAHQAJwBzAAoAcABvAHMAaQB0AGkAbwBuACAAYQBzACAAdABoAGUAIABzAHQAYQByAHQAaQBuAGcAIABwAG8AaQBuAHQAIABvAGYACgB5AG8AdQByACAAYwBhAGwAYwB1AGwAYQB0AGkAbwBuAC4AIABIAG8AdwBlAHYAZQByACwAIAB0AGgAYQB0ACAAdwBvAG4AJwB0AAoAdwBvAHIAawAgAGkAZgAgAHQAaABlACAAbwBiAGoAZQBjAHQAIABpAHMAIABiAGEAdABjAGgAZQBkAC4ACgAKAFQAaABpAHMAIABtAGUAdABoAG8AZAAgAHcAbwByAGsAcwAgAGUAdgBlAG4AIABpAGYAIAB0AGgAZQAgAG8AYgBqAGUAYwB0AAoAaQBzACAAYgBhAHQAYwBoAGUAZAAgAGEAbgBkAC8AbwByACAAcgBvAHQAYQB0AGUAZAAuACAASQB0ACAAYQBsAHMAbwAKAHUAcwBlAHMAIABvAG4AbAB5ACAAVQBWADIAIAB0AG8AIABoAG8AbABkACAANAAgAGYAbABvAGEAdABzAC4AIAA6ACkACgBUAG8AIABzAGUAZQAgAGgAbwB3ACAAaQB0ACAAZgBpAHQAcwAgADQAIABmAGwAbwBhAHQAcwAgAGkAbgB0AG8AIABVAFYAMgAsAAoAcwBlAGUAIAB0AGgAZQAgAGMAbwBtAG0AZQBuAHQAcwAgAG8AbgAgAFUAVgAyACAAdwByAGkAdAB0AGUAbgAgAGkAbgAKACAATAB1AHMAaABMAE8ARABUAHIAZQBlAEMAbwBuAHYAZQByAHQAZQByAC4AYwBzAA==,output:2,fname:CenterPointCalculator,width:311,height:300;n:type:ShaderForge.SFN_Trunc,id:6594,x:28076,y:31979,varname:node_6594,prsc:2|IN-7020-R;n:type:ShaderForge.SFN_Divide,id:2938,x:28379,y:31961,cmnt:This is UVCenter X,varname:node_2938,prsc:2|A-6594-OUT,B-4995-OUT;n:type:ShaderForge.SFN_Vector1,id:4995,x:27914,y:31897,cmnt:See UV2 comments in LushLODTreeConverter.cs,varname:node_4995,prsc:2,v1:1000;n:type:ShaderForge.SFN_Subtract,id:1504,x:28379,y:32111,cmnt:This is UVCenter Y,varname:node_1504,prsc:2|A-7020-R,B-6594-OUT;n:type:ShaderForge.SFN_Trunc,id:3029,x:28076,y:32288,varname:node_3029,prsc:2|IN-7020-G;n:type:ShaderForge.SFN_Divide,id:2725,x:28379,y:32407,cmnt:This is UV to WORLD Ratio X,varname:node_2725,prsc:2|A-3029-OUT,B-9966-OUT;n:type:ShaderForge.SFN_Vector1,id:9966,x:27900,y:32455,cmnt:See UV2 comments in LushLODTreeConverter.cs,varname:node_9966,prsc:2,v1:10000;n:type:ShaderForge.SFN_Subtract,id:139,x:28379,y:32260,cmnt:This is UV to WORLD Ratio Y,varname:node_139,prsc:2|A-7020-G,B-3029-OUT;n:type:ShaderForge.SFN_Append,id:2758,x:28658,y:31964,cmnt:UVCenter,varname:node_2758,prsc:2|A-2938-OUT,B-1504-OUT;n:type:ShaderForge.SFN_Subtract,id:8941,x:28883,y:31864,cmnt:Angle and distance from current UV to UVCenter,varname:node_8941,prsc:2|A-8853-OUT,B-2758-OUT;n:type:ShaderForge.SFN_ComponentMask,id:5723,x:29061,y:31884,varname:node_5723,prsc:2,cc1:0,cc2:1,cc3:-1,cc4:-1|IN-8941-OUT;n:type:ShaderForge.SFN_Divide,id:8824,x:29427,y:31947,cmnt:Converts the UV distance to World Distance,varname:node_8824,prsc:2|A-5723-R,B-2725-OUT;n:type:ShaderForge.SFN_Divide,id:1162,x:29426,y:32241,cmnt:Converts the UV distance to World Distance,varname:node_1162,prsc:2|A-5723-G,B-139-OUT;n:type:ShaderForge.SFN_Multiply,id:4465,x:29693,y:32304,cmnt:Our custom tangent direction points towards UV.y,varname:node_4465,prsc:2|A-1162-OUT,B-9433-OUT;n:type:ShaderForge.SFN_Multiply,id:7646,x:29694,y:31977,cmnt:Our custom bitangent direction points towards UV.x,varname:node_7646,prsc:2|A-8824-OUT,B-1993-OUT;n:type:ShaderForge.SFN_Add,id:7113,x:30209,y:31984,cmnt:Add distance toward BITANGENT which is UVx,varname:node_7113,prsc:2|A-6101-OUT,B-7646-OUT;n:type:ShaderForge.SFN_Add,id:6042,x:30235,y:32291,cmnt:Add distance toward TANGENT which is UVy,varname:node_6042,prsc:2|A-7113-OUT,B-4465-OUT;n:type:ShaderForge.SFN_Get,id:1993,x:29405,y:32104,varname:node_1993,prsc:2|IN-7710-OUT;n:type:ShaderForge.SFN_Vector4Property,id:9134,x:31299,y:32018,ptovrint:False,ptlb:UV1,ptin:_UV1,varname:node_9134,prsc:2,glob:True,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,v1:0.5,v2:0.5,v3:0.5,v4:1;n:type:ShaderForge.SFN_Append,id:8134,x:31539,y:32039,varname:node_8134,prsc:2|A-9134-X,B-9134-Y;n:type:ShaderForge.SFN_Get,id:130,x:27637,y:32126,varname:node_130,prsc:2|IN-9204-OUT;n:type:ShaderForge.SFN_ComponentMask,id:7020,x:27859,y:32126,varname:node_7020,prsc:2,cc1:0,cc2:1,cc3:-1,cc4:-1|IN-130-OUT;n:type:ShaderForge.SFN_Set,id:2217,x:31754,y:32230,varname:UV0_IN,prsc:2|IN-8992-OUT;n:type:ShaderForge.SFN_Append,id:8992,x:31539,y:32230,varname:node_8992,prsc:2|A-9031-X,B-9031-Y;n:type:ShaderForge.SFN_Vector4Property,id:9031,x:31299,y:32208,ptovrint:False,ptlb:_UV0,ptin:_UV0,varname:node_9031,prsc:2,glob:True,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,v1:0.5,v2:0.5,v3:0.5,v4:1;n:type:ShaderForge.SFN_Get,id:8853,x:28637,y:31829,varname:node_8853,prsc:2|IN-2217-OUT;n:type:ShaderForge.SFN_Get,id:9433,x:29405,y:32401,varname:node_9433,prsc:2|IN-2554-OUT;n:type:ShaderForge.SFN_Get,id:6101,x:29802,y:31802,cmnt:Position of this pixel that the shader is working on.,varname:node_6101,prsc:2|IN-853-OUT;pass:END;sub:END;*/

Shader "Hidden/LushLODTree/WorldPositionCenter" {
    Properties {
    }
    SubShader {
        Tags {
            "Queue"="Overlay"
            "CanUseSpriteAtlas"="True"
        }
        Pass {
            Name "FORWARD"
            Tags {
                "LightMode"="ForwardBase"
            }
            Cull Off
            ZWrite Off
            
            CGPROGRAM
            #pragma vertex vert
            #pragma fragment frag
            #define UNITY_PASS_FORWARDBASE
            #include "UnityCG.cginc"
            #pragma multi_compile_fwdbase_fullshadows
            #pragma target 3.0
            uniform float4 _BiTanDirIN;
            uniform float4 _WorldPosIN;
            uniform float4 _TanDirIN;
            uniform float4 _UV1;
            uniform float4 _UV0;
            struct VertexInput {
                float4 vertex : POSITION;
            };
            struct VertexOutput {
                float4 pos : SV_POSITION;
            };
            VertexOutput vert (VertexInput v) {
                VertexOutput o = (VertexOutput)0;
                o.pos = UnityObjectToClipPos( v.vertex );
                return o;
            }
            float4 frag(VertexOutput i, float facing : VFACE) : COLOR {
                float isFrontFace = ( facing >= 0 ? 1 : 0 );
                float faceSign = ( facing >= 0 ? 1 : -1 );
////// Lighting:
                float3 WorldPos = _WorldPosIN.rgb;
                float2 UV0_IN = float2(_UV0.r,_UV0.g);
                float2 UV1_IN = float2(_UV1.r,_UV1.g);
                float2 node_7020 = UV1_IN.rg;
                float node_6594 = trunc(node_7020.r);
                float2 node_5723 = (UV0_IN-float2((node_6594/1000.0),(node_7020.r-node_6594))).rg;
                float node_3029 = trunc(node_7020.g);
                float3 BiTanDir = _BiTanDirIN.rgb;
                float3 TanDir = _TanDirIN.rgb;
                float3 WorldPosCenter = ((WorldPos+((node_5723.r/(node_3029/10000.0))*BiTanDir))+((node_5723.g/(node_7020.g-node_3029))*TanDir));
                float3 finalColor = WorldPosCenter;
                return fixed4(finalColor,1);
            }
            ENDCG
        }
    }
    CustomEditor "ShaderForgeMaterialInspector"
}
