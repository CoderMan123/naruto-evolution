var/AFKLog=file("Logs/AFK Log.txt")
proc
	AutoCheck()
		set background=1
		var/SleepTime=rand(12000, 24000)//20-40min
		sleep(SleepTime)//sleep a random amount of time so players can't predict when the next check is
		world<<"<font color=red>Exp lock was auto initiated! Please use the command \"Remove Exp Lock\" on the bottom bar to remove the lock!"
		for(var/mob/M in TotalPlayers)
			if(M.key)
				M.ExpLock=1
				M.Save()
			else
				continue
		AutoCheck()

	AutoReboot()
		set background=1
		sleep(864000)//24hrs
		world<<"<font color=red>World is automatically rebooting!"
		world.Reboot()

	CheckHost()
		set background=1
		if(!fexists("HostKey.txt"))
			text2file("This text file is to give the host admin verbs. Remove ALL text from this file and put your byond Key in lowercase letters.","HostKey.txt")
