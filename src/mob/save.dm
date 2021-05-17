var/savefile_version = 1

mob
	proc/Save()
		var/savefile/F = new("[SAVEFILE_CHARACTERS]/[copytext(src.ckey, 1, 2)]/[src.ckey] ([lowertext(src.character)]).sav")
		text2file("[time2text(world.realtime, "YYYY/MM/DD hh:mm:ss")] (Write)", LOG_SAVES)
		text2file("\[O]: [F]...", LOG_SAVES)
		if(src.Write(F, src.name)) return 1
		else return 0

	proc/Load(var/character)
		var/savefile/F = new("[SAVEFILE_CHARACTERS]/[copytext(src.ckey, 1, 2)]/[src.ckey] ([lowertext(character)]).sav")
		text2file("[time2text(world.realtime, "YYYY/MM/DD hh:mm:ss")] (Read)", LOG_SAVES)
		text2file("\[O]: [F]...", LOG_SAVES)
		if(src.Read(F, character)) return 1
		else return 0


	Write(savefile/F, var/character)
		if(src.client)
			if(character)
				var/list/exclude = list("icon", "icon_state", "overlays", "underlays", "alpha", "layer", "bound_width", "bound_height", "bound_x", "bound_y", "pixel_x", "pixel_y", "appearance_flags", "transform", "vis_contents", "filters", "view")
				if(src.client && mobs_online.Find(src))
					for(var/v in src.vars)
						if(issaved(src.vars[v]))
							if(initial(src.vars[v]) == src.vars[v])
								F.dir.Remove(v)
								text2file("\[W]: \[RM]: \[initial()]:  [v] = [src.vars[v]]", LOG_SAVES)
							else if(exclude.Find(v))
								F.dir.Remove(v)
								text2file("\[W]: \[RM]: \[exclude.Find()]:  [v] = [src.vars[v]]", LOG_SAVES)
							else
								F[v] << src.vars[v]
								text2file("\[W]: [v] = [src.vars[v]]", LOG_SAVES)
						else
							F.dir.Remove(v)
							text2file("\[W]: \[RM]: \[!issaved()]:  [v] = [src.vars[v]]", LOG_SAVES)

					F["password_hotfix"] << src.password
					F["x"] << src.x
					F["y"] << src.y
					F["z"] << src.z
					F["savefile_version"] << savefile_version
					text2file("\[C]: [F]\n", LOG_SAVES)

				else
					text2file("\[E]: \[W]: invalid attempt to write savefile while not logged in.\n", LOG_SAVES)
					text2file("\[C]: [F]\n", LOG_SAVES)
					return 0
			else
				text2file("\[E]: \[W]: null character when attempting to write to savefile.\n", LOG_SAVES)
				text2file("\[C]: [F]\n", LOG_SAVES)
				return 0
		else
			text2file("\[E]: \[W]: null client when attempting to write to savefile.\n", LOG_SAVES)
			text2file("\[C]: [F]\n", LOG_SAVES)
			return 0
		..()


	Read(savefile/F, var/character)
		if(src.client)
			if(!mobs_online.Find(src))
				if(character)
					if(fexists("[F]"))
						src.last_online = world.realtime
						for(var/v in src.vars)
							if(issaved(src.vars[v]))
								if(!isnull(F[v]))
									F[v] >> src.vars[v]
									text2file("\[R]: [v] = [src.vars[v]]", LOG_SAVES)
								else
									F.dir.Remove(v)
									text2file("\[R]: \[RM]: \[isnull()]:  [v] = [src.vars[v]]", LOG_SAVES)

						F["password_hotfix"] >> src.password
						text2file("\[C]: [F]\n", LOG_SAVES)
					else
						spawn() src.client.Alert("The username you entered doesn't exist.")
						return 0
				else
					text2file("\[E]: \[R]: null character name when attempting to read from savefile.\n", LOG_SAVES)
					text2file("\[C]: [F]\n", LOG_SAVES)
					return 0
			else
				text2file("\[E]: \[R]: invalid attempt to read savefile while already logged in.\n", LOG_SAVES)
				text2file("\[C]: [F]\n", LOG_SAVES)
				return 0
		else
			text2file("\[E]: \[R]: null client when attempting to read from savefile.\n", LOG_SAVES)
			text2file("\[C]: [F]\n", LOG_SAVES)
			return 0
		..()

		src.pixel_x=-16

		spawn() src.RestoreOverlays()
		spawn() src.Run()
		spawn() src.HealthRegeneration()
		spawn() src.WeaponryDelete()
		spawn() src.AddAdminVerbs()
		if(src.MuteTime) spawn() src.Muted()

		for(var/obj/Logos/Naruto_Evolution/L in src.client.screen) src.client.screen -= L

		winset(src.client, null, {"
			Main.NavigationChild.is-visible      = "true";
			Main.OutputChild.is-visible      = "true";
			Main.ActionChild.is-visible      = "true";
			Main.Child.right=Map;
			Navigation.ExpLockButton.is-disabled = false
		"})

		src.loc = locate(F["x"], F["y"], F["z"])
		src.client.eye = src
		src.client.perspective = MOB_PERSPECTIVE

		clients_online += src.client
		mobs_online += src

		world<<"[src.character] has logged in."
		src << output("Welcome to the game. Please read the controls below.<br><br>A: Attack<br>S: Use weapon<br>D: Block/Special<br>1,2,3,4,5,Q,W,E: Handseals<br>Space: Execute handseals<br>Arrows: Move<br>F1 - F10: Hotslots<br>R: Recharge chakra<br>I: Inventory<br>O: Statpanel<br>P: Jutsus<br>Type /help to view commands that can be spoken verbally. Enter key to talk.","Action.Output")
		src << "Welcome [src.character]. If you're new please read the rules. You can find them in the Options panel. If you need to contact someone, there is a link to our discord on the HUB. Check the Action output to the right for controls."
		src << "Now speaking in: [src.client.channel]."

		new/obj/Screen/Bar(src)
		switch(src.village)
			if("Hidden Leaf") new/obj/Screen/LeafSymbol(src)
			if("Hidden Sand") new/obj/Screen/SandSymbol(src)
			if("Hidden Mist") new/obj/Screen/MistSymbol(src)
			if("Hidden Sound") new/obj/Screen/SoundSymbol(src)
			if("Hidden Rock") new/obj/Screen/RockSymbol(src)
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
		spawn() src.UpdateSlots()
		spawn() src.client.FlashExperienceLock()

		for(var/jutsu in src.jutsus) if(isnull(jutsu)) src.jutsus -= jutsu
		for(var/jutsu in src.jutsus_learned) if(isnull(jutsu)) src.jutsus -= jutsu
		for(var/jutsu in src.sbought) if(isnull(jutsu)) src.sbought -= jutsu

		var/Faction/c = getFaction(src.Faction)
		if(c)
			if(src.Faction == c.name)
				src.verbs += src.Factionverbs
				c.onlinemembers.Add(src)
				c.members[src.rname] = list(src.key, src.level, src.Factionrank)
				if(c.FMOTD) src << output("Faction MOTD: <br>[c.FMOTD]</br>","Action.Output")
				src.verbs += /Faction/Generic/verb/FactionLeave
				winset(src, "Navigation.FactionButton", "is-disabled = 'false'")

		if(src.Faction && !getFaction(src.Faction))
			src<<"Your Faction no longer exists. [src.Faction] has disbanded."
			src.Faction=null
			src.Factionrank=null
			src.verbs-=src.Factionverbs
			src.Factionverbs=list()

		for(var/obj/Inventory/Clothing/C in src.contents)
			if(src.suffix == "(Equipped)")
				src.ClothingOverlays["[C.section]"] = C.icon

		// FINISH BELOW THIS LINE
		GetScreenResolution(src)

		src.density=1
		src.sight=0
		src.invisibility=0

		if(!src.loc)
			if(src.Tutorial==7) src.loc=src.MapLoadSpawn()
			else src.loc=locate(39,158,14)

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
			src.walkingonwater=0
			src.overlays=0

		src.namecolor="green"
		src.chatcolor="white"