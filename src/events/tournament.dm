var/tournament_id = 0

var/tournament_db[0]

#define TOURNAMENT_MODE_SINGLE_ELIMINATION 1
#define TOURNAMENT_MODE_TEAM_ELIMINATION   2

#define TOURNAMENT_JOIN_TYPE_PREMADE       1
#define TOURNAMENT_JOIN_TYPE_SIGNUP        2
#define TOURNAMENT_JOIN_TYPE_MATCHMAKING   3

/tournament
    var/id = 0
    var/participants[0]
    var/teams[0]
    var/bracket[0]
    var/rounds[0]
    var/ranked = 0
    var/mode = TOURNAMENT_MODE_SINGLE_ELIMINATION
    var/join_type = TOURNAMENT_JOIN_TYPE_PREMADE
    var/join_registration = 0
    var/matchmaking = 0
    var/max_team_size = 2
    var/exp_rewards = 0
    var/item_rewards[0]
    

    // Sign ups: if signup form teams using squads and max team size, if not form teams without squads in the torney system.
    // Allow premade teams using squads.

    // matchmaking system to find a tournament
    
    // anti-abuse:
    // handle repeat matches to prevent farming

    proc/SortParticipants()
        //var/sorted_participants[0] shouldnt need a new list. use bubblesort with list.swap()
        for(var/mob/m in src.participants)
            for(var/mob/next in src.participants)
                if(m.level > next.level)
                    src.participants.Swap(m, next)
    
    proc/SortTeams()
        // This does not support players being offline!
        
        for(var/tournament_team/team in src.teams)
            var/team_average_level = 0
            
            for(var/mob/m in mobs_online)
                if(team.members.Find(m))
                    team_average_level += m.level
            
            team_average_level = team_average_level / team.members.len
            
            for(var/tournament_team/next_team in src.teams)
                var/next_team_average_level = 0

                for(var/mob/m in mobs_online)
                    if(team.members.Find(m))
                        next_team_average_level += m.level
                
                next_team_average_level = next_team_average_level / team.members.len

                if(team_average_level > next_team_average_level)
                    src.teams.Swap(team, next_team)

    // sort participents (based on levels, lowest to highest)
    // loop participents and create bracket
    // run fights
    // repeat until winner
    // log results in db, save tournament object in history

/tournament_team
    var/members[0]