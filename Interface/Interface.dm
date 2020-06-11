client
	var/tmp/input_child = 0
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

		ShowInputChild()
			set hidden=1
			if(src.input_child)
				winset(src, null, {"
					MainWindow.MapChild.focus = true;
					MainWindow.InputChild.is-visible = false;
				"})
				src.input_child = 0
			else
				winset(src, null, {"
					InputPanel.ChatInput.focus = true;
					MainWindow.InputChild.is-visible = true;
				"})
				src.input_child = 1