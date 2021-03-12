client
	verb
		ChangeChannel()
			set hidden=1
			switch(src.channel)
				if("Local")
					src.channel = "Village"

				if("Village")
					if(src.mob.Squad) src.channel = "Squad"
					else if(src.mob.Faction) src.channel = "Faction"
					else src.channel = "Global"

				if("Squad")
					if(src.mob.Faction) src.channel = "Faction"
					else src.channel = "Global"

				if("Faction")
					src.channel ="Global"

				if("Global")
					src.channel ="Local"

				else
					src.channel = "Local"
			src<<"Now speaking in: [src.channel]"

		ToggleChatInputPanel()
			set hidden=1
			if(src.mob.Muted)
				src.Alert("You can't chat while muted.")
				return

			else if(winget(src, "MainWindow.InputChild", "is-visible") == "false")
				winset(src, null, {"
					InputPanel.ChatInput.focus = "true";
					MainWindow.InputChild.is-visible = "true";
				"})
			else
				winset(src, null, {"
					MainWindow.InputChild.is-visible = "false";
					MainWindow.MapChild.focus = "true";
				"})

		ToggleChatOutputPanel()
			set hidden=1
			if(winget(src, "MainWindow.OutputChild", "is-visible") == "false")
				winset(src, null, {"
					MainWindow.OutputChild.focus = "true";
					MainWindow.OutputChild.is-visible = "true";
				"})
			else
				winset(src, null, {"
					MainWindow.OutputChild.focus = "false";
					MainWindow.OutputChild.is-visible = "false";
				"})

		ToggleCharacterPanel()
			set hidden=1
			if(winget(src, "Character", "is-visible") == "false")
				winset(src, "Character", "is-visible=true")
				src.UpdateCharacterPanel()

			else
				winset(src, "Character", "is-visible=false")


		ToggleInventoryPanel()
			set hidden=1
			if(winget(src, "InventoryWindow", "is-visible") == "false")
				winset(src, "InventoryWindow", "is-visible=true")
				src.UpdateInventoryPanel()

			else
				winset(src, null, {"
					InventoryWindow.EquippedName.text=""
					InventoryWindow.EquippedImage.image=""
					InventoryWindow.is-visible=false
				"})
				usr<<output("<center>","InventoryWindow.EquippedItemInfo")

		ToggleSettingsPanel()
			set hidden=1
			if(winget(src, "SettingsWindow", "is-visible") == "false")
				winset(src, null, {"
					SettingsWindow.is-visible = "true";
				"})
			else
				winset(src, null, {"
					SettingsWindow.is-visible = "false";
				"})

		ToggleLeaderPanel()
			set hidden=1
			if(winget(src, "LeaderWindow", "is-visible") == "false")
				winset(src, null, {"
					LeaderWindow.is-visible = "true";
				"})
			else
				winset(src, null, {"
					LeaderWindow.is-visible = "false";
				"})

	proc
		UpdateCharacterPanel()
			winset(src, null, {"
				Character.Avatar.image     = "\icon[src.mob.icon]"
				Character.Name.text        = "[src.mob.name]"
				Character.Level.text       = "[src.mob.level]"
				Character.EXP.text         = "[src.mob.exp]/[src.mob.maxexp]"
				Character.EXPBar.value     = "[round(src.mob.exp/src.mob.maxexp*100)]"
				Character.Health.text      = "[src.mob.health]/[src.mob.maxhealth]"
				Character.HealthBar.value  = "[round(src.mob.health/src.mob.maxhealth*100)]"
				Character.Chakra.text      = "[src.mob.chakra]/[src.mob.maxchakra]"
				Character.ChakraBar.value  = "[round(src.mob.chakra/src.mob.maxchakra*100)]"
				Character.Def.text         = "[src.mob.defence]"
				Character.DefEXP.text      = "[src.mob.defexp]/[src.mob.maxdefexp]"
				Character.DefEXPBar.value  = "[round(src.mob.defexp/src.mob.maxdefexp*100)]"
				Character.Agi.text         = "[src.mob.agility]"
				Character.AgiEXP.text      = "[src.mob.agilityexp]/[src.mob.maxagilityexp]"
				Character.AgiEXPBar.value  = "[round(src.mob.agilityexp/src.mob.maxagilityexp*100)]"
				Character.Tai.text         = "[src.mob.strength]"
				Character.TaiEXP.text      = "[src.mob.strengthexp]/[src.mob.maxstrengthexp]"
				Character.TaiEXPBar.value  = "[round(src.mob.strengthexp/src.mob.maxstrengthexp*100)]"
				Character.Nin.text         = "[src.mob.ninjutsu]"
				Character.NinEXP.text      = "[src.mob.ninexp]/[src.mob.maxninexp]"
				Character.NinEXPBar.value  = "[round(src.mob.ninexp/src.mob.maxninexp*100)]"
				Character.Gen.text         = "[src.mob.genjutsu]"
				Character.GenEXP.text      = "[src.mob.genexp]/[src.mob.maxgenexp]"
				Character.GenEXPBar.value  = "[round(src.mob.genexp/src.mob.maxgenexp*100)]"
				Character.StatPoints.text  = "[src.mob.statpoints]"
				Character.SkillPoints.text = "[src.mob.skillpoints]"
			"})

		UpdateInventoryPanel()
			set hidden=1
			winset(src,"InventoryWindow.Ryo","text=\"両 [src.mob.Ryo]\"")
			winset(src,"InventoryWindow.Titlebar","text=\"Inventory - [src.mob.items]/[src.mob.maxitems]\"")
			winset(src,"InventoryWindow.Grid","cells=0x0")
			var/Row = 1
		//	src<<output("Ryo:","Equip.GridEquip:1,1")
		//	src<<output("Items:","Equip.GridEquip:1,2")
		//	src<<output("[src.items]/[src.maxitems]","Equip.GridEquip:2,2")
			src<<output(" ","InventoryWindow.Grid:1,1")
			for(var/obj/O in src.mob.contents)
				Row++
				src << output(O,"InventoryWindow.Grid:1,[Row]")
				src << output("<span style='text-align: right;'>[O.suffix]</span>","InventoryWindow.Grid:2,[Row]")
			sleep(40)