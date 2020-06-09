mob
	proc
		Shikigami_Dance()
			for(var/obj/Jutsus/Shikigami_Dance/J in src.JutsusLearnt)
				var/mob/player/c_target=usr.Target_Get(TARGET_MOB)
				if(!c_target)
					src<<output("You must have a target to use this technique.","actionoutput")
					return
				if(src.PreJutsu(J))
					if(loc.loc:Safe!=1) src.LevelStat("Ninjutsu",rand(5,10))
					flick("jutsuse",src)
					view(src)<<sound('wirlwind.wav',0,0)
					src.move=0
					src.canattack=0
					src.injutsu=1
					src.firing=1
					src.Prisoner=c_target
					if(J.level==1) J.damage=src.ninjutsu*0.1
					if(J.level==2) J.damage=src.ninjutsu*0.2
					if(J.level==3) J.damage=src.ninjutsu*0.3
					if(J.level==4) J.damage=src.ninjutsu*0.5
					if(J.level<4) if(loc.loc:Safe!=1) J.exp+=rand(2,5); J.Levelup()
					var/Timer = J.level * 1.5
					if(src.inAngel==1) Timer *= 1.5
					Timer = ceil(Timer)
					c_target.move=0
					c_target.canattack=0
					c_target.injutsu=1
					c_target.overlays+='Shikigami Dance.dmi'

					sleep(10)
					src.move=1
					src.canattack=1
					src.injutsu=0
					src.firing=0

					while(Timer&&c_target&&src)
						sleep(5)
						Timer--
						c_target.DealDamage(J.damage,src,"NinBlue")
					if(c_target)
						c_target.move=1
						c_target.canattack=1
						c_target.injutsu=0
						c_target.firing=0
						c_target.overlays-='Shikigami Dance.dmi'

		Paper_Chakram()
			for(var/obj/Jutsus/Paper_Chakram/J in src.JutsusLearnt)
				if(src.PreJutsu(J))
					var/mob/c_target=src.Target_Get(TARGET_MOB)
					if(loc.loc:Safe!=1) src.LevelStat("Ninjutsu",2,5)
					flick("throw",src)
					view(src)<<sound('083.wav',0,0)
					src.firing=1
					src.canattack=0
					if(J.level==1) J.damage=1
					if(J.level==2) J.damage=3
					if(J.level==3) J.damage=6
					if(J.level==4) J.damage=10
					if(J.level<4) if(loc.loc:Safe!=1) J.exp+=rand(5,7); J.Levelup()
					if(c_target)
						src.dir=get_dir(src,c_target)
						var/obj/Projectiles/Effects/Paper_Chakram/A = new/obj/Projectiles/Effects/Paper_Chakram(src.loc)
						A.IsJutsuEffect=src
						A.Owner=src
						A.layer=src.layer
						A.fightlayer=src.fightlayer
						A.damage=J.damage
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
					spawn(1)
						src.firing=0
						src.canattack=1

		Shikigami_Spear()
			for(var/obj/Jutsus/Shikigami_Spear/J in src.JutsusLearnt)
				if(src.PreJutsu(J))
					var/mob/c_target=src.Target_Get(TARGET_MOB)
					if(loc.loc:Safe!=1) src.LevelStat("Ninjutsu",rand(5,7))
					if(J.level<4) if(loc.loc:Safe!=1) J.exp+=rand(2,5); J.Levelup()
					view(src)<<sound('wirlwind.wav',0,0)
					flick("2fist",src)
					src.firing=1
					src.canattack=0
					src.move=0
					J.damage=J.level*3
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
					A.damage=J.damage*(round(src.agility*0.3)+round(src.ninjutsu*0.7))
					A.level=J.level
					walk(A,dir,0)
					if(src.inAngel==1)
						src.firing=0
						src.canattack=1
						src.move=1
					else
						spawn(20)
							src.firing=0
							src.canattack=1
							src.move=1
					icon_state=""
					Aa.dir = src.dir

		Angel_Wings()
			if(firing)return
			if(src.firing==0 && src.canattack==1)
				for(var/obj/Jutsus/Angel_Wings/J in src.JutsusLearnt)
					if(src.PreJutsu(J))
						if(loc.loc:Safe!=1) src.LevelStat("Ninjutsu",rand(7,11))
						J.Excluded=1
						src.underlays+='Angel Wings.dmi'
						src.inAngel=1
						spawn(150)
							src.inAngel=0
							src.underlays-='Angel Wings.dmi'
							src<<"Angel mode goes off."

