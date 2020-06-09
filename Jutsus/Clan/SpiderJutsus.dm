mob
	proc
		WebShoot()
			for(var/obj/Jutsus/WebShoot/J in src.JutsusLearnt)
				if(src.PreJutsu(J))
					var/mob/c_target=src.Target_Get(TARGET_MOB)
					if(loc.loc:Safe!=1) src.LevelStat("Ninjutsu",rand(7,11))
					flick("throw",src)
					view(src)<<sound('dash.wav',0,0)
					src.firing=1
					src.canattack=0
					if(J.level==1) J.damage=10
					if(J.level==2) J.damage=20
					if(J.level==3) J.damage=30
					if(J.level==4) J.damage=40
					if(J.level<4) if(loc.loc:Safe!=1) J.exp+=rand(2,5); J.Levelup()
					var/obj/Projectiles/Effects/webshoot/S=new/obj/Projectiles/Effects/webshoot(src.loc)
					S.Owner=src
					S.damage=J.damage
					if(c_target)
						walk_towards(S,c_target.loc)
					else
						walk(S,S.dir)
					src.copy=null
					src.injutsu=0
					src.move=1
					src.canattack=1
					src.firing=0

		ArrowShoot()
			for(var/obj/Jutsus/ArrowShoot/J in src.JutsusLearnt)
				if(src.PreJutsu(J))
					var/mob/c_target=src.Target_Get(TARGET_MOB)
					if(loc.loc:Safe!=1) src.LevelStat("Ninjutsu",rand(7,11))
					flick("2fist",src)
					view(src)<<sound('dash.wav',0,0)
					src.firing=1
					src.canattack=0
					if(J.level==1) J.damage=55
					if(J.level==2) J.damage=90
					if(J.level==3) J.damage=130
					if(J.level==4) J.damage=200
					if(J.level<4) if(loc.loc:Safe!=1) J.exp+=rand(2,5); J.Levelup()
					var/obj/Projectiles/Effects/arrowshoot/S=new/obj/Projectiles/Effects/arrowshoot(src.loc)
					S.Owner=src
					S.damage=J.damage+src.ninjutsu*5
					if(c_target)
						walk_towards(S,c_target.loc)
					else
						walk(S,src.dir)
					src.copy=null
					src.injutsu=0
					src.move=1
					src.canattack=1
					src.firing=0

		Summon_Spider()
			if(src.firing==0 && src.canattack==1)
				for(var/obj/Jutsus/Summon_Spider/J in src.JutsusLearnt)
					if(src.PreJutsu(J))
						if(loc.loc:Safe!=1) src.LevelStat("Ninjutsu",rand(7,11))
						var/mob/jutsus/Summon_Spider/A=new/mob/jutsus/Summon_Spider(src.loc)
						A.OWNER=src
						A.dir=src.dir
						var/mob/c_target=src.Target_Get(TARGET_MOB)
						if(c_target)
							walk_to(A,c_target)
						spawn(100)
							del(A)
