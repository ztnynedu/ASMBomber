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

#ifndef __WEATHER_MAKER_SHADER_LIGHT__
#define __WEATHER_MAKER_SHADER_LIGHT__

#include "UnityCG.cginc"
#include "Lighting.cginc"
#include "AutoLight.cginc"
#include "WeatherMakerConstantsShaderInclude.cginc"
#include "WeatherMakerNoiseShaderInclude.cginc"
#include "WeatherMakerShadows.cginc"
#include "UnityPBSLighting.cginc"
#include "UnityStandardBRDF.cginc"
#include "HLSLSupport.cginc"

// disable features...
// WEATHER_MAKER_LIGHT_NO_DIR_LIGHT - no dir light calculations
// WEATHER_MAKER_LIGHT_NO_NORMALS - no normal calculations, also removes specular
// WEATHER_MAKER_LIGHT_NO_SPECULAR - no specular calculations

// enable features...
// WEATHER_MAKER_LIGHT_SPECULAR_SPARKLE - enable specular sparkle (if WEATHER_MAKER_LIGHT_NO_NORMALS is defined and WEATHER_MAKER_LIGHT_NO_SPECULAR is not defined)
// WEATHER_MAKER_LIGHT_SPECULAR_TRANSLUCENT - allow specular translucency (i.e. water, glass, etc.) specular highlight on opposite side of surface

#if defined(SHADER_API_D3D9)
#define MAX_LIGHT_COUNT 4
#define MAX_MOON_COUNT 2
#else
#define MAX_LIGHT_COUNT 16
#define MAX_MOON_COUNT 8
#endif

struct wm_world_space_light_params
{
	float3 worldPos;
	fixed distanceToWorldPosSquared; // distance from camera to worldPos

#if !defined(WEATHER_MAKER_LIGHT_NO_DIFFUSE)

	fixed3 diffuseColor;
	fixed3 ambientColor;

#endif

	fixed shadowStrength;

#if !defined(WEATHER_MAKER_LIGHT_NO_NORMALS)

	float3 worldNormal;

#if !defined(WEATHER_MAKER_LIGHT_NO_SPECULAR)

	float3 rayDir;
	fixed3 specularColor;
	fixed specularPower;

#endif

#endif

#if defined(WEATHER_MAKER_LIGHT_SPECULAR_SPARKLE)

	sampler2D sparkleNoise;
	fixed3 sparkleTintColor;
	fixed4 sparkleScale;
	fixed4 sparkleOffset;
	fixed4 sparkleFade;

#endif

};

// time of day multipliers, all add up to 1
uniform fixed _WeatherMakerDayMultiplier;
uniform fixed _WeatherMakerDawnDuskMultiplier;
uniform fixed _WeatherMakerNightMultiplier;

// ambient light
uniform fixed3 _WeatherMakerAmbientLightColor;
uniform fixed3 _WeatherMakerAmbientLightColorSky;
uniform fixed3 _WeatherMakerAmbientLightColorGround;
uniform fixed3 _WeatherMakerAmbientLightColorEquator;

// dir lights
uniform int _WeatherMakerDirLightCount;
uniform float4 _WeatherMakerDirLightPosition[MAX_LIGHT_COUNT];
uniform float4 _WeatherMakerDirLightDirection[MAX_LIGHT_COUNT];
uniform fixed4 _WeatherMakerDirLightColor[MAX_LIGHT_COUNT];
uniform float4 _WeatherMakerDirLightViewportPosition[MAX_LIGHT_COUNT];
uniform float4 _WeatherMakerDirLightPower[MAX_LIGHT_COUNT]; // power, multiplier, shadow strength, 1 - shadow strength
uniform float4 _WeatherMakerDirLightQuaternion[MAX_LIGHT_COUNT]; // convert from world space to light space

