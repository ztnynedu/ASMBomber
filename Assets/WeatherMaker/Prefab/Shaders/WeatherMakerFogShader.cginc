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

// receive shadows: http://www.gamasutra.com/blogs/JoeyFladderak/20140416/215612/Let_there_be_shadow.php

#include "WeatherMakerNullZoneShader.cginc"

// note: define NULL_ZONE_RENDER_MASK for the type of mask your shader is rendering (see NullZoneScript.cs)

#define FOG_LIGHT_POINT_SAMPLE_COUNT 5.0
#define FOG_LIGHT_POINT_SAMPLE_COUNT_INVERSE (1.0 / FOG_LIGHT_POINT_SAMPLE_COUNT)
#define FOG_LIGHT_SPOT_SAMPLE_COUNT 40.0
#define FOG_LIGHT_SPOT_SAMPLE_COUNT_INVERSE (1.0 / FOG_LIGHT_SPOT_SAMPLE_COUNT)
#define FOG_LIGHT_AREA_SAMPLE_COUNT 10.0
#define FOG_LIGHT_AREA_SAMPLE_COUNT_INVERSE (1.0 / FOG_LIGHT_AREA_SAMPLE_COUNT)
#define FOG_SHADOW_BASE_LIGHT_INTENSITY 0.5

uniform sampler3D _WeatherMakerNoiseTexture3D;

uniform float _WeatherMakerVolumetricPointSpotMultiplier = 1.0;

uniform uint _FogMode = 0;
uniform fixed4 _FogColor;
uniform fixed4 _FogEmissionColor;
uniform fixed _FogLightAbsorption;
uniform fixed _FogDitherLevel;
uniform float _FogNoisePercent; // percent of noise to use. 0 percent would be a noise value of 1, 1 would be the full noise value.
uniform float _FogNoiseScale;
uniform float _FogNoiseAdder;
uniform float _FogNoiseMultiplier;
uniform float _FogNoiseSampleCount;
uniform float _FogNoiseSampleCountInverse;
uniform float3 _FogNoiseVelocity;
uniform float3 _FogNoisePositionOffset;
uniform float _FogHeight;
uniform float4 _FogBoxCenter;
uniform float3 _FogBoxMin;
uniform float3 _FogBoxMax;
uniform float3 _FogBoxMinDir;
uniform float3 _FogBoxMaxDir;
uniform float4 _FogSpherePosition;
uniform float4 _FogVolumePower;
uniform float _MaxFogFactor = 1.0;

uniform fixed _FogDensity = 0.0;
uniform fixed _FogFactorMultiplier = 1.0;
uniform fixed _FogDensityScatter = 1.0;

uniform fixed4 _FogSunShaftsParam1;
uniform fixed4 _FogSunShaftsParam2;
uniform fixed4 _FogSunShaftsTintColor;
uniform fixed4 _FogSunShaftsDitherMagic;

uniform float _FogLightShadowSampleCount;
uniform float _FogLightShadowInvSampleCount;
uniform float _FogLightShadowMaxRayLength;
uniform float _FogLightShadowMultiplier;
uniform float _FogLightShadowBrightness;
uniform float _FogLightShadowPower;
uniform float _FogLightShadowDecay;
uniform float _FogLightShadowDither;
uniform float4 _FogLightShadowDitherMagic;

uniform int _FogNoiseEnabled;
#define WM_FOG_NOISE_ENABLED (_FogNoiseEnabled)
#define WM_FOG_HEIGHT_ENABLED (_FogHeight > 0.0)

uniform int _FogVolumetricLightMode;
#define WM_FOG_VOLUMETRIC_LIGHT_MODE_NONE (_FogVolumetricLightMode == 0)
#define WM_FOG_VOLUMETRIC_LIGHT_MODE_NOT_NONE (_FogVolumetricLightMode)
#define WM_FOG_VOLUMETRIC_LIGHT_MODE_ENABLE (_FogVolumetricLightMode == 1)
#define WM_FOG_VOLUMETRIC_LIGHT_MODE_ENABLE_WITH_SHADOWS (_FogVolumetricLightMode == 2)

uniform int _FogSunShaftMode;
#define WM_FOG_SUN_SHAFT_ENABLE (_FogSunShaftMode == 1)

inline float CalculateFogFactor(float depth)
{
	float fogFactor;
	switch (_FogMode)
	{
	case 1:
		// constant
		fogFactor = _FogDensity * ceil(saturate(depth));
		break;

	case 2:
		// linear
		fogFactor = min(1.0, (depth / _ProjectionParams.z) * (_FogDensity * _ProjectionParams.z * 0.1));
		break;

	case 3:
		// exponential
		// simple height formula
		// const float extinction = 0.01;
		// float fogFactor = saturate((_FogDensity * exp(-(_WorldSpaceCameraPos.y - _FogHeight) * extinction) * (1.0 - exp(-depth * rayDir.y * extinction))) / rayDir.y);
		//fogFactor = 1.0 - saturate(1.0 / (exp(depth * _FogDensity)));
		fogFactor = 1.0 - saturate(exp2(depth * -_FogDensity));
		break;

	case 4:
		// exponetial squared
		//float expFog = exp(depth * _FogDensity);
		//fogFactor = 1.0 - saturate(1.0 / (expFog * expFog));
		float expFog = exp2(depth * -_FogDensity);
		fogFactor = 1.0 - saturate((expFog * expFog));
		break;

	default:
		fogFactor = 0.0;
		break;
	}
	return min(_MaxFogFactor, fogFactor * _FogFactorMultiplier);
}

