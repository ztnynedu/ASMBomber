//
// Weather Maker for Unity
// (c) 2016 Digital Ruby, LLC
// Source code may be used for personal or commercial projects.
// Source code may NOT be redistributed or sold.
// 
// *** A NOTE ABOUT PIRACY ***
// 
// If you got this asset off of leak forums or any other horrible evil pirate site, please consider buying it from the Unity asset store at https ://www.assetstore.unity3d.com/en/#!/content/60955?aid=1011lGnL. This asset is only legally available from the Unity Asset Store.
// 
// I'm a single indie dev supporting my family by spending hundreds and thousands of hours on this and other assets. It's very offensive, rude and just plain evil to steal when I (and many others) put so much hard work into the software.
// 
// Thank you.
//
// *** END NOTE ABOUT PIRACY ***
//

#ifndef __WEATHER_MAKER_WATER_INCLUDED__
#define __WEATHER_MAKER_WATER_INCLUDED__

#include "WeatherMakerFogShader.cginc"

#define GET_WATER_DISTANCE_REDUCER(worldPos) (1.0 - saturate(((_WorldSpaceCameraPos.y - worldPos.y - 100.0) * _InvFadeParameter.y) + (worldPos.w * _InvFadeParameter.w)))

// textures
uniform sampler2D _WaterBumpMap;
uniform sampler2D _WaterFoam;
uniform sampler2D _WaterFoamBumpMap;
uniform sampler2D _WeatherMakerWaterReflectionTex;
uniform sampler2D _WeatherMakerWaterReflectionTex2;
uniform sampler2D _WeatherMakerWaterRefractionTex;
uniform sampler2D _WaterDisplacementMap;

// water y depth...
uniform sampler2D _WeatherMakerYDepthTexture;
uniform float4 _WeatherMakerYDepthParams;

#if defined(WEATHER_MAKER_LIGHT_SPECULAR_SPARKLE)

uniform sampler2D _SparkleNoise;
uniform fixed4 _SparkleTintColor;
uniform fixed4 _SparkleScale;
uniform fixed4 _SparkleOffset;
uniform fixed4 _SparkleFade;

#endif

uniform fixed3 _WaterFogColor;
uniform fixed _WaterFogDensity;

uniform sampler3D _CausticsTexture;
uniform fixed4 _CausticsTintColor;
uniform fixed4 _CausticsScale;
uniform fixed4 _CausticsVelocity;

// colors in use
uniform fixed4 _SpecularColor;
uniform fixed _SpecularIntensity;
uniform fixed4 _WaterColor;
uniform fixed _RefractionStrength;

// fade params
uniform float4 _InvFadeParameter;

// specularity
uniform float _Shininess;

// fresnel, vertex & bump displacements & strength
uniform float4 _DistortParams;
uniform float _FresnelScale;
uniform float4 _BumpTiling;
uniform float4 _BumpDirection;

// Scale, intensity, depth fade, wave factor
uniform float4 _WaterFoamParam1;
uniform float4 _WaterFoamParam2;

// water floor for shadow / depth pass
uniform fixed _WaterDepthThreshold;

uniform fixed _WaterDitherLevel;
uniform fixed _WaterShadowStrength;

// unused currently
uniform int _VolumetricSampleCount;
uniform fixed _VolumetricSampleMaxDistance;
uniform fixed _VolumetricSampleDither;
uniform fixed _VolumetricShadowPower;
uniform fixed _VolumetricShadowPowerFade;
uniform fixed _VolumetricShadowMinShadow;

// waves
uniform float4 _WaterWave1;
uniform float4 _WaterWave1_Precompute;
uniform float4 _WaterWave1_Params1;
uniform float4 _WaterWave2;
uniform float4 _WaterWave2_Precompute;
uniform float4 _WaterWave2_Params1;
uniform float4 _WaterWave3;
uniform float4 _WaterWave3_Precompute;
uniform float4 _WaterWave3_Params1;
uniform float4 _WaterWave4;
uniform float4 _WaterWave4_Precompute;
uniform float4 _WaterWave4_Params1;
uniform float4 _WaterWave5;
uniform float4 _WaterWave5_Precompute;
uniform float4 _WaterWave5_Params1;
uniform float4 _WaterWave6;
uniform float4 _WaterWave6_Precompute;
uniform float4 _WaterWave6_Params1;
uniform float4 _WaterWave7;
uniform float4 _WaterWave7_Precompute;
uniform float4 _WaterWave7_Params1;
uniform float4 _WaterWave8;
uniform float4 _WaterWave8_Precompute;
uniform float4 _WaterWave8_Params1;
uniform float _WaterWaveMultiplier;

uniform float4 _WaterDisplacement1;
uniform float4 _WaterDisplacement2;

