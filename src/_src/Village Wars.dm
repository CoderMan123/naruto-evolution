var/list/VillageDefenders=list()
var/list/VillageAttackers=list()
var/list/VillagePoints=list("Hidden Leaf"=1,"Hidden Sand"=0,"Hidden Mist"=0,"Hidden Sound"=0,"Hidden Rock"=0,"Akatsuki"=0,"Seven Swordsmen"=0,"Anbu Root"=0)
var/list/VillagesInGame=list("Hidden Leaf","Hidden Sand","Hidden Mist","Hidden Sound","Hidden Rock","Akatsuki","Seven Swordsmen","Anbu Root")
mob/var/tmp/choosing=0
mob
	Kage
		verb
			PeaceTreaty()
				set category = "Kage"
				set name = "Make Peace"
				if(!(VillagesInGame.Find(usr.village))) return
				if(!(VillageDefenders.Find(usr.village)) && !(VillageAttackers.Find(usr.village))) {usr<<output("<br><center><b>Your Village isn't in a war!</b><br>","Action.Output");return}
				if(usr.choosing) return
				usr.choosing=1
				var/list/warVillages=list("Hidden Leaf","Hidden Sand","Hidden Mist","Hidden Sound","Hidden Rock","Akatsuki","Seven Swordsmen","Anbu Root")
				if("[usr.village]" in warVillages) warVillages-="[usr.village]"
				var/input1=input("Make peace with which Village?")in warVillages+"Cancel"
				if(input1=="Cancel") {usr.choosing=0;return}
				if((VillageDefenders.Find(input1)) && (VillageAttackers.Find(usr.village))||(VillageAttackers.Find(input1)) && (VillageDefenders.Find(usr.village)))
					var/found=0
					for(var/mob/M in mobs_online)
						if(M.client && findtext("[M.rank]","kage",1) && M.village=="[input1]")
							found=1
							var/Villagetochange=usr.village
							var/input2=input(M,"[Villagetochange] wants to make peace. Do you agree?")in list("Yes","No")
							if(input2=="Yes")
								world<<output("<br><b><center>[input1] Village has made peace with [usr.village] Village!</b><br>","Action.Output")
								if("[input1]" in VillageDefenders)
									VillageAttackers-="[Villagetochange]"
									VillageDefenders-="[input1]"
									if(!VillageAttackers.len)
										world<<output("<br><b><center>All wars have ended!</font><br>","Action.Output")
										for(var/f in VillageDefenders) VillageDefenders-=f
								else
									VillageDefenders-="[Villagetochange]"
									VillageAttackers-="[input1]"
									if(!VillageDefenders.len)
										world<<output("<br><b><center>All wars have ended!</font><br>","Action.Output")
										for(var/f in VillageAttackers) VillageAttackers-=f
							else usr<<output("<br><center>[input1] has declined to the peace offering!<br>","Action.Output")
					if(!found)usr<<output("<br><center>Their kage is not online at this moment<br>","Action.Output")
				else usr<<output("<br>You're not at war with them.<br>","Action.Output")
				usr.choosing=0
			DeclareWar()
				set category = "Kage"
				set name = "Declare War"
				if(!(VillagesInGame.Find(usr.village))) return
				if(VillageDefenders.Find(usr.village)) {usr<<output("<br><center><b>Your village is already in a war!</b><br>","Action.Output");return}
				if(VillageAttackers.Find(usr.village)) {usr<<output("<br><center><b>Your village is already in a war!</b><br>","Action.Output");return}
				if(usr.choosing) return
				usr.choosing=1
				var/list/warVillages=list("Hidden Leaf","Hidden Sand","Hidden Mist","Hidden Sound","Hidden Rock","Akatsuki","Seven Swordsmen","Anbu Root")
				if(warVillages.Find(usr.village)) warVillages-="[usr.village]"
				var/input1=input("Declare war with what Village?")in warVillages+"Cancel"
				if(input1=="Cancel") {usr.choosing=0;return}
				if(VillageDefenders.Find(input1))
					var/input2=input("[input1] is already in their own war. Do you wish to oppose or help aid them?")in list("Attack","Defend")
					if(input2=="Attack")
						var/msg="<center><b>[usr.village] has joined the War to help"
						var/amount=0
						for(var/f in VillageAttackers)
							amount++
							if(VillageAttackers.len==amount) msg+=" [f].</font></u><b><br>"
							else msg+="[f],"
						VillageAttackers+="[usr.village]"
						world<<output("[msg]","Action.Output")
					else
						var/msg="<center><b>[usr.village] has joined the War to help"
						var/amount=0
						for(var/f in VillageDefenders)
							amount++
							if(VillageDefenders.len==amount) msg+=" [f].</font></u><b><br>"
							else msg+=" [f],"
						VillageDefenders+="[usr.village]"
						world<<output("[msg]","Action.Output")
				else if(VillageAttackers.Find(input1))
					var/input2=input("[input1] is already in their own war. Do you wish to oppose or help aid them?")in list("Attack","Defend")
					if(input2=="Attack")
						var/msg="<br><center><b>[usr.village] has joined the War to help"
						var/amount=0
						for(var/f in VillageDefenders)
							amount++
							if(VillageDefenders.len==amount) msg+=" [f].</font></u><b><br>"
							else msg+=" [f],"
						VillageDefenders+="[usr.village]"
						world<<output("[msg]","Action.Output")
					else
						var/msg="<center><b>[usr.village] has joined the war to help"
						var/amount=0
						for(var/f in VillageAttackers)
							amount++
							if(VillageAttackers.len==amount) msg+=" [f].</font></u><b><br>"
							else msg+=" [f],"
						VillageAttackers+="[usr.village]"
						world<<output("[msg]","Action.Output")
				else
					var/msg="<center><b>[usr.village] has declared war on [input1]</font><b><br>"
					VillageAttackers+="[usr.village]"
					VillageDefenders+="[input1]"
					world<<output("[msg]","Action.Output")
				usr.choosing=0

