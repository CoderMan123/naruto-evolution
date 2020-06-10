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
mob/NPC
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
				if(usr.Tutorial!=Tutorial)
					usr<<output("You're not supposed to talk to this Jounin","ActionPanel.Output")
					return
				if(usr.dead)return
				if(get_dist(src,usr)>2)return
				if(usr)usr.move=0
				if(usr) usr.skalert({"[src]: Hey there, welcome to Naruto Evolution: The New Era. Please take a moment to complete the tutorial.
It will help you better understand how to play as well as where to find everything. "},"[src]")
				if(usr) usr.skalert({"[src]: First, you should have a look at the interface. The \"Chat\" button at the bottom left will toggle your chatbox. Next to it is the \"Channel\" button.
This will cycle you through the different channels you can chat in.
The action output to the right will keep you informed of what is currently happening throughout the game, as well as the controls for the game when you first log on, but you will see this yourself as you continue. "},"[src]")

				if(usr) usr.skalert({"[src]:Last but not least is the Options button. In there you will find many buttons with unique outcomes, most of these are pretty self explanitory.
When you get a free minute you should explore these options more, especially \"What's New?\" and \"Rules\" as they will tell you what has recently been added, and what you are not supposed to do.
At the end of the Rules list is rules for challenging Kages and Organization leaders."},"[src]")

				if(usr) usr.skalert({"[src]: Your health and chakra bar is located at the top left of the screen, if your jutsus are on cooldown they'll appear to the right of the screen.
Typing /help into the chat will give you a short list of commands you can use.
Pressing I will bring up your inventory, O will bring up your Statpanel, and P will bring up your Jutsus, but more on this later.
Please move on to the next Jounin after you are aquainted with the interface."},"[src]")
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
				if(usr.Tutorial!=Tutorial)
					usr<<output("You're not supposed to talk to this Jounin yet.","ActionPanel.Output")
					return
				if(usr.strength<=usr.TutorialStrength)
					if(usr) usr.skalert({"[src]: Hey, talk to me again when you've increased your Taijutsu.
Use A to attack the logs, and watch the action output on the bottom right, or open your statpanel(O) to watch your stats level."},"[src]")
					return
				if(usr.dead)return
				if(get_dist(src,usr)>2)return
				if(usr)usr.move=0
				if(usr) usr.skalert({"[src]: Welcome back. I see you leveled your Taijutsu. This means you already know the basics of leveling stats. Punch things with A, get taijutsu experience.
You can also gain taijutsu experience climbing mountains by dodging(D) while walking into a cliff side.
You can also punch faster by raising your agility, which is done by dodging(D) certain jutsus that are thrown at you or by purchasing weights from the weapon shop and using them(S) like any other ninja tool."},"[src]")

				if(usr) usr.skalert({"[src]: Another thing that you should note is targetting. You can target other players by clicking on them or by pressing Tab to cycle through targets.
You can untarget by clicking them or pressing Shift+Tab. Targetting will automatically switch your direction torward the target when using most jutsus or punching.
You'll learn more about this as you experience it first hand. Please move on to the next Jounin when you're ready."},"[src]")
				if(usr)
					usr.Tutorial=2
					usr.move=1
		JouninTwo
			icon='WhiteMBase.dmi'
		//	var/message
			Tutorial=2
			density=1
			DblClick()
				if(usr.Tutorial!=Tutorial)
					usr<<output("You're not supposed to talk to this Jounin yet.","ActionPanel.Output")
					return
				if(usr.dead)return
				if(get_dist(src,usr)>2)return
				if(usr)usr.move=0
				if(usr) usr.skalert({"[src]: Hey there, I am the Ninjutsu trainer. I'll be explaining how the art of Ninjutsu works. To many, Ninjutsu is one of the most vital
roles in the ninja world. They're probably right, because it does indeed play a large role! You must first learn techniques via the skill tree, found on the lower bar of the screen.
Once you have learned a technique you can then read the handsigns by clicking the 'Jutsus' tab on that same bar.
Using the keys displayed next to the technique, you can preform the jutsu, and execute it, by pressing the spacebar."},"[src]")
				if(usr) usr.skalert({"[src]: Eventually, you will be able to macro these techniques and be able to add them to your hotslot bar.
Once you have used the technique 80 times, you will be able to drag it on down to your hotbar from the jutsu interface(P). This will allow you to use the jutsu at will.
If the jutsu doesn't have handsigns you can drag it to the hotbar(F keys at bottom of screen) without using it 80 times."},"[src]")
				if(usr) usr.skalert({"[src]:  Another important factor in training Ninjutsu is the levels each technique has.
Most techniques will have a mastery level, and it will influence the technique in certain ways depending on it's level.
Through using the technique, you will be able to increase your mastery level, and preform the technique with progression.
Some jutsus increase damage or active time while others will fire more projectiles. Substitution even grants Advanced substitution when leveled enough. Try them out for yourself."},"[src]")
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
				if(!usr.JutsusLearnt.Find(/obj/Jutsus/BodyReplace))
					usr<<"Open up your skill tree first, and purchase the Substitution Technique under Non Clan Skills."
					return
				if(usr.Tutorial!=Tutorial)
					usr<<output("You're not supposed to talk to this Jounin yet.","ActionPanel.Output")
					return
				if(usr.dead)return
				if(get_dist(src,usr)>2)return
				if(usr)usr.move=0//Tell to do a mission.
				if(usr) usr.skalert({"[src]: Hi. I'm the final Jounin instructor. I'll be briefing you on the some of the other systems you can find here. "},"[src]")
				if(usr) usr.skalert({"[src]: Training can be done in many ways. Go swimming, use chakra control to walk on water, use techniques by yourself in the dojo where it's safe, do missions with fellow villagers for experience, or even both.
If you're out and about training you have to be weary of other ninjas, expecially from other villages. They may try to kill you, that is, until you get stronger and kill them first! Hahaha. "},"[src]")
				if(usr) usr.skalert({"[src]: To survive to the fullest extent you must cooperate with your fellow ninja to defend yourselves, eachother, and the village.
Not to mention doing missions in a squad yields experience to the entire squad.
Teamwork makes the dream work."},"[src]")
				if(usr) usr.skalert({"[src]: Don't worry, the tutorial is almost over. Go take a mission picking weeds from Hisho in the Kage house.
Then train your Taijutsu, Ninjutsu, and Genjutsu to 5, by using the jutsus you already have, so you can easily take down a rogue shinobi for the key to experiencing the rest of the world."},"[src]")
				if(usr) usr.skalert({"[src]: Don't bother remembering the tasks ahead. Start with the weeding mission and we'll remind you what's next as you go.
If you ever get stuck or have questions, even after the tutorial, don't be afraid to ask your fellow ninjas. Oh, and don't forget to have fun!"},"[src]")
				if(usr)
					usr.Tutorial=4
					usr.move=1