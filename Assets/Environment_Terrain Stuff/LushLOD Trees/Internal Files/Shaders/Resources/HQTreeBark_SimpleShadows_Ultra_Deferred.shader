// Shader created with Shader Forge v1.38 
// Shader Forge (c) Neat Corporation / Joachim Holmer - http://www.acegikmo.com/shaderforge/
// Note: Manually altering this data may prevent you from opening it in Shader Forge
/*SF_DATA;ver:1.38;sub:START;pass:START;ps:flbk:,iptp:0,cusa:False,bamd:0,cgin:,lico:0,lgpr:1,limd:0,spmd:1,trmd:0,grmd:0,uamb:True,mssp:True,bkdf:False,hqlp:False,rprd:False,enco:False,rmgx:True,imps:True,rpth:0,vtps:0,hqsc:True,nrmq:1,nrsp:0,vomd:0,spxs:False,tesm:0,olmd:1,culm:0,bsrc:0,bdst:1,dpts:2,wrdp:True,dith:0,atcv:False,rfrpo:False,rfrpn:Refraction,coma:15,ufog:True,aust:False,igpj:False,qofs:0,qpre:1,rntp:1,fgom:False,fgoc:False,fgod:False,fgor:False,fgmd:0,fgcr:0.5657439,fgcg:0.6941743,fgcb:0.8014706,fgca:1,fgde:0.01,fgrn:0,fgrf:300,stcl:True,atwp:False,stva:191,stmr:255,stmw:255,stcp:6,stps:2,stfa:0,stfz:0,ofsf:0,ofsu:0,f2p0:False,fnsp:False,fnfb:True,fsmp:False;n:type:ShaderForge.SFN_Final,id:8808,x:36762,y:32724,varname:node_8808,prsc:2|custl-8301-OUT,alpha-7599-OUT,clip-2612-OUT;n:type:ShaderForge.SFN_Slider,id:7344,x:31471,y:33056,ptovrint:False,ptlb:Transparency,ptin:_Transparency,varname:_Transparency,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,min:0,cur:0,max:1;n:type:ShaderForge.SFN_Tex2d,id:3166,x:33218,y:32703,ptovrint:False,ptlb:MainTex,ptin:_MainTex,varname:_MainTex,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,ntxv:0,isnm:False;n:type:ShaderForge.SFN_Set,id:3152,x:33537,y:33499,varname:Dither,prsc:2|IN-6752-OUT;n:type:ShaderForge.SFN_Code,id:6752,x:33157,y:33502,varname:node_6752,prsc:2,code:ZgBsAG8AYQB0ACAAYwBsAGkAcABWAGEAbABfAFAAUABFACAAPQAgAG0AYQB0AHIAaQB4AEkATgA7AAoACgByAGUAdAB1AHIAbgAgAGMAbABpAHAAVgBhAGwAXwBQAFAARQA7AA==,output:0,fname:Dither_SMOOTHING,width:271,height:125,input:0,input:0,input_1_label:matrixIN,input_2_label:cut_off|A-267-OUT,B-3935-OUT;n:type:ShaderForge.SFN_Get,id:3935,x:32877,y:33660,varname:node_3935,prsc:2|IN-970-OUT;n:type:ShaderForge.SFN_Code,id:267,x:32464,y:33503,cmnt:Note that the billboards check for equals to 0 instead of 1.,varname:node_267,prsc:2,code:ZgBsAG8AYQB0ADIAIABwAHgAIAA9ACAAZgBsAG8AbwByACgAXwBTAGMAcgBlAGUAbgBQAGEAcgBhAG0AcwAuAHgAeQAgACoAIABzAGMAcgBlAGUAbgBVAFYAcwApADsACgByAGUAdAB1AHIAbgAgACgAZgBtAG8AZAAoAHAAeAAuAHgAIAArACAAcAB4AC4AeQAsACAAMgApACAAPQA9ACAAMQApACAAPwAgADAAIAA6ACAAMQA7AC8ALwAtADAALgA0ADUAIAA6ACAAMQA7AA==,output:0,fname:XYtest,width:493,height:132,input:1,input_1_label:screenUVs|A-7831-UVOUT;n:type:ShaderForge.SFN_ScreenPos,id:7831,x:32249,y:33500,varname:node_7831,prsc:2,sctp:2;n:type:ShaderForge.SFN_Set,id:970,x:31812,y:32947,varname:Param_Cutoff,prsc:2|IN-2469-OUT;n:type:ShaderForge.SFN_Slider,id:2469,x:31471,y:32948,ptovrint:False,ptlb:Cutoff,ptin:_Cutoff,varname:_Cutoff,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,min:0,cur:0.7,max:1;n:type:ShaderForge.SFN_Set,id:9043,x:31812,y:33049,varname:Param_Transparency,prsc:2|IN-7344-OUT;n:type:ShaderForge.SFN_Color,id:6756,x:34374,y:32667,ptovrint:False,ptlb:Color,ptin:_Color,cmnt:The input color,varname:_Color,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,c1:1,c2:1,c3:1,c4:1;n:type:ShaderForge.SFN_Set,id:6107,x:31069,y:33416,cmnt:This value ranges from 0 to 0.2,varname:Backside_Darkening,prsc:2|IN-4688-OUT;n:type:ShaderForge.SFN_Set,id:4328,x:31231,y:32430,varname:LightIN,prsc:2|IN-6244-OUT;n:type:ShaderForge.SFN_Vector4Property,id:5694,x:30361,y:32738,ptovrint:False,ptlb:_LushLODTreeMainLightDir,ptin:_LushLODTreeMainLightDir,cmnt:The W is set via script in _LushLODTreesManager.cs,varname:node_8259,prsc:2,glob:True,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,v1:0.5,v2:0.5,v3:0.5,v4:1;n:type:ShaderForge.SFN_Color,id:3617,x:30361,y:32442,ptovrint:False,ptlb:LushLODTreeMainLightCol,ptin:_LushLODTreeMainLightCol,cmnt:This works even with lightmaps,varname:node_349,prsc:2,glob:True,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,c1:0.5,c2:0.5,c3:0.5,c4:1;n:type:ShaderForge.SFN_ValueProperty,id:7441,x:30361,y:32623,ptovrint:False,ptlb:LushLODTreeMainLightIntensity,ptin:_LushLODTreeMainLightIntensity,cmnt:This works even with lightmaps,varname:node_5384,prsc:2,glob:True,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,v1:1;n:type:ShaderForge.SFN_Set,id:4347,x:30674,y:32776,varname:LightDir,prsc:2|IN-5694-XYZ;n:type:ShaderForge.SFN_ViewVector,id:1532,x:30475,y:33259,varname:node_1532,prsc:2;n:type:ShaderForge.SFN_Dot,id:4688,x:30688,y:33350,cmnt:Check if view is opposite the direction of sunlight,varname:node_4688,prsc:2,dt:4|A-1532-OUT,B-3300-OUT;n:type:ShaderForge.SFN_RemapRange,id:6774,x:30865,y:33386,cmnt:Rescales it to 0.7 to 1 multiplied by 0.75 which yields 0.525 to 0.75,varname:node_6774,prsc:2,frmn:-1,frmx:1,tomn:0.525,tomx:0.75|IN-4688-OUT;n:type:ShaderForge.SFN_Get,id:3300,x:30475,y:33396,varname:node_3300,prsc:2|IN-4347-OUT;n:type:ShaderForge.SFN_Vector3,id:9257,x:31576,y:32467,cmnt:Checks if the light is shining straight down,varname:node_9257,prsc:2,v1:0,v2:1,v3:0;n:type:ShaderForge.SFN_Get,id:5711,x:31576,y:32583,varname:node_5711,prsc:2|IN-4347-OUT;n:type:ShaderForge.SFN_Dot,id:7526,x:31813,y:32513,cmnt:Is ths sun above the horizon?,varname:node_7526,prsc:2,dt:0|A-9257-OUT,B-5711-OUT;n:type:ShaderForge.SFN_Vector1,id:7885,x:32001,y:32566,varname:node_7885,prsc:2,v1:0.25;n:type:ShaderForge.SFN_Add,id:8746,x:32183,y:32512,cmnt:This makes the trees not get dark  until the sun is somewhat BELOW the horizon,varname:node_8746,prsc:2|A-7526-OUT,B-7885-OUT;n:type:ShaderForge.SFN_Clamp01,id:8182,x:32384,y:32512,varname:node_8182,prsc:2|IN-8746-OUT;n:type:ShaderForge.SFN_Multiply,id:6678,x:32166,y:32295,varname:node_6678,prsc:2|A-8394-OUT,B-596-OUT;n:type:ShaderForge.SFN_Vector1,id:596,x:31984,y:32319,varname:node_596,prsc:2,v1:2;n:type:ShaderForge.SFN_Get,id:8394,x:31963,y:32214,varname:node_8394,prsc:2|IN-6107-OUT;n:type:ShaderForge.SFN_Vector1,id:5183,x:32166,y:32234,varname:node_5183,prsc:2,v1:1.3;n:type:ShaderForge.SFN_Add,id:7560,x:32384,y:32316,varname:node_7560,prsc:2|A-5183-OUT,B-6678-OUT;n:type:ShaderForge.SFN_Vector1,id:4978,x:32384,y:32260,varname:node_4978,prsc:2,v1:0;n:type:ShaderForge.SFN_Vector1,id:59,x:32384,y:32201,varname:node_59,prsc:2,v1:1;n:type:ShaderForge.SFN_Vector1,id:4204,x:32384,y:32141,varname:node_4204,prsc:2,v1:0;n:type:ShaderForge.SFN_RemapRangeAdvanced,id:1590,x:32646,y:32304,cmnt:Rescales it from 01 to about 03 to make it get brighter faster as the sun comes up. This effect is significantly stronger on the sunyn side via backside darkening.,varname:node_1590,prsc:2|IN-8182-OUT,IMIN-4204-OUT,IMAX-59-OUT,OMIN-4978-OUT,OMAX-7560-OUT;n:type:ShaderForge.SFN_Clamp01,id:1145,x:32844,y:32304,varname:node_1145,prsc:2|IN-1590-OUT;n:type:ShaderForge.SFN_Set,id:9947,x:33429,y:32349,cmnt:This is an optional lighting adjustment you can remove this if your scene doesnt benefit from this,varname:TimeOfDayIntensity,prsc:2|IN-3973-OUT;n:type:ShaderForge.SFN_NormalVector,id:2148,x:31376,y:33153,prsc:2,pt:False;n:type:ShaderForge.SFN_Get,id:1366,x:31376,y:33310,varname:node_1366,prsc:2|IN-4347-OUT;n:type:ShaderForge.SFN_Dot,id:8256,x:31569,y:33190,varname:node_8256,prsc:2,dt:0|A-2148-OUT,B-1366-OUT;n:type:ShaderForge.SFN_RemapRange,id:9534,x:31743,y:33190,cmnt:This adds a basic shadow to the back side of the tree trunks based on the normals,varname:node_9534,prsc:2,frmn:-1,frmx:1,tomn:0.2,tomx:0.8|IN-8256-OUT;n:type:ShaderForge.SFN_Set,id:7366,x:31908,y:33519,varname:AlphaToPostProcessor,prsc:2|IN-9994-OUT;n:type:ShaderForge.SFN_Get,id:7599,x:36379,y:32974,varname:node_7599,prsc:2|IN-7366-OUT;n:type:ShaderForge.SFN_Get,id:2612,x:36379,y:33023,varname:node_2612,prsc:2|IN-3152-OUT;n:type:ShaderForge.SFN_TexCoord,id:1766,x:31095,y:33810,varname:node_1766,prsc:2,uv:0,uaff:False;n:type:ShaderForge.SFN_Code,id:2157,x:31939,y:33813,varname:node_2157,prsc:2,code:ZgBsAG8AYQB0ADQAeAA0ACAAbQB0AHgAIAA9ACAAZgBsAG8AYQB0ADQAeAA0ACgACgAJAGYAbABvAGEAdAA0ACgAMQAsACAAOQAsACAAMwAsACAAMQAxACkAIAAvACAAMQA3AC4AMAAsAAoACQBmAGwAbwBhAHQANAAoADEAMwAsACAANQAsACAAMQA1ACwAIAA3ACkAIAAvACAAMQA3AC4AMAAsAAoACQBmAGwAbwBhAHQANAAoADQALAAgADEAMgAsACAAMgAsACAAMQAwACkAIAAvACAAMQA3AC4AMAAsAAoACQBmAGwAbwBhAHQANAAoADEANgAsACAAOAAsACAAMQA0ACwAIAA2ACkAIAAvACAAMQA3AC4AMAAKACkAOwAKAAoAZgBsAG8AYQB0ADIAIABwAHgAIAA9ACAAZgBsAG8AbwByACgAXwBTAGMAcgBlAGUAbgBQAGEAcgBhAG0AcwAuAHgAeQAgACoAIABzAGMAZQBuAGUAVQBWAHMAKQA7AAoAaQBuAHQAIAB4AFMAbQBwACAAPQAgAGYAbQBvAGQAKABwAHgALgB4ACwAIAA0ACkAOwAKAGkAbgB0ACAAeQBTAG0AcAAgAD0AIABmAG0AbwBkACgAcAB4AC4AeQAsACAANAApADsACgBmAGwAbwBhAHQANAAgAHgAVgBlAGMAIAA9ACAAMQAgAC0AIABzAGEAdAB1AHIAYQB0AGUAKABhAGIAcwAoAGYAbABvAGEAdAA0ACgAMAAsACAAMQAsACAAMgAsACAAMwApACAALQAgAHgAUwBtAHAAKQApADsACgBmAGwAbwBhAHQANAAgAHkAVgBlAGMAIAA9ACAAMQAgAC0AIABzAGEAdAB1AHIAYQB0AGUAKABhAGIAcwAoAGYAbABvAGEAdAA0ACgAMAAsACAAMQAsACAAMgAsACAAMwApACAALQAgAHkAUwBtAHAAKQApADsACgBmAGwAbwBhAHQANAAgAHAAeABNAHUAbAB0ACAAPQAgAGYAbABvAGEAdAA0ACgAZABvAHQAKABtAHQAeABbADAAXQAsACAAeQBWAGUAYwApACwAIABkAG8AdAAoAG0AdAB4AFsAMQBdACwAIAB5AFYAZQBjACkALAAgAGQAbwB0ACgAbQB0AHgAWwAyAF0ALAAgAHkAVgBlAGMAKQAsACAAZABvAHQAKABtAHQAeABbADMAXQAsACAAeQBWAGUAYwApACkAOwAKAHIAZQB0AHUAcgBuACAAZABvAHQAKABwAHgATQB1AGwAdAAsACAAeABWAGUAYwApADsA,output:0,fname:BinaryDither4x4_FOR_SHADOW_PASS,width:746,height:226,input:1,input_1_label:sceneUVs|A-1016-OUT;n:type:ShaderForge.SFN_Code,id:1016,x:31385,y:33806,varname:node_1016,prsc:2,code:IwBpAGYAIABVAE4ASQBUAFkAXwBVAFYAXwBTAFQAQQBSAFQAUwBfAEEAVABfAFQATwBQAA0ACgAJAGYAbABvAGEAdAAgAGcAcgBhAGIAUwBpAGcAbgAgAD0AIAAtAF8AUAByAG8AagBlAGMAdABpAG8AbgBQAGEAcgBhAG0AcwAuAHgAOwANAAoAIwBlAGwAcwBlAA0ACgAJAGYAbABvAGEAdAAgAGcAcgBhAGIAUwBpAGcAbgAgAD0AIABfAFAAcgBvAGoAZQBjAHQAaQBvAG4AUABhAHIAYQBtAHMALgB4ADsADQAKACMAZQBuAGQAaQBmAAoAcgBlAHQAdQByAG4AIABmAGwAbwBhAHQAMgAoADEALAAgAGcAcgBhAGIAUwBpAGcAbgApACoAdQB2AFAAbwBzAC4AeAB5ACoAMAAuADUAIAArACAAMAAuADUAOwA=,output:1,fname:GimmeTextureUV_SHADOWPASS,width:435,height:135,input:1,input_1_label:uvPos|A-1766-UVOUT;n:type:ShaderForge.SFN_Get,id:580,x:32753,y:33868,varname:node_580,prsc:2|IN-970-OUT;n:type:ShaderForge.SFN_Get,id:3417,x:32753,y:33929,varname:node_3417,prsc:2|IN-9043-OUT;n:type:ShaderForge.SFN_Set,id:6404,x:33573,y:33818,varname:ShadowClip,prsc:2|IN-5086-OUT;n:type:ShaderForge.SFN_Code,id:5086,x:32992,y:33810,varname:node_5086,prsc:2,code:ZgBsAG8AYQB0ACAAQwBvAHMAZQByAHAAXwBSAGUAcwB1AGwAdAAgAD0AIAAoADEALgAwACAALQAgAGMAbwBzACgAKAB0AHIAYQBuAHMAKgAzAC4AMQA0ADEANQA5ADIANgA1ADQAKgAwAC4ANQApACkAKQA7ACAALwAvADwALQAtACAAcwBhAG0AZQAgAHQAaABpAG4AZwAgAGEAcwAgAE0AYQB0AGgAZgAuAEMAbwBzAGUAcgBwACgAKQAsACAAcwBlAGUAIABHAG8AbwBnAGwAZQAuACAAVABoAGkAcwAgAGgAZQBsAHAAcwAgAGYAYQBkAGUAIABpAG4AIAB0AGgAZQAgAGwAZQBhAHYAZQBzACAAbQBvAHIAZQAgAGcAcgBhAGQAdQBhAGwAbAB5ACAAYQB0ACAAZgBpAHIAcwB0ACwAIABpAG4AcwB0AGUAYQBkACAAbwBmACAAdABoAGUAbQAgAGEAcABwAGUAYQByAGkAbgBnACAAcwBvACAAcwB1AGQAZABlAG4AbAB5AC4ADQAKAA0ACgBmAGwAbwBhAHQAIAByAGUAcwBjAGEAbABlAGQAMgAgAD0AIABsAGUAcgBwACgAMAAuADUALAAgADEALAAgAEMAbwBzAGUAcgBwAF8AUgBlAHMAdQBsAHQAKQA7ACAALwAvADwALQAtACAAcgBlAHMAYwBhAGwAZQBzACAAdABoAGUAIAB0AHIAYQBuAHMAaQB0AGkAbwBuACAAdABvACAAcgBhAG4AZwBlACAAZgByAG8AbQAgADAALgA1ACAAdABvACAAMQAsACAAaQBuAHMAdABlAGEAZAAgAG8AZgAgAGYAcgBvAG0AIAAwACAAdABvACAAMQAsACAAdABvACAAdAByAGkAbQAgAGEAIABsAGkAdAB0AGwAZQAgAHcAYQBzAHQAZQBkACAAYwB1AHIAdgBlACAAcwBwAGEAYwBlACAAbwBmAGYAIAB0AGgAZQAgAGIAZQBnAGkAbgBuAGkAbgBnAC4ADQAKAGYAbABvAGEAdAAgAHIAZQBzAGMAYQBsAGUAZAAzACAAPQAgAGwAZQByAHAAKAAwAC4ANQAsACAAMwAsACAAQwBvAHMAZQByAHAAXwBSAGUAcwB1AGwAdAApADsAIAAvAC8APAAtAC0AIAByAGUAcwBjAGEAbABlAHMAIAB0AGgAZQAgAHQAcgBhAG4AcwBpAHQAaQBvAG4AIAB0AG8AIAByAGEAbgBnAGUAIABmAHIAbwBtACAAMAAuADUAIAB0AG8AIAAzACwAIABpAG4AcwB0AGUAYQBkACAAbwBmACAAZgByAG8AbQAgADAAIAB0AG8AIAAxACAALQAtACAAdABoAGkAcwAgAGUAbgBzAHUAcgBlAHMAIAB0AGgAZQAgAGQAaQB0AGgAZQByAGkAbgBnACAAaQBzACAAZgB1AGwAbAB5ACAARwBPAE4ARQAgAHcAaABlAG4AIAB0AHIAYQBuAHMAcABhAHIAZQBuAGMAeQAgAGkAcwAgADEALgANAAoAZgBsAG8AYQB0ACAAcgBlAHMAYwBhAGwAZQBkADQAIAA9ACAAbABlAHIAcAAoAHIAZQBzAGMAYQBsAGUAZAAyACwAIAByAGUAcwBjAGEAbABlAGQAMwAsACAAdAByAGEAbgBzACkAOwAgAC8ALwA8AC0ALQAgACIAcgBlAHMAYwBhAGwAZQBkADIAIgAgAGgAZQBsAHAAcwAgAGIAcgBpAG4AZwAgAHQAaABlACAAZABpAHQAaABlAHIAaQBuAGcAIABpAG4AIABtAG8AcgBlACAAcwBsAG8AdwBsAHkAIABhAHQAIABmAGkAcgBzAHQALAAgAGIAdQB0ACAAbABlAGEAdgBlAHMAIABzAG8AbQBlACAAZABpAHQAaABlAHIAaQBuAGcAIABzAHQAaQBsAGwAIAByAGUAbQBhAGkAbgBpAG4AZwAuACAAIgByAGUAcwBjAGEAbABlAGQAMwAiACAAcgBlAG0AZQBkAGkAZQBzACAAdABoAGEAdAAuAA0ACgANAAoAZgBsAG8AYQB0ACAAZABpAHQAaABlAHIAIAA9ACAAbQBhAHQAcgBpAHgASQBOACAAKwAgACgAcgBlAHMAYwBhAGwAZQBkADQAIAAtACAAMQAuADUAKQA7ACAALwAvADwALQAtACAAYwBhAGwAYwB1AGwAYQB0AGUAcwAgAHQAaABlACAAZABpAHQAaABlAHIAaQBuAGcALgANAAoAcgBlAHQAdQByAG4AIABkAGkAdABoAGUAcgAgACsAIAAwAC4ANQA7ACAALwAvADwALQAtACAAVABIAEkAUwAgAEYASQBSAFMAVAAgAEMATABJAFAAIABpAHMAIABiAGEAcwBlAGQAIABvAG4AIABUAEUAWABUAFUAUgBFACAAUwBQAEEAQwBFACAAZABpAHQAaABlAHIAaQBuAGcALgAgAEkAdAAgAGkAcwAgACIAYwBoAHUAbgBrAHkAIgAgAGkAbgAgAGEAcABwAGUAcgBhAG4AYwBlAC4AIABMAGUAYQB2AGUAcwAgAGIAZQBnAGkAbgAgAHQAbwAgAGEAcABwAGUAYQByACAAaQBuACAAYwBoAHUAbgBrAHMAIABpAG4AIAB0AGgAZQAgAGMAZQBuAHQAZQByACAAbwBmACAAdABoAGUAIAB0AHIAZQBlACAAZgBpAHIAcwB0ACwAIAB3AGgAZQByAGUAIABsAGUAYQB2AGUAcwAgAGEAcgBlACAAdABoAGUAIABtAG8AcwB0ACAAZABlAG4AcwBlAC4ADQAKAA==,output:0,fname:Dither_FOR_SHADOW_PASS,width:521,height:177,input:0,input:0,input:0,input_1_label:matrixIN,input_2_label:cut_off,input_3_label:trans|A-2157-OUT,B-580-OUT,C-3417-OUT;n:type:ShaderForge.SFN_RemapRange,id:9994,x:31648,y:33486,varname:node_9994,prsc:2,frmn:0,frmx:1,tomn:0.01,tomx:0.95|IN-6722-OUT;n:type:ShaderForge.SFN_Get,id:6722,x:31413,y:33486,varname:node_6722,prsc:2|IN-9043-OUT;n:type:ShaderForge.SFN_Multiply,id:6244,x:31023,y:32419,varname:node_6244,prsc:2|A-3617-RGB,B-772-OUT;n:type:ShaderForge.SFN_Get,id:6916,x:35767,y:32765,varname:node_6916,prsc:2|IN-9947-OUT;n:type:ShaderForge.SFN_NormalVector,id:16,x:33980,y:33470,prsc:2,pt:False;n:type:ShaderForge.SFN_Dot,id:2773,x:34167,y:33503,varname:node_2773,prsc:2,dt:1|A-16-OUT,B-3050-OUT;n:type:ShaderForge.SFN_Get,id:3050,x:33954,y:33631,varname:node_3050,prsc:2|IN-4347-OUT;n:type:ShaderForge.SFN_Multiply,id:8301,x:36141,y:32691,cmnt:Applies the time of day,varname:node_8301,prsc:2|A-98-OUT,B-6916-OUT;n:type:ShaderForge.SFN_Lerp,id:2107,x:35189,y:32594,cmnt:Lerps towards the inut color based on how much the input color is LESS than WHITE.,varname:node_2107,prsc:2|A-1456-OUT,B-8825-OUT,T-5872-OUT;n:type:ShaderForge.SFN_Min,id:5872,x:34622,y:32998,cmnt:Finds how much LESS than WHITE the iput color is,varname:node_5872,prsc:2|A-7891-R,B-7891-G,C-7891-B;n:type:ShaderForge.SFN_Multiply,id:9241,x:35189,y:32760,cmnt:Darkens the final color based on the input color.,varname:node_9241,prsc:2|A-8825-OUT,B-6756-RGB;n:type:ShaderForge.SFN_Lerp,id:98,x:35788,y:32627,cmnt:If our input is grey we simply multiply by that grey to darken the final color without hurting the saturatio so much. But if our input is a color we lerp towards that color based upon how much that color is LESS than WHITE.,varname:node_98,prsc:2|A-9241-OUT,B-2107-OUT,T-6062-OUT;n:type:ShaderForge.SFN_Max,id:3461,x:34622,y:32838,cmnt:Finds the higest input color value,varname:node_3461,prsc:2|A-7891-R,B-7891-G,C-7891-B;n:type:ShaderForge.SFN_Subtract,id:6062,x:35189,y:32920,cmnt:Finds the difference between the highest and lowest color value. This is used to detect if our input color is simply a shade of grey and has no color.,varname:node_6062,prsc:2|A-3461-OUT,B-5872-OUT;n:type:ShaderForge.SFN_Multiply,id:1456,x:34822,y:32397,cmnt:The inut color multiplied by the texture color to give the iput color a texture so that it doesnt look flat,varname:node_1456,prsc:2|A-3166-RGB,B-6756-RGB;n:type:ShaderForge.SFN_Vector1,id:2220,x:35570,y:32831,varname:node_2220,prsc:2,v1:1;n:type:ShaderForge.SFN_ComponentMask,id:7891,x:34364,y:32885,varname:node_7891,prsc:2,cc1:0,cc2:1,cc3:2,cc4:-1|IN-6756-RGB;n:type:ShaderForge.SFN_Multiply,id:9322,x:33689,y:32810,varname:node_9322,prsc:2|A-3166-RGB,B-3922-OUT;n:type:ShaderForge.SFN_Get,id:7357,x:32971,y:32929,varname:node_7357,prsc:2|IN-4328-OUT;n:type:ShaderForge.SFN_Add,id:3922,x:33247,y:32922,varname:node_3922,prsc:2|A-7357-OUT,B-6912-RGB;n:type:ShaderForge.SFN_Blend,id:5657,x:33985,y:33228,varname:node_5657,prsc:2,blmd:1,clmp:False|SRC-6912-RGB,DST-3166-RGB;n:type:ShaderForge.SFN_Multiply,id:8939,x:34188,y:33300,cmnt:Darkens the ambient,varname:node_8939,prsc:2|A-5657-OUT,B-2219-OUT;n:type:ShaderForge.SFN_Vector1,id:2219,x:33974,y:33394,varname:node_2219,prsc:2,v1:0.8;n:type:ShaderForge.SFN_Lerp,id:8825,x:34530,y:33208,cmnt:The final color with the shadows and the ambient tint applied to the shadows,varname:node_8825,prsc:2|A-8939-OUT,B-9322-OUT,T-27-OUT;n:type:ShaderForge.SFN_Divide,id:772,x:30770,y:32505,varname:node_772,prsc:2|A-7441-OUT,B-9027-OUT;n:type:ShaderForge.SFN_Vector1,id:9027,x:30571,y:32598,varname:node_9027,prsc:2,v1:1.2;n:type:ShaderForge.SFN_Color,id:6912,x:32992,y:33111,ptovrint:False,ptlb:_LushLODTreeAmbientColor,ptin:_LushLODTreeAmbientColor,cmnt:_LushLODTreeAmbientColor... this value is set in the manager,varname:_LushLODTreeAmbientColor_copy,prsc:2,glob:True,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,c1:0.5,c2:0.5,c3:0.5,c4:1;n:type:ShaderForge.SFN_Lerp,id:3973,x:33186,y:32426,cmnt:Lets the user adjust the tie of day correction,varname:node_3973,prsc:2|A-3080-OUT,B-1145-OUT,T-8604-OUT;n:type:ShaderForge.SFN_Vector1,id:3080,x:32939,y:32426,varname:node_3080,prsc:2,v1:1;n:type:ShaderForge.SFN_ValueProperty,id:8604,x:32939,y:32498,ptovrint:False,ptlb:LushLODTreeTimeOfDay,ptin:_LushLODTreeTimeOfDay,varname:node_5174,prsc:2,glob:True,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,v1:1;n:type:ShaderForge.SFN_Clamp,id:27,x:34444,y:33670,cmnt:This lets the user adjust te maximum shadow. A value of 0.5 will limit it to half.,varname:node_27,prsc:2|IN-2773-OUT,MIN-7774-OUT,MAX-2458-OUT;n:type:ShaderForge.SFN_Vector1,id:2458,x:34136,y:33764,varname:node_2458,prsc:2,v1:1;n:type:ShaderForge.SFN_OneMinus,id:7774,x:34214,y:33875,varname:node_7774,prsc:2|IN-1474-OUT;n:type:ShaderForge.SFN_ValueProperty,id:1474,x:33988,y:33875,ptovrint:False,ptlb:LushLODTreeShadowDarkness,ptin:_LushLODTreeShadowDarkness,varname:_LushLODTreeShadowDarkness,prsc:2,glob:True,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,v1:1;proporder:7344-3166-2469-6756;pass:END;sub:END;*/

