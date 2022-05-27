mob
	npc
		mouse_over_pointer = /obj/cursors/speech
		var/tmp/list/conversations = list()
		var/npcowner
		var/ownersquad
		var/tmp/bark
		move=0

		New()
			..()
			npcs_online.Add(src)

			if(!istype(src, /mob/npc/combat/animals/small))
				src.overlays += /obj/MaleParts/UnderShade

			src.SetName(src.name)

			OriginalOverlays = overlays.Copy()
			//spawn() src.RestoreOverlays()

			src.NewStuff()

		Move()
			if(istype(src, /mob/npc/combat)) ..()
			else return

		Death(killer)
			if(istype(src, /mob/npc/combat)) ..()
			else return

		banker
			name = "Banker"
			icon = 'WhiteMBase.dmi'
			density = 1
			pixel_x = -15

			leaf_banker
				village = VILLAGE_LEAF

			sand_banker
				village = VILLAGE_SAND

			missing_nin_banker
				village = VILLAGE_AKATSUKI

			akatsuki_banker
				village = VILLAGE_AKATSUKI

			New()
				src.overlays += pick('Short.dmi', 'Short2.dmi', 'Short3.dmi')
				src.overlays += 'Shirt.dmi'
				src.overlays += 'Sandals.dmi'
				..()


			DblClick()
				if(src.conversations.Find(usr)) return 0
				if(get_dist(src,usr) > 2) return
				if(usr.dead) return

				src.conversations.Add(usr)

				if(src.village == usr.village)

					view(src) << "[HTML_GetName(src)]<font color='[COLOR_CHAT]'>: Greetings [usr.name], would you like to make a deposit or a withdrawal from your bank?</font>"

					switch(usr.client.prompt("You currently have <u>[usr.ryo]</u> Ryo in your satchel.<br /><br />You currently have <u>[usr.RyoBanked]</u> in your bank.", "Bank", list("Deposit","Withdraw","Cancel")))
						if("Deposit")

							view(usr) << "[HTML_GetName(usr)]<font color='[COLOR_CHAT]'>: I'd like to make a deposit to my bank account.</font>"

							if(!usr.ryo)
								sleep(10)
								view(src) << "[HTML_GetName(src)]<font color='[COLOR_CHAT]'>: I'm sorry, but your broke ass doesn't have any Ryo to deposit.</font>"
							else
								sleep(10)
								view(src) << "[HTML_GetName(src)]<font color='[COLOR_CHAT]'>: Very well, how much would you like to deposit?</font>"

								switch(usr.client.prompt("Would you like to deposit all of your Ryo?", "Bank", list("Yes", "No", "Cancel")))
									if("Yes")
										var/value = usr.ryo

										if(value)
											view(usr) << "[HTML_GetName(src)]<font color='[COLOR_CHAT]'>: I'd like to deposit [value] Ryo into my bank account.</font>"

											usr.ryo -= value
											usr.RyoBanked += value

											spawn() usr.client.UpdateInventoryPanel()

											usr << output("You have deposited <u>[value]</u> Ryo into your bank.", "Action.Output")
											usr << output("You now have <u>[usr.ryo]</u> Ryo into your satchel and <u>[usr.RyoBanked]</u> in your bank.", "Action.Output")

											sleep(10)
											view(src) << "[HTML_GetName(src)]<font color='[COLOR_CHAT]'>: Your transaction has been completed. Please come back again soon!</font>"

										else
											view(usr) << "[HTML_GetName(src)]<font color='[COLOR_CHAT]'>: Actually, I've changed my mind.</font>"
											sleep(10)
											view(src) << "[HTML_GetName(src)]<font color='[COLOR_CHAT]'>: Please come back again soon!</font>"

									if("No")
										var/list/response = usr.client.iprompt("How much Ryo would you like to deposit into your bank?<br /><br />You currently have <u>[usr.ryo]</u> Ryo in your satchel.<br />You currently have <u>[usr.RyoBanked]</u> in your bank.", "Bank")

										var/value = text2num(response[2])

										if(isnum(value) && value > 0 && usr.ryo >= value)
											view(usr) << "[HTML_GetName(src)]<font color='[COLOR_CHAT]'>: I'd like to deposit [value] Ryo into my bank account.</font>"

											usr.ryo -= value
											usr.RyoBanked += value

											spawn() usr.client.UpdateInventoryPanel()

											usr << output("You have deposited <u>[value]</u> Ryo into your bank.", "Action.Output")
											usr << output("You now have <u>[usr.ryo]</u> Ryo into your satchel and <u>[usr.RyoBanked]</u> in your bank.", "Action.Output")

											sleep(10)
											view(src) << "[HTML_GetName(src)]<font color='[COLOR_CHAT]'>: Your transaction has been completed. Please come back again soon!</font>"

										else
											view(usr) << "[HTML_GetName(src)]<font color='[COLOR_CHAT]'>: Actually, I've changed my mind.</font>"
											sleep(10)
											view(src) << "[HTML_GetName(src)]<font color='[COLOR_CHAT]'>: Please come back again soon!</font>"

									if("Cancel")
										view(usr) << "[HTML_GetName(src)]<font color='[COLOR_CHAT]'>: Actually, I've changed my mind.</font>"
										sleep(10)
										view(src) << "[HTML_GetName(src)]<font color='[COLOR_CHAT]'>: Please come back again soon!</font>"

						if("Withdraw")

							view(usr) << "[HTML_GetName(usr)]<font color='[COLOR_CHAT]'>: I'd like to make a withdrawal from my bank account.</font>"

							if(!usr.RyoBanked)
								sleep(10)
								view(src) << "[HTML_GetName(src)]<font color='[COLOR_CHAT]'>: I'm sorry, but your broke ass doesn't have any Ryo to withdrawal.</font>"
							else
								sleep(10)
								view(src) << "[HTML_GetName(src)]<font color='[COLOR_CHAT]'>: Very well, how much would you like to withdrawal?</font>"

								switch(usr.client.prompt("Would you like to withdrawal all of your Ryo?", "Bank", list("Yes", "No", "Cancel")))
									if("Yes")
										var/value = usr.RyoBanked

										if(value)
											view(usr) << "[HTML_GetName(src)]<font color='[COLOR_CHAT]'>: I'd like to withdrawal [value] Ryo into my bank account.</font>"

											usr.RyoBanked -= value
											usr.ryo += value

											spawn() usr.client.UpdateInventoryPanel()

											usr << output("You withdraw <u>[value]</u> Ryo into from your bank.", "Action.Output")
											usr << output("You now have <u>[usr.ryo]</u> Ryo into your satchel and <u>[usr.RyoBanked]</u> in your bank.", "Action.Output")

											sleep(10)
											view(src) << "[HTML_GetName(src)]<font color='[COLOR_CHAT]'>: Your transaction has been completed. Please come back again soon!</font>"

										else
											view(usr) << "[HTML_GetName(src)]<font color='[COLOR_CHAT]'>: Actually, I've changed my mind.</font>"
											sleep(10)
											view(src) << "[HTML_GetName(src)]<font color='[COLOR_CHAT]'>: Please come back again soon!</font>"

									if("No")
										var/list/response = usr.client.iprompt("How much Ryo would you like to withdraw from your bank?<br /><br />You currently have <u>[usr.ryo]</u> Ryo in your satchel.<br />You currently have <u>[usr.RyoBanked]</u> in your bank.", "Bank")

										var/value = text2num(response[2])

										if(isnum(value) && value > 0 && usr.RyoBanked >= value)
											view(usr) << "[HTML_GetName(src)]<font color='[COLOR_CHAT]'>: I'd like to withdraw [value] Ryo from my bank account.</font>"

											usr.RyoBanked -= value
											usr.ryo += value

											spawn() usr.client.UpdateInventoryPanel()

											usr << output("You withdraw <u>[value]</u> Ryo into from your bank.", "Action.Output")
											usr << output("You now have <u>[usr.ryo]</u> Ryo into your satchel and <u>[usr.RyoBanked]</u> in your bank.", "Action.Output")

											sleep(10)
											view(src) << "[HTML_GetName(src)]<font color='[COLOR_CHAT]'>: Your transaction has been completed. Please come back again soon!</font>"

										else
											view(usr) << "[HTML_GetName(src)]<font color='[COLOR_CHAT]'>: Actually, I've changed my mind.</font>"
											sleep(10)
											view(src) << "[HTML_GetName(src)]<font color='[COLOR_CHAT]'>: Please come back again soon!</font>"

									if("Cancel")
										view(usr) << "[HTML_GetName(src)]<font color='[COLOR_CHAT]'>: Actually, I've changed my mind.</font>"
										sleep(10)
										view(src) << "[HTML_GetName(src)]<font color='[COLOR_CHAT]'>: Please come back again soon!</font>"
						if("Cancel")
							view(usr) << "[HTML_GetName(src)]<font color='[COLOR_CHAT]'>: No, thank you.</font>"
							sleep(10)
							view(src) << "[HTML_GetName(src)]<font color='[COLOR_CHAT]'>: Please come back again soon!</font>"

				else
					view(src) << "[HTML_GetName(src)]<font color='[COLOR_CHAT]'>: I only manage accounts for members of the [HTML_GetVillage(src)].</font>"

				src.conversations.Remove(usr)

		shady_man
			name = "Shady Looking Figure"
			icon = 'WhiteMBase.dmi'
			village = VILLAGE_MISSING_NIN
			New()
				src.overlays += pick('Short.dmi','Short2.dmi','Short3.dmi')
				src.overlays += 'Shade.dmi'
				src.overlays+='Shirt.dmi'
				src.overlays+='Sandals.dmi'
				..()

			DblClick()
				if(usr.dead)return
				if(get_dist(src,usr)>2)return
				if(usr)usr.move=0
				if(usr.village == VILLAGE_MISSING_NIN)
					var/obj/Inventory/mission/deliver_intel/O = locate(/obj/Inventory/mission/deliver_intel) in usr.contents
					if(O && O.squad.mission)
						O.squad.mission.Complete(usr)
					else
						usr.client.prompt("Psst, hey you there. If you can get me some intel on the shinobi villages I'll pay you handsomely.", src.name)
				else
					usr.client.prompt("Buzz off, I don't speak with the likes of you.", src.name)
				usr.move=1

		zetsu //not to be confused with white zetsu
			name = "Zetsu"
			icon = 'Zetsu.dmi'
			village = VILLAGE_AKATSUKI
			//100,161,5

			DblClick()
				if(usr.dead)return
				if(get_dist(src,usr)>2)return
				if(usr)usr.move=0
				var/obj/Inventory/mission/deliver_intel/O = locate(/obj/Inventory/mission/deliver_intel) in usr.contents
				if(O && O.squad.mission)
					O.squad.mission.Complete(usr)
				else if(usr.client.prompt("Be patient. In time, we'll create a whole new world. Would you like to use the secret exit?", src.name, list("Yes", "No")) == "Yes")
					usr.loc = locate(100,32,4)
				usr.move=1

		onomari //prestige system
			name = "Onomari"
			icon = 'WhiteMBase.dmi'
			village = "Hidden Leaf"


			DblClick()
				if(usr.dead)return
				if(get_dist(src,usr)>2)return
				if(usr)usr.move=0
				if(usr.rank == RANK_ANBU_LEADER || usr.rank == RANK_HOKAGE || usr.rank == RANK_KAZEKAGE || usr.rank == RANK_MIZUKAGE || usr.rank == RANK_OTOKAGE || usr.rank == RANK_TSUCHIKAGE || usr.rank == RANK_AKATSUKI || usr.rank == RANK_AKATSUKI_LEADER || usr.rank == RANK_SEVEN_SWORDSMEN_LEADER)
					usr.client.Alert("Don't mind me. I'm just an old veteran looking to enjoy his retirement. (Leaders cannot prestige. Retire first and try again.)", src.name)
					return
				if(usr.level < 100)//insert prestige prereqs here
					usr.client.Alert("I used to be a shinobi like you but I took a kunai to the leg. You still seem a bit green for my teachings though. Come back when you think you've learned all you can learn about being a shinobi.", src.name)
				else if(usr.client.Alert("Well well well.. you look to be pretty strong. But it looks like you've reached the peak of your potential. If you want to get stronger you'll have to start your training over from the beginning. I can show you the way if you think you have what it takes. Would you like to prestige? (WARNING: You will lose all levels, stats and jutsu effectively starting as a fresh character.)", src.name, list("Yes", "No")) == 1)
					switch(usr.client.AlertList("What do you want to learn?", src.name, list("A New Element","Nevermind")))
						if(1)
							if(usr.Element5)
								usr.client.Alert("You already have all five elements, you're a master of the elements!", src.name)
								usr.move=1
								return
							var/PlayerElements = list("[usr.Element]","[usr.Element2]","[usr.Element3]","[usr.Element4]","[usr.Element5]")
							var/ElementChoice = list("Fire","Water","Earth","Lightning","Wind")
							ElementChoice -= PlayerElements
							var/ChosenElement
							ChosenElement = usr.client.AlertList("What do you want to learn?", src.name, ElementChoice)
							if(!usr.Element3) usr.Element3 = ElementChoice[ChosenElement]
							else if(!usr.Element4) usr.Element4 = ElementChoice[ChosenElement]
							else if(!usr.Element5) usr.Element5 = ElementChoice[ChosenElement]
							usr.prestige_reset()
							//usr.level = initial(usr.level)

						if(2)
							usr.client.Alert("You know where to find me if you change your mind.", src.name)
							usr.move=1
							return
				usr.move=1





			/*PRESTIGE CHECKLIST
				reset health/maxhealth
				reset chakra/maxchakra
				reset level
				reset exp
				reset stats
				reset stat exp
				remove stat points
				remove skill points
				remove all jutsu except starter jutsu
				set rank back to academy student*/
