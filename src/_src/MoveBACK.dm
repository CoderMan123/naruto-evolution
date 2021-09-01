mob
	var/tmp/Sleeping=0
	var/tmp/JashinConnector
	proc/Bleed()
		if(!src.dead)
			var/obj/O = new/obj/bloodeffectz
			O.Owner=src
			O.loc = src.loc
			O.pixel_x=-16
			O.icon =  'blood effects.dmi'
			var/bl = rand(1,7)
			O.icon_state = "l[bl]"
			var/bf = rand(1,7)
			flick("fl[bf]",O)
			walk_to(O,src)
			spawn(3)walk_to(O,0)
obj
	bloodeffectz
		New()
			..()
			spawn(100)if(src)del(src)
	InvisOverlay
		LArrow
			name=""
			icon='Misc Effects.dmi'
			icon_state="arrow"
			layer=9
			dir=WEST
			pixel_x=-64
			//New()
			//	screen_loc = "17,16"
		RArrow
			name=""
			icon='Misc Effects.dmi'
			icon_state="arrow"
			layer=9
			dir=EAST
			pixel_x=64
		UArrow
			name=""
			icon='Misc Effects.dmi'
			icon_state="arrow"
			layer=9
			dir=NORTH
			pixel_y=64
		DArrow
			name=""
			icon='Misc Effects.dmi'
			icon_state="arrow"
			layer=9
			dir=SOUTH
			pixel_y=-64
	Blood
		FootstepL
		FootstepR
		Drag
obj
	proc
		objburn()
			spawn(1)
				var/turf/T = src.loc
				for(var/mob/M in T)
					if(!M.burn)
						if(!M.injutsu)
							M.injutsu=1
							spawn(3)if(M)M.injutsu=0
						if(M)
							for(var/obj/Jutsus/Fire_Release_Ash_Pile_Burning/J in src.owner.jutsus)
								M.burn=(1.3*(J.damage+round((src.owner.ninjutsu / 150)*2*J.damage))/35)//burn
								M.BurnEffect(src.owner)
				src.pixel_x=-21
				src.objburn()
