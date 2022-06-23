mob
	npc
		mission_npc
			mission_secretary
				New()
					..()
					if(src.village=="Hidden Leaf") src.icon='Shizune-Leaf Secr.dmi'
					if(src.village=="Hidden Sand") src.icon='Temari-Sand Secr.dmi'

				DblClick()
					..()
					if(src.conversations.Find(usr)) return 0
					src.conversations.Add(usr)

					// Only speak to players in the same village
					if(src.village == usr.village)
						var/squad/squad = usr.GetSquad()
						if(squad && squad.mission && !squad.mission.complete)
							// Complete mission (original squad)
							squad.mission.Complete(usr)
						else
							// Complete mission (another squad)
							var/obj/Inventory/mission/deliver_intel/O = locate(/obj/Inventory/mission/deliver_intel) in usr.contents
							if(O && O.squad.mission && !O.squad.mission.complete)
								O.squad.mission.Complete(usr)

							// Request mission (Squad leader only)
							else if(squad && squad == usr.GetLeader())
								// Check for mission cooldown
								var/mission_delay = ((world.realtime - usr.client.last_mission)/10/60)
								if(mission_delay < 20)
									usr.client.prompt("You must wait [round((mission_delay-20)*-1, 1)+1] more minutes until you can accept another mission.", src.name)

								// Select mission
								else if(usr.client.prompt("Hey [usr.name], are you here to pickup a mission for your squad?", src.name, list("Yes", "No")) == "Yes")
									var/list/excluded_missions = list()
									switch(usr.client.prompt("What rank mission are you interested in?", src.name, list("D Rank", "C Rank", "B Rank", "A Rank", "S Rank")))
										if("D Rank")
											if(usr.checkRank() >= 1)
												var/mission/d_rank/mission

												try
													mission = pick(typesof(/mission/d_rank) - /mission/d_rank - excluded_missions)
												catch
													usr.client.prompt("There are currently no D rank missions avaliable.", src.name)

												if(mission)
													mission = new mission(usr)

													if(usr.client.prompt(mission.html, src.name, list("Accept Mission", "Decline Mission")) == "Accept Mission")
														squad.mission = mission
														squad.mission.Start(usr)

														for(var/mob/m in mobs_online)
															if(squad == m.GetSquad()) m.client.last_mission = squad.mission.start

														for(var/ckey in squad.members)
															var/savefile/F = new("[SAVEFILE_CLIENT]/[copytext(ckey, 1, 2)]/[ckey].sav")
															F["last_mission"] << squad.mission.start

														spawn() squad.Refresh()
											else
												usr.client.prompt("You must be at least Genin rank to take on D rank missions.", src.name)

										if("C Rank")
											if(usr.checkRank() >= 2)
												if(!(VillageDefenders.Find(usr.village)) && !(VillageAttackers.Find(usr.village))) excluded_missions += /mission/c_rank/the_war_effort
												var/mission/c_rank/mission

												try
													mission = pick(typesof(/mission/c_rank) - /mission/c_rank - excluded_missions)
												catch
													usr.client.prompt("There are currently no C rank missions avaliable.", src.name)

												if(mission)
													mission = new mission(usr)

													if(usr.client.prompt(mission.html, src.name, list("Accept Mission", "Decline Mission")) == "Accept Mission")
														squad.mission = mission
														squad.mission.Start(usr)

														for(var/mob/m in mobs_online)
															if(squad == m.GetSquad()) m.client.last_mission = squad.mission.start

														for(var/ckey in squad.members)
															var/savefile/F = new("[SAVEFILE_CLIENT]/[copytext(ckey, 1, 2)]/[ckey].sav")
															F["last_mission"] << squad.mission.start

														spawn() squad.Refresh()
											else
												usr.client.prompt("You must be at least Chunin rank to take on C rank missions.", src.name)

										if("B Rank")
											if(usr.checkRank() >= 3)
												var/mission/b_rank/mission

												try
													mission = pick(typesof(/mission/b_rank) - /mission/b_rank - excluded_missions)
												catch
													usr.client.prompt("There are currently no B rank missions avaliable.", src.name)

												if(mission)
													mission = new mission(usr)

													if(usr.client.prompt(mission.html, src.name, list("Accept Mission", "Decline Mission")) == "Accept Mission")
														squad.mission = mission
														squad.mission.Start(usr)

														for(var/mob/m in mobs_online)
															if(squad == m.GetSquad()) m.client.last_mission = squad.mission.start

														for(var/ckey in squad.members)
															var/savefile/F = new("[SAVEFILE_CLIENT]/[copytext(ckey, 1, 2)]/[ckey].sav")
															F["last_mission"] << squad.mission.start

														spawn() squad.Refresh()
											else
												usr.client.prompt("You must be at least Jonin rank to take on B rank missions.", src.name)

										if("A Rank")
											if(usr.checkRank() >= 3)
												var/mission/a_rank/mission

												try
													mission = pick(typesof(/mission/a_rank) - /mission/a_rank - excluded_missions)
												catch
													usr.client.prompt("There are currently no A rank missions avaliable.", src.name)

												if(mission)
													mission = new mission(usr)

													if(usr.client.prompt(mission.html, src.name, list("Accept Mission", "Decline Mission")) == "Accept Mission")
														squad.mission = mission
														squad.mission.Start(usr)

														for(var/mob/m in mobs_online)
															if(squad == m.GetSquad()) m.client.last_mission = squad.mission.start

														for(var/ckey in squad.members)
															var/savefile/F = new("[SAVEFILE_CLIENT]/[copytext(ckey, 1, 2)]/[ckey].sav")
															F["last_mission"] << squad.mission.start

														spawn() squad.Refresh()
											else
												usr.client.prompt("You must be at least Jonin rank to take on A rank missions.", src.name)

										if("S Rank")
											if(usr.checkRank() >= 4)
												var/mission/s_rank/mission

												try
													mission = pick(typesof(/mission/s_rank) - /mission/s_rank - excluded_missions)
												catch
													usr.client.prompt("There are currently no S rank missions avaliable.", src.name)

												if(mission)
													mission = new mission(usr)

													if(usr.client.prompt(mission.html, src.name, list("Accept Mission", "Decline Mission")) == "Accept Mission")
														squad.mission = mission
														squad.mission.Start(usr)

														for(var/mob/m in mobs_online)
															if(squad == m.GetSquad()) m.client.last_mission = squad.mission.start

														for(var/ckey in squad.members)
															var/savefile/F = new("[SAVEFILE_CLIENT]/[copytext(ckey, 1, 2)]/[ckey].sav")
															F["last_mission"] << squad.mission.start

														spawn() squad.Refresh()
											else
												usr.client.prompt("You must be at least ANBU rank to take on S rank missions.", src.name)

							// Mission request denied: active mission
							else if(squad && squad == usr.GetSquad() && squad.mission && !squad.mission.complete)
								usr.client.prompt("Your squad already has an active mission.", src.name)

							// Mission request denied: leader must request mission
							else if(squad && squad == usr.GetSquad() && !squad.mission)
								usr.client.prompt("Hey [usr.name], it's nice to see you! Have your squad leader stop by if you're ready to take on a mission.", src.name)

							// Mission request denied: not in a squad
							else if(!squad)
								usr.client.prompt("I can't send you out on missions until you form a squad.", src.name)

					// Rejection
					else
						usr.client.prompt("We don't work with your kind here.", src.name)

					src.conversations.Remove(usr)

				proc/CompleteMissions()

				proc/GetMission()

				shizune
					name = "Shizune"
					icon = 'WhiteMBase.dmi'
					village = "Hidden Leaf"

				temari
					name = "Temari"
					icon = 'WhiteMBase.dmi'
					village = "Hidden Sand"

			deliver_intel
				New()
					..()
					src.overlays += pick('Short.dmi','Short2.dmi','Short3.dmi')
					src.overlays += 'Shade.dmi'
					src.overlays+='Shirt.dmi'
					src.overlays+='Sandals.dmi'

				DblClick()
					..()
					if(src.conversations.Find(usr)) return 0
					src.conversations.Add(usr)

					var/squad/squad = usr.GetSquad()

					if(squad && squad.mission && squad.mission.required_mobs.Find(src))
						switch(squad.mission.type)
							if(/mission/d_rank/deliver_intel)
								if(squad.mission.required_items.Find(/obj/Inventory/mission/deliver_intel))
									squad.mission.required_items.Remove(/obj/Inventory/mission/deliver_intel)

									switch(usr.village)
										if("Hidden Leaf")
											var/obj/Inventory/mission/deliver_intel/leaf_intel/o = new(usr)
											usr.RecieveItem(o, src)
											spawn() usr.client.UpdateInventoryPanel()
											usr.client.prompt("I need you to deliver this intel to [squad.mission.complete_npc].", src.name)

										if("Hidden Sand")
											var/obj/Inventory/mission/deliver_intel/sand_intel/o = new(usr)
											usr.RecieveItem(o, src)
											spawn() usr.client.UpdateInventoryPanel()
											usr.client.prompt("I need you to deliver this intel to [squad.mission.complete_npc].", src.name)

								else
									usr.client.prompt("I've already given your squad the intel. Quickly, on your way before the enemy show up.", src.name)

					else
						usr.client.prompt("Got a problem?", src.name)

					src.conversations.Remove(usr)

				leaf
					New()
						..()
						src.overlays += 'SandChuninVest.dmi'
					akirya
						name = "Akirya"
						icon = 'DarkMBase.dmi'
						village="Hidden Sand"

					obei
						name = "Obei"
						icon = 'DarkMBase.dmi'
						village="Hidden Sand"

					tsunai
						name = "Tsunai"
						icon = 'WhiteMBase.dmi'
						village="Hidden Sand"

					amatsi
						name = "Amatsi"
						icon = 'WhiteMBase.dmi'
						village="Hidden Sand"

				sand
					New()
						..()
						src.overlays += 'Chunin Vest.dmi'
					ayumi
						name = "Ayumi"
						icon = 'WhiteMBase.dmi'
						village="Hidden Leaf"

					emiraya
						name = "Emiraya"
						icon = 'DarkMBase.dmi'
						village="Hidden Leaf"

					aiko
						name = "Aiko"
						icon = 'WhiteMBase.dmi'
						village="Hidden Leaf"

					nevira
						name = "Nevira"
						icon = 'DarkMBase.dmi'
						village="Hidden Leaf"




