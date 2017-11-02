atom/var/Hengable=0 // Don't change this.
mob/var/tmp/mizubunshin
mob/var/tmp/Prisoned=0
mob
	Hengable=1
proc/GetListeners(atom/what)
	var/list/ReturnValue=list()
	for(var/mob/player/M in hearers(what))
		if(M.ckey&&M.key&&M.client&&istype(M))
			ReturnValue+=M
	return ReturnValue
atom/Click()
	..()
	if(istype(src,/mob))
		if(src<>usr)
			if(istype(src,/mob/Clones/Shadow))
				var/mob/Clones/Shadow/SC=src
				if(SC.Owner==usr)
					if(!usr.likeaclone)
						usr.likeaclone=SC
						usr.client:perspective = EYE_PERSPECTIVE
						usr.client:eye=SC
						SC.target_mob=null
						walk(SC,0)
						SC.takeova=1
					else
						if(usr.likeaclone==SC)
							usr.likeaclone=null
							usr.client:perspective = EDGE_PERSPECTIVE
							usr.client:eye=usr
							SC.target_mob=null
							walk(SC,0)
							SC.takeova=0
			if(usr.henge>=1&&usr.henge<4)
				var/mob/M=src
				if(!M.henge)
					usr.henge=4
					view(usr)<<sound('flashbang_explode1.ogg',0,0)
					var/obj/A = new/obj/MiscEffects/Smoke(usr.loc)
					A.loc=usr.loc
					//var/srcname=src.name
					usr.icon=src.icon
					usr.icon_state=src.icon_state
					usr.overlays=0
					usr.overlays=src.overlays
			for(var/mob/Clones/Shadow/S in view(usr,20))
				spawn()
					if(S.Owner==usr)
						S.target_mob=src
						S.FollowTarget()
		else
			for(var/mob/Clones/Shadow/S in view(usr,20))
				spawn()
					var/mob/SC=src
					if(S.Owner==usr&&SC.Owner<>usr)
						S.target_mob=null
						walk_towards(S,usr,3)
	if(istype(src,/obj)&&src.Hengable)
		if(usr.henge>=2&&usr.henge<4)
			usr.henge=5
			view(usr)<<sound('flashbang_explode1.ogg',0,0)
			var/obj/A = new/obj/MiscEffects/Smoke(usr.loc)
			A.loc=usr.loc
			//var/regicon=usr.icon
			usr.icon=src.icon
			usr.icon_state=src.icon_state
			usr.overlays=0
			usr.overlays=src.overlays
	if(istype(src,/turf)&&src.Hengable)
		if(usr.henge==3&&usr.henge<4)
			usr.henge=6
			view(usr)<<sound('flashbang_explode1.ogg',0,0)
			var/obj/A = new/obj/MiscEffects/Smoke(usr.loc)
			A.loc=usr.loc
			//var/regicon=usr.icon
			usr.icon=src.icon
			usr.icon_state=src.icon_state
			usr.overlays=0
			usr.overlays=src.overlays
