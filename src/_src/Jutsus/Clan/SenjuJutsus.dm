mob
	proc
		JukaiKoutan()
			for(var/obj/Jutsus/JukaiKoutan/J in src.jutsus)
				if(src.PreJutsu(J))
					if(loc.loc:Safe!=1) src.LevelStat("Ninjutsu",0.2)
					flick("groundjutsu",src)
					src.firing=1
					src.canattack=0
					spawn(1)
						src.firing=0
						src.canattack=1
					if(J.level<4) if(loc.loc:Safe!=1) J.exp+=rand(4,6); J.Levelup()
					for(var/turf/T in view(src,5))
						if(T)
							var/obj/A = new/obj/Jukai
							A.IsJutsuEffect=src
							A.Owner=src
							A.layer=src.layer
							A.fightlayer=src.fightlayer
							A.damage=J.damage
							A.level=J.level
							A.loc=T
							flick("create",A)
							for(var/mob/M in T)
								if(M!=src)
									M.DealDamage(12+J.damage+ninjutsu/15,src,"NinBlue")
									spawn() if(M) M.Bleed()

		JubakuEisou()
			for(var/obj/Jutsus/JubakuEisou/J in src.jutsus)
				var/mob/c_target=src.Target_Get(TARGET_MOB)
				if(!c_target)
					src << output("This jutsu requires a target","ActionPanel.Output")
					return
				if(src.PreJutsu(J))

					if(loc.loc:Safe!=1) src.LevelStat("Ninjutsu",rand(1,2))
					flick("jutsuse",src)
					src.firing=1
					src.canattack=0
					var/TimeAsleep
					if(J.level==1) TimeAsleep=25
					if(J.level==2) TimeAsleep=50
					if(J.level==3) TimeAsleep=75
					if(J.level==4) TimeAsleep=100
					if(J.level<4) if(loc.loc:Safe!=1) J.exp+=rand(2,6); J.Levelup()
					var/mob/M = c_target
					if(M)
						var/turf/T=M.loc
						spawn(10)
							if(M&&T)
								if(T==M.loc)
									var/obj/A = new/obj/Jukai
									A.IsJutsuEffect=src
									A.Owner=src
									A.layer=src.layer
									A.fightlayer=src.fightlayer
									A.damage=J.damage
									A.level=J.level
									A.loc=M.loc
									flick("create",A)
									M.move=0
									M.injutsu=1
									M.canattack=0
									M.Sleeping=1
									spawn(TimeAsleep)
										if(!M||M.dead)continue
										M.move=1
										M.injutsu=0
										M.canattack=1
										M.Sleeping=0
								else src<<output("The jutsu did not connect.","ActionPanel.Output")
					src.firing=0
					src.canattack=1

		Daijurin()
			for(var/obj/Jutsus/Daijurin/J in src.jutsus)
				if(src.PreJutsu(J))
					if(loc.loc:Safe!=1) src.LevelStat("Ninjutsu",0.2)
					flick("jutsuse",src)
					icon_state="punchrS"
					var/obj/A = new/obj/daijurin(src.loc)
					A.IsJutsuEffect=src
					A.Owner=src
					A.layer=src.layer
					A.fightlayer=src.fightlayer
					A.damage=J.damage
					A.level=J.level
					A.dir=src.dir
					if(A.dir==WEST||A.dir==EAST)A.pixel_y=-52
					walk(A,src.dir)
					src.firing=1
					src.canattack=0
					spawn(1)
						src.firing=0
						src.canattack=1
					if(J.level<4) if(loc.loc:Safe!=1) J.exp+=rand(3,7); J.Levelup()
		Tree_Summoning()
			for(var/obj/Jutsus/Tree_Summoning/J in src.jutsus)
				if(src.PreJutsu(J))
					var/mob/c_target=src.Target_Get(TARGET_MOB)
					if(loc.loc:Safe!=1) src.LevelStat("Ninjutsu",rand(5,10))
					view(src) << output("<b><font color = brown>[usr] says: Tree Summoning!","ActionPanel.Output")
					flick("jutsuse",src)
					view(src)<<sound('wind_leaves.ogg',0,0)
					src.firing=1
					src.canattack=0
					if(J.level==1)J.damage=3
					if(J.level==2)J.damage=6
					if(J.level==3)J.damage=9
					if(J.level==4)J.damage=12
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
							src.dir=get_dir(src,c_target)
							var/obj/A = new(c_target.loc)
							A.IsJutsuEffect=src
							A.Owner=src
							A.density=1
							A.layer=MOB_LAYER+1
							var/I=J.damage*7
							A.icon='Treee Summoning.dmi'
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
								c_target.canattack=1
							if(src)
								Prisoner=null
								src.icon_state=""
					else src<<output("This technique requires a target.","ActionPanel.Output")
					if(src)
						src.firing=0
						src.canattack=1
						src.move=1
						src.injutsu=0
		WoodStyleFortress()
			if(firing)return
			if(src.firing==0 && src.canattack==1)
				for(var/obj/Jutsus/WoodStyleFortress/J in src.jutsus)
					if(src.PreJutsu(J))
						flick("groundjutsu",src)
						if(loc.loc:Safe!=1) src.LevelStat("Ninjutsu",rand(7,11))
						view(src)<<sound('Skill_MashHit.wav',0,0)
						src.move=0
						src.firing=1
						src.canattack=0
						if(J.level==1) J.damage=4
						if(J.level==2) J.damage=8
						if(J.level==3) J.damage=12
						if(J.level==4) J.damage=16
						if(J.level<4) if(loc.loc:Safe!=1) J.exp+=rand(5,15); J.Levelup()
						new/obj/WoodStyle/Fortres(locate(src.x-1,src.y-1,src.z))
						new/obj/WoodStyle/Fortres(locate(src.x,src.y-1,src.z))
						new/obj/WoodStyle/Fortres(locate(src.x+1,src.y-1,src.z))
						new/obj/WoodStyle/Fortres(locate(src.x-1,src.y+1,src.z))
						new/obj/WoodStyle/Fortres(locate(src.x,src.y+1,src.z))
						new/obj/WoodStyle/Fortres(locate(src.x+1,src.y+1,src.z))
						new/obj/WoodStyle/Fortres(locate(src.x+1,src.y,src.z))
						new/obj/WoodStyle/Fortres(locate(src.x-1,src.y,src.z))
						src.move=1
						src.firing=0
						src.copy=null
						src.canattack=1
						src.injutsu=0

		Root_Strangle()
			if(src.firing)return
			if(src.firing==0 && src.canattack==1)
				for(var/obj/Jutsus/Root_Strangle/J in src.jutsus)
					var/mob/c_target=src.Target_Get(TARGET_MOB)
					if(!c_target)
						src << output("This jutsu requires a target.","ActionPanel.Output")
						return
					if(src.PreJutsu(J))
						if(loc.loc:Safe!=1) src.LevelStat("Ninjutsu",rand(5,7))
						src.move=0
						src.injutsu=1
						src.firing=1
						src.canattack=0
						flick("groundjutsu",src)
						if(J.level<4) if(loc.loc:Safe!=1) J.exp+=rand(5,15); J.Levelup()
						var/obj/senjuu/Strangle1/s=new/obj/senjuu/Strangle1(c_target.loc)
						var/turf/lol=c_target.loc
						spawn(3)
						src.copy=null
						src.move=1
						src.firing=0
						src.copy=null
						src.canattack=1
						src.injutsu=0
						if(c_target.loc==lol)
							c_target.move=0
							c_target.injutsu=1
							c_target.firing=1
							c_target.canattack=0
							c_target.DealDamage(src.ninjutsu*J.level,src,"NinBlue")

							spawn(J.level*10)
								c_target.move=1
								c_target.injutsu=0
								c_target.firing=0
								c_target.canattack=1
								c_target.overlays=0
								del(s)
								c_target.RestoreOverlays()
						else
							c_target.overlays=0
							c_target.RestoreOverlays()
							spawn(2)
								del(s)

		Wood_Balvan()
			if(firing)return
			if(src.firing==0 && src.canattack==1)
				for(var/obj/Jutsus/Wood_Balvan/J in src.jutsus)
					if(src.PreJutsu(J))
						if(loc.loc:Safe!=1) src.LevelStat("Ninjutsu",rand(5,7))
						src.injutsu=1
						flick("jutsuse",src)
						if(J.level<4) if(loc.loc:Safe!=1) J.exp+=rand(5,15); J.Levelup()
						var/obj/O = new/obj/Projectiles/Effects/Balvan
						var/mob/c_target=src.Target_Get(TARGET_MOB)
						O.IsJutsuEffect=src
						O.loc = src.loc
						O.dir = src.dir
						O.Owner = src
						if(c_target)
							walk_towards(O,c_target)
							spawn(5)if(src)
								walk_towards(O,0)
								walk(O,O.dir)
						else walk(O,src.dir)
						spawn(1)
						src.injutsu=0

		Root_Stab()
			if(src.firing)return
			if(src.firing==0 && src.canattack==1)
				for(var/obj/Jutsus/Root_Stab/J in src.jutsus)
					if(src.PreJutsu(J))
						var/mob/c_target=src.Target_Get(TARGET_MOB)
						if(!c_target)
							src << output("You need a target to use this.","ActionPanel.Output")
							return
						if(loc.loc:Safe!=1) src.LevelStat("Ninjutsu",rand(5,7))
						src.move=0
						src.injutsu=1
						if(J.level<4) if(loc.loc:Safe!=1) J.exp+=rand(5,15); J.Levelup()
						src.firing=1
						src.canattack=0
						flick("groundjutsu",src)
						var/obj/senjuu/stab/s=new/obj/senjuu/stab(c_target.loc)
						spawn(1)
							if(c_target.loc==s.loc)
								c_target.move=0
								c_target.DealDamage(src.ninjutsu*J.level,src,"NinBlue")
								c_target.Bleed()
								view(c_target)<<sound('knife_hit1.wav',0,0,volume=50)
								spawn(3)
									c_target.move=1
							else
								spawn(3)
									del(s)
						src.copy=null
						src.move=1
						src.firing=0
						src.canattack=1
						src.injutsu=0
