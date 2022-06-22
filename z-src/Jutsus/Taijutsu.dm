//Gates. Attack Defend. Other big procs.


mob
	proc
/*
		ScreenShake(amplitude, duration)
			set waitfor = 0
			set background = 1
			//world.log << "shaking"
			animate(src, pixel_x = 0, pixel_y = 0, time = 0, loop = duration)
			for(var/i = 1 to duration)
				animate(pixel_x = rand(-amplitude, amplitude), pixel_y = rand(-amplitude, amplitude), time = 1)
			sleep(duration)
			if(src)
				animate(src, pixel_x = 0, pixel_y = 0, time = 1)
*/


		ScreenShake(var/Times)
			if(!src.screen_moved)
				if(src.client&&src.client.eye==src)
					//if(Times) src.screen_moved=Times
					//if(src.screen_moved>=5) src.screen_moved=null
					while(Times)
						Times--
					//	if(src.screen_moved)
						src.client.eye=locate(src.x+rand(-1,1),src.y+rand(-1,1),src.z)
						sleep(2)
					//	if(src){src.client.eye=src;src.screen_moved--}
						continue
					src.client.eye=src


		CS()
			if(!CheckState(src, new/state/cant_attack) && src.CS)
				src.CSstop()
				return
			if(!CheckState(src, new/state/cant_move))
				if(!src.CS)
					DealDamage(health/2,src,"black")
					src.CS=1
					var/obj/O = new/obj
					O.layer=MOB_LAYER+1
					O.icon = 'CS Aura.dmi'
					O.loc=loc
					O.pixel_x=-16
					O.linkfollow(src)
					var/obj/O2 = new/obj
					O2.icon = 'Dust.dmi'
					O2.pixel_x=-34
					O2.layer=MOB_LAYER+1
					O2.loc=loc
					O2.icon_state="smokemax"
					spawn(5)if(O2)del(O2)
					spawn(200)
						if(O)del(O)
						if(src)src.CS()

		PunchFlick(var/PTimes,var/obj/Jutsu)
			if(src.client)
				while(src)
					sleep(3.5-((src.agility/150)*3))
					if(PTimes)
						var/obj/A = new/obj/MiscEffects/Morning_Peacock(src.loc)
						src.DealDamage((src.maxhealth * 0.001) * src.Gates, src, "maroon")
						A.Owner=src
						A.damage=((Jutsu.damage+round(((src.taijutsu / 300)+(src.agility / 300))*2*Jutsu.damage))/20)+(2*src.Gates)
						A.dir=src.dir
						if(prob(50))
							if(src.dir==NORTH)
							//	var/list/dir_list=list(NORTH,EAST,WEST,NORTHEAST,NORTHWEST)
							//	step(A,pick(dir_list))
								var/list/dir_list=list(0,1,2)
								if(prob(50))A.x+=pick(dir_list)
								else A.x-=pick(dir_list)
							if(src.dir==SOUTH)
							//	var/list/dir_list=list(SOUTH,EAST,WEST,SOUTHEAST,SOUTHWEST)
							//	step(A,pick(dir_list))
								var/list/dir_list=list(0,1,2)
								if(prob(50))A.x+=pick(dir_list)
								else A.x-=pick(dir_list)
							if(src.dir==WEST)
							//	var/list/dir_list=list(SOUTH,NORTH,WEST,NORTHWEST,SOUTHWEST)
							//	step(A,pick(dir_list))
								var/list/dir_list=list(0,1,2)
								if(prob(50))A.y+=pick(dir_list)
								else A.y-=pick(dir_list)
							if(src.dir==EAST)
							//	var/list/dir_list=list(SOUTH,NORTH,EAST,NORTHEAST,SOUTHEAST)
							//	step(A,pick(dir_list))
								var/list/dir_list=list(0,1,2)
								if(prob(50))A.y+=pick(dir_list)
								else A.y-=pick(dir_list)
						step(A,src.dir)
						A.pixel_y=rand(1,5)
						A.pixel_x=rand(1,5)
						if(prob(35))step(A,src.dir)
						else
							if(prob(35))step(A,src.dir)
							else ..()
						flick("punchl",src)
						src.PlayAudio('Skill_BigRoketFire.wav', output = AUDIO_HEARERS)
						sleep(3.5-((src.agility/150)*3))
						var/obj/B = new/obj/MiscEffects/Morning_Peacock(src.loc)
						src.DealDamage((src.maxhealth * 0.001) * src.Gates, src, "maroon")
						B.Owner=src
						B.damage=((Jutsu.damage+round(((src.taijutsu / 300)+(src.agility / 300))*2*Jutsu.damage))/20)+(2*src.Gates)
						B.dir=src.dir
						if(prob(50))
							if(src.dir==NORTH)
								//var/list/dir_list=list(NORTH,EAST,WEST,NORTHEAST,NORTHWEST)
								//step(B,pick(dir_list))
								var/list/dir_list=list(0,1,2)
								if(prob(50))B.x+=pick(dir_list)
								else B.x-=pick(dir_list)
							if(src.dir==SOUTH)
								//var/list/dir_list=list(SOUTH,EAST,WEST,SOUTHEAST,SOUTHWEST)
								//step(B,pick(dir_list))
								var/list/dir_list=list(0,1,2)
								if(prob(50))B.x+=pick(dir_list)
								else B.x-=pick(dir_list)
							if(src.dir==WEST)
								//var/list/dir_list=list(SOUTH,NORTH,WEST,NORTHWEST,SOUTHWEST)
								//step(B,pick(dir_list))
								var/list/dir_list=list(0,1,2)
								if(prob(50))B.y+=pick(dir_list)
								else B.y-=pick(dir_list)
							if(src.dir==EAST)
								//var/list/dir_list=list(SOUTH,NORTH,EAST,NORTHEAST,SOUTHEAST)
								//step(B,pick(dir_list))
								var/list/dir_list=list(0,1,2)
								if(prob(50))B.y+=pick(dir_list)
								else B.y-=pick(dir_list)
						step(B,src.dir)
						B.pixel_y=rand(1,5)
						B.pixel_x=rand(1,5)
						if(prob(35))step(B,src.dir)
						else
							if(prob(35))step(B,src.dir)
							else ..()
						flick("punchr",src)
						src.PlayAudio('Skill_BigRoketFire.wav', output = AUDIO_HEARERS)
						PTimes--
						sleep(3.5-((src.agility/150)*3))
						continue
					else break