// point lights
uniform int _WeatherMakerPointLightCount;
uniform float4 _WeatherMakerPointLightPosition[MAX_LIGHT_COUNT]; // w = range squared
uniform float4 _WeatherMakerPointLightDirection[MAX_LIGHT_COUNT];
uniform fixed4 _WeatherMakerPointLightColor[MAX_LIGHT_COUNT];
uniform float4 _WeatherMakerPointLightAtten[MAX_LIGHT_COUNT]; // -1, 1, quadratic atten / range squared, 1 / range squared

// spot lights
uniform int _WeatherMakerSpotLightCount;
uniform float4 _WeatherMakerSpotLightPosition[MAX_LIGHT_COUNT]; // w = falloff resistor, thinner angles do not fall off at edges
uniform float4 _WeatherMakerSpotLightDirection[MAX_LIGHT_COUNT]; // w = end circle radius squared
uniform fixed4 _WeatherMakerSpotLightColor[MAX_LIGHT_COUNT];
uniform float4 _WeatherMakerSpotLightAtten[MAX_LIGHT_COUNT]; // outer cutoff, cutoff, quadratic atten / range squared, 1 / range squared
uniform float4 _WeatherMakerSpotLightSpotEnd[MAX_LIGHT_COUNT]; // w = range squared

// area lights
#if !defined(SHADER_API_D3D9)

uniform int _WeatherMakerAreaLightCount;
uniform float4 _WeatherMakerAreaLightPosition[MAX_LIGHT_COUNT]; // w = range squared
uniform float4 _WeatherMakerAreaLightPositionEnd[MAX_LIGHT_COUNT]; // w = 0
uniform float4 _WeatherMakerAreaLightRotation[MAX_LIGHT_COUNT]; // quaternion
uniform float4 _WeatherMakerAreaLightDirection[MAX_LIGHT_COUNT]; // w = 0
uniform float4 _WeatherMakerAreaLightMinPosition[MAX_LIGHT_COUNT]; // AABB min, w = 0
uniform float4 _WeatherMakerAreaLightMaxPosition[MAX_LIGHT_COUNT]; // AABB max, w = 0
uniform fixed4 _WeatherMakerAreaLightColor[MAX_LIGHT_COUNT];
uniform float4 _WeatherMakerAreaLightAtten[MAX_LIGHT_COUNT]; // 1 / diagonal radius squared, (width + height) * 0.5, quadratic atten / range squared, 1 / range squared

#endif

uniform fixed4 _WeatherMakerFogLightFalloff = fixed4(1.2, 0.0, 0.0, 0.0); // spot light radius light falloff, 0, 0, 0
uniform fixed _WeatherMakerFogLightSunIntensityReducer = 0.8;
uniform fixed _WeatherMakerFogDirectionalLightScatterIntensity = 5.0;

uniform float3 _WeatherMakerSunDirectionUp; // direction to sun
uniform float3 _WeatherMakerSunDirectionUp2D; // direction to sun
uniform float3 _WeatherMakerSunDirectionDown; // direction sun is facing
uniform float3 _WeatherMakerSunDirectionDown2D; // direction sun is facing
uniform fixed4 _WeatherMakerSunColor; // sun light color
uniform fixed4 _WeatherMakerSunTintColor; // sun tint color
uniform float3 _WeatherMakerSunPositionNormalized; // sun position in world space, normalized
uniform float3 _WeatherMakerSunPositionWorldSpace; // sun position in world space
uniform float4 _WeatherMakerSunLightPower; // power, multiplier, shadow strength, 1.0 - shadow strength
uniform float4 _WeatherMakerSunVar1; // scale, sun intensity ^ 0.5, sun intensity ^ 0.75, sun intensity ^ 2

uniform int _WeatherMakerMoonCount; // moon count
uniform float3 _WeatherMakerMoonDirectionUp[MAX_MOON_COUNT]; // direction to moon
uniform float3 _WeatherMakerMoonDirectionDown[MAX_MOON_COUNT]; // direction moon is facing
uniform fixed4 _WeatherMakerMoonLightColor[MAX_MOON_COUNT]; // moon light color
uniform float4 _WeatherMakerMoonLightPower[MAX_MOON_COUNT]; // power, multiplier, shadow strength, 1.0 - shadow strength
uniform fixed4 _WeatherMakerMoonTintColor[MAX_MOON_COUNT]; // moon tint color
uniform float4 _WeatherMakerMoonVar1[MAX_MOON_COUNT]; // scale, 0, 0, 0

