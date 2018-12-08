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

#include "WeatherMakerShader.cginc"

#if defined(SHADER_API_D3D9)
#define MAX_NULL_ZONE_COUNT 2
#else
#define MAX_NULL_ZONE_COUNT 16
#endif

uniform int _NullZoneCount;
uniform float4 _NullZonesMin[MAX_NULL_ZONE_COUNT];
uniform float4 _NullZonesMax[MAX_NULL_ZONE_COUNT];
uniform float4 _NullZonesCenter[MAX_NULL_ZONE_COUNT];
uniform float4 _NullZonesQuaternion[MAX_NULL_ZONE_COUNT];

inline bool CheckNullZoneMask(int nullIndex)
{

#if defined(NULL_ZONE_RENDER_MASK) && SHADER_TARGET >= 30

#if SHADER_TARGET >= 40

	uint mask = abs(_NullZonesMin[nullIndex].w); // w of min pos is mask
	return ((mask & NULL_ZONE_RENDER_MASK) == 0);

#else

	switch (abs(_NullZonesMin[nullIndex].w))
	{
	default: return true;
	case 1: return (NULL_ZONE_RENDER_MASK != 1);
	case 2: return (NULL_ZONE_RENDER_MASK != 2);
	case 3: return (NULL_ZONE_RENDER_MASK != 1 && NULL_ZONE_RENDER_MASK != 2);
	case 4: return (NULL_ZONE_RENDER_MASK != 4);
	case 5: return (NULL_ZONE_RENDER_MASK != 1 && NULL_ZONE_RENDER_MASK != 4);
	case 6: return (NULL_ZONE_RENDER_MASK != 2 && NULL_ZONE_RENDER_MASK != 4);
	case 7: return (NULL_ZONE_RENDER_MASK != 1 && NULL_ZONE_RENDER_MASK != 2 && NULL_ZONE_RENDER_MASK != 4);
	case 8: return (NULL_ZONE_RENDER_MASK != 8);
	case 9: return (NULL_ZONE_RENDER_MASK != 1 && NULL_ZONE_RENDER_MASK != 8);
	case 10: return (NULL_ZONE_RENDER_MASK != 2 && NULL_ZONE_RENDER_MASK != 8);
	case 11: return (NULL_ZONE_RENDER_MASK != 1 && NULL_ZONE_RENDER_MASK != 2 && NULL_ZONE_RENDER_MASK != 8);
	case 12: return (NULL_ZONE_RENDER_MASK != 4 && NULL_ZONE_RENDER_MASK != 8);
	case 13: return (NULL_ZONE_RENDER_MASK != 1 && NULL_ZONE_RENDER_MASK != 4 && NULL_ZONE_RENDER_MASK != 8);
	case 14: return (NULL_ZONE_RENDER_MASK != 2 && NULL_ZONE_RENDER_MASK != 4 && NULL_ZONE_RENDER_MASK != 8);
	case 15: return (NULL_ZONE_RENDER_MASK != 1 && NULL_ZONE_RENDER_MASK != 2 && NULL_ZONE_RENDER_MASK != 4 && NULL_ZONE_RENDER_MASK != 8);
	}

#endif

#else

	return true;

#endif

}

inline float NullZoneRayIntersect(int nullIndex, float3 startPos, float3 rayDir, float depth, out float amount, out float distanceToBox)
{
	UNITY_BRANCH
	if (_NullZonesCenter[nullIndex].w)
	{
		// need to rotate startPos and rayDir
		startPos = RotatePointZeroOriginQuaternion(startPos - _NullZonesCenter[nullIndex].xyz, _NullZonesQuaternion[nullIndex]);
		rayDir = RotatePointZeroOriginQuaternion(rayDir, _NullZonesQuaternion[nullIndex]);
	}
	return RayBoxIntersect(startPos, rayDir, depth, _NullZonesMin[nullIndex].xyz, _NullZonesMax[nullIndex].xyz, amount, distanceToBox);
}

inline float3 RotateNullZoneWorldPos(int nullIndex, float3 worldPos)
{
	return (worldPos * (1.0 - _NullZonesCenter[nullIndex].w)) +
		(_NullZonesCenter[nullIndex].w * RotatePointZeroOriginQuaternion(worldPos - _NullZonesCenter[nullIndex].xyz, _NullZonesQuaternion[nullIndex]));
}

inline void ClipWorldPosNullZone(int nullIndex, float3 worldPos)
{
	float3 worldPosRotated = RotateNullZoneWorldPos(nullIndex, worldPos);
	float3 minPos = _NullZonesMin[nullIndex].xyz;
	float3 maxPos = _NullZonesMax[nullIndex].xyz;

	// as long as the overlay is outside all null zones it can render
	clip(-0.5 + (
		worldPosRotated.x < minPos.x ||
		worldPosRotated.y < minPos.y ||
		worldPosRotated.z < minPos.z ||
		worldPosRotated.x > maxPos.x ||
		worldPosRotated.y > maxPos.y ||
		worldPosRotated.z > maxPos.z));
}

