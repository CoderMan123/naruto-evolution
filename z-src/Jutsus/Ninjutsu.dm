//projectile objs mobs and other ninjutsu stuff.

mob
	var
		PrevLoc

		Mcontrolled=0
		tmp
			nagashi=0
			CS=0
			C3bombz=0
			needkill=0
			immortal=0
			sbugged=0
			bugpass=0
			revived=0
			pois=0
			Rinnegan=0
			Intang=0

obj
	Iron_Fist_Left
		icon= 'Iron_Fist_Left.dmi'
		icon_state = "idle"
		pixel_x=-32
		layer = MOB_LAYER
		var/homing_switch = 1
		var/grab_time

		Bump(mob/m)
			if(m == src.owner)
				src.loc = m.loc
				return
			..()
			if(m)
				if(CheckState(src.owner, new/state/Iron_Fist_Punching_Left) || CheckState(src.owner, new/state/Iron_Fist_Spinning))	
					src.PlayAudio('KickHit.ogg', output = AUDIO_HEARERS)
				if(istype(m, /mob/) && m != src.owner)
					grab_time = src.level * 10
					var/bind_time = grab_time
					grab_time = bind_time - ((bind_time/100) * m.tenacity)
					if(CheckState(src.owner, new/state/Iron_Fist_Punching_Left))			
						m.DealDamage(damage, src.owner, "NinBlue")
						step_away(m, src)
						m.dir = get_dir(m, src)
						RemoveState(src.owner, new/state/Iron_Fist_Punching_Left, STATE_REMOVE_ALL)
					else if(CheckState(src.owner, new/state/Iron_Fist_Grabbing_Left))
						RemoveState(src.owner, new/state/Iron_Fist_Grabbing_Left, STATE_REMOVE_ALL)
						AddState(src.owner, new/state/Iron_Fist_Grabbed_Left, grab_time)
						flick("trans", src)
						sleep(1)
						src.loc = m.loc
						spawn(1)
							var/obj/grab_overlay = new(m.loc)
							grab_overlay.icon = 'Iron_Fist_Left.dmi'
							grab_overlay.icon_state = "grabbed2"
							grab_overlay.pixel_x=-32
							grab_overlay.layer = MOB_LAYER+1
							spawn(grab_time - 2) del(grab_overlay)
						src.icon_state = "grabbed1"
						src.layer = MOB_LAYER - 1
						src.owner.Bind(m, bind_time - 1)
						world << bind_time //debug
						world << grab_time //debug

					else if(CheckState(src.owner, new/state/Iron_Fist_Spinning))			
						if(m)
							src.loc = m.loc
						
						
			

		New()
			..()
			spawn()
				while(src)
					sleep(0.5)
					if(src)
						if(!owner || !CheckState(src.owner, new/state/Iron_Fists) || src.owner.chakra < 20)
							RemoveState(src.owner, new/state/Iron_Fists, STATE_REMOVE_ALL)
							src.owner.left_iron_fist = null
							src.owner.right_iron_fist = null
							del(src)

						else if(CheckState(src.owner, new/state/Iron_Fist_Spinning))
							src.density = 1
							for(var/mob/m in orange(1, src))
								if(m != src.owner)
									src.PlayAudio('KickHit.ogg', output = AUDIO_HEARERS)
									m.DealDamage(damage, src.owner, "NinBlue")
									step_away(m, src.owner)
									m.dir = get_dir(m, src.owner)
							src.icon_state = "punching"
							if(get_dist(src.owner.loc, src.loc) > 3)
								if(prob(50))step_towards(src, src.owner)
							if(get_dist(src.owner.loc, src.loc) < 2) step_away(src, src.owner)
							switch(get_dir(src.owner.loc, src.loc))
								if(NORTH)
									step(src, EAST)
								if(NORTHEAST)
									step(src, SOUTHEAST)
								if(EAST)
									step(src, SOUTH)
								if(SOUTHEAST)
									step(src, SOUTHWEST)
								if(SOUTH)
									step(src, WEST)
								if(SOUTHWEST)
									step(src, NORTHWEST)
								if(WEST)
									step(src, NORTH)
								if(NORTHWEST)
									step(src, NORTHEAST)

						else if(CheckState(src.owner, new/state/Iron_Fist_Punching_Left))
							if(src.icon_state == "idle")
								src.icon_state = "punching"
							src.density = 1
							var/mob/c_target=src.owner.Target_Get(TARGET_MOB)
							if(c_target)
								switch(homing_switch)
									if(1)
										homing_switch = 2
										step_towards(src, c_target)
									if(2)
										homing_switch = 1
										step_towards(src, get_step(src, src.dir))

							else step_towards(src, get_step(src, src.dir))

						else if(CheckState(src.owner, new/state/Iron_Fist_Grabbing_Left))
							var/mob/c_target=src.owner.Target_Get(TARGET_MOB)
							src.density = 1
							if(c_target)
								switch(homing_switch)
									if(1)
										homing_switch = 2
										step_towards(src, c_target)
									if(2)
										homing_switch = 1
										step_towards(src, get_step(src, src.dir))		
								src.dir = get_dir(src.loc, c_target.loc)

							else step_towards(src, get_step(src, src.dir))
							sleep(0.5)
					
						else if(src.owner.left_iron_fist_anchor && !CheckState(src.owner, new/state/Iron_Fist_Grabbed_Left))
							if(src.z != src.owner.z) src.loc = src.owner.loc
							src.layer = MOB_LAYER
							src.density = 0
							step_towards(src, src.owner.left_iron_fist_anchor)
							src.dir = src.owner.dir
							src.icon_state = "idle"

	Iron_Fist_Right
		icon= 'Iron_Fist_Right.dmi'
		icon_state = "idle"
		pixel_x=-32
		layer = MOB_LAYER
		var/homing_switch = 1
		var/grab_time

		Bump(mob/m)
			if(m == src.owner)
				src.loc = m.loc
				return
			..()
			grab_time = src.level * 10
			if(m)
				if(CheckState(src.owner, new/state/Iron_Fist_Punching_Right) || CheckState(src.owner, new/state/Iron_Fist_Spinning))	
					src.PlayAudio('KickHit.ogg', output = AUDIO_HEARERS)
				if(istype(m, /mob/) && m != src.owner)
					grab_time = src.level * 10
					var/bind_time = grab_time
					grab_time = (grab_time/100) * m.tenacity
					if(CheckState(src.owner, new/state/Iron_Fist_Punching_Right))					
						m.DealDamage(damage, src.owner, "NinBlue")
						step_away(m, src)
						m.dir = get_dir(m, src)
						RemoveState(src.owner, new/state/Iron_Fist_Punching_Left, STATE_REMOVE_ALL)

					else if(CheckState(src.owner, new/state/Iron_Fist_Grabbing_Right))
						RemoveState(src.owner, new/state/Iron_Fist_Grabbing_Right, STATE_REMOVE_ALL)
						AddState(src.owner, new/state/Iron_Fist_Grabbed_Right, grab_time)
						flick("trans", src)
						sleep(1)
						src.loc = m.loc
						spawn(1)
							var/obj/grab_overlay = new(m.loc)
							grab_overlay.icon = 'Iron_Fist_Right.dmi'
							grab_overlay.icon_state = "grabbed2"
							grab_overlay.pixel_x=-32
							grab_overlay.layer = MOB_LAYER+1
							spawn(grab_time - 2) del(grab_overlay)
						src.icon_state = "grabbed1"
						src.layer = MOB_LAYER - 1
						src.owner.Bind(m, bind_time - 1)
					else if(CheckState(src.owner, new/state/Iron_Fist_Spinning))			
						if(m)
							src.loc = m.loc
						

						
						
			

		New()
			..()
			spawn()
				while(src)
					sleep(0.5)
					if(src)
						if(!owner || !CheckState(src.owner, new/state/Iron_Fists) || src.owner.chakra < 20)
							RemoveState(src.owner, new/state/Iron_Fists, STATE_REMOVE_ALL)
							src.owner.left_iron_fist = null
							src.owner.right_iron_fist = null
							del(src)

						else if(CheckState(src.owner, new/state/Iron_Fist_Spinning))
							src.density = 1
							src.icon_state = "punching"
							for(var/mob/m in orange(1, src))
								if(m != src.owner)
									m.DealDamage(damage, src.owner, "NinBlue")
									step_away(m, src.owner)
									m.dir = get_dir(m, src.owner)
							if(get_dist(src.owner.loc, src.loc) > 2)
								if(prob(50))step_towards(src, src.owner)
							if(get_dist(src.owner.loc, src.loc) < 2) step_away(src, src.owner)
							switch(get_dir(src.owner.loc, src.loc))
								if(NORTH)
									step(src, EAST)
								if(NORTHEAST)
									step(src, SOUTHEAST)
								if(EAST)
									step(src, SOUTH)
								if(SOUTHEAST)
									step(src, SOUTHWEST)
								if(SOUTH)
									step(src, WEST)
								if(SOUTHWEST)
									step(src, NORTHWEST)
								if(WEST)
									step(src, NORTH)
								if(NORTHWEST)
									step(src, NORTHEAST)

						else if(CheckState(src.owner, new/state/Iron_Fist_Punching_Right))
							if(src.icon_state == "idle")
								src.icon_state = "punching"
							src.density = 1
							var/mob/c_target=src.owner.Target_Get(TARGET_MOB)
							if(c_target)
								switch(homing_switch)
									if(1)
										homing_switch = 2
										step_towards(src, c_target)
									if(2)
										homing_switch = 1
										step_towards(src, get_step(src, src.dir))

							else step_towards(src, get_step(src, src.dir))

						else if(CheckState(src.owner, new/state/Iron_Fist_Grabbing_Right))
							var/mob/c_target=src.owner.Target_Get(TARGET_MOB)
							src.density = 1
							if(c_target)
								switch(homing_switch)
									if(1)
										homing_switch = 2
										step_towards(src, c_target)
									if(2)
										homing_switch = 1
										step_towards(src, get_step(src, src.dir))		
								src.dir = get_dir(src.loc, c_target.loc)

							else step_towards(src, get_step(src, src.dir))
							sleep(0.5)
					
						else if(src.owner.right_iron_fist_anchor && !CheckState(src.owner, new/state/Iron_Fist_Grabbed_Right))
							if(src.z != src.owner.z) src.loc = src.owner.loc
							src.layer = MOB_LAYER
							src.density = 0
							step_towards(src, src.owner.right_iron_fist_anchor)
							src.dir = src.owner.dir
							src.icon_state = "idle"


	PoisonMist
		icon = 'Poison Gas Cloud.dmi'
		pixel_x=-32
		pixel_y=-32
		var/candoit=0
		var/mob/Ownzorz
		New(mob/M)
			loc = M.loc
			dir = M.dir
			step(src,src.dir)
			step(src,src.dir)
			candoit=1
			walk(src,src.dir,2)
			Ownzorz=M
			spawn(5)if(src)del(src)
		Del()
			flick("delete",src)
			spawn(4)
				..()
		Move()
			..()
			if(candoit)
				for(var/mob/M in orange(2,src))
					if(Ownzorz && M != src.Owner)
						if(M) M.DealDamage(Ownzorz.ninjutsu_total/2,src.Owner,"NinBlue")
						if(!CheckState(M, new/state/poisoned))
							AddState(M, new/state/poisoned, 100, src.Owner)
						else
							RemoveState(M, new/state/poisoned, STATE_REMOVE_ALL)
							AddState(M, new/state/poisoned, 100, src.Owner)
	ESDS
		icon = 'earth style dark swamp.dmi'
		icon_state = "center"
		New(turf/T)
			..()
			overlays+=image('earth style dark swamp.dmi',icon_state = "top",pixel_y=32)
			overlays+=image('earth style dark swamp.dmi',icon_state = "bottom",pixel_y=-32)
			overlays+=image('earth style dark swamp.dmi',icon_state = "left",pixel_x=-32)
			overlays+=image('earth style dark swamp.dmi',icon_state = "right",pixel_x=32)
			if(src)
				src.invisibility=0
				for(var/mob/M in src.loc)
					AddState(M, new/state/cant_move, 10)
				spawn(rand(10,20))if(src)del(src)
	C3bomb
		layer = MOB_LAYER
		New(mob/M)
			..()
			if(!M)
				del(src)
			src.loc = M.loc
			step(src, M.dir)
			src.dir = SOUTH
			pixel_x=-16
			src.icon = 'C3_small.dmi'
			spawn(2)
				if(src)
					pixel_x=-136
					src.icon = 'C3.dmi'
					src.icon_state = "arms out"
					flick("create",src)
			spawn(600)
				if(src)
					M.C3bombz = 0
					del(src)
	proc/Boomz(mob/M)
		layer = MOB_LAYER+10
		src.icon = 'Epic Explosion.dmi'
		pixel_x=-175
		src.PlayAudio('Exp_Dirt_01.wav', output = AUDIO_HEARERS)
		for(var/mob/M2 in orange(5,src))
		//	if(M2 == M)
		//		continue
			M2.DealDamage(src.damage,src.Owner,"NinBlue")//src or src.owner?

		spawn(10)
			if(src)
				del(src)
	SmokeBOOM
		pixel_x=-134
		pixel_y=-16
		New(mob/M)
			loc = M.loc
			icon = 'Dusty Explosion.dmi'
			flick("matt lauer can suck it",src)
			spawn(54)if(src)del(src)
	New()
		..()
		spawn(600)if(name=="Wave")if(src)del(src)
