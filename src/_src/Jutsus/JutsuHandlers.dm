mob
	var
		tmp
			Stuck
			list/Clones = list()

mob
	proc
		PreJutsu(var/obj/Jutsus/J)
			if(J.Excluded)
			//	src << output("returning 0 Ex","Action.Output")
				return 0
			if(ChakraCheck(J.ChakraCost))
			//	src << output("returning 0 CC","Action.Output")
				return 0
			J.Excluded = 1
			J.uses ++
			src.UpdateHMB()
			src.JutsuCoolSlot(J)
			spawn()
				J.cooltimer = J.maxcooltime
				J.JutsuCoolDown(src)
			//	src << output("Cooldown","Action.Output")
			//src << output("returning 1","Action.Output")
			return 1

		DealDamage(amount = 0, Owner, colortype, heal = 0, chakra = 0, punch = 0)
		//	world << output("[amount], [Owner], [colortype], [heal], [chakra], [punch]")//DEBUG INFO
			if(src.dead)
				return
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
			if(!heal && !chakra)//should fix heal.
				if(src.Intang)
					return
				src.health -= damage
				if(src.health < 0)
					src.health = 0
			src.UpdateHMB()
			spawn()
				var/colour = colour2html(colortype)
				src.DamageOverlay(damage, colour)
			spawn()
				src.Death(Owner)

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

			// as a note, change "in world" for clones to "in src.Clones"
		CloneHandler() // add this to the beginning of each clone jutsu
			if(src.Clones.len)
				Clone_Jutsu_Destroy()
				src.Clones = list()

obj
	JutsuOverlays
		layer = 9999
		icon = 'Misc Effects.dmi'
		Cool1
			icon_state = "jutsuwait1"
		Cool2
			icon_state = "jutsuwait2"
		Cool3
			icon_state = "jutsuwait3"
		Cool4
			icon_state = "jutsuwait4"
mob
	var
		tmp
			waitslot = 0
obj
	var
		tmp
			cooltimer = 0
			maxcooltime
mob
	proc
		JutsuCoolSlot(obj/Jutsus/O)
			if(waitslot >= src.YView) return
			src.waitslot ++
			O.screen_loc = "[src.XView-2],[src.YView-1-src.waitslot]"
			src.client.screen += O
			if(O.Clan == null)
				for(var/mob/M in range(10, src))
					if(M.jutsucopy == 1)
						var/X = O.type
						var/obj/Z = new X
						Z.invisibility = 1
						M.jutsucopy = Z
						M << output("Your sharingan copies [src]'s [O]","Action.Output")
obj
	proc
		JutsuCoolDown(mob/O)
			while(O && src)
				sleep(1)
				if(src.Excluded)
					src.overlays = 0
					src.cooltimer --
					if(src.cooltimer >= round(src.maxcooltime/1.2))
						src.overlays += /obj/JutsuOverlays/Cool4/
					if(src.cooltimer > round(src.maxcooltime/2) && src.cooltimer < round(src.maxcooltime/1.2))
						src.overlays += /obj/JutsuOverlays/Cool3/
					if(src.cooltimer <= round(src.maxcooltime/2) && src.cooltimer > round(src.maxcooltime/6))
						src.overlays += /obj/JutsuOverlays/Cool2/
					if(src.cooltimer <= round(src.maxcooltime/6))
						src.overlays += /obj/JutsuOverlays/Cool1/
					if(src.cooltimer <= 0)
						src.overlays = 0
						O.client.screen -= src
						O.waitslot --
						src.Excluded = 0
						break
					continue