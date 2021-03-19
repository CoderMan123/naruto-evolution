mob
	proc
		Chidori_Jinrai()
			for(var/obj/Jutsus/Jinrai/J in src.JutsusLearnt)
				if(src.PreJutsu(J))
					var/mob/c_target=src.Target_Get(TARGET_MOB)
					if(loc.loc:Safe!=1) src.LevelStat("Ninjutsu",rand(2,3))
					if(J.level<4) if(loc.loc:Safe!=1) J.exp+=rand(2,5); J.Levelup()
					icon_state="jutsuuse"
					view()<<sound('Beam.ogg')
					src.firing=1
					src.canattack=0
					src.move=0
					if(c_target)src.dir=get_dir(src,c_target)
					var/obj/Projectiles/Effects/JinraiBack/Aa=new(src.loc)
					Aa.IsJutsuEffect=src
					Aa.dir = src.dir
					Aa.pixel_y=32
					Aa.layer = src.layer+1
					var/obj/Projectiles/Effects/JinraiHead/A=new(src.loc)
					A.dir = src.dir
					A.Owner=src
					A.layer=src.layer
					A.fightlayer=src.fightlayer
					A.damage=(J.level*10)+round(src.ninjutsu*2)
					A.level=J.level
					walk(A,dir,0)
					src.firing=0
					src.canattack=1
					src.move=1
					icon_state=""
					Aa.dir = src.dir
					spawn(15)
						src.firing=0
						src.canattack=1

		Kirin()
			for(var/obj/Jutsus/Kirin/J in src.JutsusLearnt)
				var/mob/c_target=src.Target_Get(TARGET_MOB)
				if(!c_target)
					src<<output("You must have a target to use this technique.","ActionPanel.Output")
					return
				if(src.PreJutsu(J))
					if(loc.loc:Safe!=1) src.LevelStat("Ninjutsu",rand(7,11))
					icon_state="jutsuuse"
					view()<<sound('Thunder.ogg')
					src.firing=1
					src.canattack=0
					src.move=0
					if(J.level==1) J.damage=120
					if(J.level==2) J.damage=140
					if(J.level==3) J.damage=160
					if(J.level==4) J.damage=180
					if(J.level<4) if(loc.loc:Safe!=1) J.exp+=rand(2,5); J.Levelup()
					var/Jutsu=4
					J.damage+=round(src.ninjutsu*6.5)
					var/Damage=J.damage/Jutsu
					if(c_target)
						c_target.injutsu=1
						c_target.move=0
						if(J.level==4)
							var/obj/Z=new
							Z.IsJutsuEffect=src
							Z.layer=MOB_LAYER+101
							Z.loc=c_target.loc
							Z.icon='Lightning God.dmi'
							Z.pixel_x-=85
							Z.pixel_y+=170
							spawn(24) del(Z)
						var/obj/O=new
						O.IsJutsuEffect=src
						O.layer=MOB_LAYER+100
						O.loc=c_target.loc
						O.icon='Kirin.dmi'
						O.pixel_x-=85
						O.pixel_y+=80
						while(Jutsu&&c_target)
							Jutsu--
							c_target.DealDamage(Damage,src,"NinBlue")
							sleep(6)
						del(O)
						if(c_target)
							c_target.move=1
							c_target.injutsu=0
						move=1
						canattack=1
						firing=0
					icon_state=""
					spawn(5)
						src.firing=0
						src.canattack=1

		Chidori_Needles()
			for(var/obj/Jutsus/Chidori_Needles/J in src.JutsusLearnt)
				if(src.PreJutsu(J))
					var/mob/c_target=src.Target_Get(TARGET_MOB)
					if(loc.loc:Safe!=1) src.LevelStat("Ninjutsu",rand(8,13))//XPGAIN
					flick("2fist",src)
					view(src)<<sound('046.wav',0,0)
					src.firing=1
					src.canattack=0
					if(J.level==1) J.damage=6
					if(J.level==2) J.damage=10
					if(J.level==3) J.damage=15
					if(J.level==4) J.damage=30
					if(J.level<4) if(loc.loc:Safe!=1) J.exp+=rand(2,5); J.Levelup()
					var/num=5
					if(c_target)
						while(num)
							sleep(1)
							src.dir=get_dir(src,c_target)
							var/obj/Projectiles/Weaponry/ChidoriNeedle/A = new/obj/Projectiles/Weaponry/ChidoriNeedle(src.loc)
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
							A.damage=J.damage+round(src.ninjutsu*0.5+src.strength*0.3)
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
							num--
							sleep(1)
							var/obj/Projectiles/Weaponry/ChidoriNeedle/A = new/obj/Projectiles/Weaponry/ChidoriNeedle(src.loc)
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
								A.damage=J.damage+round(src.ninjutsu*1.5+src.strength*0.8)
							spawn() walk(A,src.dir)
					src.firing=0
					src.canattack=1
		Chidori_Nagashi()
			for(var/obj/Jutsus/Chidori_Nagashi/J in src.JutsusLearnt)
				if(src.PreJutsu(J))
					if(loc.loc:Safe!=1) src.LevelStat("Ninjutsu",rand(1,2))
					flick("jutsuse",src)
					src.firing=1
					src.canattack=0
					spawn(2)
						src.firing=0
						src.canattack=1
					if(J.level==1) J.damage=20
					if(J.level==2) J.damage=40
					if(J.level==3) J.damage=60
					if(J.level==4) J.damage=100
					if(J.level<4) if(loc.loc:Safe!=1) J.exp+=rand(2,5); J.Levelup()
					nagashi=1
					overlays+='Chidori Nigashi.dmi'
					spawn(80)
						if(src)
							RestoreOverlays()
							nagashi=0
					while(nagashi)
						//var/mob/M
						for(var/mob/M in orange(2,src))//maybe?
							if(M == src) return
							if(M.dead || M.swimming)return

							M.DealDamage(J.damage+src.ninjutsu*0.5,src,"NinBlue")
							LevelStat("Ninjutsu",1)
							if(M.henge==4||M.henge==5)M.HengeUndo()
						sleep(10)
						continue


		LightningBalls()
			for(var/obj/Jutsus/Lightning_Balls/J in src.JutsusLearnt)
				if(src.PreJutsu(J))
					if(firing)return
					var/mob/c_target=src.Target_Get(TARGET_MOB)
					if(loc.loc:Safe!=1) src.LevelStat("Ninjutsu",rand(1,2))
					flick("2fist",src)
					view(src)<<sound('wirlwind.wav',0,0)//CHANGE
					src.firing=1
					src.canattack=0
					if(J.level==1) J.damage=4
					if(J.level==2) J.damage=6
					if(J.level==3) J.damage=8
					if(J.level==4) J.damage=10
					if(J.level<4) if(loc.loc:Safe!=1) J.exp+=rand(2,5); J.Levelup()
					var/num=J.level*2
					if(c_target)
						while(num)
							sleep(2)
							num--
							src.dir=get_dir(src,c_target)
							var/obj/Projectiles/Weaponry/LightningBalls/A = new/obj/Projectiles/Weaponry/LightningBalls(src.loc)
							A.IsJutsuEffect=src
							if(prob(50))A.pixel_y+=rand(3,5)
							else A.pixel_y-=rand(1,5)
							if(prob(50))A.pixel_x+=rand(3,8)
							else A.pixel_x-=rand(1,8)
							A.level=J.level
							A.Owner=src
							A.layer=src.layer
							A.fightlayer=src.fightlayer
							A.damage=J.damage+round(src.ninjutsu/5+src.strength/15)
							walk_towards(A,c_target.loc,0)
							spawn(4)if(A)walk(A,A.dir)
					else
						while(num)
							sleep(2)
							num--
							var/obj/Projectiles/Weaponry/LightningBalls/A = new/obj/Projectiles/Weaponry/LightningBalls(src.loc)
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
							A.damage=J.damage+round(src.ninjutsu/5+src.strength/10)
							walk(A,src.dir)
					spawn(5)if(src)
						src.firing=0
						src.canattack=1
		Chidori()
			for(var/obj/Jutsus/Chidori/J in src.JutsusLearnt)
				if(src.PreJutsu(J))
					if(Effects["Chidori"])
						Effects["Chidori"]=null
						src.overlays-=image('Chidori.dmi',"hold")
						return
					if(loc.loc:Safe!=1) src.LevelStat("Ninjutsu",rand(4,8))
					if(J.level<4)
						if(loc.loc:Safe!=1) J.exp+=rand(2,5)
						J.Levelup()
					var/mob/c_target=src.Target_Get(TARGET_MOB)
					src.move=0
					src.injutsu=1
					src.canattack=0
					src.firing=1
					src.icon_state="groundjutsuse"
					var/obj/I = new/obj
					I.IsJutsuEffect=src
					I.loc = src.loc
					I.icon = 'Chidori.dmi'
					I.icon_state = "charge"
					I.pixel_y-=32
					I.pixel_x-=16
					if(dir!=SOUTH) I.layer=MOB_LAYER+1
					var/timer
					Effects["Chidori"] = J.level

					//if(J.level==4) Effects["Chidori"] = 5
					while(timer<20&&Effects["Chidori"]<5&&!Prisoned)
						timer++
						src.copy = "Chidori"
						var/obj/A = new/obj
						A.IsJutsuEffect=src
						A.loc = src.loc
						A.icon = 'Misc Effects.dmi'
						A.icon_state = "arrow"
						A.pixel_x=15
						A.pixel_y=7
						A.dir = SOUTH
						A.layer=10
						src.ArrowTasked = A
						sleep(5)
						if(A)del(A)
					if(Effects["Chidori"]<5||Prisoned)
						del(I)
						src.copy=null
						Effects["Chidori"]=null
						ArrowTasked=null
						src.move=1
						src.injutsu=0
						src.canattack=1
						src.firing=0
						return
					ArrowTasked=null
					src.copy=null
					src.icon_state=""
					src.move=1
					src.injutsu=0
					src.canattack=1
					src.firing=0
					Effects["Chidori"]=round(J.level*2)
					src.overlays+=image('Chidori.dmi',"hold")
					src.move=0
					if(I)del(I)
					spawn()
						if(src)
							timer=15
							src.icon_state = "run"
							var/rashit=0
							var/rcount=0
							while(rashit==0 && rcount <> 15)
								move=1
								rcount+=1
								if(c_target)step_towards(src,c_target)
								else step(src,src.dir)
								move=0
								var/obj/Drag/Dirt/D=new(src.loc)
								D.dir=src.dir
								for(var/mob/M in get_step(src,src.dir))
									if(M)
										flick("punchr",src)
										rashit=1
										step(src,src.dir)
										if(M)
											M.DealDamage((10*J.level)+(src.agility*4),src,"NinBlue")
											if(M)M.Bleed()
								sleep(0.5)
							if(src)
								Effects["Chidori"]=null
								src.overlays-=image('Chidori.dmi',"hold")
								src.move=1
								src.icon_state = ""

		Raikiri()
			for(var/obj/Jutsus/Raikiri/J in src.JutsusLearnt)
				if(src.PreJutsu(J))
					if(Effects["Chidori"])
						Effects["Chidori"]=null
						src.overlays-=image('Chidori.dmi',"hold")
						return
					if(loc.loc:Safe!=1) src.LevelStat("Ninjutsu",rand(4,8))
					if(J.level<4)
						if(loc.loc:Safe!=1) J.exp+=rand(2,5)
						J.Levelup()
					var/mob/c_target=src.Target_Get(TARGET_MOB)
					src.move=0
					src.injutsu=1
					src.canattack=0
					src.firing=1
					src.icon_state="groundjutsuse"
					var/obj/I = new/obj
					I.IsJutsuEffect=src
					I.loc = src.loc
					I.icon = 'Chidori.dmi'
					I.icon_state = "charge"
					I.pixel_y-=32
					I.pixel_x-=16
					if(dir!=SOUTH) I.layer=MOB_LAYER+1
					var/timer
					Effects["Chidori"] = J.level + round(J.level*0.25)
					//if(J.level==4) Effects["Chidori"] = 5
					while(timer<30&&Effects["Chidori"]<7&&!Prisoned)
						timer++
						src.copy = "Chidori"
						var/obj/A = new/obj
						A.IsJutsuEffect=src
						A.loc = src.loc
						A.icon = 'Misc Effects.dmi'
						A.icon_state = "arrow"
						A.pixel_x=15
						A.pixel_y=7
						A.dir = SOUTH
						A.layer=10
						src.ArrowTasked = A
						sleep(5)
						if(A)del(A)
					if(Effects["Chidori"]<7||Prisoned)
						if(I)del(I)
						src.copy=null
						Effects["Chidori"]=null
						ArrowTasked=null
						src.move=1
						src.injutsu=0
						src.canattack=1
						src.firing=0
						return
					ArrowTasked=null
					src.copy=null
					src.icon_state=""
					src.move=1
					src.injutsu=0
					src.canattack=1
					src.firing=0
					Effects["Chidori"]=round(J.level*3)
					src.overlays+=image('Chidori.dmi',"hold")
					src.move=0
					del(I)
					spawn()
						if(src)
							timer=15
							src.icon_state = "run"
							var/rashit=0
							var/rcount=0
							while(rashit==0 && rcount <> 15)
								move=1
								rcount+=1
								if(c_target)step_towards(src,c_target)
								else step(src,src.dir)
								move=0
								var/obj/Drag/Dirt/D=new(src.loc)
								D.dir=src.dir
								for(var/mob/M in get_step(src,src.dir))
									if(M)
										flick("punchr",src)
										rashit=1
										step(src,src.dir)
										if(M)
											M.DealDamage((J.level+1)*(src.agility*2),src,"NinBlue")
											if(M)M.Bleed()
								sleep(0.5)
							if(src)
								Effects["Chidori"]=null
								src.overlays-=image('Chidori.dmi',"hold")
								src.move=1
								src.icon_state = ""