inline float CalculateFogFactorWithDither(float depth, float2 screenUV)
{
	// slight dither to fog factor to give it a little more randomness
	float fogFactor = CalculateFogFactor(depth);
	float dither = 0.003 * frac(_WeatherMakerTime.x + (cos(dot(screenUV, ditherMagic.xy)) * ditherMagic.z));
	return min(1.0, fogFactor + dither);
}

inline float CalculateFogDirectionalLightScatter(float3 rayDir, float3 lightDir, float fogFactor, float power, float multiplier)
{
	float cosAngle = max(0.0, dot(lightDir, rayDir));
	float scatter = pow(cosAngle, power);
	return scatter * GetMieScattering(cosAngle) * _FogLightAbsorption * _WeatherMakerFogDirectionalLightScatterIntensity * (1.0 - fogFactor) * multiplier * max(0.0, 1.0 - (_FogDensity * 1.2));
}

fixed3 ComputeFogShaftColor(float2 screenUV, fixed fogFactor, float4 lightViewportPos)
{
	fixed3 color = 0.0;
	//if (lightViewportPos.z <= 0.0)
	//{
//		return color;
//	}

	// adjust UV coordinate if needed
	float2 viewportPos = AdjustFullScreenUV(lightViewportPos.xy);

	// determine how much to march each step - using the spread parameter (_FogSunShaftsParam1.x) we can change the length of the sun-shafts
	float2 uvMarch = (viewportPos - screenUV) * _FogSunShaftsParam1.x;

	float dither = frac(cos(dot(screenUV * _WeatherMakerTime.x, ditherMagic.xy)) * ditherMagic.z);
	dither *= (frac(dot(_FogSunShaftsDitherMagic.xy, screenUV * _FogSunShaftsDitherMagic.zw)) - 0.5);

	// adjust uv direction by dither
	uvMarch *= (1.0 + (_FogSunShaftsParam2.z * dither));

	// start off with full step multiplier
	fixed stepMultiplier = _FogSunShaftsParam2.x;

	// ray march sample count times
	UNITY_LOOP
	for (int i = 0; i < int(_FogSunShaftsParam1.y); i++)
	{
		// march from center of sun pixel towards target pixel
		screenUV += uvMarch;

#if defined(WEATHER_MAKER_IS_FULL_SCREEN_EFFECT) && (defined(UNITY_STEREO_INSTANCING_ENABLED) || defined(UNITY_STEREO_MULTIVIEW_ENABLED))

		fixed3 rgb = UNITY_SAMPLE_SCREENSPACE_TEXTURE_LOD(_MainTex2, float4(screenUV.xy, 0, 0)).rgb;

#else

		// read camera target and sum up all colors and average them
		fixed3 rgb = tex2Dlod(_MainTex2, float4(screenUV.xy, 0, 0)).rgb;

#endif

		// apply color using step multiplier and multiply by inverse sample count * weight
		color += (rgb * stepMultiplier);

		// decrease step multiplier by decay
		stepMultiplier *= _FogSunShaftsParam2.y;
	}

	// multiply final color by brightness multiplier and reduce by fog factor and reduce for very thin fog factor
	fixed fogFactorReducer1 = (1.0 - fogFactor);
	fixed fogFactorReducer2 = min(1.0, lerp(0.0, 1.0, fogFactor * fogFactor * 1000.0));
	return color * _FogColor * _FogSunShaftsParam1.w * _FogSunShaftsTintColor.rgb * lightViewportPos.w * _FogSunShaftsParam1.z * fogFactorReducer1 * fogFactorReducer2;
}

