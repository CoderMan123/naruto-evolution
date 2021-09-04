mob
	verb
		Basic_Attack()
			var/mob/c_target=src.Target_Get(TARGET_MOB)
			set hidden=1
			if(src.canattack==0)
				return
			if(src.multisized==1)//multisizestuff
				return
			if(src.shielded==1)
				if(src.Clan == "Sand"&&canattack)
					canattack=0
					spawn(15) canattack=1
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
							M.DealDamage(src.ninjutsu/2,src,"NinBlue",0,0,1)
				return
			if(src.incalorie==1&&usr.Clan=="Akimichi")
				src.Meteor_Punch()
			if(ChakraCheck(0)) return
			if(c_target&&!src.likeaclone)
				if(src.lungecounter==0)
					step(src, get_dir(src, c_target))
					src.lungecounter=1
					if(src.equipped=="Weights")
						spawn(40/((src.agility/150)*3))lungecounter=0
						if(loc.loc:Safe!=1) src.LevelStat("Agility",round(rand(8,20)*trainingexp))
					else
						spawn(20/((src.agility/150)*3))lungecounter=0
						if(loc.loc:Safe!=1) src.LevelStat("Agility",round(rand(4,11)*trainingexp))
			if(src.likeaclone)
				var/mob/Clones/SC=src.likeaclone
				if(SC.canattack==1)
					SC.canattack=0
					SC.attkspeed = (src.attkspeed * 0.5)
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
					view(SC,10) << sound('Swing5.ogg',0,0,0,100)
					spawn(2)
						for(var/mob/C in orange(SC,1))
							SC.dir = get_dir(SC,C)
							for(c_target in get_step(SC,SC.dir))
								if(c_target in get_step(SC,SC.dir))
									if(c_target.dead==0&&!istype(c_target,/mob/npc/)&&c_target!=SC.Owner || c_target.dead==0&&istype(c_target,/mob/npc/combat)&&c_target!=SC.Owner)
										if(c_target.fightlayer==SC.fightlayer)
											if(c_target.client)spawn()c_target.ScreenShake(1)
											if(c_target.dodge==0)
												var/undefendedhit=(60-round(1*((150-src.strength)/3)))-(c_target.defence/4)+rand(0,10)
												if(undefendedhit<0)undefendedhit=1
												c_target.DealDamage(undefendedhit+ (((src.strength * 0.1)* src.mystical_palms) + ((src.strength * 0.025)* src.bonesword) + ((src.strength * 0.05) * src.Gates)),src,"TaiOrange",0,0,1)
												if(src.Gates>0) src.DealDamage(((src.strength / 150)*10) * src.Gates, src, "maroon")
												if(SC.loc.loc:Safe!=1) LevelStat("Strength",10*punchstatexp)
												if(c_target)
													if(c_target.loc.loc:Safe!=1) c_target.LevelStat("Defence",rand(1,2))
												if(SC.Hand=="Left")view(SC,10) << sound('LPunchHIt.ogg',0,0,0,100)
												if(SC.Hand=="Right")view(SC,10) << sound('HandDam_Normal2.ogg',0,0,0,100)
											else
												if(SC.agility>=c_target.agility)
													var/defendedhit=SC.strength-c_target.defence
													if(defendedhit<0)defendedhit=1

													src.Levelup()
													if(c_target)
														if(c_target.loc.loc:Safe!=1) c_target.LevelStat("Defence",rand(1,2))
													if(defence<SC.strength/3)
														var/obj/Drag=new /obj/Drag/Dirt(c_target.loc)
														Drag.dir=c_target.dir
														step(c_target,SC.dir)
														c_target.dir = get_dir(c_target,SC)
														step_to(SC,c_target,1)
													c_target.DealDamage(defendedhit+ (((src.strength * 0.1)* src.mystical_palms) + ((src.strength * 0.025)* src.bonesword) + ((src.strength * 0.05) * src.Gates)),src,"TaiOrange",0,0,1)
													if(src.Gates>0) src.DealDamage(((src.strength / 150)*10) * src.Gates, src, "maroon")
													flick("defendhit",c_target)
													view(SC,10) << sound('Counter_Success.ogg',0,0,0,100)
												else
													flick("dodge",c_target)
													if(c_target.loc.loc:Safe!=1) c_target.LevelStat("Agility",rand(1,2))
							break
						for(var/obj/Training/T in get_step(SC,SC.dir))//This is all punching logs.
							if(T.health>=1)
								var/undefendedhit=round(SC.strength)//-T.defence/4)
								T.health-=undefendedhit
								if(T) if(T.Good) LevelStat("Strength",10*punchstatexp)
								else LevelStat("Strength",10*punchstatexp)
								if(SC.Hand=="Left")view(SC,10) << sound('LPunchHIt.ogg',0,0,0,100)
								if(SC.Hand=="Right")view(SC,10) << sound('HandDam_Normal2.ogg',0,0,0,100)
								T.Break(src)
					spawn(src.attkspeed)
						//src.move=1
						if(SC)SC.canattack=1
			if(src.canattack==1&&!src.likeaclone&&!dead&&!rest)
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
				src.canattack=0
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
						if(Specialist=="strength"||Specialist2=="strength")combo++
						if(src.Clan <> "Sand")
							flick("punchl",src)
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
						if(src.Clan == "Sand")
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
							if(src.Clan <> "Sand")
								flick("punchr",src)
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
							if(Specialist=="strength"||Specialist2=="strength")
								src.Hand="Kick"
								combo++
							else src.Hand="Left"
							if(src.Clan == "Sand")
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
								if(Specialist=="strength"||Specialist2=="strength")combo++
								flick("kick",src)
								src.Hand="Left"
								for(var/mob/Clones/Bunshin/C in world)if(C.Owner==src)flick("kick",C)
				view(src,10) << sound('Swing5.ogg',0,0,0,100)
				if(src.agility<50)
					spawn(2)
						for(c_target in get_step(src,src.dir))
							src.dir = get_dir(src,c_target)
							src.Target_Atom(c_target)
							if(c_target in get_step(src,src.dir))
								if(c_target.dead==0&&!istype(c_target,/mob/npc/) || c_target.dead==0&&istype(c_target,/mob/npc/combat))
									var/canhityou=1
									if(c_target.Clan == "Sand")
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
											var/undefendedhit=(60-round(1*((150-src.strength)/3)))-(c_target.defence/4)+rand(0,10)//finditlel
											if(undefendedhit<0)undefendedhit=1
											if(c_target.Sharingan)
												if(prob((c_target.agility*2)-(undefendedhit)+(c_target.Sharingan*5)))
													undefendedhit=1
													flick("dodge",c_target)
												else
													undefendedhit-=(c_target.Sharingan+c_target.agility)
													if(undefendedhit<0) undefendedhit=1
													flick("defend",c_target)
											c_target.DealDamage(undefendedhit+ (((src.strength * 0.1)* src.mystical_palms) + ((src.strength * 0.025)* src.bonesword) + ((src.strength * 0.05) * src.Gates)),src,"TaiOrange",0,0,1)
											if(src.Gates>0) src.DealDamage(((src.strength / 150)*10) * src.Gates, src, "maroon")
											if(src.byakugan==1)
												for(var/obj/Jutsus/Byakugan/J in src.jutsus)
													c_target.DealDamage(undefendedhit/3, src, "aliceblue", 0, 1)
											if(src.loc.loc:Safe!=1) LevelStat("Strength",10*punchstatexp)
											if(c_target)
												if(c_target.loc.loc:Safe!=1) c_target.LevelStat("Defence",rand(1,2))
											if(src.Hand=="Right")view(src,10) << sound('LPunchHIt.ogg',0,0,0,100)
											if(src.Hand=="Kick")
												bonus+=2
												view(src,10) << sound('HandDam_Normal2.ogg',0,0,0,100)
											if(src.Hand=="Left")view(src,10) << sound('KickHit.ogg',0,0,0,100)
											if(src.Gates >= 5&&move&&!injutsu)
												c_target.icon_state="push"
												c_target.injutsu=1
												c_target.canattack=0
												c_target.firing=1
												step_away(c_target,src)
												walk(c_target,c_target.dir)
												if(c_target.client)spawn() c_target.ScreenShake(3)
												spawn(3)
													if(c_target)
														walk(c_target,0)
														c_target.injutsu=0
														if(!c_target.swimming)c_target.icon_state=""
														c_target.canattack=1
														c_target.firing=0
											if(bonesword)
												if(c_target.icon_state == "")
													c_target.move=0
													spawn(bonesword)if(c_target)c_target.move=1
										else
											if(src.agility>=c_target.agility || src.Gates >= 3)
												var/bonus=0
												if(src.mystical_palms)bonus+=5
												if(bugpass)bonus+=3
												bonus+=src.bonesword
												var/defendedhit=(60-round(1*((150-src.strength)/3)))-(c_target.defence/2)+rand(0,10)
												if(defendedhit<0)defendedhit=1
												// WHY WHY WHY ? if(src.loc.loc:Safe!=1) src.strength++
												src.Levelup()
												if(c_target)
													if(c_target.loc.loc:Safe!=1) c_target.LevelStat("Defence",rand(1,2))
												if(defence<src.strength/3)
													var/obj/Drag=new /obj/Drag/Dirt(c_target.loc)
													Drag.dir=c_target.dir
													step(c_target,src.dir)
													c_target.dir = get_dir(c_target,src)
													step_to(src,c_target,1)
												c_target.DealDamage(defendedhit+ (((src.strength * 0.1)* src.mystical_palms) + ((src.strength * 0.025)* src.bonesword) + ((src.strength * 0.05) * src.Gates)),src,"TaiOrange",0,0,1)
												if(src.Gates>0) src.DealDamage(((src.strength / 150)*10) * src.Gates, src, "maroon")
												if(src.byakugan==1)
													for(var/obj/Jutsus/Byakugan/J in src.jutsus)
														c_target.DealDamage(defendedhit/3, src, "aliceblue", 0, 1)
												if(bonesword)
													if(c_target.icon_state == "")
														c_target.move=0
														spawn(bonesword)if(c_target)c_target.move=1
												flick("defendhit",c_target)
												view(src,10) << sound('Counter_Success.ogg',0,0,0,100)
											else
												flick("dodge",c_target)
												if(c_target.loc.loc:Safe!=1) c_target.LevelStat("Agility",rand(1,2))
												c_target.Levelup()
						for(var/obj/Training/T in get_step(src,src.dir))
							if(T.health > 0)//also logs
								var/undefendedhit=round(src.strength)//-T.defence/4)
								T.health-=undefendedhit
								if(T) if(T.Good) LevelStat("Strength",10*punchstatexp)
								else LevelStat("Strength",10*punchstatexp)
								if(src.Hand=="Right")view(src,10) << sound('LPunchHIt.ogg',0,0,0,100)
								if(src.Hand=="Kick")view(src,10) << sound('HandDam_Normal2.ogg',0,0,0,100)
								if(src.Hand=="Left")view(src,10) << sound('KickHit.ogg',0,0,0,100)
								T.Break(src)
				else
					if(src.agility>=50)
						for(c_target in get_step(src,src.dir))
							src.dir = get_dir(src,c_target)
							src.Target_Atom(c_target)
							if(c_target in get_step(src,src.dir))
								if(c_target.dead==0&&!istype(c_target,/mob/npc/) || c_target.dead==0&&istype(c_target,/mob/npc/combat))
									var/canhityou=1
									if(c_target.Clan == "Sand")
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
											var/undefendedhit=(60-round(1*((150-src.strength)/3)))-(c_target.defence/4)+rand(0,10)
											if(undefendedhit<0)undefendedhit=1
											if(c_target.Sharingan)
												if(prob((c_target.agility)-(undefendedhit)+(c_target.Sharingan*5)))
													undefendedhit=1
													flick("dodge",c_target)
												else
													undefendedhit-=(c_target.Sharingan+round(c_target.agility/2))
													if(undefendedhit<0) undefendedhit=1
													flick("defend",c_target)
											if(c_target.Owner!=src)
												c_target.DealDamage(undefendedhit+ (((src.strength * 0.1)* src.mystical_palms) + ((src.strength * 0.025)* src.bonesword) + ((src.strength * 0.05) * src.Gates)),src,"TaiOrange",0,0,1)
												if(src.Gates>0) src.DealDamage(((src.strength / 150)*10) * src.Gates, src, "maroon")
												if(src.byakugan==1)
													for(var/obj/Jutsus/Byakugan/J in src.jutsus)
														c_target.DealDamage(undefendedhit/3, src, "aliceblue", 0, 1)
												if(src.loc.loc:Safe!=1) LevelStat("Strength",10*punchstatexp)
											if(c_target)
												if(c_target.loc.loc:Safe!=1) c_target.LevelStat("Defence",rand(1,2))
											if(src.Hand=="Right")view(src,10) << sound('LPunchHIt.ogg',0,0,0,100)
											if(src.Hand=="Kick")view(src,10) << sound('HandDam_Normal2.ogg',0,0,0,100)
											if(src.Hand=="Left")view(src,10) << sound('KickHit.ogg',0,0,0,100)
											if(src.Gates >= 5&&move&&!injutsu)
												c_target.icon_state="push"
												c_target.injutsu=1
												c_target.canattack=0
												c_target.firing=1
												step_away(c_target,src)
												walk(c_target,c_target.dir)
												if(c_target.client)spawn() c_target.ScreenShake(3)
												spawn(3)
													if(c_target)
														walk(c_target,0)
														c_target.injutsu=0
														if(!c_target.swimming)c_target.icon_state=""
														c_target.canattack=1
														c_target.firing=0
											if(bonesword)
												if(c_target.icon_state == "")
													c_target.move=0
													spawn(bonesword)if(c_target)c_target.move=1
										else
											if(src.agility>=c_target.agility || src.Gates >= 3)
												var/bonus=0
												if(src.mystical_palms)bonus+=5
												if(bugpass)bonus+=3
												bonus+=src.bonesword
												var/defendedhit=(60-round(1*((150-src.strength)/3)))-(c_target.defence/2)+rand(0,10)
												if(defendedhit<0)defendedhit=1
												//if(src.loc.loc:Safe!=1) src.strength++
												src.Levelup()
												if(c_target)
													if(c_target.loc.loc:Safe!=1) c_target.LevelStat("Defence",rand(1,2))
												if(defence<src.strength/3)
													var/obj/Drag=new /obj/Drag/Dirt(c_target.loc)
													Drag.dir=c_target.dir
													step(c_target,src.dir)
													c_target.dir = get_dir(c_target,src)
													step_to(src,c_target,1)
												c_target.DealDamage(defendedhit+ (((src.strength * 0.1)* src.mystical_palms) + ((src.strength * 0.025)* src.bonesword) + ((src.strength * 0.05) * src.Gates)),src,"TaiOrange",0,0,1)
												if(src.Gates>0) src.DealDamage(((src.strength / 150)*10) * src.Gates, src, "maroon")
												if(src.byakugan==1)
													for(var/obj/Jutsus/Byakugan/J in src.jutsus)
														c_target.DealDamage(defendedhit/3, src, "aliceblue", 0, 1)
												flick("defendhit",c_target)
												view(src,10) << sound('Counter_Success.ogg',0,0,0,100)
												if(bonesword)
													if(c_target.icon_state == "")
														c_target.move=0
														spawn(bonesword)if(c_target)c_target.move=1
											else
												flick("dodge",c_target)
												if(c_target.loc.loc:Safe!=1) c_target.LevelStat("Agility",rand(1,2))
						for(var/obj/Training/T in get_step(src,src.dir))
							if(T.health>0)
								var/undefendedhit=round(src.strength)//-T.defence/4)
								T.health-=undefendedhit//,src,"TaiOrange")
								if(T) if(T.Good) LevelStat("Strength",10*punchstatexp)
								else LevelStat("Strength",10*punchstatexp)
								if(src.Hand=="Right")view(src,10) << sound('LPunchHIt.ogg',0,0,0,100)
								if(src.Hand=="Kick")view(src,10) << sound('HandDam_Normal2.ogg',0,0,0,100)
								if(src.Hand=="Left")view(src,10) << sound('KickHit.ogg',0,0,0,100)
								T.Break(src)
				if(Specialist=="strength"||Specialist2=="strength")
					if(src.combo==3)
						src.combo=0
						spawn(src.attkspeed)if(src)src.canattack=1
					else
						var/wait=src.attkspeed-(src.agility/50)
						if(wait<=0)wait=1.75
						spawn(wait)if(src)src.canattack=1
				else spawn(src.attkspeed)if(src)src.canattack=1