obj/escort
	pel1
		icon = 'placeholdertiles.dmi'
		icon_state = "escortnode"
		New()
			..()
			src.icon_state = "blank"
		Crossed(mob/m)
			if(istype(m, /mob/npc/combat/political_escort))

				var/mob/npc/combat/political_escort/political_escort = m
				political_escort.last_node = src

				walk_to(m, locate(/obj/escort/pel2), 0, 5)
				political_escort.next_node = locate(/obj/escort/pel2)
			..()
	pel2
		icon = 'placeholdertiles.dmi'
		icon_state = "escortnode"
		New()
			..()
			src.icon_state = "blank"
		Crossed(mob/m)
			if(istype(m, /mob/npc/combat/political_escort))

				var/mob/npc/combat/political_escort/political_escort = m
				political_escort.last_node = src

				walk_to(m, locate(/obj/escort/pel3), 0, 5)
				political_escort.next_node = locate(/obj/escort/pel3)
			..()
	pel3
		icon = 'placeholdertiles.dmi'
		icon_state = "escortnode"
		New()
			..()
			src.icon_state = "blank"
		Crossed(mob/m)
			if(istype(m, /mob/npc/combat/political_escort))

				var/mob/npc/combat/political_escort/political_escort = m
				political_escort.last_node = src

				walk_to(m, locate(/obj/escort/pel4), 0, 5)
				political_escort.next_node = locate(/obj/escort/pel4)
			..()

	pel4
		icon = 'placeholdertiles.dmi'
		icon_state = "escortnode"
		New()
			..()
			src.icon_state = "blank"
		Crossed(mob/m)
			if(istype(m, /mob/npc/combat/political_escort))

				var/mob/npc/combat/political_escort/political_escort = m
				political_escort.last_node = src

				walk_to(m, locate(/obj/escort/pel5), 0, 5)
				political_escort.next_node = locate(/obj/escort/pel5)
			..()

	pel5
		icon = 'placeholdertiles.dmi'
		icon_state = "escortnode"
		New()
			..()
			src.icon_state = "blank"
		Crossed(mob/m)
			if(istype(m, /mob/npc/combat/political_escort))

				var/mob/npc/combat/political_escort/political_escort = m
				political_escort.last_node = src

				walk_to(m, locate(/obj/escort/pel6), 0, 5)
				political_escort.next_node = locate(/obj/escort/pel6)
			..()

	pel6
		icon = 'placeholdertiles.dmi'
		icon_state = "escortnode"
		New()
			..()
			src.icon_state = "blank"
		Crossed(mob/m)
			if(istype(m, /mob/npc/combat/political_escort))

				var/mob/npc/combat/political_escort/political_escort = m
				political_escort.last_node = src

				m.loc = locate(101,200,3)
				walk_to(m, locate(/obj/escort/pel7), 0, 5)
				political_escort.next_node = locate(/obj/escort/pel7)
			..()

	pel7
		icon = 'placeholdertiles.dmi'
		icon_state = "escortnode"
		New()
			..()
			src.icon_state = "blank"
		Crossed(mob/m)
			if(istype(m, /mob/npc/combat/political_escort))

				var/mob/npc/combat/political_escort/political_escort = m
				political_escort.last_node = src

				walk_to(m, locate(/obj/escort/pel8), 0, 5)
				political_escort.next_node = locate(/obj/escort/pel8)
			..()

	pel8
		icon = 'placeholdertiles.dmi'
		icon_state = "escortnode"
		New()
			..()
			src.icon_state = "blank"
		Crossed(mob/m)
			if(istype(m, /mob/npc/combat/political_escort))

				var/mob/npc/combat/political_escort/political_escort = m
				political_escort.last_node = src

				walk_to(m, locate(/obj/escort/pel9_haruna), 0, 5)
				political_escort.next_node = locate(/obj/escort/pel9_haruna)
			..()

	pel9_haruna
		icon = 'placeholdertiles.dmi'
		icon_state = "escortnode"
		New()
			..()
			src.icon_state = "blank"
		Crossed(mob/m)
			if(istype(m, /mob/npc/combat/political_escort))
				if(!istype(m, /mob/npc/combat/political_escort/leaf/haruna))
					var/mob/npc/combat/political_escort/political_escort = m
					political_escort.last_node = src

					walk_to(m, locate(/obj/escort/pel10), 0, 5)
					political_escort.next_node = locate(/obj/escort/pel10)
				else
					var/mob/npc/combat/political_escort/political_escort = m
					political_escort.last_node = src

					walk_to(m, locate(/obj/escort/pel10_haruna), 0, 5)
					political_escort.next_node = locate(/obj/escort/pel10_haruna)
				..()

	pel10_haruna
		icon = 'placeholdertiles.dmi'
		icon_state = "escortnode"
		New()
			..()
			src.icon_state = "blank"
		Crossed(mob/m)
			if(istype(m, /mob/npc/combat/political_escort/leaf/haruna))

				var/mob/npc/combat/political_escort/political_escort = m
				political_escort.last_node = src

				walk_to(m, locate(/obj/escort/pel11_haruna), 0, 5)
				political_escort.next_node = locate(/obj/escort/pel11_haruna)
			..()

	pel11_haruna
		icon = 'placeholdertiles.dmi'
		icon_state = "escortnode"
		New()
			..()
			src.icon_state = "blank"
		Crossed(mob/m)
			if(istype(m, /mob/npc/combat/political_escort/leaf/haruna))

				var/mob/npc/combat/political_escort/political_escort = m
				political_escort.last_node = src

				walk_to(m, locate(/obj/escort/pel12_haruna), 0, 5)
				political_escort.next_node = locate(/obj/escort/pel12_haruna)
			..()

	pel12_haruna
		icon = 'placeholdertiles.dmi'
		icon_state = "escortnode"
		New()
			..()
			src.icon_state = "blank"
		Crossed(mob/m)
			if(istype(m, /mob/npc/combat/political_escort/leaf/haruna))

				var/mob/npc/combat/political_escort/political_escort = m
				political_escort.last_node = src

				walk_to(m, locate(/obj/escort/pel13_haruna), 0, 5)
				political_escort.next_node = locate(/obj/escort/pel13_haruna)
			..()

	pel13_haruna
		icon = 'placeholdertiles.dmi'
		icon_state = "escortnode"
		New()
			..()
			src.icon_state = "blank"
		Crossed(mob/m)
			if(istype(m, /mob/npc/combat/political_escort/leaf/haruna))

				var/mob/npc/combat/political_escort/political_escort = m
				political_escort.last_node = src

				walk_to(m, locate(/obj/escort/pel14_haruna), 0, 5)
				political_escort.next_node = locate(/obj/escort/pel14_haruna)
			..()

	pel14_haruna
		icon = 'placeholdertiles.dmi'
		icon_state = "escortnode"
		New()
			..()
			src.icon_state = "blank"
		Crossed(mob/m)
			if(istype(m, /mob/npc/combat/political_escort/leaf/haruna))

				var/mob/npc/combat/political_escort/political_escort = m
				political_escort.last_node = src

				walk_to(m, locate(/obj/escort/pel_end_haruna), 0, 5)
				political_escort.next_node = locate(/obj/escort/pel_end_haruna)
			..()

	pel_end_haruna
		icon = 'placeholdertiles.dmi'
		icon_state = "escortnode"
		New()
			..()
			src.icon_state = "blank"
		Crossed(mob/m)
			if(istype(m, /mob/npc/combat/political_escort))

				var/mob/npc/combat/political_escort/political_escort = m
				political_escort.last_node = src

				if(political_escort.squad && political_escort.squad.mission)
					for(var/mob/s_leader in mobs_online)
						if(political_escort.squad == s_leader.GetLeader())
							political_escort.squad.mission.Complete(s_leader)
							del political_escort
							break
			..()
	pel10
		icon = 'placeholdertiles.dmi'
		icon_state = "escortnode"
		New()
			..()
			src.icon_state = "blank"
		Crossed(mob/m)
			if(istype(m, /mob/npc/combat/political_escort))

				var/mob/npc/combat/political_escort/political_escort = m
				political_escort.last_node = src

				walk_to(m, locate(/obj/escort/pel11), 0, 5)
				political_escort.next_node = locate(/obj/escort/pel11)
			..()
	pel11
		icon = 'placeholdertiles.dmi'
		icon_state = "escortnode"
		New()
			..()
			src.icon_state = "blank"
		Crossed(mob/m)
			if(istype(m, /mob/npc/combat/political_escort))

				var/mob/npc/combat/political_escort/political_escort = m
				political_escort.last_node = src

				m.loc = locate(200,101,5)
				walk_to(m, locate(/obj/escort/pel12_chikara), 0, 5)
				political_escort.next_node = locate(/obj/escort/pel12_chikara)
			..()
	pel12_chikara
		icon = 'placeholdertiles.dmi'
		icon_state = "escortnode"
		New()
			..()
			src.icon_state = "blank"
		Crossed(mob/m)
			if(istype(m, /mob/npc/combat/political_escort))
				if(!istype(m, /mob/npc/combat/political_escort/leaf/chikara))
					var/mob/npc/combat/political_escort/political_escort = m
					political_escort.last_node = src

					walk_to(m, locate(/obj/escort/pel13_toki), 0, 5)
					political_escort.next_node = locate(/obj/escort/pel13_toki)
				else
					var/mob/npc/combat/political_escort/political_escort = m
					political_escort.last_node = src

					walk_to(m, locate(/obj/escort/pel13_chikara), 0, 5)
					political_escort.next_node = locate(/obj/escort/pel13_chikara)
				..()
	pel13_chikara
		icon = 'placeholdertiles.dmi'
		icon_state = "escortnode"
		New()
			..()
			src.icon_state = "blank"
		Crossed(mob/m)
			if(istype(m, /mob/npc/combat/political_escort/leaf/chikara))

				var/mob/npc/combat/political_escort/political_escort = m
				political_escort.last_node = src

				walk_to(m, locate(/obj/escort/pel14_chikara), 0, 5)
				political_escort.next_node = locate(/obj/escort/pel14_chikara)
			..()

	pel14_chikara
		icon = 'placeholdertiles.dmi'
		icon_state = "escortnode"
		New()
			..()
			src.icon_state = "blank"
		Crossed(mob/m)
			if(istype(m, /mob/npc/combat/political_escort/leaf/chikara))

				var/mob/npc/combat/political_escort/political_escort = m
				political_escort.last_node = src

				walk_to(m, locate(/obj/escort/pel15_chikara), 0, 5)
				political_escort.next_node = locate(/obj/escort/pel15_chikara)
			..()

	pel15_chikara
		icon = 'placeholdertiles.dmi'
		icon_state = "escortnode"
		New()
			..()
			src.icon_state = "blank"
		Crossed(mob/m)
			if(istype(m, /mob/npc/combat/political_escort/leaf/chikara))

				var/mob/npc/combat/political_escort/political_escort = m
				political_escort.last_node = src

				walk_to(m, locate(/obj/escort/pel_end_chikara), 0, 5)
				political_escort.next_node = locate(/obj/escort/pel_end_chikara)
			..()

	pel_end_chikara
		icon = 'placeholdertiles.dmi'
		icon_state = "escortnode"
		New()
			..()
			src.icon_state = "blank"
		Crossed(mob/m)
			if(istype(m, /mob/npc/combat/political_escort/leaf/chikara))

				var/mob/npc/combat/political_escort/political_escort = m
				political_escort.last_node = src

				if(political_escort.squad && political_escort.squad.mission)
					for(var/mob/s_leader in mobs_online)
						if(political_escort.squad == s_leader.GetLeader())
							political_escort.squad.mission.Complete(s_leader)
							del political_escort
							break
			..()
	pel13_toki
		icon = 'placeholdertiles.dmi'
		icon_state = "escortnode"
		New()
			..()
			src.icon_state = "blank"
		Crossed(mob/m)
			if(istype(m, /mob/npc/combat/political_escort/leaf/toki))
				var/mob/npc/combat/political_escort/political_escort = m
				political_escort.last_node = src

				walk_to(m, locate(/obj/escort/pel14_toki), 0, 5)
				political_escort.next_node = locate(/obj/escort/pel13_toki)
			..()

	pel14_toki
		icon = 'placeholdertiles.dmi'
		icon_state = "escortnode"
		New()
			..()
			src.icon_state = "blank"
		Crossed(mob/m)
			if(istype(m, /mob/npc/combat/political_escort/leaf/toki))

				var/mob/npc/combat/political_escort/political_escort = m
				political_escort.last_node = src

				walk_to(m, locate(/obj/escort/pel_end_toki), 0, 5)
				political_escort.next_node = locate(/obj/escort/pel_end_toki)
			..()

	pel_end_toki
		icon = 'placeholdertiles.dmi'
		icon_state = "escortnode"
		New()
			..()
			src.icon_state = "blank"
		Crossed(mob/m)
			if(istype(m, /mob/npc/combat/political_escort))

				var/mob/npc/combat/political_escort/political_escort = m
				political_escort.last_node = src

				if(political_escort.squad && political_escort.squad.mission)
					for(var/mob/s_leader in mobs_online)
						if(political_escort.squad == s_leader.GetLeader())
							political_escort.squad.mission.Complete(s_leader)
							del political_escort
							break
			..()

