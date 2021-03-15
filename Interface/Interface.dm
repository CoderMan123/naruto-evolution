client
	var/tmp/exp_lock_verify=0
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
					Main.InputChild.is-visible = "false";
					Main.MapChild.focus = "true";
				"})

		ToggleChatOutputPanel()
			set hidden=1
			if(winget(src, "Main.OutputChild", "is-visible") == "false")
				winset(src, null, {"
					Main.OutputChild.focus = "true";
					Main.OutputChild.is-visible = "true";
				"})
			else
				winset(src, null, {"
					Main.OutputChild.focus = "false";
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
			if(winget(src, "InventoryWindow", "is-visible") == "false")
				winset(src, "InventoryWindow", "is-visible=true")
				src.UpdateInventoryPanel()

			else
				winset(src, null, {"
					InventoryWindow.EquippedName.text=""
					InventoryWindow.EquippedImage.image=""
					InventoryWindow.is-visible=false
				"})
				usr<<output("<center>","InventoryWindow.EquippedItemInfo")

		ToggleSettingsPanel()
			set hidden=1
			if(winget(src, "SettingsWindow", "is-visible") == "false")
				winset(src, null, {"
					SettingsWindow.is-visible = "true";
				"})
			else
				winset(src, null, {"
					SettingsWindow.is-visible = "false";
				"})

		ToggleLeaderPanel()
			set hidden=1
			if(winget(src, "LeaderWindow", "is-visible") == "false")
				winset(src, null, {"
					LeaderWindow.is-visible = "true";
				"})
			else
				winset(src, null, {"
					LeaderWindow.is-visible = "false";
				"})

		UnlockExperience()
			set hidden=1
			if(src.exp_lock_verify) return
			if(src.mob.exp_locked)
				src.exp_lock_verify=1
				var/verification_code = rand(1000,9999)
				var/verification_response = src.AlertInput("Please enter the following verification code to resume gaining experience: [verification_code]", "Experience Lock", list("Submit", "Cancel"))
				if(verification_response[1] == 1 && text2num(verification_response[2]) == verification_code)
					src << output("You will now resume gaining experience normally.", "ActionPanel.Output")
					winset(src, "NavigationPanel.ExpLockButton", "is-disabled = 'true'")
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
			if(winget(src, "BrowserWindow", "is-visible") == "false")
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

				src << output(null, "BrowserWindow.Output")
				src << browse("[html]")
				winset(src, "BrowserWindow", "is-visible = true")
			else
				winset(src, "BrowserWindow", "is-visible = false")

		JutsuReference()
			set hidden=1
			if(winget(src, "BrowserWindow", "is-visible") == "false")
				var/html_jutsus = ""

				for(var/obj/Jutsus/I in src.mob.JutsusLearnt)
					html_jutsus += {"
						<tr>
							<td>\icon[I] [I.name]</td>
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

				src << output(null, "BrowserWindow.Output")
				src << browse("[html]")
				winset(src, "BrowserWindow", "is-visible = true")
			else
				winset(src, "BrowserWindow", "is-visible = false")

		Changelog()
			set hidden=1
			if(winget(src, "BrowserWindow", "is-visible") == "false")
				src << output(null, "BrowserWindow.Output")
				src << browse("[CHANGELOG]")
				winset(src, "BrowserWindow", "is-visible = true")
			else
				winset(src, "BrowserWindow", "is-visible = false")

		Who()
			set hidden = 1
			if(winget(src, "BrowserWindow", "is-visible") == "false")
				var/online = 0
				var/players = ""
				for(var/client/C)
					if(C)
						online++
						var/obj/Symbols/Village/V = new(C.mob)
						var/obj/Symbols/Rank/R = new(C.mob)
						var/Faction/F = new()
						F.name="-"
						if(C.mob.Faction) F=C.mob.Faction
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

				src << output(null, "BrowserWindow.Output")
				src << browse("[html]")
				winset(src, "BrowserWindow", "is-visible = true")
			else
				winset(src, "BrowserWindow", "is-visible = false")

	proc
		FlashExperienceLock()
			while(src && src.mob.exp_locked)
				if(src) winset(src, "NavigationPanel.ExpLockButton", "text-color=#C80000")
				sleep(10)
				if(src) winset(src, "NavigationPanel.ExpLockButton", "text-color=#C8C8C8")
				sleep(10)
			if(src) winset(src, "NavigationPanel.ExpLockButton", "text-color=#C8C8C8")

		UpdateCharacterPanel()
			if(winget(src, "Character", "is-visible") == "true")
				winset(src, null, {"
					Character.Avatar.image     = "\icon[src.mob.icon]"
					Character.Name.text        = "[src.mob.name]"
					Character.Level.text       = "[src.mob.level]"
					Character.EXP.text         = "[src.mob.exp]/[src.mob.maxexp]"
					Character.EXPBar.value     = "[round(src.mob.exp/src.mob.maxexp*100)]"
					Character.Health.text      = "[src.mob.health]/[src.mob.maxhealth]"
					Character.HealthBar.value  = "[round(src.mob.health/src.mob.maxhealth*100)]"
					Character.Chakra.text      = "[src.mob.chakra]/[src.mob.maxchakra]"
					Character.ChakraBar.value  = "[round(src.mob.chakra/src.mob.maxchakra*100)]"
					Character.Def.text         = "[src.mob.defence]"
					Character.DefEXP.text      = "[src.mob.defexp]/[src.mob.maxdefexp]"
					Character.DefEXPBar.value  = "[round(src.mob.defexp/src.mob.maxdefexp*100)]"
					Character.Agi.text         = "[src.mob.agility]"
					Character.AgiEXP.text      = "[src.mob.agilityexp]/[src.mob.maxagilityexp]"
					Character.AgiEXPBar.value  = "[round(src.mob.agilityexp/src.mob.maxagilityexp*100)]"
					Character.Tai.text         = "[src.mob.strength]"
					Character.TaiEXP.text      = "[src.mob.strengthexp]/[src.mob.maxstrengthexp]"
					Character.TaiEXPBar.value  = "[round(src.mob.strengthexp/src.mob.maxstrengthexp*100)]"
					Character.Nin.text         = "[src.mob.ninjutsu]"
					Character.NinEXP.text      = "[src.mob.ninexp]/[src.mob.maxninexp]"
					Character.NinEXPBar.value  = "[round(src.mob.ninexp/src.mob.maxninexp*100)]"
					Character.Gen.text         = "[src.mob.genjutsu]"
					Character.GenEXP.text      = "[src.mob.genexp]/[src.mob.maxgenexp]"
					Character.GenEXPBar.value  = "[round(src.mob.genexp/src.mob.maxgenexp*100)]"
					Character.StatPoints.text  = "[src.mob.statpoints]"
					Character.SkillPoints.text = "[src.mob.skillpoints]"
				"})

		UpdateInventoryPanel()
			set hidden=1
			if(winget(src, "InventoryWindow", "is-visible") == "true")
				winset(src,"InventoryWindow.Ryo","text=\"[src.mob.Ryo]\"")
				winset(src,"InventoryWindow.Titlebar","text=\"Inventory - [src.mob.items]/[src.mob.maxitems]\"")
				winset(src,"InventoryWindow.Grid","cells=0x0")
				var/Row = 1
			//	src<<output("Ryo:","Equip.GridEquip:1,1")
			//	src<<output("Items:","Equip.GridEquip:1,2")
			//	src<<output("[src.items]/[src.maxitems]","Equip.GridEquip:2,2")
				src<<output(" ","InventoryWindow.Grid:1,1")
				for(var/obj/O in src.mob.contents)
					Row++
					src << output(O,"InventoryWindow.Grid:1,[Row]")
					src << output("<span style='text-align: right;'>[O.suffix]</span>","InventoryWindow.Grid:2,[Row]")
					sleep(1)