void ComputeDirectionalLightFog(float3 rayOrigin, float3 rayDir, float rayLength, float fogFactor, out fixed3 lightColor, float2 screenUV)
{
	float fogFactorSquared = fogFactor * fogFactor;

	// add full ambient as sun intensity approaches 0
	fixed3 ambient = min(1.0, _WeatherMakerAmbientLightColorGround.rgb * _AmbientLightMultiplier * max(0.0, 1.0 - _WeatherMakerSunColor.a));
	lightColor = ambient * fogFactor;

	// sun light + scatter
	fixed3 sunLightColor = (_WeatherMakerSunColor.rgb * _WeatherMakerSunColor.a * _DirectionalLightMultiplier);
	float scatter = CalculateFogDirectionalLightScatter(rayDir, _WeatherMakerSunDirectionUp, fogFactor, _WeatherMakerSunLightPower.x, _FogDensityScatter);

	if (WM_FOG_VOLUMETRIC_LIGHT_MODE_ENABLE_WITH_SHADOWS && WM_CAMERA_RENDER_MODE_NORMAL && rayLength < _FogLightShadowMaxRayLength)
	{
		float4 wpos = float4(rayOrigin, 1.0);
		float shadowPower = 0.0;
		float viewZ = 0.0;
		float4 cascadeWeights;
		float4 samplePos;
		float shadowDepth;
		float lightDot = max(_FogLightShadowDecay, dot(_WeatherMakerSunDirectionUp, rayDir));

		// dithering
		float dither = (1.0 + (_FogLightShadowDither / max(0.4, fogFactor + (2 * lightDot)) * frac(cos(dot(screenUV * _WeatherMakerTime.x, ditherMagic.xy)) * ditherMagic.z) *
			(frac(dot(_FogLightShadowDitherMagic.xy, screenUV * _FogLightShadowDitherMagic.zw)) - 0.5)));

		lightDot = pow(lightDot, _FogLightShadowPower);
		lightDot = 1.0 + (_FogLightShadowMultiplier * lightDot);

#if defined(SHADER_API_D3D9)

		const float sampleCount = 16;
		const float invSampleCount = 1.0 / 16.0;

#else

		float sampleCount = floor(min(rayLength * 3, _FogLightShadowSampleCount));
		float invSampleCount = (1.0 / (float)sampleCount);

#endif

		float stepAmount = (min(rayLength, _FogLightShadowMaxRayLength) * invSampleCount);
		float3 stepDir = rayDir * stepAmount;

		stepDir *= dither;

		// for sun, ray march through the shadow map

#if defined(SHADER_API_D3D9)

		UNITY_UNROLL

#else

		UNITY_LOOP

#endif

		for (int i = 0; i < int(sampleCount); i++)
		{
			viewZ += stepAmount;
			wpos.xyz += stepDir;

			cascadeWeights = GET_CASCADE_WEIGHTS(wpos, viewZ);
			samplePos = GET_SHADOW_COORDINATES(wpos, cascadeWeights);
			shadowPower += UNITY_SAMPLE_SHADOW(_WeatherMakerShadowMapTexture, samplePos);
		}

		// general scattering
		lightColor += ((fogFactor * (sunLightColor + (sunLightColor * scatter))) *

		// ray scattering
		(FOG_SHADOW_BASE_LIGHT_INTENSITY + (max(0.0, (1.0 - (2.0 * fogFactor))) * shadowPower * invSampleCount * lightDot * _FogLightShadowBrightness)));
	}
	else
	{
		lightColor += (fogFactor * (sunLightColor + (sunLightColor * scatter)));
	}

	// moon light + scatter
	UNITY_LOOP
	for (int i = 0; i < _WeatherMakerMoonCount; i++)
	{
		fixed moonIntensity = _WeatherMakerMoonLightColor[i].a * _DirectionalLightMultiplier;
		fixed3 moonLightColor = _WeatherMakerMoonLightColor[i].rgb * moonIntensity;
		scatter = CalculateFogDirectionalLightScatter(rayDir, _WeatherMakerMoonDirectionUp[i], fogFactor, _WeatherMakerMoonLightPower[i].x, _FogDensityScatter);
		moonLightColor = (fogFactor * (moonLightColor + (moonLightColor * scatter)));
		lightColor += moonLightColor;
	}

	lightColor *= _FogDensityScatter;
}

inline void ComputeLightColorForFogPointLight
(
	float3 rayOrigin,
	float3 rayDir,
	float lightAmount,
	float distanceToLight,
	float4 lightPos,
	fixed4 lightColor,
	float4 lightAtten,
    float lightMultiplier,
	inout fixed3 accumLightColor)
{
	// amount to move for each sample
	float3 step;

	// fog factor reducer is the amount of fog in front of the light, used to reduce the light
	float fogFactorReducer = 1.0 - CalculateFogFactor(distanceToLight * 0.33);

	// amount of fog on light ray
	float fogFactorOnRay = CalculateFogFactor(lightAmount);

	// sample points along the ray
	float lightSample;
	float attenSample = 0.0;
	float eyeLightDot;
	float3 startPos = rayOrigin + (rayDir * distanceToLight);
	float3 currentPos;
	float3 toLight;

	step = rayDir * (lightAmount * FOG_LIGHT_POINT_SAMPLE_COUNT_INVERSE);
	currentPos = startPos - (step * 0.5);
	lightSample = 0.0;

	for (int i = 0; i < int(FOG_LIGHT_POINT_SAMPLE_COUNT); i++)
	{
		currentPos += step;
		toLight = currentPos - lightPos.xyz;
		lightSample += dot(toLight, toLight);
	}

	// average samples
	lightSample *= FOG_LIGHT_POINT_SAMPLE_COUNT_INVERSE;

	// calculate atten from distance from center
	lightSample = max(0.0, 1.0 - (lightSample * lightAtten.w));
	lightSample *= lightSample * CalculateFogFactor(lightAmount) * lightColor.a;

	// as camera approaches light position, reduce amount of light
	// right next to the light there is less light travelling to the eye through the fog
	toLight = _WorldSpaceCameraPos - lightPos.xyz;
	float d = dot(toLight, toLight);
	lightAmount = lightSample * clamp(d * lightAtten.w, 0.2, 1.0);

	// apply color
	accumLightColor += (lightColor.rgb * lightAmount * fogFactorReducer * fogFactorOnRay * lightMultiplier * _FogLightAbsorption

#if defined(UNITY_COLORSPACE_GAMMA)

	// brighten up gamma space to make it look more like linear
	* 1.8

#endif
		
	);
}

