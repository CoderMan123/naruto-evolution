mob
	proc
		C2()
			for(var/obj/Jutsus/C2/J in src.JutsusLearnt)
				if(src.PreJutsu(J))
					if(loc.loc:Safe!=1) src.LevelStat("Ninjutsu",rand(1,2))
					var/mob/M = new/mob/Untargettable/C2(src)
					M.loc = get_step(src,NORTH)
					M.name = src.key

		ClaySpiders()
			for(var/obj/Jutsus/C1_Spiders/J in src.JutsusLearnt)
				if(src.PreJutsu(J))
					var/mob/c_target=src.Target_Get(TARGET_MOB)
					if(loc.loc:Safe!=1) src.LevelStat("Ninjutsu",rand(3,5))
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
							var/obj/Projectiles/Effects/ClayBird/A = new/obj/Projectiles/Effects/ClayBird(src.loc)
							A.IsJutsuEffect=src
							if(prob(50))A.y+=1
							else A.y-=1
							if(prob(50))A.x+=1
							else A.x-=1
							A.icon_state = "Spider Swarm"
							A.level=J.level
							A.Owner=src
							A.layer=src.layer
							A.fightlayer=src.fightlayer
							A.damage=J.damage+round(src.ninjutsu/1.2+src.strength/4)
							walk_towards(A,c_target.loc,0)
							spawn(4)if(A)walk(A,A.dir,5)
					else
						while(num)
							sleep(2)
							num--
							var/obj/Projectiles/Effects/ClayBird/A = new/obj/Projectiles/Effects/ClayBird(src.loc)
							A.IsJutsuEffect=src
							if(prob(50))A.y+=1
							else A.y-=1
							if(prob(50))A.x+=1
							else A.x-=1
							if(A.loc == src.loc)A.loc = get_step(src,src.dir)
							A.icon_state = "Spider Swarm"
							A.level=J.level
							A.Owner=src
							A.layer=src.layer
							A.fightlayer=src.fightlayer
							A.damage=J.damage+round(src.ninjutsu/1.2+src.strength/4)
							walk_away(A,src)
							spawn(4)if(A)walk(A,A.dir,5)
					spawn(5)
						src.firing=0
						src.canattack=1

		ClayBirds()
			for(var/obj/Jutsus/C1_Birds/J in src.JutsusLearnt)
				if(src.PreJutsu(J))
					var/mob/c_target=src.Target_Get(TARGET_MOB)
					if(loc.loc:Safe!=1) src.LevelStat("Ninjutsu",rand(3,5))
					flick("2fist",src)
					view(src)<<sound('dash.wav',0,0)
					src.firing=1
					src.canattack=0
					if(J.level==1) J.damage=2
					if(J.level==2) J.damage=4
					if(J.level==3) J.damage=6
					if(J.level==4) J.damage=8
					if(J.level<4) if(loc.loc:Safe!=1) J.exp+=rand(2,5); J.Levelup()
					var/num=J.level+(round(src.ninjutsu/13))
					if(c_target)
						while(num)
							sleep(2)
							num--
							src.dir=get_dir(src,c_target)
							var/obj/Projectiles/Effects/ClayBird/A = new/obj/Projectiles/Effects/ClayBird(src.loc)
							A.IsJutsuEffect=src
							if(prob(50))A.pixel_y+=rand(3,5)
							else A.pixel_y-=rand(1,5)
							if(prob(50))A.pixel_x+=rand(3,8)
							else A.pixel_x-=rand(1,8)
							A.level=J.level
							A.Owner=src
							A.layer=src.layer
							A.fightlayer=src.fightlayer
							A.damage=J.damage+round(src.ninjutsu*0.8+src.strength/4)
							if(c_target) walk_towards(A,c_target.loc,0)
							spawn(4)if(A)walk(A,A.dir)
					else
						while(num)
							sleep(2)
							num--
							var/obj/Projectiles/Effects/ClayBird/A = new/obj/Projectiles/Effects/ClayBird(src.loc)
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
							A.damage=J.damage+round(src.ninjutsu*0.9+src.strength/4)
							walk(A,src.dir)
					spawn(5)
						src.firing=0
						src.canattack=1
		C3()
			for(var/obj/Jutsus/C3/J in src.JutsusLearnt)
				if(!src.C3bombz)
					if(src.PreJutsu(J))
						if(loc.loc:Safe != 1)
							src.LevelStat("Ninjutsu", rand(7, 11))
						view(src) << sound('Skill_MashHit.wav', 0, 0)
						if(J.level < 4)
							if(loc.loc:Safe != 1)
								J.exp += rand(5, 15)
								J.Levelup()
						src << output("<b>Now to detonate use the defend verb (D).", "ActionPanel.Output")
						var/obj/O = new/obj/C3bomb(src)//	var/obj/C3bomb/O = new(src)
						O.level = J.level
						O.Owner=src
						src.C3bombz = O
/*
		C3()
			if(src.firing==0 && src.canattack==1)
				for(var/obj/Jutsus/C3/J in src.JutsusLearnt)
					if(src.PreJutsu(J))
						if(loc.loc:Safe!=1) src.LevelStat("Ninjutsu",rand(7,11))
						view(src)<<sound('Skill_MashHit.wav',0,0)
						src.move=0
						src.firing=1
						src.canattack=0
						if(J.level==1) J.damage=300
						if(J.level==2) J.damage=350
						if(J.level==3) J.damage=600
						if(J.level==4) J.damage=700
						if(J.level<4) if(loc.loc:Safe!=1) J.exp+=rand(5,15); J.Levelup()
						src << output("<b>Now to detonate use the defend verb","ActionPanel.Output")
						var/obj/O = new/obj/C3bomb(src)
						src.C3bombz=O
						src.copy=null
						src.move=1
						src.firing=0
						src.copy=null
						src.canattack=1
						src.injutsu=0*/
		C1Snake()
			if(firing)return
			if(src.firing==0 && src.canattack==1)
				for(var/obj/Jutsus/C1Snake/J in src.JutsusLearnt)
					if(src.PreJutsu(J))
						if(loc.loc:Safe!=1) src.LevelStat("Ninjutsu",rand(7,11))
						var/mob/c_target=src.Target_Get(TARGET_MOB)
						src.firing=1
						src.canattack=0
						if(J.level==1) J.damage=40
						if(J.level==2) J.damage=80
						if(J.level==3) J.damage=120
						if(J.level==4) J.damage=130
						if(J.level<4) if(loc.loc:Safe!=1) J.exp+=rand(5,15); J.Levelup()
						flick("jutsuse",src)
						if(c_target)
							var/obj/Projectiles/Effects/SnakeC1/A = new/obj/Projectiles/Effects/SnakeC1(src.loc)
							A.Owner=src
							A.dir=src.dir
							A.damage=J.damage+round(src.ninjutsu*1.5)
							A.layer=src.layer
							walk_towards(A,c_target.loc)
							spawn(50)
								del(A)
						else
							var/obj/Projectiles/Effects/SnakeC1/A = new/obj/Projectiles/Effects/SnakeC1(src.loc)
							A.Owner=src
							A.dir=src.dir
							A.layer=src.layer
							A.damage=J.damage+round(src.ninjutsu*6)
							walk(A,A.dir)
							spawn(50)
								del(A)
						src.firing=0
						src.canattack=1

