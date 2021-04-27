var/list/Kages = list("Hidden Leaf"=null,"Hidden Sand"=null,"Hidden Mist"=null,"Hidden Sound"=null,"Hidden Rock"=null)//kensei = bane, punky = taco, qwesti = Rise, raunts = sisa, Flyboyed = Yohan
var/list/MasterGMs = list("squigs" , "rootabyss", "illusiveblair", "lavenblade")
var/list/Admins = list("reformist")//,
var/list/Moderators = list("raunts61")//"kensei_hirako","kenseihirako","FlyBoyEd","qwestizero"
var/list/PArtists = list("illusiveblair")//,"punkykick"
var/HostKey = file(CFG_HOST)

mob/var/
	canteleport = 1
	jailed=0

proc/MasterGMCheck(ckey)
	if(MasterGMs.Find(ckey)) return 1

proc/AdminCheck(ckey)
	if(Admins.Find(ckey)||MasterGMs.Find(ckey)||usr.ckey == file2text(HostKey)) return 1
	else return 0

proc/ModeratorCheck(ckey)
	if(Moderators.Find(ckey)||MasterGMs.Find(ckey)||Admins.Find(ckey)) return 1
	else return 0

proc/ArtistCheck(ckey)
	if(Moderators.Find(ckey)||MasterGMs.Find(ckey)||Admins.Find(ckey)||PArtists.Find(ckey)) return 1
	else return 0

mob/proc/AddAdminVerbs()
	if(Kages["[village]"]==src.ckey||rank=="Hokage"||rank=="Kazekage"||rank=="Mizukage"||rank=="Otokage"||rank=="Tsuchikage")
		src.verbs+=typesof(/mob/Kage/verb/)
		winset(src, "Navigation.LeaderButton", "is-disabled = 'false'")

	if(rank=="Akatsuki Leader")
		src.verbs+=typesof(/mob/AkatsukiLeader/verb/)
		winset(src, "Navigation.LeaderButton", "is-disabled = 'false'")

	if(rank=="Anbu Leader")
		src.verbs+=typesof(/mob/AnbuLeader/verb/)
		winset(src, "Navigation.LeaderButton", "is-disabled = 'false'")

	if(rank=="Seven Swordsmen Leader")
		src.verbs+=typesof(/mob/SevenSwordsmenLeader/verb/)
		winset(src, "Navigation.LeaderButton", "is-disabled = 'false'")

	if(MasterGMCheck(ckey))
		src.verbs+=typesof(/mob/MasterGM/verb/)
		src.verbs+=typesof(/mob/Admin/verb/)
		src.verbs+=typesof(/mob/Moderator/verb/)
		src.verbs+=typesof(/mob/PixelArtist/verb/)
		src.admin=1
		client.control_freak/CONTROL_FREAK_ALL=0
		winset(src, "Navigation.LeaderButton", "is-disabled = 'false'")

	if(AdminCheck(src.ckey)||src.ckey == file2text(HostKey))
		src.verbs+=typesof(/mob/Admin/verb/)
		src.verbs+=typesof(/mob/Moderator/verb/)
		src.verbs+=typesof(/mob/PixelArtist/verb/)
		src.admin=1
		winset(src, "Navigation.LeaderButton", "is-disabled = 'false'")

	if(ModeratorCheck(ckey))
		src.verbs+=typesof(/mob/Moderator/verb/)
		src.admin=1
		winset(src, "Navigation.LeaderButton", "is-disabled = 'false'")

	if(ArtistCheck(ckey))
		src.verbs+=typesof(/mob/PixelArtist/verb/)
		winset(src, "Navigation.LeaderButton", "is-disabled = 'false'")

mob/proc/RemoveAdminVerbs()
	src.verbs-=typesof(/mob/Kage/verb/)
	src.verbs-=typesof(/mob/Moderator/verb/)
	src.verbs-=typesof(/mob/Admin/verb/)
	src.verbs-=typesof(/mob/PixelArtist/verb/)
	src.verbs-=typesof(/mob/MasterGM/verb/)
	AddAdminVerbs()

mob/PixelArtist/verb/
	Add_Overlay(icon1 as icon,overlay1 as text)
		set category="Staff"
		src.overlays+=image(icon1,overlay1)

	Remove_Overlay(icon1 as icon,overlay1 as text)
		set category="Staff"
		src.overlays-=image(icon1,overlay1)

	Add_Underlay(icon1 as icon,overlay1 as text)
		set category="Staff"
		src.underlays+=image(icon1,overlay1)

	Remove_Underlay(icon1 as icon,overlay1 as text)
		set category="Staff"
		src.underlays-=image(icon1,overlay1)

	Change_Icon(icon1 as icon,iconstate as text)
		set category="Staff"
		icon=icon1
		icon_state=iconstate

	Test_Base_States()
		set category="Staff"
		var/list/states =icon_states(src.icon)
		for(var/dir in list(NORTH,EAST,SOUTH,WEST))
			src.dir=dir
			for(var/icon_state in states)
				src.icon_state=icon_state
				sleep(20)
	Get_Test_Base_States()
		set name="Test Base States Get"
		set category="Staff"
		var/dir
		switch(src.dir)
			if(1) dir="NORTH"
			if(2) dir="SOUTH"
			if(3) dir="WEST"
			if(4) dir="EAST"
		src<<"[dir] : [src.icon_state]"
	Single_Test_Base_State(state1 as text)
		set name="Change State"
		set category="Staff"
		src.icon_state=state1