inline void ComputeLightColorForFogSpotLight
(
	float3 rayOrigin,
	float3 rayDir,
	float lightAmount,
	float distanceToLight,
	float4 lightPos,
	fixed4 lightColor,
	float4 lightAtten,
	float4 lightDir,
	float4 lightEnd,
	float lightMultiplier,
	inout fixed3 accumLightColor)
{
	// amount to move for each sample
	float3 step;

	// fog factor reducer is the amount of fog in front of the light, used to reduce the light
	float fogFactorReducer = 1.0 - CalculateFogFactor(distanceToLight * 0.33);

	// amount of fog on light ray
	float fogFactorOnRay = CalculateFogFactor(lightAmount);

	// sample points along the ray
	float lightSample;
	float attenSample = 0.0;
	float eyeLightDot;
	float3 startPos = rayOrigin + (rayDir * distanceToLight);
	float3 currentPos;
	float3 toLight;

	float dotSample1 = 0.0;
	float dotSample2 = 0.0;
	float distanceSample = 0.0;

	lightSample = 9999999.0;
	step = rayDir * (lightAmount * FOG_LIGHT_SPOT_SAMPLE_COUNT_INVERSE);
	currentPos = startPos - (step * 0.5);
	for (int i = 0; i < int(FOG_LIGHT_SPOT_SAMPLE_COUNT); i++)
	{
		currentPos += step;
		toLight = currentPos - lightPos.xyz;
		eyeLightDot = dot(toLight, toLight);
		distanceSample += eyeLightDot;
		lightSample = min(eyeLightDot, lightSample);
		eyeLightDot = saturate(((dot(normalize(toLight), lightDir.xyz)) - lightAtten.x) * lightAtten.y);
		dotSample1 = max(eyeLightDot, dotSample1);
		dotSample2 += eyeLightDot;
	}

	// calculate dot attenuation, light at more of an angle is dimmer
	eyeLightDot = (dotSample1 * 0.75) + (dotSample2 * FOG_LIGHT_SPOT_SAMPLE_COUNT_INVERSE * 0.25);
	dotSample1 = pow(eyeLightDot, _WeatherMakerFogLightFalloff.x * lightPos.w);

	// calculate light attenuation
	lightSample = 1.0 / (1.0 + (lightSample * lightAtten.z));

	// increase as eye looks at center from forward direction
	eyeLightDot = max(0.0, dot(-rayDir, lightDir.xyz));
	dotSample1 *= (1.0 + (lightColor.a * 2.0 * pow(eyeLightDot, 3.0)));

	// reduce light right near the tip to eliminate hard edges
	lightAmount = (min(1.0, distanceSample * FOG_LIGHT_SPOT_SAMPLE_COUNT_INVERSE)) * lightSample * dotSample1 * lightColor.a;

	// apply color
	accumLightColor += (lightColor.rgb * lightAmount * fogFactorReducer * fogFactorOnRay * lightMultiplier * _FogLightAbsorption

#if defined(UNITY_COLORSPACE_GAMMA)

		// brighten up gamma space to make it look more like linear
	* 1.8

#endif

	);
}

#if !defined(SHADER_API_D3D9) && !defined(WEATHER_MAKER_DISABLE_AREA_LIGHTS)

inline void ComputeLightColorForFogAreaLight
(
	float3 rayOrigin,
	float3 rayDir,
	float lightAmount,
	float distanceToLight,
	fixed4 lightColor,
	float4 lightAtten,
	float3 lightPos,
	float3 lightDir,
	float3 lightBoxMin,
	float3 lightBoxMax,
	float lightMultiplier,
	inout fixed3 accumLightColor)
{
	// amount to move for each sample
	float3 step;

	// fog factor reducer is the amount of fog in front of the light, used to reduce the light
	float fogFactorReducer = 1.0 - CalculateFogFactor(distanceToLight * 0.33);

	// amount of fog on light ray
	float fogFactorOnRay = CalculateFogFactor(lightAmount);

	// sample points along the ray
	float lightSample;
	float attenSample = 0.0;
	float eyeLightDot;
	float3 startPos = rayOrigin + (rayDir * distanceToLight);
	float3 currentPos;
	float3 toLight;
	float centerDistanceSquared;
	float dx;
	float dy;
	step = rayDir * (lightAmount * FOG_LIGHT_AREA_SAMPLE_COUNT_INVERSE);

	currentPos = startPos - (step * 0.5);
	lightSample = 0.0;

	for (int i = 0; i < int(FOG_LIGHT_AREA_SAMPLE_COUNT); i++)
	{
		currentPos += step;
		toLight = currentPos - lightPos.xyz;
		eyeLightDot = dot(toLight, toLight);
		attenSample = (1.0 / (1.0 + (eyeLightDot * lightAtten.z)));
		attenSample *= (1.0 - min(1.0, (eyeLightDot * lightAtten.w)));
		dx = max(lightBoxMin.x - toLight.x, toLight.x - lightBoxMax.x);
		dy = max(lightBoxMin.y - toLight.y, toLight.y - lightBoxMax.y);
		attenSample *= min(1.0, ((dx + dx) * (dy + dy)) * lightAtten.x);
		lightSample += attenSample;
	}

	// average samples
	lightSample *= FOG_LIGHT_AREA_SAMPLE_COUNT_INVERSE * CalculateFogFactor(lightAmount * 3.0) * lightColor.a; // * 3 because area lights look too dim in the fog otherwise

	// adjust intensity as eye looks at light
	eyeLightDot = max(0.0, -dot(rayDir, lightDir.xyz));
	lightSample *= (1.0 + eyeLightDot);

	// apply color
	accumLightColor += (lightColor.rgb * lightSample * fogFactorReducer * fogFactorOnRay * lightMultiplier * _FogLightAbsorption

#if defined(UNITY_COLORSPACE_GAMMA)

	// brighten up gamma space to make it look more like linear
	* 1.8

#endif
		
	);
}

