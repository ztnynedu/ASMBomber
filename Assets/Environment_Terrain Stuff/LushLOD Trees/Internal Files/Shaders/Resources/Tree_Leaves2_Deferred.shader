// Shader created with Shader Forge v1.38 
// Shader Forge (c) Neat Corporation / Joachim Holmer - http://www.acegikmo.com/shaderforge/
// Note: Manually altering this data may prevent you from opening it in Shader Forge
/*SF_DATA;ver:1.38;sub:START;pass:START;ps:flbk:,iptp:0,cusa:True,bamd:0,cgin:QwBHAEkAbgBjAGwAdQBkAGUAcwAvAFMAZQBhAG0AcwBCAGwAZQBuAGQAaQBuAGcAXwBOAG8AQQBuAGcAdQBsAGEAcgB8AEMARwBJAG4AYwBsAHUAZABlAHMALwBXAG8AcgBsAGQAUABvAHMAaQB0AGkAbwBuAEMAZQBuAHQAZQByAHwAQwBHAEkAbgBjAGwAdQBkAGUAcwAvAEQAaQB0AGgAZQByAGkAbgBnAA==,lico:0,lgpr:1,limd:3,spmd:1,trmd:0,grmd:0,uamb:True,mssp:True,bkdf:False,hqlp:False,rprd:False,enco:False,rmgx:True,imps:True,rpth:1,vtps:0,hqsc:True,nrmq:1,nrsp:0,vomd:0,spxs:False,tesm:0,olmd:1,culm:2,bsrc:0,bdst:1,dpts:2,wrdp:True,dith:0,atcv:False,rfrpo:False,rfrpn:Refraction,coma:15,ufog:True,aust:True,igpj:False,qofs:0,qpre:2,rntp:3,fgom:False,fgoc:False,fgod:False,fgor:False,fgmd:0,fgcr:0.5,fgcg:0.5,fgcb:0.5,fgca:1,fgde:0.01,fgrn:0,fgrf:300,stcl:False,atwp:False,stva:128,stmr:255,stmw:255,stcp:6,stps:0,stfa:0,stfz:0,ofsf:0,ofsu:0,f2p0:False,fnsp:False,fnfb:True,fsmp:False;n:type:ShaderForge.SFN_Final,id:2865,x:35965,y:30857,varname:node_2865,prsc:2|emission-7269-OUT,clip-8916-OUT;n:type:ShaderForge.SFN_Color,id:6665,x:29813,y:31388,ptovrint:False,ptlb:Color,ptin:_Color,varname:_Color,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,c1:0.5019608,c2:0.5019608,c3:0.5019608,c4:1;n:type:ShaderForge.SFN_Tex2d,id:7736,x:31164,y:31435,varname:node_3116_MAINPASS,prsc:2,ntxv:0,isnm:False|TEX-6298-TEX;n:type:ShaderForge.SFN_Slider,id:6832,x:30723,y:31280,ptovrint:False,ptlb:Transparency,ptin:_Transparency,varname:_Transparency,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,min:0,cur:1,max:1;n:type:ShaderForge.SFN_Slider,id:5916,x:30737,y:31158,ptovrint:False,ptlb:Cutoff,ptin:_Cutoff,varname:_Cutoff,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,min:0,cur:0.7,max:1;n:type:ShaderForge.SFN_Tex2dAsset,id:6298,x:30748,y:31490,ptovrint:False,ptlb:MainTex,ptin:_MainTex,varname:_MainTex,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,ntxv:0,isnm:False;n:type:ShaderForge.SFN_Slider,id:1495,x:30737,y:31031,ptovrint:False,ptlb:ShadowTransparency,ptin:_ShadowTransparency,varname:_ShadowTransparency,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,min:0,cur:0,max:1;n:type:ShaderForge.SFN_Set,id:3191,x:31777,y:31528,varname:TexAlpha,prsc:2|IN-958-OUT;n:type:ShaderForge.SFN_Set,id:8286,x:31076,y:31295,varname:Param_Transparency_MAINPASS,prsc:2|IN-6832-OUT;n:type:ShaderForge.SFN_Set,id:7766,x:31078,y:31157,varname:Param_Cutoff,prsc:2|IN-5916-OUT;n:type:ShaderForge.SFN_Set,id:7143,x:31078,y:31034,varname:Param_ShadowTrans_SHADOWPASS,prsc:2|IN-6832-OUT;n:type:ShaderForge.SFN_Set,id:47,x:28682,y:32888,varname:DITHER_SHADOWPASS,prsc:2|IN-4335-OUT;n:type:ShaderForge.SFN_Get,id:2650,x:35189,y:31293,varname:node_2650,prsc:2|IN-47-OUT;n:type:ShaderForge.SFN_Set,id:4973,x:31384,y:31435,varname:MainTexIN,prsc:2|IN-7736-RGB;n:type:ShaderForge.SFN_Tex2d,id:4547,x:31133,y:31859,cmnt:Color and alpha from UV3 is used by the horizontal plane to draw the Line Z and part of the circle,varname:node_3117_MAINPASS,prsc:2,ntxv:0,isnm:False|UVIN-327-UVOUT,TEX-6298-TEX;n:type:ShaderForge.SFN_TexCoord,id:327,x:30712,y:31868,varname:node_327,prsc:2,uv:2,uaff:False;n:type:ShaderForge.SFN_Set,id:9204,x:31492,y:31867,varname:UV3ColorIN,prsc:2|IN-7063-OUT;n:type:ShaderForge.SFN_Tex2d,id:9956,x:31138,y:31675,cmnt:Color and alpha from UV4 is used by all three planes to draw all or parts of their circlecrosses,varname:node_3118_MAINPASS,prsc:2,ntxv:0,isnm:False|UVIN-3765-UVOUT,TEX-6298-TEX;n:type:ShaderForge.SFN_TexCoord,id:3765,x:30717,y:31692,varname:node_3765,prsc:2,uv:3,uaff:False;n:type:ShaderForge.SFN_Set,id:1759,x:31488,y:31694,varname:UV4ColorIN,prsc:2|IN-6850-OUT;n:type:ShaderForge.SFN_Set,id:6719,x:31062,y:30761,cmnt:Darkens the trees when viewed from the back side,varname:Backside_Darkening_Amount,prsc:2|IN-5179-OUT;n:type:ShaderForge.SFN_Set,id:7375,x:30318,y:31404,varname:Param_Color,prsc:2|IN-8651-OUT;n:type:ShaderForge.SFN_Set,id:6116,x:28772,y:32475,varname:WorldPosCenter,prsc:2|IN-7549-OUT;n:type:ShaderForge.SFN_Code,id:9670,x:30278,y:31663,varname:node_9670,prsc:2,code:VABoAGUAIABjAG8AZABlACAAdABvACAAdABoAGUAIAByAGkAZwBoAHQAIABnAGUAdABzACAAdABoAGUAIABwAGkAeABlAGwACgBjAG8AbABvAHIAIABmAHIAbwBtACAAdABoAGUAIABVAFYAMwAgAGEAbgBkACAAVQBWADQALgAgAFQAaABlAHMAZQAgAFUAVgBzAAoAdwBlAHIAZQAgAGMAYQBsAGMAdQBsAGEAdABlAGQAIABlAHgAcAByAGUAcwBzAGwAeQAgAGIAeQAgAHQAaABlAAoATAB1AHMAaABMAE8ARABUAHIAZQBlAEMAbwBuAHYAZQByAHQAZQByAC4AYwBzACAAcwBjAHIAaQBwAHQAIAB3AGgAZQBuAAoAdABoAGUAIABiAGkAbABsAGIAbwBhAHIAZAAgAG0AZQBzAGgAIAB3AGEAcwAgAGMAcgBlAGEAdABlAGQALgAgAFQAaABlAHkACgBjAG8AbgB0AGEAaQBuACAAdABoAGkAbgAgAGwAaQBuAGUAcwAgACgAMQAgAHAAaQB4AGUAbAAgAHQAaABpAGMAawApAAoAYQBjAHIAbwBzAHMAIAB0AGgAZQAgAG0AZQBzAGgAIABwAGwAYQBuAGUAcwAgAGEAdAAgAHQAaABlACAAdgBhAHIAaQBvAHUAcwAKAGkAbgB0AGUAcgBzAGUAYwB0AGkAbwBuAHMALAAgAGEAbgBkACAAYQByAGUAIAB1AHMAZQBkACAAdABvACAAcABhAHMAcwAKAHQAaABlACAAYwBvAGwAbwByACAAbwBmACAAbwBuAGUAIABwAGwAYQBuAGUAIABvAHYAZQByACAAdABvACAAdABoAGUACgBvAHQAaABlAHIAIABwAGwAYQBuAGUALAAgAHMAbwAgAHQAaABhAHQAIABlAGEAYwBoACAAcABsAGEAbgBlACAAYwBhAG4ACgBiAGwAZQBuAGQAIAB3AGkAdABoACAAdABoAGUAIABvAHQAaABlAHIALgAKAAoAVABoAGUAIABIAG8AcgBpAHoAbwBuAHQAYQBsACAAcABsAGEAbgBlACAAaQBuAHQAZQByAHMAZQBjAHQAcwAgAGEAbgBkAAoAYgBsAGUAbgBkAHMAIAB3AGkAdABoACAAYgBvAHQAaAAgAHQAaABlACAARgBPAFIAVwBBAFIARAAgAGEAbgBkACAAUgBJAEcASABUAAoAcABsAGEAbgBlAHMALgAgAFQAaAB1AHMALAAgAGkAdAAgAGIAbABlAG4AZABzACAAdQBzAGkAbgBnACAAdAB3AG8AIABsAGkAbgBlAHMALAAgAAoAdwBpAHQAaAAgAG8AbgBlACAAbABpAG4AZQAgAGEAbABvAG4AZwAgAGUAYQBjAGgAIABvAGYAIAB0AGgAbwBzAGUACgBlAGQAZwBlAHMALgAgAFQAaABlACAAcABpAHgAZQBsAHMAIABmAG8AcgAgAHQAaABvAHMAZQAgAGwAaQBuAGUAcwAgAGEAcgBlAAoAcwBhAHYAZQBkACAAaQBuACAAVQBWADMAIABhAG4AZAAgAFUAVgA0ACAAcgBlAHMAcABlAGMAdABpAHYAZQBsAHkALgAKAAoARgBvAHIAIAB0AGgAZQAgAEYATwBSAFcAQQBSAEQAIABhAG4AZAAgAFIASQBHAEgAVAAgAHAAbABhAG4AZQBzACwAIAB0AGgAZQB5AAoAYgBsAGUAbgBkACAAbwBuAGwAeQAgAHcAaQB0AGgAIAB0AGgAZQAgAGgAbwByAGkAegBvAG4AdABhAGwAIABwAGwAYQBuAGUALAAKAGEAbgBkACAAdABoAHUAcwAgAHQAaABlAHkAIABvAG4AbAB5ACAAZAByAGEAdwAgAG8AbgBlACAAbABpAG4AZQAuACAAQQBuAGQACgBlAHYAZQBuACAAdABoAG8AdQBnAGgAIAB0AGgAbwBzAGUAIABsAGkAbgBlAHMAIABnAG8AIABkAGkAZgBmAGUAcgBlAG4AdAAKAGQAaQByAGUAYwB0AGkAbwBuAHMALAAgAEkAIAB3AGEAcwAgAGEAYgBsAGUAIAB0AG8AIABzAGEAdgBlACAAYQBsAGwACgB0AGgAYQB0ACAAZABhAHQAYQAgAGkAbgB0AG8AIABqAHUAcwB0ACAAVQBWADQAIABmAG8AcgAgAHQAaABlAGkAcgAgAHUAcwBlAC4A,output:2,fname:UV3_and_UV4,width:322,height:384;n:type:ShaderForge.SFN_Set,id:5415,x:29531,y:31133,cmnt:A number identifying which plane this is,varname:PlaneNumber,prsc:2|IN-1192-OUT;n:type:ShaderForge.SFN_Code,id:7485,x:27880,y:31145,varname:node_7485,prsc:2,code:VABoAGUAIABjAG8AZABlACAAdABvACAAdABoAGUAIAByAGkAZwBoAHQAIABmAGkAZwB1AHIAZQBzACAAbwB1AHQACgB3AGgAaQBjAGgAIABwAGwAYQBuAGUAIAB0AGgAZQAgAHMAaABhAGQAZQByACAAaQBzACAAdwBvAHIAawBpAG4AZwAgAG8AbgAKAHIAaQBnAGgAdAAgAG4AbwB3AC4AIABUAG8AIABmAGkAZwB1AHIAZQAgAHQAaABpAHMAIABvAHUAdAAgAHcAaQB0AGgAbwB1AHQACgB0AG8AbwAgAG0AdQBjAGgAIABhAGQAbwAsACAAdwBlACAAcwBhAHYAZQBkACAAaQB0ACAAaQBuAHQAbwAgAHQAaABlAAoAdABlAHgAdAB1AHIAZQAnAHMAIABhAGwAcABoAGEAIABjAGgAYQBuAG4AZQBsAC4ACgAKADAALgAwADEAIABhAGwAcABoAGEAIABpAHMAIABhACAAdAByAGEAbgBzAHAAYQByAGUAbgB0ACAAcABpAHgAZQBsACAAbwBuACAARgBPAFIAVwBBAFIARAAgAHAAbABhAG4AZQAuAAoAMAAuADAAMgAgAGEAbABwAGgAYQAgAGkAcwAgAGEAIAB0AHIAYQBuAHMAcABhAHIAZQBuAHQAIABwAGkAeABlAGwAIABvAG4AIABSAEkARwBIAFQAIABwAGwAYQBuAGUALgAKADAALgAwADMAIABhAGwAcABoAGEAIABpAHMAIABhACAAdAByAGEAbgBzAHAAYQByAGUAbgB0ACAAcABpAHgAZQBsACAAbwBuACAAVABPAFAAIABwAGwAYQBuAGUALgAKADAALgA5ADgAIABpAHMAIABhAG4AIABvAHAAYQBxAHUAZQAgAHAAaQB4AGUAbAAgAG8AbgAgAEYATwBSAFcAQQBSAEQAIABwAGwAYQBuAGUALgAKADAALgA5ADkAIABpAHMAIABhAG4AIABvAHAAYQBxAHUAZQAgAHAAaQB4AGUAbAAgAG8AbgAgAFIASQBHAEgAVAAgAHAAbABhAG4AZQAuAAoAMQAuADAAMAAgAGkAcwAgAGEAbgAgAG8AcABhAHEAdQBlACAAcABpAHgAZQBsACAAbwBuACAAVABPAFAAIABwAGwAYQBuAGUALgA=,output:2,fname:PlaneNumberInfo,width:412,height:196;n:type:ShaderForge.SFN_If,id:8837,x:29162,y:31108,varname:node_8837,prsc:2|A-9388-OUT,B-4470-OUT,GT-6426-OUT,EQ-6237-OUT,LT-6237-OUT;n:type:ShaderForge.SFN_Get,id:9388,x:28366,y:31076,varname:node_9388,prsc:2|IN-3191-OUT;n:type:ShaderForge.SFN_Vector1,id:4470,x:28880,y:31060,varname:node_4470,prsc:2,v1:0.5;n:type:ShaderForge.SFN_Multiply,id:6237,x:28777,y:31386,varname:node_6237,prsc:2|A-9388-OUT,B-9006-OUT;n:type:ShaderForge.SFN_Vector1,id:9006,x:28586,y:31401,varname:node_9006,prsc:2,v1:100;n:type:ShaderForge.SFN_Subtract,id:1104,x:28670,y:31125,varname:node_1104,prsc:2|A-9388-OUT,B-2827-OUT;n:type:ShaderForge.SFN_Vector1,id:2827,x:28410,y:31171,varname:node_2827,prsc:2,v1:0.97;n:type:ShaderForge.SFN_Multiply,id:6426,x:28880,y:31136,varname:node_6426,prsc:2|A-1104-OUT,B-9006-OUT;n:type:ShaderForge.SFN_Round,id:1192,x:29339,y:31108,varname:node_1192,prsc:2|IN-8837-OUT;n:type:ShaderForge.SFN_Multiply,id:8651,x:30120,y:31388,cmnt:Inputting 0.5 will multiply by 1 which has no effect. Less than 0.5 will darken from 0 to 1 and above 0.5 will brighten by multiplying from 1 to 2x.,varname:node_8651,prsc:2|A-6665-RGB,B-4172-OUT;n:type:ShaderForge.SFN_Vector1,id:4172,x:29897,y:31321,varname:node_4172,prsc:2,v1:2;n:type:ShaderForge.SFN_ViewVector,id:9957,x:30468,y:30604,varname:node_9957,prsc:2;n:type:ShaderForge.SFN_Dot,id:5179,x:30681,y:30695,cmnt:Check if view is opposite the direction of sunlight,varname:node_5179,prsc:2,dt:4|A-9957-OUT,B-5475-OUT;n:type:ShaderForge.SFN_RemapRange,id:2187,x:30858,y:30731,cmnt:Rescales it to 0.7 to 1 multiplied by 0.75 which yields 0.525 to 0.75,varname:node_2187,prsc:2,frmn:-1,frmx:1,tomn:0.525,tomx:0.75|IN-5179-OUT;n:type:ShaderForge.SFN_Set,id:7789,x:30297,y:30069,varname:LightIN,prsc:2|IN-1638-OUT;n:type:ShaderForge.SFN_Vector4Property,id:5268,x:29324,y:30380,ptovrint:False,ptlb:_LushLODTreeMainLightDir,ptin:_LushLODTreeMainLightDir,cmnt:The W is set via script in _LushLODTreesManager.cs,varname:node_8259,prsc:2,glob:True,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,v1:0.5,v2:0.5,v3:0.5,v4:1;n:type:ShaderForge.SFN_Color,id:4725,x:29324,y:30084,ptovrint:False,ptlb:LushLODTreeMainLightCol,ptin:_LushLODTreeMainLightCol,cmnt:This works even with lightmaps,varname:node_349,prsc:2,glob:True,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,c1:0.5,c2:0.5,c3:0.5,c4:1;n:type:ShaderForge.SFN_ValueProperty,id:2566,x:29324,y:30265,ptovrint:False,ptlb:LushLODTreeMainLightIntensity,ptin:_LushLODTreeMainLightIntensity,cmnt:This works even with lightmaps,varname:node_5384,prsc:2,glob:True,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,v1:1;n:type:ShaderForge.SFN_Set,id:2236,x:29646,y:30406,varname:LightDir,prsc:2|IN-5268-XYZ;n:type:ShaderForge.SFN_Get,id:5475,x:30468,y:30741,varname:node_5475,prsc:2|IN-2236-OUT;n:type:ShaderForge.SFN_Dot,id:9047,x:30835,y:30345,cmnt:Is the sun above the horizon?,varname:node_9047,prsc:2,dt:0|A-3277-OUT,B-5518-OUT;n:type:ShaderForge.SFN_Get,id:5518,x:30602,y:30391,varname:node_5518,prsc:2|IN-2236-OUT;n:type:ShaderForge.SFN_Vector3,id:3277,x:30602,y:30278,cmnt:Checks if the light is shining straight down,varname:node_3277,prsc:2,v1:0,v2:1,v3:0;n:type:ShaderForge.SFN_Clamp01,id:7448,x:31399,y:30349,varname:node_7448,prsc:2|IN-4304-OUT;n:type:ShaderForge.SFN_Clamp01,id:3884,x:31863,y:30193,varname:node_3884,prsc:2|IN-137-OUT;n:type:ShaderForge.SFN_Set,id:5122,x:32440,y:30223,cmnt:This is an optional lighting adjustment you can remove this if your scene doesnt benefit from this.,varname:TimeOfDayIntensity,prsc:2|IN-6869-OUT;n:type:ShaderForge.SFN_Add,id:4304,x:31214,y:30349,cmnt:This makes the trees not get dark until the sun is somewhat BELOW the horizon.,varname:node_4304,prsc:2|A-9047-OUT,B-9402-OUT;n:type:ShaderForge.SFN_Vector1,id:9402,x:31026,y:30383,varname:node_9402,prsc:2,v1:0.25;n:type:ShaderForge.SFN_RemapRangeAdvanced,id:137,x:31662,y:30193,cmnt:Rescales it from 01 to about 03 to make it get brigher faster as the sun comes up. This effect is significantly stronger on the sunny side via backside darkening.,varname:node_137,prsc:2|IN-7448-OUT,IMIN-5583-OUT,IMAX-325-OUT,OMIN-6043-OUT,OMAX-8729-OUT;n:type:ShaderForge.SFN_Vector1,id:5583,x:31399,y:30044,varname:node_5583,prsc:2,v1:0;n:type:ShaderForge.SFN_Vector1,id:325,x:31399,y:30093,varname:node_325,prsc:2,v1:1;n:type:ShaderForge.SFN_Vector1,id:6043,x:31399,y:30148,varname:node_6043,prsc:2,v1:0;n:type:ShaderForge.SFN_Vector1,id:9184,x:31196,y:30104,varname:node_9184,prsc:2,v1:1.3;n:type:ShaderForge.SFN_Add,id:8729,x:31399,y:30198,varname:node_8729,prsc:2|A-9184-OUT,B-4878-OUT;n:type:ShaderForge.SFN_Get,id:1502,x:31019,y:30106,varname:node_1502,prsc:2|IN-6719-OUT;n:type:ShaderForge.SFN_Multiply,id:4878,x:31196,y:30170,varname:node_4878,prsc:2|A-1502-OUT,B-2487-OUT;n:type:ShaderForge.SFN_Vector1,id:2487,x:31019,y:30189,varname:node_2487,prsc:2,v1:2;n:type:ShaderForge.SFN_NormalVector,id:4926,x:31639,y:30617,prsc:2,pt:False;n:type:ShaderForge.SFN_Set,id:7083,x:32033,y:30717,varname:NormalIN,prsc:2|IN-5312-OUT;n:type:ShaderForge.SFN_FaceSign,id:6488,x:31639,y:30763,varname:node_6488,prsc:2,fstp:1;n:type:ShaderForge.SFN_Multiply,id:5312,x:31863,y:30700,cmnt:Stop it from reversing the normal when viewed from backface.,varname:node_5312,prsc:2|A-4926-OUT,B-6488-VFACE;n:type:ShaderForge.SFN_Set,id:9144,x:28768,y:31824,varname:FinalColor_Corrected,prsc:2|IN-3145-OUT;n:type:ShaderForge.SFN_Code,id:3145,x:28281,y:31816,cmnt:Note GetSeamsBlending is in SeamsBlending.cginc,varname:node_3145,prsc:2,code:cgBlAHQAdQByAG4AIABHAGUAdABTAGUAYQBtAHMAQgBsAGUAbgBkAGkAbgBnAF8ATgBvAEEAbgBnAHUAbABhAHIACQAKAAkAKAAJAAoACQAJAEIAaQBUAGEAbgBEAGkAcgAsAAoACQAJAE4AbwByAG0AYQBsAEkATgAsAAoACQAJAFcAbwByAGwAZABQAG8AcwBDAGUAbgB0AGUAcgAsAAoACQAJAFAAbABhAG4AZQBOAHUAbQBiAGUAcgAsAAoACQAJAEYAaQBuAGEAbABDAG8AbABvAHIASQBOACwACgAJAAkAVQBWADMAQwBvAGwAbwByACwACgAJAAkAVQBWADQAQwBvAGwAbwByACwACgAJAAkAVwBvAHIAbABkAFAAbwBzACwACgAJAAkAVABhAG4ARABpAHIACgAJACkALgByAGcAYgA7AA==,output:2,fname:GetSeamsBlending_Caller,width:384,height:237,input:2,input:2,input:2,input:0,input:2,input:3,input:3,input:2,input:2,input_1_label:BiTanDir,input_2_label:NormalIN,input_3_label:WorldPosCenter,input_4_label:PlaneNumber,input_5_label:FinalColorIN,input_6_label:UV3Color,input_7_label:UV4Color,input_8_label:WorldPos,input_9_label:TanDir|A-7378-OUT,B-847-OUT,C-6499-OUT,D-1211-OUT,E-619-OUT,F-8449-OUT,G-8154-OUT,H-3198-XYZ,I-6646-OUT;n:type:ShaderForge.SFN_Get,id:847,x:27807,y:31751,varname:node_847,prsc:2|IN-7083-OUT;n:type:ShaderForge.SFN_Get,id:6499,x:27807,y:31794,varname:node_6499,prsc:2|IN-6116-OUT;n:type:ShaderForge.SFN_Get,id:1211,x:27807,y:31839,varname:node_1211,prsc:2|IN-5415-OUT;n:type:ShaderForge.SFN_Get,id:619,x:27807,y:31884,varname:node_619,prsc:2|IN-4973-OUT;n:type:ShaderForge.SFN_Get,id:8449,x:27807,y:31928,varname:node_8449,prsc:2|IN-9204-OUT;n:type:ShaderForge.SFN_Get,id:8154,x:27807,y:31971,varname:node_8154,prsc:2|IN-1759-OUT;n:type:ShaderForge.SFN_FragmentPosition,id:3198,x:27807,y:32021,varname:node_3198,prsc:2;n:type:ShaderForge.SFN_Tangent,id:6646,x:27807,y:32137,varname:node_6646,prsc:2;n:type:ShaderForge.SFN_Bitangent,id:7378,x:27795,y:31635,varname:node_7378,prsc:2;n:type:ShaderForge.SFN_Append,id:6850,x:31323,y:31701,varname:node_6850,prsc:2|A-9956-RGB,B-9956-A;n:type:ShaderForge.SFN_Append,id:7063,x:31323,y:31882,varname:node_7063,prsc:2|A-4547-RGB,B-4547-A;n:type:ShaderForge.SFN_Code,id:7549,x:28267,y:32473,cmnt:Note GetSeamsBlending is in SeamsBlending.cginc,varname:node_7549,prsc:2,code:cgBlAHQAdQByAG4AIABHAGUAdABXAG8AcgBsAGQAUABvAHMAaQB0AGkAbwBuAEMAZQBuAHQAZQByAAoACQAoAAkACgAJAAkAQgBpAFQAYQBuAEQAaQByACwACgAJAAkAVwBvAHIAbABkAFAAbwBzACwACgAJAAkAVABhAG4ARABpAHIALAAKAAkACQBVAFYAMQAsAAoACQAJAFUAVgAwAAoACQApAC4AcgBnAGIAOwA=,output:2,fname:GetWorldPositionCenter_Caller,width:406,height:248,input:2,input:2,input:2,input:1,input:1,input_1_label:BiTanDir,input_2_label:WorldPos,input_3_label:TanDir,input_4_label:UV1,input_5_label:UV0|A-5286-OUT,B-9329-XYZ,C-6382-OUT,D-5814-OUT,E-4857-OUT;n:type:ShaderForge.SFN_Get,id:5814,x:27793,y:32661,varname:node_5814,prsc:2|IN-7633-OUT;n:type:ShaderForge.SFN_Get,id:4857,x:27793,y:32704,varname:node_4857,prsc:2|IN-647-OUT;n:type:ShaderForge.SFN_FragmentPosition,id:9329,x:27814,y:32417,varname:node_9329,prsc:2;n:type:ShaderForge.SFN_Tangent,id:6382,x:27814,y:32533,varname:node_6382,prsc:2;n:type:ShaderForge.SFN_TexCoord,id:4362,x:30722,y:32167,varname:node_4362,prsc:2,uv:0,uaff:False;n:type:ShaderForge.SFN_TexCoord,id:1099,x:30722,y:32019,varname:node_1099,prsc:2,uv:1,uaff:False;n:type:ShaderForge.SFN_Set,id:647,x:31143,y:32169,varname:UV0_IN,prsc:2|IN-4362-UVOUT;n:type:ShaderForge.SFN_Set,id:7633,x:31143,y:32022,varname:UV1_IN,prsc:2|IN-1099-UVOUT;n:type:ShaderForge.SFN_Bitangent,id:5286,x:27814,y:32294,varname:node_5286,prsc:2;n:type:ShaderForge.SFN_Code,id:958,x:31451,y:31530,varname:node_958,prsc:2,code:YwBsAGkAcAAoAFQAZQB4AEEAbABwAGgAYQAgAC0AIABDAHUAdABvAGYAZgApADsACgByAGUAdAB1AHIAbgAgAFQAZQB4AEEAbABwAGgAYQA7AA==,output:0,fname:ClipMe,width:247,height:112,input:0,input:0,input_1_label:TexAlpha,input_2_label:Cutoff|A-7736-A,B-2508-OUT;n:type:ShaderForge.SFN_Get,id:2508,x:31202,y:31581,varname:node_2508,prsc:2|IN-7766-OUT;n:type:ShaderForge.SFN_TexCoord,id:7002,x:27825,y:32819,varname:node_7002,prsc:2,uv:0,uaff:False;n:type:ShaderForge.SFN_Code,id:4335,x:28123,y:32883,varname:node_4335,prsc:2,code:cgBlAHQAdQByAG4AIABHAGUAdABEAGkAdABoAGUAcgBTAGgAYQBkAG8AdwBzAF8AQgBPAFQASABQAEEAUwBTACgAVQBWADAAXwBJAE4ALAAgAFQAcgBhAG4AcwBwAGEAcgBlAG4AYwB5ACkAOwA=,output:0,fname:GetDitherShadows_Caller,width:453,height:128,input:1,input:0,input_1_label:UV0_IN,input_2_label:Transparency|A-7002-UVOUT,B-1809-OUT;n:type:ShaderForge.SFN_Get,id:1809,x:27804,y:32968,varname:node_1809,prsc:2|IN-7143-OUT;n:type:ShaderForge.SFN_Get,id:1171,x:35189,y:31233,cmnt:Attaching this forces ClipME to run in both passes,varname:node_1171,prsc:2|IN-3191-OUT;n:type:ShaderForge.SFN_Min,id:8916,x:35414,y:31233,varname:node_8916,prsc:2|A-1171-OUT,B-2650-OUT;n:type:ShaderForge.SFN_Multiply,id:1638,x:30065,y:30069,varname:node_1638,prsc:2|A-4725-RGB,B-6545-OUT;n:type:ShaderForge.SFN_Get,id:8868,x:33136,y:30584,cmnt:The main texture color with some modifications for things like seams blending.,varname:node_8868,prsc:2|IN-9144-OUT;n:type:ShaderForge.SFN_Get,id:2160,x:32965,y:30880,cmnt:The color of the main diretional light,varname:node_2160,prsc:2|IN-7789-OUT;n:type:ShaderForge.SFN_Get,id:9703,x:33429,y:31429,cmnt:The shadows value,varname:node_9703,prsc:2|IN-6719-OUT;n:type:ShaderForge.SFN_Get,id:9030,x:34932,y:30594,varname:node_9030,prsc:2|IN-5122-OUT;n:type:ShaderForge.SFN_Add,id:2975,x:33282,y:30902,varname:node_2975,prsc:2|A-2160-OUT,B-6555-RGB;n:type:ShaderForge.SFN_Multiply,id:6559,x:33542,y:30845,cmnt:The final texture color with all lights but no shadows yet,varname:node_6559,prsc:2|A-8868-OUT,B-2975-OUT;n:type:ShaderForge.SFN_Lerp,id:7670,x:34147,y:31029,cmnt:The final color with the shadows and ambient tint applied to the shadows,varname:node_7670,prsc:2|A-970-OUT,B-6559-OUT,T-3000-OUT;n:type:ShaderForge.SFN_Multiply,id:970,x:33776,y:31216,varname:node_970,prsc:2|A-8865-OUT,B-3942-OUT;n:type:ShaderForge.SFN_Blend,id:8865,x:33564,y:31137,cmnt:The color of the shadow is based entirely off the texture color and the ambient light color,varname:node_8865,prsc:2,blmd:1,clmp:False|SRC-6555-RGB,DST-8868-OUT;n:type:ShaderForge.SFN_Vector1,id:3942,x:33538,y:31312,varname:node_3942,prsc:2,v1:0.8;n:type:ShaderForge.SFN_Get,id:6207,x:33633,y:30628,varname:node_6207,prsc:2|IN-7375-OUT;n:type:ShaderForge.SFN_Max,id:766,x:34147,y:30697,cmnt:Finds the highest input color value,varname:node_766,prsc:2|A-1132-R,B-1132-G,C-1132-B;n:type:ShaderForge.SFN_Min,id:3530,x:34147,y:30855,cmnt:Finds how much LESS than WHITE the input color is,varname:node_3530,prsc:2|A-1132-R,B-1132-G,C-1132-B;n:type:ShaderForge.SFN_ComponentMask,id:1132,x:33848,y:30628,cmnt:The input color,varname:node_1132,prsc:2,cc1:0,cc2:1,cc3:2,cc4:-1|IN-6207-OUT;n:type:ShaderForge.SFN_Multiply,id:288,x:34175,y:30388,cmnt:The input color multiplied by the texture color to give the input color a texture so that it doesnt look flat,varname:node_288,prsc:2|A-8868-OUT,B-1132-OUT;n:type:ShaderForge.SFN_Multiply,id:8087,x:34505,y:30616,cmnt:Darkens the final color based on the input ccolor,varname:node_8087,prsc:2|A-7670-OUT,B-1132-OUT;n:type:ShaderForge.SFN_Lerp,id:9623,x:34515,y:30414,cmnt:Lerps towards the input color based on how much the input color is LESS than WHITE,varname:node_9623,prsc:2|A-288-OUT,B-7670-OUT,T-3530-OUT;n:type:ShaderForge.SFN_Subtract,id:9614,x:34676,y:30762,cmnt:Finds the difference between the highest and lowest color value. This is used to detect if our iput color is simply a shade of grey and has no color,varname:node_9614,prsc:2|A-766-OUT,B-3530-OUT;n:type:ShaderForge.SFN_Lerp,id:4425,x:34953,y:30463,varname:node_4425,prsc:2|A-8087-OUT,B-9623-OUT,T-9614-OUT;n:type:ShaderForge.SFN_Multiply,id:7269,x:35286,y:30503,varname:node_7269,prsc:2|A-4425-OUT,B-9030-OUT;n:type:ShaderForge.SFN_Clamp,id:3000,x:33737,y:31431,cmnt:This lets the user adjust te maximum shadow. A value of 0.5 will limit it to half.,varname:node_3000,prsc:2|IN-9703-OUT,MIN-6372-OUT,MAX-8829-OUT;n:type:ShaderForge.SFN_Vector1,id:8829,x:33429,y:31525,varname:node_8829,prsc:2,v1:1;n:type:ShaderForge.SFN_ValueProperty,id:9737,x:33308,y:31636,ptovrint:False,ptlb:_LushLODTreeShadowDarkness,ptin:_LushLODTreeShadowDarkness,cmnt:_LusLODSadowDarkness... this is cotrolled by the manager in its Update function,varname:node_2612,prsc:2,glob:True,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,v1:1;n:type:ShaderForge.SFN_OneMinus,id:6372,x:33507,y:31636,varname:node_6372,prsc:2|IN-9737-OUT;n:type:ShaderForge.SFN_Lerp,id:6869,x:32204,y:30309,cmnt:Lets the user adjust the tie of day correction,varname:node_6869,prsc:2|A-9923-OUT,B-3884-OUT,T-7283-OUT;n:type:ShaderForge.SFN_ValueProperty,id:7283,x:31957,y:30381,ptovrint:False,ptlb:LushLODTreeTimeOfDay,ptin:_LushLODTreeTimeOfDay,varname:node_5174,prsc:2,glob:True,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,v1:1;n:type:ShaderForge.SFN_Vector1,id:9923,x:31957,y:30309,varname:node_9923,prsc:2,v1:1;n:type:ShaderForge.SFN_Divide,id:6545,x:29751,y:30133,varname:node_6545,prsc:2|A-2566-OUT,B-6349-OUT;n:type:ShaderForge.SFN_Vector1,id:6349,x:29499,y:30156,varname:node_6349,prsc:2,v1:1.2;n:type:ShaderForge.SFN_Color,id:6555,x:32968,y:31100,ptovrint:False,ptlb:_LushLODTreeAmbientColor,ptin:_LushLODTreeAmbientColor,cmnt:_LushLODTreeAmbientColor... this value is set in the manager,varname:_LushLODTreeAmbientColor_copy,prsc:2,glob:True,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,c1:0.5,c2:0.5,c3:0.5,c4:1;proporder:6665-6832-6298-5916-1495;pass:END;sub:END;*/

