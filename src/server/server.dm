var/build
var/server_capacity = 100

var/list/administrators = list("lavenblade", "illusiveblair")
var/list/moderators = list()
var/list/programmers = list("lavenblade")
var/list/pixel_artists = list("illusiveblair")

var/list/clients_connected = list()
var/list/clients_online = list()
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
		log = file(LOG_ERROR)

		build = file2text("VERSION")
		if(!build) text2file("", "VERSION")
		src.Load()

		spawn() UpdateHUB()
		spawn() GeninExam()
		spawn() ChuuninExam()
		spawn() Advert()
		spawn() RepopWorld()
		spawn() AutoCheck()
		spawn() LinkWarps()
		spawn() HTMLlist()
		
	Del()
		src.Save()
		..()
	
	proc/UpdateHUB()
		set background = 1
		while(world)
			status = "Naruto Evolution v[build] | Ninjas Online ([mobs_online.len]/[server_capacity])"
			sleep(600)

	proc/Save()
		var/savefile/F = new(SAVEFILE_STAFF)
		F["administrators"] << administrators
		F["moderators"] << moderators
		F["programmers"] << programmers
		F["pixel_artists"] << pixel_artists

		F = new(SAVEFILE_NAMES)
		F["names_taken"] << names_taken

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
		return "<center><b><font color='#dd5800'>[world.name]</font> v[build] | <font color='#dd5800'>Ninjas Online</font> ([mobs_online.len]/[server_capacity])<br />\[<a href='http://www.byond.com/games/Squigs/NETheNewEra/'>Hub</a>] \[<a href='https://discord.gg/URcN6cc\'>Discord</a>] \[<a href='https://github.com/lavenblade/naruto-evolution-community/issues/new?assignees=&labels=Type%3A+Feature+Request&template=feature-request.md&title='>Feature Requests</a>] \[<a href='https://github.com/lavenblade/naruto-evolution-community/issues/new?assignees=&labels=Type%3A+Bug&template=bug-report.md&title='>Bug Reports</a>]</b></center>"
	
	proc/Advert()
		set background = 1
		while(world)
			world << src.GetAdvert()
			sleep(600*30)