//SAND escort nodes

	pes1
		icon = 'placeholdertiles.dmi'
		icon_state = "escortnode"
		New()
			..()
			src.icon_state = "blank"
		Crossed(mob/m)
			if(istype(m, /mob/npc/combat/political_escort))

				var/mob/npc/combat/political_escort/political_escort = m
				political_escort.last_node = src

				walk_to(m, locate(/obj/escort/pes2), 0, 5)
				political_escort.next_node = locate(/obj/escort/pes2)
			..()
	pes2
		icon = 'placeholdertiles.dmi'
		icon_state = "escortnode"
		New()
			..()
			src.icon_state = "blank"
		Crossed(mob/m)
			if(istype(m, /mob/npc/combat/political_escort))

				var/mob/npc/combat/political_escort/political_escort = m
				political_escort.last_node = src

				walk_to(m, locate(/obj/escort/pes3), 0, 5)
				political_escort.next_node = locate(/obj/escort/pes3)
			..()
	pes3
		icon = 'placeholdertiles.dmi'
		icon_state = "escortnode"
		New()
			..()
			src.icon_state = "blank"
		Crossed(mob/m)
			if(istype(m, /mob/npc/combat/political_escort))

				var/mob/npc/combat/political_escort/political_escort = m
				political_escort.last_node = src

				walk_to(m, locate(/obj/escort/pes4), 0, 5)
				political_escort.next_node = locate(/obj/escort/pes4)
			..()

	pes4
		icon = 'placeholdertiles.dmi'
		icon_state = "escortnode"
		New()
			..()
			src.icon_state = "blank"
		Crossed(mob/m)
			if(istype(m, /mob/npc/combat/political_escort))

				var/mob/npc/combat/political_escort/political_escort = m
				political_escort.last_node = src

				walk_to(m, locate(/obj/escort/pes5), 0, 5)
				political_escort.next_node = locate(/obj/escort/pes5)
			..()

	pes5
		icon = 'placeholdertiles.dmi'
		icon_state = "escortnode"
		New()
			..()
			src.icon_state = "blank"
		Crossed(mob/m)
			if(istype(m, /mob/npc/combat/political_escort))

				var/mob/npc/combat/political_escort/political_escort = m
				political_escort.last_node = src

				walk_to(m, locate(/obj/escort/pes6), 0, 5)
				political_escort.next_node = locate(/obj/escort/pes6)
			..()

	pes6
		icon = 'placeholdertiles.dmi'
		icon_state = "escortnode"
		New()
			..()
			src.icon_state = "blank"
		Crossed(mob/m)
			if(istype(m, /mob/npc/combat/political_escort))

				var/mob/npc/combat/political_escort/political_escort = m
				political_escort.last_node = src

				m.loc = locate(100,1,6)
				walk_to(m, locate(/obj/escort/pes7), 0, 5)
				political_escort.next_node = locate(/obj/escort/pes7)
			..()

	pes7
		icon = 'placeholdertiles.dmi'
		icon_state = "escortnode"
		New()
			..()
			src.icon_state = "blank"
		Crossed(mob/m)
			if(istype(m, /mob/npc/combat/political_escort))

				var/mob/npc/combat/political_escort/political_escort = m
				political_escort.last_node = src

				walk_to(m, locate(/obj/escort/pes8), 0, 5)
				political_escort.next_node = locate(/obj/escort/pes8)
			..()

	pes8
		icon = 'placeholdertiles.dmi'
		icon_state = "escortnode"
		New()
			..()
			src.icon_state = "blank"
		Crossed(mob/m)
			if(istype(m, /mob/npc/combat/political_escort))

				var/mob/npc/combat/political_escort/political_escort = m
				political_escort.last_node = src

				walk_to(m, locate(/obj/escort/pes9_chichiatsu), 0, 5)
				political_escort.next_node = locate(/obj/escort/pes9_chichiatsu)
			..()

	pes9_chichiatsu
		icon = 'placeholdertiles.dmi'
		icon_state = "escortnode"
		New()
			..()
			src.icon_state = "blank"
		Crossed(mob/m)
			if(istype(m, /mob/npc/combat/political_escort))
				if(!istype(m, /mob/npc/combat/political_escort/sand/chichiatsu))
					var/mob/npc/combat/political_escort/political_escort = m
					political_escort.last_node = src

					walk_to(m, locate(/obj/escort/pes10), 0, 5)
					political_escort.next_node = locate(/obj/escort/pes10)
				else
					var/mob/npc/combat/political_escort/political_escort = m
					political_escort.last_node = src

					walk_to(m, locate(/obj/escort/pes10_chichiatsu), 0, 5)
					political_escort.next_node = locate(/obj/escort/pes10_chichiatsu)
				..()

	pes10_chichiatsu
		icon = 'placeholdertiles.dmi'
		icon_state = "escortnode"
		New()
			..()
			src.icon_state = "blank"
		Crossed(mob/m)
			if(istype(m, /mob/npc/combat/political_escort/sand/chichiatsu))

				var/mob/npc/combat/political_escort/political_escort = m
				political_escort.last_node = src

				walk_to(m, locate(/obj/escort/pes11_chichiatsu), 0, 5)
				political_escort.next_node = locate(/obj/escort/pes11_chichiatsu)
			..()

	pes11_chichiatsu
		icon = 'placeholdertiles.dmi'
		icon_state = "escortnode"
		New()
			..()
			src.icon_state = "blank"
		Crossed(mob/m)
			if(istype(m, /mob/npc/combat/political_escort/sand/chichiatsu))

				var/mob/npc/combat/political_escort/political_escort = m
				political_escort.last_node = src

				walk_to(m, locate(/obj/escort/pes12_chichiatsu), 0, 5)
				political_escort.next_node = locate(/obj/escort/pes12_chichiatsu)
			..()

	pes12_chichiatsu
		icon = 'placeholdertiles.dmi'
		icon_state = "escortnode"
		New()
			..()
			src.icon_state = "blank"
		Crossed(mob/m)
			if(istype(m, /mob/npc/combat/political_escort/sand/chichiatsu))

				var/mob/npc/combat/political_escort/political_escort = m
				political_escort.last_node = src

				walk_to(m, locate(/obj/escort/pes13_chichiatsu), 0, 5)
				political_escort.next_node = locate(/obj/escort/pes13_chichiatsu)
			..()

	pes13_chichiatsu
		icon = 'placeholdertiles.dmi'
		icon_state = "escortnode"
		New()
			..()
			src.icon_state = "blank"
		Crossed(mob/m)
			if(istype(m, /mob/npc/combat/political_escort/sand/chichiatsu))

				var/mob/npc/combat/political_escort/political_escort = m
				political_escort.last_node = src

				walk_to(m, locate(/obj/escort/pes14_chichiatsu), 0, 5)
				political_escort.next_node = locate(/obj/escort/pes14_chichiatsu)
			..()

	pes14_chichiatsu
		icon = 'placeholdertiles.dmi'
		icon_state = "escortnode"
		New()
			..()
			src.icon_state = "blank"
		Crossed(mob/m)
			if(istype(m, /mob/npc/combat/political_escort/sand/chichiatsu))

				var/mob/npc/combat/political_escort/political_escort = m
				political_escort.last_node = src

				walk_to(m, locate(/obj/escort/pes_end_chichiatsu), 0, 5)
				political_escort.next_node = locate(/obj/escort/pes_end_chichiatsu)
			..()

	pes_end_chichiatsu
		icon = 'placeholdertiles.dmi'
		icon_state = "escortnode"
		New()
			..()
			src.icon_state = "blank"
		Crossed(mob/m)
			if(istype(m, /mob/npc/combat/political_escort/sand/chichiatsu))

				var/mob/npc/combat/political_escort/political_escort = m
				political_escort.last_node = src

				if(political_escort.squad && political_escort.squad.mission)
					for(var/mob/s_leader in mobs_online)
						if(political_escort.squad == s_leader.GetLeader())
							political_escort.squad.mission.Complete(s_leader)
							del political_escort
							break
			..()
	pes10
		icon = 'placeholdertiles.dmi'
		icon_state = "escortnode"
		New()
			..()
			src.icon_state = "blank"
		Crossed(mob/m)
			if(istype(m, /mob/npc/combat/political_escort))

				var/mob/npc/combat/political_escort/political_escort = m
				political_escort.last_node = src

				walk_to(m, locate(/obj/escort/pes11), 0, 5)
				political_escort.next_node = locate(/obj/escort/pes11)
			..()
	pes11
		icon = 'placeholdertiles.dmi'
		icon_state = "escortnode"
		New()
			..()
			src.icon_state = "blank"
		Crossed(mob/m)
			if(istype(m, /mob/npc/combat/political_escort))

				var/mob/npc/combat/political_escort/political_escort = m
				political_escort.last_node = src

				m.loc = locate(1,103,4)
				walk_to(m, locate(/obj/escort/pes12_danjo), 0, 5)
				political_escort.next_node = locate(/obj/escort/pes12_danjo)
			..()
	pes12_danjo
		icon = 'placeholdertiles.dmi'
		icon_state = "escortnode"
		New()
			..()
			src.icon_state = "blank"
		Crossed(mob/m)
			if(istype(m, /mob/npc/combat/political_escort))
				if(!istype(m, /mob/npc/combat/political_escort/sand/danjo))
					var/mob/npc/combat/political_escort/political_escort = m
					political_escort.last_node = src

					walk_to(m, locate(/obj/escort/pes13_tekkan), 0, 5)
					political_escort.next_node = locate(/obj/escort/pes13_tekkan)
				else
					var/mob/npc/combat/political_escort/political_escort = m
					political_escort.last_node = src

					walk_to(m, locate(/obj/escort/pes13_danjo), 0, 5)
					political_escort.next_node = locate(/obj/escort/pes13_danjo)
				..()
	pes13_danjo
		icon = 'placeholdertiles.dmi'
		icon_state = "escortnode"
		New()
			..()
			src.icon_state = "blank"
		Crossed(mob/m)
			if(istype(m, /mob/npc/combat/political_escort/sand/danjo))

				var/mob/npc/combat/political_escort/political_escort = m
				political_escort.last_node = src

				walk_to(m, locate(/obj/escort/pes14_danjo), 0, 5)
				political_escort.next_node = locate(/obj/escort/pes14_danjo)
			..()

	pes14_danjo
		icon = 'placeholdertiles.dmi'
		icon_state = "escortnode"
		New()
			..()
			src.icon_state = "blank"
		Crossed(mob/m)
			if(istype(m, /mob/npc/combat/political_escort/sand/danjo))

				var/mob/npc/combat/political_escort/political_escort = m
				political_escort.last_node = src

				walk_to(m, locate(/obj/escort/pes15_danjo), 0, 5)
				political_escort.next_node = locate(/obj/escort/pes15_danjo)
			..()

	pes15_danjo
		icon = 'placeholdertiles.dmi'
		icon_state = "escortnode"
		New()
			..()
			src.icon_state = "blank"
		Crossed(mob/m)
			if(istype(m, /mob/npc/combat/political_escort/sand/danjo))

				var/mob/npc/combat/political_escort/political_escort = m
				political_escort.last_node = src

				walk_to(m, locate(/obj/escort/pes_end_danjo), 0, 5)
				political_escort.next_node = locate(/obj/escort/pes_end_danjo)
			..()

	pes_end_danjo
		icon = 'placeholdertiles.dmi'
		icon_state = "escortnode"
		New()
			..()
			src.icon_state = "blank"
		Crossed(mob/m)
			if(istype(m, /mob/npc/combat/political_escort/sand/danjo))

				var/mob/npc/combat/political_escort/political_escort = m
				political_escort.last_node = src

				if(political_escort.squad && political_escort.squad.mission)
					for(var/mob/s_leader in mobs_online)
						if(political_escort.squad == s_leader.GetLeader())
							political_escort.squad.mission.Complete(s_leader)
							del political_escort
							break
			..()
	pes13_tekkan
		icon = 'placeholdertiles.dmi'
		icon_state = "escortnode"
		New()
			..()
			src.icon_state = "blank"
		Crossed(mob/m)
			if(istype(m, /mob/npc/combat/political_escort))
				var/mob/npc/combat/political_escort/political_escort = m
				political_escort.last_node = src

				walk_to(m, locate(/obj/escort/pes14_tekkan), 0, 5)
				political_escort.next_node = locate(/obj/escort/pes14_tekkan)
			..()

	pes14_tekkan
		icon = 'placeholdertiles.dmi'
		icon_state = "escortnode"
		New()
			..()
			src.icon_state = "blank"
		Crossed(mob/m)
			if(istype(m, /mob/npc/combat/political_escort/sand/tekkan))

				var/mob/npc/combat/political_escort/political_escort = m
				political_escort.last_node = src

				walk_to(m, locate(/obj/escort/pes_end_tekkan), 0, 5)
				political_escort.next_node = locate(/obj/escort/pes_end_tekkan)
			..()

	pes_end_tekkan
		icon = 'placeholdertiles.dmi'
		icon_state = "escortnode"
		New()
			..()
			src.icon_state = "blank"
		Crossed(mob/m)
			if(istype(m, /mob/npc/combat/political_escort/sand/tekkan))

				var/mob/npc/combat/political_escort/political_escort = m
				political_escort.last_node = src

				if(political_escort.squad && political_escort.squad.mission)
					for(var/mob/s_leader in mobs_online)
						if(political_escort.squad == s_leader.GetLeader())
							political_escort.squad.mission.Complete(s_leader)
							del political_escort
							break
			..()