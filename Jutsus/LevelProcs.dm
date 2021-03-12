obj
	proc
		Levelup()
			if(src.exp>=src.maxexp&&src.level<4)
				if(!src.owner) return

				if(src.name=="Transformation Jutsu")
					if(src.level==3)
						return

				var/mob/Owner=getOwner(src.owner)
				Owner<<sound('level.wav',0,0)
				Owner<<output("<font color= #dda0dd>Your [src] skill has advanced a level</Font>.","ActionPanel.Output")
				src.level++
				src.exp-=src.maxexp
				src.maxexp+=30
				if(src.name=="Clone Jutsu")
					if(src.level==2)Owner.maxbunshin=1
					if(src.level==3)Owner.maxbunshin=1
					if(src.level==4)Owner.maxbunshin=1
					Owner<<output("<font color= #bc8f8f>Your [src]'s clones now have more strength</Font>.","ActionPanel.Output")
				if(src.name=="Fire Release: Fire Ball")
					Owner<<output("<font color= #bc8f8f>Your [src] skill's base damage has increased</Font>.","ActionPanel.Output")
				if(src.name=="Meteor Punch")
					Owner<<output("<font color= #bc8f8f>Your [src] skill's base damage and knockback power has increased</Font>.","ActionPanel.Output")
				if(src.name=="Fire Release: Phoenix Immortal Fire Technique")
					if(src.level==2)
						Owner<<output("<font color= #bc8f8f>Your [src] skill is now able to fire 3 projectiles</Font>.","ActionPanel.Output")
						Owner.katon=3
					if(src.level==3)
						Owner<<output("<font color= #bc8f8f>Your [src] skill's base damage has increased</Font>.","ActionPanel.Output")
						Owner<<output("<font color= #bc8f8f>Your [src] skill is now able to fire 4 projectiles</Font>.","ActionPanel.Output")
						Owner.katon=4
					if(src.level==4)
						Owner<<output("<font color= #bc8f8f>Your [src] skill is now able to fire 5 projectiles</Font>.","ActionPanel.Output")
						Owner.katon=5
				if(src.name=="Body Replacement Jutsu")
					if(src.level==4)
						var/obj/Jutsus/AdvancedBodyReplace/J=new/obj/Jutsus/AdvancedBodyReplace
						if(!J) return
						if(J.type in Owner.JutsusLearnt)del(J)
						else
							if(!J) return
							Owner<<output("<font color= #bc8f8f>You learned [J.name]</Font>.","ActionPanel.Output")
							Owner.JutsusLearnt.Add(J)
							Owner.JutsusLearnt.Add(J.type)
							J.Owner=Owner
				if(src.name=="Transformation Jutsu")
					if(src.level==2)Owner<<output("<font color= #bc8f8f>[src.name] can now be used to transform into objects</Font>!","ActionPanel.Output")
					if(src.level==3)Owner<<output("<font color= #bc8f8f>[src.name] can now be used to transform into almost anything</Font>!","ActionPanel.Output")

