mob/var/tmp/skz
mob/var/list/clanskills=list()
obj/SkillTree
	SkillTreeBack
		icon='GRND.dmi'
		icon_state="skillback"
		layer = 0

	Title
		icon='Skill tree options.dmi'
		layer = 1
		ClanJutsu
			icon_state="clan"
			Click()
				if(usr.client.eye==locate(10,75,4))usr.client.eye=locate(60,10,4)

		ClanJutsu2
			icon_state="clan2"
			Click()
				if(usr.client.eye==locate(10,75,4))usr.client.eye=locate(9,124,4)

		NonClan
			icon_state="non clan"
			Click()
				if(usr.client.eye==locate(10,75,4))usr.client.eye=locate(12,43,4)

		Element
			icon_state="element"
			Click()
				if(usr.client.eye==locate(10,75,4))usr.client.eye=locate(55,43,4)

		Back
			icon_state="back"
			Click()
				usr.client.eye=locate(10,75,4)

obj/SkillTree/Linker
	icon='Misc Effects.dmi'
	icon_state="Linker"
	layer = 2

