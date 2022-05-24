mob
	proc
//		JukaiKoutan()
//			for(var/obj/Jutsus/JukaiKoutan/J in src.jutsus)//leaving this here incase I want to use it later

		JubakuEisou()
			for(var/obj/Jutsus/JubakuEisou/J in src.jutsus)
				var/mob/c_target=src.Target_Get(TARGET_MOB)
				if(!c_target)
					src << output("This jutsu requires a target","Action.Output")
					return
				if(src.PreJutsu(J))

					if(loc.loc:Safe!=1) src.LevelStat("Ninjutsu",rand(1,2))
					flick("jutsuse",src)
					src.firing=1
					src.canattack=0
					var/TimeAsleep
					if(J.level==1) TimeAsleep=25
					if(J.level==2) TimeAsleep=50
					if(J.level==3) TimeAsleep=75
					if(J.level==4) TimeAsleep=100
					if(J.level<4) if(loc.loc:Safe!=1) J.exp+=rand(2,6); J.Levelup()
					var/mob/M = c_target
					if(M)
						var/turf/T=M.loc
						spawn(10)
							if(M&&T)
								if(T==M.loc)
									var/obj/A = new/obj/Jukai
									A.IsJutsuEffect=src
									A.Owner=src
									A.layer=src.layer
									A.fightlayer=src.fightlayer
									A.damage=J.damage
									A.level=J.level
									A.loc=M.loc
									flick("create",A)
									M.move=0
									M.injutsu=1
									M.canattack=0
									M.Sleeping=1
									spawn(TimeAsleep)
										if(!M||M.dead)continue
										M.move=1
										M.injutsu=0
										M.canattack=1
										M.Sleeping=0
								else src<<output("The jutsu did not connect.","Action.Output")
					src.firing=0
					src.canattack=1

		Daijurin()
			for(var/obj/Jutsus/Daijurin/J in src.jutsus)
				if(src.PreJutsu(J))
					if(loc.loc:Safe!=1) src.LevelStat("Ninjutsu",0.2)
					flick("jutsuse",src)
					icon_state="punchrS"
					var/obj/A = new/obj/daijurin(src.loc)
					A.IsJutsuEffect=src
					A.Owner=src
					A.layer=src.layer
					A.fightlayer=src.fightlayer
					A.damage=J.damage
					A.level=J.level
					A.dir=src.dir
					if(A.dir==WEST||A.dir==EAST)A.pixel_y=-52
					walk(A,src.dir)
					src.firing=1
					src.canattack=0
					spawn(1)
						src.firing=0
						src.canattack=1
					if(J.level<4) if(loc.loc:Safe!=1) J.exp+=rand(3,7); J.Levelup()
		Tree_Summoning()
			for(var/obj/Jutsus/Tree_Summoning/J in src.jutsus)
				var/mob/c_target=src.Target_Get(TARGET_MOB)
				if(!c_target)
					src << output("This jutsu requires a target","Action.Output")
					return
				if(src.PreJutsu(J))
					if(loc.loc:Safe!=1) src.LevelStat("Ninjutsu",((J.maxcooltime*3/10)*jutsustatexp))
					flick("groundjutsu",src)
					src.firing=1
					src.canattack=0
					spawn(5)
						src.firing=0
						src.canattack=1
					if(J.level==1) J.damage=0.5*((jutsudamage*J.Sprice)/2.5)
					if(J.level==2) J.damage=0.5*((jutsudamage*J.Sprice)/2)
					if(J.level==3) J.damage=0.5*((jutsudamage*J.Sprice)/1.5)
					if(J.level==4) J.damage=0.5*(jutsudamage*J.Sprice)
					if(J.level<4) if(loc.loc:Safe!=1) J.exp+=jutsumastery*(J.maxcooltime/20); J.Levelup()
					for(var/turf/T in view(c_target,5))
						if(T)
							if(prob(15))
								var/obj/Ground/Trees/MTree1/B2/A=new(c_target.loc)
								spawn(100) del A
								A.layer=MOB_LAYER
								A.IsJutsuEffect=src
								A.Owner=src
								A.layer=src.layer
								A.fightlayer=src.fightlayer
								A.damage=J.damage
								A.level=J.level
								A.loc=T
								flick("create",A)
								for(var/mob/M in T)
									if(M!=src)
										M.DealDamage(J.damage+round((src.ninjutsu / 150)*2*J.damage),src,"NinBlue")
										spawn() if(M) M.Bleed()
		WoodStyleFortress()
			if(firing)return
			if(src.firing==0 && src.canattack==1)
				for(var/obj/Jutsus/WoodStyleFortress/J in src.jutsus)
					if(src.PreJutsu(J))
						flick("groundjutsu",src)
						if(loc.loc:Safe!=1) src.LevelStat("Ninjutsu",((J.maxcooltime*3/10)*jutsustatexp))
						src.PlayAudio('Skill_MashHit.wav', output = AUDIO_HEARERS)
						src.move=0
						src.firing=1
						src.canattack=0
						if(J.level==1) J.damage=2
						if(J.level==2) J.damage=4
						if(J.level==3) J.damage=6
						if(J.level==4) J.damage=8
						if(J.level<4) if(loc.loc:Safe!=1) J.exp+=jutsumastery*(J.maxcooltime/20); J.Levelup()
						new/obj/WoodStyle/Fortres(locate(src.x-1,src.y-1,src.z))
						new/obj/WoodStyle/Fortres(locate(src.x,src.y-1,src.z))
						new/obj/WoodStyle/Fortres(locate(src.x+1,src.y-1,src.z))
						new/obj/WoodStyle/Fortres(locate(src.x-1,src.y+1,src.z))
						new/obj/WoodStyle/Fortres(locate(src.x,src.y+1,src.z))
						new/obj/WoodStyle/Fortres(locate(src.x+1,src.y+1,src.z))
						new/obj/WoodStyle/Fortres(locate(src.x+1,src.y,src.z))
						new/obj/WoodStyle/Fortres(locate(src.x-1,src.y,src.z))
						src.move=1
						src.firing=0
						src.copy=null
						src.canattack=1
						src.injutsu=0

		Root_Strangle()
			if(src.firing)return
			if(src.firing==0 && src.canattack==1)
				for(var/obj/Jutsus/Root_Strangle/J in src.jutsus)
					var/mob/c_target=src.Target_Get(TARGET_MOB)
					if(src.PreJutsu(J))
						if(loc.loc:Safe!=1) src.LevelStat("Ninjutsu",((J.maxcooltime*3/10)*jutsustatexp))
						if(J.level==1) J.damage=0.8*((jutsudamage*J.Sprice)/2.5)
						if(J.level==2) J.damage=0.8*((jutsudamage*J.Sprice)/2)
						if(J.level==3) J.damage=0.8*((jutsudamage*J.Sprice)/1.5)
						if(J.level==4) J.damage=0.8*(jutsudamage*J.Sprice)
						if(J.level<4) if(loc.loc:Safe!=1) J.exp+=jutsumastery*(J.maxcooltime/20); J.Levelup()
						flick("jutsuse",src)
						src.canattack=0
						src.move=0
						src.firing=1
						flick("punchr",src)
						sleep(3)
						src.icon_state="punchrS"
						src.PlayAudio('fire.wav', output = AUDIO_HEARERS)
						if(c_target)src.dir=get_dir(src,c_target)
						var/obj/Projectiles/Effects/SenjuJinraiHead/A=new(get_step(src,src.dir))
						A.icon = 'WoodDril.dmi'
						A.dir = src.dir
						A.Owner=src
						A.pixel_y=-2
						A.pixel_x=-24
						A.layer=src.layer+2
						A.fightlayer=src.fightlayer
						A.damage=(J.damage+round((src.ninjutsu / 150)*2*J.damage))
						A.level=J.level
						walk(A,dir,0)
						src.firing=0
						src.canattack=1
						src.move=1
						spawn(15)
							src.firing=0
							src.canattack=1

		Wood_Balvan()
			if(firing)return
			if(src.firing==0 && src.canattack==1)
				for(var/obj/Jutsus/Wood_Balvan/J in src.jutsus)
					if(src.PreJutsu(J))
						if(loc.loc:Safe!=1) src.LevelStat("Ninjutsu",((J.maxcooltime*3/20)*jutsustatexp))
						if(loc.loc:Safe!=1) src.LevelStat("Precision",((J.maxcooltime*3/20)*jutsustatexp))
						if(J.level==1) J.damage=((jutsudamage*J.Sprice)/2.5)/2
						if(J.level==2) J.damage=((jutsudamage*J.Sprice)/2)/2
						if(J.level==3) J.damage=((jutsudamage*J.Sprice)/1.5)/2
						if(J.level==4) J.damage=(jutsudamage*J.Sprice)/2
						if(J.level<4) if(loc.loc:Safe!=1) J.exp+=jutsumastery*(J.maxcooltime/20); J.Levelup()
						src.injutsu=1
						flick("jutsuse",src)
						var/obj/O = new/obj/Projectiles/Effects/Balvan
						var/mob/c_target=src.Target_Get(TARGET_MOB)
						O.IsJutsuEffect=src
						O.loc = src.loc
						O.dir = src.dir
						O.Owner = src
						O.damage = (J.damage+round(((src.ninjutsu / 300)+(src.precision / 300))*2*J.damage))
						if(c_target)
							walk_towards(O,c_target)
							spawn(5)if(src)
								walk_towards(O,0)
								walk(O,O.dir)
						else walk(O,src.dir)
						spawn(1)
						src.injutsu=0

		Root_Stab()
			if(src.firing)return
			if(src.firing==0 && src.canattack==1)
				for(var/obj/Jutsus/Root_Stab/J in src.jutsus)
					if(src.PreJutsu(J))
						var/mob/c_target=src.Target_Get(TARGET_MOB)
						if(!c_target)
							src << output("You need a target to use this.","Action.Output")
							return
						if(loc.loc:Safe!=1) src.LevelStat("Ninjutsu",rand(5,7))
						src.move=0
						src.injutsu=1
						if(J.level<4) if(loc.loc:Safe!=1) J.exp+=rand(5,15); J.Levelup()
						src.firing=1
						src.canattack=0
						flick("groundjutsu",src)
						var/obj/senjuu/stab/s=new/obj/senjuu/stab(c_target.loc)
						spawn(1)
							if(c_target.loc==s.loc)
								c_target.move=0
								c_target.DealDamage(src.ninjutsu*J.level,src,"NinBlue")
								c_target.Bleed()
								c_target.PlayAudio('knife_hit1.wav', output = AUDIO_HEARERS)
								spawn(3)
									c_target.move=1
							else
								spawn(3)
									del(s)
						src.copy=null
						src.move=1
						src.firing=0
						src.canattack=1
						src.injutsu=0
