mob
	proc
		DamageOverlay(damage, color, outline=1)
			var/obj/O = locate() in damage_number_pool
			if(O)
				damage_number_pool-=O
				O.loc=src.loc
			else
				O=new(src.loc)

			O.layer = EFFECTS_LAYER + 1
			O.maptext_width = 128
			O.maptext_height = 128
			O.pixel_y = 70
			O.pixel_x = (src.bound_width - O.maptext_width) / 2 + src.bound_x
			O.maptext = "<span style='-dm-text-outline: [outline]px black; color: [color]; font-weight: bold; text-align: center; vertical-align: bottom;'>[damage]</span>"
			O.alpha = 255

			sleep(1)
			animate(O, alpha = 0, pixel_y = 102, time = 5)

			spawn(15)
				O.loc=null
				damage_number_pool += O