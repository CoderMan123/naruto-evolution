var/tmp/ChuuninExam=0
var/tmp/list/Chuunins=list()
var/tmp/mob/ChuuninOpponentOne
var/tmp/mob/ChuuninOpponentTwo
var/tmp/mob/ChuuninDuelWinner
var/tmp/mob/ChuuninDuelLoser
obj/Special/ChuuninExam
	icon='building insides.dmi'
	icon_state="paper"
	mouse_opacity=2
	var/list/Questions=list("Morning Peacock is a strength technique"=1,
	"Eight Trigrams 64 Palms requires no reaction commands."=2,
"Anbu are the right hand men and women of the akatsuki."=2,
"Ash Pile Burning is triggered with the down arrow."=1,
"The Genin exam was too easy."=1,
"Rasengan is a thunder element technique."=2,
"Sensatsu Suishou is an ice element technique."=1,
"Akatsuki are bounty hunters."=1,
"Heavenly Spin requires Byakugan active."=2,
"Sickle Weasel Slash is an earth element technique."=2,
"Gentle Fist can disable chakra points."=1,
"Bone Sensation only works if there is a Bone Bullet lodged in your enemy."=1,
"Multiple Shadow Clone Jutsu creates clones that can attack."=1,
"Chidori Nagashi is an earth element technique."=2,
"The skill tree is divided in non-clan, elemental, and clan jutsus."=1,
"Tsukuyomi is utilized by the Nara clan."=2,
"Susano'o is an Uchiha clan technique."=1,
"Aburame utilize ink drawings to attack enemies."=2,
"Jounin is the rank where higher levels are able to begin taking students."=1,
"Players will lose 50% of the experience points for killing a fellow villager."=1,
"The level requirement for the Genin Exams is 10."=2,
"D rank missions are easiest but give you the least ammount of experience."=1,
"B rank missions are assigned to Chuunin level shinobi."="True","An A rank mission may send you against enemy villagers."=1,
"The resting graphic will change according to your player's maximum chakra levels."=1)
	Click()
		if(get_dist(src,usr)>1) return
		var/QuestionNum
		var/CorrectAnswer=0
		var/InUse
		var/list/NewQuestions=Questions.Copy()
		if(usr.village=="Missing-Nin")usr<<output("You are a missing shinobi.","ActionPanel.Output")
		if(usr.rank!="Genin")
			usr<<output("You are not a Genin.","ActionPanel.Output")
			return
		if(ChuuninExam!="Written")
			usr<<output("The Chuunin examination has not begun, do not start too early.","ActionPanel.Output")
			return
		if(usr.level<=9)
			usr<<output("To achive Chuunin rank, you need to be at least level 10.","ActionPanel.Output")
			return
		if(InUse)
			usr<<output("Someone is already writing the exam here!","ActionPanel.Output")
			return
		if(usr.RecentVerbsCheck("Chuunin Test",6000,1)) return
		usr.RecentVerbs["Chuunin Test"]=world.timeofday
		InUse=1
		if(usr.level<25)
			while(QuestionNum<25)
				sleep(1)
				if(ChuuninExam!="Written")
					usr<<output("You have ran out of time!","ActionPanel.Output")
					InUse=0
					CorrectAnswer=0
					QuestionNum=0
					return
				var/Question=pick(NewQuestions)
				NewQuestions-=Question
				QuestionNum++
				if(usr.client.Alert("Question #[QuestionNum]: [Question]","Question [QuestionNum]",list("True","False"))=="[Questions[Question]]")
					CorrectAnswer++
		else
			usr << output("You don't have to take the written exam at your level.","ActionPanel.Output")
			usr << output("You have completed the test, please wait for the result.","ActionPanel.Output")
			CorrectAnswer=25
			usr.cheww=1
		if(CorrectAnswer>=17)
			usr<<output("You passed the test with [CorrectAnswer]/25 questions correct! You will now be taken to the Forest of Death.","ActionPanel.Output")
			usr.cheww=1
		else usr<<output("You failed the test with [CorrectAnswer]/25 questions correct.","ActionPanel.Output")
		while(ChuuninExam!="Forest of Death")sleep(10)
		InUse=0
		CorrectAnswer=0
		QuestionNum=0
