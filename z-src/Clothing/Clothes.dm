mob/var/list/ClothingOverlays = list("Vest"=null,"Shirt"=null,"Pants"=null,"Shoes"=null,"Mask"=null,"Headband"=null,"Sword"=null,"Gloves"=null,"Accessories"=null,"Robes"=null)


mob/proc
	RemoveAllClothing()
		for(var/C in src.ClothingOverlays)
			var/c = src.ClothingOverlays[C]
			src.overlays -= c
	RemoveSection(var/section)
		var/c = src.ClothingOverlays[section]
		src.ClothingOverlays[section] = null
		src.overlays -= c
	AddSection(var/section, var/icon)
		src.ClothingOverlays[section] = icon
		var/c = src.ClothingOverlays[section]
		src.overlays += c
	ReAddClothing()
		src.RemoveAllClothing()
		//AddSection("Hair", src.ClothingOverlays["Hair"])
		if(src.HairStyle)
			//world.log << "has hair"
			var/obj/HAIR/H=new

			H.icon=icon(Hairstyles["[HairStyle]"])
			HairColorStyle=icon(Hairstyles["[HairStyle]"])

			var/list/rgb = rgb2num(src.HairColor)
			H.icon += rgb(rgb[1], rgb[2], rgb[3])

			H.layer=src.layer
			src.overlays+=H
		AddSection("Shoes", src.ClothingOverlays["Shoes"])
		AddSection("Pants", src.ClothingOverlays["Pants"])
		AddSection("Shirt", src.ClothingOverlays["Shirt"])
		AddSection("Vest", src.ClothingOverlays["Vest"])
		AddSection("Mask", src.ClothingOverlays["Mask"])
		AddSection("Robes", src.ClothingOverlays["Robes"])
		AddSection("Headband", src.ClothingOverlays["Headband"])
		AddSection("Sword", src.ClothingOverlays["Sword"])
		AddSection("Gloves", src.ClothingOverlays["Gloves"])
		AddSection("Accessories", src.ClothingOverlays["Accessories"])
mob/var/tmp/HairColorStyle
var/const
	HAIR_LAYER = FLOAT_LAYER-1
	VEST_LAYER = FLOAT_LAYER-3
	SHIRT_LAYER = MOB_LAYER+1
	PANTS_LAYER = FLOAT_LAYER-5
	SHOES_LAYER = FLOAT_LAYER-6
	MASK_LAYER = HAIR_LAYER+2
	HEADBAND_LAYER = HAIR_LAYER+1
	SWORD_LAYER = FLOAT_LAYER-7

obj/proc/take(mob/M)
	if(M.dead)
		M<<output("You're dead.","Action.Output")
		return
	hearers()<<output("[M] picks up [src].","Action.Output")
	M.RecieveItem(src)
	M.client.UpdateInventoryPanel()

mob
	var
		Mask
		HeadWrap
		Helm
		Shirt
		Vest
		Pants
		Shoes
		Sword
		Gloves
		Accessories
		//list/Clothes

