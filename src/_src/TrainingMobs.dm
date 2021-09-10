obj
	Overlays
		DummyDust
			icon='Dust.dmi'
			icon_state="spin"
			pixel_x=-34
			pixel_y=3
			layer=MOB_LAYER+1

mob
	Rotating_Dummy
		health=20000
		maxhealth=20000
		strength=0
		agility=0
		icon='RotatingDummy.dmi'
		icon_state="idle"

		New()
			..()
			src.DummyAI()

		Move()
			return

		Death()
			return

		proc
			SpinAttack()
				flick("flash", src)

				sleep(10)

				src.overlays += /obj/Overlays/DummyDust
				spawn(8) src.overlays -= /obj/Overlays/DummyDust

				flick("spin", src)

				for(var/mob/M in orange(1, src))
					if(!M.dodge)
						M.DealDamage(src.strength*10,src,"NinBlue")
						
						AddState(M, new/state/knocked_down, 50)

						step_away(M, src, 3)

						src.agility=0
						src.strength=0

					else
						flick("dodge",M)

						if(M.loc.loc:Safe != 1) M.LevelStat("Defence", (rand(60,70) + round(src.strength / 2) * trainingexp))
						if(M.loc.loc:Safe != 1) M.LevelStat("Strength", (rand(60,70) + round(src.strength / 2) * trainingexp))

					if(src.agility < 150)
						src.agility += 10
					if(src.strength < 150)
						src.strength += 10
				RemoveState(src, new/state/dummy_was_hit, STATE_REMOVE_ALL)

		proc
			DummyAI()
				src.dummylocation = src.loc
				while(src)
					icon_state="idle"
					if(prob(30+((src.agility / 150)*70)) && src.health != src.maxhealth)
						if(CheckState(src, new/state/dummy_was_hit))
							src.SpinAttack()
					src.health=src.maxhealth
					sleep(5-(round(src.agility / 150)*3)+rand(3, 6))


