obj
	proc
		Levelup()
			if(src.exp>=src.maxexp&&src.level<4)
				if(!src.owner) return

				if(src.name=="Transformation Jutsu")
					if(src.level==3)
						return

				var/mob/Owner=getOwner(src.owner)
				Owner.PlayAudio('level.wav', output = AUDIO_HEARERS)
				Owner<<output("<font color= #dda0dd>Your [src] skill has advanced a level</Font>.","Action.Output")
				src.level++
				src.exp-=src.maxexp
				src.maxexp+=30

				if(src.name=="Clone Jutsu")
					if(src.level==2)Owner.maxbunshin=1
					if(src.level==3)Owner.maxbunshin=1
					if(src.level==4)Owner.maxbunshin=1
					Owner<<output("<font color= #bc8f8f>Your [src]'s clones now have more strength</Font>.","Action.Output")
				if(src.name=="Fire Release: Fire Ball")
					Owner<<output("<font color= #bc8f8f>Your [src] skill's base damage has increased</Font>.","Action.Output")
				if(src.name=="Meteor Punch")
					Owner<<output("<font color= #bc8f8f>Your [src] skill's base damage and knockback power has increased</Font>.","Action.Output")
				if(src.name=="Fire Release: Phoenix Immortal Fire Technique")
					if(src.level==2)
						Owner<<output("<font color= #bc8f8f>Your [src] skill is now able to fire 3 projectiles</Font>.","Action.Output")
						Owner.katon=3
					if(src.level==3)
						Owner<<output("<font color= #bc8f8f>Your [src] skill's base damage has increased</Font>.","Action.Output")
						Owner<<output("<font color= #bc8f8f>Your [src] skill is now able to fire 4 projectiles</Font>.","Action.Output")
						Owner.katon=4
					if(src.level==4)
						Owner<<output("<font color= #bc8f8f>Your [src] skill is now able to fire 5 projectiles</Font>.","Action.Output")
						Owner.katon=5
				if(src.name=="Body Replacement Jutsu")
					if(src.level==4)
						var/obj/Jutsus/AdvancedBodyReplace/J=new/obj/Jutsus/AdvancedBodyReplace
						if(!J) return
						if(J.type in Owner.jutsus_learned)del(J)
						else
							if(!J) return
							Owner<<output("<font color= #bc8f8f>You learned [J.name]</Font>.","Action.Output")
							Owner.jutsus.Add(J)
							Owner.jutsus_learned.Add(J.type)
							J.Owner=Owner
				if(src.name=="Transformation Jutsu")
					if(src.level==2)Owner<<output("<font color= #bc8f8f>[src.name] can now be used to transform into objects</Font>!","Action.Output")
					if(src.level==3)Owner<<output("<font color= #bc8f8f>[src.name] can now be used to transform into almost anything</Font>!","Action.Output")