// shortcuts
#define PER_PIXEL_DISPLACE _DistortParams.x
#define REALTIME_DISTORTION _DistortParams.y
#define FRESNEL_POWER _DistortParams.z
#define FRESNEL_BIAS _DistortParams.w
#define DISTANCE_SCALE 0.01

struct appdata_water
{
	float4 vertex : POSITION;
	float3 normal : NORMAL;
	float4 uv : TEXCOORD0;
	WM_BASE_VERTEX_INPUT
};

struct v2fWater
{
	float4 pos : SV_POSITION;
	float4 normal : NORMAL;
	float4 rayDir : TEXCOORD0;
	float4 bumpCoords : TEXCOORD1;
	float4 reflectionPos : TEXCOORD2;
	float4 refractionPos : TEXCOORD3;
	float4 worldPos : TEXCOORD4;
	float4 viewPos : TEXCOORD5;
	float4 uv : TEXCOORD6;

#if defined(UNITY_PASS_FORWARDADD)

	LIGHTING_COORDS(7, 8)

#elif defined(UNITY_PASS_FORWARDBASE)

	//SHADOW_COORDS(7)

#endif

	WM_BASE_VERTEX_TO_FRAG
};

// use camera y depth to get water depth (0-1) at uv from top water plane
inline float GetWaterYDepth(float2 uv)
{
	float yDepth = GetDepth01LodSamplerOrtho(_WeatherMakerYDepthTexture, uv);
	yDepth = max(0.0, yDepth - _WeatherMakerYDepthParams.y);
	yDepth *= _WeatherMakerYDepthParams.w;
	return yDepth;
}

// get water height from GetWaterYDepth
inline float GetWaterHeight(float yDepth)
{
	return _WeatherMakerYDepthParams.x * yDepth;
}

// apply normal map to vertex normal
inline half3 PerPixelNormal(sampler2D bumpMap, half4 coords, half3 vertexNormal, half bumpStrength)
{
	half4 bump = (tex2D(bumpMap, coords.xy) + tex2D(bumpMap, coords.zw)) * 0.5;
	half3 normal = UnpackNormal(bump);
	half3 worldNormal = vertexNormal + normal.xxy * bumpStrength * half3(1, 0, 1);
	return normalize(worldNormal);
}

inline half3 PerPixelNormalLod(sampler2D bumpMap, half4 coords, half3 vertexNormal, half bumpStrength, float lod)
{
	half4 bump = (tex2Dlod(bumpMap, float4(coords.xy, 0.0, lod)) + tex2Dlod(bumpMap, float4(coords.zw, 0.0, lod))) * 0.5;
	half3 normal = UnpackNormal(bump);
	half3 worldNormal = vertexNormal + normal.xxy * bumpStrength * half3(1, 0, 1);
	return normalize(worldNormal);
}

// get normal from bump map
inline half3 PerPixelNormalUnpacked(sampler2D bumpMap, half4 coords, half bumpStrength)
{
	half4 bump = (tex2D(bumpMap, coords.xy) + tex2D(bumpMap, coords.zw)) * 0.5;
	half3 normal = UnpackNormal(bump);
	normal.xy *= bumpStrength;
	return normalize(normal);
}

// apply a single gerstner wave
inline void WaterApplyGerstnerWave(float4 wave, float4 wavePrecompute, float4 waveParams1, float3 baseWorldPos, inout float4 worldPos, inout float3 tangent, inout float3 binormal, float reducer)
{
	UNITY_BRANCH
	if ((wave.x != 0 || wave.y != 0.0) && wave.z > 0.0 && wave.w > 0.0)
	{
		float steepness = wave.z;
		float wavelength = wave.w;
		//float k = 2 * UNITY_PI / wavelength;
		//float c = sqrt(9.8 / k);
		//float a = steepness / k;
		float k = wavePrecompute.x;
		float c = wavePrecompute.y;
		float a = lerp(wavePrecompute.z * reducer, wavePrecompute.z, waveParams1.y) * _WaterWaveMultiplier; // reduce by height according to height reduce parameter waveParams1.y
		float2 d = (wave.xy);
		float f = k * (dot(d, baseWorldPos.xz) - c);
		float sinF;
		float cosF;
		sincos(f, sinF, cosF);
		float steepnessSinF = steepness * sinF;
		float steepnessCosF = steepness * cosF;
		float dxSteepnessSinF = d.x * steepnessSinF;
		float negDxSteepnessSinF = -d.x * steepnessSinF;
		float dySteepnessSinF = d.y * steepnessCosF;
		float negDySteepnessSinF = -d.y * dySteepnessSinF;
		float negDxDySteepnessSinF = -d.x * dySteepnessSinF;

		tangent += float3(negDxSteepnessSinF, d.x * steepnessCosF, negDxDySteepnessSinF);
		binormal += float3(negDxDySteepnessSinF, d.y * steepnessCosF, -d.y * dySteepnessSinF);
		worldPos.xyz += float3(d.x * (a * cosF), a * sinF, d.y * (a * cosF));
	}
}

