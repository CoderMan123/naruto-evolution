mob
	White_Zettsu
		icon='zettsu.dmi'
		Names="White Zettsu"
		health=1000
		maxhealth=1000
		var/killed=0
		var/oloc
		var/hited=0
		move=0
		Bump(mob/M)
			var/ppunch="left"
			if(src.hited==1) return
			if(istype(M,/mob/White_Zettsu/))
				return
			if(istype(M,/mob/player/))
				if(ppunch=="left")
					ppunch="right"
					flick("punchl",src)
				if(ppunch=="right")
					ppunch="left"
					flick("punchr",src)
				M.health-=350-M.defence//Change to DealDamage()
				M.UpdateHMB()
				M.Death(src)
				src.hited=1
				sleep(10)
				src.hited=0
		Move()
			if(src.move==1)
				return
			else
				..()
mob/White_Zettsu/proc/Respawn()
	src.loc=null
	spawn(600)
	src.loc=src.oloc
	src.killed=0
	src.health=src.maxhealth
	spawn(1)   src.CombatAI()
	return ..()

mob/White_Zettsu/New()
	/*if(src.killed==1)
		src.loc=null
		spawn(60)//was 600. testing
		src.loc=src.oloc
		src.killed=0
	else*/
		src.health=src.maxhealth
		src.oloc=src.loc
		spawn(1)   src.CombatAI()
		return ..()
mob/White_Zettsu/proc/CombatAI()
	while(src)
		if(src.health<=0)
			src.killed=1
			src.Respawn()
			return
		src.Move()
		for(var/mob/M in oview())
			if(istype(M,/mob/White_Zettsu/))
				continue
			if(M.village=="Akatsuki"||M.village=="Seven Swordsmen")
				continue
			if(M.dead==1)
				continue
			else
				step_towards(src,M)
				if(get_dist(src,M)<=1)
					Bump(M)
		sleep(4)

obj
	zettsuspawn
		var/filled=0

var
	lock=1
	chuuninlock=0
	wartype=null
	eventtype=null
	akatpoints=0
	sforcepoints=0
