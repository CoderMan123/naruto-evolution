//Verbs in options panel. As well as Inv statpanel and Jutsus(P)
mob
	proc
		Help()
			src<<"/Stuck -- Will teleport you out of the area after 20 seconds."
			src<<"/World -- Shows the current servers IP address."
			src<<"/Mute -- Vote to mute a player."
			src<<"/Boot -- Vote to boot an afk player."
			src<<"/Help -- View all commands."
			
		Stuck()

			if(Tutorial!=7)//TUT
				src<<"You still didn't finish tutorial so your getting teleported to the beginning..."
				src.loc=locate(40,158,14)
				return
			if(src.loc in block(locate(73,97,4),locate(198,161,4)))
				if(ChuuninExam=="Forest of Death")
					src<<"You can't /stuck here while the chuunin exam is still going."
					return
			src<<"You are about to be teleported out of the area. Please do not move or touch any buttons for 20 seconds"
			sleep(200)
			if(src.client.inactivity >= 200)
				src.loc = MapLoadSpawn()
				src.move=1
				src.injutsu=0
				src.canattack=1
				src.firing=0
			else src<<"Results show that you have moved or touched a button within the last 20 seconds."
	var/accepted
var/arenaprogress=0
mob
	verb
		Challenge()
			set hidden = 1
			if(arenaprogress==1)
				usr<<"Arena fight is already in progress!"
				return
			var/mob/M=input("Pick your opponent") as mob in mobs_online
			if(M.key==usr.key)
				usr<<"You can't challenge yourself."
				return
			if(!M.key)
				return
			if(M.jailed==1)
				usr<<"They are jailed."
				return
			if(M.loc in block(locate(73,97,4),locate(198,161,4)))
				usr<<"They're in the chuunin exam."
				return
			Accept(M)
mob
	proc
		Accept(mob/M)
			if(M.client.Alert("Fight [src]?","Duel",list("Yes","No")) == 1)
				src.opponent=M
				M.opponent=src
				M.loc=locate(172,149,8)
				src.loc=locate(185,149,8)
				world<<"[M] accepts challenge from [src]!"
				src.dueling=1
				M.dueling=1
				arenaprogress=1
			else
				world<<"[M] declines the challenge from [src]..."

mob
	var/tmp
		InventoryUp = 0//Variable telling whether your OSI is up, or not
	verb
		LeaveVillage()
			set hidden=1
			if(village == VILLAGE_MISSING_NIN) return

			var/squad/squad = src.GetSquad()
			if(squad)
				src.client.Alert("You cannot leave your village while in a Squad.", "Naruto Evolution")
				return

			if(Tutorial < 7)
				usr<<"You can't leave your village while you're in the tutorial!"
				return

			if(client.Alert("Are you sure you want to leave your village?","Confirmation",list("Yes","No"))==1)
				world<<output("[src.name] has defected from the [src.village] village.","Action.Output")

				if(village == VILLAGE_AKATSUKI)
					for(var/obj/Inventory/Clothing/Robes/Akatsuki_Robe/O in src)
						if(ClothingOverlays[O.section]==O.icon)RemoveSection(O.section)
						del(O)
					src.overlays=null
					src.ReAddClothing()
					src.RestoreOverlays()
					src.client.StaffCheck()

				if(village=="Anbu Root")
					for(var/obj/Inventory/Clothing/Robes/Anbu_Suit/O in src)
						if(ClothingOverlays[O.section]==O.icon)RemoveSection(O.section)
						del(O)
					src.overlays=null
					src.ReAddClothing()
					src.RestoreOverlays()
					src.client.StaffCheck()

				if(village=="Seven Swordsmen")
					for(var/obj/Inventory/Weaponry/Zabuza_Sword/O in src)
						if(ClothingOverlays[O.section]==O.icon)RemoveSection(O.section)
						src.equipped = null
						givenkubi=0
						del(O)

					for(var/obj/Inventory/Weaponry/Samehada/O in src)
						if(ClothingOverlays[O.section]==O.icon)RemoveSection(O.section)
						src.equipped = null
						givensame=0
						del(O)

					for(var/obj/Inventory/Weaponry/Hiramekarei/O in src)
						if(ClothingOverlays[O.section]==O.icon)RemoveSection(O.section)
						src.equipped = null
						del(O)
						//no give for this because it's leader wep

					for(var/obj/Inventory/Weaponry/Kabutowari/O in src)
						if(ClothingOverlays[O.section]==O.icon)RemoveSection(O.section)
						src.equipped = null
						givenkabu=0
						del(O)

					for(var/obj/Inventory/Weaponry/Kiba/O in src)
						if(ClothingOverlays[O.section]==O.icon)RemoveSection(O.section)
						src.equipped = null
						givenkiba=0
						del(O)

					for(var/obj/Inventory/Weaponry/Nuibari/O in src)
						if(ClothingOverlays[O.section]==O.icon)RemoveSection(O.section)
						src.equipped = null
						givennui=0
						del(O)

					for(var/obj/Inventory/Weaponry/Shibuki/O in src)
						if(ClothingOverlays[O.section]==O.icon)RemoveSection(O.section)
						src.equipped = null
						givenshibu=0
						del(O)
				
				src.SetVillage(VILLAGE_MISSING_NIN)

				world.UpdateVillageCount()
				
				spawn() src.client.UpdateWhoAll()

				var/squad/squad = src.GetSquad()
				if(squad)
					squad.Refresh()

	//	AdminUp()
	//		set hidden=1
	//		if(usr.dead==0)
	//			if(usr.AdminUp == 0)
	//				usr.AdminUp = 1
	//				//src.UpdateInventory()
	//				winset(src, null, {"
	//					Main.AdminChild.is-visible = "true";
	//				"})
	///			else
	//				usr.AdminUp = 0
	//				//src.UpdateInventory()
	//				winset(src, null, {"
	//					Main.AdminChild.is-visible = "false";
	//				"})

mob
	verb


		HealthUp()
			set hidden=1
			if(statpoints<1)
				src<<output("<font color=red>Insufficent statpoints.</Font>","Action.Output")
				return
			statpoints--
			maxhealth+=30
			src<<output("<font color=yellow>You leveled up Health!</Font>","Action.Output")
			src.UpdateHMB()

		ChakraUp()
			set hidden=1
			if(statpoints<1)
				src<<output("<font color=red>Insufficent statpoints.</Font>","Action.Output")
				return
			statpoints--
			maxchakra+=25
			src<<output("<font color=yellow>You leveled up Chakra!</Font>","Action.Output")
			src.UpdateHMB()
