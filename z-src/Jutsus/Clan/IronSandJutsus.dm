mob
	proc


		Black_Iron_Fists()
			for(var/obj/Jutsus/Black_Iron_Fists/J in src.jutsus)
				if(CheckState(src, new/state/Iron_Fists))
					RemoveState(src, new/state/Iron_Fists, STATE_REMOVE_ALL)
					src.left_iron_fist = null
					src.right_iron_fist = null
					return
				if(src.PreJutsu(J))
					if(loc.loc:Safe!=1) src.LevelStat("Ninjutsu",((J.maxcooltime*3/20)*jutsustatexp))
					if(J.level==1) J.damage=((jutsudamage*J.Sprice)/1.75)/12
					if(J.level==2) J.damage=((jutsudamage*J.Sprice)/1.5)/12
					if(J.level==3) J.damage=((jutsudamage*J.Sprice)/1.25)/12
					if(J.level==4) J.damage=(jutsudamage*J.Sprice)/12
					if(J.level<4) if(loc.loc:Safe!=1) J.exp+=jutsumastery*(J.maxcooltime/20); J.Levelup()
					if(!CheckState(src, new/state/Iron_Fists))
						AddState(src, new/state/Iron_Fists, -1)
						sleep(1)

						var/obj/Iron_Fist_Left/iron_fist_left = new/obj/Iron_Fist_Left(src.left_iron_fist_anchor)
						iron_fist_left.owner = src
						src.left_iron_fist = iron_fist_left
						iron_fist_left.level = J.level
						iron_fist_left.damage = J.damage + round((src.ninjutsu_total / 200)*2*J.damage)

						var/obj/Iron_Fist_Right/iron_fist_right = new/obj/Iron_Fist_Right(src.right_iron_fist_anchor)
						iron_fist_right.owner = src
						src.right_iron_fist = iron_fist_right
						iron_fist_right.level = J.level
						iron_fist_right.damage = J.damage + round((src.ninjutsu_total / 200)*2*J.damage)
						
						while(iron_fist_left || iron_fist_right)
							sleep(10)
							src.DealDamage(20, src, "aliceblue", 0, 1)
						src << output("Your iron fists have deactivated.","Action.Output")
						

		Grasp_of_Iron()
			for(var/obj/Jutsus/Grasp_of_Iron/J in src.jutsus)
				if(!CheckState(src, new/state/Iron_Fists))
					src << output("I can't use this without my iron fists.","Action.Output")
					return
				if(src.PreJutsu(J))
					if(loc.loc:Safe!=1) src.LevelStat("Ninjutsu",((J.maxcooltime*3/20)*jutsustatexp))
					if(J.level==1) J.damage=((jutsudamage*J.Sprice)/1.75)/6
					if(J.level==2) J.damage=((jutsudamage*J.Sprice)/1.5)/6
					if(J.level==3) J.damage=((jutsudamage*J.Sprice)/1.25)/6
					if(J.level==4) J.damage=(jutsudamage*J.Sprice)/6
					if(J.level<4) if(loc.loc:Safe!=1) J.exp+=jutsumastery*(J.maxcooltime/20); J.Levelup()
					if(src.Hand == "Left" || src.Hand == "Kick") AddState(src, new/state/Iron_Fist_Grabbing_Left, J.level * 2)	
					else AddState(src, new/state/Iron_Fist_Grabbing_Right, J.level * 2)

		Shield_of_Iron()
			for(var/obj/Jutsus/Shield_of_Iron/J in src.jutsus)
				if(!CheckState(src, new/state/Iron_Fists))
					src << output("I can't use this without my iron fists.","Action.Output")
					return
				if(src.PreJutsu(J))
					if(loc.loc:Safe!=1) src.LevelStat("Ninjutsu",((J.maxcooltime*3/20)*jutsustatexp))
					if(J.level==1) J.damage=((jutsudamage*J.Sprice)/1.75)/6
					if(J.level==2) J.damage=((jutsudamage*J.Sprice)/1.5)/6
					if(J.level==3) J.damage=((jutsudamage*J.Sprice)/1.25)/6
					if(J.level==4) J.damage=(jutsudamage*J.Sprice)/6
					if(J.level<4) if(loc.loc:Safe!=1) J.exp+=jutsumastery*(J.maxcooltime/20); J.Levelup()
					var/duration = J.level*2
					flick("trans", src.left_iron_fist)
					flick("trans", src.right_iron_fist)
					sleep(1.5)
					if(src)
						AddState(src, new/state/Iron_Fist_Spinning, duration)
						AddState(src, new/state/cant_attack, duration, src)
						AddState(src, new/state/cant_move, duration, src)


		Gathering_Assault_Pyramid()
			for(var/obj/Jutsus/Gathering_Assault_Pyramid/J in src.jutsus)
				if(src.PreJutsu(J))
					if(loc.loc:Safe!=1) src.LevelStat("Ninjutsu",((J.maxcooltime*3/20)*jutsustatexp))
					if(J.level==1) J.damage=((jutsudamage*J.Sprice)/1.75)/3
					if(J.level==2) J.damage=((jutsudamage*J.Sprice)/1.5)/3
					if(J.level==3) J.damage=((jutsudamage*J.Sprice)/1.25)/3
					if(J.level==4) J.damage=(jutsudamage*J.Sprice)/3
					if(J.level<4) if(loc.loc:Safe!=1) J.exp+=jutsumastery*(J.maxcooltime/20); J.Levelup()
					AddState(src, new/state/cant_attack, 20, src)
					AddState(src, new/state/cant_move, 20, src)
					var/obj/pyramid = new/obj(src.loc)
					pyramid.pixel_x -= 64
					pyramid.density = 0
					pyramid.layer = MOB_LAYER+2
					step(pyramid, src.dir)
					step(pyramid, src.dir)
					step(pyramid, src.dir)
					step(pyramid, src.dir)
					step(pyramid, NORTH)
					step(pyramid, NORTH)
					step(pyramid, NORTH)
					pyramid.icon = 'iron_pyramid.dmi'
					src.PlayAudio('wind_leaves.ogg', output = AUDIO_HEARERS)
					pyramid.icon_state = "form"
					sleep(12)
					pyramid.icon_state = "spin"
					var/i
					for(i=0, i<3, i++)
						sleep(1)
						step(pyramid, SOUTH)
					for(i=0, i<4, i++)
						sleep(1)
						for(var/mob/m in orange(1, pyramid))
							m.DealDamage((src.taijutsu_total / 200)*J.damage, src, "NinBlue")
							src.PlayAudio('knife_hit1.wav', output = AUDIO_HEARERS)
						for(var/mob/m in range(0, pyramid))
							m.DealDamage((src.taijutsu_total / 200)+(src.precision_total / 200)*J.damage, src, "NinBlue")
							src.PlayAudio('knife_hit1.wav', output = AUDIO_HEARERS)
					del(pyramid)
					
					
