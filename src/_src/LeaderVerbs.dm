mob/Kage/verb
	Boot_From_Village()
		set category="Kage"
		var/list/X = list()
		for(var/mob/player/M in world)
			if(M==src||!M.client||!M.key||M.village!=src.village) continue
			X+=M
		for(var/mob/player/e in X) if(e.ckey) X["[e.name] ([e.key])"]=e
		var/mob/P=CustomInput("Who do you want to use this on?","Invite",X+"Cancel")
		if(P=="Cancel") return
		var/mob/M = X["[P]"]
		if(M==src) return
		//if(Kages["[Village]"]!=src.ckey) return
		if(M.village!=src.village)
			src<<output("They're not from your village.","ActionPanel.Output")
			return
		if(client.Alert("Are you sure you want to boot [M] from the [village] village?","Confirm",list("No","Yes"))==1) return
		world<<output("[M] has been booted from the [village] village.","ActionPanel.Output")
		M.village="Missing-Nin"
		M.rank="Missing-Nin"
	Invite_to_Village()
		set category="Kage"
		var/list/X = list()
		for(var/mob/player/M in world)
			if(M==src||!M.client||!M.key||M.rank != "Missing-Nin") continue
			X+=M
		for(var/mob/player/e in X) if(e.ckey) X["[e.name] ([e.key])"]=e
		var/mob/P=CustomInput("Who do you want to use this on?","Invite",X+"Cancel")
		if(P=="Cancel") return
		var/mob/M = X["[P]"]
		if(M.client.Alert("[src] invites you to join the [village] village, accept?","Confirm",list("No","Yes"))==1) return
		world<<output("[M] has joined the [village] village.","ActionPanel.Output")
		M.village="[village]"
		M.rank="Genin"
	Make_ANBU()
		set category="Kage"
		var/list/X = list()
		for(var/mob/player/M in world)
			if(M==src||!M.client||!M.key||M.village!=src.village||M.rank != "Jounin") continue
			X+=M
		for(var/mob/player/e in X) if(e.ckey) X["[e.name] ([e.key])"]=e
		var/mob/P=CustomInput("Who do you want to promote to ANBU?","Promote",X+"Cancel")
		if(P=="Cancel") return
		var/mob/M = X["[P]"]
		M<<output("You have been promoted to the ANBU Ops.","ActionPanel.Output")
		M.rank="ANBU"
		if(M.village=="Hidden Leaf")//"Hidden Sand"||"Hidden Mist"||
			new/obj/Inventory/Clothing/Masks/Anbu(M)
		if(M.village=="Hidden Sand")
			new/obj/Inventory/Clothing/Masks/Anbu_Black(M)
		if(M.village=="Hidden Mist")
			new/obj/Inventory/Clothing/Masks/Anbu_Blue(M)
		if(M.village=="Hidden Sound")
			new/obj/Inventory/Clothing/Masks/Anbu_Purple(M)
		if(M.village=="Hidden Rock")
			new/obj/Inventory/Clothing/Masks/Anbu_Brown(M)
		else return
	Demote_ANBU()
		set category="Kage"
		var/list/X = list()
		for(var/mob/player/M in world)
			if(M==src||!M.client||!M.key||M.village!=src.village||M.rank != "ANBU") continue
			X+=M
		for(var/mob/player/e in X) if(e.ckey&&e.rank=="ANBU") X["[e.name] ([e.key])"]=e
		var/mob/P=CustomInput("Who do you want to demote from ANBU?","Demotion",X+"Cancel")
		if(P=="Cancel") return
		var/mob/M = X["[P]"]
		M<<output("You have been booted from the ANBU Ops, and are now a Jounin.","ActionPanel.Output")
		M.rank="Jounin"
		for(var/obj/Inventory/Clothing/Masks/Anbu/O in M)
			if(ClothingOverlays[O.section]==O.icon)
				RemoveSection(O.section)
			del(O)
		for(var/obj/Inventory/Clothing/Masks/Anbu_Black/O in M)
			if(ClothingOverlays[O.section]==O.icon)
				RemoveSection(O.section)
			del(O)
		M.overlays=null
		M.RestoreOverlays()
		M.RemoveAdminVerbs()
	Make_Jounin()
		set category="Kage"
		var/list/X = list()
		for(var/mob/player/M in world)
			if(M==src||!M.client||!M.key||M.village!=src.village||M.rank != "Chuunin") continue
			X+=M
		for(var/mob/player/e in X) if(e.ckey) X["[e.name] ([e.key])"]=e
		var/mob/P=CustomInput("Who do you want to promote to Jounin?","Promote",X+"Cancel")
		if(P=="Cancel") return
		var/mob/M = X["[P]"]
		M<<output("You have been promoted to Jounin.","ActionPanel.Output")
		M.rank="Jounin"
	Demote_Jounin()
		set category="Kage"
		var/list/X = list()
		for(var/mob/player/M in world)
			if(M==src||!M.client||!M.key||M.village!=src.village||M.rank != "Jounin") continue
			X+=M
		for(var/mob/player/e in X) if(e.ckey&&e.rank=="Jounin") X["[e.name] ([e.key])"]=e
		var/mob/P=CustomInput("Who do you want to demote from Jounin?","Demotion",X+"Cancel")
		if(P=="Cancel") return
		var/mob/M = X["[P]"]
		M<<output("You have been demoted from Jounin, and are now a Chuunin.","ActionPanel.Output")
		M.rank="Chuunin"
		for(var/obj/Inventory/Clothing/Masks/Anbu/O in M)
			if(ClothingOverlays[O.section]==O.icon)
				RemoveSection(O.section)
			del(O)
		for(var/obj/Inventory/Clothing/Masks/Anbu_Black/O in M)
			if(ClothingOverlays[O.section]==O.icon)
				RemoveSection(O.section)
			del(O)
		M.overlays=null
		M.RestoreOverlays()
		M.RemoveAdminVerbs()
		M.overlays=null
		M.RestoreOverlays()
		M.RemoveAdminVerbs()
		M.overlays=null
		M.RestoreOverlays()
		M.RemoveAdminVerbs()
	Retire()
		set category="Kage"
		var/list/X=list()
		if(client.Alert("Are you sure you would like to retire as kage?","Confirmation",list("No","Yes"))==1) return
		for(var/mob/player/M in world)
			if(M==src||!M.client||!M.key||M.village!=src.village) continue
			X+=M
		for(var/mob/player/e in X) if(e.ckey) X["[e.name] ([e.key])"]=e
		var/mob/P=CustomInput("Who do you want to appoint as your successor?","Appoint Successor",X+"Cancel")
		if(P=="Cancel") return
		if(P==src)
			src<<"You're already the kage."
			return
		var/mob/M = X["[P]"]
		if(!M)
			src<<"Something went wrong, please try again."
			return
		Kages["[village]"]=null
		rank="Elder"
		RemoveAdminVerbs()
		switch(village)
			if("Hidden Leaf")
				world<<output("<b><center>[src] has retired as Hokage, and [M] has been promoted as their successor!<b></center>","ActionPanel.Output")
				text2file("[src] has retired as Hokage, and [M] has been promoted as their successor!: [time2text(world.timeofday, "MMM DD hh:mm:ss")]<br>",LOG_STAFF)

				M.rank="Hokage"
				Kages["Hidden Leaf"]=M.ckey
				M.village="Hidden Leaf"
				for(var/obj/Inventory/Clothing/HeadWrap/HokageHat/S in src)
					del(S)
				for(var/obj/Inventory/Clothing/Robes/HokageRobe/S in src)
					del(S)
				new/obj/Inventory/Clothing/HeadWrap/HokageHat(M)
				new/obj/Inventory/Clothing/Robes/HokageRobe(M)
			if("Hidden Sand")
				world<<output("<b><center>[src] has retired as Kazekage, and [M] has been promoted as their successor!<b></center>","ActionPanel.Output")
				text2file("[src] has retired as Kazekage, and [M] has been promoted as their successor!: [time2text(world.timeofday, "MMM DD hh:mm:ss")]<br>",LOG_STAFF)

				M.rank="Kazekage"
				Kages["Hidden Sand"]=M.ckey
				M.village="Hidden Sand"
				for(var/obj/Inventory/Clothing/HeadWrap/KazekageHat/S in src)
					del(S)
				for(var/obj/Inventory/Clothing/Robes/KazekageRobe/S in src)
					del(S)
				new/obj/Inventory/Clothing/HeadWrap/KazekageHat(M)
				new/obj/Inventory/Clothing/Robes/KazekageRobe(M)
			if("Hidden Mist")
				world<<output("<b><center>[src] has retired as Mizukage, and [M] has been promoted as their succesor!<b></center>","ActionPanel.Output")
				text2file("[src] has retired as Mizukage, and [M] has been promoted as their successor!: [time2text(world.timeofday, "MMM DD hh:mm:ss")]<br>",LOG_STAFF)

				M.rank="Mizukage"
				Kages["Hidden Mist"]=M.ckey
				M.village="Hidden Mist"
				for(var/obj/Inventory/Clothing/HeadWrap/MizukageHat/S in src)
					del(S)
				for(var/obj/Inventory/Clothing/Robes/MizukageRobe/S in src)
					del(S)
				new/obj/Inventory/Clothing/HeadWrap/MizukageHat(M)
				new/obj/Inventory/Clothing/Robes/MizukageRobe(M)
			if("Hidden Sound")
				world<<output("<b><center>[src] has retired as Otokage, and [M] has been promoted as their successor!<b></center>","ActionPanel.Output")
				text2file("[src] has retired as Otokage, and [M] has been promoted as their successor!: [time2text(world.timeofday, "MMM DD hh:mm:ss")]<br>",LOG_STAFF)

				M.rank="Otokage"
				Kages["Hidden Sound"]=M.ckey
				M.village="Hidden Sound"
				for(var/obj/Inventory/Clothing/HeadWrap/OtokageHat/S in src)
					del(S)
				for(var/obj/Inventory/Clothing/Robes/OtokageRobe/S in src)
					del(S)
				new/obj/Inventory/Clothing/HeadWrap/OtokageHat(M)
				new/obj/Inventory/Clothing/Robes/OtokageRobe(M)
			if("Hidden Rock")
				world<<output("<b><center>[src] has retired as Tsuchikage, and [M] has been promoted as their successor!<b></center>","ActionPanel.Output")
				text2file("[src] has retired as Tsuchikage, and [M] has been promoted as their successor!: [time2text(world.timeofday, "MMM DD hh:mm:ss")]<br>",LOG_STAFF)

				M.rank="Tsuchikage"
				Kages["Hidden Rock"]=M.ckey
				M.village="Hidden Rock"
				for(var/obj/Inventory/Clothing/HeadWrap/TsuchikageHat/S in src)
					del(S)
				for(var/obj/Inventory/Clothing/Robes/TsuchikageRobe/S in src)
					del(S)
				new/obj/Inventory/Clothing/HeadWrap/TsuchikageHat(M)
				new/obj/Inventory/Clothing/Robes/TsuchikageRobe(M)
		M.AddAdminVerbs()
		src.overlays=0
		src.RestoreOverlays()