uniform fixed4 _TintColor;
uniform fixed3 _EmissiveColor;
uniform fixed _Intensity;
uniform fixed _DirectionalLightMultiplier;
uniform fixed _PointSpotLightMultiplier;
uniform fixed _AmbientLightMultiplier;

UNITY_DECLARE_DEPTH_TEXTURE(_CameraDepthTexture);

inline fixed CalculateDirLightAtten(float3 lightDir
	
#if !defined(WEATHER_MAKER_LIGHT_NO_NORMALS)

	, float3 normal
	
#endif

	)
{

#if defined(ORTHOGRAPHIC_MODE)

	fixed atten = pow(max(0.0, dot(lightDir, float3(0.0, 0.0, -1.0))), 0.5);

#elif !defined(WEATHER_MAKER_LIGHT_NO_NORMALS)

	fixed atten = max(0.0, dot(lightDir, normal));

#else

	fixed atten = 1.0;

#endif

	// average in a little bit from the direct line of site
	//atten = ((atten * 0.7) + (max(0.0, dot(worldViewDir, -normal)) * 0.3)) * 0.5;

	// horizonFade
	// atten *= saturate((lightDir.y + 0.1) * 3.0);

	return atten * _DirectionalLightMultiplier;
}

inline fixed CalculatePointLightAtten(float3 worldPos,
	
#if !defined(WEATHER_MAKER_LIGHT_NO_NORMALS)

	float3 worldNormal,
	
#endif
	
	float3 worldLightPos, float4 lightAtten)
{
	float3 toLight = (worldLightPos - worldPos);

#if defined(ORTHOGRAPHIC_MODE)

	// ignore view normal and point straight out along z axis
	fixed atten = dot(fixed3(0, 0, -1), normalize(toLight));

#else

	float lengthSq = max(0.000001, dot(toLight, toLight));
	fixed atten = (1.0 / (1.0 + (lengthSq * lightAtten.z)));
	fixed attenFalloff = 1.0 - pow(min(1.0, (lengthSq * lightAtten.w)), 2.0);
	atten *= attenFalloff;

#if !defined(WEATHER_MAKER_LIGHT_NO_NORMALS)

	toLight *= rsqrt(lengthSq);
	atten *= max(0.0, dot(worldNormal, toLight));

#endif

#endif

	return atten * _PointSpotLightMultiplier;
}

fixed CalculateSpotLightAtten(float3 worldPos,
	
#if !defined(WEATHER_MAKER_LIGHT_NO_NORMALS)

	float3 worldNormal,
	
#endif
	
	float3 worldLightPos, float3 worldLightDir, float4 lightAtten)
{
	float3 toLight = (worldLightPos - worldPos);
	float lengthSq = max(0.000001, dot(toLight, toLight));
	fixed atten = (1.0 / (1.0 + (lengthSq * lightAtten.z)));
	toLight *= rsqrt(lengthSq);

#if !defined(WEATHER_MAKER_LIGHT_NO_NORMALS)

	atten *= max(0.0, dot(worldNormal, toLight));

#endif

	float theta = max(0.0, dot(toLight, -worldLightDir.xyz));
	atten *= saturate((theta - lightAtten.x) * lightAtten.y);

	return atten * _PointSpotLightMultiplier;
}

#if !defined(SHADER_API_D3D9)

