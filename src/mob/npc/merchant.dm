mob
	npc
		merchant
			weapons_merchant
				name = "Weapons Merchant"
				icon = 'WhiteMBase.dmi'
				density = 1
				pixel_x = -15

				New()
					..()
					src.icon = pick('WhiteMBase.dmi', 'DarkMBase.dmi')
					src.overlays += pick(null, 'Deidara.dmi', 'Distance.dmi', 'Long.dmi', 'Mohawk.dmi', 'Neji Hair.dmi', 'Short.dmi','Short2.dmi','Short3.dmi', 'Spikey.dmi')
					src.overlays += 'Shirt.dmi'
					src.overlays += 'Sandals.dmi'
					src.overlays += 'Shade.dmi'

				DblClick()
					..()
					if(src.conversations.Find(usr)) return 0
					if(get_dist(src,usr) > 2) return
					if(usr.dead) return

					src.conversations.Add(usr)

					var/merchant_inventory[0]
					for(var/item in typesof(/obj/Inventory/Weaponry) - /obj/Inventory/Weaponry)
						var/obj/Inventory/i = new item
						if(i.can_purchase) merchant_inventory.Add(i)

					var/obj/Inventory/Weaponry/purchase = usr.client.prompt("What would you like to purchase?", "Weapons Merchant", merchant_inventory + "Cancel")
					if(purchase != "Cancel")
						var/list/purchase_amount = usr.client.iprompt("How many [purchase]s would you like to buy?", "Weapons Merchant", list("Purchase", "Cancel"))
						if(purchase_amount[1] == "Purchase")
							purchase_amount[2] = text2num(purchase_amount[2])
							if(purchase_amount[2])
								var/purchase_price = purchase_amount[2] * purchase.Cost
								if(purchase_price > 0)
									if(usr.client.prompt("Are you sure you want to purchase x[purchase_amount[2]] [purchase] for [purchase_price] ryo?", "Weapons Merchant", list("Purchase", "Cancel")) == "Purchase")
										if(usr.maxitems == -1 || usr.maxitems > -1 && usr.contents.len < usr.maxitems)
											if(usr.ryo >= purchase_price)
												var/obj/Inventory/Weaponry/i = new purchase.type()
												i.stacks = purchase_amount[2]
												usr.ryo -= purchase_price
												usr.RecieveItem(i, src)
												LogTransaction(usr, src, purchase_price, i, LOG_ACTION_TRANSACTION_BUY)
												usr.client.UpdateInventoryPanel()
												usr.client.prompt("You bought x[purchase_amount[2]] [purchase] for [purchase_price] ryo.")
											else
												usr.client.prompt("You need [purchase_price] ryo to purchase x[purchase_amount[2]] [purchase]", "Weapons Merchant")
										else
											usr.client.prompt("Your backback only has room for [usr.maxitems - usr.contents.len] more items.","Weapons Merchant")
								else
									usr.client.prompt("Are you trying to scam me? You can't purchase a negative amount.","Weapons Merchant")

					src.conversations.Remove(usr)

				leaf_weapons_merchant
					village = VILLAGE_LEAF

				sand_weapons_merchant
					village = VILLAGE_SAND

				missing_weapons_merchant
					village = VILLAGE_MISSING_NIN

				akatsuki_weapons_merchant
					village = VILLAGE_AKATSUKI

			clothing_merchant
				name = "Clothing Merchant"
				icon = 'WhiteMBase.dmi'
				density = 1
				pixel_x = -15

				New()
					..()
					src.icon = pick('WhiteMBase.dmi', 'DarkMBase.dmi')
					src.overlays += pick(null, 'Deidara.dmi', 'Distance.dmi', 'Long.dmi', 'Mohawk.dmi', 'Neji Hair.dmi', 'Short.dmi','Short2.dmi','Short3.dmi', 'Spikey.dmi')
					src.overlays += 'Shirt.dmi'
					src.overlays += 'Sandals.dmi'
					src.overlays += 'Shade.dmi'

				DblClick()
					..()
					if(src.conversations.Find(usr)) return 0
					if(get_dist(src,usr) > 2) return
					if(usr.dead) return

					src.conversations.Add(usr)

					var/merchant_inventory[0]
					for(var/item in typesof(/obj/Inventory/Clothing) - /obj/Inventory/Clothing)
						var/obj/Inventory/i = new item
						if(i.can_purchase) merchant_inventory.Add(i)

					var/obj/Inventory/Weaponry/purchase = usr.client.prompt("What would you like to purchase?", "Clothing Merchant", merchant_inventory + "Cancel")

					if(purchase != "Cancel")
						var/purchase_price = purchase.Cost
						var/color
						var/list/rgb = list()

						if(purchase.Colorable)
							if(usr.client.prompt("Would you like to dye your [purchase]?", "Clothing Merchant", list("Yes", "No")) == "Yes")
								color = usr.client.cprompt("What color would you like to dye your [purchase]?", "Clothing Merchant", luminosity_max = 40)
								if(color)
									rgb = rgb2num(color)
									purchase.icon += rgb(rgb[1], rgb[2], rgb[3])

						if(usr.client.prompt("Are you sure you want to purchase a [color ? "<font color='[color]'>[purchase]</font>" : "[purchase]"] for [purchase_price] ryo?", "Clothing Merchant", list("Purchase", "Cancel")) == "Purchase")
							if(usr.maxitems == -1 || usr.maxitems > -1 && usr.contents.len < usr.maxitems)
								if(usr.ryo >= purchase_price)
									purchase.stacks = 1
									usr.ryo -= purchase_price
									usr.RecieveItem(purchase, src)
									LogTransaction(usr, src, purchase_price, purchase, LOG_ACTION_TRANSACTION_BUY)
									usr.client.UpdateInventoryPanel()
									usr.client.prompt("You bought [purchase] for [purchase_price] ryo.")
								else
									usr.client.prompt("You need [purchase_price] ryo to purchase a [purchase].", "Clothing Merchant")
							else
								usr.client.prompt("Your backback only has room for [usr.maxitems - usr.contents.len] more items.","Clothing Merchant")

					src.conversations.Remove(usr)

				leaf_clothing_merchant
					village = VILLAGE_LEAF

				sand_clothing_merchant
					village = VILLAGE_SAND

				akatsuki_clothing_merchant
					village = VILLAGE_AKATSUKI

				missing_clothing_merchant
					village = VILLAGE_MISSING_NIN