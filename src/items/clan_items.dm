//items for obtaining clans in the game

obj
	Inventory
		Useable_Clan_Items
			var/required_element
			var/required_spec

			verb
				Use()
					set category = null
					set src in usr.contents
					if(usr.client.prompt({"[src.Description]"+"<br /><br />Are you sure you want to read this?<br /><br /><b><font color= #971e1e>YOU WILL OBTAIN [src.clan] AS ONE OF YOUR CLANS</Font></b>""}, "[src.name]", list("Yes", "No")) == "Yes")
						if(usr.Clan == src.clan || usr.Clan2 == src.clan)
							usr.client.prompt({"You've already read this."}, "[src.name]")
							return
						if(src.required_element)
							if(src.required_element != usr.Element && src.required_element != usr.Element2 && src.required_element != usr.Element3 && src.required_element != usr.Element4 && src.required_element != usr.Element5)
								usr.client.prompt({"You need to have [required_element] affinity to use this."}, "[src.name]")
								return
						if(src.required_spec)
							if(src.required_spec != usr.Specialist)
								usr.client.prompt({"You need to be a [required_spec] specialist to use this."}, "[src.name]")
								return
						if(usr.Clan == "No Clan" || usr.Clan2 == "No Clan")
							if(usr.Clan != "No Clan")
								usr.Clan2 = src.clan
								usr.client.prompt({"You have gained [src.clan] as your second clan!"}, "[src.name]")
							else
								usr.Clan = src.clan
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
				required_spec = SPECIALIZATION_NINJUTSU

			Guide_to_Origami
				name = "Guide to Origami"
				clan = CLAN_PAPER
				Description = "A guide containing the secret art of manipulating paper. Users of paper are high damage dealers but require a lot of chakra."
				icon = 'overhead_icons.dmi'
				icon_state = "sandintel"
			
			Leaf_Scroll_Eight_Gates
				name = "Leaf Scroll: Eight Gates"
				clan = CLAN_GATES
				required_spec = SPECIALIZATION_TAIJUTSU
				Description = "By studying these pages you can learn to devote yourself to taijutsu by opening the eight chakra gates. Gates users can obtain huge bonuses to their taijutsu but at the cost of harming themselves."
				icon = 'overhead_icons.dmi'
				icon_state = "sandintel"

			Bubble_Pipe
				name = "Bubble Pipe"
				clan = CLAN_BUBBLE
				required_element = "Water"
				Description = "A small brass pipe designed to blow large bubbles. Users of the water release can learn to use bubble jutsu. High multi target damage."
				icon = 'overhead_icons.dmi'
				icon_state = "sandintel"

			Medical_Ninjutsu_Manual
				name = "Medical Ninjutsu Manual"
				clan = CLAN_MEDICAL
				Description = "A comprehensive guide to basic medical ninjutsu including some combat applications for out on the field. Primarily healers who support their team with poison."
				icon = 'overhead_icons.dmi'
				icon_state = "sandintel"

			Fuinjutsu_Style_Manual
				name = "Fuinjutsu Style Manual"
				clan = CLAN_WEAPONIST
				Description = "A manual which describes jutsu that can store and summon weaponry using scrolls. High damage dealer with low cooldowns."
				icon = 'overhead_icons.dmi'
				icon_state = "sandintel"

		Unuseable_Clan_Items
			verb
				Use()
					set src in usr.contents
					usr.client.prompt({"You have no idea how to use this. You've heard rumors of a man who might be able to help. He lives in a small village in the south-west of the map."}, "[src.name]")

			Yuki_Clan_Cells
				name = "Frozen Cells"
				clan = CLAN_ICE
				Description = "Unlike other containers of the sort this one is completely frozen solid. No doubt the lost genes of the Yuki Clan who could use the Ice Release. A high damage bloodline which attempts to trap a single target in it's mirrors. Can only be used on those who hold the water element."
				icon = 'overhead_icons.dmi'
				icon_state = "sandintel"

			Sealed_Forbidden_Scroll_Clay
				name = "Sealed Forbidden Scroll: Clay"
				clan = CLAN_CLAY
				Description = "A forbidden procedure to implant the body with extra mouths that can mould explosive clay. Extremely high damage multi and single target but little else."
				icon = 'overhead_icons.dmi'
				icon_state = "sandintel"

			Sealed_Forbidden__Scroll_Jiongu
				name = "Sealed Forbidden Scroll: Jiongu"
				clan = CLAN_KAKUZU
				Description = "A forbidden procedure to drastically alter your body until you're held together with hundreds of thread-like tendris. You utilize these tendrils by collecting hearts to extend your own life and fight with you. Jiongu users are difficult to take down but rely on chance to deal damage."
				icon = 'overhead_icons.dmi'
				icon_state = "sandintel"
			
			Ancient_Scroll_Natural_Energy
				name = "Ancient Scroll: Natural Energy"
				clan = CLAN_SAGE
				Description = "(WIP)Obtain the power of a snake sage.(WIP)"
				icon = 'overhead_icons.dmi'
				icon_state = "sandintel"

			Sealed_Forbidden_Scroll_Spider
				name = "Sealed Forbidden Scroll: Spider"
				clan = CLAN_SPIDER
				Description = "A forbidden procedure to drastically alter your body until you resemble something like a spider. With your new form you'll be able to create sticky webs which can harden. Spiders can use their webs to trap a single target and deal damage."
				icon = 'overhead_icons.dmi'
				icon_state = "sandintel"

			Eye_of_Uchiha
				name = "Eye of Uchiha"
				clan = CLAN_IMPLANT
				Description = "A single eye taken from a member of the uchiha clan, presumed to be dead. With this you can unlock the power of the Sharingan but only from a single eye. Single target damage with the ability become intangiable and to copy weaker versions of jutsu."
				icon = 'overhead_icons.dmi'
				icon_state = "sandintel"

			Crystal_Cells
				name = "Crystalized Cells"
				clan = CLAN_CRYSTAL
				Description = "The crystaline anomalies in these cells show that it must contain the genes of a Crystal release bloodline. They used earth release to create crystals. Deals high damage with high chakra costs."
				icon = 'overhead_icons.dmi'
				icon_state = "sandintel"

			Kaguya_Clan_Cells
				name="Kaguya Clan Cells"
				clan = CLAN_KAGUYA
				Description = "The cells are attached to an extremely abnormal shard of bone. This must contain the genes of the lost kaguya clan. Using the manipulation of their bones kaguya they are strong physical attackers with numerous binds."
				icon = 'overhead_icons.dmi'
				icon_state = "sandintel"

			Hozuki_Clan_Cells_Ink
				name = "Hozuki_Clan_Cells_Ink"
				clan = CLAN_INK
				Description = "An inksoaked patch of cells clearly derived from a member of the hozuki clan. They are able to turn their energy into ink by painting it to life. High area damage with a small amount of binds."
				icon = 'overhead_icons.dmi'
				icon_state = "sandintel"

			Cells_of_the_First_Hokage
				name = "Cells of the First Hokage"
				clan = CLAN_SENJU
				Description = "Rare cells of the first Hokage. They contain the ability to use Wood Release. The cells will reject anyone without both earth and water affinity."
				icon = 'overhead_icons.dmi'
				icon_state = "sandintel"

			Eyes_of_Legend
				name = "Eyes of Legend"
				clan = CLAN_RINNEGAN
				Description = "These eyes are that of the legendary Rinnegan! They're preserved well enough for a transplant. High utilty and area of effect damage."
				icon = 'overhead_icons.dmi'
				icon_state = "sandintel"