fixed CalculateAreaLightAtten(float3 worldPos,

#if !defined(WEATHER_MAKER_LIGHT_NO_NORMALS)

	float3 worldNormal,

#endif
	
	float3 worldLightPos, float3 worldLightDir, float4 worldLightRot, float3 lightBoxMin, float3 lightBoxMax, float4 lightAtten)
{
	// area light is in non-rotated local space, rotate the world coordinate around the light position to get it into the same space
	float3 toLight = (worldPos - worldLightPos);
	toLight = RotatePointZeroOriginQuaternion(toLight, worldLightRot);
	float inBox = PointBoxIntersect(toLight, lightBoxMin, lightBoxMax);
	float lengthSq = max(0.000001, dot(toLight, toLight));
	fixed atten = (1.0 / (1.0 + (lengthSq * lightAtten.z)));
	fixed attenFalloff = 1.0 - min(1.0, (lengthSq * lightAtten.w));
	atten *= attenFalloff;

	float dx = max(lightBoxMin.x - toLight.x, toLight.x - lightBoxMax.x);
	float dy = max(lightBoxMin.y - toLight.y, toLight.y - lightBoxMax.y);
	attenFalloff = min(1.0, ((dx + dx) * (dy + dy)) * lightAtten.x);
	atten *= attenFalloff;

#if !defined(WEATHER_MAKER_LIGHT_NO_NORMALS)

	toLight *= rsqrt(lengthSq);
	// rotate normal to get it in light space
	worldNormal = RotatePointZeroOriginQuaternion(worldNormal, worldLightRot);
	atten *= max(0.0, -dot(worldNormal, toLight));

#endif
	
	return inBox * atten * _PointSpotLightMultiplier;
}

#endif

inline fixed CalculateDirLightShadowPower(float3 worldPos, int dirIndex)
{

#if !defined(WEATHER_MAKER_SHADOWS_OFF) && !defined(ORTHOGRAPHIC_MODE)

	// for now include the sun only in shadow calc, otherwise just use 1
	if (dirIndex == 0 && _WeatherMakerDirLightColor[dirIndex].a > 0.01 && _WeatherMakerDirLightPower[dirIndex].z > 0.0 && _WeatherMakerDirLightPower[dirIndex].w < 1.0)
	{
		float4 cascadeWeights = GET_CASCADE_WEIGHTS(worldPos, 1.0);
		float4 samplePos = GET_SHADOW_COORDINATES(float4(worldPos, 1.0), cascadeWeights);

#if defined(WEATHER_MAKER_SHADOWS_SOFT)

		fixed shadowPower = UNITY_SAMPLE_SHADOW_4(_WeatherMakerShadowMapTexture, samplePos);

#else

		fixed shadowPower = UNITY_SAMPLE_SHADOW(_WeatherMakerShadowMapTexture, samplePos);

#endif
		
		return _WeatherMakerDirLightPower[dirIndex].w + (shadowPower * _WeatherMakerDirLightPower[dirIndex].z);
	}
	else
	{
		return 1.0;
	}

#else

	return 1.0;

#endif

}

inline fixed CalculateSunVolumetricShadowPower
(
	int sampleCount,
	float3 worldPos,
	float3 rayDir,
	float ditherMultiplier,
	float depth,
	float maxDistance,
	float shadowPower,
	float shadowPowerFade,
	float minShadowStrength
)
{

#if !defined(WEATHER_MAKER_SHADOWS_OFF) && (defined(WEATHER_MAKER_SHADOWS_SOFT) || defined(WEATHER_MAKER_SHADOWS_HARD))

	if (shadowPower > 0.001 && _WeatherMakerSunLightPower.z > 0.001 && sampleCount >= 1)
	{
		float4 cascadeWeights;
		float4 samplePos;
		float2 ditherXY = worldPos.xz;
		fixed shadowStrength = 0.0;
		float4 pos = float4(worldPos, 1.0);
		float amount = min(maxDistance, depth - distance(_WorldSpaceCameraPos, worldPos));

#if defined(SHADER_API_D3D9)

		sampleCount = 16;
		float invSample = 1.0 / 16.0;

#else

		sampleCount = int(clamp(ceil(amount) * 4.0, 1.0, sampleCount));
		float invSample = 1.0 / sampleCount;

#endif

		float dither = frac(cos(dot(ditherXY * _WeatherMakerTime.x, ditherMagic.xy)) * ditherMagic.z);
		dither *= (frac(dot(ditherMagic.xy, ditherXY * ditherMagic.zw)) - 0.5);
		dither = 1.0 + (dither * ditherMultiplier);
		fixed samp;
		float3 step = (rayDir * amount * invSample * dither);

#if defined(SHADER_API_D3D9)

		UNITY_UNROLL

#else

		UNITY_LOOP

#endif

		for (int i = 0.0; i < int(sampleCount); i++)
		{
			pos.xyz += step;
			cascadeWeights = GET_CASCADE_WEIGHTS(pos.xyz, 1.0);
			samplePos = GET_SHADOW_COORDINATES(pos, cascadeWeights);
			shadowStrength += UNITY_SAMPLE_SHADOW(_WeatherMakerShadowMapTexture, samplePos);
		}
		shadowStrength *= invSample;
		shadowStrength = _WeatherMakerSunLightPower.w + (shadowStrength * _WeatherMakerSunLightPower.z);
		return max(minShadowStrength, pow(shadowStrength, shadowPower * min(1.0, amount * shadowPowerFade)));
	}
	else

#endif

	{
		return 1.0;
	}
}

