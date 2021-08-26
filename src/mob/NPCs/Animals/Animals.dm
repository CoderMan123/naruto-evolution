var/tmp/squirrel_count = 0
var/tmp/chipmonk_count = 0
var/tmp/hedgehog_count = 0
var/tmp/hare_count = 0
var/tmp/rabbit_count = 0
var/tmp/doe_count = 0
var/tmp/buck_count = 0
var/tmp/snake_count = 0
var/list/animal_spawns = list()
var/list/desert_animal_spawns = list()

proc/AnimalPopulater()
	while(world)
		for(var/obj/animalspawn/s)
			animal_spawns += s
		for(var/obj/animalspawndesert/s)
			desert_animal_spawns += s
		if(squirrel_count < 10)
			var/amount_to_spawn = 10 - squirrel_count
			for(amount_to_spawn, amount_to_spawn > 0, amount_to_spawn--)
				var/obj/animalspawn/spawn_location = pick(animal_spawns)
				new/mob/npc/combat/animals/small/squirrel(spawn_location.loc)
		if(chipmonk_count < 10)
			var/amount_to_spawn = 10 - chipmonk_count
			for(amount_to_spawn, amount_to_spawn > 0, amount_to_spawn--)
				var/obj/animalspawn/spawn_location = pick(animal_spawns)
				new/mob/npc/combat/animals/small/chipmonk(spawn_location.loc)
		if(hedgehog_count < 4)
			var/amount_to_spawn = 4 - hedgehog_count
			for(amount_to_spawn, amount_to_spawn > 0, amount_to_spawn--)
				var/obj/animalspawn/spawn_location = pick(animal_spawns)
				new/mob/npc/combat/animals/small/hedgehog(spawn_location.loc)
		if(hare_count < 10)
			var/amount_to_spawn = 10 - hare_count
			for(amount_to_spawn, amount_to_spawn > 0, amount_to_spawn--)
				var/obj/animalspawn/spawn_location = pick(animal_spawns)
				new/mob/npc/combat/animals/small/hare(spawn_location.loc)
		if(rabbit_count < 10)
			var/amount_to_spawn = 10 - rabbit_count
			for(amount_to_spawn, amount_to_spawn > 0, amount_to_spawn--)
				var/obj/animalspawn/spawn_location = pick(animal_spawns)
				new/mob/npc/combat/animals/small/rabbit(spawn_location.loc)
		if(doe_count < 8)
			var/amount_to_spawn = 8 - doe_count
			for(amount_to_spawn, amount_to_spawn > 0, amount_to_spawn--)
				var/obj/animalspawn/spawn_location = pick(animal_spawns)
				new/mob/npc/combat/animals/doe(spawn_location.loc)
		if(buck_count < 8)
			var/amount_to_spawn = 8 - buck_count
			for(amount_to_spawn, amount_to_spawn > 0, amount_to_spawn--)
				var/obj/animalspawn/spawn_location = pick(animal_spawns)
				new/mob/npc/combat/animals/buck(spawn_location.loc)
		if(snake_count < 20)
			var/amount_to_spawn = 20 - snake_count
			for(amount_to_spawn, amount_to_spawn > 0, amount_to_spawn--)
				var/obj/animalspawndesert/spawn_location = pick(desert_animal_spawns)
				new/mob/npc/combat/animals/snake(spawn_location.loc)
		sleep(600*3)




