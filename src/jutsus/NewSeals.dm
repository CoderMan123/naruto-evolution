mob
	proc
		SealVarReset()
			src.rat = 0
			src.ox = 0
			src.dragon = 0
			src.monkey = 0
			src.snake = 0
			src.horse = 0
			src.rabbit = 0
			src.dog = 0
			src.first = 0
			src.second = 0
			src.third = 0
			src.fourth = 0
			src.fifth = 0
			src.sixth = 0
			src.seventh = 0
			src.eighth = 0
			src.HandSeals = 0
			src.SealCount = 0
			src.HandSigning = 0
			src.SealCounting = 0
			src.Target_ReAdd()//usr to src
			spawn()
				usr.client.images = 0
				usr.Target_ReAdd()

		SealResetTimer()
			while(src.HandSigning)
				src.HandSigning --
				sleep(10)
				if(src.HandSigning <= 1)
					SealVarReset()
					//Target_ReAdd() included in sealvar
					break

		SealHandler(sign)
			set hidden = 1
			if(CheckState(src, new/state/knocked_down)) return 0
			if(!src.dead && !src.multisized && !CheckState(src, new/state/cant_attack) && !CheckState(src, new/state/swimming))
				if(src.SealCount < 12)
					src.SealCount ++
					switch(src.SealCount)
						if(1)
							src.first = "[sign]"
						if(2)
							src.second = "[sign]"
						if(3)
							src.third = "[sign]"
						if(4)
							src.fourth = "[sign]"
						if(5)
							src.fifth = "[sign]"
						if(6)
							src.sixth = "[sign]"
						if(7)
							src.seventh = "[sign]"
						if(8)
							src.eighth = "[sign]"
						if(9)
							src.nineth = "[sign]"
						if(10)
							src.tenth = "[sign]"
						if(11)
							src.eleventh = "[sign]"
						if(12)
							src.twelveth = "[sign]"
					switch(sign)
						if("rat")
							src.rat ++
						if("dragon")
							src.dragon ++
						if("snake")
							src.snake ++
						if("dog")
							src.dog ++
						if("horse")
							src.horse ++
						if("monkey")
							src.monkey ++
						if("rabbit")
							src.rabbit ++
						if("ox")
							src.ox ++
					src.PlayAudio('switsh.wav', output = AUDIO_HEARERS)
					flick("jutsu",usr)
					for(var/mob/Clones/C in src.Clones)
						flick("jutsu",C)
					spawn()
						usr.client.images=null
						usr.Target_ReAdd()
						var/obj/HSign = image('HandSigns.dmi',usr,icon_state="[sign]",layer=99)
						HSign.pixel_y=98
						usr<<HSign
					src.HandSigning = 5
					if(src.SealCounting == 0)
						src.SealCounting = 1
						src.SealResetTimer()


	verb
		HandSeal(Seal as text)
			set instant = 1
			set hidden = 1
			SealHandler("[Seal]")