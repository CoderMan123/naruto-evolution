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
		strength=1
		agility=1
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
				src.overlays+=/obj/Overlays/DummyDust
				spawn(8) src.overlays-=/obj/Overlays/DummyDust
				flick("spin", src)
				for(var/mob/M in orange(1, src))
					if(!M.dodge)
						M.DealDamage(src.strength*10,src,"NinBlue")
						M.icon_state="dead"
						M.move=0
						M.injutsu=1
						M.canattack=0
						step_away(M, src, 3)
						src.agility=1
						src.strength=1
						spawn(50)
							M.icon_state=""
							M.move=1
							M.injutsu=0
							M.canattack=1
					else
						flick("dodge",M)
						if(M.loc.loc:Safe!=1) M.LevelStat("Defence",rand(30,50)+round(src.strength/2))
						if(M.loc.loc:Safe!=1) M.LevelStat("Strength",rand(30,50)+round(src.strength/2))
						src.agility++
						src.strength++

		proc
			DummyAI()
				src.dummylocation = src.loc
				while(src)
					icon_state="idle"
					if(prob(30+((src.agility / 150)*70)) && src.health!=src.maxhealth)
						src.SpinAttack()
					src.health=src.maxhealth
					sleep(10-(round(src.agility / 150)*3))


