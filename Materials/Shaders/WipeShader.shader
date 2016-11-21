// Modified Unity version - WipeShader - mgear - http://unitycoder.com/blog/
// ORIGINAL GLSL SHADER "Postpro" WAS MADE BY: iq (2009)

Shader "sample/mWipe1"
{
	Properties
	{
		_tex0("Texture1", 2D) = "black" {}
	_tex1("Texture2", 2D) = "black" {}
	_transValue("Value",Range(0.0,1.0)) = 0
	//_tex1("Texture2", Color) = (1,1,1,1)
	}

		SubShader
	{
		Tags{ "Queue" = "Transparent" "RenderType" = "Transparent }" }

		GrabPass
	{
		"_BackgroundTexture"
	}
		Pass
	{
		//Blend SrcAlpha OneMinusSrcAlpha
		AlphaToMask On
		CGPROGRAM

#pragma target 3.0
#pragma vertex vert
#pragma fragment frag
#include "UnityCG.cginc"

		sampler2D _tex0;
	sampler2D _tex1;
	
	float _transValue;
	//float4 _tex1;

	struct v2f {
		float4 pos : SV_POSITION;
		float4 color : COLOR0;
		float4 fragPos : COLOR1;
		float2  uv : TEXCOORD0;
		//float4  uv : TEXCOORD0;
	};

	float4 _tex0_ST;

	v2f vert(appdata_base v)
	{
		v2f o;
		o.pos = mul(UNITY_MATRIX_MVP, v.vertex);
		//o.pos = UnityObjectToClipPos(v.vertex);
		o.fragPos = o.pos;
		o.uv = TRANSFORM_TEX(v.texcoord, _tex0);
		//o.color = float4 (1.0, 1.0, 1.0, 1);
		//o.uv = ComputeGrabScreenPos(o.pos);
		return o;
	}
	sampler2D _BackgroundTexture;
	// I dont really have idea whats happening here..its a bit modified version from the original shader
	half4 frag(v2f i) : SV_Target
	{
	float animtime = _Time*5.0;
	float4 oricol = tex2D(_tex1, i.uv);
	float4 col = tex2D(_tex0, i.uv);
	float comp = smoothstep(0.1, 0.7, sin(_transValue));
	float  coeff = clamp(-3.0 + 2.0 * (i.uv.y + 1.9) * (i.uv.x + 1) * comp, 0.0, 1.0);	
	float4 result   = lerp(col, oricol, coeff);

	
	//return 1 - bgcolor;
		return result;
	}
		ENDCG
	}
	}
		FallBack "VertexLit"
}