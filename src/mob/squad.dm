client
	Topic(href, href_list)
		..()
		switch(href_list["action"])
			if("squad-create")
				var/client/c = locate(href_list["src"])
				for(var/client/client in clients_online)
					if(c.ckey == client.ckey)
						c = client
						break

				var/squad/squad = new()
				squad.Create(c.mob)

			if("squad-invite")
				var/client/c = locate(href_list["src"])
				for(var/client/client in clients_online)
					if(c.ckey == client.ckey)
						c = client
						break

				var/squad/squad = c.mob.GetSquad()
				if(squad) squad.Invite(c.mob)

			if("squad-promote")
				var/squad/squad = src.mob.GetSquad()
				if(squad) squad.ChangeLeader(src.mob, href_list["ckey"])

			if("squad-kick")
				var/client/c = locate(href_list["src"])
				for(var/client/client in clients_online)
					if(c.ckey == client.ckey)
						c = client
						break

				var/squad/squad = c.mob.GetSquad()
				if(squad) squad.Kick(c.mob, href_list["ckey"])

			if("squad-leave")
				var/squad/squad = src.mob.GetSquad()
				if(squad) squad.Leave(src.mob)

			if("squad-disband")
				var/client/c = locate(href_list["src"])
				for(var/client/client in clients_online)
					if(c.ckey == client.ckey)
						c = client
						break

				var/squad/squad = c.mob.GetSquad()
				if(squad) squad.Disband(c.mob)

