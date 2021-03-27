//This is where handsigns are defined and procs to use the jutsu if it's uses are met are set.
turf
	chuuninhands
		icon = 'Chuuninhands.png'
mob
	var
		list2
		crecord
		maxbunshin=1
		maxmsbunshin=2
		maxmizubunshin=2
		katon=2
	//	UchihaJ=0
		tmp
			copy
			bunshin=0
			sbunshin=0
			msbunshin=0
			first
			second
			third
			fourth
			fifth
			sixth
			seventh
			eighth
			nineth
			tenth
			eleventh
			twelveth
			rabbit=0
			rat=0
			dog=0
			horse=0
			dragon=0
			monkey=0
			ox=0
			snake=0
			HandSeals
			SealCount
			HandSigning
			Spaced
			SealCounting = 0
obj
	var
		tmp
			Excluded=0
		signs
		rank
		uses=0
		IsGate = 0
//mob
//	proc
//		Quake_Effect(mob/M,duration,strength=1)
//			if(!M.client)return
//			spawn(1)
//				var/oldeye=M.client.eye
//				var/x
//				for(x=0;x<duration,x++)
//					M.client.eye = get_steps(M,pick(NORTH,SOUTH,EAST,WEST),strength)
//					sleep(1)
//				M.client.eye=oldeye
//Rat,Ox,Dog,Dragon,Snake,Horse,Rabbit,Monkey
mob/var/list/sbought = list()
obj
	var/Sprice=1
	var/reqs = list()
	var/starterjutsu=0
	var/sharin=0
	Jutsus
		var/ChakraCost
		var/Clan
		var/Element
		var/Element2
		var/Kekkai
		var/Specialist
		//var/Damage this might be needed who knows.
		icon='Misc Effects.dmi'
		layer=10
		pixel_x=12
		New()
			if(src.z==4)invisibility=1
		Click()
			if(usr.Tutorial==3&&src.type!=/obj/Jutsus/BodyReplace)
				usr<<"You shouldn't buy this, you need the Substitution Technique found under Non Clan Skills."
				return
			if(src.type in usr.jutsus_learned)
				if(usr.client.eye==locate(10,10,4)||usr.client.eye==locate(60,10,4)||usr.client.eye==locate(12,43,4)||usr.client.eye==locate(55,43,4)||usr.client.eye==locate(10,75,4)) return//lol tenten
				if(src.uses >= 80 && !src.IsGate)
					usr.doslot(src.name)
				else
					if(!IsGate)
						usr << output("<Font color=red>You need to use [src.name] [80-src.uses] more times([src.uses]).</Font>","ActionPanel.Output")
					else
						usr << output("You may not put this technique on a hotslot.","ActionPanel.Output")
			else
				if(src.name in usr.sbought)return
				if(src.name=="Sage Mode"&&"Curse Seal" in usr.sbought)
					usr<<output("You already have Curse Seal!","ActionPanel.Output")
					return
				if(src.name=="Sage Mode"&& "Rinnegan" in usr.sbought)
					usr<<output("The Rinnegan prohibits you from tainting your body.","ActionPanel.Output")
					return
				if(src.name=="Curse Seal"&& "Sage Mode"in usr.sbought)
					usr<<output("You already have Curse Mark!","ActionPanel.Output")
					return
				if(src.name=="Curse Seal"&&"Rinnegan" in usr.sbought)
					usr<<output("The Rinnegan prohibits you from tainting your body.","ActionPanel.Output")
					return
				if(src.name=="Rinnegan"&& "Curse Seal"in usr.sbought)
					usr<<output("The Rinnegan rejects your Curse Seal.","ActionPanel.Output")
					return
				if(src.name=="Rinnegan"&& "Sage Mode"in usr.sbought)
					usr<<output("The Rinnegan rejects your Sage Mode.","ActionPanel.Output")
					return
				if((src.name=="Sage Mode" || src.name=="Curse Seal")&&usr.Clan == "Gates")
					usr<<output("Gates require a pure body to work!","ActionPanel.Output")
					return

			/*	if(usr.UchihaJ>=3)
					usr<<" You can not learn any more clan jutsu."
					return */
				var/has_reqs = 0
				var/check=0
				var/Element1
				var/Element2z
				var/KekkaiC
				var/SpecialistZ
				for(var/X in src.reqs)
					for(var/O in usr.sbought)
						if(O == X)check+=1
				if(check == length(src.reqs))has_reqs=1
				else has_reqs=0
				if(Clan)
					if(Clan!=usr.Clan)
						usr<<output("You are not the appropriate clan to learn this technique. ([Clan]).","ActionPanel.Output")
						return
				if(src.Element)if(src.Element!=usr.Element&&src.Element!=usr.Element2)Element1=1
				if(src.Element2)if(src.Element2!=usr.Element&&src.Element2!=usr.Element2)Element2z=1
				if(src.Kekkai)if(src.Kekkai!=usr.Kekkai)KekkaiC=1
				if(src.Specialist)if(src.Specialist!=usr.Specialist)SpecialistZ=1
				if(Element1)
					usr<<output("You do not have the appropriate element affinity to learn this technique. ([Element][Element2 ? " and [Element2]" : ""]).","ActionPanel.Output")
					return
				if(Element2z)
					usr<<output("You do not have the appropriate element affinity to learn this technique. ([Element][Element2 ? " and [Element2]" : ""]).","ActionPanel.Output")
					return
				if(KekkaiC)
					usr<<output("You do not have the appropriate Kekkai Genkai to learn this technique..","ActionPanel.Output")
					return
				if(SpecialistZ)
					usr<<output("You are not the appropriate speciality to learn this technique. ([Specialist]).","ActionPanel.Output")
					return
				if(has_reqs==1)
					var/I=usr.CustomInput("Skill Tree","[Description]<br><br>Buy this jutsu for [src.Sprice] skill points?",list("Yes","No"))
					if(!I) return
					switch(I:name)
						if("Yes")
							if(usr.skillpoints<src.Sprice)
								usr<<output("Not enough skill points to purchase [src.name]. You need [src.Sprice].","ActionPanel.Output")
								return
							usr.skillpoints -= src.Sprice
							if(src.IsGate)
								if(!typesof(/obj/Jutsus/EightGates) in usr.jutsus_learned)
									var/obj/Jutsus/jutsu = new /obj/Jutsus/EightGates()
									usr.jutsus += jutsu
									usr.jutsus_learned += jutsu.type
									usr.sbought += jutsu.name
								for(var/obj/Jutsus/EightGates/jutsu in usr.jutsus)
									jutsu.level ++
							if(src.name == "Dust Particle" ||src.name == "Spider" || src.name == "Deidara" || src.name == "Puppeteer" || src.name == "Sand" || src.name == "Paper Control" || src.name == "Jashin Religion" || src.name == "Kakuzu"||src.name == "Ice"||src.name=="Opening Gate"||src.name=="Rinnegan"||src.name=="Sharingan Copy")
								usr.sbought+=src.name
								if(src.name == "Sand")usr.Clan = "Sand"
								if(src.name == "Deidara")usr.Clan = "Deidara"
								if(src.name == "Puppeteer")usr.Clan = "Puppeteer"
								if(src.name == "Paper Control")usr.Clan = "Paper"
								if(src.name == "Jashin Religion")usr.Clan = "Jashin"
								if(src.name == "Kakuzu")usr.Clan = "Kakuzu"
								if(src.name == "Spider")usr.Clan = "Spider"
								if(src.name == "Ice")usr.Clan = "Ice"
								if(src.name == "Dust Particle")usr.Clan = "Dust Particle"
								if(src.name == "Opening Gate")
									usr.Clan = "Gates"
									var/obj/Jutsus/jutsu=new src.type
									usr.jutsus += jutsu
									usr.jutsus_learned += jutsu.type
									jutsu.owner=usr.ckey

								if(src.name == "Rinnegan")
									usr.Clan = "Rinnegan"
									var/obj/Jutsus/jutsu=new src.type
									usr.jutsus += jutsu
									usr.jutsus_learned += jutsu.type
									jutsu.owner=usr.ckey
								if(src.name == "Sharingan Copy")
									usr.Clan = "Implanted"
									var/obj/Jutsus/jutsu=new src.type
									usr.jutsus += jutsu
									usr.jutsus_learned += jutsu.type
									jutsu.owner=usr.ckey


							else
							/*	if(src.name=="Tsukuyomi"||src.name=="Amaterasu"||src.name=="Kamui"||src.name=="Susanoo"||src.name=="Eternal Mangekyou Sharingan")
									usr.UchihaJ++*/
								if(src.sharin<>0 && src.sharin<>1)
									usr.sbought+=src.name
									for(var/obj/Jutsus/Sharingan/SH in usr.jutsus)
										var/os = SH.icon_state
										SH.icon_state = src.icon_state
										SH.mouse_drag_pointer = src.mouse_drag_pointer
										SH.name = src.name
										if(usr.HotSlotSave["HotSlot1"]==os)
											for(var/obj/HotSlots/HotSlot1/H in usr.client.screen)
												var/obj/h=H
												h.overlays=0
												h.overlays+=src
												usr.HotSlotSave["HotSlot1"]="[src.icon_state]"
												usr.hotslot1=src.name
												h.HotSlotNumber("F1")
										if(usr.HotSlotSave["HotSlot2"]==os)
											for(var/obj/HotSlots/HotSlot2/H in usr.client.screen)
												var/obj/h=H
												h.overlays=0
												h.overlays+=src
												usr.HotSlotSave["HotSlot2"]="[src.icon_state]"
												usr.hotslot2=src.name
												h.HotSlotNumber("F2")
										if(usr.HotSlotSave["HotSlot3"]==os)
											for(var/obj/HotSlots/HotSlot3/H in usr.client.screen)
												var/obj/h=H
												h.overlays=0
												h.overlays+=src
												usr.HotSlotSave["HotSlot3"]="[src.icon_state]"
												usr.hotslot3=src.name
												h.HotSlotNumber("F3")
										if(usr.HotSlotSave["HotSlot4"]==os)
											for(var/obj/HotSlots/HotSlot4/H in usr.client.screen)
												var/obj/h=H
												h.overlays=0
												h.overlays+=src
												usr.HotSlotSave["HotSlot4"]="[src.icon_state]"
												usr.hotslot4=src.name
												h.HotSlotNumber("F4")
										if(usr.HotSlotSave["HotSlot5"]==os)
											for(var/obj/HotSlots/HotSlot5/H in usr.client.screen)
												var/obj/h=H
												h.overlays=0
												h.overlays+=src
												usr.HotSlotSave["HotSlot5"]="[src.icon_state]"
												usr.hotslot5=src.name
												h.HotSlotNumber("F5")
										if(usr.HotSlotSave["HotSlot6"]==os)
											for(var/obj/HotSlots/HotSlot6/H in usr.client.screen)
												var/obj/h=H
												h.overlays=0
												h.overlays+=src
												usr.HotSlotSave["HotSlot6"]="[src.icon_state]"
												usr.hotslot6=src.name
												h.HotSlotNumber("F6")
										if(usr.HotSlotSave["HotSlot7"]==os)
											for(var/obj/HotSlots/HotSlot7/H in usr.client.screen)
												var/obj/h=H
												h.overlays=0
												h.overlays+=src
												usr.HotSlotSave["HotSlot7"]="[src.icon_state]"
												usr.hotslot7=src.name
												h.HotSlotNumber("F7")
										if(usr.HotSlotSave["HotSlot8"]==os)
											for(var/obj/HotSlots/HotSlot8/H in usr.client.screen)
												var/obj/h=H
												h.overlays=0
												h.overlays+=src
												usr.HotSlotSave["HotSlot8"]="[src.icon_state]"
												usr.hotslot8=src.name
												h.HotSlotNumber("F8")
										if(usr.HotSlotSave["HotSlot9"]==os)
											for(var/obj/HotSlots/HotSlot9/H in usr.client.screen)
												var/obj/h=H
												h.overlays=0
												h.overlays+=src
												usr.HotSlotSave["HotSlot9"]="[src.icon_state]"
												usr.hotslot9=src.name
												h.HotSlotNumber("F9")
										if(usr.HotSlotSave["HotSlot10"]==os)
											for(var/obj/HotSlots/HotSlot10/H in usr.client.screen)
												var/obj/h=H
												h.overlays=0
												h.overlays+=src
												usr.HotSlotSave["HotSlot10"]="[src.icon_state]"
												usr.hotslot10=src.name
												h.HotSlotNumber("F10")
										SH.level ++
								else
									usr.sbought+=src.name
									var/obj/Jutsus/jutsu=new src.type
									usr.jutsus += jutsu
									usr.jutsus_learned += jutsu.type
									jutsu.owner=usr.ckey
									if(istype(jutsu, /obj/Jutsus/BClone))
										var/obj/Jutsus/BCloneD/D=new
										usr.skillpoints-=src.Sprice
										usr.jutsus += D
										usr.jutsus_learned += D.type
										D.owner=usr.ckey
							if(src.name <> "Dust Particle"&&src.name <> "Kakuzu"&&src.name <> "Ice" &&src.name <> "Spider" && src.name <> "Deidara" && src.name <> "Puppeteer" && src.name <> "Sand" && src.name <> "Paper Control")
								usr<<output("Successfully learned [src.name]. Check your Jutsus list for information on the seals.","ActionPanel.Output")
							usr.updateskills()

				else
					usr<<output("You do not meet the requirements for this technique.","ActionPanel.Output")
		MouseDrop(var/H)
			if(!src in usr.jutsus)
				return
			if(src.IsGate)
				usr << output("You may not put this technique on a hotslot.","ActionPanel.Output")
				return
			if(src.uses>=80)
				if(istype(H,/obj/HotSlots/HotSlot1))
					var/obj/h=H
					h.overlays=0
					h.overlays+=src
					usr.HotSlotSave["HotSlot1"]="[src.icon_state]"
					usr.hotslot1=src.name
					h.HotSlotNumber("F1")
				if(istype(H,/obj/HotSlots/HotSlot2))
					var/obj/h=H
					h.overlays=0
					h.overlays+=src
					usr.HotSlotSave["HotSlot2"]="[src.icon_state]"
					usr.hotslot2=src.name
					h.HotSlotNumber("F2")
				if(istype(H,/obj/HotSlots/HotSlot3))
					var/obj/h=H
					h.overlays=0
					h.overlays+=src
					usr.HotSlotSave["HotSlot3"]="[src.icon_state]"
					usr.hotslot3=src.name
					h.HotSlotNumber("F3")
				if(istype(H,/obj/HotSlots/HotSlot4))
					var/obj/h=H
					h.overlays=0
					h.overlays+=src
					usr.HotSlotSave["HotSlot4"]="[src.icon_state]"
					usr.hotslot4=src.name
					h.HotSlotNumber("F4")
				if(istype(H,/obj/HotSlots/HotSlot5))
					var/obj/h=H
					h.overlays=0
					h.overlays+=src
					usr.HotSlotSave["HotSlot5"]="[src.icon_state]"
					usr.hotslot5=src.name
					h.HotSlotNumber("F5")
				if(istype(H,/obj/HotSlots/HotSlot6))
					var/obj/h=H
					h.overlays=0
					h.overlays+=src
					usr.HotSlotSave["HotSlot6"]="[src.icon_state]"
					usr.hotslot6=src.name
					h.HotSlotNumber("F6")
				if(istype(H,/obj/HotSlots/HotSlot7))
					var/obj/h=H
					h.overlays=0
					h.overlays+=src
					usr.HotSlotSave["HotSlot7"]="[src.icon_state]"
					usr.hotslot7=src.name
					h.HotSlotNumber("F7")
				if(istype(H,/obj/HotSlots/HotSlot8))
					var/obj/h=H
					h.overlays=0
					h.overlays+=src
					usr.HotSlotSave["HotSlot8"]="[src.icon_state]"
					usr.hotslot8=src.name
					h.HotSlotNumber("F8")
				if(istype(H,/obj/HotSlots/HotSlot9))
					var/obj/h=H
					h.overlays=0
					h.overlays+=src
					usr.HotSlotSave["HotSlot9"]="[src.icon_state]"
					usr.hotslot9=src.name
					h.HotSlotNumber("F9")
				if(istype(H,/obj/HotSlots/HotSlot10))
					var/obj/h=H
					h.overlays=0
					h.overlays+=src
					usr.HotSlotSave["HotSlot10"]="[src.icon_state]"
					usr.hotslot10=src.name
					h.HotSlotNumber("F10")
			else
				usr<<output("<Font color=red>You need to use [src.name] [80-src.uses] more times([src.uses]).</Font>","ActionPanel.Output")



