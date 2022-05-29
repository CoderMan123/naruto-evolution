mob/moderator
	verb
		Teleport()
			set category = "Moderator"
			src.TeleportCommand()
		
		Summon()
			set category = "Moderator"
			src.SummonCommand()

mob/proc/TeleportCommand()
	switch(src.client.prompt("What kind of mob would you like to teleport to?", "Teleport", list("Player", "NPC", "Coordinates")))
		if("Player")
			var/mob/mob = src.client.prompt("Which player would you like to teleport to?", "Teleport", mobs_online)
			if(mob)
				if(src.client.prompt("Are you sure you want to teleport to [mob] ([mob.ckey])?", "Teleport", list("Yes", "No")) == "Yes")
					src.loc = mob.loc
					text2file("[time2text(world.realtime , "(YYYY-MM-DD hh:mm:ss)")] [src] ([src.ckey]) has teleported to [mob] ([mob.ckey]).<br />", LOG_MODERATOR)
			else
				src << "/teleport: A player mob was not found."

		if("NPC")
			// Filter out NPCs with duplicate names from the teleport.
			var/filter[0]
			for(var/mob/m in npcs_online)
				filter.Add(m)
				for(var/mob/f in filter)
					if(m != f && m.name == f.name)
						filter.Remove(m)

			var/mob/mob = src.client.prompt("Which NPC would you like to teleport to?", "Teleport", filter)
			if(mob)
				if(src.client.prompt("Are you sure you want to teleport to [mob]?", "Teleport", list("Yes", "No")) == "Yes")
					src.loc = mob.loc
					text2file("[time2text(world.realtime , "(YYYY-MM-DD hh:mm:ss)")] [src] ([src.ckey]) has teleported to [mob].<br />", LOG_MODERATOR)
			else
				src << "/teleport: An NPC mob was not found."
		
		if("Coordinates")
			var/list/xyz = src.client.iprompt("What coordinates would you like to teleport to?<br /><br /><u>Example Format</u><br /><br />Hidden Leaf Village: 116,127,1<br />Hidden Sand Village: 102,95,2", "Teleport", list("Submit", "Cancel"))
			if(xyz[1] == "Submit")
				if(src.client.prompt("Are you sure you want to teleport to [xyz[2]]?", "Teleport", list("Yes", "No")) == "Yes")
					var/x = text2num(copytext(xyz[2], 1, findtext(xyz[2], ",")))
					var/y = text2num(copytext(xyz[2], findtext(xyz[2], ",")+1, findlasttext(xyz[2], ",")))
					var/z = text2num(copytext(xyz[2], findlasttext(xyz[2], ",")+1))
					src.loc = locate(x, y, z)
					text2file("[time2text(world.realtime , "(YYYY-MM-DD hh:mm:ss)")] [src] ([src.ckey]) has teleported to [x],[y],[z].<br />", LOG_MODERATOR)

mob/proc/SummonCommand()
	switch(src.client.prompt("What kind of mob would you like to summon?", "Summon", list("Player", "NPC")))
		if("Player")
			var/mob/mob = src.client.prompt("Which player would you like to summon?", "Summon", mobs_online)
			if(mob)
				if(src.client.prompt("Are you sure you want to summon [mob] ([mob.ckey])?", "Summon", list("Yes", "No")) == "Yes")
					mob.loc = src.loc
					text2file("[time2text(world.realtime , "(YYYY-MM-DD hh:mm:ss)")] [src] ([src.ckey]) has summoned [mob] ([mob.ckey]).<br />", LOG_MODERATOR)
			else
				src << "/summon: A player mob was not found."

		if("NPC")
			// Filter out NPCs with duplicate names from the summon.
			var/filter[0]
			for(var/mob/m in npcs_online)
				filter.Add(m)
				for(var/mob/f in filter)
					if(m != f && m.name == f.name)
						filter.Remove(m)

			var/mob/mob = src.client.prompt("Which NPC would you like to summon?", "Summon", filter)
			if(mob)
				if(src.client.prompt("Are you sure you want to summon [mob]?", "Summon", list("Yes", "No")) == "Yes")
					src.loc = mob.loc
					text2file("[time2text(world.realtime , "(YYYY-MM-DD hh:mm:ss)")] [src] ([src.ckey]) has summoned [mob].<br />", LOG_MODERATOR)
			else
				src << "/summon: An NPC mob was not found."