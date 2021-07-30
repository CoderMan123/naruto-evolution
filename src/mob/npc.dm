mob/npc
	mouse_over_pointer = /obj/cursors/speech
	var/tmp/list/conversations = list()
	var/npcowner
	var/ownersquad
	var/tmp/bark

	move=0

	Move()
		if(istype(src, /mob/npc/combat)) ..()
		else return

	Death(killer)
		if(istype(src, /mob/npc/combat)) ..()
		else return

	New()
		..()
		npcs_online.Add(src)
		if(!istype(src, /mob/npc/combat/small))
			src.overlays+=/obj/MaleParts/UnderShade
		src.SetName(src.name)

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
						// Complete mission (original squad)
						squad.mission.Complete(usr)
					else
						// Complete mission (another squad)
						var/obj/Inventory/mission/deliver_intel/O = locate(/obj/Inventory/mission/deliver_intel) in usr.contents
						if(O && O.squad.mission)
							O.squad.mission.Complete(usr)

						// Request mission (Squad leader only)
						else if(squad && squad.leader[usr.ckey] && !squad.mission)
							// Check for mission cooldown
							var/mission_delay = ((world.realtime - usr.client.last_mission)/10/60)
							if(mission_delay < 20)
								usr.client.Alert("You must wait [round((mission_delay-20)*-1, 1)+1] more minutes until you can accept another mission.", src.name)

							// Select mission
							else if(usr.client.Alert("Hey [usr.name], are you here to pickup a mission for your squad?", src.name, list("Yes", "No")) == 1)
								var/list/excluded_missions = list()
								switch(usr.client.AlertList("What rank mission are you interested in?", src.name, list("D Rank", "C Rank", "B Rank", "A Rank", "S Rank")))
									if(1)
										if(usr.checkRank() >= 1)
											var/mission/d_rank/mission

											try
												mission = pick(typesof(/mission/d_rank) - /mission/d_rank - excluded_missions)
											catch
												usr.client.Alert("There are currently no D rank missions avaliable.", src.name)

											if(mission)
												mission = new mission(usr)

												if(usr.client.Alert(mission.html, src.name, list("Accept Mission", "Decline Mission")) == 1)
													squad.mission = mission
													squad.mission.Start(usr)

													for(var/mob/m in mobs_online)
														if(squad.members[m.client.ckey]) m.client.last_mission = squad.mission.start

													for(var/ckey in squad.members)
														var/savefile/F = new("[SAVEFILE_CLIENT]/[copytext(ckey, 1, 2)]/[ckey].sav")
														F["last_mission"] << squad.mission.start

													spawn() squad.Refresh()
										else
											usr.client.Alert("You must be at least Genin rank to take on D rank missions.", src.name)

									if(2)
										if(usr.checkRank() >= 2)
											if(!(VillageDefenders.Find(usr.village)) && !(VillageAttackers.Find(usr.village))) excluded_missions += /mission/c_rank/the_war_effort
											var/mission/c_rank/mission

											try
												mission = pick(typesof(/mission/c_rank) - /mission/c_rank - excluded_missions)
											catch
												usr.client.Alert("There are currently no C rank missions avaliable.", src.name)

											if(mission)
												mission = new mission(usr)

												if(usr.client.Alert(mission.html, src.name, list("Accept Mission", "Decline Mission")) == 1)
													squad.mission = mission
													squad.mission.Start(usr)

													for(var/mob/m in mobs_online)
														if(squad.members[m.client.ckey]) m.client.last_mission = squad.mission.start

													for(var/ckey in squad.members)
														var/savefile/F = new("[SAVEFILE_CLIENT]/[copytext(ckey, 1, 2)]/[ckey].sav")
														F["last_mission"] << squad.mission.start

													spawn() squad.Refresh()
										else
											usr.client.Alert("You must be at least Chunin rank to take on C rank missions.", src.name)

									if(3)
										if(usr.checkRank() >= 3)
											var/mission/b_rank/mission

											try
												mission = pick(typesof(/mission/b_rank) - /mission/b_rank - excluded_missions)
											catch
												usr.client.Alert("There are currently no B rank missions avaliable.", src.name)
											
											if(mission)
												mission = new mission(usr)

												if(usr.client.Alert(mission.html, src.name, list("Accept Mission", "Decline Mission")) == 1)
													squad.mission = mission
													squad.mission.Start(usr)

													for(var/mob/m in mobs_online)
														if(squad.members[m.client.ckey]) m.client.last_mission = squad.mission.start

													for(var/ckey in squad.members)
														var/savefile/F = new("[SAVEFILE_CLIENT]/[copytext(ckey, 1, 2)]/[ckey].sav")
														F["last_mission"] << squad.mission.start

													spawn() squad.Refresh()
										else
											usr.client.Alert("You must be at least Jonin rank to take on B rank missions.", src.name)

									if(4)
										if(usr.checkRank() >= 3)
											var/mission/a_rank/mission

											try
												mission = pick(typesof(/mission/a_rank) - /mission/a_rank - excluded_missions)
											catch
												usr.client.Alert("There are currently no A rank missions avaliable.", src.name)
											
											if(mission)
												mission = new mission(usr)

												if(usr.client.Alert(mission.html, src.name, list("Accept Mission", "Decline Mission")) == 1)
													squad.mission = mission
													squad.mission.Start(usr)

													for(var/mob/m in mobs_online)
														if(squad.members[m.client.ckey]) m.client.last_mission = squad.mission.start

													for(var/ckey in squad.members)
														var/savefile/F = new("[SAVEFILE_CLIENT]/[copytext(ckey, 1, 2)]/[ckey].sav")
														F["last_mission"] << squad.mission.start

													spawn() squad.Refresh()
										else
											usr.client.Alert("You must be at least Jonin rank to take on A rank missions.", src.name)

									if(5)
										if(usr.checkRank() >= 4)
											var/mission/s_rank/mission
											
											try
												mission = pick(typesof(/mission/s_rank) - /mission/s_rank - excluded_missions)
											catch
												usr.client.Alert("There are currently no S rank missions avaliable.", src.name)

											if(mission)
												mission = new mission(usr)

												if(usr.client.Alert(mission.html, src.name, list("Accept Mission", "Decline Mission")) == 1)
													squad.mission = mission
													squad.mission.Start(usr)

													for(var/mob/m in mobs_online)
														if(squad.members[m.client.ckey]) m.client.last_mission = squad.mission.start

													for(var/ckey in squad.members)
														var/savefile/F = new("[SAVEFILE_CLIENT]/[copytext(ckey, 1, 2)]/[ckey].sav")
														F["last_mission"] << squad.mission.start

													spawn() squad.Refresh()
										else
											usr.client.Alert("You must be at least ANBU rank to take on S rank missions.", src.name)

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

				if(squad && squad.mission && squad.mission.required_mobs.Find(src))
					switch(squad.mission.type)
						if(/mission/d_rank/deliver_intel)
							if(squad.mission.required_items.Find(/obj/Inventory/mission/deliver_intel))
								squad.mission.required_items.Remove(/obj/Inventory/mission/deliver_intel)

								switch(usr.village)
									if("Hidden Leaf")
										new /obj/Inventory/mission/deliver_intel/leaf_intel(usr)
										spawn() usr.client.UpdateInventoryPanel()
										usr.client.Alert("I need you to deliver this intel to [squad.mission.complete_npc].", src.name)

									if("Hidden Sand")
										new /obj/Inventory/mission/deliver_intel/sand_intel(usr)
										spawn() usr.client.UpdateInventoryPanel()
										usr.client.Alert("I need you to deliver this intel to [squad.mission.complete_npc].", src.name)

							else
								usr.client.Alert("I've already given your squad the intel. Quickly, on your way before the enemy show up.", src.name)

				else
					usr.client.Alert("Got a problem?", src.name)

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

	combat
		New()
			..()
			var/obj/hbar=new /obj/Screen/healthbar/
			var/obj/mbar=new /obj/Screen/manabar/
			src.mouse_over_pointer = /obj/cursors/target
			src.hbar.Add(hbar)
			src.hbar.Add(mbar)
		Death()
			if(src.health <= 0)
				walk(src,0)
				spawn(50)
					if(src)
						del src
			..()

		political_escort
			var/tmp/squad/squad
			var/tmp/squad_leader_ckey
			var/tmp/last_location
			var/tmp/last_location_time
			var/tmp/obj/last_node
			health=20000
			maxhealth=20000
			New()
				..()
				src.overlays += pick('Short.dmi','Short2.dmi','Short3.dmi')
				src.overlays += 'Shade.dmi'
				src.overlays+='Shirt.dmi'
				src.overlays+='Sandals.dmi'
				src.move=1
				src.injutsu=0
				src.canattack=1
				spawn(5) view() << ffilter("<font color='[src.namecolor]'>[src.name]</font>: <font color='[src.chatcolor]'>[bark]</font>")
				spawn()
					while(src && !src.dead)
						if(src.last_location != src.loc)
							src.last_location = src.loc
							src.last_location_time = world.realtime

						else if(src.last_location == src.loc && src.last_location_time + 2000 <= world.realtime) //last_location_time may be innacurate make sure you test
							src.loc = src.last_node.loc
							step_away(src, src.last_node)
							walk_to(src, src.last_node, 0, 5)

						sleep(10)
			Death()
				..()
				if(src.health <= 0)
					for(var/mob/m in mobs_online)
						if(squad.members[m.client.ckey])
							m << output("<b>[squad.mission.name]:</b> The Daimyo has been killed! Our mission is a failure.", "Action.Output")
							spawn() m.client.Alert("The Daimyo has been killed! Our mission is a failure.", "Mission Failed")
							spawn() squad.RefreshMember(m)
			leaf
				New()
					..()
					walk_to(src, locate(/obj/escort/pel1), 0, 5)
				haruna
					name = "Daimyo Haruna"
					icon = 'WhiteMBase.dmi'
					village="Hidden Leaf"
					bark = "Thank you for agreeing to this! Please don't let me get get kidnapped or worse!"

				chikara
					name = "Daimyo Chikara"
					icon = 'WhiteMBase.dmi'
					village="Hidden Leaf"
					bark = "Let's get this over with quick, I can't wait to get home and have some Udon. I'm starving!"

				toki
					name = "Daimyo Toki"
					icon = 'WhiteMBase.dmi'
					village="Hidden Leaf"
					bark = "Take good care of me, I don't want to end up like the daimyo before me."
			sand
				chichiatsu
					name = "Daimyo Chichiatsu"
					icon = 'WhiteMBase.dmi'
					village="Hidden Sand"
					bark = "You're supposed to be my escort? Well, don't go letting me down."
				danjo
					name = "Daimyo Danjo"
					icon = 'WhiteMBase.dmi'
					village="Hidden Sand"
					bark = "I paid a lot for this so you better not waste my money."
				tekkan
					name = "Daimyo Tekkan"
					icon = 'WhiteMBase.dmi'
					village="Hidden Sand"
					bark = "Hmph. That meeting was a waste of time. Oh well, so you'll be my bodyguards then?"

		white_zetsu
			icon='zettsu.dmi'
			var/punch_cd=0
			var/attacking = 0
			var/tmp/mob/target
			var/retreating = 0
			var/next_punch = "left"
			health=2500
			maxhealth=2500


			SetName()
				return

			Move()
				..()
				if(!src.attacking)
					src.FindTarget()

			New()
				..()
				src.ryo = rand(50,150)
				spawn() src.CombatAI()

