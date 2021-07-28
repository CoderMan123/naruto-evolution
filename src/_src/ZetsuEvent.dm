var/tmp/vill_lives_left = 5
var/tmp/akat_lives_left = 0
var/tmp/zetsu_count = 0
var/tmp/zetsu_event_active = 0
var/tmp/sand_points = 0
var/tmp/leaf_points = 0
var/zetsu_event_toggle = 0

proc/ZetsuEvent()
	while(world)
		sleep(600*360)

proc/ZetsuEventStart()
	if(!zetsu_event_active && zetsu_event_toggle == 1)
		zetsu_event_active = 1

		for(var/mob/m in mobs_online)
			if(m)
				if(m.village == VILLAGE_AKATSUKI)
					akat_lives_left++
					m << output("<b><font color= #971e1e>The Zetsu are ready and have been released into the world! We must join the fight as the ninja world will surely try to thwart our efforts. (As an Akatsuki member you will gain additional rewards for killing village ninja during the event)</Font></b>","Action.Output")
				else if(m.village == VILLAGE_LEAF || m.village == VILLAGE_SAND)
					vill_lives_left++
					m << output("<b><font color= #971e1e>Hostile enemies known as white zetsu are roaming the lands! This can only be the Akatsuki's doing. We must band together to defeat them. The Akatsuki cannot be allowed to have their way.(You will gain additional experience for killing any member of the Akatsuki during this event)</Font></b>","Action.Output")
				else if(m.village == VILLAGE_MISSING_NIN)
					vill_lives_left++
					m << output("<b><font color= #971e1e>The Akatsuki have begun an assault on the ninja world! White Zetsu are roaming the wilds. You'll have to fight for your survival but perhaps you can take advantage of the chaos to take down your enemies. (You will gain additional exp for killing any player during this event)</Font></b>","Action.Output")
		akat_lives_left = round((akat_lives_left*2+(vill_lives_left/4)))

		for(var/obj/zetsuspawn/zetsuspawn)
			if(prob(33))
				/*var/mob/npc/combat/white_zetsu/zetsu = */new/mob/npc/combat/white_zetsu(zetsuspawn.loc)
				zetsu_count++
	else return 0

proc/ZetsuEventEnd(mob/M)
	if(zetsu_event_active)
		zetsu_event_active = 0
		if(zetsu_count < 1 || akat_lives_left < 1)
			if(leaf_points == sand_points)
				world << ("Both villages contributed equally! They have both earned 5 bonus exp for their efforts!")
				for(var/mob/m in mobs_online)
					if(m.village == VILLAGE_LEAF || m.village == VILLAGE_SAND)
						m.exp += 5
						m.Levelup()
			else if(leaf_points > sand_points)
				world << ("The Hidden Leaf village contributed the most and have earned 10 bonus exp for their efforts!")
				for(var/mob/m in mobs_online)
					if(m.village == VILLAGE_LEAF)
						m.exp += 5
						m.Levelup()
			else
				world << ("<b>The Hidden Sand village contributed the most and have earned 10 bonus exp for their efforts!</b>")
				for(var/mob/m in mobs_online)
					if(m.village == VILLAGE_SAND)
						m.exp += 5
						m.Levelup()

			for(var/mob/m in mobs_online)
				var/squad/squad = m.GetSquad()	
				spawn() m.client.UpdateCharacterPanel()
				if(squad)
					spawn() squad.RefreshMember(m)

obj
	zetsuspawn
		icon = 'placeholdertiles.dmi'
		icon_state = "zetsuspawn"
		New()
			..()
			src.icon_state = "blank"