mob
	proc
		LevelStat(stat,howmuch,mission)
			var/area/A=loc.loc
			if(!A) return
			if(A.Safe&&!mission) return
			if(src.exp_locked)
				return
			switch(stat)
				if("Defence")defexp += round(howmuch)
				if("Strength")strengthexp += round(howmuch)
				if("Ninjutsu")ninexp += round(howmuch)
				if("Genjutsu")genexp += round(howmuch)
				if("Agility")agilityexp += round(howmuch)
				if("Precision")precisionexp += round(howmuch)
			Levelup()

		Levelup()
			if(src.xplock==1)
				src<<output("You have an Experience lock on you. This measure is used against the abusers / AFK trainers. Admin decides when this is removed.","Action.Output")
				return
			if(src.exp>=src.maxexp)
				if(src.level>=100)
					goto next
				var/obj/O = new/obj
				O.icon = 'ChakraCharge.dmi'
				O.icon_state = "3x"
				O.layer=200
				src.overlays+=O
				src.PlayAudio('levelup.wav', output = AUDIO_HEARERS)
				src<<output("<font color= #bc8f8f>You leveled up!</Font>.","Action.Output")
				src.level+=1
				src.exp-=src.maxexp
				src.statpoints+=3
				src.skillpoints++
				src.maxchakra+=10
				src.maxhealth+=15
				if(src.level<=20)
					src.maxexp+=1
				if(src.level>20&&src.level<=40)
					src.maxexp+=2
				if(src.level>40&&src.level<=60)
					src.maxexp+=5
				if(src.level>60&&src.level<=80)
					src.maxexp+=8
				if(src.level>80&&src.level<=100)
					src.maxexp+=11

				if(src.client)
					spawn()
						var/squad/squad = src.GetSquad()
						if(squad)
							squad.Refresh()

				src.Levelup()
				spawn(15)
					src.overlays-=O
					O.loc = null
				next
			if(src.strengthexp>=src.maxstrengthexp)
				if(src.strength>=150)
					goto next
				src.PlayAudio('level.wav', output = AUDIO_HEARERS)
				src<<output("<font color=TaiOrange>You leveled up Strength</Font>.","Action.Output")
				src.exp+=1
				src.strength+=1
				src.strengthexp-=src.maxstrengthexp
				if(src.strength<=30)
					src.maxstrengthexp+=10+round(src.strength/2)
				if(src.strength>30&&src.strength<=60)
					src.maxstrengthexp+=30+round(src.strength/2)
				if(src.strength>60&&src.strength<=90)
					src.maxstrengthexp+=60+round(src.strength/2)
				if(src.strength>90&&src.strength<=120)
					src.maxstrengthexp+=100+round(src.strength/2)
				if(src.strength>120&&src.strength<=150)
					src.maxstrengthexp+=150+round(src.strength/2)
				src.Levelup()
				next

			if(src.ninexp>=src.maxninexp)
				if(src.ninjutsu>=150)
					goto next
				src.PlayAudio('level.wav', output = AUDIO_HEARERS)
				src<<output("<font color=NinBlue>You leveled up Ninjutsu</Font>.","Action.Output")
				src.exp+=1
				src.ninjutsu+=1
				src.ninexp-=src.maxninexp
				if(src.ninjutsu<=30)
					src.maxninexp+=10+round(src.ninjutsu/1.5)
				if(src.ninjutsu>30&&src.ninjutsu<=60)
					src.maxninexp+=30+round(src.ninjutsu/1.5)
				if(src.ninjutsu>60&&src.ninjutsu<=90)
					src.maxninexp+=60+round(src.ninjutsu/1.5)
				if(src.ninjutsu>90&&src.ninjutsu<=120)
					src.maxninexp+=100+round(src.ninjutsu/1.5)
				if(src.ninjutsu>120&&src.ninjutsu<=150)
					src.maxninexp+=150+round(src.ninjutsu/1.5)
				src.Levelup()
				next
			if(src.genexp>=src.maxgenexp)
				if(src.genjutsu>=150)
					goto next
				src.PlayAudio('level.wav', output = AUDIO_HEARERS)
				src<<output("<font color=blueviolet>You leveled up Genjutsu</Font>.","Action.Output")
				src.exp+=1
				src.genjutsu+=1
				src.genexp-=src.maxgenexp
				if(src.genjutsu<=30)
					src.maxgenexp+=10+round(src.genjutsu/3)
				if(src.genjutsu>30&&src.genjutsu<=60)
					src.maxgenexp+=30+round(src.genjutsu/3)
				if(src.genjutsu>60&&src.genjutsu<=90)
					src.maxgenexp+=60+round(src.genjutsu/3)
				if(src.genjutsu>90&&src.genjutsu<=120)
					src.maxgenexp+=100+round(src.genjutsu/3)
				if(src.genjutsu>120&&src.genjutsu<=150)
					src.maxgenexp+=150+round(src.genjutsu/3)
				src.Levelup()
				next
			if(src.defexp>=src.maxdefexp)
				if(src.defence>=150)
					goto next
				src.PlayAudio('level.wav', output = AUDIO_HEARERS)
				src<<output("<font color=maroon>You leveled up Defence</Font>.","Action.Output")
				src.exp+=1
				src.defence++
				src.defexp-=src.maxdefexp
				if(src.defence<=30)
					src.maxdefexp+=10+round(src.defence/2)
				if(src.defence>30&&src.defence<=60)
					src.maxdefexp+=30+round(src.defence/2)
				if(src.defence>60&&src.defence<=90)
					src.maxdefexp+=60+round(src.defence/2)
				if(src.defence>90&&src.defence<=120)
					src.maxdefexp+=100+round(src.defence/2)
				if(src.defence>120&&src.defence<=150)
					src.maxdefexp+=150+round(src.defence/2)
				src.Levelup()
				next
			if(src.agilityexp>=src.maxagilityexp)
				if(src.agility>=150)
					goto next
				src.PlayAudio('level.wav', output = AUDIO_HEARERS)
				src<<output("<font color=cornsilk>You leveled up Agility</Font>.","Action.Output")
				src.exp+=1
				src.agility++
				src.agilityexp-=src.maxagilityexp
				if(src.agility<=30)
					src.maxagilityexp+=10+round(src.agility/2)
				if(src.agility>30&&src.agility<=60)
					src.maxagilityexp+=30+round(src.agility/2)
				if(src.agility>60&&src.agility<=90)
					src.maxagilityexp+=60+round(src.agility/2)
				if(src.agility>90&&src.agility<=120)
					src.maxagilityexp+=100+round(src.agility/2)
				if(src.agility>120&&src.agility<=150)
					src.maxagilityexp+=150+round(src.agility/2)
				src.Levelup()
				src.attkspeed=(8-(0.04*src.agility))
