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
	fps = 20
	New()
		src.Load()
		..()

	Del()
		src.Save()
		..()

	proc/Save()
		var/savefile/F = new(SAVEFILE_NAMES)
		F["names_taken"] << names_taken

		F = new(SAVEFILE_SQUADS)
		F["squads"] << squads

	proc/Load()
		if(!fexists(CFG_ADMIN))
			for(var/ckey in administrators) text2file("[ckey] role=root", CFG_ADMIN)
		if(!fexists(CFG_HOST)) text2file("",CFG_HOST)

		var/savefile/F = new(SAVEFILE_NAMES)
		if(F["names_taken"]) F["names_taken"] >> names_taken

		F = new(SAVEFILE_SQUADS)
		if(F["squads"]) F["squads"] >> squads