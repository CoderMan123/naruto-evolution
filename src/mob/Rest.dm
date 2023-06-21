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
			if(src.dead==0&&src.rest==1)
				if(CheckState(src, new/state/recently_hit) || CheckState(src, new/state/cant_attack) || src.Intang)
					RestUp()
					return
				usr.icon_state="jutsuse"
				if(!CheckState(src, new/state/resting))
					AddState(src, new/state/resting, -1)
				var/turf/T = usr.loc
				sleep(2)
				if(src.wait<2)src.wait+=1
				src.icon_state=""
				if(usr.loc==T && usr.rest)usr.Resting()
				else usr.RestUp()
	proc
		RestSound()
			if(CheckState(src, new/state/cant_attack) &&src.dead==0&&src.rest==1)
				if(CheckState(src, new/state/recently_hit))
					RestUp()
					return
				if(src.maxchakra<=500)
					src.PlayAudio('Skills/Powerup.ogg', output = AUDIO_HEARERS)
					spawn(13)if(src)src.RestSound()
				if(src.maxchakra<=1000&&chakra>500)
					src.PlayAudio('Skills/Powerup2.ogg', output = AUDIO_HEARERS)
					spawn(14)if(src)src.RestSound()
				if(src.maxchakra<10000&&chakra>1000)
					src.PlayAudio('Skills/Powerup3.ogg', output = AUDIO_HEARERS)
					spawn(14)if(src)src.RestSound()
				if(maxchakra>10000)
					src.PlayAudio('Skills/Powerup4.ogg', output = AUDIO_HEARERS)
					spawn(13)if(src)src.RestSound()
	verb
		Rest()
			set hidden=1
			if(CheckState(usr, new/state/knocked_down)) return 0
			src.HengeUndo()
			if(!usr.Intang && !CheckState(usr, new/state/cant_attack) && !CheckState(usr, new/state/cant_move) && !CheckState(usr, new/state/swimming) && usr.dead==0 && usr.rest==0)
				if(CheckState(usr, new/state/recently_hit))
					RestUp()
					return
/*				if(src.Gates==null)
					usr.healthregenmod+=*/
				usr.wait=0
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
				sleep(2)
				if(usr.loc==T&&!CheckState(src, new/state/recently_hit))usr.Resting()
				else usr.RestUp()
								
		RestUp()
			set hidden=1
			if(usr.rest)
				src.PlayAudio('Skills/Blank.ogg', output = AUDIO_HEARERS)
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
				usr.rest=0
				RemoveState(src, new/state/resting, STATE_REMOVE_ALL)
mob/var/RestOverlays=0

