client
	var/tmp/exp_lock_verify=0
	var/sound_level_bgm = 25
	var/sound_level_sfx = 10
	verb
		GetScreenResolution()
			set hidden = 1
			var/resolution = splittext(winget(src, "Map", "size"), "x")
			src.map_resolution_x = round(text2num(resolution[1]), 32) / 32
			src.map_resolution_y = round(text2num(resolution[2]), 32) / 32
			src.view="[src.map_resolution_x]x[src.map_resolution_y]"

		ChangeChannel()
			set hidden=1
			switch(src.channel)
				if("Local")
					src.channel = "Village"

				if("Village")
					if(src.mob.GetSquad()) src.channel = "Squad"
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

			src<<"Now speaking in channel: [src.channel]"

		CloseBrowser()
			set hidden=1
			src.browser_url = BROWSER_NONE
			winset(src, null, {"Browser.is-visible = "false";"})

		MiniWindow()
			set hidden=1
			winset(usr, "Main", "is-minimized=true")

		ToggleChatInputPanel()
			set hidden=1
			if(src.mob.Muted)
				src.prompt("You can't chat while muted.")
				return

			else if(winget(src, "Main.InputChild", "is-visible") == "false")
				winset(src, null, {"
					InputPanel.ChatInput.focus = "true";
					Main.InputChild.is-visible = "true";
				"})
			else
				winset(src, null, {"
					Main.InputChild.is-visible = "false";
					Map.Main.focus = "true";
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
					Settings.Titlebar.text = 'General Settings';
					Settings.Child.left = 'Settings-General';
				"})
			else
				winset(src, null, {"
					Settings.is-visible = "false";
				"})

		SettingsPanelGeneral()
			set hidden=1
			winset(src, null, {"
				Settings.Titlebar.text = 'General Settings';
				Settings.Child.left = 'Settings-General';
			"})
		
		SettingsPanelAccount()
			set hidden=1
			winset(src, null, {"
				Settings.Titlebar.text = 'Account Settings';
				Settings.Child.left = 'Settings-Account';
			"})
		
		SettingsPanelCharacter()
			set hidden=1
			winset(src, null, {"
				Settings.Titlebar.text = 'Character Settings';
				Settings.Child.left = 'Settings-Character';
			"})

		SettingsPanelAudio()
			set hidden=1
			winset(src, null, {"
				Settings.Titlebar.text = 'Audio Settings';
				Settings.Child.left = 'Settings-Audio';
			"})

		SettingsPanelWebsiteInformation()
			set hidden=1
			winset(src, null, {"
				Settings.Titlebar.text = 'Website Information';
				Settings.Child.left = 'Settings-WebsiteInformation';
			"})
		
		SettingsPanelAdministrator()
			set hidden=1
			winset(src, null, {"
				Settings.Titlebar.text = 'Administrator Settings';
				Settings.Child.left = 'Settings-Administrator';
			"})

		OnChangeSFX()
			set hidden=1
			src.sound_level_sfx = round(text2num(winget(src, "Settings-Audio.SFX", "value")), 1)
			winset(src, "Settings-Audio.SFX", "value = '[src.sound_level_sfx]'")

		OnChangeBGM()
			set hidden=1
			src.sound_level_bgm = round(text2num(winget(src, "Settings-Audio.BGM", "value")), 1)
			winset(src, "Settings-Audio.BGM", "value = '[src.sound_level_bgm]'")

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
				var/verification_response = src.iprompt("Please enter the following verification code to resume gaining experience: [verification_code]", "Experience Lock", list("Submit", "Cancel"))
				if(verification_response[1] == "Submit" && text2num(verification_response[2]) == verification_code)
					src << output("You will now resume gaining experience normally.", "Action.Output")
					winset(src, "Navigation.ExpLockButton", "is-disabled = 'true'")
					src.mob.exp_locked=0
					src.exp_lock_verify=0
				else if(verification_response[1] == "Submit")
					src.prompt("You did not enter the correct verification code.", "Experience Lock")
					src.exp_lock_verify=0
				else
					src.exp_lock_verify=0
			else
				src.prompt("You are not currently experience locked.", "Experience Lock")

		Community_Guidelines()
			set hidden = 1
			src << link("https://community.narutoevolution.com/t/community-guidelines/26")

		Ninja_Handbook()
			set hidden = 1
			src << link("https://community.narutoevolution.com/t/the-ninja-handbook/27")
		
		Server_Information()
			set hidden=1
			if(administrators.Find(src.ckey) && src.browser_url != BROWSER_SERVER_INFORMATION)

				var/html = {"
					<!doctype html>
					<html lang="en">
					<head>
						<title>Server Information</title>

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
						<h1>Server Information</h1>

						<table class="table table-sm table-hover">
							<tr>
								<th scope="col">Name</th>
								<td>[world.name]</td>
							</tr>
							<tr>
								<th scope="col">Status</th>
								<td>[world.status]</td>
							</tr>
							<tr>
								<th scope="col">Server Time</th>
								<td>[time2text(world.timeofday, "hh:mm:ss", world.timezone)] (UTC-[world.timezone])</td>
							</tr>
							<tr>
								<th scope="col">Local Time</th>
								<td>[time2text(world.timeofday, "hh:mm:ss", src.timezone)] (UTC[src.timezone])</td>
							</tr>
							<tr>
								<th scope="col">Address</th>
								<td>[world.address]:[world.port]</td>
							</tr>
							<tr>
								<th scope="col">BYOND Version</th>
								<td>[world.byond_version].[world.byond_build]</td>
							</tr>
							<tr>
								<th scope="col">FPS</th>
								<td>[world.fps]</td>
							</tr>
							<tr>
								<th scope="col">CPU</th>
								<td>[world.cpu]</td>
							</tr>
							<tr>
								<th scope="col">Map CPU</th>
								<td>[world.map_cpu]</td>
							</tr>
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
				src.browser_url = BROWSER_SERVER_INFORMATION
				winset(src, "Browser", "is-visible = true")
			else
				src.browser_url = BROWSER_NONE
				winset(src, "Browser", "is-visible = false")
		
		World_Information()
			set hidden=1
			if(administrators.Find(src.ckey) && src.browser_url != BROWSER_WORLD_INFORMATION)

				var/area_counter = 0
				for(var/area/a in world)
					area_counter++

				var/turf_counter = 0
				for(var/turf/t in world)
					turf_counter++

				var/mob_counter = 0
				for(var/mob/m in world)
					mob_counter++

				var/obj_counter = 0
				for(var/obj/o in world)
					obj_counter++

				var/projectile_counter = 0
				for(var/obj/Projectiles/o in world)
					projectile_counter++

				var/state_counter = 0
				for(var/mob/m in mobs_online)
					for(var/state/s in m.state_manager)
						state_counter++

				var/state_counter_self = 0
				for(var/state/s in src.mob.state_manager)
					state_counter_self++

				var/name_counter = 0
				for(var/obj/name/name in src.mob.state_manager)
					name_counter++

				var/html = {"
					<!doctype html>
					<html lang="en">
					<head>
						<title>World Information</title>

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
						<h1>World Information</h1>

						<table class="table table-sm table-hover">
							<tr>
								<th scope="col">Area Counter</th>
								<td>[area_counter]</td>
							</tr>
							
							<tr>
								<th scope="col">Turf Counter</th>
								<td>[turf_counter]</td>
							</tr>
							
							<tr>
								<th scope="col">Mob Counter</th>
								<td>[mob_counter]</td>
							</tr>

							<tr>
								<th scope="col">Object Counter</th>
								<td>[obj_counter]</td>
							</tr>

							<tr>
								<th scope="col">Projectiles Counter</th>
								<td>[projectile_counter]</td>
							</tr>

							<tr>
								<th scope="col">State Counter (World)</th>
								<td>[state_counter]</td>
							</tr>

							<tr>
								<th scope="col">State Counter (Self)</th>
								<td>[state_counter_self]</td>
							</tr>

							<tr>
								<th scope="col">Name Counter</th>
								<td>[name_counter]</td>
							</tr>
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
				src.browser_url = BROWSER_WORLD_INFORMATION
				winset(src, "Browser", "is-visible = true")
			else
				src.browser_url = BROWSER_NONE
				winset(src, "Browser", "is-visible = false")
		
		Election_Information()
			set hidden=1
			if(administrators.Find(src.ckey) && src.browser_url != BROWSER_ELECTION_INFORMATION)

				var/html = {"
					<!doctype html>
					<html lang="en">
					<head>
						<title>Election Information</title>

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
						<h1>Election Information</h1>

						<table class="table table-sm table-hover">
							<tr>
								<th scope="col">Hokage Election</th>
								<td>[global.hokage_election ? "Running" : "Ended"]</td>
							</tr>
							<tr>
								<th scope="col">Hokage Ballot</th>
								<td>[global.hokage_ballot_open ? "Open" : "Closed"]</td>
							</tr>
							<tr>
								<th scope="col">Hokage Ballot Counter</th>
								<td>[global.hokage_election_ballot.len]</td>
							</tr>
							<tr>
								<th scope="col">Kazekage Election</th>
								<td>[global.kazekage_election ? "Running" : "Ended"]</td>
							</tr>
							<tr>
								<th scope="col">Kazekage Ballot</th>
								<td>[global.kazekage_ballot_open ? "Open" : "Closed"]</td>
							</tr>
							<tr>
								<th scope="col">Kazekage Ballot Counter</th>
								<td>[global.kazekage_election_ballot.len]</td>
							</tr>
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
				src.browser_url = BROWSER_ELECTION_INFORMATION
				winset(src, "Browser", "is-visible = true")
			else
				src.browser_url = BROWSER_NONE
				winset(src, "Browser", "is-visible = false")

		JutsuReference()
			set hidden=1
			if(src.browser_url != BROWSER_JUTSU_REFERENCE)
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
				src.browser_url = BROWSER_JUTSU_REFERENCE
				winset(src, "Browser", "is-visible = true")
			else
				src.browser_url = BROWSER_NONE
				winset(src, "Browser", "is-visible = false")

		Changelog()
			set hidden=1
			src << link("https://github.com/IllusiveBIair/Naruto-Evolution-Community/releases")

		Who()
			set hidden = 1
			if(src.browser_url != BROWSER_WHO)
				var/players = ""
				for(var/client/C in clients_online)
					if(C)

						var/obj/Symbols/Village/V = new(C.mob)
						var/obj/Symbols/Rank/R = new(C.mob)

						var/Faction/F = new()
						F.name="-"

						var/multikey
						if(clients_multikeying.Find(C)) multikey = "<sup>(Multikey)</sup>"

						if(C.mob.Faction) F=C.mob.Faction
						if(administrators.Find(src.ckey))
							players += {"
							<tr>
								<td>[C.mob.name] ([C.ckey]) [multikey]</td>
								<td>[C.mob.level]</td>
								<td>\icon[V] [C.mob.village]</td>
								<td>\icon[R] [C.mob.rank]</td>
								<td>[F.name]</td>
							</tr>
						"}
						else if(moderators.Find(src.ckey))
							players += {"
							<tr>
								<td>[C.mob.name] ([C.ckey]) [multikey]</td>
								<td><i>Hidden</i></td>
								<td>\icon[V] [C.mob.village]</td>
								<td>\icon[R] [C.mob.rank]</td>
								<td>[F.name]</td>
							</tr>
						"}
						else
							players += {"
								<tr>
									<td>[C.mob.name] ([C.ckey])</td>
									<td><i>Hidden</i></td>
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
									<th scope="col">Level</th>
									<th scope="col">Village</th>
									<th scope="col">Rank</th>
									<th scope="col">Faction</th>
								</tr>
							</thead>

							<tbody>
								[players]
								<tr>
									<td><span style="font-weight: bold;">Total Online:</span> [global.mobs_online.len]</td>
									<td><span style="color: [COLOR_VILLAGE_LEAF]; font-weight: bold;">[VILLAGE_LEAF]:</span> [global.leaf_online]</td>
									<td><span style="color: [COLOR_VILLAGE_SAND]; font-weight: bold;">[VILLAGE_SAND]:</span> [global.sand_online]</td>
									<td><span style="color: [COLOR_VILLAGE_MISSING_NIN]; font-weight: bold;">[VILLAGE_MISSING_NIN]:</span> [global.missing_nin_online]</td>
									<td><span style="color: [COLOR_VILLAGE_AKATSUKI]; font-weight: bold;">[VILLAGE_AKATSUKI]:</span> [global.akatsuki_online]</td>
								</tr>
								<tr>
									<td></td>
									<td><span style="color: [COLOR_VILLAGE_LEAF]; font-weight: bold;">[RANK_HOKAGE]:</span> [global.GetHokage(RETURN_FORMAT_CHARACTER)]</td>
									<td><span style="color: [COLOR_VILLAGE_SAND]; font-weight: bold;">[RANK_KAZEKAGE]:</span> [global.GetKazekage(RETURN_FORMAT_CHARACTER)]</td>
									<td></td>
									<td><span style="color: [COLOR_VILLAGE_AKATSUKI]; font-weight: bold;">[RANK_AKATSUKI_LEADER]:</span> [global.GetAkatsuki(RETURN_FORMAT_CHARACTER)]</td>
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
				src.browser_url = BROWSER_WHO
				winset(src, "Browser", "is-visible = true")
			else
				src.browser_url = BROWSER_NONE
				winset(src, "Browser", "is-visible = false")

		View_Description(obj/Jutsu/J in usr.jutsus)
			set category = null
			usr.client.prompt(J.Description, J.name)

	proc
		BrowserRefresh()
			while(src)
				switch(src.browser_url)
					if(BROWSER_SERVER_INFORMATION)
						src.CloseBrowser()
						src.Server_Information()

					if(BROWSER_WORLD_INFORMATION)
						src.CloseBrowser()
						src.World_Information()

					if(BROWSER_ELECTION_INFORMATION)
						src.CloseBrowser()
						src.Election_Information()
				
				sleep(100)

		FlashExperienceLock()
			src.mob.overlays += /obj/Symbols/exp_lock

			while(src && src.mob.exp_locked)
				if(src) winset(src, "Navigation.ExpLockButton", "text-color=#C80000")
				sleep(10)
				if(src) winset(src, "Navigation.ExpLockButton", "text-color=#C8C8C8")
				sleep(10)

			if(src)
				winset(src, "Navigation.ExpLockButton", "text-color=#C8C8C8")
				src.mob.overlays -= /obj/Symbols/exp_lock

		UpdateWho()
			if(src.browser_url == BROWSER_WHO && winget(src, "Browser", "is-visible") == "true")
				src.Who()
				src.Who()

		UpdateWhoAll()
			for(var/client/c in clients_online)
				if(c) c.UpdateWho()

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
					Character.PrecisionExperienceBar.value  = "[round(src.mob.precisionexp/src.mob.maxprecisionexp*100)]"
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