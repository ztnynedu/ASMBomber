// Shader created with Shader Forge v1.38 
// Shader Forge (c) Neat Corporation / Joachim Holmer - http://www.acegikmo.com/shaderforge/
// Note: Manually altering this data may prevent you from opening it in Shader Forge
/*SF_DATA;ver:1.38;sub:START;pass:START;ps:flbk:,iptp:0,cusa:True,bamd:0,cgin:QwBHAEkAbgBjAGwAdQBkAGUAcwAvAFMAZQBhAG0AcwBCAGwAZQBuAGQAaQBuAGcAXwBBAG4AZwB1AGwAYQByAHwAQwBHAEkAbgBjAGwAdQBkAGUAcwAvAFcAbwByAGwAZABQAG8AcwBpAHQAaQBvAG4AQwBlAG4AdABlAHIAfABDAEcASQBuAGMAbAB1AGQAZQBzAC8AQQBuAGcAdQBsAGEAcgBDAG8AcgByAGUAYwB0AGkAbwBuAHwAQwBHAEkAbgBjAGwAdQBkAGUAcwAvAEQAaQB0AGgAZQByAGkAbgBnAA==,lico:0,lgpr:1,limd:0,spmd:1,trmd:0,grmd:0,uamb:True,mssp:True,bkdf:False,hqlp:False,rprd:False,enco:False,rmgx:True,imps:True,rpth:0,vtps:0,hqsc:True,nrmq:1,nrsp:0,vomd:0,spxs:False,tesm:0,olmd:1,culm:2,bsrc:0,bdst:1,dpts:2,wrdp:True,dith:0,atcv:False,rfrpo:False,rfrpn:Refraction,coma:15,ufog:True,aust:False,igpj:False,qofs:51,qpre:2,rntp:3,fgom:False,fgoc:False,fgod:False,fgor:False,fgmd:0,fgcr:0.5661765,fgcg:1,fgcb:0.6589251,fgca:1,fgde:0.0015,fgrn:0,fgrf:300,stcl:False,atwp:False,stva:128,stmr:255,stmw:255,stcp:6,stps:0,stfa:0,stfz:0,ofsf:0,ofsu:0,f2p0:False,fnsp:False,fnfb:True,fsmp:False;n:type:ShaderForge.SFN_Final,id:2865,x:35183,y:31103,varname:node_2865,prsc:2|custl-545-OUT,clip-8508-OUT;n:type:ShaderForge.SFN_Color,id:6665,x:30049,y:31284,ptovrint:False,ptlb:Color,ptin:_Color,varname:_Color,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,c1:0.5019608,c2:0.5019608,c3:0.5019608,c4:1;n:type:ShaderForge.SFN_Tex2d,id:7736,x:31174,y:31375,varname:node_3116_MAINPASS,prsc:2,ntxv:0,isnm:False|TEX-6298-TEX;n:type:ShaderForge.SFN_Slider,id:5916,x:29905,y:31591,ptovrint:False,ptlb:Cutoff,ptin:_Cutoff,varname:_Cutoff,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,min:0,cur:0.7,max:1;n:type:ShaderForge.SFN_Tex2dAsset,id:6298,x:30556,y:31580,ptovrint:False,ptlb:MainTex,ptin:_MainTex,varname:_MainTex,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,ntxv:0,isnm:False;n:type:ShaderForge.SFN_ViewVector,id:628,x:30709,y:30523,varname:node_628,prsc:2;n:type:ShaderForge.SFN_Dot,id:1391,x:30922,y:30614,cmnt:Check if view is opposite the direction of sunlight,varname:node_1391,prsc:2,dt:4|A-628-OUT,B-808-OUT;n:type:ShaderForge.SFN_Code,id:8508,x:34351,y:31497,cmnt:Shadow or Main Pass?,varname:node_8508,prsc:2,code:IwBpAGYAIABkAGUAZgBpAG4AZQBkACgAVQBOAEkAVABZAF8AUABBAFMAUwBfAFMASABBAEQATwBXAEMAQQBTAFQARQBSACkACgAJAHIAZQB0AHUAcgBuACAAUwBIAEEARABPAFcAXwBBAEwAUABIAEEAXwBDAEwASQBQADsACgAjAGUAbABzAGUACgAJAHIAZQB0AHUAcgBuACAATQBBAEkATgBfAEEATABQAEgAQQBfAEMATABJAFAAOwAKACMAZQBuAGQAaQBmAA==,output:0,fname:Check_If_Shadow_Pass2,width:340,height:128,input:0,input:0,input_1_label:SHADOW_ALPHA_CLIP,input_2_label:MAIN_ALPHA_CLIP|A-8572-OUT,B-7769-OUT;n:type:ShaderForge.SFN_Set,id:3191,x:31755,y:31461,varname:TexAlpha,prsc:2|IN-2653-OUT;n:type:ShaderForge.SFN_Set,id:7766,x:30246,y:31590,varname:Param_Cutoff,prsc:2|IN-5916-OUT;n:type:ShaderForge.SFN_Set,id:55,x:29081,y:32176,cmnt:Used to fade away billboards parallel to view,varname:Angular_Correction_MAINPASS,prsc:2|IN-6690-OUT;n:type:ShaderForge.SFN_Set,id:6838,x:29155,y:32465,varname:DITHER_MAINPASS,prsc:2|IN-4642-OUT;n:type:ShaderForge.SFN_Get,id:7769,x:34049,y:31520,varname:node_7769,prsc:2|IN-6838-OUT;n:type:ShaderForge.SFN_Set,id:4973,x:31406,y:31375,varname:MainTexIN,prsc:2|IN-7736-RGB;n:type:ShaderForge.SFN_ViewVector,id:5054,x:28201,y:32200,varname:node_5054,prsc:2;n:type:ShaderForge.SFN_ViewReflectionVector,id:9732,x:28201,y:32078,varname:node_9732,prsc:2;n:type:ShaderForge.SFN_Tex2d,id:4547,x:31130,y:31948,cmnt:Color and alpha from UV3 is used by the horizontal plane to draw the Line Z and part of the circle,varname:node_3117_MAINPASS,prsc:2,ntxv:0,isnm:False|UVIN-327-UVOUT,TEX-6298-TEX;n:type:ShaderForge.SFN_TexCoord,id:327,x:30709,y:31944,varname:node_327,prsc:2,uv:2,uaff:False;n:type:ShaderForge.SFN_Set,id:9204,x:31575,y:31958,varname:UV3ColorIN,prsc:2|IN-8721-OUT;n:type:ShaderForge.SFN_Tex2d,id:9956,x:31134,y:31772,cmnt:Color and alpha from UV4 is used by all three planes to draw all or parts of their circlecrosses,varname:node_3118_MAINPASS,prsc:2,ntxv:0,isnm:False|UVIN-3765-UVOUT,TEX-6298-TEX;n:type:ShaderForge.SFN_TexCoord,id:3765,x:30709,y:31771,varname:node_3765,prsc:2,uv:3,uaff:False;n:type:ShaderForge.SFN_Set,id:1759,x:31557,y:31773,varname:UV4ColorIN,prsc:2|IN-8493-OUT;n:type:ShaderForge.SFN_Set,id:6719,x:31305,y:30683,cmnt:Darkens the trees when viewed from the back side.,varname:Backside_Darkening_Amount,prsc:2|IN-1391-OUT;n:type:ShaderForge.SFN_Set,id:7375,x:30427,y:31282,varname:Param_Color,prsc:2|IN-2327-OUT;n:type:ShaderForge.SFN_Set,id:6116,x:29064,y:31789,varname:WorldPosCenter,prsc:2|IN-4328-OUT;n:type:ShaderForge.SFN_Code,id:9670,x:30318,y:31904,varname:node_9670,prsc:2,code:VABoAGUAIABjAG8AZABlACAAdABvACAAdABoAGUAIAByAGkAZwBoAHQAIABnAGUAdABzACAAdABoAGUAIABwAGkAeABlAGwACgBjAG8AbABvAHIAIABmAHIAbwBtACAAdABoAGUAIABVAFYAMwAgAGEAbgBkACAAVQBWADQALgAgAFQAaABlAHMAZQAgAFUAVgBzAAoAdwBlAHIAZQAgAGMAYQBsAGMAdQBsAGEAdABlAGQAIABlAHgAcAByAGUAcwBzAGwAeQAgAGIAeQAgAHQAaABlAAoATAB1AHMAaABMAE8ARABUAHIAZQBlAEMAbwBuAHYAZQByAHQAZQByAC4AYwBzACAAcwBjAHIAaQBwAHQAIAB3AGgAZQBuAAoAdABoAGUAIABiAGkAbABsAGIAbwBhAHIAZAAgAG0AZQBzAGgAIAB3AGEAcwAgAGMAcgBlAGEAdABlAGQALgAgAFQAaABlAHkACgBjAG8AbgB0AGEAaQBuACAAdABoAGkAbgAgAGwAaQBuAGUAcwAgACgAMQAgAHAAaQB4AGUAbAAgAHQAaABpAGMAawApAAoAYQBjAHIAbwBzAHMAIAB0AGgAZQAgAG0AZQBzAGgAIABwAGwAYQBuAGUAcwAgAGEAdAAgAHQAaABlACAAdgBhAHIAaQBvAHUAcwAKAGkAbgB0AGUAcgBzAGUAYwB0AGkAbwBuAHMALAAgAGEAbgBkACAAYQByAGUAIAB1AHMAZQBkACAAdABvACAAcABhAHMAcwAKAHQAaABlACAAYwBvAGwAbwByACAAbwBmACAAbwBuAGUAIABwAGwAYQBuAGUAIABvAHYAZQByACAAdABvACAAdABoAGUACgBvAHQAaABlAHIAIABwAGwAYQBuAGUALAAgAHMAbwAgAHQAaABhAHQAIABlAGEAYwBoACAAcABsAGEAbgBlACAAYwBhAG4ACgBiAGwAZQBuAGQAIAB3AGkAdABoACAAdABoAGUAIABvAHQAaABlAHIALgAKAAoAVABoAGUAIABIAG8AcgBpAHoAbwBuAHQAYQBsACAAcABsAGEAbgBlACAAaQBuAHQAZQByAHMAZQBjAHQAcwAgAGEAbgBkAAoAYgBsAGUAbgBkAHMAIAB3AGkAdABoACAAYgBvAHQAaAAgAHQAaABlACAARgBPAFIAVwBBAFIARAAgAGEAbgBkACAAUgBJAEcASABUAAoAcABsAGEAbgBlAHMALgAgAFQAaAB1AHMALAAgAGkAdAAgAGIAbABlAG4AZABzACAAdQBzAGkAbgBnACAAdAB3AG8AIABsAGkAbgBlAHMALAAgAAoAdwBpAHQAaAAgAG8AbgBlACAAbABpAG4AZQAgAGEAbABvAG4AZwAgAGUAYQBjAGgAIABvAGYAIAB0AGgAbwBzAGUACgBlAGQAZwBlAHMALgAgAFQAaABlACAAcABpAHgAZQBsAHMAIABmAG8AcgAgAHQAaABvAHMAZQAgAGwAaQBuAGUAcwAgAGEAcgBlAAoAcwBhAHYAZQBkACAAaQBuACAAVQBWADMAIABhAG4AZAAgAFUAVgA0ACAAcgBlAHMAcABlAGMAdABpAHYAZQBsAHkALgAKAAoARgBvAHIAIAB0AGgAZQAgAEYATwBSAFcAQQBSAEQAIABhAG4AZAAgAFIASQBHAEgAVAAgAHAAbABhAG4AZQBzACwAIAB0AGgAZQB5AAoAYgBsAGUAbgBkACAAbwBuAGwAeQAgAHcAaQB0AGgAIAB0AGgAZQAgAGgAbwByAGkAegBvAG4AdABhAGwAIABwAGwAYQBuAGUALAAKAGEAbgBkACAAdABoAHUAcwAgAHQAaABlAHkAIABvAG4AbAB5ACAAZAByAGEAdwAgAG8AbgBlACAAbABpAG4AZQAuACAAQQBuAGQACgBlAHYAZQBuACAAdABoAG8AdQBnAGgAIAB0AGgAbwBzAGUAIABsAGkAbgBlAHMAIABnAG8AIABkAGkAZgBmAGUAcgBlAG4AdAAKAGQAaQByAGUAYwB0AGkAbwBuAHMALAAgAEkAIAB3AGEAcwAgAGEAYgBsAGUAIAB0AG8AIABzAGEAdgBlACAAYQBsAGwACgB0AGgAYQB0ACAAZABhAHQAYQAgAGkAbgB0AG8AIABqAHUAcwB0ACAAVQBWADQAIABmAG8AcgAgAHQAaABlAGkAcgAgAHUAcwBlAC4A,output:2,fname:UV3_and_UV4,width:322,height:384;n:type:ShaderForge.SFN_Get,id:8572,x:34051,y:31464,varname:node_8572,prsc:2|IN-3191-OUT;n:type:ShaderForge.SFN_Set,id:5415,x:27539,y:30389,cmnt:A number identifying which plane this is,varname:PlaneNumber,prsc:2|IN-1192-OUT;n:type:ShaderForge.SFN_Code,id:7485,x:25909,y:30395,varname:node_7485,prsc:2,code:VABoAGUAIABjAG8AZABlACAAdABvACAAdABoAGUAIAByAGkAZwBoAHQAIABmAGkAZwB1AHIAZQBzACAAbwB1AHQACgB3AGgAaQBjAGgAIABwAGwAYQBuAGUAIAB0AGgAZQAgAHMAaABhAGQAZQByACAAaQBzACAAdwBvAHIAawBpAG4AZwAgAG8AbgAKAHIAaQBnAGgAdAAgAG4AbwB3AC4AIABUAG8AIABmAGkAZwB1AHIAZQAgAHQAaABpAHMAIABvAHUAdAAgAHcAaQB0AGgAbwB1AHQACgB0AG8AbwAgAG0AdQBjAGgAIABhAGQAbwAsACAAdwBlACAAcwBhAHYAZQBkACAAaQB0ACAAaQBuAHQAbwAgAHQAaABlAAoAdABlAHgAdAB1AHIAZQAnAHMAIABhAGwAcABoAGEAIABjAGgAYQBuAG4AZQBsAC4ACgAKADAALgAwADEAIABhAGwAcABoAGEAIABpAHMAIABhACAAdAByAGEAbgBzAHAAYQByAGUAbgB0ACAAcABpAHgAZQBsACAAbwBuACAARgBPAFIAVwBBAFIARAAgAHAAbABhAG4AZQAuAAoAMAAuADAAMgAgAGEAbABwAGgAYQAgAGkAcwAgAGEAIAB0AHIAYQBuAHMAcABhAHIAZQBuAHQAIABwAGkAeABlAGwAIABvAG4AIABSAEkARwBIAFQAIABwAGwAYQBuAGUALgAKADAALgAwADMAIABhAGwAcABoAGEAIABpAHMAIABhACAAdAByAGEAbgBzAHAAYQByAGUAbgB0ACAAcABpAHgAZQBsACAAbwBuACAAVABPAFAAIABwAGwAYQBuAGUALgAKADAALgA5ADgAIABpAHMAIABhAG4AIABvAHAAYQBxAHUAZQAgAHAAaQB4AGUAbAAgAG8AbgAgAEYATwBSAFcAQQBSAEQAIABwAGwAYQBuAGUALgAKADAALgA5ADkAIABpAHMAIABhAG4AIABvAHAAYQBxAHUAZQAgAHAAaQB4AGUAbAAgAG8AbgAgAFIASQBHAEgAVAAgAHAAbABhAG4AZQAuAAoAMQAuADAAMAAgAGkAcwAgAGEAbgAgAG8AcABhAHEAdQBlACAAcABpAHgAZQBsACAAbwBuACAAVABPAFAAIABwAGwAYQBuAGUALgA=,output:2,fname:PlaneNumberInfo,width:412,height:196;n:type:ShaderForge.SFN_If,id:8837,x:27170,y:30364,varname:node_8837,prsc:2|A-9388-OUT,B-4470-OUT,GT-6426-OUT,EQ-6237-OUT,LT-6237-OUT;n:type:ShaderForge.SFN_Get,id:9388,x:26374,y:30332,varname:node_9388,prsc:2|IN-3191-OUT;n:type:ShaderForge.SFN_Vector1,id:4470,x:26888,y:30316,varname:node_4470,prsc:2,v1:0.5;n:type:ShaderForge.SFN_Multiply,id:6237,x:26785,y:30642,varname:node_6237,prsc:2|A-9388-OUT,B-9006-OUT;n:type:ShaderForge.SFN_Vector1,id:9006,x:26594,y:30657,varname:node_9006,prsc:2,v1:100;n:type:ShaderForge.SFN_Subtract,id:1104,x:26678,y:30381,varname:node_1104,prsc:2|A-9388-OUT,B-2827-OUT;n:type:ShaderForge.SFN_Vector1,id:2827,x:26418,y:30427,varname:node_2827,prsc:2,v1:0.97;n:type:ShaderForge.SFN_Multiply,id:6426,x:26888,y:30392,varname:node_6426,prsc:2|A-1104-OUT,B-9006-OUT;n:type:ShaderForge.SFN_Round,id:1192,x:27347,y:30364,varname:node_1192,prsc:2|IN-8837-OUT;n:type:ShaderForge.SFN_Multiply,id:2327,x:30249,y:31282,cmnt:Inputting 0.5 will multiply by 1 which has no effect. Less than 0.5 will darken from 0 to 1 and above 0.5 will brighten by multiplying from 1 to 2x.,varname:node_2327,prsc:2|A-6665-RGB,B-4804-OUT;n:type:ShaderForge.SFN_Vector1,id:4804,x:30044,y:31185,varname:node_4804,prsc:2,v1:2;n:type:ShaderForge.SFN_RemapRange,id:8022,x:31099,y:30650,cmnt:Rescales it to 0.7 to 1 multiplied by 0.75 which yields 0.525 to 0.75,varname:node_8022,prsc:2,frmn:-1,frmx:1,tomn:0.525,tomx:0.75|IN-1391-OUT;n:type:ShaderForge.SFN_Set,id:8042,x:30346,y:30036,varname:LightIN,prsc:2|IN-7231-OUT;n:type:ShaderForge.SFN_Vector4Property,id:8259,x:29432,y:30386,ptovrint:False,ptlb:_LushLODTreeMainLightDir,ptin:_LushLODTreeMainLightDir,cmnt:The W is set via script in _LushLODTreesManager.cs,varname:node_8259,prsc:2,glob:True,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,v1:0.5,v2:0.5,v3:0.5,v4:1;n:type:ShaderForge.SFN_Color,id:349,x:29432,y:30090,ptovrint:False,ptlb:LushLODTreeMainLightCol,ptin:_LushLODTreeMainLightCol,cmnt:This works even with lightmaps,varname:node_349,prsc:2,glob:True,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,c1:0.5,c2:0.5,c3:0.5,c4:1;n:type:ShaderForge.SFN_ValueProperty,id:5384,x:29432,y:30271,ptovrint:False,ptlb:LushLODTreeMainLightIntensity,ptin:_LushLODTreeMainLightIntensity,cmnt:This works even with lightmaps,varname:node_5384,prsc:2,glob:True,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,v1:1;n:type:ShaderForge.SFN_Set,id:632,x:29757,y:30389,varname:LightDir,prsc:2|IN-8259-XYZ;n:type:ShaderForge.SFN_Get,id:808,x:30709,y:30660,varname:node_808,prsc:2|IN-632-OUT;n:type:ShaderForge.SFN_Dot,id:9701,x:30943,y:30351,cmnt:Is the sun above the horizon?,varname:node_9701,prsc:2,dt:0|A-4581-OUT,B-7958-OUT;n:type:ShaderForge.SFN_Get,id:7958,x:30710,y:30397,varname:node_7958,prsc:2|IN-632-OUT;n:type:ShaderForge.SFN_Vector3,id:4581,x:30710,y:30284,cmnt:Checks if the light is shining straight down,varname:node_4581,prsc:2,v1:0,v2:1,v3:0;n:type:ShaderForge.SFN_Clamp01,id:2618,x:31507,y:30355,varname:node_2618,prsc:2|IN-1927-OUT;n:type:ShaderForge.SFN_Clamp01,id:8285,x:31971,y:30199,varname:node_8285,prsc:2|IN-9950-OUT;n:type:ShaderForge.SFN_Set,id:6648,x:32532,y:30231,cmnt:This is an optional lighting adjustment you can remove this if your scene doesnt benefit from this.,varname:TimeOfDayIntensity,prsc:2|IN-6213-OUT;n:type:ShaderForge.SFN_Add,id:1927,x:31322,y:30355,cmnt:This makes the trees not get dark until the sun is somewhat BELOW the horizon.,varname:node_1927,prsc:2|A-9701-OUT,B-6107-OUT;n:type:ShaderForge.SFN_Vector1,id:6107,x:31134,y:30389,varname:node_6107,prsc:2,v1:0.25;n:type:ShaderForge.SFN_RemapRangeAdvanced,id:9950,x:31770,y:30199,cmnt:Rescales it from 01 to about 03 to make it get brigher faster as the sun comes up. This effect is significantly stronger on the sunny side via backside darkening.,varname:node_9950,prsc:2|IN-2618-OUT,IMIN-9124-OUT,IMAX-8029-OUT,OMIN-900-OUT,OMAX-4544-OUT;n:type:ShaderForge.SFN_Vector1,id:9124,x:31507,y:30050,varname:node_9124,prsc:2,v1:0;n:type:ShaderForge.SFN_Vector1,id:8029,x:31507,y:30099,varname:node_8029,prsc:2,v1:1;n:type:ShaderForge.SFN_Vector1,id:900,x:31507,y:30154,varname:node_900,prsc:2,v1:0;n:type:ShaderForge.SFN_Vector1,id:5461,x:31304,y:30110,varname:node_5461,prsc:2,v1:1.3;n:type:ShaderForge.SFN_Add,id:4544,x:31507,y:30204,varname:node_4544,prsc:2|A-5461-OUT,B-444-OUT;n:type:ShaderForge.SFN_Get,id:7109,x:31127,y:30112,varname:node_7109,prsc:2|IN-6719-OUT;n:type:ShaderForge.SFN_Multiply,id:444,x:31304,y:30176,varname:node_444,prsc:2|A-7109-OUT,B-946-OUT;n:type:ShaderForge.SFN_Vector1,id:946,x:31127,y:30195,varname:node_946,prsc:2,v1:2;n:type:ShaderForge.SFN_NormalVector,id:4081,x:30309,y:30825,prsc:2,pt:False;n:type:ShaderForge.SFN_Set,id:6230,x:30703,y:30925,varname:NormalIN,prsc:2|IN-2584-OUT;n:type:ShaderForge.SFN_FaceSign,id:667,x:30309,y:30971,varname:node_667,prsc:2,fstp:1;n:type:ShaderForge.SFN_Multiply,id:2584,x:30533,y:30908,cmnt:Stop it from reversing the normal when viewed from backface.,varname:node_2584,prsc:2|A-4081-OUT,B-667-VFACE;n:type:ShaderForge.SFN_Code,id:1680,x:28221,y:30410,varname:node_1680,prsc:2,code:LwAvACAAVABoAGkAcwAgAGYAdQBuAGMAdABpAG8AbgAgAGkAcwAgAG4AZQBjAGUAcwBhAHIAeQAgAGQAdQBlACAAdABvACAAdABoAGkAcwAgAGIAdQBnADoAIAAKAC8ALwAgAGgAdAB0AHAAcwA6AC8ALwBzAGgAYQBkAGUAcgBmAG8AcgBnAGUALgB1AHMAZQByAGUAYwBoAG8ALgBjAG8AbQAvAHQAbwBwAGkAYwBzAC8AMQAyADQAOAAtAHQAbwBvAC0AbQBhAG4AeQAtAG8AdQB0AHAAdQB0AC0AcgBlAGcAaQBzAHQAZQByAHMALQBkAGUAYwBsAGEAcgBlAGQALQAxADIALQBvAG4ALQBkADMAZAA5AC8ACgAvAC8AIABTAG8AIAB0AG8AIAByAGUAZAB1AGMAZQAgAG8AdQB0AHAAdQB0ACAAcgBlAGcAaQBzAHQAZQByAHMALAAgAHcAZQAgAGEAcgBlACAAbQBvAHYAaQBuAGcAIAB0AGgAZQAgAEIAaQBUAGEAbgBnAGUAbgB0ACAAYwBhAGwAYwB1AGwAdABpAG8AbgAgAHQAbwAgAGgAZQByAGUALgAKAC8ALwAgAFQAaABpAHMAIABpAHMAIABwAHIAbwBiAGEAYgBsAHkAIABsAGUAcwBzACAAZQBmAGYAaQBjAGkAZQBuAHQALAAgAGIAdQB0ACAAaQB0ACAAcwBhAHYAZQBzACAAbQBlACAAZgByAG8AbQAgAGgAYQB2AGkAbgBnACAAdABvACAAbQBhAG4AdQBhAGwAbAB5ACAAZQBkAGkAdAAgAHQAaABpAHMAIABzAGgAYQBkAGUAcgAuAAoACgAvAC8ARgBvAHIAdwBhAHIAZAAgAFAAbABhAG4AZQAgAEIAaQBUAGEAbgBnAGUAbgB0ACAAaQBzACAAbQB1AGwAdABpAHAAbABpAGUAZAAgAGIAeQAgAC0AMQAgACgAcwBlAGUAIABMAHUAcwBoAEwATwBEAFQAcgBlAGUAQwBvAG4AdgBlAHIAdABlAHIALgBjAHMAKQAKAHIAZQB0AHUAcgBuACAAUABOACAAPQA9ACAAMQAgAD8AIABuAG8AcgBtAGEAbABpAHoAZQAoAGMAcgBvAHMAcwAoAG4AbwByAG0AYQBsAEQAaQByACwAIAB0AGEAbgBnAGUAbgB0AEQAaQByACkAIAAqACAALQAxACkAIAA6AAoACQAgAG4AbwByAG0AYQBsAGkAegBlACgAYwByAG8AcwBzACgAbgBvAHIAbQBhAGwARABpAHIALAAgAHQAYQBuAGcAZQBuAHQARABpAHIAKQApADsA,output:2,fname:CalculateBiTangent,width:653,height:224,input:0,input:2,input:2,input_1_label:PN,input_2_label:normalDir,input_3_label:tangentDir|A-940-OUT,B-8616-OUT,C-8674-OUT;n:type:ShaderForge.SFN_Tangent,id:8674,x:27933,y:30486,varname:node_8674,prsc:2;n:type:ShaderForge.SFN_Get,id:8616,x:27933,y:30438,varname:node_8616,prsc:2|IN-6230-OUT;n:type:ShaderForge.SFN_Get,id:940,x:27933,y:30394,varname:node_940,prsc:2|IN-5415-OUT;n:type:ShaderForge.SFN_Set,id:9565,x:28941,y:30410,varname:BiTanDir,prsc:2|IN-1680-OUT;n:type:ShaderForge.SFN_Set,id:3492,x:29163,y:31076,varname:FinalColor_Corrected,prsc:2|IN-5880-OUT;n:type:ShaderForge.SFN_Code,id:5880,x:28684,y:31073,cmnt:Note GetSeamsBlending is in SeamsBlending.cginc,varname:node_5880,prsc:2,code:cgBlAHQAdQByAG4AIABHAGUAdABTAGUAYQBtAHMAQgBsAGUAbgBkAGkAbgBnAF8AQQBuAGcAdQBsAGEAcgAJAAoACQAoAAkACgAJAAkAQgBpAFQAYQBuAEQAaQByACwACgAJAAkATgBvAHIAbQBhAGwASQBOACwACgAJAAkAVwBvAHIAbABkAFAAbwBzAEMAZQBuAHQAZQByACwACgAJAAkAUABsAGEAbgBlAE4AdQBtAGIAZQByACwACgAJAAkARgBpAG4AYQBsAEMAbwBsAG8AcgBJAE4ALAAKAAkACQBVAFYAMwBDAG8AbABvAHIALAAKAAkACQBVAFYANABDAG8AbABvAHIALAAKAAkACQBXAG8AcgBsAGQAUABvAHMALAAKAAkACQBWAGkAZQB3AEQAaQByACwACgAJAAkAVABhAG4ARABpAHIACgAJACkALgByAGcAYgA7AA==,output:2,fname:GetSeamsBlending_Caller,width:376,height:248,input:2,input:2,input:2,input:0,input:2,input:3,input:3,input:2,input:2,input:2,input_1_label:BiTanDir,input_2_label:NormalIN,input_3_label:WorldPosCenter,input_4_label:PlaneNumber,input_5_label:FinalColorIN,input_6_label:UV3Color,input_7_label:UV4Color,input_8_label:WorldPos,input_9_label:ViewDir,input_10_label:TanDir|A-558-OUT,B-4981-OUT,C-5120-OUT,D-5387-OUT,E-3091-OUT,F-9635-OUT,G-1215-OUT,H-4589-XYZ,I-4765-OUT,J-8993-OUT;n:type:ShaderForge.SFN_Get,id:558,x:28210,y:30964,varname:node_558,prsc:2|IN-9565-OUT;n:type:ShaderForge.SFN_Get,id:4981,x:28210,y:31008,varname:node_4981,prsc:2|IN-6230-OUT;n:type:ShaderForge.SFN_Get,id:5120,x:28210,y:31051,varname:node_5120,prsc:2|IN-6116-OUT;n:type:ShaderForge.SFN_Get,id:5387,x:28210,y:31096,varname:node_5387,prsc:2|IN-5415-OUT;n:type:ShaderForge.SFN_Get,id:3091,x:28210,y:31141,varname:node_3091,prsc:2|IN-4973-OUT;n:type:ShaderForge.SFN_Get,id:9635,x:28210,y:31185,varname:node_9635,prsc:2|IN-9204-OUT;n:type:ShaderForge.SFN_Get,id:1215,x:28210,y:31228,varname:node_1215,prsc:2|IN-1759-OUT;n:type:ShaderForge.SFN_FragmentPosition,id:4589,x:28210,y:31278,varname:node_4589,prsc:2;n:type:ShaderForge.SFN_ViewVector,id:4765,x:28210,y:31398,varname:node_4765,prsc:2;n:type:ShaderForge.SFN_Tangent,id:8993,x:28210,y:31518,varname:node_8993,prsc:2;n:type:ShaderForge.SFN_Append,id:8493,x:31358,y:31773,varname:node_8493,prsc:2|A-9956-RGB,B-9956-A;n:type:ShaderForge.SFN_Append,id:8721,x:31368,y:31958,varname:node_8721,prsc:2|A-4547-RGB,B-4547-A;n:type:ShaderForge.SFN_Code,id:4328,x:28654,y:31794,cmnt:Note GetWorldPositionCenter is in GetWorldPosition.cginc,varname:node_4328,prsc:2,code:cgBlAHQAdQByAG4AIABHAGUAdABXAG8AcgBsAGQAUABvAHMAaQB0AGkAbwBuAEMAZQBuAHQAZQByAAoACQAoAAkACgAJAAkAQgBpAFQAYQBuAEQAaQByACwACgAJAAkAVwBvAHIAbABkAFAAbwBzACwACgAJAAkAVABhAG4ARABpAHIALAAKAAkACQBVAFYAMQAsAAoACQAJAFUAVgAwAAoACQApAC4AcgBnAGIAOwA=,output:2,fname:GetWorldPositionCenter_Caller,width:324,height:159,input:2,input:2,input:2,input:1,input:1,input_1_label:BiTanDir,input_2_label:WorldPos,input_3_label:TanDir,input_4_label:UV1,input_5_label:UV0|A-434-OUT,B-7656-XYZ,C-8928-OUT,D-7849-OUT,E-3356-OUT;n:type:ShaderForge.SFN_Get,id:434,x:28180,y:31685,varname:node_434,prsc:2|IN-9565-OUT;n:type:ShaderForge.SFN_Get,id:7849,x:28180,y:31982,varname:node_7849,prsc:2|IN-36-OUT;n:type:ShaderForge.SFN_Get,id:3356,x:28180,y:32025,varname:node_3356,prsc:2|IN-8071-OUT;n:type:ShaderForge.SFN_FragmentPosition,id:7656,x:28201,y:31738,varname:node_7656,prsc:2;n:type:ShaderForge.SFN_Tangent,id:8928,x:28201,y:31854,varname:node_8928,prsc:2;n:type:ShaderForge.SFN_TexCoord,id:9741,x:30709,y:32126,varname:node_9741,prsc:2,uv:1,uaff:False;n:type:ShaderForge.SFN_TexCoord,id:8148,x:30709,y:32274,varname:node_8148,prsc:2,uv:0,uaff:False;n:type:ShaderForge.SFN_Set,id:36,x:31130,y:32129,varname:UV1_IN,prsc:2|IN-9741-UVOUT;n:type:ShaderForge.SFN_Set,id:8071,x:31130,y:32276,varname:UV0_IN,prsc:2|IN-8148-UVOUT;n:type:ShaderForge.SFN_Code,id:6690,x:28655,y:32141,cmnt:Note GetAngularCorrection is in AngularCorrection.cginc,varname:node_6690,prsc:2,code:cgBlAHQAdQByAG4AIABHAGUAdABBAG4AZwB1AGwAYQByAEMAbwByAHIAZQBjAHQAaQBvAG4ACgAJACgACQAKAAkACQBWAGkAZQB3AFIAZQBmACwACgAJAAkAVgBpAGUAdwBEAGkAcgBlAGMACgAJACkAOwA=,output:0,fname:GetAngularCorrection_Caller,width:338,height:134,input:2,input:2,input_1_label:ViewRef,input_2_label:ViewDirec|A-9732-OUT,B-5054-OUT;n:type:ShaderForge.SFN_Code,id:4642,x:28506,y:32461,varname:node_4642,prsc:2,code:cgBlAHQAdQByAG4AIABHAGUAdABBAG4AZwB1AGwAYQByAE4AbwBUAHIAYQBuAHMAcABhAHIAZQBuAGMAeQBfAE0AQQBJAE4AUABBAFMAUwAoAFMAYwByAGUAZQBuAFAAbwBzACwAIABBAG4AZwB1AGwAYQByAEMAbwByAHIAZQBjAHQAaQBvAG4AKQA7AA==,output:0,fname:AngularNoTransparency_Caller,width:550,height:112,input:1,input:0,input_1_label:ScreenPos,input_2_label:AngularCorrection|A-202-UVOUT,B-4098-OUT;n:type:ShaderForge.SFN_Get,id:4098,x:28190,y:32557,varname:node_4098,prsc:2|IN-55-OUT;n:type:ShaderForge.SFN_ScreenPos,id:202,x:28211,y:32388,varname:node_202,prsc:2,sctp:0;n:type:ShaderForge.SFN_Code,id:2653,x:31406,y:31461,varname:node_2653,prsc:2,code:YwBsAGkAcAAoAFQAZQB4AEEAbABwAGgAYQAgAC0AIABDAHUAdABvAGYAZgApADsACgByAGUAdAB1AHIAbgAgAFQAZQB4AEEAbABwAGgAYQA7AA==,output:0,fname:ClipMe,width:247,height:112,input:0,input:0,input_1_label:TexAlpha,input_2_label:Cutoff|A-7736-A,B-2905-OUT;n:type:ShaderForge.SFN_Get,id:2905,x:31154,y:31521,varname:node_2905,prsc:2|IN-7766-OUT;n:type:ShaderForge.SFN_Get,id:1263,x:32354,y:30971,cmnt:The main texture color with some modifications for things like seams blending.,varname:node_1263,prsc:2|IN-3492-OUT;n:type:ShaderForge.SFN_Get,id:9019,x:32183,y:31267,cmnt:The color of the main diretional light,varname:node_9019,prsc:2|IN-8042-OUT;n:type:ShaderForge.SFN_Get,id:9639,x:32647,y:31816,cmnt:The shadows value,varname:node_9639,prsc:2|IN-6719-OUT;n:type:ShaderForge.SFN_Get,id:4303,x:34150,y:30981,varname:node_4303,prsc:2|IN-6648-OUT;n:type:ShaderForge.SFN_Add,id:9160,x:32500,y:31289,varname:node_9160,prsc:2|A-9019-OUT,B-7780-RGB;n:type:ShaderForge.SFN_Multiply,id:2096,x:32760,y:31232,cmnt:The final texture color with all lights but no shadows yet,varname:node_2096,prsc:2|A-1263-OUT,B-9160-OUT;n:type:ShaderForge.SFN_Lerp,id:6643,x:33365,y:31416,cmnt:The final color with the shadows and ambient tint applied to the shadows,varname:node_6643,prsc:2|A-425-OUT,B-2096-OUT,T-2764-OUT;n:type:ShaderForge.SFN_Multiply,id:425,x:32994,y:31603,varname:node_425,prsc:2|A-970-OUT,B-1011-OUT;n:type:ShaderForge.SFN_Blend,id:970,x:32782,y:31524,cmnt:The color of the shadow is based entirely off the texture color and the ambient light color,varname:node_970,prsc:2,blmd:1,clmp:False|SRC-7780-RGB,DST-1263-OUT;n:type:ShaderForge.SFN_Vector1,id:1011,x:32756,y:31699,varname:node_1011,prsc:2,v1:0.8;n:type:ShaderForge.SFN_Get,id:7776,x:32851,y:31015,varname:node_7776,prsc:2|IN-7375-OUT;n:type:ShaderForge.SFN_Max,id:8317,x:33365,y:31084,cmnt:Finds the highest input color value,varname:node_8317,prsc:2|A-3473-R,B-3473-G,C-3473-B;n:type:ShaderForge.SFN_Min,id:9028,x:33365,y:31242,cmnt:Finds how much LESS than WHITE the input color is,varname:node_9028,prsc:2|A-3473-R,B-3473-G,C-3473-B;n:type:ShaderForge.SFN_ComponentMask,id:3473,x:33066,y:31015,cmnt:The input color,varname:node_3473,prsc:2,cc1:0,cc2:1,cc3:2,cc4:-1|IN-7776-OUT;n:type:ShaderForge.SFN_Multiply,id:3282,x:33393,y:30775,cmnt:The input color multiplied by the texture color to give the input color a texture so that it doesnt look flat,varname:node_3282,prsc:2|A-1263-OUT,B-3473-OUT;n:type:ShaderForge.SFN_Multiply,id:9441,x:33723,y:31003,cmnt:Darkens the final color based on the input ccolor,varname:node_9441,prsc:2|A-6643-OUT,B-3473-OUT;n:type:ShaderForge.SFN_Lerp,id:289,x:33733,y:30801,cmnt:Lerps towards the input color based on how much the input color is LESS than WHITE,varname:node_289,prsc:2|A-3282-OUT,B-6643-OUT,T-9028-OUT;n:type:ShaderForge.SFN_Subtract,id:6904,x:33894,y:31149,cmnt:Finds the difference between the highest and lowest color value. This is used to detect if our iput color is simply a shade of grey and has no color,varname:node_6904,prsc:2|A-8317-OUT,B-9028-OUT;n:type:ShaderForge.SFN_Lerp,id:9760,x:34171,y:30850,varname:node_9760,prsc:2|A-9441-OUT,B-289-OUT,T-6904-OUT;n:type:ShaderForge.SFN_Multiply,id:545,x:34504,y:30890,varname:node_545,prsc:2|A-9760-OUT,B-4303-OUT;n:type:ShaderForge.SFN_Clamp,id:2764,x:32955,y:31818,cmnt:This lets the user adjust te maximum shadow. A value of 0.5 will limit it to half.,varname:node_2764,prsc:2|IN-9639-OUT,MIN-1071-OUT,MAX-4440-OUT;n:type:ShaderForge.SFN_Vector1,id:4440,x:32647,y:31912,varname:node_4440,prsc:2,v1:1;n:type:ShaderForge.SFN_ValueProperty,id:3479,x:32526,y:32023,ptovrint:False,ptlb:_LushLODTreeShadowDarkness,ptin:_LushLODTreeShadowDarkness,cmnt:_LusLODSadowDarkness... this is cotrolled by the manager in its Update function,varname:node_2612,prsc:2,glob:True,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,v1:1;n:type:ShaderForge.SFN_OneMinus,id:1071,x:32725,y:32023,varname:node_1071,prsc:2|IN-3479-OUT;n:type:ShaderForge.SFN_Lerp,id:6213,x:32290,y:30332,cmnt:Lets the user adjust the tie of day correction,varname:node_6213,prsc:2|A-1206-OUT,B-8285-OUT,T-6503-OUT;n:type:ShaderForge.SFN_ValueProperty,id:6503,x:32043,y:30404,ptovrint:False,ptlb:LushLODTreeTimeOfDay,ptin:_LushLODTreeTimeOfDay,varname:node_5174,prsc:2,glob:True,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,v1:1;n:type:ShaderForge.SFN_Vector1,id:1206,x:32043,y:30332,varname:node_1206,prsc:2,v1:1;n:type:ShaderForge.SFN_Multiply,id:7231,x:30080,y:30039,varname:node_7231,prsc:2|A-349-RGB,B-8673-OUT;n:type:ShaderForge.SFN_Divide,id:8673,x:29852,y:30127,varname:node_8673,prsc:2|A-5384-OUT,B-6153-OUT;n:type:ShaderForge.SFN_Vector1,id:6153,x:29600,y:30147,varname:node_6153,prsc:2,v1:1.2;n:type:ShaderForge.SFN_Color,id:7780,x:32274,y:31475,ptovrint:False,ptlb:_LushLODTreeAmbientColor,ptin:_LushLODTreeAmbientColor,cmnt:_LushLODTreeAmbientColor... this value is set in the manager,varname:_LushLODTreeAmbientColor_copy,prsc:2,glob:True,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,c1:0.5,c2:0.5,c3:0.5,c4:1;proporder:6665-6298-5916;pass:END;sub:END;*/

