
var/HostKey = file(CFG_HOST)

mob/var/
	jailed=0

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
		usr<<"Taijutsu:[M.taijutsu]"
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

	Start_Chuunin_Exam()
		set category="Staff"
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
				M.loc = pick(block(locate(73,10,8),locate(198,74,8)))
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
			if(M.key && !M.exp_locked)
				M.exp_locked = 1
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
		if(length(c) <= 750)
			for(var/mob/M in mobs_online)
				if(administrators.Find(M.ckey) || moderators.Find(M.ckey))
					M << "<font color=yellow>\[Staff] [src.character]:</font> <font color='[COLOR_CHAT]'>[html_encode(c)]</font>"
			text2file("<font color='[COLOR_CHAT]'>[time2text(world.realtime , "(YYYY-MM-DD hh:mm:ss)")]</font> <font color=yellow> \[Staff] [src.character]:</font> <font color='[COLOR_CHAT]'>[html_encode(c)]</font><br />", LOG_CHAT_STAFF)
		else
			src << "Please do not use more than 750 characters."
			src << "Message was <i>[c]</i>"
			return

	Boot(mob/M in mobs_online)
		set category="Staff"
		if(administrators.Find(M.ckey))
			for(var/mob/m in mobs_online)
				if(administrators.Find(m.client.ckey))
					m << "[src] ([src.ckey]) tried to boot an administrator [M] ([M.ckey])."

			text2file("[src] ([src.ckey]) tried to boot an administrator [M] ([M.ckey]).: [time2text(world.realtime , "(YYYY-MM-DD hh:mm:ss)")]<br>", LOG_STAFF)
		else
			M.Save()
			del(M.client)
			world<<"[src] has booted [M] from the game."
			text2file("[src] ([src.ckey]) booted [M] ([M.ckey]).: [time2text(world.realtime , "(YYYY-MM-DD hh:mm:ss)")]<br>",LOG_STAFF)

	Mute(mob/M in mobs_online)
		set category="Staff"
		set name = "Mute/Unmute"
		if(administrators.Find(M.ckey))
			world<<"[usr] tried to mute [M]..."
			text2file("[usr]([src.key]) tried to mute [M]([M.key]): [time2text(world.realtime , "(YYYY-MM-DD hh:mm:ss)")]<br>",LOG_STAFF)
			return
		if(!M.Muted)
			var/howlong=input("How long for? (Minutes)","Mute") as num
			world<<"[M] has been muted by [src] for [howlong] minutes."
			text2file("[M]([M.key]) was muted by [src]([src.key]) for [howlong]min.: [time2text(world.realtime , "(YYYY-MM-DD hh:mm:ss)")]<br>",LOG_STAFF)
			howlong*=600
			M.Muted=1
			M.MuteTime=howlong
			M.Muted()
		else
			M.Muted=1
			M.MuteTime=1
			M.Muted()

	Jail(var/mob/M in mobs_online)
		set category = "Staff"
		spawn(1)
			M.loc=locate(172,189,7)
			M.xplock=1
			M.jailed=1
			var/timer = input("How many minutes should they be jailed?") as num
			var/Offence = input(" What are you jailing [M] for?")as text
			world<<"[M] has been jailed for [timer] Minutes! Reason:[Offence]"
			text2file("[usr]([src.key]) jailed [M]([M.key]) for [timer]min for [Offence].: [time2text(world.realtime , "(YYYY-MM-DD hh:mm:ss)")]<br>",LOG_STAFF)
			spawn(timer*600)
				if(M.jailed)
					M.xplock=0
					M.jailed=0
					world<<"[M] has been Un-jailed!"
					M.loc=MapLoadSpawn()
				else return