mob/Moderator/verb/
	CheckStats(mob/M in mobs_online)
		set category = "Staff"
		usr<<"Level:[M.level]"
		usr<<"Health:[M.maxhealth]"
		usr<<"Chakra:[M.maxchakra]"
		usr<<"Ninjutsu:[M.ninjutsu]"
		usr<<"Genjutsu:[M.genjutsu]"
		usr<<"Strength:[M.strength]"
		usr<<"Agility:[M.agility]"
		usr<<"Defence:[M.defence]"

	World_Chat_Admin()
		set category = "Staff"
		set name = "World Chat"
		var/a = input("What do you wish to say in world chat?") as text
		if(!a)
			return
		else
			world<<"<font color = white><font size=1.5>[src.name]: [a]"

	Spy(mob/M as mob in mobs_online)
		set category="Staff"
		usr.client.perspective = EYE_PERSPECTIVE
		usr.client.eye = M

	Spy_Stop()
		set category="Staff"
		usr.client.perspective = EYE_PERSPECTIVE
		usr.client.eye = usr

	Delete(atom/O in world)
		set category="Staff"
		if(!admin) return
		if(ismob(O))
			var/mob/M=O
			if(!M.client) del(M)
			if(O.name=="area")
				if(src:key!="Squigs")
					usr<<"You are not allowed to delete the area anymore!"
					text2file("[usr] tried to delete [O.name]: [time2text(world.timeofday, "MMM DD hh:mm:ss")]<br>",LOG_STAFF)

					return
			else
				if(alert("Are you sure you want to delete the Atom [O.name]?","Confirm!","No","Yes")=="Yes")
					text2file("[usr] deleted [O.name]: [time2text(world.timeofday, "MMM DD hh:mm:ss")]<br>",LOG_STAFF)
					del(O)
		else del(O)
	Start_Chuunin_Exam()
		set category="Staff"
		//ChuuninExam()
		if(chuuninlock==1)
			usr<<"Ninja War is in progress...please wait until it's over..."
			return
		ChuuninExam="Starting"
		world<<output("<b><center>A Chuunin exam will begin in 3 minutes.</b></center>","Action.Output")
		sleep(600*3)
		world<<output("<b><center>The Written Exam of the Chuunin exam has begun!</b></center>","Action.Output")
		ChuuninExam="Written"
		sleep(600*2)
		world<<output("<b><center>The Written Exam of the Chuunin exam is now over!</b></center>","Action.Output")
		ChuuninExam="Forest of Death"
		var/count=0
		for(var/mob/M in mobs_online)
			if(M.cheww==1)
				M.cheww=0
				M.loc = pick(block(locate(73,97,4),locate(198,161,4)))
				if(count==0)
					var/obj/O = new/obj/ChuuninExam/Scrolls/EarthScroll
					O.loc = M
					count=1
				else
					var/obj/O = new/obj/ChuuninExam/Scrolls/HeavenScroll
					O.loc = M
					count=0
		sleep(600*4)
		world<<output("<b><center>The Second Part of the Chuunin exam is now over!</b></center>","Action.Output")
		ChuuninExam="Tournament"
		ChuuninExamGo()

	Turn_Clones_Off_On()
		set category = "Staff"
		set name = "Turn Clones On/Off"
		if(clonesturned==1)
			clonesturned=0
			world<<"[usr] turned on clones."
		else
			clonesturned=1
			world<<"[usr] turned off clones."
	WorldMute()
		set category = "Staff"
		set name = "Mute/Unmute World"
		if(worldmute==1)
			worldmute=0
			world<<"[usr] Unmuted world chat."
		else
			worldmute=1
			world<<"[usr] Muted world chat."
	AFK_Check()
		set category = "Staff"
		world<<"<font color=red>Exp lock manually initiated! Everyone on the server is now officially Exp Locked!"
		world<<"<font color=red>Please use the button \"Remove Exp Lock\" on the bottom bar to remove the lock!"
		for(var/mob/M in world)
			if(M.key)
				M.exp_locked=1
				winset(M, "Navigation.ExpLockButton", "is-disabled = 'false'")
				spawn() M.client.FlashExperienceLock()
			else
				continue

	Exp_Lock_Who()
		set category="Staff"
		var/N=0
		for(var/mob/M in mobs_online)
			if(M.client&&M.exp_locked)
				usr<<"<small><small>[M.rname]/[M.key]</small></small>"
				N++
		usr<<"<small><small><b>A total of [N] players are Exp Locked!</b></small></small>"

	GM_Chat(c as text)
		set category="Staff"
		if(!c) return
		if(length(c)<=750)
			for(var/mob/M in mobs_online)
				if(!Admins.Find(M.ckey)&&!MasterGMs.Find(M.ckey)&&!Moderators.Find(M.ckey)) continue
				M<<"<font color=yellow> GM| [src.rname]:</font>[html_encode(c)]"
			text2file("GM>>[src.rname]:</font> [html_encode(c)]: [time2text(world.timeofday, "MMM DD hh:mm:ss")]<br>",LOG_STAFF)
		else
			src<<"Please do not use more than 250 characters."
			src<<"Message was <i>[c]</i>"
			return

	Boot(mob/M in mobs_online)
		set category="Staff"
		if(administrators.Find(M.ckey))
			for(var/mob/m in mobs_online)
				if(administrators.Find(m.client.ckey))
					m << "[src] ([src.ckey]) tried to boot an administrator [M] ([M.ckey])."

			text2file("[src] ([src.ckey]) tried to boot an administrator [M] ([M.ckey]).: [time2text(world.timeofday, "MMM DD hh:mm:ss")]<br>", LOG_STAFF)
		else
			M.Save()
			del(M.client)
			world<<"[src] has booted [M] from the game."
			text2file("[src] ([src.ckey]) booted [M] ([M.ckey]).: [time2text(world.timeofday, "MMM DD hh:mm:ss")]<br>",LOG_STAFF)

	Mute(mob/M in mobs_online)
		set category="Staff"
		set name = "Mute/Unmute"
		if(M.key=="Squigs")
			world<<"[usr] tried to mute [M]..."
			text2file("[usr]([src.key]) tried to mute [M]([M.key]): [time2text(world.timeofday, "MMM DD hh:mm:ss")]<br>",LOG_STAFF)
			return
		if(!M.Muted)
			var/howlong=input("How long for? (Minutes)","Mute") as num
			world<<"[M] has been muted by [src] for [howlong] minutes."
			text2file("[M]([M.key]) was muted by [src]([src.key]) for [howlong]min.: [time2text(world.timeofday, "MMM DD hh:mm:ss")]<br>",LOG_STAFF)
			howlong*=600
			M.Muted=1
			M.MuteTime=howlong
			M.Muted()
		else
			M.Muted=1
			M.MuteTime=1
			M.Muted()

	Teleport(mob/M in world)
		set category="Staff"
		if(M.canteleport == 0) return
		src.loc=M.loc

	Summon(mob/M in mobs_online)
		set category="Staff"
		src.overlays+=image('Smoke.dmi',"smoke")
		M.loc=src.loc
		sleep(13)
		src.overlays-=image('Smoke.dmi',"smoke")

	Jail(var/mob/M in mobs_online)
		set category = "Staff"
		spawn(1)
			M.loc=locate(106,35,16)
			M.xplock=1
			M.jailed=1
			var/timer = input("How many minutes should they be jailed?") as num
			var/Offence = input(" What are you jailing [M] for?")as text
			world<<"[M] has been jailed for [timer] Minutes! Reason:[Offence]"
			text2file("[usr]([src.key]) jailed [M]([M.key]) for [timer]min for [Offence].: [time2text(world.timeofday, "MMM DD hh:mm:ss")]<br>",LOG_STAFF)
			spawn(timer*600)
				if(M.jailed)
					M.xplock=0
					M.jailed=0
					world<<"[M] has been Un-jailed!"
					M.loc=MapLoadSpawn()
				else return
	AdminTele()
		set category = "Staff"
		set name = "Enter Admin Hideout"
		usr.loc = locate(31,38,14)
	Reboot()
		set category="Staff"
		world<<output("World is rebooting.","Action.Output")
		text2file("[usr]([src.key]) rebooted.: [time2text(world.timeofday, "MMM DD hh:mm:ss")]<br>",LOG_STAFF)
		world.Reboot()


