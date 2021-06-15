mission
	var/tmp/name
	var/tmp/description
	var/tmp/html
	var/start
	var/complete
	var/limit = 30 //mission time limit (in minutes)
	var/mob/start_npc
	var/mob/complete_npc
	var/list/required_mobs = list()
	var/list/required_items = list()
	var/list/required_vars = list()
	var/list/squad/squad

	Read(savefile/F)
		..()

		// Mission lists that have mob references (required_mobs) are saved as entire objects.
		// Loading a mission results in these objects being initilized and calling: mob/npc/New().
		// This results in unwanted references in the npcs_online list that must be immediately removed.

		// Remove unwanted references in the npcs_online list.
		if(npcs_online.Find(src.start_npc))
			npcs_online.Remove(src.start_npc)

		if(npcs_online.Find(src.complete_npc))
			npcs_online.Remove(src.complete_npc)

		for(var/mob/m in src.required_mobs)
			if(npcs_online.Find(m))
				npcs_online.Remove(m)

		// Recreate references from the initialized objects type
		if(src.start_npc)
			src.start_npc = locate(src.start_npc.type) in npcs_online

		if(src.complete_npc)
			src.complete_npc = locate(src.complete_npc.type) in npcs_online

		if(src.required_mobs)
			for(var/i = 1, i <= src.required_mobs, i++)
				src.required_mobs[i] = locate(m.type) in npcs_online

	proc/GetTimer()
		// http://www.byond.com/forum/post/2244993
		return ((src.complete-src.start)/10/60)

	proc/Complete(mob/M)
		switch(src.type)
			if(/mission/d_rank/deliver_intel)
				var/squad/squad = M.GetSquad()
				var/obj/Inventory/mission/deliver_intel/O = locate(/obj/Inventory/mission/deliver_intel) in M.contents
				// The mission belongs to the same squad turning it in
				if(src.squad && squad && src.squad == squad && O)
					M.contents -= O
					O.squad.mission = null
					src.complete = world.realtime
					spawn() M.client.UpdateInventoryPanel()

					for(var/mob/m in mobs_online)
						if(squad.members[m.client.ckey])
							spawn() squad.RefreshMember(m)
							m.exp++
							M.ryo++
							m.LevelStat("Ninjutsu",rand(1,2),1)
							m.Levelup()
					spawn() M.client.Alert("I've been waiting for this. Thank you for your service.", "[src.complete_npc]")

				else if(src.squad && squad && src.squad == squad && squad.mission && !O)
					spawn() M.client.Alert("I'm still waiting on that squad intel. Please hurry along and pick it up from [src.required_mobs[1]]", "[src.complete_npc]")

				else if(squad && O)
					M.contents -= O
					O.squad.mission = null
					src.complete = world.realtime
					spawn() M.client.UpdateInventoryPanel()

					for(var/mob/m in mobs_online)
						if(squad.members[m.client.ckey])
							spawn() squad.RefreshMember(m)
							m.exp++
							M.ryo++
							m.LevelStat("Ninjutsu",rand(1,2),1)
							m.Levelup()

				else if(O)
					M.contents -= O
					O.squad.mission = null
					src.complete = world.realtime
					spawn() M.client.UpdateInventoryPanel()
					M.exp++
					M.ryo++
					M.LevelStat("Ninjutsu",rand(1,2),1)
					M.Levelup()

					spawn() M.client.Alert("I've been waiting for this. Thank you for your service.", "[src.complete_npc]")

	New(mob/M)
		..()
		if(M)
			var/squad/squad = M.GetSquad()
			if(squad) src.squad = squad

			switch(M.village)
				if("Hidden Leaf")
					src.complete_npc = locate(/mob/npc/mission_npc/mission_secretary/shizune)

				if("Hidden Sand")
					src.complete_npc = locate(/mob/npc/mission_npc/mission_secretary/temari)

	d_rank
		deliver_intel
			name = "Deliver Intel"
			New(mob/M)
				..()
				if(M)
					src.required_items = list(/obj/Inventory/mission/deliver_intel)

					var/mob/npc/mission_npc/npc
					switch(M.village)
						if("Hidden Leaf")
							npc = locate(pick(typesof(/mob/npc/mission_npc/deliver_intel/leaf) - /mob/npc/mission_npc/deliver_intel/leaf))
							
						if("Hidden Sand")
							npc = locate(pick(typesof(/mob/npc/mission_npc/deliver_intel/sand) - /mob/npc/mission_npc/deliver_intel/sand))
					src.required_mobs.Add(npc)

					src.description = "Obtain intel from <b>[npc]</b> and then deliver it to <b>[src.complete_npc]</b>."

					src.html = {"
						<b><u>Mission</u></b><br />
						[src.name]<br /><br />
						[src.description]
					"}

	c_rank

	b_rank

	a_rank

	s_rank