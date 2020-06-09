//Clones and various effects and other bs for gen moves

atom/var/Hengable=0 // Don't change this.
//mob/var/multishadow=0
mob/var/tmp
	Prisoned=0
	mizubunshin
	gatsuga=0
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
			if(istype(src,/mob/Untargettable/C2))
				return
			if(istype(src,/mob/Untargettable/Susanoo))
				return
			if(istype(src,/mob/Karasu))
				return
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
					view(usr)<<sound('flashbang_explode1.wav',0,0)
					var/obj/A = new/obj/MiscEffects/Smoke(usr.loc)
					A.loc=usr.loc
					//var/srcname=src.name
					usr.icon=src.icon
					usr.icon_state=src.icon_state
					usr.overlays=0
					usr.overlays=src.overlays
					usr.underlays=src.underlays
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
			view(usr)<<sound('flashbang_explode1.wav',0,0)
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
			view(usr)<<sound('flashbang_explode1.wav',0,0)
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
		New()
			spawn()
				src.Owner:Clones.Add(src)
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
					for(var/mob/player/M in TotalPlayers) if(Prisoner==M)
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
				/*	for(var/mob/c_target in get_step(src,src.dir))
						if(istype(c_target,/mob/NPCs/Shinobi/)) return*/
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
												var/undefendedhit=round(src.strength-c_target.defence/4)
												if(undefendedhit<0)
													undefendedhit=0
												c_target.DealDamage(undefendedhit,src,"TaiOrange")
												if(c_target.loc.loc:Safe!=1) c_target.LevelStat("Defence",rand(1,2))
												if(src.Hand=="Left")
													view(src,10) << sound('Sounds/LPunchHIt.ogg',0,0,0,100)
												if(src.Hand=="Right")
													view(src,10) << sound('Sounds/HandDam_Normal2.ogg',0,0,0,100)
											else
												if(src.agility>=c_target.agility)
													var/defendedhit=src.strength-c_target.defence
													if(defendedhit<0)
														defendedhit=0
												//	if(Owner.loc.loc:Safe!=1) Owner.strength++
													Owner.Levelup()
													if(c_target.loc.loc:Safe!=1) c_target.LevelStat("Defence",rand(3,5))
													if(defence<src.strength/3)
														var/obj/Drag=new /obj/Drag/Dirt(c_target.loc)
														Drag.dir=c_target.dir
														step(c_target,src.dir)
														c_target.dir = get_dir(c_target,src)
														step_to(src,c_target,1)
													c_target.DealDamage(defendedhit,src,"TaiOrange")
													flick("defendhit",c_target)
													view(src,10) << sound('Sounds/Counter_Success.ogg',0,0,0,100)
												else
													flick("dodge",c_target)
													if(c_target.loc.loc:Safe!=1) c_target.LevelStat("Agility",rand(2,5))
					else
						if(src.agility>=50)
							for(var/mob/c_target in get_step(src,src.dir))
								src.dir = get_dir(src,c_target)
								if(c_target in get_step(src,src.dir))
									if(c_target.dead==0&&c_target!=Owner)
										if(c_target.fightlayer==src.fightlayer)
											if(c_target.dodge==0)
												var/undefendedhit=round(src.strength-c_target.defence/4)
												if(undefendedhit<0)undefendedhit=0
												c_target.DealDamage(undefendedhit,src,"TaiOrange")
											//	if(Owner.loc.loc:Safe!=1) Owner.LevelStat("Strength",1)
												if(c_target.loc.loc:Safe!=1) c_target.LevelStat("Defence",rand(1,2))
												if(src.Hand=="Left")view(src,10) << sound('Sounds/LPunchHIt.ogg',0,0,0,100)
												if(src.Hand=="Right")view(src,10) << sound('Sounds/HandDam_Normal2.ogg',0,0,0,100)
											else
												if(src.agility>=c_target.agility)
													var/defendedhit=src.strength-c_target.defence
													if(defendedhit<0)
														defendedhit=0
													if(c_target.loc.loc:Safe!=1) c_target.LevelStat("Defence",rand(3,5))
													if(defence<src.strength/3)
														var/obj/Drag=new /obj/Drag/Dirt(c_target.loc)
														Drag.dir=c_target.dir
														step(c_target,src.dir)
														c_target.dir = get_dir(c_target,src)
														step_to(src,c_target,1)
													c_target.DealDamage(defendedhit,src,"TaiOrange")
													flick("defendhit",c_target)
													view(src,10) << sound('Sounds/Counter_Success.ogg',0,0,0,100)
												else
													flick("dodge",c_target)
													if(c_target.loc.loc:Safe!=1) c_target.LevelStat("Agility",rand(2,5))
					spawn(12)if(src)src.canattack=1
		MizuBunshin
			//health=1
			//maxhealth=1
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
				ResetBase()
				//icon = 'WhiteMBase.dmi'
				icon_state = ""
			Del()
				if(Prisoner)
					for(var/mob/player/M in TotalPlayers) if(Prisoner==M)
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
							ResetBase()
							//icon='WhiteMBase.dmi'
			Bump(atom/O)
				/*if(istype(O,/mob))
					var/mob/M=O
					if(M.fightlayer==src.fightlayer && !M.Owner)
						src.health=0
						src.Death(M)
					else src.loc=M.loc*/
				if(istype(O,/obj))
					var/obj/OO=O
					if(!OO.Owner) return
					src.health=0
					src.Death(OO.Owner)
				/*if(istype(O,/turf))
					src.health=0
					src.Death(src)*/
			proc/Imprison()
				while(src)
					sleep(4)
					if(!move) continue
					if(src.takeova) continue
					if(TrapTimes<=0)
						src.health=0
						Death(src)
					for(var/mob/player/X in oview(src))
						if(X <> Owner)
							if(X&&istype(X)&&!X.dead&&X.move)
								while(get_dist(X,src)>1)
									sleep(2)
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
										var/obj/Jutsu/Effects/WaterPrison/W=new
										W.layer=M.layer+2
										W.pixel_x-=45
										W.loc=M.loc
										icon_state="punchrS"
										PrisonOb=W
										Prisoner=M
										while(Timer&&M.loc==W.loc&&M)
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
					//src.canattack=0
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
												var/undefendedhit=round(src.strength-c_target.defence/4)
												if(undefendedhit<0)undefendedhit=0
												c_target.DealDamage(undefendedhit,src,"TaiOrange")
												if(c_target.loc.loc:Safe!=1) c_target.LevelStat("Defence",rand(1,2))
												if(src.Hand=="Left")view(src,10) << sound('Sounds/LPunchHIt.ogg',0,0,0,100)
												if(src.Hand=="Right")view(src,10) << sound('Sounds/HandDam_Normal2.ogg',0,0,0,100)
											else
												if(src.agility>=c_target.agility)
													var/defendedhit=src.strength-c_target.defence
													if(defendedhit<0)defendedhit=0
													//if(Owner.loc.loc:Safe!=1) Owner.strength++
													Owner.Levelup()
													if(c_target.loc.loc:Safe!=1) c_target.LevelStat("Defence",rand(3,5))
													if(defence<src.strength/3)
														var/obj/Drag=new /obj/Drag/Dirt(c_target.loc)
														Drag.dir=c_target.dir
														step(c_target,src.dir)
														c_target.dir = get_dir(c_target,src)
														step_to(src,c_target,1)
													c_target.DealDamage(defendedhit,src,"TaiOrange")
													flick("defendhit",c_target)
													view(src,10) << sound('Sounds/Counter_Success.ogg',0,0,0,100)
												else
													flick("dodge",c_target)
													if(c_target.loc.loc:Safe!=1) c_target.LevelStat("Agility",rand(2,5))
					else
						if(src.agility>=50)
							for(var/mob/c_target in get_step(src,src.dir))
								src.dir = get_dir(src,c_target)
								if(c_target in get_step(src,src.dir))
									if(c_target.dead==0&&c_target!=Owner)
										if(c_target.fightlayer==src.fightlayer)
											if(c_target.dodge==0)
												var/undefendedhit=round(src.strength-c_target.defence/4)
												if(undefendedhit<0)undefendedhit=0
												c_target.DealDamage(undefendedhit,src,"TaiOrange")
												if(c_target.loc.loc:Safe!=1) c_target.LevelStat("Defence",rand(1,2))
												if(src.Hand=="Left")view(src,10) << sound('Sounds/LPunchHIt.ogg',0,0,0,100)
												if(src.Hand=="Right")view(src,10) << sound('Sounds/HandDam_Normal2.ogg',0,0,0,100)
											else
												if(src.agility>=c_target.agility)
													var/defendedhit=src.strength-c_target.defence
													if(defendedhit<0)defendedhit=0
													if(c_target.loc.loc:Safe!=1) c_target.LevelStat("Defence",rand(3,5))
													if(defence<src.strength/3)
														var/obj/Drag=new /obj/Drag/Dirt(c_target.loc)
														Drag.dir=c_target.dir
														step(c_target,src.dir)
														c_target.dir = get_dir(c_target,src)
														step_to(src,c_target,1)
													c_target.DealDamage(defendedhit,src,"TaiOrange")
													flick("defendhit",c_target)
													view(src,10) << sound('Sounds/Counter_Success.ogg',0,0,0,100)
												else
													flick("dodge",c_target)
													if(c_target.loc.loc:Safe!=1) c_target.LevelStat("Agility",rand(2,5))
					sleep(10)
					//spawn(12)if(src)src.canattack=1
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



