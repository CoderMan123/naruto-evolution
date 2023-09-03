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
								usr.sbought+=src.name
								var/obj/Jutsus/jutsu=new src.type
								usr.jutsus += jutsu
								usr.jutsus_learned += jutsu.type
								jutsu.owner=usr.ckey

							else
								// If he is evolving his sharingan.
								if(src.sharin >= 2)
									var/obj/Jutsus/jutsu=new src.type
									usr.jutsus_learned += jutsu.type
									usr.sbought+=src.name
									for(var/obj/Jutsus/Sharingan/SH in usr.jutsus)
										var/os = SH.icon_state
										SH.icon_state = src.icon_state
										SH.mouse_drag_pointer = src.mouse_drag_pointer
										SH.name = src.name

										// Declare the new image in right position.
										var/image/I = image(src, src.icon_state)
										I.pixel_x = 12
										I.pixel_y = -1

										if(usr.HotSlotSave["HotSlot1"]==os)
											for(var/obj/HotSlots/HotSlot1/H in usr.client.screen)
												var/obj/h=H
												h.overlays=null
												h.overlays+=I
												usr.HotSlotSave["HotSlot1"]="[src.icon_state]"
												usr.hotslot1=src.name
												h.SetName("[usr.client.hotkey_hotslot1]")
										if(usr.HotSlotSave["HotSlot2"]==os)
											for(var/obj/HotSlots/HotSlot2/H in usr.client.screen)
												var/obj/h=H
												h.overlays=null
												h.overlays+=I
												usr.HotSlotSave["HotSlot2"]="[src.icon_state]"
												usr.hotslot2=src.name
												h.SetName("[usr.client.hotkey_hotslot2]")
										if(usr.HotSlotSave["HotSlot3"]==os)
											for(var/obj/HotSlots/HotSlot3/H in usr.client.screen)
												var/obj/h=H
												h.overlays=null
												h.overlays+=I
												usr.HotSlotSave["HotSlot3"]="[src.icon_state]"
												usr.hotslot3=src.name
												h.SetName("[usr.client.hotkey_hotslot3]")
										if(usr.HotSlotSave["HotSlot4"]==os)
											for(var/obj/HotSlots/HotSlot4/H in usr.client.screen)
												var/obj/h=H
												h.overlays=null
												h.overlays+=I
												usr.HotSlotSave["HotSlot4"]="[src.icon_state]"
												usr.hotslot4=src.name
												h.SetName("[usr.client.hotkey_hotslot4]")
										if(usr.HotSlotSave["HotSlot5"]==os)
											for(var/obj/HotSlots/HotSlot5/H in usr.client.screen)
												var/obj/h=H
												h.overlays=null
												h.overlays+=I
												usr.HotSlotSave["HotSlot5"]="[src.icon_state]"
												usr.hotslot5=src.name
												h.SetName("[usr.client.hotkey_hotslot5]")
										if(usr.HotSlotSave["HotSlot6"]==os)
											for(var/obj/HotSlots/HotSlot6/H in usr.client.screen)
												var/obj/h=H
												h.overlays=null
												h.overlays+=I
												usr.HotSlotSave["HotSlot6"]="[src.icon_state]"
												usr.hotslot6=src.name
												h.SetName("[usr.client.hotkey_hotslot6]")
										if(usr.HotSlotSave["HotSlot7"]==os)
											for(var/obj/HotSlots/HotSlot7/H in usr.client.screen)
												var/obj/h=H
												h.overlays=null
												h.overlays+=I
												usr.HotSlotSave["HotSlot7"]="[src.icon_state]"
												usr.hotslot7=src.name
												h.SetName("[usr.client.hotkey_hotslot7]")
										if(usr.HotSlotSave["HotSlot8"]==os)
											for(var/obj/HotSlots/HotSlot8/H in usr.client.screen)
												var/obj/h=H
												h.overlays=null
												h.overlays+=I
												usr.HotSlotSave["HotSlot8"]="[src.icon_state]"
												usr.hotslot8=src.name
												h.SetName("[usr.client.hotkey_hotslot8]")
										if(usr.HotSlotSave["HotSlot9"]==os)
											for(var/obj/HotSlots/HotSlot9/H in usr.client.screen)
												var/obj/h=H
												h.overlays=null
												h.overlays+=I
												usr.HotSlotSave["HotSlot9"]="[src.icon_state]"
												usr.hotslot9=src.name
												h.SetName("[usr.client.hotkey_hotslot9]")
										if(usr.HotSlotSave["HotSlot10"]==os)
											for(var/obj/HotSlots/HotSlot10/H in usr.client.screen)
												var/obj/h=H
												h.overlays=null
												h.overlays+=I
												usr.HotSlotSave["HotSlot10"]="[src.icon_state]"
												usr.hotslot10=src.name
												h.SetName("[usr.client.hotkey_hotslot10]")
										if(usr.HotSlotSave["HotSlot11"]==os)
											for(var/obj/HotSlots/HotSlot11/H in usr.client.screen)
												var/obj/h=H
												h.overlays=null
												h.overlays+=I
												usr.HotSlotSave["HotSlot11"]="[src.icon_state]"
												usr.hotslot10=src.name
												h.SetName("[usr.client.hotkey_hotslot11]")
										if(usr.HotSlotSave["HotSlot12"]==os)
											for(var/obj/HotSlots/HotSlot12/H in usr.client.screen)
												var/obj/h=H
												h.overlays=null
												h.overlays+=I
												usr.HotSlotSave["HotSlot12"]="[src.icon_state]"
												usr.hotslot10=src.name
												h.SetName("[usr.client.hotkey_hotslot12]")
										if(usr.HotSlotSave["HotSlot13"]==os)
											for(var/obj/HotSlots/HotSlot13/H in usr.client.screen)
												var/obj/h=H
												h.overlays=null
												h.overlays+=I
												usr.HotSlotSave["HotSlot13"]="[src.icon_state]"
												usr.hotslot10=src.name
												h.SetName("[usr.client.hotkey_hotslot13]")
										if(usr.HotSlotSave["HotSlot14"]==os)
											for(var/obj/HotSlots/HotSlot14/H in usr.client.screen)
												var/obj/h=H
												h.overlays=null
												h.overlays+=I
												usr.HotSlotSave["HotSlot14"]="[src.icon_state]"
												usr.hotslot10=src.name
												h.SetName("[usr.client.hotkey_hotslot14]")
										if(usr.HotSlotSave["HotSlot15"]==os)
											for(var/obj/HotSlots/HotSlot15/H in usr.client.screen)
												var/obj/h=H
												h.overlays=null
												h.overlays+=I
												usr.HotSlotSave["HotSlot15"]="[src.icon_state]"
												usr.hotslot10=src.name
												h.SetName("[usr.client.hotkey_hotslot15]")
										if(usr.HotSlotSave["HotSlot16"]==os)
											for(var/obj/HotSlots/HotSlot16/H in usr.client.screen)
												var/obj/h=H
												h.overlays=null
												h.overlays+=I
												usr.HotSlotSave["HotSlot16"]="[src.icon_state]"
												usr.hotslot10=src.name
												h.SetName("[usr.client.hotkey_hotslot16]")
										if(usr.HotSlotSave["HotSlot17"]==os)
											for(var/obj/HotSlots/HotSlot17/H in usr.client.screen)
												var/obj/h=H
												h.overlays=null
												h.overlays+=I
												usr.HotSlotSave["HotSlot17"]="[src.icon_state]"
												usr.hotslot10=src.name
												h.SetName("[usr.client.hotkey_hotslot17]")
										if(usr.HotSlotSave["HotSlot18"]==os)
											for(var/obj/HotSlots/HotSlot18/H in usr.client.screen)
												var/obj/h=H
												h.overlays=null
												h.overlays+=I
												usr.HotSlotSave["HotSlot18"]="[src.icon_state]"
												usr.hotslot10=src.name
												h.SetName("[usr.client.hotkey_hotslot18]")

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
					h.SetName("[usr.client.hotkey_hotslot1]")

					usr.hotslot1 = src.name
					usr.HotSlotSave["HotSlot1"] = "[src.icon_state]"

				if(istype(H,/obj/HotSlots/HotSlot2))
					var/image/I = image(src, src.icon_state)
					I.pixel_x = 12
					I.pixel_y = -1

					var/obj/HotSlots/h = H
					h.overlays = null
					h.overlays += I
					h.SetName("[usr.client.hotkey_hotslot2]")

					usr.hotslot2 = src.name
					usr.HotSlotSave["HotSlot2"] = "[src.icon_state]"

				if(istype(H,/obj/HotSlots/HotSlot3))
					var/image/I = image(src, src.icon_state)
					I.pixel_x = 12
					I.pixel_y = -1

					var/obj/HotSlots/h = H
					h.overlays = null
					h.overlays += I
					h.SetName("[usr.client.hotkey_hotslot3]")

					usr.hotslot3 = src.name
					usr.HotSlotSave["HotSlot3"] = "[src.icon_state]"

				if(istype(H,/obj/HotSlots/HotSlot4))
					var/image/I = image(src, src.icon_state)
					I.pixel_x = 12
					I.pixel_y = -1

					var/obj/HotSlots/h = H
					h.overlays = null
					h.overlays += I
					h.SetName("[usr.client.hotkey_hotslot4]")

					usr.hotslot4 = src.name
					usr.HotSlotSave["HotSlot4"] = "[src.icon_state]"

				if(istype(H,/obj/HotSlots/HotSlot5))
					var/image/I = image(src, src.icon_state)
					I.pixel_x = 12
					I.pixel_y = -1

					var/obj/HotSlots/h = H
					h.overlays = null
					h.overlays += I
					h.SetName("[usr.client.hotkey_hotslot5]")

					usr.hotslot5 = src.name
					usr.HotSlotSave["HotSlot5"] = "[src.icon_state]"

				if(istype(H,/obj/HotSlots/HotSlot6))
					var/image/I = image(src, src.icon_state)
					I.pixel_x = 12
					I.pixel_y = -1

					var/obj/HotSlots/h = H
					h.overlays = null
					h.overlays += I
					h.SetName("[usr.client.hotkey_hotslot6]")

					usr.hotslot6 = src.name
					usr.HotSlotSave["HotSlot6"] = "[src.icon_state]"

				if(istype(H,/obj/HotSlots/HotSlot7))
					var/image/I = image(src, src.icon_state)
					I.pixel_x = 12
					I.pixel_y = -1

					var/obj/HotSlots/h = H
					h.overlays = null
					h.overlays += I
					h.SetName("[usr.client.hotkey_hotslot7]")

					usr.hotslot7 = src.name
					usr.HotSlotSave["HotSlot7"] = "[src.icon_state]"

				if(istype(H,/obj/HotSlots/HotSlot8))
					var/image/I = image(src, src.icon_state)
					I.pixel_x = 12
					I.pixel_y = -1

					var/obj/HotSlots/h = H
					h.overlays = null
					h.overlays += I
					h.SetName("[usr.client.hotkey_hotslot8]")

					usr.hotslot8 = src.name
					usr.HotSlotSave["HotSlot8"] = "[src.icon_state]"

				if(istype(H,/obj/HotSlots/HotSlot9))
					var/image/I = image(src, src.icon_state)
					I.pixel_x = 12
					I.pixel_y = -1

					var/obj/HotSlots/h = H
					h.overlays = null
					h.overlays += I
					h.SetName("[usr.client.hotkey_hotslot9]")

					usr.hotslot9 = src.name
					usr.HotSlotSave["HotSlot9"] = "[src.icon_state]"

				if(istype(H,/obj/HotSlots/HotSlot10))
					var/image/I = image(src, src.icon_state)
					I.pixel_x = 12
					I.pixel_y = -1

					var/obj/HotSlots/h = H
					h.overlays = null
					h.overlays += I
					h.SetName("[usr.client.hotkey_hotslot10]")

					usr.hotslot10 = src.name
					usr.HotSlotSave["HotSlot10"] = "[src.icon_state]"

				if(istype(H,/obj/HotSlots/HotSlot11))
					var/image/I = image(src, src.icon_state)
					I.pixel_x = 12
					I.pixel_y = -1

					var/obj/HotSlots/h = H
					h.overlays = null
					h.overlays += I
					h.SetName("[usr.client.hotkey_hotslot11]")

					usr.hotslot11 = src.name
					usr.HotSlotSave["HotSlot11"] = "[src.icon_state]"

				if(istype(H,/obj/HotSlots/HotSlot12))
					var/image/I = image(src, src.icon_state)
					I.pixel_x = 12
					I.pixel_y = -1

					var/obj/HotSlots/h = H
					h.overlays = null
					h.overlays += I
					h.SetName("[usr.client.hotkey_hotslot12]")

					usr.hotslot12 = src.name
					usr.HotSlotSave["HotSlot12"] = "[src.icon_state]"

				if(istype(H,/obj/HotSlots/HotSlot13))
					var/image/I = image(src, src.icon_state)
					I.pixel_x = 12
					I.pixel_y = -1

					var/obj/HotSlots/h = H
					h.overlays = null
					h.overlays += I
					h.SetName("[usr.client.hotkey_hotslot13]")

					usr.hotslot13 = src.name
					usr.HotSlotSave["HotSlot13"] = "[src.icon_state]"

				if(istype(H,/obj/HotSlots/HotSlot14))
					var/image/I = image(src, src.icon_state)
					I.pixel_x = 12
					I.pixel_y = -1

					var/obj/HotSlots/h = H
					h.overlays = null
					h.overlays += I
					h.SetName("[usr.client.hotkey_hotslot14]")

					usr.hotslot14 = src.name
					usr.HotSlotSave["HotSlot14"] = "[src.icon_state]"

				if(istype(H,/obj/HotSlots/HotSlot15))
					var/image/I = image(src, src.icon_state)
					I.pixel_x = 12
					I.pixel_y = -1

					var/obj/HotSlots/h = H
					h.overlays = null
					h.overlays += I
					h.SetName("[usr.client.hotkey_hotslot15]")

					usr.hotslot15 = src.name
					usr.HotSlotSave["HotSlot15"] = "[src.icon_state]"

				if(istype(H,/obj/HotSlots/HotSlot16))
					var/image/I = image(src, src.icon_state)
					I.pixel_x = 12
					I.pixel_y = -1

					var/obj/HotSlots/h = H
					h.overlays = null
					h.overlays += I
					h.SetName("[usr.client.hotkey_hotslot16]")

					usr.hotslot16 = src.name
					usr.HotSlotSave["HotSlot16"] = "[src.icon_state]"

				if(istype(H,/obj/HotSlots/HotSlot17))
					var/image/I = image(src, src.icon_state)
					I.pixel_x = 12
					I.pixel_y = -1

					var/obj/HotSlots/h = H
					h.overlays = null
					h.overlays += I
					h.SetName("[usr.client.hotkey_hotslot17]")

					usr.hotslot17 = src.name
					usr.HotSlotSave["HotSlot17"] = "[src.icon_state]"

				if(istype(H,/obj/HotSlots/HotSlot18))
					var/image/I = image(src, src.icon_state)
					I.pixel_x = 12
					I.pixel_y = -1

					var/obj/HotSlots/h = H
					h.overlays = null
					h.overlays += I
					h.SetName("[usr.client.hotkey_hotslot18]")

					usr.hotslot18 = src.name
					usr.HotSlotSave["HotSlot18"] = "[src.icon_state]"


			else
				usr<<output("<Font color=red>You need to use [src.name] [((80-round(src.maxcooltime/15))/handsealmastery)-src.uses] more times (You've used it [src.uses] times already).</Font>","Action.Output")