// apply all gerstner waves
inline float4 WaterApplyWaves(inout float4 vertexPos, inout float4 normal, out float4 bumpCoords, inout float waterHeight, float depth01)
{
	// perform calculations in world space
	float4 worldPos = mul(unity_ObjectToWorld, vertexPos);
	float origY = worldPos.y;
	float lod = distance(_WorldSpaceCameraPos, worldPos.xyz);
	bumpCoords = (worldPos.xzxz + (_WeatherMakerTime.x * _BumpDirection.xyzw)) * _BumpTiling.xyzw;

	UNITY_BRANCH
	if (normal.w > 0.99)
	{
		if (((_WaterWave1.x != 0.0 || _WaterWave1.y != 0.0) && (_WaterWave1.z > 0.0 && _WaterWave1.w > 0.0)) ||
			((_WaterWave2.x != 0.0 || _WaterWave2.y != 0.0) && (_WaterWave2.z > 0.0 && _WaterWave2.w > 0.0)) ||
			((_WaterWave3.x != 0.0 || _WaterWave3.y != 0.0) && (_WaterWave3.z > 0.0 && _WaterWave3.w > 0.0)) ||
			((_WaterWave4.x != 0.0 || _WaterWave4.y != 0.0) && (_WaterWave4.z > 0.0 && _WaterWave4.w > 0.0)) ||
			((_WaterWave5.x != 0.0 || _WaterWave5.y != 0.0) && (_WaterWave5.z > 0.0 && _WaterWave5.w > 0.0)) ||
			((_WaterWave6.x != 0.0 || _WaterWave6.y != 0.0) && (_WaterWave6.z > 0.0 && _WaterWave6.w > 0.0)) ||
			((_WaterWave7.x != 0.0 || _WaterWave7.y != 0.0) && (_WaterWave7.z > 0.0 && _WaterWave7.w > 0.0)) ||
			((_WaterWave8.x != 0.0 || _WaterWave8.y != 0.0) && (_WaterWave8.z > 0.0 && _WaterWave8.w > 0.0)))
		{

#if defined(TESSELATION_ENABLE)

			UNITY_BRANCH
			if (_WaterDisplacement1.x > 0.0)
			{
				// slight wave based on normal
				float lod2 = clamp(lod * 0.02, 0.0, 6.0);
				float4 uv = float4((worldPos.xz + (_WeatherMakerTime.x * _WaterDisplacement1.zw)) * _WaterDisplacement1.x, 0.0, lod2);
				float displacement = tex2Dlod(_WaterDisplacementMap, uv).a * _WaterDisplacement1.y;
				if (_WaterDisplacement2.x > 0.0)
				{
					uv = float4((worldPos.xz + (_WeatherMakerTime.x * _WaterDisplacement2.zw)) * _WaterDisplacement2.x, 0.0, lod2);
					displacement += (tex2Dlod(_WaterDisplacementMap, uv).a * _WaterDisplacement2.y);
				}
				worldPos.xyz += (normal * displacement * _WaterWaveMultiplier);
			}

#endif

			float3 tangent = float3(1.0, 0.0, 0.0);
			float3 binormal = float3(0.0, 0.0, 1.0);
			float4 baseWorldPos = worldPos;
			float reducer = depth01;
			WaterApplyGerstnerWave(_WaterWave1, _WaterWave1_Precompute, _WaterWave1_Params1, baseWorldPos, worldPos, tangent, binormal, reducer);
			WaterApplyGerstnerWave(_WaterWave2, _WaterWave2_Precompute, _WaterWave2_Params1, baseWorldPos, worldPos, tangent, binormal, reducer);
			WaterApplyGerstnerWave(_WaterWave3, _WaterWave3_Precompute, _WaterWave3_Params1, baseWorldPos, worldPos, tangent, binormal, reducer);
			WaterApplyGerstnerWave(_WaterWave4, _WaterWave4_Precompute, _WaterWave4_Params1, baseWorldPos, worldPos, tangent, binormal, reducer);
			WaterApplyGerstnerWave(_WaterWave5, _WaterWave5_Precompute, _WaterWave5_Params1, baseWorldPos, worldPos, tangent, binormal, reducer);
			WaterApplyGerstnerWave(_WaterWave6, _WaterWave6_Precompute, _WaterWave6_Params1, baseWorldPos, worldPos, tangent, binormal, reducer);
			WaterApplyGerstnerWave(_WaterWave7, _WaterWave7_Precompute, _WaterWave7_Params1, baseWorldPos, worldPos, tangent, binormal, reducer);
			WaterApplyGerstnerWave(_WaterWave8, _WaterWave8_Precompute, _WaterWave8_Params1, baseWorldPos, worldPos, tangent, binormal, reducer);
			normal.xyz = normalize(cross(binormal, tangent));

			// re-assign vertex back from world space
			vertexPos = mul(unity_WorldToObject, worldPos);

			waterHeight += max(0.0, worldPos.y - origY);
		}
	}
	else
	{
		normal.xyz = float3(0.0, 1.0, 0.0);
	}

	worldPos.w = lod;
	return worldPos;
}

