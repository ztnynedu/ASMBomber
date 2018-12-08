// Shader created with Shader Forge v1.38 
// Shader Forge (c) Neat Corporation / Joachim Holmer - http://www.acegikmo.com/shaderforge/
// Note: Manually altering this data may prevent you from opening it in Shader Forge
/*SF_DATA;ver:1.38;sub:START;pass:START;ps:flbk:,iptp:0,cusa:False,bamd:0,cgin:,lico:0,lgpr:1,limd:0,spmd:1,trmd:0,grmd:0,uamb:True,mssp:True,bkdf:False,hqlp:False,rprd:False,enco:False,rmgx:True,imps:True,rpth:0,vtps:0,hqsc:True,nrmq:1,nrsp:0,vomd:0,spxs:False,tesm:0,olmd:1,culm:0,bsrc:0,bdst:1,dpts:2,wrdp:True,dith:0,atcv:False,rfrpo:False,rfrpn:Refraction,coma:15,ufog:True,aust:False,igpj:False,qofs:51,qpre:2,rntp:3,fgom:False,fgoc:False,fgod:False,fgor:False,fgmd:0,fgcr:0.5657439,fgcg:0.6941743,fgcb:0.8014706,fgca:1,fgde:0.01,fgrn:0,fgrf:300,stcl:True,atwp:False,stva:191,stmr:255,stmw:255,stcp:6,stps:2,stfa:0,stfz:0,ofsf:0,ofsu:0,f2p0:False,fnsp:False,fnfb:True,fsmp:False;n:type:ShaderForge.SFN_Final,id:8808,x:36631,y:32445,varname:node_8808,prsc:2|custl-973-OUT,alpha-7599-OUT,clip-2495-OUT;n:type:ShaderForge.SFN_Slider,id:7344,x:31471,y:33056,ptovrint:False,ptlb:Transparency,ptin:_Transparency,varname:_Transparency,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,min:0,cur:0,max:1;n:type:ShaderForge.SFN_Tex2d,id:3166,x:33353,y:32501,ptovrint:False,ptlb:MainTex,ptin:_MainTex,varname:_MainTex,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,ntxv:0,isnm:False;n:type:ShaderForge.SFN_Set,id:3152,x:33537,y:33499,varname:Dither,prsc:2|IN-6752-OUT;n:type:ShaderForge.SFN_Code,id:6752,x:33157,y:33502,varname:node_6752,prsc:2,code:ZgBsAG8AYQB0ACAAYwBsAGkAcABWAGEAbABfAFAAUABFACAAPQAgAG0AYQB0AHIAaQB4AEkATgA7AAoACgByAGUAdAB1AHIAbgAgAGMAbABpAHAAVgBhAGwAXwBQAFAARQA7AA==,output:0,fname:Dither_SMOOTHING,width:271,height:125,input:0,input:0,input_1_label:matrixIN,input_2_label:cut_off|A-267-OUT,B-3935-OUT;n:type:ShaderForge.SFN_Get,id:3935,x:32877,y:33660,varname:node_3935,prsc:2|IN-970-OUT;n:type:ShaderForge.SFN_Code,id:267,x:32464,y:33503,cmnt:Note that the billboards check for equals to 0 instead of 1.,varname:node_267,prsc:2,code:ZgBsAG8AYQB0ADIAIABwAHgAIAA9ACAAZgBsAG8AbwByACgAXwBTAGMAcgBlAGUAbgBQAGEAcgBhAG0AcwAuAHgAeQAgACoAIABzAGMAcgBlAGUAbgBVAFYAcwApADsACgByAGUAdAB1AHIAbgAgACgAZgBtAG8AZAAoAHAAeAAuAHgAIAArACAAcAB4AC4AeQAsACAAMgApACAAPQA9ACAAMQApACAAPwAgADAAIAA6ACAAMQA7AC8ALwAtADAALgA0ADUAIAA6ACAAMQA7AA==,output:0,fname:XYtest,width:493,height:132,input:1,input_1_label:screenUVs|A-7831-UVOUT;n:type:ShaderForge.SFN_ScreenPos,id:7831,x:32249,y:33500,varname:node_7831,prsc:2,sctp:2;n:type:ShaderForge.SFN_Set,id:970,x:31812,y:32919,varname:Param_Cutoff,prsc:2|IN-2469-OUT;n:type:ShaderForge.SFN_Slider,id:2469,x:31471,y:32911,ptovrint:False,ptlb:Cutoff,ptin:_Cutoff,varname:_Cutoff,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,min:0,cur:0.7,max:1;n:type:ShaderForge.SFN_Set,id:9043,x:31812,y:33049,varname:Param_Transparency,prsc:2|IN-7344-OUT;n:type:ShaderForge.SFN_Color,id:6756,x:34435,y:32467,ptovrint:False,ptlb:Color,ptin:_Color,varname:_Color,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,c1:1,c2:1,c3:1,c4:1;n:type:ShaderForge.SFN_Set,id:6107,x:31069,y:33416,cmnt:This value ranges from 0 to 0.2,varname:Backside_Darkening,prsc:2|IN-4688-OUT;n:type:ShaderForge.SFN_Set,id:4328,x:31248,y:32458,varname:LightIN,prsc:2|IN-2434-OUT;n:type:ShaderForge.SFN_Vector4Property,id:5694,x:30361,y:32763,ptovrint:False,ptlb:_LushLODTreeMainLightDir,ptin:_LushLODTreeMainLightDir,cmnt:The W is set via script in _LushLODTreesManager.cs,varname:node_8259,prsc:2,glob:True,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,v1:0.5,v2:0.5,v3:0.5,v4:1;n:type:ShaderForge.SFN_Color,id:3617,x:30361,y:32442,ptovrint:False,ptlb:LushLODTreeMainLightCol,ptin:_LushLODTreeMainLightCol,cmnt:This works even with lightmaps,varname:node_349,prsc:2,glob:True,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,c1:0.5,c2:0.5,c3:0.5,c4:1;n:type:ShaderForge.SFN_ValueProperty,id:7441,x:30361,y:32643,ptovrint:False,ptlb:LushLODTreeMainLightIntensity,ptin:_LushLODTreeMainLightIntensity,cmnt:This works even with lightmaps,varname:node_5384,prsc:2,glob:True,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,v1:1;n:type:ShaderForge.SFN_Set,id:4347,x:30614,y:32748,varname:LightDir,prsc:2|IN-5694-XYZ;n:type:ShaderForge.SFN_ViewVector,id:1532,x:30475,y:33259,varname:node_1532,prsc:2;n:type:ShaderForge.SFN_Dot,id:4688,x:30688,y:33350,cmnt:Check if view is opposite the direction of sunlight,varname:node_4688,prsc:2,dt:4|A-1532-OUT,B-3300-OUT;n:type:ShaderForge.SFN_RemapRange,id:6774,x:30865,y:33386,cmnt:Rescales it to 0.7 to 1 multiplied by 0.75 which yields 0.525 to 0.75,varname:node_6774,prsc:2,frmn:-1,frmx:1,tomn:0.525,tomx:0.75|IN-4688-OUT;n:type:ShaderForge.SFN_Get,id:3300,x:30475,y:33396,varname:node_3300,prsc:2|IN-4347-OUT;n:type:ShaderForge.SFN_Vector3,id:9257,x:31494,y:32275,cmnt:Checks if the light is shining straight down,varname:node_9257,prsc:2,v1:0,v2:1,v3:0;n:type:ShaderForge.SFN_Get,id:5711,x:31494,y:32391,varname:node_5711,prsc:2|IN-4347-OUT;n:type:ShaderForge.SFN_Dot,id:7526,x:31731,y:32321,cmnt:Is ths sun above the horizon?,varname:node_7526,prsc:2,dt:0|A-9257-OUT,B-5711-OUT;n:type:ShaderForge.SFN_Vector1,id:7885,x:31919,y:32374,varname:node_7885,prsc:2,v1:0.25;n:type:ShaderForge.SFN_Add,id:8746,x:32101,y:32320,cmnt:This makes the trees not get dark  until the sun is somewhat BELOW the horizon,varname:node_8746,prsc:2|A-7526-OUT,B-7885-OUT;n:type:ShaderForge.SFN_Clamp01,id:8182,x:32302,y:32320,varname:node_8182,prsc:2|IN-8746-OUT;n:type:ShaderForge.SFN_Multiply,id:6678,x:32084,y:32103,varname:node_6678,prsc:2|A-8394-OUT,B-596-OUT;n:type:ShaderForge.SFN_Vector1,id:596,x:31902,y:32127,varname:node_596,prsc:2,v1:2;n:type:ShaderForge.SFN_Get,id:8394,x:31881,y:32022,varname:node_8394,prsc:2|IN-6107-OUT;n:type:ShaderForge.SFN_Vector1,id:5183,x:32084,y:32042,varname:node_5183,prsc:2,v1:1.3;n:type:ShaderForge.SFN_Add,id:7560,x:32302,y:32156,varname:node_7560,prsc:2|A-5183-OUT,B-6678-OUT;n:type:ShaderForge.SFN_Vector1,id:4978,x:32302,y:32042,varname:node_4978,prsc:2,v1:0;n:type:ShaderForge.SFN_Vector1,id:59,x:32302,y:31989,varname:node_59,prsc:2,v1:1;n:type:ShaderForge.SFN_Vector1,id:4204,x:32302,y:31886,varname:node_4204,prsc:2,v1:0;n:type:ShaderForge.SFN_RemapRangeAdvanced,id:1590,x:32564,y:32112,cmnt:Rescales it from 01 to about 03 to make it get brighter faster as the sun comes up. This effect is significantly stronger on the sunyn side via backside darkening.,varname:node_1590,prsc:2|IN-8182-OUT,IMIN-4204-OUT,IMAX-59-OUT,OMIN-4978-OUT,OMAX-7560-OUT;n:type:ShaderForge.SFN_Clamp01,id:1145,x:32762,y:32112,varname:node_1145,prsc:2|IN-1590-OUT;n:type:ShaderForge.SFN_Set,id:9947,x:33367,y:32151,cmnt:This is an optional lighting adjustment you can remove this if your scene doesnt benefit from this,varname:TimeOfDayIntensity,prsc:2|IN-1092-OUT;n:type:ShaderForge.SFN_Set,id:7366,x:31986,y:33478,varname:AlphaToPostProcessor,prsc:2|IN-9994-OUT;n:type:ShaderForge.SFN_Get,id:7599,x:35981,y:33095,varname:node_7599,prsc:2|IN-7366-OUT;n:type:ShaderForge.SFN_Code,id:2495,x:35796,y:33188,cmnt:Shadow or Main Pass?,varname:node_2495,prsc:2,code:IwBpAGYAIABkAGUAZgBpAG4AZQBkACgAVQBOAEkAVABZAF8AUABBAFMAUwBfAFMASABBAEQATwBXAEMAQQBTAFQARQBSACkACgAJAHIAZQB0AHUAcgBuACAAUwBIAEEARABPAFcAXwBBAEwAUABIAEEAXwBDAEwASQBQADsACgAjAGUAbABzAGUACgAJAHIAZQB0AHUAcgBuACAATQBBAEkATgBfAEEATABQAEgAQQBfAEMATABJAFAAOwAKACMAZQBuAGQAaQBmAA==,output:0,fname:Check_If_Shadow_Pass2,width:378,height:112,input:0,input:0,input_1_label:SHADOW_ALPHA_CLIP,input_2_label:MAIN_ALPHA_CLIP|A-1602-OUT,B-2612-OUT;n:type:ShaderForge.SFN_Get,id:2612,x:35478,y:33313,varname:node_2612,prsc:2|IN-3152-OUT;n:type:ShaderForge.SFN_TexCoord,id:1766,x:31095,y:33810,varname:node_1766,prsc:2,uv:0,uaff:False;n:type:ShaderForge.SFN_Code,id:2157,x:31939,y:33813,varname:node_2157,prsc:2,code:ZgBsAG8AYQB0ADQAeAA0ACAAbQB0AHgAIAA9ACAAZgBsAG8AYQB0ADQAeAA0ACgACgAJAGYAbABvAGEAdAA0ACgAMQAsACAAOQAsACAAMwAsACAAMQAxACkAIAAvACAAMQA3AC4AMAAsAAoACQBmAGwAbwBhAHQANAAoADEAMwAsACAANQAsACAAMQA1ACwAIAA3ACkAIAAvACAAMQA3AC4AMAAsAAoACQBmAGwAbwBhAHQANAAoADQALAAgADEAMgAsACAAMgAsACAAMQAwACkAIAAvACAAMQA3AC4AMAAsAAoACQBmAGwAbwBhAHQANAAoADEANgAsACAAOAAsACAAMQA0ACwAIAA2ACkAIAAvACAAMQA3AC4AMAAKACkAOwAKAAoAZgBsAG8AYQB0ADIAIABwAHgAIAA9ACAAZgBsAG8AbwByACgAXwBTAGMAcgBlAGUAbgBQAGEAcgBhAG0AcwAuAHgAeQAgACoAIABzAGMAZQBuAGUAVQBWAHMAKQA7AAoAaQBuAHQAIAB4AFMAbQBwACAAPQAgAGYAbQBvAGQAKABwAHgALgB4ACwAIAA0ACkAOwAKAGkAbgB0ACAAeQBTAG0AcAAgAD0AIABmAG0AbwBkACgAcAB4AC4AeQAsACAANAApADsACgBmAGwAbwBhAHQANAAgAHgAVgBlAGMAIAA9ACAAMQAgAC0AIABzAGEAdAB1AHIAYQB0AGUAKABhAGIAcwAoAGYAbABvAGEAdAA0ACgAMAAsACAAMQAsACAAMgAsACAAMwApACAALQAgAHgAUwBtAHAAKQApADsACgBmAGwAbwBhAHQANAAgAHkAVgBlAGMAIAA9ACAAMQAgAC0AIABzAGEAdAB1AHIAYQB0AGUAKABhAGIAcwAoAGYAbABvAGEAdAA0ACgAMAAsACAAMQAsACAAMgAsACAAMwApACAALQAgAHkAUwBtAHAAKQApADsACgBmAGwAbwBhAHQANAAgAHAAeABNAHUAbAB0ACAAPQAgAGYAbABvAGEAdAA0ACgAZABvAHQAKABtAHQAeABbADAAXQAsACAAeQBWAGUAYwApACwAIABkAG8AdAAoAG0AdAB4AFsAMQBdACwAIAB5AFYAZQBjACkALAAgAGQAbwB0ACgAbQB0AHgAWwAyAF0ALAAgAHkAVgBlAGMAKQAsACAAZABvAHQAKABtAHQAeABbADMAXQAsACAAeQBWAGUAYwApACkAOwAKAHIAZQB0AHUAcgBuACAAZABvAHQAKABwAHgATQB1AGwAdAAsACAAeABWAGUAYwApADsA,output:0,fname:BinaryDither4x4_FOR_SHADOW_PASS,width:746,height:226,input:1,input_1_label:sceneUVs|A-1016-OUT;n:type:ShaderForge.SFN_Code,id:1016,x:31385,y:33806,varname:node_1016,prsc:2,code:IwBpAGYAIABVAE4ASQBUAFkAXwBVAFYAXwBTAFQAQQBSAFQAUwBfAEEAVABfAFQATwBQAA0ACgAJAGYAbABvAGEAdAAgAGcAcgBhAGIAUwBpAGcAbgAgAD0AIAAtAF8AUAByAG8AagBlAGMAdABpAG8AbgBQAGEAcgBhAG0AcwAuAHgAOwANAAoAIwBlAGwAcwBlAA0ACgAJAGYAbABvAGEAdAAgAGcAcgBhAGIAUwBpAGcAbgAgAD0AIABfAFAAcgBvAGoAZQBjAHQAaQBvAG4AUABhAHIAYQBtAHMALgB4ADsADQAKACMAZQBuAGQAaQBmAAoAcgBlAHQAdQByAG4AIABmAGwAbwBhAHQAMgAoADEALAAgAGcAcgBhAGIAUwBpAGcAbgApACoAdQB2AFAAbwBzAC4AeAB5ACoAMAAuADUAIAArACAAMAAuADUAOwA=,output:1,fname:GimmeTextureUV_SHADOWPASS,width:435,height:135,input:1,input_1_label:uvPos|A-1766-UVOUT;n:type:ShaderForge.SFN_Get,id:580,x:32753,y:33868,varname:node_580,prsc:2|IN-970-OUT;n:type:ShaderForge.SFN_Get,id:3417,x:32753,y:33929,varname:node_3417,prsc:2|IN-9043-OUT;n:type:ShaderForge.SFN_Set,id:6404,x:33776,y:33845,varname:ShadowClip,prsc:2|IN-5086-OUT;n:type:ShaderForge.SFN_Code,id:5086,x:32992,y:33810,varname:node_5086,prsc:2,code:ZgBsAG8AYQB0ACAAQwBvAHMAZQByAHAAXwBSAGUAcwB1AGwAdAAgAD0AIAAoADEALgAwACAALQAgAGMAbwBzACgAKAB0AHIAYQBuAHMAKgAzAC4AMQA0ADEANQA5ADIANgA1ADQAKgAwAC4ANQApACkAKQA7ACAALwAvADwALQAtACAAcwBhAG0AZQAgAHQAaABpAG4AZwAgAGEAcwAgAE0AYQB0AGgAZgAuAEMAbwBzAGUAcgBwACgAKQAsACAAcwBlAGUAIABHAG8AbwBnAGwAZQAuACAAVABoAGkAcwAgAGgAZQBsAHAAcwAgAGYAYQBkAGUAIABpAG4AIAB0AGgAZQAgAGwAZQBhAHYAZQBzACAAbQBvAHIAZQAgAGcAcgBhAGQAdQBhAGwAbAB5ACAAYQB0ACAAZgBpAHIAcwB0ACwAIABpAG4AcwB0AGUAYQBkACAAbwBmACAAdABoAGUAbQAgAGEAcABwAGUAYQByAGkAbgBnACAAcwBvACAAcwB1AGQAZABlAG4AbAB5AC4ADQAKAA0ACgBmAGwAbwBhAHQAIAByAGUAcwBjAGEAbABlAGQAMgAgAD0AIABsAGUAcgBwACgAMAAuADUALAAgADEALAAgAEMAbwBzAGUAcgBwAF8AUgBlAHMAdQBsAHQAKQA7ACAALwAvADwALQAtACAAcgBlAHMAYwBhAGwAZQBzACAAdABoAGUAIAB0AHIAYQBuAHMAaQB0AGkAbwBuACAAdABvACAAcgBhAG4AZwBlACAAZgByAG8AbQAgADAALgA1ACAAdABvACAAMQAsACAAaQBuAHMAdABlAGEAZAAgAG8AZgAgAGYAcgBvAG0AIAAwACAAdABvACAAMQAsACAAdABvACAAdAByAGkAbQAgAGEAIABsAGkAdAB0AGwAZQAgAHcAYQBzAHQAZQBkACAAYwB1AHIAdgBlACAAcwBwAGEAYwBlACAAbwBmAGYAIAB0AGgAZQAgAGIAZQBnAGkAbgBuAGkAbgBnAC4ADQAKAGYAbABvAGEAdAAgAHIAZQBzAGMAYQBsAGUAZAAzACAAPQAgAGwAZQByAHAAKAAwAC4ANQAsACAAMwAsACAAQwBvAHMAZQByAHAAXwBSAGUAcwB1AGwAdAApADsAIAAvAC8APAAtAC0AIAByAGUAcwBjAGEAbABlAHMAIAB0AGgAZQAgAHQAcgBhAG4AcwBpAHQAaQBvAG4AIAB0AG8AIAByAGEAbgBnAGUAIABmAHIAbwBtACAAMAAuADUAIAB0AG8AIAAzACwAIABpAG4AcwB0AGUAYQBkACAAbwBmACAAZgByAG8AbQAgADAAIAB0AG8AIAAxACAALQAtACAAdABoAGkAcwAgAGUAbgBzAHUAcgBlAHMAIAB0AGgAZQAgAGQAaQB0AGgAZQByAGkAbgBnACAAaQBzACAAZgB1AGwAbAB5ACAARwBPAE4ARQAgAHcAaABlAG4AIAB0AHIAYQBuAHMAcABhAHIAZQBuAGMAeQAgAGkAcwAgADEALgANAAoAZgBsAG8AYQB0ACAAcgBlAHMAYwBhAGwAZQBkADQAIAA9ACAAbABlAHIAcAAoAHIAZQBzAGMAYQBsAGUAZAAyACwAIAByAGUAcwBjAGEAbABlAGQAMwAsACAAdAByAGEAbgBzACkAOwAgAC8ALwA8AC0ALQAgACIAcgBlAHMAYwBhAGwAZQBkADIAIgAgAGgAZQBsAHAAcwAgAGIAcgBpAG4AZwAgAHQAaABlACAAZABpAHQAaABlAHIAaQBuAGcAIABpAG4AIABtAG8AcgBlACAAcwBsAG8AdwBsAHkAIABhAHQAIABmAGkAcgBzAHQALAAgAGIAdQB0ACAAbABlAGEAdgBlAHMAIABzAG8AbQBlACAAZABpAHQAaABlAHIAaQBuAGcAIABzAHQAaQBsAGwAIAByAGUAbQBhAGkAbgBpAG4AZwAuACAAIgByAGUAcwBjAGEAbABlAGQAMwAiACAAcgBlAG0AZQBkAGkAZQBzACAAdABoAGEAdAAuAA0ACgANAAoAZgBsAG8AYQB0ACAAZABpAHQAaABlAHIAIAA9ACAAbQBhAHQAcgBpAHgASQBOACAAKwAgACgAcgBlAHMAYwBhAGwAZQBkADQAIAAtACAAMQAuADUAKQA7ACAALwAvADwALQAtACAAYwBhAGwAYwB1AGwAYQB0AGUAcwAgAHQAaABlACAAZABpAHQAaABlAHIAaQBuAGcALgANAAoAcgBlAHQAdQByAG4AIABkAGkAdABoAGUAcgAgACsAIAAwAC4ANQA7ACAALwAvADwALQAtACAAVABIAEkAUwAgAEYASQBSAFMAVAAgAEMATABJAFAAIABpAHMAIABiAGEAcwBlAGQAIABvAG4AIABUAEUAWABUAFUAUgBFACAAUwBQAEEAQwBFACAAZABpAHQAaABlAHIAaQBuAGcALgAgAEkAdAAgAGkAcwAgACIAYwBoAHUAbgBrAHkAIgAgAGkAbgAgAGEAcABwAGUAcgBhAG4AYwBlAC4AIABMAGUAYQB2AGUAcwAgAGIAZQBnAGkAbgAgAHQAbwAgAGEAcABwAGUAYQByACAAaQBuACAAYwBoAHUAbgBrAHMAIABpAG4AIAB0AGgAZQAgAGMAZQBuAHQAZQByACAAbwBmACAAdABoAGUAIAB0AHIAZQBlACAAZgBpAHIAcwB0ACwAIAB3AGgAZQByAGUAIABsAGUAYQB2AGUAcwAgAGEAcgBlACAAdABoAGUAIABtAG8AcwB0ACAAZABlAG4AcwBlAC4ADQAKAA==,output:0,fname:Dither_FOR_SHADOW_PASS,width:692,height:183,input:0,input:0,input:0,input_1_label:matrixIN,input_2_label:cut_off,input_3_label:trans|A-2157-OUT,B-580-OUT,C-3417-OUT;n:type:ShaderForge.SFN_Get,id:1602,x:35478,y:33244,varname:node_1602,prsc:2|IN-6404-OUT;n:type:ShaderForge.SFN_RemapRange,id:9994,x:31809,y:33478,varname:node_9994,prsc:2,frmn:0,frmx:1,tomn:0.01,tomx:0.95|IN-6722-OUT;n:type:ShaderForge.SFN_Get,id:6722,x:31570,y:33490,varname:node_6722,prsc:2|IN-9043-OUT;n:type:ShaderForge.SFN_Get,id:5591,x:35815,y:32549,varname:node_5591,prsc:2|IN-9947-OUT;n:type:ShaderForge.SFN_NormalVector,id:6461,x:33770,y:33328,prsc:2,pt:False;n:type:ShaderForge.SFN_Dot,id:9795,x:33987,y:33386,cmnt:The Shadows Value,varname:node_9795,prsc:2,dt:1|A-6461-OUT,B-1077-OUT;n:type:ShaderForge.SFN_Get,id:1077,x:33770,y:33499,varname:node_1077,prsc:2|IN-4347-OUT;n:type:ShaderForge.SFN_Multiply,id:973,x:36189,y:32475,cmnt:Applies the time of day,varname:node_973,prsc:2|A-5040-OUT,B-5591-OUT;n:type:ShaderForge.SFN_Lerp,id:6989,x:35237,y:32378,cmnt:Lerps towards the inut color based on how much the input color is LESS than WHITE.,varname:node_6989,prsc:2|A-8160-OUT,B-9089-OUT,T-7170-OUT;n:type:ShaderForge.SFN_Min,id:7170,x:34670,y:32782,cmnt:Finds how much LESS than WHITE the iput color is,varname:node_7170,prsc:2|A-8145-R,B-8145-G,C-8145-B;n:type:ShaderForge.SFN_Multiply,id:2147,x:35237,y:32544,cmnt:Darkens the final color based on the input color.,varname:node_2147,prsc:2|A-9089-OUT,B-6756-RGB;n:type:ShaderForge.SFN_Lerp,id:5040,x:35836,y:32411,cmnt:If our input is grey we simply multiply by that grey to darken the final color without hurting the saturatio so much. But if our input is a color we lerp towards that color based upon how much that color is LESS than WHITE.,varname:node_5040,prsc:2|A-2147-OUT,B-6989-OUT,T-6729-OUT;n:type:ShaderForge.SFN_Max,id:1368,x:34670,y:32622,cmnt:Finds the higest input color value,varname:node_1368,prsc:2|A-8145-R,B-8145-G,C-8145-B;n:type:ShaderForge.SFN_Subtract,id:6729,x:35237,y:32704,cmnt:Finds the difference between the highest and lowest color value. This is used to detect if our input color is simply a shade of grey and has no color.,varname:node_6729,prsc:2|A-1368-OUT,B-7170-OUT;n:type:ShaderForge.SFN_Multiply,id:8160,x:34710,y:32342,cmnt:The inut color multiplied by the texture color to give the iput color a texture so that it doesnt look flat,varname:node_8160,prsc:2|A-3166-RGB,B-6756-RGB;n:type:ShaderForge.SFN_ComponentMask,id:8145,x:34435,y:32663,varname:node_8145,prsc:2,cc1:0,cc2:1,cc3:2,cc4:-1|IN-6756-RGB;n:type:ShaderForge.SFN_Multiply,id:3704,x:33797,y:32584,varname:node_3704,prsc:2|A-3166-RGB,B-8702-OUT;n:type:ShaderForge.SFN_Get,id:2449,x:33054,y:32711,varname:node_2449,prsc:2|IN-4328-OUT;n:type:ShaderForge.SFN_Add,id:8702,x:33330,y:32704,varname:node_8702,prsc:2|A-2449-OUT,B-8645-RGB;n:type:ShaderForge.SFN_Blend,id:3803,x:34068,y:33010,varname:node_3803,prsc:2,blmd:1,clmp:False|SRC-8645-RGB,DST-3166-RGB;n:type:ShaderForge.SFN_Multiply,id:3109,x:34271,y:33082,cmnt:Darkens the ambient,varname:node_3109,prsc:2|A-3803-OUT,B-3586-OUT;n:type:ShaderForge.SFN_Vector1,id:3586,x:34057,y:33176,varname:node_3586,prsc:2,v1:0.8;n:type:ShaderForge.SFN_Lerp,id:9089,x:34613,y:32990,cmnt:The final color with the shadows and the ambient tint applied to the shadows,varname:node_9089,prsc:2|A-3109-OUT,B-3704-OUT,T-6279-OUT;n:type:ShaderForge.SFN_Multiply,id:2434,x:31014,y:32446,varname:node_2434,prsc:2|A-3617-RGB,B-3076-OUT;n:type:ShaderForge.SFN_Divide,id:3076,x:30776,y:32503,varname:node_3076,prsc:2|A-7441-OUT,B-6369-OUT;n:type:ShaderForge.SFN_Vector1,id:6369,x:30561,y:32487,varname:node_6369,prsc:2,v1:1.2;n:type:ShaderForge.SFN_Color,id:8645,x:33035,y:32890,ptovrint:False,ptlb:_LushLODTreeAmbientColor,ptin:_LushLODTreeAmbientColor,cmnt:_LushLODTreeAmbientColor... this value is set in the manager,varname:_LushLODTreeAmbientColor_copy,prsc:2,glob:True,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,c1:0.5,c2:0.5,c3:0.5,c4:1;n:type:ShaderForge.SFN_Lerp,id:1092,x:33098,y:32228,cmnt:Lets the user adjust the tie of day correction,varname:node_1092,prsc:2|A-3262-OUT,B-1145-OUT,T-6234-OUT;n:type:ShaderForge.SFN_Vector1,id:3262,x:32851,y:32228,varname:node_3262,prsc:2,v1:1;n:type:ShaderForge.SFN_ValueProperty,id:6234,x:32851,y:32300,ptovrint:False,ptlb:LushLODTreeTimeOfDay,ptin:_LushLODTreeTimeOfDay,varname:node_5174,prsc:2,glob:True,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,v1:1;n:type:ShaderForge.SFN_Clamp,id:6279,x:34341,y:33520,cmnt:This lets the user adjust te maximum shadow. A value of 0.5 will limit it to half.,varname:node_6279,prsc:2|IN-9795-OUT,MIN-5352-OUT,MAX-2721-OUT;n:type:ShaderForge.SFN_Vector1,id:2721,x:34033,y:33614,varname:node_2721,prsc:2,v1:1;n:type:ShaderForge.SFN_OneMinus,id:5352,x:34111,y:33725,varname:node_5352,prsc:2|IN-6775-OUT;n:type:ShaderForge.SFN_ValueProperty,id:6775,x:33880,y:33729,ptovrint:False,ptlb:LushLODTreeShadowDarkness,ptin:_LushLODTreeShadowDarkness,varname:_LushLODTreeShadowDarkness,prsc:2,glob:True,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,v1:1;proporder:7344-3166-2469-6756;pass:END;sub:END;*/

