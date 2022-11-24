mob/var/savefile_version = 2

mob
	proc/Save()
		if(src.client && mobs_online.Find(src))
			var/savefile/F = new("[SAVEFILE_CHARACTERS]/[copytext(src.ckey, 1, 2)]/[src.ckey] ([lowertext(src.character)]).sav")
			if(src.Write(F, src.name)) return 1
			else return 0
		else return 0

	proc/Load(var/character, var/password)
		if(fexists("[SAVEFILE_CHARACTERS]/[copytext(src.ckey, 1, 2)]/[src.ckey] ([lowertext(character)]).sav.lk"))
			src.client.prompt("You cannot load this character because it is currently in use.")

			var/database/query/query = new({"
				INSERT INTO `[db_table_character_login]` (`timestamp`, `key`, `character`, `action`, `result`, `reason`)
				VALUES(?, ?, ?, ?, ?, ?)"},
				time2text(world.realtime, "YYYY-MM-DD hh:mm:ss"), src.client.ckey, character, "login", "failure", "character in use"
			)
			query.Execute(log_db)
			LogErrorDb(query)

			src.client.logging_in = 0
			return 0

		else
			if(fexists("[SAVEFILE_CHARACTERS]/[copytext(src.ckey, 1, 2)]/[src.ckey] ([lowertext(character)]).sav"))
				var/savefile/F = new("[SAVEFILE_CHARACTERS]/[copytext(src.ckey, 1, 2)]/[src.ckey] ([lowertext(character)]).sav")
				var/password_hash = sha1("[password][F["password_salt"]]")
				if(password_hash != F["password"])
					spawn() src.client.prompt("The character name or password you entered is incorrect.")

					var/database/query/query = new({"
						INSERT INTO `[db_table_character_login]` (`timestamp`, `key`, `character`, `action`, `result`, `reason`)
						VALUES(?, ?, ?, ?, ?, ?)"},
						time2text(world.realtime, "YYYY-MM-DD hh:mm:ss"), src.client.ckey, character, "login", "failure", "incorrect password"
					)
					query.Execute(log_db)
					LogErrorDb(query)

					src.client.logging_in = 0
					return 0
				else
					var/database/query/query = new({"
						INSERT INTO `[db_table_character_login]` (`timestamp`, `key`, `character`, `action`, `result`, `reason`)
						VALUES(?, ?, ?, ?, ?, ?)"},
						time2text(world.realtime, "YYYY-MM-DD hh:mm:ss"), src.client.ckey, character, "login", "success", null
					)
					query.Execute(log_db)
					LogErrorDb(query)
					
					if(src.Read(F, character, password)) return 1
					else return 0
			else
				var/character_found = 0
				for(var/directory in flist("[SAVEFILE_CHARACTERS]/"))
					for(var/savefile in flist("[SAVEFILE_CHARACTERS]/[directory]/"))
						if(findtext(savefile, character))
							character_found = 1

				if(character_found)
					spawn() src.client.prompt("The character you are trying access to not linked to your current BYOND account. Please login with the BYOND account that created this character.")
					
					var/database/query/query = new({"
						INSERT INTO `[db_table_character_login]` (`timestamp`, `key`, `character`, `action`, `result`, `reason`)
						VALUES(?, ?, ?, ?, ?, ?)"},
						time2text(world.realtime, "YYYY-MM-DD hh:mm:ss"), src.client.ckey, character, "login", "failure", "key mismatch"
					)
					query.Execute(log_db)
					LogErrorDb(query)

				else
					spawn() src.client.prompt("The character name or password you entered is incorrect.")

					var/database/query/query = new({"
						INSERT INTO `[db_table_character_login]` (`timestamp`, `key`, `character`, `action`, `result`, `reason`)
						VALUES(?, ?, ?, ?, ?, ?)"},
						time2text(world.realtime, "YYYY-MM-DD hh:mm:ss"), src.client.ckey, character, "login", "failure", "character not found"
					)
					query.Execute(log_db)
					LogErrorDb(query)

				src.client.logging_in = 0
				return 0
	
	verb/DeleteCharacter()
		set category = null
		if(src.client && mobs_online.Find(src))
			if(src.client.prompt("<font color = '[COLOR_VILLAGE_AKATSUKI]'>Character deletion is a permanent action!</font><br /><br />Are you sure you would like to delete your character: <u>[HTML_GetCharacter(src)]</u>?", "Character Deletion", list("Yes", "No")) == "Yes")
				var/list/prompt = src.client.iprompt("Please enter your character password to confirm character deletion.", "Character Deletion", list("Delete", "Cancel"), mask=1)
				if(prompt[1] == 1)
					var/verify_password = prompt[2]
					if(src.password == sha1("[verify_password][src.password_salt]"))

						src.Save()

						if(fcopy("[SAVEFILE_CHARACTERS]/[copytext(src.ckey, 1, 2)]/[src.ckey] ([lowertext(src.character)]).sav", "[SAVEFILE_CHARACTERS_ARCHIVE]/[copytext(src.ckey, 1, 2)]/[src.ckey] ([lowertext(src.character)]) - [time2text(world.realtime, "YYYY-MM-DD_hh-mm-ss")].sav"))

							if(fdel("[SAVEFILE_CHARACTERS]/[copytext(src.client.ckey, 1, 2)]/[src.client.ckey] ([lowertext(src.character)]).sav"))
								names_taken.Remove(lowertext(src.character))

								spawn(-1) src.client.prompt("Your character has been deleted successfully.")

								mobs_online -= src // Prevent character save on disconnect.

								var/database/query/query = new({"
									INSERT INTO `[db_table_character_creation]` (`timestamp`, `key`, `character`, `action`)
									VALUES(?, ?, ?, ?)"},
									time2text(world.realtime, "YYYY-MM-DD hh:mm:ss"), src.client.ckey, src.character, "delete"
								)
								query.Execute(log_db)
								LogErrorDb(query)

								del(src.client)

	proc/SavefileMigration()
		if(src.savefile_version < 2)
			src.health = 2500
			src.maxhealth = 2500
			src.chakra = 1800
			src.maxchakra = 1800
			src.statpoints = 0
			src.statpoints = 3*(src.level-1)
			src.savefile_version = 2
		
		if(src.savefile_version < 3)
			if(src.Specialist == "strength") src.Specialist = SPECIALIZATION_TAIJUTSU
			if(src.Specialist2 == "strength") src.Specialist2 = SPECIALIZATION_TAIJUTSU
			src.savefile_version = 3
		
/*		if(src.savefile_version < 4)
			do stuff
			src.savefile_version = 4*/

	Write(savefile/F, var/character)
		if(src.client)
			if(mobs_online.Find(src))
				if(character)
					src.last_online = world.realtime
					if(hokage[src.client.ckey]) kages_last_online[src.village] = src.last_online
					if(kazekage[src.client.ckey]) kages_last_online[src.village] = src.last_online

					var/list/exclude = list("icon", "icon_state", "overlays", "underlays", "alpha", "layer", "bound_width", "bound_height", "bound_x", "bound_y", "pixel_x", "pixel_y", "appearance_flags", "transform", "vis_contents", "filters", "view")
					for(var/v in src.vars)
						if(issaved(src.vars[v]))
							if(initial(src.vars[v]) == src.vars[v])
								F.dir.Remove(v)
							else if(exclude.Find(v))
								F.dir.Remove(v)
							else
								F[v] << src.vars[v]
						else
							F.dir.Remove(v)

					F["password_hotfix"] << src.password
					F["x"] << src.x
					F["y"] << src.y
					F["z"] << src.z

				else return 0
			else return 0
		else return 0
		..()


	Read(savefile/F, var/character, var/password)
		if(src.client)
			if(!mobs_online.Find(src))
				if(character)
					src.last_online = world.realtime
					if(hokage[src.client.ckey]) kages_last_online[src.village] = src.last_online
					if(kazekage[src.client.ckey]) kages_last_online[src.village] = src.last_online

					for(var/v in src.vars)
						if(issaved(src.vars[v]))
							if(!isnull(F[v]))
								F[v] >> src.vars[v]
							else
								F.dir.Remove(v)

					F["password_hotfix"] >> src.password
					
				else return 0
			else return 0
		else return 0
		..()

		src.SavefileMigration()

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

		if(global.hokage_election)
			src << output("A <font color = '[COLOR_VILLAGE_LEAF]'>[RANK_HOKAGE]</font> election is currently in-progress.", "Action.Output")
			
			if(global.hokage_ballot_open)
				src << output("The <font color = '[COLOR_VILLAGE_LEAF]'>[RANK_HOKAGE]</font> election is currently <u>open ballot</u>.", "Action.Output")
				src << output("You may nominate yourself at the <font color = '[COLOR_VILLAGE_LEAF]'>Leaf Ballot Secretary</font> in the <font color = '[COLOR_VILLAGE_LEAF]'>[RANK_HOKAGE]</font> house.", "Action.Output")
			
			src << output("Ninja from the <font color = '[COLOR_VILLAGE_LEAF]'>[VILLAGE_LEAF]</font> village may cast their vote at their ballot box in the <font color = '[COLOR_VILLAGE_LEAF]'>[RANK_HOKAGE]</font> house.", "Action.Output")
		
		if(global.kazekage_election)
			src << output("A <font color = '[COLOR_VILLAGE_SAND]'>[RANK_KAZEKAGE]</font> election is currently in-progress.", "Action.Output")
			
			if(global.kazekage_ballot_open)
				src << output("The <font color = '[COLOR_VILLAGE_SAND]'>[RANK_KAZEKAGE]</font> election is currently <u>open ballot</u>.", "Action.Output")
				src << output("You may nominate yourself at the <font color = '[COLOR_VILLAGE_SAND]'>Sand Ballot Secretary</font> in the <font color = '[COLOR_VILLAGE_SAND]'>[RANK_KAZEKAGE]</font> house.", "Action.Output")
			
			src << output("Ninja from the <font color = '[COLOR_VILLAGE_SAND]'>[VILLAGE_SAND]</font> village may cast their vote at their ballot box in the <font color = '[COLOR_VILLAGE_SAND]'>[RANK_KAZEKAGE]</font> house.", "Action.Output")
		
		world.UpdateVillageCount()
		
		spawn() src.client.UpdateWhoAll()

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

		for(var/obj/Screen/WeaponSelect/H in src.client.screen)
			switch(src.equipped)
				if("Kunais") H.icon_state="kunai"
				if("ExplodeKunais") H.icon_state="expl kunai"
				if("Shurikens") H.icon_state="shuriken"
				if("Needles") H.icon_state="needle"
				if("ExplosiveTags") H.icon_state="tag"
				if("SmokeBombs") H.icon_state="SmokeBombs"
				if("FoodPill") H.icon_state="Blood Pill"
				
		spawn() src.UpdateHMB()
		spawn() src.UpdateSlots()
		spawn() src.client.FlashExperienceLock()

		for(var/jutsu in src.jutsus) if(isnull(jutsu)) src.jutsus -= jutsu
		for(var/jutsu in src.jutsus_learned) if(isnull(jutsu)) src.jutsus_learned -= jutsu
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

		src.density=1
		src.sight=0
		src.invisibility=0

		if(!src.loc)
			if(src.Tutorial==7) src.loc=src.MapLoadSpawn()
			else src.loc=locate(39,158,14)

		if(src.dead)
			src.loc=src.MapLoadSpawn()
			src.density=1
			src.health=src.maxhealth
			src.chakra=src.maxchakra
			src.dead=0
			src.icon_state=""
			src.wait=0
			src.rest=0
			src.dodge=0
			src.overlays=0