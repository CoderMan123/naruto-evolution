proc
	Remove_(var/msg)
		var/Nmsg =""
		var/l
		for(var/i=1,i<=length(msg),i++)
			l = copytext(msg,i,i+1)
			if(l != "_" && l != " ")Nmsg += l
		return Nmsg
mob
	var
		items=0
		maxitems=20
		equipped
mob/proc
	itemDrop(obj/o)
		if(o.canStack && o.contents.len)
			var/obj/theItem=pick(o.contents)
			theItem.loc=src.loc
			if(o.contents.len)o.suffix="x[o.contents.len+1]"
			else o.suffix="x1"
		else
			o.loc=src.loc
			src.items-=1
			if(items<=0) items=0
			o.suffix=""
		RefreshInventory()
	itemDelete(obj/o)
		if(o.canStack && o.contents.len)
			var/obj/theItem=pick(o.contents)
			del(theItem)
			if(o.contents.len)o.suffix="x[o.contents.len+1]"
			else o.suffix="x1"
		else
			src.items-=1
			if(items<=0) items=0
			del(o)
		RefreshInventory()
	itemAdd(obj/o)
		var/list/items=list()
		for(var/obj/i in src.contents)items+=i.type
		if(o.type in items) //if a similar item is found in the contents
			if(o.canStack)
				var/obj/theItem
				for(var/obj/i in src.contents) if(i.type == o.type) theItem=i
				if(theItem)
					if(theItem.suffix<>"[o.maxhold]")
						theItem.contents+=o
						theItem.suffix="x[theItem.contents.len+1]"
					else
						src.contents+=o
						o.suffix="x1"
						src.items+=1
				else
					src.contents+=o
					o.suffix="x1"
			else
				src.contents+=o
				src.items+=1
		else
			src.contents+=o
			src.items+=1
			o.suffix="[o.canStack ? "x1" : "[o.suffix]"]"
		RefreshInventory()
obj/RyoBag
	icon='Ryo bills.dmi'
	icon_state="owned"
	name="Ryo"
	var/Worth=0
	DblClick()
		if(get_dist(src,usr)>1) return
		if(!src) return
		var/mob/player/M=usr
		if(M.dead) return
		hearers()<<output("[M] picks up [Worth] [src].","actionoutput")
		M.Ryo+=Worth
		del(src)
mob
	player
		verb
			DropRyo()
				set hidden=1
				if(!usr.Ryo)
					usr << output("You don't have any Ryo to drop.","actionoutput")
					return
				var/Num=usr.skinput2("How much Ryo would you like to drop?","Drop Ryo",null,1)
				if(!isnum(Num))return
				if(usr.Ryo<Num||Num<=0)return
				usr.Ryo-=Num
				var/obj/RyoBag/O=new(src.loc)
				O.Worth=Num
				src << output("You drop [Num] Ryo.","actionoutput")
			Get()
				set hidden=1
				for(var/obj/Inventory/O in view(usr,1))
					if(O in get_step(usr,usr.dir))
						if(O.loc<>usr&&usr.dead==0)
							if(usr.items<usr.maxitems)
								//usr << sound('Sounds/GunMisc/AmmoPUMG.ogg',0,0,7,100)
								//if(istype(O,/obj/Inventory/Clothing))
								//	usr.Clothes+=O
								//	usr.Clothes+=O.type
								//	O.loc=0
								//else
								itemAdd(O)
								break
							else
								usr << sound('Sounds/cant.ogg',0,0,7,100)
								var/random=rand(1,3)
								if(random==1)
									usr << output("<font face=Arial><i>Your inventory is maxed already.","actionoutput")
					else
						if(O in view(usr,1))
							if(O.loc<>usr&&usr.dead==0)
								if(usr.items<usr.maxitems)
									//usr << sound('Sounds/GunMisc/AmmoPUMG.ogg',0,0,7,100)
									//if(istype(O,/obj/Inventory/Clothing))
									//	usr.Clothes.Add(O)
									//	usr.Clothes.Add(O.type)
									//else
									itemAdd(O)
									break
								else
									usr << sound('Sounds/cant.ogg',0,0,7,100)
									var/random=rand(1,3)
									if(random==1)usr << output("<font face=Arial><i>Your inventory is maxed already.","actionoutput")
