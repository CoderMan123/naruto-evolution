mob
	proc
		Gedo_Revival()
			for(var/obj/Jutsus/Gedo_Revival/J in src.jutsus)
				if(src.PreJutsu(J))
					if(loc.loc:Safe!=1) src.LevelStat("Ninjutsu",((J.maxcooltime*3/10)*jutsustatexp))
					Bind(src, 5)
					flick("groundjutsu",src)
					src.icon_state = "groundjutsuse"
					for(var/mob/M in src.loc)
						if(M.icon_state == "dead" && M.dead)
							M.revived=1
							M.dead=0
							M.density=1
							M.health=M.maxhealth
							M.chakra=M.maxchakra
							M.icon_state=""
							M.wait=0
							M.rest=0
							M.dodge=0
							M.overlays=0
							M.RestoreOverlays()
							M.UpdateHMB()
							spawn(1)M.Run()
							src.DealDamage(src.health/2,src,"cyan")
							spawn(600)if(M)if(M.revived)M.revived=0
					spawn(5)if(src)
						src.icon_state = ""

		Rinnegan()
			for(var/obj/Jutsus/Rinnegan/J in src.jutsus)
				if(src.Rinnegan)
					for(var/image/i in client.images)if(i.name=="RinneganCircle")del(i)
					src.Rinnegan=0
					hearers(src) << output("<font color=#C0C0C0><b>[src] deactivated Rinnegan","Action.Output")
					src << output("<font color=#C0C0C0><b>You deactivate Rinnegan","Action.Output")
					return
				if(!src.Rinnegan)
					if(src.PreJutsu(J))
						if(loc.loc:Safe!=1) src.LevelStat("Ninjutsu",((J.maxcooltime*3/10)*jutsustatexp))
						src << output("<font color=#C0C0C0><b>You activate your Rinnegan.","Action.Output")
						hearers(src) << output("<font color=#C0C0C0><b>[src] activated their Rinnegan!","Action.Output")
						src.Rinnegan=1
						/*if(J.level<4)
							if(loc.loc:Safe!=1) J.exp+=rand(5,15)
							J.Levelup()*/
						spawn()
							while(src.Rinnegan)
								if(src)
									for(var/atom/movable/ZX in orange())
										var/minusx=-16
										if(ismob(ZX))minusx=0
										if(ZX.byakuview == 1)
											var/QWE = image('Rinneglow.dmi',layer=600,loc = ZX,pixel_x=minusx)
											if(istype(ZX,/mob/Clones/)) QWE+=rgb(255,0,0)
											src << QWE
											spawn(10)if(QWE)del(QWE)
								sleep(10)
