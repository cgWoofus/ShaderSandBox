Shader "sample/testShader_4"{
	Properties{
		_Color("Color",Color) = (1.0,1.0,1.0,1.0)
		_MainTex("Main Texture",2D) = "white"{}
	}
		SubShader{
			Pass{

			Tags{"LightMode" = "ForwardBase"}
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

				//float3 normalDirection = normalize ( mul(float4(v.normal,0.0), _World2Object).xyz);
				o.pos = mul(UNITY_MATRIX_MVP, v.vertex);
				o.normal = mul(float4(v.normal, 0.0), _World2Object).xyz;
				o.texcoord = v.texcoord;
			//	float3 lightDirection;
			//	float atten = 1.0;

				//lightDirection = normalize(_WorldSpaceLightPos0.xyz);

				//mix color of object and lights
				//float3 diffuseReflection = atten * _LightColor0.xyz *_Color.rgb * max(0.0, dot(normalDirection, lightDirection));

				//o.col = float4(diffuseReflection, 1.0);
				//o.pos = mul(UNITY_MATRIX_MVP, v.vertex);
				return o;
			}



			float4 frag(vertexOutput i):COLOR
			{

			fixed4 texColor = tex2D(_MainTex,i.texcoord);
			float3 normalDirection = normalize(i.normal);
			float3 lightDirection = normalize(_WorldSpaceLightPos0.xyz);
			float3 diffuse = _LightColor0.rgb* max(0.0, dot(normalDirection,lightDirection));

			return _Color * texColor *float4(diffuse,1);
			}

			ENDCG


			}
			
			//Fallback "Diffuse"

	}
	

}