mob
	proc
		ChidoriUp()Effects["Chidori"]++
		RasenganUp()Effects["Rasengan"]++
		do8palms()
			src.copy = "waiting"
			for(var/i=0,i<5,i++)
				spawn(2)
					flick("punchr",src)
					spawn(2)flick("punchl",src)
					spawn(4)flick("punchr",src)
					spawn(6)flick("punchl",src)
					spawn(8)flick("punchrS",src)
				src.icon_state = "punchrS"
				var/turf/T = get_step(src,src.dir)
				for(var/mob/M in T)
					M.move=0
					M.injutsu=1
					view(src)<<sound('SkillDam_ThrowSuriken3.wav',0,0,volume=100)
					M.DealDamage((jutsudamage+round(((src.ninjutsu / 450)+(src.agility / 450)+(src.strength / 450))*2*jutsudamage))/10,src,"cyan",0,1)
					M.DealDamage((jutsudamage+round(((src.ninjutsu / 450)+(src.agility / 450)+(src.strength / 450))*2*jutsudamage))/10,src,"TaiOrange")
					if(loc.loc:Safe!=1)src.LevelStat("Ninjutsu",rand(6,10))
					src.Levelup()
					if(M.henge==4||M.henge==5)M.HengeUndo()
					spawn(2)step_towards(src,M)
					//spawn(3)if(M) M.injutsu=0
					//M.move=1
			src.icon_state = ""
		do16palms()
			src.copy = "waiting"
			for(var/i=0,i<5,i++)
				spawn(2)
					flick("punchr",src)
					spawn(2)flick("punchl",src)
					spawn(4)flick("punchr",src)
					spawn(6)flick("punchl",src)
					spawn(8)flick("punchrS",src)
				src.icon_state = "punchrS"
				var/turf/T = get_step(src,src.dir)
				for(var/mob/M in T)
					M.move=0
					M.injutsu=1
					view(src)<<sound('SkillDam_ThrowSuriken3.wav',0,0,volume=100)
					M.DealDamage((jutsudamage+round(((src.ninjutsu / 450)+(src.agility / 450)+(src.strength / 450))*2*jutsudamage))/10,src,"cyan",0,1)
					M.DealDamage((jutsudamage+round(((src.ninjutsu / 450)+(src.agility / 450)+(src.strength / 450))*2*jutsudamage))/10,src,"TaiOrange")
					if(loc.loc:Safe!=1) src.LevelStat("Ninjutsu",rand(6,10))
					src.Levelup()
					if(M.henge==4||M.henge==5)M.HengeUndo()
					spawn(2)step_towards(src,M)
					//spawn(3) if(M) M.injutsu=0
					//M.move=1
			src.icon_state = ""
		do32palms()
			src.copy = "waiting"
			for(var/i=0,i<5,i++)
				spawn(2)
					flick("punchr",src)
					spawn(2)flick("punchl",src)
					spawn(4)flick("punchr",src)
					spawn(6)flick("punchl",src)
					spawn(8)flick("punchrS",src)
				src.icon_state = "punchrS"
				var/turf/T = get_step(src,src.dir)
				for(var/mob/M in T)
					M.move=0
					M.injutsu=1
					view(src)<<sound('SkillDam_ThrowSuriken3.wav',0,0,volume=100)
					M.DealDamage((jutsudamage+round(((src.ninjutsu / 450)+(src.agility / 450)+(src.strength / 450))*2*jutsudamage))/10,src,"cyan",0,1)
					M.DealDamage((jutsudamage+round(((src.ninjutsu / 450)+(src.agility / 450)+(src.strength / 450))*2*jutsudamage))/10,src,"TaiOrange")
					if(loc.loc:Safe!=1) src.LevelStat("Ninjutsu",rand(6,10))
					src.Levelup()
					if(M.henge==4||M.henge==5)M.HengeUndo()
					spawn(2)step_towards(src,M)
					//spawn(4) if(M) M.injutsu=0
					//M.move=1
			src.icon_state = ""
		do64palms()
			src.copy = "waiting"
			for(var/i=0,i<5,i++)
				spawn(2)
					flick("punchr",src)
					spawn(2)flick("punchl",src)
					spawn(4)flick("punchr",src)
					spawn(6)flick("punchl",src)
					spawn(8)flick("punchrS",src)
				src.icon_state = "punchrS"
				var/turf/T = get_step(src,src.dir)
				for(var/mob/M in T)
					M.injutsu=1
					M.move=0
					view(src)<<sound('SkillDam_ThrowSuriken3.wav',0,0,volume=100)
					M.DealDamage((jutsudamage+round(((src.ninjutsu / 450)+(src.agility / 450)+(src.strength / 450))*2*jutsudamage))/10,src,"cyan",0,1)
					M.DealDamage((jutsudamage+round(((src.ninjutsu / 450)+(src.agility / 450)+(src.strength / 450))*2*jutsudamage))/10,src,"TaiOrange")
					if(loc.loc:Safe!=1) src.LevelStat("Ninjutsu",rand(6,10))
					src.Levelup()
					if(M.henge==4||M.henge==5)M.HengeUndo()
					spawn(2)step_towards(src,M)
					//spawn(5)if(M)M.injutsu=0
					//M.move=1
			src.icon_state = ""



		ashbomb()
			src.copy = "waiting"
			for(var/obj/O in view())
				if(O.owner == src && O.icon == 'Smoke.dmi' && O.icon_state == "still")
					O.icon = 'FireBallA.dmi'
					O.icon_state = "dir"
					O.objburn()
					O.pixel_x=-16
					O.pixel_y-=16
					//spawn(50)if(O)del(O)
					spawn(50)
						if(O)
							O.loc = null
			for(var/obj/A in get_step(src,src.dir))A.layer=OBJ_LAYER

		HealUp()
			src.health += 25
			if(health>maxhealth) health=maxhealth
			DamageOverlay(src, 25, "#7fff00")

		DoMirrors(obj/Os)
			if(Os)
				var/obj/O = new/obj
				O.loc = Os.loc
				O.dir = Os.dir
				O.icon = 'Shuriken.dmi'
				O.icon_state = "needle"
				O.pixel_y=16
				O.layer=20
				spawn(1)
					step(O,O.dir)
					for(var/mob/M in O.loc)
						if(M<>src)
							M.injutsu=1
							var/random=rand(1,4)
							if(random==1)view(src)<<sound('knife_hit1.wav',0,0,volume=100)
							if(random==2)view(src)<<sound('knife_hit2.wav',0,0,volume=100)
							if(random==3)view(src)<<sound('knife_hit3.wav',0,0,volume=100)
							if(random==4)view(src)<<sound('knife_hit4.wav',0,0,volume=100)
							M.DealDamage((jutsudamage+round(((src.ninjutsu / 300)+(src.precision / 300))*2*jutsudamage))/25,src,"NinBlue")
							src.Levelup()
							if(M.henge==4||M.henge==5)M.HengeUndo()
							spawn(2) M.injutsu=0
					spawn(1)
						step(O,O.dir)
						for(var/mob/M in O.loc)
							if(M<>src)
								M.injutsu=1
								var/random=rand(1,4)
								if(random==1)view(src)<<sound('knife_hit1.wav',0,0,volume=100)
								if(random==2)view(src)<<sound('knife_hit2.wav',0,0,volume=100)
								if(random==3)view(src)<<sound('knife_hit3.wav',0,0,volume=100)
								if(random==4)view(src)<<sound('knife_hit4.wav',0,0,volume=100)
								M.DealDamage((jutsudamage+round(((src.ninjutsu / 300)+(src.precision / 300))*2*jutsudamage))/25,src,"NinBlue")
								src.Levelup()
								if(M.henge==4||M.henge==5)M.HengeUndo()
								spawn(2) M.injutsu=0
						spawn(1)
							step(O,O.dir)
							for(var/mob/M in O.loc)
								if(M<>src)
									M.injutsu=1
									var/random=rand(1,4)
									if(random==1)view(src)<<sound('knife_hit1.wav',0,0,volume=100)
									if(random==2)view(src)<<sound('knife_hit2.wav',0,0,volume=100)
									if(random==3)view(src)<<sound('knife_hit3.wav',0,0,volume=100)
									if(random==4)view(src)<<sound('knife_hit4.wav',0,0,volume=100)
									M.DealDamage((jutsudamage+round(((src.ninjutsu / 300)+(src.precision / 300))*2*jutsudamage))/25,src,"NinBlue")
									src.Levelup()
									if(M.henge==4||M.henge==5)M.HengeUndo()
									spawn(2) M.injutsu=0
									walk_to(O,M)
									O.icon_state = "nhit"
									O.pixel_x+=rand(1,5)
									O.pixel_y+=rand(1,5)
							spawn(15)if(O)del(O)
