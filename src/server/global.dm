var/tmp/list/damage_number_pool=list()



proc/GetHokage(var/format = RETURN_FORMAT_CKEY)
    switch(format)
        if(RETURN_FORMAT_CKEY) return hokage.len ? hokage[1] : null
        if(RETURN_FORMAT_CHARACTER) return hokage.len ? hokage[hokage[1]] : null

proc/GetKazekage(var/format = RETURN_FORMAT_CKEY)
    switch(format)
        if(RETURN_FORMAT_CKEY) return kazekage.len ? kazekage[1] : null
        if(RETURN_FORMAT_CHARACTER) return kazekage.len ? kazekage[kazekage[1]] : null

proc/GetAkatsuki(var/format = RETURN_FORMAT_CKEY)
    switch(format)
        if(RETURN_FORMAT_CKEY) return akatsuki.len ? akatsuki[1] : null
        if(RETURN_FORMAT_CHARACTER) return akatsuki.len ? akatsuki[akatsuki[1]] : null