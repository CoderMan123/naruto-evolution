mob
	verb
		ThrowMob()
			set name = "Push/Pull"
			set category = "keybindable"
			set hidden=1
			for(var/mob/M in get_step(src,src.dir))
				if(istype(M, /mob/Clones)) return
			if(ChakraCheck(0)) return
			src.HengeUndo()
			if(src.likeaclone) return
			else
				if(ThrowingMob)
					if(!CheckState(src, new/state/cant_attack) && !CheckState(src, new/state/swimming))
						if(src.dead==0&&src.dodge==0)
							var/mob/M=ThrowingMob
							if(!M.key) return
							if(get_dist(src,M)>1) return
							if(!M||M.dead||CheckState(M, new/state/swimming)) return
							if(M.caged==1) return
							if(CheckState(M, new/state/knockback_immune))return
							flick("2fist",src)
							src.PlayAudio('dash.wav', output = AUDIO_HEARERS)
							ThrowingMob=null
							M.BeingThrown=null
							M.icon_state="push"
							var/bind_time = 4
							var/visual_time = bind_time - (bind_time/100) * M.tenacity
							AddState(M, new/state/cant_move, bind_time, src)
							if(M.client)spawn()M.ScreenShake(5)
							spawn()
								var/i = visual_time
								for(i, i>0, i--)
									if(M)
										sleep(0.2)
										step_away(M, src)
								M.icon_state=""
							return
				if(!CheckState(src, new/state/cant_attack) && !CheckState(src, new/state/swimming))
					if(src.dead==0&&src.dodge==0)
						for(var/mob/M in get_step(src,src.dir))
							if(M.dead||CheckState(M, new/state/swimming)) continue
							if(M.caged==1) return
							if(CheckState(M, new/state/knockback_immune))return

							flick("punchrS",src)
							src.ThrowingMob=M
							M.BeingThrown=1
		Dodge()
			set name = "Block/Dodge/Dash"
			set category = "keybindable"
			set hidden=1

			src.HengeUndo()

			if(src.icon_state == "dead") return

			if(ChakraCheck(0)) return
			if(src.likeaclone)
				var/mob/Clones/SC=src.likeaclone
				if(!CheckState(src, new/state/cant_attack) && !CheckState(src, new/state/swimming))
					if(SC.dead==0&&SC.dodge==0&&SC.dashable==1&&SC.health>SC.maxhealth/3)
						SC.PlayAudio('dash.wav', output = AUDIO_HEARERS)
						if(SC.icon_state<>"blank")flick("dash",SC)
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
						SC.PlayAudio('Swing4.ogg', output = AUDIO_HEARERS)
						if(SC.icon_state<>"blank")SC.icon_state="defend"
						SC.dodge=1
						sleep(5)
						if(SC.dead==0)
							if(SC.icon_state<>"blank")SC.icon_state=""
							SC.dodge=0
			if(!CheckState(src, new/state/cant_attack) && !CheckState(src, new/state/swimming) && !Effects["Rasengan"] && !Effects["Chidori"])
				if(src.explosivetag)
					src.explosivetag=0
					for(var/obj/Projectiles/Weaponry/ExplosiveTag/ET in view(src,50))
						if(ET.damage&&ET.Owner==src)
							var/obj/BURN = new/obj/Projectiles/Effects/MediumBurntSpot(ET.loc)
							BURN.loc=ET.loc
							var/obj/EXPLODE = new/obj/Projectiles/Effects/SmallExplosion(ET.loc)
							EXPLODE.loc=ET.loc
							var/damage=ET.damage
							ET.PlayAudio('Explo_StoneMed2.ogg', output = AUDIO_HEARERS)
							for(var/mob/M in view(ET,3))
								if(M.dead==0)
									M.DealDamage(damage,src,"TaiOrange")//HERE
									if(istype(M,/mob/npc) && !istype(M,/mob/npc/combat))..()
									else
										M.icon_state="push"
										AddState(M, new/state/cant_move, 10, src)
										walk_away(M,ET,5,0)
										spawn(10)
											if(M)
												walk(M,0)
												if(M.dead==0&&!CheckState(M, new/state/swimming))
													M.icon_state=""
												M.Death(src)
							ET.damage=null
							ET.icon_state="blank"
							spawn(50)if(ET)del(ET)
				if(src.C3bombz==0)
/*					if(src.dead==0&&src.dodge==0&&src.dashable==1&&src.health>src.maxhealth/3)
						src.PlayAudio('dash.wav', output = AUDIO_HEARERS)
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
						src.PlayAudio('Swing4.ogg', output = AUDIO_HEARERS)
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