mob
	Clones
		pixel_x=-10
		byakuview=0
		BugBunshin
			health=1
			maxhealth=1
			chakra=400
			maxchakra=400
			density=1
			var/obj/PrisonOb
			var/TrapTimes=2
			icon='Insect clone.dmi'
			New()
				..()
				spawn(1)
					BAi()
				spawn() Imprison()
				icon_state = ""
			Del()
				if(Prisoner)
					for(var/mob/player/M in world) if(Prisoner==M)
						M.move=1
						M.canattack=1
						M.firing=0
						M.injutsu=0
				if(PrisonOb) del(PrisonOb)
				..()
			Move()
				if(!move||injutsu) return
				..()
			proc/BAi()
				if(src)
					for(var/mob/P in oview(src,0))
						if(P.loc==src.loc)
							step(src,pick(NORTH,SOUTH,WEST,EAST,NORTHWEST,NORTHEAST,SOUTHWEST,SOUTHEAST))
							if(prob(50))
								step_rand(src)
							var/k = src.overlays
							src.overlays=null
							flick("form",src)
							spawn(3) src.overlays = k
			proc/Imprison()
				while(src)
					sleep(4)
					if(move==0) continue
					if(src.takeova) continue
					for(var/mob/X in oview(src))
						if(X <> Owner)
							if(X && !X.dead && X.move)
								while(get_dist(X,src)<>1 && X && src)
									sleep(1)
									if(src)
										if(X)
											step_towards(src,X)
								if(X)
									if(src)
										dir=get_dir(src,X)
										for(var/mob/player/M in get_step(src,src.dir))
											if(M <> Owner)
												if(src)
													src.Attack()
			proc/Attack()
				if(src.canattack==1)
					var/mob/Owner=src.Owner
					src.canattack=0
					for(var/mob/c_target in get_step(src,src.dir))
						if(istype(c_target,/mob/NPCs/Shinobi/)) return
					if(src.icon_state<>"blank")
						if(src.Hand=="Left")
							flick("punchl",src)
							src.Hand="Right"
						else
							if(src.Hand=="Right")
								flick("punchr",src)
								src.Hand="Left"
					view(src,10) << sound('Sounds/Swing5.ogg',0,0,0,100)
					if(src.agility<50)
						spawn(2)
							for(var/mob/c_target in get_step(src,src.dir))
								src.dir = get_dir(src,c_target)
								if(c_target in get_step(src,src.dir))
									if(c_target.dead==0&&c_target!=Owner)
										if(c_target.fightlayer==src.fightlayer)
											if(c_target.dodge==0)
												var/undefendedhit=round(src.taijutsu-c_target.defence/4)
												if(undefendedhit<0)
													undefendedhit=0
												c_target.health-=undefendedhit
												var/colour = colour2html("white")
												F_damage(c_target,undefendedhit,colour)
											//	if(Owner.loc.loc:Safe!=1) Owner.LevelStat("Taijutsu",1)
												if(c_target.loc.loc:Safe!=1) c_target.LevelStat("Defence",rand(1,2))
												c_target.Levelup()
												Owner.Levelup()
												if(src.Hand=="Left")
													view(src,10) << sound('Sounds/LPunchHIt.ogg',0,0,0,100)
												if(src.Hand=="Right")
													view(src,10) << sound('Sounds/HandDam_Normal2.ogg',0,0,0,100)
												c_target.Death(src)
											else
												if(src.agility>=c_target.agility)
													var/defendedhit=src.taijutsu-c_target.defence
													if(defendedhit<0)
														defendedhit=0
												//	if(Owner.loc.loc:Safe!=1) Owner.taijutsu++
													Owner.Levelup()
													if(c_target.loc.loc:Safe!=1) c_target.LevelStat("Defence",rand(3,5))
													if(defence<src.taijutsu/3)
														var/obj/Drag=new /obj/Drag/Dirt(c_target.loc)
														Drag.dir=c_target.dir
														step(c_target,src.dir)
														c_target.dir = get_dir(c_target,src)
														step_to(src,c_target,1)
													var/colour = colour2html("white")
													F_damage(c_target,defendedhit,colour)
													c_target.health-=defendedhit
													c_target.Levelup()
													flick("defendhit",c_target)
													view(src,10) << sound('Sounds/Counter_Success.ogg',0,0,0,100)
													c_target.Death(src)
												else
													flick("dodge",c_target)
													var/colour = colour2html("white")
													F_damage(c_target,0,colour)
													if(c_target.loc.loc:Safe!=1) c_target.LevelStat("Agility",rand(2,5))
													c_target.Levelup()
					else
						if(src.agility>=50)
							for(var/mob/c_target in get_step(src,src.dir))
								src.dir = get_dir(src,c_target)
								if(c_target in get_step(src,src.dir))
									if(c_target.dead==0&&c_target!=Owner)
										if(c_target.fightlayer==src.fightlayer)
											if(c_target.dodge==0)
												var/undefendedhit=round(src.taijutsu-c_target.defence/4)
												if(undefendedhit<0)undefendedhit=0
												c_target.health-=undefendedhit
												var/colour = colour2html("white")
												F_damage(c_target,undefendedhit,colour)
											//	if(Owner.loc.loc:Safe!=1) Owner.LevelStat("Taijutsu",1)
												if(c_target.loc.loc:Safe!=1) c_target.LevelStat("Defence",rand(1,2))
												c_target.Levelup()
												Owner.Levelup()
												if(src.Hand=="Left")view(src,10) << sound('Sounds/LPunchHIt.ogg',0,0,0,100)
												if(src.Hand=="Right")view(src,10) << sound('Sounds/HandDam_Normal2.ogg',0,0,0,100)
												c_target.Death(src)
											else
												if(src.agility>=c_target.agility)
													var/defendedhit=src.taijutsu-c_target.defence
													if(defendedhit<0)
														defendedhit=0
													//if(Owner.loc.loc:Safe!=1) Owner.taijutsu++
													Owner.Levelup()
													if(c_target.loc.loc:Safe!=1) c_target.LevelStat("Defence",rand(3,5))
													if(defence<src.taijutsu/3)
														var/obj/Drag=new /obj/Drag/Dirt(c_target.loc)
														Drag.dir=c_target.dir
														step(c_target,src.dir)
														c_target.dir = get_dir(c_target,src)
														step_to(src,c_target,1)
													var/colour = colour2html("white")
													F_damage(c_target,defendedhit,colour)
													c_target.health-=defendedhit
													c_target.Levelup()
													flick("defendhit",c_target)
													view(src,10) << sound('Sounds/Counter_Success.ogg',0,0,0,100)
													c_target.Death(src)
												else
													flick("dodge",c_target)
													var/colour = colour2html("white")
													F_damage(c_target,0,colour)
													if(c_target.loc.loc:Safe!=1) c_target.LevelStat("Agility",rand(2,5))
													c_target.Levelup()
					spawn(12)if(src)src.canattack=1
		MizuBunshin
			health=1
			maxhealth=1
			chakra=400
			maxchakra=400
			density=1
			var/obj/PrisonOb
			var/TrapTimes=2
			icon='Water Bunshin.dmi'
			New()
				..()
				spawn(1)BAi()
				spawn() Imprison()
				var/obj/Jutsus/WaterPrison/J=new
				JutsusLearnt+=J
				J.level=2
				icon = 'MaleBase.dmi'
				icon_state = ""
			Del()
				if(Prisoner)
					for(var/mob/player/M in world) if(Prisoner==M)
						M.move=1
						M.canattack=1
						M.firing=0
						M.Prisoned=0
						M.injutsu=0
				if(PrisonOb)del(PrisonOb)
				..()
			proc/BAi()
				if(src)
					for(var/mob/P in oview(src,0))
						if(P.loc==src.loc)
							step(src,pick(NORTH,SOUTH,WEST,EAST,NORTHWEST,NORTHEAST,SOUTHWEST,SOUTHEAST))
							if(prob(50))step_rand(src)
							var/list/k = src.overlays.Copy()
							src.overlays=null
							flick("form",src)
							spawn(3) src.overlays = k.Copy()
							icon='MaleBase.dmi'
			Bump(atom/O)
				if(istype(O,/mob))
					var/mob/M=O
					if(M.fightlayer==src.fightlayer)
						src.health=0
						src.Death(M)
					else src.loc=M.loc
				if(istype(O,/obj))
					var/obj/OO=O
					if(!OO.Owner) return
					src.health=0
					src.Death(OO.Owner)
				if(istype(O,/turf))
					src.health=0
					src.Death(src)
			proc/Imprison()
				while(src)
					sleep(4)
					if(!move) continue
					if(src.takeova) continue
					if(TrapTimes<=0)
						src.health=0
						Death(src)
					for(var/mob/X in oview(src))
						if(X <> Owner)
							if(X&&istype(X)&&!X.dead&&X.move)
								while(get_dist(X,src)>1)
									sleep(1)
									step_towards(src,X)
								dir=get_dir(src,X)
								for(var/mob/player/M in get_step(src,src.dir))
									var/Timer=25
									if(istype(M)&&!M.dead)
										M.move=0
										M.canattack=0
										M.injutsu=1
										M.firing=1
										M.Prisoned=1
										move=0
										firing=1
										canattack=0
										var/obj/Projectiles/Effects/WaterPrison/W=new
										W.layer=M.layer+2
										W.pixel_x-=45
										W.loc=M.loc
										icon_state="punchrS"
										PrisonOb=W
										Prisoner=M
									while(Timer)
										sleep(2)
										Timer--
										M.Prisoned=1
										M.move=0
										M.canattack=0
										M.injutsu=1
										M.firing=1
									M.move=1
									M.canattack=1
									M.firing=0
									M.Prisoned=0
									M.injutsu=0
									move=1
									firing=0
									canattack=1
									icon_state=""
									del(PrisonOb)
									Prisoner=null
									TrapTimes--
		Bunshin
			health=1
			maxhealth=1
			chakra=1
			maxchakra=1
			density=1
			New()
				..()
				spawn(1)
					BAi()
			proc/BAi()
				if(src)
					for(var/mob/P in oview(src,0))
						if(P.loc==src.loc)
							step(src,pick(NORTH,SOUTH,WEST,EAST,NORTHWEST,NORTHEAST,SOUTHWEST,SOUTHEAST))
							if(prob(50))step_rand(src)
							var/obj/A = new/obj/MiscEffects/Smoke(src.loc)
							A.loc=src.loc
			Bump(atom/O)
				if(istype(O,/mob))
					var/mob/M=O
					if(M.fightlayer==src.fightlayer)
						src.health=0
						src.Death(M)
					else src.loc=M.loc
				if(istype(O,/obj))
					var/obj/OO=O
					if(!OO.Owner) return
					src.health=0
					src.Death(OO.Owner)
				if(istype(O,/turf))
					src.health=0
					src.Death(src)
		Bunshin2
			health=1
			maxhealth=1
			chakra=1
			maxchakra=1
			density=1
			New()
				..()
				spawn(1)BAi()
			proc/BAi()
				if(src)
					for(var/mob/P in oview(src,0))
						if(P.loc==src.loc)
							step(src,pick(NORTH,SOUTH,WEST,EAST,NORTHWEST,NORTHEAST,SOUTHWEST,SOUTHEAST))
							if(prob(50))step_rand(src)
			Bump(atom/O)
				if(istype(O,/mob))
					var/mob/M=O
					if(M.fightlayer==src.fightlayer)
						src.health=0
						src.Death(M)
					else src.loc=M.loc
				if(istype(O,/obj))
					var/obj/OO=O
					if(!OO.Owner) return
					src.health=0
					src.Death(OO.Owner)
				if(istype(O,/turf))
					src.health=0
					src.Death(src)
		Shadow
			health=1
			maxhealth=1
			chakra=1
			maxchakra=1
			density=1
			New()
				..()
				spawn(1)BAi()
			proc/BAi()
				if(src)
					for(var/mob/P in oview(src,0))
						if(P.loc==src.loc)
							step(src,pick(NORTH,SOUTH,WEST,EAST,NORTHWEST,NORTHEAST,SOUTHWEST,SOUTHEAST))
							if(prob(50))step_rand(src)
							var/obj/A = new/obj/MiscEffects/Smoke(src.loc)
							A.loc=src.loc
			proc/FollowTarget()
				if(!src.takeova)
					while(src)
						sleep(1)
						if(src.target_mob)
							if(src.Owner)
								var/mob/Owner=src.Owner
								var/mob/T=usr.target_mob
								if(T)
									if(get_dist(Owner,T)>=17)
										src.target_mob=null
										if(!src.injutsu)
											if(!Owner.likeaclone)walk_towards(src,Owner,3)
									else
										if(get_dist(src,T)>1)
											if(!src.injutsu)walk_towards(src,T,3)
									if(get_dist(src,T)<=1)
										if(T<>src.Owner && T.Owner <> src.Owner)
											if(!Owner.likeaclone)src.Attack()
								continue
						else
							walk(src,0)
							break
			proc/Attack()
				if(src.canattack==1)
					var/mob/Owner=src.Owner
					src.canattack=0
					if(src.icon_state<>"blank")
						if(src.Hand=="Left")
							flick("punchl",src)
							src.Hand="Right"
						else
							if(src.Hand=="Right")
								flick("punchr",src)
								src.Hand="Left"
					view(src,10) << sound('Sounds/Swing5.ogg',0,0,0,100)
					if(src.agility<50)
						spawn(2)
							for(var/mob/c_target in get_step(src,src.dir))
								src.dir = get_dir(src,c_target)
								if(c_target in get_step(src,src.dir))
									if(c_target.dead==0&&c_target!=Owner)
										if(c_target.fightlayer==src.fightlayer)
											if(c_target.dodge==0)
												var/undefendedhit=round(src.taijutsu-c_target.defence/4)
												if(undefendedhit<0)undefendedhit=0
												c_target.health-=undefendedhit
												var/colour = colour2html("white")
												F_damage(c_target,undefendedhit,colour)
											//	if(Owner.loc.loc:Safe!=1) Owner.LevelStat("Taijutsu",1)
												if(c_target.loc.loc:Safe!=1) c_target.LevelStat("Defence",rand(1,2))
												c_target.Levelup()
												Owner.Levelup()
												if(src.Hand=="Left")view(src,10) << sound('Sounds/LPunchHIt.ogg',0,0,0,100)
												if(src.Hand=="Right")view(src,10) << sound('Sounds/HandDam_Normal2.ogg',0,0,0,100)
												c_target.Death(src)
											else
												if(src.agility>=c_target.agility)
													var/defendedhit=src.taijutsu-c_target.defence
													if(defendedhit<0)defendedhit=0
													//if(Owner.loc.loc:Safe!=1) Owner.taijutsu++
													Owner.Levelup()
													if(c_target.loc.loc:Safe!=1) c_target.LevelStat("Defence",rand(3,5))
													if(defence<src.taijutsu/3)
														var/obj/Drag=new /obj/Drag/Dirt(c_target.loc)
														Drag.dir=c_target.dir
														step(c_target,src.dir)
														c_target.dir = get_dir(c_target,src)
														step_to(src,c_target,1)
													var/colour = colour2html("white")
													F_damage(c_target,defendedhit,colour)
													c_target.health-=defendedhit
													c_target.Levelup()
													flick("defendhit",c_target)
													view(src,10) << sound('Sounds/Counter_Success.ogg',0,0,0,100)
													c_target.Death(src)
												else
													flick("dodge",c_target)
													var/colour = colour2html("white")
													F_damage(c_target,0,colour)
													if(c_target.loc.loc:Safe!=1) c_target.LevelStat("Agility",rand(2,5))
													c_target.Levelup()
					else
						if(src.agility>=50)
							for(var/mob/c_target in get_step(src,src.dir))
								src.dir = get_dir(src,c_target)
								if(c_target in get_step(src,src.dir))
									if(c_target.dead==0&&c_target!=Owner)
										if(c_target.fightlayer==src.fightlayer)
											if(c_target.dodge==0)
												var/undefendedhit=round(src.taijutsu-c_target.defence/4)
												if(undefendedhit<0)undefendedhit=0
												c_target.health-=undefendedhit
												var/colour = colour2html("white")
												F_damage(c_target,undefendedhit,colour)
											//	if(Owner.loc.loc:Safe!=1) Owner.LevelStat("Taijutsu",1)
												if(c_target.loc.loc:Safe!=1) c_target.LevelStat("Defence",rand(1,2))
												c_target.Levelup()
												Owner.Levelup()
												if(src.Hand=="Left")view(src,10) << sound('Sounds/LPunchHIt.ogg',0,0,0,100)
												if(src.Hand=="Right")view(src,10) << sound('Sounds/HandDam_Normal2.ogg',0,0,0,100)
												c_target.Death(src)
											else
												if(src.agility>=c_target.agility)
													var/defendedhit=src.taijutsu-c_target.defence
													if(defendedhit<0)defendedhit=0
												//	if(Owner.loc.loc:Safe!=1) Owner.taijutsu++
													Owner.Levelup()
													if(c_target.loc.loc:Safe!=1) c_target.LevelStat("Defence",rand(3,5))
													if(defence<src.taijutsu/3)
														var/obj/Drag=new /obj/Drag/Dirt(c_target.loc)
														Drag.dir=c_target.dir
														step(c_target,src.dir)
														c_target.dir = get_dir(c_target,src)
														step_to(src,c_target,1)
													var/colour = colour2html("white")
													F_damage(c_target,defendedhit,colour)
													c_target.health-=defendedhit
													c_target.Levelup()
													flick("defendhit",c_target)
													view(src,10) << sound('Sounds/Counter_Success.ogg',0,0,0,100)
													c_target.Death(src)
												else
													flick("dodge",c_target)
													var/colour = colour2html("white")
													F_damage(c_target,0,colour)
													if(c_target.loc.loc:Safe!=1) c_target.LevelStat("Agility",rand(2,5))
													c_target.Levelup()
					spawn(12)if(src)src.canattack=1
			Bump(atom/O)
				if(istype(O,/mob))
					var/mob/M=O
					if(M.fightlayer==src.fightlayer)
						if(src.target_mob)
							if(src.target_mob<>M)step_rand(src)
						else
							if(!src.target_mob)
								if(M<>src.Owner)step_rand(src)
					else src.loc=M.loc
				if(istype(O,/obj))step_rand(src)
				if(istype(O,/turf))step_rand(src)
		MShadow
			health=1
			maxhealth=1
			chakra=1
			maxchakra=1
			density=1
			New()
				..()
				spawn(1)BAi()
			proc/BAi()
				if(src)
					for(var/mob/P in oview(src,0))
						if(P.loc==src.loc)
							step(src,pick(NORTH,SOUTH,WEST,EAST,NORTHWEST,NORTHEAST,SOUTHWEST,SOUTHEAST))
							if(prob(50))step_rand(src)
							var/obj/A = new/obj/MiscEffects/Smoke(src.loc)
							A.loc=src.loc
