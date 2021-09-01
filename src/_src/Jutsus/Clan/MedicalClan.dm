mob
	proc
		Mystical_Palms()
			for(var/obj/Jutsus/Mystical_Palms/J in src.jutsus)
				if(mystical_palms)
					src<<output("You deactivate your mystical palms.","Action.Output")
					src.mystical_palms=0
					return
				if(src.PreJutsu(J))
					if(loc.loc:Safe!=1) src.LevelStat("Ninjutsu",((J.maxcooltime*3/10)*jutsustatexp))
					if(J.level<4) if(loc.loc:Safe!=1) J.exp+=jutsumastery*(J.maxcooltime/20); J.Levelup()
					src.mystical_palms=1
					src<<output("You activate mystical palms.","Action.Output")
					while(mystical_palms&&chakra>0)
						DealDamage(5,src,"aliceblue",0,1)
						sleep(10)
					src<<output("You deactivate your mystical palms.","Action.Output")
					src.mystical_palms=0

		Ones_Own_Life_Reincarnation()
			for(var/obj/Jutsus/Ones_Own_Life_Reincarnation/J in src.jutsus)
				if(src.PreJutsu(J))
					if(loc.loc:Safe!=1) src.LevelStat("Ninjutsu",((J.maxcooltime*3/10)*jutsustatexp))
					if(J.level<4) if(loc.loc:Safe!=1) J.exp+=jutsumastery*(J.maxcooltime/20); J.Levelup()
					src.move=0
					src.canattack=0
					src.injutsu=1
					src.firing=1
					flick("groundjutsu",src)
					src.icon_state = "groundjutsuse"
					for(var/mob/M in src.loc)
						if(M.icon_state == "dead" && M.client && M.dead)
							M.revived=1
							M.dead=0
							M.density=1
							M.health=M.maxhealth
							M.chakra=M.maxchakra
							M.injutsu=0
							M.canattack=1
							M.firing=0
							M.icon_state=""
							M.wait=0
							M.rest=0
							M.dodge=0
							M.move=1
							M.swimming=0
							M.walkingonwater=0
							M.overlays=0
							M.RestoreOverlays()
							M.UpdateHMB()
							spawn(1)M.Run()
							src.DealDamage(src.health + 1,src,"maroon")
							//src.health=0-1
							//src.Death(M)
							spawn(600)if(M)if(M.revived)M.revived=0
					spawn(5)if(src)
						src.icon_state = ""
						src.move=1
						src.canattack=1
						src.injutsu=0
						src.firing=0

		Poison_Mist()
			for(var/obj/Jutsus/Poison_Mist/J in src.jutsus)
				if(src.PreJutsu(J))
					if(loc.loc:Safe!=1) src.LevelStat("Ninjutsu",((J.maxcooltime*3/10)*jutsustatexp))
					if(J.level<4) if(loc.loc:Safe!=1) J.exp+=jutsumastery*(J.maxcooltime/20); J.Levelup()
					var/mob/c_target=src.Target_Get(TARGET_MOB)
					if(c_target)
						src.dir = get_dir(src,c_target)
					src.icon_state = "jutsuse"
					var/obj/PoisonMist/O=new(src)
					O.Owner = src
					O.Ownzorz=src
					O.IsJutsuEffect=src
					spawn(1)src.icon_state = ""

		Heal()
			for(var/obj/Jutsus/Heal/J in src.jutsus)
				if(src.PreJutsu(J))
					if(loc.loc:Safe!=1) src.LevelStat("Ninjutsu",((J.maxcooltime*3/10)*jutsustatexp))
					if(J.level<4) if(loc.loc:Safe!=1) J.exp+=jutsumastery*(J.maxcooltime/20); J.Levelup()
					if(J.level==1) J.damage=10
					if(J.level==2) J.damage=8
					if(J.level==3) J.damage=6
					if(J.level==4) J.damage=4
					var/mob/c_target=src.Target_Get(TARGET_MOB)
					var/mob/Z
					var/check=0
					src.move=0
					src.injutsu=1
					src.firing=1
					src.canattack=0
					src.icon_state = "jutsuse"
					sleep(5)
					if(c_target)
						c_target.dir = get_dir(c_target,src)
						flick('Shunshin.dmi',src)
						loc = c_target.loc
						step(src,c_target.dir)
						dir = get_dir(src,c_target)
						sleep(2)
					for(var/mob/M in get_step(src,src.dir))
						Z=M
						check=1
					if(check==0)Z=src
					if(Z && !istype(Z, /mob/npc/combat/political_escort))
						Z.DealDamage(Z.maxhealth/J.damage*(src.ninjutsu/150*1.5),src,"HealGreen",1)
						Z.overlays += 'Healing.dmi'
						src.icon_state = "punchrS"
						spawn(5)
							Z.overlays -= 'Healing.dmi'
							src.icon_state = ""
					else if(istype(Z, /mob/npc/combat/political_escort))
						Z.DealDamage((Z.maxhealth/J.damage*(src.ninjutsu/150*1.5))/2,src,"HealGreen",1)
						Z.overlays += 'Healing.dmi'
						src.icon_state = "punchrS"
						spawn(5)
							Z.overlays -= 'Healing.dmi'
							src.icon_state = ""
					src.move=1
					src.injutsu=0
					src.firing=0
					src.canattack=1

		Cherry_Blossom_Impact()
			for(var/obj/Jutsus/Cherry_Blossom_Impact/J in src.jutsus)
				if(src.PreJutsu(J))
					if(loc.loc:Safe!=1) src.LevelStat("Ninjutsu",((J.maxcooltime*3/10)*jutsustatexp))
					if(J.level<4) if(loc.loc:Safe!=1) J.exp+=jutsumastery*(J.maxcooltime/20); J.Levelup()
					if(src.COW<J.level*3)src.COW++
					src<<output("You precisely charge chakra to your hands, and now have stocked [src.COW] punches.","Action.Output")