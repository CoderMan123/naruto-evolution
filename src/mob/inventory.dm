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
					var/list/response = usr.client.iprompt("How many [src]'s would you like to drop?", "Satchel")
					response[2] = text2num(response[2])
					if(!response[2]) return

					if(src.stacks < response[2])
						usr.client.prompt("You don't have [response[2]] [src]'s to drop.")
						return

					usr.DropItem(src, response[2], usr.loc)

				else
					usr.DropItem(src, 1, usr.loc)

		ryo_pouch
			icon='Ryo_Pouch.dmi'
			icon_state="owned"
			name="Ryo Pouch"
			New(mob/M, var/ryo)
				..()
				if(M && ryo)
					src.ryo = ryo
					src.suffix = "x[ryo] Ryo"
					M.contents += src

			var/ryo = 0
			verb
				Add_to_Satchel()
					set category = null
					set src in usr.contents
					src.loc = null
					if(src.ryo)
						usr.ryo += src.ryo
						view() << "<i>[src] unbundles [ryo] Ryo from a ryo pouch and places it in their satchel.</i>"
						usr.client.UpdateInventoryPanel()

mob
	verb
		Pickup()
			set hidden=1
			if(usr.dead)
				hearers() << output("You can't pickup items while dead.","Action.Output")
				return

			if(src.maxitems > -1 && src.contents.len >= src.maxitems)
				src << output("Your satchel is too full to carry anymore.","Action.Output")
				src.PlayAudio('cant.ogg', output = AUDIO_SELF)
				return

			for(var/obj/Inventory/O in oview(1))
				src.RecieveItem(O, src.loc)
				break


	proc
		RecieveItem(var/obj/Inventory/O, var/atom/atom)
			if(istype(O, /obj/Inventory/mission/deliver_intel/leaf_intel))
				src.overlays+= /obj/Symbols/missions/intel_scroll/leaf
				var/obj/Inventory/mission/deliver_intel/leaf_intel/o = O

				var/squad/squad = src.GetSquad()
				// The intel scroll can only be picked up by the originating squad or by another village.
				if(!squad && src.village == "Hidden Leaf" || (squad && o.squad && squad != o.squad && src.village == "Hidden Leaf")) return

			else if(istype(O, /obj/Inventory/mission/deliver_intel/sand_intel))
				src.overlays+= /obj/Symbols/missions/intel_scroll/sand
				var/obj/Inventory/mission/deliver_intel/sand_intel/o = O

				var/squad/squad = src.GetSquad()
				// The intel scroll can only be picked up by the originating squad or by another village.
				if(!squad && src.village == "Hidden Sand" || (squad && o.squad && squad != o.squad && src.village == "Hidden Sand")) return

			if(O.max_stacks > 1)
				if(atom && !istype(src, /mob/npc))
					if(ismob(atom))
						hearers() << "<i>[src] takes x[O.stacks] [O] from [atom].</i>"
					else
						hearers() << "<i>[src] picks up x[O.stacks] [O] from the [lowertext(atom.name)].</i>"
				else
					hearers() << "<i>[src] picks up x[O.stacks] [O] from the ground.</i>"

				while(O && O.stacks > 0)
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
						if(O.stacks <= 0) O.loc = null

					else
						src.contents += new O.type
						O.stacks--
						O.suffix = "x[O.stacks]"
						if(O.stacks <= 0) O.loc = null

			else
				src.contents += O
				if(!istype(src, /mob/npc))
					if(atom)
						if(ismob(atom))
							hearers() << "<i>[src] takes [O] from [atom].</i>"
						else
							hearers() << "<i>[src] picks up [O] from the [lowertext(atom.name)].</i>"
					else
						hearers() << "<i>[src] picks up [O] from the ground.</i>"

			if(src.client)
				src.client.UpdateInventoryPanel()

		DropItem(obj/Inventory/O, var/quantity=1, var/atom/atom)
			//TODO: make dropping more than 1 quantity work with non stackables
			//TODO: quantity = -1 means drop maximum, stacking and non stacking included.
			if(istype(O, /obj/Inventory/mission/deliver_intel/leaf_intel))
				src.overlays-= /obj/Symbols/missions/intel_scroll/leaf

			else if(istype(O, /obj/Inventory/mission/deliver_intel/sand_intel))
				src.overlays-= /obj/Symbols/missions/intel_scroll/sand

			if(O.stacks > 1)
				if(!quantity) return
				//if(quantity == -1)
				if(quantity)
					if(O.stacks < quantity)
						src.client.prompt("You don't have [quantity] [O]'s to drop.")
						return

					else if(O.stacks == quantity)
						O.loc=src.loc

					else if(O.stacks > quantity)
						O.stacks -= quantity
						if(O.max_stacks > 1) O.suffix = "x[O.stacks]"
						var/obj/Inventory/o = new O.type(src.loc)
						o.stacks = quantity

					if(atom)
						if(ismob(atom))
							hearers() << "<i>[src] gives x[O.stacks] [O] to [atom].</i>"
						else
							hearers() << "<i>[src] drops x[O.stacks] [O] on the [lowertext(atom.name)].</i>"
					else
						hearers() << "<i>[src] drops x[quantity] [O] on the ground.</i>"

					src.client.UpdateInventoryPanel()

			else
				O.loc = src.loc

				if(!istype(src, /mob/npc))
					if(atom)
						if(ismob(atom))
							hearers() << "<i>[src] gives a [O] to [atom].</i>"
						else
							hearers() << "<i>[src] drops a [O] on the [lowertext(atom.name)].</i>"
					else
						hearers() << "<i>[src] drops a [O] on the ground.</i>"

				src.client.UpdateInventoryPanel()

		DestroyItem(obj/Inventory/O, var/destroy_quantity=1)

			if(istype(O, /obj/Inventory/mission/deliver_intel/leaf_intel))
				src.overlays-= /obj/Symbols/missions/intel_scroll/leaf

			else if(istype(O, /obj/Inventory/mission/deliver_intel/sand_intel))
				src.overlays-= /obj/Symbols/missions/intel_scroll/sand

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

							if(istype(O, /obj/Inventory/mission/deliver_intel))
								var/obj/Inventory/mission/deliver_intel/o = O
								o.squad = null

							src.DestroyItem(O, destroy_quantity)
						break
			else
				O.loc = null

				if(istype(O, /obj/Inventory/mission/deliver_intel))
					var/obj/Inventory/mission/deliver_intel/o = O
					o.squad = null

			if(src.client) src.client.UpdateInventoryPanel()
