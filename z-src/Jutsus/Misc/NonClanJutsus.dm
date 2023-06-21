mob
	proc
		Chakra_Infusion_Training()//chakrainfusionstuff
			if(infusing == 1)
				src.infusing = 0
				src.overlays-=/obj/Overlays/Chakra
				src.overlays-=/obj/Overlays/Chakra
				src.overlays-=/obj/Overlays/Chakra
				src.overlays-=/obj/Overlays/Chakra
				return
			for(var/obj/Jutsus/Chakra_Infusion_Training/J in src.jutsus)
				if(src.PreJutsu(J))
					if(src.chakra<src.maxchakra)
						src<<output("Your chakra needs to be full for this kind of training.","Action.Output")
					if(src.chakra == src.maxchakra)
						var/state/cant_attack/e = new()
						AddState(src, e, -1)
						var/state/cant_move/f = new()
						AddState(src, f, -1)
						src.icon_state = "jutsuuse"
						src.infusing=1
						var/combobuilt=3

						while(infusing)
							var/arrowcolour=rand(100,255)

							var/obj/C1 = new/obj(usr.loc)//circles
							C1.layer=MOB_LAYER
							C1.icon = 'Misc Effects.dmi'
							C1.icon_state= "arrowcircle"
							C1.color=rgb(arrowcolour,arrowcolour,255)
							step(C1,NORTH)
							step(C1,NORTH)

							var/obj/C2 = new/obj(usr.loc)
							C2.layer=MOB_LAYER
							C2.icon = 'Misc Effects.dmi'
							C2.icon_state= "arrowcircle"
							C2.color=rgb(arrowcolour,arrowcolour,255)
							step(C2,EAST)
							step(C2,EAST)

							var/obj/C3 = new/obj(usr.loc)
							C3.layer=MOB_LAYER
							C3.icon = 'Misc Effects.dmi'
							C3.icon_state= "arrowcircle"
							C3.color=rgb(arrowcolour,arrowcolour,255)
							step(C3,SOUTH)
							step(C3,SOUTH)

							var/obj/C4 = new/obj(usr.loc)
							C4.layer=MOB_LAYER
							C4.icon = 'Misc Effects.dmi'
							C4.icon_state= "arrowcircle"
							C4.color=rgb(arrowcolour,arrowcolour,255)
							step(C4,WEST)
							step(C4,WEST)

							var/obj/A = new/obj(usr.loc)//arrows
							A.color= rgb(arrowcolour,arrowcolour,255)
							A.layer= MOB_LAYER+1
							A.icon = 'Misc Effects.dmi'
							A.icon_state = "arrow"
							var/arrowrand= rand(1,4)
							switch(arrowrand)
								if(1)step(A,NORTH)
								if(2)step(A,EAST)
								if(3)step(A,SOUTH)
								if(4)step(A,WEST)
							switch(arrowrand)
								if(1)step(A,NORTH)
								if(2)step(A,EAST)
								if(3)step(A,SOUTH)
								if(4)step(A,WEST)
							var/mob/arrowdir= get_dir(src,A)
							sleep(6)
							if(src.dir==arrowdir)
								if(combobuilt<=2)combobuilt=3
								if(combobuilt>=3&&combobuilt!=7)
									combobuilt+=1
									src.overlays+=/obj/Overlays/Chakra
								switch(src.Specialist)
									if("Ninjutsu")
										src.LevelStat("Ninjutsu",round((trainingexp*rand(15,25)*(combobuilt-3))))
										src.LevelStat("Genjutsu",round((trainingexp*rand(5,15)*(combobuilt-3))))
									if("Genjutsu")
										src.LevelStat("Genjutsu",round((trainingexp*rand(15,25)*(combobuilt-3))))
										src.LevelStat("Ninjutsu",round((trainingexp*rand(5,15)*(combobuilt-3))))
									else
										src.LevelStat("Genjutsu",round((trainingexp*rand(5,15)*(combobuilt-3))))
										src.LevelStat("Ninjutsu",round((trainingexp*rand(5,15)*(combobuilt-3))))
								del(A)
								del(C1)
								del(C2)
								del(C3)
								del(C4)
							else
								if(combobuilt<=3)
									combobuilt-=1
								if(combobuilt>=4)
									combobuilt=3
									src.overlays-=/obj/Overlays/Chakra
									src.overlays-=/obj/Overlays/Chakra
									src.overlays-=/obj/Overlays/Chakra
									src.overlays-=/obj/Overlays/Chakra
								if(combobuilt==0)
									infusing=0
									RemoveState(src, e, STATE_REMOVE_REF)
									RemoveState(src, f, STATE_REMOVE_REF)
									DealDamage(src.chakra,src,"aliceblue",0,1)
									src<<output("<font color= #94FFFF>You feel your chakra points burn as you lose control.<font>","Action.Output")
								del(A)
								del(C1)
								del(C2)
								del(C3)
								del(C4)
						RemoveState(src, e, STATE_REMOVE_REF)
						RemoveState(src, f, STATE_REMOVE_REF)

		Chakra_Release()
			for(var/obj/Jutsus/ChakraRelease/J in src.jutsus)
				if(src.PreJutsu(J))
					if(loc.loc:Safe!=1) src.LevelStat("Ninjutsu",((J.maxcooltime*3/10)*jutsustatexp))
					if(J.level==1) J.damage=((jutsudamage*J.Sprice)/2)*0.6
					if(J.level==2) J.damage=((jutsudamage*J.Sprice)/1.5)*0.6
					if(J.level==3) J.damage=((jutsudamage*J.Sprice)/1.25)*0.6
					if(J.level==4) J.damage=(jutsudamage*J.Sprice)*0.6
					if(J.level<4) if(loc.loc:Safe!=1) J.exp+=jutsumastery*(J.maxcooltime/20); J.Levelup()
					src.PlayAudio('046.wav', output = AUDIO_HEARERS)
					flick("jutsu",src)
					Bind(src, 6)
					var/obj/A = new/obj/MiscEffects/Chakra(usr.loc)
					A.loc=src.loc
					//src.overlays+=/obj/MiscEffects/Chakra/
					for(var/obj/Projectiles/P in orange())
						step_rand(P)
						walk(P,P.dir)
					for(var/obj/Hits/Shurikens/N in src.SCaught)
						src.overlays-=N
						var/obj/Projectiles/Weaponry/Shuriken/S = new/obj/Projectiles/Weaponry/Shuriken(src.loc)
						S.Owner=src
						S.damage+=J.damage+round((src.ninjutsu_total / 200)*2*J.damage)
						step_rand(S)
						walk(S,S.dir)
						src.SCaught-=N
					for(var/obj/Hits/Kunai/N in src.SCaught)
						src.overlays-=N
						var/obj/Projectiles/Weaponry/Kunai/S = new/obj/Projectiles/Weaponry/Kunai(src.loc)
						S.Owner=src
						S.damage+=J.damage+round((src.ninjutsu_total / 200)*2*J.damage)
						step_rand(S)
						walk(S,S.dir)
						src.SCaught-=N
					for(var/obj/Hits/Needle/N in src.SCaught)
						src.overlays-=N
						var/obj/Projectiles/Weaponry/Needle/S = new/obj/Projectiles/Weaponry/Needle(src.loc)
						S.Owner=src
						S.damage+=J.damage+round((src.ninjutsu_total / 200)*2*J.damage)
						step_rand(S)
						walk(S,S.dir)
						src.SCaught-=N
					for(var/obj/Hits/BoneTips/N in src.SCaught)
						src.overlays-=N
						var/obj/Projectiles/Weaponry/BoneTip/S = new/obj/Projectiles/Weaponry/BoneTip(src.loc)
						S.Owner=src
						S.damage+=J.damage+round((src.ninjutsu_total / 200)*2*J.damage)
						step_rand(S)
						walk(S,S.dir)
						src.SCaught-=N
					for(var/obj/Projectiles/Weaponry/ExplosiveTag/N in view(src,1))
						if(N.icon_state<>"blank")
							var/obj/Inventory/Weaponry/Explosive_Tag/S = new/obj/Inventory/Weaponry/Explosive_Tag(src.loc)
							S.loc=src.loc
							del(N)
					src.amounthits=0
					if(CheckState(src, new/state/slowed)) RemoveState(src, new/state/slowed, STATE_REMOVE_ALL)

		Crow_Clone()
			CloneHandler()
			if(clonesturned==1)
				return
			for(var/obj/Jutsus/Crow_Clone/J in src.jutsus)
				if(src.PreJutsu(J))
					src.CloneHandler()
					if(loc.loc:Safe!=1) src.LevelStat("Genjutsu",((J.maxcooltime*3/10)*jutsustatexp))
					if(J.level<4) if(loc.loc:Safe!=1) J.exp+=jutsumastery*(J.maxcooltime/20); J.Levelup()
					flick("jutsu",src)
					for(var/mob/M in mobs_online)
						if(M.target_mob == src)
							M.Target_Remove()
					src.PlayAudio('wirlwind.wav', output = AUDIO_HEARERS)
					var/obj/O = new/obj
					O.loc = src.loc
					var/BUNLIST = list()
					Bind(src, 6)
					var/number_of_clones = J.level + round((src.genjutsu_total / 40))
					if(src.Specialist == SPECIALIZATION_GENJUTSU) number_of_clones += 2
					var/i
					for(i=0, i<number_of_clones, i++)
						var/mob/Clones/Bunshin2/A = new/mob/Clones/Bunshin2(src.loc)
						A.loc=src.loc
						A.Owner=src
						A.icon=src.icon
						A.overlays=src.overlays
						A.invisibility=1
						BUNLIST+=A
						step_rand(A)
						step_rand(A)
						step_rand(A)
						step_rand(A)
						step_rand(A)
						spawn(100)if(A)del(A)
					src.invisibility=1
					step_rand(src)
					step_rand(src)
					step_rand(src)
					step_rand(src)
					step_rand(src)
					for(var/mob/Z in BUNLIST)
						var/obj/C = new/obj/CROW
						C.loc = O.loc
						C.pixel_x=-16
						C.icon = 'Crows.dmi'
						C.overlays+=image('Crows.dmi',pixel_x=-16+rand(-8,8),pixel_y=rand(-8,8))
						C.overlays+=image('Crows.dmi',pixel_x=-16+rand(-8,8),pixel_y=rand(-8,8))
						C.overlays+=image('Crows.dmi',pixel_x=-16+rand(-8,8),pixel_y=rand(-8,8))
						walk_to(C,Z)
						spawn(5)
							if(Z)Z.invisibility=0
							if(C)del(C)
					var/obj/C2 = new/obj/CROW
					C2.loc = O.loc
					C2.pixel_x=-16
					C2.icon = 'Crows.dmi'
					C2.overlays+=image('Crows.dmi',pixel_x=-16+rand(-8,8),pixel_y=rand(-8,8))
					C2.overlays+=image('Crows.dmi',pixel_x=-16+rand(-8,8),pixel_y=rand(-8,8))
					C2.overlays+=image('Crows.dmi',pixel_x=-16+rand(-8,8),pixel_y=rand(-8,8))
					walk_to(C2,src)
					spawn(5)if(src)
						src.invisibility=0
					spawn(5)if(C2)del(C2)

		Clone_Jutsu()
			if(clonesturned==1)
				return
			/*if(multishadow==1)
				return*/
			for(var/obj/Jutsus/BClone/J in src.jutsus)
				if(src.PreJutsu(J))
					src.CloneHandler()
					if(loc.loc:Safe!=1) src.LevelStat("Genjutsu",((J.maxcooltime*3/10)*jutsustatexp))
					if(J.level<4) if(loc.loc:Safe!=1) J.exp+=jutsumastery*(J.maxcooltime/20); J.Levelup()
					flick("jutsu",src)
					for(var/mob/M in mobs_online)
						if(M.target_mob == src)
							M.Target_Remove()
					src.PlayAudio('flashbang_explode1.wav', output = AUDIO_HEARERS)
					var/number_of_clones = 1 + round((J.level/2) + (src.genjutsu_total / 25))
					if(src.Specialist == SPECIALIZATION_GENJUTSU) number_of_clones += 2
					var/i
					for(i=0, i<number_of_clones, i++)
						var/mob/Clones/Bunshin/A = new/mob/Clones/Bunshin(src.loc)
						A.Owner=src
						A.icon=src.icon
						A.overlays=src.overlays

		MultipleShadowClone_Jutsu()
			if(clonesturned==1)
				return
			for(var/obj/Jutsus/MSClone/J in src.jutsus)
				if(src.PreJutsu(J))
					src.CloneHandler()
					src.PlayAudio('flashbang_explode1.wav', output = AUDIO_HEARERS)
					if(loc.loc:Safe!=1) src.LevelStat("Genjutsu",((J.maxcooltime*3/10)*jutsustatexp))
					if(J.level<4) if(loc.loc:Safe!=1) J.exp+=jutsumastery*(J.maxcooltime/20); J.Levelup()
					for(var/mob/M in mobs_online)
						if(M.target_mob == src)
							M.Target_Remove()
					var/number_of_clones = round((J.level) + (src.genjutsu_total / 66.6))
					if(src.Specialist == SPECIALIZATION_GENJUTSU) number_of_clones++
					var/i
					for(i=0, i<number_of_clones, i++)
						sleep(1)
						flick("jutsu",src)
						var/mob/Clones/Shadow/A = new/mob/Clones/Shadow(src.loc)
						A.loc=src.loc
						A.Owner=src
						A.icon=src.icon
						A.overlays=src.overlays
						A.taijutsu=round(src.genjutsu_total)
						A.defence=round(src.genjutsu_total)
						A.health=round(src.genjutsu_total*5)
						A.maxhealth=round(src.genjutsu_total*5)
						A.agility=round(src.genjutsu_total)
						A.genjutsu_total=round(src.genjutsu_total)
						var/obj/O=new /obj/Screen/healthbar/
						var/obj/M=new /obj/Screen/manabar/
						A.hbar.Add(O)
						A.hbar.Add(M)
						A.overlays-=/obj/Screen/healthbar
						A.overlays-=/obj/Screen/manabar
						for(var/obj/Screen/healthbar/HB in A.hbar)A.overlays+=HB
						for(var/obj/Screen/manabar/HB in A.hbar)A.overlays+=HB

		ShadowClone_Jutsu()
			if(clonesturned==1)
				return
			for(var/obj/Jutsus/SClone/J in src.jutsus)
				if(src.PreJutsu(J))
					src.CloneHandler()
					if(loc.loc:Safe!=1) src.LevelStat("Genjutsu",((J.maxcooltime*3/10)*jutsustatexp))
					if(J.level<4) if(loc.loc:Safe!=1) J.exp+=jutsumastery*(J.maxcooltime/20); J.Levelup()
					spawn() src.UpdateHMB()
					flick("jutsu",src)
					src.PlayAudio('flashbang_explode1.wav', output = AUDIO_HEARERS)
					var/mob/Clones/Shadow/A = new/mob/Clones/Shadow(src.loc)
					A.loc=src.loc
					A.Owner=src
					A.icon=src.icon
					A.overlays=src.overlays
					A.taijutsu=round(src.genjutsu_total)
					A.defence=round(src.genjutsu_total)
					A.health=round(src.genjutsu_total*10)
					A.maxhealth=round(src.genjutsu_total*10)
					A.agility=round(src.genjutsu_total)
					A.genjutsu_total=round(src.genjutsu_total)
					var/obj/O=new /obj/Screen/healthbar/
					var/obj/M=new /obj/Screen/manabar/
					A.hbar.Add(O)
					A.hbar.Add(M)
					A.overlays-=/obj/Screen/healthbar
					A.overlays-=/obj/Screen/manabar
					for(var/obj/Screen/healthbar/HB in A.hbar)A.overlays+=HB
					for(var/obj/Screen/manabar/HB in A.hbar)A.overlays+=HB
					if(J.level<4&&src.loc.loc:Safe!=1)
						J.exp+=rand(5,15)
						J.Levelup()

		Clone_Jutsu_Destroy()
			for(var/obj/Jutsus/BCloneD/J in src.jutsus)
				if(src.PreJutsu(J))
					if(src.Clones.len)
						flick("jutsu",src)
						for(var/mob/Clones/C in src.Clones)
							C.health=0
							C.Death(src)
						if(usr.likeaclone)
							usr.likeaclone=null
							usr.client:perspective = EDGE_PERSPECTIVE
							usr.client:eye=usr
							target_mob=null
							takeova=0

		Transformation_Jutsu()
			for(var/obj/Jutsus/Transformation/J in src.jutsus)
				if(src.PreJutsu(J))
					if(src.henge==0)
						if(loc.loc:Safe!=1) src.LevelStat("Genjutsu",((J.maxcooltime*3/10)*jutsustatexp))
						if(J.level<4) if(loc.loc:Safe!=1) J.exp+=jutsumastery*(J.maxcooltime/20); J.Levelup()
						if(J.level==1)src.henge=1
						if(J.level==2)src.henge=2
						if(J.level==3)src.henge=3
						spawn()
							src<<output("<Font color=white>Now click the object you wish to transform into.</Font>","Action.Output")
		TreeBinding()
			for(var/obj/Jutsus/TreeBinding/J in src.jutsus)
				var/mob/c_target=usr.Target_Get(TARGET_MOB)
				if(!c_target)
					src<<output("<Font color=white>I need a target to use this jutsu!</Font>","Action.Output")
					return
				if(src.PreJutsu(J))	
					if(loc.loc:Safe!=1) src.LevelStat("Genjutsu",((J.maxcooltime*3/10)*jutsustatexp))
					if(J.level<4) if(loc.loc:Safe!=1) J.exp+=jutsumastery*(J.maxcooltime/20); J.Levelup()
					if(J.level==1) J.damage=((jutsudamage*J.Sprice)/2)*0.8
					if(J.level==2) J.damage=((jutsudamage*J.Sprice)/1.5)*0.8
					if(J.level==3) J.damage=((jutsudamage*J.Sprice)/1.25)*0.8
					if(J.level==4) J.damage=(jutsudamage*J.Sprice)*0.8
					//view()<<"<font size=1><font face=Times New Roman><b><font color=white>[src] Says:<font color=yellow> Fire Release:Fire Ball"
					flick("jutsuse",src)
					src.PlayAudio('wind_leaves.ogg', output = AUDIO_HEARERS)
					if(J.level<4) if(loc.loc:Safe!=1) J.exp+=rand(2,5); J.Levelup()
					var/Time=J.level
					var/TreeNearby
					for(var/obj/Ground/Trees/T in oview(2,c_target))
						TreeNearby=1
					if(TreeNearby)
						c_target.overlays+='TreeBinding.dmi'
						var/bind_time = Time*10
						Time -= (Time/100)*c_target.tenacity
						Bind(c_target, bind_time, src)
						var/bound_location = c_target.loc
						while(Time&&c_target&&src&&c_target.loc == bound_location)
							if(c_target)
								c_target.DealDamage((J.damage+round((src.ninjutsu_total / 200)*2*J.damage))/4,src,"white")
								sleep(10)
								Time--
						if(c_target)
							c_target.overlays-='TreeBinding.dmi'

					else src<<"Your target is not by a tree, and the technique fails!"

		Bringer_of_Darkness_Technique()
			for(var/obj/Jutsus/Bringer_of_Darkness_Technique/J in src.jutsus)
				var/mob/c_target=src.Target_Get(TARGET_MOB)
				if(!c_target)
					src << output("This jutsu requires a target","Action.Output")
					return
				if(src.PreJutsu(J))
					if(loc.loc:Safe!=1) src.LevelStat("Genjutsu",((J.maxcooltime*3/10)*jutsustatexp))
					if(J.level<4) if(loc.loc:Safe!=1) J.exp+=jutsumastery*(J.maxcooltime/20); J.Levelup()
					flick("jutsuse",src)
					src.PlayAudio('wind_leaves.ogg', output = AUDIO_HEARERS)
					var/TimeAsleep
					if(J.level==1)TimeAsleep=5
					if(J.level==2)TimeAsleep=10
					if(J.level==3)TimeAsleep=15
					if(J.level==4)TimeAsleep=20
					TimeAsleep+=(src.genjutsu_total*(20/200))
					if(src.Sharingan>0) TimeAsleep+=10
					if(c_target.client)
						if(c_target.Rinnegan==1) goto skip
						c_target.sight |= BLIND
						spawn(TimeAsleep)if(c_target)c_target.sight &= ~BLIND
					skip

		Temple_Of_Nirvana()
			for(var/obj/Jutsus/Temple_Of_Nirvana/J in src.jutsus)
				if(src.PreJutsu(J))
					if(loc.loc:Safe!=1) src.LevelStat("Genjutsu",((J.maxcooltime*3/10)*jutsustatexp))
					if(J.level<4) if(loc.loc:Safe!=1) J.exp+=jutsumastery*(J.maxcooltime/20); J.Levelup()
					var/reqhits=rand(1,2)
					var/jutsuactive=1
					flick("jutsuse",src)
					src.PlayAudio('wind_leaves.ogg', output = AUDIO_HEARERS)
					Bind(src, 2)
					var/TimeAsleep
					if(J.level==1) TimeAsleep=30+(src.genjutsu_total*(60/200))
					if(J.level==2) TimeAsleep=40+(src.genjutsu_total*(60/200))
					if(J.level==3) TimeAsleep=50+(src.genjutsu_total*(60/200))
					if(J.level==4) TimeAsleep=60+(src.genjutsu_total*(60/200))
					if(J.level<4) if(loc.loc:Safe!=1) J.exp+=rand(2,5); J.Levelup()
					new/obj/Jutsus/Effects/TempleNirvana(src.loc)
					for(var/mob/M in oview(J.level))
						M.sleephits=0
						if(Squad)
							if(Squad.Members.Find(M.ckey)||getOwner(Squad.Leader)==M.ckey) continue
						new/obj/Jutsus/Effects/TempleNirvana(M.loc)
						if(M.Sharingan>=2) continue
						if(M.Rinnegan==1) continue
						M.icon_state="dead"
						TimeAsleep -= (TimeAsleep/100) * M.tenacity
						var/state/cant_attack/e = new()
						AddState(M, e, TimeAsleep)

						var/state/cant_move/f = new()
						AddState(M, f, TimeAsleep)

						spawn(TimeAsleep)
							if(jutsuactive==1)
								if(!M||M.dead) continue
								M.icon_state=""

								RemoveState(M, e, STATE_REMOVE_REF)
								RemoveState(M, f, STATE_REMOVE_REF)

								jutsuactive=0
						spawn()
							while(jutsuactive==1)
								sleep(1)
								if(M && reqhits<=M.sleephits)
									jutsuactive=0
									M.icon_state=""
									RemoveState(M, e, STATE_REMOVE_REF)
									RemoveState(M, f, STATE_REMOVE_REF)


		One_Thousand_Years_of_Death()
			for(var/obj/Jutsus/One_Thousand_Years_of_Death/J in src.jutsus)
				if(src.PreJutsu(J))
					if(loc.loc:Safe!=1) src.LevelStat(SPECIALIZATION_TAIJUTSU,((J.maxcooltime*3/20)*jutsustatexp))
					if(loc.loc:Safe!=1) src.LevelStat("Precision",((J.maxcooltime*3/20)*jutsustatexp))
					if(J.level==1) J.damage=((jutsudamage*J.Sprice)/2)*0.7
					if(J.level==2) J.damage=((jutsudamage*J.Sprice)/1.5)*0.7
					if(J.level==3) J.damage=((jutsudamage*J.Sprice)/1.25)*0.7
					if(J.level==4) J.damage=(jutsudamage*J.Sprice)*0.7
					if(J.level<4) if(loc.loc:Safe!=1) J.exp+=jutsumastery*(J.maxcooltime/20); J.Levelup()
					var/mob/c_target=src.Target_Get(TARGET_MOB)
					Bind(src, 8)
					src.icon_state = "jutsuse"
					sleep(5)
					if(c_target)
						c_target.dir = get_dir(c_target,src)
						flick('Shunshin.dmi',src)
						loc = c_target.loc
						step(src,c_target.dir)
						dir = get_dir(src,c_target)
						sleep(2)
					flick("2fist",src)
					for(var/mob/M in get_step(src,src.dir))
						for(var/i=0,i<4,i++)
							var/obj/O = new/obj
							O.loc = M.loc
							O.icon = 'Smoke.dmi'
							flick("smoke",O)
							spawn(7)if(O)del(O)
							if(M) step(M,src.dir)
							if(M) M.dir = get_dir(M,src)
							if(M) M.DealDamage((J.damage+round(((src.taijutsu_total / 450)+(src.precision_total / 450))*2*J.damage))/4,src,"TaiOrange")
							sleep(1)
					src.icon_state = ""
		Chakra_Control()
			for(var/obj/Jutsus/Chakra_Control/J in src.jutsus)
				if(src.PreJutsu(J))
					if(loc.loc:Safe!=1) src.LevelStat("Ninjutsu",((J.maxcooltime*3/10)*jutsustatexp))
					if(J.level<4) if(loc.loc:Safe!=1) J.exp+=jutsumastery*(J.maxcooltime/20); J.Levelup()
					if(src.waterwalk)
						waterwalk=0
						src<<output("You stop converting chakra to your feet.","Action.Output")
						return
					waterwalk=1
					src<<output("You start converting chakra to your feet.","Action.Output")

		Body_Replacement_Technique()
			for(var/obj/Jutsus/BodyReplace/J in src.jutsus)
				if(src.PreJutsu(J))
					if(loc.loc:Safe!=1) src.LevelStat("Ninjutsu",((J.maxcooltime*3/10)*jutsustatexp))
					if(J.level<4) if(loc.loc:Safe!=1) J.exp+=jutsumastery*(J.maxcooltime/20); J.Levelup()
					src.PlayAudio('flashbang_explode1.wav', output = AUDIO_HEARERS)
					var/obj/A = new/obj/MiscEffects/Smoke(src.loc)
					A.IsJutsuEffect=src
					A.loc=src.loc
					var/obj/B = new/obj/Training/BDLogB(src.loc)
					B.IsJutsuEffect=src
					B.loc=src.loc
					for(var/mob/M in mobs_online)
						if(M.target_mob == src)
							M.Target_Remove()
					if(J.level<4)
						if(loc.loc:Safe!=1) J.exp=J.maxexp
						J.Levelup()

					AddState(src, new/state/cant_move, 1)

					if(J.level==1)
						src.Step_Back()

					if(J.level==2)
						src.Step_Back()
						src.Step_Back()

					if(J.level==3)
						src.overlays=0
						src.SetName(src.name)
						src.RestoreOverlays()
						src.Step_Back()
						src.Step_Back()
						src.Step_Back()
						src.SetName(src.name)
						src.icon_state=""
						src.RestoreOverlays()

					if(J.level>=4 || J.level==4)
						B.icon=src.icon
						B.icon_state=src.icon_state
						B.overlays=0
						B.overlays=src.overlays
						B.dir=src.dir
						if(!istype(src, /mob/npc))
							src.overlays=0
						src.SetName(src.name)
						src.RestoreOverlays()
						src.Step_Back()
						src.Step_Back()
						src.Step_Back()
						src.Step_Back()
						src.SetName(src.name)
						src.icon_state=""
						src.RestoreOverlays()


		Advanced_Body_Replacement_Technique()
			if(src.kawarmi)
				/*if(src.Intang)
					src<<"You can't adv sub while Intang."
					return*/
				if(usr.mark.z == usr.z)
					ChakraCheck(0)
					if(usr.dead==1) return
					if(get_dist(usr,usr.mark)>20)
						usr<<"\red <b>Your substitution was set too far away. Jutsu failed!"
						usr.mark=null
						usr.kawarmi=0
						return
					for(var/mob/M in mobs_online)
						if(M.target_mob == src)
							M.Target_Remove()
					src.PlayAudio('flashbang_explode1.wav', output = AUDIO_HEARERS)
					usr.mark2=usr.loc
					usr.loc=usr.mark

					RemoveState(usr, new/state/cant_attack, STATE_REMOVE_ALL)
					RemoveState(usr, new/state/cant_move, STATE_REMOVE_ALL)
					
					usr.kawarmi=0
					usr.inshadowfield=0
					var/obj/A = new/obj/MiscEffects/Smoke(usr.loc)
					A.loc=usr.mark2

					if(istype(loc,/turf/Ground/Water))
						if(!usr.waterwalk)
							AddState(usr, new/state/swimming, -1)
							usr.stepcounter=0
							usr.icon_state="swim"
							usr.overlays-=/obj/MaleParts/UnderShade
							usr.overlays+=/obj/MiscEffects/WaterRing
							usr.overlays+=/obj/MiscEffects/WaterRing
						if(usr.waterwalk)
							AddState(usr, new/state/water_walking, -1)
							usr.overlays+=/obj/MiscEffects/WaterRing
							usr.overlays+=/obj/MiscEffects/WaterRing

					if(!istype(loc,/turf/Ground/Water))
						if(CheckState(usr, new/state/swimming))
							RemoveState(src, new/state/swimming, STATE_REMOVE_ALL)
							usr.stepcounter=0
							usr.icon_state=""
							usr.overlays+=/obj/MaleParts/UnderShade
							usr.overlays-=/obj/MiscEffects/WaterRing
							usr.overlays-=/obj/MiscEffects/WaterRing
						if(CheckState(usr, new/state/water_walking))
							RemoveState(src, new/state/water_walking, STATE_REMOVE_ALL)
							usr.overlays-=/obj/MiscEffects/WaterRing
							usr.overlays-=/obj/MiscEffects/WaterRing

					sleep(8)
					if(src)
						var/obj/B = new/obj/MiscEffects/LogB(usr.loc)
						B.loc=usr.mark2
				else
					usr.mark=null
					usr.kawarmi=0
			for(var/obj/Jutsus/AdvancedBodyReplace/J in src.jutsus)
				if(src.PreJutsu(J))
					if(loc.loc:Safe!=1) src.LevelStat("Ninjutsu",((J.maxcooltime*3/10)*jutsustatexp))
					if(J.level<4) if(loc.loc:Safe!=1) J.exp+=jutsumastery*(J.maxcooltime/20); J.Levelup()
					src.kawarmi=1
					src.mark=src.loc
					src<<output("Now to activate use the defend verb.","Action.Output")

		Shunshin()
			for(var/obj/Jutsus/Body_Flicker/J in src.jutsus)
				if(src.PreJutsu(J))
					var/obj/Inventory/mission/deliver_intel/O = locate(/obj/Inventory/mission/deliver_intel) in usr.contents
					if(O)
						src<<output("The seal in the scroll is preventing my Body flicker!","Action.Output")
						return
					if(CheckState(src, new/state/cant_move)) return
					var/mob/c_target=src.Target_Get(TARGET_MOB)
					flick("jutsuse",src)
					src.PlayAudio('dash.wav', output = AUDIO_HEARERS)
					Bind(src, 4)
					if(J.level==1) J.damage=1
					if(J.level==2) J.damage=2
					if(J.level==3) J.damage=3
					if(J.level==4) J.damage=4
					if(loc.loc:Safe!=1) src.LevelStat("Ninjutsu",((J.maxcooltime*3/20)*jutsustatexp))
					if(loc.loc:Safe!=1) src.LevelStat("Agility",((J.maxcooltime*3/20)*jutsustatexp))
					if(J.level<4) if(loc.loc:Safe!=1) J.exp+=jutsumastery*(J.maxcooltime/20); J.Levelup()
					if(c_target)
						//if(c_target.opponent) return
						flick('Shunshin.dmi',src)
						spawn(1)
							src.loc = c_target.loc
							step(src,c_target.dir)
							if(src.loc == c_target.loc)
								for(var/turf/tile in orange(1,src))
									if(!tile.density)
										src.loc = tile
							src.dir = get_dir(src,c_target)
					else
						flick('Shunshin.dmi',src)
						spawn(1)for(var/i=0,i<J.damage*3+1,i++)step(src,src.dir)

		Body_Pathway_Derangement()
			for(var/obj/Jutsus/Body_Pathway_Derangement/J in src.jutsus)
				if(src.PreJutsu(J))
					if(loc.loc:Safe!=1) src.LevelStat(SPECIALIZATION_TAIJUTSU,((J.maxcooltime*3/20)*jutsustatexp))
					if(loc.loc:Safe!=1) src.LevelStat("Precision",((J.maxcooltime*3/20)*jutsustatexp))
					if(J.level<4) if(loc.loc:Safe!=1) J.exp+=jutsumastery*(J.maxcooltime/20); J.Levelup()
					if(J.level==1) J.damage=((jutsudamage*J.Sprice)/2)*0.4
					if(J.level==2) J.damage=((jutsudamage*J.Sprice)/1.5)*0.4
					if(J.level==3) J.damage=((jutsudamage*J.Sprice)/1.25)*0.4
					if(J.level==4) J.damage=(jutsudamage*J.Sprice)*0.4
					var/reqhits=rand(1,2)
					var/jutsuactive=1
					flick("punchr",src)
					var/mob/c_target2=src.Target_Get(TARGET_MOB)
					if(c_target2)
						step_towards(src, c_target2)
						src.dir = get_dir(src.loc, c_target2.loc)
					var/mob/Z
					for(var/mob/M in get_step(src,src.dir))Z=M
					if(Z)
						Z.DealDamage(J.damage + round((src.taijutsu_total / 450)+(src.precision_total / 450)*2*J.damage)*1.5,src,"NinBlue")
						Z.sleephits=0
						Z.icon_state="dead"
						var/TimeAsleep = J.level*10 + src.precision*0.5
						TimeAsleep -= (TimeAsleep/100) * Z.tenacity

						var/state/cant_attack/e = new()
						AddState(Z, e, TimeAsleep)

						var/state/cant_move/f = new()
						AddState(Z, f, TimeAsleep)


						spawn(TimeAsleep)
							if(jutsuactive==1)
								if(!Z||Z.dead) continue
								Z.icon_state=""
								RemoveState(Z, e, STATE_REMOVE_REF)
								RemoveState(Z, f, STATE_REMOVE_REF)
								jutsuactive=0
						while(jutsuactive==1)
							sleep(1)
							if(reqhits<=Z.sleephits)
								jutsuactive=0
								Z.icon_state=""
								RemoveState(Z, e, STATE_REMOVE_REF)
								RemoveState(Z, f, STATE_REMOVE_REF)

		Crow_Substitution()
			for(var/obj/Jutsus/Crow_Substitution/J in src.jutsus)
				if(src.PreJutsu(J))
					if(loc.loc:Safe!=1) src.LevelStat("Genjutsu",((J.maxcooltime*3/10)*jutsustatexp))
					if(J.level<4) if(loc.loc:Safe!=1) J.exp+=jutsumastery*(J.maxcooltime/20); J.Levelup()
					var/turf/T=src.loc
					src<<output("You will be sent to this location the next time your character accumulates damage.","Action.Output")
					var/lasthp = src.health
					while(src.health >= lasthp)
						lasthp = src.health
						sleep(1)
					if(get_dist(usr,T)>30||usr.z != T.z)
						usr<<"\red <b>Your substitution was set too far away. Jutsu failed!"
						return
					for(var/i=0,i<8,i++)
						var/obj/O = new/obj
						O.loc = src.loc
						O.icon = 'CrowSub.dmi'
						O.pixel_x=-16
						spawn(1) step_rand(O)
						spawn(10)if(O)del(O)
					for(var/mob/M in mobs_online)
						if(M.target_mob == src)
							M.Target_Remove()
					src.loc = T

		Rasengan()
			for(var/obj/Jutsus/Rasengan/J in src.jutsus)
				if(src.PreJutsu(J))
					if(Effects["Rasengan"])
						Effects["Rasengan"]=null
						src.overlays-=image('Rasengan.dmi',"spin")
						return
					if(loc.loc:Safe!=1) src.LevelStat("Ninjutsu",((J.maxcooltime*2/30)*jutsustatexp))
					if(loc.loc:Safe!=1) src.LevelStat("Agility",((J.maxcooltime*2/30)*jutsustatexp))
					if(J.level<4) if(loc.loc:Safe!=1) J.exp+=jutsumastery*(J.maxcooltime/20); J.Levelup()
					if(J.level==1) J.damage=((jutsudamage*J.Sprice)/2)
					if(J.level==2) J.damage=((jutsudamage*J.Sprice)/1.5)
					if(J.level==3) J.damage=((jutsudamage*J.Sprice)/1.25)
					if(J.level==4) J.damage=(jutsudamage*J.Sprice)
					var/mob/c_target=src.Target_Get(TARGET_MOB)

					var/state/cant_attack/e = new()
					AddState(src, e, -1)

					var/state/cant_move/f = new()
					AddState(src, f, -1)

					src.icon_state="punchrS"
					var/obj/I = new/obj
					I.IsJutsuEffect=src
					if(dir!=SOUTH) I.layer=MOB_LAYER-1
					I.loc = src.loc
					I.icon = 'Rasengan.dmi'
					switch(src.dir)
						if(SOUTH)
							I.pixel_y=-8
							I.layer = MOB_LAYER+1
						if(NORTH)
							I.pixel_y=5
							I.pixel_x=-12
						if(EAST)I.pixel_x=-13
						if(WEST)I.pixel_x=-11
					flick("form",I)
					spawn(3)
						I.icon_state = "spin"
					var/timer=0
					var/list/DIRS=list(NORTH,EAST,SOUTH,WEST)
					Effects["Rasengan"] = J.level - 1
					//if(J.level==4) Effects["Rasengan"] = 4
					while(DIRS.len&&timer<20&&Effects["Rasengan"]!=4&&!Prisoned)
						timer++
						src.copy = "Rasengan"
						var/obj/A = new/obj
						A.IsJutsuEffect=src
						A.loc = src.loc
						A.icon = 'Misc Effects.dmi'
						A.icon_state = "arrow"
						A.pixel_x=15
						A.pixel_y=7
						A.dir = DIRS[1]
						DIRS-=DIRS[1]
						A.layer=10
						src.ArrowTasked = A
						sleep(10)
						if(A)del(A)
					src.icon_state=""
					I.icon_state = "form"
					I.pixel_x=0
					walk_to(I,src)
					RemoveState(src, e, STATE_REMOVE_REF)
					RemoveState(src, f, STATE_REMOVE_REF)
					if(Effects["Rasengan"]<4||Prisoned)
						if(I)del(I)
						src.copy=null
						Effects["Rasengan"]=null
						ArrowTasked=null
					else
						ArrowTasked=null
						src.copy=null
						var/rashit=0
						var/rcount=0
						while(rashit==0 && rcount <> 15)
							rcount+=1
							if(c_target)step_towards(src,c_target)
							else step(src,src.dir)
							var/obj/Drag/Dirt/D=new(src.loc)
							D.dir=src.dir
							for(var/mob/M in get_step(src,src.dir))
								if(M)
									flick("punchr",src)
									rashit=1
									I.loc = M.loc
									I.icon_state = "explode"
									I.pixel_x=-16
									walk_to(I,0)
									walk_to(I,I.loc)
									M.DealDamage(round((src.ninjutsu_total / 450)+(src.agility_total / 450)*2*J.damage)*1.5,src,"NinBlue")
							sleep(0.5)
						del(I)
					Effects["Rasengan"]=null

		ShishiRendan()
			var/mob/c_target=src.Target_Get(TARGET_MOB)
			if(!c_target){src<<output("<font color=yellow>You need to have a Target to perform ShiShi Rendan","Action.Output");return}
			if(get_dist(src,c_target)>4){src<<"[c_target] need to be closer to you for that move to work!";return}
			for(var/obj/Jutsus/Shishi/J in src.jutsus)
				if(src.PreJutsu(J))
					if(loc.loc:Safe!=1) src.LevelStat(SPECIALIZATION_TAIJUTSU,((J.maxcooltime*3/20)*jutsustatexp))
					if(loc.loc:Safe!=1) src.LevelStat("Agility",((J.maxcooltime*3/20)*jutsustatexp))
					if(J.level==1) J.damage=0.7*((jutsudamage*J.Sprice)/2)
					if(J.level==2) J.damage=0.7*((jutsudamage*J.Sprice)/1.5)
					if(J.level==3) J.damage=0.7*((jutsudamage*J.Sprice)/1.25)
					if(J.level==4) J.damage=0.7*(jutsudamage*J.Sprice)
					if(J.level<4) if(loc.loc:Safe!=1) J.exp+=jutsumastery*(J.maxcooltime/20); J.Levelup()				
					view(src) << output("<b><font color = #C0C0C0>[usr] says: Shishi Rendan!!!","Action.Output")
					Bind(src, 10)
					src.loc=locate(c_target.x-1,c_target.y,c_target.z)
					flick("kick",src)
					sleep(1)
					AddState(c_target, new/state/cant_move, 10)
					step(c_target,NORTH)
					spawn(2)
						if(c_target)
							step(c_target,NORTH)
							spawn(2)
								if(src)
									spawn(2)
										if(src)
											src.loc=locate(c_target.x+1,c_target.y,c_target.z)
											flick("kick",src)
											spawn(2)
												if(src)
													step(c_target,SOUTH)
													spawn(2)
														if(src)
															step(c_target,SOUTH)
															c_target.DealDamage(J.damage+round(((src.taijutsu_total / 450)+(src.agility_total / 450))*2*J.damage),src,"TaiOrange")
															if(c_target)c_target.Bleed()

		Leaf_Whirlwind()
			for(var/obj/Jutsus/Leaf_Whirlwind/J in src.jutsus)
				if(src.PreJutsu(J))
					if(loc.loc:Safe!=1) src.LevelStat(SPECIALIZATION_TAIJUTSU,((J.maxcooltime*3/20)*jutsustatexp))
					if(loc.loc:Safe!=1) src.LevelStat("Agility",((J.maxcooltime*3/20)*jutsustatexp))
					if(J.level>=3)
						var/obj/A = new/obj/MiscEffects/LeafWhirl(src.loc)
						A.dir=src.dir
					if(J.level==1) J.damage=((jutsudamage*J.Sprice)/2)*0.6
					if(J.level==2) J.damage=((jutsudamage*J.Sprice)/1.5)*0.6
					if(J.level==3) J.damage=((jutsudamage*J.Sprice)/1.25)*0.6
					if(J.level==4) J.damage=(jutsudamage*J.Sprice)*0.6
					if(J.level<4) if(loc.loc:Safe!=1) J.exp+=jutsumastery*(J.maxcooltime/20); J.Levelup()
					AddState(src, new/state/cant_attack, 4)
					flick("kick",src)
					if(J.level>=3) src.PlayAudio('wirlwind.wav', output = AUDIO_HEARERS)
					else src.PlayAudio('Spin.ogg', output = AUDIO_HEARERS)
					var/damage = J.level*2
					for(var/mob/c_target in orange(src,J.level))
						if(c_target in orange(src,J.level))
							if(c_target.dead==0&&!istype(c_target,/mob/npc/) || c_target.dead==0&&istype(c_target,/mob/npc/combat))
								if(c_target.fightlayer==src.fightlayer)
									if(c_target.dodge==0)
										var/undefendedhit=round(J.damage+round(((src.taijutsu_total / 450)+(src.agility_total / 450))*2*J.damage))
										if(undefendedhit<0)undefendedhit=1
										c_target.DealDamage(undefendedhit,src,"TaiOrange",0,0,1)
										src.PlayAudio('KickHit.ogg', output = AUDIO_HEARERS)
										c_target.icon_state="push"
										AddState(c_target, new/state/cant_attack, damage)
										walk(c_target,src.dir)
										if(c_target.client)spawn()c_target.ScreenShake(damage)
										spawn(damage)
											if(c_target)
												walk(c_target,0)
												if(!CheckState(c_target, new/state/swimming))c_target.icon_state=""
									else
										if(src.agility_total>=c_target.agility_total)
											var/defendedhit=round(J.damage+round(((src.taijutsu_total / 450)+(src.agility_total / 450))*2*J.damage))
											if(defendedhit<0)defendedhit=1
											//if(loc.loc:Safe!=1)src.
											if(loc.loc:Safe!=1)src.LevelStat(SPECIALIZATION_TAIJUTSU,1)
											if(defence_total<src.taijutsu_total/2)
												var/obj/Drag=new /obj/Drag/Dirt(c_target.loc)
												Drag.dir=c_target.dir
												step(c_target,src.dir)
												c_target.dir = get_dir(c_target,src)
												step_to(src,c_target,1)
											c_target.DealDamage(defendedhit,src,"TaiOrange",0,0,1)
											flick("defendhit",c_target)
											src.PlayAudio('Counter_Success.ogg', output = AUDIO_HEARERS)
										else
											flick("dodge",c_target)
											if(c_target.loc.loc:Safe!=1)c_target.LevelStat("Agility",rand(5,10))
				/*	for(var/obj/Training/T in orange(src,J.level))
						if(T.health>=1)
							var/undefendedhit=round(((damage+src.taijutsu_total+src.taijutsu_total)/3))//-c_target.defence/4)
							T.DealDamage(undefendedhit,src,"TaiOrange")
							if(T) if(T.Good) LevelStat(SPECIALIZATION_TAIJUTSU,rand(1,2))
							else LevelStat(SPECIALIZATION_TAIJUTSU,rand(0.2,1))
							if(T) if(T.Good) src.LevelStat(SPECIALIZATION_TAIJUTSU,1)
							else src.LevelStat(SPECIALIZATION_TAIJUTSU,0.2)
							src.PlayAudio('KickHit.ogg', output = AUDIO_HEARERS)
							T.Break(src)*/