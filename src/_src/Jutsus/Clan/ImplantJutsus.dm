mob
	proc
		Sharingan_Copy()
			for(var/obj/Jutsus/Sharingan_Copy/J in src.jutsus)
				/*if(Sharingan<=2)
					src<<output("You need to have a stronger Sharingan to activate this.","ActionPanel.Output")
					return*/
				if(src.PreJutsu(J))
					if(loc.loc:Safe!=1) src.LevelStat("Ninjutsu",rand(2,3))
					if(J.level<4) if(loc.loc:Safe!=1) J.exp+=rand(2,5); J.Levelup()
					if(src.jutsucopy==0)
						src.jutsucopy=1
						src << output("You will soon copy the next jutsu used by another Shinobi.","ActionPanel.Output")
					else
						if(src.jutsucopy==1)src.jutsucopy=0
				//		else
						if(isobj(src.jutsucopy))
							var/obj/O = src.jutsucopy
							src.jutsus+=O
							src.doslot(O.name)
							spawn(1)src.jutsus-=O

		Kamui()
			for(var/obj/Jutsus/Kamui/J in src.jutsus)
				/*if(Sharingan<=3)
					src<<output("You need to have Mangekyou Sharingan or higher activated to use this.","ActionPanel.Output")
					return*/
				var/mob/player/c_target=src.Target_Get(TARGET_MOB)
				if(!c_target||!istype(c_target))
					src<<output("You require a targeted player to use this technique.","ActionPanel.Output")
					return
				if(src.PreJutsu(J))
					if(loc.loc:Safe!=1) src.LevelStat("Ninjutsu",rand(12,15))
					if(J.level<4) if(loc.loc:Safe!=1) J.exp+=rand(5,20); J.Levelup()
					var/obj/O = new(c_target.loc)
					O.IsJutsuEffect=src
					O.icon='kamui.dmi'
					O.icon_state="kamui"
					O.layer=MOB_LAYER+1
					O.pixel_x=-35
					O.name="kamui"
					var/Timer=J.level*5
					spawn(5)if(O)
						if(O.loc==c_target.loc)
							O.linkfollow(c_target)
							while(Timer&&c_target&&!c_target.dead)
								Timer--
								var/area/A=c_target.loc.loc
								if(A.Safe) break
								c_target.DealDamage(src.ninjutsu*0.8, src, "NinBlue")
								sleep(2)
							if(O)del(O)
						else if(O)del(O)
		WarpDim()
			for(var/obj/Jutsus/WarpDim/J in src.jutsus)
				var/mob/c_target=src.Target_Get(TARGET_MOB)
				if(c_target.jailed == 1)
					src<<output("Your target is jailed.","ActionPanel.Output")
					return
				if(src.loc.z == 4)
					src<<output("You can't use this in the chuunin exam!","ActionPanel.Output")
					return
				if(src.dueling == 1)
					src<<output("You cant use this during a duel!","ActionPanel.Output")
					return
				if(src.jailed == 1)
					src<<output("You are jailed.","ActionPanel.Output")
					return
				if(src.PreJutsu(J))
					if(loc.loc:Safe!=1) src.LevelStat("Genjutsu",rand(3,8))
					if(J.level==1) J.damage=50
					if(J.level==2) J.damage=100
					if(J.level==3) J.damage=150
					if(J.level==4) J.damage=250
					if(src.loc.z != 3)//if not used inside dimension(or the arena building i guess lol
						view(10)<<"[usr]: Let's take this to my own little world."
						PrevLoc = src.loc
						var/obj/O = new(c_target.loc)
						O.IsJutsuEffect=src
						O.icon='kamui.dmi'
						O.icon_state="kamui"
						O.layer=MOB_LAYER+1
						O.pixel_x=-35
						O.name="kamui"
						O.loc = src.loc
						sleep(10)
						c_target.loc=locate(105,166,3)//97 166 3 is middle
						src.loc=locate(90,166,3)
						c_target.canattack=1
						c_target.injutsu=0
						c_target.move=1
						del O
					else//if in the dimension Z
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
						c_target.loc=PrevLoc
						src.loc=PrevLoc
						c_target.canattack=1
						c_target.injutsu=0
						c_target.move=1
						src.move=1
						src.canattack=1
						src.injutsu=0
						src.firing=0
						flick("jutsuse",src)
						src.icon_state = "jutsuse"
						del O


		Intangible_Jutsu()
			for(var/obj/Jutsus/Intangible_Jutsu/J in src.jutsus)
				if(Intang)
					src << output("You're no longer intangible.","ActionPanel.Output")
					src.Intang=0
					src.density=1
					spawn(5)
						src.firing=0
						src.injutsu=0
						src.canattack=1
					return
				else
					if(jailed==1)
						src<<output("You're not allowed to use intangibility to break out of jail!","ActionPanel.Output")
						return
					if(src.loc.z == 3)
						src<<output("You can't use this in the dimension or an arena battle!","ActionPanel.Output")
						return

					if(src.PreJutsu(J))
						if(loc.loc:Safe!=1) src.LevelStat("Genjutsu",rand(5,10))
						src << output("You become intangible.","ActionPanel.Output")
						src.Intang=1
						src.canattack=0
						src.injutsu=0
						src.firing=0
						src.density=0
						//spawn()
						while(src.Intang)
							src.DealDamage(20, src, "aliceblue", 0 , 1)
							src.canattack=0
							src.injutsu=0
							src.firing=0
							src.density=0
							sleep(10)
							if(src.chakra<=0)
								src.chakra=0
								src << output("You're no longer intangible.","ActionPanel.Output")
								src.Intang=0
								src.density=1
								spawn(5)
									src.firing=0
									src.injutsu=0
									src.canattack=1

