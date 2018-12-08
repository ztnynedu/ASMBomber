// Shader created with Shader Forge v1.38 
// Shader Forge (c) Neat Corporation / Joachim Holmer - http://www.acegikmo.com/shaderforge/
// Note: Manually altering this data may prevent you from opening it in Shader Forge
/*SF_DATA;ver:1.38;sub:START;pass:START;ps:flbk:,iptp:0,cusa:True,bamd:0,cgin:QwBHAEkAbgBjAGwAdQBkAGUAcwAvAFMAZQBhAG0AcwBCAGwAZQBuAGQAaQBuAGcAXwBBAG4AZwB1AGwAYQByAHwAQwBHAEkAbgBjAGwAdQBkAGUAcwAvAFcAbwByAGwAZABQAG8AcwBpAHQAaQBvAG4AQwBlAG4AdABlAHIAfABDAEcASQBuAGMAbAB1AGQAZQBzAC8AQQBuAGcAdQBsAGEAcgBDAG8AcgByAGUAYwB0AGkAbwBuAHwAQwBHAEkAbgBjAGwAdQBkAGUAcwAvAEQAaQB0AGgAZQByAGkAbgBnAA==,lico:0,lgpr:1,limd:0,spmd:1,trmd:0,grmd:0,uamb:True,mssp:True,bkdf:False,hqlp:False,rprd:False,enco:False,rmgx:True,imps:True,rpth:0,vtps:0,hqsc:True,nrmq:1,nrsp:0,vomd:0,spxs:False,tesm:0,olmd:1,culm:2,bsrc:0,bdst:1,dpts:2,wrdp:True,dith:0,atcv:False,rfrpo:False,rfrpn:Refraction,coma:15,ufog:True,aust:False,igpj:False,qofs:51,qpre:2,rntp:3,fgom:False,fgoc:False,fgod:False,fgor:False,fgmd:0,fgcr:0.5657439,fgcg:0.6941743,fgcb:0.8014706,fgca:1,fgde:0.01,fgrn:0,fgrf:300,stcl:True,atwp:False,stva:191,stmr:255,stmw:255,stcp:6,stps:2,stfa:0,stfz:0,ofsf:0,ofsu:0,f2p0:False,fnsp:False,fnfb:True,fsmp:False;n:type:ShaderForge.SFN_Final,id:2865,x:36155,y:31555,varname:node_2865,prsc:2|custl-4392-OUT,alpha-1749-OUT,clip-8508-OUT;n:type:ShaderForge.SFN_Color,id:6665,x:30065,y:31532,ptovrint:False,ptlb:Color,ptin:_Color,varname:_Color,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,c1:0.5019608,c2:0.5019608,c3:0.5019608,c4:1;n:type:ShaderForge.SFN_Tex2d,id:7736,x:31161,y:31777,varname:node_3116_MAINPASS,prsc:2,ntxv:0,isnm:False|TEX-6298-TEX;n:type:ShaderForge.SFN_Slider,id:5916,x:29921,y:31839,ptovrint:False,ptlb:Cutoff,ptin:_Cutoff,varname:_Cutoff,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,min:0,cur:0.7,max:1;n:type:ShaderForge.SFN_Tex2dAsset,id:6298,x:30572,y:31828,ptovrint:False,ptlb:MainTex,ptin:_MainTex,varname:_MainTex,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,ntxv:0,isnm:False;n:type:ShaderForge.SFN_ViewVector,id:628,x:30255,y:30973,varname:node_628,prsc:2;n:type:ShaderForge.SFN_Dot,id:1391,x:30461,y:31036,cmnt:Check if view is opposite the direction of sunlight,varname:node_1391,prsc:2,dt:4|A-628-OUT,B-7517-OUT;n:type:ShaderForge.SFN_Code,id:8508,x:35267,y:32577,cmnt:Shadow or Main Pass?,varname:node_8508,prsc:2,code:IwBpAGYAIABkAGUAZgBpAG4AZQBkACgAVQBOAEkAVABZAF8AUABBAFMAUwBfAFMASABBAEQATwBXAEMAQQBTAFQARQBSACkACgAJAHIAZQB0AHUAcgBuACAAUwBIAEEARABPAFcAXwBBAEwAUABIAEEAXwBDAEwASQBQADsACgAjAGUAbABzAGUACgAJAHIAZQB0AHUAcgBuACAATQBBAEkATgBfAEEATABQAEgAQQBfAEMATABJAFAAOwAKACMAZQBuAGQAaQBmAA==,output:0,fname:Check_If_Shadow_Pass2,width:340,height:128,input:0,input:0,input_1_label:SHADOW_ALPHA_CLIP,input_2_label:MAIN_ALPHA_CLIP|A-8572-OUT,B-8233-OUT;n:type:ShaderForge.SFN_Set,id:3191,x:31775,y:31860,varname:TexAlpha,prsc:2|IN-7534-OUT;n:type:ShaderForge.SFN_Set,id:7766,x:30262,y:31838,varname:Param_Cutoff,prsc:2|IN-5916-OUT;n:type:ShaderForge.SFN_Set,id:55,x:29438,y:32370,cmnt:Used to fade away billboards parallel to view,varname:Angular_Correction_MAINPASS,prsc:2|IN-339-OUT;n:type:ShaderForge.SFN_Set,id:4973,x:31383,y:31777,varname:MainTexIN,prsc:2|IN-7736-RGB;n:type:ShaderForge.SFN_Tex2d,id:4547,x:30957,y:32191,cmnt:Color and alpha from UV3 is used by the horizontal plane to draw the Line Z and part of the circle,varname:node_3117_MAINPASS,prsc:2,ntxv:0,isnm:False|UVIN-327-UVOUT,TEX-6298-TEX;n:type:ShaderForge.SFN_TexCoord,id:327,x:30728,y:32196,varname:node_327,prsc:2,uv:2,uaff:False;n:type:ShaderForge.SFN_Set,id:9204,x:31358,y:32195,varname:UV3ColorIN,prsc:2|IN-3567-OUT;n:type:ShaderForge.SFN_Tex2d,id:9956,x:30957,y:32005,cmnt:Color and alpha from UV4 is used by all three planes to draw all or parts of their circlecrosses,varname:node_3118_MAINPASS,prsc:2,ntxv:0,isnm:False|UVIN-3765-UVOUT,TEX-6298-TEX;n:type:ShaderForge.SFN_TexCoord,id:3765,x:30728,y:32018,varname:node_3765,prsc:2,uv:3,uaff:False;n:type:ShaderForge.SFN_Set,id:1759,x:31346,y:32001,varname:UV4ColorIN,prsc:2|IN-9659-OUT;n:type:ShaderForge.SFN_Set,id:6719,x:30863,y:31132,cmnt:Darkens the trees when viewed from the back side.,varname:Backside_Darkening_Amount,prsc:2|IN-1391-OUT;n:type:ShaderForge.SFN_Set,id:7375,x:30443,y:31530,varname:Param_Color,prsc:2|IN-2327-OUT;n:type:ShaderForge.SFN_Set,id:4895,x:29441,y:31201,varname:FinalColor_Corrected,prsc:2|IN-1320-OUT;n:type:ShaderForge.SFN_Set,id:6116,x:29441,y:31965,varname:WorldPosCenter,prsc:2|IN-7818-OUT;n:type:ShaderForge.SFN_Code,id:9670,x:30341,y:32038,varname:node_9670,prsc:2,code:VABoAGUAIABjAG8AZABlACAAdABvACAAdABoAGUAIAByAGkAZwBoAHQAIABnAGUAdABzACAAdABoAGUAIABwAGkAeABlAGwACgBjAG8AbABvAHIAIABmAHIAbwBtACAAdABoAGUAIABVAFYAMwAgAGEAbgBkACAAVQBWADQALgAgAFQAaABlAHMAZQAgAFUAVgBzAAoAdwBlAHIAZQAgAGMAYQBsAGMAdQBsAGEAdABlAGQAIABlAHgAcAByAGUAcwBzAGwAeQAgAGIAeQAgAHQAaABlAAoATAB1AHMAaABMAE8ARABUAHIAZQBlAEMAbwBuAHYAZQByAHQAZQByAC4AYwBzACAAcwBjAHIAaQBwAHQAIAB3AGgAZQBuAAoAdABoAGUAIABiAGkAbABsAGIAbwBhAHIAZAAgAG0AZQBzAGgAIAB3AGEAcwAgAGMAcgBlAGEAdABlAGQALgAgAFQAaABlAHkACgBjAG8AbgB0AGEAaQBuACAAdABoAGkAbgAgAGwAaQBuAGUAcwAgACgAMQAgAHAAaQB4AGUAbAAgAHQAaABpAGMAawApAAoAYQBjAHIAbwBzAHMAIAB0AGgAZQAgAG0AZQBzAGgAIABwAGwAYQBuAGUAcwAgAGEAdAAgAHQAaABlACAAdgBhAHIAaQBvAHUAcwAKAGkAbgB0AGUAcgBzAGUAYwB0AGkAbwBuAHMALAAgAGEAbgBkACAAYQByAGUAIAB1AHMAZQBkACAAdABvACAAcABhAHMAcwAKAHQAaABlACAAYwBvAGwAbwByACAAbwBmACAAbwBuAGUAIABwAGwAYQBuAGUAIABvAHYAZQByACAAdABvACAAdABoAGUACgBvAHQAaABlAHIAIABwAGwAYQBuAGUALAAgAHMAbwAgAHQAaABhAHQAIABlAGEAYwBoACAAcABsAGEAbgBlACAAYwBhAG4ACgBiAGwAZQBuAGQAIAB3AGkAdABoACAAdABoAGUAIABvAHQAaABlAHIALgAKAAoAVABoAGUAIABIAG8AcgBpAHoAbwBuAHQAYQBsACAAcABsAGEAbgBlACAAaQBuAHQAZQByAHMAZQBjAHQAcwAgAGEAbgBkAAoAYgBsAGUAbgBkAHMAIAB3AGkAdABoACAAYgBvAHQAaAAgAHQAaABlACAARgBPAFIAVwBBAFIARAAgAGEAbgBkACAAUgBJAEcASABUAAoAcABsAGEAbgBlAHMALgAgAFQAaAB1AHMALAAgAGkAdAAgAGIAbABlAG4AZABzACAAdQBzAGkAbgBnACAAdAB3AG8AIABsAGkAbgBlAHMALAAgAAoAdwBpAHQAaAAgAG8AbgBlACAAbABpAG4AZQAgAGEAbABvAG4AZwAgAGUAYQBjAGgAIABvAGYAIAB0AGgAbwBzAGUACgBlAGQAZwBlAHMALgAgAFQAaABlACAAcABpAHgAZQBsAHMAIABmAG8AcgAgAHQAaABvAHMAZQAgAGwAaQBuAGUAcwAgAGEAcgBlAAoAcwBhAHYAZQBkACAAaQBuACAAVQBWADMAIABhAG4AZAAgAFUAVgA0ACAAcgBlAHMAcABlAGMAdABpAHYAZQBsAHkALgAKAAoARgBvAHIAIAB0AGgAZQAgAEYATwBSAFcAQQBSAEQAIABhAG4AZAAgAFIASQBHAEgAVAAgAHAAbABhAG4AZQBzACwAIAB0AGgAZQB5AAoAYgBsAGUAbgBkACAAbwBuAGwAeQAgAHcAaQB0AGgAIAB0AGgAZQAgAGgAbwByAGkAegBvAG4AdABhAGwAIABwAGwAYQBuAGUALAAKAGEAbgBkACAAdABoAHUAcwAgAHQAaABlAHkAIABvAG4AbAB5ACAAZAByAGEAdwAgAG8AbgBlACAAbABpAG4AZQAuACAAQQBuAGQACgBlAHYAZQBuACAAdABoAG8AdQBnAGgAIAB0AGgAbwBzAGUAIABsAGkAbgBlAHMAIABnAG8AIABkAGkAZgBmAGUAcgBlAG4AdAAKAGQAaQByAGUAYwB0AGkAbwBuAHMALAAgAEkAIAB3AGEAcwAgAGEAYgBsAGUAIAB0AG8AIABzAGEAdgBlACAAYQBsAGwACgB0AGgAYQB0ACAAZABhAHQAYQAgAGkAbgB0AG8AIABqAHUAcwB0ACAAVQBWADQAIABmAG8AcgAgAHQAaABlAGkAcgAgAHUAcwBlAC4A,output:2,fname:UV3_and_UV4,width:322,height:384;n:type:ShaderForge.SFN_Get,id:8572,x:34937,y:32558,varname:node_8572,prsc:2|IN-3191-OUT;n:type:ShaderForge.SFN_Set,id:5415,x:29000,y:30356,cmnt:A number identifying which plane this is,varname:PlaneNumber,prsc:2|IN-1192-OUT;n:type:ShaderForge.SFN_Code,id:7485,x:27333,y:30387,varname:node_7485,prsc:2,code:VABoAGUAIABjAG8AZABlACAAdABvACAAdABoAGUAIAByAGkAZwBoAHQAIABmAGkAZwB1AHIAZQBzACAAbwB1AHQACgB3AGgAaQBjAGgAIABwAGwAYQBuAGUAIAB0AGgAZQAgAHMAaABhAGQAZQByACAAaQBzACAAdwBvAHIAawBpAG4AZwAgAG8AbgAKAHIAaQBnAGgAdAAgAG4AbwB3AC4AIABUAG8AIABmAGkAZwB1AHIAZQAgAHQAaABpAHMAIABvAHUAdAAgAHcAaQB0AGgAbwB1AHQACgB0AG8AbwAgAG0AdQBjAGgAIABhAGQAbwAsACAAdwBlACAAcwBhAHYAZQBkACAAaQB0ACAAaQBuAHQAbwAgAHQAaABlAAoAdABlAHgAdAB1AHIAZQAnAHMAIABhAGwAcABoAGEAIABjAGgAYQBuAG4AZQBsAC4ACgAKADAALgAwADEAIABhAGwAcABoAGEAIABpAHMAIABhACAAdAByAGEAbgBzAHAAYQByAGUAbgB0ACAAcABpAHgAZQBsACAAbwBuACAARgBPAFIAVwBBAFIARAAgAHAAbABhAG4AZQAuAAoAMAAuADAAMgAgAGEAbABwAGgAYQAgAGkAcwAgAGEAIAB0AHIAYQBuAHMAcABhAHIAZQBuAHQAIABwAGkAeABlAGwAIABvAG4AIABSAEkARwBIAFQAIABwAGwAYQBuAGUALgAKADAALgAwADMAIABhAGwAcABoAGEAIABpAHMAIABhACAAdAByAGEAbgBzAHAAYQByAGUAbgB0ACAAcABpAHgAZQBsACAAbwBuACAAVABPAFAAIABwAGwAYQBuAGUALgAKADAALgA5ADgAIABpAHMAIABhAG4AIABvAHAAYQBxAHUAZQAgAHAAaQB4AGUAbAAgAG8AbgAgAEYATwBSAFcAQQBSAEQAIABwAGwAYQBuAGUALgAKADAALgA5ADkAIABpAHMAIABhAG4AIABvAHAAYQBxAHUAZQAgAHAAaQB4AGUAbAAgAG8AbgAgAFIASQBHAEgAVAAgAHAAbABhAG4AZQAuAAoAMQAuADAAMAAgAGkAcwAgAGEAbgAgAG8AcABhAHEAdQBlACAAcABpAHgAZQBsACAAbwBuACAAVABPAFAAIABwAGwAYQBuAGUALgA=,output:2,fname:PlaneNumberInfo,width:412,height:196;n:type:ShaderForge.SFN_Get,id:9388,x:27798,y:30324,varname:node_9388,prsc:2|IN-3191-OUT;n:type:ShaderForge.SFN_Multiply,id:6237,x:28209,y:30634,varname:node_6237,prsc:2|A-9388-OUT,B-9006-OUT;n:type:ShaderForge.SFN_Vector1,id:9006,x:28018,y:30649,varname:node_9006,prsc:2,v1:100;n:type:ShaderForge.SFN_Subtract,id:1104,x:28102,y:30373,varname:node_1104,prsc:2|A-9388-OUT,B-2827-OUT;n:type:ShaderForge.SFN_Vector1,id:2827,x:27842,y:30419,varname:node_2827,prsc:2,v1:0.97;n:type:ShaderForge.SFN_Multiply,id:6426,x:28312,y:30384,varname:node_6426,prsc:2|A-1104-OUT,B-9006-OUT;n:type:ShaderForge.SFN_Round,id:1192,x:28838,y:30356,varname:node_1192,prsc:2|IN-4742-OUT;n:type:ShaderForge.SFN_Multiply,id:2327,x:30265,y:31530,cmnt:Inputting 0.5 will multiply by 1 which has no effect. Less than 0.5 will darken from 0 to 1 and above 0.5 will brighten by multiplying from 1 to 2x.,varname:node_2327,prsc:2|A-6665-RGB,B-4804-OUT;n:type:ShaderForge.SFN_Vector1,id:4804,x:30060,y:31433,varname:node_4804,prsc:2,v1:2;n:type:ShaderForge.SFN_RemapRange,id:8022,x:30658,y:31079,cmnt:Rescales it to 0.7 to 1 multiplied by 0.75 which yields 0.525 to 0.75,varname:node_8022,prsc:2,frmn:-1,frmx:1,tomn:0.525,tomx:0.75|IN-1391-OUT;n:type:ShaderForge.SFN_Set,id:7719,x:29330,y:32691,cmnt:This is sent to the post processing shader.,varname:Dithering,prsc:2|IN-882-OUT;n:type:ShaderForge.SFN_Get,id:7332,x:32119,y:32561,varname:node_7332,prsc:2|IN-55-OUT;n:type:ShaderForge.SFN_Get,id:4452,x:32119,y:32480,varname:node_4452,prsc:2|IN-3191-OUT;n:type:ShaderForge.SFN_Min,id:4188,x:32386,y:32492,cmnt:This sets the transparency of each pixel to whichever of these values is the most transparent,varname:node_4188,prsc:2|A-4452-OUT,B-7332-OUT;n:type:ShaderForge.SFN_Set,id:1978,x:32583,y:32492,varname:Alpha_Output,prsc:2|IN-4188-OUT;n:type:ShaderForge.SFN_Get,id:7255,x:35204,y:32320,varname:node_7255,prsc:2|IN-1978-OUT;n:type:ShaderForge.SFN_RemapRange,id:1749,x:35387,y:32320,cmnt:This is for the post processing shader.,varname:node_1749,prsc:2,frmn:0,frmx:1,tomn:0.01,tomx:0.95|IN-7255-OUT;n:type:ShaderForge.SFN_Code,id:5350,x:32225,y:31739,varname:node_5350,prsc:2,code:VwBlAGwAYwBvAG0AZQAgAHQAbwAgAHQAaABlACAAVQBsAHQAcgBhACAAcwBoAGEAZABlAHIAIQAgAFQAaABpAHMAIABzAGgAYQBkAGUAcgAgAGkAcwAgAHMAaQBtAGkAbABhAHIAIAB0AG8AIAB0AGgAZQAgAG4AbwBuAC0AdQBsAHQAcgBhACAAcwBoAGEAZABlAHIAcwANAAoAZQB4AGMAZQBwAHQAIAB0AGgAYQB0ACAAaQB0ACAAdQBzAGUAcwAgAGEAIABwAG8AcwB0AC0AcAByAG8AYwBlAHMAcwBpAG4AZwAgAGUAZgBmAGUAYwB0ACAAdABvACAAaABhAG4AZABsAGUAIABhAGwAbAAgAG8AZgAgAHQAaABlACAAdAByAGEAbgBzAHAAYQByAGUAbgBjAHkADQAKAGYAZQBhAHQAdQByAGUAcwAuACAASABlAHIAZQAnAHMAIABoAG8AdwAgAGkAdAAgAHcAbwByAGsAcwAuAA0ACgANAAoAVABoAGUAIABvAHQAaABlAHIAIABzAGgAYQBkAGUAcgBzACAAdQBzAGUAIABkAGkAdABoAGUAcgBpAG4AZwAgAGkAbgAgAHYAYQByAGkAbwB1AHMAIABhAG0AbwB1AG4AdABzACAAdABvACAAYwByAGUAYQB0AGUAIABhACAAcwBvAHIAdAAgAG8AZgAgACIAZgBhAGsAZQAiAA0ACgB0AHIAYQBuAHMAcABhAHIAZQBuAGMAeQAuACAARgBvAHIAIABtAG8AcgBlACAAbwBwAGEAcQB1AGUAIABhAHIAZQBhAHMALAAgAHQAaABlAHkAIABzAGkAbQBwAGwAeQAgAGQAcgBhAHcAIABtAG8AcgBlACAAcwBvAGwAaQBkACAAcABpAHgAZQBsAHMALgAgAEIAdQB0AA0ACgBmAG8AcgAgAG0AbwByAGUAIAB0AHIAYQBuAHMAcABhAHIAZQBuAHQAIABhAHIAZQBhAHMALAAgAHQAaABlAHkAIABjAGwAaQBwACgAKQAgAG0AbwByAGUAIABwAGkAeABlAGwAcwAsACAAdwBoAGkAYwBoACAAYQBsAGwAbwB3AHMAIAB5AG8AdQAgAHQAbwAgAHMAZQBlAA0ACgB0AGgAcgBvAHUAZwBoACAAdABoAGUAIABtAGUAcwBoACwAIAB0AGgAdQBzACAAYwByAGUAYQB0AGkAbgBnACAAYQBuACAAaQBsAGwAdQBzAGkAbwBuACAAbwBmACAAdAByAGEAbgBzAHAAYQByAGUAbgBjAHkALgANAAoADQAKAFQAaABpAHMAIAAiAHUAbAB0AHIAYQAiACAAcwBoAGEAZABlAHIAIABkAG8AZQBzACAAYQAgAHMAaQBtAGkAbABhAHIAIAB0AGgAaQBuAGcALAAgAG8AbgBsAHkAIABkAGkAZgBmAGUAcgBlAG4AYwBlACAAaQBzACAAdABoAGEAdAAgAGkAdAAgAGQAbwBlAHMAIABuAG8AdAANAAoAYwBsAGkAcAAgAHQAaABlACAAcABpAHgAZQBsAHMAIABtAG8AcgBlACAAbwByACAAbABlAHMAcwAgAHQAbwAgAGMAcgBlAGEAdABlACAAdABoAGUAIAB2AGEAcgBpAG8AdQBzACAAYQBtAG8AdQBuAHQAcwAgAG8AZgAgAHQAcgBhAG4AcwBwAGEAcgBlAG4AYwB5AC4ADQAKAEkAbgBzAHQAZQBhAGQALAAgAHQAaABpAHMAIABzAGgAYQBkAGUAcgAgAGEAbAB3AGEAeQBzACAAYwBsAGkAcABzACAAdABoAGUAIABwAGkAeABlAGwAcwAgAGUAeABhAGMAdABsAHkAIAA1ADAAJQAsACAAbQBlAGEAbgBpAG4AZwAgAGkAdAAgAGMAbABpAHAAcwANAAoAZQB2AGUAcgB5ACAAbwB0AGgAZQByACAAcABpAHgAZQBsACwAIABpAG4AIABhACAAcABlAHIAZgBlAGMAdABsAHkAIABjAGgAZQBjAGsAZQByAGQAYgBvAGEAcgBkACAAcABhAHQAdABlAHIAbgAuACAAUwBvACAAcgBlAGcAYQByAGQAbABlAHMAcwAgAG8AZgANAAoAaABvAHcAIABtAHUAYwBoACAAdAByAGEAbgBzAHAAYQByAGUAbgBjAHkAIABpAG4AIABzAHUAcABwAG8AcwBlAGQAIAB0AG8AIABiAGUAIABpAG4AIABhAG4AeQAgAHAAYQByAHQAaQBjAHUAbABhAHIAIABhAHIAZQBhACwAIABpAHQAIABzAHQAaQBsAGwADQAKAGMAbABpAHAAcwAgAGkAdAAgAGUAeABhAGMAdABsAHkAIAB0AG8AIABhACAAYwBoAGUAYwBrAGUAcgBkAGIAbwBhAHIAZAAgAHAAYQB0AHQAZQByAG4ALgAgAEkAdAAgAGEAbABzAG8AIABzAGEAdgBlAHMAIAB0AGgAZQAgAGEAbQBvAHUAbgB0ACAAbwBmAA0ACgB0AHIAYQBuAHMAcABhAHIAZQBuAGMAeQAgAGkAbgB0AG8AIAB0AGgAZQAgAGEAbABwAGgAYQAgAGMAaABhAG4AbgBlAGwAIABvAGYAIAB0AGgAZQAgAG8AdQB0AHAAdQB0ACAAYwBvAGwAbwByACAAZgBvAHIAIABlAHYAZQByAHkAIABwAGkAeABlAGwALgANAAoAQQBuAGQAIABmAHUAcgB0AGgAZQByAG0AbwByAGUALAAgAHQAaABpAHMAIABzAGgAYQBkAGUAcgAgAG4AZQB2AGUAcgAgAG8AdQB0AHAAdQB0AHMAIABhACAAZgB1AGwAbAB5ACAAbwBwAGEAcQB1AGUAIABjAG8AbABvAHIALgAgAEkAdAAgAGMAYQBuAA0ACgByAGEAbgBnAGUAIABmAHIAbwBtACAAegBlAHIAbwAgACgAMAApACAAdABvACAAYQAgAG0AYQB4AGkAbQB1AG0AIABvAHAAYQBjAGkAdAB5ACAAbwBmACAAMAAuADkAOQAsACAAYgB1AHQAIABuAGUAdgBlAHIAIAAxACAAKAB0AGgAYQB0ACAAdwBvAHUAbABkACAAYgBlAA0ACgBmAHUAbABsAHkAIABvAHAAYQBxAHUAZQApAC4AIABUAGgAZQAgAHIAZQBhAHMAbwBuACAAZgBvAHIAIAB0AGgAZQAgAGgAYQByAGQAIABsAGkAbQBpAHQAIABvAGYAIAAwAC4AOQA5ACAAdwBpAGwAbAAgAGIAZQAgAGUAeABwAGwAYQBpAG4AZQBkACAAYgBlAGwAbwB3AC4ADQAKAA0ACgBOAG8AdwAsACAAcwBpAG4AYwBlACAAdABoAGkAcwAgAHMAaABhAGQAZQByACAAaQBzACAAcwBlAHQAIAB0AG8AIABBAGwAcABoAGEAIABDAGwAaQBwACAAbwByAGQAZQByACwAIABhAG4AZAAgAE8AcABhAHEAdQBlACAAYgBsAGUAbgBkAGkAbgBnACAAbQBvAGQAZQAsAA0ACgB0AGgAZQByAGUAIABpAHMAIABuAG8AIABhAHUAdABvAG0AYQB0AGkAYwAgAHQAcgBhAG4AcwBwAGEAcgBlAG4AYwB5ACAAcAByAG8AdgBpAGQAZQBkACAAYgB5ACAAVQBuAGkAdAB5ACcAcwAgAHIAZQBuAGQAZQByAGUAcgAuACAARQB2AGUAbgAgAHQAaABvAHUAZwBoACAAdwBlAA0ACgBzAGUAdAAgAHQAaABlACAAYQBsAHAAaABhACAAYwBoAGEAbgBuAGUAbAAgAG8AZgAgAHQAaABlACAAbwB1AHQAcAB1AHQAIABjAG8AbABvAHIAIAB0AG8AIABzAG8AbQBlAHcAaABhAHQAIAB0AHIAYQBuAHMAcABhAHIAZQBuAHQALAAgAHQAaABlACAAdAByAGUAZQAgAHcAaQBsAGwADQAKAGIAZQAgAGYAdQBsAGwAeQAgAGQAcgBhAHcAbgAgAG4AbwBuAGUAdABoAGUAbABlAHMAcwAuACAAQgB1AHQAIAB0AGgAYQB0ACAAYQBsAHAAaABhACAAYwBoAGEAbgBuAGUAbAAgAHcAaQBsAGwAIABiAGUAIABzAGEAdgBlAGQAIAB0AG8AIAB0AGgAZQAgAHAAaQB4AGUAbAAsAA0ACgB3AGkAdABoACAAdABoAGUAIABoAGEAcgBkACAAbABpAG0AaQB0ACAAbwBmACAAMAAuADkAOQAuACAAQQBuAGQAIAB0AGgAZQAgAGMAaABlAGMAawBlAHIAZABiAG8AYQByAGQAIABkAGkAdABoAGUAcgBpAG4AZwAgAHcAaQBsAGwAIABsAGUAdAAgAHUAcwAgAA0ACgBzAG8AbQBlAHcAaABhAHQAIABzAGUAZQAgAHQAaAByAG8AdQBnAGgAIAB0AGgAaQBzACAAdAByAGUAZQAsACAAYgB1AHQAIABpAHQAIAB3AG8AbgAnAHQAIABsAG8AbwBrACAAdgBlAHIAeQAgAGcAbwBvAGQAIAAtAC0AIAB5AGUAdAAhAA0ACgANAAoATABhAHMAdAAgAGIAdQB0ACAAbgBvAHQAIABsAGUAYQBzAHQALAAgAGEAbABsACAAIgB1AGwAdAByAGEAIgAgAHMAaABhAGQAZQByAHMAIAB3AGkAbABsACAAdwByAGkAdABlACAAYQAgAHYAYQBsAHUAZQAgAHQAbwAgAHQAaABlACAAcwB0AGUAbgBjAGkAbAANAAoAYgB1AGYAZgBlAHIALgAgAE4AZQB4AHQAIAB3AGUAJwBsAGwAIAB1AHMAZQAgAHQAaABpAHMALAAgAGkAbgAgAGMAbwBtAGIAaQBuAGEAdABpAG8AbgAgAHcAaQB0AGgAIAB0AGgAYQB0ACAAaABhAHIAZAAgAGwAaQBtAGkAdAAgAG8AZgAgADAALgA5ADkAIABhAGwAcABoAGEALAANAAoAdABvACAAaQBkAGUAbgB0AGkAZgB5ACAAdwBoAGUAcgBlACAAdABoAGUAIAB0AHIAZQBlAHMAIABhAHIAZQAgAG8AbgAgAHQAaABlACAAcwBjAHIAZQBlAG4ALgANAAoADQAKAE4AZQB4AHQAIAB3AGUAIABhAHQAdABhAGMAaAAgAHQAbwAgAHQAaABlACAAbQBhAGkAbgAgAGMAYQBtAGUAcgBhACAAdABoAGUAIABzAGMAcgBpAHAAdAAgAF8ATAB1AHMAaABMAE8ARABQAG8AcwB0AFAAcgBvAGMAZQBzAHMALgBjAHMALAAgAHcAaABpAGMAaAAgAHcAaQBsAGwADQAKAHIAdQBuACAAcwBlAHYAZQByAGEAbAAgAHAAbwBzAHQAIABwAHIAbwBjAGUAcwBzAGkAbgBnACAAcABhAHMAcwBlAHMAIABvAHYAZQByACAAdABoAGUAIABmAGkAbgBhAGwAIABpAG0AYQBnAGUALgAgAEkAbgAgAHQAaABlACAAZgBpAHIAcwB0ACAAcABhAHMAcwAsACAAaQB0AA0ACgB3AGkAbABsACAAbABvAG8AawAgAGYAbwByACAAdABoAGEAdAAgAHMAdABlAG4AYwBpAGwAIAB2AGEAbAB1AGUAIAB0AG8AIABmAGkAbgBkACAAZQB2AGUAcgB5ACAAbgBvAG4ALQB0AHIAZQBlACAAcABpAHgAZQBsACwAIABhAG4AZAAgAGkAdAAgAHcAaQBsAGwAIABzAGUAdAAgAGEAbABsAA0ACgBuAG8AbgAtAHQAcgBlAGUAIABwAGkAeABlAGwAcwAgAHQAbwAgAGEAIABhAGwAcABoAGEAIAB2AGEAbAB1AGUAIABvAGYAIAAxAC4AIABPAG4AYwBlACAAdABoAGEAdAAnAHMAIABkAG8AbgBlACwAIAB3AGUAIABkAG8AbgAnAHQAIABuAGUAZQBkACAAdABvACAAdQBzAGUADQAKAHQAaABlACAAcwB0AGUAbgBjAGkAbAAgAGIAdQBmAGYAZQByACAAYQBuAHkAbQBvAHIAZQAsACAAYgBlAGMAYQB1AHMAZQAgAHcAZQAgAG4AbwB3ACAAawBuAG8AdwAgAHQAaABhAHQAIABhAGwAbAAgAG4AbwBuAC0AdAByAGUAZQAgAHAAaQB4AGUAbABzACAAYQByAGUADQAKAGYAdQBsAGwAeQAgAG8AcABhAHEAdQBlACwAIABhAG4AZAAgAGEAbABsACAAdAByAGUAZQAgAHAAaQB4AGUAbABzACAAYQByAGUAIABzAG8AbQBlAHcAaABhAHQAIAB0AHIAYQBuAHMAcABhAHIAZQBuAHQALAAgAGQAdQBlACAAdABvACAAdABoAGEAdAAgAGgAYQByAGQADQAKAGwAaQBtAGkAdAAgAG8AZgAgADAALgA5ADkAIABpAG4AIAB0AGgAZQAgAGEAbABwAGgAYQAgAG8AbgAgAGEAbABsACAAdAByAGUAZQAgAHAAaQB4AGUAbABzAC4ADQAKAA0ACgBOAGUAeAB0ACwAIAB0AGgAZQAgAHMAYwByAGkAcAB0ACAAdwBpAGwAbAAgAHIAdQBuACAAdABoAGUAIABwAG8AcwB0AC0AcAByAG8AYwBlAHMAcwBpAG4AZwAgAHMAaABhAGQAZQByACAAbwB2AGUAcgAgAHQAaABlACAAdwBoAG8AbABlACAAaQBtAGEAZwBlACwAIAANAAoAYQBuAGQAIABpAHQAIAB3AGkAbABsACAAcwBhAG0AcABsAGUAIABtAHUAbAB0AGkAcABsAGUAIABwAGkAeABlAGwAcwAgAGkAbgAgAGEAIABzAG0AYQBsAGwAIABhAHIAZQBhACAAdABvACAAcwBtAG8AbwB0AGgAbAB5ACAAYgBsAGUAbgBkACAAYQB3AGEAeQAgAHQAaABhAHQADQAKAGMAaABlAGMAawBlAHIAZABiAG8AYQByAGQAIABkAGkAdABoAGUAcgBpAG4AZwAgAHAAYQB0AHQAZQByAG4ALAAgAGEAbgBkACAAYwByAGUAYQB0AGUAIABwAGUAcgBmAGUAYwB0AGwAeQAgAHMAbQBvAG8AdABoACAAbABvAG8AawBpAG4AZwAgAHQAcgBhAG4AcwBwAGEAcgBlAG4AYwB5AC4ADQAKAFQAaABpAHMAIAB0AHIAYQBuAHMAcABhAHIAZQBuAGMAeQAgAGkAcwAsACAAdwBlAGwAbAAsACAAIgBhAHcAZQBzAG8AbQBlACIAIABiAGUAYwBhAHUAcwBlACAAaQB0ACcAcwAgAHcAbwByAGsAaQBuAGcAIABvAG4AIAB0AHIAZQBlAHMAIAB0AGgAYQB0ACAAYQByAGUADQAKAGkAbgAgAHQAaABlACAAZwBlAG8AbQBlAG4AdAByAHkAIABvAHIAIABBAGwAcABoAGEAIABDAGwAaQBwACAAbwByAGQAZQByACwAIAB3AGkAdABoACAAZABlAHAAdABoACAAYgB1AGYAZgBlAHIAaQBuAGcAIABhAGMAdABpAHYAZQAuACAAVABoAGkAcwAgAGMAcgBlAGEAdABlAHMAIAAKAHYAZQByAHkAIAAzAEQAIABsAG8AbwBrAGkAbgBnAA0AIABiAGkAbABsAGIAbwBhAHIAZABzACAAKAB0AGgAZQB5ACAAdwBvAG4AJwB0ACAAbABvAG8AawAgAG8AcgAgAGEAYwB0ACAAbABpAGsAZQAgACIAcABhAHIAdABpAGMAbABlAHMAIgApACwAIAB5AGUAdAAgAHcAaQB0AGgAIAAKAHQAaABlACAAaABlAGwAcAAgAG8AZgAgAHQAaABlAA0AIABwAG8AcwB0ACAAcAByAG8AYwBlAHMAcwBpAG4AZwAgAGUAZgBmAGUAYwB0ACwAIAB0AGgAZQB5ACAAaABhAHYAZQAgAGEAbABtAG8AcwB0ACAAcABpAHgAZQBsAC0AcABlAHIAZgBlAGMAdAAgAHQAcgBhAG4AcwBwAGEAcgBlAG4AYwB5AC4ACgBFAG4AagBvAHkAIQA=,output:2,fname:Ultra_Shader_Readme,width:629,height:656;n:type:ShaderForge.SFN_Set,id:4246,x:30547,y:30102,varname:LightIN,prsc:2|IN-969-OUT;n:type:ShaderForge.SFN_Vector4Property,id:2890,x:29553,y:30409,ptovrint:False,ptlb:_LushLODTreeMainLightDir,ptin:_LushLODTreeMainLightDir,cmnt:The W is set via script in _LushLODTreesManager.cs,varname:node_8259,prsc:2,glob:True,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,v1:0.5,v2:0.5,v3:0.5,v4:1;n:type:ShaderForge.SFN_Color,id:5065,x:29553,y:30113,ptovrint:False,ptlb:LushLODTreeMainLightCol,ptin:_LushLODTreeMainLightCol,cmnt:This works even with lightmaps,varname:node_349,prsc:2,glob:True,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,c1:0.5,c2:0.5,c3:0.5,c4:1;n:type:ShaderForge.SFN_ValueProperty,id:8331,x:29553,y:30294,ptovrint:False,ptlb:LushLODTreeMainLightIntensity,ptin:_LushLODTreeMainLightIntensity,cmnt:This works even with lightmaps,varname:node_5384,prsc:2,glob:True,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,v1:1;n:type:ShaderForge.SFN_Set,id:7610,x:29805,y:30411,varname:LightDir,prsc:2|IN-2890-XYZ;n:type:ShaderForge.SFN_Get,id:7517,x:30234,y:31119,varname:node_7517,prsc:2|IN-7610-OUT;n:type:ShaderForge.SFN_Dot,id:6883,x:31051,y:30557,cmnt:Is the sun above the horizon?,varname:node_6883,prsc:2,dt:0|A-5023-OUT,B-1999-OUT;n:type:ShaderForge.SFN_Get,id:1999,x:30818,y:30603,varname:node_1999,prsc:2|IN-7610-OUT;n:type:ShaderForge.SFN_Vector3,id:5023,x:30818,y:30490,cmnt:Checks if the light is shining straight down,varname:node_5023,prsc:2,v1:0,v2:1,v3:0;n:type:ShaderForge.SFN_Clamp01,id:8079,x:31615,y:30561,varname:node_8079,prsc:2|IN-3381-OUT;n:type:ShaderForge.SFN_Clamp01,id:944,x:32079,y:30405,varname:node_944,prsc:2|IN-5641-OUT;n:type:ShaderForge.SFN_Set,id:6203,x:32707,y:30448,cmnt:This is an optional lighting adjustment you can remove this if your scene doesnt benefit from this.,varname:TimeOfDayIntensity,prsc:2|IN-997-OUT;n:type:ShaderForge.SFN_Add,id:3381,x:31430,y:30561,cmnt:This makes the trees not get dark until the sun is somewhat BELOW the horizon.,varname:node_3381,prsc:2|A-6883-OUT,B-9176-OUT;n:type:ShaderForge.SFN_Vector1,id:9176,x:31242,y:30595,varname:node_9176,prsc:2,v1:0.25;n:type:ShaderForge.SFN_RemapRangeAdvanced,id:5641,x:31878,y:30405,cmnt:Rescales it from 01 to about 03 to make it get brigher faster as the sun comes up. This effect is significantly stronger on the sunny side via backside darkening.,varname:node_5641,prsc:2|IN-8079-OUT,IMIN-7304-OUT,IMAX-1122-OUT,OMIN-1319-OUT,OMAX-5960-OUT;n:type:ShaderForge.SFN_Vector1,id:7304,x:31615,y:30256,varname:node_7304,prsc:2,v1:0;n:type:ShaderForge.SFN_Vector1,id:1122,x:31615,y:30305,varname:node_1122,prsc:2,v1:1;n:type:ShaderForge.SFN_Vector1,id:1319,x:31615,y:30360,varname:node_1319,prsc:2,v1:0;n:type:ShaderForge.SFN_Vector1,id:6195,x:31412,y:30316,varname:node_6195,prsc:2,v1:1.3;n:type:ShaderForge.SFN_Add,id:5960,x:31615,y:30410,varname:node_5960,prsc:2|A-6195-OUT,B-9849-OUT;n:type:ShaderForge.SFN_Get,id:3328,x:31235,y:30318,varname:node_3328,prsc:2|IN-6719-OUT;n:type:ShaderForge.SFN_Multiply,id:9849,x:31412,y:30382,varname:node_9849,prsc:2|A-3328-OUT,B-9983-OUT;n:type:ShaderForge.SFN_Vector1,id:9983,x:31235,y:30401,varname:node_9983,prsc:2,v1:2;n:type:ShaderForge.SFN_Lerp,id:8233,x:34717,y:32591,varname:node_8233,prsc:2|A-3860-OUT,B-9227-OUT,T-9550-OUT;n:type:ShaderForge.SFN_ValueProperty,id:9550,x:34447,y:32657,ptovrint:False,ptlb:LushLODTreeDisableFarDithering,ptin:_LushLODTreeDisableFarDithering,varname:node_9550,prsc:2,glob:True,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,v1:1;n:type:ShaderForge.SFN_Get,id:3860,x:34426,y:32521,varname:node_3860,prsc:2|IN-3191-OUT;n:type:ShaderForge.SFN_Get,id:9227,x:34426,y:32577,varname:node_9227,prsc:2|IN-7719-OUT;n:type:ShaderForge.SFN_NormalVector,id:4106,x:31340,y:30937,prsc:2,pt:False;n:type:ShaderForge.SFN_Set,id:9266,x:31734,y:31037,varname:NomalDir,prsc:2|IN-303-OUT;n:type:ShaderForge.SFN_FaceSign,id:1583,x:31340,y:31083,varname:node_1583,prsc:2,fstp:1;n:type:ShaderForge.SFN_Multiply,id:303,x:31564,y:31020,cmnt:Stop it from reversing the normal when viewed from backface.,varname:node_303,prsc:2|A-4106-OUT,B-1583-VFACE;n:type:ShaderForge.SFN_Code,id:4742,x:28516,y:30356,varname:node_4742,prsc:2,code:cgBlAHQAdQByAG4AIABBACAAPgAgADAALgA1ACAAPwAgAEIAIAA6ACAAQwA7AA==,output:0,fname:Function_node_4742,width:247,height:112,input:0,input:0,input:0,input_1_label:A,input_2_label:B,input_3_label:C|A-9388-OUT,B-6426-OUT,C-6237-OUT;n:type:ShaderForge.SFN_Code,id:5491,x:32657,y:31008,varname:node_5491,prsc:2,code:LwAvACAAVABoAGkAcwAgAGYAdQBuAGMAdABpAG8AbgAgAGkAcwAgAG4AZQBjAGUAcwBhAHIAeQAgAGQAdQBlACAAdABvACAAdABoAGkAcwAgAGIAdQBnADoAIAAKAC8ALwAgAGgAdAB0AHAAcwA6AC8ALwBzAGgAYQBkAGUAcgBmAG8AcgBnAGUALgB1AHMAZQByAGUAYwBoAG8ALgBjAG8AbQAvAHQAbwBwAGkAYwBzAC8AMQAyADQAOAAtAHQAbwBvAC0AbQBhAG4AeQAtAG8AdQB0AHAAdQB0AC0AcgBlAGcAaQBzAHQAZQByAHMALQBkAGUAYwBsAGEAcgBlAGQALQAxADIALQBvAG4ALQBkADMAZAA5AC8ACgAvAC8AIABTAG8AIAB0AG8AIAByAGUAZAB1AGMAZQAgAG8AdQB0AHAAdQB0ACAAcgBlAGcAaQBzAHQAZQByAHMALAAgAHcAZQAgAGEAcgBlACAAbQBvAHYAaQBuAGcAIAB0AGgAZQAgAEIAaQBUAGEAbgBnAGUAbgB0ACAAYwBhAGwAYwB1AGwAdABpAG8AbgAgAHQAbwAgAGgAZQByAGUALgAKAC8ALwAgAFQAaABpAHMAIABpAHMAIABwAHIAbwBiAGEAYgBsAHkAIABsAGUAcwBzACAAZQBmAGYAaQBjAGkAZQBuAHQALAAgAGIAdQB0ACAAaQB0ACAAcwBhAHYAZQBzACAAbQBlACAAZgByAG8AbQAgAGgAYQB2AGkAbgBnACAAdABvACAAbQBhAG4AdQBhAGwAbAB5ACAAZQBkAGkAdAAgAHQAaABpAHMAIABzAGgAYQBkAGUAcgAuAAoACgAvAC8ARgBvAHIAdwBhAHIAZAAgAFAAbABhAG4AZQAgAEIAaQBUAGEAbgBnAGUAbgB0ACAAaQBzACAAbQB1AGwAdABpAHAAbABpAGUAZAAgAGIAeQAgAC0AMQAgACgAcwBlAGUAIABMAHUAcwBoAEwATwBEAFQAcgBlAGUAQwBvAG4AdgBlAHIAdABlAHIALgBjAHMAKQAKAHIAZQB0AHUAcgBuACAAUABOACAAPQA9ACAAMQAgAD8AIABuAG8AcgBtAGEAbABpAHoAZQAoAGMAcgBvAHMAcwAoAG4AbwByAG0AYQBsAEQAaQByACwAIAB0AGEAbgBnAGUAbgB0AEQAaQByACkAIAAqACAALQAxACkAIAA6AAoACQAgAG4AbwByAG0AYQBsAGkAegBlACgAYwByAG8AcwBzACgAbgBvAHIAbQBhAGwARABpAHIALAAgAHQAYQBuAGcAZQBuAHQARABpAHIAKQApADsA,output:2,fname:CalculateBiTangent,width:653,height:224,input:0,input:2,input:2,input_1_label:PN,input_2_label:normalDir,input_3_label:tangentDir|A-3559-OUT,B-5688-OUT,C-587-OUT;n:type:ShaderForge.SFN_Tangent,id:587,x:32369,y:31084,varname:node_587,prsc:2;n:type:ShaderForge.SFN_Get,id:5688,x:32369,y:31036,varname:node_5688,prsc:2|IN-9266-OUT;n:type:ShaderForge.SFN_Get,id:3559,x:32369,y:30992,varname:node_3559,prsc:2|IN-5415-OUT;n:type:ShaderForge.SFN_Set,id:6525,x:33377,y:31008,varname:BiTanDir,prsc:2|IN-5491-OUT;n:type:ShaderForge.SFN_Code,id:1320,x:28950,y:31208,cmnt:Note GetSeamsBlending is in SeamsBlending.cginc,varname:node_1320,prsc:2,code:cgBlAHQAdQByAG4AIABHAGUAdABTAGUAYQBtAHMAQgBsAGUAbgBkAGkAbgBnAF8AQQBuAGcAdQBsAGEAcgAJAAoACQAoAAkACgAJAAkAQgBpAFQAYQBuAEQAaQByACwACgAJAAkATgBvAHIAbQBhAGwASQBOACwACgAJAAkAVwBvAHIAbABkAFAAbwBzAEMAZQBuAHQAZQByACwACgAJAAkAUABsAGEAbgBlAE4AdQBtAGIAZQByACwACgAJAAkARgBpAG4AYQBsAEMAbwBsAG8AcgBJAE4ALAAKAAkACQBVAFYAMwBDAG8AbABvAHIALAAKAAkACQBVAFYANABDAG8AbABvAHIALAAKAAkACQBXAG8AcgBsAGQAUABvAHMALAAKAAkACQBWAGkAZQB3AEQAaQByACwACgAJAAkAVABhAG4ARABpAHIACgAJACkALgByAGcAYgA7AA==,output:2,fname:GetSeamsBlending_Caller,width:385,height:249,input:2,input:2,input:2,input:0,input:2,input:3,input:3,input:2,input:2,input:2,input_1_label:BiTanDir,input_2_label:NormalIN,input_3_label:WorldPosCenter,input_4_label:PlaneNumber,input_5_label:FinalColorIN,input_6_label:UV3Color,input_7_label:UV4Color,input_8_label:WorldPos,input_9_label:ViewDir,input_10_label:TanDir|A-3473-OUT,B-3057-OUT,C-8551-OUT,D-7187-OUT,E-4780-OUT,F-6637-OUT,G-3323-OUT,H-7400-XYZ,I-8403-OUT,J-5914-OUT;n:type:ShaderForge.SFN_Get,id:3473,x:28476,y:31099,varname:node_3473,prsc:2|IN-6525-OUT;n:type:ShaderForge.SFN_Get,id:3057,x:28476,y:31143,varname:node_3057,prsc:2|IN-9266-OUT;n:type:ShaderForge.SFN_Get,id:8551,x:28476,y:31186,varname:node_8551,prsc:2|IN-6116-OUT;n:type:ShaderForge.SFN_Get,id:7187,x:28476,y:31231,varname:node_7187,prsc:2|IN-5415-OUT;n:type:ShaderForge.SFN_Get,id:4780,x:28476,y:31276,varname:node_4780,prsc:2|IN-4973-OUT;n:type:ShaderForge.SFN_Get,id:6637,x:28476,y:31320,varname:node_6637,prsc:2|IN-9204-OUT;n:type:ShaderForge.SFN_Get,id:3323,x:28476,y:31363,varname:node_3323,prsc:2|IN-1759-OUT;n:type:ShaderForge.SFN_FragmentPosition,id:7400,x:28476,y:31413,varname:node_7400,prsc:2;n:type:ShaderForge.SFN_ViewVector,id:8403,x:28476,y:31533,varname:node_8403,prsc:2;n:type:ShaderForge.SFN_Tangent,id:5914,x:28476,y:31653,varname:node_5914,prsc:2;n:type:ShaderForge.SFN_Code,id:7818,x:28936,y:31963,cmnt:Note GetWorldPositionCenter is in WorldPositionCenter.cginc,varname:node_7818,prsc:2,code:cgBlAHQAdQByAG4AIABHAGUAdABXAG8AcgBsAGQAUABvAHMAaQB0AGkAbwBuAEMAZQBuAHQAZQByAAoACQAoAAkACgAJAAkAQgBpAFQAYQBuAEQAaQByACwACgAJAAkAVwBvAHIAbABkAFAAbwBzACwACgAJAAkAVABhAG4ARABpAHIALAAKAAkACQBVAFYAMQAsAAoACQAJAFUAVgAwAAoACQApAC4AcgBnAGIAOwA=,output:2,fname:GetWorldPositionCenter_Caller,width:349,height:175,input:2,input:2,input:2,input:1,input:1,input_1_label:BiTanDir,input_2_label:WorldPos,input_3_label:TanDir,input_4_label:UV1,input_5_label:UV0|A-6858-OUT,B-863-XYZ,C-6776-OUT,D-2593-OUT,E-4561-OUT;n:type:ShaderForge.SFN_Get,id:6858,x:28462,y:31854,varname:node_6858,prsc:2|IN-6525-OUT;n:type:ShaderForge.SFN_Get,id:2593,x:28462,y:32151,varname:node_2593,prsc:2|IN-2175-OUT;n:type:ShaderForge.SFN_Get,id:4561,x:28462,y:32194,varname:node_4561,prsc:2|IN-859-OUT;n:type:ShaderForge.SFN_FragmentPosition,id:863,x:28483,y:31907,varname:node_863,prsc:2;n:type:ShaderForge.SFN_Tangent,id:6776,x:28483,y:32023,varname:node_6776,prsc:2;n:type:ShaderForge.SFN_TexCoord,id:4654,x:30728,y:32370,varname:node_4654,prsc:2,uv:1,uaff:False;n:type:ShaderForge.SFN_TexCoord,id:1699,x:30728,y:32518,varname:node_1699,prsc:2,uv:0,uaff:False;n:type:ShaderForge.SFN_Set,id:859,x:31149,y:32520,varname:UV0_IN,prsc:2|IN-1699-UVOUT;n:type:ShaderForge.SFN_Set,id:2175,x:31149,y:32373,varname:UV1_IN,prsc:2|IN-4654-UVOUT;n:type:ShaderForge.SFN_Append,id:3567,x:31175,y:32195,varname:node_3567,prsc:2|A-4547-RGB,B-4547-A;n:type:ShaderForge.SFN_Append,id:9659,x:31161,y:32001,varname:node_9659,prsc:2|A-9956-RGB,B-9956-A;n:type:ShaderForge.SFN_ViewVector,id:3025,x:28496,y:32401,varname:node_3025,prsc:2;n:type:ShaderForge.SFN_ViewReflectionVector,id:8540,x:28496,y:32279,varname:node_8540,prsc:2;n:type:ShaderForge.SFN_Code,id:339,x:28950,y:32342,cmnt:Note GetAngularCorrection is in AngularCorrection.cginc,varname:node_339,prsc:2,code:cgBlAHQAdQByAG4AIABHAGUAdABBAG4AZwB1AGwAYQByAEMAbwByAHIAZQBjAHQAaQBvAG4ACgAJACgACQAKAAkACQBWAGkAZQB3AFIAZQBmACwACgAJAAkAVgBpAGUAdwBEAGkAcgBlAGMACgAJACkAOwA=,output:0,fname:GetAngularCorrection_Caller,width:338,height:112,input:2,input:2,input_1_label:ViewRef,input_2_label:ViewDirec|A-8540-OUT,B-3025-OUT;n:type:ShaderForge.SFN_Code,id:7534,x:31411,y:31851,varname:node_7534,prsc:2,code:YwBsAGkAcAAoAFQAZQB4AEEAbABwAGgAYQAgAC0AIABDAHUAdABvAGYAZgApADsACgByAGUAdAB1AHIAbgAgAFQAZQB4AEEAbABwAGgAYQA7AA==,output:0,fname:ClipMe,width:247,height:112,input:0,input:0,input_1_label:TexAlpha,input_2_label:Cutoff|A-7736-A,B-1903-OUT;n:type:ShaderForge.SFN_Get,id:1903,x:31159,y:31911,varname:node_1903,prsc:2|IN-7766-OUT;n:type:ShaderForge.SFN_ScreenPos,id:8095,x:28512,y:32648,varname:node_8095,prsc:2,sctp:2;n:type:ShaderForge.SFN_Code,id:882,x:28776,y:32687,varname:node_882,prsc:2,code:cgBlAHQAdQByAG4AIABHAGUAdABEAGkAdABoAGUAcgBVAGwAdAByAGEAQgBCAF8ATQBBAEkATgBQAEEAUwBTACgAUwBjAGUAbgBlAFUAVgBzACwAIABUAHIAYQBuAHMAcABhAHIAZQBuAGMAeQApADsA,output:0,fname:GetDitherUltra_Caller,width:455,height:112,input:1,input:0,input_1_label:SceneUVs,input_2_label:Transparency|A-8095-UVOUT,B-8548-OUT;n:type:ShaderForge.SFN_Get,id:8548,x:28491,y:32791,varname:node_8548,prsc:2|IN-55-OUT;n:type:ShaderForge.SFN_Get,id:5176,x:33275,y:31535,cmnt:The main texture color with some modifications for things like seams blending.,varname:node_5176,prsc:2|IN-4895-OUT;n:type:ShaderForge.SFN_Get,id:7195,x:33104,y:31831,cmnt:The color of the main diretional light,varname:node_7195,prsc:2|IN-4246-OUT;n:type:ShaderForge.SFN_Get,id:5961,x:33568,y:32380,cmnt:The shadows value,varname:node_5961,prsc:2|IN-6719-OUT;n:type:ShaderForge.SFN_Get,id:1227,x:35071,y:31545,varname:node_1227,prsc:2|IN-6203-OUT;n:type:ShaderForge.SFN_Add,id:2542,x:33421,y:31853,varname:node_2542,prsc:2|A-7195-OUT,B-4531-RGB;n:type:ShaderForge.SFN_Multiply,id:2336,x:33681,y:31796,cmnt:The final texture color with all lights but no shadows yet,varname:node_2336,prsc:2|A-5176-OUT,B-2542-OUT;n:type:ShaderForge.SFN_Lerp,id:207,x:34286,y:31980,cmnt:The final color with the shadows and ambient tint applied to the shadows,varname:node_207,prsc:2|A-7283-OUT,B-2336-OUT,T-9092-OUT;n:type:ShaderForge.SFN_Multiply,id:7283,x:33915,y:32167,varname:node_7283,prsc:2|A-965-OUT,B-8099-OUT;n:type:ShaderForge.SFN_Blend,id:965,x:33703,y:32088,cmnt:The color of the shadow is based entirely off the texture color and the ambient light color,varname:node_965,prsc:2,blmd:1,clmp:False|SRC-4531-RGB,DST-5176-OUT;n:type:ShaderForge.SFN_Vector1,id:8099,x:33677,y:32263,varname:node_8099,prsc:2,v1:0.8;n:type:ShaderForge.SFN_Get,id:1025,x:33772,y:31579,varname:node_1025,prsc:2|IN-7375-OUT;n:type:ShaderForge.SFN_Max,id:4825,x:34286,y:31648,cmnt:Finds the highest input color value,varname:node_4825,prsc:2|A-8960-R,B-8960-G,C-8960-B;n:type:ShaderForge.SFN_Min,id:2959,x:34286,y:31806,cmnt:Finds how much LESS than WHITE the input color is,varname:node_2959,prsc:2|A-8960-R,B-8960-G,C-8960-B;n:type:ShaderForge.SFN_ComponentMask,id:8960,x:33987,y:31579,cmnt:The input color,varname:node_8960,prsc:2,cc1:0,cc2:1,cc3:2,cc4:-1|IN-1025-OUT;n:type:ShaderForge.SFN_Multiply,id:4107,x:34314,y:31339,cmnt:The input color multiplied by the texture color to give the input color a texture so that it doesnt look flat,varname:node_4107,prsc:2|A-5176-OUT,B-8960-OUT;n:type:ShaderForge.SFN_Multiply,id:9001,x:34644,y:31567,cmnt:Darkens the final color based on the input ccolor,varname:node_9001,prsc:2|A-207-OUT,B-8960-OUT;n:type:ShaderForge.SFN_Lerp,id:6056,x:34654,y:31365,cmnt:Lerps towards the input color based on how much the input color is LESS than WHITE,varname:node_6056,prsc:2|A-4107-OUT,B-207-OUT,T-2959-OUT;n:type:ShaderForge.SFN_Subtract,id:9241,x:34815,y:31713,cmnt:Finds the difference between the highest and lowest color value. This is used to detect if our iput color is simply a shade of grey and has no color,varname:node_9241,prsc:2|A-4825-OUT,B-2959-OUT;n:type:ShaderForge.SFN_Lerp,id:8361,x:35092,y:31414,varname:node_8361,prsc:2|A-9001-OUT,B-6056-OUT,T-9241-OUT;n:type:ShaderForge.SFN_Multiply,id:4392,x:35425,y:31454,varname:node_4392,prsc:2|A-8361-OUT,B-1227-OUT;n:type:ShaderForge.SFN_Clamp,id:9092,x:33876,y:32382,cmnt:This lets the user adjust te maximum shadow. A value of 0.5 will limit it to half.,varname:node_9092,prsc:2|IN-5961-OUT,MIN-574-OUT,MAX-7877-OUT;n:type:ShaderForge.SFN_Vector1,id:7877,x:33568,y:32476,varname:node_7877,prsc:2,v1:1;n:type:ShaderForge.SFN_ValueProperty,id:593,x:33447,y:32587,ptovrint:False,ptlb:_LushLODTreeShadowDarkness,ptin:_LushLODTreeShadowDarkness,cmnt:_LusLODSadowDarkness... this is cotrolled by the manager in its Update function,varname:node_2612,prsc:2,glob:True,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,v1:1;n:type:ShaderForge.SFN_OneMinus,id:574,x:33646,y:32587,varname:node_574,prsc:2|IN-593-OUT;n:type:ShaderForge.SFN_Lerp,id:997,x:32439,y:30542,cmnt:Lets the user adjust the tie of day correction,varname:node_997,prsc:2|A-4950-OUT,B-944-OUT,T-5570-OUT;n:type:ShaderForge.SFN_Vector1,id:4950,x:32184,y:30557,varname:node_4950,prsc:2,v1:1;n:type:ShaderForge.SFN_ValueProperty,id:5570,x:32184,y:30629,ptovrint:False,ptlb:LushLODTreeTimeOfDay,ptin:_LushLODTreeTimeOfDay,varname:node_5174,prsc:2,glob:True,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,v1:1;n:type:ShaderForge.SFN_Multiply,id:969,x:30301,y:30100,varname:node_969,prsc:2|A-5065-RGB,B-3293-OUT;n:type:ShaderForge.SFN_Divide,id:3293,x:30054,y:30154,varname:node_3293,prsc:2|A-8331-OUT,B-2575-OUT;n:type:ShaderForge.SFN_Vector1,id:2575,x:29736,y:30166,varname:node_2575,prsc:2,v1:1.2;n:type:ShaderForge.SFN_Color,id:4531,x:33158,y:32035,ptovrint:False,ptlb:_LushLODTreeAmbientColor,ptin:_LushLODTreeAmbientColor,cmnt:_LushLODTreeAmbientColor... this value is set in the manager,varname:_LushLODTreeAmbientColor_copy,prsc:2,glob:True,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,c1:0.5,c2:0.5,c3:0.5,c4:1;proporder:6665-6298-5916;pass:END;sub:END;*/

