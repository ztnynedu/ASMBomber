// Shader created with Shader Forge v1.38 
// Shader Forge (c) Neat Corporation / Joachim Holmer - http://www.acegikmo.com/shaderforge/
// Note: Manually altering this data may prevent you from opening it in Shader Forge
/*SF_DATA;ver:1.38;sub:START;pass:START;ps:flbk:,iptp:0,cusa:True,bamd:0,cgin:QwBHAEkAbgBjAGwAdQBkAGUAcwAvAEEAbgBnAHUAbABhAHIAQwBvAHIAcgBlAGMAdABpAG8AbgB8AEMARwBJAG4AYwBsAHUAZABlAHMALwBEAGkAdABoAGUAcgBpAG4AZwA=,lico:0,lgpr:1,limd:0,spmd:1,trmd:0,grmd:0,uamb:True,mssp:True,bkdf:False,hqlp:False,rprd:False,enco:False,rmgx:True,imps:True,rpth:0,vtps:0,hqsc:True,nrmq:1,nrsp:0,vomd:0,spxs:False,tesm:0,olmd:1,culm:2,bsrc:0,bdst:1,dpts:2,wrdp:True,dith:0,atcv:False,rfrpo:False,rfrpn:Refraction,coma:15,ufog:True,aust:False,igpj:False,qofs:51,qpre:2,rntp:3,fgom:False,fgoc:False,fgod:False,fgor:False,fgmd:0,fgcr:0.5,fgcg:0.5,fgcb:0.5,fgca:1,fgde:0.01,fgrn:0,fgrf:300,stcl:False,atwp:False,stva:128,stmr:255,stmw:255,stcp:6,stps:0,stfa:0,stfz:0,ofsf:0,ofsu:0,f2p0:False,fnsp:False,fnfb:True,fsmp:False;n:type:ShaderForge.SFN_Final,id:2865,x:35760,y:32188,varname:node_2865,prsc:2|custl-7856-OUT,clip-8508-OUT;n:type:ShaderForge.SFN_Tex2d,id:7736,x:31694,y:31519,ptovrint:False,ptlb:MainTex,ptin:_MainTex,varname:_MainTex,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,ntxv:0,isnm:False;n:type:ShaderForge.SFN_Slider,id:6832,x:30194,y:32305,ptovrint:False,ptlb:Transparency,ptin:_Transparency,varname:_Transparency,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,min:0,cur:1,max:1;n:type:ShaderForge.SFN_Slider,id:5916,x:30206,y:32205,ptovrint:False,ptlb:Cutoff,ptin:_Cutoff,varname:_Cutoff,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,min:0,cur:0.7,max:1;n:type:ShaderForge.SFN_Slider,id:1495,x:30206,y:32078,ptovrint:False,ptlb:ShadowTransparency,ptin:_ShadowTransparency,varname:_ShadowTransparency,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,min:0,cur:0,max:1;n:type:ShaderForge.SFN_ViewVector,id:628,x:30104,y:31399,varname:node_628,prsc:2;n:type:ShaderForge.SFN_Dot,id:1391,x:30310,y:31462,cmnt:Check if view is opposite the direction of sunlight,varname:node_1391,prsc:2,dt:4|A-628-OUT,B-2684-OUT;n:type:ShaderForge.SFN_Code,id:8508,x:34651,y:32790,cmnt:Shadow or Main Pass?,varname:node_8508,prsc:2,code:IwBpAGYAIABkAGUAZgBpAG4AZQBkACgAVQBOAEkAVABZAF8AUABBAFMAUwBfAFMASABBAEQATwBXAEMAQQBTAFQARQBSACkACgAJAHIAZQB0AHUAcgBuACAAUwBIAEEARABPAFcAXwBBAEwAUABIAEEAXwBDAEwASQBQADsACgAjAGUAbABzAGUACgAJAHIAZQB0AHUAcgBuACAATQBBAEkATgBfAEEATABQAEgAQQBfAEMATABJAFAAOwAKACMAZQBuAGQAaQBmAA==,output:0,fname:Check_If_Shadow_Pass2,width:340,height:128,input:0,input:0,input_1_label:SHADOW_ALPHA_CLIP,input_2_label:MAIN_ALPHA_CLIP|A-905-OUT,B-7769-OUT;n:type:ShaderForge.SFN_Set,id:3191,x:32151,y:31813,varname:TexAlpha,prsc:2|IN-3522-OUT;n:type:ShaderForge.SFN_Set,id:8286,x:30547,y:32320,varname:Param_Transparency_MAINPASS,prsc:2|IN-6832-OUT;n:type:ShaderForge.SFN_Set,id:7766,x:30547,y:32204,varname:Param_Cutoff,prsc:2|IN-5916-OUT;n:type:ShaderForge.SFN_Set,id:55,x:31154,y:33267,cmnt:Used to fade away billboards parallel to view,varname:Angular_Correction_MAINPASS,prsc:2|IN-5366-OUT;n:type:ShaderForge.SFN_RemapRange,id:694,x:30523,y:31504,cmnt:Rescales it to 0.7 to 1 multiplied by 0.75 which yields 0.525 to 0.75,varname:node_694,prsc:2,frmn:-1,frmx:1,tomn:0.525,tomx:0.75|IN-1391-OUT;n:type:ShaderForge.SFN_Set,id:7143,x:30547,y:32081,varname:Param_ShadowTrans_SHADOWPASS,prsc:2|IN-1495-OUT;n:type:ShaderForge.SFN_Set,id:6838,x:31444,y:32555,varname:DITHER_MAINPASS,prsc:2|IN-8485-OUT;n:type:ShaderForge.SFN_Set,id:47,x:31376,y:32847,varname:DITHER_SHADOWPASS,prsc:2|IN-5175-OUT;n:type:ShaderForge.SFN_Get,id:7769,x:34351,y:32847,varname:node_7769,prsc:2|IN-6838-OUT;n:type:ShaderForge.SFN_Set,id:4973,x:32015,y:31524,varname:MainTexIN,prsc:2|IN-7736-RGB;n:type:ShaderForge.SFN_Set,id:6719,x:30722,y:31546,cmnt:Darkens the billboards when viewed from the back side,varname:Backside_Darkening_Amount,prsc:2|IN-1391-OUT;n:type:ShaderForge.SFN_Set,id:7375,x:30779,y:31934,varname:Param_Color,prsc:2|IN-9349-OUT;n:type:ShaderForge.SFN_Code,id:6764,x:29906,y:32623,varname:node_6764,prsc:2,code:VABoAGUAIABjAG8AZABlACAAdABvACAAdABoAGUAIAByAGkAZwBoAHQAIABjAGEAbABjAHUAbABhAHQAZQBzACAAdAB3AG8ACgBkAGkAdABoAGUAcgBpAG4AZwAgAG0AYQB0AHIAaQB4AGUAcwAsACAAdwBoAGkAYwBoACAAYwBhAG4AIABiAGUACgB1AHMAZQBkACAAdABvACAAYQBsAHAAaABhACAAYwBsAGkAcAAgAGEAIABiAHUAbgBjAGgAIABvAGYAIABsAGkAdAB0AGwAZQAKAGgAbwBsAGUAcwAgAGkAbgAgAHQAaABlACAAbQBlAHMAaAAsACAAdABvACAAYwByAGUAYQB0AGUAIABhACAAcwBvAHIAdAAgAG8AZgAKAGYAYQBrAGUAIAB0AHIAYQBuAHMAcABhAHIAZQBuAGMAeQAuACAACgAKAEYAbwByACAAdABoAGUAIABzAGEAaABkAG8AdwAgAHAAYQBzAHMALAAgAHcAZQAgAHUAcwBlACAAVQBWACAAcwBwAGEAYwBlAAoAYwBvAG8AcgBkAGkAbgBhAHQAZQBzACAAdABvACAAZABlAHQAZQByAG0AaQBuAGUAIABoAG8AdwAgAG0AdQBjAGgACgBkAGkAcwB0AGEAbgBjAGUAIABpAHMAIABiAGUAdAB3AGUAZQBuACAAZQBhAGMAaAAgACIAaABvAGwAZQAiAC4AIABUAGgAaQBzAAoAYwBhAHUAcwBlAHMAIAB0AGgAZQAgAHMAaABhAGQAbwB3AHMAIAB0AG8AIABuAG8AdAAgACIAdAB3AGkAbgBrAGwAZQAiACAACgB3AGgAZQBuACAAeQBvAHUAIABtAG8AdgBlACAAdABoAGUAIABzAGMAcgBlAGUAbgAuAAoACgBGAG8AcgAgAHQAaABlACAAbQBhAGkAbgAgAHAAYQBzAHMALAAgAHcAZQAgAHUAcwBlACAAcwBjAHIAZQBlAG4AIABzAHAAYQBjAGUACgBVAFYAcwAgAHQAbwAgAGQAZQB0AGUAcgBtAGkAbgBlACAAdABoAGUAIABkAGkAcwB0AGEAbgBjAGUAIABiAGUAdAB3AGUAZQBuAAoAZQBhAGMAaAAgAGgAbwBsAGUAIABwAHUAbgBjAGgAZQBkAC4AIABBAG4AZAAgAHcAaABpAGwAZQAgAHQAaABpAHMAIABjAGEAbgAKAGMAcgBlAGEAdABlACAAYQAgAHQAdwBpAG4AawBsAGkAbgBnACAAZQBmAGYAZQBjAHQAIAB3AGgAZQBuACAAeQBvAHUAIAAKAG0AbwB2AGUAIAB0AGgAZQAgAHYAaQBlAHcAIABhAHIAbwB1AG4AZAAsACAAaQB0ACAAaABhAHMAIAB0AGgAZQAKAGIAZQBuAGUAZgBpAHQAIABvAGYAIABlAG4AcwB1AHIAaQBuAGcAIAB0AGgAYQB0ACAAeQBvAHUAIABzAGUAZQAgAEEATABMAAoAdABoAGUAIAB3AGEAeQAgAHQAaAByAG8AdQBnAGgAIAB0AGgAZQAgAG0AZQBzAGgALgA=,output:2,fname:DitheringInfo,width:343,height:302;n:type:ShaderForge.SFN_Multiply,id:9349,x:30568,y:31888,cmnt:Inputting 0.5 will multiply by 1 which has no effect. Less than 0.5 will darken from 0 to 1 and above 0.5 will brighten by multiplying from 1 to 2x.,varname:node_9349,prsc:2|A-5196-RGB,B-1948-OUT;n:type:ShaderForge.SFN_Vector1,id:1948,x:30363,y:31791,varname:node_1948,prsc:2,v1:2;n:type:ShaderForge.SFN_Color,id:5196,x:30363,y:31888,ptovrint:False,ptlb:Color,ptin:_Color,varname:_Color,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,c1:0.5,c2:0.5,c3:0.5,c4:1;n:type:ShaderForge.SFN_Set,id:3624,x:31243,y:30615,varname:LightIN,prsc:2|IN-3648-OUT;n:type:ShaderForge.SFN_Vector4Property,id:1476,x:30388,y:30943,ptovrint:False,ptlb:_LushLODTreeMainLightDir,ptin:_LushLODTreeMainLightDir,cmnt:The W is set via script in _LushLODTreesManager.cs,varname:node_8259,prsc:2,glob:True,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,v1:0.5,v2:0.5,v3:0.5,v4:1;n:type:ShaderForge.SFN_Color,id:5159,x:30388,y:30647,ptovrint:False,ptlb:LushLODTreeMainLightCol,ptin:_LushLODTreeMainLightCol,cmnt:This works even with lightmaps,varname:node_349,prsc:2,glob:True,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,c1:0.5,c2:0.5,c3:0.5,c4:1;n:type:ShaderForge.SFN_ValueProperty,id:3152,x:30388,y:30828,ptovrint:False,ptlb:LushLODTreeMainLightIntensity,ptin:_LushLODTreeMainLightIntensity,cmnt:This works even with lightmaps,varname:node_5384,prsc:2,glob:True,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,v1:1;n:type:ShaderForge.SFN_Set,id:3598,x:30695,y:30965,varname:LightDir,prsc:2|IN-1476-XYZ;n:type:ShaderForge.SFN_Dot,id:7605,x:31899,y:30908,cmnt:Is the sun above the horizon?,varname:node_7605,prsc:2,dt:0|A-3477-OUT,B-9675-OUT;n:type:ShaderForge.SFN_Get,id:9675,x:31666,y:30954,varname:node_9675,prsc:2|IN-3598-OUT;n:type:ShaderForge.SFN_Vector3,id:3477,x:31666,y:30841,cmnt:Checks if the light is shining straight down,varname:node_3477,prsc:2,v1:0,v2:1,v3:0;n:type:ShaderForge.SFN_Clamp01,id:7024,x:32463,y:30912,varname:node_7024,prsc:2|IN-5533-OUT;n:type:ShaderForge.SFN_Clamp01,id:4084,x:32927,y:30756,varname:node_4084,prsc:2|IN-4176-OUT;n:type:ShaderForge.SFN_Set,id:7369,x:33475,y:30855,cmnt:This is an optional lighting adjustment you can remove this if your scene doesnt benefit from this.,varname:TimeOfDayIntensity,prsc:2|IN-5727-OUT;n:type:ShaderForge.SFN_Add,id:5533,x:32278,y:30912,cmnt:This makes the trees not get dark until the sun is somewhat BELOW the horizon.,varname:node_5533,prsc:2|A-7605-OUT,B-7696-OUT;n:type:ShaderForge.SFN_Vector1,id:7696,x:32090,y:30946,varname:node_7696,prsc:2,v1:0.25;n:type:ShaderForge.SFN_RemapRangeAdvanced,id:4176,x:32726,y:30756,cmnt:Rescales it from 01 to about 03 to make it get brigher faster as the sun comes up. This effect is significantly stronger on the sunny side via backside darkening.,varname:node_4176,prsc:2|IN-7024-OUT,IMIN-1942-OUT,IMAX-2352-OUT,OMIN-4292-OUT,OMAX-1039-OUT;n:type:ShaderForge.SFN_Vector1,id:1942,x:32463,y:30607,varname:node_1942,prsc:2,v1:0;n:type:ShaderForge.SFN_Vector1,id:2352,x:32463,y:30656,varname:node_2352,prsc:2,v1:1;n:type:ShaderForge.SFN_Vector1,id:4292,x:32463,y:30711,varname:node_4292,prsc:2,v1:0;n:type:ShaderForge.SFN_Vector1,id:3524,x:32260,y:30667,varname:node_3524,prsc:2,v1:1.3;n:type:ShaderForge.SFN_Add,id:1039,x:32463,y:30761,varname:node_1039,prsc:2|A-3524-OUT,B-5703-OUT;n:type:ShaderForge.SFN_Get,id:1024,x:32083,y:30669,varname:node_1024,prsc:2|IN-6719-OUT;n:type:ShaderForge.SFN_Multiply,id:5703,x:32260,y:30733,varname:node_5703,prsc:2|A-1024-OUT,B-7717-OUT;n:type:ShaderForge.SFN_Vector1,id:7717,x:32083,y:30752,varname:node_7717,prsc:2,v1:2;n:type:ShaderForge.SFN_Get,id:2684,x:30083,y:31539,varname:node_2684,prsc:2|IN-3598-OUT;n:type:ShaderForge.SFN_ViewVector,id:5642,x:30273,y:33271,varname:node_5642,prsc:2;n:type:ShaderForge.SFN_ViewReflectionVector,id:1991,x:30273,y:33149,varname:node_1991,prsc:2;n:type:ShaderForge.SFN_Code,id:5366,x:30727,y:33212,cmnt:Note GetAngularCorrection is in AngularCorrection.cginc,varname:node_5366,prsc:2,code:cgBlAHQAdQByAG4AIABHAGUAdABBAG4AZwB1AGwAYQByAEMAbwByAHIAZQBjAHQAaQBvAG4ACgAJACgACQAKAAkACQBWAGkAZQB3AFIAZQBmACwACgAJAAkAVgBpAGUAdwBEAGkAcgBlAGMACgAJACkAOwA=,output:0,fname:GetAngularCorrection_Caller,width:338,height:134,input:2,input:2,input_1_label:ViewRef,input_2_label:ViewDirec|A-1991-OUT,B-5642-OUT;n:type:ShaderForge.SFN_Code,id:3522,x:31834,y:31758,varname:node_3522,prsc:2,code:YwBsAGkAcAAoAFQAZQB4AEEAbABwAGgAYQAgAC0AIABDAHUAdABvAGYAZgApADsACgByAGUAdAB1AHIAbgAgAFQAZQB4AEEAbABwAGgAYQA7AA==,output:0,fname:ClipMe,width:247,height:112,input:0,input:0,input_1_label:TexAlpha,input_2_label:Cutoff|A-7736-A,B-8371-OUT;n:type:ShaderForge.SFN_Get,id:8371,x:31592,y:31793,varname:node_8371,prsc:2|IN-7766-OUT;n:type:ShaderForge.SFN_TexCoord,id:5775,x:30442,y:32779,varname:node_5775,prsc:2,uv:0,uaff:False;n:type:ShaderForge.SFN_Code,id:8485,x:30755,y:32555,varname:node_8485,prsc:2,code:cgBlAHQAdQByAG4AIABHAGUAdABBAG4AZwB1AGwAYQByAFcAaQB0AGgAVAByAGEAbgBzAHAAYQByAGUAbgBjAHkAXwBNAEEASQBOAFAAQQBTAFMAKABTAGMAcgBlAGUAbgBQAG8AcwAsACAAVAByAGEAbgBzAHAAYQByAGUAbgBjAHkALAAgAEEAbgBnAHUAbABhAHIAQwBvAHIAcgBlAGMAdABpAG8AbgApADsA,output:0,fname:AngularWithTransparency_Caller,width:595,height:112,input:1,input:0,input:0,input_1_label:ScreenPos,input_2_label:AngularCorrection,input_3_label:Transparency|A-7047-UVOUT,B-2329-OUT,C-1160-OUT;n:type:ShaderForge.SFN_Get,id:2329,x:30436,y:32635,varname:node_2329,prsc:2|IN-55-OUT;n:type:ShaderForge.SFN_ScreenPos,id:7047,x:30457,y:32482,varname:node_7047,prsc:2,sctp:0;n:type:ShaderForge.SFN_Get,id:1160,x:30436,y:32688,varname:node_1160,prsc:2|IN-8286-OUT;n:type:ShaderForge.SFN_Code,id:5175,x:30740,y:32843,varname:node_5175,prsc:2,code:cgBlAHQAdQByAG4AIABHAGUAdABEAGkAdABoAGUAcgBTAGgAYQBkAG8AdwBzAF8AUwBIAEEARABPAFcAUABBAFMAUwAoAFUAVgAwAF8ASQBOACwAIABUAHIAYQBuAHMAcABhAHIAZQBuAGMAeQApADsA,output:0,fname:GetDitherShadows_Caller,width:529,height:128,input:1,input:0,input_1_label:UV0_IN,input_2_label:Transparency|A-5775-UVOUT,B-7961-OUT;n:type:ShaderForge.SFN_Get,id:7961,x:30421,y:32927,varname:node_7961,prsc:2|IN-7143-OUT;n:type:ShaderForge.SFN_Get,id:6100,x:33987,y:32851,varname:node_6100,prsc:2|IN-47-OUT;n:type:ShaderForge.SFN_Get,id:3798,x:33987,y:32791,cmnt:Attaching this forces ClipME to run in both passes,varname:node_3798,prsc:2|IN-3191-OUT;n:type:ShaderForge.SFN_Min,id:905,x:34212,y:32791,varname:node_905,prsc:2|A-3798-OUT,B-6100-OUT;n:type:ShaderForge.SFN_Multiply,id:3648,x:31042,y:30615,varname:node_3648,prsc:2|A-5159-RGB,B-4099-OUT;n:type:ShaderForge.SFN_Divide,id:4099,x:30814,y:30703,varname:node_4099,prsc:2|A-3152-OUT,B-8705-OUT;n:type:ShaderForge.SFN_Vector1,id:8705,x:30561,y:30713,varname:node_8705,prsc:2,v1:1.2;n:type:ShaderForge.SFN_Get,id:4081,x:32362,y:32197,cmnt:The main texture color with some modifications for things like seams blending.,varname:node_4081,prsc:2|IN-4973-OUT;n:type:ShaderForge.SFN_Get,id:1262,x:32191,y:32493,cmnt:The color of the main diretional light,varname:node_1262,prsc:2|IN-3624-OUT;n:type:ShaderForge.SFN_Get,id:1279,x:32655,y:33042,cmnt:The shadows value,varname:node_1279,prsc:2|IN-6719-OUT;n:type:ShaderForge.SFN_Get,id:790,x:34158,y:32207,varname:node_790,prsc:2|IN-7369-OUT;n:type:ShaderForge.SFN_Add,id:6430,x:32508,y:32515,varname:node_6430,prsc:2|A-1262-OUT,B-2783-RGB;n:type:ShaderForge.SFN_Multiply,id:9489,x:32768,y:32458,cmnt:The final texture color with all lights but no shadows yet,varname:node_9489,prsc:2|A-4081-OUT,B-6430-OUT;n:type:ShaderForge.SFN_Lerp,id:9122,x:33373,y:32642,cmnt:The final color with the shadows and ambient tint applied to the shadows,varname:node_9122,prsc:2|A-7732-OUT,B-9489-OUT,T-795-OUT;n:type:ShaderForge.SFN_Multiply,id:7732,x:33002,y:32829,varname:node_7732,prsc:2|A-833-OUT,B-6263-OUT;n:type:ShaderForge.SFN_Blend,id:833,x:32790,y:32750,cmnt:The color of the shadow is based entirely off the texture color and the ambient light color,varname:node_833,prsc:2,blmd:1,clmp:False|SRC-2783-RGB,DST-4081-OUT;n:type:ShaderForge.SFN_Vector1,id:6263,x:32764,y:32925,varname:node_6263,prsc:2,v1:0.8;n:type:ShaderForge.SFN_Get,id:1539,x:32859,y:32241,varname:node_1539,prsc:2|IN-7375-OUT;n:type:ShaderForge.SFN_Max,id:6431,x:33373,y:32310,cmnt:Finds the highest input color value,varname:node_6431,prsc:2|A-9506-R,B-9506-G,C-9506-B;n:type:ShaderForge.SFN_Min,id:7900,x:33373,y:32468,cmnt:Finds how much LESS than WHITE the input color is,varname:node_7900,prsc:2|A-9506-R,B-9506-G,C-9506-B;n:type:ShaderForge.SFN_ComponentMask,id:9506,x:33074,y:32241,cmnt:The input color,varname:node_9506,prsc:2,cc1:0,cc2:1,cc3:2,cc4:-1|IN-1539-OUT;n:type:ShaderForge.SFN_Multiply,id:7292,x:33401,y:32001,cmnt:The input color multiplied by the texture color to give the input color a texture so that it doesnt look flat,varname:node_7292,prsc:2|A-4081-OUT,B-9506-OUT;n:type:ShaderForge.SFN_Multiply,id:2850,x:33731,y:32229,cmnt:Darkens the final color based on the input ccolor,varname:node_2850,prsc:2|A-9122-OUT,B-9506-OUT;n:type:ShaderForge.SFN_Lerp,id:2502,x:33741,y:32027,cmnt:Lerps towards the input color based on how much the input color is LESS than WHITE,varname:node_2502,prsc:2|A-7292-OUT,B-9122-OUT,T-7900-OUT;n:type:ShaderForge.SFN_Subtract,id:2234,x:33902,y:32375,cmnt:Finds the difference between the highest and lowest color value. This is used to detect if our iput color is simply a shade of grey and has no color,varname:node_2234,prsc:2|A-6431-OUT,B-7900-OUT;n:type:ShaderForge.SFN_Lerp,id:8407,x:34179,y:32076,varname:node_8407,prsc:2|A-2850-OUT,B-2502-OUT,T-2234-OUT;n:type:ShaderForge.SFN_Multiply,id:7856,x:34512,y:32116,varname:node_7856,prsc:2|A-8407-OUT,B-790-OUT;n:type:ShaderForge.SFN_Clamp,id:795,x:32963,y:33044,cmnt:This lets the user adjust te maximum shadow. A value of 0.5 will limit it to half.,varname:node_795,prsc:2|IN-1279-OUT,MIN-1829-OUT,MAX-6415-OUT;n:type:ShaderForge.SFN_Vector1,id:6415,x:32655,y:33138,varname:node_6415,prsc:2,v1:1;n:type:ShaderForge.SFN_ValueProperty,id:4220,x:32534,y:33249,ptovrint:False,ptlb:_LushLODTreeShadowDarkness,ptin:_LushLODTreeShadowDarkness,cmnt:_LusLODSadowDarkness... this is cotrolled by the manager in its Update function,varname:node_2612,prsc:2,glob:True,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,v1:1;n:type:ShaderForge.SFN_OneMinus,id:1829,x:32733,y:33249,varname:node_1829,prsc:2|IN-4220-OUT;n:type:ShaderForge.SFN_Lerp,id:5727,x:33245,y:30819,cmnt:Lets the user adjust the tie of day correction,varname:node_5727,prsc:2|A-9315-OUT,B-4084-OUT,T-5174-OUT;n:type:ShaderForge.SFN_Vector1,id:9315,x:32995,y:30874,varname:node_9315,prsc:2,v1:1;n:type:ShaderForge.SFN_ValueProperty,id:5174,x:32995,y:30946,ptovrint:False,ptlb:LushLODTreeTimeOfDay,ptin:_LushLODTreeTimeOfDay,varname:node_5174,prsc:2,glob:True,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,v1:1;n:type:ShaderForge.SFN_Color,id:2783,x:32245,y:32697,ptovrint:False,ptlb:_LushLODTreeAmbientColor,ptin:_LushLODTreeAmbientColor,cmnt:_LushLODTreeAmbientColor... this value is set in the manager,varname:_LushLODTreeAmbientColor_copy,prsc:2,glob:True,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,c1:0.5,c2:0.5,c3:0.5,c4:1;proporder:6832-5916-1495-5196-7736;pass:END;sub:END;*/

