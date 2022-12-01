//This is where handsigns are defined and procs to use the jutsu if it's uses are met are set.
turf
	chuuninhands
		icon = 'Chuuninhands.png'
mob
	var
		list2
		crecord
		katon=2
	//	UchihaJ=0
		tmp
			copy
			first
			second
			third
			fourth
			fifth
			sixth
			seventh
			eighth
			nineth
			tenth
			eleventh
			twelveth
			rabbit=0
			rat=0
			dog=0
			horse=0
			dragon=0
			monkey=0
			ox=0
			snake=0
			HandSeals
			SealCount
			HandSigning
			Spaced
			SealCounting = 0
obj
	var
		signs
		rank
		uses=0
		IsGate = 0
//mob
//	proc
//		Quake_Effect(mob/M,duration,strength=1)
//			if(!M.client)return
//			spawn(1)
//				var/oldeye=M.client.eye
//				var/x
//				for(x=0;x<duration,x++)
//					M.client.eye = get_steps(M,pick(NORTH,SOUTH,EAST,WEST),strength)
//					sleep(1)
//				M.client.eye=oldeye
//Rat,Ox,Dog,Dragon,Snake,Horse,Rabbit,Monkey
mob/var/list/sbought = list()
obj
	var/Sprice=1
	var/starterjutsu=0
	var/sharin=0
	Jutsus
		var/tmp/ChakraCost
		var/Clan
		var/Element
		var/Element2
		var/Kekkai
		var/Specialist
		var/list/reqs = list()
		//var/Damage this might be needed who knows.
		icon='Misc Effects.dmi'
		layer=10
		New()
			if(src.z==4)invisibility=1
		Click()
			if(usr.Tutorial==3&&src.type!=/obj/Jutsus/BodyReplace)
				usr<<"You shouldn't buy this, you need the Substitution Technique found under Non Clan Skills."
				return
			if(src.type in usr.jutsus_learned)
				var/remaining_uses = ((80-round(src.maxcooltime/15))/handsealmastery) - src.uses
				if(remaining_uses > 0)
					if(!IsGate)
						usr << output("<Font color=red>You need to use [src.name] [remaining_uses] more times (You've used it [src.uses] times already).</Font>","Action.Output")
					else
						usr << output("You may not put this technique on a hotslot.","Action.Output")
				else
					usr << output("You have mastered this jutsu! You can now hold left click and drag it to your hotbar to use it without handseals. ","Action.Output")
			else
				if(src.name in usr.sbought)return

			/*	if(usr.UchihaJ>=3)
					usr<<" You can not learn any more clan jutsu."
					return */
				var/has_reqs = 0
				var/check=0
				var/Element1
				var/Element2z
				var/KekkaiC
				var/SpecialistZ
				for(var/X in src.reqs)
					for(var/O in usr.sbought)
						if(O == X)check+=1
				if(check == length(src.reqs))has_reqs=1
				else has_reqs=0
				if(Clan)
					if(Clan != usr.Clan && Clan != usr.Clan2)
						usr<<output("You are not the appropriate clan to learn this technique. ([Clan]).","Action.Output")
						return
				if(src.Element) if(src.Element != usr.Element && src.Element != usr.Element2 && src.Element != usr.Element3 && src.Element != usr.Element4 && src.Element != usr.Element5) Element1=1 //prestige system
				if(src.Element2) if(src.Element2 != usr.Element && src.Element2 != usr.Element2 && src.Element2 != usr.Element3 && src.Element2 != usr.Element4 && src.Element2 != usr.Element5) Element2z=1
				if(src.Kekkai)if(src.Kekkai!=usr.Kekkai)KekkaiC=1
				if(src.Specialist)if(src.Specialist!=usr.Specialist)SpecialistZ=1
				if(Element1)
					usr<<output("You do not have the appropriate element affinity to learn this technique. ([Element][Element2 ? " and [Element2]" : ""]).","Action.Output")
					return
				if(Element2z)
					usr<<output("You do not have the appropriate element affinity to learn this technique. ([Element][Element2 ? " and [Element2]" : ""]).","Action.Output")
					return
				if(KekkaiC)
					usr<<output("You do not have the appropriate Kekkai Genkai to learn this technique..","Action.Output")
					return
				if(SpecialistZ)
					usr<<output("You are not the appropriate speciality to learn this technique. ([Specialist]).","Action.Output")
					return
				if(has_reqs==1)
					var/I=usr.CustomInput("[src.name]","[Description]<br><br>Buy this jutsu for [src.Sprice] skill points?",list("Yes","No"))
					if(!I) return
					switch(I:name)
						if("Yes")
							if(usr.skillpoints<src.Sprice)
								usr<<output("Not enough skill points to purchase [src.name]. You need [src.Sprice].","Action.Output")
								return
							if(src.Clan == usr.Clan && src.Clan == usr.Clan2)
								usr<<output("You no longer have this clan!","Action.Output")
								return
							usr.skillpoints -= src.Sprice
							if(src.IsGate)
								if(!usr.jutsus_learned.Find(/obj/Jutsus/EightGates))
									var/obj/J = new /obj/Jutsus/EightGates(null)
									usr.jutsus.Add(J)
									usr.jutsus_learned.Add(J.type)
									usr.sbought.Add(J.name)
								for(var/obj/Jutsus/EightGates/J in usr.jutsus)
									J.level ++

							else
							/*	if(src.name=="Tsukuyomi"||src.name=="Amaterasu"||src.name=="Kamui"||src.name=="Susanoo"||src.name=="Eternal Mangekyou Sharingan")
									usr.UchihaJ++*/
								if(src.sharin<>0 && src.sharin<>1)
									usr.sbought+=src.name
									for(var/obj/Jutsus/Sharingan/SH in usr.jutsus)
										var/os = SH.icon_state
										SH.icon_state = src.icon_state
										SH.mouse_drag_pointer = src.mouse_drag_pointer
										SH.name = src.name
										if(usr.HotSlotSave["HotSlot1"]==os)
											for(var/obj/HotSlots/HotSlot1/H in usr.client.screen)
												var/obj/h=H
												h.overlays=0
												h.overlays+=src
												usr.HotSlotSave["HotSlot1"]="[src.icon_state]"
												usr.hotslot1=src.name
												h.SetName("Z")
										if(usr.HotSlotSave["HotSlot2"]==os)
											for(var/obj/HotSlots/HotSlot2/H in usr.client.screen)
												var/obj/h=H
												h.overlays=0
												h.overlays+=src
												usr.HotSlotSave["HotSlot2"]="[src.icon_state]"
												usr.hotslot2=src.name
												h.SetName("X")
										if(usr.HotSlotSave["HotSlot3"]==os)
											for(var/obj/HotSlots/HotSlot3/H in usr.client.screen)
												var/obj/h=H
												h.overlays=0
												h.overlays+=src
												usr.HotSlotSave["HotSlot3"]="[src.icon_state]"
												usr.hotslot3=src.name
												h.SetName("C")
										if(usr.HotSlotSave["HotSlot4"]==os)
											for(var/obj/HotSlots/HotSlot4/H in usr.client.screen)
												var/obj/h=H
												h.overlays=0
												h.overlays+=src
												usr.HotSlotSave["HotSlot4"]="[src.icon_state]"
												usr.hotslot4=src.name
												h.SetName("V")
										if(usr.HotSlotSave["HotSlot5"]==os)
											for(var/obj/HotSlots/HotSlot5/H in usr.client.screen)
												var/obj/h=H
												h.overlays=0
												h.overlays+=src
												usr.HotSlotSave["HotSlot5"]="[src.icon_state]"
												usr.hotslot5=src.name
												h.SetName("B")
										if(usr.HotSlotSave["HotSlot6"]==os)
											for(var/obj/HotSlots/HotSlot6/H in usr.client.screen)
												var/obj/h=H
												h.overlays=0
												h.overlays+=src
												usr.HotSlotSave["HotSlot6"]="[src.icon_state]"
												usr.hotslot6=src.name
												h.SetName("N")
										if(usr.HotSlotSave["HotSlot7"]==os)
											for(var/obj/HotSlots/HotSlot7/H in usr.client.screen)
												var/obj/h=H
												h.overlays=0
												h.overlays+=src
												usr.HotSlotSave["HotSlot7"]="[src.icon_state]"
												usr.hotslot7=src.name
												h.SetName("F7")
										if(usr.HotSlotSave["HotSlot8"]==os)
											for(var/obj/HotSlots/HotSlot8/H in usr.client.screen)
												var/obj/h=H
												h.overlays=0
												h.overlays+=src
												usr.HotSlotSave["HotSlot8"]="[src.icon_state]"
												usr.hotslot8=src.name
												h.SetName("F8")
										if(usr.HotSlotSave["HotSlot9"]==os)
											for(var/obj/HotSlots/HotSlot9/H in usr.client.screen)
												var/obj/h=H
												h.overlays=0
												h.overlays+=src
												usr.HotSlotSave["HotSlot9"]="[src.icon_state]"
												usr.hotslot9=src.name
												h.SetName("F9")
										if(usr.HotSlotSave["HotSlot10"]==os)
											for(var/obj/HotSlots/HotSlot10/H in usr.client.screen)
												var/obj/h=H
												h.overlays=0
												h.overlays+=src
												usr.HotSlotSave["HotSlot10"]="[src.icon_state]"
												usr.hotslot10=src.name
												h.SetName("F10")
										if(usr.HotSlotSave["HotSlot11"]==os)
											for(var/obj/HotSlots/HotSlot10/H in usr.client.screen)
												var/obj/h=H
												h.overlays=0
												h.overlays+=src
												usr.HotSlotSave["HotSlot11"]="[src.icon_state]"
												usr.hotslot10=src.name
												h.SetName("F11")
										if(usr.HotSlotSave["HotSlot12"]==os)
											for(var/obj/HotSlots/HotSlot10/H in usr.client.screen)
												var/obj/h=H
												h.overlays=0
												h.overlays+=src
												usr.HotSlotSave["HotSlot12"]="[src.icon_state]"
												usr.hotslot10=src.name
												h.SetName("F12")
										if(usr.HotSlotSave["HotSlot13"]==os)
											for(var/obj/HotSlots/HotSlot10/H in usr.client.screen)
												var/obj/h=H
												h.overlays=0
												h.overlays+=src
												usr.HotSlotSave["HotSlot13"]="[src.icon_state]"
												usr.hotslot10=src.name
												h.SetName("F1")
										if(usr.HotSlotSave["HotSlot14"]==os)
											for(var/obj/HotSlots/HotSlot10/H in usr.client.screen)
												var/obj/h=H
												h.overlays=0
												h.overlays+=src
												usr.HotSlotSave["HotSlot14"]="[src.icon_state]"
												usr.hotslot10=src.name
												h.SetName("F2")
										if(usr.HotSlotSave["HotSlot15"]==os)
											for(var/obj/HotSlots/HotSlot10/H in usr.client.screen)
												var/obj/h=H
												h.overlays=0
												h.overlays+=src
												usr.HotSlotSave["HotSlot15"]="[src.icon_state]"
												usr.hotslot10=src.name
												h.SetName("F3")
										if(usr.HotSlotSave["HotSlot16"]==os)
											for(var/obj/HotSlots/HotSlot10/H in usr.client.screen)
												var/obj/h=H
												h.overlays=0
												h.overlays+=src
												usr.HotSlotSave["HotSlot16"]="[src.icon_state]"
												usr.hotslot10=src.name
												h.SetName("F4")
										if(usr.HotSlotSave["HotSlot17"]==os)
											for(var/obj/HotSlots/HotSlot10/H in usr.client.screen)
												var/obj/h=H
												h.overlays=0
												h.overlays+=src
												usr.HotSlotSave["HotSlot17"]="[src.icon_state]"
												usr.hotslot10=src.name
												h.SetName("F5")
										if(usr.HotSlotSave["HotSlot18"]==os)
											for(var/obj/HotSlots/HotSlot10/H in usr.client.screen)
												var/obj/h=H
												h.overlays=0
												h.overlays+=src
												usr.HotSlotSave["HotSlot18"]="[src.icon_state]"
												usr.hotslot10=src.name
												h.SetName("F6")

										SH.level ++
								else
									usr.sbought+=src.name
									var/obj/Jutsus/jutsu=new src.type
									usr.jutsus += jutsu
									usr.jutsus_learned += jutsu.type
									jutsu.owner=usr.ckey
									if(istype(jutsu, /obj/Jutsus/BClone))
										var/obj/Jutsus/BCloneD/D=new
										usr.skillpoints-=src.Sprice
										usr.jutsus += D
										usr.jutsus_learned += D.type
										D.owner=usr.ckey
							if(src.name <> "Dust Particle"&&src.name <> "Kakuzu"&&src.name <> "Ice" &&src.name <> "Spider" && src.name <> "Deidara" && src.name <> "Puppeteer" && src.name <> "Sand" && src.name <> "Paper Control")
								usr<<output("Successfully learned [src.name]. Check your Jutsus list for information on the seals.","Action.Output")

							if(usr.client) usr.client.UpdateSkillTree()

				else
					usr<<output("You do not meet the requirements for this technique.","Action.Output")

		MouseDrop(var/H)
			if(!src in usr.jutsus)
				return
			if(src.IsGate)
				usr << output("You may not put this technique on a hotslot.","Action.Output")
				return
			if(src.uses>=((80-round(src.maxcooltime/15))/handsealmastery))
				if(istype(H,/obj/HotSlots/HotSlot1))
					var/image/I = image(src, src.icon_state)
					I.pixel_x = 12
					I.pixel_y = -1

					var/obj/HotSlots/h = H
					h.overlays = null
					h.overlays += I
					h.SetName("Z")

					usr.hotslot1 = src.name
					usr.HotSlotSave["HotSlot1"] = "[src.icon_state]"

				if(istype(H,/obj/HotSlots/HotSlot2))
					var/image/I = image(src, src.icon_state)
					I.pixel_x = 12
					I.pixel_y = -1

					var/obj/HotSlots/h = H
					h.overlays = null
					h.overlays += I
					h.SetName("X")

					usr.hotslot2 = src.name
					usr.HotSlotSave["HotSlot2"] = "[src.icon_state]"

				if(istype(H,/obj/HotSlots/HotSlot3))
					var/image/I = image(src, src.icon_state)
					I.pixel_x = 12
					I.pixel_y = -1

					var/obj/HotSlots/h = H
					h.overlays = null
					h.overlays += I
					h.SetName("C")

					usr.hotslot3 = src.name
					usr.HotSlotSave["HotSlot3"] = "[src.icon_state]"

				if(istype(H,/obj/HotSlots/HotSlot4))
					var/image/I = image(src, src.icon_state)
					I.pixel_x = 12
					I.pixel_y = -1

					var/obj/HotSlots/h = H
					h.overlays = null
					h.overlays += I
					h.SetName("V")

					usr.hotslot4 = src.name
					usr.HotSlotSave["HotSlot4"] = "[src.icon_state]"

				if(istype(H,/obj/HotSlots/HotSlot5))
					var/image/I = image(src, src.icon_state)
					I.pixel_x = 12
					I.pixel_y = -1

					var/obj/HotSlots/h = H
					h.overlays = null
					h.overlays += I
					h.SetName("B")

					usr.hotslot5 = src.name
					usr.HotSlotSave["HotSlot5"] = "[src.icon_state]"

				if(istype(H,/obj/HotSlots/HotSlot6))
					var/image/I = image(src, src.icon_state)
					I.pixel_x = 12
					I.pixel_y = -1

					var/obj/HotSlots/h = H
					h.overlays = null
					h.overlays += I
					h.SetName("N")

					usr.hotslot6 = src.name
					usr.HotSlotSave["HotSlot6"] = "[src.icon_state]"

				if(istype(H,/obj/HotSlots/HotSlot7))
					var/image/I = image(src, src.icon_state)
					I.pixel_x = 12
					I.pixel_y = -1

					var/obj/HotSlots/h = H
					h.overlays = null
					h.overlays += I
					h.SetName("F7")

					usr.hotslot7 = src.name
					usr.HotSlotSave["HotSlot7"] = "[src.icon_state]"

				if(istype(H,/obj/HotSlots/HotSlot8))
					var/image/I = image(src, src.icon_state)
					I.pixel_x = 12
					I.pixel_y = -1

					var/obj/HotSlots/h = H
					h.overlays = null
					h.overlays += I
					h.SetName("F8")

					usr.hotslot8 = src.name
					usr.HotSlotSave["HotSlot8"] = "[src.icon_state]"

				if(istype(H,/obj/HotSlots/HotSlot9))
					var/image/I = image(src, src.icon_state)
					I.pixel_x = 12
					I.pixel_y = -1

					var/obj/HotSlots/h = H
					h.overlays = null
					h.overlays += I
					h.SetName("F9")

					usr.hotslot9 = src.name
					usr.HotSlotSave["HotSlot9"] = "[src.icon_state]"

				if(istype(H,/obj/HotSlots/HotSlot10))
					var/image/I = image(src, src.icon_state)
					I.pixel_x = 12
					I.pixel_y = -1

					var/obj/HotSlots/h = H
					h.overlays = null
					h.overlays += I
					h.SetName("F10")

					usr.hotslot10 = src.name
					usr.HotSlotSave["HotSlot10"] = "[src.icon_state]"

				if(istype(H,/obj/HotSlots/HotSlot11))
					var/image/I = image(src, src.icon_state)
					I.pixel_x = 12
					I.pixel_y = -1

					var/obj/HotSlots/h = H
					h.overlays = null
					h.overlays += I
					h.SetName("F11")

					usr.hotslot11 = src.name
					usr.HotSlotSave["HotSlot11"] = "[src.icon_state]"

				if(istype(H,/obj/HotSlots/HotSlot12))
					var/image/I = image(src, src.icon_state)
					I.pixel_x = 12
					I.pixel_y = -1

					var/obj/HotSlots/h = H
					h.overlays = null
					h.overlays += I
					h.SetName("F12")

					usr.hotslot12 = src.name
					usr.HotSlotSave["HotSlot12"] = "[src.icon_state]"

				if(istype(H,/obj/HotSlots/HotSlot13))
					var/image/I = image(src, src.icon_state)
					I.pixel_x = 12
					I.pixel_y = -1

					var/obj/HotSlots/h = H
					h.overlays = null
					h.overlays += I
					h.SetName("F1")

					usr.hotslot13 = src.name
					usr.HotSlotSave["HotSlot13"] = "[src.icon_state]"

				if(istype(H,/obj/HotSlots/HotSlot14))
					var/image/I = image(src, src.icon_state)
					I.pixel_x = 12
					I.pixel_y = -1

					var/obj/HotSlots/h = H
					h.overlays = null
					h.overlays += I
					h.SetName("F2")

					usr.hotslot14 = src.name
					usr.HotSlotSave["HotSlot14"] = "[src.icon_state]"

				if(istype(H,/obj/HotSlots/HotSlot15))
					var/image/I = image(src, src.icon_state)
					I.pixel_x = 12
					I.pixel_y = -1

					var/obj/HotSlots/h = H
					h.overlays = null
					h.overlays += I
					h.SetName("F3")

					usr.hotslot15 = src.name
					usr.HotSlotSave["HotSlot15"] = "[src.icon_state]"

				if(istype(H,/obj/HotSlots/HotSlot16))
					var/image/I = image(src, src.icon_state)
					I.pixel_x = 12
					I.pixel_y = -1

					var/obj/HotSlots/h = H
					h.overlays = null
					h.overlays += I
					h.SetName("F4")

					usr.hotslot16 = src.name
					usr.HotSlotSave["HotSlot16"] = "[src.icon_state]"

				if(istype(H,/obj/HotSlots/HotSlot17))
					var/image/I = image(src, src.icon_state)
					I.pixel_x = 12
					I.pixel_y = -1

					var/obj/HotSlots/h = H
					h.overlays = null
					h.overlays += I
					h.SetName("F5")

					usr.hotslot17 = src.name
					usr.HotSlotSave["HotSlot17"] = "[src.icon_state]"

				if(istype(H,/obj/HotSlots/HotSlot18))
					var/image/I = image(src, src.icon_state)
					I.pixel_x = 12
					I.pixel_y = -1

					var/obj/HotSlots/h = H
					h.overlays = null
					h.overlays += I
					h.SetName("F6")

					usr.hotslot18 = src.name
					usr.HotSlotSave["HotSlot18"] = "[src.icon_state]"


			else
				usr<<output("<Font color=red>You need to use [src.name] [((80-round(src.maxcooltime/15))/handsealmastery)-src.uses] more times (You've used it [src.uses] times already).</Font>","Action.Output")
				


