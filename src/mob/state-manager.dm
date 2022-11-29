proc
	AddState(mob/m, var/state/s, var/duration = 0, mob/owner)
		// var/duration = -1 for unlimited duration
		s.mob = m
		if(owner) s.owner = owner
		s.duration = duration
		s.expiration = world.timeofday + s.duration
		s.mob.state_manager.Add(s)
		spawn() s.Ticker()

	RemoveState(mob/m, var/state/s, var/remove_action = STATE_REMOVE_REF)
		switch(remove_action)
			if(STATE_REMOVE_REF)
				for(var/state/state in m.state_manager)
					if(state == s)
						m.state_manager.Remove(s)
						s.duration = 0
						break

			if(STATE_REMOVE_ANY)
				for(var/state/state in m.state_manager)
					if(state.type == s.type)
						m.state_manager.Remove(state)
						state.duration = 0
						break

			if(STATE_REMOVE_ALL)
				for(var/state/state in m.state_manager)
					if(state.type == s.type)
						m.state_manager.Remove(state)
						state.duration = 0

	CheckState(mob/m, var/state/s)
		if(locate(s.type) in m.state_manager) return 1
		else return 0

/state
	var/mob/mob
	var/mob/owner
	var/mob/Owner
	var/duration
	var/expiration

	New()
		..()

	proc/Ticker()
		while(src && src.mob && src.mob.state_manager.Find(src) && world.timeofday < src.expiration || src.duration == -1)
			sleep(world.tick_lag)
			src.OnTick()

		if(src && src.mob)
			src.mob.state_manager.Remove(src)
			src.mob = null

		if(src && src.owner)
			src.owner = null

	proc/OnTick()
		..()

	stunned
		OnTick()
			..()

	burning
		OnTick()
			..()

	knocked_down
		Ticker()
			var/mob/m = src.mob
			if(m) m.icon_state = "dead"
			..()
			if(m && !CheckState(m, new/state/casting_jutsu) && !CheckState(m, new/state/knocked_down) && !CheckState(m, new/state/knocked_back) && !CheckState(m, new/state/dead))
				m.icon_state = ""

		OnTick()
			..()

	knocked_back
		OnTick()
			..()

	casting_jutsu
		OnTick()
			..()

	dead
		OnTick()
			..()

	punching

	throwing

	blocking
		OnTick()
			..()

	walking
		OnTick()
			..()

	swimming

	water_walking
	
	intangible
		var/delay
		OnTick()
			if(!delay) delay = world.timeofday + 10
			if(delay < world.timeofday)
				AddState(src.mob, new/state/cant_attack, 20)
				delay = world.timeofday + 10
			..()

	in_warp_dimension
		Ticker()
			var/mob/m = src.mob
			var/victims_previous_loc = m.loc
			m.loc = locate(165,183,8)
			..()
			if(m)
				m<<output("The warp dimension couldn't hold you any longer!","Action.Output")
				m.loc = victims_previous_loc

	in_combat

	nara_attack_delay

	casting_shadow_extension

	FTG_Kunai_Mark
		Ticker()
			var/mob/m = src.mob
			var/obj/mark = new()
			mark.icon = 'YellowFlashKunai.dmi'
			mark.icon_state = "marked"
			mark.pixel_y=88
			mark.pixel_x=16
			m.overlays += mark
			..()
			if(m && mark)
				m.overlays -= mark
				del mark
				

	poisoned
		var/delay
		OnTick()
			if(!delay) delay = world.timeofday + 10
			if(delay < world.timeofday)
				src.mob.DealDamage(src.mob.maxhealth / 200, src.owner, "NinBlue")
				delay = world.timeofday + 10
			..()

	cant_move
		Ticker()
			if(src.owner && src.owner != src.mob)
				if(src.duration > 0)
					src.expiration -= (src.duration/100)*src.mob.tenacity
					src.mob.tenacity += round(src.duration*0.5)
					if(src.mob.tenacity > 75) src.mob.tenacity = 75
			walk(src.mob, 0)
			..()

	cant_attack
		Ticker()
			if(src.owner && src.owner != src.mob)
				if(src.duration > 0)
					src.expiration -= (src.duration/100)*src.mob.tenacity
					src.mob.tenacity += round(src.duration*0.5)
					if(src.mob.tenacity > 75) src.mob.tenacity = 75
			walk(src.mob, 0)
			..()

	knockback
		Ticker()
			var/mob/m = src.mob
			m.icon_state="push"
			walk(m, owner.dir)
			if(m.client)spawn()m.ScreenShake(duration)
			..()
			walk(m, 0)
			if(!CheckState(m, new/state/swimming))m.icon_state=""

	knockback_immune

	sand_shield

	sleeping

	bleeding
		var/delay
		OnTick()
			if(!delay) delay = world.timeofday + 10
			if(delay < world.timeofday)
				src.mob.DealDamage(src.mob.maxhealth / 800, src.owner, "NinBlue")
				src.mob.Bleed()
				delay = world.timeofday + 10
			..()

	slowed

	dummy_was_hit

	recently_hit

	AI_is_punching

