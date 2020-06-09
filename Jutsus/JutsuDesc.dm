obj
	Jutsus
//NonClan

		BClone
			icon_state="clone"
			mouse_drag_pointer = "clone"
			name="Clone Jutsu"
			rank="D"
			signs="<font color=green>Rat</font><br>(macro(Q))"
			maxcooltime = 120
			ChakraCost = 15
			starterjutsu=1
			Description="This technique allows the user to replicate themself in a non-solid form. It is an illusionary technique that has no solid form"

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
			Description="This technique destroys the clones you have out on the field."

		Transformation
			icon_state="henge"
			mouse_drag_pointer = "henge"
			name="Transformation Jutsu"
			rank="E"
			signs="<font color=green>Dog,Rat</font><br>(macro(E,Q))"
			maxcooltime = 100
			ChakraCost = 15
			starterjutsu=1
			Description="This technique transforms the user into the selected target."

		BodyReplace
			icon_state="bodyreplace"
			mouse_drag_pointer = "bodyreplace"
			name="Body Replacement Jutsu"
			rank="E"
			signs="<font color=green>Dog</font><br>(macro(E))"
			maxcooltime = 60
			ChakraCost = 15
			//starterjutsu=1
			Description="Body replacement technique. Substitute your body with a log, allowing you to escape from battle."

		AdvancedBodyReplace
			icon_state="Abodyreplace"
			mouse_drag_pointer = "Abodyreplace"
			name="Advanced Body Replacement Jutsu"
			rank="E"
			signs="<font color=green>Dog,Dog</font><br>(macro(E,E))"
			maxcooltime = 240
			ChakraCost = 50
			Description="Body replacement technique. Substitute your body with a log, allowing you to escape from battle."

		Body_Flicker
			icon_state="Shunshin"
			mouse_drag_pointer = "Shunshin"
			name="Body Flicker Technique"
			rank="D"
			signs="<font color=green>None</font><br>"
			maxcooltime = 10
			ChakraCost = 15
			uses=100
			Description="Utilizing chakra control, this converges chakra to your feet, allowing you to move extremely fast to a location."

		Flying_Thunder_God
			icon_state="Flyingthunder"
			mouse_drag_pointer = "Flyingthunder"
			name="Flying Thunder God"
			rank="A"
			signs="<font color=green>Rabbit</font><br>(macro(1))"
			maxcooltime = 30
			ChakraCost = 100
			reqs=list("Body Flicker Technique")
			Description="Flying Thunder God: Utilizing chakra control, this converges chakra to your feet, allowing you to move as fast as if you were teleporting."

		Rasengan
			icon_state="Rasengan"
			mouse_drag_pointer = "Rasengan"
			name="Rasengan"
			rank="A"
			signs="<font color=green>Rabbit,Rabbit,Ox</font><br>(macro(1,1,W))"
			maxcooltime = 200
			ChakraCost = 100
			Sprice=2
			Description="Channeling your chakra into a ball of spinning air, allows one to create a very deadly close-range weapon."

		Warp_Rasengan
			icon_state="WarpRasengan"
			mouse_drag_pointer = "WarpRasengan"
			name="Warp Rasengan"
			rank="S"
			signs="<font color=green>Rabbit,Monkey,Monkey,Rabbit,Monkey</font><br>(macro(1,4,4,1,4))"
			maxcooltime = 140
			ChakraCost = 180
			reqs=list("Flying Thunder God","Rasengan")
			Sprice=3
			Description="Warp Rasengan: Instantly warp to your opponent sending them flying with a Rasengan."

		TreeBinding
			icon_state="Tree Binding"
			mouse_drag_pointer = "Tree Binding"
			name="Demonic Illusion: Tree Binding Death"
			rank="B"
			signs="<font color=green>Ox,Snake,Rabbit,Dog</font><br>(macro(W,2,1,E))"
			maxcooltime = 200
			ChakraCost = 100
			Sprice=2
			Specialist = "Genjutsu"
			Description="A relatively powerful Genjutsu that will convince your target's mind that they are locked to a nearby tree. This will allow one to attack them from multiple angles, rendering them helpless."

		Temple_Of_Nirvana
			icon_state="Temple of Nirvana"
			mouse_drag_pointer = "Temple of Nirvana"
			name="Temple of Nirvana"
			rank="B"
			signs="<font color=green>Dog,Rabbit,Dog,Snake</font><br>(macro(E,1,E,2))"
		//	uses=100
			Sprice=3
			maxcooltime = 400
			ChakraCost = 200
			Specialist = "Genjutsu"
			reqs=list("Demonic Illusion: Tree Binding Death")
			Description="Under the illusion of mystic feathers, this genjutsu will lull anyone near them into a deep sleep, rendering them suseptible to future attacks."

		Chakra_Control
			icon_state="chak2"
			mouse_drag_pointer = "chak2"
			name="Chakra Control"
			rank="E"
			signs="<font color=green>None</font><br>"
			uses=100
			maxcooltime = 120
			ChakraCost = 35
			Description="Imbue your chakra to your feet, allowing you to walk on water, and up mountains."

		ChakraRelease
			icon_state="chak"
			mouse_drag_pointer = "chak"
			name="Chakra Release"
			rank="E"
			signs="<font color=green>Rat,Rat</font><br>(macro(Q,Q))"
			uses=100
			maxcooltime = 250
			ChakraCost = 10
			Description="Expel all weaponry placed upon you outwards in a blast of chakra. Released weaponry can fly in the direction it is blasted to harm opponents."

		Bringer_of_Darkness_Technique
			icon_state="Bringer of Darkness Technique"
			mouse_drag_pointer = "Bringer of Darkness Technique"
			name="Bringer of Darkness Technique"
			rank="B"
			signs="<font color=green>Dog,Ox,Dragon</font><br>(macro(E,W,5))"
			maxcooltime = 900
			ChakraCost = 150
			Specialist = "Genjutsu"
		//	uses=100
			Sprice=3
			Description="Force the opponent to not be able to see light for a short amount of time."

		Body_Pathway_Derangement
			icon_state="Achiever of Nirvana Fist"
			mouse_drag_pointer = "Achiever of Nirvana Fist"
			name="Body Pathway Derangement"
			rank="A"
			Specialist = "strength"
			signs="<font color=green>Horse,Horse,Snake</font><br>(macro(3,3,2))"
			maxcooltime = 500
			ChakraCost = 200
			Sprice=2
			Description="Strike someone with chakra, interupting their nervous system, causing temporary loss of control."

		One_Thousand_Years_of_Death
			icon_state="One Thousand Years of Death"
			mouse_drag_pointer = "One Thousand Years of Death"
			name="Leaf Hidden Finger Jutsu: One Thousand Years of Death"
			rank="D"
			signs="<font color=green>Monkey</font><br>(macro(4))"
			maxcooltime = 100
			ChakraCost = 15
			uses=100
			Description="Launch your opponent into the air with a powerful strike in a ... specific... place."

		Crow_Clone
			icon_state="Crow Clone"
			mouse_drag_pointer = "Crow Clone"
			name="Crow Clone"
			rank="C"
			Sprice=2
			Specialist = "Genjutsu"
			signs="<font color=green>Rat,Dragon,Dog,Monkey</font><br>(macro(Q,5,E,4))"
			maxcooltime = 400
			ChakraCost = 100
			Description="Create multiple realistic clones by diffusing into multiple crows and solidifying in scattered places to confuse your opponent."

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
			maxcooltime = 600
			ChakraCost = 400
			Description="Crow Substitution: Replace your body with crows upon receiving damage with this jutsu active."

		Heal
			icon_state="Heal"
			mouse_drag_pointer = "Heal"
			name="Heal"
			rank="C"
			signs="<font color=green>Dog,Snake,Rat</font><br>(macro(E,2,Q))"
			maxcooltime = 350
			ChakraCost = 35
			Description="This technique allows one to channel their chakra into life force, allowing them to significantly heal themselves in battle."

		Ones_Own_Life_Reincarnation
			icon_state="Ones Own Life Reincarnation"
			mouse_drag_pointer = "Ones Own Life Reincarnation"
			name="One's Own Life Reincarnation"
			rank="A"
			signs="<font color=green>Horse,Horse,Horse</font><br>(macro(3,3,3))"
			maxcooltime = 600
			ChakraCost = 10
			Sprice=2
			reqs=list("Heal")
			Description="Sacrifice your own life to revive a fallen comrade."

		Mystical_Palms
			icon_state="Chakra Scalpel"
			mouse_drag_pointer = "Chakra Scalpel"
			name="Mystical Palms"
			rank="A"
			uses=100
			signs="<font color=green>None</font><br>"
			maxcooltime = 120
			ChakraCost = 50
			Sprice=2
			reqs = list("Heal")
			Description="Mystical Palms forms blades of chakra around your hands so your physical attack strength is boosted."

		Cherry_Blossom_Impact
			icon_state="Cherry Blossom Impact"
			mouse_drag_pointer = "Cherry Blossom Impact"
			name="Cherry Blossom Impact"
			rank="C"
			signs="<font color=green>Horse,Horse,Rabbit</font><br>(macro(3,3,1))"
			maxcooltime = 20
			ChakraCost = 100
			Sprice=2
			reqs=list("Mystical Palms")
			Description="Use a precise injection of chakra from your hand to an opponent to blast them away with immense strength."

		Poison_Mist
			icon_state="Poison Mist"
			mouse_drag_pointer = "Poison Mist"
			name="Poison Mist"
			rank="B"
			signs="<font color=green>Dragon,Horse,Snake</font><br>(macro(5,3,2))"
			maxcooltime = 100
			ChakraCost = 70
			Sprice=2
			Description="Convert your chakra into poison gas and breath it out through your mouth."
//Curse
		CurseSeal
			icon_state="Curse Seal"
			mouse_drag_pointer = "Curse Seal"
			name="Curse Seal"
			rank="S"
			Specialist = "strength"
			maxcooltime = 1200
			ChakraCost = 450
			Sprice=5
			uses=100
			signs="<font color=green>None</font><br>"
			Description="Grants powerful boost to strength and ninjutsu to the user provided by powers of darkness."

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
			maxcooltime = 400
			ChakraCost = 200
			reqs=list("Curse Seal")
			Sprice=4
			Description="Summon a powerful dragon from the darkness in your heart and send it crashing into your enemies."

		HiddenSnakeStab
			icon_state="HiddenSnakeStab"
			mouse_drag_pointer = "HiddenSnakeStab"
			name="Hidden Snake Stab"
			rank="S"
			signs="<font color=green>Rat,Snake,Dog</font><br>(macro(Q,2,E))"
			maxcooltime = 180
			ChakraCost = 200
			reqs=list("Curse Dragon")
			Sprice=3
			Description="Turns ones hand into deadly snakes to stab anything in it's way."

		Snake_Skin_Replacement_Jutsu
			icon_state="Snake Skin Replacement Jutsu"
			mouse_drag_pointer = "Snake Skin Replacement Jutsu"
			name="Snake Skin Replacement"
			rank="C"
			signs="<font color=green>Ox,Rat,Rat,Ox</font><br>(macro(W,Q,Q,W))"
			uses=0
			//Clan = "Curse"
			reqs=list("Curse Dragon")
			Sprice = 5
			maxcooltime=600
			ChakraCost = 500
			Description="Replace your body with a snake skin upon receiving damage with this jutsu active."

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

//Sage
		SageMode
			icon_state="Sage Mode"
			mouse_drag_pointer = "Sage Mode"
			name="Sage Mode"
			Specialist = "Ninjutsu"
			rank="S"
			maxcooltime = 1200
			ChakraCost = 450
			Sprice=5
			uses=100
			signs="<font color=green>None</font><br>"
			Description="Grants powerful boost to strength and ninjutsu to the user provided by powers of nature."

	/*	CloakMode old 9tail
			icon_state="Cloak Mode"
			mouse_drag_pointer = "Cloak Mode"
			name="Cloak Mode"
			rank="S"
			maxcooltime=700
			Sprice=6
			signs="<font color=green>none</font><br>"
			Description="Allows the user to tap into the Kyuubi's chakra and unleash a cloak of chakra" */

		Sage_Style_Giant_Rasengan
			icon_state="SageRasengan"
			mouse_drag_pointer = "SageRasengan"
			name="Sage Style Giant Rasengan"
			rank="S"
			signs="<font color=green>Rabbit,Ox,Rabbit,Ox,Rabbit,Ox</font><br>(macro(1,W,1,W,1,W))"
			maxcooltime = 350
			ChakraCost = 500
			Sprice=5
			reqs=list("Rasengan","Sage Style: Giant Snake")
			Description="Sage Style Giant Rasengan: Channel your Sage Energy and your knowlege of the Rasengan, and form the almighty SAGE STYLE GIANT RASENGAN!"

		Snake_Release_Jutsu
			icon_state="Snake_Release_Jutsu"
			mouse_drag_pointer = "Snake_Release_Jutsu"
			name="Sage Style: Giant Snake"
			rank="A"
			signs="<font color=green>Dog,Rat,Rat,Dragon,Dog</font><br>(macro(E,Q,Q,5,E))"
			maxcooltime = 600
			ChakraCost = 300
			Sprice=5
			reqs=list("Sage Mode")
			Description="Summon a powerful snake from the darkness in your heart and send it crashing into your enemies."

		Sage_Bind
			icon_state="SageBind"
			mouse_drag_pointer = "SageBind"
			name="Sage Style: Toad Bind"
			rank="S"
			signs="<font color=green>Dog,Dog,Rat,Dragon,Dragon</font><br>(macro(E,E,Q,5,5))"
			maxcooltime = 10//TEST
			ChakraCost = 400
			Sprice=5
			reqs=list("Sage Style: Giant Snake")
			Description="Sage Style Toad Bind: Use Sage energy to turn bind with toad tongue."

