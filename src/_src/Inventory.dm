proc
	Remove_(var/msg)
		var/Nmsg =""
		var/l
		for(var/i=1,i<=length(msg),i++)
			l = copytext(msg,i,i+1)
			if(l != "_" && l != " ")Nmsg += l
		return Nmsg

obj/RyoBag
	icon='Ryo bills.dmi'
	icon_state="owned"
	name="Ryo"
	var/Worth=0
	DblClick()
		if(get_dist(src,usr)>1) return
		if(!src) return
		var/mob/M=usr
		if(M.dead) return
		hearers()<<output("[M] picks up [Worth] [src].","Action.Output")
		M.Ryo+=Worth
		del(src)
mob
	verb
		DropRyo()
			set hidden=1
			if(!usr.Ryo)
				usr << output("You don't have any Ryo to drop.","Action.Output")
				return
			var/list/AlertInput=usr.client.AlertInput("How much Ryo would you like to drop?","Drop Ryo")
			if(!isnum(AlertInput[2]))return
			if(usr.Ryo<AlertInput[2]||AlertInput[2]<=0)return
			usr.Ryo-=AlertInput[2]
			var/obj/RyoBag/O=new(src.loc)
			O.Worth=AlertInput[2]
			src.client.UpdateInventoryPanel()
			src << output("You drop [AlertInput[2]] Ryo.","Action.Output")

obj
	Inventory
		mouse_opacity=2
		//verb
		//	Get()
		//		set src in view(usr,0)
		//		set category=null
		//		if(usr.items<usr.maxitems)
		//			//if(istype(src,/obj/Inventory/Clothing))
		//			//	usr.Clothes.Add(src)
		//			//	usr.Clothes.Add(src.type)
		//			//else
		//			usr.RecieveItem(src)
		//			src.client.UpdateInventoryPanel()
		//	Drop()
		//		set src in usr.contents
		//		set category=null
		//		if(!src.equip)
		//			//if(istype(src,/obj/Inventory/Clothing))
		//			//	usr.Clothes.Remove(src)
		//			//	usr.Clothes.Remove(src.type)
		//			//	src.loc=usr.loc
		//			//else
		//			usr.itemDrop(src)
		//		else
		//			usr<<"<font face=Times New Roman><b>[src] is still equipped."
		DblClick()
			//Get
			if(get_dist(usr,src)<=1)
				//if(over_control == "Map.map"&&src_control=="Inventory.InvenInfo")
				if(usr.contents.Find(src)&&!src.equip)
					src.Drop(usr)
					return
//			if(usr.contents.Find(src))
//				if(!src.equip)
					//if(istype(src,/obj/Inventory/Clothing))
					//	usr.Clothes.Remove(src)
					//	usr.Clothes.Remove(src.type)
					//	src.loc=usr.loc
					//else
