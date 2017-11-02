mob/var/list/HotSlotSave=list("HotSlot1"=null,"HotSlot2"=null,"HotSlot3"=null,"HotSlot4"=null,"HotSlot5"=null)
mob/var/XView
mob/var/YView
mob
	var/tmp/BOW
obj
	HotSlotNumber
		icon='Letters.dmi'
		layer=9999
proc/GetScreenResolution(mob/M) // Yay dynamic HUDS?!
	var/POS = "[winget(M, "label","pos")]"
	var/COMA = findtext(POS,",",1,0)
	var/X = text2num(copytext(POS,1,COMA))
	var/Y = text2num(copytext(POS,COMA+1,0))
	M.client.view="[round(X/32)]x[round(Y/32)]"
	M.XView=round(X/32)
	M.YView=round(Y/32)

obj/Titlescreen/Logo
	name="Logo"
	layer=999999
	icon = 'NarutoEvoHUD.png'
	//screen_loc = "25,5"
	New(var/mob/M)
		spawn(2)
			screen_loc = "CENTER-5,CENTER+2"
			M.client.screen+=src
			src.loc=locate(0,0,0)
			..()
atom
	proc
		HotSlotNumber(text as text)
			if(length(text)>=21)
				text=copytext(text,1,21)
				text+="..."
			var/list/letters=list()
			var/CX
			var/OOE=(lentext(text))
			if(OOE%2==0) CX+=11-((lentext(text))/2*5)
			else CX+=12-((lentext(text))/2*5)
			for(var/a=1, a<lentext(text)+1, a++) letters+=copytext(text,a,a+1)
			for(var/X in letters)
				var/obj/HotSlotNumber/O=new/obj/HotSlotNumber
				O.icon_state=X
				O.pixel_x=CX
				O.pixel_y=-10
				O.pixel_x-=5
				O.icon=O.icon-src.ncolor
				CX+=6
				src.overlays+=O
obj
	HotSlots
		Hengable=0
		HotSlot1
			name="1"
			layer=9999
			icon = 'HotSlot.dmi'
			//screen_loc = "25,5"
			New(var/mob/M)
				if(!ismob(M)) return
				screen_loc = "[round((M.XView/2)-2)],3"
				M.client.screen+=src
				src.loc=locate(0,0,0)
				HotSlotNumber("F1")
				..()
		HotSlot2
			name="2"
			layer=9999
			icon = 'HotSlot.dmi'
			//screen_loc = "25,5"
			New(var/mob/M)
				if(!ismob(M)) return
				M.client.screen+=src
				screen_loc = "[round(M.XView/2)],3"
				HotSlotNumber("F2")
				src.loc=locate(0,0,0)
				..()
		HotSlot3
			name="3"
			layer=9999
			icon = 'HotSlot.dmi'
			//screen_loc = "25,5"
			New(var/mob/M)
				if(!ismob(M)) return
				M.client.screen+=src
				screen_loc = "[round((M.XView/2)+2)],3"
				HotSlotNumber("F3")
				src.loc=locate(0,0,0)
				..()
		HotSlot4
			name="4"
			layer=9999
			icon = 'HotSlot.dmi'
			//screen_loc = "25,5"
			New(var/mob/M)
				if(!ismob(M)) return
				M.client.screen+=src
				screen_loc = "[round((M.XView/2)+4)],3"
				HotSlotNumber("F4")
				src.loc=locate(0,0,0)
				..()
		HotSlot5
			name="5"
			layer=9999
			icon = 'HotSlot.dmi'
			//screen_loc = "25,5"
			New(var/mob/M)
				if(!ismob(M)) return
				M.client.screen+=src
				screen_loc = "[round((M.XView/2)+6)],3"
				HotSlotNumber("F5")
				src.loc=locate(0,0,0)
				..()



