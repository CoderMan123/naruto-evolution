var/AFKLog=file("Logs/AFK Log.txt")
proc
	AutoCheck()
		set background=1
		var/SleepTime=rand(12000, 24000)//20-40min
		sleep(SleepTime)//sleep a random amount of time so players can't predict when the next check is
		world<<"<font color=red>Exp lock was auto initiated! Please use the command \"Remove Exp Lock\" on the bottom bar to remove the lock!"
		for(var/mob/M in mobs_online)
			if(M.key)
				M.exp_locked=1
				winset(M, "Navigation.ExpLockButton", "is-disabled = 'false'")
				spawn() M.client.FlashExperienceLock()
			else
				continue
		AutoCheck()