obj
	var
		canStack=0
		equip=0
		maxhold=1
		Description="No description provided."
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
		//			usr.itemAdd(src)
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
				//if(over_control == "mapwindow.map"&&src_control=="Inventory.InvenInfo")
				if(usr.contents.Find(src)&&!src.equip)
					drop(usr)
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
				usr.itemAdd(src)
				return
			..()
		Weaponry
			canStack=1
			Shuriken
				icon='Shuriken.dmi'
				icon_state="shuriS"
				mouse_drag_pointer = "shuriS"
				density=0
				maxhold="x15"
				Description="It's a sharp pointed throwing star made of a hard steel. It could be deadly if thrown. It looks as though it's worth about 5 Ryo if you were to sell it to a common merchant."
				damage=5
				Cost=5
				Click()
					if(!usr.contents.Find(src)) return
					usr.equipped="Shurikens"
					usr<<sound('083.ogg',0,0)
					for(var/obj/Screen/WeaponSelect/H in usr.client.screen)
						H.icon_state="shuriken"
						var/icon/I = new(src.icon, src.icon_state)
						var/iconfile = fcopy_rsc(I)
						winset(usr, "ItemName", "text='[src.name]'")
						winset(usr, "ItemPic", "image=\ref[iconfile]")
						usr<<output("<center><font size = 2><font color=white><Body BGCOLOR = #2E2E2E>[Description]","ItemInfo")
					//for(var/obj/Inventory/Weaponry/X)
						//X.suffix=""
					//for(var/obj/Inventory/Weaponry/Shuriken/C)
						//C.suffix="Throwing Weapon"
			Needle
				icon='Shuriken.dmi'
				icon_state="needleS"
				mouse_drag_pointer = "needleS"
				density=0
				maxhold="x20"
				Description="A sharp medical precise needle. The tip appears to be extremely sharp, and could cause severe damage to precise points on the human body if thrown, or even applied. It looks as though it's only worth 3 Ryo."
				damage=3
				Cost=3
				Click()
					if(!usr.contents.Find(src)) return
					usr.equipped="Needles"
					usr<<sound('083.ogg',0,0)
					for(var/obj/Screen/WeaponSelect/H in usr.client.screen)
						H.icon_state="needle"
						var/icon/I = new(src.icon, src.icon_state)
						var/iconfile = fcopy_rsc(I)
						winset(usr, "ItemName", "text='[src.name]'")
						winset(usr, "ItemPic", "image=\ref[iconfile]")
						usr<<output("<center><font size = 2><font color=white><Body BGCOLOR = #2E2E2E>[Description]","ItemInfo")
					//for(var/obj/Inventory/Weaponry/X)
					//	X.suffix=""
					//for(var/obj/Inventory/Weaponry/Needle/C)
					//	C.suffix="Throwing Weapon"
			Kunai
				icon='Shuriken.dmi'
				icon_state="kunaiS"
				mouse_drag_pointer = "kunaiS"
				density=0
				maxhold="x10"
				Description="A hard steel field knife. The tip is sharp enough to peirce flesh, as well as many other practical uses in the field. There is a loop at the end for auxillary use, or as a finger grip. It looks to be worth about 7 Ryo."
				damage=10
				Cost=7
				Click()
					if(!usr.contents.Find(src)) return
					usr.equipped="Kunais"
					usr<<sound('083.ogg',0,0)
					for(var/obj/Screen/WeaponSelect/H in usr.client.screen)
						H.icon_state="kunai"
						var/icon/I = new(src.icon, src.icon_state)
						var/iconfile = fcopy_rsc(I)
						winset(usr, "ItemName", "text='[src.name]'")
						winset(usr, "ItemPic", "image=\ref[iconfile]")
						usr<<output("<center><font size = 2><font color=white><Body BGCOLOR = #2E2E2E>[Description]","ItemInfo")
					//for(var/obj/Inventory/Weaponry/X)
					//	X.suffix=""
					//for(var/obj/Inventory/Weaponry/Kunai/C)
					//	C.suffix="Throwing Weapon"
			Exploding_Kunai
				icon='Shuriken.dmi'
				icon_state="kunaist"
				mouse_drag_pointer = "kunaist"
				density=0
				maxhold="x5"
				Cost=10
				Click()
					if(!usr.contents.Find(src)) return
					usr.equipped="ExplodeKunais"
					usr<<sound('083.ogg',0,0)
					for(var/obj/Screen/WeaponSelect/H in usr.client.screen)
						H.icon_state="expl kunai"
						var/icon/I = new(src.icon, src.icon_state)
						var/iconfile = fcopy_rsc(I)
						winset(usr, "ItemName", "text='[src.name]'")
						winset(usr, "ItemPic", "image=\ref[iconfile]")
						usr<<output("<center><font size = 2><font color=white><Body BGCOLOR = #2E2E2E>[Description]","ItemInfo")
					//for(var/obj/Inventory/Weaponry/X)
					//	X.suffix=""
					//for(var/obj/Inventory/Weaponry/Exploding_Kunai/C)
					//	C.suffix="Throwing Weapon"
			Explosive_Tag
				icon='Shuriken.dmi'
				icon_state="tag"
				mouse_drag_pointer = "tag"
				density=0
				maxhold="x5"
				Description="A hard paper-like material embued with kanji markings on the front. It is made with explosive paper, and if one were to embue their chakra into it, they could detonate it at will. It seems to be worth about 5 Ryo."
				damage=40
				Cost=5
				Click()
					if(!usr.contents.Find(src)) return
					usr.equipped="ExplosiveTags"
					usr<<sound('083.ogg',0,0)
					for(var/obj/Screen/WeaponSelect/H in usr.client.screen)
						H.icon_state="tag"
						var/icon/I = new(src.icon, src.icon_state)
						var/iconfile = fcopy_rsc(I)
						winset(usr, "ItemName", "text='[src.name]'")
						winset(usr, "ItemPic", "image=\ref[iconfile]")
						usr<<output("<center><font size = 2><font color=white><Body BGCOLOR = #2E2E2E>[Description]","ItemInfo")
					//for(var/obj/Inventory/Weaponry/X)
					//	X.suffix=""
					//for(var/obj/Inventory/Weaponry/Explosive_Tag/C)
					//	C.suffix="Equipped Weapon"
			Stamina_Pill
				icon='Shuriken.dmi'
				icon_state="spill"
				mouse_drag_pointer = "spill"
				density=0
				maxhold="x5"
				Cost=15
				Click()
					if(!usr.contents.Find(src)) return
					usr.equipped="StaminaPill"
					usr<<sound('083.ogg',0,0)
					for(var/obj/Screen/WeaponSelect/H in usr.client.screen)
						H.icon_state="Blood Pill"
					//for(var/obj/Inventory/Weaponry/X)
					//	X.suffix=""
					//for(var/obj/Inventory/Weaponry/Stamina_Pill/C)
					//	C.suffix="Equipped Pill"
			Chakra_Pill
				icon='Shuriken.dmi'
				icon_state="cpill"
				mouse_drag_pointer = "cpill"
				density=0
				maxhold="x5"
				Cost=15
				Click()
					if(!usr.contents.Find(src)) return
					usr.equipped="ChakraPill"
					usr<<sound('083.ogg',0,0)
					for(var/obj/Screen/WeaponSelect/H in usr.client.screen)
						H.icon_state="Chakra Pill"
					//for(var/obj/Inventory/Weaponry/X)
					//	X.suffix=""
					//for(var/obj/Inventory/Weaponry/Stamina_Pill/C)
					//	C.suffix="Equipped Pill"
			Smoke_Bomb
				icon='Shuriken.dmi'
				icon_state="sbomb"
				mouse_drag_pointer = "sbomb"
				density=0
				maxhold="x5"
				Description="A darkened sphere, containing large condensed amounts of gas. It is wired to a pressure activation system, and could be useful to make a quick escape if thrown. It seems to be worth about 5 Ryou."
				Cost=5
				Click()
					if(!usr.contents.Find(src)) return
					usr.equipped="SmokeBombs"
					usr<<sound('083.ogg',0,0)
					for(var/obj/Screen/WeaponSelect/H in usr.client.screen)H.icon_state="smoke bomb"
					var/icon/I = new(src.icon, src.icon_state)
					var/iconfile = fcopy_rsc(I)
					winset(usr, "ItemName", "text='[src.name]'")
					winset(usr, "ItemPic", "image=\ref[iconfile]")
					usr<<output("<center><font size = 2><font color=white><Body BGCOLOR = #2E2E2E>[Description]","ItemInfo")
					//for(var/obj/Inventory/Weaponry/X)
					//	X.suffix=""
					//for(var/obj/Inventory/Weaponry/Stamina_Pill/C)
					//	C.suffix="Equipped Pill"
