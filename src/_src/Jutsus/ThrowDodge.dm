mob
	verb
		ThrowMob()
			set hidden=1
			for(var/mob/M in get_step(src,src.dir))
				if(istype(M, /mob/Clones)) return
			if(ChakraCheck(0)) return
			src.HengeUndo()
			if(src.likeaclone) return
				/*var/mob/Clones/SC=src.likeaclone
				if(SC.ThrowingMob)
					if(SC.canattack==1&&SC.firing==0)
						if(SC.dead==0&&SC.dodge==0&&SC.canattack==1)
							var/mob/M=ThrowingMob
							if(!M.key)
								//src<<"You can't push non player mobs."
								return
							if(get_dist(SC,M)>1) return
							if(!M||M.dead||M.swimming) return
							flick("2fist",SC)
							view(SC) << sound('dash.wav',0,0,0,100)
							SC.ThrowingMob=null
							M.BeingThrown=null
							M.icon_state="push"
							M.injutsu=1
							M.canattack=0
							M.firing=1
							walk(M,SC.dir)
							spawn(4)
								if(M)
									M.icon_state=""
									M.injutsu=0
									M.canattack=1
									M.firing=0
									walk(M,0)
							return
				if(SC.canattack==1&&SC.firing==0)
					if(SC.dead==0&&SC.dodge==0&&SC.canattack==1)
						for(var/mob/M in get_step(SC,SC.dir))
							if(M.dead||M.swimming) continue
							flick("punchrS",SC)
							SC.ThrowingMob=M
							M.BeingThrown=1*/
			else
				if(ThrowingMob)
					if(src.canattack==1&&src.firing==0)
						if(src.dead==0&&src.dodge==0&&src.canattack==1)
							var/mob/M=ThrowingMob
							if(!M.key) return
							if(get_dist(src,M)>1) return
							if(!M||M.dead||M.swimming) return
							if(M.caged==1) return
							if(M.shielded==1)return
							flick("2fist",src)
							view(src) << sound('dash.wav',0,0,0,100)
							ThrowingMob=null
							M.BeingThrown=null
							M.icon_state="push"
							M.injutsu=1
							M.canattack=0
							M.firing=1
							walk(M,src.dir)
							spawn(4)
								if(M)
									M.icon_state=""
									M.injutsu=0
									M.canattack=1
									M.firing=0
									walk(M,0)
							return
				if(src.canattack==1&&src.firing==0)
					if(src.dead==0&&src.dodge==0&&src.canattack==1)
						for(var/mob/M in get_step(src,src.dir))
							if(M.dead||M.swimming) continue
							if(M.caged==1) return
							if(M.shielded==1)return

							flick("punchrS",src)
							src.ThrowingMob=M
							M.BeingThrown=1
		Dodge()
			set hidden=1
			src.HengeUndo()
			if(src.kawarmi)
				/*if(src.Intang)
					src<<"You can't adv sub while Intang."
					return*/
				if(usr.mark.z == usr.z)
					ChakraCheck(0)
					if(usr.dead==1) return
					if(get_dist(usr,usr.mark)>20)
						usr<<"\red <b>Your substitution was set too far away. Jutsu failed!"
						usr.mark=null
						usr.kawarmi=0
						return
					for(var/mob/M in oview(usr,13))M.Target_Remove()
					view(usr)<<sound('flashbang_explode1.wav',0,0)
					usr.mark2=usr.loc
					usr.loc=usr.mark
					usr.move=1
					usr.injutsu=0
					usr.canattack=1
					usr.caged=0
					usr.Sleeping=0
					usr.firing=0
					usr.kawarmi=0
					usr.inshadowfield=0
					var/obj/A = new/obj/MiscEffects/Smoke(usr.loc)
					A.loc=usr.mark2

					if(istype(loc,/turf/Ground/Water))
						if(!usr.waterwalk)
							usr.firing=1
							usr.canattack=0
							usr.stepcounter=0
							usr.icon_state="swim"
							usr.swimming=1
							usr.overlays-=/obj/MaleParts/UnderShade
							usr.overlays+=/obj/MiscEffects/WaterRing
							usr.overlays+=/obj/MiscEffects/WaterRing
						if(usr.waterwalk)
							usr.walkingonwater=1
							usr.overlays+=/obj/MiscEffects/WaterRing
							usr.overlays+=/obj/MiscEffects/WaterRing

					if(!istype(loc,/turf/Ground/Water))
						if(usr.swimming)
							if(!usr.injutsu)
								usr.firing=0
								usr.canattack=1
							usr.stepcounter=0
							usr.icon_state=""
							usr.swimming=null
							usr.overlays+=/obj/MaleParts/UnderShade
							usr.overlays-=/obj/MiscEffects/WaterRing
							usr.overlays-=/obj/MiscEffects/WaterRing
						if(usr.walkingonwater)
							usr.walkingonwater=0
							usr.overlays-=/obj/MiscEffects/WaterRing
							usr.overlays-=/obj/MiscEffects/WaterRing

					sleep(8)
					if(src)
						var/obj/B = new/obj/MiscEffects/LogB(usr.loc)
						B.loc=usr.mark2
				else
					usr.mark=null
					usr.kawarmi=0
			if(ChakraCheck(0)) return
			if(src.likeaclone)
				var/mob/Clones/SC=src.likeaclone
				if(SC.canattack==1&&SC.firing==0)
					if(SC.dead==0&&SC.dodge==0&&SC.canattack==1&&SC.dashable==1&&SC.health>SC.maxhealth/3)
						view(SC) << sound('dash.wav',0,0,0,100)
						if(SC.icon_state<>"blank")flick("dash",SC)
						SC.move=1
						SC.dashable=2
						step(SC,SC.dir)
						spawn(1)if(SC)step(SC,SC.dir)
						spawn(2)if(SC)step(SC,SC.dir)
						spawn(2)if(SC)SC.dashable=0
						return
					if(SC.dodge==0&&SC.dashable==0)
						for(var/mob/C in orange(SC,1))
							SC.dir = get_dir(SC,C)
							break
						view(SC) << sound('Swing4.ogg',0,0,0,50)
						if(SC.icon_state<>"blank")SC.icon_state="defend"
						SC.dodge=1
						sleep(5)
						if(SC.dead==0)
							if(SC.icon_state<>"blank")SC.icon_state=""
							SC.dodge=0
			if(src.canattack==1&&src.firing==0&&!Effects["Rasengan"]&&!Effects["Chidori"])
				if(src.explosivetag)
					src.explosivetag=0
					for(var/obj/Projectiles/Weaponry/ExplosiveTag/ET in view(src,50))
						if(ET.damage&&ET.Owner==src)
							var/obj/BURN = new/obj/Projectiles/Effects/MediumBurntSpot(ET.loc)
							BURN.loc=ET.loc
							var/obj/EXPLODE = new/obj/Projectiles/Effects/SmallExplosion(ET.loc)
							EXPLODE.loc=ET.loc
							var/damage=ET.damage
							view(ET)<<sound('Explo_StoneMed2.ogg',0,0)
							for(var/mob/M in view(ET,3))
								if(M.dead==0)
									M.DealDamage(damage-(M.defence/5),src,"TaiOrange")//HERE
									if(istype(M,/mob/npc))..()
									else
										M.icon_state="push"
										M.injutsu=1
										walk_away(M,ET,5,0)
										spawn(10)
											if(M)
												walk(M,0)
												M.injutsu=0
												if(M.dead==0&&!M.swimming)
													M.icon_state=""
												M.Death(src)
							ET.damage=null
							ET.icon_state="blank"
							spawn(50)if(ET)del(ET)
				if(src.kawarmi==0 && src.C3bombz==0)
