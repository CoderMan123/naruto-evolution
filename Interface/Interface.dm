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

		ToggleInventoryPanel()
			set hidden=1
			if(winget(src, "MainWindow.InvenChild", "is-visible") == "false")
				winset(src, null, {"
					MainWindow.InvenChild.is-visible = "true";
				"})
				src.mob.RefreshInventory()

			else
				winset(src, null, {"
					MainWindow.InvenChild.is-visible = "false";
					Equip.ItemName.text="";
					Equip.ItemPic.image="";
				"})
				usr<<output("<center><font size = 2><font color=white><Body BGCOLOR = #2E2E2E>","ItemInfo")

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