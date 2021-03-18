mob
	proc
		Chakra_Release()
			for(var/obj/Jutsus/ChakraRelease/J in src.JutsusLearnt)
				if(src.PreJutsu(J))
					if(src.firing==0&&src.canattack==1)
						view(src)<<sound('046.wav',0,0)
						flick("jutsu",src)
						src.move=0
						var/obj/A = new/obj/MiscEffects/Chakra(usr.loc)
						A.loc=src.loc
						//src.overlays+=/obj/MiscEffects/Chakra/
						src.firing=1
						for(var/obj/Projectiles/P in orange())
							step_rand(P)
							walk(P,P.dir)
						for(var/obj/Hits/Shurikens/N in src.SCaught)
							src.overlays-=N
							var/obj/Projectiles/Weaponry/Shuriken/S = new/obj/Projectiles/Weaponry/Shuriken(src.loc)
							S.Owner=src
							S.damage+=round(src.ninjutsu/3)
							step_rand(S)
							walk(S,S.dir)
							src.SCaught-=N
						for(var/obj/Hits/Kunai/N in src.SCaught)
							src.overlays-=N
							var/obj/Projectiles/Weaponry/Kunai/S = new/obj/Projectiles/Weaponry/Kunai(src.loc)
							S.Owner=src
							S.damage+=round(src.ninjutsu/3)
							step_rand(S)
							walk(S,S.dir)
							src.SCaught-=N
						for(var/obj/Hits/Needle/N in src.SCaught)
							src.overlays-=N
							var/obj/Projectiles/Weaponry/Needle/S = new/obj/Projectiles/Weaponry/Needle(src.loc)
							S.Owner=src
							S.damage+=round(src.ninjutsu/3)
							step_rand(S)
							walk(S,S.dir)
							src.SCaught-=N
						for(var/obj/Hits/BoneTips/N in src.SCaught)
							src.overlays-=N
							var/obj/Projectiles/Weaponry/BoneTip/S = new/obj/Projectiles/Weaponry/BoneTip(src.loc)
							S.Owner=src
							S.damage+=round(src.ninjutsu/3)
							step_rand(S)
							walk(S,S.dir)
							src.SCaught-=N
						for(var/obj/Projectiles/Weaponry/ExplosiveTag/N in view(src,1))
							if(N.icon_state<>"blank")
								var/obj/Inventory/Weaponry/Explosive_Tag/S = new/obj/Inventory/Weaponry/Explosive_Tag(src.loc)
								S.loc=src.loc
								del(N)
						src.amounthits=0
						spawn(6)if(src)
							src.move=1
							src.firing=0

		Crow_Clone()
			CloneHandler()
			if(clonesturned==1)
				return
			if(src.firing==0&&src.canattack==1&&!Prisoned&&move)
				for(var/obj/Jutsus/Crow_Clone/J in src.JutsusLearnt)
					if(src.PreJutsu(J))
						src.CloneHandler()
						if(src.loc.loc:Safe!=1) src.LevelStat("Genjutsu",rand(13,20))
						flick("jutsu",src)
						for(var/mob/M in oview(src,13))M.Target_Remove()
						view(src)<<sound('wirlwind.wav',0,0)
						var/obj/O = new/obj
						O.loc = src.loc
						var/BUNLIST = list()
						for(var/i=0,i<J.level*3,i++)
							var/mob/Clones/Bunshin2/A = new/mob/Clones/Bunshin2(src.loc)
							A.loc=src.loc
							A.Owner=src
							A.icon=src.icon
							A.overlays=src.overlays
							A.invisibility=1
							if(i<5)BUNLIST+=A
							step_rand(A)
							step_rand(A)
							step_rand(A)
							step_rand(A)
							step_rand(A)
							spawn(100)if(A)del(A)
						src.invisibility=1
						step_rand(src)
						step_rand(src)
						step_rand(src)
						step_rand(src)
						step_rand(src)
						for(var/mob/Z in BUNLIST)
							var/obj/C = new/obj/CROW
							C.loc = O.loc
							C.pixel_x=-16
							C.icon = 'Crows.dmi'
							C.overlays+=image('Crows.dmi',pixel_x=-16+rand(-8,8),pixel_y=rand(-8,8))
							C.overlays+=image('Crows.dmi',pixel_x=-16+rand(-8,8),pixel_y=rand(-8,8))
							C.overlays+=image('Crows.dmi',pixel_x=-16+rand(-8,8),pixel_y=rand(-8,8))
							walk_to(C,Z)
							spawn(5)
								if(Z)Z.invisibility=0
								if(C)del(C)
						var/obj/C2 = new/obj/CROW
						C2.loc = O.loc
						C2.pixel_x=-16
						C2.icon = 'Crows.dmi'
						C2.overlays+=image('Crows.dmi',pixel_x=-16+rand(-8,8),pixel_y=rand(-8,8))
						C2.overlays+=image('Crows.dmi',pixel_x=-16+rand(-8,8),pixel_y=rand(-8,8))
						C2.overlays+=image('Crows.dmi',pixel_x=-16+rand(-8,8),pixel_y=rand(-8,8))
						walk_to(C2,src)
						spawn(5)if(src)
							src.invisibility=0
							src.injutsu=0
						spawn(5)if(C2)del(C2)
						if(J.level<4&&src.loc.loc:Safe!=1)
							J.exp+=rand(5,15)
							J.Levelup()
		Clone_Jutsu()
			if(clonesturned==1)
				return
			/*if(multishadow==1)
				return*/
			for(var/obj/Jutsus/BClone/J in src.JutsusLearnt)
				if(src.PreJutsu(J))
					src.CloneHandler()
					if(src.bunshin<maxbunshin)
						src.bunshin++
						if(src.loc.loc:Safe!=1) src.LevelStat("Genjutsu",rand(7,10))
						flick("jutsu",src)
						for(var/mob/M in oview(src,13))M.Target_Remove()
						view(src)<<sound('flashbang_explode1.wav',0,0)
						var/timer = J.level
						while(timer)
							sleep(1)
							timer--
							var/mob/Clones/Bunshin/A = new/mob/Clones/Bunshin(src.loc)
							A.loc=src.loc
							A.Owner=src
							A.icon=src.icon
							A.overlays=src.overlays
						if(J.level<4&&src.loc.loc:Safe!=1)
							J.exp+=rand(5,15)
							J.Levelup()
						//src.multishadow=1
						/*spawn(80)
							src.multishadow=0*/
		MultipleShadowClone_Jutsu()
			if(clonesturned==1)
				return
			if(src.firing==0&&src.canattack==1)
				for(var/obj/Jutsus/MSClone/J in src.JutsusLearnt)
					if(src.PreJutsu(J))
						src.CloneHandler()
						view(src)<<sound('flashbang_explode1.wav',0,0)
						if(src.loc.loc:Safe!=1) src.LevelStat("Genjutsu",rand(10,15))
						for(var/mob/M in oview(src,13))
							M.Target_Remove()
						while(src.sbunshin<>5)
							sleep(1)
							src.sbunshin++
							var/bun=src.sbunshin+1
							src.chakra-=round(src.chakra/bun)
							flick("jutsu",src)
							var/mob/Clones/Shadow/A = new/mob/Clones/Shadow(src.loc)
							A.loc=src.loc
							A.Owner=src
							A.icon=src.icon
							A.overlays=src.overlays
							A.strength=round(src.strength/bun)
							A.defence=round(src.defence/bun)
							A.health=round(src.health/bun)
							A.maxhealth=round(src.health/bun)
							A.agility=round(src.agility/bun)
							var/obj/O=new /obj/Screen/healthbar/
							var/obj/M=new /obj/Screen/manabar/
							A.hbar.Add(O)
							A.hbar.Add(M)
							A.overlays-=/obj/Screen/healthbar
							A.overlays-=/obj/Screen/manabar
							for(var/obj/Screen/healthbar/HB in A.hbar)A.overlays+=HB
							for(var/obj/Screen/manabar/HB in A.hbar)A.overlays+=HB

		ShadowClone_Jutsu()
			if(clonesturned==1)
				return
			if(src.firing==0&&src.canattack==1)
				for(var/obj/Jutsus/SClone/J in src.JutsusLearnt)
					if(src.PreJutsu(J))
						src.CloneHandler()
						if(!src.sbunshin)
							src.sbunshin++
							var/bun=src.sbunshin+1
							src.chakra-=round(src.chakra*0.35/bun)
							if(src.loc.loc:Safe!=1) src.LevelStat("Genjutsu",rand(10,13))
							src.Levelup()
							src.chakra-=rand(12,25)
							src.UpdateHMB()
							flick("jutsu",src)
							view(src)<<sound('flashbang_explode1.wav',0,0)
							var/mob/Clones/Shadow/A = new/mob/Clones/Shadow(src.loc)
							A.loc=src.loc
							A.Owner=src
							A.icon=src.icon
							A.overlays=src.overlays
							A.strength=round(src.strength/bun)
							A.defence=round(src.defence/bun)
							A.health=round(src.health/bun)
							A.maxhealth=round(src.health/bun)
							A.agility=round(src.agility/bun)
							var/obj/O=new /obj/Screen/healthbar/
							var/obj/M=new /obj/Screen/manabar/
							A.hbar.Add(O)
							A.hbar.Add(M)
							A.overlays-=/obj/Screen/healthbar
							A.overlays-=/obj/Screen/manabar
							for(var/obj/Screen/healthbar/HB in A.hbar)A.overlays+=HB
							for(var/obj/Screen/manabar/HB in A.hbar)A.overlays+=HB
							if(J.level<4&&src.loc.loc:Safe!=1)
								J.exp+=rand(5,15)
								J.Levelup()

		Clone_Jutsu_Destroy()
			for(var/obj/Jutsus/BCloneD/J in src.JutsusLearnt)
				if(src.PreJutsu(J))
					if(src.Clones.len)
						flick("jutsu",src)
						for(var/mob/Clones/C in src.Clones)
							C.health=0
							C.Death(src)
						src.bunshin=0
						src.sbunshin=0
						if(usr.likeaclone)
							usr.likeaclone=null
							usr.client:perspective = EDGE_PERSPECTIVE
							usr.client:eye=usr
							target_mob=null
							takeova=0

		Transformation_Jutsu()
			if(src.firing==0)
				if(src.canattack==1)
					for(var/obj/Jutsus/Transformation/J in src.JutsusLearnt)
						if(src.PreJutsu(J))
							if(src.henge==0)
								if(src.loc.loc:Safe!=1) src.LevelStat("Genjutsu",rand(8,14))
								if(J.level==1)src.henge=1
								if(J.level==2)src.henge=2	//invis bug was taken care of
								if(J.level==3)src.henge=3
								if(J.level<3&&src.loc.loc:Safe!=1)
									J.exp+=rand(5,15)
									J.Levelup()
								spawn()
									src<<output("<Font color=white>Now click the object you wish to transform into.</Font>","ActionPanel.Output")
		TreeBinding()
			for(var/obj/Jutsus/TreeBinding/J in src.JutsusLearnt)
				if(src.PreJutsu(J))
					var/mob/c_target=usr.Target_Get(TARGET_MOB)
					if(loc.loc:Safe!=1) src.LevelStat("Genjutsu",rand(15,30))
					//view()<<"<font size=1><font face=Times New Roman><b><font color=white>[src] Says:<font color=yellow> Fire Release:Fire Ball"
					flick("jutsuse",src)
					view(src)<<sound('wind_leaves.ogg',0,0)
					if(J.level<4) if(loc.loc:Safe!=1) J.exp+=rand(2,5); J.Levelup()
					var/Time=J.level
					var/TreeNearby
					for(var/turf/Ground/Trees/T in oview(2,c_target))
						TreeNearby=1
					if(TreeNearby)
						c_target.overlays+='TreeBinding.dmi'
						c_target.move=0
						c_target.injutsu=1
						c_target.canattack=0
						while(Time&&c_target)
							sleep(10)
							Time--
							c_target.DealDamage(src.genjutsu*5,src,"white")
						if(c_target)
							c_target.overlays-='TreeBinding.dmi'
							if(!c_target.dead)
								c_target.move=1
								c_target.injutsu=0
								c_target.canattack=1
					else src<<"Your target is not by a tree, and the technique fails!"

		Bringer_of_Darkness_Technique()
			for(var/obj/Jutsus/Bringer_of_Darkness_Technique/J in src.JutsusLearnt)
				var/mob/c_target=src.Target_Get(TARGET_MOB)
				if(!c_target)
					src << output("This jutsu requires a target","ActionPanel.Output")
					return
				if(src.PreJutsu(J))
					if(loc.loc:Safe!=1) src.LevelStat("Genjutsu",rand(15,22))
					flick("jutsuse",src)
					view(src)<<sound('wind_leaves.ogg',0,0)
					src.firing=1
					src.canattack=0
					var/TimeAsleep
					if(J.level==1)TimeAsleep=5
					if(J.level==2)TimeAsleep=10
					if(J.level==3)TimeAsleep=15
					if(J.level==4)TimeAsleep=20
					if(J.level<4)if(loc.loc:Safe!=1)J.exp+=rand(2,5); J.Levelup()
					TimeAsleep+=(src.genjutsu*0.5)+(src.Sharingan*10)
					if(c_target.client)
						if(c_target.Rinnegan==1) goto skip
						c_target.sight |= BLIND
						spawn(TimeAsleep)if(c_target)c_target.sight &= ~BLIND
					skip
					src.firing=0
					src.canattack=1

		Temple_Of_Nirvana()//Should scale with Genjutsu!
			for(var/obj/Jutsus/Temple_Of_Nirvana/J in src.JutsusLearnt)
				if(src.PreJutsu(J))
					if(loc.loc:Safe!=1) src.LevelStat("Genjutsu",rand(9,13))
					flick("jutsuse",src)
					view(src)<<sound('wind_leaves.ogg',0,0)
					src.firing=1
					src.canattack=0
					spawn(2)
						src.firing=0
						src.canattack=1
					var/TimeAsleep
					if(J.level==1) TimeAsleep=30+(src.genjutsu*0.1)
					if(J.level==2) TimeAsleep=40+(src.genjutsu*0.1)
					if(J.level==3) TimeAsleep=50+(src.genjutsu*0.1)
					if(J.level==4) TimeAsleep=60+(src.genjutsu*0.1)
					if(J.level<4) if(loc.loc:Safe!=1) J.exp+=rand(2,5); J.Levelup()
					new/obj/Jutsus/Effects/TempleNirvana(src.loc)
					for(var/mob/player/M in oview(J.level))
						if(Squad)
							if(Squad.Members.Find(M.ckey)||getOwner(Squad.Leader)==M.ckey) continue
						new/obj/Jutsus/Effects/TempleNirvana(M.loc)
						if(M.Sharingan>=2) continue
						if(M.Rinnegan==1) continue
						if(M.Gates>=4) continue
						M.Sleeping=1
						M.icon_state="dead"
						M.move=0
						M.injutsu=1
						M.firing=1
						M.canattack=0
						spawn(TimeAsleep)
							if(!M||M.dead) continue
							M.icon_state=""
							M.move=1
							M.injutsu=0
							M.canattack=1
							M.Sleeping=0
							M.firing=0
					src.firing=0
					src.canattack=1
		Getsuga_Tenshou()
			for(var/obj/Jutsus/Getsuga_Tenshou/J in src.JutsusLearnt)
				if(src.PreJutsu(J))
					if(loc.loc:Safe!=1) src.LevelStat("Ninjutsu",0.2)
					flick("jutsuse",src)
					src.firing=1
					src.canattack=0
					if(J.level==1) J.damage=10
					if(J.level==2) J.damage=20
					if(J.level==3) J.damage=30
					if(J.level==4) J.damage=40
					if(J.level<4) if(loc.loc:Safe!=1) J.exp+=rand(1,2); J.Levelup()
					var/obj/Getsuga/A = new/obj/Getsuga(src.loc)
					view()<<sound('GetsugaTenshou.wav')
					A.IsJutsuEffect=src
					A.Owner=src
					A.layer=src.layer
					A.fightlayer=src.fightlayer
					A.damage=J.damage
					A.level=J.level
					walk(A,src.dir,0)
					spawn(1)
						src.firing=0
						src.canattack=1
		Flying_Thunder_God()
			for(var/obj/Jutsus/Flying_Thunder_God/J in src.JutsusLearnt)
				if(src.PreJutsu(J))
					if(!move) return
					if(injutsu) return
					if(copy=="Climb") return
					var/mob/c_target=src.Target_Get(TARGET_MOB)
					flick("jutsuse",src)
					view(src)<<sound('dash.wav',0,0)
					src.firing=1
					src.canattack=0
					src.move=0
					if(J.level==1) J.damage=2
					if(J.level==2) J.damage=4
					if(J.level==3) J.damage=6
					if(J.level==4) J.damage=8
					if(J.level<4) if(loc.loc:Safe!=1) J.exp+=rand(1,2); J.Levelup()
					if(c_target)
						//if(c_target.opponent) return
						flick('Flyingthunder.dmi',src)
						spawn(1)
							src.loc = c_target.loc
							step(src,c_target.dir)
							src.dir = get_dir(src,c_target)
					else
						flick('Flyingthunder.dmi',src)
						spawn(1)for(var/i=0,i<J.damage*3+1,i++)step(src,src.dir)
					src.move=0
					spawn(3)
						src.firing=0
						src.move=1
						src.canattack=1

		Warp_Rasengan()
			for(var/obj/Jutsus/Warp_Rasengan/J in src.JutsusLearnt) if(J.Excluded==0)
				if(src.PreJutsu(J))
					if(loc.loc:Safe!=1) src.LevelStat("Ninjutsu",rand(5,2))
					if(J.level<4) if(loc.loc:Safe!=1) J.exp+=rand(2,5); J.Levelup()
					var/mob/c_target=src.Target_Get(TARGET_MOB)
					src.move=0
					src.injutsu=1
					src.firing=1
					src.canattack=0
					src.icon_state = "jutsuse"
					sleep(5)
					if(c_target)
						c_target.dir = get_dir(c_target,src)
						flick('Flyingthunder.dmi',src)
						loc = c_target.loc
						step(src,c_target.dir)
						dir = get_dir(src,c_target)
						sleep(2)
					flick("2fist",src)
					for(var/mob/M in get_step(src,src.dir))
						for(var/i=0,i<4,i++)
							var/obj/O = new/obj
							O.loc = M.loc
							O.icon = 'Rasenshuriken Explode.dmi'
							flick("wtf",O)
							spawn(7)if(O)del(O)
							if(M) step(M,src.dir)
							if(M) M.dir = get_dir(M,src)
							if(M) M.DealDamage(75+src.agility,src,"NinBlue")
							sleep(1)
					src.icon_state = ""
					src.move=1
					src.injutsu=0
					src.firing=0
					src.canattack=1

		Sage_Bind()//HERE This just isn't fucking working.
			return//temp
		//	for(var/obj/Jutsus/Snake_Release_Jutsu/J in src.JutsusLearnt)

				/*if(src.PreJutsu(J))
					var/mob/c_target=src.Target_Get(TARGET_MOB)
					if(loc.loc:Safe!=1) src.LevelStat("Ninjutsu",rand(1,2))
					if(J.level<4) if(loc.loc:Safe!=1) J.exp+=rand(2,5); J.Levelup()
					view()<<sound('man_fs_r_mt_wat.ogg')
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
					view(src)<<sound('wind_leaves.ogg',0,0)
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



		Snake_Release_Jutsu()
			for(var/obj/Jutsus/Snake_Release_Jutsu/J in src.JutsusLearnt)
				if(src.PreJutsu(J))
					var/mob/c_target=src.Target_Get(TARGET_MOB)
					if(loc.loc:Safe!=1) src.LevelStat("Ninjutsu",rand(1,2))
					if(J.level<4) if(loc.loc:Safe!=1) J.exp+=rand(2,5); J.Levelup()
					view()<<sound('man_fs_r_mt_wat.ogg')
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
			for(var/obj/Jutsus/Snake_Skin_Replacement_Jutsu/J in src.JutsusLearnt)
				if(src.PreJutsu(J))
					if(loc.loc:Safe!=1) src.LevelStat("Ninjutsu",rand(4,8))
					var/turf/T=src.loc
					src<<output("You will be sent to this location the next time your character accumulates damage.","ActionPanel.Output")
					var/X = src.health
					while(src.health == X)sleep(1)
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
					for(var/mob/M in oview(src,13))M.Target_Remove()
					src.loc = T

		Sage_Style_Giant_Rasengan()
			for(var/obj/Jutsus/Sage_Style_Giant_Rasengan/J in src.JutsusLearnt)
				if(src.PreJutsu(J))
					if(Effects["Rasengan"])
						Effects["Rasengan"]=null
						src.overlays-=image('Rasengan.dmi',"spin")
						return
					if(loc.loc:Safe!=1) src.LevelStat("Ninjutsu",rand(4,8))
					if(J.level<4)
						if(loc.loc:Safe!=1) J.exp+=rand(2,5)
						J.Levelup()
					var/mob/c_target=src.Target_Get(TARGET_MOB)
					src.move=0
					src.injutsu=1
					src.canattack=0
					src.firing=1
					src.icon_state="jutsuse"
					view(src) << output("<b><font color = gold>[usr]says: Sage Style...GIANT RASENGAN!","ActionPanel.Output")
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
											M.DealDamage((250*J.level)+(src.strength*3)+(src.ninjutsu*3),src,"NinBlue")
							sleep(0.5)
						if(I)del(I)
					move=1
					Effects["Rasengan"]=null

		Mystical_Palms()
			for(var/obj/Jutsus/Mystical_Palms/J in src.JutsusLearnt)
				if(src.PreJutsu(J))
					if(mystical_palms)
						src<<output("You deactivate your mystical palms.","ActionPanel.Output")
						src.mystical_palms=0
						return
					if(loc.loc:Safe!=1) src.LevelStat("Ninjutsu",rand(3,5))
					src.mystical_palms=1
					src<<output("You activate mystical palms.","ActionPanel.Output")
					while(mystical_palms&&chakra>0)
						DealDamage(5,src,"aliceblue",0,1)
						sleep(10)
					src<<output("You deactivate your mystical palms.","ActionPanel.Output")
					src.mystical_palms=0




		One_Thousand_Years_of_Death()
			for(var/obj/Jutsus/One_Thousand_Years_of_Death/J in src.JutsusLearnt)
				if(src.PreJutsu(J))
					if(loc.loc:Safe!=1) src.LevelStat("Ninjutsu",rand(3,5))
					if(J.level<4) if(loc.loc:Safe!=1) J.exp+=rand(2,5); J.Levelup()
					var/mob/c_target=src.Target_Get(TARGET_MOB)
					src.move=0
					src.injutsu=1
					src.firing=1
					src.canattack=0
					src.icon_state = "jutsuse"
					sleep(5)
					if(c_target)
						c_target.dir = get_dir(c_target,src)
						flick('Shunshin.dmi',src)
						loc = c_target.loc
						step(src,c_target.dir)
						dir = get_dir(src,c_target)
						sleep(2)
					flick("2fist",src)
					for(var/mob/M in get_step(src,src.dir))
						for(var/i=0,i<4,i++)
							var/obj/O = new/obj
							O.loc = M.loc
							O.icon = 'Smoke.dmi'
							flick("smoke",O)
							spawn(7)if(O)del(O)
							if(M) step(M,src.dir)
							if(M) M.dir = get_dir(M,src)
							if(M) M.DealDamage(1+round(src.agility/15),src,"TaiOrange")
							sleep(1)
					src.icon_state = ""
					src.move=1
					src.injutsu=0
					src.firing=0
					src.canattack=1
		Chakra_Control()
			for(var/obj/Jutsus/Chakra_Control/J in src.JutsusLearnt)
				if(src.PreJutsu(J))
					if(loc.loc:Safe!=1) src.LevelStat("Ninjutsu",rand(1,2))
					if(src.waterwalk)
						waterwalk=0
						src<<output("You stop converting chakra to your feet.","ActionPanel.Output")
						return
					waterwalk=1
					src<<output("You start converting chakra to your feet.","ActionPanel.Output")

		Cherry_Blossom_Impact()
			for(var/obj/Jutsus/Cherry_Blossom_Impact/J in src.JutsusLearnt)
				if(src.PreJutsu(J))
					if(loc.loc:Safe!=1) src.LevelStat("Ninjutsu",rand(1,2))
					if(J.level<4) if(loc.loc:Safe!=1) J.exp+=rand(1,2); J.Levelup()
					if(src.COW<J.level*3)src.COW++
					src<<output("You precisely charge chakra to your hands, and now have stocked [src.COW] punches.","ActionPanel.Output")

		Body_Replacement_Technique()
			for(var/obj/Jutsus/BodyReplace/J in src.JutsusLearnt)
				if(src.PreJutsu(J))
					if(loc.loc:Safe!=1) src.LevelStat("Ninjutsu",rand(2,5))
					view(src)<<sound('flashbang_explode1.wav',0,0)
					var/obj/A = new/obj/MiscEffects/Smoke(src.loc)
					A.IsJutsuEffect=src
					A.loc=src.loc
					var/obj/B = new/obj/Training/BDLogB(src.loc)
					B.IsJutsuEffect=src
					B.loc=src.loc
					for(var/mob/M in oview(src,13))M.Target_Remove()
					if(J.level<4)
						if(loc.loc:Safe!=1) J.exp=J.maxexp
						J.Levelup()
					if(J.level==1)
						src.Step_Back()
					if(J.level==2)
						src.injutsu=1
						src.Step_Back()
						src.Step_Back()
						src.injutsu=0
					if(J.level==3)
						src.overlays=0
						src.Name(src.name)
						src.RestoreOverlays()
						src.injutsu=1
						src.Step_Back()
						src.Step_Back()
						src.Step_Back()
						src.injutsu=0
						spawn()
							src.Name(src.name)
							src.icon_state=""
							src.RestoreOverlays()
					if(J.level>=4 || J.level==4)
						B.icon=src.icon
						B.icon_state=src.icon_state
						B.overlays=0
						B.overlays=src.overlays
						B.dir=src.dir
						src.overlays=0
						src.Name(src.name)
						src.RestoreOverlays()
						src.injutsu=1
						src.Step_Back()
						src.Step_Back()
						src.Step_Back()
						src.Step_Back()
						src.injutsu=0
						spawn()
							src.Name(src.name)
							src.icon_state=""
							src.RestoreOverlays()


		Advanced_Body_Replacement_Technique()
			for(var/obj/Jutsus/AdvancedBodyReplace/J in src.JutsusLearnt)
				if(src.PreJutsu(J))
					if(loc.loc:Safe!=1) src.LevelStat("Ninjutsu",rand(4,8))
					src.kawarmi=1
					src.mark=src.loc
					src<<output("Now to activate use the defend verb.","ActionPanel.Output")


		Ones_Own_Life_Reincarnation()
			for(var/obj/Jutsus/Ones_Own_Life_Reincarnation/J in src.JutsusLearnt)
				if(src.PreJutsu(J))
					if(loc.loc:Safe!=1) src.LevelStat("Ninjutsu",rand(4,8))
					src.move=0
					src.canattack=0
					src.injutsu=1
					src.firing=1
					flick("groundjutsu",src)
					src.icon_state = "groundjutsuse"
					for(var/mob/M in src.loc)
						if(M.icon_state == "dead" && M.client && M.dead)
							M.revived=1
							M.dead=0
							M.KOs=0
							M.density=1
							M.health=M.maxhealth
							M.chakra=M.maxchakra
							M.injutsu=0
							M.canattack=1
							M.firing=0
							M.icon_state=""
							M.wait=0
							M.rest=0
							M.dodge=0
							M.move=1
							M.swimming=0
							M.walkingonwater=0
							M.overlays=0
							M.RestoreOverlays()
							M.UpdateHMB()
							spawn(1)M.Run()
							src.DealDamage(src.health + 1,src,"cyan")
							//src.health=0-1
							//src.Death(M)
							spawn(600)if(M)if(M.revived)M.revived=0
					spawn(5)if(src)
						src.icon_state = ""
						src.move=1
						src.canattack=1
						src.injutsu=0
						src.firing=0
		Shunshin()
			for(var/obj/Jutsus/Body_Flicker/J in src.JutsusLearnt)
				if(src.PreJutsu(J))
					if(!move) return
					if(injutsu) return
					if(copy=="Climb") return
					var/mob/c_target=src.Target_Get(TARGET_MOB)
					flick("jutsuse",src)
					view(src)<<sound('dash.wav',0,0)
					src.firing=1
					src.canattack=0
					src.move=0
					if(J.level==1) J.damage=1
					if(J.level==2) J.damage=2
					if(J.level==3) J.damage=3
					if(J.level==4) J.damage=4
					if(J.level<4) if(loc.loc:Safe!=1) J.exp+=rand(1,2); J.Levelup()
					if(c_target)
						//if(c_target.opponent) return
						flick('Shunshin.dmi',src)
						spawn(1)
							src.loc = c_target.loc
							step(src,c_target.dir)
							src.dir = get_dir(src,c_target)
					else
						flick('Shunshin.dmi',src)
						spawn(1)for(var/i=0,i<J.damage*3+1,i++)step(src,src.dir)
					//src.move=0
					spawn(5)if(src)
						src.firing=0
						src.move=1
						src.canattack=1

		Poison_Mist()
			for(var/obj/Jutsus/Poison_Mist/J in src.JutsusLearnt)
				if(src.PreJutsu(J))
					if(loc.loc:Safe!=1) src.LevelStat("Ninjutsu",rand(7,10))
					src.icon_state = "jutsuse"
					var/obj/PoisonMist/O=new(src)
					O.Ownzorz=src
					O.IsJutsuEffect=src
					spawn(1)src.icon_state = ""

		Body_Pathway_Derangement()
			for(var/obj/Jutsus/Body_Pathway_Derangement/J in src.JutsusLearnt)
				if(src.PreJutsu(J))
					if(loc.loc:Safe!=1) src.LevelStat("Ninjutsu",rand(7,10))
					if(J.level==1) J.damage=5
					if(J.level==2) J.damage=10
					if(J.level==3) J.damage=15
					if(J.level==4) J.damage=20
					if(J.level<4) if(loc.loc:Safe!=1) J.exp+=rand(3,6); J.Levelup()
					flick("punchr",src)
					var/mob/Z
					for(var/mob/M in get_step(src,src.dir))Z=M
					if(Z)
						Z.DealDamage(J.damage + src.strength,src,"NinBlue")
						Z.icon_state="dead"
						Z.move=0
						Z.Sleeping=1
						Z.injutsu=1
						Z.firing=1
						Z.canattack=0
						var/TimeAsleep = J.level*10 + src.ninjutsu*0.5
						spawn(TimeAsleep)
							if(!Z||Z.dead) continue
							Z.icon_state=""
							Z.move=1
							Z.Sleeping=0
							Z.injutsu=0
							Z.canattack=1
							Z.firing=0

		Heal()
			for(var/obj/Jutsus/Heal/J in src.JutsusLearnt)
				if(src.PreJutsu(J))
					if(loc.loc:Safe!=1) src.LevelStat("Ninjutsu",rand(7,10))
					if(J.level==1) J.damage=10
					if(J.level==2) J.damage=8
					if(J.level==3) J.damage=6
					if(J.level==4) J.damage=4
					if(J.level<4) if(loc.loc:Safe!=1) J.exp+=rand(3,6); J.Levelup()
					var/mob/Z
					var/check=0
					for(var/mob/M in get_step(src,src.dir))
						Z=M
						check=1
					if(check==0)Z=src
					if(Z)
						Z.DealDamage(Z.maxhealth/J.damage + src.ninjutsu/4,src,"HealGreen",1)
						Z.overlays += 'Healing.dmi'
						src.icon_state = "punchrS"
						spawn(5)
							Z.overlays -= 'Healing.dmi'
							src.icon_state = ""


		Curse_Dragon()
			for(var/obj/Jutsus/Curse_Dragon/J in src.JutsusLearnt)
				if(src.PreJutsu(J))
					var/mob/c_target=src.Target_Get(TARGET_MOB)
					if(loc.loc:Safe!=1) src.LevelStat("Ninjutsu",rand(7,9))
					if(J.level<4) if(loc.loc:Safe!=1) J.exp+=rand(2,5); J.Levelup()
					view()<<sound('man_fs_r_mt_wat.ogg')
					src.firing=1
					src.canattack=0
					src.move=0
					J.damage=J.level*50
					if(c_target)src.dir=get_dir(src,c_target)
					var/obj/Projectiles/Effects/JinraiBack/Aa=new(get_step(src,src.dir))
					Aa.icon = 'Curse Dragon.dmi'
					Aa.IsJutsuEffect=src
					Aa.dir = src.dir
					Aa.layer = src.layer+1
					Aa.pixel_y=16
					Aa.pixel_x=-16
					var/obj/Projectiles/Effects/JinraiHead/A=new(get_step(src,src.dir))
					A.icon = 'Curse Dragon.dmi'
					A.dir = src.dir
					A.Owner=src
					A.layer=src.layer+2
					A.fightlayer=src.fightlayer
					A.pixel_y=16
					A.pixel_x=-16
					A.damage=J.damage+round(src.agility*2)+round(src.ninjutsu*5)
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

		SageMode()
			if(firing)return
			if(src.firing==0 && src.canattack==1)
				for(var/obj/Jutsus/SageMode/J in src.JutsusLearnt)
					if(src.PreJutsu(J))
						if(loc.loc:Safe!=1) src.LevelStat("Ninjutsu",rand(7,11))
						view(src)<<sound('Skill_MashHit.wav',0,0)
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

		CurseSeal()
			if(firing)return
			if(src.firing==0 && src.canattack==1)
				for(var/obj/Jutsus/CurseSeal/J in src.JutsusLearnt)
					if(src.PreJutsu(J))
						if(loc.loc:Safe!=1) src.LevelStat("Ninjutsu",rand(7,11))
						view(src)<<sound('Skill_MashHit.wav',0,0)
						src.underlays+='CS Aura.dmi'
						src.ninjutsu+=10
						src.strength+=15
						src.incurse=1
						spawn(200)
							src.ninjutsu-=10
							src.strength-=15
							src.incurse=0
							src.underlays-='CS Aura.dmi'
							src<<"Curse Seal wears off..."



		Crow_Substitution()
			for(var/obj/Jutsus/Crow_Substitution/J in src.JutsusLearnt)
				if(src.PreJutsu(J))
					if(loc.loc:Safe!=1) src.LevelStat("Ninjutsu",rand(4,8))
					var/turf/T=src.loc
					src<<output("You will be sent to this location the next time your character accumulates damage.","ActionPanel.Output")
					var/X = src.health
					while(src.health == X)sleep(1)
					if(get_dist(usr,T)>30||usr.z != T.z)
						usr<<"\red <b>Your substitution was set too far away. Jutsu failed!"
						return
					for(var/i=0,i<8,i++)
						var/obj/O = new/obj
						O.loc = src.loc
						O.icon = 'CrowSub.dmi'
						O.pixel_x=-16
						spawn(1) step_rand(O)
						spawn(10)if(O)del(O)
					for(var/mob/M in oview(src,13))M.Target_Remove()
					src.loc = T

		HiddenSnakeStab()	//needs fixing. look into Bone drill. Fuinjutsu
			if(firing)return
			if(src.firing==0 && src.canattack==1)
				for(var/obj/Jutsus/HiddenSnakeStab/J in src.JutsusLearnt)
					if(src.PreJutsu(J))
						if(loc.loc:Safe!=1) src.LevelStat("Ninjutsu",rand(7,13))
						src.move=0
						src.injutsu=1
						src.firing=1
						src.canattack=0
						src.overlays+='Snake Jutsu.dmi'
						src.icon_state = "punchrS"
						flick("punchr",src)
						for(var/mob/player/M in get_dir(src,src.dir))
							M.DealDamage(J.level*src.strength/2+src.genjutsu*2,src,"NinBlue")
							M.Bleed()
							view(M)<<sound('knife_hit1.wav',0,0,volume=50)
						spawn(12)
							src.overlays=0
							src.RestoreOverlays()
							src.icon_state=""
							src.move=1
							src.injutsu=0
							src.firing=0
							src.canattack=1


		Dust_Particle_Prison()
			for(var/obj/Jutsus/Dust_Particle_Prison/J in src.JutsusLearnt)
				if(src.PreJutsu(J))
					var/mob/c_target=src.Target_Get(TARGET_MOB)
					if(!c_target)
						src << output("<Font color=White>You need a target to use this.</Font>","ActionPanel.Output")
						return
					if(loc.loc:Safe!=1) src.LevelStat("Ninjutsu",rand(4,8))
					src.canattack=0
					src.injutsu=1
					src.firing=1
					src.move=0
					if(J.level==1) J.damage=20
					if(J.level==2) J.damage=30
					if(J.level==3) J.damage=40
					if(J.level==4) J.damage=50
					if(J.level<4) if(loc.loc:Safe!=1) J.exp+=rand(3,6); J.Levelup()
					if(c_target)
						flick("jutsuse",src)
						src.move=0
						var/targetsloc
						targetsloc=c_target.loc
						var/obj/Dust/Prison/a=new/obj/Dust/Prison(targetsloc)
						spawn(1)
							a.icon_state="Prison"
							if(src)
								src.firing=0
								src.canattack=1
								src.injutsu=0
								src.move=1
							if(c_target&&c_target.loc==targetsloc)
								c_target.move=0
								c_target.injutsu=1
								c_target.firing=1
								c_target.canattack=0
								c_target.industprison=1
								spawn(J.damage)
									c_target.move=1
									c_target.injutsu=0
									c_target.firing=0
									c_target.canattack=1
									c_target.industprison=0
									del(a)

		Dust_Particle_Prison_Beam()
			for(var/obj/Jutsus/Dust_Particle_Prison_Beam/J in src.JutsusLearnt)
				if(src.PreJutsu(J))
					var/mob/c_target=src.Target_Get(TARGET_MOB)
					if(!c_target)
						src << output("<Font color=White>You need a target to use this.</Font>","ActionPanel.Output")
						return
					if(c_target.industprison!=1)
						src << output("<Font color=White>Your target needs to be in Dust Particle Prison in order for jutsu to work..</Font>","ActionPanel.Output")
						return
					if(loc.loc:Safe!=1) src.LevelStat("Ninjutsu",rand(4,8))
					src.injutsu=1
					src.firing=1
					src.move=0
					src.canattack=0
					if(J.level==1) J.damage=60
					if(J.level==2) J.damage=80
					if(J.level==3) J.damage=100
					if(J.level==4) J.damage=150
					if(J.level<4) if(loc.loc:Safe!=1) J.exp+=rand(3,6); J.Levelup()
					if(c_target)
						if(c_target.industprison==1)
							var/obj/Dust/Prison/a=new/obj/Dust/Prison(c_target.loc)
							c_target.move=0
							c_target.injutsu=1
							c_target.firing=1
							c_target.canattack=0
							a.icon_state="Beam"
							spawn(35)
								c_target.DealDamage(src.ninjutsu*20+J.damage,src,"NinBlue")
								c_target.move=1
								c_target.injutsu=0
								c_target.firing=0
								c_target.canattack=1
								del(a)
					src.injutsu=0
					src.firing=0
					src.move=1
					src.canattack=1

		Kamehameha()
			for(var/obj/Jutsus/Kamehameha/J in src.JutsusLearnt)
				if(src.PreJutsu(J))
					var/mob/c_target=src.Target_Get(TARGET_MOB)
					if(loc.loc:Safe!=1) src.LevelStat("Ninjutsu",rand(7,9))
					if(J.level<4) if(loc.loc:Safe!=1) J.exp+=rand(2,5); J.Levelup()
					view()<<sound('Kamehameflash.ogg')
					src.firing=1
					src.canattack=0
					src.move=0
					J.damage=J.level*50
					if(c_target)src.dir=get_dir(src,c_target)
					var/obj/Projectiles/Effects/JinraiBack/Aa=new(get_step(src,src.dir))
					Aa.icon = 'Kamehameha.dmi'
					Aa.IsJutsuEffect=src
					Aa.dir = src.dir
					Aa.layer = src.layer+1
					Aa.pixel_y=16
					Aa.pixel_x=-16
					var/obj/Projectiles/Effects/JinraiHead/A=new(get_step(src,src.dir))
					A.icon = 'Kamehameha.dmi'
					A.dir = src.dir
					A.Owner=src
					A.layer=src.layer
					A.fightlayer=src.fightlayer
					A.pixel_y=16
					A.pixel_x=-16
					A.damage=J.damage+round(src.agility*2)+round(src.ninjutsu*5)
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

		Rasengan()
			for(var/obj/Jutsus/Rasengan/J in src.JutsusLearnt)
				if(src.PreJutsu(J))
					if(Effects["Rasengan"])
						Effects["Rasengan"]=null
						src.overlays-=image('Rasengan.dmi',"spin")
						return
					if(loc.loc:Safe!=1) src.LevelStat("Ninjutsu",rand(4,8))
					if(J.level<4)
						if(loc.loc:Safe!=1) J.exp+=rand(2,5)
						J.Levelup()
					var/mob/c_target=src.Target_Get(TARGET_MOB)
					src.move=0
					src.injutsu=1
					src.canattack=0
					src.firing=1
					src.icon_state="punchrS"
					var/obj/I = new/obj
					I.IsJutsuEffect=src
					if(dir!=SOUTH) I.layer=MOB_LAYER-1
					I.loc = src.loc
					I.icon = 'Rasengan.dmi'
					switch(src.dir)
						if(SOUTH)
							I.pixel_y=-8
							I.layer = MOB_LAYER+1
						if(NORTH)
							I.pixel_y=5
							I.pixel_x=-12
						if(EAST)I.pixel_x=-13
						if(WEST)I.pixel_x=-11
					flick("form",I)
					spawn(3)
						I.icon_state = "spin"
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
					I.icon_state = "form"
					I.pixel_x=0
					walk_to(I,src)
					src.move=1
					src.injutsu=0
					src.canattack=1
					src.firing=0
					if(Effects["Rasengan"]<4||Prisoned)
						if(I)del(I)
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
									I.loc = M.loc
									I.icon_state = "explode"
									I.pixel_x=-16
									walk_to(I,0)
									walk_to(I,I.loc)
									M.DealDamage((2*J.level)*(src.ninjutsu/2),src,"NinBlue")
							sleep(0.5)
						del(I)
					move=1
					Effects["Rasengan"]=null
