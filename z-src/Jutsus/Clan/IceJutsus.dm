mob
	proc
		Ice_Explosion()
			for(var/obj/Jutsus/Ice_Explosion/J in src.jutsus)
				if(!has_water())
					src << output("<Font color=Aqua>You need a nearby water source to use this.</Font>","Action.Output")
					return
				if(src.PreJutsu(J))
					if(loc.loc:Safe!=1) src.LevelStat("Ninjutsu",((J.maxcooltime*3/10)*jutsustatexp))
					if(J.level==1) J.damage=0.6*((jutsudamage*J.Sprice)/2)
					if(J.level==2) J.damage=0.6*((jutsudamage*J.Sprice)/1.5)
					if(J.level==3) J.damage=0.6*((jutsudamage*J.Sprice)/1.25)
					if(J.level==4) J.damage=0.6*(jutsudamage*J.Sprice)
					if(J.level<4) if(loc.loc:Safe!=1) J.exp+=jutsumastery*(J.maxcooltime/20); J.Levelup()
					var/matrix/m = matrix()
					m.Translate(-16,-8)
					var/obj/A = new/obj(usr.loc)
					A.layer= MOB_LAYER+1
					A.icon = 'IceCrystals.dmi'
					A.icon_state = "spikes"
					A.transform = m
					var/obj/B = new/obj(usr.loc)
					B.layer= MOB_LAYER+1
					B.icon = 'IceCrystals.dmi'
					B.icon_state = "explosion1"
					step(B,WEST)
					B.transform = m
					var/obj/C = new/obj(usr.loc)
					C.layer= MOB_LAYER+1
					C.icon = 'IceCrystals.dmi'
					C.icon_state = "explosion2"
					step(C,EAST)
					C.transform = m
					flick("groundjutsu",src)
					Bind(src, 7)
					sleep(3)
					for(var/mob/M in orange(2,src))
						if(M == src) return
						if(M.dead)return
						M.DealDamage(J.damage+round((src.ninjutsu_total / 200)*2*J.damage),src,"NinBlue")
						if(M.henge==4||M.henge==5)M.HengeUndo()
						src.PlayAudio('knife_hit4.wav', output = AUDIO_HEARERS)
						M.Bleed(M)
					sleep(7)
					del A
					del B
					del C


		Demonic_Ice_Mirrors()
			for(var/obj/Jutsus/Demonic_Ice_Mirrors/J in src.jutsus)
				if(!has_water())
					src << output("<Font color=Aqua>You need a nearby water source to use this.</Font>","Action.Output")
					return

				if(src.PreJutsu(J))
					var/mob/c_target=src.Target_Get(TARGET_MOB)
					if(c_target)
						if(loc.loc:Safe!=1) src.LevelStat("Ninjutsu",((J.maxcooltime*3/20)*jutsustatexp))
						if(loc.loc:Safe!=1) src.LevelStat("Precision",((J.maxcooltime*3/20)*jutsustatexp))
						if(J.level<4) if(loc.loc:Safe!=1) J.exp+=jutsumastery*(J.maxcooltime/20); J.Levelup()
						flick("jutsuse",src)
						src.PlayAudio('man_fs_l_mt_wat.ogg', output = AUDIO_HEARERS)

						var/state/cant_attack/e = new()
						var/state/cant_move/f = new()
						AddState(src, e, -1)
						AddState(src, f, -1)

						src.pixel_x=4

						var/state/cant_attack/a = new()
						var/state/cant_move/b = new()
						AddState(c_target, a, -1)
						AddState(c_target, b, -1)

						var/last_loc = c_target.loc
						J.damage += J.damage*1.5
						for(var/i=1,i<8+1,i++)
							var/obj/O = new/obj
							O.IsJutsuEffect=src
							O.loc = c_target.loc
							O.icon = 'Ice Mirrors.dmi'
							O.icon_state = "rawr"
							O.density=1
							O.layer = MOB_LAYER
							O.owner=src
							switch(i)
								if(1) O.dir = NORTHEAST
								if(2) O.dir = NORTHWEST
								if(3) O.dir = SOUTHEAST
								if(4) O.dir = SOUTHWEST
								if(6) O.dir = EAST
								if(7) O.dir = SOUTH
								if(8) O.dir = WEST
								if(5)
									O.dir = NORTH
									src.loc = O.loc
									src.dir=SOUTH
									O.layer = OBJ_LAYER
							for(var/ifd=0,ifd<3,ifd++)
								var/IOU = O.dir
								switch(O.dir)
									if(EAST) step(O,WEST)
									if(WEST) step(O,EAST)
									if(SOUTH) step(O,NORTH)
									if(NORTH) step(O,SOUTH)
									if(NORTHEAST) step(O,SOUTHWEST)
									if(NORTHWEST) step(O,SOUTHEAST)
									if(SOUTHEAST) step(O,NORTHWEST)
									if(SOUTHWEST) step(O,NORTHEAST)
								O.dir = IOU
							O.damage = J.damage
							O.name = "[i]"
						src.invisibility=1
						src.loc = c_target.loc
						step(src,NORTH)
						step(src,NORTH)
						var/turf/NS = get_step(src,NORTH)
						for(var/obj/Ouu in NS)if(Ouu.owner == src)src.loc = NS
						src.dir=SOUTH
						for(var/ivc=0,ivc<22*J.level,ivc++)
							if(c_target.loc != last_loc) break
							if(src.ArrowTasked==null)
								var/olist = list()
								for(var/obj/Osd in view())if(Osd.owner == src)olist+=Osd
								if(length(olist))
									var/obj/IC = pick(olist)
									src.copy = "Icemir [IC.name]"
									var/image/A3 = new/obj
									A3.loc = IC.loc
									A3.icon = 'Misc Effects.dmi'
									A3.icon_state = "arrow"
									A3.y+=3
									A3.dir = pick(EAST,NORTH,SOUTH,WEST)
									A3.layer=100
									src.ArrowTasked = A3
									spawn(16)
										if(A3)
											var/obj/AT = src.ArrowTasked
											del(AT)
											src.ArrowTasked=null
							sleep(1)
						var/obj/AkT = src.ArrowTasked
						del(AkT)
						src.ArrowTasked=null
						for(var/obj/Ohh in view())
							if(Ohh.icon == 'Ice Mirrors.dmi' && Ohh.owner == src)
								Ohh.invisibility=1
								Ohh.density=0
								Ohh.owner=null
								spawn(20)if(Ohh)del(Ohh)
							if(Ohh)if(Ohh.name == "GUI [src.key]")	del(Ohh)
						src.pixel_x=-16

						RemoveState(src, e, STATE_REMOVE_REF)
						RemoveState(src, f, STATE_REMOVE_REF)
						src.invisibility = 0
						src.copy = null

						if(c_target)
							RemoveState(c_target, a, STATE_REMOVE_REF)
							RemoveState(c_target, b, STATE_REMOVE_REF)
							//J.JutsuCoolDown(src)
						
					else src << output("<Font color=Aqua>You need a target to use this.</Font>","Action.Output")

		Sensatsu_Suisho()
			for(var/obj/Jutsus/Sensatsu_Suishou/J in src.jutsus)
				if(!has_water())
					src<<output("<Font color=Aqua>You need a nearby water source to use this.</Font>","Action.Output")
					return
				var/mob/c_target=src.Target_Get(TARGET_MOB)
				if(!c_target)
					src << output("<Font color=Aqua>You need a target to use this.</Font>","Action.Output")
					return

				if(src.PreJutsu(J))
					if(loc.loc:Safe!=1) src.LevelStat("Ninjutsu",((J.maxcooltime*3/20)*jutsustatexp))
					if(loc.loc:Safe!=1) src.LevelStat("Precision",((J.maxcooltime*3/20)*jutsustatexp))
					if(J.level==1) J.damage=((jutsudamage*J.Sprice)/2)/8
					if(J.level==2) J.damage=((jutsudamage*J.Sprice)/2)/8
					if(J.level==3) J.damage=((jutsudamage*J.Sprice)/1.25)/8
					if(J.level==4) J.damage=(jutsudamage*J.Sprice)/8
					if(J.level<4) if(loc.loc:Safe!=1) J.exp+=jutsumastery*(J.maxcooltime/20); J.Levelup()
					flick("jutsuse",src)
					Bind(src, 3)
					if(c_target)
						sleep(3)
						src.PlayAudio('man_fs_r_mt_con.ogg', output = AUDIO_HEARERS)
						src.PlayAudio('man_fs_r_mt_con.ogg', output = AUDIO_HEARERS)
						src.PlayAudio('man_fs_r_mt_con.ogg', output = AUDIO_HEARERS)
						src.PlayAudio('man_fs_r_mt_con.ogg', output = AUDIO_HEARERS)
						sleep(7)
						if(c_target)
							src.PlayAudio('man_fs_r_mt_wat.ogg', output = AUDIO_HEARERS)
							for(var/i=1,i<8+1,i++)
								var/obj/O = new/obj
								O.IsJutsuEffect=src
								O.animate_movement = SYNC_STEPS
								O.icon = 'Sensastsu Suisho.dmi'
								O.loc = c_target.loc
								O.pixel_x=-32
								O.pixel_y=-32
								switch(i)
									if(1) O.dir = NORTHEAST
									if(2) O.dir = NORTHWEST
									if(3) O.dir = SOUTHEAST
									if(4) O.dir = SOUTHWEST
									if(5) O.dir = NORTH
									if(6) O.dir = EAST
									if(7) O.dir = SOUTH
									if(8) O.dir = WEST
								for(var/x=0,x<3,x++)step(O,O.dir)
								O.pixel_y=16
								O.layer=200
								O.icon_state = "live"
								O.dir = get_dir(O,c_target)
								spawn(10)
									step(O,O.dir)
									for(var/mob/M in O.loc)
										if(M.dead) continue
										AddState(M, new/state/cant_move, 20)
										var/random=rand(1,4)
										if(random==1)  src.PlayAudio('knife_hit1.wav', output = AUDIO_HEARERS)
										if(random==2)  src.PlayAudio('knife_hit2.wav', output = AUDIO_HEARERS)
										if(random==3)  src.PlayAudio('knife_hit3.wav', output = AUDIO_HEARERS)
										if(random==4)  src.PlayAudio('knife_hit4.wav', output = AUDIO_HEARERS)
										M.DealDamage(J.damage+round(((src.ninjutsu_total / 450)+(src.precision_total / 450))*2*J.damage),src,"NinBlue")
										if(M.henge==4||M.henge==5) M.HengeUndo()
										M.Bleed(M)
									spawn(1)
										step(O,O.dir)
										for(var/mob/M in O.loc)
											if(M.dead) continue
											AddState(M, new/state/cant_move, 20)
											var/random=rand(1,4)
											if(random==1)  src.PlayAudio('knife_hit1.wav', output = AUDIO_HEARERS)
											if(random==2)  src.PlayAudio('knife_hit2.wav', output = AUDIO_HEARERS)
											if(random==3)  src.PlayAudio('knife_hit3.wav', output = AUDIO_HEARERS)
											if(random==4)  src.PlayAudio('knife_hit4.wav', output = AUDIO_HEARERS)
											M.DealDamage(J.damage+round(((src.ninjutsu_total / 450)+(src.precision_total / 450))*2*J.damage),src,"NinBlue")
											if(M.henge==4||M.henge==5) M.HengeUndo()
											M.Bleed(M)
										spawn(1)
											step(O,O.dir)
											for(var/mob/M in O.loc)
												if(M.dead) continue
												AddState(M, new/state/cant_move, 20)
												var/random=rand(1,4)
												if(random==1)  src.PlayAudio('knife_hit1.wav', output = AUDIO_HEARERS)
												if(random==2)  src.PlayAudio('knife_hit2.wav', output = AUDIO_HEARERS)
												if(random==3)  src.PlayAudio('knife_hit3.wav', output = AUDIO_HEARERS)
												if(random==4)  src.PlayAudio('knife_hit4.wav', output = AUDIO_HEARERS)
												M.DealDamage(J.damage+round(((src.ninjutsu_total / 450)+(src.precision_total / 450))*2*J.damage),src,"NinBlue")
												if(M.henge==4||M.henge==5) M.HengeUndo()
												M.Bleed(M)
												walk_to(O,M)
												O.icon_state = "stuck"
											spawn(30)if(O)del(O)
						else


							src << output("<Font color=Aqua>You need a target to use this.</Font>","Action.Output")
							return
					else
						src << output("<Font color=Aqua>You need a target to use this.</Font>","Action.Output")
						return


		Iceball()
			for(var/obj/Jutsus/Iceball/J in src.jutsus)
				if(src.PreJutsu(J))
					var/mob/c_target=src.Target_Get(TARGET_MOB)
					if(loc.loc:Safe!=1) src.LevelStat("Ninjutsu",((J.maxcooltime*3/10)*jutsustatexp))
					if(J.level==1) J.damage=((jutsudamage*J.Sprice)/2)/6
					if(J.level==2) J.damage=((jutsudamage*J.Sprice)/2)/6
					if(J.level==3) J.damage=((jutsudamage*J.Sprice)/1.25)/6
					if(J.level==4) J.damage=(jutsudamage*J.Sprice)/6
					if(J.level<4) if(loc.loc:Safe!=1) J.exp+=jutsumastery*(J.maxcooltime/20); J.Levelup()
					spawn() src.UpdateHMB()
					//view()<<"<font size=1><font face=Times New Roman><b><font color=white>[src] Says:<font color=yellow> Fire Release:Fire Ball"
					flick("2fist",src)
					src.PlayAudio('046.wav', output = AUDIO_HEARERS)
					AddState(src, new/state/cant_attack, 5)
					J.uses++
					var/num=5
					if(c_target)
						while(num)
							sleep(2)
							num--
							src.dir=get_dir(src,c_target)
							var/obj/Projectiles/Weaponry/Iceball/A = new/obj/Projectiles/Weaponry/Iceball(src.loc)
							A.IsJutsuEffect=src
							if(prob(50))A.pixel_y+=rand(3,5)
							else A.pixel_y-=rand(1,5)
							if(prob(50))A.pixel_x+=rand(3,8)
							else A.pixel_x-=rand(1,8)
							A.level=J.level
							A.Owner=src
							A.layer=src.layer
							A.fightlayer=src.fightlayer
							A.damage=J.damage+round((src.ninjutsu_total / 200)*2*J.damage)
							walk_towards(A,c_target.loc,0)
							spawn(4)if(A)walk(A,A.dir)
					else
						while(num)
							sleep(2)
							num--
							var/obj/Projectiles/Weaponry/Iceball/A = new/obj/Projectiles/Weaponry/Iceball(src.loc)
							A.IsJutsuEffect=src
							if(prob(50))A.y+=1
							else A.y-=1
							if(prob(50))A.x+=1
							else A.x-=1
							if(A.loc == src.loc)A.loc = get_step(src,src.dir)
							A.level=J.level
							A.Owner=src
							A.layer=src.layer
							A.fightlayer=src.fightlayer
							A.damage=J.damage+round((src.ninjutsu_total / 200)*2*J.damage)
							walk(A,src.dir)

		Omega_Ice_Ball()
			for(var/obj/Jutsus/Omega_Ice_Ball/J in src.jutsus)
				if(src.PreJutsu(J))
					var/mob/c_target=src.Target_Get(TARGET_MOB)
					if(loc.loc:Safe!=1) src.LevelStat("Ninjutsu",rand(1,2))
					if(J.level<4) if(loc.loc:Safe!=1) J.exp+=rand(2,5); J.Levelup()
					src.PlayAudio('man_fs_r_mt_wat.ogg', output = AUDIO_HEARERS)
					Bind(src, 5)
					if(c_target)src.dir=get_dir(src,c_target)
					var/obj/Projectiles/Effects/JinraiBack/Aa=new(get_step(src,src.dir))
					Aa.icon = 'GiantIceBall.dmi'
					Aa.IsJutsuEffect=src
					Aa.dir = src.dir
					Aa.layer = src.layer+1
					Aa.pixel_y=16
					Aa.pixel_x=-16
					var/obj/Projectiles/Effects/JinraiHead/A=new(get_step(src,src.dir))
					A.icon = 'GiantIceBall.dmi'
					A.dir = src.dir
					A.Owner=src
					A.layer=src.layer
					A.fightlayer=src.fightlayer
					A.pixel_y=16
					A.pixel_x=-16
					A.damage=(J.level*100)+round(src.agility_total*1.5)+round(src.ninjutsu_total*2.5)
					A.level=J.level
					walk(A,dir,0)
					icon_state=""
					Aa.dir = src.dir