squad
	var/leader[0]
	var/members[0]
	var/levels[0]
	var/villages[0]
	var/ranks[0]
	var/factions[0]
	var/mission/mission

	proc/Create(mob/M)
		if(!M.GetSquad())
			if(M.client.Alert("Would you like to create a Squad?", "Squad", list("Yes", "No")) == 1)
				src.leader[M.ckey] = M.character
				src.members[M.ckey] = M.character
				src.levels[M.ckey] = M.level
				src.villages[M.ckey] = M.village
				src.ranks[M.ckey] = M.rank
				squads += src
				src.Refresh()
		else
			M.client.Alert("Please leave or disband the Squad you are already in before you try and create a new one.", "Squad")

	proc/Disband(mob/M)
		if(src.leader[M.ckey])
			if(src.mission)
				M.client.Alert("You can't disband your squad while on a mission.")
			else
				for(var/ckey in src.members)
					for(var/mob/m in mobs_online)
						if(m.client.ckey == ckey)
							m.client.browser=BROWSER_NONE
							winset(m.client, "Browser", "is-visible = false")
							break

				src.leader = new()
				src.members = new()
				src.Refresh()
				squads -= src
		else
			M.client.Alert("Only the Squad Leader can disband the Squad.", "Squad")

	proc/Invite(mob/M)
		if(src.leader[M.ckey])
			if(src.mission)
				M.client.Alert("You can't invite anyone to your squad while on a mission.")

			else if(src.members.len > 4)
				M.client.Alert("Your squad is already at max capacity.", "Invite to Squad")
			else
				var/mob/m = input("Who would you like to invite into your squad?", "Invite to Squad") as null|anything in mobs_online
				if(src && src.leader[M.client.ckey] && m)
					if(!m.GetSquad())
						if(m.client.Alert("Would you like to join [M]'s squad?", "Join Squad", list("Yes", "No")) == 1)
							if(!m.GetSquad())
								if(M.GetSquad() == src)
									var/squad/squad = M.GetSquad()
									if(squad)
										squad.members[m.ckey] = m.character
										squad.levels[m.ckey] = m.level
										squad.villages[m.ckey] = m.village
										squad.ranks[m.ckey] = m.rank
										src.Refresh()
									else m.client.Alert("You cannot join [M]'s squad because the squad no longer exists.")
								else
									m.client.Alert("You cannot join [M]'s squad because they are no longer the squad leader.", "Join Squad")
							else
								m.client.Alert("You cannot join [M]'s squad because you've already joined another squad.")
					else
						M.client.Alert("[m] is already in a squad.", "Invite to Squad")
		else
			M.client.Alert("Only the Squad Leader can invite someone to the Squad.", "Squad")

	proc/Leave(mob/M)
		if(src.mission)
			M.client.Alert("You can't leave your squad while on a mission.")
		else
			switch(M.client.Alert("Are you sure you want to leave your squad?", "Leave Squad", list("Yes", "No")))
				if(1)
					if(src.leader[M.ckey])
						for(var/client/C in clients_online) if(C.ckey in src.members - M.ckey)
							spawn() C.Alert("[M] has disbanded the squad.", "Disband Squad")

						src.Disband(M)
						M.client.Alert("You have disbanded the squad.", "Disband Squad")
					else
						src.members -= M.ckey
						src.Refresh()
						M.client.Alert("You have left the squad.", "Leave Squad")

	proc/Kick(mob/M, var/ckey)
		if(src.leader[M.ckey])
			if(src.mission)
				M.client.Alert("You can't kick someone from your squad while on a mission.")

			else
				if(ckey in src.members)
					for(var/client/c in clients_online)
						if(c.ckey in src.members)
							c << "[src.members[ckey]] was kicked from the Squad."
							c.browser=BROWSER_SQUAD
							winset(c, "Browser", "is-visible = true")

					if(ckey in src.members)
						src.members -= ckey
						src.levels -= ckey
						src.villages -= ckey
						src.ranks -= ckey

					src.Refresh()

		else
			M.client.Alert("Only the Squad Leader can kick someone from the Squad.", "Squad")

	proc/ChangeLeader(mob/M)
		if(src.leader[M.ckey])
			var/member = input("Who would you like to make the Squad Leader?", "Squad") as null|anything in src.members
			if(member)
				if(member in src.members)
					if(M.ckey == member)
						M.client.Alert("You are already the Squad Leader.", "Squad")
					else
						switch(M.client.Alert("Are you sure you want to promote [src.members[member]] to Squad Leader?", "Leave Squad", list("Yes", "No")))
							if(1)
								if(src.leader[M.ckey])
									if(member in src.members)
										if(M.ckey != member)
											src.leader = new()
											src.leader[member] = src.members[member]
											src.Refresh()
										else
											M.client.Alert("You are already the Squad Leader.", "Squad")
									else
										M.client.Alert("[member] is no longer in the Squad.", "Squad")
								else
									M.client.Alert("Only the Squad Leader can promote someone to the Squad Leader.", "Squad")
				else
					src.Refresh()
					M.client.Alert("[member] is no longer in the Squad.", "Squad")
		else
			M.client.Alert("Only the Squad Leader can promote someone to the Squad Leader.", "Squad")

	proc/RefreshMember(mob/M)
		if(src && M && src.members[M.client.ckey] && src.members[M.ckey] == M.character && M.client.browser == BROWSER_SQUAD && winget(M.client, "Browser", "is-visible") == "true")
			src.levels[M.ckey] = M.level
			src.villages[M.ckey] = M.village
			src.ranks[M.ckey] = M.rank
			M.Squad()
			M.Squad()

	proc/Refresh()
		for(var/client/c in clients_online)
			if(src && c && src.members[c.ckey] && src.members[c.ckey] == c.mob.character && c.browser == BROWSER_SQUAD && winget(c, "Browser", "is-visible") == "true")
				src.levels[c.ckey] = c.mob.level
				src.villages[c.ckey] = c.mob.village
				src.ranks[c.ckey] = c.mob.rank

				c.mob.Squad()
				c.mob.Squad()