obj
	Drag
		icon='GRND.dmi'
		Dirt
			icon_state="dirtdrag"
			New()
				..()
				spawn(100)if(src)del(src)
	MiscEffects
		RisingTwinDragons
			icon='RisingTwinDragon.dmi'
			icon_state="dragon"
			density=0
			layer=MOB_LAYER+2
			pixel_x=-33
			pixel_y=-5
			New()
				..()
				flick("RisingTwinDragon",src)
				spawn(8)if(src)del(src)
		WaterRing
			icon='GRND.dmi'
			icon_state="watering"
			density=0
			pixel_x=16
			pixel_y=0
		SmokeBomb
			icon='SmokeBomb.dmi'
			icon_state="fuzz"
			density=0
			layer=MOB_LAYER+2
			pixel_x=-100
			pixel_y=-50
			New()
				flick("start",src)
				spawn(50)
					flick("disperse",src)
					spawn(5)if(src)del(src)
				..()
		Smoke
			icon='Smoke.dmi'
			icon_state="smoke"
			density=0
			layer=MOB_LAYER+2
			pixel_x=-10
			New()
				..()
				flick("smoke",src)
				spawn(12)if(src)del(src)
		Chakra
			icon='Chakra.dmi'
			icon_state="chakra"
			density=0
			layer=MOB_LAYER+2
			pixel_x=-33
			pixel_y=-5
			New()
				..()
				flick("chakra",src)
				spawn(8)if(src)del(src)
		Palms68
			icon='50Palms.dmi'
			icon_state="done"
			New()
				..()
				flick("start",src)
				spawn(200)
					flick("start",src)
					src.PlayAudio('charge.wav', output = AUDIO_HEARERS)
					spawn(100)
						flick("over",src)
						spawn(7)if(src)del(src)
		MeteorDust
			icon='MeteorPunch.dmi'
			icon_state="max"
			density=0
			layer=MOB_LAYER+1
			//pixel_x=-10
			New()
				if(src.level==1)src.icon_state="0"
				if(src.level==2)src.icon_state="1"
				if(src.level==3)src.icon_state="2"
				if(src.level==4)src.icon_state="3"
				flick("[src.icon_state]",src)
				spawn(5)if(src)del(src)
				..()
		RedHawk
			icon='RedHawk.dmi'
			icon_state="max"
			density=0
			layer=MOB_LAYER+1
			//pixel_x=-10
			New()
				if(src.level==1)src.icon_state="0"
				if(src.level==2)src.icon_state="1"
				if(src.level==3)src.icon_state="2"
				if(src.level==4)src.icon_state="3"
				flick("[src.icon_state]",src)
				spawn(5)if(src)del(src)
				..()
		Morning_Peacock
			icon='MorningPeacock.dmi'
			icon_state=""
			density=0
			layer=MOB_LAYER+1
			pixel_x=-28
			pixel_y=-10
			New()
				flick("[src.icon_state]",src)
				spawn(1)AI()
				spawn(7)
					src.loc=null
				..()
			proc/AI()
				var/mob/Owner=src.Owner
				while(src)
					sleep(1)
					if(!src.Hit)
						for(var/mob/c_target in range(src,1))
							if(c_target<>Owner)
								if(c_target.dead==0)
									if(c_target.fightlayer==src.fightlayer)
										src.Hit=1
										//if(prob(35))
										//	if(istype(c_target,/mob/npc))
										//		..()
										//	else
										//		c_target.Linkage=src
										//		c_target.overlays+=/obj/Projectiles/Effects/OnFire
										//		c_target.burn=3
										//		spawn(50)
										//			if(c_target)
										//				c_target.BurnEffect(Owner)
										var/undefendedhit=round(src.damage-(c_target.defence/10))
										if(undefendedhit<0)undefendedhit=1
										c_target.DealDamage(undefendedhit,src.Owner,"TaiOrange")
										c_target.Bind(c_target, 1)
										if(c_target.client)spawn(1)c_target.ScreenShake(1)
										if(c_target.health<=0)
											if(src)
												src.loc=null
										else
											spawn(11)
												if(src)
													src.loc=null
										break
/*						for(var/obj/Training/T in range(src,1))
							if(T.health>=1)
								src.Hit=1
								var/undefendedhit=round((src.damage+Owner.taijutsu+Owner.taijutsu)/3.5)
								T.DealDamage(undefendedhit,src,"TaiOrange")
								T.Break(Owner)
								break*/
						sleep(2)
						continue
					else break
		LeafWhirl
			icon='LeafWhirlwind.dmi'
			icon_state=""
			density=0
			layer=MOB_LAYER+1
			pixel_x=-40
			//pixel_y=-10
			New()
				flick("[src.icon_state]",src)
				spawn(10)if(src)del(src)
				..()
		LogT
			icon='MiscEffects.dmi'
			icon_state="logt"
			layer=MOB_LAYER+2
			pixel_y=32
		LogB
			icon='MiscEffects.dmi'
			icon_state="logb"
			density=1
			New()
				..()
				src.overlays+=/obj/MiscEffects/LogT/
				spawn(80)if(src)del(src)