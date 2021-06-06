obj
	Overlays
		icon='Misc Effects.dmi'
		Face
			icon_state="face"
		Chest
			icon_state="chest"
		Arm
			icon_state="arm"
		Leg
			icon_state="leg"
		Feet
			icon_state="feet"
		Dust
			icon='Dust.dmi'
			icon_state="smoke"
			pixel_x=-34
			pixel_y=3
			layer=MOB_LAYER+1
		Dust2
			icon='Dust.dmi'
			icon_state="smoke2"
			pixel_x=-34
			pixel_y=3
			layer=MOB_LAYER+1
		Dust3
			icon='Dust.dmi'
			icon_state="smoke3"
			pixel_x=-34
			pixel_y=3
			layer=MOB_LAYER+1
		Dustmax
			icon='Dust.dmi'
			icon_state="smokemax"
			pixel_x=-34
			pixel_y=3
			layer=MOB_LAYER+1
		Chakra
			icon='ChakraCharge.dmi'
			icon_state="3"
			pixel_x=-7
			layer=MOB_LAYER+1
		Chakra2
			icon='ChakraCharge.dmi'
			icon_state="3"
			pixel_x=-7
			layer=MOB_LAYER+1
		Chakra3
			icon='ChakraCharge.dmi'
			icon_state="max"
			pixel_x=-7
			layer=MOB_LAYER+1
		Chakramax
			icon='ChakraCharge.dmi'
			icon_state="3x"
			pixel_x=-7
			layer=MOB_LAYER+1
mob
	proc
		Resting()
			if(src.canattack==0&&src.dead==0&&src.rest==1&& !Gates)
				if(hit)
					RestUp()
					return
				usr.injutsu=1
				usr.icon_state="jutsuse"
				if(src.wait==2)
					if(src.chakra<>src.maxchakra)
						src.chakra+=src.maxchakra/20
						if(src.chakra>src.maxchakra)src.chakra=src.maxchakra
						src.UpdateHMB()
/*						if(src.health<>src.maxhealth)
							src.health+=src.maxchakra/20
							if(src.health>src.maxhealth)src.health=src.maxhealth
							src.UpdateHMB()*/
				var/turf/T = usr.loc
				spawn(2)
					if(src.wait<2)src.wait+=1
					src.injutsu=0
					src.icon_state=""
					if(usr.loc==T)usr.Resting()
					else usr.RestUp()
	proc
		RestSound()
			if(src.canattack==0&&src.dead==0&&src.rest==1&& !Gates)
				if(hit)
					RestUp()
					return
				if(src.maxchakra<=500)
					view(src,3) << sound('Skills/Powerup.ogg',0,0,7,100)
					spawn(13)if(src)src.RestSound()
				if(src.maxchakra<=1000&&chakra>500)
					view(src,5) << sound('Skills/Powerup2.ogg',0,0,7,100)
					spawn(14)if(src)src.RestSound()
				if(src.maxchakra<10000&&chakra>1000)
					view(src,7) << sound('Skills/Powerup3.ogg',0,0,7,100)
					spawn(14)if(src)src.RestSound()
				if(maxchakra>10000)
					view(src,7) << sound('Skills/Powerup4.ogg',0,0,7,100)
					spawn(13)if(src)src.RestSound()
	verb
		Rest()
			set hidden=1
			src.HengeUndo()
			if(injutsu) return
			if(usr.canattack==1&&usr.dead==0&&usr.rest==0&&usr.move&& !Gates)
				if(hit)
					RestUp()
					return
/*				if(src.Gates==null)
					usr.healthregenmod+=*/
				usr.wait=0
				usr.canattack=0
				if(usr.rest==0)
					if(usr.maxchakra<=500)
						usr.overlays+=/obj/Overlays/Dust
						usr.overlays+=/obj/Overlays/Chakra
						usr.RestOverlays=1
						usr.rest=1
					if(usr.maxchakra<=1000&&maxchakra>500)
						usr.overlays+=/obj/Overlays/Dust2
						usr.overlays+=/obj/Overlays/Chakra2
						usr.RestOverlays=1
						usr.rest=1
					if(usr.maxchakra<10000&&maxchakra>1000)
						usr.overlays+=/obj/Overlays/Dust3
						usr.overlays+=/obj/Overlays/Chakra3
						usr.RestOverlays=1
						usr.rest=1
					if(usr.maxchakra>=10000)
						usr.overlays+=/obj/Overlays/Dustmax
						usr.overlays+=/obj/Overlays/Chakramax
						usr.RestOverlays=1
						usr.rest=1
					if(chakra<=0)chakra=0
					if(health<=0)health=0
				spawn() usr.RestSound()
				var/turf/T = usr.loc
				spawn(2)
					if(usr.loc==T&&!hit)usr.Resting()
					else usr.RestUp()
		RestUp()
			set hidden=1
			if(usr.rest)
				view(usr,3) << sound('Skills/Blank.ogg',0,0,7,100)
/*				if(src.Gates==null)
					usr.healthregenmod-=2*/
				usr.overlays-=/obj/Overlays/Dust
				usr.overlays-=/obj/Overlays/Dust2
				usr.overlays-=/obj/Overlays/Dust3
				usr.overlays-=/obj/Overlays/Dustmax
				usr.overlays-=/obj/Overlays/Chakra
				usr.overlays-=/obj/Overlays/Chakra2
				usr.overlays-=/obj/Overlays/Chakra3
				usr.overlays-=/obj/Overlays/Chakramax
				usr.RestOverlays=0
				usr.wait=0
				usr.rest=2
				usr.canattack=2
				usr.injutsu=0
				spawn(2)
				usr.rest=0
				usr.canattack=1
mob/var/RestOverlays=0
