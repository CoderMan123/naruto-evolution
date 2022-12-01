mob
	npc
		mouse_over_pointer = /obj/cursors/speech
		var/tmp/list/conversations = list()
		var/npcowner
		var/ownersquad
		var/tmp/bark

		New()
			..()
			npcs_online.Add(src)

			if(!istype(src, /mob/npc/combat/animals/small))
				src.overlays += /obj/MaleParts/UnderShade
			
			src.character = src.name
			src.SetName(src.name)

			OriginalOverlays = overlays.Copy()
			//spawn() src.RestoreOverlays()


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
				..()
				src.icon = pick('WhiteMBase.dmi', 'DarkMBase.dmi')
				src.overlays += pick(null, 'Deidara.dmi', 'Distance.dmi', 'Long.dmi', 'Mohawk.dmi', 'Neji Hair.dmi', 'Short.dmi','Short2.dmi','Short3.dmi', 'Spikey.dmi')
				src.overlays += 'Shirt.dmi'
				src.overlays += 'Sandals.dmi'
				src.overlays += 'Shade.dmi'


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
				if(src.conversations.Find(usr)) return 0
				if(usr.dead)return
				if(get_dist(src,usr)>2)return
				src.conversations.Add(usr)
				if(usr.village == VILLAGE_MISSING_NIN)
					var/obj/Inventory/mission/deliver_intel/O = locate(/obj/Inventory/mission/deliver_intel) in usr.contents
					if(O && O.squad.mission)
						O.squad.mission.Complete(usr)
					else
						usr.client.prompt("Psst, hey you there. If you can get me some intel on the shinobi villages I'll pay you handsomely.", src.name)
				else
					usr.client.prompt("Buzz off, I don't speak with the likes of you.", src.name)
				src.conversations.Remove(usr)
		
		orochimaru
			name = "Orochimaru"
			icon = 'PaleMBase.dmi'
			village = VILLAGE_MISSING_NIN
			New()
				src.overlays+= 'Shade.dmi'
				src.overlays+= 'Shirt.dmi'
				src.overlays+= 'Sandals.dmi'
				src.overlays+= 'Long.dmi'
				..()

			DblClick()
				if(src.conversations.Find(usr)) return 0
				if(usr.dead)return
				if(get_dist(src,usr)>2)return
				src.conversations.Add(usr)

				switch(usr.client.prompt("Do you have something for me?", "Orochimaru", list("Who are you?", "Give Material", "Change Bloodline", "Remove Clan", "Cancel")))

					if("Who are you?")
						usr.client.prompt("I think you and I might be able to help each other. With my research I can change your bloodline clan. But I need you to bring me the materials I need first and each change will cost 10,000 ryo. I can also remove your clans for you by removing your bloodline genes or wiping your memory to make room for more knowledge. Keep in mind, you can only have 2 clans at any one time and only one of them can be a bloodline.", "Orochimaru")

					if("Give Material")
						var/choice_of_item[0]
						var/choice

						for(var/obj/item in usr.contents) if(istype(item, /obj/Inventory/Unuseable_Clan_Items)) choice_of_item.Add(item.name)

						if(choice_of_item.len < 1)
							usr.client.prompt("Don't waste my time if you don't have anything for me.", "Orochimaru")
							src.conversations.Remove(usr)
							return

						choice = usr.client.prompt("Quickly hand it over!", "Orochimaru", choice_of_item + "Cancel")
						if(choice == "Cancel")
							src.conversations.Remove(usr)
							return
						else
							for(var/obj/item in usr.contents)
								if(item && istype(item, /obj/Inventory/Unuseable_Clan_Items) && item.name == choice)
									for(var/c in usr.known_clans)
										if(c == item.clan)
											usr.client.prompt("You have already unlocked this clan. Select 'Change Bloodline' if you want to change to it.", "Orochimaru")
											src.conversations.Remove(usr)
											return
									switch(usr.client.prompt("[item.Description]<br><br>Are you sure you want to unlock the [item.clan] clan? (This will consume the item)", "Orochimaru", list("Yes", "No")))
										if("Yes")
											if(item)
												var/itemclan = item.clan
												DestroyItem(item)
												usr.known_clans.Add(itemclan)
												usr.client.prompt("Wonderful.. Let me know if you're ready for my experime-*cough* for me to change your bloodline.", "Orochimaru")
												usr.client.UpdateInventoryPanel()

					if("Change Bloodline")
						var/scenario = 1 // 1 = has 2 clans already and no bloodline    2 = has less than 2 clans or already has a bloodline
						var/clan_to_replace
						var/new_clan
						var/purchase_price = 10000

						for(var/bclan in bloodline_clans)
							if(usr.Clan == bclan) clan_to_replace = usr.Clan
							if(usr.Clan2 == bclan) clan_to_replace = usr.Clan2
						
						if(usr.Clan == "No Clan" || usr.Clan2 == "No Clan" || clan_to_replace != null) scenario = 2

						switch(scenario)
							if(1)
								clan_to_replace = usr.client.prompt("You don't currently have a Bloodline and you already have 2 clans. Which clan would you like to replace with a Bloodline clan? <br><br> (You will lose all jutsu associated with the clan as well as it's mastery and levels. Any skillpoints spent will be refunded.)", "Orochimaru", list("[usr.Clan]", "[usr.Clan2]", "Cancel"))
								if(clan_to_replace == "Cancel")
									src.conversations.Remove(usr)
									return

								new_clan = usr.client.prompt("Which bloodline would you like me to grant you?", "Orochimaru", usr.known_clans + "Cancel")
								if(new_clan == "Cancel")
									src.conversations.Remove(usr)
									return
								if(new_clan == usr.Clan || new_clan == usr.Clan2)
									usr.client.prompt("You already have this Bloodline Clan.", "Orochimaru")
									src.conversations.Remove(usr)
									return
								
								switch(usr.client.prompt("Are you sure you want to swap the [clan_to_replace] clan with the [new_clan] clan? (This will cost 10,000 ryo)", "Orochimaru", list("Yes", "No")))
									if("Yes")
										if(usr.ryo < purchase_price)
											usr.client.prompt("You don't have enough ryo! I won't work for free. Come back when you've got enough money.", "Orochimaru")
											src.conversations.Remove(usr)
											return
										else
											usr.ryo -= purchase_price
											for(var/obj/Jutsus/jutsu in usr.jutsus) 
												if(jutsu.Clan == clan_to_replace)
													usr.skillpoints += jutsu.Sprice
													usr.jutsus -= jutsu
													usr.jutsus_learned -= jutsu.type
													usr.sbought -= jutsu.name
											if(usr.Clan == clan_to_replace) usr.Clan = new_clan
											else if(usr.Clan2 == clan_to_replace) usr.Clan2 = new_clan
											LogTransaction(usr, src, purchase_price, override_item = "Change Bloodline", LOG_ACTION_TRANSACTION_BUY)
											spawn() usr.client.prompt("The operation was a success. You are no longer of the [clan_to_replace] clan and have obtained the [new_clan] clan!", "Orochimaru")
											usr.client.UpdateInventoryPanel()
							if(2)

								new_clan = usr.client.prompt("Which bloodline would you like me to grant you?", "Orochimaru", usr.known_clans + "Cancel")
								if(new_clan == "Cancel")
									src.conversations.Remove(usr)
									return
					
								if(new_clan == usr.Clan || new_clan == usr.Clan2)
									usr.client.prompt("You already have this Bloodline Clan.", "Orochimaru")
									src.conversations.Remove(usr)
									return

								if(clan_to_replace)
									switch(usr.client.prompt("Are you sure you want to swap the [clan_to_replace] clan with the [new_clan] clan? (This will cost 10,000 ryo)", "Orochimaru", list("Yes", "No")))
										if("Yes")
											if(usr.ryo < purchase_price)
												usr.client.prompt("You don't have enough ryo! I won't work for free. Come back when you've got enough money.", "Orochimaru")
												src.conversations.Remove(usr)
												return
											else
												usr.ryo -= purchase_price
												for(var/obj/Jutsus/jutsu in usr.jutsus) 
													if(jutsu.Clan == clan_to_replace)
														usr.skillpoints += jutsu.Sprice
														usr.jutsus -= jutsu
														usr.jutsus_learned -= jutsu.type
														usr.sbought -= jutsu.name
												if(usr.Clan == clan_to_replace) usr.Clan = new_clan
												else usr.Clan2 = new_clan
												LogTransaction(usr, src, purchase_price, override_item = "Change Bloodline", LOG_ACTION_TRANSACTION_BUY)
												spawn() usr.client.prompt("The operation was a success. You are no longer of the [clan_to_replace] clan and have obtained the [new_clan] clan!", "Orochimaru")
												usr.client.UpdateInventoryPanel()

								else
									switch(usr.client.prompt("Are you sure you want to gain the [new_clan] clan? (This will cost 10,000 ryo)", "Orochimaru", list("Yes", "No")))
										if("Yes")
											if(usr.ryo < purchase_price)
												usr.client.prompt("You don't have enough ryo! I won't work for free. Come back when you've got enough money.", "Orochimaru")
												src.conversations.Remove(usr)
												return
											else
												usr.ryo -= purchase_price
												if(usr.Clan == "No Clan") usr.Clan = new_clan
												else if(usr.Clan2 == "No Clan") usr.Clan2 = new_clan
												LogTransaction(usr, src, purchase_price, override_item = "Gain Bloodline", LOG_ACTION_TRANSACTION_BUY)
												spawn() usr.client.prompt("The operation was a success. You have obtained the [new_clan] clan!", "Orochimaru")
												usr.client.UpdateInventoryPanel()

					if("Remove Clan")
						var/clan_to_remove
						var/purchase_price = 5000
						clan_to_remove = usr.client.prompt("Which clan would you like to remove? (This will cost 5,000 ryo)", "Orochimaru", list("[usr.Clan]", "[usr.Clan2]", "Cancel"))			
						if(clan_to_remove == "Cancel")
							src.conversations.Remove(usr)
							return
			
						if(clan_to_remove == "No Clan")
							usr.client.prompt("You don't have a clan in this slot to remove.", "Orochimaru")
							src.conversations.Remove(usr)
							return

						switch(usr.client.prompt("Are you sure you want to remove the [clan_to_remove] clan? (This will cost 5000 ryo and you will lose all associated jutsu. Any skillpoints spent will be refunded.)", "Orochimaru", list("Yes", "No")))
							if("Yes")
								if(usr.ryo < purchase_price)
									usr.client.prompt("You don't have enough ryo! I won't work for free. Come back when you've got enough money.", "Orochimaru")
									src.conversations.Remove(usr)
									return
								else
									usr.ryo -= purchase_price
									for(var/obj/Jutsus/jutsu in usr.jutsus) 
										if(jutsu.Clan == clan_to_remove)
											usr.skillpoints += jutsu.Sprice
											usr.jutsus -= jutsu
											usr.jutsus_learned -= jutsu.type
											usr.sbought -= jutsu.name

									if(usr.Clan == clan_to_remove) usr.Clan = "No Clan"
									else usr.Clan2 = "No Clan"
									LogTransaction(usr, src, purchase_price, override_item = "Remove Clan", LOG_ACTION_TRANSACTION_BUY)
									usr.client.prompt("The operation was a success. You are no longer of the [clan_to_remove] clan!", "Orochimaru")
							
				src.conversations.Remove(usr)

		zetsu //not to be confused with white zetsu
			name = "Zetsu"
			icon = 'Zetsu.dmi'
			village = VILLAGE_AKATSUKI
			//100,161,5

			DblClick()
				if(src.conversations.Find(usr)) return 0
				if(usr.dead)return
				if(get_dist(src,usr)>2)return
				src.conversations.Add(usr)
				var/obj/Inventory/mission/deliver_intel/O = locate(/obj/Inventory/mission/deliver_intel) in usr.contents
				if(O && O.squad.mission)
					O.squad.mission.Complete(usr)
				else if(usr.client.prompt("Be patient. In time, we'll create a whole new world. Would you like to use the secret exit?", src.name, list("Yes", "No")) == "Yes")
					usr.loc = locate(100,32,4)
				src.conversations.Remove(usr)

		onomari //prestige system
			name = "Onomari"
			icon = 'WhiteMBase.dmi'
			village = VILLAGE_MISSING_NIN

			New()
				src.overlays += pick('Short.dmi','Short2.dmi','Short3.dmi')
				src.overlays += 'Shade.dmi'
				src.overlays+='Shirt.dmi'
				src.overlays+='Sandals.dmi'
				..()

			DblClick()
				if(src.conversations.Find(usr)) return 0
				if(usr.dead)return
				if(get_dist(src,usr)>2)return
				src.conversations.Add(usr)
				switch(usr.client.prompt("Don't mind me. I'm just an old veteran looking to enjoy his retirement.", src.name, list("Stat Point Reset", "Prestige", "Cancel")))

					if("Stat Point Reset")
						switch(usr.client.prompt("Hey don't you worry, we all make mistakes in training. I can teach you to change your ways if you want. (This will cost 8000 ryo. Your statpoints will be returned to you unallocated and returned to you. This will not affect your trained stats.)", src.name, list("Okay", "Cancel")))
							if("Okay")
								if(usr.ryo > 8000)
									usr.maxhealth = initial(usr.maxhealth)
									usr.health = usr.maxhealth
									usr.maxchakra = initial(usr.maxchakra)
									usr.chakra = usr.maxchakra
									usr.ninjutsu_stated = initial(usr.ninjutsu_stated)
									usr.taijutsu_stated = initial(usr.taijutsu_stated)
									usr.genjutsu_stated = initial(usr.genjutsu_stated)
									usr.defence_stated = initial(usr.defence_stated)
									usr.agility_stated = initial(usr.agility_stated)
									usr.precision_stated = initial(usr.precision_stated)
									usr.statpoints += usr.statpoints_spent
									usr.statpoints_spent = 0
									usr.ryo -= 8000
									usr.client.prompt("Your stats have been successfuly reset.", src.name)
									src.conversations.Remove(usr)
									return
								else
									usr.client.prompt("Sorry friend, you don't have enough money.", src.name)
									src.conversations.Remove(usr)
									return
							if("Cancel")
								usr.client.prompt("You know where to find me if you change your mind.", src.name)
								src.conversations.Remove(usr)
								return

					if("Prestige")
						if(usr.rank == RANK_ANBU_LEADER || usr.rank == RANK_HOKAGE || usr.rank == RANK_KAZEKAGE || usr.rank == RANK_MIZUKAGE || usr.rank == RANK_OTOKAGE || usr.rank == RANK_TSUCHIKAGE || usr.rank == RANK_AKATSUKI || usr.rank == RANK_AKATSUKI_LEADER || usr.rank == RANK_SEVEN_SWORDSMEN_LEADER)
							usr.client.prompt("Woah there, you can't take this kind of training in your position. Your people need you. (Leaders cannot prestige. Retire first and try again.)", src.name)
							return
						if(usr.level < 100)//insert prestige prereqs here
							usr.client.prompt("I used to be a shinobi like you but I took a kunai to the leg. You still seem a bit green for my teachings though. Come back when you think you've learned all you can learn about being a shinobi. (You must be level 100 to prestige)", src.name)
						else if(usr.client.prompt("Well well well.. you look to be pretty strong. But it looks like you've reached the peak of your potential. If you want to get stronger you'll have to start your training over from the beginning. I can show you the way if you think you have what it takes. Would you like to prestige? (WARNING: You will lose all levels, stats and jutsu effectively starting as a fresh character.)", src.name, list("Yes", "No")) == "Yes")
							switch(usr.client.prompt("What do you want to learn?", src.name, list("A New Element","Nevermind")))
								if("A New Element")
									if(usr.Element5)
										usr.client.prompt("You already have all five elements, you're a master of the elements!", src.name)
										src.conversations.Remove(usr)
										return
									var/PlayerElements = list("[usr.Element]","[usr.Element2]","[usr.Element3]","[usr.Element4]","[usr.Element5]")
									var/ElementChoice = list("Fire","Water","Earth","Lightning","Wind")
									ElementChoice -= PlayerElements
									var/ChosenElement
									ChosenElement = usr.client.prompt("What do you want to learn?", src.name, ElementChoice)

									var/database/query/query = new({"
										INSERT INTO `[db_table_character_prestige]` (`timestamp`, `key`, `character`, `level`, `prestige`)
										VALUES(?, ?, ?, ?, ?)"},
										time2text(world.realtime, "YYYY-MM-DD hh:mm:ss"), usr.client.ckey, usr.character, usr.level, usr.prestigelevel++
									)
									query.Execute(log_db)
									LogErrorDb(query)

									if(!usr.Element3) usr.Element3 = ElementChoice[ChosenElement]
									else if(!usr.Element4) usr.Element4 = ElementChoice[ChosenElement]
									else if(!usr.Element5) usr.Element5 = ElementChoice[ChosenElement]
									usr.prestige_reset()
									//usr.level = initial(usr.level)

								if("Nevermind")
									usr.client.prompt("You know where to find me if you change your mind.", src.name)
									src.conversations.Remove(usr)
									return
					if("Cancel")
						usr.client.prompt("You know where to find me if you need me.", src.name)
						src.conversations.Remove(usr)
						return
				src.conversations.Remove(usr)





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
			usr.ninjutsu_stated = initial(usr.ninjutsu_stated)
			usr.ninexp = initial(usr.ninexp)
			usr.maxninexp = initial(usr.maxninexp)
			usr.genjutsu = initial(usr.genjutsu)
			usr.genjutsu_stated = initial(usr.genjutsu_stated)
			usr.genexp = initial(usr.genexp)
			usr.maxgenexp = initial(usr.maxgenexp)
			usr.taijutsu = initial(usr.taijutsu)
			usr.taijutsu_stated = initial(usr.taijutsu_stated)
			usr.taijutsuexp = initial(usr.taijutsuexp)
			usr.maxtaijutsuexp = initial(usr.maxtaijutsuexp)
			usr.defence = initial(usr.defence)
			usr.defence_stated = initial(usr.defence_stated)
			usr.defexp = initial(usr.defexp)
			usr.maxdefexp = initial(usr.maxdefexp)
			usr.agility = initial(usr.agility)
			usr.agility_stated = initial(usr.agility_stated)
			usr.agilityexp = initial(usr.agilityexp)
			usr.maxagilityexp = initial(usr.maxagilityexp)
			usr.precision = initial(usr.precision)
			usr.precision_stated = initial(usr.precision_stated)
			usr.precisionexp = initial(usr.precisionexp)
			usr.maxprecisionexp = initial(usr.maxprecisionexp)
			usr.statpoints = initial(usr.statpoints)
			usr.skillpoints = initial(usr.skillpoints)
			usr.rank = RANK_ACADEMY_STUDENT
			usr.last_hotspring_time = initial(usr.last_hotspring_time)
			usr.hotspring_minutes = initial(usr.hotspring_minutes)
			usr.jutsus = initial(usr.jutsus)
			usr.jutsus_learned = initial(usr.jutsus_learned)
			usr.sbought = initial(usr.sbought)
			usr.prestigelevel++
			usr.loc = MapLoadSpawn()
			winset(usr , null , "command = .reconnect")
