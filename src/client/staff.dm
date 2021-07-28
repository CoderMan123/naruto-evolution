mob
	administrator
		verb
			Toggle_Zetsu_Event()
				set category = "Administrator"
				if(zetsu_event_toggle)
					zetsu_event_toggle = 0
					src << output("<b>Zetsu events disabled.</b>","Action.Output")
				else
					zetsu_event_toggle = 1
					src << output("<b>Zetsu events enabled.</b>","Action.Output")

			Start_Zetsu_Event()
				set category = "Administrator"
				if(!zetsu_event_active)
					ZetsuEventStart()
				else src << output("<b>There is already a Zetsu event active. Please wait until the current one has finished before starting another.</b>","Action.Output")

			End_Mission()
				set category = "Administrator"
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

			Manage_Logs()
				set category = "Administrator"
				switch(alert("What would you like to do?", "Manage Logs", "View Logs", "Download Logs", "Clear Logs"))
					if("View Logs")
						switch(input("Which logs would you like to view?", "Logs") as null|anything in list(LOG_ADMINISTRATOR, LOG_BUGS, LOG_CLIENT_SAVES, LOG_ERROR, LOG_KILLS, LOG_SAVES, LOG_STAFF))
							if(LOG_ADMINISTRATOR)
								src << output(null, "Browser.Output")
								src << browse(file(LOG_ADMINISTRATOR))
								winset(src, "Browser", "is-visible = true")

							if(LOG_BUGS)
								src << output(null, "Browser.Output")
								src << browse(file(LOG_BUGS))
								winset(src, "Browser", "is-visible = true")

							if(LOG_CLIENT_SAVES)
								src << output(null, "Browser.Output")
								src << browse(file(LOG_CLIENT_SAVES))
								winset(src, "Browser", "is-visible = true")

							if(LOG_ERROR)
								src << output(null, "Browser.Output")
								src << browse(file(LOG_ERROR))
								winset(src, "Browser", "is-visible = true")

							if(LOG_KILLS)
								src << output(null, "Browser.Output")
								src << browse(file(LOG_KILLS))
								winset(src, "Browser", "is-visible = true")

							if(LOG_SAVES)
								src << output(null, "Browser.Output")
								src << browse(file(LOG_SAVES))
								winset(src, "Browser", "is-visible = true")

							if(LOG_STAFF)
								src << output(null, "Browser.Output")
								src << browse(file(LOG_STAFF))
								winset(src, "Browser", "is-visible = true")

					if("Download Logs")
						switch(input("Which logs would you like to download?", "Manage Logs") as null|anything in list("All Logs", LOG_ADMINISTRATOR, LOG_BUGS, LOG_CLIENT_SAVES, LOG_ERROR, LOG_KILLS, LOG_SAVES, LOG_STAFF))
							if("All Logs")
								shell("zip -r logs/logs.zip logs/")
								src << file("logs.zip")
								fdel(file("logs.zip"))

							if(LOG_ADMINISTRATOR)
								src << ftp(LOG_ADMINISTRATOR)

							if(LOG_BUGS)
								src << ftp(LOG_BUGS)

							if(LOG_CLIENT_SAVES)
								src << ftp(LOG_CLIENT_SAVES)

							if(LOG_ERROR)
								src << ftp(LOG_ERROR)

							if(LOG_KILLS)
								src << ftp(LOG_KILLS)

							if(LOG_SAVES)
								src << ftp(LOG_SAVES)

							if(LOG_STAFF)
								src << ftp(LOG_STAFF)

					if("Clear Logs")
						switch(input("Which logs would you like to clear?", "Manage Logs") as null|anything in list("All Logs", LOG_ADMINISTRATOR, LOG_BUGS, LOG_CLIENT_SAVES, LOG_ERROR, LOG_KILLS, LOG_SAVES, LOG_STAFF))
							if("All Logs")
								switch(alert("Are you sure you want to delete all logs?", "Manage Logs", "Clear All Logs", "Cancel"))
									if("Clear All Logs")
										fdel(LOG_ADMINISTRATOR)
										fdel(LOG_BUGS)
										fdel(LOG_CLIENT_SAVES)
										fdel(LOG_ERROR)
										fdel(LOG_KILLS)
										fdel(LOG_SAVES)
										fdel(LOG_STAFF)
										src << output("You have cleared all the server logs.", "Action.Output")
										text2file("[time2text(world.realtime , "(YYYY-MM-DD hh:mm:ss)") ] [src] ([src.ckey]) has cleared all the server logs.", LOG_ADMINISTRATOR)

							if(LOG_ADMINISTRATOR)
								switch(alert("Are you sure you want to delete the Administrator logs?", "Manage Logs", "Clear Logs", "Cancel"))
									if("Clear Logs")
										fdel(LOG_ADMINISTRATOR)
										src << output("You have cleared the Administrator logs.", "Action.Output")
										text2file("[time2text(world.realtime , "(YYYY-MM-DD hh:mm:ss)") ] [src] ([src.ckey]) has cleared the Administrator logs.", LOG_ADMINISTRATOR)

							if(LOG_BUGS)
								switch(alert("Are you sure you want to delete the Bug logs?", "Manage Logs", "Clear Logs", "Cancel"))
									if("Clear Logs")
										fdel(LOG_BUGS)
										src << output("You have cleared the Bug logs.", "Action.Output")
										text2file("[time2text(world.realtime , "(YYYY-MM-DD hh:mm:ss)") ] [src] ([src.ckey]) has cleared the Bug logs.", LOG_ADMINISTRATOR)

							if(LOG_CLIENT_SAVES)
								switch(alert("Are you sure you want to delete the Client Save logs?", "Manage Logs", "Clear Logs", "Cancel"))
									if("Clear Logs")
										fdel(LOG_CLIENT_SAVES)
										src << output("You have cleared the Client Save logs.", "Action.Output")
										text2file("[time2text(world.realtime , "(YYYY-MM-DD hh:mm:ss)") ] [src] ([src.ckey]) has cleared the Client Save logs.", LOG_ADMINISTRATOR)

							if(LOG_ERROR)
								switch(alert("Are you sure you want to delete the Error logs?", "Manage Logs", "Clear Logs", "Cancel"))
									if("Clear Logs")
										fdel(LOG_ERROR)
										src << output("You have cleared the Error logs.", "Action.Output")
										text2file("[time2text(world.realtime , "(YYYY-MM-DD hh:mm:ss)") ] [src] ([src.ckey]) has cleared the Error logs.", LOG_ADMINISTRATOR)

							if(LOG_KILLS)
								switch(alert("Are you sure you want to delete the Kill logs?", "Manage Logs", "Clear Logs", "Cancel"))
									if("Clear Logs")
										fdel(LOG_KILLS)
										src << output("You have cleared the Kill logs.", "Action.Output")
										text2file("[time2text(world.realtime , "(YYYY-MM-DD hh:mm:ss)") ] [src] ([src.ckey]) has cleared the Kill logs.", LOG_ADMINISTRATOR)

							if(LOG_SAVES)
								switch(alert("Are you sure you want to delete the Character Save Logs?", "Manage Logs", "Clear Logs", "Cancel"))
									if("Clear Logs")
										fdel(LOG_SAVES)
										src << output("You have cleared the Character Save logs.", "Action.Output")
										text2file("[time2text(world.realtime , "(YYYY-MM-DD hh:mm:ss)") ] [src] ([src.ckey]) has cleared the Character Save logs.", LOG_ADMINISTRATOR)

							if(LOG_STAFF)
								switch(alert("Are you sure you want to delete the Staff Logs?", "Manage Logs", "Clear Logs", "Cancel"))
									if("Clear Logs")
										fdel(LOG_STAFF)
										src << output("You have cleared the Staff logs.", "Action.Output")
										text2file("[time2text(world.realtime , "(YYYY-MM-DD hh:mm:ss)") ] [src] ([src.ckey]) has cleared the Staff logs.", LOG_ADMINISTRATOR)

			Reset_Mission_Cooldown()
				set category = "Administrator"
				src.client.last_mission = null
				var/savefile/F = new("[SAVEFILE_CLIENT]/[copytext(src.client.ckey, 1, 2)]/[src.client.ckey].sav")
				F["last_mission"] << null
				src << output("You have reset your mission cooldown.", "Action.Output")
				text2file("[time2text(world.realtime , "(YYYY-MM-DD hh:mm:ss)") ] [src] ([src.ckey]) has reset their mission cooldown.", LOG_ADMINISTRATOR)

			Change_Name()
				set category = "Administrator"
				var/mob/M = input("Who would you like to rename?", "Change Name") as null|anything in mobs_online
				if(M)
					var/name = input("What would you like to rename [M] to?", "Change Name", M.name) as null|text
					if(name)
						if(M.client && names_taken.Find(name))
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
								src << "You have changed [M]'s name to <u>[name]</u>."
								M << "[src] has changed your name to <u>[name]</u>."
								text2file("[time2text(world.realtime , "(YYYY-MM-DD hh:mm:ss)") ] [src] ([src.ckey]) has changed [M]'s ([M.ckey]) name to [name] ([M.ckey]).", LOG_ADMINISTRATOR)
								M.SetName(name)
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
								src.client << output("You have given <b>[ryo]</b> Ryo to [M].","Action.Output")
								M.client << output("[src] has given you <b>[ryo]</b> Ryo.","Action.Output")
								text2file("[time2text(world.realtime , "(YYYY-MM-DD hh:mm:ss)") ] [src] has changed [M]'s ryo from [ryo] to [M.ryo + ryo].", LOG_ADMINISTRATOR)

						if("Take")
							var/ryo = input("How much Ryo would you like to take from [M]?", "Change Ryo") as null|num
							if(ryo < 0) ryo = 0

							if(M)
								M.SetRyo(M.ryo - ryo)
								src.client << output("You have taken <b>[ryo]</b> Ryo from [M].","Action.Output")
								M.client << output("[src] has taken <b>[ryo]</b> Ryo from you.","Action.Output")
								text2file("[time2text(world.realtime , "(YYYY-MM-DD hh:mm:ss)") ] [src] has changed [M]'s ryo from [ryo] to [M.ryo + ryo].", LOG_ADMINISTRATOR)

			Change_Village()
				set category = "Administrator"
				var/mob/M = input("Who's village would you like to change?", "Change Rank") as null|anything in mobs_online
				if(M)
					switch(input("What would you like to change [M]'s village to?") as null|anything in list(VILLAGE_LEAF, VILLAGE_SAND, VILLAGE_MISSING_NIN))
						if(VILLAGE_LEAF)
							if(M)
								src.client << output("You have changed [M]'s village from [src.village] to [VILLAGE_LEAF].","Action.Output")
								M.client << output("[src] has changed your village from [src.village] to [VILLAGE_LEAF].","Action.Output")
								text2file("[time2text(world.realtime , "(YYYY-MM-DD hh:mm:ss)") ] [src] has changed [M]'s village from [src.village] to [VILLAGE_LEAF].", LOG_ADMINISTRATOR)
								M.SetVillage(VILLAGE_LEAF)

						if(VILLAGE_SAND)
							if(M)
								src.client << output("You have changed [M]'s village from [src.village] to [VILLAGE_SAND].","Action.Output")
								M.client << output("[src] has changed your village from [src.village] to [VILLAGE_SAND].","Action.Output")
								text2file("[time2text(world.realtime , "(YYYY-MM-DD hh:mm:ss)") ] [src] has changed [M]'s village from [src.village] to [VILLAGE_SAND].", LOG_ADMINISTRATOR)
								M.SetVillage(VILLAGE_SAND)

						if(VILLAGE_MISSING_NIN)
							if(M)
								src.client << output("You have changed [M]'s village from [src.village] to [VILLAGE_MISSING_NIN].","Action.Output")
								M.client << output("[src] has changed your village from [src.village] to [VILLAGE_MISSING_NIN].","Action.Output")
								text2file("[time2text(world.realtime , "(YYYY-MM-DD hh:mm:ss)") ] [src] has changed [M]'s village from [src.village] to [VILLAGE_MISSING_NIN].", LOG_ADMINISTRATOR)
								M.SetVillage(VILLAGE_MISSING_NIN)

			Change_Rank()
				set category = "Administrator"
				var/mob/M = input("Who's rank would you like to change?", "Change Rank") as null|anything in mobs_online
				if(M)
					switch(input("What would you like to change [M]'s rank to?") as null|anything in list(RANK_ACADEMY_STUDENT, RANK_GENIN, RANK_CHUUNIN, RANK_JOUNIN, RANK_ANBU, RANK_ANBU_LEADER, RANK_HOKAGE, RANK_KAZEKAGE, RANK_MIZUKAGE, RANK_OTOKAGE, RANK_TSUCHIKAGE, RANK_AKATSUKI, RANK_AKATSUKI_LEADER, RANK_SEVEN_SWORDSMEN_LEADER))
						if(RANK_ACADEMY_STUDENT)
							if(M)
								M.SetRank(RANK_ACADEMY_STUDENT)
								src.client << output("You have changed [M]'s rank from [src.rank] to [RANK_ACADEMY_STUDENT].","Action.Output")
								M.client << output("[src] has changed your rank from [src.rank] to [RANK_ACADEMY_STUDENT].","Action.Output")
								text2file("[time2text(world.realtime , "(YYYY-MM-DD hh:mm:ss)") ] [src] has changed [M]'s rank from [src.rank] to [RANK_ACADEMY_STUDENT].", LOG_ADMINISTRATOR)

						if(RANK_GENIN)
							if(M)
								M.SetRank(RANK_GENIN)
								src.client << output("You have changed [M]'s rank from [src.rank] to [RANK_GENIN].","Action.Output")
								M.client << output("[src] has changed your rank from [src.rank] to [RANK_GENIN].","Action.Output")
								text2file("[time2text(world.realtime , "(YYYY-MM-DD hh:mm:ss)") ] [src] has changed [M]'s rank from [src.rank] to [RANK_GENIN].", LOG_ADMINISTRATOR)

						if(RANK_CHUUNIN)
							if(M)
								M.SetRank(RANK_CHUUNIN)
								src.client << output("You have changed [M]'s rank from [src.rank] to [RANK_CHUUNIN].","Action.Output")
								M.client << output("[src] has changed your rank from [src.rank] to [RANK_CHUUNIN].","Action.Output")
								text2file("[time2text(world.realtime , "(YYYY-MM-DD hh:mm:ss)") ] [src] has changed [M]'s rank from [src.rank] to [RANK_CHUUNIN].", LOG_ADMINISTRATOR)

						if(RANK_JOUNIN)
							if(M)
								M.SetRank(RANK_JOUNIN)
								src.client << output("You have changed [M]'s rank from [src.rank] to [RANK_JOUNIN].","Action.Output")
								M.client << output("[src] has changed your rank from [src.rank] to [RANK_JOUNIN].","Action.Output")
								text2file("[time2text(world.realtime , "(YYYY-MM-DD hh:mm:ss)") ] [src] has changed [M]'s rank from [src.rank] to [RANK_JOUNIN].", LOG_ADMINISTRATOR)

						if(RANK_ANBU)
							if(M)
								M.SetRank(RANK_ANBU)
								src.client << output("You have changed [M]'s rank from [src.rank] to [RANK_ANBU].","Action.Output")
								M.client << output("[src] has changed your rank from [src.rank] to [RANK_ANBU].","Action.Output")
								text2file("[time2text(world.realtime , "(YYYY-MM-DD hh:mm:ss)") ] [src] has changed [M]'s rank from [src.rank] to [RANK_ANBU].", LOG_ADMINISTRATOR)

						if(RANK_ANBU_LEADER)
							if(M)
								M.SetRank(RANK_ANBU_LEADER)
								src.client << output("You have changed [M]'s rank from [src.rank] to [RANK_ANBU_LEADER].","Action.Output")
								M.client << output("[src] has changed your rank from [src.rank] to [RANK_ANBU_LEADER].","Action.Output")
								text2file("[time2text(world.realtime , "(YYYY-MM-DD hh:mm:ss)") ] [src] has changed [M]'s rank from [src.rank] to [RANK_ANBU_LEADER].", LOG_ADMINISTRATOR)

						if(RANK_HOKAGE)
							if(M)
								M.SetRank(RANK_HOKAGE)
								src.client << output("You have changed [M]'s rank from [src.rank] to [RANK_HOKAGE].","Action.Output")
								M.client << output("[src] has changed your rank from [src.rank] to [RANK_HOKAGE].","Action.Output")
								text2file("[time2text(world.realtime , "(YYYY-MM-DD hh:mm:ss)") ] [src] has changed [M]'s rank from [src.rank] to [RANK_HOKAGE].", LOG_ADMINISTRATOR)

						if(RANK_KAZEKAGE)
							if(M)
								M.SetRank(RANK_KAZEKAGE)
								src.client << output("You have changed [M]'s rank from [src.rank] to [RANK_KAZEKAGE].","Action.Output")
								M.client << output("[src] has changed your rank from [src.rank] to [RANK_KAZEKAGE].","Action.Output")
								text2file("[time2text(world.realtime , "(YYYY-MM-DD hh:mm:ss)") ] [src] has changed [M]'s rank from [src.rank] to [RANK_KAZEKAGE].", LOG_ADMINISTRATOR)

						if(RANK_MIZUKAGE)
							if(M)
								M.SetRank(RANK_MIZUKAGE)
								src.client << output("You have changed [M]'s rank from [src.rank] to [RANK_MIZUKAGE].","Action.Output")
								M.client << output("[src] has changed your rank from [src.rank] to [RANK_MIZUKAGE].","Action.Output")
								text2file("[time2text(world.realtime , "(YYYY-MM-DD hh:mm:ss)") ] [src] has changed [M]'s rank from [src.rank] to [RANK_MIZUKAGE].", LOG_ADMINISTRATOR)

						if(RANK_OTOKAGE)
							if(M)
								M.SetRank(RANK_OTOKAGE)
								src.client << output("You have changed [M]'s rank from [src.rank] to [RANK_OTOKAGE].","Action.Output")
								M.client << output("[src] has changed your rank from [src.rank] to [RANK_OTOKAGE].","Action.Output")
								text2file("[time2text(world.realtime , "(YYYY-MM-DD hh:mm:ss)") ] [src] has changed [M]'s rank from [src.rank] to [RANK_OTOKAGE].", LOG_ADMINISTRATOR)

						if(RANK_TSUCHIKAGE)
							if(M)
								M.SetRank(RANK_TSUCHIKAGE)
								src.client << output("You have changed [M]'s rank from [src.rank] to [RANK_TSUCHIKAGE].","Action.Output")
								M.client << output("[src] has changed your rank from [src.rank] to [RANK_TSUCHIKAGE].","Action.Output")
								text2file("[time2text(world.realtime , "(YYYY-MM-DD hh:mm:ss)") ] [src] has changed [M]'s rank from [src.rank] to [RANK_TSUCHIKAGE].", LOG_ADMINISTRATOR)

						if(RANK_AKATSUKI)
							if(M)
								M.SetRank(RANK_AKATSUKI)
								src.client << output("You have changed [M]'s rank from [src.rank] to [RANK_AKATSUKI].","Action.Output")
								M.client << output("[src] has changed your rank from [src.rank] to [RANK_AKATSUKI].","Action.Output")
								text2file("[time2text(world.realtime , "(YYYY-MM-DD hh:mm:ss)") ] [src] has changed [M]'s rank from [src.rank] to [RANK_AKATSUKI].", LOG_ADMINISTRATOR)

						if(RANK_AKATSUKI_LEADER)
							if(M)
								M.SetRank(RANK_AKATSUKI_LEADER)
								src.client << output("You have changed [M]'s rank from [src.rank] to [RANK_AKATSUKI_LEADER].","Action.Output")
								M.client << output("[src] has changed your rank from [src.rank] to [RANK_AKATSUKI_LEADER].","Action.Output")
								text2file("[time2text(world.realtime , "(YYYY-MM-DD hh:mm:ss)") ] [src] has changed [M]'s rank from [src.rank] to [RANK_AKATSUKI_LEADER].", LOG_ADMINISTRATOR)

						if(RANK_SEVEN_SWORDSMEN_LEADER)
							if(M)
								M.SetRank(RANK_SEVEN_SWORDSMEN_LEADER)
								src.client << output("You have changed [M]'s rank from [src.rank] to [RANK_SEVEN_SWORDSMEN_LEADER].","Action.Output")
								M.client << output("[src] has changed your rank from [src.rank] to [RANK_SEVEN_SWORDSMEN_LEADER].","Action.Output")
								text2file("[time2text(world.realtime , "(YYYY-MM-DD hh:mm:ss)") ] [src] has changed [M]'s rank from [src.rank] to [RANK_SEVEN_SWORDSMEN_LEADER].", LOG_ADMINISTRATOR)