mob
	proc
		Demon_Wind_Shuriken()
			for(var/obj/Jutsus/Demon_Wind_Shuriken/J in src.jutsus)
				if(src.PreJutsu(J))
					if(loc.loc:Safe!=1) src.LevelStat("Ninjutsu",((J.maxcooltime*3/20)*jutsustatexp))
					if(loc.loc:Safe!=1) src.LevelStat("Precision",((J.maxcooltime*3/20)*jutsustatexp))
					if(J.level==1) J.damage=((jutsudamage*J.Sprice)/2)*0.4
					if(J.level==2) J.damage=((jutsudamage*J.Sprice)/1.5)*0.4
					if(J.level==3) J.damage=((jutsudamage*J.Sprice)/1.25)*0.4
					if(J.level==4) J.damage=(jutsudamage*J.Sprice)*0.5
					if(J.level<4) if(loc.loc:Safe!=1) J.exp+=jutsumastery*(J.maxcooltime/20); J.Levelup()
					var/mob/c_target=src.Target_Get(TARGET_MOB)
					flick("throw", src)
					if(c_target)
						src.dir = get_dir(src, c_target)
						var/obj/Projectiles/Effects/DWS/A = new/obj/Projectiles/Effects/DWS(get_step(src, src.dir))
						A.Owner=src
						A.target = c_target
						A.level=J.level
						A.damage=(J.damage+round(((src.precision_total / 450)+(src.ninjutsu_total / 450))*2*J.damage))/2
						var/timer=J.level*4
						while(A && A.hits<=1 && timer > 0)
							timer--
							walk_towards(A, c_target)
							sleep(1)
							walk(A, A.dir)
							sleep(1)
						if(A) walk_towards(A, src)
					else
						var/obj/Projectiles/Effects/DWS/A = new/obj/Projectiles/Effects/DWS(get_step(src, src.dir))
						A.dir=src.dir
						A.Owner=src
						A.level=J.level
						A.damage=(J.damage+round(((src.precision_total / 450)+(src.ninjutsu_total / 450))*2*J.damage))/2
						var/timer=J.level*4
						while(A && A.hits<=1 && timer > 0)
							timer--
							walk(A, A.dir)
							sleep(1)
						if(A) walk_towards(A, src)

		Weapon_Manipulation_Jutsu()
			for(var/obj/Jutsus/Weapon_Manipulation_Jutsu/J in src.jutsus)
				if(src.PreJutsu(J))
					if(loc.loc:Safe!=1) src.LevelStat("Precision",((J.maxcooltime*3/20)*jutsustatexp))
					if(loc.loc:Safe!=1) src.LevelStat("Ninjutsu",((J.maxcooltime*3/20)*jutsustatexp))
					if(J.level==1) J.damage=((jutsudamage*J.Sprice)/2)
					if(J.level==2) J.damage=((jutsudamage*J.Sprice)/1.5)
					if(J.level==3) J.damage=((jutsudamage*J.Sprice)/1.25)
					if(J.level==4) J.damage=(jutsudamage*J.Sprice)
					if(J.level<4) if(loc.loc:Safe!=1) J.exp+=jutsumastery*(J.maxcooltime/20); J.Levelup()
					var/mob/c_target=src.Target_Get(TARGET_MOB)
					J.damage = (J.damage+round(((src.precision_total / 450)+(src.ninjutsu_total / 450))*2*J.damage))/6
					flick("2fist",src)
					src.PlayAudio('dash.wav', output = AUDIO_HEARERS)

					var/state/cant_attack/e = new()
					AddState(src, e, -1)

					var/num=round(J.level*1.5)
					if(c_target)
						while(num)
							sleep(1)
							num--
							src.dir=get_dir(src,c_target)
							if(prob(50))
								var/obj/Projectiles/Effects/Maniper2/A = new/obj/Projectiles/Effects/Maniper2(src.loc)
								A.IsJutsuEffect=src
								A.x+=rand(-1,1)
								A.y+=rand(-1,1)
								A.level=J.level
								A.Owner=src
								A.layer=src.layer
								A.fightlayer=src.fightlayer
								A.damage=J.damage
								A.density=0
								spawn(1)if(A)A.density=1
								walk_towards(A,c_target,0)
								spawn(7)if(A)walk(A,A.dir)
							else
								var/obj/Projectiles/Effects/Maniper3/A = new/obj/Projectiles/Effects/Maniper3(src.loc)
								A.IsJutsuEffect=src
								A.x+=rand(-1,1)
								A.y+=rand(-1,1)
								A.level=J.level
								A.Owner=src
								A.layer=src.layer
								A.fightlayer=src.fightlayer
								A.damage=J.damage
								A.density=0
								spawn(1)if(A)A.density=1
								walk_towards(A,c_target,0)
								spawn(7)if(A)walk(A,A.dir)
					else
						while(num)
							sleep(1)
							num--
							if(prob(50))
								var/obj/Projectiles/Effects/Maniper2/A = new/obj/Projectiles/Effects/Maniper2(src.loc)
								A.IsJutsuEffect=src
								A.x+=rand(-1,1)
								A.y+=rand(-1,1)
								if(A.loc == src.loc)A.loc = get_step(src,src.dir)
								A.level=J.level
								A.Owner=src
								A.layer=src.layer
								A.fightlayer=src.fightlayer
								A.damage=J.damage+round(src.ninjutsu_total+src.taijutsu_total)
								A.density=0
								spawn(1) if(A) A.density=1
								walk(A,src.dir)
							else
								var/obj/Projectiles/Effects/Maniper3/A = new/obj/Projectiles/Effects/Maniper3(src.loc)
								A.IsJutsuEffect=src
								A.x+=rand(-1,1)
								A.y+=rand(-1,1)
								if(A.loc == src.loc)A.loc = get_step(src,src.dir)
								A.level=J.level
								A.Owner=src
								A.layer=src.layer
								A.fightlayer=src.fightlayer
								A.damage=J.damage+round(src.ninjutsu_total+src.taijutsu_total)
								A.density=0
								spawn(1) if(A) A.density=1
								walk(A,src.dir)
					RemoveState(src, e, STATE_REMOVE_REF)

		Blade_Hurricane()//spiral jutsu
			for(var/obj/Jutsus/Blade_Hurricane/J in src.jutsus)
				if(src.PreJutsu(J))
					if(loc.loc:Safe!=1) src.LevelStat("Precision",((J.maxcooltime*3/20)*jutsustatexp))
					if(loc.loc:Safe!=1) src.LevelStat("Ninjutsu",((J.maxcooltime*3/20)*jutsustatexp))
					if(J.level==1) J.damage=0.7*((jutsudamage*J.Sprice)/2)
					if(J.level==2) J.damage=0.7*((jutsudamage*J.Sprice)/1.5)
					if(J.level==3) J.damage=0.7*((jutsudamage*J.Sprice)/1.25)
					if(J.level==4) J.damage=0.7*(jutsudamage*J.Sprice)
					if(J.level<4) if(loc.loc:Safe!=1) J.exp+=jutsumastery*(J.maxcooltime/20); J.Levelup()
					for(var/s=0,s<(5*J.level),s++)
						if(prob(25))
							step(src,src.dir)
						switch(src.dir)
							if(WEST) src.dir=NORTHWEST
							if(SOUTH) src.dir=SOUTHWEST
							if(EAST) src.dir=SOUTHEAST
							if(NORTH) src.dir=NORTHEAST
							if(NORTHWEST) src.dir=NORTH
							if(SOUTHWEST) src.dir=WEST
							if(SOUTHEAST) src.dir=SOUTH
							if(NORTHEAST) src.dir=EAST
						if(prob(25*J.level))
							var/obj/Projectiles/Effects/Windmill/A = new/obj/Projectiles/Effects/RTD(get_step(src, src.dir))
							A.Owner=src
							A.damage=J.damage+round(((src.precision_total / 450)+(src.ninjutsu_total / 450))*2*J.damage)/3
							A.icon = 'risingdragonprojectiles.dmi'
							A.icon_state="[rand(1,4)]"
							step(A, src.dir)
							walk_away(A,src)
							walk(A,A.dir)
							sleep(0.1)
							flick("throw",src)
							sleep(0.1)
							flick("punchl",src)

		Rising_Dragon()
			for(var/obj/Jutsus/Rising_Dragon/J in src.jutsus)
				if(src.PreJutsu(J))
					if(loc.loc:Safe!=1) src.LevelStat("Precision",((J.maxcooltime*3/20)*jutsustatexp))
					if(loc.loc:Safe!=1) src.LevelStat("Ninjutsu",((J.maxcooltime*3/20)*jutsustatexp))
					if(J.level==1) J.damage=((jutsudamage*J.Sprice)/2)
					if(J.level==2) J.damage=((jutsudamage*J.Sprice)/1.5)
					if(J.level==3) J.damage=((jutsudamage*J.Sprice)/1.25)
					if(J.level==4) J.damage=(jutsudamage*J.Sprice)
					if(J.level<4) if(loc.loc:Safe!=1) J.exp+=jutsumastery*(J.maxcooltime/20); J.Levelup()
					J.damage = J.damage/10
					src.PlayAudio('wirlwind.wav', output = AUDIO_HEARERS)
					//var/turf/T=src.loc
					var/p_x = src.x
					var/p_y = src.y
					var/p_z = src.z
					var/mob/c_target=src.Target_Get(TARGET_MOB)

					var/state/cant_attack/e = new()
					AddState(src, e, -1)

					var/state/cant_move/f = new()
					AddState(src, f, -1)

					var/matrix/m = matrix()
					m.Translate(-16,-4)
					var/obj/Ov = new/obj(usr.loc)
					Ov.icon='risingdragon.dmi'
					Ov.icon_state="overlay"
					Ov.layer=MOB_LAYER+1
					Ov.transform = m
					Ov.linkfollow(src)
					var/obj/Un = new/obj(usr.loc)
					Un.icon='risingdragon.dmi'
					Un.icon_state="underlay"
					Un.layer=MOB_LAYER-1
					Un.transform = m
					Un.linkfollow(src)
					var/timer = J.level*5
					var/spawn_loc = 1
					var/spawn_loc_inverse = 0
					while(timer>=1)
						if(c_target)
							src.dir=get_dir(src, c_target)
						if(/*src.loc!=T*/src.x != p_x || src.y != p_y || src.z != p_z)
							RemoveState(src, e, STATE_REMOVE_REF)
							RemoveState(src, f, STATE_REMOVE_REF)
							del Ov
							del Un
							return
						if(prob(50)) src.PlayAudio('SkillDam_ThrowSuriken3.wav', output = AUDIO_HEARERS)
						else src.PlayAudio('SkillDam_ThrowSuriken2.wav', output = AUDIO_HEARERS)
						switch(spawn_loc)
							if(1)
								spawn_loc = 2
							if(2)
								if(!spawn_loc_inverse)
									spawn_loc_inverse = 1
									spawn_loc = 3
								else
									spawn_loc = 1
									spawn_loc_inverse = 0
							if(3)
								spawn_loc = 2

						flick("throw",src)
						sleep(0.05)
						flick("punchl",src)
						sleep(0.05)
						timer--
						var/obj/Projectiles/Effects/Windmill/A = new/obj/Projectiles/Effects/RTD(src.loc)
						A.Owner=src
						A.damage=J.damage+round(((src.precision_total / 450)+(src.ninjutsu_total / 450))*2*J.damage)
						switch(src.dir)
							if(NORTH)
								switch(spawn_loc)
									if(1) A.x--
									if(3) A.x++
							if(EAST)
								switch(spawn_loc)
									if(1) A.y++
									if(3) A.y--
							if(SOUTH)
								switch(spawn_loc)
									if(1) A.x++
									if(3) A.x--
							if(WEST)
								switch(spawn_loc)
									if(1) A.y--
									if(3) A.y++
							if(NORTHEAST)
								switch(spawn_loc)
									if(1) A.y++
									if(3) A.x++
							if(SOUTHEAST)
								switch(spawn_loc)
									if(1) A.x++
									if(3) A.y--
							if(NORTHWEST)
								switch(spawn_loc)
									if(1)
										A.x--
									if(3) A.y++
							if(SOUTHWEST)
								switch(spawn_loc)
									if(1) A.y--
									if(3) A.x--
						A.icon = 'risingdragonprojectiles.dmi'
						A.icon_state="[rand(1,4)]"
						step(A, src.dir)
						if(A) walk_away(A,src)
						if(A) walk(A,A.dir)
					RemoveState(src, e, STATE_REMOVE_REF)
					RemoveState(src, f, STATE_REMOVE_REF)
					del Ov
					del Un