mob
	var
		joinedwar=0
		joinedevent=0
		joinedakatshinobiw=0
		pvppoints=0
	Admin
		verb
			Host_Great_Ninja_War_Event()
				set category = "StaffEvent"
				/*src<<"Disabled this until I fix it fully.  ~Vik"
				return*/
				if(chuuninlock==1)
					return
				world<<"<font size = 2><font color=white>[usr] started Great Ninja War Event ! Join !"
				lock=0
				chuuninlock=1
				wartype="NINJA WAR"
			Host_Allied_Shinobi_War()
				set category = "StaffEvent"
				/*src<<"Disabled this until I fix it fully.  ~Vik"
				return*/
				if(chuuninlock==1)
					return
				world<<"<font size = 2><font color=red>Akatsuki and Allied Shinobi Forces have as of now started a war! All persons above level 30 will enter the war regardless of their will!"
				for(var/mob/M in TotalPlayers)
					if(M.village=="Akatsuki"||M.village=="Seven Swordsmen")
						M.joinedakatshinobiw=1
						world<<"[M] joined to fight for Akatsuki against Allied Shinobi Force!"
						M.loc=locate(92,22,19)//akatsuki side location
					else
						if(M.level>=30)
							M.joinedakatshinobiw=1
							world<<"[M] joined to fight for Allied Shinobi Force against Akatsuki!"
							M.loc=locate(41,81,19)//allied shinobi side
				for(var/obj/zettsuspawn/A in TotalPlayers)
					if(A:filled==0)
						var/mob/White_Zettsu/B=new/mob/White_Zettsu
						B.loc=A:loc
						A:filled=1
				//var/M=new/mob/White_Zettsu()
				/*for(var/l=1,l<15,l++)
					M:loc=locate(3,3,3)//zettsu spawning point
					step_rand(M)*/
				chuuninlock=1
				wartype="AKATSUKI WAR"

			Close_Great_Ninja_War_Event()
				set category = "StaffEvent"
				lock=1
				chuuninlock=0
				world<<"[src] closes down Great Ninja War event, all of those who joined it will be teleported back to their own villages."
				world<<"Last results are : Sand Village:[sandwarpoints],Mist Village:[mistwarpoints],Sound Village:[soundwarpoints],Leaf Village:[leafwarpoints],Rock Village:[rockwarpoints],Anbu Root:[rootwarpoints],Seven Swordsmen:[ssmwarpoints],Missing Ninjas:[missingwarpoints],Akatsuki:[akatwarpoints]!."
				CheckWarWinner()
				for(var/mob/M in TotalPlayers)
					if(M.village=="Hidden Leaf"&&M.joinedwar==1)
						M.loc = locate(116,127,18)
					if(M.village=="Hidden Sand"&&M.joinedwar==1)
						M.loc = locate(91,132,10)
					if(M.village=="Hidden Mist"&&M.joinedwar==1)
						M.loc = locate(130,87,8)
					if(M.village=="Hidden Sound"&&M.joinedwar==1)
						M.loc = locate(140,28,6)
					if(M.village=="Hidden Rock"&&M.joinedwar==1)
						M.loc = locate(21,13,16)
					if(M.village=="Anbu Root"&&M.joinedwar==1)
						M.loc = locate(116,127,18)//They can go to leaf for now.
					if(M.village=="Akatsuki"&&M.joinedwar==1)
						M.loc = locate(100,101,17)
					if(M.village=="Seven Swordsmen"&&M.joinedwar==0)
						M.loc = locate(130,87,8)//They can just go to mist for now.

					M.joinedwar=0
					sandwarpoints=0
					mistwarpoints=0
					leafwarpoints=0
					soundwarpoints=0
					rockwarpoints=0
					ssmwarpoints=0
					rootwarpoints=0
					missingwarpoints=0
					akatwarpoints=0
				chuuninlock=0
				wartype=null
			Close_Allied_Shinobi_War()
				set category = "StaffEvent"
				chuuninlock=0
				wartype=null
				for(var/mob/M in TotalPlayers)
					if(M.joinedakatshinobiw==1)
						M.joinedakatshinobiw=0
						if(M.village=="Akatsuki")
							M.loc=locate(100,101,17)//akathideout
						if(M.village=="Seven Swordsmen")
							M.loc = locate(130,87,8)//They can just go to mist for now.
						if(M.village=="Anbu Root")
							M.loc = locate(116,127,18)//They can go to leaf for now.
						if(M.village=="Hidden Leaf")
							M.loc = locate(116,127,18)
						if(M.village=="Hidden Sand")
							M.loc = locate(91,132,10)
						if(M.village=="Hidden Mist")
							M.loc = locate(91,132,10)
						if(M.village=="Hidden Sound")
							M.loc = locate(140,28,6)
						if(M.village=="Hidden Rock")
							M.loc = locate(21,13,16)
				if(akatpoints>sforcepoints)
					world<<"<font color=red><font size=3>Akatsuki are victorious!"
				if(akatpoints<sforcepoints)
					world<<"<font color=red><font size=3>Allied Shinobi Force is victorious!"
				for(var/obj/zettsuspawn/A in world)
					if(A:filled==1)
						var/mob/White_Zettsu/B
						if(B in A:loc)
							del(B)
							A:filled=0
	verb
		JoinEvent()
			set hidden = 1
			if(usr.level<=5)
				usr<<"Your level is too low for participating!"
				return
			if(eventtype==null)
				usr<<"No event in progress."
				return

	verb
		JoinWar()
			set hidden = 1
			if(usr.level<=5)
				usr<<"You are too low level to participate!"
				return
			if(wartype=="AKATSUKI WAR")
				goto akatwar
			if(wartype=="NINJA WAR")
				goto ninjawar
			if(wartype==null)
				usr<<"No war in progress. Try again later."
				return
			ninjawar
			if(lock==0&&usr.joinedwar==0)
				if(!key) return
				if(!usr.village=="Hidden Leaf"&&!usr.village=="Hidden Sand"&&!usr.village=="Hidden Mist"&&!usr.village=="Hidden Sound"&&!usr.village=="Hidden Rock")
					src<<"You don't have a village. You can't join war."
					return
				usr.loc = pick(block(locate(71,95,4),locate(200,163,4)))
				world<<"[usr] joined war to fight for [village] side!"
				usr.joinedwar=1
			if(lock==1)
				usr<<"Great Ninja War hasn't started yet."
			if(lock==0&&usr.joinedwar==1)
				usr<<"You already joined war!"
			if(lock==1&&usr.joinedwar==1)
				usr<<"Use '/stuck' to teleport out of Great Ninja War Event if you are stuck in it."
			return
			akatwar
			if(usr.joinedakatshinobiw==1)
				usr<<"You already joined this war!"
			else
				if(usr.level<30)
					var/sure=CustomInput("Great War","Are you sure you want to join Akatsuki vs Shinobi Force War?",list("Yes","No"))
					if(sure=="Yes")
						usr.joinedakatshinobiw=1
						if(usr.village=="Akatsuki")
							world<<"[usr] joined to fight for [usr.village] in war against Allied Shinobi Force !"
							usr.loc=locate(92,2,19)//akatsuki side
						else
							world<<"[usr] joined to fight for [usr.village] in war against Akatsuki !"
							usr.loc=locate(41,81,19)//allied shinobi side