mob
	proc
		LevelStat(stat,howmuch,mission)
			var/area/A=loc.loc
			if(!A) return
			if(A.Safe&&!mission) return
			if(src.ExpLock)
				src<<output("<font color=red><small><small>You're currently exp locked! Use the Remove Exp Lock button under the options pane!</small></Font>","ActionPanel.Output")
				return
			switch(stat)
				if("Defence")defexp+=howmuch
				if("Strength")strengthexp+=howmuch
				if("Ninjutsu")ninexp+=howmuch
				if("Genjutsu")genexp+=howmuch
				if("Agility")agilityexp+=howmuch
			Levelup()
		Levelup()
			if(src.xplock==1)
				src<<output("You have an Experience lock on you. This measure is used against the abusers / AFK trainers. Admin decides when this is removed.","ActionPanel.Output")
				return
			if(src.exp>=src.maxexp)
				if(src.level>=100)
					goto next
				var/obj/O = new/obj
				O.icon = 'ChakraCharge.dmi'
				O.icon_state = "3x"
				O.layer=200
				src.overlays+=O
				src<<sound('levelup.wav',0,0)
				src<<output("<font color= #bc8f8f>You leveled up!</Font>.","ActionPanel.Output")
				src.level+=1
				src.exp-=src.maxexp
				src.statpoints+=3
				src.skillpoints++
				src.maxchakra+=10
				src.maxhealth+=15
				if(src.level<=10)
					src.maxexp+=1
				if(src.level>10&&src.level<=35)
					src.maxexp+=2
				if(src.level>35&&src.level<=65)
					src.maxexp+=3
				if(src.level>65&&src.level<=90)
					src.maxexp+=4
				if(src.level>90&&src.level<=100)
					src.maxexp+=5
				src.Levelup()
				spawn(15)
					src.overlays-=O
					del(O)
				next
			if(src.strengthexp>=src.maxstrengthexp)
				if(src.strength>=150)
					goto next
				src<<sound('level.wav',0,0)
				src<<output("<font color=yellow>You leveled up Strength</Font>.","ActionPanel.Output")
				src.exp+=1
				src.strength+=1
				src.strengthexp-=src.maxstrengthexp
				src.maxstrengthexp+=10+round(src.strength/2)
				src.Levelup()
				next

			if(src.ninexp>=src.maxninexp)
				if(src.ninjutsu>=150)
					goto next
				src<<sound('level.wav',0,0)
				src<<output("<font color=green>You leveled up Ninjutsu</Font>.","ActionPanel.Output")
				src.exp+=1
				src.ninjutsu+=1
				src.ninexp-=src.maxninexp
				src.maxninexp+=10+round(src.ninjutsu/2)
				src.Levelup()
				next
			if(src.genexp>=src.maxgenexp)
				if(src.genjutsu>=150)
					goto next
				src<<sound('level.wav',0,0)
				src<<output("<font color=#C0C0C0>You leveled up Genjutsu</Font>.","ActionPanel.Output")
				src.exp+=1
				src.genjutsu+=1
				src.genexp-=src.maxgenexp
				src.maxgenexp+=10+round(src.genjutsu/2)
				src.Levelup()
				next
			if(src.defexp>=src.maxdefexp)
				if(src.defence>=150)
					goto next
				src<<sound('level.wav',0,0)
				src<<output("<font color=maroon>You leveled up Defence</Font>.","ActionPanel.Output")
				src.exp+=1
				src.defence++
				src.defexp-=src.maxdefexp
				src.maxdefexp+=10+round(src.defence/2)
				src.Levelup()
				next
			if(src.agilityexp>=src.maxagilityexp)
				if(src.agility>=150)
					goto next
				src<<sound('level.wav',0,0)
				src<<output("<font color=blue>You leveled up Agility</Font>.","ActionPanel.Output")
				src.exp+=1
				src.agility++
				src.agilityexp-=src.maxagilityexp
				src.maxagilityexp+=10+round(src.agility/2)
				src.Levelup()
				if(src.agility==10)src.attkspeed=7
				if(src.agility==20)src.attkspeed=6
				if(src.agility==30)src.attkspeed=5
				if(src.agility==50)src.attkspeed=4
				if(src.agility==70)src.attkspeed=3
				if(src.agility==90)src.attkspeed=2
				if(src.agility==120)src.attkspeed=1
				next
			if(!src.client)src.UpdateHMB()
			else if(!src.likeaclone)src.UpdateHMB()
			if(src.client) src.client.UpdateCharacterPanel()
			if(level>=25&&!Element2)
				var/Elements=list("Fire","Water","Earth","Lightning","Wind")
				src.Element2=src.CustomInput("Element Options","What secondary element would you like?.",Elements-src.Element)
				if(src.Element2) src.Element2=src.Element2:name
				if(src.Element=="Water"|src.Element2=="Wind")
					if(src.Element=="Wind"|src.Element2=="Water")
						src.Kekkai = "Ice"
obj
	Overlays
		Death
			DeadRight
				icon='WhiteMBase.dmi'
				icon_state="deadright"
				//pixel_x=32
mob/var/tmp/hit
mob/var/tmp/KillCombo=0
mob/var/tmp/Attacked
mob/var/tmp/levelrate=0
mob/var
	undlvlatck=0
	overlvl=0
