mob
	var
		character
		password
		password_salt
		creation_date
		playtime = 0
		last_online

		name_color = ""

		items=0
		maxitems=-1 // Max Satchel Slots: -1 = Unlimited
		equipped
		jutsus[0]
		jutsus_learned[0]

		tmp
			name_overlays

	New()
		..()
		sleep(1)
		if(src.client || istype(src, /mob/summonings) || istype(src, /mob/jutsus) || istype(src, /mob/Rotating_Dummy))
			src.mouse_over_pointer = /obj/cursors/target

	Del()
		..()

	Login()
		..()
		var/obj/login_eye = new(locate(101,100,7))
		src.client.eye = login_eye
		src.client.perspective = EYE_PERSPECTIVE
		spawn() GetScreenResolution(src)
		src.client.screen += new/obj/Logos/Naruto_Evolution
		spawn()
			while(!mobs_online.Find(src))
				step_rand(login_eye)
				sleep(3)
			del(login_eye)

	Logout()
		..()
		for(var/obj/Inventory/mission/deliver_intel/o in src.contents) src.DropItem(o)

	verb/LoginCharacter()
		set hidden = 1
		if(src.client && !mobs_online.Find(src) && !src.client.logging_in)
			src.client.logging_in = 1

			var/character=uppercase(winget(src.client, "Titlescreen.Username", "text"), 1)
			var/password=winget(src.client, "Titlescreen.Password", "text")

			if(!character && !password)
				src.client.Alert("Please enter your character name and password.")
				src.client.logging_in = 0
				return 0
			else if(!character)
				src.client.Alert("Please enter your character name.")
				src.client.logging_in = 0
				return 0
			else if(!password)
				src.client.Alert("Please enter your password.")
				src.client.logging_in = 0
				return 0

			winset(src,"Titlescreen.Password","text=")

			if(fexists("[SAVEFILE_CHARACTERS]/[copytext(src.ckey, 1, 2)]/[src.ckey] ([lowertext(character)]).sav.lk"))
				src.client.Alert("You cannot load this character because it is currently in use.")
				src.client.logging_in = 0
				return 0

			var/savefile/F = new("[SAVEFILE_CHARACTERS]/[copytext(src.ckey, 1, 2)]/[src.ckey] ([lowertext(character)]).sav")
			var/password_hash = sha1("[password][F["password_salt"]]")
			if(password_hash != F["password"])
				src.client.Alert("The character name or password you entered is incorrect.")
				src.client.logging_in = 0
			else
				src.Load(character)

	verb/CreateCharacter()
		set hidden = 1
		if(src.client && !mobs_online.Find(src) && !src.client.logging_in)
			src.client.logging_in = 1

			src.name = null
			var/list/prompt

			while(src && !src.character)
				prompt = src.client.AlertInput("Please choose a character name...")
				src.character = prompt[2]

				if(length(src.character) < 3 || length(src.character) > 20)
					src.client.Alert("Your character name must be between 3 and 20 characters.")
					src.character = null

				else if(uppertext(src.character) == src.character)
					src.client.Alert("Your character name must not consist entirely of capital letters.")
					src.character = null

				else if(ffilter_characters(src.character) != src.character)
					src.client.Alert("\"[src.name]\" contains an invalid character.  Allowed characters are:\n[allowed_characters_name]")
					src.character = null

				else if(names_taken.Find(src.character))
					src.client.Alert("The character name <b>[src.character]</b> is already taken.")
					src.character = null

				sleep(1)

			while(src && !src.password)
				prompt = src.client.AlertInput("Please select a password for this account. Passwords are now hashed and unreadable by admins or the host.","Password", mask=1)
				src.password = prompt[2]
				if(length(src.password) < 3)
					src.client.Alert("Password must have atleast 3 characters.")
					src.password = null
				else
					src.password_salt = sha1(src.ckey)
					src.password = sha1("[src.password][src.password_salt]")

				sleep(1)

			prompt = src.client.AlertList("Skin Color Options","Please choose a Skin Tone.",list("Pale","White","Dark","Blue"))
			switch(prompt)
				if(1)
					src.SkinTone="Pale"
				if(2)
					src.SkinTone="White"
				if(3)
					src.SkinTone="Dark"
				if(4)
					src.SkinTone="Blue"
			src.ResetBase()

			src.HairStyle = src.CustomInput("Hair Options","Please choose a hair.",list("Long","Short","Tied Back","Bald","Bowl Cut","Deidara","Spikey","srcohawk","Neji Hair","Distance")).name
			if(src.HairStyle != "Bald")
				var/list/Colors=src.ColorInput("Please select a hair color.")
				src.HairColorRed=text2num(Colors[1])
				src.HairColorGreen=text2num(Colors[2])
				src.HairColorBlue=text2num(Colors[3])

			src.Element = src.CustomInput("Element Options","Please choose your primary elemental affinity.",list("Fire","Water","Wind","Earth","Lightning")).name
			src.Specialist = src.CustomInput("Specialist Options","What area of skills would you like to specialize in? Some nonclans and nonclan jutsus require a specific speciality. \n Rinnegan requires Balanced. \n Gates requires strength. \n Each speciality also has it's own nonclan tree.", list("strength","Ninjutsu","Genjutsu","Balanced")).name
			src.Clan = src.CustomInput("Clan Options","What clan would you like to be born in?. \n Nonclan has many options that are similar to clans.",list("Senjuu","Crystal","Akimichi","Weaponist","Aburame","Hyuuga","Nara","Kaguya","Uchiha","Ink","Bubble","Uzumaki","No Clan")).name
			src.village=src.CustomInput("Village Options","What village would you like to be born in?.",list("Hidden Leaf","Hidden Sand"/*,"Hidden Mist","Hidden Sound","Hidden Rock"*/)).name

			switch(src.Specialist)
				if("strength")
					src.strength+=6
					src.maxstrengthexp+=6

				if("Ninjutsu")
					src.ninjutsu+=6
					src.maxninexp+=6

				if("Genjutsu")
					src.genjutsu+=6
					src.maxgenexp+=6

				if("Balanced")
					src.strength+=2
					src.genjutsu+=2
					src.ninjutsu+=2
					src.maxstrengthexp+=2
					src.maxninexp+=2
					src.maxgenexp+=2

			for(var/jutsu in typesof(/obj/Jutsus))
				var/obj/Jutsus/j = new jutsu
				if(src && j.starterjutsu)
					j.owner = src.ckey
					src.jutsus += j
					src.jutsus_learned += j.type
					src.sbought += j.name

			src.creation_date = world.realtime
			names_taken += src.character
			src.name = src.character
			src.rname = src.name

			src.pixel_x = -16

			src.RestoreOverlays()
			spawn() src.Run()
			spawn() src.HealthRegeneration()
			spawn() src.WeaponryDelete()
			spawn() src.AddAdminVerbs()

			for(var/obj/Logos/Naruto_Evolution/L in src.client.screen) src.client.screen -= L

			winset(src, null, {"
				Main.NavigationChild.is-visible      = "true";
				Main.OutputChild.is-visible      = "true";
				Main.ActionChild.is-visible      = "true";
				Main.Child.right=Map;
			"})

			src.loc = locate(39,158,14)
			src.client.eye = src
			src.client.perspective = MOB_PERSPECTIVE

			clients_online += src.client
			mobs_online += src

			src << world.GetAdvert()
			world << "[src] has logged in for the first time."
			src << output("<br /><b><u>Basic Controls:</u></b><br><b>A:</b> Attack<br><b>S:</b> Use weapon<br><b>D:</b> Block/Special<br><b>1</b>,<b>2</b>,<b>3</b>,<b>4</b>,<b>5</b>,<b>Q</b>,<b>W</b>,<b>E:</b> Handseals<br><b>Space:</b> Execute handseals<br><b>Arrows:</b> Move<br><b>F1 - F10:</b> Hotslots<br><b>R:</b> Recharge chakra<br><b>I:</b> Inventory<br><b>O:</b> Statpanel<br><b>P:</b> Jutsus<br>Press the <b>\[Enter]</b> key to talk. Type <i>/help</i> to view commands that can be spoken verbally.<br />","Action.Output")
			src << "Now speaking in: [src.client.channel]."

			new/obj/Screen/Bar(src)
			switch(src.village)
				if("Hidden Leaf") new/obj/Screen/LeafSymbol(src)
				if("Hidden Sand") new/obj/Screen/SandSymbol(src)
				if("Hidden Mist") new/obj/Screen/MistSymbol(src)
				if("Hidden Sound") new/obj/Screen/SoundSymbol(src)
				if("Hidden Rock") new/obj/Screen/RockSymbol(src)
				if("Missing-Nin") new/obj/Screen/MissingSymbol(src)
				if("Akatsuki") new/obj/Screen/AkatsukiSymbol(src)
				if("Seven Swordsmen") new/obj/Screen/SsmSymbol(src)
				if("Anbu Root") new/obj/Screen/AnbuSymbol(src)
			new/obj/Screen/WeaponSelect(src)
			new/obj/Screen/Health(src)
			new/obj/Screen/Chakra(src)
			new/obj/Screen/EXP(src)
			new/obj/HotSlots/HotSlot1(src)
			new/obj/HotSlots/HotSlot2(src)
			new/obj/HotSlots/HotSlot3(src)
			new/obj/HotSlots/HotSlot4(src)
			new/obj/HotSlots/HotSlot5(src)
			new/obj/HotSlots/HotSlot6(src)
			new/obj/HotSlots/HotSlot7(src)
			new/obj/HotSlots/HotSlot8(src)
			new/obj/HotSlots/HotSlot9(src)
			new/obj/HotSlots/HotSlot10(src)
			var/obj/O=new/obj/Screen/healthbar
			var/obj/Mana=new/obj/Screen/manabar
			src.hbar.Add(O)
			src.hbar.Add(Mana)
			for(var/obj/Screen/healthbar/HB in src.hbar) src.overlays+=HB
			for(var/obj/Screen/manabar/HB in src.hbar) src.overlays+=HB
			spawn() src.UpdateBars()
			spawn() src.UpdateHMB()

			if(src.client.Alert("Do you wish to skip the tutorial? Only do this if you are familiar with the game. If you skip this you can't come back without making a new account.", "Skip Tutorial?", list("Yes", "No")) == 1)
				src.Tutorial = 7
				var/obj/Jutsus/jutsu = new/obj/Jutsus/BodyReplace
				src.sbought += jutsu.name
				src.jutsus.Add(jutsu)
				src.jutsus_learned.Add(jutsu.type)
				jutsu.owner = src.ckey
				src.skillpoints--
				switch(src.village)
					if("Hidden Leaf")
						src.loc = locate(116,127,18)
					if("Hidden Sand")
						src.loc = locate(91,132,10)
					if("Hidden Mist")
						src.loc = locate(75,54,8)
					if("Hidden Sound")
						src.loc = locate(140,28,6)
					if("Hidden Rock")
						src.loc = locate(21,13,16)

	proc/Playtime()
		while(src)
			if(mobs_online.Find(src)) src.playtime++
			sleep(10)

	verb
		Say(msg as text)
			set hidden=1
			winset(src, null, {"
				Map.Main.focus = "true";
				Main.InputChild.is-visible = false;
			"})

			var/message_trim

			if(!msg) return

			if(src.Muted)
				src << "You are currently muted."
				return

			else if(length(msg) > 600)
				message_trim = copytext(msg, 600)
				msg = copytext(msg, 1, 600)

			if(findtext(msg, "/stuck"))
				src.Stuck()
				return

			else if(findtext(msg, "/mute"))
				src.Vote_Mute()
				return

			else if(findtext(msg, "/boot"))
				src.Vote_Boot()
				return

			else if(findtext(msg, "/world"))
				src << output("World Address: byond://[world.internet_address]:[world.port]", "Action.Output")
				return

			else if(findtext(msg, "/help"))
				src.Help()
				return

			else
				var/obj/Symbols/Village/village = new(src)
				var/obj/Symbols/Rank/rank = new(src)
				var/obj/Symbols/Role/role = new(src)
				var/badges = ""
				if(role.icon) badges += "\icon[role] "
				if(village.icon) badges += "\icon[village]"
				if(rank.icon) badges += " \icon[rank]"

				var/whisper = winget(src, "InputPanel.WhisperInput", "text")
				if(whisper)
					if(src.name == whisper)
						src << "You cannot whisper to yourself. Try speaking in global chat to make some new friends."
						return

					var/whisper_target_online = 0
					for(var/mob/M in mobs_online)
						if(whisper == M.name)
							src << "\[W] [badges] <font color='[src.namecolor]'>[src.name]</font>: [msg]"
							M << "\[W] [badges] <font color='[src.namecolor]'>[src.name]</font>: [msg]"
							whisper_target_online = 1
							break

					if(!whisper_target_online)
						src << "You cannot whisper <i>[whisper]</i> because they're no longer online or the character doesn't exist."

				else if(src.likeaclone)
					if(src.client.channel == "Local")
						var/mob/clone = src.likeaclone
						view(clone) << ffilter("[badges] <font color='[clone.namecolor]'>[clone.name]</font>: <font color='[clone.chatcolor]'>[html_encode(msg)]</font>")
					else
						src << "Clones can only speak within the say channel."

				else
					switch(src.client.channel)
						if("Local")
							view() << ffilter("[badges] <font color='[src.namecolor]'>[src.name]</font>: <font color='[src.chatcolor]'>[html_encode(msg)]</font>")

						if("Village")
							for(var/mob/M in mobs_online)
								if(src.village == M.village || M.admin)
									M << ffilter("<font color='yellow'>\[V]</font> [badges] <font color='[src.namecolor]'>[src.name]</font>: <font color='[src.chatcolor]'>[html_encode(msg)]</font>")

						if("Squad")
							if(src.Squad)
								for(var/mob/M in mobs_online)
									if(M.ckey == src.Squad.Leader || src.Squad.Members.Find(M.ckey))
										M << ffilter("<font color='white'>\[S]</font> [badges] <font color='[src.namecolor]'>[src.name]</font>: <font color='[src.chatcolor]'>[html_encode(msg)]</font>")
							else
								src << "You cannot speak in the squad channel because you are not currently in a squad."

						if("Faction")
							if(src.Faction)
								var/Faction/F = src.Faction
								for(var/mob/M in mobs_online)
									if(src.Faction == M.Faction || M.admin)
										M << ffilter("<font color='[F.color]'>\[F] [F.name]</font> [badges] <font color='[src.namecolor]'>[src.name]</font>: <font color='[src.chatcolor]'> [html_encode(msg)]</font>")

							else
								src << "You cannot speak in the faction channel because you are not currently in a faction."

						if("Global")
							if(worldmute)
								src << "You cannot speak in the global channel because it is currently muted."
							else
								world << ffilter("<font color='red'>\[G]</font> [badges] <font color='[src.namecolor]'>[src.name]</font>: <font color='[src.chatcolor]'>[html_encode(msg)]</font>")

				if(message_trim)
					src << "Your message was longer than 1000 characters and has been trimmed."
					src << "The following text was trimmed:"
					src << message_trim

		Create_Ryo_Pouch()
			set hidden = 1
			if(!src.ryo)
				src << output("You don't have any Ryo to create a Ryo Pouch.", "Action.Output")
			else
				var/list/prompt=src.client.AlertInput("How much Ryo would you like to bundle in a Ryo Pouch?","Create Ryo Pouch")
				var/ryo = prompt[2]
				if(ryo && isnum(ryo))
					if(src.ryo >= ryo)
						src.ryo -= ryo
						new/obj/Inventory/ryo_pouch(src, ryo)
						view() << "<i>[src] removes [ryo] Ryo from their satchel and bundles it into a Ryo Pouch.</i>"
						src.client.UpdateInventoryPanel()
					else
						src << output("You don't have [ryo] Ryo to drop.", "Action.Output")

mob
	proc
		SetName(var/Name, var/Color = src.name_color, var/Outline = 1)
			if(Name)
				if(src.client)
					names_taken.Remove(src.name)
					names_taken.Add(Name)
				src.name = Name
				src.rname = Name

				if(src.name_overlays)
					src.overlays -= src.name_overlays
					src.name_overlays = null

				if(!Color)
					if(!src.client) Color = "white"
					if(!src.village) Color = "white"
					else
						switch(src.village)
							if(VILLAGE_LEAF) Color = "#2b7154"
							if(VILLAGE_SAND) Color = "#886541"
							if(VILLAGE_MISSING_NIN) Color = "white"
							if(VILLAGE_AKATSUKI) Color = "#971e1e"

				var/obj/name = new()
				name.layer = MOB_LAYER - 1000
				name.maptext_width = 128
				name.pixel_x = name.pixel_x - name.maptext_width / 2 + src.bound_width
				name.pixel_y -= 16
				name.maptext = "<span style=\"-dm-text-outline: [Outline]px black; color: [Color]; font-family: 'Open Sans'; font-weight: bold; text-align: center; vertical-align: bottom;\">[Name]</span>"
				src.name_overlays = image(name, src)
				src.overlays += src.name_overlays

		SetVillage(var/village)
			if(village)
				src.village = village
				src.SetName(src.name)
				src.client.UpdateCharacterPanel()

		checkRank()
			switch(src.rank)
				if(RANK_ACADEMY_STUDENT) return 0
				if(RANK_GENIN) return 1
				if(RANK_CHUUNIN) return 2
				if(RANK_JOUNIN) return 3
				if(RANK_ANBU) return 4
				if(RANK_ANBU_LEADER) return 5
				if(RANK_HOKAGE) return 5
				if(RANK_KAZEKAGE) return 5
				if(RANK_MIZUKAGE) return 5
				if(RANK_OTOKAGE) return 5
				if(RANK_TSUCHIKAGE) return 5
				if(RANK_AKATSUKI) return 4
				if(RANK_AKATSUKI_LEADER) return 5
				if(RANK_SEVEN_SWORDSMEN_LEADER) return 5

		SetRank(var/RANK)
			if(RANK)
				src.rank = RANK
				src.client.UpdateCharacterPanel()
				switch(RANK)
					/*if(RANK_ANBU_ROOT)
						new/obj/Screen/AnbuSymbol(src)*/

					if(RANK_AKATSUKI)
						new/obj/Screen/AkatsukiSymbol(src)
						src.SetVillage(VILLAGE_AKATSUKI)

					if(RANK_AKATSUKI_LEADER)
						new/obj/Screen/AkatsukiSymbol(src)
						src.SetVillage(VILLAGE_AKATSUKI)

					// Add SSM

					if(RANK_SEVEN_SWORDSMEN_LEADER)
						new/obj/Screen/SsmSymbol(src)

		SetRyo(var/ryo)
			if(ryo)
				if(ryo < 0) ryo = 0
				src.ryo = ryo
				src.client.UpdateInventoryPanel()

		HealthRegeneration()
			while(src)
				if(src.Gates == null && src.healthregenmod < 1) src.healthregenmod = 1
				if(src.rest) src.healthregenmod += 2
				src.health += round((src.maxhealth/100) * src.healthregenmod)
				src.health = min(src.health, src.maxhealth)
				if(src.rest) src.healthregenmod -= 2 
				spawn() src.UpdateBars()
				spawn() src.UpdateHMB()
				sleep(10)

		Respawn()
			if(!src.revived)
				var/list/Spawns=RespawnSpawn()
				if(!Spawns.len) src.loc=locate(1,1,4)
				else src.loc=pick(src.RespawnSpawn())
			else src.revived=0

			src.dead=0
			src.density=1
			src.health=src.maxhealth
			src.chakra=src.maxchakra
			src.injutsu=0
			src.canattack=1
			src.firing=0
			src.icon_state=""
			src.wait=0
			src.rest=0
			src.dodge=0
			src.move=1
			src.swimming=0
			src.walkingonwater=0
			src.overlays=0
			src.RestoreOverlays()
			spawn() src.client.UpdateCharacterPanel()
			spawn() src.UpdateHMB()
			spawn() src.Run()
			revived=0

proc
	DamageOverlay(mob/M, damage, color, outline=1)
		var/obj/O = locate() in damage_number_pool
		if(O)
			damage_number_pool-=O
			O.loc=M.loc
		else
			O=new(M.loc)

		O.layer = EFFECTS_LAYER
		O.maptext_width = 128
		O.maptext_height = 128
		O.pixel_y = 70
		O.pixel_x = (M.bound_width - O.maptext_width) / 2 + M.bound_x
		O.maptext = "<span style=\"-dm-text-outline: [outline]px black; color: [color]; font-family: 'Open Sans'; font-weight: bold; text-align: center; vertical-align: bottom;\">[damage]</span>"
		O.alpha = 255

		sleep(1)
		animate(O, alpha = 0, pixel_y = 102, time = 5)

		spawn(15)
			O.loc=null
			damage_number_pool += O