mob
	proc/GetSquad()
		for(var/squad/squad in squads)
			if(squad.leader[src.ckey] && squad.leader[src.ckey] == src.character || squad.members[src.ckey] && squad.members[src.ckey] == src.character) return squad
			else continue

	verb/Squad()
		set hidden = 1
		if(winget(src, "Browser", "is-visible") == "false")
			var/squad/squad = src.GetSquad()
			if(!squad)
				var/html = {"
					<!doctype html>
					<html lang="en">
					<head>
						<title>Squad</title>

						<!-- Required meta tags -->
						<meta charset="utf-8">
						<meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">

						<!-- Bootstrap CSS -->
						<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.0/css/bootstrap.min.css" integrity="sha384-9aIt2nRpC12Uk9gS9baDl411NQApFmC26EwAOH8WgZl5MYYxFfc+NcPb1dKGj7Sk" crossorigin="anonymous">

						<!-- Google Fonts -->
						<link href="https://fonts.googleapis.com/css2?family=Open+Sans&display=swap" rel="stylesheet">

						<style>
							body {
								padding: 10px;
								background-color: #414141;
								color: #C8C8C8;
								font-family: 'Open Sans', sans-serif;
							}

							h1 {
								margin: 0px;
							}

							h2 {
								margin-top: 16px;
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
						<h1>Squad</h1>

						<h2>Create Squad</h1>

						<span>\[<a href='?src=\ref[src];action=squad-create;ckey=[ckey]'>Create</a>]</span>

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
				src.client.browser=BROWSER_SQUAD
				winset(src, "Browser", "is-visible = true")
			else
				var/squad_members
				var/squad_management
				var/mission
				var/mission_management

				if(squad.leader[src.ckey])
					squad_management = {"
						<h2 class="spacer">Squad Management</h1>

						<span>\[<a href='?src=\ref[src];action=squad-invite;ckey=[ckey]'>Invite</a>]</span>
						<span>\[<a href='?src=\ref[src];action=squad-disband;ckey=[ckey]'>Disband</a>]</span>
					"}

				if(squad.leader[src.ckey] && squad.mission && !squad.mission.complete)
					mission_management = {"
						<span>\[<a href='?src=\ref[src];action=mission-abandon;ckey=[ckey]'>Abandon</a>]</span>
					"}

				if(squad.mission)
					var/start
					var/complete
					var/timer
					var/score
					if(squad.mission.start) start = time2text(squad.mission.start, "MM/DD/YYYY hh:mm:ss")
					if(squad.mission.complete) complete = time2text(squad.mission.complete, "MM/DD/YYYY hh:mm:ss")
					timer = squad.mission.GetTimer()
					if(timer <= squad.mission.limit && squad.mission.complete)
						score = "Pass"
					else if(timer > squad.mission.limit)
						score = "Fail"
					else
						score = "TBD"
					mission = {"
						<h2>Mission</h2>

						<table class="table table-sm table-hover">
							<thead>
								<tr>
									<th scope="col">Mission</th>
									<th scope="col">Start</th>
									<th scope="col">Complete</th>
									<th scope="col">Timer</th>
									<th scope="col">Limit</th>
									<th scope="col">Score</th>
								</tr>
							</thead>
							<tbody>
								<tr>
									<td>[squad.mission] <span>\[<a href='?src=\ref[src];action=mission-view;ckey=[ckey]'>View</a>]</span> [mission_management]</td>
									<td>[start]</td>
									<td>[complete]</td>
									<td>[round(timer, 0.01)] m</td>
									<td>[squad.mission.limit] m</td>
									<td>[score]</td>
								</tr>
							</tbody>
						</table>
					"}

				for(var/ckey in squad.members)
					//You're the Leader, ckey is not
					if(squad.leader[src.ckey] && !squad.leader[ckey])
						squad_members += {"
							<tr>
								<td>[squad.members[ckey]]</td>
								<td><span>\[<a href='?action=squad-promote;src=\ref[src];ckey=[ckey]'>Promote</a>] \[<a href='?action=squad-kick;src=\ref[src];ckey=[ckey]'>Kick</a></span>]</td>
								<td>[squad.levels[ckey]]</td>
								<td>[squad.villages[ckey]]</td>
								<td>[squad.ranks[ckey]]</td>
								<td>Unknown</td>
							</tr>
						"}

					else if(squad.leader[ckey]  && src.ckey != ckey)
						var/obj/Symbols/Squad/S = new(src, ckey)
						squad_members += {"
						<tr>
							<td>\icon[S] [squad.members[ckey]]</td>
							<td></td>
							<td>[squad.levels[ckey]]</td>
							<td>[squad.villages[ckey]]</td>
							<td>[squad.ranks[ckey]]</td>
							<td>Unknown</td>
						</tr>
					"}

					else if(squad.leader[ckey]  && src.ckey == ckey)
						var/obj/Symbols/Squad/S = new(src, ckey)
						squad_members += {"
						<tr>
							<td>\icon[S] [squad.members[ckey]]</td>
							<td><span>\[<a href='?action=squad-leave;src=\ref[src];ckey=[ckey]'>Leave</a>]</td>
							<td>[squad.levels[ckey]]</td>
							<td>[squad.villages[ckey]]</td>
							<td>[squad.ranks[ckey]]</td>
							<td>Unknown</td>
						</tr>
					"}

					else if(!squad.leader[ckey] && src.ckey != ckey)
						squad_members += {"
							<tr>
								<td>[squad.members[ckey]]</td>
								<td></td>
								<td>[squad.levels[ckey]]</td>
								<td>[squad.villages[ckey]]</td>
								<td>[squad.ranks[ckey]]</td>
								<td>Unknown</td>
							</tr>
						"}

					else if(!squad.leader[ckey] && src.ckey == ckey)
						squad_members += {"
							<tr>
								<td>[squad.members[ckey]]</td>
								<td><span>\[<a href='?action=squad-leave;src=\ref[src];ckey=[ckey]'>Leave</a>]</td>
								<td>[squad.levels[ckey]]</td>
								<td>[squad.villages[ckey]]</td>
								<td>[squad.ranks[ckey]]</td>
								<td>Unknown</td>
							</tr>
						"}


				var/html = {"
					<!doctype html>
					<html lang="en">
					<head>
						<title>Squad</title>

						<!-- Required meta tags -->
						<meta charset="utf-8">
						<meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">

						<!-- Bootstrap CSS -->
						<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.0/css/bootstrap.min.css" integrity="sha384-9aIt2nRpC12Uk9gS9baDl411NQApFmC26EwAOH8WgZl5MYYxFfc+NcPb1dKGj7Sk" crossorigin="anonymous">

						<!-- Google Fonts -->
						<link href="https://fonts.googleapis.com/css2?family=Open+Sans&display=swap" rel="stylesheet">

						<style>
							body {
								padding: 10px;
								background-color: #414141;
								color: #C8C8C8;
								font-family: 'Open Sans', sans-serif;
							}

							h1 {
								margin: 0px;
							}

							h2 {
								margin-top: 16px;
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

							spacer {
								padding-top: 32px;
							}
						</style>
					</head>

					<body>
						<h1>Squad</h1>

						[squad_management]

						<h2>Squad Members</h2>

						<table class="table table-sm table-hover">
							<thead>
								<tr>
									<th scope="col">Character</th>
									<th scope="col"></th>
									<th scope="col">Level</th>
									<th scope="col">Village</th>
									<th scope="col">Rank</th>
									<th scope="col">Faction</th>
								</tr>
							</thead>
							<tbody>
								[squad_members]

								<tr>
									<td><span style="font-weight: bold;">Total Squad Members:</span> [squad.members.len]/4</td>
									<td></td>
									<td></td>
									<td></td>
									<td></td>
									<td></td>
								</tr>
							</tbody>
						</table>

						[mission]

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
				src.client.browser=BROWSER_SQUAD
				winset(src, "Browser", "is-visible = true")
		else
			src.client.browser=BROWSER_NONE
			winset(src, "Browser", "is-visible = false")