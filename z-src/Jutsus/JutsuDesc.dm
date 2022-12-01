obj
	Jutsus
		layer = 10000
		var/give_to_guards = 0

//NonClan
		Chakra_Infusion_Training//chakrainfusionstuff
			icon_state="chakrainfuse"
			mouse_drag_pointer = "chakrainfuse"
			name="Chakra Infusion Training"
			rank="D"
			signs="<font color=green>None</font><br>"
			maxcooltime = 0
			ChakraCost = 0
			uses=100
			starterjutsu=1
			Description="Utilizing chakra control, train to increase the the power of your ninjutsu by improving your chakra infusion. The more you move with the flow of your chakra, the more effective the training."

		BClone
			icon_state="clone"
			mouse_drag_pointer = "clone"
			name="Clone Jutsu"
			rank="D"
			signs="<font color=green>Rat</font><br>(macro(Q))"
			Sprice=1
			starterjutsu=1
			give_to_guards = 1
			Description="This technique allows the user to create illusive clones of themselves. It makes it difficult to target you amongst the clones."
			New()
				..()
				ChakraCost = (Sprice*jutsuchakra)*0.6
				maxcooltime = jutsucooldown*180

		BCloneD
			icon_state="cloneD"
			mouse_drag_pointer = "cloneD"
			name="Clone Destroy"
			rank="D"
			signs="<font color=green>Rat,Ox</font><br>(macro(Q,W))"
			uses=100
			maxcooltime= 0
			ChakraCost = 0
			reqs=list("Clone Jutsu")
			starterjutsu = 1
			give_to_guards = 1
			Description="This technique destroys the clones you have out on the field."

		Transformation
			icon_state="henge"
			mouse_drag_pointer = "henge"
			name="Transformation Jutsu"
			rank="E"
			signs="<font color=green>Dog,Rat</font><br>(macro(E,Q))"
			Sprice=1
			starterjutsu=1
			Description="This technique transforms the user's appearance into the selected target but if anything touches you the genjusu breaks."
			New()
				..()
				ChakraCost = (Sprice*jutsuchakra)*0.6
				maxcooltime = jutsucooldown*100

		BodyReplace
			icon_state="bodyreplace"
			mouse_drag_pointer = "bodyreplace"
			name="Body Replacement Jutsu"
			rank="E"
			signs="<font color=green>Dog</font><br>(macro(E))"
			Sprice=1
			give_to_guards = 1
			Description="Body replacement technique. Substitute your body with a log, allowing you to escape from battle. It allows you to slip out of someones targeting breifly or avoid attacks with good timing."
			New()
				..()
				ChakraCost = (Sprice*jutsuchakra)*0.8
				maxcooltime = jutsucooldown*80


		AdvancedBodyReplace
			icon_state="Abodyreplace"
			mouse_drag_pointer = "Abodyreplace"
			name="Advanced Body Replacement Jutsu"
			rank="E"
			signs="<font color=green>Dog,Dog</font><br>(macro(E,E))"
			Sprice=1
			give_to_guards = 1
			Description="Set a location to escape to in an emergancy. You can then substitute your body with a log by pressing D, allowing you to escape dangerous situations providing you're close enough to your escape location. So long as a location is set this jutsu can be used while bound, freeing you from it's restraints."
			New()
				..()
				ChakraCost = (Sprice*jutsuchakra)*0.9
				maxcooltime = jutsucooldown*240

		Body_Flicker
			icon_state="Shunshin"
			mouse_drag_pointer = "Shunshin"
			name="Body Flicker Technique"
			rank="D"
			signs="<font color=green>None</font><br>"
			Sprice=1
			uses=100
			starterjutsu=1
			give_to_guards = 1
			Description="Utilizing chakra control, you converge chakra to your feet, allowing you to move forwards or to a target extremely fast."
			New()
				..()
				ChakraCost = (Sprice*jutsuchakra)
				maxcooltime = jutsucooldown*10

		Chakra_Control
			icon_state="chak2"
			mouse_drag_pointer = "chak2"
			name="Chakra Control"
			rank="E"
			signs="<font color=green>None</font><br>"
			uses=100
			Sprice=1
			Description="Imbue your chakra to your feet, allowing you to walk on water, and up mountains."
			New()
				..()
				ChakraCost = (Sprice*jutsuchakra)*0
				maxcooltime = jutsucooldown*10

		SClone
			icon_state="Shadclone"
			mouse_drag_pointer = "Shadclone"
			name="Shadow Clone Jutsu"
			rank="A"
			signs="<font color=green>Rat,Dragon</font><br>(macro(Q,5))"
			Sprice=1
			reqs=list("Clone Destroy")
			Description="Create a single solid clone of yourself on the battlefield which can attack your target or be more precisely controlled by clicking on the clone."
			New()
				..()
				ChakraCost = (Sprice*jutsuchakra)*1.5
				maxcooltime = jutsucooldown*250

		MSClone
			icon_state="Mclone"
			mouse_drag_pointer = "Mclone"
			name="Multiple Shadow Clone Jutsu"
			rank="A"
			signs="<font color=green>Rat,Dragon,Dog,Monkey,Monkey</font><br>(macro(Q,5,E,4,4))"
			Sprice=2
			reqs=list("Shadow Clone Jutsu")
			Description="Create multiple shadowclones which can attack their target. It also makes you difficult to target amongst the clones."
			New()
				..()
				ChakraCost = (Sprice*jutsuchakra)*1.5
				maxcooltime = jutsucooldown*500

//Ninjutsu Spec
		Rasengan
			icon_state="Rasengan"
			mouse_drag_pointer = "Rasengan"
			name="Rasengan"
			rank="A"
			signs="<font color=green>Rabbit,Rabbit,Ox</font><br>(macro(1,1,W))"
			Specialist = "Ninjutsu"
			Sprice=2
			Description="Channel your chakra into a ball of spinning air but aligning your chakra. Upon the jutsu being fully charged you run towards a direction or your target at starling speeds dealing damage (Nin|Agi) to your target if you get into melee range."
			New()
				..()
				ChakraCost = (Sprice*jutsuchakra)*2.4
				maxcooltime = jutsucooldown*200

		ChakraRelease
			icon_state="chak"
			mouse_drag_pointer = "chak"
			name="Chakra Release"
			rank="E"
			signs="<font color=green>Rat,Rat</font><br>(macro(Q,Q))"
			Specialist = "Ninjutsu"
			uses=100
			Sprice=1
			Description="Blast your chakra from your body to deflect projectiles if timed right. You will also expel all weaponry placed upon you outwards in random directions around you to deal damage (Nin)."
			New()
				..()
				ChakraCost = (Sprice*jutsuchakra)*2
				maxcooltime = jutsucooldown*100

//Taijutsu Spec
		Body_Pathway_Derangement
			icon_state="Achiever of Nirvana Fist"
			mouse_drag_pointer = "Achiever of Nirvana Fist"
			name="Body Pathway Derangement"
			rank="A"
			Specialist = SPECIALIZATION_TAIJUTSU
			signs="<font color=green>Horse,Horse,Snake</font><br>(macro(3,3,2))"
			Sprice=3
			reqs=list("ShiShi Rendan")
			Description="Strike someone in melee with chakra, interupting their nervous system, dealing damage (Str|Prc) and causing them to fall asleep. Hitting a sleeping target might wake them up."
			New()
				..()
				ChakraCost = (Sprice*jutsuchakra)*1.4
				maxcooltime = jutsucooldown*400

		One_Thousand_Years_of_Death
			icon_state="One Thousand Years of Death"
			mouse_drag_pointer = "One Thousand Years of Death"
			name="Leaf Hidden Finger Jutsu: One Thousand Years of Death"
			rank="D"
			signs="<font color=green>Monkey</font><br>(macro(4))"
			Specialist = SPECIALIZATION_TAIJUTSU
			Sprice=1
			uses=100
			Description="After a short delay you flick to your opponent and hit them with a precise strike in a.. certain place.. dealing damage (Str|Prc) and launching them a few squares."
			New()
				..()
				ChakraCost = (Sprice*jutsuchakra)*2.5
				maxcooltime = jutsucooldown*80

		Shishi
			icon_state="shishi"
			mouse_drag_pointer = "shishi"
			name="ShiShi Rendan"
			rank="D"
			signs="<font color=green>None"
			Specialist = SPECIALIZATION_TAIJUTSU
			Sprice=1
			reqs = list("Leaf Hidden Finger Jutsu: One Thousand Years of Death")
			uses=100
			Description="Perform a combination attack on a close target and use your speed to create a series off attacks dealing damage (Str|Agi) and breifly preventing the target from acting."
			New()
				..()
				ChakraCost = (Sprice*jutsuchakra)*1
				maxcooltime = jutsucooldown*100

		Leaf_Whirlwind
			icon_state="Lwind"
			mouse_drag_pointer = "Lwind"
			name="Leaf Whirlwind"
			rank="C"
			signs="<font color=green>None"
			Specialist = SPECIALIZATION_TAIJUTSU
			reqs=list("ShiShi Rendan")
			uses=100
			Sprice=2
			Description="Using a single spinning kick this technique allows one to attack multiple opponents simultaneously in a small area around you dealing damage (Str|Agi) and launching them away if they're weaker than you."
			New()
				..()
				ChakraCost = (Sprice*jutsuchakra)*0.5
				maxcooltime = jutsucooldown*200

//Genjutsu Spec
		Bringer_of_Darkness_Technique
			icon_state="Bringer of Darkness Technique"
			mouse_drag_pointer = "Bringer of Darkness Technique"
			name="Bringer of Darkness Technique"
			rank="B"
			signs="<font color=green>Dog,Ox,Dragon</font><br>(macro(E,W,5))"
			Sprice=3
			Specialist = "Genjutsu"
		//	uses=100
			Description="Force your target to not be able to see light for a breif amount of time (Gen)."
			New()
				..()
				ChakraCost = (Sprice*jutsuchakra)*2.5
				maxcooltime = jutsucooldown*600

		Crow_Clone
			icon_state="Crow Clone"
			mouse_drag_pointer = "Crow Clone"
			name="Crow Clone"
			rank="C"
			Sprice=2
			Specialist = "Genjutsu"
			signs="<font color=green>Rat,Dragon,Dog,Monkey</font><br>(macro(Q,5,E,4))"
			Description="Create multiple illusive clones by seperating into multiple crows and scatterring them to hide amongst them. This makes it difficult to be targeted amongst the clones."
			New()
				..()
				ChakraCost = (Sprice*jutsuchakra)*1.2
				maxcooltime = jutsucooldown*300

		Crow_Substitution
			icon_state="CrowSub"
			mouse_drag_pointer = "CrowSub"
			name="Crow Substitution"
			rank="C"
			signs="<font color=green>Ox,Rat,Rat</font><br>(macro(W,Q,Q))"
			uses=0
			Sprice=4
			Specialist = "Genjutsu"
			reqs=list("Crow Clone")
			Description="Sets an escape location whereby you'll replace your body with crows upon receiving any damage."
			New()
				..()
				ChakraCost = (Sprice*jutsuchakra)*1.6
				maxcooltime = jutsucooldown*450

		TreeBinding
			icon_state="Tree Binding"
			mouse_drag_pointer = "Tree Binding"
			name="Demonic Illusion: Tree Binding Death"
			rank="B"
			signs="<font color=green>Ox,Snake,Rabbit,Dog</font><br>(macro(W,2,1,E))"
			Sprice=3
			Specialist = "Genjutsu"
			Description="You convince your target's mind that they are locked to a nearby tree, dealing damage (Gen) and binding them for a duration."
			New()
				..()
				ChakraCost = (Sprice*jutsuchakra)*1.5
				maxcooltime = jutsucooldown*200

		Temple_Of_Nirvana
			icon_state="Temple of Nirvana"
			mouse_drag_pointer = "Temple of Nirvana"
			name="Temple of Nirvana"
			rank="B"
			signs="<font color=green>Dog,Rabbit,Dog,Snake</font><br>(macro(E,1,E,2))"
			Sprice=3
			Specialist = "Genjutsu"
			reqs=list("Demonic Illusion: Tree Binding Death")
			Description="Cause an illusion of mystic feathers lulling anyone near you into a deep sleep. Attacking a sleeping target might cause them to wake up."
			New()
				..()
				ChakraCost = (Sprice*jutsuchakra)*2
				maxcooltime = jutsucooldown*400

//Iron Sand

		Black_Iron_Fists
			icon_state="SageBind"
			mouse_drag_pointer = "SageBind"
			name="Black Iron Fists"
			rank="A"
			//signs="<font color=green>Dog,Dog,Rat,Dragon,Dragon</font><br>(macro(E,E,Q,5,5))"
			Clan= CLAN_IRON
			maxcooltime = 0
			ChakraCost = 0
			Sprice=2
			//reqs=list("")
			Description="Form and control fists of iron sand which will attack alongside you dealing damage (Nin) and knocking back anyone hit."
			New()
				..()
				ChakraCost = (Sprice*jutsuchakra)*1.5
				maxcooltime = jutsucooldown*50

		Grasp_of_Iron
			icon_state="SageBind"
			mouse_drag_pointer = "SageBind"
			name="Grasp of Iron"
			rank="A"
			//signs="<font color=green>Dog,Dog,Rat,Dragon,Dragon</font><br>(macro(E,E,Q,5,5))"
			Clan= CLAN_IRON
			Sprice=3
			reqs=list("Black Iron Fists")
			Description="Launch one of your fists outwards to attempt to grab someone. If you successfully grab someone they are bound for a duration and that fist will be occupied for the same duration. (An ocupied fist cannot be used for attacks or jutsu.)"
			New()
				..()
				ChakraCost = (Sprice*jutsuchakra)*2
				maxcooltime = jutsucooldown*300
			
		Shield_of_Iron
			icon_state="SageBind"
			mouse_drag_pointer = "SageBind"
			name="Shield of Iron"
			rank="B"
			//signs="<font color=green>Dog,Dog,Rat,Dragon,Dragon</font><br>(macro(E,E,Q,5,5))"
			Clan= CLAN_IRON
			Sprice=3
			reqs=list("Black Iron Fists")
			Description="Your Black Iron Fists rotate around you atempting to hit away anyone who gets too close dealing damage (Nin) and knocking them back."
			New()
				..()
				ChakraCost = (Sprice*jutsuchakra)*1.2
				maxcooltime = jutsucooldown*100

		Gathering_Assault_Pyramid
			icon_state="SageBind"
			mouse_drag_pointer = "SageBind"
			name="Gathering Assault: Pyramid"
			rank="S"
			//signs="<font color=green>Dog,Dog,Rat,Dragon,Dragon</font><br>(macro(E,E,Q,5,5))"
			Clan= CLAN_IRON
			Sprice=4
			reqs=list("Black Iron Fists")
			Description="You channel your lightning to form a huge inverted pyramid out of iron sand to drop onto anyone unlucky enough to be beneath it. Deals damage in a 3 x 3 area (Nin) or up to twice as much in the center (Nin|Prc)"
			New()
				..()
				ChakraCost = (Sprice*jutsuchakra)*2.5
				maxcooltime = jutsucooldown*200


//Snake Sage
		HiddenSnakeStab
			icon_state="HiddenSnakeStab"
			mouse_drag_pointer = "HiddenSnakeStab"
			name="Hidden Snake Stab"
			rank="S"
			signs="<font color=green>Rat,Snake,Dog</font><br>(macro(Q,2,E))"
			Clan= CLAN_SAGE
			Sprice=2
			reqs=list("Sage Mode")
			Description="You turn your arm into deadly snakes to stab and bite an enemy in it's way dealing damage (Nin) and breifly binding yourself and the target for the duration."
			New()
				..()
				ChakraCost = (Sprice*jutsuchakra)*0.9
				maxcooltime = jutsucooldown*100

		Snake_Skin_Replacement_Jutsu
			icon_state="Snake Skin Replacement Jutsu"
			mouse_drag_pointer = "Snake Skin Replacement Jutsu"
			name="Snake Skin Replacement"
			rank="C"
			signs="<font color=green>Ox,Rat,Rat,Ox</font><br>(macro(W,Q,Q,W))"
			Clan= CLAN_SAGE
			uses=0
			reqs=list("Hidden Snake Stab")
			Sprice = 3
			Description="Sets an escape location whereby you'll replace your body with snakes upon receiving any damage."
			New()
				..()
				ChakraCost = (Sprice*jutsuchakra)*1.7
				maxcooltime = jutsucooldown*450

		SageMode
			icon_state="Sage Mode"
			mouse_drag_pointer = "Sage Mode"
			name="Sage Mode"
			rank="S"
			Clan= CLAN_SAGE
			Specialist="Ninjutsu"
			Sprice=4
			uses=100
			signs="<font color=green>None</font><br>"
			Description="You activate sage mode gaining a boost to Taijutsu and ninjutsu provided by powers of nature and grants access to a powerul connection to snakes."
			New()
				..()
				ChakraCost = (Sprice*jutsuchakra)*2
				maxcooltime = jutsucooldown*600

		Sage_Style_Giant_Rasengan
			icon_state="SageRasengan"
			mouse_drag_pointer = "SageRasengan"
			name="Sage Style Giant Rasengan"
			rank="S"
			signs="<font color=green>Rabbit,Ox,Rabbit,Ox,Rabbit,Ox</font><br>(macro(1,W,1,W,1,W))"
			Clan= CLAN_SAGE
			Sprice=4
			reqs=list("Summoning Jutsu: Snake","Rasengan")
			Description="Channel your Sage Mode energy by aligning your chakra to create a giant ball of spinning energy. Upon the jutsu being fully charged you run towards a direction or your target at starling speeds dealing damage (Nin|Prc) to your target if you get into melee range."
			New()
				..()
				ChakraCost = (Sprice*jutsuchakra)*2
				maxcooltime = jutsucooldown*450

		Snake_Release_Jutsu
			icon_state="Snake_Release_Jutsu"
			mouse_drag_pointer = "Snake_Release_Jutsu"
			name="Sage Style: Giant Snake"
			rank="A"
			signs="<font color=green>Dog,Rat,Rat,Dragon,Dog</font><br>(macro(E,Q,Q,5,E))"
			Clan= CLAN_SAGE
			maxcooltime = 0
			ChakraCost = 0
			reqs=list("Sage Mode")
			Description="Summon a powerful snake from the darkness in your heart and send it crashing into your enemies."

		Snake_Summoning
			icon_state="SnakeSummoning"
			mouse_drag_pointer = "SnakeSummoning"
			name="Summoning Jutsu: Snake"
			Clan= CLAN_SAGE
			rank="B"
			Sprice=3
			reqs=list("Snake Skin Replacement")
			//uses=100
			signs="<font color=green>Rat,Horse,Rat,Dog,Ox</font><br>(macro(Q,3,Q,E,W))"
			Clan= "SnakeSage"
			Description="Allows you to summon small snake to aid you in combat! The snake will move towards your initial target and will attack dealing damage (Nin) provided you keep your opponent targeted."
			New()
				..()
				ChakraCost = (Sprice*jutsuchakra)*1.6
				maxcooltime = jutsucooldown*250

		Sage_Bind
			icon_state="SageBind"
			mouse_drag_pointer = "SageBind"
			name="Sage Style: Toad Bind"
			rank="S"
			signs="<font color=green>Dog,Dog,Rat,Dragon,Dragon</font><br>(macro(E,E,Q,5,5))"
			Clan= CLAN_SAGE
			maxcooltime = 0
			ChakraCost = 0
			Sprice=5
			reqs=list("Sage Style: Giant Snake")
			Description="Sage Style Toad Bind: Use Sage energy to turn bind with toad tongue."

