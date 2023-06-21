proc
	Remove_(var/msg)
		var/Nmsg =""
		var/l
		for(var/i=1,i<=length(msg),i++)
			l = copytext(msg,i,i+1)
			if(l != "_" && l != " ")Nmsg += l
		return Nmsg

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
				usr.RecieveItem(src, usr.loc)
				usr.client.UpdateInventoryPanel()
				return
			..()

		Weaponry
			Click(var/mob/owner)
				..()
				if(ismob(owner)) usr = owner
				var/icon/I = new(src.icon, src.icon_state)
				var/iconfile = fcopy_rsc(I)
				winset(usr, "Inventory.EquippedName", "text='[src.name]'")
				winset(usr, "Inventory.EquippedImage", "image=\ref[iconfile]")
				usr<<output(null, "Inventory.EquippedItemInfo")
				usr<<output("<center>[Description]", "Inventory.EquippedItemInfo")

			Shuriken
				name="Shuriken"
				icon='Shuriken.dmi'
				icon_state="shuriS"
				mouse_drag_pointer = "shuriS"
				density=0
				max_stacks=10000
				Description="It's a sharp pointed throwing star made of a hard steel. It could be deadly if thrown. It looks as though it's worth about 5 Ryo if you were to sell it to a common merchant."
				damage=0
				Cost=5
				can_purchase = 1
				Click()
					..()
					if(!usr.contents.Find(src)) return
					usr.equipped="Shurikens"
					usr.PlayAudio('083.wav')
					for(var/obj/Screen/WeaponSelect/H in usr.client.screen)
						H.icon_state="shuriken"

			Needle
				name = "Throwing Needle"
				icon='Shuriken.dmi'
				icon_state="needleS"
				mouse_drag_pointer = "needleS"
				density=0
				max_stacks=10000
				Description="A sharp medical precise needle. The tip appears to be extremely sharp, and could cause severe damage to precise points on the human body if thrown, or even applied. It looks as though it's only worth 3 Ryo."
				damage=0
				Cost=3
				can_purchase = 1
				Click()
					..()
					if(!usr.contents.Find(src)) return
					usr.equipped="Needles"
					usr.PlayAudio('083.wav')
					for(var/obj/Screen/WeaponSelect/H in usr.client.screen)
						H.icon_state="needle"

			Kunai
				name = "Kunai"
				icon='Shuriken.dmi'
				icon_state="kunaiS"
				mouse_drag_pointer = "kunaiS"
				density=0
				max_stacks=10000
				Description="A hard steel field knife. The tip is sharp enough to peirce flesh, as well as many other practical uses in the field. There is a loop at the end for auxillary use, or as a finger grip. It looks to be worth about 7 Ryo."
				damage=0
				Cost=7
				can_purchase = 1
				Click()
					..()
					if(!usr.contents.Find(src)) return
					usr.equipped="Kunais"
					usr.PlayAudio('083.wav')
					for(var/obj/Screen/WeaponSelect/H in usr.client.screen)
						H.icon_state="kunai"

			Exploding_Kunai
				name = "Exploding Kunai"
				icon='Shuriken.dmi'
				icon_state="kunaist"
				mouse_drag_pointer = "kunaist"
				density=1
				max_stacks=10000
				Cost=10
				can_purchase = 1
				Click()
					..()
					if(!usr.contents.Find(src)) return
					usr.equipped="ExplodeKunais"
					usr.PlayAudio('083.wav')
					for(var/obj/Screen/WeaponSelect/H in usr.client.screen)
						H.icon_state="expl kunai"

			Explosive_Tag
				name ="Explosive Tag"
				icon='Shuriken.dmi'
				icon_state="tag"
				mouse_drag_pointer = "tag"
				density=0
				max_stacks=10000
				Description="A paper-like material embued with kanji markings on the front. It is made with explosive paper, and if one were to embue their chakra into it, they could detonate it at will. It seems to be worth about 5 Ryo."
				damage=0
				Cost=8
				can_purchase = 1
				Click()
					..()
					if(!usr.contents.Find(src)) return
					usr.equipped="ExplosiveTags"
					usr.PlayAudio('083.wav')
					for(var/obj/Screen/WeaponSelect/H in usr.client.screen)
						H.icon_state="tag"

			Food_Pill
				icon='Shuriken.dmi'
				icon_state="spill"
				mouse_drag_pointer = "spill"
				density=0
				max_stacks=10000
				Cost=500
				Description="A small pill that tastes pretty gross. When consumed it energizes your body increasing your health regeneration for 20 seconds."
				can_purchase = 1
				Click()
					..()
					if(!usr.contents.Find(src)) return
					usr.equipped="FoodPill"
					usr.PlayAudio('083.wav')
					for(var/obj/Screen/WeaponSelect/H in usr.client.screen)
						H.icon_state="Blood Pill"

/*
			Chakra_Pill
				icon='Shuriken.dmi'
				icon_state="cpill"
				mouse_drag_pointer = "cpill"
				density=0
				max_stacks=100
				Cost=15000
				var/lol=0
				Click()
					..()
					if(!usr.contents.Find(src)) return
					if(lol==1)
						usr.health-=round(usr.maxchakra/2)
						usr.equipped=null
						lol=0
						del(src)
						return
					usr.equipped="ChakraPill"
					usr.client.PlayAudio('083.wav')
					usr.chakra+=round(usr.maxchakra/6)
					lol=1
					for(var/obj/Screen/WeaponSelect/H in usr.client.screen)
						H.icon_state="Chakra Pill"
					spawn(300)
						usr.health-=round(usr.maxchakra/4)
						for(var/obj/Screen/WeaponSelect/H in usr.client.screen)
							H.icon_state=null
						del(src)
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
				can_purchase = 1
				Click()
					..()
					if(!usr.contents.Find(src)) return
					usr.equipped="SmokeBombs"
					usr.PlayAudio('083.wav')
					for(var/obj/Screen/WeaponSelect/H in usr.client.screen)
						H.icon_state="SmokeBombs"

			MadaraFan
				Description="THIS ITEM WILL BE SOON CHANGED  -Vik"
				icon='MadaraFan.dmi'
				Click()
					..()
					if(!usr.contents.Find(src)) return
					if(usr.usedwepboost==0)
						usr.equipped="MadaraFan"
						usr.usedwepboost=1
						usr.agility+=60
						usr.taijutsu+=30
						usr.overlays+='MadaraFan.dmi'
						if(usr.agility<120)
							usr.attkspeed--
						else
							return
					else
						usr.equipped=null
						usr.usedwepboost=0
						usr.agility-=60
						usr.taijutsu-=30
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
					..()
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
					..()
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
					..()
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
					..()
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
					..()
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
					..()
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
					..()
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
					..()
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
				can_purchase = 1
				Click()
					..()
					if(!usr.contents.Find(src)) return
					if(usr.usedwep1==0)
						usr.equipped="Weights"
						usr.usedwep1=1
						usr.overlays+='Weights.dmi'
						usr.move_delay = 1
					else
						usr.equipped=null
						usr.usedwep1=0
						usr.overlays-='Weights.dmi'
						usr.move_delay = max(0.5, 0.8-((usr.agility/200)*0.3))

mob
	var
		usedwep1=0
		usedwep2=0
		usedwepboost=0
		equiza=0
		equisa=0