#endif

fixed3 ComputePointLightFog(float3 rayOrigin, float3 rayDir, float rayLength, float fogFactor, fixed lightMultiplier)
{
	float lightAmount;
	float distanceToLight;
	fixed3 lightColor = fixed3Zero;

	// point lights
	UNITY_LOOP
	for (int lightIndex = 0; lightIndex < _WeatherMakerPointLightCount; lightIndex++)
	{
		// get the length of the ray intersecting the point light sphere
		UNITY_BRANCH
		if (RaySphereIntersect(rayOrigin, rayDir, rayLength, _WeatherMakerPointLightPosition[lightIndex], lightAmount, distanceToLight))
		{
			// compute lighting for the point light
			ComputeLightColorForFogPointLight(rayOrigin, rayDir, lightAmount, distanceToLight, _WeatherMakerPointLightPosition[lightIndex],
				_WeatherMakerPointLightColor[lightIndex], _WeatherMakerPointLightAtten[lightIndex], lightMultiplier, lightColor);
		}
	}

	return lightColor;
}

fixed3 ComputeSpotLightFog(float3 rayOrigin, float3 rayDir, float rayLength, float fogFactor, fixed lightMultiplier)
{
	float lightAmount;
	float distanceToLight;
	fixed3 lightColor = fixed3Zero;

	// spot lights
	UNITY_LOOP
	for (int lightIndex = 0; lightIndex < _WeatherMakerSpotLightCount; lightIndex++)
	{
		// get the length of the ray intersecting the spot light cone
		UNITY_BRANCH
		if (RayConeIntersect(rayOrigin, rayDir, rayLength, _WeatherMakerSpotLightPosition[lightIndex], _WeatherMakerSpotLightDirection[lightIndex],
			_WeatherMakerSpotLightSpotEnd[lightIndex], _WeatherMakerSpotLightAtten[lightIndex].x, lightAmount, distanceToLight))
		{
			// compute lighting for the spot light
			ComputeLightColorForFogSpotLight(rayOrigin, rayDir, lightAmount, distanceToLight, _WeatherMakerSpotLightPosition[lightIndex],
				_WeatherMakerSpotLightColor[lightIndex], _WeatherMakerSpotLightAtten[lightIndex], _WeatherMakerSpotLightDirection[lightIndex],
				_WeatherMakerSpotLightSpotEnd[lightIndex], lightMultiplier, lightColor);
		}
	}

	return lightColor;
}

fixed3 ComputeAreaLightFog(float3 rayOrigin, float3 rayDir, float rayLength, float fogFactor, fixed lightMultiplier)
{
	fixed3 lightColor = fixed3Zero;

#if !defined(SHADER_API_D3D9) && !defined(WEATHER_MAKER_DISABLE_AREA_LIGHTS)

	// area lights are always the origin pointing forward on z axis
	const float3 lightPos = float3Zero;
	const float3 lightDir = float3(0.0, 0.0, 1.0);

	float lightAmount;
	float distanceToLight;

	// area lights
	UNITY_LOOP
	for (int lightIndex = 0; lightIndex < _WeatherMakerAreaLightCount; lightIndex++)
	{
		// get the length of the ray intersecting the area light box
		rayOrigin = RotatePointZeroOriginQuaternion(rayOrigin - _WeatherMakerAreaLightPosition[lightIndex], _WeatherMakerAreaLightRotation[lightIndex]);
		rayDir = RotatePointZeroOriginQuaternion(rayDir, _WeatherMakerAreaLightRotation[lightIndex]);

		UNITY_BRANCH
		if (RayBoxIntersect(rayOrigin, rayDir, rayLength, _WeatherMakerAreaLightMinPosition[lightIndex].xyz,
			_WeatherMakerAreaLightMaxPosition[lightIndex].xyz, lightAmount, distanceToLight))
		{
			// compute lighting for the area light
			ComputeLightColorForFogAreaLight(rayOrigin, rayDir, lightAmount, distanceToLight, _WeatherMakerAreaLightColor[lightIndex],
				_WeatherMakerAreaLightAtten[lightIndex], lightPos, lightDir, _WeatherMakerAreaLightMinPosition[lightIndex], _WeatherMakerAreaLightMaxPosition[lightIndex], lightMultiplier, lightColor);
		}
	}

#endif

	return lightColor;
}

