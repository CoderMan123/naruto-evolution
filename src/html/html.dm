proc/HTML_GetName(mob/m)
    var/badges = ""

    var/obj/Symbols/Village/village = new(m)
    var/obj/Symbols/Rank/rank = new(m)
    var/obj/Symbols/Role/role = new(m)

    if(role.icon) badges += "\icon[role] "
    if(village.icon) badges += "\icon[village]"
    if(rank.icon) badges += " \icon[rank]"

    if(!m.village)
        return "<font color='[COLOR_VILLAGE_MISSING_NIN]'>[m.name]</font>"
    else
        switch(m.village)
            if(VILLAGE_LEAF)
                return "[badges] <font color='[COLOR_VILLAGE_LEAF]'>[m.name]</font>"

            if(VILLAGE_SAND)
                return "[badges] <font color='[COLOR_VILLAGE_SAND]'>[m.name]</font>"

            if(VILLAGE_MISSING_NIN)
                return "[badges] <font color='[COLOR_VILLAGE_MISSING_NIN]'>[m.name]</font>"

            if(VILLAGE_AKATSUKI)
                return "[badges] <font color='[COLOR_VILLAGE_AKATSUKI]'>[m.name]</font>"

proc/HTML_GetVillage(mob/m)
    if(!m.village)
        return ""
    else
        switch(m.village)
            if(VILLAGE_LEAF)
                return "<font color='[COLOR_VILLAGE_LEAF]'>[m.village]</font>"

            if(VILLAGE_SAND)
                return "<font color='[COLOR_VILLAGE_SAND]'>[m.village]</font>"

            if(VILLAGE_MISSING_NIN)
                return "<font color='[COLOR_VILLAGE_MISSING_NIN]'>[m.village]</font>"

            if(VILLAGE_AKATSUKI)
                return "<font color='[COLOR_VILLAGE_AKATSUKI]'>[m.village]</font>"