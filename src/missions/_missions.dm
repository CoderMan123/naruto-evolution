var/list/namesavaliable=list("Akirya","Obei","Tsunai","Amatsi","Ayumi","Emiraya","Aiko","Nevira","Onomari")
mob/var/tmp/list/Killed=list()
mob/var/tmp/Mission
mob/var/tmp/list/RecentVerbs=list()
mob/var/LastMissionTime=0

mob/proc/RecentVerbsCheck(var/verbs, var/timer, var/spam = 0)
	if(src.RecentVerbs[verbs])
		if(world.timeofday-RecentVerbs["[verbs]"] < timer)
			if(spam) src << output("You must wait before using this again.","Action.Output")
			return 1
	return 0
mob/proc/MissionCheck()
	if(src.LastMissionTime>0)
		src << output("You must wait [round(LastMissionTime/600)] minutes before taking another mission.","Action.Output")
		return 1
	return 0

obj/MissionObj
	var/xp
	var/MissionRyo=50

	byakuview=1
	icon='Flowers.dmi'
	layer=TURF_LAYER+3
	Entered(var/mob/M)
		if(istype(M,/mob))
			if(M.foot=="Left")
				M.PlayAudio('Walk/man_fs_l_mt_drt.ogg', output = AUDIO_HEARERS)
				M.foot="Right"
			else
				M.PlayAudio('Walk/man_fs_r_mt_drt.ogg', output = AUDIO_HEARERS)
				M.foot="Left"
	New()
		..()

	Del()
		var/Location=src.loc
		src.loc=locate(0,0,0)
		spawn(300)
		src.loc=Location

	Weeds
		icon_state="2"
		xp = 4