mob
	npc
		combat
			animals
				small

					squirrel
						icon = 'Squirrel.dmi'
						health = 20
						maxhealth = 20
						exp_reward = 2
						var/tmp/mob/target
						var/retreating = 0
						var/tmp/climbing = 0
						var/tmp/tree_location
						var/tmp/scarred = 0
						var/tmp/idle = 0

						SetName()
							return

						New()
							..()
							src.overlays-=/obj/MaleParts/UnderShade
							src.pixel_x = 0
							src.overlays+=/obj/MaleParts/UnderShadeSmall
							squirrel_count++
							src.ryo = rand(10,30)
							spawn() src.CombatAI()

						Move()
							..()
							if(!climbing)
								src.FindTarget()
								if(src.retreating)
									for(var/obj/Ground/Trees/T in orange(10))
										if(T)
											tree_location = T.loc
											walk_to(src, T)
											break

						Death(killer)
							..()
							if(src.health <= 0)
								squirrel_count--

						proc/Idle()
							src.idle = 1
							src.retreating = 0
							src.target = null
							walk_rand(src,8)

						proc/CombatAI()
							while(src)
								if(!src.dead && !src.climbing)
									if(!src.retreating && get_dist(src,src.target) <= 10) src.Retreat(src.target)
									if(tree_location && get_dist(src, tree_location) <= 1) src.TreeClimb()
									if(get_dist(src,src.target) <= 1) src.StopInFear(src.target)
									if(get_dist(src,src.target) > 10 && !src.idle) src.Idle()
								else if(!src.dead && !src.climbing && !src.idle) src.Idle()
								sleep(2)

						proc/FindTarget()
							if(src)
								for(var/mob/M in orange(10))
									if(istype(M,/mob/npc) || istype(M,/mob/Rotating_Dummy) || M.dead) continue
									if(M)
										src.target = M
									else src.target = null

						proc/Retreat(mob/M)
							if(src && M)
								src.idle = 0
								src.retreating = 1
								walk_away(src,M,11,1)
								src.FindTarget()

						proc/TreeClimb()
							src.climbing = 1
							layer = MOB_LAYER+7
							walk(src, 0)
							src.loc = tree_location
							if(src.dir == NORTH || src.dir == WEST)
								icon_state = "climbright"
							if(src.dir == SOUTH || src.dir == EAST)
								icon_state = "climbleft"
							step(src,NORTH)
							sleep(2)
							step(src,NORTH)
							sleep(2)
							step(src,NORTH)
							del src

						proc/StopInFear(mob/M)
							src.idle = 0
							src.retreating = 0
							src.scarred = 1
							walk(src,0)
							sleep(3)
							src.Retreat(M)

					chipmonk
						icon = 'Chipmonk.dmi'
						health = 20
						maxhealth = 20
						exp_reward = 2
						var/tmp/mob/target
						var/retreating = 0
						var/tmp/climbing = 0
						var/tmp/tree_location
						var/tmp/scarred = 0
						var/tmp/idle = 0

						SetName()
							return

						New()
							..()
							src.overlays-=/obj/MaleParts/UnderShade
							src.pixel_x = 0
							src.overlays+=/obj/MaleParts/UnderShadeSmall
							chipmonk_count++
							src.ryo = rand(10,30)
							spawn() src.CombatAI()

						Move()
							..()
							if(!climbing)
								src.FindTarget()
								if(src.retreating)
									for(var/obj/Ground/Trees/T in orange(10))
										if(T)
											tree_location = T.loc
											walk_to(src, T)
											break

						Death(killer)
							..()
							if(src.health <= 0)
								chipmonk_count--

						proc/Idle()
							src.idle = 1
							src.retreating = 0
							src.target = null
							walk_rand(src,8)

						proc/CombatAI()
							while(src)
								if(!src.dead && !src.climbing)
									if(!src.retreating && get_dist(src,src.target) <= 10) src.Retreat(src.target)
									if(tree_location && get_dist(src, tree_location) <= 1) src.TreeClimb()
									if(get_dist(src,src.target) <= 1) src.StopInFear(src.target)
									if(get_dist(src,src.target) > 10 && !src.idle) src.Idle()
								else if(!src.dead && !src.climbing && !src.idle) src.Idle()
								sleep(2)

						proc/FindTarget()
							if(src)
								for(var/mob/M in orange(10))
									if(istype(M,/mob/npc) || istype(M,/mob/Rotating_Dummy) || M.dead) continue
									if(M)
										src.target = M
									else src.target = null

						proc/Retreat(mob/M)
							if(src && M)
								walk_away(src,M,11,1)
								src.idle = 0
								src.retreating = 1
								src.FindTarget()

						proc/TreeClimb()
							src.climbing = 1
							layer = MOB_LAYER+7
							walk(src, 0)
							src.loc = tree_location
							if(src.dir == NORTH || src.dir == WEST)
								icon_state = "climbright"
							if(src.dir == SOUTH || src.dir == EAST)
								icon_state = "climbleft"
							step(src,NORTH)
							sleep(2)
							step(src,NORTH)
							sleep(2)
							step(src,NORTH)
							del src

						proc/StopInFear(mob/M)
							src.idle = 0
							src.retreating = 0
							src.scarred = 1
							walk(src,0)
							sleep(3)
							src.Retreat(M)

					hedgehog
						icon = 'Hedgehog.dmi'
						health = 20
						maxhealth = 20
						exp_reward = 1
						var/tmp/mob/target
						var/tmp/retreating = 0
						var/tmp/idle = 0

						SetName()
							return

						New()
							..()
							src.overlays-=/obj/MaleParts/UnderShade
							src.pixel_x = 0
							src.overlays+=/obj/MaleParts/UnderShadeSmall
							hedgehog_count++
							src.ryo = rand(10,30)
							spawn() src.CombatAI()

						Move()
							..()
							src.FindTarget()

						Death(killer)
							..()
							if(src.health <= 0)
								hedgehog_count--

						proc/Idle()
							src.icon_state = ""
							src.idle = 1
							src.retreating = 0
							src.target = null
							walk_rand(src,8)

						proc/CombatAI()
							while(src)
								if(!src.dead && src.target)
									if(!src.retreating && get_dist(src,src.target) <= 5) src.Retreat(src.target)
									if(get_dist(src,src.target) > 5) src.Idle()
								else if(!src.dead && !src.idle) src.Idle()
								sleep(2)

						proc/FindTarget()
							if(src)
								for(var/mob/M in orange(5))
									if(istype(M,/mob/npc) || istype(M,/mob/Rotating_Dummy) || M.dead) continue
									if(M)
										src.target = M
									else src.target = null

						proc/Retreat(mob/M)
							if(src && M)
								src.retreating = 1
								src.idle = 0
								walk(src,0)
								flick("hide", src)
								sleep(3)
								src.icon_state = "hidden"
								src.FindTarget()

					hare
						icon = 'Hare.dmi'
						health = 20
						maxhealth = 20
						exp_reward = 1
						var/tmp/mob/target
						var/retreating = 0
						var/tmp/idle = 0

						SetName()
							return

						New()
							..()
							src.overlays-=/obj/MaleParts/UnderShade
							src.pixel_x = 0
							src.overlays+=/obj/MaleParts/UnderShadeSmall
							hare_count++
							src.ryo = rand(10,30)
							spawn() src.CombatAI()

						Move()
							..()
							src.FindTarget()

						Death(killer)
							..()
							if(src.health <= 0)
								hare_count--

						proc/Idle()
							src.idle = 1
							src.retreating = 0
							src.target = null
							walk_rand(src,8)

						proc/CombatAI()
							while(src)
								if(!src.dead)
									if(!src.retreating && get_dist(src,src.target) <= 10) src.Retreat(src.target)
									if(get_dist(src,src.target) > 10 && !src.idle) src.Idle()
								else if(!src.dead && !src.idle) src.Idle()
								sleep(2)

						proc/FindTarget()
							if(src)
								for(var/mob/M in orange(10))
									if(istype(M,/mob/npc) || istype(M,/mob/Rotating_Dummy) || M.dead) continue
									if(M)
										src.target = M
									else src.target = null

						proc/Retreat(mob/M)
							if(src && M)
								src.idle = 0
								src.retreating = 1
								walk_away(src,M,11,1)
								src.FindTarget()

					rabbit
						icon = 'Rabbit.dmi'
						health = 20
						maxhealth = 20
						exp_reward = 1
						var/tmp/mob/target
						var/retreating = 0
						var/tmp/idle = 0

						SetName()
							return

						New()
							..()
							src.overlays-=/obj/MaleParts/UnderShade
							src.pixel_x = 0
							src.overlays+=/obj/MaleParts/UnderShadeSmall
							rabbit_count++
							src.ryo = rand(10,30)
							spawn() src.CombatAI()

						Move()
							..()
							src.FindTarget()

						Death(killer)
							..()
							if(src.health <= 0)
								rabbit_count--

						proc/Idle()
							src.idle = 1
							src.retreating = 0
							src.target = null
							walk_rand(src,8)

						proc/CombatAI()
							while(src)
								if(!src.dead)
									if(!src.retreating && get_dist(src,src.target) <= 10) src.Retreat(src.target)
									if(get_dist(src,src.target) > 10 && !src.idle) src.Idle()
								else if(!src.dead && !src.idle) src.Idle()
								sleep(2)

						proc/FindTarget()
							if(src)
								for(var/mob/M in orange(10))
									if(istype(M,/mob/npc) || istype(M,/mob/Rotating_Dummy) || M.dead) continue
									if(M)
										src.target = M
									else src.target = null

						proc/Retreat(mob/M)
							if(src && M)
								src.idle = 0
								src.retreating = 1
								walk_away(src,M,11,1)
								src.FindTarget()

