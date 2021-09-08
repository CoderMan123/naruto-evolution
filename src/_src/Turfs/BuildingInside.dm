mob/var/tmp/lastloc
var/list/maps = list("Hidden Leaf"=list(),"Hidden Sand"=list(),"Hidden Mist"=list(),"Hidden Sound"=list(),"Hidden Rock"=list())
var/capmaps = list()
var/warmaps = list()
var/sandpoints = list("1"=0,"2"=0,"2"=0,"3"=0,"4"=0,"5"=0,"6"=0,"7"=0,"8"=0,"9"=0,"10"=0,"11"=0,"12"=0,"13"=0,"14"=0,"15"=0,"16"=0,"17"=0,"18"=0,"19"=0,"20"=0,"21"=0,"22"=0,"23"=0,"24"=0)
var/leafpoints = list("1"=0,"2"=0,"2"=0,"3"=0,"4"=0,"5"=0,"6"=0,"7"=0,"8"=0,"9"=0,"10"=0,"11"=0,"12"=0,"13"=0,"14"=0,"15"=0,"16"=0,"17"=0,"18"=0,"19"=0,"20"=0,"21"=0,"22"=0,"23"=0,"24"=0)
var/mistpoints = list("1"=0,"2"=0,"2"=0,"3"=0,"4"=0,"5"=0,"6"=0,"7"=0,"8"=0,"9"=0,"10"=0,"11"=0,"12"=0,"13"=0,"14"=0,"15"=0,"16"=0,"17"=0,"18"=0,"19"=0,"20"=0,"21"=0,"22"=0,"23"=0,"24"=0)
var/soundpoints = list("1"=0,"2"=0,"2"=0,"3"=0,"4"=0,"5"=0,"6"=0,"7"=0,"8"=0,"9"=0,"10"=0,"11"=0,"12"=0,"13"=0,"14"=0,"15"=0,"16"=0,"17"=0,"18"=0,"19"=0,"20"=0,"21"=0,"22"=0,"23"=0,"24"=0)
var/rockpoints = list("1"=0,"2"=0,"2"=0,"3"=0,"4"=0,"5"=0,"6"=0,"7"=0,"8"=0,"9"=0,"10"=0,"11"=0,"12"=0,"13"=0,"14"=0,"15"=0,"16"=0,"17"=0,"18"=0,"19"=0,"20"=0,"21"=0,"22"=0,"23"=0,"24"=0)

var
	list/SWarps = list()
	list/RWarps = list()

