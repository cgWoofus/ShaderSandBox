Shader "sample/testShader_5"{
	Properties{
		_Color("Color",Color) = (1.0,1.0,1.0,1.0)
		_MainTex("Main Texture",2D) = "white"{}
	}
		SubShader{
		Tags{ "Queue" = "Geometry-1" }
		ColorMask 0 // Don't write to any colour channels
		ZWrite Off // Don't write to the Depth buffer
			Pass
		{
				Stencil{
					Ref 1
					Comp Always
					Pass replace
				}
			
			CGPROGRAM

			#pragma vertex vert
			#pragma fragment frag

			//user defined
			uniform float4 _Color;
			uniform sampler2D _MainTex;
			
			//unity defined
			uniform float4 _LightColor0;
			
			// base input structs
			struct vertexInput {
				float4 vertex : POSITION;
				float3 normal : NORMAL;
				float2 texcoord : TEXCOORD0;

			};
			struct vertexOutput {
				float4 pos: SV_POSITION;
				float3 normal : NORMAL;
				float4 col : COLOR;
				float2 texcoord: TEXCOORD0;
			};
			 

			vertexOutput vert(vertexInput v) {
				vertexOutput o;
				o.pos = mul(UNITY_MATRIX_MVP, v.vertex);
				//o.texcoord = v.texcoord;
				o.col = _Color;
				return o;
			}



			float4 frag(vertexOutput i):SV_Target
			{

				fixed4 texColor = tex2D(_MainTex,i.texcoord);

			//return half4(1, 0, 0, 1);
				return _Color; //* texColor *float4(diffuse,1);
			}

			ENDCG
			

			}
			
			//Fallback "Diffuse"

	}
	

}
