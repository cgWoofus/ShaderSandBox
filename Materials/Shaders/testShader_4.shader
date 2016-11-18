Shader "sample/testShader_4"{
	Properties{
		_MainTex("Texture to blend", 2D) = "black" {}
	}
		SubShader
	{
		Tags{ "Queue" = "AlphaTest" "RenderType" = "TransparentCutout" "IgnoreProjector" = "True" }
		
		Pass{
		AlphaToMask On
		//ZWrite Off
		Blend SrcAlpha OneMinusSrcAlpha
		//Blend One One
		//SetTexture[_MainTex]//{ combine texture }

		CGPROGRAM
		#pragma vertex vert
		#pragma fragment frag
		uniform float4 _Color;
		uniform sampler2D _MainTex;


	// base input structs
		struct vertexInput {
			float4 vertex : POSITION;
			float2 texcoord : TEXCOORD0;
		};
		struct vertexOutput {
			float4 pos: SV_POSITION;
			float4 col : COLOR;
			float2 texcoord : TEXCOORD0;
		};
		

		vertexOutput vert(vertexInput v) {
			vertexOutput o;
		o.col = _Color;
		o.texcoord = v.texcoord;
		o.pos = mul(UNITY_MATRIX_MVP, v.vertex);
		return o;
		}



		fixed4 frag(vertexOutput i) :COLOR
		{
			
			fixed4 texcolor = tex2D(_MainTex,i.texcoord);
			//clip(texcolor.a -.001);
			return texcolor;
		}
		//Fallback "Diffuse"
		ENDCG

			}

	}
}

