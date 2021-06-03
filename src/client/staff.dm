mob
	administrator
		verb
			clear_mission_timer()
				set category = "Administrator"
				src.client.last_mission = null
				var/savefile/F = new("[SAVEFILE_CLIENT]/[copytext(src.client.ckey, 1, 2)]/[src.client.ckey].sav")
				F["last_mission"] << null
			
			Change_Rank()
				set category = "Administrator"
				var/mob/M = input("Who's rank would you like to change?", "Change Rank") as null|anything in mobs_online
				if(M)
					switch(input("What would you like to change [M]'s rank to?") as null|anything in list(RANK_ACADEMY_STUDENT, RANK_GENIN, RANK_CHUUNIN, RANK_JOUNIN, RANK_ANBU, RANK_ANBU_LEADER, RANK_HOKAGE, RANK_KAZEKAGE, RANK_MIZUKAGE, RANK_OTOKAGE, RANK_TSUCHIKAGE, RANK_AKATSUKI, RANK_AKATSUKI_LEADER, RANK_SEVEN_SWORDSMEN_LEADER))
						if(RANK_ACADEMY_STUDENT)
							if(M)
								M.SetRank(RANK_ACADEMY_STUDENT)
								src.client << output("You have changed [M]'s rank from [src.rank] to [RANK_ACADEMY_STUDENT].","Action.Output")
								M.client << output("[src] has changed [M]'s rank from [src.rank] to [RANK_ACADEMY_STUDENT].","Action.Output")
								text2file("[time2text(world.realtime , "(YYYY-MM-DD hh:mm:ss)") ] [src] has changed [M]'s rank from [src.rank] to [RANK_ACADEMY_STUDENT].", LOG_ADMINISTRATOR)

						if(RANK_GENIN)
							if(M)
								M.SetRank(RANK_GENIN)
								src.client << output("You have changed [M]'s rank from [src.rank] to [RANK_GENIN].","Action.Output")
								M.client << output("[src] has changed [M]'s rank from [src.rank] to [RANK_GENIN].","Action.Output")
								text2file("[time2text(world.realtime , "(YYYY-MM-DD hh:mm:ss)") ] [src] has changed [M]'s rank from [src.rank] to [RANK_GENIN].", LOG_ADMINISTRATOR)

						if(RANK_CHUUNIN)
							if(M)
								M.SetRank(RANK_CHUUNIN)
								src.client << output("You have changed [M]'s rank from [src.rank] to [RANK_CHUUNIN].","Action.Output")
								M.client << output("[src] has changed [M]'s rank from [src.rank] to [RANK_CHUUNIN].","Action.Output")
								text2file("[time2text(world.realtime , "(YYYY-MM-DD hh:mm:ss)") ] [src] has changed [M]'s rank from [src.rank] to [RANK_CHUUNIN].", LOG_ADMINISTRATOR)

						if(RANK_JOUNIN)
							if(M)
								M.SetRank(RANK_JOUNIN)
								src.client << output("You have changed [M]'s rank from [src.rank] to [RANK_JOUNIN].","Action.Output")
								M.client << output("[src] has changed [M]'s rank from [src.rank] to [RANK_JOUNIN].","Action.Output")
								text2file("[time2text(world.realtime , "(YYYY-MM-DD hh:mm:ss)") ] [src] has changed [M]'s rank from [src.rank] to [RANK_JOUNIN].", LOG_ADMINISTRATOR)

						if(RANK_ANBU)
							if(M)
								M.SetRank(RANK_ANBU)
								src.client << output("You have changed [M]'s rank from [src.rank] to [RANK_ANBU].","Action.Output")
								M.client << output("[src] has changed [M]'s rank from [src.rank] to [RANK_ANBU].","Action.Output")
								text2file("[time2text(world.realtime , "(YYYY-MM-DD hh:mm:ss)") ] [src] has changed [M]'s rank from [src.rank] to [RANK_ANBU].", LOG_ADMINISTRATOR)

						if(RANK_ANBU_LEADER)
							if(M)
								M.SetRank(RANK_ANBU_LEADER)
								src.client << output("You have changed [M]'s rank from [src.rank] to [RANK_ANBU_LEADER].","Action.Output")
								M.client << output("[src] has changed [M]'s rank from [src.rank] to [RANK_ANBU_LEADER].","Action.Output")
								text2file("[time2text(world.realtime , "(YYYY-MM-DD hh:mm:ss)") ] [src] has changed [M]'s rank from [src.rank] to [RANK_ANBU_LEADER].", LOG_ADMINISTRATOR)

						if(RANK_HOKAGE)
							if(M)
								M.SetRank(RANK_HOKAGE)
								src.client << output("You have changed [M]'s rank from [src.rank] to [RANK_HOKAGE].","Action.Output")
								M.client << output("[src] has changed [M]'s rank from [src.rank] to [RANK_HOKAGE].","Action.Output")
								text2file("[time2text(world.realtime , "(YYYY-MM-DD hh:mm:ss)") ] [src] has changed [M]'s rank from [src.rank] to [RANK_HOKAGE].", LOG_ADMINISTRATOR)

						if(RANK_KAZEKAGE)
							if(M)
								M.SetRank(RANK_KAZEKAGE)
								src.client << output("You have changed [M]'s rank from [src.rank] to [RANK_KAZEKAGE].","Action.Output")
								M.client << output("[src] has changed [M]'s rank from [src.rank] to [RANK_KAZEKAGE].","Action.Output")
								text2file("[time2text(world.realtime , "(YYYY-MM-DD hh:mm:ss)") ] [src] has changed [M]'s rank from [src.rank] to [RANK_KAZEKAGE].", LOG_ADMINISTRATOR)

						if(RANK_MIZUKAGE)
							if(M)
								M.SetRank(RANK_MIZUKAGE)
								src.client << output("You have changed [M]'s rank from [src.rank] to [RANK_MIZUKAGE].","Action.Output")
								M.client << output("[src] has changed [M]'s rank from [src.rank] to [RANK_MIZUKAGE].","Action.Output")
								text2file("[time2text(world.realtime , "(YYYY-MM-DD hh:mm:ss)") ] [src] has changed [M]'s rank from [src.rank] to [RANK_MIZUKAGE].", LOG_ADMINISTRATOR)

						if(RANK_OTOKAGE)
							if(M)
								M.SetRank(RANK_OTOKAGE)
								src.client << output("You have changed [M]'s rank from [src.rank] to [RANK_OTOKAGE].","Action.Output")
								M.client << output("[src] has changed [M]'s rank from [src.rank] to [RANK_OTOKAGE].","Action.Output")
								text2file("[time2text(world.realtime , "(YYYY-MM-DD hh:mm:ss)") ] [src] has changed [M]'s rank from [src.rank] to [RANK_OTOKAGE].", LOG_ADMINISTRATOR)

						if(RANK_TSUCHIKAGE)
							if(M)
								M.SetRank(RANK_TSUCHIKAGE)
								src.client << output("You have changed [M]'s rank from [src.rank] to [RANK_TSUCHIKAGE].","Action.Output")
								M.client << output("[src] has changed [M]'s rank from [src.rank] to [RANK_TSUCHIKAGE].","Action.Output")
								text2file("[time2text(world.realtime , "(YYYY-MM-DD hh:mm:ss)") ] [src] has changed [M]'s rank from [src.rank] to [RANK_TSUCHIKAGE].", LOG_ADMINISTRATOR)

						if(RANK_AKATSUKI)
							if(M)
								M.SetRank(RANK_AKATSUKI)
								src.client << output("You have changed [M]'s rank from [src.rank] to [RANK_AKATSUKI].","Action.Output")
								M.client << output("[src] has changed [M]'s rank from [src.rank] to [RANK_AKATSUKI].","Action.Output")
								text2file("[time2text(world.realtime , "(YYYY-MM-DD hh:mm:ss)") ] [src] has changed [M]'s rank from [src.rank] to [RANK_AKATSUKI].", LOG_ADMINISTRATOR)

						if(RANK_AKATSUKI_LEADER)
							if(M)
								M.SetRank(RANK_AKATSUKI_LEADER)
								src.client << output("You have changed [M]'s rank from [src.rank] to [RANK_AKATSUKI_LEADER].","Action.Output")
								M.client << output("[src] has changed [M]'s rank from [src.rank] to [RANK_AKATSUKI_LEADER].","Action.Output")
								text2file("[time2text(world.realtime , "(YYYY-MM-DD hh:mm:ss)") ] [src] has changed [M]'s rank from [src.rank] to [RANK_AKATSUKI_LEADER].", LOG_ADMINISTRATOR)

						if(RANK_SEVEN_SWORDSMEN_LEADER)
							if(M)
								M.SetRank(RANK_SEVEN_SWORDSMEN_LEADER)
								src.client << output("You have changed [M]'s rank from [src.rank] to [RANK_SEVEN_SWORDSMEN_LEADER].","Action.Output")
								M.client << output("[src] has changed [M]'s rank from [src.rank] to [RANK_SEVEN_SWORDSMEN_LEADER].","Action.Output")
								text2file("[time2text(world.realtime , "(YYYY-MM-DD hh:mm:ss)") ] [src] has changed [M]'s rank from [src.rank] to [RANK_SEVEN_SWORDSMEN_LEADER].", LOG_ADMINISTRATOR)