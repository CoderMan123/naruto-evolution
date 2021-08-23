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
		NewStuff()
			src.overlays += pick('Short.dmi','Short2.dmi','Short3.dmi')
			src.overlays+='Shirt.dmi'
			src.overlays+='Sandals.dmi'
			src.overlays+='Chunin Vest.dmi'
			spawn() Stuff()
			density=1
		Starting_Jounin
			icon='WhiteMBase.dmi'
			//var/message
			Tutorial=0
			density=1
			DblClick()
				if(usr.Tutorial < Tutorial)
					usr<<output("You're not supposed to talk to this Jounin yet.","Action.Output")
					return
				if(usr.Tutorial > Tutorial)
					usr<<output("I've done my part. Go ahead and move on to the next room.","Action.Output")
					return
				if(usr.dead)return
				if(get_dist(src,usr)>2)return
				if(usr)usr.move=0
				if(usr)
					usr.client.Alert(
						{"Hey there, welcome to Naruto Evolution. Please take a moment to complete the tutorial."}, "[src]")

				if(usr)
					usr.client.Alert(
						{"First, you should have a look at the interface. The \"Chat\" button at the bottom left will toggle your chatbox. Next to it is the \"Channel\" button.
						This will cycle you through the different channels you can chat in.
						The action output to the right will keep you informed of what is currently happening throughout the game, as well as the controls for the game when you first log on, but you will see this yourself as you continue."}, "[src]")

				if(usr)
					usr.client.Alert(
						{"Click on settings in the bottom right hand corner of the screen.
						Please take a moment to look at the Community Guidelines either now or at some other point for more information on the etiquettes of Naruto Evolution.
						If you're looking to become the next hokage or maybe the leader of the villainous Akatsuki, you can refer to the Ninja Handbook for rules on challenging Kages and Akatsuki."}, "[src]")

				if(usr)
					usr.client.Alert(
						{"Your health and chakra bar is located at the top left of the screen, if your jutsus are on cooldown they'll appear to the right of the screen.
						Pressing I will bring up your inventory, O will bring up your Statpanel, and P will bring up your Jutsus, but more on this later.
						Please move on to the next room and speak with the Jounin there once you're comfortable with the interface."}, "[src]")

				if(usr)
					usr.Tutorial=1
					usr.move=1
		JouninOne
			icon='WhiteMBase.dmi'
			//var/message
			Tutorial=1
			density=1
			DblClick()
				if(!usr.TutorialStrength) usr.TutorialStrength=usr.strength
				if(usr.Tutorial < Tutorial)
					usr<<output("You're not supposed to talk to this Jounin yet.","Action.Output")
					return
				if(usr.Tutorial > Tutorial)
					usr<<output("I've done my part. Go ahead and move on to the next room.","Action.Output")
					return
				if(usr.strength<=usr.TutorialStrength)
					if(usr) usr.client.Alert(
						{"[src]: Hey you're looking pretty weak for a Ninja. Why don't you go hit some of those dummies over there and get some meat on your bones.
						Use A to punch and watch the action output on the bottom right, or open your statpanel(O) to watch your stats level.
						Watch out for when it flashes! That means it's going to spin around sharply. You'll need to defend by holding D otherwise you might get hurt.
						Speak to me again when your Taijutsu has leveled up."}, "[src]")
					return
				if(usr.dead)return
				if(get_dist(src,usr)>2)return
				if(usr)usr.move=0
				if(usr) usr.client.Alert(
					{"[src]: Welcome back. I see you look a bit out of breath. That's good, it means your hard work is making you stronger.
					You can also gain taijutsu experience climbing mountains by dodging(D) while walking into a cliff side.
					You'll want to work on your speed as well. You'll be able to punch faster the more agility you have.
					You can raise your agility by running around, swimming and dodging certain projeciles or punches. You can even buy some weights from the weapons shop to help with your training."}, "[src]")

				if(usr) usr.client.Alert({"You might have noticed an arrow above that target dummy. This means you were targeting it. When you punch you'll automatically target a neaby combatent. You'll need to a target to be able to use most jutsu and it's significantly easier to hit others.
				You can also press TAB to target someone nearby or to cycle through targets. SHIFT+TAB will remove your target allowing you to manually aim certain jutsu.
				In the game you don't want to let people target you easily. In the next room my colleague will teach you a few tricks to dealing with enemies trying to target you.
				You should head on through and speak with him."},"[src]")
				if(usr)
					usr.Tutorial=2
					usr.move=1
		JouninTwo
			icon='WhiteMBase.dmi'
		//	var/message
			Tutorial=2
			density=1
			DblClick()
				if(usr.Tutorial < Tutorial)
					usr<<output("You're not supposed to talk to this Jounin yet.","Action.Output")
					return
				if(usr.Tutorial > Tutorial)
					usr<<output("I've done my part. Go ahead and move on to the next room.","Action.Output")
					return
				if(usr.dead)return
				if(get_dist(src,usr)>2)return
				if(usr)usr.move=0
				if(usr) usr.client.Alert({"Hey there, I am the Ninjutsu trainer. I'll teach you how to learn new jutsu as well as some techniques that even the strongest of ninja use!
				I see you already know a couple jutsu. You can use a jutsu by pressing the right handseals in the right order and then pressing the spacebar to activate it.
				You'll find a list of all of your jutsu and their handseal conbinations by pressing the 'Jutsus' button in the bottom right. Give it a try!"},"[src]")
				if(usr) usr.client.Alert({"Eventually, you will master your jutsu if you use them enough. This means you can use them instantly without having to weave the seals!
				Once you have mastered it's seals, you will be able to drag it on down to your hotbar by accessing your jutsu list by pressing P. Some Jutsu don't require seals at all and can be hotkeyed right from the start!"},"[src]")
				if(usr) usr.client.Alert({"Another important factor in training Ninjutsu is the levels each technique has.
				Most techniques will have a mastery level, and it will influence the technique in certain ways depending on it's level growing significantly stronger.
				Through using the technique, you will be able to gain experience to increase it's mastery level. You can view the levels of your Jutsu via the 'Jutsu' button in the bottom right.
				Some jutsus increase damage or active time while others will fire more projectiles or have longer effects. Substitution even grants Advanced substitution when leveled enough."},"[src]")
				if(usr) usr.client.Alert({"Oh that's right you'll definately be needing those jutsu. Clone jutsus and Substitution jutsus will be integral to your survival as they'll both cause people around you to stop targeting.
				I see you already have a simple clone jutsu which will also create clones that help block the enemy from targeting you by causing them to target the clones instead. But that won't be enough. How about you open the skill tree with the button in the bottom left so that you can learn a Substitution.
				Select Non-clan from the list and purchase Body Replacement Jutsu by clicking it's icon in the top left. As well as dropping peoples targets, Body Replacement will also move you back sharply to avoid danger leaving behind a solid substituion to block potential threats.
				When you use it you'll also gain the ability to use Advanced Body Replacement. This is a special subsitution that once used will designate a target location. The next time you defend with the D key you'll be teleported back to that location, leaving behind a log.
				So long as the jutsu has been set, you can even use it while trapped by an opponents jutsu to escape!"},"[src]")
				if(usr) usr.client.Alert({"One last thing. Using your jutsu will also level up certain stats. It's a good method for getting stronger. However an alternative for Ninjutsu and Genjutsu is to perform chakra control training.
				You should be able to find it in your jutsus list by pressing P. Face the correct direction in time and your Ninjutsu and Genjutsu will get a little stronger. The more you succeed the greater the growth!
				You can tell how well you are doing by how powerful your chakra aura is while you're training in this way. Additionally if you are Ninjutsu or Genjutsu specialization, you'll gain a bonus towards training that stat during chakra control training.
				Once you've bought Body Replacement jutsu feel free to try out everything I've taught you here but besides that you can move on to the next room."},"[src]")
				if(usr)
					usr.Tutorial=3
					usr.move=1
					usr<<"Please open up your skill tree before continuing and purchase the Substitution Technique, under Non Clan Skills."
		Ending_Jounin
			icon='WhiteMBase.dmi'
			Tutorial=3
			density=1
		//	var/message
			DblClick()
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
					usr<<output("I've done my part. Go ahead and move on to the next room.","Action.Output")
					return
				if(usr.dead)return
				if(get_dist(src,usr)>2)return
				if(usr)usr.move=0//Tell to do a mission.
				if(usr) usr.client.Alert({"Hi there, so I bet you've been wondering about Precision and Genjutsu right? Well I'm here to tell you all about them.
				Precision is your ability to land precise projectiles and weapons and Genjutsu is the use of illusion techniques. There are some Genjutsu around which can be completely crippling for it's victim if they don't have the proper defences.
				You can both increase the potency of your Genjutsu and protect yourself against them but leveling this stat."},"[src]")
				if(usr) usr.client.Alert({"As for Precision, using ninja tools will be your primary way of improving.
				It costs money to purchase weapons from the shop but it's worth it for the power they can provide you in combat."},"[src]")
				if(usr) usr.client.Alert({"Like all the other stats certain jutsu will scale off Precision and level it up too.
				Useful if you want to train it but you're low on cash."},"[src]")
				if(usr) usr.client.Alert({"It's a dangerous world out there kiddo. Make sure once you leave this place you seek the help of your fellow villagers.
				Try and find Jounin players who's task it is to look after the younger ninja in the village.
				They'll be able to teach you how to become stronger so that you can graduate from the academy.
				Once you've passed your genin exam you'll be able to go out on squad missions with your peers.
				Be careful, be fearsome but most of all... Evolve. Welcome to Naruto Evolution!"},"[src]")
				if(usr)
					usr.Tutorial=6
					usr.move=1