client
	North()
		if(src.mob.Intang==1 && istype(get_step(src.mob, NORTH), /turf/IntangBlocker)) return
		if(src.mob.dead==0&&src.mob.dodge==1&&src.mob.canattack==1&&src.mob.dashable==1&&src.mob.health>src.mob.maxhealth/3&&src.mob.dashcd==0)
			src.mob.dashcd=1
			view(src.mob) << sound('dash.wav',0,0,0,100)
			if(src.mob.icon_state<>"blank")flick("dash",src.mob)
			src.mob.dashable=2
			step(src.mob,NORTH)
			spawn(0.5)
				if(src.mob)
					step(src.mob,NORTH)
					step(src.mob,NORTH)
			spawn(1)
				if(src.mob)
					step(src.mob,NORTH)
					step(src.mob,NORTH)
			spawn(1.5)
				if(src.mob)step(src.mob,NORTH)
				if(src.mob)src.mob.dashable=0
			spawn(30-round((src.mob.ninjutsu / 150)*20))src.mob.dashcd=0
		if(src.mob.inshadowfield==1)
			if(src.mob.move==1)
				for(var/mob/M in orange(3,src))
					step(M,NORTH)
		if(src.mob.inboulder==1&&src.mob.dir!=SOUTH)//boulderstuff
			src.mob.dir=NORTH
		if(src.mob.infusing==1)//chakrainfusionstuff
			src.mob.dir=NORTH
		if(src.mob.copy)
			if(src.mob.copy=="Climb")
				if(src.mob.arrow=="U")
					spawn()
						var/obj/WArrow = image('Misc Effects.dmi',usr,icon_state="arrow",layer=99)
						WArrow.pixel_x=-64
						WArrow.dir=WEST
						src.images-=src.mob.ArrowTasked
						del(src.mob.ArrowTasked)
						src.mob.ArrowTasked=WArrow
						src<<WArrow
						src.mob.arrow="L"
						flick("climb",src.mob)
						if(mob.loc.loc:Safe!=1) src.mob.LevelStat("Strength",rand(1,4))
						src.mob.Levelup()
						..()
						//step(src,NORTH)
						//return

			if(findtext(src.mob.copy,"Chidori") && src.mob.ArrowTasked && src.mob.ArrowTasked.dir == NORTH)
				var/k = src.mob.ArrowTasked
				del(k)
				src.mob.ArrowTasked = null
				src.mob.ChidoriUp()
			if(findtext(src.mob.copy,"Rasengan") && src.mob.ArrowTasked && src.mob.ArrowTasked.dir == NORTH)
				var/k = src.mob.ArrowTasked
				del(k)
				src.mob.ArrowTasked = null
				src.mob.RasenganUp()
			if(findtext(src.mob.copy,"Heal") && src.mob.ArrowTasked && src.mob.ArrowTasked.dir == NORTH)
				var/k = src.mob.ArrowTasked
				del(k)
				src.mob.ArrowTasked = null
				src.mob.HealUp()
			if(src.mob.copy == "Hakke" && src.mob.ArrowTasked && src.mob.ArrowTasked.dir == NORTH)
				var/k = src.mob.ArrowTasked
				del(k)
				src.mob.ArrowTasked = null
				src.mob.do8palms()
			if(src.mob.copy == "Hakke2" && src.mob.ArrowTasked && src.mob.ArrowTasked.dir == NORTH)
				var/k = src.mob.ArrowTasked
				del(k)
				src.mob.ArrowTasked = null
				src.mob.do16palms()
			if(src.mob.copy == "Hakke3" && src.mob.ArrowTasked && src.mob.ArrowTasked.dir == NORTH)
				var/k = src.mob.ArrowTasked
				del(k)
				src.mob.ArrowTasked = null
				src.mob.do32palms()
			if(src.mob.copy == "Hakke4" && src.mob.ArrowTasked && src.mob.ArrowTasked.dir == NORTH)
				var/k = src.mob.ArrowTasked
				del(k)
				src.mob.ArrowTasked = null
				src.mob.do64palms()
			for(var/obj/Ogg in view())
				if(Ogg.owner == src.mob)
					if(src.mob.ArrowTasked)
						if(src.mob.copy == "Icemir [Ogg.name]" && src.mob.ArrowTasked && src.mob.ArrowTasked.dir == NORTH)
							var/k = src.mob.ArrowTasked
							del(k)
							src.mob.ArrowTasked = null
							src.mob.DoMirrors(Ogg)
							src.mob.DoMirrors(Ogg)
			if(src.mob.copy=="AlmightyPush")
				if(src.mob.arrow=="U")
					spawn()
						var/obj/WArrow = image('Misc Effects.dmi',usr,icon_state="arrow",layer=99)
						WArrow.pixel_x=-64
						WArrow.dir=WEST
						src.images-=src.mob.ArrowTasked
						del(src.mob.ArrowTasked)
						src.mob.ArrowTasked=WArrow
						src<<WArrow
						src.mob.arrow="L"
						src.mob.cranks++
						if(src.mob.cranks==3)
							for(var/obj/Projectiles/Effects/AlmightyPush/AP in range(src,0))
								AP.icon_state="2"
								AP.level++
						if(src.mob.cranks==6)
							for(var/obj/Projectiles/Effects/AlmightyPush/AP in range(src,0))
								AP.icon_state="3"
								AP.level++
						if(src.mob.cranks==9)
							for(var/obj/Projectiles/Effects/AlmightyPush/AP in range(src,0))
								AP.icon_state="4"
								AP.level++
						if(src.mob.cranks==12)
							for(var/obj/Projectiles/Effects/AlmightyPush/AP in range(src,0))
								AP.icon_state="5"
								AP.level++
						if(src.mob.cranks==15)
							for(var/obj/Projectiles/Effects/AlmightyPush/AP in range(src,0))
								AP.icon_state="6"
								AP.level++
						if(src.mob.cranks==18)
							for(var/obj/Projectiles/Effects/AlmightyPush/AP in range(src,0))
								AP.icon_state="7"
								AP.level++
						if(src.mob.cranks==21)
							for(var/obj/Projectiles/Effects/AlmightyPush/AP in range(src,0))
								AP.icon_state="8"
								AP.level++
					return
		else return ..()
	South()
		if(src.mob.Intang==1 && istype(get_step(src.mob, SOUTH), /turf/IntangBlocker)) return
		if(src.mob.dead==0&&src.mob.dodge==1&&src.mob.canattack==1&&src.mob.dashable==1&&src.mob.health>src.mob.maxhealth/3&&src.mob.dashcd==0)
			src.mob.dashcd=1
			view(src.mob) << sound('dash.wav',0,0,0,100)
			if(src.mob.icon_state<>"blank")flick("dash",src.mob)
			src.mob.dashable=2
			step(src.mob,SOUTH)
			spawn(0.5)
				if(src.mob)
					step(src.mob,SOUTH)
					step(src.mob,SOUTH)
			spawn(1)
				if(src.mob)
					step(src.mob,SOUTH)
					step(src.mob,SOUTH)
			spawn(1.5)
				if(src.mob)step(src.mob,SOUTH)
				if(src.mob)src.mob.dashable=0
			spawn(30-round((src.mob.ninjutsu / 150)*20))src.mob.dashcd=0
		if(src.mob.inshadowfield==1)
			if(src.mob.move==1)
				for(var/mob/M in orange(3,src))
					step(M,SOUTH)
		if(src.mob.inboulder==1&&src.mob.dir!=NORTH)
			src.mob.dir=SOUTH
		if(src.mob.infusing==1)//chakrainfusionstuff
			src.mob.dir=SOUTH
		if(src.mob.copy)
			if(src.mob.copy=="Climb")
				flick("climb",src.mob)
				//src.Move(dir=SOUTH)
				..()
				//return
			if(findtext(src.mob.copy,"Chidori") && src.mob.ArrowTasked && src.mob.ArrowTasked.dir == SOUTH)
				var/k = src.mob.ArrowTasked
				del(k)
				src.mob.ArrowTasked = null
				src.mob.ChidoriUp()
			if(findtext(src.mob.copy,"Rasengan") && src.mob.ArrowTasked && src.mob.ArrowTasked.dir == SOUTH)
				var/k = src.mob.ArrowTasked
				del(k)
				src.mob.ArrowTasked = null
				src.mob.RasenganUp()
			if(findtext(src.mob.copy,"Heal") && src.mob.ArrowTasked && src.mob.ArrowTasked.dir == SOUTH)
				var/k = src.mob.ArrowTasked
				del(k)
				src.mob.ArrowTasked = null
				src.mob.HealUp()
			if(src.mob.copy == "Hakke" && src.mob.ArrowTasked && src.mob.ArrowTasked.dir == SOUTH)
				var/k = src.mob.ArrowTasked
				del(k)
				src.mob.ArrowTasked = null
				src.mob.do8palms()
			if(src.mob.copy == "Hakke2" && src.mob.ArrowTasked && src.mob.ArrowTasked.dir == SOUTH)
				var/k = src.mob.ArrowTasked
				del(k)
				src.mob.ArrowTasked = null
				src.mob.do16palms()
			if(src.mob.copy == "Hakke3" && src.mob.ArrowTasked && src.mob.ArrowTasked.dir == SOUTH)
				var/k = src.mob.ArrowTasked
				del(k)
				src.mob.ArrowTasked = null
				src.mob.do32palms()
			if(src.mob.copy == "Hakke4" && src.mob.ArrowTasked && src.mob.ArrowTasked.dir == SOUTH)
				var/k = src.mob.ArrowTasked
				del(k)
				src.mob.ArrowTasked = null
				src.mob.do64palms()
			if(src.mob.copy == "Ashes" && src.mob.ArrowTasked && src.mob.ArrowTasked.dir == SOUTH)
				var/k = src.mob.ArrowTasked
				del(k)
				src.mob.ArrowTasked = null
				src.mob.ashbomb()
			for(var/obj/Ogg in view())
				if(Ogg.owner == src.mob)
					if(src.mob.ArrowTasked)
						if(src.mob.copy == "Icemir [Ogg.name]" && src.mob.ArrowTasked && src.mob.ArrowTasked.dir == SOUTH)
							var/k = src.mob.ArrowTasked
							del(k)
							src.mob.ArrowTasked = null
							src.mob.DoMirrors(Ogg)
							src.mob.DoMirrors(Ogg)
			if(src.mob.copy=="AlmightyPush")
				if(src.mob.arrow=="D")
					spawn()
						var/obj/EArrow = image('Misc Effects.dmi',usr,icon_state="arrow",layer=99)
						EArrow.pixel_x=64
						EArrow.dir=EAST
						src.images-=src.mob.ArrowTasked
						del(src.mob.ArrowTasked)
						src.mob.ArrowTasked=EArrow
						src<<EArrow
						src.mob.arrow="R"
					return
		else
			return ..()
	West()
		if(src.mob.Intang==1 && istype(get_step(src.mob, WEST), /turf/IntangBlocker)) return
		if(src.mob.dead==0&&src.mob.dodge==1&&src.mob.canattack==1&&src.mob.dashable==1&&src.mob.health>src.mob.maxhealth/3&&src.mob.dashcd==0)
			src.mob.dashcd=1
			view(src.mob) << sound('dash.wav',0,0,0,100)
			if(src.mob.icon_state<>"blank")flick("dash",src.mob)
			src.mob.dashable=2
			step(src.mob,WEST)
			spawn(0.5)
				if(src.mob)
					step(src.mob,WEST)
					step(src.mob,WEST)
			spawn(1)
				if(src.mob)
					step(src.mob,WEST)
					step(src.mob,WEST)
			spawn(1.5)
				if(src.mob)step(src.mob,WEST)
				if(src.mob)src.mob.dashable=0
			spawn(30-round((src.mob.ninjutsu / 150)*20))src.mob.dashcd=0
		if(src.mob.inshadowfield==1)
			if(src.mob.move==1)
				for(var/mob/M in orange(3,src))
					step(M,WEST)
		if(src.mob.inboulder==1&&src.mob.dir!=EAST)
			src.mob.dir=WEST
		if(src.mob.infusing==1)//chakrainfusionstuff
			src.mob.dir=WEST
		if(src.mob.copy)
			if(src.mob.copy=="Climb")
				if(src.mob.arrow=="U")
					spawn()
						var/obj/WArrow = image('Misc Effects.dmi',usr,icon_state="arrow",layer=99)
						WArrow.pixel_x=-64
						WArrow.dir=WEST
						src.images-=src.mob.ArrowTasked
						del(src.mob.ArrowTasked)
						src.mob.ArrowTasked=WArrow
						src<<WArrow
						src.mob.arrow="L"
						flick("climb",src.mob)
						src.mob.LevelStat("Strength",rand(1,2))
						src.mob.Levelup()
						..()
				if(src.mob.arrow=="L")
					spawn()
						var/obj/EArrow = image('Misc Effects.dmi',usr,icon_state="arrow",layer=99)
						EArrow.pixel_x=64
						EArrow.dir=EAST
						src.images-=src.mob.ArrowTasked
						del(src.mob.ArrowTasked)
						src.mob.ArrowTasked=EArrow
						src<<EArrow
						src.mob.arrow="R"
						return
			for(var/obj/Ogg in view())
				if(Ogg.owner == src.mob)
					if(src.mob.ArrowTasked)
						if(src.mob.copy == "Icemir [Ogg.name]" && src.mob.ArrowTasked && src.mob.ArrowTasked.dir == WEST)
							var/k = src.mob.ArrowTasked
							del(k)
							src.mob.ArrowTasked = null
							src.mob.DoMirrors(Ogg)
							src.mob.DoMirrors(Ogg)
			if(findtext(src.mob.copy,"Chidori") && src.mob.ArrowTasked && src.mob.ArrowTasked.dir == WEST)
				var/k = src.mob.ArrowTasked
				del(k)
				src.mob.ArrowTasked = null
				src.mob.ChidoriUp()
			if(findtext(src.mob.copy,"Rasengan") && src.mob.ArrowTasked && src.mob.ArrowTasked.dir == WEST)
				var/k = src.mob.ArrowTasked
				del(k)
				src.mob.ArrowTasked = null
				src.mob.RasenganUp()
			if(findtext(src.mob.copy,"Heal") && src.mob.ArrowTasked && src.mob.ArrowTasked.dir == WEST)
				var/k = src.mob.ArrowTasked
				del(k)
				src.mob.ArrowTasked = null
				src.mob.HealUp()
			if(src.mob.copy == "Hakke" && src.mob.ArrowTasked && src.mob.ArrowTasked.dir == WEST)
				var/k = src.mob.ArrowTasked
				del(k)
				src.mob.ArrowTasked = null
				src.mob.do8palms()
			if(src.mob.copy == "Hakke2" && src.mob.ArrowTasked && src.mob.ArrowTasked.dir == WEST)
				var/k = src.mob.ArrowTasked
				del(k)
				src.mob.ArrowTasked = null
				src.mob.do16palms()
			if(src.mob.copy == "Hakke3" && src.mob.ArrowTasked && src.mob.ArrowTasked.dir == WEST)
				var/k = src.mob.ArrowTasked
				del(k)
				src.mob.ArrowTasked = null
				src.mob.do32palms()
			if(src.mob.copy == "Hakke4" && src.mob.ArrowTasked && src.mob.ArrowTasked.dir == WEST)
				var/k = src.mob.ArrowTasked
				del(k)
				src.mob.ArrowTasked = null
				src.mob.do64palms()
			if(src.mob.copy=="AlmightyPush")
				if(src.mob.arrow=="L")
					spawn()
						var/obj/SArrow = image('Misc Effects.dmi',usr,icon_state="arrow",layer=99)
						SArrow.pixel_y=-64
						SArrow.dir=SOUTH
						src.images-=src.mob.ArrowTasked
						del(src.mob.ArrowTasked)
						src.mob.ArrowTasked=SArrow
						src<<SArrow
						src.mob.arrow="D"
					return
		else
			return ..()
	East()
		if(src.mob.Intang==1 && istype(get_step(src.mob, EAST), /turf/IntangBlocker)) return
		if(src.mob.dead==0&&src.mob.dodge==1&&src.mob.canattack==1&&src.mob.dashable==1&&src.mob.health>src.mob.maxhealth/3&&src.mob.dashcd==0)
			src.mob.dashcd=1
			view(src.mob) << sound('dash.wav',0,0,0,100)
			if(src.mob.icon_state<>"blank")flick("dash",src.mob)
			src.mob.dashable=2
			step(src.mob,EAST)
			spawn(0.5)
				if(src.mob)
					step(src.mob,EAST)
					step(src.mob,EAST)
			spawn(1)
				if(src.mob)
					step(src.mob,EAST)
					step(src.mob,EAST)
			spawn(1.5)
				if(src.mob)step(src.mob,EAST)
				if(src.mob)src.mob.dashable=0
			spawn(30-round((src.mob.ninjutsu / 150)*20))src.mob.dashcd=0
		if(src.mob.inshadowfield==1)
			if(src.mob.move==1)
				for(var/mob/M in orange(3,src))
					step(M,EAST)
		if(src.mob.inboulder==1&&src.mob.dir!=WEST)
			src.mob.dir=EAST
		if(src.mob.infusing==1)//chakrainfusionstuff
			src.mob.dir=EAST
		if(src.mob.copy)
			if(src.mob.copy=="Climb")
				if(src.mob.arrow=="U")
					spawn()
						var/obj/WArrow = image('Misc Effects.dmi',usr,icon_state="arrow",layer=99)
						WArrow.pixel_x=-64
						WArrow.dir=WEST
						src.images-=src.mob.ArrowTasked
						del(src.mob.ArrowTasked)
						src.mob.ArrowTasked=WArrow
						src<<WArrow
						src.mob.arrow="L"
						flick("climb",src.mob)
						src.mob.LevelStat("Strength",rand(1,2))
						src.mob.Levelup()
						..()
				if(src.mob.arrow=="R")
					spawn()
						var/obj/UArrow = image('Misc Effects.dmi',usr,icon_state="arrow",layer=99)
						UArrow.pixel_y=64
						UArrow.dir=NORTH
						src.images-=src.mob.ArrowTasked
						del(src.mob.ArrowTasked)
						src.mob.ArrowTasked=UArrow
						src<<UArrow
						src.mob.arrow="U"
						return
			for(var/obj/Ogg in view())
				if(Ogg.owner == src.mob)
					if(src.mob.ArrowTasked)
						if(src.mob.copy == "Icemir [Ogg.name]" && src.mob.ArrowTasked && src.mob.ArrowTasked.dir == EAST)
							var/k = src.mob.ArrowTasked
							del(k)
							src.mob.ArrowTasked = null
							src.mob.DoMirrors(Ogg)
							src.mob.DoMirrors(Ogg)
			if(findtext(src.mob.copy,"Chidori") && src.mob.ArrowTasked && src.mob.ArrowTasked.dir == EAST)
				var/k = src.mob.ArrowTasked
				del(k)
				src.mob.ArrowTasked = null
				src.mob.ChidoriUp()
			if(findtext(src.mob.copy,"Rasengan") && src.mob.ArrowTasked && src.mob.ArrowTasked.dir == EAST)
				var/k = src.mob.ArrowTasked
				del(k)
				src.mob.ArrowTasked = null
				src.mob.RasenganUp()
			if(findtext(src.mob.copy,"Heal") && src.mob.ArrowTasked && src.mob.ArrowTasked.dir == EAST)
				var/k = src.mob.ArrowTasked
				del(k)
				src.mob.ArrowTasked = null
				src.mob.HealUp()
			if(src.mob.copy == "Hakke" && src.mob.ArrowTasked && src.mob.ArrowTasked.dir == EAST)
				var/k = src.mob.ArrowTasked
				del(k)
				src.mob.ArrowTasked = null
				src.mob.do8palms()
			if(src.mob.copy == "Hakke2" && src.mob.ArrowTasked && src.mob.ArrowTasked.dir == EAST)
				var/k = src.mob.ArrowTasked
				del(k)
				src.mob.ArrowTasked = null
				src.mob.do16palms()
			if(src.mob.copy == "Hakke3" && src.mob.ArrowTasked && src.mob.ArrowTasked.dir == EAST)
				var/k = src.mob.ArrowTasked
				del(k)
				src.mob.ArrowTasked = null
				src.mob.do32palms()
			if(src.mob.copy == "Hakke4" && src.mob.ArrowTasked && src.mob.ArrowTasked.dir == EAST)
				var/k = src.mob.ArrowTasked
				del(k)
				src.mob.ArrowTasked = null
				src.mob.do64palms()
			if(src.mob.copy=="AlmightyPush")
				if(src.mob.arrow=="R")
					spawn()
						//for(var/obj/Screen/Arrow/A in src.screen)
						//	A.dir=NORTH
						var/obj/NArrow = image('Misc Effects.dmi',usr,icon_state="arrow",layer=99)
						NArrow.pixel_y=64
						NArrow.dir=NORTH
						src.images-=src.mob.ArrowTasked
						del(src.mob.ArrowTasked)
						src.mob.ArrowTasked=NArrow
						src<<NArrow
						src.mob.arrow="U"
					return
		else return ..()
	Northwest()return
	Northeast()return
	Southwest()return
	Southeast()return
