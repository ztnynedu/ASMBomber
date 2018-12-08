//This script is a modified version of Partials/Dithered.shader. The modifications were mainly just to remove unnecessary
//calculations, and to add additional comments, and to rearrange the code, and to make it easier to call the functions.
//Due to the extensive hand-modifications I made to this file, I don't recommend editing dithered.shader anymore.
//If you want to edit any of the behavior of any of these dithering functions, I suggest you make the edits by hand,
//and probably should simply delete the dithered.shader file as it isn't being used anymore.

float2 GimmeUV(float2 Pos) {
#if UNITY_UV_STARTS_AT_TOP
	float grabSign = -_ProjectionParams.x;
#else
	float grabSign = _ProjectionParams.x;
#endif
	return grabSign*Pos.xy*0.5 + 0.5;
}

//Creates a dither pattern, where the density of the pixels changes depending on
//how much transparency we want. Can be used for shadows or non-Ultra dithered transparecy.
float BinaryDither4x4(float2 UVs) {
	float4 mtx0 = float4(0.05882353, 0.5294118, 0.1764706, 0.6470588); // float4. 1 9 3 11 divided by 17.0
	float4 mtx1 = float4(0.7647059, 0.2941177, 0.8823529, 0.4117647); // float4. 13 5 15 7 divided by 17.0
	float4 mtx2 = float4(0.2352941, 0.7058824, 0.1176471, 0.5882353); // float4. 4 12 2 10 divided by 17.0
	float4 mtx3 = float4(0.9411765, 0.4705882, 0.8235294, 0.3529412); // float4. 16 8 14 6 divided by 17.0

	float2 px = floor(_ScreenParams.xy * UVs);
	int xSmp = fmod(px.x, 4);
	int ySmp = fmod(px.y, 4);
	float4 xVec = 1 - saturate(abs(float4(0, 1, 2, 3) - xSmp));
	float4 yVec = 1 - saturate(abs(float4(0, 1, 2, 3) - ySmp));
	float4 pxMult = float4(dot(mtx0, yVec), dot(mtx1, yVec), dot(mtx2, yVec), dot(mtx3, yVec));
	return dot(pxMult, xVec);
}

//Creates a perfect checkerdbox pattern, used by the ultra shaders.
float Checkerdboard_Pattern_Maker(float2 screenUVs) {
	float2 px = floor(_ScreenParams.xy * screenUVs);
	return (fmod(px.x + px.y, 2) == 0) ? -0.55 : 1; //<-- the 0.55 causes the entire mesh to be dithered, without exception.
}

//Creates a perfect checkerdbox pattern, used by the ultra BB shaders.
float Checkerdboard_Pattern_Maker2(float2 screenUVs) {
	float2 px = floor(_ScreenParams.xy * screenUVs);
	return (fmod(px.x + px.y, 2) == 0) ? -0.45 : 1; //<-- the 0.45 causes only the Angular Corrected parts of the mesh to be dithered.
}

///################# BOTH PASS DITHERS ###########################
//Aka, dither functions that are allowed to run on both passes 
//because the shader uses the same identical clip() on both passes.

//GetDitherShadows() is used by the following shaders:
//Tree_Leaves_Ultra (shadow pass)
//Tree_Leaves2 (shadow pass)
//Tree_Leaves2_Deferred (both passes)
//Tree_Leaves3 (shadow pass)
//Tree_Leaves3_Deferred (both passes)
//Tree_Leaves4 (both passes)
//Tree_Leaves4_Deferred (both passes)
float GetDitherShadows_BOTHPASS(float2 UV0_IN, float Transparency) {
	float MatrixUV = BinaryDither4x4(GimmeUV(UV0_IN));
	float Coserp_Result = (1 - cos((Transparency*3.141592654*0.5))); //<-- same thing as Mathf.Coserp(), see Google. This helps fade in the leaves more gradually at first, instead of them appearing so suddenly.
	float rescaled2 = lerp(0.5, 1, Coserp_Result); //<-- rescales the transition to range from 0.5 to 1, instead of from 0 to 1, to trim a little wasted curve space off the beginning.
	float rescaled3 = lerp(0.5, 3, Coserp_Result); //<-- rescales the transition to range from 0.5 to 3, instead of from 0 to 1 -- this ensures the dithering is fully GONE when transparency is 1.
	float rescaled4 = lerp(rescaled2, rescaled3, Transparency); //<-- "rescaled2" helps bring the dithering in more slowly at first, but leaves some dithering still remaining. "rescaled3" remedies that.
	float dither = MatrixUV + rescaled4; //<-- calculates the dithering.
	return dither - 1; //<-- THIS FIRST CLIP is based on TEXTURE SPACE dithering. It is "chunky" in apperance. Leaves begin to appear in chunks in the center of the tree first, where leaves are the most dense.
}

