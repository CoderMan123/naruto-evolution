obj
	var/tmp/Description="No description provided."
	Inventory
		mouse_over_pointer = /obj/cursors/pickup
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
					hearers() << output("You can't drop items while dead.","Action.Output")
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

						hearers() << output("[usr] drops [src].","Action.Output")
						usr.client.UpdateInventoryPanel()
					else
						usr.client.Alert("That is not a number!", "Satchel")

				else
					src.loc=usr.loc
					hearers() << output("[usr] drops [src].","Action.Output")
					usr.client.UpdateInventoryPanel()

mob
	verb
		Pickup()
			set hidden=1
			if(usr.dead)
				hearers() << output("You can't pickup items while dead.","Action.Output")
				return

			if(src.contents.len < src.maxitems)
				for(var/obj/Inventory/O in oview(1))

					if(istype(O, /obj/Inventory/mission/deliver_intel/leaf_intel))
						var/obj/Inventory/mission/deliver_intel/leaf_intel/o = O

						var/squad/squad = src.GetSquad()
						// The intel scroll can only be picked up by the originating squad or by another village.
						if(!squad && src.village == "Hidden Leaf" || (squad && o.squad && squad != o.squad && src.village == "Hidden Leaf")) continue

					else if(istype(O, /obj/Inventory/mission/deliver_intel/sand_intel))
						var/obj/Inventory/mission/deliver_intel/sand_intel/o = O

						var/squad/squad = src.GetSquad()
						// The intel scroll can only be picked up by the originating squad or by another village.
						if(!squad && src.village == "Hidden Sand" || (squad && o.squad && squad != o.squad && src.village == "Hidden Sand")) continue

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
							I.suffix = "x[I.stacks]"
							if(O.stacks <= 0) O.loc=null
							else src.Pickup()

						else
							src.contents += new O.type
							O.stacks--
							O.suffix = "x[O.stacks]"
							src.Pickup()
					else
						src.contents += O

					src.client.UpdateInventoryPanel()
					break
			else
				src << sound('cant.ogg',0,0,7,100)
				src << output("Your satchel is too full to carry anymore.","Action.Output")

	proc
		RecieveItem(var/obj/Inventory/O)
			if(istype(O, /obj/Inventory/mission/deliver_intel/leaf_intel))
				var/obj/Inventory/mission/deliver_intel/leaf_intel/o = O

				var/squad/squad = src.GetSquad()
				// The intel scroll can only be picked up by the originating squad or by another village.
				if(!squad && src.village == "Hidden Leaf" || (squad && o.squad && squad != o.squad && src.village == "Hidden Leaf")) return

			else if(istype(O, /obj/Inventory/mission/deliver_intel/sand_intel))
				var/obj/Inventory/mission/deliver_intel/sand_intel/o = O

				var/squad/squad = src.GetSquad()
				// The intel scroll can only be picked up by the originating squad or by another village.
				if(!squad && src.village == "Hidden Sand" || (squad && o.squad && squad != o.squad && src.village == "Hidden Sand")) return

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
					I.suffix = "x[I.stacks]"
					if(O.stacks <= 0) O.loc=null
					else src.RecieveItem(O)

				else
					src.contents += new O.type
					O.stacks--
					O.suffix = "x[O.stacks]"
					src.RecieveItem(O)
			else
				src.contents += O

			src.client.UpdateInventoryPanel()

		DropItem(obj/Inventory/O, var/quantity=1)
			//TODO: make dropping more than 1 quantity work with non stackables
			//TODO: quantity = -1 means drop maximum, stacking and non stacking included.
			if(O.stacks > 1)
				if(!quantity) return
				//if(quantity == -1)
				if(quantity)
					if(O.stacks < quantity)
						src.client.Alert("You don't have [quantity] [O]'s to drop.")
						return

					else if(O.stacks == quantity)
						O.loc=src.loc

					else if(O.stacks > quantity)
						O.stacks -= quantity
						if(O.max_stacks > 1) O.suffix = "x[O.stacks]"
						var/obj/Inventory/o = new O.type(src.loc)
						o.stacks = quantity

					hearers() << output("[src] drops [O].","Action.Output")
					src.client.UpdateInventoryPanel()

			else
				O.loc=src.loc
				hearers() << output("[src] drops [O].","Action.Output")
				src.client.UpdateInventoryPanel()

		DestroyItem(obj/Inventory/O, var/destroy_quantity=1)
			if(O.max_stacks > 1)
				var/obj/Inventory/I
				for(I in src.contents)
					if(I.type == O.type)
						if(I.stacks >= destroy_quantity)
							I.stacks -= destroy_quantity
							if(I.stacks <= 0) I.loc=null
							else I.suffix = "x[I.stacks]"

						else
							destroy_quantity -= I.stacks
							I.loc = null
							src.DestroyItem(O, destroy_quantity)
						break
			else
				O.loc=null

			src.client.UpdateInventoryPanel()
