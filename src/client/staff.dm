client
	proc
		StaffCheck()
			winset(src, "Navigation.LeaderButton", "is-disabled = 'true'")

			// Kage Check //

			if(kages[src.mob.village] == src.ckey)
				winset(src, "Navigation.LeaderButton", "is-disabled = 'false'")
				src.verbs += typesof(/mob/kage/verb)

			else
				src.verbs -= typesof(/mob/kage/verb)

				if(src.mob.rank == RANK_HOKAGE)
					src << output("You were forced out of office as the [RANK_HOKAGE] for the <font color='[COLOR_VILLAGE_LEAF]'>[VILLAGE_LEAF]</font>, and as a result you have been automatically demoted to [RANK_JOUNIN].", "Action.Output")
					text2file("<font color = '[COLOR_CHAT]'>[time2text(world.realtime , "(YYYY-MM-DD hh:mm:ss)")] [src.mob.character] ([src.ckey]) was forced out of office as the [RANK_HOKAGE] for the <font color='[COLOR_VILLAGE_LEAF]'>[VILLAGE_LEAF]</font>, and as a result has been automatically demoted to [RANK_JOUNIN].</font><br />", LOG_KAGE)
					
					src.mob.SetRank(RANK_JOUNIN)
				
				if(src.mob.rank == RANK_KAZEKAGE)
					src << output("You were forced out of office as the [RANK_KAZEKAGE] for the <font color='[COLOR_VILLAGE_SAND]'>[VILLAGE_SAND]</font>, and as a result you have been automatically demoted to [RANK_JOUNIN].", "Action.Output")
					text2file("<font color = '[COLOR_CHAT]'>[time2text(world.realtime , "(YYYY-MM-DD hh:mm:ss)")] [src.mob.character] ([src.ckey]) was forced out of office as the [RANK_KAZEKAGE] for the <font color='[COLOR_VILLAGE_SAND]'>[VILLAGE_SAND]</font>, and as a result has been automatically demoted to [RANK_JOUNIN].</font><br />", LOG_KAGE)

					src.mob.SetRank(RANK_JOUNIN)
			
			if(src.ckey in administrators)
				winset(src, "Navigation.LeaderButton", "is-disabled = 'false'")
				src.mob.verbs += typesof(/mob/administrator/verb)
				src.mob.verbs += typesof(/mob/moderator/verb)
				src.mob.verbs += typesof(/mob/programmer/verb)
				src.mob.verbs += typesof(/mob/pixel_artist/verb)
				src.mob.verbs += typesof(/mob/event/verb/)
				src.mob.verbs += typesof(/mob/debug/verb/)
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
				src.mob.verbs -= typesof(/mob/debug/verb/)
				src.mob.verbs -= typesof(/mob/MasterGM/verb)
				src.mob.verbs -= typesof(/mob/Admin/verb)
				src.mob.verbs -= typesof(/mob/Moderator/verb)
				src.mob.verbs -= typesof(/mob/PixelArtist/verb)
				src.control_freak = CONTROL_FREAK_ALL
			
			if(src.ckey in moderators)
				winset(src, "Navigation.LeaderButton", "is-disabled = 'false'")
				src.mob.verbs += typesof(/mob/moderator/verb)
			else
				src.mob.verbs -= typesof(/mob/moderator/verb)
			
			if(src.ckey in programmers)
				winset(src, "Navigation.LeaderButton", "is-disabled = 'false'")
				src.mob.verbs += typesof(/mob/programmer/verb)
			else
				src.mob.verbs -= typesof(/mob/programmer/verb)

			if(src.ckey in pixel_artists)
				winset(src, "Navigation.LeaderButton", "is-disabled = 'false'")
				src.mob.verbs += typesof(/mob/pixel_artist/verb)
			else
				src.mob.verbs -= typesof(/mob/pixel_artist/verb)
			
			spawn() src.UpdateCharacterPanel()
			spawn() src.UpdateInventoryPanel()
			