obj
	CROW
		New()
			..()
			spawn(20)if(src)del(src)
mob
	proc
		Chakra_Release()
			if(src.firing==0&&src.canattack==1)
				if(src.chakra>=10)
					src.chakra-=rand(5,10)
					//if(src.loc.loc:Safe!=1) src.LevelStat("Genjutsu",rand(1,2))
					src.Levelup()
					src.UpdateHMB()
					view(src)<<sound('046.ogg',0,0)
					flick("jutsu",src)
					src.move=0
					var/obj/A = new/obj/MiscEffects/Chakra(usr.loc)
					A.loc=src.loc
					//src.overlays+=/obj/MiscEffects/Chakra/
					src.firing=1
					for(var/obj/Hits/Shurikens/N in src.SCaught)
						src.overlays-=N
						var/obj/Projectiles/Weaponry/Shuriken/S = new/obj/Projectiles/Weaponry/Shuriken(src.loc)
						S.Owner=src
						S.damage+=round(src.genjutsu/3)
						step_rand(S)
						walk(S,S.dir)
						src.SCaught-=N
					for(var/obj/Hits/Kunai/N in src.SCaught)
						src.overlays-=N
						var/obj/Projectiles/Weaponry/Kunai/S = new/obj/Projectiles/Weaponry/Kunai(src.loc)
						S.Owner=src
						S.damage+=round(src.genjutsu/3)
						step_rand(S)
						walk(S,S.dir)
						src.SCaught-=N
					for(var/obj/Hits/Needle/N in src.SCaught)
						src.overlays-=N
						var/obj/Projectiles/Weaponry/Needle/S = new/obj/Projectiles/Weaponry/Needle(src.loc)
						S.Owner=src
						S.damage+=round(src.genjutsu/3)
						step_rand(S)
						walk(S,S.dir)
						src.SCaught-=N
					for(var/obj/Hits/BoneTips/N in src.SCaught)
						src.overlays-=N
						var/obj/Projectiles/Weaponry/BoneTip/S = new/obj/Projectiles/Weaponry/BoneTip(src.loc)
						S.Owner=src
						S.damage+=round(src.genjutsu/3)
						step_rand(S)
						walk(S,S.dir)
						src.SCaught-=N
					for(var/obj/Projectiles/Weaponry/ExplosiveTag/N in view(src,1))
						if(N.icon_state<>"blank")
							var/obj/Inventory/Weaponry/Explosive_Tag/S = new/obj/Inventory/Weaponry/Explosive_Tag(src.loc)
							S.loc=src.loc
							del(N)
					src.amounthits=0
					spawn(6)if(src)
						//src.overlays-=/obj/MiscEffects/Chakra/
						src.move=1
						src.firing=0
					//if(client)
					//src.sight |= (SEE_MOBS|SEE_OBJS|SEE_TURFS)
				else src<<output("<Font color=Aqua>You Need More Chakra(10).</Font>","actionoutput")
	proc
		Crow_Clone()
			if(src.firing==0&&src.canattack==1&&!Prisoned&&move)
				for(var/obj/Jutsus/Crow_Clone/J in src.JutsusLearnt)
					if(J.Excluded==0)
						if(src.chakra>=70)
							J.uses++
							J.Excluded=1
							src.injutsu=1
							if(src.loc.loc:Safe!=1) src.LevelStat("Genjutsu",rand(2,4))
							src.Levelup()
							src.chakra-=70
							src.UpdateHMB()
							flick("jutsu",src)
							for(var/mob/M in oview(src,13))M.Target_Remove()
							view(src)<<sound('wirlwind.ogg',0,0)
							var/obj/O = new/obj
							O.loc = src.loc
							var/BUNLIST = list()
							for(var/i=0,i<J.level*3,i++)
								var/mob/Clones/Bunshin2/A = new/mob/Clones/Bunshin2(src.loc)
								A.loc=src.loc
								A.Owner=src
								A.icon=src.icon
								A.overlays=src.overlays
								A.invisibility=1
								if(i<5)BUNLIST+=A
								step_rand(A)
								step_rand(A)
								step_rand(A)
								step_rand(A)
								step_rand(A)
								spawn(100)if(A)del(A)
							src.invisibility=1
							step_rand(src)
							step_rand(src)
							step_rand(src)
							step_rand(src)
							step_rand(src)
							for(var/mob/Z in BUNLIST)
								var/obj/C = new/obj/CROW
								C.loc = O.loc
								C.pixel_x=-16
								C.icon = 'Crows.dmi'
								C.overlays+=image('Crows.dmi',pixel_x=-16+rand(-8,8),pixel_y=rand(-8,8))
								C.overlays+=image('Crows.dmi',pixel_x=-16+rand(-8,8),pixel_y=rand(-8,8))
								C.overlays+=image('Crows.dmi',pixel_x=-16+rand(-8,8),pixel_y=rand(-8,8))
								walk_to(C,Z)
								spawn(5)
									if(Z)Z.invisibility=0
									if(C)del(C)
							var/obj/C2 = new/obj/CROW
							C2.loc = O.loc
							C2.pixel_x=-16
							C2.icon = 'Crows.dmi'
							C2.overlays+=image('Crows.dmi',pixel_x=-16+rand(-8,8),pixel_y=rand(-8,8))
							C2.overlays+=image('Crows.dmi',pixel_x=-16+rand(-8,8),pixel_y=rand(-8,8))
							C2.overlays+=image('Crows.dmi',pixel_x=-16+rand(-8,8),pixel_y=rand(-8,8))
							walk_to(C2,src)
							spawn(5)if(src)
								src.invisibility=0
								src.injutsu=0
							spawn(5)if(C2)del(C2)
							if(J.level<4&&src.loc.loc:Safe!=1)
								J.exp+=rand(5,15)
								J.Levelup()
							//view()<<output("<b><font color=white>[src] Says:</Font><font color=silver> Clone Jutsu</Font>","actionoutput")
							src.JutsuCoolSlot(J)
							spawn()
								J.cooltimer=J.maxcooltime
								J.JutsuCoolDown(src)
							//spawn(10)
							//	src.firing=0
						else src<<output("<Font color=Aqua>You Need More Chakra(70).</Font>","actionoutput")
		Clone_Jutsu()
			if(src.firing==0&&src.canattack==1)
				for(var/obj/Jutsus/BClone/J in src.JutsusLearnt)
					if(J.Excluded==0)
						if(src.chakra>=25)
							if(src.bunshin<src.maxbunshin)
								J.uses++
								J.Excluded=1
								src.bunshin++
								if(src.loc.loc:Safe!=1) src.LevelStat("Genjutsu",rand(2,4))
								src.Levelup()
								src.chakra-=rand(12,25)
								src.UpdateHMB()
								flick("jutsu",src)
								for(var/mob/M in oview(src,13))M.Target_Remove()
								view(src)<<sound('flashbang_explode1.ogg',0,0)
								var/timer = J.level
								while(timer)
									sleep(1)
									timer--
									var/mob/Clones/Bunshin/A = new/mob/Clones/Bunshin(src.loc)
									A.loc=src.loc
									A.Owner=src
									A.icon=src.icon
									A.overlays=src.overlays
								if(J.level<4&&src.loc.loc:Safe!=1)
									J.exp+=rand(5,15)
									J.Levelup()
								//view()<<output("<b><font color=white>[src] Says:</Font><font color=silver> Clone Jutsu</Font>","actionoutput")
								src.JutsuCoolSlot(J)
								spawn()
									J.cooltimer=J.maxcooltime
									J.JutsuCoolDown(src)
								//spawn(10)
								//	src.firing=0
						else src<<output("<Font color=Aqua>You Need More Chakra(25).</Font>","actionoutput")
		InsectClone()
			if(src.firing==0&&src.canattack==1)
				for(var/obj/Jutsus/Insect_Clone/J in src.JutsusLearnt)
					if(J.Excluded==0)
						if(src.chakra>=10)
							src.chakra-=rand(10,20)
							view(src)<<sound('bugs.ogg',0,0)
							if(src.loc.loc:Safe!=1) src.LevelStat("Genjutsu",rand(2,4))
							src.Levelup()
							J.uses++
							for(var/mob/M in oview(src,13))M.Target_Remove()
							J.Excluded=1
							src.mizubunshin++
							var/bun=src.mizubunshin+1
							src.health-=round(src.health/bun)
							src.chakra-=round(src.chakra/bun)
							src.UpdateHMB()
							flick("jutsu",src)
							var/mob/Clones/BugBunshin/A = new/mob/Clones/BugBunshin(src.loc)
							A.loc=src.loc
							A.Owner=src
							A.icon=src.icon
							A.overlays=src.overlays
							A.taijutsu=round(src.taijutsu/bun)
							A.defence=round(src.defence/bun)
							A.health=round(src.health/bun)
							A.maxhealth=round(src.health/bun)
							A.agility=round(src.agility/bun)
							var/obj/O=new /obj/Screen/healthbar/
							var/obj/M=new /obj/Screen/manabar/
							A.hbar.Add(O)
							A.hbar.Add(M)
							spawn(3)if(src)if(A)A.icon = src.icon
							A.overlays-=/obj/Screen/healthbar
							A.overlays-=/obj/Screen/manabar
							for(var/obj/Screen/healthbar/HB in A.hbar)A.overlays+=HB
							for(var/obj/Screen/manabar/HB in A.hbar)A.overlays+=HB
							A.UpdateHMB()
							if(J.level<4&&src.loc.loc:Safe!=1)
								J.exp+=rand(5,15)
								J.Levelup()
							spawn()
								if(src)
									src.JutsuCoolSlot(J)
									J.cooltimer=J.maxcooltime
									J.JutsuCoolDown(src)
						else src<<output("<Font color=Aqua>You Need More Chakra(100).</Font>","actionoutput")
		MizuClone_Jutsu()
			if(src.firing==0&&src.canattack==1)
				for(var/obj/Jutsus/MizuClone/J in src.JutsusLearnt)
					if(!has_water())
						src<<output("<Font color=Aqua>You need a nearby water source to use this.</Font>","actionoutput")
						return
					if(J.Excluded==0)
						if(src.chakra>=20)
							src.chakra-=rand(10,20)
							view(src)<<sound('flashbang_explode1.ogg',0,0)
							if(src.loc.loc:Safe!=1) src.LevelStat("Genjutsu",rand(2,4))
							src.Levelup()
							J.uses++
							for(var/mob/M in oview(src,13))
								M.Target_Remove()
							J.Excluded=1
							src.mizubunshin++
							var/bun=src.mizubunshin+1
							src.health-=round(src.health/bun)
							src.chakra-=round(src.chakra/bun)
							src.UpdateHMB()
							flick("jutsu",src)
							var/mob/Clones/MizuBunshin/A = new/mob/Clones/MizuBunshin(src.loc)
							A.loc=src.loc
							A.Owner=src
							A.icon=src.icon
							A.overlays=src.overlays.Copy()
							A.taijutsu=round(src.taijutsu/bun)
							A.defence=round(src.defence/bun)
							A.health=round(src.health/bun)
							A.maxhealth=round(src.health/bun)
							A.agility=round(src.agility/bun)
							var/obj/O=new /obj/Screen/healthbar/
							var/obj/M=new /obj/Screen/manabar/
							A.hbar.Add(O)
							A.hbar.Add(M)
							spawn(3) if(A) A.icon = src.icon
							A.overlays-=/obj/Screen/healthbar
							A.overlays-=/obj/Screen/manabar
							for(var/obj/Screen/healthbar/HB in A.hbar)A.overlays+=HB
							for(var/obj/Screen/manabar/HB in A.hbar)A.overlays+=HB
							A.UpdateHMB()
							if(J.level<4&&src.loc.loc:Safe!=1)
								J.exp+=rand(5,15)
								J.Levelup()
							spawn()
								src.JutsuCoolSlot(J)
								J.cooltimer=J.maxcooltime
								J.JutsuCoolDown(src)
						else src<<output("<Font color=Aqua>You Need More Chakra(100).</Font>","actionoutput")
		MultipleShadowClone_Jutsu()
			if(src.firing==0&&src.canattack==1)
				for(var/obj/Jutsus/MSClone/J in src.JutsusLearnt)
					if(J.Excluded==0)
						if(src.chakra>=100)
							src.chakra-=rand(90,100)
							view(src)<<sound('flashbang_explode1.ogg',0,0)
							if(src.loc.loc:Safe!=1) src.LevelStat("Genjutsu",rand(2,4))
							src.Levelup()
							for(var/mob/M in oview(src,13))
								M.Target_Remove()
							while(src.sbunshin<>5)
								sleep(1)
								J.uses++
								J.Excluded=1
								src.sbunshin++
								var/bun=src.sbunshin+1
								src.health-=round(src.health/bun)
								src.chakra-=round(src.chakra/bun)
								src.UpdateHMB()
								flick("jutsu",src)
								var/mob/Clones/Shadow/A = new/mob/Clones/Shadow(src.loc)
								A.loc=src.loc
								A.Owner=src
								A.icon=src.icon
								A.overlays=src.overlays
								A.taijutsu=round(src.taijutsu/bun)
								A.defence=round(src.defence/bun)
								A.health=round(src.health/bun)
								A.maxhealth=round(src.health/bun)
								A.agility=round(src.agility/bun)
								var/obj/O=new /obj/Screen/healthbar/
								var/obj/M=new /obj/Screen/manabar/
								A.hbar.Add(O)
								A.hbar.Add(M)
								A.overlays-=/obj/Screen/healthbar
								A.overlays-=/obj/Screen/manabar
								for(var/obj/Screen/healthbar/HB in A.hbar)A.overlays+=HB
								for(var/obj/Screen/manabar/HB in A.hbar)A.overlays+=HB
								A.UpdateHMB()
							if(J.level<4&&src.loc.loc:Safe!=1)
								J.exp+=rand(5,15)
								J.Levelup()
							spawn()
								src.JutsuCoolSlot(J)
								J.cooltimer=J.maxcooltime
								J.JutsuCoolDown(src)
						else src<<output("<Font color=Aqua>You Need More Chakra(100).</Font>","actionoutput")
		ShadowClone_Jutsu()
			if(src.firing==0&&src.canattack==1)
				for(var/obj/Jutsus/SClone/J in src.JutsusLearnt)
					if(J.Excluded==0)
						if(src.chakra>=50)
							if(!src.sbunshin)
								J.uses++
								J.Excluded=1
								src.sbunshin++
								var/bun=src.sbunshin+1
								src.health-=round(src.health/bun)
								src.chakra-=round(src.chakra/bun)
								if(src.loc.loc:Safe!=1) src.LevelStat("Genjutsu",rand(2,4))
								src.Levelup()
								src.chakra-=rand(12,25)
								src.UpdateHMB()
								flick("jutsu",src)
								view(src)<<sound('flashbang_explode1.ogg',0,0)
								var/mob/Clones/Shadow/A = new/mob/Clones/Shadow(src.loc)
								A.loc=src.loc
								A.Owner=src
								A.icon=src.icon
								A.overlays=src.overlays
								A.taijutsu=round(src.taijutsu/bun)
								A.defence=round(src.defence/bun)
								A.health=round(src.health/bun)
								A.maxhealth=round(src.health/bun)
								A.agility=round(src.agility/bun)
								var/obj/O=new /obj/Screen/healthbar/
								var/obj/M=new /obj/Screen/manabar/
								A.hbar.Add(O)
								A.hbar.Add(M)
								A.overlays-=/obj/Screen/healthbar
								A.overlays-=/obj/Screen/manabar
								for(var/obj/Screen/healthbar/HB in A.hbar)A.overlays+=HB
								for(var/obj/Screen/manabar/HB in A.hbar)A.overlays+=HB
								A.UpdateHMB()
								if(J.level<4&&src.loc.loc:Safe!=1)
									J.exp+=rand(5,15)
									J.Levelup()
								//view()<<output("<b><font color=white>[src] Says:</Font><font color=silver> Clone Jutsu</Font>","actionoutput")
								spawn()
									src.JutsuCoolSlot(J)
									J.cooltimer=J.maxcooltime
									J.JutsuCoolDown(src)
								//spawn(10)
								//	src.firing=0
						else src<<output("<Font color=Aqua>You Need More Chakra(50).</Font>","actionoutput")
	proc
		Clone_Jutsu_Destroy()
			if(src.firing==0&&src.canattack==1)
				if(src.bunshin<>0||src.sbunshin<>0||src.msbunshin<>0||mizubunshin<>0)
					src.Levelup()
					flick("jutsu",src)
					for(var/mob/Clones/C in world)
						if(C.Owner==src)
							C.health=0
							C.Death(src)
					src.bunshin=0
					src.sbunshin=0
	proc
		Transformation_Jutsu()
			if(src.firing==0)
				if(src.canattack==1)
					for(var/obj/Jutsus/Transformation/J in src.JutsusLearnt)
						if(J.Excluded==0)
							if(src.henge==0)
								if(src.chakra>=15)
									J.uses++
									J.Excluded=1
									if(src.loc.loc:Safe!=1) src.LevelStat("Genjutsu",rand(2,5))
									src.Levelup()
									src.chakra-=rand(8,15)
									src.UpdateHMB()
									if(J.level==1)src.henge=1
									if(J.level==2)src.henge=2
									if(J.level==3)src.henge=3
									if(J.level<3&&src.loc.loc:Safe!=1)
										J.exp+=rand(5,15)
										J.Levelup()
									src.JutsuCoolSlot(J)
									spawn()
										src<<output("<Font color=white>Now click the object you wish to transform into.</Font>","actionoutput")
										J.cooltimer=J.maxcooltime
										J.JutsuCoolDown(src)
								else src<<output("<Font color=Aqua>You Need More Chakra(15).</Font>","actionoutput")