atom/movable/var/byakuview=0
mob
	byakuview=1
mob
	var
		tmp
			Susanoo=0
			bonesword=0
			jutsucopy=0
			LinkFollowers=list()
			Sharingan=0
			puppets[2]
			pdash=0
			pshoot=0
			pgrab=0

turf/var/tmp/iswater=0
area/var/tmp/iswater=0

obj/var/IsJutsuEffect
obj/proc/lf2(mob/M)
	if(M)spawn(1) src.lf2(M)
	else if(src)del(src)
mob/verb
	puppetgrab1()
		set hidden=1
		var/mob/M  = src.puppets[1]
		if(M && src.pgrab)
			for(var/mob/K in get_step(M,M.dir))
				if(K <> src)
					M.loc = K.loc
					M.dir=SOUTH
					if(!M.henged) M.icon = 'Karasu.dmi'
					if(!M.henged) M.overlays=null
					if(!M.henged) M.icon_state = "Grab bottom"
					if(M.henged) M.icon_state = "defend"
					M.layer = MOB_LAYER-1
					var/obj/O
					if(!M.henged)
						O = new/obj
						O.icon_state = "Grab top"
						O.IsJutsuEffect=src
						O.layer = MOB_LAYER+1
					src.pgrab=0
					Bind(K, 10+round(src.ninjutsu_total/3))
					var/counter=10+round(src.ninjutsu_total/3)
					while(counter && M && src && M.loc == K.loc)
						counter-=1
						sleep(1)
					if(!M.henged)if(O)del(O)
					M.layer = MOB_LAYER
					M.icon_state = ""

	puppetgrab2()
		set hidden=1
		var/mob/M  = src.puppets[2]
		if(M && src.pgrab)
			for(var/mob/K in get_step(M,M.dir))
				if(K <> src)
					M.loc = K.loc
					M.dir=SOUTH
					if(!M.henged) M.icon = 'Karasu.dmi'
					if(!M.henged) M.overlays=null
					if(!M.henged) M.icon_state = "Grab bottom"
					if(M.henged) M.icon_state = "defend"
					M.layer = MOB_LAYER-1
					var/obj/O
					if(!M.henged)
						O = new/obj
						O.IsJutsuEffect=src
						O.icon_state = "Grab top"
						O.layer = MOB_LAYER+1
					src.pgrab=0
					Bind(K, 10+round(src.ninjutsu_total/3))
					var/counter=10+round(src.ninjutsu_total/3)
					while(counter && M && src && M.loc == K.loc)
						counter-=1
						sleep(1)
					if(!M.henged)if(O)del(O)
					M.layer = MOB_LAYER
					M.icon_state = ""

	puppetshoot1()
		set hidden=1
		var/mob/M  = src.puppets[1]
		if(M && src.pshoot)
			src.pshoot=0
			if(!M.henged) M.icon = 'Karasu.dmi'
			if(!M.henged) M.overlays=null
			if(!M.henged) M.icon_state = "arm shooters"
			if(M.henged) flick("punchr",M)
			var/obj/O = new/obj/Projectiles/Effects/Puppetknife
			O.IsJutsuEffect=src
			O.loc = M.loc
			O.dir = M.dir
			O.Owner = src
			var/mob/c_target=src.Target_Get(TARGET_MOB)
			if(c_target)
				walk_towards(O,c_target)
				spawn(5)if(src)
					walk_towards(O,0)
					walk(O,O.dir)
			else walk(O,M.dir)
			if(!M.henged) M.icon_state = ""
	puppetshoot2()
		set hidden=1
		var/mob/M  = src.puppets[2]
		if(M && src.pshoot)
			src.pshoot=0
			if(!M.henged) M.icon = 'Karasu.dmi'
			if(!M.henged) M.overlays=null
			if(!M.henged) M.icon_state = "arm shooters"
			if(M.henged) flick("punchr",M)
			var/obj/O = new/obj/Projectiles/Effects/Puppetknife
			O.IsJutsuEffect=src
			O.loc = M.loc
			O.dir = M.dir
			O.Owner = src
			var/mob/c_target=src.Target_Get(TARGET_MOB)
			if(c_target)
				walk_towards(O,c_target)
				spawn(5)if(src)
					walk_towards(O,0)
					walk(O,O.dir)
			else walk(O,M.dir)
			M.icon_state = ""

	puppetdash1()
		set hidden=1
		var/mob/M  = src.puppets[1]
		if(M && src.pdash)
			if(!M.henged) M.icon_state = "dash"
			for(var/i=0,i<3+1,i++)
				step(M,M.dir)
				sleep(1)
			M.icon_state = ""

	puppetdash2()
		set hidden=1
		var/mob/M  = src.puppets[2]
		if(M && src.pdash)
			if(!M.henged) M.icon_state = "dash"
			for(var/i=0,i<3+1,i++)
				step(M,M.dir)
				sleep(1)
			M.icon_state = ""
	puppet1north()
		set hidden=1
		var/mob/M  = src.puppets[1]
		if(M)step(M,NORTH)
	puppet2north()
		set hidden=1
		var/mob/M  = src.puppets[2]
		if(M)step(M,NORTH)
	puppet1south()
		set hidden=1
		var/mob/M  = src.puppets[1]
		if(M)step(M,SOUTH)
	puppet2south()
		set hidden=1
		var/mob/M  = src.puppets[2]
		if(M)step(M,SOUTH)
	puppet1east()
		set hidden=1
		var/mob/M  = src.puppets[1]
		if(M)step(M,EAST)
	puppet2east()
		set hidden=1
		var/mob/M  = src.puppets[2]
		if(M)step(M,EAST)
	puppet1west()
		set hidden=1
		var/mob/M  = src.puppets[1]
		if(M)step(M,WEST)
	puppet2west()
		set hidden=1
		var/mob/M  = src.puppets[2]
		if(M)step(M,WEST)
mob/var/henged
turf
	Click()
		..()
		if(usr.byakugan && src.density==0)
			if(usr.client.eye<>usr)
				usr.client.eye=usr
				usr.client:perspective = EDGE_PERSPECTIVE
				return
			usr.client.eye=src
			usr.client:perspective = EYE_PERSPECTIVE
mob/Karasu
	icon = 'Karasu.dmi'
	icon_state = ""
	health=250
	pixel_x=-16
	var/OriginalIcon='Karasu.dmi'
	var/OriginalIconState=""
	byakuview=0
	Move()
		..()
		if(!henged)
			icon=OriginalIcon
			icon_state=OriginalIconState
	Bump(mob/c_target)
		if(!ismob(c_target)) return
		if(!CheckState(src, new/state/cant_attack) && !CheckState(src, new/state/swimming))
			var/timer = src.attkspeed + 3
			AddState(src, new/state/cant_attack, timer)
			src.PlayAudio('Swing5.ogg', output = AUDIO_HEARERS)
			spawn(2)
				src.dir = get_dir(src,c_target)
				if(c_target.dead==0&&!istype(c_target,/mob/npc/)&&c_target!=src.Owner || c_target.dead==0&&istype(c_target,/mob/npc/combat)&&c_target!=src.Owner )
					if(!src.henged) flick("arm shooters",src)
					if(src.henged) flick("punchr",src)
					if(c_target.client)spawn()c_target.ScreenShake(1)
					var/undefendedhit=(180-round(1*((300-(src.ninjutsu_total+src.precision_total))/3)))+rand(0,10)
					if(undefendedhit<0)
						undefendedhit=1
					c_target.DealDamage(undefendedhit,src.Owner,"TaiOrange")

	Click()
		if(usr.puppets[1]==src||usr.puppets[2]==src)
			if(usr.client.eye==src)
				usr.client.eye=usr
				usr.client:perspective = EDGE_PERSPECTIVE
				return
			usr.client.eye=src
			usr.client:perspective = EYE_PERSPECTIVE
		..()
	Death(mob/killer)
		if(health<=0)
			for(var/mob/M in world)
				if(!M.client) continue
				if(M.client.eye==src) M.client.eye=M
			if(src)del(src)
	Del()
		for(var/mob/M in world)
			if(!M.client) continue
			if(M.client.eye==src) M.client.eye=M
		..()
mob/Untargettable
	Susanoo
		icon = 'Susanoo Official.dmi'
		icon_state = "Idle"
		pixel_y=-80
		pixel_x=-150
		var/mob/Ownzeez
		New(mob/M)
			..()
			src.Ownzeez=M
			src.loc = M.loc
			step(src,NORTH)
			src.dir=SOUTH
			src.health = 2500
			flick("create",src)
			spawn(1)
				pixel_y=-80
				pixel_x=-145
				src.bec2()
		/*	if(!Ownzeez.Susanoo)
				spawn(2)if(src)del(src) */
			spawn(100)spawn(3)if(src)del(src)//If you change this change it in uchihajutsus.dm line 117

		proc/tailswing()
			src.icon_state = "Idle"
			flick("Attack",src)
			src.PlayAudio('wirlwind.wav', output = AUDIO_HEARERS)
			for(var/mob/M in orange(5))
				if(M.dead || M.key==src.name || istype(M,/mob/npc) && !istype(M,/mob/npc/combat)) continue
				src.PlayAudio('Skill_BigRoketFire.wav', output = AUDIO_HEARERS)
				M.DealDamage(src.taijutsu_total,src.Ownzeez,"TaiOrange")
				M.Bleed(M)
				if(M.henge==4||M.henge==5)M.HengeUndo()
				M.icon_state="push"
				walk(M,pick(EAST,SOUTH,WEST,SOUTHEAST,SOUTHWEST))
				if(M.client)spawn() M.ScreenShake(8)
				walk(M,0)
				if(!CheckState(M, new/state/swimming))M.icon_state=""

		proc/bec2()
			while(src)
				sleep(25)
				if(src.Ownzeez.dead == 1)
					del(src)
				src.icon_state = "Idle"
				var/Mobs
				for(var/mob/M in oview(5))if(M.key!=src.name||istype(M,/mob/npc) && !istype(M,/mob/npc/combat))Mobs=1
				if(Mobs) src.tailswing()
	C2
		icon = 'C2.dmi'
		icon_state = "Idle"
		pixel_y=-425
		health=20
		var/mob/Ownzeez
		New(mob/M)
			..()
			src.Ownzeez=M
			src.loc = M.loc
			step(src,NORTH)
			src.dir=SOUTH
			pixel_y+=188
			pixel_x-=188
			src.health = 750
			flick("create",src)
			for(var/i=1,i<10,i++)
				var/obj/O = new/obj
				O.IsJutsuEffect=src
				O.density=1
				O.x+=i
				O.lf2(src)
			spawn(3)if(src)src.bec2()
			spawn(600)if(src)
				flick("destroy",src)
				spawn(3)if(src)del(src)

		proc/tailswing()
			src.icon_state = "Idle"
			flick("tail swing",src)
			if(!Ownzeez) return
			for(var/mob/M in orange(4))
				if(M.dead || M.key==src.name) continue
				var/random=rand(1,4)
				if(random==1) src.PlayAudio('KickHit.ogg', output = AUDIO_HEARERS)
				if(random==2) src.PlayAudio('KickHit.ogg', output = AUDIO_HEARERS)
				if(random==3) src.PlayAudio('KickHit.ogg', output = AUDIO_HEARERS)
				if(random==4) src.PlayAudio('KickHit.ogg', output = AUDIO_HEARERS)
				M.DealDamage(jutsudamage+round((src.Ownzeez.ninjutsu_total / 200)*2*jutsudamage)*2,src.Ownzeez,"TaiOrange")
				if(loc.loc:Safe!=1) src.LevelStat("Ninjutsu",rand(10,15))
				if(M.henge==4||M.henge==5)M.HengeUndo()
				M.icon_state="push"
				walk(M,pick(EAST,SOUTH,WEST,SOUTHEAST,SOUTHWEST))
				if(M.client)spawn() M.ScreenShake(5)
				spawn(4)
					if(M)
						walk(M,0)
						if(!CheckState(M, new/state/swimming))M.icon_state=""

		proc/landminemake()
			var/obj/O = new/obj/Projectiles/Effects/ClayBird
			O.icon = 'C2_landmines.dmi'
			O.loc = src.loc
			O.Owner=src.Ownzeez
			O.pixel_x-=96+rand(-5,5)
			O.pixel_y-=48+rand(-5,5)
			O.name = src.name
			spawn(2)
				O.pixel_x+=20
				spawn(2)
					O.pixel_x+=20
					spawn(2)
						O.pixel_x=0
						O.pixel_y=0
						O.y-=1
						walk(O,pick(SOUTH,EAST,WEST,SOUTHEAST,SOUTHWEST))
						spawn(7)
							walk(O,0)
							spawn(3)if(O)del(O)
		proc/birdmake()
			var/obj/O = new/obj/Projectiles/Effects/ClayBird(src.loc)
			O.Owner=src.Ownzeez
			O.dir = pick(EAST,SOUTH,WEST,SOUTHEAST,SOUTHWEST)
			O.name = src.name
			O.Owner = src
			var/check=0
			for(var/mob/M in orange(10))
				if(M.key <> src.name)
					walk_towards(O,M.loc)
					check=1
			if(check==0) walk(O,O.dir)
			spawn(10)if(O)walk(O,O.dir)
		proc/createbirds()
			src.icon_state = "mouth open"
			for(var/i=1,i<5,i++)
				spawn(i)if(src)src.birdmake()
		proc/createlandmines()
			src.icon_state = "mouth open"
			for(var/i=1,i<10,i++)
				spawn(i)if(src)src.landminemake()
		proc/bec2()
			if(src)
				src.icon_state = "Idle"
				var/k = rand(1,5)
				if(k==1)src.createlandmines()
				if(k==2)src.createbirds()
				if(k==3)src.tailswing()
				if(k==4)src.tailswing()
				if(k==5)src.tailswing()
				spawn(20)if(src)src.bec2()
