// Shader created with Shader Forge v1.38 
// Shader Forge (c) Neat Corporation / Joachim Holmer - http://www.acegikmo.com/shaderforge/
// Note: Manually altering this data may prevent you from opening it in Shader Forge
/*SF_DATA;ver:1.38;sub:START;pass:START;ps:flbk:,iptp:0,cusa:True,bamd:0,cgin:,lico:0,lgpr:1,limd:0,spmd:1,trmd:0,grmd:0,uamb:True,mssp:True,bkdf:False,hqlp:False,rprd:False,enco:False,rmgx:True,imps:True,rpth:0,vtps:0,hqsc:True,nrmq:1,nrsp:0,vomd:0,spxs:False,tesm:0,olmd:1,culm:2,bsrc:0,bdst:1,dpts:2,wrdp:False,dith:0,atcv:False,rfrpo:False,rfrpn:Refraction,coma:15,ufog:False,aust:False,igpj:False,qofs:0,qpre:4,rntp:0,fgom:False,fgoc:False,fgod:False,fgor:False,fgmd:0,fgcr:0.5,fgcg:0.5,fgcb:0.5,fgca:1,fgde:0.01,fgrn:0,fgrf:300,stcl:False,atwp:False,stva:191,stmr:255,stmw:255,stcp:6,stps:2,stfa:0,stfz:0,ofsf:0,ofsu:0,f2p0:False,fnsp:True,fnfb:True,fsmp:False;n:type:ShaderForge.SFN_Final,id:2865,x:32232,y:31905,varname:node_2865,prsc:2|custl-1983-OUT;n:type:ShaderForge.SFN_Set,id:7710,x:31724,y:32240,varname:ViewReflection,prsc:2|IN-3908-XYZ;n:type:ShaderForge.SFN_Get,id:1983,x:31992,y:32139,varname:node_1983,prsc:2|IN-9193-OUT;n:type:ShaderForge.SFN_Vector4Property,id:3908,x:31503,y:32240,ptovrint:False,ptlb:_ViewReflec,ptin:_ViewReflec,varname:node_3908,prsc:2,glob:True,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,v1:0.5,v2:0.5,v3:0.5,v4:1;n:type:ShaderForge.SFN_Set,id:2554,x:31724,y:32050,varname:ViewDirection,prsc:2|IN-4512-XYZ;n:type:ShaderForge.SFN_Vector4Property,id:4512,x:31503,y:32050,ptovrint:False,ptlb:_ViewDirec,ptin:_ViewDirec,varname:node_4512,prsc:2,glob:True,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,v1:0.5,v2:0.5,v3:0.5,v4:1;n:type:ShaderForge.SFN_Set,id:9193,x:31017,y:32206,cmnt:Used to fade away billboards parallel to view,varname:AngularCorrection,prsc:2|IN-6151-OUT;n:type:ShaderForge.SFN_Dot,id:2480,x:29553,y:32144,cmnt:Checks if a face is permendicular to the camera,varname:node_2480,prsc:2,dt:0|A-4537-OUT,B-5732-OUT;n:type:ShaderForge.SFN_Smoothstep,id:9220,x:30116,y:32202,varname:node_9220,prsc:2|A-9747-OUT,B-7872-OUT,V-2480-OUT;n:type:ShaderForge.SFN_Vector1,id:7872,x:30023,y:32105,varname:node_7872,prsc:2,v1:1;n:type:ShaderForge.SFN_Vector1,id:9747,x:30023,y:32346,varname:node_9747,prsc:2,v1:-1.4;n:type:ShaderForge.SFN_Vector1,id:1142,x:30460,y:32108,varname:node_1142,prsc:2,v1:-0.3;n:type:ShaderForge.SFN_Add,id:1957,x:30535,y:32202,varname:node_1957,prsc:2|A-8377-OUT,B-1142-OUT;n:type:ShaderForge.SFN_Multiply,id:8377,x:30324,y:32202,varname:node_8377,prsc:2|A-9220-OUT,B-6748-OUT;n:type:ShaderForge.SFN_Vector1,id:6748,x:30268,y:32088,cmnt:These variables tweak the exact angle of the correction,varname:node_6748,prsc:2,v1:6;n:type:ShaderForge.SFN_Clamp01,id:6151,x:30760,y:32202,varname:node_6151,prsc:2|IN-1957-OUT;n:type:ShaderForge.SFN_Get,id:5732,x:29292,y:32319,varname:node_5732,prsc:2|IN-2554-OUT;n:type:ShaderForge.SFN_Get,id:4537,x:29292,y:32098,varname:node_4537,prsc:2|IN-7710-OUT;pass:END;sub:END;*/

Shader "Hidden/LushLODTree/AngularCorrection" {
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
            uniform float4 _ViewReflec;
            uniform float4 _ViewDirec;
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
                float3 ViewReflection = _ViewReflec.rgb;
                float3 ViewDirection = _ViewDirec.rgb;
                float AngularCorrection = saturate(((smoothstep( (-1.4), 1.0, dot(ViewReflection,ViewDirection) )*6.0)+(-0.3))); // Used to fade away billboards parallel to view
                float node_1983 = AngularCorrection;
                float3 finalColor = float3(node_1983,node_1983,node_1983);
                return fixed4(finalColor,1);
            }
            ENDCG
        }
    }
    CustomEditor "ShaderForgeMaterialInspector"
}
