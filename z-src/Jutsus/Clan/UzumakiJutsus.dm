mob
	proc
		LimbParalyzeSeal()
			for(var/obj/Jutsus/LimbParalyzeSeal/J in src.jutsus)
				var/mob/c_target=src.Target_Get(TARGET_MOB)
				if(!c_target)
					src << output("This jutsu requires a target","Action.Output")
					return
				if(src.PreJutsu(J))
					if(loc.loc:Safe!=1) src.LevelStat("Ninjutsu",rand(1,2))
					flick("jutsuse",src)
					src.PlayAudio('man_fs_l_mt_wat.ogg', output = AUDIO_HEARERS)
					src.firing=1
					src.canattack=0
					var/TimeAsleep
					if(J.level==1) TimeAsleep=30
					if(J.level==2) TimeAsleep=40
					if(J.level==3) TimeAsleep=50
					if(J.level==4) TimeAsleep=60
					if(J.level<4) if(loc.loc:Safe!=1) J.exp+=rand(3,5); J.Levelup()
					new/obj/Jutsus/Effects/limbparalyze(src.loc)
					var/mob/M = c_target
					if(M)
						var/turf/T=M.loc
						spawn(10)
							if(M&&T)
								if(T==M.loc)
									new/obj/Jutsus/Effects/limbparalyze(M.loc)
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

		Seal_of_Terror()
			for(var/obj/Jutsus/Seal_of_Terror/J in src.jutsus)
				if(injutsu) return
				if(copy=="Climb") return
				var/mob/c_target=src.Target_Get(TARGET_MOB)
				if(!c_target)
					src<<"You need a target for this jutsu."
					return
				if(c_target.dead==1)
					src<<"Your target is dead."
					return
				if(src.PreJutsu(J))
					flick("jutsuse",src)
					src.firing=1
					src.canattack=0
					src.injutsu=1
					if(J.level==1) J.damage=1*src.ninjutsu
					if(J.level==2) J.damage=1.5*src.ninjutsu
					if(J.level==3) J.damage=2*src.ninjutsu
					if(J.level==4) J.damage=2.5*src.ninjutsu
					if(J.level<4) if(loc.loc:Safe!=1) J.exp+=rand(3,6); J.Levelup()
					c_target.overlays+='Seal of Terror.dmi'
					c_target.firing=1
					c_target.canattack=0
					c_target.move=0
					c_target.injutsu=1
					spawn(J.level*8)if(src)
						src.firing=0
						src.move=1
						src.injutsu=0
						src.canattack=1
						c_target.firing=0
						c_target.RestoreOverlays()
						c_target.canattack=1
						c_target.move=1
						c_target.injutsu=0
						c_target.DealDamage(J.damage,src,"NinBlue",0,1)

		Soul_Devastator_Seal()
			for(var/obj/Jutsus/Soul_Devastator_Seal/J in src.jutsus)
				if(!move) return
				if(injutsu) return
				if(copy=="Climb") return
				var/mob/c_target=src.Target_Get(TARGET_MOB)
				if(!c_target)
					src<<"You need a target for this jutsu."
					return
				if(c_target.dead==1)
					src<<"Your target is dead."
					return

				if(src.PreJutsu(J))
					flick("jutsuse",src)
					src.firing=1
					src.canattack=0
					src.move=0
					src.injutsu=1
					if(J.level==1) J.damage=10
					if(J.level==2) J.damage=15
					if(J.level==3) J.damage=20
					if(J.level==4) J.damage=30
					if(J.level<4) if(loc.loc:Safe!=1) J.exp+=rand(4,7); J.Levelup()
					c_target.overlays+='SoulDevestator.dmi'
					c_target.firing=1
					c_target.canattack=0
					c_target.move=0
					c_target.injutsu=1
					spawn(J.damage)if(src)
						src.firing=0
						src.move=1
						src.injutsu=0
						src.canattack=1
						c_target.firing=0
						c_target.RestoreOverlays()
						c_target.canattack=1
						c_target.move=1
						c_target.injutsu=0
						c_target.DealDamage(J.damage + src.taijutsu*2 + src.ninjutsu*2 + src.genjutsu*2,src,"NinBlue",0,1)

		Reaper_Death_Seal()
			for(var/obj/Jutsus/Reaper_Death_Seal/J in src.jutsus)
				var/mob/c_target=src.Target_Get(TARGET_MOB)
				if(!c_target)
					src<<"You need a target for this jutsu."
					return
				if(c_target.dead==1)
					src<<"Your target is dead."
					return
				if(get_dist(src,c_target)>2)
					src<<"Your target isn't near you."
					return
				if(src.PreJutsu(J))
					if(loc.loc:Safe!=1) src.LevelStat("Ninjutsu",rand(15,25))
					src.firing=1
					src.injutsu=1
					src.canattack=0
					src.move=0
					c_target.move=0
					c_target.firing=1
					c_target.injutsu=1
					c_target.canattack=0
					src.overlays+='Shiki Fuujin.dmi'
					spawn(30)
						src.DealDamage(round(src.ninjutsu*5+src.taijutsu*5+src.genjutsu*5),src,"black")
						c_target.DealDamage(round(src.ninjutsu*7.5+src.genjutsu*7.5 +src.taijutsu*7.5),src,"NinBlue")
						c_target.move=1
						c_target.firing=0
						c_target.injutsu=0
						c_target.canattack=1
						src.firing=0
						src.injutsu=0
						src.canattack=1
						src.move=1
						spawn(10)
							src.overlays-='Shiki Fuujin.dmi'
							src.RestoreOverlays()
