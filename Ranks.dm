mob/Kage/verb
	Boot_From_Village()
		set category="Kage"
		var/list/X = list()
		for(var/mob/player/e in world) if(e.ckey) X["[e.name] ([e.key])"]=e
		var/mob/P=CustomInput("Who do you want to use this on?","Invite",X+"Cancel")
		if(P=="Cancel") return
		var/mob/M = X["[P]"]
		if(M==src) return
		//if(Kages["[Village]"]!=src.ckey) return
		if(M.village!=src.village)
			src<<output("They're not from your village.","actionoutput")
			return
		if(skalert("Are you sure you want to boot [M] from the [village] village?","Confirm",list("No","Yes"))=="No") return
		world<<output("[M] has been booted from the [village] village.","actionoutput")
		M.village="Missing-Nin"
		M.rank="Missing-Nin"
	Invite_to_Village()
		set category="Kage"
		var/list/X = list()
		for(var/mob/player/e in world) if(e.ckey) X["[e.name] ([e.key])"]=e
		var/mob/P=CustomInput("Who do you want to use this on?","Invite",X+"Cancel")
		if(P=="Cancel") return
		var/mob/M = X["[P]"]
		if(M==src) return
		//if(Kages["[Village]"]!=src.ckey) return
		if(M.village!="Missing-Nin")
			src<<output("They're not a Missing Ninja.","actionoutput")
			return
		if(M.skalert("[src] invites you to join the [village] village, accept?","Confirm",list("No","Yes"))=="No") return
		world<<output("[M] has joined the [village] village.","actionoutput")
		M.village="[village]"
		M.rank="Genin"
	Make_ANBU()
		set category="Kage"
		var/list/X = list()
		for(var/mob/player/e in world) if(e.ckey) X["[e.name] ([e.key])"]=e
		var/mob/P=CustomInput("Who do you want to promote to ANBU?","Promote",X+"Cancel")
		if(P=="Cancel") return
		var/mob/M = X["[P]"]
		if(M==src) return
		//if(Kages["[Village]"]!=src.ckey) return
		if(M.village!=src.village)
			src<<output("They're not from your village.","actionoutput")
			return
		if(M.rank!="Jounin")
			src<<output("They are not Jounin yet.","actionoutput")
			return
		M<<output("You have been promoted the ANBU Ops.","actionoutput")
		M.rank="ANBU"
		new/obj/Inventory/Clothing/Masks/Anbu(M)
	Demote_ANBU()
		set category="Kage"
		var/list/X = list()
		for(var/mob/player/e in world) if(e.ckey&&e.rank=="ANBU") X["[e.name] ([e.key])"]=e
		var/mob/P=CustomInput("Who do you want to demote from ANBU?","Demotion",X+"Cancel")
		if(P=="Cancel") return
		var/mob/M = X["[P]"]
		if(M==src) return
		//if(Kages["[Village]"]!=src.ckey) return
		if(M.village!=src.village) return
		if(M.rank!="ANBU") return
		M<<output("You have been booted from the ANBU Ops, and are now a Jounin.","actionoutput")
		M.rank="Jounin"
		for(var/obj/Inventory/Clothing/Masks/Anbu/O in M)
			if(ClothingOverlays[O.section]==O.icon)
				RemoveSection(O.section)
			del(O)
		M.overlays=null
		M.RestoreOverlays()
		M.RemoveAdminVerbs()
	Make_Jounin()
		set category="Kage"
		var/list/X = list()
		for(var/mob/player/e in world) if(e.ckey) X["[e.name] ([e.key])"]=e
		var/mob/P=CustomInput("Who do you want to promote to Jounin?","Promote",X+"Cancel")
		if(P=="Cancel") return
		var/mob/M = X["[P]"]
		if(M==src) return
		//if(Kages["[Village]"]!=src.ckey) return
		if(M.village!=src.village)
			src<<output("They're not from your village.","actionoutput")
			return
		if(M.rank!="Chuunin")
			src<<output("They're not a Chuunin yet.","actionoutput")
			return
		M<<output("You have been promoted to Jounin.","actionoutput")
		M.rank="Jounin"
	Demote_Jounin()
		set category="Kage"
		var/list/X = list()
		for(var/mob/player/e in world) if(e.ckey&&e.rank=="Jounin") X["[e.name] ([e.key])"]=e
		var/mob/P=CustomInput("Who do you want to demote from Jounin?","Demotion",X+"Cancel")
		if(P=="Cancel") return
		var/mob/M = X["[P]"]
		if(M==src) return
		//if(Kages["[Village]"]!=src.ckey) return
		if(M.village!=src.village) return
		if(M.rank!="Jounin") return
		M<<output("You have been demoted from Jounin, and are now a Chuunin.","actionoutput")
		M.rank="Chuunin"
		for(var/obj/Inventory/Clothing/Masks/Anbu/O in M)
			if(ClothingOverlays[O.section]==O.icon)
				RemoveSection(O.section)
			del(O)
		M.overlays=null
		M.RestoreOverlays()
		M.RemoveAdminVerbs()
	Retire()
		set category="Kage"
		var/list/X=list()
		if(skalert("Are you sure you would like to retire as kage?","Confirmation",list("No","Yes"))=="No") return
		for(var/mob/player/M in world)
			if(M==src||!M.client||!M.key||M.village!=src.village) continue
			X+=M
		for(var/mob/player/e in world) if(e.ckey) X["[e.name] ([e.key])"]=e
		var/mob/P=CustomInput("Who do you want to appoint as your successor?","Appoint Successor",X+"Cancel")
		if(P=="Cancel") return
		var/mob/M = X["[P]"]
		if(!M)
			src<<"Messed up, please try again."
			return
		Kages["[village]"]=null
		rank="Jounin"
		RemoveAdminVerbs()
		switch(village)
			if("Hidden Leaf")
				world<<output("<b><center>[src] has retired as Hokage, and [M] has been promoted as their successor!<b></center>","actionoutput")
				M.rank="Hokage"
				Kages["Hidden Leaf"]=M.ckey
			if("Hidden Sand")
				world<<output("<b><center>[src] has retired as Kazekage, and [M] has been promoted as their successor!<b></center>","actionoutput")
				M.rank="Kazekage"
				Kages["Hidden Sand"]=M.ckey
			if("Hidden Sound")
				world<<output("<b><center>[src] has retired as Sound Leader, and [M] has been promoted as their successor!<b></center>","actionoutput")
				M.rank="Sound Leader"
				Kages["Hidden Sound"]=M.ckey
		M.StaffCheck()
