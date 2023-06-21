mob/AnbuLeader/verb/
	Make_Anbu_Root()
		set category="Anbu Root"
		var/list/X=list()
		for(var/mob/e in world) if(e.ckey) X["[e.name] ([e.key])"]=e
		var/mob/P=CustomInput("Who do you want to invite to the Anbu Root?","Invite",X+"Cancel")
		if(P=="Cancel")return
		var/mob/M = X["[P]"]
		if(M==src)return
		if(M.level < 30)
			src<<"You cannot invite players under level 30 to Anbu Root."
			return
		if(M.village!="Missing-Nin") return
		if(client.prompt("Are you sure you want to invite [M] to be in the Anbu Root?","Confirm",list("No","Yes"))=="No") return
		if(M.client.prompt("You have been invited to join the Anbu Root. Accept, decline?","Confirm",list("Accept","Decline"))=="Decline") return
		for(var/mob/Z in world) if(Z.village=="Anbu Root") Z<<"[M] has joined your ranks."
		M.village="Anbu Root"
		M.rank="Sibling"
		var/squad/squad = M.GetSquad()
		if(squad)
			squad.Refresh()

		new/obj/Inventory/Clothing/Robes/Anbu_Suit(M)
		new/obj/Inventory/Clothing/Masks/Anbu_Purple(M)
		M.client.StaffCheck()

	Remove_Anbu_Root()
		set category="Anbu Root"
		var/list/X=list()
		for(var/mob/e in world) if(e.ckey) X["[e.name] ([e.key])"]=e
		var/mob/P=CustomInput("Who do you want to remove from the Anbu Root?","Invite",X+"Cancel")
		if(P=="Cancel")return
		var/mob/M = X["[P]"]
		if(M==src)return
		if(M.village!="Anbu Root") return
		if(client.prompt("Are you sure you want to boot [M] from the [village]?","Confirm",list("No","Yes"))=="No") return
		M.village="Missing-Nin"
		M.rank="Missing-Nin"
		var/squad/squad = M.GetSquad()
		if(squad)
			squad.Refresh()

		for(var/obj/Inventory/Clothing/Robes/Anbu_Suit/O in M)
			if(ClothingOverlays[O.section]==O.icon)RemoveSection(O.section)
			del(O)
		for(var/obj/Inventory/Clothing/Masks/Anbu_Purple/O in M)
			if(ClothingOverlays[O.section]==O.icon)RemoveSection(O.section)
			del(O)
		M.overlays=null
		M.RestoreOverlays()
		M.client.StaffCheck()

	Retire()
		set category="Anbu Root"
		var/list/X=list()
		if(client.prompt("Are you sure you would like to retire as Anbu Root Leader?","Confirmation",list("No","Yes"))=="No") return
		for(var/mob/e in world) if(e.ckey) X["[e.name] ([e.key])"]=e
		var/mob/P=CustomInput("Who do you want to appoint as your successor?","Appoint Successor",X+"Cancel")
		if(P=="Cancel")return
		var/mob/M = X["[P]"]
		rank="Sibling"
		village="Anbu Root"
		var/squad/squad = src.GetSquad()
		if(squad)
			squad.Refresh()

		M.rank = RANK_ANBU_LEADER
		squad = M.GetSquad()
		if(squad)
			squad.Refresh()

		M.client.StaffCheck()

