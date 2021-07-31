var/tmp/squirrel_count = 0
var/tmp/chipmonk_count = 0
var/tmp/hedgehog_count = 0
var/tmp/hare_count = 0
var/tmp/rabbit_count = 0
var/tmp/doe_count = 0
var/tmp/buck_count = 0

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
                    var/tmp/idle = 0

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

                    Death(killer)
                        ..()
                        if(src.health <= 0)
                            squirrel_count--

                    proc/Idle()
                        src.idle = 1
                        src.retreating = 0
                        src.target = null
                        walk_rand(src,8)

                    proc/CombatAI()
                        while(src)
                            if(!src.dead && !src.climbing)
                                if(!src.retreating && get_dist(src,src.target) <= 10) src.Retreat(src.target)
                                if(tree_location && get_dist(src, tree_location) <= 1) src.TreeClimb()
                                if(get_dist(src,src.target) <= 1) src.StopInFear(src.target)
                                if(get_dist(src,src.target) > 10 && !src.idle) src.Idle()
                            else if(!src.dead && !src.climbing && !src.idle) src.Idle()
                            sleep(2)

                    proc/FindTarget()
                        if(src)
                            for(var/mob/M in orange(10))
                                if(istype(M,/mob/npc) || istype(M,/mob/Rotating_Dummy) || M.dead) continue
                                if(M)
                                    src.target = M
                                else src.target = null

                    proc/Retreat(mob/M)
                        if(src && M)
                            src.idle = 0
                            src.retreating = 1
                            walk_away(src,M,11,1)
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
                        src.idle = 0
                        src.retreating = 0
                        src.scarred = 1
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
                    var/tmp/idle = 0

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
                    
                    Death(killer)
                        ..()
                        if(src.health <= 0)
                            chipmonk_count--

                    proc/Idle()
                        src.idle = 1
                        src.retreating = 0
                        src.target = null
                        walk_rand(src,8)

                    proc/CombatAI()
                        while(src)
                            if(!src.dead && !src.climbing)
                                if(!src.retreating && get_dist(src,src.target) <= 10) src.Retreat(src.target)
                                if(tree_location && get_dist(src, tree_location) <= 1) src.TreeClimb()
                                if(get_dist(src,src.target) <= 1) src.StopInFear(src.target)
                                if(get_dist(src,src.target) > 10 && !src.idle) src.Idle()
                            else if(!src.dead && !src.climbing && !src.idle) src.Idle()
                            sleep(2)

                    proc/FindTarget()
                        if(src)
                            for(var/mob/M in orange(10))
                                if(istype(M,/mob/npc) || istype(M,/mob/Rotating_Dummy) || M.dead) continue
                                if(M)
                                    src.target = M
                                else src.target = null

                    proc/Retreat(mob/M)
                        if(src && M)
                            walk_away(src,M,11,1)
                            src.idle = 0
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
                        src.idle = 0
                        src.retreating = 0
                        src.scarred = 1
                        walk(src,0)
                        sleep(3)
                        src.Retreat(M)

                hedgehog
                    icon = 'Hedgehog.dmi'
                    health = 20
                    maxhealth = 20
                    var/tmp/mob/target
                    var/tmp/retreating = 0
                    var/tmp/idle = 0

                    SetName()
                        return

                    New()
                        ..()
                        src.overlays-=/obj/MaleParts/UnderShade
                        src.pixel_x = 0
                        src.overlays+=/obj/MaleParts/UnderShadeSmall
                        hedgehog_count++
                        src.ryo = rand(10,30)
                        spawn() src.CombatAI()

                    Move()
                        ..()
                        src.FindTarget()
                    
                    Death(killer)
                        ..()
                        if(src.health <= 0)
                            hedgehog_count--

                    proc/Idle()
                        src.icon_state = ""
                        src.idle = 1
                        src.retreating = 0
                        src.target = null
                        walk_rand(src,8)

                    proc/CombatAI()
                        while(src)
                            if(!src.dead && src.target)
                                if(!src.retreating && get_dist(src,src.target) <= 5) src.Retreat(src.target)
                                if(get_dist(src,src.target) > 5) src.Idle()
                            else if(!src.dead && !src.idle) src.Idle()
                            sleep(2)

                    proc/FindTarget()
                        if(src)
                            for(var/mob/M in orange(5))
                                if(istype(M,/mob/npc) || istype(M,/mob/Rotating_Dummy) || M.dead) continue
                                if(M)
                                    src.target = M
                                else src.target = null

                    proc/Retreat(mob/M)
                        if(src && M)
                            src.retreating = 1
                            src.idle = 0
                            walk(src,0)
                            flick("hide", src)
                            sleep(3)
                            src.icon_state = "hidden"
                            src.FindTarget()

                hare
                    icon = 'Hare.dmi'
                    health = 20
                    maxhealth = 20
                    var/tmp/mob/target
                    var/retreating = 0
                    var/tmp/idle = 0

                    SetName()
                        return

                    New()
                        ..()
                        src.overlays-=/obj/MaleParts/UnderShade
                        src.pixel_x = 0
                        src.overlays+=/obj/MaleParts/UnderShadeSmall
                        hare_count++
                        src.ryo = rand(10,30)
                        spawn() src.CombatAI()

                    Move()
                        ..()
                        src.FindTarget()

                    Death(killer)
                        ..()
                        if(src.health <= 0)
                            hare_count--

                    proc/Idle()
                        src.idle = 1
                        src.retreating = 0
                        src.target = null
                        walk_rand(src,8)

                    proc/CombatAI()
                        while(src)
                            if(!src.dead)
                                if(!src.retreating && get_dist(src,src.target) <= 10) src.Retreat(src.target)
                                if(get_dist(src,src.target) > 10 && !src.idle) src.Idle()
                            else if(!src.dead && !src.idle) src.Idle()
                            sleep(2)

                    proc/FindTarget()
                        if(src)
                            for(var/mob/M in orange(10))
                                if(istype(M,/mob/npc) || istype(M,/mob/Rotating_Dummy) || M.dead) continue
                                if(M)
                                    src.target = M
                                else src.target = null

                    proc/Retreat(mob/M)
                        if(src && M)
                            src.idle = 0
                            src.retreating = 1
                            walk_away(src,M,11,1)
                            src.FindTarget()

                rabbit
                    icon = 'Rabbit.dmi'
                    health = 20
                    maxhealth = 20
                    var/tmp/mob/target
                    var/retreating = 0
                    var/tmp/idle = 0

                    SetName()
                        return

                    New()
                        ..()
                        src.overlays-=/obj/MaleParts/UnderShade
                        src.pixel_x = 0
                        src.overlays+=/obj/MaleParts/UnderShadeSmall
                        rabbit_count++
                        src.ryo = rand(10,30)
                        spawn() src.CombatAI()

                    Move()
                        ..()
                        src.FindTarget()

                    Death(killer)
                        ..()
                        if(src.health <= 0)
                            rabbit_count--

                    proc/Idle()
                        src.idle = 1
                        src.retreating = 0
                        src.target = null
                        walk_rand(src,8)

                    proc/CombatAI()
                        while(src)
                            if(!src.dead)
                                if(!src.retreating && get_dist(src,src.target) <= 10) src.Retreat(src.target)
                                if(get_dist(src,src.target) > 10 && !src.idle) src.Idle()
                            else if(!src.dead && !src.idle) src.Idle()
                            sleep(2)

                    proc/FindTarget()
                        if(src)
                            for(var/mob/M in orange(10))
                                if(istype(M,/mob/npc) || istype(M,/mob/Rotating_Dummy) || M.dead) continue
                                if(M)
                                    src.target = M
                                else src.target = null

                    proc/Retreat(mob/M)
                        if(src && M)
                            src.idle = 0
                            src.retreating = 1
                            walk_away(src,M,11,1)
                            src.FindTarget()

