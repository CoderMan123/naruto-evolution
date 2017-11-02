mob
	var
		HairStyle
		HairColorRed
		HairColorBlue
		HairColorGreen


mob/proc
	RestoreOverlays()

		src.overlays=null
		src.overlays+=/obj/MaleParts/UnderShade
	//	var/n = input("Color?")as color
	//	var/icon/I = new(icon,icon_state)
	//	I.Blend(n, ICON_ADD)
	//	src.icon = I
		mouse_over_pointer=image('VillageSymbols.dmi',"[village]")
	/*	switch(village)
			if("Hidden Leaf")
				var/image/I=image('VillageSymbols.dmi',"Hidden Leaf")
				I.pixel_y=32
				overlays+=I
			if("Hidden Sand")
				var/image/I=image('VillageSymbols.dmi',"Hidden Sand")
				I.pixel_y=32
				overlays+=I
			if("Hidden Sand")
				var/image/I=image('VillageSymbols.dmi',"Hidden Sand")
				I.pixel_y=32
				overlays+=I*/
		src.ReAddClothing()
		src.Name(src.name)
obj
	HairStyles
		mouse_opacity=2
		Click()
			if(!usr.HairStyle)
				var/obj/Hair=new
				Hair.layer=HAIR_LAYER
				Hair.icon=src.icon
				usr.HairStyle=Hair
				usr.overlays+=Hair
			else
				usr.overlays=0
				usr.HairStyle=null
				usr.UpdateHMB()
				usr.Name(usr.name)
				usr.RestoreOverlays()
		Short1
			icon='Short.dmi'
			name="Short1"
		Short2
			icon='Short2.dmi'
			name="Short2"
		Short3
			icon='Short3.dmi'
			name="Short3"
		Long
			icon='Long.dmi'
			name="Long"
		Bald
			icon='Misc Effects.dmi'
			icon_state="jutsuwait4"