// f is fog factor, rayLength is distance of fog in ray, savedDepth is depth buffer
fixed4 ComputeFogLighting(float3 rayOrigin, float3 rayDir, float rayLength, float fogFactor, float2 screenUV, float noise)
{
	// TODO: Null zones do not eliminate light, they just reduce fog amount for pixel,
	// is there an optimized way to determine how much of a light volume is null zoned out?
	// skip expensive lighting where there is no fog
	if (fogFactor < 0.00001)
	{
		return fixed4(0.0, 0.0, 0.0, 0.0);
	}
	else
	{
		fixed4 lightColor;

		// directional light / ambient
		ComputeDirectionalLightFog(rayOrigin, rayDir, rayLength, fogFactor, lightColor.rgb, screenUV);

		if (WM_FOG_VOLUMETRIC_LIGHT_MODE_NOT_NONE)
		{
			float lightMultiplier = _PointSpotLightMultiplier * _WeatherMakerVolumetricPointSpotMultiplier;
			lightColor.rgb += ComputePointLightFog(rayOrigin, rayDir, rayLength, fogFactor, lightMultiplier);
			lightColor.rgb += ComputeSpotLightFog(rayOrigin, rayDir, rayLength, fogFactor, lightMultiplier);
			lightColor.rgb += ComputeAreaLightFog(rayOrigin, rayDir, rayLength, fogFactor, lightMultiplier);
		}

		lightColor.rgb *= _FogColor.rgb * noise;

		if (WM_FOG_SUN_SHAFT_ENABLE && WM_CAMERA_RENDER_MODE_NORMAL)
		{
			//for (int i = 0; i < _WeatherMakerDirLightCount; i++)
			{
				lightColor.rgb += ComputeFogShaftColor(screenUV, fogFactor, _WeatherMakerDirLightViewportPosition[0]);
			}
		}

		lightColor.a = fogFactor;
		lightColor.rgb += (noise * _FogEmissionColor.rgb); // _FogEmissionColor.a is already built into the shader property
		ApplyDither(lightColor.rgb, screenUV, _FogDitherLevel);
		return lightColor;
	}
}

inline float CalculateFogNoise3D(float3 pos, float3 rayDir, float rayLength, float scale, float3 velocity)
{
	float n = 0.0;
	float n2;
	float3 step = rayDir * scale;

	//pos += RotatePoint(_FogBoxCenter, float3(0, _WeatherMakerTime.x * 4, 0));// _WeatherMakerTime.y * 0.02, _WeatherMakerTime.x * 0.03));
	pos += _FogNoisePositionOffset;
	 
	pos *= scale;
	//pos += (step * int(_FogNoiseSampleCount));

	UNITY_LOOP
	for (int i = 0; i < int(_FogNoiseSampleCount); i++)
	//for (int i = int(_FogNoiseSampleCount); i > 0; i--)
	{
		float4 uv = float4(pos + velocity, -999.0);
		n += tex3Dlod(_WeatherMakerNoiseTexture3D, uv).a;
		pos += step;

		//n2 = tex3Dlod(_WeatherMakerNoiseTexture3D, float4(pos + velocity, -999.0)).a;
		//n2 = (n2 + _FogNoiseAdder) * _FogNoiseMultiplier;
		//n = n2 + (n * (1.0 - n2));
		//pos -= step;
	}

	//return n;
	n = ((n * _FogNoiseSampleCountInverse) + _FogNoiseAdder) * _FogNoiseMultiplier;
	return lerp(1.0, n, _FogNoisePercent);
}

inline float CalculateFogNoise3DOne(float3 pos, float scale, float3 velocity)
{
	return tex3Dlod(_WeatherMakerNoiseTexture3D, float4((pos * scale) + velocity, -999.0)).a;
}

inline void RaycastFogBoxFullScreen(float3 rayDir, float3 forwardLine, inout float depth, out float3 startPos, out float noise)
{
	// depth is 0-1 value, which needs to be changed to world space distance

	if (WM_CAMERA_RENDER_MODE_CUBEMAP)
	{
		startPos = _WorldSpaceCameraPos + (rayDir * depth * _ProjectionParams.z);
	}
	else
	{
		startPos = _WorldSpaceCameraPos + (depth * forwardLine);
	}

	// calculate depth exactly in world space
	depth = distance(startPos, _WorldSpaceCameraPos);
	startPos = _WorldSpaceCameraPos;
	float distanceToBox;
	float intersect;

	if (WM_FOG_HEIGHT_ENABLED)
	{
		// cast ray, get amount of intersection with the fog box
		float3 boxMin, boxMax;
		GetFullScreenBoundingBox(_FogHeight, boxMin, boxMax);
		intersect = RayBoxIntersect(_WorldSpaceCameraPos, rayDir, depth, boxMin, boxMax, depth, distanceToBox);
		startPos += (rayDir * distanceToBox * intersect);

		if (WM_FOG_NOISE_ENABLED)
		{
			// calculate noise
			noise = CalculateFogNoise3D(startPos, rayDir, depth, _FogNoiseScale, _FogNoiseVelocity);

			// remove noise where there is no fog
			noise *= (depth > 0.0 && _FogDensity > 0.0);
		}
		else
		{
			noise = 1.0;
		}
	}
	else if (WM_FOG_NOISE_ENABLED)
	{
		noise = CalculateFogNoise3D(startPos, rayDir, depth, _FogNoiseScale, _FogNoiseVelocity);
	}
	else
	{
		noise = 1.0;
	}

	GetNullZonesDepth(startPos, rayDir, depth);
}

