mob
	proc
		Eight_Gates_Assault()
			for(var/obj/Jutsus/Eight_Gates_Assault/J in src.jutsus)
				if(src.byakugan==0)
					src << output("Byakugan must be active.","Action.Output")
					return
				if(src.PreJutsu(J))
					if(loc.loc:Safe!=1) src.LevelStat("Ninjutsu",((J.maxcooltime*3/30)*jutsustatexp))
					if(loc.loc:Safe!=1) src.LevelStat("Agility",((J.maxcooltime*3/30)*jutsustatexp))
					if(loc.loc:Safe!=1) src.LevelStat("Precision",((J.maxcooltime*3/30)*jutsustatexp))
					if(J.level==1) J.damage=((jutsudamage*J.Sprice)/2)/10
					if(J.level==2) J.damage=((jutsudamage*J.Sprice)/1.5)/10
					if(J.level==3) J.damage=((jutsudamage*J.Sprice)/1.25)/10
					if(J.level==4) J.damage=(jutsudamage*J.Sprice)/10
					if(J.level<4) if(loc.loc:Safe!=1) J.exp+=jutsumastery*(J.maxcooltime/20); J.Levelup()
					src.icon_state = "punchrS"

					var/state/cant_attack/e = new()
					AddState(src, e, -1)

					var/state/cant_move/f = new()
					AddState(src, f, -1)

					var/mob/c_target=src.Target_Get(TARGET_MOB)
					if(c_target)
						step_towards(src, c_target)
						src.dir = get_dir(src.loc, c_target.loc)
					var/mob/Z

					var/state/cant_attack/a = new()
					var/state/cant_move/b = new()

					for(var/mob/M in get_step(src,src.dir))

						AddState(M, a, -1)
						AddState(M, b, -1)

						Z = M
					if(Z)
						for(var/i=0,i<5,i++)
							sleep(1)
							flick("punchr",src)
							sleep(1)
							flick("punchrS",src)
							var/obj/O = new/obj
							O.loc = Z.loc
							O.layer = 200
							O.pixel_y=-16
							O.pixel_x=-16
							O.pixel_y+=rand(-5,5)
							O.pixel_x+=rand(-5,5)
							flick('EightGatesAssault.dmi',O)
							spawn(4)if(O)del(O)
							Z.DealDamage((J.damage+round(((src.ninjutsu_total / 450)+(src.agility_total / 450)+(src.precision_total / 450))*2*J.damage))/3,src,"cyan",0,1)
							Z.DealDamage(J.damage+round(((src.ninjutsu_total / 450)+(src.agility_total / 450)+(src.precision_total / 450))*2*J.damage),src,"NinBlue")
						for(var/i=0,i<3,i++)
							step(src,src.dir)
							step(src,src.dir)
							sleep(2)
							flick("punchr",src)
							sleep(2)
							flick("punchrS",src)
							step(Z,src.dir)
							step(Z,src.dir)
							Z.dir = get_dir(Z,src)
							var/obj/O = new/obj
							O.loc = Z.loc
							O.layer = 200
							O.pixel_y=-16
							O.pixel_x=-16
							O.pixel_y+=rand(-5,5)
							O.pixel_x+=rand(-5,5)
							flick('EightGatesAssault.dmi',O)
							spawn(4)if(O)del(O)
							Z.DealDamage((J.damage+round(((src.ninjutsu_total / 450)+(src.agility_total / 450)+(src.taijutsu_total / 450))*2*J.damage))/3,src,"cyan",0,1)
							Z.DealDamage(J.damage+round(((src.ninjutsu_total / 450)+(src.agility_total / 450)+(src.taijutsu_total / 450))*2*J.damage),src,"NinBlue")
						if(Z)
							RemoveState(Z, a, STATE_REMOVE_REF)
							RemoveState(Z, b, STATE_REMOVE_REF)
							Z.icon_state = ""
					src.icon_state = ""
					RemoveState(src, e, STATE_REMOVE_REF)
					RemoveState(src, f, STATE_REMOVE_REF)

		Eight_Trigrams_Mountain_Crusher()
			for(var/obj/Jutsus/Eight_Trigrams_Mountain_Crusher/J in src.jutsus)
				if(src.PreJutsu(J))
					var/mob/c_target=src.Target_Get(TARGET_MOB)
					if(loc.loc:Safe!=1) src.LevelStat("Ninjutsu",((J.maxcooltime*3/20)*jutsustatexp))
					if(loc.loc:Safe!=1) src.LevelStat(SPECIALIZATION_TAIJUTSU,((J.maxcooltime*3/20)*jutsustatexp))
					if(J.level==1) J.damage=((jutsudamage*J.Sprice)/2)*0.7
					if(J.level==2) J.damage=((jutsudamage*J.Sprice)/1.5)*0.7
					if(J.level==3) J.damage=((jutsudamage*J.Sprice)/1.25)*0.7
					if(J.level==4) J.damage=(jutsudamage*J.Sprice)*0.7
					if(J.level<4) if(loc.loc:Safe!=1) J.exp+=jutsumastery*(J.maxcooltime/20); J.Levelup()
					flick("punchr",src)
					src.PlayAudio('Beam.ogg', output = AUDIO_HEARERS)
					Bind(src, 15)
					if(c_target)src.dir=get_dir(src,c_target)
					var/obj/Projectiles/Effects/JinraiBack/Aa=new(get_step(src,src.dir))
					Aa.icon = 'Mountain Crusher.dmi'
					Aa.IsJutsuEffect=src
					Aa.dir = src.dir
					Aa.pixel_y=32
					Aa.layer = src.layer+1
					var/obj/Projectiles/Effects/JinraiHead/A=new(get_step(src,src.dir))
					A.icon = 'Mountain Crusher.dmi'
					A.dir = src.dir
					A.Owner=src
					A.pixel_y=32
					A.layer=src.layer
					A.fightlayer=src.fightlayer
					A.damage=J.damage+round(((src.ninjutsu_total / 450)+(src.taijutsu_total / 450))*2*J.damage)
					A.level=J.level
					walk(A,dir,0)
					icon_state=""
					Aa.dir = src.dir

		Eight_Trigrams_64_Palms()
			if(src.byakugan==0)
				src<<output("<font color=#C0C0C0>You must have Byakugan activated.</font>","Action.Output")
				return

			var/mob/c_target = src.Target_Get(TARGET_MOB)
			if(!c_target)
				src << output("This jutsu requires a target","Action.Output")
				return

			for(var/obj/Jutsus/Eight_Trigrams_64_Palms/J in src.jutsus)
				if(src.PreJutsu(J))
					if(loc.loc:Safe!=1) src.LevelStat("Ninjutsu",((J.maxcooltime*3/30)*jutsustatexp))
					if(loc.loc:Safe!=1) src.LevelStat("Agility",((J.maxcooltime*3/30)*jutsustatexp))
					if(loc.loc:Safe!=1) src.LevelStat("Precision",((J.maxcooltime*3/30)*jutsustatexp))
					if(J.level==1) J.damage=((jutsudamage*J.Sprice)/2)
					if(J.level==2) J.damage=((jutsudamage*J.Sprice)/1.5)
					if(J.level==3) J.damage=((jutsudamage*J.Sprice)/1.25)
					if(J.level==4) J.damage=(jutsudamage*J.Sprice)
					if(J.level<4) if(loc.loc:Safe!=1) J.exp+=jutsumastery*(J.maxcooltime/20); J.Levelup()
					flick("jutsuse",src)
					src.PlayAudio('dash.wav', output = AUDIO_HEARERS)

					var/state/cant_attack/e = new()
					var/state/cant_move/f = new()
					AddState(src, e, -1)
					AddState(src, f, -1)

					J.Levelup()
					var/check=0
					if(c_target)
						src.loc = c_target.loc
						step_away(src,c_target)
						src.dir=get_dir(src,c_target)
					var/obj/O = new/obj
					O.IsJutsuEffect=src
					O.loc = src.loc
					O.icon = '50Palms.dmi'
					O.icon_state = ""
					flick("start",O)
					O.pixel_y-=32
					O.pixel_x-=87
					spawn(100) if(O) del(O)
					spawn(7) O.icon_state = "done"

					var/state/cant_attack/a = new()
					var/state/cant_move/b = new()

					while(check<>1)
						sleep(1)
						src.copy = "Hakke"
						view() << output("<font color=#C0C0C0><b>[src] Says: 8 palms!","Action.Output")
						var/obj/A = new/obj
						A.IsJutsuEffect=src
						A.loc = src.loc
						A.icon = 'Misc Effects.dmi'
						A.icon_state = "arrow"
						A.y+=3
						A.dir = pick(EAST,WEST,NORTH,SOUTH)
						A.layer=100
						src.ArrowTasked = A
						step(src,src.dir)
						if(c_target) step_towards(src,c_target)
						sleep(7)
						if(A)
							del(A)
						if(src.copy <> "Hakke" && J.level>1)
							src.copy = "Hakke2"
							view() << output("<font color=#C0C0C0><b>[src] Says: 16 palms!","Action.Output")
							var/obj/A2 = new/obj
							A2.IsJutsuEffect=src
							A2.loc = src.loc
							A2.icon = 'Misc Effects.dmi'
							A2.icon_state = "arrow"
							A2.y+=3
							A2.dir = pick(EAST,WEST,NORTH,SOUTH)
							A2.layer=100
							src.ArrowTasked = A2
							step(src,src.dir)
							if(c_target)step_towards(src,c_target)
							sleep(7)
							if(A2)
								del(A2)
							if(src.copy <> "Hakke2" && J.level>2)
								src.copy = "Hakke3"
								view() << output("<font color=#C0C0C0><b>[src] Says: 32 palms!","Action.Output")
								var/obj/A3 = new/obj
								A3.IsJutsuEffect=src
								A3.loc = src.loc
								A3.icon = 'Misc Effects.dmi'
								A3.icon_state = "arrow"
								A3.y+=3
								A3.dir = pick(EAST,WEST,NORTH,SOUTH)
								A3.layer=100
								src.ArrowTasked = A3
								step(src,src.dir)
								if(c_target)step_towards(src,c_target)
								sleep(7)
								if(A3)
									del(A3)
								if(src.copy <> "Hakke3" && J.level>3)
									src.copy = "Hakke4"
									view() << output("<font color=#C0C0C0><b>[src] Says: 64 PALMS!","Action.Output")
									check=1
									var/obj/A4 = new/obj
									A4.IsJutsuEffect=src
									A4.loc = src.loc
									A4.icon = 'Misc Effects.dmi'
									A4.icon_state = "arrow"
									A4.y+=3
									A4.dir = pick(EAST,WEST,NORTH,SOUTH)
									A4.layer=100
									src.ArrowTasked = A4
									step(src,src.dir)
									if(c_target)step_towards(src,c_target)
									sleep(7)
									if(A4)
										del(A4)
								else check=1
							else check=1
						else check=1
						for(var/mob/m in get_step(src,src.dir))
							RemoveState(m, a, STATE_REMOVE_REF)
							RemoveState(m, b, STATE_REMOVE_REF)
						flick("over",O)
						spawn(7) del(O)
						src.copy = null
						RemoveState(src, e, STATE_REMOVE_REF)
						RemoveState(src, f, STATE_REMOVE_REF)
		Kaiten()
			for(var/obj/Jutsus/Eight_Trigrams_Palm_Heavenly_Spin/J in src.jutsus)
				if(src.PreJutsu(J))
					if(loc.loc:Safe!=1) src.LevelStat("Ninjutsu",((J.maxcooltime*3/20)*jutsustatexp))
					if(loc.loc:Safe!=1) src.LevelStat("Agility",((J.maxcooltime*3/20)*jutsustatexp))
					flick("jutsuse",src)
					src.PlayAudio('Powerup.ogg', output = AUDIO_HEARERS)
					spawn(7)
						src.PlayAudio('Powerup.ogg', output = AUDIO_HEARERS)
						spawn(7)if(src) src.PlayAudio('Powerup.ogg', output = AUDIO_HEARERS)
					var/obj/O = new/obj
					O.IsJutsuEffect=src
					O.loc = src.loc
					O.pixel_x-=(3.5*32)
					O.pixel_y-=(1*32)
					O.icon = 'Kaiten.dmi'
					O.icon_state = ""
					O.layer=200

					var/state/cant_attack/e = new()
					var/state/cant_move/f = new()
					AddState(src, e, -1)
					AddState(src, f, -1)

					src.dir = SOUTH
					flick("throw",src)
					src.icon_state = "jutsuse"
					flick("start",O)
					for(var/s=0,s<7,s++)
						switch(src.dir)
							if(WEST) src.dir=NORTH
							if(SOUTH) src.dir=WEST
							if(EAST) src.dir=SOUTH
							if(NORTH) src.dir=EAST
					O.icon_state = "Loop"
					if(J.level==1) J.damage=((jutsudamage*J.Sprice)/2)/5
					if(J.level==2) J.damage=((jutsudamage*J.Sprice)/1.5)/5
					if(J.level==3) J.damage=((jutsudamage*J.Sprice)/1.25)/5
					if(J.level==4) J.damage=(jutsudamage*J.Sprice)/5
					if(J.level<4) if(loc.loc:Safe!=1) J.exp+=jutsumastery*(J.maxcooltime/20); J.Levelup()
					if(J.level==4)
						for(var/mob/M in range(4))
							if(!istype(M,/mob/npc) && !CheckState(M, new/state/knockback_immune) && !M.dead && !CheckState(M, new/state/swimming) || istype(M,/mob/npc/combat) && !CheckState(M, new/state/knockback_immune) && !M.dead)
								var/ki = get_dist(M,src)
								for(var/i=0,i<ki,i++) spawn() step_away(M,src); sleep(1.5)
					for(var/i=0,i<17,i++)
						if(O.loc != src.loc)
							src << output("You left your rotation.","Action.Output")
							goto skiploop
						for(var/obj/Projectiles/Weaponry/Ok in orange(J.level))
							walk_to(Ok,0)
							step_away(Ok,src)
							walk(Ok,Ok.dir)
						for(var/obj/Projectiles/Ok in orange(J.level))
							walk_to(Ok,0)
							step_away(Ok,src)
							walk(Ok,Ok.dir)
						for(var/mob/M in orange(2))
							if(M.dead) continue
							if(!istype(M,/mob/npc) || !istype(M,/mob/npc/combat))
								M.icon_state="push"
								AddState(M, new/state/cant_move, 3)
								M.DealDamage(J.damage+round(((src.ninjutsu_total / 450)+(src.agility_total / 450))*2*J.damage),src,"NinBlue")
								var/IA = rand(1,2)
								if(IA==1)step_away(M,src)
								if(M.client)spawn() M.ScreenShake(10)
								if(M)
									walk(M,0)
									if(!CheckState(M, new/state/swimming)&&!M.dead)M.icon_state=""
						switch(src.dir)
							if(WEST) src.dir=NORTH
							if(SOUTH) src.dir=WEST
							if(EAST) src.dir=SOUTH
							if(NORTH) src.dir=EAST
						sleep(0.5)
					skiploop
					O.icon_state = ""
					O.pixel_x-=32
					O.pixel_x-=16
					O.pixel_x-=8
					flick("end",O)
					sleep(5)
					if(O)del(O)
					src.icon_state = ""
					RemoveState(src, e, STATE_REMOVE_REF)
					RemoveState(src, f, STATE_REMOVE_REF)
		Byakugan()
			for(var/obj/Jutsus/Byakugan/J in src.jutsus)
				if(src.byakugan)
					for(var/image/i in client.images)if(i.name=="ByakuganCircle")del(i)
					src.byakugan=0
					src << output("<font color=#C0C0C0><b>You deactivate your Byakugan","Action.Output")
					src.client.eye=src
					src.client:perspective = EDGE_PERSPECTIVE
					return
				if(!src.byakugan)
					if(src.PreJutsu(J))
						if(loc.loc:Safe!=1) src.LevelStat("Ninjutsu",((J.maxcooltime*3/20)*jutsustatexp))
						if(loc.loc:Safe!=1) src.LevelStat("Precision",((J.maxcooltime*3/20)*jutsustatexp))
						if(J.level<4)
							if(loc.loc:Safe!=1) 
								J.exp+=jutsumastery*(J.maxcooltime/20)
								J.Levelup()
						flick("jutsuse",src)
						view(src)<<output("<font color=#C0C0C0><b>[src] Says: Byakugan!","Action.Output")
						var/obj/A = new/obj(usr.loc)
						A.icon='ClanEyes.dmi'
						A.icon_state="Byakugan"
						A.layer=MOB_LAYER+1
						var/matrix/m = matrix()
						m.Translate(-16,16)
						A.transform = m
						A.linkfollow(src)
						spawn(10) del(A)
						src.byakugan=1
						Bind(src, 2)
						while(src.byakugan)
							sleep(1)
							if(src && src.byakugan)
								src.DealDamage(10, src, "aliceblue", 0, 1)
								
								for(var/atom/movable/ZX in orange())
									if(!ZX) continue
									sleep(1)
									var/minusx=-16
									if(ismob(ZX))minusx=0
									if(ZX) if(ZX.byakuview == 1)
										var/QWE = image('byakuglow.dmi',layer=600,loc = ZX,pixel_x=minusx)
										if(istype(ZX,/mob/Clones/)) QWE+=rgb(255,0,0)
										src << QWE
										spawn(5)if(QWE)del(QWE)
							
							sleep(12)
							if(src.chakra<=0)
								src.chakra=0
								src.byakugan=0
								src << output("<font color=[colour2html("red")]><b>Your byakugan has been deactivated.","Action.Output")

		Eight_Trigrams_Empty_Palm()
			for(var/obj/Jutsus/Eight_Trigrams_Empty_Palm/J in src.jutsus)
				if(src.PreJutsu(J))
					if(loc.loc:Safe!=1) src.LevelStat("Ninjutsu",((J.maxcooltime*3/20)*jutsustatexp))
					if(loc.loc:Safe!=1) src.LevelStat(SPECIALIZATION_TAIJUTSU,((J.maxcooltime*3/20)*jutsustatexp))
					var/obj/A = new/obj/MiscEffects/MeteorDust(src.loc)
					A.pixel_x=-30
					A.pixel_y=-10
					A.dir=src.dir
					if(J.level==1) J.damage=((jutsudamage*J.Sprice)/2)*0.3
					if(J.level==2) J.damage=((jutsudamage*J.Sprice)/1.5)*0.5
					if(J.level==3) J.damage=((jutsudamage*J.Sprice)/1.25)*0.3
					if(J.level==4) J.damage=(jutsudamage*J.Sprice)*0.3
					if(J.level==1)
						A.icon_state="0"
					if(J.level==2)
						A.icon_state="1"
					if(J.level==3)
						A.icon_state="2"
					if(J.level==4)
						A.icon_state="max"
					if(J.level<4) if(loc.loc:Safe!=1) J.exp+=jutsumastery*(J.maxcooltime/20); J.Levelup()
					var/mob/c_target=src.Target_Get(TARGET_MOB)
					if(c_target)
						step_towards(src, c_target)
						src.dir = get_dir(src.loc, c_target.loc)
					if(prob(50))flick("punchl",src)
					else flick("punchr",src)
					src.PlayAudio('Skill_BigRoketFire.wav', output = AUDIO_HEARERS)
					var/obj/O = new/obj
					O.loc = src.loc
					O.dir = src.dir
					O.icon = 'Eight Trigrams Empty Palm.dmi'
					O.icon_state = "head"
					O.animate_movement = SYNC_STEPS
					for(var/i=1,i<4,i++)
						sleep(1)
						if(O.loc<>src.loc)
							var/obj/K = new/obj
							K.loc = O.loc
							K.dir = O.dir
							K.icon = 'Eight Trigrams Empty Palm.dmi'
							K.icon_state = "tail"
							K.animate_movement = SYNC_STEPS
							spawn(4)if(K)del(K)
						step(O,O.dir)
						for(c_target in view(O,0))
							src.dir = get_dir(src,c_target)
							src.Target_Atom(c_target)
							if(c_target in view(O,0))
								if(c_target.dead==0&&!istype(c_target,/mob/npc/) || c_target.dead==0&&istype(c_target,/mob/npc/combat))
									if(c_target.fightlayer==src.fightlayer)
										if(c_target.dodge==0)
											var/undefendedhit=J.damage+round(((src.ninjutsu_total / 450)+(src.taijutsu_total / 450))*2*J.damage)
											if(undefendedhit<0)undefendedhit=1
											c_target.DealDamage(undefendedhit,src,"TaiOrange",0,0,1)
											AddState(c_target, new/state/knockback, 10)
											AddState(c_target, new/state/cant_move, 10)
											if(src.Hand=="Left") src.PlayAudio('LPunchHIt.ogg', output = AUDIO_HEARERS)
											if(src.Hand=="Right") src.PlayAudio('HandDam_Normal2.ogg', output = AUDIO_HEARERS)
										else
											if(src.agility_total>=c_target.agility_total)
												var/defendedhit=(J.damage+round(((src.ninjutsu_total / 450)+(src.taijutsu_total / 450))*2*J.damage))/2
												if(defendedhit<0)
													defendedhit=1
												if(defence_total<src.taijutsu_total/2)
													var/obj/Drag=new /obj/Drag/Dirt(c_target.loc)
													Drag.dir=c_target.dir
													step(c_target,src.dir)
													c_target.dir = get_dir(c_target,src)
													step_to(src,c_target,1)

												c_target.DealDamage(defendedhit,src,"TaiOrange",0,0,1)

												AddState(c_target, new/state/knockback, 3)
												AddState(c_target, new/state/cant_move, 3)

												flick("defendhit",c_target)
												src.PlayAudio('Counter_Success.ogg', output = AUDIO_HEARERS)
											else
												flick("dodge",c_target)
												if(c_target.loc.loc:Safe!=1) c_target.LevelStat("Agility",rand(10,20))
					del(O)
		/*				for(var/obj/Training/T in view(O,0))
							if(T.health>=1)
								var/undefendedhit=round(((damage+src.taijutsu_total+src.taijutsu_total)/3))
								T.DealDamage(undefendedhit,src,"TaiOrange")
								if(T) if(T.Good) LevelStat(SPECIALIZATION_TAIJUTSU,rand(1,2))
								else LevelStat(SPECIALIZATION_TAIJUTSU,rand(0.2,1))
								if(T) if(T.Good) src.LevelStat(SPECIALIZATION_TAIJUTSU,1)
								else src.LevelStat(SPECIALIZATION_TAIJUTSU,0.2)
								if(src.Hand=="Left") src.PlayAudio('LPunchHIt.ogg', output = AUDIO_HEARERS)
								if(src.Hand=="Right") src.PlayAudio('HandDam_Normal2.ogg', output = AUDIO_HEARERS)
								T.Break(src)
					del(O) */