mob
    npc
        combat
            buck
                icon = 'Buck.dmi'
                health = 20
                maxhealth = 20
                var/tmp/mob/target
                var/retreating = 0
                var/tmp/idle = 0

                SetName()
                    return

                New()
                    ..()
                    buck_count++
                    src.ryo = rand(10,30)
                    spawn() src.CombatAI()

                Move()
                    ..()
                    src.FindTarget()

                Death(killer)
                    ..()
                    if(src.health <= 0)
                        buck_count--

                proc/Idle()
                    src.idle = 1
                    src.retreating = 0
                    src.target = null
                    walk_rand(src,8)

                proc/CombatAI()
                    while(src)
                        if(!src.dead)
                            if(!src.retreating && get_dist(src,src.target) <= 10) src.Retreat(src.target)
                            if(get_dist(src,src.target) > 15 && !src.idle) src.Idle()
                        else if(!src.dead && !src.idle) src.Idle()
                        sleep(2)

                proc/FindTarget()
                    if(src)
                        for(var/mob/M in orange(15))
                            if(istype(M,/mob/npc) || istype(M,/mob/Rotating_Dummy) || M.dead) continue
                            if(M)
                                src.target = M
                            else src.target = null

                proc/Retreat(mob/M)
                    if(src && M)
                        src.idle = 0
                        src.retreating = 1
                        walk_away(src,M,16,2)
                        src.FindTarget()

            doe
                icon = 'Doe.dmi'
                health = 20
                maxhealth = 20
                var/tmp/mob/target
                var/retreating = 0
                var/tmp/idle = 0
                var/tmp/childfawn

                SetName()
                    return

                New()
                    ..()
                    doe_count++
                    src.ryo = rand(10,30)
                    if(prob(30))
                        var/mob/npc/combat/fawn/child = new/mob/npc/combat/fawn(src.loc)
                        child.mother = src
                        src.childfawn = child
                    spawn() src.CombatAI()

                Move()
                    ..()
                    src.FindTarget()

                Death(killer)
                    ..()
                    if(src.health <= 0)
                        doe_count--

                proc/Idle()
                    src.idle = 1
                    src.retreating = 0
                    src.target = null
                    walk_rand(src,8)

                proc/CombatAI()
                    while(src)
                        if(!src.dead)
                            if(!src.retreating && get_dist(src,src.target) <= 10) src.Retreat(src.target)
                            if(get_dist(src,src.target) > 15 && !src.idle) src.Idle()
                        else if(!src.dead && !src.idle) src.Idle()
                        sleep(2)

                proc/FindTarget()
                    if(src)
                        for(var/mob/M in orange(15))
                            if(istype(M,/mob/npc) || istype(M,/mob/Rotating_Dummy) || M.dead) continue
                            if(M)
                                src.target = M
                            else src.target = null

                proc/Retreat(mob/M)
                    if(src && M)
                        src.idle = 0
                        src.retreating = 1
                        walk_away(src,M,16,2)
                        src.FindTarget()

            fawn
                icon = 'Fawn.dmi'
                health = 20
                maxhealth = 20
                var/tmp/mob/target
                var/retreating = 0
                var/tmp/idle = 0
                var/tmp/mother

                SetName()
                    return

                New()
                    ..()
                    src.ryo = rand(10,30)
                    walk_to(src,mother,2,3)
                    spawn() src.CombatAI()

                Move()
                    ..()
                    src.FindTarget()

                Death(killer)
                    ..()
                    if(src.health <= 0)
                        doe_count--

                proc/Idle()
                    src.idle = 1
                    src.retreating = 0
                    src.target = null
                    walk_rand(src,8)

                proc/CombatAI()
                    while(src)
                        if(!src.dead && !mother)
                            if(!src.retreating && get_dist(src,src.target) <= 10) src.Retreat(src.target)
                            if(get_dist(src,src.target) > 15 && !src.idle) src.Idle()
                        else if(!src.dead && !src.idle && !mother) src.Idle()
                        else walk_to(src,mother,2,3)
                        sleep(2)

                proc/FindTarget()
                    if(src)
                        for(var/mob/M in orange(15))
                            if(istype(M,/mob/npc) || istype(M,/mob/Rotating_Dummy) || M.dead) continue
                            if(M)
                                src.target = M
                            else src.target = null

                proc/Retreat(mob/M)
                    if(src && M)
                        src.idle = 0
                        src.retreating = 1
                        walk_away(src,M,16,2)
                        src.FindTarget()
