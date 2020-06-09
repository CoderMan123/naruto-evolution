mob
	proc
		DamageNumber(damage, color, outline=1)
			var/obj/O = locate() in damage_number_pool
			if(O)
				damage_number_pool-=O
				O.loc=src.loc
			else
				O=new(src.loc)

			O.layer = EFFECTS_LAYER
			O.maptext_width = 128
			O.maptext_height = 128
			O.pixel_y = 70
			O.pixel_x = (bound_width - maptext_width) / 2 + bound_x
			O.maptext = "<font color = [color]><b><font align=center valign=bottom>[damage]"
			O.alpha = 255

			sleep(7)
			animate(O, alpha = 0, pixel_y = 96, time = 5)
			spawn(15)
				O.loc=null
				damage_number_pool += O