//Yellow Flash
		Warp_Rasengan
			icon_state="WarpRasengan"
			mouse_drag_pointer = "WarpRasengan"
			name="Warp Rasengan"
			rank="S"
			signs="<font color=green>Rabbit,Monkey,Monkey,Rabbit,Monkey</font><br>(macro(1,4,4,1,4))"
			Clan= CLAN_YELLOWFLASH
			Sprice=4
			reqs=list("Flying Thunder God: Great Escape","Rasengan")
			Description="Instantly warp to an opponent marked with a spacial seal sending them flying with a Rasengan to deal damage (Nin)."
			New()
				..()
				ChakraCost = (Sprice*jutsuchakra)*1.5
				maxcooltime = jutsucooldown*450

		Flying_Thunder_God
			icon_state="Flyingthunder"
			mouse_drag_pointer = "Flyingthunder"
			name="Flying Thunder God"
			rank="A"
			signs="<font color=green>Rabbit</font><br>(macro(1))"
			Clan= CLAN_YELLOWFLASH
			Sprice=2
			reqs=list("Flying Thunder God: Kunai")
			Description="The ultimate spacial jutsu allowing the user to instantly transport themselves through space to their spacial kunai seal. You can also teleport to a target marked with your seal."
			New()
				..()
				ChakraCost = (Sprice*jutsuchakra)*2
				maxcooltime = jutsucooldown*80

		Flying_Thunder_God_Kunai
			icon_state="Flyingthunderkunai"
			mouse_drag_pointer = "Flyingthunderkunai"
			name="Flying Thunder God: Kunai"
			rank="A"
			signs="<font color=green>Dog,Rat,Rabbit</font><br>(macro(E, Q, 1))"//needs setting
			Specialist="Ninjutsu"
			Clan= CLAN_YELLOWFLASH
			Sprice=2
			Description="Learn to throw a kunai infused with a spacial seal. If the kunai hits someone it will mark them with a spacial seal and deal damage (Nin|Prc). Otherwise the kunai will fall harmlessly onto the ground."
			New()
				..()
				ChakraCost = (Sprice*jutsuchakra)*1.8
				maxcooltime = jutsucooldown*60

		Flying_Thunder_God_Great_Escape
			icon_state="Flyingthunderescape"
			mouse_drag_pointer = "Flyingthunderescape"
			name="Flying Thunder God: Great Escape"
			rank="A"
			signs="<font color=green>Rabbit,Dog,Dog</font><br>(macro(1, E, E))"//needs setting
			Clan= CLAN_YELLOWFLASH
			Sprice=4
			reqs=list("Flying Thunder God")
			Description="Drop down a spacial seal kunai to return to upon taking damage providing you are within range."
			New()
				..()
				ChakraCost = (Sprice*jutsuchakra)*1.8
				maxcooltime = jutsucooldown*600

//Medical Clan
		Poison_Mist
			icon_state="Poison Mist"
			mouse_drag_pointer = "Poison Mist"
			name="Poison Mist"
			rank="B"
			signs="<font color=green>Dragon,Horse,Snake</font><br>(macro(5,3,2))"
			Clan= CLAN_MEDICAL
			reqs=list("Heal")
			Sprice=3
			Description="Convert your chakra into poison gas and breath it out forwards or towards a target through your mouth dealing damage (Nin) and repeating it's damage after a delay."
			New()
				..()
				ChakraCost = (Sprice*jutsuchakra)*0.8
				maxcooltime = jutsucooldown*50

		Heal
			icon_state="Heal"
			mouse_drag_pointer = "Heal"
			name="Heal"
			rank="C"
			signs="<font color=green>Dog,Snake,Rat</font><br>(macro(E,2,Q))"
			Clan= CLAN_MEDICAL
			Sprice=2
			Description="Channel your chakra into life force significantly healing (Nin) yourself or a target."
			New()
				..()
				ChakraCost = (Sprice*jutsuchakra)*2.2
				maxcooltime = jutsucooldown*300

		Ones_Own_Life_Reincarnation
			icon_state="Ones Own Life Reincarnation"
			mouse_drag_pointer = "Ones Own Life Reincarnation"
			name="One's Own Life Reincarnation"
			rank="A"
			signs="<font color=green>Horse,Horse,Horse</font><br>(macro(3,3,3))"
			Clan= CLAN_MEDICAL
			Sprice=4
			maxcooltime = 600
			ChakraCost = 10
			reqs=list("Heal")
			Description="Sacrifice your own life to revive a fallen comrade."
			New()
				..()
				ChakraCost = (Sprice*jutsuchakra)*0
				maxcooltime = jutsucooldown*450

		Mystical_Palms
			icon_state="Chakra Scalpel"
			mouse_drag_pointer = "Chakra Scalpel"
			name="Mystical Palms"
			rank="A"
			uses=100
			signs="<font color=green>None</font><br>"
			Clan= CLAN_MEDICAL
			Sprice=3
			reqs = list("Heal")
			Description="Form blades of chakra around your hands increasing the damage of your punches."
			New()
				..()
				ChakraCost = (Sprice*jutsuchakra)*0.5
				maxcooltime = jutsucooldown*20

		Cherry_Blossom_Impact
			icon_state="Cherry Blossom Impact"
			mouse_drag_pointer = "Cherry Blossom Impact"
			name="Cherry Blossom Impact"
			rank="C"
			signs="<font color=green>Horse,Horse,Rabbit</font><br>(macro(3,3,1))"
			Clan= CLAN_MEDICAL
			Sprice=2
			reqs=list("Mystical Palms")
			Description="Use a precise injection of chakra from your hand on an opponent to simulate immense Taijutsu blasting them away, dealing damage (Nin) and briefly binding them. Also effective at shocking someone out of certain binds."
			New()
				..()
				ChakraCost = (Sprice*jutsuchakra)*0.5
				maxcooltime = jutsucooldown*20

//Rinnegan

		Rinnegan
			icon_state="Rinnegan"
			mouse_drag_pointer = "Rinnegan"
			name="Rinnegan"
			rank="S"
			uses=100
			Sprice=1
			maxcooltime = 50
			signs="<font color=green>None"
			ChakraCost = 0
			Clan= CLAN_RINNEGAN
			Description="The Legendary Doujutsu, the Rinnegan. The forefather of all doujutsu, capable of mastering the Yin and Yang elements. Grants immunity to certain genjutsu."
			New()
				..()
				ChakraCost = (Sprice*jutsuchakra)*0
				maxcooltime = jutsucooldown*50

		Induction
			icon_state="induct"
			mouse_drag_pointer = "induct"
			name="Gravity Divergence: Induction"
			rank="A"
			signs="<font color=green>Snake,Rabbit</font><br>(macro(2,1))"
			Clan= CLAN_RINNEGAN
			reqs=list("Rinnegan")
			Sprice=2
			Description="Control the force of gravity itself, dealing damage (Nin) and forcing your target towards you."
			New()
				..()
				ChakraCost = (Sprice*jutsuchakra)*0.7
				maxcooltime = jutsucooldown*50

		Repulsion
			icon_state="repulse"
			mouse_drag_pointer = "repulse"
			name="Gravity Divergence: Repulsion"
			rank="A"
			signs="<font color=green>Rabbit,Snake</font><br>(macro(1,2))"
			Sprice=2
			Clan= CLAN_RINNEGAN
			reqs=list("Gravity Divergence: Induction")
			Description="Control the force of gravity itself, dealing damage (Nin) and forcing your target away from you."
			New()
				..()
				ChakraCost = (Sprice*jutsuchakra)*0.7
				maxcooltime = jutsucooldown*50

		Chakra_Leech
			icon_state="Chakra Leech"
			mouse_drag_pointer = "Chakra Leech"
			name="Chakra Leech"
			Clan= CLAN_RINNEGAN
			rank="C"
			Sprice=2
			reqs=list("Gravity Divergence: Repulsion")
			signs="<font color=green>Snake,Dragon,Snake,Rat</font><br>(macro(2,5,2,Q))"
			Description="Reach out and touch someone to draw from their chakra reserves and replenish your own until either they run out of chakra or you reach your maximum. This jutsu renders both the user and the victim helpless for the duration!"
			New()
				..()
				ChakraCost = (Sprice*jutsuchakra)*0
				maxcooltime = jutsucooldown*300

		Gedo_Revival
			icon_state="Gedo Revival"
			mouse_drag_pointer = "Gedo Revival"
			name="Gedo Revival"
			Clan= CLAN_RINNEGAN
			rank="S"
			signs="<font color=green>Horse,Rabbit,Horse</font><br>(macro(3,1,3))"
			reqs=list("Chakra Leech")
			Sprice=3
			Description="Draw upon the power of the Gedo to revive fallen allies."
			New()
				..()
				ChakraCost = (Sprice*jutsuchakra)*4
				maxcooltime = jutsucooldown*450

		Almighty_Push
			icon_state="Apush"
			mouse_drag_pointer = "Apush"
			name="Gravity Divergence: Almighty Push"
			rank="S"
			Clan= CLAN_RINNEGAN
			signs="<font color=green>Rabbit,Rabbit,Snake,Snake,Rabbit,Snake</font><br>(macro(1,1,2,2,1,2))"
			Sprice=4
			reqs=list("Summoning Jutsu: Dog")
			Description="Release the full power of your gravity control repelling anyone in a large radius around you with immense force dealing damage (Nin) and launching them away from you."
			New()
				..()
				ChakraCost = (Sprice*jutsuchakra)*3
				maxcooltime = jutsucooldown*600

		Dog_Summoning
			icon_state="cerberus"
			mouse_drag_pointer = "cerberus"
			name="Summoning Jutsu: Dog"
			Clan= CLAN_RINNEGAN
			rank="B"
			Sprice=3
			reqs=list("Gedo Revival")
			//uses=100
			signs="<font color=green>Rat,Horse,Rat,Dog,Dog</font><br>(macro(Q,3,Q,E,E))"
			Clan= "Rinnegan"
			Description="Allows you to summon a cerberus dog to aid you in combat! The dog will move towards your initial target and will attack dealing damage (Nin) provided you keep your opponent targeted."
			New()
				..()
				ChakraCost = (Sprice*jutsuchakra)*1.6
				maxcooltime = jutsucooldown*250


//Gates

		EightGates
			icon_state = "Gate 5"
			mouse_drag_pointer = "Gate 5"
			name = "Eight Gates"
			rank = "B"
			Sprice = 0
			signs = "<font color=green>None</font><br>"
			maxcooltime = 5
			Clan= CLAN_GATES
			uses = 100
			level = 0
			Description="Opens the chakra gates, increasing your Taijutsu and causing damage to yourself with every punch. The benefits and downsides increase with each level of gates you use."
			New()
				..()
				ChakraCost = (Sprice*jutsuchakra)*0
				maxcooltime = jutsucooldown*10

		Opening_Gate
			icon_state = "Gate 1"
			mouse_drag_pointer = "Gate 1"
			name = "Opening Gate"
			rank = "B"
			Sprice = 1
			signs = "<font color=green>None</font><br>"
			Clan= CLAN_GATES
			Specialist=SPECIALIZATION_TAIJUTSU
			maxcooltime = 200
			uses = 100
			IsGate = 1
			Description="Opens the first chakra gate, increasing your Taijutsu and causing damage to yourself."

		Energy_Gate
			icon_state="Gate 2"
			mouse_drag_pointer = "Gate 2"
			name="Energy Gate"
			rank="B"
			signs="<font color=green>None</font><br>"
			Clan= CLAN_GATES
			maxcooltime=200
			Sprice=2
			uses=100
			IsGate = 1
			reqs=list("Opening Gate")
			Description="Opens the second chakra gate, increasing your Taijutsu further."

		Life_Gate
			icon_state="Gate 3"
			mouse_drag_pointer = "Gate 3"
			name="Life Gate"
			rank="B"
			signs="<font color=green>None</font><br>"
			Clan= CLAN_GATES
			maxcooltime=200
			Sprice=2
			uses=100
			IsGate = 1
			reqs=list("Opening Gate","Energy Gate")
			Description="Opens the third chakra gate, allowing you to dramatically increase your Taijutsu and cause more damage to yourself."

		Pain_Gate
			icon_state="Gate 4"
			mouse_drag_pointer = "Gate 4"
			name="Pain Gate"
			rank="B"
			signs="<font color=green>None</font><br>"
			Clan= CLAN_GATES
			maxcooltime=200
			Sprice=3
			uses=100
			IsGate = 1
			reqs=list("Opening Gate","Energy Gate","Life Gate")
			Description="Opens the fourth chakra gate, increasing your Taijutsu, giving you blinding speed, and causing damage to yourself."

		Limiter_Gate
			icon_state="Gate 5"
			mouse_drag_pointer = "Gate 5"
			name="Limiter Gate"
			rank="B"
			signs="<font color=green>None</font><br>"
			Clan= CLAN_GATES
			maxcooltime=200
			Sprice=3
			uses=100
			IsGate = 1
			reqs=list("Opening Gate","Energy Gate","Life Gate","Pain Gate")
			Description="Opens the fifth chakra gate, increasing your Taijutsu unbeleivably and causing damage to yourself."

		Meteor_Punch
			icon_state="mpunch"
			mouse_drag_pointer = "mpunch"
			name="Meteor Punch"
			rank="C"
			signs="<font color=green>None"
			Clan= CLAN_GATES
			Sprice=2
			uses=100
			reqs = list("Opening Gate")
			Description="Summoning up monsterous Taijutsu, channel this Taijutsu into a single punch launching someone back and dealing damage (Str)."
			New()
				..()
				ChakraCost = (Sprice*jutsuchakra)*0.7
				maxcooltime = jutsucooldown*100

		Morning_Peacock
			icon_state="Asakujaku"
			mouse_drag_pointer = "Asakujaku"
			name="Morning Peacock"
			rank="C"
			signs="<font color=green>None"
			Clan= CLAN_GATES
			Sprice=3
			uses=100
			reqs=list("Limiter Gate")
			Description="This technique unleashes a huge flurry of flaming punches in front of them dealing damage (Str|Agi) to anyone in a small area of effect in front of you. The damage increases with every level of gates you use however it will also cause you to take some damage from the jutsu aswell. The higher your agility, the faster you finish the jutsu. This jutsu has a chance of setting it's victims on fire."
			New()
				..()
				ChakraCost = (Sprice*jutsuchakra)*1.2
				maxcooltime = jutsucooldown*200