obj/Jutsus/Effects/
	TempleNirvana
		icon='Temple of Nirvana.dmi'
		pixel_x=-32
		New()
			..()
			spawn(12)if(src)del(src)
	mudslide
		icon='Earth Flow River.dmi'
		pixel_x=-16
		New()
			..()
			spawn(12)if(src)del(src)
	desertcoffin
		icon='Desert Coffin.dmi'
		pixel_x=-21
		New()
			..()
			spawn(200)if(src)del(src)
	papercoffin
		icon='Paper Bind.dmi'
		pixel_x=-21
		New()
			..()
			spawn(200)if(src)del(src)
obj/TsukiyomiHUD
	icon = 'Misc Effects.dmi'
	screen_loc = "SOUTHWEST to NORTHEAST"
	icon_state = "Fade"
	layer = 600
	name = null
	mouse_opacity=0
	New(var/client/C)
		..()
		C.screen += src
		spawn(10)if(src)del(src)
mob
	proc
		Tsukiyomi()
			for(var/obj/Jutsus/Tsukiyomi/J in src.JutsusLearnt)
				if(J.Excluded) return
				if(Sharingan!=4)
					src<<output("You must have Mangekyou Sharingan activated in order to use this.","actionoutput")
					return
				var/mob/player/c_target=usr.Target_Get(TARGET_MOB)
				if(!c_target||!istype(c_target))
					src<<output("You must have a target to use this technique.","actionoutput")
					return
				if(ChakraCheck(200)) return
				if(loc.loc:Safe!=1) src.LevelStat("Ninjutsu",rand(1,2))
				src.Levelup()
				src.UpdateHMB()
				//view()<<"<font size=1><font face=Times New Roman><b><font color=white>[src] Says:<font color=yellow> Fire Release:Fire Ball"
				flick("jutsuse",src)
				//view(src)<<sound('wind_leaves.ogg',0,0)
				src.firing=1
				src.canattack=0
				J.Excluded=1
				J.uses++
				if(J.level<4) if(loc.loc:Safe!=1) J.exp+=rand(2,5); J.Levelup()
				move=0
				canattack=0
				injutsu=1
				c_target.move=0
				c_target.canattack=0
				c_target.injutsu=1
				src.Prisoner=c_target
				new/obj/TsukiyomiHUD(c_target.client)
				c_target.client.eye=locate(143,38,14)
				c_target.client:perspective = EYE_PERSPECTIVE
				var/Timer=J.level*3
				var/Timer1 = Timer
				spawn(10)
					src.JutsuCoolSlot(J)
					spawn()
						J.cooltimer=J.maxcooltime
						J.JutsuCoolDown(src)
				while(Timer&&c_target)
					sleep(5)
					Timer--
					c_target.health-=round(src.genjutsu/Timer1)
					c_target.Death(src)
				if(c_target)
					c_target.client.eye=c_target
					c_target.client:perspective = EYE_PERSPECTIVE
					c_target.move=1
					c_target.canattack=1
					c_target.injutsu=0
					for(var/obj/TsukiyomiHUD/H in c_target.client.screen)del H
				src.Prisoner=null
				src.firing=0
				src.injutsu=0
				move=1
				canattack=1
				injutsu=0
		TreeBinding()
			for(var/obj/Jutsus/TreeBinding/J in src.JutsusLearnt)
				if(J.Excluded) return
				if(ChakraCheck(100)) return
				var/mob/c_target=usr.Target_Get(TARGET_MOB)
				if(loc.loc:Safe!=1) src.LevelStat("Ninjutsu",rand(1,2))
				src.Levelup()
				src.UpdateHMB()
				//view()<<"<font size=1><font face=Times New Roman><b><font color=white>[src] Says:<font color=yellow> Fire Release:Fire Ball"
				flick("jutsuse",src)
				view(src)<<sound('wind_leaves.ogg',0,0)
				src.firing=1
				src.canattack=0
				J.Excluded=1
				J.uses++
				if(J.level<4) if(loc.loc:Safe!=1) J.exp+=rand(2,5); J.Levelup()
				var/Time=J.level*3
				var/TreeNearby
				for(var/turf/Ground/Trees/T in oview(1,c_target))
					TreeNearby=1
				if(TreeNearby)
					c_target.overlays+='TreeBinding.dmi'
					c_target.move=0
					c_target.injutsu=1
					c_target.canattack=0
					while(Time&&c_target)
						sleep(10)
						Time--
						c_target.health-=2+src.ninjutsu/2
						var/colour = colour2html("white")
						F_damage(c_target,2+src.ninjutsu/2,colour)
						c_target.Death(src)
					if(c_target)
						c_target.overlays-='TreeBinding.dmi'
						if(!c_target.dead)
							c_target.move=1
							c_target.injutsu=0
							c_target.canattack=1
				else src<<"Your target is not by a tree, and the technique fails!"
				src.JutsuCoolSlot(J)
				src.firing=0
				src.canattack=1
				spawn()
					J.cooltimer=J.maxcooltime
					J.JutsuCoolDown(src)
		Earth_Disruption()
			for(var/obj/Jutsus/Earth_Disruption/J in src.JutsusLearnt)
				if(J.Excluded) return
				if(ChakraCheck(60)) return
				//var/mob/c_target=usr.Target_Get(TARGET_MOB)
				if(loc.loc:Safe!=1) src.LevelStat("Ninjutsu",rand(1,2))
				src.Levelup()
				src.UpdateHMB()
				//view()<<"<font size=1><font face=Times New Roman><b><font color=white>[src] Says:<font color=yellow> Fire Release:Fire Ball"
				flick("groundjutsuse",src)
				view(src)<<sound('Skill_BigRoketFire.ogg',0,0)
				src.firing=1
				src.canattack=0
				J.Excluded=1
				J.uses++
				var/TimeAsleep
				if(J.level==1) TimeAsleep=5
				if(J.level==2) TimeAsleep=10
				if(J.level==3) TimeAsleep=15
				if(J.level==4) TimeAsleep=20
				if(J.level<4) if(loc.loc:Safe!=1) J.exp+=rand(2,5); J.Levelup()
				for(var/mob/player/M in oview(J.level))
					if(!istype(M,M)||!M) continue
					M.icon_state="dead"
					M.move=0
					M.injutsu=1
					M.canattack=0
					M.health-=J.level*5+src.taijutsu/2+src.taijutsu/3
					var/colour = colour2html("white")
					F_damage(M,J.level*5+src.taijutsu/2+src.taijutsu/3,colour)
					M.Death(src)
					spawn(TimeAsleep)
						if(!M||M.dead)continue
						M.icon_state=""
						M.move=1
						M.injutsu=0
						M.canattack=1
				src.firing=0
				src.canattack=1
				src.JutsuCoolSlot(J)
				spawn()
					J.cooltimer=J.maxcooltime
					J.JutsuCoolDown(src)
		Paper_Bind()
			for(var/obj/Jutsus/Paper_Bind/J in src.JutsusLearnt)
				if(J.Excluded) return
				if(ChakraCheck(130)) return
				var/mob/c_target=src.Target_Get(TARGET_MOB)
				if(!c_target)
					src << output("This jutsu requires a target","actionoutput")
					return
				//var/mob/c_target=usr.Target_Get(TARGET_MOB)
				if(loc.loc:Safe!=1) src.LevelStat("Ninjutsu",rand(1,2))
				src.Levelup()
				src.UpdateHMB()
				//view()<<"<font size=1><font face=Times New Roman><b><font color=white>[src] Says:<font color=yellow> Fire Release:Fire Ball"
				flick("jutsu",src)
				view(src)<<sound('wind_leaves.ogg',0,0)
				src.firing=1
				src.canattack=0
				src.move=0
				src.injutsu=1
				J.Excluded=1
				J.uses++
				var/TimeAsleep
				if(J.level==1) TimeAsleep=35
				if(J.level==2) TimeAsleep=50
				if(J.level==3) TimeAsleep=75
				if(J.level==4) TimeAsleep=100
				if(J.level<4) if(loc.loc:Safe!=1) J.exp+=rand(2,5); J.Levelup()
				var/mob/M = c_target
				if(M)
					var/turf/T=M.loc
					spawn(10)
						if(M&&T)
							if(T==M.loc)
								var/obj/O = new/obj/Jutsus/Effects/papercoffin(M.loc)
								M.icon_state=""
								M.move=0
								M.dir = SOUTH
								M.injutsu=1
								M.canattack=0
								M.Sleeping=1
								spawn(TimeAsleep)
									if(!M||M.dead)continue
									M.icon_state=""
									M.move=1
									M.injutsu=0
									M.Sleeping=0
									M.canattack=1
									del(O)
							else src<<output("The jutsu did not connect.","actionoutput")
				src.firing=0
				src.canattack=1
				src.move=1
				src.injutsu=0
				src.JutsuCoolSlot(J)
				spawn()
					J.cooltimer=J.maxcooltime
					J.JutsuCoolDown(src)
		Bringer_of_Darkness_Technique()
			for(var/obj/Jutsus/Bringer_of_Darkness_Technique/J in src.JutsusLearnt)
				if(J.Excluded)return
				if(ChakraCheck(50))return
				var/mob/c_target=src.Target_Get(TARGET_MOB)
				if(!c_target)
					src << output("This jutsu requires a target","actionoutput")
					return
				if(loc.loc:Safe!=1) src.LevelStat("Ninjutsu",rand(1,2))
				src.Levelup()
				src.UpdateHMB()
				//view()<<"<font size=1><font face=Times New Roman><b><font color=white>[src] Says:<font color=yellow> Fire Release:Fire Ball"
				flick("jutus",src)
				view(src)<<sound('wind_leaves.ogg',0,0)
				src.firing=1
				src.canattack=0
				J.Excluded=1
				J.uses++
				var/TimeAsleep
				if(J.level==1)TimeAsleep=50
				if(J.level==2)TimeAsleep=75
				if(J.level==3)TimeAsleep=100
				if(J.level==4)TimeAsleep=150
				if(J.level<4)if(loc.loc:Safe!=1)J.exp+=rand(2,5); J.Levelup()
				//var/mob/M = c_target
				TimeAsleep+=src.genjutsu+(src.Sharingan*10)
				if(c_target.client)
					/*c_target.sight &= ~SEE_TURFS
					c_target.sight &= ~SEE_MOBS
					c_target.sight |= SEE_SELF
					spawn(TimeAsleep)if(c_target)
						c_target.sight |= SEE_TURFS
						c_target.sight |= SEE_MOBS*/
					c_target.sight |= BLIND
					spawn(TimeAsleep)if(c_target)c_target.sight &= ~BLIND
				src.firing=0
				src.canattack=1
				src.JutsuCoolSlot(J)
				spawn()
					J.cooltimer=J.maxcooltime
					J.JutsuCoolDown(src)
		Desert_Coffin()
			for(var/obj/Jutsus/Desert_Coffin/J in src.JutsusLearnt)
				if(J.Excluded)return
				if(ChakraCheck(200))return
				var/mob/c_target=src.Target_Get(TARGET_MOB)
				if(!c_target)
					src << output("This jutsu requires a target","actionoutput")
					return
				//var/mob/c_target=usr.Target_Get(TARGET_MOB)
				if(loc.loc:Safe!=1) src.LevelStat("Ninjutsu",rand(1,2))
				src.Levelup()
				src.UpdateHMB()
				//view()<<"<font size=1><font face=Times New Roman><b><font color=white>[src] Says:<font color=yellow> Fire Release:Fire Ball"
				flick("punchrS",src)
				view(src)<<sound('wind_leaves.ogg',0,0)
				src.firing=1
				src.canattack=0
				src.injutsu=1
				src.move=0
				J.Excluded=1
				J.uses++
				var/TimeAsleep
				if(J.level==1)TimeAsleep=50
				if(J.level==2)TimeAsleep=75
				if(J.level==3)TimeAsleep=100
				if(J.level==4)TimeAsleep=150
				if(J.level<4) if(loc.loc:Safe!=1) J.exp+=rand(2,5); J.Levelup()
				var/mob/M = c_target
				if(M)
					var/turf/T=M.loc
					spawn(10)
						if(M&&T)
							if(T==M.loc)
								var/obj/O = new/obj/Jutsus/Effects/desertcoffin(M.loc)
								M.icon_state=""
								M.move=0
								M.dir = SOUTH
								M.injutsu=1
								M.Sleeping=1
								M.canattack=0
								spawn(TimeAsleep)
									if(!M||M.dead)continue
									M.Sleeping=0
									M.icon_state=""
									M.move=1
									M.injutsu=0
									M.canattack=1
									if(O)del(O)
							else src<<output("The jutsu did not connect.","actionoutput")
				src.firing=0
				src.canattack=1
				src.injutsu=0
				src.move=1
				src.JutsuCoolSlot(J)
				spawn()
					J.cooltimer=J.maxcooltime
					J.JutsuCoolDown(src)
		Earth_Release_Mud_River()
			for(var/obj/Jutsus/Earth_Release_Mud_River/J in src.JutsusLearnt)
				if(J.Excluded) return
				if(ChakraCheck(100)) return
				var/mob/c_target=src.Target_Get(TARGET_MOB)
				if(!c_target)
					src << output("This jutsu requires a target","actionoutput")
					return
				//var/mob/c_target=usr.Target_Get(TARGET_MOB)
				if(loc.loc:Safe!=1) src.LevelStat("Ninjutsu",rand(1,2))
				src.Levelup()
				src.UpdateHMB()
				//view()<<"<font size=1><font face=Times New Roman><b><font color=white>[src] Says:<font color=yellow> Fire Release:Fire Ball"
				flick("jutsuse",src)
				view(src)<<sound('man_fs_l_mt_wat.ogg',0,0)
				src.firing=1
				src.canattack=0
				J.Excluded=1
				J.uses++
				var/TimeAsleep
				if(J.level==1) TimeAsleep=25
				if(J.level==2) TimeAsleep=50
				if(J.level==3) TimeAsleep=75
				if(J.level==4) TimeAsleep=100
				if(J.level<4) if(loc.loc:Safe!=1) J.exp+=rand(2,5); J.Levelup()
				new/obj/Jutsus/Effects/mudslide(src.loc)
				var/mob/M = c_target
				if(M)
					var/turf/T=M.loc
					spawn(10)
						if(M&&T)
							if(T==M.loc)
								new/obj/Jutsus/Effects/mudslide(M.loc)
								M.icon_state="dead"
								M.move=0
								M.injutsu=1
								M.canattack=0
								M.Sleeping=1
								spawn(TimeAsleep)
									if(!M||M.dead)continue
									M.icon_state=""
									M.move=1
									M.injutsu=0
									M.canattack=1
									M.Sleeping=0
							else src<<output("The jutsu did not connect.","actionoutput")
				src.firing=0
				src.canattack=1
				src.JutsuCoolSlot(J)
				spawn()
					J.cooltimer=J.maxcooltime
					J.JutsuCoolDown(src)
		Temple_Of_Nirvana()
			for(var/obj/Jutsus/Temple_Of_Nirvana/J in src.JutsusLearnt)
				if(J.Excluded) return
				if(ChakraCheck(200)) return
				//var/mob/c_target=usr.Target_Get(TARGET_MOB)
				if(loc.loc:Safe!=1) src.LevelStat("Ninjutsu",rand(1,2))
				src.Levelup()
				src.UpdateHMB()
				//view()<<"<font size=1><font face=Times New Roman><b><font color=white>[src] Says:<font color=yellow> Fire Release:Fire Ball"
				flick("jutsuse",src)
				view(src)<<sound('wind_leaves.ogg',0,0)
				src.firing=1
				src.canattack=0
				spawn(2)
					src.firing=0
					src.canattack=1
				J.Excluded=1
				J.uses++
				var/TimeAsleep
				if(J.level==1) TimeAsleep=50
				if(J.level==2) TimeAsleep=60
				if(J.level==3) TimeAsleep=70
				if(J.level==4) TimeAsleep=80
				if(J.level<4) if(loc.loc:Safe!=1) J.exp+=rand(2,5); J.Levelup()
				new/obj/Jutsus/Effects/TempleNirvana(src.loc)
				for(var/mob/player/M in oview(J.level))
					if(Squad)
						if(Squad.Members.Find(M.ckey)||getOwner(Squad.Leader)==M.ckey) continue
					new/obj/Jutsus/Effects/TempleNirvana(M.loc)
					if(M.Sharingan>=2) continue
					M.Sleeping=1
					M.icon_state="dead"
					M.move=0
					M.injutsu=1
					M.firing=1
					M.canattack=0
					spawn(TimeAsleep)
						if(!M||M.dead) continue
						M.icon_state=""
						M.move=1
						M.injutsu=0
						M.canattack=1
						M.Sleeping=0
						M.firing=0
				src.firing=0
				src.canattack=1
				src.JutsuCoolSlot(J)
				spawn()
					J.cooltimer=J.maxcooltime
					J.JutsuCoolDown(src)