mob
	proc
		Death(mob/X,JashinFix)
			set waitfor = 0
			if(!X.key)
				goto trol
			if(!src.key)
				goto trol
			if(src.level<=4&&X.level>4)
				src.health=src.maxhealth
				return
			if(X.level<=4)
				X<<"<font color=red><b>WARNING:</b><font color=white>You cannnot kill anyone while under level 5."
				return
			if(X.jailed==1)
				X.health=X.maxhealth
				return
			if(src.jailed==1)
				src.health=src.maxhealth
				return
			trol
			src.UpdateHMB()
			if(loc == null) return //TEST
			var/area/A=loc.loc
			hit=1
			spawn(100)hit=0
			src.HengeUndo()
			if(immortal)
				if(src.health < 1)
					src.health=1
					UpdateHMB()
					return
			if(AdminShield)
				src.health=maxhealth
				UpdateHMB()
				return
			if(Tutorial&&Tutorial!=7)//TUT
				src.health=maxhealth
				UpdateHMB()
				return
			if(JashinFix)if(prob(50))return
			for(var/obj/JashinSymbol/O in src.loc)
				sleep(1)
				if(O&&O.Owner==src&&O.JashinConnected)
					var/mob/HitMe=O.JashinConnected
					if(!HitMe||!ismob(HitMe)) continue
					HitMe.health-= src.strength*2
					F_damage(HitMe,src.strength*2)
					HitMe.Bleed()
					src.Bleed()
					HitMe.UpdateHMB()
					view() << sound('knife_hit1.wav')
					src.UpdateHMB()
					HitMe.Death(src)
			if(ismob(X))
				if(istype(X,/mob/Karasu))X=X.Owner
				if(icon_state=="push"&&X==src)
					var/area/AK=X.loc.loc
					if(A.Safe==1||AK.Safe==1)
						src.health=src.maxhealth
						src.UpdateHMB()
						return
				if(src.key&&X&&X!=src&&X.key&&!dueling)
					var/area/AK=X.loc.loc
					X.Attacked=src
					spawn(200) if(X) X.Attacked=null
					if(A.Safe==1||AK.Safe==1)
						src.health=src.maxhealth
						src.UpdateHMB()
						return
			if(src.health<=0&&src.dead==0)
				if(istype(src,/mob/player))
					if(ismob(X))
						if(X.needkill==1)X.needkill=2
					src.KillCombo=0
					Effects["Rasengan"]=null
					Effects["Chidori"]=null
					gatestop()
					if(src.Susanoo)
						src.health=1
						return
					if(src.client)src.client.eye=src
					src.screen_moved=0
					for(var/obj/Projectiles/Effects/AlmightyPush/JP in range(src,0))del(JP)
					if(src.client)
						src.client.images=0
						src.Target_ReAdd()
						src.client:perspective = EDGE_PERSPECTIVE
					src.likeaclone=null
					if(src.client)src.client.eye=src
					src.arrow=null
					src.cranks=null
					src.copy=null
					src.ArrowTasked=null
					for(var/mob/Clones/C in src.Clones)
						C.health=0
						C.Death(src)
					src.bunshin=0
					src.sbunshin=0
					src.msbunshin=0
					src.mizubunshin=0
					if(istype(A,/area/Dojo))
						if(ismob(X))
							if(src==X)
								src<<output("You've just self-killed.'No exp from that...","ActionPanel.Output")
								goto skip
							X.levelrate+=1
							if(X.levelrate>=1) X.levelrate=1
						skip
						var/area/Dojo/D=A
						src.health=maxhealth/2
						src.chakra=src.maxchakra/2
						src.injutsu=0//Anti stuck after dojo.
						src.canattack=1
						src.firing=0
						src.icon_state=""
						src.wait=0
						src.rest=0
						src.dodge=0
						src.move=1
						view(src)<<output("[src] has been KO'd and removed from the Dojo.","ActionPanel.Output")
						if(istype(locate(D.DojoX,D.DojoY,D.DojoZ),/turf/))src.loc=locate(D.DojoX,D.DojoY,D.DojoZ)
						else src.loc=MapLoadSpawn()
						UpdateHMB()
						if(ismob(X)&&src != X)
							X.exp+=((0.1*X.KillCombo)+0.1)
						if(X&&src != X&&ismob(X)&&X.KillCombo<5+round(X.agility/5))
							X.KillCombo++
						return
					if(dueling)
						world << output("[opponent] has defeated [src] in an arena battle.","ActionPanel.Output")
						src.loc=locate(110,90,3)
						src.health=src.maxhealth
						src.kawarmi=0
						var/mob/i=opponent
						i.loc=locate(110,90,3)
						i.health=i.maxhealth
						i.kawarmi=0
						arenaprogress=0
						opponent.dueling=0
						src.dueling=0
						return
					if(ChuuninOpponentOne==src&&ChuuninOpponentTwo==X)
						ChuuninDuelLoser=src
						ChuuninDuelWinner=X
						src.health=maxhealth
						return
					if(ChuuninOpponentTwo==src&&ChuuninOpponentOne==X)
						ChuuninDuelLoser=src
						ChuuninDuelWinner=X
						src.health=maxhealth
						return
					var/DeadLocation=src.loc
					src.health=0
					src.chakra=0
					src.move=0
					src.dead=1
					src.canattack=0
					src.firing=1
					src.density=0
					src.dodge=0
					src.Sleeping=0
					src.levelrate=0
					src.injutsu=1
					src.icon_state="dead"
					for(var/obj/ChuuninExam/Scrolls/S in src)S.Move(src.loc)
					spawn()
						while(dead)
							loc=DeadLocation
							icon_state="dead"
							move=0
							injutsu=1
							canattack=0
							sleep(1)
					src.wait=0
					src.rest=0
					src.overlays=0
					src.RestoreOverlays()
					src.UpdateHMB()
					if(ismob(X)) if(X&&X.key&&src!=X)
						if(X&&ismob(X)&&X.KillCombo<5+round(X.agility/5))
							X.KillCombo++
						if(X.village==src.village&&X.village!="Missing-Nin"&&src.village!="Missing-Nin")
							world<<output("[src] was knocked out by [X], and they were both from the [src.village]!","ActionPanel.Output")
							//text2file("[src]([src.key]) was ko'd by [X]([X.key]) at [time2text(world.timeofday, "MMM DD hh:mm:ss")]<br>","KillLog.txt")
							if(X.village == "Missing-Nin"|| X.village == "Seven Swordsmen"||X.village=="Akatsuki"||X.village=="Anbu Root") goto MissSkip
							if(loc in block(locate(71,95,4),locate(200,163,4))) goto chuuninskip
							X.exp-=round(X.exp*0.5)
							X.Vkill++
							if(X.exp<=0) X.exp=0
							X<<output("You have lost 50% of your EXP for killing a fellow villager.","ActionPanel.Output")

							if(!X.CheckVKill())
								X<<output("Careful! Killing your villagers will get you kicked from the village. ([X.Vkill]/5)","ActionPanel.Output")
							else //if(X.CheckVkill())
								world<<output("[X] has been booted from [X.village] for village killing!","ActionPanel.Output")
								text2file("[X] has been booted from [X.village] for village killing: [time2text(world.timeofday, "MMM DD hh:mm:ss")]<br>","GMLog.txt")

								X.village="Missing-Nin"
								X.rank="Missing-Nin"

							MissSkip
							chuuninskip
							X.KillCombo=0

						else world<<output("[src] was knocked out by [X]!","ActionPanel.Output")
						text2file("[src]([src.key]) was ko'd by [X]([X.key]) at [time2text(world.timeofday, "MMM DD hh:mm:ss")]<br>","KillLog.txt")//Kill Log test
						src<<output("You were knocked out by [X].","ActionPanel.Output")
						X.levelrate+=2
						X.exp+=rand(3,(X.levelrate))
						if(X.levelrate>=5) X.levelrate=5
						X.Ryo+=src.Ryo
						X<<output("You have looted [src.Ryo] Ryo from [src].","ActionPanel.Output")
						X.kills++
						//X.Multikill++
						if(X.joinedwar==1)
							world<<"<font color = #C0C0C0>[src],[src.village] shinobi was knocked out by [X]...[X.village] gets 1 point!"
							if(X.village=="Hidden Sand")
								sandwarpoints++
								X.exp+=rand(3,5)
							if(X.village=="Hidden Mist")
								mistwarpoints++
								X.exp+=rand(3,5)
							if(X.village=="Hidden Leaf")
								leafwarpoints++
								X.exp+=rand(3,5)
							if(X.village=="Hidden Sound")
								soundwarpoints++
								X.exp+=rand(3,5)
							if(X.village=="Hidden Rock")
								rockwarpoints++
								X.exp+=rand(3,5)
							if(X.village=="Anbu Root")
								rootwarpoints++
						if(joinedakatshinobiw==1)
							if(src.village==X.village)
								world<<"<font color = #C0C0C0>[src],[src.village] ninja was knocked out by [X]...[X.village] LOOSES 1 point in war!"
								if(X.village=="Akatsuki"||X.village == "Seven Swordsmen")
									akatpoints--
									goto rofl
								else
									sforcepoints--
									goto rofl
							world<<"<font color = #C0C0C0>[src],[src.village] ninja was knocked out by [X]...[X] gets 1 PvP point."
							X.exp+=rand(5,10)
							X.pvppoints++
							if(X.village=="Akatsuki"||X.village == "Seven Swordsmen")
								world<<"Akatsuki gets 1 point in war!"
								akatpoints++
							else
								world<<"Shinobi Force gets a point!"
								sforcepoints++
						rofl
						//spawn() X.MedalCheck()
						//spawn(70) X.Multikill=0

						if(VillageAttackers.Find(src.village)&&VillageDefenders.Find(X.village))
							X<<output("You killed an enemy Shinobi! 10 Ryo has been granted to you for your efforts!","ActionPanel.Output")
							X.Ryo+=10
						if(VillageDefenders.Find(src.village)&&VillageAttackers.Find(X.village))
							X<<output("You killed an enemy Shinobi! 10 Ryo has been granted to you for your efforts!","ActionPanel.Output")
							X.Ryo+=10
						if(src.Bounty)
							X<<output("You have claimed the $[src.Bounty] bounty on [src.name]'s head.","ActionPanel.Output")
							X.Ryo+=src.Bounty
							src.Bounty=0
						else X.Bounty+=rand(5,10)
						if(X.Mission=="Kill [src] ([src.ckey])")
							X.Mission=null
							X<<output("You have successfully completed your mission.","ActionPanel.Output")
							var/MissionRyo=300
							var/MissionExp=10 + WorldXp
							if(X.Squad)
								var/mob/player/M = getOwner(X.Squad.Leader)
								M.Ryo += (MissionRyo + 1)
								M<<output("You have gained [(MissionRyo + 1)] Ryo and [MissionExp] EXP from your mission!","ActionPanel.Output")
								M.exp+=MissionExp
								for(var/i=0,i<MissionExp,i++)
									var/GAIN = rand(1,3)
									switch(GAIN)
										if(1)
											M.LevelStat("Ninjutsu",rand(10,25),1)
											M.Levelup()
										if(2)
											M.LevelStat("strength",rand(10,25),1)
											M.Levelup()
										if(3)
											M.LevelStat("Genjutsu",rand(10,25),1)
											M.Levelup()
								for(var/i in X.Squad.Members)
									if(getOwner(i))
										M = getOwner(i)
										if((M.client.inactivity/10)>=120) continue
										M.Ryo += MissionRyo + 1
										M.exp+=MissionExp
										for(var/i2=0,i2<MissionExp,i2++)
											var/GAIN = rand(1,3)
											switch(GAIN)
												if(1)
													M.LevelStat("Ninjutsu",rand(10,25),1)
													M.Levelup()
												if(2)
													M.LevelStat("strength",rand(10,25),1)
													M.Levelup()
												if(3)
													M.LevelStat("Genjutsu",rand(10,25),1)
													M.Levelup()
										M<<output("<I><font color=blue>You gained [(MissionRyo + 1)] Ryo, and [MissionExp] EXP from your mission! Mission reset.","ActionPanel.Output")
										//M.Mission=null
										for(var/obj/MissionObj/O in M)M.itemDelete(O)
							else
								X<<output("You have gained [MissionRyo] Ryo and [MissionExp] EXP from your mission! Mission reset","ActionPanel.Output")
								X.Ryo+=MissionRyo
								var/mob/player/M2 = X
								for(var/i=0,i<MissionExp,i++)
									var/GAIN = rand(1,3)
									switch(GAIN)
										if(1)
											M2.LevelStat("Ninjutsu",rand(10,25),1)
											M2.Levelup()
										if(2)
											M2.LevelStat("strength",rand(10,25),1)
											M2.Levelup()
										if(3)
											M2.LevelStat("Genjutsu",rand(10,25),1)
											M2.Levelup()
							X.Levelup()














						if(X.Mission=="Jounin Kill [src] ([src.ckey])")
							X.Mission=null
							X<<output("You have successfully completed your mission.","ActionPanel.Output")
							var/MissionRyo=600
							var/MissionExp=15 + WorldXp
							if(X.Squad)
								var/mob/player/M = getOwner(X.Squad.Leader)
								M.Ryo += (MissionRyo + 1)
								M<<output("You have gained [(MissionRyo + 1)] Ryo and [MissionExp] EXP from your mission!","ActionPanel.Output")
								M.exp+=MissionExp
								for(var/i=0,i<MissionExp,i++)
									var/GAIN = rand(1,3)
									switch(GAIN)
										if(1)
											M.LevelStat("Ninjutsu",rand(10,25),1)
											M.Levelup()
										if(2)
											M.LevelStat("strength",rand(10,25),1)
											M.Levelup()
										if(3)
											M.LevelStat("Genjutsu",rand(10,25),1)
											M.Levelup()
								for(var/i in X.Squad.Members)
									if(getOwner(i))
										M = getOwner(i)
										if((M.client.inactivity/10)>=120) continue
										M.Ryo += MissionRyo + 1
										M.exp+=MissionExp
										for(var/i2=0,i2<MissionExp,i2++)
											var/GAIN = rand(1,3)
											switch(GAIN)
												if(1)
													M.LevelStat("Ninjutsu",rand(10,25),1)
													M.Levelup()
												if(2)
													M.LevelStat("strength",rand(10,25),1)
													M.Levelup()
												if(3)
													M.LevelStat("Genjutsu",rand(10,25),1)
													M.Levelup()
										M<<output("<I><font color=blue>You gained [(MissionRyo + 1)] Ryo, and [MissionExp] EXP from your mission! Mission reset.","ActionPanel.Output")
										//M.Mission=null
										for(var/obj/MissionObj/O in M)M.itemDelete(O)
							else
								X<<output("You have gained [MissionRyo] Ryo and [MissionExp] EXP from your mission! Mission reset","ActionPanel.Output")
								X.Ryo+=MissionRyo
								var/mob/player/M2 = X
								for(var/i=0,i<MissionExp,i++)
									var/GAIN = rand(1,3)
									switch(GAIN)
										if(1)
											M2.LevelStat("Ninjutsu",rand(10,25),1)
											M2.Levelup()
										if(2)
											M2.LevelStat("strength",rand(10,25),1)
											M2.Levelup()
										if(3)
											M2.LevelStat("Genjutsu",rand(10,25),1)
											M2.Levelup()
						if(X.Mission=="Elite Kill [src] ([src.ckey])")
							X.Mission=null
							X<<output("You have successfully completed your mission.","ActionPanel.Output")
							var/MissionRyo=600
							var/MissionExp=25 + WorldXp
							if(X.Squad)
								var/mob/player/M = getOwner(X.Squad.Leader)
								M.Ryo += (MissionRyo + 1)
								M<<output("You have gained [(MissionRyo + 1)] Ryo and [MissionExp] EXP from your mission!","ActionPanel.Output")
								M.exp+=MissionExp
								for(var/i=0,i<MissionExp,i++)
									var/GAIN = rand(1,3)
									switch(GAIN)
										if(1)
											M.LevelStat("Ninjutsu",rand(10,25),1)
											M.Levelup()
										if(2)
											M.LevelStat("strength",rand(10,25),1)
											M.Levelup()
										if(3)
											M.LevelStat("Genjutsu",rand(10,25),1)
											M.Levelup()
								for(var/i in X.Squad.Members)
									if(getOwner(i))
										M = getOwner(i)
										if((M.client.inactivity/10)>=120) continue
										M.Ryo += MissionRyo + 1
										M.exp+=MissionExp
										for(var/i2=0,i2<MissionExp,i2++)
											var/GAIN = rand(1,3)
											switch(GAIN)
												if(1)
													M.LevelStat("Ninjutsu",rand(10,25),1)
													M.Levelup()
												if(2)
													M.LevelStat("strength",rand(10,25),1)
													M.Levelup()
												if(3)
													M.LevelStat("Genjutsu",rand(10,25),1)
													M.Levelup()
										M<<output("<I><font color=blue>You gained [(MissionRyo + 1)] Ryo, and [MissionExp] EXP from your mission! Mission reset.","ActionPanel.Output")
										//M.Mission=null
										for(var/obj/MissionObj/O in M)M.itemDelete(O)
							else
								X<<output("You have gained [MissionRyo] Ryo and [MissionExp] EXP from your mission! Mission reset","ActionPanel.Output")
								X.Ryo+=MissionRyo
								var/mob/player/M2 = X
								for(var/i=0,i<MissionExp,i++)
									var/GAIN = rand(1,3)
									switch(GAIN)
										if(1)
											M2.LevelStat("Ninjutsu",rand(10,25),1)
											M2.Levelup()
										if(2)
											M2.LevelStat("strength",rand(10,25),1)
											M2.Levelup()
										if(3)
											M2.LevelStat("Genjutsu",rand(10,25),1)
											M2.Levelup()

					src.Ryo=0
					spawn(300)
						if(!revived)
							KOs++
							src.dead=0
							if(KOs>=2&&!Chuunins.Find(src))
								if(X&&X.key&&src!=X)
									if(X.z in global.warmaps && src.z in global.warmaps)
										if(X.village == "Hidden Sand")
											global.sandpoints["[X.z]"]+=src.level
										if(X.village == "Hidden Leaf")
											global.leafpoints["[X.z]"]+=src.level
										if(X.village == "Hidden Mist")
											global.mistpoints["[X.z]"]+=src.level
										if(X.village == "Hidden Sound")
											global.soundpoints["[X.z]"]+=src.level
										if(X.village == "Hidden Rock")
											global.rockpoints["[X.z]"]+=src.level
								if(src.revived==0)
									var/list/Spawns=RespawnSpawn()
									if(!Spawns.len) src.loc=locate(1,1,4)
									else src.loc=pick(src.RespawnSpawn())
								else src.revived=0
								KOs=0
							if(KOs>=2)KOs=0
							src.density=1
							src.health=src.maxhealth
							src.chakra=src.maxchakra
							src.injutsu=0
							src.canattack=1
							src.firing=0
							src.icon_state=""
							src.wait=0
							src.rest=0
							src.dodge=0
							src.move=1
							src.joinedwar=0
							src.joinedakatshinobiw=0
							src.swimming=0
							src.walkingonwater=0
							src.overlays=0
							src.RestoreOverlays()
							src.UpdateHMB()
							spawn(1)src.Run()
						revived=0
				if(istype(src,/mob/Clones))
					var/mob/O=src.Owner
					if(O.likeaclone)
						O.likeaclone=null
						O.client:perspective = EDGE_PERSPECTIVE
						O.client:eye=O
						O.target_mob=null
						O.takeova=0
					/*if(O.likeaclone)
						O.client:perspective = EDGE_PERSPECTIVE
						O.client.eye=O*/
					if(istype(src,/mob/Clones/Bunshin))O.bunshin--
					if(istype(src,/mob/Clones/Shadow))O.sbunshin=0
					if(istype(src,/mob/Clones/MShadow))	O.msbunshin--
					if(istype(src,/mob/Clones/MizuBunshin))
						O.mizubunshin--
						view(src)<<sound('sg_explode.wav',0,0)
						icon='Water Bunshin.dmi'
						flick("form",src)
					view(src)<<sound('sg_explode.wav',0,0)
					var/obj/S = new/obj/MiscEffects/Smoke(src.loc)
					S.loc=src.loc
					spawn(1)
						if(src)
							src.loc = null
				if(istype(src,/mob/Untargettable/C2))
					flick("destroy",src)
					spawn(3)del(src)
				/*if(istype(src,/mob/Missions/Bandit))
					if(findtext(X.Mission,"K.O a bandit"))
						X<<output("\yellow You've finished your mission. Congratulations, the bandit is down!.","ActionPanel.Output")
						X.Mission=null
						var/MissionRyo=100
						var/MissionExp=12+WorldXp
						X.IncreaseExp()
						if(usr.Squad)
							var/mob/M
							M = getOwner(usr.Squad.Leader)
							M.Ryo += (MissionRyo + 1)
							M<<output("You have gained [(MissionRyo + 1)] Ryo and [MissionExp] EXP from your mission!","ActionPanel.Output")
							M.exp+=MissionExp
							for(var/i in usr.Squad.Members)
								if(getOwner(i))
									M = getOwner(i)
									if((M.client.inactivity/10)>=120) continue
									M.Ryo += MissionRyo + 1
									M.exp+=MissionExp
									M<<output("<I><font color=blue>You gained [(MissionRyo + 1)] Ryo, and [MissionExp] EXP from your mission! Mission reset.","ActionPanel.Output")
									if(M.Mission=="K.O a bandit")
										M.Mission=null
									M.Levelup()
									Del(src)
						else
							usr<<output("You have gained [MissionRyo] Ryo and [MissionExp] EXP from your mission! Mission reset.","ActionPanel.Output")
							usr.Ryo+=MissionRyo
							usr.exp+=MissionExp
							usr.Levelup()
							Del(src)
						X.Levelup()*/