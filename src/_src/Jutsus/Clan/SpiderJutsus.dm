mob
	proc
		WebShoot()
			for(var/obj/Jutsus/WebShoot/J in src.jutsus)
				if(src.PreJutsu(J))
					var/mob/c_target=src.Target_Get(TARGET_MOB)
					if(loc.loc:Safe!=1) src.LevelStat("Ninjutsu",((J.maxcooltime*3/10)*jutsustatexp))
					flick("throw",src)
					src.PlayAudio('dash.wav', output = AUDIO_HEARERS)
					src.firing=1
					src.canattack=0
					if(J.level==1) J.damage=15
					if(J.level==2) J.damage=20
					if(J.level==3) J.damage=25
					if(J.level==4) J.damage=30
					if(J.level<4) if(loc.loc:Safe!=1) J.exp+=jutsumastery*(J.maxcooltime/20); J.Levelup()
					var/obj/Projectiles/Effects/webshoot/S=new/obj/Projectiles/Effects/webshoot(src.loc)
					S.Owner=src
					S.damage=J.damage
					if(c_target)
						walk_to(S,c_target)
					else
						walk(S,S.dir)
					src.copy=null
					src.injutsu=0
					src.move=1
					src.canattack=1
					src.firing=0

		ArrowShoot()
			for(var/obj/Jutsus/ArrowShoot/J in src.jutsus)
				if(src.PreJutsu(J))
					var/mob/c_target=src.Target_Get(TARGET_MOB)
					if(loc.loc:Safe!=1) src.LevelStat("Ninjutsu",((J.maxcooltime*3/20)*jutsustatexp))
					if(loc.loc:Safe!=1) src.LevelStat("Precision",((J.maxcooltime*3/20)*jutsustatexp))
					flick("jutsuse",src)
					src.canattack=0
					src.move=0
					src.firing=1
					sleep(3)
					flick("2fist",src)
					src.PlayAudio('dash.wav', output = AUDIO_HEARERS)
					if(J.level==1) J.damage=((jutsudamage*J.Sprice)/2.5)*0.9
					if(J.level==2) J.damage=((jutsudamage*J.Sprice)/2)*0.9
					if(J.level==3) J.damage=((jutsudamage*J.Sprice)/1.5)*0.9
					if(J.level==4) J.damage=(jutsudamage*J.Sprice)*0.9
					if(J.level<4) if(loc.loc:Safe!=1) J.exp+=jutsumastery*(J.maxcooltime/20); J.Levelup()
					var/obj/Projectiles/Effects/arrowshoot/S=new/obj/Projectiles/Effects/arrowshoot(src.loc)
					S.Owner=src
					S.damage=(J.damage+round((src.ninjutsu / 150)*2*J.damage))*0.8
					if(c_target)
						walk_to(S,c_target)
					else
						walk(S,src.dir)
					src.copy=null
					src.injutsu=0
					src.move=1
					src.canattack=1
					src.firing=0

		Summon_Spider()
			if(src.firing==0 && src.canattack==1)
				for(var/obj/Jutsus/Summon_Spider/J in src.jutsus)
					if(src.PreJutsu(J))
						if(loc.loc:Safe!=1) src.LevelStat("Ninjutsu",((J.maxcooltime*3/10)*jutsustatexp))
						if(J.level==1) J.damage=((jutsudamage*J.Sprice)/2.5)/7
						if(J.level==2) J.damage=((jutsudamage*J.Sprice)/2)/7
						if(J.level==3) J.damage=((jutsudamage*J.Sprice)/1.5)/7
						if(J.level==4) J.damage=(jutsudamage*J.Sprice)/7
						if(J.level<4) if(loc.loc:Safe!=1) J.exp+=jutsumastery*(J.maxcooltime/20); J.Levelup()
						var/mob/jutsus/Summon_Spider/A=new/mob/jutsus/Summon_Spider(src.loc)
						A.OWNER=src
						A.dir=src.dir
						A.strength=J.damage+round((src.ninjutsu / 150)*2*J.damage)
						var/mob/c_target=src.Target_Get(TARGET_MOB)
						if(c_target)
							walk_to(A,c_target)
						spawn(100)
							del(A)