// Iron Fist Clan

	Iron_Fists
		proc/setanchors()
			switch(src.mob.dir)
				if(NORTH)
					src.mob.left_iron_fist_anchor = locate(src.mob.x - 1, src.mob.y, src.mob.z)
					src.mob.right_iron_fist_anchor = locate(src.mob.x + 1, src.mob.y, src.mob.z)
				if(NORTHEAST)
					src.mob.left_iron_fist_anchor = locate(src.mob.x - 1, src.mob.y + 1, src.mob.z)
					src.mob.right_iron_fist_anchor = locate(src.mob.x + 1, src.mob.y - 1, src.mob.z)
				if(EAST)
					src.mob.left_iron_fist_anchor = locate(src.mob.x, src.mob.y + 1, src.mob.z)
					src.mob.right_iron_fist_anchor = locate(src.mob.x, src.mob.y - 1, src.mob.z)
				if(SOUTHEAST)
					src.mob.left_iron_fist_anchor = locate(src.mob.x + 1, src.mob.y + 1, src.mob.z)
					src.mob.right_iron_fist_anchor = locate(src.mob.x - 1, src.mob.y - 1, src.mob.z)
				if(SOUTH)
					src.mob.left_iron_fist_anchor = locate(src.mob.x + 1, src.mob.y, src.mob.z)
					src.mob.right_iron_fist_anchor = locate(src.mob.x - 1, src.mob.y, src.mob.z)
				if(SOUTHWEST)
					src.mob.left_iron_fist_anchor = locate(src.mob.x + 1, src.mob.y - 1, src.mob.z)
					src.mob.right_iron_fist_anchor = locate(src.mob.x - 1, src.mob.y + 1, src.mob.z)
				if(WEST)
					src.mob.left_iron_fist_anchor = locate(src.mob.x, src.mob.y - 1, src.mob.z)
					src.mob.right_iron_fist_anchor = locate(src.mob.x, src.mob.y + 1, src.mob.z)
				if(NORTHWEST)
					src.mob.left_iron_fist_anchor = locate(src.mob.x - 1, src.mob.y - 1, src.mob.z)
					src.mob.right_iron_fist_anchor = locate(src.mob.x + 1, src.mob.y - 1, src.mob.z)
		var/delay
		Ticker()
			src.setanchors()
			..()

		OnTick()
			if(!delay) delay = world.timeofday + 0.5
			if(delay < world.timeofday)
				src.setanchors()
				delay = world.timeofday + 0.5
			..()
	
	Iron_Fist_Punching_Left

	Iron_Fist_Grabbing_Left

	Iron_Fist_Grabbed_Left

	Iron_Fist_Punching_Right

	Iron_Fist_Grabbing_Right

	Iron_Fist_Grabbed_Right

	Iron_Fist_Spinning

#ifdef STATE_MANAGER_DEBUG
mob
	verb
		State_Manager_Stress_Test()
			set category = "Debug"
			var/count = input("How many states would you like to add?") as null|num
			if(count)
				for(var/i = 0, i < count, i++)
					AddState(src, new/state/knocked_down, 10)

		Example()
			set category = "Debug"
			AddState(src, new/state/burning, 100)
			RemoveState(src, new/state/burning, STATE_REMOVE_ALL)

			AddState(src, new/state/stunned, 20)
			if(CheckState(src, new/state/stunned))
				src << "I'm stunned!"

			AddState(src, new/state/knocked_down, 600)
			RemoveState(src, new/state/knocked_down, STATE_REMOVE_ANY)

			var/state/knocked_back/e = new()
			AddState(src, e, 50)
			RemoveState(src, e, STATE_REMOVE_REF)
#endif