// return water foam color
inline fixed4 WaterFoamColor(float4 worldPos, float3 viewVector, float4 bumpCoords, float waterAmount, float distanceReducer, inout float3 worldNormal)
{
	UNITY_BRANCH
	if (_WaterFoamParam1.x <= 0.0 || _WaterFoamParam1.y <= 0.0 || distanceReducer <= 0.0 || (_WaterFoamParam1.z <= 0.0 && _WaterFoamParam1.w <= 0.0))
	{
		return fixed4Zero;
	}
	else
	{
		// reduce foam by increase depth
		fixed depthFactor = saturate(1.0 - (_WaterFoamParam1.z * waterAmount));

		// increase foam by increase wave
		fixed waveFactor = saturate((worldPos.y - _FogBoxMax.y) * _WaterFoamParam1.w);

		// foam is still if depth factor is greater than wave factor
		fixed foamVelFactor = max(0.0, ceil(waveFactor - depthFactor));
		float2 foamUV = (_WeatherMakerTime.x * _WaterFoamParam2.xy);

		// get foam color from both bump coords and average
		fixed4 foamColor = (tex2D(_WaterFoam, _WaterFoamParam1.x * (bumpCoords.xy + foamUV)) + tex2D(_WaterFoam, _WaterFoamParam1.x * (bumpCoords.zw + foamUV))) * 0.5;

		// apply intensity, depth factor and wave factor
		fixed factor = saturate(distanceReducer * _WaterFoamParam1.y * max(depthFactor, waveFactor));
		foamColor.a = factor * factor;
		worldNormal = PerPixelNormal(_WaterFoamBumpMap, bumpCoords, worldNormal, PER_PIXEL_DISPLACE * foamColor.a);
		return foamColor;
	}
}

// get color behind water with refraction and fog
float3 ColorBehindWater(float4 worldPos, float3 rayDir, float4 screenPos, float3 viewPos, float2 uvOffset, out float waterAmount, out float fogFactor, out float sceneZ, out float3 depthPos)
{
	// handle edges, aliasing
	float div = 1.0 / max(0.0001, screenPos.w);

	// account for perpective distortion
	float2 baseUV = screenPos.xy * div;
	uvOffset *= div;

	// fractional pixel removal
	uvOffset.y *= _CameraDepthTexture_TexelSize.z * abs(_CameraDepthTexture_TexelSize.y);

	// get depth value at fully distorted pixel
	float2 uv = AlignScreenUVWithDepthTexel(baseUV + uvOffset);
	float depth = LinearEyeDepth(WM_SAMPLE_DEPTH(uv));

	// water depth
	float surfaceDepth = UNITY_Z_0_FAR_FROM_CLIPSPACE(screenPos.z);

	// difference
	float depthDifference = depth - surfaceDepth;

	// scale down if negative depth or close to 0 depth
	uvOffset *= saturate(depthDifference);

	// get new uv
	uv = AlignScreenUVWithDepthTexel(baseUV + uvOffset);

	// set depth to corrected value
	depth = LinearEyeDepth(SAMPLE_DEPTH_TEXTURE(_CameraDepthTexture, uv));

	// set sceneZ
	sceneZ = length(depth / viewPos.z);

#if defined(WATER_UNDERWATER)

	// in the water, use depth or distance to edge of water, whichever is smaller
	waterAmount = min(sceneZ, worldPos.w);
	depthPos = _WorldSpaceCameraPos + (rayDir * waterAmount);

#else

	// set depth to non-refracted value
	float nonRefractionDepth = LinearEyeDepth(SAMPLE_DEPTH_TEXTURE(_CameraDepthTexture, baseUV));
	float nonRefractionSceneZ = length(nonRefractionDepth / viewPos.z);
	depthPos = _WorldSpaceCameraPos + (rayDir * nonRefractionSceneZ);
	waterAmount = distance(worldPos.xyz, depthPos);

#endif

	fogFactor = saturate(exp(-_WaterFogDensity * waterAmount));
	fixed3 backgroundColor;

	// fetch background at uv
	UNITY_BRANCH
	if (_RefractionStrength > 0.0)
	{
		backgroundColor = tex2D(_WeatherMakerWaterRefractionTex, uv).rgb * _RefractionStrength;
	}
	else
	{
		// save texture fetch
		backgroundColor = fixed3Zero;
	}

#if defined(WATER_UNDERWATER)

	return backgroundColor;

#else

	// TODO: Note, this assumes the sun intensity is being reduced as the player goes lower into the water
	return lerp(_WaterFogColor * _LightColor0.rgb, backgroundColor, fogFactor);

#endif

}