// returns the original scene depth
inline void RaycastFogBox(float3 rayDir, float3 normal, float2 screenUV, inout float depth, out float3 startPos, out float noise)
{	
	// cast ray, get amount of intersection with the fog box
	float distanceToBox;
	if (RayBoxIntersect(_WorldSpaceCameraPos, rayDir, depth, _FogBoxMin, _FogBoxMax, depth, distanceToBox) == 0.0)
	{
		depth = 0.0;
		startPos = float3Zero;
		noise = 0.0;
	}
	else
	{
		startPos = _WorldSpaceCameraPos + (rayDir * distanceToBox);

		if (WM_FOG_NOISE_ENABLED)
		{
			// calculate noise
			noise = CalculateFogNoise3D(startPos, rayDir, depth, _FogNoiseScale, _FogNoiseVelocity);
		}
		else
		{
			noise = 1.0;
		}

		if (_FogVolumePower.x > 0.0)
		{
			// attempt to smooth height and edges of box fog, these are much more noticeable than sphere fog
			float3 endPos = startPos + (rayDir * depth);
			float3 pos = startPos;
			const float samples = 8;
			const float invSamples = 1.0 / 8.0;
			float smoothFactor = 0.0;
			float3 step = (endPos - startPos) * invSamples;
			float3 diam = (_FogBoxMax - _FogBoxMin);
			float diamYInv = 1.0 / diam.y;
			float3 halfDiamInv = 1.0 / (diam * 0.5);
			float yMax = _FogBoxMax.y;
			for (int i = 0; i < samples; i++)
			{
				pos += step;
				float3 diff = min(pos - _FogBoxMin, _FogBoxMax - pos);
				float heightFactor = saturate(0.75 + ((yMax - pos.y) * diamYInv));
				heightFactor = pow(heightFactor, _FogVolumePower.z);
				diff *= halfDiamInv;
				smoothFactor += (heightFactor * pow(max(_FogVolumePower.y, min(diff.x + diff.y, min(diff.y + diff.z, diff.z + diff.x))), _FogVolumePower.w));
				//factor += max(0.1, min(diff.x, max(diff.y, diff.z)));
				//factor += max(0.3, (diff.x + diff.y + diff.z) * 0.33);
				//factor += clamp(diff.x + diff.y + diff.z, 1, 2);
			}
			smoothFactor = min(1.0, smoothFactor * invSamples);

			noise *= smoothFactor;

			// reset startPos to new point
			startPos = _WorldSpaceCameraPos + (rayDir * distanceToBox);
		}
	}
}

// returns the original scene depth
inline void RaycastFogSphere(float3 rayDir, float3 normal, inout float depth, out float3 startPos, out float noise)
{
	float distanceToSphere;
	float4 pos = _FogSpherePosition;
	if (RaySphereIntersect(_WorldSpaceCameraPos, rayDir, depth, pos, depth, distanceToSphere) == 0.0)
	{
		depth = 0.0;
		startPos = float3Zero;
		noise = 0.0;
	}
	else
	{
		startPos = _WorldSpaceCameraPos + (rayDir * distanceToSphere);

		// attempt to smooth height and edges of sphere fog
		float halfDepth = depth * 0.5;
		float halfDepthSquared = halfDepth * halfDepth;
		float factor = min(1.0, halfDepthSquared * _FogVolumePower.x * _FogVolumePower.y * 10.0);

		if (WM_FOG_NOISE_ENABLED)
		{
			// calculate noise
			noise = CalculateFogNoise3D(startPos, rayDir, depth, _FogNoiseScale, _FogNoiseVelocity);
		}
		else
		{
			noise = 1.0;
		}

		noise *= pow(factor, _FogVolumePower.w);

		startPos = _WorldSpaceCameraPos + (rayDir * distanceToSphere);
	}
}