world
	proc
		LinkWarps() // Reformist's warp link optimization
			Link:
				for(var/turf/Warpz/Senders/S in SWarps)
					for(var/turf/Warpz/Receivers/R in RWarps)
						if(S.name == R.name)
							S.ToWhere = R
							R.ToWhere = S
							//RWarps -= R
							//SWarps -= S
							continue Link
				for(var/turf/Warpz/Receivers/R in RWarps)
					if(!R.ToWhere)
						for(var/turf/Warpz/Senders/S in SWarps)
							if(R.name == S.name)
								R.ToWhere = S
								break
			SWarps = null
			RWarps = null

	proc/Capdo(LevelTo,villagea)
		sleep(6000)
		if(LevelTo in global.capmaps)
			global.capmaps -= LevelTo
			if(villagea == "Hidden Sand")
				global.maps["Hidden Sand"]+=LevelTo
				world << output("<b>The Hidden Sand has captured an area!","Action.Output")
				for(var/mob/M in mobs_online)
					if(M.client && M.village == "Hidden Sand" && M.z == LevelTo)
						M.ryo += (100 + 1)
						M<<output("<b>You have gained [(100 + 1)] Ryo and 10 EXP from the capture!","Action.Output")
						M.exp+=10
						for(var/i=0,i<3,i++)
							var/GAIN = rand(1,3)
							switch(GAIN)
								if(1)
									M.LevelStat("Ninjutsu",0.2,1)

								if(2)
									M.LevelStat("strength",0.2,1)

								if(3)
									M.LevelStat("Genjutsu",0.2,1)

			if(villagea == "Hidden Leaf")
				global.maps["Hidden Leaf"]+=LevelTo
				world << output("<b>The Hidden Leaf has captured an area!","Action.Output")
				for(var/mob/M in mobs_online)
					if(M.client && M.village == "Hidden Leaf" && M.z == LevelTo)
						M.ryo += (100 + 1)
						M<<output("<b>You have gained [(100 + 1)] Ryo and 10 EXP from the capture!","Action.Output")
						M.exp+=10
						for(var/i=0,i<3,i++)
							var/GAIN = rand(1,3)
							switch(GAIN)
								if(1)
									M.LevelStat("Ninjutsu",0.2,1)

								if(2)
									M.LevelStat("strength",0.2,1)

								if(3)
									M.LevelStat("Genjutsu",0.2,1)

			if(villagea == "Hidden Mist")
				global.maps["Hidden Mist"]+=LevelTo
				world << output("<b>The Hidden Mist has captured an area!","Action.Output")
				for(var/mob/M in mobs_online)
					if(M.client && M.village == "Hidden Mist" && M.z == LevelTo)
						M.ryo += (100 + 1)
						M<<output("<b>You have gained [(100 + 1)] Ryo and 10 EXP from the capture!","Action.Output")
						M.exp+=10
						for(var/i=0,i<3,i++)
							var/GAIN = rand(1,3)
							switch(GAIN)
								if(1)
									M.LevelStat("Ninjutsu",0.2,1)

								if(2)
									M.LevelStat("strength",0.2,1)

								if(3)
									M.LevelStat("Genjutsu",0.2,1)

			if(villagea == "Hidden Sound")
				global.maps["Hidden Sound"]+=LevelTo
				world << output("<b>The Hidden Sound has captured an area!","Action.Output")
				for(var/mob/M in mobs_online)
					if(M.client && M.village == "Hidden Sound" && M.z == LevelTo)
						M.ryo += (100 + 1)
						M<<output("<b>You have gained [(100 + 1)] Ryo and 10 EXP from the capture!","Action.Output")
						M.exp+=10
						for(var/i=0,i<3,i++)
							var/GAIN = rand(1,3)
							switch(GAIN)
								if(1)
									M.LevelStat("Ninjutsu",0.2,1)

								if(2)
									M.LevelStat("strength",0.2,1)

								if(3)
									M.LevelStat("Genjutsu",0.2,1)

			if(villagea == "Hidden Rock")
				global.maps["Hidden Rock"]+=LevelTo
				world << output("<b>The Hidden Rock has captured an area!","Action.Output")
				for(var/mob/M in mobs_online)
					if(M.client && M.village == "Hidden Rock" && M.z == LevelTo)
						M.ryo += (100 + 1)
						M<<output("<b>You have gained [(100 + 1)] Ryo and 10 EXP from the capture!","Action.Output")
						M.exp+=10
						for(var/i=0,i<3,i++)
							var/GAIN = rand(1,3)
							switch(GAIN)
								if(1)
									M.LevelStat("Ninjutsu",0.2,1)

								if(2)
									M.LevelStat("strength",0.2,1)

								if(3)
									M.LevelStat("Genjutsu",0.2,1)

	proc/Wardo(LevelTo)
		sleep(6000)
		if(LevelTo in global.warmaps)
			global.warmaps -= LevelTo
			world << output("<center><font size=2><b>After-battle report:<br><br>Leaf points: [global.leafpoints["[LevelTo]"]]<br>Sand points: [global.sandpoints["[LevelTo]"]]","Action.Output")
			if(global.sandpoints["[LevelTo]"] >= global.leafpoints["[LevelTo]"])
				global.maps["Hidden Sand"]+=LevelTo
				world << output("<b>The Hidden Sand has won the battle!","Action.Output")
				global.sandpoints["[LevelTo]"]=0
				global.leafpoints["[LevelTo]"]=0
				for(var/mob/M in mobs_online)
					if(M.client && M.village == "Hidden Sand" && M.z == LevelTo)
						M.ryo += (100 + 1)
						M<<output("<b>You have gained [(100 + 1)] Ryo and 6 EXP from the battle!","Action.Output")
						M.exp+=6
						for(var/i=0,i<5,i++)
							var/GAIN = rand(1,3)
							switch(GAIN)
								if(1)
									M.LevelStat("Ninjutsu",0.2,1)

								if(2)
									M.LevelStat("strength",0.2,1)

								if(3)
									M.LevelStat("Genjutsu",0.2,1)

			if(global.leafpoints["[LevelTo]"] >= global.sandpoints["[LevelTo]"])
				global.maps["Hidden Leaf"]+=LevelTo
				world << output("<b>The Hidden Leaf has won the battle!","Action.Output")
				global.sandpoints["[LevelTo]"]=0
				global.leafpoints["[LevelTo]"]=0
				for(var/mob/M in mobs_online)
					if(M.client && M.village == "Hidden Leaf" && M.z == LevelTo)
						M.ryo += (100 + 1)
						M<<output("<b>You have gained [(100 + 1)] Ryo and 6 EXP from the battle!","Action.Output")
						M.exp+=6
						for(var/i=0,i<5,i++)
							var/GAIN = rand(1,3)
							switch(GAIN)
								if(1)
									M.LevelStat("Ninjutsu",0.2,1)

								if(2)
									M.LevelStat("strength",0.2,1)

								if(3)
									M.LevelStat("Genjutsu",0.2,1)
									