//GetDitherUltra() is used by the following shaders:
//Tree_Leaves_Ultra (main pass - min)
//Tree_Leaves_Ultra_Deferred (main pass - min)
float GetDitherUltra_BOTHPASS(float2 SceneUVs, float Transparency) {
	float MatrixCheckerdBox = Checkerdboard_Pattern_Maker(SceneUVs);
	float Coserp_Result = (1 - cos((Transparency*3.141592654*0.5))); //<-- same thing as Mathf.Coserp(), see Google. This helps fade in the leaves more gradually at first, instead of them appearing so suddenly.
	float rescaled = lerp(0.0588, 1.0, Coserp_Result); //<-- rescales the transition to range from 0.0588 to 1, instead of from 0 to 1, to trim a little wasted curve space off the beginning, to ensure that the leaves begin to appear as soon as _Transparency is even slightly above zero (otherwise they don't even start to appear until _Transparency is nearly 0.2!). EDIT: 99 works better than 1... it ensures it ends up fully opaque with no dithering still lingering.
	return MatrixCheckerdBox + rescaled; //<-- calculates the dithering.
}

//GetPixelyDither() is used by the following shaders:
//Tree_Leaves_Ultra (main pass - min)
//Tree_Leaves_Ultra_Deferred (both passes - min)
float GetPixelyDither_BOTHPASS(float2 ScreenPos, float Transparency) {
	float MatrixScreen = BinaryDither4x4(GimmeUV(ScreenPos));
	float Coserp_Result = (-0.21 + (Transparency * 30)); //<-- controls where the pixely dither begins and ends 
	float rescaled = lerp(0.3, 1.5, Coserp_Result); //<-- controls where the pixely dither begins and ends
	float dither = MatrixScreen + rescaled; //<-- calculates the dithering.
	return dither - 0.5;
}

//GetTexAlphaTrimmed() is used by the following shaders:
//Tree_Leaves_Far4 (both passes)
//Tree_Leaves_Far4_Deferred (both passes)
float GetTexAlphaTrimmed_BOTHPASS(float TexAlpha) {
	//Since the edges of the textures are not softened by dithering we need to trim a little off
	return TexAlpha - 0.2;
}

///################# SHADOW PASS DITHERS ###########################

//GetDitherShadows() is used by the following shaders:
//Tree_Leaves_Ultra (shadow pass)
//Tree_Leaves2 (shadow pass)
//Tree_Leaves2_Deferred (both passes)
//Tree_Leaves3 (shadow pass)
//Tree_Leaves3_Deferred (both passes)
//Tree_Leaves4 (both passes)
//Tree_Leaves4_Deferred (both passes)
float GetDitherShadows_SHADOWPASS(float2 UV0_IN, float Transparency) {
#if defined(UNITY_PASS_SHADOWCASTER)
	float MatrixUV = BinaryDither4x4(GimmeUV(UV0_IN));
	float Coserp_Result = (1 - cos((Transparency*3.141592654*0.5))); //<-- same thing as Mathf.Coserp(), see Google. This helps fade in the leaves more gradually at first, instead of them appearing so suddenly.
	float rescaled2 = lerp(0.5, 1, Coserp_Result); //<-- rescales the transition to range from 0.5 to 1, instead of from 0 to 1, to trim a little wasted curve space off the beginning.
	float rescaled3 = lerp(0.5, 3, Coserp_Result); //<-- rescales the transition to range from 0.5 to 3, instead of from 0 to 1 -- this ensures the dithering is fully GONE when transparency is 1.
	float rescaled4 = lerp(rescaled2, rescaled3, Transparency); //<-- "rescaled2" helps bring the dithering in more slowly at first, but leaves some dithering still remaining. "rescaled3" remedies that.
	float dither = MatrixUV + rescaled4; //<-- calculates the dithering.
	return dither - 1; //<-- THIS FIRST CLIP is based on TEXTURE SPACE dithering. It is "chunky" in apperance. Leaves begin to appear in chunks in the center of the tree first, where leaves are the most dense.
#else
	return 1;
#endif
}

//GetDitherUltra() is used by the following shaders:
//Tree_Leaves_Ultra (main pass - min)
//Tree_Leaves_Ultra_Deferred (main pass - min)
float GetDitherUltra_SHADOWPASS(float2 SceneUVs, float Transparency) {
#if defined(UNITY_PASS_SHADOWCASTER)
	float MatrixCheckerdBox = Checkerdboard_Pattern_Maker(SceneUVs);
	float Coserp_Result = (1 - cos((Transparency*3.141592654*0.5))); //<-- same thing as Mathf.Coserp(), see Google. This helps fade in the leaves more gradually at first, instead of them appearing so suddenly.
	float rescaled = lerp(0.0588, 1.0, Coserp_Result); //<-- rescales the transition to range from 0.0588 to 1, instead of from 0 to 1, to trim a little wasted curve space off the beginning, to ensure that the leaves begin to appear as soon as _Transparency is even slightly above zero (otherwise they don't even start to appear until _Transparency is nearly 0.2!). EDIT: 99 works better than 1... it ensures it ends up fully opaque with no dithering still lingering.
	return MatrixCheckerdBox + rescaled; //<-- calculates the dithering.
#else
	return 1;
#endif
}