// get fresnel factor (spreads specular light out)
inline half Fresnel(half3 viewVector, half3 worldNormal, half bias, half power)
{
	half facing = clamp(1.0 - max(dot(-viewVector, worldNormal), 0.0), 0.0, 1.0);
	half refl2Refr = saturate(bias + (1.0 - bias) * pow(facing, power));
	return refl2Refr;
}

// calculate caustics (little wavy lines at bottom of pools)
fixed3 ComputeWaterCaustics(float4 worldPos, float3 rayDir, float3 depthPos, float waterAmount, float2 distortOffset, fixed reducer)
{
	// reduce with tiny water height, fade linear, z value is shallow water fade factor
	float height = (_FogBoxMax.y - depthPos.y);
	reducer *= saturate(height * _CausticsScale.z);

	// reduce with increased water height, fade linear
	reducer *= saturate(16.0 / height);

#if !defined(WATER_UNDERWATER)

	// reduce with increased distance to water surface from eye, fade linear
	reducer /= max(1.0, worldPos.w * 0.01);

#endif

	UNITY_BRANCH
	if (reducer <= 0.0)
	{
		return fixed3Zero;
	}
	else
	{
		// calculate shadow, reduce caustics by shadow and sun light intensity
		fixed shadowAmount = CalculateDirLightShadowPower(depthPos.xyz, 0);
		reducer *= pow(shadowAmount * min(1.0, _LightColor0.a), 4.0);

		// if rotating to light, no need to swap z and y as the rotation does it
		float3 samplePos = RotatePointZeroOriginQuaternion(depthPos, _WeatherMakerDirLightQuaternion[0]);

		// adjust z (depth) animation
		float3 velocity = _CausticsVelocity * _WeatherMakerTime.x;
		samplePos = float3(samplePos.xy * _CausticsScale.x, velocity.y);

		// adjust texture lookup animation
		samplePos.xy -= (velocity.xz * _BumpDirection.xy);

		// adjust distortion animation
		samplePos.xy += (distortOffset * _CausticsScale.w);

		// take sample pos and lookup caustics
		fixed causticsLookupValue = tex3D(_CausticsTexture, samplePos).a * _CausticsScale.y;

		return (causticsLookupValue * reducer * _WeatherMakerDirLightPower[0].z) * _CausticsTintColor * _WeatherMakerDirLightColor[0].rgb;
	}
}

#if !defined(WATER_LIGHT_FORWARD_BASE)

// compute water surface color from all lights in one function, no need for more than one pass
void ComputeWaterColorAllLight(float3 worldPos, float3 worldNormal, float3 viewVector,

	fixed shadowPowerReducer, float distanceToWorldPosSquared,

#if defined(WEATHER_MAKER_SHADOWS_SOFT) || defined(WEATHER_MAKER_SHADOWS_HARD)

	float sceneZ,

#endif	

	inout fixed4 baseColor, fixed4 specColor)
{
	wm_world_space_light_params p;
	p.worldPos = worldPos;
	p.worldNormal = worldNormal;

#if !defined(WEATHER_MAKER_LIGHT_NO_DIFFUSE)

	p.diffuseColor = baseColor;
	p.ambientColor = _WeatherMakerAmbientLightColorGround * _AmbientLightMultiplier;

#endif

#if !defined(WEATHER_MAKER_LIGHT_NO_SPECULAR)

	p.rayDir = viewVector;
	p.specularColor = specColor.rgb * specColor.a;

#if defined(WATER_UNDERWATER)

	p.specularPower = _Shininess * 0.25;

#else

	p.specularPower = _Shininess;

#endif

#endif

	p.shadowStrength = _WaterShadowStrength;

#if defined(WEATHER_MAKER_LIGHT_SPECULAR_SPARKLE)

	p.sparkleNoise = _SparkleNoise;
	p.sparkleTintColor = _SparkleTintColor.rgb * _SparkleTintColor.a * specColor.a;
	p.sparkleScale = _SparkleScale;
	p.sparkleOffset = _SparkleOffset;
	p.sparkleFade = _SparkleFade;
	p.distanceToWorldPosSquared = distanceToWorldPosSquared;

#endif

	baseColor.rgb = CalculateLightColorWorldSpace(p).rgb;
}