Shader "Hidden/LushLODTree/Tree_Leaves_Far2" {
    Properties {
        _Color ("Color", Color) = (0.5019608,0.5019608,0.5019608,1)
        _MainTex ("MainTex", 2D) = "white" {}
        _Cutoff ("Cutoff", Range(0, 1)) = 0.7
        [HideInInspector]_Cutoff ("Alpha cutoff", Range(0,1)) = 0.5
    }
    SubShader {
        Tags {
            "Queue"="AlphaTest+51"
            "RenderType"="TransparentCutout"
            "CanUseSpriteAtlas"="True"
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
			#ifndef UNITY_PASS_FORWARDBASE //<-- fixes really weird bug.
			#define UNITY_PASS_FORWARDBASE
			#endif
            #include "UnityCG.cginc"
            #include "CGIncludes/SeamsBlending_Angular.cginc"
            #include "CGIncludes/WorldPositionCenter.cginc"
            #include "CGIncludes/AngularCorrection.cginc"
            #include "CGIncludes/Dithering.cginc"
            #pragma multi_compile_fwdbase_fullshadows
            #pragma multi_compile_fog
            #pragma target 3.0
            uniform float4 _Color;
            uniform float _Cutoff;
            uniform sampler2D _MainTex; uniform float4 _MainTex_ST;
            float Check_If_Shadow_Pass2( float SHADOW_ALPHA_CLIP , float MAIN_ALPHA_CLIP ){
            #if defined(UNITY_PASS_SHADOWCASTER)
            	return SHADOW_ALPHA_CLIP;
            #else
            	return MAIN_ALPHA_CLIP;
            #endif
            }
            
            uniform float4 _LushLODTreeMainLightDir;
            uniform float4 _LushLODTreeMainLightCol;
            uniform float _LushLODTreeMainLightIntensity;
            float3 CalculateBiTangent( float PN , float3 normalDir , float3 tangentDir ){
            // This function is necesary due to this bug: 
            // https://shaderforge.userecho.com/topics/1248-too-many-output-registers-declared-12-on-d3d9/
            // So to reduce output registers, we are moving the BiTangent calcultion to here.
            // This is probably less efficient, but it saves me from having to manually edit this shader.
            
            //Forward Plane BiTangent is multiplied by -1 (see LushLODTreeConverter.cs)
            return PN == 1 ? normalize(cross(normalDir, tangentDir) * -1) :
            	 normalize(cross(normalDir, tangentDir));
            }
            
            float3 GetSeamsBlending_Caller( float3 BiTanDir , float3 NormalIN , float3 WorldPosCenter , float PlaneNumber , float3 FinalColorIN , float4 UV3Color , float4 UV4Color , float3 WorldPos , float3 ViewDir , float3 TanDir ){
            return GetSeamsBlending_Angular	
            	(	
            		BiTanDir,
            		NormalIN,
            		WorldPosCenter,
            		PlaneNumber,
            		FinalColorIN,
            		UV3Color,
            		UV4Color,
            		WorldPos,
            		ViewDir,
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
            
            float GetAngularCorrection_Caller( float3 ViewRef , float3 ViewDirec ){
            return GetAngularCorrection
            	(	
            		ViewRef,
            		ViewDirec
            	);
            }
            
            float AngularNoTransparency_Caller( float2 ScreenPos , float AngularCorrection ){
            return GetAngularNoTransparency_MAINPASS(ScreenPos, AngularCorrection);
            }
            
            float ClipMe( float TexAlpha , float Cutoff ){
            clip(TexAlpha - Cutoff);
            return TexAlpha;
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
                float3 viewReflectDirection = reflect( -viewDirection, normalDirection );
                float2 sceneUVs = (i.projPos.xy / i.projPos.w);
                float4 node_3116_MAINPASS = tex2D(_MainTex,TRANSFORM_TEX(i.uv0, _MainTex));
                float Param_Cutoff = _Cutoff;
                float TexAlpha = ClipMe( node_3116_MAINPASS.a , Param_Cutoff );
                float Angular_Correction_MAINPASS = GetAngularCorrection_Caller( viewReflectDirection , viewDirection ); // Used to fade away billboards parallel to view
                float DITHER_MAINPASS = AngularNoTransparency_Caller( (sceneUVs * 2 - 1).rg , Angular_Correction_MAINPASS );
                clip(Check_If_Shadow_Pass2( TexAlpha , DITHER_MAINPASS ) - 0.5);
////// Lighting:
                float node_9388 = TexAlpha;
                float node_8837_if_leA = step(node_9388,0.5);
                float node_8837_if_leB = step(0.5,node_9388);
                float node_9006 = 100.0;
                float node_6237 = (node_9388*node_9006);
                float PlaneNumber = round(lerp((node_8837_if_leA*node_6237)+(node_8837_if_leB*((node_9388-0.97)*node_9006)),node_6237,node_8837_if_leA*node_8837_if_leB)); // A number identifying which plane this is
                float3 NormalIN = (i.normalDir*faceSign);
                float3 BiTanDir = CalculateBiTangent( PlaneNumber , NormalIN , i.tangentDir );
                float2 UV1_IN = i.uv1;
                float2 UV0_IN = i.uv0;
                float3 WorldPosCenter = GetWorldPositionCenter_Caller( BiTanDir , i.posWorld.rgb , i.tangentDir , UV1_IN , UV0_IN );
                float3 MainTexIN = node_3116_MAINPASS.rgb;
                float4 node_3117_MAINPASS = tex2D(_MainTex,TRANSFORM_TEX(i.uv2, _MainTex)); // Color and alpha from UV3 is used by the horizontal plane to draw the Line Z and part of the circle
                float4 UV3ColorIN = float4(node_3117_MAINPASS.rgb,node_3117_MAINPASS.a);
                float4 node_3118_MAINPASS = tex2D(_MainTex,TRANSFORM_TEX(i.uv3, _MainTex)); // Color and alpha from UV4 is used by all three planes to draw all or parts of their circlecrosses
                float4 UV4ColorIN = float4(node_3118_MAINPASS.rgb,node_3118_MAINPASS.a);
                float3 FinalColor_Corrected = GetSeamsBlending_Caller( BiTanDir , NormalIN , WorldPosCenter , PlaneNumber , MainTexIN , UV3ColorIN , UV4ColorIN , i.posWorld.rgb , viewDirection , i.tangentDir );
                float3 node_1263 = FinalColor_Corrected; // The main texture color with some modifications for things like seams blending.
                float3 LightIN = (_LushLODTreeMainLightCol.rgb*(_LushLODTreeMainLightIntensity/1.2));
                float3 LightDir = _LushLODTreeMainLightDir.rgb;
                float node_1391 = 0.5*dot(viewDirection,LightDir)+0.5; // Check if view is opposite the direction of sunlight
                float Backside_Darkening_Amount = node_1391; // Darkens the trees when viewed from the back side.
                float3 node_6643 = lerp(((_LushLODTreeAmbientColor.rgb*node_1263)*0.8),(node_1263*(LightIN+_LushLODTreeAmbientColor.rgb)),clamp(Backside_Darkening_Amount,(1.0 - _LushLODTreeShadowDarkness),1.0)); // The final color with the shadows and ambient tint applied to the shadows
                float3 Param_Color = (_Color.rgb*2.0);
                float3 node_3473 = Param_Color.rgb; // The input color
                float node_9028 = min(min(node_3473.r,node_3473.g),node_3473.b); // Finds how much LESS than WHITE the input color is
                float node_9124 = 0.0;
                float node_900 = 0.0;
                float TimeOfDayIntensity = lerp(1.0,saturate((node_900 + ( (saturate((dot(float3(0,1,0),LightDir)+0.25)) - node_9124) * ((1.3+(Backside_Darkening_Amount*2.0)) - node_900) ) / (1.0 - node_9124))),_LushLODTreeTimeOfDay); // This is an optional lighting adjustment you can remove this if your scene doesnt benefit from this.
                float3 finalColor = (lerp((node_6643*node_3473),lerp((node_1263*node_3473),node_6643,node_9028),(max(max(node_3473.r,node_3473.g),node_3473.b)-node_9028))*TimeOfDayIntensity);
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
			#ifndef UNITY_PASS_SHADOWCASTER //<-- fixes really weird bug.
			#define UNITY_PASS_SHADOWCASTER
			#endif
            #include "UnityCG.cginc"
            #include "Lighting.cginc"
            #include "CGIncludes/SeamsBlending_Angular.cginc"
            #include "CGIncludes/WorldPositionCenter.cginc"
            #include "CGIncludes/AngularCorrection.cginc"
            #include "CGIncludes/Dithering.cginc"
            #pragma fragmentoption ARB_precision_hint_fastest
            #pragma multi_compile_shadowcaster
            #pragma multi_compile_fog
            #pragma target 3.0
            uniform float _Cutoff;
            uniform sampler2D _MainTex; uniform float4 _MainTex_ST;
            float Check_If_Shadow_Pass2( float SHADOW_ALPHA_CLIP , float MAIN_ALPHA_CLIP ){
            #if defined(UNITY_PASS_SHADOWCASTER)
            	return SHADOW_ALPHA_CLIP;
            #else
            	return MAIN_ALPHA_CLIP;
            #endif
            }
            
            float GetAngularCorrection_Caller( float3 ViewRef , float3 ViewDirec ){
            return GetAngularCorrection
            	(	
            		ViewRef,
            		ViewDirec
            	);
            }
            
            float AngularNoTransparency_Caller( float2 ScreenPos , float AngularCorrection ){
            return GetAngularNoTransparency_MAINPASS(ScreenPos, AngularCorrection);
            }
            
            float ClipMe( float TexAlpha , float Cutoff ){
            clip(TexAlpha - Cutoff);
            return TexAlpha;
            }
            
            struct VertexInput {
                float4 vertex : POSITION;
                float3 normal : NORMAL;
                float2 texcoord0 : TEXCOORD0;
            };
            struct VertexOutput {
                V2F_SHADOW_CASTER;
                float2 uv0 : TEXCOORD1;
                float4 posWorld : TEXCOORD2;
                float3 normalDir : TEXCOORD3;
                float4 projPos : TEXCOORD4;
            };
            VertexOutput vert (VertexInput v) {
                VertexOutput o = (VertexOutput)0;
                o.uv0 = v.texcoord0;
                o.normalDir = UnityObjectToWorldNormal(v.normal);
                o.posWorld = mul(unity_ObjectToWorld, v.vertex);
                o.pos = UnityObjectToClipPos( v.vertex );
                o.projPos = ComputeScreenPos (o.pos);
                COMPUTE_EYEDEPTH(o.projPos.z);
                TRANSFER_SHADOW_CASTER(o)
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
                float2 sceneUVs = (i.projPos.xy / i.projPos.w);
                float4 node_3116_MAINPASS = tex2D(_MainTex,TRANSFORM_TEX(i.uv0, _MainTex));
                float Param_Cutoff = _Cutoff;
                float TexAlpha = ClipMe( node_3116_MAINPASS.a , Param_Cutoff );
                float Angular_Correction_MAINPASS = GetAngularCorrection_Caller( viewReflectDirection , viewDirection ); // Used to fade away billboards parallel to view
                float DITHER_MAINPASS = AngularNoTransparency_Caller( (sceneUVs * 2 - 1).rg , Angular_Correction_MAINPASS );
                clip(Check_If_Shadow_Pass2( TexAlpha , DITHER_MAINPASS ) - 0.5);
                SHADOW_CASTER_FRAGMENT(i)
            }
            ENDCG
        }
    }
    CustomEditor "ShaderForgeMaterialInspector"
}
