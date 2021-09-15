mob
	proc
		Flying_Thunder_God_Kunai()
			for(var/obj/Jutsus/Flying_Thunder_God_Kunai/J in src.jutsus)
				if(src.PreJutsu(J))
					if(loc.loc:Safe!=1) src.LevelStat("Ninjutsu",((J.maxcooltime*3/20)*jutsustatexp))
					if(loc.loc:Safe!=1) src.LevelStat("Precision",((J.maxcooltime*3/20)*jutsustatexp))
					if(J.level<4) if(loc.loc:Safe!=1) J.exp+=jutsumastery*(J.maxcooltime/20); J.Levelup()
					if(J.level==1) J.damage=((jutsudamage*J.Sprice)/2.5)*0.6
					if(J.level==2) J.damage=((jutsudamage*J.Sprice)/2)*0.6
					if(J.level==3) J.damage=((jutsudamage*J.Sprice)/1.5)*0.6
					if(J.level==4) J.damage=(jutsudamage*J.Sprice)*0.6
					if(!move) return
					if(injutsu) return
					if(copy=="Climb") return
					var/mob/c_target=src.Target_Get(TARGET_MOB)
					if(c_target)
						src.dir=get_dir(src,c_target)
						flick("throw",src)
						src.PlayAudio('SkillDam_ThrowSuriken2.wav', output = AUDIO_HEARERS)
						var/obj/Projectiles/Effects/FTGkunai/A = new/obj/Projectiles/Effects/FTGkunai(src.loc)
						A.IsJutsuEffect=src
						A.Owner=src
						A.layer=src.layer
						A.fightlayer=src.fightlayer
						A.damage=J.damage+round(((src.ninjutsu / 300)+(src.precision / 300))*2*J.damage)
						A.level=J.level
						walk_towards(A,c_target.loc,0)
						spawn(4)if(A.icon_state=="thrown")walk(A,A.dir)
						src.ftgkunai=A
					else
						flick("throw",src)
						src.PlayAudio('SkillDam_ThrowSuriken2.wav', output = AUDIO_HEARERS)
						var/obj/Projectiles/Effects/FTGkunai/A = new/obj/Projectiles/Effects/FTGkunai(src.loc)
						A.IsJutsuEffect=src
						A.Owner=src
						A.layer=src.layer
						A.fightlayer=src.fightlayer
						A.damage=J.damage+round(((src.ninjutsu / 300)+(src.precision / 300))*2*J.damage)
						A.level=J.level
						walk(A,src.dir)
						src.ftgkunai=A


		Warp_Rasengan()
			for(var/obj/Jutsus/Warp_Rasengan/J in src.jutsus)
				var/mob/c_target=src.Target_Get(TARGET_MOB)
				if(!c_target||c_target.ftgmarked==0)
					src<<output("You can only use this on targets you've marked with your kunai!","Action.Output")
					return
				if(src.PreJutsu(J))
					if(loc.loc:Safe!=1) src.LevelStat("Ninjutsu",((J.maxcooltime*3/10)*jutsustatexp))
					if(J.level<4) if(loc.loc:Safe!=1) J.exp+=jutsumastery*(J.maxcooltime/20); J.Levelup()
					if(J.level==1) J.damage=((jutsudamage*J.Sprice)/2.5)*0.7
					if(J.level==2) J.damage=((jutsudamage*J.Sprice)/2)*0.7
					if(J.level==3) J.damage=((jutsudamage*J.Sprice)/1.5)*0.7
					if(J.level==4) J.damage=(jutsudamage*J.Sprice)*0.7
					src.move=0
					src.injutsu=1
					src.firing=1
					src.canattack=0
					src.icon_state = "jutsuse"
					sleep(2)
					flick('Flyingthunder.dmi',src)
					if(c_target)
						c_target.dir = get_dir(c_target,src)
						flick('Flyingthunder.dmi',src)
						loc = c_target.loc
						step(src,c_target.dir)
						dir = get_dir(src,c_target)
						flick("2fist",src)
						for(var/mob/M in get_step(src,src.dir))
							for(var/i=0,i<4,i++)
								var/obj/O = new/obj
								O.loc = M.loc
								O.icon = 'Rasenshuriken Explode.dmi'
								flick("wtf",O)
								spawn(7)if(O)del(O)
								if(M) step(M,src.dir)
								if(M) M.dir = get_dir(M,src)
								if(M) M.DealDamage((J.damage+round((src.ninjutsu / 150)*2*J.damage))/4,src,"NinBlue")
								sleep(1)
							M.ftgmarked = 0
					src.icon_state = ""
					src.move=1
					src.injutsu=0
					src.firing=0
					src.canattack=1

		Flying_Thunder_God()
			for(var/obj/Jutsus/Flying_Thunder_God/J in src.jutsus)
				var/mob/c_target=src.Target_Get(TARGET_MOB)
				var/obj/ftgkunai= src.ftgkunai
				if(!ftgkunai)
					src<<output("You can only teleport to your kunai!","Action.Output")
					return
				if(src.PreJutsu(J))
					if(loc.loc:Safe!=1) src.LevelStat("Ninjutsu",((J.maxcooltime*3/10)*jutsustatexp))
					if(J.level<4) if(loc.loc:Safe!=1) J.exp+=jutsumastery*(J.maxcooltime/20); J.Levelup()
					flick("jutsuse",src)
					src.PlayAudio('dash.wav', output = AUDIO_HEARERS)
					src.firing=1
					src.canattack=0
					src.move=0
					if(J.level==1) J.damage=2
					if(J.level==2) J.damage=4
					if(J.level==3) J.damage=6
					if(J.level==4) J.damage=8
					if(c_target&&c_target.ftgmarked==1)
						//if(c_target.opponent) return
						flick('Flyingthunder.dmi',src)
						spawn(1)
							src.loc = c_target.loc
							step(src,c_target.dir)
							src.dir = get_dir(src,c_target)
							c_target.ftgmarked=0
							ftgkunai.linkfollow(null)
							src.ftgkunai=null
					else if(ftgkunai)
						flick('Flyingthunder.dmi',src)
						src.loc = ftgkunai.loc
						ftgkunai.loc=null
						src.ftgkunai=null

					src.move=0
					spawn(3)
						src.firing=0
						src.move=1
						src.canattack=1

		Flying_Thunder_God_Great_Escape()
			for(var/obj/Jutsus/Flying_Thunder_God_Great_Escape/J in src.jutsus)
				if(src.PreJutsu(J))
					if(loc.loc:Safe!=1) src.LevelStat("Ninjutsu",((J.maxcooltime*3/10)*jutsustatexp))
					if(J.level<4) if(loc.loc:Safe!=1) J.exp+=jutsumastery*(J.maxcooltime/20); J.Levelup()
					var/obj/T= new(src.loc)
					spawn(200)T.loc = null
					T.icon='YellowFlashKunai.dmi'
					T.icon_state="ground"
					src<<output("You will be sent to this location the next time your character accumulates damage in the next 20 seconds!.","Action.Output")
					var/lasthp = src.health
					while(src.health >= lasthp)
						lasthp = src.health
						sleep(1)
					if(get_dist(usr,T)>50||usr.z != T.z)
						usr<<"\red <b>Your substitution was set too far away. Jutsu failed!"
						T.loc = null
						return
					if(T)
						flick('Flyingthunder.dmi',src)
						sleep(1)
						for(var/mob/M in oview(src,13))M.Target_Remove()
						src.loc = T.loc
						T.loc = null