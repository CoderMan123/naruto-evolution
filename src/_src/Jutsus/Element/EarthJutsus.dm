mob
	proc
		Earth_Disruption()
			for(var/obj/Jutsus/Earth_Disruption/J in src.jutsus)
				if(src.PreJutsu(J))
					if(loc.loc:Safe!=1) src.LevelStat("Ninjutsu",rand(10,13))//XPGAIN
					flick("groundjutsuse",src)
					view(src)<<sound('Skill_BigRoketFire.wav',0,0)
					src.firing=1
					src.canattack=0
					var/TimeAsleep
					if(J.level==1) TimeAsleep=5
					if(J.level==2) TimeAsleep=10
					if(J.level==3) TimeAsleep=15
					if(J.level==4) TimeAsleep=20
					if(J.level<4) if(loc.loc:Safe!=1) J.exp+=rand(2,5); J.Levelup()
					for(var/mob/player/M in oview(J.level))
						if(!istype(M,M)||!M) continue
						M.icon_state="dead"
						M.move=0
						M.injutsu=1
						M.canattack=0
						M.DealDamage(J.level*5+src.strength/2+src.strength/3,src, "TaiOrange")
						spawn(TimeAsleep)
							if(!M||M.dead)continue
							M.icon_state=""
							M.move=1
							M.injutsu=0
							M.canattack=1
					src.firing=0
					src.canattack=1

		Earth_Release_Mud_River()
			for(var/obj/Jutsus/Earth_Release_Mud_River/J in src.jutsus)
				var/mob/c_target=src.Target_Get(TARGET_MOB)
				if(!c_target)
					src << output("This jutsu requires a target","Action.Output")
					return
				if(src.PreJutsu(J))

				/*	if(c_target.caged==1)
						src<<"You cannot use that jutsu while the target is Caged."
						return */
					if(loc.loc:Safe!=1) src.LevelStat("Ninjutsu",rand(3,5))
					flick("jutsuse",src)
					view(src)<<sound('man_fs_l_mt_wat.ogg',0,0)
					src.firing=1
					src.canattack=0
					var/TimeAsleep
					if(J.level==1) TimeAsleep=20
					if(J.level==2) TimeAsleep=40
					if(J.level==3) TimeAsleep=60
					if(J.level==4) TimeAsleep=80
					if(J.level<4) if(loc.loc:Safe!=1) J.exp+=rand(2,3); J.Levelup()
					new/obj/Jutsus/Effects/mudslide(src.loc)
					var/mob/M = c_target
					if(M)
						var/turf/T=M.loc
						spawn(10)
							if(M&&T)
								if(T==M.loc)
									new/obj/Jutsus/Effects/mudslide(M.loc)
									M.icon_state="dead"
									M.move=0
									M.injutsu=1
									M.canattack=0
									M.Sleeping=1
									spawn(TimeAsleep)
										if(!M||M.dead)continue
										M.icon_state=""
										M.move=1
										M.injutsu=0
										M.canattack=1
										M.Sleeping=0
								else src<<output("The jutsu did not connect.","Action.Output")
					src.firing=0
					src.canattack=1
		Dango()
			for(var/obj/Jutsus/Dango/J in src.jutsus)
				if(src.PreJutsu(J))
					if(loc.loc:Safe!=1) src.LevelStat("Taijutsu",0.2)
					flick("groundjutsu",src)
					src.firing=1
					src.canattack=0
					if(J.level==1) J.damage=2
					if(J.level==2) J.damage=4
					if(J.level==3) J.damage=7
					if(J.level==4) J.damage=10
					if(J.level<4) if(loc.loc:Safe!=1) J.exp+=rand(3,6); J.Levelup()
					var/obj/Dango/p1/A = new/obj/Dango/p1(src.loc)
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

		Doryuusou()
			for(var/obj/Jutsus/Doryuusou/J in src.jutsus)
				var/mob/c_target=src.Target_Get(TARGET_MOB)
				if(!c_target)
					src << output("This jutsu requires a target","Action.Output")
					return
				if(src.PreJutsu(J))

					if(loc.loc:Safe!=1) src.LevelStat("Ninjutsu",0.2)
					flick("groundjutsu",src)
					src.firing=1
					src.canattack=0
					if(J.level<4) if(loc.loc:Safe!=1) J.exp+=rand(4,6); J.Levelup()
					var/mob/M = c_target
					if(M)
						var/turf/T=M.loc
						spawn(10)
							if(M&&T)
								if(T==M.loc)
									var/obj/Y = new/obj
									Y.icon='newdoton.dmi'
									Y.icon_state=""
									Y.pixel_x=-55
									Y.loc=M.loc
									flick("dead",M)
									spawn(25)
										if(Y)
											del(Y)
									M.DealDamage((12+J.damage+usr.ninjutsu)*3,src,"NinBlue")
									spawn() if(M) M.Bleed()
								else src<<output("The jutsu did not connect.","Action.Output")
					spawn(1)
						src.firing=0
						src.canattack=1
		Mud_Dragon_Projectile()
			for(var/obj/Jutsus/Mud_Dragon_Projectile/J in src.jutsus)
				if(src.PreJutsu(J))
					var/mob/c_target=src.Target_Get(TARGET_MOB)
					if(loc.loc:Safe!=1) src.LevelStat("Ninjutsu",rand(5,7))
					if(J.level<4) if(loc.loc:Safe!=1) J.exp+=rand(2,5); J.Levelup()
					view()<<sound('man_fs_r_mt_wat.ogg')
					src.firing=1
					src.canattack=0
					src.move=0
					if(c_target)src.dir=get_dir(src,c_target)
					var/obj/Projectiles/Effects/JinraiBack/Aa=new(get_step(src,src.dir))
					Aa.icon = 'Mud Dragon Projectile.dmi'
					Aa.IsJutsuEffect=src
					Aa.dir = src.dir
					Aa.layer = src.layer+1
					Aa.pixel_y=16
					Aa.pixel_x=-16
					var/obj/Projectiles/Effects/JinraiHead/A=new(get_step(src,src.dir))
					A.icon = 'Mud Dragon Projectile.dmi'
					A.dir = src.dir
					A.Owner=src
					A.layer=src.layer+2
					A.fightlayer=src.fightlayer
					A.pixel_y=16
					A.pixel_x=-16
					A.damage=(J.level*50)+round(src.agility*2)+round(src.ninjutsu*5)
					A.level=J.level
					walk(A,dir,0)
					src.firing=0
					src.canattack=1
					src.move=1
					icon_state=""
					Aa.dir = src.dir
					spawn(15)
						src.firing=0
						src.canattack=1

		Earth_Style_Dark_Swamp()
			for(var/obj/Jutsus/Earth_Style_Dark_Swamp/J in src.jutsus)
				if(src.PreJutsu(J))
					if(loc.loc:Safe!=1) src.LevelStat("Ninjutsu",rand(4,8))
					var/mob/c_target=src.Target_Get(TARGET_MOB)
					src.move=0
					src.canattack=0
					src.injutsu=1
					src.firing=1
					flick("groundjutsu",src)
					src.icon_state = "groundjutsuse"
					var/mob/M
					if(c_target)M = c_target
					else M = src
					for(var/turf/T in view(0,M))new/obj/ESDS(T)
					spawn(1)
						for(var/turf/T in view(1,M))new/obj/ESDS(T)
						spawn(1)for(var/turf/T in view(2,M))new/obj/ESDS(T)
					spawn(3)
						src.icon_state = ""
						src.move=1
						src.canattack=1
						src.injutsu=0
						src.firing=0

		Earth_Release_Earth_Cage()
			for(var/obj/Jutsus/Earth_Release_Earth_Cage/J in src.jutsus)
				var/mob/c_target=src.Target_Get(TARGET_MOB)
				if(!c_target||!istype(c_target))
					src<<output("You must have a target to use this technique.","Action.Output")
					return

				if(src.PreJutsu(J))
					J.density = 1
					if(loc.loc:Safe!=1) src.LevelStat("Ninjutsu",rand(7,11))
					flick("jutsuse",src)
					view(src)<<sound('wind_leaves.ogg',0,0)
					src.firing=1
					src.canattack=0
					if(J.level==1)J.damage=2
					if(J.level==2)J.damage=4
					if(J.level==3)J.damage=5
					if(J.level==4)J.damage=6
					if(J.level<4)if(loc.loc:Safe!=1)J.exp+=rand(3,6); J.Levelup()
					if(c_target)
						flick("groundjutsu",src)
						sleep(4)
						src.icon_state="groundjutsuse"
						src.move=0
						spawn(3)if(src)
							src.firing=0
							src.canattack=1
							src.move=1
						if(c_target)
							if(c_target.health==0) return
							c_target.caged=1
							src.dir=get_dir(src,c_target)
							var/obj/A = new(c_target.loc)
							A.IsJutsuEffect=src
							A.Owner=src
							A.density=1
							A.layer=MOB_LAYER+1
							var/I=J.damage*5
							A.icon='doton cage.dmi'
							A.icon_state="stay"
							A.pixel_x=-48
							A.pixel_y=-16
							flick("create",A)
							I = I+round(src.ninjutsu/16)
							var/oldhealth=c_target.health
							var/I2=1
							while(I)
								I--
								I2+=1
								sleep(1)
								for(var/mob/F in A.loc)
									if(F.health==0) return
									F.health=oldhealth
									F.move=0
									F.injutsu=1
									F.canattack=0
									if(src)Prisoner=F
									spawn(2)
										if(F)
											F.move=1
											F.injutsu=0
											F.canattack=1
									if(I2==8)
										I2=0
										if(F)
											if(F.health==0) return
											F.DealDamage(J.damage,src,"NinBlue")
											oldhealth=(oldhealth-J.damage)
											F.health=oldhealth
								sleep(1)
							if(src)
								flick("delete",A)
								sleep(4)
								del(A)
							if(c_target)
								c_target.move=1
								c_target.injutsu=0
								c_target.caged=0
								c_target.canattack=1
							if(src)
								Prisoner=null
								src.icon_state=""
					if(src)
						src.firing=0
						src.canattack=1
						src.move=1
						src.injutsu=0

		MudWall()
			if(firing)return
			if(src.firing==0 && src.canattack==1)
				for(var/obj/Jutsus/MudWall/J in src.jutsus)
					if(src.PreJutsu(J))
						if(loc.loc:Safe!=1) src.LevelStat("Ninjutsu",rand(11,13))
						var/obj/Projectiles/Effects/mudwall/A=new/obj/Projectiles/Effects/mudwall(src.loc)
						A.Owner=src
						var/mob/forjutsu/mudwallmob/B=new/mob/forjutsu/mudwallmob(src.loc)
						B.health+=1



		EarthBoulder()
			if(src.firing==0 && src.canattack==1)
				for(var/obj/Jutsus/EarthBoulder/J in src.jutsus)
					if(src.PreJutsu(J))
						if(loc.loc:Safe!=1) src.LevelStat("Ninjutsu",rand(7,11))
						src.move=0
						src.injutsu=1
						if(J.level<4) if(loc.loc:Safe!=1) J.exp+=rand(8,10); J.Levelup()
						src.firing=1
						src.canattack=0
						flick("2fist",src)
						var/obj/earth/dotondango/A=new/obj/earth/dotondango(src.loc)
						A.ooowner=src
						A.dir=src.dir
						if(J.level==1) A.dmg=120
						if(J.level==2) A.dmg=140
						if(J.level==3) A.dmg=160
						if(J.level==4) A.dmg=180
						walk(A,A.dir)
						src.copy=null
						src.move=1
						src.firing=0
						src.canattack=1
						src.injutsu=0


