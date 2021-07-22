mob
	var/tmp/list/hbar = newlist()
obj/Screen/healthbar
	name=""
	icon='HBar.dmi'
	icon_state="100"
	layer=99
	pixel_y=69
	pixel_x=15
obj/Screen/manabar
	name=""
	icon='MBar.dmi'
	icon_state="100"
	layer=99
	pixel_y=65
	pixel_x=15
obj/Screen/Bar
	name=""
	icon='Bar.dmi'
	//icon_state="100"
	layer=999
	New(var/mob/M)
		if(!ismob(M)) return
		screen_loc = "2,[(M.YView-7)]"
		M.client.screen+=src
		src.loc=locate(0,0,0)
obj/Screen/LeafSymbol
	name=""
	icon='Bar.dmi'
	icon_state="Leaf"
	layer=9999
	New(var/mob/M)
		if(!ismob(M)) return
		screen_loc = "2,[(M.YView-7)]"
		M.client.screen+=src
		src.loc=locate(0,0,0)
obj/Screen/SandSymbol
	name=""
	icon='Bar.dmi'
	icon_state="Sand"
	layer=9999
	New(var/mob/M)
		if(!ismob(M)) return
		screen_loc = "2,[(M.YView-7)]"
		M.client.screen+=src
		src.loc=locate(0,0,0)
obj/Screen/MistSymbol
	name=""
	icon='Bar.dmi'
	icon_state="Mist"
	layer=9999
	New(var/mob/M)
		if(!ismob(M)) return
		screen_loc = "2,[(M.YView-7)]"
		M.client.screen+=src
		src.loc=locate(0,0,0)
obj/Screen/SoundSymbol
	name=""
	icon='Bar.dmi'
	icon_state="Sound"
	layer=9999
	New(var/mob/M)
		if(!ismob(M)) return
		screen_loc = "2,[(M.YView-7)]"
		M.client.screen+=src
		src.loc=locate(0,0,0)
obj/Screen/RockSymbol
	name=""
	icon='Bar.dmi'
	icon_state="Rock"
	layer=9999
	New(var/mob/M)
		if(!ismob(M)) return
		screen_loc = "2,[(M.YView-7)]"
		M.client.screen+=src
		src.loc=locate(0,0,0)
obj/Screen/MissingSymbol
	name=""
	icon='Bar.dmi'
	icon_state="Missing"
	layer=9999
	New(var/mob/M)
		if(!ismob(M)) return
		screen_loc = "2,[(M.YView-7)]"
		M.client.screen+=src
		src.loc=locate(0,0,0)
obj/Screen/AkatsukiSymbol
	name=""
	icon='Bar.dmi'
	icon_state="Akatsuki"
	layer=9999
	New(var/mob/M)
		if(!ismob(M)) return
		screen_loc = "2,[(M.YView-7)]"
		M.client.screen+=src
		src.loc=locate(0,0,0)
obj/Screen/AnbuSymbol
	name=""
	icon='Bar.dmi'
	icon_state="Anbu Root"
	layer=9999
	New(var/mob/M)
		if(!ismob(M)) return
		screen_loc = "2,[(M.YView-7)]"
		M.client.screen+=src
		src.loc=locate(0,0,0)
obj/Screen/SsmSymbol
	name=""
	icon='Bar.dmi'
	icon_state="Seven Swordsmen"
	layer=9999
	New(var/mob/M)
		if(!ismob(M)) return
		screen_loc = "2,[(M.YView-7)]"
		M.client.screen+=src
		src.loc=locate(0,0,0)
obj/Screen/WeaponSelect
	name=""
	icon='Bar.dmi'
	icon_state="blank"
	layer=9999
	New(var/mob/M)
		if(!ismob(M)) return
		screen_loc = "2,[(M.YView-7)]"
		M.client.screen+=src
		src.loc=locate(0,0,0)
obj/Screen/Health
	name=""
	icon='Health.dmi'
	icon_state="1"
	layer=9998
	New(var/mob/M)
		if(!ismob(M)) return
		screen_loc = "2,[(M.YView-7)]"
		M.client.screen+=src
		src.loc=locate(0,0,0)
obj/Screen/Chakra
	name=""
	icon='ChakraB.dmi'
	icon_state="1"
	layer=9998
	New(var/mob/M)
		if(!ismob(M)) return
		screen_loc = "2,[(M.YView-7)]"
		M.client.screen+=src
		src.loc=locate(0,0,0)
