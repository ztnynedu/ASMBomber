Shader "Hidden/LushLODTree/BlitCopyAlphaFlippable" {
    Properties {
		_Color("Multiplicative color", Color) = (1.0, 1.0, 1.0, 1.0)
    }
    SubShader {
        Pass {
            Cull Off
            ZTest Always
            ZWrite Off
			ColorMask A //<-- Ensures that this shader only restores the alpha values
            
            CGPROGRAM
            #pragma vertex vert
            #pragma fragment frag
            #include "UnityCG.cginc"
            #pragma target 2.0
            uniform sampler2D _LushLODTreesScreenCopy2;
			uniform float4 _LushLODTreesScreenCopy2_ST;
            uniform float4 _Color;
            uniform float _LushLODTreeFlipY;

			struct appdata_t {
				float4 vertex : POSITION;
			};

			struct v2f {
				float4 pos : SV_POSITION;
				float4 screenPos : TEXCOORD0;
			};

			v2f vert(appdata_t v)
			{
				v2f o;
				o.pos = mul(UNITY_MATRIX_VP, v.vertex);
				o.screenPos = o.pos;
				return o;
			}

			fixed4 frag(v2f i) : SV_Target
			{

				#if UNITY_UV_STARTS_AT_TOP
								float grabSign = -_ProjectionParams.x;
				#else
								float grabSign = _ProjectionParams.x;
				#endif
				i.screenPos = float4(i.screenPos.xy / i.screenPos.w, 0, 0);
				i.screenPos.y *= _ProjectionParams.x;
				i.screenPos.y *= _LushLODTreeFlipY;
				float2 sceneUVs = (float2(1,grabSign)*i.screenPos.xy*0.5 + 0.5);

				fixed4 col = tex2D(_LushLODTreesScreenCopy2, sceneUVs.rg) * _Color;

				return col.a < 1 ? col : fixed4(1, 0, 0, 0); //<-- TO-DO: this is debug red, remove this debug red when done debugging.
			}
            ENDCG
        }
    }
}