obj
	proc/linkfollow(mob/M)
		if(M && src && src.loc)
			M.LinkFollowers+=src
			src.loc = M.loc
			spawn(0.2) src.linkfollow(M)
		else if(src)del(src)
	var
		tmp
			cooled=0
			hitstate
			hitsound
	watercreate
		icon = 'GRND.dmi'
		icon_state = "water"
		New()
			spawn(4)
				var/turf/T = get_step(src,NORTH)
				var/check1=0
				var/check14=0
				var/check12=0
				var/check13=0
				for(var/obj/watercreate/O in T)check1=1
				var/turf/T2 = get_step(src,SOUTH)
				for(var/obj/watercreate/O2 in T2)check12=1
				var/turf/T3 = get_step(src,EAST)
				for(var/obj/watercreate/O3 in T3)check13=1
				var/turf/T4 = get_step(src,WEST)
				for(var/obj/watercreate/O4 in T4)check14=1
				if(check14==0)
					src.overlays+=image('GRND.dmi',icon_state = "GDEdgeR")
					src.overlays+=image('GRND.dmi',icon_state = "GDEdgeL",pixel_x=-32)
				if(check13==0)
					src.overlays+=image('GRND.dmi',icon_state = "GDEdgeL")
					src.overlays+=image('GRND.dmi',icon_state = "GDEdgeR",pixel_x=32)
				if(check12==0)
					src.overlays+=image('GRND.dmi',icon_state = "GDEdgeT")
					src.overlays+=image('GRND.dmi',icon_state = "GDEdgeB",pixel_y=-32)
				if(check1==0)
					src.overlays+=image('GRND.dmi',icon_state = "GDEdgeB")
					src.overlays+=image('GRND.dmi',icon_state = "GDEdgeT",pixel_y=32)
				var/turf/Td = src.loc
				if(Td) Td.iswater=1
				spawn(300)
					if(Td)Td.iswater=0
					if(src)del(src)
	Projectiles
		New()
			..()
			spawn(76)
				if(loc)
					del(src)
		icon='Jutsus.dmi'
		density=1
		Effects
			InkLions
				name="Ink Lions"
				icon='hm.dmi'
				icon_state="lion"
				density=1
				New()
					..()
					pixel_y=32
					layer = MOB_LAYER+1
					spawn(20)
						var/mob/Owner=src.Owner
						src.density=0
						Owner.PlayAudio('Exp_Dirt_01.wav', output = AUDIO_HEARERS)
						src.layer=MOB_LAYER+1
						walk(src,0)
						src.icon = 'SmallExplode.dmi'
						src.pixel_x=-16
						src.pixel_y=-16
						flick("blow",src)
						src.Hit=1
						for(var/mob/M in oview(2,src))
							if(M.dead||!M) continue
							M.DealDamage(src.damage,src.Owner,"NinBlue")
							if(Owner.loc.loc:Safe!=1) Owner.LevelStat("Ninjutsu",rand(4,6))
							if(M.henge==4||M.henge==5)M.HengeUndo()
						spawn(5)if(src)src.loc=locate(0,0,0)
						spawn(100)if(src)del(src)
				Bump(atom/O)
					if(!src.Hit)
						if(istype(O,/mob))
							var/mob/M=O
							var/mob/Owner=src.Owner
							if(M.dead || M.key == src.name) return
							if(M.fightlayer==src.fightlayer)
								src.density=0
								M.PlayAudio('Exp_Dirt_01.wav', output = AUDIO_HEARERS)
								src.layer=MOB_LAYER+1
								walk(src,0)
								src.loc=O.loc
								src.icon = 'SmallExplode.dmi'
								src.pixel_x=-16
								src.pixel_y=-16
								flick("blow",src)
								src.Hit=1
								M.DealDamage(src.damage,src.Owner,"NinBlue")
								if(Owner.loc.loc:Safe!=1) Owner.LevelStat("Ninjutsu",rand(3,5))
								if(M.henge==4||M.henge==5)M.HengeUndo()
						else src.invisibility=1
						spawn(5)if(src)src.loc=locate(0,0,0)
			FTGkunai
				name="FTGkunai"
				icon='YellowFlashKunai.dmi'
				icon_state="thrown"
				density=1
				var/in_flight = 1
				var/uptime = 80
				New()
					if(src.Owner)
						pixel_y+=32
						layer = MOB_LAYER+1
						spawn(uptime)
							if(src && src.in_flight)
								src.in_flight = 0
								src.density=0
								walk(src,0)
								src.icon_state="ground"
								src.pixel_y=0
								spawn(uptime)
									if(src)
										del src

				Bump(atom/O)
					if(istype(O,/mob))
						var/mob/M=O
						if(M.dead) return
						if(M && M.fightlayer == src.fightlayer)
							M.PlayAudio('knife_hit1.wav', output = AUDIO_HEARERS)
							M.DealDamage(src.damage,src.Owner,"NinBlue")
							M.Bleed()
							if(M.henge==4||M.henge==5)M.HengeUndo()
							if(M != src.Owner) AddState(M, new/state/FTG_Kunai_Mark, uptime, Owner)
							if(src)
								del src
								world << 1
					else
						if(src && src.in_flight)
							src.in_flight = 0
							src.density=0
							walk(src,0)
							src.icon_state="ground"
							src.pixel_y=0
							spawn(uptime)
								if(src)
									del src

			RTD
				name="RTD"
				icon='Shuriken.dmi'
				icon_state="RTD"
				density=1
				var/has_damaged[0]
				New()
					..()
					pixel_y+=32
					layer = MOB_LAYER+1
					spawn(50)
						if(src)
							src.loc = null
							src.Owner = null
				Bump(atom/O)
					if(!src.Hit)
						if(istype(O,/mob))
							var/mob/M=O
							if(M)
								if(M != src.Owner)
									if(M.dead || M.key == src.name) return
									if(M.fightlayer==src.fightlayer)
										src.loc = M.loc
										if(M in has_damaged) return
										M.PlayAudio('knife_hit1.wav', output = AUDIO_HEARERS)
										src.layer=MOB_LAYER+1
										M.DealDamage(src.damage,src.Owner,"NinBlue")
										M.Bleed()
										has_damaged += M
										if(M.henge==4||M.henge==5)M.HengeUndo()
								else if(src)
									M.DealDamage(src.damage,src.Owner,"NinBlue")
									M.Bleed()
									src.loc = null
									src.Owner = null
						else if(src)
							src.loc = null
							src.Owner = null
			DWS
				name="DWS"
				icon = 'risingdragonprojectiles.dmi'
				icon_state="3"
				density=1
				New()
					..()
					pixel_y+=32
					layer = MOB_LAYER+1
					spawn(50)if(src)del(src)