//GetPixelyDither() is used by the following shaders:
//Tree_Leaves_Ultra (main pass - min)
//Tree_Leaves_Ultra_Deferred (both passes - min)
float GetPixelyDither_SHADOWPASS(float2 ScreenPos, float Transparency) {
#if defined(UNITY_PASS_SHADOWCASTER)
	float MatrixScreen = BinaryDither4x4(GimmeUV(ScreenPos));
	float Coserp_Result = (-0.21 + (Transparency * 30)); //<-- controls where the pixely dither begins and ends 
	float rescaled = lerp(0.3, 1.5, Coserp_Result); //<-- controls where the pixely dither begins and ends
	float dither = MatrixScreen + rescaled; //<-- calculates the dithering.
	return dither - 0.5;
#else
	return 1;
#endif
}

///################# MAIN PASS DITHERS ###########################

//GetDitherShadows() is used by the following shaders:
//Tree_Leaves_Ultra (shadow pass)
//Tree_Leaves2 (shadow pass)
//Tree_Leaves2_Deferred (both passes)
//Tree_Leaves3 (shadow pass)
//Tree_Leaves3_Deferred (both passes)
//Tree_Leaves4 (both passes)
//Tree_Leaves4_Deferred (both passes)
float GetDitherShadows_MAINPASS(float2 UV0_IN, float Transparency) {
#if !defined(UNITY_PASS_SHADOWCASTER)
	float MatrixUV = BinaryDither4x4(GimmeUV(UV0_IN));
	float Coserp_Result = (1 - cos((Transparency*3.141592654*0.5))); //<-- same thing as Mathf.Coserp(), see Google. This helps fade in the leaves more gradually at first, instead of them appearing so suddenly.
	float rescaled2 = lerp(0.5, 1, Coserp_Result); //<-- rescales the transition to range from 0.5 to 1, instead of from 0 to 1, to trim a little wasted curve space off the beginning.
	float rescaled3 = lerp(0.5, 3, Coserp_Result); //<-- rescales the transition to range from 0.5 to 3, instead of from 0 to 1 -- this ensures the dithering is fully GONE when transparency is 1.
	float rescaled4 = lerp(rescaled2, rescaled3, Transparency); //<-- "rescaled2" helps bring the dithering in more slowly at first, but leaves some dithering still remaining. "rescaled3" remedies that.
	float dither = MatrixUV + rescaled4; //<-- calculates the dithering.
	return dither - 1; //<-- THIS FIRST CLIP is based on TEXTURE SPACE dithering. It is "chunky" in apperance. Leaves begin to appear in chunks in the center of the tree first, where leaves are the most dense.
#else
	return 1;
#endif
}

//GetDitherUltra() is used by the following shaders:
//Tree_Leaves_Ultra (main pass - min)
//Tree_Leaves_Ultra_Deferred (main pass - min)
float GetDitherUltra_MAINPASS(float2 SceneUVs, float Transparency) {
#if !defined(UNITY_PASS_SHADOWCASTER)
	float MatrixCheckerdBox = Checkerdboard_Pattern_Maker(SceneUVs);
	float Coserp_Result = (1 - cos((Transparency*3.141592654*0.5))); //<-- same thing as Mathf.Coserp(), see Google. This helps fade in the leaves more gradually at first, instead of them appearing so suddenly.
	float rescaled = lerp(0.0588, 1.0, Coserp_Result); //<-- rescales the transition to range from 0.0588 to 1, instead of from 0 to 1, to trim a little wasted curve space off the beginning, to ensure that the leaves begin to appear as soon as _Transparency is even slightly above zero (otherwise they don't even start to appear until _Transparency is nearly 0.2!). EDIT: 99 works better than 1... it ensures it ends up fully opaque with no dithering still lingering.
	return MatrixCheckerdBox + rescaled; //<-- calculates the dithering.
#else
	return 1;
#endif
}

