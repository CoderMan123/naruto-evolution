mob
	proc
		Shikigami_Dance()
			for(var/obj/Jutsus/Shikigami_Dance/J in src.jutsus)
				var/mob/c_target=usr.Target_Get(TARGET_MOB)
				if(!c_target)
					src<<output("You must have a target to use this technique.","Action.Output")
					return
				if(src.PreJutsu(J))
					if(loc.loc:Safe!=1) src.LevelStat("Ninjutsu",((J.maxcooltime*3/10)*jutsustatexp)) //determines amount of ninjutsu exp gained on use
					flick("jutsuse",src)
					src.PlayAudio('wirlwind.wav', output = AUDIO_HEARERS)
					if(J.level==1) J.damage=((jutsudamage*J.Sprice)/2)/9
					if(J.level==2) J.damage=((jutsudamage*J.Sprice)/1.5)/9
					if(J.level==3) J.damage=((jutsudamage*J.Sprice)/1.25)/9
					if(J.level==4) J.damage=(jutsudamage*J.Sprice)/9
					if(J.level<4) if(loc.loc:Safe!=1) J.exp+=jutsumastery*(J.maxcooltime/20); J.Levelup()
					J.damage=J.damage+round((src.ninjutsu_total / 200)*2*J.damage)
					var/Timer = J.level * 1.5 //determines how many ticks of damage as well as scaled bind duration
					if(src.inAngel==1) Timer *= 1.5
					Timer = round(Timer + 3)
					var/obj/A = new/obj(usr.loc)
					A.icon='Shikigami Dance.dmi'
					flick("anim", A)
					A.layer=MOB_LAYER+1
					var/mob/M = c_target
					A.linkfollow(M)
					var/matrix/x = matrix()
					x.Translate(-16,0)
					A.transform = x
					spawn(10)
						M=src.Target_Get(TARGET_MOB)
						if(M)
							var/bind_time = Timer*5
							Timer -= (Timer/100)*c_target.tenacity
							Bind(c_target, bind_time, src)
							var/bound_location = c_target.loc
							while(Timer&&c_target&&src&&c_target.loc == bound_location)
								sleep(5)
								Timer--
								c_target.DealDamage(J.damage,src,"NinBlue")
							del A
						else
							src<<output("The jutsu did not connect.","Action.Output")
							del A



		Paper_Chakram()
			for(var/obj/Jutsus/Paper_Chakram/J in src.jutsus)
				if(src.PreJutsu(J))
					var/mob/c_target=src.Target_Get(TARGET_MOB)
					if(loc.loc:Safe!=1) src.LevelStat("Ninjutsu",((J.maxcooltime*3/10)*jutsustatexp))
					flick("throw",src)
					src.PlayAudio('083.wav', output = AUDIO_HEARERS)
					Bind(src, 2)
					if(J.level==1) J.damage=((jutsudamage*J.Sprice)/2)*0.8
					if(J.level==2) J.damage=((jutsudamage*J.Sprice)/1.5)*0.8
					if(J.level==3) J.damage=((jutsudamage*J.Sprice)/1.25)*0.8
					if(J.level==4) J.damage=(jutsudamage*J.Sprice)*0.8
					if(J.level<4) if(loc.loc:Safe!=1) J.exp+=jutsumastery*(J.maxcooltime/20); J.Levelup()
					if(c_target)
						src.dir=get_dir(src,c_target)
						var/obj/Projectiles/Effects/Paper_Chakram/A = new/obj/Projectiles/Effects/Paper_Chakram(src.loc)
						A.IsJutsuEffect=src
						A.Owner=src
						A.layer=src.layer
						A.fightlayer=src.fightlayer
						A.damage=J.damage+round((src.ninjutsu_total / 200)*2*J.damage)
						A.level=J.level
						var/turf/TZ = c_target.loc
						walk_towards(A,TZ,0)
						spawn(7)if(A)walk(A,A.dir)
					else
						var/obj/Projectiles/Effects/Paper_Chakram/A = new/obj/Projectiles/Effects/Paper_Chakram(src.loc)
						A.IsJutsuEffect=src
						A.Owner=src
						A.layer=src.layer
						A.fightlayer=src.fightlayer
						A.damage=J.damage
						A.level=J.level
						walk(A,src.dir)

		Shikigami_Spear()
			for(var/obj/Jutsus/Shikigami_Spear/J in src.jutsus)
				if(src.PreJutsu(J))
					var/mob/c_target=src.Target_Get(TARGET_MOB)
					if(loc.loc:Safe!=1) src.LevelStat("Ninjutsu",((J.maxcooltime*3/10)*jutsustatexp))
					if(J.level==1) J.damage=((jutsudamage*J.Sprice)/2)*0.9
					if(J.level==2) J.damage=((jutsudamage*J.Sprice)/1.5)*0.9
					if(J.level==3) J.damage=((jutsudamage*J.Sprice)/1.25)*0.9
					if(J.level==4) J.damage=(jutsudamage*J.Sprice)*0.9
					if(J.level<4) if(loc.loc:Safe!=1) J.exp+=jutsumastery*(J.maxcooltime/20); J.Levelup()
					if(src.inAngel==0)
						flick("jutsuse",src)
						Bind(src, 10)
						sleep(10)
					src.PlayAudio('wirlwind.wav', output = AUDIO_HEARERS)
					flick("2fist",src)
					if(c_target)src.dir=get_dir(src,c_target)
					var/obj/Projectiles/Effects/JinraiBack/Aa=new(get_step(src,src.dir))
					Aa.icon = 'Shikigami Spear.dmi'
					Aa.IsJutsuEffect=src
					Aa.dir = src.dir
					Aa.layer = src.layer+1
					Aa.pixel_y=16
					Aa.pixel_x=-16
					var/obj/Projectiles/Effects/JinraiHead/A=new(get_step(src,src.dir))
					A.icon = 'Shikigami Spear.dmi'
					A.dir = src.dir
					A.Owner=src
					A.layer=MOB_LAYER+2
					A.fightlayer=src.fightlayer
					A.pixel_y=16
					A.pixel_x=-16
					A.damage=J.damage+round((src.ninjutsu_total / 200)*2*J.damage)
					A.level=J.level
					walk(A,dir,0)
					icon_state=""
					Aa.dir = src.dir

		Angel_Wings()
			for(var/obj/Jutsus/Angel_Wings/J in src.jutsus)
				if(src.PreJutsu(J))
					if(loc.loc:Safe!=1) src.LevelStat("Ninjutsu",((J.maxcooltime*3/10)*jutsustatexp))
					src.underlays+='Angel Wings.dmi'
					src.inAngel=1
					spawn(150)
						src.inAngel=0
						src.underlays-='Angel Wings.dmi'
						src<<"Angel mode goes off."