/*								src.DealDamage(15, src, "aliceblue", 0, 1)
								if(src.chakra<=0)
									src.chakra=0
									src.Rinnegan=0
									src << output("<font color=[colour2html("red")]><b>Your Rinnegan has been deactivated.","Action.Output")
*/
		Induction()
			for(var/obj/Jutsus/Induction/J in src.jutsus)
				if(src.PreJutsu(J))
					var/mob/c_target=src.Target_Get(TARGET_MOB)
					if(loc.loc:Safe!=1) src.LevelStat("Ninjutsu",((J.maxcooltime*3/10)*jutsustatexp))
					flick("jutsuse",src)
					src.PlayAudio('wind_leaves.ogg', output = AUDIO_HEARERS)
					Bind(src, 3)
					if(J.level==1) J.damage=((jutsudamage*J.Sprice)/2)/4
					if(J.level==2) J.damage=((jutsudamage*J.Sprice)/1.5)/4
					if(J.level==3) J.damage=((jutsudamage*J.Sprice)/1.25)/4
					if(J.level==4) J.damage=(jutsudamage*J.Sprice)/4
					if(J.level<4) if(loc.loc:Safe!=1) J.exp+=jutsumastery*(J.maxcooltime/20); J.Levelup()
					if(c_target)
						src.dir=get_dir(src,c_target)
						var/obj/Projectiles/Pull/A = new/obj/Projectiles/Pull(src.loc)
						A.IsJutsuEffect=src
						A.Owner=src
						A.fightlayer=src.fightlayer
						A.damage=J.damage+round((src.ninjutsu_total / 200)*2*J.damage)
						A.level=J.level
						walk_towards(A,c_target.loc,0)
						A.pixel_y+=rand(10,15)
						spawn(4) if(A) walk(A,A.dir)
					else
						var/obj/Projectiles/Pull/A = new/obj/Projectiles/Pull(src.loc)
						A.IsJutsuEffect=src
						A.Owner=src
						A.fightlayer=src.fightlayer
						A.damage=J.damage+round((src.ninjutsu_total / 200)*2*J.damage)
						A.level=J.level
						walk(A,src.dir)
						A.pixel_y+=rand(10,15)

		Repulsion()
			for(var/obj/Jutsus/Repulsion/J in src.jutsus)
				if(src.PreJutsu(J))
					var/mob/c_target=src.Target_Get(TARGET_MOB)
					if(loc.loc:Safe!=1) src.LevelStat("Ninjutsu",((J.maxcooltime*3/10)*jutsustatexp))
					flick("jutsuse",src)
					src.PlayAudio('wind_leaves.ogg', output = AUDIO_HEARERS)
					Bind(src, 3)
					if(J.level==1) J.damage=((jutsudamage*J.Sprice)/2)/4
					if(J.level==2) J.damage=((jutsudamage*J.Sprice)/1.5)/4
					if(J.level==3) J.damage=((jutsudamage*J.Sprice)/1.25)/4
					if(J.level==4) J.damage=(jutsudamage*J.Sprice)/4
					if(J.level<4) if(loc.loc:Safe!=1) J.exp+=jutsumastery*(J.maxcooltime/20); J.Levelup()
					if(c_target)
						src.dir=get_dir(src,c_target)
						var/obj/Projectiles/Push/A = new/obj/Projectiles/Push(src.loc)
						A.IsJutsuEffect=src
						A.Owner=src
						A.fightlayer=src.fightlayer
						A.damage=J.damage+round((src.ninjutsu_total / 200)*2*J.damage)
						A.level=J.level
						walk_towards(A,c_target.loc,0)
						A.pixel_y+=rand(10,15)
						spawn(4) if(A) walk(A,A.dir)
					else
						var/obj/Projectiles/Push/A = new/obj/Projectiles/Push(src.loc)
						A.IsJutsuEffect=src
						A.Owner=src
						A.fightlayer=src.fightlayer
						A.damage=J.damage+round((src.ninjutsu_total / 200)*2*J.damage)
						A.level=J.level
						walk(A,src.dir)
						A.pixel_y+=rand(10,15)

		Summoning_Dog()
			for(var/obj/Jutsus/Dog_Summoning/J in src.jutsus)
				if(src.PreJutsu(J))
					if(loc.loc:Safe!=1) src.LevelStat("Ninjutsu",((J.maxcooltime*3/10)*jutsustatexp))
					var/obj/SMOKE = new/obj/MiscEffects/SmokeBomb(usr.loc)
					SMOKE.loc=usr.loc
					src.PlayAudio('flashbang_explode2.wav', output = AUDIO_HEARERS)
					var/mob/summonings/DogSummoning/D = new/mob/summonings/DogSummoning(usr.loc)
					D.loc=usr.loc
					D.OWNER=src
					var/mob/c_target=src.Target_Get(TARGET_MOB)
					if(c_target)
						walk_to(D,c_target)
					spawn(100)
						del(D)

		AlmightyPush()
			for(var/obj/Jutsus/Almighty_Push/J in src.jutsus)
				if(src.PreJutsu(J))
					src.icon_state="jutsuse"
					Bind(src, 10)
					src.PlayAudio('wind_leaves.ogg', output = AUDIO_HEARERS)
					var/obj/Projectiles/Effects/shinratensei/A=new/obj/Projectiles/Effects/shinratensei(src.loc)
					A.IsJutsuEffect=src
					A.Owner=src
					A.layer=src.layer
					sleep(1)
					if(loc.loc:Safe!=1) src.LevelStat("Ninjutsu",((J.maxcooltime*3/10)*jutsustatexp))
					if(J.level==1) A.damage=((jutsudamage*J.Sprice)/2)/2
					if(J.level==2) A.damage=((jutsudamage*J.Sprice)/2)/2
					if(J.level==3) A.damage=((jutsudamage*J.Sprice)/1.25)/2
					if(J.level==4) A.damage=(jutsudamage*J.Sprice)/2
					if(J.level<4) if(loc.loc:Safe!=1) J.exp+=jutsumastery*(J.maxcooltime/20); J.Levelup()
					var/Jdamage=A.damage+round((src.ninjutsu_total / 200)*2*A.damage)
					for(var/atom/S in orange(src,A.level+4))
						if(istype(S,/mob/))
							var/mob/M=S
							if(M.dead) continue
							M.icon_state="push"
							AddState(src, new/state/cant_attack, 30)
							M.DealDamage(Jdamage,src,"NinBlue")
							if(M.client)
								spawn()M.ScreenShake(50)
							walk_away(M,src)
							spawn(30)
								if(M)
									walk(M,0)
								if(M) if(!CheckState(M, new/state/swimming)) M.icon_state=""
						if(istype(S,/obj/Projectiles/))
							if(S==A) continue
							walk_away(S,A)
					spawn(10)if(src)
						del(A)
						src.ArrowTasked=null
						src.arrow=null
						src.cranks=null
						src.icon_state=""

		Chakra_Leech()
			for(var/obj/Jutsus/Chakra_Leech/J in src.jutsus)
				if(src.PreJutsu(J))
					if(loc.loc:Safe!=1) src.LevelStat("Ninjutsu",((J.maxcooltime*3/10)*jutsustatexp))
					if(J.level<4) if(loc.loc:Safe!=1) J.exp+=jutsumastery*(J.maxcooltime/20); J.Levelup()
					src.icon_state = "punchrS"

					var/state/cant_attack/e = new()
					AddState(src, e, -1)

					var/state/cant_move/f = new()
					AddState(src, f, -1)

					var/mob/Z
					for(var/mob/M in get_step(src,src.dir))
						if(M.key)
							Z = M
					if(Z)
						var/obj/O = new/obj
						O.icon = 'ChakraCharge.dmi'
						O.loc = Z.loc
						O.icon_state = "3x"
						O.layer = 200
						O.pixel_x=-21

						var/state/cant_attack/a = new()
						var/state/cant_move/b = new()

						while(Z && src && Z.chakra-J.level*5>0 && src.chakra<>src.maxchakra && Z.loc == get_step(src,src.dir))
							Z.DealDamage(J.level*5,src,"aliceblue",0,1)
							src.DealDamage(-J.level*5,src,"aliceblue",0,1)
							
							AddState(Z, a, -1)
							AddState(Z, b, -1)

							if(src.chakra>src.maxchakra)src.chakra = src.maxchakra
							sleep(2)
						if(Z)
							RemoveState(src, a, STATE_REMOVE_REF)
							RemoveState(src, b, STATE_REMOVE_REF)
							Z.icon_state = ""
						del(O)
					src.icon_state = ""

					RemoveState(src, e, STATE_REMOVE_REF)
					RemoveState(src, f, STATE_REMOVE_REF)

