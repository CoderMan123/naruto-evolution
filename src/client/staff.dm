client
	var/tmp/stat_display_world = 1
	Stat()
		if(src && administrators.Find(src.ckey))
			if(src && statpanel("Server"))
				stat("Name:", world.name)
				stat("Status:", world.status)
				stat("Server Time:", "[time2text(world.timeofday, "hh:mm:ss", world.timezone)] (UTC-[world.timezone])")
				stat("Local Time:", "[time2text(world.timeofday, "hh:mm:ss", src.timezone)] (UTC[src.timezone])")
				stat("Address:", "[world.address]:[world.port]")
				stat("BYOND Version:", "[world.byond_version].[world.byond_build]")
				stat("FPS:", world.fps)
				stat("CPU:", world.cpu)
				stat("Map CPU:", world.map_cpu)
		
		if(src && administrators.Find(src.ckey) && src.stat_display_world)
			if(src && statpanel("World"))
				var/counter = 0
				for(var/area/a in world)
					counter++
				stat("Area Counter", counter)

				counter = 0
				for(var/turf/t in world)
					counter++
				stat("Turf Counter", counter)

				counter = 0
				for(var/mob/m in world)
					counter++
				stat("Mob Counter", counter)

				counter = 0
				for(var/obj/o in world)
					counter++
				stat("Object Counter", counter)

				counter = 0
				for(var/obj/Projectiles/o in world)
					counter++
				stat("Projectiles Counter", counter)

				counter = 0
				for(var/mob/m in mobs_online)
					for(var/state/s in m.state_manager)
						counter++
				stat("State Counter (World)", counter)

				counter = 0
				for(var/state/s in src.mob.state_manager)
					counter++
				stat("State Counter (Self)", counter)

				counter = 0
				for(var/obj/name/name in src.mob.state_manager)
					counter++
				stat("Name Counter", counter)
				sleep(world.tick_lag)
		
		if(src && administrators.Find(src.ckey) && global.hokage_election || global.kazekage_election)
			if(src && statpanel("Election"))
				stat("Hokage Election:", global.hokage_election ? "Running" : "Ended")
				stat("Hokage Ballot:", global.hokage_ballot_open ? "Open" : "Closed")
				stat("Hokage Ballot Counter:", global.hokage_election_ballot.len)
				stat("Kazekage Election:", global.kazekage_election ? "Running" : "Ended")
				stat("Kazekage Ballot:", global.kazekage_ballot_open ? "Open" : "Closed")
				stat("Kazekage Ballot Counter:", global.kazekage_election_ballot.len)

