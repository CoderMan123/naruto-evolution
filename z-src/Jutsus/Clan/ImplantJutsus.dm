mob
	Void
		name = "The Void"
obj
	IntangBlocker //A turf which does not allow a player using intangibility to pass through
		icon = 'Misc Effects.dmi'
		icon_state = "IntangBlocker"
		New()
			..()
			src.icon_state = "Blank"
		Crossed(atom/a)
			if(ismob(a))
				var/mob/M = a
				M.Intang = 0
				var/mob/Void/Void = new()
				M.DealDamage(100000, Void)
				Void.loc = null
				M << "I ventured too far into the void!"
				world << output("[M] was knocked out by [Void]!","Action.Output")

mob
	proc
		Sharingan_Copy()
			for(var/obj/Jutsus/Sharingan_Copy/J in src.jutsus)
				/*if(Sharingan<=2)
					src<<output("You need to have a stronger Sharingan to activate this.","Action.Output")
					return*/
				if(src.PreJutsu(J))
					if(loc.loc:Safe!=1) src.LevelStat("Ninjutsu",((J.maxcooltime*3/10)*jutsustatexp))
					if(J.level<4) if(loc.loc:Safe!=1) J.exp+=jutsumastery*(J.maxcooltime/20); J.Levelup()
					if(src.jutsucopy==0)
						src.jutsucopy=1
						src << output("You will soon copy the next jutsu used by another Shinobi.","Action.Output")
					else
				//		else
						if(isobj(src.jutsucopy))
							var/obj/O = src.jutsucopy
							src.jutsus+=O
							src.doslot(O.name)
							spawn(1)src.jutsus-=O
						if(src.jutsucopy==1)src.jutsucopy=0

		Kamui()
			for(var/obj/Jutsus/Kamui/J in src.jutsus)
				/*if(Sharingan<=3)
					src<<output("You need to have Mangekyou Sharingan or higher activated to use this.","Action.Output")
					return*/
				var/mob/c_target=src.Target_Get(TARGET_MOB)
				if(!c_target||!istype(c_target))
					src<<output("You require a targeted player to use this technique.","Action.Output")
					return
				if(src.PreJutsu(J))
					if(loc.loc:Safe!=1) src.LevelStat("Ninjutsu",((J.maxcooltime*3/10)*jutsustatexp))
					if(J.level==1) J.damage=((jutsudamage*J.Sprice)/2)*0.8
					if(J.level==2) J.damage=((jutsudamage*J.Sprice)/1.5)*0.8
					if(J.level==3) J.damage=((jutsudamage*J.Sprice)/1.25)*0.8
					if(J.level==4) J.damage=(jutsudamage*J.Sprice)*0.8
					if(J.level<4) if(loc.loc:Safe!=1) J.exp+=jutsumastery*(J.maxcooltime/20); J.Levelup()
					var/obj/A = new/obj(usr.loc)
					A.icon='ClanEyes.dmi'
					A.icon_state="Kamui"
					A.layer=MOB_LAYER+1
					var/matrix/m = matrix()
					m.Translate(-16,16)
					A.transform = m
					A.linkfollow(src)
					spawn(10) del(A)
					var/mob/M = c_target
					var/Timer=J.level*5
					spawn(10)
						M=src.Target_Get(TARGET_MOB)
						if(M)
							var/obj/O = new(c_target.loc)
							O.IsJutsuEffect=src
							O.icon='kamui.dmi'
							O.icon_state="kamui"
							O.layer=MOB_LAYER+1
							O.pixel_x=-35
							O.name="kamui"
							O.linkfollow(c_target)
							while(Timer&&c_target&&!c_target.dead)
								Timer--
								var/area/B=c_target.loc.loc
								if(B.Safe) break
								c_target.DealDamage((J.damage+round((src.ninjutsu_total / 200)*2*J.damage))/20, src, "NinBlue")
								sleep(2)
							if(O)del(O)
						else
							src<<output("The jutsu did not connect.","Action.Output")

		WarpDim()
			for(var/obj/Jutsus/WarpDim/J in src.jutsus)
			
				var/mob/c_target = src.Target_Get(TARGET_MOB)
				if(c_target)
					if(istype(c_target, /mob/npc/combat/political_escort))
						src<<output("It appears that the Daimyo is protected against spacial inteferance!","Action.Output")
						return

					if(istype(c_target, /mob/npc/combat/white_zetsu))
						src<<output("Something is preventing me from pulling it into the dimension!","Action.Output")
						return

					if(istype(c_target, /mob/training))
						src<<output("I can't do that, it's fastened to the ground!","Action.Output")
						return

					if(locate(/obj/Inventory/mission/deliver_intel) in c_target.contents)
						src<<output("The seal in their scroll is preventing spacial travel!","Action.Output")
						return

					if(c_target.jailed == 1)
						src<<output("Your target is jailed.","Action.Output")
						return

				if(src.loc.z == 4)
					src<<output("You can't use this in the chuunin exam!","Action.Output")
					return

				if(src.dueling == 1)
					src<<output("You cant use this during a duel!","Action.Output")
					return

				if(src.jailed == 1)
					src<<output("You are jailed.","Action.Output")
					return

				if(src.PreJutsu(J))
					if(loc.loc:Safe!=1) src.LevelStat("Ninjutsu",((J.maxcooltime*3/10)*jutsustatexp))
					if(J.level==1) J.damage=50
					if(J.level==2) J.damage=100
					if(J.level==3) J.damage=150
					if(J.level==4) J.damage=250
					if(src.loc in block(locate(148,128,8),locate(199,199,8)))//if used inside dimension or arena
						view(10)<<"[usr]: Let us get back to the real world."
						var/obj/O = new(c_target.loc)
						O.IsJutsuEffect=src
						O.icon='kamui.dmi'
						O.icon_state="kamui"
						O.layer=MOB_LAYER+1
						O.pixel_x=-35
						O.name="kamui"
						O.loc = src.loc
						sleep(10)
						if(src.PrevLoc == null) PrevLoc = src.MapLoadSpawn()
						if(c_target)
							RemoveState(c_target, new/state/in_warp_dimension, STATE_REMOVE_ALL)
							c_target.loc=PrevLoc
						src.loc=PrevLoc
						flick("jutsuse",src)
						src.icon_state = "jutsuse"
						del O
					else //anywhere else
						view(10)<<"[usr]: Let's take this to my own little world."
						PrevLoc = src.loc
						var/mob/M = c_target
						var/obj/O = new(c_target.loc)
						O.IsJutsuEffect=src
						O.icon='kamui.dmi'
						O.icon_state="kamui"
						O.layer=MOB_LAYER+1
						O.pixel_x=-35
						O.name="kamui"
						O.loc = src.loc
						spawn(10)
							M=src.Target_Get(TARGET_MOB)
							if(M)
								AddState(M, new/state/in_warp_dimension, 200)
								src.loc=locate(175,183,8)
								del O
							else
								src<<output("You failed to pull them in with you!","Action.Output")
								src.loc=locate(175,183,8)
								del O


		Intangible_Jutsu()
			for(var/obj/Jutsus/Intangible_Jutsu/J in src.jutsus)
				if(Intang)
					src << output("You're no longer intangible.","Action.Output")
					src.Intang=0
					src.density=1
					RemoveState(src, new/state/intangible, STATE_REMOVE_ALL)
					return
				else
					if(jailed==1)
						src<<output("You're not allowed to use intangibility to break out of jail!","Action.Output")
						return
					if(src.loc in block(locate(148,128,8),locate(199,199,8)))
						src<<output("You can't use this in the dimension or an arena battle!","Action.Output")
						return

					if(src.PreJutsu(J))
						if(loc.loc:Safe!=1) src.LevelStat("Ninjutsu",((J.maxcooltime*3/20)*jutsustatexp))
						if(loc.loc:Safe!=1) src.LevelStat("Genjutsu",((J.maxcooltime*3/20)*jutsustatexp))
						src << output("You become intangible.","Action.Output")
						AddState(src, new/state/intangible, -1)
						src.Intang=1
						src.density=0
						//spawn()
						while(src.Intang)
							src.DealDamage(50, src, "aliceblue", 0 , 1)
							src.density=0
							sleep(10)
							if(src.chakra<=0)
								src.chakra=0
								src << output("You're no longer intangible.","Action.Output")
								src.Intang=0
								src.density=1
								RemoveState(src, new/state/intangible, STATE_REMOVE_ALL)

