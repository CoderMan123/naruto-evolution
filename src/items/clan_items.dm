//items for obtaining clans in the game

obj
	Inventory
		Useable_Clan_Items
			var/Clan
			verb
				Use()
					set category = null
					set src in usr.contents
					if(usr.client.prompt({"[src.Description]"+"<br /><br />Are you sure you want to read this?<br /><br /><b><font color= #971e1e>YOU WILL OBTAIN [src.clan] AS ONE OF YOUR CLANS</Font></b>""}, "[src.name]", list("Yes", "No")) == "Yes")
						if(usr.Clan == CLAN_JASHIN || usr.Clan2 == CLAN_JASHIN)
							usr.client.prompt({"You've already read this."}, "[src.name]")
							return
						if(usr.Clan == "No Clan" || !usr.Clan2)
							if(usr.Clan != "No Clan")
								usr.Clan2 = src.Clan
								usr.client.prompt({"You have gained [src.clan] as your second clan!"}, "[src.name]")
							else
								usr.Clan = src.Clan
								usr.client.prompt({"You have gained [src.clan] as your first clan!"}, "[src.name]")
							src.loc = null
							usr.client.UpdateInventoryPanel()
						else usr.client.prompt({"You already have both of your clans. You've heard rumors of a man who might be able to help. He lives in a small village in the south-west of the map."}, "[src.name]")


			Scripture_of_Lord_Jashin //Jashin clan
				name = "Scripture of Lord Jashin"
				clan = CLAN_JASHIN
				Description = "A strange scripture written in blood on what is most certainly not paper. It seems to contain forbidden knowledge of a strange and powerful entity. Followers of Jashin boast short periods of immortality for successful sacrifices. They deal damage based on their maximum hp but can also damage themselves."
				icon = 'overhead_icons.dmi'
				icon_state = "sandintel"

			Leaf_Scroll_Yellow_Flash
				name = "Leaf Scroll: Yellow Flash"
				clan = CLAN_YELLOWFLASH
				Description = "The recorded jutsu of 2 legendary hokage utilizing telportation with marked kunai. A highly mobile clan with difficult to avoid attacks."
				icon = 'overhead_icons.dmi'
				icon_state = "sandintel"

			Guide_to_Origami
				name = "Guide to Origami"
				clan = CLAN_PAPER
				Description = "A guide containing the secret art of manipulating paper. Users of paper are high damage dealers but require a lot of chakra."
				icon = 'overhead_icons.dmi'
				icon_state = "sandintel"
			
			Leaf_Scroll_Eight_Gates
				name = "Leaf Scroll: Eight Gates"
				clan = CLAN_GATES
				Description = "By studying these pages you can learn to devote yourself to taijutsu by opening the eight chakra gates. Gates users can obtain huge bonuses to their taijutsu but at the cost of harming themselves."
				icon = 'overhead_icons.dmi'
				icon_state = "sandintel"

			Bubble_Pipe
				name = "Bubble Pipe"
				Clan = CLAN_BUBBLE
				Description = "A small brass pipe designed to blow large bubbles. Users of the water release can learn to use bubble jutsu. High multi target damage."
				icon = 'overhead_icons.dmi'
				icon_state = "sandintel"

			Medical_Ninjutsu_Manual
				name = "Medical Ninjutsu Manual"
				Clan = CLAN_MEDICAL
				Description = "A comprehensive guide to basic medical ninjutsu including some combat applications for out on the field. Primarily healers who support their team with poison."
				icon = 'overhead_icons.dmi'
				icon_state = "sandintel"

			Fuinjutsu_Style_Manual
				name = "Fuinjutsu_Style_Manual"
				Clan = CLAN_WEAPONIST
				Description = "A manual which describes jutsu that can store and summon weaponry using scrolls. High damage dealer with low cooldowns."
				icon = 'overhead_icons.dmi'
				icon_state = "sandintel"

		Unuseable_Clan_Items
			var/Clan
			verb
				Use()
					set src in usr.contents
					usr.client.prompt({"You have no idea how to use this. You've heard rumors of a man who might be able to help. He lives in a small village in the south-west of the map."}, "[src.name]")

			Yuki_Clan_Cells
				name = "Frozen Cells"
				Clan = CLAN_ICE
				Description = "Unlike other containers of the sort this one is completely frozen solid. No doubt the lost genes of the Yuki Clan who could use the Ice Release. A high damage bloodline which attempts to trap a single target in it's mirrors. Can only be used on those who hold the water element."
				icon = 'overhead_icons.dmi'
				icon_state = "sandintel"

			Sealed_Forbidden_Scroll_Clay
				name = "Sealed Forbidden Scroll: Clay"
				Clan = CLAN_CLAY
				Description = "A forbidden procedure to implant the body with extra mouths that can mould explosive clay. Extremely high damage multi and single target but little else."
				icon = 'overhead_icons.dmi'
				icon_state = "sandintel"

			Sealed_Forbidden__Scroll_Jiongu
				name = "Sealed Forbidden Scroll: Jiongu"
				Clan = CLAN_KAKUZU
				Description = "A forbidden procedure to drastically alter your body until you're held together with hundreds of thread-like tendris. You utilize these tendrils by collecting hearts to extend your own life and fight with you. Jiongu users are difficult to take down but rely on chance to deal damage."
				icon = 'overhead_icons.dmi'
				icon_state = "sandintel"
			
			Ancient_Scroll_Natural_Energy
				name = "Ancient Scroll: Natural Energy"
				Clan = CLAN_SAGE
				Description = "(WIP)Obtain the power of a snake sage.(WIP)"
				icon = 'overhead_icons.dmi'
				icon_state = "sandintel"

			Sealed_Forbidden_Scroll_Spider
				name = "Sealed Forbidden Scroll: Spider"
				Clan = CLAN_SPIDER
				Description = "A forbidden procedure to drastically alter your body until you resemble something like a spider. With your new form you'll be able to create sticky webs which can harden. Spiders can use their webs to trap a single target and deal damage."
				icon = 'overhead_icons.dmi'
				icon_state = "sandintel"

			Eye_of_Uchiha
				name = "Eye of Uchiha"
				Clan = CLAN_IMPLANT
				Description = "A single eye taken from a member of the uchiha clan, presumed to be dead. With this you can unlock the power of the Sharingan but only from a single eye. Single target damage with the ability become intangiable and to copy weaker versions of jutsu."
				icon = 'overhead_icons.dmi'
				icon_state = "sandintel"

			Crystal_Cells
				name = "Crystalized Cells"
				Clan = CLAN_CRYSTAL
				Description = "The crystaline anomalies in these cells show that it must contain the genes of a Crystal release bloodline. They used earth release to create crystals. Deals high damage with high chakra costs."
				icon = 'overhead_icons.dmi'
				icon_state = "sandintel"

			Kaguya_Clan_Cells
				name="Kaguya Clan Cells"
				Clan = CLAN_KAGUYA
				Description = "The cells are attached to an extremely abnormal shard of bone. This must contain the genes of the lost kaguya clan. Using the manipulation of their bones kaguya they are strong physical attackers with numerous binds."
				icon = 'overhead_icons.dmi'
				icon_state = "sandintel"

			Hozuki_Clan_Cells_Ink
				name = "Hozuki_Clan_Cells_Ink"
				Clan = CLAN_INK
				Description = "An inksoaked patch of cells clearly derived from a member of the hozuki clan. They are able to turn their energy into ink by painting it to life. High area damage with a small amount of binds."
				icon = 'overhead_icons.dmi'
				icon_state = "sandintel"

			Cells_of_the_First_Hokage
				name = "Cells of the First Hokage"
				Clan = CLAN_SENJU
				Description = "Rare cells of the first Hokage. They contain the ability to use Wood Release. The cells will reject anyone without both earth and water affinity."
				icon = 'overhead_icons.dmi'
				icon_state = "sandintel"