/*
		DblClick()
			if(get_dist(src,usr)>1) return
			if(findtext(usr.Mission,"Weeds"))
				usr<<output("You pick the weed, and crumple it up in your hand.","Action.Output")
				usr.Killed["Weeds"]++
				if(usr.Killed["Weeds"]==6)
					usr.Killed["Weeds"]=null
					usr.Mission=null
					var/MissionRyo=45
					var/MissionExp=4+WorldXp
					if(usr.Squad)
						var/mob/M
						M = getOwner(usr.Squad.Leader)
						M.ryo += (MissionRyo + 1)
						M<<output("You have gained [(MissionRyo + 1)] Ryo and [MissionExp] EXP from your mission!","Action.Output")
						M.exp+=MissionExp
						for(var/i=0,i<MissionExp,i++)
							var/GAIN = rand(1,3)
							switch(GAIN)
								if(1)
									M.LevelStat("Ninjutsu",rand(25,45),1)
									M.Levelup()
								if(2)
									M.LevelStat(SPECIALIZATION_TAIJUTSU,rand(25,45),1)
									M.Levelup()
								if(3)
									M.LevelStat("Genjutsu",rand(25,45),1)
									M.Levelup()
						for(var/i in usr.Squad.Members)
							if(getOwner(i))
								M = getOwner(i)
								if((M.client.inactivity/10)>=120) continue
								M.ryo += MissionRyo + 1
								M.exp+=MissionExp
								for(var/i2=0,i2<MissionExp,i2++)
									var/GAIN = rand(1,3)
									switch(GAIN)
										if(1)
											M.LevelStat("Ninjutsu",rand(25,45),1)
											M.Levelup()
										if(2)
											M.LevelStat(SPECIALIZATION_TAIJUTSU,rand(25,45),1)
											M.Levelup()
										if(3)
											M.LevelStat("Genjutsu",rand(25,45),1)
											M.Levelup()
								M<<output("<I><font color=blue>You gained [(MissionRyo + 1)] Ryo, and [MissionExp] EXP from your mission! Mission reset.","Action.Output")
								//M.Mission=null
								M.Levelup()
					else
						usr<<output("You have gained [MissionRyo] Ryo and [MissionExp] EXP from your mission! Mission reset.","Action.Output")
						usr.ryo+=MissionRyo
						usr.exp+=MissionExp
						var/mob/M = usr
						for(var/i=0,i<MissionExp,i++)
							var/GAIN = rand(1,3)
							switch(GAIN)
								if(1)
									M.LevelStat("Ninjutsu",rand(25,45),1)
									M.Levelup()
								if(2)
									M.LevelStat(SPECIALIZATION_TAIJUTSU,rand(25,45),1)
									M.Levelup()
								if(3)
									M.LevelStat("Genjutsu",rand(25,45),1)
									M.Levelup()
					usr.Levelup()
				del(src)
*/


	VesaiRoot
		name="VesaiRoot"
		icon_state="vesai"
		xp = 8

	Opal
		icon_state="opal"
		xp = 8

	DblClick()
		if(get_dist(src,usr)>1) return
		if(!findtext(usr.Mission,"[src.name]"))
			usr<<output("You shouldn't pick this up.","Action.Output")
			return
		if(findtext(usr.Mission,"[src.name]"))
			usr<<output("You pick up the [src.name].","Action.Output")
			usr.Killed["[src.name]"]++
			if(usr.Mission=="Collect [usr.Killed["[src.name]"]] [src.name]")
				usr.Killed["[src.name]"]=null
				if(usr.Tutorial==4)
					usr.Tutorial=5
					usr<<"Good job! You completed the mission. Now level your stats past 5 and take down a rogue shinobi!"
				usr.Mission=null
				var/MissionExp=src.xp+WorldXp
				if(usr.Squad)
					var/mob/M
					M = getOwner(usr.Squad.Leader)
					M.ryo += (MissionRyo + 1)
					M<<output("You have gained [(MissionRyo + 1)] Ryo and [MissionExp] EXP from your mission!","Action.Output")
					M.exp+=MissionExp
					for(var/i=0,i<MissionExp,i++)
						var/GAIN = rand(1,3)
						switch(GAIN)
							if(1)
								M.LevelStat("Ninjutsu",rand(25,45),1)
							if(2)
								M.LevelStat(SPECIALIZATION_TAIJUTSU,rand(25,45),1)
							if(3)
								M.LevelStat("Genjutsu",rand(25,45),1)

					for(var/i in usr.Squad.Members)
						if(getOwner(i))
							M = getOwner(i)
							if((M.client.inactivity/10)>=120) continue
							M.ryo += MissionRyo + 1
							M.exp+=MissionExp
							for(var/i2=0,i2<MissionExp,i2++)
								var/GAIN = rand(1,3)
								switch(GAIN)
									if(1)
										M.LevelStat("Ninjutsu",rand(25,45),1)

									if(2)
										M.LevelStat(SPECIALIZATION_TAIJUTSU,rand(25,45),1)

									if(3)
										M.LevelStat("Genjutsu",rand(25,45),1)

							M<<output("<I><font color=blue>You gained [(MissionRyo + 1)] Ryo, and [MissionExp] EXP from your mission! Mission reset.","Action.Output")
							//M.Mission=null
							M.Levelup()
				else
					usr<<output("You have gained [MissionRyo] Ryo and [MissionExp] EXP from your mission! Mission reset.","Action.Output")
					usr.ryo+=MissionRyo
					usr.exp+=MissionExp
					var/mob/M = usr
					for(var/i=0,i<MissionExp,i++)
						var/GAIN = rand(1,3)
						switch(GAIN)
							if(1)
								M.LevelStat("Ninjutsu",rand(25,45),1)

							if(2)
								M.LevelStat(SPECIALIZATION_TAIJUTSU,rand(25,45),1)

							if(3)
								M.LevelStat("Genjutsu",rand(25,45),1)
								
				usr.Levelup()
			del(src)

mob
	Test
		FakeMob
			icon='WhiteMBase.dmi'
			name="FakePlayer"
			village="Missing Nin"
			health=1500
			maxhealth=1500
			chakra=1500
			maxchakra=1500