//Uchiha

		Sharingan
			icon_state="Sharingan 1 tomoe"
			mouse_drag_pointer = "Sharingan 1 tomoe"
			name="Sharingan 1 tomoe"
			rank="B"
			Clan= CLAN_UCHIHA
			signs="<font color=green>None</font><br>"
			maxcooltime=55
			ChakraCost = 25
			uses=100
			sharin=1
			Description="The Uchiha clan specialty, the legendary Sharingan doujutsu. This eye technique allows you to track time as if it were slowed down. Allowing you to block most moves, and grants immunity to certain genjutsu. The chance of automatically blocking/dodging attacks increases base on the level of sharingan you possess."
			New()
				..()
				ChakraCost = (Sprice*jutsuchakra)*0.5
				maxcooltime = jutsucooldown*55

		Sharingan_2
			icon_state="Sharingan 2 tomoe"
			mouse_drag_pointer = "Sharingan 2 tomoe"
			name="Sharingan 2 tomoe"
			rank="B"
			Clan= CLAN_UCHIHA
			signs="<font color=green>None</font><br>"
			maxcooltime=45
			ChakraCost = 20
			Sprice=1
			uses=100
			sharin=2
			reqs = list("Sharingan 1 tomoe")
			Description="The Uchiha clan specialty, the legendary Sharingan doujutsu. This eye technique allows you to track time as if it were slowed down. Allowing you to block most moves, and grants immunity to certain genjutsu. The chance of automatically blocking/dodging attacks increases base on the level of sharingan you possess. "
			New()
				..()
				ChakraCost = (Sprice*jutsuchakra)*0.5
				maxcooltime = jutsucooldown*45

		Sharingan_3
			icon_state="Sharingan 3 tomoe"
			mouse_drag_pointer = "Sharingan 3 tomoe"
			name="Sharingan 3 tomoe"
			rank="B"
			Clan= CLAN_UCHIHA
			signs="<font color=green>None</font><br>"
			maxcooltime=35
			ChakraCost = 15
			Sprice=1
			uses=100
			sharin=3
			reqs = list("Sharingan 2 tomoe")
			Description="The Uchiha clan specialty, the legendary Sharingan doujutsu. This eye technique allows you to track time as if it were slowed down. Allowing you to block most moves, and grants immunity to certain genjutsu. The chance of automatically blocking/dodging attacks increases base on the level of sharingan you possess."
			New()
				..()
				ChakraCost = (Sprice*jutsuchakra)*0.5
				maxcooltime = jutsucooldown*35

		Sharingan_4
			icon_state="Mangekyou Sharingan"
			mouse_drag_pointer = "Mangekyou Sharingan"
			name="Mangekyou Sharingan"
			rank="A"
			Clan= CLAN_UCHIHA
			signs="<font color=green>None</font><br>"
			maxcooltime=25
			ChakraCost = 10
			Sprice=2
			uses=100
			sharin=4
			reqs = list("Sharingan 3 tomoe")
			Description="Your sharingan enters it's final form. By sacrificing a portion of your maximum health you can activate the magekyo sharingan. It grants the highest chance of automatically blocking/dodgeing as well as giving genjutsu immunity. The mangekyo sharingan unlocks the ability to use powerful visual jutsu."
			New()
				..()
				ChakraCost = (Sprice*jutsuchakra)*0.5
				maxcooltime = jutsucooldown*25

		Sharingan_5
			icon_state="Eternal Mangekyou"
			mouse_drag_pointer = "Eternal Mangekyou"
			name="Eternal Mangekyou Sharingan"
			rank="S"
			Clan= CLAN_UCHIHA
			signs="<font color=green>None</font><br>"
			maxcooltime=15
			ChakraCost = 5
			Sprice=3
			uses=100
			sharin=5
			reqs = list("Mangekyou Sharingan")
			Description="The unbelieveably strong, one and only Eternal Mangekyou Sharingan! Mastered only among the best of the Uchihas."
			New()
				..()
				ChakraCost = (Sprice*jutsuchakra)*0.5
				maxcooltime = jutsucooldown*15

		Tsukuyomi
			icon_state="Tsukuyomi"
			mouse_drag_pointer = "Tsukuyomi"
			name="Tsukuyomi"
			rank="S"
			uses=100
			signs="<font color=green>None</font><br>"
			Clan= CLAN_UCHIHA
			Sprice=3
			reqs=list("Mangekyou Sharingan")
			Description="Cause anyone looking into your eyes (targeting you) to fall into a cruel genjutsu forcing them to live out years of torture in their own mind. Victims are bound for the duration and take damage (Gen) as their will is broken."
			New()
				..()
				ChakraCost = (Sprice*jutsuchakra)*2
				maxcooltime = jutsucooldown*450

		Amaterasu
			icon_state="Amaterasu"
			mouse_drag_pointer = "Amaterasu"
			name="Amaterasu"
			rank="S"
			signs="<font color=green>None</font><br>"
			uses=100
			Clan= CLAN_UCHIHA
			Sprice=3
			reqs=list("Mangekyou Sharingan")
			Description="Summon an unextinguishable fire onto a target. After a delay, providing you are still targeting your victim they will be flooded with a raging black flame causing them to burn for a long duration dealing damage over time (Nin)."
			New()
				..()
				ChakraCost = (Sprice*jutsuchakra)*2
				maxcooltime = jutsucooldown*350

		Susanoo
			icon_state="Susanoo"
			mouse_drag_pointer = "Susanoo"
			name="Susanoo"
			Sprice=5
			rank="S"
			Clan= CLAN_UCHIHA
			signs="<font color=green>Dog,Ox,Dragon,Ox,Dog</font><br>(macro(E,W,5,W,E))"
			reqs = list("Mangekyou Sharingan")
			Description="You manefest a giant warrior incarnation which protects you from death for a duration. You can cause the incarnation to attack enemies around you by pressing the S key."
			New()
				..()
				ChakraCost = (Sprice*jutsuchakra)*3
				maxcooltime = jutsucooldown*600

//Implanted

		Sharingan_Copy
			icon_state="Sharingan Copy"
			mouse_drag_pointer = "Sharingan Copy"
			name="Sharingan Copy"
			rank="B"
			Clan= CLAN_IMPLANT
			signs="<font color=green>None</font><br>"
			Sprice=3
			uses=100
			Description="Implant yourself with a Sharingan! By using it you can copy the next jutsu used by a player."
			New()
				..()
				ChakraCost = (Sprice*jutsuchakra)
				maxcooltime = jutsucooldown*50

		Kamui
			icon_state="Kamui"
			mouse_drag_pointer = "kamui"
			name="Kamui"
			rank="S"
			uses=100
			signs="<font color=green>None</font><br>"
			Sprice=4
			Clan= CLAN_IMPLANT
			reqs=list("Sharingan Copy")
			Description="Cause a rip in space time pulling a section of someones body into the warp dimension. After a delay, providing you are still targeting your victim they will begin to quickly take damage (Nin) over time."
			New()
				..()
				ChakraCost = (Sprice*jutsuchakra)*2
				maxcooltime = jutsucooldown*450

		WarpDim
			icon_state="WD"
			mouse_drag_pointer = "WD"
			name="Warp Dimension"
			rank="A"
			//Clan="Uchiha"
			signs="<font color=green>None</font><br>"
			Clan= CLAN_IMPLANT
			reqs=list("Intangible")
			Sprice=5
			uses=100
			Description="After a short delay pull yourself into the warp dimension almost entirely safe from the outside world. If someone is targeted you will drag them with you providing you are still targeting them after the delay."
			New()
				..()
				ChakraCost = (Sprice*jutsuchakra)*1.5
				maxcooltime = jutsucooldown*100

		Intangible_Jutsu
			icon_state="In"
			mouse_drag_pointer = "In"
			name="Intangible"
			rank="S"
			//Clan="Uchiha"
			signs="<font color=green>None</font><br>"
			Clan= CLAN_IMPLANT
			reqs=list("Kamui")
			Sprice=4
			uses=100
			Description="Use the power of the Kamui on yourself to make things pass through you as if you weren't even there. You cannot perform jutsus are actions in any way while this jutsu is active."
			New()
				..()
				ChakraCost = (Sprice*jutsuchakra)
				maxcooltime = jutsucooldown*30

//Nara

		Shadow_Extension
			icon_state="Shadow Bind"
			mouse_drag_pointer = "Shadow Bind"
			name="Shadow Bind"
			rank="B"
			Clan= CLAN_NARA
			signs="<font color=green>Monkey, Snake, Ox</font><br>(macro(4,2,W))"
			Sprice=2
			Description="Reach out with your shadow towards a target and attempt to possess their shadow with your own. If the jutsu succeeds the target will be bound in place and helpless."
			New()
				..()
				ChakraCost = (Sprice*jutsuchakra)*1.3
				maxcooltime = jutsucooldown*200

		Shadow_Stab
			icon_state="Shadow Stab"
			mouse_drag_pointer = "Shadow Stab"
			name="Shadow Stab"
			rank="A"
			Clan= CLAN_NARA
			reqs=list("Shadow Bind")
			signs="<font color=green>None</font><br>"
			Sprice=2
			uses=100
			Description="Shoot spikes out from a victims possessed shadow to deal damage (Nin)."
			New()
				..()
				ChakraCost = (Sprice*jutsuchakra)*1.8
				maxcooltime = jutsucooldown*150

		Shadow_Choke
			icon_state="Shadow Choke"
			mouse_drag_pointer = "Shadow Choke"
			name="Shadow Choke"
			rank="A"
			Clan= CLAN_NARA
			reqs=list("Shadow Stab")
			signs="<font color=green>None</font><br>"
			Sprice=3
			uses=100
			Description="Choke a target with their own shadow quickly dealing damage over time (Nin)."
			New()
				..()
				ChakraCost = (Sprice*jutsuchakra)*1.8
				maxcooltime = jutsucooldown*300

		Shadow_Field
			icon_state="Shadow Field"
			mouse_drag_pointer = "Shadow Field"
			name="Shadow Field"
			rank="S"
			Clan= CLAN_NARA
			signs="<font color=green>Monkey,Snake,Ox,Monkey</font><br>(macro(4,2,W,4))"
			Sprice=3
			reqs=list("Shadow Bind")
			Description="Expand your shadow all around you binding anyone nearby and allowing you to move them around helplessly."
			New()
				..()
				ChakraCost = (Sprice*jutsuchakra)*2.8
				maxcooltime = jutsucooldown*300

		Shadow_Explosion
			icon_state="Shadow Explosion"
			mouse_drag_pointer = "Shadow Explosion"
			name="Shadow Explosion"
			rank="S"
			Clan= CLAN_NARA
			reqs=list("Shadow Choke")
			signs="<font color=green>None</font><br>"
			Sprice=4
			uses=100
		//	uses=0;notneeded=1
			Description="Reveal explosive tags hidden in your shadow extension and cause them to explode to deal damage (Nin) to a target whose shadow you possess.."
			New()
				..()
				ChakraCost = (Sprice*jutsuchakra)*1.8
				maxcooltime = jutsucooldown*500

//Aburame

		Insect_Clone
			icon_state="Insect Clone"
			mouse_drag_pointer = "Insect Clone"
			name="Insect Clone"
			rank="S"
			uses=0
			signs="<font color=green>Snake,Dragon,Snake</font><br>(macro(2,5,2))"
			Sprice=2
			Clan= CLAN_ABURAME
			Description="Uses the destruction bugs to make a clone that battles alongside you running around and punching anyone and everyone indscriminately."
			New()
				..()
				ChakraCost = (Sprice*jutsuchakra)*0.7
				maxcooltime = jutsucooldown*220

		Bug_Neurotoxin
			icon_state="Bug Neurotoxin"
			mouse_drag_pointer = "Bug Neurotoxin"
			name="Destruction Bug Neurotoxin"
			rank="S"
			uses=0
			signs="<font color=green>Dragon,Snake,Snake</font><br>(macro(5,2,2))"
			Sprice=2
			Clan= CLAN_ABURAME
			reqs = list("Stealth Bug")
			Description="Command stealth bugs to bind the effected target breifly"
			New()
				..()
				ChakraCost = (Sprice*jutsuchakra)*2.8
				maxcooltime = jutsucooldown*450

		Insect_Cocoon
			icon_state="Insect Cocoon"
			mouse_drag_pointer = "Insect Cocoon"
			name="Insect Cocoon"
			rank="S"
			uses=0
			signs="<font color=green>Dragon,Snake,Snake,Dragon</font><br>(macro(5,2,2,5))"
			Sprice=3
			Clan= CLAN_ABURAME
			reqs = list("Destruction Bug Neurotoxin")
			Description="Use insects smaller than the eye can see and spread them across the battlefield. With every punch you expend chakra to pull everyone towards you slightly, creating chaos."
			New()
				..()
				ChakraCost = (Sprice*jutsuchakra)*0.5
				maxcooltime = jutsucooldown*10

		Hunter_Scarabs
			icon_state="Hunter Scarabs"
			mouse_drag_pointer = "Hunter Scarabs"
			name="Destruction Bug Hunter Scarabs"
			rank="S"
			uses=0
			signs="<font color=green>Dragon,Snake</font><br>(macro(5,2))"
			Sprice=2
			Clan= CLAN_ABURAME
			reqs = list("Destruction Bug Swarm")
			Description="Summon Destruction Bugs all around or towards a target that crawl slowly on the ground dealing damage (Nin) and shoving anyone they hit."
			New()
				..()
				ChakraCost = (Sprice*jutsuchakra)*1.4
				maxcooltime = jutsucooldown*400

		Destruction_Bug_Swarm
			icon_state="Destruction Bug Swarm"
			mouse_drag_pointer = "Destruction Bug Swarm"
			name="Destruction Bug Swarm"
			rank="S"
			uses=0
			signs="<font color=green>Snake,Dragon,Dragon</font><br>(macro(2,5,5))"
			Sprice=2
			Clan= CLAN_ABURAME
			reqs = list("Insect Clone")
			Description="Launch a swarm of insects from your body carrying someone away from you and drilling into them to deal damage(Nin)."
			New()
				..()
				ChakraCost = (Sprice*jutsuchakra)*2
				maxcooltime = jutsucooldown*150

		Stealth_Bug
			icon_state="Stealth Bug"
			mouse_drag_pointer = "Stealth Bug"
			name="Stealth Bug"
			rank="S"
			uses=0
			signs="<font color=green>Dragon,Dragon,Snake</font><br>(macro(5,5,2))"
			Sprice=2
			Clan= CLAN_ABURAME
			reqs = list("Insect Clone")
			Description="Infect your target with a swarm of tiny insects slowly biting at them to deal damage over time (Nin)"
			New()
				..()
				ChakraCost = (Sprice*jutsuchakra)
				maxcooltime = jutsucooldown*350

		BugTornado
			icon_state="BugTornado"
			mouse_drag_pointer = "BugTornado"
			name="Bug Tornado"
			rank="S"
			uses=0
			signs="<font color=green>Dragon,Snake,Snake,Dragon,Dragon</font><br>(macro(5,2,2,5,5))"
			Sprice=3
			Clan= CLAN_ABURAME
			reqs = list("Destruction Bug Swarm")
			Description="Summon a tempest of insects which move towards a target or wander the battlefield dealing damage (Nin) to anyone who gets in it's way."
			New()
				..()
				ChakraCost = (Sprice*jutsuchakra)*1.6
				maxcooltime = jutsucooldown*300

//Hyuuga

		Byakugan
			icon_state="Byakugan"
			mouse_drag_pointer = "Byakugan"
			name="Byakugan"
			rank="D"
			signs="<font color=green>Snake</font><br>(macro(2))"
			Sprice=1
			Clan= CLAN_HYUUGA
			Description="The Hyuuga clan's Doujutsu. This technique allows the user to temporarily extend their vision as well as use the power of the gentle fist. While Byakugan is active your punches will deal damage to the victims chakra aswell."
			New()
				..()
				ChakraCost = (Sprice*jutsuchakra)*0.5
				maxcooltime = jutsucooldown*10

		Eight_Trigrams_Palm_Heavenly_Spin
			icon_state="Kaiten"
			mouse_drag_pointer = "Kaiten"
			name="Eight Trigrams Palm: Heavenly Spin"
			rank="B"
			signs="<font color=green>Snake,Rat,Snake,Dragon</font><br>(macro(2,Q,2,5))"
			Sprice=2
			Clan= CLAN_HYUUGA
			reqs=list("Byakugan")
			Description="Spin rapidly while forming chakra all around you deflecting most projectiles, pushing targets away from you and dealing damage (Nin|Agi) to anyone in a radius around you."
			New()
				..()
				ChakraCost = (Sprice*jutsuchakra)*2
				maxcooltime = jutsucooldown*120

		Eight_Trigrams_Empty_Palm
			icon_state="Eight Trigrams Empty Palm"
			mouse_drag_pointer = "Eight Trigrams Empty Palm"
			name="Eight Trigrams: Empty Palm"
			rank="S"
			signs="<font color=green>Snake,Rat</font><br>(macro(2,Q))"
			Sprice=2
			Clan= CLAN_HYUUGA
			reqs=list("Byakugan")
			Description="Infuse chakra in your palm and strike out with enough force to create a short range blast of compressed air dealing damage (Nin|Str) and knocking back anyone you hit. They will not be knocked back if their stats are too high."
			New()
				..()
				ChakraCost = (Sprice*jutsuchakra)*0.8
				maxcooltime = jutsucooldown*100

		Eight_Trigrams_Mountain_Crusher
			icon_state="Eight Trigrams Mountain Crusher"
			mouse_drag_pointer = "Eight Trigrams Mountain Crusher"
			name="Eight Trigrams: Mountain Crusher"
			rank="A"
			signs="<font color=green>Snake,Snake,Dog</font><br>(macro(2,2,E))"
			Sprice=2
			Description="Create a long range blast of air more powerful and precise than emtpy palm dealing damage (Nin|Str) to the first target hit in a line."
			reqs = list("Eight Trigrams: Empty Palm")
			Clan= CLAN_HYUUGA
			New()
				..()
				ChakraCost = (Sprice*jutsuchakra)*1.5
				maxcooltime = jutsucooldown*70

		Eight_Trigrams_64_Palms
			icon_state="64 Palms"
			mouse_drag_pointer = "64 Palms"
			name="Eight Trigrams: 64 Palms"
			rank="A"
			signs="<font color=green>Snake,Rat,Dragon,Rat,Dragon</font><br>(macro(2,Q,5,Q,5))"
			Sprice=3
			Clan= CLAN_HYUUGA
			reqs=list("Eight Trigrams: Empty Palm")
			Description="Using Byakugan and Gentle fist you gain increased perception for a short time and attack your opponents chakra points. You flicker to your target and begin a combination attack against them until you've hit all 64 chakra points dealing damage (Nin|Agi|Prc) and additional chakra damage. Both you and your target are helpless for the duration."
			New()
				..()
				ChakraCost = (Sprice*jutsuchakra)*2.5
				maxcooltime = jutsucooldown*450

		Eight_Gates_Assault
			icon_state="Eight Gates Assault"
			mouse_drag_pointer = "Eight Gates Assault"
			name="Last Resort: Eight Gates Assault"
			rank="S"
			signs="<font color=green>Snake,Rat,Dragon,Rat,Dragon,Dragon</font><br>(macro(2,Q,5,Q,5,5))"
			Sprice=4
			Clan= CLAN_HYUUGA
			reqs=list("Eight Trigrams: 64 Palms")
			Description="Attack the enemy in front of you with the full force of your Byakugan and Gentle Fist, devistating their 8 chakra gates to deal damage (Nin|Agi|Prc) and seriously harm their chakra reserves."
			New()
				..()
				ChakraCost = (Sprice*jutsuchakra)*3
				maxcooltime = jutsucooldown*600

