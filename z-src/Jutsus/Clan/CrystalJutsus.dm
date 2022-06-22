mob
	proc
		Crystal_Arrow()
			for(var/obj/Jutsus/Crystal_Arrow/J in src.jutsus)
				if(src.PreJutsu(J))
					var/mob/c_target=src.Target_Get(TARGET_MOB)
					if(loc.loc:Safe!=1) src.LevelStat("Ninjutsu",rand(1,2))
					if(J.level<4) if(loc.loc:Safe!=1) J.exp+=rand(2,5); J.Levelup()
					src.PlayAudio('man_fs_r_mt_wat.ogg', output = AUDIO_HEARERS)
					J.damage=J.level*45
					if(c_target)src.dir=get_dir(src,c_target)
					var/obj/Projectiles/Effects/JinraiBack/Aa=new(get_step(src,src.dir))
					Aa.icon = 'Crystal Arrow.dmi'
					Aa.IsJutsuEffect=src
					Aa.dir = src.dir
					Aa.layer = src.layer+1
					Aa.pixel_y=16
					Aa.pixel_x=-16
					var/obj/Projectiles/Effects/JinraiHead/A=new(get_step(src,src.dir))
					A.icon = 'Crystal Arrow.dmi'
					A.dir = src.dir
					A.Owner=src
					A.layer=src.layer
					A.fightlayer=src.fightlayer
					A.pixel_y=16
					A.pixel_x=-16
					A.damage=J.damage+round(src.agility*2)+round(src.ninjutsu*5)
					A.level=J.level
					walk(A,dir,0)
					icon_state=""
					Aa.dir = src.dir

		Crystal_Mirrors()
			for(var/obj/Jutsus/Crystal_Mirrors/J in src.jutsus)
				if(src.PreJutsu(J))
					var/mob/c_target=src.Target_Get(TARGET_MOB)
					if(c_target)
						if(loc.loc:Safe!=1) src.LevelStat("Ninjutsu",rand(5,10))
						flick("jutsuse",src)
						src.PlayAudio('man_fs_l_mt_wat.ogg', output = AUDIO_HEARERS)
						src.pixel_x=4
						if(J.level==1) J.damage=5
						if(J.level==2) J.damage=15
						if(J.level==3) J.damage=25
						if(J.level==4) J.damage=35
						J.damage=J.damage+(src.ninjutsu/3.5)
						if(J.level<4) if(loc.loc:Safe!=1) J.exp+=rand(5,15); J.Levelup()
						for(var/i=1,i<8+1,i++)
							var/obj/O = new/obj
							O.IsJutsuEffect=src
							O.loc = c_target.loc
							O.icon = 'Crystal Mirrors.dmi'
							O.icon_state = "rawr"
							O.density=1
							O.layer = MOB_LAYER
							O.owner=src
							switch(i)
								if(1) O.dir = NORTHEAST
								if(2) O.dir = NORTHWEST
								if(3) O.dir = SOUTHEAST
								if(4) O.dir = SOUTHWEST
								if(6) O.dir = EAST
								if(7) O.dir = SOUTH
								if(8) O.dir = WEST
								if(5)
									O.dir = NORTH
									src.loc = O.loc
									src.dir=SOUTH
									O.layer = OBJ_LAYER
							for(var/ifd=0,ifd<3,ifd++)
								var/IOU = O.dir
								switch(O.dir)
									if(EAST) step(O,WEST)
									if(WEST) step(O,EAST)
									if(SOUTH) step(O,NORTH)
									if(NORTH) step(O,SOUTH)
									if(NORTHEAST) step(O,SOUTHWEST)
									if(NORTHWEST) step(O,SOUTHEAST)
									if(SOUTHEAST) step(O,NORTHWEST)
									if(SOUTHWEST) step(O,NORTHEAST)
								O.dir = IOU
							O.damage = J.damage
							O.name = "[i]"
						src.invisibility=1
						src.loc = c_target.loc
						step(src,NORTH)
						step(src,NORTH)
						var/turf/NS = get_step(src,NORTH)
						for(var/obj/Ouu in NS)if(Ouu.owner == src)src.loc = NS
						src.dir=SOUTH
						for(var/ivc=0,ivc<33*J.level,ivc++)
							if(src.ArrowTasked==null)
								var/olist = list()
								for(var/obj/Osd in view())if(Osd.owner == src)olist+=Osd
								if(length(olist))
									var/obj/IC = pick(olist)
									src.copy = "Icemir [IC.name]"
									var/image/A3 = new/obj
									A3.loc = IC.loc
									A3.icon = 'Misc Effects.dmi'
									A3.icon_state = "arrow"
									A3.y+=3
									A3.dir = pick(EAST,NORTH,SOUTH,WEST)
									A3.layer=100
									src.ArrowTasked = A3
									spawn(16)
										if(A3)
											var/obj/AT = src.ArrowTasked
											del(AT)
											src.ArrowTasked=null
							sleep(1)
						var/obj/AkT = src.ArrowTasked
						del(AkT)
						src.ArrowTasked=null
						for(var/obj/Ohh in view())
							if(Ohh.icon == 'Crystal Mirrors.dmi' && Ohh.owner == src)
								Ohh.invisibility=1
								Ohh.density=0
								Ohh.owner=null
								spawn(20)if(Ohh)del(Ohh)
							if(Ohh)if(Ohh.name == "GUI [src.key]")	del(Ohh)
						src.pixel_x=-16
						spawn(10-(J.level*2))if(src)
							src.invisibility=0
					else
						src << output("<Font color=Aqua>You need a target to use this.</Font>","Action.Output")

		Crystal_Pillar()
			for(var/obj/Jutsus/Crystal_Pillar/J in src.jutsus)
				if(src.PreJutsu(J))
					var/mob/c_target=src.Target_Get(TARGET_MOB)
					if(loc.loc:Safe!=1) src.LevelStat("Ninjutsu",rand(5,10))
					flick("jutsuse",src)
					src.PlayAudio('wind_leaves.ogg', output = AUDIO_HEARERS)
					if(J.level==1)J.damage=2
					if(J.level==2)J.damage=4
					if(J.level==3)J.damage=5
					if(J.level==4)J.damage=6
					if(J.level<4)if(loc.loc:Safe!=1)J.exp+=rand(3,6); J.Levelup()
					if(c_target)
						flick("groundjutsu",src)
						sleep(4)
						src.icon_state="groundjutsuse"
						spawn(3)
						if(c_target)
							src.dir=get_dir(src,c_target)
							var/obj/A = new(c_target.loc)
							A.IsJutsuEffect=src
							A.Owner=src
							A.density=1
							A.layer=MOB_LAYER+1
							var/I=J.damage*7
							A.icon='Crystal Pillar.dmi'
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
									spawn(2)
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
							if(src)
								src.icon_state=""
					else src<<output("This technique requires a target.","Action.Output")

		Crystal_Shards()
			for(var/obj/Jutsus/Crystal_Shards/J in src.jutsus)
				if(src.PreJutsu(J))
					if(loc.loc:Safe!=1) src.LevelStat("Ninjutsu",((J.maxcooltime*3/10)*jutsustatexp))
					var/mob/c_target=src.Target_Get(TARGET_MOB)
					if(J.level==1) J.damage=1*((jutsudamage*J.Sprice)/2.5)
					if(J.level==2) J.damage=1*((jutsudamage*J.Sprice)/2)
					if(J.level==3) J.damage=1*((jutsudamage*J.Sprice)/1.5)
					if(J.level==4) J.damage=1*(jutsudamage*J.Sprice)
					if(J.level<4) if(loc.loc:Safe!=1) J.exp+=jutsumastery*(J.maxcooltime/20); J.Levelup()
					AddState(src, new/state/cant_attack, 10)
					flick("jutsuse",src)
					if(c_target)
						var/obj/Projectiles/Effects/CrystalShards/A = new/obj/Projectiles/Effects/CrystalShards(src.loc)
						A.Owner=src
						A.dir=src.dir
						A.damage=J.damage+round((src.ninjutsu / 150)*2*J.damage)
						A.layer=src.layer
						walk_towards(A,c_target.loc)
						spawn(50)
							del(A)
					else
						var/obj/Projectiles/Effects/CrystalShards/A = new/obj/Projectiles/Effects/CrystalShards(src.loc)
						A.Owner=src
						A.dir=src.dir
						A.layer=src.layer
						A.damage=J.damage+round((src.ninjutsu / 150)*2*J.damage)
						walk(A,A.dir)
						spawn(50)
							del(A)

		Crystal_Needles()
			for(var/obj/Jutsus/Crystal_Needles/J in src.jutsus)
				if(src.PreJutsu(J))
					if(loc.loc:Safe!=1) src.LevelStat("Ninjutsu",((J.maxcooltime*3/10)*jutsustatexp))
					var/mob/c_target=src.Target_Get(TARGET_MOB)
					if(J.level==1) J.damage=0.4*((jutsudamage*J.Sprice)/2.5)
					if(J.level==2) J.damage=0.4*((jutsudamage*J.Sprice)/2)
					if(J.level==3) J.damage=0.4*((jutsudamage*J.Sprice)/1.5)
					if(J.level==4) J.damage=0.4*(jutsudamage*J.Sprice)
					if(J.level<4) if(loc.loc:Safe!=1) J.exp+=jutsumastery*(J.maxcooltime/20); J.Levelup()
					AddState(src, new/state/cant_attack, 10)
					flick("jutsuse",src)
					if(c_target)
						var/obj/Projectiles/Effects/CrystalNeedles/A = new/obj/Projectiles/Effects/CrystalNeedles(src.loc)
						A.Owner=src
						A.dir=src.dir
						A.damage=J.damage+round((src.ninjutsu / 150)*2*J.damage)
						A.layer=src.layer
						walk_towards(A,c_target.loc)
						sleep(1)
						var/obj/Projectiles/Effects/CrystalNeedles/B = new/obj/Projectiles/Effects/CrystalNeedles(src.loc)
						B.Owner=src
						B.dir=src.dir
						B.damage=J.damage+round((src.ninjutsu / 150)*2*J.damage)
						B.layer=src.layer
						walk_towards(B,c_target.loc)
						spawn(50)
							del(A)
							del(B)
					else
						var/obj/Projectiles/Effects/CrystalNeedles/A = new/obj/Projectiles/Effects/CrystalNeedles(src.loc)
						A.Owner=src
						A.dir=src.dir
						A.layer=src.layer
						A.damage=J.damage+round((src.ninjutsu / 150)*2*J.damage)
						walk(A,A.dir)
						sleep(1)
						var/obj/Projectiles/Effects/CrystalNeedles/B = new/obj/Projectiles/Effects/CrystalNeedles(src.loc)
						B.Owner=src
						B.dir=src.dir
						B.layer=src.layer
						B.damage=J.damage+round((src.ninjutsu / 150)*2*J.damage)
						walk(B,B.dir)
						spawn(50)
							del(A)
							del(B)

		Crystal_Spikes()
			for(var/obj/Jutsus/Crystal_Spikes/J in src.jutsus)
				if(src.PreJutsu(J))
					var/mob/c_target=src.Target_Get(TARGET_MOB)
					if(!c_target)
						src << output("You need a target to use this.","Action.Output")
						return
					if(loc.loc:Safe!=1) src.LevelStat("Ninjutsu",((J.maxcooltime*3/10)*jutsustatexp))
					if(J.level==1) J.damage=0.7*((jutsudamage*J.Sprice)/2.5)
					if(J.level==2) J.damage=0.7*((jutsudamage*J.Sprice)/2)
					if(J.level==3) J.damage=0.7*((jutsudamage*J.Sprice)/1.5)
					if(J.level==4) J.damage=0.7*(jutsudamage*J.Sprice)
					if(J.level<4) if(loc.loc:Safe!=1) J.exp+=jutsumastery*(J.maxcooltime/20); J.Levelup()
					Bind(src, 3)
					flick("groundjutsu",src)
					var/obj/senjuu/stab/s=new/obj/crystal/spikes(c_target.loc)
					spawn(1)
						if(c_target.loc==s.loc)
							AddState(c_target, new/state/cant_move, 3)
							c_target.DealDamage(J.damage+round((src.ninjutsu / 150)*2*J.damage),src,"NinBlue")
							c_target.Bleed()
							c_target.PlayAudio('knife_hit1.wav', output = AUDIO_HEARERS)
						else
							spawn(3)
								del(s)

		Crystal_Explosion()
			for(var/obj/Jutsus/Crystal_Explosion/J in src.jutsus)
				if(src.PreJutsu(J))
					if(loc.loc:Safe!=1) src.LevelStat("Ninjutsu",((J.maxcooltime*3/10)*jutsustatexp))
					if(J.level==1) J.damage=0.8*((jutsudamage*J.Sprice)/2.5)
					if(J.level==2) J.damage=0.8*((jutsudamage*J.Sprice)/2)
					if(J.level==3) J.damage=0.8*((jutsudamage*J.Sprice)/1.5)
					if(J.level==4) J.damage=0.8*(jutsudamage*J.Sprice)
					if(J.level<4) if(loc.loc:Safe!=1) J.exp+=jutsumastery*(J.maxcooltime/20); J.Levelup()
					Bind(src, 25)
					src.icon_state="groundjutsuse"
					var/obj/crystal/explosion/A=new/obj/crystal/explosion(src.loc)
					A.icon_state = "blank"
					A.dir = src.dir
					A.Owner = src
					A.damage=J.damage+round((src.ninjutsu / 150)*2*J.damage)
					spawn(25)
						src.icon_state=""
					walk(A,src.dir,2)
				break