mob/var/xplock=0
mob/var/tmp/AdminShield
mob/var/watching=0
mob/Admin/verb
	Announce(t as text)
		set category = "Staff"
		if(!t) return
		if(!admin) return
		world<<"<center><b>---------------------------------</b></center>"
		world<<"<center><b>Announcement from [src]</b><br><br>[t]</b></font></center></p></br></b></center>"
		world<<"<center><b>---------------------------------</b></center>"
		text2file("[src]([src.key]) announced [t].: [time2text(world.timeofday, "MMM DD hh:mm:ss")]<br>",LOG_STAFF)

	Staff_Who()
		set category = "Staff"
		var/amount=0
		if(!admin) return
		var/Who={"<html><center>
<head><title>Who's Online</title><body>
<body bgcolor="green"><font family='Comic Sans MS'><font size=2><font color="#0099FF"><b>
</body><html>"}
		for(var/mob/M) if(M.client) amount+=1
		for(var/mob/M) if(M.client) Who+={"<html><center>
<head><title>Staff Who</title><body>
<body bgcolor="green"><font family='Comic Sans MS'><font size=2><font color="#0099FF"><b>
<br><font color=white>[M.name] ([M.key]) - (Level: [M.level])
</body><html>"}
		Who+={"<html>
<head><title></head></title><body>
<body bgcolor="green"><font family='Comic Sans MS'><font size=2><font color=blue><b>
<br><u>[amount] player(s) online</u>
</body><html>"}
		src<<browse(Who,"window=Who;size=400x400")
		Who={"<html><center>
<head><title>Staff Who</title><body>
<body bgcolor="green"><font family='Comic Sans MS'><font size=2><font color="#0099FF"><b>
</body><html>"}
	Votation(t as text)
		set desc = "What Would You like To Create A Votation For?"
		set category = "Staff"
		if(VotationGoingOn==1)
			world<<output("<b><font color=red>Wait... We don't want to have spam.","Action.Output")
			return
		Y=0
		world<<output("<u><b><font color=white>[src.key] has initiated a votation!</u>","Action.Output")
		N=0
		VoteMessage=t
		VotationGoingOn=1
		Vote_Check()
		Vote_Election()
	Get_Bugs()
		set category = "Staff"
		var/bugs = file("Bugs.txt")
		usr << browse(bugs)
		winset(src, null, {"
						Browser.is-visible = "true";
					"})
	Get_ErrorLog()
		set category = "Staff"
		var/ErLog = file(LOG_ERROR)
		usr << browse(ErLog)
		winset(src, null, {"
						Browser.is-visible = "true";
					"})

	Get_KillLog()
		set category = "Staff"
		var/killlog = file(LOG_KILLS)
		usr << browse(killlog)
		winset(src, null, {"
						Browser.is-visible = "true";
					"})


	Promote_to_Position(mob/M in mobs_online)
		set category = "Staff"
		var/list/Positions=list("Akatsuki Leader"/*,"Seven Swordsmen Leader","Anbu Leader"*/)
		var/Position=input("What position will you give them?","Promotion") in Positions + "Cancel"
		if(Position=="Cancel") return
		switch(Position)
			if("Akatsuki Leader")
				M<<"You now lead the Akatsuki."
				text2file("[M]([M.key]) was promoted to Akat by [usr]([usr.key]).: [time2text(world.timeofday, "MMM DD hh:mm:ss")]<br>",LOG_STAFF)
				new/obj/Inventory/Clothing/Robes/Akatsuki_Robe(M)
				//new/obj/Inventory/Weaponry/MadaraFan(M) // Fan is bug-able and is also OP.
				new/obj/Inventory/Clothing/HeadWrap/TobiMask(M)
				new/obj/Inventory/Clothing/HeadWrap/AkatsukiHat(M)
				M.village="Akatsuki"

			if("Seven Swordsmen Leader")
				M<<"You now lead the Seven Swordsmen."
				text2file("[M]([M.key]) was promoted to 7sm lead by [usr]([usr.key]).: [time2text(world.timeofday, "MMM DD hh:mm:ss")]<br>",LOG_STAFF)
				new/obj/Inventory/Weaponry/Hiramekarei(M)
				M.village="Seven Swordsmen"

			if("Anbu Leader")
				M<<"You now lead the Anbu Root."
				text2file("[M]([M.key]) was promoted to Anbu by [usr]([usr.key]).: [time2text(world.timeofday, "MMM DD hh:mm:ss")]<br>",LOG_STAFF)
				new/obj/Inventory/Clothing/Robes/Anbu_Suit(M)
				new/obj/Inventory/Clothing/Masks/Absolute_Zero_Mask(M)
				M.village="Anbu Root"

		M.rank="[Position]"
		var/squad/squad = M.GetSquad()
		if(squad)
			squad.Refresh()

		M.AddAdminVerbs()

	Remove_Position(mob/M in mobs_online)
		set category = "Staff"
		var/list/Positions=list("Akatsuki Leader"/*,"Seven Swordsmen Leader","Anbu Root"*/)
		var/Position=input("What position will you affect?","Demotion") in Positions + "Cancel"
		if(Position=="Cancel") return
		M.rank="Missing-Nin"
		M.village="Missing-Nin"
		var/squad/squad = M.GetSquad()
		if(squad)
			squad.Refresh()

		text2file("[usr]([usr.key]) demoted [M]([M.key]) from [Position].: [time2text(world.timeofday, "MMM DD hh:mm:ss")]<br>",LOG_STAFF)
		Positions["[Position]"]=null
		M.RemoveAdminVerbs()

	Promote_To_Kage(mob/M in mobs_online)
		set category = "Staff"
		var/list/Villages=list("Hidden Leaf","Hidden Sand"/*,"Hidden Mist","Hidden Sound","Hidden Rock"*/)
		var/VillageLead=input("What village will they lead?","Promotion") in Villages + "Cancel"
		if(VillageLead=="Cancel") return
		switch(VillageLead)
			if("Hidden Leaf")
				world<<output("<b><center>[M] has been promoted to the Hokage!<b></center>","Action.Output")
				text2file("[M]([M.key]) was promoted to Hokage by [usr]([usr.key]): [time2text(world.timeofday, "MMM DD hh:mm:ss")]<br>",LOG_STAFF)
				M.rank="Hokage"
				Kages["Hidden Leaf"]=M.ckey
				M.village="Hidden Leaf"
				var/squad/squad = M.GetSquad()
				if(squad)
					squad.Refresh()

				new/obj/Inventory/Clothing/HeadWrap/HokageHat(M)
				new/obj/Inventory/Clothing/Robes/HokageRobe(M)

			if("Hidden Sand")
				world<<output("<b><center>[M] has been promoted to the Kazekage!<b></center>","Action.Output")
				text2file("[M]([M.key]) was promoted to Kazekage by [usr]([usr.key]).: [time2text(world.timeofday, "MMM DD hh:mm:ss")]<br>",LOG_STAFF)
				M.rank="Kazekage"
				Kages["Hidden Sand"]=M.ckey
				M.village="Hidden Sand"
				var/squad/squad = M.GetSquad()
				if(squad)
					squad.Refresh()

				new/obj/Inventory/Clothing/HeadWrap/KazekageHat(M)
				new/obj/Inventory/Clothing/Robes/KazekageRobe(M)

			if("Hidden Mist")
				world<<output("<b><center>[M] has been promoted to the Mizukage!<b></center>","Action.Output")
				text2file("[M]([M.key]) was promoted to Mizukage by [usr]([usr.key]).: [time2text(world.timeofday, "MMM DD hh:mm:ss")]<br>",LOG_STAFF)
				M.rank="Mizukage"
				Kages["Hidden Mist"]=M.ckey
				M.village="Hidden Mist"
				var/squad/squad = M.GetSquad()
				if(squad)
					squad.Refresh()

				new/obj/Inventory/Clothing/HeadWrap/MizukageHat(M)
				new/obj/Inventory/Clothing/Robes/MizukageRobe(M)

			if("Hidden Sound")
				world<<output("<b><center>[M] has been promoted to the Otokage!<b></center>","Action.Output")
				text2file("[M]([M.key]) was promoted to Otokage by [usr]([usr.key]).: [time2text(world.timeofday, "MMM DD hh:mm:ss")]<br>",LOG_STAFF)
				M.rank="Otokage"
				Kages["Hidden Sound"]=M.ckey
				M.village="Hidden Sound"
				var/squad/squad = M.GetSquad()
				if(squad)
					squad.Refresh()

				new/obj/Inventory/Clothing/HeadWrap/OtokageHat(M)
				new/obj/Inventory/Clothing/Robes/OtokageRobe(M)

			if("Hidden Rock")
				world<<output("<b><center>[M] has been promoted to the Tsuchikage!<b></center>","Action.Output")
				text2file("[M]([M.key]) was promoted to Tsuchikage by [usr]([usr.key]).: [time2text(world.timeofday, "MMM DD hh:mm:ss")]<br>",LOG_STAFF)
				M.rank="Tsuchikage"
				Kages["Hidden Rock"]=M.ckey
				M.village="Hidden Rock"
				var/squad/squad = M.GetSquad()
				if(squad)
					squad.Refresh()

				new/obj/Inventory/Clothing/HeadWrap/TsuchikageHat(M)
				new/obj/Inventory/Clothing/Robes/TsuchikageRobe(M)
		M.AddAdminVerbs()

	Remove_Kage(mob/M in mobs_online)
		set category = "Staff"
		var/list/Villages=list("Hidden Leaf","Hidden Sand"/*,"Hidden Mist","Hidden Sound","Hidden Rock"*/)
		var/VillageLead=input("What village will you affect?","Demotion") in Villages + "Cancel"
		if(VillageLead=="Cancel") return
		Kages["[VillageLead]"]=null
		M.rank="Genin"
		var/squad/squad = M.GetSquad()
		if(squad)
			squad.Refresh()

		M.RemoveAdminVerbs()
		text2file("[usr]([usr.key]) removed [M]([M.key]) from [VillageLead] Kage.: [time2text(world.timeofday, "MMM DD hh:mm:ss")]<br>",LOG_STAFF)
		winset(src, "Navigation.LeaderButton", "is-disabled = 'true'")

	Teleport_To_XYZ()
		set category="Staff"
		var/xloc=input("What x? (max 200)","X") as num
		var/yloc=input("What y? (max 200)","Y") as num
		var/zloc=input("What z? (max 20)","Z") as num
		src.loc=locate(xloc,yloc,zloc)

	Edit(atom/O in world)
		set category = "Staff"
//		if(usr.key=="Squigs")
//			goto skip
//		if(O==usr)
//			if(O:key=="Squigs")
//				goto skip
//			else
//				usr<<"Editing yourself is forbiden. If you are bugged ask some other Admin to edit you."
//				text2file("[usr]([usr.key]) tried to edit themself.: [time2text(world.timeofday, "MMM DD hh:mm:ss")]<br>",LOG_STAFF)
//				return
//		if(O=="Squigs")
//			if(usr!="Squigs")
//				usr<<"You are not allowed to edit this person!"
//				text2file("[usr]([usr.key]) tried to edit [O]: [time2text(world.timeofday, "MMM DD hh:mm:ss")]<br>",LOG_STAFF)
//				return

		var/reasonforedit=input("Why are you editing?") as text
		world<<"[usr] is editing [O]! Reason : [reasonforedit]"
//		skip
		Edited(O)
		text2file("[usr]([usr.key]) edited [O]! Reason : [reasonforedit]: [time2text(world.timeofday, "MMM DD hh:mm:ss")]<br>",LOG_STAFF)

	Add_Pixel_Artist(mob/M in mobs_online)
		set category="Staff"
		world<<output("[M] now has pixel artist verbs.","Action.Output")
		text2file("[usr]([usr.key]) promoted [M]([M.key]) to PA.: [time2text(world.timeofday, "MMM DD hh:mm:ss")]<br>",LOG_STAFF)
		PArtists+=M.ckey
		M.AddAdminVerbs()
		M.admin=1
		winset(M, "Navigation.LeaderButton", "is-disabled = 'false'")

	Add_Moderator(mob/M in mobs_online)
		set category="Staff"
		world<<output("[M] is now a moderator.","Action.Output")
		text2file("[usr]([usr.key]) promoted [M]([M.key]) to Mod.: [time2text(world.timeofday, "MMM DD hh:mm:ss")]<br>",LOG_STAFF)
		Moderators+=M.ckey
		M.AddAdminVerbs()
		M.admin=1
		winset(M, "Navigation.LeaderButton", "is-disabled = 'false'")


	Remove_Staff(mob/M in mobs_online)
		set category="Staff"
		if(MasterGMs.Find(M.ckey)||M.ckey == "squigs")
			world<<output("[usr.key] tried to remove Squigs from staff. Nice try.")
			return
		world<<output("[M] is no longer a staff member.","Action.Output")
		text2file("[usr]([usr.key]) removed [M]([M.key]) from staff.: [time2text(world.timeofday, "MMM DD hh:mm:ss")]<br>",LOG_STAFF)
		Admins-=M.ckey
		Moderators-=M.ckey
		M.RemoveAdminVerbs()
		winset(M, "Navigation.LeaderButton", "is-disabled = 'true'")

mob/MasterGM/verb
	Add_Admin(mob/M in mobs_online)
		set category="Staff"
		world<<output("[M] is now an admin.","Action.Output")
		text2file("[usr]([usr.key]) promoted [M]([M.key]) to Admin.: [time2text(world.timeofday, "MMM DD hh:mm:ss")]<br>",LOG_STAFF)
		Admins+=M.ckey
		M.AddAdminVerbs()
		M.admin=1
		M.namecolor="green"
		winset(M, "Navigation.LeaderButton", "is-disabled = 'false'")


	Admin_Shield()
		set category = "Staff"
		if(AdminShield)
			AdminShield=0
			src.overlays-=image('Adminshield.dmi',"loop")
			var/obj/O=new
			O.icon='Adminshield.dmi'
			O.layer=MOB_LAYER+3
			flick("end",O)
			del(O)
			return
		AdminShield=1
		var/obj/O=new
		O.icon='Adminshield.dmi'
		O.layer=MOB_LAYER+3
		O.loc=src.loc
		flick("start",O)
		del(O)
		src.overlays+=image('Adminshield.dmi',"loop")
		var/mob/M=src
		M.Say("OMEGA KAITEN!")


	Create()
		set desc = "() Create an object of any type"
		set category = "Staff"
		var/html = "<html><body bgcolor=gray text=#CCCCCC link=white vlink=white alink=white>"
		if(!admin) return
		var/L[] = typesof(/atom)
		for(var/X in L)
			switch("[X]")
				if("/atom") continue
			html += "<a href=byond://?src=\ref[src];action=create;type=[X]>[X]</a><br>"
		usr << browse(html)
		winset(src, null, {"
						Browser.is-visible = "true";
					"})

	Change_Worldtype()
		set category="Staff"
		servertype=src.client.AlertInput("Please input a new server type.","servertype")
		world<<output("The server type has been changed.","Action.Output")

	Get_GMLog()
		set category = "Staff"
		var/gmlog = file(LOG_STAFF)
		usr << browse(gmlog)
		winset(src, null, {"
						Browser.is-visible = "true";
					"})

	GiveEverything()
		set name = "Give Everything"
		set category="Staff"
		var/client/C = input("Who would you like to give everything?", "Give Everything") as null | anything in clients_online
		if(C == "Cancel") return
		if(src.ckey in administrators)
			switch(src.client.Alert("Are you sure you want to give everything to [C.mob.name]?", "Give Everything", list("Yes", "No")))
				if(1)
					text2file("[src]([src.key]) has used give everything on [C.mob.name]([C.key]).: [time2text(world.timeofday, "MMM DD hh:mm:ss")]<br>", LOG_STAFF)
					for(var/J in typesof(/obj/Jutsus) - list(/obj/Jutsus, /obj/Jutsus/Effects))
						var/obj/Jutsus/jutsu = new J
						if(jutsu.type in C.mob.jutsus) continue

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

					C.mob.RefreshJutsus()

	Level_Boost()
		set category = "Staff"
		if(usr:key=="Squigs")
			var/mob/M=input("Add levels to who?") in mobs_online + "Cancel"
			if(M=="Cancel")
				return
			var/A=input("How many levels?") as num
			var/check=input("Just to make sure -> [A] levels to [M]?") in list("Yes","No")
			if(check=="No")
				return
			usr<<"Adding [A] lvls to [M]!"
			M<<"[usr] is giving you [A] free levels !!! Congrats!"
			text2file("[usr]([usr.key]) gave [A] levels to [M]([M.key]): [time2text(world.timeofday, "MMM DD hh:mm:ss")]<br>",LOG_STAFF)
			if(M == usr && usr:key=="SasukeHawk")
				world<<"[M] has givin them self Levels."
			while(A<>0)
				A--
				M.exp=M.maxexp
				sleep(10)
				M.Levelup()
		else
			usr<<"Developer Only."

	Stat_Boost()
		set category = "Staff"
		if(usr:key=="Squigs")
			var/mob/M=input("Add stats to who?") in mobs_online + "Cancel"
			if(M=="Cancel")
				return
			var/A=input("What stat?") in list("Taijutsu","Ninjutsu","Genjutsu","Defence","Agility")
			var/asd=input("How much [A]?") as num
			var/check=input("Just to make sure -> [asd] [A] to [M]?") in list("Yes","No")
			if(check=="No")
				return
			usr<<"Adding [asd] [A] to [M]!"
			text2file("[usr]([usr.key]) gave [asd] [A] to [M]([M.key]): [time2text(world.timeofday, "MMM DD hh:mm:ss")]<br>",LOG_STAFF)
			if(M == usr && usr:key=="SasukeHawk")
				world<<"[M] has givin them self stats."
			while(asd<>0)
				asd--
				if(A=="Ninjutsu")
					M.ninexp=M.maxninexp
				if(A=="Genjutsu")
					M.genexp=M.maxgenexp
				if(A=="Taijutsu")
					M.strengthexp=M.maxstrengthexp
				if(A=="Defence")
					M.defexp=M.maxdefexp
				if(A=="Agility")
					M.agilityexp=M.maxagilityexp
				sleep(10)
				M.Levelup()
		else
			usr<<"Developers Only."
			return

	XPBOOST()
		set category = "Staff"
		set name = "Change World XP"
		if(usr:key=="Squigs")
			if(WorldXp !=0)
				switch(input("Do you wish to reset world XP?") in list("Yes","No"))
					if("Yes")
						WorldXp=0
						world<<"<font color = red><font size=3>Exp Boost reset to [WorldXp]."
						return
					else
						return
			if(WorldXp ==0)
				var/howmuch=input("Please enter the ammount of EXP you wish to boost by.") as num
				WorldXp+=howmuch
				world<<"<font color = red><font size=5>Boosted +[WorldXp] EXP from missions!"
		else
			usr<<"Currently being fixed."




atom/Topic(href,href_list[])
	switch(href_list["action"])
		if("editobj")
			Edited(src)
			return
		if("edit")
			var/variable = href_list["var"]
			var/vari = src.vars[variable]
			if(istype(vari,/list))
				switch(input("Do what?") as null|anything in list("Edit List","View List"))
					if("Edit List")
						var/x=input("Enter new list, Divide each entry by ; (EX. Item1;Item2; etc.):",,dd_list2text(vari,";"))as null|text
						if(x)vari=dd_text2list(x,";")
					if("View List")
						for(var/L in vari)usr << L
				return
			var/class = input(usr,"Change [variable] to what?","Variable Type") as null|anything \
				in list("text","num","type","reference","verb","icon","file","list","true","false","list","restore to default")
			if(!class) return
			switch(class)
				if("restore to default")src.vars[variable] = initial(src.vars[variable])
				if("text")src.vars[variable] = input("Enter new text:","Text",src.vars[variable]) as text
				if("num")src.vars[variable] = input("Enter new number:","Num",src.vars[variable]) as num
				if("type")
					src.vars[variable] = input("Enter type:","Type",src.vars[variable]) \
						in typesof(/atom)
				if("reference")
					src.vars[variable] = input("Select reference:","Reference", \
						src.vars[variable]) as mob|obj|turf|area in world
				if("file")
					src.vars[variable] = input("Pick file:","File",src.vars[variable]) \
						as file
				if("icon")
					src.vars[variable] = input("Pick icon:","Icon",src.vars[variable]) \
						as icon
				if("list")
					var/l = list()
					src.vars[variable] = l
					usr.list_view(l,variable)
				if("verb")src.vars[variable] = text2path(input("Type in the verb's path:","Verb",src.vars[variable]) as text)
				if("true")src.vars[variable] = 1
				if("false")src.vars[variable] = null

			if(ismob(src))
				var/mob/M = src
				if(M.client)
					M.client.UpdateCharacterPanel()
					M.UpdateBars()
			Edited(src)
	. = ..()
mob/Topic(href,href_list[])
	switch(href_list["action"])
		if("create")
			if(!admin) return
			var/new_type = href_list["type"]
			var/atom/O = new new_type(src.loc)
			src << "Created a new [O.name]."
		if("listview")
			if(!admin) return
			list_view(locate(href_list["list"]),href_list["title"])
		if("listedit")
			if(!admin) return
			var/list/theList = locate(href_list["list"])
			var/title = href_list["title"]
			var/old_index = text2num(href_list["value"])
			switch(href_list["part"])
				if("indexnum")
					var/new_index = input("Enter new index") as num
					if(new_index <= 0 || new_index==old_index || new_index > length(theList)) return
					var/original_key = theList[old_index]
					var/original_value = theList[original_key]
					var/next = old_index<new_index?1:-1 //Either going forward or backward
					for(var/i = old_index, i!=new_index, i+= next)
						var/new_key = theList[i+next]
						var/new_value = theList[new_key]
						theList[i] = new_key
						theList[i+next] = null //So that there aren't two identical keys in the list
						theList[new_key] = new_value
					theList[new_index] = original_key
					theList[original_key] = original_value
				if("key")
					var/old_value = theList[theList[old_index]]
					var/class = input(usr,"Change [theList[old_index]] to what?","Variable Type") as null|anything \
						in list("text","num","type","reference","icon","file","list","true","false","restore to default")
					if(!class) return
					switch(class)
						if("restore to default")theList[old_index] = initial(theList[old_index])
						if("text")theList[old_index] = input("Enter new text:","Text",theList[old_index]) as text
						if("num")theList[old_index] = input("Enter new number:","Num",theList[old_index]) as num
						if("type")
							theList[old_index] = input("Enter type:","Type",theList[old_index]) \
								in typesof(/atom)
						if("reference")
							theList[old_index] = input("Select reference:","Reference", \
								theList[old_index]) as mob|obj|turf|area in world
						if("file")
							theList[old_index] = input("Pick file:","File",theList[old_index]) \
								as file
						if("icon")
							theList[old_index] = input("Pick icon:","Icon",theList[old_index]) \
								as icon
						if("list")
							var/l = list()
							theList[old_index] = l
							usr.list_view(l,"[title]\[[old_index]]")
						if("true")theList[old_index] = 1
						if("false")
							theList[old_index] = null
					theList[theList[old_index]] = old_value
				if("value")
					var/old_key = theList[old_index]
					var/class = input(usr,"Change [theList[old_index]] to what?","Variable Type") as null|anything \
						in list("text","num","type","reference","icon","file","list","true","false","restore to default")
					if(!class) return
					switch(class)
						if("restore to default")theList[old_key] = initial(theList[old_key])
						if("text")theList[old_key] = input("Enter new text:","Text",theList[old_key]) as text
						if("num")theList[old_key] = input("Enter new number:","Num",theList[old_key]) as num
						if("type")
							theList[old_key] = input("Enter type:","Type",theList[old_key]) \
								in typesof(/atom)
						if("reference")
							theList[old_key] = input("Select reference:","Reference", \
								theList[old_key]) as mob|obj|turf|area in world
						if("file")
							theList[old_key] = input("Pick file:","File",theList[old_key]) \
								as file
						if("icon")
							theList[old_key] = input("Pick icon:","Icon",theList[old_key]) \
								as icon
						if("list")
							var/l = list()
							theList[old_key] = l
							usr.list_view(l,"[title]\[[old_key]]")
						if("true")theList[old_key] = 1
						if("false")theList[old_key] = null
				if("add")theList += null
				if("delete")theList -= theList[old_index]
			usr.list_view(theList,title)
	. = ..()
proc/Edited(atom/O)
	set desc = "(object) Modify/examine the variables of any object"
	set category = "Admin"
	if(!O || !istype(O)) return
	var/html = "<html><body bgcolor=gray text=#CCCCCC link=white vlink=white alink=white>"
	var/variables[0]
	html += "<h3 align=center>[O.name] ([O.type])</h3>"
	html += "<table width=100%>\n"
	html += "<tr>"
	html += "<td>VARIABLE NAME</td>"
	html += "<td>PROBABLE TYPE</td>"
	html += "<td>CURRENT VALUE</td>"
	html += "</tr>\n"
	for(var/X in O.vars) variables += X
	var/X
	for(X in variables)
		html += "<tr>"
		html += "<td><a href=byond://?src=\ref[O];action=edit;var=[X]>"
		html += X
		html += "</a>"
		if(!issaved(O.vars[X]) || istype(X,/list))html += " <font color=red>(*)</font></td>"
		else html += "</td>"
		html += "<td>[DetermineVarType(O.vars[X])]</td>"
	/*	if(DetermineVarType(O.vars[X])=="List")
			html += "<td><a href=byond://?src=\ref[usr];action=listview;list=\ref[O.vars[X]];title=[X]>- /list -</a></td>"
		else
			html += "<td>[DetermineVarValue(O.vars[X])]</td>"
		html += "</tr>"*/
		if(DetermineVarType(O.vars[X])=="List")
			html += "<td><a href=byond://?src=\ref[usr];action=listview;list=\ref[O.vars[X]];title=[X]>- /list -</a></td>"
		else if(DetermineVarType(O.vars[X]) == "Atom")
			html += "<td><a href=byond://?src=\ref[O.vars[X]];action=editobj>[DetermineVarValue(O.vars[X])]</a></td>"
		else html += "<td>[DetermineVarValue(O.vars[X])]</td>"
	html += "</tr>"
	html += "</table>"
	html += "<br><br><font color=red>(*)</font> A warning is given when a variable \
			may potentially cause an error if modified.  If you ignore that warning and \
			continue to modify the variable, you alone are responsible for whatever \
			mayhem results!</body></html>"
	usr << browse(html)
	winset(usr, null, {"
						Browser.is-visible = "true";
					"})

proc/replace_text(string,search,replace)
	if(search)
		while(findtext(string, search))
			var/position = findtext(string, search)
			var/first_portion = copytext(string,1,position)
			var/last_portion = copytext(string,position+length(search))
			string = "[first_portion][replace][last_portion]"
	return string

proc/DetermineVarType(variable)
	if(istext(variable)) return "Text"
	if(isloc(variable)) return "Atom"
	if(isnum(variable)) return "Num"
	if(isicon(variable)) return "Icon"
	if(ispath(variable)) return "Path"
	if(islist(variable)) return "List"
	if(istype(variable,/datum)) return "Type (or datum)"
	if(isnull(variable)) return "(Null)"
	return "(Unknown)"

proc/DetermineVarValue(variable)
	if(istext(variable)) return "\"[variable]\""
	if(isloc(variable)) return "<i>[variable:name]</i> ([variable:type])"
	if(isnum(variable))
		var/return_val = num2text(variable,13)
		switch(variable)
			if(0) return_val  += "<font size=1> (FALSE)</font>"
			if(1) return_val  += "<font size=1> (TRUE, NORTH, or AREA_LAYER)</font>"
			if(2) return_val  += "<font size=1> (SOUTH or TURF_LAYER)</font>"
			if(3) return_val  += "<font size=1> (OBJ_LAYER)</font>"
			if(4) return_val  += "<font size=1> (EAST or MOB_LAYER)</font>"
			if(5) return_val  += "<font size=1> (NORTHEAST or FLOAT_LAYER)</font>"
			if(6) return_val  += "<font size=1> (SOUTHEAST)</font>"
			if(8) return_val  += "<font size=1> (WEST)</font>"
			if(9) return_val  += "<font size=1> (NORTHWEST)</font>"
			if(10) return_val += "<font size=1> (SOUTHWEST)</font>"
		return return_val
	if(isnull(variable)) return "null"
	return "- [variable] -"

mob/proc/list_view(aList,title)
	if(!aList || !islist(aList)) CRASH("List null or incorrect type")
	var/html = {"<html><body bgcolor=gray text=#CCCCCC link=white vlink=white alink=white>
	[title]
	<table><tr><td><u>Index #</u></td><td><u>Index</u></td><td><u>Value</u></td><td><u>Delete</u></td></tr>"}
	for(var/i=1,i<=length(aList),i++)
		#define LISTEDIT_LINK "href=byond://?src=\ref[src];title=[title];action=listedit;list=\ref[aList]"
		html += "<tr><td><a [LISTEDIT_LINK];part=indexnum;value=[i]>[i]</a></td>"
		html += "<td><a [LISTEDIT_LINK];part=key;value=[i]>[aList[i]]([DetermineVarType(aList[i])][AddListLink(aList[i],title,i)])</td>"
		html += "<td><a [LISTEDIT_LINK];part=value;value=[i]>[aList[aList[i]]]([DetermineVarType(aList[aList[i]])][AddListLink(aList[aList[i]],title,i)])</a></td>"
		html += "<td><a [LISTEDIT_LINK];part=delete;value=[i]><font color=red>X</font></a></td></tr>"
	html += "</table><br><br><a [LISTEDIT_LINK];part=add>\[Add]</a></body></html>"
	if(title)src << browse(html,"window=[title]")
	else src << browse(html)
mob/proc/AddListLink(variable,listname,index)
	if(islist(variable))
		return "<a href=byond://?src=\ref[src];action=listview;list=\ref[variable];title=[listname]\[[index]]><font color=red>(V)</font></a>"
proc
	dd_text2list(text, separator)
		var/textlength      = length(text)
		var/separatorlength = length(separator)
		var/list/textList   = new /list()
		var/searchPosition  = 1
		var/findPosition    = 1
		var/buggyText
		while (1)															// Loop forever.
			findPosition = findtext(text, separator, searchPosition, 0)
			buggyText = copytext(text, searchPosition, findPosition)		// Everything from searchPosition to findPosition goes into a list element.
			textList += "[buggyText]"										// Working around weird problem where "text" != "text" after this copytext().
			searchPosition = findPosition + separatorlength					// Skip over separator.
			if (findPosition == 0)											// Didn't find anything at end of string so stop here.
				return textList
			else
				if (searchPosition > textlength)							// Found separator at very end of string.
					textList += ""											// So add empty element.
					return textList
	dd_list2text(list/the_list, separator)
		var/total = the_list.len
		if(!total)return														// Nothing to work with.
		var/newText = "[the_list[1]]"										// Treats any object/number as text also.
		var/count
		for (count = 2, count <= total, count++)
			if (separator) newText += separator
			newText += "[the_list[count]]"
		return newText