obj
	var
		cColor // had to make it a normal obj var because clothier doesn't type cast
	HAIR
	var
		tmp
			Boosts
			Str=0
			Def=0
			Agil=0
			Nin=0
			Tai=0
			Gen=0
			HealP=0
			ChakP=0
			section
			C
		Cost=0
	Inventory
		var/tmp/can_purchase = 0
		Clothing
			Colorable=1
			Hengable=1
			New()
				..()
				spawn()
					if(cColor)
						var/icon/X = new(icon)
						X.Blend(cColor, ICON_ADD)
						icon = X

			MouseDrop(over_object=src,src_location,over_location, src_control,over_control,params)
			//Get
				if(usr.ClothingOverlays[section]==src.icon) return
				if(get_dist(usr,src)<=1)
					//if(over_control == "Map.map"&&src_control=="Inventory.InvenInfo")
					if(usr.contents.Find(src))
						src.Drop(usr)
						return
			Click()
				..()
				if(get_dist(src,usr)>1) return
				if(!usr.contents.Find(src))
					take(usr)
					return

				var/icon/I = new(src.icon, src.icon_state)
				var/iconfile = fcopy_rsc(I)
				winset(usr, "Inventory.EquippedName", "text='[src.name]'")
				winset(usr, "Inventory.EquippedImage", "image=\ref[iconfile]")
				usr<<output(null, "Inventory.EquippedItemInfo")
				usr<<output("<center>[Description]", "Inventory.EquippedItemInfo")

				if(src in usr)
					if(!usr.ClothingOverlays[section])
						Wear()
					else
						Remove()
				usr.client.UpdateInventoryPanel()

			DblClick()

			proc/Wear()
				if(usr.ClothingOverlays[section]) return
				C=src
				usr.ClothingOverlays[src.section] = src.icon
				usr.ReAddClothing()
				src.suffix = "(Equipped)"

			proc/Remove()
				if(!usr.ClothingOverlays[section]) return
				if(usr.ClothingOverlays[section] == src.icon)
					usr.RemoveSection(section)
				src.suffix = ""

			//Click()
			//	if(src in usr)
			//		if(!src.equip)
			//			src.equip=1
			//			src.suffix="Equipped"
			//			src.layer=MOB_LAYER+1
			//			usr.overlays+=src
			//		else
			//			src.equip=0
			//			src.suffix=""
			//			usr.overlays-=src
			//			src.layer=OBJ_LAYER
			Masks
				section="Mask"
				Anbu
					icon='anbu mask.dmi'
					//icon_state="1"
					//mouse_drag_pointer = "1"
					name="Anbu Mask"
					Cost=35000
				Anbu_Black
					icon='anbu mask black.dmi'
					//icon_state="1"
					//mouse_drag_pointer = "1"
					name="Anbu Mask Black"
					Cost=35000
				Anbu_Blue
					icon='anbu mask blue.dmi'
					//icon_state="1"
					//mouse_drag_pointer = "1"
					name="Anbu Mask Blue"
					Cost=35000
				Anbu_Purple
					icon='anbu mask purple.dmi'
					//icon_state="1"
					//mouse_drag_pointer = "1"
					name="Anbu Mask Purple"
					Cost=35000
				Anbu_Brown
					icon='anbu mask brown.dmi'
					//icon_state="1"
					//mouse_drag_pointer = "1"
					name="Anbu Mask Brown"
					Cost=35000
				Half_Mask
					Colorable=0
					icon='Half Mask.dmi'
					icon_state=""
					mouse_drag_pointer = ""
					name="Half Mask"
					Boosts="+5 Taijutsu"
					Tai=5
					Cost=100000
					can_purchase = 1
				Half_Mask_Black
					Colorable=0
					icon='Half Mask Black.dmi'
					icon_state=""
					mouse_drag_pointer = ""
					name="Black Half Mask"
					Boosts="+5 Taijutsu"
					Tai=5
					Cost=100000
					can_purchase = 1
				Obito_Goggles
					Colorable=0
					icon='ObitoGoggles.dmi'
					icon_state=""
					mouse_drag_pointer = ""
					name="Obito Goggles"
					Boosts="+5 Taijutsu"
					Tai=5
					Cost=100
				Tobi_Mask
					Colorable=0
					icon='Tobi Mask.dmi'
					icon_state=""
					mouse_drag_pointer = ""
					name="Tobi Mask"
					Boosts="+15 Ninjutsu"
					Nin=15
					Cost=100000
				TobiWarMask
					Colorable=0
					icon='tobiswarmaskoldbase.dmi'
					icon_state=""
					mouse_drag_pointer = ""
					name="Tobi War Mask"
					Boosts="+15 Ninjutsu"
					Nin=15
					Cost=1000000
				Absolute_Zero_Mask
					Colorable=0
					icon='Absolute Zero Mask.dmi'
					icon_state=""
					mouse_drag_pointer = ""
					name="Absolute Zero Mask"
					Boosts="+3 Taijutsu"
					Tai=3
					Cost=100000
				Mask
					Colorable=0
					icon='Mask.dmi'
					icon_state=""
					mouse_drag_pointer = ""
					name="Face Mask"
					Boosts="+10 Ninjutsu"
					Nin=10
					Cost=100
			HeadWrap
				section="Headband"

				LeafHeadBand
					icon='HeadBandLeaf.dmi'
					icon_state=""
					mouse_drag_pointer = ""
					name="Leaf Headband"
					Boosts="+ 2 Defence"
					Def=2
					Cost=100
				SandHeadBand
					icon='HeadBandSand.dmi'
					icon_state=""
					mouse_drag_pointer = ""
					name="Sand Headband"
					Boosts="+ 2 Defence"
					Def=2
					Cost=100
				MistHeadBand
					icon='HeadBandMist.dmi'
					icon_state=""
					mouse_drag_pointer = ""
					name="Mist Headband"
					Boosts="+ 2 Defence"
					Def=2
					Cost=100
				SoundHeadBand
					icon='HeadBandSound.dmi'
					icon_state=""
					mouse_drag_pointer = ""
					name="Sound Headband"
					Boosts="+ 2 Defence"
					Def=2
					Cost=100
				RockHeadBand
					icon='HeadBandRock.dmi'
					icon_state=""
					mouse_drag_pointer = ""
					name="Rock Headband"
					Boosts="+ 2 Defence"
					Def=2
					Cost=100
				Scarf
					icon='Scarf.dmi'
					icon_state=""
					mouse_drag_pointer = ""
					name="White Scarf"
					Colorable=0
					Boosts="+ 5 Defence"
					Cost=500
					Def=5
					can_purchase = 1
				Straw_Hat
					icon='Straw Hat.dmi'
					Cost=1000
					//icon_state="1"
					//mouse_drag_pointer = "1"
					name="Straw Hat"
				HokageHat
					icon='Hokage Hat.dmi'
					//icon_state="1"
					//mouse_drag_pointer = "1"
					name="Hokage Hat"
				KazekageHat
					icon='Kazekage Hat.dmi'
					//icon_state="1"
					//mouse_drag_pointer = "1"
					name="Kazekage Hat"
				OtokageHat
					icon='OtokageHat.dmi'
					//icon_state="1"
					//mouse_drag_pointer = "1"
					name="Otokage Hat"
				MizukageHat
					icon='MizukageHat.dmi'
					//icon_state="1"
					//mouse_drag_pointer = "1"
					name="Mizukage Hat"
				TsuchikageHat
					icon='Tsui Hat.dmi'
					//icon_state="1"
					//mouse_drag_pointer = "1"
					name="Mizukage Hat"
				TobiMask
					icon='Tobi Mask.dmi'
					name="Akatsuki Leader Mask"
				AkatsukiHat
					icon='AkatsukiHats.dmi'
					name="Akatsuki Hat"
			Vests
				section="Vest"
				ChuninVest
					Colorable=0
					icon='Chunin Vest.dmi'
					icon_state=""
					mouse_drag_pointer = ""
					name="Leaf Flak Vest"
					Boosts="+ 8 Defence"
					Def=8
				SandChuninVest
					Colorable=0
					icon='SandChuninVest.dmi'
					icon_state=""
					mouse_drag_pointer = ""
					name="Sand Flak Vest"
					Boosts="+ 8 Defence"
					Def=8
				SoundVest
					Colorable=0
					icon='SoundVest.dmi'
					icon_state=""
					mouse_drag_pointer = ""
					name="Sound Flak Vest"
					Boosts="+ 8 Defence"
					Def=8
					Cost=20
				MistVest
					Colorable=0
					icon='MistChuunin.dmi'
					icon_state=""
					mouse_drag_pointer = ""
					name="Mist Flak Vest"
					Boosts="+ 8 Defence"
					Def=8
				RockVest
					Colorable=0
					icon='RockChuunin.dmi'
					icon_state=""
					mouse_drag_pointer = ""
					name="Rock Flak Vest"
					Boosts="+ 8 Defence"
					Def=8
					Cost=20
				Black_Body_Guard_Vest
					Colorable=0
					icon='Black Body Guard Vest.dmi'
					icon_state=""
					mouse_drag_pointer = ""
					name="Black Bodyguard Vest"
					Boosts="+ 15 Defence"
					Def=15
					Cost=10000
				Body_Guard_Vest
					Colorable=0
					icon='Body Guard Vest.dmi'
					icon_state=""
					mouse_drag_pointer = ""
					name="Bodyguard Vest"
					Boosts="+ 15 Defence"
					Def=15
					Cost=10000
				Elite_Bodyguard_Vest
					Colorable=0
					icon='Kuro Shiro Vest.dmi'
					icon_state=""
					mouse_drag_pointer = ""
					name="Elite Bodyguard Vest"
					Boosts="+ 20 Defence"
					Def=15
					Cost=10000
				Uchiha_Vest
					Colorable=0
					icon='Uchiha Vest.dmi'
					Cost=1000
					icon_state=""
					mouse_drag_pointer = ""
					name="Uchiha Vest"
					Boosts="+ 8 Defence"
					Def=8
				Tank_Top
					icon='Tank-Top.dmi'
					icon_state=""
					mouse_drag_pointer = ""
					name="Tank Top"
					Boosts="+ 8 Defence"
					Cost=100
					Def=8
					can_purchase = 1
			Shirt
				section="Shirt"
				Shirt
					icon='Shirt.dmi'
					icon_state=""
					mouse_drag_pointer = ""
					name="Short Sleeve Shirt"
					Boosts="+ 2 Defence"
					Cost=75
					Def=2
					can_purchase = 1
				Muscles
					icon='Muscles.dmi'
					icon_state=""
					mouse_drag_pointer = ""
					name="Muscles"
					Boosts="+ 2 Defence"
					Def=2
					Cost=100000
				LongSleevedShirt
					icon='Long Sleeved Shirt.dmi'
					icon_state=""
					mouse_drag_pointer = ""
					name="Long Sleeve Shirt"
					Boosts="+2 Defence"
					Cost=100
					Def=2
					can_purchase = 1
				Long_Shirt
					icon='Long Sleeved Shirt.dmi'
					icon_state=""
					mouse_drag_pointer = ""
					name="Long Sleeved Shirt"
					Boosts="+ 5 Defence"
					Cost=100
					Def=5
				UchihaShirt
					icon='Uchiha shirt.dmi'
					icon_state=""
					mouse_drag_pointer = ""
					name="Uchiha Shirt"
					Boosts="+5 Ninjutsu"
					Nin=5
					Cost=150
				Nara_Shirt
					icon='Nara Shirt.dmi'
					icon_state=""
					mouse_drag_pointer = ""
					name="Nara Shirt"
					Boosts="+5 Ninjutsu"
					Nin=5
					Cost=150
				UzumakiShirt
					icon='Uzumaki Shirt.dmi'
					icon_state=""
					mouse_drag_pointer = ""
					name ="Uzumaki Shirt"
					Boosts="+5 Ninjutsu"
					Nin=5
					Cost=150
				Shirt_White
					icon='Shirt White.dmi'
					icon_state=""
					mouse_drag_pointer = ""
					name="Shirt White"
					Boosts="+ 2 Defence"
					Def=2
					Cost=100
			Pants
				section="Pants"
				Pants
					icon='Pants.dmi'
					icon_state=""
					mouse_drag_pointer = ""
					name="Shorts"
					Boosts="+ 2 Defence"
					Def=2
					Cost=75
					can_purchase = 1

				LongPants
					icon='LongPants.dmi'
					icon_state=""
					mouse_drag_pointer=""
					name="Pants"
					Boosts="+ 4 Defence"
					Def=4
					Cost=100
					can_purchase = 1
			Shoes
				section="Shoes"
				Sandals
					icon='Sandals.dmi'
					icon_state="Test"
					mouse_drag_pointer = ""
					name="Sandals"
					Boosts="+ 2 Agility"
					Agil=2
					Cost=50
					can_purchase = 1
			Robes
				section="Robes"
				Jacket
					Colorable=1
					icon='Jacket.dmi'
					icon_state=""
					mouse_drag_pointer = ""
					name="Jacket"
					Boosts="+5 Defence"
					Cost = 100
					Def=5
					can_purchase = 1
				Goku_Suit
					Colorable=0
					icon='Goku.dmi'
					icon_state=""
					mouse_drag_pointer = ""
					name="Goku Suit"
					Boosts="+20 Ninjutsu"
					Nin=20
					Cost=1000
				Captain_Robe
					Colorable
					icon='Captain.dmi'
					icon_state=""
					mouse_drag_pointer = ""
					name="Squad Captain Suit"
					Boosts="+20 Ninjutsu"
					Nin=20
					Cost=1000
				Anbu_Suit
					Colorable=0
					icon='AnbuSet.dmi'
					icon_state=""
					mouse_drag_pointer = ""
					name="Anbu Suit"
					Boosts="+ 8 Defence"
					Def=8
					Cost=1000
				Kazekage_Suit
					Colorable=0
					icon='GaaraC.dmi'
					icon_state=""
					mouse_drag_pointer = ""
					name="Kazekage Suit"
					Boosts="+ 8 Defence"
					Def=8
				Jounin_Training_Suit
					Colorable=0
					icon='GuyC.dmi'
					icon_state=""
					mouse_drag_pointer = ""
					name="Jounin Training Suit"
					Boosts="+ 8 Defence"
					Def=8
					Cost=10
				Jounin_Suit
					Colorable=0
					icon='KakashiC.dmi'
					icon_state=""
					mouse_drag_pointer = ""
					name="Jounin Suit"
					Boosts="+ 8 Defence"
					Def=8
					Cost=10
				Hyuuga_Suit
					Colorable=0
					icon='NejiC.dmi'
					icon_state=""
					mouse_drag_pointer = ""
					name="Hyuuga Suit"
					Boosts="+ 8 Defence"
					Def=8
					Cost=10
				Mist_Jounin_Suit
					Colorable=0
					icon='ZabuzaC.dmi'
					icon_state=""
					mouse_drag_pointer = ""
					name="Mist Jounin Suit"
					Boosts="+ 8 Defence"
					Def=8
					Cost=10
				Akatsuki_Robe
					Colorable=0
					icon='Akatsuki Robe.dmi'
					icon_state=""
					mouse_drag_pointer = ""
					name="Akatsuki Robe"
					Boosts="+ 7 Defence"
					Def=7
					Cost=10000
				Kaguya_Robe
					Colorable=0
					icon='KaguyaRobe.dmi'
					icon_state=""
					mouse_drag_pointer = ""
					name="Kaguya Robe"
					Boosts="+10 Taijutsu"
					Tai=20
					Cost = 1500
				Robe
					Colorable=1
					icon='Robe.dmi'
					icon_state=""
					mouse_drag_pointer = ""
					name="Robe"
					Boosts="+ 4 Defence"
					Cost=1000
					Def=4
				Closed_Robe
					Colorable=1
					icon='Closed Robe.dmi'
					icon_state=""
					name="Closed Robe"
					Boosts="+ 4 Defence"
					Cost = 1000
					Def = 4
					can_purchase = 1
				HokageRobe
					Colorable=0
					icon='Hokage Robe.dmi'
					icon_state=""
					mouse_drag_pointer = ""
					name="Hokage Robe"
					Boosts="+ 15 Defence"
					Def=15
				HokageRobe2
					Colorable=0
					icon='ClosedKageRobe.dmi'
					icon_state=""
					mouse_drag_pointer = ""
					name="Closed Hokage Robe"
					Boosts="+15 Defence"
					Def=15
				KazekageRobe
					Colorable=0
					icon='Kazekage Robe.dmi'
					icon_state=""
					mouse_drag_pointer = ""
					name="Kazekage Robe"
					Boosts="+ 15 Defence"
					Def=15
				OtokageRobe
					Colorable=0
					icon='OtokageRobe.dmi'
					icon_state=""
					mouse_drag_pointer = ""
					name="Otokage Robe"
					Boosts="+ 15 Defence"
					Def=15
				TsuchikageRobe
					Colorable=0
					icon='Tsui Robe.dmi'
					icon_state=""
					mouse_drag_pointer = ""
					name="Tsuchikage Robe"
					Boosts="+ 15 Defence"
					Def=15
				MizukageRobe
					Colorable=0
					icon='MizukageRobe.dmi'
					icon_state=""
					mouse_drag_pointer = ""
					name="Mizukage Robe"
					Boosts="+ 15 Defence"
					Def=15
				FlameRobe
					Colorable=0
					icon='Flame Robe.dmi'
					icon_state=""
					mouse_drag_pointer = ""
					name="Will Of Fire Robe"
					Boosts="+ 20 Defence"
					Def=20
					Cost=10000
				Sage_Robe
					Colorable=0
					icon='Sage Robe.dmi'
					icon_state=""
					mouse_drag_pointer = ""
					name="Sage Robe"
					Boosts="+ 10 Ninjutsu"
					Nin=10
					Cost=10000
				Hokage_Armour
					Colorable=0
					icon='HashiramaC.dmi'
					icon_state=""
					mouse_drag_pointer = ""
					name="Hokage Armour"
					Boosts="+ 8 Defence"
					Def=8
				Hokage_Armour_2
					Colorable=0
					icon='TobiramaC.dmi'
					icon_state=""
					mouse_drag_pointer = ""
					name="New Generation Hokage Armour"
					Boosts="+ 8 Defence"
					Def=8
				AdminRobe
					Colorable=0
					icon='AdminRobe.dmi'
					icon_state=""
					mouse_drag_pointer = ""
					name="Admin Robe"
					Boosts="+ 25 Ninjutsu"
					Nin=25
				Sasuke_Robe
					Colorable=0
					icon='sasukerobe.dmi'
					icon_state=""
					mouse_drag_pointer = ""
					name="Uchiha Robe"
					Boosts="+20 Ninjutsu"
					Nin=20
					Cost=2500
				Orochimaru_Robe
					Colorable=0
					icon='Orochimaru_Robe.dmi'
					icon_state=""
					mouse_drag_pointer = ""
					name="Orochimaru Robe"
					Boosts="+15 Ninjutsu"
					Nin=15
				LeafElderRobe
					Colorable=0
					icon='LeafElderRobe.dmi'
					icon_state=""
					mouse_drag_pointer = ""
					name="Leaf Elder Robe"
					Boosts="+10 Genjutsu"
					Gen=10
				Guardian_Shinobi_Robe
					Colorable=0
					icon='Guardian Shinobi 10.dmi'
					icon_state=""
					mouse_drag_pointer = ""
					name="Guardian Shinobi 10 Robe"
					Boosts="+10 Ninjutsu"
					Nin=10
					Cost=10000
				Genjutsu_Robe
					Colorable=0
					icon='Genjutsu Robe.dmi'
					icon_state=""
					mouse_drag_pointer = ""
					name="Genjutsu Robe"
					Boosts="+10 Genjutsu"
					Gen=10
					Cost=10000
			Sword
				section="Sword"
				Scythe
					Colorable=0
					icon='HidanScythe.dmi'
					icon_state=""
					mouse_drag_pointer = ""
					name="Hidan Sycthe"
					Boosts="+10 Taijutsu"
					Tai=10
				Zabuza_Sword // there WAS a */
					Colorable=0
					icon='Zabuzas Blade.dmi'
					icon_state=""
					mouse_drag_pointer = ""
					name="Kubikiribocho"
					Boosts="+10 Taijutsu"
					Tai=10
				Hiramekarei
					Colorable=0
					icon='7SM Hiramekarei.dmi'
					icon_state=""
					mouse_drag_pointer = ""
					name="Hiramekarei"
					Boosts="+10 Taijutsu"
					Tai=10
				Kabutowari
					Colorable=0
					icon='7SM Kabutowari.dmi'
					icon_state=""
					mouse_drag_pointer = ""
					name="Kabuto Wari"
					Boosts="+10 Taijutsu"
					Tai=10
				Kiba
					Colorable=0
					icon='7SM Kiba.dmi'
					icon_state=""
					mouse_drag_pointer = ""
					name="Kiba"
					Boosts="+10 Taijutsu"
					Tai=10
				Nuibari
					Colorable=0
					icon='7SM Nuibari.dmi'
					icon_state=""
					mouse_drag_pointer = ""
					name="Nuibari"
					Boosts="+10 Taijutsu"
					Tai=10
				Shibuki
					Colorable=0
					icon='7SM Shibuki.dmi'
					icon_state=""
					mouse_drag_pointer = ""
					name="Shibuki"
					Boosts="+10 Taijutsu"
					Tai=10
