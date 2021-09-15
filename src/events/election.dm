var/tmp/hokage_election = 0
var/tmp/hokage_ballot_open = 0
var/tmp/list/hokage_election_ballot = list()
var/tmp/list/hokage_election_votes = list()

var/tmp/kazekage_election = 0
var/tmp/kazekage_ballot_open = 0
var/tmp/list/kazekage_election_ballot = list()
var/tmp/list/kazekage_election_votes = list()

election_ballot
	parent_type = /obj
	var/ckey
	var/character
	var/votes = 0

proc/GetBallot(mob/m)
	switch(m.village)
		if(VILLAGE_LEAF)
			for(var/election_ballot/ballot in hokage_election_ballot)
				if(ballot.ckey == m.ckey) return ballot
			return null

		if(VILLAGE_SAND)
			for(var/election_ballot/ballot in kazekage_election_ballot)
				if(ballot.ckey == m.ckey) return ballot
			return null


world
	proc
		Election()
			while(src)
				if(!global.hokage.len && !global.hokage_election)
					spawn() world.StartElection(VILLAGE_LEAF, open_ballot = 1)
				
				if(!global.kazekage.len && !global.kazekage_election)
					spawn() world.StartElection(VILLAGE_SAND, open_ballot = 1)
				
				if(global.hokage_election && world.realtime > global.hokage_election)
					world.EndElection(VILLAGE_LEAF)
				
				if(global.kazekage_election && world.realtime > global.kazekage_election)
					world.EndElection(VILLAGE_SAND)
					
				sleep(600)
		
		StartElection(var/village, var/list/ballot, var/open_ballot = 1)
			switch(village)
				if(VILLAGE_LEAF)
					global.hokage_election = world.realtime + 600 // 12 Hours
					global.hokage_ballot_open = open_ballot
					if(ballot) global.hokage_election_ballot = ballot
					else global.hokage_election_ballot = list()
					global.hokage_election_votes = list()

					world << output("An election for the <font color = '[COLOR_VILLAGE_LEAF]'>[RANK_HOKAGE]</font> has started for the <font color = '[COLOR_VILLAGE_LEAF]'>[VILLAGE_LEAF]</font> village and will end in 12 hours.", "Action.Output")
					if(hokage_ballot_open)
						world << output("The <font color = '[COLOR_VILLAGE_LEAF]'>[RANK_HOKAGE]</font> election is currently <u>open ballot</u>.", "Action.Output")
						world << output("You may nominate yourself at the <font color = '[COLOR_VILLAGE_LEAF]'>Leaf Ballot Secretary</font> in the <font color = '[COLOR_VILLAGE_LEAF]'>[RANK_HOKAGE]</font> house.", "Action.Output")
					else
						world << output("The <font color = '[COLOR_VILLAGE_LEAF]'>[RANK_HOKAGE]</font> election is currently <b>closed ballot</b>, due to the previous election resulting in a tie.", "Action.Output")
					
					world << output("Ninja from the <font color = '[COLOR_VILLAGE_LEAF]'>[VILLAGE_LEAF]</font> village may cast their vote at their ballot box in the <font color = '[COLOR_VILLAGE_LEAF]'>[RANK_HOKAGE]</font> house.", "Action.Output")
				
				if(VILLAGE_SAND)
					global.kazekage_election = world.realtime + 432000 // 12 Hours
					global.kazekage_ballot_open = open_ballot
					if(ballot) global.kazekage_election_ballot = ballot
					else global.kazekage_election_ballot = list()
					global.kazekage_election_votes = list()

					world << output("An election for the <font color = '[COLOR_VILLAGE_SAND]'>[RANK_KAZEKAGE]</font> has started for the <font color = '[COLOR_VILLAGE_SAND]'>[RANK_KAZEKAGE]</font> village and will end in 12 hours.", "Action.Output")
					if(hokage_ballot_open)
						world << output("The <font color = '[COLOR_VILLAGE_SAND]'>[RANK_KAZEKAGE]</font> election is currently <u>open ballot</u>.", "Action.Output")
						world << output("You may nominate yourself at the <font color = '[COLOR_VILLAGE_SAND]'>Sand Ballot Secretary</font> in the <font color = '[COLOR_VILLAGE_SAND]'>[RANK_KAZEKAGE]</font> house.", "Action.Output")
					else
						world << output("The <font color = '[COLOR_VILLAGE_SAND]'>[RANK_KAZEKAGE]</font> election is currently <b>closed ballot</b>, due to the previous election resulting in a tie.", "Action.Output")
					
					world << output("Ninja from the <font color = '[COLOR_VILLAGE_SAND]'>[VILLAGE_SAND]</font> village may cast their vote at their ballot box in the <font color = '[COLOR_VILLAGE_SAND]'>[RANK_KAZEKAGE]</font> house.", "Action.Output")
				
		
		EndElection(var/village)
			switch(village)
				if(VILLAGE_LEAF)
					if(global.hokage_election_ballot.len < 1)
						global.hokage_election = 0
						spawn() StartElection(village)

					else if(global.hokage_election_ballot.len == 1)
						var/election_ballot/ballot = global.hokage_election_ballot[1]
						hokage[ballot.ckey] = ballot.character

						world << output("The election for the <font color='[COLOR_VILLAGE_LEAF]'>[RANK_HOKAGE]</font> has ended for the <font color='[COLOR_VILLAGE_LEAF]'>[VILLAGE_LEAF]</font> village.", "Action.Output")
						world << output("[ballot.character] has been elected into office as the <font color='[COLOR_VILLAGE_LEAF]'>[RANK_HOKAGE]</font> for the <font color='[COLOR_VILLAGE_LEAF]'>[VILLAGE_LEAF]</font> village.", "Action.Output")

						for(var/mob/m in mobs_online)
							if(hokage[m.client.ckey] == m.character)
								m.client.StaffCheck()

					else
						for(var/election_ballot/ballot in global.hokage_election_ballot)
							
							for(var/election_ballot/ballot_compare in global.hokage_election_ballot - ballot)

								if(ballot.votes > ballot_compare.votes)
									global.hokage_election_ballot.Remove(ballot_compare)
									break

								else if(ballot.votes < ballot_compare.votes)
									global.hokage_election_ballot.Remove(ballot)
									break
								
								else if(ballot.votes == ballot_compare.votes)
									break
						
						if(global.hokage_election_ballot.len == 1)
							var/election_ballot/ballot = global.hokage_election_ballot[1]
							hokage[ballot.ckey] = ballot.character

							world << output("The election for the <font color='[COLOR_VILLAGE_LEAF]'>[RANK_HOKAGE]</font> has ended for the <font color='[COLOR_VILLAGE_LEAF]'>[VILLAGE_LEAF]</font> village.", "Action.Output")
							world << output("[ballot.character] has been elected into office as the <font color='[COLOR_VILLAGE_LEAF]'>[RANK_HOKAGE]</font> for the <font color='[COLOR_VILLAGE_LEAF]'>[VILLAGE_LEAF]</font> village.", "Action.Output")

							for(var/mob/m in mobs_online)
								if(hokage[m.client.ckey] == m.character)
									m.client.StaffCheck()
						
						else if(global.hokage_election_ballot > 1)
							global.hokage_election = 0
							world << output("The election for the <font color='[COLOR_VILLAGE_LEAF]'>[RANK_HOKAGE]</font> has ended in a <u>tie</u> for the <font color='[COLOR_VILLAGE_LEAF]'>[VILLAGE_LEAF]</font> village.", "Action.Output")
							spawn() world.StartElection(village, global.hokage_election_ballot, open_ballot = 0)

				if(VILLAGE_SAND)
					if(global.kazekage_election_ballot.len < 1)
						global.kazekage_election = 0
						spawn() StartElection(village)

					else if(global.kazekage_election_ballot.len == 1)
						var/election_ballot/ballot = global.kazekage_election_ballot[1]
						kazekage[ballot.ckey] = ballot.character

						world << output("The election for the <font color='[COLOR_VILLAGE_SAND]'>[RANK_KAZEKAGE]</font> has ended for the <font color='[COLOR_VILLAGE_SAND]'>[VILLAGE_SAND]</font> village.", "Action.Output")
						world << output("[ballot.character] has been elected into office as the <font color='[COLOR_VILLAGE_SAND]'>[RANK_KAZEKAGE]</font> for the <font color='[COLOR_VILLAGE_SAND]'>[VILLAGE_SAND]</font> village.", "Action.Output")

						for(var/mob/m in mobs_online)
							if(kazekage[m.client.ckey] == m.character)
								m.client.StaffCheck()

					else
						for(var/election_ballot/ballot in global.kazekage_election_ballot)
							
							for(var/election_ballot/ballot_compare in global.kazekage_election_ballot - ballot)

								if(ballot.votes > ballot_compare.votes)
									global.kazekage_election_ballot.Remove(ballot_compare)
									break

								else if(ballot.votes < ballot_compare.votes)
									global.kazekage_election_ballot.Remove(ballot)
									break
								
								else if(ballot.votes == ballot_compare.votes)
									break
						
						if(global.kazekage_election_ballot.len == 1)
							var/election_ballot/ballot = global.kazekage_election_ballot[1]
							kazekage[ballot.ckey] = ballot.character

							world << output("The election for the <font color='[COLOR_VILLAGE_SAND]'>[RANK_KAZEKAGE]</font> has ended for the <font color='[COLOR_VILLAGE_SAND]'>[VILLAGE_SAND]</font> village.", "Action.Output")
							world << output("[ballot.character] has been elected into office as the <font color='[COLOR_VILLAGE_SAND]'>[RANK_KAZEKAGE]</font> for the <font color='[COLOR_VILLAGE_SAND]'>[VILLAGE_SAND]</font> village.", "Action.Output")

							for(var/mob/m in mobs_online)
								if(kazekage[m.client.ckey] == m.character)
									m.client.StaffCheck()
						
						else if(global.kazekage_election_ballot > 1)
							global.kazekage_election = 0
							world << output("The election for the <font color='[COLOR_VILLAGE_SAND]'>[RANK_KAZEKAGE]</font> has ended in a <u>tie</u> for the <font color='[COLOR_VILLAGE_SAND]'>[VILLAGE_SAND]</font> village.", "Action.Output")
							spawn() world.StartElection(village, global.kazekage_election_ballot, open_ballot = 0)