mob/AnbuLeader/verb/
	Make_Anbu_Root()
		set category="Anbu Root"
		var/list/X=list()
		for(var/mob/player/e in world) if(e.ckey) X["[e.name] ([e.key])"]=e
		var/mob/P=CustomInput("Who do you want to invite to the Anbu Root?","Invite",X+"Cancel")
		if(P=="Cancel")return
		var/mob/M = X["[P]"]
		if(M==src)return
		if(M.level < 30)
			src<<"You cannot invite players under level 30 to Anbu Root."
			return
		if(M.village!="Missing-Nin") return
		if(client.Alert("Are you sure you want to invite [M] to be in the Anbu Root?","Confirm",list("No","Yes"))==1) return
		if(M.client.Alert("You have been invited to join the Anbu Root. Accept, decline?","Confirm",list("Accept","Decline"))==2) return
		for(var/mob/Z in world) if(Z.village=="Anbu Root") Z<<"[M] has joined your ranks."
		M.village="Anbu Root"
		M.rank="Sibling"
		new/obj/Inventory/Clothing/Robes/Anbu_Suit(M)
		new/obj/Inventory/Clothing/Masks/Anbu_Purple(M)
		M.AddAdminVerbs()
	Remove_Anbu_Root()
		set category="Anbu Root"
		var/list/X=list()
		for(var/mob/player/e in world) if(e.ckey) X["[e.name] ([e.key])"]=e
		var/mob/P=CustomInput("Who do you want to remove from the Anbu Root?","Invite",X+"Cancel")
		if(P=="Cancel")return
		var/mob/M = X["[P]"]
		if(M==src)return
		if(M.village!="Anbu Root") return
		if(client.Alert("Are you sure you want to boot [M] from the [village]?","Confirm",list("No","Yes"))==1) return
		M.village="Missing-Nin"
		M.rank="Missing-Nin"
		for(var/obj/Inventory/Clothing/Robes/Anbu_Suit/O in M)
			if(ClothingOverlays[O.section]==O.icon)RemoveSection(O.section)
			del(O)
		for(var/obj/Inventory/Clothing/Masks/Anbu_Purple/O in M)
			if(ClothingOverlays[O.section]==O.icon)RemoveSection(O.section)
			del(O)
		M.overlays=null
		M.RestoreOverlays()
		M.RemoveAdminVerbs()
	Retire()
		set category="Anbu Root"
		var/list/X=list()
		if(client.Alert("Are you sure you would like to retire as Anbu Root Leader?","Confirmation",list("No","Yes"))==1) return
		for(var/mob/player/e in world) if(e.ckey) X["[e.name] ([e.key])"]=e
		var/mob/P=CustomInput("Who do you want to appoint as your successor?","Appoint Successor",X+"Cancel")
		if(P=="Cancel")return
		var/mob/M = X["[P]"]
		rank="Sibling"
		village="Anbu Root"
		M.rank="Anbu Leader"
		text2file("[src] has retired as Anbu Leader, and [M] has been promoted as their successor!: [time2text(world.timeofday, "MMM DD hh:mm:ss")]<br>",LOG_STAFF)

		M.AddAdminVerbs()
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
		if(M.level < 50)
			src<<"You cannot invite players under level 50 to Akatsuki."
			return
