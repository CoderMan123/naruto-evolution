var/savefile_version = 1

mob
	proc/Save()
		if(src.client && mobs_online.Find(src))
			var/savefile/F = new("[SAVEFILE_CHARACTERS]/[copytext(src.ckey, 1, 2)]/[src.ckey] ([lowertext(src.character)]).sav")
			text2file("[time2text(world.realtime, "YYYY/MM/DD hh:mm:ss")] (Write)<br />", LOG_SAVES)
			text2file("\[O]: [F]...<br />", LOG_SAVES)
			if(src.Write(F, src.name)) return 1
			else return 0
		else return 0

	proc/Load(var/character, var/password)
		if(fexists("[SAVEFILE_CHARACTERS]/[copytext(src.ckey, 1, 2)]/[src.ckey] ([lowertext(character)]).sav.lk"))
			src.client.Alert("You cannot load this character because it is currently in use.")
			src.client.logging_in = 0
			return 0

		else
			if(fexists("[SAVEFILE_CHARACTERS]/[copytext(src.ckey, 1, 2)]/[src.ckey] ([lowertext(character)]).sav"))
				var/savefile/F = new("[SAVEFILE_CHARACTERS]/[copytext(src.ckey, 1, 2)]/[src.ckey] ([lowertext(character)]).sav")
				var/password_hash = sha1("[password][F["password_salt"]]")
				if(password_hash != F["password"])
					spawn() src.client.Alert("The character name or password you entered is incorrect.")
					src.client.logging_in = 0
					return 0
				else
					text2file("[time2text(world.realtime, "YYYY/MM/DD hh:mm:ss")] (Read)<br />", LOG_SAVES)
					text2file("\[O]: [F]...<br />", LOG_SAVES)
					if(src.Read(F, character, password)) return 1
					else return 0
			else
				var/character_found = 0
				for(var/directory in flist("[SAVEFILE_CHARACTERS]/"))
					for(var/savefile in flist("[SAVEFILE_CHARACTERS]/[directory]/"))
						if(findtext(savefile, character))
							character_found = 1

				if(character_found)spawn() src.client.Alert("The character you are trying access to not linked to your current BYOND account. Please login with the BYOND account that created this character.")
				else spawn() src.client.Alert("The character name or password you entered is incorrect.")

				src.client.logging_in = 0
				return 0


	Write(savefile/F, var/character)
		if(src.client)
			if(mobs_online.Find(src))
				if(character)
					src.last_online = world.realtime
					if(kages[src.village] == src.client.ckey) kages_last_online[src.village] = src.last_online

					var/list/exclude = list("icon", "icon_state", "overlays", "underlays", "alpha", "layer", "bound_width", "bound_height", "bound_x", "bound_y", "pixel_x", "pixel_y", "appearance_flags", "transform", "vis_contents", "filters", "view")
					for(var/v in src.vars)
						if(issaved(src.vars[v]))
							if(initial(src.vars[v]) == src.vars[v])
								F.dir.Remove(v)
								text2file("\[W]: \[RM]: \[initial()]:  [v] = [src.vars[v]]<br />", LOG_SAVES)
							else if(exclude.Find(v))
								F.dir.Remove(v)
								text2file("\[W]: \[RM]: \[exclude.Find()]:  [v] = [src.vars[v]]<br />", LOG_SAVES)
							else
								F[v] << src.vars[v]
								text2file("\[W]: [v] = [src.vars[v]]<br />", LOG_SAVES)
						else
							F.dir.Remove(v)
							text2file("\[W]: \[RM]: \[!issaved()]:  [v] = [src.vars[v]]<br />", LOG_SAVES)

					F["password_hotfix"] << src.password
					F["x"] << src.x
					F["y"] << src.y
					F["z"] << src.z
					F["savefile_version"] << savefile_version
					text2file("\[C]: [F]<br /><br />", LOG_SAVES)

				else
					text2file("\[E]: \[W]: null character when attempting to write to savefile.<br />", LOG_SAVES)
					text2file("\[C]: [F]<br /><br />", LOG_SAVES)
					return 0
			else
				text2file("\[E]: \[W]: invalid attempt to write savefile while not logged in.<br />", LOG_SAVES)
				text2file("\[C]: [F]<br /><br />", LOG_SAVES)
				return 0
		else
			text2file("\[E]: \[W]: null client when attempting to write to savefile.<br />", LOG_SAVES)
			text2file("\[C]: [F]<br /><br />", LOG_SAVES)
			return 0
		..()


	Read(savefile/F, var/character, var/password)
		if(src.client)
			if(!mobs_online.Find(src))
				if(character)
					src.last_online = world.realtime
					if(kages[src.village] == src.client.ckey) kages_last_online[src.village] = src.last_online

					for(var/v in src.vars)
						if(issaved(src.vars[v]))
							if(!isnull(F[v]))
								F[v] >> src.vars[v]
								text2file("\[R]: [v] = [src.vars[v]]<br />", LOG_SAVES)
							else
								F.dir.Remove(v)
								text2file("\[R]: \[RM]: \[isnull()]:  [v] = [src.vars[v]]<br />", LOG_SAVES)

					F["password_hotfix"] >> src.password
					text2file("\[C]: [F]<br /><br />", LOG_SAVES)
				else
					text2file("\[E]: \[R]: null character name when attempting to read from savefile.<br />", LOG_SAVES)
					text2file("\[C]: [F]<br /><br />", LOG_SAVES)
					return 0
			else
				text2file("\[E]: \[R]: invalid attempt to read savefile while already logged in.<br />", LOG_SAVES)
				text2file("\[C]: [F]<br /><br />", LOG_SAVES)
				return 0
		else
			text2file("\[E]: \[R]: null client when attempting to read from savefile.<br />", LOG_SAVES)
			text2file("\[C]: [F]<br /><br />", LOG_SAVES)
			return 0
		..()

		src.pixel_x=-16

		src.RestoreOverlays()
		spawn() src.Run()
		spawn() src.HealthRegeneration()
		spawn() src.WeaponryDelete()

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

		src << world.GetAdvert()

		for(var/mob/m in mobs_online)
			if(administrators.Find(m.client.ckey) || moderators.Find(m.client.ckey))
				if(clients_multikeying.Find(src.client))
					m << "[src.name] ([src.client.ckey]) <sup>(Multikey)</sup> has logged in."
				else
					m << "[src.name] ([src.client.ckey]) has logged in."
			else
				m << "[src.name] has logged in."

		src << output("<br /><b><u>Basic Controls:</u></b><br><b>A:</b> Attack<br><b>S:</b> Use weapon<br><b>D:</b> Block/Special<br><b>1</b>,<b>2</b>,<b>3</b>,<b>4</b>,<b>5</b>,<b>Q</b>,<b>W</b>,<b>E:</b> Handseals<br><b>Space:</b> Execute handseals<br><b>Arrows:</b> Move<br><b>F1 - F10:</b> Hotslots<br><b>R:</b> Recharge chakra<br><b>I:</b> Inventory<br><b>O:</b> Statpanel<br><b>P:</b> Jutsus<br>Press the <b>\[Enter]</b> key to talk. Type <i>/help</i> to view commands that can be spoken verbally.<br />","Action.Output")
		src << "Now speaking in channel: [src.client.channel]."

		src.client.StaffCheck()

		spawn() src.mob.UpdateWhoAll()

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
		new/obj/HotSlots/HotSlot11(src)
		new/obj/HotSlots/HotSlot12(src)
		new/obj/HotSlots/HotSlot13(src)
		new/obj/HotSlots/HotSlot14(src)
		new/obj/HotSlots/HotSlot15(src)
		new/obj/HotSlots/HotSlot16(src)
		new/obj/HotSlots/HotSlot17(src)
		new/obj/HotSlots/HotSlot18(src)
		var/obj/O=new/obj/Screen/healthbar
		var/obj/Mana=new/obj/Screen/manabar
		src.hbar.Add(O)
		src.hbar.Add(Mana)
		for(var/obj/Screen/healthbar/HB in src.hbar) src.overlays+=HB
		for(var/obj/Screen/manabar/HB in src.hbar) src.overlays+=HB
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

		if(src.equipped == "Weights")
			usr.overlays+='Weights.dmi'
			src.move_delay=1

		for(var/obj/Inventory/Clothing/C in src.contents)
			if(src.suffix == "(Equipped)")
				src.ClothingOverlays["[C.section]"] = C.icon

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