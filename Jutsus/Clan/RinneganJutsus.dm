mob
	proc
		Gedo_Revival()
			for(var/obj/Jutsus/Gedo_Revival/J in src.JutsusLearnt) if(J.Excluded==0)
				if(src.PreJutsu(J))
					if(loc.loc:Safe!=1) src.LevelStat("Ninjutsu",rand(4,8))
					src.move=0
					src.canattack=0
					src.injutsu=1
					src.firing=1
					flick("groundjutsu",src)
					src.icon_state = "groundjutsuse"
					for(var/mob/M in src.loc)
						if(M.icon_state == "dead" && M.dead)
							M.revived=1
							M.dead=0
							M.KOs=0
							M.density=1
							M.health=M.maxhealth
							M.chakra=M.maxchakra
							M.injutsu=0
							M.canattack=1
							M.firing=0
							M.icon_state=""
							M.wait=0
							M.rest=0
							M.dodge=0
							M.move=1
							M.swimming=0
							M.walkingonwater=0
							M.overlays=0
							M.RestoreOverlays()
							M.UpdateHMB()
							spawn(1)M.Run()
							src.DealDamage(src.health/2,src,"cyan")
							spawn(600)if(M)if(M.revived)M.revived=0
					spawn(5)if(src)
						src.icon_state = ""
						src.move=1
						src.canattack=1
						src.injutsu=0
						src.firing=0
		Rinnegan()
			for(var/obj/Jutsus/Rinnegan/J in src.JutsusLearnt)
				if(src.Rinnegan)
					for(var/image/i in client.images)if(i.name=="RinneganCircle")del(i)
					src.Rinnegan=0
					world<<output("<font color=#C0C0C0><b>[src] deactivated Rinnegan","ActionPanel.Output")
					src << output("<font color=#C0C0C0><b>You deactivate Rinnegan","ActionPanel.Output")
					return
				if(!src.Rinnegan)
					if(src.PreJutsu(J))
						//if(loc.loc:Safe!=1) src.LevelStat("Ninjutsu",rand(5,7))
						src << output("<font color=#C0C0C0><b>You activate your Rinnegan.","ActionPanel.Output")
						world<<output("<font color=#C0C0C0><b>[src] activated their Rinnegan!","ActionPanel.Output")
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
									src << output("<font color=[colour2html("red")]><b>Your Rinnegan has been deactivated.","ActionPanel.Output")
