mob/var/tmp/list/SCaught= new/list()
mob/var/tmp/list/SCaughtPeople= new/list()
mob/proc/WeaponryDelete()
	while(src)
		sleep(600*3)
		for(var/obj/O in SCaught)
			SCaught-=O
			overlays-=O
			del(O)
obj
	Projectiles
		Weaponry
			icon='Shuriken.dmi'
			Hengable=1
			Exploding_Kunai
				icon_state="kunaist"
				pixel_y=16
				New()
					spawn(20)
						if(!src.Hit)
							walk(src,0)
							src.density=0
							var/obj/BURN = new/obj/Projectiles/Effects/MediumBurntSpot(src.loc)
							BURN.loc=src.loc
							var/obj/EXPLODE = new/obj/Projectiles/Effects/SmallExplosion(src.loc)
							EXPLODE.loc=src.loc
							var/damage=src.damage
							src.PlayAudio('Explo_StoneMed2.ogg', output = AUDIO_HEARERS)
							for(var/mob/X in view(src,3))
								if(X.dead==0)
									X.DealDamage(damage-(X.defence/5),src.Owner,"TaiOrange")
									if(istype(X,/mob/npc) && !istype(X,/mob/npc/combat))..()
									else
										X.icon_state="push"
										X.injutsu=1
										walk_away(X,src,5,0)
										spawn(10)
											if(X)
												walk(X,0)
												X.injutsu=0
												if(X.dead==0&&!X.swimming)X.icon_state=""
							src.damage=null
							src.icon_state="blank"
							src.loc=locate(0,0,0)
							spawn(150)if(src)del(src)
						else spawn(100)if(src)del(src)
					..()
				Bump(atom/O)
					if(!src.Hit)
						if(istype(O,/mob))
							var/mob/M=O
							if(M.fightlayer==src.fightlayer)
								if(M.dodge==0)
									src.density=0
									src.layer=MOB_LAYER+1
									walk(src,0)
									src.loc=M.loc
									src.Hit=1
									var/obj/BURN = new/obj/Projectiles/Effects/MediumBurntSpot(src.loc)
									BURN.loc=src.loc
									var/obj/EXPLODE = new/obj/Projectiles/Effects/SmallExplosion(src.loc)
									EXPLODE.loc=src.loc
									var/damage=src.damage
									src.PlayAudio('Explo_StoneMed2.ogg', output = AUDIO_HEARERS)
									for(var/mob/X in view(src,3))
										if(X.dead==0)
											X.DealDamage(damage,src.Owner,"TaiOrange")
											if(istype(X,/mob/npc) && !istype(X,/mob/npc/combat))
												..()
											else
												X.icon_state="push"
												X.injutsu=1
												walk_away(X,src,5,0)
												spawn(10)
													if(X)
														walk(X,0)
														X.injutsu=0
														if(X.dead==0&&!X.swimming)
															X.icon_state=""
									src.damage=null
									src.icon_state="blank"
									if(M.henge==4||M.henge==5)
										M.HengeUndo()
									spawn(1)
										src.loc=locate(0,0,0)
										spawn(400) del(src)

							else
								if(M.fightlayer=="Normal"&&src.fightlayer=="HighGround")
									if(M.dodge==0)
										src.density=0
										src.layer=MOB_LAYER+1
										walk(src,0)
										src.loc=O.loc
										src.Hit=1
										var/obj/BURN = new/obj/Projectiles/Effects/MediumBurntSpot(src.loc)
										BURN.loc=src.loc
										var/obj/EXPLODE = new/obj/Projectiles/Effects/SmallExplosion(src.loc)
										EXPLODE.loc=src.loc
										var/damage=src.damage
										src.PlayAudio('Explo_StoneMed2.ogg', output = AUDIO_HEARERS)
										for(var/mob/X in view(src,3))
											if(X.dead==0)
												X.DealDamage(damage,src.Owner,"TaiOrange")
												if(istype(X,/mob/npc) && !istype(X,/mob/npc/combat)) ..()
												else
													X.icon_state="push"
													X.injutsu=1
													walk_away(X,src,5,0)
													spawn(10)
														if(X)
															walk(X,0)
															X.injutsu=0
															if(X.dead==0&&!X.swimming)X.icon_state=""
										src.damage=null
										src.icon_state="blank"
										if(M.henge==4||M.henge==5)
											M.HengeUndo()
										spawn(1)
											src.loc=locate(0,0,0)
											spawn(400)if(src)del(src)
								else src.loc=M.loc
						else
							if(istype(O,/turf))
								var/turf/T=O
								if(T.fightlayer=="HighGround"&&src.fightlayer=="Normal")src.loc=locate(T.x,T.y,T.z)
								if(src.fightlayer==T.fightlayer)
									src.density=0
									var/obj/BURN = new/obj/Projectiles/Effects/MediumBurntSpot(src.loc)
									BURN.loc=src.loc
									var/obj/EXPLODE = new/obj/Projectiles/Effects/SmallExplosion(src.loc)
									EXPLODE.loc=src.loc
									var/damage=src.damage
									src.PlayAudio('Explo_StoneMed2.ogg', output = AUDIO_HEARERS)
									for(var/mob/M in view(src,3))
										if(M.dead==0)
											M.DealDamage(damage,src.Owner,"TaiOrange")
											if(istype(M,/mob/npc) && !istype(M,/mob/npc/combat)) ..()
											else
												M.icon_state="push"
												M.injutsu=1
												walk_away(M,src,5,0)
												spawn(10)
													if(M)
														walk(M,0)
														M.injutsu=0
														if(M.dead==0&&!M.swimming)M.icon_state=""
									src.damage=null
									src.icon_state="blank"
									walk(src,0)
									src.loc=locate(T.x,T.y,T.z)
									src.Hit=1
									src.loc=locate(0,0,0)
									spawn(90)if(src)del(src)
							if(istype(O,/obj))
								var/obj/OB=O
								if(OB.fightlayer=="HighGround"&&src.fightlayer=="Normal")src.loc=locate(OB.x,OB.y,OB.z)
								if(src.fightlayer==OB.fightlayer)
									src.density=0
									var/obj/BURN = new/obj/Projectiles/Effects/MediumBurntSpot(src.loc)
									BURN.loc=src.loc
									var/obj/EXPLODE = new/obj/Projectiles/Effects/SmallExplosion(src.loc)
									EXPLODE.loc=src.loc
									var/damage=src.damage
									src.PlayAudio('Explo_StoneMed2.ogg', output = AUDIO_HEARERS)
									for(var/mob/M in view(src,3))
										if(M.dead==0)
											M.DealDamage(damage,src.Owner,"TaiOrange")
											if(istype(M,/mob/npc) && !istype(M,/mob/npc/combat)) ..()
											else
												M.icon_state="push"
												M.injutsu=1
												walk_away(M,src,5,0)
												spawn(10)
													if(M)
														walk(M,0)
														M.injutsu=0
														if(M.dead==0&&!M.swimming)M.icon_state=""
									src.damage=null
									src.icon_state="blank"
									walk(src,0)
									src.loc=locate(OB.x,OB.y,OB.z)
									src.Hit=1
									src.loc=locate(0,0,0)
									spawn(90)if(src)del(src)
			Magma_Needles
				icon='Magma_Needles.dmi'
				icon_state=""
				damage=3
				pixel_x=-16
				pixel_y=-16
				New()
					spawn(20)
						if(!src.Hit)
							walk(src,0)
							del(src)
						else
							spawn(100)
								if(src)
									del(src)
					..()
				Bump(atom/O)
					if(!src.Hit)
						if(istype(O,/mob))
							var/mob/M=O
							var/mob/Owner=src.Owner
							if(M.fightlayer==src.fightlayer)
								if(M.dodge==0)
									src.density=0
									if(prob(50))
										src.PlayAudio('KickHit.ogg', output = AUDIO_HEARERS)
									else
										src.PlayAudio('KickHit.ogg', output = AUDIO_HEARERS)
									src.layer=MOB_LAYER+1
									walk(src,0)
									src.loc=O.loc
									src.Hit=1
									var/undefendedhit=round(src.damage+M.defence/6)
									if(undefendedhit<=0) undefendedhit=1
									M.DealDamage(undefendedhit,src.Owner,"TaiOrange")
									spawn() if(M) M.Bleed()
									if(Owner)
										if(Owner.loc.loc:Safe!=1) Owner.LevelStat("Strength",1)
										if(Owner.loc.loc:Safe!=1) Owner.LevelStat("strength",rand(1,4))
									if(prob(15))
										M.speeding=0
									if(istype(O,/mob/npc) && !istype(O,/mob/npc/combat))
										..()
									if(M.henge==4||M.henge==5)
										M.HengeUndo()
									spawn(1)
										src.loc=locate(0,0,0)
										spawn(400)
											if(src)
												del(src)
								else
									flick("dodge",M)
									if(M.loc.loc:Safe!=1) M.LevelStat("Agility",rand(3,6))
									src.loc=M.loc

							else
								if(M.fightlayer=="Normal"&&src.fightlayer=="HighGround")
									if(M.dodge==0)
										src.density=0
										if(prob(50))
											src.PlayAudio('KickHit.ogg', output = AUDIO_HEARERS)
										else
											src.PlayAudio('KickHit.ogg', output = AUDIO_HEARERS)
										src.layer=MOB_LAYER+1
										walk(src,0)
										src.loc=O.loc
										src.Hit=1
										var/undefendedhit=round(src.damage+M.defence/6)
										if(undefendedhit<=0) undefendedhit=1
										M.DealDamage(undefendedhit,src.Owner,"TaiOrange")
										spawn() if(M) M.Bleed()
										if(Owner.loc.loc:Safe!=1) Owner.LevelStat("Strength",1)
										if(Owner.loc.loc:Safe!=1) Owner.LevelStat("strength",rand(1,4))
										if(prob(15))
											M.speeding=0
										if(istype(O,/mob/npc) && !istype(O,/mob/npc/combat))
											..()
										if(M.henge==4||M.henge==5)
											M.HengeUndo()
										spawn(1)
											src.loc=locate(0,0,0)
											spawn(400) del(src)
									else
										flick("dodge",M)
										if(M.loc.loc:Safe!=1) M.LevelStat("Agility",rand(3,6))
										src.loc=M.loc
								else
									src.loc=M.loc
						else
							if(istype(O,/obj/Projectiles))
								var/obj/Projectiles/OBJ=O
								if(OBJ.Owner)
									var/mob/OBOwner=OBJ.Owner
									if(OBOwner==src.Owner)
										if(istype(OBJ,/obj/Projectiles/Weaponry/ChidoriNeedle)) del(src)
										src.loc=OBJ.loc
									else
										if(istype(OBJ,/obj/Projectiles/Effects/ClayBird))
											OBJ.Hit=1
							else
								if(istype(O,/turf))
									var/turf/T=O
									if(T.fightlayer=="HighGround"&&src.fightlayer=="Normal")
										src.loc=locate(T.x,T.y,T.z)
									if(src.fightlayer==T.fightlayer)
										src.density=0
										if(prob(50))
											src.PlayAudio('KickHit.ogg', output = AUDIO_HEARERS)
										else
											src.PlayAudio('KickHit.ogg', output = AUDIO_HEARERS)
										del(src)
								if(istype(O,/obj))
									var/obj/OB=O
									if(OB.fightlayer=="HighGround"&&src.fightlayer=="Normal")
										src.loc=locate(OB.x,OB.y,OB.z)
									if(src.fightlayer==OB.fightlayer)
										src.density=0
										if(prob(50))
											src.PlayAudio('KickHit.ogg', output = AUDIO_HEARERS)
										else
											src.PlayAudio('KickHit.ogg', output = AUDIO_HEARERS)
										del(src)
			Shuriken
				icon_state="shuri"
				damage=5
				pixel_y=16
				New()
					spawn(20)
						if(!src.Hit)
							walk(src,0)
							src.density=0
							src.icon_state="shuriland"
							spawn(80)if(src)del(src)
						else spawn(100)if(src)del(src)
					..()
				Bump(atom/O)
					if(!src.Hit)
						if(istype(O,/mob))
							var/mob/M=O
							var/mob/Owner=src.Owner
							if(M.fightlayer==src.fightlayer)
								if(M.dodge==0)
									src.density=0
									if(prob(50))src.PlayAudio('SharpHit_Short2.wav', output = AUDIO_HEARERS)
									else src.PlayAudio('SharpHit_Short.wav', output = AUDIO_HEARERS)
									src.layer=MOB_LAYER+1
									walk(src,0)
									src.loc=O.loc
									src.Hit=1
									var/undefendedhit=round(src.damage)
									if(undefendedhit<=0) undefendedhit=1
									M.DealDamage(undefendedhit-(M.defence/5),src.Owner,"TaiOrange")
									spawn() if(M) M.Bleed()
									if(Owner.loc.loc:Safe!=1) Owner.LevelStat("Strength",rand(2,4))
									if(prob(45))M.speeding=0
									if(istype(O,/mob/npc) && !istype(O,/mob/npc/combat))
										..()
									else
										if(M.amounthits<6)
											M.amounthits++
											if(prob(50))
												var/obj/I=new/obj/Hits/Shurikens/Hit
												if(prob(50))
													I.pixel_y+=rand(1,5)
												else
													I.pixel_y-=rand(1,5)
												if(prob(50))
													I.pixel_x+=rand(1,5)
												else
													I.pixel_x-=rand(1,5)
												M.SCaught+=I
												M.overlays+=I
												spawn(370) M.overlays-=I
											else
												if(prob(50))
													var/obj/I=new/obj/Hits/Shurikens/Hit2
													if(prob(50))
														I.pixel_y+=rand(1,5)
													else
														I.pixel_y-=rand(1,5)
													if(prob(50))
														I.pixel_x+=rand(1,5)
													else
														I.pixel_x-=rand(1,5)
													M.SCaught+=I
													M.overlays+=I
													spawn(370) M.overlays-=I
												else
													var/obj/I=new/obj/Hits/Shurikens/Hit3
													if(prob(50))
														I.pixel_y+=rand(1,5)
													else
														I.pixel_y-=rand(1,5)
													if(prob(50))
														I.pixel_x+=rand(5,8)
													else
														I.pixel_x-=rand(1,3)
													M.SCaught+=I
													M.overlays+=I
													spawn(370) M.overlays-=I
									if(M.henge==4||M.henge==5)M.HengeUndo()
									M.Death(Owner)
									spawn(1)
										src.loc=locate(0,0,0)
										spawn(400) del(src)
								else
									flick("dodge",M)
									if(M.loc.loc:Safe!=1) M.LevelStat("Agility",rand(3,6))
									del(src)
							else
								if(M.fightlayer=="Normal"&&src.fightlayer=="HighGround")
									if(M.dodge==0)
										src.density=0
										if(prob(50))
											src.PlayAudio('SharpHit_Short2.wav', output = AUDIO_HEARERS)
										else
											src.PlayAudio('SharpHit_Short.wav', output = AUDIO_HEARERS)
										src.layer=MOB_LAYER+1
										walk(src,0)
										src.loc=O.loc
										src.Hit=1
										var/undefendedhit=round(src.damage)
										if(undefendedhit<=0) undefendedhit=1
										M.DealDamage(undefendedhit-(M.defence/5),src.Owner,"TaiOrange")
										spawn() if(M) M.Bleed()
										if(Owner.loc.loc:Safe!=1) Owner.LevelStat("Strength",rand(2,4))
										if(prob(45))
											M.speeding=0
										if(istype(O,/mob/npc) && !istype(O,/mob/npc/combat))
											..()
										else
											if(M.amounthits<6)
												M.amounthits++
												if(prob(50))
													var/obj/I=new/obj/Hits/Shurikens/Hit
													if(prob(50))
														I.pixel_y+=rand(1,5)
													else
														I.pixel_y-=rand(1,5)
													if(prob(50))
														I.pixel_x+=rand(1,5)
													else
														I.pixel_x-=rand(1,5)
													M.SCaught+=I
													M.overlays+=I
													spawn(370) M.overlays-=I
												else
													if(prob(50))
														var/obj/I=new/obj/Hits/Shurikens/Hit2
														if(prob(50))
															I.pixel_y+=rand(1,5)
														else
															I.pixel_y-=rand(1,5)
														if(prob(50))
															I.pixel_x+=rand(1,5)
														else
															I.pixel_x-=rand(1,5)
														M.SCaught+=I
														M.overlays+=I
														spawn(370) M.overlays-=I
													else
														var/obj/I=new/obj/Hits/Shurikens/Hit3
														if(prob(50))
															I.pixel_y+=rand(1,5)
														else
															I.pixel_y-=rand(1,5)
														if(prob(50))
															I.pixel_x+=rand(5,8)
														else
															I.pixel_x-=rand(1,3)
														M.SCaught+=I
														M.overlays+=I
														spawn(370) M.overlays-=I
										if(M.henge==4||M.henge==5)M.HengeUndo()
										M.Death(Owner)
										spawn(1)
											src.loc=locate(0,0,0)
											spawn(400) del(src)
									else
										flick("dodge",M)
										if(M.loc.loc:Safe!=1) M.LevelStat("Agility",rand(3,6))
										del(src)
								else
									src.loc=M.loc
						else
							if(istype(O,/turf))
								var/turf/T=O
								if(T.fightlayer=="HighGround"&&src.fightlayer=="Normal")
									src.loc=locate(T.x,T.y,T.z)
								if(src.fightlayer==T.fightlayer)
									src.density=0
									if(prob(50))
										src.PlayAudio('sclang.ogg', output = AUDIO_HEARERS)
									else
										src.PlayAudio('sclang2.ogg', output = AUDIO_HEARERS)
									walk(src,0)
									src.loc=locate(T.x,T.y,T.z)
									src.Hit=1
									if(prob(50))
										var/obj/I=new/obj/Hits/Shurikens/Hit
										if(prob(50))
											I.pixel_y+=rand(1,5)
										else
											I.pixel_y-=rand(1,5)
										if(prob(50))
											I.pixel_x+=rand(1,5)
										else
											I.pixel_x-=rand(1,5)
										O.overlays+=I
										spawn(50)
											if(O)
												O.overlays-=I
												del(I)
									else
										if(prob(50))
											var/obj/I=new/obj/Hits/Shurikens/Hit2
											if(prob(50))
												I.pixel_y+=rand(1,5)
											else
												I.pixel_y-=rand(1,5)
											if(prob(50))
												I.pixel_x+=rand(1,5)
											else
												I.pixel_x-=rand(1,5)
											O.overlays+=I
											spawn(50)
												if(O)
													O.overlays-=I
													del(I)
										else
											var/obj/I=new/obj/Hits/Shurikens/Hit3
											if(prob(50))
												I.pixel_y+=rand(1,5)
											else
												I.pixel_y-=rand(1,5)
											if(prob(50))
												I.pixel_x+=rand(5,8)
											else
												I.pixel_x-=rand(1,3)
											O.overlays+=I
											spawn(50)
												if(O)
													O.overlays-=I
													del(I)
									src.loc=locate(0,0,0)
									spawn(90)
										if(src)
											del(src)
							if(istype(O,/obj))
								var/obj/OB=O
								if(OB.fightlayer=="HighGround"&&src.fightlayer=="Normal")
									src.loc=locate(OB.x,OB.y,OB.z)
								if(src.fightlayer==OB.fightlayer)
									src.density=0
									if(prob(50))
										src.PlayAudio('sclang.ogg', output = AUDIO_HEARERS)
									else
										src.PlayAudio('sclang2.ogg', output = AUDIO_HEARERS)
									walk(src,0)
									src.loc=locate(OB.x,OB.y,OB.z)
									src.Hit=1
									if(prob(50))
										var/obj/I=new/obj/Hits/Shurikens/Hit
										if(prob(50))
											I.pixel_y+=rand(1,5)
										else
											I.pixel_y-=rand(1,5)
										if(prob(50))
											I.pixel_x+=rand(1,5)
										else
											I.pixel_x-=rand(1,5)
										O.overlays+=I
										spawn(50)
											if(O)
												O.overlays-=I
												del(I)
									else
										if(prob(50))
											var/obj/I=new/obj/Hits/Shurikens/Hit2
											if(prob(50))
												I.pixel_y+=rand(1,5)
											else
												I.pixel_y-=rand(1,5)
											if(prob(50))
												I.pixel_x+=rand(1,5)
											else
												I.pixel_x-=rand(1,5)
											O.overlays+=I
											spawn(50)
												if(O)
													O.overlays-=I
													del(I)
										else
											var/obj/I=new/obj/Hits/Shurikens/Hit3
											if(prob(50))
												I.pixel_y+=rand(1,5)
											else
												I.pixel_y-=rand(1,5)
											if(prob(50))
												I.pixel_x+=rand(5,8)
											else
												I.pixel_x-=rand(1,3)
											O.overlays+=I
											spawn(50)
												if(O)
													O.overlays-=I
													del(I)
									src.loc=locate(0,0,0)
									spawn(90)
										if(src)
											del(src)
			Kunai
				icon_state="kunai"
				damage=10
				pixel_y=16
				New()
					spawn(20)
						if(!src.Hit)
							walk(src,0)
							src.density=0
							src.icon_state="kunailand"
							spawn(80)
								del(src)
						else
							spawn(100)
								if(src)
									del(src)
					..()
				Bump(atom/O)
					if(!src.Hit)
						if(istype(O,/mob))
							var/mob/M=O
							var/mob/Owner=src.Owner
							if(M.fightlayer==src.fightlayer)
								if(M.dodge==0)
									src.density=0
									if(prob(50))
										src.PlayAudio('SharpHit_Short2.wav', output = AUDIO_HEARERS)
									else
										src.PlayAudio('SharpHit_Short.wav', output = AUDIO_HEARERS)
									src.layer=MOB_LAYER+1
									walk(src,0)
									src.loc=O.loc
									src.Hit=1
									var/undefendedhit=round(src.damage)
									if(undefendedhit<=0) undefendedhit=1
									M.DealDamage(undefendedhit-(M.defence/5),src.Owner,"TaiOrange")
									spawn() if(M) M.Bleed()
									if(Owner.loc.loc:Safe!=1) Owner.LevelStat("Strength",rand(2,4))
									if(prob(75))
										M.speeding=0
									if(istype(O,/mob/npc) && !istype(O,/mob/npc/combat))
										..()
									else
										if(M.amounthits<6)
											M.amounthits++
											if(prob(50))
												var/obj/I=new/obj/Hits/Kunai/Hit
												if(prob(50))
													I.pixel_y+=rand(1,5)
												else
													I.pixel_y-=rand(1,5)
												if(prob(50))
													I.pixel_x+=rand(1,5)
												else
													I.pixel_x-=rand(1,5)
												M.SCaught+=I
												M.overlays+=I
												spawn(370) M.overlays-=I
											else
												if(prob(50))
													var/obj/I=new/obj/Hits/Kunai/Hit2
													if(prob(50))
														I.pixel_y+=rand(1,5)
													else
														I.pixel_y-=rand(1,5)
													if(prob(50))
														I.pixel_x+=rand(1,5)
													else
														I.pixel_x-=rand(1,5)
													M.SCaught+=I
													M.overlays+=I
													spawn(370) M.overlays-=I
												else
													var/obj/I=new/obj/Hits/Kunai/Hit3
													if(prob(50))
														I.pixel_y+=rand(1,5)
													else
														I.pixel_y-=rand(1,5)
													if(prob(50))
														I.pixel_x+=rand(5,8)
													else
														I.pixel_x-=rand(1,3)
													M.SCaught+=I
													M.overlays+=I
													spawn(370) M.overlays-=I
									if(M.henge==4||M.henge==5)M.HengeUndo()
									M.Death(Owner)
									spawn(1)
										src.loc=locate(0,0,0)
										spawn(400) del(src)
								else
									flick("dodge",M)
									if(M.loc.loc:Safe!=1) M.LevelStat("Agility",rand(3,6))
									del(src)

							else
								if(M.fightlayer=="Normal"&&src.fightlayer=="HighGround")
									if(M.dodge==0)
										src.density=0
										if(prob(50))
											src.PlayAudio('SharpHit_Short2.wav', output = AUDIO_HEARERS)
										else
											src.PlayAudio('SharpHit_Short.wav', output = AUDIO_HEARERS)
										src.layer=MOB_LAYER+1
										walk(src,0)
										src.loc=O.loc
										src.Hit=1
										var/undefendedhit=round(src.damage)
										if(undefendedhit<=0) undefendedhit=1
										M.DealDamage(undefendedhit-(M.defence/5),src.Owner,"TaiOrange")
										spawn() if(M) M.Bleed()
										if(Owner.loc.loc:Safe!=1) Owner.LevelStat("Strength",rand(2,4))
										if(prob(75))
											M.speeding=0
										if(istype(O,/mob/npc) && !istype(O,/mob/npc/combat))
											..()
										else
											if(M.amounthits<6)
												M.amounthits++
												if(prob(50))
													var/obj/I=new/obj/Hits/Kunai/Hit
													if(prob(50))
														I.pixel_y+=rand(1,5)
													else
														I.pixel_y-=rand(1,5)
													if(prob(50))
														I.pixel_x+=rand(1,5)
													else
														I.pixel_x-=rand(1,5)
													M.SCaught+=I
													M.overlays+=I
													spawn(370) M.overlays-=I
												else
													if(prob(50))
														var/obj/I=new/obj/Hits/Kunai/Hit2
														if(prob(50))
															I.pixel_y+=rand(1,5)
														else
															I.pixel_y-=rand(1,5)
														if(prob(50))
															I.pixel_x+=rand(1,5)
														else
															I.pixel_x-=rand(1,5)
														M.SCaught+=I
														M.overlays+=I
													else
														var/obj/I=new/obj/Hits/Kunai/Hit3
														if(prob(50))
															I.pixel_y+=rand(1,5)
														else
															I.pixel_y-=rand(1,5)
														if(prob(50))
															I.pixel_x+=rand(5,8)
														else
															I.pixel_x-=rand(1,3)
														M.SCaught+=I
														M.overlays+=I
														spawn(370) M.overlays-=I
										if(M.henge==4||M.henge==5)
											M.HengeUndo()
										M.Death(Owner)
										spawn(1)
											spawn(400) del(src)
											src.loc=locate(0,0,0)
									else
										flick("dodge",M)
										if(M.loc.loc:Safe!=1) M.LevelStat("Agility",rand(3,6))
										del(src)
								else
									src.loc=M.loc
						else
							if(istype(O,/turf))
								var/turf/T=O
								if(T.fightlayer=="HighGround"&&src.fightlayer=="Normal")
									src.loc=locate(T.x,T.y,T.z)
								if(src.fightlayer==T.fightlayer)
									src.density=0
									if(prob(50))
										src.PlayAudio('sclang.ogg', output = AUDIO_HEARERS)
									else
										src.PlayAudio('sclang2.ogg', output = AUDIO_HEARERS)
									walk(src,0)
									src.loc=locate(T.x,T.y,T.z)
									src.Hit=1
									if(prob(50))
										var/obj/I=new/obj/Hits/Needle/Hit
										if(prob(50))
											I.pixel_y+=rand(1,9)
										else
											I.pixel_y-=rand(1,9)
										if(prob(50))
											I.pixel_x+=rand(1,5)
										else
											I.pixel_x-=rand(1,5)
										O.overlays+=I
										spawn(50)
											if(T)
												T.overlays-=I
												del(I)
									else
										if(prob(50))
											var/obj/I=new/obj/Hits/Needle/Hit2
											if(prob(50))
												I.pixel_y+=rand(1,9)
											else
												I.pixel_y-=rand(1,9)
											if(prob(50))
												I.pixel_x+=rand(1,5)
											else
												I.pixel_x-=rand(1,5)
											O.overlays+=I
											spawn(50)
												if(O)
													O.overlays-=I
													del(I)
										else
											var/obj/I=new/obj/Hits/Needle/Hit3
											if(prob(50))
												I.pixel_y+=rand(1,9)
											else
												I.pixel_y-=rand(1,9)
											if(prob(50))
												I.pixel_x+=rand(5,8)
											else
												I.pixel_x-=rand(1,3)
											O.overlays+=I
											spawn(50)
												if(O)
													O.overlays-=I
													del(I)
									src.loc=locate(0,0,0)
									spawn(90)
										if(src)
											del(src)
							if(istype(O,/obj))
								var/obj/OB=O
								if(OB.fightlayer=="HighGround"&&src.fightlayer=="Normal")
									src.loc=locate(OB.x,OB.y,OB.z)
								if(src.fightlayer==OB.fightlayer)
									src.density=0
									if(prob(50))
										src.PlayAudio('sclang.ogg', output = AUDIO_HEARERS)
									else
										src.PlayAudio('sclang2.ogg', output = AUDIO_HEARERS)
									walk(src,0)
									src.loc=locate(OB.x,OB.y,OB.z)
									src.Hit=1
									if(prob(50))
										var/obj/I=new/obj/Hits/Kunai/Hit
										if(prob(50))
											I.pixel_y+=rand(1,5)
										else
											I.pixel_y-=rand(1,5)
										if(prob(50))
											I.pixel_x+=rand(1,5)
										else
											I.pixel_x-=rand(1,5)
										O.overlays+=I
										spawn(50)
											if(O)
												O.overlays-=I
												del(I)
									else
										if(prob(50))
											var/obj/I=new/obj/Hits/Kunai/Hit2
											if(prob(50))
												I.pixel_y+=rand(1,5)
											else
												I.pixel_y-=rand(1,5)
											if(prob(50))
												I.pixel_x+=rand(1,5)
											else
												I.pixel_x-=rand(1,5)
											O.overlays+=I
											spawn(50)
												if(O)
													O.overlays-=I
													del(I)
										else
											var/obj/I=new/obj/Hits/Kunai/Hit3
											if(prob(50))
												I.pixel_y+=rand(1,5)
											else
												I.pixel_y-=rand(1,5)
											if(prob(50))
												I.pixel_x+=rand(5,8)
											else
												I.pixel_x-=rand(1,3)
											O.overlays+=I
											spawn(50)
												if(O)
													O.overlays-=I
													del(I)
									src.loc=locate(0,0,0)
									spawn(90)
										if(src)
											del(src)
			Needle
				icon_state="needle"
				damage=3
				pixel_y=16
				New()
					spawn(20)
						if(!src.Hit)
							walk(src,0)
							src.density=0
							src.icon_state="needleland"
							spawn(80)
								del(src)
						else
							spawn(100)
								if(src)
									del(src)
					..()
				Bump(atom/O)
					if(!src.Hit)
						if(istype(O,/mob))
							var/mob/M=O
							var/mob/Owner=src.Owner
							if(M.fightlayer==src.fightlayer)
								if(M.dodge==0)
									src.density=0
									if(prob(50))
										src.PlayAudio('SharpHit_Short2.wav', output = AUDIO_HEARERS)
									else
										src.PlayAudio('SharpHit_Short.wav', output = AUDIO_HEARERS)
									src.layer=MOB_LAYER+1
									walk(src,0)
									src.loc=O.loc
									src.Hit=1
									var/undefendedhit=round(src.damage)
									if(undefendedhit<=0) undefendedhit=1
									M.DealDamage(undefendedhit-(M.defence/5),src.Owner,"TaiOrange")
									spawn() if(M) M.Bleed()
									if(Owner.loc.loc:Safe!=1) Owner.LevelStat("Strength",rand(2,4))
									if(prob(30))
										M.speeding=0
									if(istype(O,/mob/npc) && !istype(O,/mob/npc/combat))
										..()
									else
										if(M.amounthits<6)
											M.amounthits++
											if(prob(50))
												var/obj/I=new/obj/Hits/Needle/Hit
												if(prob(50))
													I.pixel_y+=rand(1,9)
												else
													I.pixel_y-=rand(1,9)
												if(prob(50))
													I.pixel_x+=rand(1,5)
												else
													I.pixel_x-=rand(1,5)
												M.SCaught+=I
												M.overlays+=I
												spawn(370) M.overlays-=I
											else
												if(prob(50))
													var/obj/I=new/obj/Hits/Needle/Hit2
													if(prob(50))
														I.pixel_y+=rand(1,9)
													else
														I.pixel_y-=rand(1,9)
													if(prob(50))
														I.pixel_x+=rand(1,5)
													else
														I.pixel_x-=rand(1,5)
													M.SCaught+=I
													M.overlays+=I
													spawn(370) M.overlays-=I
												else
													var/obj/I=new/obj/Hits/Needle/Hit3
													if(prob(50))
														I.pixel_y+=rand(1,9)
													else
														I.pixel_y-=rand(1,9)
													if(prob(50))
														I.pixel_x+=rand(5,8)
													else
														I.pixel_x-=rand(1,3)
													M.SCaught+=I
													M.overlays+=I
													spawn(370) M.overlays-=I
									if(M.henge==4||M.henge==5)
										M.HengeUndo()
									M.Death(Owner)
									spawn(1)
										src.loc=locate(0,0,0)
										spawn(400) del(src)
								else
									flick("dodge",M)
									if(M.loc.loc:Safe!=1) M.LevelStat("Agility",rand(3,6))
									del(src)

							else
								if(M.fightlayer=="Normal"&&src.fightlayer=="HighGround")
									if(M.dodge==0)
										src.density=0
										if(prob(50))
											src.PlayAudio('SharpHit_Short2.wav', output = AUDIO_HEARERS)
										else
											src.PlayAudio('SharpHit_Short.wav', output = AUDIO_HEARERS)
										src.layer=MOB_LAYER+1
										walk(src,0)
										src.loc=O.loc
										src.Hit=1
										var/undefendedhit=round(src.damage)
										if(undefendedhit<=0) undefendedhit=1
										M.DealDamage(undefendedhit-(M.defence/5),src.Owner,"TaiOrange")
										spawn() if(M) M.Bleed()
										if(Owner.loc.loc:Safe!=1) Owner.LevelStat("Strength",rand(2,4))
										if(prob(75))
											M.speeding=0
										if(istype(O,/mob/npc) && !istype(O,/mob/npc/combat))
											..()
										else
											if(M.amounthits<6)
												M.amounthits++
												if(prob(50))
													var/obj/I=new/obj/Hits/Kunai/Hit
													if(prob(50))
														I.pixel_y+=rand(1,9)
													else
														I.pixel_y-=rand(1,9)
													if(prob(50))
														I.pixel_x+=rand(1,5)
													else
														I.pixel_x-=rand(1,5)
													M.SCaught+=I
													M.overlays+=I
													spawn(370) M.overlays-=I
												else
													if(prob(50))
														var/obj/I=new/obj/Hits/Needle/Hit2
														if(prob(50))
															I.pixel_y+=rand(1,9)
														else
															I.pixel_y-=rand(1,9)
														if(prob(50))
															I.pixel_x+=rand(1,5)
														else
															I.pixel_x-=rand(1,5)
														M.SCaught+=I
														M.overlays+=I
														spawn(370) M.overlays-=I
													else
														var/obj/I=new/obj/Hits/Needle/Hit3
														if(prob(50))
															I.pixel_y+=rand(1,9)
														else
															I.pixel_y-=rand(1,9)
														if(prob(50))
															I.pixel_x+=rand(5,8)
														else
															I.pixel_x-=rand(1,3)
														M.SCaught+=I
														M.overlays+=I
														spawn(370) M.overlays-=I
										if(M.henge==4||M.henge==5)
											M.HengeUndo()
										M.Death(Owner)
										spawn(1)
											src.loc=locate(0,0,0)
											spawn(400) del(src)
									else
										flick("dodge",M)
										if(M.loc.loc:Safe!=1) M.LevelStat("Agility",rand(3,6))

										del(src)
								else
									src.loc=M.loc
						else
							if(istype(O,/turf))
								var/turf/T=O
								if(T.fightlayer=="HighGround"&&src.fightlayer=="Normal")
									src.loc=locate(T.x,T.y,T.z)
								if(src.fightlayer==T.fightlayer)
									src.density=0
									if(prob(50))
										src.PlayAudio('sclang.ogg', output = AUDIO_HEARERS)
									else
										src.PlayAudio('sclang2.ogg', output = AUDIO_HEARERS)
									walk(src,0)
									src.loc=locate(T.x,T.y,T.z)
									src.Hit=1
									if(prob(50))
										var/obj/I=new/obj/Hits/Needle/Hit
										if(prob(50))
											I.pixel_y+=rand(1,9)
										else
											I.pixel_y-=rand(1,9)
										if(prob(50))
											I.pixel_x+=rand(1,5)
										else
											I.pixel_x-=rand(1,5)
										O.overlays+=I
										spawn(50)
											if(T)
												T.overlays-=I
												del(I)
									else
										if(prob(50))
											var/obj/I=new/obj/Hits/Needle/Hit2
											if(prob(50))
												I.pixel_y+=rand(1,9)
											else
												I.pixel_y-=rand(1,9)
											if(prob(50))
												I.pixel_x+=rand(1,5)
											else
												I.pixel_x-=rand(1,5)
											O.overlays+=I
											spawn(50)
												if(O)
													O.overlays-=I
													del(I)
										else
											var/obj/I=new/obj/Hits/Needle/Hit3
											if(prob(50))
												I.pixel_y+=rand(1,9)
											else
												I.pixel_y-=rand(1,9)
											if(prob(50))
												I.pixel_x+=rand(5,8)
											else
												I.pixel_x-=rand(1,3)
											O.overlays+=I
											spawn(50)
												if(O)
													O.overlays-=I
													del(I)
									src.loc=locate(0,0,0)
									spawn(90)
										if(src)
											del(src)
							if(istype(O,/obj))
								var/obj/OB=O
								if(OB.fightlayer=="HighGround"&&src.fightlayer=="Normal")
									src.loc=locate(OB.x,OB.y,OB.z)
								if(src.fightlayer==OB.fightlayer)
									src.density=0
									if(prob(50))
										src.PlayAudio('sclang.ogg', output = AUDIO_HEARERS)
									else
										src.PlayAudio('sclang2.ogg', output = AUDIO_HEARERS)
									walk(src,0)
									src.loc=locate(OB.x,OB.y,OB.z)
									src.Hit=1
									if(prob(50))
										var/obj/I=new/obj/Hits/Needle/Hit
										if(prob(50))
											I.pixel_y+=rand(1,9)
										else
											I.pixel_y-=rand(1,9)
										if(prob(50))
											I.pixel_x+=rand(1,5)
										else
											I.pixel_x-=rand(1,5)
										O.overlays+=I
										spawn(50)
											if(O)
												O.overlays-=I
												del(I)
									else
										if(prob(50))
											var/obj/I=new/obj/Hits/Needle/Hit2
											if(prob(50))
												I.pixel_y+=rand(1,9)
											else
												I.pixel_y-=rand(1,9)
											if(prob(50))
												I.pixel_x+=rand(1,5)
											else
												I.pixel_x-=rand(1,5)
											O.overlays+=I
											spawn(50)
												if(O)
													O.overlays-=I
													del(I)
										else
											var/obj/I=new/obj/Hits/Needle/Hit3
											if(prob(50))
												I.pixel_y+=rand(1,9)
											else
												I.pixel_y-=rand(1,9)
											if(prob(50))
												I.pixel_x+=rand(5,8)
											else
												I.pixel_x-=rand(1,3)
											O.overlays+=I
											spawn(50)
												if(O)
													O.overlays-=I
													del(I)
									src.loc=locate(0,0,0)
									spawn(90)
										if(src)
											del(src)
			Iceball
				icon='Iceball.dmi'
				icon_state=""
				damage=3
				pixel_x=-16
				pixel_y=-16
				New()
					spawn(20)
						if(!src.Hit)
							walk(src,0)
							del(src)
						else
							spawn(100)
								if(src)
									del(src)
					..()
				Bump(atom/O)
					if(!src.Hit)
						if(istype(O,/mob))
							var/mob/M=O
							var/mob/Owner=src.Owner
							if(M.fightlayer==src.fightlayer)
								if(M.dodge==0)
									src.density=0
									if(prob(50))
										src.PlayAudio('KickHit.ogg', output = AUDIO_HEARERS)
									else
										src.PlayAudio('KickHit.ogg', output = AUDIO_HEARERS)
									src.layer=MOB_LAYER+1
									walk(src,0)
									src.loc=O.loc
									src.Hit=1
									var/undefendedhit=round(src.damage+M.defence/6)
									if(undefendedhit<=0) undefendedhit=1
									M.DealDamage(undefendedhit,src.Owner,"TaiOrange")
									spawn() if(M) M.Bleed()
									if(Owner)
										if(Owner.loc.loc:Safe!=1) Owner.LevelStat("Strength",1)
										if(Owner.loc.loc:Safe!=1) Owner.LevelStat("strength",rand(1,4))
									if(prob(15))
										M.speeding=0
									if(istype(O,/mob/npc) && !istype(O,/mob/npc/combat))
										..()
									if(M.henge==4||M.henge==5)
										M.HengeUndo()
									spawn(1)
										src.loc=locate(0,0,0)
										spawn(400)
											if(src)
												del(src)
								else
									flick("dodge",M)
									if(M.loc.loc:Safe!=1) M.LevelStat("Agility",rand(3,6))
									src.loc=M.loc

							else
								if(M.fightlayer=="Normal"&&src.fightlayer=="HighGround")
									if(M.dodge==0)
										src.density=0
										if(prob(50))
											src.PlayAudio('KickHit.ogg', output = AUDIO_HEARERS)
										else
											src.PlayAudio('KickHit.ogg', output = AUDIO_HEARERS)
										src.layer=MOB_LAYER+1
										walk(src,0)
										src.loc=O.loc
										src.Hit=1
										var/undefendedhit=round(src.damage+M.defence/6)
										if(undefendedhit<=0) undefendedhit=1
										M.DealDamage(undefendedhit,src.Owner,"TaiOrange")
										spawn() if(M) M.Bleed()
										if(Owner.loc.loc:Safe!=1) Owner.LevelStat("Strength",1)
										if(Owner.loc.loc:Safe!=1) Owner.LevelStat("strength",rand(1,4))
										if(prob(15))
											M.speeding=0
										if(istype(O,/mob/npc) && !istype(O,/mob/npc/combat))
											..()
										if(M.henge==4||M.henge==5)
											M.HengeUndo()
										spawn(1)
											src.loc=locate(0,0,0)
											spawn(400) del(src)
									else
										flick("dodge",M)
										if(M.loc.loc:Safe!=1) M.LevelStat("Agility",rand(3,6))
										src.loc=M.loc
								else
									src.loc=M.loc
						else
							if(istype(O,/obj/Projectiles))
								var/obj/Projectiles/OBJ=O
								if(OBJ.Owner)
									var/mob/OBOwner=OBJ.Owner
									if(OBOwner==src.Owner)
										if(istype(OBJ,/obj/Projectiles/Weaponry/ChidoriNeedle)) del(src)
										src.loc=OBJ.loc
									else
										if(istype(OBJ,/obj/Projectiles/Effects/ClayBird))
											OBJ.Hit=1
							else
								if(istype(O,/turf))
									var/turf/T=O
									if(T.fightlayer=="HighGround"&&src.fightlayer=="Normal")
										src.loc=locate(T.x,T.y,T.z)
									if(src.fightlayer==T.fightlayer)
										src.density=0
										if(prob(50))
											src.PlayAudio('KickHit.ogg', output = AUDIO_HEARERS)
										else
											src.PlayAudio('KickHit.ogg', output = AUDIO_HEARERS)
										del(src)
								if(istype(O,/obj))
									var/obj/OB=O
									if(OB.fightlayer=="HighGround"&&src.fightlayer=="Normal")
										src.loc=locate(OB.x,OB.y,OB.z)
									if(src.fightlayer==OB.fightlayer)
										src.density=0
										if(prob(50))
											src.PlayAudio('KickHit.ogg', output = AUDIO_HEARERS)
										else
											src.PlayAudio('KickHit.ogg', output = AUDIO_HEARERS)
										del(src)

			ChidoriNeedle
				icon='Chidori Needles.dmi'
				icon_state=""
				damage=3
				pixel_x=-16
				pixel_y=-16
				New()
					spawn(20)
						if(!src.Hit)
							walk(src,0)
							del(src)
						else
							spawn(100)
								if(src)
									del(src)
					..()
				Bump(atom/O)
					if(!src.Hit)
						if(istype(O,/mob))
							var/mob/M=O
							var/mob/Owner=src.Owner
							if(M.fightlayer==src.fightlayer)
								if(M.dodge==0)
									src.density=0
									if(prob(50))
										src.PlayAudio('KickHit.ogg', output = AUDIO_HEARERS)
									else
										src.PlayAudio('KickHit.ogg', output = AUDIO_HEARERS)
									src.layer=MOB_LAYER+1
									walk(src,0)
									src.loc=O.loc
									src.Hit=1
									var/undefendedhit=round(src.damage+M.defence/6)
									if(undefendedhit<=0) undefendedhit=1
									M.DealDamage(undefendedhit,src.Owner,"NinBlue")
									spawn() if(M) M.Bleed()
									if(Owner)
										if(Owner.loc.loc:Safe!=1) Owner.LevelStat("Ninjutsu",1)
										if(Owner.loc.loc:Safe!=1) Owner.LevelStat("Ninjutsu",rand(1,4))
									if(prob(15))
										M.speeding=0
									if(istype(O,/mob/npc) && !istype(O,/mob/npc/combat))
										..()
									if(M.henge==4||M.henge==5)
										M.HengeUndo()
									spawn(1)
										src.loc=locate(0,0,0)
										spawn(400)
											if(src)
												del(src)
								else
									flick("dodge",M)
									if(M.loc.loc:Safe!=1) M.LevelStat("Agility",rand(3,6))
									src.loc=M.loc

							else
								if(M.fightlayer=="Normal"&&src.fightlayer=="HighGround")
									if(M.dodge==0)
										src.density=0
										if(prob(50))
											src.PlayAudio('KickHit.ogg', output = AUDIO_HEARERS)
										else
											src.PlayAudio('KickHit.ogg', output = AUDIO_HEARERS)
										src.layer=MOB_LAYER+1
										walk(src,0)
										src.loc=O.loc
										src.Hit=1
										var/undefendedhit=round(src.damage+M.defence/6)
										if(undefendedhit<=0) undefendedhit=1
										M.DealDamage(undefendedhit,src.Owner,"NinBlue")
										spawn() if(M) M.Bleed()
										if(Owner.loc.loc:Safe!=1) Owner.LevelStat("Ninjutsu",1)
										if(Owner.loc.loc:Safe!=1) Owner.LevelStat("Ninjutsu",rand(1,4))
										if(prob(15))
											M.speeding=0
										if(istype(O,/mob/npc) && !istype(O,/mob/npc/combat))
											..()
										if(M.henge==4||M.henge==5)
											M.HengeUndo()
										spawn(1)
											src.loc=locate(0,0,0)
											spawn(400) del(src)
									else
										flick("dodge",M)
										if(M.loc.loc:Safe!=1) M.LevelStat("Agility",rand(3,6))
										src.loc=M.loc
								else
									src.loc=M.loc
						else
							if(istype(O,/obj/Projectiles))
								var/obj/Projectiles/OBJ=O
								if(OBJ.Owner)
									var/mob/OBOwner=OBJ.Owner
									if(OBOwner==src.Owner)
										if(istype(OBJ,/obj/Projectiles/Weaponry/ChidoriNeedle)) del(src)
										src.loc=OBJ.loc
									else
										if(istype(OBJ,/obj/Projectiles/Effects/ClayBird))
											OBJ.Hit=1
							else
								if(istype(O,/turf))
									var/turf/T=O
									if(T.fightlayer=="HighGround"&&src.fightlayer=="Normal")
										src.loc=locate(T.x,T.y,T.z)
									if(src.fightlayer==T.fightlayer)
										src.density=0
										if(prob(50))
											src.PlayAudio('KickHit.ogg', output = AUDIO_HEARERS)
										else
											src.PlayAudio('KickHit.ogg', output = AUDIO_HEARERS)
										del(src)
								if(istype(O,/obj))
									var/obj/OB=O
									if(OB.fightlayer=="HighGround"&&src.fightlayer=="Normal")
										src.loc=locate(OB.x,OB.y,OB.z)
									if(src.fightlayer==OB.fightlayer)
										src.density=0
										if(prob(50))
											src.PlayAudio('KickHit.ogg', output = AUDIO_HEARERS)
										else
											src.PlayAudio('KickHit.ogg', output = AUDIO_HEARERS)
										del(src)
			SickleSlash
				icon='Sickle Weasel slash.dmi'
				icon_state="Sickle spin"
				damage=3
				New()
					spawn(20)
						if(!src.Hit)
							walk(src,0)
							del(src)
						else
							spawn(100)
								if(src)
									del(src)
					..()
				Bump(atom/O)
					if(!src.Hit)
						if(istype(O,/mob))
							var/mob/M=O
							var/mob/Owner=src.Owner
							if(M.fightlayer==src.fightlayer)
								if(M.dodge==0)
									src.density=0
									if(prob(50))
										src.PlayAudio('KickHit.ogg', output = AUDIO_HEARERS)
									else
										src.PlayAudio('KickHit.ogg', output = AUDIO_HEARERS)
									src.layer=MOB_LAYER+1
									walk(src,0)
									src.loc=O.loc
									src.Hit=1
									var/undefendedhit=round(src.damage+M.defence/6)
									if(undefendedhit<=0) undefendedhit=1
									M.DealDamage(undefendedhit,src.Owner,"NinBlue")
									spawn() if(M) M.Bleed()
									if(Owner.loc.loc:Safe!=1) Owner.LevelStat("Ninjutsu",1)
									if(Owner.loc.loc:Safe!=1) Owner.LevelStat("Ninjutsu",rand(1,4))
									if(prob(15))
										M.speeding=0
									if(istype(O,/mob/npc) && !istype(O,/mob/npc/combat))
										..()
									if(M.henge==4||M.henge==5)
										M.HengeUndo()
									spawn(1)
										src.loc=locate(0,0,0)
										spawn(400) del(src)
								else
									flick("dodge",M)
									if(M.loc.loc:Safe!=1) M.LevelStat("Agility",rand(3,6))
									src.loc=M.loc

							else
								if(M.fightlayer=="Normal"&&src.fightlayer=="HighGround")
									if(M.dodge==0)
										src.density=0
										if(prob(50))
											src.PlayAudio('KickHit.ogg', output = AUDIO_HEARERS)
										else
											src.PlayAudio('KickHit.ogg', output = AUDIO_HEARERS)
										src.layer=MOB_LAYER+1
										walk(src,0)
										src.loc=O.loc
										src.Hit=1
										var/undefendedhit=round(src.damage+M.defence/6)
										if(undefendedhit<=0) undefendedhit=1
										M.DealDamage(undefendedhit,src.Owner,"TaiOrange")
										spawn() if(M) M.Bleed()
										if(Owner.loc.loc:Safe!=1) Owner.LevelStat("Strength",1)
										if(Owner.loc.loc:Safe!=1) Owner.LevelStat("strength",rand(1,4))
										if(prob(15))
											M.speeding=0
										if(istype(O,/mob/npc) && !istype(O,/mob/npc/combat))
											..()
										if(M.henge==4||M.henge==5)
											M.HengeUndo()
										spawn(1)
											src.loc=locate(0,0,0)
											spawn(400) del(src)
									else
										flick("dodge",M)
										if(M.loc.loc:Safe!=1) M.LevelStat("Agility",rand(3,6))
										src.loc=M.loc
								else
									src.loc=M.loc
						else
							if(istype(O,/obj/Projectiles))
								var/obj/Projectiles/OBJ=O
								if(OBJ.Owner)
									var/mob/OBOwner=OBJ.Owner
									if(OBOwner==src.Owner)
										src.loc=OBJ.loc
							else
								if(istype(O,/turf))
									var/turf/T=O
									if(T.fightlayer=="HighGround"&&src.fightlayer=="Normal")
										src.loc=locate(T.x,T.y,T.z)
									if(src.fightlayer==T.fightlayer)
										src.density=0
										if(prob(50))
											src.PlayAudio('KickHit.ogg', output = AUDIO_HEARERS)
										else
											src.PlayAudio('KickHit.ogg', output = AUDIO_HEARERS)
										walk(src,0)
										src.loc=locate(T.x,T.y,T.z)
										src.Hit=1
										spawn(90)
											if(src)
												del(src)
								if(istype(O,/obj))
									var/obj/OB=O
									if(OB.fightlayer=="HighGround"&&src.fightlayer=="Normal")
										src.loc=locate(OB.x,OB.y,OB.z)
									if(src.fightlayer==OB.fightlayer)
										src.density=0
										if(prob(50))
											src.PlayAudio('KickHit.ogg', output = AUDIO_HEARERS)
										else
											src.PlayAudio('KickHit.ogg', output = AUDIO_HEARERS)
										walk(src,0)
										src.loc=locate(OB.x,OB.y,OB.z)
										src.Hit=1
										src.loc=locate(0,0,0)
										spawn(90)
											if(src)
												del(src)
			LightningBalls
				icon='LightningBall.dmi'
				icon_state="LightningBall"
				damage=8
				New()
					spawn(20)
						if(!src.Hit)
							walk(src,0)
							del(src)
						else
							spawn(100)
								if(src)
									del(src)
					..()
				Bump(atom/O)
					if(!src.Hit)
						if(istype(O,/mob))
							var/mob/M=O
							var/mob/Owner=src.Owner
							if(M.fightlayer==src.fightlayer)
								if(M.dodge==0)
									src.density=0
									if(prob(50))
										src.PlayAudio('KickHit.ogg', output = AUDIO_HEARERS)
									else
										src.PlayAudio('KickHit.ogg', output = AUDIO_HEARERS)
									src.layer=MOB_LAYER+1
									walk(src,0)
									src.loc=O.loc
									src.Hit=1
									var/undefendedhit=round(src.damage+M.defence/6)
									if(undefendedhit<=0) undefendedhit=1
									M.DealDamage(undefendedhit,src.Owner,"NinBlue")
									spawn() if(M) M.Bleed()
									if(Owner.loc.loc:Safe!=1) Owner.LevelStat("Ninjutsu",3)
									if(Owner.loc.loc:Safe!=1) Owner.LevelStat("Ninjutsu",rand(1,6))
									if(prob(15))
										M.speeding=0
									if(istype(O,/mob/npc) && !istype(O,/mob/npc/combat))
										..()
									if(M.henge==4||M.henge==5)
										M.HengeUndo()
									spawn(1)
										src.loc=locate(0,0,0)
										spawn(400) del(src)
							else
								if(M.fightlayer=="Normal"&&src.fightlayer=="HighGround")
									if(M.dodge==0)
										src.density=0
										if(prob(50))
											src.PlayAudio('KickHit.ogg', output = AUDIO_HEARERS)
										else
											src.PlayAudio('KickHit.ogg', output = AUDIO_HEARERS)
										src.layer=MOB_LAYER+1
										walk(src,0)
										src.loc=O.loc
										src.Hit=1
										var/undefendedhit=round(src.damage+M.defence/6)
										if(undefendedhit<=0) undefendedhit=1
										M.DealDamage(undefendedhit,src.Owner,"NinBlue")
										spawn() if(M) M.Bleed()
										if(Owner.loc.loc:Safe!=1) Owner.LevelStat("Ninjutsu",3)
										if(Owner.loc.loc:Safe!=1) Owner.LevelStat("Ninjutsu",rand(1,6))
										if(prob(15))
											M.speeding=0
										if(istype(O,/mob/npc) && !istype(O,/mob/npc/combat))
											..()
										if(M.henge==4||M.henge==5)
											M.HengeUndo()
										spawn(1)
											src.loc=locate(0,0,0)
											spawn(400) del(src)
								else
									src.loc=M.loc
						else
							if(istype(O,/obj/Projectiles))
								var/obj/Projectiles/OBJ=O
								if(OBJ.Owner)
									var/mob/OBOwner=OBJ.Owner
									if(OBOwner==src.Owner)
										src.loc=OBJ.loc
							else
								if(istype(O,/turf))
									var/turf/T=O
									if(T.fightlayer=="HighGround"&&src.fightlayer=="Normal")
										src.loc=locate(T.x,T.y,T.z)
									if(src.fightlayer==T.fightlayer)
										src.density=0
										if(prob(50))
											src.PlayAudio('KickHit.ogg', output = AUDIO_HEARERS)
										else
											src.PlayAudio('KickHit.ogg', output = AUDIO_HEARERS)
										walk(src,0)
										src.loc=locate(T.x,T.y,T.z)
										src.Hit=1
										spawn(90)
											if(src)
												del(src)
								if(istype(O,/obj))
									var/obj/OB=O
									if(OB.fightlayer=="HighGround"&&src.fightlayer=="Normal")
										src.loc=locate(OB.x,OB.y,OB.z)
									if(src.fightlayer==OB.fightlayer)
										src.density=0
										if(prob(50))
											src.PlayAudio('KickHit.ogg', output = AUDIO_HEARERS)
										else
											src.PlayAudio('KickHit.ogg', output = AUDIO_HEARERS)
										walk(src,0)
										src.loc=locate(OB.x,OB.y,OB.z)
										src.Hit=1
										src.loc=locate(0,0,0)
										spawn(90)
											if(src)
												del(src)
			BoneTip
				icon_state="bonetip"
				damage=3
				New()
					spawn(20)
						if(!src.Hit)
							walk(src,0)
							src.density=0
							src.icon_state="bonetipland"
							spawn(80)
								del(src)
						else
							spawn(100)
								if(src)
									del(src)
					..()
				Bump(atom/O)
					if(!src.Hit)
						if(istype(O,/mob))
							var/mob/M=O
							var/mob/Owner=src.Owner
							if(M.fightlayer==src.fightlayer)
								if(M.dodge==0)
									src.density=0
									if(prob(50))
										src.PlayAudio('KickHit.ogg', output = AUDIO_HEARERS)
									else
										src.PlayAudio('KickHit.ogg', output = AUDIO_HEARERS)
									src.layer=MOB_LAYER+1
									walk(src,0)
									src.loc=O.loc
									src.Hit=1
									var/undefendedhit=round(src.damage+M.defence/6)
									if(undefendedhit<=0) undefendedhit=1
									M.DealDamage(undefendedhit,src.Owner,"TaiOrange")
									spawn() if(M) M.Bleed()
									if(prob(15))
										M.speeding=0
									if(istype(O,/mob/npc) && !istype(O,/mob/npc/combat))
										..()
									else
										if(M.amounthits<6)
											if(src.level>=2)
												var/obj/I=new/obj/Hits/BoneTips/Hit
												if(src.dir==NORTH)
													I.icon_state="bonetipN"
												else
													if(src.dir==SOUTH)
														I.icon_state="bonetipS"
													else
														if(src.dir==WEST)
															I.icon_state="bonetipW"
														else
															if(src.dir==EAST)
																I.icon_state="bonetipE"
															else
																..()
												if(prob(50))
													I.pixel_y+=rand(1,5)
												else
													I.pixel_y-=rand(1,5)
												if(prob(50))
													I.pixel_x+=rand(1,5)
												else
													I.pixel_x-=rand(1,5)
												M.SCaught+=I
												M.amounthits++
												M.overlays+=I
												spawn(370) M.overlays-=I
									if(M.henge==4||M.henge==5)
										M.HengeUndo()
									M.Death(Owner)
									spawn(1)
										src.loc=locate(0,0,0)
										spawn(400) del(src)
								else
									flick("dodge",M)
									if(M.loc.loc:Safe!=1) M.LevelStat("Agility",rand(3,6))
									src.loc=M.loc

							else
								if(M.fightlayer=="Normal"&&src.fightlayer=="HighGround")
									if(M.dodge==0)
										src.density=0
										if(prob(50))
											src.PlayAudio('KickHit.ogg', output = AUDIO_HEARERS)
										else
											src.PlayAudio('KickHit.ogg', output = AUDIO_HEARERS)
										src.layer=MOB_LAYER+1
										walk(src,0)
										src.loc=O.loc
										src.Hit=1
										var/undefendedhit=round(src.damage+M.defence/6)
										if(undefendedhit<=0) undefendedhit=1
										M.DealDamage(undefendedhit,src.Owner,"TaiOrange")
										spawn() if(M) M.Bleed()
										if(prob(15))
											M.speeding=0
										if(istype(O,/mob/npc) && !istype(O,/mob/npc/combat))
											..()
										else
											if(M.amounthits<6)
												if(src.level>=2)
													var/obj/I=new/obj/Hits/BoneTips/Hit
													if(src.dir==NORTH)
														I.icon_state="bonetipN"
													else
														if(src.dir==SOUTH)
															I.icon_state="bonetipS"
														else
															if(src.dir==WEST)
																I.icon_state="bonetipW"
															else
																if(src.dir==EAST)
																	I.icon_state="bonetipE"
																else
																	..()
													if(prob(50))
														I.pixel_y+=rand(1,5)
													else
														I.pixel_y-=rand(1,5)
													if(prob(50))
														I.pixel_x+=rand(1,5)
													else
														I.pixel_x-=rand(1,5)
													M.SCaught+=I
													M.amounthits++
													M.overlays+=I
													spawn(370) M.overlays-=I
										if(M.henge==4||M.henge==5)
											M.HengeUndo()
										M.Death(Owner)
										spawn(1)
											src.loc=locate(0,0,0)
											spawn(400) del(src)
									else
										flick("dodge",M)
										if(M.loc.loc:Safe!=1) M.LevelStat("Agility",rand(3,6))
										src.loc=M.loc
								else
									src.loc=M.loc
						else
							if(istype(O,/obj/Projectiles))
								var/obj/Projectiles/OBJ=O
								if(OBJ.Owner)
									var/mob/OBOwner=OBJ.Owner
									if(OBOwner==src.Owner)
										src.loc=OBJ.loc
							else
								if(istype(O,/turf))
									var/turf/T=O
									if(T.fightlayer=="HighGround"&&src.fightlayer=="Normal")
										src.loc=locate(T.x,T.y,T.z)
									if(src.fightlayer==T.fightlayer)
										src.density=0
										if(prob(50))
											src.PlayAudio('KickHit.ogg', output = AUDIO_HEARERS)
										else
											src.PlayAudio('KickHit.ogg', output = AUDIO_HEARERS)
										walk(src,0)
										src.loc=locate(T.x,T.y,T.z)
										src.Hit=1
										var/obj/I=new/obj/Hits/BoneTips/Hit
										if(src.dir==NORTH)
											I.icon_state="bonetipN"
										else
											if(src.dir==SOUTH)
												I.icon_state="bonetipS"
											else
												if(src.dir==WEST)
													I.icon_state="bonetipW"
												else
													if(src.dir==EAST)
														I.icon_state="bonetipE"
													else
														..()
										if(prob(50))
											I.pixel_y+=rand(1,5)
										else
											I.pixel_y-=rand(1,5)
										if(prob(50))
											I.pixel_x+=rand(1,5)
										else
											I.pixel_x-=rand(1,5)
										O.overlays+=I
										spawn(50)
											if(O)
												O.overlays-=I
												del(I)
										src.loc=locate(0,0,0)
										spawn(90)
											if(src)
												del(src)
								if(istype(O,/obj))
									var/obj/OB=O
									if(OB.fightlayer=="HighGround"&&src.fightlayer=="Normal")
										src.loc=locate(OB.x,OB.y,OB.z)
									if(src.fightlayer==OB.fightlayer)
										src.density=0
										if(prob(50))
											src.PlayAudio('KickHit.ogg', output = AUDIO_HEARERS)
										else
											src.PlayAudio('KickHit.ogg', output = AUDIO_HEARERS)
										walk(src,0)
										src.loc=locate(OB.x,OB.y,OB.z)
										src.Hit=1
										var/obj/I=new/obj/Hits/BoneTips/Hit
										if(src.dir==NORTH)
											I.icon_state="bonetipN"
										else
											if(src.dir==SOUTH)
												I.icon_state="bonetipS"
											else
												if(src.dir==WEST)
													I.icon_state="bonetipW"
												else
													if(src.dir==EAST)
														I.icon_state="bonetipE"
													else
														..()
										if(prob(50))
											I.pixel_y+=rand(1,5)
										else
											I.pixel_y-=rand(1,5)
										if(prob(50))
											I.pixel_x+=rand(1,5)
										else
											I.pixel_x-=rand(1,5)
										O.overlays+=I
										spawn(50)
											if(O)
												O.overlays-=I
												del(I)
										src.loc=locate(0,0,0)
										spawn(90)
											if(src)
												del(src)
			SaiRat
				icon='SaiRat.dmi'
				icon_state=""
				damage=3
				pixel_x=-16
				pixel_y=-16
				New()
					spawn(20)
						if(!src.Hit)
							walk(src,0)
							del(src)
						else
							spawn(100)
								if(src)
									del(src)
					..()
				Bump(atom/O)
					if(!src.Hit)
						if(istype(O,/mob))
							var/mob/M=O
							var/mob/Owner=src.Owner
							if(M.fightlayer==src.fightlayer)
								if(M.dodge==0)
									src.density=0
									if(prob(50))
										src.PlayAudio('KickHit.ogg', output = AUDIO_HEARERS)
									else
										src.PlayAudio('KickHit.ogg', output = AUDIO_HEARERS)
									src.layer=MOB_LAYER+1
									walk(src,0)
									src.loc=O.loc
									src.Hit=1
									var/undefendedhit=round(src.damage+M.defence/6)
									if(undefendedhit<=0) undefendedhit=1
									M.DealDamage(undefendedhit,src.Owner,"TaiOrange")
									spawn() if(M) M.Bleed()
									if(Owner)
										if(Owner.loc.loc:Safe!=1) Owner.LevelStat("Strength",1)
										if(Owner.loc.loc:Safe!=1) Owner.LevelStat("strength",rand(1,2))

									if(prob(15))
										M.speeding=0
									if(istype(O,/mob/npc) && !istype(O,/mob/npc/combat))
										..()
									if(M.henge==4||M.henge==5)
										M.HengeUndo()
									M.Death(Owner)
									spawn(1)
										src.loc=locate(0,0,0)
										spawn(400)
											if(src)
												del(src)
								else
									flick("dodge",M)
									if(M.loc.loc:Safe!=1) M.LevelStat("Agility",rand(3,6))
									src.loc=M.loc

							else
								if(M.fightlayer=="Normal"&&src.fightlayer=="HighGround")
									if(M.dodge==0)
										src.density=0
										if(prob(50))
											src.PlayAudio('KickHit.ogg', output = AUDIO_HEARERS)
										else
											src.PlayAudio('KickHit.ogg', output = AUDIO_HEARERS)
										src.layer=MOB_LAYER+1
										walk(src,0)
										src.loc=O.loc
										src.Hit=1
										var/undefendedhit=round(src.damage+M.defence/6)
										if(undefendedhit<=0) undefendedhit=1
										M.DealDamage(undefendedhit,src.Owner,"TaiOrange")
										spawn() if(M) M.Bleed()
										if(Owner.loc.loc:Safe!=1) Owner.LevelStat("Strength",1)
										if(Owner.loc.loc:Safe!=1) Owner.LevelStat("strength",rand(1,4))
										if(prob(15))
											M.speeding=0
										if(istype(O,/mob/npc) && !istype(O,/mob/npc/combat))
											..()
										if(M.henge==4||M.henge==5)
											M.HengeUndo()
										spawn(1)
											src.loc=locate(0,0,0)
											spawn(400) del(src)
									else
										flick("dodge",M)
										if(M.loc.loc:Safe!=1) M.LevelStat("Agility",rand(3,6))
										src.loc=M.loc
								else
									src.loc=M.loc
						else
							if(istype(O,/obj/Projectiles))
								var/obj/Projectiles/OBJ=O
								if(OBJ.Owner)
									var/mob/OBOwner=OBJ.Owner
									if(OBOwner==src.Owner)
										if(istype(OBJ,/obj/Projectiles/Weaponry/ChidoriNeedle)) del(src)
										src.loc=OBJ.loc
									else
										if(istype(OBJ,/obj/Projectiles/Effects/ClayBird))
											OBJ.Hit=1
							else
								if(istype(O,/turf))
									var/turf/T=O
									if(T.fightlayer=="HighGround"&&src.fightlayer=="Normal")
										src.loc=locate(T.x,T.y,T.z)
									if(src.fightlayer==T.fightlayer)
										src.density=0
										if(prob(50))
											src.PlayAudio('KickHit.ogg', output = AUDIO_HEARERS)
										else
											src.PlayAudio('KickHit.ogg', output = AUDIO_HEARERS)
										del(src)
								if(istype(O,/obj))
									var/obj/OB=O
									if(OB.fightlayer=="HighGround"&&src.fightlayer=="Normal")
										src.loc=locate(OB.x,OB.y,OB.z)
									if(src.fightlayer==OB.fightlayer)
										src.density=0
										if(prob(50))
											src.PlayAudio('KickHit.ogg', output = AUDIO_HEARERS)
										else
											src.PlayAudio('KickHit.ogg', output = AUDIO_HEARERS)
										del(src)
			Sai_Snakes
				icon='Sai Snakes.dmi'
				icon_state=""
				damage=3
				pixel_x=-16
				pixel_y=-16
				New()
					spawn(20)
						if(!src.Hit)
							walk(src,0)
							del(src)
						else
							spawn(100)
								if(src)
									del(src)
					..()
				Bump(atom/O)
					if(!src.Hit)
						if(istype(O,/mob))
							var/mob/M=O
							var/mob/Owner=src.Owner
							if(M.fightlayer==src.fightlayer)
								if(M.dodge==0)
									src.density=0
									if(prob(50))
										src.PlayAudio('KickHit.ogg', output = AUDIO_HEARERS)
									else
										src.PlayAudio('KickHit.ogg', output = AUDIO_HEARERS)
									src.layer=MOB_LAYER+1
									walk(src,0)
									src.loc=O.loc
									src.Hit=1
									var/undefendedhit=round(src.damage+M.defence/6)
									if(undefendedhit<=0) undefendedhit=1
									M.DealDamage(undefendedhit,src.Owner,"TaiOrange")
									spawn() if(M) M.Bleed()
									if(Owner)
										if(Owner.loc.loc:Safe!=1) Owner.LevelStat("Strength",1)
										if(Owner.loc.loc:Safe!=1) Owner.LevelStat("strength",rand(1,2))
									if(prob(15))
										M.speeding=0
									if(istype(O,/mob/npc) && !istype(O,/mob/npc/combat))
										..()
									if(M.henge==4||M.henge==5)
										M.HengeUndo()
									spawn(1)
										src.loc=locate(0,0,0)
										spawn(400)
											if(src)
												del(src)
								else
									flick("dodge",M)
									if(M.loc.loc:Safe!=1) M.LevelStat("Agility",rand(3,6))
									src.loc=M.loc

							else
								if(M.fightlayer=="Normal"&&src.fightlayer=="HighGround")
									if(M.dodge==0)
										src.density=0
										if(prob(50))
											src.PlayAudio('KickHit.ogg', output = AUDIO_HEARERS)
										else
											src.PlayAudio('KickHit.ogg', output = AUDIO_HEARERS)
										src.layer=MOB_LAYER+1
										walk(src,0)
										src.loc=O.loc
										src.Hit=1
										var/undefendedhit=round(src.damage+M.defence/6)
										if(undefendedhit<=0) undefendedhit=1
										M.DealDamage(undefendedhit,src.Owner,"TaiOrange")
										spawn() if(M) M.Bleed()
										if(Owner.loc.loc:Safe!=1) Owner.LevelStat("Strength",1)
										if(Owner.loc.loc:Safe!=1) Owner.LevelStat("strength",rand(1,4))
										if(prob(15))
											M.speeding=0
										if(istype(O,/mob/npc) && !istype(O,/mob/npc/combat))
											..()
										if(M.henge==4||M.henge==5)
											M.HengeUndo()
										spawn(1)
											src.loc=locate(0,0,0)
											spawn(400) del(src)
									else
										flick("dodge",M)
										if(M.loc.loc:Safe!=1) M.LevelStat("Agility",rand(3,6))
										src.loc=M.loc
								else
									src.loc=M.loc
						else
							if(istype(O,/obj/Projectiles))
								var/obj/Projectiles/OBJ=O
								if(OBJ.Owner)
									var/mob/OBOwner=OBJ.Owner
									if(OBOwner==src.Owner)
										if(istype(OBJ,/obj/Projectiles/Weaponry/ChidoriNeedle)) del(src)
										src.loc=OBJ.loc
									else
										if(istype(OBJ,/obj/Projectiles/Effects/ClayBird))
											OBJ.Hit=1
							else
								if(istype(O,/turf))
									var/turf/T=O
									if(T.fightlayer=="HighGround"&&src.fightlayer=="Normal")
										src.loc=locate(T.x,T.y,T.z)
									if(src.fightlayer==T.fightlayer)
										src.density=0
										if(prob(50))
											src.PlayAudio('KickHit.ogg', output = AUDIO_HEARERS)
										else
											src.PlayAudio('KickHit.ogg', output = AUDIO_HEARERS)
										del(src)
								if(istype(O,/obj))
									var/obj/OB=O
									if(OB.fightlayer=="HighGround"&&src.fightlayer=="Normal")
										src.loc=locate(OB.x,OB.y,OB.z)
									if(src.fightlayer==OB.fightlayer)
										src.density=0
										if(prob(50))
											src.PlayAudio('KickHit.ogg', output = AUDIO_HEARERS)
										else
											src.PlayAudio('KickHit.ogg', output = AUDIO_HEARERS)
										del(src)
			ExplosiveTag
				icon_state="tag"
				damage=40
				density=0
				New()
					spawn(600)del(src)
					spawn()
						AI()
					..()
				proc/AI()
					while(src)
						sleep(1)
						if(src.Linkage)
							var/mob/L=src.Linkage
							src.loc=L.loc
							sleep(0.5)
							continue
						else
							break
	Hits
		density=0
		pixel_x=16
		Shurikens
			icon='Shuriken.dmi'
			Hit
				icon_state="hit"
				layer=MOB_LAYER+1
			Hit2
				icon_state="hit2"
				layer=MOB_LAYER+1
			Hit3
				icon_state="hit3"
				layer=MOB_LAYER+1
		Needle
			icon='Shuriken.dmi'
			density=0
			Hit
				icon_state="nhit"
				layer=MOB_LAYER+1
			Hit2
				icon_state="nhit2"
				layer=MOB_LAYER+1
			Hit3
				icon_state="nhit3"
				layer=MOB_LAYER+1
		Kunai
			icon='Shuriken.dmi'
			density=0
			Hit
				icon_state="khit"
				layer=MOB_LAYER+1
			Hit2
				icon_state="khit2"
				layer=MOB_LAYER+1
			Hit3
				icon_state="khit3"
				layer=MOB_LAYER+1
		BoneTips
			icon='Shuriken.dmi'
			density=0
			Hit
				icon_state="bonetipN"
				layer=MOB_LAYER+1