mob/var/xplock=0
mob/var/tmp/AdminShield
mob/var/watching=0
mob/Admin/verb
	Announce(t as text)
		set category = "Staff"
		if(!t) return
		world<<"<center><b>---------------------------------</b></center>"
		world<<"<center><b>Announcement from [src]</b><br><br>[t]</b></font></center></p></br></b></center>"
		world<<"<center><b>---------------------------------</b></center>"
		text2file("[src]([src.key]) announced [t].: [time2text(world.realtime , "(YYYY-MM-DD hh:mm:ss)")]<br>",LOG_STAFF)

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

	Promote_to_Position(mob/M in mobs_online)
		set category = "Staff"
		var/list/Positions=list("Akatsuki Leader"/*,"Seven Swordsmen Leader","Anbu Leader"*/)
		var/Position=input("What position will you give them?","Promotion") in Positions + "Cancel"
		if(Position=="Cancel") return
		switch(Position)
			if("Akatsuki Leader")
				M<<"You now lead the Akatsuki."
				text2file("[M]([M.key]) was promoted to Akat by [usr]([usr.key]).: [time2text(world.realtime , "(YYYY-MM-DD hh:mm:ss)")]<br>",LOG_STAFF)
				new/obj/Inventory/Clothing/Robes/Akatsuki_Robe(M)
				//new/obj/Inventory/Weaponry/MadaraFan(M) // Fan is bug-able and is also OP.
				new/obj/Inventory/Clothing/HeadWrap/TobiMask(M)
				new/obj/Inventory/Clothing/HeadWrap/AkatsukiHat(M)
				M.village="Akatsuki"

			if("Seven Swordsmen Leader")
				M<<"You now lead the Seven Swordsmen."
				text2file("[M]([M.key]) was promoted to 7sm lead by [usr]([usr.key]).: [time2text(world.realtime , "(YYYY-MM-DD hh:mm:ss)")]<br>",LOG_STAFF)
				new/obj/Inventory/Weaponry/Hiramekarei(M)
				M.village="Seven Swordsmen"

			if("Anbu Leader")
				M<<"You now lead the Anbu Root."
				text2file("[M]([M.key]) was promoted to Anbu by [usr]([usr.key]).: [time2text(world.realtime , "(YYYY-MM-DD hh:mm:ss)")]<br>",LOG_STAFF)
				new/obj/Inventory/Clothing/Robes/Anbu_Suit(M)
				new/obj/Inventory/Clothing/Masks/Absolute_Zero_Mask(M)
				M.village="Anbu Root"

		M.rank="[Position]"
		var/squad/squad = M.GetSquad()
		if(squad)
			squad.Refresh()

		M.client.StaffCheck()

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

		text2file("[usr]([usr.key]) demoted [M]([M.key]) from [Position].: [time2text(world.realtime , "(YYYY-MM-DD hh:mm:ss)")]<br>",LOG_STAFF)
		Positions["[Position]"]=null
		M.client.StaffCheck()

	Edit(atom/O in world)
		set category = "Staff"
		Edited(O)
		text2file("[usr]([usr.key]) edited [O]! [time2text(world.realtime , "(YYYY-MM-DD hh:mm:ss)")]<br>",LOG_STAFF)

	Add_Pixel_Artist(mob/M in mobs_online)
		set category="Staff"
		world<<output("[M] now has pixel artist verbs.","Action.Output")
		text2file("[usr]([usr.key]) promoted [M]([M.key]) to PA.: [time2text(world.realtime , "(YYYY-MM-DD hh:mm:ss)")]<br>",LOG_STAFF)
		pixel_artists.Add(M.ckey)
		M.client.StaffCheck()
		winset(M, "Navigation.LeaderButton", "is-disabled = 'false'")

	Add_Moderator(mob/M in mobs_online)
		set category="Staff"
		world<<output("[M] is now a moderator.","Action.Output")
		text2file("[usr]([usr.key]) promoted [M]([M.key]) to Mod.: [time2text(world.realtime , "(YYYY-MM-DD hh:mm:ss)")]<br>",LOG_STAFF)
		moderators.Add(M.ckey)
		M.client.StaffCheck()
		winset(M, "Navigation.LeaderButton", "is-disabled = 'false'")


	Remove_Staff(mob/M in mobs_online)
		set category="Staff"
		if(administrators.Find(M.ckey))
			world<<output("[src] ([src.ckey]) tried to remove [M] from staff. Nice try.")
			return
		world<<output("[M] is no longer a staff member.","Action.Output")
		text2file("[usr]([usr.key]) removed [M]([M.key]) from staff.: [time2text(world.realtime , "(YYYY-MM-DD hh:mm:ss)")]<br>",LOG_STAFF)
		administrators.Remove(M.ckey)
		moderators.Remove(M.ckey)
		programmers.Remove(M.ckey)
		pixel_artists.Remove(M.ckey)
		M.client.StaffCheck()
		winset(M, "Navigation.LeaderButton", "is-disabled = 'true'")

mob/MasterGM/verb

	AdminTele()
		set category = "Staff"
		set name = "Enter Admin Hideout"
		usr.loc = locate(152,162,9)

	Reboot()
		set category="Staff"
		world<<output("World is rebooting.","Action.Output")
		text2file("[usr]([src.key]) rebooted.: [time2text(world.realtime , "(YYYY-MM-DD hh:mm:ss)")]<br>",LOG_STAFF)
		world.Reboot()

	Summon(mob/M in mobs_online)
		set category="Staff"
		src.overlays+=image('Smoke.dmi',"smoke")
		M.loc=src.loc
		sleep(13)
		src.overlays-=image('Smoke.dmi',"smoke")

	Delete(atom/O in world)
		set category="Staff"
		if(!administrators.Find(src.ckey)) return
		if(ismob(O))
			var/mob/M=O
			if(!M.client) del(M)
			if(M)
				if(alert("Are you sure you want to delete the Atom [O.name]?","Confirm!","No","Yes")=="Yes")
					text2file("[usr] deleted [O.name]: [time2text(world.realtime , "(YYYY-MM-DD hh:mm:ss)")]<br>",LOG_STAFF)
					del(M)
		else del(O)

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
		if(!src.client.ckey in administrators) return
		var/L[] = typesof(/atom)
		for(var/X in L)
			switch("[X]")
				if("/atom") continue
			html += "<a href=byond://?src=\ref[src];action=create;type=[X]>[X]</a><br>"
		usr << browse(html)
		winset(src, null, {"
						Browser.is-visible = "true";
					"})

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
					spawn() M.UpdateHMB()
			Edited(src)
	. = ..()
mob/Topic(href,href_list[])
	switch(href_list["action"])
		if("create")
			if(!src.client.ckey in administrators) return
			var/new_type = href_list["type"]
			var/atom/O = new new_type(src.loc)
			src << "Created a new [O.name]."
		if("listview")
			if(!src.client.ckey in administrators) return
			list_view(locate(href_list["list"]),href_list["title"])
		if("listedit")
			if(!src.client.ckey in administrators) return
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