*/
		Induction()
			for(var/obj/Jutsus/Induction/J in src.JutsusLearnt)
				if(src.PreJutsu(J))
					var/mob/c_target=src.Target_Get(TARGET_MOB)
					if(loc.loc:Safe!=1) src.LevelStat("Ninjutsu",rand(4,7))
					flick("jutsuse",src)
					view(src)<<sound('wind_leaves.ogg',0,0)
					src.firing=1
					src.canattack=0
					if(J.level==1) J.damage=5
					if(J.level==2) J.damage=10
					if(J.level==3) J.damage=15
					if(J.level==4) J.damage=15
					if(J.level<4) if(loc.loc:Safe!=1) J.exp+=rand(7,9); J.Levelup()
					if(c_target)
						src.dir=get_dir(src,c_target)
						var/obj/Projectiles/Pull/A = new/obj/Projectiles/Pull(src.loc)
						A.IsJutsuEffect=src
						A.Owner=src
						A.fightlayer=src.fightlayer
						A.damage=J.damage
						A.level=J.level
						walk_towards(A,c_target.loc,0)
						A.pixel_y+=rand(10,15)
						spawn(4) if(A) walk(A,A.dir)
					else
						var/obj/Projectiles/Pull/A = new/obj/Projectiles/Pull(src.loc)
						A.IsJutsuEffect=src
						A.Owner=src
						A.fightlayer=src.fightlayer
						A.damage=J.damage
						A.level=J.level
						walk(A,src.dir)
						A.pixel_y+=rand(10,15)
					spawn(7)if(src)
						src.firing=0
						src.canattack=1

		Repulsion()
			for(var/obj/Jutsus/Repulsion/J in src.JutsusLearnt)
				if(src.PreJutsu(J))
					var/mob/c_target=src.Target_Get(TARGET_MOB)
					if(loc.loc:Safe!=1) src.LevelStat("Ninjutsu",rand(4,7))
					flick("jutsuse",src)
					view(src)<<sound('wind_leaves.ogg',0,0)
					src.firing=1
					src.canattack=0
					if(J.level==1) J.damage=5
					if(J.level==2) J.damage=10
					if(J.level==3) J.damage=15
					if(J.level==4) J.damage=15
					if(J.level<4) if(loc.loc:Safe!=1) J.exp+=rand(7,9); J.Levelup()
					if(c_target)
						src.dir=get_dir(src,c_target)
						var/obj/Projectiles/Push/A = new/obj/Projectiles/Push(src.loc)
						A.IsJutsuEffect=src
						A.Owner=src
						A.fightlayer=src.fightlayer
						A.damage=J.damage
						A.level=J.level
						walk_towards(A,c_target.loc,0)
						A.pixel_y+=rand(10,15)
						spawn(4) if(A) walk(A,A.dir)
					else
						var/obj/Projectiles/Push/A = new/obj/Projectiles/Push(src.loc)
						A.IsJutsuEffect=src
						A.Owner=src
						A.fightlayer=src.fightlayer
						A.damage=J.damage
						A.level=J.level
						walk(A,src.dir)
						A.pixel_y+=rand(10,15)
					spawn(5)if(src)
						src.firing=0
						src.canattack=1
		Summoning_Snake()
			if(firing)return
			if(src.firing==0 && src.canattack==1)
				for(var/obj/Jutsus/Snake_Summoning/J in src.JutsusLearnt)
					if(src.PreJutsu(J))
						if(loc.loc:Safe!=1) src.LevelStat("Ninjutsu",rand(9,11))
						var/obj/SMOKE = new/obj/MiscEffects/SmokeBomb(usr.loc)
						SMOKE.loc=usr.loc
						view(usr)<<sound('flashbang_explode2.wav',0,0)
						var/mob/summonings/SnakeSummoning/B = new/mob/summonings/SnakeSummoning(usr.loc)
						B.loc=usr.loc
						B.lowner=src
						var/mob/c_target=src.Target_Get(TARGET_MOB)
						if(c_target)
							walk_to(B,c_target)
						spawn(100)
							del(B)

		AlmightyPush()
			for(var/obj/Jutsus/Almighty_Push/J in src.JutsusLearnt)
				if(src.PreJutsu(J))
					if(src.firing==1) return
					src.copy=null
					src.icon_state="jutsuse"
					src.injutsu=1
					src.move=0
					src.canattack=0
					src.firing=1
					view(src)<<sound('wind_leaves.ogg',0,0)
					var/obj/Projectiles/Effects/shinratensei/A=new/obj/Projectiles/Effects/shinratensei(src.loc)
					A.IsJutsuEffect=src
					A.Owner=src
					A.layer=src.layer
					sleep(1)
					if(A.level==1) A.damage=100
					if(A.level==2) A.damage=200
					if(A.level==3) A.damage=300
					if(A.level==4) A.damage=500
					if(J.level<4) if(loc.loc:Safe!=1) J.exp+=rand(20,30); J.Levelup()
					var/Jdamage=A.damage+round(src.ninjutsu*10)
					for(var/atom/S in orange(src,A.level+4))
						if(istype(S,/mob/))
							var/mob/M=S
							if(M.dead || M.swimming) continue
							M.icon_state="push"
							M.injutsu=1
							M.DealDamage(Jdamage,src,"NinBlue")
							if(M.client)
								spawn()M.ScreenShake(50)
							walk_away(M,src)
							spawn(30)
								if(M)
									M.injutsu=0
									walk(M,0)
								if(M) if(!M.swimming) M.icon_state=""
						if(istype(S,/obj/Projectiles/))
							if(S==A) continue
							walk_away(S,A)
					spawn(10)if(src)
						del(A)
						src.copy=null
						src.ArrowTasked=null
						src.arrow=null
						src.cranks=null
						src.copy=null
						src.injutsu=0
						src.move=1
						src.canattack=1
						src.icon_state=""
						src.firing=0

		Chakra_Leech()
			for(var/obj/Jutsus/Chakra_Leech/J in src.JutsusLearnt)
				if(src.PreJutsu(J))
					if(loc.loc:Safe!=1) src.LevelStat("Ninjutsu",rand(2,10))//Might be too high.
					if(J.level<4) if(loc.loc:Safe!=1) J.exp+=rand(2,5); J.Levelup()
					src.icon_state = "punchrS"
					src.move=0
					src.injutsu=1
					src.firing=1
					src.canattack=0
					var/mob/Z
					for(var/mob/M in get_step(src,src.dir))
						if(M.key)
							M.move=0
							M.injutsu=1
							M.firing=1
							M.canattack=0
							Z = M
					if(Z)
						var/obj/O = new/obj
						O.icon = 'ChakraCharge.dmi'
						O.loc = Z.loc
						O.icon_state = "3x"
						O.layer = 200
						O.pixel_x=-21
						while(Z && src && Z.chakra-J.level*5>0 && src.chakra<>src.maxchakra && Z.loc == get_step(src,src.dir))
							Z.DealDamage(J.level*5,src,"aliceblue",0,1)
							src.DealDamage(-J.level*5,src,"aliceblue",0,1)
							Z.move=0
							Z.injutsu=1
							Z.firing=1
							Z.canattack=0
							if(src.chakra>src.maxchakra)src.chakra = src.maxchakra
							sleep(2)
						if(Z)
							Z.move=1
							Z.injutsu=0
							Z.firing=0
							Z.canattack=1
							Z.icon_state = ""
						del(O)
					src.icon_state = ""
					src.move=1
					src.injutsu=0
					src.firing=0
					src.canattack=1

