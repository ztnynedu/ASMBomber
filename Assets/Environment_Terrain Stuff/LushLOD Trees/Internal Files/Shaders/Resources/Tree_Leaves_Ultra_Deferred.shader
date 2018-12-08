// Shader created with Shader Forge v1.38 
// Shader Forge (c) Neat Corporation / Joachim Holmer - http://www.acegikmo.com/shaderforge/
// Note: Manually altering this data may prevent you from opening it in Shader Forge
/*SF_DATA;ver:1.38;sub:START;pass:START;ps:flbk:,iptp:0,cusa:True,bamd:0,cgin:QwBHAEkAbgBjAGwAdQBkAGUAcwAvAFMAZQBhAG0AcwBCAGwAZQBuAGQAaQBuAGcAXwBOAG8AQQBuAGcAdQBsAGEAcgB8AEMARwBJAG4AYwBsAHUAZABlAHMALwBXAG8AcgBsAGQAUABvAHMAaQB0AGkAbwBuAEMAZQBuAHQAZQByAHwAQwBHAEkAbgBjAGwAdQBkAGUAcwAvAEQAaQB0AGgAZQByAGkAbgBnAA==,lico:0,lgpr:1,limd:0,spmd:1,trmd:0,grmd:0,uamb:True,mssp:True,bkdf:False,hqlp:False,rprd:False,enco:False,rmgx:True,imps:True,rpth:0,vtps:0,hqsc:True,nrmq:1,nrsp:0,vomd:0,spxs:False,tesm:0,olmd:1,culm:2,bsrc:0,bdst:1,dpts:2,wrdp:True,dith:0,atcv:False,rfrpo:False,rfrpn:Refraction,coma:15,ufog:True,aust:False,igpj:False,qofs:0,qpre:1,rntp:1,fgom:False,fgoc:False,fgod:False,fgor:False,fgmd:0,fgcr:0.5661765,fgcg:1,fgcb:0.6589251,fgca:1,fgde:0.0015,fgrn:0,fgrf:300,stcl:True,atwp:False,stva:191,stmr:255,stmw:255,stcp:6,stps:2,stfa:0,stfz:0,ofsf:0,ofsu:0,f2p0:False,fnsp:False,fnfb:True,fsmp:False;n:type:ShaderForge.SFN_Final,id:2865,x:37036,y:31170,varname:node_2865,prsc:2|custl-8659-OUT,alpha-1313-OUT,clip-3378-OUT;n:type:ShaderForge.SFN_Color,id:6665,x:30049,y:31284,ptovrint:False,ptlb:Color,ptin:_Color,varname:_Color,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,c1:0.5019608,c2:0.5019608,c3:0.5019608,c4:1;n:type:ShaderForge.SFN_Tex2d,id:7736,x:31162,y:31457,varname:node_3116_MAINPASS,prsc:2,ntxv:0,isnm:False|TEX-6298-TEX;n:type:ShaderForge.SFN_Slider,id:6832,x:29893,y:31691,ptovrint:False,ptlb:Transparency,ptin:_Transparency,varname:_Transparency,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,min:0,cur:1,max:1;n:type:ShaderForge.SFN_Slider,id:5916,x:29905,y:31591,ptovrint:False,ptlb:Cutoff,ptin:_Cutoff,varname:_Cutoff,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,min:0,cur:0.7,max:1;n:type:ShaderForge.SFN_Tex2dAsset,id:6298,x:30746,y:31512,ptovrint:False,ptlb:MainTex,ptin:_MainTex,varname:_MainTex,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,ntxv:0,isnm:False;n:type:ShaderForge.SFN_Slider,id:1495,x:29905,y:31464,ptovrint:False,ptlb:ShadowTransparency,ptin:_ShadowTransparency,varname:_ShadowTransparency,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,min:0,cur:0,max:1;n:type:ShaderForge.SFN_ViewVector,id:628,x:30047,y:30669,varname:node_628,prsc:2;n:type:ShaderForge.SFN_Dot,id:1391,x:30253,y:30732,cmnt:Check if view is opposite the direction of sunlight,varname:node_1391,prsc:2,dt:4|A-628-OUT,B-5541-OUT;n:type:ShaderForge.SFN_Set,id:3191,x:31785,y:31594,varname:TexAlpha,prsc:2|IN-8560-OUT;n:type:ShaderForge.SFN_Set,id:8286,x:30246,y:31706,varname:Param_Transparency_MAINPASS,prsc:2|IN-6832-OUT;n:type:ShaderForge.SFN_Set,id:7766,x:30246,y:31590,varname:Param_Cutoff,prsc:2|IN-5916-OUT;n:type:ShaderForge.SFN_Set,id:7143,x:30246,y:31467,varname:Param_ShadowTrans_SHADOWPASS,prsc:2|IN-1495-OUT;n:type:ShaderForge.SFN_Set,id:6838,x:29515,y:32815,varname:DITHER_MAINPASS,prsc:2|IN-3666-OUT;n:type:ShaderForge.SFN_Set,id:4973,x:31394,y:31457,varname:MainTexIN,prsc:2|IN-7736-RGB;n:type:ShaderForge.SFN_Tex2d,id:4547,x:31004,y:31905,cmnt:Color and alpha from UV3 is used by the horizontal plane to draw the Line Z and part of the circle,varname:node_3117_MAINPASS,prsc:2,ntxv:0,isnm:False|UVIN-327-UVOUT,TEX-6298-TEX;n:type:ShaderForge.SFN_TexCoord,id:327,x:30741,y:31891,varname:node_327,prsc:2,uv:2,uaff:False;n:type:ShaderForge.SFN_Set,id:9204,x:31385,y:31915,varname:UV3Color_IN,prsc:2|IN-7074-OUT;n:type:ShaderForge.SFN_Tex2d,id:9956,x:31004,y:31702,cmnt:Color and alpha from UV4 is used by all three planes to draw all or parts of their circlecrosses,varname:node_3118_MAINPASS,prsc:2,ntxv:0,isnm:False|UVIN-3765-UVOUT,TEX-6298-TEX;n:type:ShaderForge.SFN_TexCoord,id:3765,x:30741,y:31706,varname:node_3765,prsc:2,uv:3,uaff:False;n:type:ShaderForge.SFN_Set,id:1759,x:31365,y:31705,varname:UV4Color_IN,prsc:2|IN-4247-OUT;n:type:ShaderForge.SFN_Set,id:6719,x:30657,y:30874,cmnt:Darkens the trees when viewed from the back side,varname:Backside_Darkening_Amount,prsc:2|IN-1391-OUT;n:type:ShaderForge.SFN_Set,id:7375,x:30554,y:31300,varname:Param_Color,prsc:2|IN-8651-OUT;n:type:ShaderForge.SFN_Set,id:4895,x:29518,y:31462,varname:FinalColor_Corrected,prsc:2|IN-2577-OUT;n:type:ShaderForge.SFN_Set,id:6116,x:29517,y:32104,varname:WorldPosCenter,prsc:2|IN-6240-OUT;n:type:ShaderForge.SFN_Code,id:9670,x:30318,y:31904,varname:node_9670,prsc:2,code:VABoAGUAIABjAG8AZABlACAAdABvACAAdABoAGUAIAByAGkAZwBoAHQAIABnAGUAdABzACAAdABoAGUAIABwAGkAeABlAGwACgBjAG8AbABvAHIAIABmAHIAbwBtACAAdABoAGUAIABVAFYAMwAgAGEAbgBkACAAVQBWADQALgAgAFQAaABlAHMAZQAgAFUAVgBzAAoAdwBlAHIAZQAgAGMAYQBsAGMAdQBsAGEAdABlAGQAIABlAHgAcAByAGUAcwBzAGwAeQAgAGIAeQAgAHQAaABlAAoATAB1AHMAaABMAE8ARABUAHIAZQBlAEMAbwBuAHYAZQByAHQAZQByAC4AYwBzACAAcwBjAHIAaQBwAHQAIAB3AGgAZQBuAAoAdABoAGUAIABiAGkAbABsAGIAbwBhAHIAZAAgAG0AZQBzAGgAIAB3AGEAcwAgAGMAcgBlAGEAdABlAGQALgAgAFQAaABlAHkACgBjAG8AbgB0AGEAaQBuACAAdABoAGkAbgAgAGwAaQBuAGUAcwAgACgAMQAgAHAAaQB4AGUAbAAgAHQAaABpAGMAawApAAoAYQBjAHIAbwBzAHMAIAB0AGgAZQAgAG0AZQBzAGgAIABwAGwAYQBuAGUAcwAgAGEAdAAgAHQAaABlACAAdgBhAHIAaQBvAHUAcwAKAGkAbgB0AGUAcgBzAGUAYwB0AGkAbwBuAHMALAAgAGEAbgBkACAAYQByAGUAIAB1AHMAZQBkACAAdABvACAAcABhAHMAcwAKAHQAaABlACAAYwBvAGwAbwByACAAbwBmACAAbwBuAGUAIABwAGwAYQBuAGUAIABvAHYAZQByACAAdABvACAAdABoAGUACgBvAHQAaABlAHIAIABwAGwAYQBuAGUALAAgAHMAbwAgAHQAaABhAHQAIABlAGEAYwBoACAAcABsAGEAbgBlACAAYwBhAG4ACgBiAGwAZQBuAGQAIAB3AGkAdABoACAAdABoAGUAIABvAHQAaABlAHIALgAKAAoAVABoAGUAIABIAG8AcgBpAHoAbwBuAHQAYQBsACAAcABsAGEAbgBlACAAaQBuAHQAZQByAHMAZQBjAHQAcwAgAGEAbgBkAAoAYgBsAGUAbgBkAHMAIAB3AGkAdABoACAAYgBvAHQAaAAgAHQAaABlACAARgBPAFIAVwBBAFIARAAgAGEAbgBkACAAUgBJAEcASABUAAoAcABsAGEAbgBlAHMALgAgAFQAaAB1AHMALAAgAGkAdAAgAGIAbABlAG4AZABzACAAdQBzAGkAbgBnACAAdAB3AG8AIABsAGkAbgBlAHMALAAgAAoAdwBpAHQAaAAgAG8AbgBlACAAbABpAG4AZQAgAGEAbABvAG4AZwAgAGUAYQBjAGgAIABvAGYAIAB0AGgAbwBzAGUACgBlAGQAZwBlAHMALgAgAFQAaABlACAAcABpAHgAZQBsAHMAIABmAG8AcgAgAHQAaABvAHMAZQAgAGwAaQBuAGUAcwAgAGEAcgBlAAoAcwBhAHYAZQBkACAAaQBuACAAVQBWADMAIABhAG4AZAAgAFUAVgA0ACAAcgBlAHMAcABlAGMAdABpAHYAZQBsAHkALgAKAAoARgBvAHIAIAB0AGgAZQAgAEYATwBSAFcAQQBSAEQAIABhAG4AZAAgAFIASQBHAEgAVAAgAHAAbABhAG4AZQBzACwAIAB0AGgAZQB5AAoAYgBsAGUAbgBkACAAbwBuAGwAeQAgAHcAaQB0AGgAIAB0AGgAZQAgAGgAbwByAGkAegBvAG4AdABhAGwAIABwAGwAYQBuAGUALAAKAGEAbgBkACAAdABoAHUAcwAgAHQAaABlAHkAIABvAG4AbAB5ACAAZAByAGEAdwAgAG8AbgBlACAAbABpAG4AZQAuACAAQQBuAGQACgBlAHYAZQBuACAAdABoAG8AdQBnAGgAIAB0AGgAbwBzAGUAIABsAGkAbgBlAHMAIABnAG8AIABkAGkAZgBmAGUAcgBlAG4AdAAKAGQAaQByAGUAYwB0AGkAbwBuAHMALAAgAEkAIAB3AGEAcwAgAGEAYgBsAGUAIAB0AG8AIABzAGEAdgBlACAAYQBsAGwACgB0AGgAYQB0ACAAZABhAHQAYQAgAGkAbgB0AG8AIABqAHUAcwB0ACAAVQBWADQAIABmAG8AcgAgAHQAaABlAGkAcgAgAHUAcwBlAC4A,output:2,fname:UV3_and_UV4,width:322,height:384;n:type:ShaderForge.SFN_Set,id:5415,x:29058,y:30733,cmnt:A number identifying which plane this is,varname:PlaneNumber,prsc:2|IN-1192-OUT;n:type:ShaderForge.SFN_Code,id:7485,x:27407,y:30745,varname:node_7485,prsc:2,code:VABoAGUAIABjAG8AZABlACAAdABvACAAdABoAGUAIAByAGkAZwBoAHQAIABmAGkAZwB1AHIAZQBzACAAbwB1AHQACgB3AGgAaQBjAGgAIABwAGwAYQBuAGUAIAB0AGgAZQAgAHMAaABhAGQAZQByACAAaQBzACAAdwBvAHIAawBpAG4AZwAgAG8AbgAKAHIAaQBnAGgAdAAgAG4AbwB3AC4AIABUAG8AIABmAGkAZwB1AHIAZQAgAHQAaABpAHMAIABvAHUAdAAgAHcAaQB0AGgAbwB1AHQACgB0AG8AbwAgAG0AdQBjAGgAIABhAGQAbwAsACAAdwBlACAAcwBhAHYAZQBkACAAaQB0ACAAaQBuAHQAbwAgAHQAaABlAAoAdABlAHgAdAB1AHIAZQAnAHMAIABhAGwAcABoAGEAIABjAGgAYQBuAG4AZQBsAC4ACgAKADAALgAwADEAIABhAGwAcABoAGEAIABpAHMAIABhACAAdAByAGEAbgBzAHAAYQByAGUAbgB0ACAAcABpAHgAZQBsACAAbwBuACAARgBPAFIAVwBBAFIARAAgAHAAbABhAG4AZQAuAAoAMAAuADAAMgAgAGEAbABwAGgAYQAgAGkAcwAgAGEAIAB0AHIAYQBuAHMAcABhAHIAZQBuAHQAIABwAGkAeABlAGwAIABvAG4AIABSAEkARwBIAFQAIABwAGwAYQBuAGUALgAKADAALgAwADMAIABhAGwAcABoAGEAIABpAHMAIABhACAAdAByAGEAbgBzAHAAYQByAGUAbgB0ACAAcABpAHgAZQBsACAAbwBuACAAVABPAFAAIABwAGwAYQBuAGUALgAKADAALgA5ADgAIABpAHMAIABhAG4AIABvAHAAYQBxAHUAZQAgAHAAaQB4AGUAbAAgAG8AbgAgAEYATwBSAFcAQQBSAEQAIABwAGwAYQBuAGUALgAKADAALgA5ADkAIABpAHMAIABhAG4AIABvAHAAYQBxAHUAZQAgAHAAaQB4AGUAbAAgAG8AbgAgAFIASQBHAEgAVAAgAHAAbABhAG4AZQAuAAoAMQAuADAAMAAgAGkAcwAgAGEAbgAgAG8AcABhAHEAdQBlACAAcABpAHgAZQBsACAAbwBuACAAVABPAFAAIABwAGwAYQBuAGUALgA=,output:2,fname:PlaneNumberInfo,width:412,height:196;n:type:ShaderForge.SFN_If,id:8837,x:28689,y:30708,varname:node_8837,prsc:2|A-9388-OUT,B-4470-OUT,GT-6426-OUT,EQ-6237-OUT,LT-6237-OUT;n:type:ShaderForge.SFN_Get,id:9388,x:27893,y:30676,varname:node_9388,prsc:2|IN-3191-OUT;n:type:ShaderForge.SFN_Vector1,id:4470,x:28407,y:30660,varname:node_4470,prsc:2,v1:0.5;n:type:ShaderForge.SFN_Multiply,id:6237,x:28304,y:30986,varname:node_6237,prsc:2|A-9388-OUT,B-9006-OUT;n:type:ShaderForge.SFN_Vector1,id:9006,x:28113,y:31001,varname:node_9006,prsc:2,v1:100;n:type:ShaderForge.SFN_Subtract,id:1104,x:28197,y:30725,varname:node_1104,prsc:2|A-9388-OUT,B-2827-OUT;n:type:ShaderForge.SFN_Vector1,id:2827,x:27937,y:30771,varname:node_2827,prsc:2,v1:0.97;n:type:ShaderForge.SFN_Multiply,id:6426,x:28407,y:30736,varname:node_6426,prsc:2|A-1104-OUT,B-9006-OUT;n:type:ShaderForge.SFN_Round,id:1192,x:28866,y:30708,varname:node_1192,prsc:2|IN-8837-OUT;n:type:ShaderForge.SFN_Multiply,id:8651,x:30356,y:31284,cmnt:Inputting 0.5 will multiply by 1 which has no effect. Less than 0.5 will darken from 0 to 1 and above 0.5 will brighten by multiplying from 1 to 2x.,varname:node_8651,prsc:2|A-6665-RGB,B-4172-OUT;n:type:ShaderForge.SFN_Vector1,id:4172,x:30133,y:31217,varname:node_4172,prsc:2,v1:2;n:type:ShaderForge.SFN_RemapRange,id:8121,x:30466,y:30820,cmnt:Rescales it to 0.7 to 1 multiplied by 0.75 which yields 0.525 to 0.75,varname:node_8121,prsc:2,frmn:-1,frmx:1,tomn:0.525,tomx:0.75|IN-1391-OUT;n:type:ShaderForge.SFN_Get,id:988,x:35734,y:31656,varname:node_988,prsc:2|IN-8286-OUT;n:type:ShaderForge.SFN_RemapRange,id:1313,x:35982,y:31635,cmnt:Must use 0.01 because 0 is reserved for the FAR leaves. See comments in post processor shader.,varname:node_1313,prsc:2,frmn:0,frmx:1,tomn:0.01,tomx:0.95|IN-988-OUT;n:type:ShaderForge.SFN_Set,id:2975,x:30280,y:29937,varname:LightIN,prsc:2|IN-2919-OUT;n:type:ShaderForge.SFN_Vector4Property,id:8811,x:29340,y:30252,ptovrint:False,ptlb:_LushLODTreeMainLightDir,ptin:_LushLODTreeMainLightDir,cmnt:The W is set via script in _LushLODTreesManager.cs,varname:node_8259,prsc:2,glob:True,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,v1:0.5,v2:0.5,v3:0.5,v4:1;n:type:ShaderForge.SFN_Color,id:670,x:29340,y:29956,ptovrint:False,ptlb:LushLODTreeMainLightCol,ptin:_LushLODTreeMainLightCol,cmnt:This works even with lightmaps,varname:node_349,prsc:2,glob:True,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,c1:0.5,c2:0.5,c3:0.5,c4:1;n:type:ShaderForge.SFN_ValueProperty,id:1460,x:29340,y:30137,ptovrint:False,ptlb:LushLODTreeMainLightIntensity,ptin:_LushLODTreeMainLightIntensity,cmnt:This works even with lightmaps,varname:node_5384,prsc:2,glob:True,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,v1:1;n:type:ShaderForge.SFN_Set,id:9521,x:29686,y:30256,varname:LightDir,prsc:2|IN-8811-XYZ;n:type:ShaderForge.SFN_Get,id:5541,x:30026,y:30817,varname:node_5541,prsc:2|IN-9521-OUT;n:type:ShaderForge.SFN_Dot,id:7816,x:30915,y:30467,cmnt:Is the sun above the horizon?,varname:node_7816,prsc:2,dt:0|A-261-OUT,B-1542-OUT;n:type:ShaderForge.SFN_Get,id:1542,x:30682,y:30513,varname:node_1542,prsc:2|IN-9521-OUT;n:type:ShaderForge.SFN_Vector3,id:261,x:30682,y:30400,cmnt:Checks if the light is shining straight down,varname:node_261,prsc:2,v1:0,v2:1,v3:0;n:type:ShaderForge.SFN_Clamp01,id:1356,x:31479,y:30471,varname:node_1356,prsc:2|IN-8058-OUT;n:type:ShaderForge.SFN_Clamp01,id:8743,x:31943,y:30315,varname:node_8743,prsc:2|IN-8361-OUT;n:type:ShaderForge.SFN_Set,id:2686,x:32580,y:30358,cmnt:This is an optional lighting adjustment you can remove this if your scene doesnt benefit from this.,varname:TimeOfDayIntensity,prsc:2|IN-6670-OUT;n:type:ShaderForge.SFN_Add,id:8058,x:31294,y:30471,cmnt:This makes the trees not get dark until the sun is somewhat BELOW the horizon.,varname:node_8058,prsc:2|A-7816-OUT,B-3836-OUT;n:type:ShaderForge.SFN_Vector1,id:3836,x:31106,y:30505,varname:node_3836,prsc:2,v1:0.25;n:type:ShaderForge.SFN_RemapRangeAdvanced,id:8361,x:31742,y:30315,cmnt:Rescales it from 01 to about 03 to make it get brigher faster as the sun comes up. This effect is significantly stronger on the sunny side via backside darkening.,varname:node_8361,prsc:2|IN-1356-OUT,IMIN-468-OUT,IMAX-4708-OUT,OMIN-3048-OUT,OMAX-539-OUT;n:type:ShaderForge.SFN_Vector1,id:468,x:31479,y:30166,varname:node_468,prsc:2,v1:0;n:type:ShaderForge.SFN_Vector1,id:4708,x:31479,y:30215,varname:node_4708,prsc:2,v1:1;n:type:ShaderForge.SFN_Vector1,id:3048,x:31479,y:30270,varname:node_3048,prsc:2,v1:0;n:type:ShaderForge.SFN_Vector1,id:479,x:31276,y:30226,varname:node_479,prsc:2,v1:1.3;n:type:ShaderForge.SFN_Add,id:539,x:31479,y:30320,varname:node_539,prsc:2|A-479-OUT,B-7586-OUT;n:type:ShaderForge.SFN_Get,id:8148,x:31099,y:30228,varname:node_8148,prsc:2|IN-6719-OUT;n:type:ShaderForge.SFN_Multiply,id:7586,x:31276,y:30292,varname:node_7586,prsc:2|A-8148-OUT,B-9923-OUT;n:type:ShaderForge.SFN_Vector1,id:9923,x:31099,y:30311,varname:node_9923,prsc:2,v1:2;n:type:ShaderForge.SFN_Lerp,id:3378,x:35982,y:31838,varname:node_3378,prsc:2|A-8271-OUT,B-282-OUT,T-779-OUT;n:type:ShaderForge.SFN_ValueProperty,id:779,x:35728,y:31954,ptovrint:False,ptlb:LushLODTreeDisableFarDithering,ptin:_LushLODTreeDisableFarDithering,varname:node_9550,prsc:2,glob:True,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,v1:1;n:type:ShaderForge.SFN_Get,id:8271,x:35660,y:31784,varname:node_8271,prsc:2|IN-3191-OUT;n:type:ShaderForge.SFN_Get,id:453,x:35209,y:31883,varname:node_453,prsc:2|IN-6838-OUT;n:type:ShaderForge.SFN_Set,id:5385,x:29563,y:32535,varname:PixelyDither,prsc:2|IN-6069-OUT;n:type:ShaderForge.SFN_Min,id:282,x:35509,y:31920,varname:node_282,prsc:2|A-453-OUT,B-6175-OUT;n:type:ShaderForge.SFN_Get,id:6175,x:35209,y:32074,cmnt:This gradually dissolves the billboards as they get real close to the camera. Necessary because the billboards that are fully transparent can still over-write the billboards than are still transitioning behind them.,varname:node_6175,prsc:2|IN-5385-OUT;n:type:ShaderForge.SFN_NormalVector,id:7382,x:29430,y:30877,prsc:2,pt:False;n:type:ShaderForge.SFN_Set,id:722,x:29824,y:30977,varname:NormalDir,prsc:2|IN-5426-OUT;n:type:ShaderForge.SFN_FaceSign,id:8646,x:29430,y:31023,varname:node_8646,prsc:2,fstp:1;n:type:ShaderForge.SFN_Multiply,id:5426,x:29654,y:30960,cmnt:Stop it from reversing the normal when viewed from backface.,varname:node_5426,prsc:2|A-7382-OUT,B-8646-VFACE;n:type:ShaderForge.SFN_Code,id:4878,x:32210,y:31382,varname:node_4878,prsc:2,code:LwAvACAAVABoAGkAcwAgAGYAdQBuAGMAdABpAG8AbgAgAGkAcwAgAG4AZQBjAGUAcwBhAHIAeQAgAGQAdQBlACAAdABvACAAdABoAGkAcwAgAGIAdQBnADoAIAAKAC8ALwAgAGgAdAB0AHAAcwA6AC8ALwBzAGgAYQBkAGUAcgBmAG8AcgBnAGUALgB1AHMAZQByAGUAYwBoAG8ALgBjAG8AbQAvAHQAbwBwAGkAYwBzAC8AMQAyADQAOAAtAHQAbwBvAC0AbQBhAG4AeQAtAG8AdQB0AHAAdQB0AC0AcgBlAGcAaQBzAHQAZQByAHMALQBkAGUAYwBsAGEAcgBlAGQALQAxADIALQBvAG4ALQBkADMAZAA5AC8ACgAvAC8AIABTAG8AIAB0AG8AIAByAGUAZAB1AGMAZQAgAG8AdQB0AHAAdQB0ACAAcgBlAGcAaQBzAHQAZQByAHMALAAgAHcAZQAgAGEAcgBlACAAbQBvAHYAaQBuAGcAIAB0AGgAZQAgAEIAaQBUAGEAbgBnAGUAbgB0ACAAYwBhAGwAYwB1AGwAdABpAG8AbgAgAHQAbwAgAGgAZQByAGUALgAKAC8ALwAgAFQAaABpAHMAIABpAHMAIABwAHIAbwBiAGEAYgBsAHkAIABsAGUAcwBzACAAZQBmAGYAaQBjAGkAZQBuAHQALAAgAGIAdQB0ACAAaQB0ACAAcwBhAHYAZQBzACAAbQBlACAAZgByAG8AbQAgAGgAYQB2AGkAbgBnACAAdABvACAAbQBhAG4AdQBhAGwAbAB5ACAAZQBkAGkAdAAgAHQAaABpAHMAIABzAGgAYQBkAGUAcgAuAAoACgAvAC8ARgBvAHIAdwBhAHIAZAAgAFAAbABhAG4AZQAgAEIAaQBUAGEAbgBnAGUAbgB0ACAAaQBzACAAbQB1AGwAdABpAHAAbABpAGUAZAAgAGIAeQAgAC0AMQAgACgAcwBlAGUAIABMAHUAcwBoAEwATwBEAFQAcgBlAGUAQwBvAG4AdgBlAHIAdABlAHIALgBjAHMAKQAKAHIAZQB0AHUAcgBuACAAUABOACAAPQA9ACAAMQAgAD8AIABuAG8AcgBtAGEAbABpAHoAZQAoAGMAcgBvAHMAcwAoAG4AbwByAG0AYQBsAEQAaQByACwAIAB0AGEAbgBnAGUAbgB0AEQAaQByACkAIAAqACAALQAxACkAIAA6AAoACQAgAG4AbwByAG0AYQBsAGkAegBlACgAYwByAG8AcwBzACgAbgBvAHIAbQBhAGwARABpAHIALAAgAHQAYQBuAGcAZQBuAHQARABpAHIAKQApADsA,output:2,fname:CalculateBiTangent,width:653,height:224,input:0,input:2,input:2,input_1_label:PN,input_2_label:normalDir,input_3_label:tangentDir|A-5212-OUT,B-3551-OUT,C-7863-OUT;n:type:ShaderForge.SFN_Tangent,id:7863,x:31922,y:31458,varname:node_7863,prsc:2;n:type:ShaderForge.SFN_Get,id:3551,x:31922,y:31410,varname:node_3551,prsc:2|IN-722-OUT;n:type:ShaderForge.SFN_Get,id:5212,x:31922,y:31366,varname:node_5212,prsc:2|IN-5415-OUT;n:type:ShaderForge.SFN_Set,id:4649,x:32930,y:31382,varname:BiTanDir,prsc:2|IN-4878-OUT;n:type:ShaderForge.SFN_Code,id:2577,x:29032,y:31445,cmnt:Note GetSeamsBlending is in SeamsBlending.cginc,varname:node_2577,prsc:2,code:cgBlAHQAdQByAG4AIABHAGUAdABTAGUAYQBtAHMAQgBsAGUAbgBkAGkAbgBnAF8ATgBvAEEAbgBnAHUAbABhAHIACQAKAAkAKAAJAAoACQAJAEIAaQBUAGEAbgBEAGkAcgAsAAoACQAJAE4AbwByAG0AYQBsAEkATgAsAAoACQAJAFcAbwByAGwAZABQAG8AcwBDAGUAbgB0AGUAcgAsAAoACQAJAFAAbABhAG4AZQBOAHUAbQBiAGUAcgAsAAoACQAJAEYAaQBuAGEAbABDAG8AbABvAHIASQBOACwACgAJAAkAVQBWADMAQwBvAGwAbwByACwACgAJAAkAVQBWADQAQwBvAGwAbwByACwACgAJAAkAVwBvAHIAbABkAFAAbwBzACwACgAJAAkAVABhAG4ARABpAHIACgAJACkALgByAGcAYgA7AA==,output:2,fname:GetSeamsBlending_Caller,width:384,height:237,input:2,input:2,input:2,input:0,input:2,input:3,input:3,input:2,input:2,input_1_label:BiTanDir,input_2_label:NormalIN,input_3_label:WorldPosCenter,input_4_label:PlaneNumber,input_5_label:FinalColorIN,input_6_label:UV3Color,input_7_label:UV4Color,input_8_label:WorldPos,input_9_label:TanDir|A-378-OUT,B-1550-OUT,C-985-OUT,D-5117-OUT,E-2204-OUT,F-4611-OUT,G-4775-OUT,H-6756-XYZ,I-7091-OUT;n:type:ShaderForge.SFN_Get,id:1550,x:28558,y:31380,varname:node_1550,prsc:2|IN-722-OUT;n:type:ShaderForge.SFN_Get,id:985,x:28558,y:31423,varname:node_985,prsc:2|IN-6116-OUT;n:type:ShaderForge.SFN_Get,id:5117,x:28558,y:31468,varname:node_5117,prsc:2|IN-5415-OUT;n:type:ShaderForge.SFN_Get,id:2204,x:28558,y:31513,varname:node_2204,prsc:2|IN-4973-OUT;n:type:ShaderForge.SFN_Get,id:4611,x:28558,y:31557,varname:node_4611,prsc:2|IN-9204-OUT;n:type:ShaderForge.SFN_Get,id:4775,x:28558,y:31600,varname:node_4775,prsc:2|IN-1759-OUT;n:type:ShaderForge.SFN_FragmentPosition,id:6756,x:28558,y:31650,varname:node_6756,prsc:2;n:type:ShaderForge.SFN_Tangent,id:7091,x:28558,y:31766,varname:node_7091,prsc:2;n:type:ShaderForge.SFN_Code,id:6240,x:29018,y:32102,cmnt:Note GetSeamsBlending is in SeamsBlending.cginc,varname:node_6240,prsc:2,code:cgBlAHQAdQByAG4AIABHAGUAdABXAG8AcgBsAGQAUABvAHMAaQB0AGkAbwBuAEMAZQBuAHQAZQByAAoACQAoAAkACgAJAAkAQgBpAFQAYQBuAEQAaQByACwACgAJAAkAVwBvAHIAbABkAFAAbwBzACwACgAJAAkAVABhAG4ARABpAHIALAAKAAkACQBVAFYAMQAsAAoACQAJAFUAVgAwAAoACQApAC4AcgBnAGIAOwA=,output:2,fname:GetWorldPositionCenter_Caller,width:406,height:248,input:2,input:2,input:2,input:1,input:1,input_1_label:BiTanDir,input_2_label:WorldPos,input_3_label:TanDir,input_4_label:UV1,input_5_label:UV0|A-6866-OUT,B-3287-XYZ,C-5576-OUT,D-727-OUT,E-4905-OUT;n:type:ShaderForge.SFN_Get,id:727,x:28544,y:32290,varname:node_727,prsc:2|IN-2338-OUT;n:type:ShaderForge.SFN_Get,id:4905,x:28544,y:32333,varname:node_4905,prsc:2|IN-9647-OUT;n:type:ShaderForge.SFN_FragmentPosition,id:3287,x:28565,y:32046,varname:node_3287,prsc:2;n:type:ShaderForge.SFN_Tangent,id:5576,x:28565,y:32162,varname:node_5576,prsc:2;n:type:ShaderForge.SFN_TexCoord,id:3301,x:30741,y:32087,varname:node_3301,prsc:2,uv:1,uaff:False;n:type:ShaderForge.SFN_TexCoord,id:54,x:30741,y:32244,varname:node_54,prsc:2,uv:0,uaff:False;n:type:ShaderForge.SFN_Set,id:2338,x:31142,y:32099,varname:UV1_IN,prsc:2|IN-3301-UVOUT;n:type:ShaderForge.SFN_Set,id:9647,x:31142,y:32246,varname:UV0_IN,prsc:2|IN-54-UVOUT;n:type:ShaderForge.SFN_Get,id:378,x:28558,y:31336,varname:node_378,prsc:2|IN-4649-OUT;n:type:ShaderForge.SFN_Append,id:7074,x:31202,y:31915,varname:node_7074,prsc:2|A-4547-RGB,B-4547-A;n:type:ShaderForge.SFN_Append,id:4247,x:31202,y:31705,varname:node_4247,prsc:2|A-9956-RGB,B-9956-A;n:type:ShaderForge.SFN_Get,id:6866,x:28548,y:31959,varname:node_6866,prsc:2|IN-4649-OUT;n:type:ShaderForge.SFN_Code,id:8560,x:31454,y:31548,varname:node_8560,prsc:2,code:YwBsAGkAcAAoAFQAZQB4AEEAbABwAGgAYQAgAC0AIABDAHUAdABvAGYAZgApADsACgByAGUAdAB1AHIAbgAgAFQAZQB4AEEAbABwAGgAYQA7AA==,output:0,fname:ClipMe,width:247,height:112,input:0,input:0,input_1_label:TexAlpha,input_2_label:Cutoff|A-7736-A,B-2739-OUT;n:type:ShaderForge.SFN_Get,id:2739,x:31202,y:31586,varname:node_2739,prsc:2|IN-7766-OUT;n:type:ShaderForge.SFN_ScreenPos,id:7004,x:28617,y:32521,varname:node_7004,prsc:2,sctp:0;n:type:ShaderForge.SFN_ScreenPos,id:4193,x:28617,y:32773,varname:node_4193,prsc:2,sctp:2;n:type:ShaderForge.SFN_Code,id:6069,x:28887,y:32525,varname:node_6069,prsc:2,code:cgBlAHQAdQByAG4AIABHAGUAdABQAGkAeABlAGwAeQBEAGkAdABoAGUAcgBfAEIATwBUAEgAUABBAFMAUwAoAFMAYwByAGUAZQBuAFAAbwBzACwAIABUAHIAYQBuAHMAcABhAHIAZQBuAGMAeQApADsA,output:0,fname:GetPixelyDither_Caller,width:453,height:128,input:1,input:0,input_1_label:ScreenPos,input_2_label:Transparency|A-7004-UVOUT,B-2213-OUT;n:type:ShaderForge.SFN_Code,id:3666,x:28882,y:32808,varname:node_3666,prsc:2,code:cgBlAHQAdQByAG4AIABHAGUAdABEAGkAdABoAGUAcgBVAGwAdAByAGEAXwBCAE8AVABIAFAAQQBTAFMAKABTAGMAZQBuAGUAVQBWAHMALAAgAFQAcgBhAG4AcwBwAGEAcgBlAG4AYwB5ACkAOwA=,output:0,fname:GetDitherUltra_Caller,width:467,height:128,input:1,input:0,input_1_label:SceneUVs,input_2_label:Transparency|A-4193-UVOUT,B-9715-OUT;n:type:ShaderForge.SFN_Get,id:9715,x:28596,y:32922,varname:node_9715,prsc:2|IN-8286-OUT;n:type:ShaderForge.SFN_Get,id:2213,x:28596,y:32661,varname:node_2213,prsc:2|IN-8286-OUT;n:type:ShaderForge.SFN_Multiply,id:2919,x:30067,y:29937,varname:node_2919,prsc:2|A-670-RGB,B-7915-OUT;n:type:ShaderForge.SFN_Get,id:349,x:33767,y:30939,cmnt:The main texture color with some modifications for things like seams blending.,varname:node_350,prsc:2|IN-4895-OUT;n:type:ShaderForge.SFN_Get,id:6317,x:33596,y:31235,cmnt:The color of the main diretional light,varname:node_6317,prsc:2|IN-2975-OUT;n:type:ShaderForge.SFN_Get,id:13,x:34060,y:31784,cmnt:The shadows value,varname:node_13,prsc:2|IN-6719-OUT;n:type:ShaderForge.SFN_Get,id:45,x:35563,y:30949,varname:node_45,prsc:2|IN-2686-OUT;n:type:ShaderForge.SFN_Add,id:7757,x:33913,y:31257,varname:node_7757,prsc:2|A-6317-OUT,B-5699-RGB;n:type:ShaderForge.SFN_Multiply,id:9403,x:34173,y:31200,cmnt:The final texture color with all lights but no shadows yet,varname:node_9403,prsc:2|A-349-OUT,B-7757-OUT;n:type:ShaderForge.SFN_Lerp,id:8594,x:34778,y:31384,cmnt:The final color with the shadows and ambient tint applied to the shadows,varname:node_8594,prsc:2|A-4751-OUT,B-9403-OUT,T-5619-OUT;n:type:ShaderForge.SFN_Multiply,id:4751,x:34407,y:31571,varname:node_4751,prsc:2|A-470-OUT,B-2902-OUT;n:type:ShaderForge.SFN_Blend,id:470,x:34195,y:31492,cmnt:The color of the shadow is based entirely off the texture color and the ambient light color,varname:node_470,prsc:2,blmd:1,clmp:False|SRC-5699-RGB,DST-349-OUT;n:type:ShaderForge.SFN_Vector1,id:2902,x:34169,y:31667,varname:node_2902,prsc:2,v1:0.8;n:type:ShaderForge.SFN_Get,id:6160,x:34264,y:30983,varname:node_6160,prsc:2|IN-7375-OUT;n:type:ShaderForge.SFN_Max,id:900,x:34778,y:31052,cmnt:Finds the highest input color value,varname:node_900,prsc:2|A-4628-R,B-4628-G,C-4628-B;n:type:ShaderForge.SFN_Min,id:7840,x:34778,y:31210,cmnt:Finds how much LESS than WHITE the input color is,varname:node_7840,prsc:2|A-4628-R,B-4628-G,C-4628-B;n:type:ShaderForge.SFN_ComponentMask,id:4628,x:34479,y:30983,cmnt:The input color,varname:node_4628,prsc:2,cc1:0,cc2:1,cc3:2,cc4:-1|IN-6160-OUT;n:type:ShaderForge.SFN_Multiply,id:3808,x:34806,y:30743,cmnt:The input color multiplied by the texture color to give the input color a texture so that it doesnt look flat,varname:node_3808,prsc:2|A-349-OUT,B-4628-OUT;n:type:ShaderForge.SFN_Multiply,id:2785,x:35136,y:30971,cmnt:Darkens the final color based on the input ccolor,varname:node_2785,prsc:2|A-8594-OUT,B-4628-OUT;n:type:ShaderForge.SFN_Lerp,id:1162,x:35146,y:30769,cmnt:Lerps towards the input color based on how much the input color is LESS than WHITE,varname:node_1162,prsc:2|A-3808-OUT,B-8594-OUT,T-7840-OUT;n:type:ShaderForge.SFN_Subtract,id:4713,x:35307,y:31117,cmnt:Finds the difference between the highest and lowest color value. This is used to detect if our iput color is simply a shade of grey and has no color,varname:node_4713,prsc:2|A-900-OUT,B-7840-OUT;n:type:ShaderForge.SFN_Lerp,id:4490,x:35584,y:30818,varname:node_4490,prsc:2|A-2785-OUT,B-1162-OUT,T-4713-OUT;n:type:ShaderForge.SFN_Multiply,id:8659,x:35917,y:30858,varname:node_8659,prsc:2|A-4490-OUT,B-45-OUT;n:type:ShaderForge.SFN_Clamp,id:5619,x:34368,y:31786,cmnt:This lets the user adjust te maximum shadow. A value of 0.5 will limit it to half.,varname:node_5619,prsc:2|IN-13-OUT,MIN-3309-OUT,MAX-4135-OUT;n:type:ShaderForge.SFN_Vector1,id:4135,x:34060,y:31880,varname:node_4135,prsc:2,v1:1;n:type:ShaderForge.SFN_ValueProperty,id:7672,x:33939,y:31991,ptovrint:False,ptlb:_LushLODTreeShadowDarkness,ptin:_LushLODTreeShadowDarkness,cmnt:_LusLODSadowDarkness... this is cotrolled by the manager in its Update function,varname:node_2612,prsc:2,glob:True,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,v1:1;n:type:ShaderForge.SFN_OneMinus,id:3309,x:34138,y:31991,varname:node_3309,prsc:2|IN-7672-OUT;n:type:ShaderForge.SFN_Lerp,id:6670,x:32266,y:30443,cmnt:Lets the user adjust the tie of day correction,varname:node_6670,prsc:2|A-1421-OUT,B-8743-OUT,T-5235-OUT;n:type:ShaderForge.SFN_ValueProperty,id:5235,x:32019,y:30515,ptovrint:False,ptlb:LushLODTreeTimeOfDay,ptin:_LushLODTreeTimeOfDay,varname:node_5174,prsc:2,glob:True,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,v1:1;n:type:ShaderForge.SFN_Vector1,id:1421,x:32019,y:30443,varname:node_1421,prsc:2,v1:1;n:type:ShaderForge.SFN_Divide,id:7915,x:29790,y:30014,varname:node_7915,prsc:2|A-1460-OUT,B-7830-OUT;n:type:ShaderForge.SFN_Vector1,id:7830,x:29552,y:30033,varname:node_7830,prsc:2,v1:1.2;n:type:ShaderForge.SFN_Color,id:5699,x:33610,y:31446,ptovrint:False,ptlb:_LushLODTreeAmbientColor,ptin:_LushLODTreeAmbientColor,cmnt:_LushLODTreeAmbientColor... this value is set in the manager,varname:_LushLODTreeAmbientColor_copy,prsc:2,glob:True,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,c1:0.5,c2:0.5,c3:0.5,c4:1;proporder:6665-6832-6298-5916-1495;pass:END;sub:END;*/

