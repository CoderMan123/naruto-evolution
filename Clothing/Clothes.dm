mob/var/list/ClothingOverlays = list("Vest"=null,"Shirt"=null,"Pants"=null,"Shoes"=null,"Mask"=null,"Headband"=null)
//penis penis penis penis penis penis
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
			var/obj/HAIR/H=new
			if(!HairColorStyle)
				var/icon/I = new(HairStyle)
			//	H.icon=src.HairStyle
				I.Blend(rgb(HairColorRed,HairColorGreen,HairColorBlue),ICON_ADD)
				H.icon=I
				HairColorStyle=I
			H.icon=HairColorStyle
			H.layer=src.layer
			src.overlays+=H
		AddSection("Shoes", src.ClothingOverlays["Shoes"])
		AddSection("Pants", src.ClothingOverlays["Pants"])
		AddSection("Shirt", src.ClothingOverlays["Shirt"])
		AddSection("Vest", src.ClothingOverlays["Vest"])
		AddSection("Mask", src.ClothingOverlays["Mask"])
		AddSection("Headband", src.ClothingOverlays["Headband"])

mob/var/tmp/HairColorStyle
var/const
	HAIR_LAYER = FLOAT_LAYER-1
	VEST_LAYER = FLOAT_LAYER-3
	SHIRT_LAYER = MOB_LAYER+1
	PANTS_LAYER = FLOAT_LAYER-5
	SHOES_LAYER = FLOAT_LAYER-6
	MASK_LAYER = HAIR_LAYER+2
	HEADBAND_LAYER = HAIR_LAYER+1

obj/proc/take(mob/M)
	if(M.dead)
		M<<output("You're dead.","actionoutput")
		return
	hearers()<<output("[M] picks up [src].","actionoutput")
	M.itemAdd(src)
obj/proc/drop(mob/M)
	if(usr.dead) return
	M.itemDrop(src)
	hearers()<<output("[M] drops [src].","actionoutput")
mob
	var
		Mask
		HeadWrap
		Helm
		Shirt
		Vest
		Pants
		Shoes
		//list/Clothes

obj
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
		Clothing
			Hengable=1
			MouseDrop(over_object=src,src_location,over_location, src_control,over_control,params)
			//Get
				if(usr.ClothingOverlays[section]==src.icon) return
				if(get_dist(usr,src)<=1)
					//if(over_control == "mapwindow.map"&&src_control=="Inventory.InvenInfo")
					if(usr.contents.Find(src))
						drop(usr)
						return
			Click()
				if(get_dist(src,usr)>1) return
				if(!usr.contents.Find(src))
					take(usr)
					return
				if(src in usr)
					if(!usr.ClothingOverlays[section])
						Wear()
					else
						Remove()
				usr.RefreshInventory()
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
					Cost=35
			HeadWrap
				section="Headband"
				HeadBand
					icon='HeadBand.dmi'
					icon_state=""
					mouse_drag_pointer = ""
					name="Headband"
					Boosts="+ 2 Defence"
					Def=2
					Cost=10
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
				Robe
					Colorable=1
					icon='Robe.dmi'
					icon_state=""
					mouse_drag_pointer = ""
					name="Robe"
					Boosts="+ 4 Defence"
					Cost=100
					Def=4
				Santa_Robe
					Colorable=0
					icon='SantaRobe.dmi'
					icon_state=""
					mouse_drag_pointer = ""
					name="Santa's Robe"
					Boosts="+ 12 Defence"
					Cost=100
					Def=12
				Green_Robe
					Colorable=0
					icon='Haku yut robe.dmi'
					icon_state=""
					mouse_drag_pointer = ""
					name="Green Robe"
					Boosts="+ 6 Defence"
					Cost=100
					Def=6
				HokageRobe
					Colorable=0
					icon='Hokage Robe.dmi'
					icon_state=""
					mouse_drag_pointer = ""
					name="Hokage Robe"
					Boosts="+ 15 Defence"
					Def=15
				KazekageRobe
					Colorable=0
					icon='Kazekage Robe.dmi'
					icon_state=""
					mouse_drag_pointer = ""
					name="Kazekage Robe"
					Boosts="+ 15 Defence"
					Def=15
			Shirt
				section="Shirt"
				Akatsuki_Robe
					Colorable=0
					icon='Akatsuki Robe.dmi'
					icon_state=""
					mouse_drag_pointer = ""
					name="Akatsuki Robe"
					Boosts="+ 7 Defence"
					Cost=100
					Def=7
				Shirt
					icon='Shirt.dmi'
					icon_state=""
					mouse_drag_pointer = ""
					name="Short Sleeve Shirt"
					Boosts="+ 2 Defence"
					Cost=25
					Def=2
			Pants
				section="Pants"
				Pants
					icon='Pants.dmi'
					icon_state=""
					mouse_drag_pointer = ""
					name="Shorts"
					Boosts="+ 2 Defence"
					Def=2
					Cost=25
			Shoes
				section="Shoes"
				Sandals
					icon='Sandals.dmi'
					icon_state="Test"
					mouse_drag_pointer = ""
					name="Sandals"
					Boosts="+ 2 Agility"
					Agil=2
					Cost=15



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
							usr.Name(usr.name)
							usr.overlays+=/obj/MaleParts/UnderShade
							usr.RestoreOverlays()
							src.layer=OBJ_LAYER
							src.suffix=""
							if(Agil)
								usr.agility-=src.Agil
*/