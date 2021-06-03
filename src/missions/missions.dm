mission
	var/tmp/name
	var/tmp/description
	var/tmp/html
	var/start
	var/complete
	var/limit = 30 //mission time limit (in minutes)
	var/list/mob_objectives = list()
	var/list/obj_objectives = list()
	var/list/squad/squad


	proc/GetTimer()
		// http://www.byond.com/forum/post/2244993
		return ((src.complete-src.start)/10/60)

	proc/Complete(mob/M)
		switch(src.type)
			if(/mission/d_rank/deliver_intel)
				var/squad/squad = M.GetSquad()
				var/obj/Inventory/mission/deliver_intel/O = locate(/obj/Inventory/mission/deliver_intel) in M.contents
				// The mission belongs the the same squad turning it in
				if(src.squad && squad && src.squad == squad && O)
					M.contents -= O
					//squad.mission = null
					O.squad.mission = null
					src.complete = world.realtime
					spawn() M.client.UpdateInventoryPanel()

					for(var/mob/m in mobs_online)
						if(squad.members[m.client.ckey])
							spawn() squad.RefreshMember(m)
							m.exp++
							m.Ryo++
							m.LevelStat("Ninjutsu",rand(1,2),1)
							m.Levelup()
							//m.squad.mission = null
					spawn() M.client.Alert("I've been waiting for this. Thank you for your service.", "Shizune")
				
				else if(src.squad && squad && src.squad == squad && squad.mission && !O)
					spawn() M.client.Alert("I'm still waiting on that squad intel. Please hurry along and pick it up from [src.mob_objectives[1]]", "Shizune")

				else if(squad && O)
					M.contents -= O
					//squad.mission = null
					O.squad.mission = null
					src.complete = world.realtime
					spawn() M.client.UpdateInventoryPanel()

					for(var/mob/m in mobs_online)
						if(squad.members[m.client.ckey])
							spawn() squad.RefreshMember(m)
							m.exp++
							m.Ryo++
							m.LevelStat("Ninjutsu",rand(1,2),1)
							m.Levelup()
							//m.squad.mission = null

				else if(O)
					M.contents -= O
					//squad.mission = null
					O.squad.mission = null
					src.complete = world.realtime
					spawn() M.client.UpdateInventoryPanel()
					M.exp++
					M.Ryo++
					M.LevelStat("Ninjutsu",rand(1,2),1)
					M.Levelup()

					spawn() M.client.Alert("I've been waiting for this. Thank you for your service.", "Shizune")



	New(mob/M)
		..()
		if(M)
			var/squad/squad = M.GetSquad()
			if(squad) src.squad = squad

	d_rank
		deliver_intel
			name = "Deliver Intel"
			New(mob/M)
				..()
				if(M && !src.mob_objectives.len)
					switch(M.village)
						if("Hidden Leaf")
							src.obj_objectives = list(/obj/Inventory/mission/deliver_intel)
							var/mob/npc/mission_npc/npc = pick(typesof(/mob/npc/mission_npc/deliver_intel/leaf) - /mob/npc/mission_npc/deliver_intel/leaf)
							npc = new npc
							src.mob_objectives.Add(npc.type)
							src.description = "Obtain intel from <b>[npc]</b> and then deliver it to <b>Shizune</b>."

						if("Hidden Sand")
							src.obj_objectives = list(/obj/Inventory/mission/deliver_intel)
							var/mob/npc/mission_npc/npc = pick(typesof(/mob/npc/mission_npc/deliver_intel/sand) - /mob/npc/mission_npc/deliver_intel/sand)
							npc = new npc()
							src.mob_objectives.Add(npc.type)
							src.description = "Obtain intel from <b>[npc]</b> and then deliver it to <b>Temari</b>."
				src.html = {"
					<b><u>Mission</u></b><br />
					[src.name]<br /><br />
					[src.description]
				"}

	c_rank

	b_rank

	a_rank

	s_rank