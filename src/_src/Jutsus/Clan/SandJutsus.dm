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

					if(loc.loc:Safe!=1) src.LevelStat("Ninjutsu",rand(11,15))
					flick("punchrS",src)
					view(src)<<sound('wind_leaves.ogg',0,0)
					src.firing=1
					src.canattack=0
					src.injutsu=1
					src.move=0
					var/TimeAsleep
					if(J.level==1)TimeAsleep=25
					if(J.level==2)TimeAsleep=50
					if(J.level==3)TimeAsleep=75
					if(J.level==4)TimeAsleep=100
					if(J.level<4) if(loc.loc:Safe!=1) J.exp+=rand(2,5); J.Levelup()
					var/mob/M = c_target
					if(M)
						var/turf/T=M.loc
						spawn(10)
							if(M&&T)
								if(T==M.loc)
									var/obj/O = new/obj/Jutsus/Effects/desertcoffin(M.loc)
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

					if(loc.loc:Safe!=1) src.LevelStat("Ninjutsu",rand(8,12))
					if(J.level<4)
						if(loc.loc:Safe!=1)
							J.exp+=rand(2,5)
							J.Levelup()
					flick("groundjutsu",src)
					if(c_target)
						for(var/obj/Jutsus/Effects/desertcoffin/O in c_target.loc)
							view(src)<<sound('knife_hit3.wav',0,0)
							O.icon = 'Sand Funeral.dmi'
							flick("stab",O)
							O.icon_state = "blood"
							c_target.DealDamage((J.level*50)+src.ninjutsu*5,src,"NinBlue")

		Sand_Shield()
			for(var/obj/Jutsus/Sand_Shield/J in src.jutsus)
				if(src.PreJutsu(J))
					if(loc.loc:Safe!=1) src.LevelStat("Ninjutsu",rand(3,5))
					if(J.level<4)
						if(loc.loc:Safe!=1)
							J.exp+=rand(2,5)
							J.Levelup()
					flick("jutsuse",src)
					view(src)<<sound('dash.wav',0,0)
					src.shielded=1
					src.firing=1
					src.move=0
					src.injutsu=1
					var/obj/O = new/obj
					O.loc = src.loc
					O.icon = 'Sand Shield.dmi'
					O.icon_state = "stay"
					O.pixel_x=-32
					O.pixel_y=-8
					O.layer=10
					flick("form",O)
					var/X = J.level*100
					var/Z = src.health
					while(X && src)
						sleep(1)
						src.health = Z
						src.shielded=1
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
					if(loc.loc:Safe!=1) src.LevelStat("Ninjutsu",rand(3,7))
					flick("throw",src)
					view(src)<<sound('Skill_MashHit.wav',0,0)
					if(J.level==1) J.damage=2
					if(J.level==2) J.damage=4
					if(J.level==3) J.damage=6
					if(J.level==4) J.damage=7
					if(J.level<4) if(loc.loc:Safe!=1) J.exp+=rand(2,5); J.Levelup()
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
							A.damage=J.damage+round(src.ninjutsu*0.2+src.strength*0.2)
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
								A.damage=J.damage+round(src.ninjutsu*0.8+src.strength*0.8)
							spawn() walk(A,src.dir)
					src.firing=0
					src.canattack=1

		Shukakku_Spear()
			for(var/obj/Jutsus/Shukakku_Spear/J in src.jutsus)
				if(src.PreJutsu(J))
					var/mob/c_target=src.Target_Get(TARGET_MOB)
					if(loc.loc:Safe!=1) src.LevelStat("Ninjutsu",rand(5,7))
					flick("punchl",src)
					view(src)<<sound('Skill_MashHit.wav',0,0)
					src.firing=1
					src.canattack=0
					if(J.level==1) J.damage=15
					if(J.level==2) J.damage=20
					if(J.level==3) J.damage=25
					if(J.level==4) J.damage=30
					if(J.level<4) if(loc.loc:Safe!=1) J.exp+=rand(5,15); J.Levelup()
					if(c_target)
						src.dir=get_dir(src,c_target)
						var/obj/Projectiles/Effects/Shukakku_Spear/A = new/obj/Projectiles/Effects/Shukakku_Spear(src.loc)
						A.IsJutsuEffect=src
						A.Owner=src
						A.layer=src.layer
						A.fightlayer=src.fightlayer
						A.damage=J.damage+round(src.ninjutsu*2)
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
						A.damage=J.damage+round(src.ninjutsu*2)
						A.level=J.level
						walk(A,src.dir)
					spawn(10)if(src)
						src.firing=0
						src.canattack=1