mob
	proc
		Run()
			while(src)
				sleep(1)
				if(!src.dead)
					if(src.speeding>=1&&src.speeding<=20)src.speeding-=2
					else
						if(src.speeding>=20&&src.speeding<=50)src.speeding-=3
						else
							if(src.speeding>=50&&src.speeding<=100)src.speeding-=4
							else
								if(src.speeding>=100)src.speeding-=6
					if(src.speeding<= 40)
						if(!src.swimming)
							if(src.health<=src.maxhealth/4)src.speeddelay=4
							if(src.health<=src.maxhealth/3&&src.health>src.maxhealth/4)src.speeddelay=3
							if(src.health<=src.maxhealth/2&&src.health>src.maxhealth/3)src.speeddelay=2
							if(src.health>src.maxhealth/2)src.speeddelay=1.5
						else
							if(src.swimming)
								if(src.health<=src.maxhealth/3)src.speeddelay=6
								if(src.health>src.maxhealth/3)src.speeddelay=4
					else
						if(src.speeding>= 16&&src.health>=src.maxhealth/2)
							if(!src.swimming)src.speeddelay=1//.5
							else
								if(src.swimming)src.speeddelay=4
					sleep(10)
					continue
				else
					if(src.dead)break
mob
	proc
		AgilityBoost()
			if(src.agility>=1&&src.agility<25)step(src,src.dir)
