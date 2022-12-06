mob
	npc
		combat
			New()
				..()
				var/obj/hbar=new /obj/Screen/healthbar/
				var/obj/mbar=new /obj/Screen/manabar/
				src.mouse_over_pointer = /obj/cursors/target
				src.hbar.Add(hbar)
				src.hbar.Add(mbar)

			Death(mob/killer)
				if(src.health <= 0)
					walk(src,0)

					if(killer.client)

						spawn()
							var/database/query/query = new({"
								INSERT INTO `[db_table_character_kills]` (`timestamp`, `environment`, `key`, `character`, `identity`, `village`, `faction`, `victim_key`, `victim_character`, `victim_identity`, `victim_village`, `victim_faction`)
								VALUES(?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)"},
								time2text(world.realtime, "YYYY-MM-DD hh:mm:ss"), "pve", killer.client.ckey, killer.character, killer.name, killer.village, killer.Faction, "[src.type]", src.character, src.name, src.village, src.Faction
							)
							query.Execute(log_db)
							LogErrorDb(query)

					spawn(50)
						if(src)
							del src
				..()

			political_escort
				var/tmp/squad/squad
				var/tmp/squad_leader_ckey
				var/tmp/last_location
				var/tmp/last_location_time
				var/tmp/obj/next_node
				var/tmp/obj/last_node
				health=15000
				maxhealth=15000
				New()
					..()
					src.overlays += pick('Short.dmi','Short2.dmi','Short3.dmi')
					src.overlays += 'Shade.dmi'
					src.overlays+='Shirt.dmi'
					src.overlays+='Sandals.dmi'
					spawn(5) view() << ffilter("<font color='[src.name_color]'>[src.name]</font>: <font color='[COLOR_CHAT]'>[bark]</font>")
					spawn()
						while(src && !src.dead)
							if(src.last_location != src.loc)
								src.last_location = src.loc
								src.last_location_time = world.realtime

							else if(src.last_location == src.loc && src.last_location_time + 2000 <= world.realtime) //last_location_time may be innacurate make sure you test
								src.loc = src.last_node.loc
								step_away(src, src.last_node)
								walk_to(src, src.last_node, 0, 5)

							else if(!CheckState(src, new/state/cant_move))
								walk_to(src, src.next_node, 0, 5)

							sleep(10)

				Death(mob/killer)
					..()
					if(src.squad && src.health <= 0)
						for(var/mob/m in mobs_online)
							if(squad == m.GetSquad())
								squad.mission.status = "Failure"
								squad.mission.complete = world.realtime
								m << output("<b>[squad.mission.name]:</b> The Daimyo has been killed! Our mission is a failure.", "Action.Output")
								spawn() m.client.prompt("The Daimyo has been killed! Our mission is a failure.", "Mission Failed")
								spawn() squad.RefreshMember(m)

						if(killer && killer.village != src.village)
							var/squad/ksquad = killer.GetSquad()
							if(ksquad)
								var/exp_reward = round(squad.mission.mission_exp_mod * squad.mission.A_reward)
								var/ryo_reward = round(squad.mission.mission_ryo_mod * squad.mission.A_reward)
								for(var/mob/m in mobs_online)
									if(ksquad == m.GetSquad())
										m.exp += exp_reward
										m.ryo += ryo_reward
										m.Levelup()
										m << output("<b>[squad.mission.name]:</b> [killer.name] killed an enemy Daimyo and have recieved [exp_reward] exp and [ryo_reward] ryo for your effort!", "Action.Output")
										if(src.village == VILLAGE_LEAF)
											Lootdrop("LeafMissions", m, 5)
										else if(src.village == VILLAGE_SAND)
											Lootdrop("SandMissions", m, 5)
							else
								var/exp_reward = round(squad.mission.mission_exp_mod * squad.mission.A_reward)
								var/ryo_reward = round(squad.mission.mission_ryo_mod * squad.mission.A_reward)
								killer.exp += exp_reward
								killer.ryo += ryo_reward
								killer.Levelup()
								killer << output("<b>[squad.mission.name]:</b> You've killed an enemy Daimyo and have recieved [exp_reward] exp and [ryo_reward] ryo for your effort!", "Action.Output")
								if(src.village == VILLAGE_LEAF)
									Lootdrop("LeafMissions", killer, 5)
								else if(src.village == VILLAGE_SAND)
									Lootdrop("SandMissions", killer, 5)

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
					New()
						..()
						walk_to(src, locate(/obj/escort/pes1), 0, 5)
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

			guard
				var/list/element_pool = list("Fire","Water","Wind","Earth","Lightning")
				var/list/tool_pool = list("Shuriken", "Throwing Needle", "Kunai", "Exploding Tag"/*, "Explosive Kunai"*/)
				var/list/style_pool = list("ranger", "melee", "binder")

				genin
					icon='WhiteMBase.dmi'
					var/punch_cd=0
					var/attacking = 0
					var/tmp/mob/target
					var/retreating = 0
					var/next_punch = "left"
					var/mob/c_target
					var/chosen_tool
					var/chosen_style
					var/movementspeed = 1
					var/last_target
					var/spawned = 0
					var/no_target_counter = 0
					var/original_loc
					health=3000
					maxhealth=3000
					chakra=1000000000
					maxchakra=1000000000
					maxninexp=1000000000
					maxgenexp=1000000000
					maxtaijutsuexp=1000000000
					maxdefexp=1000000000
					maxagilityexp=1000000000
					maxprecisionexp=1000000000
					ninjutsu_total=100
					genjutsu_total=100
					taijutsu_total=100
					defence_total=100
					agility_total=100
					precision_total=100

					Move()
						..()
						if(!src.attacking && !c_target)
							src.FindTarget()

					New()
						..()
						src.PlayAudio('flashbang_explode1.wav', output = AUDIO_HEARERS)
						new/obj/MiscEffects/Smoke(src.loc)
						src.icon = pick('WhiteMBase.dmi', 'DarkMBase.dmi')
						src.overlays += pick(null, 'Deidara.dmi', 'Distance.dmi', 'Long.dmi', 'Mohawk.dmi', 'Neji Hair.dmi', 'Short.dmi','Short2.dmi','Short3.dmi', 'Spikey.dmi')
						src.overlays += 'Shirt.dmi'
						src.overlays += 'Sandals.dmi'
						src.overlays += 'Shade.dmi'
						src.original_loc = src.loc
						src.attkspeed=(8-(0.03*src.agility_total))
						src.PickElement()
						src.PickTools()
						src.PickStyle()
						src.GainJutsu()
						src.ryo = rand(50,150)
						spawn() src.CombatAI()

					Death(mob/killer)
						killer.infamy_points++
						killer.exp += 4
						..()

					proc/Idle()
						src.attacking = 0
						src.retreating = 0
						src.Target_Remove()
						for(var/mob/Clones/C in src.Clones)
							C.health=0
							C.Death(src)
						src.FindTarget()
						if(!CheckState(src, new/state/in_combat) && src.loc != src.original_loc) src.ResetAI()

					proc/ResetAI()
						for(var/mob/Clones/C in src.Clones)
							C.health=0
							C.Death(src)
						if(src.spawned)
							src.PlayAudio('flashbang_explode1.wav', output = AUDIO_HEARERS)
							new/obj/MiscEffects/Smoke(src.loc)
							del(src)
						else
							src.health = src.maxhealth
							src.chakra = src.maxchakra
							src.PlayAudio('flashbang_explode1.wav', output = AUDIO_HEARERS)
							new/obj/MiscEffects/Smoke(src.loc)
							src.loc = src.original_loc
							src.dir = SOUTH
							src.PlayAudio('flashbang_explode1.wav', output = AUDIO_HEARERS)
							new/obj/MiscEffects/Smoke(src.loc)
							walk(src, 0)

					proc/FindTarget()
						if(!c_target) sleep(10)
						if(src)
							for(var/mob/M in orange(30))
								if(istype(M,/mob/npc) || istype(M,/mob/training) || M.village == src.village || M.dead || M.infamy_points < 1) continue
								if(M)
									src.Target_Remove()
									src.Target_Atom(M)
									AddState(src, new/state/in_combat, 150)
									src.attacking = 1
									src.last_target = M
								else
									src.Target_Remove()

					proc/CastDefensive()
						walk(src, 0)
						if(prob(0)) // set higher than zero to activate clones
							src.Clone_Jutsu()
							spawn(50)
								for(var/mob/Clones/C in src.Clones)
									C.health=0
									C.Death(src)
						else if(prob(30))src.Body_Replacement_Technique()

						if(prob(50))
							src.Advanced_Body_Replacement_Technique()

					proc/CombatAI()
						while(src)
							if(!CheckState(src, new/state/recently_hit) && src.tenacity > 0)
								src.tenacity -= 5
								if(src.tenacity < 0) src.tenacity = 0
							if(src.kawarmi && CheckState(src, new/state/cant_move))
								if(prob(40)) src.Dodge()
							if(!CheckState(src, new/state/cant_move))
								src.icon_state = "run"
								c_target = src.Target_Get(TARGET_MOB)
								if(istype(c_target, /mob/npc)) c_target = null
								if(src.c_target && src.attacking && !src.dead && !c_target.dead && !CheckState(src, new/state/cant_attack))
									if(prob(80))
										src.CombatIdle()
									else if(prob(10)) src.CastDefensive()
									else
										src.EngageTarget()
								else if(!src.dead) src.Idle()
							else
								walk(src, 0)
							sleep(3)

					proc/CombatIdle()
						if(c_target)
							switch(src.chosen_style)
								if("melee")
									if(prob(50))
										step_to(src, c_target)
									else
										step_rand(src)
								if("ranger")
									if(get_dist(src.loc, c_target.loc) < 8)
										if(prob(50)) step_away(src, c_target, 8)
										else step_rand(src)
									else step_to(src, c_target)
								if("binder")
									if(prob(50)) step_rand(src)
									else if(prob(50)) step_to(src, c_target)
									else if(prob(30)) step_away(src, c_target, 8)

					proc/EngageTarget()
						switch(src.chosen_style)
							if("melee")
								if(prob(70))
									if(!CheckState(src, new/state/AI_is_punching)) src.PunchTarget()
								else if(prob(40)) src.UseTool()
								else src.CastJutsuMelee()
							if("ranger")
								if(prob(70)) src.UseTool()
								else if(prob(60)) src.CastJutsuRanger()
								else src.UseTool()

							if("binder")
								if(prob(50)) src.CastJutsuBinder()
								else if(prob(60)) src.UseTool()
								else src.CastJutsuBinder()


					proc/PunchTarget(mob/M)
						if(c_target.loc != get_step(src, src.dir) && get_dist(src.loc, c_target.loc) > 5 && !CheckState(src, new/state/cant_attack) && !CheckState(src, new/state/swimming))
							src.UseFlicker()
						else if(prob(20)) src.UseFlicker()
						AddState(src, new/state/AI_is_punching, 20)
						while(CheckState(src, new/state/AI_is_punching))
							if(prob(10))
								if(!CheckState(src, new/state/cant_move)) step_rand(src)
							else if(!CheckState(src, new/state/cant_move)) walk_towards(src, c_target, src.movementspeed)
							src.Basic_Attack()
							sleep(0.1)

					proc/Retreat(var/dist)
						if(c_target && get_dist(src.loc, c_target.loc) < dist)
							if(!CheckState(src, new/state/cant_move)) walk_away(src, c_target, dist, src.movementspeed)
						sleep(7)
						walk(src, 0)

					proc/CastJutsuMelee(mob/M)
						walk(src, 0)
						switch(src.Element)
							if("Earth")
								var/which_combo = pick(1,2,3)
								switch(which_combo)
									if(1)
										src.Earth_Style_Dark_Swamp()
										sleep(3)
										src.PunchTarget()
									if(2)
										src.UseFlicker()
										src.Earth_Disruption()
										src.PunchTarget()
									if(3)
										src.UseFlicker()
										if(!CheckState(src, new/state/cant_move)) step_away(src, c_target)
										src.Mud_Dragon_Projectile()
										sleep(5)

							if("Fire")
								var/which_combo = pick(1,2,3)
								switch(which_combo)
									if(1)
										src.UseFlicker()
										step_away(src, c_target)
										sleep(1)
										step_away(src, c_target)
										src.AFire_Ball()
										sleep(2)
										src.PunchTarget()
									if(2)
										src.UseFlicker()
										src.Fire_Ball()
										sleep(2)
										src.PunchTarget()
									if(3)
										src.UseFlicker()
										step_away(src, c_target)
										src.Fire_Dragon_Projectile()
										sleep(5)


							if("Water")
								var/which_combo = pick(1,2)
								if(prob(66))
									src.UseFlicker()
									if(c_target) src.dir = get_dir(src.loc, c_target.loc)
									src.Water_Release_Exploding_Water_Colliding_Wave()
									sleep(5)

								else
									switch(which_combo)
										if(1)
											src.UseFlicker()
											if(c_target) src.dir = get_dir(src.loc, c_target.loc)
											src.Teppoudama()
											src.PunchTarget()
										if(2)
											src.UseFlicker()
											step_away(src, c_target)
											src.Water_Dragon_Projectile()
											sleep(5)

							if("Wind")
								var/which_combo = pick(1,2,3)
								switch(which_combo)
									if(1)
										src.UseFlicker()
										if(c_target) src.dir = get_dir(src.loc, c_target.loc)
										src.Blade_of_Wind()
										src.PunchTarget()
									if(2)
										src.UseFlicker()
										src.Wind_Tornados()
									if(3)
										src.UseFlicker()
										step_away(src, c_target)
										src.Wind_Dragon_Projectile()
										sleep(5)

							if("Lightning")
								var/which_combo = pick(1,2,3)
								switch(which_combo)
									if(1)
										src.UseFlicker()
										src.Chidori()
										sleep(10)
										src.PunchTarget()
									if(2)
										src.UseFlicker()
										spawn() src.Chidori_Nagashi()
										src.PunchTarget()
									if(3)
										src.UseFlicker()
										src.Chidori_Jinrai()
										src.PunchTarget()

						src.jutsu_cooldowns = list()


					proc/CastJutsuRanger(mob/M)
						walk(src, 0)
						switch(src.Element)
							if("Earth")
								var/which_combo = pick(1,2,3)
								switch(which_combo)
									if(1)
										src.Doryuusou()
									if(2)
										src.MudWall()
									if(3)
										src.Mud_Dragon_Projectile()
										sleep(5)


							if("Fire")
								var/which_combo = pick(1,2,3)
								switch(which_combo)
									if(1)
										src.Phoenix_Immortal_Fire_Technique()
									if(2)
										src.AFire_Ball()
									if(3)
										src.Magma_Needles()



							if("Water")
								var/which_combo = pick(1,2)
								if(prob(66))
									src.UseFlicker()
									if(c_target) src.dir = get_dir(src.loc, c_target.loc)
									src.Water_Release_Exploding_Water_Colliding_Wave()
									sleep(5)

								else
									switch(which_combo)
										if(1)
											src.WaterShark()
										if(2)
											src.Teppoudama()


							if("Wind")
								var/which_combo = pick(1,2,3)
								switch(which_combo)
									if(1)
										src.Sickle_Weasel_Technique()
									if(2)
										src.Wind_Tornados()
									if(3)
										src.Wind_Dragon_Projectile()
										sleep(5)

							if("Lightning")
								var/which_combo = pick(1,2,3)
								switch(which_combo)
									if(1)
										src.Chidori_Needles()
									if(2)
										src.Chidori_Jinrai()
									if(3)
										src.LightningBalls()

						src.jutsu_cooldowns = list()


					proc/CastJutsuBinder(mob/M)
						walk(src, 0)
						switch(src.Element)
							if("Earth")
								var/which_combo = pick(1,2,3)
								switch(which_combo)
									if(1)
										src.Earth_Release_Earth_Cage()
									if(2)
										src.Earth_Style_Dark_Swamp()
									if(3)
										src.Earth_Release_Mud_River()

							if("Fire")
								var/which_combo = pick(1,2,3)
								switch(which_combo)
									if(1)
										src.dir = get_dir(src.loc, c_target.loc)
										src.Fire_Release_Ash_Pile_Burning()
										src.ArrowTasked = null
										src.ashbomb()
									if(2)
										src.Magma_Crush()
									if(3)
										src.Fire_Ball()



							if("Water")
								var/which_combo = pick(1,2)
								if(prob(66))
									src.UseFlicker()
									if(c_target) src.dir = get_dir(src.loc, c_target.loc)
									src.Water_Release_Exploding_Water_Colliding_Wave()
									sleep(5)

								else
									switch(which_combo)
										if(1)
											src.UseFlicker()
											src.WaterPrison()
											sleep(30)
										if(2)
											src.UseFlicker()
											step_away(src, c_target)
											src.Water_Dragon_Projectile()
											sleep(5)


							if("Wind")
								var/which_combo = pick(1,2,3)
								switch(which_combo)
									if(1)
										src.dir = get_dir(src.loc, c_target.loc)
										src.FuutonDaitoppa()
									if(2)
										src.UseFlicker()
										src.Wind_Shield()
									if(3)
										src.Wind_Dragon_Projectile()
										sleep(5)

							if("Lightning")
								var/which_combo = pick(1,2,3)
								switch(which_combo)
									if(1)
										if(prob(40)) src.Kirin()
									if(2)
										src.Chidori_Needles()
									if(3)
										src.Chidori()
										sleep(10)

					proc/UseTool(mob/M)
						if(src.equipped=="Shurikens")
							if(src.chosen_style == "ranger")
								src.Retreat(8)
							src.Throw()

						if(src.equipped=="ExplodeKunais")
							if(src.chosen_style == "ranger")
								src.Retreat(8)
							else
								src.Retreat(5)
							src.Throw()

						if(src.equipped=="Kunais")
							if(src.chosen_style == "ranger")
								src.Retreat(8)
							src.Throw()

						if(src.equipped=="Needles")
							if(src.chosen_style == "ranger")
								src.Retreat(8)
							src.Throw()

						if(src.equipped=="ExplosiveTags")
							if(!src.tagcd)
								src.UseFlicker()
								src.Throw()
								src.Retreat(5)
								src.Dodge()

					proc/UseFlicker(mob/M)
						src.Shunshin()
						sleep(5)

					proc/PickElement()
						src.Element = pick(src.element_pool)
						src.element_pool -= src.Element
						src.Element2 = pick(src.element_pool)

					proc/GainJutsu()
						for(var/obj/Jutsus/J in world)
							if(J.Element == src.Element || J.give_to_guards)
								if(J.type in src.jutsus_learned) continue
								src.jutsus += J
								src.jutsus_learned += J.type
						for(var/obj/Jutsus/J2 in src.jutsus)
							J2.level = 4

					proc/PickTools()
						src.chosen_tool = pick(src.tool_pool)
						for(var/obj/Inventory/Weaponry/C)
							if(C.name == src.chosen_tool)
								var/obj/Inventory/I=new C.type()
								I.stacks = 10000
								src.RecieveItem(I)
								break
						switch(src.chosen_tool)
							if("Shuriken") src.equipped = "Shurikens"
							if("Throwing Needle") src.equipped = "Needles"
							if("Kunai") src.equipped = "Kunais"
							if("Exploding Kunai") src.equipped = "ExplodeKunais"
							if("Explosive Tag") src.equipped = "ExplosiveTags"

					proc/PickStyle()
						src.chosen_style = pick(src.style_pool)
						if(chosen_style == "melee") src.Specialist = SPECIALIZATION_TAIJUTSU

					Leaf
						name = "Genin Guard"
						village = VILLAGE_LEAF
						New()
							..()
							src.overlays += 'HeadBandLeaf.dmi'

					Sand
						name = "Genin Guard"
						village = VILLAGE_SAND
						New()
							..()
							src.overlays += 'HeadBandSand.dmi'

			white_zetsu
				name = "White Zetsu"
				icon='zettsu.dmi'
				var/punch_cd=0
				var/attacking = 0
				var/tmp/mob/target
				var/retreating = 0
				var/next_punch = "left"
				health=2500
				maxhealth=2500

				SetName() return

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
						if(!CheckState(src, new/state/recently_hit) && src.tenacity > 0)
							src.tenacity -= 5
							if(src.tenacity < 0) src.tenacity = 0
						if(src.target && src.attacking && !src.dead)
							if(get_dist(src,src.target) <= 1 && !src.punch_cd) src.AttackTarget(src.target)
							else if(get_dist(src,src.target) > 20) src.Idle()
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
							if(istype(M,/mob/npc) || istype(M,/mob/training) || M.village == VILLAGE_AKATSUKI || M.dead) continue
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
						M.DealDamage(300,src,"TaiOrange",0,0,1)
						M.UpdateHMB()
						M.Death(src)
						src.punch_cd=1
	//					spawn() CombatAI()
						sleep(2)
						src.Retreat(M)
						spawn(4)
						src.punch_cd=0

				proc/Retreat(mob/M)
					if(src && M)
						walk(src,0)
						step_rand(src)
						walk_away(src,M,10,2)
						src.retreating = 1
						src.FindTarget()
	//					spawn(1) src.CombatAI()