obj
	HSigns
		icon='HandSigns.dmi'
		dog
			icon_state = "dog"
			layer = 20
			screen_loc = "17,20"
		rat
			icon_state = "rat"
			layer = 20
			screen_loc = "17,20"
		rabbit
			icon_state = "rabbit"
			layer = 20
			screen_loc = "17,20"
		horse
			icon_state = "horse"
			layer = 20
			screen_loc = "17,20"
		ox
			icon_state = "ox"
			layer = 20
			screen_loc = "17,20"
		snake
			icon_state = "snake"
			layer = 20
			screen_loc = "17,20"
		monkey
			icon_state = "monkey"
			layer = 20
			screen_loc = "17,20"
		dragon
			icon_state = "dragon"
			layer = 20
			screen_loc = "17,20"
mob
	verb
		HandSealActivate()
			set hidden=1
			if(client.eye==locate(10,10,4)||client.eye==locate(60,10,4)||client.eye==locate(12,43,4)||client.eye==locate(55,43,4)||usr.client.eye==locate(10,75,4)) return
			src.HengeUndo()
			if(usr.SealCount>=1)
				view(usr)<<sound('active.wav',0,0)
				if(usr.first=="rat"&&usr.second=="dragon"&&usr.rat==1&&usr.dog==0&&usr.ox==0&&usr.dragon==1&&usr.monkey==0&&usr.snake==0&&usr.horse==0&&usr.rabbit==0)
					var/obj/Jutsus/SClone/J=new/obj/Jutsus/SClone
					if(J.type in usr.jutsus_learned)
						if(genintesters.Find(src)) SealsDoneGenin++
						usr.ShadowClone_Jutsu()
				if(usr.first=="rat"&&usr.second=="rat"&&usr.third=="snake"&&usr.rat==2&&usr.dog==0&&usr.ox==0&&usr.dragon==0&&usr.monkey==0&&usr.snake==1&&usr.horse==0&&usr.rabbit==0)
					var/obj/Jutsus/MizuClone/J=new/obj/Jutsus/MizuClone
					if(J.type in usr.jutsus_learned)
						if(genintesters.Find(src)) SealsDoneGenin++
						usr.MizuClone_Jutsu()
				if(usr.first=="rat"&&usr.second=="rat"&&usr.third=="ox"&&usr.rat==2&&usr.dog==0&&usr.ox==1&&usr.dragon==0&&usr.monkey==0&&usr.snake==0&&usr.horse==0&&usr.rabbit==0)
					var/obj/Jutsus/Camellia_Dance/J=new/obj/Jutsus/Camellia_Dance
					if(J.type in usr.jutsus_learned)
						if(genintesters.Find(src)) SealsDoneGenin++
						usr.Camellia_Dance()
				if(usr.first=="snake"&&usr.second=="dragon"&&usr.third=="snake"&&usr.rat==0&&usr.dog==0&&usr.ox==0&&usr.dragon==1&&usr.monkey==0&&usr.snake==2&&usr.horse==0&&usr.rabbit==0)
					var/obj/Jutsus/Insect_Clone/J=new/obj/Jutsus/Insect_Clone
					if(J.type in usr.jutsus_learned)
						if(genintesters.Find(src)) SealsDoneGenin++
						usr.InsectClone()
				if(usr.first=="snake"&&usr.second=="snake"&&usr.third=="dog"&&usr.rat==0&&usr.dog==1&&usr.ox==0&&usr.dragon==0&&usr.monkey==0&&usr.snake==2&&usr.horse==0&&usr.rabbit==0)
					var/obj/Jutsus/Eight_Trigrams_Mountain_Crusher/J=new/obj/Jutsus/Eight_Trigrams_Mountain_Crusher
					if(J.type in usr.jutsus_learned)
						if(genintesters.Find(src)) SealsDoneGenin++
						usr.Eight_Trigrams_Mountain_Crusher()
				if(usr.first=="dog"&&usr.second=="ox"&&usr.third=="ox"&&usr.fourth=="dog"&&usr.rat==0&&usr.dog==2&&usr.ox==2&&usr.dragon==0&&usr.monkey==0&&usr.snake==0&&usr.horse==0&&usr.rabbit==0)
					var/obj/Jutsus/Sand_Funeral/J=new/obj/Jutsus/Sand_Funeral
					if(J.type in usr.jutsus_learned)
						if(genintesters.Find(src)) SealsDoneGenin++
						usr.Sand_Funeral()
				if(usr.first=="dog"&&usr.second=="ox"&&usr.third=="dog"&&usr.fourth=="ox"&&usr.rat==0&&usr.dog==2&&usr.ox==2&&usr.dragon==0&&usr.monkey==0&&usr.snake==0&&usr.horse==0&&usr.rabbit==0)
					var/obj/Jutsus/Sand_Shield/J=new/obj/Jutsus/Sand_Shield
					if(J.type in usr.jutsus_learned)
						if(genintesters.Find(src)) SealsDoneGenin++
						usr.Sand_Shield()
				if(usr.first=="dog"&&usr.second=="rat"&&usr.third=="rat"&&usr.fourth=="dog"&&usr.fifth=="dog"&&usr.sixth=="rat"&&usr.seventh=="dog"&&usr.eighth=="rat"&&usr.rat==4&&usr.dog==4&&usr.ox==0&&usr.dragon==0&&usr.monkey==0&&usr.snake==0&&usr.horse==0&&usr.rabbit==0)
					var/obj/Jutsus/Fire_Dragon_Projectile/J=new/obj/Jutsus/Fire_Dragon_Projectile
					if(J.type in usr.jutsus_learned)
						if(genintesters.Find(src)) SealsDoneGenin++
						usr.Fire_Dragon_Projectile()
				if(usr.first=="dog"&&usr.second=="rat"&&usr.third=="rat"&&usr.fourth=="dog"&&usr.fifth=="dog"&&usr.sixth=="rat"&&usr.seventh=="dog"&&usr.eighth=="rat"&&usr.nineth=="dragon"&&usr.tenth=="dragon"&&usr.rat==4&&usr.dog==4&&usr.ox==0&&usr.dragon==2&&usr.monkey==0&&usr.snake==0&&usr.horse==0&&usr.rabbit==0)
					var/obj/Jutsus/Water_Dragon_Projectile/J=new/obj/Jutsus/Water_Dragon_Projectile
					if(J.type in usr.jutsus_learned)
						if(genintesters.Find(src)) SealsDoneGenin++
						usr.Water_Dragon_Projectile()
				if(usr.first=="dog"&&usr.second=="rat"&&usr.third=="rat"&&usr.fourth=="dog"&&usr.fifth=="dog"&&usr.sixth=="rat"&&usr.seventh=="dog"&&usr.rat==3&&usr.dog==4&&usr.ox==0&&usr.dragon==0&&usr.monkey==0&&usr.snake==0&&usr.horse==0&&usr.rabbit==0)
					var/obj/Jutsus/Mud_Dragon_Projectile/J=new/obj/Jutsus/Mud_Dragon_Projectile
					if(J.type in usr.jutsus_learned)
						if(genintesters.Find(src)) SealsDoneGenin++
						usr.Mud_Dragon_Projectile()
				if(usr.first=="snake"&&usr.second=="dragon"&&usr.third=="snake"&&usr.fourth=="rat"&&usr.rat==1&&usr.dog==0&&usr.ox==0&&usr.dragon==1&&usr.monkey==0&&usr.snake==2&&usr.horse==0&&usr.rabbit==0)
					var/obj/Jutsus/Chakra_Leech/J=new/obj/Jutsus/Chakra_Leech
					if(J.type in usr.jutsus_learned)
						if(genintesters.Find(src)) SealsDoneGenin++
						usr.Chakra_Leech()
				if(usr.first=="horse"&&usr.second=="horse"&&usr.third=="horse"&&usr.rat==0&&usr.dog==0&&usr.ox==0&&usr.dragon==0&&usr.monkey==0&&usr.snake==0&&usr.horse==3&&usr.rabbit==0)
					var/obj/Jutsus/Ones_Own_Life_Reincarnation/J=new/obj/Jutsus/Ones_Own_Life_Reincarnation
					if(J.type in usr.jutsus_learned)
						if(genintesters.Find(src)) SealsDoneGenin++
						usr.Ones_Own_Life_Reincarnation()
				if(usr.first=="ox"&&usr.second=="rat"&&usr.third=="ox"&&usr.rat==1&&usr.dog==0&&usr.ox==2&&usr.dragon==0&&usr.monkey==0&&usr.snake==0&&usr.horse==0&&usr.rabbit==0)
					var/obj/Jutsus/Shikigami_Spear/J=new/obj/Jutsus/Shikigami_Spear
					if(J.type in usr.jutsus_learned)
						if(genintesters.Find(src)) SealsDoneGenin++
						usr.Shikigami_Spear()
				if(usr.first=="dragon"&&usr.second=="dragon"&&usr.third=="snake"&&usr.rat==0&&usr.dog==0&&usr.ox==0&&usr.dragon==2&&usr.monkey==0&&usr.snake==1&&usr.horse==0&&usr.rabbit==0)
					var/obj/Jutsus/Stealth_Bug/J=new/obj/Jutsus/Stealth_Bug
					if(J.type in usr.jutsus_learned)
						if(genintesters.Find(src)) SealsDoneGenin++
						usr.Stealth_Bug()
				if(usr.first=="ox"&&usr.second=="rat"&&usr.third=="rat"&&usr.fourth=="rat"&&usr.rat==3&&usr.dog==0&&usr.ox==1&&usr.dragon==0&&usr.monkey==0&&usr.snake==0&&usr.horse==0&&usr.rabbit==0)
					var/obj/Jutsus/Shikigami_Dance/J=new/obj/Jutsus/Shikigami_Dance
					if(J.type in usr.jutsus_learned)
						if(genintesters.Find(src)) SealsDoneGenin++
						usr.Shikigami_Dance()
				if(usr.first=="dog"&&usr.second=="ox"&&usr.third=="dragon"&&usr.rat==0&&usr.dog==1&&usr.ox==1&&usr.dragon==1&&usr.monkey==0&&usr.snake==0&&usr.horse==0&&usr.rabbit==0)
					var/obj/Jutsus/Bringer_of_Darkness_Technique/J=new/obj/Jutsus/Bringer_of_Darkness_Technique
					if(J.type in usr.jutsus_learned)
						if(genintesters.Find(src)) SealsDoneGenin++
						usr.Bringer_of_Darkness_Technique()
				if(usr.first=="snake"&&usr.second=="dragon"&&usr.third=="dragon"&&usr.rat==0&&usr.dog==0&&usr.ox==0&&usr.dragon==2&&usr.monkey==0&&usr.snake==1&&usr.horse==0&&usr.rabbit==0)
					var/obj/Jutsus/Destruction_Bug_Swarm/J=new/obj/Jutsus/Destruction_Bug_Swarm
					if(J.type in usr.jutsus_learned)
						if(genintesters.Find(src)) SealsDoneGenin++
						usr.Destruction_Bug_Swarm()
				if(usr.first=="dog"&&usr.second=="dog"&&usr.third=="ox"&&usr.fourth=="dog"&&usr.rat==0&&usr.dog==3&&usr.ox==1&&usr.dragon==0&&usr.monkey==0&&usr.snake==0&&usr.horse==0&&usr.rabbit==0)
					var/obj/Jutsus/Shukakku_Spear/J=new/obj/Jutsus/Shukakku_Spear
					if(J.type in usr.jutsus_learned)
						if(genintesters.Find(src)) SealsDoneGenin++
						usr.Shukakku_Spear()
				if(usr.first=="dog"&&usr.second=="dog"&&usr.third=="ox"&&usr.fourth=="ox"&&usr.rat==0&&usr.dog==2&&usr.ox==2&&usr.dragon==0&&usr.monkey==0&&usr.snake==0&&usr.horse==0&&usr.rabbit==0)
					var/obj/Jutsus/Desert_Coffin/J=new/obj/Jutsus/Desert_Coffin
					if(J.type in usr.jutsus_learned)
						if(genintesters.Find(src)) SealsDoneGenin++
						usr.Desert_Coffin()
				if(usr.first=="dog"&&usr.second=="dog"&&usr.third=="ox"&&usr.rat==0&&usr.dog==2&&usr.ox==1&&usr.dragon==0&&usr.monkey==0&&usr.snake==0&&usr.horse==0&&usr.rabbit==0)
					var/obj/Jutsus/Sand_Shuriken/J=new/obj/Jutsus/Sand_Shuriken
					if(J.type in usr.jutsus_learned)
						if(genintesters.Find(src)) SealsDoneGenin++
						usr.Sand_Shuriken()
				if(usr.first=="dragon"&&usr.second=="snake"&&usr.third=="snake"&&usr.fourth=="dragon"&&usr.rat==0&&usr.dog==0&&usr.ox==0&&usr.dragon==2&&usr.monkey==0&&usr.snake==2&&usr.horse==0&&usr.rabbit==0)
					var/obj/Jutsus/Insect_Cocoon/J=new/obj/Jutsus/Insect_Cocoon
					if(J.type in usr.jutsus_learned)
						if(genintesters.Find(src)) SealsDoneGenin++
						usr.Insect_Cocoon()
				if(usr.first=="rabbit"&&usr.second=="rabbit"&&usr.third=="rabbit"&&usr.rat==0&&usr.dog==0&&usr.ox==0&&usr.dragon==0&&usr.monkey==0&&usr.snake==0&&usr.horse==0&&usr.rabbit==3)
					var/obj/Jutsus/Earth_Disruption/J=new/obj/Jutsus/Earth_Disruption
					if(J.type in usr.jutsus_learned)
						if(genintesters.Find(src)) SealsDoneGenin++
						usr.Earth_Disruption()
				if(usr.first=="rabbit"&&usr.second=="rabbit"&&usr.third=="monkey"&&usr.rat==0&&usr.dog==0&&usr.ox==0&&usr.dragon==0&&usr.monkey==1&&usr.snake==0&&usr.horse==0&&usr.rabbit==2)
					var/obj/Jutsus/Earth_Release_Mud_River/J=new/obj/Jutsus/Earth_Release_Mud_River
					if(J.type in usr.jutsus_learned)
						if(genintesters.Find(src)) SealsDoneGenin++
						usr.Earth_Release_Mud_River()
				if(usr.first=="ox"&&usr.second=="snake"&&usr.third=="rat"&&usr.fourth=="snake"&&usr.rat==1&&usr.dog==0&&usr.ox==1&&usr.dragon==0&&usr.monkey==0&&usr.snake==2&&usr.horse==0&&usr.rabbit==0)
					var/obj/Jutsus/WaterPrison/J=new/obj/Jutsus/WaterPrison
					if(J.type in usr.jutsus_learned)
						if(genintesters.Find(src)) SealsDoneGenin++
						usr.WaterPrison()
				if(usr.first=="monkey"&&usr.second=="snake"&&usr.third=="ox"&&usr.rat==0&&usr.dog==0&&usr.ox==1&&usr.dragon==0&&usr.monkey==1&&usr.snake==1&&usr.horse==0&&usr.rabbit==0)
					var/obj/Jutsus/Shadow_Extension/J=new/obj/Jutsus/Shadow_Extension
					if(J.type in usr.jutsus_learned)
						if(genintesters.Find(src)) SealsDoneGenin++
						usr.Shadow_Extension()
				if(usr.first=="rabbit"&&usr.second=="snake"&&usr.third=="monkey"&&usr.rat==0&&usr.dog==0&&usr.ox==0&&usr.dragon==0&&usr.monkey==1&&usr.snake==1&&usr.horse==0&&usr.rabbit==1)
					var/obj/Jutsus/Wind_Shield/J=new/obj/Jutsus/Wind_Shield
					if(J.type in usr.jutsus_learned)
						if(genintesters.Find(src)) SealsDoneGenin++
						usr.Wind_Shield()
				if(usr.first=="ox"&&usr.second=="snake"&&usr.third=="rat"&&usr.fourth=="rabbit"&&usr.fifth=="dragon"&&usr.rat==1&&usr.dog==0&&usr.ox==1&&usr.dragon==1&&usr.monkey==0&&usr.snake==1&&usr.horse==0&&usr.rabbit==1)
					var/obj/Jutsus/WaterShark/J=new/obj/Jutsus/WaterShark
					if(J.type in usr.jutsus_learned)
						if(genintesters.Find(src)) SealsDoneGenin++
						usr.WaterShark()
				if(usr.first=="ox"&&usr.second=="snake"&&usr.third=="rabbit"&&usr.fourth=="dog"&&usr.rat==0&&usr.dog==1&&usr.ox==1&&usr.dragon==0&&usr.monkey==0&&usr.snake==1&&usr.horse==0&&usr.rabbit==1)
					var/obj/Jutsus/TreeBinding/J=new/obj/Jutsus/TreeBinding
					if(J.type in usr.jutsus_learned)
						if(genintesters.Find(src)) SealsDoneGenin++
						usr.TreeBinding()
				if(usr.first=="dog"&&usr.second=="rabbit"&&usr.third=="dog"&&usr.fourth=="snake"&&usr.rat==0&&usr.dog==2&&usr.ox==0&&usr.dragon==0&&usr.monkey==0&&usr.snake==1&&usr.horse==0&&usr.rabbit==1)
					var/obj/Jutsus/Temple_Of_Nirvana/J=new/obj/Jutsus/Temple_Of_Nirvana
					if(J.type in usr.jutsus_learned)
						if(genintesters.Find(src)) SealsDoneGenin++
						usr.Temple_Of_Nirvana()
				if(usr.first=="rabbit"&&usr.second=="rabbit"&&usr.rat==0&&usr.dog==0&&usr.ox==0&&usr.dragon==0&&usr.monkey==0&&usr.snake==0&&usr.horse==0&&usr.rabbit==2)
					var/obj/Jutsus/Earth_Style_Dark_Swamp/J=new/obj/Jutsus/Earth_Style_Dark_Swamp
					if(J.type in usr.jutsus_learned)
						if(genintesters.Find(src)) SealsDoneGenin++
						usr.Earth_Style_Dark_Swamp()
				if(usr.first=="snake"&&usr.second=="rabbit"&&usr.third=="dog"&&usr.rat==0&&usr.dog==1&&usr.ox==0&&usr.dragon==0&&usr.monkey==0&&usr.snake==1&&usr.horse==0&&usr.rabbit==1)
					var/obj/Jutsus/Jinrai/J=new/obj/Jutsus/Jinrai
					if(J.type in usr.jutsus_learned)
						if(genintesters.Find(src)) SealsDoneGenin++
						usr.Chidori_Jinrai()
				if(usr.first=="dragon"&&usr.second=="snake"&&usr.third=="snake"&&usr.rat==0&&usr.dog==0&&usr.ox==0&&usr.dragon==1&&usr.monkey==0&&usr.snake==2&&usr.horse==0&&usr.rabbit==0)
					var/obj/Jutsus/Bug_Neurotoxin/J=new/obj/Jutsus/Bug_Neurotoxin
					if(J.type in usr.jutsus_learned)
						if(genintesters.Find(src)) SealsDoneGenin++
						usr.Bug_Neurotoxin()
				if(usr.first=="dragon"&&usr.second=="snake"&&usr.rat==0&&usr.dog==0&&usr.ox==0&&usr.dragon==1&&usr.monkey==0&&usr.snake==1&&usr.horse==0&&usr.rabbit==0)
					var/obj/Jutsus/Hunter_Scarabs/J=new/obj/Jutsus/Hunter_Scarabs
					if(J.type in usr.jutsus_learned)
						if(genintesters.Find(src)) SealsDoneGenin++
						usr.Hunter_Scarabs()
				if(usr.first=="dragon"&&usr.second=="rabbit"&&usr.third=="dragon"&&usr.rat==0&&usr.dog==0&&usr.ox==0&&usr.dragon==2&&usr.monkey==0&&usr.snake==0&&usr.horse==0&&usr.rabbit==1)
					var/obj/Jutsus/C1_Birds/J=new/obj/Jutsus/C1_Birds
					if(J.type in usr.jutsus_learned)
						if(genintesters.Find(src)) SealsDoneGenin++
						usr.ClayBirds()//signs="<font color=green>Dragon,Dog,Dragon</font><br>(macro(5,E,5))"
				if(usr.first=="dragon"&&usr.second=="dog"&&usr.third=="dragon"&&usr.rat==0&&usr.dog==1&&usr.ox==0&&usr.dragon==2&&usr.monkey==0&&usr.snake==0&&usr.horse==0&&usr.rabbit==0)
					var/obj/Jutsus/C1_Spiders/J=new/obj/Jutsus/C1_Spiders
					if(J.type in usr.jutsus_learned)
						if(genintesters.Find(src)) SealsDoneGenin++
						usr.ClaySpiders()
				if(usr.first=="dragon"&&usr.second=="dragon"&&usr.third=="dragon"&&usr.fourth=="dragon"&&usr.fifth=="dragon"&&usr.rat==0&&usr.dog==0&&usr.ox==0&&usr.dragon==5&&usr.monkey==0&&usr.snake==0&&usr.horse==0&&usr.rabbit==0)
					var/obj/Jutsus/C2/J=new/obj/Jutsus/C2
					if(J.type in usr.jutsus_learned)
						if(genintesters.Find(src)) SealsDoneGenin++
						usr.C2()
				if(usr.first=="dog"&&usr.second=="ox"&&usr.third=="dragon"&&usr.fourth=="ox"&&usr.fifth=="dog"&&usr.rat==0&&usr.dog==2&&usr.ox==2&&usr.dragon==1&&usr.monkey==0&&usr.snake==0&&usr.horse==0&&usr.rabbit==0)
					var/obj/Jutsus/Susanoo/J=new/obj/Jutsus/Susanoo
					if(J.type in usr.jutsus_learned)
						if(genintesters.Find(src)) SealsDoneGenin++
						usr.Susanoo()
				if(usr.first=="dragon"&&usr.second=="dragon"&&usr.third=="dragon"&&usr.fourth=="dragon"&&usr.fifth=="dog"&&usr.rat==0&&usr.dog==1&&usr.ox==0&&usr.dragon==4&&usr.monkey==0&&usr.snake==0&&usr.horse==0&&usr.rabbit==0)
					var/obj/Jutsus/C3/J=new/obj/Jutsus/C3
					if(J.type in usr.jutsus_learned)
						if(genintesters.Find(src)) SealsDoneGenin++
						usr.C3()
				if(usr.first=="dragon"&&usr.second=="horse"&&usr.third=="dragon"&&usr.rat==0&&usr.dog==0&&usr.ox==0&&usr.dragon==2&&usr.monkey==0&&usr.snake==0&&usr.horse==1&&usr.rabbit==0)
					var/obj/Jutsus/Blade_Manipulation_Jutsu/J=new/obj/Jutsus/Blade_Manipulation_Jutsu
					if(J.type in usr.jutsus_learned)
						if(genintesters.Find(src)) SealsDoneGenin++
						usr.Blade_Manipulation_Jutsu()
				if(usr.first=="ox"&&usr.second=="rabbit"&&usr.third=="snake"&&usr.fourth=="dog"&&usr.fifth=="dog"&&usr.sixth=="rabbit"&&usr.rat==0&&usr.dog==2&&usr.ox==1&&usr.dragon==0&&usr.monkey==0&&usr.snake==1&&usr.horse==0&&usr.rabbit==2)
					var/obj/Jutsus/Kirin/J=new/obj/Jutsus/Kirin
					if(J.type in usr.jutsus_learned)
						if(genintesters.Find(src)) SealsDoneGenin++
						usr.Kirin()
				if(usr.first=="ox"&&usr.second=="rabbit"&&usr.rat==0&&usr.dog==0&&usr.ox==1&&usr.dragon==0&&usr.monkey==0&&usr.snake==0&&usr.horse==0&&usr.rabbit==1)
					var/obj/Jutsus/Chidori_Needles/J=new/obj/Jutsus/Chidori_Needles
					if(J.type in usr.jutsus_learned)
						if(genintesters.Find(src)) SealsDoneGenin++
						usr.Chidori_Needles()
				if(usr.first=="rabbit"&&usr.second=="rabbit"&&usr.third=="ox"&&usr.rat==0&&usr.dog==0&&usr.ox==1&&usr.dragon==0&&usr.monkey==0&&usr.snake==0&&usr.horse==0&&usr.rabbit==2)
					var/obj/Jutsus/Rasengan/J=new/obj/Jutsus/Rasengan
					if(J.type in usr.jutsus_learned)
						if(genintesters.Find(src)) SealsDoneGenin++
						usr.Rasengan()
				if(usr.first=="horse"&&usr.second=="horse"&&usr.third=="rabbit"&&usr.rat==0&&usr.dog==0&&usr.ox==0&&usr.dragon==0&&usr.monkey==0&&usr.snake==0&&usr.horse==2&&usr.rabbit==1)
					var/obj/Jutsus/Cherry_Blossom_Impact/J=new/obj/Jutsus/Cherry_Blossom_Impact
					if(J.type in usr.jutsus_learned)
						if(genintesters.Find(src)) SealsDoneGenin++
						usr.Cherry_Blossom_Impact()
				if(usr.first=="rat"&&usr.second=="rat"&&usr.third=="rat"&&usr.rat==3&&usr.dog==0&&usr.ox==0&&usr.dragon==0&&usr.monkey==0&&usr.snake==0&&usr.horse==0&&usr.rabbit==0)
					var/obj/Jutsus/Bone_Drill/J=new/obj/Jutsus/Bone_Drill
					if(J.type in usr.jutsus_learned)
						if(genintesters.Find(src)) SealsDoneGenin++
						usr.Bone_Drill()
				if(usr.first=="rabbit"&&usr.second=="snake"&&usr.third=="rabbit"&&usr.rat==0&&usr.dog==0&&usr.ox==0&&usr.dragon==0&&usr.monkey==0&&usr.snake==1&&usr.horse==0&&usr.rabbit==2)
					var/obj/Jutsus/Blade_of_Wind/J=new/obj/Jutsus/Blade_of_Wind
					if(J.type in usr.jutsus_learned)
						if(genintesters.Find(src)) SealsDoneGenin++
						usr.Blade_of_Wind()
				if(usr.first=="rabbit"&&usr.second=="rabbit"&&usr.third=="ox"&&usr.fourth=="ox"&&usr.fifth=="ox"&&usr.sixth=="ox"&&usr.rat==0&&usr.dog==0&&usr.ox==4&&usr.dragon==0&&usr.monkey==0&&usr.snake==0&&usr.horse==0&&usr.rabbit==2)
					var/obj/Jutsus/Rasenshuriken/J=new/obj/Jutsus/Rasenshuriken
					if(J.type in usr.jutsus_learned)
						if(genintesters.Find(src)) SealsDoneGenin++
						usr.Rasenshuriken()
				if(usr.first=="snake"&&usr.second=="rabbit"&&usr.third=="ox"&&usr.rat==0&&usr.dog==0&&usr.ox==1&&usr.dragon==0&&usr.monkey==0&&usr.snake==1&&usr.horse==0&&usr.rabbit==1)
					var/obj/Jutsus/Chidori/J=new/obj/Jutsus/Chidori
					if(J.type in usr.jutsus_learned)
						if(genintesters.Find(src)) SealsDoneGenin++
						usr.Chidori()
				if(usr.first=="snake"&&usr.second=="ox"&&usr.third=="ox"&&usr.rat==0&&usr.dog==0&&usr.ox==2&&usr.dragon==0&&usr.monkey==0&&usr.snake==1&&usr.horse==0&&usr.rabbit==0)
					var/obj/Jutsus/Raikiri/J=new/obj/Jutsus/Raikiri
					if(J.type in usr.jutsus_learned)
						if(genintesters.Find(src)) SealsDoneGenin++
						usr.Raikiri()
				if(usr.first=="ox"&&usr.second=="snake"&&usr.third=="rabbit"&&usr.fourth=="ox"&&usr.rat==0&&usr.dog==0&&usr.ox==2&&usr.dragon==0&&usr.monkey==0&&usr.snake==1&&usr.horse==0&&usr.rabbit==1)
					var/obj/Jutsus/Sickle_Weasel_Technique/J=new/obj/Jutsus/Sickle_Weasel_Technique
					if(J.type in usr.jutsus_learned)
						if(genintesters.Find(src)) SealsDoneGenin++
						usr.Sickle_Weasel_Technique()
				if(usr.first=="rat"&&usr.second=="dragon"&&usr.third=="dog"&&usr.fourth=="monkey"&&usr.fifth=="monkey"&&usr.rat==1&&usr.dog==1&&usr.ox==0&&usr.dragon==1&&usr.monkey==2&&usr.snake==0&&usr.horse==0&&usr.rabbit==0)
					var/obj/Jutsus/MSClone/J=new/obj/Jutsus/MSClone
					if(J.type in usr.jutsus_learned)
						if(genintesters.Find(src)) SealsDoneGenin++
						usr.MultipleShadowClone_Jutsu()
				if(usr.first=="rat"&&usr.second=="dragon"&&usr.third=="dog"&&usr.fourth=="monkey"&&usr.rat==1&&usr.dog==1&&usr.ox==0&&usr.dragon==1&&usr.monkey==1&&usr.snake==0&&usr.horse==0&&usr.rabbit==0)
					var/obj/Jutsus/Crow_Clone/J=new/obj/Jutsus/Crow_Clone
					if(J.type in usr.jutsus_learned)
						if(genintesters.Find(src)) SealsDoneGenin++
						usr.Crow_Clone()
				if(usr.first=="rabbit"&&usr.second=="dog"&&usr.third=="dog"&&usr.fourth=="ox"&&usr.fifth=="rabbit"&&usr.rat==0&&usr.dog==2&&usr.ox==1&&usr.dragon==0&&usr.monkey==0&&usr.snake==0&&usr.horse==0&&usr.rabbit==2)
					var/obj/Jutsus/Demonic_Ice_Mirrors/J=new/obj/Jutsus/Demonic_Ice_Mirrors
					if(J.type in usr.jutsus_learned)
						if(genintesters.Find(src)) SealsDoneGenin++
						usr.Demonic_Ice_Mirrors()
				if(usr.first=="rabbit"&&usr.second=="dog"&&usr.third=="snake"&&usr.rat==0&&usr.dog==1&&usr.ox==0&&usr.dragon==0&&usr.monkey==0&&usr.snake==1&&usr.horse==0&&usr.rabbit==1)
					var/obj/Jutsus/Water_Release_Exploding_Water_Colliding_Wave/J=new/obj/Jutsus/Water_Release_Exploding_Water_Colliding_Wave
					if(J.type in usr.jutsus_learned)
						if(genintesters.Find(src)) SealsDoneGenin++
						usr.Water_Release_Exploding_Water_Colliding_Wave()
				if(usr.first=="horse"&&usr.second=="horse"&&usr.third=="snake"&&usr.rat==0&&usr.dog==0&&usr.ox==0&&usr.dragon==0&&usr.monkey==0&&usr.snake==1&&usr.horse==2&&usr.rabbit==0)
					var/obj/Jutsus/Body_Pathway_Derangement/J=new/obj/Jutsus/Body_Pathway_Derangement
					if(J.type in usr.jutsus_learned)
						if(genintesters.Find(src)) SealsDoneGenin++
						usr.Body_Pathway_Derangement()
				if(usr.first=="dragon"&&usr.second=="horse"&&usr.third=="snake"&&usr.rat==0&&usr.dog==0&&usr.ox==0&&usr.dragon==1&&usr.monkey==0&&usr.snake==1&&usr.horse==1&&usr.rabbit==0)
					var/obj/Jutsus/Poison_Mist/J=new/obj/Jutsus/Poison_Mist
					if(J.type in usr.jutsus_learned)
						if(genintesters.Find(src)) SealsDoneGenin++
						usr.Poison_Mist()
				if(usr.first=="dog"&&usr.second=="rat"&&usr.third=="dog"&&usr.fourth=="rabbit"&&usr.fifth=="dog"&&usr.rat==1&&usr.dog==3&&usr.ox==0&&usr.dragon==0&&usr.monkey==0&&usr.snake==0&&usr.horse==0&&usr.rabbit==1)
					var/obj/Jutsus/Fire_Release_Ash_Pile_Burning/J=new/obj/Jutsus/Fire_Release_Ash_Pile_Burning
					if(J.type in usr.jutsus_learned)
						if(genintesters.Find(src)) SealsDoneGenin++
						usr.Fire_Release_Ash_Pile_Burning()
				if(usr.first=="snake"&&usr.second=="rat"&&usr.third=="snake"&&usr.fourth=="dragon"&&usr.rat==1&&usr.dog==0&&usr.ox==0&&usr.dragon==1&&usr.monkey==0&&usr.snake==2&&usr.horse==0&&usr.rabbit==0)
					var/obj/Jutsus/Eight_Trigrams_Palm_Heavenly_Spin/J=new/obj/Jutsus/Eight_Trigrams_Palm_Heavenly_Spin
					if(J.type in usr.jutsus_learned)
						if(genintesters.Find(src)) SealsDoneGenin++
						usr.Kaiten()
				if(usr.first=="snake"&&usr.second=="rat"&&usr.rat==1&&usr.dog==0&&usr.ox==0&&usr.dragon==0&&usr.monkey==0&&usr.snake==1&&usr.horse==0&&usr.rabbit==0)
					var/obj/Jutsus/Eight_Trigrams_Empty_Palm/J=new/obj/Jutsus/Eight_Trigrams_Empty_Palm
					if(J.type in usr.jutsus_learned)
						if(genintesters.Find(src)) SealsDoneGenin++
						usr.Eight_Trigrams_Empty_Palm()
				if(usr.first=="rabbit"&&usr.second=="dog"&&usr.third=="rabbit"&&usr.rat==0&&usr.dog==1&&usr.ox==0&&usr.dragon==0&&usr.monkey==0&&usr.snake==0&&usr.horse==0&&usr.rabbit==2)
					var/obj/Jutsus/Sensatsu_Suishou/J=new/obj/Jutsus/Sensatsu_Suishou
					if(J.type in usr.jutsus_learned)
						if(genintesters.Find(src)) SealsDoneGenin++
						usr.Sensatsu_Suisho()
				if(usr.first=="snake"&&usr.rat==0&&usr.dog==0&&usr.ox==0&&usr.dragon==0&&usr.monkey==0&&usr.snake==1&&usr.horse==0&&usr.rabbit==0)
					var/obj/Jutsus/Byakugan/J=new/obj/Jutsus/Byakugan
					if(J.type in usr.jutsus_learned)
						if(genintesters.Find(src)) SealsDoneGenin++
						usr.Byakugan()
				if(usr.first=="rat"&&usr.rat==1&&usr.dog==0&&usr.ox==0&&usr.dragon==0&&usr.monkey==0&&usr.snake==0&&usr.horse==0&&usr.rabbit==0)
					var/obj/Jutsus/BClone/J=new/obj/Jutsus/BClone
					if(J.type in usr.jutsus_learned)
						if(genintesters.Find(src)) SealsDoneGenin++
						usr.Clone_Jutsu()
				if(usr.first=="snake"&&usr.second=="rat"&&usr.third=="dragon"&&usr.fourth=="rat"&&usr.fifth=="dragon"&&usr.rat==2&&usr.dog==0&&usr.ox==0&&usr.dragon==2&&usr.monkey==0&&usr.snake==1&&usr.horse==0&&usr.rabbit==0)
					var/obj/Jutsus/Eight_Trigrams_64_Palms/J=new/obj/Jutsus/Eight_Trigrams_64_Palms
					if(J.type in usr.jutsus_learned)
						if(genintesters.Find(src)) SealsDoneGenin++
						usr.Eight_Trigrams_64_Palms()
				if(usr.first=="snake"&&usr.second=="rat"&&usr.third=="dragon"&&usr.fourth=="rat"&&usr.fifth=="dragon"&&usr.sixth=="dragon"&&usr.rat==2&&usr.dog==0&&usr.ox==0&&usr.dragon==3&&usr.monkey==0&&usr.snake==1&&usr.horse==0&&usr.rabbit==0)
					var/obj/Jutsus/Eight_Gates_Assault/J=new/obj/Jutsus/Eight_Gates_Assault
					if(J.type in usr.jutsus_learned)
						if(genintesters.Find(src)) SealsDoneGenin++
						usr.Eight_Gates_Assault()
			//	if(usr.first=="dragon"&&usr.rat==0&&usr.dog==0&&usr.ox==0&&usr.dragon==1&&usr.monkey==0&&usr.snake==0&&usr.horse==0&&usr.rabbit==0)
			//		var/obj/Jutsus/Body_Flicker/J=new/obj/Jutsus/Body_Flicker
			//		if(J.type in usr.jutsus_learned)
			//			if(genintesters.Find(src)) SealsDoneGenin++
			//			usr.Shunshin()
				if(usr.first=="dog"&&usr.second=="rat"&&usr.third=="rat"&&usr.fourth=="rat"&&usr.rat==3&&usr.dog==1&&usr.ox==0&&usr.dragon==0&&usr.monkey==0&&usr.snake==0&&usr.horse==0&&usr.rabbit==00)
					var/obj/Jutsus/Tree_Summoning/J=new/obj/Jutsus/Tree_Summoning
					if(J.type in usr.jutsus_learned)
						if(genintesters.Find(src)) SealsDoneGenin++
						usr.Tree_Summoning()
				if(usr.first=="dog"&&usr.second=="snake"&&usr.third=="rat"&&usr.rat==1&&usr.dog==1&&usr.ox==0&&usr.dragon==0&&usr.monkey==0&&usr.snake==1&&usr.horse==0&&usr.rabbit==0)
					var/obj/Jutsus/Heal/J=new/obj/Jutsus/Heal
					if(J.type in usr.jutsus_learned)
						if(genintesters.Find(src)) SealsDoneGenin++
						usr.Heal()
				if(usr.first=="rabbit"&&usr.second=="snake"&&usr.third=="snake"&&usr.fourth=="dog"&&usr.fifth=="rat"&&usr.rat==1&&usr.dog==1&&usr.ox==0&&usr.dragon==0&&usr.monkey==0&&usr.snake==2&&usr.horse==0&&usr.rabbit==1)
					var/obj/Jutsus/Earth_Release_Earth_Cage/J=new/obj/Jutsus/Earth_Release_Earth_Cage
					if(J.type in usr.jutsus_learned)
						if(genintesters.Find(src)) SealsDoneGenin++
						usr.Earth_Release_Earth_Cage()//signs="<font color=green>Rabbit,Snake,Snake,Dog,Rat</font><br>(macro(1,2,2,E,Q))"
				if(usr.first=="rat"&&usr.second=="ox"&&usr.rat==1&&usr.dog==0&&usr.ox==1&&usr.dragon==0&&usr.monkey==0&&usr.snake==0&&usr.horse==0&&usr.rabbit==0)
					var/obj/Jutsus/BCloneD/J=new/obj/Jutsus/BCloneD
					if(J.type in usr.jutsus_learned)
						if(genintesters.Find(src)) SealsDoneGenin++
						usr.Clone_Jutsu_Destroy()
				if(usr.first=="dog"&&usr.rat==0&&usr.dog==1&&usr.ox==0&&usr.dragon==0&&usr.monkey==0&&usr.snake==0&&usr.horse==0&&usr.rabbit==0)
					var/obj/Jutsus/BodyReplace/J=new/obj/Jutsus/BodyReplace
					if(J.type in usr.jutsus_learned)
						if(genintesters.Find(src)) SealsDoneGenin++
						usr.Body_Replacement_Technique()
				if(usr.first=="dog"&&usr.second=="rat"&&usr.rat==1&&usr.dog==1&&usr.ox==0&&usr.dragon==0&&usr.monkey==0&&usr.snake==0&&usr.horse==0&&usr.rabbit==0)
					var/obj/Jutsus/Transformation/J=new/obj/Jutsus/Transformation
					if(J.type in usr.jutsus_learned)
						if(genintesters.Find(src)) SealsDoneGenin++
						usr.Transformation_Jutsu()
				if(usr.first=="dog"&&usr.second=="dog"&&usr.rat==0&&usr.dog==2&&usr.ox==0&&usr.dragon==0&&usr.monkey==0&&usr.snake==0&&usr.horse==0&&usr.rabbit==0)
					var/obj/Jutsus/AdvancedBodyReplace/J=new/obj/Jutsus/AdvancedBodyReplace
					if(J.type in usr.jutsus_learned)
						if(genintesters.Find(src)) SealsDoneGenin++
						usr.Advanced_Body_Replacement_Technique()
				if(usr.first=="rat"&&usr.second=="rat"&&usr.rat==2&&usr.dog==0&&usr.ox==0&&usr.dragon==0&&usr.monkey==0&&usr.snake==0&&usr.horse==0&&usr.rabbit==0)
					var/obj/Jutsus/ChakraRelease/J=new/obj/Jutsus/ChakraRelease
					if(J.type in usr.jutsus_learned)
						if(genintesters.Find(src)) SealsDoneGenin++
						usr.Chakra_Release()
				if(usr.first=="dog"&&usr.second=="dog"&&usr.third=="rat"&&usr.rat==1&&usr.dog==2&&usr.ox==0&&usr.dragon==0&&usr.monkey==0&&usr.snake==0&&usr.horse==0&&usr.rabbit==0)
					var/obj/Jutsus/FireBall/J=new/obj/Jutsus/FireBall
					if(J.type in usr.jutsus_learned)
						if(genintesters.Find(src)) SealsDoneGenin++
						usr.Fire_Ball()
				if(usr.first=="dog"&&usr.second=="rat"&&usr.third=="rat"&&usr.fourth=="dog"&&usr.rat==2&&usr.dog==2&&usr.ox==0&&usr.dragon==0&&usr.monkey==0&&usr.snake==0&&usr.horse==0&&usr.rabbit==0)
					var/obj/Jutsus/PheonixFire/J=new/obj/Jutsus/PheonixFire
					if(J.type in usr.jutsus_learned)
						if(genintesters.Find(src)) SealsDoneGenin++
						usr.Phoenix_Immortal_Fire_Technique()
				if(usr.first=="dog"&&usr.second=="rat"&&usr.third=="dog"&&usr.fourth=="rabbit"&&usr.fifth=="snake"&&usr.rat==1&&usr.dog==2&&usr.ox==0&&usr.dragon==0&&usr.monkey==0&&usr.snake==1&&usr.horse==0&&usr.rabbit==1)
					var/obj/Jutsus/AFireBall/J=new/obj/Jutsus/AFireBall
					if(J.type in usr.jutsus_learned)
						if(genintesters.Find(src)) SealsDoneGenin++
						usr.AFire_Ball()
			//"Gravity"
				if(usr.first=="snake"&&usr.second=="rabbit"&&usr.rat==0&&usr.dog==0&&usr.ox==0&&usr.dragon==0&&usr.monkey==0&&usr.snake==1&&usr.horse==0&&usr.rabbit==1)
					var/obj/Jutsus/Induction/J=new/obj/Jutsus/Induction
					if(J.type in usr.jutsus_learned)
						if(genintesters.Find(src)) SealsDoneGenin++
						usr.Induction()
				if(usr.first=="rabbit"&&usr.second=="snake"&&usr.rat==0&&usr.dog==0&&usr.ox==0&&usr.dragon==0&&usr.monkey==0&&usr.snake==1&&usr.horse==0&&usr.rabbit==1)
					var/obj/Jutsus/Repulsion/J=new/obj/Jutsus/Repulsion
					if(J.type in usr.jutsus_learned)
						if(genintesters.Find(src)) SealsDoneGenin++
						usr.Repulsion()
				if(usr.first=="rabbit"&&usr.second=="rabbit"&&usr.third=="snake"&&usr.fourth=="snake"&&usr.fifth=="rabbit"&&usr.sixth=="snake"&&usr.rat==0&&usr.dog==0&&usr.ox==0&&usr.dragon==0&&usr.monkey==0&&usr.snake==3&&usr.horse==0&&usr.rabbit==3)
					var/obj/Jutsus/Almighty_Push/J=new/obj/Jutsus/Almighty_Push
					if(J.type in usr.jutsus_learned)
						if(genintesters.Find(src)) SealsDoneGenin++
						usr.AlmightyPush()
			//"Kaguya"
				if(usr.first=="rat"&&usr.second=="dog"&&usr.third=="ox"&&usr.rat==1&&usr.dog==1&&usr.ox==1&&usr.dragon==0&&usr.monkey==0&&usr.snake==0&&usr.horse==0&&usr.rabbit==0)
					var/obj/Jutsus/Bone_Pulse/J=new/obj/Jutsus/Bone_Pulse
					if(J.type in usr.jutsus_learned)
						if(genintesters.Find(src)) SealsDoneGenin++
						usr.Bone_Pulse()
				if(usr.first=="rat"&&usr.second=="dog"&&usr.third=="ox"&usr.fourth=="rat"&&usr.rat==2&&usr.dog==1&&usr.ox==1&&usr.dragon==0&&usr.monkey==0&&usr.snake==0&&usr.horse==0&&usr.rabbit==0)
					var/obj/Jutsus/Dance_Of_The_Kaguya/J=new/obj/Jutsus/Dance_Of_The_Kaguya
					if(J.type in usr.jutsus_learned)
						if(genintesters.Find(src)) SealsDoneGenin++
						usr.Dance_Of_The_Kaguya()
				if(usr.first=="ox"&&usr.rat==0&&usr.dog==0&&usr.ox==1&&usr.dragon==0&&usr.monkey==0&&usr.snake==0&&usr.horse==0&&usr.rabbit==0)
					var/obj/Jutsus/Bone_Tip/J=new/obj/Jutsus/Bone_Tip
					if(J.type in usr.jutsus_learned)
						if(genintesters.Find(src)) SealsDoneGenin++
						usr.Bone_Tip()
				if(usr.first=="ox"&&usr.second=="ox"&&usr.third=="rat"&&usr.rat==1&&usr.dog==0&&usr.ox==2&&usr.dragon==0&&usr.monkey==0&&usr.snake==0&&usr.horse==0&&usr.rabbit==0)
					var/obj/Jutsus/Bone_Tip/J=new/obj/Jutsus/Bone_Sensation
					if(J.type in usr.jutsus_learned)
						if(genintesters.Find(src)) SealsDoneGenin++
						usr.Bone_Sensation()
				if(usr.first=="dog"&&usr.second=="rat"&&usr.third=="rat"&&usr.rat==2&&usr.dog==1&&usr.ox==0&&usr.dragon==0&&usr.monkey==0&&usr.snake==0&&usr.horse==0&&usr.rabbit==0)
					var/obj/Jutsus/Curse_Dragon/J=new/obj/Jutsus/Curse_Dragon
					if(J.type in usr.jutsus_learned)
						if(genintesters.Find(src)) SealsDoneGenin++
						usr.Curse_Dragon()
				if(usr.first=="dog"&&usr.second=="ox"&&usr.third=="dragon"&&usr.fourth=="ox"&&usr.rat==0&&usr.dog==1&&usr.ox==2&&usr.dragon==1&&usr.monkey==0&&usr.snake==0&&usr.horse==0&&usr.rabbit==0)
					var/obj/Jutsus/Kamui/J=new/obj/Jutsus/Kamui
					if(J.type in usr.jutsus_learned)
						if(genintesters.Find(src)) SealsDoneGenin++
						usr.Kamui()
				if(usr.first=="rabbit"&&usr.rat==0&&usr.dog==0&&usr.ox==0&&usr.dragon==0&&usr.monkey==0&&usr.snake==0&&usr.horse==0&&usr.rabbit==1)
					var/obj/Jutsus/Flying_Thunder_God/J=new/obj/Jutsus/Flying_Thunder_God
					if(J.type in usr.jutsus_learned)
						if(genintesters.Find(src)) SealsDoneGenin++
						usr.Flying_Thunder_God()
				if(usr.first=="rabbit"&&usr.second=="rabbit"&&usr.third=="monkey"&&usr.fourth=="monkey"&&usr.rat==0&&usr.dog==0&&usr.ox==0&&usr.dragon==0&&usr.monkey==2&&usr.snake==0&&usr.horse==0&&usr.rabbit==2)
					var/obj/Jutsus/LimbParalyzeSeal/J=new/obj/Jutsus/LimbParalyzeSeal
					if(J.type in usr.jutsus_learned)
						if(genintesters.Find(src)) SealsDoneGenin++
						usr.LimbParalyzeSeal()
				if(usr.first=="rabbit"&&usr.second=="monkey"&&usr.third=="monkey"&&usr.fourth=="rabbit"&&usr.fifth=="monkey"&&usr.rat==0&&usr.dog==0&&usr.ox==0&&usr.dragon==0&&usr.monkey==3&&usr.snake==0&&usr.horse==0&&usr.rabbit==2)
					var/obj/Jutsus/Warp_Rasengan/J=new/obj/Jutsus/Warp_Rasengan
					if(J.type in usr.jutsus_learned)
						if(genintesters.Find(src)) SealsDoneGenin++
						usr.Warp_Rasengan()
				if(usr.first=="rabbit"&&usr.second=="dog"&&usr.third=="monkey"&&usr.fourth=="rabbit"&&usr.rat==0&&usr.dog==1&&usr.ox==0&&usr.dragon==0&&usr.monkey==1&&usr.snake==0&&usr.horse==0&&usr.rabbit==2)
					var/obj/Jutsus/Sai_Rat/J=new/obj/Jutsus/Sai_Rat
					if(J.type in usr.jutsus_learned)
						if(genintesters.Find(src)) SealsDoneGenin++
						usr.SaiRat()
				if(usr.first=="dog"&&usr.second=="rat"&&usr.third=="rat"&&usr.fourth=="dragon"&&usr.fifth=="dog"&&usr.rat==2&&usr.dog==2&&usr.ox==0&&usr.dragon==1&&usr.monkey==0&&usr.snake==0&&usr.horse==0&&usr.rabbit==0)
					var/obj/Jutsus/Snake_Release_Jutsu/J=new/obj/Jutsus/Snake_Release_Jutsu
					if(J.type in usr.jutsus_learned)
						if(genintesters.Find(src)) SealsDoneGenin++
						usr.Snake_Release_Jutsu()
				if(usr.first=="dog"&&usr.second=="dog"&&usr.third=="rat"&&usr.fourth=="dragon"&&usr.fifth=="dragon"&&usr.rat==1&&usr.dog==2&&usr.ox==0&&usr.dragon==2&&usr.monkey==0&&usr.snake==0&&usr.horse==0&&usr.rabbit==0)
					var/obj/Jutsus/Sage_Bind/J=new/obj/Jutsus/Sage_Bind
					if(J.type in usr.jutsus_learned)
						if(genintesters.Find(src)) SealsDoneGenin++
						usr.Sage_Bind()
				if(usr.first=="ox"&&usr.second=="rat"&&usr.third=="rat"&&usr.fourth=="ox"&&usr.rat==2&&usr.dog==0&&usr.ox==2&&usr.dragon==0&&usr.monkey==0&&usr.snake==0&&usr.horse==0&&usr.rabbit==0)
					var/obj/Jutsus/Snake_Skin_Replacement_Jutsu/J=new/obj/Jutsus/Snake_Skin_Replacement_Jutsu
					if(J.type in usr.jutsus_learned)
						if(genintesters.Find(src)) SealsDoneGenin++
						usr.Snake_Skin_Replacement_Jutsu()
				if(usr.first=="dragon"&&usr.second=="horse"&&usr.third=="horse"&&usr.fourth=="dragon"&&usr.fifth=="dragon"&&usr.rat==0&&usr.dog==0&&usr.ox==0&&usr.dragon==3&&usr.monkey==0&&usr.snake==0&&usr.horse==2&&usr.rabbit==0)
					var/obj/Jutsus/Demon_Wind_Shuriken/J=new/obj/Jutsus/Demon_Wind_Shuriken
					if(J.type in usr.jutsus_learned)
						if(genintesters.Find(src)) SealsDoneGenin++
						usr.Demon_Wind_Shuriken()
				if(usr.first=="dragon"&&usr.second=="horse"&&usr.third=="dragon"&&usr.fourth=="horse"&&usr.rat==0&&usr.dog==0&&usr.ox==0&&usr.dragon==2&&usr.monkey==0&&usr.snake==0&&usr.horse==2&&usr.rabbit==0)
					var/obj/Jutsus/Multiple_Chakra_Kunai/J=new/obj/Jutsus/Multiple_Chakra_Kunai
					if(J.type in usr.jutsus_learned)
						if(genintesters.Find(src)) SealsDoneGenin++
						usr.Multiple_Chakra_Kunai()
				if(usr.first=="rabbit"&&usr.second=="horse"&&usr.third=="monkey"&&usr.fourth=="dragon"&&usr.rat==0&&usr.dog==0&&usr.ox==0&&usr.dragon==1&&usr.monkey==1&&usr.snake==0&&usr.horse==1&&usr.rabbit==1)
					var/obj/Jutsus/Snake_Rustle_Jutsu/J=new/obj/Jutsus/Snake_Rustle_Jutsu
					if(J.type in usr.jutsus_learned)
						if(genintesters.Find(src)) SealsDoneGenin++
						usr.Snake_Rustle_Jutsu()
				if(usr.first=="rabbit"&&usr.second=="dragon"&&usr.third=="dog"&&usr.fourth=="monkey"&&usr.fifth=="rabbit"&&usr.rat==0&&usr.dog==1&&usr.ox==0&&usr.dragon==1&&usr.monkey==1&&usr.snake==0&&usr.horse==0&&usr.rabbit==2)
					var/obj/Jutsus/Sai_Snakes/J=new/obj/Jutsus/Sai_Snakes
					if(J.type in usr.jutsus_learned)
						if(genintesters.Find(src)) SealsDoneGenin++
						usr.Sai_Snakes()
				if(usr.first=="rabbit"&&usr.second=="dog"&&usr.third=="snake"&&usr.fourth=="rabbit"&&usr.rat==0&&usr.dog==1&&usr.ox==0&&usr.dragon==0&&usr.monkey==0&&usr.snake==1&&usr.horse==0&&usr.rabbit==2)
					var/obj/Jutsus/Magma_Needles/J=new/obj/Jutsus/Magma_Needles
					if(J.type in usr.jutsus_learned)
						if(genintesters.Find(src)) SealsDoneGenin++
						usr.Magma_Needles()
				if(usr.first=="rabbit"&&usr.second=="snake"&&usr.third=="dog"&&usr.fourth=="rat"&&usr.rat==1&&usr.dog==1&&usr.ox==0&&usr.dragon==0&&usr.monkey==0&&usr.snake==1&&usr.horse==0&&usr.rabbit==1)
					var/obj/Jutsus/Magma_Crush/J=new/obj/Jutsus/Magma_Crush
					if(J.type in usr.jutsus_learned)
						if(genintesters.Find(src)) SealsDoneGenin++
						usr.Magma_Crush()
				if(usr.first=="dog"&&usr.second=="rat"&&usr.third=="dog"&&usr.fourth=="rat"&&usr.fifth=="dog"&&usr.sixth=="rat"&&usr.seventh=="dog"&&usr.rat==3&&usr.dog==4&&usr.ox==0&&usr.dragon==0&&usr.monkey==0&&usr.snake==0&&usr.horse==0&&usr.rabbit==0)
					var/obj/Jutsus/Wind_Dragon_Projectile/J=new/obj/Jutsus/Wind_Dragon_Projectile
					if(J.type in usr.jutsus_learned)
						if(genintesters.Find(src)) SealsDoneGenin++
						usr.Wind_Dragon_Projectile()
				if(usr.first=="monkey"&&usr.second=="snake"&&usr.third=="ox"&&usr.fourth=="monkey"&&usr.rat==0&&usr.dog==0&&usr.ox==1&&usr.dragon==0&&usr.monkey==2&&usr.snake==1&&usr.horse==0&&usr.rabbit==0)
					var/obj/Jutsus/Shadow_Punch/J=new/obj/Jutsus/Shadow_Punch
					if(J.type in usr.jutsus_learned)
						if(genintesters.Find(src)) SealsDoneGenin++
						usr.Shadow_Punch()
				if(usr.first=="ox"&&usr.second=="rat"&&usr.third=="rat"&&usr.rat==2&&usr.dog==0&&usr.ox==1&&usr.dragon==0&&usr.monkey==0&&usr.snake==0&&usr.horse==0&&usr.rabbit==0)
					var/obj/Jutsus/Crow_Substitution/J=new/obj/Jutsus/Crow_Substitution
					if(J.type in usr.jutsus_learned)
						if(genintesters.Find(src)) SealsDoneGenin++
						usr.Crow_Substitution()
				if(usr.first=="rabbit"&&usr.second=="rabbit"&&usr.third=="dragon"&&usr.fourth=="rabbit"&&usr.rat==0&&usr.dog==0&&usr.ox==0&&usr.dragon==1&&usr.monkey==0&&usr.snake==0&&usr.horse==0&&usr.rabbit==3)
					var/obj/Jutsus/Bubble_Barrage/J=new/obj/Jutsus/Bubble_Barrage
					if(J.type in usr.jutsus_learned)
						if(genintesters.Find(src)) SealsDoneGenin++
						usr.BubbleBarrage()
				if(usr.first=="rabbit"&&usr.second=="rabbit"&&usr.third=="dragon"&&usr.fourth=="rabbit"&&usr.fifth=="dragon"&&usr.sixth=="rabbit"&&usr.seventh=="dragon"&&usr.eighth=="dragon"&&usr.rat==0&&usr.dog==0&&usr.ox==0&&usr.dragon==4&&usr.monkey==0&&usr.snake==0&&usr.horse==0&&usr.rabbit==4)
					var/obj/Jutsus/Bubble_Trouble/J=new/obj/Jutsus/Bubble_Trouble
					if(J.type in usr.jutsus_learned)
						if(genintesters.Find(src)) SealsDoneGenin++
						usr.Bubble_Trouble()
				if(usr.first=="dog"&&usr.second=="dog"&&usr.third=="dragon"&&usr.fourth=="dog"&&usr.rat==0&&usr.dog==3&&usr.ox==0&&usr.dragon==1&&usr.monkey==0&&usr.snake==0&&usr.horse==0&&usr.rabbit==0)
					var/obj/Jutsus/Bubble_Spreader/J=new/obj/Jutsus/Bubble_Spreader
					if(J.type in usr.jutsus_learned)
						if(genintesters.Find(src)) SealsDoneGenin++
						usr.BubbleSpreader()
				if(usr.first=="rabbit"&&usr.second=="dragon"&&usr.third=="dog"&&usr.fourth=="rabbit"&&usr.fifth=="dragon"&&usr.sixth=="dog"&&usr.rat==0&&usr.dog==2&&usr.ox==0&&usr.dragon==2&&usr.monkey==0&&usr.snake==0&&usr.horse==0&&usr.rabbit==2)
					var/obj/Jutsus/Ink_Lions/J=new/obj/Jutsus/Ink_Lions
					if(J.type in usr.jutsus_learned)
						if(genintesters.Find(src)) SealsDoneGenin++
						usr.InkLions()
				if(usr.first=="ox"&&usr.second=="rabbit"&&usr.third=="dog"&&usr.fourth=="ox"&&usr.rat==0&&usr.dog==1&&usr.ox==2&&usr.dragon==0&&usr.monkey==0&&usr.snake==0&&usr.horse==0&&usr.rabbit==1)
					var/obj/Jutsus/Crystal_Mirrors/J=new/obj/Jutsus/Crystal_Mirrors
					if(J.type in usr.jutsus_learned)
						if(genintesters.Find(src)) SealsDoneGenin++
						usr.Crystal_Mirrors()
				if(usr.first=="rabbit"&&usr.second=="rabbit"&&usr.third=="rabbit"&usr.fourth=="rabbit"&&usr.rat==0&&usr.dog==0&&usr.ox==0&&usr.dragon==0&&usr.monkey==0&&usr.snake==0&&usr.horse==0&&usr.rabbit==4)
					var/obj/Jutsus/MudWall/J=new/obj/Jutsus/MudWall
					if(J.type in usr.jutsus_learned)
						if(genintesters.Find(src)) SealsDoneGenin++
						usr.MudWall()
				if(usr.first=="dragon"&&usr.second=="horse"&&usr.third=="dragon"&&usr.fourth=="horse"&&usr.rat==0&&usr.dog==0&&usr.ox==0&&usr.dragon==2&&usr.monkey==0&&usr.snake==0&&usr.horse==2&&usr.rabbit==0)
					var/obj/Jutsus/Weapon_Manipulation_Jutsu/J=new/obj/Jutsus/Blade_Manipulation_Jutsu
					if(J.type in usr.jutsus_learned)
						if(genintesters.Find(src)) SealsDoneGenin++
						usr.Weapon_Manipulation_Jutsu()
				if(usr.first=="dragon"&&usr.second=="snake"&&usr.third=="dragon"&&usr.rat==0&&usr.dog==0&&usr.ox==0&&usr.dragon==2&&usr.monkey==0&&usr.snake==1&&usr.horse==0&&usr.rabbit==0)
					var/obj/Jutsus/C1Snake/J=new/obj/Jutsus/C1Snake
					if(J.type in usr.jutsus_learned)
						if(genintesters.Find(src)) SealsDoneGenin++
						usr.C1Snake()
				if(usr.first=="dragon"&&usr.second=="horse"&&usr.third=="dragon"&&usr.fourth=="horse"&&usr.fifth=="dragon"&&usr.sixth=="dragon"&&usr.rat==0&&usr.dog==0&&usr.ox==0&&usr.dragon==4&&usr.monkey==0&&usr.snake==0&&usr.horse==2&&usr.rabbit==0)
					var/obj/Jutsus/TwinDragons/J=new/obj/Jutsus/TwinDragons
					if(J.type in usr.jutsus_learned)
						if(genintesters.Find(src)) SealsDoneGenin++
						usr.TwinDragons()
				if(usr.first=="rat"&&usr.second=="snake"&&usr.third=="dog"&&usr.rat==1&&usr.dog==1&&usr.ox==0&&usr.dragon==0&&usr.monkey==0&&usr.snake==1&&usr.horse==0&&usr.rabbit==0)
					var/obj/Jutsus/HiddenSnakeStab/J=new/obj/Jutsus/HiddenSnakeStab
					if(J.type in usr.jutsus_learned)
						if(genintesters.Find(src)) SealsDoneGenin++
						usr.HiddenSnakeStab()
				if(usr.first=="dog"&&usr.second=="rabbit"&&usr.third=="ox"&&usr.rat==0&&usr.dog==1&&usr.ox==1&&usr.dragon==0&&usr.monkey==0&&usr.snake==0&&usr.horse==0&&usr.rabbit==1)
					var/obj/Jutsus/Root_Strangle/J=new/obj/Jutsus/Root_Strangle
					if(J.type in usr.jutsus_learned)
						if(genintesters.Find(src)) SealsDoneGenin++
						usr.Root_Strangle()
				if(usr.first=="dog"&&usr.second=="rabbit"&&usr.third=="ox"&&usr.fourth=="dog"&&usr.rat==0&&usr.dog==2&&usr.ox==1&&usr.dragon==0&&usr.monkey==0&&usr.snake==0&&usr.horse==0&&usr.rabbit==1)
					var/obj/Jutsus/Wood_Balvan/J=new/obj/Jutsus/Wood_Balvan
					if(J.type in usr.jutsus_learned)
						if(genintesters.Find(src)) SealsDoneGenin++
						usr.Wood_Balvan()
				if(usr.first=="dog"&&usr.second=="rabbit"&&usr.third=="ox"&&usr.fourth=="dog"&&usr.fifth=="dog"&&usr.rat==0&&usr.dog==3&&usr.ox==1&&usr.dragon==0&&usr.monkey==0&&usr.snake==0&&usr.horse==0&&usr.rabbit==1)
					var/obj/Jutsus/Root_Stab/J=new/obj/Jutsus/Root_Stab
					if(J.type in usr.jutsus_learned)
						if(genintesters.Find(src)) SealsDoneGenin++
						usr.Root_Stab()
				if(usr.first=="ox"&&usr.second=="ox"&&usr.third=="dog"&&usr.fourth=="rabbit"&&usr.rat==0&&usr.dog==1&&usr.ox==2&&usr.dragon==0&&usr.monkey==0&&usr.snake==0&&usr.horse==0&&usr.rabbit==1)
					var/obj/Jutsus/Crystal_Pillar/J=new/obj/Jutsus/Crystal_Pillar
					if(J.type in usr.jutsus_learned)
						if(genintesters.Find(src)) SealsDoneGenin++
						usr.Crystal_Pillar()
				if(usr.first=="ox"&&usr.second=="rabbit"&&usr.third=="dog"&&usr.fourth=="ox"&&usr.fifth=="ox"&&usr.sixth=="rabbit"&&usr.seventh=="dog"&&usr.eighth=="ox"&&usr.rat==0&&usr.dog==2&&usr.ox==4&&usr.dragon==0&&usr.monkey==0&&usr.snake==0&&usr.horse==0&&usr.rabbit==2)
					var/obj/Jutsus/Crystal_Arrow/J=new/obj/Jutsus/Crystal_Arrow
					if(J.type in usr.jutsus_learned)
						if(genintesters.Find(src)) SealsDoneGenin++
						usr.Crystal_Arrow()
				if(usr.first=="rabbit"&&usr.second=="ox"&&usr.third=="rabbit"&&usr.fourth=="ox"&&usr.fifth=="rabbit"&&usr.sixth=="ox"&&usr.rat==0&&usr.dog==0&&usr.ox==3&&usr.dragon==0&&usr.monkey==0&&usr.snake==0&&usr.horse==0&&usr.rabbit==3)
					var/obj/Jutsus/Sage_Style_Giant_Rasengan/J=new/obj/Jutsus/Sage_Style_Giant_Rasengan
					if(J.type in usr.jutsus_learned)
						if(genintesters.Find(src)) SealsDoneGenin++
						usr.Sage_Style_Giant_Rasengan()
				if(usr.first=="horse"&&usr.second=="rabbit"&&usr.third=="horse"&&usr.rat==0&&usr.dog==0&&usr.ox==0&&usr.dragon==0&&usr.monkey==0&&usr.snake==0&&usr.horse==2&&usr.rabbit==1)
					var/obj/Jutsus/Gedo_Revival/J=new/obj/Jutsus/Gedo_Revival
					if(J.type in usr.jutsus_learned)
						if(genintesters.Find(src)) SealsDoneGenin++
						usr.Gedo_Revival()
				if(usr.first=="rabbit"&&usr.second=="snake"&&usr.third=="monkey"&&usr.fourth=="rabbit"&&usr.rat==0&&usr.dog==0&&usr.ox==0&&usr.dragon==0&&usr.monkey==1&&usr.snake==1&&usr.horse==0&&usr.rabbit==2)
					var/obj/Jutsus/Chidori_Nagashi/J=new/obj/Jutsus/Chidori_Nagashi
					if(J.type in usr.jutsus_learned)
						if(genintesters.Find(src)) SealsDoneGenin++
						usr.Chidori_Nagashi()
				if(usr.first=="rat"&&usr.second=="rat"&&usr.third=="rat"&&usr.rat==3&&usr.dog==0&&usr.ox==0&&usr.dragon==0&&usr.monkey==0&&usr.snake==0&&usr.horse==0&&usr.rabbit==0)
					var/obj/Jutsus/Rising_Twin_Dragon/J=new/obj/Jutsus/Rising_Twin_Dragon
					if(J.type in usr.jutsus_learned)
						if(genintesters.Find(src)) SealsDoneGenin++
						usr.Rising_Twin_Dragons()
				if(usr.first=="dog"&&usr.second=="dog"&&usr.third=="ox"&&usr.fourth=="rabbit"&&usr.rat==0&&usr.dog==2&&usr.ox==1&&usr.dragon==0&&usr.monkey==0&&usr.snake==0&&usr.horse==0&&usr.rabbit==1)
					var/obj/Jutsus/Dango/J=new/obj/Jutsus/Dango
					if(J.type in usr.jutsus_learned)
						usr.Dango()
				if(usr.first=="monkey"&&usr.second=="monkey"&&usr.third=="rabbit"&&usr.rat==0&&usr.dog==0&&usr.ox==0&&usr.dragon==0&&usr.monkey==2&&usr.snake==0&&usr.horse==0&&usr.rabbit==1)
					var/obj/Jutsus/Zankuuha/J=new/obj/Jutsus/Zankuuha
					if(J.type in usr.jutsus_learned)
						usr.Zankuuha()
				if(usr.first=="rat"&&usr.second=="dragon"&&usr.third=="rat"&&usr.fourth=="ox"&&usr.fifth=="snake"&&usr.rat==2&&usr.dog==0&&usr.ox==1&&usr.dragon==1&&usr.monkey==0&&usr.snake==1&&usr.horse==0&&usr.rabbit==0)
					var/obj/Jutsus/Teppoudama/J=new/obj/Jutsus/Teppoudama
					if(J.type in usr.jutsus_learned)
						usr.Teppoudama()
				if(usr.first=="ox"&&usr.second=="dragon"&&usr.third=="dragon"&&usr.fourth=="rat"&&usr.fifth=="rat"&&usr.rat==2&&usr.dog==0&&usr.ox==1&&usr.dragon==2&&usr.monkey==0&&usr.snake==0&&usr.horse==0&&usr.rabbit==0)
					var/obj/Jutsus/Suijinheki/J=new/obj/Jutsus/Suijinheki
					if(J.type in usr.jutsus_learned)
						usr.Suijinheki()
				if(usr.first=="dragon"&&usr.second=="rat"&&usr.third=="rat"&&usr.fourth=="rabbit"&&usr.rat==2&&usr.dog==0&&usr.ox==0&&usr.dragon==1&&usr.monkey==0&&usr.snake==0&&usr.horse==0&&usr.rabbit==1)
					var/obj/Jutsus/Daitoppa/J=new/obj/Jutsus/Daitoppa
					if(J.type in usr.jutsus_learned)
						usr.FuutonDaitoppa()
				if(usr.first=="dragon"&&usr.second=="snake"&&usr.third=="monkey"&&usr.rat==0&&usr.dog==0&&usr.ox==0&&usr.dragon==1&&usr.monkey==1&&usr.snake==1&&usr.horse==0&&usr.rabbit==0)
					var/obj/Jutsus/Doryuusou/J=new/obj/Jutsus/Doryuusou
					if(J.type in usr.jutsus_learned)
						usr.Doryuusou()
				if(usr.first=="snake"&&usr.second=="snake"&&usr.third=="rabbit"&&usr.fourth=="rat"&&usr.fifth=="rabbit"&&usr.rat==1&&usr.dog==0&&usr.ox==0&&usr.dragon==0&&usr.monkey==0&&usr.snake==2&&usr.horse==0&&usr.rabbit==2)
					var/obj/Jutsus/JukaiKoutan/J=new/obj/Jutsus/JukaiKoutan
					if(J.type in usr.jutsus_learned)
						usr.JukaiKoutan()
				if(usr.first=="rat"&&usr.second=="rat"&&usr.third=="snake"&&usr.fourth=="rabbit"&&usr.rat==2&&usr.dog==0&&usr.ox==0&&usr.dragon==0&&usr.monkey==0&&usr.snake==1&&usr.horse==0&&usr.rabbit==1)
					var/obj/Jutsus/JubakuEisou/J=new/obj/Jutsus/JubakuEisou
					if(J.type in usr.jutsus_learned)
						usr.JubakuEisou()
				if(usr.first=="rat"&&usr.second=="rat"&&usr.third=="snake"&&usr.fourth=="rabbit"&&usr.fifth=="rabbit"&&usr.rat==2&&usr.dog==0&&usr.ox==0&&usr.dragon==0&&usr.monkey==0&&usr.snake==1&&usr.horse==0&&usr.rabbit==2)
					var/obj/Jutsus/Daijurin/J=new/obj/Jutsus/Daijurin
					if(J.type in usr.jutsus_learned)
						usr.Daijurin()
				if(usr.first=="rabbit"&&usr.second=="snake"&&usr.third=="horse"&&usr.fourth=="rabbit"&&usr.fifth=="rat"&&usr.rat==1&&usr.dog==0&&usr.ox==0&&usr.dragon==0&&usr.monkey==0&&usr.snake==1&&usr.horse==1&&usr.rabbit==2)
					var/obj/Jutsus/Soul_Devastator_Seal/J=new/obj/Jutsus/Soul_Devastator_Seal
					if(J.type in usr.jutsus_learned)
						if(genintesters.Find(src)) SealsDoneGenin++
						usr.Soul_Devastator_Seal()
				if(usr.first=="rabbit"&&usr.second=="dog"&&usr.third=="dog"&&usr.fourth=="rabbit"&&usr.rat==0&&usr.dog==2&&usr.ox==0&&usr.dragon==0&&usr.monkey==0&&usr.snake==0&&usr.horse==0&&usr.rabbit==2)
					var/obj/Jutsus/Iceball/J=new/obj/Jutsus/Iceball
					if(J.type in usr.jutsus_learned)
						if(genintesters.Find(src)) SealsDoneGenin++
						usr.Iceball()
				if(usr.first=="dog"&&usr.second=="dog"&&usr.third=="dog"&&usr.fourth=="ox"&&usr.rat==0&&usr.dog==3&&usr.ox==1&&usr.dragon==0&&usr.monkey==0&&usr.snake==0&&usr.horse==0&&usr.rabbit==0)
					var/obj/Jutsus/WoodStyleFortress/J=new/obj/Jutsus/WoodStyleFortress
					if(J.type in usr.jutsus_learned)
						if(genintesters.Find(src)) SealsDoneGenin++
						usr.WoodStyleFortress()
				if(usr.first=="ox"&&usr.second=="ox"&&usr.third=="dragon"&&usr.fourth=="ox"&&usr.rat==0&&usr.dog==0&&usr.ox==3&&usr.dragon==1&&usr.monkey==0&&usr.snake==0&&usr.horse==0&&usr.rabbit==0)
					var/obj/Jutsus/CalorieControl/J=new/obj/Jutsus/CalorieControl
					if(J.type in usr.jutsus_learned)
						if(genintesters.Find(src)) SealsDoneGenin++
						usr.CalorieControl()
				if(usr.first=="ox"&&usr.second=="rabbit"&&usr.third=="dog"&&usr.rat==0&&usr.dog==1&&usr.ox==1&&usr.dragon==0&&usr.monkey==0&&usr.snake==0&&usr.horse==0&&usr.rabbit==1)
					var/obj/Jutsus/Crystal_Shards/J=new/obj/Jutsus/Crystal_Shards
					if(J.type in usr.jutsus_learned)
						if(genintesters.Find(src)) SealsDoneGenin++
						usr.Crystal_Shards()
				if(usr.first=="dog"&&usr.second=="rabbit"&&usr.third=="rabbit"&&usr.fourth=="dog"&&usr.rat==0&&usr.dog==2&&usr.ox==0&&usr.dragon==0&&usr.monkey==0&&usr.snake==0&&usr.horse==0&&usr.rabbit==2)
					var/obj/Jutsus/Crystal_Needles/J=new/obj/Jutsus/Crystal_Needles
					if(J.type in usr.jutsus_learned)
						if(genintesters.Find(src)) SealsDoneGenin++
						usr.Crystal_Needles()
				if(usr.first=="rabbit"&&usr.second=="dog"&&usr.third=="dog"&&usr.fourth=="ox"&&usr.rat==0&&usr.dog==2&&usr.ox==1&&usr.dragon==0&&usr.monkey==0&&usr.snake==0&&usr.horse==0&&usr.rabbit==1)
					var/obj/Jutsus/Crystal_Spikes/J=new/obj/Jutsus/Crystal_Spikes
					if(J.type in usr.jutsus_learned)
						if(genintesters.Find(src)) SealsDoneGenin++
						usr.Crystal_Spikes()
				if(usr.first=="rabbit"&&usr.second=="rabbit"&&usr.third=="ox"&&usr.fourth=="dog"&&usr.fifth=="dog"&&usr.rat==0&&usr.dog==2&&usr.ox==1&&usr.dragon==0&&usr.monkey==0&&usr.snake==0&&usr.horse==0&&usr.rabbit==2)
					var/obj/Jutsus/Crystal_Explosion/J=new/obj/Jutsus/Crystal_Explosion
					if(J.type in usr.jutsus_learned)
						if(genintesters.Find(src)) SealsDoneGenin++
						usr.Crystal_Explosion()
				if(usr.first=="rabbit"&&usr.second=="rabbit"&&usr.third=="rabbit"&&usr.fourth=="snake"&&usr.rat==0&&usr.dog==0&&usr.ox==0&&usr.dragon==0&&usr.monkey==0&&usr.snake==1&&usr.horse==0&&usr.rabbit==3)
					var/obj/Jutsus/EarthBoulder/J=new/obj/Jutsus/EarthBoulder
					if(J.type in usr.jutsus_learned)
						if(genintesters.Find(src)) SealsDoneGenin++
						usr.EarthBoulder()
				if(usr.first=="rabbit"&&usr.second=="snake"&&usr.third=="monkey"&&usr.fourth=="rabbit"&&usr.fifth=="snake"&&usr.rat==0&&usr.dog==0&&usr.ox==0&&usr.dragon==0&&usr.monkey==1&&usr.snake==2&&usr.horse==0&&usr.rabbit==2)
					var/obj/Jutsus/Wind_Tornados/J=new/obj/Jutsus/Wind_Tornados
					if(J.type in usr.jutsus_learned)
						if(genintesters.Find(src)) SealsDoneGenin++
						usr.Wind_Tornados()
				if(usr.first=="dog"&&usr.second=="snake"&&usr.rat==0&&usr.dog==1&&usr.ox==0&&usr.dragon==0&&usr.monkey==0&&usr.snake==1&&usr.horse==0&&usr.rabbit==0)
					var/obj/Jutsus/FireMask/J=new/obj/Jutsus/FireMask
					if(J.type in usr.jutsus_learned)
						if(genintesters.Find(src)) SealsDoneGenin++
						usr.FireMask()
				if(usr.first=="ox"&&usr.second=="snake"&&usr.rat==0&&usr.dog==0&&usr.ox==1&&usr.dragon==0&&usr.monkey==0&&usr.snake==1&&usr.horse==0&&usr.rabbit==0)
					var/obj/Jutsus/WindMask/J=new/obj/Jutsus/WindMask
					if(J.type in usr.jutsus_learned)
						if(genintesters.Find(src)) SealsDoneGenin++
						usr.WindMask()
				if(usr.first=="dog"&&usr.second=="rabbit"&&usr.rat==0&&usr.dog==1&&usr.ox==0&&usr.dragon==0&&usr.monkey==0&&usr.snake==0&&usr.horse==0&&usr.rabbit==1)
					var/obj/Jutsus/LightningMask/J=new/obj/Jutsus/LightningMask
					if(J.type in usr.jutsus_learned)
						if(genintesters.Find(src)) SealsDoneGenin++
						usr.LightningMask()
				if(usr.first=="dragon"&&usr.second=="rabbit"&&usr.rat==0&&usr.dog==0&&usr.ox==0&&usr.dragon==1&&usr.monkey==0&&usr.snake==0&&usr.horse==0&&usr.rabbit==1)
					var/obj/Jutsus/EarthMask/J=new/obj/Jutsus/EarthMask
					if(J.type in usr.jutsus_learned)
						if(genintesters.Find(src)) SealsDoneGenin++
						usr.EarthMask()
				if(usr.first=="dragon"&&usr.second=="snake"&&usr.third=="snake"&&usr.fourth=="dragon"&&usr.fifth=="dragon"&&usr.rat==0&&usr.dog==0&&usr.ox==0&&usr.dragon==3&&usr.monkey==0&&usr.snake==2&&usr.horse==0&&usr.rabbit==0)
					var/obj/Jutsus/BugTornado/J=new/obj/Jutsus/BugTornado
					if(J.type in usr.jutsus_learned)
						if(genintesters.Find(src)) SealsDoneGenin++
						usr.BugTornado()
				if(usr.first=="ox"&&usr.second=="monkey"&&usr.third=="dragon"&&usr.fourth=="dog"&&usr.fifth=="rat"&&usr.sixth=="ox"&&usr.seventh=="rabbit"&&usr.rat==1&&usr.dog==1&&usr.ox==2&&usr.dragon==1&&usr.monkey==1&&usr.snake==0&&usr.horse==0&&usr.rabbit==1)
					var/obj/Jutsus/Dust_Particle_Prison/J=new/obj/Jutsus/Dust_Particle_Prison
					if(J.type in usr.jutsus_learned)
						if(genintesters.Find(src)) SealsDoneGenin++
						usr.Dust_Particle_Prison()
				if(usr.first=="ox"&&usr.second=="monkey"&&usr.third=="dragon"&&usr.rat==0&&usr.dog==0&&usr.ox==1&&usr.dragon==1&&usr.monkey==1&&usr.snake==0&&usr.horse==0&&usr.rabbit==0)
					var/obj/Jutsus/Dust_Particle_Prison_Beam/J=new/obj/Jutsus/Dust_Particle_Prison_Beam
					if(J.type in usr.jutsus_learned)
						if(genintesters.Find(src)) SealsDoneGenin++
						usr.Dust_Particle_Prison_Beam()
						//InkBird
				if(usr.first=="dragon"&&usr.second=="rabbit"&&usr.third=="monkey"&&usr.fourth=="dog"&&usr.fifth=="dragon"&&usr.sixth=="rabbit"&&usr.seventh=="dog"&&usr.eighth=="dog"&&usr.rat==0&&usr.dog==3&&usr.ox==0&&usr.dragon==2&&usr.monkey==1&&usr.snake==0&&usr.horse==0&&usr.rabbit==2)
					var/obj/Jutsus/Ultimate_Ink_Bird/J=new/obj/Jutsus/Ultimate_Ink_Bird
					if(J.type in usr.jutsus_learned)
						if(genintesters.Find(src)) SealsDoneGenin++
						usr.Ultimate_Ink_Bird()
						//1stPupp
				if(usr.first=="rabbit"&&usr.second=="rabbit"&&usr.third=="snake"&&usr.rat==0&&usr.dog==0&&usr.ox==0&&usr.dragon==0&&usr.monkey==0&&usr.snake==1&&usr.horse==0&&usr.rabbit==2)
					var/obj/Jutsus/First_Puppet_Summoning/J=new/obj/Jutsus/First_Puppet_Summoning
					if(J.type in usr.jutsus_learned)
						if(genintesters.Find(src)) SealsDoneGenin++
						usr.First_Puppet_Summoning()
						//2ndPupp
				if(usr.first=="rabbit"&&usr.second=="snake"&&usr.third=="snake"&&usr.rat==0&&usr.dog==0&&usr.ox==0&&usr.dragon==0&&usr.monkey==0&&usr.snake==2&&usr.horse==0&&usr.rabbit==1)
					var/obj/Jutsus/Second_Puppet_Summoning/J=new/obj/Jutsus/Second_Puppet_Summoning
					if(J.type in usr.jutsus_learned)
						if(genintesters.Find(src)) SealsDoneGenin++
						usr.Second_Puppet_Summoning()
						//kazePupp
				if(usr.first=="snake"&&usr.second=="rabbit"&&usr.third=="rat"&&usr.fourth=="rabbit"&&usr.fifth=="snake"&&usr.sixth=="ox"&&usr.rat==1&&usr.dog==0&&usr.ox==1&&usr.dragon==0&&usr.monkey==0&&usr.snake==2&&usr.horse==0&&usr.rabbit==2)
					var/obj/Jutsus/Summon_Kazekage_Puppet/J=new/obj/Jutsus/Summon_Kazekage_Puppet
					if(J.type in usr.jutsus_learned)
						if(genintesters.Find(src)) SealsDoneGenin++
						usr.Summon_Kazekage_Puppet()
						//1000yrs
				if(usr.first=="monkey"&&usr.rat==0&&usr.dog==0&&usr.ox==0&&usr.dragon==0&&usr.monkey==1&&usr.snake==0&&usr.horse==0&&usr.rabbit==0)
					var/obj/Jutsus/One_Thousand_Years_of_Death/J=new/obj/Jutsus/One_Thousand_Years_of_Death
					if(J.type in usr.jutsus_learned)
						if(genintesters.Find(src)) SealsDoneGenin++
						usr.One_Thousand_Years_of_Death()
						//spidersumm
				if(usr.first=="ox"&&usr.second=="horse"&&usr.third=="horse"&&usr.fourth=="dog"&&usr.fifth=="ox"&&usr.sixth=="horse"&&usr.rat==0&&usr.dog==1&&usr.ox==2&&usr.dragon==0&&usr.monkey==0&&usr.snake==0&&usr.horse==3&&usr.rabbit==0)
					var/obj/Jutsus/Summon_Spider/J=new/obj/Jutsus/Summon_Spider
					if(J.type in usr.jutsus_learned)
						if(genintesters.Find(src)) SealsDoneGenin++
						usr.Summon_Spider()
						//snakesum
				if(usr.first=="rat"&&usr.second=="horse"&&usr.third=="rat"&&usr.fourth=="dog"&&usr.fifth=="ox"&&usr.rat==2&&usr.dog==1&&usr.ox==1&&usr.dragon==0&&usr.monkey==0&&usr.snake==0&&usr.horse==1&&usr.rabbit==0)
					var/obj/Jutsus/Snake_Summoning/J=new/obj/Jutsus/Snake_Summoning
					if(J.type in usr.jutsus_learned)
						if(genintesters.Find(src)) SealsDoneGenin++
						usr.Summoning_Snake()
						//angelwing
				if(usr.first=="rat"&&usr.second=="ox"&&usr.third=="ox"&&usr.fourth=="rat"&&usr.rat==2&&usr.dog==0&&usr.ox==2&&usr.dragon==0&&usr.monkey==0&&usr.snake==0&&usr.horse==0&&usr.rabbit==0)
					var/obj/Jutsus/Angel_Wings/J=new/obj/Jutsus/Angel_Wings
					if(J.type in usr.jutsus_learned)
						if(genintesters.Find(src)) SealsDoneGenin++
						usr.Angel_Wings()
						//paperchak
				if(usr.first=="ox"&&usr.second=="rat"&&usr.rat==1&&usr.dog==0&&usr.ox==1&&usr.dragon==0&&usr.monkey==0&&usr.snake==0&&usr.horse==0&&usr.rabbit==0)
					var/obj/Jutsus/Paper_Chakram/J=new/obj/Jutsus/Paper_Chakram
					if(J.type in usr.jutsus_learned)
						if(genintesters.Find(src)) SealsDoneGenin++
						usr.Paper_Chakram()
						//reaper
				if(usr.first=="dragon"&&usr.second=="rat"&&usr.third=="rabbit"&&usr.fourth=="dragon"&&usr.fifth=="rabbit"&&usr.sixth=="rabbit"&&usr.seventh=="rat"&&usr.rat==2&&usr.dog==0&&usr.ox==0&&usr.dragon==2&&usr.monkey==0&&usr.snake==0&&usr.horse==0&&usr.rabbit==3)
					var/obj/Jutsus/Reaper_Death_Seal/J=new/obj/Jutsus/Reaper_Death_Seal
					if(J.type in usr.jutsus_learned)
						if(genintesters.Find(src)) SealsDoneGenin++
						usr.Reaper_Death_Seal()
						//terror
				if(usr.first=="monkey"&&usr.second=="rabbit"&&usr.third=="rabbit"&&usr.fourth=="monkey"&&usr.rat==0&&usr.dog==0&&usr.ox==0&&usr.dragon==0&&usr.monkey==2&&usr.snake==0&&usr.horse==0&&usr.rabbit==2)
					var/obj/Jutsus/Seal_of_Terror/J=new/obj/Jutsus/Seal_of_Terror
					if(J.type in usr.jutsus_learned)
						if(genintesters.Find(src)) SealsDoneGenin++
						usr.Seal_of_Terror()
						//windcutt
				if(usr.first=="snake"&&usr.second=="rabbit"&&usr.third=="rabbit"&&usr.fourth=="snake"&&usr.rat==0&&usr.dog==0&&usr.ox==0&&usr.dragon==0&&usr.monkey==0&&usr.snake==2&&usr.horse==0&&usr.rabbit==2)
					var/obj/Jutsus/Wind_Cutter/J=new/obj/Jutsus/Wind_Cutter
					if(J.type in usr.jutsus_learned)
						if(genintesters.Find(src)) SealsDoneGenin++
						usr.Wind_Cutter()
						//LightningBalls
				if(usr.first=="snake"&&usr.second=="rabbit"&&usr.third=="rabbit"&&usr.rat==0&&usr.dog==0&&usr.ox==0&&usr.dragon==0&&usr.monkey==0&&usr.snake==1&&usr.horse==0&&usr.rabbit==2)
					var/obj/Jutsus/Lightning_Balls/J=new/obj/Jutsus/Lightning_Balls
					if(J.type in usr.jutsus_learned)
						if(genintesters.Find(src)) SealsDoneGenin++
						usr.LightningBalls()
						//omegaice
				if(usr.first=="rabbit"&&usr.second=="dog"&&usr.third=="dog"&&usr.fourth=="rabbit"&&usr.fifth=="dog"&&usr.sixth=="dog"&&usr.seventh=="rabbit"&&usr.rat==0&&usr.dog==4&&usr.ox==0&&usr.dragon==0&&usr.monkey==0&&usr.snake==0&&usr.horse==0&&usr.rabbit==3)
					var/obj/Jutsus/Omega_Ice_Ball/J=new/obj/Jutsus/Omega_Ice_Ball
					if(J.type in usr.jutsus_learned)
						if(genintesters.Find(src)) SealsDoneGenin++
						usr.Omega_Ice_Ball()


				if(usr.SealCount)
					view(usr)<<sound('active.wav',0,0)
					usr.SealVarReset()
					usr.Target_ReAdd()