//GetDitherUltraBB() is used by the following shaders:
//Tree_Leaves_Ultra_BB
float GetDitherUltraBB_MAINPASS(float2 SceneUVs, float Transparency) {
#if !defined(UNITY_PASS_SHADOWCASTER)
	float MatrixCheckerdBox = Checkerdboard_Pattern_Maker2(SceneUVs);
	float Coserp_Result = (1 - cos((Transparency*3.141592654*0.5))); //<-- same thing as Mathf.Coserp(), see Google. This helps fade in the leaves more gradually at first, instead of them appearing so suddenly.
	float rescaled = lerp(0.0588, 1.0, Coserp_Result); //<-- rescales the transition to range from 0.0588 to 1, instead of from 0 to 1, to trim a little wasted curve space off the beginning, to ensure that the leaves begin to appear as soon as _Transparency is even slightly above zero (otherwise they don't even start to appear until _Transparency is nearly 0.2!). EDIT: 99 works better than 1... it ensures it ends up fully opaque with no dithering still lingering.
	return MatrixCheckerdBox + rescaled; //<-- calculates the dithering.
#else
	return 1;
#endif
}

//GetPixelyDither() is used by the following shaders:
//Tree_Leaves_Ultra (main pass - min)
//Tree_Leaves_Ultra_Deferred (both passes - min)
float GetPixelyDither_MAINPASS(float2 ScreenPos, float Transparency) {
#if !defined(UNITY_PASS_SHADOWCASTER)
	float MatrixScreen = BinaryDither4x4(GimmeUV(ScreenPos));
	float Coserp_Result = (-0.21 + (Transparency * 30)); //<-- controls where the pixely dither begins and ends 
	float rescaled = lerp(0.3, 1.5, Coserp_Result); //<-- controls where the pixely dither begins and ends
	float dither = MatrixScreen + rescaled; //<-- calculates the dithering.
	return dither - 0.5;
#else
	return 1;
#endif
}

//GetAngularNoTransparency() is used by the following shaders:
//Tree_Leaves_Far2 (main pass)
//Tree_Leaves_Far3 (main pass)
float GetAngularNoTransparency_MAINPASS(float2 ScreenPos, float AngularCorrection) {
#if !defined(UNITY_PASS_SHADOWCASTER)

	//THIS CODE IS IDENTICAL TO THE FUNCTION BELOW (GetAngularWithTransparency), except it does NOT add * Transparency at the end.

	float MatrixScreen = BinaryDither4x4(GimmeUV(ScreenPos));
	float Coserp_Result = (1 - cos((AngularCorrection*3.141592654*0.5))); //<-- same thing as Mathf.Coserp(), see Google. This helps fade in the leaves more gradually at first, instead of them appearing so suddenly.
	float rescaled = lerp(0.0588, 1.0, Coserp_Result); //<-- rescales the transition to range from 0.0588 to 1, instead of from 0 to 1, to trim a little wasted curve space off the beginning, to ensure that the leaves begin to appear as soon as _Transparency is even slightly above zero (otherwise they don't even start to appear until _Transparency is nearly 0.2!). EDIT: 99 works better than 1... it ensures it ends up fully opaque with no dithering still lingering.
	float dither = MatrixScreen + rescaled; //<-- calculates the dithering.
	return dither - 0.5;
#else
	return 1;
#endif
}

//GetAngularWithTransparency() is used by the following shaders:
//Tree_Leaves2 (main pass)
//Tree_Leaves3 (main pass)
float GetAngularWithTransparency_MAINPASS(float2 ScreenPos, float Transparency, float AngularCorrection) {
#if !defined(UNITY_PASS_SHADOWCASTER)

	//THIS CODE IS IDENTICAL TO THE FUNCTION ABOVE (GetAngularNoTransparency), except it adds * Transparency at the end.

	float MatrixScreen = BinaryDither4x4(GimmeUV(ScreenPos));
	float Coserp_Result = (1 - cos((AngularCorrection*3.141592654*0.5))); //<-- same thing as Mathf.Coserp(), see Google. This helps fade in the leaves more gradually at first, instead of them appearing so suddenly.
	float rescaled = lerp(0.0588, 1.0, Coserp_Result); //<-- rescales the transition to range from 0.0588 to 1, instead of from 0 to 1, to trim a little wasted curve space off the beginning, to ensure that the leaves begin to appear as soon as _Transparency is even slightly above zero (otherwise they don't even start to appear until _Transparency is nearly 0.2!). EDIT: 99 works better than 1... it ensures it ends up fully opaque with no dithering still lingering.
	float dither = MatrixScreen + rescaled; //<-- calculates the dithering.
	return (dither - 0.5) * Transparency;
#else
	return 1;
#endif
}

//NOTE: The following shaders use only TexAlpha for their clipping:
//TO-DO: Check to see if they would look better using GetTexAlphaTrimmed() instead.
//Tree_Leaves_Far2 (shadow pass)
//Tree_Leaves_Far3 (shadow pass)
//Tree_Leaves_Far3_Deferred (both passes)