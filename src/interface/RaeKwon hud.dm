mob/var/list/HotSlotSave=list("HotSlot1"=null,"HotSlot2"=null,"HotSlot3"=null,"HotSlot4"=null,"HotSlot5"=null,"HotSlot6"=null,"HotSlot7"=null,"HotSlot8"=null,"HotSlot9"=null,"HotSlot10"=null,"HotSlot11"=null,"HotSlot12"=null,"HotSlot13"=null,"HotSlot14"=null,"HotSlot15"=null,"HotSlot16"=null,"HotSlot17"=null,"HotSlot18"=null)
mob
	var/tmp/BOW

obj/Titlescreen/Logo
	name="Logo"
	layer=9999
//	icon = 'Lol.dmi'
	//screen_loc = "25,5"
	New(var/mob/M)
		spawn(2)
			screen_loc = "CENTER-5,CENTER+2"
			M.client.screen+=src
			..()

obj
	HotSlots
		var/hotslot_ref
		Hengable=0
		HotSlot1
			name="1"
			layer=9999
			icon = 'HotSlot.dmi'
			//screen_loc = "25,5"
			New(var/mob/M)
				if(!ismob(M)) return
				hotslot_ref = M.client.vars["hotkey_hotslot1"]
				screen_loc = "[round((M.client.map_resolution_x/2)-4)],3.5"
				M.client.screen+=src
				src.loc=locate(0,0,0)
				src.SetName("Z")
				..()
		HotSlot2
			name="2"
			layer=9999
			icon = 'HotSlot.dmi'
			//screen_loc = "25,5"
			New(var/mob/M)
				if(!ismob(M)) return
				M.client.screen+=src
				screen_loc = "[round(M.client.map_resolution_x/2)-2],3.5"
				src.SetName("X")
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
				screen_loc = "[round((M.client.map_resolution_x/2))],3.5"
				src.SetName("C")
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
				screen_loc = "[round((M.client.map_resolution_x/2)+2)],3.5"
				src.SetName("V")
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
				screen_loc = "[round((M.client.map_resolution_x/2)+4)],3.5"
				src.SetName("B")
				src.loc=locate(0,0,0)
				..()
		HotSlot6
			name="6"
			layer=9999
			icon = 'HotSlot.dmi'
			//screen_loc = "25,5"
			New(var/mob/M)
				if(!ismob(M)) return
				M.client.screen+=src
				screen_loc = "[round((M.client.map_resolution_x/2)+6)],3.5"
				src.SetName("N")
				src.loc=locate(0,0,0)
				..()

		HotSlot7
			name="1"
			layer=9999
			icon = 'HotSlot.dmi'
			//screen_loc = "25,5"
			New(var/mob/M)
				if(!ismob(M)) return
				screen_loc = "[round((M.client.map_resolution_x/2)-4)],4.5"
				M.client.screen+=src
				src.loc=locate(0,0,0)
				src.SetName("F7")
				..()
		HotSlot8
			name="2"
			layer=9999
			icon = 'HotSlot.dmi'
			//screen_loc = "25,5"
			New(var/mob/M)
				if(!ismob(M)) return
				M.client.screen+=src
				screen_loc = "[round(M.client.map_resolution_x/2)-2],4.5"
				src.SetName("F8")
				src.loc=locate(0,0,0)
				..()
		HotSlot9
			name="3"
			layer=9999
			icon = 'HotSlot.dmi'
			//screen_loc = "25,5"
			New(var/mob/M)
				if(!ismob(M)) return
				M.client.screen+=src
				screen_loc = "[round((M.client.map_resolution_x/2))],4.5"
				src.SetName("F9")
				src.loc=locate(0,0,0)
				..()
		HotSlot10
			name="4"
			layer=9999
			icon = 'HotSlot.dmi'
			//screen_loc = "25,5"
			New(var/mob/M)
				if(!ismob(M)) return
				M.client.screen+=src
				screen_loc = "[round((M.client.map_resolution_x/2)+2)],4.5"
				src.SetName("F10")
				src.loc=locate(0,0,0)
				..()
		HotSlot11
			name="5"
			layer=9999
			icon = 'HotSlot.dmi'
			//screen_loc = "25,5"
			New(var/mob/M)
				if(!ismob(M)) return
				M.client.screen+=src
				screen_loc = "[round((M.client.map_resolution_x/2)+4)],4.5"
				src.SetName("F11")
				src.loc=locate(0,0,0)
				..()
		HotSlot12
			name="6"
			layer=9999
			icon = 'HotSlot.dmi'
			//screen_loc = "25,5"
			New(var/mob/M)
				if(!ismob(M)) return
				M.client.screen+=src
				screen_loc = "[round((M.client.map_resolution_x/2)+6)],4.5"
				src.SetName("F12")
				src.loc=locate(0,0,0)
				..()

		HotSlot13
			name="1"
			layer=9999
			icon = 'HotSlot.dmi'
			//screen_loc = "25,5"
			New(var/mob/M)
				if(!ismob(M)) return
				screen_loc = "[round((M.client.map_resolution_x/2)-4)],5.5"
				M.client.screen+=src
				src.loc=locate(0,0,0)
				src.SetName("F1")
				..()
		HotSlot14
			name="2"
			layer=9999
			icon = 'HotSlot.dmi'
			//screen_loc = "25,5"
			New(var/mob/M)
				if(!ismob(M)) return
				M.client.screen+=src
				screen_loc = "[round(M.client.map_resolution_x/2)-2],5.5"
				src.SetName("F2")
				src.loc=locate(0,0,0)
				..()
		HotSlot15
			name="3"
			layer=9999
			icon = 'HotSlot.dmi'
			//screen_loc = "25,5"
			New(var/mob/M)
				if(!ismob(M)) return
				M.client.screen+=src
				screen_loc = "[round((M.client.map_resolution_x/2))],5.5"
				src.SetName("F3")
				src.loc=locate(0,0,0)
				..()
		HotSlot16
			name="4"
			layer=9999
			icon = 'HotSlot.dmi'
			//screen_loc = "25,5"
			New(var/mob/M)
				if(!ismob(M)) return
				M.client.screen+=src
				screen_loc = "[round((M.client.map_resolution_x/2)+2)],5.5"
				src.SetName("F4")
				src.loc=locate(0,0,0)
				..()
		HotSlot17
			name="5"
			layer=9999
			icon = 'HotSlot.dmi'
			//screen_loc = "25,5"
			New(var/mob/M)
				if(!ismob(M)) return
				M.client.screen+=src
				screen_loc = "[round((M.client.map_resolution_x/2)+4)],5.5"
				src.SetName("F5")
				src.loc=locate(0,0,0)
				..()
		HotSlot18
			name="6"
			layer=9999
			icon = 'HotSlot.dmi'
			//screen_loc = "25,5"
			New(var/mob/M)
				if(!ismob(M)) return
				M.client.screen+=src
				screen_loc = "[round((M.client.map_resolution_x/2)+6)],5.5"
				src.SetName("F6")
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
		hotslot6
		hotslot7
		hotslot8
		hotslot9
		hotslot10
		hotslot11
		hotslot12
		hotslot13
		hotslot14
		hotslot15
		hotslot16
		hotslot17
		hotslot18

	proc
		UpdateSlots()
			for(var/obj/HotSlots/h in src.client.screen)
				if(istype(h,/obj/HotSlots/HotSlot1))
					var/image/I=image('Misc Effects.dmi',HotSlotSave["HotSlot1"])
					I.pixel_x = 12
					I.pixel_y = -1

					h.overlays=null
					h.overlays+=I
					h.SetName("[src.client.hotkey_hotslot1]")

				if(istype(h,/obj/HotSlots/HotSlot2))
					var/image/I=image('Misc Effects.dmi',HotSlotSave["HotSlot2"])
					I.pixel_x = 12
					I.pixel_y = -1

					h.overlays=null
					h.overlays+=I
					h.SetName("[src.client.hotkey_hotslot2]")

				if(istype(h,/obj/HotSlots/HotSlot3))
					var/image/I=image('Misc Effects.dmi',HotSlotSave["HotSlot3"])
					I.pixel_x = 12
					I.pixel_y = -1

					h.overlays=null
					h.overlays+=I
					h.SetName("[src.client.hotkey_hotslot3]")

				if(istype(h,/obj/HotSlots/HotSlot4))
					var/image/I=image('Misc Effects.dmi',HotSlotSave["HotSlot4"])
					I.pixel_x = 12
					I.pixel_y = -1

					h.overlays=null
					h.overlays+=I
					h.SetName("[src.client.hotkey_hotslot4]")

				if(istype(h,/obj/HotSlots/HotSlot5))
					var/image/I=image('Misc Effects.dmi',HotSlotSave["HotSlot5"])
					I.pixel_x = 12
					I.pixel_y = -1

					h.overlays=null
					h.overlays+=I
					h.SetName("[src.client.hotkey_hotslot5]")

				if(istype(h,/obj/HotSlots/HotSlot6))
					var/image/I=image('Misc Effects.dmi',HotSlotSave["HotSlot6"])
					I.pixel_x = 12
					I.pixel_y = -1

					h.overlays=null
					h.overlays+=I
					h.SetName("[src.client.hotkey_hotslot6]")

				if(istype(h,/obj/HotSlots/HotSlot7))
					var/image/I=image('Misc Effects.dmi',HotSlotSave["HotSlot7"])
					I.pixel_x = 12
					I.pixel_y = -1

					h.overlays=null
					h.overlays+=I
					h.SetName("[src.client.hotkey_hotslot7]")

				if(istype(h,/obj/HotSlots/HotSlot8))
					var/image/I=image('Misc Effects.dmi',HotSlotSave["HotSlot8"])
					I.pixel_x = 12
					I.pixel_y = -1

					h.overlays=null
					h.overlays+=I
					h.SetName("[src.client.hotkey_hotslot8]")

				if(istype(h,/obj/HotSlots/HotSlot9))
					var/image/I=image('Misc Effects.dmi',HotSlotSave["HotSlot9"])
					I.pixel_x = 12
					I.pixel_y = -1

					h.overlays=null
					h.overlays+=I
					h.SetName("[src.client.hotkey_hotslot9]")

				if(istype(h,/obj/HotSlots/HotSlot10))
					var/image/I=image('Misc Effects.dmi',HotSlotSave["HotSlot10"])
					I.pixel_x = 12
					I.pixel_y = -1

					h.overlays=null
					h.overlays+=I
					h.SetName("[src.client.hotkey_hotslot10]")

				if(istype(h,/obj/HotSlots/HotSlot11))
					var/image/I=image('Misc Effects.dmi',HotSlotSave["HotSlot11"])
					I.pixel_x = 12
					I.pixel_y = -1

					h.overlays=null
					h.overlays+=I
					h.SetName("[src.client.hotkey_hotslot11]")

				if(istype(h,/obj/HotSlots/HotSlot12))
					var/image/I=image('Misc Effects.dmi',HotSlotSave["HotSlot12"])
					I.pixel_x = 12
					I.pixel_y = -1

					h.overlays=null
					h.overlays+=I
					h.SetName("[src.client.hotkey_hotslot12]")

				if(istype(h,/obj/HotSlots/HotSlot13))
					var/image/I=image('Misc Effects.dmi',HotSlotSave["HotSlot13"])
					I.pixel_x = 12
					I.pixel_y = -1

					h.overlays=null
					h.overlays+=I
					h.SetName("[src.client.hotkey_hotslot13]")

				if(istype(h,/obj/HotSlots/HotSlot14))
					var/image/I=image('Misc Effects.dmi',HotSlotSave["HotSlot14"])
					I.pixel_x = 12
					I.pixel_y = -1

					h.overlays=null
					h.overlays+=I
					h.SetName("[src.client.hotkey_hotslot14]")

				if(istype(h,/obj/HotSlots/HotSlot15))
					var/image/I=image('Misc Effects.dmi',HotSlotSave["HotSlot15"])
					I.pixel_x = 12
					I.pixel_y = -1

					h.overlays=null
					h.overlays+=I
					h.SetName("[src.client.hotkey_hotslot15]")

				if(istype(h,/obj/HotSlots/HotSlot16))
					var/image/I=image('Misc Effects.dmi',HotSlotSave["HotSlot16"])
					I.pixel_x = 12
					I.pixel_y = -1

					h.overlays=null
					h.overlays+=I
					h.SetName("[src.client.hotkey_hotslot16]")

				if(istype(h,/obj/HotSlots/HotSlot17))
					var/image/I=image('Misc Effects.dmi',HotSlotSave["HotSlot17"])
					I.pixel_x = 12
					I.pixel_y = -1

					h.overlays=null
					h.overlays+=I
					h.SetName("[src.client.hotkey_hotslot17]")

				if(istype(h,/obj/HotSlots/HotSlot18))
					var/image/I=image('Misc Effects.dmi',HotSlotSave["HotSlot18"])
					I.pixel_x = 12
					I.pixel_y = -1

					h.overlays=null
					h.overlays+=I
					h.SetName("[src.client.hotkey_hotslot18]")

			/*for(var/obj/Jutsus/J in world)
				if(J.name==hotslot1)
					for(var/obj/HotSlots/HotSlot1/h in src.client.screen)
						h.overlays=0
						h.overlays+=J
						h.SetName("F1")
				if(J.name==hotslot2)
					for(var/obj/HotSlots/HotSlot2/h in src.client.screen)
						h.overlays=0
						h.overlays+=J
						h.SetName("F2")
				if(J.name==hotslot3)
					for(var/obj/HotSlots/HotSlot3/h in src.client.screen)
						h.overlays=0
						h.overlays+=J
						h.SetName("F3")
				if(J.name==hotslot4)
					for(var/obj/HotSlots/HotSlot4/h in src.client.screen)
						h.overlays=0
						h.overlays+=J
						h.SetName("F4")
				if(J.name==hotslot5)
					for(var/obj/HotSlots/HotSlot5/h in src.client.screen)
						h.overlays=0
						h.overlays+=J
						h.SetName("F5")*/
		doslot(txt)//CANNOT MACRO***
			if(usr.NaraTarget)
				switch(txt)
					if("Shadow Choke")usr.Shadow_Choke()
					if("Shadow Stab")usr.Shadow_Stab()
					if("Shadow Explosion")usr.Shadow_Explosion()

			else
				if(findtext(txt,"Sharingan"))usr.Sharingan()
				switch(txt)
					if("Summoning Jutsu: Dog")usr.Summoning_Dog()
					if("Wood Style: Tree Summoning")usr.Tree_Summoning()
					if("Ice Explosion")usr.Ice_Explosion()//iceexplosionstuff
					if("Super Multi-Size Technique")usr.SuperMultiSizeTechnique()//multisizestuff
					if("Bubble Shield")usr.Bubble_Shield()
					if("Chakra Infusion Training")usr.Chakra_Infusion_Training()//chakrainfusionstuff
					if("Shadow Field")usr.Shadow_Field()
					if("Gravity Divergence: Almighty Push")usr.AlmightyPush()
					if("Temple of Nirvana")usr.Temple_Of_Nirvana()
					if("Bone Sensation")usr.Bone_Sensation()
					if("Bone Pulse")usr.Bone_Pulse()
					if("Bone Tip")usr.Bone_Tip()
					if("Shadow Bind")usr.Shadow_Extension()
					if("Water Clone")usr.MizuClone_Jutsu()
					if("Water Prison")usr.WaterPrison()
					if("Rasenshuriken")usr.Rasenshuriken()
					if("Water Shark Projectile")usr.WaterShark()
					if("Tsukuyomi")usr.Tsukuyomi()
					if("Wind Shield")usr.Wind_Shield()
					if("Earth Release: Mud River")usr.Earth_Release_Mud_River()
					if("Earth Disruption")usr.Earth_Disruption()
					if("Mystical Palms")usr.Mystical_Palms()
					if("Amaterasu")usr.Amaterasu()
					if("Demonic Illusion: Tree Binding Death")usr.TreeBinding()
					if("Susanoo")usr.Susanoo()
					if("Chidori Jinrai")usr.Chidori_Jinrai()
					if("Kirin")usr.Kirin()
					if("Chidori Needles")usr.Chidori_Needles()
					if("Rasengan")usr.Rasengan()
					if("Chidori")usr.Chidori()
					if("Sickle Weasel Technique")usr.Sickle_Weasel_Technique()
					if("Morning Peacock")usr.Morning_Peacock()
					if("Leaf Whirlwind")usr.Leaf_Whirlwind()
					if("Meteor Punch")usr.Meteor_Punch()
					if("Gomu Gomu No Red Hawk")usr.Gomu_Gomu_No_Red_Hawk()
					if("Clone Jutsu")usr.Clone_Jutsu()
					if("Chakra Release")usr.Chakra_Release()
					if("Sharingan")usr.Sharingan()
					if("Advanced Body Replacement Jutsu")usr.Advanced_Body_Replacement_Technique()
					if("Chakra Control")usr.Chakra_Control()
					if("Body Replacement Jutsu")usr.Body_Replacement_Technique()
					if("Transformation Jutsu")usr.Transformation_Jutsu()
					if("Clone Destroy")usr.Clone_Jutsu_Destroy()
					if("Fire Release: Fire Ball")usr.Fire_Ball()
					if("Fire Release: Blazing Sun")usr.AFire_Ball()
					if("Fire Release: Phoenix Immortal Fire Technique")usr.Phoenix_Immortal_Fire_Technique()
					if("Fire Release: Fire Dragon Projectile")usr.Fire_Dragon_Projectile()
					if("Gravity Divergence: Induction")usr.Induction()
					if("Gravity Divergence: Repulsion")usr.Repulsion()
					if("Body Flicker Technique")usr.Shunshin()
					if("Byakugan")usr.Byakugan()
					if("Eight Trigrams: 64 Palms")usr.Eight_Trigrams_64_Palms()
					if("Earth Release: Earth Cage")usr.Earth_Release_Earth_Cage()
					if("Shadow Clone Jutsu")usr.ShadowClone_Jutsu()
					if("Multiple Shadow Clone Jutsu")usr.MultipleShadowClone_Jutsu()
					if("Eight Trigrams Palm: Heavenly Spin")usr.Kaiten()
					if("Sensatsu Suishou")usr.Sensatsu_Suisho()
					if("Water Release: Exploding Water Colliding Wave")usr.Water_Release_Exploding_Water_Colliding_Wave()
					if("Fire Release: Ash Pile Burning")usr.Fire_Release_Ash_Pile_Burning()
					if("Demonic Ice Mirrors")usr.Demonic_Ice_Mirrors()
					if("Heal")usr.Heal()
					if("Chakra Control")usr.Chakra_Control()
					if("Eight Gates")usr.Gates()
					/*if("Opening Gate")usr.Gate_1()
					if("Energy Gate")usr.Gate_2()
					if("Life Gate")usr.Gate_3()
					if("Pain Gate")usr.Gate_4()
					if("Limiter Gate")usr.Gate_5()*/
					if("Young Bracken Dance")usr.Young_Bracken_Dance()
					if("Eight Trigrams: Empty Palm")usr.Eight_Trigrams_Empty_Palm()
					if("First Puppet Summoning")usr.First_Puppet_Summoning()
					if("Second Puppet Summoning")usr.Second_Puppet_Summoning()
					if("Puppet Dash")usr.Puppet_Dash()
					if("Puppet Shoot")usr.Puppet_Shoot()
					if("Puppet Grab")usr.Puppet_Grab()
					if("Puppet Transform")usr.Puppet_Transform()
					if("Angel Wings")usr.Angel_Wings()
					if("C2")usr.C2()
					if("C3")usr.C3()
					if("C1: Tracking Birds")usr.ClayBirds()
					if("C1: Spider Swarm")usr.ClaySpiders()
					if("Shukakku Spear")usr.Shukakku_Spear()
					if("Desert Coffin")usr.Desert_Coffin()
					if("Sand Shuriken")usr.Sand_Shuriken()
					if("Insect Clone")usr.InsectClone()
					if("Destruction Bug Swarm")usr.Destruction_Bug_Swarm()
					if("Stealth Bug")usr.Stealth_Bug()
					if("Crow Clone")usr.Crow_Clone()
					if("Crow Substitution")usr.Crow_Substitution()
					if("Shikigami Spear")usr.Shikigami_Spear()
					if("Paper Chakram")usr.Paper_Chakram()
					if("Shikigami Dance")usr.Shikigami_Dance()
					if("Sand Funeral")usr.Sand_Funeral()
					if("Sand Shield")usr.Sand_Shield()
					if("Sharingan Copy")usr.Sharingan_Copy()
					if("Chakra Leech")usr.Chakra_Leech()
					if("Camellia Dance")usr.Camellia_Dance()
					if("Sorcery: Death Ruling Possesion Blood")usr.Death_Ruling_Possesion_Blood()
					if("Sacrifice to Jashin")usr.Immortality()
					if("Immortal") src.Immortal()
					if("Destruction Bug Neurotoxin")usr.Bug_Neurotoxin()
					if("Destruction Bug Hunter Scarabs")usr.Hunter_Scarabs()
					if("Insect Cocoon")usr.Insect_Cocoon()
					if("Earth Release: Dark Swamp")usr.Earth_Style_Dark_Swamp()
					if("Eight Trigrams: Mountain Crusher")usr.Eight_Trigrams_Mountain_Crusher()
					if("Last Resort: Eight Gates Assault")usr.Eight_Gates_Assault()
					if("Bone Drill")usr.Bone_Drill()
					if("Bringer of Darkness Technique")usr.Bringer_of_Darkness_Technique()
					if("Blade of Wind")usr.Blade_of_Wind()
					if("Raikiri")usr.Raikiri()
					if("Leaf Hidden Finger Jutsu: One Thousand Years of Death")usr.One_Thousand_Years_of_Death()
					if("One's Own Life Reincarnation")usr.Ones_Own_Life_Reincarnation()
					if("Body Pathway Derangement")usr.Body_Pathway_Derangement()
					if("Poison Mist")usr.Poison_Mist()
					if("Cherry Blossom Impact")usr.Cherry_Blossom_Impact()
					if("Blade Manipulation Jutsu")usr.Blade_Manipulation_Jutsu()
					if("Water Dragon Projectile")usr.Water_Dragon_Projectile()
					if("Fire Dragon Projectile")usr.Fire_Dragon_Projectile()
					if("Mud Dragon Projectile")usr.Mud_Dragon_Projectile()
					if("Curse Seal of Heaven")usr.CS()
					if("Summoning Jutsu: Snake")usr.Summoning_Snake()
					if("Summoning Jutsu: Snake")usr.Summoning_Snake()
					if("Sage Mode")usr.SageMode()
					if("Curse Seal")usr.CurseSeal()
					if("Sage Style: Giant Snake")usr.Snake_Release_Jutsu()
					if("Snake Skin Replacement")usr.Snake_Skin_Replacement_Jutsu()
					if("Sage Style: Toad Bind")usr.Sage_Bind()
					if("RedPill")usr.RedPill()
					if("YellowPill")usr.YellowPill()
					if("GreenPill")usr.GreenPill()
					if("Human Bullet Tank")usr.HumanBulletTank()
					if("Calorie Control")usr.CalorieControl()
					if("Earth Mask")usr.EarthMask()
					if("Fire Mask")usr.FireMask()
					if("Wind Mask")usr.WindMask()
					if("Lightning Mask")usr.LightningMask()
					if("Earth Release: Mud Wall")usr.MudWall()
					if("Weapon Manipulation Jutsu")usr.Weapon_Manipulation_Jutsu()
					if("Twin Dragons")usr.TwinDragons()
					if("C1: Exploding Snake")usr.C1Snake()
					if("Curse Dragon")usr.Curse_Dragon()
					if("Kamehameha")usr.Kamehameha()
					if("Hidden Snake Stab")usr.HiddenSnakeStab()
					if("Wood Release: Wood Fortress")usr.WoodStyleFortress()
					if("Wood Release: Wooden Balvan")usr.Wood_Balvan()
					if("Wood Release: Root Stab")usr.Root_Stab()
					if("Wood Release: Root Strangle")usr.Root_Strangle()
					if("Crystal Release: Crystal Shards")usr.Crystal_Shards()
					if("Crystal Release: Crystal Needles")usr.Crystal_Needles()
					if("Crystal Release: Crystal Explosion")usr.Crystal_Explosion()
					if("Crystal Release: Crystal Spikes")usr.Crystal_Spikes()
					if("Earth Release: Earth Boulder")usr.EarthBoulder()

					if("Forbiden Tehnique: Kazekage Puppet")usr.Summon_Kazekage_Puppet()
					if("Rinnegan")usr.Rinnegan()
					if("Bug Tornado")usr.BugTornado()
					if("Spider Web Shoot")usr.WebShoot()
					if("Spider Arrow Shoot")usr.ArrowShoot()
					if("Summon Spider")usr.Summon_Spider()
					if("Wind Tornados")usr.Wind_Tornados()
					if("Getsuga Tenshou")usr.Getsuga_Tenshou()
					if("Dance Of The Kaguya")usr.Dance_Of_The_Kaguya()
					if("ShiShi Rendan")usr.ShishiRendan()
					if("Sage Style Giant Rasengan")usr.Sage_Style_Giant_Rasengan()
					if("Demon Wind Shuriken")usr.Demon_Wind_Shuriken()
					if("Intangible")usr.Intangible_Jutsu()
					if("Rising Dragon")usr.Rising_Dragon()
					if("Ink Style: Rats")usr.SaiRat()
					if("Ink Style: Snakes")usr.Sai_Snakes()
					if("Ink Style: Snake Rustle Jutsu")usr.Snake_Rustle_Jutsu()
					if("Ultimate Ink Style: Lions")usr.InkLions()
					if("Ultimate Ink Bird")usr.Ultimate_Ink_Bird()
					if("Bubble Barrage")usr.BubbleBarrage()
					if("Bubble Spreader")usr.BubbleSpreader()
					if("Bubble Trouble")usr.Bubble_Trouble()
					if("Mokuton - Daijurin no Jutsu")usr.Daijurin()
					if("Mokuton - Jubaku Eisou")usr.JubakuEisou()
					if("Doton Doryuusou no Jutsu")usr.Doryuusou()
					if("Doton Doryo Dango")usr.Dango()
					if("Fuuton Daitoppa")usr.FuutonDaitoppa()
					if("Zankuuha")usr.Zankuuha()
					if("Wind Dragon Projectile")usr.Wind_Dragon_Projectile()
					if("Wind Cutter")usr.Wind_Cutter()
					if("Lightning Balls")usr.LightningBalls()
					if("Chidori Nagashi")usr.Chidori_Nagashi()
					if("Suiton Suijinheki no Jutsu")usr.Suijinheki()
					if("Suiton Teppoudama")usr.Teppoudama()
					if("Magma Style: Magma Cage")usr.Magma_Crush()
					if("Magma Style: Magma Needles")usr.Magma_Needles()
					if("Warp Rasengan")usr.Warp_Rasengan()
					if("Flying Thunder God")usr.Flying_Thunder_God()
					if("Flying Thunder God: Kunai")usr.Flying_Thunder_God_Kunai()
					if("Flying Thunder God: Great Escape")usr.Flying_Thunder_God_Great_Escape()
					if("Blade Hurricane")usr.Blade_Hurricane()
					if("Reaper Death Seal")usr.Reaper_Death_Seal()
					if("Soul Devastator Seal")usr.Soul_Devastator_Seal()
					if("Sealing Technique: Seal of Terror")usr.Seal_of_Terror()
					if("Sealing Jutsu: Limb Paralyzis")usr.LimbParalyzeSeal()
					if("Crystal Pillar")usr.Crystal_Pillar()
					if("Crystal Mirrors")usr.Crystal_Mirrors()
					if("Crystal Arrow")usr.Crystal_Arrow()
					if("Iceball")usr.Iceball()
					if("Omega Ice Ball")usr.Omega_Ice_Ball()
					if("Kamui")usr.Kamui()
					if("Warp Dimension")usr.WarpDim()
					if("Jinchuriki: Chakra Cloak1")usr.Jin_Cloak1()
					if("Jinchuriki: Chakra Cloak2")usr.Jin_Cloak2()
					if("Jinchuriki: Chakra Cloak3")usr.Jin_Cloak3()
					if("Jinchuriki: Chakra Cloak4")usr.Jin_Cloak4()
					if("Jinchuriki: Chakra Cloak5")usr.Jin_Cloak5()
					if("Jinchuriki: Chakra Cloak6")usr.Jin_Cloak6()
					if("Jinchuriki: Chakra Cloak7")usr.Jin_Cloak7()
					if("Jinchuriki: Chakra Cloak8")usr.Jin_Cloak8()
					if("Jinchuriki: Chakra Cloak9")usr.Jin_Cloak9()
					if("Dust Particle Prison")usr.Dust_Particle_Prison()
					if("Dust Particle Prison Beam")usr.Dust_Particle_Prison_Beam()
					if("Black Iron Fists")usr.Black_Iron_Fists()
					if("Grasp of Iron")usr.Grasp_of_Iron()
					if("Shield of Iron")usr.Shield_of_Iron()
					if("Gathering Assault: Pyramid")usr.Gathering_Assault_Pyramid()


		HotSlots()
			if(usr.hotslot=="1") usr.doslot(usr.hotslot1)
			if(usr.hotslot=="2") usr.doslot(usr.hotslot2)
			if(usr.hotslot=="3") usr.doslot(usr.hotslot3)
			if(usr.hotslot=="4") usr.doslot(usr.hotslot4)
			if(usr.hotslot=="5") usr.doslot(usr.hotslot5)
			if(usr.hotslot=="6") usr.doslot(usr.hotslot6)
			if(usr.hotslot=="7") usr.doslot(usr.hotslot7)
			if(usr.hotslot=="8") usr.doslot(usr.hotslot8)
			if(usr.hotslot=="9") usr.doslot(usr.hotslot9)
			if(usr.hotslot=="10") usr.doslot(usr.hotslot10)
			if(usr.hotslot=="11") usr.doslot(usr.hotslot11)
			if(usr.hotslot=="12") usr.doslot(usr.hotslot12)
			if(usr.hotslot=="13") usr.doslot(usr.hotslot13)
			if(usr.hotslot=="14") usr.doslot(usr.hotslot14)
			if(usr.hotslot=="15") usr.doslot(usr.hotslot15)
			if(usr.hotslot=="16") usr.doslot(usr.hotslot16)
			if(usr.hotslot=="17") usr.doslot(usr.hotslot17)
			if(usr.hotslot=="18") usr.doslot(usr.hotslot18)