mob/AkatsukiLeader/verb/
	Make_Akatsuki()
		set category="Akatsuki"
		var/list/X=list()
		for(var/mob/e in world) if(e.ckey) X["[e.name] ([e.key])"]=e
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
		if(client.prompt("Are you sure you want to invite [M] to be a Akatsuki?","Confirm",list("No","Yes"))=="No") return
		if(M.client.prompt("You have been invited to join the Akatsuki. Accept, decline?","Confirm",list("Accept","Decline"))=="Decline") return
		for(var/mob/Z in world) if(Z.village=="Akatsuki") Z<<"[M] has joined your ranks."
		M.village="Akatsuki"
		M.rank = RANK_AKATSUKI
		var/squad/squad = M.GetSquad()
		if(squad)
			squad.Refresh()

		AkatInvites++
		new/obj/Inventory/Clothing/Robes/Akatsuki_Robe(M)
		new/obj/Inventory/Clothing/HeadWrap/AkatsukiHat(M)
		M.client.StaffCheck()

	Remove_Akatsuki()
		set category="Akatsuki"
		var/list/X=list()
		for(var/mob/e in world) if(e.ckey) X["[e.name] ([e.key])"]=e
		var/mob/P=CustomInput("Who do you want to remove from the Akatsuki?","Invite",X+"Cancel")
		if(P=="Cancel")return
		var/mob/M = X["[P]"]
		if(M==src)return
		//if(Positions["Akatsuki Leader"]!=src.ckey) return
		if(M.village!="Akatsuki") return
		if(client.prompt("Are you sure you want to boot [M] from the [village]?","Confirm",list("No","Yes"))=="No") return
		M.village="Missing-Nin"
		M.rank="Missing-Nin"
		var/squad/squad = M.GetSquad()
		if(squad)
			squad.Refresh()

		AkatInvites--
		for(var/obj/Inventory/Clothing/Robes/Akatsuki_Robe/O in M)
			if(ClothingOverlays[O.section]==O.icon)RemoveSection(O.section)
			del(O)
		for(var/obj/Inventory/Clothing/HeadWrap/AkatsukiHat/O in M)
			if(ClothingOverlays[O.section]==O.icon)RemoveSection(O.section)
			del(O)
		M.overlays=null
		M.RestoreOverlays()
		M.client.StaffCheck()

	Retire()
		set category="Akatsuki"
		var/list/X=list()
		if(client.prompt("Are you sure you would like to retire as Akatsuki Leader?","Confirmation",list("No","Yes"))=="No") return
		for(var/mob/e in world) if(e.ckey) X["[e.name] ([e.key])"]=e
		var/mob/P=CustomInput("Who do you want to appoint as your successor?","Appoint Successor",X+"Cancel")
		if(P=="Cancel")return
		var/mob/M = X["[P]"]

		rank = RANK_AKATSUKI
		village="Akatsuki"
		var/squad/squad = src.GetSquad()
		if(squad)
			squad.Refresh()

		for(var/obj/Inventory/Clothing/HeadWrap/TobiMask/O in M)
			if(ClothingOverlays[O.section]==O.icon)RemoveSection(O.section)
			del(O)
		overlays=null
		RestoreOverlays()
		src.client.StaffCheck()
		M.rank = RANK_AKATSUKI_LEADER
		squad = M.GetSquad()
		if(squad)
			squad.Refresh()

		M.client.StaffCheck()