// sphere is xyz, w = radius squared, returns clarity
inline float RayMarchFogSphere(volumetric_data i, int iterations, float4 sphere, float density, float outerDensity, out float clarity, out float3 rayDir, out float3 sphereCenterViewSpace, out float maxDistance)
{
	float2 screenUV = i.projPos.xy / i.projPos.w;
	maxDistance = length(DECODE_EYEDEPTH(WM_SAMPLE_DEPTH(screenUV)) / normalize(i.viewPos).z);
	//float depthBufferDepth = LinearEyeDepth(WM_SAMPLE_DEPTH_PROJ(i.projPos));
	rayDir = normalize(i.viewPos.xyz);
	sphereCenterViewSpace = mul((float3x3)UNITY_MATRIX_V, (_WorldSpaceCameraPos - sphere.xyz));
	float invSphereRadiusSquared = 1.0 / sphere.w;

	// calculate sphere intersection
	float b = -dot(rayDir, sphereCenterViewSpace);
	float c = dot(sphereCenterViewSpace, sphereCenterViewSpace) - sphere.w;
	float d = sqrt((b * b) - c);
	float dist = b - d;
	float dist2 = b + d;

	/*
	float fA = dot(rayDir, rayDir);
	float fB = 2 * dot(rayDir, sphereCenterViewSpace);
	float fC = dot(sphereCenterViewSpace, sphereCenterViewSpace) - sphere.w;
	float fD = fB * fB - 4 * fA * fC;
	// if (fD <= 0.0f) { return; } // not sure if this is needed, doesn't seem to trigger very often
	float recpTwoA = 0.5 / fA;
	float DSqrt = sqrt(fD);
	// the distance to the front of sphere, or 0 if inside the sphere. This is the distance from the camera where sampling begins.
	float dist = max((-fB - DSqrt) * recpTwoA, 0);
	// total distance to the back of the sphere.
	float dist2 = max((-fB + DSqrt) * recpTwoA, 0);
	*/

	// stop at the back of the sphere or depth buffer, whichever is the smaller distance.
	float backDepth = min(maxDistance, dist2);

	// calculate initial sample distance, and the distance between samples.
	float samp = dist;
	float step_distance = (backDepth - dist) / (float)iterations;

	// how much does each step get modified? approaches 1 with distance.
	float step_contribution = (1 - 1 / pow(2, step_distance)) * density;

	// 1 means no fog, 0 means completely opaque fog
	clarity = 1;

	UNITY_LOOP
	for (int i = 0; i < iterations; i++)
	{
		float3 position = sphereCenterViewSpace + (rayDir * samp);
		float val = saturate(outerDensity * (1.0 - (dot(position, position) * invSphereRadiusSquared)));
		clarity *= (1.0 - saturate(val * step_contribution));
		samp += step_distance;
	}

	return clarity;
}

inline void PreFogFragment(volumetric_data i, out float depth, out float depth01, out float2 screenUV, out float3 rayDir)
{
	// get the depth of this pixel
	screenUV = i.projPos.xy / i.projPos.w;
	depth = WM_SAMPLE_DEPTH(screenUV);
	depth01 = Linear01Depth(depth);
	depth = length(DECODE_EYEDEPTH(depth) / normalize(i.viewPos).z);
	rayDir = normalize(i.rayDir);
}

inline fixed4 PostFogFragment(float3 startPos, float3 rayDir, float amount, float noise, float2 screenUV, out float fogFactor)
{
	GetNullZonesDepth(startPos, rayDir, amount);
	fogFactor = saturate(CalculateFogFactor(amount) * noise);
	return ComputeFogLighting(startPos, rayDir, amount, fogFactor, screenUV, noise);
}

// VERTEX AND FRAGMENT SHADERS ----------------------------------------------------------------------------------------------------

volumetric_data fog_volume_vertex_shader(appdata_base v)
{
	return GetVolumetricData(v);
}

fixed4 fog_box_full_screen_fragment_shader(full_screen_fragment i) : SV_TARGET
{
	WM_INSTANCE_FRAG(i);
	if (_FogMode == 0)
	{
		return fixed4Zero;
	}
	float3 rayDir = GetRayFromForwardLine(i.forwardLine);
	float depth01 = GetDepth01(i.uv.xy);
	float noise;
	float3 startPos;
	float depth = depth01; // gets set to the fog amount on the ray
	RaycastFogBoxFullScreen(rayDir, i.forwardLine, depth, startPos, noise);
	float fogFactor = saturate(CalculateFogFactorWithDither(depth, i.uv) * noise);
	return ComputeFogLighting(startPos, rayDir, depth, fogFactor, i.uv, noise);
}

fixed4 fog_box_fragment(volumetric_data i, out float depth, out float fogFactor, out float3 rayDir)
{
	WM_INSTANCE_FRAG(i);
	float noise;
	float2 screenUV;
	float depth01;
	PreFogFragment(i, depth, depth01, screenUV, rayDir);
	float3 startPos;
	RaycastFogBox(rayDir, i.normal, screenUV, depth, startPos, noise);
	if (_FogMode == 0)
	{
		fogFactor = 0.0;
		return fixed4Zero;
	}
	else
	{
		return PostFogFragment(startPos, rayDir, depth, noise, screenUV, fogFactor);
	}
}

fixed4 fog_box_fragment_shader(volumetric_data i) : SV_TARGET
{
	WM_INSTANCE_FRAG(i);
	if (_FogMode == 0)
	{
		return fixed4Zero;
	}
	float depth, fogFactor;
	float3 rayDir;
	return fog_box_fragment(i, depth, fogFactor, rayDir);
}

fixed4 fog_sphere_fragment_shader(volumetric_data i) : SV_TARGET
{
	WM_INSTANCE_FRAG(i);
	if (_FogMode == 0)
	{
		return fixed4Zero;
	}
	float noise, fogFactor;
	float2 screenUV;
	float3 startPos, rayDir;
	float depth, depth01;
	PreFogFragment(i, depth, depth01, screenUV, rayDir);
	RaycastFogSphere(rayDir, i.normal, depth, startPos, noise);
	return PostFogFragment(startPos, rayDir, depth, noise, screenUV, fogFactor);
}
