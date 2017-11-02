#define WORLD_SAVE "Savefiles/World.sav"

var/full=0
var/servertype = "Official"
var/list/ServerInfo=list("name"="Project Evolution", "version"="1.0.0.0", "prefix"="", "suffix"="", "type"="Official")
world
	name = ""
	hub= "Lavitiz.ProjectEvolution"
	hub_password="CMq0hXJddFhgzcLU"
	status=""
	mob = /mob
	turf=/turf/Ground/Grass
	view = 16
	loop_checks=1
	//cache_lifespan=0
	//tick_lag=1
	//icon_size=64
	proc/PlayerCount()
		set background=1
		while(world)
			sleep(600)//One minute each to check! Not .2 seconds=EPIC LAG!
			var/number=0
			for(var/mob/player/M in world)if(M.key)number++
			Players=number
			if(Players>=MaxPlayers)full=1
			else full=0
			status = "<font face=MS Comic Sans>[ServerInfo["name"]] Version [ServerInfo["prefix"]][ServerInfo["version"]][ServerInfo["suffix"]] | [ServerInfo["type"]] Server | ([Players]/[MaxPlayers])"
	New()
		//..()
		//world.status="<font face= Times New Roman>Ninja Adventure(Alpha Version) (TEST SERVER)"
		//spawn()
		//	TimeEffect()
		log = file("Savefiles/Errorlog.txt")
		name = "[ServerInfo["name"]] Version [ServerInfo["prefix"]][ServerInfo["version"]][ServerInfo["suffix"]] | [ServerInfo["type"]] Server"
		spawn() RepopWorld()
		spawn() GeninExam()
		spawn() ChuuninExam()
		spawn() Advert()
		//spawn() AutomaticReboot()
		spawn(5) PlayerCount()
		spawn() HTMLlist()
		if(!fexists(WORLD_SAVE)) return
		var/savefile/F = new(WORLD_SAVE)
		if(!isnull(F["Factions"])) F["Factions"] >> Factionnames
		if(!isnull(F["Maps"])) F["Maps"] >> maps
		if(!isnull(F["SandLevel"])) F["SandLevel"] >> SandLevel
		if(!isnull(F["LeafLevel"])) F["LeafLevel"] >> LeafLevel
		if(!isnull(F["SandExp"])) F["SandExp"] >> SandExp
		if(!isnull(F["LeafExp"])) F["LeafExp"] >> LeafExp
		if(!isnull(F["SandExpmax"])) F["SandExpmax"] >> SandExpmax
		if(!isnull(F["LeafExpmax"])) F["LeafExpmax"] >> LeafExpmax
		if(!isnull(F["Expboosts"])) F["Expboosts"] >> Expboosts
		for(var/c in Factionnames)
			var/path = "Factions/[c].sav"
			var/savefile/G = new(path)
			if(!fexists(path))
				Factionnames -= c
				continue
			var/Faction/Faction
			G >> Faction
			Factions += Faction
		..()
	Del()
		var/savefile/F = new(WORLD_SAVE)
		Factionnames = new/list()
		for(var/Faction/c in Factions)
			if(!c.name) continue
			var/path = "Factions/[c.name].sav"
			var/savefile/G = new(path)
			G << c
			Factionnames += c.name
		if(maps.len) F["Maps"] << maps
		F["Factions"] << Factionnames
		F["SandLevel"] << SandLevel
		F["LeafLevel"] << LeafLevel
		F["SandExp"] << SandExp
		F["LeafExp"] << LeafExp
		F["SandExpmax"] << SandExpmax
		F["LeafExpmax"] << LeafExpmax
		F["Expboosts"] << Expboosts
		..()
		//for(var/turf/Spawns/RespawnSpot/GS in world)
		//	Respawn.Add(GS)
		//for(var/turf/Spawns/StartSpot/GS in world)
	//		MapLoadSpawn.Add(GS)

var/list/Badwords = list(\
	"fag","bastard","fuck","fucker","f u c k",
	"cock","cunt","pussy","bitch","nigger","chink",
	"slut","fucking","byond://",
	"fking","fag","b!tch","nigga"," a.ss","n.igger","http://","fawk","b-otch",
	"cum","f@g","\n"," ass","shit")
var/const/allowed_characters_name = "abcdefghijklmnopqrstuvwxyz' .	"
mob/var/Password
proc/filter_characters(var/string, var/allowed = allowed_characters_name)
	set background = 1
	if(!string || !allowed) return 0
	var/stringlen = lentext(string)
	var/newstring = ""
	for(var/i = 1 to stringlen)
		var/char = copytext(string, i, i+1)
		if(findtext(allowed, char)) newstring += char
		sleep(-1)
	return newstring

proc/hasSavefile(var/key)
	var/letter = copytext(key,1,2)
	return fexists("Savefiles/Players/[letter]/[key].sav")

proc/uppercase(var/string, var/pos=1)
	if(!string || !pos) return
	return uppertext(copytext(string, pos, pos+1))+copytext(string, pos+1)
