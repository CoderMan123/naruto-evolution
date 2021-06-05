mob
	proc


		Gomu_Gomu_No_Red_Hawk()
			if(src.firing==0&&!src.likeaclone)
				for(var/obj/Jutsus/Gomu_Gomu_No_Red_Hawk/J in src.jutsus)
					if(src.PreJutsu(J))
						if(loc.loc:Safe!=1) src.LevelStat("strength",rand(3,8))
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
						//src.firing=1
						view(src,10) << sound('Skill_BigRoketFire.wav',0,0,0,100)
						for(var/mob/c_target in get_step(src,src.dir))
							src.dir = get_dir(src,c_target)
							src.Target_Atom(c_target)
							if(c_target in get_step(src,src.dir))
								if(c_target.dead==0&&!istype(c_target,/mob/npc/))
									if(c_target.fightlayer==src.fightlayer)
										if(c_target.dodge==0)
											var/undefendedhit=round(((damage+src.strength+src.strength)/5)-(c_target.defence/10))
											if(undefendedhit<0)undefendedhit=1
											c_target.DealDamage(undefendedhit,src,"TaiOrange",0,0,1)
											if(loc.loc:Safe!=1) LevelStat("Strength",rand(3,9))
											if(loc.loc:Safe!=1) src.LevelStat("strength",rand(3,9))
											if(c_target.loc.loc:Safe!=1) c_target.LevelStat("Defence",rand(1,2))
											if(src.Hand=="Left")view(src,10) << sound('LPunchHIt.ogg',0,0,0,100)
											if(src.Hand=="Right")view(src,10) << sound('HandDam_Normal2.ogg',0,0,0,100)
											c_target.icon_state="push"
											c_target.injutsu=1
											c_target.canattack=0
											c_target.firing=1
											walk(c_target,src.dir)
											if(c_target.client)spawn()c_target.ScreenShake(damage)
											spawn(damage)
												if(c_target)
													walk(c_target,0)
													c_target.injutsu=0
													if(!c_target.swimming)c_target.icon_state=""
													c_target.canattack=1
													c_target.firing=0
										else
											if(src.agility>=c_target.agility)
												var/defendedhit=round(((damage+src.strength+src.strength)/6))
												if(defendedhit<0)defendedhit=1
												//if(loc.loc:Safe!=1)src.strength++
												if(loc.loc:Safe!=1)src.LevelStat("strength",1)
												if(c_target.loc.loc:Safe!=1) c_target.LevelStat("Defence",rand(1,2))
												if(defence<src.strength/3)
													var/obj/Drag=new /obj/Drag/Dirt(c_target.loc)
													Drag.dir=c_target.dir
													step(c_target,src.dir)
													c_target.dir = get_dir(c_target,src)
													step_to(src,c_target,1)
												c_target.DealDamage(defendedhit,src,"TaiOrange",0,0,1)
												flick("defendhit",c_target)
												view(src,10) << sound('Counter_Success.ogg',0,0,0,100)
											else
												flick("dodge",c_target)
												if(c_target.loc.loc:Safe!=1) c_target.LevelStat("Agility",rand(1,2))
				/*		for(var/obj/Training/T in get_step(src,src.dir))
							if(T.health>=1)
								var/undefendedhit=round(((damage+src.strength+src.strength)/3))//-c_target.defence/4)
								T.DealDamage(undefendedhit,src,"TaiOrange")
								if(T) if(T.Good) LevelStat("Strength",rand(1,2))
								else LevelStat("Strength",rand(0.2,1))
								if(T) if(T.Good) src.LevelStat("strength",1)
								else src.LevelStat("strength",0.2)
								if(src.Hand=="Left")view(src,10) << sound('LPunchHIt.ogg',0,0,0,100)
								if(src.Hand=="Right")view(src,10) << sound('HandDam_Normal2.ogg',0,0,0,100)
								T.Break(src)*/

		Meteor_Punch()
			if(src.firing==0&&!src.likeaclone)
				for(var/obj/Jutsus/Meteor_Punch/J in src.jutsus)
					if(src.PreJutsu(J))
						if(loc.loc:Safe!=1) src.LevelStat("Strength",((J.maxcooltime*3/10)*jutsustatexp))
						var/damage
						var/obj/A = new/obj/MiscEffects/MeteorDust(src.loc)
						A.pixel_x=-30
						A.pixel_y=-10
						A.dir=src.dir
						if(J.level==1)
							J.damage=((jutsudamage*J.Sprice)/2.5)*0.7
							A.icon_state="0"
						if(J.level==2)
							J.damage=((jutsudamage*J.Sprice)/2)*0.7
							A.icon_state="1"
						if(J.level==3)
							J.damage=((jutsudamage*J.Sprice)/1.5)*0.7
							A.icon_state="2"
						if(J.level==4)
							J.damage=(jutsudamage*J.Sprice)*0.7
							A.icon_state="max"
						if(J.level<4) if(loc.loc:Safe!=1) J.exp+=jutsumastery*(J.maxcooltime/20); J.Levelup()
						if(prob(50))flick("punchl",src)
						else flick("punchr",src)
						//src.firing=1
						view(src,10) << sound('Skill_BigRoketFire.wav',0,0,0,100)
						for(var/mob/c_target in get_step(src,src.dir))
							src.dir = get_dir(src,c_target)
							src.Target_Atom(c_target)
							if(c_target in get_step(src,src.dir))
								if(c_target.dead==0&&!istype(c_target,/mob/npc/))
									if(c_target.fightlayer==src.fightlayer)
										if(c_target.dodge==0)
											var/undefendedhit=round((J.damage+round((src.strength / 150)*2*J.damage)-(c_target.defence/10)))
											if(undefendedhit<0)undefendedhit=1
											c_target.DealDamage(undefendedhit,src,"TaiOrange",0,0,1)
											if(c_target.loc.loc:Safe!=1) c_target.LevelStat("Defence",rand(3,6))
											if(src.Hand=="Left")view(src,10) << sound('LPunchHIt.ogg',0,0,0,100)
											if(src.Hand=="Right")view(src,10) << sound('HandDam_Normal2.ogg',0,0,0,100)
											c_target.icon_state="push"
											c_target.injutsu=1
											c_target.canattack=0
											c_target.firing=1
											walk(c_target,src.dir)
											if(c_target.client)spawn()c_target.ScreenShake(damage)
											spawn(damage)
												if(c_target)
													walk(c_target,0)
													c_target.injutsu=0
													if(!c_target.swimming)c_target.icon_state=""
													c_target.canattack=1
													c_target.firing=0
										else
											if(src.agility>=c_target.agility)
												var/defendedhit=J.damage+round((src.strength / 150)*2*J.damage)
												if(defendedhit<0)defendedhit=1
												//if(loc.loc:Safe!=1)src.strength++
												if(loc.loc:Safe!=1)src.LevelStat("strength",1)
												src.Levelup()
												if(c_target.loc.loc:Safe!=1) c_target.LevelStat("Defence",rand(5,10))
												if(defence<src.strength/3)
													var/obj/Drag=new /obj/Drag/Dirt(c_target.loc)
													Drag.dir=c_target.dir
													step(c_target,src.dir)
													c_target.dir = get_dir(c_target,src)
													step_to(src,c_target,1)
												c_target.DealDamage(defendedhit,src,"TaiOrange",0,0,1)
												flick("defendhit",c_target)
												view(src,10) << sound('Counter_Success.ogg',0,0,0,100)
											else
												flick("dodge",c_target)
												if(c_target.loc.loc:Safe!=1) c_target.LevelStat("Agility",rand(5,10))
												if(c_target.loc.loc:Safe!=1) c_target.Levelup()
				/*		for(var/obj/Training/T in get_step(src,src.dir))
							if(T.health>=1)
								var/undefendedhit=round(((damage+src.strength+src.strength)/3))//-c_target.defence/4)
								T.DealDamage(undefendedhit,src,"TaiOrange")
								if(T) if(T.Good) LevelStat("Strength",rand(1,2))
								else LevelStat("Strength",rand(0.2,1))
								if(T) if(T.Good) src.LevelStat("strength",1)
								else src.LevelStat("strength",0.2)
								if(src.Hand=="Left")view(src,10) << sound('LPunchHIt.ogg',0,0,0,100)
								if(src.Hand=="Right")view(src,10) << sound('HandDam_Normal2.ogg',0,0,0,100)
								T.Break(src)*/

		Morning_Peacock()
			if(src.firing==0&&!src.likeaclone)
				for(var/obj/Jutsus/Morning_Peacock/J in src.jutsus)
					if(src.PreJutsu(J))
						if(loc.loc:Safe!=1) src.LevelStat("Strength",((J.maxcooltime*3/20)*jutsustatexp))
						if(loc.loc:Safe!=1) src.LevelStat("Agility",((J.maxcooltime*3/20)*jutsustatexp))
						var/hitamount
						if(J.level==1)
							J.damage=((jutsudamage*J.Sprice)/2.5)
							hitamount=4+(2*src.Gates)
						if(J.level==2)
							J.damage=((jutsudamage*J.Sprice)/2)
							hitamount=6+(2*src.Gates)
						if(J.level==3)
							J.damage=((jutsudamage*J.Sprice)/1.5)
							hitamount=8+(2*src.Gates)
						if(J.level==4)
							J.damage=(jutsudamage*J.Sprice)
							hitamount=10+(2*src.Gates)
						if(J.level<4) if(loc.loc:Safe!=1) J.exp+=jutsumastery*(J.maxcooltime/20); J.Levelup()
						src.injutsu=1
						src.firing=1
						for(var/mob/c_target in get_step(src,src.dir))
							src.dir = get_dir(src,c_target)
							src.Target_Atom(c_target)
							if(c_target.dead==0&&!istype(c_target,/mob/npc/))
								if(c_target.fightlayer==src.fightlayer)
									if(c_target.dodge==0)
										c_target.dir = get_dir(c_target,src)
										c_target.Step_Back()
										if(prob(35))
											//c_target.Linkage=src
											c_target.overlays+=/obj/Projectiles/Effects/OnFire
											c_target.burn=3
											spawn(50)if(c_target)c_target.BurnEffect(src)
										var/undefendedhit=round(((J.damage+round(((src.strength / 300)+(src.agility / 300))*2*J.damage))/40)-(c_target.defence/10))
										if(undefendedhit<0)undefendedhit=1
										c_target.DealDamage(undefendedhit,src,"TaiOrange",0,0,1)
										if(c_target.loc.loc:Safe!=1)c_target.LevelStat("Defence",rand(3,6))
										view(src) << sound('Skill_MashHit.wav',0,0,0,50)
										c_target.injutsu=1
										c_target.canattack=0
										c_target.firing=1
										if(c_target.client)spawn()c_target.ScreenShake(1)
										spawn(11)
											if(c_target)
												c_target.injutsu=0
												c_target.canattack=1
												c_target.firing=0
									else
										if(src.agility>=c_target.agility)
											var/defendedhit=round(((J.damage+round(((src.strength / 300)+(src.agility / 300))*2*J.damage))/40)-(c_target.defence/8.5))
											if(defendedhit<0)defendedhit=1
											if(c_target.loc.loc:Safe!=1) c_target.LevelStat("Defence",rand(5,10))
											if(defence<src.strength/3)
												var/obj/Drag=new /obj/Drag/Dirt(c_target.loc)
												Drag.dir=c_target.dir
												step(c_target,src.dir)
												c_target.dir = get_dir(c_target,src)
												step_to(src,c_target,1)
											c_target.DealDamage(defendedhit,src,"TaiOrange")
											flick("defendhit",c_target)
											view(src,10) << sound('Counter_Success.ogg',0,0,0,100)
										else
											flick("dodge",c_target)
											if(c_target.loc.loc:Safe!=1) c_target.LevelStat("Agility",rand(5,10))
					/*	for(var/obj/Training/T in get_step(src,src.dir))
							if(T.health>=1)
								var/undefendedhit=round(((damage+src.strength+src.strength)/2.5))//-c_target.defence/4)
								T.DealDamage(undefendedhit,src,"TaiOrange")
								if(T) if(T.Good) LevelStat("Strength",rand(1,2))
								else LevelStat("Strength",rand(0.2,1))
								if(T) if(T.Good) src.LevelStat("strength",3)
								else LevelStat("strength",0.5)
								view(src) << sound('Skill_MashHit.wav',0,0,0,50)
								T.Break(src)*/
						spawn()PunchFlick(hitamount,J)
						src.JutsuCoolSlot(J)
						var/wait=hitamount*4
						spawn(wait)if(src)
							src.firing=0
							src.injutsu=0