Shader "Hidden/LushLODTree/HQTreeBark_SimpleShadows_Ultra_Deferred" {
    Properties {
        _Transparency ("Transparency", Range(0, 1)) = 0
        _MainTex ("MainTex", 2D) = "white" {}
        _Cutoff ("Cutoff", Range(0, 1)) = 0.7
        _Color ("Color", Color) = (1,1,1,1)
        [HideInInspector]_Cutoff ("Alpha cutoff", Range(0,1)) = 0.5
    }
    SubShader {
        Tags {
            "RenderType"="Opaque"
        }
        LOD 100
        Pass {
            Name "FORWARD"
            Tags {
                "LightMode"="ForwardBase"
            }
            
            
            Stencil {
                Ref 191
                Pass Replace
            }
            CGPROGRAM
            #pragma vertex vert
            #pragma fragment frag
            #define UNITY_PASS_FORWARDBASE
            #include "UnityCG.cginc"
            #pragma multi_compile_fwdbase_fullshadows
            #pragma multi_compile_fog
            #pragma target 3.0
            uniform float _Transparency;
            uniform sampler2D _MainTex; uniform float4 _MainTex_ST;
            float Dither_SMOOTHING( float matrixIN , float cut_off ){
            float clipVal_PPE = matrixIN;
            
            return clipVal_PPE;
            }
            
            float XYtest( float2 screenUVs ){
            float2 px = floor(_ScreenParams.xy * screenUVs);
            return (fmod(px.x + px.y, 2) == 1) ? 0 : 1;//-0.45 : 1;
            }
            
            uniform float _Cutoff;
            uniform float4 _Color;
            uniform float4 _LushLODTreeMainLightDir;
            uniform float4 _LushLODTreeMainLightCol;
            uniform float _LushLODTreeMainLightIntensity;
            uniform float4 _LushLODTreeAmbientColor;
            uniform float _LushLODTreeTimeOfDay;
            uniform float _LushLODTreeShadowDarkness;
            struct VertexInput {
                float4 vertex : POSITION;
                float3 normal : NORMAL;
                float2 texcoord0 : TEXCOORD0;
            };
            struct VertexOutput {
                float4 pos : SV_POSITION;
                float2 uv0 : TEXCOORD0;
                float4 posWorld : TEXCOORD1;
                float3 normalDir : TEXCOORD2;
                float4 projPos : TEXCOORD3;
                UNITY_FOG_COORDS(4)
            };
            VertexOutput vert (VertexInput v) {
                VertexOutput o = (VertexOutput)0;
                o.uv0 = v.texcoord0;
                o.normalDir = UnityObjectToWorldNormal(v.normal);
                o.posWorld = mul(unity_ObjectToWorld, v.vertex);
                o.pos = UnityObjectToClipPos( v.vertex );
                UNITY_TRANSFER_FOG(o,o.pos);
                o.projPos = ComputeScreenPos (o.pos);
                COMPUTE_EYEDEPTH(o.projPos.z);
                return o;
            }
            float4 frag(VertexOutput i) : COLOR {
                i.normalDir = normalize(i.normalDir);
                float3 viewDirection = normalize(_WorldSpaceCameraPos.xyz - i.posWorld.xyz);
                float3 normalDirection = i.normalDir;
                float2 sceneUVs = (i.projPos.xy / i.projPos.w);
                float Param_Cutoff = _Cutoff;
                float Dither = Dither_SMOOTHING( XYtest( sceneUVs.rg ) , Param_Cutoff );
                clip(Dither - 0.5);
////// Lighting:
                float4 _MainTex_var = tex2D(_MainTex,TRANSFORM_TEX(i.uv0, _MainTex));
                float3 LightIN = (_LushLODTreeMainLightCol.rgb*(_LushLODTreeMainLightIntensity/1.2));
                float3 LightDir = _LushLODTreeMainLightDir.rgb;
                float3 node_8825 = lerp(((_LushLODTreeAmbientColor.rgb*_MainTex_var.rgb)*0.8),(_MainTex_var.rgb*(LightIN+_LushLODTreeAmbientColor.rgb)),clamp(max(0,dot(i.normalDir,LightDir)),(1.0 - _LushLODTreeShadowDarkness),1.0)); // The final color with the shadows and the ambient tint applied to the shadows
                float3 node_7891 = _Color.rgb.rgb;
                float node_5872 = min(min(node_7891.r,node_7891.g),node_7891.b); // Finds how much LESS than WHITE the iput color is
                float node_4204 = 0.0;
                float node_4978 = 0.0;
                float node_4688 = 0.5*dot(viewDirection,LightDir)+0.5; // Check if view is opposite the direction of sunlight
                float Backside_Darkening = node_4688; // This value ranges from 0 to 0.2
                float TimeOfDayIntensity = lerp(1.0,saturate((node_4978 + ( (saturate((dot(float3(0,1,0),LightDir)+0.25)) - node_4204) * ((1.3+(Backside_Darkening*2.0)) - node_4978) ) / (1.0 - node_4204))),_LushLODTreeTimeOfDay); // This is an optional lighting adjustment you can remove this if your scene doesnt benefit from this
                float3 finalColor = (lerp((node_8825*_Color.rgb),lerp((_MainTex_var.rgb*_Color.rgb),node_8825,node_5872),(max(max(node_7891.r,node_7891.g),node_7891.b)-node_5872))*TimeOfDayIntensity);
                float Param_Transparency = _Transparency;
                float AlphaToPostProcessor = (Param_Transparency*0.94+0.01);
                fixed4 finalRGBA = fixed4(finalColor,AlphaToPostProcessor);
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
            Cull Back
            
            CGPROGRAM
            #pragma vertex vert
            #pragma fragment frag
            #define UNITY_PASS_SHADOWCASTER
            #include "UnityCG.cginc"
            #include "Lighting.cginc"
            #pragma fragmentoption ARB_precision_hint_fastest
            #pragma multi_compile_shadowcaster
            #pragma multi_compile_fog
            #pragma target 3.0
            float Dither_SMOOTHING( float matrixIN , float cut_off ){
            float clipVal_PPE = matrixIN;
            
            return clipVal_PPE;
            }
            
            float XYtest( float2 screenUVs ){
            float2 px = floor(_ScreenParams.xy * screenUVs);
            return (fmod(px.x + px.y, 2) == 1) ? 0 : 1;//-0.45 : 1;
            }
            
            uniform float _Cutoff;
            struct VertexInput {
                float4 vertex : POSITION;
            };
            struct VertexOutput {
                V2F_SHADOW_CASTER;
                float4 projPos : TEXCOORD1;
            };
            VertexOutput vert (VertexInput v) {
                VertexOutput o = (VertexOutput)0;
                o.pos = UnityObjectToClipPos( v.vertex );
                o.projPos = ComputeScreenPos (o.pos);
                COMPUTE_EYEDEPTH(o.projPos.z);
                TRANSFER_SHADOW_CASTER(o)
                return o;
            }
            float4 frag(VertexOutput i) : COLOR {
                float2 sceneUVs = (i.projPos.xy / i.projPos.w);
                float Param_Cutoff = _Cutoff;
                float Dither = Dither_SMOOTHING( XYtest( sceneUVs.rg ) , Param_Cutoff );
                clip(Dither - 0.5);
                SHADOW_CASTER_FRAGMENT(i)
            }
            ENDCG
        }
    }
    CustomEditor "ShaderForgeMaterialInspector"
}
