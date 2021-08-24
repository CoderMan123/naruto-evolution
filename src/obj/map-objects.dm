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

	skill_tree_locations
		icon = 'placeholdertiles.dmi'
		icon_state = "skilltree"

		var/instance_radius = 0 // Radius for screen instancing of the skill tree
		New()
			..()
			icon_state = "blank"
		noclan_ninspec
			instance_radius = 5

		noclan_strspec
			instance_radius = 5

		noclan_genspec
			instance_radius = 5

		elemental
			instance_radius = 6

		clan_noclan
			instance_radius = 5

		clan_aburame
			instance_radius = 4

		clan_akimichi
			instance_radius = 4

		clan_bubble
			instance_radius = 4

		clan_clay
			instance_radius = 4

		clan_crystal
			instance_radius = 4

		clan_gates
			instance_radius = 4

		clan_hyuuga
			instance_radius = 4

		clan_ice
			instance_radius = 4

		clan_implant
			instance_radius = 4

		clan_ink
			instance_radius = 4

		clan_jashin
			instance_radius = 4

		clan_kaguya
			instance_radius = 4

		clan_kakuzu
			instance_radius = 4

		clan_medical
			instance_radius = 4

		clan_nara
			instance_radius = 4

		clan_paper
			instance_radius = 4

		clan_puppet
			instance_radius = 4

		clan_rinnegan
			instance_radius = 4

		clan_sage
			instance_radius = 4

		clan_sand
			instance_radius = 4

		clan_senju
			instance_radius = 4

		clan_spider
			instance_radius = 4

		clan_uchiha
			instance_radius = 4

		clan_uzumaki
			instance_radius = 4

		clan_weaponist
			instance_radius = 4

		clan_yellowflash
			instance_radius = 4

	login_screen_locations
		icon = 'placeholdertiles.dmi'
		icon_state = "loginscreenlocations"
		New()
			..()
			icon_state = "blank"

		leaf
		sand
		sound
		rock
		akatfront
		akatback

turf
	akat_exit
		Entered()
			usr.loc = locate(100,161,5)
			..()