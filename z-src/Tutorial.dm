//1:Interface
//2:Str training,Mentions agility and targetting.
//3:Jutsus, skill tree, drag and drop hotkeys.
//4:Misc. Send to do mission.
//5:Weeds mission
//6:Kill a rogue
//7:Done
mob/var/Tutorial=0
mob/var/tmp/TutorialStrength=0
mob/var/tutorialskilltree=0
obj/Tutorial
	ClickMe
		icon='Misc Effects.dmi'
		icon_state="ClickMe"
		density=0
		layer=999
mob/npc
	Tutorial
		name="Jounin"
		density=1
		Move()return
		Death()return
		New()
			src.overlays += pick('Short.dmi','Short2.dmi','Short3.dmi')
			src.overlays+='Shirt.dmi'
			src.overlays+='Sandals.dmi'
			src.overlays+='Chunin Vest.dmi'
			spawn() src.RestoreOverlays()
			density=1
			..()
			
		Starting_Jounin
			icon='WhiteMBase.dmi'
			//var/message
			Tutorial=0
			density=1
			DblClick()
				if(src.conversations.Find(usr)) return 0
				if(usr.Tutorial < Tutorial)
					usr<<output("You're not supposed to talk to this Jounin yet.","Action.Output")
					return
				if(usr.Tutorial > Tutorial)
					usr<<output("I've done my part. Go ahead and move on to the next room.","Action.Output")
					return
				if(usr.dead)return
				if(get_dist(src,usr)>2)return
				src.conversations.Add(usr)
				if(usr)
					usr.client.prompt(
						{"Hey there, welcome to Naruto Evolution. Please take a moment to complete the tutorial."}, "[src]")

				if(usr)
					usr.client.prompt(
						{"First, you should have a look at the interface. The \"Chat\" button at the bottom left will toggle your chatbox. Next to it is the \"Channel\" button.
						This will cycle you through the different channels you can chat in."}, "[src]")

				if(usr)
					usr.client.prompt(
						{"The action output box on the bottom right of your screen will keep you informed of what is currently happening throughout the game, as well as the controls for the game when you first log in."}, "[src]")

				if(usr)
					usr.client.prompt(
						{"Click on settings in the bottom right hand corner of the screen.
						Please take a moment to look at the Community Guidelines either now or at some other point for more information on the rules and etiquettes of Naruto Evolution."}, "[src]")

				if(usr)
					usr.client.prompt(
						{"If you're looking to become the next hokage or maybe the leader of the villainous Akatsuki, you can refer to the Ninja Handbook for rules on challenging Kages and Akatsuki."}, "[src]")

				if(usr)
					usr.client.prompt(
						{"Your health and chakra bar is located at the top left of the screen, if your jutsus are on cooldown they'll appear to the right of the screen."}, "[src]")

				if(usr)
					usr.client.prompt(
						{"Pressing I will bring up your inventory, O will bring up your Statpanel, and P will bring up your Jutsus, but more on this later."}, "[src]")
				
				if(usr)
					usr.client.prompt(
						{"Please move on to the next room and speak with the Jounin there once you feel comfortable with the interface."}, "[src]")

				if(usr)
					usr.Tutorial=1
					src.conversations.Remove(usr)
		JouninOne
			icon='WhiteMBase.dmi'
			//var/message
			Tutorial=1
			density=1
			DblClick()
				if(src.conversations.Find(usr)) return 0
				if(!usr.TutorialStrength) usr.TutorialStrength=usr.taijutsu
				if(usr.Tutorial < Tutorial)
					usr<<output("You're not supposed to talk to this Jounin yet.","Action.Output")
					return
				if(usr.Tutorial > Tutorial)
					usr<<output("I've done my part. Go ahead and move on to the next room.","Action.Output")
					return
				if(usr.taijutsu<=usr.TutorialStrength)
					if(usr.dead) return
					if(get_dist(src,usr)>2) return
					src.conversations.Add(usr)
					if(usr)
						usr.client.prompt(
							{"[src]: Hey you're looking pretty weak for a Ninja. Why don't you go hit some of those dummies over there and get some meat on your bones."}, "[src]")

					if(usr)
						usr.client.prompt(
							{"Use A to punch and watch the action output on the bottom right, or open your statpanel(O) to see when your stats level up."}, "[src]")

					if(usr)
						usr.client.prompt(
							{"Watch out for when the dummy flashes! That means it's going to spin around violently. You'll need to defend by holding D otherwise you might get hurt."}, "[src]")

					if(usr)
						usr.client.prompt(
							{"Speak to me again when your Taijutsu has leveled up."}, "[src]")
						src.conversations.Remove(usr)
						return

				if(usr.dead)return
				if(get_dist(src,usr)>2)return
				src.conversations.Add(usr)
				if(usr) usr.client.prompt(
					{"[src]: Welcome back. I see you look a bit out of breath. That's good, it means your hard work is making you stronger."}, "[src]")
				
				if(usr)
					usr.client.prompt(
						{"You can also gain taijutsu experience climbing mountains by dodging(D) while walking into a cliff side."}, "[src]")

				if(usr)
					usr.client.prompt(
						{"You'll want to work on your speed as well. You'll be able to punch faster the more agility you have."}, "[src]")

				if(usr)
					usr.client.prompt(
						{"You can raise your agility by running around, swimming and dodging certain projeciles or punches. You can even buy some weights from the weapons shop to help with your training."}, "[src]")

				if(usr)
					usr.client.prompt(
						{"You might have noticed an arrow above that target dummy. This means you were targeting it. When you punch you'll automatically target a neaby combatent. You'll need to a target to be able to use most jutsu and it's significantly easier to hit others."},"[src]")

				if(usr)
					usr.client.prompt(
						{"You can also press TAB to target someone nearby or to cycle through targets. SHIFT+TAB will remove your target allowing you to manually aim certain jutsu."}, "[src]")

				if(usr)
					usr.client.prompt(
						{"In this game you don't want to let people target you easily. In the next room my colleague will teach you a few tricks to dealing with enemies trying to target you."}, "[src]")

				if(usr)
					usr.client.prompt(
						{"You should head on through and speak with him."}, "[src]")

				if(usr)
					usr.Tutorial=2
					src.conversations.Remove(usr)
		JouninTwo
			icon='WhiteMBase.dmi'
		//	var/message
			Tutorial=2
			density=1
			DblClick()
				if(src.conversations.Find(usr)) return 0
				if(usr.Tutorial < Tutorial)
					usr<<output("You're not supposed to talk to this Jounin yet.","Action.Output")
					return
				if(usr.Tutorial > Tutorial)
					usr<<output("I've done my part. Go ahead and move on to the next room.","Action.Output")
					return
				if(usr.dead)return
				if(get_dist(src,usr)>2)return
				src.conversations.Add(usr)
				if(usr) usr.client.prompt({"Hey there, I am the Ninjutsu trainer. I'll teach you how to learn new jutsu as well as some basic techniques that even the strongest of ninja use!"},"[src]")

				if(usr)
					usr.client.prompt(
						{"I see you already know a couple jutsu. You can use a jutsu by pressing the right combination of handseals in the right order and then pressing the spacebar to activate it."}, "[src]")

				if(usr)
					usr.client.prompt(
						{"You'll find a list of all of your jutsu and their handseal conbinations by pressing the 'Jutsus' button in the bottom right. Give it a try!"}, "[src]")

				if(usr)
					usr.client.prompt(
						{"Eventually, you will master your jutsu if you use them enough. This means you can use them instantly without having to weave the seals!"},"[src]")

				if(usr)
					usr.client.prompt(
						{"Once you have mastered it's seals, you will be able to drag it on down to your hotbar by accessing your jutsu list by pressing P. Some Jutsu don't require seals at all and can be hotkeyed right from the start!"}, "[src]")

				if(usr)
					usr.client.prompt(
						{"Another important factor in training Ninjutsu is the levels each technique has."},"[src]")

				if(usr)
					usr.client.prompt(
						{"Most techniques will have a mastery level, and it will influence the technique in certain ways depending on it's level growing significantly stronger."}, "[src]")

				if(usr)
					usr.client.prompt(
						{"Through using the technique, you will be able to gain experience to increase it's mastery level. You can view the levels of your Jutsu via the 'Jutsu' button in the bottom right."}, "[src]")

				if(usr)
					usr.client.prompt(
						{"Some jutsus increase in damage while others will fire more projectiles or have longer effects. Substitution even grants Advanced substitution when leveled enough."}, "[src]")

				if(usr)
					usr.client.prompt(
						{"Oh that's right there's a few jutsu you will definately want to know how to use. Clone jutsus and Substitution jutsus will be integral to your survival as they'll both cause people around you to stop targeting yourself and your teammates."},"[src]")

				if(usr)
					usr.client.prompt(
						{"I see you already have a simple clone jutsu which will create clones that help block the enemy from targeting you, causing them to often target the clones instead. But that won't be enough."}, "[src]")

				if(usr)
					usr.Tutorial=3
					usr.client.prompt(
						{"How about you open the skill tree with the button in the bottom left so that you can learn a Substitution."}, "[src]")

				if(usr)
					usr.client.prompt(
						{"Select Non-clan from the list and purchase Body Replacement Jutsu by clicking it's icon in the top left. As well as dropping peoples targets, Body Replacement will also move you back sharply to avoid danger leaving behind a solid substituion to block potential threats."}, "[src]")

				if(usr)
					usr.client.prompt(
						{"When you use it you'll also gain the ability to use Advanced Body Replacement. This is a special subsitution that once used will designate a target location. The next time you defend with the D key you'll be teleported back to that location, leaving behind a log."}, "[src]")

				if(usr)
					usr.client.prompt(
						{"So long as the jutsu has been set, you can even use it while trapped by an opponents jutsu to escape!"}, "[src]")

				if(usr)
					usr.client.prompt(
						{"One last thing. Using your jutsu will also level up certain stats. It's a good method for getting stronger."},"[src]")

				if(usr)
					usr.client.prompt(
						{"However, an alternative for Ninjutsu and Genjutsu is to perform chakra control training. You should be able to find it in your jutsus list by pressing P."}, "[src]")

				if(usr)
					usr.client.prompt(
						{"Face the correct direction in time and your Ninjutsu and Genjutsu will get a little stronger. The more successes in a row, the greater the growth!"}, "[src]")

				if(usr)
					usr.client.prompt(
						{"You can tell how well you are doing by how powerful your chakra aura is while you're training in this way."}, "[src]")

				if(usr)
					usr.client.prompt(
						{"Additionally if you are Ninjutsu or Genjutsu specialization, you'll gain a bonus towards training that stat during chakra control training."}, "[src]")

				if(usr)
					usr.client.prompt(
						{"Once you've bought Body Replacement jutsu feel free to try out everything I've taught you here but besides that you can move on to the next room."}, "[src]")

				if(usr)
					usr.Tutorial=4
					src.conversations.Remove(usr)
					usr<<"Please open up your skill tree before continuing and purchase the Substitution Technique, under Non Clan Skills."

		Ending_Jounin
			icon='WhiteMBase.dmi'
			Tutorial=4
			density=1
		//	var/message
			DblClick()
				if(src.conversations.Find(usr)) return 0
				if(!usr.tutorialskilltree)
					usr<<"Open up your skill tree first, and purchase the Substitution Technique under Non Clan Skills."
					return
				if(!typesof(/obj/Jutsus/BodyReplace) in usr.jutsus_learned)
					usr<<"Open up your skill tree first, and purchase the Substitution Technique under Non Clan Skills."
					return
				if(usr.Tutorial < Tutorial)
					usr<<output("You're not supposed to talk to this Jounin yet.","Action.Output")
					return
				if(usr.Tutorial > Tutorial)
					usr<<output("You're all set! Make your way into the world through the doorway in front of me to begin your journey.","Action.Output")
					return
				if(usr.dead)return
				if(get_dist(src,usr)>2)return
				if(usr) src.conversations.Add(usr)//Tell to do a mission.
				if(usr)
					usr.client.prompt(
						{"Hi there, so I bet you've been wondering about Precision and Genjutsu right? Well I'm here to tell you all about them."},"[src]")

				if(usr)
					usr.client.prompt(
						{"Precision is your ability to land precise projectiles and weapons and Genjutsu is the use of illusion techniques."}, "[src]")

				if(usr)
					usr.client.prompt(
						{"There are some Genjutsu around which can be completely crippling for it's victim if they don't have the proper defences."}, "[src]")

				if(usr)
					usr.client.prompt(
						{"You can both increase the potency of your Genjutsu and protect yourself against them by leveling this stat."}, "[src]")

				if(usr)
					usr.client.prompt(
						{"As for Precision, using ninja tools will be your primary way of improving. You can use them by clicking on one in your inventory to equip them and pressing the S key."},"[src]")

				if(usr)
					usr.client.prompt(
						{"It costs money to purchase weapons from the shop but it's worth it for the power they can provide you in combat."}, "[src]")

				if(usr)
					usr.client.prompt(
						{"Like all the other stats certain jutsu will scale off Precision and level it up too. Useful if you want to train it but you're low on cash. Agility will also increase the rate you can use them."},"[src]")

				if(usr)
					usr.client.prompt(
						{"It's a dangerous world out there kiddo. Make sure once you leave this place you seek the help of your fellow villagers."},"[src]")

				if(usr)
					usr.client.prompt(
						{"Try and find Jounin players who's task it is to look after the younger ninja in the village."}, "[src]")

				if(usr)
					usr.client.prompt(
						{"They'll be able to teach you how to become stronger so that you can graduate from the academy."}, "[src]")

				if(usr)
					usr.client.prompt(
						{"Once you've passed your genin exam you'll be able to go out on squad missions with your peers."}, "[src]")

				if(usr)
					usr.client.prompt(
						{"Be careful, be fearsome but most of all... Evolve. Welcome to Naruto Evolution!"}, "[src]")

				if(usr)
					usr.Tutorial=6
					src.conversations.Remove(usr)