//				if(src.agility==10)src.attkspeed=7
//				if(src.agility==20)src.attkspeed=6
//				if(src.agility==30)src.attkspeed=5
//				if(src.agility==50)src.attkspeed=4
//				if(src.agility==70)src.attkspeed=3
//				if(src.agility==90)src.attkspeed=2
//				if(src.agility==120)src.attkspeed=1
				next
			if(src.precisionexp>=src.maxprecisionexp)
				if(src.precision>=150)
					goto next
				src.PlayAudio('level.wav', output = AUDIO_HEARERS)
				src<<output("<font color=azure>You leveled up Precision</Font>.","Action.Output")
				src.exp+=1
				src.precision++
				src.precisionexp-=src.maxprecisionexp
				if(src.precision<=30)
					src.maxprecisionexp+=10+round(src.precision/1.5)
				if(src.precision>30&&src.precision<=60)
					src.maxprecisionexp+=30+round(src.precision/1.5)
				if(src.precision>60&&src.precision<=90)
					src.maxprecisionexp+=60+round(src.precision/1.5)
				if(src.precision>90&&src.precision<=120)
					src.maxprecisionexp+=100+round(src.precision/1.5)
				if(src.precision>120&&src.precision<=150)
					src.maxprecisionexp+=150+round(src.precision/1.5)
				src.Levelup()
				next

			spawn() src.UpdateHMB()
			
			if(src.rank == RANK_ACADEMY_STUDENT && src.level >= 25)
				src.rank = RANK_GENIN
				switch(src.village)
					if(VILLAGE_LEAF)
						src.RecieveItem(new/obj/Inventory/Clothing/HeadWrap/LeafHeadBand)
					if(VILLAGE_SAND)
						src.RecieveItem(new/obj/Inventory/Clothing/HeadWrap/SandHeadBand)
				src.client.Alert("Your elders have deemed you a true ninja. You've become a Genin!")

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
					if(!HitMe.dead)
						if(!HitMe||!ismob(HitMe)) continue
						var/jashpercent = (jutsudamage / 100)/15
						HitMe.DealDamage(src.maxhealth*(jashpercent/10),src,"maroon")
						HitMe.Bleed()
						src.health-=src.maxhealth*(jashpercent/20)
						src.Bleed()
						HitMe.UpdateHMB()
						src.PlayAudio('knife_hit1.wav', output = AUDIO_HEARERS)
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
					if(A.Safe==1||AK.Safe==1)
						src.health=src.maxhealth
						src.UpdateHMB()
						return
			if(src.health<=0&&src.dead==0)
				if(istype(src,/mob) && !istype(src, /mob/Clones))
					if(ismob(X))
						if(X.needkill==1)X.needkill=2
					src.KillCombo=0
					Effects["Rasengan"]=null
					Effects["Chidori"]=null
					spawn() gatestop()
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
								src<<output("You've just self-killed.'No exp from that...","Action.Output")
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
						view(src)<<output("[src] has been KO'd and removed from the Dojo.","Action.Output")
						if(istype(locate(D.DojoX,D.DojoY,D.DojoZ),/turf/))src.loc=locate(D.DojoX,D.DojoY,D.DojoZ)
						else src.loc=MapLoadSpawn()
						UpdateHMB()
						if(ismob(X)&&src != X)
							X.exp+=((0.1*X.KillCombo)+0.1)
						if(X&&src != X&&ismob(X)&&X.KillCombo<5+round(X.agility/5))
							X.KillCombo++
						return
					if(dueling)
						world << output("[opponent] has defeated [src] in an arena battle.","Action.Output")
						src.loc=locate(177,136,8)
						src.health=src.maxhealth
						src.kawarmi=0
						var/mob/i=opponent
						i.loc=locate(177,136,8)
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
					for(var/obj/Inventory/mission/deliver_intel/o in src.contents) src.DropItem(o)
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
							world<<output("[src] was knocked out by [X], and they were both from the [src.village]!","Action.Output")
							//text2file("[src]([src.key]) was ko'd by [X]([X.key]) at [time2text(world.realtime , "(YYYY-MM-DD hh:mm:ss)")]<br>",LOG_KILLS)
							if(X.village == "Missing-Nin"|| X.village == "Seven Swordsmen"||X.village=="Akatsuki"||X.village=="Anbu Root") goto MissSkip
							if(loc in block(locate(71,95,4),locate(200,163,4))) goto chuuninskip
							X.exp-=round(X.exp*0.5)
							X.Vkill++
							if(X.exp<=0) X.exp=0
							X<<output("You have lost 50% of your EXP for killing a fellow villager.","Action.Output")

							MissSkip
							chuuninskip
							X.KillCombo=0

						else if(!istype(src, /mob/npc/combat/white_zetsu) && !istype(src, /mob/npc/combat/animals)) world<<output("[src] was knocked out by [X]!","Action.Output")

						if(!istype(src, /mob/npc/combat/white_zetsu)&&!istype(src, /mob/npc/combat/animals))
							text2file("[src]([src.key]) was ko'd by [X]([X.key]) at [time2text(world.realtime , "(YYYY-MM-DD hh:mm:ss)")]<br>",LOG_KILLS)//Kill Log test
						src<<output("You were knocked out by [X].","Action.Output")
						if(!istype(src, /mob/npc/combat/animals))
							var/exp_loss = 2
							src.exp -= exp_loss
							src << output("You lose [exp_loss] experience points.","Action.Output")
							X.levelrate+=2
							X.exp+=rand(3,(X.levelrate))
							if(X.levelrate>=5) X.levelrate=5
						else
							X.exp += src.exp_reward

						// Loot Ryo //
						X.ryo += src.ryo
						src.ryo = 0
						view(X) << output("<i>[X] has looted [src.ryo] Ryo from [src].</i>", "Action.Output")

						// Loot Ryo Pouches //
						var/looted_pouches = 0
						var/looted_pouches_ryo = 0

						for(var/obj/Inventory/ryo_pouch/pouch in src.contents)
							X.contents += pouch
							looted_pouches++
							looted_pouches_ryo += pouch.ryo

						if(looted_pouches)
							spawn() src.client.UpdateInventoryPanel()
							spawn() X.client.UpdateInventoryPanel()
							view(X) << output("<i>[X] has looted [looted_pouches] Ryo Pouches containing [looted_pouches_ryo] Ryo from [src].</i>", "Action.Output")

						X.kills++
						//X.Multikill++

						if(VillageAttackers.Find(src.village)&&VillageDefenders.Find(X.village))
							X<<output("You killed an enemy Shinobi! 10 Ryo has been granted to you for your efforts!","Action.Output")
							X.ryo+=10
						if(VillageDefenders.Find(src.village)&&VillageAttackers.Find(X.village))
							X<<output("You killed an enemy Shinobi! 10 Ryo has been granted to you for your efforts!","Action.Output")
							X.ryo+=10
						if(src.Bounty)
							X<<output("You have claimed the $[src.Bounty] bounty on [src.name]'s head.","Action.Output")
							X.ryo+=src.Bounty
							src.Bounty=0
						else if(!istype(src, /mob/npc/combat/animals) && !istype(src, /mob/npc/combat/white_zetsu))
							X.Bounty+=rand(5,10)