mob
	verb
		HotSlot1()
			set name = "Hotbar Slot 1"
			set category = "keybindable"
			set hidden=1
			usr.hotslot="1"
			usr.HotSlots()

		HotSlot2()
			set name = "Hotbar Slot 2"
			set category = "keybindable"
			set hidden=1
			usr.hotslot="2"
			usr.HotSlots()

		HotSlot3()
			set name = "Hotbar Slot 3"
			set category = "keybindable"
			set hidden=1
			usr.hotslot="3"
			usr.HotSlots()

		HotSlot4()
			set name = "Hotbar Slot 5"
			set category = "keybindable"
			set hidden=1
			usr.hotslot="4"
			usr.HotSlots()

		HotSlot5()
			set name = "Hotbar Slot 5"
			set category = "keybindable"
			set hidden=1
			usr.hotslot="5"
			usr.HotSlots()

		HotSlot6()
			set name = "Hotbar Slot 6"
			set category = "keybindable"
			set hidden=1
			usr.hotslot="6"
			usr.HotSlots()

		HotSlot7()
			set name = "Hotbar Slot 7"
			set category = "keybindable"
			set hidden=1
			usr.hotslot="7"
			usr.HotSlots()

		HotSlot8()
			set name = "Hotbar Slot 8"
			set category = "keybindable"
			set hidden=1
			usr.hotslot="8"
			usr.HotSlots()

		HotSlot9()
			set name = "Hotbar Slot 9"
			set category = "keybindable"
			set hidden=1
			usr.hotslot="9"
			usr.HotSlots()

		HotSlot10()
			set name = "Hotbar Slot 10"
			set category = "keybindable"
			set hidden=1
			usr.hotslot="10"
			usr.HotSlots()

		HotSlot11()
			set name = "Hotbar Slot 11"
			set category = "keybindable"
			set hidden=1
			usr.hotslot="11"
			usr.HotSlots()

		HotSlot12()
			set name = "Hotbar Slot 12"
			set category = "keybindable"
			set hidden=1
			usr.hotslot="12"
			usr.HotSlots()

		HotSlot13()
			set name = "Hotbar Slot 13"
			set category = "keybindable"
			set hidden=1
			usr.hotslot="13"
			usr.HotSlots()

		HotSlot14()
			set name = "Hotbar Slot 14"
			set category = "keybindable"
			set hidden=1
			usr.hotslot="14"
			usr.HotSlots()

		HotSlot15()
			set name = "Hotbar Slot 15"
			set category = "keybindable"
			set hidden=1
			usr.hotslot="15"
			usr.HotSlots()

		HotSlot16()
			set name = "Hotbar Slot 16"
			set category = "keybindable"
			set hidden=1
			usr.hotslot="16"
			usr.HotSlots()

		HotSlot17()
			set name = "Hotbar Slot 17"
			set category = "keybindable"
			set hidden=1
			usr.hotslot="17"
			usr.HotSlots()

		HotSlot18()
			set name = "Hotbar Slot 18"
			set category = "keybindable"
			set hidden=1
			usr.hotslot="18"
			usr.HotSlots()