//Kaguya

		Bone_Tip
			icon_state="BoneT"
			mouse_drag_pointer = "BoneT"
			name="Bone Tip"
			rank="C"
			signs="<font color=green>Ox</font><br>(macro(W))"
			maxcooltime = 0
			ChakraCost = 0
			Clan= CLAN_KAGUYA
			Description="Blast the tips of your finger bones as a projectile that will fire towards your target or in a straight line dealing damage (Str|Prc) to the first target hit."
			New()
				..()
				ChakraCost = (Sprice*jutsuchakra)*1
				maxcooltime = jutsucooldown*80

		Bone_Sensation
			icon_state="BoneS"
			mouse_drag_pointer = "BoneS"
			name="Bone Sensation"
			rank="C"
			signs="<font color=green>Ox,Ox,Rat</font><br>(macro(W,W,Q))"
			maxcooltime = 0
			ChakraCost = 0
			Sprice=2
			Clan= CLAN_KAGUYA
			reqs=list("Bone Tip")
			Description="After using the finger-tip like bones that have been implanted into your opponent, you can follow it up with this deadly technique which forces the bone-tips to expel outwards from the target's body.."

		Camellia_Dance
			icon_state="Camellia Dance"
			mouse_drag_pointer = "Camellia Dance"
			name="Camellia Dance"
			rank="C"
			signs="<font color=green>Rat,Rat,Ox</font><br>(macro(Q,Q,W))"
			Sprice=3
			Clan= CLAN_KAGUYA
			reqs=list("Bone Tip")
			Description="Harden your bones to form a sword which makes your physical attacks deal more damage."
			New()
				..()
				ChakraCost = (Sprice*jutsuchakra)*0.5
				maxcooltime = jutsucooldown*10

		Bone_Drill
			icon_state="Bone Drill"
			mouse_drag_pointer = "Bone Drill"
			name="Bone Drill"
			rank="C"
			signs="<font color=green>Rat,Rat,Rat</font><br>(macro(Q,Q,Q))"
			Sprice=2
			Clan= CLAN_KAGUYA
			reqs=list("Camellia Dance")
			Description="Harden your bones to form a drill and drive it into an opponent directly in front of you dealing damage (Str|Prc) and knocking them away from you."
			New()
				..()
				ChakraCost = (Sprice*jutsuchakra)*2.2
				maxcooltime = jutsucooldown*220

		Bone_Pulse
			icon_state="BoneP"
			mouse_drag_pointer = "BoneP"
			name="Bone Pulse"
			rank="C"
			signs="<font color=green>Rat,Dog,Ox</font><br>(macro(Q,E,W))"
			Sprice=2
			Clan= CLAN_KAGUYA
			reqs=list("Bone Tip")
			Description="Release your bones into large sharp bone fangs that erupt from the ground before you or from underneath a target dealing damage and holding them in place. A victim of this jutsu can still use jutsu and will only be bound as long as they remain where the spikes errupt."
			New()
				..()
				ChakraCost = (Sprice*jutsuchakra)*1.8
				maxcooltime = jutsucooldown*150

		Young_Bracken_Dance
			icon_state="young bracken dance"
			mouse_drag_pointer = "young bracken dance"
			name="Young Bracken Dance"
			rank="C"
			signs="<font color=green>Rat,Dog,Ox,Ox</font><br>(macro(Q,E,W,W))"
			Sprice=3
			Clan= CLAN_KAGUYA
			reqs=list("Bone Pulse")
			Description="Unleash your bones from their body into large sharp bone fangs that erupt from the ground all around you dealing damage (Str|Prc) and restricting victims movement. The spikes will also block most projectiles."
			New()
				..()
				ChakraCost = (Sprice*jutsuchakra)*2.5
				maxcooltime = jutsucooldown*250

		Dance_Of_The_Kaguya
			icon_state="DOTK"
			mouse_drag_pointer = "DOTK"
			name="Dance Of The Kaguya"
			rank="A"
			signs="<font color=green>Rat,Dog,Ox,Rat</font><br>(macro(Q,E,W,Q))"
			Sprice=3
			Clan= CLAN_KAGUYA
			reqs=list("Bone Drill")
			Description="Perform a deadly dance attacking someone directly in front of you with a flurry of strikes, injecting your bones into them as you do. Each hit will deal damage (Str|Prc|Agi) and knock them back slightly while you follow them continuing the onslaught."
			New()
				..()
				ChakraCost = (Sprice*jutsuchakra)*2
				maxcooltime = jutsucooldown*550


//Clay

		Deidara
			icon_state="Deidara"
			mouse_drag_pointer = "Deidara"
			name="Deidara"
			rank="S"
			signs="<font color=green>None</font><br>"
			Sprice=1
			maxcooltime = 0
			ChakraCost = 0
			Clan= CLAN_CLAY
			Element="Earth"
			Description="By using the forbidden Kinjutsu of the Iwagakure along with exploding clay, you gain the ability to create dolls which attack the opponent and explode."

		C1_Birds
			icon_state="C1 bird"
			mouse_drag_pointer = "C1 bird"
			name="C1: Tracking Birds"
			rank="B"
			signs="<font color=green>Dragon,Rabbit,Dragon</font><br>(macro(5,1,5))"
			Sprice=2
			Element="Earth"
			Clan= CLAN_CLAY
			Description="Use special mouths on the palms of your hands to create a swarm of clay tracking birds, which fly towards a target and explode on impact dealing damage (Nin)."
			New()
				..()
				ChakraCost = (Sprice*jutsuchakra)*1.4
				maxcooltime = jutsucooldown*180

		C1_Spiders
			icon_state="C1 spider"
			mouse_drag_pointer = "C1 spider"
			name="C1: Spider Swarm"
			rank="B"
			signs="<font color=green>Dragon,Dog,Dragon</font><br>(macro(5,E,5))"
			Sprice=3
			Element="Earth"
			Clan= CLAN_CLAY
			reqs = list("C1: Tracking Birds")
			Description="Use special mouths on the palms of your hands to create a swarm of clay spiders, which slowly stalk a target or spread out all around you and explode dealing damage (Nin) in a small radius."
			New()
				..()
				ChakraCost = (Sprice*jutsuchakra)*2
				maxcooltime = jutsucooldown*120

		C1Snake
			icon_state="C1Snake"
			mouse_drag_pointer = "C1Snake"
			name="C1: Exploding Snake"
			rank="B"
			signs="<font color=green>Dragon,Snake,Dragon</font><br>(macro(5,2,5))"
			Sprice=3
			Element="Earth"
			Clan= CLAN_CLAY
			reqs = list("C1: Spider Swarm")
			Description="Use special mouths on the palms of your hands to create a deadly exploding snake that slithers towards your target and explodes dealing damage (Nin)."
			New()
				..()
				ChakraCost = (Sprice*jutsuchakra)*1.6
				maxcooltime = jutsucooldown*80

		C2
			icon_state="C2"
			mouse_drag_pointer = "C2"
			name="C2"
			rank="S"
			signs="<font color=green>Dragon,Dragon,Dragon,Dragon,Dragon</font><br>(macro(5,5,5,5,5))"
			Sprice=3
			maxcooltime = 0
			Clan= CLAN_CLAY
			ChakraCost = 0
			reqs = list("C1: Tracking Birds","C1: Spider Swarm")
			Description="This technique allows one to use special mouths on the palms of your hands to create a large clay dragon, which can use the clay it consists of to fire a managerie of explosives at it's oppoenents."

		C3
			icon_state="C3"
			mouse_drag_pointer = "C3"
			name="C3"
			rank="S"
			signs="<font color=green>Dragon,Dragon,Dragon,Dragon,Dog</font><br>(macro(5,5,5,5,E))"
			Sprice=4
			Element="Earth"
			Clan = CLAN_CLAY
			reqs = list("C1: Exploding Snake")
			Description="Use special mouths on the palms of your hands to create a large clay doll slightly in the shape of a human, when activated with 'D' it will explode dealing damage (Nin) in a large radius."
			New()
				..()
				ChakraCost = (Sprice*jutsuchakra)*2
				maxcooltime = jutsucooldown*400

//Ice

		Ice
			icon_state="IceKekkeiGenkai"
			mouse_drag_pointer = "IceKekkeiGenkai"
			name="Ice"
			rank="S"
			signs="<font color=green>None</font><br>"
			Sprice=1
			maxcooltime = 170
			ChakraCost = 0
			Clan= CLAN_ICE
			Description="Allows user to gain powers of the Ice Kekkei Genkai."

		Demonic_Ice_Mirrors
			icon_state="Demonic Ice Mirrors"
			mouse_drag_pointer = "Demonic Ice Mirrors"
			name="Demonic Ice Mirrors"
			rank="B"
			signs="<font color=green>Rabbit,Dog,Dog,Ox,Rabbit</font><br>(macro(1,E,E,W,1))"
			Sprice=3
			Clan = CLAN_ICE
			reqs = list("Sensatsu Suishou")
			Description="Create multiple ice-like mirrors around the selected target, and throw needles from the mirrors towards the target from different angles by warping to the different mirrors at high speeds. Deals more damage (Nin|Prc) the faster you can press the commands.)"
			New()
				..()
				ChakraCost = (Sprice*jutsuchakra)*2.3
				maxcooltime = jutsucooldown*350

		Sensatsu_Suishou
			icon_state="Sensatsu Suishou"
			mouse_drag_pointer = "Sensatsu Suishou"
			name="Sensatsu Suishou"
			rank="A"
			signs="<font color=green>Rabbit,Dog,Rabbit</font><br>(macro(1,E,1))"
			Sprice=3
			Clan = CLAN_ICE
			reqs = list("Ice Explosion")
			Description="This technique forms deadly ice needles that attempt to impale your target and anyone nearby them dealing damage (Nin|Prc) and holding them in place. They can escape by moving from the location the jutsu hits them and they can still use jutsu."
			New()
				..()
				ChakraCost = (Sprice*jutsuchakra)*1.2
				maxcooltime = jutsucooldown*150

		Iceball
			icon_state="Iceball"
			mouse_drag_pointer = "Iceball"
			name="Iceball"
			rank="B"
			signs="<font color=green>Rabbit,Dog,Dog,Rabbit</font><br>(macro(1,E,E,1))"
			Sprice=2
			Clan = CLAN_ICE
			reqs=list("Demonic Ice Mirrors")
			Description="Create balls of ice that launch towards a target dealing damage (Nin)."
			New()
				..()
				ChakraCost = (Sprice*jutsuchakra)*1.2
				maxcooltime = jutsucooldown*120

		Omega_Ice_Ball
			icon_state="GiantIceBall"
			mouse_drag_pointer = "GiantIceBall"
			name="Omega Ice Ball"
			rank="S"
			signs="<font color=green>Rabbit,Dog,Dog,Rabbit,Dog,Dog,Rabbit</font><br>(macro(1,E,E,1,E,E,1))"
			Sprice=5
			maxcooltime = 0
			ChakraCost = 0
			reqs=list("Iceball")
			uses=100
			Clan = CLAN_ICE
			Description="Omega Ice Ball: An Giant Iceball streaming with only power of ice & destroying all in it's path."

		Ice_Explosion
			icon_state="C0"
			mouse_drag_pointer = "C0"
			name="Ice Explosion"
			rank="B"
			signs="<font color=green>Dog,Dog,Rabbit</font><br>(macro(E,E,1))"
			Sprice=3
			Clan = CLAN_ICE
			Description="Use nearby water to explode and freeze, impaling enemies and dealing damage (Nin) in a radius around you."
			New()
				..()
				ChakraCost = (Sprice*jutsuchakra)*1.8
				maxcooltime = jutsucooldown*150

//Kakuzu

		Kakuzu
			icon_state="Kakuzu"
			mouse_drag_pointer = "Kakuzu"
			name="Kakuzu"
			rank="S"
			signs="<font color=green>None</font><br>"
			maxcooltime = 0
			ChakraCost= 0
			Sprice = 4
			Clan= CLAN_KAKUZU
			Description="Gain powers of Kakuzu that allow you to use elemental jutsus without affinity towards that element!"

		FireMask
			icon_state="FireMask"
			mouse_drag_pointer = "FireMask"
			name="Fire Mask"
			rank="A"
			signs="<font color=green>Dog,Snake</font><br>(macro(E,2))"
			Sprice=2
			Clan= CLAN_KAKUZU
			Description="Allows the user to summon a Fire Heart that uses a single Fire jutsu."
			New()
				..()
				ChakraCost = (Sprice*jutsuchakra)*1.5
				maxcooltime = jutsucooldown*300

		WindMask
			icon_state="WindMask"
			mouse_drag_pointer = "WindMask"
			name="Wind Mask"
			rank="A"
			signs="<font color=green>Ox,Snake</font><br>(macro(W,2))"
			Sprice=2
			Clan= CLAN_KAKUZU
			Description="Allows the user to summon a Wind Heart that uses a single Wind jutsu."
			New()
				..()
				ChakraCost = (Sprice*jutsuchakra)*1.5
				maxcooltime = jutsucooldown*200

		EarthMask
			icon_state="EarthMask"
			mouse_drag_pointer = "EarthMask"
			name="Earth Mask"
			rank="A"
			signs="<font color=green>Dragon,Rabbit</font><br>(macro(5,1))"
			Sprice=2
			Clan= CLAN_KAKUZU
			Description="Allows the user to summon a Earth Heart that uses a single Earth jutsu."
			New()
				..()
				ChakraCost = (Sprice*jutsuchakra)*1.5
				maxcooltime = jutsucooldown*400

		LightningMask
			icon_state="LightningMask"
			mouse_drag_pointer = "LightningMask"
			name="Lightning Mask"
			rank="A"
			signs="<font color=green>Dog,Rabbit</font><br>(macro(E,1))"
			Sprice=2
			Clan= CLAN_KAKUZU
			Description="Allows the user to summon a Lightning Heart that uses a single Lightning jutsu."
			New()
				..()
				ChakraCost = (Sprice*jutsuchakra)*1.5
				maxcooltime = jutsucooldown*400

//Puppeteer

		Puppeteer
			icon_state="Puppeteer"
			mouse_drag_pointer = "Puppeteer"
			name="Puppeteer"
			rank="B"
			signs="<font color=green>None</font><br>"
			maxcooltime = 0
			ChakraCost = 0
			Sprice=1
			Clan= CLAN_PUPPET
			Description="Train yourself to learn to control a puppet through chakra strings that come from your fingers."

		First_Puppet_Summoning
			icon_state="puppet 1"
			mouse_drag_pointer = "puppet 1"
			name="First Puppet Summoning"
			rank="C"
			signs="<font color=green>Rabbit,Rabbit,Snake</font><br>(macro(1,1,2))"
			uses=100
			Sprice=2
			Clan= CLAN_PUPPET
			reqs = list("Puppeteer")
			Description="You summon a puppet which can uses its hidden weapons to attack opponents by walking into them, dealing damage (Nin|Prc). Hold 'ctrl' to move it. Your first puppet will also come to your aid with every attack."
			New()
				..()
				ChakraCost = (Sprice*jutsuchakra)*2.5
				maxcooltime = jutsucooldown*250

		Puppet_Dash
			icon_state="puppet dashing"
			mouse_drag_pointer = "puppet dashing"
			name="Puppet Dash"
			rank="B"
			signs="<font color=green>None</font><br>"
			uses=100
			Sprice=1
			Clan= CLAN_PUPPET
			reqs = list("First Puppet Summoning")
			Description="Imbue more chakra into the strands that bind your puppet to you than normal and enable the ability to move your puppets at greater speeds than ever before."
			New()
				..()
				ChakraCost = (Sprice*jutsuchakra)*0.5
				maxcooltime = jutsucooldown*20

		Puppet_Shoot
			icon_state="puppet shoot"
			mouse_drag_pointer = "puppet shoot"
			name="Puppet Shoot"
			rank="B"
			signs="<font color=green>None</font><br>"
			uses=100
			Sprice=2
			Clan= CLAN_PUPPET
			reqs = list("First Puppet Summoning")
			Description="Make your puppets load one of their hidden weapons for use. When activated the puppet will fire it dealing damage (Nin|Prc) to the first target it hits."
			New()
				..()
				ChakraCost = (Sprice*jutsuchakra)*0.8
				maxcooltime = jutsucooldown*150

		Puppet_Transform
			icon_state="puppet transform"
			mouse_drag_pointer = "puppet transform"
			name="Puppet Transform"
			rank="B"
			signs="<font color=green>None</font><br>"
			uses=100
			Sprice=1
			Clan= CLAN_PUPPET
			reqs = list("Second Puppet Summoning")
			Description="Make your puppets transform to look identical to you."
			New()
				..()
				ChakraCost = (Sprice*jutsuchakra)*0.6
				maxcooltime = jutsucooldown*100

		Puppet_Grab
			icon_state="puppet grab"
			mouse_drag_pointer = "puppet grab"
			name="Puppet Grab"
			rank="B"
			signs="<font color=green>None</font><br>"
			uses=100
			Sprice=3
			Clan= CLAN_PUPPET
			reqs = list("Puppet Transform")
			Description="Make your puppets loosen their arms' joints, ready to grab a foe and bind them for a duration. Moving the puppet will cancel the bind."
			New()
				..()
				ChakraCost = (Sprice*jutsuchakra)*1.8
				maxcooltime = jutsucooldown*200

		Second_Puppet_Summoning
			icon_state="puppet 2"
			mouse_drag_pointer = "puppet 2"
			name="Second Puppet Summoning"
			rank="B"
			signs="<font color=green>Rabbit,Snake,Snake</font><br>(macro(1,2,2))"
			uses=100
			Sprice=2
			Clan= CLAN_PUPPET
			reqs = list("First Puppet Summoning")
			Description="You summon a second puppet which can uses its hidden weapons to attack opponents by walking into them, dealing damage (Nin|Prc). Hold 'alt' to move it."
			New()
				..()
				ChakraCost = (Sprice*jutsuchakra)*2.5
				maxcooltime = jutsucooldown*250

		Summon_Kazekage_Puppet
			icon_state="kpuppet"
			mouse_drag_pointer = "kpuppet"
			name="Forbiden Tehnique: Kazekage Puppet"
			rank="S"
			signs="<font color=green>Snake,Rabbit,Rat,Rabbit,Snake,Ox</font><br>(macro(2,1,Q,1,2,W))"
			uses=100
			Sprice=2
			Clan= CLAN_PUPPET
			reqs = list("Second Puppet Summoning")
			Description="Summon a Puppet made from body of a Kazekage to pursue and attack your enemy dealing damage (Nin|Prc) provided you remain targeting the victim."
			New()
				..()
				ChakraCost = (Sprice*jutsuchakra)*3
				maxcooltime = jutsucooldown*300

