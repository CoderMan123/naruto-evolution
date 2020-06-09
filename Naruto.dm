#define WORLD_SAVE "World.sav"

var/list/Badwords = list("byond://","www.","http://","\n")
var/const/allowed_characters_name = "abcdefghijklmnopqrstuvwxyz' "// removed >> and . from name creation because it can fuck our verbs. specifically edit, checkstats, boot, ban, etc.
var/list/TotalPlayers = list()
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
	return fexists("Players/[letter]/[ckey].sav")
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
	name = "Naruto Evolution: The New Era"
	hub= "Squigs.NETheNewEra"
	hub_password = "Ue7DTLSxJx1vnALy"
	status="<font face= Times New Roman>Loading Configuration..."

	mob = /mob/Login
	view = 16
	loop_checks=1
	proc/PlayerCount()
		set background=1
		while(world)
			sleep(600)//One minute each to check! Not .2 seconds=EPIC LAG!
			var/number=0
			for(var/mob/player/M in TotalPlayers)if(M.key)number++
			Players=number
			if(Players>=MaxPlayers)full=1
			else full=0
			status="<font face= Times New Roman>NE: The New Era ([Players]/[MaxPlayers]) Server: [global.servertype]"

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
//	return pick(MapLoadSpawn)
world
	New()
		log = file("Errorlog.txt")
//		spawn(10) RepopWorld()
		spawn(10) GeninExam()
		spawn(10) ChuuninExam()
		spawn(10) Advert()
		spawn(10) RepopWorld()
		spawn(10) AutoCheck()
		spawn(5) LinkWarps()
		//spawn() AutoReboot()
		spawn(5)  PlayerCount()
		spawn(5)  HTMLlist()
		spawn(5) CheckHost()
		if(!fexists(WORLD_SAVE)) return
		var/savefile/F = new(WORLD_SAVE)
		if(!isnull(F["Factions"])) F["Factions"] >> Factionnames
		if(!isnull(F["Maps"])) F["Maps"] >> maps
		if(!isnull(F["Admins"])) F["Admins"] >> Admins
		if(!isnull(F["MasterGMs"])) F["MasterGMs"] >> MasterGMs
		if(!isnull(F["Moderators"])) F["Moderators"] >> Moderators
		if(!isnull(F["PArtists"])) F["PArtists"] >> PArtists
		if(!isnull(F["AkatInvites"])) F["AkatInvites"] >> AkatInvites
		if(!isnull(F["WorldXp"])) F["WorldXp"] >> WorldXp
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
		F["Admins"] << Admins
		F["MasterGMs"] << MasterGMs
		F["Moderators"] << Moderators
		F["PArtists"] << PArtists
		F["AkatInvites"] << AkatInvites
		F["WorldXp"] << WorldXp
		..()

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

