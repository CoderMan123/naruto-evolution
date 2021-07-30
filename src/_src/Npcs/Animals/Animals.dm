var/tmp/squirrel_count = 0
var/tmp/chipmonk_count = 0

mob
    npc
        combat
            small
                squirrel
                    icon = 'Squirrel.dmi'
                    health = 20
                    maxhealth = 20
                    var/tmp/mob/target
                    var/retreating = 0
                    var/tmp/climbing = 0
                    var/tmp/tree_location
                    var/tmp/scarred = 0

                    SetName()
                        return

                    New()
                        ..()
                        src.overlays-=/obj/MaleParts/UnderShade
                        src.pixel_x = 0
                        src.overlays+=/obj/MaleParts/UnderShadeSmall
                        squirrel_count++
                        src.ryo = rand(10,30)
                        spawn() src.CombatAI()

                    Move()
                        ..()
                        if(!climbing)
                            src.FindTarget()
                            if(src.retreating)
                                for(var/obj/Ground/Trees/T in orange(10))
                                    if(T)
                                        tree_location = T.loc
                                        walk_to(src, T)
                                        break

                    Death()
                        ..()
                        if(src.health <= 0)
                            squirrel_count--

                    proc/Idle()
                        src.retreating = 0
                        src.target = null
                        walk_rand(src,8)

                    proc/CombatAI()
                        while(src)
                            if(!src.dead && !src.climbing)
                                if(tree_location && get_dist(src, tree_location) <= 1) src.TreeClimb()
                                if(get_dist(src,src.target) <= 1) src.StopInFear(src.target)
                                if(!src.retreating && get_dist(src,src.target) <= 10) src.Retreat(src.target)
                                if(get_dist(src,src.target) > 10) src.Idle()
                            else if(!src.dead && !src.climbing) src.Idle()
                            sleep(2)

                    proc/FindTarget()
                        if(src)
                            for(var/mob/M in orange(10))
                                if(istype(M,/mob/npc) || istype(M,/mob/Rotating_Dummy) || M.dead) continue
                                if(M)
                                    src.target = M
                                    src.retreating = 1
                                else src.target = null

                    proc/Retreat(mob/M)
                        if(src && M)
                            walk_away(src,M,11,1)
                            src.retreating = 1
                            src.FindTarget()

                    proc/TreeClimb()
                        src.climbing = 1
                        layer = MOB_LAYER+7
                        walk(src, 0)
                        src.loc = tree_location
                        if(src.dir == NORTH || src.dir == WEST)                  
                            icon_state = "climbright"
                        if(src.dir == SOUTH || src.dir == EAST)                  
                            icon_state = "climbleft"
                        step(src,NORTH)
                        sleep(2)
                        step(src,NORTH)
                        sleep(2)
                        step(src,NORTH)
                        del src

                    proc/StopInFear(mob/M)
                        retreating = 0
                        scarred = 1
                        walk(src,0)
                        sleep(3)
                        src.Retreat(M)

                chipmonk
                    icon = 'Chipmonk.dmi'
                    health = 20
                    maxhealth = 20
                    var/tmp/mob/target
                    var/retreating = 0
                    var/tmp/climbing = 0
                    var/tmp/tree_location
                    var/tmp/scarred = 0

                    SetName()
                        return

                    New()
                        ..()
                        src.overlays-=/obj/MaleParts/UnderShade
                        src.pixel_x = 0
                        src.overlays+=/obj/MaleParts/UnderShadeSmall
                        chipmonk_count++
                        src.ryo = rand(10,30)
                        spawn() src.CombatAI()

                    Move()
                        ..()
                        if(!climbing)
                            src.FindTarget()
                            if(src.retreating)
                                for(var/obj/Ground/Trees/T in orange(10))
                                    if(T)
                                        tree_location = T.loc
                                        walk_to(src, T)
                                        break
                    
                    Death()
                        ..()
                        if(src.health <= 0)
                            chipmonk_count--
                    proc/Idle()
                        src.retreating = 0
                        src.target = null
                        walk_rand(src,8)

                    proc/CombatAI()
                        while(src)
                            if(!src.dead && !src.climbing)
                                if(tree_location && get_dist(src, tree_location) <= 1) src.TreeClimb()
                                if(get_dist(src,src.target) <= 1) src.StopInFear(src.target)
                                if(!src.retreating && get_dist(src,src.target) <= 10) src.Retreat(src.target)
                                if(get_dist(src,src.target) > 10) src.Idle()
                            else if(!src.dead && !src.climbing) src.Idle()
                            sleep(2)

                    proc/FindTarget()
                        if(src)
                            for(var/mob/M in orange(10))
                                if(istype(M,/mob/npc) || istype(M,/mob/Rotating_Dummy) || M.dead) continue
                                if(M)
                                    src.target = M
                                    src.retreating = 1
                                else src.target = null

                    proc/Retreat(mob/M)
                        if(src && M)
                            walk_away(src,M,11,1)
                            src.retreating = 1
                            src.FindTarget()

                    proc/TreeClimb()
                        src.climbing = 1
                        layer = MOB_LAYER+7
                        walk(src, 0)
                        src.loc = tree_location
                        if(src.dir == NORTH || src.dir == WEST)                  
                            icon_state = "climbright"
                        if(src.dir == SOUTH || src.dir == EAST)                  
                            icon_state = "climbleft"
                        step(src,NORTH)
                        sleep(2)
                        step(src,NORTH)
                        sleep(2)
                        step(src,NORTH)
                        del src

                    proc/StopInFear(mob/M)
                        retreating = 0
                        scarred = 1
                        walk(src,0)
                        sleep(3)
                        src.Retreat(M)