mob/var/cheww=0
proc/ChuuninExam()
	while(world)
		sleep(600*240)
		if(chuuninlock==1)
			usr<<"Ninja War is in progress...please wait until it's over..."
			return
		ChuuninExam="Starting"
		world<<output("<b><center>A Chuunin exam will begin in 5 minutes.</b></center>","ActionPanel.Output")
		sleep(600*5)
		world<<output("<b><center>The Written Exam of the Chuunin exam has begun!</b></center>","ActionPanel.Output")
		ChuuninExam="Written"
		sleep(600*2)
		world<<output("<b><center>The Written Exam of the Chuunin exam is now over!</b></center>","ActionPanel.Output")
		ChuuninExam="Forest of Death"
		var/count=0
		for(var/mob/player/M in mobs_online)
			if(M.cheww==1)
				M.cheww=0
				M.loc = pick(block(locate(73,97,4),locate(198,161,4)))
				if(count==0)
					var/obj/O = new/obj/ChuuninExam/Scrolls/EarthScroll
					O.loc = M
					count=1
				else
					var/obj/O = new/obj/ChuuninExam/Scrolls/HeavenScroll
					O.loc = M
					count=0
		sleep(600*5)
		world<<output("<b><center>The Second Part of the Chuunin exam is now over!</b></center>","ActionPanel.Output")
		ChuuninExam="Tournament"
		ChuuninExamGo()
proc/ChuuninExamGo()
	//Remember to add a check for people here to see if they were in the FoD when it ended. Proper teleportation.
	for(var/mob/player/M in mobs_online)
		if(M.loc in block(locate(71,95,4),locate(200,163,4))) // If they are in FoD
			M.loc=M.MapLoadSpawn() // Remember to change depending on villages!
			for(var/obj/ChuuninExam/Scrolls/S in M)	del(S)
	for(var/mob/player/M in mobs_online)
		if(M.loc in block(locate(113,29,4),locate(146,58,4))) // If they are in tournament zone
			Chuunins+=M
			for(var/obj/ChuuninExam/Scrolls/S in M)del(S)
	if(Chuunins.len<2)
		for(var/mob/player/M in Chuunins)
			M.rank="Chuunin"
			var/squad/squad = M.GetSquad()
			if(squad)
				squad.Refresh()

			world<<output("<i>[M.name] is now a Chuunin.</i>","ActionPanel.Output")
			if(M.village=="Hidden Leaf") new/obj/Inventory/Clothing/Vests/ChuninVest(M)
			if(M.village=="Hidden Sand") new/obj/Inventory/Clothing/Vests/SandChuninVest(M)
			if(M.village=="Hidden Mist") new/obj/Inventory/Clothing/Vests/MistVest(M)
			if(M.village=="Hidden Sound") new/obj/Inventory/Clothing/Vests/SoundVest(M)
			if(M.village=="Hidden Rock") new/obj/Inventory/Clothing/Vests/RockVest(M)
			M.loc=M.MapLoadSpawn() // Remember to change depending on villages!
		world<<output("<b><center>The Chuunin exam is now over!</b></center>","ActionPanel.Output")
		ChuuninExam=0
		ChuuninDuelWinner=null
		ChuuninDuelLoser=null
		ChuuninOpponentOne=null
		ChuuninOpponentTwo=null
		Chuunins=list()
		return
	world<<output("<b><center>The tournament portion of the Chuunin exam has begun!</b></center>","ActionPanel.Output")
	while(Chuunins.len)
		if(Chuunins.len<2)
			for(var/mob/player/M in Chuunins)
				M.rank="Chuunin"
				var/squad/squad = M.GetSquad()
				if(squad)
					squad.Refresh()

				world<<output("<i>[M.name] is now a Chuunin.</i>","ActionPanel.Output")
				if(M.village=="Hidden Leaf") new/obj/Inventory/Clothing/Vests/ChuninVest(M)
				if(M.village=="Hidden Sand") new/obj/Inventory/Clothing/Vests/SandChuninVest(M)
				if(M.village=="Hidden Mist") new/obj/Inventory/Clothing/Vests/MistVest(M)
				if(M.village=="Hidden Sound") new/obj/Inventory/Clothing/Vests/SoundVest(M)
				if(M.village=="Hidden Rock") new/obj/Inventory/Clothing/Vests/RockVest(M)
				M.loc=M.MapLoadSpawn()//Teleportation here.
			world<<output("<b><center>The Chuunin exam is now over!</b></center>","ActionPanel.Output")
			//for(var/mob/Player/M in world)
				//Teleportation redundancy check here!
			ChuuninExam=0
			ChuuninDuelWinner=null
			ChuuninDuelLoser=null
			ChuuninOpponentOne=null
			ChuuninOpponentTwo=null
			Chuunins=list()
			return
		ChuuninOpponentOne=pick(Chuunins)
		ChuuninOpponentTwo=pick(Chuunins-ChuuninOpponentOne)
		ChuuninOpponentTwo.loc=locate(126,35,4)
		ChuuninOpponentOne.loc=locate(126,50,4)
		world<<output("<i><center>Match Beginning: [ChuuninOpponentOne] vs. [ChuuninOpponentTwo].</center></i>","ActionPanel.Output")
		for(var/obj/ChuuninExam/Barrier/O in world)O.invisibility=0 // Barriers up!
		var/timer=5
		while(timer)
			for(var/mob/player/M in Chuunins)M<<output("[timer]","ActionPanel.Output")
			ChuuninOpponentOne.move=0
			ChuuninOpponentTwo.move=0
			timer--
			sleep(10)
		for(var/mob/player/M in Chuunins)M<<output("GO!","ActionPanel.Output")
		ChuuninOpponentOne.move=1
		ChuuninOpponentTwo.move=1
		while(!ChuuninDuelWinner&&ChuuninOpponentOne&&ChuuninOpponentTwo)sleep(10)
		world<<output("<i><center>[ChuuninDuelWinner] has defeated [ChuuninDuelLoser] in the chuunin exams.</center></i>","ActionPanel.Output")
		world<<output("<i>[ChuuninDuelWinner.name] is now a Chuunin.</i>","ActionPanel.Output")
		if(ChuuninDuelWinner.village=="Hidden Leaf") new/obj/Inventory/Clothing/Vests/ChuninVest(ChuuninDuelWinner)
		if(ChuuninDuelWinner.village=="Hidden Sand") new/obj/Inventory/Clothing/Vests/SandChuninVest(ChuuninDuelWinner)
		if(ChuuninDuelWinner.village=="Hidden Mist") new/obj/Inventory/Clothing/Vests/MistVest(ChuuninDuelWinner)
		if(ChuuninDuelWinner.village=="Hidden Sound") new/obj/Inventory/Clothing/Vests/SoundVest(ChuuninDuelWinner)
		if(ChuuninDuelWinner.village=="Hidden Rock") new/obj/Inventory/Clothing/Vests/RockVest(ChuuninDuelWinner)
		ChuuninDuelWinner.rank="Chuunin"
		var/squad/squad = ChuuninDuelWinner.GetSquad()
		if(squad)
			squad.Refresh()
		ChuuninDuelWinner.loc=ChuuninDuelWinner.MapLoadSpawn()
		ChuuninDuelLoser.loc=ChuuninDuelLoser.MapLoadSpawn()
		Chuunins-=ChuuninDuelWinner
		Chuunins-=ChuuninDuelLoser
		ChuuninDuelWinner=null
		ChuuninDuelLoser=null
		ChuuninOpponentOne=null
		ChuuninOpponentTwo=null
		for(var/obj/ChuuninExam/Barrier/O in world)O.invisibility=99 // Barriers down!
		continue
	//for(var/mob/Player/M in world)
		//Redundancy check here (teleportation).
	world<<output("<b><center>The Chuunin exam is now over!</b></center>","ActionPanel.Output")
	ChuuninExam=0
	ChuuninDuelWinner=null
	ChuuninDuelLoser=null
	ChuuninOpponentOne=null
	ChuuninOpponentTwo=null
	Chuunins=list()