turf
	Tsukiyomi
	//	var/Inversion
		icon='Tsukuyomi.dmi'
	//	proc/Flash()
	//		while(src)
	//			icon_state=Inversion
	//			sleep(30)
	//			icon_state=initial(icon_state)
	//			sleep(30)
	//	New()
	//		..()
	//		Flash()
		Grass
			//icon_state="Grass"
			icon_state="Inverted Grass"
obj
	Tsukiyomi
		icon='Tsukuyomi.dmi'
		Rock
		//	icon_state="Rock"
			icon_state="Inverted Rock"
		TorturerHit
		//icon_state="Torturer Hit"
			icon_state="Inverted Hit"
		Cross
		//	icon_state="Cross"
			icon_state="Cross2"
		Torturer
		//	icon_state="Cross"
			icon_state="Inverted Torturer"
obj
	JutsuOverlays
		layer=999
		icon='Misc Effects.dmi'
		Cool1
			icon_state="jutsuwait1"
		Cool2
			icon_state="jutsuwait2"
		Cool3
			icon_state="jutsuwait3"
		Cool4
			icon_state="jutsuwait4"
mob
	var
		tmp
			waitslot=0
obj
	var
		tmp
			cooltimer=0
			maxcooltime
mob
	proc
		JutsuCoolSlot(obj/Jutsus/O)
			if(waitslot>=src.YView) return
			src.waitslot++
			O.screen_loc="[src.XView-2],[src.YView-src.waitslot]"
			src.client.screen+=O
			if(O.Clan==null)
				for(var/mob/M in world)
					if(get_dist(M,src)<10 && M <> src)
						if(M.jutsucopy==1)
							var/X = O.type
							var/obj/Z = new X
							Z.invisibility=1
							M.jutsucopy = Z
							M << output("Your sharingan copies [src]'s [O]","actionoutput")
