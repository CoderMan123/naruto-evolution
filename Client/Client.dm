client
	var/tmp/channel = "Local"
	New()
		..()

	Topic(href, href_list)
		if(href_list["changelog"] && href_list["changelog"] == "current")
			src << browse("[CHANGELOG]")
			winset(src, "BrowserWindow", "is-visible = 'true'")

		else if(href_list["changelog"] && href_list["changelog"] == "previous")
			src << browse("[CHANGELOG_PREVIOUS]")
			winset(src, "BrowserWindow", "is-visible = 'true'")
		..()

	verb
		Tab()
			set hidden=1
			world << winget(src, null, "focus")