obj/ChuuninExam/
	//icon='ChuuninStuff.dmi' ICONZ GO HERE.
	Barrier
		icon_state="Barrier"
		invisibility=99
		density=1
	Scrolls
		layer=MOB_LAYER+1
		EarthScroll
			name="Earth Scroll"
			icon = 'chewninz.dmi'
			icon_state="Earth"
		HeavenScroll
			name="Heaven Scroll"
			icon = 'chewninz.dmi'
			icon_state="Heaven"
		Click()
			if(!ChuuninExam)
				usr<<output("You shouldn't pick this up.","ActionPanel.Output")
				return
			for(var/obj/ChuuninExam/Scrolls/Y in usr)
				if(Y.type==src.type)
					usr<<output("You already have one of these.","ActionPanel.Output")
					return
			if(usr.dead) return
			hearers()<<output("[usr] picks up [src].","ActionPanel.Output")
			Move(usr)
			var/EarthScroll
			var/HeavenScroll
			for(var/obj/ChuuninExam/Scrolls/O in usr)
				if(istype(O,/obj/ChuuninExam/Scrolls/EarthScroll))EarthScroll=1
				if(istype(O,/obj/ChuuninExam/Scrolls/HeavenScroll))HeavenScroll=1
			if(EarthScroll&&HeavenScroll)
				usr<<output("If you manage to hold on to both of these scrolls for 25 more seconds you will be teleported to the next area.","ActionPanel.Output")
				hearers() << output("[usr] has aquirred both scrolls.","ActionPanel.Output")
				sleep(250)
				var/EarthScroll1
				var/HeavenScroll1
				for(var/obj/ChuuninExam/Scrolls/X in usr)
					if(istype(X,/obj/ChuuninExam/Scrolls/EarthScroll))EarthScroll1=1
					if(istype(X,/obj/ChuuninExam/Scrolls/HeavenScroll))HeavenScroll1=1
				if(HeavenScroll1&&EarthScroll1)
					if(prob(50)) usr.loc=locate(144,44,4)
					else usr.loc=locate(115,44,4)
					world<<output("<i>[usr] has made it past the first portion of the Chuunin exam!</i>","ActionPanel.Output")
					usr<<output("Do not start killing. This is a tournament match.","ActionPanel.Output")
					for(var/obj/ChuuninExam/Scrolls/S in usr)del(S)
			return