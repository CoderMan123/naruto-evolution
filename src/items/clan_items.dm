//items for obtaining clans in the game

obj
	Inventory
		Useable_Clan_Items
			var/Clan
			var/Name
			verb
				Use()
					set category = null
					set src in usr.contents
					if(usr.client.prompt({"[src.Description]"}, "[src.Name]", list("Yes", "No")) == "Yes")
						if(usr.Clan == CLAN_JASHIN || usr.Clan2 == CLAN_JASHIN)
							usr.client.prompt({"You've already read this."}, "[src.Name]")
							return
						if(usr.Clan == "No Clan" || !usr.Clan2)
							if(usr.Clan != "No Clan")
								usr.Clan2 = src.Clan
								usr.client.prompt({"You have gained [src.Clan] as your second clan!"}, "[src.Name]")
							else
								usr.Clan = src.Clan
								usr.client.prompt({"You have gained [src.Clan] as your first clan!"}, "[src.Name]")
							src.loc = null
							usr.client.UpdateInventoryPanel()
						else usr.client.prompt({"You already have both of your clans. You've heard rumors of a man who might be able to help. He lives in a small village in the south-west of the map."}, "[src.Name]")


			Scripture_of_Lord_Jashin //Jashin clan
				Name = "Scripture of Lord Jashin"
				Description = "A strange scripture written in blood on what is most certainly not paper. It seems to contain forbidden knowledge of a strange and powerful entity.<br /><br />Are you sure you want to read this?<br /><br /><b><font color= #971e1e>YOU WILL OBTAIN JASHIN AS ONE OF YOUR CLANS</Font></b>"
				Clan = CLAN_JASHIN
				icon = 'overhead_icons.dmi'
				icon_state = "sandintel"

		Unuseable_Clan_Items
			var/Clan
			var/Name
			verb
				Use()
					set src in usr.contents
					usr.client.prompt({"You have no idea how to use this. You've heard rumors of a man who might be able to help. He lives in a small village in the south-west of the map."}, "[src.Name]")


