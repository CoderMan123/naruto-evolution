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
									spawn(TimeAsleep)
										if(!M||M.dead)continue
										M.icon_state=""
								else src<<output("The jutsu did not connect.","Action.Output")

		Seal_of_Terror()
			for(var/obj/Jutsus/Seal_of_Terror/J in src.jutsus)
				var/mob/c_target=src.Target_Get(TARGET_MOB)
				if(!c_target)
					src<<"You need a target for this jutsu."
					return
				if(c_target.dead==1)
					src<<"Your target is dead."
					return
				if(src.PreJutsu(J))
					flick("jutsuse",src)
					if(J.level==1) J.damage=1*src.ninjutsu
					if(J.level==2) J.damage=1.5*src.ninjutsu
					if(J.level==3) J.damage=2*src.ninjutsu
					if(J.level==4) J.damage=2.5*src.ninjutsu
					if(J.level<4) if(loc.loc:Safe!=1) J.exp+=rand(3,6); J.Levelup()
					c_target.overlays+='Seal of Terror.dmi'
					spawn(J.level*8)if(src)
						c_target.RestoreOverlays()
						c_target.DealDamage(J.damage,src,"NinBlue",0,1)

		Soul_Devastator_Seal()
			for(var/obj/Jutsus/Soul_Devastator_Seal/J in src.jutsus)
				if(CheckState(src, new/state/cant_move)) return
				var/mob/c_target=src.Target_Get(TARGET_MOB)
				if(!c_target)
					src<<"You need a target for this jutsu."
					return
				if(c_target.dead==1)
					src<<"Your target is dead."
					return

				if(src.PreJutsu(J))
					flick("jutsuse",src)
					if(J.level==1) J.damage=10
					if(J.level==2) J.damage=15
					if(J.level==3) J.damage=20
					if(J.level==4) J.damage=30
					if(J.level<4) if(loc.loc:Safe!=1) J.exp+=rand(4,7); J.Levelup()
					c_target.overlays+='SoulDevestator.dmi'
					spawn(J.damage)if(src)
						c_target.RestoreOverlays()
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
					src.overlays+='Shiki Fuujin.dmi'
					Bind(src, 30)
					Bind(c_target, 30)
					spawn(30)
						src.DealDamage(round(src.ninjutsu*5+src.taijutsu*5+src.genjutsu*5),src,"black")
						c_target.DealDamage(round(src.ninjutsu*7.5+src.genjutsu*7.5 +src.taijutsu*7.5),src,"NinBlue")
						spawn(10)
							src.overlays-='Shiki Fuujin.dmi'
							src.RestoreOverlays()
