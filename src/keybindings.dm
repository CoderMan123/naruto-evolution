client
	verb
		keybind_release(input as text)
			set instant = 1
			set hidden = 1
			src.keys_held -= input

			if(hotkey_restup == input) src.mob.RestUp()

		keybind_call(input as text)
			set instant = 1
			set hidden = 1

			if(!(input in keys_held))
				src.keys_held += input

			if(input == "Shift") return
			if(input == "Alt") return
			if(input == "Ctrl") return

			if("Shift" in keys_held) input = "Shift+[input]"
			if("Ctrl" in keys_held) input = "Ctrl+[input]"
			if("Alt" in keys_held) input = "Alt+[input]"

			if(setting_keybind)
				new_key = input
				setting_keybind = null
				return

			sleep(world.tick_lag)

			if(hotkey_walk_n == input)
				src.North()
				if(input in keys_held) src.keybind_call(input)
				return

			else if(hotkey_walk_s == input)
				src.South()
				if(input in keys_held) src.keybind_call(input)
				return

			else if(hotkey_walk_e == input)
				src.East()
				if(input in keys_held) src.keybind_call(input)
				return

			else if(hotkey_walk_w == input)
				src.West()
				if(input in keys_held) src.keybind_call(input)
				return

			else if(hotkey_basic_attack == input) 
				src.mob.Basic_Attack()
				if(input in keys_held) src.keybind_call(input)
				return
			
			else if(hotkey_dodge == input)
				src.mob.Dodge()
				if(input in keys_held) src.keybind_call(input)
				return

			else if(hotkey_rest == input) 													src.mob.Rest()
			else if(hotkey_restup == input) 												src.mob.RestUp()

			else if(hotkey_throwmob == input) 												src.mob.ThrowMob()
			else if(hotkey_throw == input) 													src.mob.Throw()
			else if(hotkey_pickup == input) 												src.mob.Pickup()
			else if(hotkey_rotate_ninja_tool == input) 										src.mob.Rotate_Ninja_Tool()

			else if(hotkey_target_a_mob == input) 											src.mob.Target_A_Mob()
			else if(hotkey_target_an_ally == input) 										src.mob.Target_An_Ally()
			else if(hotkey_untarget_pplz == input) 											src.mob.Untarget_pplz()

			else if(hotkey_hotslot1 == input) 												src.mob.HotSlot1()
			else if(hotkey_hotslot2 == input) 												src.mob.HotSlot2()
			else if(hotkey_hotslot3 == input) 												src.mob.HotSlot3()
			else if(hotkey_hotslot4 == input) 												src.mob.HotSlot4()
			else if(hotkey_hotslot5 == input) 												src.mob.HotSlot5()
			else if(hotkey_hotslot6 == input) 												src.mob.HotSlot6()
			else if(hotkey_hotslot7 == input) 												src.mob.HotSlot7()
			else if(hotkey_hotslot8 == input) 												src.mob.HotSlot8()
			else if(hotkey_hotslot9 == input) 												src.mob.HotSlot9()
			else if(hotkey_hotslot10 == input) 												src.mob.HotSlot10()
			else if(hotkey_hotslot11 == input) 												src.mob.HotSlot11()
			else if(hotkey_hotslot12 == input) 												src.mob.HotSlot12()
			else if(hotkey_hotslot13 == input) 												src.mob.HotSlot13()
			else if(hotkey_hotslot14 == input)												src.mob.HotSlot14()
			else if(hotkey_hotslot15 == input) 												src.mob.HotSlot15()
			else if(hotkey_hotslot16 == input) 												src.mob.HotSlot16()
			else if(hotkey_hotslot17 == input) 												src.mob.HotSlot17()
			else if(hotkey_hotslot18 == input) 												src.mob.HotSlot18()

			else if(hotkey_handsealactivate == input) 										src.mob.HandSealActivate()
			else if(hotkey_handseal_rat == input) 											src.mob.HandSeal("rat")
			else if(hotkey_handseal_snk == input) 											src.mob.HandSeal("snake")
			else if(hotkey_handseal_hrs == input) 											src.mob.HandSeal("horse")
			else if(hotkey_handseal_mky == input) 											src.mob.HandSeal("monkey")
			else if(hotkey_handseal_drg == input) 											src.mob.HandSeal("dragon")
			else if(hotkey_handseal_dog == input) 											src.mob.HandSeal("dog")
			else if(hotkey_handseal_rbt == input) 											src.mob.HandSeal("rabbit")
			else if(hotkey_handseal_ox == input) 											src.mob.HandSeal("ox")

			else if(hotkey_panel_chatinput == input)										src.ToggleChatInputPanel()
			else if(hotkey_panel_options == input)											src.ToggleSettingsPanel()
			else if(hotkey_panel_inventory == input) 										src.ToggleInventoryPanel()
			else if(hotkey_panel_stats == input)											src.ToggleCharacterPanel()
			else if(hotkey_panel_jutsu == input) 											src.ToggleJutsuPanel()

			else if(hotkey_puppetgrab1 == input) 											src.mob.puppetgrab1()
			else if(hotkey_puppetgrab2 == input) 											src.mob.puppetgrab2()
			else if(hotkey_puppetshoot1 == input) 											src.mob.puppetshoot1()
			else if(hotkey_puppetshoot2 == input) 											src.mob.puppetshoot2()
			else if(hotkey_puppetdash1 == input) 											src.mob.puppetdash1()
			else if(hotkey_puppetdash2 == input) 											src.mob.puppetdash2()
			else if(hotkey_puppet1north == input) 											src.mob.puppet1north()
			else if(hotkey_puppet2north == input) 											src.mob.puppet2north()
			else if(hotkey_puppet1south == input) 											src.mob.puppet1south()
			else if(hotkey_puppet2south == input) 											src.mob.puppet2south()
			else if(hotkey_puppet1east == input) 											src.mob.puppet1east()
			else if(hotkey_puppet2east == input) 											src.mob.puppet2east()
			else if(hotkey_puppet1west == input) 											src.mob.puppet1west()
			else if(hotkey_puppet2west == input) 											src.mob.puppet2west()


			else return null

		/*keybinds to exclude:
			SHIFT+Return

		special exceptions

		/mob/verb/Rest
		/mob/verb/RestUp

		HandSeal() line 103 NewSeals.dm
		*/


	var
		tmp/setting_keybind
		tmp/new_key

		tmp/keys_held = list()

		hotkey_panel_chatinput = "Return"
		hotkey_panel_options = "Escape"
		hotkey_panel_inventory = "I"
		hotkey_panel_stats = "O"
		hotkey_panel_jutsu = "P"

		hotkey_walk_n = "North"
		hotkey_walk_s = "South"
		hotkey_walk_e = "East"
		hotkey_walk_w = "West"

		hotkey_hotslot1 = "Z"
		hotkey_hotslot2	= "X"
		hotkey_hotslot3 = "C"
		hotkey_hotslot4 = "V"
		hotkey_hotslot5 = "B"
		hotkey_hotslot6 = "N"
		hotkey_hotslot7 = "F7"
		hotkey_hotslot8 = "F8"
		hotkey_hotslot9 = "F9"
		hotkey_hotslot10 = "F10"
		hotkey_hotslot11 = "F11"
		hotkey_hotslot12 = "F12"
		hotkey_hotslot13 = "F1"
		hotkey_hotslot14 = "F2"
		hotkey_hotslot15 = "F3"
		hotkey_hotslot16 = "F4"
		hotkey_hotslot17 = "F5"
		hotkey_hotslot18 = "F6"

		hotkey_handsealactivate = "Space"
		hotkey_handseal_rat = "Q"
		hotkey_handseal_ox = "W"
		hotkey_handseal_dog = "E"
		hotkey_handseal_rbt = "1"
		hotkey_handseal_snk = "2"
		hotkey_handseal_hrs = "3"
		hotkey_handseal_mky = "4"
		hotkey_handseal_drg = "5"
		
		hotkey_puppetgrab1 = "Ctrl+S"
		hotkey_puppetgrab2 = "Alt+S"
		hotkey_puppetshoot1 = "Ctrl+A"
		hotkey_puppetshoot2 = "Alt+A"
		hotkey_puppetdash1 = "Ctrl+D"
		hotkey_puppetdash2 = "Alt+A"
		hotkey_puppet1north = "Ctrl+North"
		hotkey_puppet2north = "Alt+North"
		hotkey_puppet1south = "Ctrl+South"
		hotkey_puppet2south = "Alt+South"
		hotkey_puppet1east = "Ctrl+East"
		hotkey_puppet2east = "Alt+East"
		hotkey_puppet1west = "Ctrl+West"
		hotkey_puppet2west = "Alt+West"

		hotkey_basic_attack = "A"
		hotkey_throwmob = "F"
		hotkey_dodge = "D"
		hotkey_throw = "S"
		hotkey_pickup = "G"
		hotkey_rotate_ninja_tool = "Shift+S"

		hotkey_rest = "R"
		hotkey_restup = "R" //make sure this one automatically updates with rest

		hotkey_target_a_mob = "Tab"
		hotkey_target_an_ally = "Shift+Tab"
		hotkey_untarget_pplz = "Ctrl+Tab"
