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

#ifndef __WEATHER_MAKER_OVERLAY_SHADER__
#define __WEATHER_MAKER_OVERLAY_SHADER__

#include "WeatherMakerFogShader.cginc"

uniform sampler2D _OverlayTexture;
uniform sampler2D _OverlayNormalTexture;

uniform float _OverlayIntensity;
uniform float _OverlayNormalReducer;
uniform float _OverlayScale;
uniform fixed2 _OverlayOffset;
uniform fixed2 _OverlayVelocity;
uniform fixed3 _OverlayColor;
uniform fixed3 _OverlaySpecularColor;
uniform fixed _OverlaySpecularIntensity = 4.0;
uniform fixed _OverlaySpecularPower = 4.0;

uniform float _OverlayMinHeight;
uniform fixed _OverlayMinHeightNoiseMultiplier;
uniform fixed _OverlayMinHeightNoiseAdder;
uniform fixed _OverlayMinHeightFalloffMultiplier;
uniform fixed _OverlayMinHeightFalloffPower;

uniform sampler2D _OverlayNoiseHeightTexture;
uniform fixed _OverlayMinHeightNoiseScale;
uniform fixed2 _OverlayMinHeightNoiseOffset;
uniform fixed2 _OverlayMinHeightNoiseVelocity;

uniform sampler2D _OverlayNoiseTexture;
uniform fixed _OverlayNoiseMultiplier;
uniform fixed _OverlayNoisePower;
uniform fixed _OverlayNoiseAdder;
uniform fixed _OverlayNoiseScale;
uniform fixed2 _OverlayNoiseOffset;
uniform fixed2 _OverlayNoiseVelocity;

uniform sampler2D _CameraGBufferTexture2;

uniform int _OverlayNoiseEnabled;
uniform int _OverlayMinHeightNoiseEnabled;
#define WM_OVERLAY_NOISE_ENABLED (_OverlayNoiseEnabled)
#define WM_OVERLAY_MIN_HEIGHT_ENABLED (_OverlayMinHeight > 0.0)
#define WM_OVERLAY_MIN_HEIGHT_NOISE_ENABLED (_OverlayMinHeightNoiseEnabled)

fixed4 ComputeOverlayColor(float3 worldPos, float3 ray, float3 normal, float depth)
{
	fixed alpha = ClipWorldPosNullZonesAlpha(worldPos);
	float noiseMultiplier = 1.0;

	if (WM_OVERLAY_MIN_HEIGHT_ENABLED)
	{
		float worldPosYWithNoise = worldPos.y;

		if (WM_OVERLAY_MIN_HEIGHT_NOISE_ENABLED)
		{
			// sample noise from texture
			float heightNoise = (CalculateNoiseXZ(_OverlayNoiseHeightTexture, worldPos, _OverlayMinHeightNoiseScale, _OverlayMinHeightNoiseOffset, _OverlayMinHeightNoiseVelocity, _OverlayMinHeightNoiseMultiplier, _OverlayMinHeightNoiseAdder) - 0.5) * 15.0;
			worldPosYWithNoise += heightNoise;

			// if world pos y is too low, clip
			clip(0.5 - (worldPosYWithNoise < _OverlayMinHeight));
		}
		else
		{
			// basic noise function
			float heightNoise = _OverlayMinHeightNoiseAdder + ((sin(worldPos.x * 0.5) * 4.0 * _OverlayMinHeightNoiseMultiplier) - (sin(worldPos.z * 0.5) * 4.0) * _OverlayMinHeightNoiseMultiplier);
			worldPosYWithNoise += heightNoise;

			// if world pos y is too low, clip
			clip(0.5 - (worldPosYWithNoise < _OverlayMinHeight));
		}

		noiseMultiplier = pow(min(1.0, (worldPosYWithNoise / _OverlayMinHeight) * _OverlayMinHeightFalloffMultiplier), _OverlayMinHeightFalloffPower);
	}

	float noise = 1.0;
	if (WM_OVERLAY_NOISE_ENABLED)
	{
		noise = CalculateNoiseXZ(_OverlayNoiseTexture, worldPos, _OverlayNoiseScale, _OverlayNoiseOffset, _OverlayNoiseVelocity, _OverlayNoiseMultiplier, _OverlayNoiseAdder);
		noise = pow(abs(noise), _OverlayNoisePower) * sign(noise) * noiseMultiplier;
	}

	float normalReducer = max(0.0, (normal.y - _OverlayNormalReducer));
	float overlayAmount = normalReducer * _OverlayIntensity;
	float4 overlayLookup = float4((worldPos.xz * _OverlayScale) + _OverlayOffset + (max(0.1, normal.y) * _OverlayVelocity), 0.0, 0.0);
	fixed4 overlayColor = tex2Dlod(_OverlayTexture, overlayLookup);
	overlayAmount = saturate(overlayAmount * overlayColor.a * noise);

	// if no overlay at all, just exit out, avoid pointless light calculations
	clip(-0.0001 + overlayAmount);

	alpha *= overlayAmount;
	fixed4 specularColor = fixed4(_OverlaySpecularColor, _OverlaySpecularIntensity);
	wm_world_space_light_params p;
	p.worldPos = worldPos;
	p.worldNormal = normal;
	p.diffuseColor = overlayColor.rgb;
	p.rayDir = ray;
	p.specularColor = specularColor.rgb * specularColor.a;
	p.specularPower = _OverlaySpecularPower;
	p.ambientColor = _WeatherMakerAmbientLightColorGround;
	p.shadowStrength = 1.0;
	overlayColor.rgb = CalculateLightColorWorldSpace(p).rgb * _OverlayColor * overlayAmount * alpha;

	return fixed4(overlayColor.rgb, alpha);
}

#endif