Shader "Hidden/LushLODTree/HQTreeBark_SimpleShadows_Ultra" {
    Properties {
        _Transparency ("Transparency", Range(0, 1)) = 0
        _MainTex ("MainTex", 2D) = "white" {}
        _Cutoff ("Cutoff", Range(0, 1)) = 0.7
        _Color ("Color", Color) = (1,1,1,1)
        [HideInInspector]_Cutoff ("Alpha cutoff", Range(0,1)) = 0.5
    }
    SubShader {
        Tags {
            "Queue"="AlphaTest+51"
            "RenderType"="TransparentCutout"
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
			#ifndef UNITY_PASS_FORWARDBASE //<-- fixes really weird bug.
			#define UNITY_PASS_FORWARDBASE
			#endif
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
            float Check_If_Shadow_Pass2( float SHADOW_ALPHA_CLIP , float MAIN_ALPHA_CLIP ){
            #if defined(UNITY_PASS_SHADOWCASTER)
            	return SHADOW_ALPHA_CLIP;
            #else
            	return MAIN_ALPHA_CLIP;
            #endif
            }
            
            float BinaryDither4x4_FOR_SHADOW_PASS( float2 sceneUVs ){
            float4x4 mtx = float4x4(
            	float4(1, 9, 3, 11) / 17.0,
            	float4(13, 5, 15, 7) / 17.0,
            	float4(4, 12, 2, 10) / 17.0,
            	float4(16, 8, 14, 6) / 17.0
            );
            
            float2 px = floor(_ScreenParams.xy * sceneUVs);
            int xSmp = fmod(px.x, 4);
            int ySmp = fmod(px.y, 4);
            float4 xVec = 1 - saturate(abs(float4(0, 1, 2, 3) - xSmp));
            float4 yVec = 1 - saturate(abs(float4(0, 1, 2, 3) - ySmp));
            float4 pxMult = float4(dot(mtx[0], yVec), dot(mtx[1], yVec), dot(mtx[2], yVec), dot(mtx[3], yVec));
            return dot(pxMult, xVec);
            }
            
            float2 GimmeTextureUV_SHADOWPASS( float2 uvPos ){
            #if UNITY_UV_STARTS_AT_TOP
            	float grabSign = -_ProjectionParams.x;
            #else
            	float grabSign = _ProjectionParams.x;
            #endif
            return float2(1, grabSign)*uvPos.xy*0.5 + 0.5;
            }
            
            float Dither_FOR_SHADOW_PASS( float matrixIN , float cut_off , float trans ){
            float Coserp_Result = (1.0 - cos((trans*3.141592654*0.5))); //<-- same thing as Mathf.Coserp(), see Google. This helps fade in the leaves more gradually at first, instead of them appearing so suddenly.
            
            float rescaled2 = lerp(0.5, 1, Coserp_Result); //<-- rescales the transition to range from 0.5 to 1, instead of from 0 to 1, to trim a little wasted curve space off the beginning.
            float rescaled3 = lerp(0.5, 3, Coserp_Result); //<-- rescales the transition to range from 0.5 to 3, instead of from 0 to 1 -- this ensures the dithering is fully GONE when transparency is 1.
            float rescaled4 = lerp(rescaled2, rescaled3, trans); //<-- "rescaled2" helps bring the dithering in more slowly at first, but leaves some dithering still remaining. "rescaled3" remedies that.
            
            float dither = matrixIN + (rescaled4 - 1.5); //<-- calculates the dithering.
            return dither + 0.5; //<-- THIS FIRST CLIP is based on TEXTURE SPACE dithering. It is "chunky" in apperance. Leaves begin to appear in chunks in the center of the tree first, where leaves are the most dense.
            
            }
            
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
                float Param_Transparency = _Transparency;
                float ShadowClip = Dither_FOR_SHADOW_PASS( BinaryDither4x4_FOR_SHADOW_PASS( GimmeTextureUV_SHADOWPASS( i.uv0 ) ) , Param_Cutoff , Param_Transparency );
                float Dither = Dither_SMOOTHING( XYtest( sceneUVs.rg ) , Param_Cutoff );
                clip(Check_If_Shadow_Pass2( ShadowClip , Dither ) - 0.5);
////// Lighting:
                float4 _MainTex_var = tex2D(_MainTex,TRANSFORM_TEX(i.uv0, _MainTex));
                float3 LightIN = (_LushLODTreeMainLightCol.rgb*(_LushLODTreeMainLightIntensity/1.2));
                float3 LightDir = _LushLODTreeMainLightDir.rgb;
                float3 node_9089 = lerp(((_LushLODTreeAmbientColor.rgb*_MainTex_var.rgb)*0.8),(_MainTex_var.rgb*(LightIN+_LushLODTreeAmbientColor.rgb)),clamp(max(0,dot(i.normalDir,LightDir)),(1.0 - _LushLODTreeShadowDarkness),1.0)); // The final color with the shadows and the ambient tint applied to the shadows
                float3 node_8145 = _Color.rgb.rgb;
                float node_7170 = min(min(node_8145.r,node_8145.g),node_8145.b); // Finds how much LESS than WHITE the iput color is
                float node_4204 = 0.0;
                float node_4978 = 0.0;
                float node_4688 = 0.5*dot(viewDirection,LightDir)+0.5; // Check if view is opposite the direction of sunlight
                float Backside_Darkening = node_4688; // This value ranges from 0 to 0.2
                float TimeOfDayIntensity = lerp(1.0,saturate((node_4978 + ( (saturate((dot(float3(0,1,0),LightDir)+0.25)) - node_4204) * ((1.3+(Backside_Darkening*2.0)) - node_4978) ) / (1.0 - node_4204))),_LushLODTreeTimeOfDay); // This is an optional lighting adjustment you can remove this if your scene doesnt benefit from this
                float3 finalColor = (lerp((node_9089*_Color.rgb),lerp((_MainTex_var.rgb*_Color.rgb),node_9089,node_7170),(max(max(node_8145.r,node_8145.g),node_8145.b)-node_7170))*TimeOfDayIntensity);
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
			#ifndef UNITY_PASS_SHADOWCASTER //<-- fixes really weird bug.
			#define UNITY_PASS_SHADOWCASTER
			#endif
            #include "UnityCG.cginc"
            #include "Lighting.cginc"
            #pragma fragmentoption ARB_precision_hint_fastest
            #pragma multi_compile_shadowcaster
            #pragma multi_compile_fog
            #pragma target 3.0
            uniform float _Transparency;
            float Dither_SMOOTHING( float matrixIN , float cut_off ){
            float clipVal_PPE = matrixIN;
            
            return clipVal_PPE;
            }
            
            float XYtest( float2 screenUVs ){
            float2 px = floor(_ScreenParams.xy * screenUVs);
            return (fmod(px.x + px.y, 2) == 1) ? 0 : 1;//-0.45 : 1;
            }
            
            uniform float _Cutoff;
            float Check_If_Shadow_Pass2( float SHADOW_ALPHA_CLIP , float MAIN_ALPHA_CLIP ){
            #if defined(UNITY_PASS_SHADOWCASTER)
            	return SHADOW_ALPHA_CLIP;
            #else
            	return MAIN_ALPHA_CLIP;
            #endif
            }
            
            float BinaryDither4x4_FOR_SHADOW_PASS( float2 sceneUVs ){
            float4x4 mtx = float4x4(
            	float4(1, 9, 3, 11) / 17.0,
            	float4(13, 5, 15, 7) / 17.0,
            	float4(4, 12, 2, 10) / 17.0,
            	float4(16, 8, 14, 6) / 17.0
            );
            
            float2 px = floor(_ScreenParams.xy * sceneUVs);
            int xSmp = fmod(px.x, 4);
            int ySmp = fmod(px.y, 4);
            float4 xVec = 1 - saturate(abs(float4(0, 1, 2, 3) - xSmp));
            float4 yVec = 1 - saturate(abs(float4(0, 1, 2, 3) - ySmp));
            float4 pxMult = float4(dot(mtx[0], yVec), dot(mtx[1], yVec), dot(mtx[2], yVec), dot(mtx[3], yVec));
            return dot(pxMult, xVec);
            }
            
            float2 GimmeTextureUV_SHADOWPASS( float2 uvPos ){
            #if UNITY_UV_STARTS_AT_TOP
            	float grabSign = -_ProjectionParams.x;
            #else
            	float grabSign = _ProjectionParams.x;
            #endif
            return float2(1, grabSign)*uvPos.xy*0.5 + 0.5;
            }
            
            float Dither_FOR_SHADOW_PASS( float matrixIN , float cut_off , float trans ){
            float Coserp_Result = (1.0 - cos((trans*3.141592654*0.5))); //<-- same thing as Mathf.Coserp(), see Google. This helps fade in the leaves more gradually at first, instead of them appearing so suddenly.
            
            float rescaled2 = lerp(0.5, 1, Coserp_Result); //<-- rescales the transition to range from 0.5 to 1, instead of from 0 to 1, to trim a little wasted curve space off the beginning.
            float rescaled3 = lerp(0.5, 3, Coserp_Result); //<-- rescales the transition to range from 0.5 to 3, instead of from 0 to 1 -- this ensures the dithering is fully GONE when transparency is 1.
            float rescaled4 = lerp(rescaled2, rescaled3, trans); //<-- "rescaled2" helps bring the dithering in more slowly at first, but leaves some dithering still remaining. "rescaled3" remedies that.
            
            float dither = matrixIN + (rescaled4 - 1.5); //<-- calculates the dithering.
            return dither + 0.5; //<-- THIS FIRST CLIP is based on TEXTURE SPACE dithering. It is "chunky" in apperance. Leaves begin to appear in chunks in the center of the tree first, where leaves are the most dense.
            
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
            float4 frag(VertexOutput i) : COLOR {
                float2 sceneUVs = (i.projPos.xy / i.projPos.w);
                float Param_Cutoff = _Cutoff;
                float Param_Transparency = _Transparency;
                float ShadowClip = Dither_FOR_SHADOW_PASS( BinaryDither4x4_FOR_SHADOW_PASS( GimmeTextureUV_SHADOWPASS( i.uv0 ) ) , Param_Cutoff , Param_Transparency );
                float Dither = Dither_SMOOTHING( XYtest( sceneUVs.rg ) , Param_Cutoff );
                clip(Check_If_Shadow_Pass2( ShadowClip , Dither ) - 0.5);
                SHADOW_CASTER_FRAGMENT(i)
            }
            ENDCG
        }
    }
    CustomEditor "ShaderForgeMaterialInspector"
}
