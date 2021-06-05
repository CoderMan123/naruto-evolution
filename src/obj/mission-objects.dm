obj/Inventory
	mission
		var/squad/squad
		New(mob/M)
			..()
			if(M && ismob(M)) src.squad = M.GetSquad()

		deliver_intel
			leaf_intel
				name = "Hidden Leaf Intelligence"
				icon = 'JMastScroll.dmi'


			sand_intel
				name = "Hidden Sand Intelligence"
				icon = 'JMastScroll.dmi'