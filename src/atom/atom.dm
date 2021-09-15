atom
	var/name_color
	var/name_color_custom
	var/tmp/list/name_overlays = list()

	proc
		SetName(var/Name, var/Color = src.name_color_custom, var/Outline = 1)
			if(Name)
				src.name = Name
				if(istype(src, /mob))
					var/mob/m = src

					m.name = Name
					m.rname = Name

				if(src.name_overlays)
					src.overlays -= src.name_overlays
					src.name_overlays = null

				if(!Color)
					if(istype(src, /mob))
						var/mob/m = src

						if(!m.client) Color = "white"
						if(!m.village) Color = "white"
						else
							switch(m.village)
								if(VILLAGE_LEAF) Color = "#2b7154"
								if(VILLAGE_SAND) Color = "#886541"
								if(VILLAGE_MISSING_NIN) Color = "white"
								if(VILLAGE_AKATSUKI) Color = "#971e1e"
						
						m.name_color = Color

					else
						Color = "white"

				var/obj/name = new()
				name.layer = 10001
				name.maptext_width = 256
				name.pixel_x = name.pixel_x - (name.maptext_width / 2) + ((src.pixel_x * 2) * -1)

				if(istype(src, /mob))
					name.pixel_y -= 16

				if(istype(src, /obj/HotSlots))
					name.pixel_x = name.pixel_x + 1
					name.pixel_y += 8
				
				if(istype(src, /obj/HotSlots))
					name.maptext = "<span style=\"-dm-text-outline: [Outline]px black; color: [Color]; font-family: 'Open Sans'; font-size: 8px; font-weight: bold; text-align: center; vertical-align: bottom;\">[Name]</span>"
				else
					name.maptext = "<span style=\"-dm-text-outline: [Outline]px black; color: [Color]; font-family: 'Open Sans'; font-weight: bold; text-align: center; vertical-align: bottom;\">[Name]</span>"
				src.name_overlays = image(name, src)
				src.overlays += src.name_overlays