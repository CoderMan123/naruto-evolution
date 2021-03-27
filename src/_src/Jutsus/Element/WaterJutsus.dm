mob
	proc
		MizuClone_Jutsu()
			if(clonesturned==1)
				return
			if(src.firing==0&&src.canattack==1)
				for(var/obj/Jutsus/MizuClone/J in src.jutsus)
					if(!has_water())
						src<<output("<Font color=Aqua>You need a nearby water source to use this.</Font>","ActionPanel.Output")
						return
					if(src.PreJutsu(J))
						src.CloneHandler()
						view(src)<<sound('flashbang_explode1.wav',0,0)
						if(src.loc.loc:Safe!=1) src.LevelStat("Ninjutsu",rand(7,10))
						for(var/mob/M in oview(src,13))
							M.Target_Remove()
						src.mizubunshin++
						var/bun=src.mizubunshin+3
						src.DealDamage((src.health/bun),src,"NinBlue")
						src.chakra-=round(src.chakra/bun)
						flick("jutsu",src)
						var/mob/Clones/MizuBunshin/A = new/mob/Clones/MizuBunshin(src.loc)
						A.loc=src.loc
						A.Owner=src
						A.icon=src.icon
						A.overlays=src.overlays.Copy()
						A.strength=round(src.strength/bun)
						A.defence=round(src.defence/bun)
						A.health=100//round(src.health/bun)
						A.maxhealth=100//round(src.health/bun)
						A.agility=round(src.agility/bun)
						var/obj/O=new /obj/Screen/healthbar/
						var/obj/M=new /obj/Screen/manabar/
						A.hbar.Add(O)
						A.hbar.Add(M)
						spawn(3) if(A) A.icon = src.icon
						A.overlays-=/obj/Screen/healthbar
						A.overlays-=/obj/Screen/manabar
						for(var/obj/Screen/healthbar/HB in A.hbar)A.overlays+=HB
						for(var/obj/Screen/manabar/HB in A.hbar)A.overlays+=HB
						A.UpdateHMB()

		Teppoudama()
			for(var/obj/Jutsus/Teppoudama/J in src.jutsus)
				if(src.PreJutsu(J))
					if(loc.loc:Safe!=1) src.LevelStat("Ninjutsu",rand(10,15))//XPGAIN
					flick("jutsuse",src)
					src.firing=1
					src.canattack=0
					if(J.level==1) J.damage=5
					if(J.level==2) J.damage=10
					if(J.level==3) J.damage=15
					if(J.level==4) J.damage=20
					if(J.level<4) if(loc.loc:Safe!=1) J.exp+=rand(4,6); J.Levelup()
					var/obj/Teppoudama/A = new/obj/Teppoudama(src.loc)
					A.IsJutsuEffect=src
					A.Owner=src
					A.layer=src.layer
					A.fightlayer=src.fightlayer
					A.damage=J.damage
					A.level=J.level
					walk(A,src.dir,0)
					spawn(1)
						src.firing=0
						src.canattack=1
		Suijinheki()
			for(var/obj/Jutsus/Suijinheki/J in src.jutsus)
				if(src.PreJutsu(J))
					if(loc.loc:Safe!=1) src.LevelStat("Ninjutsu",0.2)
					flick("groundjutsu",src)
					src.firing=1
					src.canattack=0
					if(J.level<4) if(loc.loc:Safe!=1) J.exp+=rand(3,7); J.Levelup()
					var/obj/suijinheki/A = new/obj/suijinheki(src.loc)
					A.IsJutsuEffect=src
					A.Owner=src
					A.layer=src.layer
					A.fightlayer=src.fightlayer
					A.damage=J.damage
					A.level=J.level
					step(A,dir)
					spawn(1)
						src.firing=0
						src.canattack=1
		WaterPrison()
			for(var/obj/Jutsus/WaterPrison/J in src.jutsus)
				if(!has_water())
					src<<output("<Font color=Aqua>You need a nearby water source to use this.</Font>","ActionPanel.Output")
					return
				if(src.PreJutsu(J))
					if(loc.loc:Safe!=1) src.LevelStat("Ninjutsu",rand(3,5))
					flick("jutsuse",src)
					view(src)<<sound('dash.wav',0,0)
					src.firing=1
					src.canattack=0
					var/Timer
					if(J.level==1) Timer=2
					if(J.level==2) Timer=4
					if(J.level==3) Timer=7
					if(J.level==4) Timer=10
					if(J.level<4) if(loc.loc:Safe!=1) J.exp+=rand(2,5); J.Levelup()
					var/obj/PrisonOb
					var/turf/T
					for(var/mob/M in get_step(src,src.dir))
						if(istype(M)&&!M.dead)
							Prisoner=M
							M.move=0
							M.canattack=0
							M.injutsu=1
							M.Prisoned=1
							firing=1
							canattack=0
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
								M.move=0
								M.canattack=0
								M.injutsu=1
								M.Prisoned=1
								sleep(10)
						M.move=1
						M.canattack=1
						M.injutsu=0
						M.Prisoned=0
						icon_state=""
						if(PrisonOb)del(PrisonOb)
					firing=0
					canattack=1
					Prisoner=null

		WaterShark()
			for(var/obj/Jutsus/WaterShark/J in src.jutsus)
				if(!has_water())
					src<<output("<Font color=Aqua>You need a nearby water source to use this.</Font>","ActionPanel.Output")
					return
				if(src.PreJutsu(J))
					var/mob/c_target=src.Target_Get(TARGET_MOB)
					if(loc.loc:Safe!=1) src.LevelStat("Ninjutsu",rand(5,7))
					flick("groundjutsuse",src)
					view(src)<<sound('dash.wav',0,0)
					src.firing=1
					src.canattack=0
					if(J.level==1) J.damage=30
					if(J.level==2) J.damage=40
					if(J.level==3) J.damage=45
					if(J.level==4) J.damage=50
					if(J.level<4) if(loc.loc:Safe!=1) J.exp+=rand(2,5); J.Levelup()
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
							A.damage=J.damage+round(src.ninjutsu*2+src.strength*0.8)
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
							A.damage=J.damage+round(src.ninjutsu/2+src.strength/10)
							walk(A,src.dir)
					spawn(5)if(src)src.firing=0
					src.canattack=1

		Water_Dragon_Projectile()
			for(var/obj/Jutsus/Water_Dragon_Projectile/J in src.jutsus)
				if(!has_water())
					src << output("<Font color=Aqua>You need a nearby water source to use this.</Font>","ActionPanel.Output")
					return
				if(src.PreJutsu(J))
					var/mob/c_target=src.Target_Get(TARGET_MOB)
					if(loc.loc:Safe!=1) src.LevelStat("Ninjutsu",rand(5,7))
					if(J.level<4) if(loc.loc:Safe!=1) J.exp+=rand(2,5); J.Levelup()
					flick("2fist",src)
					view()<<sound('man_fs_r_mt_wat.ogg')
					src.firing=1
					src.canattack=0
					src.move=0
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
					A.damage=(J.level*50)+round(src.ninjutsu*1.5)+round(src.strength*5)
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

		Water_Release_Exploding_Water_Colliding_Wave()
			for(var/obj/Jutsus/Water_Release_Exploding_Water_Colliding_Wave/J in src.jutsus)
				if(src.PreJutsu(J))
					if(loc.loc:Safe!=1) src.LevelStat("Ninjutsu",rand(7,11))
					flick("jutsuse",src)
					view(src)<<sound('man_fs_r_mt_wat.ogg',0,0)
					src.firing=1
					src.canattack=0
					spawn(10-(J.level*2))
						if(src)if(src)
							src.firing=0
							src.canattack=1
							src.copy = null
					if(J.level==1) J.damage=5
					if(J.level==2) J.damage=10
					if(J.level==3) J.damage=15
					if(J.level==4) J.damage=30
					J.damage+=round(src.ninjutsu/10)
					if(J.level<4) if(loc.loc:Safe!=1) J.exp+=rand(5,15); J.Levelup()
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
					spawn(5)
						if(src)
							if(O)O.dir = src.dir
							var/moves=0
							while(moves<>(10+J.level))
								moves+=1
								sleep(1)
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
											if(M.dead || M.swimming) continue
											if(M) M.icon_state = "push"
											if(M) step(M,O.dir)
											if(M) M.dir = get_dir(M,O)
											if(M) M.DealDamage(J.damage,src,"NinBlue")
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
								sleep(1)
						if(O)del(O)
					src.copy = "Cant move"
					spawn(10-(J.level*2))
						if(src)
							src.firing=0
							src.copy=null
							src.canattack=1