mob/AkatsukiLeader/verb/
	Make_Akatsuki()
		set category="Akatsuki"
		var/list/X=list()
		for(var/mob/player/e in world) if(e.ckey) X["[e.name] ([e.key])"]=e
		var/mob/P=CustomInput("Who do you want to invite to the Akatsuki?","Invite",X+"Cancel")
		if(P=="Cancel")return
		var/mob/M = X["[P]"]
		if(M==src)return
		//if(Positions["Akatsuki Leader"]!=src.ckey) return
		if(M.village!="Missing-Nin") return
		if(skalert("Are you sure you want to invite [M] to be a Akatsuki?","Confirm",list("No","Yes"))=="No") return
		if(M.skalert("You have been invited to join the Akatsuki. Accept, decline?","Confirm",list("Accept","Decline"))=="Decline") return
		for(var/mob/Z in world) if(Z.village=="Akatsuki") Z<<"[M] has joined your ranks."
		M.village="Akatsuki"
		M.rank="Akatsuki"
		new/obj/Inventory/Clothing/Shirt/Akatsuki_Robe(M)
		M.StaffCheck()
	Remove_Akatsuki()
		set category="Akatsuki"
		var/list/X=list()
		for(var/mob/player/e in world) if(e.ckey) X["[e.name] ([e.key])"]=e
		var/mob/P=CustomInput("Who do you want to remove from the Akatsuki?","Invite",X+"Cancel")
		if(P=="Cancel")return
		var/mob/M = X["[P]"]
		if(M==src)return
		//if(Positions["Akatsuki Leader"]!=src.ckey) return
		if(M.village!="Akatsuki") return
		if(skalert("Are you sure you want to boot [M] from the [village]?","Confirm",list("No","Yes"))=="No") return
		M.village="Missing-Nin"
		M.rank="Missing-Nin"
		for(var/obj/Inventory/Clothing/Shirt/Akatsuki_Robe/O in M)
			if(ClothingOverlays[O.section]==O.icon)RemoveSection(O.section)
			del(O)
		M.overlays=null
		M.RestoreOverlays()
		M.RemoveAdminVerbs()
	Retire()
		set category="Akatsuki"
		var/list/X=list()
		if(skalert("Are you sure you would like to retire as Akatsuki Leader?","Confirmation",list("No","Yes"))=="No") return
		for(var/mob/player/e in world) if(e.ckey) X["[e.name] ([e.key])"]=e
		var/mob/P=CustomInput("Who do you want to appoint as your successor?","Appoint Successor",X+"Cancel")
		if(P=="Cancel")return
		var/mob/M = X["[P]"]
		rank="Missing-Nin"
		village="Missing-Nin"
		for(var/obj/Inventory/Clothing/Shirt/Akatsuki_Robe/O in src)
			if(ClothingOverlays[O.section]==O.icon)RemoveSection(O.section)
			del(O)
		overlays=null
		RestoreOverlays()
		RemoveAdminVerbs()
		M.rank="Akatsuki Leader"
		M.StaffCheck()