//Senju

/*		WoodClan
			icon_state="wood style"
			mouse_drag_pointer = "wood style"
			name="Wood Style"
			rank="S"
			signs="<font color=green>None</font><br>"
			maxcooltime=0
			ChakraCost = 0
			Sprice=3
			Clan="No Clan"
			Element="Earth"
			Element2="Water"
			Description="Allows one to combine water and earth element to create Wood!"*/

		Tree_Summoning
			icon_state="Tree Summoning"
			mouse_drag_pointer = "Tree Summoning"
			name="Wood Style: Tree Summoning"
			rank="S"
			uses=0
			signs="<font color=green>Dog,Ox,Ox,Ox</font><br>(macro(E,Q,Q,Q))"
			Sprice=4
			Clan= CLAN_SENJU
			reqs=list("Wood Release: Wood Fortress")
			Description="Summon a collection of trees around the target restricting where they can move and dealing damage (Nin) to anyone unfortunate enough to be stood where a tree grows."
			New()
				..()
				ChakraCost = (Sprice*jutsuchakra)*3
				maxcooltime = jutsucooldown*350

		Root_Strangle
			icon_state="Tree Bind"
			mouse_drag_pointer = "Tree Bind"
			name="Wood Release: Root Strangle"
			rank="B"
			uses=0
			signs="<font color=green>Dog,Rabbit,Ox</font><br>(macro(E,1,W))"
			Sprice=4
			Clan= CLAN_SENJU
			reqs=list("Wood Release: Wooden Balvan")
			Description="Grow branches from your arm and send them forth in a straight line to strangle the first target hit dealing damage over time (Nin) and binding them for the duration."
			New()
				..()
				ChakraCost = (Sprice*jutsuchakra)*2.2
				maxcooltime = jutsucooldown*250

		Wood_Balvan//change to/create wood palm
			icon_state="Wood Balvan"
			mouse_drag_pointer = "Wood Balvan"
			name="Wood Release: Wooden Balvan"
			rank="A"
			uses=0
			signs="<font color=green>Dog,Rabbit,Ox,Dog</font><br>(macro(E,1,W,E))"
			Sprice=1
			Clan= CLAN_SENJU
			Description="Produce a balvan and sling it at your target to deal damage (Nin|Prc)"
			New()
				..()
				ChakraCost = (Sprice*jutsuchakra)*2.8
				maxcooltime = jutsucooldown*20

		WoodStyleFortress
			icon_state="WoodStyleFortress"
			mouse_drag_pointer = "WoodStyleFortress"
			name="Wood Release: Wood Fortress"
			rank="B"
			signs="<font color=green>Dog,Dog,Dog,Ox</font><br>(macro(E,E,E,W))"
			Sprice=3
			Clan= CLAN_SENJU
			reqs=list("Wood Release: Root Strangle")
			Description="Create a wooden boundry around you to protect yourself at the cost of restricting your movement for the duration."
			New()
				..()
				ChakraCost = (Sprice*jutsuchakra)*1.5
				maxcooltime = jutsucooldown*190

		Root_Stab // change to/make rampant earth.
			icon_state="Root Stab"
			mouse_drag_pointer = "Root Stab"
			name="Wood Release: Root Stab"
			rank="S"
			uses=0
			signs="<font color=green>Dog,Rabbit,Ox,Dog,Dog</font><br>(macro(E,1,W,E,E))"
			Sprice=3
			maxcooltime = 0
			ChakraCost = 0
			Clan= CLAN_SENJU
			reqs=list("Wood Release: Wood Fortress")
			Description="Summons deadly spikes made out of wood to severely damage ."

		JukaiKoutan // Remove
			icon_state="Jukai"
			mouse_drag_pointer = "Jukai"
			name="Mokuton Hijutsu - Jukai Koutan"
			rank="S"
			signs="<font color=green>Snake,Snake,Rabbit,Rat,Rabbit</font><br>(macro(2,2,1,Q,1))"
			Sprice=4
			maxcooltime = 0
			ChakraCost = 0
			Clan= CLAN_SENJU
			reqs=list("Wood Drill")
			reqs = list("Mokuton - Jubaku Eisou")
			Description=" Jukai Koutan: User creates a forest that will damage everyone in it"

		JubakuEisou
			icon_state="jubakueisou"
			mouse_drag_pointer = "jubakueisou"
			name="Mokuton - Jubaku Eisou"
			rank="B"
			signs="<font color=green>Rat,Snake,Snake,Rabbit</font><br>(macro(Q,2,2,1))"
			Sprice= 0
			maxcooltime= 0
			Clan= CLAN_SENJU
			reqs=list("Wood Drill")
			Description="Jubaku Eisou: User creates a prison made of wood around his target to paralyze him"

		Daijurin
			icon_state="daijurin"
			mouse_drag_pointer = "daijurin"
			name="Mokuton - Daijurin no Jutsu"
			rank="B"
			signs="<font color=green>Rat,Rat,Snake,Rabbit,Rabbit</font><br>(macro(Q,Q,2,1,1))"
			Sprice=1
			maxcooltime= 0
			ChakraCost = 0
			reqs=list("Wood Release: Wooden Balvan")
			Clan= CLAN_SENJU
			Description="Daijurin: User stretchs is arm creating wood from it that wood arm will damage anyone he touches"

//Ink

		Ultimate_Ink_Bird
			icon_state="InkBird"
			mouse_drag_pointer = "InkBird"
			name="Ultimate Ink Bird"
			rank="S"
			signs="<font color=green>Dragon,Rabbit,Monkey,Dog,Rabbit,Dog,Dog</font><br>(macro(5,1,4,E,5,1,E,E))"
			Sprice=5
			Clan= CLAN_INK
			reqs=list("Ink Style: Snake Rustle Jutsu")
			Description="Bring to life a giant bird of ink to divebomb in a line dealing damage (Nin|Agi) to the first enemy it hits."
			New()
				..()
				ChakraCost = (Sprice*jutsuchakra)*3
				maxcooltime = jutsucooldown*600

		Ink_Lions
			icon_state="Ink Lions"
			mouse_drag_pointer = "Ink Lions"
			name="Ultimate Ink Style: Lions"
			rank="S"
			signs="<font color=green>Rabbit,Dragon,Dog,Rabbit,Dragon,Dog</font><br>(macro(1,5,E,1,5,E))"
			Sprice=2
			reqs=list("Ink Style: Snake Rustle Jutsu")
			Clan= CLAN_INK
			Description="Create a number of lions that dash towards your target with their full might and explode dealing damage (Nin|Agi)."
			New()
				..()
				ChakraCost = (Sprice*jutsuchakra)*1.4
				maxcooltime = jutsucooldown*200

		Snake_Rustle_Jutsu
			icon_state="Snake Rustle Jutsu"
			mouse_drag_pointer = "Snake Rustle Jutsu"
			name="Ink Style: Snake Rustle Jutsu"
			rank="B"
			signs="<font color=green>Rabbit,Horse,Monkey,Dragon</font><br>(macro(1,3,4,5))"
			Sprice=2
			Clan= CLAN_INK
			reqs=list("Ink Style: Rats")
			Description="Convert your chakra into drawings of snakes and make them come into motion beneath your target. After a delay, providing you are still targeting your victim, they will lose their footing binding them for a duration."
			New()
				..()
				ChakraCost = (Sprice*jutsuchakra)*2.5
				maxcooltime = jutsucooldown*550

		Sai_Snakes
			icon_state="Sai Snakes"
			mouse_drag_pointer = "Sai Snakes"
			name="Ink Style: Snakes"
			rank="A"
			signs="<font color=green>Rabbit,Dragon,Dog,Monkey,Rabbit</font><br>(macro(1,5,E,4,1))"
			Sprice=2
			Clan= CLAN_INK
			reqs=list("Ink Style: Snake Rustle Jutsu")
			Description="Send forth snakes of ink to bite into the first enemy they hit dealing damage (Nin|Prc)."
			New()
				..()
				ChakraCost = (Sprice*jutsuchakra)*1.2
				maxcooltime = jutsucooldown*160

		Sai_Rat
			icon_state="SaiRat"
			mouse_drag_pointer = "SaiRat"
			name="Ink Style: Rats"
			rank="B"
			signs="<font color=green>Rabbit,Dog,Monkey,Rabbit</font><br>(macro(1,E,4,1))"
			Sprice=2
			Clan= CLAN_INK
			Description="Draw rats and cast them out onto the battlefield peircing through anyone in their path dealing damage (Nin|Prc)."
			New()
				..()
				ChakraCost = (Sprice*jutsuchakra)*0.8
				maxcooltime = jutsucooldown*80

//Weaponist
		Rising_Dragon
			icon_state="RTD"
			mouse_drag_pointer = "RTD"
			name="Rising Dragon"
			rank="B"
			signs="<font color=green>Dragon,Horse,Dragon,Horse,Snake</font><br>(macro(5,3,5,3,2))"
			Clan= CLAN_WEAPONIST
			reqs = list("Blade Hurricane")
			Sprice=5
			Description="Summon a relentless barrage of weaponry throwing them in a large wave towards a target or in an area of effect in front of you dealing damage (Nin|Prc) with every hit."
			New()
				..()
				ChakraCost = (Sprice*jutsuchakra)*2.8
				maxcooltime = jutsucooldown*600

		Weapon_Manipulation_Jutsu
			icon_state="wmj"
			mouse_drag_pointer = "wmj"
			name="Weapon Manipulation Jutsu"
			rank="A"
			signs="<font color=green>Dragon,Horse,Dragon,Horse</font><br>(macro(5,3,5,3))"
			Sprice=3
			Clan= CLAN_WEAPONIST
			reqs = list("Demon Wind Shuriken")
			Description="Throw a number of weapons tied together with a chakra string causing them to home in and pierce through anyone in their way dealing damage (Nin|Prc) with each hit."
			New()
				..()
				ChakraCost = (Sprice*jutsuchakra)*1.8
				maxcooltime = jutsucooldown*200

		Blade_Hurricane
			icon_state="bladehurri"
			mouse_drag_pointer = "bladehurri"
			name="Blade Hurricane"
			rank="A"
			signs="<font color=green>Dragon,Horse,Dragon,Horse,Rabbit</font><br>(macro(5,3,5,3,1))"
			Sprice=3
			Clan= CLAN_WEAPONIST
			reqs=list("Weapon Manipulation Jutsu")
			Description="Move around irratically and throw out weaponry all around you dealing damage (Nin|Prc) to anyone hit."
			New()
				..()
				ChakraCost = (Sprice*jutsuchakra)*1.7
				maxcooltime = jutsucooldown*150

		Demon_Wind_Shuriken
			icon_state="Demon Wind Shuriken"
			mouse_drag_pointer = "Demon Wind Shuriken"
			name="Demon Wind Shuriken"
			rank="A"
			signs="<font color=green>Dragon,Horse,Horse,Dragon,Dragon</font><br>(macro(5,3,3,5,5))"
			Clan= CLAN_WEAPONIST
			Sprice=3
			Description="Throw a large demon wind shuriken connected to you with a chakra thread at your target or in a line in front of you dealing damage (Nin|Prc) to the first target it hits. Once it reaches it's full range or hits a target you pull back on the thread causing it to return to you and deal damage (Nin|Prc) to anyone in it's path."
			New()
				..()
				ChakraCost = (Sprice*jutsuchakra)*2
				maxcooltime = jutsucooldown*100

		TwinDragons
			icon_state="twindragons"
			mouse_drag_pointer = "twindragons"
			name="Twin Dragons"
			rank="S"
			signs="<font color=green>Dragon,Horse,Dragon,Horse,Dragon,Dragon</font><br>(macro(5,3,5,3,5,5))"
			Sprice=5
			maxcooltime = 0
			ChakraCost = 0
			Clan= CLAN_WEAPONIST
			reqs = list("Weapon Manipulation Jutsu")
			Description="Tie several kunai along a chakra string and throw to home in on a target."

		Blade_Manipulation_Jutsu
			icon_state="Blade Manipulation Jutsu"
			mouse_drag_pointer = "Blade Manipulation Jutsu"
			name="Blade Manipulation Jutsu"
			rank="B"
			Clan= CLAN_WEAPONIST
			signs="<font color=green>Dragon,Horse,Dragon</font><br>(macro(5,3,5))"
			Sprice=2
			maxcooltime = 0
			ChakraCost = 0
			Description="Tie several kunai along a chakra string and throw to home in on a target."

//Akimichi

		GreenPill
			icon_state="GreenPill"
			mouse_drag_pointer = "GreenPill"
			name="GreenPill"
			rank="D"
			Sprice=1
			Clan= CLAN_AKIMICHI
			uses=100
			signs="<font color=green>None</font><br>"
			Description="Take a green pill which infuses your body with chakra increasing your Taijutsu but burns calories causing a loss in health."
			New()
				..()
				ChakraCost = (Sprice*jutsuchakra)
				maxcooltime = jutsucooldown*200

		YellowPill
			icon_state="YellowPill"
			mouse_drag_pointer = "YellowPill"
			name="YellowPill"
			rank="C"
			Sprice=1
			Clan= CLAN_AKIMICHI
			uses=100
			signs="<font color=green>None</font><br>"
			reqs=list("GreenPill")
			Description="Take a yellow pill which infuses your body with chakra increasing your Taijutsu but burning calories causing a loss in health. Both the positive and negative effects are stronger than the green pill."
			New()
				..()
				ChakraCost = (Sprice*jutsuchakra)
				maxcooltime = jutsucooldown*250

		RedPill
			icon_state="RedPill"
			mouse_drag_pointer = "RedPill"
			name="RedPill"
			rank="B"
			uses=100
			Sprice=1
			Clan= CLAN_AKIMICHI
			signs="<font color=green>None</font><br>"
			reqs=list("YellowPill")
			Description="Take a red pill which infuses your body with chakra increasing your Taijutsu but burning calories causing a loss in health. Both the positive and negative effects are stronger than the yellow pill"
			New()
				..()
				ChakraCost = (Sprice*jutsuchakra)
				maxcooltime = jutsucooldown*300

		HumanBulletTank
			icon_state="Human Bullet Tank"
			mouse_drag_pointer = "Human Bullet Tank"
			name="Human Bullet Tank"
			rank="A"
			Clan= CLAN_AKIMICHI
			signs="<font color=green>None</font><br>"
			Sprice=5
			uses=100
			reqs=list("YellowPill")
			Description="Transform your body into a large ball of body fat and roll around with starling velocity. Deals damage (Str|Nin) and knocks down anyone hit and deals more damage if you hit someone directly."
			New()
				..()
				ChakraCost = (Sprice*jutsuchakra)*1.6
				maxcooltime = jutsucooldown*300

		CalorieControl
			icon_state="CalorieControl"
			mouse_drag_pointer = "CalorieControl"
			name="Calorie Control"
			rank="S"
			signs="<font color=green>Ox,Ox,Dragon,Ox</font><br>(macro(W,W,5,W))"
			Sprice=3
			Clan= CLAN_AKIMICHI
			reqs=list("RedPill")
			Description="Control the calories in your body and convert them into chakra which greatly enhances your Taijutsu and forms as bright blue butterfly wings. It can be just as powerful as your pills but without the downsides."
			New()
				..()
				ChakraCost = (Sprice*jutsuchakra)*2.5
				maxcooltime = jutsucooldown*280

		SuperMultiSizeTechnique//multisizestuff
			icon_state="baika"
			mouse_drag_pointer = "baika"
			name="Super Multi-Size Technique"
			rank="D"
			signs="<font color=green>None</font><br>"
			Clan= CLAN_AKIMICHI
			reqs=list("RedPill")
			Sprice=4
			uses=100
			Description="Convert your calories into vast amounts of chakra allowing you to grow in size exponencially for a duration. While in this form it is much easier for people to hit you and impossible to fit through tight spaces but you are able to smash the ground with 'S' dealing damage (Str|Nin) in a large radius around you and you're far more resistent to most damage. You must use Colorie Control or the Red Pill to be able to control your body well enough to use this."
			New()
				..()
				ChakraCost = (Sprice*jutsuchakra)*3
				maxcooltime = jutsucooldown*600
