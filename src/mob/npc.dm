mob/npc
	mouse_over_pointer = /obj/cursors/speech
	var/tmp/list/conversations = list()

	New()
		..()
		src.overlays+=/obj/MaleParts/UnderShade
		src.Name(src.name)

	onomari
		name = "Onomari"
		icon = 'WhiteMBase.dmi'
		village = "Hidden Leaf"

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
					if(squad && squad.mission)
						squad.mission.Complete(usr) // Complete mission (original squad)
					else
						var/obj/Inventory/mission/deliver_intel/O = locate(/obj/Inventory/mission/deliver_intel) in usr.contents
						if(O && O.squad.mission)
							O.squad.mission.Complete(usr) // Complete mission (another squad)

						// Request mission (Squad leader only)
						else if(squad && squad.leader[usr.ckey] && !squad.mission)
							// Check for mission cooldown
							var/mission_delay = ((world.realtime - usr.client.last_mission)/10/60)
							if(mission_delay < 20)
								usr.client.Alert("You must wait [round((mission_delay-20)*-1, 1)+1] more minutes until you can accept another mission.", src.name)

							// Select mission
							else if(usr.client.Alert("Hey [usr.name], are you here to pickup a mission for your squad?", src.name, list("Yes", "No")) == 1)
								switch(usr.client.AlertList("What rank mission are you interested in?", src.name, list("D Rank", "C Rank", "B Rank", "A Rank", "S Rank")))
									if(1)
										if(usr.checkRank() >= 1)
											var/mission/d_rank/deliver_intel/mission = pick(typesof(/mission/d_rank) - /mission/d_rank)
											mission = new mission(usr)

											if(usr.client.Alert(mission.html, src.name, list("Accept Mission", "Decline Mission")) == 1)
												squad.mission = mission
												squad.mission.start = world.realtime

												for(var/mob/m in mobs_online)
													if(squad.members[m.client.ckey]) m.client.last_mission = squad.mission.start

												for(var/ckey in squad.members)
													var/savefile/F = new("[SAVEFILE_CLIENT]/[copytext(ckey, 1, 2)]/[ckey].sav")
													F["last_mission"] << squad.mission.start

												spawn() squad.Refresh()
										else
											usr.client.Alert("Only a Genin rank ninja or higher can take a D rank mission.", src.name)

									if(2) usr << 2

									if(3) usr << 3

									if(4) usr << 4

									if(5) usr << 5

						// Mission request denied: active mission
						else if(squad && squad.members[usr.ckey] && squad.mission)
							usr.client.Alert("Your squad already has an active mission.", src.name)

						// Mission request denied: leader must request mission
						else if(squad && squad.members[usr.ckey] && !squad.mission)
							usr.client.Alert("Hey [usr.name], it's nice to see you! Have your squad leader stop by if you're ready to take on a mission.", src.name)

							// Mission request denied: not in a squad
						else if(!squad)
							usr.client.Alert("I can't send you out on missions until you form a squad.", src.name)


				// Rejection
				else
					usr.client.Alert("We don't work with your kind here.", src.name)

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
				if(squad && squad.mission && squad.mission.mob_objectives[1] == src.type)
					switch(squad.mission.type)
						if(/mission/d_rank/deliver_intel)
							if(squad.mission.obj_objectives.Find(/obj/Inventory/mission/deliver_intel))
								squad.mission.obj_objectives.Remove(/obj/Inventory/mission/deliver_intel)

								switch(usr.village)
									if("Hidden Leaf")
										new /obj/Inventory/mission/deliver_intel/leaf_intel(usr)
										spawn() usr.client.UpdateInventoryPanel()
										usr.client.Alert("I need you to deliver this intel to Shizune.", src.name)


									if("Hidden Sand")
										new /obj/Inventory/mission/deliver_intel/sand_intel(usr)
										spawn() usr.client.UpdateInventoryPanel()
										usr.client.Alert("I need you to deliver this intel to Temari.", src.name)

							else
								usr.client.Alert("I've already given your squad the intel. Quickly, on your way before the enemy show up.", src.name)


				else
					usr.client.Alert("Got a problem?", src.name)

				src.conversations.Remove(usr)

			leaf
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