/*			Death(mob/killer)
				..()
					if(zetsu_count > 1)
						world << output("[killer] has slain a white zetsu! [zetsu_count] remain.", "Action.Output")
						killer << output ("You gain 5 exp and 100 ryo for your efforts.", "Action.Output")
						killer.exp += 5
						killer.ryo += 100 */

			proc/CombatAI()
				while(src)
					if(src.target && src.attacking && !src.dead)
						if(get_dist(src,src.target) <= 1 && !src.punch_cd) src.AttackTarget(src.target)
						else if(get_dist(src,src.target) > 20) src.Idle()
						else if(src.punch_cd && !src.retreating) src.Retreat(src.target)
						else if(!src.punch_cd) src.ChaseTarget(src.target)
	//					else sleep(10) src.CombatAI()
					else if(!src.dead) src.Idle()
					sleep(3)
					
			proc/Idle()
				src.attacking = 0
				src.retreating = 0
				src.target = null
				walk_rand(src,10)

			proc/FindTarget()
				if(src)
					for(var/mob/M in orange(20))
						if(istype(M,/mob/npc) || istype(M,/mob/Rotating_Dummy) || M.village == VILLAGE_AKATSUKI || M.dead) continue
						if(M)
							src.target = M
							src.attacking = 1
						else src.target = null
