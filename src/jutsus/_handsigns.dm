mob
	var/hand_seals_used = list()


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
							src << hand_seals + "(handseals)"
							src << jutsu_seals + "([jutsu.name])"
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
			src << Seal
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
					//add timer that removes handseals after a duration


