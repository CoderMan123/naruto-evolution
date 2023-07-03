mob
	var/tmp/last_melee_attack
	var/tmp/fighting_style
	var/tmp/combo_order = list()
	var/tmp/combo_pos = 1
	var/tmp/combo_mod
	verb
		basic_attack()
			set hidden=1

			var/attack_speed
			var/attack_damage = src.taijutsu_total
			var/is_dodged
			var/is_hit
			var/combo_total = 1

			if(!CheckState(src, new/state/combo_cooldown)) src.combo_pos = 1

			if(src.Specialist == SPECIALIZATION_TAIJUTSU)
				attack_speed = src.attkspeed - 0.1
			else
				attack_speed = src.attkspeed + 0.05

			var/mob/c_target = src.Target_Get(TARGET_MOB)
			var/mob/attacker = src

			if(src.likeaclone)
				attacker = src.likeaclone
				attacker.attkspeed = attack_speed

			if(!c_target)
				for(var/mob in get_step(attacker,attacker.dir))
					src.Target_Atom(mob)
					c_target = src.Target_Get(TARGET_MOB)
					break

			if(CheckState(attacker, new/state/cant_attack) || CheckState(attacker, new/state/punching) || CheckState(attacker, new/state/knocked_down) || attacker.multisized==1) return

			if(ChakraCheck(0)) return

			if(CheckState(attacker, new/state/sand_shield))
				attacker.sand_shield_attack()
				AddState(attacker, new/state/punching, attack_speed*2)
				return

			if(c_target&&!src.likeaclone)
				if(attacker.lungecounter==0)
					step(attacker, get_dir(attacker, c_target))
					attacker.lungecounter=1
					if(attacker.equipped=="Weights")
						spawn(40-((src.agility_total/200)*30))lungecounter=0
						if(loc.loc:Safe!=1) src.LevelStat("Agility",round(rand(8,20)*trainingexp))
					else
						spawn(20-((src.agility_total/200)*15))lungecounter=0
						if(loc.loc:Safe!=1) src.LevelStat("Agility",round(rand(4,11)*trainingexp))
					if(src.Gates >= 4)
						var/mob/W=src.Target_Get(TARGET_MOB)
						if(W)
							attacker.dir = get_dir(attacker,W)
							attacker.loc = W.loc
							step(attacker,W.dir)
							attacker.dir = get_dir(attacker,W)
							var/obj/SH = new/obj
							SH.loc = attacker.loc
							SH.icon = 'Shunshin.dmi'
							flick("fl",SH)
							spawn(3)if(SH)del(SH)

			

			if(c_target)attacker.dir = get_dir(attacker, c_target)
			else if(src.likeaclone)
				attacker.Target_A_Mob()
				var/mob/c_target3=attacker.Target_Get(TARGET_MOB)
				src.Target_Atom(c_target3)
			else
				src.Target_A_Mob()
				var/mob/c_target23=src.Target_Get(TARGET_MOB)
				if(c_target23)attacker.dir = get_dir(attacker,c_target23)

			

			if(!attacker.fighting_style)
				attacker.combo_order = list("punch","punch","kick")

			switch(attacker.fighting_style)
				if("byakugan")						attacker.combo_order = list("punch","punch","punch","punch")

				if("mystical palms")				attacker.combo_order = list("punch","punch")

				if("bone sword")					attacker.combo_order = list("punch","punch","punch")

				if("first gate") 					attacker.combo_order = list("punch","kick","punch","kick")
				if("second gate") 					attacker.combo_order = list("punch","kick","punch","kick","punch")
				if("third gate") 					attacker.combo_order = list("punch","kick","punch","kick","punch","kick")
				if("fourth gate") 					attacker.combo_order = list("punch","kick","punch","kick","punch","kick","punch")
				if("fifth gate") 					attacker.combo_order = list("punch","kick","punch","kick","punch","kick","punch","kick")

			combo_total = length(attacker.combo_order)
			if(src.Specialist != SPECIALIZATION_TAIJUTSU) combo_total -= 1
			
			if(c_target in get_step(attacker,attacker.dir))
				if(src.Clan == CLAN_SAND || src.Clan2 == CLAN_SAND)
					if(prob(30))
						is_dodged = 1
						sand_block_fx(attacker)
				if(c_target.Sharingan)
					if(prob((c_target.Sharingan*10)))
						c_target.Dodge()
				if(c_target.dodge && c_target.agility > attacker.agility)
					var/dodge_chance = c_target.agility - attacker.agility
					if(dodge_chance > 100) dodge_chance = 100
					if(prob(dodge_chance))
						is_dodged = 1
						flick("dodge",c_target)
						if(c_target) c_target.LevelStat("Agility",rand(1,2))
				else
					is_hit = 1

			switch(attacker.combo_order[attacker.combo_pos])
				if("punch") attacker.punch(attacker, c_target, attack_damage, is_dodged, is_hit)
				if("kick") attacker.kick(attacker, c_target, attack_damage, is_dodged, is_hit)

			if(c_target)
				if(attacker.taijutsu_total > c_target.defence_total && is_hit && !attacker.Gates)
					var/obj/Drag=new /obj/Drag/Dirt(c_target.loc)
					Drag.dir=c_target.dir
					step(c_target,attacker.dir)
					c_target.dir = get_dir(c_target,attacker)
					step_to(attacker,c_target,1)

			if(combo_total <= attacker.combo_pos)
				attacker.combo_pos = 1
				AddState(attacker, new/state/punching, (attack_speed * 3))
			else
				attacker.combo_pos ++
				AddState(attacker, new/state/punching, attack_speed)

			AddState(src, new/state/combo_cooldown, 20)

			if(CheckState(attacker, new/state/sand_shield))
				attacker.sand_shield_attack()
				return



