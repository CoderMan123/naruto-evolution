mob/var/Bounty
proc/BountyText(number)
	if(number<50)return "D Rank"
	if(number<200&&number>49)return "C Rank"
	if(number<400&&number>199)return "B Rank"
	if(number<1000&&number>399)return "A Rank"
	if(number>999)return "S Rank"
	return "Unknown Rank"
mob/verb/BingoBook()
	set hidden=1
	set category="Commands"
	var/People=0
	var/HTML="<body bgcolor=black><font color=white><center><b>Bingo Book</i><br><i>(Currently Wanted Online Shinobi)</i></center><br><hr><br>"
	for(var/mob/player/M in mobs_online)
		if(M.key&&M.client&&M.Bounty)
			People=1
			HTML+="<center><font color=white>[M.name] ([M.key]) : [BountyText(M.kills)] ($[M.Bounty])</font></center>"
	if(!People) HTML+="<center><font color=white>There is nobody wanted online.</font></center>"
	src<<browse(HTML)
	winset(src, null, {"
						BrowserWindow.is-visible = "true";
					"})