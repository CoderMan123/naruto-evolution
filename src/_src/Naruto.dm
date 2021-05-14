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
	if(full)
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
client//the client
    New()//when logs on to game
        ..()
        //if(key=="Guest-[computer_id]")//Checks if guest and finds their id
           // sleep(20) //hold for a few mili seconds
            //del(src)//kick them out

var/full=0
var/servertype = "Version 1.3.9"
world
	name = "Naruto Evolution"
	hub= "Squigs.NETheNewEra"
	hub_password = "Ue7DTLSxJx1vnALy"
	status="Naruto Evolution (Connecting...) | Ninjas Online (Connecting...)"

	view = 16
	loop_checks=1
	proc/PlayerCount()
		set background=1
		while(world)
			sleep(600)//One minute each to check! Not .2 seconds=EPIC LAG!
			var/number=0
			for(var/mob/M in mobs_online)if(M.key)number++
			Players=number
			if(Players>=MaxPlayers)full=1
			else full=0
			status="Naruto Evolution v[global.servertype] | Ninjas Online ([Players]/[MaxPlayers])"

proc/RepopWorld()
	set background=1
	while(world)
		sleep(600*5)
		world.Repop()

proc/Advert()
	set background = 1
	while(world)
		world<<"<font color=white><b>Don't forget to visit our <a href=\"http://www.byond.com/games/Squigs/NETheNewEra/\">HUB</a>, and join the <a href=\"https://discord.gg/URcN6cc\">Discord</a> for news and updates!</b></font>!"
		sleep(600*30)
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
client
	mouse_pointer_icon='VillageSymbols.dmi'
	//lazy_eye = 5
	//mouse_over_pointer='pointero.dmi'