//				var/traveltime=src.level*(30/4)
				var/hits=0
				var/mob/target
				var/has_damaged[0]
				Bump(atom/O)
					if(!src.Hit)
						if(istype(O,/mob))
							var/mob/M=O

							if(M)
								if(M <> src.Owner)
									if(M.dead || M.key == src.name) return
									if(M.fightlayer==src.fightlayer)
										M.PlayAudio('knife_hit1.wav', output = AUDIO_HEARERS)
										src.layer=MOB_LAYER+1
										src.loc = M.loc
										if(has_damaged[M] < 2)
											M.DealDamage(src.damage,src.Owner,"NinBlue")
											M.Bleed()
											if(!has_damaged[M]) has_damaged[M] = 1
											else has_damaged[M] ++
										if(M.henge==4||M.henge==5)M.HengeUndo()
										if(src.target==M) hits++
								else if(src) del(src)
						else
							hits++
							hits++


			BubbleBarrage
				name="Bubble Barrage"
				icon='Bubble Barrage.dmi'
				icon_state="bubble"
				density=1
				New()
					..()
					pixel_y=32
					layer = MOB_LAYER+1
					spawn(20)
						var/mob/Owner=src.Owner
						src.density=0
						src.PlayAudio('Exp_Dirt_01.wav', output = AUDIO_HEARERS)
						src.layer=MOB_LAYER+1
						walk(src,0)
						src.icon = 'SmallExplode.dmi'
						src.pixel_x=-16
						src.pixel_y=-16
						flick("blow",src)
						src.Hit=1
						for(var/mob/M in orange(3,src))
							if(M.dead || M==Owner) continue
							M.DealDamage(src.damage,src.Owner,"NinBlue")
							if(M.henge==4||M.henge==5)M.HengeUndo()
						spawn(5)if(src)src.loc=locate(0,0,0)
						spawn(100)if(src)del(src)
				Bump(atom/O)
					if(!src.Hit)
						if(istype(O,/mob))
							var/mob/M=O
							if(M.dead || M.key == src.name) return
							if(M.fightlayer==src.fightlayer)
								src.density=0
								M.PlayAudio('Exp_Dirt_01.wav', output = AUDIO_HEARERS)
								src.layer=MOB_LAYER+1
								walk(src,0)
								src.loc=O.loc
								src.icon = 'SmallExplode.dmi'
								src.pixel_x=-16
								src.pixel_y=-16
								flick("blow",src)
								src.Hit=1
								for(M in orange(3,src))
									M.DealDamage(src.damage,src.Owner,"NinBlue")
									if(M.henge==4||M.henge==5)M.HengeUndo()
						else src.invisibility=1
						spawn(5)if(src)src.loc=locate(0,0,0)
			Puppetknife
				name="Knife"
				icon='Puppet Projectiles.dmi'
				icon_state="Arm knife"
				density=1
				New()
					..()
					pixel_y=32
					layer = MOB_LAYER+1
					src.damage = 20
					spawn(50)if(src)del(src)
				Bump(atom/O)
					src.damage = 20
					if(!src.Hit)
						if(istype(O,/mob))
							var/mob/M=O
							var/mob/Owner=src.Owner
							if(M.dead || M.key == src.name) return
							if(M.fightlayer==src.fightlayer)
								src.density=0
								M.PlayAudio('knife_hit1.wav', output = AUDIO_HEARERS)
								src.layer=MOB_LAYER+1
								walk(src,0)
								src.loc=O.loc
								src.icon_state = "NUUUUU"
								src.Hit=1
								M.DealDamage((jutsudamage+round(((Owner.ninjutsu_total / 450)+(Owner.precision_total / 450))*2*jutsudamage))*2,src.Owner,"NinBlue")
								spawn() M.Bleed()
								if(M.henge==4||M.henge==5)M.HengeUndo()
						else src.invisibility=1
						spawn(5) src.loc=locate(0,0,0)
			Balvan
				name="Balvan"
				icon='Senjuu.dmi'
				icon_state="woodbalvan"
				density=1
				New()
					..()
					layer = MOB_LAYER+1
					spawn(50)if(src)del(src)
				Bump(atom/O)
					if(!src.Hit)
						if(istype(O,/mob))
							var/mob/M=O
							var/mob/Owner=src.Owner
							if(M.dead || M.key == src.name) return
							if(M)
								src.density=0
								M.PlayAudio('knife_hit1.wav', output = AUDIO_HEARERS)
								src.layer=MOB_LAYER+1
								walk(src,0)
								src.loc=O.loc
								src.Hit=1
								M.DealDamage(src.damage,Owner,"NinBlue")
								spawn() M.Bleed()
								if(M.henge==4||M.henge==5)M.HengeUndo()
						else src.invisibility=1
						spawn(5) src.loc=locate(0,0,0)
			ChakraManiper
				name="Kunai"
				icon='Multiple Chakra Kunai.dmi'
				icon_state="kunai"
				density=1
				New()
					..()
					pixel_y+=32
					layer = MOB_LAYER+1
					src.damage = 1
				//	var/obj/O = new/obj
				//	O.loc = src.loc
					spawn(50)if(src)del(src)
				Bump(atom/O)
					if(!src.Hit)
						if(istype(O,/mob))
							var/mob/M=O
							if(M)
								if(M <> src.Owner)
									var/mob/Owner=src.Owner
									if(M.dead || M.key == src.name) return
									if(M.fightlayer==src.fightlayer)
										M.PlayAudio('knife_hit1.wav', output = AUDIO_HEARERS)
										src.layer=MOB_LAYER+1
										if(M)
											src.loc = M.loc
											M.DealDamage(src.damage,src.Owner,"NinBlue")
											spawn()if(M)M.Bleed()
											if(Owner.loc.loc:Safe!=1) Owner.LevelStat("Ninjutsu",rand(3,5))
											if(M.henge==4||M.henge==5)M.HengeUndo()
			Windmill
				name="windmill"
				icon='Shuriken.dmi'
				icon_state="windmill"
				density=1
				New()
					..()
					pixel_y+=32
					layer = MOB_LAYER+1
					src.damage = 1
				//	var/obj/O = new/obj
				//	O.loc = src.loc
					spawn(50)
						if(src)
							src.loc = null
							src.Owner = null
				Bump(atom/O)
					if(!src.Hit)
						if(istype(O,/mob))
							var/mob/M=O
							if(M)
								if(M != src.Owner)
									var/mob/Owner=src.Owner
									if(M.dead || M.key == src.name) return
									if(M.fightlayer==src.fightlayer)
										M.PlayAudio('knife_hit1.wav', output = AUDIO_HEARERS)
										src.layer=MOB_LAYER+1
										if(M)
											src.loc = M.loc
											M.DealDamage(src.damage,src.Owner,"NinBlue")
											spawn()if(M)M.Bleed()
											if(Owner.loc.loc:Safe!=1) Owner.LevelStat("Ninjutsu",rand(3,5))
											if(M.henge==4||M.henge==5)M.HengeUndo()
								else
									M.DealDamage(src.damage,src.Owner,"NinBlue")
									spawn()if(M)M.Bleed()
									src.loc = null
									src.Owner = null
			Shukakku_Spear
				name="Shukkaku Spear"
				icon='Shukakku Spear.dmi'
				icon_state=""
				density=1
				New()
					..()
					pixel_y=-69
					pixel_x=-69
					pixel_y+=32
					layer = MOB_LAYER+1
					src.damage = 20
					var/obj/O = new/obj
					O.loc = src.loc
					O.icon = 'Smoke.dmi'
					flick("smoke",O)
					spawn(7)if(O)del(O)
					spawn(50)if(src)del(src)
				Bump(atom/O)
					if(!src.Hit)
						if(istype(O,/mob))
							var/mob/M=O
							if(M)
								var/mob/Owner=src.Owner
								if(M.dead || M.key == src.name) return
								if(M.fightlayer==src.fightlayer)
									M.PlayAudio('knife_hit1.wav', output = AUDIO_HEARERS)
									src.layer=MOB_LAYER+1
									if(M)
										src.loc = M.loc
										M.DealDamage(src.damage,Owner,"NinBlue")
										spawn() if(M) M.Bleed()
										if(M.henge==4||M.henge==5)
											M.HengeUndo()
			Sand_Shuriken
				name="Sand Shuriken"
				icon='Sand Shuriken.dmi'
				icon_state=""
				density=1
				New()
					..()
					pixel_x=-16
					pixel_y+=32
					layer = MOB_LAYER+1
					src.damage = 1
				//	var/obj/O = new/obj
				//	O.loc = src.loc
					spawn(50)if(src)del(src)
				Bump(atom/O)
					if(!src.Hit)
						if(istype(O,/mob))
							var/mob/M=O
							if(M)
								var/mob/Owner=src.Owner
								if(M.dead || M.key == src.name) return
								if(M.fightlayer==src.fightlayer)
									M.PlayAudio('knife_hit1.wav', output = AUDIO_HEARERS)
									src.layer=MOB_LAYER+1
									if(M)
										src.loc = M.loc
										if(!Owner) return
										M.DealDamage(src.damage,src.Owner,"NinBlue")
										spawn() if(M) M.Bleed()
										if(M.henge==4||M.henge==5)M.HengeUndo()
			Maniper
				name="Kunai"
				icon='Shuriken.dmi'
				icon_state="kunai"
				density=1
				New()
					..()
					pixel_y+=32
					layer = MOB_LAYER+1
					src.damage = 1
				//	var/obj/O = new/obj
				//	O.loc = src.loc
					spawn(50)if(src)del(src)
				Bump(atom/O)
					if(!src.Hit)
						if(istype(O,/mob))
							var/mob/M=O
							if(M)
								if(M <> src.Owner)
									var/mob/Owner=src.Owner
									if(M.dead || M.key == src.name) return
									if(M.fightlayer==src.fightlayer)
										M.PlayAudio('knife_hit1.wav', output = AUDIO_HEARERS)
										src.layer=MOB_LAYER+1
										if(M)
											src.loc = M.loc
											M.DealDamage(src.damage,src.Owner,"NinBlue")
											spawn()if(M)M.Bleed()
											if(Owner.loc.loc:Safe!=1) Owner.LevelStat("Ninjutsu",rand(3,4))
											if(M.henge==4||M.henge==5)M.HengeUndo()
			SnakeC1
				name="C1 Snake"
				icon='C1Snake.dmi'
				icon_state=""
				density=1
				New()
					..()
					pixel_y=32
					layer = MOB_LAYER+1
					spawn(20)
						src.density=0
						src.PlayAudio('Exp_Dirt_01.wav', output = AUDIO_HEARERS)
						src.layer=MOB_LAYER+1
						walk(src,0)
						src.icon = 'SmallExplode.dmi'
						flick("blow",src)
						src.Hit=1
						for(var/mob/M in oview(2,src))
							if(M.dead||!M) continue
							M.DealDamage(src.damage,src.Owner,"NinBlue")
							if(M.henge==4||M.henge==5)M.HengeUndo()
						spawn(5)if(src)src.loc=locate(0,0,0)
						spawn(100)if(src)del(src)
				Bump(atom/O)
					if(!src.Hit)
						if(istype(O,/mob))
							var/mob/M=O
							if(M.dead || M.key == src.name) return
							if(M.fightlayer==src.fightlayer)
								src.density=0
								src.PlayAudio('Exp_Dirt_01.wav', output = AUDIO_HEARERS)
								src.layer=MOB_LAYER+1
								walk(src,0)
								src.loc=O.loc
								src.icon = 'SmallExplode.dmi'
								src.pixel_x=-16
								src.pixel_y=-16
								flick("blow",src)
								src.Hit=1
								M.DealDamage(src.damage,src.Owner,"NinBlue")
								if(M.henge==4||M.henge==5)M.HengeUndo()
						else src.invisibility=1
						spawn(5)if(src)src.loc=locate(0,0,0)
			CrystalShards
				name="Crystal Shards"
				icon='CrystalIcons.dmi'
				icon_state="shards"
				density=1
				pixel_x=-16
				New()
					..()
					layer = MOB_LAYER+1
					spawn(50)if(src)del(src)
				Bump(atom/O)
					if(!src.Hit)
						if(istype(O,/mob))
							var/mob/M=O
							if(M)
								if(M <> src.Owner)
									var/mob/Owner=src.Owner
									if(M.dead || M.key == src.name) return
									if(M.fightlayer==src.fightlayer)
										src.PlayAudio('knife_hit1.wav', output = AUDIO_HEARERS)
										src.layer=MOB_LAYER+1
										if(M)
											src.loc = M.loc
											M.DealDamage(src.damage,Owner,"NinBlue")
											spawn()if(M)M.Bleed()
											if(M.henge==4||M.henge==5)M.HengeUndo()
											walk(src,src.dir,1)
											spawn(1) src.density=1
											src.density=0
			CrystalNeedles
				name="Crystal Needles"
				icon='CrystalIcons.dmi'
				icon_state="needles"
				density=1
				pixel_x=-16
				New()
					..()
					layer = MOB_LAYER+1
					spawn(50)if(src)del(src)
				Bump(atom/O)
					if(!src.Hit)
						if(istype(O,/mob))
							var/mob/M=O
							if(M)
								if(M <> src.Owner)
									var/mob/Owner=src.Owner
									if(M.dead || M.key == src.name) return
									if(M.fightlayer==src.fightlayer)
										src.PlayAudio('knife_hit1.wav', output = AUDIO_HEARERS)
										src.layer=MOB_LAYER+1
										if(M)
											src.loc = M.loc
											M.DealDamage(src.damage,Owner,"NinBlue")
											spawn()if(M)M.Bleed()
											if(M.henge==4||M.henge==5)M.HengeUndo()
											walk(src,src.dir,1)
											spawn(1) src.density=1
											src.density=0
			lightningmask
				icon='KakuzuPuppets.dmi'
				icon_state="Lightning"
				density=1
			firemask
				icon='KakuzuPuppets.dmi'
				icon_state="Fire"
				density=1
			windmask
				icon='KakuzuPuppets.dmi'
				icon_state="Wind"
				density=1
			earthmask
				icon='KakuzuPuppets.dmi'
				icon_state="Earth"
				density=1
			mudwall
				icon='Mud Wall.dmi'
				layer=MOB_LAYER+1
				density=1
				pixel_x=-34
				pixel_y=-5
				New()
					spawn(15)
						src.icon_state="idle"
						spawn(85)
							del(src)
			shinratensei
				icon='Jutsus/Clan/ClanJutIcons/shinratensei.dmi'
				layer=MOB_LAYER+10
				density=1
				pixel_x=-310
				pixel_y=-242
				New()
					spawn(20)
						del(src)
					..()
			Maniper2
				name="Shuriken"
				icon='Shuriken.dmi'
				icon_state="shuri"
				density=1
				New()
					..()
					pixel_y+=32
					layer = MOB_LAYER+1
					src.damage = 1
				//	var/obj/O = new/obj
				//	O.loc = src.loc
					spawn(50)if(src)del(src)
				var/has_damaged[0]
				Bump(atom/O)
					if(!src.Hit)
						if(istype(O,/mob))
							var/mob/M=O
							if(M)
								if(M <> src.Owner)
									if(M.dead || M.key == src.name) return
									if(M.fightlayer==src.fightlayer)
										src.layer=MOB_LAYER+1
										if(M)
											src.loc = M.loc
											if(M in has_damaged) return
											src.PlayAudio('knife_hit1.wav', output = AUDIO_HEARERS)
											M.DealDamage(src.damage,src.Owner,"NinBlue")
											has_damaged += M
											M.Bleed()
											if(M.henge==4||M.henge==5)M.HengeUndo()
			Maniper3
				name="Needle "
				icon='Shuriken.dmi'
				icon_state="needle"
				density=1
				New()
					..()
					pixel_y+=32
					layer = MOB_LAYER+1
					src.damage = 1
				//	var/obj/O = new/obj
				//	O.loc = src.loc
					spawn(50)if(src)del(src)
				var/has_damaged[0]
				Bump(atom/O)
					if(!src.Hit)
						if(istype(O,/mob))
							var/mob/M=O
							if(M)
								if(M <> src.Owner)
									if(M.dead || M.key == src.name) return
									if(M.fightlayer==src.fightlayer)
										src.layer=MOB_LAYER+1
										if(M)
											src.loc = M.loc
											if(M in has_damaged)return
											src.PlayAudio('knife_hit1.wav', output = AUDIO_HEARERS)
											M.DealDamage(src.damage,src.Owner,"NinBlue")
											has_damaged += M
											M.Bleed()
											if(M.henge==4||M.henge==5)M.HengeUndo()
			Paper_Chakram
				name="Paper Chakram"
				icon='Paper Chakram.dmi'
				icon_state=""
				density=1
				New()
					..()
					layer = MOB_LAYER+1
					src.damage = 1
					var/obj/O = new/obj
					O.loc = src.loc
					O.icon = 'paperb.dmi'
					O.pixel_y=32
					O.pixel_x=-16
					step_rand(O)
					spawn(2)if(O)del(O)
					spawn(10)if(src)del(src)
				Bump(atom/O)
					if(!src.Hit)
						if(istype(O,/mob))
							var/mob/M=O
							var/mob/Owner=src.Owner
							if(M.dead || M.key == src.name) return
							if(M.fightlayer==src.fightlayer)
								src.PlayAudio('SharpHit_Short2.wav', output = AUDIO_HEARERS)
								src.layer=MOB_LAYER+1
								src.loc = M.loc
								if(Owner.inAngel==1)
									M.DealDamage(src.damage,src.Owner,"NinBlue")
								else
									M.DealDamage(src.damage,src.Owner,"NinBlue")
								if(M.henge==4||M.henge==5)M.HengeUndo()
			Bug_Swarm
				name="Bug Swarm"
				icon='Bug Swarm.dmi'
				icon_state=""
				density=1
				New()
					..()
					pixel_x=-16
					pixel_y=8
					layer = MOB_LAYER+1
					src.damage = 1
					spawn(10)if(src)del(src)
				Bump(atom/O)
					if(!src.Hit)
						if(istype(O,/mob))
							var/mob/M=O
							if(M.dead || M.key == src.name) return
							if(M.fightlayer==src.fightlayer)
								M.PlayAudio('LPunchHIt.ogg', output = AUDIO_HEARERS)
								src.layer=MOB_LAYER+1
								src.loc = M.loc
								M.DealDamage(src.damage,src.Owner,"NinBlue")
								step(M,src.dir)
								M.dir = get_dir(M,src)
								if(M.henge==4||M.henge==5)M.HengeUndo()
			HunterScarab
				name="Hunter Scarab"
				icon='Destruction Bug Hunter Scarabs.dmi'
				icon_state=""
				density=1
				var/hits
				New()
					..()
					pixel_x=-16
					pixel_y=8
					layer = MOB_LAYER+1
					src.damage = 1
					spawn(50)if(src)del(src)
				Bump(atom/O)
					if(!src.Hit)
						if(istype(O,/mob))
							var/mob/M=O
							var/mob/Owner=src.Owner
							if(M.dead || M.key == src.name) return
							if(M.fightlayer==src.fightlayer)
								M.PlayAudio('LPunchHIt.ogg', output = AUDIO_HEARERS)
								src.layer=MOB_LAYER+1
								src.loc = M.loc
								if(M!=src.Owner)
									M.DealDamage(2+src.damage+(Owner.ninjutsu_total/10),src.Owner,"NinBlue")
									src.hits++
								step(M,src.dir)
								M.dir = get_dir(M,src)
								if(M.henge==4||M.henge==5)M.HengeUndo()
								if(src.hits >= 16) del(src)
			BugTornado
				name="Bug Tornado"
				icon='AburameUltimate.dmi'
				density=1
				var/hits
				New()
					..()
					layer = MOB_LAYER+1
					src.damage = 1
					spawn(40)if(src)del(src)
				Bump(atom/O)
					if(!src.Hit)
						if(istype(O,/mob))
							var/mob/M=O
							if(M.dead || M.key == src.name) return
							if(M.fightlayer==src.fightlayer)
								M.PlayAudio('LPunchHIt.ogg', output = AUDIO_HEARERS)
								src.layer=MOB_LAYER+1
								src.loc = M.loc
								M.DealDamage(src.damage,src.Owner,"NinBlue")
								src.hits++
								step(M,src.dir)
								M.dir = get_dir(M,src)
								if(M.henge==4||M.henge==5)M.HengeUndo()
								if(src.hits >= 12) del(src)
								if(src)
									walk_towards(src, M, 3)

			WaterShark
				name="Water Shark"
				icon='Water Shark.dmi'
				icon_state=""
				density=1
				New()
					..()
					pixel_y=32
					layer = MOB_LAYER+1
					spawn(50)if(src)del(src)
				Bump(atom/O)
					if(!src.Hit)
						if(istype(O,/mob))
							var/mob/M=O
							var/mob/Owner=src.Owner
							if(M.dead || M.key == src.name || M == Owner) return
							if(M.fightlayer==src.fightlayer)
								src.density=0
								src.PlayAudio('man_fs_r_mt_wat.ogg', output = AUDIO_HEARERS)
								src.layer=MOB_LAYER+1
								walk(src,0)
								src.loc=O.loc
								src.Hit=1
								M.DealDamage(src.damage,src.Owner,"NinBlue")
								if(M.henge==4||M.henge==5)M.HengeUndo()
								M.icon_state="push"
								walk(M,pick(EAST,SOUTH,WEST,SOUTHEAST,SOUTHWEST))
								if(M.client) spawn() M.ScreenShake(5)
								walk(M,0)
								if(!CheckState(M, new/state/swimming))M.icon_state=""
								M.Death(src.Owner)
						else src.invisibility=1
						spawn(5)if(src)del(src)
				Move()
					..()
					var/obj/Projectiles/Effects/WaterDash/D=new(src.loc)
					D.dir=src.dir
			WaterDash
				name="Water Dash"
				icon='Water Dash.dmi'
				icon_state="water top"
				density=1
				New()
					..()
					overlays+=image('Water Dash.dmi',"water bottom")
					spawn(10)if(src)del(src)
			ClayBird
				name="Clay Bird"
				icon='C1.dmi'
				icon_state="Bird"
				density=1
				New()
					..()
					pixel_y=32
					layer = MOB_LAYER+1
					spawn(20)
						var/mob/Owner=src.Owner
						src.density=0
						src.PlayAudio('Exp_Dirt_01.wav', output = AUDIO_HEARERS)
						src.layer=MOB_LAYER+1
						walk(src,0)
						src.icon = 'SmallExplode.dmi'
						src.pixel_x=-16
						src.pixel_y=-16
						flick("blow",src)
						src.Hit=1
						for(var/mob/M in orange(3,src))
							if(!M||M.dead||M==Owner) continue
							M.DealDamage(src.damage,src.Owner,"NinBlue")
							if(M.henge==4||M.henge==5)M.HengeUndo()
						spawn(5)if(src)src.loc=locate(0,0,0)
						spawn(100)if(src)del(src)
				Bump(atom/O)
					if(!src.Hit)
						if(istype(O,/mob))
							var/mob/M=O
							var/mob/Owner=src.Owner
							if(M.dead || M.key == src.name || M==Owner) return
							if(M.fightlayer==src.fightlayer)
								src.density=0
								src.PlayAudio('Exp_Dirt_01.wav', output = AUDIO_HEARERS)
								src.layer=MOB_LAYER+1
								walk(src,0)
								src.loc=O.loc
								src.icon = 'SmallExplode.dmi'
								src.pixel_x=-16
								src.pixel_y=-16
								flick("blow",src)
								src.Hit=1
								M.DealDamage(src.damage,src.Owner,"NinBlue")
								if(M.henge==4||M.henge==5)M.HengeUndo()
						else src.invisibility=1
						spawn(5)if(src)src.loc=locate(0,0,0)

			SenjuJinraiHead
				name="Jinrai"
				icon='flashy beamy.dmi'
				icon_state="heady"
				density=1
				var/tracker=2
				var/obj/Projectiles/Effects/JinraiCore/link
				New()
					..()
					spawn()if(icon == 'flashy beamy.dmi')pixel_y=32
					layer = MOB_LAYER+2
					spawn(60)
						for(var/obj/Projectiles/Effects/JinraiCore/K in world)if(K.link == src)del K
						if(src)del(src)
				Move()
					var/K = new/obj/Projectiles/Effects/JinraiCore(src.loc)
					if(tracker==0)
						tracker=1
						K:icon_state = "beamy2"
					if(tracker==2)
						K:icon_state= "flashy"
						tracker=0
					else tracker=0
					K:icon = src.icon
					K:link = src
					K:dir = src.dir
					K:pixel_x = src.pixel_x
					K:pixel_y = src.pixel_y
					..()
				Bump(atom/O)
					if(!src.Hit)
						spawn(100) for(var/obj/Projectiles/Effects/JinraiCore/K in world) if(K.link == src) K.loc=locate(0,0,0)
						spawn(100) for(var/obj/Projectiles/Effects/JinraiBack/K in world) if(K.link == src.link) K.loc=locate(0,0,0)
						spawn(100) for(var/obj/Projectiles/Effects/JinraiCore/K in world) if(K.link == src) del K
						if(istype(O,/mob))
							var/mob/M=O
							var/mob/Owner=src.Owner
							if(M.dead) return
							if(M.fightlayer==src.fightlayer)
								src.icon_state="heady2"
								src.pixel_x = -16
								src.pixel_y = 0
								src.density=0
								src.PlayAudio('Exp_Dirt_01.wav', output = AUDIO_HEARERS)
								src.layer=MOB_LAYER+1
								walk(src,0)
								src.loc=O.loc
								flick("[src.hitstate]",src)
								src.Hit=1

								var/state/cant_attack/senjujinrai1 = new()
								var/state/cant_move/senjujinrai2 = new()
								AddState(M, senjujinrai1, -1)
								AddState(M, senjujinrai2, -1)

								var/bound_location = M.loc
								for(var/i=0, i<(src.level*2), i++)
									if(bound_location != M.loc || !Owner) break
									M.DealDamage(src.damage/8,Owner,"NinBlue")
									sleep(3)

								if(M.henge==4||M.henge==5)M.HengeUndo()

								RemoveState(M, senjujinrai1, STATE_REMOVE_REF)
								RemoveState(M, senjujinrai2, STATE_REMOVE_REF)

						src.loc=locate(0,0,0)

			SenjuJinraiCore
				name="Jinrai"
				icon='flashy beamy.dmi'
				icon_state="beamy"
				density=1
			JinraiHead
				name="Jinrai"
				icon='flashy beamy.dmi'
				icon_state="heady"
				density=1
				var/obj/Projectiles/Effects/JinraiCore/link
				New()
					..()
					spawn()if(icon == 'flashy beamy.dmi')pixel_y=32
					layer = MOB_LAYER+2
					spawn(20)
						for(var/obj/Projectiles/Effects/JinraiCore/K in world)if(K.link == src)del K
						if(src)del(src)
				Bump(atom/O)
					if(!src.Hit)
						for(var/obj/Projectiles/Effects/JinraiCore/K in world) if(K.link == src) K.loc=locate(0,0,0)
						for(var/obj/Projectiles/Effects/JinraiBack/K in world) if(K.link == src.link) K.loc=locate(0,0,0)
						spawn(100) for(var/obj/Projectiles/Effects/JinraiCore/K in world) if(K.link == src) del K
						if(istype(O,/mob))
							var/mob/M=O
							var/mob/Owner=src.Owner
							if(M.dead) return
							if(M.fightlayer==src.fightlayer)
								src.density=0
								src.PlayAudio('Exp_Dirt_01.wav', output = AUDIO_HEARERS)
								src.layer=MOB_LAYER+1
								walk(src,0)
								src.loc=O.loc
								flick("[src.hitstate]",src)
								src.Hit=1
								M.DealDamage(src.damage,Owner,"NinBlue")
								if(M.henge==4||M.henge==5)M.HengeUndo()
						src.loc=locate(0,0,0)
				Move()
					var/K = new/obj/Projectiles/Effects/JinraiCore(src.loc)
					K:icon = src.icon
					K:link = src
					K:dir = src.dir
					K:pixel_x = src.pixel_x
					K:pixel_y = src.pixel_y
					..()
			JinraiCore
				name="Jinrai"
				icon='flashy beamy.dmi'
				icon_state="beamy"
				density=1
				var/obj/Projectiles/Effects/JinraiBack/link
				Del()
					..()
					for(var/obj/Projectiles/Effects/JinraiBack/K in world) if(K.link == src) del(K)
				New()
					..()
					spawn()if(icon == 'flashy beamy.dmi')pixel_y=32
					layer = MOB_LAYER+1
					spawn(20)if(src)del(src)
				Move()
					var/K = new/obj/Projectiles/Effects/JinraiBack(src.loc)
					K:icon = src.icon
					K:link = src
					K:dir = src.dir
					K:pixel_x = src.pixel_x
					K:pixel_y = src.pixel_y
					..()
			JinraiBack
				name="Jinrai"
				icon='flashy beamy.dmi'
				icon_state="flashy"
				density=1
				var/link
				pixel_y=32
				layer = MOB_LAYER+1
				New()
					..()
					spawn()if(icon == 'flashy beamy.dmi')pixel_y=32
					layer = MOB_LAYER+1
					spawn(20) del(src)
			AlmightyPush
				icon='APush.dmi'
				icon_state="1"
				pixel_x=-310
				pixel_y=-242
				density=0
			BoneSenHit
				icon='Jutsus.dmi'
				icon_state="bonesen"
				layer=MOB_LAYER+1
				New()
					..()
					src.dir=pick(NORTH,EAST,WEST,SOUTH)
					if(prob(50))src.pixel_y+=rand(3,5)
					else src.pixel_y-=rand(1,5)
					if(prob(50))src.pixel_x+=rand(3,6)
					else src.pixel_x-=rand(1,6)
			BoneHit
				icon='BoneYard.dmi'
			//	icon_state="1T"
				layer=MOB_LAYER+1
			BoneYard
				icon='BoneYard.dmi'
				icon_state="1"
				density=0
				New()
					..()
					var/list/dir_list=list(NORTH,EAST,WEST,SOUTH)
					var/list/icon_list=list("1","2","3")
					src.dir=pick(dir_list)
					src.icon_state=pick(icon_list)
					flick("[src.icon_state]R",src)
					var/obj/Top=new/obj/Projectiles/Effects/BoneHit
					Top.IsJutsuEffect=src
					Top.icon_state="[src.icon_state]T"
					Top.dir=src.dir
					src.overlays+=Top
					var/time=text2num(src.level*10)
					for(var/mob/M in view(src,0))
						AddState(M, new/state/cant_move, time)
					spawn(2)	
						src.density=1
						spawn(time)
							src.overlays=null
							Top.loc = null
							spawn(1)flick("[src.icon_state]S",src)
							spawn(3)
								if(src)
									src.loc = null

			OnFire
				icon_state="onfire"
				pixel_y=15
				layer=MOB_LAYER+1
				luminosity=2
				pixel_x=16
			BurntSpot
				icon_state="burnt"
				density=0
				New(loc)
					..()
					var/list/dir_list=list(NORTH,EAST,WEST,SOUTH)
					src.dir=pick(dir_list)
					spawn(600)
						flick("burntfade",src)
						spawn(3)if(src)del(src)
			MediumBurntSpot
				icon='SmallExplode.dmi'
				icon_state="burnt"
				density=0
				New(loc)
					..()
					var/list/dir_list=list(NORTH,EAST,WEST,SOUTH)
					src.dir=pick(dir_list)
					spawn(600)
						flick("burntfade",src)
						spawn(3)if(src)del(src)
			SmallExplosion
				icon='SmallExplode.dmi'
				icon_state="blow"
				density=0
				layer=MOB_LAYER+2
				luminosity=3
				//pixel_x=-10
				New()
					..()
					flick("blow",src)
					spawn(6)if(src)del(src)
			Fire
				name=""
				icon_state="firesmall"
				density=0
				layer=OBJ_LAYER+1
				luminosity=2
				New(loc)
					..()
					src.overlays+=/obj/Projectiles/Effects/Fire
					src.pixel_x+=rand(1,20)
					src.pixel_x-=rand(1,20)
					src.pixel_y+=rand(1,20)
					src.pixel_y-=rand(1,20)
					spawn(rand(50,100))
						if(src.Linkage)
							flick("firesmall",src)
							sleep(5)
							del(src)
						else
							flick("firesmall",src)
							sleep(5)
							del(src)
					spawn()
						AI()
						AIBurn()
				proc/AI()
					if(prob(50))src.icon_state="fire"
					else src.icon_state="firesmall"
					if(prob(50))step_rand(src)
					else ..()
					if(prob(50))step_rand(src)
					else ..()
					var/obj/FB=new/obj/Projectiles/Effects/BurntSpot
					FB.IsJutsuEffect=src
					FB.loc=src.loc
					FB.pixel_x=src.pixel_x
					FB.pixel_y=src.pixel_y
				proc/AIBurn()
					while(src)
						if(src)
							var/mob/Owner=src.Owner
							if(!Owner) break
							for(var/mob/U in view(src,0))
								if(U.dead || CheckState(U, new/state/swimming)) continue
								if(U.dead==0)
									var/damage=10+round(Owner.ninjutsu_total/4)
									U.DealDamage(damage,src.Owner,"NinBlue")
									if(U.henge==4||U.henge==5)
										U.HengeUndo()
									src.Linkage=U
									spawn(2)
										if(src)src.Linkage=0
							sleep(5)
							continue
						else break
			MasterFire
				name=""
				icon_state="fire"
				density=0
				layer=OBJ_LAYER+1
				luminosity=2
				New(loc)
					..()
					src.pixel_x+=rand(1,20)
					src.pixel_x-=rand(1,20)
					src.pixel_y+=rand(1,20)
					src.pixel_y-=rand(1,20)
					src.overlays+=/obj/Projectiles/Effects/Fire
					src.overlays+=/obj/Projectiles/Effects/Fire
					var/obj/FB=new/obj/Projectiles/Effects/BurntSpot
					FB.IsJutsuEffect=src
					FB.loc=src.loc
					FB.pixel_x=src.pixel_x
					FB.pixel_y=src.pixel_y
					spawn(rand(150,250))
						flick("firesmall",src)
						sleep(5)
						del(src)
					spawn()AI()
				proc/AI()
					src.PlayAudio('fire/fire_small1.ogg', output = AUDIO_HEARERS)
					if(src.cooled<=14)
						var/obj/fire=new/obj/Projectiles/Effects/Fire(src.loc)
						var/mob/CP=src.Owner
						fire.Owner=CP
						fire.IsJutsuEffect=src
						src.cooled++
					sleep(43)
					if(src)src.AI()
			MasterFireNoSound
				name=""
				icon_state="fire"
				density=0
				layer=OBJ_LAYER+1
				luminosity=2
				New(loc)
					..()
					src.pixel_x+=rand(1,20)
					src.pixel_x-=rand(1,20)
					src.pixel_y+=rand(1,20)
					src.pixel_y-=rand(1,20)
					src.overlays+=/obj/Projectiles/Effects/Fire
					src.overlays+=/obj/Projectiles/Effects/Fire
					var/obj/FB=new/obj/Projectiles/Effects/BurntSpot
					FB.IsJutsuEffect=src
					FB.loc=src.loc
					FB.pixel_x=src.pixel_x
					FB.pixel_y=src.pixel_y
					spawn(rand(150,250))
						flick("firesmall",src)
						sleep(5)
						if(src)del(src)
					spawn()AI()
				proc/AI()
					if(src.cooled<=14)
						var/obj/fire=new/obj/Projectiles/Effects/Fire(src.loc)
						fire.IsJutsuEffect=src
						var/mob/CP=src.Owner
						fire.Owner=CP
						src.cooled++
					sleep(33)
					if(src)src.AI()
		AFireBall
			icon='FireBallA.dmi'
			icon_state="dir"
			pixel_x=-30
			hitstate="hit"
			hitsound='Exp_Dirt_01.wav'
			luminosity=5
			New()
				flick("dir",src)
				spawn(30)if(src)if(!src.Hit)del(src)
				spawn()AI()
				..()
			proc/AI()
				var/mob/Owner=src.Owner
				while(src)
					if(!src.Hit)
						for(var/mob/M in range(src,1))
							if(M<>Owner)
								if(M.dead||CheckState(M, new/state/swimming)||M.Owner==src.Owner)continue
								if(M.fightlayer==src.fightlayer||M.fightlayer=="Normal"&&src.fightlayer=="HighGround")
									src.Hit=1
									src.icon='FireBallAHit.dmi'
									src.pixel_x=-50
									src.density=0
									src.PlayAudio(src.hitsound, output = AUDIO_HEARERS)
									src.layer=MOB_LAYER+1
									walk(src,0)
									flick("hit",src)
									M.DealDamage(src.damage,src.Owner,"NinBlue")
									if(M.henge==4||M.henge==5)M.HengeUndo()
									var/obj/Projectiles/Effects/MasterFire/F1 = new(src.loc)
									F1.loc=src.loc
									F1.Owner=Owner
									var/obj/Projectiles/Effects/MasterFireNoSound/F2 = new(src.loc)
									F2.loc=src.loc
									F2.x+=1
									F2.Owner=Owner
									var/obj/Projectiles/Effects/MasterFireNoSound/F3 = new(src.loc)
									F3.loc=src.loc
									F3.x-=1
									F3.Owner=Owner
									var/obj/Projectiles/Effects/MasterFireNoSound/F4 = new(src.loc)
									F4.loc=src.loc
									F4.y-=1
									F4.Owner=Owner
									spawn(7)if(src)del(src)
						sleep(2)
						continue
					else break
			Bump(atom/O)
				if(!src.Hit)
					src.icon='FireBallAHit.dmi'
					src.pixel_x=-50
					if(istype(O,/mob))
						var/mob/M=O
						var/mob/Owner=src.Owner
						if(M.dead||CheckState(M, new/state/swimming)||M.Owner==src.Owner)if(src)del(src)
						if(M.fightlayer==src.fightlayer)
							src.density=0
							src.PlayAudio('Exp_Dirt_01.wav', output = AUDIO_HEARERS)
							src.layer=MOB_LAYER+1
							walk(src,0)
							src.loc=O.loc
							flick("[src.hitstate]",src)
							src.Hit=1
							M.DealDamage(src.damage,src.Owner,"NinBlue")
							if(M.henge==4||M.henge==5)M.HengeUndo()
							var/obj/Projectiles/Effects/MasterFire/F1 = new(src.loc)
							F1.loc=src.loc
							F1.Owner=Owner
							var/obj/Projectiles/Effects/MasterFireNoSound/F2 = new(src.loc)
							F2.loc=src.loc
							F2.x+=1
							F2.Owner=Owner
							var/obj/Projectiles/Effects/MasterFireNoSound/F3 = new(src.loc)
							F3.loc=src.loc
							F3.x-=1
							F3.Owner=Owner
							var/obj/Projectiles/Effects/MasterFireNoSound/F4 = new(src.loc)
							F4.loc=src.loc
							F4.y-=1
							F4.Owner=Owner
							spawn(7)if(src)del(src)
						else
							if(M.fightlayer=="Normal"&&src.fightlayer=="HighGround")
								src.density=0
								src.PlayAudio('Exp_Dirt_01.wav', output = AUDIO_HEARERS)
								src.layer=MOB_LAYER+1
								walk(src,0)
								src.loc=O.loc
								flick("[src.hitstate]",src)
								src.Hit=1
								M.DealDamage(src.damage,src.Owner,"NinBlue")
								if(M.henge==4||M.henge==5)M.HengeUndo()
								var/obj/Projectiles/Effects/MasterFire/F1 = new(src.loc)
								F1.loc=src.loc
								F1.Owner=Owner
								var/obj/Projectiles/Effects/MasterFireNoSound/F2 = new(src.loc)
								F2.loc=src.loc
								F2.x+=1
								F2.Owner=Owner
								var/obj/Projectiles/Effects/MasterFireNoSound/F3 = new(src.loc)
								F3.loc=src.loc
								F3.x-=1
								F3.Owner=Owner
								var/obj/Projectiles/Effects/MasterFireNoSound/F4 = new(src.loc)
								F4.loc=src.loc
								F4.y-=1
								F4.Owner=Owner
								spawn(7)if(src)del(src)
							else src.loc=M.loc
					else
						if(istype(O,/obj/Projectiles)&&!istype(O,/obj/Projectiles/Weaponry))
							var/obj/Projectiles/OBJ=O
							if(OBJ.fightlayer==src.fightlayer)
								src.Hit=1
								if(src.damage>OBJ.damage)
									OBJ.density=0
									OBJ.PlayAudio(OBJ.hitsound, output = AUDIO_HEARERS)
									walk(OBJ,0)
									flick("[OBJ.hitstate]",OBJ)
									spawn(7)if(OBJ)del(OBJ)
								else
									if(src.damage<OBJ.damage)
										src.density=0
										src.icon='FireBallAHit.dmi'
										src.pixel_x=-50
										src.PlayAudio('Exp_Dirt_01.wav', output = AUDIO_HEARERS)
										walk(src,0)
										flick("[src.hitstate]",src)
										var/obj/Projectiles/Effects/MasterFire/F1 = new(src.loc)
										F1.loc=src.loc
										F1.Owner=Owner
										var/obj/Projectiles/Effects/MasterFireNoSound/F2 = new(src.loc)
										F2.loc=src.loc
										F2.x+=1
										F2.Owner=Owner
										var/obj/Projectiles/Effects/MasterFireNoSound/F3 = new(src.loc)
										F3.loc=src.loc
										F3.x-=1
										F3.Owner=Owner
										var/obj/Projectiles/Effects/MasterFireNoSound/F4 = new(src.loc)
										F4.loc=src.loc
										F4.y-=1
										F4.Owner=Owner
										spawn(7)if(src)del(src)
									else
										if(src.damage==OBJ.damage)
											src.density=0
											OBJ.density=0
											src.icon='FireBallAHit.dmi'
											src.pixel_x=-50
											src.PlayAudio('Exp_Dirt_01.wav', output = AUDIO_HEARERS)
											walk(src,0)
											walk(OBJ,0)
											flick("[src.hitstate]",src)
											flick("[OBJ.hitstate]",OBJ)
											var/obj/Projectiles/Effects/MasterFire/F1 = new(src.loc)
											F1.loc=src.loc
											F1.Owner=Owner
											var/obj/Projectiles/Effects/MasterFireNoSound/F2 = new(src.loc)
											F2.loc=src.loc
											F2.x+=1
											F2.Owner=Owner
											var/obj/Projectiles/Effects/MasterFireNoSound/F3 = new(src.loc)
											F3.loc=src.loc
											F3.x-=1
											F3.Owner=Owner
											var/obj/Projectiles/Effects/MasterFireNoSound/F4 = new(src.loc)
											F4.loc=src.loc
											F4.y-=1
											F4.Owner=Owner
											spawn(7)
												if(OBJ)del(OBJ)
												if(src)del(src)
						else
							if(istype(O,/obj))
								var/obj/OBJ=O
								if(OBJ.fightlayer==src.fightlayer)
									src.density=0
									src.PlayAudio('Exp_Dirt_01.wav', output = AUDIO_HEARERS)
									walk(src,0)
									flick("hit",src)
									var/obj/Projectiles/Effects/MasterFire/F1 = new(src.loc)
									F1.loc=src.loc
									F1.Owner=Owner
									var/obj/Projectiles/Effects/MasterFireNoSound/F2 = new(src.loc)
									F2.loc=src.loc
									F2.x+=1
									F2.Owner=Owner
									var/obj/Projectiles/Effects/MasterFireNoSound/F3 = new(src.loc)
									F3.loc=src.loc
									F3.x-=1
									F3.Owner=Owner
									var/obj/Projectiles/Effects/MasterFireNoSound/F4 = new(src.loc)
									F4.loc=src.loc
									F4.y-=1
									F4.Owner=Owner
									spawn(7)if(src)del(src)
								else
									if(OBJ.fightlayer=="Normal"&&src.fightlayer=="HighGround")
										src.density=0
										src.PlayAudio('Exp_Dirt_01.wav', output = AUDIO_HEARERS)
										walk(src,0)
										flick("hit",src)
										var/obj/Projectiles/Effects/MasterFire/F1 = new(src.loc)
										F1.loc=src.loc
										F1.Owner=Owner
										var/obj/Projectiles/Effects/MasterFireNoSound/F2 = new(src.loc)
										F2.loc=src.loc
										F2.x+=1
										F2.Owner=Owner
										var/obj/Projectiles/Effects/MasterFireNoSound/F3 = new(src.loc)
										F3.loc=src.loc
										F3.x-=1
										F3.Owner=Owner
										var/obj/Projectiles/Effects/MasterFireNoSound/F4 = new(src.loc)
										F4.loc=src.loc
										F4.y-=1
										F4.Owner=Owner
										spawn(7)if(src)del(src)
							else
								if(istype(O,/turf))
									var/turf/T=O
									if(T.fightlayer==src.fightlayer)
										src.density=0
										src.PlayAudio('Exp_Dirt_01.wav', output = AUDIO_HEARERS)
										walk(src,0)
										flick("hit",src)
										var/obj/Projectiles/Effects/MasterFire/F1 = new(src.loc)
										F1.loc=src.loc
										F1.Owner=Owner
										var/obj/Projectiles/Effects/MasterFireNoSound/F2 = new(src.loc)
										F2.loc=src.loc
										F2.x+=1
										F2.Owner=Owner
										var/obj/Projectiles/Effects/MasterFireNoSound/F3 = new(src.loc)
										F3.loc=src.loc
										F3.x-=1
										F3.Owner=Owner
										var/obj/Projectiles/Effects/MasterFireNoSound/F4 = new(src.loc)
										F4.loc=src.loc
										F4.y-=1
										F4.Owner=Owner
										spawn(7)if(src)del(src)
									else
										if(T.fightlayer=="HighGround"&&src.fightlayer=="Normal")src.loc=locate(T.x,T.y,T.z)
										else if(src.fightlayer=="HighGround"&&T.fightlayer=="Normal")src.loc=locate(T.x,T.y,T.z)
		FireBall
			icon_state="fireball"
			hitstate="fireballhit"
			hitsound='boom.wav'
			luminosity=3
			New()
				flick("fireball",src)
				spawn(30)
					if(!src.Hit)
						flick("fireballhit",src)
						spawn(7)if(src)del(src)
				..()
			Bump(atom/O)
				if(!src.Hit)
					if(istype(O,/mob))
						var/mob/M=O
						var/mob/owner=src.Owner
						if(M.dead) return
						if(M.fightlayer==src.fightlayer)
							src.density=0
							src.PlayAudio('boom.wav', output = AUDIO_HEARERS)
							src.layer=MOB_LAYER+1
							walk(src,0)
							src.loc=O.loc
							flick("[src.hitstate]",src)
							src.Hit=1
							M.DealDamage(src.damage,src.Owner,"NinBlue")
							if(prob(80))
								M.Linkage=src
								M.overlays+=/obj/Projectiles/Effects/OnFire
								if(src.level==1)
									M.burn=4
									spawn(10)if(M)M.BurnEffect(owner)
								if(src.level==2)
									M.burn=6
									spawn(10)if(M)M.BurnEffect(owner)
								if(src.level==3)
									M.burn=8
									spawn(10)if(M)M.BurnEffect(owner)
								if(src.level==4)
									M.burn=10
									spawn(10)if(M)M.BurnEffect(owner)
							if(M.henge==4||M.henge==5)M.HengeUndo()
							spawn(7)if(src)src.loc=locate(0,0,0)
						else
							if(M.fightlayer=="Normal"&&src.fightlayer=="HighGround")
								src.density=0
								src.PlayAudio('boom.wav', output = AUDIO_HEARERS)
								src.layer=MOB_LAYER+1
								walk(src,0)
								src.loc=O.loc
								flick("fireballhit",src)
								src.Hit=1
								M.DealDamage(src.damage,src.Owner,"NinBlue")
								if(prob(80))
									M.Linkage=src
									M.overlays+=/obj/Projectiles/Effects/OnFire
									if(src.level==1)
										M.burn=4
										spawn(10)if(M)M.BurnEffect(owner)
									if(src.level==2)
										M.burn=6
										spawn(10)if(M)M.BurnEffect(owner)
									if(src.level==3)
										M.burn=8
										spawn(10)if(M)M.BurnEffect(owner)
									if(src.level==4)
										M.burn=10
										spawn(10)if(M)M.BurnEffect(owner)
								if(M.henge==4||M.henge==5)M.HengeUndo()
								spawn(7)if(src)src.loc=locate(0,0,0)
							else src.loc=M.loc
					else
						if(istype(O,/obj/Projectiles)&&!istype(O,/obj/Projectiles/Weaponry))
							var/obj/Projectiles/OBJ=O
							if(OBJ.fightlayer==src.fightlayer)
								src.Hit=1
								if(src.damage>OBJ.damage)
									OBJ.density=0
									OBJ.PlayAudio(OBJ.hitsound, output = AUDIO_HEARERS)
									walk(OBJ,0)
									flick("[OBJ.hitstate]",OBJ)
									spawn(7)if(OBJ)del(OBJ)
								else
									if(src.damage<OBJ.damage)
										src.density=0
										src.PlayAudio(src.hitsound, output = AUDIO_HEARERS)
										walk(src,0)
										flick("[src.hitstate]",src)
										spawn(7)if(src)del(src)
									else
										if(src.damage==OBJ.damage)
											src.density=0
											OBJ.density=0
											src.PlayAudio(src.hitsound, output = AUDIO_HEARERS)
											walk(src,0)
											walk(OBJ,0)
											flick("[src.hitstate]",src)
											flick("[OBJ.hitstate]",OBJ)
											spawn(7)
												if(OBJ)del(OBJ)
												if(src)del(src)
							else
								if(OBJ.fightlayer=="Normal"&&src.fightlayer=="HighGround")
									src.Hit=1
									src.density=0
									src.PlayAudio('boom.wav', output = AUDIO_HEARERS)
									walk(src,0)
									flick("[src.hitstate]",src)
									spawn(7)if(src)del(src)
						else
							if(istype(O,/obj))
								var/obj/OBJ=O
								if(OBJ.fightlayer==src.fightlayer)
									src.Hit=1
									src.loc=O.loc
									src.density=0
									src.PlayAudio('boom.wav', output = AUDIO_HEARERS)
									walk(src,0)
									flick("[src.hitstate]",src)
									spawn(7)if(src)del(src)
								else
									if(OBJ.fightlayer=="Normal"&&src.fightlayer=="HighGround")
										src.Hit=1
										src.density=0
										src.PlayAudio('boom.wav', output = AUDIO_HEARERS)
										walk(src,0)
										flick("[src.hitstate]",src)
										spawn(7)if(src)del(src)
							else
								if(istype(O,/turf))
									var/turf/T=O
									if(T.fightlayer==src.fightlayer)
										src.Hit=1
										src.loc=locate(T.x,T.y,T.z)
										src.density=0
										src.PlayAudio('boom.wav', output = AUDIO_HEARERS)
										walk(src,0)
										flick("fireballhit",src)
										spawn(7)if(src)del(src)
									else
										if(T.fightlayer=="HighGround"&&src.fightlayer=="Normal")src.loc=locate(T.x,T.y,T.z)
										else
											if(src.fightlayer=="HighGround"&&T.fightlayer=="Normal")src.loc=locate(T.x,T.y,T.z)
		Pull
			icon_state="pull"
			New()
				flick("pull",src)
				spawn(30)if(src)if(!src.Hit)del(src)
				..()
			Bump(atom/O)
				if(!src.Hit)
					if(istype(O,/mob))
						var/mob/M=O
						var/mob/Owner=src.Owner
						if(M.dead || !M.key) del(src)
						if(M.fightlayer==src.fightlayer)
							src.density=0
							src.PlayAudio('Beam.ogg', output = AUDIO_HEARERS)
							walk(src,0)
							src.loc=locate(0,0,0)
							src.Hit=1
							Owner.Levelup()
							if(M.henge==4||M.henge==5)M.HengeUndo()
							M.icon_state="pull"
							M.Bind(M, 10+Owner.ninjutsu_total/8)
							if(!M.key) goto lol
							walk_towards(M,Owner)
							lol
							src.loc=locate(0,0,0)
							M.DealDamage(src.damage,src.Owner,"NinBlue")
							spawn(10+Owner.ninjutsu_total/8)
								if(M)
									if(M.dead==0)
										M.icon_state=""
									walk(M,0)
								if(src)del(src)
						else
							if(M.fightlayer=="Normal"&&src.fightlayer=="HighGround")
								src.density=0
								src.PlayAudio('Beam.ogg', output = AUDIO_HEARERS)
								walk(src,0)
								src.loc=locate(0,0,0)
								src.Hit=1
								Owner.Levelup()
								if(M.henge==4||M.henge==5)M.HengeUndo()
								M.icon_state="pull"
								M.Bind(M, 10+Owner.ninjutsu_total/8)
								walk_towards(M,Owner)
								src.loc=locate(0,0,0)
								M.DealDamage(src.damage,src.Owner,"NinBlue")
								spawn(10+Owner.ninjutsu_total/8)
									if(M)
										if(M.dead==0)
											M.icon_state=""
										walk(M,0)
									if(src)del(src)
							else src.loc=M.loc
					else
						if(istype(O,/obj))
							var/obj/OBJ=O
							if(OBJ.fightlayer==src.fightlayer)if(src)del(src)
							else
								if(OBJ.fightlayer=="Normal"&&src.fightlayer=="HighGround")if(src)del(src)
						else
							if(istype(O,/turf))
								var/turf/T=O
								if(T.fightlayer==src.fightlayer)if(src)del(src)
								else
									if(T.fightlayer=="HighGround"&&src.fightlayer=="Normal")if(src)src.loc=locate(T.x,T.y,T.z)
									else
										if(src.fightlayer=="HighGround"&&T.fightlayer=="Normal")if(src)src.loc=locate(T.x,T.y,T.z)
			Move()
				..()
				return step(src,src.dir)
		Push
			icon_state="pull"
			hitstate="0"
			New()
				flick("pull",src)
				spawn(30)if(src)if(!src.Hit)del(src)
				..()
			Bump(atom/O)
				if(!src.Hit)
					if(istype(O,/mob))
						var/mob/M=O
						var/mob/Owner=src.Owner
						if(M.dead || !M.key) del(src)
						if(M.fightlayer==src.fightlayer)
							src.density=0
							var/obj/A = new/obj/MiscEffects/MeteorDust(src.loc)
							A.IsJutsuEffect=src
							A.pixel_x=-30
							A.pixel_y=-10
							A.dir=src.dir
							src.PlayAudio('Beam.ogg', output = AUDIO_HEARERS)
							walk(src,0)
							src.loc=locate(0,0,0)
							src.Hit=1
							Owner.Levelup()
							if(M.henge==4||M.henge==5)M.HengeUndo()
							M.icon_state="push"
							M.Bind(M, 10+Owner.ninjutsu_total/8)
							if(!M.key) goto lol
							walk(M,Owner.dir)
							lol
							src.loc=locate(0,0,0)
							M.DealDamage(src.damage,src.Owner,"NinBlue")
							spawn(10+Owner.ninjutsu_total/8)
								if(M)
									if(M.dead==0&&!CheckState(M, new/state/swimming))M.icon_state=""
									walk(M,0)
								if(src)del(src)
						else
							if(M.fightlayer=="Normal"&&src.fightlayer=="HighGround")
								src.density=0
								var/obj/A = new/obj/MiscEffects/MeteorDust(src.loc)
								A.IsJutsuEffect=src
								A.pixel_x=-30
								A.pixel_y=-10
								A.dir=src.dir
								src.PlayAudio('Beam.ogg', output = AUDIO_HEARERS)
								walk(src,0)
								src.loc=locate(0,0,0)
								src.Hit=1
								Owner.Levelup()
								if(M.henge==4||M.henge==5)M.HengeUndo()
								M.icon_state="push"
								AddState(M, new/state/cant_move, 10+Owner.ninjutsu_total/8)
								walk(M,Owner.dir)
								src.loc=locate(0,0,0)
								M.DealDamage(src.damage,src.Owner,"NinBlue")
								spawn(10+Owner.ninjutsu_total/8)
									if(M)
										if(M.dead==0&&!CheckState(M, new/state/swimming))M.icon_state=""
										walk(M,0)
									if(src)del(src)
							else src.loc=M.loc
					else
						if(istype(O,/obj/Projectiles)&&!istype(O,/obj/Projectiles/Weaponry))
							..()
						else
							if(istype(O,/obj/Projectiles/Weaponry))
								var/obj/OBJ=O
								if(OBJ.fightlayer==src.fightlayer)walk(O,src.dir)
								else
									if(OBJ.fightlayer=="Normal"&&src.fightlayer=="HighGround")walk(O,src.dir)
							else
								if(istype(O,/obj))
									var/obj/OBJ=O
									if(OBJ.fightlayer==src.fightlayer)if(src)del(src)
									else
										if(OBJ.fightlayer=="Normal"&&src.fightlayer=="HighGround")if(src)del(src)
								else
									if(istype(O,/turf))
										var/turf/T=O
										if(T.fightlayer==src.fightlayer)if(src)del(src)
										else
											if(T.fightlayer=="HighGround"&&src.fightlayer=="Normal")src.loc=locate(T.x,T.y,T.z)
											else
												if(src.fightlayer=="HighGround"&&T.fightlayer=="Normal")src.loc=locate(T.x,T.y,T.z)
						if(src)del(src)
			Move()
				..()
				return step(src,src.dir)
