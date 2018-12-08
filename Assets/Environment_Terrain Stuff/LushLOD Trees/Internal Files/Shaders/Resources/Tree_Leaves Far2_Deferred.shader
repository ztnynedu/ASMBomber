// Shader created with Shader Forge v1.38 
// Shader Forge (c) Neat Corporation / Joachim Holmer - http://www.acegikmo.com/shaderforge/
// Note: Manually altering this data may prevent you from opening it in Shader Forge
/*SF_DATA;ver:1.38;sub:START;pass:START;ps:flbk:,iptp:0,cusa:True,bamd:0,cgin:QwBHAEkAbgBjAGwAdQBkAGUAcwAvAFMAZQBhAG0AcwBCAGwAZQBuAGQAaQBuAGcAXwBOAG8AQQBuAGcAdQBsAGEAcgB8AEMARwBJAG4AYwBsAHUAZABlAHMALwBXAG8AcgBsAGQAUABvAHMAaQB0AGkAbwBuAEMAZQBuAHQAZQByAA==,lico:0,lgpr:1,limd:3,spmd:1,trmd:0,grmd:0,uamb:True,mssp:True,bkdf:False,hqlp:False,rprd:False,enco:False,rmgx:True,imps:True,rpth:1,vtps:0,hqsc:True,nrmq:1,nrsp:0,vomd:0,spxs:False,tesm:0,olmd:1,culm:2,bsrc:0,bdst:1,dpts:2,wrdp:True,dith:0,atcv:False,rfrpo:False,rfrpn:Refraction,coma:15,ufog:True,aust:True,igpj:False,qofs:0,qpre:2,rntp:3,fgom:False,fgoc:False,fgod:False,fgor:False,fgmd:0,fgcr:0.5661765,fgcg:1,fgcb:0.6589251,fgca:1,fgde:0.0015,fgrn:0,fgrf:300,stcl:False,atwp:False,stva:191,stmr:255,stmw:255,stcp:6,stps:2,stfa:0,stfz:0,ofsf:0,ofsu:0,f2p0:False,fnsp:False,fnfb:True,fsmp:False;n:type:ShaderForge.SFN_Final,id:2865,x:35102,y:30877,varname:node_2865,prsc:2|emission-5632-OUT,clip-8572-OUT;n:type:ShaderForge.SFN_Color,id:6665,x:30049,y:31284,ptovrint:False,ptlb:Color,ptin:_Color,varname:_Color,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,c1:0.5019608,c2:0.5019608,c3:0.5019608,c4:1;n:type:ShaderForge.SFN_Tex2d,id:7736,x:31177,y:31445,varname:node_3116_MAINPASS,prsc:2,ntxv:0,isnm:False|TEX-6298-TEX;n:type:ShaderForge.SFN_Slider,id:5916,x:29905,y:31591,ptovrint:False,ptlb:Cutoff,ptin:_Cutoff,varname:_Cutoff,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,min:0,cur:0.7,max:1;n:type:ShaderForge.SFN_Tex2dAsset,id:6298,x:30556,y:31580,ptovrint:False,ptlb:MainTex,ptin:_MainTex,varname:_MainTex,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,ntxv:0,isnm:False;n:type:ShaderForge.SFN_ViewVector,id:628,x:30709,y:30523,varname:node_628,prsc:2;n:type:ShaderForge.SFN_Dot,id:1391,x:30922,y:30614,cmnt:Check if view is opposite the direction of sunlight,varname:node_1391,prsc:2,dt:4|A-628-OUT,B-808-OUT;n:type:ShaderForge.SFN_Set,id:3191,x:31775,y:31534,varname:TexAlpha,prsc:2|IN-4384-OUT;n:type:ShaderForge.SFN_Set,id:7766,x:30246,y:31590,varname:Param_Cutoff,prsc:2|IN-5916-OUT;n:type:ShaderForge.SFN_Set,id:4973,x:31399,y:31445,varname:MainTexIN,prsc:2|IN-7736-RGB;n:type:ShaderForge.SFN_Tex2d,id:4547,x:31133,y:31933,cmnt:Color and alpha from UV3 is used by the horizontal plane to draw the Line Z and part of the circle,varname:node_3117_MAINPASS,prsc:2,ntxv:0,isnm:False|UVIN-327-UVOUT,TEX-6298-TEX;n:type:ShaderForge.SFN_TexCoord,id:327,x:30712,y:31942,varname:node_327,prsc:2,uv:2,uaff:False;n:type:ShaderForge.SFN_Set,id:9204,x:31584,y:31953,varname:UV3ColorIN,prsc:2|IN-5615-OUT;n:type:ShaderForge.SFN_Tex2d,id:9956,x:31136,y:31773,cmnt:Color and alpha from UV4 is used by all three planes to draw all or parts of their circlecrosses,varname:node_3118_MAINPASS,prsc:2,ntxv:0,isnm:False|UVIN-3765-UVOUT,TEX-6298-TEX;n:type:ShaderForge.SFN_TexCoord,id:3765,x:30714,y:31723,varname:node_3765,prsc:2,uv:3,uaff:False;n:type:ShaderForge.SFN_Set,id:1759,x:31565,y:31784,varname:UV4ColorIN,prsc:2|IN-4529-OUT;n:type:ShaderForge.SFN_Set,id:6719,x:31305,y:30683,cmnt:Darkens the trees when viewed from the back side.,varname:Backside_Darkening_Amount,prsc:2|IN-1391-OUT;n:type:ShaderForge.SFN_Set,id:7375,x:30427,y:31282,varname:Param_Color,prsc:2|IN-2327-OUT;n:type:ShaderForge.SFN_Set,id:4895,x:29234,y:31475,varname:FinalColor_Corrected,prsc:2|IN-446-OUT;n:type:ShaderForge.SFN_Set,id:6116,x:29247,y:32165,varname:WorldPosCenter,prsc:2|IN-1034-OUT;n:type:ShaderForge.SFN_Code,id:9670,x:30316,y:31891,varname:node_9670,prsc:2,code:VABoAGUAIABjAG8AZABlACAAdABvACAAdABoAGUAIAByAGkAZwBoAHQAIABnAGUAdABzACAAdABoAGUAIABwAGkAeABlAGwACgBjAG8AbABvAHIAIABmAHIAbwBtACAAdABoAGUAIABVAFYAMwAgAGEAbgBkACAAVQBWADQALgAgAFQAaABlAHMAZQAgAFUAVgBzAAoAdwBlAHIAZQAgAGMAYQBsAGMAdQBsAGEAdABlAGQAIABlAHgAcAByAGUAcwBzAGwAeQAgAGIAeQAgAHQAaABlAAoATAB1AHMAaABMAE8ARABUAHIAZQBlAEMAbwBuAHYAZQByAHQAZQByAC4AYwBzACAAcwBjAHIAaQBwAHQAIAB3AGgAZQBuAAoAdABoAGUAIABiAGkAbABsAGIAbwBhAHIAZAAgAG0AZQBzAGgAIAB3AGEAcwAgAGMAcgBlAGEAdABlAGQALgAgAFQAaABlAHkACgBjAG8AbgB0AGEAaQBuACAAdABoAGkAbgAgAGwAaQBuAGUAcwAgACgAMQAgAHAAaQB4AGUAbAAgAHQAaABpAGMAawApAAoAYQBjAHIAbwBzAHMAIAB0AGgAZQAgAG0AZQBzAGgAIABwAGwAYQBuAGUAcwAgAGEAdAAgAHQAaABlACAAdgBhAHIAaQBvAHUAcwAKAGkAbgB0AGUAcgBzAGUAYwB0AGkAbwBuAHMALAAgAGEAbgBkACAAYQByAGUAIAB1AHMAZQBkACAAdABvACAAcABhAHMAcwAKAHQAaABlACAAYwBvAGwAbwByACAAbwBmACAAbwBuAGUAIABwAGwAYQBuAGUAIABvAHYAZQByACAAdABvACAAdABoAGUACgBvAHQAaABlAHIAIABwAGwAYQBuAGUALAAgAHMAbwAgAHQAaABhAHQAIABlAGEAYwBoACAAcABsAGEAbgBlACAAYwBhAG4ACgBiAGwAZQBuAGQAIAB3AGkAdABoACAAdABoAGUAIABvAHQAaABlAHIALgAKAAoAVABoAGUAIABIAG8AcgBpAHoAbwBuAHQAYQBsACAAcABsAGEAbgBlACAAaQBuAHQAZQByAHMAZQBjAHQAcwAgAGEAbgBkAAoAYgBsAGUAbgBkAHMAIAB3AGkAdABoACAAYgBvAHQAaAAgAHQAaABlACAARgBPAFIAVwBBAFIARAAgAGEAbgBkACAAUgBJAEcASABUAAoAcABsAGEAbgBlAHMALgAgAFQAaAB1AHMALAAgAGkAdAAgAGIAbABlAG4AZABzACAAdQBzAGkAbgBnACAAdAB3AG8AIABsAGkAbgBlAHMALAAgAAoAdwBpAHQAaAAgAG8AbgBlACAAbABpAG4AZQAgAGEAbABvAG4AZwAgAGUAYQBjAGgAIABvAGYAIAB0AGgAbwBzAGUACgBlAGQAZwBlAHMALgAgAFQAaABlACAAcABpAHgAZQBsAHMAIABmAG8AcgAgAHQAaABvAHMAZQAgAGwAaQBuAGUAcwAgAGEAcgBlAAoAcwBhAHYAZQBkACAAaQBuACAAVQBWADMAIABhAG4AZAAgAFUAVgA0ACAAcgBlAHMAcABlAGMAdABpAHYAZQBsAHkALgAKAAoARgBvAHIAIAB0AGgAZQAgAEYATwBSAFcAQQBSAEQAIABhAG4AZAAgAFIASQBHAEgAVAAgAHAAbABhAG4AZQBzACwAIAB0AGgAZQB5AAoAYgBsAGUAbgBkACAAbwBuAGwAeQAgAHcAaQB0AGgAIAB0AGgAZQAgAGgAbwByAGkAegBvAG4AdABhAGwAIABwAGwAYQBuAGUALAAKAGEAbgBkACAAdABoAHUAcwAgAHQAaABlAHkAIABvAG4AbAB5ACAAZAByAGEAdwAgAG8AbgBlACAAbABpAG4AZQAuACAAQQBuAGQACgBlAHYAZQBuACAAdABoAG8AdQBnAGgAIAB0AGgAbwBzAGUAIABsAGkAbgBlAHMAIABnAG8AIABkAGkAZgBmAGUAcgBlAG4AdAAKAGQAaQByAGUAYwB0AGkAbwBuAHMALAAgAEkAIAB3AGEAcwAgAGEAYgBsAGUAIAB0AG8AIABzAGEAdgBlACAAYQBsAGwACgB0AGgAYQB0ACAAZABhAHQAYQAgAGkAbgB0AG8AIABqAHUAcwB0ACAAVQBWADQAIABmAG8AcgAgAHQAaABlAGkAcgAgAHUAcwBlAC4A,output:2,fname:UV3_and_UV4,width:322,height:384;n:type:ShaderForge.SFN_Get,id:8572,x:34670,y:31435,varname:node_8572,prsc:2|IN-3191-OUT;n:type:ShaderForge.SFN_Set,id:5415,x:28835,y:30701,cmnt:A number identifying which plane this is,varname:PlaneNumber,prsc:2|IN-1192-OUT;n:type:ShaderForge.SFN_Code,id:7485,x:27239,y:30724,varname:node_7485,prsc:2,code:VABoAGUAIABjAG8AZABlACAAdABvACAAdABoAGUAIAByAGkAZwBoAHQAIABmAGkAZwB1AHIAZQBzACAAbwB1AHQACgB3AGgAaQBjAGgAIABwAGwAYQBuAGUAIAB0AGgAZQAgAHMAaABhAGQAZQByACAAaQBzACAAdwBvAHIAawBpAG4AZwAgAG8AbgAKAHIAaQBnAGgAdAAgAG4AbwB3AC4AIABUAG8AIABmAGkAZwB1AHIAZQAgAHQAaABpAHMAIABvAHUAdAAgAHcAaQB0AGgAbwB1AHQACgB0AG8AbwAgAG0AdQBjAGgAIABhAGQAbwAsACAAdwBlACAAcwBhAHYAZQBkACAAaQB0ACAAaQBuAHQAbwAgAHQAaABlAAoAdABlAHgAdAB1AHIAZQAnAHMAIABhAGwAcABoAGEAIABjAGgAYQBuAG4AZQBsAC4ACgAKADAALgAwADEAIABhAGwAcABoAGEAIABpAHMAIABhACAAdAByAGEAbgBzAHAAYQByAGUAbgB0ACAAcABpAHgAZQBsACAAbwBuACAARgBPAFIAVwBBAFIARAAgAHAAbABhAG4AZQAuAAoAMAAuADAAMgAgAGEAbABwAGgAYQAgAGkAcwAgAGEAIAB0AHIAYQBuAHMAcABhAHIAZQBuAHQAIABwAGkAeABlAGwAIABvAG4AIABSAEkARwBIAFQAIABwAGwAYQBuAGUALgAKADAALgAwADMAIABhAGwAcABoAGEAIABpAHMAIABhACAAdAByAGEAbgBzAHAAYQByAGUAbgB0ACAAcABpAHgAZQBsACAAbwBuACAAVABPAFAAIABwAGwAYQBuAGUALgAKADAALgA5ADgAIABpAHMAIABhAG4AIABvAHAAYQBxAHUAZQAgAHAAaQB4AGUAbAAgAG8AbgAgAEYATwBSAFcAQQBSAEQAIABwAGwAYQBuAGUALgAKADAALgA5ADkAIABpAHMAIABhAG4AIABvAHAAYQBxAHUAZQAgAHAAaQB4AGUAbAAgAG8AbgAgAFIASQBHAEgAVAAgAHAAbABhAG4AZQAuAAoAMQAuADAAMAAgAGkAcwAgAGEAbgAgAG8AcABhAHEAdQBlACAAcABpAHgAZQBsACAAbwBuACAAVABPAFAAIABwAGwAYQBuAGUALgA=,output:2,fname:PlaneNumberInfo,width:412,height:196;n:type:ShaderForge.SFN_If,id:8837,x:28466,y:30676,varname:node_8837,prsc:2|A-9388-OUT,B-4470-OUT,GT-6426-OUT,EQ-6237-OUT,LT-6237-OUT;n:type:ShaderForge.SFN_Get,id:9388,x:27670,y:30644,varname:node_9388,prsc:2|IN-3191-OUT;n:type:ShaderForge.SFN_Vector1,id:4470,x:28184,y:30628,varname:node_4470,prsc:2,v1:0.5;n:type:ShaderForge.SFN_Multiply,id:6237,x:28081,y:30954,varname:node_6237,prsc:2|A-9388-OUT,B-9006-OUT;n:type:ShaderForge.SFN_Vector1,id:9006,x:27890,y:30969,varname:node_9006,prsc:2,v1:100;n:type:ShaderForge.SFN_Subtract,id:1104,x:27974,y:30693,varname:node_1104,prsc:2|A-9388-OUT,B-2827-OUT;n:type:ShaderForge.SFN_Vector1,id:2827,x:27714,y:30739,varname:node_2827,prsc:2,v1:0.97;n:type:ShaderForge.SFN_Multiply,id:6426,x:28184,y:30704,varname:node_6426,prsc:2|A-1104-OUT,B-9006-OUT;n:type:ShaderForge.SFN_Round,id:1192,x:28643,y:30676,varname:node_1192,prsc:2|IN-8837-OUT;n:type:ShaderForge.SFN_Multiply,id:2327,x:30249,y:31282,cmnt:Inputting 0.5 will multiply by 1 which has no effect. Less than 0.5 will darken from 0 to 1 and above 0.5 will brighten by multiplying from 1 to 2x.,varname:node_2327,prsc:2|A-6665-RGB,B-4804-OUT;n:type:ShaderForge.SFN_Vector1,id:4804,x:30044,y:31185,varname:node_4804,prsc:2,v1:2;n:type:ShaderForge.SFN_RemapRange,id:8022,x:31099,y:30650,cmnt:Rescales it to 0.7 to 1 multiplied by 0.75 which yields 0.525 to 0.75,varname:node_8022,prsc:2,frmn:-1,frmx:1,tomn:0.525,tomx:0.75|IN-1391-OUT;n:type:ShaderForge.SFN_Set,id:8042,x:30564,y:30061,varname:LightIN,prsc:2|IN-6812-OUT;n:type:ShaderForge.SFN_Vector4Property,id:8259,x:29432,y:30386,ptovrint:False,ptlb:_LushLODTreeMainLightDir,ptin:_LushLODTreeMainLightDir,cmnt:The W is set via script in _LushLODTreesManager.cs,varname:node_8259,prsc:2,glob:True,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,v1:0.5,v2:0.5,v3:0.5,v4:1;n:type:ShaderForge.SFN_Color,id:349,x:29432,y:30090,ptovrint:False,ptlb:LushLODTreeMainLightCol,ptin:_LushLODTreeMainLightCol,cmnt:This works even with lightmaps,varname:node_349,prsc:2,glob:True,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,c1:0.5,c2:0.5,c3:0.5,c4:1;n:type:ShaderForge.SFN_ValueProperty,id:5384,x:29432,y:30271,ptovrint:False,ptlb:LushLODTreeMainLightIntensity,ptin:_LushLODTreeMainLightIntensity,cmnt:This works even with lightmaps,varname:node_5384,prsc:2,glob:True,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,v1:1;n:type:ShaderForge.SFN_Set,id:632,x:29742,y:30401,varname:LightDir,prsc:2|IN-8259-XYZ;n:type:ShaderForge.SFN_Get,id:808,x:30709,y:30660,varname:node_808,prsc:2|IN-632-OUT;n:type:ShaderForge.SFN_Dot,id:9701,x:30943,y:30351,cmnt:Is the sun above the horizon?,varname:node_9701,prsc:2,dt:0|A-4581-OUT,B-7958-OUT;n:type:ShaderForge.SFN_Get,id:7958,x:30710,y:30397,varname:node_7958,prsc:2|IN-632-OUT;n:type:ShaderForge.SFN_Vector3,id:4581,x:30710,y:30284,cmnt:Checks if the light is shining straight down,varname:node_4581,prsc:2,v1:0,v2:1,v3:0;n:type:ShaderForge.SFN_Clamp01,id:2618,x:31507,y:30355,varname:node_2618,prsc:2|IN-1927-OUT;n:type:ShaderForge.SFN_Clamp01,id:8285,x:31971,y:30199,varname:node_8285,prsc:2|IN-9950-OUT;n:type:ShaderForge.SFN_Set,id:6648,x:32551,y:30245,cmnt:This is an optional lighting adjustment you can remove this if your scene doesnt benefit from this.,varname:TimeOfDayIntensity,prsc:2|IN-1749-OUT;n:type:ShaderForge.SFN_Add,id:1927,x:31322,y:30355,cmnt:This makes the trees not get dark until the sun is somewhat BELOW the horizon.,varname:node_1927,prsc:2|A-9701-OUT,B-6107-OUT;n:type:ShaderForge.SFN_Vector1,id:6107,x:31134,y:30389,varname:node_6107,prsc:2,v1:0.25;n:type:ShaderForge.SFN_RemapRangeAdvanced,id:9950,x:31770,y:30199,cmnt:Rescales it from 01 to about 03 to make it get brigher faster as the sun comes up. This effect is significantly stronger on the sunny side via backside darkening.,varname:node_9950,prsc:2|IN-2618-OUT,IMIN-9124-OUT,IMAX-8029-OUT,OMIN-900-OUT,OMAX-4544-OUT;n:type:ShaderForge.SFN_Vector1,id:9124,x:31507,y:30050,varname:node_9124,prsc:2,v1:0;n:type:ShaderForge.SFN_Vector1,id:8029,x:31507,y:30099,varname:node_8029,prsc:2,v1:1;n:type:ShaderForge.SFN_Vector1,id:900,x:31507,y:30154,varname:node_900,prsc:2,v1:0;n:type:ShaderForge.SFN_Vector1,id:5461,x:31304,y:30110,varname:node_5461,prsc:2,v1:1.3;n:type:ShaderForge.SFN_Add,id:4544,x:31507,y:30204,varname:node_4544,prsc:2|A-5461-OUT,B-444-OUT;n:type:ShaderForge.SFN_Get,id:7109,x:31127,y:30112,varname:node_7109,prsc:2|IN-6719-OUT;n:type:ShaderForge.SFN_Multiply,id:444,x:31304,y:30176,varname:node_444,prsc:2|A-7109-OUT,B-946-OUT;n:type:ShaderForge.SFN_Vector1,id:946,x:31127,y:30195,varname:node_946,prsc:2,v1:2;n:type:ShaderForge.SFN_NormalVector,id:4081,x:30309,y:30825,prsc:2,pt:False;n:type:ShaderForge.SFN_Set,id:6230,x:30725,y:30944,varname:NormalIN,prsc:2|IN-2584-OUT;n:type:ShaderForge.SFN_FaceSign,id:667,x:30309,y:30971,varname:node_667,prsc:2,fstp:1;n:type:ShaderForge.SFN_Multiply,id:2584,x:30513,y:30882,cmnt:Stop it from reversing the normal when viewed from backface.,varname:node_2584,prsc:2|A-4081-OUT,B-667-VFACE;n:type:ShaderForge.SFN_Code,id:446,x:28722,y:31457,cmnt:Note GetSeamsBlending is in SeamsBlending.cginc,varname:node_446,prsc:2,code:cgBlAHQAdQByAG4AIABHAGUAdABTAGUAYQBtAHMAQgBsAGUAbgBkAGkAbgBnAF8ATgBvAEEAbgBnAHUAbABhAHIACQAKAAkAKAAJAAoACQAJAEIAaQBUAGEAbgBEAGkAcgAsAAoACQAJAE4AbwByAG0AYQBsAEkATgAsAAoACQAJAFcAbwByAGwAZABQAG8AcwBDAGUAbgB0AGUAcgAsAAoACQAJAFAAbABhAG4AZQBOAHUAbQBiAGUAcgAsAAoACQAJAEYAaQBuAGEAbABDAG8AbABvAHIASQBOACwACgAJAAkAVQBWADMAQwBvAGwAbwByACwACgAJAAkAVQBWADQAQwBvAGwAbwByACwACgAJAAkAVwBvAHIAbABkAFAAbwBzACwACgAJAAkAVABhAG4ARABpAHIACgAJACkALgByAGcAYgA7AA==,output:2,fname:GetSeamsBlending_Caller,width:387,height:232,input:2,input:2,input:2,input:0,input:2,input:3,input:3,input:2,input:2,input_1_label:BiTanDir,input_2_label:NormalIN,input_3_label:WorldPosCenter,input_4_label:PlaneNumber,input_5_label:FinalColorIN,input_6_label:UV3Color,input_7_label:UV4Color,input_8_label:WorldPos,input_9_label:TanDir|A-7169-OUT,B-2574-OUT,C-6739-OUT,D-4143-OUT,E-8844-OUT,F-8694-OUT,G-1478-OUT,H-5774-XYZ,I-4417-OUT;n:type:ShaderForge.SFN_Get,id:2574,x:28266,y:31408,varname:node_2574,prsc:2|IN-6230-OUT;n:type:ShaderForge.SFN_Get,id:6739,x:28266,y:31451,varname:node_6739,prsc:2|IN-6116-OUT;n:type:ShaderForge.SFN_Get,id:4143,x:28266,y:31496,varname:node_4143,prsc:2|IN-5415-OUT;n:type:ShaderForge.SFN_Get,id:8844,x:28266,y:31541,varname:node_8844,prsc:2|IN-4973-OUT;n:type:ShaderForge.SFN_Get,id:8694,x:28266,y:31585,varname:node_8694,prsc:2|IN-9204-OUT;n:type:ShaderForge.SFN_Get,id:1478,x:28266,y:31628,varname:node_1478,prsc:2|IN-1759-OUT;n:type:ShaderForge.SFN_FragmentPosition,id:5774,x:28266,y:31678,varname:node_5774,prsc:2;n:type:ShaderForge.SFN_Tangent,id:4417,x:28266,y:31794,varname:node_4417,prsc:2;n:type:ShaderForge.SFN_Bitangent,id:7169,x:28254,y:31292,varname:node_7169,prsc:2;n:type:ShaderForge.SFN_Append,id:5615,x:31346,y:31933,varname:node_5615,prsc:2|A-4547-RGB,B-4547-A;n:type:ShaderForge.SFN_Append,id:4529,x:31346,y:31773,varname:node_4529,prsc:2|A-9956-RGB,B-9956-A;n:type:ShaderForge.SFN_Code,id:1034,x:28714,y:32115,cmnt:Note GetWorldPositionCenter is in GetWorldPosition.cginc,varname:node_1034,prsc:2,code:cgBlAHQAdQByAG4AIABHAGUAdABXAG8AcgBsAGQAUABvAHMAaQB0AGkAbwBuAEMAZQBuAHQAZQByAAoACQAoAAkACgAJAAkAQgBpAFQAYQBuAEQAaQByACwACgAJAAkAVwBvAHIAbABkAFAAbwBzACwACgAJAAkAVABhAG4ARABpAHIALAAKAAkACQBVAFYAMQAsAAoACQAJAFUAVgAwAAoACQApAC4AcgBnAGIAOwA=,output:2,fname:GetWorldPositionCenter_Caller,width:406,height:248,input:2,input:2,input:2,input:1,input:1,input_1_label:BiTanDir,input_2_label:WorldPos,input_3_label:TanDir,input_4_label:UV1,input_5_label:UV0|A-9310-OUT,B-9513-XYZ,C-1045-OUT,D-5332-OUT,E-3385-OUT;n:type:ShaderForge.SFN_Get,id:5332,x:28262,y:32352,varname:node_5332,prsc:2|IN-5923-OUT;n:type:ShaderForge.SFN_Get,id:3385,x:28262,y:32395,varname:node_3385,prsc:2|IN-6300-OUT;n:type:ShaderForge.SFN_FragmentPosition,id:9513,x:28283,y:32108,varname:node_9513,prsc:2;n:type:ShaderForge.SFN_Tangent,id:1045,x:28283,y:32224,varname:node_1045,prsc:2;n:type:ShaderForge.SFN_TexCoord,id:5217,x:30722,y:32276,varname:node_5217,prsc:2,uv:0,uaff:False;n:type:ShaderForge.SFN_TexCoord,id:3555,x:30722,y:32128,varname:node_3555,prsc:2,uv:1,uaff:False;n:type:ShaderForge.SFN_Set,id:6300,x:31143,y:32278,varname:UV0_IN,prsc:2|IN-5217-UVOUT;n:type:ShaderForge.SFN_Set,id:5923,x:31143,y:32131,varname:UV1_IN,prsc:2|IN-3555-UVOUT;n:type:ShaderForge.SFN_Bitangent,id:9310,x:28283,y:31985,varname:node_9310,prsc:2;n:type:ShaderForge.SFN_Code,id:4384,x:31438,y:31534,varname:node_4384,prsc:2,code:YwBsAGkAcAAoAFQAZQB4AEEAbABwAGgAYQAgAC0AIABDAHUAdABvAGYAZgApADsACgByAGUAdAB1AHIAbgAgAFQAZQB4AEEAbABwAGgAYQA7AA==,output:0,fname:ClipMe,width:247,height:112,input:0,input:0,input_1_label:TexAlpha,input_2_label:Cutoff|A-7736-A,B-6655-OUT;n:type:ShaderForge.SFN_Get,id:6655,x:31186,y:31594,varname:node_6655,prsc:2|IN-7766-OUT;n:type:ShaderForge.SFN_Multiply,id:6812,x:30328,y:30061,varname:node_6812,prsc:2|A-349-RGB,B-3320-OUT;n:type:ShaderForge.SFN_Get,id:5686,x:32226,y:30952,cmnt:The main texture color with some modifications for things like seams blending.,varname:node_5686,prsc:2|IN-4895-OUT;n:type:ShaderForge.SFN_Get,id:5070,x:32055,y:31248,cmnt:The color of the main diretional light,varname:node_5070,prsc:2|IN-8042-OUT;n:type:ShaderForge.SFN_Get,id:9719,x:32519,y:31797,cmnt:The shadows value,varname:node_9719,prsc:2|IN-6719-OUT;n:type:ShaderForge.SFN_Get,id:5344,x:34022,y:30962,varname:node_5344,prsc:2|IN-6648-OUT;n:type:ShaderForge.SFN_Add,id:6842,x:32372,y:31270,varname:node_6842,prsc:2|A-5070-OUT,B-1950-RGB;n:type:ShaderForge.SFN_Multiply,id:5200,x:32632,y:31213,cmnt:The final texture color with all lights but no shadows yet,varname:node_5200,prsc:2|A-5686-OUT,B-6842-OUT;n:type:ShaderForge.SFN_Lerp,id:6001,x:33237,y:31397,cmnt:The final color with the shadows and ambient tint applied to the shadows,varname:node_6001,prsc:2|A-1088-OUT,B-5200-OUT,T-7118-OUT;n:type:ShaderForge.SFN_Multiply,id:1088,x:32866,y:31584,varname:node_1088,prsc:2|A-479-OUT,B-508-OUT;n:type:ShaderForge.SFN_Blend,id:479,x:32654,y:31505,cmnt:The color of the shadow is based entirely off the texture color and the ambient light color,varname:node_479,prsc:2,blmd:1,clmp:False|SRC-1950-RGB,DST-5686-OUT;n:type:ShaderForge.SFN_Vector1,id:508,x:32628,y:31680,varname:node_508,prsc:2,v1:0.8;n:type:ShaderForge.SFN_Get,id:8597,x:32723,y:30996,varname:node_8597,prsc:2|IN-7375-OUT;n:type:ShaderForge.SFN_Max,id:9921,x:33237,y:31065,cmnt:Finds the highest input color value,varname:node_9921,prsc:2|A-9076-R,B-9076-G,C-9076-B;n:type:ShaderForge.SFN_Min,id:9794,x:33237,y:31223,cmnt:Finds how much LESS than WHITE the input color is,varname:node_9794,prsc:2|A-9076-R,B-9076-G,C-9076-B;n:type:ShaderForge.SFN_ComponentMask,id:9076,x:32938,y:30996,cmnt:The input color,varname:node_9076,prsc:2,cc1:0,cc2:1,cc3:2,cc4:-1|IN-8597-OUT;n:type:ShaderForge.SFN_Multiply,id:1840,x:33265,y:30756,cmnt:The input color multiplied by the texture color to give the input color a texture so that it doesnt look flat,varname:node_1840,prsc:2|A-5686-OUT,B-9076-OUT;n:type:ShaderForge.SFN_Multiply,id:2748,x:33595,y:30984,cmnt:Darkens the final color based on the input ccolor,varname:node_2748,prsc:2|A-6001-OUT,B-9076-OUT;n:type:ShaderForge.SFN_Lerp,id:8967,x:33605,y:30782,cmnt:Lerps towards the input color based on how much the input color is LESS than WHITE,varname:node_8967,prsc:2|A-1840-OUT,B-6001-OUT,T-9794-OUT;n:type:ShaderForge.SFN_Subtract,id:9972,x:33766,y:31130,cmnt:Finds the difference between the highest and lowest color value. This is used to detect if our iput color is simply a shade of grey and has no color,varname:node_9972,prsc:2|A-9921-OUT,B-9794-OUT;n:type:ShaderForge.SFN_Lerp,id:3734,x:34043,y:30831,varname:node_3734,prsc:2|A-2748-OUT,B-8967-OUT,T-9972-OUT;n:type:ShaderForge.SFN_Multiply,id:5632,x:34376,y:30871,varname:node_5632,prsc:2|A-3734-OUT,B-5344-OUT;n:type:ShaderForge.SFN_Clamp,id:7118,x:32827,y:31799,cmnt:This lets the user adjust te maximum shadow. A value of 0.5 will limit it to half.,varname:node_7118,prsc:2|IN-9719-OUT,MIN-2817-OUT,MAX-3744-OUT;n:type:ShaderForge.SFN_Vector1,id:3744,x:32519,y:31893,varname:node_3744,prsc:2,v1:1;n:type:ShaderForge.SFN_ValueProperty,id:7586,x:32398,y:32004,ptovrint:False,ptlb:_LushLODTreeShadowDarkness,ptin:_LushLODTreeShadowDarkness,cmnt:_LusLODSadowDarkness... this is cotrolled by the manager in its Update function,varname:node_2612,prsc:2,glob:True,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,v1:1;n:type:ShaderForge.SFN_OneMinus,id:2817,x:32597,y:32004,varname:node_2817,prsc:2|IN-7586-OUT;n:type:ShaderForge.SFN_Lerp,id:1749,x:32325,y:30345,cmnt:Lets the user adjust the tie of day correction,varname:node_1749,prsc:2|A-6493-OUT,B-8285-OUT,T-4754-OUT;n:type:ShaderForge.SFN_Vector1,id:6493,x:32076,y:30345,varname:node_6493,prsc:2,v1:1;n:type:ShaderForge.SFN_ValueProperty,id:4754,x:32076,y:30417,ptovrint:False,ptlb:LushLODTreeTimeOfDay,ptin:_LushLODTreeTimeOfDay,varname:node_5174,prsc:2,glob:True,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,v1:1;n:type:ShaderForge.SFN_Divide,id:3320,x:29987,y:30151,varname:node_3320,prsc:2|A-5384-OUT,B-3061-OUT;n:type:ShaderForge.SFN_Vector1,id:3061,x:29668,y:30150,varname:node_3061,prsc:2,v1:1.2;n:type:ShaderForge.SFN_Color,id:1950,x:32075,y:31461,ptovrint:False,ptlb:_LushLODTreeAmbientColor,ptin:_LushLODTreeAmbientColor,cmnt:_LushLODTreeAmbientColor... this value is set in the manager,varname:_LushLODTreeAmbientColor_copy,prsc:2,glob:True,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,c1:0.5,c2:0.5,c3:0.5,c4:1;proporder:6665-6298-5916;pass:END;sub:END;*/