//	Move()
//		..()
//		if(src.Owner)
//			var/mob/O=src.Owner
//			if(src.stepped==0)
//				if(O.strength>=1&&O.strength<25)
//					step(src,src.dir)
//					src.stepped=1
	//M.ResetBase()
	//icon='WhiteMBase.dmi'
	//	statpanel("Inventory")
	//	stat("Ryo: ","[src.Ryo]")
	//	stat("Items: ","[src.items]/[src.maxitems]")
	//	stat(src.contents)
		//statpanel("Clothing")
		//stat("Items: ","[src.items]/[src.maxitems]")
		//stat(src.Clothes)
	//	statpanel("Jutsus")
	//	stat(src.jutsus)
		//statpanel("Clothing Collection", src.storage)
		//statpanel("Quest Items", src.QuestItems)

	New()
		..()
		src.overlays+=/obj/MaleParts/UnderShade
	Bump(atom/O)
		..()
		if(istype(O,/mob))
			var/mob/M=O
			if(M.fightlayer==src.fightlayer)
				if(src.henge==4||src.henge==5)src.HengeUndo()
			if(istype(O,/turf))
				src.HengeUndo()
				if(O.density&&src.icon_state=="push")
				//	O.overlays+=image('Misc Effects.dmi',O,"crack[number]")
					var/damage=rand(10,15)
					src.health-=damage
					spawn() DamageOverlay(src, damage, "white")
					if(src.client) spawn() src.ScreenShake(5)
					spawn() UpdateHMB()
					Death(src)
					src.icon_state=""


