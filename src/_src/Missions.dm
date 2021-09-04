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
				view(M,13) << sound('Walk/man_fs_l_mt_drt.ogg',0,0,0,25)
				M.foot="Right"
			else
				view(M,13) << sound('Walk/man_fs_r_mt_drt.ogg',0,0,0,25)
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
									M.LevelStat("strength",rand(25,45),1)
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
											M.LevelStat("strength",rand(25,45),1)
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
									M.LevelStat("strength",rand(25,45),1)
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
								M.LevelStat("strength",rand(25,45),1)
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
										M.LevelStat("strength",rand(25,45),1)

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
								M.LevelStat("strength",rand(25,45),1)

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


mob
	Missions
		Bandit
			icon='WhiteMBase.dmi'
			name="Dangerous Bandit"
			village="Missing Nin"
			health=1500
			maxhealth=1500
			chakra=1500
			maxchakra=1500
			strength=80
			ninjutsu=80
			genjutsu=80
			dead=0
			var/hited=0
			var/ppunch="left"
			var/locc
			move=0
			proc
				Attack(mob/M)
					oview(10) << sound('Swing5.ogg',0,0,0,100)
					if(src.hited==1) return
					/*if(istype(M,/mob/White_Zettsu/))
						return*/
					src.dir=get_dir(src,M)
					if(ppunch=="left")
						ppunch="right"
						flick("punchl",src)
					if(ppunch=="right")
						ppunch="left"
						flick("punchr",src)
					M.DealDamage(src.strength*rand(3,6)-M.defence*2,src,"TaiOrange")
					M.UpdateHMB()
					//M.Death(src)
					src.hited=1
					sleep(10)
					src.hited=0

			Move()
				if(src.move==1||src.dead==1)
					return
				else
					..()


			proc/Combat()
				while(src.dead==0)
					if(src.health<=0)
						src.dead = 1
						Death(src)
					for(var/mob/M in view())
						if(!M.key||M.village==src.village||M.dead==1) continue
						step(src,M)
						if(get_dist(src,src.locc)>=12)
							flick('Shunshin.dmi',src)
							src.loc=src.locc
							goto skipt
						if(get_dist(src,M)>=3&&get_dist(src,M)<10)
							src.Flicker(M)
						sleep(5)
						if(get_dist(src,M)<=1)
							src.Attack(M)
						sleep(rand(1,2))
					skipt
					sleep(rand(6,9))
			proc/Flicker(mob/M)
				if(prob(3))
					view()<<"\yellow[src] says, \white'Say goodbye [M], you're dead now!'"
				else if(prob(3))
					view()<<"\yellow[src] says, \white'I'm taking you down [M]!'"
				else if(prob(3))
					view()<<"\yellow[src] says, \white'You can't kill me [M]!!! You're done for!'"
				sleep(2)
				src.dir=get_dir(src,M)
				view(src)<<sound('dash.wav',0,0)
				flick('Shunshin.dmi',src)
				sleep(2)
				step(src,src.dir)
				step(src,src.dir)
				step(src,src.dir)
				step(src,src.dir)
				step(src,src.dir)

mob/Missions/Bandit/New()
	src.health=src.maxhealth
	src.chakra=src.maxchakra
	src.icon_state=""
	var/s=rand(1,3)
	if(s==1)
		src.overlays+='Deidara.dmi'
	if(s==2)
		src.overlays+='Long.dmi'
	if(s==3)
		src.overlays+='Short.dmi'
	src.overlays+='Sandals.dmi'
	src.overlays+='Shirt.dmi'
	src.overlays+='Pants.dmi'
	src.overlays+='Gloves.dmi'
	src.locc=src.loc
	src.Combat()
	src.SetName(src.name)
mob/Missions/Bandit/Del()
	src.loc=null
	spawn(600*4)
		view()<<"\yellow[src] says, \white'Fear me! I have returned to kill you all !!!'"
		src.icon_state=""
		src.health=src.maxhealth
		src.chakra=src.maxchakra
		src.loc=src.locc
		src.dead=0
		src.move=0