#if !defined(WEATHER_MAKER_LIGHT_NO_NORMALS) && !defined(WEATHER_MAKER_LIGHT_NO_SPECULAR)

inline fixed3 CalculateSpecularColor(fixed4 lightColor, float3 lightDir, fixed atten, wm_world_space_light_params p)
{
	// Phong
	//float3 reflectionVector = reflect(lightDir, p.worldNormal);
	//float4 specularTerm = pow(saturate(dot(reflectionVector, p.rayDir)), p.specularPower);

	// Blinn-Phong
	float3 halfVector = normalize(lightDir - p.rayDir);
	fixed halfVectorDot = max(0.0, dot(p.worldNormal, halfVector));

#if defined(WEATHER_MAKER_LIGHT_SPECULAR_TRANSLUCENT)

	halfVectorDot = max(halfVectorDot, dot(lightDir, p.rayDir));

#endif

	fixed specularTerm =  pow(halfVectorDot, p.specularPower);
	fixed3 specularColor = p.specularColor;

#if defined(WEATHER_MAKER_LIGHT_SPECULAR_SPARKLE)

	UNITY_BRANCH
	if (atten > 0.0 && p.sparkleScale.z <= 1.0 && p.sparkleScale.w > 0.0)
	{
		// sparkleFade = scale, speed, threshold, intensity
		float3 worldPos = p.worldPos;
		fixed distanceFade = min(1.0, p.sparkleFade.y / p.distanceToWorldPosSquared);
		float3 offset = (p.rayDir * p.sparkleOffset.x) +
			(p.rayDir * p.sparkleOffset.y) +
			(p.rayDir * p.sparkleOffset.z) +
			(p.rayDir * p.sparkleOffset.w);
		worldPos += offset;
		float3 samplePos = (worldPos * p.sparkleScale.x) + (p.rayDir * p.sparkleScale.y * _WeatherMakerTime.x);
		fixed sparkles = generic_noise_3d(samplePos);
		fixed fade = min(1.0, 1.0 - (p.sparkleScale.z - sparkles));
		fade = distanceFade * p.sparkleScale.w * (((p.sparkleFade.x <= 0.0) * (sparkles >= p.sparkleScale.z)) + ((p.sparkleFade.x > 0.0) * pow(fade, p.sparkleFade.x)));
		sparkles *= fade;
		specularColor += (sparkles * p.sparkleTintColor);
	}

#endif

	return (lightColor.rgb * specularColor.rgb * (specularTerm * atten * lightColor.a * (p.specularPower > 0.0)));
}

#endif

