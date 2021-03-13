client
	var/tmp/channel = "Local"
	Topic(href, href_list)
		if(href_list["changelog"] && href_list["changelog"] == "current")
			src << browse("[CHANGELOG]")
			winset(src, "BrowserWindow", "is-visible = 'true'")

		else if(href_list["changelog"] && href_list["changelog"] == "previous")
			src << browse("[CHANGELOG_PREVIOUS]")
			winset(src, "BrowserWindow", "is-visible = 'true'")
		..()

	verb
		Tab()
			set hidden=1
			world << winget(src, null, "focus")

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