//Clones
		SClone
			icon_state="Shadclone"
			mouse_drag_pointer = "Shadclone"
			name="Shadow Clone Jutsu"
			rank="A"
			signs="<font color=green>Rat,Dragon</font><br>(macro(Q,5))"
			maxcooltime = 150
			ChakraCost = 50
			Sprice=1
			reqs=list("Clone Destroy")
			Description="This technique allows the user to replicate themselves into a single solid form on the battlefield.."

		MSClone
			icon_state="Mclone"
			mouse_drag_pointer = "Mclone"
			name="Multiple Shadow Clone Jutsu"
			rank="A"
			signs="<font color=green>Rat,Dragon,Dog,Monkey,Monkey</font><br>(macro(Q,5,E,4,4))"
			maxcooltime = 250
			ChakraCost = 100
			Sprice=2
			reqs=list("Shadow Clone Jutsu")
			Description="This technique is similar to Shadow Clone Jutsu, only it allows the user to create multiple solid copies of themself."


//Rinnegan

		Rinnegan
			icon_state="Rinnegan"
			mouse_drag_pointer = "Rinnegan"
			name="Rinnegan"
			rank="S"
			uses=100
			maxcooltime = 50
			signs="<font color=green>None"
			ChakraCost = 0
			Sprice = 10
			Clan="No Clan"
			Specialist="Balanced"
			Description="The Legendary Doujutsu, the Rinnegan. The forefather of all doujutsu, capable of mastering the Yin and Yang elements. This source of pure power will reject outside power!(No Curse mark or Sage mode)"

		Induction
			icon_state="induct"
			mouse_drag_pointer = "induct"
			name="Gravity Divergence: Induction"
			rank="A"
			signs="<font color=green>Snake,Rabbit</font><br>(macro(2,1))"
			Clan="Rinnegan"
			reqs=list("Rinnegan")
			maxcooltime = 50
			ChakraCost = 15
			Sprice=2
			Description="Controlling the force of gravity itself, this allows the user to force their target towards them."

		Repulsion
			icon_state="repulse"
			mouse_drag_pointer = "repulse"
			name="Gravity Divergence: Repulsion"
			rank="A"
			signs="<font color=green>Rabbit,Snake</font><br>(macro(1,2))"
			maxcooltime = 50
			ChakraCost = 15
			Clan="Rinnegan"
			Sprice=2
			reqs=list("Gravity Divergence: Induction")
			Description="Controlling the force of gravity itself, this allows the user to force their target away from them."

		Chakra_Leech
			icon_state="Chakra Leech"
			mouse_drag_pointer = "Chakra Leech"
			name="Chakra Leech"
			Clan="Rinnegan"
			rank="C"
			Sprice=2
			reqs=list("Gravity Divergence: Repulsion")
			signs="<font color=green>Snake,Dragon,Snake,Rat</font><br>(macro(2,5,2,Q))"
			maxcooltime = 50
			ChakraCost = 100
			Description="This technique allows one to draw from another Shinobi's chakra to replenish their own."

		Gedo_Revival
			icon_state="Gedo Revival"
			mouse_drag_pointer = "Gedo Revival"
			name="Gedo Revival"
			Clan="Rinnegan"
			rank="S"
			signs="<font color=green>Horse,Rabbit,Horse</font><br>(macro(3,1,3))"
			reqs=list("Chakra Leech")
			maxcooltime = 50
			ChakraCost = 100
			Sprice=3
			Description="Gedo Revival: Summon the Gedo Statue and revive friends or foes."

		Snake_Summoning
			icon_state="SnakeSummoning"
			mouse_drag_pointer = "SnakeSummoning"
			name="Summoning Jutsu: Snake"
			Clan="Rinnegan"
			rank="B"
			maxcooltime = 200
			ChakraCost = 400
			Sprice = 3
			reqs=list("Gedo Revival")
			//uses=100
			signs="<font color=green>Rat,Horse,Rat,Dog,Ox</font><br>(macro(Q,3,Q,E,W))"
			Description="Allows you to summon small snake to aid you in combat!"

		Almighty_Push
			icon_state="Apush"
			mouse_drag_pointer = "Apush"
			name="Gravity Divergence: Almighty Push"
			rank="S"
			Clan="Rinnegan"
			signs="<font color=green>Rabbit,Rabbit,Snake,Snake,Rabbit,Snake</font><br>(macro(1,1,2,2,1,2))"
			maxcooltime = 450
			ChakraCost = 600
			Sprice=4
			reqs=list("Summoning Jutsu: Snake")
			Description="The ultimate gravity control technique. This technique channels massive amounts of chakra into a gravitational force, allowing one to propel multiple enemies away from themself."


//Gates

		EightGates
			icon_state = "Gate 5"
			mouse_drag_pointer = "Gate 5"
			name = "Eight Gates"
			rank = "B"
			Sprice = 0
			signs = "<font color=green>None</font><br>"
			maxcooltime = 5
			uses = 100
			level = 0
			Description="Opens the first chakra gate, increasing your strength and causing damage to yourself."

		Opening_Gate
			icon_state = "Gate 1"
			mouse_drag_pointer = "Gate 1"
			name = "Opening Gate"
			rank = "B"
			Sprice = 2
			signs = "<font color=green>None</font><br>"
			Clan="No Clan"
			Specialist="strength"
			maxcooltime = 200
			uses = 100
			IsGate = 1
			Description="Opens the first chakra gate, increasing your strength and causing damage to yourself."

		Energy_Gate
			icon_state="Gate 2"
			mouse_drag_pointer = "Gate 2"
			name="Energy Gate"
			rank="B"
			signs="<font color=green>None</font><br>"
			Clan="Gates"
			maxcooltime=200
			Sprice=2
			uses=100
			IsGate = 1
			reqs=list("Opening Gate")
			Description="Opens the second chakra gate, increasing your strength further."

		Life_Gate
			icon_state="Gate 3"
			mouse_drag_pointer = "Gate 3"
			name="Life Gate"
			rank="B"
			signs="<font color=green>None</font><br>"
			Clan="Gates"
			maxcooltime=200
			Sprice=2
			uses=100
			IsGate = 1
			reqs=list("Opening Gate","Energy Gate")
			Description="Opens the third chakra gate, allowing you to dramatically increase your strength and cause more damage to yourself."

		Pain_Gate
			icon_state="Gate 4"
			mouse_drag_pointer = "Gate 4"
			name="Pain Gate"
			rank="B"
			signs="<font color=green>None</font><br>"
			Clan="Gates"
			maxcooltime=200
			Sprice=3
			uses=100
			IsGate = 1
			reqs=list("Opening Gate","Energy Gate","Life Gate")
			Description="Opens the fourth chakra gate, increasing your strength, giving you blinding speed, and causing damage to yourself."

		Limiter_Gate
			icon_state="Gate 5"
			mouse_drag_pointer = "Gate 5"
			name="Limiter Gate"
			rank="B"
			signs="<font color=green>None</font><br>"
			Clan="Gates"
			maxcooltime=200
			Sprice=4
			uses=100
			IsGate = 1
			reqs=list("Opening Gate","Energy Gate","Life Gate","Pain Gate")
			Description="Opens the fifth chakra gate, increasing your strength unbeleivably and causing damage to yourself."

		Meteor_Punch
			icon_state="mpunch"
			mouse_drag_pointer = "mpunch"
			name="Meteor Punch"
			rank="C"
			signs="<font color=green>None"
			Clan="Gates"
			maxcooltime = 100
			ChakraCost = 0 //Change
			uses=100
			Sprice=2
			reqs = list("Opening Gate")
			Description="Summoning up monsterous strength, this strength ability allows one to channel this strength into a single punch."

		Shishi
			icon_state="shishi"
			mouse_drag_pointer = "shishi"
			name="ShiShi Rendan"
			rank="D"
			signs="<font color=green>None"
			Clan="Gates"
			maxcooltime = 120
			ChakraCost = 100
			Sprice=1
			reqs = list("Energy Gate")
			uses=100
			Description="Shishi Rendan: Very Powerfull combo where user uses its speed to create a series off attacks"

		Leaf_Whirlwind
			icon_state="Lwind"
			mouse_drag_pointer = "Lwind"
			name="Leaf Whirlwind"
			rank="C"
			signs="<font color=green>None"
			Clan="Gates"
			maxcooltime = 120
			ChakraCost = 0 //Change
			uses=100
			Sprice=2
			reqs=list("Life Gate")
			Description="Using a single, yet powerful kick this technique allows one to attack multiple opponents simultaneously."

		Morning_Peacock
			icon_state="Asakujaku"
			mouse_drag_pointer = "Asakujaku"
			name="Morning Peacock"
			rank="C"
			signs="<font color=green>None"
			Clan="Gates"
			maxcooltime = 200
			ChakraCost = 0 //Change
			Sprice=2
			uses=100
			reqs=list("Limiter Gate")
			Description="This technique unleashes a absolute fury of punches towards their target, and is capable of injuring multiple enemies at once."

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
			maxcooltime = 200
			ChakraCost = 100
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
			maxcooltime = 200
			ChakraCost = 200
			Sprice=0
			Clan="Dust Particle"
			reqs = list("Dust Particle Prison")
			Description="Emits a beam of light which attemts to evaporate the target at a molecular level."

//Uchiha

		Sharingan
			icon_state="Sharingan 1 tomoe"
			mouse_drag_pointer = "Sharingan 1 tomoe"
			name="Sharingan 1 tomoe"
			rank="B"
			Clan="Uchiha"
			signs="<font color=green>None</font><br>"
			maxcooltime=55
			ChakraCost = 25
			uses=100
			sharin=1
			Description="The Uchiha clan specialty, the legendary Sharingan doujutsu. This eye technique allows you to track time as if it were slowed down. Allowing you to block most moves, and copy techniques.."

		Sharingan_2
			icon_state="Sharingan 2 tomoe"
			mouse_drag_pointer = "Sharingan 2 tomoe"
			name="Sharingan 2 tomoe"
			rank="B"
			Clan="Uchiha"
			signs="<font color=green>None</font><br>"
			maxcooltime=45
			ChakraCost = 20
			Sprice=1
			uses=100
			sharin=2
			reqs = list("Sharingan 1 tomoe")
			Description="The Uchiha clan specialty, the legendary Sharingan doujutsu. This eye technique allows you to track time as if it were slowed down. Allowing you to block most moves, and copy techniques.."

		Sharingan_3
			icon_state="Sharingan 3 tomoe"
			mouse_drag_pointer = "Sharingan 3 tomoe"
			name="Sharingan 3 tomoe"
			rank="B"
			Clan="Uchiha"
			signs="<font color=green>None</font><br>"
			maxcooltime=35
			ChakraCost = 15
			Sprice=1
			uses=100
			sharin=3
			reqs = list("Sharingan 2 tomoe")
			Description="The Uchiha clan specialty, the legendary Sharingan doujutsu. This eye technique allows you to track time as if it were slowed down. Allowing you to block most moves, and copy techniques.."

		Sharingan_4
			icon_state="Mangekyou Sharingan"
			mouse_drag_pointer = "Mangekyou Sharingan"
			name="Mangekyou Sharingan"
			rank="A"
			Clan="Uchiha"
			signs="<font color=green>None</font><br>"
			maxcooltime=25
			ChakraCost = 10
			Sprice=2
			uses=100
			sharin=4
			reqs = list("Sharingan 3 tomoe")
			Description="The Uchiha clan specialty, the legendary Sharingan doujutsu. This eye technique allows you to track time as if it were slowed down. Allowing you to block most moves, and copy techniques.."

		Sharingan_5
			icon_state="Eternal Mangekyou"
			mouse_drag_pointer = "Eternal Mangekyou"
			name="Eternal Mangekyou Sharingan"
			rank="S"
			Clan="Uchiha"
			signs="<font color=green>None</font><br>"
			maxcooltime=15
			ChakraCost = 5
			Sprice=3
			uses=100
			sharin=5
			reqs = list("Mangekyou Sharingan")
			Description="The unbelieveably strong, one and only Eternal Mangekyou Sharingan! Mastered only among the best of the Uchihas."

		Tsukuyomi
			icon_state="Tsukuyomi"
			mouse_drag_pointer = "Tsukuyomi"
			name="Tsukuyomi"
			rank="S"
			uses=100
			signs="<font color=green>None</font><br>"
			maxcooltime = 450
			ChakraCost = 250
			Sprice=3
			reqs=list("Mangekyou Sharingan")
			Description="An extremely powerful genjutsu that will instantly warp your target to a moonlit insane world, where they will be endlessly tortured. Only the strongest have ever come out of this technique mentally intact."

		Amaterasu
			icon_state="Amaterasu"
			mouse_drag_pointer = "Amaterasu"
			name="Amaterasu"
			rank="S"
			signs="<font color=green>None</font><br>"
			uses=100
			maxcooltime = 280
			ChakraCost = 250
			//Clan="Sasuke"
			Sprice=3
			reqs=list("Mangekyou Sharingan")
			Description="One of the most fearsome techniques on the face of the planet, the unextinguishable fire. This technique using the power of Mangekyo Sharingan will summon this fearsome fire onto the battlefield, and on your target, causing devastating effects."

		Susanoo
			icon_state="Susanoo"
			mouse_drag_pointer = "Susanoo"
			name="Susanoo"
			Sprice=3
			rank="S"
			Clan= "Uchiha"
			signs="<font color=green>Dog,Ox,Dragon,Ox,Dog</font><br>(macro(E,W,5,W,E))"
			maxcooltime = 600
			ChakraCost = 650
			reqs = list("Mangekyou Sharingan")
			Description="The last technique one will learn through the Mangekyou Sharingan, Susanoo creates a giant warrior god to aid you who is very useful in all situations."

