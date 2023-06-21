mob
	proc
		InsectClone()
			if(clonesturned==1)
				return
			for(var/obj/Jutsus/Insect_Clone/J in src.jutsus)
				if(src.PreJutsu(J))
					src.CloneHandler()
					src.PlayAudio('bugs.wav', output = AUDIO_HEARERS)
					if(src.loc.loc:Safe!=1) src.LevelStat("Ninjutsu",((J.maxcooltime*3/20)*jutsustatexp))
					if(src.loc.loc:Safe!=1) src.LevelStat("Genjutsu",((J.maxcooltime*3/20)*jutsustatexp))
					if(J.level==1) J.damage=((jutsudamage*J.Sprice)/2)
					if(J.level==2) J.damage=((jutsudamage*J.Sprice)/1.5)
					if(J.level==3) J.damage=((jutsudamage*J.Sprice)/1.25)
					if(J.level==4) J.damage=(jutsudamage*J.Sprice)
					if(J.level<4)
						if(loc.loc:Safe!=1)
							J.exp+=jutsumastery*(J.maxcooltime/20)
							J.Levelup()
					flick("jutsu",src)
					var/number_of_clones = round((J.level/2) + (src.ninjutsu_total / 100))
					if(src.Specialist == SPECIALIZATION_GENJUTSU) number_of_clones++
					var/i
					for(i=0, i<number_of_clones, i++)
						var/mob/Clones/BugBunshin/A = new/mob/Clones/BugBunshin(src.loc)
						A.loc=src.loc
						A.Owner=src
						A.icon='Insect clone.dmi'
						A.ninjutsu=round((src.ninjutsu_total / 450)*2*J.damage)
						A.genjutsu=round((src.genjutsu_total / 450)*2*J.damage)
						A.defence=round(src.ninjutsu_total)
						A.health=round(src.ninjutsu_total)
						A.maxhealth=round(src.ninjutsu_total)
						A.agility=round(src.ninjutsu_total)
						var/obj/O=new /obj/Screen/healthbar/
						var/obj/M=new /obj/Screen/manabar/
						A.hbar.Add(O)
						A.hbar.Add(M)
						spawn(3)if(src)if(A)A.icon ='Insect clone.dmi'
						A.overlays-=/obj/Screen/healthbar
						A.overlays-=/obj/Screen/manabar
						for(var/obj/Screen/healthbar/HB in A.hbar)A.overlays+=HB
						for(var/obj/Screen/manabar/HB in A.hbar)A.overlays+=HB
						A.UpdateHMB()

		Bug_Neurotoxin()
			for(var/obj/Jutsus/Bug_Neurotoxin/J in src.jutsus)
				var/mob/c_target=src.Target_Get(TARGET_MOB)
				if(!c_target || c_target.sbugged==0)
					src << output("This jutsu requires a target that is under the effect of stealth bug.","Action.Output")
					return
				if(src.PreJutsu(J))
					if(loc.loc:Safe!=1) src.LevelStat("Ninjutsu",((J.maxcooltime*3/10)*jutsustatexp))
					if(J.level<4)
						if(loc.loc:Safe!=1)
							J.exp+=jutsumastery*(J.maxcooltime/20)
							J.Levelup()
					flick("groundjutsu",src)
					if(c_target)
						if(c_target.sbugged)
							var/obj/O = new/obj
							O.loc = c_target.loc
							src.PlayAudio('bugs.wav', output = AUDIO_HEARERS)
							O.icon = 'Neurotoxin Bug.dmi'
							O.pixel_x=-48
							O.pixel_y=-32
							flick("grab",O)
							O.icon_state = "grabbed"
							var/bind_time = 2+(J.level*2)
							var/visual_time = bind_time - (bind_time/100)*c_target.tenacity
							Bind(c_target, bind_time, src)
							spawn(visual_time)
								if(O)del(O)

		Insect_Cocoon()
			for(var/obj/Jutsus/Insect_Cocoon/J in src.jutsus)
				if(bugpass)
					src<<output("You shut down your insect Cocoon.","Action.Output")
					src.bugpass=0
					return
				if(src.PreJutsu(J))
					if(loc.loc:Safe!=1) src.LevelStat("Ninjutsu",((J.maxcooltime*3/10)/2*jutsustatexp))
					src.bugpass=1
					src<<output("You turn on your insect Cocoon.","Action.Output")
					while(bugpass&&chakra>0)
						sleep(10)
					src<<output("You shut down your insect Cocoon.","Action.Output")
					src.bugpass=0

		Stealth_Bug()
			for(var/obj/Jutsus/Stealth_Bug/J in src.jutsus)
				var/mob/c_target=src.Target_Get(TARGET_MOB)
				if(!c_target)
					src<<output("You require a targeted player to use this technique.","Action.Output")
					return
				if(src.PreJutsu(J))
					if(loc.loc:Safe!=1) src.LevelStat("Ninjutsu",((J.maxcooltime*3/10)*jutsustatexp))
					if(J.level==1) J.damage=0.02*((jutsudamage*J.Sprice)/2)
					if(J.level==2) J.damage=0.02*((jutsudamage*J.Sprice)/1.5)
					if(J.level==3) J.damage=0.02*((jutsudamage*J.Sprice)/1.25)
					if(J.level==4) J.damage=0.02*(jutsudamage*J.Sprice)
					if(J.level<4) if(loc.loc:Safe!=1) J.exp+=jutsumastery*(J.maxcooltime/20); J.Levelup()
					src.PlayAudio('bugs.wav', output = AUDIO_HEARERS)
					var/obj/O = new(c_target.loc)
					O.IsJutsuEffect=src
					O.icon='stealth bug.dmi'
					O.layer=MOB_LAYER+1
					O.pixel_x=-16
					O.name="Stealth Bugs"
					var/Timer=J.level*10
					walk_to(O,c_target)
					while(Timer&&c_target&&!c_target.dead)
						Timer--
						var/area/A=c_target.loc.loc
						if(A.Safe) break
						c_target.sbugged=1
						c_target.DealDamage(J.damage+round((src.ninjutsu_total / 200)*2*J.damage),src,"NinBlue")
						sleep(4)
					del(O)
					if(c_target)c_target.sbugged=0

		Hunter_Scarabs()
			for(var/obj/Jutsus/Hunter_Scarabs/J in src.jutsus)
				if(src.PreJutsu(J))
					var/mob/c_target=src.Target_Get(TARGET_MOB)
					if(loc.loc:Safe!=1) src.LevelStat("Ninjutsu",((J.maxcooltime*3/10)*jutsustatexp))
					if(J.level==1) J.damage=0.1*((jutsudamage*J.Sprice)/2)
					if(J.level==2) J.damage=0.1*((jutsudamage*J.Sprice)/1.5)
					if(J.level==3) J.damage=0.1*((jutsudamage*J.Sprice)/1.25)
					if(J.level==4) J.damage=0.1*(jutsudamage*J.Sprice)
					flick("throw",src)
					src.PlayAudio('dash.wav', output = AUDIO_HEARERS)
					AddState(src, new/state/cant_attack, 5)
					if(J.level<4) if(loc.loc:Safe!=1) J.exp+=jutsumastery*(J.maxcooltime/20); J.Levelup()
					var/num=J.level*2+round(src.ninjutsu_total/30)
					if(c_target)
						while(num)
							sleep(1)
							num--
							src.dir=get_dir(src,c_target)
							var/obj/Projectiles/Effects/HunterScarab/A = new/obj/Projectiles/Effects/HunterScarab(src.loc)
							A.IsJutsuEffect=src
							if(prob(50))A.y+=1
							else A.y-=1
							if(prob(50))A.x+=1
							else A.x-=1
							A.level=J.level
							A.Owner=src
							A.layer=src.layer
							A.fightlayer=src.fightlayer
							A.damage=J.damage+round((src.ninjutsu_total / 200)*2*J.damage)
							A.dir = get_dir(A,c_target)
							walk_towards(A,c_target.loc,3)
							spawn(25)if(A)walk(A,A.dir,3)
					else
						while(num)
							sleep(1)
							num--
							var/obj/Projectiles/Effects/HunterScarab/A = new/obj/Projectiles/Effects/HunterScarab(src.loc)
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
							A.damage=J.damage+round((src.ninjutsu_total / 200)*2*J.damage)
							A.dir = src.dir
							if(A)walk(A,A.dir,3)

		Destruction_Bug_Swarm()
			for(var/obj/Jutsus/Destruction_Bug_Swarm/J in src.jutsus)
				if(src.PreJutsu(J))
					var/mob/c_target=src.Target_Get(TARGET_MOB)
					if(loc.loc:Safe!=1) src.LevelStat("Ninjutsu",((J.maxcooltime*3/10)*jutsustatexp))
					flick("2fist",src)
					src.PlayAudio('bugs.wav', output = AUDIO_HEARERS)
					AddState(src, new/state/cant_attack, 15)
					if(J.level==1) J.damage=((jutsudamage*J.Sprice)/2)/10
					if(J.level==2) J.damage=((jutsudamage*J.Sprice)/1.5)/10
					if(J.level==3) J.damage=((jutsudamage*J.Sprice)/1.25)/10
					if(J.level==4) J.damage=(jutsudamage*J.Sprice)/10
					if(J.level<4) if(loc.loc:Safe!=1) J.exp+=jutsumastery*(J.maxcooltime/20); J.Levelup()
					if(c_target)
						src.dir=get_dir(src,c_target)
						var/obj/Projectiles/Effects/Bug_Swarm/A = new/obj/Projectiles/Effects/Bug_Swarm(src.loc)
						A.IsJutsuEffect=src
						A.Owner=src
						A.layer=src.layer
						A.fightlayer=src.fightlayer
						A.damage=J.damage+round((src.ninjutsu_total / 200)*2*J.damage)
						A.level=J.level
						walk_towards(A,c_target.loc,0)
						spawn(4)if(A)walk(A,A.dir)
					else
						var/obj/Projectiles/Effects/Bug_Swarm/A = new/obj/Projectiles/Effects/Bug_Swarm(src.loc)
						A.IsJutsuEffect=src
						A.Owner=src
						A.layer=src.layer
						A.fightlayer=src.fightlayer
						A.damage=J.damage+round((src.ninjutsu_total / 200)*2*J.damage)
						A.level=J.level
						walk(A,src.dir)

		BugTornado()
			for(var/obj/Jutsus/BugTornado/J in src.jutsus)
				if(src.PreJutsu(J))
					var/mob/c_target=src.Target_Get(TARGET_MOB)
					if(loc.loc:Safe!=1) src.LevelStat("Ninjutsu",((J.maxcooltime*3/10)*jutsustatexp))
					flick("throw",src)
					src.PlayAudio('dash.wav', output = AUDIO_HEARERS)
					Bind(src, 5)
					if(J.level==1) J.damage=0.15*((jutsudamage*J.Sprice)/2)
					if(J.level==2) J.damage=0.15*((jutsudamage*J.Sprice)/1.5)
					if(J.level==3) J.damage=0.15*((jutsudamage*J.Sprice)/1.25)
					if(J.level==4) J.damage=0.15*(jutsudamage*J.Sprice)
					if(J.level<4) if(loc.loc:Safe!=1) J.exp+=jutsumastery*(J.maxcooltime/20); J.Levelup()
					if(c_target)
						src.dir=get_dir(src,c_target)
						var/obj/Projectiles/Effects/BugTornado/A = new/obj/Projectiles/Effects/BugTornado(src.loc)
						A.IsJutsuEffect=src
						A.level=J.level
						A.Owner=src
						A.layer=src.layer
						A.fightlayer=src.fightlayer
						A.damage=J.damage+round((src.ninjutsu_total / 200)*2*J.damage)
						A.dir = get_dir(A,c_target)
						walk_towards(A,c_target.loc,2)
					else
						var/obj/Projectiles/Effects/BugTornado/A = new/obj/Projectiles/Effects/BugTornado(src.loc)
						A.IsJutsuEffect=src
						if(A.loc == src.loc)A.loc = get_step(src,src.dir)
						A.level=J.level
						A.Owner=src
						A.layer=src.layer
						A.fightlayer=src.fightlayer
						A.damage=J.damage+round((src.ninjutsu_total / 200)*2*J.damage)
						A.dir = src.dir
						spawn(20)if(A)walk(A,A.dir,3)