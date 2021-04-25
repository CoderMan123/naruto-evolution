var/list/namesavaliable=list("Akirya","Obei","Tsunai","Amatsi","Ayumi","Emiraya","Aiko","Nevira","Onomari")
mob/var/tmp/list/Killed=list()
mob/var/tmp/Mission
mob/var/tmp/list/RecentVerbs=list()
mob/var/LastMissionTime=0
mob/var/MissionUp = 0

mob/proc/RecentVerbsCheck(var/verbs, var/timer, var/spam = 0)
	if(src.RecentVerbs[verbs])
		if(world.timeofday-RecentVerbs["[verbs]"] < timer)
			if(spam) src << output("You must wait before using this again.","ActionPanel.Output")
			return 1
	return 0
mob/proc/MissionCheck()
	if(src.LastMissionTime>0)
		src << output("You must wait [round(LastMissionTime/600)] minutes before taking another mission.","ActionPanel.Output")
		return 1
	return 0
mob/NPC
	move=0
	Move()return
	Death(killer)return
	MissionGuy
		density=0
		icon='WhiteMBase.dmi'
		health=500
		maxhealth=500
		Death()
			if(src.health<=0&&!dead)
				src.dead=1
				src.density=0
				src.icon_state="dead"
				spawn(600*5)
					src.health=maxhealth
					src.dead=0
					density=1
					src.icon_state=""
			..()
		NewStuff()
			if(!namesavaliable.len) del(src)
			name=pick(namesavaliable)
			namesavaliable-=name
			src.overlays += pick('Short.dmi','Short2.dmi','Short3.dmi')
			src.overlays += 'Shade.dmi'
			src.overlays+='Shirt.dmi'
		//	src.overlays+='Chunin Vest.dmi'
			src.overlays+='Sandals.dmi'
			src.Name(name)
			spawn() src.Stuff()
	DblClick()
		if(usr.dead) return
		if(get_dist(src,usr)>2) return
		if(usr.Mission=="Talk with [src.name]")
			usr.Mission=null
			usr.client.Alert("[src] says, Oh hello [usr.name].<br>You and [src] have a long talk, after it is over they hand you your reward. You have completed your mission!","[src]")
			var/MissionRyo=150
			var/MissionExp=6+WorldXp
			if(usr.Squad)
				var/mob/M
				M = getOwner(usr.Squad.Leader)
				M.Ryo += (MissionRyo + 1)
				M<<output("You have gained [(MissionRyo + 1)] Ryo and [MissionExp] EXP from your mission!","ActionPanel.Output")
				M.exp+=MissionExp
				for(var/i=0,i<MissionExp,i++)
					var/GAIN = rand(1,3)
					switch(GAIN)
						if(1)
							M.LevelStat("Ninjutsu",rand(20,35),1)
							M.Levelup()
						if(2)
							M.LevelStat("strength",rand(20,35),1)
							M.Levelup()
						if(3)
							M.LevelStat("Genjutsu",rand(20,35),1)
							M.Levelup()
				for(var/i in usr.Squad.Members)
					if(getOwner(i))
						M = getOwner(i)
						if((M.client.inactivity/10)>=120) continue
						M.Ryo += MissionRyo + 1
						M.exp+=MissionExp
						for(var/i2=0,i2<MissionExp,i2++)
							var/GAIN = rand(1,3)
							switch(GAIN)
								if(1)
									M.LevelStat("Ninjutsu",rand(20,35),1)
									M.Levelup()
								if(2)
									M.LevelStat("strength",rand(20,35),1)
									M.Levelup()
								if(3)
									M.LevelStat("Genjutsu",rand(20,35),1)
									M.Levelup()
						M<<output("<I><font color=blue>You gained [(MissionRyo + 1)] Ryo, and [MissionExp] EXP from your mission! Mission reset.","ActionPanel.Output")
						//M.Mission=null
						M.Levelup()
			else
				usr<<output("You have gained [MissionRyo] Ryo and [MissionExp] EXP from your mission! Mission reset.","ActionPanel.Output")
				usr.Ryo+=MissionRyo
				usr.exp+=MissionExp
				var/mob/M = usr
				for(var/i=0,i<MissionExp,i++)
					var/GAIN = rand(1,3)
					switch(GAIN)
						if(1)
							M.LevelStat("Ninjutsu",rand(20,35),1)
							M.Levelup()
						if(2)
							M.LevelStat("strength",rand(20,35),1)
							M.Levelup()
						if(3)
							M.LevelStat("Genjutsu",rand(20,35),1)
							M.Levelup()
			usr.Levelup()
			return
