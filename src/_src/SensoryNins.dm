mob/NPC/SensoryNin//sensory
	name = "Sensory ninja"
	icon='WhiteMBase.dmi'
	pixel_x=-15
	village="Hidden Leaf"
	density=1
	Move()return
	Death()return
	NewStuff()
		if(src.village=="Hidden Leaf")
			src.icon='Leaf Sensory.dmi'
			src.name="Reevo"
		if(src.village=="Hidden Sand")
			src.icon='Sand Sensory.dmi'
			src.name="Shiza"
		if(src.village=="Hidden Mist")
			src.icon='Teshou-Mist Sensory.dmi'
			src.name="Teshou"
		if(src.village=="Hidden Sound")
			src.icon='Miya-Sound Sensory.dmi'
			src.name="Miya"
		if(src.village=="Hidden Rock")
			src.icon='Akatsuchi-Rock Sensory.dmi'
			src.name="Akatsuchi"
		src.Name(name)
		OriginalOverlays=overlays.Copy()
	DblClick()
		if(usr.dead) return
		if(get_dist(src,usr)>2) return
		var/obj/telewhere=usr.CustomInput("Teleport","Hello there. What village would you like to go to?",list("Hidden Leaf","Hidden Sand","Hidden Mist","Hidden Sound","Hidden Rock"))
		if(!usr) return
		switch(telewhere.name)
		/*	if(telewhere=src.village)
				usr<<output("You're already in this village.","Action.Output") // Couldn't get this to fucking work
				return */
			if("Hidden Leaf")
				usr.loc=locate(188,86,2)
			if("Hidden Sand")
				usr.loc=locate(130,94,13)
			if("Hidden Mist")
				usr.loc=locate(65,84,20)
			if("Hidden Sound")
				usr.loc=locate(149,29,9)
			if("Hidden Rock")
				usr.loc=locate(167,158,16)
