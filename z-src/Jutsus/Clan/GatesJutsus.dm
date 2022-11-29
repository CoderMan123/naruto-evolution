mob
	proc


		Gomu_Gomu_No_Red_Hawk()
			for(var/obj/Jutsus/Gomu_Gomu_No_Red_Hawk/J in src.jutsus)
				if(src.PreJutsu(J))
					if(loc.loc:Safe!=1) src.LevelStat(SPECIALIZATION_TAIJUTSU,rand(3,8))
					var/damage
					var/obj/A = new/obj/MiscEffects/RedHawk(src.loc)
					A.pixel_x=-30
					A.pixel_y=-10
					A.dir=src.dir
					if(J.level==1)
						damage=10
						A.icon_state="0"
					if(J.level==2)
						damage=15
						A.icon_state="1"
					if(J.level==3)
						damage=20
						A.icon_state="2"
					if(J.level==4)
						damage=30
						A.icon_state="max"
					if(J.level<4)
						if(loc.loc:Safe!=1) J.exp+=rand(2,5)
						J.Levelup()
					if(prob(50))flick("punchl",src)
					else flick("punchr",src)
					src.PlayAudio('Skill_BigRoketFire.wav', output = AUDIO_HEARERS)
					for(var/mob/c_target in get_step(src,src.dir))
						src.dir = get_dir(src,c_target)
						src.Target_Atom(c_target)
						if(c_target in get_step(src,src.dir))
							if(c_target.dead==0&&!istype(c_target,/mob/npc/) || c_target.dead==0&&istype(c_target,/mob/npc/combat))
								if(c_target.fightlayer==src.fightlayer)
									if(c_target.dodge==0)
										var/undefendedhit=round(((damage+src.taijutsu_total+src.taijutsu_total)/5))
										if(undefendedhit<0)undefendedhit=1
										c_target.DealDamage(undefendedhit,src,"TaiOrange",0,0,1)
										if(loc.loc:Safe!=1) LevelStat(SPECIALIZATION_TAIJUTSU,rand(3,9))
										if(loc.loc:Safe!=1) src.LevelStat(SPECIALIZATION_TAIJUTSU,rand(3,9))
										if(src.Hand=="Left") src.PlayAudio('LPunchHIt.ogg', output = AUDIO_HEARERS)
										if(src.Hand=="Right") src.PlayAudio('HandDam_Normal2.ogg', output = AUDIO_HEARERS)
										c_target.icon_state="push"
										walk(c_target,src.dir)
										if(c_target.client)spawn()c_target.ScreenShake(damage)
										spawn(damage)
											if(c_target)
												walk(c_target,0)
												if(!CheckState(c_target, new/state/swimming))c_target.icon_state=""
									else
										if(src.agility_total>=c_target.agility_total)
											var/defendedhit=round(((damage+src.taijutsu_total+src.taijutsu_total)/6))
											if(defendedhit<0)defendedhit=1
											if(loc.loc:Safe!=1)src.LevelStat(SPECIALIZATION_TAIJUTSU,1)
											if(defence_total<(src.taijutsu_total*0.75))
												var/obj/Drag=new /obj/Drag/Dirt(c_target.loc)
												Drag.dir=c_target.dir
												step(c_target,src.dir)
												c_target.dir = get_dir(c_target,src)
												step_to(src,c_target,1)
											c_target.DealDamage(defendedhit,src,"TaiOrange",0,0,1)
											flick("defendhit",c_target)
											src.PlayAudio('Counter_Success.ogg', output = AUDIO_HEARERS)
										else
											flick("dodge",c_target)
											if(c_target.loc.loc:Safe!=1) c_target.LevelStat("Agility",rand(1,2))
			/*		for(var/obj/Training/T in get_step(src,src.dir))
						if(T.health>=1)
							var/undefendedhit=round(((damage+src.taijutsu_total+src.taijutsu_total)/3)))
							T.DealDamage(undefendedhit,src,"TaiOrange")
							if(T) if(T.Good) LevelStat(SPECIALIZATION_TAIJUTSU,rand(1,2))
							else LevelStat(SPECIALIZATION_TAIJUTSU,rand(0.2,1))
							if(T) if(T.Good) src.LevelStat(SPECIALIZATION_TAIJUTSU,1)
							else src.LevelStat(SPECIALIZATION_TAIJUTSU,0.2)
							if(src.Hand=="Left") src.PlayAudio('LPunchHIt.ogg', output = AUDIO_HEARERS)
							if(src.Hand=="Right") src.PlayAudio('HandDam_Normal2.ogg', output = AUDIO_HEARERS)
							T.Break(src)*/

		Meteor_Punch()
			for(var/obj/Jutsus/Meteor_Punch/J in src.jutsus)
				if(src.PreJutsu(J))
					if(loc.loc:Safe!=1) src.LevelStat(SPECIALIZATION_TAIJUTSU,((J.maxcooltime*3/10)*jutsustatexp))
					var/damage
					var/obj/A = new/obj/MiscEffects/MeteorDust(src.loc)
					var/mob/c_target2=src.Target_Get(TARGET_MOB)
					if(c_target2)
						step_towards(src, c_target2)
						src.dir = get_dir(src.loc, c_target2.loc)
					A.pixel_x=-30
					A.pixel_y=-10
					A.dir=src.dir
					if(J.level==1)
						J.damage=((jutsudamage*J.Sprice)/2)*0.7
						A.icon_state="0"
					if(J.level==2)
						J.damage=((jutsudamage*J.Sprice)/2)*0.7
						A.icon_state="1"
					if(J.level==3)
						J.damage=((jutsudamage*J.Sprice)/1.25)*0.7
						A.icon_state="2"
					if(J.level==4)
						J.damage=(jutsudamage*J.Sprice)*0.7
						A.icon_state="max"
					if(J.level<4) if(loc.loc:Safe!=1) J.exp+=jutsumastery*(J.maxcooltime/20); J.Levelup()
					if(prob(50))flick("punchl",src)
					else flick("punchr",src)
					src.PlayAudio('Skill_BigRoketFire.wav', output = AUDIO_HEARERS)
					for(var/mob/c_target in get_step(src,src.dir))
						src.dir = get_dir(src,c_target)
						src.Target_Atom(c_target)
						if(c_target in get_step(src,src.dir))
							if(c_target.dead==0&&!istype(c_target,/mob/npc/) || c_target.dead==0&&istype(c_target,/mob/npc/combat))
								if(c_target.fightlayer==src.fightlayer)
									if(c_target.dodge==0)
										var/undefendedhit=round((J.damage+round((src.taijutsu_total / 200)*2*J.damage)))
										if(undefendedhit<0)undefendedhit=1
										c_target.DealDamage(undefendedhit,src,"TaiOrange",0,0,1)
										if(src.Hand=="Left") src.PlayAudio('LPunchHIt.ogg', output = AUDIO_HEARERS)
										if(src.Hand=="Right") src.PlayAudio('HandDam_Normal2.ogg', output = AUDIO_HEARERS)
										c_target.icon_state="push"
										AddState(c_target, new/state/cant_attack, damage)
										walk(c_target,src.dir)
										if(c_target.client)spawn()c_target.ScreenShake(damage)
										spawn(damage)
											if(c_target)
												walk(c_target,0)
												if(!CheckState(c_target, new/state/swimming))c_target.icon_state=""
									else
										if(src.agility_total>=c_target.agility_total)
											var/defendedhit=J.damage+round((src.taijutsu_total / 200)*2*J.damage)
											if(defendedhit<0)defendedhit=1
											if(loc.loc:Safe!=1)src.LevelStat(SPECIALIZATION_TAIJUTSU,1)
											if(defence_total<src.taijutsu_total/2)
												var/obj/Drag=new /obj/Drag/Dirt(c_target.loc)
												Drag.dir=c_target.dir
												step(c_target,src.dir)
												c_target.dir = get_dir(c_target,src)
												step_to(src,c_target,1)
											c_target.DealDamage(defendedhit,src,"TaiOrange",0,0,1)
											flick("defendhit",c_target)
											src.PlayAudio('Counter_Success.ogg', output = AUDIO_HEARERS)
										else
											flick("dodge",c_target)
											if(c_target.loc.loc:Safe!=1) c_target.LevelStat("Agility",rand(5,10))
											if(c_target.loc.loc:Safe!=1) c_target.Levelup()
			/*		for(var/obj/Training/T in get_step(src,src.dir))
						if(T.health>=1)
							var/undefendedhit=round(((damage+src.taijutsu_total+src.taijutsu_total)/3))
							T.DealDamage(undefendedhit,src,"TaiOrange")
							if(T) if(T.Good) LevelStat(SPECIALIZATION_TAIJUTSU,rand(1,2))
							else LevelStat(SPECIALIZATION_TAIJUTSU,rand(0.2,1))
							if(T) if(T.Good) src.LevelStat(SPECIALIZATION_TAIJUTSU,1)
							else src.LevelStat(SPECIALIZATION_TAIJUTSU,0.2)
							if(src.Hand=="Left") src.PlayAudio('LPunchHIt.ogg', output = AUDIO_HEARERS)
							if(src.Hand=="Right") src.PlayAudio('HandDam_Normal2.ogg', output = AUDIO_HEARERS)
							T.Break(src)*/

		Morning_Peacock()
			for(var/obj/Jutsus/Morning_Peacock/J in src.jutsus)
				if(src.PreJutsu(J))
					if(loc.loc:Safe!=1) src.LevelStat(SPECIALIZATION_TAIJUTSU,((J.maxcooltime*3/20)*jutsustatexp))
					if(loc.loc:Safe!=1) src.LevelStat("Agility",((J.maxcooltime*3/20)*jutsustatexp))
					var/hitamount
					if(J.level==1)
						J.damage=((jutsudamage*J.Sprice)/2)
						hitamount=4+(2*src.Gates)
					if(J.level==2)
						J.damage=((jutsudamage*J.Sprice)/2)
						hitamount=6+(2*src.Gates)
					if(J.level==3)
						J.damage=((jutsudamage*J.Sprice)/1.25)
						hitamount=8+(2*src.Gates)
					if(J.level==4)
						J.damage=(jutsudamage*J.Sprice)
						hitamount=10+(2*src.Gates)
					if(J.level<4) if(loc.loc:Safe!=1) J.exp+=jutsumastery*(J.maxcooltime/20); J.Levelup()

					var/state/cant_attack/e = new()
					var/state/cant_move/f = new()
					AddState(src, e, -1)
					AddState(src, f, -1)

					for(var/mob/c_target in get_step(src,src.dir))
						src.dir = get_dir(src,c_target)
						src.Target_Atom(c_target)
						if(c_target.dead==0&&!istype(c_target,/mob/npc/) || c_target.dead==0&&istype(c_target,/mob/npc/combat))
							if(c_target.fightlayer==src.fightlayer)
								if(c_target.dodge==0)
									c_target.dir = get_dir(c_target,src)
									c_target.Step_Back()
									if(prob(35))
										//c_target.Linkage=src
										c_target.overlays+=/obj/Projectiles/Effects/OnFire
										c_target.burn=3
										spawn(50)if(c_target)c_target.BurnEffect(src)
									var/undefendedhit=round(((J.damage+round(((src.taijutsu_total / 450)+(src.agility_total / 450))*2*J.damage))/40))
									if(undefendedhit<0)undefendedhit=1
									c_target.DealDamage(undefendedhit,src,"TaiOrange",0,0,1)
									src.PlayAudio('Skill_MashHit.wav', output = AUDIO_HEARERS)
									Bind(c_target, 10, src)
									if(c_target.client)spawn()c_target.ScreenShake(1)
								else
									if(src.agility_total>=c_target.agility_total)
										var/defendedhit=round(((J.damage+round(((src.taijutsu_total / 450)+(src.agility_total / 450))*2*J.damage))/40))
										if(defendedhit<0)defendedhit=1
										if(defence_total<src.taijutsu_total/2)
											var/obj/Drag=new /obj/Drag/Dirt(c_target.loc)
											Drag.dir=c_target.dir
											step(c_target,src.dir)
											c_target.dir = get_dir(c_target,src)
											step_to(src,c_target,1)
										c_target.DealDamage(defendedhit,src,"TaiOrange")
										flick("defendhit",c_target)
										src.PlayAudio('Counter_Success.ogg', output = AUDIO_HEARERS)
									else
										flick("dodge",c_target)
										if(c_target.loc.loc:Safe!=1) c_target.LevelStat("Agility",rand(5,10))
				/*	for(var/obj/Training/T in get_step(src,src.dir))
						if(T.health>=1)
							var/undefendedhit=round(((damage+src.taijutsu_total+src.taijutsu)/2.5))
							T.DealDamage(undefendedhit,src,"TaiOrange")
							if(T) if(T.Good) LevelStat(SPECIALIZATION_TAIJUTSU,rand(1,2))
							else LevelStat(SPECIALIZATION_TAIJUTSU,rand(0.2,1))
							if(T) if(T.Good) src.LevelStat(SPECIALIZATION_TAIJUTSU,3)
							else LevelStat(SPECIALIZATION_TAIJUTSU,0.5)
							src.PlayAudio('Skill_MashHit.wav', output = AUDIO_HEARERS)
							T.Break(src)*/
					spawn()PunchFlick(hitamount,J)
					var/wait=hitamount*((3.5-((src.agility_total/200)*3))+1)
					spawn(wait)if(src)
						RemoveState(src, e, STATE_REMOVE_REF)
						RemoveState(src, f, STATE_REMOVE_REF)
