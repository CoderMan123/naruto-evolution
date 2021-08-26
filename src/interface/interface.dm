client
	var/tmp/exp_lock_verify=0
	var/tmp/browser = BROWSER_NONE
	verb
		ChangeChannel()
			set hidden=1
			switch(src.channel)
				if("Local")
					src.channel = "Village"

				if("Village")
					if(src.mob.Squad) src.channel = "Squad"
					else if(src.mob.Faction) src.channel = "Faction"
					else src.channel = "Global"

				if("Squad")
					if(src.mob.Faction) src.channel = "Faction"
					else src.channel = "Global"

				if("Faction")
					src.channel ="Global"

				if("Global")
					src.channel ="Local"

				else
					src.channel = "Local"
			src<<"Now speaking in: [src.channel]"

		ToggleChatInputPanel()
			set hidden=1
			if(src.mob.Muted)
				src.Alert("You can't chat while muted.")
				return

			else if(winget(src, "Main.InputChild", "is-visible") == "false")
				winset(src, null, {"
					InputPanel.ChatInput.focus = "true";
					Main.InputChild.is-visible = "true";
				"})
			else
				winset(src, null, {"
					Map.Main.focus = "true";
					Main.MapChild.focus = "true";
				"})

		ToggleChatOutputPanel()
			set hidden=1
			if(winget(src, "Main.OutputChild", "is-visible") == "false")
				winset(src, null, {"
					Main.OutputChild.is-visible = "true";
				"})
			else
				winset(src, null, {"
					Main.OutputChild.is-visible = "false";
				"})

		ToggleCharacterPanel()
			set hidden=1
			if(winget(src, "Character", "is-visible") == "false")
				winset(src, "Character", "is-visible=true")
				src.UpdateCharacterPanel()

			else
				winset(src, "Character", "is-visible=false")


		ToggleInventoryPanel()
			set hidden=1
			if(winget(src, "Inventory", "is-visible") == "false")
				winset(src, "Inventory", "is-visible=true")
				src.UpdateInventoryPanel()

			else
				winset(src, null, {"
					Inventory.EquippedName.text=""
					Inventory.EquippedImage.image=""
					Inventory.is-visible=false
				"})
				usr<<output("<center>","Inventory.EquippedItemInfo")

		ToggleJutsuPanel()
			set hidden=1
			if(winget(src, "Jutsu", "is-visible") == "false")
				winset(src, "Jutsu", "is-visible=true")
				src.UpdateJutsuPanel()

			else
				winset(src, null, {"
					Jutsu.Name.text=""
					Jutsu.Image.image=""
					Jutsu.is-visible=false
				"})
				usr<<output("<center>","Jutsu.Info")

		ToggleSkillTreePanel()
			set hidden=1
			if(src.mob.Tutorial < 3)
				src << output("You cannot open the skill tree during this stage of the tutorial.", "Action.Output")
				return

			// This completes the step of the tutorial where it asks you to open the skill tree.
			if(!src.mob.tutorialskilltree) src.mob.tutorialskilltree = 1

			if(winget(src, "SkillTree", "is-visible") == "false")
				switch(input("Which skill tree would you like to view?", "Skill Tree") in list("Elemental Jutsu", "Clan Jutsu", "Non-clan Jutsu", "Cancel"))
					if("Elemental Jutsu")
						winset(src, "SkillTree", "is-visible=true")
						src.UpdateSkillTreePanel(/obj/skill_tree_locations/elemental)

					if("Clan Jutsu")
						winset(src, "SkillTree", "is-visible=true")
						switch(src.mob.Clan)
							if(CLAN_ABURAME) src.UpdateSkillTreePanel(/obj/skill_tree_locations/clan_aburame)
							if(CLAN_AKIMICHI) src.UpdateSkillTreePanel(/obj/skill_tree_locations/clan_akimichi)
							if(CLAN_BUBBLE) src.UpdateSkillTreePanel(/obj/skill_tree_locations/clan_bubble)
							if(CLAN_CLAY) src.UpdateSkillTreePanel(/obj/skill_tree_locations/clan_clay)
							if(CLAN_CRYSTAL) src.UpdateSkillTreePanel(/obj/skill_tree_locations/clan_crystal)
							if(CLAN_GATES) src.UpdateSkillTreePanel(/obj/skill_tree_locations/clan_gates)
							if(CLAN_HYUUGA) src.UpdateSkillTreePanel(/obj/skill_tree_locations/clan_hyuuga)
							if(CLAN_ICE) src.UpdateSkillTreePanel(/obj/skill_tree_locations/clan_ice)
							if(CLAN_IMPLANT) src.UpdateSkillTreePanel(/obj/skill_tree_locations/clan_implant)
							if(CLAN_INK) src.UpdateSkillTreePanel(/obj/skill_tree_locations/clan_ink)
							if(CLAN_JASHIN) src.UpdateSkillTreePanel(/obj/skill_tree_locations/clan_jashin)
							if(CLAN_KAGUYA) src.UpdateSkillTreePanel(/obj/skill_tree_locations/clan_kaguya)
							if(CLAN_KAKUZU) src.UpdateSkillTreePanel(/obj/skill_tree_locations/clan_kakuzu)
							if(CLAN_MEDICAL) src.UpdateSkillTreePanel(/obj/skill_tree_locations/clan_medical)
							if(CLAN_NARA) src.UpdateSkillTreePanel(/obj/skill_tree_locations/clan_nara)
							if(CLAN_NOCLAN) src.UpdateSkillTreePanel(/obj/skill_tree_locations/clan_noclan)
							if(CLAN_PAPER) src.UpdateSkillTreePanel(/obj/skill_tree_locations/clan_paper)
							if(CLAN_PUPPET) src.UpdateSkillTreePanel(/obj/skill_tree_locations/clan_puppet)
							if(CLAN_RINNEGAN) src.UpdateSkillTreePanel(/obj/skill_tree_locations/clan_rinnegan)
							if(CLAN_SAGE) src.UpdateSkillTreePanel(/obj/skill_tree_locations/clan_sage)
							if(CLAN_SAND) src.UpdateSkillTreePanel(/obj/skill_tree_locations/clan_sand)
							if(CLAN_SENJU) src.UpdateSkillTreePanel(/obj/skill_tree_locations/clan_senju)
							if(CLAN_SPIDER) src.UpdateSkillTreePanel(/obj/skill_tree_locations/clan_spider)
							if(CLAN_UCHIHA) src.UpdateSkillTreePanel(/obj/skill_tree_locations/clan_uchiha)
							if(CLAN_WEAPONIST) src.UpdateSkillTreePanel(/obj/skill_tree_locations/clan_weaponist)
							if(CLAN_YELLOWFLASH) src.UpdateSkillTreePanel(/obj/skill_tree_locations/clan_yellowflash)

					if("Non-clan Jutsu")
						winset(src, "SkillTree", "is-visible=true")
						switch(src.mob.Specialist)
							if(SPECIALIZATION_NINJUTSU) src.UpdateSkillTreePanel(/obj/skill_tree_locations/noclan_ninspec)
							if(SPECIALIZATION_GENJUTSU) src.UpdateSkillTreePanel(/obj/skill_tree_locations/noclan_genspec)
							if(SPECIALIZATION_TAIJUTSU) src.UpdateSkillTreePanel(/obj/skill_tree_locations/noclan_strspec)

			else
				winset(src, null, "SkillTree.is-visible=false")
				src.screen -= src.skill_tree_objects
				//UpdateSlots()
				//Target_ReAdd()

		ToggleSettingsPanel()
			set hidden=1
			if(winget(src, "Settings", "is-visible") == "false")
				winset(src, null, {"
					Settings.is-visible = "true";
				"})
			else
				winset(src, null, {"
					Settings.is-visible = "false";
				"})

		ToggleLeaderPanel()
			set hidden=1
			if(winget(src, "Leader", "is-visible") == "false")
				winset(src, null, {"
					Leader.is-visible = "true";
				"})
			else
				winset(src, null, {"
					Leader.is-visible = "false";
				"})

		UnlockExperience()
			set hidden=1
			if(src.exp_lock_verify) return
			if(src.mob.exp_locked)
				src.exp_lock_verify=1
				var/verification_code = rand(1000,9999)
				var/verification_response = src.AlertInput("Please enter the following verification code to resume gaining experience: [verification_code]", "Experience Lock", list("Submit", "Cancel"))
				if(verification_response[1] == 1 && text2num(verification_response[2]) == verification_code)
					src << output("You will now resume gaining experience normally.", "Action.Output")
					winset(src, "Navigation.ExpLockButton", "is-disabled = 'true'")
					src.mob.exp_locked=0
					src.exp_lock_verify=0
				else if(verification_response[1] == 1)
					src.Alert("You did not enter the correct verification code.", "Experience Lock")
					src.exp_lock_verify=0
				else
					src.exp_lock_verify=0
			else
				src.Alert("You are not currently experience locked.", "Experience Lock")

		CommunityGuidelines()
			set hidden = 1
			if(winget(src, "Browser", "is-visible") == "false")
				var/html = {"
					<!doctype html>
					<html lang="en">
					<head>
						<title>Characters Online</title>

						<!-- Required meta tags -->
						<meta charset="utf-8">
						<meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">

						<!-- Bootstrap CSS -->
						<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.0/css/bootstrap.min.css" integrity="sha384-9aIt2nRpC12Uk9gS9baDl411NQApFmC26EwAOH8WgZl5MYYxFfc+NcPb1dKGj7Sk" crossorigin="anonymous">

						<!-- Google Fonts -->
						<link href="https://fonts.googleapis.com/css2?family=Open+Sans&display=swap" rel="stylesheet">

						<style>
							body {
								padding-top: 19px;
								padding-left: 10px;
								background-color: #414141;
								color: #C8C8C8;
								font-family: 'Open Sans', sans-serif;
							}

							a {
								color: #007bff;
								text-decoration: none;
							}

							a:hover {
								color: #0056b3;
								text-decoration: underline;
							}

							a:visited {
								color: #007bff;
								text-decoration: none;
							}
							table {
								border-color: #dee2e6 !important;
							}
							th {
								color: #C8C8C8;
								border-width: 1px !important;
								border-color: #646464 !important;
							}
							td {
								color: #C8C8C8;
								border-color: #646464 !important;
							}
						</style>
					</head>

					<body>
						<h1>Community Guidelines</h1>

						<p style="font-style: italic;">Your community guidelines go here.</p>

						<h2>Social Etiquette</h2>
						<ul>
							<li>We have a zero tolerance policy for harassment, discrimination, racial slurs, your Mum, and more.</li>

							<li>
								test
								<li>test</li>
							</li>

						</ul>

						<!-- Optional JavaScript -->
						<!-- jQuery first, then Popper.js, then Bootstrap JS -->
						<!-- <script src="https://code.jquery.com/jquery-3.5.1.slim.min.js" integrity="sha384-DfXdz2htPH0lsSSs5nCTpuj/zy4C+OGpamoFVy38MVBnE+IbbVYUew+OrCXaRkfj" crossorigin="anonymous"></script> -->
						<!-- <script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.0/dist/umd/popper.min.js" integrity="sha384-Q6E9RHvbIyZFJoft+2mJbHaEWldlvI9IOYy5n3zV9zzTtmI3UksdQRVvoxMfooAo" crossorigin="anonymous"></script> -->
						<!-- <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.0/js/bootstrap.min.js" integrity="sha384-OgVRvuATP1z7JjHLkuOU7Xw704+h835Lr+6QL9UvYjZE3Ipu6Tp75j7Bh/kR0JKI" crossorigin="anonymous"></script> -->
					</body>
					</html>
				"}

				src << output(null, "Browser.Output")
				src << browse("[html]")
				winset(src, "Browser", "is-visible = true")
			else
				winset(src, "Browser", "is-visible = false")

		JutsuReference()
			set hidden=1
			if(winget(src, "Browser", "is-visible") == "false")
				var/html_jutsus = ""

				for(var/obj/Jutsus/I in src.mob.jutsus)
					html_jutsus += {"
						<tr>
							<td>[I.name]</td>
							<td>[I.level]</td>
							<td>[I.exp]/[I.maxexp]</td>
							<td>[I.rank]</td>
							<td>[I.signs]</td>
						</tr>
					"}

				var/html = {"
					<!doctype html>
					<html lang="en">
					<head>
						<title>Characters Online</title>

						<!-- Required meta tags -->
						<meta charset="utf-8">
						<meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">

						<!-- Bootstrap CSS -->
						<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.0/css/bootstrap.min.css" integrity="sha384-9aIt2nRpC12Uk9gS9baDl411NQApFmC26EwAOH8WgZl5MYYxFfc+NcPb1dKGj7Sk" crossorigin="anonymous">

						<!-- Google Fonts -->
						<link href="https://fonts.googleapis.com/css2?family=Open+Sans&display=swap" rel="stylesheet">

						<style>
							body {
								padding-top: 19px;
								padding-left: 10px;
								background-color: #414141;
								color: #C8C8C8;
								font-family: 'Open Sans', sans-serif;
							}

							a {
								color: #007bff;
								text-decoration: none;
							}

							a:hover {
								color: #0056b3;
								text-decoration: underline;
							}

							a:visited {
								color: #007bff;
								text-decoration: none;
							}
							table {
								border-color: #dee2e6 !important;
							}
							th {
								color: #C8C8C8;
								border-width: 1px !important;
								border-color: #646464 !important;
							}
							td {
								color: #C8C8C8;
								border-color: #646464 !important;
							}
						</style>
					</head>

					<body>
						<h1>Jutsu Reference</h1>

						<table class="table table-sm table-hover">
							<thead>
								<tr>
									<th scope="col">Jutsu</th>
									<th scope="col">Level</th>
									<th scope="col">Experience</th>
									<th scope="col">Rank</th>
									<th scope="col">Hand Seals</th>
								</tr>
							</thead>
							<tbody>
								[html_jutsus]
							</tbody>
						</table>

						<!-- Optional JavaScript -->
						<!-- jQuery first, then Popper.js, then Bootstrap JS -->
						<!-- <script src="https://code.jquery.com/jquery-3.5.1.slim.min.js" integrity="sha384-DfXdz2htPH0lsSSs5nCTpuj/zy4C+OGpamoFVy38MVBnE+IbbVYUew+OrCXaRkfj" crossorigin="anonymous"></script> -->
						<!-- <script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.0/dist/umd/popper.min.js" integrity="sha384-Q6E9RHvbIyZFJoft+2mJbHaEWldlvI9IOYy5n3zV9zzTtmI3UksdQRVvoxMfooAo" crossorigin="anonymous"></script> -->
						<!-- <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.0/js/bootstrap.min.js" integrity="sha384-OgVRvuATP1z7JjHLkuOU7Xw704+h835Lr+6QL9UvYjZE3Ipu6Tp75j7Bh/kR0JKI" crossorigin="anonymous"></script> -->
					</body>
					</html>
				"}

				src << output(null, "Browser.Output")
				src << browse("[html]")
				winset(src, "Browser", "is-visible = true")
			else
				winset(src, "Browser", "is-visible = false")

		Changelog()
			set hidden=1
			src << link("https://github.com/IllusiveBIair/Naruto-Evolution-Community/releases")

		Who()
			set hidden = 1
			if(winget(src, "Browser", "is-visible") == "false")
				var/online = 0
				var/players = ""
				for(var/client/C)
					if(C)
						online++

						var/obj/Symbols/Village/V = new(C.mob)
						var/obj/Symbols/Rank/R = new(C.mob)

						var/Faction/F = new()
						F.name="-"

						var/multikey
						if(clients_multikeying.Find(C)) multikey = "<sup>(Multikey)</sup>"

						if(C.mob.Faction) F=C.mob.Faction
						if(administrators.Find(src.ckey) || moderators.Find(src.ckey))
							players += {"
							<tr>
								<td>[C.mob.name] ([C.ckey]) [multikey]</td>
								<td>\icon[V] [C.mob.village]</td>
								<td>\icon[R] [C.mob.rank]</td>
								<td>[F.name]</td>
							</tr>
						"}
						else
							players += {"
								<tr>
									<td>[C.mob.name]</td>
									<td>\icon[V] [C.mob.village]</td>
									<td>\icon[R] [C.mob.rank]</td>
									<td>[F.name]</td>
								</tr>
							"}

				var/html = {"
					<!doctype html>
					<html lang="en">
					<head>
						<title>Characters Online</title>

						<!-- Required meta tags -->
						<meta charset="utf-8">
						<meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">

						<!-- Bootstrap CSS -->
						<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.0/css/bootstrap.min.css" integrity="sha384-9aIt2nRpC12Uk9gS9baDl411NQApFmC26EwAOH8WgZl5MYYxFfc+NcPb1dKGj7Sk" crossorigin="anonymous">

						<!-- Google Fonts -->
						<link href="https://fonts.googleapis.com/css2?family=Open+Sans&display=swap" rel="stylesheet">

						<style>
							body {
								padding-top: 19px;
								padding-left: 10px;
								background-color: #414141;
								color: #C8C8C8;
								font-family: 'Open Sans', sans-serif;
							}

							a {
								color: #007bff;
								text-decoration: none;
							}

							a:hover {
								color: #0056b3;
								text-decoration: underline;
							}

							a:visited {
								color: #007bff;
								text-decoration: none;
							}
							table {
								border-color: #dee2e6 !important;
							}
							th {
								color: #C8C8C8;
								border-width: 1px !important;
								border-color: #646464 !important;
							}
							td {
								color: #C8C8C8;
								border-color: #646464 !important;
							}
						</style>
					</head>

					<body>
						<h1>Characters Online</h1>

						<table class="table table-sm table-hover">
							<thead>
								<tr>
									<th scope="col">Character</th>
									<th scope="col">Village</th>
									<th scope="col">Rank</th>
									<th scope="col">Faction</th>
								</tr>
							</thead>
							<tbody>
								[players]

								<tr>
									<td scope="col"><span style="font-weight: bold;">Total Online:</span> [online]</td>
									<td></td>
									<td></td>
									<td></td>
								</tr>
							</tbody>
						</table>

						<!-- Optional JavaScript -->
						<!-- jQuery first, then Popper.js, then Bootstrap JS -->
						<!-- <script src="https://code.jquery.com/jquery-3.5.1.slim.min.js" integrity="sha384-DfXdz2htPH0lsSSs5nCTpuj/zy4C+OGpamoFVy38MVBnE+IbbVYUew+OrCXaRkfj" crossorigin="anonymous"></script> -->
						<!-- <script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.0/dist/umd/popper.min.js" integrity="sha384-Q6E9RHvbIyZFJoft+2mJbHaEWldlvI9IOYy5n3zV9zzTtmI3UksdQRVvoxMfooAo" crossorigin="anonymous"></script> -->
						<!-- <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.0/js/bootstrap.min.js" integrity="sha384-OgVRvuATP1z7JjHLkuOU7Xw704+h835Lr+6QL9UvYjZE3Ipu6Tp75j7Bh/kR0JKI" crossorigin="anonymous"></script> -->
					</body>
					</html>
				"}

				src << output(null, "Browser.Output")
				src << browse("[html]")
				winset(src, "Browser", "is-visible = true")
			else
				winset(src, "Browser", "is-visible = false")

	proc
		FlashExperienceLock()
			while(src && src.mob.exp_locked)
				if(src) winset(src, "Navigation.ExpLockButton", "text-color=#C80000")
				sleep(10)
				if(src) winset(src, "Navigation.ExpLockButton", "text-color=#C8C8C8")
				sleep(10)
			if(src) winset(src, "Navigation.ExpLockButton", "text-color=#C8C8C8")

		UpdateCharacterPanel()
			if(!src) return
			if(winget(src, "Character", "is-visible") == "true")
				var/icon/mob_image// = new(src.mob.icon, src.mob.icon_state)

				var/obj/Symbols/Village/village = new(src.mob)
				var/icon/village_image = new(village.icon, icon_state = village.icon_state)

				var/obj/Symbols/Rank/rank = new(src.mob)
				var/icon/rank_image = new(rank.icon, icon_state = rank.icon_state)

				winset(src, null, {"
					Character.Avatar.image     				= "\ref[fcopy_rsc(mob_image)]"
					Character.Avatar.image-mode				= "center"
					Character.Avatar.keep-aspect			= "true"
					Character.Name.text        				= "[src.mob.name]"
					Character.Clan.text        				= "[src.mob.Clan]"
					Character.Village.text     				= "[src.mob.village] ≡ [src.mob.rank]"
					Character.VillageImage.image     		= "\ref[fcopy_rsc(village_image)]"
					Character.RankImage.image     			= "\ref[fcopy_rsc(rank_image)]"
					Character.Level.text       				= "[src.mob.level]"
					Character.EXP.text         				= "[src.mob.exp]/[src.mob.maxexp]"
					Character.EXPBar.value     				= "[round(src.mob.exp/src.mob.maxexp*100)]"
					Character.Health.text      				= "[src.mob.health]/[src.mob.maxhealth]"
					Character.HealthBar.value  				= "[round(src.mob.health/src.mob.maxhealth*100)]"
					Character.Chakra.text      				= "[src.mob.chakra]/[src.mob.maxchakra]"
					Character.ChakraBar.value  				= "[round(src.mob.chakra/src.mob.maxchakra*100)]"
					Character.Def.text         				= "[src.mob.defence]"
					Character.DefEXP.text      				= "[src.mob.defexp]/[src.mob.maxdefexp]"
					Character.DefEXPBar.value  				= "[round(src.mob.defexp/src.mob.maxdefexp*100)]"
					Character.Agi.text         				= "[src.mob.agility]"
					Character.AgiEXP.text      				= "[src.mob.agilityexp]/[src.mob.maxagilityexp]"
					Character.AgiEXPBar.value  				= "[round(src.mob.agilityexp/src.mob.maxagilityexp*100)]"
					Character.Tai.text         				= "[src.mob.strength]"
					Character.TaiEXP.text      				= "[src.mob.strengthexp]/[src.mob.maxstrengthexp]"
					Character.TaiEXPBar.value  				= "[round(src.mob.strengthexp/src.mob.maxstrengthexp*100)]"
					Character.Nin.text         				= "[src.mob.ninjutsu]"
					Character.NinEXP.text     				= "[src.mob.ninexp]/[src.mob.maxninexp]"
					Character.NinEXPBar.value 				= "[round(src.mob.ninexp/src.mob.maxninexp*100)]"
					Character.Gen.text         				= "[src.mob.genjutsu]"
					Character.GenEXP.text      				= "[src.mob.genexp]/[src.mob.maxgenexp]"
					Character.GenEXPBar.value  				= "[round(src.mob.genexp/src.mob.maxgenexp*100)]"
					Character.Precision.text         		= "[src.mob.precision]"
					Character.PrecisionExperience.text      = "[src.mob.precisionexp]/[src.mob.maxprecisionexp]"
					Character.PrecisionExperienceBar.value  = "[round(src.mob.maxprecisionexp/src.mob.maxprecisionexp*100)]"
					Character.StatPoints.text  				= "[src.mob.statpoints]"
					Character.SkillPoints.text 				= "[src.mob.skillpoints]"
				"})

		UpdateInventoryPanel()
			if(!src) return
			if(winget(src, "Inventory", "is-visible") == "true")
				winset(src,"Inventory.Ryo","text=\"[src.mob.ryo]\"")
				winset(src,"Inventory.Titlebar","text=\"Inventory - [src.mob.contents.len]/[src.mob.maxitems]\"")
				winset(src,"Inventory.Grid","cells=0x0")

				var/row = 1
				src<<output("","Inventory.Grid:1,1")
				for(var/obj/O in src.mob.contents)
					row++
					src << output(O,"Inventory.Grid:1,[row]")
					src << output("<span style='text-align: right;'>[O.suffix]</span>","Inventory.Grid:2,[row]")

		UpdateJutsuPanel()
			if(!src) return
			if(winget(src, "Jutsu", "is-visible") == "true")
				winset(src,"Jutsu.Total","text=\"Learned Jutsu: [src.mob.jutsus.len]\"")
				winset(src,"Jutsu.Grid","cells=0x0")

				var/row = 1
				src<<output("","Jutsu.Grid:1,1")
				for(var/obj/Jutsus/O in src.mob.jutsus)
					row++
					src << output(O,"Jutsu.Grid:1,[row]")

		UpdateSkillTree()
			if(!src) return
			for(var/obj/Jutsus/jutsu in src.skill_tree_objects)

				// Check if the player meets to requirements to learn a jutsu.
				// This check is purely for visual representation

				jutsu.overlays = null

				if(jutsu.type in src.mob.jutsus_learned)
					jutsu.overlays += image('Misc Effects.dmi', "hasit!")
				else
					// TODO: o.reqs should be updated to be a list of objects i.e. list(new /obj/Jutsus/Bone-Tip)
					// TODO: Update visual state when learning a new jutsu via Click()
					var/requirement_counter = 0
					for(var/requirement in jutsu.reqs)
						for(var/obj/Jutsus/j in src.mob.jutsus)
							if(requirement == j.name) requirement_counter++

					if(requirement_counter != jutsu.reqs.len) jutsu.overlays += image('Misc Effects.dmi', "X")

					else if(jutsu.Clan && jutsu.Clan != src.mob.Clan) jutsu.overlays += image('Misc Effects.dmi', "X")

					else if(jutsu.Element)
						if(jutsu.Element != src.mob.Element && jutsu.Element != src.mob.Element2) jutsu.overlays += image('Misc Effects.dmi', "X")

					else if(jutsu.Element2)
						if(jutsu.Element2 != src.mob.Element && jutsu.Element2 != src.mob.Element2) jutsu.overlays += image('Misc Effects.dmi',"X")

					else if(jutsu.Specialist && jutsu.Specialist != src.mob.Specialist) jutsu.overlays += image('Misc Effects.dmi',"X")

		UpdateSkillTreePanel(var/obj/map_location)
			if(!src) return
			if(winget(src, "SkillTree", "is-visible") == "true")

				winset(src, null, "SkillTree-Progress.Bar.value='0'; SkillTree-Progress.Status.text='Loading... 0%' SkillTree.Loading.is-visible='true'")

				sleep(2)

				var/obj/skill_tree_locations/location = locate(map_location)

				if(location)

					var/list/instance_map = block(locate(max(location.x - location.instance_radius, 1), max(location.y - location.instance_radius, 1), location.z), locate(min(location.x + location.instance_radius, world.maxx), min(location.y + location.instance_radius, world.maxy), location.z))
					// block(locate(max(10-10, world.min_x), max(74-10, world.min_y), 4), locate(min(10+10, world.max_x), min(74+10, world.max_y), 4))

					var/instance_placement_x = 1
					var/instance_placement_y = 1
					var/instance_loading_percent = 0
					var/instance_loading_counter = 0

					for(var/turf/t in instance_map)

						for(var/atom/movable/o in t)
							var/obj/map_object = new o.type
							map_object.icon = o.icon
							map_object.icon_state = o.icon_state
							map_object.pixel_x = o.pixel_x
							map_object.pixel_y = o.pixel_y
							map_object.overlays = o.overlays
							map_object.underlays = o.underlays
							map_object.dir = o.dir
							map_object.screen_loc = "SkillTreeMap:[instance_placement_x],[instance_placement_y]"
							src.screen += map_object
							src.skill_tree_objects += map_object

							if(istype(map_object, /obj/Jutsus))
								var/obj/Jutsus/jutsu = map_object

								// Check if the player meets to requirements to learn a jutsu.
								// This check is purely for visual representation

								if(jutsu.type in src.mob.jutsus_learned)
									jutsu.overlays += image('Misc Effects.dmi', "hasit!")
								else
									// TODO: o.reqs should be updated to be a list of objects i.e. list(new /obj/Jutsus/Bone-Tip)
									// TODO: Update visual state when learning a new jutsu via Click()
									var/requirement_counter = 0
									for(var/requirement in jutsu.reqs)
										for(var/obj/Jutsus/j in src.mob.jutsus)
											if(requirement == j.name) requirement_counter++

									if(requirement_counter != jutsu.reqs.len) jutsu.overlays += image('Misc Effects.dmi', "X")

									else if(jutsu.Clan && jutsu.Clan != src.mob.Clan) jutsu.overlays += image('Misc Effects.dmi', "X")

									else if(jutsu.Element)
										if(jutsu.Element != src.mob.Element && jutsu.Element != src.mob.Element2) jutsu.overlays += image('Misc Effects.dmi', "X")

									else if(jutsu.Element2)
										if(jutsu.Element2 != src.mob.Element && jutsu.Element2 != src.mob.Element2) jutsu.overlays += image('Misc Effects.dmi',"X")

									else if(jutsu.Specialist && jutsu.Specialist != src.mob.Specialist) jutsu.overlays += image('Misc Effects.dmi',"X")

						instance_loading_counter ++

						if(instance_placement_x <= location.instance_radius * 2)
							instance_placement_x++
						else
							instance_placement_x = 1
							instance_placement_y++

						var/instance_loading_percent_next = round(instance_loading_counter / instance_map.len * 100, 1)
						if(instance_loading_percent < instance_loading_percent_next)
							instance_loading_percent = instance_loading_percent_next
							winset(src, null, "SkillTree-Progress.Bar.value='[instance_loading_percent]'; SkillTree-Progress.Status.text='Loading... [instance_loading_percent]%'")

					winset(src, null, "SkillTree.Loading.is-visible='false'")