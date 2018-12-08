// Shader created with Shader Forge v1.38 
// Shader Forge (c) Neat Corporation / Joachim Holmer - http://www.acegikmo.com/shaderforge/
// Note: Manually altering this data may prevent you from opening it in Shader Forge
/*SF_DATA;ver:1.38;sub:START;pass:START;ps:flbk:,iptp:0,cusa:True,bamd:0,cgin:QwBHAEkAbgBjAGwAdQBkAGUAcwAvAFMAZQBhAG0AcwBCAGwAZQBuAGQAaQBuAGcAXwBOAG8AQQBuAGcAdQBsAGEAcgB8AEMARwBJAG4AYwBsAHUAZABlAHMALwBXAG8AcgBsAGQAUABvAHMAaQB0AGkAbwBuAEMAZQBuAHQAZQByAA==,lico:0,lgpr:1,limd:3,spmd:1,trmd:0,grmd:0,uamb:True,mssp:True,bkdf:False,hqlp:False,rprd:False,enco:False,rmgx:True,imps:True,rpth:1,vtps:0,hqsc:True,nrmq:1,nrsp:0,vomd:0,spxs:False,tesm:0,olmd:1,culm:2,bsrc:0,bdst:1,dpts:2,wrdp:True,dith:0,atcv:False,rfrpo:False,rfrpn:Refraction,coma:15,ufog:True,aust:True,igpj:False,qofs:0,qpre:2,rntp:3,fgom:False,fgoc:False,fgod:False,fgor:False,fgmd:0,fgcr:0.5657439,fgcg:0.6941743,fgcb:0.8014706,fgca:1,fgde:0.01,fgrn:0,fgrf:300,stcl:False,atwp:False,stva:191,stmr:255,stmw:255,stcp:6,stps:2,stfa:0,stfz:0,ofsf:0,ofsu:0,f2p0:False,fnsp:False,fnfb:True,fsmp:False;n:type:ShaderForge.SFN_Final,id:2865,x:37144,y:30960,varname:node_2865,prsc:2|emission-8231-OUT,clip-8572-OUT;n:type:ShaderForge.SFN_Color,id:6665,x:30065,y:31532,ptovrint:False,ptlb:Color,ptin:_Color,varname:_Color,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,c1:0.5019608,c2:0.5019608,c3:0.5019608,c4:1;n:type:ShaderForge.SFN_Tex2d,id:7736,x:31161,y:31777,varname:node_3116_MAINPASS,prsc:2,ntxv:0,isnm:False|TEX-6298-TEX;n:type:ShaderForge.SFN_Slider,id:5916,x:29921,y:31839,ptovrint:False,ptlb:Cutoff,ptin:_Cutoff,varname:_Cutoff,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,min:0,cur:0.7,max:1;n:type:ShaderForge.SFN_Tex2dAsset,id:6298,x:30572,y:31828,ptovrint:False,ptlb:MainTex,ptin:_MainTex,varname:_MainTex,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,ntxv:0,isnm:False;n:type:ShaderForge.SFN_ViewVector,id:628,x:30255,y:30973,varname:node_628,prsc:2;n:type:ShaderForge.SFN_Dot,id:1391,x:30461,y:31036,cmnt:Check if view is opposite the direction of sunlight,varname:node_1391,prsc:2,dt:4|A-628-OUT,B-7517-OUT;n:type:ShaderForge.SFN_Set,id:3191,x:31729,y:31881,varname:TexAlpha,prsc:2|IN-6824-OUT;n:type:ShaderForge.SFN_Set,id:7766,x:30262,y:31838,varname:Param_Cutoff,prsc:2|IN-5916-OUT;n:type:ShaderForge.SFN_Set,id:4973,x:31383,y:31777,varname:MainTexIN,prsc:2|IN-7736-RGB;n:type:ShaderForge.SFN_Tex2d,id:4547,x:30942,y:32187,cmnt:Color and alpha from UV3 is used by the horizontal plane to draw the Line Z and part of the circle,varname:node_3117_MAINPASS,prsc:2,ntxv:0,isnm:False|UVIN-327-UVOUT,TEX-6298-TEX;n:type:ShaderForge.SFN_TexCoord,id:327,x:30740,y:32196,varname:node_327,prsc:2,uv:2,uaff:False;n:type:ShaderForge.SFN_Set,id:9204,x:31373,y:32187,varname:UV3ColorIN,prsc:2|IN-6311-OUT;n:type:ShaderForge.SFN_Tex2d,id:9956,x:30942,y:32021,cmnt:Color and alpha from UV4 is used by all three planes to draw all or parts of their circlecrosses,varname:node_3118_MAINPASS,prsc:2,ntxv:0,isnm:False|UVIN-3765-UVOUT,TEX-6298-TEX;n:type:ShaderForge.SFN_TexCoord,id:3765,x:30740,y:32021,varname:node_3765,prsc:2,uv:3,uaff:False;n:type:ShaderForge.SFN_Set,id:1759,x:31373,y:32021,varname:UV4ColorIN,prsc:2|IN-1683-OUT;n:type:ShaderForge.SFN_Set,id:6719,x:30863,y:31132,cmnt:Darkens the trees when viewed from the back side.,varname:Backside_Darkening_Amount,prsc:2|IN-1391-OUT;n:type:ShaderForge.SFN_Set,id:7375,x:30443,y:31530,varname:Param_Color,prsc:2|IN-2327-OUT;n:type:ShaderForge.SFN_Set,id:4895,x:29636,y:32030,varname:FinalColor_Corrected,prsc:2|IN-3451-OUT;n:type:ShaderForge.SFN_Set,id:6116,x:29648,y:32689,varname:WorldPosCenter,prsc:2|IN-2910-OUT;n:type:ShaderForge.SFN_Code,id:9670,x:30334,y:32152,varname:node_9670,prsc:2,code:VABoAGUAIABjAG8AZABlACAAdABvACAAdABoAGUAIAByAGkAZwBoAHQAIABnAGUAdABzACAAdABoAGUAIABwAGkAeABlAGwACgBjAG8AbABvAHIAIABmAHIAbwBtACAAdABoAGUAIABVAFYAMwAgAGEAbgBkACAAVQBWADQALgAgAFQAaABlAHMAZQAgAFUAVgBzAAoAdwBlAHIAZQAgAGMAYQBsAGMAdQBsAGEAdABlAGQAIABlAHgAcAByAGUAcwBzAGwAeQAgAGIAeQAgAHQAaABlAAoATAB1AHMAaABMAE8ARABUAHIAZQBlAEMAbwBuAHYAZQByAHQAZQByAC4AYwBzACAAcwBjAHIAaQBwAHQAIAB3AGgAZQBuAAoAdABoAGUAIABiAGkAbABsAGIAbwBhAHIAZAAgAG0AZQBzAGgAIAB3AGEAcwAgAGMAcgBlAGEAdABlAGQALgAgAFQAaABlAHkACgBjAG8AbgB0AGEAaQBuACAAdABoAGkAbgAgAGwAaQBuAGUAcwAgACgAMQAgAHAAaQB4AGUAbAAgAHQAaABpAGMAawApAAoAYQBjAHIAbwBzAHMAIAB0AGgAZQAgAG0AZQBzAGgAIABwAGwAYQBuAGUAcwAgAGEAdAAgAHQAaABlACAAdgBhAHIAaQBvAHUAcwAKAGkAbgB0AGUAcgBzAGUAYwB0AGkAbwBuAHMALAAgAGEAbgBkACAAYQByAGUAIAB1AHMAZQBkACAAdABvACAAcABhAHMAcwAKAHQAaABlACAAYwBvAGwAbwByACAAbwBmACAAbwBuAGUAIABwAGwAYQBuAGUAIABvAHYAZQByACAAdABvACAAdABoAGUACgBvAHQAaABlAHIAIABwAGwAYQBuAGUALAAgAHMAbwAgAHQAaABhAHQAIABlAGEAYwBoACAAcABsAGEAbgBlACAAYwBhAG4ACgBiAGwAZQBuAGQAIAB3AGkAdABoACAAdABoAGUAIABvAHQAaABlAHIALgAKAAoAVABoAGUAIABIAG8AcgBpAHoAbwBuAHQAYQBsACAAcABsAGEAbgBlACAAaQBuAHQAZQByAHMAZQBjAHQAcwAgAGEAbgBkAAoAYgBsAGUAbgBkAHMAIAB3AGkAdABoACAAYgBvAHQAaAAgAHQAaABlACAARgBPAFIAVwBBAFIARAAgAGEAbgBkACAAUgBJAEcASABUAAoAcABsAGEAbgBlAHMALgAgAFQAaAB1AHMALAAgAGkAdAAgAGIAbABlAG4AZABzACAAdQBzAGkAbgBnACAAdAB3AG8AIABsAGkAbgBlAHMALAAgAAoAdwBpAHQAaAAgAG8AbgBlACAAbABpAG4AZQAgAGEAbABvAG4AZwAgAGUAYQBjAGgAIABvAGYAIAB0AGgAbwBzAGUACgBlAGQAZwBlAHMALgAgAFQAaABlACAAcABpAHgAZQBsAHMAIABmAG8AcgAgAHQAaABvAHMAZQAgAGwAaQBuAGUAcwAgAGEAcgBlAAoAcwBhAHYAZQBkACAAaQBuACAAVQBWADMAIABhAG4AZAAgAFUAVgA0ACAAcgBlAHMAcABlAGMAdABpAHYAZQBsAHkALgAKAAoARgBvAHIAIAB0AGgAZQAgAEYATwBSAFcAQQBSAEQAIABhAG4AZAAgAFIASQBHAEgAVAAgAHAAbABhAG4AZQBzACwAIAB0AGgAZQB5AAoAYgBsAGUAbgBkACAAbwBuAGwAeQAgAHcAaQB0AGgAIAB0AGgAZQAgAGgAbwByAGkAegBvAG4AdABhAGwAIABwAGwAYQBuAGUALAAKAGEAbgBkACAAdABoAHUAcwAgAHQAaABlAHkAIABvAG4AbAB5ACAAZAByAGEAdwAgAG8AbgBlACAAbABpAG4AZQAuACAAQQBuAGQACgBlAHYAZQBuACAAdABoAG8AdQBnAGgAIAB0AGgAbwBzAGUAIABsAGkAbgBlAHMAIABnAG8AIABkAGkAZgBmAGUAcgBlAG4AdAAKAGQAaQByAGUAYwB0AGkAbwBuAHMALAAgAEkAIAB3AGEAcwAgAGEAYgBsAGUAIAB0AG8AIABzAGEAdgBlACAAYQBsAGwACgB0AGgAYQB0ACAAZABhAHQAYQAgAGkAbgB0AG8AIABqAHUAcwB0ACAAVQBWADQAIABmAG8AcgAgAHQAaABlAGkAcgAgAHUAcwBlAC4A,output:2,fname:UV3_and_UV4,width:322,height:384;n:type:ShaderForge.SFN_Get,id:8572,x:36350,y:31533,varname:node_8572,prsc:2|IN-3191-OUT;n:type:ShaderForge.SFN_Set,id:5415,x:29390,y:30930,cmnt:A number identifying which plane this is,varname:PlaneNumber,prsc:2|IN-1192-OUT;n:type:ShaderForge.SFN_Code,id:7485,x:27760,y:30936,varname:node_7485,prsc:2,code:VABoAGUAIABjAG8AZABlACAAdABvACAAdABoAGUAIAByAGkAZwBoAHQAIABmAGkAZwB1AHIAZQBzACAAbwB1AHQACgB3AGgAaQBjAGgAIABwAGwAYQBuAGUAIAB0AGgAZQAgAHMAaABhAGQAZQByACAAaQBzACAAdwBvAHIAawBpAG4AZwAgAG8AbgAKAHIAaQBnAGgAdAAgAG4AbwB3AC4AIABUAG8AIABmAGkAZwB1AHIAZQAgAHQAaABpAHMAIABvAHUAdAAgAHcAaQB0AGgAbwB1AHQACgB0AG8AbwAgAG0AdQBjAGgAIABhAGQAbwAsACAAdwBlACAAcwBhAHYAZQBkACAAaQB0ACAAaQBuAHQAbwAgAHQAaABlAAoAdABlAHgAdAB1AHIAZQAnAHMAIABhAGwAcABoAGEAIABjAGgAYQBuAG4AZQBsAC4ACgAKADAALgAwADEAIABhAGwAcABoAGEAIABpAHMAIABhACAAdAByAGEAbgBzAHAAYQByAGUAbgB0ACAAcABpAHgAZQBsACAAbwBuACAARgBPAFIAVwBBAFIARAAgAHAAbABhAG4AZQAuAAoAMAAuADAAMgAgAGEAbABwAGgAYQAgAGkAcwAgAGEAIAB0AHIAYQBuAHMAcABhAHIAZQBuAHQAIABwAGkAeABlAGwAIABvAG4AIABSAEkARwBIAFQAIABwAGwAYQBuAGUALgAKADAALgAwADMAIABhAGwAcABoAGEAIABpAHMAIABhACAAdAByAGEAbgBzAHAAYQByAGUAbgB0ACAAcABpAHgAZQBsACAAbwBuACAAVABPAFAAIABwAGwAYQBuAGUALgAKADAALgA5ADgAIABpAHMAIABhAG4AIABvAHAAYQBxAHUAZQAgAHAAaQB4AGUAbAAgAG8AbgAgAEYATwBSAFcAQQBSAEQAIABwAGwAYQBuAGUALgAKADAALgA5ADkAIABpAHMAIABhAG4AIABvAHAAYQBxAHUAZQAgAHAAaQB4AGUAbAAgAG8AbgAgAFIASQBHAEgAVAAgAHAAbABhAG4AZQAuAAoAMQAuADAAMAAgAGkAcwAgAGEAbgAgAG8AcABhAHEAdQBlACAAcABpAHgAZQBsACAAbwBuACAAVABPAFAAIABwAGwAYQBuAGUALgA=,output:2,fname:PlaneNumberInfo,width:412,height:196;n:type:ShaderForge.SFN_If,id:8837,x:29021,y:30905,varname:node_8837,prsc:2|A-9388-OUT,B-4470-OUT,GT-6426-OUT,EQ-6237-OUT,LT-6237-OUT;n:type:ShaderForge.SFN_Get,id:9388,x:28225,y:30873,varname:node_9388,prsc:2|IN-3191-OUT;n:type:ShaderForge.SFN_Vector1,id:4470,x:28739,y:30857,varname:node_4470,prsc:2,v1:0.5;n:type:ShaderForge.SFN_Multiply,id:6237,x:28636,y:31183,varname:node_6237,prsc:2|A-9388-OUT,B-9006-OUT;n:type:ShaderForge.SFN_Vector1,id:9006,x:28445,y:31198,varname:node_9006,prsc:2,v1:100;n:type:ShaderForge.SFN_Subtract,id:1104,x:28529,y:30922,varname:node_1104,prsc:2|A-9388-OUT,B-2827-OUT;n:type:ShaderForge.SFN_Vector1,id:2827,x:28269,y:30968,varname:node_2827,prsc:2,v1:0.97;n:type:ShaderForge.SFN_Multiply,id:6426,x:28739,y:30933,varname:node_6426,prsc:2|A-1104-OUT,B-9006-OUT;n:type:ShaderForge.SFN_Round,id:1192,x:29198,y:30905,varname:node_1192,prsc:2|IN-8837-OUT;n:type:ShaderForge.SFN_Multiply,id:2327,x:30265,y:31530,cmnt:Inputting 0.5 will multiply by 1 which has no effect. Less than 0.5 will darken from 0 to 1 and above 0.5 will brighten by multiplying from 1 to 2x.,varname:node_2327,prsc:2|A-6665-RGB,B-4804-OUT;n:type:ShaderForge.SFN_Vector1,id:4804,x:30060,y:31433,varname:node_4804,prsc:2,v1:2;n:type:ShaderForge.SFN_RemapRange,id:8022,x:30658,y:31079,cmnt:Rescales it to 0.7 to 1 multiplied by 0.75 which yields 0.525 to 0.75,varname:node_8022,prsc:2,frmn:-1,frmx:1,tomn:0.525,tomx:0.75|IN-1391-OUT;n:type:ShaderForge.SFN_Code,id:5350,x:32139,y:31761,varname:node_5350,prsc:2,code:VwBlAGwAYwBvAG0AZQAgAHQAbwAgAHQAaABlACAAVQBsAHQAcgBhACAAcwBoAGEAZABlAHIAIQAgAFQAaABpAHMAIABzAGgAYQBkAGUAcgAgAGkAcwAgAHMAaQBtAGkAbABhAHIAIAB0AG8AIAB0AGgAZQAgAG4AbwBuAC0AdQBsAHQAcgBhACAAcwBoAGEAZABlAHIAcwANAAoAZQB4AGMAZQBwAHQAIAB0AGgAYQB0ACAAaQB0ACAAdQBzAGUAcwAgAGEAIABwAG8AcwB0AC0AcAByAG8AYwBlAHMAcwBpAG4AZwAgAGUAZgBmAGUAYwB0ACAAdABvACAAaABhAG4AZABsAGUAIABhAGwAbAAgAG8AZgAgAHQAaABlACAAdAByAGEAbgBzAHAAYQByAGUAbgBjAHkADQAKAGYAZQBhAHQAdQByAGUAcwAuACAASABlAHIAZQAnAHMAIABoAG8AdwAgAGkAdAAgAHcAbwByAGsAcwAuAA0ACgANAAoAVABoAGUAIABvAHQAaABlAHIAIABzAGgAYQBkAGUAcgBzACAAdQBzAGUAIABkAGkAdABoAGUAcgBpAG4AZwAgAGkAbgAgAHYAYQByAGkAbwB1AHMAIABhAG0AbwB1AG4AdABzACAAdABvACAAYwByAGUAYQB0AGUAIABhACAAcwBvAHIAdAAgAG8AZgAgACIAZgBhAGsAZQAiAA0ACgB0AHIAYQBuAHMAcABhAHIAZQBuAGMAeQAuACAARgBvAHIAIABtAG8AcgBlACAAbwBwAGEAcQB1AGUAIABhAHIAZQBhAHMALAAgAHQAaABlAHkAIABzAGkAbQBwAGwAeQAgAGQAcgBhAHcAIABtAG8AcgBlACAAcwBvAGwAaQBkACAAcABpAHgAZQBsAHMALgAgAEIAdQB0AA0ACgBmAG8AcgAgAG0AbwByAGUAIAB0AHIAYQBuAHMAcABhAHIAZQBuAHQAIABhAHIAZQBhAHMALAAgAHQAaABlAHkAIABjAGwAaQBwACgAKQAgAG0AbwByAGUAIABwAGkAeABlAGwAcwAsACAAdwBoAGkAYwBoACAAYQBsAGwAbwB3AHMAIAB5AG8AdQAgAHQAbwAgAHMAZQBlAA0ACgB0AGgAcgBvAHUAZwBoACAAdABoAGUAIABtAGUAcwBoACwAIAB0AGgAdQBzACAAYwByAGUAYQB0AGkAbgBnACAAYQBuACAAaQBsAGwAdQBzAGkAbwBuACAAbwBmACAAdAByAGEAbgBzAHAAYQByAGUAbgBjAHkALgANAAoADQAKAFQAaABpAHMAIAAiAHUAbAB0AHIAYQAiACAAcwBoAGEAZABlAHIAIABkAG8AZQBzACAAYQAgAHMAaQBtAGkAbABhAHIAIAB0AGgAaQBuAGcALAAgAG8AbgBsAHkAIABkAGkAZgBmAGUAcgBlAG4AYwBlACAAaQBzACAAdABoAGEAdAAgAGkAdAAgAGQAbwBlAHMAIABuAG8AdAANAAoAYwBsAGkAcAAgAHQAaABlACAAcABpAHgAZQBsAHMAIABtAG8AcgBlACAAbwByACAAbABlAHMAcwAgAHQAbwAgAGMAcgBlAGEAdABlACAAdABoAGUAIAB2AGEAcgBpAG8AdQBzACAAYQBtAG8AdQBuAHQAcwAgAG8AZgAgAHQAcgBhAG4AcwBwAGEAcgBlAG4AYwB5AC4ADQAKAEkAbgBzAHQAZQBhAGQALAAgAHQAaABpAHMAIABzAGgAYQBkAGUAcgAgAGEAbAB3AGEAeQBzACAAYwBsAGkAcABzACAAdABoAGUAIABwAGkAeABlAGwAcwAgAGUAeABhAGMAdABsAHkAIAA1ADAAJQAsACAAbQBlAGEAbgBpAG4AZwAgAGkAdAAgAGMAbABpAHAAcwANAAoAZQB2AGUAcgB5ACAAbwB0AGgAZQByACAAcABpAHgAZQBsACwAIABpAG4AIABhACAAcABlAHIAZgBlAGMAdABsAHkAIABjAGgAZQBjAGsAZQByAGQAYgBvAGEAcgBkACAAcABhAHQAdABlAHIAbgAuACAAUwBvACAAcgBlAGcAYQByAGQAbABlAHMAcwAgAG8AZgANAAoAaABvAHcAIABtAHUAYwBoACAAdAByAGEAbgBzAHAAYQByAGUAbgBjAHkAIABpAG4AIABzAHUAcABwAG8AcwBlAGQAIAB0AG8AIABiAGUAIABpAG4AIABhAG4AeQAgAHAAYQByAHQAaQBjAHUAbABhAHIAIABhAHIAZQBhACwAIABpAHQAIABzAHQAaQBsAGwADQAKAGMAbABpAHAAcwAgAGkAdAAgAGUAeABhAGMAdABsAHkAIAB0AG8AIABhACAAYwBoAGUAYwBrAGUAcgBkAGIAbwBhAHIAZAAgAHAAYQB0AHQAZQByAG4ALgAgAEkAdAAgAGEAbABzAG8AIABzAGEAdgBlAHMAIAB0AGgAZQAgAGEAbQBvAHUAbgB0ACAAbwBmAA0ACgB0AHIAYQBuAHMAcABhAHIAZQBuAGMAeQAgAGkAbgB0AG8AIAB0AGgAZQAgAGEAbABwAGgAYQAgAGMAaABhAG4AbgBlAGwAIABvAGYAIAB0AGgAZQAgAG8AdQB0AHAAdQB0ACAAYwBvAGwAbwByACAAZgBvAHIAIABlAHYAZQByAHkAIABwAGkAeABlAGwALgANAAoAQQBuAGQAIABmAHUAcgB0AGgAZQByAG0AbwByAGUALAAgAHQAaABpAHMAIABzAGgAYQBkAGUAcgAgAG4AZQB2AGUAcgAgAG8AdQB0AHAAdQB0AHMAIABhACAAZgB1AGwAbAB5ACAAbwBwAGEAcQB1AGUAIABjAG8AbABvAHIALgAgAEkAdAAgAGMAYQBuAA0ACgByAGEAbgBnAGUAIABmAHIAbwBtACAAegBlAHIAbwAgACgAMAApACAAdABvACAAYQAgAG0AYQB4AGkAbQB1AG0AIABvAHAAYQBjAGkAdAB5ACAAbwBmACAAMAAuADkAOQAsACAAYgB1AHQAIABuAGUAdgBlAHIAIAAxACAAKAB0AGgAYQB0ACAAdwBvAHUAbABkACAAYgBlAA0ACgBmAHUAbABsAHkAIABvAHAAYQBxAHUAZQApAC4AIABUAGgAZQAgAHIAZQBhAHMAbwBuACAAZgBvAHIAIAB0AGgAZQAgAGgAYQByAGQAIABsAGkAbQBpAHQAIABvAGYAIAAwAC4AOQA5ACAAdwBpAGwAbAAgAGIAZQAgAGUAeABwAGwAYQBpAG4AZQBkACAAYgBlAGwAbwB3AC4ADQAKAA0ACgBOAG8AdwAsACAAcwBpAG4AYwBlACAAdABoAGkAcwAgAHMAaABhAGQAZQByACAAaQBzACAAcwBlAHQAIAB0AG8AIABBAGwAcABoAGEAIABDAGwAaQBwACAAbwByAGQAZQByACwAIABhAG4AZAAgAE8AcABhAHEAdQBlACAAYgBsAGUAbgBkAGkAbgBnACAAbQBvAGQAZQAsAA0ACgB0AGgAZQByAGUAIABpAHMAIABuAG8AIABhAHUAdABvAG0AYQB0AGkAYwAgAHQAcgBhAG4AcwBwAGEAcgBlAG4AYwB5ACAAcAByAG8AdgBpAGQAZQBkACAAYgB5ACAAVQBuAGkAdAB5ACcAcwAgAHIAZQBuAGQAZQByAGUAcgAuACAARQB2AGUAbgAgAHQAaABvAHUAZwBoACAAdwBlAA0ACgBzAGUAdAAgAHQAaABlACAAYQBsAHAAaABhACAAYwBoAGEAbgBuAGUAbAAgAG8AZgAgAHQAaABlACAAbwB1AHQAcAB1AHQAIABjAG8AbABvAHIAIAB0AG8AIABzAG8AbQBlAHcAaABhAHQAIAB0AHIAYQBuAHMAcABhAHIAZQBuAHQALAAgAHQAaABlACAAdAByAGUAZQAgAHcAaQBsAGwADQAKAGIAZQAgAGYAdQBsAGwAeQAgAGQAcgBhAHcAbgAgAG4AbwBuAGUAdABoAGUAbABlAHMAcwAuACAAQgB1AHQAIAB0AGgAYQB0ACAAYQBsAHAAaABhACAAYwBoAGEAbgBuAGUAbAAgAHcAaQBsAGwAIABiAGUAIABzAGEAdgBlAGQAIAB0AG8AIAB0AGgAZQAgAHAAaQB4AGUAbAAsAA0ACgB3AGkAdABoACAAdABoAGUAIABoAGEAcgBkACAAbABpAG0AaQB0ACAAbwBmACAAMAAuADkAOQAuACAAQQBuAGQAIAB0AGgAZQAgAGMAaABlAGMAawBlAHIAZABiAG8AYQByAGQAIABkAGkAdABoAGUAcgBpAG4AZwAgAHcAaQBsAGwAIABsAGUAdAAgAHUAcwAgAA0ACgBzAG8AbQBlAHcAaABhAHQAIABzAGUAZQAgAHQAaAByAG8AdQBnAGgAIAB0AGgAaQBzACAAdAByAGUAZQAsACAAYgB1AHQAIABpAHQAIAB3AG8AbgAnAHQAIABsAG8AbwBrACAAdgBlAHIAeQAgAGcAbwBvAGQAIAAtAC0AIAB5AGUAdAAhAA0ACgANAAoATABhAHMAdAAgAGIAdQB0ACAAbgBvAHQAIABsAGUAYQBzAHQALAAgAGEAbABsACAAIgB1AGwAdAByAGEAIgAgAHMAaABhAGQAZQByAHMAIAB3AGkAbABsACAAdwByAGkAdABlACAAYQAgAHYAYQBsAHUAZQAgAHQAbwAgAHQAaABlACAAcwB0AGUAbgBjAGkAbAANAAoAYgB1AGYAZgBlAHIALgAgAE4AZQB4AHQAIAB3AGUAJwBsAGwAIAB1AHMAZQAgAHQAaABpAHMALAAgAGkAbgAgAGMAbwBtAGIAaQBuAGEAdABpAG8AbgAgAHcAaQB0AGgAIAB0AGgAYQB0ACAAaABhAHIAZAAgAGwAaQBtAGkAdAAgAG8AZgAgADAALgA5ADkAIABhAGwAcABoAGEALAANAAoAdABvACAAaQBkAGUAbgB0AGkAZgB5ACAAdwBoAGUAcgBlACAAdABoAGUAIAB0AHIAZQBlAHMAIABhAHIAZQAgAG8AbgAgAHQAaABlACAAcwBjAHIAZQBlAG4ALgANAAoADQAKAE4AZQB4AHQAIAB3AGUAIABhAHQAdABhAGMAaAAgAHQAbwAgAHQAaABlACAAbQBhAGkAbgAgAGMAYQBtAGUAcgBhACAAdABoAGUAIABzAGMAcgBpAHAAdAAgAF8ATAB1AHMAaABMAE8ARABQAG8AcwB0AFAAcgBvAGMAZQBzAHMALgBjAHMALAAgAHcAaABpAGMAaAAgAHcAaQBsAGwADQAKAHIAdQBuACAAcwBlAHYAZQByAGEAbAAgAHAAbwBzAHQAIABwAHIAbwBjAGUAcwBzAGkAbgBnACAAcABhAHMAcwBlAHMAIABvAHYAZQByACAAdABoAGUAIABmAGkAbgBhAGwAIABpAG0AYQBnAGUALgAgAEkAbgAgAHQAaABlACAAZgBpAHIAcwB0ACAAcABhAHMAcwAsACAAaQB0AA0ACgB3AGkAbABsACAAbABvAG8AawAgAGYAbwByACAAdABoAGEAdAAgAHMAdABlAG4AYwBpAGwAIAB2AGEAbAB1AGUAIAB0AG8AIABmAGkAbgBkACAAZQB2AGUAcgB5ACAAbgBvAG4ALQB0AHIAZQBlACAAcABpAHgAZQBsACwAIABhAG4AZAAgAGkAdAAgAHcAaQBsAGwAIABzAGUAdAAgAGEAbABsAA0ACgBuAG8AbgAtAHQAcgBlAGUAIABwAGkAeABlAGwAcwAgAHQAbwAgAGEAIABhAGwAcABoAGEAIAB2AGEAbAB1AGUAIABvAGYAIAAxAC4AIABPAG4AYwBlACAAdABoAGEAdAAnAHMAIABkAG8AbgBlACwAIAB3AGUAIABkAG8AbgAnAHQAIABuAGUAZQBkACAAdABvACAAdQBzAGUADQAKAHQAaABlACAAcwB0AGUAbgBjAGkAbAAgAGIAdQBmAGYAZQByACAAYQBuAHkAbQBvAHIAZQAsACAAYgBlAGMAYQB1AHMAZQAgAHcAZQAgAG4AbwB3ACAAawBuAG8AdwAgAHQAaABhAHQAIABhAGwAbAAgAG4AbwBuAC0AdAByAGUAZQAgAHAAaQB4AGUAbABzACAAYQByAGUADQAKAGYAdQBsAGwAeQAgAG8AcABhAHEAdQBlACwAIABhAG4AZAAgAGEAbABsACAAdAByAGUAZQAgAHAAaQB4AGUAbABzACAAYQByAGUAIABzAG8AbQBlAHcAaABhAHQAIAB0AHIAYQBuAHMAcABhAHIAZQBuAHQALAAgAGQAdQBlACAAdABvACAAdABoAGEAdAAgAGgAYQByAGQADQAKAGwAaQBtAGkAdAAgAG8AZgAgADAALgA5ADkAIABpAG4AIAB0AGgAZQAgAGEAbABwAGgAYQAgAG8AbgAgAGEAbABsACAAdAByAGUAZQAgAHAAaQB4AGUAbABzAC4ADQAKAA0ACgBOAGUAeAB0ACwAIAB0AGgAZQAgAHMAYwByAGkAcAB0ACAAdwBpAGwAbAAgAHIAdQBuACAAdABoAGUAIABwAG8AcwB0AC0AcAByAG8AYwBlAHMAcwBpAG4AZwAgAHMAaABhAGQAZQByACAAbwB2AGUAcgAgAHQAaABlACAAdwBoAG8AbABlACAAaQBtAGEAZwBlACwAIAANAAoAYQBuAGQAIABpAHQAIAB3AGkAbABsACAAcwBhAG0AcABsAGUAIABtAHUAbAB0AGkAcABsAGUAIABwAGkAeABlAGwAcwAgAGkAbgAgAGEAIABzAG0AYQBsAGwAIABhAHIAZQBhACAAdABvACAAcwBtAG8AbwB0AGgAbAB5ACAAYgBsAGUAbgBkACAAYQB3AGEAeQAgAHQAaABhAHQADQAKAGMAaABlAGMAawBlAHIAZABiAG8AYQByAGQAIABkAGkAdABoAGUAcgBpAG4AZwAgAHAAYQB0AHQAZQByAG4ALAAgAGEAbgBkACAAYwByAGUAYQB0AGUAIABwAGUAcgBmAGUAYwB0AGwAeQAgAHMAbQBvAG8AdABoACAAbABvAG8AawBpAG4AZwAgAHQAcgBhAG4AcwBwAGEAcgBlAG4AYwB5AC4ADQAKAFQAaABpAHMAIAB0AHIAYQBuAHMAcABhAHIAZQBuAGMAeQAgAGkAcwAsACAAdwBlAGwAbAAsACAAIgBhAHcAZQBzAG8AbQBlACIAIABiAGUAYwBhAHUAcwBlACAAaQB0ACcAcwAgAHcAbwByAGsAaQBuAGcAIABvAG4AIAB0AHIAZQBlAHMAIAB0AGgAYQB0ACAAYQByAGUADQAKAGkAbgAgAHQAaABlACAAZwBlAG8AbQBlAG4AdAByAHkAIABvAHIAIABBAGwAcABoAGEAIABDAGwAaQBwACAAbwByAGQAZQByACwAIAB3AGkAdABoACAAZABlAHAAdABoACAAYgB1AGYAZgBlAHIAaQBuAGcAIABhAGMAdABpAHYAZQAuACAAVABoAGkAcwAgAGMAcgBlAGEAdABlAHMAIAAKAHYAZQByAHkAIAAzAEQAIABsAG8AbwBrAGkAbgBnAA0AIABiAGkAbABsAGIAbwBhAHIAZABzACAAKAB0AGgAZQB5ACAAdwBvAG4AJwB0ACAAbABvAG8AawAgAG8AcgAgAGEAYwB0ACAAbABpAGsAZQAgACIAcABhAHIAdABpAGMAbABlAHMAIgApACwAIAB5AGUAdAAgAHcAaQB0AGgAIAAKAHQAaABlACAAaABlAGwAcAAgAG8AZgAgAHQAaABlAA0AIABwAG8AcwB0ACAAcAByAG8AYwBlAHMAcwBpAG4AZwAgAGUAZgBmAGUAYwB0ACwAIAB0AGgAZQB5ACAAaABhAHYAZQAgAGEAbABtAG8AcwB0ACAAcABpAHgAZQBsAC0AcABlAHIAZgBlAGMAdAAgAHQAcgBhAG4AcwBwAGEAcgBlAG4AYwB5AC4ACgBFAG4AagBvAHkAIQA=,output:2,fname:Ultra_Shader_Readme,width:629,height:656;n:type:ShaderForge.SFN_Set,id:4246,x:30675,y:30072,varname:LightIN,prsc:2|IN-8149-OUT;n:type:ShaderForge.SFN_Vector4Property,id:2890,x:29553,y:30409,ptovrint:False,ptlb:_LushLODTreeMainLightDir,ptin:_LushLODTreeMainLightDir,cmnt:The W is set via script in _LushLODTreesManager.cs,varname:node_8259,prsc:2,glob:True,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,v1:0.5,v2:0.5,v3:0.5,v4:1;n:type:ShaderForge.SFN_Color,id:5065,x:29553,y:30113,ptovrint:False,ptlb:LushLODTreeMainLightCol,ptin:_LushLODTreeMainLightCol,cmnt:This works even with lightmaps,varname:node_349,prsc:2,glob:True,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,c1:0.5,c2:0.5,c3:0.5,c4:1;n:type:ShaderForge.SFN_ValueProperty,id:8331,x:29553,y:30294,ptovrint:False,ptlb:LushLODTreeMainLightIntensity,ptin:_LushLODTreeMainLightIntensity,cmnt:This works even with lightmaps,varname:node_5384,prsc:2,glob:True,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,v1:1;n:type:ShaderForge.SFN_Set,id:7610,x:29877,y:30415,varname:LightDir,prsc:2|IN-2890-XYZ;n:type:ShaderForge.SFN_Get,id:7517,x:30234,y:31119,varname:node_7517,prsc:2|IN-7610-OUT;n:type:ShaderForge.SFN_Dot,id:6883,x:31051,y:30557,cmnt:Is the sun above the horizon?,varname:node_6883,prsc:2,dt:0|A-5023-OUT,B-1999-OUT;n:type:ShaderForge.SFN_Get,id:1999,x:30818,y:30603,varname:node_1999,prsc:2|IN-7610-OUT;n:type:ShaderForge.SFN_Vector3,id:5023,x:30818,y:30490,cmnt:Checks if the light is shining straight down,varname:node_5023,prsc:2,v1:0,v2:1,v3:0;n:type:ShaderForge.SFN_Clamp01,id:8079,x:31615,y:30561,varname:node_8079,prsc:2|IN-3381-OUT;n:type:ShaderForge.SFN_Clamp01,id:944,x:32079,y:30405,varname:node_944,prsc:2|IN-5641-OUT;n:type:ShaderForge.SFN_Set,id:6203,x:32679,y:30431,cmnt:This is an optional lighting adjustment you can remove this if your scene doesnt benefit from this.,varname:TimeOfDayIntensity,prsc:2|IN-9263-OUT;n:type:ShaderForge.SFN_Add,id:3381,x:31430,y:30561,cmnt:This makes the trees not get dark until the sun is somewhat BELOW the horizon.,varname:node_3381,prsc:2|A-6883-OUT,B-9176-OUT;n:type:ShaderForge.SFN_Vector1,id:9176,x:31242,y:30595,varname:node_9176,prsc:2,v1:0.25;n:type:ShaderForge.SFN_RemapRangeAdvanced,id:5641,x:31878,y:30405,cmnt:Rescales it from 01 to about 03 to make it get brigher faster as the sun comes up. This effect is significantly stronger on the sunny side via backside darkening.,varname:node_5641,prsc:2|IN-8079-OUT,IMIN-7304-OUT,IMAX-1122-OUT,OMIN-1319-OUT,OMAX-5960-OUT;n:type:ShaderForge.SFN_Vector1,id:7304,x:31615,y:30256,varname:node_7304,prsc:2,v1:0;n:type:ShaderForge.SFN_Vector1,id:1122,x:31615,y:30305,varname:node_1122,prsc:2,v1:1;n:type:ShaderForge.SFN_Vector1,id:1319,x:31615,y:30360,varname:node_1319,prsc:2,v1:0;n:type:ShaderForge.SFN_Vector1,id:6195,x:31412,y:30316,varname:node_6195,prsc:2,v1:1.3;n:type:ShaderForge.SFN_Add,id:5960,x:31615,y:30410,varname:node_5960,prsc:2|A-6195-OUT,B-9849-OUT;n:type:ShaderForge.SFN_Get,id:3328,x:31235,y:30318,varname:node_3328,prsc:2|IN-6719-OUT;n:type:ShaderForge.SFN_Multiply,id:9849,x:31412,y:30382,varname:node_9849,prsc:2|A-3328-OUT,B-9983-OUT;n:type:ShaderForge.SFN_Vector1,id:9983,x:31235,y:30401,varname:node_9983,prsc:2,v1:2;n:type:ShaderForge.SFN_NormalVector,id:4106,x:29294,y:31436,prsc:2,pt:False;n:type:ShaderForge.SFN_Set,id:9266,x:29688,y:31536,varname:NomalDir,prsc:2|IN-303-OUT;n:type:ShaderForge.SFN_FaceSign,id:1583,x:29294,y:31582,varname:node_1583,prsc:2,fstp:1;n:type:ShaderForge.SFN_Multiply,id:303,x:29518,y:31519,cmnt:Stop it from reversing the normal when viewed from backface.,varname:node_303,prsc:2|A-4106-OUT,B-1583-VFACE;n:type:ShaderForge.SFN_Vector1,id:9305,x:36350,y:31445,cmnt:Normally youd connect this to Opacity but shader forge will switch the shader to 3000 queue if you do that which messes up stuff... and we dont need to connec this since the default opacity is 1 anyway.,varname:node_9305,prsc:2,v1:1;n:type:ShaderForge.SFN_Code,id:3451,x:29149,y:32027,cmnt:Note GetSeamsBlending is in SeamsBlending.cginc,varname:node_3451,prsc:2,code:cgBlAHQAdQByAG4AIABHAGUAdABTAGUAYQBtAHMAQgBsAGUAbgBkAGkAbgBnAF8ATgBvAEEAbgBnAHUAbABhAHIACQAKAAkAKAAJAAoACQAJAEIAaQBUAGEAbgBEAGkAcgAsAAoACQAJAE4AbwByAG0AYQBsAEkATgAsAAoACQAJAFcAbwByAGwAZABQAG8AcwBDAGUAbgB0AGUAcgAsAAoACQAJAFAAbABhAG4AZQBOAHUAbQBiAGUAcgAsAAoACQAJAEYAaQBuAGEAbABDAG8AbABvAHIASQBOACwACgAJAAkAVQBWADMAQwBvAGwAbwByACwACgAJAAkAVQBWADQAQwBvAGwAbwByACwACgAJAAkAVwBvAHIAbABkAFAAbwBzACwACgAJAAkAVABhAG4ARABpAHIACgAJACkALgByAGcAYgA7AA==,output:2,fname:GetSeamsBlending_Caller,width:384,height:237,input:2,input:2,input:2,input:0,input:2,input:3,input:3,input:2,input:2,input_1_label:BiTanDir,input_2_label:NormalIN,input_3_label:WorldPosCenter,input_4_label:PlaneNumber,input_5_label:FinalColorIN,input_6_label:UV3Color,input_7_label:UV4Color,input_8_label:WorldPos,input_9_label:TanDir|A-9482-OUT,B-4401-OUT,C-9958-OUT,D-9752-OUT,E-4566-OUT,F-1867-OUT,G-5675-OUT,H-1798-XYZ,I-2851-OUT;n:type:ShaderForge.SFN_Get,id:4401,x:28675,y:31962,varname:node_4401,prsc:2|IN-9266-OUT;n:type:ShaderForge.SFN_Get,id:9958,x:28675,y:32005,varname:node_9958,prsc:2|IN-6116-OUT;n:type:ShaderForge.SFN_Get,id:9752,x:28675,y:32050,varname:node_9752,prsc:2|IN-5415-OUT;n:type:ShaderForge.SFN_Get,id:4566,x:28675,y:32095,varname:node_4566,prsc:2|IN-4973-OUT;n:type:ShaderForge.SFN_Get,id:1867,x:28675,y:32139,varname:node_1867,prsc:2|IN-9204-OUT;n:type:ShaderForge.SFN_Get,id:5675,x:28675,y:32182,varname:node_5675,prsc:2|IN-1759-OUT;n:type:ShaderForge.SFN_FragmentPosition,id:1798,x:28675,y:32232,varname:node_1798,prsc:2;n:type:ShaderForge.SFN_Tangent,id:2851,x:28675,y:32348,varname:node_2851,prsc:2;n:type:ShaderForge.SFN_Bitangent,id:9482,x:28663,y:31846,varname:node_9482,prsc:2;n:type:ShaderForge.SFN_Code,id:2910,x:29135,y:32684,cmnt:Note GetSeamsBlending is in SeamsBlending.cginc,varname:node_2910,prsc:2,code:cgBlAHQAdQByAG4AIABHAGUAdABXAG8AcgBsAGQAUABvAHMAaQB0AGkAbwBuAEMAZQBuAHQAZQByAAoACQAoAAkACgAJAAkAQgBpAFQAYQBuAEQAaQByACwACgAJAAkAVwBvAHIAbABkAFAAbwBzACwACgAJAAkAVABhAG4ARABpAHIALAAKAAkACQBVAFYAMQAsAAoACQAJAFUAVgAwAAoACQApAC4AcgBnAGIAOwA=,output:2,fname:GetWorldPositionCenter_Caller,width:406,height:248,input:2,input:2,input:2,input:1,input:1,input_1_label:BiTanDir,input_2_label:WorldPos,input_3_label:TanDir,input_4_label:UV1,input_5_label:UV0|A-8888-OUT,B-6850-XYZ,C-5635-OUT,D-7968-OUT,E-69-OUT;n:type:ShaderForge.SFN_Get,id:7968,x:28661,y:32872,varname:node_7968,prsc:2|IN-4012-OUT;n:type:ShaderForge.SFN_Get,id:69,x:28661,y:32915,varname:node_69,prsc:2|IN-7644-OUT;n:type:ShaderForge.SFN_FragmentPosition,id:6850,x:28682,y:32628,varname:node_6850,prsc:2;n:type:ShaderForge.SFN_Tangent,id:5635,x:28682,y:32744,varname:node_5635,prsc:2;n:type:ShaderForge.SFN_Bitangent,id:8888,x:28682,y:32505,varname:node_8888,prsc:2;n:type:ShaderForge.SFN_TexCoord,id:5553,x:30748,y:32359,varname:node_5553,prsc:2,uv:1,uaff:False;n:type:ShaderForge.SFN_TexCoord,id:1989,x:30748,y:32507,varname:node_1989,prsc:2,uv:0,uaff:False;n:type:ShaderForge.SFN_Set,id:7644,x:31169,y:32509,varname:UV0_IN,prsc:2|IN-1989-UVOUT;n:type:ShaderForge.SFN_Set,id:4012,x:31169,y:32362,varname:UV1_IN,prsc:2|IN-5553-UVOUT;n:type:ShaderForge.SFN_Append,id:1683,x:31161,y:32021,varname:node_1683,prsc:2|A-9956-RGB,B-9956-A;n:type:ShaderForge.SFN_Append,id:6311,x:31161,y:32187,varname:node_6311,prsc:2|A-4547-RGB,B-4547-A;n:type:ShaderForge.SFN_Code,id:6824,x:31402,y:31867,varname:node_6824,prsc:2,code:YwBsAGkAcAAoAFQAZQB4AEEAbABwAGgAYQAgAC0AIABDAHUAdABvAGYAZgApADsACgByAGUAdAB1AHIAbgAgAFQAZQB4AEEAbABwAGgAYQA7AA==,output:0,fname:ClipMe,width:247,height:112,input:0,input:0,input_1_label:TexAlpha,input_2_label:Cutoff|A-7736-A,B-15-OUT;n:type:ShaderForge.SFN_Get,id:15,x:31150,y:31927,varname:node_15,prsc:2|IN-7766-OUT;n:type:ShaderForge.SFN_Multiply,id:8149,x:30465,y:30072,varname:node_8149,prsc:2|A-5065-RGB,B-3934-OUT;n:type:ShaderForge.SFN_Get,id:4796,x:34260,y:30831,cmnt:The main texture color with some modifications for things like seams blending.,varname:node_4796,prsc:2|IN-4895-OUT;n:type:ShaderForge.SFN_Get,id:3288,x:34089,y:31127,cmnt:The color of the main diretional light,varname:node_3288,prsc:2|IN-4246-OUT;n:type:ShaderForge.SFN_Get,id:140,x:34553,y:31676,cmnt:The shadows value,varname:node_140,prsc:2|IN-6719-OUT;n:type:ShaderForge.SFN_Get,id:7815,x:36056,y:30841,varname:node_7815,prsc:2|IN-6203-OUT;n:type:ShaderForge.SFN_Add,id:765,x:34406,y:31149,varname:node_765,prsc:2|A-3288-OUT,B-9644-RGB;n:type:ShaderForge.SFN_Multiply,id:2188,x:34666,y:31092,cmnt:The final texture color with all lights but no shadows yet,varname:node_2188,prsc:2|A-4796-OUT,B-765-OUT;n:type:ShaderForge.SFN_Lerp,id:6158,x:35271,y:31276,cmnt:The final color with the shadows and ambient tint applied to the shadows,varname:node_6158,prsc:2|A-8279-OUT,B-2188-OUT,T-115-OUT;n:type:ShaderForge.SFN_Multiply,id:8279,x:34900,y:31463,varname:node_8279,prsc:2|A-1643-OUT,B-3481-OUT;n:type:ShaderForge.SFN_Blend,id:1643,x:34688,y:31384,cmnt:The color of the shadow is based entirely off the texture color and the ambient light color,varname:node_1643,prsc:2,blmd:1,clmp:False|SRC-9644-RGB,DST-4796-OUT;n:type:ShaderForge.SFN_Vector1,id:3481,x:34662,y:31559,varname:node_3481,prsc:2,v1:0.8;n:type:ShaderForge.SFN_Get,id:8832,x:34757,y:30875,varname:node_8832,prsc:2|IN-7375-OUT;n:type:ShaderForge.SFN_Max,id:4364,x:35271,y:30944,cmnt:Finds the highest input color value,varname:node_4364,prsc:2|A-9835-R,B-9835-G,C-9835-B;n:type:ShaderForge.SFN_Min,id:2629,x:35271,y:31102,cmnt:Finds how much LESS than WHITE the input color is,varname:node_2629,prsc:2|A-9835-R,B-9835-G,C-9835-B;n:type:ShaderForge.SFN_ComponentMask,id:9835,x:34972,y:30875,cmnt:The input color,varname:node_9835,prsc:2,cc1:0,cc2:1,cc3:2,cc4:-1|IN-8832-OUT;n:type:ShaderForge.SFN_Multiply,id:1556,x:35299,y:30635,cmnt:The input color multiplied by the texture color to give the input color a texture so that it doesnt look flat,varname:node_1556,prsc:2|A-4796-OUT,B-9835-OUT;n:type:ShaderForge.SFN_Multiply,id:1392,x:35629,y:30863,cmnt:Darkens the final color based on the input ccolor,varname:node_1392,prsc:2|A-6158-OUT,B-9835-OUT;n:type:ShaderForge.SFN_Lerp,id:7918,x:35639,y:30661,cmnt:Lerps towards the input color based on how much the input color is LESS than WHITE,varname:node_7918,prsc:2|A-1556-OUT,B-6158-OUT,T-2629-OUT;n:type:ShaderForge.SFN_Subtract,id:5229,x:35800,y:31009,cmnt:Finds the difference between the highest and lowest color value. This is used to detect if our iput color is simply a shade of grey and has no color,varname:node_5229,prsc:2|A-4364-OUT,B-2629-OUT;n:type:ShaderForge.SFN_Lerp,id:4842,x:36077,y:30710,varname:node_4842,prsc:2|A-1392-OUT,B-7918-OUT,T-5229-OUT;n:type:ShaderForge.SFN_Multiply,id:8231,x:36410,y:30750,varname:node_8231,prsc:2|A-4842-OUT,B-7815-OUT;n:type:ShaderForge.SFN_Clamp,id:115,x:34861,y:31678,cmnt:This lets the user adjust te maximum shadow. A value of 0.5 will limit it to half.,varname:node_115,prsc:2|IN-140-OUT,MIN-2015-OUT,MAX-2257-OUT;n:type:ShaderForge.SFN_Vector1,id:2257,x:34553,y:31772,varname:node_2257,prsc:2,v1:1;n:type:ShaderForge.SFN_ValueProperty,id:9716,x:34432,y:31883,ptovrint:False,ptlb:_LushLODTreeShadowDarkness,ptin:_LushLODTreeShadowDarkness,cmnt:_LusLODSadowDarkness... this is cotrolled by the manager in its Update function,varname:node_2612,prsc:2,glob:True,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,v1:1;n:type:ShaderForge.SFN_OneMinus,id:2015,x:34631,y:31883,varname:node_2015,prsc:2|IN-9716-OUT;n:type:ShaderForge.SFN_Lerp,id:9263,x:32424,y:30537,cmnt:Lets the user adjust the tie of day correction,varname:node_9263,prsc:2|A-8650-OUT,B-944-OUT,T-9256-OUT;n:type:ShaderForge.SFN_Vector1,id:8650,x:32177,y:30537,varname:node_8650,prsc:2,v1:1;n:type:ShaderForge.SFN_ValueProperty,id:9256,x:32177,y:30609,ptovrint:False,ptlb:LushLODTreeTimeOfDay,ptin:_LushLODTreeTimeOfDay,varname:node_5174,prsc:2,glob:True,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,v1:1;n:type:ShaderForge.SFN_Divide,id:3934,x:30123,y:30145,varname:node_3934,prsc:2|A-8331-OUT,B-7532-OUT;n:type:ShaderForge.SFN_Vector1,id:7532,x:29833,y:30161,varname:node_7532,prsc:2,v1:1.2;n:type:ShaderForge.SFN_Color,id:9644,x:34176,y:31337,ptovrint:False,ptlb:_LushLODTreeAmbientColor,ptin:_LushLODTreeAmbientColor,cmnt:_LushLODTreeAmbientColor... this value is set in the manager,varname:_LushLODTreeAmbientColor_copy,prsc:2,glob:True,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,c1:0.5,c2:0.5,c3:0.5,c4:1;proporder:6665-6298-5916;pass:END;sub:END;*/