mob
	New()
		..()
		src.move_delay = min(0.5, 0.8-((src.agility/150)*0.3))

	var/tmp/move_delay=0.8
	var/tmp/moving=0

client
	Move(Loc)
		if(mob.moving) return
		if(!mob.likeaclone)
			if(!mob.injutsu&&!mob.rest&&!mob.dead&&!mob.shielded&&!mob.Sleeping)
				if(mob.dashable<>2)
					if(mob.move==1)
						if(mob.ThrowingMob)
							for(var/mob/M in mobs_online)if(M==mob.ThrowingMob)step_to(M,mob,0)
						if(mob.BeingThrown)
							for(var/mob/M in mobs_online)if(M.ThrowingMob==mob) M.ThrowingMob=null; mob.BeingThrown=0
						if(mob.bunshin)
							for(var/mob/Clones/C2 in mob.Clones)
								if(C2.Owner==mob&&!C2.target_mob)
									step(C2,mob.dir)
									if(C2)	C2.icon_state="[mob.icon_state]"
						if(!mob.dashable)mob.dashable=1
						mob.moving=1
						mob.speeding += 1

						if(istype(mob.loc,/turf/Ground/Water))
							if(mob.swimming)//SWIM
								mob.LevelStat("Agility",rand(2,4))
								mob.Levelup()

							if(mob.walkingonwater)
								mob.LevelStat("Ninjutsu",rand(4,8))
								mob.Levelup()

						if(mob.speeding<0)mob.speeding=0
						if(mob.speeding<=40)
							if(mob.dead==0&&mob.icon_state<>"blank"&&mob.icon_state<>"swim"&&mob.icon_state<>"climbS"&&mob.henge==0&&mob.dodge==0&&mob.rest==0)
								mob.icon_state=""
						if(mob.speeding>= 41&&mob.health>=mob.maxhealth/3)
							if(mob.dead==0&&mob.icon_state<>"blank"&&mob.icon_state<>"swim"&&mob.icon_state<>"climbS"&&mob.dodge==0)
								mob.icon_state="run"
								//mob.layer=MOB_LAYER
								var/turf/T = mob.loc
								spawn(10)
									if(mob.loc == T)
										mob.speeding=0
										mob.icon_state = ""
						mob.lastloc=mob.loc
						..()
						if(src.mob.equipped=="Weights")
							if(prob(50))
								spawn() src.mob.LevelStat("Agility",round(rand(5,10)*trainingexp))
						else
							if(prob(40))
								spawn() src.mob.LevelStat("Agility",rand(1,2))

						sleep(mob.move_delay)
						mob.moving=0

						spawn(2) if(mob.dashable<>2)mob.dashable=0
						/*sleep(mob.speeddelay)
						if(!mob.move)mob.move=1
						switch(mob.dir)
							if(NORTH) mob.pixel_move(0,7)
							if(SOUTH) mob.pixel_move(0,-7)
							if(EAST) mob.pixel_move(7,0)
							if(WEST) mob.pixel_move(-7,0)
							if(NORTHEAST) mob.pixel_move(7,7)
							if(NORTHWEST) mob.pixel_move(-7,7)
							if(SOUTHEAST) mob.pixel_move(7,-7)
							if(SOUTHWEST) mob.pixel_move(-7,-7)*/
					else if(!mob.move)return
				else return
			else return
		else
			var/mob/Clones/SC=src.mob.likeaclone
			if(SC.ThrowingMob)for(var/mob/M in mobs_online) if(M==SC.ThrowingMob)step_to(M,SC,0)
			if(SC.BeingThrown)for(var/mob/M in mobs_online)if(M.ThrowingMob==SC) M.ThrowingMob=null; SC.BeingThrown=0
			var/Dir = get_dir(mob,Loc)
			if(!SC.dashable)SC.dashable=1
			step(SC,Dir)
			spawn(2)if(SC)if(SC.dashable<>2)SC.dashable=0
obj
	var/tmp/stepped=0
mob
	proc
		HengeUndo()
			if(src.henge)
				view(src)<<sound('flashbang_explode1.wav',0,0)
				var/obj/A = new/obj/MiscEffects/Smoke(src.loc)
				A.loc=src.loc
				src.overlays=0
				src.henge=0
				src.UpdateHMB()
				src.SetName(src.name)
				src.ResetBase()
				//src.icon='WhiteMBase.dmi'
				src.icon_state=""
				src.RestoreOverlays()
				if(!jutsuaffect)src.move=1