//Implanted

		Sharingan_Copy
			icon_state="Sharingan Copy"
			mouse_drag_pointer = "Sharingan Copy"
			name="Sharingan Copy"
			rank="B"
			Clan="No Clan"
			signs="<font color=green>None</font><br>"
			maxcooltime = 50
			ChakraCost = 100
			Sprice=5
			uses=100
			Description="Implant yourself with a Sharingan! Use your Sharingan to allow you to copy techniques used by other Shinobi."

		Kamui
			icon_state="Kamui"
			mouse_drag_pointer = "kamui"
			name="Kamui"
			rank="S"
			uses=100
			signs="<font color=green>None</font><br>"
			maxcooltime = 300
			ChakraCost = 200
			Sprice = 5
			Clan="Implanted"
			reqs=list("Sharingan Copy")
			Description="An extremely powerful genjutsu that will instantly warp your target to another dimension, where they will be endlessly tortured."

		WarpDim
			icon_state="WD"
			mouse_drag_pointer = "WD"
			name="Warp Dimension"
			rank="A"
			//Clan="Uchiha"
			signs="<font color=green>None</font><br>"
			Clan="Implanted"
			reqs=list("Kamui")
			maxcooltime = 100
			ChakraCost = 350
			Sprice=5
			uses=100
			Description="You're in my world now."

		Intangible_Jutsu
			icon_state="In"
			mouse_drag_pointer = "In"
			name="Intangible"
			rank="S"
			//Clan="Uchiha"
			signs="<font color=green>None</font><br>"
			Clan="Implanted"
			reqs=list("Warp Dimension")
			maxcooltime = 30
			ChakraCost = 300
			Sprice=5
			uses=100
		//	uses=0;notneeded=1
			Description="Use the power of the Kamui on yourself to make things pass through you."

//Nara

		Shadow_Extension
			icon_state="Shadow Bind"
			mouse_drag_pointer = "Shadow Bind"
			name="Shadow Bind"
			rank="B"
			Clan="Nara"
			signs="<font color=green>Monkey, Snake, Ox</font><br>(macro(4,2,W))"
			maxcooltime = 400
			ChakraCost = 275
			Description="The Nara's clan specialty. Utilizing the shadows around them, the Nara clan can extend their shadow beyond that of normal range, and are able to interact with one's shadow, locking the target in place."

		Shadow_Stab
			icon_state="Shadow Stab"
			mouse_drag_pointer = "Shadow Stab"
			name="Shadow Stab"
			rank="A"
			Clan="Nara"
			reqs=list("Shadow Bind")
			signs="<font color=green>None</font><br>"
			maxcooltime = 300
			ChakraCost = 200
			Sprice=2
			uses=100
			Description="A deadly technique that can be used by a member of the Nara clan, Shadow Stab uses a previously used Shadow Extension to trap and stab their target. This can cause serious injury, or even death."

		Shadow_Choke
			icon_state="Shadow Choke"
			mouse_drag_pointer = "Shadow Choke"
			name="Shadow Choke"
			rank="A"
			Clan="Nara"
			reqs=list("Shadow Stab")
			signs="<font color=green>None</font><br>"
			maxcooltime=350
			ChakraCost = 150
			Sprice=3
			uses=100
			Description="A deadly technique that can be used by a member of the Nara clan, Shadow Choke uses a previously used Shadow Extension to trap and choke their target. This can cause serious injury, or even death."

		Shadow_Punch
			icon_state="Shadow Punch"
			mouse_drag_pointer = "Shadow Punch"
			name="Shadow Punch"
			rank="S"
			Clan="Nara"
			signs="<font color=green>Monkey,Snake,Ox,Monkey</font><br>(macro(4,2,W,4))"
			maxcooltime=300
			ChakraCost = 250
			reqs=list("Shadow Choke")
			Sprice=3
			Description="Shadow Punch: Summon a powerful palm of destruction from the shadows created by your clans inner will and send it crashing into your enemies."

		Shadow_Explosion
			icon_state="Shadow Explosion"
			mouse_drag_pointer = "Shadow Explosion"
			name="Shadow Explosion"
			rank="S"
			Clan="Nara"
			reqs=list("Shadow Punch")
			signs="<font color=green>None</font><br>"
			maxcooltime=350
			ChakraCost = 150
			Sprice=3
			uses=100
		//	uses=0;notneeded=1
			Description="Shadow Explosion: A deadly attack to fuck up your opponent."

//Aburame

		Insect_Clone
			icon_state="Insect Clone"
			mouse_drag_pointer = "Insect Clone"
			name="Insect Clone"
			rank="S"
			uses=0
			signs="<font color=green>Snake,Dragon,Snake</font><br>(macro(2,5,2))"
			maxcooltime=220
			ChakraCost = 30
			Clan="Aburame"
			Sprice=2
			Description="Uses the destruction bugs to make a clone that battles alongside you."

		Bug_Neurotoxin
			icon_state="Bug Neurotoxin"
			mouse_drag_pointer = "Bug Neurotoxin"
			name="Destruction Bug Neurotoxin"
			rank="S"
			uses=0
			signs="<font color=green>Dragon,Snake,Snake</font><br>(macro(5,2,2))"
			maxcooltime = 500
			ChakraCost = 40
			Clan="Aburame"
			Sprice=2
			reqs = list("Stealth Bug")
			Description="Use your stealth bugs to stun your opponent for a moment long enough for you to close a quick gap."

		Insect_Cocoon
			icon_state="Insect Cocoon"
			mouse_drag_pointer = "Insect Cocoon"
			name="Insect Cocoon"
			rank="S"
			uses=0
			signs="<font color=green>Dragon,Snake,Snake,Dragon</font><br>(macro(5,2,2,5))"
			maxcooltime = 100
			ChakraCost = 30
			Clan="Aburame"
			Sprice=3
			reqs = list("Destruction Bug Neurotoxin")
			Description="Unleash the power of your destruction bugs by channeling your body's chakra straight through their nest within you to pull enemies torwards you."

		Hunter_Scarabs
			icon_state="Hunter Scarabs"
			mouse_drag_pointer = "Hunter Scarabs"
			name="Destruction Bug Hunter Scarabs"
			rank="S"
			uses=0
			signs="<font color=green>Dragon,Snake</font><br>(macro(5,2))"
			maxcooltime = 400
			ChakraCost = 25
			Clan="Aburame"
			Sprice=2
			reqs = list("Destruction Bug Swarm")
			Description="Summon Destruction Bugs that crawl slowly on the ground and protect you for great mobile area control."

		Destruction_Bug_Swarm
			icon_state="Destruction Bug Swarm"
			mouse_drag_pointer = "Destruction Bug Swarm"
			name="Destruction Bug Swarm"
			rank="S"
			uses=0
			signs="<font color=green>Snake,Dragon,Dragon</font><br>(macro(2,5,5))"
			maxcooltime = 200
			ChakraCost = 100
			Clan="Aburame"
			reqs = list("Insect Clone")
			Sprice=3
			Description="Uses the destruction bugs to make a large swarm that tears apart your enemies savagely."

		Stealth_Bug
			icon_state="Stealth Bug"
			mouse_drag_pointer = "Stealth Bug"
			name="Stealth Bug"
			rank="S"
			uses=0
			signs="<font color=green>Dragon,Dragon,Snake</font><br>(macro(5,5,2))"
			maxcooltime = 370
			ChakraCost = 50
			Clan="Aburame"
			reqs = list("Insect Clone")
			Sprice=2
			Description="Uses the destruction bugs to make a swarm of parasites that attack your enemy relentlessly from the inside."

		BugTornado
			icon_state="BugTornado"
			mouse_drag_pointer = "BugTornado"
			name="Bug Tornado"
			rank="S"
			uses=0
			signs="<font color=green>Dragon,Snake,Snake,Dragon,Dragon</font><br>(macro(5,2,2,5,5))"
			maxcooltime = 300
			ChakraCost = 600
			Clan="Aburame"
			Sprice=2
			reqs = list("Destruction Bug Swarm")
			Description="Summon Destruction Bugs that crawl slowly on the ground and protect you for great mobile area control."

//Hyuuga

		Byakugan
			icon_state="Byakugan"
			mouse_drag_pointer = "Byakugan"
			name="Byakugan"
			rank="D"
			signs="<font color=green>Snake</font><br>(macro(2))"
			maxcooltime = 30
			ChakraCost = 30
			Clan="Hyuuga"
			Description="The Hyuuga clan's Doujutsu. This technique gives the user 359 degree vision, and allows them to use strength style: Jyuuken."

		Eight_Trigrams_Palm_Heavenly_Spin
			icon_state="Kaiten"
			mouse_drag_pointer = "Kaiten"
			name="Eight Trigrams Palm: Heavenly Spin"
			rank="B"
			signs="<font color=green>Snake,Rat,Snake,Dragon</font><br>(macro(2,Q,2,5))"
			maxcooltime = 220
			ChakraCost = 70
			Sprice=2
			Clan="Hyuuga"
			reqs=list("Byakugan")
			Description="This technique allows the user to utilize their Byakugan and spin rapidly in a 360 degree motion, repelling all offensives against the user."

		Eight_Trigrams_Empty_Palm
			icon_state="Eight Trigrams Empty Palm"
			mouse_drag_pointer = "Eight Trigrams Empty Palm"
			name="Eight Trigrams: Empty Palm"
			rank="S"
			signs="<font color=green>Snake,Rat</font><br>(macro(2,Q))"
			maxcooltime = 100
			ChakraCost = 75 //Change
			Sprice=2
			Clan="Hyuuga"
			reqs=list("Byakugan")
			Description="This technique allows the user to utilize Byakugan and Jyuuken simultaneously. The user can deliver a punch so powerful it creates an impact shell of air and works like a projectile."

		Eight_Trigrams_Mountain_Crusher
			icon_state="Eight Trigrams Mountain Crusher"
			mouse_drag_pointer = "Eight Trigrams Mountain Crusher"
			name="Eight Trigrams: Mountain Crusher"
			rank="A"
			signs="<font color=green>Snake,Snake,Dog</font><br>(macro(2,2,E))"
			maxcooltime = 100
			ChakraCost = 50
			Description="A more powerful variation of Eight Trigrams Empty Palm. The user hits the target at close range with a powerful wave of chakra."
			Sprice=2
			reqs = list("Eight Trigrams: Empty Palm")
			Clan="Hyuuga"

		Eight_Trigrams_64_Palms
			icon_state="64 Palms"
			mouse_drag_pointer = "64 Palms"
			name="Eight Trigrams: 64 Palms"
			rank="A"
			signs="<font color=green>Snake,Rat,Dragon,Rat,Dragon</font><br>(macro(2,Q,5,Q,5))"
			maxcooltime = 450
			ChakraCost = 250
			Sprice=3
			Clan="Hyuuga"
			reqs=list("Eight Trigrams: Empty Palm")
			Description="This technique allows the user to utilize Byakugan and Jyuuken simultaneously. The user can rapidly strike all of an opponents chakra points, disabling their ability to use chakra."

		Eight_Gates_Assault
			icon_state="Eight Gates Assault"
			mouse_drag_pointer = "Eight Gates Assault"
			name="Last Resort: Eight Gates Assault"
			rank="S"
			signs="<font color=green>Snake,Rat,Dragon,Rat,Dragon,Dragon</font><br>(macro(2,Q,5,Q,5,5))"
			maxcooltime = 600
			ChakraCost = 300
			Sprice=4
			Clan="Hyuuga"
			reqs=list("Eight Trigrams: 64 Palms")
			Description="This technique allows the user to utilize Byakugan and Jyuuken simultaneously. The user can strike and close the opponent's eight chakra gates, mortally wounding them."

