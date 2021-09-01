var/list/Badwords = list("byond://","www.","http://","\n")
var/const/allowed_characters_name = "abcdefghijklmnopqrstuvwxyz' "// removed >> and . from name creation because it can fuck our verbs. specifically edit, checkstats, boot, ban, etc.
mob/var/Logins
proc/ffilter_characters(var/string, var/allowed = allowed_characters_name)
	set background = 1
	if(!string || !allowed) return 0
	var/stringlen = length(string)
	var/newstring = ""
	for(var/i = 1 to stringlen)
		var/char = copytext(string, i, i+1)
		if(findtext(allowed, char)) newstring += char
		sleep(-1)
	return newstring
proc/hasSavefile(var/ckey)
	ckey=lowertext(ckey)
	var/letter = copytext(ckey,1,2)
	return fexists("saves/characters/[letter]/[ckey].sav")
proc/uppercase(var/string, var/pos=1)
	if(!string || !pos) return
	return uppertext(copytext(string, pos, pos+1))+copytext(string, pos+1)
client/Del()
	if(Members.Find(src.ckey)) Members-=src.ckey
	..()
client/New()
	if(mobs_online.len >= server_capacity)
		if(IsByondMember())
			if(Members.len<MaxMembers)
				Members++
				src<<"You've been let into the server due to your BYOND Membership. Thanks for supporting BYOND!"
				..()
				return
		src<<"Server is full."
		del(src)
		return
	..()

proc/RepopWorld()
	set background=1
	while(world)
		sleep(600*5)
		world.Repop()
		
var/MOTD
var/list/MapLoadSpawn= newlist()
var/list/Respawn= newlist()
mob/proc/MapLoadSpawn()
	for(var/turf/Spawns/StartSpot/S in world)
		if(S.Village==village)return S
mob/proc/RespawnSpawn()
	var/list/Respawns=list()
	for(var/turf/Spawns/RespawnSpot/S in world)
		if(S.Village==village)Respawns+=S
	return Respawns
mob
	var/SkinTone

obj
	MaleParts
		UnderShade
			icon='Shade.dmi'
			icon_state="undershade"
			pixel_y=-2
			pixel_x=15
			layer=TURF_LAYER+1
		UnderShadeSmall
			icon='Shade.dmi'
			icon_state="undershade"
			pixel_y=-2
			layer=TURF_LAYER+1

obj/CinematicFollower
	//icon='checkbox.dmi'
	//icon_state="unchecked"
	layer=999
	New(var/mob/M)
		if(!ismob(M)) return
		M.client.screen+=src
		screen_loc = "CENTER-6,CENTER"
		src.loc=locate(0,0,0)
		..()
obj/FadingHUD
	icon = 'Misc Effects.dmi'
	screen_loc = "SOUTHWEST to NORTHEAST"
	icon_state = "Fade"
	layer = 600
	name = null
	mouse_opacity=0
	New(var/client/C)
		..()
		C.screen += src
		spawn(10) del(src)

mob/var/tmp/Prisoner		

mob
	verb
		CloseBrowser()
			set hidden=1
			winset(src, null, {"
						Browser.is-visible = "false";
					"})
		MiniWindow()
			set hidden=1
			winset(usr, "Main", "is-minimized=true")

/*
mob
	proc
		ResetBase()
			switch(SkinTone)
				if("White") icon='WhiteMBase.dmi'
				if("Dark") icon='DarkMBase.dmi'
				if("Blue") icon='BlueMBase.dmi'
*/
mob
	proc
		ResetBase()
			if(SkinTone == "White") icon='WhiteMBase.dmi'
			if(SkinTone == "Dark") icon='DarkMBase.dmi'
			if(SkinTone == "Blue") icon='BlueMBase.dmi'
			if(SkinTone == "Pale") icon='PaleMBase.dmi'


//client/control_freak=CONTROL_FREAK_ALL