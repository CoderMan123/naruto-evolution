atom
	proc
		PlayAudio(var/audio_file, var/audio_repeat = 0, var/audio_wait = 0, var/audio_channel = 0, var/output = AUDIO_SELF)
			if(audio_file)
				switch(output)
					if(AUDIO_SELF)
						var/mob/m = src
						if(ismob(m) && m.client)
							m << sound(audio_file, audio_repeat, audio_wait, audio_channel, m.client.sound_level_sfx)
					
					if(AUDIO_HEARERS)
						spawn()
							for(var/mob/m in hearers(src))
								if(m.client) m << sound(audio_file, audio_repeat, audio_wait, audio_channel, m.client.sound_level_sfx)