Shader "Hidden/LushLODTree/Tree_Leaves_Far2_Deferred" {
    Properties {
        _Color ("Color", Color) = (0.5019608,0.5019608,0.5019608,1)
        _MainTex ("MainTex", 2D) = "white" {}
        _Cutoff ("Cutoff", Range(0, 1)) = 0.7
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
            #pragma fragmentoption ARB_precision_hint_fastest
            #pragma multi_compile_shadowcaster
            #pragma multi_compile ___ UNITY_HDR_ON
            #pragma multi_compile_fog
            #pragma target 3.0
            uniform float4 _Color;
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
                clip(TexAlpha - 0.5);
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
                float3 node_5686 = FinalColor_Corrected; // The main texture color with some modifications for things like seams blending.
                float3 LightIN = (_LushLODTreeMainLightCol.rgb*(_LushLODTreeMainLightIntensity/1.2));
                float3 LightDir = _LushLODTreeMainLightDir.rgb;
                float node_1391 = 0.5*dot(viewDirection,LightDir)+0.5; // Check if view is opposite the direction of sunlight
                float Backside_Darkening_Amount = node_1391; // Darkens the trees when viewed from the back side.
                float3 node_6001 = lerp(((_LushLODTreeAmbientColor.rgb*node_5686)*0.8),(node_5686*(LightIN+_LushLODTreeAmbientColor.rgb)),clamp(Backside_Darkening_Amount,(1.0 - _LushLODTreeShadowDarkness),1.0)); // The final color with the shadows and ambient tint applied to the shadows
                float3 Param_Color = (_Color.rgb*2.0);
                float3 node_9076 = Param_Color.rgb; // The input color
                float node_9794 = min(min(node_9076.r,node_9076.g),node_9076.b); // Finds how much LESS than WHITE the input color is
                float node_9124 = 0.0;
                float node_900 = 0.0;
                float TimeOfDayIntensity = lerp(1.0,saturate((node_900 + ( (saturate((dot(float3(0,1,0),LightDir)+0.25)) - node_9124) * ((1.3+(Backside_Darkening_Amount*2.0)) - node_900) ) / (1.0 - node_9124))),_LushLODTreeTimeOfDay); // This is an optional lighting adjustment you can remove this if your scene doesnt benefit from this.
                float3 emissive = (lerp((node_6001*node_9076),lerp((node_5686*node_9076),node_6001,node_9794),(max(max(node_9076.r,node_9076.g),node_9076.b)-node_9794))*TimeOfDayIntensity);
                float3 finalColor = emissive;
                outDiffuse = half4( 0, 0, 0, 1 );
                outSpecSmoothness = half4(0,0,0,0);
                outNormal = half4( normalDirection * 0.5 + 0.5, 1 );
                outEmission = half4( (lerp((node_6001*node_9076),lerp((node_5686*node_9076),node_6001,node_9794),(max(max(node_9076.r,node_9076.g),node_9076.b)-node_9794))*TimeOfDayIntensity), 1 );
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
            #pragma multi_compile_fwdbase_fullshadows
            #pragma multi_compile_fog
            #pragma target 3.0
            uniform float4 _Color;
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
                clip(TexAlpha - 0.5);
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
                float3 node_5686 = FinalColor_Corrected; // The main texture color with some modifications for things like seams blending.
                float3 LightIN = (_LushLODTreeMainLightCol.rgb*(_LushLODTreeMainLightIntensity/1.2));
                float3 LightDir = _LushLODTreeMainLightDir.rgb;
                float node_1391 = 0.5*dot(viewDirection,LightDir)+0.5; // Check if view is opposite the direction of sunlight
                float Backside_Darkening_Amount = node_1391; // Darkens the trees when viewed from the back side.
                float3 node_6001 = lerp(((_LushLODTreeAmbientColor.rgb*node_5686)*0.8),(node_5686*(LightIN+_LushLODTreeAmbientColor.rgb)),clamp(Backside_Darkening_Amount,(1.0 - _LushLODTreeShadowDarkness),1.0)); // The final color with the shadows and ambient tint applied to the shadows
                float3 Param_Color = (_Color.rgb*2.0);
                float3 node_9076 = Param_Color.rgb; // The input color
                float node_9794 = min(min(node_9076.r,node_9076.g),node_9076.b); // Finds how much LESS than WHITE the input color is
                float node_9124 = 0.0;
                float node_900 = 0.0;
                float TimeOfDayIntensity = lerp(1.0,saturate((node_900 + ( (saturate((dot(float3(0,1,0),LightDir)+0.25)) - node_9124) * ((1.3+(Backside_Darkening_Amount*2.0)) - node_900) ) / (1.0 - node_9124))),_LushLODTreeTimeOfDay); // This is an optional lighting adjustment you can remove this if your scene doesnt benefit from this.
                float3 emissive = (lerp((node_6001*node_9076),lerp((node_5686*node_9076),node_6001,node_9794),(max(max(node_9076.r,node_9076.g),node_9076.b)-node_9794))*TimeOfDayIntensity);
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
            #pragma fragmentoption ARB_precision_hint_fastest
            #pragma multi_compile_shadowcaster
            #pragma multi_compile_fog
            #pragma target 3.0
            uniform float _Cutoff;
            uniform sampler2D _MainTex; uniform float4 _MainTex_ST;
            float ClipMe( float TexAlpha , float Cutoff ){
            clip(TexAlpha - Cutoff);
            return TexAlpha;
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
                clip(TexAlpha - 0.5);
                SHADOW_CASTER_FRAGMENT(i)
            }
            ENDCG
        }
    }
    CustomEditor "ShaderForgeMaterialInspector"
}
