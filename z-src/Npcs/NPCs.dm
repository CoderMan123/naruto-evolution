obj/var/Colorable=1
mob/npc
	layer=MOB_LAYER
	move=0
	var/list/OriginalOverlays=list()

	Hair_Stylist
		name="Barber"
		icon='WhiteMBase.dmi'
		density=0
		pixel_x=-15
		New()
			src.overlays += pick('Short.dmi','Short2.dmi','Short3.dmi')
			src.overlays += 'Shirt.dmi'
			src.overlays += 'Sandals.dmi'

			OriginalOverlays = overlays.Copy()

			spawn() RestoreOverlays()
			..()

		DblClick()
			if(usr.dead) return
			if(get_dist(src,usr)>2) return
			usr.HairStyle = usr.client.prompt("Hair Options","Please choose a hair.",list("Long","Short","Tied Back","Bald","Bowl Cut","Deidara","Spikey","Mohawk","Neji Hair","Distance"))

			if(usr.HairStyle != "Bald")
				usr.HairColor = usr.client.cprompt("Please select a hairstyle dye.", "Hairstyle Dye", luminosity_max = 20)

			usr.HairColorStyle=null
			usr.RestoreOverlays()

	Clothier
		icon='WhiteMBase.dmi'
		pixel_x=-15
		density=0
		New()
			src.overlays += pick('Short.dmi','Short2.dmi','Short3.dmi')
			src.overlays += 'Shirt.dmi'
			src.overlays += 'Sandals.dmi'

			OriginalOverlays=overlays.Copy()

			spawn() src.RestoreOverlays()
			..()

		DblClick()
			if(usr.dead) return
			if(get_dist(src,usr)>2) return
			if(usr.maxitems > -1 && usr.contents.len >= usr.maxitems)
				usr<<output("This would exceed your amount of avaliable items.","Action.Output")
				return
			usr.move=0
			var/list/Options=list()
			for(var/obj/Inventory/Clothing/C in world)
				if(C.loc==locate(199,199,9)) Options["[C.name]-[C.Cost] Ryo"]=C
			var/obj/Choice = usr.CustomInput("Purchase","What would you like to purchase?",Options + "Cancel",0)
			if(Choice.name=="Cancel")
				usr.move=1
				return
			var/obj/S = Options["[Choice]"]
			if(usr.ryo>=S.Cost)
				var/obj/I=new S.type()
				if(I.Colorable)
					var/list/Colors=usr.ColorInput("What colour would you like the [I] to be?")
					var/icon/X=new(I.icon)
					X.Blend(rgb(text2num(Colors[1]),text2num(Colors[2]),text2num(Colors[3])),ICON_ADD)
					I.icon=X
					I.cColor = rgb(text2num(Colors[1]),text2num(Colors[2]),text2num(Colors[3]))
				usr.RecieveItem(I, src)
				usr.client.UpdateInventoryPanel()
				usr<<output("You bought the [S.name] for [S.Cost] Ryo.","Action.Output")
				usr.ryo-=S.Cost
				usr.move=1
			else
				usr.move=1
				usr<<output("You need [S.Cost] Ryo to purchase this.","Action.Output")
				return
				//obj/Inventory/Clothing/Vests/Robe
