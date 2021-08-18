client
	mouse_pointer_icon='cursors.dmi'
	fps = 60
	var/tmp
		channel = "Local"
		logging_in = 0

	var/tmp/list
		skill_tree_objects = list()

	var
		last_mission

	New()
		..()
		clients_connected += src
		winset(src, null, {"
			Main.is-maximized=true
			Main.Child.right=Titlescreen;
			Main.OutputChild.is-visible=false;
			Main.ActionChild.is-visible=false;
			Main.NavigationChild.is-visible=false;
			Titlescreen.Child.left=Map;
			Character.is-visible=false;
			Inventory.is-visible=false;
			Jutsu.is-visible=false;
			SkillTree.is-visible=false;
			Settings.is-visible=false;
			Browser.is-visible=false;
			Leader.is-visible=false;
			Main.UnlockChild.is-visible = "false";
		"})

		src.Load()

		spawn() src.mob.Playtime()

	Del()
		src.mob.Save()
		src.Save()
		mobs_online -= src.mob
		clients_online -= src
		clients_connected -= src
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