mob
	proc
		prestige_reset()
			usr.health = initial(usr.health)
			usr.maxhealth = initial(usr.maxhealth)
			usr.chakra = initial(usr.chakra)
			usr.maxchakra = initial(usr.maxchakra)
			usr.level = initial(usr.level)
			usr.exp = initial(usr.exp)
			usr.maxexp = initial(usr.maxexp)
			usr.ninjutsu = initial(usr.ninjutsu)
			usr.ninexp = initial(usr.ninexp)
			usr.maxninexp = initial(usr.maxninexp)
			usr.genjutsu = initial(usr.genjutsu)
			usr.genexp = initial(usr.genexp)
			usr.maxgenexp = initial(usr.maxgenexp)
			usr.strength = initial(usr.strength)
			usr.strengthexp = initial(usr.strengthexp)
			usr.maxstrengthexp = initial(usr.maxstrengthexp)
			usr.defence = initial(usr.defence)
			usr.defexp = initial(usr.defexp)
			usr.maxdefexp = initial(usr.maxdefexp)
			usr.agility = initial(usr.agility)
			usr.agilityexp = initial(usr.agilityexp)
			usr.maxagilityexp = initial(usr.maxagilityexp)
			usr.precision = initial(usr.precision)
			usr.precisionexp = initial(usr.precisionexp)
			usr.maxprecisionexp = initial(usr.maxprecisionexp)
			usr.statpoints = initial(usr.statpoints)
			usr.skillpoints = initial(usr.skillpoints)
			usr.rank = RANK_ACADEMY_STUDENT
			usr.last_hotspring_time = initial(usr.last_hotspring_time)
			usr.hotspring_minutes = initial(usr.hotspring_minutes)
			usr.jutsus = initial(usr.jutsus)
			usr.jutsus_learned = initial(usr.jutsus_learned)
			usr.prestigelevel++
			usr.loc = MapLoadSpawn()
			winset(usr , null , "command = .reconnect")
