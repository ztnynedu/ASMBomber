// Shader created with Shader Forge v1.38 
// Shader Forge (c) Neat Corporation / Joachim Holmer - http://www.acegikmo.com/shaderforge/
// Note: Manually altering this data may prevent you from opening it in Shader Forge
/*SF_DATA;ver:1.38;sub:START;pass:START;ps:flbk:,iptp:0,cusa:False,bamd:1,cgin:,lico:0,lgpr:1,limd:0,spmd:1,trmd:0,grmd:0,uamb:True,mssp:True,bkdf:False,hqlp:False,rprd:False,enco:False,rmgx:True,imps:True,rpth:0,vtps:0,hqsc:True,nrmq:1,nrsp:0,vomd:0,spxs:False,tesm:0,olmd:1,culm:2,bsrc:0,bdst:1,dpts:2,wrdp:False,dith:0,atcv:False,rfrpo:False,rfrpn:Refraction,coma:15,ufog:False,aust:False,igpj:False,qofs:0,qpre:1,rntp:1,fgom:False,fgoc:False,fgod:False,fgor:False,fgmd:0,fgcr:0.5,fgcg:0.5,fgcb:0.5,fgca:1,fgde:0.01,fgrn:0,fgrf:300,stcl:False,atwp:False,stva:128,stmr:255,stmw:255,stcp:6,stps:0,stfa:0,stfz:0,ofsf:0,ofsu:0,f2p0:False,fnsp:False,fnfb:False,fsmp:False;n:type:ShaderForge.SFN_Final,id:8376,x:38513,y:31048,varname:node_8376,prsc:2|custl-5238-OUT,alpha-5884-OUT,clip-9930-A,voffset-3176-OUT;n:type:ShaderForge.SFN_Tex2d,id:5970,x:28139,y:32524,ptovrint:False,ptlb:ShadowMapFront,ptin:_ShadowMapFront,cmnt:Must rename i.uv2 to i.uv3_ShadowMapFront,varname:_ShadowMapFront,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:True,tagnrm:False,ntxv:0,isnm:False|UVIN-5985-UVOUT;n:type:ShaderForge.SFN_Tex2d,id:184,x:28106,y:33642,ptovrint:False,ptlb:ShadowMapRight,ptin:_ShadowMapRight,cmnt:Must rename i.uv3 to i.uv4_ShadowMapRight,varname:_ShadowMapRight,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:True,tagnrm:False,ntxv:0,isnm:False|UVIN-4871-UVOUT;n:type:ShaderForge.SFN_TexCoord,id:5985,x:27369,y:32354,cmnt:This is mesh.uv3 and it holds the texture coordinates for _ShadowMapForward and is used to add shadowing to all vertices in the tree for any lights coming from RIGHT or LEFT or DOWN along the X axis,varname:node_5985,prsc:2,uv:2,uaff:False;n:type:ShaderForge.SFN_TexCoord,id:4871,x:27274,y:33487,cmnt:This is mesh.uv4 and it holds the texture coordinates for _ShadowMapRight and is used to add shadowing to all vertices in the tree for any lights coming from RIGHT or LEFT or DOWN along the Z axis,varname:node_4871,prsc:2,uv:3,uaff:False;n:type:ShaderForge.SFN_Tex2d,id:9930,x:35528,y:31083,ptovrint:False,ptlb:MainTex,ptin:_MainTex,varname:_MainTex,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,ntxv:0,isnm:False;n:type:ShaderForge.SFN_Vector3,id:5326,x:29311,y:32761,cmnt:This is the Y axis of the tree and it will be aligned TOP to BOTTOM of the tree,varname:node_5326,prsc:2,v1:0,v2:1,v3:0;n:type:ShaderForge.SFN_Transform,id:132,x:29518,y:32794,varname:node_132,prsc:2,tffrom:1,tfto:0|IN-5326-OUT;n:type:ShaderForge.SFN_Dot,id:9493,x:29773,y:32801,cmnt:Is the light shining straight down at the tree?,varname:node_9493,prsc:2,dt:4|A-132-XYZ,B-6634-OUT;n:type:ShaderForge.SFN_Add,id:3875,x:28699,y:33181,cmnt:Both shadow maps have their GREEN color values measuring the light from above so first add them together,varname:node_3875,prsc:2|A-5970-G,B-184-G;n:type:ShaderForge.SFN_Divide,id:586,x:30318,y:33064,cmnt:Divide the light from above in half to get the average of both shadow maps,varname:node_586,prsc:2|A-3875-OUT,B-2205-OUT;n:type:ShaderForge.SFN_Vector1,id:2205,x:29996,y:33199,varname:node_2205,prsc:2,v1:2;n:type:ShaderForge.SFN_Set,id:5346,x:37606,y:32760,varname:ShadowMapDarkeningVal,prsc:2|IN-7018-OUT;n:type:ShaderForge.SFN_Get,id:9084,x:33275,y:32637,varname:node_9084,prsc:2|IN-5346-OUT;n:type:ShaderForge.SFN_Vector3,id:9950,x:29572,y:31891,cmnt:This is the X axis of the tree and it will be aligned RIGHT to LEFT if you view the tree from the Z axis direction,varname:node_9950,prsc:2,v1:1,v2:0,v3:0;n:type:ShaderForge.SFN_Transform,id:7462,x:29784,y:31924,varname:node_7462,prsc:2,tffrom:1,tfto:0|IN-9950-OUT;n:type:ShaderForge.SFN_Dot,id:4611,x:30039,y:31931,cmnt:Is the light shining permendicular to the Z axis?,varname:node_4611,prsc:2,dt:4|A-7462-XYZ,B-7073-OUT;n:type:ShaderForge.SFN_Vector3,id:243,x:29273,y:33659,cmnt:This is the Z axis of the tree and it will be aligned RIGHT to LEFT if you view the tree fromt he X axis direction,varname:node_243,prsc:2,v1:0,v2:0,v3:1;n:type:ShaderForge.SFN_Transform,id:6731,x:29502,y:33729,varname:node_6731,prsc:2,tffrom:1,tfto:0|IN-243-OUT;n:type:ShaderForge.SFN_Dot,id:4112,x:29758,y:33699,cmnt:Is the light shining permendicular to the X axis?,varname:node_4112,prsc:2,dt:4|A-6731-XYZ,B-7157-OUT;n:type:ShaderForge.SFN_Lerp,id:2028,x:30937,y:33371,cmnt:Fades between the light coming from the RIGHT or LEFT side when viewed from the X axis,varname:node_2028,prsc:2|A-184-R,B-184-B,T-1221-OUT;n:type:ShaderForge.SFN_Lerp,id:6270,x:31068,y:32065,cmnt:Fades between light coming from the RIGHT or LEFT side when viewed from the Z axis,varname:node_6270,prsc:2|A-5970-R,B-5970-B,T-5317-OUT;n:type:ShaderForge.SFN_Subtract,id:5328,x:31355,y:32124,cmnt:Reduces the intensity of the shadows a bit,varname:node_5328,prsc:2|A-6270-OUT,B-1811-OUT;n:type:ShaderForge.SFN_Subtract,id:8427,x:31242,y:33408,cmnt:Reduces the intensity of the shadows a bit,varname:node_8427,prsc:2|A-2028-OUT,B-2098-OUT;n:type:ShaderForge.SFN_RemapRange,id:1630,x:30340,y:31967,cmnt:Stretches the effect somewhat,varname:node_1630,prsc:2,frmn:0,frmx:1,tomn:-0.25,tomx:1.25|IN-4611-OUT;n:type:ShaderForge.SFN_Clamp01,id:5317,x:30690,y:31948,varname:node_5317,prsc:2|IN-1630-OUT;n:type:ShaderForge.SFN_RemapRange,id:7427,x:30019,y:33726,cmnt:Stretches the effect somewhat,varname:node_7427,prsc:2,frmn:0,frmx:1,tomn:-0.25,tomx:1.25|IN-4112-OUT;n:type:ShaderForge.SFN_Clamp01,id:1221,x:30383,y:33720,varname:node_1221,prsc:2|IN-7427-OUT;n:type:ShaderForge.SFN_Blend,id:267,x:31630,y:32501,cmnt:Blends shadows coming from 4 different possible horizontal directions,varname:node_267,prsc:2,blmd:6,clmp:False|SRC-6270-OUT,DST-2028-OUT;n:type:ShaderForge.SFN_Multiply,id:8575,x:32435,y:33177,varname:node_8575,prsc:2|A-3965-OUT,B-7551-OUT;n:type:ShaderForge.SFN_RemapRange,id:5290,x:30053,y:32834,cmnt:Stretches the effect somewhat,varname:node_5290,prsc:2,frmn:0,frmx:1,tomn:-0.25,tomx:1.25|IN-9493-OUT;n:type:ShaderForge.SFN_Lerp,id:9362,x:30539,y:32884,cmnt:Fades between maximum shadowing if the light is directly above OR zero shadowing if the light is coming from direction under the tree,varname:node_9362,prsc:2|A-4137-OUT,B-586-OUT,T-1731-OUT;n:type:ShaderForge.SFN_Vector1,id:4137,x:30489,y:32744,cmnt:No shadows if the light is coming from under the tree,varname:node_4137,prsc:2,v1:0;n:type:ShaderForge.SFN_Subtract,id:7757,x:31145,y:32712,cmnt:Reduces the intensity of the shadows a bit,varname:node_7757,prsc:2|A-9362-OUT,B-8030-OUT;n:type:ShaderForge.SFN_Clamp01,id:1731,x:30286,y:32834,varname:node_1731,prsc:2|IN-5290-OUT;n:type:ShaderForge.SFN_Blend,id:4910,x:31899,y:32644,cmnt:Blends in shadows coming from lighting that is shining directly down on the tree,varname:node_4910,prsc:2,blmd:6,clmp:False|SRC-267-OUT,DST-9362-OUT;n:type:ShaderForge.SFN_Code,id:3176,x:38966,y:31412,varname:node_3176,prsc:2,code:LwAvAFQASABJAFMAIABTAEgAQQBEAEUAUgAgAGkAcwBuACcAdAAgAGUAeABhAGMAdABsAHkAIABtAGUAYQBuAHQAIAB0AG8AIABiAGUAIAB1AHMAZQBkAC4AIABJAG4AdABlAGEAZAAsACAAeQBvAHUAIABzAGgAbwB1AGwAZAAgAGMAbwBwAHkALwBwAGEAcwB0AGUAIAB0AGgAZQAgAGMAbwBkAGUAIABmAHIAbwBtAAoALwAvAHQAaABpAHMAIABzAGgAYQBkAGUAcgAsACAAaQBuAHQAbwAgAHQAaABlACAAVAByAGUAZQBDAHIAZQBhAHQAbwByAEwAZQBhAHYAZQBzAE8AcAB0AGkAbQBpAHoAZQBkAF8AUwBpAG0AcABsAGUAUwBoAGEAZABvAHcAcwAuAHMAaABhAGQAZQByAC4ACgAKAC8ALwBUAGgAaQBzACAAcwBoAGEAZABlAHIAIABkAG8AZQBzACAAYgBhAHMAaQBjAGEAbABsAHkAIABuAG8AdABoAGkAbgBnACAAZQB4AGMAZQBwAHQAIABjAGEAbABjAHUAbABhAHQAZQBzACAAcwBoAGEAZABvAHcAcwAgAHQAaABhAHQAIABhAHIAZQAgAGkAbgBzAGkAZABlACAAbwBmACAAdABoAGUAIABsAGUAYQB2AGUAcwAKAC8ALwBvAGYAIAB0AGgAZQAgAHQAcgBlAGUALgAgAEkAdAAgAGMAYQBuACcAdAAgAHIAZQBjAGUAaQB2AGUAIABzAGgAYQBkAG8AdwBzACAAZgByAG8AbQAgAGEAbgB5ACAAbwB0AGgAZQByACAAdAByAGUAZQAsACAAbwBuAGwAeQAgAGYAcgBvAG0AIABpAHQAcwBlAGwAZgAuACAAVABoAGUAcgBlAGYAbwByAGUALAAKAC8ALwBhAG4AeQAgAG0AYQB0AGUAcgBpAGEAbAAgAHQAaABhAHQAIABpAHMAIAB1AHMAaQBuAGcAIAB0AGgAaQBzACAAcwBoAGEAZABlAHIALAAgAHMAaABvAHUAbABkACAAcwBlAHQAIABpAHQAcwAgACIAcgBlAGMAZQBpAHYAZQAgAHMAaABhAGQAbwB3AHMAIgAgAGMAaABlAGMAawBiAG8AeAAgAHQAbwAgAE8ARgBGAC4ACgAvAC8AVABoAGkAcwAgAHMAaABhAGQAZQByACAAcgBlAG4AZABlAHIAcwAgAHMAaABhAGQAbwB3AHMAIABtAHUAYwBoACAAZgBhAHMAdABlAHIAIAB0AGgAYQBuACAAVQBuAGkAdAB5ACcAcwAgAGIAdQBpAGwAdAAtAGkAbgAgAHMAaABhAGQAbwB3AHMALAAgAGIAdQB0ACAAdABoAGUAIABzAGgAYQBkAG8AdwBzAAoALwAvAHIAZQBuAGQAZQByAGUAZAAgAGIAeQAgAHQAaABpAHMAIABzAGgAYQBkAGUAcgAgAGEAcgBlAG4AJwB0ACAAbgBlAGEAcgBsAHkAIABhAHMAIABwAG8AdwBlAHIAZgB1AGwALgAKAAoALwAvAEEAZwBhAGkAbgAsACAAdABoAGkAcwAgAHMAaABhAGQAZQByACAAaQBzAG4AJwB0ACAAbQBlAGEAbgB0ACAAdABvACAAYgBlACAAdQBzAGUAZAAgAGEAcwAtAGkAcwAuACAAVABoAGUAIABjAG8AZABlACAAZgByAG8AbQAgAHQAaABpAHMAIABzAGgAYQBkAGUAcgAgAGkAcwAgAG0AZQBhAG4AdAAgAHQAbwAgAGIAZQAKAC8ALwBjAG8AcABpAGUAZAAgAGkAbgB0AG8AIAB0AGgAZQAgAFQAcgBlAGUAQwByAGUAYQB0AG8AcgBMAGUAYQB2AGUAcwBPAHAAdABpAG0AaQB6AGUAZABfAFMAaQBtAHAAbABlAFMAaABhAGQAbwB3AHMALgBzAGgAYQBkAGUAcgAsACAAYQBuAGQAIABiAGUAYwBvAG0AZQBzACAAcABhAHIAdAAgAG8AZgAgAHQAaABhAHQACgAvAC8AcwBoAGEAZABlAHIAJwBzACAAcwBoAGEAZABvAHcAIAByAGUAbgBkAGUAcgBpAG4AZwAgAHAAcgBvAGMAZQBzAHMALgAgAFQAaABlACAAcAB1AHIAcABvAHMAZQAgAG8AZgAgAHQAaABpAHMAIABzAGgAYQBkAGUAcgAgAGkAcwAgAHQAbwAgAHMAaQBtAHAAbAB5ACAAYQBsAGwAbwB3ACAAeQBvAHUAIAB0AG8ACgAvAC8AbQBvAGQAaQBmAHkAIAB0AGgAZQAgACIAcwBpAG0AcABsAGUAIABzAGgAYQBkAG8AdwAiACAAcABvAHIAdABpAG8AbgAgAGkAbgAgAFMAaABhAGQAZQByACAARgBvAHIAZwBlAC4AIABCAHUAdAAgAGkAZgAgAHkAbwB1ACAAbQBhAGsAZQAgAGEAbgB5ACAAYwBoAGEAbgBnAGUAcwAgAHQAbwAgAHQAaABpAHMACgAvAC8AcwBoAGEAZABlAHIALAAgAHkAbwB1ACAAcwBoAG8AbABkACAAYwBvAHAAeQAgAHQAaABvAHMAZQAgAGMAaABhAG4AZwBlAHMAIABpAG4AdABvACAAdABoAGUAIABhAGIAbwB2AGUALQBtAGUAbgB0AGkAbwBuAGUAZAAgAHMAaABhAGQAZQByACAAcwBvACAAdABoAGEAdAAgAGkAdAAgAGMAYQBuACAAYgBlAAoALwAvAHUAcwBlAGQALAAgAHMAaQBuAGMAZQAgAHQAaABpAHMAIABzAGgAYQBkAGUAcgAgAGkAcwAgAHAAcgBlAHQAdAB5ACAAdQBnAGwAeQAgAGEAbABsACAAYgB5ACAAaQB0AHMAZQBsAGYALgAKAAoALwAvAFQAaABpAHMAIABzAGgAYQBkAGUAcgAgAHIAZQBxAHUAaQByAGUAcwAgAHQAdwBvACAAdABlAHgAdAB1AHIAZQBzACAAdABoAGEAdAAgAGEAcgBlACAAYwBhAGwAbABlAGQAIABTAGgAYQBkAG8AdwAgAE0AYQBwAHMALgAgAFQAaABlAHMAZQAgAHQAZQB4AHQAdQByAGUAcwAgAGEAcgBlACAAYwByAGUAYQB0AGUAZAAKAC8ALwBhAHUAdABvAG0AYQB0AGkAYwBhAGwAbAB5ACAAZAB1AHIAaQBuAGcAIAB0AGgAZQAgAHQAcgBlAGUAIABjAG8AbgB2AGUAcgBzAGkAbwBuACAAcAByAG8AYwBlAHMAcwAsACAAdwBoAGkAYwBoACAAaABhAHAAcABlAG4AcwAgAGkAbgAgAHQAaABlACAAdAByAGUAZQAgAGMAbwBuAHYAZQByAHQAZQByACAAcwBjAGUAbgBlAAoALwAvAHQAaABhAHQAIABpAHMAIABpAG4AYwBsAHUAZABlAGQAIAB3AGkAdABoACAATAB1AHMAaABMAE8ARAAgAHQAcgBlAGUAcwAuACAAVABoAGEAdAAgAGgAYQBwAHAAZQBuAHMAIABpAG4AIAB0AGgAZQAgACIATAB1AHMAaABMAE8ARAAgAFQAcgBlAGUAIABDAG8AbgB2AGUAcgB0AGUAcgAiACAAcwBjAGUAbgBlACwACgAvAC8AYQBuAGQAIABpAHMAIABoAGEAbgBkAGwAZQBkACAAYgB5ACAAdABoAGUAIABzAGMAcgBpAHAAdAAgAG4AYQBtAGUAZAAgAF8ATAB1AHMAaABMAE8ARABUAHIAZQBlAEMAbwBuAHYAZQByAHQAZQByAC4AYwBzAC4ACgAKAC8ALwBJAGYAIAB5AG8AdQAgAGYAbwByACAAdwBoAGEAdABlAHYAZQByACAAYwByAGEAegB5ACAAcgBlAGEAcwBvAG4AIAB3AGEAbgB0ACAAdABvACAAZQBkAGkAdAAgAHQAaABpAHMAIABzAGgAYQBkAGUAcgAsACAAcABsAGUAYQBzAGUAIABmAG8AbABsAG8AdwAgAHQAaABlACAAcwB0AGUAcABzACAAYgBlAGwAbwB3ACAAdABvAAoALwAvAGEAcABwAGwAeQAgAHkAbwB1AHIAIABjAGgAYQBuAGcAZQBzACAAcwBvACAAdABoAGEAdAAgAHQAaABlAHkAIAB3AGkAbABsACAAdwBvAHIAawAgAHcAaQB0AGgAIABMAHUAcwBoAEwATwBEACAAdAByAGUAZQBzAC4ACgAKAC8ALwBTAHQAZQBwAHMAOgAKAAoALwAvADEAKQAgAE8AcABlAG4AIAB0AGgAaQBzACAAcwBoAGEAZABlAHIAIABpAG4AIABzAGgAYQBkAGUAcgAgAGYAbwByAGcAZQAsACAAYQBuAGQAIABtAGEAawBlACAAdwBoAGEAdABlAHYAZQByACAAYwByAGEAegB5ACAAYwBoAGEAbgBnAGUAcwAgAHkAbwB1ACAAdwBhAG4AbgBhAC4ACgAKAC8ALwAyACkAIABTAGEAdgBlACAAdABoAGkAcwAgAHMAaABhAGQAZQByAC4ACgAKAC8ALwAzACkAIABEAG8AdQBiAGwAZQAtAGMAbABpAGMAawAgAHQAaABpAHMAIABzAGgAYQBkAGUAcgAgAGYAaQBsAGUAIAB0AG8AIABvAHAAZQBuACAAaQB0ACAAKABkAG8AbgAnAHQAIABjAGwAaQBjAGsAIAB0AGgAZQAgACIAYwBvAG0AcABpAGwAZQAgAGEAbgBkACAAcwBoAG8AdwAgAGMAbwBkAGUAIgAgAGIAdQB0AHQAbwBuACkACgAKAC8ALwA0ACkAIABZAG8AdQAnAGwAbAAgAG4AZQBlAGQAIAB0AG8AIABjAG8AcAB5ACAAcwBvAG0AZQAgAGwAaQBuAGUAcwAgAG8AZgAgAGMAbwBkAGUALAAgAHMAdABhAHIAdABpAG4AZwAgAHcAaABlAHIAZQAgAHQAaABlACAAIgAvAC8ALwAvAC8ALwAgAEwAaQBnAGgAdABpAG4AZwA6ACIAIAAKAC8ALwBjAG8AbQBtAGUAbgB0ACAAaQBzACAAZgBvAHUAbgBkACAAaQBuACAAdABoAGUAIABzAHUAcgBmACgAKQAgAGYAdQBuAGMAdABpAG8AbgAuAAoACgAvAC8ANQApACAARABvAHUAYgBsAGUALQBjAGwAaQBjAGsAIAB0AGgAZQAgAFQAcgBlAGUAQwByAGUAYQB0AG8AcgBMAGUAYQB2AGUAcwBPAHAAdABpAG0AaQB6AGUAZABfAFMAaQBtAHAAbABlAFMAaABhAGQAbwB3AHMALgBzAGgAYQBkAGUAcgAgAGYAaQBsAGUAIAB0AG8AIABvAHAAZQBuACAAaQB0ACAAaQBuAAoALwAvAGEAIAB0AGUAeAB0ACAAZQBkAGkAdABvAHIALgAKAAoALwAvADYAKQAgAEYAaQBsAGUAIAB0AGgAZQAgAHMAdQByAGYAKAApACAAZgB1AG4AYwB0AGkAbwBuACAAbgBlAGEAcgAgAHQAaABlACAAdABvAHAAIABvAGYAIAB0AGgAYQB0ACAAcwBoAGEAZABlAHIAIABmAGkAbABlAC4ACgAKAC8ALwA3ACkAIABGAGkAbgBkACAAdABoAGUAIABjAG8AbQBtAGUAbgB0AHMAIAB0AGgAYQB0ACAAcwBhAHkAIAAiAFMAdABhAHIAdAAgAG8AZgAgAFMAaQBtAHAAbABlACAAUwBoAGEAZABvAHcAIABDAG8AZABlACIAIABhAG4AZAAgACIARQBuAGQAIABvAGYAIABTAGkAbQBwAGwAZQAgAFMAaABhAGQAbwB3ACAAQwBvAGQAZQAiAC4ACgAKAC8ALwA4ACkAIABQAGEAcwB0AGUAIAB0AGgAZQAgAGMAbwBkAGUAIAB5AG8AdQAgAGMAbwBwAGkAZQBkACAAZgByAG8AbQAgAHQAaABpAHMAIABzAGgAYQBkAGUAcgAsACAAaQBuAHQAbwAgAHQAaABhAHQAIABhAHIAZQBhAC4AIABPAHYAZQByAHcAcgBpAHQAZQAgAHQAaABlACAAbwBsAGQAIABjAG8AZABlAC4ACgAKAC8ALwA5ACkAIABJAG4AIAB0AGgAZQAgAF8ATAB1AHMAaABMAE8ARABUAHIAZQBlAHMATQBhAG4AYQBnAGUAcgAgAHcAaABpAGMAaAAgAGkAcwAgAGEAdQB0AG8AbQBhAHQAaQBjAGEAbABsAHkAIABhAGQAZABlAGQAIAB0AG8AIABhAG4AeQAgAHMAYwBlAG4AZQAgAHQAaABhAHQAIABoAGEAcwAgAGEACgAvAC8ATAB1AHMAaABMAE8ARAAgAHQAcgBlAGUAIABpAG4AIABpAHQALAAgAGwAbwBvAGsAIABmAG8AcgAgAHQAaABlACAAbwBwAHQAaQBvAG4AIAB0AG8AIABzAHcAaQB0AGMAaAAgAHQAbwAgACIAUwBpAG0AcABsAGUAIABTAGgAYQBkAG8AdwBzACIAIABtAG8AZABlAC4AIABZAG8AdQAgAHMAaABvAHUAbABkAAoALwAvAHQAaABlAG4AIABzAGUAZQAgAHQAaABlACAAdAByAGUAZQBzACAAdwBvAHIAawBpAG4AZwAgAHcAaQB0AGgAIAB3AGgAYQB0AGUAdgBlAHIAIABjAGgAYQBuAGcAZQBzACAAeQBvAHUAIABtAGEAZABlAC4ACgAKAC8ALwBOAE8AVABFADoAIABZAG8AdQAgAGMAYQBuACAAYQBsAHMAbwAgAGMAbwBwAHkAIAB0AGgAaQBzACAAcwBoAGEAZABlAHIAJwBzACAAYwBvAGQAZQAgAGkAbgB0AG8AIABvAHQAaABlAHIAIABzAGgAYQBkAGUAcgBzACAAdABoAGEAdAAgAHUAcwBlACAAdABoAGUAIABTAGkAbQBwAGwAZQAgAFMAaABhAGQAbwB3AHMACgAvAC8AYwBvAGQAZQAuAAoACgByAGUAdAB1AHIAbgAgADAAOwAgAC8ALwA8AC0ALQAgAGQAdQBtAG0AeQAgAHIAZQB0AHUAcgBuAC4A,output:0,fname:READ_ME_LOTS_OF_INFO_HERE,width:701,height:718;n:type:ShaderForge.SFN_Set,id:7500,x:31965,y:33097,varname:MaximumShadows,prsc:2|IN-842-OUT;n:type:ShaderForge.SFN_Get,id:7551,x:32207,y:33250,varname:node_7551,prsc:2|IN-7500-OUT;n:type:ShaderForge.SFN_Get,id:1811,x:31081,y:32286,cmnt:Subtract between 0 to 0.2 from the shadow,varname:node_1811,prsc:2;n:type:ShaderForge.SFN_Get,id:8030,x:30875,y:32594,cmnt:Subtract between 0 to 0.2 from the shadow,varname:node_8030,prsc:2;n:type:ShaderForge.SFN_Get,id:2098,x:30937,y:33615,cmnt:Subtract between 0 to 0.2 from the shadow,varname:node_2098,prsc:2;n:type:ShaderForge.SFN_Set,id:6148,x:34095,y:33138,varname:FinalBeforeRescale,prsc:2|IN-5110-OUT;n:type:ShaderForge.SFN_Get,id:5801,x:35937,y:32119,varname:node_5801,prsc:2|IN-6148-OUT;n:type:ShaderForge.SFN_Set,id:7992,x:34120,y:31758,varname:Backside_Darkening_Amount,prsc:2|IN-1780-OUT;n:type:ShaderForge.SFN_Vector4Property,id:8547,x:33442,y:30971,ptovrint:False,ptlb:_LushLODTreeMainLightDir,ptin:_LushLODTreeMainLightDir,cmnt:The W is set via script in _LushLODTreesManager.cs,varname:node_8259,prsc:2,glob:True,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,v1:0.5,v2:0.5,v3:0.5,v4:1;n:type:ShaderForge.SFN_Set,id:8463,x:33862,y:30976,varname:LightDir,prsc:2|IN-8547-XYZ;n:type:ShaderForge.SFN_Get,id:6634,x:29497,y:32974,varname:node_6634,prsc:2|IN-8463-OUT;n:type:ShaderForge.SFN_Get,id:7073,x:29763,y:32087,varname:node_7073,prsc:2|IN-8463-OUT;n:type:ShaderForge.SFN_Get,id:7157,x:29481,y:33900,varname:node_7157,prsc:2|IN-8463-OUT;n:type:ShaderForge.SFN_ViewVector,id:9713,x:33502,y:31582,varname:node_9713,prsc:2;n:type:ShaderForge.SFN_Dot,id:1780,x:33715,y:31673,cmnt:Check if view is opposite the direction of sunlight,varname:node_1780,prsc:2,dt:4|A-9713-OUT,B-9636-OUT;n:type:ShaderForge.SFN_RemapRange,id:6458,x:33939,y:31719,cmnt:Rescales it to 0.7 to 1 multiplied by 0.75 which yields 0.525 to 0.75,varname:node_6458,prsc:2,frmn:-1,frmx:1,tomn:0.525,tomx:0.75|IN-1780-OUT;n:type:ShaderForge.SFN_Get,id:9636,x:33502,y:31719,varname:node_9636,prsc:2|IN-8463-OUT;n:type:ShaderForge.SFN_Set,id:8929,x:34346,y:32758,cmnt:Used in our custom LightModel to create the translucency effect,varname:LightAtten,prsc:2|IN-1922-OUT;n:type:ShaderForge.SFN_Get,id:9406,x:37674,y:31586,varname:node_9406,prsc:2|IN-8929-OUT;n:type:ShaderForge.SFN_Vector1,id:9946,x:37698,y:31636,varname:node_9946,prsc:2,v1:1;n:type:ShaderForge.SFN_Clamp01,id:7200,x:33611,y:33010,varname:node_7200,prsc:2|IN-6240-OUT;n:type:ShaderForge.SFN_Max,id:5884,x:37892,y:31586,cmnt:Dummy output just to ensure that these variables are written to the code,varname:node_5884,prsc:2|A-9406-OUT,B-9946-OUT,C-9065-OUT;n:type:ShaderForge.SFN_RemapRange,id:3309,x:33563,y:32687,cmnt:Darkens the shadows,varname:node_3309,prsc:2,frmn:0.6,frmx:1,tomn:0,tomx:1|IN-9084-OUT;n:type:ShaderForge.SFN_Clamp01,id:7899,x:33756,y:32687,varname:node_7899,prsc:2|IN-3309-OUT;n:type:ShaderForge.SFN_Lerp,id:5110,x:33909,y:33122,cmnt:Sharpens only when viewed from the back this helps sharpen the translucency effect,varname:node_5110,prsc:2|A-7200-OUT,B-8575-OUT,T-394-OUT;n:type:ShaderForge.SFN_Get,id:9472,x:32301,y:33398,varname:node_9472,prsc:2|IN-7992-OUT;n:type:ShaderForge.SFN_Clamp01,id:394,x:32734,y:33374,varname:node_394,prsc:2|IN-1603-OUT;n:type:ShaderForge.SFN_Multiply,id:1603,x:32549,y:33374,cmnt:Delays the sharpening effect until view is halfway rotated from the sunlight. Aka perpendicular.,varname:node_1603,prsc:2|A-9472-OUT,B-3978-OUT;n:type:ShaderForge.SFN_Vector1,id:3978,x:32322,y:33448,varname:node_3978,prsc:2,v1:2;n:type:ShaderForge.SFN_Dot,id:4794,x:32105,y:32361,cmnt:Is the sun above the horizon?,varname:node_4794,prsc:2,dt:0|A-926-OUT,B-2363-OUT;n:type:ShaderForge.SFN_Get,id:2363,x:31872,y:32407,varname:node_2363,prsc:2|IN-8463-OUT;n:type:ShaderForge.SFN_Vector3,id:926,x:31872,y:32294,cmnt:Checks if the light is shining straight down,varname:node_926,prsc:2,v1:0,v2:1,v3:0;n:type:ShaderForge.SFN_Clamp01,id:1368,x:32669,y:32365,varname:node_1368,prsc:2|IN-9583-OUT;n:type:ShaderForge.SFN_Clamp01,id:2282,x:33133,y:32209,varname:node_2282,prsc:2|IN-9077-OUT;n:type:ShaderForge.SFN_Set,id:5422,x:33656,y:32322,cmnt:This is an optional lighting adjustment you can remove this if your scene doesnt benefit from this.,varname:TimeOfDayIntensity,prsc:2|IN-6641-OUT;n:type:ShaderForge.SFN_Add,id:9583,x:32484,y:32365,cmnt:This makes the trees not get dark until the sun is somewhat BELOW the horizon.,varname:node_9583,prsc:2|A-4794-OUT,B-6880-OUT;n:type:ShaderForge.SFN_Vector1,id:8713,x:32291,y:32507,cmnt:NOTE this is normally 0.25 but for Simple Shadows we use 0.1 to make the translucency effect go away sooner.,varname:node_8713,prsc:2,v1:0.1;n:type:ShaderForge.SFN_RemapRangeAdvanced,id:9077,x:32932,y:32209,cmnt:Rescales it from 01 to about 03 to make it get brigher faster as the sun comes up. This effect is significantly stronger on the sunny side via backside darkening.,varname:node_9077,prsc:2|IN-1368-OUT,IMIN-424-OUT,IMAX-7199-OUT,OMIN-1563-OUT,OMAX-6926-OUT;n:type:ShaderForge.SFN_Vector1,id:424,x:32669,y:32060,varname:node_424,prsc:2,v1:0;n:type:ShaderForge.SFN_Vector1,id:7199,x:32669,y:32109,varname:node_7199,prsc:2,v1:1;n:type:ShaderForge.SFN_Vector1,id:1563,x:32669,y:32164,varname:node_1563,prsc:2,v1:0;n:type:ShaderForge.SFN_Vector1,id:9431,x:32466,y:32120,varname:node_9431,prsc:2,v1:1.3;n:type:ShaderForge.SFN_Add,id:6926,x:32669,y:32214,varname:node_6926,prsc:2|A-9431-OUT,B-2218-OUT;n:type:ShaderForge.SFN_Get,id:34,x:32289,y:32122,varname:node_34,prsc:2|IN-7992-OUT;n:type:ShaderForge.SFN_Multiply,id:2218,x:32466,y:32186,varname:node_2218,prsc:2|A-34-OUT,B-5131-OUT;n:type:ShaderForge.SFN_Vector1,id:5131,x:32289,y:32205,varname:node_5131,prsc:2,v1:2;n:type:ShaderForge.SFN_Get,id:9065,x:37677,y:31701,varname:node_9065,prsc:2|IN-5422-OUT;n:type:ShaderForge.SFN_Multiply,id:1922,x:34013,y:32717,cmnt:Avoids translucency effects during sunrise and sunset because often trees would be expected to cast shadows on each other so it looks funny when some of them are glowing brightly,varname:node_1922,prsc:2|A-7899-OUT,B-7371-OUT,C-7432-OUT;n:type:ShaderForge.SFN_Get,id:7371,x:33756,y:32812,varname:node_7371,prsc:2|IN-5422-OUT;n:type:ShaderForge.SFN_ValueProperty,id:1521,x:31559,y:33251,ptovrint:False,ptlb:_LushLODTreeLinear,ptin:_LushLODTreeLinear,cmnt:This is set to 0.7 in Linear color space or 0 in Gamma color space,varname:node_1521,prsc:2,glob:True,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,v1:1;n:type:ShaderForge.SFN_Add,id:842,x:31775,y:33068,varname:node_842,prsc:2|A-506-OUT,B-3011-OUT;n:type:ShaderForge.SFN_ValueProperty,id:3011,x:31561,y:33464,ptovrint:False,ptlb:_LushLODTreeMaxShadowAdd,ptin:_LushLODTreeMaxShadowAdd,cmnt:This allows the user to adjust the maximum shadow strength,varname:__LushLODTreeLinear_copy,prsc:2,glob:True,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,v1:1;n:type:ShaderForge.SFN_RemapRangeAdvanced,id:6240,x:33346,y:32993,cmnt:0 and 1 is remapped to a maximum of -1 to 2,varname:node_6240,prsc:2|IN-8575-OUT,IMIN-8084-OUT,IMAX-7978-OUT,OMIN-8622-OUT,OMAX-3483-OUT;n:type:ShaderForge.SFN_Vector1,id:8084,x:32821,y:32752,varname:node_8084,prsc:2,v1:0;n:type:ShaderForge.SFN_Vector1,id:7978,x:32821,y:33012,varname:node_7978,prsc:2,v1:1;n:type:ShaderForge.SFN_ValueProperty,id:3738,x:32502,y:33010,ptovrint:False,ptlb:_LushLODTreeTranslucencySharpen,ptin:_LushLODTreeTranslucencySharpen,cmnt:This allows the user to adjust the Translucency sharpenin strength,varname:__LushLODTreeMaxShadowAdd_copy,prsc:2,glob:True,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,v1:1;n:type:ShaderForge.SFN_Add,id:3483,x:33102,y:33092,varname:node_3483,prsc:2|A-7978-OUT,B-3738-OUT;n:type:ShaderForge.SFN_Subtract,id:8622,x:32821,y:32824,varname:node_8622,prsc:2|A-8084-OUT,B-3738-OUT;n:type:ShaderForge.SFN_ValueProperty,id:5363,x:36617,y:32936,ptovrint:False,ptlb:_LushLODTreeShadowDarkness,ptin:_LushLODTreeShadowDarkness,cmnt:Set this to 0.5 to limit the maximum shadows to 50 percent effet. User can adjust this.,varname:node_5363,prsc:2,glob:True,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,v1:1;n:type:ShaderForge.SFN_Color,id:6045,x:36277,y:31173,ptovrint:False,ptlb:Color,ptin:_Color,cmnt:The input color,varname:_Color,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,c1:1,c2:1,c3:1,c4:1;n:type:ShaderForge.SFN_Multiply,id:3633,x:35969,y:31286,varname:node_3633,prsc:2|A-9930-RGB,B-1555-OUT;n:type:ShaderForge.SFN_Get,id:2220,x:37652,y:31159,varname:node_2220,prsc:2|IN-5422-OUT;n:type:ShaderForge.SFN_Lerp,id:3797,x:36410,y:31583,cmnt:The final color with the shadows and the ambient tint applied to the shadows,varname:node_3797,prsc:2|A-7365-OUT,B-3633-OUT,T-2625-OUT;n:type:ShaderForge.SFN_Multiply,id:7365,x:36068,y:31675,cmnt:Darkens the ambient,varname:node_7365,prsc:2|A-1513-OUT,B-899-OUT;n:type:ShaderForge.SFN_Vector1,id:899,x:35854,y:31769,varname:node_899,prsc:2,v1:0.8;n:type:ShaderForge.SFN_Lerp,id:2169,x:37074,y:30988,cmnt:Lerps towards the inut color based on how much the input color is LESS than WHITE.,varname:node_2169,prsc:2|A-3710-OUT,B-3797-OUT,T-4284-OUT;n:type:ShaderForge.SFN_Min,id:4284,x:36507,y:31392,cmnt:Finds how much LESS than WHITE the iput color is,varname:node_4284,prsc:2|A-6045-R,B-6045-G,C-6045-B;n:type:ShaderForge.SFN_Multiply,id:6196,x:37074,y:31154,cmnt:Darkens the final color based on the input color.,varname:node_6196,prsc:2|A-3797-OUT,B-6045-RGB;n:type:ShaderForge.SFN_Lerp,id:140,x:37673,y:31021,cmnt:If our input is grey we simply multiply by that grey to darken the final color without hurting the saturatio so much. But if our input is a color we lerp towards that color based upon how much that color is LESS than WHITE.,varname:node_140,prsc:2|A-6196-OUT,B-2169-OUT,T-2622-OUT;n:type:ShaderForge.SFN_Max,id:4144,x:36507,y:31232,cmnt:Finds the higest input color value,varname:node_4144,prsc:2|A-6045-R,B-6045-G,C-6045-B;n:type:ShaderForge.SFN_Subtract,id:2622,x:37087,y:31309,cmnt:Finds the difference between the highest and lowest color value. This is used to detect if our input color is simply a shade of grey and has no color.,varname:node_2622,prsc:2|A-4144-OUT,B-4284-OUT;n:type:ShaderForge.SFN_Multiply,id:3710,x:36547,y:30952,cmnt:The inut color multiplied by the texture color to give the iput color a texture so that it doesnt look flat,varname:node_3710,prsc:2|A-9930-RGB,B-6045-RGB;n:type:ShaderForge.SFN_Blend,id:1513,x:35865,y:31603,varname:node_1513,prsc:2,blmd:1,clmp:False|SRC-2898-RGB,DST-9930-RGB;n:type:ShaderForge.SFN_Multiply,id:5238,x:38015,y:31065,cmnt:Applies the time of day,varname:node_5238,prsc:2|A-140-OUT,B-2220-OUT;n:type:ShaderForge.SFN_Get,id:228,x:35128,y:31244,varname:node_228,prsc:2|IN-5616-OUT;n:type:ShaderForge.SFN_Set,id:5616,x:34301,y:30666,varname:LightIN,prsc:2|IN-5128-OUT;n:type:ShaderForge.SFN_ValueProperty,id:3044,x:33442,y:30880,ptovrint:False,ptlb:LushLODTreeMainLightIntensity,ptin:_LushLODTreeMainLightIntensity,cmnt:This works even with lightmaps,varname:node_5384,prsc:2,glob:True,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,v1:1;n:type:ShaderForge.SFN_Get,id:2625,x:36102,y:31840,varname:node_2625,prsc:2|IN-5346-OUT;n:type:ShaderForge.SFN_Color,id:2194,x:33442,y:30696,ptovrint:False,ptlb:_LushLODTreeMainLightCol,ptin:_LushLODTreeMainLightCol,varname:node_2194,prsc:2,glob:True,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,c1:0.5,c2:0.5,c3:0.5,c4:1;n:type:ShaderForge.SFN_Add,id:1555,x:35363,y:31267,varname:node_1555,prsc:2|A-228-OUT,B-2898-RGB;n:type:ShaderForge.SFN_ValueProperty,id:5828,x:33219,y:32385,ptovrint:False,ptlb:_LushLODTreeTimeOfDay,ptin:_LushLODTreeTimeOfDay,varname:node_5828,prsc:2,glob:True,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,v1:1;n:type:ShaderForge.SFN_Lerp,id:6641,x:33429,y:32286,cmnt:Lets the user adjust the time of day correctio,varname:node_6641,prsc:2|A-2250-OUT,B-2282-OUT,T-5828-OUT;n:type:ShaderForge.SFN_Vector1,id:2250,x:33219,y:32320,varname:node_2250,prsc:2,v1:1;n:type:ShaderForge.SFN_ValueProperty,id:7432,x:33777,y:32912,ptovrint:False,ptlb:LushLODTreeTranslucency,ptin:_LushLODTreeTranslucency,cmnt:Lets the user adjust the translucency,varname:node_7432,prsc:2,glob:True,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,v1:1;n:type:ShaderForge.SFN_Clamp01,id:3965,x:32191,y:32936,varname:node_3965,prsc:2|IN-4910-OUT;n:type:ShaderForge.SFN_ValueProperty,id:2379,x:35939,y:32801,ptovrint:False,ptlb:LushLODTreeShadowContrast,ptin:_LushLODTreeShadowContrast,cmnt:Shadow Contrast,varname:node_2379,prsc:2,glob:True,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,v1:1;n:type:ShaderForge.SFN_RemapRangeAdvanced,id:7987,x:36561,y:32562,varname:node_7987,prsc:2|IN-7886-OUT,IMIN-4965-OUT,IMAX-6031-OUT,OMIN-9894-OUT,OMAX-2379-OUT;n:type:ShaderForge.SFN_Vector1,id:4965,x:36206,y:32469,varname:node_4965,prsc:2,v1:0;n:type:ShaderForge.SFN_Vector1,id:6031,x:36206,y:32540,varname:node_6031,prsc:2,v1:1;n:type:ShaderForge.SFN_Clamp01,id:7018,x:37346,y:32749,varname:node_7018,prsc:2|IN-7004-OUT;n:type:ShaderForge.SFN_OneMinus,id:9894,x:36161,y:32609,varname:node_9894,prsc:2|IN-2379-OUT;n:type:ShaderForge.SFN_OneMinus,id:7886,x:36177,y:32266,varname:node_7886,prsc:2|IN-5801-OUT;n:type:ShaderForge.SFN_Clamp,id:7004,x:37100,y:32749,varname:node_7004,prsc:2|IN-7987-OUT,MIN-8515-OUT,MAX-7059-OUT;n:type:ShaderForge.SFN_Vector1,id:7059,x:36787,y:32745,varname:node_7059,prsc:2,v1:1;n:type:ShaderForge.SFN_Multiply,id:5128,x:34084,y:30666,varname:node_5128,prsc:2|A-2194-RGB,B-2611-OUT;n:type:ShaderForge.SFN_Divide,id:2611,x:33883,y:30734,varname:node_2611,prsc:2|A-3044-OUT,B-3667-OUT;n:type:ShaderForge.SFN_Vector1,id:3667,x:33598,y:30740,varname:node_3667,prsc:2,v1:1.2;n:type:ShaderForge.SFN_OneMinus,id:8515,x:36838,y:32936,varname:node_8515,prsc:2|IN-5363-OUT;n:type:ShaderForge.SFN_Vector1,id:6880,x:32291,y:32560,varname:node_6880,prsc:2,v1:0.25;n:type:ShaderForge.SFN_ValueProperty,id:506,x:31545,y:33048,ptovrint:False,ptlb:ShadowStrength,ptin:_ShadowStrength,varname:_ShadowStrength,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,v1:1;n:type:ShaderForge.SFN_Color,id:2898,x:35135,y:31456,ptovrint:False,ptlb:LushLODTreeAmbientColor,ptin:_LushLODTreeAmbientColor,cmnt:_LushLODTreeAmbientColor... this value is set in the manager,varname:node_2898,prsc:2,glob:True,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,c1:0.5,c2:0.5,c3:0.5,c4:1;proporder:9930-5970-184-6045-506;pass:END;sub:END;*/

