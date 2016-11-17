Shader "sample/testShader_5"{
	Properties{
		_Color("Color",Color) = (1.0,1.0,1.0,1.0)
		_MainTex("Main Texture",2D) = "white"{}
	}
		SubShader{
		Tags{ "RenderType" = "Opaque" "Queue" = "Geometry+1" }
			Pass{
				Stencil{
					Ref 2
					Comp always
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

				//float3 normalDirection = normalize ( mul(float4(v.normal,0.0), _World2Object).xyz);
				o.pos = mul(UNITY_MATRIX_MVP, v.vertex);
				o.texcoord = v.texcoord;
				//o.pos = UnityObjectToClipPos(v.vertex);
				//o.normal = mul(float4(v.normal, 0.0), _World2Object).xyz;
				
			//	float3 lightDirection;
			//	float atten = 1.0;

				//lightDirection = normalize(_WorldSpaceLightPos0.xyz);

				//mix color of object and lights
				//float3 diffuseReflection = atten * _LightColor0.xyz *_Color.rgb * max(0.0, dot(normalDirection, lightDirection));

				//o.col = float4(diffuseReflection, 1.0);
				//o.pos = mul(UNITY_MATRIX_MVP, v.vertex);
				return o;
			}



			float4 frag(vertexOutput i):SV_Target
			{

			fixed4 texColor = tex2D(_MainTex,i.texcoord);
			//float3 normalDirection = normalize(i.normal);
			//float3 lightDirection = normalize(_WorldSpaceLightPos0.xyz);
			//float3 diffuse = _LightColor0.rgb* max(0.0, dot(normalDirection,lightDirection));
			return half4(1, 0, 0, 1);
			//return _Color * texColor *float4(diffuse,1);
			}

			ENDCG


			}
			
			//Fallback "Diffuse"

	}
	

}