mob
	var
		hotslot
		hotslot1
		hotslot2
		hotslot3
		hotslot4
		hotslot5
	proc
		UpdateSlots()
			for(var/obj/HotSlots/h in src.client.screen)
				if(istype(h,/obj/HotSlots/HotSlot1))
					var/image/I=image('Misc Effects.dmi',HotSlotSave["HotSlot1"])
					I.pixel_x=12
					h.overlays=null
					h.overlays+=I
					h.HotSlotNumber("F1")
				if(istype(h,/obj/HotSlots/HotSlot2))
					var/image/I=image('Misc Effects.dmi',HotSlotSave["HotSlot2"])
					I.pixel_x=12
					h.overlays=null
					h.overlays+=I
					h.HotSlotNumber("F2")
				if(istype(h,/obj/HotSlots/HotSlot3))
					var/image/I=image('Misc Effects.dmi',HotSlotSave["HotSlot3"])
					I.pixel_x=12
					h.overlays=null
					h.overlays+=I
					h.HotSlotNumber("F3")
				if(istype(h,/obj/HotSlots/HotSlot4))
					var/image/I=image('Misc Effects.dmi',HotSlotSave["HotSlot4"])
					I.pixel_x=12
					h.overlays=null
					h.overlays+=I
					h.HotSlotNumber("F4")
				if(istype(h,/obj/HotSlots/HotSlot5))
					var/image/I=image('Misc Effects.dmi',HotSlotSave["HotSlot5"])
					I.pixel_x=12
					h.overlays=null
					h.overlays+=I
					h.HotSlotNumber("F5")
			/*for(var/obj/Jutsus/J in world)
				if(J.name==hotslot1)
					for(var/obj/HotSlots/HotSlot1/h in src.client.screen)
						h.overlays=0
						h.overlays+=J
						h.HotSlotNumber("F1")
				if(J.name==hotslot2)
					for(var/obj/HotSlots/HotSlot2/h in src.client.screen)
						h.overlays=0
						h.overlays+=J
						h.HotSlotNumber("F2")
				if(J.name==hotslot3)
					for(var/obj/HotSlots/HotSlot3/h in src.client.screen)
						h.overlays=0
						h.overlays+=J
						h.HotSlotNumber("F3")
				if(J.name==hotslot4)
					for(var/obj/HotSlots/HotSlot4/h in src.client.screen)
						h.overlays=0
						h.overlays+=J
						h.HotSlotNumber("F4")
				if(J.name==hotslot5)
					for(var/obj/HotSlots/HotSlot5/h in src.client.screen)
						h.overlays=0
						h.overlays+=J
						h.HotSlotNumber("F5")*/
		doslot(txt)
			if(txt=="Almighty Push")usr.AlmightyPush()
			if(txt=="Temple of Nirvana")usr.Temple_Of_Nirvana()
			if(txt=="Bone Sensation")usr.Bone_Sensation()
			if(txt=="Bone Pulse")usr.Bone_Pulse()
			if(txt=="Bone Tip")usr.Bone_Tip()
			if(txt=="Shadow Choke")usr.Shadow_Choke()
			if(txt=="Shadow Stab")usr.Shadow_Stab()
			if(txt=="Shadow Bind")usr.Shadow_Extension()
			if(txt=="Water Clone")usr.MizuClone_Jutsu()
			if(txt=="Water Prison")usr.WaterPrison()
			if(txt=="Rasenshuriken")usr.Rasenshuriken()
			if(txt=="Water Shark Projectile")usr.WaterShark()
			if(txt=="Tsukiyomi")usr.Tsukiyomi()
			if(txt=="Wind Sheild")usr.Wind_Sheild()
			if(txt=="Earth Release: Mud River")usr.Earth_Release_Mud_River()
			if(txt=="Earth Disruption")usr.Earth_Disruption()
			if(txt=="Mystical Palms")usr.Mystical_Palms()
			if(txt=="Amaterasu")usr.Amaterasu()
			if(txt=="Demonic Illusion: Tree Binding Death")usr.TreeBinding()
			if(txt=="Susanoo")usr.Susanoo()
			if(txt=="Chidori Jinrai")usr.Chidori_Jinrai()
			if(txt=="Kirin")usr.Kirin()
			if(txt=="Chidori Needles")usr.Chidori_Needles()
			if(txt=="Rasengan")usr.Rasengan()
			if(txt=="Chidori")usr.Chidori()
			if(txt=="Sickle Weasel Technique")usr.Sickle_Weasel_Technique()
			if(txt=="Morning Peacock")usr.Morning_Peacock()
			if(txt=="Leaf Whirlwind")usr.Leaf_Whirlwind()
			if(txt=="Meteor Punch")usr.Meteor_Punch()
			if(txt=="Clone Jutsu")usr.Clone_Jutsu()
			if(txt=="Chakra Release")usr.Chakra_Release()
			if(txt=="Sharingan")usr.Sharingan()
			if(txt=="Advanced Body Replacement Jutsu")usr.Advanced_Body_Replacement_Technique()
			if(txt=="Chakra Control")usr.Chakra_Control()
			if(txt=="Body Replacement Jutsu")usr.Body_Replacement_Technique()
			if(txt=="Transformation Jutsu")usr.Transformation_Jutsu()
			if(txt=="Clone Destroy")usr.Clone_Jutsu_Destroy()
			if(txt=="Fire Release: Fire Ball")usr.Fire_Ball()
			if(txt=="Fire Release: Blazing Sun")usr.AFire_Ball()
			if(txt=="Fire Release: Phoenix Immortal Fire Technique")usr.Phoenix_Immortal_Fire_Technique()
			if(txt=="Fire Release: Fire Dragon Projectile")usr.Fire_Dragon_Projectile()
			if(txt=="Gravity Divergence: Induction")usr.Induction()
			if(txt=="Gravity Divergence: Repulsion")usr.Repulsion()
			if(txt=="Body Flicker Technique")usr.Shunshin()
			if(txt=="Byakugan")usr.Byakugan()
			if(txt=="Eight Trigrams: 64 Palms")usr.Eight_Trigrams_64_Palms()
			if(txt=="Earth Release: Earth Cage")usr.Earth_Release_Earth_Cage()
			if(txt=="Multiple Shadow Clone Jutsu")usr.MultipleShadowClone_Jutsu()
			if(txt=="Eight Trigrams Palm: Heavenly Spin")usr.Kaiten()
			if(txt=="Sensatsu Suishou")usr.Sensatsu_Suisho()
			if(txt=="Water Release: Exploding Water Colliding Wave")usr.Water_Release_Exploding_Water_Colliding_Wave()
			if(txt=="Fire Release: Ash Pile Burning")usr.Fire_Release_Ash_Pile_Burning()
			if(txt=="Demonic Ice Mirrors")usr.Demonic_Ice_Mirrors()
			if(txt=="Heal")usr.Heal()
			if(txt=="Chakra Control")usr.Chakra_Control()
			if(txt=="Opening Gate")usr.Gate_1()
			if(txt=="Energy Gate")usr.Gate_2()
			if(txt=="Life Gate")usr.Gate_3()
			if(txt=="Pain Gate")usr.Gate_4()
			if(txt=="Limiter Gate")usr.Gate_5()
			if(txt=="Young Bracken Dance")usr.Young_Bracken_Dance()
			if(txt=="Eight Trigrams: Empty Palm")usr.Eight_Trigrams_Empty_Palm()
			if(txt=="First Puppet Summoning")usr.First_Puppet_Summoning()
			if(txt=="Second Puppet Summoning")usr.Second_Puppet_Summoning()
			if(txt=="Puppet Dash")usr.Puppet_Dash()
			if(txt=="Puppet Shoot")usr.Puppet_Shoot()
			if(txt=="Puppet Grab")usr.Puppet_Grab()
			if(txt=="Puppet Transform")usr.Puppet_Transform()
			if(txt=="C2")usr.C2()
			if(txt=="C3")usr.C3()
			if(txt=="C1: Tracking Birds")usr.ClayBirds()
			if(txt=="C1: Spider Swarm")usr.ClaySpiders()
			if(findtext(txt,"Sharingan"))usr.Sharingan()
			if(txt=="Shukakku Spear")usr.Shukakku_Spear()
			if(txt=="Desert Coffin")usr.Desert_Coffin()
			if(txt=="Sand Shuriken")usr.Sand_Shuriken()
			if(txt=="Insect Clone")usr.InsectClone()
			if(txt=="Destruction Bug Swarm")usr.Destruction_Bug_Swarm()
			if(txt=="Stealth Bug")usr.Stealth_Bug()
			if(txt=="Crow Clone")usr.Crow_Clone()
			if(txt=="Paper Bind")usr.Paper_Bind()
			if(txt=="Paper Shuriken")usr.Paper_Shuriken()
			if(txt=="Paper Replacement Technique")usr.Paper_Replacement_Technique()
			if(txt=="Sand Funeral")usr.Sand_Funeral()
			if(txt=="Sand Sheild")usr.Sand_Sheild()
			if(txt=="Sharingan Copy")usr.Sharingan_Copy()
			if(txt=="Chakra Leech")usr.Chakra_Leech()
			if(txt=="Camellia Dance")usr.Camellia_Dance()
			if(txt=="Sorcery: Death Ruling Possesion Blood")usr.Death_Ruling_Possesion_Blood()
			if(txt=="Sacrifice to Jashin")usr.Immortality()
			if(txt=="Destruction Bug Neurotoxin")usr.Bug_Neurotoxin()
			if(txt=="Destruction Bug Hunter Scarabs")usr.Hunter_Scarabs()
			if(txt=="Insect Coccoon")usr.Insect_Coccoon()
			if(txt=="Earth Release: Dark Swamp")usr.Earth_Style_Dark_Swamp()
			if(txt=="Eight Trigrams Mountain Crusher")usr.Eight_Trigrams_Mountain_Crusher()
			if(txt=="Last Resort: Eight Gates Assault")usr.Eight_Gates_Assault()
			if(txt=="Bone Drill")usr.Bone_Drill()
			if(txt=="Bringer of Darkness Technique")usr.Bringer_of_Darkness_Technique()
			if(txt=="Blade of Wind")usr.Blade_of_Wind()
			if(txt=="Raikiri")usr.Raikiri()
			if(txt=="Leaf Hidden Finger Jutsu: One Thousand Years of Death")usr.One_Thousand_Years_of_Death()
			if(txt=="One's Own Life Reincarnation")usr.Ones_Own_Life_Reincarnation()
			if(txt=="Achiever of Nirvana Fist")usr.Achiever_of_Nirvana_Fist()
			if(txt=="Poison Mist")usr.Poison_Mist()
			if(txt=="Cherry Blossom Impact")usr.Cherry_Blossom_Impact()
			if(txt=="Blade Manipulation Jutsu")usr.Blade_Manipulation_Jutsu()
			if(txt=="Water Dragon Projectile")usr.Water_Dragon_Projectile()
			if(txt=="Fire Dragon Projectile")usr.Fire_Dragon_Projectile()
			if(txt=="Earth Dragon Projectile")usr.Mud_Dragon_Projectile()
			if(txt=="Curse Seal of Heaven")usr.CS()
		HotSlots()
			if(usr.hotslot=="1")usr.doslot(usr.hotslot1)
			if(usr.hotslot=="2")usr.doslot(usr.hotslot2)
			if(usr.hotslot=="3")usr.doslot(usr.hotslot3)
			if(usr.hotslot=="4")usr.doslot(usr.hotslot4)
			if(usr.hotslot=="5")usr.doslot(usr.hotslot5)
mob
	verb
		HotSlot1()
			set hidden=1
			usr.hotslot="1"
			usr.HotSlots()
		HotSlot2()
			set hidden=1
			usr.hotslot="2"
			usr.HotSlots()
		HotSlot3()
			set hidden=1
			usr.hotslot="3"
			usr.HotSlots()
		HotSlot4()
			set hidden=1
			usr.hotslot="4"
			usr.HotSlots()
		HotSlot5()
			set hidden=1
			usr.hotslot="5"
			usr.HotSlots()
