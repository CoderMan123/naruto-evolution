var/tmp/hokage_election = 0
var/tmp/hokage_ballot_open = 0
var/tmp/list/hokage_election_ballot = list() // list(ckey = list(character, votes))

var/tmp/kazekage_election = 0
var/tmp/kazekage_ballot_open = 0
var/tmp/list/kazekage_election_ballot = list() // list(ckey = list(character, votes))

world
    proc
        Election()
            while(src)
                if(!kages[VILLAGE_LEAF] && !global.hokage_election)
                    spawn() world.StartElection(VILLAGE_LEAF, open_ballot = 1)
                
                if(!kages[VILLAGE_SAND] && !global.kazekage_election)
                    spawn() world.StartElection(VILLAGE_SAND, open_ballot = 1)
                
                if(global.hokage_election && world.realtime > global.hokage_election)
                    world.EndElection(VILLAGE_LEAF)
                
                if(global.kazekage_election && world.realtime > global.kazekage_election)
                    world.EndElection(VILLAGE_SAND)
                    
                sleep(600)
        
        StartElection(var/village, var/list/ballot, var/open_ballot = 1)
            switch(village)
                if(VILLAGE_LEAF)
                    global.hokage_election = world.realtime + 432000 // 12 Hours
                    global.hokage_ballot_open = open_ballot
                    if(ballot) global.hokage_election_ballot = ballot
                
                if(VILLAGE_SAND)
                    global.kazekage_election = world.realtime + 432000 // 12 Hours
                    global.kazekage_ballot_open = open_ballot
                    if(ballot) global.kazekage_election_ballot = ballot
        
        EndElection(var/village)
            switch(village)
                if(VILLAGE_LEAF)
                    if(global.hokage_election_ballot.len < 1)
                        global.hokage_election = 0
                        global.hokage_election_ballot = list()
                        spawn() StartElection(village)

                    else if(global.hokage_election_ballot.len == 1)
                        kages[village] = global.hokage_election_ballot[1]

                    else
                        for(var/ckey in global.hokage_election_ballot)
                            var/list/entry = list(global.hokage_election_ballot[ckey])
                            
                            for(var/ckey_compare in global.hokage_election_ballot - ckey)
                                var/list/entry_compare = list(global.hokage_election_ballot[ckey_compare])

                                if(entry[2] > entry_compare[2])
                                    global.hokage_election_ballot.Remove(ckey_compare)
                                    break

                                else if(entry[2] < entry_compare[2])
                                    global.hokage_election_ballot.Remove(ckey)
                                    break
                                
                                else if(entry[2] == entry_compare[2])
                                    break
                        
                        if(global.hokage_election_ballot.len == 1)
                            kages[village] = global.hokage_election_ballot[1]
                        
                        else if(global.hokage_election_ballot > 1)
                            global.hokage_election = 0
                            spawn() world.StartElection(village, global.hokage_election_ballot, open_ballot = 0)

                if(VILLAGE_SAND)