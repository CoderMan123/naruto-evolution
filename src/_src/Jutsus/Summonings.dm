mob
	summonings
		SnakeSummoning
			icon='Pein Summoning.dmi'
			Names="Snake"
			health=3000
			maxhealth=3000
			icon_state="2"
			density=1
			var/mob/lowner
			New()
				spawn(1)
					src.SnakeCombat()
				..()
			proc
				SnakeCombat()
					while(src)
						var/mob/c_target=lowner.Target_Get(TARGET_MOB)
						if(c_target&&c_target==src) return
						sleep(1)
						if(c_target)
							if(src.health<=0)
								del(src)
							src.Move()
							step_towards(src,c_target)
							if(get_dist(src,c_target)<=1)
								if(c_target.dead==1) return
								src.Strike(c_target)
							sleep(4)
						sleep(1)
				Strike(mob/A)
					A.DealDamage((jutsudamage+round((lowner.ninjutsu / 150)*2*jutsudamage))/4,src.lowner,"cyan")
					if(A) A.UpdateHMB()
		DogSummoning
			icon='Pein Summoning.dmi'
			icon_state="1"
			density=1
			var/mob/lowner
			New()
				spawn(1)
					src.SnakeCombat()
				..()
			proc
				SnakeCombat()
					while(src)
						var/mob/c_target=lowner.Target_Get(TARGET_MOB)
						if(c_target&&c_target==src) return
						sleep(1)
						if(c_target)
							if(src.health<=0)
								del(src)
							src.Move()
							step_towards(src,c_target)
							if(get_dist(src,c_target)<=1)
								if(c_target.dead==1) return
								src.Strike(c_target)
							sleep(4)
						sleep(1)
				Strike(mob/A)
					A.DealDamage(lowner.strength+lowner.ninjutsu+lowner.genjutsu,src.lowner,"cyan")
					if(A) A.UpdateHMB()


mob
	jutsus
		var/mob/OWNER
		KazekagePuppet
			icon='Kazekage Puppet.dmi'
			Names="Kazekage Puppet"
			health=2300
			maxhealth=2300
			var/hited=0
			move=0
			Bump(mob/M)
				if(src.hited==1) return
				if(istype(M,/mob/White_Zettsu/))
					M.DealDamage((jutsudamage+round(((OWNER.ninjutsu / 300)+(OWNER.precision / 300))*2*jutsudamage))/3,src.OWNER,"NinBlue")
					//if(M.health >= 0) M.Death()
					//M.Death(src)

				if(istype(M,/mob/))
					flick("punch",src)
					M.DealDamage((jutsudamage+round(((OWNER.ninjutsu / 300)+(OWNER.precision / 300))*2*jutsudamage))/3,src.OWNER,"NinBlue")
					//if(M.health >= 0) M.Death()
					//M.Death(src)

					src.hited=1
					sleep(7)
					src.hited=0
				else
					return
			Move()
				//sleep(3)
				if(src.move==1)
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
			strength=0
			var/hited=0
			pixel_y=-40
			pixel_x=-40
			move=0
			Bump(mob/M)
				if(src.hited==1) return
				if(istype(M,/mob/White_Zettsu/))
					M.DealDamage(src.strength,src.OWNER,"TaiOrange")

				if(istype(M,/mob/))
					//flick("punch",src)
					M.DealDamage(src.strength,src.OWNER,"TaiOrange")
					src.hited=1
					sleep(7)
					src.hited=0
				else
					return
			Move()
				if(src.move==1)
					return
				..()
			New()
				spawn(5)//leave 5 here so that it doesnt throw out an run time error caused by target_get proc which is instantly called when summoned and it appears that in jutsu itself owner is defined a split second later lol so theres null.target_get lmao! XD
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