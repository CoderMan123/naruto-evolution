var/build
var/server_capacity = 100

var/list/administrators = list("douglasparker", "illusiveblair")
var/list/moderators = list("squigs")
var/list/programmers = list("douglasparker")
var/list/pixel_artists = list("illusiveblair")

var/list/kages = list(VILLAGE_LEAF = null, VILLAGE_SAND = null)
var/list/kages_last_online = list(VILLAGE_LEAF = null, VILLAGE_SAND = null)

var/list/alpha_testers = list()
var/list/beta_testers = list()

var/list/clients_connected = list()
var/list/clients_online = list()
var/list/clients_multikeying = list()
var/list/mobs_online = list()
var/list/names_taken = list()
var/list/npcs_online = list()

var/squads[0]

world
	name = "Naruto Evolution"
	hub = "Squigs.NETheNewEra"
	hub_password = "Ue7DTLSxJx1vnALy"
	status = "Naruto Evolution (Connecting...) | Ninjas Online (Connecting...)"
	fps = 20
	view = 16
	loop_checks = 1
	New()
		..()
		CreateLogs()

		log = file(LOG_ERROR)

		build = file2text("VERSION")
		if(!build) text2file("", "VERSION")

		src.Load()

		spawn() UpdateHUB()
		spawn() GeninExam()
		spawn() ChuuninExam()
		spawn() AnimalPopulater()
		spawn() ZetsuEvent()
		spawn() Advert()
		spawn() RepopWorld()
		spawn() AutoCheck()
		spawn() LinkWarps()
		spawn() HTMLlist()
		spawn() Kage_Inactivity_Check()

	Del()
		src.Save()
		..()
	
	Error(exception/ex)
		text2file("<b>Runtime Error:</b> [ex.name]<br /><b>File:</b> [ex.file]<br /><b>Line:</b> [ex.line]<br /><b><u>Description:</u></b><br />[ex.desc]<br /><br />", LOG_ERROR)
	
	proc/UpdateClientsMultikeying()
		clients_multikeying = list()

		for(var/client/source in clients_connected)
			for(var/client/target in clients_connected)
				if(source != target)
					if(source.address == target.address || source.computer_id == target.computer_id)
						clients_multikeying.Add(source)
						clients_multikeying.Add(target)
	
	proc/Kage_Inactivity_Check()
		set background = 1
		while(src)
			var/days = 5
			
			if(kages_last_online[VILLAGE_LEAF] && kages_last_online[VILLAGE_LEAF] + 864000 * days <= world.realtime)
				var/online
				for(var/mob/m in mobs_online)
					if(kages[VILLAGE_LEAF] == m.client.ckey) online = 1

				// Don't demote Kages that are online because kage_last_online[] only updates on mob.Load() and mob.Save().
				// Otherwise, Kages will be demoted if they do not logout to update their kage_last_online[] timestamp.
				if(online)
					world << output("The [RANK_HOKAGE] for the <font color='[COLOR_VILLAGE_LEAF]'>[VILLAGE_LEAF]</font> was forced out of office due to inactivity for [days] days.", "Action.Output")
					text2file("<font color = '[COLOR_CHAT]'>[time2text(world.realtime , "(YYYY-MM-DD hh:mm:ss)")] The [RANK_HOKAGE] for the <font color='[COLOR_VILLAGE_LEAF]'>[VILLAGE_LEAF]</font> ([kages[VILLAGE_LEAF]]) was forced out of office due to inactivity for [days] days.</font><br />", LOG_KAGE)
					kages[VILLAGE_LEAF] = null
					kages_last_online[VILLAGE_LEAF] = null
			
			if(kages_last_online[VILLAGE_SAND] && kages_last_online[VILLAGE_SAND] + 864000 * days <= world.realtime)
				var/online
				for(var/mob/m in mobs_online)
					if(kages[VILLAGE_SAND] == m.client.ckey) online = 1
				
				// Don't demote Kages that are online because kage_last_online[] only updates on mob.Load() and mob.Save().
				// Otherwise, Kages will be demoted if they do not logout to update their kage_last_online[] timestamp.
				if(online)
					world << output("The [RANK_KAZEKAGE] for the <font color='[COLOR_VILLAGE_SAND]'>[VILLAGE_SAND]</font> was forced out of office due to inactivity for [days] days.", "Action.Output")
					text2file("<font color = '[COLOR_CHAT]'>[time2text(world.realtime , "(YYYY-MM-DD hh:mm:ss)")] The [RANK_KAZEKAGE] ([kages[VILLAGE_SAND]]) for the <font color='[COLOR_VILLAGE_SAND]'>[VILLAGE_SAND]</font> was forced out of office due to inactivity for [days] days.</font><br />", LOG_KAGE)
					kages[VILLAGE_SAND] = null
					kages_last_online[VILLAGE_SAND] = null

			sleep(600)

	proc/UpdateHUB()
		set background = 1
		while(world)
			status = "Naruto Evolution v[build] | Ninjas Online ([mobs_online.len]/[server_capacity])"
			sleep(600)
	
	proc/CreateLogs()

		if(!fexists(LOG_ERROR))
			text2file("<body bgcolor = '#414141'><font color = '[COLOR_CHAT]'>", LOG_ERROR)
		
		if(!fexists(LOG_BUGS))
			text2file("<body bgcolor = '#414141'><font color = '[COLOR_CHAT]'>", LOG_BUGS)
		
		if(!fexists(LOG_SAVES))
			text2file("<body bgcolor = '#414141'><font color = '[COLOR_CHAT]'>", LOG_SAVES)
		
		if(!fexists(LOG_CLIENT_SAVES))
			text2file("<body bgcolor = '#414141'><font color = '[COLOR_CHAT]'>", LOG_CLIENT_SAVES)
		
		if(!fexists(LOG_KILLS))
			text2file("<body bgcolor = '#414141'><font color = '[COLOR_CHAT]'>", LOG_KILLS)
		
		if(!fexists(LOG_STAFF))
			text2file("<body bgcolor = '#414141'><font color = '[COLOR_CHAT]'>", LOG_STAFF)
		
		if(!fexists(LOG_ADMINISTRATOR))
			text2file("<body bgcolor = '#414141'><font color = '[COLOR_CHAT]'>", LOG_ADMINISTRATOR)
		
		if(!fexists(LOG_MODERATOR))
			text2file("<body bgcolor = '#414141'><font color = '[COLOR_CHAT]'>", LOG_MODERATOR)
		
		if(!fexists(LOG_KAGE))
			text2file("<body bgcolor = '#414141'><font color = '[COLOR_CHAT]'>", LOG_KAGE)
		
		if(!fexists(LOG_CHAT_LOCAL))
			text2file("<body bgcolor = '#414141'>", LOG_CHAT_LOCAL)
		
		if(!fexists(LOG_CHAT_VILLAGE))
			text2file("<body bgcolor = '#414141'>", LOG_CHAT_VILLAGE)
		
		if(!fexists(LOG_CHAT_SQUAD))
			text2file("<body bgcolor = '#414141'>", LOG_CHAT_SQUAD)
		
		if(!fexists(LOG_CHAT_FACTION))
			text2file("<body bgcolor = '#414141'>", LOG_CHAT_FACTION)
		
		if(!fexists(LOG_CHAT_GLOBAL))
			text2file("<body bgcolor = '#414141'>", LOG_CHAT_GLOBAL)
		
		if(!fexists(LOG_CHAT_WHISPER))
			text2file("<body bgcolor = '#414141'>", LOG_CHAT_WHISPER)
		
		if(!fexists(LOG_KAGE))
			text2file("<body bgcolor = '#414141'>", LOG_KAGE)

	proc/Save()
		var/savefile/F = new(SAVEFILE_STAFF)
		F["administrators"] << administrators
		F["moderators"] << moderators
		F["programmers"] << programmers
		F["pixel_artists"] << pixel_artists

		F = new(SAVEFILE_NAMES)
		F["names_taken"] << names_taken

		F = new(SAVEFILE_KAGES)
		F["kages"] << kages
		F["kages_last_online"] << kages_last_online

		F = new(SAVEFILE_SQUADS)
		F["squads"] << squads

		F = new(SAVEFILE_WORLD)
		Factionnames = new/list()
		for(var/Faction/c in Factions)
			if(!c.name) continue
			var/path = "Factions/[c.name].sav"
			var/savefile/G = new(path)
			G << c
			Factionnames += c.name
		if(maps.len) F["Maps"] << maps
		F["Factions"] << Factionnames
		F["AkatInvites"] << AkatInvites
		F["WorldXp"] << WorldXp

	proc/Load()
		var/savefile/F = new(SAVEFILE_STAFF)
		if(!isnull(F["administrators"])) F["administrators"] >> administrators
		if(!isnull(F["moderators"])) F["moderators"] >> moderators
		if(!isnull(F["programmers"])) F["programmers"] >> programmers
		if(!isnull(F["pixel_artists"])) F["pixel_artists"] >> pixel_artists

		for(var/ckey in initial(administrators))
			if(!ckey in administrators) administrators += ckey

		for(var/ckey in initial(moderators))
			if(!ckey in moderators) moderators += ckey

		for(var/ckey in initial(programmers))
			if(!ckey in programmers) programmers += ckey

		for(var/ckey in initial(pixel_artists))
			if(!ckey in pixel_artists) pixel_artists += ckey

		if(!fexists(CFG_ADMIN))
			for(var/ckey in administrators) text2file("[ckey] role=root", CFG_ADMIN)
		if(!fexists(CFG_HOST)) text2file("",CFG_HOST)

		F = new(SAVEFILE_NAMES)
		if(F["names_taken"]) F["names_taken"] >> names_taken

		F = new(SAVEFILE_SQUADS)
		if(F["squads"]) F["squads"] >> squads

		F = new(SAVEFILE_KAGES)
		if(F["kages"]) F["kages"] >> kages
		if(F["kages_last_online"]) F["kages_last_online"] >> kages_last_online

		F = new(SAVEFILE_WORLD)
		if(!isnull(F["Factions"])) F["Factions"] >> Factionnames
		if(!isnull(F["Maps"])) F["Maps"] >> maps
		if(!isnull(F["AkatInvites"])) F["AkatInvites"] >> AkatInvites
		if(!isnull(F["WorldXp"])) F["WorldXp"] >> WorldXp

		for(var/c in Factionnames)
			var/path = "Factions/[c].sav"
			var/savefile/G = new(path)
			if(!fexists(path))
				Factionnames -= c
				continue
			var/Faction/Faction
			G >> Faction
			Factions += Faction

	proc/GetAdvert()
		return "<center><b><font color='#dd5800'>[world.name]</font> v[build] | <font color='#dd5800'>Ninjas Online</font> ([mobs_online.len]/[server_capacity])<br />\[<a href='http://www.byond.com/games/Squigs/NETheNewEra/'>Hub</a>] \[<a href='https://community.narutoevolution.com/'>Forums</a>] \[<a href='https://wiki.narutoevolution.com/'>Wiki</a>] \[<a href='https://discord.gg/URcN6cc\'>Discord</a>]<br />\[<a href='https://github.com/IllusiveBIair/Naruto-Evolution-Community/issues/new?assignees=&labels=Type%3A+Feature+Request&template=feature-request.md&title='>Feature Requests</a>] \[<a href='https://github.com/IllusiveBIair/Naruto-Evolution-Community/issues/new?assignees=&labels=Type%3A+Bug&template=bug-report.md&title='>Bug Reports</a>]</b></center>"

	proc/Advert()
		set background = 1
		while(world)
			world << src.GetAdvert()
			sleep(600*30)