//ZETSU EVENT XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX
	//Zetsu Killed
						if(src != X)
							if(istype(src, /mob/npc/combat/white_zetsu) && zetsu_event_active == 1)
								zetsu_count--
								switch(X.village)
									if(VILLAGE_LEAF)
										leaf_points++
									if(VILLAGE_SAND)
										sand_points++
								if(X.village != VILLAGE_MISSING_NIN && X.village != VILLAGE_AKATSUKI)
									if(zetsu_count > 0)
										world<<output("A white Zetsu has been slain by [X.name] earning the [X.village] village 1 point! There are still [zetsu_count] Zetsu somewhere!]","Action.Output")
									if(zetsu_count < 1)
										ZetsuEventEnd(X)
								else	
									if(zetsu_count > 0)
										world<<output("A white Zetsu has been slain by [X.name]! There are still [zetsu_count] Zetsu somewhere!]","Action.Output")
									if(zetsu_count < 1)
										ZetsuEventEnd(X)


	//Akatsuki Killed
							if(src.village == VILLAGE_AKATSUKI && zetsu_event_active == 1)
								var/squad/squad = X.GetSquad()
								if(X.village == VILLAGE_LEAF || X.village == VILLAGE_SAND)
									akat_lives_left--
									switch(X.village)
										if(VILLAGE_LEAF)
											leaf_points += 4
										if(VILLAGE_SAND)
											sand_points += 4
									if(akat_lives_left > 0)
										world << output ("[X.name] has slain a member of the Akatsuki earning the [X.village] village 4 points! (Akatsuki lives remaining: [akat_lives_left])", "Action.Output")
										if(squad)
											for(var/mob/m in mobs_online)
												if(squad.members[m.client.ckey])
													m << output ("[X.name] has killed a member of the Akatsuki! You've earned 10 bonus experience for your squad!", "Action.Output")
													m.exp += 10
													m.Levelup()
										else
											X.exp += 10
											X.Levelup()
									else
										ZetsuEventEnd(X)

	//Villager Killed
							if(src.village == VILLAGE_LEAF || src.village == VILLAGE_SAND)
								var/squad/squad = X.GetSquad()
								if(X.village == VILLAGE_AKATSUKI && zetsu_event_active == 1 || istype(X, /mob/npc/combat/white_zetsu))
									vill_lives_left--
									if(vill_lives_left > 0)
										world << output ("[X.name] has slain a member of the [src.village] village! (Shinobi Alliance lives remaining: [vill_lives_left])", "Action.Output")
										X << output ("It's a slaughter. You've earned 10 bonus experience for your squad!", "Action.Output")
										if(squad)
											for(var/mob/m in mobs_online)
												if(squad.members[m.client.ckey])
													m.exp += 10
													m.Levelup()
										else
											X.exp += 10
											X.Levelup()
									else
										ZetsuEventEnd(X)

	//Missing nin kills
							if(X.village == VILLAGE_MISSING_NIN && zetsu_event_active == 1)
								if(src.village == VILLAGE_AKATSUKI || src.village == VILLAGE_LEAF || src.village == VILLAGE_SAND)
									if(src.village == VILLAGE_AKATSUKI)
										akat_lives_left--
										world << output("A rogue ninja took advantage of the fray and has killed a member of the Akatuski! (Akatsuki lives remaining: [akat_lives_left])", "Action.Output")
									if(src.village == VILLAGE_LEAF || src.village == VILLAGE_SAND)
										vill_lives_left--
										world << output("A rogue ninja took advantage of the fray and has killed a member of the [X.village] village! (Shinobi Alliance lives remaining: [vill_lives_left])", "Action.Output")
									X << output ("With everything going on, they never saw you coming. You've earned 15 bonus experience!", "Action.Output")
									X.exp += 15
									X.Levelup()
									if(akat_lives_left < 1 || vill_lives_left < 1)
										ZetsuEventEnd(X)

	//Update Panels
							for(var/mob/m in mobs_online)
								var/squad/squad = m.GetSquad()
								spawn() m.client.UpdateCharacterPanel()
								if(squad)
									spawn() squad.RefreshMember(m)

