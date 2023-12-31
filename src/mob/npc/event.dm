mob
	npc
		event_npc
			genin_examiner
				icon = 'WhiteMBase.dmi'
				New()
					..()
					src.icon = pick('WhiteMBase.dmi', 'DarkMBase.dmi')
					src.overlays += pick(null, 'Deidara.dmi', 'Distance.dmi', 'Long.dmi', 'Mohawk.dmi', 'Neji Hair.dmi', 'Short.dmi','Short2.dmi','Short3.dmi', 'Spikey.dmi')
					src.overlays += 'Shirt.dmi'
					src.overlays += 'Sandals.dmi'
					src.overlays += 'Shade.dmi'

				DblClick()
					..()
					if(src.conversations.Find(usr)) return 0
					src.conversations.Add(usr)
					if(src.village != usr.village)
						hearers(src) << "[HTML_GetName(src)]<font color='[COLOR_CHAT]'>: Please visit the Genin Examiner in your own village.</font>"
					else
						if(usr.rank != RANK_ACADEMY_STUDENT)
							hearers(src) << "[HTML_GetName(src)]<font color='[COLOR_CHAT]'>: Quit fooling around, you're not an [RANK_ACADEMY_STUDENT].</font>"
						else if(usr.level < 5)
							hearers(src) << "[HTML_GetName(src)]<font color='[COLOR_CHAT]'>: You must be at least level 5 before you can register for the Genin exam.</font>"
						else
							if(genin_exam_registration)
								hearers(src) << "[HTML_GetName(src)]<font color='[COLOR_CHAT]'>: Hey, are you here to register for the Genin exam?</font>"

								if(usr.client.prompt("Would you like to register for the Genin exam?", "[src]", list("Yes", "No")) == "Yes")
									hearers(usr) << "[HTML_GetName(usr)]<font color='[COLOR_CHAT]'>: Yes, I'm ready to join the ranks of Genin!</font>"
									genin_exam_participants.Add(usr)
									sleep(10)
									hearers(src) << "[HTML_GetName(src)]<font color='[COLOR_CHAT]'>: You've successfully been registered for the Genin exam.</font>"
									sleep(10)
									hearers(src) << "[HTML_GetName(src)]<font color='[COLOR_CHAT]'>: Please find your seat and prepare for the writtem examination.</font>"
								else
									hearers(src) << "[HTML_GetName(src)]<font color='[COLOR_CHAT]'>: Okay, be sure to come back when you are ready.</font>"
							else
								hearers(src) << "[HTML_GetName(src)]<font color='[COLOR_CHAT]'>: Registration for the Genin exam is not currently open.</font>"

					src.conversations.Remove(usr)

				leaf_genin_examiner
					name = "Genin Examiner"
					village = VILLAGE_LEAF

				sand_genin_examiner
					name = "Genin Examiner"
					village = VILLAGE_SAND

			ballot_secretary
				New()
					..()
					if(src.village == VILLAGE_LEAF) src.icon = src.icon
					if(src.village == VILLAGE_SAND) src.icon = src.icon
					src.overlays += pick('Short.dmi','Short2.dmi','Short3.dmi')
					src.overlays+='Shirt.dmi'
					src.overlays+='Sandals.dmi'

				DblClick()
					..()
					if(src.conversations.Find(usr)) return 0
					src.conversations.Add(usr)

					switch(src.village)
						if(VILLAGE_LEAF)
							if(src.village == usr.village)
								if(usr.checkRank() >= 2)
									if(global.hokage_election)
										if(global.hokage_ballot_open)
											view(src) << "<font color = '[COLOR_VILLAGE_LEAF]'>[src.name]</font><font color='[COLOR_CHAT]'>: I see that you're at least a [RANK_CHUUNIN], would you like to nominate yourself for [RANK_HOKAGE]?</font>"
											if(usr.client.prompt("Would you like to nominate yourself as [RANK_HOKAGE]?", "Election", list("Yes", "No")) == "Yes")
												view(usr) << "<font color='[src.name_color]'>[usr.name]</font><font color='[COLOR_CHAT]'>: Yes, please accept my ballot.</font>"
												sleep(10)
												if(GetBallot(usr))
													view(src) << "<font color = '[COLOR_VILLAGE_LEAF]'>[src.name]</font><font color='[COLOR_CHAT]'>: I see that you have already nominated yourself for [RANK_HOKAGE]. As per policy, a nominee may only nominate themselves once.</font>"
												else
													var/election_ballot/ballot = new()
													ballot.name = "[usr.character] ([usr.ckey])"
													ballot.ckey = usr.ckey
													ballot.character = usr.character
													hokage_election_ballot.Add(ballot)
													view(src) << "<font color = '[COLOR_VILLAGE_LEAF]'>[src.name]</font><font color='[COLOR_CHAT]'>: Thank you for your submission, [usr.character]. Your ballot has been accepted.</font>"
													world << "<font color='red'>\[G]</font> <font color = '[COLOR_VILLAGE_LEAF]'>[src.name]</font><font color='[COLOR_CHAT]'>: [usr.character] has submitted their ballot as a nominee for the on-going [RANK_HOKAGE] election.</font>"
											else
												view(usr) << "<font color='[src.name_color]'>[usr.name]</font><font color='[COLOR_CHAT]'>: No, thank you.</font>"
												sleep(10)
												view(src) << "<font color = '[COLOR_VILLAGE_LEAF]'>[src.name]</font><font color='[COLOR_CHAT]'>: I understand, feel free to come back if you'd like to nominate yourself for [RANK_HOKAGE].</font>"
										else
											view(src) << "<font color = '[COLOR_VILLAGE_LEAF]'>[src.name]</font><font color='[COLOR_CHAT]'>: Sorry, the current on-going election has a closed ballot policy, due to the previous election resulting in a tie.</font>"
									else
										view(src) << "<font color = '[COLOR_VILLAGE_LEAF]'>[src.name]</font><font color='[COLOR_CHAT]'>: There currently isn't an on-going election for [RANK_HOKAGE]. You can come back during the next election if you'd like to nominate yourself.</font>"
								else
									view(src) << "<font color = '[COLOR_VILLAGE_LEAF]'>[src.name]</font><font color='[COLOR_CHAT]'>: You must be at least a Chuunin to be allowed nominate yourself for [RANK_HOKAGE].</font>"
							else
								view(src) << "<font color = '[COLOR_VILLAGE_LEAF]'>[src.name]</font><font color='[COLOR_CHAT]'>: You can't nominate yourself for [RANK_HOKAGE]. You're from the Hidden Sand village, get out of here!</font>"

						if(VILLAGE_SAND)
							if(src.village == usr.village)
								if(usr.checkRank() >= 2)
									if(global.kazekage_election)
										if(global.kazekage_ballot_open)
											view(src) << "<font color = '[COLOR_VILLAGE_SAND]'>[src.name]</font><font color='[COLOR_CHAT]'>: I see that you're at least a [RANK_CHUUNIN], would you like to nominate yourself for [RANK_KAZEKAGE]?</font>"
											if(usr.client.prompt("Would you like to nominate yourself as [RANK_KAZEKAGE]?", "Election", list("Yes", "No")) == "Yes")
												view(usr) << "<font color='[src.name_color]'>[usr.name]</font><font color='[COLOR_CHAT]'>: Yes, please accept my ballot.</font>"
												sleep(10)
												if(GetBallot(usr))
													view(src) << "<font color = '[COLOR_VILLAGE_SAND]'>[src.name]</font><font color='[COLOR_CHAT]'>: I see that you have already nominated yourself for [RANK_KAZEKAGE]. As per policy, a nominee may only nominate themselves once.</font>"
												else
													var/election_ballot/ballot = new()
													ballot.name = "[usr.character] ([usr.ckey])"
													ballot.ckey = usr.ckey
													ballot.character = usr.character
													kazekage_election_ballot.Add(ballot)
													view(src) << "<font color = '[COLOR_VILLAGE_SAND]'>[src.name]</font><font color='[COLOR_CHAT]'>: Thank you for your submission, [usr.character]. Your ballot has been accepted.</font>"
													world << "<font color='red'>\[G]</font> <font color = '[COLOR_VILLAGE_SAND]'>[src.name]</font><font color='[COLOR_CHAT]'>: [usr.character] has submitted their ballot as a nominee for the on-going [RANK_KAZEKAGE] election.</font>"
											else
												view(usr) << "<font color='[src.name_color]'>[usr.name]</font><font color='[COLOR_CHAT]'>: No, thank you.</font>"
												sleep(10)
												view(src) << "<font color = '[COLOR_VILLAGE_SAND]'>[src.name]</font><font color='[COLOR_CHAT]'>: I understand, feel free to come back if you'd like to nominate yourself for [RANK_KAZEKAGE].</font>"
										else
											view(src) << "<font color = '[COLOR_VILLAGE_SAND]'>[src.name]</font><font color='[COLOR_CHAT]'>: Sorry, the current on-going election has a closed ballot policy, due to the previous election resulting in a tie.</font>"
									else
										view(src) << "<font color = '[COLOR_VILLAGE_SAND]'>[src.name]</font><font color='[COLOR_CHAT]'>: There currently isn't an on-going election for [RANK_KAZEKAGE]. You can come back during the next election if you'd like to nominate yourself.</font>"
								else
									view(src) << "<font color = '[COLOR_VILLAGE_SAND]'>[src.name]</font><font color='[COLOR_CHAT]'>: You must be at least a Chuunin to be allowed nominate yourself for [RANK_KAZEKAGE].</font>"
							else
								view(src) << "<font color = '[COLOR_VILLAGE_SAND]'>[src.name]</font><font color='[COLOR_CHAT]'>: You can't nominate yourself for [RANK_KAZEKAGE]. You're from the Hidden Sand village, get out of here!</font>"

					src.conversations.Remove(usr)

				leaf_ballot_secretary
					icon = 'DarkMBase.dmi'
					name = "Leaf Ballot Secretary"
					village = VILLAGE_LEAF

				sand_ballot_secretary
					icon = 'PaleMBase.dmi'
					name = "Sand Ballot Secretary"
					village = VILLAGE_SAND