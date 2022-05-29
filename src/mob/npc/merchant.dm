mob
	npc
		merchant
			weapons_merchant
				name = "Weapons Merchant"
				icon = 'WhiteMBase.dmi'
				density = 1
				pixel_x = -15

				New()
					src.overlays += pick('Short.dmi', 'Short2.dmi', 'Short3.dmi')
					src.overlays += 'Shirt.dmi'
					src.overlays += 'Sandals.dmi'
					..()

				DblClick()
					..()
					if(src.conversations.Find(usr)) return 0
					if(get_dist(src,usr) > 2) return
					if(usr.dead) return

					src.conversations.Add(usr)

					var/merchant_inventory[0]
					for(var/item in typesof(/obj/Inventory/Weaponry) - /obj/Inventory/Weaponry)
						merchant_inventory.Add(new item)

					var/obj/Inventory/Weaponry/purchase = usr.client.prompt("What would you like to purchase?", "Weapons Merchant", merchant_inventory + "Cancel")
					if(purchase != "Cancel")
						var/list/purchase_amount = usr.client.iprompt("How many [purchase]s would you like to buy?", "Weapons Merchant", list("Purchase", "Cancel"))
						if(purchase_amount[1] == "Purchase")
							purchase_amount[2] = text2num(purchase_amount[2])
							if(purchase_amount[2])
								var/purchase_price = purchase_amount[2] * purchase.Cost
								if(usr.client.prompt("Are you sure you want to purchase x[purchase_amount[2]] [purchase] for [purchase_price] ryo?", "Weapons Merchant", list("Purchase", "Cancel")) == "Purchase")
									if(usr.maxitems == -1 || usr.maxitems > -1 && usr.contents.len < usr.maxitems)
										if(usr.ryo >= purchase_price)
											var/obj/Inventory/Weaponry/i = new purchase.type()
											i.stacks = purchase_amount[2]
											usr.ryo -= purchase_price
											usr.RecieveItem(i, src)
											usr.client.UpdateInventoryPanel()
											usr.client.prompt("You bought x[purchase_amount[2]] [purchase] for [purchase_price] ryo.")
										else
											usr.client.prompt("You need [purchase_price] ryo to purchase x[purchase_amount[2]] [purchase]", "Weapons Merchant")
									else
										usr.client.prompt("Your backback only has room for [usr.maxitems - usr.contents.len] more items.","Weapons Merchant")

					src.conversations.Remove(usr)

				leaf_weapons_merchant
					village = VILLAGE_LEAF

				sand_weapons_merchant
					village = VILLAGE_SAND

				akatsuki_weapons_merchant
					village = VILLAGE_AKATSUKI