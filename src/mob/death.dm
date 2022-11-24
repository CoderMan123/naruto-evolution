mob
	proc
		Death(mob/attacker, jashin_self_damage = 0)

			///////////////
			// Pre-Death //
			///////////////

			src.HengeUndo()

			var/area/area
			if(src.loc) area = src.loc.loc

			// Ensure kills from clones are acredited to the player
			if(istype(attacker, /mob/Karasu)) attacker = attacker.Owner

			if(src.client && attacker.client && src.level <= 4)
				src.health = src.maxhealth
				src << output("You are protected from death by other players while under level 5.", "Action.Output")
				attacker << output("[src] is protected from death by other players while under level 5.", "Action.Output")
			
			else if(area && area.Safe && src.health < 1)
				src.health = 1
				src << output("You are protected from death because you are in a safezone.", "Action.Output")
				attacker << output("[src] is protected from death because they are in a safezone.", "Action.Output")
			
			else if(attacker.client && attacker.jailed)
				attacker.health = attacker.maxhealth
				attacker << output("You are protected from death while you are in jail.", "Action.Output")

			else if(src.immortal)
				if(src.health < 1) src.health = 1
			
			else if(src.Susanoo)
				if(src.health < 1) src.health = 1

			else if(src.AdminShield)
				src.health = src.maxhealth
				src << output("You are protected from death by a barrier.", "Action.Output")
				attacker << output("[src] is protected from death by a barrier.", "Action.Output")

			else if(src.Tutorial && src.Tutorial != 7)
				src.health = src.maxhealth
				src << output("You are protected from death while in the tutorial.", "Action.Output")
				attacker << output("[src] is protected from death while in the tutorial.", "Action.Output")
			
			// Damage taken while on Jashin Circle (Not from same circle)
			else if(!jashin_self_damage)
				for(var/obj/JashinSymbol/jashin_symbol in src.loc)
					sleep(1)
					if(jashin_symbol && jashin_symbol.Owner == src && jashin_symbol.JashinConnected)
						var/mob/jashin_target = jashin_symbol.JashinConnected
						if(jashin_target && !jashin_target.dead)
							var/jashpercent = (jutsudamage / 200) * 1.5
							jashin_target.DealDamage(src.maxhealth * (jashpercent / 20), src, "maroon")
							jashin_target.Bleed()
							jashin_target.UpdateHMB()

							src.DealDamage(src.maxhealth * (jashpercent / 40), src, "maroon", jashin_damage = 1)
							src.Bleed()

							src.PlayAudio('knife_hit1.wav', output = AUDIO_HEARERS)

			///////////
			// Death //
			///////////
			
			if(src.health <= 0 && !src.dead)

				/////////////////
				// Clone Death //
				/////////////////

				if(istype(src, /mob/Clones))
					var/mob/owner = src.Owner

					if(owner && owner.likeaclone)
						owner.likeaclone = null
						owner.target_mob = null
						owner.takeova = 0
						if(owner.client)
							owner.client.perspective = EDGE_PERSPECTIVE
							owner.client.eye = owner
					
					if(owner)
						if(istype(src, /mob/Clones/MizuBunshin))
							src.PlayAudio('sg_explode.wav', output = AUDIO_HEARERS)
							src.icon = 'Water Bunshin.dmi'
							flick("form", src)
						else
							src.PlayAudio('sg_explode.wav', output = AUDIO_HEARERS)
							new /obj/MiscEffects/Smoke(src.loc)

						spawn(1)
							if(src)
								src.loc = null
								src.Owner = null
				
				////////////////
				// Clay Death //
				////////////////

				else if(istype(src, /mob/Untargettable/C2))
					flick("destroy", src)
					spawn(3) del(src)
				
				///////////////
				// Mob Death //
				///////////////

				else
					///////////////////////
					// Mob Death: Global //
					///////////////////////

					spawn() src.gatestop()

					// Immortality sacrifice requirement
					if(attacker.needkill == 1) attacker.needkill = 2

					// Reset dojo exp multiplier

					src.likeaclone = null

					// Reset unknown variables
					src.screen_moved = 0
					src.arrow = null
					src.cranks = null
					src.copy = null
					src.ArrowTasked = null
					src.Effects["Rasengan"] = null
					src.Effects["Chidori"] = null

					if(src.client)
						src.client.eye = src
						src.client.images = null
						src.Target_ReAdd()
						src.client.perspective = EDGE_PERSPECTIVE
					
					// Jutsu cleanup
					for(var/obj/Projectiles/Effects/AlmightyPush/JP in range(src, 0)) del(JP)

					// Destroy clones
					for(var/mob/Clones/C in src.Clones)
						C.health = 0
						C.Death(src)
					

					//////////////////////////
					// Mob Death: Dojo Only //
					//////////////////////////

					if(istype(area, /area/Dojo))
						if(src == attacker)
							src << output("You've just self-killed. No exp from that...", "Action.Output")
						else
							attacker.levelrate += 1
							if(attacker.levelrate >= 1) attacker.levelrate=1

						src.health = src.maxhealth / 2
						src.chakra = src.maxchakra / 2
						src.icon_state = ""
						src.wait = 0
						src.rest = 0
						src.dodge = 0
						src.UpdateHMB()
						RemoveState(src, new/state/cant_attack, STATE_REMOVE_ALL)
						RemoveState(src, new/state/cant_move, STATE_REMOVE_ALL)

						view(src) << output("[src] has been KO'd and removed from the Dojo.", "Action.Output")

						var/area/Dojo/dojo = area
						if(dojo && istype(locate(dojo.DojoX, dojo.DojoY, dojo.DojoZ), /turf/)) src.loc = locate(dojo.DojoX, dojo.DojoY, dojo.DojoZ)
						else src.loc = MapLoadSpawn()
					
					//////////////////////////
					// Mob Death: Duel Only //
					//////////////////////////

					else if(dueling)
						world << output("[opponent] has defeated [src] in an arena battle.", "Action.Output")
						src.loc = locate(177,136,8)
						src.health = src.maxhealth
						src.kawarmi = 0
						var/mob/i = opponent
						i.loc = locate(177,136,8)
						i.health = i.maxhealth
						i.kawarmi = 0
						arenaprogress = 0
						opponent.dueling = 0
						src.dueling = 0
						src.UpdateHMB()
					
					//////////////////////////////////
					// Mob Death: Chuunin Exam Only //
					//////////////////////////////////

					else if(src == ChuuninOpponentOne && attacker == ChuuninOpponentTwo || attacker == ChuuninOpponentOne && src == ChuuninOpponentTwo)
						ChuuninDuelLoser = src
						ChuuninDuelWinner = attacker
						src.health = src.maxhealth
						src.UpdateHMB()
					
					/////////////////////////////
					// Mob Death: Standard //
					/////////////////////////////

					else
						var/death_location = src.loc
						src.health = 0
						src.chakra = 0
						src.dead = 1
						src.density = 0
						src.dodge = 0
						AddState(src, new/state/cant_attack, -1)
						AddState(src, new/state/cant_move, -1)
						RemoveState(src, new/state/sleeping, STATE_REMOVE_ALL)
						src.levelrate = 0
						src.wait = 0
						src.rest = 0
						src.overlays = null
						src.RestoreOverlays()
						src.UpdateHMB()
						src.infamy_points = 0
						src.icon_state = "dead"
						src.UpdateHMB()

						for(var/obj/ChuuninExam/Scrolls/scroll in src.contents) scroll.Move(src.loc)
						for(var/obj/Inventory/mission/deliver_intel/scroll in src.contents) src.DropItem(scroll)

						if(src.client)
							spawn()
								while(src && src.dead)
									src.loc = death_location
									src.icon_state = "dead"
									sleep(1)
						
						if(src.client)
							var/respawned = 0

							spawn(3000) if(!respawned && src.dead) src.Respawn()
							if(src.client.prompt("Please wait for a medic or respawn in the hospital", "Reaper", list("Respawn")))
								if(src.dead)
									respawned = 1
									src.Respawn()
						
						///////////////////////////////////
						// Friendly Village Kill Penalty //
						///////////////////////////////////

						if(src != attacker && src.village == attacker.village && src.village != VILLAGE_MISSING_NIN && src.village != VILLAGE_AKATSUKI && !Chuunins.Find(src))
							attacker.exp -= round(attacker.exp*0.5)
							if(attacker.exp < 0) attacker.exp = 0
							attacker.Vkill++
							attacker << output("You have lost 50% of your EXP for killing a fellow villager.", "Action.Output")
							world << output("[src] was knocked out by [attacker], and they were both from the [src.village]!", "Action.Output")
						
						///////////////////////////
						// PvP Rewards & Penalty //
						///////////////////////////
						
						else if(src != attacker && src.client && attacker.client)
							var/exp_loss = 2
							src.exp -= exp_loss
							src << output("You lose [exp_loss] experience points.", "Action.Output")

							var/exp_reward = rand(3, attacker.levelrate)
							attacker.exp += exp_reward
							attacker.levelrate = min(attacker.levelrate + 2, 5)

							world<<output("[src] was knocked out by [attacker]!","Action.Output")
						
						/////////////////
						// PvE Rewards //
						/////////////////

						else if(src != attacker && !src.client)
							attacker.exp += src.exp_reward

						/////////////////
						// Ryo Rewards //
						/////////////////

						// Loot Ryo
						if(src != attacker)
							attacker.ryo += src.ryo
							src.ryo = 0
							view(attacker) << output("<i>[attacker] has looted [src.ryo] Ryo from [src].</i>", "Action.Output")

						// Loot Ryo pouches
						if(src != attacker)
							var/looted_pouches = 0
							var/looted_pouches_ryo = 0

							for(var/obj/Inventory/ryo_pouch/pouch in src.contents)
								attacker.contents += pouch
								looted_pouches++
								looted_pouches_ryo += pouch.ryo

							if(looted_pouches)
								spawn() src.client.UpdateInventoryPanel()
								spawn() attacker.client.UpdateInventoryPanel()
								view(attacker) << output("<i>[attacker] has looted [looted_pouches] Ryo Pouches containing [looted_pouches_ryo] Ryo from [src].</i>", "Action.Output")
						
						if(src != attacker)
							attacker.kills++

						//////////////////
						// Misc Rewards //
						//////////////////

						if(src != attacker)
							if(VillageAttackers.Find(src.village) && VillageDefenders.Find(attacker.village))
								attacker<<output("You killed an enemy Shinobi! 10 Ryo has been granted to you for your efforts!", "Action.Output")
								attacker.ryo += 10

							if(VillageDefenders.Find(src.village) && VillageAttackers.Find(attacker.village))
								attacker<<output("You killed an enemy Shinobi! 10 Ryo has been granted to you for your efforts!", "Action.Output")
								attacker.ryo += 10
						
						

						///////////////////
						// Bounty System //
						///////////////////
						
						if(src != attacker && src.Bounty)
							attacker << output("You have claimed the [src.Bounty] Ryo bounty on [src.name]'s head.", "Action.Output")
							attacker.ryo += src.Bounty
							src.Bounty = 0
						
						if(src != attacker && src.client)
							attacker.Bounty += rand(5,10)
						
						///////////////////
						// Infamy System //
						///////////////////

						if(attacker.village != VILLAGE_LEAF && src.village == VILLAGE_LEAF && src.z == 1)
							if(!attacker.infamy_points) src.infamy_points++

						if(attacker.village != VILLAGE_SAND && src.village == VILLAGE_SAND && src.z == 2)
							if(!attacker.infamy_points) src.infamy_points++
						
						/////////////////////
						// Mission Rewards //
						/////////////////////

						/////////////////////////
						// Zetsu Event Rewards //
						/////////////////////////

						// Zetsu Death
						if(src != attacker && istype(src, /mob/npc/combat/white_zetsu) && zetsu_event_active)
							zetsu_count--
							switch(attacker.village)
								if(VILLAGE_LEAF)
									leaf_points++

								if(VILLAGE_SAND)
									sand_points++

							if(attacker.village != VILLAGE_MISSING_NIN && attacker.village != VILLAGE_AKATSUKI)
								if(zetsu_count > 0)
									world << output("A white Zetsu has been slain by [attacker.name] earning the [attacker.village] village 1 point! There are still [zetsu_count] Zetsu somewhere!]", "Action.Output")
									Lootdrop("AkatsukiClans", attacker, 1)
								
								if(zetsu_count < 1)
									ZetsuEventEnd(attacker)
								
									Lootdrop("AkatsukiClans", attacker, 15)
							else
								if(zetsu_count > 0)
									world << output("A white Zetsu has been slain by [attacker.name]! There are still [zetsu_count] Zetsu somewhere!]", "Action.Output")
									if(attacker.village == VILLAGE_MISSING_NIN) Lootdrop("AkatsukiClans", attacker, 1)

								if(zetsu_count < 1)
									ZetsuEventEnd(attacker)



						// Akatsuki Death
						if(src != attacker && src.village == VILLAGE_AKATSUKI && zetsu_event_active)
							var/squad/squad = attacker.GetSquad()
							if(attacker.village == VILLAGE_LEAF || attacker.village == VILLAGE_SAND)
								Lootdrop("AkatsukiClans", attacker, 3)
								akat_lives_left--
								switch(attacker.village)
									if(VILLAGE_LEAF)
										leaf_points += 4

									if(VILLAGE_SAND)
										sand_points += 4

								if(akat_lives_left > 0)
									world << output ("[attacker.name] has slain a member of the Akatsuki earning the [attacker.village] village 4 points! (Akatsuki lives remaining: [akat_lives_left])", "Action.Output")

									if(squad)
										for(var/mob/m in mobs_online)
											if(squad == m.GetSquad())
												m << output ("[attacker.name] has killed a member of the Akatsuki! You've earned 10 bonus experience for your squad!", "Action.Output")
												m.exp += 10
												m.Levelup()
									else
										attacker.exp += 10
										attacker.Levelup()
								else
									ZetsuEventEnd(attacker)

						// Villager Death
						if(src != attacker && src.village == VILLAGE_LEAF || src.village == VILLAGE_SAND)
							var/squad/squad = attacker.GetSquad()
							if(attacker.village == VILLAGE_AKATSUKI && zetsu_event_active || istype(attacker, /mob/npc/combat/white_zetsu))
								vill_lives_left--
								if(vill_lives_left > 0)
									world << output ("[attacker.name] has slain a member of the [src.village] village! (Shinobi Alliance lives remaining: [vill_lives_left])", "Action.Output")
									attacker << output ("It's a slaughter. You've earned 10 bonus experience for your squad!", "Action.Output")
									if(squad)
										for(var/mob/m in mobs_online)
											if(squad == m.GetSquad())
												m.exp += 10
												m.Levelup()
									else
										attacker.exp += 10
										attacker.Levelup()
								else
									ZetsuEventEnd(attacker)

						// Missing-Nin Death
						if(src != attacker && attacker.village == VILLAGE_MISSING_NIN && zetsu_event_active)
							if(src.village == VILLAGE_AKATSUKI || src.village == VILLAGE_LEAF || src.village == VILLAGE_SAND)
								if(src.village == VILLAGE_AKATSUKI)
									akat_lives_left--
									world << output("A rogue ninja took advantage of the fray and has killed a member of the Akatuski! (Akatsuki lives remaining: [akat_lives_left])", "Action.Output")

								if(src.village == VILLAGE_LEAF || src.village == VILLAGE_SAND)
									vill_lives_left--
									world << output("A rogue ninja took advantage of the fray and has killed a member of the [attacker.village] village! (Shinobi Alliance lives remaining: [vill_lives_left])", "Action.Output")

								attacker << output ("With everything going on, they never saw you coming. You've earned 15 bonus experience!", "Action.Output")
								attacker.exp += 15
								attacker.Levelup()
								if(akat_lives_left < 1 || vill_lives_left < 1)
									ZetsuEventEnd(attacker)

						///////////////////////////////////////////////////
						// Search and Destroy Mission Rewards (Attacker) //
						///////////////////////////////////////////////////

						// Reward Squad (attacker) for killing a mob during search and destroy type missions.
						if(src != attacker)
							var/squad/squad = attacker.GetSquad()
							if(squad && squad.mission && !squad.mission.complete)
								switch(squad.mission.type)

									////////////////////////////////////
									// Hunting Rogues Mission Rewards //
									////////////////////////////////////
									
									if(/mission/b_rank/hunting_rogues)
										if(src.village == VILLAGE_MISSING_NIN)
											squad.mission.required_vars["KILLS"]++
											for(var/mob/m in mobs_online)
												if(squad == m.GetSquad())
													m << output("[attacker] has slain the Missing-Nin [src] while on a mission hunting rogue ninja.", "Action.Output")
													m << output("<b>[squad.mission]:</b> [squad.mission.required_vars["KILLS"]]/[squad.mission.required_vars["REQUIRED_KILLS"]] rogue ninja have been eliminated.", "Action.Output")
											spawn() squad.mission.Complete(attacker)
									
									////////////////////////////////////
									// The War Effort Mission Rewards //
									////////////////////////////////////

									if(/mission/c_rank/the_war_effort)
										switch(attacker.village)
											if(VILLAGE_LEAF)
												if(src.village == VILLAGE_SAND)
													squad.mission.required_vars["KILLS"]++
													for(var/mob/m in mobs_online)
														if(squad == m.GetSquad())
															m << output("[attacker] has slain the enemy villager [src] as part of the war effort.", "Action.Output")
															m << output("<b>[squad.mission]:</b> [squad.mission.required_vars["KILLS"]]/[squad.mission.required_vars["REQUIRED_KILLS"]] enemy ninja have been eliminated.", "Action.Output")
													spawn() squad.mission.Complete(attacker)

											if(VILLAGE_SAND)
												if(src.village == VILLAGE_LEAF)
													squad.mission.required_vars["KILLS"]++
													for(var/mob/m in mobs_online)
														if(squad == m.GetSquad())
															m << output("[attacker] has slain the enemy villager [src] as part of the war effort.", "Action.Output")
															m << output("<b>[squad.mission]:</b> [squad.mission.required_vars["KILLS"]]/[squad.mission.required_vars["REQUIRED_KILLS"]] enemy ninja have been eliminated.", "Action.Output")
													spawn() squad.mission.Complete(attacker)

									///////////////////////////////////////
									// Clouds of Crimson Mission Rewards //
									///////////////////////////////////////

									if(/mission/s_rank/clouds_of_crimson)
										if(src.village == VILLAGE_AKATSUKI)
											squad.mission.required_vars["KILLS"]++
											for(var/mob/m in mobs_online)
												if(squad == m.GetSquad())
													m << output("[attacker] has slain the Akatsuki member [src] while on a mission to eliminate them.", "Action.Output")
													m << output("<b>[squad.mission]:</b> [squad.mission.required_vars["KILLS"]]/[squad.mission.required_vars["REQUIRED_KILLS"]] Akatsuki members have been eliminated.", "Action.Output")
											spawn() squad.mission.Complete(attacker)
						
						////////////////////////////////////////
						// Search and Destroy Mission Penalty //
						////////////////////////////////////////

						// Penalize Squad for dying while on a search and destroy mission
						if(src != attacker)
							var/squad/squad = src.GetSquad()
							if(squad && squad.mission && !squad.mission.complete)
								switch(squad.mission.type)

									////////////////////////////////////
									// Hunting Rogues Mission Penalty //
									////////////////////////////////////

									if(/mission/b_rank/hunting_rogues)
										squad.mission.required_vars["DEATHS"]++
										for(var/mob/m in mobs_online)
											if(squad == m.GetSquad())
												m << output("[src] has died to [attacker] while on a mission hunting rogue ninja.", "Action.Output")
												m << output("<b>[squad.mission]:</b> [squad.mission.required_vars["DEATHS"]]/[squad.members.len] fatalities while hunting rogue ninja.", "Action.Output")
										spawn() squad.mission.Complete(src)
									
									////////////////////////////////////
									// The War Effort Mission Penalty //
									////////////////////////////////////
									
									if(/mission/c_rank/the_war_effort)
										squad.mission.required_vars["DEATHS"]++
										for(var/mob/m in mobs_online)
											if(squad == m.GetSquad())
												m << output("[src] has died to [attacker] while on a mission hunting enemy ninja.", "Action.Output")
												m << output("<b>[squad.mission]:</b> [squad.mission.required_vars["DEATHS"]]/[squad.members.len] fatalities while hunting enemy ninja.", "Action.Output")
										spawn() squad.mission.Complete(src)

									///////////////////////////////////////
									// Clouds of Crimson Mission Penalty //
									///////////////////////////////////////

									if(/mission/s_rank/clouds_of_crimson)
										squad.mission.required_vars["DEATHS"]++
										for(var/mob/m in mobs_online)
											if(squad == m.GetSquad())
												m << output("[src] has died to [attacker] while on a mission to eliminate the Akatsuki.", "Action.Output")
												m << output("<b>[squad.mission]:</b> [squad.mission.required_vars["DEATHS"]]/[squad.members.len] fatalities while hunting the Akatsuki.", "Action.Output")
										spawn() squad.mission.Complete(src)

						/////////////////////////////////////////////////
						// Search and Destroy Mission Rewards (Attacker) //
						/////////////////////////////////////////////////

						// Reward player (attacker) for killing someone who is on a search and destroy type mission which targets you.
						if(src != attacker)
							var/squad/squad = src.GetSquad()
							if(squad && squad.mission && !squad.mission.complete)
								switch(squad.mission.type)

									////////////////////////////////////
									// Hunting Rogues Mission Rewards //
									////////////////////////////////////

									if(/mission/b_rank/hunting_rogues)
										if(attacker.village == VILLAGE_MISSING_NIN)
											attacker << output("You have slain [src] who was on a mission hunting rogue ninja.", "Action.Output")
											attacker.exp += 20
											attacker.ryo += 250
											attacker << output("You Recieve 20 exp and 250 ryo as a reward for your effort.", "Action.Output")
											spawn() attacker.Levelup()

									////////////////////////////////////
									// The War Effort Mission Rewards //
									////////////////////////////////////

									if(/mission/c_rank/the_war_effort)
										if(attacker.village == VILLAGE_LEAF && src.village != VILLAGE_LEAF)
											attacker << output("You have slain [src] who was on a mission hunting leaf ninja!.", "Action.Output")
											attacker.exp += 20
											attacker.ryo += 250
											attacker << output("You Recieve 20 exp and 250 ryo as a reward for your effort.", "Action.Output")
											spawn() attacker.Levelup()
										if(attacker.village == VILLAGE_SAND && src.village != VILLAGE_SAND)
											attacker << output("You have slain [src] who was on a mission hunting sand ninja!.", "Action.Output")
											attacker.exp += 20
											attacker.ryo += 250
											attacker << output("You Recieve 20 exp and 250 ryo as a reward for your effort.", "Action.Output")
											spawn() attacker.Levelup()

									///////////////////////////////////////
									// Clouds of Crimson Mission Rewards //
									///////////////////////////////////////

									if(/mission/s_rank/clouds_of_crimson)
										if(attacker.village == VILLAGE_AKATSUKI)
											attacker << output("You have slain [src] who was on a mission to kill the Akatsuki.", "Action.Output")
											attacker.exp += 20
											attacker.ryo += 250
											attacker << output("You Recieve 1 exp and 1 ryo as a reward for your effort.", "Action.Output")
											spawn() attacker.Levelup()
					
					////////////////////////
					// Mob Death: Logging //
					////////////////////////

					if(src.client && attacker.client)

						var/database/query/query = new({"
							INSERT INTO `[db_table_character_kills]` (`timestamp`, `environment`, `key`, `character`, `identity`, `village`, `faction`, `victim_key`, `victim_character`, `victim_identity`, `victim_village`, `victim_faction`)
							VALUES(?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)"},
							time2text(world.realtime, "YYYY-MM-DD hh:mm:ss"), "pvp", attacker.client.key, attacker.character, attacker.name, attacker.village, attacker.Faction, src.key, src.character, src.name, src.village, src.Faction
						)
						query.Execute(log_db)
						LogErrorDb(query)

					else if(attacker.client)

						var/database/query/query = new({"
							INSERT INTO `[db_table_character_kills]` (`timestamp`, `environment`, `key`, `character`, `identity`, `village`, `faction`, `victim_key`, `victim_character`, `victim_identity`, `victim_village`, `victim_faction`)
							VALUES(?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)"},
							time2text(world.realtime, "YYYY-MM-DD hh:mm:ss"), "pve", attacker.client.key, attacker.character, attacker.name, attacker.village, attacker.Faction, "[src.type]", src.character, src.name, src.village, src.Faction
						)
						query.Execute(log_db)
						LogErrorDb(query)