mob/Login
	verb/Logins()
		set hidden=1
		for(var/client/A in world)
			if(src.client.computer_id == A.computer_id)
				src<<"Multi keying is fixed."
				src.Logout()
		var/LoginID=winget(src,"titlescreen.Username","text")
		var/LoginPW=winget(src,"titlescreen.Password","text")
		LoginID=lowertext(LoginID)
		var/letter = copytext(LoginID,1,2)
		if(!key)
			client.Command(".reconnect")
		for(var/mob/M in TotalPlayers)
			if(lowertext(M.name) == lowertext(LoginID))
				skalert("The account \"[LoginID]\" is already logged in.", "Login Error")
				return
		if(hasSavefile(LoginID))
			var/savefile/F = new("Players/[lowertext(letter)]/[lowertext(LoginID)].sav")
			var/reason
			if(!LoginID || !LoginPW)
				reason = "Please enter both an account ID and password."
			else
				if(md5("[LoginPW][LoginPW][LoginPW][LoginPW][LoginPW]") != F["Password"])
					reason = "The password you have entered is incorrect."
			if(reason)
				del F
				skalert("[reason]", "Login Error")
				return
			LoadCharacter(LoginID, F)
		else
			src.skalert("The account \"[LoginID]\" does not exist.","Login Error")
			return

	Login()
		..()
		spawn()
			GetScreenResolution(src)
		var/mob/EYEBALL=new()
		EYEBALL.name="EYE"
		EYEBALL.loc=locate(101,100,7)
		EYEBALL.density=0
		//src.skalert("When you create your account, you won't be automatically teleported to the spawn. Please relog and log in to be teleported to the tutorial. This is to prevent spam.")
		EYEBALL.invisibility=1
		EYEBALL.byakuview = 0
		EYEBALL.canteleport = 0
		src.client.eye=EYEBALL
		src.client:perspective = EYE_PERSPECTIVE
		spawn()
			var/obj/Titlescreen/Logo/L=new(src)
			while(istype(src,/mob/Login))
				step_rand(EYEBALL)
				sleep(10)
			del(EYEBALL)
			del(L)
	//	src<<sound('preview.ogg')
		if(prob(50))
			winset(src, null, {"
					titlescreen.Shikamaru.is-visible="false"
						"})
		winset(src, null, {"
							Maplink.right=titlescreen;
							mainwindow.is-maximized=true
							mainwindow.UnlockChild.is-visible = "false";
							mainwindow.InvenChild.is-visible = "false";
							Stats.is-visible      = "false";
							SkillBar.is-visible      = "false";
							ChatOut.is-visible      = "false";
							target.is-visible = "false";
							ActionOutputChild.is-visible      = "false";
						"})
		winset(src, null, {"
							TitleChild.right=mapwindow;
						"})
		src.AddAdminVerbs()
		var/Ticked=0
		var/mob/t1
		var/mob/t2
		spawn()
			for(var/mob/player/M in world)
				if(!M.client) continue
				if(!src.client) continue
				if(M==src||M.client==client) continue
				if(M.client.address==src.client.address&&src.client.computer_id==M.client.computer_id)Ticked=1
			if(Ticked)
				world<<"[t1] and [t2] are the same person. We do not allow multikeys."
				text2file("usr: [usr], ckey: [ckey], t1.name: [t1.name], t2.ckey: [t2.ckey] Tried to multikey.(I don't know which of these might work: [time2text(world.timeofday, "MMM DD hh:mm:ss")]<br>","GMLog.txt")
				sleep(10)
				del(src)

	proc/LoadCharacter(var/LoginID,var/savefile/F)
		ASSERT(hasSavefile(LoginID) && src.client)
		src.loc=locate(1,200,19)
		winset(src, null, {"
							Maplink.right=mapwindow;
						"})
		for(var/obj/Titlescreen/Logo/L in src.client.screen)del(L)
		LoginID=lowertext(LoginID)

		var/mob/player/M = new
		F >> M

		//spawn()
		M.client = src.client
		GetScreenResolution(M)
		M.verbs.Add(typesof(/mob/verb))
		M.name = M.rname
		M.icon = M.ricon
		M.icon_state = M.riconstate
		M.ResetBase()//HERE what's ricon and rname
		M.density=1
		M.sight=0
		M.invisibility=0
		M.Move(locate(F["x"], F["y"], F["z"]))
		if(!M.loc)
			if(M.Tutorial==7) M.loc=M.MapLoadSpawn()
			else M.loc=locate(39,158,14)
		if(M.dead)
			M.density=1
			M.health=M.maxhealth
			M.chakra=M.maxchakra
			M.injutsu=0
			M.dead=0
			M.canattack=1
			M.firing=0
			M.icon_state=""
			M.wait=0
			M.rest=0
			M.dodge=0
			M.move=1
			M.swimming=0
			M.walkingonwater=0
			M.overlays=0
		M.client.eye=M
		M.client:perspective = EYE_PERSPECTIVE
		M.namecolor="green"
		M.chatcolor="white"
		M.RestoreOverlays()
		world<<"[M.rname] has logged in."
		M << output("Welcome to the game. Please read the controls below.<br><br>A: Attack<br>S: Use weapon<br>D: Block/Special<br>1,2,3,4,5,Q,W,E: Handseals<br>Space: Execute handseals<br>Arrows: Move<br>F1 - F10: Hotslots<br>R: Recharge chakra<br>I: Inventory<br>O: Statpanel<br>P: Jutsus<br>Type /help to view commands that can be spoken verbally. Enter key to talk.","actionoutput")
		M << "Welcome [M.rname]. If you're new please read the rules. You can find them in the Options panel. If you need to contact someone, there is a link to our discord on the HUB. Check the Action output to the right for controls."
		if(!M.key)
			M.Logout()

		winset(M, "mainwindow", "is-maximized=true")
		new/obj/Screen/Bar(M)
		if(M.village == "Hidden Leaf")new/obj/Screen/LeafSymbol(M)
		if(M.village == "Hidden Sand")new/obj/Screen/SandSymbol(M)
		if(M.village == "Hidden Mist")new/obj/Screen/MistSymbol(M)
		if(M.village == "Hidden Sound")new/obj/Screen/SoundSymbol(M)
		if(M.village == "Hidden Rock")new/obj/Screen/RockSymbol(M)
		if(M.village == "Akatsuki")new/obj/Screen/AkatsukiSymbol(M)
		if(M.village == "Seven Swordsmen")new/obj/Screen/SsmSymbol(M)
		if(M.village == "Anbu Root")new/obj/Screen/AnbuSymbol(M)
		new/obj/Screen/WeaponSelect(M)
		new/obj/Screen/Health(M)
		new/obj/Screen/Chakra(M)
		new/obj/Screen/EXP(M)
		new/obj/HotSlots/HotSlot1(M)
		new/obj/HotSlots/HotSlot2(M)
		new/obj/HotSlots/HotSlot3(M)
		new/obj/HotSlots/HotSlot4(M)
		new/obj/HotSlots/HotSlot5(M)
		new/obj/HotSlots/HotSlot6(M)
		new/obj/HotSlots/HotSlot7(M)
		new/obj/HotSlots/HotSlot8(M)
		new/obj/HotSlots/HotSlot9(M)
		new/obj/HotSlots/HotSlot10(M)
		var/obj/O=new /obj/Screen/healthbar/
		var/obj/Mana=new /obj/Screen/manabar/
		M.hbar.Add(O)
		M.hbar.Add(Mana)
		for(var/obj/Screen/healthbar/HB in M.hbar)M.overlays+=HB
		for(var/obj/Screen/manabar/HB in M.hbar)M.overlays+=HB
		for(var/i in M.JutsusLearnt)if(isnull(i))del(i)
		var/Faction/c = getFaction(M.Faction)
		if(c)
			if(M.Faction == c.name)
				M.verbs += M.Factionverbs
				c.onlinemembers.Add(M)
				c.members[M.rname] = list(M.key, M.level, M.Factionrank)
				if(c.FMOTD) M<<output("Faction MOTD: <br>[c.FMOTD]</br>","actionoutput")
				M.verbs += /Faction/Generic/verb/FactionLeave
		if(M.Faction&&!getFaction(M.Faction))
			M<<"Your Faction no longer exists. [M.Faction] has disbanded."
			M.Faction=null
			M.Factionrank=null
			M.verbs-=M.Factionverbs
			M.Factionverbs=list()
		M.UpdateBars()
		spawn(1)M.Run()
		//spawn(1)M.lifecycle()
		spawn()
			M.UpdateHMB()
		M.pixel_x=-16
		M.Name(M.name)
		for(var/obj/Inventory/Clothing/C in M.contents)
			if(C.suffix == "(Equipped)")
				M.ClothingOverlays["[C.section]"] = C.icon
		M.RestoreOverlays()
		M.AddAdminVerbs()
		TotalPlayers.Add(M)
		M.UpdateSlots()
		spawn() M.WeaponryDelete()
		if(M.MuteTime) spawn() M.Muted()
		//M.px = 32 * M.x
		//M.py = 32 * M.y
		//spawn() M.MedalCheck()
		spawn()
			del src
		if(!M.name) M.name=M.key
		winset(M, null, {"
							SkillBar.is-visible      = "true";
							ChatOut.is-visible      = "true";
							ActionOutputChild.is-visible      = "true";
							Maplink.right=mapwindow;
						"})
		M<<"Now speaking in: [M.Channel]."
		spawn(30)if(M)M.ASave()
	verb/CreateCharacter()
		set hidden=1
		if(src.client)
			var/mob/player/M = new//had to put this here because it kept freezing for the new mob ///// This screwed up A LOT of stuff, please do not do that
			M.loc=locate(1,200,19)
			src.loc=locate(1,200,19)
			M.gender = src.gender // We need to create a new player mob, otherwise the player is just a /mob, not /mob/player
			//M.icon = 'WhiteMBase.dmi'
			M.verbs.Add(typesof(/mob/verb))
			M.client=src.client
			M.riconstate = M.icon_state
			M.Ryo=25
			M.name = null
			M.creating=1
			GetScreenResolution(M)
			var/ck = uppercase(M.ckey, 1)
			while(M.name==null)
			//skinput2(prompt,title,initial,Number
				if(M)
					var/ZZ
					ZZ=M.skinput2("Type in a name. Names from the anime are looked down on.","Name",ck,0)
					if(M)
						M.name = ZZ
						var/leng = length(M.name)
						if(hasSavefile(M.name))
							M.skalert("The name you entered already exists.")
							M.name = null
							continue
						if((leng>20) || (leng<3))
							M.skalert("The name must be between 3 and 20 characters.")
							M.name = null
							continue
						if(uppertext(M.name) == M.name)
							M.skalert("Your name may not consist entirely of capital letters.")
							M.name = null
							continue
						if(ffilter_characters(M.name)!=M.name)
							M.skalert("\"[M.name]\" contains an invalid character.  Allowed characters are:\n[allowed_characters_name]")
							M.name = null
							continue
					else return
				else return
				sleep(1)
			M.Logins=lowertext(M.name)
			while(!M.Password)
			//skinput2(prompt,title,initial,Number
				if(M)
					M.Password = M.skinput2("Please select a password for this account. Passwords are now hashed and unreadable by admins or the host.","Password",0)
					if(M)
						if(length(M.Password)<3)
							M.skalert("Password must have atleast 3 characters.")
							M.Password = null
							continue
					else return
				else return
				sleep(1)
			if(!istext(M.Password))
				M.Password="[M.Password]"
			M.Password = md5("[M.Password][M.Password][M.Password][M.Password][M.Password]")
			//var/savefile/F = new("Players/[lowertext(copytext(M.name,1,2))]/[lowertext(M.name)].sav")
			//F["Password"] = Password
			if(M)
				M.name = uppercase(M.name, 1)
				M.rname = M.name
				M.overlays=0
				//M.HairStyle='Long.dmi'
				var/obj/SkinTone
				SkinTone = M.CustomInput("Skin Color Options","Please choose a Skin Tone.",list("White","Dark","Blue","Pale"))
				if(M)
					if(SkinTone)
						switch(SkinTone.name)
							if("White")
								M.SkinTone="White"
							if("Dark")
								M.SkinTone="Dark"
							if("Blue")
								M.SkinTone="Blue"
							if("Pale")
								M.SkinTone="Pale"

				M.ResetBase()

				M.HairStyle = M.CustomInput("Hair Options","Please choose a hair.",list("Long","Short","Tied Back","Bald","Bowl Cut","Deidara","Spikey","Mohawk","Neji Hair","Distance")).name

				/*if(M)
					if(Hair)
						switch(Hair)
							if("Long") M.HairStyle='Long.dmi'
							if("Short") M.HairStyle='Short.dmi'
							if("Tied Back") M.HairStyle='Short2.dmi'
							if("Bald")
								M.HairStyle=null
								goto baldSkip
							if("Bowl Cut") M.HairStyle='Short3.dmi'
							if("Deidara") M.HairStyle= 'Deidara.dmi'
							if("Spikey") M.HairStyle='Spikey.dmi'
							if("Mohawk") M.HairStyle='Mohawk.dmi'
							if("Neji Hair") M.HairStyle='Neji Hair.dmi'
							if("Distance") M.HairStyle='Distance.dmi'*/
			if(M && M.HairStyle != "Bald")
				var/list/Colors=M.ColorInput("Please select a hair color.")
				if(M)
					M.HairColorRed=text2num(Colors[1])
					M.HairColorGreen=text2num(Colors[2])
					M.HairColorBlue=text2num(Colors[3])
/*			if(src)
				var/obj/Gender
				Gender = src.CustomInput("Gender Options","Please choose a Gender.",list("Male","Female"))
				if(src)
					if(Gender)
						switch(Gender.name)
							if("Male")
								src.icon='[SkinTone]MBase.dmi'
							if("Female")
								src.icon='[SkinTone]FBase.dmi'
			if(src)
				var/obj/skintone
				skintone = src.CustomInput("skintone Options","Please choose a Skin tone (Dark female skin tone is still not added)",list("Light Male","Light Female","Dark Male"))
				if(src)
					if(skintone)
						switch(skintone.name)
							if("Light Male")
								src.icon='WhiteMBase.dmi'
							if("Light Female")
								src.icon='WhiteFBase.dmi'
							if("Dark Male")
								src.icon='DarkMBase.dmi'*/
			if(M)
				if(M) M.Element=M.CustomInput("Element Options","Please choose your primary elemental affinity.",list("Fire","Water","Wind","Earth","Lightning"))
				if(M&&M.Element)M.Element=M.Element:name
			if(M)
				M.Specialist=M.CustomInput("Specialist Options","What area of skills would you like to specialize in? Some nonclans and nonclan jutsus require a specific speciality. \n Rinnegan requires Balanced. \n Gates requires strength. \n Each speciality also has it's own nonclan tree.",list("strength","Ninjutsu","Genjutsu","Balanced"))
				if(M&&M.Specialist)M.Specialist=M.Specialist:name
			if(M)
				if(M) M.Clan=M.CustomInput("Clan Options","What clan would you like to be born in?. \n Nonclan has many options that are similar to clans.",list("Senjuu","Crystal","Akimichi","Weaponist","Aburame","Hyuuga","Nara","Kaguya","Uchiha","Ink","Bubble","Uzumaki","No Clan"))
				if(M&&M.Clan)
					M.Clan=M.Clan:name
					/*if(M.Clan=="No Clan")
						if(M)
							var/list/Specialties=list("strength","Ninjutsu","Genjutsu","Balanced")
							var/obj/K=M.CustomInput("Specialist Options","Since you are a non-clan, you get to pick a second specialty. Please choose another.",Specialties-M.Specialist)
							if(M)if(K)M.Specialist2=K.name*/
					if(M)
						var/obj/K=M.CustomInput("Village Options","What village would you like to be born in?.",list("Hidden Leaf","Hidden Sand"/*,"Hidden Mist","Hidden Sound","Hidden Rock"*/))
						if(M)if(K)M.village=K.name
			if(M)
				/*switch(M.Specialist2)
					if("strength")
						M.strength+=6
						M.maxstrengthexp+=5
					if("Ninjutsu")
						M.ninjutsu+=6
						M.maxninexp+=5
					if("Genjutsu")
						M.genjutsu+=6
						M.maxgenexp+=5
					if("Balanced")
						M.strength+=2
						M.genjutsu+=2
						M.ninjutsu+=2
						M.maxstrengthexp+=2
						M.maxninexp+=2
						M.maxgenexp+=2*/
				switch(M.Specialist)
					if("strength")
						M.strength+=6
						M.maxstrengthexp+=6
					if("Ninjutsu")
						M.ninjutsu+=6
						M.maxninexp+=6
					if("Genjutsu")
						M.genjutsu+=6
						M.maxgenexp+=6
					if("Balanced")
						M.strength+=2
						M.genjutsu+=2
						M.ninjutsu+=2
						M.maxstrengthexp+=2
						M.maxninexp+=2
						M.maxgenexp+=2
				for(var/SJ in typesof(/obj/Jutsus))
					var/obj/SJT = new SJ
					if(SJT.starterjutsu==1)
						M.JutsusLearnt.Add(SJT)
						M.JutsusLearnt.Add(SJT.type)
						M.sbought+=SJT.name
						SJT.owner=M.ckey
				M.skillpoints=1
				M.RestoreOverlays()
				for(var/obj/Titlescreen/Logo/L in M.client.screen)del(L)
				if(!M)return
			//	M.client.eye=locate(41,148,14)
				M.loc=locate(39,158,14)//M.MapLoadSpawn()
				M.client.eye=M
				M.client:perspective = EYE_PERSPECTIVE
				M << output("Welcome to the game. Enjoy. Please read the controls below.<br><br>A: Attack<br>S: Use weapon<br>D: Block/Special<br>1,2,3,4,5,Q,W,E: Handseals<br>Space: Execute handseals<br>Arrows: Move<br>F1 - F5: Hotslots<br>R: Recharge chakra<br>Tab: Target<br>Shift+Tab: Untarget<br>Type /help to view commands that can be spoken verbally. Enter key to talk.","actionoutput")
				winset(M, "mainwindow", "is-maximized=true")
				new/obj/Screen/Bar(M)
				if(M.village == "Hidden Leaf")new/obj/Screen/LeafSymbol(M)
				if(M.village == "Hidden Sand")new/obj/Screen/SandSymbol(M)
				if(M.village == "Hidden Mist")new/obj/Screen/MistSymbol(M)
				if(M.village == "Hidden Sound")new/obj/Screen/SoundSymbol(M)
				if(M.village == "Hidden Rock")new/obj/Screen/RockSymbol(M)
				if(M.village == "Akatsuki")new/obj/Screen/AkatsukiSymbol(M)
				if(M.village == "Seven Swordsmen")new/obj/Screen/SsmSymbol(M)
				if(M.village == "Anbu Root")new/obj/Screen/AnbuSymbol(M)
				new/obj/Screen/WeaponSelect(M)
				new/obj/Screen/Health(M)
				new/obj/Screen/Chakra(M)
				new/obj/Screen/EXP(M)
				new/obj/HotSlots/HotSlot1(M)
				new/obj/HotSlots/HotSlot2(M)
				new/obj/HotSlots/HotSlot3(M)
				new/obj/HotSlots/HotSlot4(M)
				new/obj/HotSlots/HotSlot5(M)
				new/obj/HotSlots/HotSlot6(M)
				new/obj/HotSlots/HotSlot7(M)
				new/obj/HotSlots/HotSlot8(M)
				new/obj/HotSlots/HotSlot9(M)
				new/obj/HotSlots/HotSlot10(M)
				var/obj/O=new /obj/Screen/healthbar/
				var/obj/Mana=new /obj/Screen/manabar/
				M.hbar.Add(O)
				M.hbar.Add(Mana)
				for(var/obj/Screen/healthbar/HB in M.hbar)M.overlays+=HB
				for(var/obj/Screen/manabar/HB in M.hbar)M.overlays+=HB
				M.UpdateBars()
				spawn(1)if(M)M.Run()
				//spawn(1)M.lifecycle()
				if(M)
					spawn()
						M.UpdateHMB()
					M.Name(M.name)
					M.pixel_x=-16
					M.RestoreOverlays()
				spawn()if(M)M.WeaponryDelete()
				if(M)M.AddAdminVerbs()
				//spawn()if(M)M.MedalCheck()
				world<<"[M.rname] has logged in for the first time."
				M.creating=0
				winset(M, null, {"
								SkillBar.is-visible      = "true";
								ChatOut.is-visible      = "true";
								ActionOutputChild.is-visible      = "true";
								Maplink.right=mapwindow;
							"})
				M<<"Now speaking in: [M.Channel]."
				spawn(30)if(M)M.ASave()

				TotalPlayers.Add(M)
				for(var/client/A in world)
					if(src.client.computer_id == A.computer_id)
						src<<"Multi keying is fixed."
						src.Logout()


				if(M.skalert("Do you wish to skip the tutorial? Only do this if you are familiar with the game. If you skip this you can't come back without making a new account.","Skip Tutorial?",list("No","Yes"))=="No")
					return
				M.Tutorial=7
				if(M.village=="Hidden Leaf")
					M.loc = locate(116,127,18)
				if(M.village=="Hidden Sand")
					M.loc = locate(91,132,10)
				if(M.village=="Hidden Mist")
					M.loc = locate(75,54,8)
				if(M.village=="Hidden Sound")
					M.loc = locate(140,28,6)
				if(M.village=="Hidden Rock")
					M.loc = locate(21,13,16)

			/*	TotalPlayers.Add(M)
				for(var/client/A in world)
					if(src.client.computer_id == A.computer_id)
						src<<"Multi keying is fixed."
						src.Logout()*/

				spawn()
					del src


mob/var/tmp/Prisoner
mob/var/tmp/creating
mob/player
	Logout()
		if(creating) del(src)
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
			for(var/obj/Jutsus/CalorieControl/J in src.JutsusLearnt)
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
		TotalPlayers.Remove(src)
		Save()
		if(src.key&&src.name)world<<"[src.name] has logged out!"
		if(Squad)
			if(Squad.Leader == ckey)del Squad
			else if(Squad.Members.Find(ckey))
				for(var/i in Squad.Members)
					var/mob/player/P = getOwner(i)
					P.Squad.Members -= ckey
				var/mob/player/P = getOwner(Squad.Leader)
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
		//var/list/possible_entries = typesof(/mob/Jutsus/verb)
		//var/list/current_verbs = src.verbs.Copy()
		//for(var/R in current_verbs) if(!(R in possible_entries)) current_verbs -= R
		if(!src.key) //This means that they're simply switching mobs
			world.log << "[src.rname] has left their mob without logging out."
			del src
			return
		del(src)
		..()
mob/proc/ASave()
	while(src)
		Save()
		sleep(600*3)//Three minutes to save periodically!

mob
	proc
		Save()
			var/savefile/F = new/savefile("Players/[copytext(Logins,1,2)]/[Logins].sav")
			F["Password"] = Password
			F << src
			//src << output("Game saved successfully.", "actionoutput")

	Write(var/savefile/F,var/list/neversave=null)
		. = ..(F,neversave)
		var/ocd = F.cd
		F.cd = "location"
		F << x
		F << y
		F << z
		F << step_x
		F << step_y
		F << dir
		F.cd = ocd
		return .

	Read(var/savefile/F,var/list/neversave=null)
		. = ..(F,neversave)
		var/ocd = F.cd
		F.cd = "location"
		F >> x
		F >> y
		F >> z
		F >> step_x
		F >> step_y
		F >> dir
		F.cd = ocd
		return .
/*mob/player
	Del()
		Logout()
		..()*/
mob
	var/tmp
		Channel="Say"
	verb
		WorldAddy()
			set hidden=1
			usr << output("<FONT FACE= Times New Roman>byond://[world.internet_address]:[world.port]", "actionoutput")
	verb
		CloseBrowser()
			set hidden=1
			winset(src, null, {"
						mainwindow.BrowserChild.is-visible = "false";
					"})
		MiniWindow()
			set hidden=1
			winset(usr, "mainwindow", "is-minimized=true")

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