/*				Samehada
					Colorable=0
					icon='KisameSword.dmi'
					icon_state=""
					mouse_drag_pointer = ""
					name="Samehada"
					Boosts="+10 Taijutsu"
					Tai=10*/
				MizukageStick
					Colorable=0
					icon='MizukageStick.dmi'
					icon_state=""
					mouse_drag_pointer = ""
					name="Mizukage Stick"
					Boosts="+10 Taijutsu"
					Tai=10
				Feudal_Staff
					Colorable=0
					icon='Feudal Scroll.dmi'
					icon_state=""
					mouse_drag_pointer = ""
					name="Feudal Scroll"
					Boosts="+20 Ninjutsu"
					Nin=20
				Sage_Scroll
					Colorable=0
					icon='Sage Scroll.dmi'
					icon_state=""
					mouse_drag_pointer = ""
					name="Sage Scroll"
					Boosts="+15 Ninjutsu"
					Nin=20
				MadaraGunbai
					Colorable=0
					icon='MadaraGunbai.dmi'
					icon_state=""
					mouse_drag_pointer = ""
					name="Madara Warfan"
					Boosts="+10 Taijutsu"
					Tai=10
				HokageStaff
					Colorable=0
					icon='HokageStaff.dmi'
					icon_state=""
					mouse_drag_pointer = ""
					name="Hokage Staff"
					Boosts="+8 Taijutsu"
					Tai=8
				Gourd
					Colorable=0
					icon='Gourd.dmi'
					icon_state=""
					mouse_drag_pointer = ""
					name="Gourd"
					Boosts="+10 Ninjutsu"
					Nin=10 //There WAS a /*
			Accessories
				section="Accessories"
				Bandages
					Colorable=0
					icon='Bandage.dmi'
					icon_state=""
					mouse_drag_pointer = ""
					name="Bandages"
					Boosts="+10 Taijutsu"
					Tai=10
					Cost = 100
					can_purchase = 1
				Weights
					Colorable=0
					icon='Weights.dmi'
					icon_state=""
					mouse_drag_pointer = ""
					name="Weights"
					Boosts="+7 Taijutsu"
					Tai=7
					Cost = 1000
					can_purchase = 1
				Wings
					icon='Wings.dmi'
					icon_state=""
					mouse_drag_pointer = ""
					name="Wings"
					Boosts="+30 Defence"
					Def=30

			Gloves
				section="Gloves"
				AssassinGloves
					Colorable=0
					icon='Assasin gloves.dmi'
					icon_state=""
					mouse_drag_pointer = ""
					name="Assassin Gloves"
					Boosts="+10 Taijutsu"
					Tai=10
					Cost = 2000
				Gloves
					Colorable=0
					icon='gloves.dmi'
					icon_state=""
					mouse_drag_pointer = ""
					name="Shinobi Gloves"
					Boosts="+3 Taijutsu"
					Tai=10
					Cost = 200
					can_purchase = 1



/*
				Click()
					if(get_dist(src,usr)>1) return
					if(!usr.contents.Find(src))
						take(usr)
						return
					if(src in usr)
						if(!usr.Shoes)
							src.equip=1
							var/obj/Shoes2=new
							Shoes2.layer=SHOES_LAYER
							src.suffix="Equipped- [src.Boosts]"
							if(Agil)
								usr.agility+=src.Agil
								usr.MenuUpdate()
							src.layer=SHOES_LAYER
							Shoes2.icon=src.icon
							Shoes2.icon_state=src.icon_state
							usr.Shoes=Shoes2
							usr.overlays+=Shoes2
						else
							src.equip=0
							usr.overlays=0
							usr.Shoes=null
							usr.UpdateHMB()
							usr.SetName(usr.name)
							usr.overlays+=/obj/MaleParts/UnderShade
							usr.RestoreOverlays()
							src.layer=OBJ_LAYER
							src.suffix=""
							if(Agil)
								usr.agility-=src.Agil
*/

//if(src.AnubuMaskWorn)
    //Say Stuff
//else
   //default say stuff
