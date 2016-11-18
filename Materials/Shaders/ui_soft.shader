Shader "sample/ui/ui_soft"{
	Properties{
		_Color("Color",Color) = (1.0,1.0,1.0,1.0)
		_MainTex("Main Texture",2D) = "white"{}
		_TopColor("Color1",Color) = (1,1,1,1)
		_BottomColor("Color2",Color) = (0,0,0,1)
			/*
	// required for UI.Mask
	_StencilComp("Stencil Comparison", Float) = 8
	_Stencil("Stencil ID", Float) = 0
	_StencilOp("Stencil Operation", Float) = 0
	_StencilWriteMask("Stencil Write Mask", Float) = 255
	_StencilReadMask("Stencil Read Mask", Float) = 255
	_ColorMask("Color Mask", Float) = 15*/
	}
		SubShader{
			Tags
			{ "RenderType" = "Transparent" "Queue" = "Transparent" }
				/*
			Stencil
			{
				Ref[_Stencil]
				Comp[_StencilComp]
				Pass[_StencilOp]
				ReadMask[_StencilReadMask]
				WriteMask[_StencilWriteMask]
		}
			ColorMask[_ColorMask]*/

			Pass
			{

			Blend SrcAlpha OneMinusSrcAlpha
			CGPROGRAM
			#pragma vertex vert
			#pragma fragment frag
			#include "UnityCG.cginc"
			uniform float4 _Color;
			sampler2D _MainTex;
			float4 _MainTex_ST;
			uniform fixed4 _TopColor;
			uniform fixed4 _BottomColor;
			half _Value;

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

		//mix color of object and lights

		
		o.pos = mul(UNITY_MATRIX_MVP, v.vertex);
		o.texcoord = TRANSFORM_TEX(v.texcoord, _MainTex);
		o.col = lerp(_TopColor, _BottomColor, v.texcoord.y);
		return o;
	}



	float4 frag(vertexOutput i) :SV_TARGET
	{
		float4 color;
		color.rgb = i.col.rgb;
		color.a = tex2D(_MainTex, i.texcoord).a * i.col.a;
		return color;
	}







		//Fallback "Diffuse"
		ENDCG
}


	}
}
