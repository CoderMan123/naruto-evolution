mob
	proc
		Tsukuyomi()
			for(var/obj/Jutsus/Tsukuyomi/J in src.jutsus)
				if(Sharingan<=3) // things like this come first
					src<<output("You must have Mangekyou Sharingan or higher activated in order to use this.","Action.Output")
					return
				var/mob/player/c_target=usr.Target_Get(TARGET_MOB)
				if(!c_target||!istype(c_target))
					src<<output("You must have a target to use this technique.","Action.Output")
					return
				if(src.PreJutsu(J)) // call this at the beginning of the jutsu.
					if(loc.loc:Safe != 1)
						src.LevelStat("Genjutsu",rand(20,30))
					flick("jutsuse",src)
					//view(src)<<sound('wind_leaves.ogg',0,0)
					src.firing=1
					src.canattack=0
					if(J.level<4)
						if(loc.loc:Safe!=1)
							J.exp += rand(20,25)
							J.Levelup()
					move = 0
					canattack = 0
					injutsu = 1
					c_target.move=0
					c_target.canattack=0
					c_target.injutsu=1
					src.Prisoner=c_target
					new/obj/TsukuyomiHUD(c_target.client)
					c_target.client.eye=locate(143,38,14)
					c_target.client:perspective = EYE_PERSPECTIVE
					var/Timer=J.level+2
					while(Timer&&c_target)// I tend to use white as gen damage. Heal only needs to be set to 1 on healing jutsus
						if(J.level==1) // DealDamage() has 4 parameters DealDamage(amount, owner, color, heal)
							c_target.DealDamage(src.genjutsu*0.6, src, "white")
						if(J.level==2)
							c_target.DealDamage(src.genjutsu*1.0, src, "white")
						if(J.level==3)
							c_target.DealDamage(src.genjutsu*1.4, src, "white")
						if(J.level==4)
							c_target.DealDamage(src.genjutsu*2.0, src, "white")
						Timer--
						sleep(5)
					if(c_target)
						c_target.client.eye=c_target
						c_target.client:perspective = EYE_PERSPECTIVE
						c_target.move=1
						c_target.canattack=1
						c_target.injutsu=0
						for(var/obj/TsukuyomiHUD/H in c_target.client.screen)del H
					src.Prisoner=null
					src.firing=0
					src.injutsu=0
					move=1
					canattack=1
					injutsu=0
		Amaterasu()
			for(var/obj/Jutsus/Amaterasu/J in src.jutsus)
				if(Sharingan<=3)
					src<<output("You need to have Mangekyou Sharingan or higher activated to use this.","Action.Output")
					return
				var/mob/player/c_target=src.Target_Get(TARGET_MOB)
				if(!c_target||!istype(c_target))
					src<<output("You require a targeted player to use this technique.","Action.Output")
					return
				if(src.PreJutsu(J))
					if(loc.loc:Safe!=1) src.LevelStat("Ninjutsu",rand(12,15))
					if(J.level<4) if(loc.loc:Safe!=1) J.exp+=rand(5,20); J.Levelup()
					var/obj/O = new(c_target.loc)
					O.IsJutsuEffect=src
					O.icon='Amat.dmi'
					O.pixel_x=-15
					O.layer=MOB_LAYER+1
					O.name="AmaterasuFire"
					var/Timer=J.level*5
					spawn(5)if(O)
						if(O.loc==c_target.loc)
							O.linkfollow(c_target)
							while(Timer&&c_target&&!c_target.dead)
								Timer--
								var/area/A=c_target.loc.loc
								if(A.Safe) break
								c_target.DealDamage(J.level+round(src.ninjutsu*0.5),src,"NinBlue")
								sleep(5)
							if(O)del(O)
						else if(O)del(O)

		Susanoo()
			for(var/obj/Jutsus/Susanoo/J in src.jutsus)
				/*if(src.Susanoo)
					src<<output("You deactivate your Susanoo","Action.Output")
					src.Susanoo = 0
					del(Susanoo)
					return */
				if(src.Sharingan<=3)
					src<<output("You need to have Mangekyou Sharingan or higher activated to use this.","Action.Output")
					return
		//		if(!src.Susanoo)
				if(src.PreJutsu(J))
					if(loc.loc:Safe!=1) src.LevelStat("Ninjutsu",rand(12,16))
					if(J.level<4) if(loc.loc:Safe!=1) J.exp+=rand(15,30); J.Levelup()
					var/mob/M = new/mob/Untargettable/Susanoo(src)
					M.Follow(src)
					M.name = src.key
					M.level = J.level
					src.Susanoo=1
					spawn(200) src.Susanoo=0 //removes at 200 when susanoo is removed.
				/*	while(Susanoo)
						sleep(50)
						src.DealDamage(100,src,"aliceblue",0,1)
						if(src.chakra<=0)
							src.chakra=0
							src<<output("Your Susanoo has deactivated","Action.Output")
							src.Susanoo = 0
							del(M)
							return */



		Sharingan()
			for(var/obj/Jutsus/Sharingan/J in src.jutsus)
				if(src.Sharingan)
					src.Sharingan=0
					if(src.jutsucopy)src.jutsucopy=0
					src << output("<font color=[colour2html("red")]><b>You deactivate your Sharingan.","Action.Output")
					return
				if(!src.Sharingan)
					if(src.PreJutsu(J))
						var/Text
						if(J.level==1)
							Text="a one tomoe"
							J.name="Sharingan One Tomoe"
							J.icon_state="Sharingan 1 tomoe"
						if(J.level==2)
							Text="a two tomoe"
							J.name="Sharingan Two Tomoe"
							J.icon_state="Sharingan 2 tomoe"
						if(J.level==3)
							Text="a three tomoe"
							J.name="Sharingan Three Tomoe"
							J.icon_state="Sharingan 3 tomoe"
						if(J.level==4)
							Text="the legendary Mangekyou"
							J.name="Mangekyou Sharingan"
							J.icon_state="Mangekyou Sharingan"
							src.DealDamage(round((src.health*0.01)*15),src,"white")
						if(J.level==5)
							Text="the almighty Eternal Mangekyou"
							J.name="Eternal Mangekyou Sharingan"
							J.icon_state="Eternal Mangekyou"
						//if(loc.loc:Safe!=1) src.LevelStat("Ninjutsu",rand(7,12))
						view(src)<<output("<font color=[colour2html("red")]><b>[src] says: Sharingan!","Action.Output")
						view(src)<<output("<font color=[colour2html("red")]><b>[src]'s eyes swirl to form [Text] Sharingan.","Action.Output")
						src.firing=1
						src.canattack=0
						src.Sharingan=J.level
						src.copy = "Cant move"
						spawn(2)if(src)
							src.firing=0
							src.copy=null
							src.canattack=1
						while(src.Sharingan)//?
							sleep(12)
							src.DealDamage(10, src, "aliceblue", 0, 1)
							if(src.chakra<=0)
								src.chakra=0
								src.Sharingan=0
								src << output("<font color=[colour2html("red")]><b>Your sharingan has been deactivated.","Action.Output")
								//if(src.jutsucopy)src.jutsucopy=0