//SEARCH AND DESTROY MISSIONS XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX

// Reward Squad (Killer) for killing a mob during search and destroy type missions.
						var/squad/squad = X.GetSquad()
						if(squad && squad.mission)
							switch(squad.mission.type)
//HUNTING ROGUES
								if(/mission/b_rank/hunting_rogues)
									if(src.village == VILLAGE_MISSING_NIN)
										squad.mission.required_vars["KILLS"]++
										for(var/mob/m in mobs_online)
											if(squad.members[m.client.ckey])
												m << output("[X] has slain the Missing-Nin [src] while on a mission hunting rogue ninja.", "Action.Output")
												m << output("<b>[squad.mission]:</b> [squad.mission.required_vars["KILLS"]]/[squad.mission.required_vars["REQUIRED_KILLS"]] rogue ninja have been eliminated.", "Action.Output")
										spawn() squad.mission.Complete(X)
//THE WAR EFFORT
								if(/mission/c_rank/the_war_effort)
									switch(X.village)
										if(VILLAGE_LEAF)
											if(src.village == VILLAGE_SAND)
												squad.mission.required_vars["KILLS"]++
												for(var/mob/m in mobs_online)
													if(squad.members[m.client.ckey])
														m << output("[X] has slain the enemy villager [src] as part of the war effort.", "Action.Output")
														m << output("<b>[squad.mission]:</b> [squad.mission.required_vars["KILLS"]]/[squad.mission.required_vars["REQUIRED_KILLS"]] enemy ninja have been eliminated.", "Action.Output")
												spawn() squad.mission.Complete(X)

										if(VILLAGE_SAND)
											if(src.village == VILLAGE_LEAF)
												squad.mission.required_vars["KILLS"]++
												for(var/mob/m in mobs_online)
													if(squad.members[m.client.ckey])
														m << output("[X] has slain the enemy villager [src] as part of the war effort.", "Action.Output")
														m << output("<b>[squad.mission]:</b> [squad.mission.required_vars["KILLS"]]/[squad.mission.required_vars["REQUIRED_KILLS"]] enemy ninja have been eliminated.", "Action.Output")
												spawn() squad.mission.Complete(X)