//					usr.itemDrop(src)
//				else
//					usr<<"<font face=Times New Roman><b>[src] is still equipped."
//				return
			if(get_dist(src,usr)>1) return
			if(usr.items<usr.maxitems)
					//if(istype(src,/obj/Inventory/Clothing))
					//	usr.Clothes.Add(src)
					//	usr.Clothes.Add(src.type)
					//else
				usr.RecieveItem(src)
				usr.client.UpdateInventoryPanel()
				return
			..()
		Weaponry
			Shuriken
				name="Shuriken"
				icon='Shuriken.dmi'
				icon_state="shuriS"
				mouse_drag_pointer = "shuriS"
				density=0
				max_stacks=10000
				Description="It's a sharp pointed throwing star made of a hard steel. It could be deadly if thrown. It looks as though it's worth about 5 Ryo if you were to sell it to a common merchant."
				damage=5
				Cost=5
				Click()
					if(!usr.contents.Find(src)) return
					usr.equipped="Shurikens"
					usr<<sound('083.wav',0,0)
					for(var/obj/Screen/WeaponSelect/H in usr.client.screen)
						H.icon_state="shuriken"
						var/icon/I = new(src.icon, src.icon_state)
						var/iconfile = fcopy_rsc(I)
						winset(usr, "Inventory.EquippedName", "text='[src.name]'")
						winset(usr, "Inventory.EquippedImage", "image=\ref[iconfile]")
						usr<<output("<center>[Description]","Inventory.EquippedItemInfo")
					//for(var/obj/Inventory/Weaponry/X)
						//X.suffix=""
					//for(var/obj/Inventory/Weaponry/Shuriken/C)
						//C.suffix="Throwing Weapon"
			Needle
				name = "Throwing Needle"
				icon='Shuriken.dmi'
				icon_state="needleS"
				mouse_drag_pointer = "needleS"
				density=0
				max_stacks=10000
				Description="A sharp medical precise needle. The tip appears to be extremely sharp, and could cause severe damage to precise points on the human body if thrown, or even applied. It looks as though it's only worth 3 Ryo."
				damage=3
				Cost=3
				Click()
					if(!usr.contents.Find(src)) return
					usr.equipped="Needles"
					usr<<sound('083.wav',0,0)
					for(var/obj/Screen/WeaponSelect/H in usr.client.screen)
						H.icon_state="needle"
						var/icon/I = new(src.icon, src.icon_state)
						var/iconfile = fcopy_rsc(I)
						winset(usr, "Inventory.EquippedName", "text='[src.name]'")
						winset(usr, "Inventory.EquippedImage", "image=\ref[iconfile]")
						usr<<output("<center>[Description]","Inventory.EquippedItemInfo")
					//for(var/obj/Inventory/Weaponry/X)
					//	X.suffix=""
					//for(var/obj/Inventory/Weaponry/Needle/C)
					//	C.suffix="Throwing Weapon"
			Kunai
				name = "Kunai"
				icon='Shuriken.dmi'
				icon_state="kunaiS"
				mouse_drag_pointer = "kunaiS"
				density=0
				max_stacks=10000
				Description="A hard steel field knife. The tip is sharp enough to peirce flesh, as well as many other practical uses in the field. There is a loop at the end for auxillary use, or as a finger grip. It looks to be worth about 7 Ryo."
				damage=10
				Cost=7
				Click()
					if(!usr.contents.Find(src)) return
					usr.equipped="Kunais"
					usr<<sound('083.wav',0,0)
					for(var/obj/Screen/WeaponSelect/H in usr.client.screen)
						H.icon_state="kunai"
						var/icon/I = new(src.icon, src.icon_state)
						var/iconfile = fcopy_rsc(I)
						winset(usr, "Inventory.EquippedName", "text='[src.name]'")
						winset(usr, "Inventory.EquippedImage", "image=\ref[iconfile]")
						usr<<output("<center>[Description]","Inventory.EquippedItemInfo")
					//for(var/obj/Inventory/Weaponry/X)
					//	X.suffix=""
					//for(var/obj/Inventory/Weaponry/Kunai/C)
					//	C.suffix="Throwing Weapon"
			Exploding_Kunai
				name = "Exploding Kunai"
				icon='Shuriken.dmi'
				icon_state="kunaist"
				mouse_drag_pointer = "kunaist"
				density=0
				max_stacks=10000
				Cost=10
				Click()
					if(!usr.contents.Find(src)) return
					usr.equipped="ExplodeKunais"
					usr<<sound('083.wav',0,0)
					for(var/obj/Screen/WeaponSelect/H in usr.client.screen)
						H.icon_state="expl kunai"
						var/icon/I = new(src.icon, src.icon_state)
						var/iconfile = fcopy_rsc(I)
						winset(usr, "Inventory.EquippedName", "text='[src.name]'")
						winset(usr, "Inventory.EquippedImage", "image=\ref[iconfile]")
						usr<<output("<center>[Description]","Inventory.EquippedItemInfo")
					//for(var/obj/Inventory/Weaponry/X)
					//	X.suffix=""
					//for(var/obj/Inventory/Weaponry/Exploding_Kunai/C)
					//	C.suffix="Throwing Weapon"
			Explosive_Tag
				name ="Explosive Tag"
				icon='Shuriken.dmi'
				icon_state="tag"
				mouse_drag_pointer = "tag"
				density=0
				max_stacks=10000
				Description="A hard paper-like material embued with kanji markings on the front. It is made with explosive paper, and if one were to embue their chakra into it, they could detonate it at will. It seems to be worth about 5 Ryo."
				damage=40
				Cost=5
				Click()
					if(!usr.contents.Find(src)) return
					usr.equipped="ExplosiveTags"
					usr<<sound('083.wav',0,0)
					for(var/obj/Screen/WeaponSelect/H in usr.client.screen)
						H.icon_state="tag"
						var/icon/I = new(src.icon, src.icon_state)
						var/iconfile = fcopy_rsc(I)
						winset(usr, "Inventory.EquippedName", "text='[src.name]'")
						winset(usr, "Inventory.EquippedImage", "image=\ref[iconfile]")
						usr<<output("<center>[Description]","Inventory.EquippedItemInfo")
					//for(var/obj/Inventory/Weaponry/X)
					//	X.suffix=""
					//for(var/obj/Inventory/Weaponry/Explosive_Tag/C)
					//	C.suffix="Equipped Weapon"
			/*
			Stamina_Pill
				icon='Shuriken.dmi'
				icon_state="spill"
				mouse_drag_pointer = "spill"
				density=0
				max_stacks=100
				Cost=15000
				var/lol=0
				Click()
					if(!usr.contents.Find(src)) return
					if(lol==1)
						usr.health-=round(usr.maxhealth/2)
						usr.equipped=null
						lol=0
						del(src)
						return
					usr.equipped="StaminaPill"
					usr<<sound('083.wav',0,0)
					usr.health+=round(usr.maxhealth/6)
					lol=1
					for(var/obj/Screen/WeaponSelect/H in usr.client.screen)
						H.icon_state="Blood Pill"
					spawn(300)
						usr.health-=round(usr.maxhealth/4)
						for(var/obj/Screen/WeaponSelect/H in usr.client.screen)
							H.icon_state=null
						del(src)
					//for(var/obj/Inventory/Weaponry/X)
					//	X.suffix=""
					//for(var/obj/Inventory/Weaponry/Stamina_Pill/C)
					//	C.suffix="Equipped Pill"
			Chakra_Pill
				icon='Shuriken.dmi'
				icon_state="cpill"
				mouse_drag_pointer = "cpill"
				density=0
				max_stacks=100
				Cost=15000
				var/lol=0
				Click()
					if(!usr.contents.Find(src)) return
					if(lol==1)
						usr.health-=round(usr.maxchakra/2)
						usr.equipped=null
						lol=0
						del(src)
						return
					usr.equipped="ChakraPill"
					usr<<sound('083.wav',0,0)
					usr.chakra+=round(usr.maxchakra/6)
					lol=1
					for(var/obj/Screen/WeaponSelect/H in usr.client.screen)
						H.icon_state="Chakra Pill"
					spawn(300)
						usr.health-=round(usr.maxchakra/4)
						for(var/obj/Screen/WeaponSelect/H in usr.client.screen)
							H.icon_state=null
						del(src)
					//for(var/obj/Inventory/Weaponry/X)
					//	X.suffix=""
					//for(var/obj/Inventory/Weaponry/Stamina_Pill/C)
					//	C.suffix="Equipped Pill"
				*/
			Smoke_Bomb
				name = "Smoke Bomb"
				icon='Shuriken.dmi'
				icon_state="sbomb"
				mouse_drag_pointer = "sbomb"
				density=0
				max_stacks=10000
				Description="A darkened sphere, containing large condensed amounts of gas. It is wired to a pressure activation system, and could be useful to make a quick escape if thrown. It seems to be worth about 5 Ryo."
				Cost=5
				Click()
					if(!usr.contents.Find(src)) return
					usr.equipped="SmokeBombs"
					usr<<sound('083.wav',0,0)
					for(var/obj/Screen/WeaponSelect/H in usr.client.screen)H.icon_state="smoke bomb"
					var/icon/I = new(src.icon, src.icon_state)
					var/iconfile = fcopy_rsc(I)
					winset(usr, "Inventory.EquippedName", "text='[src.name]'")
					winset(usr, "Inventory.EquippedImage", "image=\ref[iconfile]")
					usr<<output("<center>[Description]","Inventory.EquippedItemInfo")
					//for(var/obj/Inventory/Weaponry/X)
					//	X.suffix=""
					//for(var/obj/Inventory/Weaponry/Stamina_Pill/C)
					//	C.suffix="Equipped Pill"
			MadaraFan
				Description="THIS ITEM WILL BE SOON CHANGED  -Vik"
				icon='MadaraFan.dmi'
				Click()
					if(!usr.contents.Find(src)) return
					usr<<output("<center>[Description]","Inventory.EquippedItemInfo")
					if(usr.usedwepboost==0)
						usr.equipped="MadaraFan"
						usr.usedwepboost=1
						usr.agility+=60
						usr.strength+=30
						usr.overlays+='MadaraFan.dmi'
						if(usr.agility<120)
							usr.attkspeed--
						else
							return
					else
						usr.equipped=null
						usr.usedwepboost=0
						usr.agility-=60
						usr.strength-=30
						usr.overlays-='MadaraFan.dmi'
						if(usr.agility<120)
							usr.attkspeed++
						else
							return//obj/Inventory/Weaponry/Katana


			DarkSword
				icon='DarkSword.dmi'
				icon_state="standing"
				mouse_drag_pointer = "standing"
				density=0
				Description="Dark Sword. A legendary sword of the Dark Shinobi."
				Cost=5000
				Click()
					if(!usr.contents.Find(src)) return
					if(usr.usedwep2==0)
						usr.equipped="Dark Sword"
						usr.usedwep2=1
						usr.overlays+='DarkSword.dmi'
					else
						usr.equipped=null
						usr.usedwep2=0
						usr.overlays-='DarkSword.dmi'
			Samehada
				name ="Samehada"
				icon='7SM Samehada.dmi'
				icon_state=""
				mouse_drag_pointer = ""
				density=0
				Description="Samehada. A legendary sword of the Seven Swordsmen"
				Cost=5000
				Click()
					if(!usr.contents.Find(src)) return
					if(usr.usedwep1==0)
						usr.equipped="Samehada"
						usr.usedwep1=1
						usr.overlays+='7SM Samehada.dmi'
					else
						usr.equipped=null
						usr.usedwep1=0
						usr.overlays-='7SM Samehada.dmi'

			Zabuza_Sword
				name ="Kubikiribocho"
				icon='Zabuzas Blade.dmi'
				icon_state=""
				mouse_drag_pointer = ""
				density=0
				Description="Kubukiribocho. A legendary sword of the Seven Swordsmen."
				Cost=5000
				Click()
					if(!usr.contents.Find(src)) return
					if(usr.usedwep2==0)
						usr.equipped="Kubikiribocho"
						usr.usedwep2=1
						usr.overlays+='Zabuzas Blade.dmi'
					else
						usr.equipped=null
						usr.usedwep2=0
						usr.overlays-='Zabuzas Blade.dmi'
			Hiramekarei
				name ="Hiramekarei"
				icon='7SM Hiramekarei.dmi'
				icon_state=""
				mouse_drag_pointer = ""
				density=0
				Description="Hiramekarei. A legendary sword of the Seven Swordsmen"
				Cost=5000
				Click()
					if(!usr.contents.Find(src)) return
					if(usr.usedwep1==0)
						usr.equipped="Hiramekarei"
						usr.usedwep1=1
						usr.overlays+='7SM Hiramekarei.dmi'
					else
						usr.equipped=null
						usr.usedwep1=0
						usr.overlays-='7SM Hiramekarei.dmi'
			Kabutowari
				name ="Kabuto Wari"
				icon='7SM Kabutowari.dmi'
				icon_state=""
				mouse_drag_pointer = ""
				density=0
				Description="Kabuto Wari. A legendary sword of the Seven Swordsmen."
				Cost=5000
				Click()
					if(!usr.contents.Find(src)) return
					if(usr.usedwep2==0)
						usr.equipped="Kabuto Wari"
						usr.usedwep2=1
						usr.overlays+='7SM Kabutowari.dmi'
					else
						usr.equipped=null
						usr.usedwep2=0
						usr.overlays-='7SM Kabutowari.dmi'
			Kiba
				name ="Kiba"
				icon='7SM Kiba.dmi'
				icon_state=""
				mouse_drag_pointer = ""
				density=0
				Description="Kiba. A legendary sword of the Seven Swordsmen"
				Cost=5000
				Click()
					if(!usr.contents.Find(src)) return
					if(usr.usedwep1==0)
						usr.equipped="Kiba"
						usr.usedwep1=1
						usr.overlays+='7SM Kiba.dmi'
					else
						usr.equipped=null
						usr.usedwep1=0
						usr.overlays-='7SM Kiba.dmi'

			Nuibari
				name ="Nuibari"
				icon='7SM Nuibari.dmi'
				icon_state=""
				mouse_drag_pointer = ""
				density=0
				Description="Nuibari. A legendary sword of the Seven Swordsmen."
				Cost=5000
				Click()
					if(!usr.contents.Find(src)) return
					if(usr.usedwep2==0)
						usr.equipped="Nuibari"
						usr.usedwep2=1
						usr.overlays+='7SM Nuibari.dmi'
					else
						usr.equipped=null
						usr.usedwep2=0
						usr.overlays-='7SM Nuibari.dmi'
			Shibuki
				name ="Shibuki"
				icon='7SM Shibuki.dmi'
				icon_state=""
				mouse_drag_pointer = ""
				density=0
				Description="Shibuki. A legendary sword of the Seven Swordsmen"
				Cost=5000
				Click()
					if(!usr.contents.Find(src)) return
					if(usr.usedwep1==0)
						usr.equipped="Shibuki"
						usr.usedwep1=1
						usr.overlays+='7SM Shibuki.dmi'
					else
						usr.equipped=null
						usr.usedwep1=0
						usr.overlays-='7SM Shibuki.dmi'
			Weights
				name ="Weights"
				icon='Weights.dmi'
				icon_state=""
				mouse_drag_pointer = ""
				density=0
				Description="Weights. Training weights used to raise ones own Agi."
				Cost = 1000
				Click()
					if(!usr.contents.Find(src)) return
					if(usr.usedwep1==0)
						usr.equipped="Weights"
						usr.usedwep1=1
						usr.overlays+='Weights.dmi'
					else
						usr.equipped=null
						usr.usedwep1=0
						usr.overlays-='Weights.dmi'

mob
	var
		usedwep1=0
		usedwep2=0
		usedwepboost=0
		equiza=0
		equisa=0
