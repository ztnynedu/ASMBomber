// Shader created with Shader Forge v1.38 
// Shader Forge (c) Neat Corporation / Joachim Holmer - http://www.acegikmo.com/shaderforge/
// Note: Manually altering this data may prevent you from opening it in Shader Forge
/*SF_DATA;ver:1.38;sub:START;pass:START;ps:flbk:,iptp:0,cusa:True,bamd:0,cgin:QwBHAEkAbgBjAGwAdQBkAGUAcwAvAEQAaQB0AGgAZQByAGkAbgBnAA==,lico:0,lgpr:1,limd:3,spmd:1,trmd:0,grmd:0,uamb:True,mssp:True,bkdf:False,hqlp:False,rprd:False,enco:False,rmgx:True,imps:True,rpth:1,vtps:0,hqsc:True,nrmq:1,nrsp:0,vomd:0,spxs:False,tesm:0,olmd:1,culm:2,bsrc:0,bdst:1,dpts:2,wrdp:True,dith:0,atcv:False,rfrpo:False,rfrpn:Refraction,coma:15,ufog:True,aust:True,igpj:False,qofs:0,qpre:2,rntp:3,fgom:False,fgoc:False,fgod:False,fgor:False,fgmd:0,fgcr:0.5,fgcg:0.5,fgcb:0.5,fgca:1,fgde:0.01,fgrn:0,fgrf:300,stcl:False,atwp:False,stva:128,stmr:255,stmw:255,stcp:6,stps:0,stfa:0,stfz:0,ofsf:0,ofsu:0,f2p0:False,fnsp:False,fnfb:True,fsmp:False;n:type:ShaderForge.SFN_Final,id:2865,x:37103,y:31250,varname:node_2865,prsc:2|emission-9440-OUT,clip-1861-OUT;n:type:ShaderForge.SFN_Color,id:6665,x:32826,y:31887,ptovrint:False,ptlb:Color,ptin:_Color,varname:_Color,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,c1:0.5,c2:0.5,c3:0.5,c4:1;n:type:ShaderForge.SFN_Tex2d,id:7736,x:34167,y:31025,ptovrint:False,ptlb:MainTex,ptin:_MainTex,varname:_MainTex,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,ntxv:0,isnm:False;n:type:ShaderForge.SFN_Slider,id:5916,x:32780,y:32116,ptovrint:False,ptlb:Cutoff,ptin:_Cutoff,varname:_Cutoff,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,min:0,cur:0.7,max:1;n:type:ShaderForge.SFN_Set,id:3191,x:34483,y:31264,varname:TexAlpha,prsc:2|IN-8433-OUT;n:type:ShaderForge.SFN_Set,id:7766,x:33121,y:32115,varname:Param_Cutoff,prsc:2|IN-5916-OUT;n:type:ShaderForge.SFN_Set,id:7375,x:33218,y:31887,varname:Param_Color,prsc:2|IN-5134-OUT;n:type:ShaderForge.SFN_ViewVector,id:161,x:33218,y:31517,varname:node_161,prsc:2;n:type:ShaderForge.SFN_Dot,id:9680,x:33424,y:31580,cmnt:Check if view is opposite the direction of sunlight,varname:node_9680,prsc:2,dt:4|A-161-OUT,B-1900-OUT;n:type:ShaderForge.SFN_Set,id:8421,x:33807,y:31654,cmnt:Darkens the trees when viewed from the back side.,varname:BacksideDarkening,prsc:2|IN-9680-OUT;n:type:ShaderForge.SFN_Multiply,id:5134,x:33039,y:31887,cmnt:Inputting 0.5 will multiply by 1 which has no effect. Less than 0.5 will darken from 0 to 1 and above 0.5 will brighten by multiplying from 1 to 2x.,varname:node_5134,prsc:2|A-6665-RGB,B-4317-OUT;n:type:ShaderForge.SFN_Vector1,id:4317,x:32834,y:31790,varname:node_4317,prsc:2,v1:2;n:type:ShaderForge.SFN_RemapRange,id:1317,x:33618,y:31610,cmnt:Rescales it to 0.7 to 1 multiplied by 0.75 which yields 0.525 to 0.75,varname:node_1317,prsc:2,frmn:-1,frmx:1,tomn:0.525,tomx:0.75|IN-9680-OUT;n:type:ShaderForge.SFN_Set,id:1610,x:33465,y:31002,varname:LightIN,prsc:2|IN-3561-OUT;n:type:ShaderForge.SFN_Vector4Property,id:53,x:32544,y:31301,ptovrint:False,ptlb:_LushLODTreeMainLightDir,ptin:_LushLODTreeMainLightDir,cmnt:The W is set via script in _LushLODTreesManager.cs,varname:node_8259,prsc:2,glob:True,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,v1:0.5,v2:0.5,v3:0.5,v4:1;n:type:ShaderForge.SFN_Color,id:1033,x:32522,y:30998,ptovrint:False,ptlb:LushLODTreeMainLightCol,ptin:_LushLODTreeMainLightCol,cmnt:This works even with lightmaps,varname:node_349,prsc:2,glob:True,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,c1:0.5,c2:0.5,c3:0.5,c4:1;n:type:ShaderForge.SFN_ValueProperty,id:135,x:32522,y:31179,ptovrint:False,ptlb:LushLODTreeMainLightIntensity,ptin:_LushLODTreeMainLightIntensity,cmnt:This works even with lightmaps,varname:node_5384,prsc:2,glob:True,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,v1:1;n:type:ShaderForge.SFN_Set,id:544,x:32765,y:31317,varname:LightDir,prsc:2|IN-53-XYZ;n:type:ShaderForge.SFN_Get,id:1900,x:33218,y:31652,varname:node_1900,prsc:2|IN-544-OUT;n:type:ShaderForge.SFN_Code,id:8433,x:34149,y:31267,varname:node_8433,prsc:2,code:YwBsAGkAcAAoAFQAZQB4AEEAbABwAGgAYQAgAC0AIABDAHUAdABvAGYAZgApADsACgByAGUAdAB1AHIAbgAgAFQAZQB4AEEAbABwAGgAYQA7AA==,output:0,fname:ClipMe,width:247,height:112,input:0,input:0,input_1_label:TexAlpha,input_2_label:Cutoff|A-7736-A,B-5785-OUT;n:type:ShaderForge.SFN_Get,id:5785,x:33859,y:31174,varname:node_5785,prsc:2|IN-7766-OUT;n:type:ShaderForge.SFN_Code,id:1861,x:35706,y:32004,varname:node_1861,prsc:2,code:cgBlAHQAdQByAG4AIABHAGUAdABUAGUAeABBAGwAcABoAGEAVAByAGkAbQBtAGUAZABfAEIATwBUAEgAUABBAFMAUwAoAFQAZQB4AEEAbABwAGgAYQApADsA,output:0,fname:GetTexAlphaTrimmed_Caller,width:382,height:112,input:0,input_1_label:TexAlpha|A-5406-OUT;n:type:ShaderForge.SFN_Get,id:5406,x:35430,y:32005,varname:node_5406,prsc:2|IN-3191-OUT;n:type:ShaderForge.SFN_Multiply,id:3561,x:33237,y:31002,varname:node_3561,prsc:2|A-1033-RGB,B-6046-OUT;n:type:ShaderForge.SFN_Multiply,id:593,x:34991,y:31294,varname:node_593,prsc:2|A-7736-RGB,B-7841-OUT;n:type:ShaderForge.SFN_Get,id:7841,x:34621,y:31449,varname:node_7841,prsc:2|IN-7375-OUT;n:type:ShaderForge.SFN_Get,id:1509,x:35745,y:31671,varname:node_1509,prsc:2|IN-1610-OUT;n:type:ShaderForge.SFN_Get,id:2269,x:34616,y:31809,cmnt:The shadows value,varname:node_2269,prsc:2|IN-8421-OUT;n:type:ShaderForge.SFN_Clamp,id:2769,x:34902,y:31817,cmnt:This lets the user adjust te maximum shadow. A value of 0.5 will limit it to half.,varname:node_2769,prsc:2|IN-2269-OUT,MIN-4142-OUT,MAX-4289-OUT;n:type:ShaderForge.SFN_Vector1,id:4289,x:34616,y:31905,varname:node_4289,prsc:2,v1:1;n:type:ShaderForge.SFN_ValueProperty,id:7063,x:34495,y:32016,ptovrint:False,ptlb:_LushLODTreeShadowDarkness,ptin:_LushLODTreeShadowDarkness,cmnt:_LusLODSadowDarkness... this is cotrolled by the manager in its Update function,varname:node_2612,prsc:2,glob:True,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,v1:1;n:type:ShaderForge.SFN_OneMinus,id:4142,x:34694,y:32016,varname:node_4142,prsc:2|IN-7063-OUT;n:type:ShaderForge.SFN_Multiply,id:2746,x:36072,y:31447,cmnt:Darkens the ambient by up to 20 when not being viewed on the sunny side.,varname:node_2746,prsc:2|A-3031-RGB,B-3741-OUT;n:type:ShaderForge.SFN_Multiply,id:9440,x:36761,y:31319,varname:node_9440,prsc:2|A-593-OUT,B-4569-OUT;n:type:ShaderForge.SFN_Vector1,id:5539,x:34886,y:31449,varname:node_5539,prsc:2,v1:0.8;n:type:ShaderForge.SFN_Multiply,id:9604,x:35958,y:31700,varname:node_9604,prsc:2|A-1509-OUT,B-2769-OUT;n:type:ShaderForge.SFN_Add,id:4569,x:36349,y:31539,varname:node_4569,prsc:2|A-2746-OUT,B-9604-OUT;n:type:ShaderForge.SFN_Clamp01,id:3741,x:35799,y:31460,varname:node_3741,prsc:2|IN-3047-OUT;n:type:ShaderForge.SFN_Add,id:3047,x:35580,y:31460,varname:node_3047,prsc:2|A-5539-OUT,B-4788-OUT;n:type:ShaderForge.SFN_Subtract,id:5746,x:35152,y:31630,cmnt:This begins to remove the darkening of the ambient when we are more than 80 percent viewing the tree from the sunny side.,varname:node_5746,prsc:2|A-2769-OUT,B-5539-OUT;n:type:ShaderForge.SFN_Clamp01,id:4788,x:35354,y:31630,varname:node_4788,prsc:2|IN-5746-OUT;n:type:ShaderForge.SFN_Code,id:8687,x:35220,y:31145,varname:node_8687,prsc:2,code:LwAvAFQAaABlACAAYwBvAGQAZQAgAGgAZQByAGUAIABoAGEAbgBkAGwAZQBzACAAdABoAGUAIABhAG0AYgBpAGUAbgB0ACAAbABpAGcAaAB0ACAAYQBuAGQAIABzAGgAYQBkAG8AdwBzAC4ACgAvAC8ASQBUACAASQBTACAATgBPAFQAIABUAEgARQAgAFMAQQBNAEUAIABhAHMAIABmAG8AdQBuAGQAIABpAG4AIAB0AGgAZQAgAG8AdABoAGUAcgAgAGgAaQBnAGUAcgAgAHEAdQBhAGkAdAB5ACAAbABlAHYAZQBsAHMALgAKAC8ALwBJACAAZABpAGQAIABhACAAcwBvAG0AZQB3AGgAYQB0ACAAcgBlAGQAdQBjAGUAZAAgAHYAZQByAHMAaQBvAG4AIABoAGUAcgBlACAAdwBoAGkAYwBoACAAdQBzAGUAcwAgAGYAZQB3AGUAcgAKAC8ALwBtAHUAbAB0AGkAcABsAGkAYwBhAHQAaQBvAG4AcwAgAGEAbgBkACAAbgBvACAAbABlAHIAcABzACAAYQB0ACAAYQBsAGwALgAgAFQAaABhAHQAJwBzACAAYgBlAGMAYQB1AHMAZQAgAHQAaABpAHMAIABpAHMAIAAKAC8ALwB0AGgAZQAgAGwAbwB3AGUAcwB0ACAAcQB1AGEAbABpAHQAeQAgAHMAaABhAGQAZQByACwAIABzAG8AIABJACAAdAByAGkAZQBkACAAdABvACAAbQBhAGsAZQAgAGkAdAAgAGYAYQBzAHQAIABoAGUAcgBlAC4ACgAvAC8AUwBvACAAZABvAG4AJwB0ACAAZQB4AHAAZQBjAHQAIAB0AGgAaQBzACAAcwBoAGEAZABlAHIAIAB0AG8AIABoAGEAbgBkAGwAZQAgAHQAaABlACAAYQBtAGIAaQBlAG4AdAAgAGwAaQBnAGgAdAAKAC8ALwBlAHgAYQBjAHQAbAB5ACAAdABoAGUAIABzAGEAbQBlACAAYQBzACAAdABoAGUAIABvAHQAaABlAHIAIABzAGEAZABlAHIAcwAsACAAYgBlAGMAYQB1AHMAZQAgAGkAdAAgAHcAbwBuACcAdAAuAA==,output:2,fname:Read_Me_23957205,width:478,height:280;n:type:ShaderForge.SFN_Divide,id:6046,x:33024,y:31053,varname:node_6046,prsc:2|A-135-OUT,B-8582-OUT;n:type:ShaderForge.SFN_Vector1,id:8582,x:32711,y:31059,varname:node_8582,prsc:2,v1:1.2;n:type:ShaderForge.SFN_Color,id:3031,x:35799,y:31347,ptovrint:False,ptlb:_LushLODTreeAmbientColor,ptin:_LushLODTreeAmbientColor,cmnt:_LushLODTreeAmbientColor... this value is set in the manager,varname:_LushLODTreeAmbientColor_copy,prsc:2,glob:True,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,c1:0.5,c2:0.5,c3:0.5,c4:1;proporder:6665-5916-7736;pass:END;sub:END;*/

