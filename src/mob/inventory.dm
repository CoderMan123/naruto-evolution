obj
	var/tmp/Description="No description provided."
	Inventory
		var/stacks=1
		var/tmp/max_stacks=1
		var/equip=0
		New()
			..()
			if(src.max_stacks > 1) src.suffix = "x[src.stacks]"

		verb
			Drop()
				set category = null
				set src in usr.contents
				if(usr.dead)
					hearers() << output("You can't drop items while dead.","ActionPanel.Output")
					return

				if(src.stacks > 1)
					var/result = usr.client.AlertInput("How many [src]'s would you like to drop?", "Satchel")
					if(!result[2]) return
					if(isnum(result[2]))
						if(src.stacks < result[2])
							usr.client.Alert("You don't have [result[2]] [src]'s to drop.")
							return

						else if(src.stacks == result[2])
							src.loc=usr.loc

						else if(src.stacks > result[2])
							src.stacks -= result[2]
							if(src.max_stacks > 1) src.suffix = "x[src.stacks]"
							var/obj/Inventory/O = new src.type(usr.loc)
							O.stacks = result[2]

						hearers() << output("[usr] drops [src].","ActionPanel.Output")
						usr.client.UpdateInventoryPanel()
					else
						usr.client.Alert("That is not a number!", "Satchel")

				else
					src.loc=usr.loc
					hearers() << output("[usr] drops [src].","ActionPanel.Output")
					usr.client.UpdateInventoryPanel()

mob
	verb
		Pickup()
			set hidden=1
			if(usr.dead)
				hearers() << output("You can't pickup items while dead.","ActionPanel.Output")
				return

			if(src.contents.len < src.maxitems)
				for(var/obj/Inventory/O in oview(1))
					if(O.max_stacks > 1)
						var/obj/Inventory/I
						for(I in src.contents)
							if(I.type == O.type)
								if(I.stacks >= I.max_stacks) continue
								else break
						if(I)
							var/convert = min(O.stacks, I.max_stacks - I.stacks)
							O.stacks -= convert
							I.stacks += convert
							if(I.max_stacks > 1) I.suffix = "x[I.stacks]"
							if(O.stacks <= 0) O.loc=null
							else src.Pickup()

						else
							src.contents += new O.type
							O.stacks--
							if(O.max_stacks > 1) O.suffix = "x[O.stacks]"
							src.Pickup()
					else
						src.contents += O

					src.client.UpdateInventoryPanel()
					break
			else
				src << sound('cant.ogg',0,0,7,100)
				src << output("Your satchel is too full to carry anymore.","ActionPanel.Output")

	proc
		RecieveItem(var/obj/Inventory/O)
			if(O.max_stacks > 1)
				var/obj/Inventory/I
				for(I in src.contents)
					if(I.type == O.type)
						if(I.stacks >= I.max_stacks) continue
						else break
				if(I)
					var/convert = min(O.stacks, I.max_stacks - I.stacks)
					O.stacks -= convert
					I.stacks += convert
					if(I.max_stacks > 1) I.suffix = "x[I.stacks]"
					if(O.stacks <= 0) O.loc=null
					else src.RecieveItem(O)

				else
					src.contents += new O.type
					O.stacks--
					if(O.max_stacks > 1) O.suffix = "x[O.stacks]"
					src.RecieveItem(O)
			else
				src.contents += O

			src.client.UpdateInventoryPanel()

		DropItem(obj/Inventory/O, var/quantity=1)

		DestroyItem(obj/Inventory/O, var/quantity=1)