turf
	MapWarps
		var/LevelTo
		Entered(mob/M)
			if(istype(M,/mob) && !istype(M, /mob/npc))
				if(CheckState(M, new/state/in_combat))
					M<<"You were recently in combat. Please wait to do this."
					return
			if(istype(M,/mob) && M.client)
				var/counts=0
				var/check=0
				if(M.z == 2 || M.z == 3 || M.z == 4 || M.z == 13 || M.z == 14)
					check=1
				else
					if(M.village == "Hidden Leaf" || M.village == "Hidden Sand")
						if(M.z in global.warmaps)
							check=0
							M << output("Nice try! You're not leaving this area while it's undergoing battle.","Action.Output")
						else
							if(LevelTo in global.maps["[M.village]"])
								check=1
							else
								if(LevelTo in global.warmaps)
									check=1
								else
									for(var/mob/M2 in mobs_online)
										if(M2.client && M2.village == M.village && M2.z == LevelTo)
											counts++
									if(counts >= 5)
										counts=0
										for(var/mob/M2 in mobs_online)
											if(M2.client && M2.village <> M.village && M2.z == LevelTo)
												counts++
										if(counts>=5)
											world << output("<b><font size=2>[M.village]'s capture has led to battle!","Action.Output")
											global.sandpoints["[LevelTo]"]=0
											global.leafpoints["[LevelTo]"]=0
											if(LevelTo in global.maps["Hidden Leaf"])
												global.maps["Hidden Leaf"]-=LevelTo
											if(LevelTo in global.maps["Hidden Sand"])
												global.maps["Hidden Sand"]-=LevelTo
											if(LevelTo in global.capmaps)
												global.capmaps-=LevelTo
											global.warmaps += LevelTo
											world.Wardo(LevelTo)
										else
											if(LevelTo in global.capmaps)
												check=1
											else
												world << output("<b><font size=2>[M.village] is capturing an area!","Action.Output")
												if(LevelTo in global.maps["Hidden Leaf"])
													global.maps["Hidden Leaf"]-=LevelTo
												if(LevelTo in global.maps["Hidden Sand"])
													global.maps["Hidden Sand"]-=LevelTo
												global.capmaps+=LevelTo
												world.Capdo(LevelTo,M.village)

									check=1
					else
						check=1
				if(check)
					/*if(M.x==world.maxx&&dir==SOUTH)
						M.x=1
						M.z=LevelTo
						counts++*/
					if(M.x==1&&M.dir==WEST)
						M.x=world.maxx
						M.z=LevelTo
						counts++
					if(M.x==world.maxx&&M.dir==EAST)
						M.x=1
						M.z=LevelTo
						counts++
					/*if(M.x==world.maxx&&M.dir==NORTH)
						M.x=1
						M.z=LevelTo
						counts++*/
					if(M.y==1&&M.dir==SOUTH)
						M.y=world.maxy
						M.z=LevelTo
						counts++
					if(M.y==1&&M.dir==NORTH)
						M.y=1
						M.z=LevelTo
						counts++
					if(M.y==world.maxy&&M.dir==SOUTH)
						M.y=world.maxy
						M.z=LevelTo
						counts++
					if(M.y==world.maxy&&M.dir==NORTH)
						M.y=1
						M.z=LevelTo
						counts++
					var/Owned=0
					var/list/LeafList=maps["Hidden Leaf"]
					var/list/SandList=maps["Hidden Sand"]
					if(LeafList.Find(LevelTo))
						M<<"This area is under control by the Hidden Leaf."
						Owned=1
					if(SandList.Find(LevelTo))
						M<<"This area is under control by the Hidden Sand."
						Owned=1
					if(!Owned)M<<"This area is not under control by any village."
	Warpz
		Special
			WarpToMapLoadSpawn
				Entered(mob/M)
					if(istype(M,/mob) && M.client)
						if(M.Tutorial!=6)//TUT
							M<<output("Hey, hold your horses! You haven't finished the tutorial yet. Make sure you go back and speak with the NPCs in order starting from the room you arrived in!","Action.Output")
							if(M.lastloc)M.loc=M.lastloc
							return
						else
							M.Tutorial=7
							M<<output("Congratulations! You've finished the tutorial! Make sure to ask other players if you need help either in your village chat or on the discord! Look out for the bells icon next to someone name when they speak in chat, that means they're a Jounin and happy to help!","Action.Output")
						M.loc=M.MapLoadSpawn()
		layer=TURF_LAYER+1
		Senders
			var/turf/Warpz/Receivers/ToWhere
			New()
				..()
				SWarps += src
				//for(var/turf/Warpz/Receivers/T in world)if(T.name == src.name) ToWhere=T
		//	icon='uparrow.dmi'
			Entered(mob/M)
				if(istype(M,/mob) && M.client && ToWhere)
					if(CheckState(M, new/state/in_combat))
						M<<"You were recently in combat. Please wait to do this."
						if(M.lastloc) M.loc=M.lastloc
						return
					if(M.inboulder)
						M<<"You can't enter buildings like that. Come back when you're not a boulder."
						if(M.lastloc) M.loc=M.lastloc
						return
					if(M.Intang)
						M<<"You can't enter buildings while intangible. Come back when you're tangible."
						if(M.lastloc) M.loc = M.lastloc
						return
					if(M.Susanoo)
						M<<"You can't enter buildings with Susanoo. Come back without Susanoo."
						if(M.lastloc) M.loc=M.lastloc
						return
					usr.loc = ToWhere
					step(usr,NORTH)
				else if(istype(M,/mob/npc/combat/political_escort))
					M.loc = ToWhere
			//Leaf
			T1	//KH
			T2	//Dojo
			T3	//Hospital
			T4	//Genin
			T5	//Chuunin
			T6	//Barber
			T7	//Clothes
			T8	//Weapons
			T9	//Arena
			T10	//DojoR1
			T11	//DojoR2
			T12	//DojoR3
			T13	//DojoR4
			//Sand
			T14	//KH
			T15	//Dojo
			T16	//Hospital
			T17	//Genin
			T18	//Chuunin
			T19	//DojoR1
			T20	//DojoR2
			T21	//DojoR3
			T22	//DojoR4
			//Mist
			T23	//KH
			T24	//Dojo
			T25	//Hospital
			T26	//Genin
			T27	//Chuunin
			T28	//Barber
			T29	//Weapons
			T30	//DojoR1
			T31	//DojoR2
			//Misc
			T32	//Cave(Rock)
			//Anbu Root
			T33	//Entrance
				Entered(mob/M)
					if(M.village != "Anbu Root")
						return
					else
						..()
			T34	//Secretary
			T35	//Spawn
			T36	//Vends
			T37	//Dojo1
			T38	//Dojo2
			//Seven Swordsmen
			T39	//Entrance
				Entered(mob/M)
					if(M.village !="Seven Swordsmen")
						return
					else
						..()
			//Sound
			T40	//Hospital
			T41 //Dojo
			T42 //Weapon
			T43 //Genin
			T44 //Chuunin
			T45 //DojoR1
			T46 //DojoR2
			//Rock
			T47 //KH
			T48 //Genin
			T49 //Chuunin
			T50 //All shops
			T51 //Hospital

			//Tutorial
			T52 //KH


			T100//Akat
				Entered(mob/M)
					if(M.village != "Akatsuki")
						return
					else
						..()

		Receivers
		//	icon = 'downarrow.dmi'
			var/turf/Warpz/Receivers/ToWhere
			New()
				..()
				RWarps += src
				//for(var/turf/Warpz/Senders/T in world)
				//	if(T.name == src.name) ToWhere=T
			Entered(mob/M)
				if(istype(M,/mob) && M.client && ToWhere)
					if(CheckState(M, new/state/in_combat))
						M<<"You were recently in combat. Please wait to do this."
						if(M.lastloc) M.loc=M.lastloc
						return
					if(M.inboulder)
						M<<"You can't enter here like that. Come back when you're not a boulder."
						if(M.lastloc) M.loc=M.lastloc
						return
					if(M.Intang)
						M<<"You can't enter here while intangible. Come back when you're tangible."
						if(M.lastloc) M.loc = M.lastloc
						return
					if(M.Susanoo)
						M<<"You can't enter here with Susanoo. Come back without Susanoo."
						if(M.lastloc) M.loc=M.lastloc
						return
					usr.loc = ToWhere
					step(usr,SOUTH)
				else if(istype(M,/mob/npc/combat/political_escort))
					M.loc = ToWhere
			//Leaf
			T1	//KH
			T2	//Dojo
			T3	//Hospital
			T4	//Genin
			T5	//Chuunin
			T6	//Barber
			T7	//Clothes
			T8	//Weapons
			T9	//Arena
			T10	//DojoR1
			T11	//DojoR2
			T12	//DojoR3
			T13	//DojoR4
			//Sand
			T14	//KH
			T15	//Dojo
			T16	//Hospital
			T17	//Genin
			T18	//Chuunin
			T19	//DojoR1
			T20	//DojoR2
			T21	//DojoR3
			T22	//DojoR4
			//Mist
			T23	//KH
			T24	//Dojo
			T25	//Hospital
			T26	//Genin
			T27	//Chuunin
			T28	//Barber
			T29	//Weapons
			T30	//DojoR1
			T31	//DojoR2
			//Misc
			T32	//Cave(Rock)

			//Anbu Root
			T33	//Entrance
			T34	//Secretary
			T35	//Spawn
			T36	//Vends
			T37	//Dojo1
			T38	//Dojo2
			//Seven Swordsmen
			T39	//Entrance
			//Sound
			T40	//Hospital
			T41 //Dojo
			T42 //Weapon
			T43 //Genin
			T44 //Chuunin
			T45 //DojoR1
			T46 //DojoR2
			//Rock
			T47 //KH
			T48 //Genin
			T49 //Chuunin
			T50 //All shops
			T51 //Hospital
			//Tutorial
			T52 //KH

			T100//Akat
	Outsides
		Fence
			icon='Fence.dmi'
			density=1
			bottom1
				icon_state="bottom1"
			bottom2
				icon_state="bottom2"
			top1
				icon_state="top1"
				layer=MOB_LAYER+1
				density=0
			top2
				icon_state="top2"
				layer=MOB_LAYER+1
				density=0
			side1
				icon_state="side1"
				layer=MOB_LAYER+1
			side2
				icon_state="side2"
				layer=MOB_LAYER+1
			side3
				icon_state="side3"
				layer=MOB_LAYER+1
			side4
				icon_state="side4"
				layer=MOB_LAYER+1
			endline1
				icon_state="endline1"
				layer=MOB_LAYER
			endline2
				icon_state="endline2"
				layer=MOB_LAYER
			endline3
				icon_state="endline3"
				layer=MOB_LAYER
			endline4
				icon_state="endline4"
				layer=MOB_LAYER
	BuildingInsides
		icon='building insides.dmi'
		door
			doortop
				icon_state = "doortop"
			doorbottom
				icon_state = "doorbottom"
		Wall
			density=1
			name="Wall"
			Wall
				icon_state="wallbottom"
			Walltop
				icon_state="walltop"
			Walltop1
				icon_state="walltop1"
			Walltop2
				icon_state="walltop2"
			Wallbottom1
				icon_state="wallbottom1"
			Wallbottom2
				icon_state="wallbottom2"
		WallSides
			density=1
			name="Wall"
			WallSide1
				icon_state="wallside1"
			TopCorner1
				icon_state="topcorner1"
			WallBorderTop
				icon_state="wallbordertop"
			Wall2BorderTop
				icon_state="wallbordertop2"
			TopCorner2
				icon_state="topcorner2"
			TopCorner3
				icon_state="topcorner3"
			TopCorner4
				icon_state="topcorner4"
			WallSide2
				icon_state="wallside2"
			SideBottom1
				icon_state="sidebottom1"
			SideBottom2
				icon_state="sidebottom2"
			Top2Corner1
				icon_state="2topcorner1"
			Top2Corner2
				icon_state="2topcorner2"
			Top2Corner3
				icon_state="2topcorner3"
			Top2Corner4
				icon_state="2topcorner4"
		Floors
			name="Floor"
			Floor
				icon_state="floor"
			Floor2
				icon_state="floor2"
			ChuuninTile
				icon='GRND.dmi'
				icon_state="Chewnin exam tile"
		Desk
			layer=MOB_LAYER-1
			density=1
			Desk1
				icon_state="desk1"
			Desk2
				icon_state="desk2"
			Desk3
				icon_state="desk3"
			Ddesk
				icon_state="Ddesk"
			Cdesk
				icon_state="Cdesk"
			BigBook
				icon_state="BigBook"
			Books
				icon_state="Books"
			Book
				icon_state="Book"
		Doors
			Doortop
				icon_state="doortop"
			Doorbottom
				icon_state="doorbottom"
		Bed
			icon='HouseObjs.dmi'
			Bottom
				icon_state="Bed1B"
			Top
				icon_state="Bed1T"
				density=1
			Sheet
				icon_state="Bed1Sheet"
				layer=MOB_LAYER+5