inline fixed ClipWorldPosNullZoneAlpha(int nullIndex, float3 worldPos)
{
	float3 minPos = _NullZonesMin[nullIndex].xyz;
	float3 maxPos = _NullZonesMax[nullIndex].xyz;
	float fade = _NullZonesMax[nullIndex].w;
	float3 worldPosRotated = RotateNullZoneWorldPos(nullIndex, worldPos);
	float worldPosOutOfZone =
		worldPosRotated.x < minPos.x ||
		worldPosRotated.y < minPos.y ||
		worldPosRotated.z < minPos.z ||
		worldPosRotated.x > maxPos.x ||
		worldPosRotated.y > maxPos.y ||
		worldPosRotated.z > maxPos.z;

#if NULL_ZONE_RENDER_MASK == 4

	// if special fade option and the world pos is in the zone, do special fade option
	UNITY_BRANCH
	if (fade <= 0.0)
	{
		UNITY_BRANCH
		if (worldPosOutOfZone == 0.0)
		{
			float3 camPosRotated = RotateNullZoneWorldPos(nullIndex, _WorldSpaceCameraPos);
			float cameraOutOfZone =
				camPosRotated.x < minPos.x ||
				camPosRotated.y < minPos.y ||
				camPosRotated.z < minPos.z ||
				camPosRotated.x > maxPos.x ||
				camPosRotated.y > maxPos.y ||
				camPosRotated.z > maxPos.z;

			// fade as camera gets closer to the zone, camera in zone has 0 fade
			float3 deltaPos = cameraOutOfZone * max(float3Zero, max(minPos - camPosRotated, camPosRotated - maxPos));
			float d = dot(deltaPos, deltaPos);
			return min(1.0, d * abs(fade));
		}
		else
		{
			// overlay out of the zone at full strength
			return 1.0;
		}
	}
	else
	{

#endif

		// clip if world pos is in the zone
		clip(-0.5 + worldPosOutOfZone);

		// negative fade outside of an overlay mask, make sure it is positive
		fade = abs(fade);

		float3 deltaPos = max(float3Zero, max(minPos - worldPosRotated, worldPosRotated - maxPos));
		float d = dot(deltaPos, deltaPos);

		return min(1.0, d * fade); // w of max pos is fade

#if NULL_ZONE_RENDER_MASK == 4

	}

#endif

}

inline void ClipWorldPosNullZones(float3 worldPos)
{
	UNITY_BRANCH
	if (_NullZoneCount > 0)
	{
		UNITY_LOOP
		for (int nullIndex = 0; nullIndex < _NullZoneCount; nullIndex++)
		{
			if (CheckNullZoneMask(nullIndex))
			{
				ClipWorldPosNullZone(nullIndex, worldPos);
			}
		}
	}
}

inline fixed ClipWorldPosNullZonesAlpha(float3 worldPos)
{
	fixed alpha = 1.0;

	UNITY_BRANCH
	if (_NullZoneCount > 0)
	{
		UNITY_LOOP
		for (int nullIndex = 0; nullIndex < _NullZoneCount; nullIndex++)
		{
			if (CheckNullZoneMask(nullIndex))
			{
				alpha *= ClipWorldPosNullZoneAlpha(nullIndex, worldPos);
			}
		}
	}

	return alpha;
}

inline float ClipWorldPosNullZonesFade(float3 worldPos, float3 rayDir, float depth, float worldPosDepth, float invFade)
{
	float alpha = 1.0;
	UNITY_BRANCH
	if (_NullZoneCount > 0)
	{
		rayDir = normalize(rayDir);
		float amount, toBox, sceneZ, diff;
		UNITY_LOOP
		for (int nullIndex = 0; nullIndex < _NullZoneCount; nullIndex++)
		{
			if (CheckNullZoneMask(nullIndex))
			{
				ClipWorldPosNullZone(nullIndex, worldPos);
				float intersect = NullZoneRayIntersect(nullIndex, _WorldSpaceCameraPos, rayDir, depth, amount, toBox);
				UNITY_FLATTEN
				if (intersect)
				{
					UNITY_FLATTEN
					if (toBox < 0.01)
					{
						// inside the null zone looking out
						sceneZ = length(rayDir * amount);
						diff = (worldPosDepth - sceneZ);
					}
					else
					{
						// outside the null zone looking in
						sceneZ = length(rayDir * toBox);
						diff = (sceneZ - worldPosDepth);
					}
					alpha *= saturate(invFade * diff);
				}
			}
		}
	}
	return alpha;
}

inline void GetNullZonesDepth(float3 startPos, float3 rayDir, inout float depth)
{
	float nullDepth, distanceToBox, intersect;
	UNITY_LOOP
	for (int nullIndex = 0; nullIndex < _NullZoneCount; nullIndex++)
	{
		if (CheckNullZoneMask(nullIndex))
		{
			intersect = NullZoneRayIntersect(nullIndex, startPos, rayDir, depth, nullDepth, distanceToBox);
			depth = max(0.0, depth - (intersect * nullDepth));
		}
	}
}