mob
	administrator
		verb
    
			// IMPORTAINT: Only use `usr` in verbs for safety. Calling `src.client` results in runtime errors.
			// IMPORTAINT: This doesn't apply to verbs of type path: `/mob/verb`.
      
			// UPDATE: This issue only happens when you add these verbs to src.client instead of src.mob.
			// NOTE: Only add verbs to src.mob from now on.
      
			Manage_Kages()
				set category = "Administrator"
				switch(usr.client.Alert("Which village Kage would you like to manage?", "Manage Kages", list("[VILLAGE_LEAF]", "[VILLAGE_SAND]", "Cancel")))
					if(1)
						switch(usr.client.Alert("Would you like to promote or demote the [RANK_HOKAGE] for the [VILLAGE_LEAF]?", "Manage Kages", list("Promote", "Demote", "Cancel")))
							if(1)
								if(kages[VILLAGE_LEAF])
									usr.client.Alert("There is already a [RANK_HOKAGE] for the [VILLAGE_LEAF].", "Manage Kages")
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
										text2file("<font color = '[COLOR_CHAT]'>[time2text(world.realtime , "(YYYY-MM-DD hh:mm:ss)")] [usr.character] ([usr.client.ckey]) has elected [m.character] ([m.client.ckey]) into office as the [RANK_HOKAGE] for the <font color='[COLOR_VILLAGE_LEAF]'>[VILLAGE_LEAF]</font>.</font><br />", LOG_KAGE)
							
							if(2)
								if(kages[VILLAGE_LEAF])
									switch(usr.client.Alert("Are you sure you want to demote the [VILLAGE_LEAF] [RANK_HOKAGE]?", "Manage Kages", list("Demote", "Cancel")))
										if(1)
											world << output("The [RANK_HOKAGE] for the <font color='[COLOR_VILLAGE_LEAF]'>[VILLAGE_LEAF]</font> was forced out of office by [usr.character].", "Action.Output")
											text2file("<font color = '[COLOR_CHAT]'>[time2text(world.realtime , "(YYYY-MM-DD hh:mm:ss)")] The [RANK_HOKAGE] for the <font color='[COLOR_VILLAGE_LEAF]'>[VILLAGE_LEAF]</font> was forced out of office by [usr.character] ([usr.client.ckey]).</font><br />", LOG_KAGE)
											
											kages[VILLAGE_LEAF] = null
											kages_last_online[VILLAGE_LEAF] = null

											for(var/mob/m in mobs_online)
												m.client.StaffCheck()
								else
									usr.client.Alert("There isn't a [RANK_HOKAGE] currently in office for the [VILLAGE_LEAF].", "Manage Kages")

					if(2)
						switch(usr.client.Alert("Would you like to promote or demote the [RANK_KAZEKAGE] for the [VILLAGE_SAND]?", "Manage Kages", list("Promote", "Demote", "Cancel")))
							if(1)
								if(kages[VILLAGE_SAND])
									usr.client.Alert("There is already a [RANK_KAZEKAGE] for the [VILLAGE_SAND].", "Manage Kages")
								else
									var/list/exclude = list()
									for(var/mob/m in mobs_online)
										if(m.village != VILLAGE_SAND) exclude += m

									var/mob/m = input("Who would you like to promote to [RANK_KAZEKAGE]", "Manage Kages") as null|anything in mobs_online - exclude
									if(m)
										m.SetRank(RANK_KAZEKAGE)

										new/obj/Inventory/Clothing/HeadWrap/KazekageHat(m)
										new/obj/Inventory/Clothing/Robes/KazekageRobe(m)

										var/squad/squad = m.GetSquad()
										if(squad)
											spawn() squad.Refresh()

										m.client.StaffCheck()

										world << output("[usr] has elected [m.character] into office as the [RANK_KAZEKAGE] for the <font color='[COLOR_VILLAGE_SAND]'>[VILLAGE_SAND]</font>.", "Action.Output")
										text2file("<font color = '[COLOR_CHAT]'>[time2text(world.realtime , "(YYYY-MM-DD hh:mm:ss)")] [usr.character] (usr.client.ckey) has elected [m.character] ([m.client.ckey]) into office as the [RANK_KAZEKAGE] for the <font color='[COLOR_VILLAGE_SAND]'>[VILLAGE_SAND]</font>.</font><br />", LOG_KAGE)
							if(2)
								if(kages[VILLAGE_SAND])
									switch(usr.client.Alert("Are you sure you want to demote the [VILLAGE_SAND] [RANK_KAZEKAGE]?", "Manage Kages", list("Demote", "Cancel")))
										if(1)
											world << output("The elected [RANK_KAZEKAGE] for the <font color='[COLOR_VILLAGE_SAND]'>[VILLAGE_SAND]</font> was forced out of office by [usr.character].", "Action.Output")
											text2file("<font color = '[COLOR_CHAT]'>[time2text(world.realtime , "(YYYY-MM-DD hh:mm:ss)")] The elected [RANK_KAZEKAGE] ([kages[VILLAGE_SAND]]) for the <font color='[COLOR_VILLAGE_SAND]'>[VILLAGE_SAND]</font> was forced out of office by [usr.character] ([usr.client.ckey]).</font><br />", LOG_KAGE)

											kages[VILLAGE_SAND] = null
											kages_last_online[VILLAGE_SAND] = null

											for(var/mob/m in mobs_online)
												m.client.StaffCheck()
								else
									usr.client.Alert("There isn't a [RANK_KAZEKAGE] currently in office for the [VILLAGE_SAND].", "Manage Kages")

			Manage_Logs()
				set category = "Administrator"
				switch(alert("What would you like to do?", "Manage Logs", "View Logs", "Download Logs", "Clear Logs"))
					if("View Logs")
						switch(input("Which logs would you like to view?", "Logs") as null|anything in list(LOG_ADMINISTRATOR, LOG_KAGE, LOG_BUGS, LOG_CLIENT_SAVES, LOG_ERROR, LOG_KILLS, LOG_SAVES, LOG_STAFF))
							if(LOG_ADMINISTRATOR)
								usr << output(null, "Browser.Output")
								usr << browse(file(LOG_ADMINISTRATOR))
								winset(usr, "Browser", "is-visible = true")
							
							if(LOG_KAGE)
								usr << output(null, "Browser.Output")
								usr << browse(file(LOG_KAGE))
								winset(usr, "Browser", "is-visible = true")

							if(LOG_BUGS)
								usr << output(null, "Browser.Output")
								usr << browse(file(LOG_BUGS))
								winset(usr, "Browser", "is-visible = true")

							if(LOG_CLIENT_SAVES)
								usr << output(null, "Browser.Output")
								usr << browse(file(LOG_CLIENT_SAVES))
								winset(usr, "Browser", "is-visible = true")

							if(LOG_ERROR)
								usr << output(null, "Browser.Output")
								usr << browse(file(LOG_ERROR))
								winset(usr, "Browser", "is-visible = true")

							if(LOG_KILLS)
								usr << output(null, "Browser.Output")
								usr << browse(file(LOG_KILLS))
								winset(usr, "Browser", "is-visible = true")

							if(LOG_SAVES)
								usr << output(null, "Browser.Output")
								usr << browse(file(LOG_SAVES))
								winset(usr, "Browser", "is-visible = true")

							if(LOG_STAFF)
								usr << output(null, "Browser.Output")
								usr << browse(file(LOG_STAFF))
								winset(usr, "Browser", "is-visible = true")

					if("Download Logs")
						switch(input("Which logs would you like to download?", "Manage Logs") as null|anything in list("All Logs", LOG_ADMINISTRATOR, LOG_KAGE, LOG_BUGS, LOG_CLIENT_SAVES, LOG_ERROR, LOG_KILLS, LOG_SAVES, LOG_STAFF))
							if("All Logs")
								shell("zip -r logs/logs.zip logs/")
								usr << file("logs.zip")
								fdel(file("logs.zip"))

							if(LOG_ADMINISTRATOR)
								usr << ftp(LOG_ADMINISTRATOR)
							
							if(LOG_KAGE)
								usr << ftp(LOG_KAGE)

							if(LOG_BUGS)
								usr << ftp(LOG_BUGS)

							if(LOG_CLIENT_SAVES)
								usr << ftp(LOG_CLIENT_SAVES)

							if(LOG_ERROR)
								usr << ftp(LOG_ERROR)

							if(LOG_KILLS)
								usr << ftp(LOG_KILLS)

							if(LOG_SAVES)
								usr << ftp(LOG_SAVES)

							if(LOG_STAFF)
								usr << ftp(LOG_STAFF)

					if("Clear Logs")
						switch(input("Which logs would you like to clear?", "Manage Logs") as null|anything in list("All Logs", LOG_ADMINISTRATOR, LOG_KAGE, LOG_BUGS, LOG_CLIENT_SAVES, LOG_ERROR, LOG_KILLS, LOG_SAVES, LOG_STAFF))
							if("All Logs")
								switch(alert("Are you sure you want to delete all logs?", "Manage Logs", "Clear All Logs", "Cancel"))
									if("Clear All Logs")
										fdel(LOG_ADMINISTRATOR)
										fdel(LOG_KAGE)
										fdel(LOG_BUGS)
										fdel(LOG_CLIENT_SAVES)
										fdel(LOG_ERROR)
										fdel(LOG_KILLS)
										fdel(LOG_SAVES)
										fdel(LOG_STAFF)
										usr << output("You have cleared all the server logs.", "Action.Output")
										text2file("[time2text(world.realtime , "(YYYY-MM-DD hh:mm:ss)") ] [usr] ([usr.ckey]) has cleared all the server logs.", LOG_ADMINISTRATOR)

							if(LOG_ADMINISTRATOR)
								switch(alert("Are you sure you want to delete the Administrator logs?", "Manage Logs", "Clear Logs", "Cancel"))
									if("Clear Logs")
										fdel(LOG_ADMINISTRATOR)
										usr << output("You have cleared the Administrator logs.", "Action.Output")
										text2file("[time2text(world.realtime , "(YYYY-MM-DD hh:mm:ss)") ] [usr] ([usr.ckey]) has cleared the Administrator logs.", LOG_ADMINISTRATOR)
							
							if(LOG_KAGE)
								switch(alert("Are you sure you want to delete the Kage logs?", "Manage Logs", "Clear Logs", "Cancel"))
									if("Clear Logs")
										fdel(LOG_KAGE)
										usr << output("You have cleared the Kage logs.", "Action.Output")
										text2file("[time2text(world.realtime , "(YYYY-MM-DD hh:mm:ss)") ] [usr] ([usr.ckey]) has cleared the Kage logs.", LOG_KAGE)

							if(LOG_BUGS)
								switch(alert("Are you sure you want to delete the Bug logs?", "Manage Logs", "Clear Logs", "Cancel"))
									if("Clear Logs")
										fdel(LOG_BUGS)
										usr << output("You have cleared the Bug logs.", "Action.Output")
										text2file("[time2text(world.realtime , "(YYYY-MM-DD hh:mm:ss)") ] [usr] ([usr.ckey]) has cleared the Bug logs.", LOG_ADMINISTRATOR)

							if(LOG_CLIENT_SAVES)
								switch(alert("Are you sure you want to delete the Client Save logs?", "Manage Logs", "Clear Logs", "Cancel"))
									if("Clear Logs")
										fdel(LOG_CLIENT_SAVES)
										usr << output("You have cleared the Client Save logs.", "Action.Output")
										text2file("[time2text(world.realtime , "(YYYY-MM-DD hh:mm:ss)") ] [usr] ([usr.ckey]) has cleared the Client Save logs.", LOG_ADMINISTRATOR)

							if(LOG_ERROR)
								switch(alert("Are you sure you want to delete the Error logs?", "Manage Logs", "Clear Logs", "Cancel"))
									if("Clear Logs")
										fdel(LOG_ERROR)
										usr << output("You have cleared the Error logs.", "Action.Output")
										text2file("[time2text(world.realtime , "(YYYY-MM-DD hh:mm:ss)") ] [usr] ([usr.ckey]) has cleared the Error logs.", LOG_ADMINISTRATOR)

							if(LOG_KILLS)
								switch(alert("Are you sure you want to delete the Kill logs?", "Manage Logs", "Clear Logs", "Cancel"))
									if("Clear Logs")
										fdel(LOG_KILLS)
										usr << output("You have cleared the Kill logs.", "Action.Output")
										text2file("[time2text(world.realtime , "(YYYY-MM-DD hh:mm:ss)") ] [usr] ([usr.ckey]) has cleared the Kill logs.", LOG_ADMINISTRATOR)

							if(LOG_SAVES)
								switch(alert("Are you sure you want to delete the Character Save Logs?", "Manage Logs", "Clear Logs", "Cancel"))
									if("Clear Logs")
										fdel(LOG_SAVES)
										usr << output("You have cleared the Character Save logs.", "Action.Output")
										text2file("[time2text(world.realtime , "(YYYY-MM-DD hh:mm:ss)") ] [usr] ([usr.ckey]) has cleared the Character Save logs.", LOG_ADMINISTRATOR)

							if(LOG_STAFF)
								switch(alert("Are you sure you want to delete the Staff Logs?", "Manage Logs", "Clear Logs", "Cancel"))
									if("Clear Logs")
										fdel(LOG_STAFF)
										usr << output("You have cleared the Staff logs.", "Action.Output")
										text2file("[time2text(world.realtime , "(YYYY-MM-DD hh:mm:ss)") ] [usr] ([usr.ckey]) has cleared the Staff logs.", LOG_ADMINISTRATOR)

			Reset_Mission_Cooldown()
				set category = "Administrator"
				usr.client.last_mission = null
				var/savefile/F = new("[SAVEFILE_CLIENT]/[copytext(usr.client.ckey, 1, 2)]/[usr.client.ckey].sav")
				F["last_mission"] << null
				usr << output("You have reset your mission cooldown.", "Action.Output")
				text2file("[time2text(world.realtime , "(YYYY-MM-DD hh:mm:ss)") ] [usr] ([usr.ckey]) has reset their mission cooldown.", LOG_ADMINISTRATOR)

			Change_Name()
				set category = "Administrator"
				var/mob/M = input("Who would you like to rename?", "Change Name") as null|anything in mobs_online
				if(M)
					var/name = input("What would you like to rename [M] to?", "Change Name", M.name) as null|text
					if(name)
						if(M.client && names_taken.Find(lowertext(name)))
							alert("The name [name] is already in use.", "Change Name")
							return 0
						else
							switch(alert("Please choose a font color for [M].", "Change Name", "Village", "Custom"))
								if("Village")
									M.name_color = null

								if("Custom")
									var/color = input("What custom character name color would you like for [M]?") as null|color
									if(color) M.name_color = color

							if(M)
								var/old_character = M.character
								var/old_name = M.name
								var/old_src_name = usr.name
								M.SetName(name)
								M.Save()
								M.client.Save()
								fdel("[SAVEFILE_CHARACTERS]/[copytext(M.ckey, 1, 2)]/[M.ckey] ([lowertext(old_character)]).sav")
								usr << output("You have changed [old_name]'s character name to <u>[name]</u>.", "Action.Output")
								M << output("[old_src_name] has changed your character name to <u>[name]</u>.", "Action.Output")
								spawn() M.client.Alert({"
									[old_src_name] has changed your character name to <u>[name]</u>.
									<br /><br />
									<font color='#BE1A0E'><b><u>Warning:</u></b></font>
									<br />
									You will need to use your updated character name to login."})
								text2file("[time2text(world.realtime , "(YYYY-MM-DD hh:mm:ss)") ] [usr] ([usr.ckey]) has changed [M]'s ([M.ckey]) character name to [name] ([M.ckey]).", LOG_ADMINISTRATOR)

			Change_Ryo()
				set category = "Administrator"
				var/mob/M = input("Who would you like to give or take Ryo from?", "Change Ryo") as null|anything in mobs_online
				if(M)
					switch(alert("Would you like to give or take Ryo from [M]?", "Change Ryo", "Give", "Take", "Cancel"))
						if("Give")
							var/ryo = input("How much Ryo would you like to give to [M]?", "Change Ryo") as null|num
							if(ryo < 0) ryo = 0

							if(M)
								M.SetRyo(M.ryo + ryo)
								usr.client << output("You have given <b>[ryo]</b> Ryo to [M].","Action.Output")
								M.client << output("[usr] has given you <b>[ryo]</b> Ryo.","Action.Output")
								text2file("[time2text(world.realtime , "(YYYY-MM-DD hh:mm:ss)") ] [usr] has changed [M]'s ryo from [ryo] to [M.ryo + ryo].", LOG_ADMINISTRATOR)

						if("Take")
							var/ryo = input("How much Ryo would you like to take from [M]?", "Change Ryo") as null|num
							if(ryo < 0) ryo = 0

							if(M)
								M.SetRyo(M.ryo - ryo)
								usr.client << output("You have taken <b>[ryo]</b> Ryo from [M].","Action.Output")
								M.client << output("[usr] has taken <b>[ryo]</b> Ryo from you.","Action.Output")
								text2file("[time2text(world.realtime , "(YYYY-MM-DD hh:mm:ss)") ] [usr] has changed [M]'s ryo from [ryo] to [M.ryo + ryo].", LOG_ADMINISTRATOR)

			Change_Village()
				set category = "Administrator"
				var/mob/M = input("Who's village would you like to change?", "Change Rank") as null|anything in mobs_online
				if(M)
					switch(input("What would you like to change [M]'s village to?") as null|anything in list(VILLAGE_LEAF, VILLAGE_SAND, VILLAGE_MISSING_NIN))
						if(VILLAGE_LEAF)
							if(M)
								usr.client << output("You have changed [M]'s village from [usr.village] to [VILLAGE_LEAF].","Action.Output")
								M.client << output("[usr] has changed your village from [usr.village] to [VILLAGE_LEAF].","Action.Output")
								text2file("[time2text(world.realtime , "(YYYY-MM-DD hh:mm:ss)") ] [usr] has changed [M]'s village from [usr.village] to [VILLAGE_LEAF].", LOG_ADMINISTRATOR)
								M.SetVillage(VILLAGE_LEAF)

						if(VILLAGE_SAND)
							if(M)
								usr.client << output("You have changed [M]'s village from [usr.village] to [VILLAGE_SAND].","Action.Output")
								M.client << output("[usr] has changed your village from [usr.village] to [VILLAGE_SAND].","Action.Output")
								text2file("[time2text(world.realtime , "(YYYY-MM-DD hh:mm:ss)") ] [usr] has changed [M]'s village from [usr.village] to [VILLAGE_SAND].", LOG_ADMINISTRATOR)
								M.SetVillage(VILLAGE_SAND)

						if(VILLAGE_MISSING_NIN)
							if(M)
								usr.client << output("You have changed [M]'s village from [usr.village] to [VILLAGE_MISSING_NIN].","Action.Output")
								M.client << output("[usr] has changed your village from [usr.village] to [VILLAGE_MISSING_NIN].","Action.Output")
								text2file("[time2text(world.realtime , "(YYYY-MM-DD hh:mm:ss)") ] [usr] has changed [M]'s village from [usr.village] to [VILLAGE_MISSING_NIN].", LOG_ADMINISTRATOR)
								M.SetVillage(VILLAGE_MISSING_NIN)

			Change_Rank()
				set category = "Administrator"
				var/mob/M = input("Who's rank would you like to change?", "Change Rank") as null|anything in mobs_online
				if(M)
					switch(input("What would you like to change [M]'s rank to?") as null|anything in list(RANK_ACADEMY_STUDENT, RANK_GENIN, RANK_CHUUNIN, RANK_JOUNIN, RANK_ANBU))
						if(RANK_ACADEMY_STUDENT)
							if(M)
								M.SetRank(RANK_ACADEMY_STUDENT)
								usr.client << output("You have changed [M]'s rank from [usr.rank] to [RANK_ACADEMY_STUDENT].","Action.Output")
								M.client << output("[usr] has changed your rank from [usr.rank] to [RANK_ACADEMY_STUDENT].","Action.Output")
								text2file("[time2text(world.realtime , "(YYYY-MM-DD hh:mm:ss)") ] [usr] has changed [M]'s rank from [usr.rank] to [RANK_ACADEMY_STUDENT].", LOG_ADMINISTRATOR)

						if(RANK_GENIN)
							if(M)
								M.SetRank(RANK_GENIN)
								usr.client << output("You have changed [M]'s rank from [usr.rank] to [RANK_GENIN].","Action.Output")
								M.client << output("[usr] has changed your rank from [usr.rank] to [RANK_GENIN].","Action.Output")
								text2file("[time2text(world.realtime , "(YYYY-MM-DD hh:mm:ss)") ] [usr] has changed [M]'s rank from [usr.rank] to [RANK_GENIN].", LOG_ADMINISTRATOR)

						if(RANK_CHUUNIN)
							if(M)
								M.SetRank(RANK_CHUUNIN)
								usr.client << output("You have changed [M]'s rank from [usr.rank] to [RANK_CHUUNIN].","Action.Output")
								M.client << output("[usr] has changed your rank from [usr.rank] to [RANK_CHUUNIN].","Action.Output")
								text2file("[time2text(world.realtime , "(YYYY-MM-DD hh:mm:ss)") ] [usr] has changed [M]'s rank from [usr.rank] to [RANK_CHUUNIN].", LOG_ADMINISTRATOR)

						if(RANK_JOUNIN)
							if(M)
								M.SetRank(RANK_JOUNIN)
								usr.client << output("You have changed [M]'s rank from [usr.rank] to [RANK_JOUNIN].","Action.Output")
								M.client << output("[usr] has changed your rank from [usr.rank] to [RANK_JOUNIN].","Action.Output")
								text2file("[time2text(world.realtime , "(YYYY-MM-DD hh:mm:ss)") ] [usr] has changed [M]'s rank from [usr.rank] to [RANK_JOUNIN].", LOG_ADMINISTRATOR)

						if(RANK_ANBU)
							if(M)
								M.SetRank(RANK_ANBU)
								usr.client << output("You have changed [M]'s rank from [usr.rank] to [RANK_ANBU].","Action.Output")
								M.client << output("[usr] has changed your rank from [usr.rank] to [RANK_ANBU].","Action.Output")
								text2file("[time2text(world.realtime , "(YYYY-MM-DD hh:mm:ss)") ] [usr] has changed [M]'s rank from [usr.rank] to [RANK_ANBU].", LOG_ADMINISTRATOR)

			Give_Everything()
				set category="Administrator"
				var/client/C = input("Who would you like to give everything?", "Give Everything") as null | anything in clients_online
				if(C == "Cancel") return
				if(usr.ckey in administrators)
					if(C.ckey in administrators)
						switch(usr.client.Alert("Are you sure you want to give everything to [C.mob.name]?", "Give Everything", list("Yes", "No")))
							if(1)
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
									C.mob.strength = 150
									C.mob.ninjutsu = 150
									C.mob.genjutsu = 150
									C.mob.defence = 150
									C.mob.agility = 150
									C.mob.level = 100

								C.UpdateJutsuPanel()

								usr.client << output("You have used <u>Give Everything</u> on [C.mob.name].", "Action.Output")
								C << output("[usr.name] has used <u>Give Everything</u> on you.", "Action.Output")
								text2file("[usr]([usr.key]) has used give everything on [C.mob.name]([C.key]).: [time2text(world.timeofday, "MMM DD hh:mm:ss")]<br>", LOG_STAFF)
					else
						text2file("[usr]([usr.key]) has attempted to use give everything on [C.mob.name]([C.key]).: [time2text(world.timeofday, "MMM DD hh:mm:ss")]<br>", LOG_STAFF)
						usr.client.Alert("You can only use this command on Administrators.")
				else
					usr.client.Alert("This command is restricted to Administrators.")

mob
	moderator
		verb
			Test()
				set category = "Moderator"

mob
	programmer
		verb
			Test()
				set category = "Programmer"

mob
	pixel_artist
		verb
			Test()
				set category = "Pixel Artist"

mob
	kage
		verb
			Manage_Village()
				set category = "Kage"
				switch(usr.client.Alert("Would you like to invite or boot ninja from the [usr.village] village?", "Manage Village", list("Invite", "Exile", "Cancel")))
					if(1)
						var/list/exclude = list(usr)
						for(var/mob/m in mobs_online)
							if(m.village != VILLAGE_MISSING_NIN) exclude += m

						var/mob/m = input("Who would you like to invite to the [usr.village]", "Manage Village") as null|anything in mobs_online - exclude

						if(m)
							if(m.village == VILLAGE_MISSING_NIN)
								switch(m.client.Alert("The [usr.village] [usr.rank], [usr.name], formally invites you to join the [usr.village] village. Do you accept this invitation?", "Village Invitation", list("Yes", "No")))
									if(1)
										if(m.village == VILLAGE_MISSING_NIN)
											usr.client.Alert("[m.name] has accepted your invitation to join the [usr.village] village.")
											m.SetVillage(usr.village)

											var/squad/squad = m.GetSquad()
											if(squad) squad.Refresh()
										else
											spawn() usr.client.Alert("[m.name] is no longer a [VILLAGE_MISSING_NIN] and is therefore unable to join the [usr.village] village.")
											spawn() m.client.Alert("You are no longer a [VILLAGE_MISSING_NIN] and are therefore unable to join the [usr.village] village.")

									if(2)
										usr.client.Alert("[m.name] has rejected your invitation to join the [usr.village] village.")

							else
								usr.client.Alert("You can't send a village invitation to [m.name] because they are not a [VILLAGE_MISSING_NIN].", "Manage Village")
						
						else
							usr.client.Alert("The ninja you were going to invite is no longer online and is therefore unable to be invited.", "Manage Village")

					if(2)
						var/list/exclude = list(usr)
						for(var/mob/m in mobs_online)
							if(m.village != usr.village) exclude += m

						var/mob/m = input("Who would you like to boot from the [usr.village]", "Manage Village") as null|anything in mobs_online - exclude

						if(m)
							if(m.village == usr.village)
								spawn() usr.client.Alert("You have formally exiled [m.name] from the [usr.village] village.", "Village Exile")
								spawn() m.client.Alert("The [usr.village] [usr.rank], [usr.name], formally exiles you from the [usr.village] village.", "Village Exile")
								m.SetVillage(VILLAGE_MISSING_NIN)

								var/squad/squad = m.GetSquad()
								if(squad) squad.Refresh()
							else
								usr.client.Alert("[m.name] is no longer in the [usr.village] village and is therefore unable to be exiled.", "Manage Village")
						else
							usr.client.Alert("The ninja you were going to exile is no longer online and is therefore unable to be exiled.", "Manage Village")
									
			Manage_Jounin()
				set category = "Kage"
				switch(usr.client.Alert("Would you like to promote someone to [RANK_JOUNIN] or demote them?", "Manage [RANK_JOUNIN]", list("Promote", "Demote", "Cancel")))
					if(1)
						var/list/exclude = list(usr)
						for(var/mob/m in mobs_online)
							if(m.village != usr.village || m.rank != RANK_CHUUNIN) exclude += m

						var/mob/m = input("Who would you like to promote to [RANK_JOUNIN]?", "Manage [RANK_JOUNIN]") as null|anything in mobs_online - exclude
						if(m)
							if(m.village == usr.village)
								if(m.rank == RANK_CHUUNIN)
									switch(m.client.Alert("The [usr.village] [usr.rank], [usr.name], formally invites you to join the [RANK_JOUNIN]. Do you accept this invitation?", "[RANK_JOUNIN] Invitation", list("Yes", "No")))
										if(1)
											if(m.village == usr.village)
												if(m.rank == RANK_CHUUNIN)
													spawn() usr.client.Alert("[m.name] has accepted your invitation to join the [RANK_JOUNIN].")
													m.SetRank(RANK_JOUNIN)

													var/squad/squad = m.GetSquad()
													if(squad) squad.Refresh()
												else
													spawn() usr.client.Alert("[m.name] is no longer a [RANK_CHUUNIN] and is therefore unable to join the [RANK_JOUNIN].")
													spawn() m.client.Alert("You are no longer in a [RANK_CHUUNIN] and are therefore unable to join the [RANK_JOUNIN].")
											else
												spawn() usr.client.Alert("[m.name] is no longer in the [usr.village] village and is therefore unable to join the [RANK_JOUNIN].")
												spawn() m.client.Alert("You are no longer in the [usr.village] village and are therefore unable to join the [RANK_JOUNIN].")

										if(2)
											usr.client.Alert("[m.name] has rejected your invitation to join the [RANK_JOUNIN].")
								else
									usr.client.Alert("You can't send a [RANK_JOUNIN] invitation to [m.name] because they are no longer a [RANK_CHUUNIN].", "Manage [RANK_JOUNIN]")
							else
								usr.client.Alert("You can't send a [RANK_JOUNIN] invitation to [m.name] because they are no longer in the [usr.village] village.", "Manage [RANK_JOUNIN]")
						else
							usr.client.Alert("The ninja you were going to promote to [RANK_JOUNIN] is no longer online and is therefore unable to be promoted.", "Manage [RANK_JOUNIN]")
					
					if(2)
						var/list/exclude = list(usr)
						for(var/mob/m in mobs_online)
							if(m.village != usr.village || m.rank != RANK_JOUNIN) exclude += m

						var/mob/m = input("Who would you like to demote from [RANK_JOUNIN]?", "Manage [RANK_JOUNIN]") as null|anything in mobs_online - exclude
						if(m)
							if(m.village == usr.village)
								if(m.rank == RANK_JOUNIN)
									spawn() usr.client.Alert("You have formally demoted [m.name] to [RANK_CHUUNIN].", "[RANK_JOUNIN] Demotion")
									spawn() m.client.Alert("The [usr.village] [usr.rank], [usr.name], formally demotes you to [RANK_CHUUNIN].", "[RANK_JOUNIN] Demotion")
									m.SetRank(RANK_CHUUNIN)

									var/squad/squad = m.GetSquad()
									if(squad) squad.Refresh()
								else
									usr.client.Alert("[m.name] is no longer a [RANK_JOUNIN] and is therefore unable to be demoted.", "Manage [RANK_JOUNIN]")
							else
								usr.client.Alert("[m.name] is no longer in the [usr.village] village and is therefore unable to be demoted.", "Manage [RANK_JOUNIN]")
						else
							usr.client.Alert("The ninja you were going to demote is no longer online and is therefore unable to be demoted.", "Manage [RANK_JOUNIN]")

			Manage_Anbu()
				set category = "Kage"
				switch(usr.client.Alert("Would you like to promote someone to [RANK_ANBU] or demote them?", "Manage [RANK_ANBU]", list("Promote", "Demote", "Cancel")))
					if(1)
						var/list/exclude = list(usr)
						for(var/mob/m in mobs_online)
							if(m.village != usr.village || (m.rank != RANK_CHUUNIN && m.rank != RANK_JOUNIN)) exclude += m

						var/mob/m = input("Who would you like to promote to [RANK_ANBU]?", "Manage [RANK_ANBU]") as null|anything in mobs_online - exclude
						if(m)
							if(m.village == usr.village)
								if(m.rank == RANK_CHUUNIN || m.rank == RANK_JOUNIN)
									switch(m.client.Alert("The [usr.village] [usr.rank], [usr.name], formally invites you to join the [RANK_ANBU]. Do you accept this invitation?", "[RANK_ANBU] Invitation", list("Yes", "No")))
										if(1)
											if(m.village == usr.village)
												if(m.rank == RANK_CHUUNIN || m.rank == RANK_JOUNIN)
													spawn() usr.client.Alert("[m.name] has accepted your invitation to join the [RANK_ANBU].")
													m.SetRank(RANK_ANBU)

													var/squad/squad = m.GetSquad()
													if(squad) squad.Refresh()
												else
													spawn() usr.client.Alert("[m.name] is no longer a [RANK_CHUUNIN] or [RANK_JOUNIN] and is therefore unable to join the [RANK_ANBU].")
													spawn() m.client.Alert("You are no longer in a [RANK_CHUUNIN] or [RANK_JOUNIN] and are therefore unable to join the [RANK_ANBU].")
											else
												spawn() usr.client.Alert("[m.name] is no longer in the [usr.village] village and is therefore unable to join the [RANK_JOUNIN].")
												spawn() m.client.Alert("You are no longer in the [usr.village] village and are therefore unable to join the [RANK_JOUNIN].")

										if(2)
											usr.client.Alert("[m.name] has rejected your invitation to join the [RANK_ANBU].")
								else
									usr.client.Alert("You can't send a [RANK_ANBU] invitation to [m.name] because they are no longer a [RANK_CHUUNIN] or [RANK_JOUNIN].", "Manage [RANK_ANBU]")
							else
								usr.client.Alert("You can't send a [RANK_ANBU] invitation to [m.name] because they are no longer in the [usr.village] village.", "Manage [RANK_ANBU]")
						else
							usr.client.Alert("The ninja you were going to promote to [RANK_ANBU] is no longer online and is therefore unable to be promoted.", "Manage [RANK_ANBU]")
					
					if(2)
						var/list/exclude = list(usr)
						for(var/mob/m in mobs_online)
							if(m.village != usr.village || m.rank != RANK_ANBU) exclude += m

						var/mob/m = input("Who would you like to demote from [RANK_ANBU]?", "Manage [RANK_ANBU]") as null|anything in mobs_online - exclude
						if(m)
							if(m.village == usr.village)
								if(m.rank == RANK_ANBU)
									spawn() usr.client.Alert("You have formally demoted [m.name] to [RANK_CHUUNIN].", "[RANK_ANBU] Demotion")
									spawn() m.client.Alert("The [usr.village] [usr.rank], [usr.name], formally demotes you to [RANK_CHUUNIN].", "[RANK_ANBU] Demotion")
									
									m.SetRank(RANK_CHUUNIN)

									var/squad/squad = m.GetSquad()
									if(squad) squad.Refresh()
								else
									usr.client.Alert("[m.name] is no longer a [RANK_ANBU] and is therefore unable to be demoted.", "Manage [RANK_ANBU]")
							else
								usr.client.Alert("[m.name] is no longer in the [usr.village] village and is therefore unable to be demoted.", "Manage [RANK_ANBU]")
						else
							usr.client.Alert("The ninja you were going to demote is no longer online and is therefore unable to be demoted.", "Manage [RANK_ANBU]")

			Retire()
				set category = "Kage"
				switch(usr.client.Alert("Are you sure that you want to retire as [usr.rank]?", "Retire [usr.rank]", list("Retire", "Cancel")))
					if(1)
						switch(usr.client.Alert("Would you like to choose a successor?", "Retire [usr.rank]", list("Yes", "No", "Cancel")))
							if(1)
								var/list/exclude = list(usr)
								for(var/mob/m in mobs_online)
									if(m.village != usr.village || (m.rank != RANK_CHUUNIN && m.rank != RANK_JOUNIN && m.rank != RANK_ANBU)) exclude += m

								var/mob/m = input("Who would you like to succeed you as [usr.rank]?", "Retire [usr.rank]") as null|anything in mobs_online - exclude
								if(m)
									if(m.village == usr.village)
										if(m.rank == RANK_CHUUNIN || m.rank == RANK_JOUNIN || m.rank != RANK_ANBU)
											switch(m.client.Alert("The [usr.village] [usr.rank], [usr.name], formally invites you to succeed them as [usr.rank]. Do you accept this invitation?", "[usr.rank] Invitation", list("Yes", "No")))
												if(1)
													spawn() usr.client.Alert("[m.name] has accepted your invitation to join the [usr.rank].")

													switch(usr.rank)
														if(RANK_HOKAGE)
															world << output("[usr.character] has retired from office as the [RANK_HOKAGE] for the <font color='[COLOR_VILLAGE_LEAF]'>[VILLAGE_LEAF]</font>.", "Action.Output")
															text2file("<font color = '[COLOR_CHAT]'>[time2text(world.realtime , "(YYYY-MM-DD hh:mm:ss)")] [usr.character] ([usr.client.ckey]) has retired from office as the [RANK_HOKAGE] for the <font color='[COLOR_VILLAGE_LEAF]'>[VILLAGE_LEAF]</font>.</font><br />", LOG_KAGE)

															world << output("[usr.character] has appointed [m.character] as their successor and is now the [RANK_HOKAGE] for the <font color='[COLOR_VILLAGE_LEAF]'>[VILLAGE_LEAF]</font>.", "Action.Output")
															text2file("<font color = '[COLOR_CHAT]'>[time2text(world.realtime , "(YYYY-MM-DD hh:mm:ss)")] [usr.character] ([usr.client.ckey]) has appointed [m.character] ([m.client.ckey]) as their successor and is now the [RANK_HOKAGE] for the <font color='[COLOR_VILLAGE_LEAF]'>[VILLAGE_LEAF]</font>.</font><br />", LOG_KAGE)
														
														if(RANK_KAZEKAGE)
															world << output("[usr.character] has retired from office as the [RANK_KAZEKAGE] for the <font color='[COLOR_VILLAGE_LEAF]'>[VILLAGE_LEAF]</font>.", "Action.Output")
															text2file("<font color = '[COLOR_CHAT]'>[time2text(world.realtime , "(YYYY-MM-DD hh:mm:ss)")] [usr.character] ([usr.client.ckey]) has retired from office as the [RANK_HOKAGE] for the <font color='[COLOR_VILLAGE_LEAF]'>[VILLAGE_LEAF]</font>.</font><br />", LOG_KAGE)
															
															world << output("[usr.character] has appointed [m.character] as their successor and is now the [RANK_KAZEKAGE] for the <font color='[COLOR_VILLAGE_LEAF]'>[VILLAGE_LEAF]</font>.", "Action.Output")
															text2file("<font color = '[COLOR_CHAT]'>[time2text(world.realtime , "(YYYY-MM-DD hh:mm:ss)")] [usr.character] ([usr.client.ckey]) has appointed [m.character] ([m.client.ckey]) as their successor and is now the [RANK_HOKAGE] for the <font color='[COLOR_VILLAGE_LEAF]'>[VILLAGE_LEAF]</font>.</font><br />", LOG_KAGE)
													
													m.SetRank(usr.rank)
													m.client.StaffCheck()

													usr.SetRank(RANK_CHUUNIN)
													usr.client.StaffCheck()

													var/squad/squad = usr.GetSquad()
													if(squad) spawn() squad.Refresh()

													var/squad/squad2 = m.GetSquad()
													if(squad2) spawn() squad2.Refresh()
										else
											usr.client.Alert("You can't send a [usr.rank] invitation to [m.name] because they are no longer a [RANK_CHUUNIN], [RANK_JOUNIN] or [RANK_ANBU].", "Retire [usr.rank]")
									else
										usr.client.Alert("You can't send a [usr.rank] invitation to [m.name] because they are no longer in the [usr.village] village.", "Retire [usr.rank]")
								else
									usr.client.Alert("The ninja you were going to promote to [usr.rank] is no longer online and is therefore unable to be promoted.", "Retire [usr.rank]")
										
							if(2)
								switch(usr.rank)
									if(RANK_HOKAGE)
										world << output("[usr.character] has retired from office as the [RANK_HOKAGE] for the <font color='[COLOR_VILLAGE_LEAF]'>[VILLAGE_LEAF]</font>.", "Action.Output")
										text2file("<font color = '[COLOR_CHAT]'>[time2text(world.realtime , "(YYYY-MM-DD hh:mm:ss)")] [usr.character] ([usr.client.ckey]) has retired from office as the [RANK_HOKAGE] for the <font color='[COLOR_VILLAGE_LEAF]'>[VILLAGE_LEAF]</font>.</font><br />", LOG_KAGE)
									if(RANK_KAZEKAGE)
										world << output("[usr.character] has retired from office as the [RANK_KAZEKAGE] for the <font color='[COLOR_VILLAGE_SAND]'>[VILLAGE_SAND]</font>.", "Action.Output")
										text2file("<font color = '[COLOR_CHAT]'>[time2text(world.realtime , "(YYYY-MM-DD hh:mm:ss)")] [usr.character] ([usr.client.ckey]) has retired from office as the [RANK_KAZEKAGE] for the <font color='[COLOR_VILLAGE_SAND]'>[VILLAGE_SAND]</font>.</font><br />", LOG_KAGE)
								
								kages[usr.village] = null
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

mob
	debug
		verb
			End_Mission()
				set category = "Debug"
				switch(alert("Which would you like to do?", "End Mission", "Fail Mission", "Complete Mission"))
					if("Complete Mission")
						var/mob/M = input("Who's mission would you like to complete?", "Complete Mission") as null|anything in mobs_online
						var/squad/squad = M.GetSquad()
						if(M)
							squad.mission.Complete(M)
					if("Fail Mission")
						var/mob/M = input("Who's mission would you like to fail?", "Fail Mission") as null|anything in mobs_online
						var/squad/squad = M.GetSquad()
						if(M)
							squad.mission = null