obj
	HSigns
		icon='HandSigns.dmi'
		dog
			icon_state = "dog"
			layer = 20
			screen_loc = "17,20"
		rat
			icon_state = "rat"
			layer = 20
			screen_loc = "17,20"
		rabbit
			icon_state = "rabbit"
			layer = 20
			screen_loc = "17,20"
		horse
			icon_state = "horse"
			layer = 20
			screen_loc = "17,20"
		ox
			icon_state = "ox"
			layer = 20
			screen_loc = "17,20"
		snake
			icon_state = "snake"
			layer = 20
			screen_loc = "17,20"
		monkey
			icon_state = "monkey"
			layer = 20
			screen_loc = "17,20"
		dragon
			icon_state = "dragon"
			layer = 20
			screen_loc = "17,20"
mob
	verb
		HandSealActivate()
			set hidden=1
			if(CheckState(src, new/state/knocked_down)) return 0

			if(client.eye==locate(10,10,4)||client.eye==locate(60,10,4)||client.eye==locate(12,43,4)||client.eye==locate(55,43,4)||usr.client.eye==locate(10,75,4)) return
			src.HengeUndo()
			if(usr.SealCount>=1)
				src.PlayAudio('active.wav', output = AUDIO_HEARERS)
				if(usr.first=="rat"&&usr.second=="dragon"&&usr.rat==1&&usr.dog==0&&usr.ox==0&&usr.dragon==1&&usr.monkey==0&&usr.snake==0&&usr.horse==0&&usr.rabbit==0)
					var/obj/Jutsus/SClone/J=new/obj/Jutsus/SClone
					if(J.type in usr.jutsus_learned)
						if(genin_exam_participants.Find(src))
							if(!genin_exam_practical_score[src]) genin_exam_practical_score[src] = 1
							else genin_exam_practical_score[src]++

						usr.ShadowClone_Jutsu()

				if(usr.first=="rat"&&usr.second=="rat"&&usr.third=="snake"&&usr.rat==2&&usr.dog==0&&usr.ox==0&&usr.dragon==0&&usr.monkey==0&&usr.snake==1&&usr.horse==0&&usr.rabbit==0)
					var/obj/Jutsus/MizuClone/J=new/obj/Jutsus/MizuClone
					if(J.type in usr.jutsus_learned)
						if(genin_exam_participants.Find(src))
							if(!genin_exam_practical_score[src]) genin_exam_practical_score[src] = 1
							else genin_exam_practical_score[src]++

						usr.MizuClone_Jutsu()

				if(usr.first=="rat"&&usr.second=="rat"&&usr.third=="ox"&&usr.rat==2&&usr.dog==0&&usr.ox==1&&usr.dragon==0&&usr.monkey==0&&usr.snake==0&&usr.horse==0&&usr.rabbit==0)
					var/obj/Jutsus/Camellia_Dance/J=new/obj/Jutsus/Camellia_Dance
					if(J.type in usr.jutsus_learned)
						if(genin_exam_participants.Find(src))
							if(!genin_exam_practical_score[src]) genin_exam_practical_score[src] = 1
							else genin_exam_practical_score[src]++

						usr.Camellia_Dance()

				if(usr.first=="snake"&&usr.second=="dragon"&&usr.third=="snake"&&usr.rat==0&&usr.dog==0&&usr.ox==0&&usr.dragon==1&&usr.monkey==0&&usr.snake==2&&usr.horse==0&&usr.rabbit==0)
					var/obj/Jutsus/Insect_Clone/J=new/obj/Jutsus/Insect_Clone
					if(J.type in usr.jutsus_learned)
						if(genin_exam_participants.Find(src))
							if(!genin_exam_practical_score[src]) genin_exam_practical_score[src] = 1
							else genin_exam_practical_score[src]++

						usr.InsectClone()

				if(usr.first=="snake"&&usr.second=="snake"&&usr.third=="dog"&&usr.rat==0&&usr.dog==1&&usr.ox==0&&usr.dragon==0&&usr.monkey==0&&usr.snake==2&&usr.horse==0&&usr.rabbit==0)
					var/obj/Jutsus/Eight_Trigrams_Mountain_Crusher/J=new/obj/Jutsus/Eight_Trigrams_Mountain_Crusher
					if(J.type in usr.jutsus_learned)
						if(genin_exam_participants.Find(src))
							if(!genin_exam_practical_score[src]) genin_exam_practical_score[src] = 1
							else genin_exam_practical_score[src]++

						usr.Eight_Trigrams_Mountain_Crusher()

				if(usr.first=="dog"&&usr.second=="ox"&&usr.third=="ox"&&usr.fourth=="dog"&&usr.rat==0&&usr.dog==2&&usr.ox==2&&usr.dragon==0&&usr.monkey==0&&usr.snake==0&&usr.horse==0&&usr.rabbit==0)
					var/obj/Jutsus/Sand_Funeral/J=new/obj/Jutsus/Sand_Funeral
					if(J.type in usr.jutsus_learned)
						if(genin_exam_participants.Find(src))
							if(!genin_exam_practical_score[src]) genin_exam_practical_score[src] = 1
							else genin_exam_practical_score[src]++

						usr.Sand_Funeral()

				if(usr.first=="dog"&&usr.second=="ox"&&usr.third=="dog"&&usr.fourth=="ox"&&usr.rat==0&&usr.dog==2&&usr.ox==2&&usr.dragon==0&&usr.monkey==0&&usr.snake==0&&usr.horse==0&&usr.rabbit==0)
					var/obj/Jutsus/Sand_Shield/J=new/obj/Jutsus/Sand_Shield
					if(J.type in usr.jutsus_learned)
						if(genin_exam_participants.Find(src))
							if(!genin_exam_practical_score[src]) genin_exam_practical_score[src] = 1
							else genin_exam_practical_score[src]++

						usr.Sand_Shield()

				if(usr.first=="dog"&&usr.second=="rat"&&usr.third=="rat"&&usr.fourth=="dog"&&usr.fifth=="dog"&&usr.sixth=="rat"&&usr.seventh=="dog"&&usr.eighth=="rat"&&usr.rat==4&&usr.dog==4&&usr.ox==0&&usr.dragon==0&&usr.monkey==0&&usr.snake==0&&usr.horse==0&&usr.rabbit==0)
					var/obj/Jutsus/Fire_Dragon_Projectile/J=new/obj/Jutsus/Fire_Dragon_Projectile
					if(J.type in usr.jutsus_learned)
						if(genin_exam_participants.Find(src))
							if(!genin_exam_practical_score[src]) genin_exam_practical_score[src] = 1
							else genin_exam_practical_score[src]++

						usr.Fire_Dragon_Projectile()

				if(usr.first=="dog"&&usr.second=="rat"&&usr.third=="rat"&&usr.fourth=="dog"&&usr.fifth=="dog"&&usr.sixth=="rat"&&usr.seventh=="dog"&&usr.eighth=="rat"&&usr.nineth=="dragon"&&usr.tenth=="dragon"&&usr.rat==4&&usr.dog==4&&usr.ox==0&&usr.dragon==2&&usr.monkey==0&&usr.snake==0&&usr.horse==0&&usr.rabbit==0)
					var/obj/Jutsus/Water_Dragon_Projectile/J=new/obj/Jutsus/Water_Dragon_Projectile
					if(J.type in usr.jutsus_learned)
						if(genin_exam_participants.Find(src))
							if(!genin_exam_practical_score[src]) genin_exam_practical_score[src] = 1
							else genin_exam_practical_score[src]++

						usr.Water_Dragon_Projectile()

				if(usr.first=="dog"&&usr.second=="rat"&&usr.third=="rat"&&usr.fourth=="dog"&&usr.fifth=="dog"&&usr.sixth=="rat"&&usr.seventh=="dog"&&usr.rat==3&&usr.dog==4&&usr.ox==0&&usr.dragon==0&&usr.monkey==0&&usr.snake==0&&usr.horse==0&&usr.rabbit==0)
					var/obj/Jutsus/Mud_Dragon_Projectile/J=new/obj/Jutsus/Mud_Dragon_Projectile
					if(J.type in usr.jutsus_learned)
						if(genin_exam_participants.Find(src))
							if(!genin_exam_practical_score[src]) genin_exam_practical_score[src] = 1
							else genin_exam_practical_score[src]++

						usr.Mud_Dragon_Projectile()

				if(usr.first=="snake"&&usr.second=="dragon"&&usr.third=="snake"&&usr.fourth=="rat"&&usr.rat==1&&usr.dog==0&&usr.ox==0&&usr.dragon==1&&usr.monkey==0&&usr.snake==2&&usr.horse==0&&usr.rabbit==0)
					var/obj/Jutsus/Chakra_Leech/J=new/obj/Jutsus/Chakra_Leech
					if(J.type in usr.jutsus_learned)
						if(genin_exam_participants.Find(src))
							if(!genin_exam_practical_score[src]) genin_exam_practical_score[src] = 1
							else genin_exam_practical_score[src]++

						usr.Chakra_Leech()

				if(usr.first=="horse"&&usr.second=="horse"&&usr.third=="horse"&&usr.rat==0&&usr.dog==0&&usr.ox==0&&usr.dragon==0&&usr.monkey==0&&usr.snake==0&&usr.horse==3&&usr.rabbit==0)
					var/obj/Jutsus/Ones_Own_Life_Reincarnation/J=new/obj/Jutsus/Ones_Own_Life_Reincarnation
					if(J.type in usr.jutsus_learned)
						if(genin_exam_participants.Find(src))
							if(!genin_exam_practical_score[src]) genin_exam_practical_score[src] = 1
							else genin_exam_practical_score[src]++

						usr.Ones_Own_Life_Reincarnation()

				if(usr.first=="ox"&&usr.second=="rat"&&usr.third=="ox"&&usr.rat==1&&usr.dog==0&&usr.ox==2&&usr.dragon==0&&usr.monkey==0&&usr.snake==0&&usr.horse==0&&usr.rabbit==0)
					var/obj/Jutsus/Shikigami_Spear/J=new/obj/Jutsus/Shikigami_Spear
					if(J.type in usr.jutsus_learned)
						if(genin_exam_participants.Find(src))
							if(!genin_exam_practical_score[src]) genin_exam_practical_score[src] = 1
							else genin_exam_practical_score[src]++

						usr.Shikigami_Spear()

				if(usr.first=="dragon"&&usr.second=="dragon"&&usr.third=="snake"&&usr.rat==0&&usr.dog==0&&usr.ox==0&&usr.dragon==2&&usr.monkey==0&&usr.snake==1&&usr.horse==0&&usr.rabbit==0)
					var/obj/Jutsus/Stealth_Bug/J=new/obj/Jutsus/Stealth_Bug
					if(J.type in usr.jutsus_learned)
						if(genin_exam_participants.Find(src))
							if(!genin_exam_practical_score[src]) genin_exam_practical_score[src] = 1
							else genin_exam_practical_score[src]++

						usr.Stealth_Bug()

				if(usr.first=="ox"&&usr.second=="rat"&&usr.third=="rat"&&usr.fourth=="rat"&&usr.rat==3&&usr.dog==0&&usr.ox==1&&usr.dragon==0&&usr.monkey==0&&usr.snake==0&&usr.horse==0&&usr.rabbit==0)
					var/obj/Jutsus/Shikigami_Dance/J=new/obj/Jutsus/Shikigami_Dance
					if(J.type in usr.jutsus_learned)
						if(genin_exam_participants.Find(src))
							if(!genin_exam_practical_score[src]) genin_exam_practical_score[src] = 1
							else genin_exam_practical_score[src]++

						usr.Shikigami_Dance()

				if(usr.first=="dog"&&usr.second=="ox"&&usr.third=="dragon"&&usr.rat==0&&usr.dog==1&&usr.ox==1&&usr.dragon==1&&usr.monkey==0&&usr.snake==0&&usr.horse==0&&usr.rabbit==0)
					var/obj/Jutsus/Bringer_of_Darkness_Technique/J=new/obj/Jutsus/Bringer_of_Darkness_Technique
					if(J.type in usr.jutsus_learned)
						if(genin_exam_participants.Find(src))
							if(!genin_exam_practical_score[src]) genin_exam_practical_score[src] = 1
							else genin_exam_practical_score[src]++

						usr.Bringer_of_Darkness_Technique()

				if(usr.first=="snake"&&usr.second=="dragon"&&usr.third=="dragon"&&usr.rat==0&&usr.dog==0&&usr.ox==0&&usr.dragon==2&&usr.monkey==0&&usr.snake==1&&usr.horse==0&&usr.rabbit==0)
					var/obj/Jutsus/Destruction_Bug_Swarm/J=new/obj/Jutsus/Destruction_Bug_Swarm
					if(J.type in usr.jutsus_learned)
						if(genin_exam_participants.Find(src))
							if(!genin_exam_practical_score[src]) genin_exam_practical_score[src] = 1
							else genin_exam_practical_score[src]++

						usr.Destruction_Bug_Swarm()

				if(usr.first=="dog"&&usr.second=="dog"&&usr.third=="ox"&&usr.fourth=="dog"&&usr.rat==0&&usr.dog==3&&usr.ox==1&&usr.dragon==0&&usr.monkey==0&&usr.snake==0&&usr.horse==0&&usr.rabbit==0)
					var/obj/Jutsus/Shukakku_Spear/J=new/obj/Jutsus/Shukakku_Spear
					if(J.type in usr.jutsus_learned)
						if(genin_exam_participants.Find(src))
							if(!genin_exam_practical_score[src]) genin_exam_practical_score[src] = 1
							else genin_exam_practical_score[src]++

						usr.Shukakku_Spear()

				if(usr.first=="dog"&&usr.second=="dog"&&usr.third=="ox"&&usr.fourth=="ox"&&usr.rat==0&&usr.dog==2&&usr.ox==2&&usr.dragon==0&&usr.monkey==0&&usr.snake==0&&usr.horse==0&&usr.rabbit==0)
					var/obj/Jutsus/Desert_Coffin/J=new/obj/Jutsus/Desert_Coffin
					if(J.type in usr.jutsus_learned)
						if(genin_exam_participants.Find(src))
							if(!genin_exam_practical_score[src]) genin_exam_practical_score[src] = 1
							else genin_exam_practical_score[src]++

						usr.Desert_Coffin()

				if(usr.first=="dog"&&usr.second=="dog"&&usr.third=="ox"&&usr.rat==0&&usr.dog==2&&usr.ox==1&&usr.dragon==0&&usr.monkey==0&&usr.snake==0&&usr.horse==0&&usr.rabbit==0)
					var/obj/Jutsus/Sand_Shuriken/J=new/obj/Jutsus/Sand_Shuriken
					if(J.type in usr.jutsus_learned)
						if(genin_exam_participants.Find(src))
							if(!genin_exam_practical_score[src]) genin_exam_practical_score[src] = 1
							else genin_exam_practical_score[src]++

						usr.Sand_Shuriken()

				if(usr.first=="dragon"&&usr.second=="snake"&&usr.third=="snake"&&usr.fourth=="dragon"&&usr.rat==0&&usr.dog==0&&usr.ox==0&&usr.dragon==2&&usr.monkey==0&&usr.snake==2&&usr.horse==0&&usr.rabbit==0)
					var/obj/Jutsus/Insect_Cocoon/J=new/obj/Jutsus/Insect_Cocoon
					if(J.type in usr.jutsus_learned)
						if(genin_exam_participants.Find(src))
							if(!genin_exam_practical_score[src]) genin_exam_practical_score[src] = 1
							else genin_exam_practical_score[src]++

						usr.Insect_Cocoon()

				if(usr.first=="rabbit"&&usr.second=="rabbit"&&usr.third=="rabbit"&&usr.rat==0&&usr.dog==0&&usr.ox==0&&usr.dragon==0&&usr.monkey==0&&usr.snake==0&&usr.horse==0&&usr.rabbit==3)
					var/obj/Jutsus/Earth_Disruption/J=new/obj/Jutsus/Earth_Disruption
					if(J.type in usr.jutsus_learned)
						if(genin_exam_participants.Find(src))
							if(!genin_exam_practical_score[src]) genin_exam_practical_score[src] = 1
							else genin_exam_practical_score[src]++

						usr.Earth_Disruption()

				if(usr.first=="rabbit"&&usr.second=="rabbit"&&usr.third=="monkey"&&usr.rat==0&&usr.dog==0&&usr.ox==0&&usr.dragon==0&&usr.monkey==1&&usr.snake==0&&usr.horse==0&&usr.rabbit==2)
					var/obj/Jutsus/Earth_Release_Mud_River/J=new/obj/Jutsus/Earth_Release_Mud_River
					if(J.type in usr.jutsus_learned)
						if(genin_exam_participants.Find(src))
							if(!genin_exam_practical_score[src]) genin_exam_practical_score[src] = 1
							else genin_exam_practical_score[src]++

						usr.Earth_Release_Mud_River()

				if(usr.first=="ox"&&usr.second=="snake"&&usr.third=="rat"&&usr.fourth=="snake"&&usr.rat==1&&usr.dog==0&&usr.ox==1&&usr.dragon==0&&usr.monkey==0&&usr.snake==2&&usr.horse==0&&usr.rabbit==0)
					var/obj/Jutsus/WaterPrison/J=new/obj/Jutsus/WaterPrison
					if(J.type in usr.jutsus_learned)
						if(genin_exam_participants.Find(src))
							if(!genin_exam_practical_score[src]) genin_exam_practical_score[src] = 1
							else genin_exam_practical_score[src]++

						usr.WaterPrison()

				if(usr.first=="monkey"&&usr.second=="snake"&&usr.third=="ox"&&usr.rat==0&&usr.dog==0&&usr.ox==1&&usr.dragon==0&&usr.monkey==1&&usr.snake==1&&usr.horse==0&&usr.rabbit==0)
					var/obj/Jutsus/Shadow_Extension/J=new/obj/Jutsus/Shadow_Extension
					if(J.type in usr.jutsus_learned)
						if(genin_exam_participants.Find(src))
							if(!genin_exam_practical_score[src]) genin_exam_practical_score[src] = 1
							else genin_exam_practical_score[src]++

						usr.Shadow_Extension()

				if(usr.first=="rabbit"&&usr.second=="snake"&&usr.third=="monkey"&&usr.rat==0&&usr.dog==0&&usr.ox==0&&usr.dragon==0&&usr.monkey==1&&usr.snake==1&&usr.horse==0&&usr.rabbit==1)
					var/obj/Jutsus/Wind_Shield/J=new/obj/Jutsus/Wind_Shield
					if(J.type in usr.jutsus_learned)
						if(genin_exam_participants.Find(src))
							if(!genin_exam_practical_score[src]) genin_exam_practical_score[src] = 1
							else genin_exam_practical_score[src]++

						usr.Wind_Shield()

				if(usr.first=="ox"&&usr.second=="snake"&&usr.third=="rat"&&usr.fourth=="rabbit"&&usr.fifth=="dragon"&&usr.rat==1&&usr.dog==0&&usr.ox==1&&usr.dragon==1&&usr.monkey==0&&usr.snake==1&&usr.horse==0&&usr.rabbit==1)
					var/obj/Jutsus/WaterShark/J=new/obj/Jutsus/WaterShark
					if(J.type in usr.jutsus_learned)
						if(genin_exam_participants.Find(src))
							if(!genin_exam_practical_score[src]) genin_exam_practical_score[src] = 1
							else genin_exam_practical_score[src]++

						usr.WaterShark()

				if(usr.first=="ox"&&usr.second=="snake"&&usr.third=="rabbit"&&usr.fourth=="dog"&&usr.rat==0&&usr.dog==1&&usr.ox==1&&usr.dragon==0&&usr.monkey==0&&usr.snake==1&&usr.horse==0&&usr.rabbit==1)
					var/obj/Jutsus/TreeBinding/J=new/obj/Jutsus/TreeBinding
					if(J.type in usr.jutsus_learned)
						if(genin_exam_participants.Find(src))
							if(!genin_exam_practical_score[src]) genin_exam_practical_score[src] = 1
							else genin_exam_practical_score[src]++

						usr.TreeBinding()

				if(usr.first=="dog"&&usr.second=="rabbit"&&usr.third=="dog"&&usr.fourth=="snake"&&usr.rat==0&&usr.dog==2&&usr.ox==0&&usr.dragon==0&&usr.monkey==0&&usr.snake==1&&usr.horse==0&&usr.rabbit==1)
					var/obj/Jutsus/Temple_Of_Nirvana/J=new/obj/Jutsus/Temple_Of_Nirvana
					if(J.type in usr.jutsus_learned)
						if(genin_exam_participants.Find(src))
							if(!genin_exam_practical_score[src]) genin_exam_practical_score[src] = 1
							else genin_exam_practical_score[src]++

						usr.Temple_Of_Nirvana()

				if(usr.first=="rabbit"&&usr.second=="rabbit"&&usr.rat==0&&usr.dog==0&&usr.ox==0&&usr.dragon==0&&usr.monkey==0&&usr.snake==0&&usr.horse==0&&usr.rabbit==2)
					var/obj/Jutsus/Earth_Style_Dark_Swamp/J=new/obj/Jutsus/Earth_Style_Dark_Swamp
					if(J.type in usr.jutsus_learned)
						if(genin_exam_participants.Find(src))
							if(!genin_exam_practical_score[src]) genin_exam_practical_score[src] = 1
							else genin_exam_practical_score[src]++

						usr.Earth_Style_Dark_Swamp()

				if(usr.first=="snake"&&usr.second=="rabbit"&&usr.third=="dog"&&usr.rat==0&&usr.dog==1&&usr.ox==0&&usr.dragon==0&&usr.monkey==0&&usr.snake==1&&usr.horse==0&&usr.rabbit==1)
					var/obj/Jutsus/Jinrai/J=new/obj/Jutsus/Jinrai
					if(J.type in usr.jutsus_learned)
						if(genin_exam_participants.Find(src))
							if(!genin_exam_practical_score[src]) genin_exam_practical_score[src] = 1
							else genin_exam_practical_score[src]++

						usr.Chidori_Jinrai()

				if(usr.first=="dragon"&&usr.second=="snake"&&usr.third=="snake"&&usr.rat==0&&usr.dog==0&&usr.ox==0&&usr.dragon==1&&usr.monkey==0&&usr.snake==2&&usr.horse==0&&usr.rabbit==0)
					var/obj/Jutsus/Bug_Neurotoxin/J=new/obj/Jutsus/Bug_Neurotoxin
					if(J.type in usr.jutsus_learned)
						if(genin_exam_participants.Find(src))
							if(!genin_exam_practical_score[src]) genin_exam_practical_score[src] = 1
							else genin_exam_practical_score[src]++

						usr.Bug_Neurotoxin()

				if(usr.first=="dragon"&&usr.second=="snake"&&usr.rat==0&&usr.dog==0&&usr.ox==0&&usr.dragon==1&&usr.monkey==0&&usr.snake==1&&usr.horse==0&&usr.rabbit==0)
					var/obj/Jutsus/Hunter_Scarabs/J=new/obj/Jutsus/Hunter_Scarabs
					if(J.type in usr.jutsus_learned)
						if(genin_exam_participants.Find(src))
							if(!genin_exam_practical_score[src]) genin_exam_practical_score[src] = 1
							else genin_exam_practical_score[src]++

						usr.Hunter_Scarabs()

				if(usr.first=="dragon"&&usr.second=="rabbit"&&usr.third=="dragon"&&usr.rat==0&&usr.dog==0&&usr.ox==0&&usr.dragon==2&&usr.monkey==0&&usr.snake==0&&usr.horse==0&&usr.rabbit==1)
					var/obj/Jutsus/C1_Birds/J=new/obj/Jutsus/C1_Birds
					if(J.type in usr.jutsus_learned)
						if(genin_exam_participants.Find(src))
							if(!genin_exam_practical_score[src]) genin_exam_practical_score[src] = 1
							else genin_exam_practical_score[src]++

						usr.ClayBirds()//signs="<font color=green>Dragon,Dog,Dragon</font><br>(macro(5,E,5))"

				if(usr.first=="dragon"&&usr.second=="dog"&&usr.third=="dragon"&&usr.rat==0&&usr.dog==1&&usr.ox==0&&usr.dragon==2&&usr.monkey==0&&usr.snake==0&&usr.horse==0&&usr.rabbit==0)
					var/obj/Jutsus/C1_Spiders/J=new/obj/Jutsus/C1_Spiders
					if(J.type in usr.jutsus_learned)
						if(genin_exam_participants.Find(src))
							if(!genin_exam_practical_score[src]) genin_exam_practical_score[src] = 1
							else genin_exam_practical_score[src]++

						usr.ClaySpiders()

				if(usr.first=="dragon"&&usr.second=="dragon"&&usr.third=="dragon"&&usr.fourth=="dragon"&&usr.fifth=="dragon"&&usr.rat==0&&usr.dog==0&&usr.ox==0&&usr.dragon==5&&usr.monkey==0&&usr.snake==0&&usr.horse==0&&usr.rabbit==0)
					var/obj/Jutsus/C2/J=new/obj/Jutsus/C2
					if(J.type in usr.jutsus_learned)
						if(genin_exam_participants.Find(src))
							if(!genin_exam_practical_score[src]) genin_exam_practical_score[src] = 1
							else genin_exam_practical_score[src]++

						usr.C2()

				if(usr.first=="dog"&&usr.second=="ox"&&usr.third=="dragon"&&usr.fourth=="ox"&&usr.fifth=="dog"&&usr.rat==0&&usr.dog==2&&usr.ox==2&&usr.dragon==1&&usr.monkey==0&&usr.snake==0&&usr.horse==0&&usr.rabbit==0)
					var/obj/Jutsus/Susanoo/J=new/obj/Jutsus/Susanoo
					if(J.type in usr.jutsus_learned)
						if(genin_exam_participants.Find(src))
							if(!genin_exam_practical_score[src]) genin_exam_practical_score[src] = 1
							else genin_exam_practical_score[src]++

						usr.Susanoo()

				if(usr.first=="dragon"&&usr.second=="dragon"&&usr.third=="dragon"&&usr.fourth=="dragon"&&usr.fifth=="dog"&&usr.rat==0&&usr.dog==1&&usr.ox==0&&usr.dragon==4&&usr.monkey==0&&usr.snake==0&&usr.horse==0&&usr.rabbit==0)
					var/obj/Jutsus/C3/J=new/obj/Jutsus/C3
					if(J.type in usr.jutsus_learned)
						if(genin_exam_participants.Find(src))
							if(!genin_exam_practical_score[src]) genin_exam_practical_score[src] = 1
							else genin_exam_practical_score[src]++

						usr.C3()

				if(usr.first=="dragon"&&usr.second=="horse"&&usr.third=="dragon"&&usr.rat==0&&usr.dog==0&&usr.ox==0&&usr.dragon==2&&usr.monkey==0&&usr.snake==0&&usr.horse==1&&usr.rabbit==0)
					var/obj/Jutsus/Blade_Manipulation_Jutsu/J=new/obj/Jutsus/Blade_Manipulation_Jutsu
					if(J.type in usr.jutsus_learned)
						if(genin_exam_participants.Find(src))
							if(!genin_exam_practical_score[src]) genin_exam_practical_score[src] = 1
							else genin_exam_practical_score[src]++

						usr.Blade_Manipulation_Jutsu()

				if(usr.first=="ox"&&usr.second=="rabbit"&&usr.third=="snake"&&usr.fourth=="dog"&&usr.fifth=="dog"&&usr.sixth=="rabbit"&&usr.rat==0&&usr.dog==2&&usr.ox==1&&usr.dragon==0&&usr.monkey==0&&usr.snake==1&&usr.horse==0&&usr.rabbit==2)
					var/obj/Jutsus/Kirin/J=new/obj/Jutsus/Kirin
					if(J.type in usr.jutsus_learned)
						if(genin_exam_participants.Find(src))
							if(!genin_exam_practical_score[src]) genin_exam_practical_score[src] = 1
							else genin_exam_practical_score[src]++

						usr.Kirin()

				if(usr.first=="ox"&&usr.second=="rabbit"&&usr.rat==0&&usr.dog==0&&usr.ox==1&&usr.dragon==0&&usr.monkey==0&&usr.snake==0&&usr.horse==0&&usr.rabbit==1)
					var/obj/Jutsus/Chidori_Needles/J=new/obj/Jutsus/Chidori_Needles
					if(J.type in usr.jutsus_learned)
						if(genin_exam_participants.Find(src))
							if(!genin_exam_practical_score[src]) genin_exam_practical_score[src] = 1
							else genin_exam_practical_score[src]++

						usr.Chidori_Needles()

				if(usr.first=="rabbit"&&usr.second=="rabbit"&&usr.third=="ox"&&usr.rat==0&&usr.dog==0&&usr.ox==1&&usr.dragon==0&&usr.monkey==0&&usr.snake==0&&usr.horse==0&&usr.rabbit==2)
					var/obj/Jutsus/Rasengan/J=new/obj/Jutsus/Rasengan
					if(J.type in usr.jutsus_learned)
						if(genin_exam_participants.Find(src))
							if(!genin_exam_practical_score[src]) genin_exam_practical_score[src] = 1
							else genin_exam_practical_score[src]++

						usr.Rasengan()

				if(usr.first=="horse"&&usr.second=="horse"&&usr.third=="rabbit"&&usr.rat==0&&usr.dog==0&&usr.ox==0&&usr.dragon==0&&usr.monkey==0&&usr.snake==0&&usr.horse==2&&usr.rabbit==1)
					var/obj/Jutsus/Cherry_Blossom_Impact/J=new/obj/Jutsus/Cherry_Blossom_Impact
					if(J.type in usr.jutsus_learned)
						if(genin_exam_participants.Find(src))
							if(!genin_exam_practical_score[src]) genin_exam_practical_score[src] = 1
							else genin_exam_practical_score[src]++

						usr.Cherry_Blossom_Impact()

				if(usr.first=="rat"&&usr.second=="rat"&&usr.third=="rat"&&usr.rat==3&&usr.dog==0&&usr.ox==0&&usr.dragon==0&&usr.monkey==0&&usr.snake==0&&usr.horse==0&&usr.rabbit==0)
					var/obj/Jutsus/Bone_Drill/J=new/obj/Jutsus/Bone_Drill
					if(J.type in usr.jutsus_learned)
						if(genin_exam_participants.Find(src))
							if(!genin_exam_practical_score[src]) genin_exam_practical_score[src] = 1
							else genin_exam_practical_score[src]++

						usr.Bone_Drill()

				if(usr.first=="rabbit"&&usr.second=="snake"&&usr.third=="rabbit"&&usr.rat==0&&usr.dog==0&&usr.ox==0&&usr.dragon==0&&usr.monkey==0&&usr.snake==1&&usr.horse==0&&usr.rabbit==2)
					var/obj/Jutsus/Blade_of_Wind/J=new/obj/Jutsus/Blade_of_Wind
					if(J.type in usr.jutsus_learned)
						if(genin_exam_participants.Find(src))
							if(!genin_exam_practical_score[src]) genin_exam_practical_score[src] = 1
							else genin_exam_practical_score[src]++

						usr.Blade_of_Wind()

				if(usr.first=="rabbit"&&usr.second=="rabbit"&&usr.third=="ox"&&usr.fourth=="ox"&&usr.fifth=="ox"&&usr.sixth=="ox"&&usr.rat==0&&usr.dog==0&&usr.ox==4&&usr.dragon==0&&usr.monkey==0&&usr.snake==0&&usr.horse==0&&usr.rabbit==2)
					var/obj/Jutsus/Rasenshuriken/J=new/obj/Jutsus/Rasenshuriken
					if(J.type in usr.jutsus_learned)
						if(genin_exam_participants.Find(src))
							if(!genin_exam_practical_score[src]) genin_exam_practical_score[src] = 1
							else genin_exam_practical_score[src]++

						usr.Rasenshuriken()

				if(usr.first=="snake"&&usr.second=="rabbit"&&usr.third=="ox"&&usr.rat==0&&usr.dog==0&&usr.ox==1&&usr.dragon==0&&usr.monkey==0&&usr.snake==1&&usr.horse==0&&usr.rabbit==1)
					var/obj/Jutsus/Chidori/J=new/obj/Jutsus/Chidori
					if(J.type in usr.jutsus_learned)
						if(genin_exam_participants.Find(src))
							if(!genin_exam_practical_score[src]) genin_exam_practical_score[src] = 1
							else genin_exam_practical_score[src]++

						usr.Chidori()

				if(usr.first=="snake"&&usr.second=="ox"&&usr.third=="ox"&&usr.rat==0&&usr.dog==0&&usr.ox==2&&usr.dragon==0&&usr.monkey==0&&usr.snake==1&&usr.horse==0&&usr.rabbit==0)
					var/obj/Jutsus/Raikiri/J=new/obj/Jutsus/Raikiri
					if(J.type in usr.jutsus_learned)
						if(genin_exam_participants.Find(src))
							if(!genin_exam_practical_score[src]) genin_exam_practical_score[src] = 1
							else genin_exam_practical_score[src]++

						usr.Raikiri()

				if(usr.first=="ox"&&usr.second=="snake"&&usr.third=="rabbit"&&usr.fourth=="ox"&&usr.rat==0&&usr.dog==0&&usr.ox==2&&usr.dragon==0&&usr.monkey==0&&usr.snake==1&&usr.horse==0&&usr.rabbit==1)
					var/obj/Jutsus/Sickle_Weasel_Technique/J=new/obj/Jutsus/Sickle_Weasel_Technique
					if(J.type in usr.jutsus_learned)
						if(genin_exam_participants.Find(src))
							if(!genin_exam_practical_score[src]) genin_exam_practical_score[src] = 1
							else genin_exam_practical_score[src]++

						usr.Sickle_Weasel_Technique()

				if(usr.first=="rat"&&usr.second=="dragon"&&usr.third=="dog"&&usr.fourth=="monkey"&&usr.fifth=="monkey"&&usr.rat==1&&usr.dog==1&&usr.ox==0&&usr.dragon==1&&usr.monkey==2&&usr.snake==0&&usr.horse==0&&usr.rabbit==0)
					var/obj/Jutsus/MSClone/J=new/obj/Jutsus/MSClone
					if(J.type in usr.jutsus_learned)
						if(genin_exam_participants.Find(src))
							if(!genin_exam_practical_score[src]) genin_exam_practical_score[src] = 1
							else genin_exam_practical_score[src]++

						usr.MultipleShadowClone_Jutsu()

				if(usr.first=="rat"&&usr.second=="dragon"&&usr.third=="dog"&&usr.fourth=="monkey"&&usr.rat==1&&usr.dog==1&&usr.ox==0&&usr.dragon==1&&usr.monkey==1&&usr.snake==0&&usr.horse==0&&usr.rabbit==0)
					var/obj/Jutsus/Crow_Clone/J=new/obj/Jutsus/Crow_Clone
					if(J.type in usr.jutsus_learned)
						if(genin_exam_participants.Find(src))
							if(!genin_exam_practical_score[src]) genin_exam_practical_score[src] = 1
							else genin_exam_practical_score[src]++

						usr.Crow_Clone()

				if(usr.first=="rabbit"&&usr.second=="dog"&&usr.third=="dog"&&usr.fourth=="ox"&&usr.fifth=="rabbit"&&usr.rat==0&&usr.dog==2&&usr.ox==1&&usr.dragon==0&&usr.monkey==0&&usr.snake==0&&usr.horse==0&&usr.rabbit==2)
					var/obj/Jutsus/Demonic_Ice_Mirrors/J=new/obj/Jutsus/Demonic_Ice_Mirrors
					if(J.type in usr.jutsus_learned)
						if(genin_exam_participants.Find(src))
							if(!genin_exam_practical_score[src]) genin_exam_practical_score[src] = 1
							else genin_exam_practical_score[src]++

						usr.Demonic_Ice_Mirrors()

				if(usr.first=="rabbit"&&usr.second=="dog"&&usr.third=="snake"&&usr.rat==0&&usr.dog==1&&usr.ox==0&&usr.dragon==0&&usr.monkey==0&&usr.snake==1&&usr.horse==0&&usr.rabbit==1)
					var/obj/Jutsus/Water_Release_Exploding_Water_Colliding_Wave/J=new/obj/Jutsus/Water_Release_Exploding_Water_Colliding_Wave
					if(J.type in usr.jutsus_learned)
						if(genin_exam_participants.Find(src))
							if(!genin_exam_practical_score[src]) genin_exam_practical_score[src] = 1
							else genin_exam_practical_score[src]++

						usr.Water_Release_Exploding_Water_Colliding_Wave()

				if(usr.first=="horse"&&usr.second=="horse"&&usr.third=="snake"&&usr.rat==0&&usr.dog==0&&usr.ox==0&&usr.dragon==0&&usr.monkey==0&&usr.snake==1&&usr.horse==2&&usr.rabbit==0)
					var/obj/Jutsus/Body_Pathway_Derangement/J=new/obj/Jutsus/Body_Pathway_Derangement
					if(J.type in usr.jutsus_learned)
						if(genin_exam_participants.Find(src))
							if(!genin_exam_practical_score[src]) genin_exam_practical_score[src] = 1
							else genin_exam_practical_score[src]++

						usr.Body_Pathway_Derangement()

				if(usr.first=="dragon"&&usr.second=="horse"&&usr.third=="snake"&&usr.rat==0&&usr.dog==0&&usr.ox==0&&usr.dragon==1&&usr.monkey==0&&usr.snake==1&&usr.horse==1&&usr.rabbit==0)
					var/obj/Jutsus/Poison_Mist/J=new/obj/Jutsus/Poison_Mist
					if(J.type in usr.jutsus_learned)
						if(genin_exam_participants.Find(src))
							if(!genin_exam_practical_score[src]) genin_exam_practical_score[src] = 1
							else genin_exam_practical_score[src]++

						usr.Poison_Mist()

				if(usr.first=="dog"&&usr.second=="rat"&&usr.third=="dog"&&usr.fourth=="rabbit"&&usr.fifth=="dog"&&usr.rat==1&&usr.dog==3&&usr.ox==0&&usr.dragon==0&&usr.monkey==0&&usr.snake==0&&usr.horse==0&&usr.rabbit==1)
					var/obj/Jutsus/Fire_Release_Ash_Pile_Burning/J=new/obj/Jutsus/Fire_Release_Ash_Pile_Burning
					if(J.type in usr.jutsus_learned)
						if(genin_exam_participants.Find(src))
							if(!genin_exam_practical_score[src]) genin_exam_practical_score[src] = 1
							else genin_exam_practical_score[src]++

						usr.Fire_Release_Ash_Pile_Burning()

				if(usr.first=="snake"&&usr.second=="rat"&&usr.third=="snake"&&usr.fourth=="dragon"&&usr.rat==1&&usr.dog==0&&usr.ox==0&&usr.dragon==1&&usr.monkey==0&&usr.snake==2&&usr.horse==0&&usr.rabbit==0)
					var/obj/Jutsus/Eight_Trigrams_Palm_Heavenly_Spin/J=new/obj/Jutsus/Eight_Trigrams_Palm_Heavenly_Spin
					if(J.type in usr.jutsus_learned)
						if(genin_exam_participants.Find(src))
							if(!genin_exam_practical_score[src]) genin_exam_practical_score[src] = 1
							else genin_exam_practical_score[src]++

						usr.Kaiten()

				if(usr.first=="snake"&&usr.second=="rat"&&usr.rat==1&&usr.dog==0&&usr.ox==0&&usr.dragon==0&&usr.monkey==0&&usr.snake==1&&usr.horse==0&&usr.rabbit==0)
					var/obj/Jutsus/Eight_Trigrams_Empty_Palm/J=new/obj/Jutsus/Eight_Trigrams_Empty_Palm
					if(J.type in usr.jutsus_learned)
						if(genin_exam_participants.Find(src))
							if(!genin_exam_practical_score[src]) genin_exam_practical_score[src] = 1
							else genin_exam_practical_score[src]++

						usr.Eight_Trigrams_Empty_Palm()

				if(usr.first=="rabbit"&&usr.second=="dog"&&usr.third=="rabbit"&&usr.rat==0&&usr.dog==1&&usr.ox==0&&usr.dragon==0&&usr.monkey==0&&usr.snake==0&&usr.horse==0&&usr.rabbit==2)
					var/obj/Jutsus/Sensatsu_Suishou/J=new/obj/Jutsus/Sensatsu_Suishou
					if(J.type in usr.jutsus_learned)
						if(genin_exam_participants.Find(src))
							if(!genin_exam_practical_score[src]) genin_exam_practical_score[src] = 1
							else genin_exam_practical_score[src]++

						usr.Sensatsu_Suisho()

				if(usr.first=="snake"&&usr.rat==0&&usr.dog==0&&usr.ox==0&&usr.dragon==0&&usr.monkey==0&&usr.snake==1&&usr.horse==0&&usr.rabbit==0)
					var/obj/Jutsus/Byakugan/J=new/obj/Jutsus/Byakugan
					if(J.type in usr.jutsus_learned)
						if(genin_exam_participants.Find(src))
							if(!genin_exam_practical_score[src]) genin_exam_practical_score[src] = 1
							else genin_exam_practical_score[src]++

						usr.Byakugan()

				if(usr.first=="rat"&&usr.rat==1&&usr.dog==0&&usr.ox==0&&usr.dragon==0&&usr.monkey==0&&usr.snake==0&&usr.horse==0&&usr.rabbit==0)
					var/obj/Jutsus/BClone/J=new/obj/Jutsus/BClone
					if(J.type in usr.jutsus_learned)
						if(genin_exam_participants.Find(src))
							if(!genin_exam_practical_score[src]) genin_exam_practical_score[src] = 1
							else genin_exam_practical_score[src]++

						usr.Clone_Jutsu()

				if(usr.first=="snake"&&usr.second=="rat"&&usr.third=="dragon"&&usr.fourth=="rat"&&usr.fifth=="dragon"&&usr.rat==2&&usr.dog==0&&usr.ox==0&&usr.dragon==2&&usr.monkey==0&&usr.snake==1&&usr.horse==0&&usr.rabbit==0)
					var/obj/Jutsus/Eight_Trigrams_64_Palms/J=new/obj/Jutsus/Eight_Trigrams_64_Palms
					if(J.type in usr.jutsus_learned)
						if(genin_exam_participants.Find(src))
							if(!genin_exam_practical_score[src]) genin_exam_practical_score[src] = 1
							else genin_exam_practical_score[src]++

						usr.Eight_Trigrams_64_Palms()

				if(usr.first=="snake"&&usr.second=="rat"&&usr.third=="dragon"&&usr.fourth=="rat"&&usr.fifth=="dragon"&&usr.sixth=="dragon"&&usr.rat==2&&usr.dog==0&&usr.ox==0&&usr.dragon==3&&usr.monkey==0&&usr.snake==1&&usr.horse==0&&usr.rabbit==0)
					var/obj/Jutsus/Eight_Gates_Assault/J=new/obj/Jutsus/Eight_Gates_Assault
					if(J.type in usr.jutsus_learned)
						if(genin_exam_participants.Find(src))
							if(!genin_exam_practical_score[src]) genin_exam_practical_score[src] = 1
							else genin_exam_practical_score[src]++

						usr.Eight_Gates_Assault()
			//	if(usr.first=="dragon"&&usr.rat==0&&usr.dog==0&&usr.ox==0&&usr.dragon==1&&usr.monkey==0&&usr.snake==0&&usr.horse==0&&usr.rabbit==0)
			//		var/obj/Jutsus/Body_Flicker/J=new/obj/Jutsus/Body_Flicker
			//		if(J.type in usr.jutsus_learned)
						if(genin_exam_participants.Find(src))
							if(!genin_exam_practical_score[src]) genin_exam_practical_score[src] = 1
							else genin_exam_practical_score[src]++

			//			usr.Shunshin()

				if(usr.first=="dog"&&usr.second=="rat"&&usr.third=="rat"&&usr.fourth=="rat"&&usr.rat==3&&usr.dog==1&&usr.ox==0&&usr.dragon==0&&usr.monkey==0&&usr.snake==0&&usr.horse==0&&usr.rabbit==00)
					var/obj/Jutsus/Tree_Summoning/J=new/obj/Jutsus/Tree_Summoning
					if(J.type in usr.jutsus_learned)
						if(genin_exam_participants.Find(src))
							if(!genin_exam_practical_score[src]) genin_exam_practical_score[src] = 1
							else genin_exam_practical_score[src]++

						usr.Tree_Summoning()

				if(usr.first=="dog"&&usr.second=="snake"&&usr.third=="rat"&&usr.rat==1&&usr.dog==1&&usr.ox==0&&usr.dragon==0&&usr.monkey==0&&usr.snake==1&&usr.horse==0&&usr.rabbit==0)
					var/obj/Jutsus/Heal/J=new/obj/Jutsus/Heal
					if(J.type in usr.jutsus_learned)
						if(genin_exam_participants.Find(src))
							if(!genin_exam_practical_score[src]) genin_exam_practical_score[src] = 1
							else genin_exam_practical_score[src]++

						usr.Heal()

				if(usr.first=="rabbit"&&usr.second=="snake"&&usr.third=="snake"&&usr.fourth=="dog"&&usr.fifth=="rat"&&usr.rat==1&&usr.dog==1&&usr.ox==0&&usr.dragon==0&&usr.monkey==0&&usr.snake==2&&usr.horse==0&&usr.rabbit==1)
					var/obj/Jutsus/Earth_Release_Earth_Cage/J=new/obj/Jutsus/Earth_Release_Earth_Cage
					if(J.type in usr.jutsus_learned)
						if(genin_exam_participants.Find(src))
							if(!genin_exam_practical_score[src]) genin_exam_practical_score[src] = 1
							else genin_exam_practical_score[src]++

						usr.Earth_Release_Earth_Cage()//signs="<font color=green>Rabbit,Snake,Snake,Dog,Rat</font><br>(macro(1,2,2,E,Q))"

				if(usr.first=="rat"&&usr.second=="ox"&&usr.rat==1&&usr.dog==0&&usr.ox==1&&usr.dragon==0&&usr.monkey==0&&usr.snake==0&&usr.horse==0&&usr.rabbit==0)
					var/obj/Jutsus/BCloneD/J=new/obj/Jutsus/BCloneD
					if(J.type in usr.jutsus_learned)
						if(genin_exam_participants.Find(src))
							if(!genin_exam_practical_score[src]) genin_exam_practical_score[src] = 1
							else genin_exam_practical_score[src]++

						usr.Clone_Jutsu_Destroy()

				if(usr.first=="dog"&&usr.rat==0&&usr.dog==1&&usr.ox==0&&usr.dragon==0&&usr.monkey==0&&usr.snake==0&&usr.horse==0&&usr.rabbit==0)
					var/obj/Jutsus/BodyReplace/J=new/obj/Jutsus/BodyReplace
					if(J.type in usr.jutsus_learned)
						if(genin_exam_participants.Find(src))
							if(!genin_exam_practical_score[src]) genin_exam_practical_score[src] = 1
							else genin_exam_practical_score[src]++

						usr.Body_Replacement_Technique()

				if(usr.first=="dog"&&usr.second=="rat"&&usr.rat==1&&usr.dog==1&&usr.ox==0&&usr.dragon==0&&usr.monkey==0&&usr.snake==0&&usr.horse==0&&usr.rabbit==0)
					var/obj/Jutsus/Transformation/J=new/obj/Jutsus/Transformation
					if(J.type in usr.jutsus_learned)
						if(genin_exam_participants.Find(src))
							if(!genin_exam_practical_score[src]) genin_exam_practical_score[src] = 1
							else genin_exam_practical_score[src]++

						usr.Transformation_Jutsu()

				if(usr.first=="dog"&&usr.second=="dog"&&usr.rat==0&&usr.dog==2&&usr.ox==0&&usr.dragon==0&&usr.monkey==0&&usr.snake==0&&usr.horse==0&&usr.rabbit==0)
					var/obj/Jutsus/AdvancedBodyReplace/J=new/obj/Jutsus/AdvancedBodyReplace
					if(J.type in usr.jutsus_learned)
						if(genin_exam_participants.Find(src))
							if(!genin_exam_practical_score[src]) genin_exam_practical_score[src] = 1
							else genin_exam_practical_score[src]++

						usr.Advanced_Body_Replacement_Technique()

				if(usr.first=="rat"&&usr.second=="rat"&&usr.rat==2&&usr.dog==0&&usr.ox==0&&usr.dragon==0&&usr.monkey==0&&usr.snake==0&&usr.horse==0&&usr.rabbit==0)
					var/obj/Jutsus/ChakraRelease/J=new/obj/Jutsus/ChakraRelease
					if(J.type in usr.jutsus_learned)
						if(genin_exam_participants.Find(src))
							if(!genin_exam_practical_score[src]) genin_exam_practical_score[src] = 1
							else genin_exam_practical_score[src]++

						usr.Chakra_Release()

				if(usr.first=="dog"&&usr.second=="dog"&&usr.third=="rat"&&usr.rat==1&&usr.dog==2&&usr.ox==0&&usr.dragon==0&&usr.monkey==0&&usr.snake==0&&usr.horse==0&&usr.rabbit==0)
					var/obj/Jutsus/FireBall/J=new/obj/Jutsus/FireBall
					if(J.type in usr.jutsus_learned)
						if(genin_exam_participants.Find(src))
							if(!genin_exam_practical_score[src]) genin_exam_practical_score[src] = 1
							else genin_exam_practical_score[src]++

						usr.Fire_Ball()

				if(usr.first=="dog"&&usr.second=="rat"&&usr.third=="rat"&&usr.fourth=="dog"&&usr.rat==2&&usr.dog==2&&usr.ox==0&&usr.dragon==0&&usr.monkey==0&&usr.snake==0&&usr.horse==0&&usr.rabbit==0)
					var/obj/Jutsus/PheonixFire/J=new/obj/Jutsus/PheonixFire
					if(J.type in usr.jutsus_learned)
						if(genin_exam_participants.Find(src))
							if(!genin_exam_practical_score[src]) genin_exam_practical_score[src] = 1
							else genin_exam_practical_score[src]++

						usr.Phoenix_Immortal_Fire_Technique()

				if(usr.first=="dog"&&usr.second=="rat"&&usr.third=="dog"&&usr.fourth=="rabbit"&&usr.fifth=="snake"&&usr.rat==1&&usr.dog==2&&usr.ox==0&&usr.dragon==0&&usr.monkey==0&&usr.snake==1&&usr.horse==0&&usr.rabbit==1)
					var/obj/Jutsus/AFireBall/J=new/obj/Jutsus/AFireBall
					if(J.type in usr.jutsus_learned)
						if(genin_exam_participants.Find(src))
							if(!genin_exam_practical_score[src]) genin_exam_practical_score[src] = 1
							else genin_exam_practical_score[src]++

						usr.AFire_Ball()
			//"Gravity"

				if(usr.first=="snake"&&usr.second=="rabbit"&&usr.rat==0&&usr.dog==0&&usr.ox==0&&usr.dragon==0&&usr.monkey==0&&usr.snake==1&&usr.horse==0&&usr.rabbit==1)
					var/obj/Jutsus/Induction/J=new/obj/Jutsus/Induction
					if(J.type in usr.jutsus_learned)
						if(genin_exam_participants.Find(src))
							if(!genin_exam_practical_score[src]) genin_exam_practical_score[src] = 1
							else genin_exam_practical_score[src]++

						usr.Induction()

				if(usr.first=="rabbit"&&usr.second=="snake"&&usr.rat==0&&usr.dog==0&&usr.ox==0&&usr.dragon==0&&usr.monkey==0&&usr.snake==1&&usr.horse==0&&usr.rabbit==1)
					var/obj/Jutsus/Repulsion/J=new/obj/Jutsus/Repulsion
					if(J.type in usr.jutsus_learned)
						if(genin_exam_participants.Find(src))
							if(!genin_exam_practical_score[src]) genin_exam_practical_score[src] = 1
							else genin_exam_practical_score[src]++

						usr.Repulsion()

				if(usr.first=="rabbit"&&usr.second=="rabbit"&&usr.third=="snake"&&usr.fourth=="snake"&&usr.fifth=="rabbit"&&usr.sixth=="snake"&&usr.rat==0&&usr.dog==0&&usr.ox==0&&usr.dragon==0&&usr.monkey==0&&usr.snake==3&&usr.horse==0&&usr.rabbit==3)
					var/obj/Jutsus/Almighty_Push/J=new/obj/Jutsus/Almighty_Push
					if(J.type in usr.jutsus_learned)
						if(genin_exam_participants.Find(src))
							if(!genin_exam_practical_score[src]) genin_exam_practical_score[src] = 1
							else genin_exam_practical_score[src]++

						usr.AlmightyPush()
			//"Kaguya"

				if(usr.first=="rat"&&usr.second=="dog"&&usr.third=="ox"&&usr.rat==1&&usr.dog==1&&usr.ox==1&&usr.dragon==0&&usr.monkey==0&&usr.snake==0&&usr.horse==0&&usr.rabbit==0)
					var/obj/Jutsus/Bone_Pulse/J=new/obj/Jutsus/Bone_Pulse
					if(J.type in usr.jutsus_learned)
						if(genin_exam_participants.Find(src))
							if(!genin_exam_practical_score[src]) genin_exam_practical_score[src] = 1
							else genin_exam_practical_score[src]++

						usr.Bone_Pulse()

				if(usr.first=="rat"&&usr.second=="dog"&&usr.third=="ox"&usr.fourth=="rat"&&usr.rat==2&&usr.dog==1&&usr.ox==1&&usr.dragon==0&&usr.monkey==0&&usr.snake==0&&usr.horse==0&&usr.rabbit==0)
					var/obj/Jutsus/Dance_Of_The_Kaguya/J=new/obj/Jutsus/Dance_Of_The_Kaguya
					if(J.type in usr.jutsus_learned)
						if(genin_exam_participants.Find(src))
							if(!genin_exam_practical_score[src]) genin_exam_practical_score[src] = 1
							else genin_exam_practical_score[src]++

						usr.Dance_Of_The_Kaguya()

				if(usr.first=="ox"&&usr.rat==0&&usr.dog==0&&usr.ox==1&&usr.dragon==0&&usr.monkey==0&&usr.snake==0&&usr.horse==0&&usr.rabbit==0)
					var/obj/Jutsus/Bone_Tip/J=new/obj/Jutsus/Bone_Tip
					if(J.type in usr.jutsus_learned)
						if(genin_exam_participants.Find(src))
							if(!genin_exam_practical_score[src]) genin_exam_practical_score[src] = 1
							else genin_exam_practical_score[src]++

						usr.Bone_Tip()

				if(usr.first=="rat"&&usr.second=="dog"&&usr.third=="ox"&&usr.fourth=="ox"&&usr.rat==1&&usr.dog==1&&usr.ox==2&&usr.dragon==0&&usr.monkey==0&&usr.snake==0&&usr.horse==0&&usr.rabbit==0)
					var/obj/Jutsus/Young_Bracken_Dance/J=new/obj/Jutsus/Young_Bracken_Dance
					if(J.type in usr.jutsus_learned)
						if(genin_exam_participants.Find(src))
							if(!genin_exam_practical_score[src]) genin_exam_practical_score[src] = 1
							else genin_exam_practical_score[src]++

						usr.Young_Bracken_Dance()

				if(usr.first=="ox"&&usr.second=="ox"&&usr.third=="rat"&&usr.rat==1&&usr.dog==0&&usr.ox==2&&usr.dragon==0&&usr.monkey==0&&usr.snake==0&&usr.horse==0&&usr.rabbit==0)
					var/obj/Jutsus/Bone_Tip/J=new/obj/Jutsus/Bone_Sensation
					if(J.type in usr.jutsus_learned)
						if(genin_exam_participants.Find(src))
							if(!genin_exam_practical_score[src]) genin_exam_practical_score[src] = 1
							else genin_exam_practical_score[src]++

						usr.Bone_Sensation()

				if(usr.first=="dog"&&usr.second=="rat"&&usr.third=="rat"&&usr.rat==2&&usr.dog==1&&usr.ox==0&&usr.dragon==0&&usr.monkey==0&&usr.snake==0&&usr.horse==0&&usr.rabbit==0)
					var/obj/Jutsus/Curse_Dragon/J=new/obj/Jutsus/Curse_Dragon
					if(J.type in usr.jutsus_learned)
						if(genin_exam_participants.Find(src))
							if(!genin_exam_practical_score[src]) genin_exam_practical_score[src] = 1
							else genin_exam_practical_score[src]++

						usr.Curse_Dragon()

				if(usr.first=="dog"&&usr.second=="ox"&&usr.third=="dragon"&&usr.fourth=="ox"&&usr.rat==0&&usr.dog==1&&usr.ox==2&&usr.dragon==1&&usr.monkey==0&&usr.snake==0&&usr.horse==0&&usr.rabbit==0)
					var/obj/Jutsus/Kamui/J=new/obj/Jutsus/Kamui
					if(J.type in usr.jutsus_learned)
						if(genin_exam_participants.Find(src))
							if(!genin_exam_practical_score[src]) genin_exam_practical_score[src] = 1
							else genin_exam_practical_score[src]++

						usr.Kamui()

				if(usr.first=="rabbit"&&usr.rat==0&&usr.dog==0&&usr.ox==0&&usr.dragon==0&&usr.monkey==0&&usr.snake==0&&usr.horse==0&&usr.rabbit==1)
					var/obj/Jutsus/Flying_Thunder_God/J=new/obj/Jutsus/Flying_Thunder_God
					if(J.type in usr.jutsus_learned)
						if(genin_exam_participants.Find(src))
							if(!genin_exam_practical_score[src]) genin_exam_practical_score[src] = 1
							else genin_exam_practical_score[src]++

						usr.Flying_Thunder_God()

				if(usr.first=="dog"&&usr.second=="rat"&&usr.third=="rabbit"&&usr.rat==1&&usr.dog==1&&usr.ox==0&&usr.dragon==0&&usr.monkey==0&&usr.snake==0&&usr.horse==0&&usr.rabbit==1)
					var/obj/Jutsus/Flying_Thunder_God_Kunai/J=new/obj/Jutsus/Flying_Thunder_God_Kunai
					if(J.type in usr.jutsus_learned)
						if(genin_exam_participants.Find(src))
							if(!genin_exam_practical_score[src]) genin_exam_practical_score[src] = 1
							else genin_exam_practical_score[src]++

						usr.Flying_Thunder_God_Kunai()

				if(usr.first=="rabbit"&&usr.second=="dog"&&usr.third=="dog"&&usr.rat==0&&usr.dog==2&&usr.ox==0&&usr.dragon==0&&usr.monkey==0&&usr.snake==0&&usr.horse==0&&usr.rabbit==1)
					var/obj/Jutsus/Flying_Thunder_God_Great_Escape/J=new/obj/Jutsus/Flying_Thunder_God_Great_Escape
					if(J.type in usr.jutsus_learned)
						if(genin_exam_participants.Find(src))
							if(!genin_exam_practical_score[src]) genin_exam_practical_score[src] = 1
							else genin_exam_practical_score[src]++

						usr.Flying_Thunder_God_Great_Escape()

				if(usr.first=="rabbit"&&usr.second=="rabbit"&&usr.third=="monkey"&&usr.fourth=="monkey"&&usr.rat==0&&usr.dog==0&&usr.ox==0&&usr.dragon==0&&usr.monkey==2&&usr.snake==0&&usr.horse==0&&usr.rabbit==2)
					var/obj/Jutsus/LimbParalyzeSeal/J=new/obj/Jutsus/LimbParalyzeSeal
					if(J.type in usr.jutsus_learned)
						if(genin_exam_participants.Find(src))
							if(!genin_exam_practical_score[src]) genin_exam_practical_score[src] = 1
							else genin_exam_practical_score[src]++

						usr.LimbParalyzeSeal()

				if(usr.first=="rabbit"&&usr.second=="monkey"&&usr.third=="monkey"&&usr.fourth=="rabbit"&&usr.fifth=="monkey"&&usr.rat==0&&usr.dog==0&&usr.ox==0&&usr.dragon==0&&usr.monkey==3&&usr.snake==0&&usr.horse==0&&usr.rabbit==2)
					var/obj/Jutsus/Warp_Rasengan/J=new/obj/Jutsus/Warp_Rasengan
					if(J.type in usr.jutsus_learned)
						if(genin_exam_participants.Find(src))
							if(!genin_exam_practical_score[src]) genin_exam_practical_score[src] = 1
							else genin_exam_practical_score[src]++

						usr.Warp_Rasengan()

				if(usr.first=="rabbit"&&usr.second=="dog"&&usr.third=="monkey"&&usr.fourth=="rabbit"&&usr.rat==0&&usr.dog==1&&usr.ox==0&&usr.dragon==0&&usr.monkey==1&&usr.snake==0&&usr.horse==0&&usr.rabbit==2)
					var/obj/Jutsus/Sai_Rat/J=new/obj/Jutsus/Sai_Rat
					if(J.type in usr.jutsus_learned)
						if(genin_exam_participants.Find(src))
							if(!genin_exam_practical_score[src]) genin_exam_practical_score[src] = 1
							else genin_exam_practical_score[src]++

						usr.SaiRat()

				if(usr.first=="dog"&&usr.second=="rat"&&usr.third=="rat"&&usr.fourth=="dragon"&&usr.fifth=="dog"&&usr.rat==2&&usr.dog==2&&usr.ox==0&&usr.dragon==1&&usr.monkey==0&&usr.snake==0&&usr.horse==0&&usr.rabbit==0)
					var/obj/Jutsus/Snake_Release_Jutsu/J=new/obj/Jutsus/Snake_Release_Jutsu
					if(J.type in usr.jutsus_learned)
						if(genin_exam_participants.Find(src))
							if(!genin_exam_practical_score[src]) genin_exam_practical_score[src] = 1
							else genin_exam_practical_score[src]++

						usr.Snake_Release_Jutsu()

				if(usr.first=="dog"&&usr.second=="dog"&&usr.third=="rat"&&usr.fourth=="dragon"&&usr.fifth=="dragon"&&usr.rat==1&&usr.dog==2&&usr.ox==0&&usr.dragon==2&&usr.monkey==0&&usr.snake==0&&usr.horse==0&&usr.rabbit==0)
					var/obj/Jutsus/Sage_Bind/J=new/obj/Jutsus/Sage_Bind
					if(J.type in usr.jutsus_learned)
						if(genin_exam_participants.Find(src))
							if(!genin_exam_practical_score[src]) genin_exam_practical_score[src] = 1
							else genin_exam_practical_score[src]++

						usr.Sage_Bind()

				if(usr.first=="ox"&&usr.second=="rat"&&usr.third=="rat"&&usr.fourth=="ox"&&usr.rat==2&&usr.dog==0&&usr.ox==2&&usr.dragon==0&&usr.monkey==0&&usr.snake==0&&usr.horse==0&&usr.rabbit==0)
					var/obj/Jutsus/Snake_Skin_Replacement_Jutsu/J=new/obj/Jutsus/Snake_Skin_Replacement_Jutsu
					if(J.type in usr.jutsus_learned)
						if(genin_exam_participants.Find(src))
							if(!genin_exam_practical_score[src]) genin_exam_practical_score[src] = 1
							else genin_exam_practical_score[src]++

						usr.Snake_Skin_Replacement_Jutsu()

				if(usr.first=="dragon"&&usr.second=="horse"&&usr.third=="horse"&&usr.fourth=="dragon"&&usr.fifth=="dragon"&&usr.rat==0&&usr.dog==0&&usr.ox==0&&usr.dragon==3&&usr.monkey==0&&usr.snake==0&&usr.horse==2&&usr.rabbit==0)
					var/obj/Jutsus/Demon_Wind_Shuriken/J=new/obj/Jutsus/Demon_Wind_Shuriken
					if(J.type in usr.jutsus_learned)
						if(genin_exam_participants.Find(src))
							if(!genin_exam_practical_score[src]) genin_exam_practical_score[src] = 1
							else genin_exam_practical_score[src]++

						usr.Demon_Wind_Shuriken()

				if(usr.first=="dragon"&&usr.second=="horse"&&usr.third=="dragon"&&usr.fourth=="horse"&&usr.fifth=="rabbit"&&usr.rat==0&&usr.dog==0&&usr.ox==0&&usr.dragon==2&&usr.monkey==0&&usr.snake==0&&usr.horse==2&&usr.rabbit==1)
					var/obj/Jutsus/Blade_Hurricane/J=new/obj/Jutsus/Blade_Hurricane
					if(J.type in usr.jutsus_learned)
						if(genin_exam_participants.Find(src))
							if(!genin_exam_practical_score[src]) genin_exam_practical_score[src] = 1
							else genin_exam_practical_score[src]++

						usr.Blade_Hurricane()

				if(usr.first=="rabbit"&&usr.second=="horse"&&usr.third=="monkey"&&usr.fourth=="dragon"&&usr.rat==0&&usr.dog==0&&usr.ox==0&&usr.dragon==1&&usr.monkey==1&&usr.snake==0&&usr.horse==1&&usr.rabbit==1)
					var/obj/Jutsus/Snake_Rustle_Jutsu/J=new/obj/Jutsus/Snake_Rustle_Jutsu
					if(J.type in usr.jutsus_learned)
						if(genin_exam_participants.Find(src))
							if(!genin_exam_practical_score[src]) genin_exam_practical_score[src] = 1
							else genin_exam_practical_score[src]++

						usr.Snake_Rustle_Jutsu()

				if(usr.first=="rabbit"&&usr.second=="dragon"&&usr.third=="dog"&&usr.fourth=="monkey"&&usr.fifth=="rabbit"&&usr.rat==0&&usr.dog==1&&usr.ox==0&&usr.dragon==1&&usr.monkey==1&&usr.snake==0&&usr.horse==0&&usr.rabbit==2)
					var/obj/Jutsus/Sai_Snakes/J=new/obj/Jutsus/Sai_Snakes
					if(J.type in usr.jutsus_learned)
						if(genin_exam_participants.Find(src))
							if(!genin_exam_practical_score[src]) genin_exam_practical_score[src] = 1
							else genin_exam_practical_score[src]++

						usr.Sai_Snakes()

				if(usr.first=="rabbit"&&usr.second=="dog"&&usr.third=="snake"&&usr.fourth=="rabbit"&&usr.rat==0&&usr.dog==1&&usr.ox==0&&usr.dragon==0&&usr.monkey==0&&usr.snake==1&&usr.horse==0&&usr.rabbit==2)
					var/obj/Jutsus/Magma_Needles/J=new/obj/Jutsus/Magma_Needles
					if(J.type in usr.jutsus_learned)
						if(genin_exam_participants.Find(src))
							if(!genin_exam_practical_score[src]) genin_exam_practical_score[src] = 1
							else genin_exam_practical_score[src]++

						usr.Magma_Needles()

				if(usr.first=="rabbit"&&usr.second=="snake"&&usr.third=="dog"&&usr.fourth=="rat"&&usr.rat==1&&usr.dog==1&&usr.ox==0&&usr.dragon==0&&usr.monkey==0&&usr.snake==1&&usr.horse==0&&usr.rabbit==1)
					var/obj/Jutsus/Magma_Crush/J=new/obj/Jutsus/Magma_Crush
					if(J.type in usr.jutsus_learned)
						if(genin_exam_participants.Find(src))
							if(!genin_exam_practical_score[src]) genin_exam_practical_score[src] = 1
							else genin_exam_practical_score[src]++

						usr.Magma_Crush()

				if(usr.first=="dog"&&usr.second=="rat"&&usr.third=="dog"&&usr.fourth=="rat"&&usr.fifth=="dog"&&usr.sixth=="rat"&&usr.seventh=="dog"&&usr.rat==3&&usr.dog==4&&usr.ox==0&&usr.dragon==0&&usr.monkey==0&&usr.snake==0&&usr.horse==0&&usr.rabbit==0)
					var/obj/Jutsus/Wind_Dragon_Projectile/J=new/obj/Jutsus/Wind_Dragon_Projectile
					if(J.type in usr.jutsus_learned)
						if(genin_exam_participants.Find(src))
							if(!genin_exam_practical_score[src]) genin_exam_practical_score[src] = 1
							else genin_exam_practical_score[src]++

						usr.Wind_Dragon_Projectile()

				if(usr.first=="monkey"&&usr.second=="snake"&&usr.third=="ox"&&usr.fourth=="monkey"&&usr.rat==0&&usr.dog==0&&usr.ox==1&&usr.dragon==0&&usr.monkey==2&&usr.snake==1&&usr.horse==0&&usr.rabbit==0)
					var/obj/Jutsus/Shadow_Field/J=new/obj/Jutsus/Shadow_Field
					if(J.type in usr.jutsus_learned)
						if(genin_exam_participants.Find(src))
							if(!genin_exam_practical_score[src]) genin_exam_practical_score[src] = 1
							else genin_exam_practical_score[src]++

						usr.Shadow_Field()

				if(usr.first=="ox"&&usr.second=="rat"&&usr.third=="rat"&&usr.rat==2&&usr.dog==0&&usr.ox==1&&usr.dragon==0&&usr.monkey==0&&usr.snake==0&&usr.horse==0&&usr.rabbit==0)
					var/obj/Jutsus/Crow_Substitution/J=new/obj/Jutsus/Crow_Substitution
					if(J.type in usr.jutsus_learned)
						if(genin_exam_participants.Find(src))
							if(!genin_exam_practical_score[src]) genin_exam_practical_score[src] = 1
							else genin_exam_practical_score[src]++

						usr.Crow_Substitution()

				if(usr.first=="rabbit"&&usr.second=="rabbit"&&usr.third=="dragon"&&usr.fourth=="rabbit"&&usr.rat==0&&usr.dog==0&&usr.ox==0&&usr.dragon==1&&usr.monkey==0&&usr.snake==0&&usr.horse==0&&usr.rabbit==3)
					var/obj/Jutsus/Bubble_Barrage/J=new/obj/Jutsus/Bubble_Barrage
					if(J.type in usr.jutsus_learned)
						if(genin_exam_participants.Find(src))
							if(!genin_exam_practical_score[src]) genin_exam_practical_score[src] = 1
							else genin_exam_practical_score[src]++

						usr.BubbleBarrage()

				if(usr.first=="rabbit"&&usr.second=="rabbit"&&usr.third=="dragon"&&usr.fourth=="rabbit"&&usr.fifth=="dragon"&&usr.sixth=="rabbit"&&usr.seventh=="dragon"&&usr.eighth=="dragon"&&usr.rat==0&&usr.dog==0&&usr.ox==0&&usr.dragon==4&&usr.monkey==0&&usr.snake==0&&usr.horse==0&&usr.rabbit==4)
					var/obj/Jutsus/Bubble_Trouble/J=new/obj/Jutsus/Bubble_Trouble
					if(J.type in usr.jutsus_learned)
						if(genin_exam_participants.Find(src))
							if(!genin_exam_practical_score[src]) genin_exam_practical_score[src] = 1
							else genin_exam_practical_score[src]++

						usr.Bubble_Trouble()

				if(usr.first=="dog"&&usr.second=="dog"&&usr.third=="dragon"&&usr.fourth=="dog"&&usr.rat==0&&usr.dog==3&&usr.ox==0&&usr.dragon==1&&usr.monkey==0&&usr.snake==0&&usr.horse==0&&usr.rabbit==0)
					var/obj/Jutsus/Bubble_Spreader/J=new/obj/Jutsus/Bubble_Spreader
					if(J.type in usr.jutsus_learned)
						if(genin_exam_participants.Find(src))
							if(!genin_exam_practical_score[src]) genin_exam_practical_score[src] = 1
							else genin_exam_practical_score[src]++

						usr.BubbleSpreader()

				if(usr.first=="dog"&&usr.second=="dog"&&usr.third=="dog"&&usr.fourth=="dog"&&usr.rat==0&&usr.dog==4&&usr.ox==0&&usr.dragon==0&&usr.monkey==0&&usr.snake==0&&usr.horse==0&&usr.rabbit==0)
					var/obj/Jutsus/Bubble_Shield/J=new/obj/Jutsus/Bubble_Spreader
					if(J.type in usr.jutsus_learned)
						if(genin_exam_participants.Find(src))
							if(!genin_exam_practical_score[src]) genin_exam_practical_score[src] = 1
							else genin_exam_practical_score[src]++

						usr.Bubble_Shield()

				if(usr.first=="rabbit"&&usr.second=="dragon"&&usr.third=="dog"&&usr.fourth=="rabbit"&&usr.fifth=="dragon"&&usr.sixth=="dog"&&usr.rat==0&&usr.dog==2&&usr.ox==0&&usr.dragon==2&&usr.monkey==0&&usr.snake==0&&usr.horse==0&&usr.rabbit==2)
					var/obj/Jutsus/Ink_Lions/J=new/obj/Jutsus/Ink_Lions
					if(J.type in usr.jutsus_learned)
						if(genin_exam_participants.Find(src))
							if(!genin_exam_practical_score[src]) genin_exam_practical_score[src] = 1
							else genin_exam_practical_score[src]++

						usr.InkLions()

				if(usr.first=="ox"&&usr.second=="rabbit"&&usr.third=="dog"&&usr.fourth=="ox"&&usr.rat==0&&usr.dog==1&&usr.ox==2&&usr.dragon==0&&usr.monkey==0&&usr.snake==0&&usr.horse==0&&usr.rabbit==1)
					var/obj/Jutsus/Crystal_Mirrors/J=new/obj/Jutsus/Crystal_Mirrors
					if(J.type in usr.jutsus_learned)
						if(genin_exam_participants.Find(src))
							if(!genin_exam_practical_score[src]) genin_exam_practical_score[src] = 1
							else genin_exam_practical_score[src]++

						usr.Crystal_Mirrors()

				if(usr.first=="rabbit"&&usr.second=="rabbit"&&usr.third=="rabbit"&usr.fourth=="rabbit"&&usr.rat==0&&usr.dog==0&&usr.ox==0&&usr.dragon==0&&usr.monkey==0&&usr.snake==0&&usr.horse==0&&usr.rabbit==4)
					var/obj/Jutsus/MudWall/J=new/obj/Jutsus/MudWall
					if(J.type in usr.jutsus_learned)
						if(genin_exam_participants.Find(src))
							if(!genin_exam_practical_score[src]) genin_exam_practical_score[src] = 1
							else genin_exam_practical_score[src]++

						usr.MudWall()

				if(usr.first=="dragon"&&usr.second=="horse"&&usr.third=="dragon"&&usr.fourth=="horse"&&usr.rat==0&&usr.dog==0&&usr.ox==0&&usr.dragon==2&&usr.monkey==0&&usr.snake==0&&usr.horse==2&&usr.rabbit==0)
					var/obj/Jutsus/Weapon_Manipulation_Jutsu/J=new/obj/Jutsus/Weapon_Manipulation_Jutsu
					if(J.type in usr.jutsus_learned)
						if(genin_exam_participants.Find(src))
							if(!genin_exam_practical_score[src]) genin_exam_practical_score[src] = 1
							else genin_exam_practical_score[src]++

						usr.Weapon_Manipulation_Jutsu()

				if(usr.first=="dragon"&&usr.second=="snake"&&usr.third=="dragon"&&usr.rat==0&&usr.dog==0&&usr.ox==0&&usr.dragon==2&&usr.monkey==0&&usr.snake==1&&usr.horse==0&&usr.rabbit==0)
					var/obj/Jutsus/C1Snake/J=new/obj/Jutsus/C1Snake
					if(J.type in usr.jutsus_learned)
						if(genin_exam_participants.Find(src))
							if(!genin_exam_practical_score[src]) genin_exam_practical_score[src] = 1
							else genin_exam_practical_score[src]++

						usr.C1Snake()

				if(usr.first=="dragon"&&usr.second=="horse"&&usr.third=="dragon"&&usr.fourth=="horse"&&usr.fifth=="dragon"&&usr.sixth=="dragon"&&usr.rat==0&&usr.dog==0&&usr.ox==0&&usr.dragon==4&&usr.monkey==0&&usr.snake==0&&usr.horse==2&&usr.rabbit==0)
					var/obj/Jutsus/TwinDragons/J=new/obj/Jutsus/TwinDragons
					if(J.type in usr.jutsus_learned)
						if(genin_exam_participants.Find(src))
							if(!genin_exam_practical_score[src]) genin_exam_practical_score[src] = 1
							else genin_exam_practical_score[src]++

						usr.TwinDragons()

				if(usr.first=="rat"&&usr.second=="snake"&&usr.third=="dog"&&usr.rat==1&&usr.dog==1&&usr.ox==0&&usr.dragon==0&&usr.monkey==0&&usr.snake==1&&usr.horse==0&&usr.rabbit==0)
					var/obj/Jutsus/HiddenSnakeStab/J=new/obj/Jutsus/HiddenSnakeStab
					if(J.type in usr.jutsus_learned)
						if(genin_exam_participants.Find(src))
							if(!genin_exam_practical_score[src]) genin_exam_practical_score[src] = 1
							else genin_exam_practical_score[src]++

						usr.HiddenSnakeStab()

				if(usr.first=="dog"&&usr.second=="rabbit"&&usr.third=="ox"&&usr.rat==0&&usr.dog==1&&usr.ox==1&&usr.dragon==0&&usr.monkey==0&&usr.snake==0&&usr.horse==0&&usr.rabbit==1)
					var/obj/Jutsus/Root_Strangle/J=new/obj/Jutsus/Root_Strangle
					if(J.type in usr.jutsus_learned)
						if(genin_exam_participants.Find(src))
							if(!genin_exam_practical_score[src]) genin_exam_practical_score[src] = 1
							else genin_exam_practical_score[src]++

						usr.Root_Strangle()

				if(usr.first=="dog"&&usr.second=="rabbit"&&usr.third=="ox"&&usr.fourth=="dog"&&usr.rat==0&&usr.dog==2&&usr.ox==1&&usr.dragon==0&&usr.monkey==0&&usr.snake==0&&usr.horse==0&&usr.rabbit==1)
					var/obj/Jutsus/Wood_Balvan/J=new/obj/Jutsus/Wood_Balvan
					if(J.type in usr.jutsus_learned)
						if(genin_exam_participants.Find(src))
							if(!genin_exam_practical_score[src]) genin_exam_practical_score[src] = 1
							else genin_exam_practical_score[src]++

						usr.Wood_Balvan()

				if(usr.first=="dog"&&usr.second=="rabbit"&&usr.third=="ox"&&usr.fourth=="dog"&&usr.fifth=="dog"&&usr.rat==0&&usr.dog==3&&usr.ox==1&&usr.dragon==0&&usr.monkey==0&&usr.snake==0&&usr.horse==0&&usr.rabbit==1)
					var/obj/Jutsus/Root_Stab/J=new/obj/Jutsus/Root_Stab
					if(J.type in usr.jutsus_learned)
						if(genin_exam_participants.Find(src))
							if(!genin_exam_practical_score[src]) genin_exam_practical_score[src] = 1
							else genin_exam_practical_score[src]++

						usr.Root_Stab()

				if(usr.first=="ox"&&usr.second=="ox"&&usr.third=="dog"&&usr.fourth=="rabbit"&&usr.rat==0&&usr.dog==1&&usr.ox==2&&usr.dragon==0&&usr.monkey==0&&usr.snake==0&&usr.horse==0&&usr.rabbit==1)
					var/obj/Jutsus/Crystal_Pillar/J=new/obj/Jutsus/Crystal_Pillar
					if(J.type in usr.jutsus_learned)
						if(genin_exam_participants.Find(src))
							if(!genin_exam_practical_score[src]) genin_exam_practical_score[src] = 1
							else genin_exam_practical_score[src]++

						usr.Crystal_Pillar()

				if(usr.first=="ox"&&usr.second=="rabbit"&&usr.third=="dog"&&usr.fourth=="ox"&&usr.fifth=="ox"&&usr.sixth=="rabbit"&&usr.seventh=="dog"&&usr.eighth=="ox"&&usr.rat==0&&usr.dog==2&&usr.ox==4&&usr.dragon==0&&usr.monkey==0&&usr.snake==0&&usr.horse==0&&usr.rabbit==2)
					var/obj/Jutsus/Crystal_Arrow/J=new/obj/Jutsus/Crystal_Arrow
					if(J.type in usr.jutsus_learned)
						if(genin_exam_participants.Find(src))
							if(!genin_exam_practical_score[src]) genin_exam_practical_score[src] = 1
							else genin_exam_practical_score[src]++

						usr.Crystal_Arrow()

				if(usr.first=="rabbit"&&usr.second=="ox"&&usr.third=="rabbit"&&usr.fourth=="ox"&&usr.fifth=="rabbit"&&usr.sixth=="ox"&&usr.rat==0&&usr.dog==0&&usr.ox==3&&usr.dragon==0&&usr.monkey==0&&usr.snake==0&&usr.horse==0&&usr.rabbit==3)
					var/obj/Jutsus/Sage_Style_Giant_Rasengan/J=new/obj/Jutsus/Sage_Style_Giant_Rasengan
					if(J.type in usr.jutsus_learned)
						if(genin_exam_participants.Find(src))
							if(!genin_exam_practical_score[src]) genin_exam_practical_score[src] = 1
							else genin_exam_practical_score[src]++

						usr.Sage_Style_Giant_Rasengan()

				if(usr.first=="horse"&&usr.second=="rabbit"&&usr.third=="horse"&&usr.rat==0&&usr.dog==0&&usr.ox==0&&usr.dragon==0&&usr.monkey==0&&usr.snake==0&&usr.horse==2&&usr.rabbit==1)
					var/obj/Jutsus/Gedo_Revival/J=new/obj/Jutsus/Gedo_Revival
					if(J.type in usr.jutsus_learned)
						if(genin_exam_participants.Find(src))
							if(!genin_exam_practical_score[src]) genin_exam_practical_score[src] = 1
							else genin_exam_practical_score[src]++

						usr.Gedo_Revival()

				if(usr.first=="rabbit"&&usr.second=="snake"&&usr.third=="monkey"&&usr.fourth=="rabbit"&&usr.rat==0&&usr.dog==0&&usr.ox==0&&usr.dragon==0&&usr.monkey==1&&usr.snake==1&&usr.horse==0&&usr.rabbit==2)
					var/obj/Jutsus/Chidori_Nagashi/J=new/obj/Jutsus/Chidori_Nagashi
					if(J.type in usr.jutsus_learned)
						if(genin_exam_participants.Find(src))
							if(!genin_exam_practical_score[src]) genin_exam_practical_score[src] = 1
							else genin_exam_practical_score[src]++

						usr.Chidori_Nagashi()

				if(usr.first=="dragon"&&usr.second=="horse"&&usr.third=="dragon"&&usr.fourth=="horse"&&usr.fifth=="snake"&&usr.rat==0&&usr.dog==0&&usr.ox==0&&usr.dragon==2&&usr.monkey==0&&usr.snake==1&&usr.horse==2&&usr.rabbit==0)
					var/obj/Jutsus/Rising_Dragon/J=new/obj/Jutsus/Rising_Dragon
					if(J.type in usr.jutsus_learned)
						if(genin_exam_participants.Find(src))
							if(!genin_exam_practical_score[src]) genin_exam_practical_score[src] = 1
							else genin_exam_practical_score[src]++

						usr.Rising_Dragon()

				if(usr.first=="dog"&&usr.second=="dog"&&usr.third=="ox"&&usr.fourth=="rabbit"&&usr.rat==0&&usr.dog==2&&usr.ox==1&&usr.dragon==0&&usr.monkey==0&&usr.snake==0&&usr.horse==0&&usr.rabbit==1)
					var/obj/Jutsus/Dango/J=new/obj/Jutsus/Dango
					if(J.type in usr.jutsus_learned)
						usr.Dango()

				if(usr.first=="monkey"&&usr.second=="monkey"&&usr.third=="rabbit"&&usr.rat==0&&usr.dog==0&&usr.ox==0&&usr.dragon==0&&usr.monkey==2&&usr.snake==0&&usr.horse==0&&usr.rabbit==1)
					var/obj/Jutsus/Zankuuha/J=new/obj/Jutsus/Zankuuha
					if(J.type in usr.jutsus_learned)
						usr.Zankuuha()

				if(usr.first=="rat"&&usr.second=="dragon"&&usr.third=="rat"&&usr.fourth=="ox"&&usr.fifth=="snake"&&usr.rat==2&&usr.dog==0&&usr.ox==1&&usr.dragon==1&&usr.monkey==0&&usr.snake==1&&usr.horse==0&&usr.rabbit==0)
					var/obj/Jutsus/Teppoudama/J=new/obj/Jutsus/Teppoudama
					if(J.type in usr.jutsus_learned)
						usr.Teppoudama()

				if(usr.first=="ox"&&usr.second=="dragon"&&usr.third=="dragon"&&usr.fourth=="rat"&&usr.fifth=="rat"&&usr.rat==2&&usr.dog==0&&usr.ox==1&&usr.dragon==2&&usr.monkey==0&&usr.snake==0&&usr.horse==0&&usr.rabbit==0)
					var/obj/Jutsus/Suijinheki/J=new/obj/Jutsus/Suijinheki
					if(J.type in usr.jutsus_learned)
						usr.Suijinheki()

				if(usr.first=="dragon"&&usr.second=="rat"&&usr.third=="rat"&&usr.fourth=="rabbit"&&usr.rat==2&&usr.dog==0&&usr.ox==0&&usr.dragon==1&&usr.monkey==0&&usr.snake==0&&usr.horse==0&&usr.rabbit==1)
					var/obj/Jutsus/Daitoppa/J=new/obj/Jutsus/Daitoppa
					if(J.type in usr.jutsus_learned)
						usr.FuutonDaitoppa()

				if(usr.first=="dragon"&&usr.second=="snake"&&usr.third=="monkey"&&usr.rat==0&&usr.dog==0&&usr.ox==0&&usr.dragon==1&&usr.monkey==1&&usr.snake==1&&usr.horse==0&&usr.rabbit==0)
					var/obj/Jutsus/Doryuusou/J=new/obj/Jutsus/Doryuusou
					if(J.type in usr.jutsus_learned)
						usr.Doryuusou()

				if(usr.first=="rat"&&usr.second=="rat"&&usr.third=="snake"&&usr.fourth=="rabbit"&&usr.rat==2&&usr.dog==0&&usr.ox==0&&usr.dragon==0&&usr.monkey==0&&usr.snake==1&&usr.horse==0&&usr.rabbit==1)
					var/obj/Jutsus/JubakuEisou/J=new/obj/Jutsus/JubakuEisou
					if(J.type in usr.jutsus_learned)
						usr.JubakuEisou()

				if(usr.first=="rat"&&usr.second=="rat"&&usr.third=="snake"&&usr.fourth=="rabbit"&&usr.fifth=="rabbit"&&usr.rat==2&&usr.dog==0&&usr.ox==0&&usr.dragon==0&&usr.monkey==0&&usr.snake==1&&usr.horse==0&&usr.rabbit==2)
					var/obj/Jutsus/Daijurin/J=new/obj/Jutsus/Daijurin
					if(J.type in usr.jutsus_learned)
						usr.Daijurin()

				if(usr.first=="rabbit"&&usr.second=="snake"&&usr.third=="horse"&&usr.fourth=="rabbit"&&usr.fifth=="rat"&&usr.rat==1&&usr.dog==0&&usr.ox==0&&usr.dragon==0&&usr.monkey==0&&usr.snake==1&&usr.horse==1&&usr.rabbit==2)
					var/obj/Jutsus/Soul_Devastator_Seal/J=new/obj/Jutsus/Soul_Devastator_Seal
					if(J.type in usr.jutsus_learned)
						if(genin_exam_participants.Find(src))
							if(!genin_exam_practical_score[src]) genin_exam_practical_score[src] = 1
							else genin_exam_practical_score[src]++

						usr.Soul_Devastator_Seal()

				if(usr.first=="rabbit"&&usr.second=="dog"&&usr.third=="dog"&&usr.fourth=="rabbit"&&usr.rat==0&&usr.dog==2&&usr.ox==0&&usr.dragon==0&&usr.monkey==0&&usr.snake==0&&usr.horse==0&&usr.rabbit==2)
					var/obj/Jutsus/Iceball/J=new/obj/Jutsus/Iceball
					if(J.type in usr.jutsus_learned)
						if(genin_exam_participants.Find(src))
							if(!genin_exam_practical_score[src]) genin_exam_practical_score[src] = 1
							else genin_exam_practical_score[src]++

						usr.Iceball()

				if(usr.first=="dog"&&usr.second=="dog"&&usr.third=="rabbit"&&usr.rat==0&&usr.dog==2&&usr.ox==0&&usr.dragon==0&&usr.monkey==0&&usr.snake==0&&usr.horse==0&&usr.rabbit==1)
					var/obj/Jutsus/Ice_Explosion/J=new/obj/Jutsus/Ice_Explosion
					if(J.type in usr.jutsus_learned)
						if(genin_exam_participants.Find(src))
							if(!genin_exam_practical_score[src]) genin_exam_practical_score[src] = 1
							else genin_exam_practical_score[src]++

						usr.Ice_Explosion()

				if(usr.first=="dog"&&usr.second=="dog"&&usr.third=="dog"&&usr.fourth=="ox"&&usr.rat==0&&usr.dog==3&&usr.ox==1&&usr.dragon==0&&usr.monkey==0&&usr.snake==0&&usr.horse==0&&usr.rabbit==0)
					var/obj/Jutsus/WoodStyleFortress/J=new/obj/Jutsus/WoodStyleFortress
					if(J.type in usr.jutsus_learned)
						if(genin_exam_participants.Find(src))
							if(!genin_exam_practical_score[src]) genin_exam_practical_score[src] = 1
							else genin_exam_practical_score[src]++

						usr.WoodStyleFortress()

				if(usr.first=="ox"&&usr.second=="ox"&&usr.third=="dragon"&&usr.fourth=="ox"&&usr.rat==0&&usr.dog==0&&usr.ox==3&&usr.dragon==1&&usr.monkey==0&&usr.snake==0&&usr.horse==0&&usr.rabbit==0)
					var/obj/Jutsus/CalorieControl/J=new/obj/Jutsus/CalorieControl
					if(J.type in usr.jutsus_learned)
						if(genin_exam_participants.Find(src))
							if(!genin_exam_practical_score[src]) genin_exam_practical_score[src] = 1
							else genin_exam_practical_score[src]++

						usr.CalorieControl()

				if(usr.first=="ox"&&usr.second=="rabbit"&&usr.third=="dog"&&usr.rat==0&&usr.dog==1&&usr.ox==1&&usr.dragon==0&&usr.monkey==0&&usr.snake==0&&usr.horse==0&&usr.rabbit==1)
					var/obj/Jutsus/Crystal_Shards/J=new/obj/Jutsus/Crystal_Shards
					if(J.type in usr.jutsus_learned)
						if(genin_exam_participants.Find(src))
							if(!genin_exam_practical_score[src]) genin_exam_practical_score[src] = 1
							else genin_exam_practical_score[src]++

						usr.Crystal_Shards()

				if(usr.first=="dog"&&usr.second=="rabbit"&&usr.third=="rabbit"&&usr.fourth=="dog"&&usr.rat==0&&usr.dog==2&&usr.ox==0&&usr.dragon==0&&usr.monkey==0&&usr.snake==0&&usr.horse==0&&usr.rabbit==2)
					var/obj/Jutsus/Crystal_Needles/J=new/obj/Jutsus/Crystal_Needles
					if(J.type in usr.jutsus_learned)
						if(genin_exam_participants.Find(src))
							if(!genin_exam_practical_score[src]) genin_exam_practical_score[src] = 1
							else genin_exam_practical_score[src]++

						usr.Crystal_Needles()

				if(usr.first=="rabbit"&&usr.second=="dog"&&usr.third=="dog"&&usr.fourth=="ox"&&usr.rat==0&&usr.dog==2&&usr.ox==1&&usr.dragon==0&&usr.monkey==0&&usr.snake==0&&usr.horse==0&&usr.rabbit==1)
					var/obj/Jutsus/Crystal_Spikes/J=new/obj/Jutsus/Crystal_Spikes
					if(J.type in usr.jutsus_learned)
						if(genin_exam_participants.Find(src))
							if(!genin_exam_practical_score[src]) genin_exam_practical_score[src] = 1
							else genin_exam_practical_score[src]++

						usr.Crystal_Spikes()

				if(usr.first=="rabbit"&&usr.second=="rabbit"&&usr.third=="ox"&&usr.fourth=="dog"&&usr.fifth=="dog"&&usr.rat==0&&usr.dog==2&&usr.ox==1&&usr.dragon==0&&usr.monkey==0&&usr.snake==0&&usr.horse==0&&usr.rabbit==2)
					var/obj/Jutsus/Crystal_Explosion/J=new/obj/Jutsus/Crystal_Explosion
					if(J.type in usr.jutsus_learned)
						if(genin_exam_participants.Find(src))
							if(!genin_exam_practical_score[src]) genin_exam_practical_score[src] = 1
							else genin_exam_practical_score[src]++

						usr.Crystal_Explosion()

				if(usr.first=="rabbit"&&usr.second=="rabbit"&&usr.third=="rabbit"&&usr.fourth=="snake"&&usr.rat==0&&usr.dog==0&&usr.ox==0&&usr.dragon==0&&usr.monkey==0&&usr.snake==1&&usr.horse==0&&usr.rabbit==3)
					var/obj/Jutsus/EarthBoulder/J=new/obj/Jutsus/EarthBoulder
					if(J.type in usr.jutsus_learned)
						if(genin_exam_participants.Find(src))
							if(!genin_exam_practical_score[src]) genin_exam_practical_score[src] = 1
							else genin_exam_practical_score[src]++

						usr.EarthBoulder()

				if(usr.first=="rabbit"&&usr.second=="snake"&&usr.third=="monkey"&&usr.fourth=="rabbit"&&usr.fifth=="snake"&&usr.rat==0&&usr.dog==0&&usr.ox==0&&usr.dragon==0&&usr.monkey==1&&usr.snake==2&&usr.horse==0&&usr.rabbit==2)
					var/obj/Jutsus/Wind_Tornados/J=new/obj/Jutsus/Wind_Tornados
					if(J.type in usr.jutsus_learned)
						if(genin_exam_participants.Find(src))
							if(!genin_exam_practical_score[src]) genin_exam_practical_score[src] = 1
							else genin_exam_practical_score[src]++

						usr.Wind_Tornados()

				if(usr.first=="dog"&&usr.second=="snake"&&usr.rat==0&&usr.dog==1&&usr.ox==0&&usr.dragon==0&&usr.monkey==0&&usr.snake==1&&usr.horse==0&&usr.rabbit==0)
					var/obj/Jutsus/FireMask/J=new/obj/Jutsus/FireMask
					if(J.type in usr.jutsus_learned)
						if(genin_exam_participants.Find(src))
							if(!genin_exam_practical_score[src]) genin_exam_practical_score[src] = 1
							else genin_exam_practical_score[src]++

						usr.FireMask()

				if(usr.first=="ox"&&usr.second=="snake"&&usr.rat==0&&usr.dog==0&&usr.ox==1&&usr.dragon==0&&usr.monkey==0&&usr.snake==1&&usr.horse==0&&usr.rabbit==0)
					var/obj/Jutsus/WindMask/J=new/obj/Jutsus/WindMask
					if(J.type in usr.jutsus_learned)
						if(genin_exam_participants.Find(src))
							if(!genin_exam_practical_score[src]) genin_exam_practical_score[src] = 1
							else genin_exam_practical_score[src]++

						usr.WindMask()

				if(usr.first=="dog"&&usr.second=="rabbit"&&usr.rat==0&&usr.dog==1&&usr.ox==0&&usr.dragon==0&&usr.monkey==0&&usr.snake==0&&usr.horse==0&&usr.rabbit==1)
					var/obj/Jutsus/LightningMask/J=new/obj/Jutsus/LightningMask
					if(J.type in usr.jutsus_learned)
						if(genin_exam_participants.Find(src))
							if(!genin_exam_practical_score[src]) genin_exam_practical_score[src] = 1
							else genin_exam_practical_score[src]++

						usr.LightningMask()

				if(usr.first=="dragon"&&usr.second=="rabbit"&&usr.rat==0&&usr.dog==0&&usr.ox==0&&usr.dragon==1&&usr.monkey==0&&usr.snake==0&&usr.horse==0&&usr.rabbit==1)
					var/obj/Jutsus/EarthMask/J=new/obj/Jutsus/EarthMask
					if(J.type in usr.jutsus_learned)
						if(genin_exam_participants.Find(src))
							if(!genin_exam_practical_score[src]) genin_exam_practical_score[src] = 1
							else genin_exam_practical_score[src]++

						usr.EarthMask()

				if(usr.first=="dragon"&&usr.second=="snake"&&usr.third=="snake"&&usr.fourth=="dragon"&&usr.fifth=="dragon"&&usr.rat==0&&usr.dog==0&&usr.ox==0&&usr.dragon==3&&usr.monkey==0&&usr.snake==2&&usr.horse==0&&usr.rabbit==0)
					var/obj/Jutsus/BugTornado/J=new/obj/Jutsus/BugTornado
					if(J.type in usr.jutsus_learned)
						if(genin_exam_participants.Find(src))
							if(!genin_exam_practical_score[src]) genin_exam_practical_score[src] = 1
							else genin_exam_practical_score[src]++

						usr.BugTornado()

				if(usr.first=="ox"&&usr.second=="monkey"&&usr.third=="dragon"&&usr.fourth=="dog"&&usr.fifth=="rat"&&usr.sixth=="ox"&&usr.seventh=="rabbit"&&usr.rat==1&&usr.dog==1&&usr.ox==2&&usr.dragon==1&&usr.monkey==1&&usr.snake==0&&usr.horse==0&&usr.rabbit==1)
					var/obj/Jutsus/Dust_Particle_Prison/J=new/obj/Jutsus/Dust_Particle_Prison
					if(J.type in usr.jutsus_learned)
						if(genin_exam_participants.Find(src))
							if(!genin_exam_practical_score[src]) genin_exam_practical_score[src] = 1
							else genin_exam_practical_score[src]++

						usr.Dust_Particle_Prison()

				if(usr.first=="ox"&&usr.second=="monkey"&&usr.third=="dragon"&&usr.rat==0&&usr.dog==0&&usr.ox==1&&usr.dragon==1&&usr.monkey==1&&usr.snake==0&&usr.horse==0&&usr.rabbit==0)
					var/obj/Jutsus/Dust_Particle_Prison_Beam/J=new/obj/Jutsus/Dust_Particle_Prison_Beam
					if(J.type in usr.jutsus_learned)
						if(genin_exam_participants.Find(src))
							if(!genin_exam_practical_score[src]) genin_exam_practical_score[src] = 1
							else genin_exam_practical_score[src]++

						usr.Dust_Particle_Prison_Beam()
						//InkBird

				if(usr.first=="dragon"&&usr.second=="rabbit"&&usr.third=="monkey"&&usr.fourth=="dog"&&usr.fifth=="dragon"&&usr.sixth=="rabbit"&&usr.seventh=="dog"&&usr.eighth=="dog"&&usr.rat==0&&usr.dog==3&&usr.ox==0&&usr.dragon==2&&usr.monkey==1&&usr.snake==0&&usr.horse==0&&usr.rabbit==2)
					var/obj/Jutsus/Ultimate_Ink_Bird/J=new/obj/Jutsus/Ultimate_Ink_Bird
					if(J.type in usr.jutsus_learned)
						if(genin_exam_participants.Find(src))
							if(!genin_exam_practical_score[src]) genin_exam_practical_score[src] = 1
							else genin_exam_practical_score[src]++

						usr.Ultimate_Ink_Bird()
						//1stPupp

				if(usr.first=="rabbit"&&usr.second=="rabbit"&&usr.third=="snake"&&usr.rat==0&&usr.dog==0&&usr.ox==0&&usr.dragon==0&&usr.monkey==0&&usr.snake==1&&usr.horse==0&&usr.rabbit==2)
					var/obj/Jutsus/First_Puppet_Summoning/J=new/obj/Jutsus/First_Puppet_Summoning
					if(J.type in usr.jutsus_learned)
						if(genin_exam_participants.Find(src))
							if(!genin_exam_practical_score[src]) genin_exam_practical_score[src] = 1
							else genin_exam_practical_score[src]++

						usr.First_Puppet_Summoning()
						//2ndPupp

				if(usr.first=="rabbit"&&usr.second=="snake"&&usr.third=="snake"&&usr.rat==0&&usr.dog==0&&usr.ox==0&&usr.dragon==0&&usr.monkey==0&&usr.snake==2&&usr.horse==0&&usr.rabbit==1)
					var/obj/Jutsus/Second_Puppet_Summoning/J=new/obj/Jutsus/Second_Puppet_Summoning
					if(J.type in usr.jutsus_learned)
						if(genin_exam_participants.Find(src))
							if(!genin_exam_practical_score[src]) genin_exam_practical_score[src] = 1
							else genin_exam_practical_score[src]++

						usr.Second_Puppet_Summoning()
						//kazePupp

				if(usr.first=="snake"&&usr.second=="rabbit"&&usr.third=="rat"&&usr.fourth=="rabbit"&&usr.fifth=="snake"&&usr.sixth=="ox"&&usr.rat==1&&usr.dog==0&&usr.ox==1&&usr.dragon==0&&usr.monkey==0&&usr.snake==2&&usr.horse==0&&usr.rabbit==2)
					var/obj/Jutsus/Summon_Kazekage_Puppet/J=new/obj/Jutsus/Summon_Kazekage_Puppet
					if(J.type in usr.jutsus_learned)
						if(genin_exam_participants.Find(src))
							if(!genin_exam_practical_score[src]) genin_exam_practical_score[src] = 1
							else genin_exam_practical_score[src]++

						usr.Summon_Kazekage_Puppet()
						//1000yrs

				if(usr.first=="monkey"&&usr.rat==0&&usr.dog==0&&usr.ox==0&&usr.dragon==0&&usr.monkey==1&&usr.snake==0&&usr.horse==0&&usr.rabbit==0)
					var/obj/Jutsus/One_Thousand_Years_of_Death/J=new/obj/Jutsus/One_Thousand_Years_of_Death
					if(J.type in usr.jutsus_learned)
						if(genin_exam_participants.Find(src))
							if(!genin_exam_practical_score[src]) genin_exam_practical_score[src] = 1
							else genin_exam_practical_score[src]++

						usr.One_Thousand_Years_of_Death()
						//spidersumm

				if(usr.first=="ox"&&usr.second=="horse"&&usr.third=="horse"&&usr.fourth=="dog"&&usr.fifth=="ox"&&usr.sixth=="horse"&&usr.rat==0&&usr.dog==1&&usr.ox==2&&usr.dragon==0&&usr.monkey==0&&usr.snake==0&&usr.horse==3&&usr.rabbit==0)
					var/obj/Jutsus/Summon_Spider/J=new/obj/Jutsus/Summon_Spider
					if(J.type in usr.jutsus_learned)
						if(genin_exam_participants.Find(src))
							if(!genin_exam_practical_score[src]) genin_exam_practical_score[src] = 1
							else genin_exam_practical_score[src]++

						usr.Summon_Spider()
						//snakesum

				if(usr.first=="rat"&&usr.second=="horse"&&usr.third=="rat"&&usr.fourth=="dog"&&usr.fifth=="ox"&&usr.rat==2&&usr.dog==1&&usr.ox==1&&usr.dragon==0&&usr.monkey==0&&usr.snake==0&&usr.horse==1&&usr.rabbit==0)
					var/obj/Jutsus/Snake_Summoning/J=new/obj/Jutsus/Snake_Summoning
					if(J.type in usr.jutsus_learned)
						if(genin_exam_participants.Find(src))
							if(!genin_exam_practical_score[src]) genin_exam_practical_score[src] = 1
							else genin_exam_practical_score[src]++

						usr.Summoning_Snake()
						//dogsum

				if(usr.first=="rat"&&usr.second=="horse"&&usr.third=="rat"&&usr.fourth=="dog"&&usr.fifth=="dog"&&usr.rat==2&&usr.dog==2&&usr.ox==0&&usr.dragon==0&&usr.monkey==0&&usr.snake==0&&usr.horse==1&&usr.rabbit==0)
					var/obj/Jutsus/Dog_Summoning/J=new/obj/Jutsus/Dog_Summoning
					if(J.type in usr.jutsus_learned)
						if(genin_exam_participants.Find(src))
							if(!genin_exam_practical_score[src]) genin_exam_practical_score[src] = 1
							else genin_exam_practical_score[src]++

						usr.Summoning_Dog()
						//angelwing

				if(usr.first=="rat"&&usr.second=="ox"&&usr.third=="ox"&&usr.fourth=="rat"&&usr.rat==2&&usr.dog==0&&usr.ox==2&&usr.dragon==0&&usr.monkey==0&&usr.snake==0&&usr.horse==0&&usr.rabbit==0)
					var/obj/Jutsus/Angel_Wings/J=new/obj/Jutsus/Angel_Wings
					if(J.type in usr.jutsus_learned)
						if(genin_exam_participants.Find(src))
							if(!genin_exam_practical_score[src]) genin_exam_practical_score[src] = 1
							else genin_exam_practical_score[src]++

						usr.Angel_Wings()
						//paperchak

				if(usr.first=="ox"&&usr.second=="rat"&&usr.rat==1&&usr.dog==0&&usr.ox==1&&usr.dragon==0&&usr.monkey==0&&usr.snake==0&&usr.horse==0&&usr.rabbit==0)
					var/obj/Jutsus/Paper_Chakram/J=new/obj/Jutsus/Paper_Chakram
					if(J.type in usr.jutsus_learned)
						if(genin_exam_participants.Find(src))
							if(!genin_exam_practical_score[src]) genin_exam_practical_score[src] = 1
							else genin_exam_practical_score[src]++

						usr.Paper_Chakram()
						//reaper

				if(usr.first=="dragon"&&usr.second=="rat"&&usr.third=="rabbit"&&usr.fourth=="dragon"&&usr.fifth=="rabbit"&&usr.sixth=="rabbit"&&usr.seventh=="rat"&&usr.rat==2&&usr.dog==0&&usr.ox==0&&usr.dragon==2&&usr.monkey==0&&usr.snake==0&&usr.horse==0&&usr.rabbit==3)
					var/obj/Jutsus/Reaper_Death_Seal/J=new/obj/Jutsus/Reaper_Death_Seal
					if(J.type in usr.jutsus_learned)
						if(genin_exam_participants.Find(src))
							if(!genin_exam_practical_score[src]) genin_exam_practical_score[src] = 1
							else genin_exam_practical_score[src]++

						usr.Reaper_Death_Seal()
						//terror

				if(usr.first=="monkey"&&usr.second=="rabbit"&&usr.third=="rabbit"&&usr.fourth=="monkey"&&usr.rat==0&&usr.dog==0&&usr.ox==0&&usr.dragon==0&&usr.monkey==2&&usr.snake==0&&usr.horse==0&&usr.rabbit==2)
					var/obj/Jutsus/Seal_of_Terror/J=new/obj/Jutsus/Seal_of_Terror
					if(J.type in usr.jutsus_learned)
						if(genin_exam_participants.Find(src))
							if(!genin_exam_practical_score[src]) genin_exam_practical_score[src] = 1
							else genin_exam_practical_score[src]++

						usr.Seal_of_Terror()
						//windcutt

				if(usr.first=="snake"&&usr.second=="rabbit"&&usr.third=="rabbit"&&usr.fourth=="snake"&&usr.rat==0&&usr.dog==0&&usr.ox==0&&usr.dragon==0&&usr.monkey==0&&usr.snake==2&&usr.horse==0&&usr.rabbit==2)
					var/obj/Jutsus/Wind_Cutter/J=new/obj/Jutsus/Wind_Cutter
					if(J.type in usr.jutsus_learned)
						if(genin_exam_participants.Find(src))
							if(!genin_exam_practical_score[src]) genin_exam_practical_score[src] = 1
							else genin_exam_practical_score[src]++

						usr.Wind_Cutter()
						//LightningBalls

				if(usr.first=="snake"&&usr.second=="rabbit"&&usr.third=="rabbit"&&usr.rat==0&&usr.dog==0&&usr.ox==0&&usr.dragon==0&&usr.monkey==0&&usr.snake==1&&usr.horse==0&&usr.rabbit==2)
					var/obj/Jutsus/Lightning_Balls/J=new/obj/Jutsus/Lightning_Balls
					if(J.type in usr.jutsus_learned)
						if(genin_exam_participants.Find(src))
							if(!genin_exam_practical_score[src]) genin_exam_practical_score[src] = 1
							else genin_exam_practical_score[src]++

						usr.LightningBalls()
						//omegaice

				if(usr.first=="rabbit"&&usr.second=="dog"&&usr.third=="dog"&&usr.fourth=="rabbit"&&usr.fifth=="dog"&&usr.sixth=="dog"&&usr.seventh=="rabbit"&&usr.rat==0&&usr.dog==4&&usr.ox==0&&usr.dragon==0&&usr.monkey==0&&usr.snake==0&&usr.horse==0&&usr.rabbit==3)
					var/obj/Jutsus/Omega_Ice_Ball/J=new/obj/Jutsus/Omega_Ice_Ball
					if(J.type in usr.jutsus_learned)
						if(genin_exam_participants.Find(src))
							if(!genin_exam_practical_score[src]) genin_exam_practical_score[src] = 1
							else genin_exam_practical_score[src]++

						usr.Omega_Ice_Ball()
				
				if(usr.first=="snake"&&usr.second=="horse"&&usr.third=="dog"&&usr.rat==0&&usr.dog==1&&usr.ox==0&&usr.dragon==0&&usr.monkey==0&&usr.snake==1&&usr.horse==1&&usr.rabbit==0)
					var/obj/Jutsus/Black_Iron_Fists/J=new/obj/Jutsus/Black_Iron_Fists
					if(J.type in usr.jutsus_learned)
						if(genin_exam_participants.Find(src))
							if(!genin_exam_practical_score[src]) genin_exam_practical_score[src] = 1
							else genin_exam_practical_score[src]++

						usr.Black_Iron_Fists()

				if(usr.first=="snake"&&usr.second=="horse"&&usr.third=="dog"&&usr.fourth=="rabbit"&&usr.fifth=="rabbit"&&usr.sixth=="dog"&&usr.rat==0&&usr.dog==2&&usr.ox==0&&usr.dragon==0&&usr.monkey==0&&usr.snake==1&&usr.horse==1&&usr.rabbit==2)
					var/obj/Jutsus/Gathering_Assault_Pyramid/J=new/obj/Jutsus/Gathering_Assault_Pyramid
					if(J.type in usr.jutsus_learned)
						if(genin_exam_participants.Find(src))
							if(!genin_exam_practical_score[src]) genin_exam_practical_score[src] = 1
							else genin_exam_practical_score[src]++

						usr.Gathering_Assault_Pyramid()

				if(usr.SealCount)
					src.PlayAudio('active.wav', output = AUDIO_HEARERS)
					usr.SealVarReset()
					usr.Target_ReAdd()