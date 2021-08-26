var
	list/Hairstyles = list("Long" = 'Long.dmi',"Short" = 'Short.dmi',"Tied Back" = 'Short2.dmi',"Bald","Bowl Cut" = 'Short3.dmi',"Deidara" = 'Deidara.dmi',"Spikey" = 'Spikey.dmi',"Mohawk" = 'Mohawk.dmi',"Neji Hair" = 'Neji Hair.dmi',"Distance" = 'Distance.dmi')

mob
	var
		HairStyle
		HairColorRed
		HairColorBlue
		HairColorGreen
		Genderswag
		skintoneswag


mob/proc
	RestoreOverlays()

		src.overlays=null
		src.overlays+=/obj/MaleParts/UnderShade
	//	var/n = input("Color?")as color
	//	var/icon/I = new(icon,icon_state)
	//	I.Blend(n, ICON_ADD)
	//	src.icon = I
	//	mouse_over_pointer=image('VillageSymbols.dmi',"[village]") Doesn't work on new clients. Removed
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
		if(src.equipped=="Samehada")
			src.overlays+=/obj/Inventory/Weaponry/Samehada
//		if((src.equipped!="Samehada")
		//	src.overlays-=/obj/Inventory/Weaponry/Samehada
		if(src.equipped=="Kubikiribocho")
			src.overlays+=/obj/Inventory/Weaponry/Zabuza_Sword
//		if((src.equipped!="Kubikiribocho")
//			src.overlays-=/obj/Inventory/Weaponry/Kubikiribocho
		if(src.equipped=="Hiramekarei")
			src.overlays+=/obj/Inventory/Weaponry/Hiramekarei
//		if((src.equipped!="Hiramekarei")
//			src.overlays-=/obj/Inventory/Weaponry/Hiramekarei
		if(src.equipped=="Kabuto Wari")
			src.overlays+=/obj/Inventory/Weaponry/Kabutowari
//		if((src.equipped!="Kabuto Wari")
//			src.overlays-=/obj/Inventory/Weaponry/Kabutowari
		if(src.equipped=="Kiba")
			src.overlays+=/obj/Inventory/Weaponry/Kiba
//		if((src.equipped!="Kiba")
//			src.overlays-=/obj/Inventory/Weaponry/Kiba
		if(src.equipped=="Nuibari")
			src.overlays+=/obj/Inventory/Weaponry/Nuibari
//		if((src.equipped!="Nuibari")
//			src.overlays-=/obj/Inventory/Weaponry/Nuibari
		if(src.equipped=="Shibuki")
			src.overlays+=/obj/Inventory/Weaponry/Shibuki
//		if((src.equipped!="Shibuki")
//			src.overlays-=/obj/Inventory/Weaponry/Shibuki
		if(src.equipped=="Dark Sword")
			src.overlays+=/obj/Inventory/Weaponry/DarkSword
//		if(src.equipped!="Dark Sword")
//			src.overlays-=/obj/Inventory/Weaponry/DarkSword
		if(src.equipped=="Weights")
			src.overlays+=/obj/Inventory/Weaponry/Weights
//		if(src.equipped!="Weights")
//			src.overlays-=/obj/Inventory/Weaponry/Weights
		if(src.inAngel==1)
			src.overlays+='Angel Wings.dmi'
		if(src.inAngel==0)
			src.overlays-='Angel Wings.dmi'
		src.ReAddClothing()
		src.SetName(src.name)

obj
	HairStyles
		var
			Style
		mouse_opacity=2
		Click()
			if(!usr.HairStyle)
				var/obj/Hair=new
				Hair.layer=HAIR_LAYER
				Hair.icon=src.icon
				usr.HairStyle= Hairstyles[Style]
				usr.overlays+=Hair
			else
				usr.overlays=0
				usr.HairStyle=null
				usr.UpdateHMB()
				usr.SetName(usr.name)
				usr.RestoreOverlays()
		Short1
			icon='Short.dmi'
			name="Short1"
			Style = "Short"
		Short2
			icon='Short2.dmi'
			name="Short2"
			Style = "Tied Back"
		Short3
			icon='Short3.dmi'
			name="Short3"
			Style = "Bowl Cut"
		Long
			icon='Long.dmi'
			name="Long"
			Style = "Long"
		Deidara
			icon='Deidara.dmi'
			name="Deidara Cut"
			Style = "Deidara"
		Bald
			icon='Misc Effects.dmi'
			icon_state="jutsuwait4"
			Style = "Bald"