/*		if(AkatInvites>6)
			src<<"You cannot invite any more Akatsukis."
			return*/
		if(client.Alert("Are you sure you want to invite [M] to be a Akatsuki?","Confirm",list("No","Yes"))==1) return
		if(M.client.Alert("You have been invited to join the Akatsuki. Accept, decline?","Confirm",list("Accept","Decline"))==2) return
		for(var/mob/Z in world) if(Z.village=="Akatsuki") Z<<"[M] has joined your ranks."
		M.village="Akatsuki"
		M.rank="Akatsuki"
		AkatInvites++
		new/obj/Inventory/Clothing/Robes/Akatsuki_Robe(M)
		new/obj/Inventory/Clothing/HeadWrap/AkatsukiHat(M)
		M.AddAdminVerbs()
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
		if(client.Alert("Are you sure you want to boot [M] from the [village]?","Confirm",list("No","Yes"))==1) return
		M.village="Missing-Nin"
		M.rank="Missing-Nin"
		AkatInvites--
		for(var/obj/Inventory/Clothing/Robes/Akatsuki_Robe/O in M)
			if(ClothingOverlays[O.section]==O.icon)RemoveSection(O.section)
			del(O)
		for(var/obj/Inventory/Clothing/HeadWrap/AkatsukiHat/O in M)
			if(ClothingOverlays[O.section]==O.icon)RemoveSection(O.section)
			del(O)
		M.overlays=null
		M.RestoreOverlays()
		M.RemoveAdminVerbs()
	Retire()
		set category="Akatsuki"
		var/list/X=list()
		if(client.Alert("Are you sure you would like to retire as Akatsuki Leader?","Confirmation",list("No","Yes"))==1) return
		for(var/mob/player/e in world) if(e.ckey) X["[e.name] ([e.key])"]=e
		var/mob/P=CustomInput("Who do you want to appoint as your successor?","Appoint Successor",X+"Cancel")
		if(P=="Cancel")return
		var/mob/M = X["[P]"]
		text2file("[src] has retired as Akatsuki, and [M] has been promoted as their successor!: [time2text(world.timeofday, "MMM DD hh:mm:ss")]<br>",LOG_STAFF)

		rank="Akatsuki"
		village="Akatsuki"
		for(var/obj/Inventory/Clothing/HeadWrap/TobiMask/O in M)
			if(ClothingOverlays[O.section]==O.icon)RemoveSection(O.section)
			del(O)
		overlays=null
		RestoreOverlays()
		RemoveAdminVerbs()
		M.rank="Akatsuki Leader"
		M.AddAdminVerbs()
