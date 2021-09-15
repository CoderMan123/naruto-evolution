mob
	proc
		Snake_Release_Jutsu()
			for(var/obj/Jutsus/Snake_Release_Jutsu/J in src.jutsus)
				if(src.PreJutsu(J))
					var/mob/c_target=src.Target_Get(TARGET_MOB)
					src.PlayAudio('man_fs_r_mt_wat.ogg', output = AUDIO_HEARERS)
					src.firing=1
					src.canattack=0
					src.move=0
					if(c_target)src.dir=get_dir(src,c_target)
					var/obj/Projectiles/Effects/JinraiBack/Aa=new(get_step(src,src.dir))
					Aa.icon = 'Snake_Release_Jutsu.dmi'
					Aa.IsJutsuEffect=src
					Aa.dir = src.dir
					Aa.layer = src.layer+1
					Aa.pixel_y=16
					Aa.pixel_x=-16
					var/obj/Projectiles/Effects/JinraiHead/A=new(get_step(src,src.dir))
					A.icon = 'Snake_Release_Jutsu.dmi'
					A.dir = src.dir
					A.Owner=src
					A.layer=src.layer
					A.fightlayer=src.fightlayer
					A.pixel_y=16
					A.pixel_x=-16
					A.damage=(J.level*50)+round(src.agility*2)+round(src.ninjutsu*6)
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

		Snake_Skin_Replacement_Jutsu()
			for(var/obj/Jutsus/Snake_Skin_Replacement_Jutsu/J in src.jutsus)
				if(src.PreJutsu(J))
					if(loc.loc:Safe!=1) src.LevelStat("Ninjutsu",((J.maxcooltime*3/10)*jutsustatexp))
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
						O.icon = 'Snake_Skin_Replacement_Jutsu.dmi'
						O.pixel_x=-16
						spawn(1) step_rand(O)
						spawn(10)if(O)del(O)
					for(var/mob/M in oview(src,20))M.Target_Remove()
					src.loc = T

		Sage_Bind()//HERE This just isn't fucking working.
			return//temp
		//	for(var/obj/Jutsus/Snake_Release_Jutsu/J in src.jutsus)

				/*if(src.PreJutsu(J))
					var/mob/c_target=src.Target_Get(TARGET_MOB)
					if(loc.loc:Safe!=1) src.LevelStat("Ninjutsu",rand(1,2))
					if(J.level<4) if(loc.loc:Safe!=1) J.exp+=rand(2,5); J.Levelup()
					src.PlayAudio('man_fs_r_mt_wat.ogg', output = AUDIO_HEARERS)
					src.firing=1
					src.canattack=0
					src.move=0
					flick("jutsuse",src)
					if(c_target)src.dir=get_dir(src,c_target)
					var/obj/Projectiles/Effects/JinraiBack/Aa=new(get_step(src,src.dir))
					Aa.icon = 'Sage_Bind.dmi'
					Aa.IsJutsuEffect=src
					Aa.dir = src.dir
					Aa.layer = src.layer+1
					Aa.pixel_y=16
					Aa.pixel_x=-16
					var/obj/Projectiles/Effects/JinraiHead/A=new(get_step(src,src.dir))
					A.icon = 'Sage_Bind.dmi'
					A.dir = src.dir
					A.Owner=src
					A.layer=src.layer
					A.fightlayer=src.fightlayer
					A.pixel_y=16
					A.pixel_x=-16
					A.damage=(J.level*50)+round(src.agility*2)+round(src.ninjutsu*6)
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

					flick("Bind",c_target)
					src.PlayAudio('wind_leaves.ogg', output = AUDIO_HEARERS)
					if(J.level<4) if(loc.loc:Safe!=1) J.exp+=rand(2,5); J.Levelup()
					var/Time=J.level*1.5
					c_target.overlays+='Sage_Bind.dmi'
					c_target.icon_state = "bound"
					c_target.move=0
					c_target.injutsu=1
					c_target.canattack=0
					while(Time&&c_target)
						sleep(10)
						Time--
						if(c_target)
							c_target.overlays-='Sage_Bind.dmi'
							if(!c_target.dead)
								c_target.move=1
								c_target.injutsu=0
								c_target.canattack=1*/

		Sage_Style_Giant_Rasengan()
			for(var/obj/Jutsus/Sage_Style_Giant_Rasengan/J in src.jutsus)
				if(!insage) // things like this come first
					src<<output("You must be in Sage Mode in order to use this.","Action.Output")
					return
				if(src.PreJutsu(J))
					if(Effects["Rasengan"])
						Effects["Rasengan"]=null
						src.overlays-=image('Rasengan.dmi',"spin")
						return
					if(loc.loc:Safe!=1) src.LevelStat("Ninjutsu",((J.maxcooltime*3/20)*jutsustatexp))
					if(loc.loc:Safe!=1) src.LevelStat("Precision",((J.maxcooltime*3/20)*jutsustatexp))
					if(J.level<4) if(loc.loc:Safe!=1) J.exp+=jutsumastery*(J.maxcooltime/20); J.Levelup()
					if(J.level==1) J.damage=((jutsudamage*J.Sprice)/2.5)
					if(J.level==2) J.damage=((jutsudamage*J.Sprice)/2)
					if(J.level==3) J.damage=((jutsudamage*J.Sprice)/1.5)
					if(J.level==4) J.damage=(jutsudamage*J.Sprice)
					var/mob/c_target=src.Target_Get(TARGET_MOB)
					src.move=0
					src.injutsu=1
					src.canattack=0
					src.firing=1
					src.icon_state="jutsuse"
					view(src) << output("<b><font color = gold>[usr]says: Sage Style...GIANT RASENGAN!","Action.Output")
					var/obj/I = new/obj
					I.IsJutsuEffect=src
					if(dir!=SOUTH) I.layer=MOB_LAYER-1
					I.loc = src.loc
					I.icon = 'Sage Style Giant Rasengan.dmi'
					I.pixel_y=-32
					I.pixel_x=-32
					switch(src.dir)
						if(SOUTH)
							I.pixel_y=-8
							I.layer = MOB_LAYER+1
						if(NORTH)
							I.pixel_y=5
							I.pixel_x=-12
						if(EAST)I.pixel_x=-13
						if(WEST)I.pixel_x=-11
					flick("Form",I)
					spawn(3)if(I)I.icon_state = "Spin"
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
					I.icon_state = "Form"
					I.pixel_x=0
					walk_to(I,src)
					src.move=1
					src.injutsu=0
					src.canattack=1
					src.firing=0
					if(Effects["Rasengan"]<4||Prisoned)
						del(I)
						src.copy=null
						Effects["Rasengan"]=null
						ArrowTasked=null
					else
						ArrowTasked=null
						src.copy=null
						var/rashit=0
						var/rcount=0
						while(rashit==0 && rcount <> 15)
							move=1
							rcount+=1
							if(c_target)step_towards(src,c_target)
							else step(src,src.dir)
							move=0
							var/obj/Drag/Dirt/D=new(src.loc)
							D.dir=src.dir
							for(var/mob/M in get_step(src,src.dir))
								if(M)
									flick("punchr",src)
									rashit=1
									del(I)
									M.icon_state="push"
									M.injutsu=1
									M.canattack=0
									M.firing=1
									walk(M,src.dir)
									if(M.client)spawn(1)if(M)M.ScreenShake(4)
									spawn(10)
										if(M)
											walk(M,0)
											M.injutsu=0
											if(!M.swimming)M.icon_state=""
											M.canattack=1
											M.firing=0
											var/obj/Ex = new/obj
											Ex.icon = 'Sage Style Giant Rasengan Explode.dmi'
											Ex.icon_state = "ow"
											Ex.layer=MOB_LAYER+2
											Ex.pixel_x=-112
											Ex.loc = M.loc
											spawn(20)if(Ex)del(Ex)
											M.DealDamage(round(J.damage+((src.ninjutsu / 300)+(src.precision / 300))*2*J.damage),src,"NinBlue")
							sleep(0.5)
						if(I)del(I)
					move=1
					Effects["Rasengan"]=null

		SageMode()
			if(firing)return
			if(src.firing==0 && src.canattack==1)
				for(var/obj/Jutsus/SageMode/J in src.jutsus)
					if(src.PreJutsu(J))
						if(loc.loc:Safe!=1) src.LevelStat("Ninjutsu",((J.maxcooltime*3/10)*jutsustatexp))
						if(J.level<4) if(loc.loc:Safe!=1) J.exp+=jutsumastery*(J.maxcooltime/20); J.Levelup()
						src.PlayAudio('Skill_MashHit.wav', output = AUDIO_HEARERS)
						src.overlays+='Jutsus/Misc/MiscJutIcons/sage.dmi'
						src.ninjutsu+=20
						src.insage=1
						src.strength+=10
						spawn(200)
							src.ninjutsu-=20
							src.strength-=10
							src.insage=0
							src.overlays=0
							src.RestoreOverlays()
							src<<"Sage Mode wears off..."

		HiddenSnakeStab()
			if(firing)return
			if(src.firing==0 && src.canattack==1)
				for(var/obj/Jutsus/HiddenSnakeStab/J in src.jutsus)
					if(src.PreJutsu(J))
						if(loc.loc:Safe!=1) src.LevelStat("Ninjutsu",((J.maxcooltime*3/10)*jutsustatexp))
						if(J.level<4) if(loc.loc:Safe!=1) J.exp+=jutsumastery*(J.maxcooltime/20); J.Levelup()
						if(J.level==1) J.damage=((jutsudamage*J.Sprice)/2.5)
						if(J.level==2) J.damage=((jutsudamage*J.Sprice)/2)
						if(J.level==3) J.damage=((jutsudamage*J.Sprice)/1.5)
						if(J.level==4) J.damage=(jutsudamage*J.Sprice)
						var/mob/Z
						var/i
						src.move=0
						src.injutsu=1
						src.firing=1
						src.canattack=0
						var/obj/A = new(get_step(src,src.dir))
						A.icon='Snake Jutsu.dmi'
						A.dir=src.dir
						A.layer=MOB_LAYER+1
						switch(A.dir)
							if(NORTH)
								A.pixel_x=-35
								A.pixel_y=3
							if(SOUTH)
								A.pixel_x=-29
								A.pixel_y=-36
							if(EAST)
								A.pixel_x=-12
								A.pixel_y=-23
							if(WEST)
								A.pixel_x=-51
								A.pixel_y=-22
						src.icon_state = "punchrS"
						for(var/mob/M in get_step(src,src.dir))
							Z=M
							break
						if(Z)
							Z.move=0
							Z.canattack=0
							for(i=0,i<2,i++)
								sleep(2)
								Z.DealDamage((J.damage+round((src.ninjutsu / 150)*2*J.damage))/2,src,"NinBlue")
								Z.Bleed()
								Z.PlayAudio('knife_hit1.wav', output = AUDIO_HEARERS)
								step_away(Z,src,3)
								Z.dir=get_dir(Z,src)
						else
							sleep(4)
						sleep(4)
						if(A) del A
						src.overlays=0
						src.RestoreOverlays()
						src.icon_state=""
						src.move=1
						src.injutsu=0
						src.firing=0
						src.canattack=1
						sleep(1)
						if(Z)
							Z.move=1
							Z.canattack=1

		Summoning_Snake()
			if(firing)return
			if(src.firing==0 && src.canattack==1)
				for(var/obj/Jutsus/Snake_Summoning/J in src.jutsus)
					if(src.PreJutsu(J))
						if(loc.loc:Safe!=1) src.LevelStat("Ninjutsu",((J.maxcooltime*3/10)*jutsustatexp))
						var/obj/SMOKE = new/obj/MiscEffects/SmokeBomb(usr.loc)
						SMOKE.loc=usr.loc
						src.PlayAudio('flashbang_explode2.wav', output = AUDIO_HEARERS)
						var/mob/summonings/SnakeSummoning/B = new/mob/summonings/SnakeSummoning(usr.loc)
						B.loc=usr.loc
						B.OWNER=src
						var/mob/c_target=src.Target_Get(TARGET_MOB)
						if(c_target)
							walk_to(B,c_target)
						spawn(100)
							del(B)