//Kaguya

		Bone_Tip
			icon_state="BoneT"
			mouse_drag_pointer = "BoneT"
			name="Bone Tip"
			rank="C"
			signs="<font color=green>Ox</font><br>(macro(W))"
			maxcooltime = 100
			ChakraCost = 5
			Clan="Kaguya"
			Description="Using the finger tip-like bones, this technique allows one to blast off those bones towards their target. Skilled users can get the bones lodged in the target"

		Bone_Sensation
			icon_state="BoneS"
			mouse_drag_pointer = "BoneS"
			name="Bone Sensation"
			rank="C"
			signs="<font color=green>Ox,Ox,Rat</font><br>(macro(W,W,Q))"
			maxcooltime = 200
			ChakraCost = 10
			Sprice=2
			Clan="Kaguya"
			reqs=list("Bone Tip")
			Description="After using the finger-tip like bones that have been implanted into your opponent, you can follow it up with this deadly technique which forces the bone-tips to expel outwards from the target's body.."

		Camellia_Dance
			icon_state="Camellia Dance"
			mouse_drag_pointer = "Camellia Dance"
			name="Camellia Dance"
			rank="C"
			signs="<font color=green>Rat,Rat,Ox</font><br>(macro(Q,Q,W))"
			maxcooltime = 10
			ChakraCost = 50
			Sprice=3
			Clan="Kaguya"
			reqs=list("Bone Tip")
			Description="Harden your bones to form a sword which can make your physical attacks stronger."

		Bone_Drill
			icon_state="Bone Drill"
			mouse_drag_pointer = "Bone Drill"
			name="Bone Drill"
			rank="C"
			signs="<font color=green>Rat,Rat,Rat</font><br>(macro(Q,Q,Q))"
			maxcooltime = 220
			ChakraCost = 25
			Sprice=3
			Clan="Kaguya"
			reqs=list("Camellia Dance")
			Description="Harden your bones to form a drill which can drive through your opponents."

		Bone_Pulse
			icon_state="BoneP"
			mouse_drag_pointer = "BoneP"
			name="Bone Pulse"
			rank="C"
			signs="<font color=green>Rat,Dog,Ox</font><br>(macro(Q,E,W))"
			maxcooltime = 150
			ChakraCost = 35
			Clan="Kaguya"
			Sprice=3
			reqs=list("Bone Sensation")
			Description="This technique allows one to unleash their bones from their body into large sharp bone fangs that erupt from the ground before them. They are able to pierce their opponent."

		Young_Bracken_Dance
			icon_state="young bracken dance"
			mouse_drag_pointer = "young bracken dance"
			name="Young Bracken Dance"
			rank="C"
			signs="<font color=green>Rat,Dog,Ox,Ox</font><br>(macro(Q,E,W,W))"
			maxcooltime=0//240
			ChakraCost = 300
			Sprice=0
			Clan="Kaguya"
			reqs=list("Bone Pulse")
			Description="This technique allows one to unleash their bones from their body into large sharp bone fangs that erupt from the ground all around them, in a range that varies on the user's ability to control the skill."

		Dance_Of_The_Kaguya
			icon_state="DOTK"
			mouse_drag_pointer = "DOTK"
			name="Dance Of The Kaguya"
			rank="A"
			signs="<font color=green>Rat,Dog,Ox,Rat</font><br>(macro(Q,E,W,Q))"
			maxcooltime=550
			ChakraCost = 300
			Clan="Kaguya"
			Sprice=3
			reqs=list("Bone Pulse")
			Description="This technique allows one to unleash their bones from their hands to make a series of taijutsu combos that damages the enemy greatly."


//Clay

		Deidara
			icon_state="Deidara"
			mouse_drag_pointer = "Deidara"
			name="Deidara"
			rank="S"
			signs="<font color=green>None</font><br>"
			maxcooltime = 0
			ChakraCost = 0
			Sprice=3
			Clan="No Clan"
			Element="Earth"
			Description="By using the forbidden Kinjutsu of the Iwagakure along with exploding clay, you gain the ability to create dolls which attack the opponent and explode."

		C1_Birds
			icon_state="C1 bird"
			mouse_drag_pointer = "C1 bird"
			name="C1: Tracking Birds"
			rank="B"
			signs="<font color=green>Dragon,Rabbit,Dragon</font><br>(macro(5,1,5))"
			maxcooltime = 280
			ChakraCost = 50
			Element="Earth"
			reqs = list("Deidara")
			Description="This technique allows one to use special mouths on the palms of their hands to create a swarm of clay tracking birds, which fly towards a target and explode on impact."

		C1_Spiders
			icon_state="C1 spider"
			mouse_drag_pointer = "C1 spider"
			name="C1: Spider Swarm"
			rank="B"
			signs="<font color=green>Dragon,Dog,Dragon</font><br>(macro(5,E,5))"
			maxcooltime=200
			ChakraCost = 25
			Element="Earth"
			reqs = list("Deidara")
			Description="This technique allows one to use special mouths on the palms of their hands to create a swarm of clay spiders, which slowly stalk a target and explode on impact."

		C1Snake
			icon_state="C1Snake"
			mouse_drag_pointer = "C1Snake"
			name="C1: Exploding Snake"
			rank="B"
			signs="<font color=green>Dragon,Snake,Dragon</font><br>(macro(5,2,5))"
			maxcooltime = 330
			ChakraCost = 150
			Element="Earth"
			reqs = list("C1: Tracking Birds")
			Description="This technique allows one to use special mouths on the palms of their hands to create a deadly exploding snake that can devaste it's target."

		C2
			icon_state="C2"
			mouse_drag_pointer = "C2"
			name="C2"
			rank="S"
			signs="<font color=green>Dragon,Dragon,Dragon,Dragon,Dragon</font><br>(macro(5,5,5,5,5))"
			maxcooltime = 1200
			ChakraCost = 250
			Sprice=3
			Element="Earth"
			reqs = list("C1: Tracking Birds","C1: Spider Swarm")
			Description="This technique allows one to use special mouths on the palms of their hands to create a large clay dragon, which can use the clay it consists of to fire a managerie of explosives at it's oppoenents."

		C3
			icon_state="C3"
			mouse_drag_pointer = "C3"
			name="C3"
			rank="S"
			signs="<font color=green>Dragon,Dragon,Dragon,Dragon,Dog</font><br>(macro(5,5,5,5,E))"
			maxcooltime = 360
			ChakraCost = 150
			Sprice=3
			Element="Earth"
			reqs = list("C2")
			Description="This technique allows one to use special mouths on the palms of their hands to create a large clay doll slightly in the shape of a human, which then falls down from the sky and delivers death to below with an apocalyptic explosion."

//Ice

		Ice
			icon_state="IceKekkeiGenkai"
			mouse_drag_pointer = "IceKekkeiGenkai"
			name="Ice"
			rank="S"
			signs="<font color=green>None</font><br>"
			maxcooltime = 170
			ChakraCost = 0
			Sprice=3
			Clan="No Clan"
			Description="Allows user to gain powers of the Ice Kekkei Genkai."

		Demonic_Ice_Mirrors
			icon_state="Demonic Ice Mirrors"
			mouse_drag_pointer = "Demonic Ice Mirrors"
			name="Demonic Ice Mirrors"
			rank="B"
			signs="<font color=green>Rabbit,Dog,Dog,Ox,Rabbit</font><br>(macro(1,E,E,W,1))"
			maxcooltime = 600
			ChakraCost = 100
			Sprice=2
			Clan = "Ice"
			reqs = list("Ice")
			Description="This technique creates multiple ice-like mirrors around the selected target, and allows the user to throw needles towards the target from different angles by warping to the different mirrors at high speeds."

		Sensatsu_Suishou
			icon_state="Sensatsu Suishou"
			mouse_drag_pointer = "Sensatsu Suishou"
			name="Sensatsu Suishou"
			rank="A"
			signs="<font color=green>Rabbit,Dog,Rabbit</font><br>(macro(1,E,1))"
			maxcooltime = 180
			ChakraCost = 45
			Sprice=2
			Clan = "Ice"
			reqs = list("Ice")
			Description="This technique forms deadly ice needles that impale your opponents."

		Iceball
			icon_state="Iceball"
			mouse_drag_pointer = "Iceball"
			name="Iceball"
			rank="B"
			signs="<font color=green>Rabbit,Dog,Dog,Rabbit</font><br>(macro(1,E,E,1))"
			maxcooltime = 120
			ChakraCost = 150
			Sprice=2
			Clan = "Ice"
			reqs=list("Sensatsu Suishou")
			Description="Iceball: Used in combination with water, this technique forms a deadly ice ball that impale your opponents."

		Omega_Ice_Ball
			icon_state="GiantIceBall"
			mouse_drag_pointer = "GiantIceBall"
			name="Omega Ice Ball"
			rank="S"
			signs="<font color=green>Rabbit,Dog,Dog,Rabbit,Dog,Dog,Rabbit</font><br>(macro(1,E,E,1,E,E,1))"
			maxcooltime = 300
			ChakraCost = 250
			reqs=list("Iceball")
			Sprice=5
			uses=100
			Clan = "Ice"
			Description="Omega Ice Ball: An Giant Iceball streaming with only power of ice & destroying all in it's path."

//Kakuzu

		Kakuzu
			icon_state="Kakuzu"
			mouse_drag_pointer = "Kakuzu"
			name="Kakuzu"
			rank="S"
			signs="<font color=green>None</font><br>"
			maxcooltime = 0
			Sprice = 4
			Clan="No Clan"
			Description="Gain powers of Kakuzu that allow you to use elemental jutsus without affinity towards that element!"

		FireMask
			icon_state="FireMask"
			mouse_drag_pointer = "FireMask"
			name="Fire Mask"
			rank="A"
			signs="<font color=green>Dog,Snake</font><br>(macro(E,2))"
			maxcooltime = 175
			ChakraCost = 50
			Sprice=2
			reqs = list("Kakuzu")
			Description="Allows the user to summon a Fire Heart that uses a single Fire jutsu."

		WindMask
			icon_state="WindMask"
			mouse_drag_pointer = "WindMask"
			name="Wind Mask"
			rank="A"
			signs="<font color=green>Ox,Snake</font><br>(macro(W,2))"
			maxcooltime = 60
			ChakraCost = 50
			Sprice=2
			reqs = list("Kakuzu")
			Description="Allows the user to summon a Wind Heart that uses a single Wind jutsu."

		EarthMask
			icon_state="EarthMask"
			mouse_drag_pointer = "EarthMask"
			name="Earth Mask"
			rank="A"
			signs="<font color=green>Dragon,Rabbit</font><br>(macro(5,1))"
			maxcooltime = 300
			ChakraCost = 50
			Sprice=2
			reqs = list("Kakuzu")
			Description="Allows the user to summon a Earth Heart that uses a single Earth jutsu."

		LightningMask
			icon_state="LightningMask"
			mouse_drag_pointer = "LightningMask"
			name="Lightning Mask"
			rank="A"
			signs="<font color=green>Dog,Rabbit</font><br>(macro(E,1))"
			maxcooltime = 400
			ChakraCost = 50
			Sprice=2
			reqs = list("Kakuzu")
			Description="Allows the user to summon a Lightning Heart that uses a single Lightning jutsu."

