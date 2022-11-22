mob
	proc
		C2()
			for(var/obj/Jutsus/C2/J in src.jutsus)
				if(src.PreJutsu(J))
					if(loc.loc:Safe!=1) src.LevelStat("Ninjutsu",rand(1,2))
					if(J.level==1) J.damage=5
					if(J.level==2) J.damage=8
					if(J.level==3) J.damage=14
					if(J.level==4) J.damage=20
					if(J.level<4) if(loc.loc:Safe!=1) J.exp+=rand(2,5); J.Levelup()
					var/mob/M = new/mob/Untargettable/C2(src)
					M.loc = get_step(src,NORTH)
					M.name = src.key

		ClaySpiders()
			for(var/obj/Jutsus/C1_Spiders/J in src.jutsus)
				if(src.PreJutsu(J))
					var/mob/c_target=src.Target_Get(TARGET_MOB)
					if(loc.loc:Safe!=1) src.LevelStat("Ninjutsu",((J.maxcooltime*3/10)*jutsustatexp))
					flick("2fist",src)
					src.PlayAudio('dash.wav', output = AUDIO_HEARERS)
					AddState(src, new/state/cant_attack, 5)
					if(J.level==1) J.damage=((jutsudamage*J.Sprice)/2)
					if(J.level==2) J.damage=((jutsudamage*J.Sprice)/1.5)
					if(J.level==3) J.damage=((jutsudamage*J.Sprice)/1.25)
					if(J.level==4) J.damage=(jutsudamage*J.Sprice)
					if(J.level<4) if(loc.loc:Safe!=1) J.exp+=jutsumastery*(J.maxcooltime/20); J.Levelup()
					var/num=J.level+(round(src.ninjutsu_total/20))
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
							A.damage=(J.damage+round((src.ninjutsu_total / 200)*2*J.damage))/8
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
							A.damage=(J.damage+round((src.ninjutsu_total / 200)*2*J.damage))/2
							sleep(1)
							walk_rand(A,2)

		ClayBirds()
			for(var/obj/Jutsus/C1_Birds/J in src.jutsus)
				if(src.PreJutsu(J))
					var/mob/c_target=src.Target_Get(TARGET_MOB)
					if(loc.loc:Safe!=1) src.LevelStat("Ninjutsu",((J.maxcooltime*3/10)*jutsustatexp))
					flick("2fist",src)
					src.PlayAudio('dash.wav', output = AUDIO_HEARERS)
					AddState(src, new/state/cant_attack, 10)
					if(J.level==1) J.damage=((jutsudamage*J.Sprice)/2)
					if(J.level==2) J.damage=((jutsudamage*J.Sprice)/1.5)
					if(J.level==3) J.damage=((jutsudamage*J.Sprice)/1.25)
					if(J.level==4) J.damage=(jutsudamage*J.Sprice)
					if(J.level<4) if(loc.loc:Safe!=1) J.exp+=jutsumastery*(J.maxcooltime/20); J.Levelup()
					var/num=J.level+(round(src.ninjutsu_total/13))
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
							A.damage=(J.damage+round((src.ninjutsu_total / 200)*2*J.damage))/10
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
							A.damage=(J.damage+round((src.ninjutsu_total / 200)*2*J.damage))/8
							walk(A,src.dir)

		C3()
			for(var/obj/Jutsus/C3/J in src.jutsus)
				if(!src.C3bombz)
					if(src.PreJutsu(J))
						if(loc.loc:Safe != 1)
							src.LevelStat("Ninjutsu",((J.maxcooltime*3/10)*jutsustatexp))
						if(J.level==1) J.damage=((jutsudamage*J.Sprice)/2)
						if(J.level==2) J.damage=((jutsudamage*J.Sprice)/2)
						if(J.level==3) J.damage=((jutsudamage*J.Sprice)/1.25)
						if(J.level==4) J.damage=(jutsudamage*J.Sprice)
						src.PlayAudio('Skill_MashHit.wav', output = AUDIO_HEARERS)
						if(J.level < 4)
							if(loc.loc:Safe != 1)
								J.exp+=jutsumastery*(J.maxcooltime/20)
								J.Levelup()
						src << output("<b>Now to detonate use the defend verb (D).", "Action.Output")
						var/obj/O = new/obj/C3bomb(src)//	var/obj/C3bomb/O = new(src)
						O.level = J.level
						O.Owner=src
						src.C3bombz = O
						O.damage =(J.damage+round((src.ninjutsu_total / 200)*2*J.damage))*0.8

		C1Snake()
			for(var/obj/Jutsus/C1Snake/J in src.jutsus)
				if(src.PreJutsu(J))
					if(loc.loc:Safe!=1) src.LevelStat("Ninjutsu",((J.maxcooltime*3/10)*jutsustatexp))
					var/mob/c_target=src.Target_Get(TARGET_MOB)
					AddState(src, new/state/cant_attack, 10)
					if(J.level==1) J.damage=((jutsudamage*J.Sprice)/2)
					if(J.level==2) J.damage=((jutsudamage*J.Sprice)/1.5)
					if(J.level==3) J.damage=((jutsudamage*J.Sprice)/1.25)
					if(J.level==4) J.damage=(jutsudamage*J.Sprice)
					if(J.level<4) if(loc.loc:Safe!=1) J.exp+=jutsumastery*(J.maxcooltime/20); J.Levelup()
					flick("jutsuse",src)
					if(c_target)
						var/obj/Projectiles/Effects/SnakeC1/A = new/obj/Projectiles/Effects/SnakeC1(src.loc)
						A.Owner=src
						A.dir=src.dir
						A.damage=(J.damage+round((src.ninjutsu_total / 200)*2*J.damage))*0.9
						A.layer=src.layer
						walk_towards(A,c_target.loc)
						spawn(50)
							del(A)
					else
						var/obj/Projectiles/Effects/SnakeC1/A = new/obj/Projectiles/Effects/SnakeC1(src.loc)
						A.Owner=src
						A.dir=src.dir
						A.layer=src.layer
						A.damage=(J.damage+round((src.ninjutsu_total / 200)*2*J.damage))*0.9
						walk(A,A.dir)
						spawn(50)
							del(A)