client
	proc
		StaffCheck()
			winset(src, "Navigation.LeaderButton", "is-disabled = 'true'")

			// Kage Check //

			if(hokage[src.ckey] == src.mob.character || kazekage[src.ckey] == src.mob.character)
				winset(src, "Navigation.LeaderButton", "is-disabled = 'false'")
				src.verbs += typesof(/mob/kage/verb)

				if(hokage[src.ckey] == src.mob.character)
					src.mob.SetRank(RANK_HOKAGE)

				else if(kazekage[src.ckey] == src.mob.character)
					src.mob.SetRank(RANK_KAZEKAGE)

			else
				src.verbs -= typesof(/mob/kage/verb)

				if(src.mob.rank == RANK_HOKAGE)
					src << output("You were forced out of office as the [RANK_HOKAGE] for the <font color='[COLOR_VILLAGE_LEAF]'>[VILLAGE_LEAF]</font>, and as a result you have been automatically demoted to [RANK_JOUNIN].", "Action.Output")
					text2file("<font color = '[COLOR_CHAT]'>[time2text(world.realtime , "(YYYY-MM-DD hh:mm:ss)")] [src.mob.character] ([src.ckey]) was forced out of office as the [RANK_HOKAGE] for the <font color='[COLOR_VILLAGE_LEAF]'>[VILLAGE_LEAF]</font>, and as a result has been automatically demoted to [RANK_JOUNIN].</font><br />", LOG_KAGE)
					
					src.mob.SetRank(RANK_CHUUNIN)
				
				if(src.mob.rank == RANK_KAZEKAGE)
					src << output("You were forced out of office as the [RANK_KAZEKAGE] for the <font color='[COLOR_VILLAGE_SAND]'>[VILLAGE_SAND]</font>, and as a result you have been automatically demoted to [RANK_JOUNIN].", "Action.Output")
					text2file("<font color = '[COLOR_CHAT]'>[time2text(world.realtime , "(YYYY-MM-DD hh:mm:ss)")] [src.mob.character] ([src.ckey]) was forced out of office as the [RANK_KAZEKAGE] for the <font color='[COLOR_VILLAGE_SAND]'>[VILLAGE_SAND]</font>, and as a result has been automatically demoted to [RANK_JOUNIN].</font><br />", LOG_KAGE)

					src.mob.SetRank(RANK_CHUUNIN)
			
			// Akatsuki Check //

			if(akatsuki[src.ckey] == src.mob.character)
				winset(src, "Navigation.LeaderButton", "is-disabled = 'false'")
				src.verbs += typesof(/mob/akatsuki/verb)
				src.mob.SetRank(RANK_AKATSUKI_LEADER)

			else
				src.verbs -= typesof(/mob/akatsuki/verb)

				if(src.mob.rank == RANK_AKATSUKI_LEADER)
					src << output("You were forced out of office as the [RANK_AKATSUKI_LEADER] for the <font color='[COLOR_VILLAGE_AKATSUKI]'>[VILLAGE_AKATSUKI]</font>, and as a result you have been automatically demoted to [RANK_AKATSUKI].", "Action.Output")
					text2file("<font color = '[COLOR_CHAT]'>[time2text(world.realtime , "(YYYY-MM-DD hh:mm:ss)")] [src.mob.character] ([src.ckey]) was forced out of office as the [RANK_AKATSUKI_LEADER] for the <font color='[COLOR_VILLAGE_AKATSUKI]'>[VILLAGE_AKATSUKI]</font>, and as a result has been automatically demoted to [RANK_AKATSUKI].</font><br />", LOG_AKATSUKI)
					
					src.mob.SetRank(RANK_AKATSUKI)
			
			if(administrators.Find(src.ckey))
				winset(src, "Navigation.LeaderButton", "is-disabled = 'false'")
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

			Toggle_World_Information()
				set category = "Administrator"
				src.client.stat_display_world = src.client.stat_display_world ? 0 : 1

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
					m.move_delay = max(0.5, 0.8-((m.agility/150)*0.3))

			Manage_Akatsuki()
				set category = "Administrator"
				switch(usr.client.Alert("Would you like to promote or demote the [RANK_AKATSUKI_LEADER]?", "Manage Akatsuki", list("Promote", "Demote", "Cancel")))
					if(1)
						if(akatsuki.len)
							usr.client.Alert("There is already an [RANK_AKATSUKI_LEADER].", "Manage Akatsuki")
						else
							var/list/exclude = list()
							for(var/mob/m in mobs_online)
								if(m.village != VILLAGE_MISSING_NIN && m.village != VILLAGE_AKATSUKI) exclude += m

							var/mob/m = input("Who would you like to promote to [RANK_AKATSUKI_LEADER]", "Manage Akatsuki") as null|anything in mobs_online - exclude
							if(m)

								var/squad/squad = m.GetSquad()
								if(squad)
									spawn() src.client.Alert("You cannot promote [m.character] to [RANK_AKATSUKI_LEADER] while in a Squad.", "Naruto Evolution")
									spawn() m.client.Alert("You cannot be promoted to [RANK_AKATSUKI_LEADER] while in a Squad.", "Naruto Evolution")
									return 0

								m.SetVillage(VILLAGE_AKATSUKI)
								m.SetRank(RANK_AKATSUKI_LEADER)

								world.UpdateVillageCount()
								spawn() src.client.UpdateWhoAll()
								
								m.client.StaffCheck()

								world << output("[usr.character] has elected [m.character] into office as the [RANK_AKATSUKI_LEADER] for the <font color='[COLOR_VILLAGE_AKATSUKI]'>[VILLAGE_AKATSUKI]</font>.", "Action.Output")
								text2file("<font color = '[COLOR_CHAT]'>[time2text(world.realtime , "(YYYY-MM-DD hh:mm:ss)")] [usr.character] ([usr.client.ckey]) has elected [m.character] ([m.client.ckey]) into office as the [RANK_AKATSUKI_LEADER] for the <font color='[COLOR_VILLAGE_AKATSUKI]'>[VILLAGE_AKATSUKI]</font>.</font><br />", LOG_AKATSUKI)
					
					if(2)
						if(akatsuki.len)
							switch(usr.client.Alert("Are you sure you want to demote the [VILLAGE_AKATSUKI] [RANK_AKATSUKI_LEADER]?", "Manage Akatsuki", list("Demote", "Cancel")))
								if(1)
									world << output("The [RANK_AKATSUKI_LEADER] for the <font color='[COLOR_VILLAGE_AKATSUKI]'>[VILLAGE_AKATSUKI]</font> was forced out of office by [usr.character].", "Action.Output")
									text2file("<font color = '[COLOR_CHAT]'>[time2text(world.realtime , "(YYYY-MM-DD hh:mm:ss)")] The [RANK_AKATSUKI_LEADER] for the <font color='[COLOR_VILLAGE_AKATSUKI]'>[VILLAGE_AKATSUKI]</font> was forced out of office by [usr.character] ([usr.client.ckey]).</font><br />", LOG_AKATSUKI)
									
									akatsuki = list()
									akatsuki_last_online = null

									for(var/mob/m in mobs_online)
										m.client.StaffCheck()
						else
							usr.client.Alert("There isn't a [RANK_AKATSUKI_LEADER] currently in office for the [VILLAGE_AKATSUKI].", "Manage Akatsuki")

			Manage_Kages()
				set category = "Administrator"
				switch(usr.client.Alert("Which village Kage would you like to manage?", "Manage Kages", list("[VILLAGE_LEAF]", "[VILLAGE_SAND]", "Cancel")))
					if(1)
						switch(usr.client.Alert("Would you like to promote or demote the [RANK_HOKAGE] for the [VILLAGE_LEAF]?", "Manage Kages", list("Promote", "Demote", "Cancel")))
							if(1)
								if(hokage.len)
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
								if(hokage.len)
									switch(usr.client.Alert("Are you sure you want to demote the [VILLAGE_LEAF] [RANK_HOKAGE]?", "Manage Kages", list("Demote", "Cancel")))
										if(1)
											world << output("The [RANK_HOKAGE] for the <font color='[COLOR_VILLAGE_LEAF]'>[VILLAGE_LEAF]</font> was forced out of office by [usr.character].", "Action.Output")
											text2file("<font color = '[COLOR_CHAT]'>[time2text(world.realtime , "(YYYY-MM-DD hh:mm:ss)")] The [RANK_HOKAGE] ([global.GetHokage()]) for the <font color='[COLOR_VILLAGE_LEAF]'>[VILLAGE_LEAF]</font> was forced out of office by [usr.character] ([usr.client.ckey]).</font><br />", LOG_KAGE)
											
											hokage = list()
											kages_last_online[VILLAGE_LEAF] = null

											for(var/mob/m in mobs_online)
												m.client.StaffCheck()
								else
									usr.client.Alert("There isn't a [RANK_HOKAGE] currently in office for the [VILLAGE_LEAF].", "Manage Kages")

					if(2)
						switch(usr.client.Alert("Would you like to promote or demote the [RANK_KAZEKAGE] for the [VILLAGE_SAND]?", "Manage Kages", list("Promote", "Demote", "Cancel")))
							if(1)
								if(kazekage.len)
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
								if(kazekage.len)
									switch(usr.client.Alert("Are you sure you want to demote the [VILLAGE_SAND] [RANK_KAZEKAGE]?", "Manage Kages", list("Demote", "Cancel")))
										if(1)
											world << output("The elected [RANK_KAZEKAGE] for the <font color='[COLOR_VILLAGE_SAND]'>[VILLAGE_SAND]</font> was forced out of office by [usr.character].", "Action.Output")
											text2file("<font color = '[COLOR_CHAT]'>[time2text(world.realtime , "(YYYY-MM-DD hh:mm:ss)")] The elected [RANK_KAZEKAGE] ([global.GetKazekage()]) for the <font color='[COLOR_VILLAGE_SAND]'>[VILLAGE_SAND]</font> was forced out of office by [usr.character] ([usr.client.ckey]).</font><br />", LOG_KAGE)

											kazekage = list()
											kages_last_online[VILLAGE_SAND] = null

											for(var/mob/m in mobs_online)
												m.client.StaffCheck()
								else
									usr.client.Alert("There isn't a [RANK_KAZEKAGE] currently in office for the [VILLAGE_SAND].", "Manage Kages")

			Manage_Logs()
				set category = "Administrator"
				switch(alert("What would you like to do?", "Manage Logs", "View Logs", "Download Logs", "Clear Logs"))
					if("View Logs")
						switch(input("Which logs would you like to view?", "Logs") as null|anything in list(LOG_CHAT_LOCAL, LOG_CHAT_VILLAGE, LOG_CHAT_SQUAD, LOG_CHAT_FACTION, LOG_CHAT_GLOBAL, LOG_CHAT_WHISPER, LOG_CHAT_STAFF, LOG_ADMINISTRATOR, LOG_AKATSUKI, LOG_KAGE, LOG_BUGS, LOG_CLIENT_SAVES, LOG_ERROR, LOG_KILLS, LOG_SAVES, LOG_STAFF))
							if(LOG_CHAT_LOCAL)
								src << output(null, "Browser.Output")
								src << browse(file(LOG_CHAT_LOCAL))
								src.client.browser_url = BROWSER_LOGS
								winset(usr, "Browser", "is-visible = true")

							if(LOG_CHAT_VILLAGE)
								src << output(null, "Browser.Output")
								src << browse(file(LOG_CHAT_VILLAGE))
								src.client.browser_url = BROWSER_LOGS
								winset(usr, "Browser", "is-visible = true")

							if(LOG_CHAT_SQUAD)
								src << output(null, "Browser.Output")
								src << browse(file(LOG_CHAT_SQUAD))
								src.client.browser_url = BROWSER_LOGS
								winset(usr, "Browser", "is-visible = true")

							if(LOG_CHAT_FACTION)
								src << output(null, "Browser.Output")
								src << browse(file(LOG_CHAT_FACTION))
								src.client.browser_url = BROWSER_LOGS
								winset(usr, "Browser", "is-visible = true")

							if(LOG_CHAT_GLOBAL)
								src << output(null, "Browser.Output")
								src << browse(file(LOG_CHAT_GLOBAL))
								src.client.browser_url = BROWSER_LOGS
								winset(usr, "Browser", "is-visible = true")

							if(LOG_CHAT_WHISPER)
								src << output(null, "Browser.Output")
								src << browse(file(LOG_CHAT_WHISPER))
								src.client.browser_url = BROWSER_LOGS
								winset(usr, "Browser", "is-visible = true")
							
							if(LOG_CHAT_STAFF)
								src << output(null, "Browser.Output")
								src << browse(file(LOG_CHAT_STAFF))
								src.client.browser_url = BROWSER_LOGS
								winset(usr, "Browser", "is-visible = true")

							if(LOG_ADMINISTRATOR)
								usr << output(null, "Browser.Output")
								usr << browse(file(LOG_ADMINISTRATOR))
								src.client.browser_url = BROWSER_LOGS
								winset(usr, "Browser", "is-visible = true")
							
							if(LOG_AKATSUKI)
								usr << output(null, "Browser.Output")
								usr << browse(file(LOG_AKATSUKI))
								src.client.browser_url = BROWSER_LOGS
								winset(usr, "Browser", "is-visible = true")
							
							if(LOG_KAGE)
								usr << output(null, "Browser.Output")
								usr << browse(file(LOG_KAGE))
								src.client.browser_url = BROWSER_LOGS
								winset(usr, "Browser", "is-visible = true")

							if(LOG_BUGS)
								usr << output(null, "Browser.Output")
								usr << browse(file(LOG_BUGS))
								src.client.browser_url = BROWSER_LOGS
								winset(usr, "Browser", "is-visible = true")

							if(LOG_CLIENT_SAVES)
								usr << output(null, "Browser.Output")
								usr << browse(file(LOG_CLIENT_SAVES))
								src.client.browser_url = BROWSER_LOGS
								winset(usr, "Browser", "is-visible = true")

							if(LOG_ERROR)
								usr << output(null, "Browser.Output")
								usr << browse(file(LOG_ERROR))
								src.client.browser_url = BROWSER_LOGS
								winset(usr, "Browser", "is-visible = true")

							if(LOG_KILLS)
								usr << output(null, "Browser.Output")
								usr << browse(file(LOG_KILLS))
								src.client.browser_url = BROWSER_LOGS
								winset(usr, "Browser", "is-visible = true")

							if(LOG_SAVES)
								usr << output(null, "Browser.Output")
								usr << browse(file(LOG_SAVES))
								src.client.browser_url = BROWSER_LOGS
								winset(usr, "Browser", "is-visible = true")

							if(LOG_STAFF)
								usr << output(null, "Browser.Output")
								usr << browse(file(LOG_STAFF))
								src.client.browser_url = BROWSER_LOGS
								winset(usr, "Browser", "is-visible = true")

					if("Download Logs")
						switch(input("Which logs would you like to download?", "Manage Logs") as null|anything in list("All Logs", LOG_CHAT_LOCAL, LOG_CHAT_VILLAGE, LOG_CHAT_SQUAD, LOG_CHAT_FACTION, LOG_CHAT_GLOBAL, LOG_CHAT_WHISPER, LOG_CHAT_STAFF, LOG_ADMINISTRATOR, LOG_AKATSUKI, LOG_KAGE, LOG_BUGS, LOG_CLIENT_SAVES, LOG_ERROR, LOG_KILLS, LOG_SAVES, LOG_STAFF))
							if("All Logs")
								shell("zip -r logs/logs.zip logs/")
								usr << file("logs.zip")
								fdel("logs.zip")
							
							if(LOG_CHAT_LOCAL)
								src << ftp(LOG_CHAT_LOCAL)

							if(LOG_CHAT_VILLAGE)
								src << ftp(LOG_CHAT_VILLAGE)

							if(LOG_CHAT_SQUAD)
								src << ftp(LOG_CHAT_SQUAD)

							if(LOG_CHAT_FACTION)
								src << ftp(LOG_CHAT_FACTION)

							if(LOG_CHAT_GLOBAL)
								src << ftp(LOG_CHAT_GLOBAL)

							if(LOG_CHAT_WHISPER)
								src << ftp(LOG_CHAT_WHISPER)
							
							if(LOG_CHAT_STAFF)
								src << ftp(LOG_CHAT_STAFF)

							if(LOG_ADMINISTRATOR)
								usr << ftp(LOG_ADMINISTRATOR)
							
							if(LOG_AKATSUKI)
								usr << ftp(LOG_AKATSUKI)
							
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
						switch(input("Which logs would you like to clear?", "Manage Logs") as null|anything in list("All Logs", LOG_CHAT_LOCAL, LOG_CHAT_VILLAGE, LOG_CHAT_SQUAD, LOG_CHAT_FACTION, LOG_CHAT_GLOBAL, LOG_CHAT_WHISPER, LOG_CHAT_STAFF, LOG_ADMINISTRATOR, LOG_AKATSUKI, LOG_KAGE, LOG_BUGS, LOG_CLIENT_SAVES, LOG_ERROR, LOG_KILLS, LOG_SAVES, LOG_STAFF))
							if("All Logs")
								alert("Clearing of all logs has been disabled. This will be replaced with rotate logs soon.")
								return
								switch(alert("Are you sure you want to delete all logs?", "Manage Logs", "Clear All Logs", "Cancel"))
									if("Clear All Logs")
										fdel(LOG_ADMINISTRATOR)
										fdel(LOG_AKATSUKI)
										fdel(LOG_KAGE)
										fdel(LOG_BUGS)
										fdel(LOG_CLIENT_SAVES)
										fdel(LOG_ERROR)
										fdel(LOG_KILLS)
										fdel(LOG_SAVES)
										fdel(LOG_STAFF)
										usr << output("You have cleared all the server logs.", "Action.Output")
										world.CreateLogs()
										text2file("[time2text(world.realtime , "(YYYY-MM-DD hh:mm:ss)")] [usr] ([usr.ckey]) has cleared all the server logs.<br />", LOG_ADMINISTRATOR)
							
							if(LOG_CHAT_LOCAL)
								switch(src.client.Alert("Are you sure you want to delete the Local Chat logs?", "Manage Logs", list("Clear Logs", "Cancel")))
									if(1)
										fdel(LOG_CHAT_LOCAL)
										src << output("You have cleared the Local Chat logs.", "Action.Output")
										world.CreateLogs()
										text2file("[time2text(world.realtime , "(YYYY-MM-DD hh:mm:ss)")] [src] ([src.ckey]) has cleared the Local Chat logs.<br />", LOG_ADMINISTRATOR)

							if(LOG_CHAT_VILLAGE)
								switch(src.client.Alert("Are you sure you want to delete the Village Chat logs?", "Manage Logs", list("Clear Logs", "Cancel")))
									if(1)
										fdel(LOG_CHAT_VILLAGE)
										src << output("You have cleared the Village Chat logs.", "Action.Output")
										world.CreateLogs()
										text2file("[time2text(world.realtime , "(YYYY-MM-DD hh:mm:ss)")] [src] ([src.ckey]) has cleared the Village Chat logs.<br />", LOG_ADMINISTRATOR)

							if(LOG_CHAT_SQUAD)
								switch(src.client.Alert("Are you sure you want to delete the Squad Chat logs?", "Manage Logs", list("Clear Logs", "Cancel")))
									if(1)
										fdel(LOG_CHAT_SQUAD)
										src << output("You have cleared the Squad Chat logs.", "Action.Output")
										world.CreateLogs()
										text2file("[time2text(world.realtime , "(YYYY-MM-DD hh:mm:ss)")] [src] ([src.ckey]) has cleared the Squad Chat logs.<br />", LOG_ADMINISTRATOR)

							if(LOG_CHAT_FACTION)
								switch(src.client.Alert("Are you sure you want to delete the Faction Chat logs?", "Manage Logs", list("Clear Logs", "Cancel")))
									if(1)
										fdel(LOG_CHAT_FACTION)
										src << output("You have cleared the Faction Chat logs.", "Action.Output")
										world.CreateLogs()
										text2file("[time2text(world.realtime , "(YYYY-MM-DD hh:mm:ss)")] [src] ([src.ckey]) has cleared the Faction Chat logs.<br />", LOG_ADMINISTRATOR)

							if(LOG_CHAT_GLOBAL)
								switch(src.client.Alert("Are you sure you want to delete the Global Chat logs?", "Manage Logs", list("Clear Logs", "Cancel")))
									if(1)
										fdel(LOG_CHAT_GLOBAL)
										src << output("You have cleared the Global Chat logs.", "Action.Output")
										world.CreateLogs()
										text2file("[time2text(world.realtime , "(YYYY-MM-DD hh:mm:ss)")] [src] ([src.ckey]) has cleared the Global Chat logs.<br />", LOG_ADMINISTRATOR)

							if(LOG_CHAT_WHISPER)
								switch(src.client.Alert("Are you sure you want to delete the Whisper Chat logs?", "Manage Logs", list("Clear Logs", "Cancel")))
									if(1)
										fdel(LOG_CHAT_WHISPER)
										src << output("You have cleared the Whisper Chat logs.", "Action.Output")
										world.CreateLogs()
										text2file("[time2text(world.realtime , "(YYYY-MM-DD hh:mm:ss)")] [src] ([src.ckey]) has cleared the Whisper Chat logs.<br />", LOG_ADMINISTRATOR)
							
							if(LOG_CHAT_STAFF)
								switch(src.client.Alert("Are you sure you want to delete the Staff Chat logs?", "Manage Logs", list("Clear Logs", "Cancel")))
									if(1)
										fdel(LOG_CHAT_STAFF)
										src << output("You have cleared the Staff Chat logs.", "Action.Output")
										world.CreateLogs()
										text2file("[time2text(world.realtime , "(YYYY-MM-DD hh:mm:ss)")] [src] ([src.ckey]) has cleared the Staff Chat logs.<br />", LOG_ADMINISTRATOR)

							if(LOG_ADMINISTRATOR)
								switch(alert("Are you sure you want to delete the Administrator logs?", "Manage Logs", "Clear Logs", "Cancel"))
									if("Clear Logs")
										fdel(LOG_ADMINISTRATOR)
										usr << output("You have cleared the Administrator logs.", "Action.Output")
										world.CreateLogs()
										text2file("[time2text(world.realtime , "(YYYY-MM-DD hh:mm:ss)")] [usr] ([usr.ckey]) has cleared the Administrator logs.<br />", LOG_ADMINISTRATOR)
							
							if(LOG_AKATSUKI)
								switch(alert("Are you sure you want to delete the Akatsuki logs?", "Manage Logs", "Clear Logs", "Cancel"))
									if("Clear Logs")
										fdel(LOG_AKATSUKI)
										usr << output("You have cleared the Akatsuki logs.", "Action.Output")
										world.CreateLogs()
										text2file("[time2text(world.realtime , "(YYYY-MM-DD hh:mm:ss)")] [usr] ([usr.ckey]) has cleared the Akatsuki logs.<br />", LOG_ADMINISTRATOR)
							
							if(LOG_KAGE)
								switch(alert("Are you sure you want to delete the Kage logs?", "Manage Logs", "Clear Logs", "Cancel"))
									if("Clear Logs")
										fdel(LOG_KAGE)
										usr << output("You have cleared the Kage logs.", "Action.Output")
										world.CreateLogs()
										text2file("[time2text(world.realtime , "(YYYY-MM-DD hh:mm:ss)")] [usr] ([usr.ckey]) has cleared the Kage logs.<br />", LOG_ADMINISTRATOR)

							if(LOG_BUGS)
								switch(alert("Are you sure you want to delete the Bug logs?", "Manage Logs", "Clear Logs", "Cancel"))
									if("Clear Logs")
										fdel(LOG_BUGS)
										usr << output("You have cleared the Bug logs.", "Action.Output")
										world.CreateLogs()
										text2file("[time2text(world.realtime , "(YYYY-MM-DD hh:mm:ss)")] [usr] ([usr.ckey]) has cleared the Bug logs.<br />", LOG_ADMINISTRATOR)

							if(LOG_CLIENT_SAVES)
								switch(alert("Are you sure you want to delete the Client Save logs?", "Manage Logs", "Clear Logs", "Cancel"))
									if("Clear Logs")
										fdel(LOG_CLIENT_SAVES)
										usr << output("You have cleared the Client Save logs.", "Action.Output")
										world.CreateLogs()
										text2file("[time2text(world.realtime , "(YYYY-MM-DD hh:mm:ss)")] [usr] ([usr.ckey]) has cleared the Client Save logs.<br />", LOG_ADMINISTRATOR)

							if(LOG_ERROR)
								switch(alert("Are you sure you want to delete the Error logs?", "Manage Logs", "Clear Logs", "Cancel"))
									if("Clear Logs")
										fdel(LOG_ERROR)
										usr << output("You have cleared the Error logs.", "Action.Output")
										world.CreateLogs()
										text2file("[time2text(world.realtime , "(YYYY-MM-DD hh:mm:ss)")] [usr] ([usr.ckey]) has cleared the Error logs.<br />", LOG_ADMINISTRATOR)

							if(LOG_KILLS)
								switch(alert("Are you sure you want to delete the Kill logs?", "Manage Logs", "Clear Logs", "Cancel"))
									if("Clear Logs")
										fdel(LOG_KILLS)
										usr << output("You have cleared the Kill logs.", "Action.Output")
										world.CreateLogs()
										text2file("[time2text(world.realtime , "(YYYY-MM-DD hh:mm:ss)")] [usr] ([usr.ckey]) has cleared the Kill logs.<br />", LOG_ADMINISTRATOR)

							if(LOG_SAVES)
								switch(alert("Are you sure you want to delete the Character Save Logs?", "Manage Logs", "Clear Logs", "Cancel"))
									if("Clear Logs")
										fdel(LOG_SAVES)
										usr << output("You have cleared the Character Save logs.", "Action.Output")
										world.CreateLogs()
										text2file("[time2text(world.realtime , "(YYYY-MM-DD hh:mm:ss)")] [usr] ([usr.ckey]) has cleared the Character Save logs.<br />", LOG_ADMINISTRATOR)

							if(LOG_STAFF)
								switch(alert("Are you sure you want to delete the Staff Logs?", "Manage Logs", "Clear Logs", "Cancel"))
									if("Clear Logs")
										fdel(LOG_STAFF)
										usr << output("You have cleared the Staff logs.", "Action.Output")
										world.CreateLogs()
										text2file("[time2text(world.realtime , "(YYYY-MM-DD hh:mm:ss)")] [usr] ([usr.ckey]) has cleared the Staff logs.<br />", LOG_ADMINISTRATOR)
			
			Manage_Mission()
				set category = "Administrator"
				var/mob/M = input("Who's mission would you like to manage?", "Manage Mission") as null|anything in mobs_online
				var/squad/squad = M.GetSquad()
				if(M)
					switch(src.client.Alert("Would you like to complete or fail the mission for [M.name]'s Squad?", "Manage Mission", list("Complete", "Fail", "Cancel")))
						if(1)
							if(M)
								squad.mission.Complete(M)
								text2file("[time2text(world.realtime , "(YYYY-MM-DD hh:mm:ss)")] [src.name] ([src.ckey]) has completed [M.name]'s mission for their entire Squad.<br />", LOG_ADMINISTRATOR)
								
								if(src.client.Alert("Would you like to reset mission cooldown for [M.name]'s Squad?", "Manage Mission", list("Yes", "No")) == 1)
									for(var/mob/m in mobs_online)
										if(m && squad == m.GetSquad())
											m.client.last_mission = null
											var/savefile/F = new("[SAVEFILE_CLIENT]/[copytext(m.client.ckey, 1, 2)]/[m.client.ckey].sav")
											F["last_mission"] << null
									
									text2file("[time2text(world.realtime , "(YYYY-MM-DD hh:mm:ss)")] [src.name] ([src.ckey]) has reset the mission cooldown for [M.name]'s entire Squad.<br />", LOG_ADMINISTRATOR)
							
							else
								src.client.Alert("[M.name] isn't currently in a Squad.", "Manage Mission")

						if(2)
							if(M)
								if(squad.mission)
									squad.mission.status = "Failure"
									squad.mission.complete = world.realtime
									text2file("[time2text(world.realtime , "(YYYY-MM-DD hh:mm:ss)")] [src.name] ([src.ckey]) has failed [M.name]'s mission for their entire Squad.<br />", LOG_ADMINISTRATOR)

								if(src.client.Alert("Would you like to reset mission cooldown for [M.name]'s Squad?", "Manage Mission", list("Yes", "No")) == 1)
									for(var/mob/m in mobs_online)
										if(m && squad == m.GetSquad())
											m.client.last_mission = null
											var/savefile/F = new("[SAVEFILE_CLIENT]/[copytext(m.client.ckey, 1, 2)]/[m.client.ckey].sav")
											F["last_mission"] << null

									text2file("[time2text(world.realtime , "(YYYY-MM-DD hh:mm:ss)")] [src.name] ([src.ckey]) has reset the mission cooldown for [M.name]'s entire Squad.<br />", LOG_ADMINISTRATOR)
							
							else
								src.client.Alert("[M.name] isn't currently in a Squad.", "Manage Mission")
				
				else
					src.client.Alert("[M.name] isn't currently in a Squad.", "Manage Mission")

			Change_Name()
				set category = "Administrator"
				var/mob/M = input("Who would you like to rename?", "Change Name") as null|anything in mobs_online
				if(M)
					var/name = input("What would you like to rename [M] to?", "Change Name", M.name) as null|text
					if(name)
						if(M.client && lowertext(M.name) != lowertext(name) && names_taken.Find(lowertext(name)))
							alert("The name [name] is already in use.", "Change Name")
							return 0
						else
							switch(alert("Please choose a font color for [M].", "Change Name", "Village", "Custom"))
								if("Village")
									M.name_color_custom = null

								if("Custom")
									var/color = input("What custom character name color would you like for [M]?") as null|color
									if(color) M.name_color_custom = color

							if(M)
								var/old_character = M.character
								var/old_name = M.name
								var/old_src_name = usr.name

								names_taken.Remove(lowertext(old_character))
								names_taken.Add(lowertext(name))

								M.character = name
								M.SetName(name)

								if(hokage[M.client.ckey] == old_character)
									hokage[M.client.ckey] = M.character
								
								if(kazekage[M.client.ckey] == old_character)
									kazekage[M.client.ckey] = M.character
								
								if(akatsuki[M.client.ckey] == old_character)
									akatsuki[M.client.ckey] = M.character
								
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
								spawn() M.client.Alert({"
									[old_src_name] has changed your character name to <u>[name]</u>.
									<br /><br />
									<font color='#BE1A0E'><b><u>Warning:</u></b></font>
									<br />
									You will need to use your updated character name to login."})
								text2file("[time2text(world.realtime , "(YYYY-MM-DD hh:mm:ss)")] [usr] ([usr.ckey]) has changed [M]'s ([M.ckey]) character name to [name] ([M.ckey]).<br />", LOG_ADMINISTRATOR)
			
			Manage_Names()
				set category = "Administrator"
				switch(alert("Would you like to add or remove a name from the list of taken character names?", "Manage Names", "Add", "Remove"))
					if("Add")
						var/name = input("What character name would you like to add to the list of taken character names?", "Manage Names") as null|text
						
						if(name)
							names_taken.Add(name)
							text2file("[time2text(world.realtime , "(YYYY-MM-DD hh:mm:ss)")] [src] ([src.ckey]) has added [name] to the list of taken character names.<br />", LOG_ADMINISTRATOR)
							alert("The character name, [name], has been added to the list of taken character names.", "Manage Names")

					if("Remove")
						var/name = input("Which character name would you like to remove from the list of taken character names?", "Manage Names") as null|anything in names_taken
						
						if(name)
							names_taken.Remove(name)
							text2file("[time2text(world.realtime , "(YYYY-MM-DD hh:mm:ss)")] [src] ([src.ckey]) has removed [name] from the list of taken character names.<br />", LOG_ADMINISTRATOR)
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
					switch(alert("Would you like to give or take Ryo from [M]?", "Change Ryo", "Give", "Take", "Cancel"))
						if("Give")
							var/ryo = input("How much Ryo would you like to give to [M]?", "Change Ryo") as null|num
							if(ryo < 0) ryo = 0

							if(M)
								M.SetRyo(M.ryo + ryo)
								usr.client << output("You have given <b>[ryo]</b> Ryo to [M].","Action.Output")
								M.client << output("[usr] has given you <b>[ryo]</b> Ryo.","Action.Output")
								text2file("[time2text(world.realtime , "(YYYY-MM-DD hh:mm:ss)")] [usr] has changed [M]'s ryo from [ryo] to [M.ryo + ryo].<br />", LOG_ADMINISTRATOR)

						if("Take")
							var/ryo = input("How much Ryo would you like to take from [M]?", "Change Ryo") as null|num
							if(ryo < 0) ryo = 0

							if(M)
								M.SetRyo(M.ryo - ryo)
								usr.client << output("You have taken <b>[ryo]</b> Ryo from [M].","Action.Output")
								M.client << output("[usr] has taken <b>[ryo]</b> Ryo from you.","Action.Output")
								text2file("[time2text(world.realtime , "(YYYY-MM-DD hh:mm:ss)")] [usr] has changed [M]'s ryo from [ryo] to [M.ryo + ryo].<br />", LOG_ADMINISTRATOR)

			Change_Village()
				set category = "Administrator"
				var/mob/M = input("Who's village would you like to change?", "Change Rank") as null|anything in mobs_online
				if(M)
					switch(input("What would you like to change [M]'s village to?") as null|anything in list(VILLAGE_LEAF, VILLAGE_SAND, VILLAGE_AKATSUKI, VILLAGE_MISSING_NIN))
						if(VILLAGE_LEAF)
							if(M)
								var/squad/squad = M.GetSquad()
								if(squad)
									spawn() src.client.Alert("You change [M.character]'s village while they're in a Squad.", "Naruto Evolution")
									return 0

								usr.client << output("You have changed [M]'s village from [usr.village] to [VILLAGE_LEAF].","Action.Output")
								M.client << output("[usr] has changed your village from [usr.village] to [VILLAGE_LEAF].","Action.Output")
								text2file("[time2text(world.realtime , "(YYYY-MM-DD hh:mm:ss)")] [usr] has changed [M]'s village from [usr.village] to [VILLAGE_LEAF].<br />", LOG_ADMINISTRATOR)
								M.SetVillage(VILLAGE_LEAF)

								world.UpdateVillageCount()
								spawn() src.client.UpdateWhoAll()

						if(VILLAGE_SAND)
							if(M)
								var/squad/squad = M.GetSquad()
								if(squad)
									spawn() src.client.Alert("You change [M.character]'s village while they're in a Squad.", "Naruto Evolution")
									return 0

								usr.client << output("You have changed [M]'s village from [usr.village] to [VILLAGE_SAND].","Action.Output")
								M.client << output("[usr] has changed your village from [usr.village] to [VILLAGE_SAND].","Action.Output")
								text2file("[time2text(world.realtime , "(YYYY-MM-DD hh:mm:ss)")] [usr] has changed [M]'s village from [usr.village] to [VILLAGE_SAND].<br />", LOG_ADMINISTRATOR)
								M.SetVillage(VILLAGE_SAND)

								world.UpdateVillageCount()
								spawn() src.client.UpdateWhoAll()
						
						if(VILLAGE_AKATSUKI)
							if(M)
								var/squad/squad = M.GetSquad()
								if(squad)
									spawn() src.client.Alert("You change [M.character]'s village while they're in a Squad.", "Naruto Evolution")
									return 0

								usr.client << output("You have changed [M]'s village from [usr.village] to [VILLAGE_AKATSUKI].","Action.Output")
								M.client << output("[usr] has changed your village from [usr.village] to [VILLAGE_AKATSUKI].","Action.Output")
								text2file("[time2text(world.realtime , "(YYYY-MM-DD hh:mm:ss)")] [usr] has changed [M]'s village from [usr.village] to [VILLAGE_AKATSUKI].<br />", LOG_ADMINISTRATOR)
								M.SetVillage(VILLAGE_AKATSUKI)

								world.UpdateVillageCount()
								spawn() src.client.UpdateWhoAll()

						if(VILLAGE_MISSING_NIN)
							if(M)
								var/squad/squad = M.GetSquad()
								if(squad)
									spawn() src.client.Alert("You change [M.character]'s village while they're in a Squad.", "Naruto Evolution")
									return 0
									
								usr.client << output("You have changed [M]'s village from [usr.village] to [VILLAGE_MISSING_NIN].","Action.Output")
								M.client << output("[usr] has changed your village from [usr.village] to [VILLAGE_MISSING_NIN].","Action.Output")
								text2file("[time2text(world.realtime , "(YYYY-MM-DD hh:mm:ss)")] [usr] has changed [M]'s village from [usr.village] to [VILLAGE_MISSING_NIN].<br />", LOG_ADMINISTRATOR)
								M.SetVillage(VILLAGE_MISSING_NIN)

								world.UpdateVillageCount()
								spawn() src.client.UpdateWhoAll()

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
								text2file("[time2text(world.realtime , "(YYYY-MM-DD hh:mm:ss)")] [usr] has changed [M]'s rank from [usr.rank] to [RANK_ACADEMY_STUDENT].<br />", LOG_ADMINISTRATOR)

						if(RANK_GENIN)
							if(M)
								M.SetRank(RANK_GENIN)
								usr.client << output("You have changed [M]'s rank from [usr.rank] to [RANK_GENIN].","Action.Output")
								M.client << output("[usr] has changed your rank from [usr.rank] to [RANK_GENIN].","Action.Output")
								text2file("[time2text(world.realtime , "(YYYY-MM-DD hh:mm:ss)")] [usr] has changed [M]'s rank from [usr.rank] to [RANK_GENIN].<br />", LOG_ADMINISTRATOR)

						if(RANK_CHUUNIN)
							if(M)
								M.SetRank(RANK_CHUUNIN)
								usr.client << output("You have changed [M]'s rank from [usr.rank] to [RANK_CHUUNIN].","Action.Output")
								M.client << output("[usr] has changed your rank from [usr.rank] to [RANK_CHUUNIN].","Action.Output")
								text2file("[time2text(world.realtime , "(YYYY-MM-DD hh:mm:ss)")] [usr] has changed [M]'s rank from [usr.rank] to [RANK_CHUUNIN].<br />", LOG_ADMINISTRATOR)

						if(RANK_JOUNIN)
							if(M)
								M.SetRank(RANK_JOUNIN)
								usr.client << output("You have changed [M]'s rank from [usr.rank] to [RANK_JOUNIN].","Action.Output")
								M.client << output("[usr] has changed your rank from [usr.rank] to [RANK_JOUNIN].","Action.Output")
								text2file("[time2text(world.realtime , "(YYYY-MM-DD hh:mm:ss)")] [usr] has changed [M]'s rank from [usr.rank] to [RANK_JOUNIN].<br />", LOG_ADMINISTRATOR)

						if(RANK_ANBU)
							if(M)
								M.SetRank(RANK_ANBU)
								usr.client << output("You have changed [M]'s rank from [usr.rank] to [RANK_ANBU].","Action.Output")
								M.client << output("[usr] has changed your rank from [usr.rank] to [RANK_ANBU].","Action.Output")
								text2file("[time2text(world.realtime , "(YYYY-MM-DD hh:mm:ss)")] [usr] has changed [M]'s rank from [usr.rank] to [RANK_ANBU].<br />", LOG_ADMINISTRATOR)

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
								text2file("[usr]([usr.key]) has used give everything on [C.mob.name]([C.key]).: [time2text(world.realtime , "(YYYY-MM-DD hh:mm:ss)")]<br>", LOG_STAFF)
					else
						text2file("[usr]([usr.key]) has attempted to use give everything on [C.mob.name]([C.key]).: [time2text(world.realtime , "(YYYY-MM-DD hh:mm:ss)")]<br>", LOG_STAFF)
						usr.client.Alert("You can only use this command on Administrators.")
				else
					usr.client.Alert("This command is restricted to Administrators.")

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
				switch(usr.client.Alert("Would you like to invite or boot ninja from the [VILLAGE_AKATSUKI]?", "Manage Members", list("Invite", "Exile", "Cancel")))
					if(1)
						var/list/exclude = list(usr)
						for(var/mob/m in mobs_online)
							if(m.village != VILLAGE_MISSING_NIN) exclude += m

						var/mob/m = input("Who would you like to invite to the [VILLAGE_AKATSUKI]", "Manage Members") as null|anything in mobs_online - exclude

						if(m)
							if(m.village == VILLAGE_MISSING_NIN)
								switch(m.client.Alert("The [usr.rank], [usr.name], formally invites you to join the [usr.village]. Do you accept this invitation?", "Akatsuki Invitation", list("Yes", "No")))
									if(1)
										if(m.village == VILLAGE_MISSING_NIN)

											var/squad/squad = m.GetSquad()
											if(squad)
												spawn() src.client.Alert("You cannot invite someone who is in a Squad.", "Naruto Evolution")
												spawn() m.client.Alert("You cannot join a village while in a Squad.", "Naruto Evolution")
												return 0

											usr.client.Alert("[m.name] has accepted your invitation to join the [usr.village].")

											m.SetVillage(usr.village)
											m.SetRank(RANK_AKATSUKI)
											world.UpdateVillageCount()
				
											spawn() src.client.UpdateWhoAll()

										else
											spawn() usr.client.Alert("[m.name] is no longer a [VILLAGE_MISSING_NIN] and is therefore unable to join the [usr.village].")
											spawn() m.client.Alert("You are no longer a [VILLAGE_MISSING_NIN] and are therefore unable to join the [usr.village].")

									if(2)
										usr.client.Alert("[m.name] has rejected your invitation to join the [usr.village].")

							else
								usr.client.Alert("You can't send a village invitation to [m.name] because they are not a [VILLAGE_MISSING_NIN].", "Manage Members")
						
						else
							usr.client.Alert("The ninja you were going to invite is no longer online and is therefore unable to be invited.", "Manage Members")

					if(2)
						var/list/exclude = list(usr)
						for(var/mob/m in mobs_online)
							if(m.village != usr.village) exclude += m

						var/mob/m = input("Who would you like to boot from the [usr.village]?", "Manage Members") as null|anything in mobs_online - exclude

						if(m)
							if(m.village == usr.village)
							
								var/squad/squad = m.GetSquad()
								if(squad)
									spawn() src.client.Alert("You can't exile [m.name] from the [usr.village] village because they are currently in a Squad.")
									return 0

								spawn() usr.client.Alert("You have formally exiled [m.name] from the [usr.village].", "Member Exile")
								spawn() m.client.Alert("The [usr.rank], [usr.name], formally exiles you from the [usr.village].", "Member Exile")

								m.SetVillage(VILLAGE_MISSING_NIN)
								world.UpdateVillageCount()
				
								spawn() src.client.UpdateWhoAll()

							else
								usr.client.Alert("[m.name] is no longer in the [usr.village] village and is therefore unable to be exiled.", "Manage Members")
						else
							usr.client.Alert("The ninja you were going to exile is no longer online and is therefore unable to be exiled.", "Manage Members")
			
			Retire()
				set category = "Akatsuki"
				switch(usr.client.Alert("Are you sure that you want to retire as [usr.rank]?", "Retire [usr.rank]", list("Retire", "Cancel")))
					if(1)
						switch(usr.client.Alert("Would you like to choose a successor?", "Retire [usr.rank]", list("Yes", "No", "Cancel")))
							if(1)
								var/list/exclude = list(usr)
								for(var/mob/m in mobs_online)
									if(m.village != VILLAGE_AKATSUKI) exclude += m

								var/mob/m = input("Who would you like to succeed you as [usr.rank]?", "Retire [usr.rank]") as null|anything in mobs_online - exclude
								if(m)
									if(m.village == VILLAGE_AKATSUKI)
										switch(m.client.Alert("The [usr.rank], [usr.name], formally invites you to succeed them as the [usr.rank]. Do you accept this invitation?", "[usr.rank] Invitation", list("Yes", "No")))
											if(1)
												spawn() usr.client.Alert("[m.name] has accepted your invitation to succeed you as the [usr.rank].")

												world << output("[usr.character] has retired from office as the [RANK_AKATSUKI_LEADER] for the <font color='[COLOR_VILLAGE_AKATSUKI]'>[VILLAGE_AKATSUKI]</font>.", "Action.Output")
												text2file("<font color = '[COLOR_CHAT]'>[time2text(world.realtime , "(YYYY-MM-DD hh:mm:ss)")] [usr.character] ([usr.client.ckey]) has retired from office as the [RANK_AKATSUKI] for the <font color='[COLOR_VILLAGE_AKATSUKI]'>[VILLAGE_AKATSUKI]</font>.</font><br />", LOG_AKATSUKI)

												world << output("[usr.character] has appointed [m.character] as their successor and is now the [RANK_AKATSUKI_LEADER] for the <font color='[COLOR_VILLAGE_AKATSUKI]'>[VILLAGE_AKATSUKI]</font>.", "Action.Output")
												text2file("<font color = '[COLOR_CHAT]'>[time2text(world.realtime , "(YYYY-MM-DD hh:mm:ss)")] [usr.character] ([usr.client.ckey]) has appointed [m.character] ([m.client.ckey]) as their successor and is now the [RANK_AKATSUKI_LEADER] for the <font color='[COLOR_VILLAGE_AKATSUKI]'>[VILLAGE_AKATSUKI]</font>.</font><br />", LOG_AKATSUKI)

												m.SetRank(usr.rank)
												m.client.StaffCheck()

												usr.SetRank(RANK_AKATSUKI)
												usr.client.StaffCheck()

												var/squad/squad = usr.GetSquad()
												if(squad) spawn() squad.Refresh()

												var/squad/squad2 = m.GetSquad()
												if(squad2) spawn() squad2.Refresh()
											
											if(2)
												usr.client.Alert("[m.name] has rejected your invitation to succeed you as the [usr.rank].")
									else
										usr.client.Alert("You can't send a [usr.rank] invitation to [m.name] because they are no longer in the [usr.village].", "Retire [usr.rank]")
								else
									usr.client.Alert("The ninja you were going to promote to [usr.rank] is no longer online and is therefore unable to be promoted.", "Retire [usr.rank]")
										
							if(2)

								world << output("[usr.character] has retired from office as the [RANK_AKATSUKI_LEADER] for the <font color='[COLOR_VILLAGE_AKATSUKI]'>[VILLAGE_AKATSUKI]</font>.", "Action.Output")
								text2file("<font color = '[COLOR_CHAT]'>[time2text(world.realtime , "(YYYY-MM-DD hh:mm:ss)")] [usr.character] ([usr.client.ckey]) has retired from office as the [RANK_AKATSUKI_LEADER] for the <font color='[COLOR_VILLAGE_AKATSUKI]'>[VILLAGE_AKATSUKI]</font>.</font><br />", LOG_AKATSUKI)
																
								akatsuki = list()
								akatsuki_last_online = null

								usr.SetRank(RANK_AKATSUKI)

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

											var/squad/squad = m.GetSquad()
											if(squad)
												spawn() src.client.Alert("You cannot invite someone who is in a Squad.", "Naruto Evolution")
												spawn() m.client.Alert("You cannot join a village while in a Squad.", "Naruto Evolution")
												return 0

											usr.client.Alert("[m.name] has accepted your invitation to join the [usr.village] village.")

											m.SetVillage(usr.village)
											m.SetRank(RANK_GENIN)
											world.UpdateVillageCount()
				
											spawn() src.client.UpdateWhoAll()

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

								var/squad/squad = m.GetSquad()
								if(squad)
									spawn() src.client.Alert("You can't exile [m.name] from the [usr.village] village because they are currently in a Squad.")
									return 0

								spawn() usr.client.Alert("You have formally exiled [m.name] from the [usr.village] village.", "Village Exile")
								spawn() m.client.Alert("The [usr.village] [usr.rank], [usr.name], formally exiles you from the [usr.village] village.", "Village Exile")

								m.SetVillage(VILLAGE_MISSING_NIN)

								world.UpdateVillageCount()
								spawn() src.client.UpdateWhoAll()

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
										if(m.rank == RANK_CHUUNIN || m.rank == RANK_JOUNIN || m.rank == RANK_ANBU)
											switch(m.client.Alert("The [usr.village] [usr.rank], [usr.name], formally invites you to succeed them as [usr.rank]. Do you accept this invitation?", "[usr.rank] Invitation", list("Yes", "No")))
												if(1)
													spawn() usr.client.Alert("[m.name] has accepted your invitation to succeed you as [usr.rank].")

													switch(usr.rank)
														if(RANK_HOKAGE)
															world << output("[usr.character] has retired from office as the [RANK_HOKAGE] for the <font color='[COLOR_VILLAGE_LEAF]'>[VILLAGE_LEAF]</font>.", "Action.Output")
															text2file("<font color = '[COLOR_CHAT]'>[time2text(world.realtime , "(YYYY-MM-DD hh:mm:ss)")] [usr.character] ([usr.client.ckey]) has retired from office as the [RANK_HOKAGE] for the <font color='[COLOR_VILLAGE_LEAF]'>[VILLAGE_LEAF]</font>.</font><br />", LOG_KAGE)

															world << output("[usr.character] has appointed [m.character] as their successor and is now the [RANK_HOKAGE] for the <font color='[COLOR_VILLAGE_LEAF]'>[VILLAGE_LEAF]</font>.", "Action.Output")
															text2file("<font color = '[COLOR_CHAT]'>[time2text(world.realtime , "(YYYY-MM-DD hh:mm:ss)")] [usr.character] ([usr.client.ckey]) has appointed [m.character] ([m.client.ckey]) as their successor and is now the [RANK_HOKAGE] for the <font color='[COLOR_VILLAGE_LEAF]'>[VILLAGE_LEAF]</font>.</font><br />", LOG_KAGE)
														
														if(RANK_KAZEKAGE)
															world << output("[usr.character] has retired from office as the [RANK_KAZEKAGE] for the <font color='[COLOR_VILLAGE_SAND]'>[VILLAGE_SAND]</font>.", "Action.Output")
															text2file("<font color = '[COLOR_CHAT]'>[time2text(world.realtime , "(YYYY-MM-DD hh:mm:ss)")] [usr.character] ([usr.client.ckey]) has retired from office as the [RANK_KAZEKAGE] for the <font color='[COLOR_VILLAGE_SAND]'>[VILLAGE_SAND]</font>.</font><br />", LOG_KAGE)
															
															world << output("[usr.character] has appointed [m.character] as their successor and is now the [RANK_KAZEKAGE] for the <font color='[COLOR_VILLAGE_SAND]'>[VILLAGE_SAND]</font>.", "Action.Output")
															text2file("<font color = '[COLOR_CHAT]'>[time2text(world.realtime , "(YYYY-MM-DD hh:mm:ss)")] [usr.character] ([usr.client.ckey]) has appointed [m.character] ([m.client.ckey]) as their successor and is now the [RANK_KAZEKAGE] for the <font color='[COLOR_VILLAGE_SAND]'>[VILLAGE_SAND]</font>.</font><br />", LOG_KAGE)
													
													m.SetRank(usr.rank)
													m.client.StaffCheck()

													usr.SetRank(RANK_CHUUNIN)
													usr.client.StaffCheck()

													var/squad/squad = usr.GetSquad()
													if(squad) spawn() squad.Refresh()

													var/squad/squad2 = m.GetSquad()
													if(squad2) spawn() squad2.Refresh()
												
												if(2)
													usr.client.Alert("[m.name] has rejected your invitation to succeed you as [usr.rank].")
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
										hokage = list()

									if(RANK_KAZEKAGE)
										world << output("[usr.character] has retired from office as the [RANK_KAZEKAGE] for the <font color='[COLOR_VILLAGE_SAND]'>[VILLAGE_SAND]</font>.", "Action.Output")
										text2file("<font color = '[COLOR_CHAT]'>[time2text(world.realtime , "(YYYY-MM-DD hh:mm:ss)")] [usr.character] ([usr.client.ckey]) has retired from office as the [RANK_KAZEKAGE] for the <font color='[COLOR_VILLAGE_SAND]'>[VILLAGE_SAND]</font>.</font><br />", LOG_KAGE)
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