void CalculateDirLightColorWorldSpace(wm_world_space_light_params p, inout fixed3 diffuseLight, inout fixed3 specularLight, inout fixed shadowStrength)
{

#if !defined(WEATHER_MAKER_LIGHT_NO_DIR_LIGHT)

	UNITY_LOOP
	for (int dirIndex = 0; dirIndex < _WeatherMakerDirLightCount; dirIndex++)
	{
		fixed intensity = _WeatherMakerDirLightColor[dirIndex].a;

#if UNITY_VERSION < 2018

		intensity *= intensity;

#else

		intensity = min(intensity, intensity * intensity * 2.0);

#endif

		fixed diffuseTerm;
		fixed shadowPower = 1.0;

#if !defined(WEATHER_MAKER_SHADOWS_OFF) && !defined(ORTHOGRAPHIC_MODE)

		shadowPower = CalculateDirLightShadowPower(p.worldPos, dirIndex);

		// shadow power always reduces specular light, but only reduces diffuse if requested
		shadowPower *= shadowPower;
		diffuseTerm = (intensity * min(1.0, shadowPower * p.shadowStrength));

		// reduce specular light by a lot based on shadow power
		shadowPower *= shadowPower;
		shadowPower *= shadowPower;
		shadowStrength = shadowPower;

#else

		diffuseTerm = intensity;

#endif

		fixed atten = CalculateDirLightAtten(_WeatherMakerDirLightPosition[dirIndex].xyz

#if !defined(WEATHER_MAKER_LIGHT_NO_NORMALS)

			, p.worldNormal

#endif

		);
		diffuseTerm *= atten;

#if !defined(WEATHER_MAKER_LIGHT_NO_DIFFUSE)

		diffuseLight += (_WeatherMakerDirLightColor[dirIndex].rgb * diffuseTerm);

#endif

#if !defined(WEATHER_MAKER_LIGHT_NO_NORMALS) && !defined(WEATHER_MAKER_LIGHT_NO_SPECULAR)

		specularLight += CalculateSpecularColor(_WeatherMakerDirLightColor[dirIndex], _WeatherMakerDirLightPosition[dirIndex].xyz, atten * shadowPower * _WeatherMakerDirLightPower[dirIndex].z, p);

#endif

	}

#endif

}

void CalculatePointLightColorWorldSpace(wm_world_space_light_params p, inout fixed3 diffuseLight, inout fixed3 specularLight)
{
	UNITY_LOOP
	for (int pointIndex = 0; pointIndex < _WeatherMakerPointLightCount; pointIndex++)
	{
		float3 lightDir = normalize(_WeatherMakerPointLightPosition[pointIndex].xyz - p.worldPos);
		fixed pointAtten = CalculatePointLightAtten(p.worldPos,

#if !defined(WEATHER_MAKER_LIGHT_NO_NORMALS)

			p.worldNormal,

#endif

			_WeatherMakerPointLightPosition[pointIndex].xyz, _WeatherMakerPointLightAtten[pointIndex]);

#if !defined(WEATHER_MAKER_LIGHT_NO_DIFFUSE)

		diffuseLight += (_WeatherMakerPointLightColor[pointIndex].rgb * (pointAtten * _WeatherMakerPointLightColor[pointIndex].a));

#endif

#if !defined(WEATHER_MAKER_LIGHT_NO_NORMALS) && !defined(WEATHER_MAKER_LIGHT_NO_SPECULAR)

		specularLight += CalculateSpecularColor(_WeatherMakerPointLightColor[pointIndex], lightDir, pointAtten, p);

#endif

	}
}

void CalculateSpotLightColorWorldSpace(wm_world_space_light_params p, inout fixed3 diffuseLight, inout fixed3 specularLight)
{
	UNITY_LOOP
	for (int spotIndex = 0; spotIndex < _WeatherMakerSpotLightCount; spotIndex++)
	{
		float3 lightDir = normalize(_WeatherMakerSpotLightPosition[spotIndex].xyz - p.worldPos);
		fixed spotAtten = CalculateSpotLightAtten(p.worldPos,

#if !defined(WEATHER_MAKER_LIGHT_NO_NORMALS)

			p.worldNormal,

#endif

			_WeatherMakerSpotLightPosition[spotIndex].xyz, _WeatherMakerSpotLightDirection[spotIndex].xyz, _WeatherMakerSpotLightAtten[spotIndex]);

#if !defined(WEATHER_MAKER_LIGHT_NO_DIFFUSE)

		diffuseLight += (_WeatherMakerSpotLightColor[spotIndex].rgb * (spotAtten * _WeatherMakerSpotLightColor[spotIndex].a));

#endif

#if !defined(WEATHER_MAKER_LIGHT_NO_NORMALS) && !defined(WEATHER_MAKER_LIGHT_NO_SPECULAR)

		specularLight += CalculateSpecularColor(_WeatherMakerSpotLightColor[spotIndex], lightDir, spotAtten, p);

#endif

	}
}