Shader "Hidden/LushLODTree/Tree_Leaves_Far_Ultra_BB" {
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
        LOD 100
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
            uniform float _LushLODTreeDisableFarDithering;
            float Function_node_4742( float A , float B , float C ){
            return A > 0.5 ? B : C;
            }
            
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
            
            float ClipMe( float TexAlpha , float Cutoff ){
            clip(TexAlpha - Cutoff);
            return TexAlpha;
            }
            
            float GetDitherUltra_Caller( float2 SceneUVs , float Transparency ){
            return GetDitherUltraBB_MAINPASS(SceneUVs, Transparency);
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
                float Dithering = GetDitherUltra_Caller( sceneUVs.rg , Angular_Correction_MAINPASS ); // This is sent to the post processing shader.
                clip(Check_If_Shadow_Pass2( TexAlpha , lerp(TexAlpha,Dithering,_LushLODTreeDisableFarDithering) ) - 0.5);
////// Lighting:
                float node_9388 = TexAlpha;
                float node_9006 = 100.0;
                float PlaneNumber = round(Function_node_4742( node_9388 , ((node_9388-0.97)*node_9006) , (node_9388*node_9006) )); // A number identifying which plane this is
                float3 NomalDir = (i.normalDir*faceSign);
                float3 BiTanDir = CalculateBiTangent( PlaneNumber , NomalDir , i.tangentDir );
                float2 UV1_IN = i.uv1;
                float2 UV0_IN = i.uv0;
                float3 WorldPosCenter = GetWorldPositionCenter_Caller( BiTanDir , i.posWorld.rgb , i.tangentDir , UV1_IN , UV0_IN );
                float3 MainTexIN = node_3116_MAINPASS.rgb;
                float4 node_3117_MAINPASS = tex2D(_MainTex,TRANSFORM_TEX(i.uv2, _MainTex)); // Color and alpha from UV3 is used by the horizontal plane to draw the Line Z and part of the circle
                float4 UV3ColorIN = float4(node_3117_MAINPASS.rgb,node_3117_MAINPASS.a);
                float4 node_3118_MAINPASS = tex2D(_MainTex,TRANSFORM_TEX(i.uv3, _MainTex)); // Color and alpha from UV4 is used by all three planes to draw all or parts of their circlecrosses
                float4 UV4ColorIN = float4(node_3118_MAINPASS.rgb,node_3118_MAINPASS.a);
                float3 FinalColor_Corrected = GetSeamsBlending_Caller( BiTanDir , NomalDir , WorldPosCenter , PlaneNumber , MainTexIN , UV3ColorIN , UV4ColorIN , i.posWorld.rgb , viewDirection , i.tangentDir );
                float3 node_5176 = FinalColor_Corrected; // The main texture color with some modifications for things like seams blending.
                float3 LightIN = (_LushLODTreeMainLightCol.rgb*(_LushLODTreeMainLightIntensity/1.2));
                float3 LightDir = _LushLODTreeMainLightDir.rgb;
                float node_1391 = 0.5*dot(viewDirection,LightDir)+0.5; // Check if view is opposite the direction of sunlight
                float Backside_Darkening_Amount = node_1391; // Darkens the trees when viewed from the back side.
                float3 node_207 = lerp(((_LushLODTreeAmbientColor.rgb*node_5176)*0.8),(node_5176*(LightIN+_LushLODTreeAmbientColor.rgb)),clamp(Backside_Darkening_Amount,(1.0 - _LushLODTreeShadowDarkness),1.0)); // The final color with the shadows and ambient tint applied to the shadows
                float3 Param_Color = (_Color.rgb*2.0);
                float3 node_8960 = Param_Color.rgb; // The input color
                float node_2959 = min(min(node_8960.r,node_8960.g),node_8960.b); // Finds how much LESS than WHITE the input color is
                float node_7304 = 0.0;
                float node_1319 = 0.0;
                float TimeOfDayIntensity = lerp(1.0,saturate((node_1319 + ( (saturate((dot(float3(0,1,0),LightDir)+0.25)) - node_7304) * ((1.3+(Backside_Darkening_Amount*2.0)) - node_1319) ) / (1.0 - node_7304))),_LushLODTreeTimeOfDay); // This is an optional lighting adjustment you can remove this if your scene doesnt benefit from this.
                float3 finalColor = (lerp((node_207*node_8960),lerp((node_5176*node_8960),node_207,node_2959),(max(max(node_8960.r,node_8960.g),node_8960.b)-node_2959))*TimeOfDayIntensity);
                float Alpha_Output = min(TexAlpha,Angular_Correction_MAINPASS);
                fixed4 finalRGBA = fixed4(finalColor,(Alpha_Output*0.94+0.01));
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
            
            uniform float _LushLODTreeDisableFarDithering;
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
            
            float GetDitherUltra_Caller( float2 SceneUVs , float Transparency ){
            return GetDitherUltraBB_MAINPASS(SceneUVs, Transparency);
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
                float Dithering = GetDitherUltra_Caller( sceneUVs.rg , Angular_Correction_MAINPASS ); // This is sent to the post processing shader.
                clip(Check_If_Shadow_Pass2( TexAlpha , lerp(TexAlpha,Dithering,_LushLODTreeDisableFarDithering) ) - 0.5);
                SHADOW_CASTER_FRAGMENT(i)
            }
            ENDCG
        }
    }
    CustomEditor "ShaderForgeMaterialInspector"
}
