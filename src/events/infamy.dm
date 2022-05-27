proc/InfamyLoop()
	while(world)
		sleep(1200*3)//600
		for(var/mob/m in mobs_online)
			if(m.village != VILLAGE_LEAF && m.z == 1 && m.infamy_points > 0)
				var/mob/npc/combat/guard/guard_found = locate() in orange(m, 15)
				if(guard_found) continue
				var/number_of_spawns = min(m.infamy_points, 50)
				for(number_of_spawns, number_of_spawns > 1, number_of_spawns -= 10)
					var/mob/npc/combat/guard/genin/Leaf/guard = new()
					guard.spawned = 1
					var/loc = locate(m.x + rand(-2, 2), m.y + rand(-2, 2), m.z)
					guard.loc = loc
					new/obj/MiscEffects/Smoke(loc)

			if(m.village != VILLAGE_SAND && m.z == 2 && m.infamy_points > 0)
				var/mob/npc/combat/guard/guard_found = locate() in orange(m, 15)
				if(guard_found) continue
				var/number_of_spawns = min(m.infamy_points, 50)
				for(number_of_spawns, number_of_spawns > 1, number_of_spawns -= 10)
					var/mob/npc/combat/guard/genin/Sand/guard = new()
					guard.spawned = 1
					var/loc = locate(m.x + rand(-2, 2), m.y + rand(-2, 2), m.z)
					guard.loc = loc
					new/obj/MiscEffects/Smoke(loc)

			if(m.infamy_points > 0) m.infamy_points -= 10
			if(m.infamy_points < 0) m.infamy_points = 0