mob/SevenSwordsmenLeader/verb/
	Make_SevenSwordsmen()
		set category="Seven Swordsmen"
		var/list/X=list()
		for(var/mob/player/e in world) if(e.ckey) X["[e.name] ([e.key])"]=e
		var/mob/P=CustomInput("Who do you want to invite to the Organization?","Invite",X+"Cancel")
		if(P=="Cancel")return
		var/mob/M = X["[P]"]
		if(M==src)return
		//if(Positions["7SM"]!=src.ckey) return
		if(M.village!="Missing-Nin") return
		if(M.level < 40)
			src<<"You cannot invite players under level 40 to Seven Swordsmen."
			return
		if(client.Alert("Are you sure you want to invite [M] to the Seven Swordsmen Organization?","Confirm",list("No","Yes"))==1) return
		if(M.client.Alert("You have been invited to join the Seven Swordsmen. Accept, decline?","Confirm",list("Accept","Decline"))==2) return
		for(var/mob/Z in world) if(Z.village=="Seven Swordsmen") Z<<"[M] has joined your ranks."
		M.village="Seven Swordsmen"
		M.rank="Member"
		M.AddAdminVerbs()
	Remove_SevenSwordsmen()
		set category="Seven Swordsmen"
		var/list/X=list()
		for(var/mob/player/e in world) if(e.ckey) X["[e.name] ([e.key])"]=e
		var/mob/P=CustomInput("Who do you want to remove from the Organization?","Invite",X+"Cancel")
		if(P=="Cancel")return
		var/mob/M = X["[P]"]
		if(M==src)return
		//if(Positions["7SM"]!=src.ckey) return
		if(M.village!="Seven Swordsmen") return
		if(client.Alert("Are you sure you want to boot [M] from the [village]?","Confirm",list("No","Yes"))==1) return
		M.village="Missing-Nin"
		M.rank="Missing-Nin"
		for(var/obj/Inventory/Weaponry/Zabuza_Sword/O in src)
			if(ClothingOverlays[O.section]==O.icon)RemoveSection(O.section)
			M.equipped = null
			givenkubi=0
			del(O)
		for(var/obj/Inventory/Weaponry/Samehada/O in src)
			if(ClothingOverlays[O.section]==O.icon)RemoveSection(O.section)
			M.equipped = null
			givensame=0
			del(O)
		for(var/obj/Inventory/Weaponry/Hiramekarei/O in src)
			if(ClothingOverlays[O.section]==O.icon)RemoveSection(O.section)
			M.equipped = null
			del(O)
			//no give for this because it's leader wep
		for(var/obj/Inventory/Weaponry/Kabutowari/O in src)
			if(ClothingOverlays[O.section]==O.icon)RemoveSection(O.section)
			M.equipped = null
			givenkabu=0
			del(O)
		for(var/obj/Inventory/Weaponry/Kiba/O in src)
			if(ClothingOverlays[O.section]==O.icon)RemoveSection(O.section)
			M.equipped = null
			givenkiba=0
			del(O)
		for(var/obj/Inventory/Weaponry/Nuibari/O in src)
			if(ClothingOverlays[O.section]==O.icon)RemoveSection(O.section)
			M.equipped = null
			givennui=0
			del(O)
		for(var/obj/Inventory/Weaponry/Shibuki/O in src)
			if(ClothingOverlays[O.section]==O.icon)RemoveSection(O.section)
			M.equipped = null
			givenshibu=0

		M.overlays=null
		M.RestoreOverlays()
		M.RemoveAdminVerbs()
	Retire()
		set category="Seven Swordsmen"
		var/list/X=list()
		if(client.Alert("Are you sure you would like to retire as Seven Swordsmen Leader?","Confirmation",list("No","Yes"))==1) return
		for(var/mob/player/e in world) if(e.ckey) X["[e.name] ([e.key])"]=e
		var/mob/P=CustomInput("Who do you want to appoint as your successor?","Appoint Successor",X+"Cancel")
		if(P=="Cancel")return
		var/mob/M = X["[P]"]
		rank="Missing-Nin"
		village="Missing-Nin"
		text2file("[src] has retired as Seven Swordsmen, and [M] has been promoted as their successor!: [time2text(world.timeofday, "MMM DD hh:mm:ss")]<br>",LOG_STAFF)

		for(var/obj/Inventory/Weaponry/Hiramekarei/O in src)
			if(ClothingOverlays[O.section]==O.icon)RemoveSection(O.section)
			src.equipped = null
			del(O)
		overlays=null
		RestoreOverlays()
		RemoveAdminVerbs()
		M.rank="Seven Swordsmen Leader"
		M.AddAdminVerbs()
	Give_Kubikiribocho()
		set category="Seven Swordsmen"
		if(givenkubi==1)
			usr<<"You can not give this Sword twice!"
			return
		var/list/X=list()
		for(var/mob/player/e in world) if(e.ckey) X["[e.name] ([e.key])"]=e
		var/mob/P=CustomInput("Who do you want to give the Kubikiribocho to?","Give",X+"Cancel")
		if(P=="Cancel")return
		var/mob/M = X["[P]"]
		if(M==src)return
		//if(Positions["7SM"]!=src.ckey) return
		if(M.village!="Seven Swordsmen") return
		if(client.Alert("Are you sure you want to give [M] to the Kubikiibocho?","Confirm",list("No","Yes"))==1) return
		if(M.client.Alert("You have been given the Kubikiribocho. Accept, decline?","Confirm",list("Accept","Decline"))==2)	givenkubi=0
		if("Accept")
			for(var/mob/Z in world) if(Z.village=="Seven Swordsmen") Z<<"[M] has been given the Kubikiribocho!"
			M.rank="Zabuza Momochi"
			new/obj/Inventory/Weaponry/Zabuza_Sword(M)
			givenkubi=1
			M.AddAdminVerbs()
	Give_Samehada()
		set category="Seven Swordsmen"
		if(givensame==1)
			usr<<"You can not give this Sword twice!"
			return
		var/list/X=list()
		for(var/mob/player/e in world) if(e.ckey) X["[e.name] ([e.key])"]=e
		var/mob/P=CustomInput("Who do you want to give the Samehada to?","Give",X+"Cancel")
		if(P=="Cancel")return
		var/mob/M = X["[P]"]
		if(M==src)return
		//if(Positions["7SM"]!=src.ckey) return
		if(M.village!="Seven Swordsmen") return
		if(client.Alert("Are you sure you want to give [M] to the Samehada?","Confirm",list("No","Yes"))==1) return
		if(M.client.Alert("You have been given the Samehada. Accept, decline?","Confirm",list("Accept","Decline"))==2)	givensame=0
		if("Accept")
			for(var/mob/Z in world) if(Z.village=="Seven Swordsmen") Z<<"[M] been given the Samehada!"
			M.rank="Kisame Hoshigaki"
			new/obj/Inventory/Weaponry/Samehada(M)
			givensame=1
			M.AddAdminVerbs()
	Give_Nuibari()
		set category="Seven Swordsmen"
		if(givennui==1)
			usr<<"You can not give this Sword twice!"
			return
		var/list/X=list()
		for(var/mob/player/e in world) if(e.ckey) X["[e.name] ([e.key])"]=e
		var/mob/P=CustomInput("Who do you want to give the Nuibari to?","Give",X+"Cancel")
		if(P=="Cancel")return
		var/mob/M = X["[P]"]
		if(M==src)return
		//if(Positions["7SM"]!=src.ckey) return
		if(M.village!="Seven Swordsmen") return
		if(client.Alert("Are you sure you want to give [M] to the Nuibari?","Confirm",list("No","Yes"))==1) return
		if(M.client.Alert("You have been given the Nuibari. Accept, decline?","Confirm",list("Accept","Decline"))==2)	givennui=0
		if("Accept")
			for(var/mob/Z in world) if(Z.village=="Seven Swordsmen") Z<<"[M] been given the Nuibari!"
			M.rank="Kushimaru Kuriarare"
			new/obj/Inventory/Weaponry/Nuibari(M)
			givennui=1
			M.AddAdminVerbs()
	Give_Shibuki()
		set category="Seven Swordsmen"
		if(givenshibu==1)
			usr<<"You can not give this Sword twice!"
			return
		var/list/X=list()
		for(var/mob/player/e in world) if(e.ckey) X["[e.name] ([e.key])"]=e
		var/mob/P=CustomInput("Who do you want to give the Shibuki to?","Give",X+"Cancel")
		if(P=="Cancel")return
		var/mob/M = X["[P]"]
		if(M==src)return
		//if(Positions["7SM"]!=src.ckey) return
		if(M.village!="Seven Swordsmen") return
		if(client.Alert("Are you sure you want to give [M] to the Shibuki?","Confirm",list("No","Yes"))==1) return
		if(M.client.Alert("You have been given the Shibuki. Accept, decline?","Confirm",list("Accept","Decline"))==2)	givenshibu=0
		if("Accept")
			for(var/mob/Z in world) if(Z.village=="Seven Swordsmen") Z<<"[M] been given the Shibuki!"
			M.rank="Jinpachi Munashi"
			new/obj/Inventory/Weaponry/Shibuki(M)
			givenshibu=1
			M.AddAdminVerbs()
	Give_Kabutowari()
		set category="Seven Swordsmen"
		if(givenkabu==1)
			usr<<"You can not give this Sword twice!"
			return
		var/list/X=list()
		for(var/mob/player/e in world) if(e.ckey) X["[e.name] ([e.key])"]=e
		var/mob/P=CustomInput("Who do you want to give the Kabuto Wari to?","Give",X+"Cancel")
		if(P=="Cancel")return
		var/mob/M = X["[P]"]
		if(M==src)return
		//if(Positions["7SM"]!=src.ckey) return
		if(M.village!="Seven Swordsmen") return
		if(client.Alert("Are you sure you want to give [M] to the Kabuto Wari?","Confirm",list("No","Yes"))==1) return
		if(M.client.Alert("You have been given the Kabuto Wari. Accept, decline?","Confirm",list("Accept","Decline"))==2)	givenkabu=0
		if("Accept")
			for(var/mob/Z in world) if(Z.village=="Seven Swordsmen") Z<<"[M] been given the Kabuto Wari!"
			M.rank="Jinin Akebino"
			new/obj/Inventory/Weaponry/Kabutowari(M)
			givenkabu=1
			M.AddAdminVerbs()
	Give_Kiba()
		set category="Seven Swordsmen"
		if(givenkiba==1)
			usr<<"You can not give this Sword twice!"
			return
		var/list/X=list()
		for(var/mob/player/e in world) if(e.ckey) X["[e.name] ([e.key])"]=e
		var/mob/P=CustomInput("Who do you want to give the Kiba to?","Give",X+"Cancel")
		if(P=="Cancel")return
		var/mob/M = X["[P]"]
		if(M==src)return
		//if(Positions["7SM"]!=src.ckey) return
		if(M.village!="Seven Swordsmen") return
		if(client.Alert("Are you sure you want to give [M] to the Kiba?","Confirm",list("No","Yes"))==1) return
		if(M.client.Alert("You have been given the Kiba. Accept, decline?","Confirm",list("Accept","Decline"))==2)	givenkiba=0
		if("Accept")
			for(var/mob/Z in world) if(Z.village=="Seven Swordsmen") Z<<"[M] been given the Kiba!"
			M.rank="Ameyuri Ringo"
			new/obj/Inventory/Weaponry/Kiba(M)
			givenkiba=1
			M.AddAdminVerbs()

var/givenkubi=0
var/givensame=0
var/givennui=0
var/givenshibu=0
var/givenkiba=0
var/givenkabu=0