obj/MissionObj
	var/xp
	var/MissionRyo=50

	byakuview=1
	icon='Flowers.dmi'
	layer=TURF_LAYER+3
	Entered(var/mob/player/M)
		if(istype(M,/mob/player))
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
				usr<<output("You pick the weed, and crumple it up in your hand.","ActionPanel.Output")
				usr.Killed["Weeds"]++
				if(usr.Killed["Weeds"]==6)
					usr.Killed["Weeds"]=null
					usr.Mission=null
					var/MissionRyo=45
					var/MissionExp=4+WorldXp
					if(usr.Squad)
						var/mob/M
						M = getOwner(usr.Squad.Leader)
						M.Ryo += (MissionRyo + 1)
						M<<output("You have gained [(MissionRyo + 1)] Ryo and [MissionExp] EXP from your mission!","ActionPanel.Output")
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
								M.Ryo += MissionRyo + 1
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
								M<<output("<I><font color=blue>You gained [(MissionRyo + 1)] Ryo, and [MissionExp] EXP from your mission! Mission reset.","ActionPanel.Output")
								//M.Mission=null
								M.Levelup()
					else
						usr<<output("You have gained [MissionRyo] Ryo and [MissionExp] EXP from your mission! Mission reset.","ActionPanel.Output")
						usr.Ryo+=MissionRyo
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
			usr<<output("You shouldn't pick this up.","ActionPanel.Output")
			return
		if(findtext(usr.Mission,"[src.name]"))
			usr<<output("You pick up the [src.name].","ActionPanel.Output")
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
					M.Ryo += (MissionRyo + 1)
					M<<output("You have gained [(MissionRyo + 1)] Ryo and [MissionExp] EXP from your mission!","ActionPanel.Output")
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
							M.Ryo += MissionRyo + 1
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
							M<<output("<I><font color=blue>You gained [(MissionRyo + 1)] Ryo, and [MissionExp] EXP from your mission! Mission reset.","ActionPanel.Output")
							//M.Mission=null
							M.Levelup()
				else
					usr<<output("You have gained [MissionRyo] Ryo and [MissionExp] EXP from your mission! Mission reset.","ActionPanel.Output")
					usr.Ryo+=MissionRyo
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