//Puppeteer

		Puppeteer
			icon_state="Puppeteer"
			mouse_drag_pointer = "Puppeteer"
			name="Puppeteer"
			rank="B"
			signs="<font color=green>None</font><br>"
			maxcooltime = 0
			ChakraCost = 0
			Sprice=2
			Clan="No Clan"
			Description="Train yourself to learn to control a puppet through chakra strings that come from your fingers."

		First_Puppet_Summoning
			icon_state="puppet 1"
			mouse_drag_pointer = "puppet 1"
			name="First Puppet Summoning"
			rank="C"
			signs="<font color=green>Rabbit,Rabbit,Snake</font><br>(macro(1,1,2))"
			uses=100
			maxcooltime = 100
			ChakraCost = 250
			Sprice=2
			reqs = list("Puppeteer")
			Description="Though it takes a long time to learn, the art of puppetry is a valuable technique to have in battle. This skill alows you to summon a puppet which can uses its hidden weapons to attack opponents."

		Puppet_Dash
			icon_state="puppet dashing"
			mouse_drag_pointer = "puppet dashing"
			name="Puppet Dash"
			rank="B"
			signs="<font color=green>None</font><br>"
			uses=100
			maxcooltime = 20
			ChakraCost = 30
			reqs = list("First Puppet Summoning")
			Description="Imbue more chakra into the strands that bind your puppet to you than normal and enable the ability to move your puppets at greater speeds than ever before."

		Puppet_Shoot
			icon_state="puppet shoot"
			mouse_drag_pointer = "puppet shoot"
			name="Puppet Shoot"
			rank="B"
			signs="<font color=green>None</font><br>"
			uses=100
			Sprice=2
			maxcooltime = 200
			ChakraCost = 20
			reqs = list("First Puppet Summoning")
			Description="Make your puppets load one of their hidden weapons, the Arm Knife, for use."

		Puppet_Transform
			icon_state="puppet transform"
			mouse_drag_pointer = "puppet transform"
			name="Puppet Transform"
			rank="B"
			signs="<font color=green>None</font><br>"
			uses=100
			maxcooltime = 100
			ChakraCost = 30
			reqs = list("Second Puppet Summoning")
			Description="Make your puppets transform to look identical to you."

		Puppet_Grab
			icon_state="puppet grab"
			mouse_drag_pointer = "puppet grab"
			name="Puppet Grab"
			rank="B"
			signs="<font color=green>None</font><br>"
			uses=100
			Sprice=2
			maxcooltime = 200
			ChakraCost = 30
			reqs = list("Puppet Transform")
			Description="Make your puppets loosen their arms' joints, ready to grab a foe."

		Second_Puppet_Summoning
			icon_state="puppet 2"
			mouse_drag_pointer = "puppet 2"
			name="Second Puppet Summoning"
			rank="B"
			signs="<font color=green>Rabbit,Snake,Snake</font><br>(macro(1,2,2))"
			uses=100
			Sprice=3
			maxcooltime = 100
			ChakraCost = 250
			reqs = list("First Puppet Summoning")
			Description="Though it takes a long time to learn, the art of puppetry is a valuable technique to have in battle. This skill alows you to summon a second puppet which can uses its hidden weapons to attack opponents."

		Summon_Kazekage_Puppet
			icon_state="kpuppet"
			mouse_drag_pointer = "kpuppet"
			name="Forbiden Tehnique: Kazekage Puppet"
			rank="S"
			signs="<font color=green>Snake,Rabbit,Rat,Rabbit,Snake,Ox</font><br>(macro(2,1,Q,1,2,W))"
			uses=100
			maxcooltime = 300
			ChakraCost = 200
			Clan="Puppeteer"
			reqs = list("Second Puppet Summoning")
			Description="Puppet Master's ultimate jutsu and a forbiden one. Summons a Puppet made from body of a Kazekage."

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

		Tree_Summoning //Broken?
			icon_state="Tree Summoning"
			mouse_drag_pointer = "Tree Summoning"
			name="Wood Style: Tree Summoning"
			rank="S"
			uses=0
			signs="<font color=green>Dog,Ox,Ox,Ox</font><br>(macro(E,Q,Q,Q))"
			maxcooltime = 150
			ChakraCost = 120
			Clan="Senjuu"
			reqs=list("Wood Drill")
			Sprice=2
			Description="Summon a Tree towering over even the toughest of foes."

		Root_Strangle
			icon_state="Tree Bind"
			mouse_drag_pointer = "Tree Bind"
			name="Wood Release: Root Strangle"
			rank="B"
			uses=0
			signs="<font color=green>Dog,Rabbit,Ox</font><br>(macro(E,1,W))"
			maxcooltime = 220
			ChakraCost = 200
			Clan="Senjuu"
			Sprice=2
			Description="Focuses chakra in order to create a tree to stun the enemy."

		Wood_Balvan//change to/create wood palm
			icon_state="Wood Balvan"
			mouse_drag_pointer = "Wood Balvan"
			name="Wood Release: Wooden Balvan"
			rank="A"
			uses=0
			signs="<font color=green>Dog,Rabbit,Ox,Dog</font><br>(macro(E,1,W,E))"
			maxcooltime = 220
			ChakraCost = 200
			Clan="Senjuu"
			Sprice=3
			reqs=list("Wood Release: Root Strangle")
			Description="Focuses chakra in order to create a huge balvan to strike the enemy."

		WoodStyleFortress
			icon_state="WoodStyleFortress"
			mouse_drag_pointer = "WoodStyleFortress"
			name="Wood Release: Wood Fortress"
			rank="B"
			signs="<font color=green>Dog,Dog,Dog,Ox</font><br>(macro(E,E,E,W))"
			maxcooltime = 230
			ChakraCost = 130
			Sprice=2
			reqs=list("Wood Release: Root Strangle")
			Description="This technique allows one to create huge wooden fortrest to protect the user."

		Root_Stab // change to/make rampant earth.
			icon_state="Root Stab"
			mouse_drag_pointer = "Root Stab"
			name="Wood Release: Root Stab"
			rank="S"
			uses=0
			signs="<font color=green>Dog,Rabbit,Ox,Dog,Dog</font><br>(macro(E,1,W,E,E))"
			maxcooltime = 300
			ChakraCost = 200
			Clan="Senjuu"
			Sprice=3
			reqs=list("Wood Release: Wood Fortress")
			Description="Summons deadly spikes made out of wood to severely damage ."

		JukaiKoutan // Remove
			icon_state="Jukai"
			mouse_drag_pointer = "Jukai"
			name="Mokuton Hijutsu - Jukai Koutan"
			rank="S"
			signs="<font color=green>Snake,Snake,Rabbit,Rat,Rabbit</font><br>(macro(2,2,1,Q,1))"
			maxcooltime = 600
			ChakraCost = 75
			Sprice=4
			Clan="Senjuu"
			reqs=list("Wood Drill")
			reqs = list("Mokuton - Jubaku Eisou")
			Description=" Jukai Koutan: User creates a forest that will damage everyone in it"

		JubakuEisou
			icon_state="jubakueisou"
			mouse_drag_pointer = "jubakueisou"
			name="Mokuton - Jubaku Eisou"
			rank="B"
			signs="<font color=green>Rat,Snake,Snake,Rabbit</font><br>(macro(Q,2,2,1))"
			maxcooltime=360
			Sprice=1
			Clan="Senjuu"
			reqs=list("Wood Drill")
			Description="Jubaku Eisou: User creates a prison made of wood around his target to paralyze him"

		Daijurin
			icon_state="daijurin"
			mouse_drag_pointer = "daijurin"
			name="Mokuton - Daijurin no Jutsu"
			rank="B"
			signs="<font color=green>Rat,Rat,Snake,Rabbit,Rabbit</font><br>(macro(Q,Q,2,1,1))"
			maxcooltime=460
			ChakraCost = 125
			Sprice=1
			reqs=list("Wood Release: Wooden Balvan")
			Clan="Senjuu"
			Description="Daijurin: User stretchs is arm creating wood from it that wood arm will damage anyone he touches"

//Ink

		Ultimate_Ink_Bird
			icon_state="InkBird"
			mouse_drag_pointer = "InkBird"
			name="Ultimate Ink Bird"
			rank="S"
			signs="<font color=green>Dragon,Rabbit,Monkey,Dog,Rabbit,Dog,Dog</font><br>(macro(5,1,4,E,5,1,E,E))"
			maxcooltime = 400
			ChakraCost = 350
			Sprice=5
			Clan="Ink"
			reqs=list("Ink Style: Snake Rustle Jutsu")
			Description="An Giant Ink Bird streaming with only power of Ink & destroying all in it's path."

		Ink_Lions
			icon_state="Ink Lions"
			mouse_drag_pointer = "Ink Lions"
			name="Ultimate Ink Style: Lions"
			rank="S"
			signs="<font color=green>Rabbit,Dragon,Dog,Rabbit,Dragon,Dog</font><br>(macro(1,5,E,1,5,E))"
			maxcooltime = 240
			ChakraCost = 200
			reqs=list("Ink Style: Snake Rustle Jutsu")
			Clan="Ink"
			Description="This technique creates a bunch of drawn lions dashing towards your opponent with their full might and explodes!"

		Snake_Rustle_Jutsu
			icon_state="Snake Rustle Jutsu"
			mouse_drag_pointer = "Snake Rustle Jutsu"
			name="Ink Style: Snake Rustle Jutsu"
			rank="B"
			signs="<font color=green>Rabbit,Horse,Monkey,Dragon</font><br>(macro(1,3,4,5))"
			maxcooltime = 500
			ChakraCost = 100
			Sprice=2
			Clan="Ink"
			reqs=list("Ink Style: Rats")
			Description="This technique allows one to convert their chakra into drawings and make them come into motion binding the opponent."

		Sai_Snakes
			icon_state="Sai Snakes"
			mouse_drag_pointer = "Sai Snakes"
			name="Ink Style: Snakes"
			rank="A"
			signs="<font color=green>Rabbit,Dragon,Dog,Monkey,Rabbit</font><br>(macro(1,5,E,4,1))"
			maxcooltime = 120
			ChakraCost = 200
			Sprice=2
			Clan="Ink"
			reqs=list("Ink Style: Snake Rustle Jutsu")
			Description="Bites your opponent poisoning them."

		Sai_Rat
			icon_state="SaiRat"
			mouse_drag_pointer = "SaiRat"
			name="Ink Style: Rats"
			rank="B"
			signs="<font color=green>Rabbit,Dog,Monkey,Rabbit</font><br>(macro(1,E,4,1))"
			maxcooltime = 100
			ChakraCost = 100
			Sprice=2
			Clan="Ink"
			Description="Draws rats that naws on your opponent!"

//Weaponist

		Blade_Manipulation_Jutsu
			icon_state="Blade Manipulation Jutsu"
			mouse_drag_pointer = "Blade Manipulation Jutsu"
			name="Blade Manipulation Jutsu"
			rank="B"
			Clan="Weaponist"
			signs="<font color=green>Dragon,Horse,Dragon</font><br>(macro(5,3,5))"
			maxcooltime = 180
			ChakraCost = 60
			Sprice=2
			Description="Tie several kunai along a chakra string and throw to home in on a target."

		Weapon_Manipulation_Jutsu
			icon_state="wmj"
			mouse_drag_pointer = "wmj"
			name="Weapon Manipulation Jutsu"
			rank="A"
			signs="<font color=green>Dragon,Horse,Dragon,Horse</font><br>(macro(5,3,5,3))"
			maxcooltime = 200
			ChakraCost = 200
			Clan="Weaponist"
			reqs = list("Blade Manipulation Jutsu")
			Sprice=3
			Description="Tie several kunai along a chakra string and throw to home in on a target."

		Multiple_Chakra_Kunai
			icon_state="Multiple Chakra Kunai"
			mouse_drag_pointer = "Multiple Chakra Kunai"
			name="Multiple Chakra Kunai"
			rank="A"
			signs="<font color=green>Dragon,Horse,Dragon,Horse</font><br>(macro(5,3,5,3))"
			maxcooltime = 230
			ChakraCost = 100
			Sprice=3
			Clan="Weaponist"
			reqs=list("Weapon Manipulation Jutsu")
			Description="Tie several kunai along a chakra string and swing them hazing into your opponent."

		Demon_Wind_Shuriken
			icon_state="Demon Wind Shuriken"
			mouse_drag_pointer = "Demon Wind Shuriken"
			name="Demon Wind Shuriken"
			rank="A"
			signs="<font color=green>Dragon,Horse,Horse,Dragon,Dragon</font><br>(macro(5,3,3,5,5))"
			maxcooltime = 220
			ChakraCost = 100
			Sprice=3
			reqs=list("Blade Manipulation Jutsu")
			Description="Tie several wind shurikens along a chakra string and throw them on a target by using your chakra."

		TwinDragons
			icon_state="twindragons"
			mouse_drag_pointer = "twindragons"
			name="Twin Dragons"
			rank="S"
			signs="<font color=green>Dragon,Horse,Dragon,Horse,Dragon,Dragon</font><br>(macro(5,3,5,3,5,5))"
			maxcooltime = 300
			ChakraCost = 500
			Clan="Weaponist"
			reqs = list("Weapon Manipulation Jutsu")
			Sprice=5
			Description="Tie several kunai along a chakra string and throw to home in on a target."