/*					if(src.dead==0&&src.dodge==0&&src.canattack==1&&src.dashable==1&&src.health>src.maxhealth/3)
						view(src) << sound('dash.wav',0,0,0,100)
						if(src.icon_state<>"blank")flick("dash",src)
						src.dashable=2
						step(src,src.dir)
						spawn(1)if(src)step(src,usr.dir)
						spawn(2)
							if(src)step(usr,usr.dir)
							if(usr)usr.dashable=0*/
						//return
					if(usr.dodge==0&&usr.dashable==0)
						var/mob/c_target=usr.Target_Get(TARGET_MOB)
						if(c_target)
							usr.dir = get_dir(usr,c_target)
							usr.Target_Atom(c_target)
						usr.dashable=1
						usr.dodge=1
						view(usr) << sound('Swing4.ogg',0,0,0,50)
						if(usr.icon_state<>"blank")
							usr.icon_state="defend"
						for(var/mob/Clones/C in world)if(C.Owner==src)C.icon_state="defend"
						sleep(5)
						for(var/mob/Clones/C in world)if(C.Owner==src)C.icon_state=""
						if(usr.dead==0)
							if(usr.icon_state<>"blank")usr.icon_state=""
							usr.dodge=0
							usr.dashable=0
				else
					if(src.C3bombz)
						var/obj/O = src.C3bombz
						O.Boomz(src)
						src.C3bombz=0