Shader "Hidden/LushLODTree/Tree_Leaves_Far_Ultra_Deferred" {
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
        LOD 100
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
                float3 NomalDir = (i.normalDir*faceSign);
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
                float3 FinalColor_Corrected = GetSeamsBlending_Caller( i.bitangentDir , NomalDir , WorldPosCenter , PlaneNumber , MainTexIN , UV3ColorIN , UV4ColorIN , i.posWorld.rgb , i.tangentDir );
                float3 node_4796 = FinalColor_Corrected; // The main texture color with some modifications for things like seams blending.
                float3 LightIN = (_LushLODTreeMainLightCol.rgb*(_LushLODTreeMainLightIntensity/1.2));
                float3 LightDir = _LushLODTreeMainLightDir.rgb;
                float node_1391 = 0.5*dot(viewDirection,LightDir)+0.5; // Check if view is opposite the direction of sunlight
                float Backside_Darkening_Amount = node_1391; // Darkens the trees when viewed from the back side.
                float3 node_6158 = lerp(((_LushLODTreeAmbientColor.rgb*node_4796)*0.8),(node_4796*(LightIN+_LushLODTreeAmbientColor.rgb)),clamp(Backside_Darkening_Amount,(1.0 - _LushLODTreeShadowDarkness),1.0)); // The final color with the shadows and ambient tint applied to the shadows
                float3 Param_Color = (_Color.rgb*2.0);
                float3 node_9835 = Param_Color.rgb; // The input color
                float node_2629 = min(min(node_9835.r,node_9835.g),node_9835.b); // Finds how much LESS than WHITE the input color is
                float node_7304 = 0.0;
                float node_1319 = 0.0;
                float TimeOfDayIntensity = lerp(1.0,saturate((node_1319 + ( (saturate((dot(float3(0,1,0),LightDir)+0.25)) - node_7304) * ((1.3+(Backside_Darkening_Amount*2.0)) - node_1319) ) / (1.0 - node_7304))),_LushLODTreeTimeOfDay); // This is an optional lighting adjustment you can remove this if your scene doesnt benefit from this.
                float3 emissive = (lerp((node_6158*node_9835),lerp((node_4796*node_9835),node_6158,node_2629),(max(max(node_9835.r,node_9835.g),node_9835.b)-node_2629))*TimeOfDayIntensity);
                float3 finalColor = emissive;
                outDiffuse = half4( 0, 0, 0, 1 );
                outSpecSmoothness = half4(0,0,0,0);
                outNormal = half4( normalDirection * 0.5 + 0.5, 1 );
                outEmission = half4( (lerp((node_6158*node_9835),lerp((node_4796*node_9835),node_6158,node_2629),(max(max(node_9835.r,node_9835.g),node_9835.b)-node_2629))*TimeOfDayIntensity), 1 );
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
                float3 NomalDir = (i.normalDir*faceSign);
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
                float3 FinalColor_Corrected = GetSeamsBlending_Caller( i.bitangentDir , NomalDir , WorldPosCenter , PlaneNumber , MainTexIN , UV3ColorIN , UV4ColorIN , i.posWorld.rgb , i.tangentDir );
                float3 node_4796 = FinalColor_Corrected; // The main texture color with some modifications for things like seams blending.
                float3 LightIN = (_LushLODTreeMainLightCol.rgb*(_LushLODTreeMainLightIntensity/1.2));
                float3 LightDir = _LushLODTreeMainLightDir.rgb;
                float node_1391 = 0.5*dot(viewDirection,LightDir)+0.5; // Check if view is opposite the direction of sunlight
                float Backside_Darkening_Amount = node_1391; // Darkens the trees when viewed from the back side.
                float3 node_6158 = lerp(((_LushLODTreeAmbientColor.rgb*node_4796)*0.8),(node_4796*(LightIN+_LushLODTreeAmbientColor.rgb)),clamp(Backside_Darkening_Amount,(1.0 - _LushLODTreeShadowDarkness),1.0)); // The final color with the shadows and ambient tint applied to the shadows
                float3 Param_Color = (_Color.rgb*2.0);
                float3 node_9835 = Param_Color.rgb; // The input color
                float node_2629 = min(min(node_9835.r,node_9835.g),node_9835.b); // Finds how much LESS than WHITE the input color is
                float node_7304 = 0.0;
                float node_1319 = 0.0;
                float TimeOfDayIntensity = lerp(1.0,saturate((node_1319 + ( (saturate((dot(float3(0,1,0),LightDir)+0.25)) - node_7304) * ((1.3+(Backside_Darkening_Amount*2.0)) - node_1319) ) / (1.0 - node_7304))),_LushLODTreeTimeOfDay); // This is an optional lighting adjustment you can remove this if your scene doesnt benefit from this.
                float3 emissive = (lerp((node_6158*node_9835),lerp((node_4796*node_9835),node_6158,node_2629),(max(max(node_9835.r,node_9835.g),node_9835.b)-node_2629))*TimeOfDayIntensity);
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