//Akimichi

		GreenPill
			icon_state="GreenPill"
			mouse_drag_pointer = "GreenPill"
			name="GreenPill"
			rank="D"
			maxcooltime = 200
			ChakraCost = 100
			Sprice=1
			Clan="Akimichi"
			uses=100
			signs="<font color=green>None</font><br>"
			Description="Akimichi clan pill. Gives it's user boost in strenght but has health side effects..."

		YellowPill
			icon_state="YellowPill"
			mouse_drag_pointer = "YellowPill"
			name="YellowPill"
			rank="C"
			maxcooltime = 250
			ChakraCost = 200
			Sprice=2
			Clan="Akimichi"
			uses=100
			signs="<font color=green>None</font><br>"
			reqs=list("GreenPill")
			Description="Akimichi clan pill. Gives it's user more strenght and has stronger health side effects..."

		RedPill
			icon_state="RedPill"
			mouse_drag_pointer = "RedPill"
			name="RedPill"
			rank="B"
			uses=100
			maxcooltime = 300
			ChakraCost = 300
			Sprice=3
			Clan="Akimichi"
			signs="<font color=green>None</font><br>"
			reqs=list("YellowPill")
			Description="Akimichi clan pill. Last and most unsafe of Akimichi pills. User becomes super strong at cost of health demage at the pill effect end..."

		HumanBulletTank
			icon_state="Human Bullet Tank"
			mouse_drag_pointer = "Human Bullet Tank"
			name="Human Bullet Tank"
			rank="A"
			Clan="Akimichi"
			signs="<font color=green>None</font><br>"
			maxcooltime = 230
			ChakraCost = 500
			Sprice=5
			uses=100
			reqs=list("YellowPill")
			Description="Akimichi clan speciallity. User becomes transformed into anormous ball of mostly chakra. If spinned at a high speed it allows one to crush his enemies in the way..."

		CalorieControl
			icon_state="CalorieControl"
			mouse_drag_pointer = "CalorieControl"
			name="Calorie Control"
			rank="S"
			signs="<font color=green>Ox,Ox,Dragon,Ox</font><br>(macro(W,W,5,W))"
			Sprice=8
			maxcooltime = 280
			ChakraCost = 1000
			Clan="Akimichi"
			reqs=list("RedPill")
			Description="Last and best of Akimichi jutsus. When used person acumulates his body calories into chakra and releases that chakra in a wing shape. Gives anormous amount of strength.."

//Sand

		Sand
			icon_state="Sand"
			mouse_drag_pointer = "Sand"
			name="Sand"
			rank="S"
			signs="<font color=green>None</font><br>"
			maxcooltime = 0
			ChakraCost = 0
			Sprice=3
			Clan="No Clan"
			Element="Earth"
			Description="Gain the ability to convert chakra into sand."

		Shukakku_Spear
			icon_state="Shukakku Spear"
			mouse_drag_pointer = "Shukakku Spear"
			name="Shukakku Spear"
			rank="S"
			uses=0
			signs="<font color=green>Dog,Dog,Ox,Dog</font><br>(macro(E,E,W,E))"
			maxcooltime = 260
			Clan="Sand"
			reqs=list("Sand Shuriken")
			Sprice=3
			Description="Summon sand from the earth and use it to form a powerful spear for hurling towards your foes."

		Sand_Funeral
			icon_state="Sand Funeral"
			mouse_drag_pointer = "Sand Funeral"
			name="Sand Funeral"
			rank="S"
			uses=0
			signs="<font color=green>Dog,Ox,Ox,Dog</font><br>(macro(E,W,W,E))"
			maxcooltime = 100
			ChakraCost = 300
			Clan="Sand"
			reqs=list("Desert Coffin")
			Sprice=3
			Description="Use the sand wrapped around your foe from Desert Coffin to kill them by form sharp spikes and stabbing it inwards."

		Sand_Shuriken
			icon_state="Sand Shuriken"
			mouse_drag_pointer = "Sand Shuriken"
			name="Sand Shuriken"
			rank="S"
			uses=0
			signs="<font color=green>Dog,Dog,Ox</font><br>(macro(E,E,W))"
			maxcooltime = 100
			ChakraCost = 30
			Clan="Sand"
			reqs=list("Sand")
			Sprice=2
			Description="Summon sand from the earth and use it to form multiple shurikens for hurling towards your foes."

		Desert_Coffin
			icon_state="Desert Coffin"
			mouse_drag_pointer = "Desert Coffin"
			name="Desert Coffin"
			rank="S"
			uses=0
			signs="<font color=green>Dog,Dog,Ox,Ox</font><br>(macro(E,E,W,W))"
			maxcooltime = 340
			ChakraCost = 200
			Clan="Sand"
			reqs=list("Sand")
			Sprice=2
			Description="Summon sand from the earth and use it to trap your opponent for a long amount of time."

		Sand_Shield
			icon_state="Sand Shield"
			mouse_drag_pointer = "Sand Shield"
			name="Sand Shield"
			rank="B"
			signs="<font color=green>Dog,Ox,Dog,Ox</font><br>(macro(E,W,E,W))"
			maxcooltime = 330
			ChakraCost = 75
			Sprice=2
			uses=0
			reqs=list("Desert Coffin")
			Description="Creates a shield of sand around you which can block most attacks and attack with powerful close-range spikes."

//Crystal

		Crystal_Shards
			icon_state="Crystal Shards"
			mouse_drag_pointer = "Crystal Shards"
			name="Crystal Release: Crystal Shards"
			rank="B"
			uses=0
			signs="<font color=green>Ox,Rabbit,Dog</font><br>(macro(W,1,E))"
			maxcooltime = 200
			ChakraCost = 180
			Clan="Crystal"
			Sprice=2
			Description="Focuses chakra in order to create a shard to strike the enemy."

		Crystal_Needles
			icon_state="Crystal Needles"
			mouse_drag_pointer = "Crystal Needles"
			name="Crystal Release: Crystal Needles"
			rank="A"
			uses=0
			signs="<font color=green>Dog,Rabbit,Rabbit,Dog</font><br>(macro(E,1,1,E))"
			maxcooltime = 190
			ChakraCost = 150
			Clan="Crystal"
			Sprice=3
			reqs=list("Crystal Release: Crystal Shards")
			Description="Focuses chakra in order to create a couple of needles to strike the enemy."

		Crystal_Spikes
			icon_state="Crystal Spikes"
			mouse_drag_pointer = "Crystal Spikes"
			name="Crystal Release: Crystal Spikes"
			rank="B"
			signs="<font color=green>Rabbit,Dog,Dog,Ox</font><br>(macro(1,E,E,W))"
			maxcooltime = 300
			ChakraCost = 300
			Sprice=2
			reqs=list("Crystal Release: Crystal Needles")
			Description="Deadly spikes made out of crystal that come out of ground to stab users target."

		Crystal_Explosion
			icon_state="Crystal Explosion"
			mouse_drag_pointer = "Crystal Explosion"
			name="Crystal Release: Crystal Explosion"
			rank="S"
			uses=0
			signs="<font color=green>Rabbit,Rabbit,Ox,Dog,Dog</font><br>(macro(1,1,W,E,E))"
			maxcooltime = 280
			ChakraCost = 400
			Clan="Crystal"
			Sprice=3
			reqs=list("Crystal Release: Crystal Spikes")
			Description="Strongest Crystal Release jutsu. Huge number of crystal spikes hurls foward in order to kill anything it touches !"

		Crystal_Mirrors
			icon_state="Crystal Mirrors"
			mouse_drag_pointer = "Crystal Mirrors"
			name="Crystal Mirrors"
			rank="B"
			signs="<font color=green>Ox,Rabbit,Dog,Ox</font><br>(macro(W,1,E,W))"
			maxcooltime = 240
			ChakraCost = 250
			Sprice=3
			Clan="Crystal"
			reqs=list("Crystal Pillar")
			Description="Crystal Mirrors: This technique creates solid mirrors of the hardest iron in the world, Crystal. Allowing you to attack from each & every mirror."

		Crystal_Arrow
			icon_state="Crystal Arrow"
			mouse_drag_pointer = "Crystal Arrow"
			name="Crystal Arrow"
			rank="S"
			signs="<font color=green>Ox,Rabbit,Dog,Ox,Ox,Rabbit,Dog,Ox</font><br>(macro(W,1,E,W,W,1,E,W))"
			maxcooltime = 300
			ChakraCost = 250
			Sprice=3
			Clan="Crystal"
			reqs=list("Crystal Mirrors")
			Description="Crystal Arrow: An Giant Arrow shot by the will & the determination of the user."

		Crystal_Pillar
			icon_state="Crystal Pillar"
			mouse_drag_pointer = "Crystal Pillar"
			name="Crystal Pillar"
			rank="S"
			signs="<font color=green>Ox,Ox,Dog,Rabbit</font><br>(macro(W,W,E,1))"
			maxcooltime = 360
			ChakraCost = 200
			Sprice=3
			Clan="Crystal"
			Description="Crystal Pillar: An Giant Arrow shot by the will & the determination of the user."

//Paper

		Paper_Control
			icon_state="Paper Control"
			mouse_drag_pointer = "Paper Control"
			name="Paper Control"
			rank="S"
			signs="<font color=green>None</font><br>"
			maxcooltime = 0
			ChakraCost = 0
			Sprice=3
			Clan="No Clan"
			Description="Gain the ability to convert chakra into paper."

		Paper_Chakram
			icon_state="Paper Chakram"
			mouse_drag_pointer = "Paper Chakram"
			name="Paper Chakram"
			rank="B"
			signs="<font color=green>Ox,Rat</font><br>(macro(W,Q))"
			uses=100
			Clan = "Paper"
			reqs = list("Paper Control")
			maxcooltime = 200
			ChakraCost = 300
			Sprice=3
			Description="A technique that consists of pouring one's chakra into a scrap of paper in a split second, hardening and sharpening it, so it can be used as a chakram."

		Shikigami_Spear
			icon_state="Shikigami Spear"
			mouse_drag_pointer = "Shikigami Spear"
			name="Shikigami Spear"
			rank="A"
			signs="<font color=green>Ox,Rat,Ox</font><br>(macro(W,Q,W))"
			uses=0
			Clan = "Paper"
			reqs = list("Paper Control")
			maxcooltime = 300
			ChakraCost = 90
			Description="Channel your chakra through paper and fire a deadly spear created from it."

		Shikigami_Dance
			icon_state="Shikigami Dance"
			mouse_drag_pointer = "Shikigami Dance"
			name="Shikigami Dance"
			rank="A"
			signs="<font color=green>Ox,Rat,Rat,Rat</font><br>(macro(W,Q,Q,Q))"
			uses=0
			Clan = "Paper"
			reqs = list("Paper Chakram")
			maxcooltime = 480
			ChakraCost = 300
			Description="Bind your enemy with a magnificent flow of paper."

		Angel_Wings
			icon_state="Angel Wings"
			mouse_drag_pointer = "Angel Wings"
			name="Angel Wings"
			rank="S"
			signs="<font color=green>Rat,Ox,Ox,Rat</font><br>(macro(Q,W,W,Q))"
			uses=100
			Clan = "Paper"
			reqs = list("Paper Chakram")
			maxcooltime = 600
			ChakraCost = 200
			Description="Creates huge Paper Wings which boost your Clan's power by a lot. Each Jutsu gains an additional effect!"

//Jashin

		Jashin_Religion
			icon_state="Jashin Religion"
			mouse_drag_pointer = "Jashin Religion"
			name="Jashin Religion"
			rank="S"
			signs="<font color=green>None</font><br>"
			maxcooltime = 0
			ChakraCost = 0
			Sprice=4
			Clan="No Clan"
			Description="Learn to worship Jashin and harness evil powers."

		Death_Ruling_Possesion_Blood
			icon_state="Death Ruling Possesion Blood"
			mouse_drag_pointer = "Death Ruling Possesion Blood"
			name="Sorcery: Death Ruling Possesion Blood"
			rank="S"
			signs="<font color=green>None</font><br>"
			maxcooltime = 650
			Sprice=3
			uses=100
			ChakraCost = 250
			Clan="Jashin"
			Description="Create a circle of blood and, while standing within it, turn yourself into a voodoo doll and stab yourself to harm another."

		Immortality
			icon_state="Immortality"
			mouse_drag_pointer = "Immortality"
			name="Sacrifice to Jashin"
			rank="S"
			signs="<font color=green>None</font><br>"
			maxcooltime = 450
			ChakraCost = 100
			Sprice=3
			uses=100
			reqs = list("Sorcery: Death Ruling Possesion Blood")
			Clan="Jashin"
			Description="Sacrifice someone's life to grant yourself immortality."

		Immortal
			icon_state="Immortal"
			mouse_drag_pointer = "Immortal"
			name="Immortal"
			rank="S"
			signs="<font color=green>None</font><br>"
			maxcooltime = 600
			ChakraCost = 100
			Sprice=5
			uses=100
			reqs = list("Sacrifice to Jashin")
			Clan="Jashin"
			Description="Grants a period of complete Immortality to Jashin worshipers."

//Spider

		Spider
			icon_state="Spider"
			mouse_drag_pointer = "SpiderSpider"
			name="Spider"
			rank="B"
			signs="<font color=green>None</font><br>"
			maxcooltime = 0
			ChakraCost = 0
			Sprice=4
			Clan="No Clan"
			Description="Become the spider itself and learn its ways!"

		WebShoot
			icon_state="WebShoot"
			mouse_drag_pointer = "WebShoot"
			name="Spider Web Shoot"
			rank="B"
			signs="<font color=green>None</font><br>"
			uses=100
			maxcooltime = 300
			ChakraCost = 100
			Sprice=2
			Clan="Spider"
			Description="Fires off a spider web that can immobilze the target on hit."

		ArrowShoot
			icon_state="ArrowShoot"
			mouse_drag_pointer = "ArrowShoot"
			name="Spider Arrow Shoot"
			rank="A"
			signs="<font color=green>None</font><br>"
			uses=100
			maxcooltime = 170
			ChakraCost = 100
			Sprice=3
			reqs = list("Spider Web Shoot")
			Description="Fires off a deadly arrow that pierces through anything!"

		Summon_Spider
			icon_state="spiders"
			mouse_drag_pointer = "spiders"
			name="Summon Spider"
			rank="S"
			Sprice = 5
			signs="<font color=green>Ox,Horse,Horse,Dog,Ox,Horse</font><br>(macro(W,3,3,E,W,3))"
			//uses=100
			maxcooltime = 600
			ChakraCost = 500
			Clan="Spider"
			reqs = list("Spider Arrow Shoot")
			Description="Summon a huge spider to fight for your cause in combat!"

