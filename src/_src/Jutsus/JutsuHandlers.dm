var/jutsudamage=150 //A global variable to serve as the baseline for all jutsu damage forumla.(WIP)Changing this value will change the damage of all jutsu relative to it's value.
var/jutsustatexp=2 //A global vairable to act as a multiplier for the amount of stat exp gained when using jutsu
var/jutsumastery=2 //A global variable to act as a multiplier for the amount of exp a jutsu gains on use
var/jutsuchakra=50  //A global variable to act as the baseline for the amount of chakra jutsu cost to use
var/jutsucooldown=1  //A global variable to act as the baseline for the amount of chakra jutsu cost to use
var/punchstatexp=1.8 //A global vairable to act as a multiplier for the amount of stat exp gained when punching (2.5 once attack speed bug is fixed)
var/trainingexp=0.5 //A global variable to act as a multiplier for the amount of exp gained when using training methods
var/weapondamage=1 //A global variable to act as a multiplier for the amount of damage all weaponry deal (including swords)
var/handsealmastery=2 //A global bariable to act as a multiplier for the amount of uses a jutsu needs before it is hotkeyable

mob
	var
		tmp
			Stuck
			list/Clones = list()

mob
	proc
		PreJutsu(var/obj/Jutsus/J)
			if(CheckState(src, new/state/knocked_down)) return 0

			if(!src.canattack) return 0

			if(src.multisized == 1) return 0

			if(src.jutsu_cooldowns.Find(J)) return 0

			if(ChakraCheck(J.ChakraCost)) return 0

			J.JutsuCoolDown(src)

			J.uses ++
			
			return 1

		DealDamage(amount = 0, var/mob/Owner, colortype, heal = 0, chakra = 0, punch = 0)
		//	world << output("[amount], [Owner], [colortype], [heal], [chakra], [punch]")//DEBUG INFO
			ASSERT(Owner)
			if(src.bubbled==0)//bubbleshieldstuff
				if(src.dead)
					return
				if(istype(Owner, /mob/npc) && istype(src, /mob/npc)) return
				var/damage = round(amount) + round(rand(amount/15, amount/5))
				/*if(punch && bonesword)
					damage += round(src.strength * 0.1) // adds 10 dmg at 100 str and bonesword on
				if(punch && src.Gates>0)
					damage += round((src.strength * 0.1) * src.Gates)*/ // adds 50 damage at 100 str and gates 5
				if(heal)
					if(src.Intang)
						return
					src.health += damage
					if(src.health > src.maxhealth)
						src.health = src.maxhealth
				if(chakra)
					src.chakra -= damage
					if(src.chakra > src.maxchakra)
						src.chakra = src.maxchakra
					if(src.chakra < 0)
						src.chakra = 0
				if(!heal && !chakra)
					if(src.Intang)
						return
					if(src.multisized)
						damage = round(damage*0.3)
					src.health -= damage
					AddState(src, new/state/recently_hit, 60)
					AddState(src, new/state/in_combat, 100)
					if(Owner)
						AddState(Owner, new/state/in_combat, 100)
					if(src.health < 0)
						src.health = 0
					src.sleephits++
					src.last_damage_taken_time = world.timeofday
					if(Owner.village != VILLAGE_LEAF && src.village == VILLAGE_LEAF && src.z == 1)//infamy system
						if(!Owner.infamy_points) Owner.infamy_points++

					if(Owner.village != VILLAGE_SAND && src.village == VILLAGE_SAND && src.z == 2)//infamy system
						if(!Owner.infamy_points) Owner.infamy_points++
				src.UpdateHMB()
				spawn()
					var/colour = colour2html(colortype)
					DamageOverlay(src, damage, colour)
				spawn()
					src.Death(Owner)
			if(src.bubbled==1&&!heal&&!chakra)//bubbleshieldstuff
				src.bubbled=0


		BindStuck(time)
			src.Stuck ++
			src.move = 0
			src.firing = 1
			src.injutsu = 1
			src.canattack = 0
			sleep(time)
			src.Stuck --
			if(!src.Stuck)
				src.move = 1
				src.firing = 0
				src.injutsu = 0
				src.canattack = 1

		ChakraCheck(var/CHAKRA)
			var/area/T = loc.loc
			src.HengeUndo()
			if(Sleeping)
				return 1
			if(T)
				if(T.Safe)
					src<<output("You're indoors, you shouldn't be doing this.","Action.Output")
					return 1
			if(Disabled)
				src<<output("Your jutsus have been disabled right now.","Action.Output")
				return 1
			if(istype(loc,/turf/Arena)&&!opponent)
				src<<output("You can't attack people who aren't your opponent!","Action.Output")//These don't actually output anywhere.
				return 1
			if(Chuunins.Find(src)&&ChuuninOpponentOne!=src&&ChuuninOpponentTwo!=src)
				src<<output("Your jutsus have been disabled right now.","Action.Output")
				return
			if(!NaraTarget)
				if(src.firing == 1)
					return 1
				if(src.canattack == 0)
					return 1
			if(dead)
				return 1
			if(CHAKRA > src.chakra)
				src << output("<Font color=Aqua>You Need More Chakra([CHAKRA]).</Font>","Action.Output")
				return 1

			src.chakra -= CHAKRA

			src.UpdateHMB()


			// as a note, change "in world" for clones to "in src.Clones"
		CloneHandler() // add this to the beginning of each clone jutsu
			if(src.Clones.len)
				Clone_Jutsu_Destroy()
				src.Clones = list()

