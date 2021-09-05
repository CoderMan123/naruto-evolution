#define EFFECTS

#define EFFECT_REMOVE_REF 1
#define EFFECT_REMOVE_ANY 2
#define EFFECT_REMOVE_ALL 3

proc
	AddEffect(mob/m, var/effect/e, var/duration = 0)
		e.mob = m
		e.duration = duration
		e.expiration = world.timeofday + e.duration
		e.mob.effects.Add(e)
		spawn() e.Ticker()

	RemoveEffect(mob/m, var/effect/e, var/remove_action = EFFECT_REMOVE_REF)
		switch(remove_action)
			if(EFFECT_REMOVE_REF)
				for(var/effect/effect in m.effects)
					if(effect == e)
						m.effects.Remove(e)
						break

			if(EFFECT_REMOVE_ANY)
				for(var/effect/effect in m.effects)
					if(effect.type == e.type)
						m.effects.Remove(e)
						break

			if(EFFECT_REMOVE_ALL)
				for(var/effect/effect in m.effects)
					if(effect.type == e.type)
						m.effects.Remove(e)

	CheckEffect(mob/m, var/effect/e)
		if(locate(e.type) in m.effects) return 1
		else return 0

/effect
	var/mob/mob
	var/duration
	var/expiration

	New()
		..()
	
	proc/Ticker()
		while(src && src.mob && world.timeofday < src.expiration || src.duration == -1)
			sleep(world.tick_lag)
			src.OnTick()
		
		if(src && src.mob)
			src.mob.effects.Remove(src)
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
			if(m && !CheckEffect(m, new/effect/casting_jutsu) && !CheckEffect(m, new/effect/knocked_down) && !CheckEffect(m, new/effect/knocked_back) && !CheckEffect(m, new/effect/dead))
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
		OnTick()
			..()
	
	blocking
		OnTick()
			..()

	walking
		OnTick()
			..()

#ifdef EFFECTS_DEBUG
mob
	verb
		Example()

			AddEffect(src, new/effect/burn, 100)
			RemoveEffect(src, new/effect/burn, EFFECT_REMOVE_ALL)

			AddEffect(src, new/effect/stun, 20)
			if(CheckEffect(src, new/effect/stun))
				src << "I'm stunned!"
			
			AddEffect(src, new/effect/knock_down, 600)
			RemoveEffect(src, new/effect/knock_down, EFFECT_REMOVE_ANY)

			var/effect/knocked_back/e = new()
			AddEffect(src, e, 50)
			RemoveEffect(src, e, EFFECT_REMOVE_REF)
#endif