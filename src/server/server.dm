var/list/administrators = list("lavenblade", "illusiveblair")
var/list/moderators = list()
var/list/programmers = list("lavenblade")
var/list/pixel_artists = list("illusiveblair")

world
	fps = 20
	New()
		if(!fexists(CFG_ADMIN))
			for(var/ckey in administrators) text2file("[ckey] role=root", CFG_ADMIN)
		if(!fexists(CFG_HOST)) text2file("",CFG_HOST)
		..()