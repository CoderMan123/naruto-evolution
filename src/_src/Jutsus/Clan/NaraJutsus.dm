mob
	proc
		Shadow_Stab()
			for(var/obj/Jutsus/Shadow_Stab/J in src.jutsus)
				if(src.PreJutsu(J))
					if(loc.loc:Safe!=1) src.LevelStat("Ninjutsu",rand(5,7))
					if(J.level==1) J.damage=35
					if(J.level==2) J.damage=45
					if(J.level==3) J.damage=55
					if(J.level==4) J.damage=65
					if(J.level<4) if(loc.loc:Safe!=1) J.exp+=rand(2,5); J.Levelup()
					flick("jutsuse",src)
					view(src)<<sound('dash.wav',0,0)
					var/mob/M=NaraTarget
					var/obj/O=new
					O.IsJutsuEffect=src
					O.icon='Multiple Shadow Stab.dmi'
					O.loc=M.loc
					O.layer=MOB_LAYER+1
					O.pixel_x=-16
					M.DealDamage(J.damage+round(src.ninjutsu*4),src,"NinBlue")
					flick("stab",O)
					if(!M) M.Bleed()
					spawn(5)if(O)del(O)

		Shadow_Choke()
			for(var/obj/Jutsus/Shadow_Choke/J in src.jutsus)
				if(src.PreJutsu(J))
					if(loc.loc:Safe!=1) src.LevelStat("Ninjutsu",rand(5,7))
					if(J.level==1) J.damage=10
					if(J.level==2) J.damage=15
					if(J.level==3) J.damage=20
					if(J.level==4) J.damage=25
					if(J.level<4) if(loc.loc:Safe!=1) J.exp+=rand(2,5); J.Levelup()
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
					M.DealDamage(J.damage+src.ninjutsu*3.5,src,"NinBlue")
					while(Timer&&NaraTarget&&M)
						Timer--
						sleep(4)
						O.icon_state = "choke"
					del(O)

		Shadow_Extension()
			for(var/obj/Jutsus/Shadow_Extension/J in src.jutsus)
				if(src.PreJutsu(J))
					var/mob/c_target=src.Target_Get(TARGET_MOB)
					if(loc.loc:Safe!=1) src.LevelStat("Ninjutsu",rand(5,7))
					if(J.level<4)
						if(loc.loc:Safe!=1)
							J.exp+=rand(2,5)
							J.Levelup()
					flick("jutsuse",src)
					view(src)<<sound('dash.wav',0,0)
					if(c_target)
						dir = get_dir(src,c_target)
						CreateTrailNara(c_target,J.level*5)
					else
						Target_A_Mob()
						c_target=src.Target_Get(TARGET_MOB)
						if(c_target)
							dir = get_dir(src,c_target)
							CreateTrailNara(c_target,J.level*4)
		Shadow_Explosion()
			for(var/obj/Jutsus/Shadow_Explosion/J in src.jutsus)
				if(src.PreJutsu(J))
					if(loc.loc:Safe!=1) src.LevelStat("Ninjutsu",rand(1,2))
					if(J.level==1) J.damage=5
					if(J.level==2) J.damage=10
					if(J.level==3) J.damage=15
					if(J.level==4) J.damage=30
					if(J.level<4) if(loc.loc:Safe!=1) J.exp+=rand(2,5); J.Levelup()
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
					J.damage = J.damage+src.ninjutsu*1.5
					while(Timer&&NaraTarget&&M)
						Timer--
						sleep(4)
						O.icon_state = "explode"
						M.DealDamage(J.damage,src,"NinBlue")
					del(O)

		Shadow_Punch()
			for(var/obj/Jutsus/Shadow_Punch/J in src.jutsus)
				if(src.PreJutsu(J))
					var/mob/c_target=src.Target_Get(TARGET_MOB)
					if(loc.loc:Safe!=1) src.LevelStat("Ninjutsu",rand(1,2))
					if(J.level<4) if(loc.loc:Safe!=1) J.exp+=rand(2,5); J.Levelup()
					view()<<sound('man_fs_r_mt_wat.ogg')
					src.firing=1
					src.canattack=0
					src.move=0
					J.damage=J.level*30
					if(c_target)src.dir=get_dir(src,c_target)
					var/obj/Projectiles/Effects/JinraiBack/Aa=new(get_step(src,src.dir))
					Aa.icon = 'Shadow Punch.dmi'
					Aa.IsJutsuEffect=src
					Aa.dir = src.dir
					Aa.layer = src.layer+1
					Aa.pixel_y=16
					Aa.pixel_x=-16
					var/obj/Projectiles/Effects/JinraiHead/A=new(get_step(src,src.dir))
					A.icon = 'Shadow Punch.dmi'
					A.dir = src.dir
					A.Owner=src
					A.layer=src.layer
					A.fightlayer=src.fightlayer
					A.pixel_y=16
					A.pixel_x=-16
					A.damage=J.damage+round(src.ninjutsu*4)
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