//Uzumaki


		Seal_of_Terror
			icon_state="CT"
			mouse_drag_pointer="CT"
			name="Sealing Technique: Seal of Terror"
			Clan="Uzumaki"
			rank="B"
			signs="<font color=green>Monkey,Rabbit,Rabbit,Monkey</font><br>(macro(4,1,1,4))"
			maxcooltime = 500
			ChakraCost = 150
			//uses=100
			Sprice=3
			Description="A powerful jutsu that creates a strong bind which restricts movement of a person and also damages them for a huge amount."

		Soul_Devastator_Seal
			icon_state="SD"
			mouse_drag_pointer = "SD"
			name="Soul Devastator Seal"
			rank="A"
			signs="<font color=green>Rabbit,Snake,Horse,Rabbit,Rat</font><br>(macro(1,2,3,1,Q))"
			maxcooltime = 300
			ChakraCost = 300
			uses=0
			Sprice=3
			Clan="Uzumaki"
			reqs = list("Sealing Technique: Seal of Terror")
			Description="A powerful immobilising seal capable of binding even the most powerful shinobi."

		LimbParalyzeSeal
			icon_state="LimbParalyzeSeal"
			mouse_drag_pointer = "LimbParalyzeSeal"
			name="Sealing Jutsu: Limb Paralyzis"
			rank="B"
			signs="<font color=green>Rabbit,Rabbit,Monkey,Monkey</font><br>(macro(1,1,4,4))"
			maxcooltime = 450
			ChakraCost = 200
			Sprice=4
			Clan="Uzumaki"
			reqs = list("Soul Devastator Seal")
			Description="Limb Paralyze Seal: This technique stuns your opponent for a certain amount of time"

		Reaper_Death_Seal
			icon_state="RDS"
			mouse_drag_pointer="RDS"
			name="Reaper Death Seal"
			Clan="Uzumaki"
			rank="S"
			reqs = list("Soul Devastator Seal")
			signs="<font color=green>Dragon,Rat,Rabbit,Dragon,Rabbit,Rabbit,Rat</font><br>(macro(5,Q,1,5,1,1,Q))"
			maxcooltime = 400
			ChakraCost = 1000
			uses=100
			Sprice=5
			Description="An advanced move which cuts the enemies life pool by a large amount. Deals a huge amount of damage to the user himself aswell."

//Bubble

		Bubble_Trouble
			icon_state="Bubble Trouble"
			mouse_drag_pointer = "Bubble Trouble"
			name="Bubble Trouble"
			rank="A"
			signs="<font color=green>Rabbit,Rabbit,Dragon,Rabbit,Dragon,Rabbit,Dragon,Dragon</font><br>(macro(1,1,5,1,5,1,5,5))"
			maxcooltime = 300
			ChakraCost = 300
			reqs=list("Bubble Barrage")
			Clan="Bubble"
			Description="Bubble Trouble: Create a Giant bubble streaming with all your power impaling your opponents defense no matter how hard it may be!"

		Bubble_Spreader
			icon_state="Bubble Spreader"
			mouse_drag_pointer = "Bubble Spreader"
			name="Bubble Spreader"
			rank="B"
			signs="<font color=green>Dog,Dog,Dragon,Dog</font><br>(macro(E,E,5,E))"
			maxcooltime = 220
			ChakraCost = 25
			Clan="Bubble"
			Description="Bubble Spreader: This technique creates bubble smashing upon every direction unable of being controlled, very powerful if you are facing multiple enemies."

		Bubble_Barrage
			icon_state="Bubble Barrage"
			mouse_drag_pointer = "Bubble Barrage"
			name="Bubble Barrage"
			rank="B"
			signs="<font color=green>Rabbit,Rabbit,Dragon,Rabbit</font><br>(macro(1,1,5,1))"
			maxcooltime = 240
			ChakraCost = 50
			reqs=list("Bubble Spreader")
			Clan="Bubble"
			Description="Bubble Barrage: This technique allows the use to stream an certain amount of bubbles dashing towards the enemy."

//Fire

		FireBall
			icon_state="fireball"
			mouse_drag_pointer = "fireball"
			name="Fire Release: Fire Ball"
			rank="D"
			signs="<font color=green>Dog,Dog,Rat</font><br>(macro(E,E,Q))"
			maxcooltime=60
			ChakraCost = 60
			Element="Fire"
			Description="This technique unleashes a small fireball from the caster's hands."

		AFireBall
			icon_state="Afireball"
			mouse_drag_pointer = "Afireball"
			name="Fire Release: Blazing Sun"
			rank="A"
			signs="<font color=green>Dog,Rat,Dog,Rabbit,Snake</font><br>(macro(E,Q,E,1,2))"
			maxcooltime=175
			ChakraCost = 170
			Sprice=2
			Element="Fire"
			reqs=list("Fire Release: Phoenix Immortal Fire Technique")
			Description="This technique is similar to fireball, but it is a significantly larger fireball that can devastate multiple opponents."

		Fire_Release_Ash_Pile_Burning
			icon_state="Ash Pile Burning"
			mouse_drag_pointer = "Ash Pile Burning"
			name="Fire Release: Ash Pile Burning"
			rank="B"
			signs="<font color=green>Dog,Rat,Dog,Rabbit,Dog</font><br>(macro(E,Q,E,1,E))"
			maxcooltime = 550
			ChakraCost = 150
			Sprice=2
			Element="Fire"
			reqs=list("Fire Release: Fire Ball")
			Description="Spewing ash from the caster's mouth, this technique allows one to burn multiple enemies at once by igniting the ash into a raging torrent."

		PheonixFire
			icon_state="fireballs"
			mouse_drag_pointer = "fireballs"
			name="Fire Release: Phoenix Immortal Fire Technique"
			rank="C"
			signs="<font color=green>Dog,Rat,Rat,Dog</font><br>(macro(E,Q,Q,E))"
			maxcooltime = 250
			ChakraCost = 45
			Sprice=2
			Element="Fire"
			reqs=list("Fire Release: Ash Pile Burning")
			Description="This technique is similar to fireball, but it unleashes multiple fireballs in succession."

		Fire_Dragon_Projectile
			icon_state="Fire Dragon Projectile"
			mouse_drag_pointer = "Fire Dragon Projectile"
			name="Fire Release: Fire Dragon Projectile"
			rank="C"
			signs="<font color=green>Dog,Rat,Rat,Dog,Dog,Rat,Dog,Rat</font><br>(macro(E,Q,Q,E,E,Q,E,Q))"
			maxcooltime = 350
			ChakraCost = 250
			Sprice=4
			Element="Fire"
			reqs=list("Fire Release: Phoenix Immortal Fire Technique")
			Description="Breath a raging blast of fire out of your mouth."
//Magma

		Magma_Crush
			icon_state="Magma Crush"
			mouse_drag_pointer = "Magma Crush"
			name="Magma Style: Magma Cage"
			rank="B"
			signs="<font color=green>Rabbit,Snake,Dog,Rat</font><br>(macro(1,2,E,Q))"
			maxcooltime = 600
			ChakraCost = 120
			Sprice = 4
			Element="Fire"
			reqs=list("Fire Release: Fire Dragon Projectile")
			Description="Magma Crush: This technique allows one to channel the forces of the heat in the air and create magma forming a large cage with floating magma"

		Magma_Needles
			icon_state="Magma Needles"
			mouse_drag_pointer = "Magma Needles"
			name="Magma Style: Magma Needles"
			rank="A"
			signs="<font color=green>Rabbit,Dog,Snake,Rabbit</font><br>(macro(1,E,2,1))"
			maxcooltime = 200
			ChakraCost = 150
			Sprice=4
			Element="Fire"
			reqs=list("Magma Style: Magma Cage")
			Description="Magma Needles: Used in combination with fire & earth, this technique forms deadly magma needles that impale your opponents."

//Earth

		Earth_Release_Earth_Cage
			icon_state="Doton Cage"
			mouse_drag_pointer = "Doton Cage"
			name="Earth Release: Earth Cage"
			rank="B"
			signs="<font color=green>Rabbit,Snake,Snake,Dog,Rat</font><br>(macro(1,2,2,E,Q))"
			maxcooltime = 500
			ChakraCost = 65
			Element="Earth"
			Description="This technique allows one to channel the forces of the earth into forming a large cage like structure around their opponent, encasing them whilst damaging them from lack of oxygen."

		Earth_Disruption
			icon_state="Earth Disruption"
			mouse_drag_pointer = "Earth Disruption"
			name="Earth Disruption"
			rank="D"
			signs="<font color=green>Rabbit,Rabbit,Rabbit</font><br>(macro(1,1,1))"
			maxcooltime = 200
			ChakraCost = 60
			uses=0
			Sprice=2
			Element = "Earth"
			reqs = list("Earth Release: Earth Cage")
			Description="Charge your fist with chakra and plummet it into the ground, knocking down nearby enemies"

		Earth_Style_Dark_Swamp
			icon_state="Earth Style Dark Swamp"
			mouse_drag_pointer = "Earth Style Dark Swamp"
			name="Earth Release: Dark Swamp"
			rank="C"
			signs="<font color=green>Rabbit,Rabbit</font><br>(macro(1,1))"
			maxcooltime = 150
			ChakraCost = 5
			uses=0
			Sprice=3
			Element = "Earth"
			reqs = list("Earth Disruption")
			Description="Turn the ground your opponents stand on into thick mud and make their movement impaired."

		Earth_Release_Mud_River
			icon_state="Mud River"
			mouse_drag_pointer = "Mud River"
			name="Earth Release: Mud River"
			rank="B"
			signs="<font color=green>Rabbit,Rabbit,Monkey</font><br>(macro(1,1,4))"
			maxcooltime = 550
			ChakraCost = 100
			Sprice=2
			Element="Earth"
			Description="This technique allows one to convert their chakra into the earth element and make the ground their opponent is standing on turn into mud, disabling the opponent temporarily"

		MudWall
			icon_state="MudWall"
			mouse_drag_pointer = "MudWall"
			name="Earth Release: Mud Wall"
			rank="A"
			signs="<font color=green>Rabbit,Rabbit,Rabbit,Rabbit</font><br>(macro(1,1,1,1))"
			maxcooltime = 350
			ChakraCost = 100
			uses=0
			Sprice=4
			Element = "Earth"
			reqs = list("Earth Release: Mud River")
			Description="Focuses large amount of chakra into creating a wall made out of mud to serve as a protection to it's user."

		EarthBoulder
			icon_state="EarthBoulder"
			mouse_drag_pointer = "EarthBoulder"
			name="Earth Release: Earth Boulder"
			rank="B"
			signs="<font color=green>Rabbit,Rabbit,Rabbit,Snake</font><br>(macro(1,1,1,2))"
			Element="Earth"
			maxcooltime = 190
			ChakraCost = 200
			Sprice=3
			reqs = list("Earth Release: Mud River")
			Description="Creates a massive boulder made from earth itself and throws it foward smashing anything in it's way."

		Dango
			icon_state="dango"
			mouse_drag_pointer = "dango"
			name="Doton Doryo Dango"
			rank="S"
			signs="<font color=green>Dog,Dog,Ox,Rabbit</font><br>(macro(E,E,W,1))"
			maxcooltime = 250
			ChakraCost = 140
			Element="Earth"
			reqs=list("Earth Release: Mud Wall")
			Sprice=1
			Description="Dango: Throws a Huge Rock in user's direction"

		Doryuusou
			icon_state="doryuusou"
			mouse_drag_pointer = "doryuusou"
			name="Doton Doryuusou no Jutsu"
			rank="A"
			reqs=list("Mud Dragon Projectile")
			signs="<font color=green>Dragon,Snake,Monkey</font><br>(macro(5,2,4))"
			maxcooltime = 280
			ChakraCost = 160
			Sprice=1
			Element="Earth"

			Description="Doryuusou: User creates spikes under the targets feet to hurt them"

		Mud_Dragon_Projectile
			icon_state="Mud Dragon Projectile"
			mouse_drag_pointer = "Mud Dragon Projectile"
			name="Mud Dragon Projectile"
			rank="A"
			Element="Earth"
			signs="<font color=green>Dog,Rat,Rat,Dog,Dog,Rat,Dog</font><br>(macro(E,Q,Q,E,E,Q,E))"
			maxcooltime = 300
			ChakraCost = 200
			reqs=list("Earth Release: Mud Wall")
			Sprice=3
			Description="Summon a powerful dragon from the earth and send it crashing into your enemies."