obj
	JutsuOverlays
		layer = 10001
		icon = 'Misc Effects.dmi'
		Cool1
			icon_state = "jutsuwait1"
		Cool2
			icon_state = "jutsuwait2"
		Cool3
			icon_state = "jutsuwait3"
		Cool4
			icon_state = "jutsuwait4"
obj
	var
		tmp
			cooltimer = 0
			maxcooltime
mob
	proc
		JutsuCoolSlot(obj/Jutsus/O)
			src.jutsu_cooldowns.Add(O)
			if(src.client)
				src.client.screen += O

			// Reorder Jutsu Cooldown List: Cooldown Timer Descending //

			for(var/i = 1, i <= src.jutsu_cooldowns.len, i++)

				for(var/next_index = 1, next_index <= src.jutsu_cooldowns.len, next_index++)

					var/obj/Jutsus/jutsu = src.jutsu_cooldowns[i]
					var/obj/Jutsus/jutsu_compare = src.jutsu_cooldowns[next_index]

					if(jutsu.cooltimer > jutsu_compare.cooltimer)
						src.jutsu_cooldowns.Swap(i, next_index)

			// Reorder Jutsu Cooldown HUD Objects //

			for(var/i = 1, i <= src.jutsu_cooldowns.len, i++)
				var/obj/Jutsus/jutsu = src.jutsu_cooldowns[i]
				if(src.client)
					jutsu.screen_loc = "[src.client.map_resolution_x - 2], [src.client.map_resolution_y - 1 - i]:-[i]"

			if(O.Clan == null)
				for(var/mob/M in range(10, src))
					if(M.jutsucopy == 1)
						var/X = O.type
						var/obj/Z = new X
						Z.invisibility = 1
						M.jutsucopy = Z
						M << output("Your sharingan copies [src]'s [O]","Action.Output")
obj
	Jutsus
		proc
			JutsuCoolDown(mob/m)
				spawn()
					src.cooltimer = src.maxcooltime

					m.JutsuCoolSlot(src)

					src.overlays = null

					src.SetName("[round(src.cooltimer/10, 1)]")
					src.name = initial(src.name)

					while(src && src.cooltimer && m && m.jutsu_cooldowns.Find(src))

						sleep(1)

						if(src && m)
							src.cooltimer--

							src.overlays = null

							src.SetName("[round(src.cooltimer/10, 1)]")
							src.name = initial(src.name)

							// Cooldown Color Indicator //
							/*
							if(src.cooltimer / src.maxcooltime >= 0.75)
								src.overlays += /obj/JutsuOverlays/Cool4

							else if(src.cooltimer / src.maxcooltime >= 0.50)
								src.overlays += /obj/JutsuOverlays/Cool3

							else if(src.cooltimer / src.maxcooltime >= 0.25)
								src.overlays += /obj/JutsuOverlays/Cool2
							
							else if(src.cooltimer / src.maxcooltime >= 0.10)
								src.overlays += /obj/JutsuOverlays/Cool1
							*/
					if(src)
						src.overlays = null
						src.name_overlays = null

					if(m)
						m.jutsu_cooldowns.Remove(src)

						if(m.client) m.client.screen -= src

						// Reorder Jutsu Cooldown List: Cooldown Timer Descending //

						for(var/i = 1, i <= m.jutsu_cooldowns.len, i++)
							for(var/next_index = 1, next_index <= m.jutsu_cooldowns.len, next_index++)

								var/obj/Jutsus/jutsu = m.jutsu_cooldowns[i]
								var/obj/Jutsus/jutsu_compare = m.jutsu_cooldowns[next_index]

								if(jutsu.cooltimer > jutsu_compare.cooltimer)
									m.jutsu_cooldowns.Swap(i, next_index)
						
						// Reorder Jutsu Cooldown HUD Objects //

						for(var/i = 1, i <= m.jutsu_cooldowns.len, i++)
							var/obj/Jutsus/jutsu = m.jutsu_cooldowns[i]
							if(m.client)
								jutsu.screen_loc = "[m.client.map_resolution_x - 2], [m.client.map_resolution_y - 1 - i]:-[i]"