mob
	proc
		BurnEffect(mob/X)
			if(src.burn>0&&src.health>0&&X)
				burn--
				var/damage=3+round(X.ninjutsu_total/5)
				src.DealDamage(damage,X,"NinBlue")
				src.PlayAudio('boom.wav', output = AUDIO_HEARERS)
				spawn(4)if(src)src.BurnEffect(X)
			else
				src.overlays-=/obj/Projectiles/Effects/OnFire
				if(src.Linkage)
					var/obj/OBJ=src.Linkage
					if(OBJ)del(OBJ)
					src.Linkage=null

		Step_Back()
			var/direct=src.dir
			if(src.dir==NORTH)
				step(src,SOUTH)
				src.dir=direct
				return
			if(src.dir==NORTHEAST)
				step(src,SOUTHWEST)
				src.dir=direct
				return
			if(src.dir==NORTHWEST)
				step(src,SOUTHEAST)
				src.dir=direct
				return
			if(src.dir==SOUTH)
				step(src,NORTH)
				src.dir=direct
				return
			if(src.dir==SOUTHEAST)
				step(src,NORTHWEST)
				src.dir=direct
				return
			if(src.dir==SOUTHWEST)
				step(src,NORTHEAST)
				src.dir=direct
				return
			if(src.dir==EAST)
				step(src,WEST)
				src.dir=direct
				return
			if(src.dir==WEST)
				step(src,EAST)
				src.dir=direct
				return