Shader "Hidden/LushLODTree/Tree_Leaves_Ultra_Deferred" {
    Properties {
        _Color ("Color", Color) = (0.5019608,0.5019608,0.5019608,1)
        _Transparency ("Transparency", Range(0, 1)) = 1
        _MainTex ("MainTex", 2D) = "white" {}
        _Cutoff ("Cutoff", Range(0, 1)) = 0.7
        _ShadowTransparency ("ShadowTransparency", Range(0, 1)) = 0
        [HideInInspector]_Cutoff ("Alpha cutoff", Range(0,1)) = 0.5
    }
    SubShader {
        Tags {
            "RenderType"="Opaque"
            "CanUseSpriteAtlas"="True"
        }
        Pass {
            Name "FORWARD"
            Tags {
                "LightMode"="ForwardBase"
            }
            Cull Off
            
            
            Stencil {
                Ref 191
                Pass Replace
            }
            CGPROGRAM
            #pragma vertex vert
            #pragma fragment frag
            #define UNITY_PASS_FORWARDBASE
            #include "UnityCG.cginc"
            #include "CGIncludes/SeamsBlending_NoAngular.cginc"
            #include "CGIncludes/WorldPositionCenter.cginc"
            #include "CGIncludes/Dithering.cginc"
            #pragma multi_compile_fwdbase_fullshadows
            #pragma multi_compile_fog
            #pragma target 3.0
            uniform float4 _Color;
            uniform float _Transparency;
            uniform float _Cutoff;
            uniform sampler2D _MainTex; uniform float4 _MainTex_ST;
            uniform float4 _LushLODTreeMainLightDir;
            uniform float4 _LushLODTreeMainLightCol;
            uniform float _LushLODTreeMainLightIntensity;
            uniform float _LushLODTreeDisableFarDithering;
            float3 CalculateBiTangent( float PN , float3 normalDir , float3 tangentDir ){
            // This function is necesary due to this bug: 
            // https://shaderforge.userecho.com/topics/1248-too-many-output-registers-declared-12-on-d3d9/
            // So to reduce output registers, we are moving the BiTangent calcultion to here.
            // This is probably less efficient, but it saves me from having to manually edit this shader.
            
            //Forward Plane BiTangent is multiplied by -1 (see LushLODTreeConverter.cs)
            return PN == 1 ? normalize(cross(normalDir, tangentDir) * -1) :
            	 normalize(cross(normalDir, tangentDir));
            }
            
            float3 GetSeamsBlending_Caller( float3 BiTanDir , float3 NormalIN , float3 WorldPosCenter , float PlaneNumber , float3 FinalColorIN , float4 UV3Color , float4 UV4Color , float3 WorldPos , float3 TanDir ){
            return GetSeamsBlending_NoAngular	
            	(	
            		BiTanDir,
            		NormalIN,
            		WorldPosCenter,
            		PlaneNumber,
            		FinalColorIN,
            		UV3Color,
            		UV4Color,
            		WorldPos,
            		TanDir
            	).rgb;
            }
            
            float3 GetWorldPositionCenter_Caller( float3 BiTanDir , float3 WorldPos , float3 TanDir , float2 UV1 , float2 UV0 ){
            return GetWorldPositionCenter
            	(	
            		BiTanDir,
            		WorldPos,
            		TanDir,
            		UV1,
            		UV0
            	).rgb;
            }
            
            float ClipMe( float TexAlpha , float Cutoff ){
            clip(TexAlpha - Cutoff);
            return TexAlpha;
            }
            
            float GetPixelyDither_Caller( float2 ScreenPos , float Transparency ){
            return GetPixelyDither_BOTHPASS(ScreenPos, Transparency);
            }
            
            float GetDitherUltra_Caller( float2 SceneUVs , float Transparency ){
            return GetDitherUltra_BOTHPASS(SceneUVs, Transparency);
            }
            
            uniform float _LushLODTreeShadowDarkness;
            uniform float _LushLODTreeTimeOfDay;
            uniform float4 _LushLODTreeAmbientColor;
            struct VertexInput {
                float4 vertex : POSITION;
                float3 normal : NORMAL;
                float4 tangent : TANGENT;
                float2 texcoord0 : TEXCOORD0;
                float2 texcoord1 : TEXCOORD1;
                float2 texcoord2 : TEXCOORD2;
                float2 texcoord3 : TEXCOORD3;
            };
            struct VertexOutput {
                float4 pos : SV_POSITION;
                float2 uv0 : TEXCOORD0;
                float2 uv1 : TEXCOORD1;
                float2 uv2 : TEXCOORD2;
                float2 uv3 : TEXCOORD3;
                float4 posWorld : TEXCOORD4;
                float3 normalDir : TEXCOORD5;
                float3 tangentDir : TEXCOORD6;
                float4 projPos : TEXCOORD7;
                UNITY_FOG_COORDS(8)
            };
            VertexOutput vert (VertexInput v) {
                VertexOutput o = (VertexOutput)0;
                o.uv0 = v.texcoord0;
                o.uv1 = v.texcoord1;
                o.uv2 = v.texcoord2;
                o.uv3 = v.texcoord3;
                o.normalDir = UnityObjectToWorldNormal(v.normal);
                o.tangentDir = normalize( mul( unity_ObjectToWorld, float4( v.tangent.xyz, 0.0 ) ).xyz );
                o.posWorld = mul(unity_ObjectToWorld, v.vertex);
                o.pos = UnityObjectToClipPos( v.vertex );
                UNITY_TRANSFER_FOG(o,o.pos);
                o.projPos = ComputeScreenPos (o.pos);
                COMPUTE_EYEDEPTH(o.projPos.z);
                return o;
            }
            float4 frag(VertexOutput i, float facing : VFACE) : COLOR {
                float isFrontFace = ( facing >= 0 ? 1 : 0 );
                float faceSign = ( facing >= 0 ? 1 : -1 );
                i.normalDir = normalize(i.normalDir);
                i.normalDir *= faceSign;
                float3 viewDirection = normalize(_WorldSpaceCameraPos.xyz - i.posWorld.xyz);
                float3 normalDirection = i.normalDir;
                float2 sceneUVs = (i.projPos.xy / i.projPos.w);
                float4 node_3116_MAINPASS = tex2D(_MainTex,TRANSFORM_TEX(i.uv0, _MainTex));
                float Param_Cutoff = _Cutoff;
                float TexAlpha = ClipMe( node_3116_MAINPASS.a , Param_Cutoff );
                float Param_Transparency_MAINPASS = _Transparency;
                float DITHER_MAINPASS = GetDitherUltra_Caller( sceneUVs.rg , Param_Transparency_MAINPASS );
                float PixelyDither = GetPixelyDither_Caller( (sceneUVs * 2 - 1).rg , Param_Transparency_MAINPASS );
                clip(lerp(TexAlpha,min(DITHER_MAINPASS,PixelyDither),_LushLODTreeDisableFarDithering) - 0.5);
////// Lighting:
                float node_9388 = TexAlpha;
                float node_8837_if_leA = step(node_9388,0.5);
                float node_8837_if_leB = step(0.5,node_9388);
                float node_9006 = 100.0;
                float node_6237 = (node_9388*node_9006);
                float PlaneNumber = round(lerp((node_8837_if_leA*node_6237)+(node_8837_if_leB*((node_9388-0.97)*node_9006)),node_6237,node_8837_if_leA*node_8837_if_leB)); // A number identifying which plane this is
                float3 NormalDir = (i.normalDir*faceSign);
                float3 BiTanDir = CalculateBiTangent( PlaneNumber , NormalDir , i.tangentDir );
                float2 UV1_IN = i.uv1;
                float2 UV0_IN = i.uv0;
                float3 WorldPosCenter = GetWorldPositionCenter_Caller( BiTanDir , i.posWorld.rgb , i.tangentDir , UV1_IN , UV0_IN );
                float3 MainTexIN = node_3116_MAINPASS.rgb;
                float4 node_3117_MAINPASS = tex2D(_MainTex,TRANSFORM_TEX(i.uv2, _MainTex)); // Color and alpha from UV3 is used by the horizontal plane to draw the Line Z and part of the circle
                float4 UV3Color_IN = float4(node_3117_MAINPASS.rgb,node_3117_MAINPASS.a);
                float4 node_3118_MAINPASS = tex2D(_MainTex,TRANSFORM_TEX(i.uv3, _MainTex)); // Color and alpha from UV4 is used by all three planes to draw all or parts of their circlecrosses
                float4 UV4Color_IN = float4(node_3118_MAINPASS.rgb,node_3118_MAINPASS.a);
                float3 FinalColor_Corrected = GetSeamsBlending_Caller( BiTanDir , NormalDir , WorldPosCenter , PlaneNumber , MainTexIN , UV3Color_IN , UV4Color_IN , i.posWorld.rgb , i.tangentDir );
                float3 node_350 = FinalColor_Corrected; // The main texture color with some modifications for things like seams blending.
                float3 LightIN = (_LushLODTreeMainLightCol.rgb*(_LushLODTreeMainLightIntensity/1.2));
                float3 LightDir = _LushLODTreeMainLightDir.rgb;
                float node_1391 = 0.5*dot(viewDirection,LightDir)+0.5; // Check if view is opposite the direction of sunlight
                float Backside_Darkening_Amount = node_1391; // Darkens the trees when viewed from the back side
                float3 node_8594 = lerp(((_LushLODTreeAmbientColor.rgb*node_350)*0.8),(node_350*(LightIN+_LushLODTreeAmbientColor.rgb)),clamp(Backside_Darkening_Amount,(1.0 - _LushLODTreeShadowDarkness),1.0)); // The final color with the shadows and ambient tint applied to the shadows
                float3 Param_Color = (_Color.rgb*2.0);
                float3 node_4628 = Param_Color.rgb; // The input color
                float node_7840 = min(min(node_4628.r,node_4628.g),node_4628.b); // Finds how much LESS than WHITE the input color is
                float node_468 = 0.0;
                float node_3048 = 0.0;
                float TimeOfDayIntensity = lerp(1.0,saturate((node_3048 + ( (saturate((dot(float3(0,1,0),LightDir)+0.25)) - node_468) * ((1.3+(Backside_Darkening_Amount*2.0)) - node_3048) ) / (1.0 - node_468))),_LushLODTreeTimeOfDay); // This is an optional lighting adjustment you can remove this if your scene doesnt benefit from this.
                float3 finalColor = (lerp((node_8594*node_4628),lerp((node_350*node_4628),node_8594,node_7840),(max(max(node_4628.r,node_4628.g),node_4628.b)-node_7840))*TimeOfDayIntensity);
                fixed4 finalRGBA = fixed4(finalColor,(Param_Transparency_MAINPASS*0.94+0.01));
                UNITY_APPLY_FOG(i.fogCoord, finalRGBA);
                return finalRGBA;
            }
            ENDCG
        }
        Pass {
            Name "ShadowCaster"
            Tags {
                "LightMode"="ShadowCaster"
            }
            Offset 1, 1
            Cull Off
            
            CGPROGRAM
            #pragma vertex vert
            #pragma fragment frag
            #define UNITY_PASS_SHADOWCASTER
            #include "UnityCG.cginc"
            #include "Lighting.cginc"
            #include "CGIncludes/SeamsBlending_NoAngular.cginc"
            #include "CGIncludes/WorldPositionCenter.cginc"
            #include "CGIncludes/Dithering.cginc"
            #pragma fragmentoption ARB_precision_hint_fastest
            #pragma multi_compile_shadowcaster
            #pragma multi_compile_fog
            #pragma target 3.0
            uniform float _Transparency;
            uniform float _Cutoff;
            uniform sampler2D _MainTex; uniform float4 _MainTex_ST;
            uniform float _LushLODTreeDisableFarDithering;
            float ClipMe( float TexAlpha , float Cutoff ){
            clip(TexAlpha - Cutoff);
            return TexAlpha;
            }
            
            float GetPixelyDither_Caller( float2 ScreenPos , float Transparency ){
            return GetPixelyDither_BOTHPASS(ScreenPos, Transparency);
            }
            
            float GetDitherUltra_Caller( float2 SceneUVs , float Transparency ){
            return GetDitherUltra_BOTHPASS(SceneUVs, Transparency);
            }
            
            struct VertexInput {
                float4 vertex : POSITION;
                float2 texcoord0 : TEXCOORD0;
            };
            struct VertexOutput {
                V2F_SHADOW_CASTER;
                float2 uv0 : TEXCOORD1;
                float4 projPos : TEXCOORD2;
            };
            VertexOutput vert (VertexInput v) {
                VertexOutput o = (VertexOutput)0;
                o.uv0 = v.texcoord0;
                o.pos = UnityObjectToClipPos( v.vertex );
                o.projPos = ComputeScreenPos (o.pos);
                COMPUTE_EYEDEPTH(o.projPos.z);
                TRANSFER_SHADOW_CASTER(o)
                return o;
            }
            float4 frag(VertexOutput i, float facing : VFACE) : COLOR {
                float isFrontFace = ( facing >= 0 ? 1 : 0 );
                float faceSign = ( facing >= 0 ? 1 : -1 );
                float2 sceneUVs = (i.projPos.xy / i.projPos.w);
                float4 node_3116_MAINPASS = tex2D(_MainTex,TRANSFORM_TEX(i.uv0, _MainTex));
                float Param_Cutoff = _Cutoff;
                float TexAlpha = ClipMe( node_3116_MAINPASS.a , Param_Cutoff );
                float Param_Transparency_MAINPASS = _Transparency;
                float DITHER_MAINPASS = GetDitherUltra_Caller( sceneUVs.rg , Param_Transparency_MAINPASS );
                float PixelyDither = GetPixelyDither_Caller( (sceneUVs * 2 - 1).rg , Param_Transparency_MAINPASS );
                clip(lerp(TexAlpha,min(DITHER_MAINPASS,PixelyDither),_LushLODTreeDisableFarDithering) - 0.5);
                SHADOW_CASTER_FRAGMENT(i)
            }
            ENDCG
        }
    }
    CustomEditor "ShaderForgeMaterialInspector"
}
