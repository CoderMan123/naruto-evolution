var/tmp/vill_lives_left = 5
var/tmp/akat_lives_left = 0
var/tmp/zetsu_count = 0
var/tmp/zetsu_event_active = 0
var/tmp/sand_points = 0
var/tmp/leaf_points = 0
var/zetsu_event_toggle = 1

proc/ZetsuEvent()
	while(world)
		sleep(600*360)
		ZetsuEventStart()

proc/ZetsuEventStart()
	zetsu_count = 0
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
		var/squad/squad = M.GetSquad()
		if(zetsu_count < 1 || akat_lives_left < 1)
			if(akat_lives_left < 1)
				world << output ("<b><font color= #971e1e>The Akatsuki have suffered too many loses, the Akatsuki have failed!</Font></b>", "Action.Output")
				if(squad)
					for(var/mob/m in mobs_online)
						if(squad == m.GetSquad())
							m << output ("[M.name] has killed an Akatsuki member leading to their retreat. Your squad has been awarded 20 bonus experience for their efforts!", "Action.Output")
							m.exp += 20
							m.Levelup()
				else
					M.exp +=15
					M.Levelup()

			if(zetsu_count < 1)
				world << output("<b><font color= #971e1e>[M.name] has slain the last of the White Zetsu! The Akatsuki's assault has been halted.. for now. The Shinobi Alliance are Victorious and have gained 40 bonus exp!</Font></b>","Action.Output")
				if(squad)
					for(var/mob/m in mobs_online)
						if(squad == m.GetSquad())
							m << output ("[M.name] has killed the last Zetsu, the Akatsuki have failed! Your squad gains 20 extra exp for your efforts!", "Action.Output")
							m.exp += 20
							m.Levelup()
				else
					M.exp +=20
					M.Levelup()

			if(leaf_points == sand_points)
				world << output("Both villages contributed equally! They have both earned 40 bonus exp for their efforts!","Action.Output")
				for(var/mob/m in mobs_online)
					if(m.village == VILLAGE_LEAF || m.village == VILLAGE_SAND)
						m.exp += 40
						m.Levelup()
				
			else if(leaf_points > sand_points)
				world << output("The Hidden Leaf village contributed the most and have earned 80 bonus exp for their efforts!","Action.Output")
				for(var/mob/m in mobs_online)
					if(m.village == VILLAGE_LEAF)
						m.exp += 80
						m.Levelup()
			else
				world << output("<b>The Hidden Sand village contributed the most and have earned 80 bonus exp for their efforts!</b>","Action.Output")
				for(var/mob/m in mobs_online)
					if(m.village == VILLAGE_SAND)
						m.exp += 80
						m.Levelup()
			for(var/mob/m in mobs_online)
				if(m.village == VILLAGE_LEAF || m.village == VILLAGE_SAND)
					m.exp += 40
					m.Levelup()
		if(vill_lives_left < 1)
			world << output ("<b><font color= #971e1e>The Shinobi Alliance have suffered too many loses, the Akatsuki have won the battle and earned themselves 120 experience for their success!</Font></b>", "Action.Output")
			M << output ("[M.name] has killed another shinobi. You have slain enough of these fools for now. Your squad has been awarded 30 bonus experience for their efforts!", "Action.Output")
			if(squad)
				for(var/mob/m in mobs_online)
					if(squad == m.GetSquad())
						m.exp += 30
						m.Levelup()
			else
				M.exp +=30
				M.Levelup()

			for(var/mob/m in mobs_online)
				var/squad/allsquads = m.GetSquad()
				spawn() m.client.UpdateCharacterPanel()
				if(allsquads)
					spawn() allsquads.RefreshMember(m)
			
			for(var/mob/m in mobs_online)
				if(m.village == VILLAGE_AKATSUKI)
					m.exp += 120
					m.Levelup()

		for(var/mob/npc/combat/white_zetsu/m)
			sleep(1)
			del m

		zetsu_count = 0
		sand_points = 0
		leaf_points = 0
		vill_lives_left = 5
		akat_lives_left = 0

obj
	zetsuspawn
		icon = 'placeholdertiles.dmi'
		icon_state = "zetsuspawn"
		New()
			..()
			src.icon_state = "blank"