//Sand

		Sand
			icon_state="Sand"
			mouse_drag_pointer = "Sand"
			name="Sand"
			rank="S"
			signs="<font color=green>None</font><br>"
			maxcooltime = 0
			ChakraCost = 0
			Sprice=1
			Clan= CLAN_SAND
			Element="Earth"
			Description="Gain the ability to infuse your chakra into sand."

		Shukakku_Spear
			icon_state="Shukakku Spear"
			mouse_drag_pointer = "Shukakku Spear"
			name="Shukakku Spear"
			rank="S"
			uses=0
			signs="<font color=green>Dog,Dog,Ox,Dog</font><br>(macro(E,E,W,E))"
			Sprice=3
			Clan= CLAN_SAND
			reqs=list("Sand Shuriken")
			Description="Summon sand from the earth and use it to form a powerful spear for hurling towards your foes dealing damage (Nin|Prc) and piercing through enemies."
			New()
				..()
				ChakraCost = (Sprice*jutsuchakra)*1.2
				maxcooltime = jutsucooldown*250

		Sand_Funeral
			icon_state="Sand Funeral"
			mouse_drag_pointer = "Sand Funeral"
			name="Sand Funeral"
			rank="S"
			uses=0
			signs="<font color=green>Dog,Ox,Ox,Dog</font><br>(macro(E,W,W,E))"
			Sprice=3
			Clan= CLAN_SAND
			reqs=list("Desert Coffin")
			Description="Use the sand wrapped around your foe from Desert Coffin to crush the person trapped inside dealing damage (Nin)."
			New()
				..()
				ChakraCost = (Sprice*jutsuchakra)*1.4
				maxcooltime = jutsucooldown*30

		Sand_Shuriken
			icon_state="Sand Shuriken"
			mouse_drag_pointer = "Sand Shuriken"
			name="Sand Shuriken"
			rank="S"
			uses=0
			signs="<font color=green>Dog,Dog,Ox</font><br>(macro(E,E,W))"
			Sprice=2
			Clan= CLAN_SAND
			Description="Summon sand from the earth and use it to form multiple shurikens for hurling towards your foes dealing damage (Nin|Prc) and piercing through enemies."
			New()
				..()
				ChakraCost = (Sprice*jutsuchakra)*0.8
				maxcooltime = jutsucooldown*100

		Desert_Coffin
			icon_state="Desert Coffin"
			mouse_drag_pointer = "Desert Coffin"
			name="Desert Coffin"
			rank="S"
			uses=0
			signs="<font color=green>Dog,Dog,Ox,Ox</font><br>(macro(E,E,W,W))"
			Sprice=2
			Clan= CLAN_SAND
			Description="Summon sand from the earth and use it to trap your opponent. After a delay your target will be bound for a duration providing you are still targeting them."
			New()
				..()
				ChakraCost = (Sprice*jutsuchakra)*2.2
				maxcooltime = jutsucooldown*340

		Sand_Shield
			icon_state="Sand Shield"
			mouse_drag_pointer = "Sand Shield"
			name="Sand Shield"
			rank="B"
			signs="<font color=green>Dog,Ox,Dog,Ox</font><br>(macro(E,W,E,W))"
			Sprice=3
			Clan= CLAN_SAND
			uses=0
			reqs=list("Desert Coffin")
			Description="Creates a shield of sand around you which protects you from damage for a duration however you are unable to perform any actions during this time."
			New()
				..()
				ChakraCost = (Sprice*jutsuchakra)*1
				maxcooltime = jutsucooldown*450

//Crystal

		Crystal_Shards
			icon_state="Crystal Shards"
			mouse_drag_pointer = "Crystal Shards"
			name="Crystal Release: Crystal Shards"
			rank="B"
			uses=0
			signs="<font color=green>Ox,Rabbit,Dog</font><br>(macro(W,1,E))"
			Sprice=2
			Clan= CLAN_CRYSTAL
			Description="Focuses chakra in order to create a shard to strike the enemy dealing damage (Nin)."
			New()
				..()
				ChakraCost = (Sprice*jutsuchakra)*1.4
				maxcooltime = jutsucooldown*100

		Crystal_Needles
			icon_state="Crystal Needles"
			mouse_drag_pointer = "Crystal Needles"
			name="Crystal Release: Crystal Needles"
			rank="A"
			uses=0
			signs="<font color=green>Dog,Rabbit,Rabbit,Dog</font><br>(macro(E,1,1,E))"
			Sprice=3
			Clan= CLAN_CRYSTAL
			reqs=list("Crystal Release: Crystal Shards")
			Description="Focuses chakra in order to create a some crystal needles that pierce through the enemy dealing damage (Nin)."
			New()
				..()
				ChakraCost = (Sprice*jutsuchakra)*1.4
				maxcooltime = jutsucooldown*70

		Crystal_Spikes
			icon_state="Crystal Spikes"
			mouse_drag_pointer = "Crystal Spikes"
			name="Crystal Release: Crystal Spikes"
			rank="B"
			signs="<font color=green>Rabbit,Dog,Dog,Ox</font><br>(macro(1,E,E,W))"
			Sprice=2
			Clan= CLAN_CRYSTAL
			reqs=list("Crystal Release: Crystal Needles")
			Description="Deadly spikes made out of crystal that come out of ground to stab users target dealing damage (Nin)."
			New()
				..()
				ChakraCost = (Sprice*jutsuchakra)*1.3
				maxcooltime = jutsucooldown*300

		Crystal_Explosion
			icon_state="Crystal Explosion"
			mouse_drag_pointer = "Crystal Explosion"
			name="Crystal Release: Crystal Explosion"
			rank="S"
			uses=0
			signs="<font color=green>Rabbit,Rabbit,Ox,Dog,Dog</font><br>(macro(1,1,W,E,E))"
			Sprice=4
			Clan= CLAN_CRYSTAL
			reqs=list("Crystal Release: Crystal Spikes")
			Description="Pump your chakra into the ground and create a wave of deadly crystal spikes that explode out of the ground in a line in front of you dealing damage (Nin) to anyone in it's way."
			New()
				..()
				ChakraCost = (Sprice*jutsuchakra)*1.9
				maxcooltime = jutsucooldown*300

		Crystal_Mirrors
			icon_state="Crystal Mirrors"
			mouse_drag_pointer = "Crystal Mirrors"
			name="Crystal Mirrors"
			rank="B"
			signs="<font color=green>Ox,Rabbit,Dog,Ox</font><br>(macro(W,1,E,W))"
			Sprice=3
			maxcooltime = 0
			ChakraCost = 0
			Clan= CLAN_CRYSTAL
			reqs=list("Crystal Pillar")
			Description="Crystal Mirrors: This technique creates solid mirrors of the hardest iron in the world, Crystal. Allowing you to attack from each & every mirror."

		Crystal_Arrow
			icon_state="Crystal Arrow"
			mouse_drag_pointer = "Crystal Arrow"
			name="Crystal Arrow"
			rank="S"
			signs="<font color=green>Ox,Rabbit,Dog,Ox,Ox,Rabbit,Dog,Ox</font><br>(macro(W,1,E,W,W,1,E,W))"
			Sprice=3
			maxcooltime = 0
			ChakraCost = 0
			Clan= CLAN_CRYSTAL
			reqs=list("Crystal Mirrors")
			Description="Crystal Arrow: An Giant Arrow shot by the will & the determination of the user."


		Crystal_Pillar
			icon_state="Crystal Pillar"
			mouse_drag_pointer = "Crystal Pillar"
			name="Crystal Pillar"
			rank="S"
			signs="<font color=green>Ox,Ox,Dog,Rabbit</font><br>(macro(W,W,E,1))"
			Sprice=3
			maxcooltime = 0
			ChakraCost = 0
			Clan= CLAN_CRYSTAL
			Description="Crystal Pillar: An Giant Arrow shot by the will & the determination of the user."

//Paper

		Paper_Control
			icon_state="Paper Control"
			mouse_drag_pointer = "Paper Control"
			name="Paper Control"
			rank="S"
			signs="<font color=green>None</font><br>"
			Sprice=1
			maxcooltime = 0
			ChakraCost = 0
			Clan= CLAN_PAPER
			Description="Gain the ability to convert chakra into paper."

		Paper_Chakram
			icon_state="Paper Chakram"
			mouse_drag_pointer = "Paper Chakram"
			name="Paper Chakram"
			rank="B"
			signs="<font color=green>Ox,Rat</font><br>(macro(W,Q))"
			uses=100
			Clan= CLAN_PAPER
			Sprice=2
			Description="Bring sheets of paper together into a sharp chakram and send it at your foe dealing damage (Nin)."
			New()
				..()
				ChakraCost = (Sprice*jutsuchakra)*1.7
				maxcooltime = jutsucooldown*70

		Shikigami_Spear
			icon_state="Shikigami Spear"
			mouse_drag_pointer = "Shikigami Spear"
			name="Shikigami Spear"
			rank="A"
			signs="<font color=green>Ox,Rat,Ox</font><br>(macro(W,Q,W))"
			uses=0
			Clan= CLAN_PAPER
			Sprice=4
			Description="Channel your chakra through paper and fire a deadly spear created from it dealing damage to the first target it hits (Nin)."
			New()
				..()
				ChakraCost = (Sprice*jutsuchakra)*2.2
				maxcooltime = jutsucooldown*300

		Shikigami_Dance
			icon_state="Shikigami Dance"
			mouse_drag_pointer = "Shikigami Dance"
			name="Shikigami Dance"
			rank="A"
			signs="<font color=green>Ox,Rat,Rat,Rat</font><br>(macro(W,Q,Q,Q))"
			uses=0
			Clan= CLAN_PAPER
			reqs = list("Paper Chakram")
			Sprice=4
			Description="Send sheets of paper to stick to your target holding them in place. After a delay, providing you're still targeting them the victim will be bound for a duration."
			New()
				..()
				ChakraCost = (Sprice*jutsuchakra)*3.2
				maxcooltime = jutsucooldown*550

		Angel_Wings
			icon_state="Angel Wings"
			mouse_drag_pointer = "Angel Wings"
			name="Angel Wings"
			rank="S"
			signs="<font color=green>Rat,Ox,Ox,Rat</font><br>(macro(Q,W,W,Q))"
			uses=100
			Clan= CLAN_PAPER
			reqs = list("Paper Chakram")
			Sprice=3
			Description="Creates huge Paper Wings which boost your paper jutsus power. The following jutsu gain an additional effect: Shikigami Dance lasts longer and Shikigami Spear activates faster."
			New()
				..()
				ChakraCost = (Sprice*jutsuchakra)*1.5
				maxcooltime = jutsucooldown*600

//Jashin

		Jashin_Religion
			icon_state="Jashin Religion"
			mouse_drag_pointer = "Jashin Religion"
			name="Jashin Religion"
			rank="S"
			signs="<font color=green>None</font><br>"
			Sprice=1
			maxcooltime = 0
			ChakraCost = 0
			Clan= CLAN_JASHIN
			Description="Learn to worship the god, Lord Jashin, and harness the powers of death and immortality.(You will no long be a non clan ninja by commiting to Lord Jashin)"

		Death_Ruling_Possesion_Blood
			icon_state="Death Ruling Possesion Blood"
			mouse_drag_pointer = "Death Ruling Possesion Blood"
			name="Sorcery: Death Ruling Possesion Blood"
			rank="S"
			signs="<font color=green>None</font><br>"
			Sprice=4
			uses=100
			Clan= CLAN_JASHIN
			Description="Use someones blood to perform a deadly ritual turning yourself into a voodoo doll that will deal damage to that person when you yourself take damage. To perform the jutsu stand on top of someones blood and use to jutsu to create a circle. Providing you remain in the circle you can press S to deal damage to yourself and that player. Additionally any instance of damage taken will trigger additional hits to both yourself and the victim. Unlike other jutsu this jutsus damage scales from your maximum health."
			New()
				..()
				ChakraCost = (Sprice*jutsuchakra)*1
				maxcooltime = jutsucooldown*600

		Immortality
			icon_state="Immortality"
			mouse_drag_pointer = "Immortality"
			name="Sacrifice to Jashin"
			rank="S"
			signs="<font color=green>None</font><br>"
			Sprice=4
			uses=100
			reqs = list("Sorcery: Death Ruling Possesion Blood")
			Clan= CLAN_JASHIN
			Description="Pray to jashin and kill someone within the time limit to offer a sacrifice to Lord Jashin causing you to become immortal for a duration. During this time your health cannot be dropped below 1."
			New()
				..()
				ChakraCost = (Sprice*jutsuchakra)*1
				maxcooltime = jutsucooldown*450

		Immortal
			icon_state="Immortal"
			mouse_drag_pointer = "Immortal"
			name="Immortal"
			rank="S"
			signs="<font color=green>None</font><br>"
			Sprice=4
			uses=100
			reqs = list("Sacrifice to Jashin")
			Clan= CLAN_JASHIN
			Description="If Lord Jashin is pleased with you service you can become immortal on demand for a duration. During this time your health cannot drop below 1. Use the jutsu to see how many more sacrifices must be offered to achieve Lord Jashin's favor."
			New()
				..()
				ChakraCost = (Sprice*jutsuchakra)*1
				maxcooltime = jutsucooldown*600

//Spider

		Spider
			icon_state="Spider"
			mouse_drag_pointer = "SpiderSpider"
			name="Spider"
			rank="B"
			signs="<font color=green>None</font><br>"
			Clan= CLAN_SPIDER
			Description="Develop mutations and become more like a spider!"
			maxcooltime = 0
			ChakraCost = 0

		WebShoot
			icon_state="WebShoot"
			mouse_drag_pointer = "WebShoot"
			name="Spider Web Shoot"
			rank="B"
			signs="<font color=green>None</font><br>"
			uses=100
			Sprice=3
			Clan= CLAN_SPIDER
			Description="Fires off a spider web that can bind the target on hit."
			New()
				..()
				ChakraCost = (Sprice*jutsuchakra)*2.4
				maxcooltime = jutsucooldown*200

		ArrowShoot
			icon_state="ArrowShoot"
			mouse_drag_pointer = "ArrowShoot"
			name="Spider Arrow Shoot"
			rank="A"
			signs="<font color=green>None</font><br>"
			uses=100
			Sprice=3
			Clan= CLAN_SPIDER
			reqs = list("Spider Web Shoot")
			Description="Fires off a deadly arrow that pierces through anythingin it's path dealing damage (Nin|Prc)"
			New()
				..()
				ChakraCost = (Sprice*jutsuchakra)*1.6
				maxcooltime = jutsucooldown*80

		Summon_Spider
			icon_state="spiders"
			mouse_drag_pointer = "spiders"
			name="Summon Spider"
			rank="S"
			Sprice = 5
			signs="<font color=green>Ox,Horse,Horse,Dog,Ox,Horse</font><br>(macro(W,3,3,E,W,3))"
			//uses=100
			Clan= CLAN_SPIDER
			reqs = list("Spider Arrow Shoot")
			Description="Summon a huge spider to fight for your cause in combat! It will chase your target dealing damage (Nin) to them providing you maintain your target."
			New()
				..()
				ChakraCost = (Sprice*jutsuchakra)*3
				maxcooltime = jutsucooldown*600

//Uzumaki


		Seal_of_Terror
			icon_state="CT"
			mouse_drag_pointer="CT"
			name="Sealing Technique: Seal of Terror"
			Clan="Uzumaki"
			rank="B"
			signs="<font color=green>Monkey,Rabbit,Rabbit,Monkey</font><br>(macro(4,1,1,4))"
			Sprice=3
			Description="A powerful jutsu that creates a strong bind which restricts movement of a person and also damages them for a huge amount."
			New()
				..()
				ChakraCost = (Sprice*jutsuchakra)
				maxcooltime = jutsucooldown

		Soul_Devastator_Seal
			icon_state="SD"
			mouse_drag_pointer = "SD"
			name="Soul Devastator Seal"
			rank="A"
			signs="<font color=green>Rabbit,Snake,Horse,Rabbit,Rat</font><br>(macro(1,2,3,1,Q))"
			Sprice=3
			uses=0
			Clan="Uzumaki"
			reqs = list("Sealing Technique: Seal of Terror")
			Description="A powerful immobilising seal capable of binding even the most powerful shinobi."
			New()
				..()
				ChakraCost = (Sprice*jutsuchakra)
				maxcooltime = jutsucooldown

		LimbParalyzeSeal
			icon_state="LimbParalyzeSeal"
			mouse_drag_pointer = "LimbParalyzeSeal"
			name="Sealing Jutsu: Limb Paralyzis"
			rank="B"
			signs="<font color=green>Rabbit,Rabbit,Monkey,Monkey</font><br>(macro(1,1,4,4))"
			Sprice=4
			Clan="Uzumaki"
			reqs = list("Soul Devastator Seal")
			Description="Limb Paralyze Seal: This technique stuns your opponent for a certain amount of time"
			New()
				..()
				ChakraCost = (Sprice*jutsuchakra)
				maxcooltime = jutsucooldown

		Reaper_Death_Seal
			icon_state="RDS"
			mouse_drag_pointer="RDS"
			name="Reaper Death Seal"
			Clan="Uzumaki"
			rank="S"
			reqs = list("Soul Devastator Seal")
			signs="<font color=green>Dragon,Rat,Rabbit,Dragon,Rabbit,Rabbit,Rat</font><br>(macro(5,Q,1,5,1,1,Q))"
			Sprice=5
			uses=100
			Description="An advanced move which cuts the enemies life pool by a large amount. Deals a huge amount of damage to the user himself aswell."
			New()
				..()
				ChakraCost = (Sprice*jutsuchakra)
				maxcooltime = jutsucooldown

