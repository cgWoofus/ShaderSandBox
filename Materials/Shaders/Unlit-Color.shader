// Unlit shader. Simplest possible colored shader.
// - no lighting
// - no lightmap support
// - no texture

Shader "sample/Unlit/Color" {
Properties {
	_Color ("Main Color", Color) = (1,1,1,1)
	_MainTex("Main Texture",2D) = "white"{}
}

SubShader {
	Tags { "RenderType"="Opaque" }
	LOD 100
	
	Pass {  
		CGPROGRAM
			#pragma vertex vert
			#pragma fragment frag
			#pragma multi_compile_fog
			
			#include "UnityCG.cginc"

			struct appdata_t {
				float4 vertex : POSITION;
				float2 texcoord : TEXCOORD0;
			};

			struct v2f {
				float4 vertex : SV_POSITION;
				float2 texcoord : TEXCOORD0;
				//UNITY_FOG_COORDS(0)
			};

			fixed4 _Color;
			sampler2D _MainTex;
			
			v2f vert (appdata_t v)
			{
				v2f o;
				o.vertex = mul(UNITY_MATRIX_MVP, v.vertex);
				o.texcoord = v.texcoord;
				//UNITY_TRANSFER_FOG(o,o.vertex);
				
				return o;
			}
			
			fixed4 frag (v2f i) : COLOR
			{
				//fixed4 col = _Color;
				fixed4 texColor = tex2D(_MainTex,i.texcoord);
				//UNITY_APPLY_FOG(i.fogCoord, col);
				//UNITY_OPAQUE_ALPHA(col.a);
				return texColor;
			}
		ENDCG
	}
}

}