#endif

// return water color for the given worldPos
fixed4 ComputeWaterColor
(
	float4 bumpCoords,
	float4 normal,
	float4 rayDir,
	float4 reflectionPos,
	float4 refractionPos,
	float4 viewPos,
	float4 worldPos,
	float4 uv,
	float atten,
	out float3 worldNormal
)
{
	//worldNormal = float3(0, 0, 0); return fixed4(uv.zzz, 1.0);

	// normalize view pos
	viewPos.xyz = normalize(viewPos.xyz);

	// distance reducer, water farther away smooths out
	fixed distanceReducer = rayDir.w;

	// ray direction
	float3 viewVector = normalize(rayDir.xyz);

	// used to fade out sparkles
	float distanceToWorldPosSquared = viewPos.w;

	// output parameters
	float waterAmount;
	float fogFactor;
	float sceneZ;
	float3 depthPos;

#if defined(WATER_UNDERWATER)

	// if underwater, do not show caustics when looking up through water surface
	float showCaustics = (normal.w < 0.99);
	float noCaustics = (1.0 - showCaustics);

	// get water normal, no water normal for non-water surface
	worldNormal = (noCaustics * PerPixelNormal(_WaterBumpMap, bumpCoords, normal.xyz, PER_PIXEL_DISPLACE)) + (normal.xyz * showCaustics);
	worldNormal = lerp(float3(0.0, 1.0, 0.0), worldNormal, distanceReducer);
	float2 distortOffset = worldNormal.xz * REALTIME_DISTORTION * noCaustics;

#else

	// caustics always show if above water
	float showCaustics = 1.0;

	// use water height to show shoreline
	fixed waterHeight = uv.w;
	worldNormal = PerPixelNormal(_WaterBumpMap, bumpCoords, normal.xyz, PER_PIXEL_DISPLACE);
	worldNormal = lerp(float3(0.0, 1.0, 0.0), worldNormal, distanceReducer);
	float2 distortOffset = worldNormal.xz * REALTIME_DISTORTION;

#endif

	// calculate reflection and refraction
	fixed reflectionDistortReducer = min(1.0, worldPos.w * 0.02);
	float2 reflectionUV = (reflectionPos.xy + (distortOffset * reflectionDistortReducer)) / max(0.001, reflectionPos.w);
	fixed3 colorBehindWater = ColorBehindWater(worldPos, viewVector, refractionPos, viewPos, distortOffset, waterAmount, fogFactor, sceneZ, depthPos);
	fixed4 rtRefractions = fixed4(colorBehindWater, 1.0);

#if defined(WATER_UNDERWATER)

	// if the water is beyond the depth buffer, use a down normal to not light it
	fixed isInFrontOfDepthBuffer = (worldPos.w >= sceneZ);
	worldNormal = lerp(worldNormal, float3(0.0, -1.0, 0.0), isInFrontOfDepthBuffer);
	fixed foamSpecularReducer = 1.0;

#else

	// above water, calculate foam
	fixed minWaterAmount = min(waterHeight, waterAmount);
	fixed4 foamColor = WaterFoamColor(worldPos, viewVector, bumpCoords, minWaterAmount, distanceReducer, worldNormal);
	fixed foamSpecularReducer = 1.0 - min(1.0, (_WaterFoamParam2.z * foamColor.a));

#endif

	// shading for fresnel term
	worldNormal.xz *= _FresnelScale;

	// reflection
#if defined(WATER_REFLECTIVE)

	// compute reflection color
	fixed4 rtReflections = lerp(tex2D(_WeatherMakerWaterReflectionTex, reflectionUV),
		tex2D(_WeatherMakerWaterReflectionTex2, reflectionUV), reflectionPos.z);
	rtReflections.a = 1.0;
	half reflectionStrength = Fresnel(viewVector, worldNormal, FRESNEL_BIAS, FRESNEL_POWER) * (FRESNEL_BIAS > -100.0) * foamSpecularReducer * _InvFadeParameter.z;
	fixed shadowPowerReducer = (1.0 - reflectionStrength);

#else

	fixed shadowPowerReducer = 1.0;

#endif

#if !defined(UNITY_PASS_FORWARDADD)

	// caustics, not shown in forward add pass
	if (_CausticsScale.x > 0.0 && _CausticsScale.y > 0.0 && showCaustics == 1.0)
	{
		fixed reducer = shadowPowerReducer * foamSpecularReducer * atten * fogFactor * saturate(3.0 - (REALTIME_DISTORTION + PER_PIXEL_DISPLACE));
		rtRefractions.rgb += ComputeWaterCaustics(worldPos, viewVector, depthPos, waterAmount, distortOffset, reducer);
	}

#endif

	// base, depth & reflection colors
	fixed4 baseColor = _WaterColor;
	baseColor *= lerp(fixed4One, ((tex2D(_MainTex, bumpCoords.xy) + tex2D(_MainTex, bumpCoords.zw)) * 0.5), distanceReducer
		
#if defined(WATER_UNDERWATER)

		* (1.0 - isInFrontOfDepthBuffer)

#endif
	
	);
	rtRefractions *= (1.0 - baseColor.a);

	// fade / alpha
#if defined(WATER_UNDERWATER)

	baseColor.a = 1.0;

#else

	// fade shoreline if above water
	fixed invFade = saturate(minWaterAmount * _InvFadeParameter.x);
	baseColor.rgb = DO_ALPHA_BLEND(foamColor, baseColor);
	baseColor.a = invFade;

#endif

	// lighting
#if !defined(WATER_LIGHT_FORWARD_BASE)

	fixed4 specColor = _SpecularColor;
	specColor.a *= _SpecularIntensity * foamSpecularReducer;

	// compure water color
	ComputeWaterColorAllLight(

#if defined(WATER_UNDERWATER)

	depthPos

#else

	worldPos

#endif

	, worldNormal, viewVector, shadowPowerReducer, distanceToWorldPosSquared,

#if defined(WEATHER_MAKER_SHADOWS_SOFT) || defined(WEATHER_MAKER_SHADOWS_HARD)

		sceneZ,

#endif

		baseColor, specColor);

#endif

#if defined(WATER_REFLECTIVE) && !defined(WATER_UNDERWATER)

	fixed3 emissive = lerp(rtRefractions.rgb, rtReflections.rgb, reflectionStrength);

#else

	fixed3 emissive = rtRefractions.rgb;

#endif

	// add emissive color (refraction and/or reflection)
	baseColor.rgb += lerp(emissive, emissive * _WaterColor.rgb, _WaterColor.a);

#if defined(WATER_UNDERWATER)

	// fog
	fixed4 fogColor = fixed4(_WaterFogColor * _LightColor0.rgb, 1.0 - fogFactor);
	baseColor.rgb = DO_ALPHA_BLEND(fogColor, baseColor);

#endif

	// dither
	ApplyDither(baseColor.rgb, worldPos.xz + worldPos.yy, _WaterDitherLevel);

	return baseColor;
}