obj/Screen/EXP
	name=""
	icon='EXPB.dmi'
	icon_state="1"
	layer=9998
	New(var/mob/M)
		if(!ismob(M)) return
		screen_loc = "2,[(M.YView-7)]"
		M.client.screen+=src
		src.loc=locate(0,0,0)
mob
	proc
		UpdateBars()
			if(!src.client) return
			var/timeoff=rand(10,16)
			sleep(timeoff)
			if(src.client)
				if(LastMissionTime)LastMissionTime-=timeoff
				if(src.RestOverlays&&!rest) RestUp()
				if(!src.key)del(src)
				/*if(Gates) Why is this here?
					var/colour = colour2html("red")
					F_damage(src,src.health/20+1,colour)
					health-=src.health/20+1
					src.Death(src)*/
				for(var/obj/Screen/H in src.client.screen)
					if(istype(H, /obj/Screen/Health/))
						var/percent = round(src.health/src.maxhealth*100,1)
						switch(percent)
							if(0) H.icon = 'assets/aseprite/Healthbar/101.png'
							if(1) H.icon = 'assets/aseprite/Healthbar/100.png'
							if(2) H.icon = 'assets/aseprite/Healthbar/99.png'
							if(3) H.icon = 'assets/aseprite/Healthbar/98.png'
							if(4) H.icon = 'assets/aseprite/Healthbar/97.png'
							if(5) H.icon = 'assets/aseprite/Healthbar/96.png'
							if(6) H.icon = 'assets/aseprite/Healthbar/95.png'
							if(7) H.icon = 'assets/aseprite/Healthbar/94.png'
							if(8) H.icon = 'assets/aseprite/Healthbar/93.png'
							if(9) H.icon = 'assets/aseprite/Healthbar/92.png'
							if(10) H.icon = 'assets/aseprite/Healthbar/91.png'
							if(11) H.icon = 'assets/aseprite/Healthbar/90.png'
							if(12) H.icon = 'assets/aseprite/Healthbar/89.png'
							if(13) H.icon = 'assets/aseprite/Healthbar/88.png'
							if(14) H.icon = 'assets/aseprite/Healthbar/87.png'
							if(15) H.icon = 'assets/aseprite/Healthbar/86.png'
							if(16) H.icon = 'assets/aseprite/Healthbar/85.png'
							if(17) H.icon = 'assets/aseprite/Healthbar/84.png'
							if(18) H.icon = 'assets/aseprite/Healthbar/83.png'
							if(19) H.icon = 'assets/aseprite/Healthbar/82.png'
							if(20) H.icon = 'assets/aseprite/Healthbar/81.png'
							if(21) H.icon = 'assets/aseprite/Healthbar/80.png'
							if(22) H.icon = 'assets/aseprite/Healthbar/79.png'
							if(23) H.icon = 'assets/aseprite/Healthbar/78.png'
							if(24) H.icon = 'assets/aseprite/Healthbar/77.png'
							if(25) H.icon = 'assets/aseprite/Healthbar/76.png'
							if(26) H.icon = 'assets/aseprite/Healthbar/75.png'
							if(27) H.icon = 'assets/aseprite/Healthbar/74.png'
							if(28) H.icon = 'assets/aseprite/Healthbar/73.png'
							if(29) H.icon = 'assets/aseprite/Healthbar/72.png'
							if(30) H.icon = 'assets/aseprite/Healthbar/71.png'
							if(31) H.icon = 'assets/aseprite/Healthbar/70.png'
							if(32) H.icon = 'assets/aseprite/Healthbar/69.png'
							if(33) H.icon = 'assets/aseprite/Healthbar/68.png'
							if(34) H.icon = 'assets/aseprite/Healthbar/67.png'
							if(35) H.icon = 'assets/aseprite/Healthbar/66.png'
							if(36) H.icon = 'assets/aseprite/Healthbar/65.png'
							if(37) H.icon = 'assets/aseprite/Healthbar/64.png'
							if(38) H.icon = 'assets/aseprite/Healthbar/63.png'
							if(39) H.icon = 'assets/aseprite/Healthbar/62.png'
							if(40) H.icon = 'assets/aseprite/Healthbar/61.png'
							if(41) H.icon = 'assets/aseprite/Healthbar/60.png'
							if(42) H.icon = 'assets/aseprite/Healthbar/59.png'
							if(43) H.icon = 'assets/aseprite/Healthbar/58.png'
							if(44) H.icon = 'assets/aseprite/Healthbar/57.png'
							if(45) H.icon = 'assets/aseprite/Healthbar/56.png'
							if(46) H.icon = 'assets/aseprite/Healthbar/55.png'
							if(47) H.icon = 'assets/aseprite/Healthbar/54.png'
							if(48) H.icon = 'assets/aseprite/Healthbar/53.png'
							if(49) H.icon = 'assets/aseprite/Healthbar/52.png'
							if(50) H.icon = 'assets/aseprite/Healthbar/51.png'
							if(51) H.icon = 'assets/aseprite/Healthbar/50.png'
							if(52) H.icon = 'assets/aseprite/Healthbar/49.png'
							if(53) H.icon = 'assets/aseprite/Healthbar/48.png'
							if(54) H.icon = 'assets/aseprite/Healthbar/47.png'
							if(55) H.icon = 'assets/aseprite/Healthbar/46.png'
							if(56) H.icon = 'assets/aseprite/Healthbar/45.png'
							if(57) H.icon = 'assets/aseprite/Healthbar/44.png'
							if(58) H.icon = 'assets/aseprite/Healthbar/43.png'
							if(59) H.icon = 'assets/aseprite/Healthbar/42.png'
							if(60) H.icon = 'assets/aseprite/Healthbar/41.png'
							if(61) H.icon = 'assets/aseprite/Healthbar/40.png'
							if(62) H.icon = 'assets/aseprite/Healthbar/39.png'
							if(63) H.icon = 'assets/aseprite/Healthbar/38.png'
							if(64) H.icon = 'assets/aseprite/Healthbar/37.png'
							if(65) H.icon = 'assets/aseprite/Healthbar/36.png'
							if(66) H.icon = 'assets/aseprite/Healthbar/35.png'
							if(67) H.icon = 'assets/aseprite/Healthbar/34.png'
							if(68) H.icon = 'assets/aseprite/Healthbar/33.png'
							if(69) H.icon = 'assets/aseprite/Healthbar/32.png'
							if(70) H.icon = 'assets/aseprite/Healthbar/31.png'
							if(71) H.icon = 'assets/aseprite/Healthbar/30.png'
							if(72) H.icon = 'assets/aseprite/Healthbar/29.png'
							if(73) H.icon = 'assets/aseprite/Healthbar/28.png'
							if(74) H.icon = 'assets/aseprite/Healthbar/27.png'
							if(75) H.icon = 'assets/aseprite/Healthbar/26.png'
							if(76) H.icon = 'assets/aseprite/Healthbar/25.png'
							if(77) H.icon = 'assets/aseprite/Healthbar/24.png'
							if(78) H.icon = 'assets/aseprite/Healthbar/23.png'
							if(79) H.icon = 'assets/aseprite/Healthbar/22.png'
							if(80) H.icon = 'assets/aseprite/Healthbar/21.png'
							if(81) H.icon = 'assets/aseprite/Healthbar/20.png'
							if(82) H.icon = 'assets/aseprite/Healthbar/19.png'
							if(83) H.icon = 'assets/aseprite/Healthbar/18.png'
							if(84) H.icon = 'assets/aseprite/Healthbar/17.png'
							if(85) H.icon = 'assets/aseprite/Healthbar/16.png'
							if(86) H.icon = 'assets/aseprite/Healthbar/15.png'
							if(87) H.icon = 'assets/aseprite/Healthbar/14.png'
							if(88) H.icon = 'assets/aseprite/Healthbar/13.png'
							if(89) H.icon = 'assets/aseprite/Healthbar/12.png'
							if(90) H.icon = 'assets/aseprite/Healthbar/11.png'
							if(91) H.icon = 'assets/aseprite/Healthbar/10.png'
							if(92) H.icon = 'assets/aseprite/Healthbar/9.png'
							if(93) H.icon = 'assets/aseprite/Healthbar/8.png'
							if(94) H.icon = 'assets/aseprite/Healthbar/7.png'
							if(95) H.icon = 'assets/aseprite/Healthbar/6.png'
							if(96) H.icon = 'assets/aseprite/Healthbar/5.png'
							if(97) H.icon = 'assets/aseprite/Healthbar/4.png'
							if(98) H.icon = 'assets/aseprite/Healthbar/3.png'
							if(99) H.icon = 'assets/aseprite/Healthbar/2.png'
							if(100) H.icon = 'assets/aseprite/Healthbar/1.png'

					if(istype(H, /obj/Screen/Chakra/))
						var/percent = round(src.chakra/src.maxchakra*100,1)
						switch(percent)
							if(0) H.icon = 'assets/aseprite/Chakrabar/101.png'
							if(1) H.icon = 'assets/aseprite/Chakrabar/100.png'
							if(2) H.icon = 'assets/aseprite/Chakrabar/99.png'
							if(3) H.icon = 'assets/aseprite/Chakrabar/98.png'
							if(4) H.icon = 'assets/aseprite/Chakrabar/97.png'
							if(5) H.icon = 'assets/aseprite/Chakrabar/96.png'
							if(6) H.icon = 'assets/aseprite/Chakrabar/95.png'
							if(7) H.icon = 'assets/aseprite/Chakrabar/94.png'
							if(8) H.icon = 'assets/aseprite/Chakrabar/93.png'
							if(9) H.icon = 'assets/aseprite/Chakrabar/92.png'
							if(10) H.icon = 'assets/aseprite/Chakrabar/91.png'
							if(11) H.icon = 'assets/aseprite/Chakrabar/90.png'
							if(12) H.icon = 'assets/aseprite/Chakrabar/89.png'
							if(13) H.icon = 'assets/aseprite/Chakrabar/88.png'
							if(14) H.icon = 'assets/aseprite/Chakrabar/87.png'
							if(15) H.icon = 'assets/aseprite/Chakrabar/86.png'
							if(16) H.icon = 'assets/aseprite/Chakrabar/85.png'
							if(17) H.icon = 'assets/aseprite/Chakrabar/84.png'
							if(18) H.icon = 'assets/aseprite/Chakrabar/83.png'
							if(19) H.icon = 'assets/aseprite/Chakrabar/82.png'
							if(20) H.icon = 'assets/aseprite/Chakrabar/81.png'
							if(21) H.icon = 'assets/aseprite/Chakrabar/80.png'
							if(22) H.icon = 'assets/aseprite/Chakrabar/79.png'
							if(23) H.icon = 'assets/aseprite/Chakrabar/78.png'
							if(24) H.icon = 'assets/aseprite/Chakrabar/77.png'
							if(25) H.icon = 'assets/aseprite/Chakrabar/76.png'
							if(26) H.icon = 'assets/aseprite/Chakrabar/75.png'
							if(27) H.icon = 'assets/aseprite/Chakrabar/74.png'
							if(28) H.icon = 'assets/aseprite/Chakrabar/73.png'
							if(29) H.icon = 'assets/aseprite/Chakrabar/72.png'
							if(30) H.icon = 'assets/aseprite/Chakrabar/71.png'
							if(31) H.icon = 'assets/aseprite/Chakrabar/70.png'
							if(32) H.icon = 'assets/aseprite/Chakrabar/69.png'
							if(33) H.icon = 'assets/aseprite/Chakrabar/68.png'
							if(34) H.icon = 'assets/aseprite/Chakrabar/67.png'
							if(35) H.icon = 'assets/aseprite/Chakrabar/66.png'
							if(36) H.icon = 'assets/aseprite/Chakrabar/65.png'
							if(37) H.icon = 'assets/aseprite/Chakrabar/64.png'
							if(38) H.icon = 'assets/aseprite/Chakrabar/63.png'
							if(39) H.icon = 'assets/aseprite/Chakrabar/62.png'
							if(40) H.icon = 'assets/aseprite/Chakrabar/61.png'
							if(41) H.icon = 'assets/aseprite/Chakrabar/60.png'
							if(42) H.icon = 'assets/aseprite/Chakrabar/59.png'
							if(43) H.icon = 'assets/aseprite/Chakrabar/58.png'
							if(44) H.icon = 'assets/aseprite/Chakrabar/57.png'
							if(45) H.icon = 'assets/aseprite/Chakrabar/56.png'
							if(46) H.icon = 'assets/aseprite/Chakrabar/55.png'
							if(47) H.icon = 'assets/aseprite/Chakrabar/54.png'
							if(48) H.icon = 'assets/aseprite/Chakrabar/53.png'
							if(49) H.icon = 'assets/aseprite/Chakrabar/52.png'
							if(50) H.icon = 'assets/aseprite/Chakrabar/51.png'
							if(51) H.icon = 'assets/aseprite/Chakrabar/50.png'
							if(52) H.icon = 'assets/aseprite/Chakrabar/49.png'
							if(53) H.icon = 'assets/aseprite/Chakrabar/48.png'
							if(54) H.icon = 'assets/aseprite/Chakrabar/47.png'
							if(55) H.icon = 'assets/aseprite/Chakrabar/46.png'
							if(56) H.icon = 'assets/aseprite/Chakrabar/45.png'
							if(57) H.icon = 'assets/aseprite/Chakrabar/44.png'
							if(58) H.icon = 'assets/aseprite/Chakrabar/43.png'
							if(59) H.icon = 'assets/aseprite/Chakrabar/42.png'
							if(60) H.icon = 'assets/aseprite/Chakrabar/41.png'
							if(61) H.icon = 'assets/aseprite/Chakrabar/40.png'
							if(62) H.icon = 'assets/aseprite/Chakrabar/39.png'
							if(63) H.icon = 'assets/aseprite/Chakrabar/38.png'
							if(64) H.icon = 'assets/aseprite/Chakrabar/37.png'
							if(65) H.icon = 'assets/aseprite/Chakrabar/36.png'
							if(66) H.icon = 'assets/aseprite/Chakrabar/35.png'
							if(67) H.icon = 'assets/aseprite/Chakrabar/34.png'
							if(68) H.icon = 'assets/aseprite/Chakrabar/33.png'
							if(69) H.icon = 'assets/aseprite/Chakrabar/32.png'
							if(70) H.icon = 'assets/aseprite/Chakrabar/31.png'
							if(71) H.icon = 'assets/aseprite/Chakrabar/30.png'
							if(72) H.icon = 'assets/aseprite/Chakrabar/29.png'
							if(73) H.icon = 'assets/aseprite/Chakrabar/28.png'
							if(74) H.icon = 'assets/aseprite/Chakrabar/27.png'
							if(75) H.icon = 'assets/aseprite/Chakrabar/26.png'
							if(76) H.icon = 'assets/aseprite/Chakrabar/25.png'
							if(77) H.icon = 'assets/aseprite/Chakrabar/24.png'
							if(78) H.icon = 'assets/aseprite/Chakrabar/23.png'
							if(79) H.icon = 'assets/aseprite/Chakrabar/22.png'
							if(80) H.icon = 'assets/aseprite/Chakrabar/21.png'
							if(81) H.icon = 'assets/aseprite/Chakrabar/20.png'
							if(82) H.icon = 'assets/aseprite/Chakrabar/19.png'
							if(83) H.icon = 'assets/aseprite/Chakrabar/18.png'
							if(84) H.icon = 'assets/aseprite/Chakrabar/17.png'
							if(85) H.icon = 'assets/aseprite/Chakrabar/16.png'
							if(86) H.icon = 'assets/aseprite/Chakrabar/15.png'
							if(87) H.icon = 'assets/aseprite/Chakrabar/14.png'
							if(88) H.icon = 'assets/aseprite/Chakrabar/13.png'
							if(89) H.icon = 'assets/aseprite/Chakrabar/12.png'
							if(90) H.icon = 'assets/aseprite/Chakrabar/11.png'
							if(91) H.icon = 'assets/aseprite/Chakrabar/10.png'
							if(92) H.icon = 'assets/aseprite/Chakrabar/9.png'
							if(93) H.icon = 'assets/aseprite/Chakrabar/8.png'
							if(94) H.icon = 'assets/aseprite/Chakrabar/7.png'
							if(95) H.icon = 'assets/aseprite/Chakrabar/6.png'
							if(96) H.icon = 'assets/aseprite/Chakrabar/5.png'
							if(97) H.icon = 'assets/aseprite/Chakrabar/4.png'
							if(98) H.icon = 'assets/aseprite/Chakrabar/3.png'
							if(99) H.icon = 'assets/aseprite/Chakrabar/2.png'
							if(100) H.icon = 'assets/aseprite/Chakrabar/1.png'
					if(istype(H, /obj/Screen/EXP/))
						var/percent = round(src.exp/src.maxexp*100,1)
						switch(percent)
							if(0) H.icon = 'assets/aseprite/Expbar/101.png'
							if(1) H.icon = 'assets/aseprite/Expbar/100.png'
							if(2) H.icon = 'assets/aseprite/Expbar/99.png'
							if(3) H.icon = 'assets/aseprite/Expbar/98.png'
							if(4) H.icon = 'assets/aseprite/Expbar/97.png'
							if(5) H.icon = 'assets/aseprite/Expbar/96.png'
							if(6) H.icon = 'assets/aseprite/Expbar/95.png'
							if(7) H.icon = 'assets/aseprite/Expbar/94.png'
							if(8) H.icon = 'assets/aseprite/Expbar/93.png'
							if(9) H.icon = 'assets/aseprite/Expbar/92.png'
							if(10) H.icon = 'assets/aseprite/Expbar/91.png'
							if(11) H.icon = 'assets/aseprite/Expbar/90.png'
							if(12) H.icon = 'assets/aseprite/Expbar/89.png'
							if(13) H.icon = 'assets/aseprite/Expbar/88.png'
							if(14) H.icon = 'assets/aseprite/Expbar/87.png'
							if(15) H.icon = 'assets/aseprite/Expbar/86.png'
							if(16) H.icon = 'assets/aseprite/Expbar/85.png'
							if(17) H.icon = 'assets/aseprite/Expbar/84.png'
							if(18) H.icon = 'assets/aseprite/Expbar/83.png'
							if(19) H.icon = 'assets/aseprite/Expbar/82.png'
							if(20) H.icon = 'assets/aseprite/Expbar/81.png'
							if(21) H.icon = 'assets/aseprite/Expbar/80.png'
							if(22) H.icon = 'assets/aseprite/Expbar/79.png'
							if(23) H.icon = 'assets/aseprite/Expbar/78.png'
							if(24) H.icon = 'assets/aseprite/Expbar/77.png'
							if(25) H.icon = 'assets/aseprite/Expbar/76.png'
							if(26) H.icon = 'assets/aseprite/Expbar/75.png'
							if(27) H.icon = 'assets/aseprite/Expbar/74.png'
							if(28) H.icon = 'assets/aseprite/Expbar/73.png'
							if(29) H.icon = 'assets/aseprite/Expbar/72.png'
							if(30) H.icon = 'assets/aseprite/Expbar/71.png'
							if(31) H.icon = 'assets/aseprite/Expbar/70.png'
							if(32) H.icon = 'assets/aseprite/Expbar/69.png'
							if(33) H.icon = 'assets/aseprite/Expbar/68.png'
							if(34) H.icon = 'assets/aseprite/Expbar/67.png'
							if(35) H.icon = 'assets/aseprite/Expbar/66.png'
							if(36) H.icon = 'assets/aseprite/Expbar/65.png'
							if(37) H.icon = 'assets/aseprite/Expbar/64.png'
							if(38) H.icon = 'assets/aseprite/Expbar/63.png'
							if(39) H.icon = 'assets/aseprite/Expbar/62.png'
							if(40) H.icon = 'assets/aseprite/Expbar/61.png'
							if(41) H.icon = 'assets/aseprite/Expbar/60.png'
							if(42) H.icon = 'assets/aseprite/Expbar/59.png'
							if(43) H.icon = 'assets/aseprite/Expbar/58.png'
							if(44) H.icon = 'assets/aseprite/Expbar/57.png'
							if(45) H.icon = 'assets/aseprite/Expbar/56.png'
							if(46) H.icon = 'assets/aseprite/Expbar/55.png'
							if(47) H.icon = 'assets/aseprite/Expbar/54.png'
							if(48) H.icon = 'assets/aseprite/Expbar/53.png'
							if(49) H.icon = 'assets/aseprite/Expbar/52.png'
							if(50) H.icon = 'assets/aseprite/Expbar/51.png'
							if(51) H.icon = 'assets/aseprite/Expbar/50.png'
							if(52) H.icon = 'assets/aseprite/Expbar/49.png'
							if(53) H.icon = 'assets/aseprite/Expbar/48.png'
							if(54) H.icon = 'assets/aseprite/Expbar/47.png'
							if(55) H.icon = 'assets/aseprite/Expbar/46.png'
							if(56) H.icon = 'assets/aseprite/Expbar/45.png'
							if(57) H.icon = 'assets/aseprite/Expbar/44.png'
							if(58) H.icon = 'assets/aseprite/Expbar/43.png'
							if(59) H.icon = 'assets/aseprite/Expbar/42.png'
							if(60) H.icon = 'assets/aseprite/Expbar/41.png'
							if(61) H.icon = 'assets/aseprite/Expbar/40.png'
							if(62) H.icon = 'assets/aseprite/Expbar/39.png'
							if(63) H.icon = 'assets/aseprite/Expbar/38.png'
							if(64) H.icon = 'assets/aseprite/Expbar/37.png'
							if(65) H.icon = 'assets/aseprite/Expbar/36.png'
							if(66) H.icon = 'assets/aseprite/Expbar/35.png'
							if(67) H.icon = 'assets/aseprite/Expbar/34.png'
							if(68) H.icon = 'assets/aseprite/Expbar/33.png'
							if(69) H.icon = 'assets/aseprite/Expbar/32.png'
							if(70) H.icon = 'assets/aseprite/Expbar/31.png'
							if(71) H.icon = 'assets/aseprite/Expbar/30.png'
							if(72) H.icon = 'assets/aseprite/Expbar/29.png'
							if(73) H.icon = 'assets/aseprite/Expbar/28.png'
							if(74) H.icon = 'assets/aseprite/Expbar/27.png'
							if(75) H.icon = 'assets/aseprite/Expbar/26.png'
							if(76) H.icon = 'assets/aseprite/Expbar/25.png'
							if(77) H.icon = 'assets/aseprite/Expbar/24.png'
							if(78) H.icon = 'assets/aseprite/Expbar/23.png'
							if(79) H.icon = 'assets/aseprite/Expbar/22.png'
							if(80) H.icon = 'assets/aseprite/Expbar/21.png'
							if(81) H.icon = 'assets/aseprite/Expbar/20.png'
							if(82) H.icon = 'assets/aseprite/Expbar/19.png'
							if(83) H.icon = 'assets/aseprite/Expbar/18.png'
							if(84) H.icon = 'assets/aseprite/Expbar/17.png'
							if(85) H.icon = 'assets/aseprite/Expbar/16.png'
							if(86) H.icon = 'assets/aseprite/Expbar/15.png'
							if(87) H.icon = 'assets/aseprite/Expbar/14.png'
							if(88) H.icon = 'assets/aseprite/Expbar/13.png'
							if(89) H.icon = 'assets/aseprite/Expbar/12.png'
							if(90) H.icon = 'assets/aseprite/Expbar/11.png'
							if(91) H.icon = 'assets/aseprite/Expbar/10.png'
							if(92) H.icon = 'assets/aseprite/Expbar/9.png'
							if(93) H.icon = 'assets/aseprite/Expbar/8.png'
							if(94) H.icon = 'assets/aseprite/Expbar/7.png'
							if(95) H.icon = 'assets/aseprite/Expbar/6.png'
							if(96) H.icon = 'assets/aseprite/Expbar/5.png'
							if(97) H.icon = 'assets/aseprite/Expbar/4.png'
							if(98) H.icon = 'assets/aseprite/Expbar/3.png'
							if(99) H.icon = 'assets/aseprite/Expbar/2.png'
							if(100) H.icon = 'assets/aseprite/Expbar/1.png'
		UpdateHMB()
			if(src.client) spawn() src.client.UpdateCharacterPanel()
			if(!src.henge)
				for(var/obj/Screen/O in src.hbar)
					if(istype(O,/obj/Screen/healthbar))
						src.overlays-=O
						if(health>0)
							O.icon_state="[round(src.health/src.maxhealth*100,4)]"
						src.overlays+=O
					if(istype(O,/obj/Screen/manabar))
						src.overlays-=O
						if(chakra>0)
							O.icon_state="[round(src.chakra/src.maxchakra*100,4)]"
						src.overlays+=O

obj
	Healthbar
		icon = 'assets/aseprite/Healthbar/1.png'

