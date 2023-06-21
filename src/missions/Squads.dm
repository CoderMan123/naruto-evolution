proc/getOwner(ckey)
	if(!ckey) return
	for(var/mob/p in world)if(p.ckey == ckey)return p
obj/Squad
	name = "(Click for Settings)"
	var/tmp/
		Leader // ckey Oriented
		ID
		list/Members =  list() //ckey Oriented
	proc/Menu()
		if(usr.ckey != Leader)
			var/setting = usr.client.prompt("Select an option","Squad",list("View Squad","Check mission","Leave Squad", "Cancel"))
			switch(setting)
				if("Cancel") return
				if("View Squad")
					var/html={"
<head>
<title>[getOwner(Leader)]'s Squad</title>
<FONT SIZE="7"><b><u>[getOwner(Leader)]'s Squad</u></b></FONT>
<BODY BGCOLOR="#996633"><hr><br>"}
					var/mob/leader=getOwner(Leader)
					html+="[leader.name]  -  Health: [leader.health]/[leader.maxhealth] - Chakra: [leader.chakra]/[leader.maxchakra] - Level: [leader.level] ([(leader.exp/leader.maxexp)*100])<br><br>"
					for(var/ckey in Members)
						var/mob/p=getOwner(ckey)
						html+="[p.name]  -  Health: [p.health]/[p.maxhealth] - Chakra: [p.chakra]/[p.maxchakra] - Level: [p.level] ([round((p.exp/p.maxexp)*100)]%)<br><br>"
					usr << browse(html)
					winset(usr, null, {"
						Browser.is-visible = "true";
					"})
				if("Check mission")
					if(usr.Mission == null)
						if(usr.LastMissionTime>0)
							usr << output("You must wait [round(usr.LastMissionTime/600)] minutes before taking another mission.","Action.Output")
						else
							usr << output("You can currently pick up a mission.","Action.Output")
					else
						usr<<output("Your mission is: [usr.Mission]","Action.Output")

				if("Leave Squad")
					Members -= usr.ckey
					usr.Squad = null
					usr.client.channel ="Local"
					for(var/i in Members)
						var/mob/M=getOwner(i)
						M<<output("[usr] has left your squad","Action.Output")
						winset(M, "Navigation.SquadButton", "is-disabled = 'false'")
					var/mob/L=getOwner(Leader)
					L<<output("[usr] has left your squad","Action.Output")
					winset(L, "Navigation.SquadButton", "is-disabled = 'false'")
			return
		var/setting = usr.client.prompt("Select an option","Squad",list("View Squad","Invite Member", "Remove Member","Check Mission","Leave Squad", "Cancel"))
		switch(setting)
			if("View Squad")
				var/html={"
<head>
<title>[getOwner(Leader)]'s Squad</title>
<FONT SIZE="7"><b><u>[getOwner(Leader)]'s Squad</u></b></FONT>
<BODY BGCOLOR="#996633"><hr><br>"}
				var/mob/leader=getOwner(Leader)
				html+="[leader.name]  -  Health: [leader.health]/[leader.maxhealth] - Chakra: [leader.chakra]/[leader.maxchakra] - Level: [leader.level] ([(leader.exp/leader.maxexp)*100])<br><br>"
				for(var/ckey in Members)
					var/mob/p=getOwner(ckey)
					html+="[p.name]  -  Health: [p.health]/[p.maxhealth] - Chakra: [p.chakra]/[p.maxchakra] - Level: [p.level] ([(p.exp/p.maxexp)*100])<br><br>"
				usr << browse(html)
				winset(usr, null, {"
						Browser.is-visible = "true";
					"})
			if("Invite Member")
				if(usr.rank=="Genin"||usr.rank=="Academy Student")
					usr<<output("You must be Chuunin+ to lead a squad with other ninjas in it.","Action.Output")
					return
				if(length(Members) >= 4) //Checks to make sure there aren't already 4 memebers
					usr<<output("You already have a total of 4 members in your squad, including yourself. If you wish to add another, remove one first.","Action.Output")
				else
					var/list/Players = list()
					for(var/mob/P in view()) Players += P
					var/mob/M = input("Invite Who?") as mob in Players

					if(M.village != usr.village)
						usr<<output("You can only squad with fellow villagers.","Action.Output")
						return
					if(Members.Find(M.ckey) || M.ckey == Leader)
						usr<<output("[M] is already in the Squad","Action.Output")
						return
					if(M.Squad != null)
						usr<<output("[M] is already in another squad.","Action.Output")
						return
					if(alert(M,"[usr] wants you to join their Squad. Join?","Squad","Yes","No") == "Yes")
						if(length(Members) >= 4) return
						if(Members.Find(M.ckey) || M.ckey == Leader)
							usr<<output("[M] is already in the Squad","Action.Output")
							return
						Members += M.ckey
						M.Squad = src
						winset(M, "Navigation.SquadButton", "is-disabled = 'false'")
						usr<<output("[M] is now a part of your Squad.","Action.Output")
						M<<output("You are now a part of [usr]'s Squad.","Action.Output")
			if("Remove Member")
				var/list/Players = list()
				for(var/i in Members)
					if(getOwner(i))
						var/mob/M = getOwner(i)
						Players["[M.name]/[M.ckey]"] = M
					else Players += i
				Players += "Cancel"
				var/choice = input("Remove who?") in Players
				if(choice == "Cancel") return
				if(Players[choice])
					var/mob/M = Players[choice]
					Members -= M.ckey
					M.Squad = null
					M.client.channel ="Local"
					winset(M, "Navigation.SquadButton", "is-disabled = 'false'")
				else
					Members -= choice
				usr<<output("[choice] has been removed","Action.Output")
			if("Check Mission")
				if(usr.Mission == null)
					if(usr.LastMissionTime>0)
						usr << output("You must wait [round(usr.LastMissionTime/600)] minutes before taking another mission.","Action.Output")
					else
						usr << output("You can currently pick up a mission.","Action.Output")
				else
					usr<<output("Your mission is: [usr.Mission]","Action.Output")

			if("Leave Squad")
				if(usr.client.prompt("Are you sure?","Disband Squad","Yes","No") == "Yes")
					if(usr.ckey != Leader) return
					usr.Squad = null // The previous Leader no long has control over this.
					Members -= Leader // The leader's key isn't stored in the member list.
					if(!length(Members)) del src // Del the Squad if no one is left to take over.
					Leader = pick(Members) //It picks a new Leader from the current members
					Members -= Leader //Remove the leader from the member list once(was duplicating)
					usr.client.channel ="Local"
					winset(usr, "Navigation.SquadButton", "is-disabled = 'false'")
mob/
	var/tmp/
		obj/Squad/Squad
mob/verb/
	SquadMenu()
		set hidden=1
		if(!Squad)
			if(src.client.prompt("Would you like to create a squad?", "Alert", list("Yes", "No")) == "Yes")
				Create_Squad()
			return
		usr.Squad.Menu()

	FactionMenu()
		set hidden=1
		if(!getFaction(src.Faction)&&Squad&&!Faction)
			if(Squad.Members.len>=4&&Squad.Leader==ckey)
				if(src.client.prompt("You have the ability to create a Faction. You have five members in your party. It costs 3000 Ryo to create, continue?", "Alert", list("Create Faction", "Cancel") == "Create Faction"))
					Create_Faction()
			else
				src<<"You need five members in your party, including yourself, and be the leader of your party to form a faction."
			return

		if(winget(src, "Main.KageChild", "is-visible") == "false")
			winset(src, null, {"
				Main.KageChild.is-visible = "true";
			"})
		else
			winset(src, null, {"
				Main.KageChild.is-visible = "false";
			"})

	Create_Squad()
		set hidden=1
		set category = "Commands"
		var/obj/Squad/P = new
		usr.Squad = P
		P.Leader = usr.ckey
		P.ID = "[rand(100,999)][rand(100,999)][rand(100,999)]"
		winset(src, "Navigation.SquadButton", "is-disabled = 'false'")

