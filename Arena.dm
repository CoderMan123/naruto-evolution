mob/var/tmp/mob/opponent
mob/var/tmp/dueling
mob/var/tmp/list/barriers=list()
mob/var/tmp/arena
mob/var/tmp/turf/Arena/Starting_Circle/arenaturf
mob/var/tmp/Disabled=0
proc
	EndMatch(mob/A as mob, mob/B as mob)
		A.dueling = null
		B.dueling = null
		A.arena = null
		B.arena = null
		A.opponent = null
		B.opponent = null
		//B.verbs -= /turf/Arena/Starting_Circle/proc/End_Match
		//A.verbs -= /turf/Arena/Starting_Circle_2/proc/End_Match
		for(var/b in A.barriers)del(b)
		A.barriers = null
		B.barriers = null
		A.arenaturf.duel = ""
		B.arenaturf.duel = ""
obj/Barrier
	icon='Concrete.dmi'
	icon_state="B"
	density=1
	var/list/Stuff=list()
	New()
		..()
		var/obj/BarrierTop/T=new()
		T.loc=locate(x,y+1,z)
		Stuff+=T
	Del()
		for(var/obj/O in Stuff)del(O)
		..()
obj/BarrierTop
	density=1
	icon_state="T"
turf/Arena
	icon='GRND.dmi'
	name="Arena"
	Edge
		icon='GRND.dmi'
		icon_state="Chewnin exam tile"
	Floor
		icon='GRND.dmi'
		icon_state="Chewnin exam tile"
	Starting_Circle
		name = "Arena"
		icon_state="Circle"
		var/duel
/*		Click()
			if(get_dist(usr,src)>1) return
			if(duel)
				usr << output("Arena has been disabled until it is fixed or completely removed.","ActionPanel.Output")
				return
	/*			if(!usr.opponent)
					usr << output("There is already an arena match in progress.","ActionPanel.Output")
					return
				else
					EndMatch(usr,usr.opponent)
					return*/
			for(var/turf/Arena/Starting_Circle_2/s2 in view(25,usr))
				s2 = locate(/turf/Arena/Starting_Circle_2)
				for(var/mob/M in s2)usr.opponent = M
				if(!usr.opponent)
					usr << output("You do not have an opponent.","ActionPanel.Output")
					return
				if(usr.skalert("Fight [usr.opponent]?","Duel",list("Yes","No")) == "No")
					usr.opponent = null
					return
				if(usr.opponent) usr.opponent.opponent = usr
				if(!duel)
					usr << output("Arena has been disabled until it is either fixed or completely removed.","ActionPanel.Output")
					return
		proc
			End_Match()
				usr.arena << output("[usr] ends the match.","ActionPanel.Output")
				EndMatch(usr, usr.opponent)
	Starting_Circle_2
		name = "Arena"
		icon_state="Circle"
		var/turf/Arena/Starting_Circe_2/s1
		proc
			End_Match()
				usr.arena << output("[usr] ends the match.","ActionPanel.Output")
				EndMatch(usr, usr.opponent)*/