// Shader created with Shader Forge v1.38 
// Shader Forge (c) Neat Corporation / Joachim Holmer - http://www.acegikmo.com/shaderforge/
// Note: Manually altering this data may prevent you from opening it in Shader Forge
/*SF_DATA;ver:1.38;sub:START;pass:START;ps:flbk:,iptp:0,cusa:False,bamd:0,cgin:,lico:0,lgpr:1,limd:0,spmd:1,trmd:0,grmd:0,uamb:True,mssp:True,bkdf:False,hqlp:False,rprd:False,enco:False,rmgx:True,imps:True,rpth:0,vtps:0,hqsc:True,nrmq:1,nrsp:0,vomd:0,spxs:False,tesm:0,olmd:1,culm:2,bsrc:0,bdst:1,dpts:6,wrdp:False,dith:0,atcv:False,rfrpo:True,rfrpn:Refraction,coma:15,ufog:False,aust:False,igpj:True,qofs:0,qpre:3,rntp:2,fgom:False,fgoc:False,fgod:False,fgor:False,fgmd:0,fgcr:0.5,fgcg:0.5,fgcb:0.5,fgca:1,fgde:0.01,fgrn:0,fgrf:300,stcl:False,atwp:False,stva:128,stmr:255,stmw:255,stcp:6,stps:0,stfa:0,stfz:0,ofsf:0,ofsu:0,f2p0:False,fnsp:True,fnfb:True,fsmp:True;n:type:ShaderForge.SFN_Final,id:9641,x:34360,y:32754,varname:node_9641,prsc:2|custl-2790-OUT,alpha-5680-A;n:type:ShaderForge.SFN_ScreenPos,id:4794,x:31814,y:33192,varname:node_4794,prsc:2,sctp:2;n:type:ShaderForge.SFN_Color,id:6372,x:32065,y:32794,ptovrint:False,ptlb:Background,ptin:_Background,cmnt:This will be set to BillboardCamera.backgroundColor,varname:node_6372,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,c1:0.5,c2:0.5,c3:0.5,c4:1;n:type:ShaderForge.SFN_Tex2d,id:5680,x:32065,y:32999,ptovrint:False,ptlb:MainTex,ptin:_MainTex,cmnt:This is the original screenshot,varname:node_5680,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,ntxv:0,isnm:False|UVIN-4794-UVOUT;n:type:ShaderForge.SFN_SceneColor,id:4538,x:32065,y:33192,cmnt:This is the blurred image,varname:node_4538,prsc:2|UVIN-4794-UVOUT;n:type:ShaderForge.SFN_Code,id:2790,x:32943,y:32827,cmnt:Dont draw the background pixels,varname:node_2790,prsc:2,code:cgBlAHQAdQByAG4AIAAoAEIAYQBjAGsAZwByAG8AdQBuAGQASQBOAC4AcgAgAD0APQAgAEMAbwBsAG8AcgBJAE4ALgByACAAJgAmACAAQgBhAGMAawBnAHIAbwB1AG4AZABJAE4ALgBnACAAPQA9ACAAQwBvAGwAbwByAEkATgAuAGcAIAAmACYAIABCAGEAYwBrAGcAcgBvAHUAbgBkAEkATgAuAGIAIAA9AD0AIABDAG8AbABvAHIASQBOAC4AYgApACAAPwAgAEIAbAB1AHIASQBOAC4AcgBnAGIAIAA6ACAAQwBvAGwAbwByAEkATgAuAHIAZwBiADsA,output:2,fname:Function_node_2790,width:1038,height:132,input:2,input:2,input:2,input_1_label:BackgroundIN,input_2_label:ColorIN,input_3_label:BlurIN|A-6372-RGB,B-5680-RGB,C-4538-RGB;proporder:6372-5680;pass:END;sub:END;*/

Shader "Hidden/LushLODTree/BackgroundClippedCopy" {
    Properties {
        _Background ("Background", Color) = (0.5,0.5,0.5,1)
        _MainTex ("MainTex", 2D) = "white" {}
        [HideInInspector]_Cutoff ("Alpha cutoff", Range(0,1)) = 0.5
    }
    SubShader {
        Tags {
            "IgnoreProjector"="True"
            "Queue"="Transparent"
            "RenderType"="Transparent"
        }
        LOD 100
        GrabPass{ }
        Pass {
            Name "FORWARD"
            Tags {
                "LightMode"="ForwardBase"
            }
            Cull Off
            ZTest Always
            ZWrite Off
            
            CGPROGRAM
            #pragma vertex vert
            #pragma fragment frag
            #define UNITY_PASS_FORWARDBASE
            #include "UnityCG.cginc"
            #pragma multi_compile_fwdbase
            #pragma target 3.0
            uniform sampler2D _GrabTexture;
            uniform float4 _Background;
            uniform sampler2D _MainTex; uniform float4 _MainTex_ST;
            float3 Function_node_2790( float3 BackgroundIN , float3 ColorIN , float3 BlurIN ){
            return (BackgroundIN.r == ColorIN.r && BackgroundIN.g == ColorIN.g && BackgroundIN.b == ColorIN.b) ? BlurIN.rgb : ColorIN.rgb;
            }
            
            struct VertexInput {
                float4 vertex : POSITION;
            };
            struct VertexOutput {
                float4 pos : SV_POSITION;
                float4 projPos : TEXCOORD0;
            };
            VertexOutput vert (VertexInput v) {
                VertexOutput o = (VertexOutput)0;
                o.pos = mul(UNITY_MATRIX_VP, v.vertex );
                o.projPos = ComputeScreenPos (o.pos);
                COMPUTE_EYEDEPTH(o.projPos.z);
                return o;
            }
            float4 frag(VertexOutput i, float facing : VFACE) : COLOR {
                float isFrontFace = ( facing >= 0 ? 1 : 0 );
                float faceSign = ( facing >= 0 ? 1 : -1 );
                float2 sceneUVs = (i.projPos.xy / i.projPos.w);
                float4 sceneColor = tex2D(_GrabTexture, sceneUVs);
////// Lighting:
                float4 _MainTex_var = tex2D(_MainTex,TRANSFORM_TEX(sceneUVs.rg, _MainTex)); // This is the original screenshot
                float3 finalColor = Function_node_2790( _Background.rgb , _MainTex_var.rgb , tex2D( _GrabTexture, sceneUVs.rg).rgb );
                return fixed4(finalColor,_MainTex_var.a);
            }
            ENDCG
        }
    }
    CustomEditor "ShaderForgeMaterialInspector"
}