var
	sandwarpoints=0
	mistwarpoints=0
	leafwarpoints=0
	soundwarpoints=0
	missingwarpoints=0
	rootwarpoints=0
	ssmwarpoints=0
	akatwarpoints=0
	rockwarpoints=0
proc
	CheckWarWinner()
		if(sandwarpoints>mistwarpoints && sandwarpoints>leafwarpoints && sandwarpoints>soundwarpoints && sandwarpoints>missingwarpoints && sandwarpoints>akatwarpoints && sandwarpoints>rockwarpoints && sandwarpoints>rootwarpoints && sandwarpoints>ssmwarpoints)
			world<<"<font size=4>Winner of this war is Sand Village !"
			return
		if(mistwarpoints>sandwarpoints && mistwarpoints>leafwarpoints && mistwarpoints>soundwarpoints && mistwarpoints>missingwarpoints && mistwarpoints>akatwarpoints && mistwarpoints>rockwarpoints && mistwarpoints>rootwarpoints && mistwarpoints>ssmwarpoints)
			world<<"<font size=4>Winner of this war is Mist Village !"
			return
		if(leafwarpoints>mistwarpoints && leafwarpoints>sandwarpoints && leafwarpoints>soundwarpoints && leafwarpoints>missingwarpoints && leafwarpoints>akatwarpoints && leafwarpoints>rockwarpoints && leafwarpoints>rootwarpoints && leafwarpoints>ssmwarpoints)
			world<<"<font size=4>Winner of this war is Leaf Village !"
			return
		if(soundwarpoints>mistwarpoints && soundwarpoints>leafwarpoints && soundwarpoints>sandwarpoints && soundwarpoints>missingwarpoints && soundwarpoints>akatwarpoints && soundwarpoints>rockwarpoints && soundwarpoints>rootwarpoints && soundwarpoints>ssmwarpoints)
			world<<"<font size=4>Winner of this war is Sound Village !"
			return
		if(missingwarpoints>mistwarpoints && missingwarpoints>leafwarpoints && missingwarpoints>sandwarpoints && missingwarpoints>akatwarpoints && missingwarpoints>rockwarpoints && missingwarpoints>soundwarpoints && missingwarpoints>rootwarpoints && missingwarpoints>ssmwarpoints)
			world<<"<font size=4>Winner of this war is Missing Ninjas !"
			return
		if(akatwarpoints>mistwarpoints && akatwarpoints>leafwarpoints && akatwarpoints>sandwarpoints && akatwarpoints>rockwarpoints && akatwarpoints>soundwarpoints && akatwarpoints>missingwarpoints && akatwarpoints>rootwarpoints && akatwarpoints>ssmwarpoints)
			world<<"<font size=4>Winner of this war is Akatsuki !"
			return
		if(rockwarpoints>mistwarpoints && rockwarpoints>leafwarpoints && rockwarpoints>sandwarpoints && rockwarpoints>akatwarpoints && rockwarpoints>soundwarpoints && rockwarpoints>missingwarpoints && rockwarpoints>rootwarpoints && rockwarpoints>ssmwarpoints)
			world<<"<font size=4>Winner of this war is Rock Village !"
			return
		if(rootwarpoints>mistwarpoints && rootwarpoints>leafwarpoints && rootwarpoints>sandwarpoints && rootwarpoints>akatwarpoints && rootwarpoints>soundwarpoints && rootwarpoints>missingwarpoints && rootwarpoints>rockwarpoints && rootwarpoints>ssmwarpoints)
			world<<"<font size=4>Winner of this war is Anbu Root !"
			return
		if(ssmwarpoints>mistwarpoints && ssmwarpoints>leafwarpoints && ssmwarpoints>sandwarpoints && ssmwarpoints>akatwarpoints && ssmwarpoints>soundwarpoints && ssmwarpoints>missingwarpoints && ssmwarpoints>rootwarpoints && ssmwarpoints>rockwarpoints)
			world<<"<font size=4>Winner of this war is Seven Swordsmen !"
			return

		else
			world<<"No war winner."