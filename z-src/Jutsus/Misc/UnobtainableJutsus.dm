mob
	proc
		Kamehameha()
			for(var/obj/Jutsus/Kamehameha/J in src.jutsus)
				if(src.PreJutsu(J))
					var/mob/c_target=src.Target_Get(TARGET_MOB)
					if(loc.loc:Safe!=1) src.LevelStat("Ninjutsu",rand(7,9))
					if(J.level<4) if(loc.loc:Safe!=1) J.exp+=rand(2,5); J.Levelup()
					src.PlayAudio('Kamehameflash.ogg', output = AUDIO_HEARERS)
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
					A.damage=J.damage+round(src.agility_total*2)+round(src.ninjutsu_total*5)
					A.level=J.level
					walk(A,dir,0)
					icon_state=""
					Aa.dir = src.dir


		Dust_Particle_Prison_Beam()
			for(var/obj/Jutsus/Dust_Particle_Prison_Beam/J in src.jutsus)
				if(src.PreJutsu(J))
					var/mob/c_target=src.Target_Get(TARGET_MOB)
					if(!c_target)
						src << output("<Font color=White>You need a target to use this.</Font>","Action.Output")
						return
					if(c_target.industprison!=1)
						src << output("<Font color=White>Your target needs to be in Dust Particle Prison in order for jutsu to work..</Font>","Action.Output")
						return
					if(loc.loc:Safe!=1) src.LevelStat("Ninjutsu",rand(4,8))
					if(J.level==1) J.damage=60
					if(J.level==2) J.damage=80
					if(J.level==3) J.damage=100
					if(J.level==4) J.damage=150
					if(J.level<4) if(loc.loc:Safe!=1) J.exp+=rand(3,6); J.Levelup()
					if(c_target)
						if(c_target.industprison==1)
							var/obj/Dust/Prison/a=new/obj/Dust/Prison(c_target.loc)
							a.icon_state="Beam"
							spawn(35)
								c_target.DealDamage(src.ninjutsu_total*20+J.damage,src,"NinBlue")
								del(a)


		Dust_Particle_Prison()
			for(var/obj/Jutsus/Dust_Particle_Prison/J in src.jutsus)
				if(src.PreJutsu(J))
					var/mob/c_target=src.Target_Get(TARGET_MOB)
					if(!c_target)
						src << output("<Font color=White>You need a target to use this.</Font>","Action.Output")
						return
					if(loc.loc:Safe!=1) src.LevelStat("Ninjutsu",rand(4,8))
					if(J.level==1) J.damage=20
					if(J.level==2) J.damage=30
					if(J.level==3) J.damage=40
					if(J.level==4) J.damage=50
					if(J.level<4) if(loc.loc:Safe!=1) J.exp+=rand(3,6); J.Levelup()
					if(c_target)
						flick("jutsuse",src)
						var/targetsloc
						targetsloc=c_target.loc
						var/obj/Dust/Prison/a=new/obj/Dust/Prison(targetsloc)
						spawn(1)
							a.icon_state="Prison"
							if(c_target&&c_target.loc==targetsloc)
								c_target.industprison=1
								spawn(J.damage)
									c_target.industprison=0
									del(a)

		CurseSeal()
			for(var/obj/Jutsus/CurseSeal/J in src.jutsus)
				if(src.PreJutsu(J))
					if(loc.loc:Safe!=1) src.LevelStat("Ninjutsu",rand(7,11))
					src.PlayAudio('Skill_MashHit.wav', output = AUDIO_HEARERS)
					src.underlays+='CS Aura.dmi'
					src.ninjutsu_buffed+=10
					src.taijutsu_buffed+=15
					src.incurse=1
					spawn(150)
						src.ninjutsu_buffed-=10
						src.taijutsu_buffed-=15
						src.incurse=0
						src.underlays-='CS Aura.dmi'
						src<<"Curse Seal wears off..."

		Curse_Dragon()
			for(var/obj/Jutsus/Curse_Dragon/J in src.jutsus)
				if(src.PreJutsu(J))
					var/mob/c_target=src.Target_Get(TARGET_MOB)
					if(loc.loc:Safe!=1) src.LevelStat("Ninjutsu",rand(7,9))
					if(J.level<4) if(loc.loc:Safe!=1) J.exp+=rand(2,5); J.Levelup()
					src.PlayAudio('man_fs_r_mt_wat.ogg', output = AUDIO_HEARERS)
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
					A.damage=J.damage+round(src.agility_total*2)+round(src.ninjutsu_total*5)
					A.level=J.level
					walk(A,dir,0)
					icon_state=""
					Aa.dir = src.dir

		Getsuga_Tenshou()
			for(var/obj/Jutsus/Getsuga_Tenshou/J in src.jutsus)
				if(src.PreJutsu(J))
					if(loc.loc:Safe!=1) src.LevelStat("Ninjutsu",0.2)
					flick("jutsuse",src)
					if(J.level==1) J.damage=10
					if(J.level==2) J.damage=20
					if(J.level==3) J.damage=30
					if(J.level==4) J.damage=40
					if(J.level<4) if(loc.loc:Safe!=1) J.exp+=rand(1,2); J.Levelup()
					var/obj/Getsuga/A = new/obj/Getsuga(src.loc)
					src.PlayAudio('GetsugaTenshou.wav', output = AUDIO_HEARERS)
					A.IsJutsuEffect=src
					A.Owner=src
					A.layer=src.layer
					A.fightlayer=src.fightlayer
					A.damage=J.damage
					A.level=J.level
					walk(A,src.dir,0)