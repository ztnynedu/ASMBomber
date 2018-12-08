// Shader created with Shader Forge v1.38 
// Shader Forge (c) Neat Corporation / Joachim Holmer - http://www.acegikmo.com/shaderforge/
// Note: Manually altering this data may prevent you from opening it in Shader Forge
/*SF_DATA;ver:1.38;sub:START;pass:START;ps:flbk:,iptp:0,cusa:False,bamd:1,cgin:,lico:0,lgpr:1,limd:0,spmd:1,trmd:0,grmd:0,uamb:True,mssp:True,bkdf:False,hqlp:False,rprd:False,enco:False,rmgx:True,imps:True,rpth:0,vtps:0,hqsc:True,nrmq:1,nrsp:0,vomd:0,spxs:False,tesm:0,olmd:1,culm:2,bsrc:0,bdst:1,dpts:6,wrdp:False,dith:0,atcv:False,rfrpo:False,rfrpn:Refraction,coma:15,ufog:False,aust:False,igpj:False,qofs:0,qpre:3,rntp:0,fgom:False,fgoc:False,fgod:False,fgor:False,fgmd:0,fgcr:0.5657439,fgcg:0.6941743,fgcb:0.8014706,fgca:1,fgde:0.01,fgrn:0,fgrf:300,stcl:True,atwp:False,stva:191,stmr:255,stmw:255,stcp:5,stps:0,stfa:0,stfz:0,ofsf:0,ofsu:0,f2p0:False,fnsp:True,fnfb:True,fsmp:True;n:type:ShaderForge.SFN_Final,id:7073,x:32830,y:32850,varname:node_7073,prsc:2|custl-7222-RGB,alpha-748-OUT;n:type:ShaderForge.SFN_Tex2d,id:7222,x:32398,y:32941,varname:node_7222,prsc:2,ntxv:0,isnm:False|UVIN-6894-UVOUT,TEX-5941-TEX;n:type:ShaderForge.SFN_Vector1,id:748,x:32398,y:33078,varname:node_748,prsc:2,v1:1;n:type:ShaderForge.SFN_ScreenPos,id:6894,x:32186,y:32816,varname:node_6894,prsc:2,sctp:2;n:type:ShaderForge.SFN_Tex2dAsset,id:5941,x:31858,y:33190,ptovrint:False,ptlb:MainTex,ptin:_MainTex,varname:node_5941,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,ntxv:0,isnm:False;n:type:ShaderForge.SFN_Tex2dAsset,id:6994,x:32019,y:33011,ptovrint:False,ptlb:_LushLODOriginalPixels,ptin:_LushLODOriginalPixels,varname:node_6994,glob:True,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,ntxv:0,isnm:False;n:type:ShaderForge.SFN_Vector3,id:1826,x:32245,y:33109,varname:node_1826,prsc:2,v1:1,v2:0,v3:0;n:type:ShaderForge.SFN_Vector4,id:3619,x:32515,y:33248,varname:node_3619,prsc:2,v1:0,v2:0,v3:0,v4:0;proporder:5941;pass:END;sub:END;*/

Shader "Hidden/LushLODTree/MakeNonStencilPixelsOpaque" {
    Properties {
        _MainTex ("MainTex", 2D) = "white" {}
        [HideInInspector]_Cutoff ("Alpha cutoff", Range(0,1)) = 0.5
    }
    SubShader {
        Tags {
            "Queue"="Transparent"
            "DisableBatching"="True"
        }
        LOD 100
        Pass {
            Name "FORWARD"
            Tags {
                "LightMode"="ForwardBase"
            }
            Cull Off
            ZTest Always
            ZWrite Off
            
            Stencil {
                Ref 191
                Comp NotEqual
            }
            CGPROGRAM
            #pragma vertex vert
            #pragma fragment frag
            #define UNITY_PASS_FORWARDBASE
            #include "UnityCG.cginc"
            #pragma multi_compile_fwdbase_fullshadows
            #pragma target 3.0
            uniform sampler2D _MainTex; uniform float4 _MainTex_ST;
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
////// Lighting:
                float4 node_7222 = tex2D(_MainTex,TRANSFORM_TEX(sceneUVs.rg, _MainTex));
                float3 finalColor = node_7222.rgb;
                return fixed4(finalColor,1.0);
            }
            ENDCG
        }
    }
    CustomEditor "ShaderForgeMaterialInspector"
}
