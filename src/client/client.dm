client
	mouse_pointer_icon='cursors.dmi'
	fps = 60
	var/tmp
		map_resolution_x
		map_resolution_y

		channel = "Local"
		logging_in = 0
		browser_url = BROWSER_NONE

	var/tmp/list
		skill_tree_objects = list()

	var
		last_mission 	

	New()
		..()
		src.mob.loc = null
		clients_connected += src
		winset(src, null, {"
			Main.is-maximized=true;
			Main.Child.right=Titlescreen;
			Main.OutputChild.is-visible=false;
			Main.ActionChild.is-visible=false;
			Main.NavigationChild.is-visible=false;
			Main.ReconnectChild.is-visible=false;
			Titlescreen.Child.left=Map;
			Character.is-visible=false;
			Inventory.is-visible=false;
			Jutsu.is-visible=false;
			SkillTree.is-visible=false;
			Settings.is-visible=false;
			Settings-General.Administration.is-visible = 'false';
			Browser.is-visible=false;
			Leader.is-visible=false;
			Main.UnlockChild.is-visible = "false";
		"})

		src.GetScreenResolution()

		world.UpdateClientsMultikeying()

		spawn() src.UpdateWhoAll()

		src.Load()
		spawn() src.mob.Playtime()

		spawn() src.BrowserRefresh()

		if(findtext(lowertext(build), "alpha"))
			if(!administrators.Find(src.ckey) && !alpha_testers.Find(src.ckey))
				spawn() src.prompt("You do not have authorization to access the alpha server. If this is in error, please contact support.<br /><br />support@narutoevolution.com", "Alpha Server: Access Authorization")
				sleep(10)
				del(src)

		else if(findtext(lowertext(build), "beta"))
			if(!administrators.Find(src.ckey) && !beta_testers.Find(src.ckey))
				spawn() src.prompt("You do not have authorization to access the beta server. If this is in error, please contact support.<br /><br />support@narutoevolution.com", "Beta Server: Access Authorization")
				sleep(10)
				del(src)

		for(var/client/source in clients_connected)
			for(var/client/target in clients_connected)
				if(source != target)
					if(administrators.Find(source.ckey) || administrators.Find(target.ckey)) continue
					if(source.computer_id == target.computer_id)
						spawn() src.prompt("Running multiple clients isn't allowed on this server. Please logout of your other character before proceeding to login. Your connection to the server has been terminated.")
						sleep(10)
						del(src)

	Del()
		src.mob.LogoutCharacter()
		src.mob.Save()
		mobs_online -= src.mob

		src.Save()
		clients_online -= src
		clients_connected -= src

		world.UpdateClientsMultikeying()

		world.UpdateVillageCount()
		
		src.UpdateWhoAll()

		winset(src, null, {"
			Main.ReconnectChild.is-visible=true;
		"})

		src << output("You have been disconnected from the server.", "Reconnect.Message")
		..()

	Topic(href, href_list)
		if(href_list["changelog"] && href_list["changelog"] == "current")
			src << browse("[CHANGELOG]")
			winset(src, "Browser", "is-visible = 'true'")

		else if(href_list["changelog"] && href_list["changelog"] == "previous")
			src << browse("[CHANGELOG_PREVIOUS]")
			winset(src, "Browser", "is-visible = 'true'")
		..()

	verb
		Tab()
			set hidden=1
			world << winget(src, null, "focus")