Shader "Hidden/LushLODTree/Tree_Leaves_Far4_Deferred" {
    Properties {
        _Color ("Color", Color) = (0.5,0.5,0.5,1)
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
            #include "CGIncludes/Dithering.cginc"
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
            
            float GetTexAlphaTrimmed_Caller( float TexAlpha ){
            return GetTexAlphaTrimmed_BOTHPASS(TexAlpha);
            }
            
            uniform float _LushLODTreeShadowDarkness;
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
                clip(GetTexAlphaTrimmed_Caller( TexAlpha ) - 0.5);
////// Lighting:
////// Emissive:
                float3 Param_Color = (_Color.rgb*2.0);
                float node_5539 = 0.8;
                float3 LightDir = _LushLODTreeMainLightDir.rgb;
                float node_9680 = 0.5*dot(viewDirection,LightDir)+0.5; // Check if view is opposite the direction of sunlight
                float BacksideDarkening = node_9680; // Darkens the trees when viewed from the back side.
                float node_2769 = clamp(BacksideDarkening,(1.0 - _LushLODTreeShadowDarkness),1.0); // This lets the user adjust te maximum shadow. A value of 0.5 will limit it to half.
                float3 LightIN = (_LushLODTreeMainLightCol.rgb*(_LushLODTreeMainLightIntensity/1.2));
                float3 emissive = ((_MainTex_var.rgb*Param_Color)*((_LushLODTreeAmbientColor.rgb*saturate((node_5539+saturate((node_2769-node_5539)))))+(LightIN*node_2769)));
                float3 finalColor = emissive;
                outDiffuse = half4( 0, 0, 0, 1 );
                outSpecSmoothness = half4(0,0,0,0);
                outNormal = half4( normalDirection * 0.5 + 0.5, 1 );
                outEmission = half4( ((_MainTex_var.rgb*Param_Color)*((_LushLODTreeAmbientColor.rgb*saturate((node_5539+saturate((node_2769-node_5539)))))+(LightIN*node_2769))), 1 );
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
            
            float GetTexAlphaTrimmed_Caller( float TexAlpha ){
            return GetTexAlphaTrimmed_BOTHPASS(TexAlpha);
            }
            
            uniform float _LushLODTreeShadowDarkness;
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
                clip(GetTexAlphaTrimmed_Caller( TexAlpha ) - 0.5);
////// Lighting:
////// Emissive:
                float3 Param_Color = (_Color.rgb*2.0);
                float node_5539 = 0.8;
                float3 LightDir = _LushLODTreeMainLightDir.rgb;
                float node_9680 = 0.5*dot(viewDirection,LightDir)+0.5; // Check if view is opposite the direction of sunlight
                float BacksideDarkening = node_9680; // Darkens the trees when viewed from the back side.
                float node_2769 = clamp(BacksideDarkening,(1.0 - _LushLODTreeShadowDarkness),1.0); // This lets the user adjust te maximum shadow. A value of 0.5 will limit it to half.
                float3 LightIN = (_LushLODTreeMainLightCol.rgb*(_LushLODTreeMainLightIntensity/1.2));
                float3 emissive = ((_MainTex_var.rgb*Param_Color)*((_LushLODTreeAmbientColor.rgb*saturate((node_5539+saturate((node_2769-node_5539)))))+(LightIN*node_2769)));
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
            uniform sampler2D _MainTex; uniform float4 _MainTex_ST;
            uniform float _Cutoff;
            float ClipMe( float TexAlpha , float Cutoff ){
            clip(TexAlpha - Cutoff);
            return TexAlpha;
            }
            
            float GetTexAlphaTrimmed_Caller( float TexAlpha ){
            return GetTexAlphaTrimmed_BOTHPASS(TexAlpha);
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
                clip(GetTexAlphaTrimmed_Caller( TexAlpha ) - 0.5);
                SHADOW_CASTER_FRAGMENT(i)
            }
            ENDCG
        }
    }
    CustomEditor "ShaderForgeMaterialInspector"
}
