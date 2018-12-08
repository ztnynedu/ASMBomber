// Shader created with Shader Forge v1.38 
// Shader Forge (c) Neat Corporation / Joachim Holmer - http://www.acegikmo.com/shaderforge/
// Note: Manually altering this data may prevent you from opening it in Shader Forge
/*SF_DATA;ver:1.38;sub:START;pass:START;ps:flbk:,iptp:0,cusa:False,bamd:1,cgin:,lico:0,lgpr:1,limd:0,spmd:1,trmd:0,grmd:0,uamb:True,mssp:True,bkdf:False,hqlp:False,rprd:False,enco:False,rmgx:True,imps:True,rpth:0,vtps:0,hqsc:True,nrmq:1,nrsp:0,vomd:0,spxs:False,tesm:0,olmd:1,culm:2,bsrc:0,bdst:1,dpts:6,wrdp:False,dith:0,atcv:False,rfrpo:False,rfrpn:Refraction,coma:1,ufog:False,aust:False,igpj:False,qofs:0,qpre:3,rntp:0,fgom:False,fgoc:False,fgod:False,fgor:False,fgmd:0,fgcr:0.5661765,fgcg:1,fgcb:0.6589251,fgca:1,fgde:0.0015,fgrn:0,fgrf:300,stcl:False,atwp:False,stva:191,stmr:255,stmw:255,stcp:5,stps:0,stfa:0,stfz:0,ofsf:0,ofsu:0,f2p0:False,fnsp:True,fnfb:True,fsmp:True;n:type:ShaderForge.SFN_Final,id:7073,x:32849,y:32615,varname:node_7073,prsc:2|alpha-7222-A;n:type:ShaderForge.SFN_Tex2d,id:7222,x:32400,y:33109,cmnt:Alpha of the pixels comes from a saved rendertexture that we save just after my trees render before any other image effects have run.,varname:node_7222,prsc:2,ntxv:0,isnm:False|TEX-5941-TEX;n:type:ShaderForge.SFN_ScreenPos,id:6894,x:32098,y:32917,varname:node_6894,prsc:2,sctp:2;n:type:ShaderForge.SFN_Tex2dAsset,id:5941,x:32188,y:33163,ptovrint:False,ptlb:MainTex,ptin:_MainTex,varname:_MainTex,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,ntxv:0,isnm:False;n:type:ShaderForge.SFN_ScreenPos,id:260,x:32188,y:32457,varname:node_260,prsc:2,sctp:2;n:type:ShaderForge.SFN_Vector3,id:7574,x:32476,y:32823,varname:node_7574,prsc:2,v1:1,v2:1,v3:0;n:type:ShaderForge.SFN_Code,id:5755,x:31658,y:33094,varname:node_5755,prsc:2,code:IwBpAGYAIABVAE4ASQBUAFkAXwBVAFYAXwBTAFQAQQBSAFQAUwBfAEEAVABfAFQATwBQAA0ACgByAGUAdAB1AHIAbgAgAGYAbABvAGEAdAAyACgAcwBjAHIAZQBlAG4AUABvAHMALgB4ACwAIAAxAC0AcwBjAHIAZQBlAG4AUABvAHMALgB5ACkAOwAKACMAZQBsAHMAZQANAAoAcgBlAHQAdQByAG4AIABmAGwAbwBhAHQAMgAoAHMAYwByAGUAZQBuAFAAbwBzAC4AeAAsACAAcwBjAHIAZQBlAG4AUABvAHMALgB5ACkAOwAKACMAZQBuAGQAaQBmAA==,output:1,fname:GimmeScreenSpaceUV_MAINPASS,width:445,height:148,input:1,input_1_label:screenPos|A-7240-UVOUT;n:type:ShaderForge.SFN_ScreenPos,id:7240,x:31368,y:33081,varname:node_7240,prsc:2,sctp:2;n:type:ShaderForge.SFN_SceneColor,id:1420,x:32386,y:32575,cmnt:Color of the pixels comes from AFTER other transparent objects andor other post processing effects have finished.,varname:node_1420,prsc:2;n:type:ShaderForge.SFN_Vector1,id:1405,x:32476,y:32933,varname:node_1405,prsc:2,v1:1;proporder:5941;pass:END;sub:END;*/

Shader "Hidden/LushLODTree/ReapplySavedAlphaChannel_OnPostRender" {
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
            ColorMask A
            
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
                float2 texcoord0 : TEXCOORD0;
            };
            struct VertexOutput {
                float4 pos : SV_POSITION;
                float2 uv0 : TEXCOORD0;
            };
            VertexOutput vert (VertexInput v) {
                VertexOutput o = (VertexOutput)0;
                o.uv0 = v.texcoord0;
                o.pos = mul(UNITY_MATRIX_VP, v.vertex );
                return o;
            }
            float4 frag(VertexOutput i, float facing : VFACE) : COLOR {
                float isFrontFace = ( facing >= 0 ? 1 : 0 );
                float faceSign = ( facing >= 0 ? 1 : -1 );
////// Lighting:
                float3 finalColor = 0;
                float4 node_7222 = tex2D(_MainTex,TRANSFORM_TEX(i.uv0, _MainTex)); // Alpha of the pixels comes from a saved rendertexture that we save just after my trees render before any other image effects have run.
                return fixed4(finalColor,node_7222.a);
            }
            ENDCG
        }
    }
    CustomEditor "ShaderForgeMaterialInspector"
}
