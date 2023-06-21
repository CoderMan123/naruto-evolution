var/build
var/pre_release = 0
var/server_capacity = 100

var/list/administrators = list("illusiveblair")
var/list/moderators = list()
var/list/programmers = list("illusiveblair")
var/list/pixel_artists = list("illusiveblair")

var/list/hokage = list()
var/list/kazekage = list()
var/list/kages_last_online = list(VILLAGE_LEAF = null, VILLAGE_SAND = null)

var/list/akatsuki_leader = list()
var/list/akatsuki_members = list()
var/akatsuki_last_online

var/list/alpha_testers = list()
var/list/beta_testers = list()

var/list/clients_connected = list()
var/list/clients_online = list()
var/list/clients_multikeying = list()
var/list/mobs_online = list()
var/list/names_taken = list()
var/list/npcs_online = list()

var/leaf_online = 0
var/sand_online = 0
var/missing_nin_online = 0
var/akatsuki_online = 0

var/squads[0]



world
	name = "Naruto Evolution"
	hub = "ProjectNE.NarutoEvolution"
	hub_password = ""
	status = "Naruto Evolution (Connecting...) | Ninjas Online (Connecting...)"
	fps = 20
	view = 16
	loop_checks = 1
	New()
		log_db = new(DATABASE_LOGS)
		DbMigrations()
		..()

		spawn()
			var/database/query/query = new({"
				INSERT INTO `[db_table_server_startup]` (`timestamp`, `action`)
				VALUES(?, ?)"},
				time2text(world.realtime, "YYYY-MM-DD hh:mm:ss"), "start"
			)
			query.Execute(log_db)
			LogErrorDb(query)

		build = file2text("VERSION")
		if(!build) text2file("0.0.0", "VERSION")

		if(file2text("PRERELEASE")) pre_release = 1

		src.Load()

		spawn() UpdateHUB()
		spawn() GeninExam()
		spawn() ChuuninExam()
		spawn() AnimalPopulater()
		spawn() ZetsuEvent()
		spawn() Advert()
		spawn() RepopWorld()
		spawn() AutomaticExperienceLock()
		spawn() LinkWarps()
		spawn() HTMLlist()
		spawn() Kage_Inactivity_Check()
		spawn() Akatsuki_Inactivity_Check()
		spawn() Hotspring_Loop()
		spawn() Election()
		spawn() InfamyLoop()
		spawn() Maintenance()
		spawn() AutoSave()

	Del()
		src.FailMissions()
		src.Save()

		spawn()
			var/database/query/query = new({"
				INSERT INTO `[db_table_server_startup]` (`timestamp`, `action`)
				VALUES(?, ?)"},
				time2text(world.realtime, "YYYY-MM-DD hh:mm:ss"), "shutdown"
			)
			query.Execute(log_db)
			LogErrorDb(query)

		log_db.Close()

		..()

	Error(exception/ex)
		var/database/query/query = new("INSERT INTO `[db_table_error]` (`timestamp`, `error`, `description`, `file`, `line`) VALUES(?, ?, ?, ?, ?)", time2text(world.realtime, "YYYY-MM-DD hh:mm:ss"), ex.name, ex.desc, ex.file, ex.line)
		query.Execute(log_db)
		LogErrorDb(query)
	
	proc/AutoSave()
		set background = 1
		while(src)
			world.Save()

			for(var/mob/m in mobs_online)
				if(m) m.Save()
				sleep(world.tick_lag)

			sleep(600 * 5)

	proc/UpdateVillageCount()
		leaf_online = 0
		sand_online = 0
		missing_nin_online = 0
		akatsuki_online = 0

		for(var/mob/m in mobs_online)
			if(m.village == VILLAGE_LEAF) leaf_online++
			if(m.village == VILLAGE_SAND) sand_online++
			if(m.village == VILLAGE_MISSING_NIN) missing_nin_online++
			if(m.village == VILLAGE_AKATSUKI) akatsuki_online++

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
			var/days = 3

			if(kages_last_online[VILLAGE_LEAF] && kages_last_online[VILLAGE_LEAF] + 864000 * days <= world.realtime)
				var/online
				for(var/mob/m in mobs_online)
					if(hokage[m.client.ckey] == m.character) online = 1

				// Don't demote Kages that are online because kage_last_online[] only updates on mob.Load() and mob.Save().
				// Otherwise, Kages will be demoted if they do not logout to update their kage_last_online[] timestamp.
				if(!online)
					world << output("The [RANK_HOKAGE] for the <font color='[COLOR_VILLAGE_LEAF]'>[VILLAGE_LEAF]</font> was forced out of office due to inactivity for [days] days.", "Action.Output")

					spawn()
						var/database/query/query = new({"
							INSERT INTO `[db_table_character_prestige]` (`timestamp`, `key`, `character`, `village`, `log`)
							VALUES(?, ?, ?, ?, ?)"},
							time2text(world.realtime, "YYYY-MM-DD hh:mm:ss"), global.GetHokage(), global.GetHokage(RETURN_FORMAT_CHARACTER), VILLAGE_LEAF, "The [RANK_HOKAGE] ([global.GetHokage()]) for the [VILLAGE_LEAF] was forced out of office due to inactivity for [days] days."
						)
						query.Execute(log_db)
						LogErrorDb(query)
					
					hokage = list()
					kages_last_online[VILLAGE_LEAF] = null

			if(kages_last_online[VILLAGE_SAND] && kages_last_online[VILLAGE_SAND] + 864000 * days <= world.realtime)
				var/online
				for(var/mob/m in mobs_online)
					if(kazekage[m.client.ckey] == m.character) online = 1

				// Don't demote Kages that are online because kage_last_online[] only updates on mob.Load() and mob.Save().
				// Otherwise, Kages will be demoted if they do not logout to update their kage_last_online[] timestamp.
				if(!online)
					world << output("The [RANK_KAZEKAGE] for the <font color='[COLOR_VILLAGE_SAND]'>[VILLAGE_SAND]</font> was forced out of office due to inactivity for [days] days.", "Action.Output")
					
					spawn()
						var/database/query/query = new({"
							INSERT INTO `[db_table_character_prestige]` (`timestamp`, `key`, `character`, `village`, `log`)
							VALUES(?, ?, ?, ?, ?)"},
							time2text(world.realtime, "YYYY-MM-DD hh:mm:ss"), global.GetKazekage(), global.GetKazekage(RETURN_FORMAT_CHARACTER), RANK_KAZEKAGE, "The [RANK_KAZEKAGE] ([global.GetKazekage()]) for the [VILLAGE_SAND] was forced out of office due to inactivity for [days] days."
						)
						query.Execute(log_db)
						LogErrorDb(query)

					kazekage = list()
					kages_last_online[VILLAGE_SAND] = null

			sleep(600)

	proc/Akatsuki_Inactivity_Check()
		set background = 1
		while(src)
			var/days = 3

			if(akatsuki_last_online && akatsuki_last_online + 864000 * days <= world.realtime)
				var/online
				for(var/mob/m in mobs_online)
					if(akatsuki_leader[m.client.ckey] == m.character) online = 1

				// Don't demote Akatsuki that are online because akatsuki_last_online only updates on mob.Load() and mob.Save().
				// Otherwise, Akatsuki will be demoted if they do not logout to update their akatsuki_last_online timestamp.
				if(!online)
					world << output("The [RANK_AKATSUKI] for the <font color='[COLOR_VILLAGE_AKATSUKI]'>[VILLAGE_AKATSUKI]</font> was forced out of office due to inactivity for [days] days.", "Action.Output")
					
					spawn()
						var/database/query/query = new({"
							INSERT INTO `[db_table_akatsuki]` (`timestamp`, `key`, `character`, `village`, `log`)
							VALUES(?, ?, ?, ?, ?)"},
							time2text(world.realtime, "YYYY-MM-DD hh:mm:ss"), global.GetAkatsukiLeader(), global.GetAkatsukiLeader(RETURN_FORMAT_CHARACTER), VILLAGE_AKATSUKI, "The [RANK_AKATSUKI] ([global.GetAkatsukiLeader()]) for the [VILLAGE_AKATSUKI] was forced out of office due to inactivity for [days] days."
						)
						query.Execute(log_db)
						LogErrorDb(query)

					akatsuki_leader = list()
					akatsuki_last_online = null

			sleep(600)

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
		F["alpha_testers"] << alpha_testers
		F["beta_testers"] << beta_testers

		F = new(SAVEFILE_NAMES)
		F["names_taken"] << names_taken

		F = new(SAVEFILE_KAGES)
		F["hokage"] << hokage
		F["kazekage"] << kazekage
		F["kages_last_online"] << kages_last_online

		F = new(SAVEFILE_AKATSUKI)
		F["akatsuki"] << akatsuki_leader
		F["akatsuki_last_online"] << akatsuki_last_online
		F["akatsuki_members"] << akatsuki_members

		F = new(SAVEFILE_SQUADS)
		F["squads"] << squads

		F = new(SAVEFILE_ELECTIONS)
		F["hokage_election"] << hokage_election
		F["hokage_ballot_open"] << hokage_ballot_open
		F["hokage_election_ballot"] << hokage_election_ballot
		F["hokage_election_votes"] << hokage_election_votes
		F["kazekage_election"] << kazekage_election
		F["kazekage_ballot_open"] << kazekage_ballot_open
		F["kazekage_election_ballot"] << kazekage_election_ballot
		F["kazekage_election_votes"] << kazekage_election_votes

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
		F["item_id"] << item_id

	proc/Load()
		var/savefile/F = new(SAVEFILE_STAFF)
		if(!isnull(F["administrators"])) F["administrators"] >> administrators
		if(!isnull(F["moderators"])) F["moderators"] >> moderators
		if(!isnull(F["programmers"])) F["programmers"] >> programmers
		if(!isnull(F["pixel_artists"])) F["pixel_artists"] >> pixel_artists
		if(!isnull(F["alpha_testers"])) F["alpha_testers"] >> alpha_testers
		if(!isnull(F["beta_testers"])) F["beta_testers"] >> beta_testers

		for(var/ckey in initial(administrators))
			if(!ckey in administrators) administrators += ckey

		for(var/ckey in initial(moderators))
			if(!ckey in moderators) moderators += ckey

		for(var/ckey in initial(programmers))
			if(!ckey in programmers) programmers += ckey

		for(var/ckey in initial(pixel_artists))
			if(!ckey in pixel_artists) pixel_artists += ckey
		
		for(var/ckey in initial(alpha_testers))
			if(!ckey in alpha_testers) alpha_testers += ckey
		
		for(var/ckey in initial(beta_testers))
			if(!ckey in beta_testers) beta_testers += ckey

		if(!fexists(CFG_ADMIN))
			for(var/ckey in administrators) text2file("[ckey] role=root", CFG_ADMIN)
		if(!fexists(CFG_HOST)) text2file("",CFG_HOST)

		F = new(SAVEFILE_NAMES)
		if(F["names_taken"]) F["names_taken"] >> names_taken

		F = new(SAVEFILE_SQUADS)
		if(F["squads"]) F["squads"] >> squads

		F = new(SAVEFILE_KAGES)
		if(F["hokage"]) F["hokage"] >> hokage
		if(F["kazekage"]) F["kazekage"] >> kazekage
		if(F["kages_last_online"]) F["kages_last_online"] >> kages_last_online

		F = new(SAVEFILE_AKATSUKI)
		if(F["akatsuki"]) F["akatsuki"] >> akatsuki_leader
		if(F["akatsuki_last_online"]) F["akatsuki_last_online"] >> akatsuki_last_online
		if(F["akatsuki_members"]) F["akatsuki_members"] >> akatsuki_members

		F = new(SAVEFILE_ELECTIONS)
		if(F["hokage_election"]) F["hokage_election"] >> hokage_election
		if(F["hokage_ballot_open"]) F["hokage_ballot_open"] >> hokage_ballot_open
		if(F["hokage_election_ballot"]) F["hokage_election_ballot"] >> hokage_election_ballot
		if(F["hokage_election_votes"]) F["hokage_election_votes"] >> hokage_election_votes
		if(F["kazekage_election"]) F["kazekage_election"] >> kazekage_election
		if(F["kazekage_ballot_open"]) F["kazekage_ballot_open"] >> kazekage_ballot_open
		if(F["kazekage_election_ballot"]) F["kazekage_election_ballot"] >> kazekage_election_ballot
		if(F["kazekage_election_votes"]) F["kazekage_election_votes"] >> kazekage_election_votes

		F = new(SAVEFILE_WORLD)
		if(!isnull(F["Factions"])) F["Factions"] >> Factionnames
		if(!isnull(F["Maps"])) F["Maps"] >> maps
		if(!isnull(F["AkatInvites"])) F["AkatInvites"] >> AkatInvites
		if(!isnull(F["WorldXp"])) F["WorldXp"] >> WorldXp
		if(!isnull(F["item_id"])) F["item_id"] >> item_id

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
		return "<center><b><font color='#dd5800'>[world.name]</font> v[build] | <font color='#dd5800'>Ninjas Online</font> ([mobs_online.len]/[server_capacity])<br />\[<a href='https://www.byond.com/games/ProjectNE/NarutoEvolution'>Hub</a>] \[<a href='https://discord.gg/SYF6CdA2Fa'>Discord</a>]<br />\[<a href='https://github.com/Aeiwik/naruto-evolution/issues/new?assignees=&labels=Type%3A+Feature+Request&template=feature-request.md&title='>Feature Requests</a>] \[<a href='https://github.com/Aeiwik/naruto-evolution/issues/new?assignees=&labels=Type%3A+Bug&template=bug-report.md&title='>Bug Reports</a>]</b></center>"
	
	proc/Maintenance()
		while(world)
			switch(time2text(world.timeofday, "hh:mm"))
				if("11:50")
					world << "<center><font color='#BE1A0E'><b><u>The server will be going down for maintenance in 10 minutes.</u></b></font></center>"
				
				if("11:55")
					world << "<center><font color='#BE1A0E'><b><u>The server will be going down for maintenance in 5 minutes.</u></b></font></center>"
				
				if("11:56")
					world << "<center><font color='#BE1A0E'><b><u>The server will be going down for maintenance in 4 minutes.</u></b></font></center>"
				
				if("11:57")
					world << "<center><font color='#BE1A0E'><b><u>The server will be going down for maintenance in 3 minutes.</u></b></font></center>"
				
				if("11:58")
					world << "<center><font color='#BE1A0E'><b><u>The server will be going down for maintenance in 2 minutes.</u></b></font></center>"
				
				if("11:59")
					world << "<center><font color='#BE1A0E'><b><u>The server will be going down for maintenance in 1 minutes.</u></b></font></center>"
				
				if("12:00")
					world << "<center><font color='#BE1A0E'><b><u>The server is now going down for maintenance. The server should be back online in a couple of minutes.</u></b></font></center>"
			
			sleep(600)

	proc/Advert()
		set background = 1
		while(world)
			world << src.GetAdvert()
			sleep(600*30)

	proc/FailMissions()
		for(var/squad/squad in squads)
			if(squad.mission)
				switch(squad.mission.type)
					if(/mission/d_rank/deliver_intel)
						squad.mission.status = "Failure"
						squad.mission.complete = world.realtime

					if(/mission/a_rank/political_escort)
						squad.mission.status = "Failure"
						squad.mission.complete = world.realtime