//----------------------------------------------------------------------------------------------------------------------------

		Blade_Manipulation_Jutsu()
			for(var/obj/Jutsus/Blade_Manipulation_Jutsu/J in src.jutsus)
				if(src.PreJutsu(J))
					if(loc.loc:Safe!=1) src.LevelStat("Ninjutsu",rand(2,4))
					var/mob/c_target=src.Target_Get(TARGET_MOB)
					flick("2fist",src)
					src.PlayAudio('dash.wav', output = AUDIO_HEARERS)
					
					var/state/cant_attack/e = new()
					AddState(src, e, -1)

					if(J.level==1) J.damage=4
					if(J.level==2) J.damage=5
					if(J.level==3) J.damage=6
					if(J.level==4) J.damage=7
					if(J.level<4) if(loc.loc:Safe!=1) J.exp+=rand(2,5); J.Levelup()
					var/num=round(J.level*1.5)
					if(c_target)
						while(num)
							sleep(1)
							num--
							src.dir=get_dir(src,c_target)
							var/obj/Projectiles/Effects/Maniper/A = new/obj/Projectiles/Effects/Maniper(src.loc)
							A.IsJutsuEffect=src
							A.x+=rand(-1,1)
							A.y+=rand(-1,1)
							A.level=J.level
							A.Owner=src
							A.layer=src.layer
							A.fightlayer=src.fightlayer
							A.damage=J.damage+round(src.ninjutsu_total/5+src.taijutsu_total/10)
							A.density=0
							spawn(1)if(A)A.density=1
							walk_towards(A,c_target,0)
							spawn(7)if(A)walk(A,A.dir)
					else
						while(num)
							sleep(1)
							num--
							var/obj/Projectiles/Effects/Maniper/A = new/obj/Projectiles/Effects/Maniper(src.loc)
							A.IsJutsuEffect=src
							A.x+=rand(-1,1)
							A.y+=rand(-1,1)
							if(A.loc == src.loc)A.loc = get_step(src,src.dir)
							A.level=J.level
							A.Owner=src
							A.layer=src.layer
							A.fightlayer=src.fightlayer
							A.damage=J.damage+round(src.ninjutsu_total/5+src.taijutsu_total/10)
							A.density=0
							spawn(1) if(A) A.density=1
							walk(A,src.dir)
					RemoveState(src, e, STATE_REMOVE_REF)

		TwinDragons()
			for(var/obj/Jutsus/TwinDragons/J in src.jutsus)
				if(src.PreJutsu(J))
					if(loc.loc:Safe!=1) src.LevelStat("Ninjutsu",rand(7,11))
					var/mob/c_target=src.Target_Get(TARGET_MOB)
					flick("jutsuse",src)
					src.PlayAudio('dash.wav', output = AUDIO_HEARERS)
					if(J.level==1) J.damage=4
					if(J.level==2) J.damage=5
					if(J.level==3) J.damage=6
					if(J.level==4) J.damage=7
					if(J.level<4) if(loc.loc:Safe!=1) J.exp+=rand(2,5); J.Levelup()
					var/num=round(J.level*3)
					if(c_target)
						while(num)
							sleep(1)
							num--
							src.dir=get_dir(src,c_target)
							if(prob(50))
								var/obj/Projectiles/Effects/Maniper2/A = new/obj/Projectiles/Effects/Maniper2(src.loc)
								A.IsJutsuEffect=src
								A.x+=rand(-1,1)
								A.y+=rand(-1,1)
								A.level=J.level
								A.Owner=src
								A.layer=src.layer
								A.fightlayer=src.fightlayer
								A.damage=J.damage+round(src.ninjutsu_total*2+src.taijutsu_total*2)
								A.density=0
								spawn(1)if(A)A.density=1
								spawn(1)if(A)walk_rand(A)
								spawn(4)
									walk_towards(A,c_target.loc)
							else
								var/obj/Projectiles/Effects/Maniper3/A = new/obj/Projectiles/Effects/Maniper3(src.loc)
								A.IsJutsuEffect=src
								A.x+=rand(-1,1)
								A.y+=rand(-1,1)
								A.level=J.level
								A.Owner=src
								A.layer=src.layer
								A.fightlayer=src.fightlayer
								A.damage=J.damage+round(src.ninjutsu_total*2+src.taijutsu_total*2)
								A.density=0
								spawn(1)if(A)A.density=1
								spawn(1)if(A)walk_rand(A)
								spawn(4)
									walk_towards(A,c_target.loc)
					else
						while(num)
							sleep(1)
							num--
							if(prob(50))
								var/obj/Projectiles/Effects/Maniper2/A = new/obj/Projectiles/Effects/Maniper2(src.loc)
								A.IsJutsuEffect=src
								A.x+=rand(-1,1)
								A.y+=rand(-1,1)
								if(A.loc == src.loc)A.loc = get_step(src,src.dir)
								A.level=J.level
								A.Owner=src
								A.layer=src.layer
								A.fightlayer=src.fightlayer
								A.damage=J.damage+round(src.ninjutsu_total*2+src.taijutsu_total*2)
								A.density=0
								spawn(1) if(A) A.density=1
								walk_rand(A)
								spawn(10)
									del(A)
							else
								var/obj/Projectiles/Effects/Maniper3/A = new/obj/Projectiles/Effects/Maniper3(src.loc)
								A.IsJutsuEffect=src
								A.x+=rand(-1,1)
								A.y+=rand(-1,1)
								if(A.loc == src.loc)A.loc = get_step(src,src.dir)
								A.level=J.level
								A.Owner=src
								A.layer=src.layer
								A.fightlayer=src.fightlayer
								A.damage=J.damage+round(src.ninjutsu_total*2+src.taijutsu_total*2)
								A.density=0
								spawn(1) if(A) A.density=1
								walk_rand(A)
								spawn(10)
									del(A)
