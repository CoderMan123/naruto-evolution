mob
	proc
		Camellia_Dance()
			for(var/obj/Jutsus/Camellia_Dance/J in src.jutsus)
				if(src.PreJutsu(J))
					if(loc.loc:Safe!=1) src.LevelStat("Agility",((J.maxcooltime*3/20)*jutsustatexp))
					if(loc.loc:Safe!=1) src.LevelStat("Precision",((J.maxcooltime*3/20)*jutsustatexp))
					if(J.level<4)
						if(loc.loc:Safe!=1)
							J.exp+=rand(2,5)
							J.Levelup()
					flick("jutsu",src)
					if(src.bonesword==0)
						src.bonesword = J.level
						src.overlays+='Camellia.dmi'
						src.overlays+=image('CamB.dmi',pixel_y=-32)
						src.overlays+=image('CamL.dmi',pixel_x=-32)
						src.overlays+=image('CamR.dmi',pixel_x=32)
						src.overlays+=image('CamT.dmi',pixel_y=32)
						while(src.bonesword)
							src.DealDamage(20,src,"aliceblue",0,1)
							if(src.chakra<=0)
								src.chakra=0
								src.bonesword=0
								src.overlays-='Camellia.dmi'
								src.overlays-=image('CamB.dmi',pixel_y=-32)
								src.overlays-=image('CamL.dmi',pixel_x=-32)
								src.overlays-=image('CamR.dmi',pixel_x=32)
								src.overlays-=image('CamT.dmi',pixel_y=32)
							sleep(10)
					else
						src.chakra+=25
						src.bonesword=0
						src.overlays-='Camellia.dmi'
						src.overlays-=image('CamB.dmi',pixel_y=-32)
						src.overlays-=image('CamL.dmi',pixel_x=-32)
						src.overlays-=image('CamR.dmi',pixel_x=32)
						src.overlays-=image('CamT.dmi',pixel_y=32)
		Bone_Drill()
			for(var/obj/Jutsus/Bone_Drill/J in src.jutsus)
				if(src.PreJutsu(J))
					if(loc.loc:Safe!=1) src.LevelStat("Strength",((J.maxcooltime*3/20)*jutsustatexp))
					if(loc.loc:Safe!=1) src.LevelStat("Precision",((J.maxcooltime*3/20)*jutsustatexp))
					if(J.level==1) J.damage=((jutsudamage*J.Sprice)/2.5)/6
					if(J.level==2) J.damage=((jutsudamage*J.Sprice)/2)/6
					if(J.level==3) J.damage=((jutsudamage*J.Sprice)/1.5)/6
					if(J.level==4) J.damage=(jutsudamage*J.Sprice)/6
					if(J.level<4) if(loc.loc:Safe!=1) J.exp+=jutsumastery*(J.maxcooltime/20); J.Levelup()
					src.overlays+='BoneDrill.dmi'
					src.icon_state = "punchrS"
					flick("punchr",src)
					src.move=0
					src.injutsu=1
					src.firing=1
					src.canattack=0
					var/mob/Z
					for(var/mob/M in get_step(src,src.dir))
						M.move=0
						M.injutsu=1
						M.firing=1
						M.canattack=0
						Z = M
					if(Z)
						for(var/i=0,i<5,i++)
							step(Z,src.dir)
							Z.dir = get_dir(Z,src)
							step(src,src.dir)
							Z.DealDamage(J.damage+round(((src.strength / 300)+(src.precision / 300))*2*J.damage),src,"TaiOrange")
							sleep(1)
						if(Z)
							Z.icon_state = "push"
							var/I = J.level*2
							while(I)
								I--
								step(Z,src.dir)
								Z.dir = get_dir(Z,src)
								sleep(1)
							Z.move=1
							Z.injutsu=0
							Z.firing=0
							Z.canattack=1
							Z.icon_state = ""
							Z.Death(src)
						else continue
					src.overlays-='BoneDrill.dmi'
					src.icon_state = ""
					src.move=1
					src.injutsu=0
					src.firing=0
					src.canattack=1
		Bone_Pulse()
			if(src.firing==0)
				if(src.canattack==1)
					for(var/obj/Jutsus/Bone_Pulse/J in src.jutsus_learned)
						var/mob/c_target=src.Target_Get(TARGET_MOB)
						if(src.PreJutsu(J))
							if(loc.loc:Safe!=1) src.LevelStat("Strength",((J.maxcooltime*3/20)*jutsustatexp))
							if(loc.loc:Safe!=1) src.LevelStat("Precision",((J.maxcooltime*3/20)*jutsustatexp))
							flick("groundjutsuse",src)
							view(src)<<sound('Down_Nornal.wav',0,0)
							src.firing=1
							src.canattack=0
							if(J.level==1) J.damage=((jutsudamage*J.Sprice)/2.5)/2
							if(J.level==2) J.damage=((jutsudamage*J.Sprice)/2)/2
							if(J.level==3) J.damage=((jutsudamage*J.Sprice)/1.5)/2
							if(J.level==4) J.damage=(jutsudamage*J.Sprice)/2
							if(J.level<4) if(loc.loc:Safe!=1) J.exp+=jutsumastery*(J.maxcooltime/20); J.Levelup()
							if(c_target)
								src.dir=get_dir(src,c_target)
								var/obj/Projectiles/Effects/BoneYard/A = new/obj/Projectiles/Effects/BoneYard(c_target.loc)
								A.IsJutsuEffect=src
								A.Owner=src
								A.layer=c_target.layer
								A.fightlayer=src.fightlayer
								A.level=J.level
								A.damage=J.damage+round(((src.strength / 300)+(src.precision / 300))*2*J.damage)
								spawn(4)
									for(var/mob/M in view(A,0))
										M.injutsu=1
										var/random=rand(1,4)
										if(random==1)view(src)<<sound('knife_hit1.wav',0,0,volume=100)
										if(random==2)view(src)<<sound('knife_hit2.wav',0,0,volume=100)
										if(random==3)view(src)<<sound('knife_hit3.wav',0,0,volume=100)
										if(random==4)view(src)<<sound('knife_hit4.wav',0,0,volume=100)
										M.DealDamage(A.damage,src,"NinBlue")
										if(M.henge==4||M.henge==5)M.HengeUndo()
								if(J.level==2)
									var/obj/Projectiles/Effects/BoneYard/A2 = new/obj/Projectiles/Effects/BoneYard(c_target.loc)
									A2.IsJutsuEffect=src
									A2.Owner=src
									A2.level=J.level
								if(J.level==3)
									var/obj/Projectiles/Effects/BoneYard/A2 = new/obj/Projectiles/Effects/BoneYard(c_target.loc)
									A2.IsJutsuEffect=src
									var/obj/Projectiles/Effects/BoneYard/A3 = new/obj/Projectiles/Effects/BoneYard(c_target.loc)
									A3.IsJutsuEffect=src
									A2.Owner=src
									A3.Owner=src
									A2.level=J.level
									A3.level=J.level
								if(J.level==4)
									var/obj/Projectiles/Effects/BoneYard/A2 = new/obj/Projectiles/Effects/BoneYard(c_target.loc)
									A2.IsJutsuEffect=src
									var/obj/Projectiles/Effects/BoneYard/A3 = new/obj/Projectiles/Effects/BoneYard(c_target.loc)
									A3.IsJutsuEffect=src
									var/obj/Projectiles/Effects/BoneYard/A4 = new/obj/Projectiles/Effects/BoneYard(c_target.loc)
									A4.IsJutsuEffect=src
									A2.Owner=src
									A3.Owner=src
									A4.Owner=src
									A2.level=J.level
									A3.level=J.level
									A4.level=J.level
							else
								var/obj/Projectiles/Effects/BoneYard/A = new/obj/Projectiles/Effects/BoneYard(src.loc)
								A.IsJutsuEffect=src
								A.Owner=src
								A.layer=src.layer
								A.fightlayer=src.fightlayer
								A.level=J.level
								A.damage=J.damage+round(((src.strength / 300)+(src.precision / 300))*2*J.damage)
								step(A,src.dir)
								spawn(3)
									for(var/mob/M in view(A,0))
										if(M.dead || M.swimming) continue
										M.injutsu=1
										var/random=rand(1,4)
										if(random==1)view(src)<<sound('knife_hit1.wav',0,0,volume=100)
										if(random==2)view(src)<<sound('knife_hit2.wav',0,0,volume=100)
										if(random==3)view(src)<<sound('knife_hit3.wav',0,0,volume=100)
										if(random==4)view(src)<<sound('knife_hit4.wav',0,0,volume=100)
										M.DealDamage(A.damage,src,"NinBlue")
										if(M.henge==4||M.henge==5)M.HengeUndo()
								if(J.level==2)
									var/obj/Projectiles/Effects/BoneYard/A2 = new/obj/Projectiles/Effects/BoneYard(A.loc)
									A2.IsJutsuEffect=src
									A2.Owner=src
									A2.level=J.level
									A2.loc = get_step(A,src.dir)
									spawn(3)
										for(var/mob/M in view(A2,0))
											if(M.dead || M.swimming) continue
											M.injutsu=1
											var/random=rand(1,4)
											if(random==1)view(src)<<sound('knife_hit1.wav',0,0,volume=100)
											if(random==2)view(src)<<sound('knife_hit2.wav',0,0,volume=100)
											if(random==3)view(src)<<sound('knife_hit3.wav',0,0,volume=100)
											if(random==4)view(src)<<sound('knife_hit4.wav',0,0,volume=100)
											M.DealDamage(A.damage,src,"NinBlue")
											if(M.henge==4||M.henge==5)M.HengeUndo()
								if(J.level==3)
									var/obj/Projectiles/Effects/BoneYard/A2 = new/obj/Projectiles/Effects/BoneYard(A.loc)
									A2.IsJutsuEffect=src
									var/obj/Projectiles/Effects/BoneYard/A3 = new/obj/Projectiles/Effects/BoneYard(A.loc)
									A3.IsJutsuEffect=src
									A2.Owner=src
									A2.loc = get_step(A,src.dir)
									A3.loc = get_step(A2,src.dir)
									A3.Owner=src
									A2.level=J.level
									A3.level=J.level
									spawn(3)
										for(var/mob/M in view(A2,0))
											if(M.dead || M.swimming) continue
											M.injutsu=1
											var/random=rand(1,4)
											if(random==1)view(src)<<sound('knife_hit1.wav',0,0,volume=100)
											if(random==2)view(src)<<sound('knife_hit2.wav',0,0,volume=100)
											if(random==3)view(src)<<sound('knife_hit3.wav',0,0,volume=100)
											if(random==4)view(src)<<sound('knife_hit4.wav',0,0,volume=100)
											M.DealDamage(A.damage,src,"NinBlue")
											if(M.henge==4||M.henge==5)M.HengeUndo()
									spawn(3)
										for(var/mob/M in view(A3,0))
											if(M.dead || M.swimming) continue
											M.injutsu=1
											var/random=rand(1,4)
											if(random==1)view(src)<<sound('knife_hit1.wav',0,0,volume=100)
											if(random==2)view(src)<<sound('knife_hit2.wav',0,0,volume=100)
											if(random==3)view(src)<<sound('knife_hit3.wav',0,0,volume=100)
											if(random==4)view(src)<<sound('knife_hit4.wav',0,0,volume=100)
											M.DealDamage(A.damage,src,"NinBlue")
											if(M.henge==4||M.henge==5)M.HengeUndo()
								if(J.level==4)
									var/obj/Projectiles/Effects/BoneYard/A2 = new/obj/Projectiles/Effects/BoneYard(A.loc)
									A2.IsJutsuEffect=src
									var/obj/Projectiles/Effects/BoneYard/A3 = new/obj/Projectiles/Effects/BoneYard(A.loc)
									A3.IsJutsuEffect=src
									var/obj/Projectiles/Effects/BoneYard/A4 = new/obj/Projectiles/Effects/BoneYard(A.loc)
									A4.IsJutsuEffect=src
									A2.Owner=src
									A2.loc = get_step(A,src.dir)
									A3.loc = get_step(A2,src.dir)
									A4.loc = get_step(A3,src.dir)
									A3.Owner=src
									A4.Owner=src
									A2.level=J.level
									A3.level=J.level
									A4.level=J.level
									spawn(3)
										for(var/mob/M in view(A2,0))
											if(M.dead || M.swimming) continue
											M.injutsu=1
											var/random=rand(1,4)
											if(random==1)view(src)<<sound('knife_hit1.wav',0,0,volume=100)
											if(random==2)view(src)<<sound('knife_hit2.wav',0,0,volume=100)
											if(random==3)view(src)<<sound('knife_hit3.wav',0,0,volume=100)
											if(random==4)view(src)<<sound('knife_hit4.wav',0,0,volume=100)
											M.DealDamage(A.damage,src,"NinBlue")
											if(M.henge==4||M.henge==5)M.HengeUndo()
									spawn(3)
										for(var/mob/M in view(A3,0))
											if(M.dead || M.swimming) continue
											M.injutsu=1
											var/random=rand(1,4)
											if(random==1)view(src)<<sound('knife_hit1.wav',0,0,volume=100)
											if(random==2)view(src)<<sound('knife_hit2.wav',0,0,volume=100)
											if(random==3)view(src)<<sound('knife_hit3.wav',0,0,volume=100)
											if(random==4)view(src)<<sound('knife_hit4.wav',0,0,volume=100)
											M.DealDamage(A.damage,src,"NinBlue")
											if(M.henge==4||M.henge==5)M.HengeUndo()
									spawn(3)
										for(var/mob/M in view(A4,0))
											if(M.dead || M.swimming) continue
											M.injutsu=1
											var/random=rand(1,4)
											if(random==1)view(src)<<sound('knife_hit1.wav',0,0,volume=100)
											if(random==2)view(src)<<sound('knife_hit2.wav',0,0,volume=100)
											if(random==3)view(src)<<sound('knife_hit3.wav',0,0,volume=100)
											if(random==4)view(src)<<sound('knife_hit4.wav',0,0,volume=100)
											M.DealDamage(A.damage,src,"NinBlue")
											if(M.henge==4||M.henge==5)M.HengeUndo()
							spawn(10)if(src)
								src.firing=0
								src.canattack=1
								src.injutsu=0

		Bone_Tip()
			if(src.firing==0)
				if(src.canattack==1)
					for(var/obj/Jutsus/Bone_Tip/J in src.jutsus)
						if(src.PreJutsu(J))
							var/mob/c_target=src.Target_Get(TARGET_MOB)
							if(loc.loc:Safe!=1) src.LevelStat("Strength",((J.maxcooltime*3/20)*jutsustatexp))
							if(loc.loc:Safe!=1) src.LevelStat("Precision",((J.maxcooltime*3/20)*jutsustatexp))
							if(J.level==1) J.damage=((jutsudamage*J.Sprice)/2.5)/2
							if(J.level==2) J.damage=((jutsudamage*J.Sprice)/2)/2
							if(J.level==3) J.damage=((jutsudamage*J.Sprice)/1.5)/2
							if(J.level==4) J.damage=(jutsudamage*J.Sprice)/2
							if(J.level<4) if(loc.loc:Safe!=1) J.exp+=jutsumastery*(J.maxcooltime/20); J.Levelup()
							flick("2fist",src)
							view(src)<<sound('we_revolver_silenced_fire.ogg',0,0)
							src.firing=1
							src.canattack=0
							if(c_target)
								src.dir=get_dir(src,c_target)
								var/obj/Projectiles/Weaponry/BoneTip/A = new/obj/Projectiles/Weaponry/BoneTip(src.loc)
								A.IsJutsuEffect=src
								if(J.level==1)
									if(prob(50))A.pixel_y+=rand(3,5)
									else A.pixel_y-=rand(1,5)
									if(prob(50))A.pixel_x+=rand(3,8)
									else A.pixel_x-=rand(1,8)
								if(J.level==2)
									A.icon_state="bonetip2"
									if(prob(50))A.pixel_y+=rand(3,5)
									else A.pixel_y-=rand(1,5)
									if(prob(50))A.pixel_x+=rand(3,8)
									else A.pixel_x-=rand(1,8)
								if(J.level==3)
									A.icon_state="bonetip3"
									A.pixel_y+=rand(13,15)
								if(J.level==4)
									A.icon_state="bonetip4"
									A.pixel_y+=rand(13,15)
								A.level=J.level
								A.Owner=src
								A.layer=src.layer
								A.fightlayer=src.fightlayer
								A.damage=J.damage+round(((src.strength / 300)+(src.precision / 300))*2*J.damage)
								walk_towards(A,c_target.loc,0)
								spawn(4)if(A)walk(A,A.dir)
							else
								var/obj/Projectiles/Weaponry/BoneTip/A = new/obj/Projectiles/Weaponry/BoneTip(src.loc)
								A.IsJutsuEffect=src
								if(J.level==1)
									if(prob(50))A.pixel_y+=rand(3,5)
									else A.pixel_y-=rand(1,5)
									if(prob(50))A.pixel_x+=rand(3,8)
									else A.pixel_x-=rand(1,8)
								if(J.level==2)
									A.icon_state="bonetip2"
									if(prob(50))A.pixel_y+=rand(3,5)
									else A.pixel_y-=rand(1,5)
									if(prob(50))A.pixel_x+=rand(3,8)
									else A.pixel_x-=rand(1,8)
								if(J.level==3)
									A.icon_state="bonetip3"
									A.pixel_y+=rand(13,15)
								if(J.level==4)
									A.icon_state="bonetip4"
									A.pixel_y+=rand(13,15)
								A.level=J.level
								A.Owner=src
								A.layer=src.layer
								A.fightlayer=src.fightlayer
								A.damage=J.damage+round(((src.strength / 300)+(src.precision / 300))*2*J.damage)
								walk(A,src.dir)
							spawn(5)if(src)
								src.firing=0
								src.canattack=1

		Bone_Sensation()
			if(src.firing==0)
				if(src.canattack==1)
					for(var/obj/Jutsus/Bone_Sensation/J in src.jutsus)
						if(src.PreJutsu(J))
							if(loc.loc:Safe!=1) src.LevelStat("Ninjutsu",rand(5,7))
							flick("jutsuse",src)
							view(src)<<sound('we_revolver_silenced_fire.ogg',0,0)
							src.firing=1
							src.canattack=0
							if(J.level==1)J.damage=40
							if(J.level==2)J.damage=60
							if(J.level==3)J.damage=80
							if(J.level==4)J.damage=100
							J.damage = J.damage + src.strength*1.5 + src.ninjutsu/3
							if(J.level<4)
								if(loc.loc:Safe!=1) J.exp+=rand(2,3)
								J.Levelup()
							if(J.level==1)
								for(var/mob/M in oview(3,src))
									if(M.dead||M.swimming)continue
									if(M.dead==0)
										for(var/obj/Hits/BoneTips/N in M.SCaught)
											if(N)
												var/obj/I=new/obj/Projectiles/Effects/BoneSenHit
												I.IsJutsuEffect=src
												var/damage=J.damage+round(((src.strength / 300)+(src.precision / 300))*2*J.damage)
												M.DealDamage(damage,src,"NinBlue")
												M.overlays+=I
												M.overlays-=N
												M.SCaught-=N
												spawn(50)
													if(M)M.overlays-=I
													if(I)del(I)
							if(J.level==2)
								for(var/mob/M in oview(5,src))
									if(M.dead || M.swimming) continue
									if(M.dead==0)
										for(var/obj/Hits/BoneTips/N in M.SCaught)
											if(N)
												var/obj/I=new/obj/Projectiles/Effects/BoneSenHit
												I.IsJutsuEffect=src
												var/damage=J.damage+round(((src.strength / 300)+(src.precision / 300))*2*J.damage)
												M.DealDamage(damage,src,"NinBlue")
												M.overlays-=N
												M.overlays+=I
												M.SCaught-=N
												spawn(50)
													if(M)M.overlays-=I
													if(I)del(I)
							if(J.level==3)
								for(var/mob/M in oview(7,src))
									if(M.dead || M.swimming) continue
									if(M.dead==0)
										for(var/obj/Hits/BoneTips/N in M.SCaught)
											if(N)
												var/obj/I=new/obj/Projectiles/Effects/BoneSenHit
												I.IsJutsuEffect=src
												var/damage=J.damage+round(((src.strength / 300)+(src.precision / 300))*2*J.damage)
												M.DealDamage(damage,src,"NinBlue")
												M.overlays-=N
												M.overlays+=I
												M.SCaught-=N
												spawn(50)
													if(M)M.overlays-=I
													if(I)del(I)
							if(J.level==4)
								for(var/mob/M in oview(10,src))
									if(M.dead || M.swimming) continue
									if(M.dead==0)
										for(var/obj/Hits/BoneTips/N in M.SCaught)
											if(N)
												var/obj/I=new/obj/Projectiles/Effects/BoneSenHit
												I.IsJutsuEffect=src
												var/damage=J.damage+round(((src.strength / 300)+(src.precision / 300))*2*J.damage)
												M.DealDamage(damage,src,"NinBlue")
												M.overlays-=N
												M.overlays+=I
												M.SCaught-=N
												spawn(50)
													if(M)M.overlays-=I
													if(I)del(I)
							spawn(5)if(src)
								src.firing=0
								src.injutsu=0
								src.canattack=1

		Young_Bracken_Dance()
			if(firing)return
			if(src.firing==0 && src.canattack==1)
				for(var/obj/Jutsus/Young_Bracken_Dance/J in src.jutsus)
					if(src.PreJutsu(J))
						flick("groundjutsu",src)
						src.icon_state = "groundjutsuse"
						spawn(4)if(src)icon_state = ""
						if(loc.loc:Safe!=1) src.LevelStat("Strength",((J.maxcooltime*3/20)*jutsustatexp))
						if(loc.loc:Safe!=1) src.LevelStat("Precision",((J.maxcooltime*3/20)*jutsustatexp))
						view(src)<<sound('Skill_MashHit.wav',0,0)
						src.move=0
						src.firing=1
						src.canattack=0
						if(J.level==1) J.damage=((jutsudamage*J.Sprice)/2.5)*0.6
						if(J.level==2) J.damage=((jutsudamage*J.Sprice)/2)*0.6
						if(J.level==3) J.damage=((jutsudamage*J.Sprice)/1.5)*0.6
						if(J.level==4) J.damage=(jutsudamage*J.Sprice)*0.6
						if(J.level<4) if(loc.loc:Safe!=1) J.exp+=jutsumastery*(J.maxcooltime/20); J.Levelup()
						var/obj/O = new/obj
						O.IsJutsuEffect=src
						O.loc = src.loc
						O.x-=round(J.level*round(3)/2)
						O.y-=round(J.level*round(3)/2)
						for(var/xi=1,xi<J.level*round(3),xi++)
							for(var/yi=1,yi<J.level*round(3),yi++)
								var/obj/Projectiles/Effects/BoneYard/B = new/obj/Projectiles/Effects/BoneYard(O.loc)
								B.IsJutsuEffect=src
								B.Owner=src
								B.loc = O.loc
								B.level=J.level
								B.damage=J.damage+round(((src.strength / 300)+(src.precision / 300))*2*J.damage)
								B.x+=xi
								B.y+=yi
								if(B.loc == src.loc) del(B)
								if(B)
									spawn(3)
										for(var/mob/M in view(B,0))
											if(M.dead || M.swimming) continue
											M.injutsu=1
											var/random=rand(1,4)
											if(random==1)view(src)<<sound('knife_hit1.wav',0,0,volume=100)
											if(random==2)view(src)<<sound('knife_hit2.wav',0,0,volume=100)
											if(random==3)view(src)<<sound('knife_hit3.wav',0,0,volume=100)
											if(random==4)view(src)<<sound('knife_hit4.wav',0,0,volume=100)
											M.DealDamage(B.damage,src,"NinBlue")
											if(M.henge==4||M.henge==5)M.HengeUndo()
						src.copy=null
						src.move=1
						src.firing=0
						src.copy=null
						src.canattack=1
						src.injutsu=0

		Dance_Of_The_Kaguya()
			for(var/obj/Jutsus/Dance_Of_The_Kaguya/J in src.jutsus)
				if(src.PreJutsu(J))
					if(loc.loc:Safe!=1) src.LevelStat("Strength",((J.maxcooltime*3/30)*jutsustatexp))
					if(loc.loc:Safe!=1) src.LevelStat("Precision",((J.maxcooltime*3/30)*jutsustatexp))
					if(loc.loc:Safe!=1) src.LevelStat("Agility",((J.maxcooltime*3/30)*jutsustatexp))
					if(J.level==1) J.damage=((jutsudamage*J.Sprice)/2.5)/10
					if(J.level==2) J.damage=((jutsudamage*J.Sprice)/2)/10
					if(J.level==3) J.damage=((jutsudamage*J.Sprice)/1.5)/10
					if(J.level==4) J.damage=(jutsudamage*J.Sprice)/10
					if(J.level<4) if(loc.loc:Safe!=1) J.exp+=jutsumastery*(J.maxcooltime/20); J.Levelup()
					src.icon_state = "punchrS"
					src.move=0
					src.injutsu=1
					src.firing=1
					src.canattack=0
					var/mob/Z
					for(var/mob/M in get_step(src,src.dir))
						M.move=0
						M.injutsu=1
						M.firing=1
						M.canattack=0
						Z = M
					if(Z)
						for(var/i=0,i<5,i++)
							sleep(1)
							flick("punchr",src)
							sleep(1)
							flick("punchl",src)
							var/obj/O = new/obj
							O.loc = Z.loc
							O.layer = 200
							O.pixel_y=-16
							O.pixel_x=-16
							O.pixel_y+=rand(-5,5)
							O.pixel_x+=rand(-5,5)
							flick('KaguyaBlow.dmi',O)
							spawn(4)if(O)del(O)
							Z.DealDamage(J.damage+round(((src.strength / 450)+(src.precision / 450)+(src.agility / 450))*2*J.damage),src,"NinBlue")
						for(var/i=0,i<3,i++)
							step(src,src.dir)
							step(src,src.dir)
							sleep(2)
							flick("punchr",src)
							sleep(2)
							flick("punchl",src)
							step(Z,src.dir)
							step(Z,src.dir)
							Z.dir = get_dir(Z,src)
							var/obj/O = new/obj
							O.loc = Z.loc
							O.layer = 200
							O.pixel_y=-16
							O.pixel_x=-16
							O.pixel_y+=rand(-5,5)
							O.pixel_x+=rand(-5,5)
							flick('KaguyaBlow.dmi',O)
							spawn(4)if(O)del(O)
							Z.DealDamage(J.damage+round(((src.strength / 300)+(src.precision / 300))*2*J.damage),src,"NinBlue")
						if(Z)
							Z.move=1
							Z.injutsu=0
							Z.firing=0
							Z.canattack=1
							Z.icon_state = ""
					src.icon_state = ""
					src.move=1
					src.injutsu=0
					src.firing=0
					src.canattack=1