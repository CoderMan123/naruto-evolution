mob
	proc
		FuutonDaitoppa()
			for(var/obj/Jutsus/Daitoppa/J in src.JutsusLearnt)
				if(src.PreJutsu(J))
					if(loc.loc:Safe!=1) src.LevelStat("Ninjutsu",rand(5,10))
					flick("jutsuse",src)
					src.firing=1
					src.canattack=0
					spawn(10-(J.level*2))
						if(src)if(src)
							src.firing=0
							src.canattack=1
							src.copy = null
					if(J.level==1) J.damage=1
					if(J.level==2) J.damage=5
					if(J.level==3) J.damage=10
					if(J.level==4) J.damage=15
					J.damage+=round(src.ninjutsu/2)
					if(J.level<4) if(loc.loc:Safe!=1) J.exp+=rand(5,12); J.Levelup()
					var/obj/O = new/obj
					O.IsJutsuEffect=src
					O.loc = src.loc
					O.icon = 'fuuton.dmi'
					O.icon_state = "2"
					O.name="Fuuton Daitoppa"
					if(dir==NORTH||dir==SOUTH)
						O.overlays+=image('fuuton.dmi',icon_state = "1",pixel_x=-32)
						O.overlays+=image('fuuton.dmi',icon_state = "3",pixel_x=32)
					if(dir==EAST)
						O.overlays+=image('fuuton.dmi',icon_state = "1",pixel_y=-32)
						O.overlays+=image('fuuton.dmi',icon_state = "3",pixel_y=32)
					if(dir==WEST)
						O.overlays+=image('fuuton.dmi',icon_state = "1",pixel_y=32)
						O.overlays+=image('fuuton.dmi',icon_state = "3",pixel_y=-32)
					spawn(2)
						if(src)
							if(O)O.dir = src.dir
							var/moves=0
							while(moves<>(10+J.level))
								moves+=1
								if(O) step(O,O.dir)
								if(O)
									var/turf/T = O.loc
									if(T.density)moves=10
									else
										for(var/mob/M in O.loc)
											if(M.dead || M.swimming) continue
											if(M) M.icon_state = "push"
											if(M) step(M,O.dir)
											if(M) M.dir = get_dir(M,O)
											if(M) M.DealDamage(J.damage,src,"NinBlue")
											spawn(1)if(M)M.icon_state = ""
								sleep(1)
						if(O)del(O)
					spawn(10-(J.level*2))
						if(src)
							src.firing=0
							src.copy=null
							src.canattack=1
		Zankuuha()
			for(var/obj/Jutsus/Zankuuha/J in src.JutsusLearnt)
				if(src.PreJutsu(J))
					if(loc.loc:Safe!=1) src.LevelStat("Ninjutsu",0.2)
					flick("jutsuse",src)
					src.firing=1
					src.canattack=0
					if(J.level==1) J.damage=2
					if(J.level==2) J.damage=4
					if(J.level==3) J.damage=7
					if(J.level==4) J.damage=10
					if(J.level<4) if(loc.loc:Safe!=1) J.exp+=rand(3,5); J.Levelup()
					var/obj/Zankuuha/A = new/obj/Zankuuha(src.loc)
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

		Wind_Shield()
			for(var/obj/Jutsus/Wind_Shield/J in src.JutsusLearnt)
				if(src.PreJutsu(J))
					if(loc.loc:Safe!=1) src.LevelStat("Ninjutsu",rand(1,2))
					if(J.level==1) J.damage=5
					if(J.level==2) J.damage=10
					if(J.level==3) J.damage=15
					if(J.level==4) J.damage=20
					if(J.level<4) if(loc.loc:Safe!=1) J.exp+=rand(2,5); J.Levelup()
					src.firing=1
					src.canattack=0
					src.move=0
					flick("jutsuse",src)
					view(src)<<sound('wirlwind.wav',0,0)
					var/obj/O=new
					O.IsJutsuEffect=src
					O.icon='Tornado.dmi'
					O.loc=src.loc
					O.layer=200
					O.pixel_x=-78
					for(var/mob/M in orange(2))
						if(!M) continue
						M.DealDamage(J.damage+src.strength*0.7+src.ninjutsu*0.7,src,"NinBlue")
						if(M) M.Bleed()
						M.icon_state="push"
						M.injutsu=1
						M.canattack=0
						M.firing=1
						step_away(M,src)
						walk(M,M.dir)
						if(M.client)spawn()M.ScreenShake(5)
						spawn(round(6))
							if(M)
								walk(M,0)
								M.injutsu=0
								if(!M.swimming)M.icon_state=""
								M.canattack=1
								M.firing=0
								if(M) M.Bleed()
					spawn(5)
						del(O)
						src.firing=0
						src.canattack=1
						src.move=1
		Sickle_Weasel_Technique()
			for(var/obj/Jutsus/Sickle_Weasel_Technique/J in src.JutsusLearnt)
				if(src.PreJutsu(J))
					if(firing)return
					var/mob/c_target=src.Target_Get(TARGET_MOB)
					if(loc.loc:Safe!=1) src.LevelStat("Ninjutsu",rand(8,12))//XPGAIN
					flick("2fist",src)
					view(src)<<sound('wirlwind.wav',0,0)
					src.firing=1
					src.canattack=0
					if(J.level==1) J.damage=2
					if(J.level==2) J.damage=3
					if(J.level==3) J.damage=4
					if(J.level==4) J.damage=5
					if(J.level<4) if(loc.loc:Safe!=1) J.exp+=rand(2,5); J.Levelup()
					var/num=J.level*2
					while(num)
						sleep(3)
						num--
						var/obj/Projectiles/Weaponry/SickleSlash/A = new/obj/Projectiles/Weaponry/SickleSlash(src.loc)
						A.IsJutsuEffect=src
						A.level=J.level
						A.Owner=src
						A.layer=src.layer
						A.fightlayer=src.fightlayer
						A.damage=J.damage+round(src.ninjutsu/2+src.strength/4)
						if(c_target)
							src.dir=get_dir(src,c_target)
							if(prob(50))A.pixel_y+=rand(3,5)
							else A.pixel_y-=rand(1,5)
							if(prob(50))A.pixel_x+=rand(3,8)
							else A.pixel_x-=rand(1,8)
							walk_towards(A,c_target.loc,0)
							spawn(4)if(A)walk(A,A.dir)
						else
							if(prob(50))A.y+=1
							else A.y-=1
							if(prob(50))A.x+=1
							else A.x-=1
							if(A.loc == src.loc)A.loc = get_step(src,src.dir)
							walk(A,src.dir)
					spawn(5)
						if(src)
							src.firing=0
							src.canattack=1

		Blade_of_Wind()
			for(var/obj/Jutsus/Blade_of_Wind/J in src.JutsusLearnt)
				if(src.PreJutsu(J))
					if(loc.loc:Safe!=1) src.LevelStat("Ninjutsu",rand(1,2))
					if(J.level<4) if(loc.loc:Safe!=1) J.exp+=rand(1,2); J.Levelup()
					if(src.BOW<J.level*2)src.BOW++
					src<<output("You charge chakra to your fingertips, and now have stocked [src.BOW] Blades of Wind.","ActionPanel.Output")

		Wind_Tornados()
			if(src.firing==0 && src.canattack==1 && src.dead==0)
				for(var/obj/Jutsus/Wind_Tornados/J in src.JutsusLearnt)
					if(src.PreJutsu(J))
						if(loc.loc:Safe!=1) src.LevelStat("Ninjutsu",rand(11,15))
						src.move=0
						src.injutsu=1
						if(J.level<4) if(loc.loc:Safe!=1) J.exp+=rand(8,10); J.Levelup()
						src.firing=1
						src.canattack=0
						var/obj/forwind/windstyle/A=new/obj/forwind/windstyle(src.loc)
						A.owner=src
						spawn(10)
							src.copy=null
							src.injutsu=0
							src.move=1
							src.canattack=1
							src.firing=0
						while(A)
							walk_rand(A,2)
							for(var/mob/M in orange(2,A))
								if(M!=A.owner)
									M.DealDamage(round((src.ninjutsu*J.level)*0.5),src,"NinBlue")
							sleep(8)


		Wind_Dragon_Projectile()
			for(var/obj/Jutsus/Wind_Dragon_Projectile/J in src.JutsusLearnt)
				if(src.PreJutsu(J))
					var/mob/c_target=src.Target_Get(TARGET_MOB)
					if(loc.loc:Safe!=1) src.LevelStat("Ninjutsu",rand(1,2))
					if(J.level<4) if(loc.loc:Safe!=1) J.exp+=rand(2,5); J.Levelup()
					view()<<sound('man_fs_r_mt_wat.ogg')
					src.firing=1
					src.canattack=0
					src.move=0
					J.damage=J.level*45
					if(c_target)src.dir=get_dir(src,c_target)
					var/obj/Projectiles/Effects/JinraiBack/Aa=new(get_step(src,src.dir))
					Aa.icon = 'Wind Dragon Projectile.dmi'
					Aa.IsJutsuEffect=src
					Aa.dir = src.dir
					Aa.layer = src.layer+1
					Aa.pixel_y=16
					Aa.pixel_x=-16
					var/obj/Projectiles/Effects/JinraiHead/A=new(get_step(src,src.dir))
					A.icon = 'Wind Dragon Projectile.dmi'
					A.dir = src.dir
					A.Owner=src
					A.layer=src.layer+2
					A.fightlayer=src.fightlayer
					A.pixel_y=16
					A.pixel_x=-16
					A.damage=J.damage+round(src.agility*2)+round(src.ninjutsu*5)
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



		Wind_Cutter()
			for(var/obj/Jutsus/Wind_Cutter/J in src.JutsusLearnt)
				if(src.PreJutsu(J))
					if(loc.loc:Safe!=1) src.LevelStat("Ninjutsu",rand(5,10))
					flick("jutsuse",src)
					view(src)<<sound('dash.wav',0,0)
					src.firing=1
					src.canattack=0
					spawn(10-(J.level*2))
						if(src)if(src)
							src.firing=0
							src.canattack=1
							src.copy = null
					if(J.level==1) J.damage=8
					if(J.level==2) J.damage=11
					if(J.level==3) J.damage=18
					if(J.level==4) J.damage=40
					J.damage+=round(src.ninjutsu/10)
					if(J.level<4) if(loc.loc:Safe!=1) J.exp+=rand(5,15); J.Levelup()
					var/obj/O = new/obj
					O.IsJutsuEffect=src
					O.loc = src.loc
					O.icon = 'Wind Cutter.dmi'
					O.icon_state = "Cut"
					O.name="Cut"
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
								sleep(1)
						if(O)del(O)
					src.copy = "Cant move"
					spawn(10-(J.level*2))
						if(src)
							src.firing=0
							src.copy=null
							src.canattack=1
		Rasenshuriken()
			for(var/obj/Jutsus/Rasenshuriken/J in src.JutsusLearnt)
				if(src.PreJutsu(J))
					if(Effects["Rasengan"])
						Effects["Rasengan"]=null
						src.overlays-=image('Rasengan.dmi',"spin")
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
					src.icon_state="punchrS"
					var/obj/I = new/obj
					I.IsJutsuEffect=src
					if(dir!=SOUTH) I.layer=MOB_LAYER-1
					I.loc = src.loc
					I.icon = 'Rasenshuriken.dmi'
					I.pixel_y=-32
					I.pixel_x=-32
					switch(src.dir)
						if(SOUTH)
							I.pixel_y=-8
							I.layer = MOB_LAYER+1
						if(NORTH)
							I.pixel_y=5
							I.pixel_x=-12
						if(EAST)I.pixel_x=-13
						if(WEST)I.pixel_x=-11
					flick("form",I)
					spawn(3)if(I)I.icon_state = "spin"
					var/timer=0
					var/list/DIRS=list(NORTH,EAST,SOUTH,WEST)
					Effects["Rasengan"] = (J.level * 0.5)
					//if(J.level==4) Effects["Rasengan"] = 4
					while(DIRS.len&&timer<15&&Effects["Rasengan"]!=4&&!Prisoned)
						timer++
						src.copy = "Rasengan"
						var/obj/A = new/obj
						A.IsJutsuEffect=src
						A.loc = src.loc
						A.icon = 'Misc Effects.dmi'
						A.icon_state = "arrow"
						A.pixel_x=15
						A.pixel_y=7
						A.dir = DIRS[1]
						DIRS-=DIRS[1]
						A.layer=10
						src.ArrowTasked = A
						sleep(10)
						if(A)del(A)
					src.icon_state=""
					I.icon_state = "form"
					I.pixel_x=0
					walk_to(I,src)
					src.move=1
					src.injutsu=0
					src.canattack=1
					src.firing=0
					if(Effects["Rasengan"]<4||Prisoned)
						del(I)
						src.copy=null
						Effects["Rasengan"]=null
						ArrowTasked=null
					else
						ArrowTasked=null
						src.copy=null
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
									del(I)
									M.icon_state="push"
									M.injutsu=1
									M.canattack=0
									M.firing=1
									walk(M,src.dir)
									if(M.client)spawn(1)if(M)M.ScreenShake(6)
									spawn(10)
										if(M)
											walk(M,0)
											M.injutsu=0
											if(!M.swimming)M.icon_state=""
											M.canattack=1
											M.firing=0
											var/obj/Ex = new/obj
											Ex.icon = 'Rasenshuriken Explode.dmi'
											Ex.icon_state = "wtf"
											Ex.layer=MOB_LAYER+2
											Ex.pixel_x=-112
											Ex.loc = M.loc
											spawn(20)if(Ex)del(Ex)
											M.DealDamage((J.level+2)*(src.ninjutsu+src.strength),src,"TaiOrange")
							sleep(1)
						if(I)del(I)
					move=1
					Effects["Rasengan"]=null