//CLOUDS OF CRIMSON

								if(/mission/s_rank/clouds_of_crimson)
									if(src.village == VILLAGE_AKATSUKI)
										squad.mission.required_vars["KILLS"]++
										for(var/mob/m in mobs_online)
											if(squad.members[m.client.ckey])
												m << output("[X] has slain the Akatsuki member [src] while on a mission to eliminate them.", "Action.Output")
												m << output("<b>[squad.mission]:</b> [squad.mission.required_vars["KILLS"]]/[squad.mission.required_vars["REQUIRED_KILLS"]] Akatsuki members have been eliminated.", "Action.Output")
										spawn() squad.mission.Complete(X)
// Penalize Squad for dying while on a search and destroy mission
						squad = src.GetSquad()
						if(squad && squad.mission)
							switch(squad.mission.type)
//HUNTING ROGUES
								if(/mission/b_rank/hunting_rogues)
									squad.mission.required_vars["DEATHS"]++
									for(var/mob/m in mobs_online)
										if(squad.members[m.client.ckey])
											m << output("[src] has died to [X] while on a mission hunting rogue ninja.", "Action.Output")
											m << output("<b>[squad.mission]:</b> [squad.mission.required_vars["DEATHS"]]/[squad.members.len] fatalities while hunting rogue ninja.", "Action.Output")
									spawn() squad.mission.Complete(src)
//THE WAR EFFORT
								if(/mission/c_rank/the_war_effort)
									squad.mission.required_vars["DEATHS"]++
									for(var/mob/m in mobs_online)
										if(squad.members[m.client.ckey])
											m << output("[src] has died to [X] while on a mission hunting enemy ninja.", "Action.Output")
											m << output("<b>[squad.mission]:</b> [squad.mission.required_vars["DEATHS"]]/[squad.members.len] fatalities while hunting enemy ninja.", "Action.Output")
									spawn() squad.mission.Complete(src)

//CLOUDS OF CRIMSON

								if(/mission/s_rank/clouds_of_crimson)
									squad.mission.required_vars["DEATHS"]++
									for(var/mob/m in mobs_online)
										if(squad.members[m.client.ckey])
											m << output("[src] has died to [X] while on a mission to eliminate the Akatsuki.", "Action.Output")
											m << output("<b>[squad.mission]:</b> [squad.mission.required_vars["DEATHS"]]/[squad.members.len] fatalities while hunting the Akatsuki.", "Action.Output")
									spawn() squad.mission.Complete(src)

// Reward player (Killer) for killing someone who is on a search and destroy type mission which targets you.
						squad = src.GetSquad()
						if(squad && squad.mission)
							switch(squad.mission.type)
//HUNTING ROGUES
								if(/mission/b_rank/hunting_rogues)
									if(X.village == VILLAGE_MISSING_NIN)
										X << output("You have slain [src] who was on a mission hunting rogue ninja.", "Action.Output")
										X.exp += 1
										X.ryo += 1
										X << output("You Recieve 1 exp and 1 ryo as a reward for your effort.", "Action.Output")
										spawn() X.Levelup()
//THE WAR EFFORT
								if(/mission/c_rank/the_war_effort)
									if(X.village == VILLAGE_LEAF && src.village != VILLAGE_LEAF)
										X << output("You have slain [src] who was on a mission hunting leaf ninja!.", "Action.Output")
										X.exp += 1
										X.ryo += 1
										X << output("You Recieve 1 exp and 1 ryo as a reward for your effort.", "Action.Output")
										spawn() X.Levelup()
									if(X.village == VILLAGE_SAND && src.village != VILLAGE_SAND)
										X << output("You have slain [src] who was on a mission hunting sand ninja!.", "Action.Output")
										X.exp += 1
										X.ryo += 1
										X << output("You Recieve 1 exp and 1 ryo as a reward for your effort.", "Action.Output")
										spawn() X.Levelup()