void CalculateAreaLightColorWorldSpace(wm_world_space_light_params p, inout fixed3 diffuseLight, inout fixed3 specularLight)
{

#if !defined(SHADER_API_D3D9) && !defined(WEATHER_MAKER_DISABLE_AREA_LIGHTS)

	UNITY_LOOP
	for (int areaIndex = 0; areaIndex < _WeatherMakerAreaLightCount; areaIndex++)
	{
		float3 lightDir = normalize(_WeatherMakerAreaLightPosition[areaIndex].xyz - p.worldPos);
		fixed areaAtten = CalculateAreaLightAtten(p.worldPos,


#if !defined(WEATHER_MAKER_LIGHT_NO_NORMALS)

			p.worldNormal,

#endif

			_WeatherMakerAreaLightPosition[areaIndex].xyz, _WeatherMakerAreaLightDirection[areaIndex],
			_WeatherMakerAreaLightRotation[areaIndex], _WeatherMakerAreaLightMinPosition[areaIndex].xyz,
			_WeatherMakerAreaLightMaxPosition[areaIndex].xyz, _WeatherMakerAreaLightAtten[areaIndex]);

#if !defined(WEATHER_MAKER_LIGHT_NO_DIFFUSE)

		diffuseLight += (_WeatherMakerAreaLightColor[areaIndex].rgb * (areaAtten * _WeatherMakerAreaLightColor[areaIndex].a));

#endif

#if !defined(WEATHER_MAKER_LIGHT_NO_NORMALS) && !defined(WEATHER_MAKER_LIGHT_NO_SPECULAR)

		specularLight += CalculateSpecularColor(_WeatherMakerAreaLightColor[areaIndex], lightDir, areaAtten, p);

#endif

	}

#endif

}

fixed4 CalculateLightColorWorldSpace(wm_world_space_light_params p)
{
	fixed3 diffuseLight = float3Zero;
	fixed shadowStrength = 1.0;
	fixed3 specularLight = float3Zero;

	CalculateDirLightColorWorldSpace(p, diffuseLight, specularLight, shadowStrength);
	CalculatePointLightColorWorldSpace(p, diffuseLight, specularLight);
	CalculateSpotLightColorWorldSpace(p, diffuseLight, specularLight);
	CalculateAreaLightColorWorldSpace(p, diffuseLight, specularLight);

#if defined(WEATHER_MAKER_LIGHT_NO_DIFFUSE)

	return fixed4(specularLight, shadowStrength);

#else

	diffuseLight += (p.ambientColor.rgb * _AmbientLightMultiplier);
	diffuseLight *= p.diffuseColor;

#if !defined(WEATHER_MAKER_LIGHT_NO_NORMALS) && !defined(WEATHER_MAKER_LIGHT_NO_SPECULAR)

	diffuseLight += specularLight;

#endif

	return fixed4(diffuseLight, shadowStrength);

#endif

}

inline fixed GetMieScattering(float cosAngle)
{
	const float MIEGV_COEFF = 0.1;
	const float4 MIEGV = float4(1.0 - (MIEGV_COEFF * MIEGV_COEFF), 1.0 + (MIEGV_COEFF * MIEGV_COEFF), 2.0 * MIEGV_COEFF, 1.0f / (4.0f * 3.14159265358979323846));
	return MIEGV.w * (MIEGV.x / (pow(MIEGV.y - (MIEGV.z * cosAngle), 1.5)));
}

#endif
