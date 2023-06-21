proc
	Lootdrop(var/lootname, mob/m, var/dropchance)
		if(lootname && m && dropchance)
			switch(lootname)
				if("StandardClans")
					if(prob(dropchance))//5
						var/obj/Inventory/Useable_Clan_Items/Medical_Ninjutsu_Manual/med = new()
						m.RecieveItem(med, silent = 1)
						m << output("<font color = 9F51B9>You've recieved a rare item! (Medical Ninjutsu Manual) </font>", "Action.Output")
					if(prob(dropchance))//5
						var/obj/Inventory/Useable_Clan_Items/Fuinjutsu_Style_Manual/fu = new()
						m.RecieveItem(fu, silent = 1)
						m << output("<font color = 9F51B9>You've recieved a rare item! (Fuinjutsu Style Manual) </font>", "Action.Output")

				if("LeafMissions")
					if(prob(dropchance))//1
						var/obj/Inventory/Useable_Clan_Items/Leaf_Scroll_Yellow_Flash/yf = new()
						m.RecieveItem(yf, silent = 1)
						m << output("<font color = 9F51B9>You've recieved a rare item! (Leaf Scroll: Yellow Flash) </font>", "Action.Output")
					if(prob(dropchance))//1
						var/obj/Inventory/Useable_Clan_Items/Leaf_Scroll_Eight_Gates/eg = new()
						m.RecieveItem(eg, silent = 1)
						m << output("<font color = 9F51B9>You've recieved a rare item! (Leaf Scroll: Eight Gates) </font>", "Action.Output")

				if("Akatsuki Join")
					if(prob(dropchance))//1
						var/obj/Inventory/Akatsuki_Items/Seal_of_the_Crimson_Cloud/crim = new()
						m.RecieveItem(crim, silent = 1)
						m << output("<font color = 9F51B9>You've recieved a rare item! (Seal of the Crimson Cloud) </font>", "Action.Output")
				
				if("SandMissions")
					if(prob(dropchance))
						m << output("error: no loot in table")				

				if("MissingNin")
					if(prob(dropchance))//1
						var/obj/Inventory/Useable_Clan_Items/Bubble_Pipe/bub = new()
						m.RecieveItem(bub, silent = 1)
						m << output("<font color = 9F51B9>You've recieved a rare item! (Bubble Pipe) </font>", "Action.Output")
					if(prob(dropchance))//1
						var/obj/Inventory/Unuseable_Clan_Items/Eyes_of_Legend/rinne = new()
						m.RecieveItem(rinne, silent = 1)
						m << output("<font color = 9F51B9>You've recieved a rare item! (Eyes of Legend) </font>", "Action.Output")
					if(prob(dropchance))//1
						var/obj/Inventory/Unuseable_Clan_Items/Yuki_Clan_Cells/yuk = new()
						m.RecieveItem(yuk, silent = 1)
						m << output("<font color = 9F51B9>You've recieved a rare item! (Bubble Pipe) </font>", "Action.Output")
					if(prob(dropchance))//1
						var/obj/Inventory/Unuseable_Clan_Items/Sealed_Forbidden_Scroll_Spider/spi = new()
						m.RecieveItem(spi, silent = 1)
						m << output("<font color = 9F51B9>You've recieved a rare item! (Sealed Forbidden Scroll Spider) </font>", "Action.Output")
					if(prob(dropchance))//1
						var/obj/Inventory/Unuseable_Clan_Items/Crystal_Cells/cry = new()
						m.RecieveItem(cry, silent = 1)
						m << output("<font color = 9F51B9>You've recieved a rare item! (Crystal Cells) </font>", "Action.Output")
					if(prob(dropchance))//1
						var/obj/Inventory/Unuseable_Clan_Items/Kaguya_Clan_Cells/kag = new()
						m.RecieveItem(kag, silent = 1)
						m << output("<font color = 9F51B9>You've recieved a rare item! (Kaguya Clan Cells) </font>", "Action.Output")
					if(prob(dropchance))//1
						var/obj/Inventory/Unuseable_Clan_Items/Hozuki_Clan_Cells_Ink/ink = new()
						m.RecieveItem(ink, silent = 1)
						m << output("<font color = 9F51B9>You've recieved a rare item! (Hozuki Clan Cells: Ink) </font>", "Action.Output")
					if(prob(dropchance))//1
						var/obj/Inventory/Unuseable_Clan_Items/Cells_of_the_First_Hokage/wood = new()
						m.RecieveItem(wood, silent = 1)
						m << output("<font color = 9F51B9>You've recieved a rare item! (Cells of the First Hokage) </font>", "Action.Output")

				if("AkatsukiClans")
					if(prob(dropchance))//1
						var/obj/Inventory/Useable_Clan_Items/Scripture_of_Lord_Jashin/jash = new()
						m.RecieveItem(jash, silent = 1)
						m << output("<font color = 9F51B9>You've recieved a rare item! (Scripture of Lord Jashin) </font>", "Action.Output")
					if(prob(dropchance))//1
						var/obj/Inventory/Unuseable_Clan_Items/Sealed_Forbidden_Scroll_Clay/clay = new()
						m.RecieveItem(clay, silent = 1)
						m << output("<font color = 9F51B9>You've recieved a rare item! (Sealed Forbidden Scroll: Clay) </font>", "Action.Output")
					/*if(prob(dropchance))//1
						var/obj/Inventory/Unuseable_Clan_Items/Sealed_Forbidden__Scroll_Jiongu/jion = new()
						m.RecieveItem(jion, silent = 1)
						m << output("<font color = 9F51B9>You've recieved a rare item! (Sealed Forbidden Scroll: Jiongu) </font>", "Action.Output")*/
					if(prob(dropchance))//1
						var/obj/Inventory/Unuseable_Clan_Items/Eye_of_Uchiha/eye = new()
						m.RecieveItem(eye, silent = 1)
						m << output("<font color = 9F51B9>You've recieved a rare item! (Eye of Uchiha) </font>", "Action.Output")
					if(prob(dropchance))//1
						var/obj/Inventory/Useable_Clan_Items/Guide_to_Origami/ori = new()
						m.RecieveItem(ori, silent = 1)
						m << output("<font color = 9F51B9>You've recieved a rare item! (Guide to Origami) </font>", "Action.Output")


mob
	npc
		proc
			Lootdrop(var/lootname, mob/m)