obj
	JashinSymbol
		icon = 'Jashin symbol.dmi'
		pixel_y=-10
		pixel_x=-16
		var/mob/Jashiner
		var/mob/JashinConnected
		New(mob/M)
			src.loc = M.loc
			src.Owner = M
		//	var/mob/c_target=M.Target_Get(TARGET_MOB)
		//	if(c_target)
		//		src.Jashiner = c_target
		//	else
		//		del(src)
			spawn(320)
				if(src)
					del(src)

mob
	New()
		..()
		pixel_x=-16
	var
		tmp
			explosivetag=0
			canja=1
			LOW=0
			COW=0
	verb
		Throw()
			set hidden=1
			set category=null
			if(src.loc.loc:Safe == 1)
				src<<output("You're indoors, you shouldn't be doing this.","Action.Output")
				return 1

			if(CheckState(src, new/state/knocked_down) || CheckState(src, new/state/knocked_back) || CheckState(src, new/state/dead))
				return

			if(src.dead || src.move ==0 || src.canattack ==0 || src.injutsu || src.firing)
				return
			src.HengeUndo()
			if(multisized==1 && multisizestomp==0)//multisizestuff
				spawn(10) multisizestomp=0
				src.multisizestomp=1
				spawn(4) src.overlays-=/obj/Overlays/Dustmax
				src.overlays+=/obj/Overlays/Dustmax
				flick("groundjutsu",src)
				for(var/mob/M in orange(7))
					if(M.dead || M.key==src.name || istype(M,/mob/npc)) continue
					M.DealDamage(jutsudamage+round((src.strength / 150)*2*jutsudamage*1.2),src,"TaiOrange")
					if(M.henge==4||M.henge==5)M.HengeUndo()
					M.icon_state="dead"
					M.move=0
					M.injutsu=1
					M.canattack=0
					spawn(5)
						if(!M||M.dead)continue
						M.icon_state=""
						M.move=1
						M.injutsu=0
						M.canattack=1
					return

			if(src.COW)
				src.COW--
				src.icon_state = ""
				src.overlays += 'Cherry Blossom Impact.dmi'
				src.icon_state = "punchrS"
				src.PlayAudio('Skill_MashHit.wav', output = AUDIO_HEARERS)
				sleep(1)
				flick("punchr",src)
				src.icon_state = "punchrS"
				var/mob/c_target=src.Target_Get(TARGET_MOB)
				if(c_target)
					src.dir = get_dir(src,c_target)
				for(var/mob/M in get_step(src,src.dir))
					M.DealDamage((src.ninjutsu*1.5),src,"NinBlue")
					M.move=0
					M.canattack=0
					for(var/i=0,i<2,i++)
						M.icon_state = "push"
						step(M,src.dir)
						sleep(1)
					M.icon_state="dead"
					sleep(2)
					M.move=1
					M.canattack=1
					if(!M.dead)
						M.icon_state = ""
				src.overlays -= 'Cherry Blossom Impact.dmi'
				src.icon_state = ""
				return
			if(src.LOW)
				src.LOW--
				src.firing=1
				src.icon_state = "punchrS"
				src.overlays += 'Raikiri.dmi'
				src.PlayAudio('dash.wav', output = AUDIO_HEARERS)
				sleep(2)
				var/mob/Z
				flick("punchr",src)
				for(var/i=0,i<4,i++)
					var/check=0
					for(var/mob/M in get_step(src,src.dir))
						M.DealDamage(src.ninjutsu/2,src,"NinBlue")
						M.Bleed()
						src.loc = M.loc
						Z = M
						check=1
					if(check==0)
						step(src,src.dir)
					sleep(1)
				if(Z)
					src.dir = get_dir(src,Z)
				src.overlays -= 'Raikiri.dmi'
				src.icon_state = ""
				src.firing=0
				return
			for(var/obj/JashinSymbol/O in src.loc)
				sleep(1)
				if(O&&O.Owner==src&&O.JashinConnected&&src.canja)
					var/mob/HitMe=O.JashinConnected
					if(!HitMe.dead)
						if(!HitMe||!ismob(HitMe)) continue
						canja=0
						spawn(60) canja=1
						var/jashpercent = (jutsudamage / 100)/15
						if(src.health>0)
							HitMe.DealDamage(src.maxhealth*jashpercent,src,"maroon")
							HitMe.Bleed()
							src.DealDamage(src.maxhealth*jashpercent,src,"maroon")
							src.Bleed()
							src.PlayAudio('knife_hit1.wav', output = AUDIO_HEARERS)
							src.Death(src,1)
						return
			if(usr.equipped=="Shurikens")
				for(var/obj/Inventory/Weaponry/Shuriken/C in usr.contents)
					if(usr.firing == 0 && !CheckState(usr, new/state/throwing) && usr.dead==0)
						var/throwdelay = usr.attkspeed*3
						var/mob/c_target=usr.Target_Get(TARGET_MOB)
						AddState(usr, new/state/throwing, throwdelay)
						if(prob(50))
							flick("throw",usr)
							src.PlayAudio('SkillDam_ThrowSuriken2.wav', output = AUDIO_HEARERS)
						else
							flick("throw",usr)
							src.PlayAudio('SkillDam_ThrowSuriken3.wav', output = AUDIO_HEARERS)
						if(c_target)
							src.dir=get_dir(usr,c_target)
							usr.Target_Atom(c_target)
							var/obj/Projectiles/Weaponry/Shuriken/A = new/obj/Projectiles/Weaponry/Shuriken(usr.loc)
							if(loc.loc:Safe!=1) src.LevelStat("Precision",rand(36, 60))
							if(prob(50))A.pixel_y+=rand(5,10)
							else A.pixel_y-=rand(5,10)
							if(prob(50))A.pixel_x+=rand(1,8)
							else A.pixel_x-=rand(1,8)
							A.Owner=usr
							A.layer=usr.layer
							A.fightlayer=usr.fightlayer
							A.damage=(C.damage+(100-round(1*((150-((usr.precision)/1))/3)))+rand(0,10)*weapondamage)*0.6
							walk_towards(A,c_target.loc,0)
							spawn(4)if(A)walk(A,A.dir)
						else if(!c_target)
							var/obj/Projectiles/Weaponry/Shuriken/A = new/obj/Projectiles/Weaponry/Shuriken(usr.loc)
							if(loc.loc:Safe!=1) src.LevelStat("Precision",rand(36, 60))
							if(prob(50))A.pixel_y+=rand(5,10)
							else A.pixel_y-=rand(5,10)
							if(prob(50))A.pixel_x+=rand(1,8)
							else A.pixel_x-=rand(1,8)
							A.Owner=usr
							A.layer=usr.layer
							A.fightlayer=usr.fightlayer
							A.damage=(C.damage+(100-round(1*((150-((usr.precision)/1))/3)))+rand(0,10)*weapondamage)*0.6
							walk(A,usr.dir)
						usr.DestroyItem(C)
						break

			if(usr.equipped=="ExplodeKunais")
				for(var/obj/Inventory/Weaponry/Exploding_Kunai/C in usr.contents)
					if(usr.firing == 0 && !CheckState(usr, new/state/throwing) && usr.dead==0)
						var/throwdelay = usr.attkspeed*5
						var/mob/c_target=usr.Target_Get(TARGET_MOB)
						AddState(usr, new/state/throwing, throwdelay)
						if(prob(50))
							flick("throw",usr)
							src.PlayAudio('SkillDam_ThrowSuriken2.wav', output = AUDIO_HEARERS)
						else
							flick("throw",usr)
							src.PlayAudio('SkillDam_ThrowSuriken3.wav', output = AUDIO_HEARERS)
						if(c_target)
							src.dir=get_dir(usr,c_target)
							usr.Target_Atom(c_target)
							var/obj/Projectiles/Weaponry/Exploding_Kunai/A = new/obj/Projectiles/Weaponry/Exploding_Kunai(usr.loc)
							if(loc.loc:Safe!=1) src.LevelStat("Precision",rand(80, 110))
							if(prob(50))A.pixel_y+=rand(5,10)
							else A.pixel_y-=rand(5,10)
							if(prob(50))A.pixel_x+=rand(1,8)
							else A.pixel_x-=rand(1,8)
							A.Owner=usr
							A.layer=usr.layer
							A.fightlayer=usr.fightlayer
							A.damage=(C.damage+(100-round(1*((150-((usr.precision+usr.ninjutsu+usr.strength)/3))/3)))+rand(0,10)*weapondamage)*1
							walk_towards(A,c_target.loc,0)
							spawn(4)if(A)walk(A,A.dir)
						else
							var/obj/Projectiles/Weaponry/Exploding_Kunai/A = new/obj/Projectiles/Weaponry/Exploding_Kunai(usr.loc)
							if(loc.loc:Safe!=1) src.LevelStat("Precision",rand(80, 110))
							if(prob(50))A.pixel_y+=rand(5,10)
							else A.pixel_y-=rand(5,10)
							if(prob(50))A.pixel_x+=rand(1,8)
							else A.pixel_x-=rand(1,8)
							A.Owner=usr
							A.layer=usr.layer
							A.fightlayer=usr.fightlayer
							A.damage=(C.damage+(100-round(1*((150-((usr.precision+usr.ninjutsu+usr.strength)/3))/3)))+rand(0,10)*weapondamage)*1
							walk(A,usr.dir)
						usr.DestroyItem(C)
						break

			if(usr.equipped=="Kunais")
				for(var/obj/Inventory/Weaponry/Kunai/C in usr.contents)
					if(usr.firing == 0 && !CheckState(usr, new/state/throwing) && usr.dead==0)
						var/throwdelay = usr.attkspeed*4
						var/mob/c_target=usr.Target_Get(TARGET_MOB)
						AddState(usr, new/state/throwing, throwdelay)
						if(prob(50))
							flick("throw",usr)
							src.PlayAudio('SkillDam_ThrowSuriken2.wav', output = AUDIO_HEARERS)
						else
							flick("throw",usr)
							src.PlayAudio('SkillDam_ThrowSuriken3.wav', output = AUDIO_HEARERS)
						if(c_target)
							src.dir=get_dir(usr,c_target)
							usr.Target_Atom(c_target)
							var/obj/Projectiles/Weaponry/Kunai/A = new/obj/Projectiles/Weaponry/Kunai(usr.loc)
							if(loc.loc:Safe!=1) src.LevelStat("Precision",rand(40, 78))
							if(prob(50))A.pixel_y+=rand(5,10)
							else A.pixel_y-=rand(5,10)
							if(prob(50))A.pixel_x+=rand(1,8)
							else A.pixel_x-=rand(1,8)
							A.Owner=usr
							A.layer=usr.layer
							A.fightlayer=usr.fightlayer
							A.damage=(C.damage+(100-round(1*((150-((usr.precision+usr.strength)/2))/3)))+rand(0,10)*weapondamage)*0.9
							walk_towards(A,c_target.loc,0)
							spawn(4)if(A)walk(A,A.dir)
						else
							var/obj/Projectiles/Weaponry/Kunai/A = new/obj/Projectiles/Weaponry/Kunai(usr.loc)
							if(loc.loc:Safe!=1) src.LevelStat("Precision",rand(40, 78))
							if(prob(50))A.pixel_y+=rand(5,10)
							else A.pixel_y-=rand(5,10)
							if(prob(50))A.pixel_x+=rand(1,8)
							else A.pixel_x-=rand(1,8)
							A.Owner=usr
							A.layer=usr.layer
							A.fightlayer=usr.fightlayer
							A.damage=(C.damage+(100-round(1*((150-((usr.precision+usr.strength)/2))/3)))+rand(0,10)*weapondamage)*0.9
							walk(A,usr.dir)
						usr.DestroyItem(C)
						break

			if(usr.equipped=="Needles")
				for(var/obj/Inventory/Weaponry/Needle/C in usr.contents)
					if(usr.firing == 0 && !CheckState(usr, new/state/throwing) && usr.dead==0)
						var/throwdelay = usr.attkspeed*2
						var/mob/c_target=usr.Target_Get(TARGET_MOB)
						AddState(usr, new/state/throwing, throwdelay)
						if(prob(50))
							flick("throw",usr)
							src.PlayAudio('SkillDam_ThrowSuriken2.wav', output = AUDIO_HEARERS)
						else
							flick("throw",usr)
							src.PlayAudio('SkillDam_ThrowSuriken3.wav', output = AUDIO_HEARERS)
						if(c_target)
							src.dir=get_dir(usr,c_target)
							usr.Target_Atom(c_target)
							var/obj/Projectiles/Weaponry/Needle/A = new/obj/Projectiles/Weaponry/Needle(usr.loc)
							if(loc.loc:Safe!=1) src.LevelStat("Precision",rand(24, 48))
							if(prob(50))A.pixel_y+=rand(5,10)
							else A.pixel_y-=rand(5,10)
							if(prob(50))A.pixel_x+=rand(1,8)
							else A.pixel_x-=rand(1,8)
							A.Owner=usr
							A.layer=usr.layer
							A.fightlayer=usr.fightlayer
							A.damage=(C.damage+(100-round(1*((150-((usr.precision+usr.agility)/2))/3)))+rand(0,10)*weapondamage)*0.3
							walk_towards(A,c_target.loc,0)
							spawn(4)if(A)walk(A,A.dir)
						else
							var/obj/Projectiles/Weaponry/Needle/A = new/obj/Projectiles/Weaponry/Needle(usr.loc)
							if(loc.loc:Safe!=1) src.LevelStat("Precision",rand(24, 48))
							if(prob(50))A.pixel_y+=rand(5,10)
							else A.pixel_y-=rand(5,10)
							if(prob(50))A.pixel_x+=rand(1,8)
							else A.pixel_x-=rand(1,8)
							A.Owner=usr
							A.layer=usr.layer
							A.fightlayer=usr.fightlayer
							A.damage=(C.damage+(100-round(1*((150-((usr.precision+usr.agility)/2))/3)))+rand(0,10)*weapondamage)*0.3
							walk(A,usr.dir)
						usr.DestroyItem(C)
						break

			if(usr.equipped=="ExplosiveTags")
				if(usr.explosivetag<6)
					for(var/obj/Inventory/Weaponry/Explosive_Tag/C in usr.contents)
						if(usr.firing==0&&usr.tagcd==0&&usr.dead==0)
							var/mob/c_target=usr.Target_Get(TARGET_MOB)
							usr.tagcd=1
							usr.explosivetag++
							spawn(usr.attkspeed*6)
								usr.tagcd=0
							if(prob(50))
								flick("throw",usr)
								src.PlayAudio('SkillDam_ThrowSuriken2.wav', output = AUDIO_HEARERS)
							else
								flick("throw",usr)
								src.PlayAudio('SkillDam_ThrowSuriken3.wav', output = AUDIO_HEARERS)
							if(c_target)
								src.dir=get_dir(usr,c_target)
								usr.Target_Atom(c_target)
								var/obj/Projectiles/Weaponry/ExplosiveTag/A = new/obj/Projectiles/Weaponry/ExplosiveTag(usr.loc)
								if(loc.loc:Safe!=1) src.LevelStat("Precision",rand(72, 102))
								if(prob(50))A.pixel_y+=rand(5,10)
								else A.pixel_y-=rand(5,10)
								if(prob(50))A.pixel_x+=rand(1,8)
								else A.pixel_x-=rand(1,8)
								A.Owner=usr
								A.layer=usr.layer
								A.fightlayer=usr.fightlayer
								A.damage=(C.damage+(100-round(1*((150-((usr.ninjutsu)/1))/3)))+rand(0,10)*weapondamage)*1.2
								if(c_target in get_step(usr,usr.dir))
									A.Linkage=c_target
									A.pixel_y+=rand(8,10)
									A.layer=MOB_LAYER+1
								step(A,usr.dir)
							else
								var/obj/Projectiles/Weaponry/ExplosiveTag/A = new/obj/Projectiles/Weaponry/ExplosiveTag(usr.loc)
								if(loc.loc:Safe!=1) src.LevelStat("Precision",rand(72, 102))
								if(prob(50))A.pixel_y+=rand(1,8)
								else A.pixel_y-=rand(1,8)
								if(prob(50))A.pixel_x+=rand(1,8)
								else A.pixel_x-=rand(1,8)
								A.Owner=usr
								A.layer=usr.layer
								A.fightlayer=usr.fightlayer
								A.damage=(C.damage+(100-round(1*((150-((usr.ninjutsu)/1))/3)))+rand(0,10)*weapondamage)*1.2
								for(var/mob/M in get_step(usr,usr.dir))
									A.Linkage=M
									A.pixel_y+=rand(8,10)
									A.layer=MOB_LAYER+1
								step(A,usr.dir)
							usr.DestroyItem(C)
							break

			if(usr.equipped=="SmokeBombs")
				if(!usr.smokebomb)
					for(var/obj/Inventory/Weaponry/Smoke_Bomb/C in usr.contents)
						if(usr.firing==0&&usr.dead==0)
							usr.firing=1
							flick("throw",usr)
							spawn(3)
								usr.smokebomb=1
								var/obj/SMOKE = new/obj/MiscEffects/SmokeBomb(usr.loc)
								if(loc.loc:Safe!=1) src.LevelStat("Precision",rand(180, 320))
								SMOKE.loc=usr.loc
								src.PlayAudio('flashbang_explode2.wav', output = AUDIO_HEARERS)
								src.overlays=0
								src.icon_state="blank"
								for(var/mob/M in oview(usr))
									M.Target_Remove()
								usr.Step_Back()
								usr.DestroyItem(C)
								spawn(5)if(usr)usr.firing=0
								spawn(40)if(src)
									src.UpdateHMB()
									src.SetName(src.name)
									src.icon_state=""
									src.RestoreOverlays()
								spawn(600)if(usr)usr.smokebomb=0
								break

			if(usr.equipped=="FoodPill")
				if(!usr.foodpillcd)
					for(var/obj/Inventory/Weaponry/Food_Pill/C in usr.contents)
						src.foodpillcd=1
						src.healthregenmod++
						src.DestroyItem(C)
						spawn(200)
							src.foodpillcd=0
							src.healthregenmod--
						break


			if(usr.equipped=="Kubikiribocho")
				for(var/obj/Inventory/Weaponry/Zabuza_Sword/C in usr.contents)
					if(usr.firing==0&&usr.dead==0)
						usr.firing=1
						flick("throw",usr)
						for(var/mob/M in get_step(usr,usr.dir))
							if(M)
								M.DealDamage(usr.strength*3,src,"TaiOrange")
							//	usr.health+=usr.strength
								M.Bleed()
						spawn(usr.attkspeed*6)
							usr.firing=0
						break

			if(usr.equipped=="Samehada")
				for(var/obj/Inventory/Weaponry/Samehada/C in usr.contents)
					if(usr.firing==0&&usr.dead==0)
						usr.firing=1
						flick("throw",usr)
						for(var/mob/M in get_step(usr,usr.dir))
							if(M)
								M.DealDamage(usr.strength*3,src,"TaiOrange")
							//	usr.chakra+=usr.strength*1.5
								M.Bleed()
						spawn(usr.attkspeed*6)
							usr.firing=0
						break

			if(usr.equipped=="Hiramekarei")
				for(var/obj/Inventory/Weaponry/Hiramekarei/C in usr.contents)
					if(usr.firing==0&&usr.dead==0)
						usr.firing=1
						flick("throw",usr)
						for(var/mob/M in get_step(usr,usr.dir))
							if(M)
								M.DealDamage(usr.strength*3,src,"TaiOrange")
							//	usr.chakra+=usr.strength*1.5
								M.Bleed()
						spawn(usr.attkspeed*6)
							usr.firing=0
						break

			if(usr.equipped=="Kabuto Wari")
				for(var/obj/Inventory/Weaponry/Kabutowari/C in usr.contents)
					if(usr.firing==0&&usr.dead==0)
						usr.firing=1
						flick("throw",usr)
						for(var/mob/M in get_step(usr,usr.dir))
							if(M)
								M.DealDamage(usr.strength*3,src,"TaiOrange")
							//	usr.chakra+=usr.strength*1.5
								M.Bleed()
						spawn(usr.attkspeed*6)
							usr.firing=0
						break

			if(usr.equipped=="Kiba")
				for(var/obj/Inventory/Weaponry/Kiba/C in usr.contents)
					if(usr.firing==0&&usr.dead==0)
						usr.firing=1
						flick("throw",usr)
						for(var/mob/M in get_step(usr,usr.dir))
							if(M)
								M.DealDamage(usr.strength*3,src,"TaiOrange")
							//	usr.chakra+=usr.strength*1.5
								M.Bleed()
						spawn(usr.attkspeed*6)
							usr.firing=0
						break

			if(usr.equipped=="Nuibari")
				for(var/obj/Inventory/Weaponry/Nuibari/C in usr.contents)
					if(usr.firing==0&&usr.dead==0)
						usr.firing=1
						flick("throw",usr)
						for(var/mob/M in get_step(usr,usr.dir))
							if(M)
								M.DealDamage(usr.strength*3,src,"TaiOrange")
							//	usr.chakra+=usr.strength*1.5
								M.Bleed()
						spawn(usr.attkspeed*6)
							usr.firing=0
						break

			if(usr.equipped=="Shibuki")
				for(var/obj/Inventory/Weaponry/Shibuki/C in usr.contents)
					if(usr.firing==0&&usr.dead==0)
						usr.firing=1
						flick("throw",usr)
						for(var/mob/M in get_step(usr,usr.dir))
							if(M)
								M.DealDamage(usr.strength*3,src,"TaiOrange")
							//	usr.chakra+=usr.strength*1.5
								M.Bleed()
						spawn(usr.attkspeed*6)
							usr.firing=0
						break

			if(usr.equipped=="Dark Sword")
				for(var/obj/Inventory/Weaponry/DarkSword/C in usr.contents)
					if(usr.firing==0&&usr.dead==0)
						usr.firing=1
						flick("throw",usr)
						for(var/mob/M in get_step(usr,usr.dir))
							if(M)
								M.DealDamage(usr.strength,src,"TaiOrange")
								M.Bleed()
						spawn(usr.attkspeed*6)
							usr.firing=0
						break

/*			if(usr.equipped=="Weights")
				for(var/obj/Inventory/Weaponry/Weights/C in usr.contents)
					if(usr.firing==0 && usr.dead==0)
						if(usr.agility < 80)
							usr.firing=1
							flick("punchr",usr)
							usr.LevelStat("Agility",rand(4,7))
							for(var/mob/M in get_step(usr,usr.dir))
								if(M)
									M.DealDamage(usr.strength*0.1,src,"TaiOrange")
							spawn(usr.attkspeed*2)
								usr.firing=0
						else
							usr << output("You're too experienced in agility to gain anymore experience from these.","Action.Output")
							return*/
			//UpdateInventoryPanel()
			return