Shader "Hidden/LushLODTree/Tree_Leaves2_Deferred" {
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
            "Queue"="AlphaTest"
            "RenderType"="TransparentCutout"
            "CanUseSpriteAtlas"="True"
        }
        Pass {
            Name "DEFERRED"
            Tags {
                "LightMode"="Deferred"
            }
            Cull Off
            
            
            CGPROGRAM
            #pragma vertex vert
            #pragma fragment frag
            #define UNITY_PASS_DEFERRED
            #include "UnityCG.cginc"
            #include "UnityPBSLighting.cginc"
            #include "UnityStandardBRDF.cginc"
            #include "CGIncludes/SeamsBlending_NoAngular.cginc"
            #include "CGIncludes/WorldPositionCenter.cginc"
            #include "CGIncludes/Dithering.cginc"
            #pragma fragmentoption ARB_precision_hint_fastest
            #pragma multi_compile_shadowcaster
            #pragma multi_compile ___ UNITY_HDR_ON
            #pragma multi_compile_fog
            #pragma target 3.0
            uniform float4 _Color;
            uniform float _Transparency;
            uniform float _Cutoff;
            uniform sampler2D _MainTex; uniform float4 _MainTex_ST;
            uniform float4 _LushLODTreeMainLightDir;
            uniform float4 _LushLODTreeMainLightCol;
            uniform float _LushLODTreeMainLightIntensity;
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
            
            float GetDitherShadows_Caller( float2 UV0_IN , float Transparency ){
            return GetDitherShadows_BOTHPASS(UV0_IN, Transparency);
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
                float3 bitangentDir : TEXCOORD7;
            };
            VertexOutput vert (VertexInput v) {
                VertexOutput o = (VertexOutput)0;
                o.uv0 = v.texcoord0;
                o.uv1 = v.texcoord1;
                o.uv2 = v.texcoord2;
                o.uv3 = v.texcoord3;
                o.normalDir = UnityObjectToWorldNormal(v.normal);
                o.tangentDir = normalize( mul( unity_ObjectToWorld, float4( v.tangent.xyz, 0.0 ) ).xyz );
                o.bitangentDir = normalize(cross(o.normalDir, o.tangentDir) * v.tangent.w);
                o.posWorld = mul(unity_ObjectToWorld, v.vertex);
                o.pos = UnityObjectToClipPos( v.vertex );
                return o;
            }
            void frag(
                VertexOutput i,
                out half4 outDiffuse : SV_Target0,
                out half4 outSpecSmoothness : SV_Target1,
                out half4 outNormal : SV_Target2,
                out half4 outEmission : SV_Target3,
                float facing : VFACE )
            {
                float isFrontFace = ( facing >= 0 ? 1 : 0 );
                float faceSign = ( facing >= 0 ? 1 : -1 );
                i.normalDir = normalize(i.normalDir);
                i.normalDir *= faceSign;
                float3 viewDirection = normalize(_WorldSpaceCameraPos.xyz - i.posWorld.xyz);
                float3 normalDirection = i.normalDir;
                float3 viewReflectDirection = reflect( -viewDirection, normalDirection );
                float4 node_3116_MAINPASS = tex2D(_MainTex,TRANSFORM_TEX(i.uv0, _MainTex));
                float Param_Cutoff = _Cutoff;
                float TexAlpha = ClipMe( node_3116_MAINPASS.a , Param_Cutoff );
                float Param_ShadowTrans_SHADOWPASS = _Transparency;
                float DITHER_SHADOWPASS = GetDitherShadows_Caller( i.uv0 , Param_ShadowTrans_SHADOWPASS );
                clip(min(TexAlpha,DITHER_SHADOWPASS) - 0.5);
////// Lighting:
////// Emissive:
                float3 NormalIN = (i.normalDir*faceSign);
                float2 UV1_IN = i.uv1;
                float2 UV0_IN = i.uv0;
                float3 WorldPosCenter = GetWorldPositionCenter_Caller( i.bitangentDir , i.posWorld.rgb , i.tangentDir , UV1_IN , UV0_IN );
                float node_9388 = TexAlpha;
                float node_8837_if_leA = step(node_9388,0.5);
                float node_8837_if_leB = step(0.5,node_9388);
                float node_9006 = 100.0;
                float node_6237 = (node_9388*node_9006);
                float PlaneNumber = round(lerp((node_8837_if_leA*node_6237)+(node_8837_if_leB*((node_9388-0.97)*node_9006)),node_6237,node_8837_if_leA*node_8837_if_leB)); // A number identifying which plane this is
                float3 MainTexIN = node_3116_MAINPASS.rgb;
                float4 node_3117_MAINPASS = tex2D(_MainTex,TRANSFORM_TEX(i.uv2, _MainTex)); // Color and alpha from UV3 is used by the horizontal plane to draw the Line Z and part of the circle
                float4 UV3ColorIN = float4(node_3117_MAINPASS.rgb,node_3117_MAINPASS.a);
                float4 node_3118_MAINPASS = tex2D(_MainTex,TRANSFORM_TEX(i.uv3, _MainTex)); // Color and alpha from UV4 is used by all three planes to draw all or parts of their circlecrosses
                float4 UV4ColorIN = float4(node_3118_MAINPASS.rgb,node_3118_MAINPASS.a);
                float3 FinalColor_Corrected = GetSeamsBlending_Caller( i.bitangentDir , NormalIN , WorldPosCenter , PlaneNumber , MainTexIN , UV3ColorIN , UV4ColorIN , i.posWorld.rgb , i.tangentDir );
                float3 node_8868 = FinalColor_Corrected; // The main texture color with some modifications for things like seams blending.
                float3 LightIN = (_LushLODTreeMainLightCol.rgb*(_LushLODTreeMainLightIntensity/1.2));
                float3 LightDir = _LushLODTreeMainLightDir.rgb;
                float node_5179 = 0.5*dot(viewDirection,LightDir)+0.5; // Check if view is opposite the direction of sunlight
                float Backside_Darkening_Amount = node_5179; // Darkens the trees when viewed from the back side
                float3 node_7670 = lerp(((_LushLODTreeAmbientColor.rgb*node_8868)*0.8),(node_8868*(LightIN+_LushLODTreeAmbientColor.rgb)),clamp(Backside_Darkening_Amount,(1.0 - _LushLODTreeShadowDarkness),1.0)); // The final color with the shadows and ambient tint applied to the shadows
                float3 Param_Color = (_Color.rgb*2.0);
                float3 node_1132 = Param_Color.rgb; // The input color
                float node_3530 = min(min(node_1132.r,node_1132.g),node_1132.b); // Finds how much LESS than WHITE the input color is
                float node_5583 = 0.0;
                float node_6043 = 0.0;
                float TimeOfDayIntensity = lerp(1.0,saturate((node_6043 + ( (saturate((dot(float3(0,1,0),LightDir)+0.25)) - node_5583) * ((1.3+(Backside_Darkening_Amount*2.0)) - node_6043) ) / (1.0 - node_5583))),_LushLODTreeTimeOfDay); // This is an optional lighting adjustment you can remove this if your scene doesnt benefit from this.
                float3 emissive = (lerp((node_7670*node_1132),lerp((node_8868*node_1132),node_7670,node_3530),(max(max(node_1132.r,node_1132.g),node_1132.b)-node_3530))*TimeOfDayIntensity);
                float3 finalColor = emissive;
                outDiffuse = half4( 0, 0, 0, 1 );
                outSpecSmoothness = half4(0,0,0,0);
                outNormal = half4( normalDirection * 0.5 + 0.5, 1 );
                outEmission = half4( (lerp((node_7670*node_1132),lerp((node_8868*node_1132),node_7670,node_3530),(max(max(node_1132.r,node_1132.g),node_1132.b)-node_3530))*TimeOfDayIntensity), 1 );
                #ifndef UNITY_HDR_ON
                    outEmission.rgb = exp2(-outEmission.rgb);
                #endif
            }
            ENDCG
        }
        Pass {
            Name "FORWARD"
            Tags {
                "LightMode"="ForwardBase"
            }
            Cull Off
            
            
            CGPROGRAM
            #pragma vertex vert
            #pragma fragment frag
            #define UNITY_PASS_FORWARDBASE
            #include "UnityCG.cginc"
            #include "UnityPBSLighting.cginc"
            #include "UnityStandardBRDF.cginc"
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
            
            float GetDitherShadows_Caller( float2 UV0_IN , float Transparency ){
            return GetDitherShadows_BOTHPASS(UV0_IN, Transparency);
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
                float3 bitangentDir : TEXCOORD7;
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
                o.bitangentDir = normalize(cross(o.normalDir, o.tangentDir) * v.tangent.w);
                o.posWorld = mul(unity_ObjectToWorld, v.vertex);
                o.pos = UnityObjectToClipPos( v.vertex );
                UNITY_TRANSFER_FOG(o,o.pos);
                return o;
            }
            float4 frag(VertexOutput i, float facing : VFACE) : COLOR {
                float isFrontFace = ( facing >= 0 ? 1 : 0 );
                float faceSign = ( facing >= 0 ? 1 : -1 );
                i.normalDir = normalize(i.normalDir);
                i.normalDir *= faceSign;
                float3 viewDirection = normalize(_WorldSpaceCameraPos.xyz - i.posWorld.xyz);
                float3 normalDirection = i.normalDir;
                float3 viewReflectDirection = reflect( -viewDirection, normalDirection );
                float4 node_3116_MAINPASS = tex2D(_MainTex,TRANSFORM_TEX(i.uv0, _MainTex));
                float Param_Cutoff = _Cutoff;
                float TexAlpha = ClipMe( node_3116_MAINPASS.a , Param_Cutoff );
                float Param_ShadowTrans_SHADOWPASS = _Transparency;
                float DITHER_SHADOWPASS = GetDitherShadows_Caller( i.uv0 , Param_ShadowTrans_SHADOWPASS );
                clip(min(TexAlpha,DITHER_SHADOWPASS) - 0.5);
////// Lighting:
////// Emissive:
                float3 NormalIN = (i.normalDir*faceSign);
                float2 UV1_IN = i.uv1;
                float2 UV0_IN = i.uv0;
                float3 WorldPosCenter = GetWorldPositionCenter_Caller( i.bitangentDir , i.posWorld.rgb , i.tangentDir , UV1_IN , UV0_IN );
                float node_9388 = TexAlpha;
                float node_8837_if_leA = step(node_9388,0.5);
                float node_8837_if_leB = step(0.5,node_9388);
                float node_9006 = 100.0;
                float node_6237 = (node_9388*node_9006);
                float PlaneNumber = round(lerp((node_8837_if_leA*node_6237)+(node_8837_if_leB*((node_9388-0.97)*node_9006)),node_6237,node_8837_if_leA*node_8837_if_leB)); // A number identifying which plane this is
                float3 MainTexIN = node_3116_MAINPASS.rgb;
                float4 node_3117_MAINPASS = tex2D(_MainTex,TRANSFORM_TEX(i.uv2, _MainTex)); // Color and alpha from UV3 is used by the horizontal plane to draw the Line Z and part of the circle
                float4 UV3ColorIN = float4(node_3117_MAINPASS.rgb,node_3117_MAINPASS.a);
                float4 node_3118_MAINPASS = tex2D(_MainTex,TRANSFORM_TEX(i.uv3, _MainTex)); // Color and alpha from UV4 is used by all three planes to draw all or parts of their circlecrosses
                float4 UV4ColorIN = float4(node_3118_MAINPASS.rgb,node_3118_MAINPASS.a);
                float3 FinalColor_Corrected = GetSeamsBlending_Caller( i.bitangentDir , NormalIN , WorldPosCenter , PlaneNumber , MainTexIN , UV3ColorIN , UV4ColorIN , i.posWorld.rgb , i.tangentDir );
                float3 node_8868 = FinalColor_Corrected; // The main texture color with some modifications for things like seams blending.
                float3 LightIN = (_LushLODTreeMainLightCol.rgb*(_LushLODTreeMainLightIntensity/1.2));
                float3 LightDir = _LushLODTreeMainLightDir.rgb;
                float node_5179 = 0.5*dot(viewDirection,LightDir)+0.5; // Check if view is opposite the direction of sunlight
                float Backside_Darkening_Amount = node_5179; // Darkens the trees when viewed from the back side
                float3 node_7670 = lerp(((_LushLODTreeAmbientColor.rgb*node_8868)*0.8),(node_8868*(LightIN+_LushLODTreeAmbientColor.rgb)),clamp(Backside_Darkening_Amount,(1.0 - _LushLODTreeShadowDarkness),1.0)); // The final color with the shadows and ambient tint applied to the shadows
                float3 Param_Color = (_Color.rgb*2.0);
                float3 node_1132 = Param_Color.rgb; // The input color
                float node_3530 = min(min(node_1132.r,node_1132.g),node_1132.b); // Finds how much LESS than WHITE the input color is
                float node_5583 = 0.0;
                float node_6043 = 0.0;
                float TimeOfDayIntensity = lerp(1.0,saturate((node_6043 + ( (saturate((dot(float3(0,1,0),LightDir)+0.25)) - node_5583) * ((1.3+(Backside_Darkening_Amount*2.0)) - node_6043) ) / (1.0 - node_5583))),_LushLODTreeTimeOfDay); // This is an optional lighting adjustment you can remove this if your scene doesnt benefit from this.
                float3 emissive = (lerp((node_7670*node_1132),lerp((node_8868*node_1132),node_7670,node_3530),(max(max(node_1132.r,node_1132.g),node_1132.b)-node_3530))*TimeOfDayIntensity);
                float3 finalColor = emissive;
                fixed4 finalRGBA = fixed4(finalColor,1);
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
            #include "UnityPBSLighting.cginc"
            #include "UnityStandardBRDF.cginc"
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
            float ClipMe( float TexAlpha , float Cutoff ){
            clip(TexAlpha - Cutoff);
            return TexAlpha;
            }
            
            float GetDitherShadows_Caller( float2 UV0_IN , float Transparency ){
            return GetDitherShadows_BOTHPASS(UV0_IN, Transparency);
            }
            
            struct VertexInput {
                float4 vertex : POSITION;
                float2 texcoord0 : TEXCOORD0;
            };
            struct VertexOutput {
                V2F_SHADOW_CASTER;
                float2 uv0 : TEXCOORD1;
            };
            VertexOutput vert (VertexInput v) {
                VertexOutput o = (VertexOutput)0;
                o.uv0 = v.texcoord0;
                o.pos = UnityObjectToClipPos( v.vertex );
                TRANSFER_SHADOW_CASTER(o)
                return o;
            }
            float4 frag(VertexOutput i, float facing : VFACE) : COLOR {
                float isFrontFace = ( facing >= 0 ? 1 : 0 );
                float faceSign = ( facing >= 0 ? 1 : -1 );
                float4 node_3116_MAINPASS = tex2D(_MainTex,TRANSFORM_TEX(i.uv0, _MainTex));
                float Param_Cutoff = _Cutoff;
                float TexAlpha = ClipMe( node_3116_MAINPASS.a , Param_Cutoff );
                float Param_ShadowTrans_SHADOWPASS = _Transparency;
                float DITHER_SHADOWPASS = GetDitherShadows_Caller( i.uv0 , Param_ShadowTrans_SHADOWPASS );
                clip(min(TexAlpha,DITHER_SHADOWPASS) - 0.5);
                SHADOW_CASTER_FRAGMENT(i)
            }
            ENDCG
        }
    }
    CustomEditor "ShaderForgeMaterialInspector"
}
