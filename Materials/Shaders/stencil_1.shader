Shader "Unlit/stencil_1"
{
	Properties
	{
		_MainTex ("Texture", 2D) = "white" {}
	}
	SubShader
	{
		Tags { "RenderType"="Opaque" }
		// Only render pixels whose value in the stencil buffer equals 1.
	
		Pass
		{
		Stencil{
			Ref 1
			Comp Equal
			}

		}
	}
}