client
	New()
		..()
		spawn(5)GetScreenResolution(src.mob)
		//src.mob<<sound('preview.ogg')
		winset(src.mob, null, {"
			MainWindow.Maplink.right=titlescreen;
			MainWindow.is-maximized=true
			MainWindow.UnlockChild.is-visible = "false";
			MainWindow.InvenChild.is-visible = "false";
			MainWindow.Stats.is-visible      = "false";
			MainWindow.SkillBar.is-visible      = "false";
			MainWindow.ChatOut.is-visible      = "false";
			MainWindow.ActionOutputChild.is-visible      = "false";
			"})
		src.mob.StaffCheck()

	Del()
		if(Members.Find(src.ckey)) Members-=src.ckey
		..()
/*
	if(usr) return ..()
	var/mob/Login/MOB
	for(var/mob/Login/M in world) if(!M.client)
		MOB = M
		break
	if(!MOB) MOB = new
	MOB.name = src.key
	MOB.gender = src.gender
	MOB.client = src
	return MOB*/
proc/RepopWorld()
	set background=1
	while(world)
		sleep(600*3)
		//for(var/mob/player/M in world)if(M.client&&M.key)M.Save() Use automatic saving for EACH mob, otherwise it'll lag.
		world.Repop()
proc/AutomaticReboot()
	set background=1
	while(world)
		sleep(600*175)
		world<<"<center><b>Automatically rebooting server in 5 minutes!</b></center>"
		sleep(660*5)
		world<<"<center><b>Automatically rebooting server!</b></center>"
		world.Reboot()
proc/Advert()
	set background = 1
	while(world)
		world<<"<font color=white><b>Don't forget to visit our <a href=[_forumURL]>forums</a></b></font>!"
		sleep(600*15)
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
	var/ownerkey
//	return pick(MapLoadSpawn)

//atom
//	movable
//		pixel_step_size=4
//		animate_movement=2
obj
	MaleParts
		UnderShade
			icon='Shade.dmi'
			icon_state="undershade"
			pixel_y=-2
			pixel_x=15
			layer=TURF_LAYER+1
client
	mouse_pointer_icon='mousepointer.dmi'
	//lazy_eye = 5
	//mouse_over_pointer='pointero.dmi'
//	Stat()
//		.=..()
		//src.overlays=0//Clears the player's overlays so the letters won't build up on top of each other.
obj/CinematicFollower
	//icon='checkbox.dmi'
	//icon_state="unchecked"
	layer=99999999999999999999999999999999999
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
//var/dmifont/_AdobeSongStdLBold24pt_AA16/cinefont = new
mob/var/CinematicGoing
mob/proc
	CinematicOpening()
		var/SY=1
		var/mob/EYEBALL=new()
		EYEBALL.name="EYE"
		EYEBALL.loc=locate(101,1,17)
		EYEBALL.density=0
		EYEBALL.invisibility=1
		src.client.eye=EYEBALL
		src.client:perspective = EYE_PERSPECTIVE
//		src.client.eye=locate(101,1,17)
//		src.client:perspective = EYE_PERSPECTIVE
		src.CinematicGoing=(600)
	//	var/MX=src.XView/2
	//	var/MY=src.YView/2
		var/obj/CinematicFollower/MS=new(src)
		spawn(2)
			while(CinematicGoing)
				sleep(5)
				if(CinematicGoing==600) new/obj/FadingHUD(src.client)
				CinematicGoing-=5
				SY++
				EYEBALL.loc=locate(101,SY,17)
				src.client:perspective = EYE_PERSPECTIVE
//				if(CinematicGoing==550)cinefont.QuickText2(MS,"The Shinobi World is in great turmoil..","#fff",1)
				if(CinematicGoing==400)
					MS.overlays=null
//					cinefont.QuickText2(MS,"A great war rages, with catastrophic losses on each side.","#fff",1)
//				if(CinematicGoing==320)
					MS.overlays=null
//					cinefont.QuickText2(MS,"You have an important role to take in this battle..","#fff",1)
//				if(CinematicGoing==250)
					MS.overlays=null
//					cinefont.QuickText2(MS,"Will you rise as a shinobi to defeat evil..","#fff",1)
//				if(CinematicGoing==180)
					MS.overlays=null
//					cinefont.QuickText2(MS,"Or conquer those who stand in your way?","#fff",1)
//				if(CinematicGoing==100)
					MS.overlays=null
//					cinefont.QuickText2(MS,"That is your destiny. Choose your path.","#fff",1)
				if(CinematicGoing==12)new/obj/FadingHUD(src.client)
		while(CinematicGoing>0) sleep(1)
		src.client.eye=src
		src.client:perspective = EYE_PERSPECTIVE
		del(MS)
		del(EYEBALL)
	//	proc/QuickText(atom/A, txt, color="#fff", outline, x=0, y=0, bottom, justify=DF_JUSTIFY_LEFT, layer=FLY_LAYER)
mob


	verb/Logins()
		set hidden=1
		var/LoginID=winget(src,"titlescreen.Username","text")
		var/LoginPW=winget(src,"titlescreen.Password","text")
		LoginID=lowertext(LoginID)
		var/letter = copytext(LoginID,1,2)
		if(hasSavefile(src.key))
			var/savefile/F = new("Savefiles/Players/[letter]/[LoginID].sav")
			if(isnull(F["Password"]))
				src.skalert("No password set for this account, please try again.","Invalid")
				return
			F["Password"] >> src.Password
			if(!LoginPW)
				src.skalert("Please enter a password.","Invalid")
				return
			if(!LoginID)
				src.skalert("Please enter an account ID.","Invalid")
				return
			if(!hasSavefile(LoginID))
				src.skalert("Invalid Account ID.","Invalid")
				return
			if(LoginPW!=src.Password)
				src.skalert("Invalid Password.","Invalid")
				return
			src.LoadCharacter(LoginID)
		else
			src.skalert("Invalid Account ID.","Invalid")
			return


	proc/LoadCharacter(var/LoginID)
		winset(src, null, {"
			MainWindow.SkillBar.is-visible="true";
			MainWindow.ChatOut.is-visible="true";
			MainWindow.ActionOutputChild.is-visible="true";
			MainWindow.Maplink.right=mapwindow;
						"})
		GetScreenResolution(src)
		src.Load()



	verb/CreateCharacter()
		set hidden=1
		if(src.client)
			src.Ryo=25
			src.ownerkey = src.key
			src.creating=1
			GetScreenResolution(src)
			var/ck = uppercase(src.ckey, 1)
			src.name=null
			while(src.name==null)
				sleep(1)
				if(src)
					var/ZZ=src.skinput2("Type in a name. Names from the anime are strongly looked down upon.","Name",ck,0)
					if(src)
						src.name = ZZ
						var/leng = lentext(src.name)
						if(hasSavefile(src.name))
							src.skalert("The name you entered already exists.")
							src.name = null
							continue

						if((leng>20) || (leng<3))
							src.skalert("The name must be between 3 and 20 characters.")
							src.name = null
							continue

						if(uppertext(src.name) == src.name)
							src.skalert("Your name may not consist entirely of capital letters.")
							src.name = null
							continue

						if(filter_characters(src.name)!=src.name)
							src.skalert("\"[src.name]\" contains an invalid character.  Allowed characters are:\n[allowed_characters_name]")
							src.name = null
							continue
					else return
				else return

			src.Password=null
			while(src.Password==null)
				sleep(1)
				if(src)
					var/ZZ=src.skinput2("Please select a password for this account.","Password",0)
					if(src)
						src.Password = ZZ
						if(lentext(src.Password)<3)
							src.skalert("Password must have atleast 3 characters.")
							src.Password = null
							continue
					else return
				else return

			if(!istext(src.Password)) src.Password="[src.Password]"

			if(src)
				src.name = uppercase(src.name, 1)
				src.rname = src.name
				//M.gender=M.CustomInput("Gender Selection", "Please choose your gender.", list("Male", "Female"))
				var/obj/Tone=src.CustomInput("Skintone Selection", "Please choose your skin tone.", list("White", "Black"))
				src.SkinTone=Tone.name
				if(src.SkinTone=="White")
					src.icon='WhiteMaleBase.dmi'
					src.icon_state=""
					src.ricon=src.icon
					src.riconstate = src.icon_state
				else if(src.SkinTone=="Black")
					src.icon='BlackMaleBase.dmi'
					src.icon_state=""
					src.ricon=src.icon
					src.riconstate = src.icon_state
				//M.HairStyle='Long.dmi'
				var/obj/Hair
				Hair = src.CustomInput("Hair Options","Please choose a hair.",list("Long","Short","Tied Back","Bald","Bowl Cut"))
				if(src)
					if(Hair)
						switch(Hair.name)
							if("Long") src.HairStyle='Long.dmi'
							if("Short") src.HairStyle='Short.dmi'
							if("Tied Back") src.HairStyle='Short2.dmi'
							if("Bald") src.HairStyle=null
							if("Bowl Cut") src.HairStyle='Short3.dmi'
			if(src)
				var/list/Colors=src.ColorInput("Please select a hair color.")
				if(src)
					src.HairColorRed=text2num(Colors[1])
					src.HairColorGreen=text2num(Colors[2])
					src.HairColorBlue=text2num(Colors[3])
			if(src)
				if(src) src.Element=src.CustomInput("Element Options","Please choose your primary elemental affinity.",list("Fire","Water","Wind","Earth","Lightning"))
				if(src&&src.Element)src.Element=src.Element:name
			if(src)
				src.Specialist=src.CustomInput("Specialist Options","What area of skills would you like to specialize in?.",list("Taijutsu","Ninjutsu","Genjutsu","Balanced"))
				if(src&&src.Specialist)src.Specialist=src.Specialist:name
			if(src)
				if(src) src.Clan=src.CustomInput("Clan Options","What clan would you like to be born in?.",list("Aburame","Uchiha","Hyuuga","Nara","Kaguya","No Clan"))
				if(src&&src.Clan)
					src.Clan=src.Clan:name
					if(src.Clan=="No Clan")
						if(src)
							var/list/Specialties=list("Taijutsu","Ninjutsu","Genjutsu","Balanced")
							var/obj/K=src.CustomInput("Specialist Options","Since you are a non-clan, you get to pick a second specialty. Please choose another.",Specialties-src.Specialist)
							if(src)if(K)src.Specialist2=K.name
					if(src)
						var/obj/K=src.CustomInput("Village Options","What village would you like to be born in?",list("Hidden Leaf","Hidden Sand"))
						if(src)if(K)src.village=K.name
			if(src)
				switch(src.Specialist2)
					if("Taijutsu")
						src.taijutsu+=6
						src.maxtaiexp+=5
					if("Ninjutsu")
						src.ninjutsu+=6
						src.maxninexp+=5
					if("Genjutsu")
						src.genjutsu+=6
						src.maxgenexp+=5
					if("Balanced")
						src.taijutsu+=2
						src.genjutsu+=2
						src.ninjutsu+=2
						src.maxtaiexp+=2
						src.maxninexp+=2
						src.maxgenexp+=2
				switch(src.Specialist)
					if("Taijutsu")
						src.taijutsu+=6
						src.maxtaiexp+=6
					if("Ninjutsu")
						src.ninjutsu+=6
						src.maxninexp+=6
					if("Genjutsu")
						src.genjutsu+=6
						src.maxgenexp+=6
					if("Balanced")
						src.taijutsu+=2
						src.genjutsu+=2
						src.ninjutsu+=2
						src.maxtaiexp+=2
						src.maxninexp+=2
						src.maxgenexp+=2
				for(var/SJ in typesof(/obj/Jutsus))
					var/obj/SJT = new SJ
					if(SJT.starterjutsu==1)
						src.JutsusLearnt.Add(SJT)
						src.JutsusLearnt.Add(SJT.type)
						src.sbought+=SJT.name
						SJT.owner=src.ckey
				src.skillpoints=1
				src.RestoreOverlays()
				for(var/obj/Titlescreen/Logo/L in src.client.screen)del(L)

				if(!src)return
				src.loc=locate(39,158,1)//M.MapLoadSpawn()
				src << output("Welcome to the game. This is currently a server for heavy testing. Please read the controls below.<br><br>A: Attack<br>S: Use weapon<br>D: Block/Special<br>1,2,3,4,5,Q,W,E: Handseals<br>Space: Execute handseals<br>Arrows: Move<br>F1 - F5: Hotslots<br>R: Recharge chakra<br>Tab: Target<br>Shift+Tab: Untarget<br>Type /help to view commands that can be spoken verbally. Enter key to talk.","actionoutput")
				winset(src, null, "mainwindow.is-maximized=true;")
				new/obj/Screen/Bar(src)
				if(src.village == "Hidden Leaf")new/obj/Screen/LeafSymbol(src)
				if(src.village == "Hidden Sand")new/obj/Screen/SandSymbol(src)
				new/obj/Screen/WeaponSelect(src)
				new/obj/Screen/Health(src)
				new/obj/Screen/Chakra(src)
				new/obj/Screen/EXP(src)
				new/obj/HotSlots/HotSlot1(src)
				new/obj/HotSlots/HotSlot2(src)
				new/obj/HotSlots/HotSlot3(src)
				new/obj/HotSlots/HotSlot4(src)
				new/obj/HotSlots/HotSlot5(src)
				var/obj/O=new /obj/Screen/healthbar/
				var/obj/Mana=new /obj/Screen/manabar/
				src.hbar.Add(O)
				src.hbar.Add(Mana)
				for(var/obj/Screen/healthbar/HB in src.hbar)src.overlays+=HB
				for(var/obj/Screen/manabar/HB in src.hbar)src.overlays+=HB
				src.UpdateBars()
				spawn(1)if(src)src.Run()
				//spawn(1)src.lifecycle()
				if(src)
					src.UpdateHMB()
					src.Name(src.name)
					src.pixel_x=-16
					src.RestoreOverlays()
				spawn()if(src)src.WeaponryDelete()
				if(src)src.StaffCheck()
				//M.px = 32 * M.x
				//M.py = 32 * M.y
				spawn()if(src)src.MedalCheck()
				world<<"[src.rname] has logged in for the first time."
				//M.client.eye=locate(143,38,14)
				src.name="[name]CLIENT"
				src.creating=0
				winset(src, null, {"
								SkillBar.is-visible      = "true";
								ChatOut.is-visible      = "true";
								ActionOutputChild.is-visible      = "true";
								MainWindow.Maplink.right=mapwindow;
							"})
				src<<"Now speaking in: [src.Channel]."
				src.cansave=1
				spawn() src.ASave()


mob/var/tmp/Prisoner
mob/var/tmp/creating
mob
	//pwidth = 64
	//pheight = 30
	Logout()
		if(creating) del(src)
		for(var/obj/O in world)if(O.IsJutsuEffect==src) del(O)
		for(var/mob/M in src.puppets)del(M)
		if(src in global.genintesters)
			global.genintesters-=src
			src.loc = locate(11,69,2)
		if(Chuunins.Find(src))
			Chuunins-=src
			src.loc=MapLoadSpawn()
		if(village!="Akatsuki")
			for(var/obj/Inventory/Clothing/Shirt/Akatsuki_Robe/O in src)
				if(ClothingOverlays[O.section]==O.icon)RemoveSection(O.section)
				del(O)
		if(rank!="ANBU")
			for(var/obj/Inventory/Clothing/Masks/Anbu/O in src)
				if(ClothingOverlays[O.section]==O.icon)RemoveSection(O.section)
				del(O)
		if(loc in block(locate(71,95,4),locate(200,163,4))) // If they are in FoD
			loc=MapLoadSpawn() // Remember to change depending on villages!
			for(var/obj/ChuuninExam/Scrolls/S in src)del(S)
		if(loc in block(locate(113,29,4),locate(146,58,2)))loc=MapLoadSpawn()
		if(NaraTarget)
			var/mob/M=NaraTarget
			M.move=1
			M.injutsu=0
			M.canattack=1
			NaraTarget=null
		if(Prisoner)
			var/mob/M=Prisoner
			M.client.eye=M
			M.client:perspective = EYE_PERSPECTIVE
			M.move=1
			M.canattack=1
			M.injutsu=0
			Prisoner=null
	//	if(src.key&&src.name)world<<"[src.name] has logged out!"
		if(Squad)
			if(Squad.Leader == ckey)del Squad
			else if(Squad.Members.Find(ckey))
				for(var/i in Squad.Members)
					var/mob/player/P = getOwner(i)
					P.Squad.Members -= ckey
				var/mob/player/P = getOwner(Squad.Leader)
				P.Squad.Members -= ckey
		for(var/mob/Clones/C in world)if(C.Owner==src)del(C)
		var/Faction/c=getFaction(src.Faction)
		if(c)
			c.onlinemembers -= usr
			c.members[rname] = list(key, level, Factionrank)
			usr.verbs -= Factionverbs
	//	for(var/obj/O in world) // RAGEEEE This kept me busy for a good hour and a half trying to figure out why Jutsus were being randomly
	//		if(O.owner == src) // Deleted! Whoever did this needs to be shot, lol.
	//			del(O)

		src.overlays-=src.overlays
		//image('Jutsus.dmi',"burning")
		//src.overlays-=image('Jutsus2.dmi',"Meat Tank")
		pixel_y = 0
		pixel_x = 0
		//var/list/possible_entries = typesof(/mob/Jutsus/verb)
		//var/list/current_verbs = src.verbs.Copy()
		//for(var/R in current_verbs) if(!(R in possible_entries)) current_verbs -= R
		src.Save()
		del(src)
		..()

mob/proc/ASave()
	while(src)
		Save()
		sleep(600*3)//Three minutes to save periodically!

mob/proc/Save()
	if(!src.cansave) return 0
	var/letter = copytext(src.key,1,2)
	if(fexists("Savefiles/Players/[letter]/[src.key].sav")) fdel("Savefiles/Players/[letter]/[src.key].sav")
	var/savefile/F = new("Savefiles/Players/[letter]/[src.key].sav")
	ASSERT(src && ismob(src))
	if(!F["ownerkey"]) F["ownerkey"]<<src.key
	F["x"] << src.x
	F["y"] << src.y
	F["z"] << src.z
	F["Clan"] << src.Clan
	F["Password"] << src.Password
	F["mob"] << src
	src<<output("Game saved successfully.","actionoutput")
	return 1

mob/proc/Load()
	var/letter = copytext(src.key,1,2)
	var/savefile/F = new("Savefiles/Players/[letter]/[src.key].sav")
	ASSERT(src && ismob(src))
	F["mob"] >> src

mob
	Read(savefile/F)
		..()
		src.name = src.rname
		src.icon = src.ricon
		src.icon_state = src.riconstate
		src.density=1
		src.sight=0
		src.invisibility=0
		if(src.dead)
			src.density=1
			src.health=src.maxhealth
			src.chakra=src.maxchakra
			src.injutsu=0
			src.dead=0
			src.canattack=1
			src.firing=0
			src.icon_state=""
			src.wait=0
			src.rest=0
			src.dodge=0
			src.move=1
			src.swimming=0
			src.overlays=0
		src.RestoreOverlays()
	//	world<<"[M.rname] has logged in."
		src << output("Welcome to the game. This is currently a server for heavy testing. Please read the controls below.<br><br>A: Attack<br>S: Use weapon<br>D: Block/Special<br>1,2,3,4,5,Q,W,E: Handseals<br>Space: Execute handseals<br>Arrows: Move<br>F1 - F5: Hotslots<br>R: Recharge chakra<br>Type /help to view commands that can be spoken verbally. Enter key to talk.","actionoutput")
		winset(src, null, "MainWindow.is-maximized=true;")
		new/obj/Screen/Bar(src)
		if(src.village=="Hidden Leaf")new/obj/Screen/LeafSymbol(src)
		if(src.village=="Hidden Sand")new/obj/Screen/SandSymbol(src)
		new/obj/Screen/WeaponSelect(src)
		new/obj/Screen/Health(src)
		new/obj/Screen/Chakra(src)
		new/obj/Screen/EXP(src)
		new/obj/HotSlots/HotSlot1(src)
		new/obj/HotSlots/HotSlot2(src)
		new/obj/HotSlots/HotSlot3(src)
		new/obj/HotSlots/HotSlot4(src)
		new/obj/HotSlots/HotSlot5(src)
		var/obj/O=new /obj/Screen/healthbar/
		var/obj/Mana=new /obj/Screen/manabar/
		src.hbar.Add(O)
		src.hbar.Add(Mana)
		for(var/obj/Screen/healthbar/HB in src.hbar)src.overlays+=HB
		for(var/obj/Screen/manabar/HB in src.hbar)src.overlays+=HB
		for(var/i in src.JutsusLearnt)if(isnull(i))del(i)
		var/Faction/c = getFaction(src.Faction)
		if(c)
			if(src.Faction == c.name)
				src.verbs += src.Factionverbs
				c.onlinemembers.Add(src)
				c.members[src.rname] = list(src.key, src.level, src.Factionrank)
				if(c.FMOTD) src<<output("Faction MOTD: <br>[c.FMOTD]</br>","actionoutput")
				src.verbs += /Faction/Generic/verb/FactionLeave
		if(src.Faction&&!getFaction(src.Faction))
			src<<"Your Faction no longer exists. You have been removed from [src.Faction]"
			src.Faction=null
			src.Factionrank=null
			src.verbs-=src.Factionverbs
			src.Factionverbs=list()
		src.UpdateBars()
		spawn(1)src.Run()
		//spawn(1)src.lifecycle()
		src.UpdateHMB()
		src.pixel_x=-16
		src.Name(src.name)
		src.RestoreOverlays()
		src.StaffCheck()
		src.UpdateSlots()
		spawn() src.WeaponryDelete()
		spawn() src.MedalCheck()
		if(!src.name) src.name=src.key
		F["Clan"] >> src.Clan
		src.loc=locate(F["x"], F["y"], F["z"])
		if(!src.loc)
			if(src.Tutorial==6) src.loc=src.MapLoadSpawn()
			else src.loc=locate(39,158,1)
			//else M.loc=M.MapLoadSpawn()
		src<<output("Game loaded successfully.","actionoutput")
		src<<"Now speaking in: [src.Channel]."
		spawn() if(src) src.ASave()
		src.cansave=1

mob
	var/tmp
		Channel="Say"
	verb
		WorldAddy()
			set hidden=1
			usr << output("<FONT FACE= Times New Roman>byond://[world.internet_address]:[world.port]", "actionoutput")
	verb
		ResizeWin()
			GetScreenResolution(src)


		CloseBrowser()
			set hidden=1
			winset(src, null, {"
						mainwindow.BrowserChild.is-visible = "false";
					"})
		MiniWindow()
			set hidden=1
			winset(usr, "mainwindow", "is-minimized=true")
		ChangeChannel()
			set hidden=1
			if(Channel=="Say")
				Channel="Whisper"
				src<<"Now speaking in: [Channel]. Type a name in dashes, and then your message.."
				src<<"Example: -Username- Message"
				return
		//	if(Channel=="Whisper") // World
		//		Channel="Village"
		//		src<<"Now speaking in: [Channel]"
		//		return
			if(Squad && Channel=="Village") // Squad  Squad AND Channel is Village
				Channel="Squad"
				src<<"Now speaking in: [Channel]"
				return
			if(Channel=="Village" || Channel=="Squad") // Say -- Village or Squad
				Channel="Say"
				src<<"Now speaking in: [Channel]"
				return
			if(Faction && getFaction(src.Faction))
				if(Channel=="Whisper") // Village
					Channel="Faction"
					src<<"Now speaking in: [Channel]"
					return
			if(village)
				if(Channel=="Whisper" || Channel=="Faction") // Village Village AND Channel is World
					Channel="Village"
					src<<"Now speaking in: [Channel]"
					return
mob
	var/SayUp
	see_in_dark=3
	New()
		..()
		if(!src.client) src.beAI()
	verb
		Winsay()
			set hidden=1
			if(Muted)
				src<<"You're muted!"
				return

			if(src.SayUp)
				src.SayUp=0
				winset(src, null, {"
					MainWindow.SayBoxChild.focus      = "false";
					MainWindow.SayBoxChild.is-visible      = "false";
					MainWindow.MainWindow.Maplink.focus      = "true";
					"})


			else
				winset(src, null, {"
						MainWindow.SayBoxChild.focus      = "true";
						MainWindow.SayBoxChild.is-visible      = "true";
					"})
				src.SayUp=1
	verb
		ChatBox()
			set hidden=1
			if(src.chatbox)
				src.chatbox=0
				winset(usr, null, {"
					ChatOut.focus      = "false";
					ChatOut.is-visible      = "false";
				"})
			else
				if(!src.chatbox)
					src.chatbox=1
					winset(usr, null, {"
						ChatOut.focus      = "true";
						ChatOut.is-visible      = "true";
					"})
mob
	var
		tmp
			statbox=0
			jutsutab=0
	verb
		ViewJutsuTab()
			set hidden=1
			if(jutsutab)
				jutsutab=0
				winset(usr, null, {"
				JutsuTabChild.focus      = "false";
				JutsuTabChild.is-visible      = "false";
				"})
				return
			RefreshJutsus()
			winset(usr, null, {"
				JutsuTabChild.focus      = "true";
				JutsuTabChild.is-visible      = "true";
			"})
			jutsutab=1
		RefreshJutsus()
			set hidden=1
			winset(src,"JutsuTab.Grid","cells=0x0")
			var/Row = 1
			src<<output("","Grid:1,1")
			for(var/obj/Jutsus/O in src.JutsusLearnt)
				Row++
				src << output(O,"Grid:1,[Row]")
		Stats()
			set hidden=1
			if(src.statbox==1)
				src.statbox=0
				winset(src, null, {"
					Stats.focus      = "false";
					Stats.is-visible      = "false";
				"})
			else
				if(src.statbox==0)
					src.statbox=1
					winset(src, null, {"
						Stats.focus      = "true";
						Stats.is-visible      = "true";
						Status.Name.text      = "[src.name]";
						Status.Level.text      = "[src.level]";
						Status.EXP.text      = "[src.exp]/[src.maxexp]";
						Status.Tai.text      = "[src.taijutsu]([src.taiexp]/[src.maxtaiexp])";
						Status.Nin.text      = "[src.ninjutsu]([src.ninexp]/[src.maxninexp])";
						Status.Gen.text      = "[src.genjutsu]([src.genexp]/[src.maxgenexp])";
						Status.Def.text      = "[src.defence]([src.defexp]/[src.maxdefexp])";
						Status.Agi.text      = "[src.agility]([src.agilityexp]/[src.maxagilityexp])";
						Status.Health.text      = "([src.health]/[src.maxhealth])";
						Status.Chakra.text      = "([src.chakra]/[src.maxchakra])";
						Status.statpoints.text      = "[src.statpoints] -- [src.skillpoints]";
					"})


		RefreshStats()
			set hidden=1
			winset(src, null, {"
						Stats.focus      = "true";
						Stats.is-visible      = "true";
						Status.Name.text      = "[src.name]";
						Status.Level.text      = "[src.level]";
						Status.EXP.text      = "[src.exp]/[src.maxexp]";
						Status.Tai.text      = "[src.taijutsu]([src.taiexp]/[src.maxtaiexp])";
						Status.Nin.text      = "[src.ninjutsu]([src.ninexp]/[src.maxninexp])";
						Status.Gen.text      = "[src.genjutsu]([src.genexp]/[src.maxgenexp])";
						Status.Def.text      = "[src.defence]([src.defexp]/[src.maxdefexp])";
						Status.Agi.text      = "[src.agility]([src.agilityexp]/[src.maxagilityexp])";
						Status.Health.text      = "([src.health]/[src.maxhealth])";
						Status.Chakra.text      = "([src.chakra]/[src.maxchakra])";
						Status.statpoints.text      = "[src.statpoints] -- [src.skillpoints]";
					"})


		StrengthUp()
			set hidden=1
			if(statpoints<1)
				src<<output("<font color=red>Insufficent statpoints.</Font>","actionoutput")
				return
			statpoints--
			taijutsu++
			src<<output("<font color=yellow>You leveled up Strength!</Font>","actionoutput")
			RefreshStats()
		DefenceUp()
			set hidden=1
			if(statpoints<1)
				src<<output("<font color=red>Insufficent statpoints.</Font>","actionoutput")
				return
			statpoints--
			defence++
			src<<output("<font color=yellow>You leveled up Defence!</Font>","actionoutput")
			RefreshStats()
		AgilityUp()
			set hidden=1
			if(statpoints<1)
				src<<output("<font color=red>Insufficent statpoints.</Font>","actionoutput")
				return
			statpoints--
			agility++
			src<<output("<font color=yellow>You leveled up Agility!</Font>","actionoutput")
			RefreshStats()
		HealthUp()
			set hidden=1
			if(statpoints<1)
				src<<output("<font color=red>Insufficent statpoints.</Font>","actionoutput")
				return
			statpoints--
			maxhealth+=25
			src<<output("<font color=yellow>You leveled up Health!</Font>","actionoutput")
			RefreshStats()
		ChakraUp()
			set hidden=1
			if(statpoints<1)
				src<<output("<font color=red>Insufficent statpoints.</Font>","actionoutput")
				return
			statpoints--
			maxchakra+=20
			src<<output("<font color=yellow>You leveled up Chakra!</Font>","actionoutput")
			RefreshStats()
mob
	var
		InventoryUp = 0//Variable telling whether your OSI is up, or not
		//AdminUp=0
		KageUp=0
		OptionsUp=0
	verb
		LeaveVillage()
			set hidden=1
			if(village=="Missing-Nin") return
			if(rank=="Missing-Nin") return
			if(skalert("Are you sure you want to leave your village?","Confirmation",list("Yes","No"))=="Yes")
				world<<output("[src.name] has defected from the [src.village] village.","actionoutput")
				if(village=="Akatsuki")
					for(var/obj/Inventory/Clothing/Shirt/Akatsuki_Robe/O in src)
						if(ClothingOverlays[O.section]==O.icon)RemoveSection(O.section)
						del(O)
					src.overlays=null
					src.ReAddClothing()
					src.RestoreOverlays()
					src.RemoveAdminVerbs()
				village="Missing-Nin"
				rank="Missing-Nin"
		OptionsPanel()
			set hidden=1
			if(usr.dead==0)
				if(usr.OptionsUp == 0)
					usr.OptionsUp = 1
					//src.UpdateInventory()
					if(getFaction(src.Faction))
						winset(src, null, {"
						Options.FactionTab.is-visible = "true";
					"})
					if(Squad) if(Squad.Leader == ckey) if(Squad.Members.len>=4)
						winset(src, null, {"
						Options.FactionTab.is-visible = "true";
					"})
					winset(src, null, {"
						mainwindow.OptionsChild.is-visible = "true";
					"})
				else
					usr.OptionsUp = 0
					//src.UpdateInventory()
					winset(src, null, {"
						mainwindow.OptionsChild.is-visible = "false";
					"})
					winset(src, null, {"
						Options.FactionTab.is-visible = "false";
					"})
		KagePanel()
			set hidden=1
			if(usr.dead==0)
				if(usr.KageUp == 0)
					usr.KageUp = 1
					//src.UpdateInventory()
					winset(src, null, {"
						mainwindow.KageChild.is-visible = "true";
					"})
				else
					usr.KageUp = 0
					//src.UpdateInventory()
					winset(src, null, {"
						mainwindow.KageChild.is-visible = "false";
					"})
	//	AdminUp()
	//		set hidden=1
	//		if(usr.dead==0)
	//			if(usr.AdminUp == 0)
	//				usr.AdminUp = 1
	//				//src.UpdateInventory()
	//				winset(src, null, {"
	//					mainwindow.AdminChild.is-visible = "true";
	//				"})
	///			else
	//				usr.AdminUp = 0
	//				//src.UpdateInventory()
	//				winset(src, null, {"
	//					mainwindow.AdminChild.is-visible = "false";
	//				"})
		RefreshInventory()
			set hidden=1
			if(!client) return
			winset(src,"Equip.Ryo","text=\"Ryo: [Ryo]\"")
			winset(src,"Equip.Items","text=\"Items: [items]/[maxitems]\"")
			winset(src,"Equip.GridEquip","cells=0x0")
			var/Row = 1
		//	src<<output("Ryo:","Equip.GridEquip:1,1")
		//	src<<output("Items:","Equip.GridEquip:1,2")
		//	src<<output("[src.items]/[src.maxitems]","Equip.GridEquip:2,2")
			src<<output(" ","Equip.GridEquip:1,1")
			for(var/obj/O in src.contents)
				Row++
				src << output(O,"Equip.GridEquip:1,[Row]")
				src << output("[O.suffix]","Equip.GridEquip:2,[Row]")
			sleep(40)
		Inventory()
			set hidden=1
			if(usr.dead==0)
				if(usr.InventoryUp == 0)
					usr.InventoryUp = 1
					//src.UpdateInventory()
					winset(src, null, {"
						mainwindow.InvenChild.is-visible = "true";
					"})
					winset(usr, "ItemName", "text=\"\"")
					winset(usr, "ItemPic", "image=\"\"")
					usr<<output("<center><font size = 2><font color=white><Body BGCOLOR = #2E2E2E>","ItemInfo")
					RefreshInventory()
				else
					if(usr.InventoryUp)
						winset(usr, "ItemName", "text=\"\"")
						winset(usr, "ItemPic", "image=\"\"")
						usr<<output("<center><font size = 2><font color=white><Body BGCOLOR = #2E2E2E>","ItemInfo")
						winset(src, null, {"
							mainwindow.InvenChild.is-visible = "false";
						"})
						usr.InventoryUp = 0
mob/var/tmp/checkcuss
proc
	symbol(length as num)
		var/T
		for(var/i = 0,i < length,i++)
			T += "*"
			//T += pick("!","@","#","$","%","^","&","*")
		return T
mob
	proc
		filter(msg as text)
			var/txt = lowertext(msg)
			var/a
			var/out
			for(var/cuss in Badwords)
				if(findtext(txt,"[cuss]"))
					for(var/i = 1, i <= length(txt))
						a = copytext(msg, i , i+length(cuss))
						if(lowertext(a) == "[cuss]")
							a = symbol(length(cuss))
							i+= length(cuss)
							out += "[a]"
							usr.checkcuss = 1
						else
							out += copytext(msg, i, i+1)
							i ++
					msg = out
					txt = lowertext(msg)
					out = ""
			return msg
proc
	Filter(msg as text)
		var/txt = lowertext(msg)
		var/a
		var/out
		for(var/cuss in Badwords)
			if(findtext(txt,"[cuss]"))
				for(var/i = 1, i <= length(txt))
					a = copytext(msg, i , i+length(cuss))
					if(lowertext(a) == "[cuss]")
						a = symbol(length(cuss))
						i+= length(cuss)
						out += "[a]"
					else
						out += copytext(msg, i, i+1)
						i ++
				msg = out
				txt = lowertext(msg)
				out = ""
		return msg
mob
	verb
		say(msg as text)
			set hidden=1
			var/lengtext = lentext(msg)
			SayUp=0
			winset(src, null, {"
				SayBoxChild.focus      = "false";
				SayBoxChild.is-visible      = "false";
			"})
			winset(src, null, {"
				MainWindow.Maplink.focus      = "true";
			"})
			if(Muted) return
			if(lengtext>300) return
			if(lengtext > 10 && !usr.admin)
				var/caps = 0
				for(var/i=1 to lengtext)
					var/l = text2ascii(msg,i)
					if(l > 64 && l < 93) caps ++
					if(l==32||l==255) lengtext --
				var/percent = 20
				switch(lengtext)
					if(0 to 3)percent = 100
					if(4 to 7)percent = 80
					if(8 to 11)percent = 60
					if(12 to 15)percent = 30
				if((100 * (caps / lengtext)) > percent)msg = lowertext(msg)
			if(findtext(msg,lowertext("/World"))==1)
				usr.WorldAddy()
				return
		//	if(findtext(msg,"/NameColor")==1)
		//		usr.ChangeNameColor()
		//		return
		//	if(findtext(msg,"/ChatColor")==1)
		//		usr.ChangeTextColor()
		//		return
			if(findtext(msg,lowertext("/Help"))==1)
				usr.Help()
				return
			if(findtext(msg,lowertext("/Where"))==1)
				usr.Help()
				return
			if(findtext(msg,lowertext("/Stuck"))==1)
				usr.Stuck()
				return
			if(!usr.likeaclone)
				if(msg)
					if(Channel=="Say")
						if(usr.admin) view(usr)<<"<b><font color=[usr.namecolor]>([usr.name]): </Font><font color=[usr.chatcolor]>[html_encode(msg)]</Font>"
						else view(usr)<<filter("<font color=[usr.namecolor]>([usr.name]): </Font><font color=[usr.chatcolor]>[html_encode(msg)]</Font>")
					if(Channel=="World")
						if(usr.admin) world<<"<b><font color=red>World-</font><font color=[usr.namecolor]>([usr.name]): </Font><font color=[usr.chatcolor]>[html_encode(msg)]</Font>"
						else world<<filter("<font color=red>World-</font><font color=[usr.namecolor]>([usr.name]): </Font><font color=[usr.chatcolor]>[html_encode(msg)]</Font>")
					if(Channel=="Squad")
						if(!Squad) return
						for(var/i in Squad.Members)
							var/mob/M=getOwner(i)
							if(!M) continue
							if(usr.admin) M<<"<b><font color=white>Radio-</font><font color=[usr.namecolor]>([usr.name]): </Font><font color=[usr.chatcolor]>[html_encode(msg)]</Font>"
							else M<<filter("<font color=white>Radio-</font><font color=[usr.namecolor]>([usr.name]): </Font><font color=[usr.chatcolor]>[html_encode(msg)]</Font>")
						var/mob/player/Leader=getOwner(Squad.Leader)
						if(usr.admin) Leader<<"<b><font color=white>Radio-</font><font color=[usr.namecolor]>([usr.name]): </Font><font color=[usr.chatcolor]>[html_encode(msg)]</Font>"
						else Leader<<filter("<font color=white>Radio-</font><font color=[usr.namecolor]>([usr.name]): </Font><font color=[usr.chatcolor]>[html_encode(msg)]</Font>")
					if(Channel=="Village")
						for(var/mob/player/M in world) if(M.village==src.village || MasterKeyCheck(M.key))
							if(MasterKeyCheck(src.key)) M<<"<b><font color=yellow>[src.village]-[src.rank]-</font><font color=[usr.namecolor]>([usr.name]): </Font><font color=[usr.chatcolor]>[html_encode(msg)]</Font>"
							else M<<filter("<font color=yellow>[src.village]-[src.rank]-</font><font color=[usr.namecolor]>([usr.name]): </Font><font color=[usr.chatcolor]>[html_encode(msg)]</Font>")
					if(Channel=="Faction")
						var/Faction/faction=getFaction(src.Faction)
						if(!faction) return
						for(var/mob/player/p in world)
							var/t
							if(getFaction(p.Faction) == getFaction(src.Faction)) t=1
							if(p.admin || t)
								p << filter("<font color = [faction.color]><b>[faction.name]-</b></font><font color=[usr.namecolor]>([usr.name]):</Font><font color=[usr.chatcolor]> [html_encode(msg)]</font>")
					if(Channel=="Whisper")
						var/Quotation=findtext(msg,"-",2)
						if(!Quotation) return
						var/Person=copytext(msg,2,Quotation)
						var/Message=copytext(msg,Quotation)
						var/mob/t
						for(var/mob/player/M in world)if(Person==M.name)t=M
						if(t)
							src<<"<b><u>You whisper:</u></b> [Message]"
							t<<"<b><u>[src] whispers:</u></b> [Message]"
						else
							src<<"Unable to find: [Person]"
							return
			else
				if(msg&&Channel=="Say")
					var/mob/SC = usr.likeaclone
					if(usr.admin) view(SC)<<"<b><font color=[usr.namecolor]>([usr.name]): </Font><font color=[usr.chatcolor]>[html_encode(msg)]</Font>"
					else view(SC)<<filter("<font color=[usr.namecolor]>([usr.name]): </Font><font color=[usr.chatcolor]>[html_encode(msg)]</Font>")
mob
	proc
		Help()
			src<<"/Stuck -- Will teleport you out of the area after 20 seconds."
			src<<"/World -- Shows the current servers IP address."
			src<<"/Mute -- Vote to mute a player."
			src<<"/Boot -- Vote to boot a player."
			src<<"/Help -- View all commands."
	//	ChangeNameColor()
	//		namecolor = input("What color will your name be?") as null|color
	//	ChangeTextColor()
	//		chatcolor=input("What color will your chat text be?") as null|color
		Stuck()
			if(Tutorial!=6)
				src<<"You're in the tutorial. Please finish it before using this."
				return
			src<<"You are about to be teleported out of the area. Please do not move or touch any buttons for 20 seconds"
			sleep(200)
			if(src.client.inactivity >= 200)
				src.loc = MapLoadSpawn()
				src.move=1
				src.injutsu=0
				src.canattack=1
				src.firing=0
			else src<<"Results show that you have moved or touched a button within the last 20 seconds."