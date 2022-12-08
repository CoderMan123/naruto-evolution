mob
	proc
		MizuClone_Jutsu()
			var/mob/c_target=src.Target_Get(TARGET_MOB)
			if(!c_target){src<<output("You need a target to use this jutsu.","Action.Output");return}
			if(clonesturned==1)
				return
			for(var/obj/Jutsus/MizuClone/J in src.jutsus)
				if(src.PreJutsu(J))
					src.CloneHandler()
					src.PlayAudio('flashbang_explode1.wav', output = AUDIO_HEARERS)
					if(src.loc.loc:Safe!=1) src.LevelStat("Ninjutsu",((J.maxcooltime*3/20)*jutsustatexp))
					if(src.loc.loc:Safe!=1) src.LevelStat("Genjutsu",((J.maxcooltime*3/20)*jutsustatexp))
					for(var/mob/M in oview(src,13))
						M.Target_Remove()
					flick("jutsu",src)
					var/mob/Clones/MizuBunshin/A = new/mob/Clones/MizuBunshin(src.loc)
					A.attack_target = c_target
					A.loc=src.loc
					A.Owner=src
					A.taijutsu=round(src.genjutsu_total)
					A.defence=round(src.genjutsu_total)
					A.health=100 + (1000 * ((src.genjutsu_total / 200)*1))
					A.maxhealth=100 + (1000 * ((src.genjutsu_total / 200)*1))
					A.agility=round(src.genjutsu_total)
					A.level = J.level
					var/obj/O=new /obj/Screen/healthbar/
					var/obj/M=new /obj/Screen/manabar/
					A.hbar.Add(O)
					A.hbar.Add(M)
					spawn(3)
						if(A)
							A.icon = src.icon
							A.overlays=src.overlays.Copy()
					A.overlays-=/obj/Screen/healthbar
					A.overlays-=/obj/Screen/manabar
					for(var/obj/Screen/healthbar/HB in A.hbar)A.overlays+=HB
					for(var/obj/Screen/manabar/HB in A.hbar)A.overlays+=HB
					A.UpdateHMB()

		Teppoudama()
			for(var/obj/Jutsus/Teppoudama/J in src.jutsus)
				if(src.PreJutsu(J))
					if(loc.loc:Safe!=1) src.LevelStat("Ninjutsu",((J.maxcooltime*3/10)*jutsustatexp))//XPGAIN
					flick("jutsuse",src)
					Bind(src, 1)
					if(J.level==1) J.damage=((jutsudamage*J.Sprice)/2)
					if(J.level==2) J.damage=((jutsudamage*J.Sprice)/1.5)
					if(J.level==3) J.damage=((jutsudamage*J.Sprice)/1.25)
					if(J.level==4) J.damage=(jutsudamage*J.Sprice)
					if(J.level<4) if(loc.loc:Safe!=1) J.exp+=jutsumastery*(J.maxcooltime/20); J.Levelup()
					var/obj/Teppoudama/A = new/obj/Teppoudama(src.loc)
					A.IsJutsuEffect=src
					A.Owner=src
					A.layer=src.layer
					A.fightlayer=src.fightlayer
					A.damage=1.2*(J.damage+round((src.ninjutsu_total / 200)*2*J.damage))
					A.level=J.level
					walk(A,src.dir,0)

		Suijinheki()
			for(var/obj/Jutsus/Suijinheki/J in src.jutsus)
				if(src.PreJutsu(J))
					if(loc.loc:Safe!=1) src.LevelStat("Ninjutsu",((J.maxcooltime*3/10)*jutsustatexp))
					flick("groundjutsu",src)
					Bind(src, 1)
					if(J.level<4) if(loc.loc:Safe!=1) J.exp+=jutsumastery*(J.maxcooltime/20); J.Levelup()
					var/mob/c_target=src.Target_Get(TARGET_MOB)
					if(c_target)
						src.dir = get_dir(src.loc, c_target.loc)
					var/obj/suijinheki/A = new/obj/suijinheki(src.loc)
					A.IsJutsuEffect=src
					A.Owner=src
					A.layer=src.layer
					A.fightlayer=src.fightlayer
					A.damage=J.damage
					A.level=J.level
					step(A,dir)

		WaterPrison()
			for(var/obj/Jutsus/WaterPrison/J in src.jutsus)
				if(src.PreJutsu(J))
					if(loc.loc:Safe!=1) src.LevelStat("Ninjutsu",((J.maxcooltime*3/10)*jutsustatexp))
					flick("jutsuse",src)
					src.PlayAudio('dash.wav', output = AUDIO_HEARERS)

					var/state/cant_attack/e = new()
					AddState(src, e, -1)

					var/Timer
					if(J.level==1) Timer=2
					if(J.level==2) Timer=4
					if(J.level==3) Timer=7
					if(J.level==4) Timer=10
					if(J.level<4) if(loc.loc:Safe!=1) J.exp+=jutsumastery*(J.maxcooltime/20); J.Levelup()
					var/obj/PrisonOb
					var/mob/c_target=src.Target_Get(TARGET_MOB)
					if(c_target)
						step_towards(src, c_target)
						src.dir = get_dir(src.loc, c_target.loc)
					var/turf/T
					for(var/mob/M in get_step(src,src.dir))
						var/state/cant_attack/a = new()
						var/state/cant_move/b = new()
						if(istype(M)&&!M.dead)
							
							AddState(M, a, -1)
							AddState(M, b, -1)

							var/obj/Jutsu/Effects/WaterPrison/W=new
							W.IsJutsuEffect=src
							W.pixel_x-=45
							W.loc=M.loc
							W.layer=M.layer+2
							icon_state="punchrS"
							PrisonOb=W
							T=src.loc
							while(Timer&&T==src.loc&&M.loc==W.loc&&M)
								Timer--
								sleep(10)

						RemoveState(M, a, STATE_REMOVE_REF)
						RemoveState(M, b, STATE_REMOVE_REF)

						icon_state=""
						if(PrisonOb)del(PrisonOb)
					RemoveState(src, e, STATE_REMOVE_REF)

		WaterShark()
			for(var/obj/Jutsus/WaterShark/J in src.jutsus)
				if(src.PreJutsu(J))
					var/mob/c_target=src.Target_Get(TARGET_MOB)
					if(loc.loc:Safe!=1) src.LevelStat("Ninjutsu",((J.maxcooltime*3/10)*jutsustatexp))
					flick("groundjutsuse",src)
					src.PlayAudio('dash.wav', output = AUDIO_HEARERS)
					AddState(src, new/state/cant_attack, 5)
					if(J.level==1) J.damage=((jutsudamage*J.Sprice)/2)
					if(J.level==2) J.damage=((jutsudamage*J.Sprice)/1.5)
					if(J.level==3) J.damage=((jutsudamage*J.Sprice)/1.25)
					if(J.level==4) J.damage=(jutsudamage*J.Sprice)
					if(J.level<4) if(loc.loc:Safe!=1) J.exp+=jutsumastery*(J.maxcooltime/20); J.Levelup()
					var/num=3
					if(c_target)
						while(num)
							num--
							sleep(2)
							src.dir=get_dir(src,c_target)
							var/obj/Projectiles/Effects/WaterShark/A = new/obj/Projectiles/Effects/WaterShark(src.loc)
							A.IsJutsuEffect=src
							A.pixel_x-=44
							A.dir = src.dir
							if(num==1)
								if(dir==NORTH||dir==SOUTH)A.x--
								A.y--
							if(num==2)
								if(dir==NORTH||dir==SOUTH)A.x++
								A.y++
							if(A.loc == src.loc)A.loc = get_step(src,src.dir)
							A.level=J.level
							A.Owner=src
							A.layer=src.layer
							A.fightlayer=src.fightlayer
							A.damage=0.8*(J.damage+round((src.ninjutsu_total / 200)*2*J.damage))
							walk_towards(A,c_target.loc,0)
							spawn(4)if(A)walk(A,A.dir)
					else
						while(num)
							num--
							sleep(2)
							var/obj/Projectiles/Effects/WaterShark/A = new/obj/Projectiles/Effects/WaterShark(src.loc)
							A.IsJutsuEffect=src
							A.pixel_x-=44
							A.dir  = src.dir
							if(num==1)
								if(dir==NORTH||dir==SOUTH)A.x--
								A.y--
							if(num==2)
								if(dir==NORTH||dir==SOUTH)A.x++
								A.y++
							if(A.loc == src.loc)A.loc = get_step(src,src.dir)
							A.level=J.level
							A.Owner=src
							A.layer=src.layer
							A.fightlayer=src.fightlayer
							A.damage=0.8*(J.damage+round((src.ninjutsu_total / 200)*2*J.damage))
							walk(A,src.dir)

		Water_Dragon_Projectile()
			for(var/obj/Jutsus/Water_Dragon_Projectile/J in src.jutsus)
				if(src.PreJutsu(J))
					var/mob/c_target=src.Target_Get(TARGET_MOB)
					if(loc.loc:Safe!=1) src.LevelStat("Ninjutsu",((J.maxcooltime*3/10)*jutsustatexp))
					if(J.level==1) J.damage=((jutsudamage*J.Sprice)/2)
					if(J.level==2) J.damage=((jutsudamage*J.Sprice)/1.5)
					if(J.level==3) J.damage=((jutsudamage*J.Sprice)/1.25)
					if(J.level==4) J.damage=(jutsudamage*J.Sprice)
					if(J.level<4) if(loc.loc:Safe!=1) J.exp+=jutsumastery*(J.maxcooltime/20); J.Levelup()
					flick("jutsuse",src)
					Bind(src, 5)
					sleep(5)
					flick("2fist",src)
					src.PlayAudio('man_fs_r_mt_wat.ogg', output = AUDIO_HEARERS)
					if(c_target)src.dir=get_dir(src,c_target)
					var/obj/Projectiles/Effects/JinraiBack/Aa=new(get_step(src,src.dir))
					Aa.icon = 'Water Dragon Projectile.dmi'
					Aa.IsJutsuEffect=src
					Aa.dir = src.dir
					Aa.layer = src.layer+1
					Aa.pixel_y=16
					Aa.pixel_x=-16
					var/obj/Projectiles/Effects/JinraiHead/A=new(get_step(src,src.dir))
					A.icon = 'Water Dragon Projectile.dmi'
					A.dir = src.dir
					A.Owner=src
					A.layer=src.layer+2
					A.fightlayer=src.fightlayer
					A.pixel_y=16
					A.pixel_x=-16
					A.damage=0.8*(J.damage+round((src.ninjutsu_total / 200)*2*J.damage))
					A.level=J.level
					walk(A,dir,0)
					icon_state=""
					Aa.dir = src.dir

		Water_Release_Exploding_Water_Colliding_Wave()
			for(var/obj/Jutsus/Water_Release_Exploding_Water_Colliding_Wave/J in src.jutsus)
				if(src.PreJutsu(J))
					if(loc.loc:Safe!=1) src.LevelStat("Ninjutsu",((J.maxcooltime*3/10)*jutsustatexp))
					flick("jutsuse",src)
					src.PlayAudio('man_fs_r_mt_wat.ogg', output = AUDIO_HEARERS)
					Bind(src, 10-(J.level*2))
					if(J.level==1) J.damage=((jutsudamage*J.Sprice)/2)
					if(J.level==2) J.damage=((jutsudamage*J.Sprice)/1.5)
					if(J.level==3) J.damage=((jutsudamage*J.Sprice)/1.25)
					if(J.level==4) J.damage=(jutsudamage*J.Sprice)
					if(J.level<4) if(loc.loc:Safe!=1) J.exp+=jutsumastery*(J.maxcooltime/20); J.Levelup()
					var/obj/O = new/obj
					O.IsJutsuEffect=src
					O.loc = src.loc
					O.icon = 'Wave.dmi'
					O.icon_state = "mid"
					O.name="Wave"
					O.overlays+=image('Wave.dmi',icon_state = "top",pixel_y=32)
					O.overlays+=image('Wave.dmi',icon_state = "bottom",pixel_y=-32)
					O.overlays+=image('Wave.dmi',icon_state = "left",pixel_x=-32)
					O.overlays+=image('Wave.dmi',icon_state = "right",pixel_x=32)
					spawn()
						if(src)
							if(O)O.dir = src.dir
							var/moves=0
							while(moves<>(10+J.level))
								moves+=1
								sleep(0.5)
								if(O) step(O,O.dir)
								if(O)
									var/turf/T = O.loc
									if(T.density)moves=10
									else
										for(var/obj/Projectiles/Effects/OnFire/Fire in O.loc)del(Fire)
										for(var/obj/Projectiles/Effects/Fire/Fire in O.loc)	del(Fire)
										for(var/obj/Projectiles/Effects/MasterFireNoSound/Fire in O.loc)del(Fire)
										for(var/obj/Projectiles/Effects/MasterFire/Fire in O.loc)del(Fire)
										for(var/mob/M in O.loc)
											if(M.dead) continue
											if(M) M.icon_state = "push"
											if(M) step(M,O.dir)
											if(M) M.dir = get_dir(M,O)
											if(M) M.DealDamage(1.5*(J.damage+round((src.ninjutsu_total / 200)*2*J.damage))/10,src,"NinBlue")
											spawn(1)if(M)M.icon_state = ""
										var/obj/W3 = new/obj/watercreate
										W3.IsJutsuEffect=src
										W3.loc=O.loc
										switch(O.dir)
											if(EAST)
												O.pixel_x=32
												var/obj/W = new/obj/watercreate
												W.IsJutsuEffect=src
												W.loc=O.loc
												W.y-=1
												var/obj/W2 = new/obj/watercreate
												W2.IsJutsuEffect=src
												W2.loc=O.loc
												W2.y+=1
											if(WEST)
												O.pixel_x=-32
												var/obj/W = new/obj/watercreate
												W.IsJutsuEffect=src
												W.loc=O.loc
												W.y-=1
												var/obj/W2 = new/obj/watercreate
												W2.IsJutsuEffect=src
												W2.loc=O.loc
												W2.y+=1
											if(NORTH)
												O.pixel_y=32
												var/obj/W = new/obj/watercreate
												W.IsJutsuEffect=src
												W.loc=O.loc
												W.x-=1
												var/obj/W2 = new/obj/watercreate
												W2.IsJutsuEffect=src
												W2.loc=O.loc
												W2.x+=1
											if(SOUTH)
												O.pixel_y=-32
												var/obj/W = new/obj/watercreate
												W.IsJutsuEffect=src
												W.loc=O.loc
												W.x-=1
												var/obj/W2 = new/obj/watercreate
												W2.IsJutsuEffect=src
												W2.loc=O.loc
												W2.x+=1
						if(O)del(O)