//Bubble

		Bubble_Trouble
			icon_state="Bubble Trouble"
			mouse_drag_pointer = "Bubble Trouble"
			name="Bubble Trouble"
			rank="A"
			signs="<font color=green>Rabbit,Rabbit,Dragon,Rabbit,Dragon,Rabbit,Dragon,Dragon</font><br>(macro(1,1,5,1,5,1,5,5))"
			Sprice=4
			reqs=list("Bubble Barrage")
			Clan= CLAN_BUBBLE
			Description="Create tempest of bubbles in a straight line dealing damage (Nin) to the first person it hits."
			New()
				..()
				ChakraCost = (Sprice*jutsuchakra)*2.2
				maxcooltime = jutsucooldown*300

		Bubble_Spreader
			icon_state="Bubble Spreader"
			mouse_drag_pointer = "Bubble Spreader"
			name="Bubble Spreader"
			rank="B"
			signs="<font color=green>Dog,Dog,Dragon,Dog</font><br>(macro(E,E,5,E))"
			Sprice=4
			Clan= CLAN_BUBBLE
			Description="Creates bubbles and spreads them in every direction. The bubbles will float around and explode dealing damage (Nin) to anyone nearby. If you have a target they will home in however at the cost of dealing significantly less damage."
			New()
				..()
				ChakraCost = (Sprice*jutsuchakra)*2.5
				maxcooltime = jutsucooldown*180

		Bubble_Barrage
			icon_state="Bubble Barrage"
			mouse_drag_pointer = "Bubble Barrage"
			name="Bubble Barrage"
			rank="B"
			signs="<font color=green>Rabbit,Rabbit,Dragon,Rabbit</font><br>(macro(1,1,5,1))"
			Sprice=3
			reqs=list("Bubble Spreader")
			Clan= CLAN_BUBBLE
			Description="Blow bubbles towards your target which explode on contact dealing damage (Nin)."
			New()
				..()
				ChakraCost = (Sprice*jutsuchakra)*1.4
				maxcooltime = jutsucooldown*180

		Bubble_Shield//bubblshieldstuff
			icon_state="BubbleShield"
			mouse_drag_pointer = "BubbleShield"
			name="Bubble Shield"
			rank="D"
			signs="<font color=green>Dog,Dog,Dog,Dog</font><br>(macro(E,E,E,E))"
			Clan= CLAN_BUBBLE
			Sprice=2
			Description="Protect yourself with a large bubble blocking the next single instance of damage you would take."
			New()
				..()
				ChakraCost = (Sprice*jutsuchakra)
				maxcooltime = jutsucooldown*200

//Fire

		FireBall
			icon_state="fireball"
			mouse_drag_pointer = "fireball"
			name="Fire Release: Fire Ball"
			rank="D"
			signs="<font color=green>Dog,Dog,Rat</font><br>(macro(E,E,Q))"
			Sprice=1
			Element="Fire"
			Description="Unleash a small fireball from your mouth towards a target to deal damage (Nin) and has a chance to set them on fire."
			New()
				..()
				ChakraCost = (Sprice*jutsuchakra)*1.8
				maxcooltime = jutsucooldown*60

		AFireBall
			icon_state="Afireball"
			mouse_drag_pointer = "Afireball"
			name="Fire Release: Blazing Sun"
			rank="A"
			signs="<font color=green>Dog,Rat,Dog,Rabbit,Snake</font><br>(macro(E,Q,E,1,2))"
			reqs=list("Fire Release: Fire Ball")
			Sprice=2
			Element="Fire"
			Specialist = "Ninjutsu"
			Description="Similar to fireball but significantly larger and can hit multiple opponents to deal damage (Nin). After it hits it leaves the ground in flames dealing damage to anyone foolish enough to remain there."
			New()
				..()
				ChakraCost = (Sprice*jutsuchakra)*1.3
				maxcooltime = jutsucooldown*175

		Fire_Release_Ash_Pile_Burning
			icon_state="Ash Pile Burning"
			mouse_drag_pointer = "Ash Pile Burning"
			name="Fire Release: Ash Pile Burning"
			rank="B"
			signs="<font color=green>Dog,Rat,Dog,Rabbit,Dog</font><br>(macro(E,Q,E,1,E))"
			Sprice=2
			Element="Fire"
			reqs=list("Fire Release: Fire Ball")
			Description="Spew ash from your mouth in a wide area in front of you. You can press the down arrow to ignite the ash causing an area of flames that will burn anyone who stands there. Burn victims will take damage over time (Nin) for a duration."
			New()
				..()
				ChakraCost = (Sprice*jutsuchakra)*2.4
				maxcooltime = jutsucooldown*600

		PheonixFire
			icon_state="fireballs"
			mouse_drag_pointer = "fireballs"
			name="Fire Release: Phoenix Immortal Fire Technique"
			rank="C"
			signs="<font color=green>Dog,Rat,Rat,Dog</font><br>(macro(E,Q,Q,E))"
			Sprice=3
			Element="Fire"
			reqs=list("Fire Release: Ash Pile Burning")
			Description="Spit a volly of fireballs towards a target which deal damage (Nin) and have a chance to set them on fire."
			New()
				..()
				ChakraCost = (Sprice*jutsuchakra)*1.5
				maxcooltime = jutsucooldown*250

		Fire_Dragon_Projectile
			icon_state="Fire Dragon Projectile"
			mouse_drag_pointer = "Fire Dragon Projectile"
			name="Fire Release: Fire Dragon Projectile"
			rank="C"
			signs="<font color=green>Dog,Rat,Rat,Dog,Dog,Rat,Dog,Rat</font><br>(macro(E,Q,Q,E,E,Q,E,Q))"
			Sprice=4
			Element="Fire"
			reqs=list("Fire Release: Phoenix Immortal Fire Technique")
			Description="Breath a raging blast of fire out of your mouth in a line which deals damage (Nin) to the first target hit.."
			New()
				..()
				ChakraCost = (Sprice*jutsuchakra)*2.2
				maxcooltime = jutsucooldown*400
//Magma

		Magma_Crush
			icon_state="Magma Crush"
			mouse_drag_pointer = "Magma Crush"
			name="Magma Style: Magma Cage"
			rank="B"
			signs="<font color=green>Rabbit,Snake,Dog,Rat</font><br>(macro(1,2,E,Q))"
			Sprice=2
			Element="Fire"
			reqs=list("Fire Release: Fire Dragon Projectile")
			Description="Channel the forces of the heat in the air to create a large cage with floating magma binding the target for the duration but also protecting them from damage."
			New()
				..()
				ChakraCost = (Sprice*jutsuchakra)*3.4
				maxcooltime = jutsucooldown*650

		Magma_Needles
			icon_state="Magma Needles"
			mouse_drag_pointer = "Magma Needles"
			name="Magma Style: Magma Needles"
			rank="A"
			signs="<font color=green>Rabbit,Dog,Snake,Rabbit</font><br>(macro(1,E,2,1))"
			Sprice=2
			Element="Fire"
			reqs=list("Magma Style: Magma Cage")
			Description="Form deadly flaming needles and shoot them at a target to impale them and deal damage (Nin|Prc)."
			New()
				..()
				ChakraCost = (Sprice*jutsuchakra)*1.2
				maxcooltime = jutsucooldown*180

//Earth

		Earth_Release_Earth_Cage
			icon_state="Doton Cage"
			mouse_drag_pointer = "Doton Cage"
			name="Earth Release: Earth Cage"
			rank="B"
			signs="<font color=green>Rabbit,Snake,Snake,Dog,Rat</font><br>(macro(1,2,2,E,Q))"
			Sprice=2
			Element="Earth"
			Description="Channel the forces of the earth into a large cage like structure around your opponent, binding them but also protecting them from damage for the duration."
			New()
				..()
				ChakraCost = (Sprice*jutsuchakra)*3.4
				maxcooltime = jutsucooldown*650

		Earth_Disruption
			icon_state="Earth Disruption"
			mouse_drag_pointer = "Earth Disruption"
			name="Earth Disruption"
			rank="D"
			signs="<font color=green>Rabbit,Rabbit,Rabbit</font><br>(macro(1,1,1))"
			Sprice=2
			uses=0
			Element = "Earth"
			reqs = list("Earth Release: Earth Cage")
			Description="Charge your fist with chakra and plummet it into the ground, knocking down nearby enemies and dealing damage (Nin)"
			New()
				..()
				ChakraCost = (Sprice*jutsuchakra)*1.8
				maxcooltime = jutsucooldown*200

		Earth_Style_Dark_Swamp
			icon_state="Earth Style Dark Swamp"
			mouse_drag_pointer = "Earth Style Dark Swamp"
			name="Earth Release: Dark Swamp"
			rank="C"
			signs="<font color=green>Rabbit,Rabbit</font><br>(macro(1,1))"
			Sprice=3
			uses=0
			Element = "Earth"
			reqs = list("Earth Disruption")
			Description="Turn the ground your target is standing on into thick mud and make their movement impaired."
			New()
				..()
				ChakraCost = (Sprice*jutsuchakra)*1.6
				maxcooltime = jutsucooldown*150

		Earth_Release_Mud_River
			icon_state="Mud River"
			mouse_drag_pointer = "Mud River"
			name="Earth Release: Mud River"
			rank="B"
			signs="<font color=green>Rabbit,Rabbit,Monkey</font><br>(macro(1,1,4))"
			reqs=list("Earth Release: Mud Wall")
			Sprice=2
			Element="Earth"
			Description="Cause the ground your is standing on turn into mud to attempt to cause them to lose their footing. After a delay if you are still targeting them they will be bound for a duration."
			New()
				..()
				ChakraCost = (Sprice*jutsuchakra)*2.5
				maxcooltime = jutsucooldown*550

		MudWall
			icon_state="MudWall"
			mouse_drag_pointer = "MudWall"
			name="Earth Release: Mud Wall"
			rank="A"
			signs="<font color=green>Rabbit,Rabbit,Rabbit,Rabbit</font><br>(macro(1,1,1,1))"
			Sprice=3
			uses=0
			Element = "Earth"
			reqs = list("Doton Doryuusou no Jutsu")
			Description="Bring forth a wall of earth from the ground to protect you from projectiles. The wall has health and can be destroyed and it will not protect you from everything."
			New()
				..()
				ChakraCost = (Sprice*jutsuchakra)*1.3
				maxcooltime = jutsucooldown*350

		EarthBoulder
			icon_state="EarthBoulder"
			mouse_drag_pointer = "EarthBoulder"
			name="Earth Release: Earth Boulder"
			rank="B"
			signs="<font color=green>Rabbit,Rabbit,Rabbit,Snake</font><br>(macro(1,1,1,2))"
			Sprice=3
			Element="Earth"
			reqs = list("Earth Release: Mud River")
			Description="Creates a massive boulder made from earth itself and throws it foward smashing anything in it's way."
			New()
				..()
				ChakraCost = (Sprice*jutsuchakra)
				maxcooltime = jutsucooldown*190

		Dango
			icon_state="dango"
			mouse_drag_pointer = "dango"
			name="Doton Doryo Dango"
			rank="S"
			signs="<font color=green>Dog,Dog,Ox,Rabbit</font><br>(macro(E,E,W,1))"
			Sprice=1
			Element="Earth"
			reqs=list("Earth Release: Mud Wall")
			Description="Dango: Throws a Huge Rock in user's direction"
			New()
				..()
				ChakraCost = (Sprice*jutsuchakra)
				maxcooltime = jutsucooldown*250

		Doryuusou
			icon_state="doryuusou"
			mouse_drag_pointer = "doryuusou"
			name="Doton Doryuusou no Jutsu"
			rank="A"
			signs="<font color=green>Dragon,Snake,Monkey</font><br>(macro(5,2,4))"
			Sprice=1
			Element="Earth"
			Description="Send a wave of chakra through the ground to erupt at your targets location dealing damage. This occurs after a delay providing you are still targeting them."
			New()
				..()
				ChakraCost = (Sprice*jutsuchakra)*1.6
				maxcooltime = jutsucooldown*350

		Mud_Dragon_Projectile
			icon_state="Mud Dragon Projectile"
			mouse_drag_pointer = "Mud Dragon Projectile"
			name="Mud Dragon Projectile"
			rank="A"
			Element="Earth"
			signs="<font color=green>Dog,Rat,Rat,Dog,Dog,Rat,Dog</font><br>(macro(E,Q,Q,E,E,Q,E))"
			Specialist = "Ninjutsu"
			Sprice=4
			reqs=list("Earth Release: Mud Wall")
			Description="Summon a powerful dragon from the earth and send it crashing in a straight line dealing damage to the first target hit."
			New()
				..()
				ChakraCost = (Sprice*jutsuchakra)*2.2
				maxcooltime = jutsucooldown*450


//Lightning

		Jinrai
			icon_state="Chidori Jinrai"
			mouse_drag_pointer = "Chidori Jinrai"
			name="Chidori Jinrai"
			rank="A"
			signs="<font color=green>Snake,Rabbit,Dog</font><br>(macro(2,1,E))"
		//	uses=100
			Element="Lightning"
			Sprice=2
			reqs = list("Chidori Needles")
			Description="Utilizing chidori's destructive power into a single point of energy, one can channel it down into a beam of force that travels in a straight line dealing damage (Nin) to the first target it hits."
			New()
				..()
				ChakraCost = (Sprice*jutsuchakra)*2
				maxcooltime = jutsucooldown*40

		Kirin
			icon_state="Kirin"
			mouse_drag_pointer = "Kirin"
			name="Kirin"
			rank="S"
			signs="<font color=green>Ox,Rabbit,Snake,Dog,Dog,Rabbit</font><br>(macro(W,1,2,E,E,1))"
		//	uses=100
			Element="Lightning"
			Sprice=4
			reqs = list("Chidori Jinrai")
			Description="Cause static to build over a target to call down a devistating bolt of lightning which deals damage (Nin) over time and prevents the target from moving for the duration. You are completely helpless while the lightning is striking."
			New()
				..()
				ChakraCost = (Sprice*jutsuchakra)*2.2
				maxcooltime = jutsucooldown*450

		Chidori_Needles
			icon_state="Chidori Needles"
			mouse_drag_pointer = "Chidori Needles"
			name="Chidori Needles"
			rank="A"
			signs="<font color=green>Ox,Rabbit</font><br>(macro(W,1))"
		//	uses=100
			Element="Lightning"
			Sprice=2
			reqs = list("Chidori")
			Description="Convert lightning chakra into sharp dense needles and fling them dealing damage (Nin|Prc)."
			New()
				..()
				ChakraCost = (Sprice*jutsuchakra)*0.8
				maxcooltime = jutsucooldown*60

		Raikiri
			icon_state="Raikiri"
			mouse_drag_pointer = "Raikiri"
			name="Raikiri"
			rank="A"
			signs="<font color=green>Snake,Ox,Ox</font><br>(macro(2,W,W))"
			//uses=100
			Sprice=3
			Specialist = "Ninjutsu"
			Element="Lightning"
			reqs=list("Chidori")
			Description="Charge your chakra to form a blade of lightning before rushing your target or in a straight line dealing damage (Nin|Agi|Prc) when you enter melee range of your target."
			New()
				..()
				ChakraCost = (Sprice*jutsuchakra)*2
				maxcooltime = jutsucooldown*450

		Chidori
			icon_state="Chidori"
			mouse_drag_pointer = "Chidori"
			name="Chidori"
			rank="A"
			signs="<font color=green>Snake,Rabbit,Ox</font><br>(macro(2,1,W))"
			//uses=100
			Element="Lightning"
			Sprice=2
			Description="Charge your chakra to form a ball of crackling lightning before rushing your target or in a straight line dealing damage (Nin|Agi) when you enter melee range of your target."
			New()
				..()
				ChakraCost = (Sprice*jutsuchakra)*2.4
				maxcooltime = jutsucooldown*200

		Chidori_Nagashi
			icon_state="Nagashi"
			mouse_drag_pointer = "Nagashi"
			name="Chidori Nagashi"
			rank="C"
			signs="<font color=green>Rabbit,Snake,Monkey,Rabbit</font><br>(macro(1,2,4,1))"
			Sprice=2
			uses=0
			Element="Lightning"
			reqs = list("Chidori Needles")
			Description="Focus chakra mixed with Lightning style to create a shield of lightning dealing damage over time (Nin) to anyone nearby."
			New()
				..()
				ChakraCost = (Sprice*jutsuchakra)*1.6
				maxcooltime = jutsucooldown*200

		Lightning_Balls
			icon_state="LightningBalls"
			mouse_drag_pointer="LightningBalls"
			name="Lightning Balls"
			Element="Lightning"
			rank="B"
			reqs = list("Chidori Jinrai")
			signs="<font color=green>Snake,Rabbit,Rabbit</font><br>(macro(2,1,1))"
			//uses=100
			Sprice=1
			Description="Create and fire balls of lightning towards your target dealing damage (Nin)."
			New()
				..()
				ChakraCost = (Sprice*jutsuchakra)*0.7
				maxcooltime = jutsucooldown*90

