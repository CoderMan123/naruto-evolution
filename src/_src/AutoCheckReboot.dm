var/AFKLog=file("Logs/AFK Log.txt")
proc
	AutoCheck()
		while(true)
			sleep(rand(36000, 72000)) // 1-2 hours
			for(var/mob/M in mobs_online)
				if(M.key)
					M.exp_locked=1
					M << output("You have been automatically experience locked. Please click the flashing <font color=red><u>Experience Lock</u></font> button to continue earning experience.", "Action.Output")
					winset(M, "Navigation.ExpLockButton", "is-disabled = 'false'")
					spawn() M.client.FlashExperienceLock()
				else continue