obj/Jutsus/Effects/
	TempleNirvana
		icon='Temple of Nirvana.dmi'
		pixel_x=-32
		New()
			..()
			spawn(12)if(src)del(src)
	limbparalyze
		icon='LimbParalyzeSeal.dmi'
		pixel_x=-16
		New()
			..()
			spawn(12)if(src)del(src)
	rustle
		icon='Snake Rustle Jutsu.dmi'
		pixel_x=-16
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
obj/TsukuyomiHUD
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

turf
	Tsukuyomi
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
	Tsukuyomi
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
	Jukai
		name="Mokuton Hijutsu - Jukai Koutan"
		icon='WoodCageStyle.dmi'
		icon_state="stay"
		New()
			..()
			spawn(100)if(src)del(src)
	suijinheki
		name="Suiton Suijinheki"
		icon='suiton.dmi'
		icon_state="1"
		density=1
		New()
			..()
			overlays+=/obj/suijinheki2
			overlays+=/obj/suijinheki3
			overlays+=/obj/suijinheki4
			overlays+=/obj/suijinheki5
			overlays+=/obj/suijinheki6
			spawn(50)if(src)del(src)
	daijurin
		name="Mokuton - Daijurin no Jutsu"
		icon='WoodDril.dmi'
		icon_state="punchrS"
		pixel_x=-55
		density=1
		Move()
			var/mob/O = Owner
			var/obj/A = new/obj/daijurin(src.loc)
			A.icon_state="tail"
			A.IsJutsuEffect=O
			A.Owner=O
			A.layer=src.layer
			A.fightlayer=src.fightlayer
			A.damage=src.damage
			A.level=src.level
			A.dir=dir
			if(A.dir==WEST||A.dir==EAST)A.pixel_y=-52
			..()
		New()
			..()
			spawn(50)if(src)del(src)
		Del()
			var/mob/O = Owner
			O.icon_state=""
			..()
		Bump(atom/O)
			if(!src.Hit)
				if(istype(O,/mob))
					var/mob/M=O
					if(M)
						var/mob/Owner=src.Owner
						if(M.dead || M.swimming) return
						if(M.fightlayer==src.fightlayer)
							src.layer=MOB_LAYER+1
							if(M)
								src.loc = M.loc
								if(!Owner) return
								M.DealDamage((12+src.damage+Owner.ninjutsu)*8,src.Owner,"NinBlue")
								spawn() if(M) M.Bleed()
								if(Owner.loc.loc:Safe!=1) Owner.LevelStat("Ninjutsu",rand(3,4))
								if(M.henge==4||M.henge==5)M.HengeUndo()
	suijinheki2
		name="Suiton Suijinheki"
		icon='suiton.dmi'
		icon_state="2"
		density=1
		pixel_x=32
	suijinheki3
		name="Suiton Suijinheki"
		icon='suiton.dmi'
		icon_state="top1"
		density=1
		pixel_y=32
	suijinheki4
		name="Suiton Suijinheki"
		icon='suiton.dmi'
		icon_state="top2"
		density=1
		pixel_x=32
		pixel_y=32
	suijinheki5
		name="Suiton Suijinheki"
		icon='suiton.dmi'
		icon_state="top-1"
		density=1
		pixel_y=58
	suijinheki6
		name="Suiton Suijinheki"
		icon='suiton.dmi'
		icon_state="top-2"
		density=1
		pixel_y=58
		pixel_x=32
	Teppoudama
		name="Suiton Teppoudama"
		icon='suiton.dmi'
		icon_state="waterball"
		density=1
		New()
			..()
			spawn(50)if(src)del(src)
		Bump(atom/O)
			if(!src.Hit)
				if(istype(O,/mob))
					var/mob/M=O
					if(M)
						var/mob/Owner=src.Owner
						if(M.dead || M.swimming) return
						if(M.fightlayer==src.fightlayer)
							src.layer=MOB_LAYER+1
							if(M)
								src.loc = M.loc
								if(!Owner) return
								M.DealDamage(12+src.damage+Owner.ninjutsu*6.5,src.Owner,"NinBlue")
								spawn() if(M) M.Bleed()
								if(Owner.loc.loc:Safe!=1) Owner.LevelStat("Ninjutsu",rand(3,5))
								if(M.henge==4||M.henge==5)M.HengeUndo()
	Getsuga
		name="Getsuga Tenshou"
		icon='Getsuga.dmi'
		icon_state="tenshou"
		density=1
		New()
			..()
			spawn(50)if(src)del(src)
		Bump(atom/O)
			if(!src.Hit)
				if(istype(O,/mob))
					var/mob/M=O
					if(M)
						view()<<sound('GetsugaTenshou.wav')
						var/mob/Owner=src.Owner
						if(M.dead || M.swimming) return
						if(M.fightlayer==src.fightlayer)
							src.layer=MOB_LAYER+1
							if(M)
								view()<<sound('GetsugaTenshou.wav')
								src.loc = M.loc
								if(!Owner) return
								M.DealDamage(12+src.damage+Owner.ninjutsu*6.5,src.Owner,"NinBlue")
								spawn() if(M) M.Bleed()
								if(Owner.loc.loc:Safe!=1) Owner.LevelStat("Ninjutsu",rand(3,5))
								if(M.henge==4||M.henge==5)M.HengeUndo()

	Zankuuha
		name="Zankuuha"
		icon='MeteorPunch.dmi'
		icon_state="max"
		pixel_x=-32
		density=1
		New()
			..()
			spawn(50)if(src)del(src)
		Move()
			..()
			var/obj/Zankuuha/A = new/obj/Zankuuha(src.loc)
			A.IsJutsuEffect=src
			A.Owner=src
			A.layer=src.layer
			A.fightlayer=src.fightlayer
			A.damage=damage
			A.level=level
		Bump(atom/O)
			if(!src.Hit)
				if(istype(O,/mob))
					var/mob/M=O
					if(M)
						var/mob/Owner=src.Owner
						if(M.dead || M.swimming) return
						if(M.fightlayer==src.fightlayer)
							src.layer=MOB_LAYER+1
							if(M)
								src.loc = M.loc
								if(!Owner) return
								M.DealDamage(12+src.damage+Owner.strength/5,src.Owner,"TaiOrange")
								spawn() if(M) M.Bleed()
								if(Owner.loc.loc:Safe!=1) Owner.LevelStat("Taijutsu",rand(3,5))
								if(M.henge==4||M.henge==5)M.HengeUndo()
	Dango
		Bump(atom/O)
			if(!src.Hit)
				if(istype(O,/mob))
					var/mob/M=O
					if(M)
						var/mob/Owner=src.Owner
						if(M.dead || M.swimming) return
						if(M.fightlayer==src.fightlayer)
							src.layer=MOB_LAYER+1
							if(M)
								src.loc = M.loc
								if(!Owner) return
								M.DealDamage(2+Owner.strength*4,src.Owner,"TaiOrange")
								spawn() if(M) M.Bleed()
								if(Owner.loc.loc:Safe!=1) Owner.LevelStat("Taijutsu",rand(3,5))
								if(M.henge==4||M.henge==5)M.HengeUndo()
		p1
			name="Doton Doryo Dango"
			icon='dango.dmi'
			icon_state="6"
			density=1
			New()
				..()
				overlays+=/obj/Dango/p2
				overlays+=/obj/Dango/p3
				overlays+=/obj/Dango/p4
				overlays+=/obj/Dango/p5
				overlays+=/obj/Dango/p6
				spawn(50)if(src)del(src)
		p2
			name="Doton Doryo Dango"
			icon='dango.dmi'
			icon_state="5"
			density=1
			pixel_y=32
		p3
			name="Doton Doryo Dango"
			icon='dango.dmi'
			icon_state="4"
			density=1
			pixel_x=32
		p4
			name="Doton Doryo Dango"
			icon='dango.dmi'
			icon_state="3"
			density=1
			pixel_y=32
			pixel_x=32
		p5
			name="Doton Doryo Dango"
			icon='dango.dmi'
			icon_state="2"
			density=1
			pixel_x=-32
		p6
			name="Doton Doryo Dango"
			icon='dango.dmi'
			icon_state="1"
			density=1
			pixel_y=32
			pixel_x=-32