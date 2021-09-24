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
			if(usr.maxitems > -1 && usr.contents.len >= usr.maxitems)
				usr<<output("This would exceed your amount of avaliable items.","Action.Output")
				return
			usr.move=0
			var/list/Options=list()
			for(var/obj/Inventory/Clothing/C in world)
				if(C.loc==locate(199,199,9)) Options["[C.name]-[C.Cost] Ryo"]=C
			var/obj/Choice = usr.CustomInput("Purchase","What would you like to purchase?",Options + "Cancel",0)
			if(Choice.name=="Cancel")
				usr.move=1
				return
			var/obj/S = Options["[Choice]"]
			if(usr.ryo>=S.Cost)
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
				usr.ryo-=S.Cost
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
				if(C.loc==locate(199,199,9)) Options["[C.name]-[C.Cost] Ryo"]=C
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
			if(usr.maxitems > -1 && usr.contents.len >= usr.maxitems)
				usr<<output("This would exceed your amount of avaliable items.","Action.Output")
				usr.move=1
				return
			if(AlertInput[2]<=0)
				usr.move=1
				return
			if(usr.ryo>=RealPrice)
				var/obj/Inventory/I=new S.type()
				I.stacks = AlertInput[2]
				usr.RecieveItem(I)
				usr.client.UpdateInventoryPanel()
				usr<<output("You bought [AlertInput[2]] [S.name](s) for [RealPrice] Ryo.","Action.Output")
				usr.ryo-=RealPrice
				usr.move=1
			else
				usr<<output("You need [RealPrice] Ryo to purchase this.","Action.Output")
				usr.move=1
				return
	Banker
		icon = 'WhiteMBase.dmi'
		village = VILLAGE_LEAF
		rank = null
		density = 1
		pixel_x = -15

		New()
			..()
			src.SetName(src.name)

		NewStuff()
			src.overlays += pick('Short.dmi','Short2.dmi','Short3.dmi')
			src.overlays+='Shirt.dmi'
			src.overlays+='Sandals.dmi'
			OriginalOverlays=overlays.Copy()
			src.SetName(src.name)
			spawn() Stuff()
			..()

		DblClick()
			if(src.conversations.Find(usr)) return 0
			if(get_dist(src,usr) > 2) return
			if(usr.dead) return

			src.conversations.Add(usr)

			view(src) << "[HTML_GetName(src)]<font color='[COLOR_CHAT]'>: Greetings [usr.name], would you like to make a deposit or a withdrawal from your bank?</font>"

			switch(usr.client.Alert("You currently have <u>[usr.ryo]</u> Ryo in your satchel.<br /><br />You currently have <u>[usr.RyoBanked]</u> in your bank.", "Bank", list("Deposit","Withdraw","Cancel")))
				if(1)
					
					view(usr) << "[HTML_GetName(usr)]<font color='[COLOR_CHAT]'>: I'd like to make a deposit to my bank account.</font>"
					
					if(!usr.ryo)
						sleep(10)
						view(src) << "[HTML_GetName(src)]<font color='[COLOR_CHAT]'>: I'm sorry, but your broke ass doesn't have any Ryo to deposit.</font>"
					else
						sleep(10)
						view(src) << "[HTML_GetName(src)]<font color='[COLOR_CHAT]'>: Very well, how much would you like to deposit?</font>"

						switch(usr.client.Alert("Would you like to deposit all of your Ryo?", "Bank", list("Yes", "No", "Cancel")))
							if(1)
								var/value = usr.ryo

								if(value)
									view(usr) << "[HTML_GetName(src)]<font color='[COLOR_CHAT]'>: I'd like to deposit [value] Ryo into my bank account.</font>"

									usr.ryo -= value
									usr.RyoBanked += value

									spawn() usr.client.UpdateInventoryPanel()

									usr << output("You have deposited <u>[value]</u> Ryo into your bank.", "Action.Output")
									usr << output("You now have <u>[usr.ryo]</u> Ryo into your satchel and <u>[usr.RyoBanked]</u> in your bank.", "Action.Output")

									sleep(10)
									view(src) << "[HTML_GetName(src)]<font color='[COLOR_CHAT]'>: Your transaction has been completed. Please come back again soon!</font>"

								else
									view(usr) << "[HTML_GetName(src)]<font color='[COLOR_CHAT]'>: Actually, I've changed my mind.</font>"
									sleep(10)
									view(src) << "[HTML_GetName(src)]<font color='[COLOR_CHAT]'>: Please come back again soon!</font>"

							if(2)
								var/list/AlertInput = usr.client.AlertInput("How much Ryo would you like to deposit into your bank?<br /><br />You currently have <u>[usr.ryo]</u> Ryo in your satchel.<br />You currently have <u>[usr.RyoBanked]</u> in your bank.", "Bank")
								
								var/value = AlertInput[2]

								if(isnum(value) && value > 0 && usr.ryo >= value)
									view(usr) << "[HTML_GetName(src)]<font color='[COLOR_CHAT]'>: I'd like to deposit [value] Ryo into my bank account.</font>"
								
									usr.ryo -= value
									usr.RyoBanked += value

									spawn() usr.client.UpdateInventoryPanel()

									usr << output("You have deposited <u>[value]</u> Ryo into your bank.", "Action.Output")
									usr << output("You now have <u>[usr.ryo]</u> Ryo into your satchel and <u>[usr.RyoBanked]</u> in your bank.", "Action.Output")

									sleep(10)
									view(src) << "[HTML_GetName(src)]<font color='[COLOR_CHAT]'>: Your transaction has been completed. Please come back again soon!</font>"

								else
									view(usr) << "[HTML_GetName(src)]<font color='[COLOR_CHAT]'>: Actually, I've changed my mind.</font>"
									sleep(10)
									view(src) << "[HTML_GetName(src)]<font color='[COLOR_CHAT]'>: Please come back again soon!</font>"
							
							if(3)
								view(usr) << "[HTML_GetName(src)]<font color='[COLOR_CHAT]'>: Actually, I've changed my mind.</font>"
								sleep(10)
								view(src) << "[HTML_GetName(src)]<font color='[COLOR_CHAT]'>: Please come back again soon!</font>"

				if(2)

					view(usr) << "[HTML_GetName(usr)]<font color='[COLOR_CHAT]'>: I'd like to make a withdrawal from my bank account.</font>"

					if(!usr.RyoBanked)
						sleep(10)
						view(src) << "[HTML_GetName(src)]<font color='[COLOR_CHAT]'>: I'm sorry, but your broke ass doesn't have any Ryo to withdrawal.</font>"
					else
						sleep(10)
						view(src) << "[HTML_GetName(src)]<font color='[COLOR_CHAT]'>: Very well, how much would you like to withdrawal?</font>"

						switch(usr.client.Alert("Would you like to withdrawal all of your Ryo?", "Bank", list("Yes", "No", "Cancel")))
							if(1)
								var/value = usr.RyoBanked

								if(value)
									view(usr) << "[HTML_GetName(src)]<font color='[COLOR_CHAT]'>: I'd like to withdrawal [value] Ryo into my bank account.</font>"

									usr.RyoBanked -= value
									usr.ryo += value
									
									spawn() usr.client.UpdateInventoryPanel()

									usr << output("You withdraw <u>[value]</u> Ryo into from your bank.", "Action.Output")
									usr << output("You now have <u>[usr.ryo]</u> Ryo into your satchel and <u>[usr.RyoBanked]</u> in your bank.", "Action.Output")

									sleep(10)
									view(src) << "[HTML_GetName(src)]<font color='[COLOR_CHAT]'>: Your transaction has been completed. Please come back again soon!</font>"

								else
									view(usr) << "[HTML_GetName(src)]<font color='[COLOR_CHAT]'>: Actually, I've changed my mind.</font>"
									sleep(10)
									view(src) << "[HTML_GetName(src)]<font color='[COLOR_CHAT]'>: Please come back again soon!</font>"

							if(2)
								var/list/AlertInput = usr.client.AlertInput("How much Ryo would you like to withdraw from your bank?<br /><br />You currently have <u>[usr.ryo]</u> Ryo in your satchel.<br />You currently have <u>[usr.RyoBanked]</u> in your bank.", "Bank")
								
								var/value = AlertInput[2]

								if(isnum(value) && value > 0 && usr.RyoBanked >= value)
									view(usr) << "[HTML_GetName(src)]<font color='[COLOR_CHAT]'>: I'd like to withdraw [value] Ryo from my bank account.</font>"

									usr.RyoBanked -= value
									usr.ryo += value
									
									spawn() usr.client.UpdateInventoryPanel()

									usr << output("You withdraw <u>[value]</u> Ryo into from your bank.", "Action.Output")
									usr << output("You now have <u>[usr.ryo]</u> Ryo into your satchel and <u>[usr.RyoBanked]</u> in your bank.", "Action.Output")

									sleep(10)
									view(src) << "[HTML_GetName(src)]<font color='[COLOR_CHAT]'>: Your transaction has been completed. Please come back again soon!</font>"

								else
									view(usr) << "[HTML_GetName(src)]<font color='[COLOR_CHAT]'>: Actually, I've changed my mind.</font>"
									sleep(10)
									view(src) << "[HTML_GetName(src)]<font color='[COLOR_CHAT]'>: Please come back again soon!</font>"
							
							if(3)
								view(usr) << "[HTML_GetName(src)]<font color='[COLOR_CHAT]'>: Actually, I've changed my mind.</font>"
								sleep(10)
								view(src) << "[HTML_GetName(src)]<font color='[COLOR_CHAT]'>: Please come back again soon!</font>"
				if(3)
					view(usr) << "[HTML_GetName(src)]<font color='[COLOR_CHAT]'>: No, thank you.</font>"
					sleep(10)
					view(src) << "[HTML_GetName(src)]<font color='[COLOR_CHAT]'>: Please come back again soon!</font>"

			src.conversations.Remove(usr)