mob
	proc
		punch(var/mob/attacker , var/mob/target , var/damage , var/is_dodged , var/is_hit)
			attacker.last_melee_attack = "punch"
			attacker.PlayAudio('Swing5.ogg', output = AUDIO_HEARERS)
			if(attacker.Hand == "right")
				flick("punchr", attacker)
				attacker.Hand = "left"
				if(!is_dodged && is_hit && !attacker.byakugan && !attacker.mystical_palms && !attacker.bonesword && !attacker.Gates) attacker.PlayAudio('LPunchHIt.ogg', output = AUDIO_HEARERS)
				else if(attacker.byakugan && is_hit) attacker.PlayAudio('SkillDam_ThrowSuriken3.wav', output = AUDIO_HEARERS)
				else if(attacker.mystical_palms && is_hit) attacker.PlayAudio('SharpHit_Short.wav', output = AUDIO_HEARERS)
				else if(attacker.bonesword && is_hit) attacker.PlayAudio('SharpHit_Short2.wav', output = AUDIO_HEARERS)
				else if(attacker.Gates && is_hit)
					attacker.PlayAudio('LPunchHIt.ogg', output = AUDIO_HEARERS)
					attacker.PlayAudio('Down_Nornal.wav', output = AUDIO_HEARERS)
					attacker.gate_fx()
				if(CheckState(src, new/state/Iron_Fists) && !CheckState(src, new/state/Iron_Fist_Punching_Right) && !CheckState(src, new/state/Iron_Fist_Grabbing_Right) && !CheckState(src, new/state/Iron_Fist_Grabbed_Right))
					flick("trans", src.right_iron_fist)
					AddState(src, new/state/Iron_Fist_Punching_Right, 3)
			else
				flick("punchl", attacker)
				attacker.Hand = "right"
				if(!is_dodged && is_hit && !attacker.byakugan && !attacker.mystical_palms && !attacker.bonesword && !attacker.Gates) attacker.PlayAudio('KickHit.ogg', output = AUDIO_HEARERS)
				else if(attacker.byakugan && is_hit) attacker.PlayAudio('SkillDam_ThrowSuriken3.wav', output = AUDIO_HEARERS)
				else if(attacker.mystical_palms && is_hit) attacker.PlayAudio('SharpHit_Short.wav', output = AUDIO_HEARERS)
				else if(attacker.bonesword && is_hit) attacker.PlayAudio('SharpHit_Short2.wav', output = AUDIO_HEARERS)
				else if(attacker.Gates && is_hit)
					attacker.PlayAudio('KickHit.ogg', output = AUDIO_HEARERS)
					attacker.PlayAudio('Down_Nornal.wav', output = AUDIO_HEARERS)
					attacker.gate_fx()
				if(CheckState(src, new/state/Iron_Fists) && !CheckState(src, new/state/Iron_Fist_Punching_Left) && !CheckState(src, new/state/Iron_Fist_Grabbing_Left) && !CheckState(src, new/state/Iron_Fist_Grabbed_Left))
					flick("trans", src.left_iron_fist)
					AddState(src, new/state/Iron_Fist_Punching_Left, 3)
			
			var/byakugan_level
			if(attacker.byakugan)
				var/obj/GF = new/obj
				GF.loc = attacker.loc
				GF.layer=200
				GF.dir = attacker.dir
				GF.icon = 'PressurePoint.dmi'
				for(var/obj/Jutsus/Byakugan/J in attacker.jutsus)
					if(J.level == 4)flick('GentleFist.dmi',GF)
					else flick("[J.level]",GF)
					byakugan_level = J.level
				switch(attacker.dir)
					if(WEST) GF.pixel_x=-16
				spawn(4)if(GF)del(GF)
			
			if(attacker.mystical_palms)
				var/obj/GF = new/obj
				GF.loc = src.loc
				GF.layer=200
				GF.dir = src.dir
				GF.icon = 'PressurePoint.dmi'
				flick('GentleFist.dmi',GF)
				switch(src.dir)
					if(WEST) GF.pixel_x=-16
				spawn(4)if(GF)del(GF)

			if(!is_dodged && is_hit)
				
				if(attacker.byakugan) target.DealDamage((damage / 12) * byakugan_level, attacker, "aliceblue", 0, 1)
				if(attacker.mystical_palms) AddState(target, new/state/bleeding, 40, attacker)
				if(attacker.Gates)
					damage += (damage * 0.05) * attacker.Gates
					attacker.DealDamage((((attacker.taijutsu_total / 200)*3) + (attacker.health * 0.001))* attacker.Gates, attacker, "maroon")
					var/obj/Drag=new /obj/Drag/Dirt(target.loc)
					Drag.dir=target.dir
					step(target,attacker.dir)
					target.dir = get_dir(target,attacker)
					step_to(attacker,target,1)
				if(attacker.bonesword)
					damage += (damage * 0.1) * attacker.bonesword
					target.Bleed()
				target.DealDamage(damage, attacker, "TaiOrange",0,0,1)
				if(!target.dodge) Bind(target, 0.5)
				if(loc.loc:Safe!=1) attacker.LevelStat("Taijutsu", 10*punchstatexp)

		kick(var/mob/attacker , var/mob/target , var/damage , var/is_dodged, var/is_hit)
			attacker.last_melee_attack = "kick"
			attacker.PlayAudio('Swing5.ogg', output = AUDIO_HEARERS)
			if(!is_dodged && is_hit && !attacker.Gates) src.PlayAudio('HandDam_Normal2.ogg', output = AUDIO_HEARERS)
			else if(attacker.Gates && is_hit)
				attacker.PlayAudio('HandDam_Normal2.ogg', output = AUDIO_HEARERS)
				attacker.PlayAudio('Down_Nornal.wav', output = AUDIO_HEARERS)
				attacker.gate_fx()
			flick("kick", attacker)

			if(!is_dodged && is_hit)
				if(attacker.Gates)
					damage += (damage * 0.05) * attacker.Gates
					attacker.DealDamage((((attacker.taijutsu_total / 200)*3) + (attacker.health * 0.001))* attacker.Gates, attacker, "maroon")
					var/obj/Drag=new /obj/Drag/Dirt(target.loc)
					Drag.dir=target.dir
					step(target,attacker.dir)
					target.dir = get_dir(target,attacker)
					step_to(attacker,target,1)
				target.DealDamage(damage, attacker, "TaiOrange",0,0,1)
				if(!target.dodge) Bind(target, 0.5)
				if(loc.loc:Safe!=1) attacker.LevelStat("Taijutsu", 10*punchstatexp)

		sand_shield_attack()
			if(src.Clan == CLAN_SAND || src.Clan2 == CLAN_SAND)
				if(!CheckState(src, new/state/cant_attack) && !CheckState(src, new/state/punching) && !CheckState(src, new/state/swimming))
					var/obj/O = new/obj
					O.loc = src.loc
					O.icon = 'Sand Shield.dmi'
					O.icon_state = "spike"
					O.pixel_x=-32
					O.layer=12
					O.layer=MOB_LAYER+100
					var/PL = list()
					for(var/mob/PO in orange(1))PL+=PO
					if(length(PL)<>0)
						var/mob/W = pick(PL)
						src.Target_Atom(W)
						src.dir = get_dir(src,W)
					step(O,src.dir)
					if(O.dir == NORTH)O.layer = OBJ_LAYER
					spawn(2)if(O)del(O)
					for(var/mob/M in orange(1,O))
						if(M <> src)
							M.DealDamage(src.ninjutsu_total,src,"NinBlue",0,0,1)

		sand_block_fx(var/attacker)
			var/obj/AW = new/obj
			AW.loc = src.loc
			AW.dir = src.dir
			AW.layer = MOB_LAYER+1
			AW.pixel_x=-16
			var/obj/AW2 = new/obj
			AW2.loc = src.loc
			AW2.pixel_x=-16
			AW2.dir = src.dir
			AW2.layer = MOB_LAYER-1
			AW.icon = 'sand block.dmi'
			AW2.icon = 'sand block.dmi'
			flick("over player",AW)
			flick("under player",AW2)
			spawn(3)
				if(AW)del(AW)
				if(AW2)del(AW2)

		gate_fx()
			if(src.Gates == 2)
				var/obj/A = new/obj/MiscEffects/MeteorDust(src.loc)
				A.pixel_x=-30
				A.pixel_y=-10
				A.dir=src.dir
				A.icon_state = "0"
			if(src.Gates == 3)
				var/obj/A = new/obj/MiscEffects/MeteorDust(src.loc)
				A.pixel_x=-30
				A.pixel_y=-10
				A.dir=src.dir
				A.icon_state = "1"
			if(src.Gates == 4)
				var/obj/A = new/obj/MiscEffects/MeteorDust(src.loc)
				A.pixel_x=-30
				A.pixel_y=-10
				A.dir=src.dir
				A.icon_state = "2"
			if(src.Gates == 5)
				var/obj/A = new/obj/MiscEffects/MeteorDust(src.loc)
				A.pixel_x=-30
				A.pixel_y=-10
				A.dir=src.dir
				A.icon_state = "max"

			