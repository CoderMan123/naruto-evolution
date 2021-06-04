var/version
var/server_capacity = 100

var/list/administrators = list("lavenblade", "illusiveblair")
var/list/moderators = list()
var/list/programmers = list("lavenblade")
var/list/pixel_artists = list("illusiveblair")

var/list/clients_connected = list()
var/list/clients_online = list()
var/list/mobs_online = list()
var/list/names_taken = list()

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
		log = file(LOG_ERROR)

		version = file2text("VERSION")
		if(!version) text2file("", "VERSION")

		spawn(10) GeninExam()
		spawn(10) ChuuninExam()
		spawn(10) Advert()
		spawn(10) RepopWorld()
		spawn(10) AutoCheck()
		spawn(5) LinkWarps()
		spawn(5) UpdateHUB()
		spawn(5) HTMLlist()

		src.Load()
		..()

	Del()
		src.Save()
		..()
	
	proc/UpdateHUB()
		set background = 1
		while(world)
			sleep(600)
			status="Naruto Evolution v[version] | Ninjas Online ([mobs_online.len]/[server_capacity])"

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