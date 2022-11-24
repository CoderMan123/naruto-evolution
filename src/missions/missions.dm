mission
	var/tmp/name
	var/tmp/description
	var/tmp/html
	var/start
	var/complete
	var/limit = 0 //mission time limit (in minutes)
	var/status = "In-Progress"
	var/mob/start_npc
	var/mob/complete_npc
	var/list/required_mobs = list()
	var/list/required_items = list()
	var/list/required_vars = list()
	var/list/squad/squad
	var/mission_exp_mod = 1 //global mod for all mission exp rewards
	var/mission_ryo_mod = 20 //global mod for all mission ryo rewards
	var/mission_statexp_mod = 10 //global mod for all mission stat exp rewards (I will add stat exp rewards to missions when there is a greater variety of missions so it will be balanced)
	var/D_reward = 32
	var/C_reward = 40
	var/B_reward = 50
	var/A_reward = 62
	var/S_reward = 76
	var/jounin_reward_mod = 5

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
			for(var/mob/m in src.required_mobs)
				m = locate(m.type) in npcs_online

	proc/GetTimer()
		// http://www.byond.com/forum/post/2244993
		return ((src.complete-src.start)/10/60)

	proc/Start(mob/M)
		var/squad/squad = M.GetSquad()
		squad.mission.start = world.realtime

		switch(squad.mission.type)

			if(/mission/d_rank/deliver_intel)

				switch(M.village)
					if(VILLAGE_LEAF)
						for(var/mob/m in mobs_online)
							if(m.village != VILLAGE_LEAF)
								spawn(150)m<<output("<b>Word has spread that the <font color='[COLOR_VILLAGE_LEAF]'>Hidden Leaf</font> will be delivering some intel! Intercept them!</b>","Action.Output")
					if(VILLAGE_SAND)
						for(var/mob/m in mobs_online)
							if(m.village != VILLAGE_SAND)
								spawn(150)m<<output("<b>Word has spread that the <font color='[COLOR_VILLAGE_SAND]'>Hidden Sand</font> will be delivering some intel! Intercept them!</b>","Action.Output")

			if(/mission/a_rank/political_escort)

				switch(M.village)
					if(VILLAGE_LEAF)
						var/mob/npc/combat/picked = pick(typesof(/mob/npc/combat/political_escort/leaf) - /mob/npc/combat/political_escort/leaf)
						var/mob/npc/combat/political_escort/npc = new picked(locate(75,26,7))
						src.complete_npc = npc
						npc.squad = src.squad
						npc.squad_leader_ckey = M.ckey
						for(var/mob/m in mobs_online)
							if(m.village != VILLAGE_LEAF)
								spawn(150)m<<output("<b>Word has spread that the <font color='[COLOR_VILLAGE_LEAF]'>Hidden Leaf</font> are escorting a Daimyo! Nows our chance to assasinate them!</b>","Action.Output")
						
					
					if(VILLAGE_SAND)
						var/mob/npc/combat/picked = pick(typesof(/mob/npc/combat/political_escort/sand) - /mob/npc/combat/political_escort/sand)
						var/mob/npc/combat/political_escort/npc = new picked(locate(10,25,7))
						src.complete_npc = npc
						npc.squad = src.squad
						npc.squad_leader_ckey = M.ckey
						for(var/mob/m in mobs_online)
							if(m.village != VILLAGE_SAND)
								spawn(150)m<<output("<b>Word has spread that the <font color='[COLOR_VILLAGE_SAND]'>Hidden Sand</font> are escorting a Daimyo! Nows our chance to assasinate them!</b>","Action.Output")

	proc/Complete(mob/M)
		switch(M.village)
			if(VILLAGE_LEAF)
				if(sand_online > leaf_online) mission_exp_mod = initial(mission_exp_mod) + (0.1 * (sand_online - leaf_online))
				else mission_exp_mod = initial(mission_exp_mod)

			if(VILLAGE_SAND)
				if(leaf_online > sand_online) mission_exp_mod = initial(mission_exp_mod) + (0.1 * (leaf_online - sand_online))
				else mission_exp_mod = initial(mission_exp_mod)

		switch(src.type)
			if(/mission/d_rank/deliver_intel)
				var/squad/squad = M.GetSquad()
				var/obj/Inventory/mission/deliver_intel/O = locate(/obj/Inventory/mission/deliver_intel) in M.contents
				var/exp_reward = round(mission_exp_mod * D_reward)
				var/ryo_reward = round(mission_ryo_mod * D_reward)
				// The mission belongs to the same squad turning it in
				if(src.squad && squad && src.squad == squad && !src.squad.mission.complete && O)
					src.squad.mission.status = "Success"
					src.squad.mission.complete = world.realtime

					var/database/query/query = new({"
						INSERT INTO `[db_table_missions]` (`timestamp`, `squad_leader_key`, `squad_leader`, `squad_member_1_key`, `squad_member_1`, `squad_member_2_key`, `squad_member_2`, `squad_member_3_key`, `squad_member_3`, `squad_member_4_key`, `squad_member_4`, `mission`, `mission_status`)
						VALUES(?,?,?,?,?,?,?,?,?,?,?,?)"},
						time2text(world.realtime, "YYYY-MM-DD hh:mm:ss"), squad.leader[1], squad.leader[squad.leader[1]], squad.members[1], squad.members[squad.members[1]], squad.members[2], squad.members[squad.members[2]], squad.members[3], squad.members[squad.members[3]], squad.members[4], squad.members[squad.members[4]], src.name
					)
					query.Execute(log_db)
					LogErrorDb(query)

					M.DestroyItem(O)

					spawn() M.client.UpdateInventoryPanel()

					var/jounin_reward = 0
					for(var/mob/m in mobs_online)
						if(squad == m.GetSquad() && m.rank == RANK_ACADEMY_STUDENT)
							jounin_reward += jounin_reward_mod

					for(var/mob/m in mobs_online)
						if(squad == m.GetSquad())
							m.exp += exp_reward
							m.ryo += ryo_reward
							m << output("You have completed your mission and you have recieved [exp_reward] exp and [ryo_reward] ryo for your effort!.", "Action.Output")
							if(squad == m.GetLeader() && m.rank == RANK_JOUNIN)
								m.exp += jounin_reward
								m << output("You have recieved an additional [jounin_reward] exp for fulfilling your role as a teacher!", "Action.Output")
							if(m.village == VILLAGE_LEAF)
								Lootdrop("LeafMissions", m, 5)
							else
								Lootdrop("SandMissions", m, 5)
							Lootdrop("StandardClans", m, 10)
							m.Levelup()
							spawn() m.UpdateHMB()
							spawn() squad.RefreshMember(m)

					spawn() M.client.prompt("I've been waiting for this. Thank you for your service.", "[src.complete_npc]")

				else if(src.squad && squad && src.squad == squad && squad.mission && !src.squad.mission.complete && !O)
					spawn() M.client.prompt("I'm still waiting on that squad intel. Please hurry along and pick it up from [src.required_mobs[1]]", "[src.complete_npc]")

				// This mission belongs to another Squad
				else if(squad && O && !O.squad.mission.complete)
					O.squad.mission.status = "Failure"
					O.squad.mission.complete = world.realtime

					var/database/query/query = new({"
						INSERT INTO `[db_table_missions]` (`timestamp`, `squad_leader_key`, `squad_leader`, `squad_member_1_key`, `squad_member_1`, `squad_member_2_key`, `squad_member_2`, `squad_member_3_key`, `squad_member_3`, `squad_member_4_key`, `squad_member_4`, `mission`, `mission_status`)
						VALUES(?,?,?,?,?,?,?,?,?,?,?,?)"},
						time2text(world.realtime, "YYYY-MM-DD hh:mm:ss"), squad.leader[1], squad.leader[squad.leader[1]], squad.members[1], squad.members[squad.members[1]], squad.members[2], squad.members[squad.members[2]], squad.members[3], squad.members[squad.members[3]], squad.members[4], squad.members[squad.members[4]], src.name
					)
					query.Execute(log_db)
					LogErrorDb(query)

					var/scrolltype //1 = leaf 2 = sand
					if(istype(O, /obj/Inventory/mission/deliver_intel/leaf_intel)) scrolltype = 1
					if(istype(O, /obj/Inventory/mission/deliver_intel/sand_intel)) scrolltype = 2
					M.DestroyItem(O)

					spawn() M.client.UpdateInventoryPanel()

					for(var/mob/m in mobs_online)
						if(squad == m.GetSquad())
							m.exp += exp_reward
							m.ryo += ryo_reward
							m.Levelup()
							spawn() m.UpdateHMB()
							spawn() squad.RefreshMember(m)
							if(M.village == VILLAGE_AKATSUKI)
								M.client.prompt("Excellent work. We'll make good use of this.", "Zetsu")
								M << output("You have successfully stolen intel and you have recieved [exp_reward] exp and [ryo_reward] ryo for your effort!.", "Action.Output")
								Lootdrop("AkatsukiClans", m, 3)
								if(scrolltype == 1)
									Lootdrop("LeafMissions", m, 3)
								else if(scrolltype == 2)
									Lootdrop("SandMissions", m, 3)
							else if(M.village == VILLAGE_MISSING_NIN)
								M.client.prompt("Ah wonderful. Here's your money now get lost before someone sees us.", "Shady Looking Figure")
								M << output("You have successfully stolen intel and you have recieved [exp_reward] exp and [ryo_reward] ryo for your effort!.", "Action.Output")
								Lootdrop("MissingNin", m, 3)
								if(scrolltype == 1)
									Lootdrop("LeafMissions", m, 3)
								else if(scrolltype == 2)
									Lootdrop("SandMissions", m, 3)
							else
								spawn() M.client.prompt("Well done. That'll teach them not to spy on us.", "[src.complete_npc]")
								M << output("You have completed your mission and you have recieved [exp_reward] exp and [ryo_reward] ryo for your effort!.", "Action.Output")
								if(m.village == VILLAGE_LEAF)
									Lootdrop("SandMissions", m, 3)
								else
									Lootdrop("LeafMissions", m, 3)
								Lootdrop("StandardClans", m, 3)

				// Solo ninja turning in the mission
				else if(O && !O.squad.mission.complete)
					O.squad.mission.status = "Failure"
					O.squad.mission.complete = world.realtime

					var/database/query/query = new({"
						INSERT INTO `[db_table_missions]` (`timestamp`, `squad_leader_key`, `squad_leader`, `squad_member_1_key`, `squad_member_1`, `squad_member_2_key`, `squad_member_2`, `squad_member_3_key`, `squad_member_3`, `squad_member_4_key`, `squad_member_4`, `mission`)
						VALUES(?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)"},
						time2text(world.realtime, "YYYY-MM-DD hh:mm:ss"), M.ckey, M.character, null, null, null, null, null, null, null, null, src.name
					)
					query.Execute(log_db)
					LogErrorDb(query)

					var/scrolltype //1 = leaf 2 = sand
					if(istype(O, /obj/Inventory/mission/deliver_intel/leaf_intel)) scrolltype = 1
					if(istype(O, /obj/Inventory/mission/deliver_intel/sand_intel)) scrolltype = 2
					M.DestroyItem(O)

					spawn() M.client.UpdateInventoryPanel()
					M.exp += exp_reward
					M.ryo += ryo_reward
					M.Levelup()
					spawn() M.UpdateHMB()
					if(M.village == VILLAGE_AKATSUKI)
						M.client.prompt("Excellent work. We'll make good use of this.", "Zetsu")
						M << output("You have successfully stolen intel and you have recieved [exp_reward] exp and [ryo_reward] ryo for your effort!.", "Action.Output")
						Lootdrop("AkatsukiClans", M, 5)
						if(scrolltype == 1)
							Lootdrop("LeafMissions", M, 5)
						else if(scrolltype == 2)
							Lootdrop("SandMissions", M , 5)
					else if(M.village == VILLAGE_MISSING_NIN)
						M.client.prompt("Ah wonderful. Here's your money now get lost before someone sees us.", "Shady Looking Figure")
						M << output("You have successfully stolen intel and you have recieved [exp_reward] exp and [ryo_reward] ryo for your effort!.", "Action.Output")
						Lootdrop("MissingNin", M, 5)
						if(scrolltype == 1)
							Lootdrop("LeafMissions", M, 5)
						else if(scrolltype == 2)
							Lootdrop("SandMissions", M, 5)
					else
						spawn() M.client.prompt("I've been waiting for this. Thank you for your service.", "[src.complete_npc]")
						M << output("You have completed your mission and you have recieved [exp_reward] exp and [ryo_reward] ryo for your effort!.", "Action.Output")
						if(M.village == VILLAGE_LEAF)
							Lootdrop("SandMissions", M, 5)
						else
							Lootdrop("LeafMissions", M, 5)
						Lootdrop("StandardClans", M, 5)

			if(/mission/c_rank/the_war_effort)
				if(squad && !squad.mission.complete)
					var/exp_reward = round(mission_exp_mod * C_reward)
					var/ryo_reward = round(mission_ryo_mod * C_reward)
					if(src.required_vars["DEATHS"] >= src.squad.members.len)
						squad.mission.status = "Failure"
						squad.mission.complete = world.realtime

						for(var/mob/m in mobs_online)
							if(squad == m.GetSquad())
								m << output("<b>[squad.mission]:</b> You've suffered too many losses, and your orders are to retreat.", "Action.Output")
								spawn() m.client.prompt("You've suffered too many losses, and your orders are to retreat.", "Mission Failed")
								spawn() m.UpdateHMB()
								spawn() squad.RefreshMember(m)

					else if(src.required_vars["KILLS"] >= src.required_vars["REQUIRED_KILLS"])
						squad.mission.status = "Success"
						squad.mission.complete = world.realtime

						var/database/query/query = new({"
							INSERT INTO `[db_table_missions]` (`timestamp`, `squad_leader_key`, `squad_leader`, `squad_member_1_key`, `squad_member_1`, `squad_member_2_key`, `squad_member_2`, `squad_member_3_key`, `squad_member_3`, `squad_member_4_key`, `squad_member_4`, `mission`, `mission_status`)
							VALUES(?,?,?,?,?,?,?,?,?,?,?,?)"},
							time2text(world.realtime, "YYYY-MM-DD hh:mm:ss"), squad.leader[1], squad.leader[squad.leader[1]], squad.members[1], squad.members[squad.members[1]], squad.members[2], squad.members[squad.members[2]], squad.members[3], squad.members[squad.members[3]], squad.members[4], squad.members[squad.members[4]], src.name
						)
						query.Execute(log_db)
						LogErrorDb(query)

						var/jounin_reward = 0
						for(var/mob/m in mobs_online)
							if(squad == m.GetSquad() && m.rank == RANK_ACADEMY_STUDENT)
								jounin_reward += jounin_reward_mod

						for(var/mob/m in mobs_online)
							if(squad == m.GetSquad())
								m.exp += exp_reward
								m.ryo += ryo_reward
								m << output("You have completed your mission and you have recieved [exp_reward] exp and [ryo_reward] ryo for your effort!.", "Action.Output")
								if(squad == m.GetLeader() && m.rank == RANK_JOUNIN)
									m.exp += jounin_reward
									m << output("You have recieved an additional [jounin_reward] exp for fulfilling your role as a teacher!", "Action.Output")

									m.Levelup()
									spawn() m.UpdateHMB()
									spawn() squad.RefreshMember(m)

			if(/mission/b_rank/hunting_rogues)
				if(squad && !squad.mission.complete)
					var/exp_reward = round(mission_exp_mod * B_reward)
					var/ryo_reward = round(mission_ryo_mod * B_reward)
					if(src.required_vars["DEATHS"] >= src.squad.members.len)
						squad.mission.status = "Failure"
						squad.mission.complete = world.realtime

						for(var/mob/m in mobs_online)
							if(squad == m.GetSquad())
								m << output("<b>[squad.mission]:</b> You've suffered too many losses, and your orders are to retreat.", "Action.Output")
								spawn() m.client.prompt("You've suffered too many losses, and your orders are to retreat.", "Mission Failed")
								spawn() m.UpdateHMB()
								spawn() squad.RefreshMember(m)

					else if(src.required_vars["KILLS"] >= src.required_vars["REQUIRED_KILLS"])
						squad.mission.status = "Success"
						squad.mission.complete = world.realtime

						var/database/query/query = new({"
							INSERT INTO `[db_table_missions]` (`timestamp`, `squad_leader_key`, `squad_leader`, `squad_member_1_key`, `squad_member_1`, `squad_member_2_key`, `squad_member_2`, `squad_member_3_key`, `squad_member_3`, `squad_member_4_key`, `squad_member_4`, `mission`, `mission_status`)
							VALUES(?,?,?,?,?,?,?,?,?,?,?,?)"},
							time2text(world.realtime, "YYYY-MM-DD hh:mm:ss"), squad.leader[1], squad.leader[squad.leader[1]], squad.members[1], squad.members[squad.members[1]], squad.members[2], squad.members[squad.members[2]], squad.members[3], squad.members[squad.members[3]], squad.members[4], squad.members[squad.members[4]], src.name
						)
						query.Execute(log_db)
						LogErrorDb(query)

						var/jounin_reward = 0
						for(var/mob/m in mobs_online)
							if(squad == m.GetSquad() && m.rank == RANK_ACADEMY_STUDENT)
								jounin_reward += jounin_reward_mod

						for(var/mob/m in mobs_online)
							if(squad == m.GetSquad())
								m.exp += exp_reward
								m.ryo += ryo_reward
								m << output("You have completed your mission and you have recieved [exp_reward] exp and [ryo_reward] ryo for your effort!.", "Action.Output")
								if(squad == m.GetLeader() && m.rank == RANK_JOUNIN)
									m.exp += jounin_reward
									m << output("You have recieved an additional [jounin_reward] exp for fulfilling your role as a teacher!", "Action.Output")
								Lootdrop("MissingNin", m, 2)
								if(m.village == VILLAGE_LEAF)
									Lootdrop("LeafMissions", m, 5)
								else
									Lootdrop("SandMissions", m, 5)
								m.Levelup()
								spawn() m.UpdateHMB()
								spawn() squad.RefreshMember(m)

			if(/mission/a_rank/political_escort)
				if(squad && !squad.mission.complete)
					var/can_complete = 0

					var/mob/npc/combat/political_escort/npc = squad.mission.complete_npc

					switch(npc.type)
						if(/mob/npc/combat/political_escort/leaf/haruna)
							var/obj/escort/pel_end_haruna/end = locate()
							if(end && end.loc == npc.loc)
								can_complete = 1

						if(/mob/npc/combat/political_escort/leaf/chikara)
							var/obj/escort/pel_end_chikara/end = locate()
							if(end && end.loc == npc.loc)
								can_complete = 1

						if(/mob/npc/combat/political_escort/leaf/toki)
							var/obj/escort/pel_end_toki/end = locate()
							if(end && end.loc == npc.loc)
								can_complete = 1
						
						if(/mob/npc/combat/political_escort/sand/chichiatsu)
							var/obj/escort/pes_end_chichiatsu/end = locate()
							if(end && end.loc == npc.loc)
								can_complete = 1

						if(/mob/npc/combat/political_escort/sand/danjo)
							var/obj/escort/pes_end_danjo/end = locate()
							if(end && end.loc == npc.loc)
								can_complete = 1

						if(/mob/npc/combat/political_escort/sand/tekkan)
							var/obj/escort/pes_end_tekkan/end = locate()
							if(end && end.loc == npc.loc)
								can_complete = 1

					if(can_complete)
						var/exp_reward = round(mission_exp_mod * A_reward)
						var/ryo_reward = round(mission_ryo_mod * A_reward)
						squad.mission.status = "Success"
						squad.mission.complete = world.realtime

						var/database/query/query = new({"
							INSERT INTO `[db_table_missions]` (`timestamp`, `squad_leader_key`, `squad_leader`, `squad_member_1_key`, `squad_member_1`, `squad_member_2_key`, `squad_member_2`, `squad_member_3_key`, `squad_member_3`, `squad_member_4_key`, `squad_member_4`, `mission`, `mission_status`)
							VALUES(?,?,?,?,?,?,?,?,?,?,?,?)"},
							time2text(world.realtime, "YYYY-MM-DD hh:mm:ss"), squad.leader[1], squad.leader[squad.leader[1]], squad.members[1], squad.members[squad.members[1]], squad.members[2], squad.members[squad.members[2]], squad.members[3], squad.members[squad.members[3]], squad.members[4], squad.members[squad.members[4]], src.name
						)
						query.Execute(log_db)
						LogErrorDb(query)

						var/jounin_reward = 0
						for(var/mob/m in mobs_online)
							if(squad == m.GetSquad() && m.rank == RANK_ACADEMY_STUDENT)
								jounin_reward += jounin_reward_mod

						for(var/mob/m in mobs_online)
							if(squad == m.GetSquad())
								m.exp += exp_reward
								m.ryo += ryo_reward
								m << output("You have completed your mission and you have recieved [exp_reward] exp and [ryo_reward] ryo for your effort!.", "Action.Output")
								if(squad == m.GetLeader() && m.rank == RANK_JOUNIN)
									m.exp += jounin_reward
									m << output("You have recieved an additional [jounin_reward] exp for fulfilling your role as a teacher!", "Action.Output")

								if(m.village == VILLAGE_LEAF)
									Lootdrop("LeafMissions", m, 5)
								else
									Lootdrop("SandMissions", m, 5)

								m.Levelup()
								spawn() m.UpdateHMB()
								spawn() squad.RefreshMember(m)

			if(/mission/s_rank/clouds_of_crimson)
				if(squad && !squad.mission.complete)
					var/exp_reward = round(mission_exp_mod * A_reward)
					var/ryo_reward = round(mission_ryo_mod * A_reward)
					if(src.required_vars["DEATHS"] >= src.squad.members.len)
						squad.mission.status = "Failure"
						squad.mission.complete = world.realtime

						for(var/mob/m in mobs_online)
							if(squad== m.GetSquad())
								m << output("<b>[squad.mission]:</b> You've suffered too many losses, and your orders are to retreat.", "Action.Output")
								spawn() m.client.prompt("You've suffered too many losses, and your orders are to retreat.", "Mission Failed")
								spawn() m.UpdateHMB()
								spawn() squad.RefreshMember(m)

					else if(src.required_vars["KILLS"] >= src.required_vars["REQUIRED_KILLS"])
						squad.mission.status = "Success"
						squad.mission.complete = world.realtime

						var/database/query/query = new({"
							INSERT INTO `[db_table_missions]` (`timestamp`, `squad_leader_key`, `squad_leader`, `squad_member_1_key`, `squad_member_1`, `squad_member_2_key`, `squad_member_2`, `squad_member_3_key`, `squad_member_3`, `squad_member_4_key`, `squad_member_4`, `mission`, `mission_status`)
							VALUES(?,?,?,?,?,?,?,?,?,?,?,?)"},
							time2text(world.realtime, "YYYY-MM-DD hh:mm:ss"), squad.leader[1], squad.leader[squad.leader[1]], squad.members[1], squad.members[squad.members[1]], squad.members[2], squad.members[squad.members[2]], squad.members[3], squad.members[squad.members[3]], squad.members[4], squad.members[squad.members[4]], src.name
						)
						query.Execute(log_db)
						LogErrorDb(query)

						var/jounin_reward = 0
						for(var/mob/m in mobs_online)
							if(squad == m.GetSquad() && m.rank == RANK_ACADEMY_STUDENT)
								jounin_reward += jounin_reward_mod

						for(var/mob/m in mobs_online)
							if(squad == m.GetSquad())
								m.exp += exp_reward
								m.ryo += ryo_reward
								m << output("You have completed your mission and you have recieved [exp_reward] exp and [ryo_reward] ryo for your effort!.", "Action.Output")
								if(squad == m.GetLeader() && m.rank == RANK_JOUNIN)
									m.exp += jounin_reward
									m << output("You have recieved an additional [jounin_reward] exp for fulfilling your role as a teacher!", "Action.Output")

								if(m.village == VILLAGE_LEAF)
									Lootdrop("LeafMissions", m, 5)
								else
									Lootdrop("SandMissions", m, 5)
								Lootdrop("AkatsukiClans", m, 5)

								m.Levelup()
								spawn() m.UpdateHMB()
								spawn() squad.RefreshMember(m)

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

		the_war_effort
			name = "The War Effort"
			New(mob/M)
				..()
				if(M)
					src.description = "We're at war! Find and dispose of or defend the village against enemy ninja to further the war effort."
					src.html = {"
						<b><u>Mission</u></b><br />
						[src.name]<br /><br />
						[src.description]
					"}
					src.required_vars["KILLS"] = 0
					src.required_vars["DEATHS"] = 0
					src.required_vars["REQUIRED_KILLS"] = (src.squad.members.len + rand(1,3)) - 1

	b_rank
		hunting_rogues
			name = "Hunting Rogues"
			New(mob/M)
				..()
				if(M)
					src.description = "Hunt down and elimate rogue ninja."
					src.html = {"
						<b><u>Mission</u></b><br />
						[src.name]<br /><br />
						[src.description]
					"}
					src.required_vars["KILLS"] = 0
					src.required_vars["DEATHS"] = 0
					src.required_vars["REQUIRED_KILLS"] = (src.squad.members.len + rand(1,3)) - 1

	a_rank

		political_escort
			name = "Political Escort"
			New(mob/M)
				..()
				if(M)
					src.description = "An important political dignitary is being targeted. Protect him while he travels to where he needs to go."
					src.html = {"
						<b><u>Mission</u></b><br />
						[src.name]<br /><br />
						[src.description]
					"}

//						if("Hidden Sand")


	s_rank

		clouds_of_crimson
			name = "Clouds of Crimson"
			New(mob/M)
				..()
				if(M)
					src.description = "A group of dangerous criminals known as the Akatsuki are plotting something. Find them and take them out."
					src.html = {"
						<b><u>Mission</u></b><br />
						[src.name]<br /><br />
						[src.description]
					"}
					src.required_vars["KILLS"] = 0
					src.required_vars["DEATHS"] = 0
					src.required_vars["REQUIRED_KILLS"] = (src.squad.members.len + rand(1,3)) - 1