mob
	npc
		combat
			animals
				buck
					icon = 'Buck.dmi'
					health = 20
					maxhealth = 20
					exp_reward = 1
					var/tmp/mob/target
					var/retreating = 0
					var/tmp/idle = 0

					SetName()
						return

					New()
						..()
						buck_count++
						src.ryo = rand(10,30)
						spawn() src.CombatAI()

					Move()
						..()
						src.FindTarget()

					Death(killer)
						..()
						if(src.health <= 0)
							buck_count--

					proc/Idle()
						src.idle = 1
						src.retreating = 0
						src.target = null
						walk_rand(src,8)

					proc/CombatAI()
						while(src)
							if(!src.dead)
								if(!src.retreating && get_dist(src,src.target) <= 10) src.Retreat(src.target)
								if(get_dist(src,src.target) > 15 && !src.idle) src.Idle()
							else if(!src.dead && !src.idle) src.Idle()
							sleep(2)

					proc/FindTarget()
						if(src)
							for(var/mob/M in orange(15))
								if(istype(M,/mob/npc) || istype(M,/mob/Rotating_Dummy) || M.dead) continue
								if(M)
									src.target = M
								else src.target = null

					proc/Retreat(mob/M)
						if(src && M)
							src.idle = 0
							src.retreating = 1
							walk_away(src,M,16,2)
							src.FindTarget()

				doe
					icon = 'Doe.dmi'
					health = 20
					maxhealth = 20
					exp_reward = 1
					var/tmp/mob/target
					var/retreating = 0
					var/tmp/idle = 0
					var/tmp/childfawn

					SetName()
						return

					New()
						..()
						doe_count++
						src.ryo = rand(10,30)
						if(prob(30))
							var/mob/npc/combat/animals/fawn/child = new/mob/npc/combat/animals/fawn(src.loc)
							child.mother = src
							src.childfawn = child
						spawn() src.CombatAI()

					Move()
						..()
						src.FindTarget()

					Death(killer)
						..()
						if(src.health <= 0)
							doe_count--

					proc/Idle()
						src.idle = 1
						src.retreating = 0
						src.target = null
						walk_rand(src,8)

					proc/CombatAI()
						while(src)
							if(!src.dead)
								if(!src.retreating && get_dist(src,src.target) <= 10) src.Retreat(src.target)
								if(get_dist(src,src.target) > 15 && !src.idle) src.Idle()
							else if(!src.dead && !src.idle) src.Idle()
							sleep(2)

					proc/FindTarget()
						if(src)
							for(var/mob/M in orange(15))
								if(istype(M,/mob/npc) || istype(M,/mob/Rotating_Dummy) || M.dead) continue
								if(M)
									src.target = M
								else src.target = null

					proc/Retreat(mob/M)
						if(src && M)
							src.idle = 0
							src.retreating = 1
							walk_away(src,M,16,2)
							src.FindTarget()

				fawn
					icon = 'Fawn.dmi'
					health = 20
					maxhealth = 20
					exp_reward = 1
					var/tmp/mob/target
					var/retreating = 0
					var/tmp/idle = 0
					var/tmp/mother

					SetName()
						return

					New()
						..()
						src.ryo = rand(10,30)
						walk_to(src,mother,2,3)
						spawn() src.CombatAI()

					Move()
						..()
						src.FindTarget()

					Death(killer)
						..()
						if(src.health <= 0)
							doe_count--

					proc/Idle()
						src.idle = 1
						src.retreating = 0
						src.target = null
						walk_rand(src,8)

					proc/CombatAI()
						while(src)
							if(!src.dead && !mother)
								if(!src.retreating && get_dist(src,src.target) <= 10) src.Retreat(src.target)
								if(get_dist(src,src.target) > 15 && !src.idle) src.Idle()
							else if(!src.dead && !src.idle && !mother) src.Idle()
							else walk_to(src,mother,2,3)
							sleep(2)

					proc/FindTarget()
						if(src)
							for(var/mob/M in orange(15))
								if(istype(M,/mob/npc) || istype(M,/mob/Rotating_Dummy) || M.dead) continue
								if(M)
									src.target = M
								else src.target = null

					proc/Retreat(mob/M)
						if(src && M)
							src.idle = 0
							src.retreating = 1
							walk_away(src,M,16,2)
							src.FindTarget()

				snake
					icon='Snake.dmi'
					exp_reward = 3
					var/punch_cd=0
					var/attacking = 0
					var/tmp/mob/target
					var/retreating = 0
					health=2500
					maxhealth=2500


					SetName()
						return

					Move()
						..()
						if(!src.attacking)
							src.FindTarget()

					New()
						..()
						src.ryo = rand(50,150)
						snake_count++
						spawn() src.CombatAI()

					proc/CombatAI()
						while(src)
							if(src.target && src.attacking && !src.dead)
								if(get_dist(src,src.target) <= 1 && !src.punch_cd) src.AttackTarget(src.target)
								else if(get_dist(src,src.target) > 20) src.Idle()
								else if(!src.punch_cd) src.ChaseTarget(src.target)
							else if(!src.dead) src.Idle()
							sleep(1)

					proc/Idle()
						src.attacking = 0
						src.retreating = 0
						src.target = null
						walk_rand(src,10)

					proc/FindTarget()
						if(src)
							for(var/mob/M in orange(15))
								if(istype(M,/mob/npc) || istype(M,/mob/Rotating_Dummy) || M.village == VILLAGE_AKATSUKI || M.dead) continue
								if(M)
									src.target = M
									src.attacking = 1
								else src.target = null

					proc/ChaseTarget(mob/M)
						if(src && M)
							src.retreating = 0
							walk_towards(src,M,2)

					proc/AttackTarget(mob/M)
						if(src && M)
							M.DealDamage(50,src,"TaiOrange",0,0,1)
							M.UpdateHMB()
							M.Death(src)
							src.punch_cd=1
							sleep(2)
							src.Retreat(M)
							spawn(4) src.punch_cd=0

					proc/Retreat(mob/M)
						if(src && M)
							walk(src,0)
							step_rand(src)
							walk_away(src,M,10,2)
							src.retreating = 1
							src.FindTarget()

obj
	animalspawn
		icon = 'placeholdertiles.dmi'
		icon_state = "animalspawn"
		New()
			..()
			src.icon_state = "blank"

	animalspawndesert
		icon = 'placeholdertiles.dmi'
		icon_state = "animalspawndesert"
		New()
			..()
			src.icon_state = "blank"

obj
	animalblocker
		icon = 'placeholdertiles.dmi'
		icon_state = "animalblocker"
		layer = TURF_LAYER+1
		New()
			..()
			src.icon_state = "blank"
		Cross(mob/M)
			if(istype(M, /mob/npc/combat/animals))
				return 0
			else
				return ..()