mob/SevenSwordsmenLeader/verb/
	Make_SevenSwordsmen()
		set category="Seven Swordsmen"
		var/list/X=list()
		for(var/mob/e in world) if(e.ckey) X["[e.name] ([e.key])"]=e
		var/mob/P=CustomInput("Who do you want to invite to the Organization?","Invite",X+"Cancel")
		if(P=="Cancel")return
		var/mob/M = X["[P]"]
		if(M==src)return
		//if(Positions["7SM"]!=src.ckey) return
		if(M.village!="Missing-Nin") return
		if(M.level < 40)
			src<<"You cannot invite players under level 40 to Seven Swordsmen."
			return
		if(client.prompt("Are you sure you want to invite [M] to the Seven Swordsmen Organization?","Confirm",list("No","Yes"))=="No") return
		if(M.client.prompt("You have been invited to join the Seven Swordsmen. Accept, decline?","Confirm",list("Accept","Decline"))=="Decline") return
		for(var/mob/Z in world) if(Z.village=="Seven Swordsmen") Z<<"[M] has joined your ranks."
		M.village="Seven Swordsmen"
		M.rank="Member"
		var/squad/squad = M.GetSquad()
		if(squad)
			squad.Refresh()

		M.client.StaffCheck()

	Remove_SevenSwordsmen()
		set category="Seven Swordsmen"
		var/list/X=list()
		for(var/mob/e in world) if(e.ckey) X["[e.name] ([e.key])"]=e
		var/mob/P=CustomInput("Who do you want to remove from the Organization?","Invite",X+"Cancel")
		if(P=="Cancel")return
		var/mob/M = X["[P]"]
		if(M==src)return
		//if(Positions["7SM"]!=src.ckey) return
		if(M.village!="Seven Swordsmen") return
		if(client.prompt("Are you sure you want to boot [M] from the [village]?","Confirm",list("No","Yes"))=="No") return
		M.village="Missing-Nin"
		M.rank="Missing-Nin"
		var/squad/squad = M.GetSquad()
		if(squad)
			squad.Refresh()

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
		M.client.StaffCheck()

	Retire()
		set category="Seven Swordsmen"
		var/list/X=list()
		if(client.prompt("Are you sure you would like to retire as Seven Swordsmen Leader?","Confirmation",list("No","Yes"))=="No") return
		for(var/mob/e in world) if(e.ckey) X["[e.name] ([e.key])"]=e
		var/mob/P=CustomInput("Who do you want to appoint as your successor?","Appoint Successor",X+"Cancel")
		if(P=="Cancel")return
		var/mob/M = X["[P]"]
		rank="Missing-Nin"
		village="Missing-Nin"
		var/squad/squad = src.GetSquad()
		if(squad)
			squad.Refresh()

		for(var/obj/Inventory/Weaponry/Hiramekarei/O in src)
			if(ClothingOverlays[O.section]==O.icon)RemoveSection(O.section)
			src.equipped = null
			del(O)
		overlays=null
		RestoreOverlays()
		src.client.StaffCheck()
		M.rank = RANK_SEVEN_SWORDSMEN_LEADER
		squad = M.GetSquad()
		if(squad)
			squad.Refresh()

		M.client.StaffCheck()

	Give_Kubikiribocho()
		set category="Seven Swordsmen"
		if(givenkubi==1)
			usr<<"You can not give this Sword twice!"
			return
		var/list/X=list()
		for(var/mob/e in world) if(e.ckey) X["[e.name] ([e.key])"]=e
		var/mob/P=CustomInput("Who do you want to give the Kubikiribocho to?","Give",X+"Cancel")
		if(P=="Cancel")return
		var/mob/M = X["[P]"]
		if(M==src)return
		//if(Positions["7SM"]!=src.ckey) return
		if(M.village!="Seven Swordsmen") return
		if(client.prompt("Are you sure you want to give [M] to the Kubikiibocho?","Confirm",list("No","Yes"))=="No") return
		if(M.client.prompt("You have been given the Kubikiribocho. Accept, decline?","Confirm",list("Accept","Decline"))=="Decline")	givenkubi=0
		if("Accept")
			for(var/mob/Z in world) if(Z.village=="Seven Swordsmen") Z<<"[M] has been given the Kubikiribocho!"
			M.rank="Zabuza Momochi"
			var/squad/squad = M.GetSquad()
			if(squad)
				squad.Refresh()

			new/obj/Inventory/Weaponry/Zabuza_Sword(M)
			givenkubi=1
			M.client.StaffCheck()

	Give_Samehada()
		set category="Seven Swordsmen"
		if(givensame==1)
			usr<<"You can not give this Sword twice!"
			return
		var/list/X=list()
		for(var/mob/e in world) if(e.ckey) X["[e.name] ([e.key])"]=e
		var/mob/P=CustomInput("Who do you want to give the Samehada to?","Give",X+"Cancel")
		if(P=="Cancel")return
		var/mob/M = X["[P]"]
		if(M==src)return
		//if(Positions["7SM"]!=src.ckey) return
		if(M.village!="Seven Swordsmen") return
		if(client.prompt("Are you sure you want to give [M] to the Samehada?","Confirm",list("No","Yes"))=="No") return
		if(M.client.prompt("You have been given the Samehada. Accept, decline?","Confirm",list("Accept","Decline"))=="Decline")	givensame=0
		if("Accept")
			for(var/mob/Z in world) if(Z.village=="Seven Swordsmen") Z<<"[M] been given the Samehada!"
			M.rank="Kisame Hoshigaki"
			var/squad/squad = M.GetSquad()
			if(squad)
				squad.Refresh()

			new/obj/Inventory/Weaponry/Samehada(M)
			givensame=1
			M.client.StaffCheck()

	Give_Nuibari()
		set category="Seven Swordsmen"
		if(givennui==1)
			usr<<"You can not give this Sword twice!"
			return
		var/list/X=list()
		for(var/mob/e in world) if(e.ckey) X["[e.name] ([e.key])"]=e
		var/mob/P=CustomInput("Who do you want to give the Nuibari to?","Give",X+"Cancel")
		if(P=="Cancel")return
		var/mob/M = X["[P]"]
		if(M==src)return
		//if(Positions["7SM"]!=src.ckey) return
		if(M.village!="Seven Swordsmen") return
		if(client.prompt("Are you sure you want to give [M] to the Nuibari?","Confirm",list("No","Yes"))=="No") return
		if(M.client.prompt("You have been given the Nuibari. Accept, decline?","Confirm",list("Accept","Decline"))=="Decline")	givennui=0
		if("Accept")
			for(var/mob/Z in world) if(Z.village=="Seven Swordsmen") Z<<"[M] been given the Nuibari!"
			M.rank="Kushimaru Kuriarare"
			var/squad/squad = M.GetSquad()
			if(squad)
				squad.Refresh()

			new/obj/Inventory/Weaponry/Nuibari(M)
			givennui=1
			M.client.StaffCheck()

	Give_Shibuki()
		set category="Seven Swordsmen"
		if(givenshibu==1)
			usr<<"You can not give this Sword twice!"
			return
		var/list/X=list()
		for(var/mob/e in world) if(e.ckey) X["[e.name] ([e.key])"]=e
		var/mob/P=CustomInput("Who do you want to give the Shibuki to?","Give",X+"Cancel")
		if(P=="Cancel")return
		var/mob/M = X["[P]"]
		if(M==src)return
		//if(Positions["7SM"]!=src.ckey) return
		if(M.village!="Seven Swordsmen") return
		if(client.prompt("Are you sure you want to give [M] to the Shibuki?","Confirm",list("No","Yes"))=="No") return
		if(M.client.prompt("You have been given the Shibuki. Accept, decline?","Confirm",list("Accept","Decline"))=="Decline")	givenshibu=0
		if("Accept")
			for(var/mob/Z in world) if(Z.village=="Seven Swordsmen") Z<<"[M] been given the Shibuki!"
			M.rank="Jinpachi Munashi"
			var/squad/squad = M.GetSquad()
			if(squad)
				squad.Refresh()

			new/obj/Inventory/Weaponry/Shibuki(M)
			givenshibu=1
			M.client.StaffCheck()

	Give_Kabutowari()
		set category="Seven Swordsmen"
		if(givenkabu==1)
			usr<<"You can not give this Sword twice!"
			return
		var/list/X=list()
		for(var/mob/e in world) if(e.ckey) X["[e.name] ([e.key])"]=e
		var/mob/P=CustomInput("Who do you want to give the Kabuto Wari to?","Give",X+"Cancel")
		if(P=="Cancel")return
		var/mob/M = X["[P]"]
		if(M==src)return
		//if(Positions["7SM"]!=src.ckey) return
		if(M.village!="Seven Swordsmen") return
		if(client.prompt("Are you sure you want to give [M] to the Kabuto Wari?","Confirm",list("No","Yes"))=="No") return
		if(M.client.prompt("You have been given the Kabuto Wari. Accept, decline?","Confirm",list("Accept","Decline"))=="Decline")	givenkabu=0
		if("Accept")
			for(var/mob/Z in world) if(Z.village=="Seven Swordsmen") Z<<"[M] been given the Kabuto Wari!"
			M.rank="Jinin Akebino"
			var/squad/squad = M.GetSquad()
			if(squad)
				squad.Refresh()

			new/obj/Inventory/Weaponry/Kabutowari(M)
			givenkabu=1
			M.client.StaffCheck()

	Give_Kiba()
		set category="Seven Swordsmen"
		if(givenkiba==1)
			usr<<"You can not give this Sword twice!"
			return
		var/list/X=list()
		for(var/mob/e in world) if(e.ckey) X["[e.name] ([e.key])"]=e
		var/mob/P=CustomInput("Who do you want to give the Kiba to?","Give",X+"Cancel")
		if(P=="Cancel")return
		var/mob/M = X["[P]"]
		if(M==src)return
		//if(Positions["7SM"]!=src.ckey) return
		if(M.village!="Seven Swordsmen") return
		if(client.prompt("Are you sure you want to give [M] to the Kiba?","Confirm",list("No","Yes"))=="No") return
		if(M.client.prompt("You have been given the Kiba. Accept, decline?","Confirm",list("Accept","Decline"))=="Decline")	givenkiba=0
		if("Accept")
			for(var/mob/Z in world) if(Z.village=="Seven Swordsmen") Z<<"[M] been given the Kiba!"
			M.rank="Ameyuri Ringo"
			var/squad/squad = M.GetSquad()
			if(squad)
				squad.Refresh()

			new/obj/Inventory/Weaponry/Kiba(M)
			givenkiba=1
			M.client.StaffCheck()

var/givenkubi=0
var/givensame=0
var/givennui=0
var/givenshibu=0
var/givenkiba=0
var/givenkabu=0