//Lightning

		Jinrai
			icon_state="Chidori Jinrai"
			mouse_drag_pointer = "Chidori Jinrai"
			name="Chidori Jinrai"
			rank="A"
			signs="<font color=green>Snake,Rabbit,Dog</font><br>(macro(2,1,E))"
		//	uses=100
			Element="Lightning"
			maxcooltime = 200
			ChakraCost = 25
			Sprice=2
			reqs = list("Chidori Needles")
			Description="Utilizing chidori's destructive power into a single point of energy, one can channel it down into a beam of devastating force, capable of tearing through rock."

		Kirin
			icon_state="Kirin"
			mouse_drag_pointer = "Kirin"
			name="Kirin"
			rank="S"
			signs="<font color=green>Ox,Rabbit,Snake,Dog,Dog,Rabbit</font><br>(macro(W,1,2,E,E,1))"
		//	uses=100
			Element="Lightning"
			maxcooltime = 400
			ChakraCost = 300
			Sprice=4
			reqs = list("Chidori Jinrai")
			Description="The ultimate lightning technique. Utilizing the thunder in the clouds, one can manipulate nature itself into their own use. Commanding a powerful lightning strike to be thrown towards their target, with devastating effects ."

		Chidori_Needles
			icon_state="Chidori Needles"
			mouse_drag_pointer = "Chidori Needles"
			name="Chidori Needles"
			rank="A"
			signs="<font color=green>Ox,Rabbit</font><br>(macro(W,1))"
		//	uses=100
			Element="Lightning"
			maxcooltime = 80
			ChakraCost = 75
			Sprice=2
			reqs = list("Chidori")
			Description="Converting lightning elemented chakra into sharp dense needles, allows one to create a weapon of significant power, one that can slice through even rock."

		Raikiri
			icon_state="Raikiri"
			mouse_drag_pointer = "Raikiri"
			name="Raikiri"
			rank="A"
			signs="<font color=green>Snake,Ox,Ox</font><br>(macro(2,W,W))"
			//uses=100
			Sprice=3
			Element="Lightning"
			maxcooltime = 450
			ChakraCost = 300
			reqs=list("Chidori")
			Description="Create a blade of lightning and drive it through your enemies.."

		Chidori
			icon_state="Chidori"
			mouse_drag_pointer = "Chidori"
			name="Chidori"
			rank="A"
			signs="<font color=green>Snake,Rabbit,Ox</font><br>(macro(2,1,W))"
			//uses=100
			Element="Lightning"
			maxcooltime = 300
			ChakraCost = 180
			Sprice=2
			Description="Channeling your chakra into a ball of lightning, allows one to create a very deadly close-range weapon."

		Chidori_Nagashi
			icon_state="Nagashi"
			mouse_drag_pointer = "Nagashi"
			name="Chidori Nagashi"
			rank="C"
			signs="<font color=green>Rabbit,Snake,Monkey,Rabbit</font><br>(macro(1,2,4,1))"
			maxcooltime = 300
			ChakraCost = 200
			uses=0
			Sprice=2
			reqs = list("Chidori Needles")
			Description="Chidori Nagashi: Focus chakra mixed with Lightning style to create a shield of lightning defending inflicting damage to those who are nearby, however this technique can not kill."

		Lightning_Balls
			icon_state="LightningBalls"
			mouse_drag_pointer="LightningBalls"
			name="Lightning Balls"
			Element="Lightning"
			rank="B"
			reqs = list("Chidori Jinrai")
			signs="<font color=green>Snake,Rabbit,Rabbit</font><br>(macro(2,1,1))"
			//uses=100
			maxcooltime = 150
			ChakraCost = 100
			Description="Lightning Balls: Create and fire balls of lightning."

//Water

		Water_Release_Exploding_Water_Colliding_Wave
			icon_state="Water Release Exploding Water Colliding Wave"
			mouse_drag_pointer = "Water Release Exploding Water Colliding Wave"
			name="Water Release: Exploding Water Colliding Wave"
			rank="B"
			signs="<font color=green>Rabbit,Dog,Snake</font><br>(macro(1,E,2))"
			maxcooltime = 200
			ChakraCost = 63
			Element="Water"
			Description="This technique unleashes a massive torrent of water from the user's mouth. It will wash away any foes it meets."


		MizuClone
			icon_state="Water Bunshin"
			mouse_drag_pointer = "Water Bunshin"
			name="Water Clone"
			rank="B"
			Element="Water"
			signs="<font color=green>Rat, Rat, Snake</font><br>(macro(Q,Q,2))"
			maxcooltime = 300
			ChakraCost = 30
			reqs=list("Water Prison")
			Sprice=2
			Description="Utilizing one's elemental chakra and shape manipulation to craft a replication of theirselves, in order to trap enemies using Water Prison techniques through such clones."

		WaterPrison
			icon_state="Water Prison"
			mouse_drag_pointer = "Water Prison"
			name="Water Prison"
			rank="B"
			Element="Water"
			signs="<font color=green>Ox, Snake, Rat, Snake</font><br>(macro(W,2,Q,2))"
			maxcooltime = 500
			ChakraCost = 75
			Sprice=1
			reqs=list("Water Release: Exploding Water Colliding Wave")
			Description="Utilizing one's elemental chakra and shape manipulation to craft a spherical water prison around a target within their grasp."

		Water_Dragon_Projectile
			icon_state="Water Dragon Projectile"
			mouse_drag_pointer = "Water Dragon Projectile"
			name="Water Dragon Projectile"
			rank="A"
			Element="Water"
			signs="<font color=green>Dog,Rat,Rat,Dog,Dog,Rat,Dog,Rat,Dragon,Dragon</font><br>(macro(E,Q,Q,E,E,Q,E,Q,5,5))"
			maxcooltime = 450
			ChakraCost = 300
			reqs=list("Water Shark Projectile")
			Sprice=4
			Description="Summon a powerful dragon from the water and send it crashing into your enemies."

		WaterShark
			icon_state="Water Shark"
			mouse_drag_pointer = "Water Shark"
			name="Water Shark Projectile"
			rank="A"
			Element="Water"
			signs="<font color=green>Ox, Snake, Rat, Rabbit, Dragon</font><br>(macro(W,2,Q,1,5))"
			maxcooltime = 350
			ChakraCost = 75
			reqs=list("Water Clone")
			Sprice=3
			Description="Uses one's elemental chakra and shape manipulation to craft a shark-like projectile of crashing water, and forcing it out one's chakra points towards their target."

		Teppoudama
			icon_state="tepo"
			mouse_drag_pointer = "tepo"
			name="Suiton Teppoudama"
			rank="B"
			signs="<font color=green>Rat,Dragon,Rat,Ox,Snake</font><br>(macro(Q,5,Q,W,2))"
			maxcooltime = 200
			ChakraCost = 200
			Sprice=1
			Element="Water"
			reqs = list("Water Prison")
			Description="Teppoudama: Shoots Water Ball from user's mouth"

		Suijinheki
			icon_state="suijin"
			mouse_drag_pointer = "suijin"
			name="Suiton Suijinheki no Jutsu"
			rank="B"
			signs="<font color=green>Ox,Dragon,Dragon,Rat,Rat</font><br>(macro(W,5,5,Q,Q))"
			maxcooltime = 200
			ChakraCost = 180
			Sprice=1
			Element="Water"
			reqs = list("Water Dragon Projectile")
			Description="Suijunheki: Creates a water wave infront of the user's to protect him"


//Wind

		Sickle_Weasel_Technique
			icon_state="Sickle Weasel Technique"
			mouse_drag_pointer = "Sickle Weasel Technique"
			name="Sickle Weasel Technique"
			rank="A"
			signs="<font color=green>Ox,Snake,Rabbit,Ox</font><br>(macro(W,2,1,W))"
		//	uses=100
			Element="Wind"
			maxcooltime = 60
			ChakraCost = 50
			Sprice=1
			Description="Convert chakra into air, and launch it in a rapid spinning form towards your target at a speed that can slice through trees."

		Wind_Dragon_Projectile
			icon_state="Wind Dragon Projectile"
			mouse_drag_pointer = "Wind Dragon Projectile"
			name="Wind Dragon Projectile"
			rank="A"
			Element="Wind"
			signs="<font color=green>Dog,Rat,Dog,Rat,Dog,Rat,Dog</font><br>(macro(E,Q,E,Q,E,Q,E))"
			maxcooltime = 300
			ChakraCost = 300
			Sprice=3
			reqs=list("Wind Tornados")
			Description="Summon a powerful dragon from the wind and send it crashing into your enemies."

		Wind_Shield
			icon_state="Tornado Shield"
			mouse_drag_pointer = "Tornado Shield"
			name="Wind Shield"
			rank="C"
			signs="<font color=green>Rabbit,Snake,Monkey</font><br>(macro(1,2,4))"
			maxcooltime = 250
			ChakraCost = 20
			uses=0
			Sprice=2
			reqs = list("Sickle Weasel Technique")
			Description="Rapidly spin the air around you using your chakra, and blow away close foes with sharp winds."

		Blade_of_Wind
			icon_state="Blade of Wind"
			mouse_drag_pointer = "Blade of Wind"
			name="Blade of Wind"
			rank="C"
			signs="<font color=green>Rabbit,Snake,Rabbit</font><br>(macro(1,2,1))"
			maxcooltime = 150
			ChakraCost = 50
			uses=0
			Sprice=1
			reqs = list("Sickle Weasel Technique")
			Description="This technique is a pinpoint slashing strike, where the user emits chakra from their fingertips and materializes it into an invisible sword that assaults the enemy in a gust of wind."

		Wind_Tornados
			icon_state="WindTornados"
			mouse_drag_pointer = "WindTornados"
			name="Wind Tornados"
			rank="A"
			signs="<font color=green>Rabbit,Snake,Monkey,Rabbit,Snake</font><br>(macro(1,2,4,1,2))"
			maxcooltime = 350
			ChakraCost = 350
			uses=0
			Sprice=4
			reqs = list("Wind Shield")
			Description="Rapidly spin the air around you using your chakra, creating tornados themselves to tear appart opponents!"

		Rasenshuriken
			icon_state="Rasenshuriken"
			mouse_drag_pointer = "Rasenshuriken"
			name="Rasenshuriken"
			rank="A"
			signs="<font color=green>Rabbit,Rabbit,Ox,Ox,Ox,Ox</font><br>(macro(1,1,W,W,W,W))"
		//	uses=100
			Element="Wind"
			maxcooltime = 300
			ChakraCost = 240
			Sprice=3
			reqs=list("Rasengan")
			Description="Channeling your chakra into a ball of spinning air, allows one to create a very deadly close-range weapon. More advanced than a normal rasengan, and is much more explosive but takes more chakra."

		Zankuuha
			icon_state="zanku"
			mouse_drag_pointer = "zanku"
			name="Zankuuha"
			rank="D"
			signs="<font color=green>Monkey,Monkey,Rat</font><br>(macro(4,4,Q))"
			maxcooltime = 380
			ChakraCost = 200
			Sprice=1
			Element="Wind"
			Description="Zankuuha: Shoots wind from user's hand"

		Daitoppa
			icon_state="daitoppa"
			mouse_drag_pointer = "daitoppa"
			name="Fuuton Daitoppa"
			rank="B"
			signs="<font color=green>Dragon,Rat,Rat,Rabbit</font><br>(macro(5,Q,Q,1))"
			maxcooltime = 280
			ChakraCost = 70
			Sprice=1
			reqs=list("Wind Cutter")
			Element="Wind"
			Description="Daitoppa: Wind Element jutsu where user releases a huge wind that can push enemys while damaging them"

		Wind_Cutter
			icon_state="WC"
			mouse_drag_pointer="WC"
			name="Wind Cutter"
			Element="Wind"
			rank="B"
			signs="<font color=green>Snake,Rabbit,Rabbit,Snake</font><br>(macro(2,1,1,2))"
			uses=100
			maxcooltime = 340
			ChakraCost = 100
			reqs = list("Sickle Weasel Technique")
			Description="Wind Cutter: Slice through every thing in your path with the power of wind."



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
			Description="Summoning up monsterous strength, this strength ability allows one to put all that strength into one punch!"

		Rising_Twin_Dragon //NI
			icon_state="RTD"
			mouse_drag_pointer = "RTD"
			name="Rising Twin Dragons"
			rank="B"
			signs="<font color=green>Rat,Rat,Rat</font><br>(macro(Q,Q,Q))"
		//	uses=0;notneeded=1
			maxcooltime=150
			Sprice = 0
			ChakraCost = 200
			Description="Rising Twin Dragon: Expel all weaponry placed upon you outwards in a blast along with dragons, the weaponary can fly in any direction it will engage enemies."