mob/NPC/Mission_Lady//mission
	name = "Hokage's Secretary"
	icon='WhiteMBase.dmi'
	pixel_x=-15
	village="Hidden Leaf"
	density=1
	Move()return
	Death()return
	NewStuff()
		if(src.village=="Hidden Leaf")
			src.icon='Shizune-Leaf Secr.dmi'
			src.name="Shizune"
		if(src.village=="Hidden Sand")
			src.icon='Temari-Sand Secr.dmi'
			src.name="Temari"
		if(src.village=="Hidden Mist")
			src.icon='Ao-Mist Secr.dmi'
			src.name="Ao"
		if(src.village=="Hidden Sound")
			src.icon='Kabuto-Sound Secr.dmi'
			src.name="Kabuto"
		if(src.village=="Hidden Rock")
			src.icon='Kurotsuchi-Rock Secr.dmi'
			src.name="Kurotsuchi"
		if(src.village=="Anbu Root")
			src.icon='Sai-Root Secr.dmi'
			src.name="Sai"
		if(src.village=="Seven Swordsmen")
			src.icon='Kisame-Seven Swordsmen Secr.dmi'
			src.name="Kisame"
		if(src.village=="Akatsuki")
			src.icon='Zetsu.dmi'
			src.name="Zetsu"
		if(src.village=="Tutorial")
			src.icon='Hisho-Tut Secr.dmi'
			src.name="Hisho"

		src.Name(name)
		OriginalOverlays=overlays.Copy()
		spawn() src.Stuff()
	DblClick()
		if(usr.dead) return
		if(get_dist(src,usr)>2) return
		if(usr.Mission) return
		if(usr.MissionUp==1) return
		if(src.village=="Tutorial")
			goto TutSkip
		if(usr.village!=src.village)
			usr<<"You must be from the [village] to talk to this NPC."
			return
		TutSkip
		if(usr.MissionCheck()) return
		var/obj/missiontype=usr.CustomInput("Mission","Hello there. What rank mission would you like?",list("D","C","B","A","S"))
		if(!usr) return
		if(!missiontype) return
		if(!istype(missiontype)) return
		switch(missiontype.name)


			if("D")//Weeds, npc talks
				usr.MissionUp = 1
				var/obj/choices=usr.CustomInput("Choices","These are the options for D rank.",list("Weeding","Relay Message"))
				//var/list/choices=list("Weeding","Talk with Mission")
				var/choice
				var/text
				var/amount=rand(4,7)
				switch(choices.name)
					if("Weeding")
						var/obj/MissionObj/Weeds/W=new
						usr << browse_rsc(icon(W.icon,W.icon_state), "Weed.png")
						text="to get rid of those pesky weeds around the outside of the village, they're getting annoying. [amount] should be enough. They look like this: \icon[W] Do you accept this mission?"
						choice="Collect [amount] Weeds"
						del(W)
					if("Relay Message")
						if(usr.Tutorial<7)
							usr<<"You only have access to the Weeds mission while in the tutorial."
							usr.MissionUp=0
							return
						var/MissionGuys
						for(var/mob/NPC/MissionGuy/M in world)
							if(prob(30)) MissionGuys=M
						if(!MissionGuys)
							for(var/mob/NPC/MissionGuy/M in world)
								MissionGuys=M
						choice="Talk with [MissionGuys]"
						text="to talk with [MissionGuys], he has some information that could benefit the village.He should be around the village somewhere. Do you accept this mission?"
				if(usr.client.Alert("Great! Your mission is [text]","Mission",list("Accept","Decline"))==2)
					usr.MissionUp = 0
					return
				if(!usr)
					usr.MissionUp = 0
					return
				usr.Mission=choice
				if(usr.Mission=="Collect [amount] Weeds")
					usr<<browse({"<head>
<title>Extra Mission Info</title>
<FONT SIZE="7"><center><font color=white><b><u>Extra Mission Info</u></b></FONT>
<BODY BGCOLOR="#000000"><hr><br>
<font color=white>You are looking for this plant:<br><img src="Weed.png">"})
					winset(usr, null, {"
						BrowserWindow.is-visible = "true";
					"})
				usr.LastMissionTime=(600*7)
				usr.MissionUp = 0
				return



			if("C")
				usr.MissionUp = 1
				if(usr.rank=="Academy Student" || usr.level<13)
					usr.client.Alert("Sorry, you're too young to do this mission. Come back when you're a Genin and at least level 13.","Mission")
					usr.MissionUp = 0
					return
				var/list/choices=list(/obj/MissionObj/VesaiRoot/,/obj/MissionObj/Opal/*,"K.O a bandit"*/)
				var/choice=pick(choices)
				/*if(choice=="K.O a bandit")
					if(usr.client.Alert("Your mission is to knock out a troublesome bandit and teach him a lesson not to mess with local folks! Do you accept this mission?","Mission",list("Accept","Decline"))==2)
						usr.MissionUp = 0
						return
					if(!usr) return
					usr.Mission="K.O a bandit"
					goto skip*/
				var/obj/I=new choice
				usr << browse_rsc(icon(I.icon,I.icon_state), "[I].png")
				var/amount=rand(5,10)
				if(usr.client.Alert("Your mission is to collect [amount] [I](s) for our research. You can find them throughout the world. Do you accept this mission?","Mission",list("Accept","Decline"))==2)
					usr.MissionUp = 0
					return
				if(!usr)
					usr.MissionUp = 0
					return
				usr.Mission="Collect [amount] [I]"
				usr<<browse({"<head>
<title>Extra Mission Info</title>
<FONT SIZE="7"><center><font color=white><b><u>Extra Mission Info</u></b></FONT>
<BODY BGCOLOR="#000000"><hr><br>
<font color=white>You are looking for this object:<br><img src=[I].png>"})
				winset(usr, null, {"
						BrowserWindow.is-visible = "true";
					"})
				//skip
				usr.LastMissionTime=(600*7)
				usr.MissionUp = 0
				return



			if("B")//Rogue hunt
				usr.MissionUp = 1
				var/mob/choice
				if(usr.rank=="Genin"||usr.rank=="Academy Student")
					usr.client.Alert("Sorry, you're too young to do this mission. Come back when you're a Chuunin.","Mission")
					if(!usr)
						usr.MissionUp = 0
						return
					usr.MissionUp = 0
					return
				for(var/mob/player/M in mobs_online)
					if(M.village=="Missing-Nin"&&usr!=M)
						choice=M
						break
				if(!choice)
					usr.client.Alert("Sorry, we don't have a mission for you yet.","Mission")
					if(!usr)
						usr.MissionUp = 0
						return
					usr.MissionUp = 0
					return
				if(usr.client.Alert("Your mission is a special one, you are to hunt down and kill the Missing-Nin, [choice]. His last known location was at [choice.x],[choice.y],[choice.z]. Do you accept?","Mission",list("Accept","Decline"))==2)
					usr.MissionUp = 0
					return
				if(!usr)
					usr.MissionUp = 0
					return
				usr.Mission="Kill [choice] ([choice.ckey])"
				usr.LastMissionTime=(600*7)
				usr.MissionUp = 0
				return



			if("A")//Akat hunt
				usr.MissionUp = 1
				var/mob/choice
				if(usr.rank=="Genin"||usr.rank=="Academy Student"||usr.rank=="Chuunin")
					usr.client.Alert("Sorry, you're too young to do this mission. Come back when you're a Jounin.","Mission")
					if(!usr)
						usr.MissionUp = 0
						return
					usr.MissionUp = 0
					return
				for(var/mob/player/M in mobs_online)
					if(M.village=="Missing-Nin"&&usr!=M)
						choice=M
						break
					if(M&&M.rank=="Jounin"&&M.village!=usr.village&&usr!=M)
						choice=M
						break
					if(M&&VillageAttackers.Find(src.village)&&VillageDefenders.Find(M.village))
						choice=M
						break
					if(M&&VillageDefenders.Find(src.village)&&VillageAttackers.Find(M.village))
						choice=M
						break
				if(!choice)
					usr.client.Alert("Sorry, we don't have a mission for you yet.","Mission")
					if(!usr)
						usr.MissionUp = 0
						return
					usr.MissionUp = 0
					return
				if(usr.client.Alert("Greetings [usr.name]. Your mission today is that you are to hunt down and kill the [choice.rank] Ninja ([choice.village ? "[choice.village]" : ""]), [choice]. His last known location was at [choice.x],[choice.y],[choice.z]. Do you accept?","Mission",list("Accept","Decline"))==2)
					usr.MissionUp = 0
					return
				if(!usr)
					usr.MissionUp = 0
					return
				usr.Mission="Jounin Kill [choice] ([choice.ckey])"
				usr.LastMissionTime=(600*7)
				usr.MissionUp = 0
				return



			if("S")//Bijuu hunt
				usr.MissionUp = 1
				var/mob/choice
				if(usr.rank=="Genin"||usr.rank=="Academy Student"||usr.rank=="Chuunin" || usr.rank=="Jounin")
					usr.client.Alert("Sorry, this mission is only for Anbu.","Mission")
					if(!usr)
						usr.MissionUp = 0
						return
					usr.MissionUp = 0
					return
				if(usr.village == "Akatsuki"|| usr.village == "Seven Swordsmen")
					usr.client.Alert("Why would you want to hunt your fellow members?!")
					if(!usr)
						usr.MissionUp = 0
						return
					usr.MissionUp = 0
					return
				for(var/mob/player/M in mobs_online)
					if(M.village=="Akatsuki"&&usr!=M)
						choice=M
						break
					if(M.village=="Seven Swordsmen"&&usr!=M)
						choice=M
						break
				if(!choice)
					usr.client.Alert("Sorry, we don't have a mission for you yet.","Mission")
					if(!usr)
						usr.MissionUp = 0
						return
					usr.MissionUp = 0
					return
				if(usr.client.Alert("Greetings [usr.name]. Your mission today is that you are to hunt down and kill the [choice.rank] Ninja ([choice.village ? "[choice.village]" : ""]), [choice]. His last known location was at [choice.x],[choice.y],[choice.z]. Do you accept?","Mission",list("Accept","Decline"))==2)
					usr.MissionUp = 0
					return
				if(!usr)
					usr.MissionUp = 0
					return
				usr.Mission="Elite Kill [choice] ([choice.ckey])"
				usr.LastMissionTime=(600*7)
				usr.MissionUp = 0
				return





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
	Name(src.name)
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
