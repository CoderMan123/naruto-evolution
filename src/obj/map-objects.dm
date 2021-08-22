obj
	mechanical_blocks
		opaque_block
			icon = 'placeholdertiles.dmi'
			icon_state = "opaque"
			opacity = 1
			density = 1
			New()
				..()
				icon_state = "black"
	akat_entrance
		icon = 'akat-entrance.dmi'
		bound_width = 96
		pixel_x = -32

		Crossed()
			if(usr.village == VILLAGE_AKATSUKI)
				usr.loc = locate(51,149,7)
			else
				usr<<output("A strange and powerful seal blocks this cave, it could only be the work of the Akatsuki!","Action.Output")

	desert_objects
		cactus
			icon = 'desert-objects.dmi'
			icon_state = "cactus"
		buck_skull
			icon = 'desert-objects.dmi'
			icon_state = "buckskull"
		bone
			icon = 'desert-objects.dmi'
			icon_state = "bone"

	capture_banner
		icon = 'Signs.dmi'
		icon_state = "blank"
		density = 1

turf
	akat_exit
		Entered()
			usr.loc = locate(100,161,5)
			..()