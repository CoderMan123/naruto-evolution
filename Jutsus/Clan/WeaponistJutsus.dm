mob
	proc
		Demon_Wind_Shuriken()
			for(var/obj/Jutsus/Demon_Wind_Shuriken/J in src.JutsusLearnt)
				if(src.PreJutsu(J))
					if(loc.loc:Safe!=1) src.LevelStat("Ninjutsu",rand(4,8))
					var/mob/c_target=src.Target_Get(TARGET_MOB)
					flick("2fist",src)
					view(src)<<sound('dash.wav',0,0)
					src.firing=1
					src.canattack=0
					if(J.level==1) J.damage=5
					if(J.level==2) J.damage=6
					if(J.level==3) J.damage=7
					if(J.level==4) J.damage=9
					if(J.level<4) if(loc.loc:Safe!=1) J.exp+=rand(2,5); J.Levelup()
					var/num=round(J.level*1.5)
					if(c_target)
						while(num)
							sleep(1)
							num--
							src.dir=get_dir(src,c_target)
							var/obj/Projectiles/Effects/Windmill/A = new/obj/Projectiles/Effects/Windmill(src.loc)
							A.IsJutsuEffect=src
							A.x+=rand(-1,1)
							A.y+=rand(-1,1)
							A.level=J.level
							A.Owner=src
							A.layer=src.layer
							A.fightlayer=src.fightlayer
							A.damage=J.damage+round(src.ninjutsu/5+src.strength/10)
							A.density=0
							spawn(1)if(A)A.density=1
							walk_towards(A,c_target,0)
							spawn(7)if(A)walk(A,A.dir)
					else
						while(num)
							sleep(1)
							num--
							var/obj/Projectiles/Effects/Windmill/A = new/obj/Projectiles/Effects/Windmill(src.loc)
							A.IsJutsuEffect=src
							A.x+=rand(-1,1)
							A.y+=rand(-1,1)
							if(A.loc == src.loc)A.loc = get_step(src,src.dir)
							A.level=J.level
							A.Owner=src
							A.layer=src.layer
							A.fightlayer=src.fightlayer
							A.damage=J.damage+round(src.ninjutsu/5+src.strength/10)
							A.density=0
							spawn(1) if(A) A.density=1
							walk(A,src.dir)
					src.firing=0
					src.canattack=1

		Multiple_Chakra_Kunai()
			for(var/obj/Jutsus/Multiple_Chakra_Kunai/J in src.JutsusLearnt)
				if(src.PreJutsu(J))
					if(loc.loc:Safe!=1) src.LevelStat("Ninjutsu",rand(4,8))
					var/mob/c_target=src.Target_Get(TARGET_MOB)
					flick("2fist",src)
					view(src)<<sound('dash.wav',0,0)
					src.firing=1
					src.canattack=0
					if(J.level==1) J.damage=5
					if(J.level==2) J.damage=6
					if(J.level==3) J.damage=7
					if(J.level==4) J.damage=10
					if(J.level<4) if(loc.loc:Safe!=1) J.exp+=rand(2,5); J.Levelup()
					var/num=round(J.level*1.5)
					if(c_target)
						while(num)
							sleep(1)
							num--
							src.dir=get_dir(src,c_target)
							var/obj/Projectiles/Effects/ChakraManiper/A = new/obj/Projectiles/Effects/ChakraManiper(src.loc)
							A.IsJutsuEffect=src
							A.x+=rand(-1,1)
							A.y+=rand(-1,1)
							A.level=J.level
							A.Owner=src
							A.layer=src.layer
							A.fightlayer=src.fightlayer
							A.damage=J.damage+round(src.ninjutsu/5+src.strength/10)
							A.density=0
							spawn(1)if(A)A.density=1
							walk_towards(A,c_target,0)
							spawn(7)if(A)walk(A,A.dir)
					else
						while(num)
							sleep(1)
							num--
							var/obj/Projectiles/Effects/ChakraManiper/A = new/obj/Projectiles/Effects/ChakraManiper(src.loc)
							A.IsJutsuEffect=src
							A.x+=rand(-1,1)
							A.y+=rand(-1,1)
							if(A.loc == src.loc)A.loc = get_step(src,src.dir)
							A.level=J.level
							A.Owner=src
							A.layer=src.layer
							A.fightlayer=src.fightlayer
							A.damage=J.damage+round(src.ninjutsu/5+src.strength/10)
							A.density=0
							spawn(1) if(A) A.density=1
							walk(A,src.dir)
					src.firing=0
					src.canattack=1
		Blade_Manipulation_Jutsu()
			for(var/obj/Jutsus/Blade_Manipulation_Jutsu/J in src.JutsusLearnt)
				if(src.PreJutsu(J))
					if(loc.loc:Safe!=1) src.LevelStat("Ninjutsu",rand(2,4))
					var/mob/c_target=src.Target_Get(TARGET_MOB)
					flick("2fist",src)
					view(src)<<sound('dash.wav',0,0)
					src.firing=1
					src.canattack=0
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
							A.damage=J.damage+round(src.ninjutsu/5+src.strength/10)
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
							A.damage=J.damage+round(src.ninjutsu/5+src.strength/10)
							A.density=0
							spawn(1) if(A) A.density=1
							walk(A,src.dir)
					src.firing=0
					src.canattack=1
		Rising_Twin_Dragons()
			for(var/obj/Jutsus/Rising_Twin_Dragon/J in src.JutsusLearnt)
				if(src.PreJutsu(J))
					if(loc.loc:Safe!=1) src.LevelStat("Ninjutsu",rand(4,8))
					var/mob/c_target=src.Target_Get(TARGET_MOB)
					flick("2fist",src)
					view(src)<<sound('dash.wav',0,0)
					src.firing=1
					src.canattack=0
					if(J.level==1) J.damage=6
					if(J.level==2) J.damage=7
					if(J.level==3) J.damage=8
					if(J.level==4) J.damage=10
					if(J.level<4) if(loc.loc:Safe!=1) J.exp+=rand(2,5); J.Levelup()
					var/num=round(J.level*1.5)
					if(c_target)
						while(num)
							sleep(1)
							num--
							src.dir=get_dir(src,c_target)
							var/obj/Projectiles/Effects/Windmill/A = new/obj/Projectiles/Effects/RTD(src.loc)
							A.IsJutsuEffect=src
							A.x+=rand(-1,1)
							A.y+=rand(-1,1)
							A.level=J.level
							A.Owner=src
							A.layer=src.layer
							A.fightlayer=src.fightlayer
							A.damage=J.damage+round(src.ninjutsu/5+src.strength/10)
							A.density=0
							spawn(1)if(A)A.density=1
							walk_towards(A,c_target,0)
							spawn(7)if(A)walk(A,A.dir)
							var/obj/Aa = new(get_step(src,src.dir))
							Aa.icon = 'RisingTwinDragon.dmi'
							Aa.icon_state="1"
							Aa.IsJutsuEffect=src
							Aa.dir = src.dir
							Aa.pixel_y=16
							Aa.pixel_x=-16
							Aa.layer = src.layer+1
							flick("delete",Aa)
							sleep(4)
							del(Aa)
					else
						while(num)
							sleep(1)
							num--
							var/obj/Projectiles/Effects/Windmill/A = new/obj/Projectiles/Effects/RTD(src.loc)
							A.IsJutsuEffect=src
							A.x+=rand(-1,1)
							A.y+=rand(-1,1)
							if(A.loc == src.loc)A.loc = get_step(src,src.dir)
							A.level=J.level
							A.Owner=src
							A.layer=src.layer
							A.fightlayer=src.fightlayer
							A.damage=J.damage+round(src.ninjutsu/5+src.strength/10)
							A.density=0
							spawn(1) if(A) A.density=1
							walk(A,src.dir)
					src.firing=0
					src.canattack=1
		Weapon_Manipulation_Jutsu()
			if(firing)return
			if(src.firing==0 && src.canattack==1)
				for(var/obj/Jutsus/Weapon_Manipulation_Jutsu/J in src.JutsusLearnt)
					if(src.PreJutsu(J))
						if(loc.loc:Safe!=1) src.LevelStat("Ninjutsu",rand(3,4))
						var/mob/c_target=src.Target_Get(TARGET_MOB)
						flick("2fist",src)
						view(src)<<sound('dash.wav',0,0)
						src.firing=1
						src.canattack=0
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
								if(prob(50))
									var/obj/Projectiles/Effects/Maniper2/A = new/obj/Projectiles/Effects/Maniper2(src.loc)
									A.IsJutsuEffect=src
									A.x+=rand(-1,1)
									A.y+=rand(-1,1)
									A.level=J.level
									A.Owner=src
									A.layer=src.layer
									A.fightlayer=src.fightlayer
									A.damage=J.damage+round(src.ninjutsu+src.strength)
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
									A.damage=J.damage+round(src.ninjutsu+src.strength)
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
									A.damage=J.damage+round(src.ninjutsu+src.strength)
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
									A.damage=J.damage+round(src.ninjutsu+src.strength)
									A.density=0
									spawn(1) if(A) A.density=1
									walk(A,src.dir)
						src.firing=0
						src.canattack=1

		TwinDragons()
			if(firing)return
			if(src.firing==0 && src.canattack==1)
				for(var/obj/Jutsus/TwinDragons/J in src.JutsusLearnt)
					if(src.PreJutsu(J))
						if(loc.loc:Safe!=1) src.LevelStat("Ninjutsu",rand(7,11))
						var/mob/c_target=src.Target_Get(TARGET_MOB)
						flick("jutsuse",src)
						view(src)<<sound('dash.wav',0,0)
						src.firing=1
						src.canattack=0
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
									A.damage=J.damage+round(src.ninjutsu*2+src.strength*2)
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
									A.damage=J.damage+round(src.ninjutsu*2+src.strength*2)
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
									A.damage=J.damage+round(src.ninjutsu*2+src.strength*2)
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
									A.damage=J.damage+round(src.ninjutsu*2+src.strength*2)
									A.density=0
									spawn(1) if(A) A.density=1
									walk_rand(A)
									spawn(10)
										del(A)
						src.firing=0
						src.canattack=1