#if defined(WATER_LIGHT_FORWARD_BASE)

fixed4 ApplyWaterLightForwardBaseAdd(fixed4 baseColor, fixed atten, float3 lightDir, float3 worldPos, float3 worldNormal, fixed4 specularColor, fixed specularPower)
{
	float3 rayDir = normalize(worldPos - _WorldSpaceCameraPos);

#if defined(UNITY_PASS_FORWARDBASE)

	UnityLight light;
#ifdef LIGHTMAP_OFF
	light.color = baseColor.rgb;
	light.dir = lightDir;
	light.ndotl = LambertTerm(worldNormal, light.dir);
#else
	light.color = half3(0.f, 0.f, 0.f);
	light.ndotl = 0.0f;
	light.dir = half3(0.f, 0.f, 0.f);
#endif
	UnityGIInput d;
	d.light = light;
	d.worldPos = worldPos;
	d.worldViewDir = rayDir;
	d.atten = atten;
#if UNITY_SPECCUBE_BLENDING || UNITY_SPECCUBE_BOX_PROJECTION
	d.boxMin[0] = unity_SpecCube0_BoxMin;
	d.boxMin[1] = unity_SpecCube1_BoxMin;
#endif
#if UNITY_SPECCUBE_BOX_PROJECTION
	d.boxMax[0] = unity_SpecCube0_BoxMax;
	d.boxMax[1] = unity_SpecCube1_BoxMax;
	d.probePosition[0] = unity_SpecCube0_ProbePosition;
	d.probePosition[1] = unity_SpecCube1_ProbePosition;
#endif
	d.probeHDR[0] = unity_SpecCube0_HDR;
	d.probeHDR[1] = unity_SpecCube1_HDR;
	Unity_GlossyEnvironmentData ugls_en_data;
	ugls_en_data.roughness = 0.45; // 1.0 - gloss
	float3 viewReflectDirection = reflect(-rayDir, worldNormal);
	ugls_en_data.reflUVW = viewReflectDirection;
	UnityGI gi = UnityGlobalIllumination(d, 1, worldNormal, ugls_en_data);
	lightDir = gi.light.dir;
	baseColor.rgb = gi.light.color;

#endif

	fixed3 finalColor = saturate(dot(lightDir, worldNormal));
	finalColor = finalColor * baseColor.rgb * _LightColor0.rgb * atten; // diffuse color * light color
	wm_world_space_light_params p;
	p.worldPos = worldPos;
	p.worldNormal = worldNormal;

#if !defined(WEATHER_MAKER_LIGHT_NO_SPECULAR)

	p.specularColor = specularColor;
	p.specularPower = specularPower;
	p.rayDir = rayDir;
	finalColor += CalculateSpecularColor(fixed4(_LightColor0.rgb, 1.0), lightDir, floor(atten), p);

#endif

	return fixed4(finalColor, baseColor.a);
}

