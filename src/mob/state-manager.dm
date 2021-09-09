proc
	AddState(mob/m, var/state/s, var/duration = 0, mob/owner)
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
						break

			if(STATE_REMOVE_ANY)
				for(var/state/state in m.state_manager)
					if(state.type == s.type)
						m.state_manager.Remove(state)
						break

			if(STATE_REMOVE_ALL)
				for(var/state/state in m.state_manager)
					if(state.type == s.type)
						m.state_manager.Remove(state)

	CheckState(mob/m, var/state/s)
		if(locate(s.type) in m.state_manager) return 1
		else return 0

/state
	var/mob/mob
	var/mob/owner
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
	
	blocking
		OnTick()
			..()

	walking
		OnTick()
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

	poisoned
		var/delay
		OnTick()
			if(!delay) delay = world.timeofday + 10
			if(delay < world.timeofday)
				src.mob.DealDamage(src.mob.maxhealth / 200, src.owner, "NinBlue")
				delay = world.timeofday + 10
			..()

#ifdef STATE_MANAGER_DEBUG
mob
	verb
		Example()

			AddState(src, new/state/burn, 100)
			RemoveState(src, new/state/burn, STATE_REMOVE_ALL)

			AddState(src, new/state/stun, 20)
			if(CheckState(src, new/state/stun))
				src << "I'm stunned!"
			
			AddState(src, new/state/knock_down, 600)
			RemoveState(src, new/state/knock_down, STATE_REMOVE_ANY)

			var/state/knocked_back/e = new()
			AddState(src, e, 50)
			RemoveState(src, e, STATE_REMOVE_REF)
#endif