obj
	Overlays
		DummyDust
			icon='Dust.dmi'
			icon_state="spin"
			pixel_x=-34
			pixel_y=3
			layer=MOB_LAYER+1
	
	precision_training_blocker
		icon = 'placeholdertiles.dmi'
		icon_state = "precisiontrainblocker"

		New()
			..()
			icon_state = "blank"

		Cross(atom/o)
			if(istype(o, /obj/Projectiles/Weaponry/Needle) || istype(o, /obj/Projectiles/Weaponry/Shuriken) || istype(o, /obj/Projectiles/Weaponry/Kunai))
				return ..()
			else return 0

turf
	Sliding_Target_Track
		icon = 'Sliding_Target_Track.dmi'

		top
			icon_state = "top"

		middle
			icon_state = "middle"

		bottom
			icon_state = "bottom"


mob
	training
		untargetable
			Sliding_Target
				health=20000
				maxhealth=20000
				strength=0
				agility=0
				icon='Sliding_Target.dmi'
				icon_state="idle"
				var/slide_speed = 2
				var/slide_distance = 10
				var/step_counter = 0

				New()
					..()
					src.TargetAI()

				Cross(atom/o)
					var/obj/O = o
					var/mob/M = O.Owner
					if(istype(o, /obj/Projectiles/Weaponry/Needle))
						M.LevelStat("Precision", (rand(150, 200)*trainingexp))
					if(istype(o, /obj/Projectiles/Weaponry/Shuriken))
						M.LevelStat("Precision", (rand(200, 300)*trainingexp))
					if(istype(o, /obj/Projectiles/Weaponry/Kunai))
						M.LevelStat("Precision", (rand(300, 400)*trainingexp))

				Move()
					return

				proc
					TargetAI()
						while(src)
							sleep(slide_speed)
							switch(src.dir)
								if(SOUTH)
									src.loc = locate(src.x, src.y-1, src.z)
									step_counter++
									if(step_counter >= 10)
										step_counter = 0
										src.dir = NORTH
										slide_speed = rand(10, 20)/10
								if(NORTH)
									src.loc = locate(src.x, src.y+1, src.z)
									step_counter++
									if(step_counter >= 10)
										step_counter = 0
										src.dir = SOUTH
										slide_speed = rand(10, 20)/10

	training
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
							M.DealDamage(src.strength*8,src,"NinBlue")
							
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
						src.health = src.maxhealth
						sleep(5-(round(src.agility / 150)*3)+rand(3, 6))