//	Stat()
//		.=..()
		//src.overlays=0//Clears the player's overlays so the letters won't build up on top of each other.
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
	Logout()
		for(var/obj/O in world)if(O.IsJutsuEffect==src) del(O)
		for(var/mob/M in src.puppets)del(M)
		if(src.MissionUp) src.MissionUp=0
		if(src.inboulder==1) src.inboulder=0
		if(src.ingpill==1)
			src.ingpill=0
			src.strength-=15
		if(src.inypill==1)
			src.inypill=0
			src.strength-=25
		if(src.inrpill==1)
			src.inrpill=0
			src.strength-=40
		if(src.dueling==1)
			src.loc=MapLoadSpawn()
			src.opponent.loc=MapLoadSpawn()
			src.opponent.dueling = 0
			arenaprogress=0
			world<<"[src] has logged out during an Arena challenge. Match has become Null."
		if(src.incalorie==1)
			for(var/obj/Jutsus/CalorieControl/J in src.jutsus)
				src.incalorie=0
				src.strength-=J.damage
				src.overlays=0
		if(src.incurse==1)
			src.incurse=0
			src.strength-=15
			src.ninjutsu-=10
			src.underlays=null
			src.overlays=null
		if(src.insage==1)
			src.insage=0
			src.strength-=10
			src.ninjutsu-=20
			src.underlays=null
			src.overlays=null
		if(src.inAngel==1)
			src.inAngel=0
			src.underlays=null
			src.overlays=null

		if(src.inJC1==1)
			src.inJC1=0
			src.ninjutsu-=35
			src.defence-=35
			src.underlays=null
			src.overlays=null

		if(src.inJC2==1)
			src.inJC2=0
			src.ninjutsu-=35
			src.agility-=35
			src.underlays=null
			src.overlays=null

		if(src.inJC3==1)
			src.inJC3=0
			src.defence-=50
			src.underlays=null
			src.overlays=null

		if(src.inJC4==1)
			src.inJC4=0
			src.strength-=50
			src.underlays=null
			src.overlays=null

		if(src.inJC5==1)
			src.inJC5=0
			src.strength-=35
			src.agility-=35
			src.underlays=null
			src.overlays=null

		if(src.inJC6==1)
			src.inJC6=0
			src.ninjutsu-=50
			src.underlays=null
			src.overlays=null

		if(src.inJC7==1)
			src.inJC7=0
			src.strength-=35
			src.agility-=35
			src.underlays=null
			src.overlays=null

		if(src.inJC8==1)
			src.inJC8=0
			src.strength-=50
			src.underlays=null
			src.overlays=null

		if(src.inJC9==1)
			src.inJC9=0
			src.strength-=35
			src.ninjutsu-=35
			src.underlays=null
			src.overlays=null

		if(src in global.genintesters)
			global.genintesters-=src
			src.loc = locate(11,69,2)
		if(Chuunins.Find(src))
			Chuunins-=src
			src.loc=MapLoadSpawn()
		if(village!="Anbu Root")
			for(var/obj/Inventory/Clothing/Robes/Anbu_Suit/O in src)
				if(ClothingOverlays[O.section]==O.icon)RemoveSection(O.section)
				del(O)
			for(var/obj/Inventory/Clothing/Masks/Absolute_Zero_Mask/O in src)
				if(ClothingOverlays[O.section]==O.icon)RemoveSection(O.section)
				del(O)
		if(village!="Akatsuki")
			for(var/obj/Inventory/Clothing/Robes/Akatsuki_Robe/O in src)
				if(ClothingOverlays[O.section]==O.icon)RemoveSection(O.section)
				del(O)
			for(var/obj/Inventory/Clothing/HeadWrap/AkatsukiHat/O in src)
				if(ClothingOverlays[O.section]==O.icon)RemoveSection(O.section)
				del(O)
			for(var/obj/Inventory/Clothing/Masks/Tobi_Mask/O in src)
				if(ClothingOverlays[O.section]==O.icon)RemoveSection(O.section)
				del(O)
		/*if(rank!="ANBU")
			for(var/obj/Inventory/Clothing/Masks/Anbu/O in src)
				if(ClothingOverlays[O.section]==O.icon)RemoveSection(O.section)
				del(O)
			for(var/obj/Inventory/Clothing/Masks/Anbu_Black/O in src)
				if(ClothingOverlays[O.section]==O.icon)RemoveSection(O.section)
				del(O)
			for(var/obj/Inventory/Clothing/Masks/Anbu_Blue/O in src)
				if(ClothingOverlays[O.section]==O.icon)RemoveSection(O.section)
				del(O)
			for(var/obj/Inventory/Clothing/Masks/Anbu_Purple/O in src)
				if(ClothingOverlays[O.section]==O.icon)RemoveSection(O.section)
				del(O)*/

		if(rank!="Sage")
			for(var/obj/Inventory/Clothing/Robes/Sage_Robe/O in src)
				if(ClothingOverlays[O.section]==O.icon)RemoveSection(O.section)
				del(O)
		if(rank!="Hokage")
			for(var/obj/Inventory/Clothing/Robes/HokageRobe/O in src)
				if(ClothingOverlays[O.section]==O.icon)RemoveSection(O.section)
				del(O)
			for(var/obj/Inventory/Clothing/HeadWrap/HokageHat/O in src)
				if(ClothingOverlays[O.section]==O.icon)RemoveSection(O.section)
				del(O)
		if(rank!="Kazekage")
			for(var/obj/Inventory/Clothing/Robes/KazekageRobe/O in src)
				if(ClothingOverlays[O.section]==O.icon)RemoveSection(O.section)
				del(O)
			for(var/obj/Inventory/Clothing/HeadWrap/KazekageHat/O in src)
				if(ClothingOverlays[O.section]==O.icon)RemoveSection(O.section)
				del(O)
		if(rank!="Otokage")
			for(var/obj/Inventory/Clothing/Robes/OtokageRobe/O in src)
				if(ClothingOverlays[O.section]==O.icon)RemoveSection(O.section)
				del(O)
			for(var/obj/Inventory/Clothing/HeadWrap/OtokageHat/O in src)
				if(ClothingOverlays[O.section]==O.icon)RemoveSection(O.section)
				del(O)
		if(rank!="Mizukage")
			for(var/obj/Inventory/Clothing/HeadWrap/MizukageHat/O in src)
				if(ClothingOverlays[O.section]==O.icon)RemoveSection(O.section)
				del(O)
			for(var/obj/Inventory/Clothing/Robes/MizukageRobe/O in src)
				if(ClothingOverlays[O.section]==O.icon)RemoveSection(O.section)
				del(O)
				del(O)
		if(rank!="Tsuchikage")
			for(var/obj/Inventory/Clothing/HeadWrap/TsuchikageHat/O in src)
				if(ClothingOverlays[O.section]==O.icon)RemoveSection(O.section)
				del(O)
			for(var/obj/Inventory/Clothing/Robes/TsuchikageRobe/O in src)
				if(ClothingOverlays[O.section]==O.icon)RemoveSection(O.section)
				del(O)
		if(loc in block(locate(71,95,4),locate(200,163,4))) // If they are in FoD
			loc=MapLoadSpawn() // Remember to change depending on villages!
			for(var/obj/ChuuninExam/Scrolls/S in src)del(S)
		if(loc in block(locate(113,29,4),locate(146,58,2)))loc=MapLoadSpawn()
		if(MissionUp) MissionUp=0
		if(NaraTarget)
			var/mob/M=NaraTarget
			M.move=1
			M.injutsu=0
			M.canattack=1
			NaraTarget=null
		if(Prisoner)
			var/mob/M=Prisoner
			if(M.client)
				M.client.eye=M
				M.client:perspective = EYE_PERSPECTIVE
			M.move=1
			M.canattack=1
			M.injutsu=0
			Prisoner=null

		if(src.key&&src.name)world<<"[src.name] has logged out!"
		if(Squad)
			if(Squad.Leader == ckey)del Squad
			else if(Squad.Members.Find(ckey))
				for(var/i in Squad.Members)
					var/mob/P = getOwner(i)
					P.Squad.Members -= ckey
				var/mob/P = getOwner(Squad.Leader)
				P.Squad.Members -= ckey
		for(var/mob/Clones/C in src.Clones)
			del(C)
		var/Faction/c=getFaction(src.Faction)
		if(c)
			c.onlinemembers -= usr
			c.members[rname] = list(key, level, Factionrank)
			usr.verbs -= Factionverbs
		src.overlays-=src.overlays
		//image('Jutsus.dmi',"burning")
		//src.overlays-=image('Jutsus2.dmi',"Meat Tank")
		pixel_y = 0
		pixel_x = 0
		for(var/mob/jutsus/Summon_Spider/A in world)
			if(A.OWNER==src)
				del(A)
		for(var/mob/summonings/SnakeSummoning/B in world)
			if(B.lowner==src)
				del(B)
		for(var/mob/jutsus/KazekagePuppet/C in world)
			if(C.OWNER==src)
				del(C)
		for(var/mob/summonings/DogSummoning/D in world)
			if(D.lowner==src)
				del(D)
		//var/list/possible_entries = typesof(/mob/Jutsus/verb)
		//var/list/current_verbs = src.verbs.Copy()
		//for(var/R in current_verbs) if(!(R in possible_entries)) current_verbs -= R
		if(!src.key) //This means that they're simply switching mobs
			world.log << "[src.rname] has left their mob without logging out."
			del src
			return
		del(src)
		..()

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