mob/proc/Follow(var/mob/M)
	if(M && src)
		M.LinkFollowers+=src
		src.loc = M.loc
		spawn(1)if(src)src.Follow(M)
	else if(src)del(src)
obj/Jutsu/Effects
	WaterPrison
		icon='Water Prison.dmi'
		icon_state="stay"
		//density=0
		pixel_y=-5
		mouse_opacity=0
		New()
			..()
			flick("create",src)

	Nara
		layer=MOB_LAYER-1

		ShadowBase
			icon='Shadow_Bind.dmi'
			icon_state="base"
			pixel_y=-12
			pixel_x=-2
			New()
				..()
				spawn(20000)if(src)del(src)

		ShadowTrail
			icon='Shadow_Bind.dmi'
			icon_state="trail"
			pixel_y=-12
			pixel_x=-2
			New()
				..()
				spawn(20000)if(src)del(src)
				spawn(1)
					switch(src.dir)
						if(NORTHEAST)src.overlays+=image('Shadow_Bind.dmi',icon_state = "patch",pixel_x=16,pixel_y=16)
						if(NORTHWEST)src.overlays+=image('Shadow_Bind.dmi',icon_state = "patch",pixel_x=-16,pixel_y=16)
						if(SOUTHEAST)src.overlays+=image('Shadow_Bind.dmi',icon_state = "patch",pixel_x=16,pixel_y=-16)
						if(SOUTHWEST)src.overlays+=image('Shadow_Bind.dmi',icon_state = "patch",pixel_x=-16,pixel_y=-16)

		ShadowExtension
			icon='Shadow_Bind.dmi'
			icon_state="head"
			pixel_y=-12
			pixel_x=-2
			var/list/Stuffz=list()
			var/bumped
			New(loc, var/state/cant_attack/a, var/state/cant_move/b)
				..()
				spawn(1200)if(src)src.Del(a, b)
			Move()
				..()
				if(bumped) return
				var/obj/Jutsu/Effects/Nara/ShadowTrail/T=new(src.loc)
				T.IsJutsuEffect=src
				Stuffz.Add(T)
				T.dir=src.dir
			Del(var/state/cant_attack/a, var/state/cant_move/b)
				for(var/obj/O in Stuffz) del(O)
				for(var/mob/Who in src.loc)
					if(!Who.dead)
						RemoveState(Who, a, STATE_REMOVE_REF)
						RemoveState(Who, b, STATE_REMOVE_REF)
						Who.NaraTarget=null
						Who.icon_state=""
				..()
