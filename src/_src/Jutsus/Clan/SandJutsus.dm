mob
	proc

		Desert_Coffin()
			for(var/obj/Jutsus/Desert_Coffin/J in src.jutsus)
				var/mob/c_target=src.Target_Get(TARGET_MOB)
				if(!c_target)
					src << output("This jutsu requires a target","Action.Output")
					return
				if(src.PreJutsu(J))
					J.density = 1
					if(loc.loc:Safe!=1) src.LevelStat("Ninjutsu",((J.maxcooltime*3/10)*jutsustatexp))
					flick("punchrS",src)
					src.PlayAudio('wind_leaves.ogg', output = AUDIO_HEARERS)
					src.firing=1
					src.canattack=0
					src.injutsu=1
					src.move=0
					var/TimeAsleep
					if(J.level==1)TimeAsleep=20
					if(J.level==2)TimeAsleep=30
					if(J.level==3)TimeAsleep=40
					if(J.level==4)TimeAsleep=50
					if(J.level<4) if(loc.loc:Safe!=1) J.exp+=jutsumastery*(J.maxcooltime/20); J.Levelup()
					var/mob/M = c_target
					var/obj/A = new/obj(M.loc)
					A.icon='sandfuneralbuild.dmi'
					A.layer=MOB_LAYER+1
					var/matrix/m = matrix()
					m.Translate(-32,-18)
					A.transform = m
					A.linkfollow(M)
					spawn(10)
						M=src.Target_Get(TARGET_MOB)
						if(M)
							var/obj/O = new/obj/Jutsus/Effects/desertcoffin(M.loc)
							var/matrix/m2 = matrix()
							m2.Translate(-1,-3)
							O.transform = m2
							M.icon_state=""
							M.move=0
							M.dir = SOUTH
							M.injutsu=1
							M.Sleeping=1
							M.canattack=0
							spawn(TimeAsleep)
								if(!M||M.dead)continue
								M.Sleeping=0
								M.icon_state=""
								M.move=1
								M.injutsu=0
								M.canattack=1
								if(O)del(O)
						else src<<output("The jutsu did not connect.","Action.Output")
						if(A) del(A)
					src.firing=0
					src.canattack=1
					src.injutsu=0
					src.move=1

		Sand_Funeral()
			for(var/obj/Jutsus/Sand_Funeral/J in src.jutsus)
				var/mob/c_target=src.Target_Get(TARGET_MOB)
				if(!c_target)
					src << output("This jutsu requires a target.","Action.Output")
					return
				if(src.PreJutsu(J))
					if(loc.loc:Safe!=1) src.LevelStat("Ninjutsu",((J.maxcooltime*3/10)*jutsustatexp))
					if(J.level==1) J.damage=((jutsudamage*J.Sprice)/2.5)*0.7
					if(J.level==2) J.damage=((jutsudamage*J.Sprice)/2)*0.7
					if(J.level==3) J.damage=((jutsudamage*J.Sprice)/1.5)*0.7
					if(J.level==4) J.damage=(jutsudamage*J.Sprice)*0.7
					if(J.level<4) if(loc.loc:Safe!=1) J.exp+=jutsumastery*(J.maxcooltime/20); J.Levelup()
					flick("groundjutsu",src)
					if(c_target)
						for(var/obj/Jutsus/Effects/desertcoffin/O in c_target.loc)
							src.PlayAudio('knife_hit3.wav', output = AUDIO_HEARERS)
							O.icon = 'Sand Funeral.dmi'
							flick("stab",O)
							O.icon_state = "blood"
							c_target.DealDamage(J.damage+round((src.ninjutsu / 150)*2*J.damage),src,"NinBlue")

		Sand_Shield()
			for(var/obj/Jutsus/Sand_Shield/J in src.jutsus)
				if(src.PreJutsu(J))
					if(loc.loc:Safe!=1) src.LevelStat("Ninjutsu",((J.maxcooltime*3/10)*jutsustatexp))
					if(loc.loc:Safe!=1) src.LevelStat("Defence",((J.maxcooltime*3/10)*jutsustatexp))
					if(J.level<4) if(loc.loc:Safe!=1) J.exp+=jutsumastery*(J.maxcooltime/20); J.Levelup()
					flick("jutsuse",src)
					src.PlayAudio('dash.wav', output = AUDIO_HEARERS)
					src.shielded=1
					src.firing=1
					src.move=0
					src.injutsu=1
					var/obj/O = new/obj
					O.loc = src.loc
					O.icon = 'Sand Shield.dmi'
					O.icon_state = "stay"
					O.pixel_x=-33
					O.pixel_y=-8
					O.layer=10
					flick("form",O)
					var/X = J.level*40
					var/Z = src.health
					while(X && src)
						sleep(0.4)
						src.health = Z
						src.shielded=1
						src.loc = O.loc
						X--
					if(src)
						if(O)del(O)
						src.firing=0
						src.move=1
						src.injutsu=0
						src.shielded=0
					else if(O)del(O)

		Sand_Shuriken()
			for(var/obj/Jutsus/Sand_Shuriken/J in src.jutsus)
				if(src.PreJutsu(J))
					if(!canattack)return
					canattack=0
					var/mob/c_target=src.Target_Get(TARGET_MOB)
					if(loc.loc:Safe!=1) src.LevelStat("Ninjutsu",((J.maxcooltime*3/20)*jutsustatexp))
					if(loc.loc:Safe!=1) src.LevelStat("Precision",((J.maxcooltime*3/20)*jutsustatexp))
					flick("throw",src)
					src.PlayAudio('Skill_MashHit.wav', output = AUDIO_HEARERS)
					if(J.level==1) J.damage=((jutsudamage*J.Sprice)/2.5)/4
					if(J.level==2) J.damage=((jutsudamage*J.Sprice)/2)/4
					if(J.level==3) J.damage=((jutsudamage*J.Sprice)/1.5)/4
					if(J.level==4) J.damage=(jutsudamage*J.Sprice)/4
					if(J.level<4) if(loc.loc:Safe!=1) J.exp+=jutsumastery*(J.maxcooltime/20); J.Levelup()
					var/num=5
					if(c_target)
						while(num)
							sleep(1)
							src.dir=get_dir(src,c_target)
							var/obj/Projectiles/Effects/Sand_Shuriken/A = new/obj/Projectiles/Effects/Sand_Shuriken(src.loc)
							A.IsJutsuEffect=src
							A.density=0
							switch(num)
								if(5)
									switch(src.dir)
										if(EAST)A.x+=1
										if(WEST)A.x-=1
										if(NORTH)A.y+=1
										if(SOUTH)A.y-=1
								if(4)
									switch(src.dir)
										if(EAST)
											A.y+=1
											A.x+=1
										if(WEST)
											A.y+=1
											A.x-=1
										if(NORTH)
											A.x+=1
											A.y+=1
										if(SOUTH)
											A.x+=1
											A.y-=1
								if(3)
									switch(src.dir)
										if(EAST)
											A.y+=2
											A.x+=1
										if(WEST)
											A.y+=2
											A.x-=1
										if(NORTH)
											A.x+=2
											A.y+=1
										if(SOUTH)
											A.x+=2
											A.y-=1
								if(2)
									switch(src.dir)
										if(EAST)
											A.y-=1
											A.x+=1
										if(WEST)
											A.y-=1
											A.x-=1
										if(NORTH)
											A.x-=1
											A.y+=1
										if(SOUTH)
											A.x-=1
											A.y-=1
								if(1)
									switch(src.dir)
										if(EAST)
											A.y-=2
											A.x+=1
										if(WEST)
											A.y-=2
											A.x-=1
										if(NORTH)
											A.x-=2
											A.y+=1
										if(SOUTH)
											A.x-=2
											A.y-=1
							A.level=J.level
							A.Owner=src
							A.layer=src.layer
							A.fightlayer=src.fightlayer
							A.damage=J.damage+round(((src.ninjutsu / 300)+(src.precision / 300))*2*J.damage)
							var/turf/Tg
							Tg = get_step(c_target,pick(NORTH,SOUTH,EAST,WEST))
							var/k = rand(1,5)
							spawn() switch(k)
								if(1)
									spawn(1) A.density=1
									walk_towards(A,c_target.loc,0)
								else
									spawn(1) A.density=1
									walk_towards(A,Tg,0)
							spawn(4)
								spawn(1) if(A) A.density=1
								if(A) walk(A,A.dir)
							num--
					else
						while(num)
							sleep(1)
							num--
							var/obj/Projectiles/Effects/Sand_Shuriken/A = new/obj/Projectiles/Effects/Sand_Shuriken(src.loc)
							A.IsJutsuEffect=src
							switch(num)
								if(5)
									switch(src.dir)
										if(EAST)A.x+=1
										if(WEST)A.x-=1
										if(NORTH)A.y+=1
										if(SOUTH)A.y-=1
								if(4)
									switch(src.dir)
										if(EAST)
											A.y+=1
											A.x+=1
										if(WEST)
											A.y+=1
											A.x-=1
										if(NORTH)
											A.x+=1
											A.y+=1
										if(SOUTH)
											A.x+=1
											A.y-=1
								if(3)
									switch(src.dir)
										if(EAST)
											A.y+=2
											A.x+=1
										if(WEST)
											A.y+=2
											A.x-=1
										if(NORTH)
											A.x+=2
											A.y+=1
										if(SOUTH)
											A.x+=2
											A.y-=1
								if(2)
									switch(src.dir)
										if(EAST)
											A.y-=1
											A.x+=1
										if(WEST)
											A.y-=1
											A.x-=1
										if(NORTH)
											A.x-=1
											A.y+=1
										if(SOUTH)
											A.x-=1
											A.y-=1
								if(1)
									switch(src.dir)
										if(EAST)
											A.y-=2
											A.x+=1
										if(WEST)
											A.y-=2
											A.x-=1
										if(NORTH)
											A.x-=2
											A.y+=1
										if(SOUTH)
											A.x-=2
											A.y-=1
							step(A,A.dir)
							if(A)
								A.level=J.level
								A.Owner=src
								A.layer=src.layer
								A.fightlayer=src.fightlayer
								A.damage=J.damage+round(((src.ninjutsu / 300)+(src.precision / 300))*2*J.damage)
							spawn() walk(A,src.dir)
					src.firing=0
					src.canattack=1

		Shukakku_Spear()
			for(var/obj/Jutsus/Shukakku_Spear/J in src.jutsus)
				if(src.PreJutsu(J))
					var/mob/c_target=src.Target_Get(TARGET_MOB)
					if(loc.loc:Safe!=1) src.LevelStat("Ninjutsu",((J.maxcooltime*3/20)*jutsustatexp))
					if(loc.loc:Safe!=1) src.LevelStat("Precision",((J.maxcooltime*3/20)*jutsustatexp))
					flick("punchl",src)
					src.PlayAudio('Skill_MashHit.wav', output = AUDIO_HEARERS)
					src.firing=1
					src.canattack=0
					if(J.level==1) J.damage=((jutsudamage*J.Sprice)/2.5)*0.8
					if(J.level==2) J.damage=((jutsudamage*J.Sprice)/2)*0.8
					if(J.level==3) J.damage=((jutsudamage*J.Sprice)/1.5)*0.8
					if(J.level==4) J.damage=(jutsudamage*J.Sprice)*0.8
					if(J.level<4) if(loc.loc:Safe!=1) J.exp+=jutsumastery*(J.maxcooltime/20); J.Levelup()
					if(c_target)
						src.dir=get_dir(src,c_target)
						var/obj/Projectiles/Effects/Shukakku_Spear/A = new/obj/Projectiles/Effects/Shukakku_Spear(src.loc)
						A.IsJutsuEffect=src
						A.Owner=src
						A.layer=src.layer
						A.fightlayer=src.fightlayer
						A.damage=J.damage+round(((src.ninjutsu / 300)+(src.precision / 300))*2*J.damage)
						A.level=J.level
						walk_towards(A,c_target.loc,0)
						spawn(4)
						if(A)  walk(A,A.dir)
					else
						var/obj/Projectiles/Effects/Shukakku_Spear/A = new/obj/Projectiles/Effects/Shukakku_Spear(src.loc)
						A.IsJutsuEffect=src
						A.Owner=src
						A.layer=src.layer
						A.fightlayer=src.fightlayer
						A.damage=J.damage+round(((src.ninjutsu / 300)+(src.precision / 300))*2*J.damage)
						A.level=J.level
						walk(A,src.dir)
					spawn(10)if(src)
						src.firing=0
						src.canattack=1