obj
	proc
		JutsuCoolDown(mob/O)
			while(O&&src)
				var/timeoff=rand(1,4)
				sleep(timeoff)
				if(src.Excluded)
					src.overlays=0
					if(O.Specialist=="Ninjutsu"||O.Specialist2=="Ninjutsu")src.cooltimer-=timeoff*2
					else src.cooltimer-=timeoff
					if(src.cooltimer>=round(src.maxcooltime/1.2))src.overlays+=/obj/JutsuOverlays/Cool4/
					if(src.cooltimer>round(src.maxcooltime/2)&&src.cooltimer<round(src.maxcooltime/1.2))src.overlays+=/obj/JutsuOverlays/Cool3/
					if(src.cooltimer<=round(src.maxcooltime/2)&&src.cooltimer>round(src.maxcooltime/6))src.overlays+=/obj/JutsuOverlays/Cool2/
					if(src.cooltimer<=round(src.maxcooltime/6))src.overlays+=/obj/JutsuOverlays/Cool1/
					if(src.cooltimer<=0)
						src.overlays=0
						O.client.screen-=src
						O.waitslot--
					//	for(var/obj/Jutsus/J in O.client.screen)
					//		if(J==src)
					//			O.client.screen-=J
					//			O.waitslot--
						src.Excluded=0
					continue
				else break
