var/GeninTest=0
var/list/genintesters = list()
mob/var/tmp/SealsDoneGenin=0
turf
	geninexamsealstest
proc/GeninExam()
	while(world)
		sleep((600*30)+rand(200,400))
		for(var/mob/player/M in TotalPlayers)M<<output("<center>A Genin exam is about to begin in all Village Academies.</center>","ActionPanel.Output")
		sleep(600*3)
		for(var/mob/player/M in TotalPlayers)M<<output("<center>The Genin exam has begun!</center>","ActionPanel.Output")
		GeninTest=1
		sleep(600*2)
		for(var/mob/player/M in TotalPlayers)M<<output("<center>The written Genin exam is now over! Handseals testing will begin in one minute for all who passed!</center>","ActionPanel.Output")
		GeninTest=0
		sleep(100)
		for(var/mob/M in global.genintesters)M << output("You are to execute 3 of your ninjutsu or genjutsu within thirty seconds ignoring the indoors dialog telling you not to.","ActionPanel.Output")
		sleep(300)
		for(var/mob/M in global.genintesters)
			if(M.SealsDoneGenin>=3)
				M.SealsDoneGenin=0
				M.givegenin()
				M.loc=M.MapLoadSpawn()
			else M.loc=M.MapLoadSpawn()
		genintesters=list()
		for(var/mob/player/M in TotalPlayers)M<<output("<center>The practical examination for the Genin Exams are now over. Thank you for those that participated!</center>","ActionPanel.Output")
mob
	proc/givegenin()
		src<<output("You are now a Genin.","ActionPanel.Output")
		src.rank="Genin"
		if(village=="Hidden Leaf")
			new/obj/Inventory/Clothing/HeadWrap/LeafHeadBand(src)
		if(village=="Hidden Sand")
			new/obj/Inventory/Clothing/HeadWrap/SandHeadBand(src)
		if(village=="Hidden Mist")
			new/obj/Inventory/Clothing/HeadWrap/MistHeadBand(src)
		if(village=="Hidden Sound")
			new/obj/Inventory/Clothing/HeadWrap/SoundHeadBand(src)
		if(village=="Hidden Rock")
			new/obj/Inventory/Clothing/HeadWrap/RockHeadBand(src)

obj/Special/GeninExam
	icon='building insides.dmi'
	icon_state="paper"
	mouse_opacity=2
	var/village="Hidden Leaf"
	var/list/Questions=list("This exam requires you to be level 5 or higher"="True","Pheonix flower technique is a fire element technique"="True",
"Tsukuyomi is a technique utilized by the hyuga clan"="False","Senju clan majors in the use of puppets"="False","The Hokage's job is to take care of the leaf village"="True",
"If you are stuck in a location you shouldn't be, you can type in /stuck to teleport out"="True","You move with the arrow keys"="True",
"You can retake this exam if you fail it"="True","Chidori is a wind element technique"="False",
"To receive a mission, you talk to the banker of your village"="False","You started this game with Clone jutsu and Transformation jutsu"="True",
"You recieve a headband from passing this exam"="True","This exam is too easy"="True")
	Click()
		if(get_dist(src,usr)>1) return
		var/QuestionNum
		var/CorrectAnswer=0
		var/InUse
		var/list/NewQuestions=Questions.Copy()
		if(usr.village!=village)
			usr<<output("You are not apart of this village.","ActionPanel.Output")
			return
		if(usr.rank!="Academy Student")
			usr<<output("You are not an Academy Student.","ActionPanel.Output")
			return
		if(!GeninTest)
			usr<<output("The Genin Exam has not begun, do not start too early.","ActionPanel.Output")
			return
		if(usr.level<5)
			usr<<output("You must be level 5 more higher to write the Genin exam.","ActionPanel.Output")
			return
		if(InUse)
			usr<<output("Someone is already writing the exam here!","ActionPanel.Output")
			return
		if(usr.RecentVerbsCheck("Genin Test",6000,1)) return
		usr.RecentVerbs["Genin Test"]=world.timeofday
		InUse=1
		while(QuestionNum<10)
			sleep(1)
			if(!GeninTest)
				usr<<output("You have ran out of time!","ActionPanel.Output")
				QuestionNum=0
				CorrectAnswer=0
				return
			var/Question=pick(NewQuestions)
			NewQuestions-=Question
			QuestionNum++
			if(usr.skalert("Question #[QuestionNum]: [Question]","Question [QuestionNum]",list("True","False"))=="[Questions[Question]]")
				CorrectAnswer++
		usr<<output("You have completed the test, please wait for the result.","ActionPanel.Output")
		while(GeninTest)
			sleep(10)
		if(CorrectAnswer>=7)
			usr<<output("You passed the test with [CorrectAnswer]/10 questions correct! You will now be taken to the handseals testing.","ActionPanel.Output")
			usr.loc = locate(/turf/geninexamsealstest)
			global.genintesters+=usr
		else usr<<output("You failed the test with [CorrectAnswer]/10 questions correct.","ActionPanel.Output")
		InUse=0
		QuestionNum=0
		CorrectAnswer=0