#endif

v2fWater vertWater(appdata_water v)
{
	WM_INSTANCE_VERT(v, v2fWater, o);
	if (v.uv.w > 0.0)
	{
		float yDepth = GetWaterYDepth(v.uv);
		o.uv = float4(v.uv.xy, yDepth, GetWaterHeight(yDepth));
		o.normal = float4(v.normal, v.normal.y);
		o.worldPos = WaterApplyWaves(v.vertex, o.normal, o.bumpCoords, o.uv.w, yDepth);
		o.pos = UnityObjectToClipPos(v.vertex);
		o.viewPos.xyz = UnityObjectToViewPos(v.vertex);
		o.viewPos.w = o.worldPos.w * o.worldPos.w;
		o.rayDir.xyz = -WorldSpaceViewDir(v.vertex);
		o.rayDir.w = GET_WATER_DISTANCE_REDUCER(o.worldPos);
		o.reflectionPos = ComputeNonStereoScreenPos(o.pos);
		o.refractionPos = ComputeScreenPos(o.pos);

#if defined(UNITY_SINGLE_PASS_STEREO)

		o.reflectionPos.z = unity_StereoEyeIndex;

#else

		// When not using single pass stereo rendering, eye index must be determined by testing the
		// sign of the horizontal skew of the projection matrix.
		o.reflectionPos.z = (unity_CameraProjection[0][2] > 0.0);

#endif

#if defined(WATER_UNDERWATER)

		// recompute to far plane position, underwater in a huge water volume can have clip holes
		//  where the camera far plane does not reach the edge of the water
		o.pos = UnityObjectToClipPosFarPlane(v.vertex);

#endif

	}
	else
	{
		o.pos = -999999.0;
		o.uv = -999999.0;
		o.normal = 0.0;
		o.worldPos = 0.0;
		o.viewPos = 0.0;
		o.rayDir = 0.0;
		o.reflectionPos = 0.0;
		o.refractionPos = 0.0;
		o.bumpCoords = 0.0;
	}

#if defined(UNITY_PASS_FORWARDADD)

	TRANSFER_VERTEX_TO_FRAGMENT(o);

#elif defined(UNITY_PASS_FORWARDBASE)

	//TRANSFER_SHADOW(o);

#endif

	return o;
}

fixed4 fragWaterForward(v2fWater i) : SV_Target
{
	WM_INSTANCE_FRAG(i);

	clip(i.uv.w);

#if !defined(WATER_UNDERWATER)

	// check null zones, clip out if not allowing water
	ClipWorldPosNullZones(i.worldPos);

#endif

	float3 worldNormal;

#if !defined(WATER_LIGHT_FORWARD_BASE) || defined(WATER_UNDERWATER)

	// all lights in one pass
	return ComputeWaterColor(i.bumpCoords, i.normal, i.rayDir, i.reflectionPos, i.refractionPos, i.viewPos, i.worldPos, i.uv, 1.0, worldNormal);

#else

#if defined(UNITY_PASS_FORWARDBASE)

	// TODO: Figure out why Unity can't sample the shadow map in forward base pass properly
	float atten = CalculateDirLightShadowPower(i.worldPos.xyz, 0);
	atten = min(1.0, atten * 5.0);
	//float atten = SHADOW_ATTENUATION(i);
	float3 lightDir = normalize(_WorldSpaceLightPos0.xyz);

#else

	UNITY_LIGHT_ATTENUATION(atten, i, i.worldPos.xyz);
	float3 lightDir = normalize(lerp(_WorldSpaceLightPos0.xyz, _WorldSpaceLightPos0.xyz - i.worldPos.xyz, _WorldSpaceLightPos0.w));

#endif

	fixed4 baseColor = ComputeWaterColor(i.bumpCoords, i.normal, i.rayDir, i.reflectionPos, i.refractionPos, i.viewPos, i.worldPos, i.uv, atten, worldNormal);
	fixed4 specColor = _SpecularColor;
	specColor.rgb *= _SpecularIntensity;

#if defined(UNITY_PASS_FORWARDBASE)

	specColor.a *= _WeatherMakerDirLightPower[0].z;

#endif

	return ApplyWaterLightForwardBaseAdd(baseColor, atten, lightDir, i.worldPos.xyz, worldNormal, specColor, _Shininess);

#endif

}

#endif
