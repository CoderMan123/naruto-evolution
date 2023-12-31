client
	proc
		StaffCheck()
			winset(src, null, {"
				Navigation.LeaderButton.is-disabled = 'true';
				Settings-General.Administration.is-visible = 'false';
			"})

			// Kage Check //

			if(hokage[src.ckey] == src.mob.character || kazekage[src.ckey] == src.mob.character)
				winset(src, "Navigation.LeaderButton", "is-disabled = 'false'")
				src.mob.verbs += typesof(/mob/kage/verb)

				if(hokage[src.ckey] == src.mob.character)
					src.mob.SetRank(RANK_HOKAGE)

				else if(kazekage[src.ckey] == src.mob.character)
					src.mob.SetRank(RANK_KAZEKAGE)

			else
				src.mob.verbs -= typesof(/mob/kage/verb)

				if(src.mob.rank == RANK_HOKAGE)
					src << output("You were forced out of office as the [RANK_HOKAGE] for the <font color='[COLOR_VILLAGE_LEAF]'>[VILLAGE_LEAF]</font>, and as a result you have been automatically demoted to [RANK_JOUNIN].", "Action.Output")
					
					spawn()
						var/database/query/query = new({"
							INSERT INTO `[db_table_kage]` (`timestamp`, `key`, `character`, `village`, `log`)
							VALUES(?, ?, ?, ?, ?)"},
							time2text(world.realtime, "YYYY-MM-DD hh:mm:ss"), src.ckey, src.mob.character, src.mob.village, "[src.mob.character] ([src.ckey]) was forced out of office as the [RANK_HOKAGE] for the [VILLAGE_LEAF], and as a result has been automatically demoted to [RANK_JOUNIN]."
						)
						query.Execute(log_db)
						LogErrorDb(query)
					
					src.mob.SetRank(RANK_CHUUNIN)

				if(src.mob.rank == RANK_KAZEKAGE)
					src << output("You were forced out of office as the [RANK_KAZEKAGE] for the <font color='[COLOR_VILLAGE_SAND]'>[VILLAGE_SAND]</font>, and as a result you have been automatically demoted to [RANK_JOUNIN].", "Action.Output")
					
					spawn()
						var/database/query/query = new({"
							INSERT INTO `[db_table_kage]` (`timestamp`, `key`, `character`, `village`, `log`)
							VALUES(?, ?, ?, ?, ?)"},
							time2text(world.realtime, "YYYY-MM-DD hh:mm:ss"), src.ckey, src.mob.character, src.mob.village, "[src.mob.character] ([src.ckey]) was forced out of office as the [RANK_KAZEKAGE] for the [VILLAGE_SAND], and as a result has been automatically demoted to [RANK_JOUNIN]."
						)
						query.Execute(log_db)
						LogErrorDb(query)

					src.mob.SetRank(RANK_CHUUNIN)

			// Akatsuki Check //

			if(akatsuki_leader[src.ckey] == src.mob.character)
				winset(src, "Navigation.LeaderButton", "is-disabled = 'false'")
				src.mob.verbs += typesof(/mob/akatsuki/verb)
				src.mob.SetRank(RANK_AKATSUKI_LEADER)

			else
				src.mob.verbs -= typesof(/mob/akatsuki/verb)

				if(src.mob.rank == RANK_AKATSUKI_LEADER)
					src << output("You were forced out of office as the [RANK_AKATSUKI_LEADER] for the <font color='[COLOR_VILLAGE_AKATSUKI]'>[VILLAGE_AKATSUKI]</font>, and as a result you have been automatically demoted to [RANK_AKATSUKI].", "Action.Output")
					
					spawn()
						var/database/query/query = new({"
							INSERT INTO `[db_table_akatsuki]` (`timestamp`, `key`, `character`, `village`, `log`)
							VALUES(?, ?, ?, ?, ?)"},
							time2text(world.realtime, "YYYY-MM-DD hh:mm:ss"), global.GetAkatsukiLeader(), global.GetAkatsukiLeader(RETURN_FORMAT_CHARACTER), VILLAGE_AKATSUKI, "[src.mob.character] ([src.ckey]) was forced out of office as the [RANK_AKATSUKI_LEADER] for the [VILLAGE_AKATSUKI], and as a result has been automatically demoted to [RANK_AKATSUKI]."
						)
						query.Execute(log_db)
						LogErrorDb(query)

					src.mob.SetRank(RANK_AKATSUKI)

			if(administrators.Find(src.ckey))
				winset(src, null, {"
					Navigation.LeaderButton.is-disabled = 'false';
					Settings-General.Administration.is-visible = 'true';
				"})

				src.mob.verbs += typesof(/mob/administrator/verb)
				src.mob.verbs += typesof(/mob/moderator/verb)
				src.mob.verbs += typesof(/mob/programmer/verb)
				src.mob.verbs += typesof(/mob/pixel_artist/verb)
				src.mob.verbs += typesof(/mob/event/verb/)
				src.mob.verbs += typesof(/mob/MasterGM/verb)
				src.mob.verbs += typesof(/mob/Admin/verb)
				src.mob.verbs += typesof(/mob/Moderator/verb)
				src.mob.verbs += typesof(/mob/PixelArtist/verb)
				src.control_freak = 0
			else
				src.mob.verbs -= typesof(/mob/administrator/verb)
				src.mob.verbs -= typesof(/mob/moderator/verb)
				src.mob.verbs -= typesof(/mob/programmer/verb)
				src.mob.verbs -= typesof(/mob/pixel_artist/verb)
				src.mob.verbs -= typesof(/mob/event/verb/)
				src.mob.verbs -= typesof(/mob/MasterGM/verb)
				src.mob.verbs -= typesof(/mob/Admin/verb)
				src.mob.verbs -= typesof(/mob/Moderator/verb)
				src.mob.verbs -= typesof(/mob/PixelArtist/verb)
				src.control_freak = CONTROL_FREAK_ALL

			if(moderators.Find(src.ckey) || administrators.Find(src.ckey))
				winset(src, "Navigation.LeaderButton", "is-disabled = 'false'")
				src.mob.verbs += typesof(/mob/moderator/verb)
				src.mob.verbs += typesof(/mob/Moderator/verb)
			else
				src.mob.verbs -= typesof(/mob/moderator/verb)
				src.mob.verbs -= typesof(/mob/Moderator/verb)

			if(programmers.Find(src.ckey) || administrators.Find(src.ckey))
				winset(src, "Navigation.LeaderButton", "is-disabled = 'false'")
				src.mob.verbs += typesof(/mob/programmer/verb)
			else
				src.mob.verbs -= typesof(/mob/programmer/verb)

			if(pixel_artists.Find(src.ckey) || administrators.Find(src.ckey))
				winset(src, "Navigation.LeaderButton", "is-disabled = 'false'")
				src.mob.verbs += typesof(/mob/pixel_artist/verb)
			else
				src.mob.verbs -= typesof(/mob/pixel_artist/verb)

			spawn() src.UpdateCharacterPanel()


mob
	administrator
		verb

			// IMPORTAINT: Only use `usr` in verbs for safety. Calling `src.client` results in runtime errors.
			// IMPORTAINT: This doesn't apply to verbs of type path: `/mob/verb`.

			// UPDATE: This issue only happens when you add these verbs to src.client instead of src.mob.
			// NOTE: Only add verbs to src.mob from now on.

			List_Verbs()
				set category="Administrator"
				for(var/x in typesof(/mob/verb))
					src << "[x]"


			Start_Chuunin_Exam()
				set category="Administrator"
				var/a = input("How long till it starts?") as num
				var/b = input("How long should the written last?") as num
				ChuninExamStart(a, b)

			Account_Migration()
				set category = "Administrator"

				var/list/savefile_dirs = flist("[SAVEFILE_CHARACTERS]/")
				var/list/savefile_list = list()

				for(var/dir in savefile_dirs)
					savefile_list.Add(flist("[SAVEFILE_CHARACTERS]/[dir]"))

				for(var/sav in savefile_list)
					if(findlasttext(sav, ".sav.lk")) savefile_list.Remove(sav)
					if(findlasttext(sav, ".sav.backup")) savefile_list.Remove(sav)
					if(findlasttext(sav, ".sav.migration")) savefile_list.Remove(sav)
					if(findlasttext(sav, ".sav") == 0) savefile_list.Remove(sav)

				var/savefile = src.client.prompt("Select which savefile you'd like to migrate.", "Account Migration", savefile_list + list("Cancel"))

				if(savefile != "Cancel")
					for(var/dir in savefile_dirs)

						if(fexists("[SAVEFILE_CHARACTERS]/[dir]/[savefile].lk"))
							alert("This savefile is locked and cannot be migrated.", "Account Migration")
							break

						else if(fexists("[SAVEFILE_CHARACTERS]/[dir]/[savefile]"))
							var/list/ckey = src.client.iprompt("Please enter the new <b><u>ckey</u></b> this savefile should be migrated to. Savefile: [savefile].", "Account Migration", list("Migrate Account", "Cancel"))
							if(ckey[2] && ckey[1] != "Cancel")
								var/timestamp = time2text(world.realtime, "YYYY-MM-DD")
								if(fcopy("[SAVEFILE_CHARACTERS]/[dir]/[savefile]", "[SAVEFILE_CHARACTERS]/[dir]/[timestamp]_[world.timeofday]-[savefile].migration"))
									var/savefile/F = new("[SAVEFILE_CHARACTERS]/[dir]/[savefile]")

									if(fcopy("[SAVEFILE_CHARACTERS]/[dir]/[savefile]", "[SAVEFILE_CHARACTERS]/[copytext(ckey[2], 1, 2)]/[replacetext(savefile, ckey(F["key"]), ckey[2])]"))
										F = new("[SAVEFILE_CHARACTERS]/[copytext(ckey[2], 1, 2)]/[replacetext(savefile, ckey(F["key"]), ckey[2])]")
										F["key"] << ckey[2]

										fdel("[SAVEFILE_CHARACTERS]/[dir]/[savefile]")
										
										alert("You have migrated the account successfully.", "Account Migration")
									
									else
										fdel("[SAVEFILE_CHARACTERS]/migration/[dir]/[timestamp]_[world.timeofday]-[savefile].backup")
										alert("Savefile migration has failed.", "Account Migration")

								else
									alert("Savefile backup failed, so the account migration was aborted.", "Account Migration")

							else if(!isnull(ckey[2]) && ckey[1] != "Cancel")
								alert("You must provide a ckey to migrate this account to.", "Account Migration")

							break

			Manage_Database()
				set category = "Administrator"
				switch(src.client.prompt("Which database would you like to manage?", "Manage Database", list("Logs", "Cancel")))
					if("Logs")
						switch(src.client.prompt("How would you like to manage this database?", "Manage Database", list("Download", "Cancel")))
							if("Download")
								src << ftp(DATABASE_LOGS)

			Restore_Base()
				set category = "Administrator"
				var/mob/m = input("Who's base would you like to restore?", "Reset Icon") as null|anything in mobs_online
				if(m)
					for(var/obj/Inventory/Clothing/o in m.contents)
						o.suffix = ""

					m.ClothingOverlays = list("Vest"=null,"Shirt"=null,"Pants"=null,"Shoes"=null,"Mask"=null,"Headband"=null,"Sword"=null,"Gloves"=null,"Accessories"=null,"Robes"=null)
					m.ResetBase()
					m.RestoreOverlays()
					m.client.UpdateInventoryPanel()
					m.move_delay = max(0.5, 0.8-((m.agility_total/200)*0.3))

					spawn()
						var/database/query/query = new({"
							INSERT INTO `[db_table_staff]` (`timestamp`, `key`, `character`, `role`, `log`)
							VALUES(?, ?, ?, ?, ?)"},
							time2text(world.realtime, "YYYY-MM-DD hh:mm:ss"), src.client.ckey, src.character, "Administrator", "Restore Base was used on [m.character] ([m.ckey])."
						)
						query.Execute(log_db)
						LogErrorDb(query)
			
			Manage_Testers()
				set category = "Administrator"
				switch(usr.client.prompt("Whould you like to manage alpha or beta testers?", "Manage Testers", list("Alpha Testers", "Beta Testers", "Cancel")))
					if("Alpha Testers")
						switch(usr.client.prompt("Would you like to add or remove alpha testers?", "Manage Testers", list("Add", "Remove", "Cancel")))
							if("Add")
								var/response = usr.client.iprompt("Please enter the ckey of the user you would like to add as an alpha tester.", "Manage Testers", list("Add", "Cancel"))
								if(response[1] == "Add")
									if(!response[2])
										usr.client.prompt("You cannot enter a blank ckey to the alpha testers list.")

									else if(!alpha_testers.Find(response[2]))
										alpha_testers.Add(response[2])
										usr.client.prompt("[response[2]] is now an alpha tester.", "Manage Testers")

									else
										usr.client.prompt("[response[2]] is already an alpha tester.", "Manage Testers")

							if("Remove")
								var/response = usr.client.prompt("Please select the ckey of the user you would like to remove from being alpha tester.", "Manage Testers", alpha_testers + list("Cancel"))
								if(response != "Cancel")
									alpha_testers.Remove(response)
									usr.client.prompt("[response] is no longer an alpha tester.", "Manage Testers")

					if("Beta Testers")
						switch(usr.client.prompt("Would you like to add or remove beta testers?", "Manage Testers", list("Add", "Remove", "Cancel")))
							if("Add")
								var/response = usr.client.iprompt("Please enter the ckey of the user you would like to add as an beta tester.", "Manage Testers", list("Add", "Cancel"))
								if(response[1] == "Add")
									if(!response[2])
										usr.client.prompt("You cannot enter a blank ckey to the beta testers list.")

									else if(!beta_testers.Find(response[2]))
										beta_testers.Add(response[2])
										usr.client.prompt("[response[2]] is now an beta tester.", "Manage Testers")

									else
										usr.client.prompt("[response[2]] is already an beta tester.", "Manage Testers")

							if("Remove")
								var/response = usr.client.prompt("Please select the ckey of the user you would like to remove from being beta tester.", "Manage Testers", beta_testers + list("Cancel"))
								if(response != "Cancel")
									beta_testers.Remove(response)
									usr.client.prompt("[response] is no longer an beta tester.", "Manage Testers")

			Manage_Akatsuki_Leader()
				set category = "Administrator"
				switch(usr.client.prompt("Would you like to promote or demote the [RANK_AKATSUKI_LEADER]?", "Manage Akatsuki", list("Promote", "Demote", "Cancel")))
					if("Promote")
						if(akatsuki_leader.len)
							usr.client.prompt("There is already an [RANK_AKATSUKI_LEADER].", "Manage Akatsuki")
						else
							var/list/exclude = list()
							for(var/mob/m in mobs_online)
								if(m.village != VILLAGE_MISSING_NIN && m.village != VILLAGE_AKATSUKI) exclude += m

							var/mob/m = input("Who would you like to promote to [RANK_AKATSUKI_LEADER]", "Manage Akatsuki") as null|anything in mobs_online - exclude
							if(m)

								var/squad/squad = m.GetSquad()
								if(squad)
									spawn() src.client.prompt("You cannot promote [m.character] to [RANK_AKATSUKI_LEADER] while in a Squad.", "Naruto Evolution")
									spawn() m.client.prompt("You cannot be promoted to [RANK_AKATSUKI_LEADER] while in a Squad.", "Naruto Evolution")
									return 0

								m.SetVillage(VILLAGE_AKATSUKI)
								m.SetRank(RANK_AKATSUKI_LEADER)

								world.UpdateVillageCount()
								spawn() src.client.UpdateWhoAll()

								m.client.StaffCheck()

								world << output("[usr.character] has elected [m.character] into office as the [RANK_AKATSUKI_LEADER] for the <font color='[COLOR_VILLAGE_AKATSUKI]'>[VILLAGE_AKATSUKI]</font>.", "Action.Output")
								
								spawn()
									var/database/query/query = new({"
										INSERT INTO `[db_table_akatsuki]` (`timestamp`, `key`, `character`, `village`, `log`)
										VALUES(?, ?, ?, ?, ?)"},
										time2text(world.realtime, "YYYY-MM-DD hh:mm:ss"), src.client.ckey, src.character, usr.village, "[m.character] ([m.client.ckey]) was elected into office as the [RANK_AKATSUKI_LEADER] for the [VILLAGE_AKATSUKI]."
									)
									query.Execute(log_db)
									LogErrorDb(query)

					if("Demote")
						if(akatsuki_leader.len)
							switch(usr.client.prompt("Are you sure you want to demote the [VILLAGE_AKATSUKI] [RANK_AKATSUKI_LEADER]?", "Manage Akatsuki", list("Demote", "Cancel")))
								if("Demote")
									world << output("The [RANK_AKATSUKI_LEADER] for the <font color='[COLOR_VILLAGE_AKATSUKI]'>[VILLAGE_AKATSUKI]</font> was forced out of office by [usr.character].", "Action.Output")
									
									spawn()
										var/database/query/query = new({"
											INSERT INTO `[db_table_akatsuki]` (`timestamp`, `key`, `character`, `village`, `log`)
											VALUES(?, ?, ?, ?, ?)"},
											time2text(world.realtime, "YYYY-MM-DD hh:mm:ss"), src.client.ckey, src.character, src.village, "The [RANK_AKATSUKI_LEADER] [global.GetAkatsukiLeader(RETURN_FORMAT_CHARACTER)] ([global.GetAkatsukiLeader()]) for the [VILLAGE_AKATSUKI] was forced out of office."
										)
										query.Execute(log_db)
										LogErrorDb(query)

									akatsuki_leader = list()
									akatsuki_last_online = null

									for(var/mob/m in mobs_online)
										m.client.StaffCheck()
						else
							usr.client.prompt("There isn't a [RANK_AKATSUKI_LEADER] currently in office for the [VILLAGE_AKATSUKI].", "Manage Akatsuki")

			Manage_Kages()
				set category = "Administrator"
				switch(usr.client.prompt("Which village Kage would you like to manage?", "Manage Kages", list("[VILLAGE_LEAF]", "[VILLAGE_SAND]", "Cancel")))
					if(VILLAGE_LEAF)
						switch(usr.client.prompt("Would you like to promote or demote the [RANK_HOKAGE] for the [VILLAGE_LEAF]?", "Manage Kages", list("Promote", "Demote", "Cancel")))
							if("Promote")
								if(hokage.len)
									usr.client.prompt("There is already a [RANK_HOKAGE] for the [VILLAGE_LEAF].", "Manage Kages")
								else
									var/list/exclude = list()
									for(var/mob/m in mobs_online)
										if(m.village != VILLAGE_LEAF) exclude += m

									var/mob/m = input("Who would you like to promote to [RANK_HOKAGE]", "Manage Kages") as null|anything in mobs_online - exclude
									if(m)
										m.SetRank(RANK_HOKAGE)

										var/squad/squad = m.GetSquad()
										if(squad)
											spawn() squad.Refresh()

										m.client.StaffCheck()

										world << output("[usr.character] has elected [m.character] into office as the [RANK_HOKAGE] for the <font color='[COLOR_VILLAGE_LEAF]'>[VILLAGE_LEAF]</font>.", "Action.Output")
										
										spawn()
											var/database/query/query = new({"
												INSERT INTO `[db_table_kage]` (`timestamp`, `key`, `character`, `village`, `log`)
												VALUES(?, ?, ?, ?, ?)"},
												time2text(world.realtime, "YYYY-MM-DD hh:mm:ss"), src.client.ckey, src.character, src.village, "[m.character] ([m.client.ckey]) was elected into office as the [RANK_HOKAGE] for the [VILLAGE_LEAF]."
											)
											query.Execute(log_db)
											LogErrorDb(query)

							if("Demote")
								if(hokage.len)
									switch(usr.client.prompt("Are you sure you want to demote the [VILLAGE_LEAF] [RANK_HOKAGE]?", "Manage Kages", list("Demote", "Cancel")))
										if("Demote")
											world << output("The [RANK_HOKAGE] for the <font color='[COLOR_VILLAGE_LEAF]'>[VILLAGE_LEAF]</font> was forced out of office by [usr.character].", "Action.Output")

											spawn()
												var/database/query/query = new({"
													INSERT INTO `[db_table_kage]` (`timestamp`, `key`, `character`, `village`, `log`)
													VALUES(?, ?, ?, ?, ?)"},
													time2text(world.realtime, "YYYY-MM-DD hh:mm:ss"), src.client.ckey, src.character, src.village, "The [RANK_HOKAGE] [global.GetHokage(RETURN_FORMAT_CHARACTER)] ([global.GetHokage()]) for the [VILLAGE_LEAF] was forced out of office."
												)
												query.Execute(log_db)
												LogErrorDb(query)
											
											hokage = list()
											kages_last_online[VILLAGE_LEAF] = null

											for(var/mob/m in mobs_online)
												m.client.StaffCheck()
								else
									usr.client.prompt("There isn't a [RANK_HOKAGE] currently in office for the [VILLAGE_LEAF].", "Manage Kages")

					if(VILLAGE_SAND)
						switch(usr.client.prompt("Would you like to promote or demote the [RANK_KAZEKAGE] for the [VILLAGE_SAND]?", "Manage Kages", list("Promote", "Demote", "Cancel")))
							if("Promote")
								if(kazekage.len)
									usr.client.prompt("There is already a [RANK_KAZEKAGE] for the [VILLAGE_SAND].", "Manage Kages")
								else
									var/list/exclude = list()
									for(var/mob/m in mobs_online)
										if(m.village != VILLAGE_SAND) exclude += m

									var/mob/m = input("Who would you like to promote to [RANK_KAZEKAGE]", "Manage Kages") as null|anything in mobs_online - exclude
									if(m)
										m.SetRank(RANK_KAZEKAGE)

										var/squad/squad = m.GetSquad()
										if(squad)
											spawn() squad.Refresh()

										m.client.StaffCheck()

										world << output("[usr] has elected [m.character] into office as the [RANK_KAZEKAGE] for the <font color='[COLOR_VILLAGE_SAND]'>[VILLAGE_SAND]</font>.", "Action.Output")
										
										spawn()
											var/database/query/query = new({"
												INSERT INTO `[db_table_kage]` (`timestamp`, `key`, `character`, `village`, `log`)
												VALUES(?, ?, ?, ?, ?)"},
												time2text(world.realtime, "YYYY-MM-DD hh:mm:ss"), src.client.ckey, src.character, src.village, "[m.character] ([m.client.ckey]) was elected into office as the [RANK_KAZEKAGE] for the [VILLAGE_SAND]."
											)
											query.Execute(log_db)
											LogErrorDb(query)
										
							if("Demote")
								if(kazekage.len)
									switch(usr.client.prompt("Are you sure you want to demote the [VILLAGE_SAND] [RANK_KAZEKAGE]?", "Manage Kages", list("Demote", "Cancel")))
										if("Demote")
											world << output("The elected [RANK_KAZEKAGE] for the <font color='[COLOR_VILLAGE_SAND]'>[VILLAGE_SAND]</font> was forced out of office by [usr.character].", "Action.Output")
											
											spawn()
												var/database/query/query = new({"
													INSERT INTO `[db_table_kage]` (`timestamp`, `key`, `character`, `village`, `log`)
													VALUES(?, ?, ?, ?, ?)"},
													time2text(world.realtime, "YYYY-MM-DD hh:mm:ss"), src.client.ckey, src.character, src.village, "The elected [RANK_KAZEKAGE] [global.GetKazekage(RETURN_FORMAT_CHARACTER)] ([global.GetKazekage()]) for the [VILLAGE_SAND] was forced out of office."
												)
												query.Execute(log_db)
												LogErrorDb(query)
											
											kazekage = list()
											kages_last_online[VILLAGE_SAND] = null

											for(var/mob/m in mobs_online)
												m.client.StaffCheck()
								else
									usr.client.prompt("There isn't a [RANK_KAZEKAGE] currently in office for the [VILLAGE_SAND].", "Manage Kages")

			Manage_Mission()
				set category = "Administrator"
				var/mob/M = input("Who's mission would you like to manage?", "Manage Mission") as null|anything in mobs_online
				var/squad/squad = M.GetSquad()
				if(M)
					switch(src.client.prompt("Would you like to complete or fail the mission for [M.character]'s Squad?", "Manage Mission", list("Complete", "Fail", "Cancel")))
						if("Complete")
							if(M)
								squad.mission.Complete(M)

								spawn()
									var/database/query/query = new({"
										INSERT INTO `[db_table_staff]` (`timestamp`, `key`, `character`, `role`, `log`)
										VALUES(?, ?, ?, ?, ?)"},
										time2text(world.realtime, "YYYY-MM-DD hh:mm:ss"), src.client.ckey, src.character, "Administrator", "[usr.character] ([usr.ckey]) has completed [M.character]'s mission for their entire Squad."
									)
									query.Execute(log_db)
									LogErrorDb(query)

								if(src.client.prompt("Would you like to reset mission cooldown for [M.character]'s Squad?", "Manage Mission", list("Yes", "No")) == "Yes")
									for(var/mob/m in mobs_online)
										if(m && squad == m.GetSquad())
											m.client.last_mission = null
											var/savefile/F = new("[SAVEFILE_CLIENT]/[copytext(m.client.ckey, 1, 2)]/[m.client.ckey].sav")
											F["last_mission"] << null
									
									spawn()
										var/database/query/query = new({"
											INSERT INTO `[db_table_staff]` (`timestamp`, `key`, `character`, `role`, `log`)
											VALUES(?, ?, ?, ?, ?)"},
											time2text(world.realtime, "YYYY-MM-DD hh:mm:ss"), src.client.ckey, src.character, "Administrator", "[usr.character] ([usr.ckey]) has reset the mission cooldown for [M.character]'s entire Squad."
										)
										query.Execute(log_db)
										LogErrorDb(query)

							else
								src.client.prompt("[M.character] isn't currently in a Squad.", "Manage Mission")

						if("Fail")
							if(M)
								if(squad.mission)
									squad.mission.status = "Failure"
									squad.mission.complete = world.realtime

									spawn()
										var/database/query/query = new({"
											INSERT INTO `[db_table_staff]` (`timestamp`, `key`, `character`, `role`, `log`)
											VALUES(?, ?, ?, ?, ?)"},
											time2text(world.realtime, "YYYY-MM-DD hh:mm:ss"), src.client.ckey, src.character, "Administrator", "[src.character] ([src.ckey]) has failed [M.character]'s mission for their entire Squad."
										)
										query.Execute(log_db)
										LogErrorDb(query)

								if(src.client.prompt("Would you like to reset mission cooldown for [M.character]'s Squad?", "Manage Mission", list("Yes", "No")) == "Yes")
									for(var/mob/m in mobs_online)
										if(m && squad == m.GetSquad())
											m.client.last_mission = null
											var/savefile/F = new("[SAVEFILE_CLIENT]/[copytext(m.client.ckey, 1, 2)]/[m.client.ckey].sav")
											F["last_mission"] << null
									
									spawn()
										var/database/query/query = new({"
											INSERT INTO `[db_table_staff]` (`timestamp`, `key`, `character`, `role`, `log`)
											VALUES(?, ?, ?, ?, ?)"},
											time2text(world.realtime, "YYYY-MM-DD hh:mm:ss"), src.client.ckey, src.character, "Administrator", "[src.character] ([src.ckey]) has reset the mission cooldown for [M.character]'s entire Squad."
										)
										query.Execute(log_db)
										LogErrorDb(query)

							else
								src.client.prompt("[M.character] isn't currently in a Squad.", "Manage Mission")

				else
					src.client.prompt("[M.character] isn't currently in a Squad.", "Manage Mission")

			Change_Name()
				set category = "Administrator"
				var/mob/M = input("Who would you like to rename?", "Change Name") as null|anything in mobs_online
				if(M)
					var/name = input("What would you like to rename [M.character] to?", "Change Name", M.character) as null|text
					if(name)
						if(M.client && lowertext(M.character) != lowertext(name) && names_taken.Find(lowertext(name)))
							alert("The name [name] is already in use.", "Change Name")
							return 0
						else
							switch(alert("Please choose a font color for [M.character].", "Change Name", "Village", "Custom"))
								if("Village")
									M.name_color_custom = null

								if("Custom")
									var/color = input("What custom character name color would you like for [M.character]?") as null|color
									if(color) M.name_color_custom = color

							if(M)
								var/old_character = M.character
								var/old_name = M.character
								var/old_src_name = usr.character

								names_taken.Remove(lowertext(old_character))
								names_taken.Add(lowertext(name))

								M.character = name
								M.SetName(name)

								if(hokage[M.client.ckey] == old_character)
									hokage[M.client.ckey] = M.character

								if(kazekage[M.client.ckey] == old_character)
									kazekage[M.client.ckey] = M.character

								if(akatsuki_leader[M.client.ckey] == old_character)
									akatsuki_leader[M.client.ckey] = M.character

								for(var/squad/squad in squads)
									if(squad.leader[M.client.ckey] == old_character)
										squad.leader[M.client.ckey] = M.character

									if(squad.members[M.client.ckey] == old_character)
										squad.members[M.client.ckey] = M.character

								for(var/election_ballot/ballot in hokage_election_ballot)
									if(ballot.ckey == M.client.ckey && ballot.character == M.character)
										ballot.character = name

								for(var/election_ballot/ballot in kazekage_election_ballot)
									if(ballot.ckey == M.client.ckey && ballot.character == M.character)
										ballot.character = name

								var/squad/squad = M.GetSquad()
								if(squad) spawn() squad.Refresh()

								spawn() M.client.UpdateCharacterPanel()

								M.Save()
								M.client.Save()

								fdel("[SAVEFILE_CHARACTERS]/[copytext(M.ckey, 1, 2)]/[M.ckey] ([lowertext(old_character)]).sav")

								usr << output("You have changed [old_name]'s character name to <u>[name]</u>.", "Action.Output")
								M << output("[old_src_name] has changed your character name to <u>[name]</u>.", "Action.Output")
								spawn() M.client.prompt({"
									[old_src_name] has changed your character name to <u>[name]</u>.
									<br /><br />
									<font color='#BE1A0E'><b><u>Warning:</u></b></font>
									<br />
									You will need to use your updated character name to login."})
								
								spawn()
									var/database/query/query = new({"
										INSERT INTO `[db_table_staff]` (`timestamp`, `key`, `character`, `role`, `log`)
										VALUES(?, ?, ?, ?, ?)"},
										time2text(world.realtime, "YYYY-MM-DD hh:mm:ss"), src.client.ckey, src.character, "Administrator", "[M.character]'s ([M.ckey]) character name was changed to [name] ([M.ckey])."
									)
									query.Execute(log_db)
									LogErrorDb(query)

			Manage_Names()
				set category = "Administrator"
				switch(alert("Would you like to add or remove a name from the list of taken character names?", "Manage Names", "Add", "Remove"))
					if("Add")
						var/name = input("What character name would you like to add to the list of taken character names?", "Manage Names") as null|text

						if(name)
							names_taken.Add(name)

							spawn()
								var/database/query/query = new({"
									INSERT INTO `[db_table_staff]` (`timestamp`, `key`, `character`, `role`, `log`)
									VALUES(?, ?, ?, ?, ?)"},
									time2text(world.realtime, "YYYY-MM-DD hh:mm:ss"), src.client.ckey, src.character, "Administrator", "[name] was added to the list of taken character names."
								)
								query.Execute(log_db)
								LogErrorDb(query)

							alert("The character name, [name], has been added to the list of taken character names.", "Manage Names")

					if("Remove")
						var/name = input("Which character name would you like to remove from the list of taken character names?", "Manage Names") as null|anything in names_taken

						if(name)
							names_taken.Remove(name)

							spawn()
								var/database/query/query = new({"
									INSERT INTO `[db_table_staff]` (`timestamp`, `key`, `character`, `role`, `log`)
									VALUES(?, ?, ?, ?, ?)"},
									time2text(world.realtime, "YYYY-MM-DD hh:mm:ss"), src.client.ckey, src.character, "Administrator", "[name] was removed from the list of taken character names."
								)
								query.Execute(log_db)
								LogErrorDb(query)

							alert("The character name, [name], has been removed from the list of taken character names.", "Manage Names")

			Change_Password()
				set category = "Administrator"

				var/list/savefile_dirs = flist("[SAVEFILE_CHARACTERS]/")
				var/list/savefile_list = list()

				for(var/dir in savefile_dirs)
					savefile_list.Add(flist("[SAVEFILE_CHARACTERS]/[dir]"))

				for(var/sav in savefile_list)
					if(findlasttext(sav, ".sav.lk")) savefile_list.Remove(sav)
					if(findlasttext(sav, ".sav.backup")) savefile_list.Remove(sav)
					if(findlasttext(sav, ".sav.migration")) savefile_list.Remove(sav)
					if(findlasttext(sav, ".sav") == 0) savefile_list.Remove(sav)

				var/savefile = input("Select which savefile you'd like to update the account password to.") as null|anything in savefile_list

				if(savefile)
					for(var/dir in savefile_dirs)

						if(fexists("[SAVEFILE_CHARACTERS]/[dir]/[savefile].lk"))
							alert("This savefile is locked and cannot be modified.", "Change Password")

							break

						else if(fexists("[SAVEFILE_CHARACTERS]/[dir]/[savefile]"))
							var/password = input("Please enter a new password for the savefile: [savefile].", "Change Password") as null|text
							if(password)
								if(fcopy("[SAVEFILE_CHARACTERS]/[dir]/[savefile]", "[SAVEFILE_CHARACTERS]/[dir]/[time2text(world.realtime, "YYYY-MM-DD")]_[world.timeofday]-[savefile].backup"))
									var/savefile/F = new(savefile)
									password = sha1("[password][sha1(ckey(F["key"]))]")
									F["password_hotfix"] << password

									spawn()
										var/database/query/query = new({"
											INSERT INTO `[db_table_staff]` (`timestamp`, `key`, `character`, `role`, `log`)
											VALUES(?, ?, ?, ?, ?)"},
											time2text(world.realtime, "YYYY-MM-DD hh:mm:ss"), src.client.ckey, src.character, "Administrator", "The password was changed for the savefile: [savefile]."
										)
										query.Execute(log_db)
										LogErrorDb(query)
									
									alert("You have updated the password for the savefile: [savefile].", "Change Password")

								else
									alert("Savefile backup failed, so the savefile password was not updated.", "Change Password")

							else if(!isnull(password))
								alert("The password may not be blank.", "Change Password")

							break

			Change_Ryo()
				set category = "Administrator"
				var/mob/M = input("Who would you like to give or take Ryo from?", "Change Ryo") as null|anything in mobs_online
				if(M)
					switch(alert("Would you like to give or take Ryo from [M.character]?", "Change Ryo", "Give", "Take", "Cancel"))
						if("Give")
							var/ryo = input("How much Ryo would you like to give to [M.character]?", "Change Ryo") as null|num
							if(ryo < 0) ryo = 0

							if(M)
								M.SetRyo(M.ryo + ryo)
								usr.client << output("You have given <b>[ryo]</b> Ryo to [M.character].","Action.Output")
								M.client << output("[usr] has given you <b>[ryo]</b> Ryo.","Action.Output")

								spawn()
									var/database/query/query = new({"
										INSERT INTO `[db_table_staff]` (`timestamp`, `key`, `character`, `role`, `log`)
										VALUES(?, ?, ?, ?, ?)"},
										time2text(world.realtime, "YYYY-MM-DD hh:mm:ss"), src.client.ckey, src.character, "Administrator", "[M.character] ([M.ckey]) was given [ryo] ryo."
									)
									query.Execute(log_db)
									LogErrorDb(query)

						if("Take")
							var/ryo = input("How much Ryo would you like to take from [M.character]?", "Change Ryo") as null|num
							if(ryo < 0) ryo = 0

							if(M)
								M.SetRyo(M.ryo - ryo)
								usr.client << output("You have taken <b>[ryo]</b> Ryo from [M.character].","Action.Output")
								M.client << output("[usr] has taken <b>[ryo]</b> Ryo from you.","Action.Output")

								spawn()
									var/database/query/query = new({"
										INSERT INTO `[db_table_staff]` (`timestamp`, `key`, `character`, `role`, `log`)
										VALUES(?, ?, ?, ?, ?)"},
										time2text(world.realtime, "YYYY-MM-DD hh:mm:ss"), src.client.ckey, src.character, "Administrator", "[ryo] ryo was taken from [M.character] ([M.ckey])."
									)
									query.Execute(log_db)
									LogErrorDb(query)

			Change_Village()
				set category = "Administrator"
				var/mob/M = input("Who's village would you like to change?", "Change Rank") as null|anything in mobs_online
				if(M)
					switch(input("What would you like to change [M.character]'s village to?") as null|anything in list(VILLAGE_LEAF, VILLAGE_SAND, VILLAGE_AKATSUKI, VILLAGE_MISSING_NIN))
						if(VILLAGE_LEAF)
							if(M)
								var/squad/squad = M.GetSquad()
								if(squad)
									spawn() src.client.prompt("You change [M.character]'s village while they're in a Squad.", "Naruto Evolution")
									return 0

								usr.client << output("You have changed [M.character]'s village from [M.village] to [VILLAGE_LEAF].","Action.Output")
								M.client << output("[usr] has changed your village from [M.village] to [VILLAGE_LEAF].","Action.Output")

								spawn()
									var/database/query/query = new({"
										INSERT INTO `[db_table_staff]` (`timestamp`, `key`, `character`, `role`, `log`)
										VALUES(?, ?, ?, ?, ?)"},
										time2text(world.realtime, "YYYY-MM-DD hh:mm:ss"), src.client.ckey, src.character, "Administrator", "[M.character] ([M.ckey])'s village was changed from [M.village] to [VILLAGE_LEAF].<br />"
									)
									query.Execute(log_db)
									LogErrorDb(query)

								M.SetVillage(VILLAGE_LEAF)

								world.UpdateVillageCount()
								spawn() src.client.UpdateWhoAll()

						if(VILLAGE_SAND)
							if(M)
								var/squad/squad = M.GetSquad()
								if(squad)
									spawn() src.client.prompt("You change [M.character]'s village while they're in a Squad.", "Naruto Evolution")
									return 0

								usr.client << output("You have changed [M.character]'s village from [M.village] to [VILLAGE_SAND].","Action.Output")
								M.client << output("[usr] has changed your village from [M.village] to [VILLAGE_SAND].","Action.Output")

								spawn()
									var/database/query/query = new({"
										INSERT INTO `[db_table_staff]` (`timestamp`, `key`, `character`, `role`, `log`)
										VALUES(?, ?, ?, ?, ?)"},
										time2text(world.realtime, "YYYY-MM-DD hh:mm:ss"), src.client.ckey, src.character, "Administrator", "[M.character] ([M.ckey])'s village was changed from [M.village] to [VILLAGE_SAND].<br />"
									)
									query.Execute(log_db)
									LogErrorDb(query)

								M.SetVillage(VILLAGE_SAND)

								world.UpdateVillageCount()
								spawn() src.client.UpdateWhoAll()

						if(VILLAGE_AKATSUKI)
							if(M)
								if(akatsuki_members.len >= 9)
									spawn() src.client.prompt("The [VILLAGE_AKATSUKI] are already full.", "Naruto Evolution")
									return 0
								var/squad/squad = M.GetSquad()
								if(squad)
									spawn() src.client.prompt("You change [M.character]'s village while they're in a Squad.", "Naruto Evolution")
									return 0

								usr.client << output("You have changed [M.character]'s village from [M.village] to [VILLAGE_AKATSUKI].","Action.Output")
								M.client << output("[usr] has changed your village from [M.village] to [VILLAGE_AKATSUKI].","Action.Output")

								spawn()
									var/database/query/query = new({"
										INSERT INTO `[db_table_staff]` (`timestamp`, `key`, `character`, `role`, `log`)
										VALUES(?, ?, ?, ?, ?)"},
										time2text(world.realtime, "YYYY-MM-DD hh:mm:ss"), src.client.ckey, src.character, "Administrator", "[M.character] ([M.ckey])'s village was changed from [M.village] to [VILLAGE_AKATSUKI].<br />"
									)
									query.Execute(log_db)
									LogErrorDb(query)

								M.SetVillage(VILLAGE_AKATSUKI)

								world.UpdateVillageCount()
								spawn() src.client.UpdateWhoAll()

						if(VILLAGE_MISSING_NIN)
							if(M)
								var/squad/squad = M.GetSquad()
								if(squad)
									spawn() src.client.prompt("You change [M.character]'s village while they're in a Squad.", "Naruto Evolution")
									return 0

								usr.client << output("You have changed [M.character]'s village from [M.village] to [VILLAGE_MISSING_NIN].","Action.Output")
								M.client << output("[usr] has changed your village from [M.village] to [VILLAGE_MISSING_NIN].","Action.Output")

								spawn()
									var/database/query/query = new({"
										INSERT INTO `[db_table_staff]` (`timestamp`, `key`, `character`, `role`, `log`)
										VALUES(?, ?, ?, ?, ?)"},
										time2text(world.realtime, "YYYY-MM-DD hh:mm:ss"), src.client.ckey, src.character, "Administrator", "[M.character] ([M.ckey])'s village was changed from [M.village] to [VILLAGE_MISSING_NIN].<br />"
									)
									query.Execute(log_db)
									LogErrorDb(query)
								
								M.SetVillage(VILLAGE_MISSING_NIN)

								world.UpdateVillageCount()
								spawn() src.client.UpdateWhoAll()

			Change_Rank()
				set category = "Administrator"
				var/mob/M = input("Who's rank would you like to change?", "Change Rank") as null|anything in mobs_online
				if(M)
					switch(input("What would you like to change [M.character]'s rank to?") as null|anything in list(RANK_ACADEMY_STUDENT, RANK_GENIN, RANK_CHUUNIN, RANK_JOUNIN, RANK_ANBU))
						if(RANK_ACADEMY_STUDENT)
							if(M)
								usr.client << output("You have changed [M.character]'s rank from [M.rank] to [RANK_ACADEMY_STUDENT].","Action.Output")
								M.client << output("[usr] has changed your rank from [M.rank] to [RANK_ACADEMY_STUDENT].","Action.Output")

								spawn()
									var/database/query/query = new({"
										INSERT INTO `[db_table_staff]` (`timestamp`, `key`, `character`, `role`, `log`)
										VALUES(?, ?, ?, ?, ?)"},
										time2text(world.realtime, "YYYY-MM-DD hh:mm:ss"), src.client.ckey, src.character, "Administrator", "[M.character] ([M.ckey])'s rank was changed from [M.rank] to [RANK_ACADEMY_STUDENT].<br />"
									)
									query.Execute(log_db)
									LogErrorDb(query)

								M.SetRank(RANK_ACADEMY_STUDENT)

						if(RANK_GENIN)
							if(M)
								usr.client << output("You have changed [M.character]'s rank from [M.rank] to [RANK_GENIN].","Action.Output")
								M.client << output("[usr] has changed your rank from [M.rank] to [RANK_GENIN].","Action.Output")

								spawn()
									var/database/query/query = new({"
										INSERT INTO `[db_table_staff]` (`timestamp`, `key`, `character`, `role`, `log`)
										VALUES(?, ?, ?, ?, ?)"},
										time2text(world.realtime, "YYYY-MM-DD hh:mm:ss"), src.client.ckey, src.character, "Administrator", "[M.character] ([M.ckey])'s rank was changed from [M.rank] to [RANK_GENIN].<br />"
									)
									query.Execute(log_db)
									LogErrorDb(query)

								M.SetRank(RANK_GENIN)

						if(RANK_CHUUNIN)
							if(M)
								usr.client << output("You have changed [M.character]'s rank from [M.rank] to [RANK_CHUUNIN].","Action.Output")
								M.client << output("[usr] has changed your rank from [M.rank] to [RANK_CHUUNIN].","Action.Output")

								spawn()
									var/database/query/query = new({"
										INSERT INTO `[db_table_staff]` (`timestamp`, `key`, `character`, `role`, `log`)
										VALUES(?, ?, ?, ?, ?)"},
										time2text(world.realtime, "YYYY-MM-DD hh:mm:ss"), src.client.ckey, src.character, "Administrator", "[M.character] ([M.ckey])'s rank was changed from [M.rank] to [RANK_CHUUNIN].<br />"
									)
									query.Execute(log_db)
									LogErrorDb(query)

								M.SetRank(RANK_CHUUNIN)

						if(RANK_JOUNIN)
							if(M)
								usr.client << output("You have changed [M.character]'s rank from [M.rank] to [RANK_JOUNIN].","Action.Output")
								M.client << output("[usr] has changed your rank from [M.rank] to [RANK_JOUNIN].","Action.Output")

								spawn()
									var/database/query/query = new({"
										INSERT INTO `[db_table_staff]` (`timestamp`, `key`, `character`, `role`, `log`)
										VALUES(?, ?, ?, ?, ?)"},
										time2text(world.realtime, "YYYY-MM-DD hh:mm:ss"), src.client.ckey, src.character, "Administrator", "[M.character] ([M.ckey])'s rank was changed from [M.rank] to [RANK_JOUNIN].<br />"
									)
									query.Execute(log_db)
									LogErrorDb(query)

								M.SetRank(RANK_JOUNIN)

						if(RANK_ANBU)
							if(M)
								usr.client << output("You have changed [M.character]'s rank from [M.rank] to [RANK_ANBU].","Action.Output")
								M.client << output("[usr] has changed your rank from [M.rank] to [RANK_ANBU].","Action.Output")
								
								spawn()
									var/database/query/query = new({"
										INSERT INTO `[db_table_staff]` (`timestamp`, `key`, `character`, `role`, `log`)
										VALUES(?, ?, ?, ?, ?)"},
										time2text(world.realtime, "YYYY-MM-DD hh:mm:ss"), src.client.ckey, src.character, "Administrator", "[M.character] ([M.ckey])'s rank was changed from [M.rank] to [RANK_ANBU].<br />"
									)
									query.Execute(log_db)
									LogErrorDb(query)

								M.SetRank(RANK_ANBU)

			Give_Everything()
				set category="Administrator"
				var/client/C = input("Who would you like to give everything?", "Give Everything") as null | anything in clients_online
				if(C == "Cancel") return
				if(usr.ckey in administrators)
					if(C.ckey in administrators)
						switch(usr.client.prompt("Are you sure you want to give everything to [C.mob.character]?", "Give Everything", list("Yes", "No")))
							if("Yes")
								var/list/excluded_jutsu = list(/obj/Jutsus)
								excluded_jutsu += typesof(/obj/Jutsus/Effects)

								for(var/obj/Jutsus/jutsu in C.mob.jutsus)
									excluded_jutsu += jutsu.type

								for(var/type in typesof(/obj/Jutsus) - excluded_jutsu)
									var/obj/Jutsus/jutsu = new type

									C.mob.jutsus += jutsu
									C.mob.jutsus_learned += jutsu.type
									jutsu.owner = C.ckey
									jutsu.level = 4
									jutsu.uses = 100

									C.mob.skillpoints = 100
									C.mob.statpoints = 100
									C.mob.maxchakra = 10000
									C.mob.chakra = C.mob.maxchakra
									C.mob.maxhealth = 10000
									C.mob.health = C.mob.maxhealth
									C.mob.taijutsu = 100
									C.mob.taijutsu_stated = 100
									C.mob.ninjutsu = 100
									C.mob.ninjutsu_stated = 100
									C.mob.genjutsu = 100
									C.mob.genjutsu_stated = 100
									C.mob.defence = 100
									C.mob.defence_stated = 100
									C.mob.agility = 100
									C.mob.agility_stated = 100
									C.mob.precision = 100
									C.mob.precision_stated = 100
									C.mob.level = 100

								C.UpdateJutsuPanel()

								usr.client << output("You have used <u>Give Everything</u> on [C.mob.character].", "Action.Output")
								C << output("[usr.character] has used <u>Give Everything</u> on you.", "Action.Output")

								spawn()
									var/database/query/query = new({"
										INSERT INTO `[db_table_staff]` (`timestamp`, `key`, `character`, `role`, `log`)
										VALUES(?, ?, ?, ?, ?)"},
										time2text(world.realtime, "YYYY-MM-DD hh:mm:ss"), src.client.ckey, src.character, "Administrator", "Give Everything was used on [C.mob.character] ([C.key]).<br />"
									)
									query.Execute(log_db)
									LogErrorDb(query)

					else
						spawn()
							var/database/query/query = new({"
								INSERT INTO `[db_table_staff]` (`timestamp`, `key`, `character`, `role`, `log`)
								VALUES(?, ?, ?, ?, ?)"},
								time2text(world.realtime, "YYYY-MM-DD hh:mm:ss"), src.client.ckey, src.character, "Administrator", "Give Everything was attempted to be used on [C.mob.character] ([C.key]).<br />"
							)
							query.Execute(log_db)
							LogErrorDb(query)

						usr.client.prompt("You can only use this command on Administrators.")
				else
					usr.client.prompt("This command is restricted to Administrators.")

mob
	moderator
		verb
			Placeholder()
				set category = "Moderator"

mob
	programmer
		verb
			Placeholder()
				set category = "Programmer"

mob
	pixel_artist
		verb
			Placeholder()
				set category = "Pixel Artist"

mob
	akatsuki
		verb
			Manage_Members()
				set category = "Akatsuki"
				switch(usr.client.prompt("Would you like to invite or boot ninja from the [VILLAGE_AKATSUKI]?", "Manage Members", list("Invite", "Exile", "Cancel")))
					if("Invite")		
						var/list/exclude = list(usr)
						for(var/mob/m in mobs_online)
							if(m.village != VILLAGE_MISSING_NIN) exclude += m

						var/mob/m = input("Who would you like to invite to the [VILLAGE_AKATSUKI]", "Manage Members") as null|anything in mobs_online - exclude

						if(akatsuki_members.len >= 9)
							usr.client.prompt("The [VILLAGE_AKATSUKI] is already full, you need to boot someone to invite anyone else.", "Manage Members")
							return

						if(m)
							if(m.village == VILLAGE_MISSING_NIN)
								switch(m.client.prompt("The [usr.rank], [usr.character], formally invites you to join the [usr.village]. Do you accept this invitation?", "Akatsuki Invitation", list("Yes", "No")))
									if("Yes")
										if(akatsuki_members.len >= 9)
											usr.client.prompt("The [VILLAGE_AKATSUKI] is already full.", "Manage Members")
											return

										var/obj/required_item
										for(var/obj/Inventory/Akatsuki_Items/Seal_of_the_Crimson_Cloud/item in m.contents)
											if(item) required_item = item
										
										if(!required_item)
											spawn() usr.client.prompt("This ninja is unable to present you with a <font color='[COLOR_VILLAGE_AKATSUKI]'>Seal of the Crimson Clouds</font>. They must prove themselves a lamb of the cause like you yourself did once before.", "Manage Members")
											spawn() m.client.prompt("You are asked to present a <font color='[COLOR_VILLAGE_AKATSUKI]'>Seal of the Crimson Clouds</font> but you don't have such an item. You must prove yourself a lamb of the cause by slaughtering those foolish shinobi villages when they try to prevent the <font color='[COLOR_VILLAGE_AKATSUKI]'>[VILLAGE_AKATSUKI]</font> from achieving their goal.", "Manage Members")
											return

										if(m.village == VILLAGE_MISSING_NIN)

											var/squad/squad = m.GetSquad()
											if(squad)
												spawn() src.client.prompt("You cannot invite someone who is in a Squad.", "Naruto Evolution")
												spawn() m.client.prompt("You cannot join a village while in a Squad.", "Naruto Evolution")
												return 0

											spawn() usr.client.prompt("[m.character] has accepted your invitation to join the [usr.village].")

											spawn()
												var/database/query/query = new({"
													INSERT INTO `[db_table_akatsuki]` (`timestamp`, `key`, `character`, `village`, `log`)
													VALUES(?, ?, ?, ?, ?)"},
													time2text(world.realtime, "YYYY-MM-DD hh:mm:ss"), global.GetAkatsukiLeader(), global.GetAkatsukiLeader(RETURN_FORMAT_CHARACTER), VILLAGE_AKATSUKI, "[m.character] ([m.ckey]) has accepted the invitation to join the [VILLAGE_AKATSUKI]."
												)
												query.Execute(log_db)
												LogErrorDb(query)

											m.SetVillage(usr.village)
											m.SetRank(RANK_AKATSUKI)
											world.UpdateVillageCount()
											akatsuki_members += m.character

											spawn() src.client.UpdateWhoAll()

										else
											spawn() usr.client.prompt("[m.character] is no longer a [VILLAGE_MISSING_NIN] and is therefore unable to join the [usr.village].")
											spawn() m.client.prompt("You are no longer a [VILLAGE_MISSING_NIN] and are therefore unable to join the [usr.village].")

									if("No")
										spawn() usr.client.prompt("[m.character] has rejected your invitation to join the [usr.village].")

										spawn()
											var/database/query/query = new({"
												INSERT INTO `[db_table_akatsuki]` (`timestamp`, `key`, `character`, `village`, `log`)
												VALUES(?, ?, ?, ?, ?)"},
												time2text(world.realtime, "YYYY-MM-DD hh:mm:ss"), global.GetAkatsukiLeader(), global.GetAkatsukiLeader(RETURN_FORMAT_CHARACTER), VILLAGE_AKATSUKI, "[m.character] ([m.ckey]) has rejected the invitation to join the [VILLAGE_AKATSUKI]."
											)
											query.Execute(log_db)
											LogErrorDb(query)

							else
								usr.client.prompt("You can't send a village invitation to [m.character] because they are not a [VILLAGE_MISSING_NIN].", "Manage Members")

						else
							usr.client.prompt("The ninja you were going to invite is no longer online and is therefore unable to be invited.", "Manage Members")

					if("Exile")
						var/list/exclude = list(usr)
						for(var/mob/m in mobs_online)
							if(m.village != usr.village) exclude += m

						var/mem = input("Who would you like to boot from the [usr.village]?", "Manage Members") as null|anything in akatsuki_members

						var/mob/m
						for(var/mob/check in mobs_online)
							if(check.character == mem) m = check
							break

						if(m)
							if(m.village == usr.village)

								var/squad/squad = m.GetSquad()
								if(squad)
									spawn() src.client.prompt("You can't exile [m.character] from the [usr.village] village because they are currently in a Squad.")
									return 0

								spawn() usr.client.prompt("You have formally exiled [m.character] from the [usr.village].", "Member Exile")
								spawn() m.client.prompt("The [usr.rank], [usr.character], formally exiles you from the [usr.village].", "Member Exile")

								spawn()
									var/database/query/query = new({"
										INSERT INTO `[db_table_akatsuki]` (`timestamp`, `key`, `character`, `village`, `log`)
										VALUES(?, ?, ?, ?, ?)"},
										time2text(world.realtime, "YYYY-MM-DD hh:mm:ss"), global.GetAkatsukiLeader(), global.GetAkatsukiLeader(RETURN_FORMAT_CHARACTER), VILLAGE_AKATSUKI, "[m.character] ([m.ckey]) was exiled from the [VILLAGE_AKATSUKI]."
									)
									query.Execute(log_db)
									LogErrorDb(query)

								m.SetVillage(VILLAGE_MISSING_NIN)
								world.UpdateVillageCount()
								akatsuki_members -= m.character

								spawn() src.client.UpdateWhoAll()

							else
								usr.client.prompt("[m.character] is no longer in the [usr.village] village and is therefore unable to be exiled.", "Manage Members")
						else
							usr.client.prompt("The ninja [mem] has been successfully exiled from the [VILLAGE_AKATSUKI].", "Manage Members")
							akatsuki_members -= mem

			Retire()
				set category = "Akatsuki"
				switch(usr.client.prompt("Are you sure that you want to retire as [usr.rank]?", "Retire [usr.rank]", list("Retire", "Cancel")))
					if("Retire")
						switch(usr.client.prompt("Would you like to choose a successor?", "Retire [usr.rank]", list("Yes", "No", "Cancel")))
							if("Yes")
								var/list/exclude = list(usr)
								for(var/mob/m in mobs_online)
									if(m.village != VILLAGE_AKATSUKI) exclude += m

								var/mob/m = input("Who would you like to succeed you as [usr.rank]?", "Retire [usr.rank]") as null|anything in mobs_online - exclude
								if(m)
									if(m.village == VILLAGE_AKATSUKI)
										switch(m.client.prompt("The [usr.rank], [usr.character], formally invites you to succeed them as the [usr.rank]. Do you accept this invitation?", "[usr.rank] Invitation", list("Yes", "No")))
											if("Yes")
												spawn() usr.client.prompt("[m.character] has accepted your invitation to succeed you as the [usr.rank].")

												world << output("[usr.character] has retired from office as the [RANK_AKATSUKI_LEADER] for the <font color='[COLOR_VILLAGE_AKATSUKI]'>[VILLAGE_AKATSUKI]</font>.", "Action.Output")
												
												spawn()
													var/database/query/query = new({"
														INSERT INTO `[db_table_akatsuki]` (`timestamp`, `key`, `character`, `village`, `log`)
														VALUES(?, ?, ?, ?, ?)"},
														time2text(world.realtime, "YYYY-MM-DD hh:mm:ss"), global.GetAkatsukiLeader(), global.GetAkatsukiLeader(RETURN_FORMAT_CHARACTER), VILLAGE_AKATSUKI, "[usr.character] ([usr.client.ckey]) has retired from office as the [RANK_AKATSUKI] for the [VILLAGE_AKATSUKI]."
													)
													query.Execute(log_db)
													LogErrorDb(query)

												world << output("[usr.character] has appointed [m.character] as their successor and is now the [RANK_AKATSUKI_LEADER] for the <font color='[COLOR_VILLAGE_AKATSUKI]'>[VILLAGE_AKATSUKI]</font>.", "Action.Output")
												
												spawn()
													var/database/query/query = new({"
														INSERT INTO `[db_table_akatsuki]` (`timestamp`, `key`, `character`, `village`, `log`)
														VALUES(?, ?, ?, ?, ?)"},
														time2text(world.realtime, "YYYY-MM-DD hh:mm:ss"), global.GetAkatsukiLeader(), global.GetAkatsukiLeader(RETURN_FORMAT_CHARACTER), VILLAGE_AKATSUKI, "[usr.character] ([usr.client.ckey]) has appointed [m.character] ([m.client.ckey]) as their successor and is now the [RANK_AKATSUKI_LEADER] for the [VILLAGE_AKATSUKI]."
													)
													query.Execute(log_db)
													LogErrorDb(query)

												m.SetRank(usr.rank)
												m.client.StaffCheck()

												usr.SetRank(RANK_AKATSUKI)
												usr.client.StaffCheck()

												var/squad/squad = usr.GetSquad()
												if(squad) spawn() squad.Refresh()

												var/squad/squad2 = m.GetSquad()
												if(squad2) spawn() squad2.Refresh()

											if("No")
												usr.client.prompt("[m.character] has rejected your invitation to succeed you as the [usr.rank].")
									else
										usr.client.prompt("You can't send a [usr.rank] invitation to [m.character] because they are no longer in the [usr.village].", "Retire [usr.rank]")
								else
									usr.client.prompt("The ninja you were going to promote to [usr.rank] is no longer online and is therefore unable to be promoted.", "Retire [usr.rank]")

							if("No")
								switch(src.client.prompt("Do you wish to disband the [VILLAGE_AKATSUKI]? This will cause you and all [VILLAGE_AKATSUKI] members to become missing nin.", "[usr.rank] Retirement", list("Yes", "No")))
									if("Yes")

										world << output("[usr.character] has retired as the [RANK_AKATSUKI_LEADER]. The <font color='[COLOR_VILLAGE_AKATSUKI]'>[VILLAGE_AKATSUKI]</font> will be disbanded.", "Action.Output")

										for(var/mob/m in akatsuki_online)
											m.SetVillage(VILLAGE_MISSING_NIN)
											m.SetRank("")

										akatsuki_online = list()
										akatsuki_members = list()
										akatsuki_leader = list()
										akatsuki_last_online = null
										usr.client.StaffCheck()

										usr.SetVillage(VILLAGE_MISSING_NIN)
										usr.SetRank("")

									if("No")
										usr.client.prompt("You have decided not to retire as [RANK_AKATSUKI_LEADER].", "Retire [usr.rank]")
mob
	kage
		verb
			Manage_Village()
				set category = "Kage"
				switch(usr.client.prompt("Would you like to invite or boot ninja from the [usr.village] village?", "Manage Village", list("Invite", "Exile", "Cancel")))
					if("Invite")
						var/list/exclude = list(usr)
						for(var/mob/m in mobs_online)
							if(m.village != VILLAGE_MISSING_NIN) exclude += m

						var/mob/m = input("Who would you like to invite to the [usr.village]", "Manage Village") as null|anything in mobs_online - exclude

						if(m)
							if(m.village == VILLAGE_MISSING_NIN)
								switch(m.client.prompt("The [usr.village] [usr.rank], [usr.character], formally invites you to join the [usr.village] village. Do you accept this invitation?", "Village Invitation", list("Yes", "No")))
									if("Yes")
										if(m.village == VILLAGE_MISSING_NIN)

											var/squad/squad = m.GetSquad()
											if(squad)
												spawn() src.client.prompt("You cannot invite someone who is in a Squad.", "Naruto Evolution")
												spawn() m.client.prompt("You cannot join a village while in a Squad.", "Naruto Evolution")
												return 0

											spawn() usr.client.prompt("[m.character] has accepted your invitation to join the [usr.village] village.")

											spawn()
												LogKage(src, "[m.character] ([m.ckey]) has accepted the invitation to join the [src.village] village.")

											m.SetVillage(usr.village)
											m.SetRank(RANK_GENIN)
											world.UpdateVillageCount()

											spawn() src.client.UpdateWhoAll()

										else
											spawn() usr.client.prompt("[m.character] is no longer a [VILLAGE_MISSING_NIN] and is therefore unable to join the [usr.village] village.")
											spawn() m.client.prompt("You are no longer a [VILLAGE_MISSING_NIN] and are therefore unable to join the [usr.village] village.")

									if("No")
										spawn() usr.client.prompt("[m.character] has rejected your invitation to join the [usr.village] village.")

										spawn()
											var/database/query/query = new({"
												INSERT INTO `[db_table_kage]` (`timestamp`, `key`, `character`, `village`, `log`)
												VALUES(?, ?, ?, ?, ?)"},
												time2text(world.realtime, "YYYY-MM-DD hh:mm:ss"), src.client.ckey, src.character, src.village, "[m.character] ([m.ckey]) has rejected the invitation to join the [src.village] village."
											)
											query.Execute(log_db)
											LogErrorDb(query)

							else
								usr.client.prompt("You can't send a village invitation to [m.character] because they are not a [VILLAGE_MISSING_NIN].", "Manage Village")

						else
							usr.client.prompt("The ninja you were going to invite is no longer online and is therefore unable to be invited.", "Manage Village")

					if("Exile")
						var/list/exclude = list(usr)
						for(var/mob/m in mobs_online)
							if(m.village != usr.village) exclude += m

						var/mob/m = input("Who would you like to boot from the [usr.village]", "Manage Village") as null|anything in mobs_online - exclude

						if(m)
							if(m.village == usr.village)

								var/squad/squad = m.GetSquad()
								if(squad)
									spawn() src.client.prompt("You can't exile [m.character] from the [usr.village] village because they are currently in a Squad.")
									return 0

								spawn() usr.client.prompt("You have formally exiled [m.character] from the [usr.village] village.", "Village Exile")
								spawn() m.client.prompt("The [usr.village] [usr.rank], [usr.character], formally exiles you from the [usr.village] village.", "Village Exile")

								m.SetVillage(VILLAGE_MISSING_NIN)

								world.UpdateVillageCount()
								spawn() src.client.UpdateWhoAll()

							else
								usr.client.prompt("[m.character] is no longer in the [usr.village] village and is therefore unable to be exiled.", "Manage Village")
						else
							usr.client.prompt("The ninja you were going to exile is no longer online and is therefore unable to be exiled.", "Manage Village")

			Manage_Jounin()
				set category = "Kage"
				switch(usr.client.prompt("Would you like to promote someone to [RANK_JOUNIN] or demote them?", "Manage [RANK_JOUNIN]", list("Promote", "Demote", "Cancel")))
					if("Promote")
						var/list/exclude = list(usr)
						for(var/mob/m in mobs_online)
							if(m.village != usr.village || m.rank != RANK_CHUUNIN) exclude += m

						var/mob/m = input("Who would you like to promote to [RANK_JOUNIN]?", "Manage [RANK_JOUNIN]") as null|anything in mobs_online - exclude
						if(m)
							if(m.village == usr.village)
								if(m.rank == RANK_CHUUNIN)
									switch(m.client.prompt("The [usr.village] [usr.rank], [usr.character], formally invites you to join the [RANK_JOUNIN]. Do you accept this invitation?", "[RANK_JOUNIN] Invitation", list("Yes", "No")))
										if("Yes")
											if(m.village == usr.village)
												if(m.rank == RANK_CHUUNIN)
													spawn() usr.client.prompt("[m.character] has accepted your invitation to join the [RANK_JOUNIN].")
													
													spawn()
														var/database/query/query = new({"
															INSERT INTO `[db_table_kage]` (`timestamp`, `key`, `character`, `village`, `log`)
															VALUES(?, ?, ?, ?, ?)"},
															time2text(world.realtime, "YYYY-MM-DD hh:mm:ss"), src.client.ckey, src.character, src.village, "[m.character] ([m.ckey]) has accepted the invitation to join the [RANK_JOUNIN]."
														)
														query.Execute(log_db)
														LogErrorDb(query)
													
													m.SetRank(RANK_JOUNIN)

													var/squad/squad = m.GetSquad()
													if(squad) squad.Refresh()
												else
													spawn() usr.client.prompt("[m.character] is no longer a [RANK_CHUUNIN] and is therefore unable to join the [RANK_JOUNIN].")
													spawn() m.client.prompt("You are no longer in a [RANK_CHUUNIN] and are therefore unable to join the [RANK_JOUNIN].")
											else
												spawn() usr.client.prompt("[m.character] is no longer in the [usr.village] village and is therefore unable to join the [RANK_JOUNIN].")
												spawn() m.client.prompt("You are no longer in the [usr.village] village and are therefore unable to join the [RANK_JOUNIN].")

										if("No")
											spawn() usr.client.prompt("[m.character] has rejected your invitation to join the [RANK_JOUNIN].")

											spawn()
												var/database/query/query = new({"
													INSERT INTO `[db_table_kage]` (`timestamp`, `key`, `character`, `village`, `log`)
													VALUES(?, ?, ?, ?, ?)"},
													time2text(world.realtime, "YYYY-MM-DD hh:mm:ss"), src.client.ckey, src.character, src.village, "[m.character] ([m.ckey]) has rejected the invitation to join the [RANK_JOUNIN]."
												)
												query.Execute(log_db)
												LogErrorDb(query)
								else
									usr.client.prompt("You can't send a [RANK_JOUNIN] invitation to [m.character] because they are no longer a [RANK_CHUUNIN].", "Manage [RANK_JOUNIN]")
							else
								usr.client.prompt("You can't send a [RANK_JOUNIN] invitation to [m.character] because they are no longer in the [usr.village] village.", "Manage [RANK_JOUNIN]")
						else
							usr.client.prompt("The ninja you were going to promote to [RANK_JOUNIN] is no longer online and is therefore unable to be promoted.", "Manage [RANK_JOUNIN]")

					if("Demote")
						var/list/exclude = list(usr)
						for(var/mob/m in mobs_online)
							if(m.village != usr.village || m.rank != RANK_JOUNIN) exclude += m

						var/mob/m = input("Who would you like to demote from [RANK_JOUNIN]?", "Manage [RANK_JOUNIN]") as null|anything in mobs_online - exclude
						if(m)
							if(m.village == usr.village)
								if(m.rank == RANK_JOUNIN)
									spawn() usr.client.prompt("You have formally demoted [m.character] to [RANK_CHUUNIN].", "[RANK_JOUNIN] Demotion")
									spawn() m.client.prompt("The [usr.village] [usr.rank], [usr.character], formally demotes you to [RANK_CHUUNIN].", "[RANK_JOUNIN] Demotion")

									spawn()
										var/database/query/query = new({"
											INSERT INTO `[db_table_kage]` (`timestamp`, `key`, `character`, `village`, `log`)
											VALUES(?, ?, ?, ?, ?)"},
											time2text(world.realtime, "YYYY-MM-DD hh:mm:ss"), src.client.ckey, src.character, src.village, "[m.character] ([m.ckey]) was demoted to rank [RANK_CHUUNIN]."
										)
										query.Execute(log_db)
										LogErrorDb(query)
									
									m.SetRank(RANK_CHUUNIN)

									var/squad/squad = m.GetSquad()
									if(squad) squad.Refresh()
								else
									usr.client.prompt("[m.character] is no longer a [RANK_JOUNIN] and is therefore unable to be demoted.", "Manage [RANK_JOUNIN]")
							else
								usr.client.prompt("[m.character] is no longer in the [usr.village] village and is therefore unable to be demoted.", "Manage [RANK_JOUNIN]")
						else
							usr.client.prompt("The ninja you were going to demote is no longer online and is therefore unable to be demoted.", "Manage [RANK_JOUNIN]")

			Manage_Anbu()
				set category = "Kage"
				switch(usr.client.prompt("Would you like to promote someone to [RANK_ANBU] or demote them?", "Manage [RANK_ANBU]", list("Promote", "Demote", "Cancel")))
					if("Promote")
						var/list/exclude = list(usr)
						for(var/mob/m in mobs_online)
							if(m.village != usr.village || (m.rank != RANK_CHUUNIN && m.rank != RANK_JOUNIN)) exclude += m

						var/mob/m = input("Who would you like to promote to [RANK_ANBU]?", "Manage [RANK_ANBU]") as null|anything in mobs_online - exclude
						if(m)
							if(m.village == usr.village)
								if(m.rank == RANK_CHUUNIN || m.rank == RANK_JOUNIN)
									switch(m.client.prompt("The [usr.village] [usr.rank], [usr.character], formally invites you to join the [RANK_ANBU]. Do you accept this invitation?", "[RANK_ANBU] Invitation", list("Yes", "No")))
										if("Yes")
											if(m.village == usr.village)
												if(m.rank == RANK_CHUUNIN || m.rank == RANK_JOUNIN)
													spawn() usr.client.prompt("[m.character] has accepted your invitation to join the [RANK_ANBU].")

													spawn()
														var/database/query/query = new({"
															INSERT INTO `[db_table_kage]` (`timestamp`, `key`, `character`, `village`, `log`)
															VALUES(?, ?, ?, ?, ?)"},
															time2text(world.realtime, "YYYY-MM-DD hh:mm:ss"), src.client.ckey, src.character, src.village, "[m.character] has accepted the invitation to join the [RANK_ANBU]."
														)
														query.Execute(log_db)
														LogErrorDb(query)
													
													m.SetRank(RANK_ANBU)

													var/squad/squad = m.GetSquad()
													if(squad) squad.Refresh()
												else
													spawn() usr.client.prompt("[m.character] is no longer a [RANK_CHUUNIN] or [RANK_JOUNIN] and is therefore unable to join the [RANK_ANBU].")
													spawn() m.client.prompt("You are no longer in a [RANK_CHUUNIN] or [RANK_JOUNIN] and are therefore unable to join the [RANK_ANBU].")
											else
												spawn() usr.client.prompt("[m.character] is no longer in the [usr.village] village and is therefore unable to join the [RANK_JOUNIN].")
												spawn() m.client.prompt("You are no longer in the [usr.village] village and are therefore unable to join the [RANK_JOUNIN].")

										if("No")
											spawn() usr.client.prompt("[m.character] has rejected your invitation to join the [RANK_ANBU].")

											spawn()
												var/database/query/query = new({"
													INSERT INTO `[db_table_kage]` (`timestamp`, `key`, `character`, `village`, `log`)
													VALUES(?, ?, ?, ?, ?)"},
													time2text(world.realtime, "YYYY-MM-DD hh:mm:ss"), src.client.ckey, src.character, src.village, "[m.character] has rejected the invitation to join the [RANK_ANBU]."
												)
												query.Execute(log_db)
												LogErrorDb(query)
								else
									usr.client.prompt("You can't send a [RANK_ANBU] invitation to [m.character] because they are no longer a [RANK_CHUUNIN] or [RANK_JOUNIN].", "Manage [RANK_ANBU]")
							else
								usr.client.prompt("You can't send a [RANK_ANBU] invitation to [m.character] because they are no longer in the [usr.village] village.", "Manage [RANK_ANBU]")
						else
							usr.client.prompt("The ninja you were going to promote to [RANK_ANBU] is no longer online and is therefore unable to be promoted.", "Manage [RANK_ANBU]")

					if("Demote")
						var/list/exclude = list(usr)
						for(var/mob/m in mobs_online)
							if(m.village != usr.village || m.rank != RANK_ANBU) exclude += m

						var/mob/m = input("Who would you like to demote from [RANK_ANBU]?", "Manage [RANK_ANBU]") as null|anything in mobs_online - exclude
						if(m)
							if(m.village == usr.village)
								if(m.rank == RANK_ANBU)
									spawn() usr.client.prompt("You have formally demoted [m.character] to [RANK_CHUUNIN].", "[RANK_ANBU] Demotion")
									spawn() m.client.prompt("The [usr.village] [usr.rank], [usr.character], formally demotes you to [RANK_CHUUNIN].", "[RANK_ANBU] Demotion")

									spawn()
										var/database/query/query = new({"
											INSERT INTO `[db_table_kage]` (`timestamp`, `key`, `character`, `village`, `log`)
											VALUES(?, ?, ?, ?, ?)"},
											time2text(world.realtime, "YYYY-MM-DD hh:mm:ss"), src.client.ckey, src.character, src.village, "[m.character] ([m.ckey]) was demoted to rank [RANK_CHUUNIN]."
										)
										query.Execute(log_db)
										LogErrorDb(query)

									m.SetRank(RANK_CHUUNIN)

									var/squad/squad = m.GetSquad()
									if(squad) squad.Refresh()
								else
									usr.client.prompt("[m.character] is no longer a [RANK_ANBU] and is therefore unable to be demoted.", "Manage [RANK_ANBU]")
							else
								usr.client.prompt("[m.character] is no longer in the [usr.village] village and is therefore unable to be demoted.", "Manage [RANK_ANBU]")
						else
							usr.client.prompt("The ninja you were going to demote is no longer online and is therefore unable to be demoted.", "Manage [RANK_ANBU]")

			Retire()
				set category = "Kage"
				switch(usr.client.prompt("Are you sure that you want to retire as [usr.rank]?", "Retire [usr.rank]", list("Retire", "Cancel")))
					if("Retire")
						switch(usr.client.prompt("Would you like to choose a successor?", "Retire [usr.rank]", list("Yes", "No", "Cancel")))
							if("Yes")
								var/list/exclude = list(usr)
								for(var/mob/m in mobs_online)
									if(m.village != usr.village || (m.rank != RANK_CHUUNIN && m.rank != RANK_JOUNIN && m.rank != RANK_ANBU)) exclude += m

								var/mob/m = input("Who would you like to succeed you as [usr.rank]?", "Retire [usr.rank]") as null|anything in mobs_online - exclude
								if(m)
									if(m.village == usr.village)
										if(m.rank == RANK_CHUUNIN || m.rank == RANK_JOUNIN || m.rank == RANK_ANBU)
											switch(m.client.prompt("The [usr.village] [usr.rank], [usr.character], formally invites you to succeed them as [usr.rank]. Do you accept this invitation?", "[usr.rank] Invitation", list("Yes", "No")))
												if("Yes")
													spawn() usr.client.prompt("[m.character] has accepted your invitation to succeed you as [usr.rank].")

													spawn()
														var/database/query/query = new({"
															INSERT INTO `[db_table_kage]` (`timestamp`, `key`, `character`, `village`, `log`)
															VALUES(?, ?, ?, ?, ?)"},
															time2text(world.realtime, "YYYY-MM-DD hh:mm:ss"), src.client.ckey, src.character, src.village, "[m.character] ([m.ckey]) has accepted the invitation be the successor [usr.rank]."
														)
														query.Execute(log_db)
														LogErrorDb(query)

													switch(usr.rank)
														if(RANK_HOKAGE)
															world << output("[usr.character] has retired from office as the [RANK_HOKAGE] for the <font color='[COLOR_VILLAGE_LEAF]'>[VILLAGE_LEAF]</font>.", "Action.Output")

															spawn()
																var/database/query/query = new({"
																	INSERT INTO `[db_table_kage]` (`timestamp`, `key`, `character`, `village`, `log`)
																	VALUES(?, ?, ?, ?, ?)"},
																	time2text(world.realtime, "YYYY-MM-DD hh:mm:ss"), m.client.ckey, m.character, m.village, "[usr.character] ([usr.client.ckey]) has retired from office as the [RANK_HOKAGE] for the [VILLAGE_LEAF]."
																)
																query.Execute(log_db)
																LogErrorDb(query)

															world << output("[usr.character] has appointed [m.character] as their successor and is now the [RANK_HOKAGE] for the <font color='[COLOR_VILLAGE_LEAF]'>[VILLAGE_LEAF]</font>.", "Action.Output")
															
															spawn()
																var/database/query/query = new({"
																	INSERT INTO `[db_table_kage]` (`timestamp`, `key`, `character`, `village`, `log`)
																	VALUES(?, ?, ?, ?, ?)"},
																	time2text(world.realtime, "YYYY-MM-DD hh:mm:ss"), m.client.ckey, m.character, m.village, "[usr.character] ([usr.client.ckey]) has appointed [m.character] ([m.client.ckey]) as their successor and is now the [RANK_HOKAGE] for the [VILLAGE_LEAF]."
																)
																query.Execute(log_db)
																LogErrorDb(query)
															
														if(RANK_KAZEKAGE)
															world << output("[usr.character] has retired from office as the [RANK_KAZEKAGE] for the <font color='[COLOR_VILLAGE_SAND]'>[VILLAGE_SAND]</font>.", "Action.Output")
															
															spawn()
																var/database/query/query = new({"
																	INSERT INTO `[db_table_kage]` (`timestamp`, `key`, `character`, `village`, `log`)
																	VALUES(?, ?, ?, ?, ?)"},
																	time2text(world.realtime, "YYYY-MM-DD hh:mm:ss"), m.client.ckey, m.character, m.village, "[usr.character] ([usr.client.ckey]) has retired from office as the [RANK_KAZEKAGE] for the [VILLAGE_SAND]."
																)
																query.Execute(log_db)
																LogErrorDb(query)
															
															world << output("[usr.character] has appointed [m.character] as their successor and is now the [RANK_KAZEKAGE] for the <font color='[COLOR_VILLAGE_SAND]'>[VILLAGE_SAND]</font>.", "Action.Output")
															
															spawn()
																var/database/query/query = new({"
																	INSERT INTO `[db_table_kage]` (`timestamp`, `key`, `character`, `village`, `log`)
																	VALUES(?, ?, ?, ?, ?)"},
																	time2text(world.realtime, "YYYY-MM-DD hh:mm:ss"), m.client.ckey, m.character, m.village, "[usr.character] ([usr.client.ckey]) has appointed [m.character] ([m.client.ckey]) as their successor and is now the [RANK_KAZEKAGE] for the [VILLAGE_SAND]."
																)
																query.Execute(log_db)
																LogErrorDb(query)

													m.SetRank(usr.rank)
													m.client.StaffCheck()

													usr.SetRank(RANK_CHUUNIN)
													usr.client.StaffCheck()

													var/squad/squad = usr.GetSquad()
													if(squad) spawn() squad.Refresh()

													var/squad/squad2 = m.GetSquad()
													if(squad2) spawn() squad2.Refresh()

												if("No")
													spawn() usr.client.prompt("[m.character] has rejected your invitation to succeed you as [usr.rank].")

													spawn()
														var/database/query/query = new({"
															INSERT INTO `[db_table_kage]` (`timestamp`, `key`, `character`, `village`, `log`)
															VALUES(?, ?, ?, ?, ?)"},
															time2text(world.realtime, "YYYY-MM-DD hh:mm:ss"), src.client.ckey, src.character, src.village, "[m.character] ([m.ckey]) has rejected the invitation be the successor [usr.rank]."
														)
														query.Execute(log_db)
														LogErrorDb(query)
										else
											usr.client.prompt("You can't send a [usr.rank] invitation to [m.character] because they are no longer a [RANK_CHUUNIN], [RANK_JOUNIN] or [RANK_ANBU].", "Retire [usr.rank]")
									else
										usr.client.prompt("You can't send a [usr.rank] invitation to [m.character] because they are no longer in the [usr.village] village.", "Retire [usr.rank]")
								else
									usr.client.prompt("The ninja you were going to promote to [usr.rank] is no longer online and is therefore unable to be promoted.", "Retire [usr.rank]")

							if("No")
								switch(usr.rank)
									if(RANK_HOKAGE)
										world << output("[usr.character] has retired from office as the [RANK_HOKAGE] for the <font color='[COLOR_VILLAGE_LEAF]'>[VILLAGE_LEAF]</font>.", "Action.Output")

										spawn()
											var/database/query/query = new({"
												INSERT INTO `[db_table_kage]` (`timestamp`, `key`, `character`, `village`, `log`)
												VALUES(?, ?, ?, ?, ?)"},
												time2text(world.realtime, "YYYY-MM-DD hh:mm:ss"), src.client.ckey, src.character, usr.village, "[usr.character] ([usr.client.ckey]) has retired from office as the [RANK_HOKAGE] for the [VILLAGE_LEAF]."
											)
											query.Execute(log_db)
											LogErrorDb(query)

										hokage = list()

									if(RANK_KAZEKAGE)
										world << output("[usr.character] has retired from office as the [RANK_KAZEKAGE] for the <font color='[COLOR_VILLAGE_SAND]'>[VILLAGE_SAND]</font>.", "Action.Output")
										
										spawn()
											var/database/query/query = new({"
												INSERT INTO `[db_table_kage]` (`timestamp`, `key`, `character`, `village`, `log`)
												VALUES(?, ?, ?, ?, ?)"},
												time2text(world.realtime, "YYYY-MM-DD hh:mm:ss"), src.client.ckey, src.character, usr.village, "[usr.character] ([usr.client.ckey]) has retired from office as the [RANK_KAZEKAGE] for the [VILLAGE_SAND]."
											)
											query.Execute(log_db)
											LogErrorDb(query)

										kazekage = list()

								kages_last_online[usr.village] = null

								usr.SetRank(RANK_CHUUNIN)

mob
	event
		verb
			Toggle_Zetsu_Event()
				set category = "Event"
				if(zetsu_event_toggle)
					zetsu_event_toggle = 0
					usr << output("<b>Zetsu events disabled.</b>","Action.Output")
				else
					zetsu_event_toggle = 1
					usr << output("<b>Zetsu events enabled.</b>","Action.Output")

			Start_Zetsu_Event()
				set category = "Event"
				if(!zetsu_event_active)
					ZetsuEventStart()
				else usr << output("<b>There is already a Zetsu event active. Please wait until the current one has finished before starting another.</b>","Action.Output")
