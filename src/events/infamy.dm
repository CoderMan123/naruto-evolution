proc/InfamyLoop()
	while(world)
		sleep(600*3)
		for(var/mob/m in mobs_online)
			if(m.village != VILLAGE_LEAF && m.z == 1 && m.infamy_points > 0)
				var/number_of_spawns = min(m.infamy_points, 50)
				for(number_of_spawns, number_of_spawns > 1, number_of_spawns -= 10)
					var/mob/npc/combat/guard/genin/Leaf/guard = new()
					guard.spawned = 1
					guard.loc = locate(m.x + pick(list(-1, 1)), m.y + pick(list(-1, 1)), m.z)

			if(m.village != VILLAGE_SAND && m.z == 2 && m.infamy_points > 0)
				var/number_of_spawns = min(m.infamy_points, 50)
				for(number_of_spawns, number_of_spawns > 1, number_of_spawns -= 10)
					var/mob/npc/combat/guard/genin/Sand/guard = new()
					guard.spawned = 1
					guard.loc = locate(m.x + pick(list(-1, 1)), m.y + pick(list(-1, 1)), m.z)

			if(m.infamy_points > 0) m.infamy_points -= 5
			if(m.infamy_points < 0) m.infamy_points = 0