mob
	proc
		Puppet_Dash()
			for(var/obj/Jutsus/Puppet_Dash/J in src.jutsus)
				if(pdash)
					src<<output("You deactivate your puppet dashing.","Action.Output")
					src.pdash=0
					return
				if(src.PreJutsu(J))
					if(loc.loc:Safe!=1) src.LevelStat("Ninjutsu",((J.maxcooltime*3/10)*jutsustatexp))
					src.pdash=1
					src<<output("You activate puppet dashing. Press CTRL+D or ALT+D to dash.","Action.Output")
					while(pdash&&chakra>0)
						DealDamage(20,src,"aliceblue",0,1)
						sleep(10)
					src<<output("You deactivate your puppet dashing.","Action.Output")
					src.pdash=0

		Puppet_Shoot()
			for(var/obj/Jutsus/Puppet_Shoot/J in src.jutsus)
				if(pshoot)
					src<<output("You unload your puppet's knife.","Action.Output")
					src.pshoot=0
					return
				if(src.PreJutsu(J))
					if(loc.loc:Safe!=1) src.LevelStat("Ninjutsu",((J.maxcooltime*3/20)*jutsustatexp))
					if(loc.loc:Safe!=1) src.LevelStat("Precision",((J.maxcooltime*3/20)*jutsustatexp))
					src.pshoot=1
					src<<output("Your puppet loads a knife into it's arms. Press CTRL+A or ALT+A to fire it from the first or second puppet respectively.","Action.Output")

		Puppet_Grab()
			for(var/obj/Jutsus/Puppet_Grab/J in src.jutsus)
				if(pgrab)
					src<<output("Your puppet's arms are unflexed.","Action.Output")
					src.pgrab=0
					return
				if(src.PreJutsu(J))
					if(loc.loc:Safe!=1) src.LevelStat("Ninjutsu",((J.maxcooltime*3/20)*jutsustatexp))
					if(loc.loc:Safe!=1) src.LevelStat("Precision",((J.maxcooltime*3/20)*jutsustatexp))
					src.pgrab=1
					src<<output("Your puppet loosens it's joints, ready to grab a nearby foe. Press CTRL+S or ALT+S to grab a player with the first or second puppet respectively.","Action.Output")

		Puppet_Transform()
			for(var/obj/Jutsus/Puppet_Transform/J in src.jutsus)
				if(src.PreJutsu(J))
					if(loc.loc:Safe!=1) src.LevelStat("Genjutsu",((J.maxcooltime*3/10)*jutsustatexp))
					var/mob/K = src.puppets[1]
					if(K)
						var/obj/O = new/obj
						O.IsJutsuEffect=src
						O.loc = K.loc
						O.icon = 'Smoke.dmi'
						flick("smoke",O)
						spawn(7)if(O)del(O)
						K.icon = src.icon
						K.henged=1
						K.overlays = src.overlays
						K.icon_state = ""
					var/mob/K2 = src.puppets[2]
					if(K2)
						var/obj/O = new/obj
						O.IsJutsuEffect=src
						O.loc = K2.loc
						O.icon = 'Smoke.dmi'
						flick("smoke",O)
						spawn(7)if(O)del(O)
						K2.icon = src.icon
						K2.henged=1
						K2.overlays = src.overlays
						K2.icon_state = ""
					src << output("Your puppets transform into you! Their joints are loose and ready for grabbing.","Action.Output")
					src.pgrab=1
		First_Puppet_Summoning()
			for(var/obj/Jutsus/First_Puppet_Summoning/J in src.jutsus)
				if(src.puppets[1])
					var/mob/K = src.puppets[1]
					src.puppets[1]=null
					var/obj/O = new/obj
					O.IsJutsuEffect=src
					O.loc = K.loc
					O.icon = 'Smoke.dmi'
					flick("smoke",O)
					spawn(7) del(O)
					del(K)
					src << output("You un-summon your first puppet.","Action.Output")
					return
				if(src.PreJutsu(J))
					if(loc.loc:Safe!=1) src.LevelStat("Ninjutsu",((J.maxcooltime*3/20)*jutsustatexp))
					if(loc.loc:Safe!=1) src.LevelStat("Precision",((J.maxcooltime*3/20)*jutsustatexp))
					if(J.level<4) if(loc.loc:Safe!=1) J.exp+=rand(2,5); J.Levelup()
					var/mob/M = new/mob/Karasu(get_step(src,src.dir))
					var/obj/O2 = new/obj
					O2.IsJutsuEffect=src
					O2.loc = M.loc
					O2.icon = 'Smoke.dmi'
					flick("smoke",O2)
					spawn(7) del(O2)
					M.Owner=src
					M.health=J.level*400
					M.taijutsu=src.taijutsu
					M.name = src.key
					M.Owner=src
					src.puppets[1] = M

		Second_Puppet_Summoning()
			for(var/obj/Jutsus/Second_Puppet_Summoning/J in src.jutsus)
				if(src.puppets[2])
					var/mob/K = src.puppets[2]
					src.puppets[2]=null
					var/obj/O = new/obj
					O.IsJutsuEffect=src
					O.loc = K.loc
					O.icon = 'Smoke.dmi'
					flick("smoke",O)
					spawn(7) del(O)
					del(K)
					src << output("You un-summon your second puppet.","Action.Output")
					return
				if(src.PreJutsu(J))

					if(loc.loc:Safe!=1) src.LevelStat("Ninjutsu",((J.maxcooltime*3/20)*jutsustatexp))
					if(loc.loc:Safe!=1) src.LevelStat("Precision",((J.maxcooltime*3/20)*jutsustatexp))
					if(J.level<4) if(loc.loc:Safe!=1) J.exp+=rand(2,5); J.Levelup()
					var/mob/M = new/mob/Karasu(get_step(src,src.dir))
					M.Owner=src
					M.health=J.level*400
					M.taijutsu=src.taijutsu
					var/obj/O2 = new/obj
					O2.IsJutsuEffect=src
					O2.loc = M.loc
					O2.icon = 'Smoke.dmi'
					flick("smoke",O2)
					spawn(7) del(O2)
					M.name = src.key
					src.puppets[2] = M
		Summon_Kazekage_Puppet()
			for(var/obj/Jutsus/Summon_Kazekage_Puppet/J in src.jutsus)
				if(src.PreJutsu(J))
					if(loc.loc:Safe!=1) src.LevelStat("Ninjutsu",((J.maxcooltime*3/20)*jutsustatexp))
					if(loc.loc:Safe!=1) src.LevelStat("Precision",((J.maxcooltime*3/20)*jutsustatexp))
					var/mob/jutsus/KazekagePuppet/A=new/mob/jutsus/KazekagePuppet(src.loc)
					A.OWNER=src
					A.dir=src.dir
					var/mob/c_target=src.Target_Get(TARGET_MOB)
					if(c_target)
						walk_to(A,c_target)
					spawn(100)
						del(A)

