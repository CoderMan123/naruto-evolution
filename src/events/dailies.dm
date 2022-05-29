var/hotspring_exp = 3
var/hotspring_stat_exp = 300

proc/Hotspring_Loop()
	while(world)
		for(var/mob/m in mobs_online)
			if(m && m.loc && istype(m.loc.loc, /area/hotspring))
				if(m && CheckNextDay(m, m.last_hotspring_time))
					m<<output("It is a new day. Prepare your buttocks.","Action.Output")
					m.last_hotspring_time = world.realtime
					m.hotspring_minutes = 0
				else if(m && m.hotspring_minutes < 60)
					m.hotspring_minutes++
					m.LevelStat("Ninjutsu", hotspring_stat_exp, 1)
					m.LevelStat("Genjutsu", hotspring_stat_exp, 1)
					m.LevelStat("Precision", hotspring_stat_exp,1)
					m.LevelStat(SPECIALIZATION_TAIJUTSU, hotspring_stat_exp, 1)
					m.LevelStat("Defence", hotspring_stat_exp, 1)
					m.LevelStat("Agility", hotspring_stat_exp, 1)
					m.exp += hotspring_exp
					m<<output("You feel relaxed and have gained [hotspring_exp] exp and [hotspring_stat_exp] exp in each stat! You have spent [m.hotspring_minutes] minutes in the hotspring today.","Action.Output")
				else if(m)
					m<<output("You've already soaked for an hour today, that's enough relaxation for one day. Come back tommorow.","Action.Output")
		sleep(600)


proc/CheckNextDay(mob/M, var/timestamp)
	if(!timestamp)
		M.last_hotspring_time = world.realtime
		timestamp = M.last_hotspring_time

	var/month = text2num(time2text(timestamp, "MM"))
	var/day = text2num(time2text(timestamp, "DD"))
	var/year = text2num(time2text(timestamp, "YYYY"))

	if(year == text2num(time2text(world.realtime, "YYYY")))
		if(month == text2num(time2text(world.realtime, "MM")))
			if(day == text2num(time2text(world.realtime, "DD")))
				return 0
	return 1

area
	hotspring
		Safe = 1
		icon = 'placeholdertiles.dmi'
		icon_state = "hotspring"
		invisibility = 99