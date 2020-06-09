mob
	proc


		ShishiRendan()
			for(var/obj/Jutsus/Shishi/J in src.JutsusLearnt)
				if(src.PreJutsu(J))
					var/mob/c_target=src.Target_Get(TARGET_MOB)
					if(!c_target){src<<output("<font color=yellow>You need to have a Target to perform ShiShi Rendan","actionoutput");return}
					if(loc.loc:Safe!=1) src.LevelStat("Taijutsu",rand(4,8))
					if(J.level<4)
						if(loc.loc:Safe!=1) J.exp+=rand(2,5)
						J.Levelup()
					if(get_dist(src,c_target)>4){src<<"[c_target] need to be closer to you for that move to work!";src.move=1;return}
					view(src) << output("<b><font color = #C0C0C0>[usr] says: Shishi Rendan!!!","actionoutput")
					src.move=0
					src.injutsu=1
					src.canattack=0
					src.firing=1
					src.loc=locate(c_target.x-1,c_target.y,c_target.z)
					flick("kick",src)
					sleep(1)
					c_target.move=0
					step(c_target,NORTH)
					spawn(2)
						if(c_target)
							step(c_target,NORTH)
							spawn(2)
								if(src)
									spawn(2)
										if(src)
											src.loc=locate(c_target.x+1,c_target.y,c_target.z)
											flick("kick",src)
											spawn(2)
												if(src)
													step(c_target,SOUTH)
													spawn(2)
														if(src)
															step(c_target,SOUTH)
															src.move=1
															src.firing=0
															src.injutsu=0
															src.canattack=1
															c_target.move=1
															c_target.DealDamage((18*J.level)+src.agility,src,"TaiOrange")
															if(c_target)c_target.Bleed()
															src.move=1

		Gomu_Gomu_No_Red_Hawk()
			if(src.firing==0&&!src.likeaclone)
				for(var/obj/Jutsus/Gomu_Gomu_No_Red_Hawk/J in src.JutsusLearnt)
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
						view(src,10) << sound('Sounds/Skill_BigRoketFire.wav',0,0,0,100)
						for(var/mob/c_target in get_step(src,src.dir))
							src.dir = get_dir(src,c_target)
							src.Target_Atom(c_target)
							if(c_target in get_step(src,src.dir))
								if(c_target.dead==0&&!istype(c_target,/mob/NPC/))
									if(c_target.fightlayer==src.fightlayer)
										if(c_target.dodge==0)
											var/undefendedhit=round(((damage+src.strength+src.strength)/5)-(c_target.defence/10))
											if(undefendedhit<0)undefendedhit=1
											c_target.DealDamage(undefendedhit,src,"TaiOrange",0,0,1)
											if(loc.loc:Safe!=1) LevelStat("Strength",rand(3,9))
											if(loc.loc:Safe!=1) src.LevelStat("strength",rand(3,9))
											if(c_target.loc.loc:Safe!=1) c_target.LevelStat("Defence",rand(1,2))
											if(src.Hand=="Left")view(src,10) << sound('Sounds/LPunchHIt.ogg',0,0,0,100)
											if(src.Hand=="Right")view(src,10) << sound('Sounds/HandDam_Normal2.ogg',0,0,0,100)
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
												view(src,10) << sound('Sounds/Counter_Success.ogg',0,0,0,100)
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
								if(src.Hand=="Left")view(src,10) << sound('Sounds/LPunchHIt.ogg',0,0,0,100)
								if(src.Hand=="Right")view(src,10) << sound('Sounds/HandDam_Normal2.ogg',0,0,0,100)
								T.Break(src)*/

		Meteor_Punch()
			if(src.firing==0&&!src.likeaclone)
				for(var/obj/Jutsus/Meteor_Punch/J in src.JutsusLearnt)
					if(src.PreJutsu(J))
						if(loc.loc:Safe!=1) src.LevelStat("strength",rand(2,5))
						var/damage
						var/obj/A = new/obj/MiscEffects/MeteorDust(src.loc)
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
						view(src,10) << sound('Sounds/Skill_BigRoketFire.wav',0,0,0,100)
						for(var/mob/c_target in get_step(src,src.dir))
							src.dir = get_dir(src,c_target)
							src.Target_Atom(c_target)
							if(c_target in get_step(src,src.dir))
								if(c_target.dead==0&&!istype(c_target,/mob/NPC/))
									if(c_target.fightlayer==src.fightlayer)
										if(c_target.dodge==0)
											var/undefendedhit=round(((damage+src.strength+src.strength)/3)-(c_target.defence/10))
											if(undefendedhit<0)undefendedhit=1
											c_target.DealDamage(undefendedhit,src,"TaiOrange",0,0,1)
											if(loc.loc:Safe!=1) LevelStat("Strength",rand(3,9))
											if(loc.loc:Safe!=1) src.LevelStat("strength",rand(3,9))
											if(c_target.loc.loc:Safe!=1) c_target.LevelStat("Defence",rand(1,2))
											if(src.Hand=="Left")view(src,10) << sound('Sounds/LPunchHIt.ogg',0,0,0,100)
											if(src.Hand=="Right")view(src,10) << sound('Sounds/HandDam_Normal2.ogg',0,0,0,100)
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
												var/defendedhit=round(((damage+src.strength+src.strength)/4))
												if(defendedhit<0)defendedhit=1
												//if(loc.loc:Safe!=1)src.strength++
												if(loc.loc:Safe!=1)src.LevelStat("strength",1)
												src.Levelup()
												if(c_target.loc.loc:Safe!=1) c_target.LevelStat("Defence",rand(1,2))
												if(defence<src.strength/3)
													var/obj/Drag=new /obj/Drag/Dirt(c_target.loc)
													Drag.dir=c_target.dir
													step(c_target,src.dir)
													c_target.dir = get_dir(c_target,src)
													step_to(src,c_target,1)
												c_target.DealDamage(defendedhit,src,"TaiOrange",0,0,1)
												flick("defendhit",c_target)
												view(src,10) << sound('Sounds/Counter_Success.ogg',0,0,0,100)
											else
												flick("dodge",c_target)
												if(c_target.loc.loc:Safe!=1) c_target.LevelStat("Agility",rand(1,2))
												if(c_target.loc.loc:Safe!=1) c_target.Levelup()
				/*		for(var/obj/Training/T in get_step(src,src.dir))
							if(T.health>=1)
								var/undefendedhit=round(((damage+src.strength+src.strength)/3))//-c_target.defence/4)
								T.DealDamage(undefendedhit,src,"TaiOrange")
								if(T) if(T.Good) LevelStat("Strength",rand(1,2))
								else LevelStat("Strength",rand(0.2,1))
								if(T) if(T.Good) src.LevelStat("strength",1)
								else src.LevelStat("strength",0.2)
								if(src.Hand=="Left")view(src,10) << sound('Sounds/LPunchHIt.ogg',0,0,0,100)
								if(src.Hand=="Right")view(src,10) << sound('Sounds/HandDam_Normal2.ogg',0,0,0,100)
								T.Break(src)*/

		Leaf_Whirlwind()
			if(src.firing==0&&!src.likeaclone)
				for(var/obj/Jutsus/Leaf_Whirlwind/J in src.JutsusLearnt)
					if(src.PreJutsu(J))
						if(loc.loc:Safe!=1)src.LevelStat("strength",rand(2,5))
						var/damage
						if(J.level==3)
							var/obj/A = new/obj/MiscEffects/LeafWhirl(src.loc)
							A.dir=src.dir
						if(J.level==1)damage=10
						if(J.level==2)damage=15
						if(J.level==3)damage=20
						if(J.level<3)
							if(loc.loc:Safe!=1) J.exp+=rand(2,5)
							J.Levelup()
						src.injutsu=1
						src.firing=1
						flick("kick",src)
						if(J.level==3)view(src) << sound('Sounds/wirlwind.wav',0,0,0,100)
						else view(src) << sound('Sounds/Spin.ogg',0,0,0,100)
						for(var/mob/c_target in orange(src,J.level))
							if(c_target in orange(src,J.level))
								if(c_target.dead==0&&!istype(c_target,/mob/NPC/))
									if(c_target.fightlayer==src.fightlayer)
										if(c_target.dodge==0)
											var/undefendedhit=round(((damage+src.strength+src.strength)/3)-(c_target.defence/10))
											if(undefendedhit<0)undefendedhit=1
											c_target.DealDamage(undefendedhit,src,"TaiOrange",0,0,1)
											if(loc.loc:Safe!=1) LevelStat("Strength",rand(1,3))
											if(loc.loc:Safe!=1)src.LevelStat("strength",rand(1,3))
											if(c_target.loc.loc:Safe!=1)c_target.LevelStat("Defence",rand(1,2))
											view(src,10) << sound('Sounds/KickHit.ogg',0,0,0,100)
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
												var/defendedhit=round(((damage+src.strength+src.strength)/4))
												if(defendedhit<0)defendedhit=1
												//if(loc.loc:Safe!=1)src.
												if(loc.loc:Safe!=1)src.LevelStat("strength",1)
												if(c_target.loc.loc:Safe!=1)c_target.LevelStat("Defence",rand(1,2))
												if(defence<src.strength/3)
													var/obj/Drag=new /obj/Drag/Dirt(c_target.loc)
													Drag.dir=c_target.dir
													step(c_target,src.dir)
													c_target.dir = get_dir(c_target,src)
													step_to(src,c_target,1)
												c_target.DealDamage(defendedhit,src,"TaiOrange",0,0,1)
												flick("defendhit",c_target)
												view(src,10) << sound('Sounds/Counter_Success.ogg',0,0,0,100)
											else
												flick("dodge",c_target)
												if(c_target.loc.loc:Safe!=1)c_target.LevelStat("Agility",rand(1,2))
					/*	for(var/obj/Training/T in orange(src,J.level))
							if(T.health>=1)
								var/undefendedhit=round(((damage+src.strength+src.strength)/3))//-c_target.defence/4)
								T.DealDamage(undefendedhit,src,"TaiOrange")
								if(T) if(T.Good) LevelStat("Strength",rand(1,2))
								else LevelStat("Strength",rand(0.2,1))
								if(T) if(T.Good) src.LevelStat("strength",1)
								else src.LevelStat("strength",0.2)
								view(src,10) << sound('Sounds/KickHit.ogg',0,0,0,100)
								T.Break(src)*/
						src.JutsuCoolSlot(J)
						spawn(5)if(src)src.firing=0
					spawn(10)src.injutsu=0

		Morning_Peacock()
			if(src.firing==0&&!src.likeaclone)
				for(var/obj/Jutsus/Morning_Peacock/J in src.JutsusLearnt)
					if(src.PreJutsu(J))
						if(loc.loc:Safe!=1)src.LevelStat("strength",rand(2,5))
						var/damage
						if(J.level==1)damage=5
						if(J.level==2)damage=8
						if(J.level==3)damage=12
						if(J.level<3)
							if(loc.loc:Safe!=1) J.exp+=rand(2,5)
							J.Levelup()
						src.injutsu=1
						src.firing=1
						for(var/mob/c_target in get_step(src,src.dir))
							src.dir = get_dir(src,c_target)
							src.Target_Atom(c_target)
							if(c_target.dead==0&&!istype(c_target,/mob/NPC/))
								if(c_target.fightlayer==src.fightlayer)
									if(c_target.dodge==0)
										c_target.dir = get_dir(c_target,src)
										c_target.Step_Back()
										if(prob(35))
											//c_target.Linkage=src
											c_target.overlays+=/obj/Projectiles/Effects/OnFire
											c_target.burn=3
											spawn(50)if(c_target)c_target.BurnEffect(src)
										var/undefendedhit=round(((damage+src.strength+src.strength)/6.5)-(c_target.defence/10))
										if(undefendedhit<0)undefendedhit=1
										c_target.DealDamage(undefendedhit,src,"TaiOrange",0,0,1)
										if(loc.loc:Safe!=1)LevelStat("Strength",rand(1,4))
										if(loc.loc:Safe!=1)src.LevelStat("strength",rand(1,3))
										if(c_target.loc.loc:Safe!=1)c_target.LevelStat("Defence",rand(1,2))
										view(src) << sound('Sounds/Skill_MashHit.wav',0,0,0,50)
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
											var/defendedhit=round(((damage+src.strength+src.strength)/8.5))
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
											c_target.DealDamage(defendedhit,src,"TaiOrange")
											flick("defendhit",c_target)
											view(src,10) << sound('Sounds/Counter_Success.ogg',0,0,0,100)
										else
											flick("dodge",c_target)
											if(c_target.loc.loc:Safe!=1) c_target.LevelStat("Agility",rand(1,2))
					/*	for(var/obj/Training/T in get_step(src,src.dir))
							if(T.health>=1)
								var/undefendedhit=round(((damage+src.strength+src.strength)/2.5))//-c_target.defence/4)
								T.DealDamage(undefendedhit,src,"TaiOrange")
								if(T) if(T.Good) LevelStat("Strength",rand(1,2))
								else LevelStat("Strength",rand(0.2,1))
								if(T) if(T.Good) src.LevelStat("strength",3)
								else LevelStat("strength",0.5)
								view(src) << sound('Sounds/Skill_MashHit.wav',0,0,0,50)
								T.Break(src)*/
						spawn()PunchFlick(damage,J)
						src.JutsuCoolSlot(J)
						var/wait=damage*4
						spawn(wait)if(src)
							src.firing=0
							src.injutsu=0