//						spawn(1) src.CombatAI()

			proc/ChaseTarget(mob/M)
				if(src && M)
					src.retreating = 0
					walk_towards(src,M,2)
//					spawn(5) src.CombatAI()

			proc/AttackTarget(mob/M)
				if(src && M)
					switch(next_punch)
						if("left")
							next_punch="right"
							flick("punchl",src)
						if("right")
							next_punch="left"
							flick("punchr",src)
					M.DealDamage(1,src,"TaiOrange",0,0,1)
					M.UpdateHMB()
					M.Death(src)
					src.punch_cd=1
//					spawn() CombatAI()
					sleep(6)
					src.punch_cd=0

			proc/Retreat(mob/M)
				if(src && M)
					walk(src,0)
					step_rand(src)
					walk_away(src,M,10,2)
					src.retreating = 1
					src.FindTarget()
//					spawn(1) src.CombatAI()


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

				if(political_escort.squad)
					for(var/mob/player in mobs_online)
						if(political_escort.squad.members[player.client.ckey])
							spawn()
								political_escort.squad.mission.Complete(player)
								del m
			..()

	pes1
		icon = 'placeholdertiles.dmi'
		icon_state = "escortnode"
		New()
			..()
			src.icon_state = "blank"
	pes2
		icon = 'placeholdertiles.dmi'
		icon_state = "escortnode"
		New()
			..()
			src.icon_state = "blank"
	pes3
		icon = 'placeholdertiles.dmi'
		icon_state = "escortnode"
		New()
			..()
			src.icon_state = "blank"
	pes4
		icon = 'placeholdertiles.dmi'
		icon_state = "escortnode"
		New()
			..()
			src.icon_state = "blank"
	pes5
		icon = 'placeholdertiles.dmi'
		icon_state = "escortnode"
		New()
			..()
			src.icon_state = "blank"