//Water

		Water_Release_Exploding_Water_Colliding_Wave
			icon_state="Water Release Exploding Water Colliding Wave"
			mouse_drag_pointer = "Water Release Exploding Water Colliding Wave"
			name="Water Release: Exploding Water Colliding Wave"
			rank="B"
			signs="<font color=green>Rabbit,Dog,Snake</font><br>(macro(1,E,2))"
			Sprice=1
			Element="Water"
			Description="Unleash a torrent of water from the your mouth which carries someone away with the wave dealing damage (Nin) for each tile they are carried. The wave doesn't hold well against resistence."
			New()
				..()
				ChakraCost = (Sprice*jutsuchakra)*0.5
				maxcooltime = jutsucooldown*170

		MizuClone
			icon_state="Water Bunshin"
			mouse_drag_pointer = "Water Bunshin"
			name="Water Clone"
			rank="B"
			Element="Water"
			signs="<font color=green>Rat, Rat, Snake</font><br>(macro(Q,Q,2))"
			Sprice=2
			reqs=list("Water Prison")
			Description="Creates a clone of pure chakra infused water that will indiscriminately engage anyone nearby binding them in a bubble of water for a duration."
			New()
				..()
				ChakraCost = (Sprice*jutsuchakra)*1.6
				maxcooltime = jutsucooldown*600

		WaterPrison
			icon_state="Water Prison"
			mouse_drag_pointer = "Water Prison"
			name="Water Prison"
			rank="B"
			Element="Water"
			signs="<font color=green>Ox, Snake, Rat, Snake</font><br>(macro(W,2,Q,2))"
			Sprice=1
			reqs=list("Water Release: Exploding Water Colliding Wave")
			Description="Craft a spherical water prison around a target directly in front of you. You must be touching the orb to maintain the bind and are therefor helpless for the duration."
			New()
				..()
				ChakraCost = (Sprice*jutsuchakra)*1.4
				maxcooltime = jutsucooldown*400

		Water_Dragon_Projectile
			icon_state="Water Dragon Projectile"
			mouse_drag_pointer = "Water Dragon Projectile"
			name="Water Dragon Projectile"
			rank="A"
			Element="Water"
			signs="<font color=green>Dog,Rat,Rat,Dog,Dog,Rat,Dog,Rat,Dragon,Dragon</font><br>(macro(E,Q,Q,E,E,Q,E,Q,5,5))"
			Sprice=4
			reqs=list("Water Clone")
			Description="Summon a powerful dragon from the water and send it crashing in a line dealing damage (Nin) to the first target hit."
			New()
				..()
				ChakraCost = (Sprice*jutsuchakra)*1.5
				maxcooltime = jutsucooldown*300

		WaterShark
			icon_state="Water Shark"
			mouse_drag_pointer = "Water Shark"
			name="Water Shark Projectile"
			rank="A"
			Element="Water"
			signs="<font color=green>Ox, Snake, Rat, Rabbit, Dragon</font><br>(macro(W,2,Q,1,5))"
			Specialist = "Ninjutsu"
			Sprice=3
			reqs=list("Water Clone")
			Description="Craft shark-like projectiles of crashing water, and force them outwards towards your target dealing damage (Nin) and knocking them around."
			New()
				..()
				ChakraCost = (Sprice*jutsuchakra)*2.3
				maxcooltime = jutsucooldown*150

		Teppoudama
			icon_state="tepo"
			mouse_drag_pointer = "tepo"
			name="Suiton Teppoudama"
			rank="B"
			signs="<font color=green>Rat,Dragon,Rat,Ox,Snake</font><br>(macro(Q,5,Q,W,2))"
			Sprice=1
			Element="Water"
			reqs = list("Water Prison")
			Description="Shoots Water Ball from user's mouth in a straight line in front of you that is small enough and precise enough to pierce through enemies dealing damage (Nin)."
			New()
				..()
				ChakraCost = (Sprice*jutsuchakra)*1.8
				maxcooltime = jutsucooldown*100

		Suijinheki
			icon_state="suijin"
			mouse_drag_pointer = "suijin"
			name="Suiton Suijinheki no Jutsu"
			rank="B"
			signs="<font color=green>Ox,Dragon,Dragon,Rat,Rat</font><br>(macro(W,5,5,Q,Q))"
			Sprice=1
			Element="Water"
			reqs = list("Water Release: Exploding Water Colliding Wave")
			Description="Produce a solid wave of water infront of you."
			New()
				..()
				ChakraCost = (Sprice*jutsuchakra)*0.8
				maxcooltime = jutsucooldown*80


//Wind

		Sickle_Weasel_Technique
			icon_state="Sickle Weasel Technique"
			mouse_drag_pointer = "Sickle Weasel Technique"
			name="Sickle Weasel Technique"
			rank="A"
			signs="<font color=green>Ox,Snake,Rabbit,Ox</font><br>(macro(W,2,1,W))"
		//	uses=100
			Element="Wind"
			Sprice=1
			Description="Convert chakra into air, and launch it in a rapid spinning form towards your target dealing damage (Nin|Prc)"
			New()
				..()
				ChakraCost = (Sprice*jutsuchakra)*0.9
				maxcooltime = jutsucooldown*60

		Wind_Dragon_Projectile
			icon_state="Wind Dragon Projectile"
			mouse_drag_pointer = "Wind Dragon Projectile"
			name="Wind Dragon Projectile"
			rank="A"
			Element="Wind"
			signs="<font color=green>Dog,Rat,Dog,Rat,Dog,Rat,Dog</font><br>(macro(E,Q,E,Q,E,Q,E))"
			Sprice=3
			reqs=list("Wind Tornados")
			Description="Summon a powerful dragon from the wind and send it crashing in a straight line dealing damage (Nin) to the first target it hits.."
			New()
				..()
				ChakraCost = (Sprice*jutsuchakra)*2.2
				maxcooltime = jutsucooldown*200

		Wind_Shield
			icon_state="Tornado Shield"
			mouse_drag_pointer = "Tornado Shield"
			name="Wind Shield"
			rank="C"
			signs="<font color=green>Rabbit,Snake,Monkey</font><br>(macro(1,2,4))"
			Sprice=2
			uses=0
			reqs = list("Sickle Weasel Technique")
			Description="Rapidly spin the air around you using your chakra dealing damage (Nin) and knocking back nearby enemies."
			New()
				..()
				ChakraCost = (Sprice*jutsuchakra)*0.7
				maxcooltime = jutsucooldown*70

		Blade_of_Wind
			icon_state="Blade of Wind"
			mouse_drag_pointer = "Blade of Wind"
			name="Blade of Wind"
			rank="C"
			signs="<font color=green>Rabbit,Snake,Rabbit</font><br>(macro(1,2,1))"
			Sprice=1
			uses=0
			reqs = list("Sickle Weasel Technique")
			Description="Form a blade of air around your fist and trust forward quickly dealing damage. If you hit someone, you use the momentum to turn around to face them automatically."
			New()
				..()
				ChakraCost = (Sprice*jutsuchakra)*0.8
				maxcooltime = jutsucooldown*100

		Wind_Tornados
			icon_state="WindTornados"
			mouse_drag_pointer = "WindTornados"
			name="Wind Tornados"
			rank="A"
			signs="<font color=green>Rabbit,Snake,Monkey,Rabbit,Snake</font><br>(macro(1,2,4,1,2))"
			Sprice=4
			uses=0
			reqs = list("Wind Shield")
			Description="Command the air to your will with chakra to form tornados that move around on their own dealing damage (Nin) to anyone nearby."
			New()
				..()
				ChakraCost = (Sprice*jutsuchakra)*1.6
				maxcooltime = jutsucooldown*250

		Rasenshuriken
			icon_state="Rasenshuriken"
			mouse_drag_pointer = "Rasenshuriken"
			name="Rasenshuriken"
			rank="A"
			signs="<font color=green>Rabbit,Rabbit,Ox,Ox,Ox,Ox</font><br>(macro(1,1,W,W,W,W))"
			Specialist = "Ninjutsu"
		//	uses=100
			Element="Wind"
			Sprice=3
			reqs=list("Rasengan")
			Description="Channel your chakra into a ball of spinning air with protruding blades before rushing your target or in a line in front of you knocking back the first target hit. After they are knocked back the delayed effects kick in and the jutsu explodes dealing damage(Nin|Agi|Prc)."
			New()
				..()
				ChakraCost = (Sprice*jutsuchakra)*2
				maxcooltime = jutsucooldown*450

		Zankuuha
			icon_state="zanku"
			mouse_drag_pointer = "zanku"
			name="Zankuuha"
			rank="D"
			signs="<font color=green>Monkey,Monkey,Rat</font><br>(macro(4,4,Q))"
			Sprice=1
			Element="Wind"
			Description="Zankuuha: Shoots wind from user's hand"
			New()
				..()
				ChakraCost = (Sprice*jutsuchakra)
				maxcooltime = jutsucooldown*380

		Daitoppa
			icon_state="daitoppa"
			mouse_drag_pointer = "daitoppa"
			name="Fuuton Daitoppa"
			rank="B"
			signs="<font color=green>Dragon,Rat,Rat,Rabbit</font><br>(macro(5,Q,Q,1))"
			Sprice=1
			reqs=list("Sickle Weasel Technique")
			Element="Wind"
			Description="Releases a huge gust of wind that can push enemys back dealing damage (Nin)"
			New()
				..()
				ChakraCost = (Sprice*jutsuchakra)*1.6
				maxcooltime = jutsucooldown*150

		Wind_Cutter
			icon_state="WC"
			mouse_drag_pointer="WC"
			name="Wind Cutter"
			Element="Wind"
			rank="B"
			signs="<font color=green>Snake,Rabbit,Rabbit,Snake</font><br>(macro(2,1,1,2))"
			Sprice=1
			uses=100
			reqs = list("Sickle Weasel Technique")
			Description="Produce a slow moving glaive of wind that pushes into anyone in it's way dealing damage (Nin) and pushing them back."
			New()
				..()
				ChakraCost = (Sprice*jutsuchakra)*1.2
				maxcooltime = jutsucooldown*100



//Other

		Getsuga_Tenshou
			icon_state="tenshou"
			mouse_drag_pointer = "tenshou"
			name="Getsuga Tenshou"
			rank="A"
			signs="<font color=green>None</font><br>"
			maxcooltime = 250
			ChakraCost = 200
			uses = 100
			Sprice=0
			Description="Getsuga Tenshou: Shoots a curvy line of immense force using Reiatsu."

		Kamehameha
			icon_state="Kamehameha"
			mouse_drag_pointer = "Kamehameha"
			name="Kamehameha"
			rank="S"
			signs="<font color=green>None</font><br>"
			maxcooltime = 300
			ChakraCost = 200
			uses=100
			Sprice=0
			Description="Use your ki to penetrate your opponents with an almighty blast!"

		Gomu_Gomu_No_Red_Hawk //NI
			icon_state="RedHawk"
			mouse_drag_pointer = "RedHawk"
			name="Gomu Gomu No Red Hawk"
			rank="B"
			signs="<font color=green>None"
			maxcooltime=90
			ChakraCost = 0 //Change
			uses=100
			Sprice=0
			Description="Summoning up monsterous Taijutsu, this Taijutsu ability allows one to put all that Taijutsu into one punch!"

//Curse
		CurseSeal
			icon_state="Curse Seal"
			mouse_drag_pointer = "Curse Seal"
			name="Curse Seal"
			rank="S"
			Specialist = SPECIALIZATION_TAIJUTSU
			maxcooltime = 0
			ChakraCost = 0
			Sprice=5
			uses=100
			signs="<font color=green>None</font><br>"
			Description="Grants powerful boost to Taijutsu and ninjutsu to the user provided by powers of darkness."

/*		Curse_Seal_of_Heaven		I don't think this one is used.
			icon_state="Curse Seal"
			mouse_drag_pointer = "Curse Seal"
			name="Curse Seal of Heaven"
			rank="A"
			signs="<font color=green>None</font><br>"
			maxcooltime=600
			Sprice=3
			uses=100
			Description="Release the power of your Curse Seal and gain infinite chakra for a short amount of time at the cost of physical damage."*/

		Curse_Dragon
			icon_state="Curse Dragon"
			mouse_drag_pointer = "Curse Dragon"
			name="Curse Dragon"
			rank="S"
			signs="<font color=green>Dog,Rat,Rat</font><br>(macro(E,Q,Q))"
			maxcooltime = 0
			ChakraCost = 0
			reqs=list("Curse Seal")
			Sprice=4
			Description="Summon a powerful dragon from the darkness in your heart and send it crashing into your enemies."

//Jinchuriki

		Jin_Cloak1
			icon_state="JC1"
			mouse_drag_pointer = "JC1"
			name="Jinchuriki: Chakra Cloak1"
			rank="S"
			signs="<font color=green>None</font><br>"
			maxcooltime = 1200
			ChakraCost = 100
			uses=100
			Sprice=0
			Description="Jinchuriki Cloak: Unleash your jinchuriki powers in a fraction of what it could be."


		Jin_Cloak2
			icon_state="JC2"
			mouse_drag_pointer = "JC2"
			name="Jinchuriki: Chakra Cloak2"
			rank="S"
			signs="<font color=green>None</font><br>"
			maxcooltime = 1200
			ChakraCost = 100
			uses=100
			Sprice=0
			Description="Jinchuriki Cloak: Unleash your jinchuriki powers in a fraction of what it could be."

		Jin_Cloak3
			icon_state="JC3"
			mouse_drag_pointer = "JC3"
			name="Jinchuriki: Chakra Cloak3"
			rank="S"
			signs="<font color=green>None</font><br>"
			maxcooltime = 1200
			ChakraCost = 100
			uses=100
			Sprice=0
			Description="Jinchuriki Cloak: Unleash your jinchuriki powers in a fraction of what it could be."

		Jin_Cloak4
			icon_state="JC4"
			mouse_drag_pointer = "JC4"
			name="Jinchuriki: Chakra Cloak4"
			rank="S"
			signs="<font color=green>None</font><br>"
			maxcooltime = 1200
			ChakraCost = 100
			uses=100
			Sprice=0
			Description="Jinchuriki Cloak: Unleash your jinchuriki powers in a fraction of what it could be."

		Jin_Cloak5
			icon_state="JC5"
			mouse_drag_pointer = "JC5"
			name="Jinchuriki: Chakra Cloak5"
			rank="S"
			signs="<font color=green>None</font><br>"
			maxcooltime = 1200
			ChakraCost = 100
			uses=100
			Sprice=0
			Description="Jinchuriki Cloak: Unleash your jinchuriki powers in a fraction of what it could be."

		Jin_Cloak6
			icon_state="JC6"
			mouse_drag_pointer = "JC6"
			name="Jinchuriki: Chakra Cloak6"
			rank="S"
			signs="<font color=green>None</font><br>"
			maxcooltime = 1200
			ChakraCost = 100
			uses=100
			Sprice=0
			Description="Jinchuriki Cloak: Unleash your jinchuriki powers in a fraction of what it could be."

		Jin_Cloak7
			icon_state="JC7"
			mouse_drag_pointer = "JC7"
			name="Jinchuriki: Chakra Cloak7"
			rank="S"
			signs="<font color=green>None</font><br>"
			maxcooltime = 1200
			ChakraCost = 100
			uses=100
			Sprice=0
			Description="Jinchuriki Cloak: Unleash your jinchuriki powers in a fraction of what it could be."

		Jin_Cloak8
			icon_state="JC8"
			mouse_drag_pointer = "JC8"
			name="Jinchuriki: Chakra Cloak8"
			rank="S"
			signs="<font color=green>None</font><br>"
			maxcooltime = 1200
			ChakraCost = 100
			uses=100
			Sprice=0
			Description="Jinchuriki Cloak: Unleash your jinchuriki powers in a fraction of what it could be."

		Jin_Cloak9
			icon_state="JC9"
			mouse_drag_pointer = "JC9"
			name="Jinchuriki: Chakra Cloak9"
			rank="S"
			signs="<font color=green>None</font><br>"
			maxcooltime = 1200
			ChakraCost = 100
			uses=100
			Sprice=0
			Description="Jinchuriki Cloak: Unleash your jinchuriki powers in a fraction of what it could be."

//Dust

		Dust_Particle
			icon_state="dust"
			mouse_drag_pointer = "dust"
			name="Dust Particle"
			rank="S"
			signs="<font color=green>None</font><br>"
			maxcooltime = 0
			ChakraCost = 0
			Sprice=0
			Clan="Dust Particle"
			Description="Allows the one to utilize the power of Dust Particle."

		Dust_Particle_Prison
			icon_state="dpp"
			mouse_drag_pointer = "dpp"
			name="Dust Particle Prison"
			rank="S"
			signs="<font color=green>Ox,Monkey,Dragon,Dog,Rat,Ox,Rabbit</font><br>(macro(W,4,5,E,Q,W,1))"
			maxcooltime = 0
			ChakraCost = 0
			Sprice=0
			Clan="Dust Particle"
			reqs = list("Dust Particle")
			Description="Forms a cube which contains the target for it's duration and allows the usage of Dust Particle Prison Beam jutsu."

		Dust_Particle_Prison_Beam
			icon_state="dppb"
			mouse_drag_pointer = "dppb"
			name="Dust Particle Prison Beam"
			rank="S"
			signs="<font color=green>Ox,Monkey,Dragon</font><br>(macro(W,4,5))"
			maxcooltime = 0
			ChakraCost = 0
			Sprice=0
			Clan="Dust Particle"
			reqs = list("Dust Particle Prison")
			Description="Emits a beam of light which attemts to evaporate the target at a molecular level."