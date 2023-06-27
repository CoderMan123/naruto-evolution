mob
	var
		hand_seals_used = list()

	proc
		Activate_Handseals()
			set hidden = 1
			set instant = 1
			var/hand_seals
			if(client.eye==locate(10,10,4)||client.eye==locate(60,10,4)||client.eye==locate(12,43,4)||client.eye==locate(55,43,4)||usr.client.eye==locate(10,75,4)) return
			if(!src.dead && !src.multisized && !CheckState(src, new/state/cant_attack) && !CheckState(src, new/state/swimming))
				src.HengeUndo()
				for(var/x in hand_seals_used)
					hand_seals += "[x]"
				
				if(length(hand_seals_used) > 0)
					src.PlayAudio('active.wav', output = AUDIO_HEARERS)
					for(var/obj/Jutsus/jutsu in src.jutsus)
						var/jutsu_seals
						for(var/n in jutsu.hand_signs)
							jutsu_seals += "[n]"
						if(jutsu_seals == hand_seals)
							spawn() src.doslot(jutsu.name)
							if(genin_exam_participants.Find(src))
								if(!genin_exam_practical_score[src]) genin_exam_practical_score[src] = 1
								else genin_exam_practical_score[src]++
							break
				src.hand_seals_used = list()
				usr.client.images = 0
				usr.Target_ReAdd()
						

			
	verb
		Handseal_Pressed(Seal as text)
			set instant = 1
			set hidden = 1
			if(!src.dead && !src.multisized && !CheckState(src, new/state/cant_attack) && !CheckState(src, new/state/swimming))
				if(length(hand_seals_used) < 12)
					src.hand_seals_used += "[Seal]"
					src.PlayAudio('switsh.wav', output = AUDIO_HEARERS)
					flick("jutsu",src)
					for(var/mob/Clones/C in src.Clones)
						flick("jutsu",C)
					spawn()
						usr.client.images=null
						usr.Target_ReAdd()
						var/obj/HSign = image('HandSigns.dmi',usr,icon_state="[Seal]",layer=99)
						HSign.pixel_y=98
						usr<<HSign
					AddState(usr, new/state/using_handseals, 40)

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