mob/var/tmp/mob/NaraTarget
mob/proc/CreateTrailNara(mob/Who,Timer)
	if(!Who)return
	//if(!Who in oview()) return
	icon_state="jutsuse"

	var/state/cant_attack/e = new()
	var/state/cant_move/f = new()
	var/state/casting_shadow_extension/shadow_extension = new()

	var/state/cant_attack/a = new()
	var/state/cant_move/b = new()

	AddState(src, e, -1)
	AddState(src, f, -1)
	AddState(src, shadow_extension, -1)

	Timer = Timer*10
	if(Timer>=50)Timer=50
	var/obj/Jutsu/Effects/Nara/ShadowBase/B=new(src.loc)
	B.IsJutsuEffect=src
	B.dir=src.dir
	var/obj/Jutsu/Effects/Nara/ShadowExtension/E=new(src.loc, a, b)
	E.IsJutsuEffect=src
	E.dir=src.dir
	E.Owner=src
	B.Owner=src
	var/turf/T=Who.loc

	spawn((Timer)+10)
		if(src)
			RemoveState(src, e, STATE_REMOVE_REF)
			RemoveState(src, f, STATE_REMOVE_REF)
			RemoveState(src, shadow_extension, STATE_REMOVE_REF)
			icon_state=""
			NaraTarget=null
			/*for(var/obj/Jutsus/Shadow_Extension/J in src.jutsus)
				src.JutsuCoolSlot(J)
				J.cooltimer=J.maxcooltime
				J.JutsuCoolDown(src)*/
		if(Who)
			RemoveState(Who, a, STATE_REMOVE_REF)
			RemoveState(Who, b, STATE_REMOVE_REF)
			Who.icon_state = ""
			NaraTarget=null
			Who=null
		if(E)del(E)
		if(B)del(B)


	while(E.loc!=T&&!E.bumped&&Who)
		sleep(1)
		if(src)
			T=Who.loc
			if(!E) continue
			for(var/atom/D in get_step(E,E.dir))
				if(D.density&&!ismob(D))
					if(isturf(D)||isobj(D))
						if(E)E.bumped=1
			E.density=0
			step_to(E,T,0)
	T = Who.loc
	if(Who&&T)
		if(Who.loc==T&&E.loc==T)
			AddState(Who, a, -1)
			AddState(Who, b, -1)
			NaraTarget=Who
			while(Timer && Who && src && NaraTarget==Who)
				Timer--
				NaraTarget=Who
				if(Who.loc!=E.loc)
					NaraTarget=null
				sleep(1)
			if(E)del(E)
			if(B)del(B)
			if(Who)
				if(!Who.dead)
					RemoveState(Who, a, -1)
					RemoveState(Who, b, -1)
					NaraTarget=null

			if(src)
				if(!src.dead)
					RemoveState(src, e, -1)
					RemoveState(src, f, -1)
					RemoveState(src, shadow_extension, -1)
					src.NaraTarget=null
					/*for(var/obj/Jutsus/Shadow_Extension/J in src.jutsus)
						src.JutsuCoolSlot(J)
						J.cooltimer=J.maxcooltime
						J.JutsuCoolDown(src)*/
	if(E)del(E)
	if(B)del(B)
	if(src)
		if(!src.dead)
			RemoveState(src, e, -1)
			RemoveState(src, f, -1)
			RemoveState(src, shadow_extension, -1)
			NaraTarget=null
			icon_state=""
			/*for(var/obj/Jutsus/Shadow_Extension/J in src.jutsus)
				src.JutsuCoolSlot(J)
				J.cooltimer=J.maxcooltime
				J.JutsuCoolDown(src)*/
	if(Who)
		if(!Who.dead)
			RemoveState(Who, a, -1)
			RemoveState(Who, b, -1)
			Who.NaraTarget=null
			Who.icon_state=""


