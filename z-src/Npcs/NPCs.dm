obj/var/Colorable=1
mob/npc
	layer=MOB_LAYER
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