Shader "Hidden/LushLODTree/Tree_Leaves3" {
    Properties {
        _Transparency ("Transparency", Range(0, 1)) = 1
        _Cutoff ("Cutoff", Range(0, 1)) = 0.7
        _ShadowTransparency ("ShadowTransparency", Range(0, 1)) = 0
        _Color ("Color", Color) = (0.5,0.5,0.5,1)
        _MainTex ("MainTex", 2D) = "white" {}
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
            #include "CGIncludes/AngularCorrection.cginc"
            #include "CGIncludes/Dithering.cginc"
            #pragma multi_compile_fwdbase_fullshadows
            #pragma multi_compile_fog
            #pragma target 3.0
            uniform sampler2D _MainTex; uniform float4 _MainTex_ST;
            uniform float _Transparency;
            uniform float _Cutoff;
            uniform float _ShadowTransparency;
            float Check_If_Shadow_Pass2( float SHADOW_ALPHA_CLIP , float MAIN_ALPHA_CLIP ){
            #if defined(UNITY_PASS_SHADOWCASTER)
            	return SHADOW_ALPHA_CLIP;
            #else
            	return MAIN_ALPHA_CLIP;
            #endif
            }
            
            uniform float4 _Color;
            uniform float4 _LushLODTreeMainLightDir;
            uniform float4 _LushLODTreeMainLightCol;
            uniform float _LushLODTreeMainLightIntensity;
            float GetAngularCorrection_Caller( float3 ViewRef , float3 ViewDirec ){
            return GetAngularCorrection
            	(	
            		ViewRef,
            		ViewDirec
            	);
            }
            
            float ClipMe( float TexAlpha , float Cutoff ){
            clip(TexAlpha - Cutoff);
            return TexAlpha;
            }
            
            float AngularWithTransparency_Caller( float2 ScreenPos , float AngularCorrection , float Transparency ){
            return GetAngularWithTransparency_MAINPASS(ScreenPos, Transparency, AngularCorrection);
            }
            
            float GetDitherShadows_Caller( float2 UV0_IN , float Transparency ){
            return GetDitherShadows_SHADOWPASS(UV0_IN, Transparency);
            }
            
            uniform float _LushLODTreeShadowDarkness;
            uniform float _LushLODTreeTimeOfDay;
            uniform float4 _LushLODTreeAmbientColor;
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
            float4 frag(VertexOutput i, float facing : VFACE) : COLOR {
                float isFrontFace = ( facing >= 0 ? 1 : 0 );
                float faceSign = ( facing >= 0 ? 1 : -1 );
                i.normalDir = normalize(i.normalDir);
                i.normalDir *= faceSign;
                float3 viewDirection = normalize(_WorldSpaceCameraPos.xyz - i.posWorld.xyz);
                float3 normalDirection = i.normalDir;
                float3 viewReflectDirection = reflect( -viewDirection, normalDirection );
                float2 sceneUVs = (i.projPos.xy / i.projPos.w);
                float4 _MainTex_var = tex2D(_MainTex,TRANSFORM_TEX(i.uv0, _MainTex));
                float Param_Cutoff = _Cutoff;
                float TexAlpha = ClipMe( _MainTex_var.a , Param_Cutoff );
                float Param_ShadowTrans_SHADOWPASS = _ShadowTransparency;
                float DITHER_SHADOWPASS = GetDitherShadows_Caller( i.uv0 , Param_ShadowTrans_SHADOWPASS );
                float Angular_Correction_MAINPASS = GetAngularCorrection_Caller( viewReflectDirection , viewDirection ); // Used to fade away billboards parallel to view
                float Param_Transparency_MAINPASS = _Transparency;
                float DITHER_MAINPASS = AngularWithTransparency_Caller( (sceneUVs * 2 - 1).rg , Angular_Correction_MAINPASS , Param_Transparency_MAINPASS );
                clip(Check_If_Shadow_Pass2( min(TexAlpha,DITHER_SHADOWPASS) , DITHER_MAINPASS ) - 0.5);
////// Lighting:
                float3 MainTexIN = _MainTex_var.rgb;
                float3 node_4081 = MainTexIN; // The main texture color with some modifications for things like seams blending.
                float3 LightIN = (_LushLODTreeMainLightCol.rgb*(_LushLODTreeMainLightIntensity/1.2));
                float3 LightDir = _LushLODTreeMainLightDir.rgb;
                float node_1391 = 0.5*dot(viewDirection,LightDir)+0.5; // Check if view is opposite the direction of sunlight
                float Backside_Darkening_Amount = node_1391; // Darkens the billboards when viewed from the back side
                float3 node_9122 = lerp(((_LushLODTreeAmbientColor.rgb*node_4081)*0.8),(node_4081*(LightIN+_LushLODTreeAmbientColor.rgb)),clamp(Backside_Darkening_Amount,(1.0 - _LushLODTreeShadowDarkness),1.0)); // The final color with the shadows and ambient tint applied to the shadows
                float3 Param_Color = (_Color.rgb*2.0);
                float3 node_9506 = Param_Color.rgb; // The input color
                float node_7900 = min(min(node_9506.r,node_9506.g),node_9506.b); // Finds how much LESS than WHITE the input color is
                float node_1942 = 0.0;
                float node_4292 = 0.0;
                float TimeOfDayIntensity = lerp(1.0,saturate((node_4292 + ( (saturate((dot(float3(0,1,0),LightDir)+0.25)) - node_1942) * ((1.3+(Backside_Darkening_Amount*2.0)) - node_4292) ) / (1.0 - node_1942))),_LushLODTreeTimeOfDay); // This is an optional lighting adjustment you can remove this if your scene doesnt benefit from this.
                float3 finalColor = (lerp((node_9122*node_9506),lerp((node_4081*node_9506),node_9122,node_7900),(max(max(node_9506.r,node_9506.g),node_9506.b)-node_7900))*TimeOfDayIntensity);
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
            #include "CGIncludes/AngularCorrection.cginc"
            #include "CGIncludes/Dithering.cginc"
            #pragma fragmentoption ARB_precision_hint_fastest
            #pragma multi_compile_shadowcaster
            #pragma multi_compile_fog
            #pragma target 3.0
            uniform sampler2D _MainTex; uniform float4 _MainTex_ST;
            uniform float _Transparency;
            uniform float _Cutoff;
            uniform float _ShadowTransparency;
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
            
            float ClipMe( float TexAlpha , float Cutoff ){
            clip(TexAlpha - Cutoff);
            return TexAlpha;
            }
            
            float AngularWithTransparency_Caller( float2 ScreenPos , float AngularCorrection , float Transparency ){
            return GetAngularWithTransparency_MAINPASS(ScreenPos, Transparency, AngularCorrection);
            }
            
            float GetDitherShadows_Caller( float2 UV0_IN , float Transparency ){
            return GetDitherShadows_SHADOWPASS(UV0_IN, Transparency);
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
                float4 _MainTex_var = tex2D(_MainTex,TRANSFORM_TEX(i.uv0, _MainTex));
                float Param_Cutoff = _Cutoff;
                float TexAlpha = ClipMe( _MainTex_var.a , Param_Cutoff );
                float Param_ShadowTrans_SHADOWPASS = _ShadowTransparency;
                float DITHER_SHADOWPASS = GetDitherShadows_Caller( i.uv0 , Param_ShadowTrans_SHADOWPASS );
                float Angular_Correction_MAINPASS = GetAngularCorrection_Caller( viewReflectDirection , viewDirection ); // Used to fade away billboards parallel to view
                float Param_Transparency_MAINPASS = _Transparency;
                float DITHER_MAINPASS = AngularWithTransparency_Caller( (sceneUVs * 2 - 1).rg , Angular_Correction_MAINPASS , Param_Transparency_MAINPASS );
                clip(Check_If_Shadow_Pass2( min(TexAlpha,DITHER_SHADOWPASS) , DITHER_MAINPASS ) - 0.5);
                SHADOW_CASTER_FRAGMENT(i)
            }
            ENDCG
        }
    }
    CustomEditor "ShaderForgeMaterialInspector"
}