mob
	proc
		has_water()//Special Proc
			for(var/turf/T in view()) if(T.iswater==1) return T
			for(var/area/A in view()) if(A.iswater==1) return A
			return null


obj/Dust
	icon='DustJutsu.dmi'
	Prison
		icon_state="create"
		pixel_x=-13
		pixel_y=-12
		layer=999

obj
	forwind
		windstyle
			icon='Tornado.dmi'
			layer=MOB_LAYER+1
			pixel_x=-90
			pixel_y=12
			density=0
			//var/mob/ownerrr=null
			New()
				spawn(80)
					del(src)
				..()

	snakeeelol
		icon='Snake Jutsu.dmi'
		pixel_y=-20
		pixel_x=37
	senjuu
		layer=MOB_LAYER+2
		stab
			icon='Senjuu.dmi'
			icon_state="stab"
			density=1
			New()
				spawn(30)
					if(src) del(src)

		Strangle1
			icon='senjuustrangle.dmi'
			density=1
			pixel_x=8
			pixel_y=-20//strangle
			New()

				spawn(50)
					if(src) del(src)
	earth
		dotondango
			icon='DotonBoulder.dmi'
			density=1
			var/mob/ooowner=null
			var/dmg=100
			New()
				spawn(80)
					del(src)
				..()
			Bump(A)
				if(istype(A,/mob/))
					var/mob/M=A
					if(M==ooowner) del(src)
					M.DealDamage((ooowner.taijutsu_total+dmg+ooowner.ninjutsu_total),src.Owner,"NinBlue")
					src.density=0
					step(src,src.dir)
				else
					del(src)

	WoodStyle
		Fortres
			icon='WoodStyleFortress.dmi'
			density=1
			layer=MOB_LAYER
			New()
				spawn(40)
				del(src)

	FireStyle
		Ring
			icon='Ring of Fire.dmi'
			icon_state="stay"
			density=1
			layer=MOB_LAYER+1
			New()
				spawn(100)
				del(src)

	crystal
		pixel_x=-16
		spikes
			icon='CrystalIcons.dmi'
			icon_state="spikes"
			density=1
			layer=MOB_LAYER+2
			New()
				..()
				spawn(30)
					if(src) del(src)
		explosion
			icon='CrystalIcons.dmi'
			icon_state="explosion"
			density=1
			layer=MOB_LAYER+2
			New()
				..()
				spawn(60)//60
					if(src) del(src)

			Move()
				..()
				var/obj/crystal/explosion/E= new/obj/crystal/explosion(src.loc)
				E.dir=get_dir(src.Owner,E)

			Bump(atom/O)
				if(!src.Hit)
					if(istype(O,/mob))
						var/mob/M=O
						if(M)
							if(M <> src.Owner)
								var/mob/Owner=src.Owner
								if(M.dead || M.key == src.name) return
								if(M.fightlayer==src.fightlayer)
									src.PlayAudio('knife_hit1.wav', output = AUDIO_HEARERS)
									src.layer=MOB_LAYER+1
									if(M)
										src.loc = M.loc
										AddState(M, new/state/cant_move, 15)
										M.DealDamage(src.damage,src.Owner,"NinBlue")
										spawn(15)
										if(M)M.Bleed()
										if(Owner.loc.loc:Safe!=1) Owner.LevelStat("Ninjutsu",rand(3,5))
										if(M.henge==4||M.henge==5)M.HengeUndo()

obj
	proc
		Dup(mob/M)
			var/obj/O8 = new/obj
			O8.IsJutsuEffect=M
			O8.icon = 'Smoke.dmi'
			O8.icon_state = "still"
			O8.loc = src.loc
			step(O8,src.dir)
			step_rand(O8)
			for(var/obj/O in O8.loc)if(O8 && O <> O8)del(O8)
			if(O8)
				var/turf/T = O8.loc
				if(T.density)if(O8)del(O8)
			if(O8)
				O8.owner = M
				spawn(2)if(M.copy == "Ashes" && src) O8.Dup(M)
				spawn(150)if(O8)del(O8)

obj
	Projectiles
		Effects
			webshoot
				icon='Spider_Web.dmi'
				icon_state="throw"
				density=1
				layer=MOB_LAYER+2
				New()
					..()
					spawn(4)
						walk(src, src.dir)
					spawn(90)
						if(src) del(src)
				Bump(atom/O)
					if(!src.Hit)
						if(istype(O,/mob))
							var/mob/M=O
							if(M)
								if(M <> src.Owner)
									if(M.dead || M.key == src.name) return
									if(M.fightlayer==src.fightlayer)
										src.layer=MOB_LAYER+1
										if(M)
											walk(src, 0)
											src.icon_state = "stuck"
											flick("stuck",src)
											src.pixel_x -= 9
											src.loc = M.loc
											src.density=0
											AddState(M, new/state/cant_move, src.damage)
											AddState(M, new/state/cant_attack, src.damage)
											if(M.henge==4||M.henge==5)M.HengeUndo()
											spawn(src.damage)
												del(src)
			arrowshoot
				icon='SpiderJutsus.dmi'
				icon_state="arrowshoot"
				density=1
				layer=MOB_LAYER+2
				New()
					..()
					spawn(4)
						walk(src, src.dir)
					spawn(40)
						if(src) del(src)
				Bump(atom/O)
					if(!src.Hit)
						if(istype(O,/mob))
							var/mob/M=O
							if(M)
								if(M <> src.Owner)
									var/mob/Owner=src.Owner
									if(M.dead || M.key == src.name) return
									if(M.fightlayer==src.fightlayer)
									//	src.PlayAudio('knife_hit1.wav', output = AUDIO_HEARERS)
										src.layer=MOB_LAYER+1
										if(M)
											src.loc = M.loc
											AddState(M, new/state/cant_move, 5)
											M.DealDamage(src.damage,src.Owner,"NinBlue")
											if(Owner.loc.loc:Safe!=1) Owner.LevelStat("Ninjutsu",rand(3,5))
											if(M.henge==4||M.henge==5)M.HengeUndo()
											walk(src,src.dir)



mob
	var/tmp
		insage=0
		incurse=0
		ingpill=0
		inypill=0
		inrpill=0
		incalorie=0
		inboulder=0
		caged=0
		industprison=0
		ringed=0
		inAngel=0
		
mob
	Bump(M)
		if(src.inboulder==1)//boulderstuff
			if(istype(M,/mob/))
				src.density=0
				step(src,src.dir)
				step(src,src.dir)
				src.density=1
				M:DealDamage(round((src.ninjutsu_total / 450)+(src.taijutsu_total / 450)*2*300)/6,src,"TaiOrange")
		else
			..()

mob
	forjutsu
		mudwallmob
			icon=""
			density=1
			layer=999
			health=1500
			maxhealth=1500
			chakra=300
			maxchakra=300
			level=1
			exp=0
			maxexp=10
			ninjutsu=1
			ninexp=0
			maxninexp=10
			genjutsu=1
			genexp=0
			maxgenexp=10
			taijutsu=1
			editing=0
			taijutsuexp=0
			maxtaijutsuexp=10
			defence=1
			defexp=0
			maxdefexp=10
			agility=1
			agilityexp=0
			maxagilityexp=10
			New()
				spawn(100)
					del(src)

