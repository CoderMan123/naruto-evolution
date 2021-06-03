obj/var/Colorable=1
mob/npc
	New()
		NewStuff()
		..()
	layer=MOB_LAYER
	move=0
	var/list/OriginalOverlays=list()
//	New()
//		spawn() Stuff()
//		src.overlays += pick('Short.dmi','Short2.dmi','Short3.dmi')
//		src.overlays+='Shirt.dmi'
//		src.overlays+='Sandals.dmi'
//		OriginalOverlays=overlays
//		..()
	Death()return
	Move()return
	proc/Stuff()
		spawn(20)
			while(src)
				if(OriginalOverlays.len) overlays=OriginalOverlays.Copy()
				icon_state=""
				sleep(10)
	Hair_Stylist
		name="Barber"
		density=0
		NewStuff()
			src.overlays += pick('Short.dmi','Short2.dmi','Short3.dmi')
			src.overlays+='Shirt.dmi'
			src.overlays+='Sandals.dmi'
			OriginalOverlays=overlays.Copy()
			src.SetName(src.name)
			spawn() Stuff()
			..()
		icon='WhiteMBase.dmi'
		pixel_x=-15
		DblClick()
			if(usr.dead) return
			if(get_dist(src,usr)>2) return
			usr.HairStyle = usr.CustomInput("Hair Options","Please choose a hair.",list("Long","Short","Tied Back","Bald","Bowl Cut","Deidara","Spikey","Mohawk","Neji Hair","Distance")).name

			if(usr.HairStyle != "Bald")
				var/list/Colors=usr.ColorInput("Please select a hair color.")
				usr.HairColorRed=text2num(Colors[1])
				usr.HairColorGreen=text2num(Colors[2])
				usr.HairColorBlue=text2num(Colors[3])

			/*
			var/list/Colors=usr.ColorInput("Please select a hair color.")
			usr.HairColorRed=text2num(Colors[1])
			usr.HairColorGreen=text2num(Colors[2])
			usr.HairColorBlue=text2num(Colors[3])
			*/
			usr.HairColorStyle=null
			usr.RestoreOverlays()
	Clothier
		icon='WhiteMBase.dmi'
		pixel_x=-15
		density=0
		NewStuff()
			src.overlays += pick('Short.dmi','Short2.dmi','Short3.dmi')
			src.overlays+='Shirt.dmi'
			src.overlays+='Sandals.dmi'
			OriginalOverlays=overlays.Copy()
			src.SetName(src.name)
			spawn() Stuff()
			..()
		DblClick()
			if(usr.dead) return
			if(get_dist(src,usr)>2) return
			var/newitems=usr.items+1
			if(usr.maxitems > -1 && usr.contents.len >= usr.maxitems)
				usr<<output("This would exceed your amount of avaliable items.","Action.Output")
				return
			usr.move=0
			var/list/Options=list()
			for(var/obj/Inventory/Clothing/C in world)
				if(C.loc==locate(199,199,12)) Options["[C.name]-[C.Cost] Ryo"]=C
			var/obj/Choice = usr.CustomInput("Purchase","What would you like to purchase?",Options + "Cancel",0)
			if(Choice.name=="Cancel")
				usr.move=1
				return
			var/obj/S = Options["[Choice]"]
			if(usr.Ryo>=S.Cost)
				var/obj/I=new S.type()
				if(I.Colorable)
					var/list/Colors=usr.ColorInput("What colour would you like the [I] to be?")
					var/icon/X=new(I.icon)
					X.Blend(rgb(text2num(Colors[1]),text2num(Colors[2]),text2num(Colors[3])),ICON_ADD)
					I.icon=X
					I.cColor = rgb(text2num(Colors[1]),text2num(Colors[2]),text2num(Colors[3]))
				usr.RecieveItem(I)
				usr.client.UpdateInventoryPanel()
				usr<<output("You bought the [S.name] for [S.Cost] Ryo.","Action.Output")
				usr.Ryo-=S.Cost
				usr.move=1
			else
				usr.move=1
				usr<<output("You need [S.Cost] Ryo to purchase this.","Action.Output")
				return
				//obj/Inventory/Clothing/Vests/Robe
	Weapons_Dealer
		icon='WhiteMBase.dmi'
		pixel_x=-15
		density=0
		NewStuff()
			src.overlays += pick('Short.dmi','Short2.dmi','Short3.dmi')
			src.overlays+='Shirt.dmi'
			src.overlays+='Sandals.dmi'
			OriginalOverlays=overlays.Copy()
			src.SetName(src.name)
			spawn() Stuff()
			..()
		DblClick()
			if(usr.dead) return
			if(get_dist(src,usr)>2) return
			usr.move=0
			var/list/Options=list()
			for(var/obj/Inventory/Weaponry/C in world)
				if(C.loc==locate(199,199,12)) Options["[C.name]-[C.Cost] Ryo"]=C
			var/obj/Choice=usr.CustomInput("Purchase","What would you like to purchase?",Options + "Cancel")
			if(Choice.name=="Cancel")
				usr.move=1
				return
			var/obj/S = Options["[Choice]"]
			var/list/AlertInput=usr.client.AlertInput("How many would you like to buy?","Purchase")
			if(!isnum(AlertInput[2]))
				usr.move=1
				return
			var/RealPrice=S.Cost*AlertInput[2]
			var/newitems=usr.items+AlertInput[2]
			if(usr.maxitems > -1 && usr.contents.len >= usr.maxitems)
				usr<<output("This would exceed your amount of avaliable items.","Action.Output")
				usr.move=1
				return
			if(AlertInput[2]<=0)
				usr.move=1
				return
			if(usr.Ryo>=RealPrice)
				var/obj/Inventory/I=new S.type()
				I.stacks = AlertInput[2]
				usr.RecieveItem(I)
				usr.client.UpdateInventoryPanel()
				usr<<output("You bought [AlertInput[2]] [S.name](s) for [RealPrice] Ryo.","Action.Output")
				usr.Ryo-=RealPrice
				usr.move=1
			else
				usr<<output("You need [RealPrice] Ryo to purchase this.","Action.Output")
				usr.move=1
				return
	Banker
		icon='WhiteMBase.dmi'
		pixel_x=-15
		density=0
		NewStuff()
			src.overlays += pick('Short.dmi','Short2.dmi','Short3.dmi')
			src.overlays+='Shirt.dmi'
			src.overlays+='Sandals.dmi'
			OriginalOverlays=overlays.Copy()
			src.SetName(src.name)
			spawn() Stuff()
			..()
		DblClick()
			if(usr.dead) return
			if(get_dist(src,usr)>2) return
			if(!usr.move) return
			usr.move=0
			switch(usr.client.Alert("You have [usr.Ryo] Ryo on you and [usr.RyoBanked] banked here.","Bank",list("Deposit","Withdraw","Cancel")))
				if(1)
					if(!usr.Ryo)
						usr << output("[src] says, You don't have any Ryo to deposit","Action.Output")
					else
						var/list/AlertInput=usr.client.AlertInput("How much would you like to deposit?","Ryo Deposit")
						if(!isnum(AlertInput[2]))
							usr.move=1
							return
						if(usr.Ryo<AlertInput[2]||AlertInput[2]<=0)
							usr.move=1
							return
						usr.RyoBanked+=AlertInput[2]
						usr.Ryo-=AlertInput[2]
						usr << output("[src] says,  Thank you for your deposit.","Action.Output")
					usr.move=1
					return

				if(2)
					if(!usr.RyoBanked)
						usr << output("[src] says, You do not have any Ryo to withdraw","Action.Output")
					else
						var/list/AlertInput=usr.client.AlertInput("How much would you like to withdraw?","Ryo Withdraw")
						if(!isnum(AlertInput[2]))
							usr.move=1
							return
						if(usr.RyoBanked<AlertInput[2]||AlertInput[2]<=0)
							usr.move=1
							return
						usr.Ryo+=AlertInput[2]
						usr.RyoBanked-=AlertInput[2]
						usr << output("[src] says, Thanks, here's your Ryo.","Action.Output")
					usr.move=1
					return

				if(3)
					usr.move=1
					return

