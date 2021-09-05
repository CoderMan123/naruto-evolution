#define EFFECTS

#define EFFECT_REMOVE_REF 1
#define EFFECT_REMOVE_ANY 2
#define EFFECT_REMOVE_ALL 3

proc
	AddEffect(mob/m, var/effect/e)
		e.mob = m
		e.mob.effects.Add(e)

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

	New(var/duration)
		src.duration = duration
		src.expiration = world.timeofday + src.duration
		..()

		spawn() src.Ticker()
	
	proc/Ticker()
		while(src && src.mob && world.timeofday < src.expiration)
			sleep(world.tick_lag)
			src.OnTick()

		src.mob.effects.Remove(src)
		src.mob = null

	proc/OnTick()
		..()

	stun
		OnTick()
			..()

	burn
		OnTick()
			..()

	knock_down
		OnTick()
			..()

	knock_back
		OnTick()
			..()

	cast_jutsu
		OnTick()
			..()

	dead
		OnTick()
			..()

	punch
		OnTick()
			..()
	
	block
		OnTick()
			..()

	walk
		OnTick()
			..()

#ifdef EFFECTS_DEBUG
mob
	verb
		Example()

			AddEffect(src, new/effect/burn(100))
			RemoveEffect(src, new/effect/burn, EFFECT_REMOVE_ALL)

			AddEffect(src, new/effect/stun(20))
			if(CheckEffect(src, new/effect/stun))
				src << "I'm stunned!"
			
			AddEffect(src, new/effect/knock_down(600))
			RemoveEffect(src, new/effect/knock_down, EFFECT_REMOVE_ANY)

			var/effect/knocked_back/e = new(50)
			AddEffect(src, e)
			RemoveEffect(src, e, EFFECT_REMOVE_REF)
#endif