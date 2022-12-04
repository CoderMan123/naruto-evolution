mob
	proc
		Shadow_Stab()
			if(CheckState(src, new/state/nara_attack_delay)) return
			for(var/obj/Jutsus/Shadow_Stab/J in src.jutsus)
				if(src.PreJutsu(J))
					if(loc.loc:Safe!=1) src.LevelStat("Ninjutsu",((J.maxcooltime*3/10)*jutsustatexp))
					if(J.level==1) J.damage=((jutsudamage*J.Sprice)/2)*0.7
					if(J.level==2) J.damage=((jutsudamage*J.Sprice)/1.5)*0.7
					if(J.level==3) J.damage=((jutsudamage*J.Sprice)/1.25)*0.7
					if(J.level==4) J.damage=(jutsudamage*J.Sprice)*0.7
					if(J.level<4) if(loc.loc:Safe!=1) J.exp+=jutsumastery*(J.maxcooltime/20); J.Levelup()
					var/mob/c_target=src.Target_Get(TARGET_MOB)
					AddState(src, new/state/nara_attack_delay, -1)
					flick("jutsuse",src)
					src.PlayAudio('dash.wav', output = AUDIO_HEARERS)
					var/mob/M=NaraTarget
					var/obj/O=new
					O.IsJutsuEffect=src
					O.icon='Multiple Shadow Stab.dmi'
					O.loc=M.loc
					O.layer=MOB_LAYER+1
					O.pixel_x=-16
					c_target.DealDamage(J.damage+round((src.ninjutsu_total / 200)*2*J.damage),src,"NinBlue")
					flick("stab",O)
					if(!M) M.Bleed()
					spawn(5)if(O)del(O)
					RemoveState(src, new/state/nara_attack_delay, STATE_REMOVE_ALL)

		Shadow_Choke()
			if(CheckState(src, new/state/nara_attack_delay)) return
			for(var/obj/Jutsus/Shadow_Choke/J in src.jutsus)
				if(src.PreJutsu(J))
					if(loc.loc:Safe!=1) src.LevelStat("Ninjutsu",((J.maxcooltime*3/10)*jutsustatexp))
					if(J.level==1) J.damage=((jutsudamage*J.Sprice)/2)*0.7
					if(J.level==2) J.damage=((jutsudamage*J.Sprice)/1.5)*0.7
					if(J.level==3) J.damage=((jutsudamage*J.Sprice)/1.25)*0.7
					if(J.level==4) J.damage=(jutsudamage*J.Sprice)*0.7
					if(J.level<4) if(loc.loc:Safe!=1) J.exp+=jutsumastery*(J.maxcooltime/20); J.Levelup()
					AddState(src, new/state/nara_attack_delay, -1)
					var/Timer=J.level
					flick("jutsuse",src)
					src.PlayAudio('dash.wav', output = AUDIO_HEARERS)
					var/mob/M=NaraTarget
					var/obj/O=new
					O.IsJutsuEffect=src
					O.icon='Shadowneckbind.dmi'
					O.loc=M.loc
					O.pixel_x=-16
					O.layer=MOB_LAYER+1
					flick("grab",O)
					M.DealDamage(J.damage+round((src.ninjutsu_total / 200)*2*J.damage),src,"NinBlue")
					while(Timer&&NaraTarget&&M)
						Timer--
						sleep(5)
						O.icon_state = "choke"
					del(O)
					RemoveState(src, new/state/nara_attack_delay, STATE_REMOVE_ALL)

		Shadow_Extension()
			for(var/obj/Jutsus/Shadow_Extension/J in src.jutsus)
				var/mob/c_target=src.Target_Get(TARGET_MOB)
				if(!c_target||!istype(c_target))
					src<<output("You require a target to use this technique.","Action.Output")
					return
				if(src.PreJutsu(J))
					if(loc.loc:Safe!=1) src.LevelStat("Ninjutsu",((J.maxcooltime*3/10)*jutsustatexp))
					if(J.level<4) if(loc.loc:Safe!=1) J.exp+=jutsumastery*(J.maxcooltime/20); J.Levelup()
					flick("jutsuse",src)
					src.PlayAudio('dash.wav', output = AUDIO_HEARERS)
					if(c_target)
						dir = get_dir(src,c_target)
						CreateTrailNara(c_target,J.level*4)

		Shadow_Explosion()
			if(CheckState(src, new/state/nara_attack_delay)) return
			for(var/obj/Jutsus/Shadow_Explosion/J in src.jutsus)
				if(src.PreJutsu(J))
					if(loc.loc:Safe!=1) src.LevelStat("Ninjutsu",((J.maxcooltime*3/10)*jutsustatexp))
					if(J.level==1) J.damage=((jutsudamage*J.Sprice)/2)/4
					if(J.level==2) J.damage=((jutsudamage*J.Sprice)/1.5)/4
					if(J.level==3) J.damage=((jutsudamage*J.Sprice)/1.25)/4
					if(J.level==4) J.damage=(jutsudamage*J.Sprice)/4
					if(J.level<4) if(loc.loc:Safe!=1) J.exp+=jutsumastery*(J.maxcooltime/20); J.Levelup()
					AddState(src, new/state/nara_attack_delay, -1)
					var/Timer=J.level
					flick("jutsuse",src)
					src.PlayAudio('dash.wav', output = AUDIO_HEARERS)
					var/mob/M=NaraTarget
					var/obj/O=new
					O.IsJutsuEffect=src
					O.icon='NewNara.dmi'
					O.loc=M.loc
					O.pixel_x=-16
					O.layer=MOB_LAYER+1
					flick("grab",O)
					while(Timer&&NaraTarget&&M)
						Timer--
						sleep(4)
						O.icon_state = "explode"
						M.DealDamage(J.damage+round((src.ninjutsu_total / 200)*2*J.damage),src,"NinBlue")
					del(O)
					RemoveState(src, new/state/nara_attack_delay, STATE_REMOVE_ALL)

		Shadow_Field()
			for(var/obj/Jutsus/Shadow_Field/J in src.jutsus)
				if(src.PreJutsu(J))
					if(loc.loc:Safe!=1) src.LevelStat("Ninjutsu",((J.maxcooltime*3/10)*jutsustatexp))
					if(J.level<4) if(loc.loc:Safe!=1) J.exp+=jutsumastery*(J.maxcooltime/20); J.Levelup()
					src.inshadowfield=1

					AddState(src, new/state/cant_attack, (5*J.level)+(src.genjutsu_total/3))
					AddState(src, new/state/slowed, (5*J.level)+(src.genjutsu_total/3))

					var/obj/A = new/obj(usr.loc)
					A.icon='shadowfield.dmi'
					A.icon_state="field"
					A.layer=MOB_LAYER-1
					var/matrix/m = matrix()
					m.Translate(-96,-96)
					A.transform = m
					A.linkfollow(src)
					flick("grow", A)
					sleep(5)
					var/duration = (5*J.level)+(src.genjutsu_total/3)
					var/timer
					spawn(duration) del A
					while(A)
						var/area/area = src.loc.loc
						if(area.Safe) del(A)
						sleep(1)
						timer++
						if(src.inshadowfield==0)
							del A
						if(A)
							for(var/mob/M in orange(3, src))
								AddState(M, new/state/cant_attack, (duration - timer), src)
								AddState(M, new/state/cant_move, (duration - timer), src)
								AddState(M, new/state/slowed, (duration - timer), src)

					src.inshadowfield=0