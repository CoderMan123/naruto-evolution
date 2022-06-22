mob
	proc
		Fire_Ball()
			for(var/obj/Jutsus/FireBall/J in src.jutsus)
				if(src.PreJutsu(J))
					var/mob/c_target=src.Target_Get(TARGET_MOB)
					if(loc.loc:Safe!=1) src.LevelStat("Ninjutsu",((J.maxcooltime*3/10)*jutsustatexp))//XPGAIN
					flick("jutsuse",src)
					src.PlayAudio('fire.wav', output = AUDIO_HEARERS)
					Bind(src, 2)
					if(J.level==1) J.damage=0.9*((jutsudamage*J.Sprice)/2.5)
					if(J.level==2) J.damage=0.9*((jutsudamage*J.Sprice)/2)
					if(J.level==3) J.damage=0.9*((jutsudamage*J.Sprice)/1.5)
					if(J.level==4) J.damage=0.9*(jutsudamage*J.Sprice)
					if(J.level<4) if(loc.loc:Safe!=1) J.exp+=jutsumastery*(J.maxcooltime/20); J.Levelup()
					if(c_target)
						src.dir=get_dir(src,c_target)
						var/obj/Projectiles/FireBall/A = new/obj/Projectiles/FireBall(src.loc)
						A.IsJutsuEffect=src
						A.Owner=src
						A.layer=src.layer
						A.fightlayer=src.fightlayer
						A.damage=J.damage+round((src.ninjutsu / 150)*2*J.damage)
						A.level=J.level
						walk_towards(A,c_target.loc,0)
						spawn(4)if(A)walk(A,A.dir)
					else
						var/obj/Projectiles/FireBall/A = new/obj/Projectiles/FireBall(src.loc)
						A.IsJutsuEffect=src
						A.Owner=src
						A.layer=src.layer
						A.fightlayer=src.fightlayer
						A.damage=J.damage+round((src.ninjutsu / 150)*2*J.damage)
						A.level=J.level
						walk(A,src.dir)

		Magma_Crush()
			for(var/obj/Jutsus/Magma_Crush/J in src.jutsus)
				var/mob/c_target=src.Target_Get(TARGET_MOB)
				if(!c_target||!istype(c_target))
					src<<output("You must have a target to use this technique.","Action.Output")
					return

				if(src.PreJutsu(J))
					if(loc.loc:Safe!=1) src.LevelStat("Ninjutsu",((J.maxcooltime*3/10)*jutsustatexp))
					flick("jutsuse",src)
					src.PlayAudio('wind_leaves.ogg', output = AUDIO_HEARERS)
					Bind(src, 4)
					if(J.level==1)J.damage=3
					if(J.level==2)J.damage=5
					if(J.level==3)J.damage=6
					if(J.level==4)J.damage=7
					if(J.level<4)if(loc.loc:Safe!=1)J.exp+=jutsumastery*(J.maxcooltime/20); J.Levelup()
					if(c_target)
						flick("groundjutsu",src)
						sleep(4)
						src.icon_state="groundjutsuse"
						if(c_target)
							src.dir=get_dir(src,c_target)
							var/obj/A = new(c_target.loc)
							A.IsJutsuEffect=src
							A.Owner=src
							A.density=1
							A.layer=MOB_LAYER+1
							var/I=J.damage*8
							A.icon='Magma_Crush.dmi'
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
								for(var/mob/F in A.loc)
									F.health=oldhealth
									if(I2==8)
										I2=0
										if(F)
											F.DealDamage(J.damage,src,"NinBlue")
											Bind(F, 10)
											oldhealth=(oldhealth-J.damage)
											F.health=oldhealth
								sleep(1)
							if(src)
								flick("delete",A)
								sleep(4)
								del(A)
								src.icon_state=""

		Magma_Needles()
			for(var/obj/Jutsus/Magma_Needles/J in src.jutsus)
				if(src.PreJutsu(J))
					var/mob/c_target=src.Target_Get(TARGET_MOB)
					if(loc.loc:Safe!=1) src.LevelStat("Ninjutsu",((J.maxcooltime*3/20)*jutsustatexp))
					if(loc.loc:Safe!=1) src.LevelStat("Precision",((J.maxcooltime*3/20)*jutsustatexp))
					flick("2fist",src)
					src.PlayAudio('046.wav', output = AUDIO_HEARERS)
					AddState(src, new/state/cant_attack, 5)
					if(J.level==1) J.damage=0.9*((jutsudamage*J.Sprice)/2.5)
					if(J.level==2) J.damage=0.9*((jutsudamage*J.Sprice)/2)
					if(J.level==3) J.damage=0.9*((jutsudamage*J.Sprice)/1.5)
					if(J.level==4) J.damage=0.9*(jutsudamage*J.Sprice)
					if(J.level<4) if(loc.loc:Safe!=1) J.exp+=jutsumastery*(J.maxcooltime/20); J.Levelup()
					var/num=5
					if(c_target)
						while(num)
							sleep(1)
							src.dir=get_dir(src,c_target)
							var/obj/Projectiles/Weaponry/Magma_Needles/A = new/obj/Projectiles/Weaponry/Magma_Needles(src.loc)
							A.IsJutsuEffect=src
							A.density=0
							switch(num)
								if(5)
									switch(src.dir)
										if(EAST)A.x+=1
										if(WEST)A.x-=1
										if(NORTH)A.y+=1
										if(SOUTH)A.y-=1
								if(4)
									switch(src.dir)
										if(EAST)
											A.y+=1
											A.x+=1
										if(WEST)
											A.y+=1
											A.x-=1
										if(NORTH)
											A.x+=1
											A.y+=1
										if(SOUTH)
											A.x+=1
											A.y-=1
								if(3)
									switch(src.dir)
										if(EAST)
											A.y+=2
											A.x+=1
										if(WEST)
											A.y+=2
											A.x-=1
										if(NORTH)
											A.x+=2
											A.y+=1
										if(SOUTH)
											A.x+=2
											A.y-=1
								if(2)
									switch(src.dir)
										if(EAST)
											A.y-=1
											A.x+=1
										if(WEST)
											A.y-=1
											A.x-=1
										if(NORTH)
											A.x-=1
											A.y+=1
										if(SOUTH)
											A.x-=1
											A.y-=1
								if(1)
									switch(src.dir)
										if(EAST)
											A.y-=2
											A.x+=1
										if(WEST)
											A.y-=2
											A.x-=1
										if(NORTH)
											A.x-=2
											A.y+=1
										if(SOUTH)
											A.x-=2
											A.y-=1
							A.level=J.level
							A.Owner=src
							A.layer=src.layer
							A.fightlayer=src.fightlayer
							A.damage=(J.damage+round((src.ninjutsu / 300)*2*J.damage)+round((src.taijutsu / 300)*2*J.damage))/5
							var/turf/Tg
							Tg = get_step(c_target,pick(NORTH,SOUTH,EAST,WEST))
							var/k = rand(1,5)
							spawn() switch(k)
								if(1)
									spawn(1) A.density=1
									walk_towards(A,c_target.loc,0)
								else
									spawn(1) A.density=1
									walk_towards(A,Tg,0)
							spawn(4)
								spawn(1) if(A) A.density=1
								if(A) walk(A,A.dir)
							num--
					else
						while(num)
							num--
							sleep(1)
							var/obj/Projectiles/Weaponry/Magma_Needles/A = new/obj/Projectiles/Weaponry/Magma_Needles(src.loc)
							A.IsJutsuEffect=src
							switch(num)
								if(5)
									switch(src.dir)
										if(EAST)A.x+=1
										if(WEST)A.x-=1
										if(NORTH)A.y+=1
										if(SOUTH)A.y-=1
								if(4)
									switch(src.dir)
										if(EAST)
											A.y+=1
											A.x+=1
										if(WEST)
											A.y+=1
											A.x-=1
										if(NORTH)
											A.x+=1
											A.y+=1
										if(SOUTH)
											A.x+=1
											A.y-=1
								if(3)
									switch(src.dir)
										if(EAST)
											A.y+=2
											A.x+=1
										if(WEST)
											A.y+=2
											A.x-=1
										if(NORTH)
											A.x+=2
											A.y+=1
										if(SOUTH)
											A.x+=2
											A.y-=1
								if(2)
									switch(src.dir)
										if(EAST)
											A.y-=1
											A.x+=1
										if(WEST)
											A.y-=1
											A.x-=1
										if(NORTH)
											A.x-=1
											A.y+=1
										if(SOUTH)
											A.x-=1
											A.y-=1
								if(1)
									switch(src.dir)
										if(EAST)
											A.y-=2
											A.x+=1
										if(WEST)
											A.y-=2
											A.x-=1
										if(NORTH)
											A.x-=2
											A.y+=1
										if(SOUTH)
											A.x-=2
											A.y-=1
							step(A,A.dir)
							if(A)
								A.level=J.level
								A.Owner=src
								A.layer=src.layer
								A.fightlayer=src.fightlayer
								A.damage=(J.damage+round((src.ninjutsu / 300)*2*J.damage)+round((src.taijutsu / 300)*2*J.damage))/5
							spawn() walk(A,src.dir)

		Phoenix_Immortal_Fire_Technique()
			for(var/obj/Jutsus/PheonixFire/J in src.jutsus)
				if(src.PreJutsu(J))
					var/mob/c_target=src.Target_Get(TARGET_MOB)
					src.LevelStat("Ninjutsu",((J.maxcooltime*3/10)*jutsustatexp))
					flick("jutsuse",src)
					src.PlayAudio('fire.wav', output = AUDIO_HEARERS)
					var/I=J.level*2
					
					var/state/cant_attack/e = new()
					AddState(src, e, -1)

					if(J.level==1) J.damage=((jutsudamage*J.Sprice)/2.5)
					if(J.level==2) J.damage=((jutsudamage*J.Sprice)/2)
					if(J.level==3) J.damage=((jutsudamage*J.Sprice)/1.5)
					if(J.level==4) J.damage=(jutsudamage*J.Sprice)
					if(J.level<4)
						J.exp+=jutsumastery*(J.maxcooltime/20)
						J.Levelup()
					spawn(5)
						while(I)
							I--
							sleep(2)
							if(c_target)
								src.dir=get_dir(src,c_target)
								var/obj/Projectiles/FireBall/A = new/obj/Projectiles/FireBall(src.loc)
								A.IsJutsuEffect=src
								if(prob(50))A.pixel_y+=rand(1,8)
								else A.pixel_y-=rand(1,8)
								if(prob(50))A.pixel_x+=rand(1,8)
								else A.pixel_x-=rand(1,8)
								A.Owner=src
								A.layer=src.layer
								A.fightlayer=src.fightlayer
								A.damage=(J.damage+round((src.ninjutsu / 150)*2*J.damage))/7
								A.level=J.level
								walk_towards(A,c_target.loc,0)
								spawn(4)if(A)walk(A,A.dir)
							else
								var/obj/Projectiles/FireBall/A = new/obj/Projectiles/FireBall(src.loc)
								A.IsJutsuEffect=src
								if(prob(50))A.pixel_y+=rand(1,8)
								else A.pixel_y-=rand(1,8)
								if(prob(50))A.pixel_x+=rand(1,8)
								else A.pixel_x-=rand(1,8)
								A.Owner=src
								A.fightlayer=src.fightlayer
								A.layer=src.layer
								A.damage=(J.damage+((src.ninjutsu / 150)*2*J.damage))/7
								A.level=J.level
								walk(A,src.dir)
					src.copy=null
					spawn(6)if(src)
						RemoveState(src, e, STATE_REMOVE_REF)

		AFire_Ball()
			for(var/obj/Jutsus/AFireBall/J in src.jutsus)
				if(src.PreJutsu(J))
					var/mob/c_target=src.Target_Get(TARGET_MOB)
					if(loc.loc:Safe!=1) src.LevelStat("Ninjutsu",((J.maxcooltime*3/10)*jutsustatexp))
					flick("jutsuse",src)
					src.PlayAudio('fire.wav', output = AUDIO_HEARERS)
					AddState(src, new/state/cant_attack, 5)
					if(J.level==1) J.damage=((jutsudamage*J.Sprice)/2.5)
					if(J.level==2) J.damage=((jutsudamage*J.Sprice)/2)
					if(J.level==3) J.damage=((jutsudamage*J.Sprice)/1.5)
					if(J.level==4) J.damage=(jutsudamage*J.Sprice)
					if(J.level<4) if(loc.loc:Safe!=1) J.exp+=jutsumastery*(J.maxcooltime/20); J.Levelup()
					if(c_target)
						src.dir=get_dir(src,c_target)
						var/obj/Projectiles/AFireBall/A = new/obj/Projectiles/AFireBall(src.loc)
						A.IsJutsuEffect=src
						A.Owner=src
						A.layer=src.layer
						A.fightlayer=src.fightlayer
						A.damage=0.9*(J.damage+round((src.ninjutsu / 150)*2*J.damage))
						A.level=J.level
						walk_towards(A,c_target.loc,0)
						spawn(4)if(A)walk(A,A.dir)
					else
						var/obj/Projectiles/AFireBall/A = new/obj/Projectiles/AFireBall(src.loc)
						A.IsJutsuEffect=src
						A.Owner=src
						A.layer=src.layer
						A.fightlayer=src.fightlayer
						A.damage=0.9*(J.damage+round((src.ninjutsu / 150)*2*J.damage))
						A.level=J.level
						walk(A,src.dir)

		Fire_Release_Ash_Pile_Burning()
			for(var/obj/Jutsus/Fire_Release_Ash_Pile_Burning/J in src.jutsus)
				if(src.PreJutsu(J))
					if(loc.loc:Safe!=1) src.LevelStat("Ninjutsu",((J.maxcooltime*3/10)*jutsustatexp))
					flick("jutsuse",src)

					var/state/cant_attack/e = new()
					AddState(src, e, -1)

					var/state/cant_move/f = new()
					AddState(src, f, -1)

					if(J.level==1) J.damage=((jutsudamage*J.Sprice)/2.5)
					if(J.level==2) J.damage=((jutsudamage*J.Sprice)/2)
					if(J.level==3) J.damage=((jutsudamage*J.Sprice)/1.5)
					if(J.level==4) J.damage=(jutsudamage*J.Sprice)
					if(J.level<4)
						if(loc.loc:Safe!=1) J.exp+=jutsumastery*(J.maxcooltime/20)
						J.Levelup()
					src.icon_state = "jutsuse"
					var/obj/Z = new/obj
					Z.loc = src.loc
					Z.density=1
					var/R=5
					while(R)
						sleep(1)
						R--
						step(Z,src.dir)
					Z.density=0
					var/U = get_dist(Z,src)
					U-=1
					for(var/turf/T in orange(U,Z))
						var/obj/ash/O = new(T)
						O.IsJutsuEffect=src
						O.owner=src
						spawn(150)
							if(O) O.loc = null
					src.copy = "Ashes"
					var/obj/A = new/obj
					A.IsJutsuEffect=src
					A.loc = src.loc
					A.icon = 'Misc Effects.dmi'
					A.icon_state = "arrow"
					A.y+=3
					A.dir = SOUTH
					A.layer=100
					src.ArrowTasked = A
					if(istype(src, /mob/npc))
						spawn(10)
							var/k = src.ArrowTasked
							del(k)
							src.ArrowTasked = null
							src.ashbomb()
					spawn(150)
						if(ArrowTasked==A) ArrowTasked=null; src.copy=null; del(A)
					src << output("<Font color=[colour2html("orange")]>Press down to ignite the ashes.</Font>","Action.Output")
					for(var/obj/As in get_step(src,src.dir))
						As.layer=OBJ_LAYER
					while(src.copy == "Ashes")
						sleep(1)
					src.copy=null
					RemoveState(src, e, STATE_REMOVE_REF)
					RemoveState(src, f, STATE_REMOVE_REF)



		Fire_Dragon_Projectile()
			for(var/obj/Jutsus/Fire_Dragon_Projectile/J in src.jutsus)
				if(src.PreJutsu(J))
					var/mob/c_target=src.Target_Get(TARGET_MOB)
					if(loc.loc:Safe!=1) src.LevelStat("Ninjutsu",((J.maxcooltime*3/10)*jutsustatexp))
					if(J.level==1) J.damage=((jutsudamage*J.Sprice)/2.5)
					if(J.level==2) J.damage=((jutsudamage*J.Sprice)/2)
					if(J.level==3) J.damage=((jutsudamage*J.Sprice)/1.5)
					if(J.level==4) J.damage=(jutsudamage*J.Sprice)
					if(J.level<4) if(loc.loc:Safe!=1) J.exp+=jutsumastery*(J.maxcooltime/20); J.Levelup()
					flick("jutsuse",src)
					Bind(src, 5)
					sleep(5)
					flick("2fist",src)
					src.PlayAudio('fire.wav', output = AUDIO_HEARERS)
					if(c_target)src.dir=get_dir(src,c_target)
					var/obj/Projectiles/Effects/JinraiBack/Aa=new(get_step(src,src.dir))
					Aa.icon = 'FireBallA.dmi'
					Aa.IsJutsuEffect=src
					Aa.dir = src.dir
					Aa.pixel_y=16
					Aa.pixel_x=-16
					Aa.layer = src.layer+1
					var/obj/Projectiles/Effects/JinraiHead/A=new(get_step(src,src.dir))
					A.icon = 'FireBallA.dmi'
					A.dir = src.dir
					A.Owner=src
					A.pixel_y=16
					A.pixel_x=-16
					A.layer=src.layer+2
					A.fightlayer=src.fightlayer
					A.damage=0.9*(J.damage+round((src.ninjutsu / 150)*2*J.damage))
					A.level=J.level
					walk(A,dir,0)
					icon_state=""
					Aa.dir = src.dir

obj
	ash
		icon = 'Smoke.dmi'
		icon_state = "still"