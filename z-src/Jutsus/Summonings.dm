mob
	summonings
		var/mob/OWNER
		SnakeSummoning
			icon='Pein Summoning.dmi'
			Names="Snake"
			health=1500
			maxhealth=1500
			icon_state="2"
			var/hited=0
			Bump(mob/M)
				if(src.hited==1) return
				if(istype(M,/mob/) || istype(M,/mob/npc/combat))
					flick("punch",src)
					M.DealDamage((jutsudamage+round((OWNER.ninjutsu_total / 200)*2*jutsudamage))/3,src.OWNER,"NinBlue")
					//if(M.health >= 0) M.Death()
					//M.Death(src)

					src.hited=1
					sleep(7)
					src.hited=0
				else
					return
			Move()
				//sleep(3)
				if(!CheckState(src, new/state/cant_move))
					return
				..()
			New()
				spawn(5)

					src.CombatAI()
				..()

		DogSummoning
			icon='Pein Summoning.dmi'
			Names="Dog"
			health=1500
			maxhealth=1500
			icon_state="1"
			var/hited=0
			Bump(mob/M)
				if(src.hited==1) return
				if(istype(M,/mob/) || istype(M,/mob/npc/combat))
					flick("punch",src)
					M.DealDamage((jutsudamage+round(((OWNER.ninjutsu_total / 450)+(Owner.taijutsu_total / 450)+(OWNER.genjutsu_total / 450))*2*jutsudamage))/3,src.OWNER,"NinBlue")
					//if(M.health >= 0) M.Death()
					//M.Death(src)

					src.hited=1
					sleep(7)
					src.hited=0
				else
					return
			Move()
				//sleep(3)
				if(!CheckState(src, new/state/cant_move))
					return
				..()
			New()
				spawn(5)

					src.CombatAI()
				..()

mob/summonings/proc/CombatAI()
	while(src)
		var/mob/c_target=OWNER.Target_Get(TARGET_MOB)
		if(c_target&&c_target==src) return
		sleep(1)
		if(c_target)
			if(src.health<=0)
				del(src)
			src.Move()
			step_towards(src,c_target)
			if(get_dist(src,c_target)<=1)
				if(c_target.dead==1) return
				Bump(c_target)
			sleep(4)
		sleep(1)

mob
	jutsus
		var/mob/OWNER
		KazekagePuppet
			icon='Kazekage Puppet.dmi'
			Names="Kazekage Puppet"
			health=2300
			maxhealth=2300
			var/hited=0
			Bump(mob/M)
				if(src.hited==1) return
				if(istype(M,/mob/) || istype(M,/mob/npc/combat))
					flick("punch",src)
					M.DealDamage((jutsudamage+round(((OWNER.ninjutsu_total / 300)+(OWNER.precision_total / 300))*2*jutsudamage))/3,src.OWNER,"NinBlue")
					//if(M.health >= 0) M.Death()
					//M.Death(src)

					src.hited=1
					sleep(7)
					src.hited=0
				else
					return
			Move()
				if(!CheckState(src, new/state/cant_move))
					return
				..()
			New()
				spawn(5)

					src.CombatAI()
				..()
		Summon_Spider
			icon='SpiderS.dmi'
			Names="Huge Spider"
			health=1200
			maxhealth=1200
			taijutsu=0
			var/hited=0
			pixel_y=-40
			pixel_x=-40
			Bump(mob/M)
				if(src.hited==1) return
				if(istype(M,/mob/) || istype(M,/mob/npc/combat))
					//flick("punch",src)
					M.DealDamage(src.taijutsu_total,src.OWNER,"TaiOrange")
					src.hited=1
					sleep(7)
					src.hited=0
				else
					return
			Move()
				if(!CheckState(src, new/state/cant_move))
					return
				..()
			New()
				spawn(5)//here to avoid a race condition with target_get
					src.CombatAI()
				..()


mob/jutsus/proc/CombatAI()
	while(src)
		var/mob/c_target=OWNER.Target_Get(TARGET_MOB)
		if(c_target&&c_target==src) return
		sleep(1)
		if(c_target)
			if(src.health<=0)
				del(src)
			src.Move()
			step_towards(src,c_target)
			if(get_dist(src,c_target)<=1)
				if(c_target.dead==1) return
				Bump(c_target)
			sleep(4)
		sleep(1)