//CLOUDS OF CRIMSON

								if(/mission/s_rank/clouds_of_crimson)
									if(X.village == VILLAGE_AKATSUKI)
										X << output("You have slain [src] who was on a mission to kill the Akatsuki.", "Action.Output")
										X.exp += 1
										X.ryo += 1
										X << output("You Recieve 1 exp and 1 ryo as a reward for your effort.", "Action.Output")
										spawn() X.Levelup()

//XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX

						if(X.Mission=="Kill [src] ([src.ckey])")
							X.Mission=null
							X<<output("You have successfully completed your mission.","Action.Output")
							var/MissionRyo=300
							var/MissionExp=10 + WorldXp
							if(X.Squad)
								var/mob/M = getOwner(X.Squad.Leader)
								M.ryo += (MissionRyo + 1)
								M<<output("You have gained [(MissionRyo + 1)] Ryo and [MissionExp] EXP from your mission!","Action.Output")
								M.exp+=MissionExp
								for(var/i=0,i<MissionExp,i++)
									var/GAIN = rand(1,3)
									switch(GAIN)
										if(1)
											M.LevelStat("Ninjutsu",rand(10,25),1)

										if(2)
											M.LevelStat("strength",rand(10,25),1)

										if(3)
											M.LevelStat("Genjutsu",rand(10,25),1)

								for(var/i in X.Squad.Members)
									if(getOwner(i))
										M = getOwner(i)
										if((M.client.inactivity/10)>=120) continue
										M.ryo += MissionRyo + 1
										M.exp+=MissionExp
										for(var/i2=0,i2<MissionExp,i2++)
											var/GAIN = rand(1,3)
											switch(GAIN)
												if(1)
													M.LevelStat("Ninjutsu",rand(10,25),1)

												if(2)
													M.LevelStat("strength",rand(10,25),1)

												if(3)
													M.LevelStat("Genjutsu",rand(10,25),1)

										M<<output("<I><font color=blue>You gained [(MissionRyo + 1)] Ryo, and [MissionExp] EXP from your mission! Mission reset.","Action.Output")
										//M.Mission=null
										for(var/obj/MissionObj/O in M) M.DestroyItem(O)
							else
								X<<output("You have gained [MissionRyo] Ryo and [MissionExp] EXP from your mission! Mission reset","Action.Output")
								X.ryo+=MissionRyo
								var/mob/M2 = X
								for(var/i=0,i<MissionExp,i++)
									var/GAIN = rand(1,3)
									switch(GAIN)
										if(1)
											M2.LevelStat("Ninjutsu",rand(10,25),1)

										if(2)
											M2.LevelStat("strength",rand(10,25),1)

										if(3)
											M2.LevelStat("Genjutsu",rand(10,25),1)

							X.Levelup()

						if(X.Mission=="Jounin Kill [src] ([src.ckey])")
							X.Mission=null
							X<<output("You have successfully completed your mission.","Action.Output")
							var/MissionRyo=600
							var/MissionExp=15 + WorldXp
							if(X.Squad)
								var/mob/M = getOwner(X.Squad.Leader)
								M.ryo += (MissionRyo + 1)
								M<<output("You have gained [(MissionRyo + 1)] Ryo and [MissionExp] EXP from your mission!","Action.Output")
								M.exp+=MissionExp
								for(var/i=0,i<MissionExp,i++)
									var/GAIN = rand(1,3)
									switch(GAIN)
										if(1)
											M.LevelStat("Ninjutsu",rand(10,25),1)

										if(2)
											M.LevelStat("strength",rand(10,25),1)

										if(3)
											M.LevelStat("Genjutsu",rand(10,25),1)

								for(var/i in X.Squad.Members)
									if(getOwner(i))
										M = getOwner(i)
										if((M.client.inactivity/10)>=120) continue
										M.ryo += MissionRyo + 1
										M.exp+=MissionExp
										for(var/i2=0,i2<MissionExp,i2++)
											var/GAIN = rand(1,3)
											switch(GAIN)
												if(1)
													M.LevelStat("Ninjutsu",rand(10,25),1)

												if(2)
													M.LevelStat("strength",rand(10,25),1)

												if(3)
													M.LevelStat("Genjutsu",rand(10,25),1)

										M<<output("<I><font color=blue>You gained [(MissionRyo + 1)] Ryo, and [MissionExp] EXP from your mission! Mission reset.","Action.Output")
										//M.Mission=null
										for(var/obj/MissionObj/O in M) M.DestroyItem(O)
							else
								X<<output("You have gained [MissionRyo] Ryo and [MissionExp] EXP from your mission! Mission reset","Action.Output")
								X.ryo+=MissionRyo
								var/mob/M2 = X
								for(var/i=0,i<MissionExp,i++)
									var/GAIN = rand(1,3)
									switch(GAIN)
										if(1)
											M2.LevelStat("Ninjutsu",rand(10,25),1)

										if(2)
											M2.LevelStat("strength",rand(10,25),1)

										if(3)
											M2.LevelStat("Genjutsu",rand(10,25),1)

						if(X.Mission=="Elite Kill [src] ([src.ckey])")
							X.Mission=null
							X<<output("You have successfully completed your mission.","Action.Output")
							var/MissionRyo=600
							var/MissionExp=25 + WorldXp
							if(X.Squad)
								var/mob/M = getOwner(X.Squad.Leader)
								M.ryo += (MissionRyo + 1)
								M<<output("You have gained [(MissionRyo + 1)] Ryo and [MissionExp] EXP from your mission!","Action.Output")
								M.exp+=MissionExp
								for(var/i=0,i<MissionExp,i++)
									var/GAIN = rand(1,3)
									switch(GAIN)
										if(1)
											M.LevelStat("Ninjutsu",rand(10,25),1)

										if(2)
											M.LevelStat("strength",rand(10,25),1)

										if(3)
											M.LevelStat("Genjutsu",rand(10,25),1)

								for(var/i in X.Squad.Members)
									if(getOwner(i))
										M = getOwner(i)
										if((M.client.inactivity/10)>=120) continue
										M.ryo += MissionRyo + 1
										M.exp+=MissionExp
										for(var/i2=0,i2<MissionExp,i2++)
											var/GAIN = rand(1,3)
											switch(GAIN)
												if(1)
													M.LevelStat("Ninjutsu",rand(10,25),1)

												if(2)
													M.LevelStat("strength",rand(10,25),1)

												if(3)
													M.LevelStat("Genjutsu",rand(10,25),1)

										M<<output("<I><font color=blue>You gained [(MissionRyo + 1)] Ryo, and [MissionExp] EXP from your mission! Mission reset.","Action.Output")
										//M.Mission=null
										for(var/obj/MissionObj/O in M) M.DestroyItem(O)
							else
								X<<output("You have gained [MissionRyo] Ryo and [MissionExp] EXP from your mission! Mission reset","Action.Output")
								X.ryo += MissionRyo
								var/mob/M2 = X
								for(var/i=0,i<MissionExp,i++)
									var/GAIN = rand(1,3)
									switch(GAIN)
										if(1)
											M2.LevelStat("Ninjutsu",rand(10,25),1)

										if(2)
											M2.LevelStat("strength",rand(10,25),1)

										if(3)
											M2.LevelStat("Genjutsu",rand(10,25),1)
											
					if(!Chuunins.Find(src))
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

					var/respawned = 0

					spawn(3000) if(!respawned && src.dead) src.Respawn()

					if(src.client && src.client.Alert("Please wait for a medic or respawn in the hospital", "Reaper", list("Respawn")))
						if(src.dead)
							respawned = 1
							src.Respawn()

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
						src.PlayAudio('sg_explode.wav', output = AUDIO_HEARERS)
						icon='Water Bunshin.dmi'
						flick("form",src)
					src.PlayAudio('sg_explode.wav', output = AUDIO_HEARERS)
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
						X<<output("\yellow You've finished your mission. Congratulations, the bandit is down!.","Action.Output")
						X.Mission=null
						var/MissionRyo=100
						var/MissionExp=12+WorldXp
						X.IncreaseExp()
						if(usr.Squad)
							var/mob/M
							M = getOwner(usr.Squad.Leader)
							M.ryo += (MissionRyo + 1)
							M<<output("You have gained [(MissionRyo + 1)] Ryo and [MissionExp] EXP from your mission!","Action.Output")
							M.exp+=MissionExp
							for(var/i in usr.Squad.Members)
								if(getOwner(i))
									M = getOwner(i)
									if((M.client.inactivity/10)>=120) continue
									M.ryo += MissionRyo + 1
									M.exp+=MissionExp
									M<<output("<I><font color=blue>You gained [(MissionRyo + 1)] Ryo, and [MissionExp] EXP from your mission! Mission reset.","Action.Output")
									if(M.Mission=="K.O a bandit")
										M.Mission=null
									M.Levelup()
									Del(src)
						else
							usr<<output("You have gained [MissionRyo] Ryo and [MissionExp] EXP from your mission! Mission reset.","Action.Output")
							usr.ryo+=MissionRyo
							usr.exp+=MissionExp
							usr.Levelup()
							Del(src)
						X.Levelup()*/