Shader "Hidden/LushLODTree/Simple Shadows" {
    Properties {
        _MainTex ("MainTex", 2D) = "white" {}
        [NoScaleOffset]_ShadowMapFront ("ShadowMapFront", 2D) = "white" {}
        [NoScaleOffset]_ShadowMapRight ("ShadowMapRight", 2D) = "white" {}
        _Color ("Color", Color) = (1,1,1,1)
        _ShadowStrength ("ShadowStrength", Float ) = 1
        [HideInInspector]_Cutoff ("Alpha cutoff", Range(0,1)) = 0.5
    }
    SubShader {
        Tags {
            "RenderType"="Opaque"
            "DisableBatching"="True"
        }
        LOD 100
        Pass {
            Name "FORWARD"
            Tags {
                "LightMode"="ForwardBase"
            }
            Cull Off
            ZWrite Off
            
            CGPROGRAM
            #pragma vertex vert
            #pragma fragment frag
            #define UNITY_PASS_FORWARDBASE
            #include "UnityCG.cginc"
            #pragma multi_compile_fwdbase_fullshadows
            #pragma target 3.0
            uniform sampler2D _ShadowMapFront;
            uniform sampler2D _ShadowMapRight;
            uniform sampler2D _MainTex; uniform float4 _MainTex_ST;
            float READ_ME_LOTS_OF_INFO_HERE(){
            //THIS SHADER isn't exactly meant to be used. Intead, you should copy/paste the code from
            //this shader, into the TreeCreatorLeavesOptimized_SimpleShadows.shader.
            
            //This shader does basically nothing except calculates shadows that are inside of the leaves
            //of the tree. It can't receive shadows from any other tree, only from itself. Therefore,
            //any material that is using this shader, should set its "receive shadows" checkbox to OFF.
            //This shader renders shadows much faster than Unity's built-in shadows, but the shadows
            //rendered by this shader aren't nearly as powerful.
            
            //Again, this shader isn't meant to be used as-is. The code from this shader is meant to be
            //copied into the TreeCreatorLeavesOptimized_SimpleShadows.shader, and becomes part of that
            //shader's shadow rendering process. The purpose of this shader is to simply allow you to
            //modify the "simple shadow" portion in Shader Forge. But if you make any changes to this
            //shader, you shold copy those changes into the above-mentioned shader so that it can be
            //used, since this shader is pretty ugly all by itself.
            
            //This shader requires two textures that are called Shadow Maps. These textures are created
            //automatically during the tree conversion process, which happens in the tree converter scene
            //that is included with LushLOD trees. That happens in the "LushLOD Tree Converter" scene,
            //and is handled by the script named _LushLODTreeConverter.cs.
            
            //If you for whatever crazy reason want to edit this shader, please follow the steps below to
            //apply your changes so that they will work with LushLOD trees.
            
            //Steps:
            
            //1) Open this shader in shader forge, and make whatever crazy changes you wanna.
            
            //2) Save this shader.
            
            //3) Double-click this shader file to open it (don't click the "compile and show code" button)
            
            //4) You'll need to copy some lines of code, starting where the "////// Lighting:" 
            //comment is found in the surf() function.
            
            //5) Double-click the TreeCreatorLeavesOptimized_SimpleShadows.shader file to open it in
            //a text editor.
            
            //6) File the surf() function near the top of that shader file.
            
            //7) Find the comments that say "Start of Simple Shadow Code" and "End of Simple Shadow Code".
            
            //8) Paste the code you copied from this shader, into that area. Overwrite the old code.
            
            //9) In the _LushLODTreesManager which is automatically added to any scene that has a
            //LushLOD tree in it, look for the option to switch to "Simple Shadows" mode. You should
            //then see the trees working with whatever changes you made.
            
            //NOTE: You can also copy this shader's code into other shaders that use the Simple Shadows
            //code.
            
            return 0; //<-- dummy return.
            }
            
            uniform float4 _LushLODTreeMainLightDir;
            uniform float _LushLODTreeMaxShadowAdd;
            uniform float _LushLODTreeTranslucencySharpen;
            uniform float _LushLODTreeShadowDarkness;
            uniform float4 _Color;
            uniform float _LushLODTreeMainLightIntensity;
            uniform float4 _LushLODTreeMainLightCol;
            uniform float _LushLODTreeTimeOfDay;
            uniform float _LushLODTreeTranslucency;
            uniform float _LushLODTreeShadowContrast;
            uniform float _ShadowStrength;
            uniform float4 _LushLODTreeAmbientColor;
            struct VertexInput {
                float4 vertex : POSITION;
                float2 texcoord0 : TEXCOORD0;
                float2 texcoord2 : TEXCOORD2;
                float2 texcoord3 : TEXCOORD3;
            };
            struct VertexOutput {
                float4 pos : SV_POSITION;
                float2 uv0 : TEXCOORD0;
                float2 uv2 : TEXCOORD1;
                float2 uv3 : TEXCOORD2;
                float4 posWorld : TEXCOORD3;
            };
            VertexOutput vert (VertexInput v) {
                VertexOutput o = (VertexOutput)0;
                o.uv0 = v.texcoord0;
                o.uv2 = v.texcoord2;
                o.uv3 = v.texcoord3;
                float node_3176 = READ_ME_LOTS_OF_INFO_HERE();
                v.vertex.xyz += float3(node_3176,node_3176,node_3176);
                o.posWorld = mul(unity_ObjectToWorld, v.vertex);
                o.pos = UnityObjectToClipPos( v.vertex );
                return o;
            }
            float4 frag(VertexOutput i, float facing : VFACE) : COLOR {
                float isFrontFace = ( facing >= 0 ? 1 : 0 );
                float faceSign = ( facing >= 0 ? 1 : -1 );
                float3 viewDirection = normalize(_WorldSpaceCameraPos.xyz - i.posWorld.xyz);
                float4 _MainTex_var = tex2D(_MainTex,TRANSFORM_TEX(i.uv0, _MainTex));
                clip(_MainTex_var.a - 0.5);
////// Lighting:
                float3 LightIN = (_LushLODTreeMainLightCol.rgb*(_LushLODTreeMainLightIntensity/1.2));
                float4 _ShadowMapFront_var = tex2D(_ShadowMapFront,i.uv2); // Must rename i.uv2 to i.uv3_ShadowMapFront
                float3 LightDir = _LushLODTreeMainLightDir.rgb;
                float node_6270 = lerp(_ShadowMapFront_var.r,_ShadowMapFront_var.b,saturate((0.5*dot(mul( unity_ObjectToWorld, float4(float3(1,0,0),0) ).xyz.rgb,LightDir)+0.5*1.5+-0.25))); // Fades between light coming from the RIGHT or LEFT side when viewed from the Z axis
                float4 _ShadowMapRight_var = tex2D(_ShadowMapRight,i.uv3); // Must rename i.uv3 to i.uv4_ShadowMapRight
                float node_2028 = lerp(_ShadowMapRight_var.r,_ShadowMapRight_var.b,saturate((0.5*dot(mul( unity_ObjectToWorld, float4(float3(0,0,1),0) ).xyz.rgb,LightDir)+0.5*1.5+-0.25))); // Fades between the light coming from the RIGHT or LEFT side when viewed from the X axis
                float node_9362 = lerp(0.0,((_ShadowMapFront_var.g+_ShadowMapRight_var.g)/2.0),saturate((0.5*dot(mul( unity_ObjectToWorld, float4(float3(0,1,0),0) ).xyz.rgb,LightDir)+0.5*1.5+-0.25))); // Fades between maximum shadowing if the light is directly above OR zero shadowing if the light is coming from direction under the tree
                float MaximumShadows = (_ShadowStrength+_LushLODTreeMaxShadowAdd);
                float node_8575 = (saturate((1.0-(1.0-(1.0-(1.0-node_6270)*(1.0-node_2028)))*(1.0-node_9362)))*MaximumShadows);
                float node_8084 = 0.0;
                float node_7978 = 1.0;
                float node_8622 = (node_8084-_LushLODTreeTranslucencySharpen);
                float node_1780 = 0.5*dot(viewDirection,LightDir)+0.5; // Check if view is opposite the direction of sunlight
                float Backside_Darkening_Amount = node_1780;
                float FinalBeforeRescale = lerp(saturate((node_8622 + ( (node_8575 - node_8084) * ((node_7978+_LushLODTreeTranslucencySharpen) - node_8622) ) / (node_7978 - node_8084))),node_8575,saturate((Backside_Darkening_Amount*2.0)));
                float node_4965 = 0.0;
                float node_9894 = (1.0 - _LushLODTreeShadowContrast);
                float ShadowMapDarkeningVal = saturate(clamp((node_9894 + ( ((1.0 - FinalBeforeRescale) - node_4965) * (_LushLODTreeShadowContrast - node_9894) ) / (1.0 - node_4965)),(1.0 - _LushLODTreeShadowDarkness),1.0));
                float3 node_3797 = lerp(((_LushLODTreeAmbientColor.rgb*_MainTex_var.rgb)*0.8),(_MainTex_var.rgb*(LightIN+_LushLODTreeAmbientColor.rgb)),ShadowMapDarkeningVal); // The final color with the shadows and the ambient tint applied to the shadows
                float node_4284 = min(min(_Color.r,_Color.g),_Color.b); // Finds how much LESS than WHITE the iput color is
                float node_424 = 0.0;
                float node_1563 = 0.0;
                float TimeOfDayIntensity = lerp(1.0,saturate((node_1563 + ( (saturate((dot(float3(0,1,0),LightDir)+0.25)) - node_424) * ((1.3+(Backside_Darkening_Amount*2.0)) - node_1563) ) / (1.0 - node_424))),_LushLODTreeTimeOfDay); // This is an optional lighting adjustment you can remove this if your scene doesnt benefit from this.
                float3 finalColor = (lerp((node_3797*_Color.rgb),lerp((_MainTex_var.rgb*_Color.rgb),node_3797,node_4284),(max(max(_Color.r,_Color.g),_Color.b)-node_4284))*TimeOfDayIntensity);
                float LightAtten = (saturate((ShadowMapDarkeningVal*2.5+-1.5))*TimeOfDayIntensity*_LushLODTreeTranslucency); // Used in our custom LightModel to create the translucency effect
                return fixed4(finalColor,max(max(LightAtten,1.0),TimeOfDayIntensity));
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
            #pragma fragmentoption ARB_precision_hint_fastest
            #pragma multi_compile_shadowcaster
            #pragma target 3.0
            uniform sampler2D _MainTex; uniform float4 _MainTex_ST;
            float READ_ME_LOTS_OF_INFO_HERE(){
            //THIS SHADER isn't exactly meant to be used. Intead, you should copy/paste the code from
            //this shader, into the TreeCreatorLeavesOptimized_SimpleShadows.shader.
            
            //This shader does basically nothing except calculates shadows that are inside of the leaves
            //of the tree. It can't receive shadows from any other tree, only from itself. Therefore,
            //any material that is using this shader, should set its "receive shadows" checkbox to OFF.
            //This shader renders shadows much faster than Unity's built-in shadows, but the shadows
            //rendered by this shader aren't nearly as powerful.
            
            //Again, this shader isn't meant to be used as-is. The code from this shader is meant to be
            //copied into the TreeCreatorLeavesOptimized_SimpleShadows.shader, and becomes part of that
            //shader's shadow rendering process. The purpose of this shader is to simply allow you to
            //modify the "simple shadow" portion in Shader Forge. But if you make any changes to this
            //shader, you shold copy those changes into the above-mentioned shader so that it can be
            //used, since this shader is pretty ugly all by itself.
            
            //This shader requires two textures that are called Shadow Maps. These textures are created
            //automatically during the tree conversion process, which happens in the tree converter scene
            //that is included with LushLOD trees. That happens in the "LushLOD Tree Converter" scene,
            //and is handled by the script named _LushLODTreeConverter.cs.
            
            //If you for whatever crazy reason want to edit this shader, please follow the steps below to
            //apply your changes so that they will work with LushLOD trees.
            
            //Steps:
            
            //1) Open this shader in shader forge, and make whatever crazy changes you wanna.
            
            //2) Save this shader.
            
            //3) Double-click this shader file to open it (don't click the "compile and show code" button)
            
            //4) You'll need to copy some lines of code, starting where the "////// Lighting:" 
            //comment is found in the surf() function.
            
            //5) Double-click the TreeCreatorLeavesOptimized_SimpleShadows.shader file to open it in
            //a text editor.
            
            //6) File the surf() function near the top of that shader file.
            
            //7) Find the comments that say "Start of Simple Shadow Code" and "End of Simple Shadow Code".
            
            //8) Paste the code you copied from this shader, into that area. Overwrite the old code.
            
            //9) In the _LushLODTreesManager which is automatically added to any scene that has a
            //LushLOD tree in it, look for the option to switch to "Simple Shadows" mode. You should
            //then see the trees working with whatever changes you made.
            
            //NOTE: You can also copy this shader's code into other shaders that use the Simple Shadows
            //code.
            
            return 0; //<-- dummy return.
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
                float node_3176 = READ_ME_LOTS_OF_INFO_HERE();
                v.vertex.xyz += float3(node_3176,node_3176,node_3176);
                o.pos = UnityObjectToClipPos( v.vertex );
                TRANSFER_SHADOW_CASTER(o)
                return o;
            }
            float4 frag(VertexOutput i, float facing : VFACE) : COLOR {
                float isFrontFace = ( facing >= 0 ? 1 : 0 );
                float faceSign = ( facing >= 0 ? 1 : -1 );
                float4 _MainTex_var = tex2D(_MainTex,TRANSFORM_TEX(i.uv0, _MainTex));
                clip(_MainTex_var.a - 0.5);
                SHADOW_CASTER_FRAGMENT(i)
            }
            ENDCG
        }
    }
    FallBack "Diffuse"
    CustomEditor "ShaderForgeMaterialInspector"
}
