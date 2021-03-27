mob
	proc
		BubbleBarrage()
			for(var/obj/Jutsus/Bubble_Barrage/J in src.jutsus)
				if(src.PreJutsu(J))
					var/mob/c_target=src.Target_Get(TARGET_MOB)
					if(loc.loc:Safe!=1) src.LevelStat("Ninjutsu",rand(1,2))
					flick("2fist",src)
					view(src)<<sound('dash.wav',0,0)
					src.firing=1
					src.canattack=0
					if(J.level==1) J.damage=30
					if(J.level==2) J.damage=50
					if(J.level==3) J.damage=70
					if(J.level==4) J.damage=90
					if(J.level<4) if(loc.loc:Safe!=1) J.exp+=rand(2,5); J.Levelup()
					var/num=J.level+(round(src.ninjutsu/15))
					if(c_target)
						while(num)
							sleep(2)
							num--
							src.dir=get_dir(src,c_target)
							var/obj/Projectiles/Effects/BubbleBarrage/A = new/obj/Projectiles/Effects/BubbleBarrage(src.loc)
							A.IsJutsuEffect=src
							if(prob(50))A.pixel_y+=rand(3,5)
							else A.pixel_y-=rand(1,5)
							if(prob(50))A.pixel_x+=rand(3,8)
							else A.pixel_x-=rand(1,8)
							A.level=J.level
							A.Owner=src
							A.layer=src.layer
							A.fightlayer=src.fightlayer
							A.damage=J.damage
							if(c_target) walk_towards(A,c_target.loc,0)
							spawn(4)if(A)walk(A,A.dir)
					else
						while(num)
							sleep(2)
							num--
							var/obj/Projectiles/Effects/BubbleBarrage/A = new/obj/Projectiles/Effects/BubbleBarrage(src.loc)
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
							A.damage=J.damage
							walk(A,src.dir)
					spawn(5)
						src.firing=0
						src.canattack=1

		Bubble_Trouble()
			for(var/obj/Jutsus/Bubble_Trouble/J in src.jutsus)
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
					Aa.icon = 'Bubble Trouble.dmi'
					Aa.IsJutsuEffect=src
					Aa.dir = src.dir
					Aa.layer = src.layer+1
					Aa.pixel_y=16
					Aa.pixel_x=-16
					var/obj/Projectiles/Effects/JinraiHead/A=new(get_step(src,src.dir))
					A.icon = 'Bubble Trouble.dmi'
					A.dir = src.dir
					A.Owner=src
					A.layer=src.layer
					A.fightlayer=src.fightlayer
					A.pixel_y=16
					A.pixel_x=-16
					A.damage=J.damage+round(src.agility*2)+round(src.ninjutsu*3)
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

		BubbleSpreader()
			for(var/obj/Jutsus/Bubble_Spreader/J in src.jutsus)
				if(src.PreJutsu(J))
					var/mob/c_target=src.Target_Get(TARGET_MOB)
					if(loc.loc:Safe!=1) src.LevelStat("Ninjutsu",rand(1,2))
					flick("2fist",src)
					view(src)<<sound('dash.wav',0,0)
					src.firing=1
					src.canattack=0
					if(J.level==1) J.damage=5
					if(J.level==2) J.damage=8
					if(J.level==3) J.damage=14
					if(J.level==4) J.damage=20
					if(J.level<4) if(loc.loc:Safe!=1) J.exp+=rand(2,5); J.Levelup()
					var/num=J.level+(round(src.ninjutsu/20))
					if(c_target)
						while(num)
							sleep(2)
							num--
							src.dir=get_dir(src,c_target)
							var/obj/Projectiles/Effects/BubbleBarrage/A = new/obj/Projectiles/Effects/BubbleBarrage(src.loc)
							A.IsJutsuEffect=src
							if(prob(50))A.y+=1
							else A.y-=1
							if(prob(50))A.x+=1
							else A.x-=1
							A.icon_state = "bblz"
							A.level=J.level
							A.Owner=src
							A.layer=src.layer
							A.fightlayer=src.fightlayer
							A.damage=J.damage+round((src.ninjutsu/1.5)+(src.strength/4))
							walk_towards(A,c_target.loc,0)
							spawn(4)if(A)walk(A,A.dir,5)
					else
						while(num)
							sleep(2)
							num--
							var/obj/Projectiles/Effects/BubbleBarrage/A = new/obj/Projectiles/Effects/BubbleBarrage(src.loc)
							A.IsJutsuEffect=src
							if(prob(50))A.y+=1
							else A.y-=1
							if(prob(50))A.x+=1
							else A.x-=1
							if(A.loc == src.loc)A.loc = get_step(src,src.dir)
							A.icon_state = "bblz"
							A.level=J.level
							A.Owner=src
							A.layer=src.layer
							A.fightlayer=src.fightlayer
							A.damage=J.damage+round((src.ninjutsu/1.5)+(src.strength/4))
							walk_away(A,src)
							spawn(1)if(A)walk(A,A.dir,5)
					spawn(5)
						src.firing=0
						src.canattack=1
