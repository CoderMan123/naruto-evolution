mob
	proc
		Shadow_Stab()
			for(var/obj/Jutsus/Shadow_Stab/J in src.jutsus)
				if(src.PreJutsu(J))
					if(loc.loc:Safe!=1) src.LevelStat("Ninjutsu",((J.maxcooltime*3/10)*jutsustatexp))
					if(J.level==1) J.damage=((jutsudamage*J.Sprice)/2.5)*0.7
					if(J.level==2) J.damage=((jutsudamage*J.Sprice)/2)*0.7
					if(J.level==3) J.damage=((jutsudamage*J.Sprice)/1.5)*0.7
					if(J.level==4) J.damage=(jutsudamage*J.Sprice)*0.7
					if(J.level<4) if(loc.loc:Safe!=1) J.exp+=jutsumastery*(J.maxcooltime/20); J.Levelup()
					flick("jutsuse",src)
					view(src)<<sound('dash.wav',0,0)
					var/mob/M=NaraTarget
					var/obj/O=new
					O.IsJutsuEffect=src
					O.icon='Multiple Shadow Stab.dmi'
					O.loc=M.loc
					O.layer=MOB_LAYER+1
					O.pixel_x=-16
					M.DealDamage(J.damage+round((src.ninjutsu / 150)*2*J.damage),src,"NinBlue")
					flick("stab",O)
					if(!M) M.Bleed()
					spawn(5)if(O)del(O)

		Shadow_Choke()
			for(var/obj/Jutsus/Shadow_Choke/J in src.jutsus)
				if(src.PreJutsu(J))
					if(loc.loc:Safe!=1) src.LevelStat("Ninjutsu",((J.maxcooltime*3/10)*jutsustatexp))
					if(J.level==1) J.damage=((jutsudamage*J.Sprice)/2.5)*0.7
					if(J.level==2) J.damage=((jutsudamage*J.Sprice)/2)*0.7
					if(J.level==3) J.damage=((jutsudamage*J.Sprice)/1.5)*0.7
					if(J.level==4) J.damage=(jutsudamage*J.Sprice)*0.7
					if(J.level<4) if(loc.loc:Safe!=1) J.exp+=jutsumastery*(J.maxcooltime/20); J.Levelup()
					var/Timer=J.level
					flick("jutsuse",src)
					view(src)<<sound('dash.wav',0,0)
					var/mob/M=NaraTarget
					var/obj/O=new
					O.IsJutsuEffect=src
					O.icon='Shadowneckbind.dmi'
					O.loc=M.loc
					O.pixel_x=-16
					O.layer=MOB_LAYER+1
					flick("grab",O)
					M.DealDamage(J.damage+round((src.ninjutsu / 150)*2*J.damage),src,"NinBlue")
					while(Timer&&NaraTarget&&M)
						Timer--
						sleep(4)
						O.icon_state = "choke"
					del(O)

		Shadow_Extension()
			for(var/obj/Jutsus/Shadow_Extension/J in src.jutsus)
				var/mob/c_target=src.Target_Get(TARGET_MOB)
				if(!c_target||!istype(c_target))
					src<<output("You require a target to use this technique.","Action.Output")
					return
				if(src.PreJutsu(J))
					if(loc.loc:Safe!=1) src.LevelStat("Genjutsu",((J.maxcooltime*3/10)*jutsustatexp))
					if(J.level<4) if(loc.loc:Safe!=1) J.exp+=jutsumastery*(J.maxcooltime/20); J.Levelup()
					flick("jutsuse",src)
					view(src)<<sound('dash.wav',0,0)
					if(c_target)
						dir = get_dir(src,c_target)
						CreateTrailNara(c_target,J.level*4)

		Shadow_Explosion()
			for(var/obj/Jutsus/Shadow_Explosion/J in src.jutsus)
				if(src.PreJutsu(J))
					if(loc.loc:Safe!=1) src.LevelStat("Ninjutsu",((J.maxcooltime*3/10)*jutsustatexp))
					if(J.level==1) J.damage=((jutsudamage*J.Sprice)/2.5)/4
					if(J.level==2) J.damage=((jutsudamage*J.Sprice)/2)/4
					if(J.level==3) J.damage=((jutsudamage*J.Sprice)/1.5)/4
					if(J.level==4) J.damage=(jutsudamage*J.Sprice)/4
					if(J.level<4) if(loc.loc:Safe!=1) J.exp+=jutsumastery*(J.maxcooltime/20); J.Levelup()
					var/Timer=J.level
					flick("jutsuse",src)
					view(src)<<sound('dash.wav',0,0)
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
						M.DealDamage(J.damage+round((src.ninjutsu / 150)*2*J.damage),src,"NinBlue")
					del(O)

		Shadow_Field()
			for(var/obj/Jutsus/Shadow_Field/J in src.jutsus)
				if(src.PreJutsu(J))
					if(loc.loc:Safe!=1) src.LevelStat("Genjutsu",((J.maxcooltime*3/10)*jutsustatexp))
					if(J.level<4) if(loc.loc:Safe!=1) J.exp+=jutsumastery*(J.maxcooltime/20); J.Levelup()
					src.inshadowfield=1
					src.canattack=0
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
					spawn((5*J.level)+(src.genjutsu/3)) del A
					var/list/caught = new()
					var/mob/M
					while(A)
						sleep(1)
						if(src.inshadowfield==0)
							del A
						for(M in orange(3,src))
							caught+= M
							if(!M.likeaclone)
								M.move=0
								M.canattack=0
					for(M in caught)
						M.move=1
						M.canattack=1
					src.inshadowfield=0
					src.canattack=1