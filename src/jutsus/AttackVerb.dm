mob
	verb
		Basic_Attack()
			set hidden=1
			var/attack_speed
			if(src.Specialist == SPECIALIZATION_TAIJUTSU)
				attack_speed = src.attkspeed - 0.1
			else
				attack_speed = src.attkspeed + 0.05

			if(CheckState(src, new/state/knocked_down)) return 0

			if(CheckState(src, new/state/cant_attack) || CheckState(src, new/state/punching))

				return
			if(src.multisized==1)//multisizestuff
				return

			var/mob/c_target=src.Target_Get(TARGET_MOB)
			if(CheckState(src, new/state/sand_shield))
				if(src.Clan == CLAN_SAND || src.Clan2 == CLAN_SAND)
					if(!CheckState(src, new/state/cant_attack) && !CheckState(src, new/state/punching) && !CheckState(src, new/state/swimming))
						AddState(src, new/state/punching, attack_speed)
						var/obj/O = new/obj
						O.loc = src.loc
						O.icon = 'Sand Shield.dmi'
						O.icon_state = "spike"
						O.pixel_x=-32
						O.layer=12
						O.layer=MOB_LAYER+100
						var/PL = list()
						for(var/mob/PO in orange(1))PL+=PO
						if(length(PL)<>0)
							var/mob/W = pick(PL)
							src.Target_Atom(W)
							src.dir = get_dir(src,W)
						step(O,src.dir)
						if(O.dir == NORTH)O.layer = OBJ_LAYER
						spawn(2)if(O)del(O)
						for(var/mob/M in orange(1,O))
							if(M <> src)
								M.DealDamage(src.ninjutsu_total/2,src,"NinBlue",0,0,1)
				return
			if(ChakraCheck(0)) return
			if(c_target&&!src.likeaclone)
				if(src.lungecounter==0)
					step(src, get_dir(src, c_target))
					src.lungecounter=1
					if(src.equipped=="Weights")
						spawn(40-((src.agility_total/200)*30))lungecounter=0
						if(loc.loc:Safe!=1) src.LevelStat("Agility",round(rand(8,20)*trainingexp))
					else
						spawn(20-((src.agility_total/200)*15))lungecounter=0
						if(loc.loc:Safe!=1) src.LevelStat("Agility",round(rand(4,11)*trainingexp))
			if(src.likeaclone)
				var/mob/Clones/SC=src.likeaclone
				if(!CheckState(SC, new/state/cant_attack))
					if(!CheckState(SC, new/state/punching))
						SC.attkspeed = src.attkspeed
						AddState(SC, new/state/punching, SC.attkspeed)
						if(SC.icon_state<>"blank")
							if(SC.Hand=="Left")
								flick("punchl",SC)
								SC.Hand="Right"
							else
								if(SC.Hand=="Right")
									flick("punchr",SC)
									SC.Hand="Kick"
								else
									if(SC.Hand=="Kick")
										flick("kick",SC)
										SC.Hand="Left"
						SC.PlayAudio('Swing5.ogg', output = AUDIO_HEARERS)
						spawn(2)
							for(var/mob/C in orange(SC,1))
								SC.dir = get_dir(SC,C)
								for(c_target in get_step(SC,SC.dir))
									if(c_target in get_step(SC,SC.dir))
										if(c_target.dead==0&&!istype(c_target,/mob/npc/)&&c_target!=SC.Owner || c_target.dead==0&&istype(c_target,/mob/npc/combat)&&c_target!=SC.Owner)
											if(c_target.fightlayer==SC.fightlayer)
												if(c_target.client)spawn()c_target.ScreenShake(1)
												if(c_target.dodge==0)
													var/undefendedhit=src.taijutsu_total
													if(undefendedhit<0)undefendedhit=1
													c_target.DealDamage(undefendedhit+ (((src.taijutsu_total * 0.1)* src.mystical_palms) + ((src.taijutsu_total * 0.025)* src.bonesword) + ((src.taijutsu_total * 0.05) * src.Gates)),src,"TaiOrange",0,0,1)
													if(src.Gates>0) src.DealDamage((((src.taijutsu_total / 200)*3) + (src.health * 0.001))* src.Gates, src, "maroon")
													if(SC.loc.loc:Safe!=1) LevelStat(SPECIALIZATION_TAIJUTSU,10*punchstatexp)
													if(SC.Hand=="Left") SC.PlayAudio('LPunchHIt.ogg', output = AUDIO_HEARERS)
													if(SC.Hand=="Right") SC.PlayAudio('HandDam_Normal2.ogg', output = AUDIO_HEARERS)
												else
													if(SC.agility>=c_target.agility_total)
														var/defendedhit=SC.taijutsu_total
														if(defendedhit<0)defendedhit=1
														src.Levelup()
														if(defence_total<SC.taijutsu_total/2)
															var/obj/Drag=new /obj/Drag/Dirt(c_target.loc)
															Drag.dir=c_target.dir
															step(c_target,SC.dir)
															c_target.dir = get_dir(c_target,SC)
															step_to(SC,c_target,1)
														c_target.DealDamage(defendedhit+ (((src.taijutsu_total * 0.1)* src.mystical_palms) + ((src.taijutsu_total * 0.025)* src.bonesword) + ((src.taijutsu_total * 0.05) * src.Gates)),src,"TaiOrange",0,0,1)
														if(src.Gates>0) src.DealDamage((((src.taijutsu_total / 200)*3) + (src.health * 0.001))* src.Gates, src, "maroon")
														flick("defendhit",c_target)
														SC.PlayAudio('Counter_Success.ogg', output = AUDIO_HEARERS)
													else
														flick("dodge",c_target)
														if(c_target.loc.loc:Safe!=1) c_target.LevelStat("Agility",rand(1,2))
								break
							for(var/obj/Training/T in get_step(SC,SC.dir))//This is all punching logs.
								if(T.health>=1)
									var/undefendedhit=round(SC.taijutsu_total)
									T.health-=undefendedhit
									if(T) if(T.Good) LevelStat(SPECIALIZATION_TAIJUTSU,10*punchstatexp)
									else LevelStat(SPECIALIZATION_TAIJUTSU,10*punchstatexp)
									if(SC.Hand=="Left") SC.PlayAudio('LPunchHIt.ogg', output = AUDIO_HEARERS)
									if(SC.Hand=="Right") SC.PlayAudio('HandDam_Normal2.ogg', output = AUDIO_HEARERS)
									T.Break(src)


			if(!CheckState(src, new/state/cant_attack) && !src.likeaclone && !dead && !rest && !CheckState(src, new/state/punching) && !CheckState(src, new/state/swimming))
				var/mob/c_target2=src.Target_Get(TARGET_MOB)
				if(c_target2)src.dir = get_dir(src,c_target2)
				else
					src.Target_A_Mob()
					var/mob/c_target23=src.Target_Get(TARGET_MOB)
					if(c_target23)src.dir = get_dir(src,c_target23)
				var/mob/M  = src.puppets[1]
				if(M)
					M.loc = src.loc
					M.dir = src.dir
					step(M,src.dir)
					spawn(1)
						step(M,src.dir)
						spawn(1)step(M,src.dir)
					var/obj/A = new/obj/MiscEffects/Smoke(M.loc)
					A.loc=M.loc
				AddState(src, new/state/punching, attack_speed)
				if(istype(c_target, /mob/training/Rotating_Dummy))
					AddState(c_target, new/state/dummy_was_hit, -1)
				if(src.icon_state<>"blank")
					if(src.byakugan==1)
						var/PL = list()
						for(var/mob/PO in orange(1))PL+=PO
						if(length(PL)<>0)
							var/mob/W = pick(PL)
							src.Target_Atom(W)
							src.dir = get_dir(src,W)
					if(src.Gates >= 4)//HERE
						var/mob/W=src.Target_Get(TARGET_MOB)
						if(W)
							src.dir = get_dir(src,W)
							src.loc = W.loc
							step(src,W.dir)
							src.dir = get_dir(src,W)
							var/obj/SH = new/obj
							SH.loc = src.loc
							SH.icon = 'Shunshin.dmi'
							flick("fl",SH)
							spawn(3)if(SH)del(SH)
					if(src.Hand=="Left")
						if(Specialist==SPECIALIZATION_TAIJUTSU||Specialist2==SPECIALIZATION_TAIJUTSU)combo++
						if(src.Clan != CLAN_SAND || src.Clan2 != CLAN_SAND)
							flick("punchl",src)

							if(CheckState(src, new/state/Iron_Fists) && !CheckState(src, new/state/Iron_Fist_Punching_Left) && !CheckState(src, new/state/Iron_Fist_Grabbing_Left) && !CheckState(src, new/state/Iron_Fist_Grabbed_Left))
								flick("trans", src.left_iron_fist)
								AddState(src, new/state/Iron_Fist_Punching_Left, 2)

							if(src.bugpass)
								src.DealDamage(50,src,"aliceblue",0,1)
								var/obj/O = new/obj
								O.loc = src.loc
								O.icon = 'Insect Cocoon.dmi'
								O.pixel_x=-16
								O.icon_state = ""
								O.dir = src.dir
								O.layer = MOB_LAYER+1
								flick("punchl",O)
								var/obj/O2 = new/obj
								O2.loc =src.loc
								step(O2,src.dir)
								for(var/mob/Mv in orange(O2))if(Mv <> src)step_to(Mv,O2)
								spawn(5)
									if(O)del(O)
									if(O2)del(O2)
						src.Hand="Right"
						if(src.Clan == CLAN_SAND || src.Clan2 == CLAN_SAND)
							var/obj/SAND = new/obj
							SAND.loc = src.loc
							SAND.layer = src.layer+1
							SAND.dir = src.dir
							SAND.pixel_x=-16
							flick('Sand Attack 1.dmi',SAND)
							spawn(4)if(SAND)del(SAND)
						for(var/mob/Clones/Bunshin/C in world)if(C.Owner==src)flick("punchl",C)
					else
						if(src.Hand=="Right")
							if(src.Clan != CLAN_SAND || src.Clan2 != CLAN_SAND)
								flick("punchr",src)

								if(CheckState(src, new/state/Iron_Fists) && !CheckState(src, new/state/Iron_Fist_Punching_Right) && !CheckState(src, new/state/Iron_Fist_Grabbing_Right) && !CheckState(src, new/state/Iron_Fist_Grabbed_Right))
									flick("trans", src.right_iron_fist)
									AddState(src, new/state/Iron_Fist_Punching_Right, 2)

								if(src.bugpass)
									var/obj/O = new/obj
									O.loc = src.loc
									O.icon = 'Insect Cocoon.dmi'
									O.pixel_x=-16
									O.icon_state = ""
									O.dir = src.dir
									O.layer = MOB_LAYER+1
									flick("punchr",O)
									var/obj/O2 = new/obj
									O2.loc =src.loc
									step(O2,src.dir)
									for(var/mob/Mv in orange(O2))if(Mv <> src)step_to(Mv,O2)
									spawn(5)
										if(O)del(O)
										if(O2)del(O2)
							if(Specialist==SPECIALIZATION_TAIJUTSU||Specialist2==SPECIALIZATION_TAIJUTSU)
								src.Hand="Kick"
								combo++
							else src.Hand="Left"
							if(src.Clan == CLAN_SAND == src.Clan2 == CLAN_SAND)
								var/obj/SAND = new/obj
								SAND.loc = src.loc
								SAND.layer = src.layer-1
								SAND.dir = src.dir
								SAND.pixel_x=-16
								flick('Sand Attack 2.dmi',SAND)
								spawn(4)if(SAND)del(SAND)
							if(src.byakugan==1)
								var/obj/GF = new/obj
								GF.loc = src.loc
								GF.layer=200
								GF.dir = src.dir
								GF.icon = 'PressurePoint.dmi'
								for(var/obj/Jutsus/Byakugan/J in src.jutsus)
									if(J.level == 4)flick('GentleFist.dmi',GF)
									else flick("[J.level]",GF)
								switch(src.dir)
									if(WEST) GF.pixel_x=-16
								spawn(4)if(GF)del(GF)
							if(src.mystical_palms==1)
								var/obj/GF = new/obj
								GF.loc = src.loc
								GF.layer=200
								GF.dir = src.dir
								GF.icon = 'PressurePoint.dmi'
								flick('GentleFist.dmi',GF)
								switch(src.dir)
									if(WEST) GF.pixel_x=-16
								spawn(4)if(GF)del(GF)
							for(var/mob/Clones/Bunshin/C in world)if(C.Owner==src)flick("punchr",C)
						else
							if(src.Hand=="Kick")
								if(Specialist==SPECIALIZATION_TAIJUTSU||Specialist2==SPECIALIZATION_TAIJUTSU)combo++
								flick("kick",src)
								src.Hand="Left"
								for(var/mob/Clones/Bunshin/C in world)if(C.Owner==src)flick("kick",C)
				src.PlayAudio('Swing5.ogg', output = AUDIO_HEARERS)
				if(src.agility_total<50)
					spawn(2)
						for(c_target in get_step(src,src.dir))
							src.dir = get_dir(src,c_target)
							src.Target_Atom(c_target)
							if(c_target in get_step(src,src.dir))
								if(c_target.dead==0&&!istype(c_target,/mob/npc/) || c_target.dead==0&&istype(c_target,/mob/npc/combat))
									var/canhityou=1
									if(c_target.Clan == CLAN_SAND || c_target.Clan2 == CLAN_SAND)
										var/blockchance = rand(1,2)
										if(c_target.dir == get_dir(c_target,src))blockchance = 1
										if(blockchance==1)

											var/obj/AW = new/obj
											AW.loc = c_target.loc
											AW.dir = c_target.dir
											AW.pixel_x=-16
											AW.layer = MOB_LAYER+1
											var/obj/AW2 = new/obj
											AW2.loc = c_target.loc
											AW2.dir = c_target.dir
											AW2.pixel_x=-16
											AW2.layer = MOB_LAYER-1
											AW.icon = 'sand block.dmi'
											AW2.icon = 'sand block.dmi'
											flick("over player",AW)
											flick("under player",AW2)
											canhityou=0
											spawn(3)
												if(AW)del(AW)
												if(AW2)del(AW2)
									if(c_target.fightlayer==src.fightlayer && canhityou==1)
										if(c_target.client)	spawn()c_target.ScreenShake(1)
										if(c_target.dodge==0)
											var/bonus=0
											if(src.Gates == 1)
												bonus=10
											if(src.Gates == 2)
												bonus=15
												var/obj/A = new/obj/MiscEffects/MeteorDust(src.loc)
												A.pixel_x=-30
												A.pixel_y=-10
												A.dir=src.dir
												A.icon_state = "0"
											if(src.Gates == 3)
												bonus=20
												var/obj/A = new/obj/MiscEffects/MeteorDust(src.loc)
												A.pixel_x=-30
												A.pixel_y=-10
												A.dir=src.dir
												A.icon_state = "1"
											if(src.Gates == 4)
												bonus=25
												var/obj/A = new/obj/MiscEffects/MeteorDust(src.loc)
												A.pixel_x=-30
												A.pixel_y=-10
												A.dir=src.dir
												A.icon_state = "2"
											if(src.Gates == 5)
												bonus=30
												var/obj/A = new/obj/MiscEffects/MeteorDust(src.loc)
												A.pixel_x=-30
												A.pixel_y=-10
												A.dir=src.dir
												A.icon_state = "max"
											if(bugpass)bonus+=3
											if(Sharingan)bonus+=Sharingan
											if(src.mystical_palms)bonus+=5
											bonus+=src.bonesword
											var/undefendedhit=src.taijutsu_total
											if(undefendedhit<0)undefendedhit=1
											if(c_target.Sharingan)
												if(prob((c_target.Sharingan*10)))
													undefendedhit=1
													flick("dodge",c_target)
												else
													undefendedhit=(c_target.taijutsu_total*0.5)
													if(undefendedhit<0) undefendedhit=1
													flick("defend",c_target)
											c_target.DealDamage(undefendedhit + (((src.taijutsu_total * 0.1) * src.mystical_palms) + ((src.taijutsu_total * 0.025) * src.bonesword) + ((src.taijutsu_total * 0.05) * src.Gates)),src,"TaiOrange",0,0,1)
											if(src.Gates>0) src.DealDamage((((src.taijutsu_total / 200)*3) + (src.health * 0.001))* src.Gates, src, "maroon")
											if(src.byakugan==1)
												for(var/obj/Jutsus/Byakugan/J in src.jutsus)
													c_target.DealDamage(undefendedhit/3, src, "aliceblue", 0, 1)
											if(src.loc.loc:Safe!=1) LevelStat(SPECIALIZATION_TAIJUTSU,10*punchstatexp)
											if(src.Hand=="Right") src.PlayAudio('LPunchHIt.ogg', output = AUDIO_HEARERS)
											if(src.Hand=="Kick")
												bonus+=2
												src.PlayAudio('HandDam_Normal2.ogg', output = AUDIO_HEARERS)
											if(src.Hand=="Left") src.PlayAudio('KickHit.ogg', output = AUDIO_HEARERS)
											if(src.Gates >= 5 && !CheckState(src, new/state/cant_attack) && !CheckState(src, new/state/cant_move))
												c_target.icon_state="push"
												AddState(c_target, new/state/cant_move, 0.1)
												step_away(c_target,src)
												walk(c_target,c_target.dir)
												if(c_target.client)spawn() c_target.ScreenShake(3)
												spawn(3)
													if(c_target)
														walk(c_target,0)
														if(!CheckState(c_target, new/state/swimming))c_target.icon_state=""
											if(bonesword)
												if(c_target.icon_state == "")
													AddState(c_target, new/state/cant_move, bonesword)
										else
											if(src.agility_total>=c_target.agility_total || src.Gates >= 3)
												var/bonus=0
												if(src.mystical_palms)bonus+=5
												if(bugpass)bonus+=3
												bonus+=src.bonesword
												var/defendedhit=src.taijutsu_total
												if(defendedhit<0)defendedhit=1
												src.Levelup()
												if(defence_total<src.taijutsu_total/2)
													var/obj/Drag=new /obj/Drag/Dirt(c_target.loc)
													Drag.dir=c_target.dir
													step(c_target,src.dir)
													c_target.dir = get_dir(c_target,src)
													step_to(src,c_target,1)
												c_target.DealDamage(defendedhit + (((src.taijutsu_total * 0.1)* src.mystical_palms) + ((src.taijutsu_total * 0.025)* src.bonesword) + ((src.taijutsu_total * 0.05) * src.Gates)),src,"TaiOrange",0,0,1)
												if(src.Gates>0) src.DealDamage((((src.taijutsu_total / 200)*3) + (src.health * 0.001))* src.Gates, src, "maroon")
												if(src.byakugan==1)
													for(var/obj/Jutsus/Byakugan/J in src.jutsus)
														c_target.DealDamage(defendedhit/3, src, "aliceblue", 0, 1)
												if(bonesword)
													if(c_target.icon_state == "")
														AddState(c_target, new/state/cant_move, bonesword)
												flick("defendhit",c_target)
												src.PlayAudio('Counter_Success.ogg', output = AUDIO_HEARERS)
											else
												flick("dodge",c_target)
												if(c_target.loc.loc:Safe!=1) c_target.LevelStat("Agility",rand(1,2))
												c_target.Levelup()

						for(var/obj/Training/T in get_step(src,src.dir))
							if(T.health > 0)//also logs
								var/undefendedhit=round(src.taijutsu_total)
								T.health-=undefendedhit
								if(T) if(T.Good) LevelStat(SPECIALIZATION_TAIJUTSU,10*punchstatexp)
								else LevelStat(SPECIALIZATION_TAIJUTSU,10*punchstatexp)
								if(src.Hand=="Right") src.PlayAudio('LPunchHIt.ogg', output = AUDIO_HEARERS)
								if(src.Hand=="Kick") src.PlayAudio('HandDam_Normal2.ogg', output = AUDIO_HEARERS)
								if(src.Hand=="Left") src.PlayAudio('KickHit.ogg', output = AUDIO_HEARERS)
								T.Break(src)
				else
					if(src.agility_total>=50)
						for(c_target in get_step(src,src.dir))
							src.dir = get_dir(src,c_target)
							src.Target_Atom(c_target)
							if(c_target in get_step(src,src.dir))
								if(c_target.dead==0&&!istype(c_target,/mob/npc/) || c_target.dead==0&&istype(c_target,/mob/npc/combat))
									var/canhityou=1
									if(c_target.Clan == CLAN_SAND || c_target.Clan2 == CLAN_SAND)
										var/blockchance = rand(1,3)
										if(c_target.dir == get_dir(c_target,src))blockchance = rand(1,2)
										if(blockchance==1)

											var/obj/AW = new/obj
											AW.loc = c_target.loc
											AW.dir = c_target.dir
											AW.layer = MOB_LAYER+1
											AW.pixel_x=-16
											var/obj/AW2 = new/obj
											AW2.loc = c_target.loc
											AW2.pixel_x=-16
											AW2.dir = c_target.dir
											AW2.layer = MOB_LAYER-1
											AW.icon = 'sand block.dmi'
											AW2.icon = 'sand block.dmi'
											flick("over player",AW)
											flick("under player",AW2)
											canhityou=0
											spawn(3)
												if(AW)del(AW)
												if(AW2)del(AW2)
									if(c_target.fightlayer==src.fightlayer && canhityou==1)
										if(c_target.client)spawn()c_target.ScreenShake(1)
										if(c_target.dodge==0)
											var/bonus=0
											if(src.Gates == 1)
												bonus=2
											if(src.Gates == 2)
												bonus=4
												var/obj/A = new/obj/MiscEffects/MeteorDust(src.loc)
												A.pixel_x=-30
												A.pixel_y=-10
												A.dir=src.dir
												A.icon_state = "0"
											if(src.Gates == 3)
												bonus=6
												var/obj/A = new/obj/MiscEffects/MeteorDust(src.loc)
												A.pixel_x=-30
												A.pixel_y=-10
												A.dir=src.dir
												A.icon_state = "1"
											if(src.Gates == 4)
												bonus=8
												var/obj/A = new/obj/MiscEffects/MeteorDust(src.loc)
												A.pixel_x=-30
												A.pixel_y=-10
												A.dir=src.dir
												A.icon_state = "2"
											if(src.Gates == 5)
												bonus=10
												var/obj/A = new/obj/MiscEffects/MeteorDust(src.loc)
												A.pixel_x=-30
												A.pixel_y=-10
												A.dir=src.dir
												A.icon_state = "max"
											bonus+=src.bonesword
											if(bugpass)bonus+=3
											if(Sharingan)bonus+=Sharingan
											if(src.mystical_palms)bonus+=5
											if(src.Hand=="Kick")bonus+=2
											var/undefendedhit=src.taijutsu_total
											if(undefendedhit<0)undefendedhit=1
											if(c_target.Sharingan)
												if(prob(c_target.Sharingan*10))
													undefendedhit=1
													flick("dodge",c_target)
												else
													undefendedhit=(c_target.taijutsu_total/2)
													if(undefendedhit<0) undefendedhit=1
													flick("defend",c_target)
											if(c_target.Owner!=src)
												c_target.DealDamage(undefendedhit + (((src.taijutsu_total * 0.1)* src.mystical_palms) + ((src.taijutsu_total * 0.025)* src.bonesword) + ((src.taijutsu_total * 0.05) * src.Gates)),src,"TaiOrange",0,0,1)
												if(src.Gates>0) src.DealDamage((((src.taijutsu_total / 200)*3) + (src.health * 0.001))* src.Gates, src, "maroon")
												if(src.byakugan==1)
													for(var/obj/Jutsus/Byakugan/J in src.jutsus)
														c_target.DealDamage(undefendedhit/3, src, "aliceblue", 0, 1)
												if(src.loc.loc:Safe!=1) LevelStat(SPECIALIZATION_TAIJUTSU,10*punchstatexp)
											if(src.Hand=="Right") src.PlayAudio('LPunchHIt.ogg', output = AUDIO_HEARERS)
											if(src.Hand=="Kick") src.PlayAudio('HandDam_Normal2.ogg', output = AUDIO_HEARERS)
											if(src.Hand=="Left") src.PlayAudio('KickHit.ogg', output = AUDIO_HEARERS)
											if(src.Gates >= 5 && !CheckState(src, new/state/cant_attack) && !CheckState(src, new/state/cant_move))
												c_target.icon_state="push"
												AddState(c_target, new/state/cant_move, 0.1)
												step_away(c_target,src)
												walk(c_target,c_target.dir)
												if(c_target.client)spawn() c_target.ScreenShake(3)
												spawn(3)
													if(c_target)
														walk(c_target,0)
														if(!CheckState(c_target, new/state/swimming))c_target.icon_state=""
											if(bonesword)
												if(c_target.icon_state == "")
													AddState(c_target, new/state/cant_move, bonesword)
										else
											if(src.agility_total>=c_target.agility_total || src.Gates >= 3)
												var/bonus=0
												if(src.mystical_palms)bonus+=5
												if(bugpass)bonus+=3
												bonus+=src.bonesword
												var/defendedhit=src.taijutsu_total
												if(defendedhit<0)defendedhit=1
												src.Levelup()
												if(defence_total<src.taijutsu_total/2)
													var/obj/Drag=new /obj/Drag/Dirt(c_target.loc)
													Drag.dir=c_target.dir
													step(c_target,src.dir)
													c_target.dir = get_dir(c_target,src)
													step_to(src,c_target,1)
												c_target.DealDamage(defendedhit + (((src.taijutsu_total * 0.1)* src.mystical_palms) + ((src.taijutsu_total * 0.025)* src.bonesword) + ((src.taijutsu_total * 0.05) * src.Gates)),src,"TaiOrange",0,0,1)
												if(src.Gates>0) src.DealDamage((((src.taijutsu_total / 200)*3) + (src.health * 0.001))* src.Gates, src, "maroon")
												if(src.byakugan==1)
													for(var/obj/Jutsus/Byakugan/J in src.jutsus)
														c_target.DealDamage(defendedhit/3, src, "aliceblue", 0, 1)
												flick("defendhit",c_target)
												src.PlayAudio('Counter_Success.ogg', output = AUDIO_HEARERS)
												if(bonesword)
													if(c_target.icon_state == "")
														AddState(c_target, new/state/cant_move, bonesword)
											else
												flick("dodge",c_target)
												if(c_target.loc.loc:Safe!=1) c_target.LevelStat("Agility",rand(1,2))
						for(var/obj/Training/T in get_step(src,src.dir))
							if(T.health>0)
								var/undefendedhit=round(src.taijutsu_total)
								T.health-=undefendedhit//,src,"TaiOrange")
								if(T) if(T.Good) LevelStat(SPECIALIZATION_TAIJUTSU,10*punchstatexp)
								else LevelStat(SPECIALIZATION_TAIJUTSU,10*punchstatexp)
								if(src.Hand=="Right") src.PlayAudio('LPunchHIt.ogg', output = AUDIO_HEARERS)
								if(src.Hand=="Kick") src.PlayAudio('HandDam_Normal2.ogg', output = AUDIO_HEARERS)
								if(src.Hand=="Left") src.PlayAudio('KickHit.ogg', output = AUDIO_HEARERS)
								T.Break(src)
