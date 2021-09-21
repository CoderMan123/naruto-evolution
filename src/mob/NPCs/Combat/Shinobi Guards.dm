mob/npc/combat
	guard
		var/list/element_pool = list("Fire","Water","Wind","Earth","Lightning")
		var/list/tool_pool = list("Shuriken", "Throwing Needle", "Kunai", "Exploding Kunai", "Explosive Tag")
		var/list/style_pool = list("ranger", "melee", "binder")

		genin
			icon='WhiteMBase.dmi'
			var/punch_cd=0
			var/attacking = 0
			var/tmp/mob/target
			var/retreating = 0
			var/next_punch = "left"
			var/mob/c_target
			var/chosen_tool
			var/chosen_style
			var/movementspeed = 1
			var/last_target
			var/spawned = 0
			var/no_target_counter = 0
			var/original_loc
			move = 1
			health=2500
			maxhealth=2500
			chakra=1000000000
			maxchakra=1000000000
			maxninexp=1000000000
			maxgenexp=1000000000
			maxstrengthexp=1000000000
			maxdefexp=1000000000
			maxagilityexp=1000000000
			maxprecisionexp=1000000000
			ninjutsu=80
			genjutsu=80
			strength=80
			defence=80
			agility=80
			precision=80


			SetName()
				return

			Move()
				..()
				if(!src.attacking && !c_target)
					src.FindTarget()

			New()
				..()
				src.original_loc = src.loc
				src.attkspeed=(8-(0.04*src.agility))
				src.PickElement()
				src.PickTools()
				src.PickStyle()
				src.GainJutsu()
				src.ryo = rand(50,150)
				spawn() src.CombatAI()

			Death(mob/killer)
				..()
				killer.infamy_points++
				for(var/mob/Clones/C in src.Clones)
					C.health=0
					C.Death(src)
				spawn(50) del(src)

			proc/Idle()
				src.attacking = 0
				src.retreating = 0
				src.Target_Remove()
				src.FindTarget()
				if(src.no_target_counter > 40) src.ResetAI()

			proc/ResetAI()
				for(var/mob/Clones/C in src.Clones)
					C.health=0
					C.Death(src)
				if(src.spawned)
					src.Clone_Jutsu_Destroy()
					del(src)
				else
					src.Clone_Jutsu_Destroy()
					src.health = src.maxhealth
					src.chakra = src.maxchakra
					src.loc = src.original_loc

			proc/FindTarget()
				if(!c_target) sleep(10)
				if(src)
					for(var/mob/M in orange(30))
						if(istype(M,/mob/npc) || istype(M,/mob/training) || M.village == src.village || M.dead || M.infamy_points < 1) continue
						if(M)
							src.no_target_counter = 0
							src.Target_Remove()
							src.Target_Atom(M)
							src.attacking = 1
							src.last_target = M
						else
							src.Target_Remove()
					if(!c_target) src.no_target_counter++

			proc/CastDefensive()
				walk(src, 0)
				if(prob(50)) src.Clone_Jutsu()
				else src.Body_Replacement_Technique()

				if(prob(50))
					src.Advanced_Body_Replacement_Technique()

			proc/CombatAI()
				while(src)
					if(src.kawarmi && !src.move)
						if(prob(40)) src.Dodge()
					if(src.move)
						src.icon_state = "run"
						c_target = src.Target_Get(TARGET_MOB)
						if(istype(c_target, /mob/npc)) c_target = null
						if(src.c_target && src.attacking && !src.dead && !c_target.dead)
							if(prob(50))
								src.CombatIdle()
							else if(prob(10)) src.CastDefensive()
							else
								src.EngageTarget()
						else if(!src.dead) src.Idle()
					else
						walk(src, 0)
					sleep(3)

			proc/CombatIdle()
				if(c_target)
					switch(src.chosen_style)
						if("melee")
							if(prob(50))
								step_to(src, c_target)
							else
								step_rand(src)
						if("ranger")
							if(get_dist(src.loc, c_target.loc) < 8)
								if(prob(50)) step_away(src, c_target, 8)
								else step_rand(src)
							else step_to(src, c_target)
						if("binder")
							if(prob(50)) step_rand(src)
							else if(prob(50)) step_to(src, c_target)
							else if(prob(30)) step_away(src, c_target, 8)

			proc/EngageTarget()
				switch(src.chosen_style)
					if("melee")
						if(prob(70))
							if(!CheckState(src, new/state/AI_is_punching)) src.PunchTarget()
						else if(prob(40)) src.UseTool()
						else src.CastJutsuMelee()
					if("ranger")
						if(prob(70)) src.UseTool()
						else if(prob(60)) src.CastJutsuRanger()
						else src.UseTool()

					if("binder")
						if(prob(50)) src.CastJutsuBinder()
						else if(prob(60)) src.UseTool()
						else src.CastJutsuBinder()


			proc/PunchTarget(mob/M)
				if(c_target.loc != get_step(src, src.dir) && get_dist(src.loc, c_target.loc) > 5 && src.canattack)
					src.UseFlicker()
				else if(prob(20)) src.UseFlicker()
				AddState(src, new/state/AI_is_punching, 20)
				while(CheckState(src, new/state/AI_is_punching))
					if(prob(10))
						if(src.move) step_rand(src)
					else if(src.move) walk_towards(src, c_target, src.movementspeed)
					src.Basic_Attack()
					sleep(0.1)

			proc/Retreat(var/dist)
				if(c_target && get_dist(src.loc, c_target.loc) < dist)
					if(src.move) walk_away(src, c_target, dist, src.movementspeed)
				sleep(7)
				walk(src, 0)

			proc/CastJutsuMelee(mob/M)
				walk(src, 0)
				switch(src.Element)
					if("Earth")
						var/which_combo = pick(1,2,3)
						switch(which_combo)
							if(1)
								src.Earth_Style_Dark_Swamp()
								sleep(3)
								src.PunchTarget()
							if(2)
								src.UseFlicker()
								src.Earth_Disruption()
								src.PunchTarget()
							if(3)
								src.UseFlicker()
								if(src.move) step_away(src, c_target)
								src.Mud_Dragon_Projectile()
								sleep(5)

					if("Fire")
						var/which_combo = pick(1,2,3)
						switch(which_combo)
							if(1)
								src.UseFlicker()
								step_away(src, c_target)
								sleep(1)
								step_away(src, c_target)
								src.AFire_Ball()
								sleep(2)
								src.PunchTarget()
							if(2)
								src.UseFlicker()
								src.Fire_Ball()
								sleep(2)
								src.PunchTarget()
							if(3)
								src.UseFlicker()
								step_away(src, c_target)
								src.Fire_Dragon_Projectile()
								sleep(5)

						
					if("Water")
						var/which_combo = pick(1,2)
						if(prob(66))
							src.UseFlicker()
							if(c_target) src.dir = get_dir(src.loc, c_target.loc)
							src.Water_Release_Exploding_Water_Colliding_Wave()
							sleep(5)

						else
							switch(which_combo)
								if(1)
									src.UseFlicker()
									if(c_target) src.dir = get_dir(src.loc, c_target.loc)
									src.Teppoudama()
									src.PunchTarget()
								if(2)
									src.UseFlicker()
									step_away(src, c_target)
									src.Water_Dragon_Projectile()
									sleep(5)
						
					if("Wind")
						var/which_combo = pick(1,2,3)
						switch(which_combo)
							if(1)
								src.UseFlicker()
								if(c_target) src.dir = get_dir(src.loc, c_target.loc)
								src.Blade_of_Wind()
								src.PunchTarget()
							if(2)
								src.UseFlicker()
								src.Wind_Tornados()
							if(3)
								src.UseFlicker()
								step_away(src, c_target)
								src.Wind_Dragon_Projectile()
								sleep(5)

					if("Lightning")
						var/which_combo = pick(1,2,3)
						switch(which_combo)
							if(1)
								src.UseFlicker()
								src.Chidori()
								sleep(10)
								src.PunchTarget()
							if(2)
								src.UseFlicker()
								spawn() src.Chidori_Nagashi()
								src.PunchTarget()
							if(3)
								src.UseFlicker()
								src.Chidori_Jinrai()
								src.PunchTarget()

				src.jutsu_cooldowns = list()


			proc/CastJutsuRanger(mob/M)
				walk(src, 0)
				switch(src.Element)
					if("Earth")
						var/which_combo = pick(1,2,3)
						switch(which_combo)
							if(1)
								src.Doryuusou()
							if(2)
								src.MudWall()
							if(3)
								src.Mud_Dragon_Projectile()
								sleep(5)


					if("Fire")
						var/which_combo = pick(1,2,3)
						switch(which_combo)
							if(1)
								src.Phoenix_Immortal_Fire_Technique()
							if(2)
								src.AFire_Ball()
							if(3)
								src.Magma_Needles()


						
					if("Water")
						var/which_combo = pick(1,2)
						if(prob(66))
							src.UseFlicker()
							if(c_target) src.dir = get_dir(src.loc, c_target.loc)
							src.Water_Release_Exploding_Water_Colliding_Wave()
							sleep(5)

						else
							switch(which_combo)
								if(1)
									src.WaterShark()
								if(2)
									src.Teppoudama()

						
					if("Wind")
						var/which_combo = pick(1,2,3)
						switch(which_combo)
							if(1)
								src.Sickle_Weasel_Technique()
							if(2)
								src.Wind_Tornados()
							if(3)
								src.Wind_Dragon_Projectile()
								sleep(5)

					if("Lightning")
						var/which_combo = pick(1,2,3)
						switch(which_combo)
							if(1)
								src.Chidori_Needles()
							if(2)
								src.Chidori_Jinrai()
							if(3)
								src.LightningBalls()

				src.jutsu_cooldowns = list()


			proc/CastJutsuBinder(mob/M)
				walk(src, 0)
				switch(src.Element)
					if("Earth")
						var/which_combo = pick(1,2,3)
						switch(which_combo)
							if(1)
								src.Earth_Release_Earth_Cage()
							if(2)
								src.Earth_Style_Dark_Swamp()
							if(3)
								src.Earth_Release_Mud_River()

					if("Fire")
						var/which_combo = pick(1,2,3)
						switch(which_combo)
							if(1)
								src.dir = get_dir(src.loc, c_target.loc)
								src.Fire_Release_Ash_Pile_Burning()
								src.ArrowTasked = null
								src.ashbomb()
							if(2)
								src.Magma_Crush()
							if(3)
								src.Fire_Ball()


						
					if("Water")
						var/which_combo = pick(1,2)
						if(prob(66))
							src.UseFlicker()
							if(c_target) src.dir = get_dir(src.loc, c_target.loc)
							src.Water_Release_Exploding_Water_Colliding_Wave()
							sleep(5)

						else
							switch(which_combo)
								if(1)
									src.UseFlicker()
									src.WaterPrison()
									sleep(30)
								if(2)
									src.UseFlicker()
									step_away(src, c_target)
									src.Water_Dragon_Projectile()
									sleep(5)

						
					if("Wind")
						var/which_combo = pick(1,2,3)
						switch(which_combo)
							if(1)
								src.dir = get_dir(src.loc, c_target.loc)
								src.FuutonDaitoppa()
							if(2)
								src.UseFlicker()
								src.Wind_Shield()
							if(3)
								src.Wind_Dragon_Projectile()
								sleep(5)

					if("Lightning")
						var/which_combo = pick(1,2,3)
						switch(which_combo)
							if(1)
								if(prob(40)) src.Kirin()
							if(2)
								src.Chidori_Needles()
							if(3)
								src.Chidori()
								sleep(10)

			proc/UseTool(mob/M)
				if(src.equipped=="Shurikens")
					if(src.chosen_style == "ranger")
						src.Retreat(8)
					src.Throw()

				if(src.equipped=="ExplodeKunais")
					if(src.chosen_style == "ranger")
						src.Retreat(8)
					else
						src.Retreat(5)
					src.Throw()

				if(src.equipped=="Kunais")
					if(src.chosen_style == "ranger")
						src.Retreat(8)
					src.Throw()

				if(src.equipped=="Needles")
					if(src.chosen_style == "ranger")
						src.Retreat(8)
					src.Throw()

				if(src.equipped=="ExplosiveTags")
					if(!src.tagcd)
						src.UseFlicker()
						src.Throw()
						src.Retreat(5)
						src.Dodge()

			proc/UseFlicker(mob/M)
				src.Shunshin()
				sleep(5)

			proc/PickElement()
				src.Element = pick(src.element_pool)
				src.element_pool -= src.Element
				src.Element2 = pick(src.element_pool)
			
			proc/GainJutsu()
				for(var/obj/Jutsus/J in world)
					if(J.Element == src.Element || J.give_to_guards)
						if(J.type in src.jutsus_learned) continue
						src.jutsus += J
						src.jutsus_learned += J.type
				for(var/obj/Jutsus/J2 in src.jutsus)
					J2.level = 4

			proc/PickTools()
				src.chosen_tool = pick(src.tool_pool)
				for(var/obj/Inventory/Weaponry/C)
					if(C.name == src.chosen_tool)
						var/obj/Inventory/I=new C.type()
						I.stacks = 10000
						src.RecieveItem(I)
						break
				switch(src.chosen_tool)
					if("Shuriken") src.equipped = "Shurikens"
					if("Throwing Needle") src.equipped = "Needles"
					if("Kunai") src.equipped = "Kunais"
					if("Exploding Kunai") src.equipped = "ExplodeKunais"
					if("Explosive Tag") src.equipped = "ExplosiveTags"

			proc/PickStyle()
				src.chosen_style = pick(src.style_pool)
				if(chosen_style == "melee") src.Specialist = SPECIALIZATION_TAIJUTSU

			Leaf
				name = "Leaf Genin Guard"
				village = VILLAGE_LEAF

				New()
					..()
					src.overlays += pick('Short.dmi','Short2.dmi','Short3.dmi')
					src.overlays += 'Shade.dmi'
					src.overlays+='Shirt.dmi'
					src.overlays+='Sandals.dmi'
					src.overlays += 'HeadBandLeaf.dmi'

			Sand
				name = "Sand Genin Guard"
				village = VILLAGE_SAND

				New()
					..()
					src.overlays += pick('Short.dmi','Short2.dmi','Short3.dmi')
					src.overlays += 'Shade.dmi'
					src.overlays+='Shirt.dmi'
					src.overlays+='Sandals.dmi'
					src.overlays += 'HeadBandSand.dmi'