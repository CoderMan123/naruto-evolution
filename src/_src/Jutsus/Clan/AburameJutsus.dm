mob
	proc
		InsectClone()
			if(clonesturned==1)
				return
			if(src.firing==0&&src.canattack==1)
				for(var/obj/Jutsus/Insect_Clone/J in src.jutsus)
					if(src.PreJutsu(J))
						src.CloneHandler()
						view(src)<<sound('bugs.wav',0,0)
						if(src.loc.loc:Safe!=1) src.LevelStat("Genjutsu",rand(7,10))
						for(var/mob/M in oview(src,13))M.Target_Remove()
						src.mizubunshin++
						var/bun=src.mizubunshin+3
						src.DealDamage((src.health/bun),src,"white")
						src.chakra-=round(src.chakra/bun)
						flick("jutsu",src)
						var/mob/Clones/BugBunshin/A = new/mob/Clones/BugBunshin(src.loc)
						A.loc=src.loc
						A.Owner=src
						A.icon=src.icon
						A.overlays=src.overlays
						A.strength=round(src.strength/bun)
						A.defence=round(src.defence/bun)
						A.health=round(src.health/bun)
						A.maxhealth=round(src.health/bun)
						A.agility=round(src.agility/bun)
						var/obj/O=new /obj/Screen/healthbar/
						var/obj/M=new /obj/Screen/manabar/
						A.hbar.Add(O)
						A.hbar.Add(M)
						spawn(3)if(src)if(A)A.icon = src.icon
						A.overlays-=/obj/Screen/healthbar
						A.overlays-=/obj/Screen/manabar
						for(var/obj/Screen/healthbar/HB in A.hbar)A.overlays+=HB
						for(var/obj/Screen/manabar/HB in A.hbar)A.overlays+=HB
						A.UpdateHMB()
		Bug_Neurotoxin()
			for(var/obj/Jutsus/Bug_Neurotoxin/J in src.jutsus)
				if(src.firing)return
				var/mob/c_target=src.Target_Get(TARGET_MOB)
				if(!c_target || c_target.sbugged==0)
					src << output("This jutsu requires a target that is under the effect of stealth bug.","Action.Output")
					return
				if(src.PreJutsu(J))
					if(loc.loc:Safe!=1) src.LevelStat("Ninjutsu",rand(3,5))
					if(J.level<4)
						if(loc.loc:Safe!=1)
							J.exp+=rand(2,5)
							J.Levelup()
					flick("groundjutsu",src)
					if(c_target)
						if(c_target.sbugged)
							var/obj/O = new/obj
							O.loc = c_target.loc
							view(src)<<sound('bugs.wav',0,0)
							O.icon = 'Neurotoxin Bug.dmi'
							O.pixel_x=-48
							O.pixel_y=-32
							flick("grab",O)
							O.icon_state = "grabbed"
							c_target.move=0
							c_target.injutsu=1
							c_target.canattack=0
							spawn(25+(J.level*3))
								if(c_target)
									c_target.move=1
									c_target.injutsu=0
									c_target.canattack=1
								if(O)del(O)
		Insect_Cocoon()
			for(var/obj/Jutsus/Insect_Cocoon/J in src.jutsus)
				if(bugpass)
					src<<output("You shut down your insect Cocoon.","Action.Output")
					src.bugpass=0
					return
				if(src.PreJutsu(J))
					if(loc.loc:Safe!=1) src.LevelStat("Ninjutsu",rand(3,5))
					src.bugpass=1
					src<<output("You turn on your insect Cocoon.","Action.Output")
					while(bugpass&&chakra>0)
						DealDamage(10,src,"aliceblue",0,1)
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
					if(loc.loc:Safe!=1) src.LevelStat("Ninjutsu",rand(5,7))
					if(J.level<4) if(loc.loc:Safe!=1) J.exp+=rand(2,5); J.Levelup()
					view()<<sound('bugs.wav')
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
						c_target.DealDamage(round(src.ninjutsu/13),src,"NinBlue")
						sleep(2)
					del(O)
					if(c_target)c_target.sbugged=0

		Hunter_Scarabs()
			for(var/obj/Jutsus/Hunter_Scarabs/J in src.jutsus)
				if(src.PreJutsu(J))
					var/mob/c_target=src.Target_Get(TARGET_MOB)
					if(loc.loc:Safe!=1) src.LevelStat("Ninjutsu",rand(3,5))
					flick("throw",src)
					view(src)<<sound('dash.wav',0,0)
					src.firing=1
					src.canattack=0
					if(J.level==1) J.damage=5
					if(J.level==2) J.damage=8
					if(J.level==3) J.damage=14
					if(J.level==4) J.damage=20
					if(J.level<6) if(loc.loc:Safe!=1) J.exp+=rand(2,5); J.Levelup()
					var/num=J.level*2+(round(src.strength/23)+round(src.ninjutsu/23))
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
							A.damage=J.damage+round(src.ninjutsu/10+src.strength/5)
							A.dir = get_dir(A,c_target)
							walk_towards(A,c_target.loc,5)
							spawn(25)if(A)walk(A,A.dir,5)
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
							A.damage=J.damage+round(src.ninjutsu/10+src.strength/5)
							A.dir = src.dir
							if(A)walk(A,A.dir,5)
					spawn(5)
						src.firing=0
						src.canattack=1

		Destruction_Bug_Swarm()
			for(var/obj/Jutsus/Destruction_Bug_Swarm/J in src.jutsus)
				if(src.PreJutsu(J))
					var/mob/c_target=src.Target_Get(TARGET_MOB)
					if(loc.loc:Safe!=1) src.LevelStat("Ninjutsu",rand(5,7))
					flick("2fist",src)
					view(src)<<sound('bugs.wav',0,0)
					src.firing=1
					src.canattack=0
					if(J.level==1) J.damage=4
					if(J.level==2) J.damage=8
					if(J.level==3) J.damage=12
					if(J.level==4) J.damage=16
					if(J.level<4) if(loc.loc:Safe!=1) J.exp+=rand(5,15); J.Levelup()
					if(c_target)
						src.dir=get_dir(src,c_target)
						var/obj/Projectiles/Effects/Bug_Swarm/A = new/obj/Projectiles/Effects/Bug_Swarm(src.loc)
						A.IsJutsuEffect=src
						A.Owner=src
						A.layer=src.layer
						A.fightlayer=src.fightlayer
						A.damage=J.damage+round(src.ninjutsu/10)
						A.level=J.level
						walk_towards(A,c_target.loc,0)
						spawn(4)if(A)walk(A,A.dir)
					else
						var/obj/Projectiles/Effects/Bug_Swarm/A = new/obj/Projectiles/Effects/Bug_Swarm(src.loc)
						A.IsJutsuEffect=src
						A.Owner=src
						A.layer=src.layer
						A.fightlayer=src.fightlayer
						A.damage=J.damage+round(src.ninjutsu/20)
						A.level=J.level
						walk(A,src.dir)
					spawn(20)if(src)
						src.firing=0
						src.canattack=1
		BugTornado()
			for(var/obj/Jutsus/BugTornado/J in src.jutsus)
				if(src.PreJutsu(J))
					var/mob/c_target=src.Target_Get(TARGET_MOB)
					if(loc.loc:Safe!=1) src.LevelStat("Ninjutsu",rand(7,11))
					flick("throw",src)
					view(src)<<sound('dash.wav',0,0)
					src.firing=1
					src.canattack=0
					if(J.level==1) J.damage=40
					if(J.level==2) J.damage=60
					if(J.level==3) J.damage=80
					if(J.level==4) J.damage=100
					if(J.level<4) if(loc.loc:Safe!=1) J.exp+=rand(2,5); J.Levelup()
					if(c_target)
						src.dir=get_dir(src,c_target)
						var/obj/Projectiles/Effects/BugTornado/A = new/obj/Projectiles/Effects/BugTornado(src.loc)
						A.IsJutsuEffect=src
						A.level=J.level
						A.Owner=src
						A.layer=src.layer
						A.fightlayer=src.fightlayer
						A.damage=J.damage+round(src.ninjutsu*1.3+src.strength*1.3)
						A.dir = get_dir(A,c_target)
						walk_towards(A,c_target.loc,5)
						spawn(20)if(A)walk(A,A.dir,5)
					else
						var/obj/Projectiles/Effects/BugTornado/A = new/obj/Projectiles/Effects/BugTornado(src.loc)
						A.IsJutsuEffect=src
						if(A.loc == src.loc)A.loc = get_step(src,src.dir)
						A.level=J.level
						A.Owner=src
						A.layer=src.layer
						A.fightlayer=src.fightlayer
						A.damage=J.damage+round(src.ninjutsu*1.3+src.strength*1.3)
						A.dir = src.dir
						spawn(20)if(A)walk(A,A.dir,5)
					spawn(5)
						src.firing=0
						src.canattack=1