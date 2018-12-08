
//This shader is identical to the builtin BlitCopy shader used by Graphics.Blit() internally.
//Except that this shader accepts a _FlipY input (either 0 or -1) which can flip the texture upside down to fix an upside down image.

Shader "Hidden/LushLODTree/BlitCopyFlippable" {
    Properties {
		_MainTex("Texture", any) = "" {}
		_Color("Multiplicative color", Color) = (1.0, 1.0, 1.0, 1.0)
    }
    SubShader {
        Pass {
            Cull Off
            ZTest Always
            ZWrite Off
            
            CGPROGRAM
            #pragma vertex vert
            #pragma fragment frag
            #include "UnityCG.cginc"
            #pragma target 2.0
            uniform sampler2D _MainTex; 
			uniform float4 _MainTex_ST;
            uniform float4 _Color;
			uniform float _LushLODTreeFlipY;

			struct appdata_t {
				float4 vertex : POSITION;
				float2 texcoord : TEXCOORD0;
			};

			struct v2f {
				float4 vertex : SV_POSITION;
				float2 texcoord : TEXCOORD0;
			};

			v2f vert(appdata_t v)
			{
				v2f o;
				o.vertex = UnityObjectToClipPos(v.vertex);
				o.texcoord = TRANSFORM_TEX(float2(v.texcoord.x, v.texcoord.y * _LushLODTreeFlipY), _MainTex);
				return o;
			}

			fixed4 frag(v2f i) : SV_Target
			{
				return tex2D(_MainTex, i.texcoord) * _Color;
			}
            ENDCG
        }
    }
}
