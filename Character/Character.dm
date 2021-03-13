mob
	verb
		Say(msg as text)
			set hidden=1
			winset(src, null, {"
				Main.MapChild.focus = "true";
				Main.InputChild.is-visible = false;
			"})

			var/message_trim

			if(!msg) return

			if(src.Muted)
				src << "You are currently muted."
				return

			else if(length(msg) > 600)
				message_trim = copytext(msg, 600)
				msg = copytext(msg, 1, 600)

			if(findtext(msg, "/stuck"))
				src.Stuck()
				return

			else if(findtext(msg, "/mute"))
				src.Vote_Mute()
				return

			else if(findtext(msg, "/boot"))
				src.Vote_Boot()
				return

			else if(findtext(msg, "/world"))
				src << output("World Address: byond://[world.internet_address]:[world.port]", "ActionPanel.Output")
				return

			else if(findtext(msg, "/help"))
				src.Help()
				return

			else
				var/obj/Symbols/Village/V = new(src)
				var/obj/Symbols/Rank/R = new(src)
				var/obj/Symbols/Role/role
				if(src.client.ckey in administrators)
					role=new(ADMINISTRATOR)

				else if(src.client.ckey in moderators)
					role=new(MODERATOR)

				var/whisper = winget(src, "InputPanel.WhisperInput", "text")
				if(whisper)
					if(src.name == whisper)
						src << "You cannot whisper to yourself. Try speaking in global chat to make some new friends."
						return

					var/whisper_target_online = 0
					for(var/mob/M in TotalPlayers)
						if(whisper == M.name)
							src << "\[W] \icon[V] \icon[R] <font color='[src.namecolor]'>[src.name]</font>: [msg]"
							M << "\[W] \icon[V] \icon[R] <font color='[src.namecolor]'>[src.name]</font>: [msg]"
							whisper_target_online = 1
							break

					if(!whisper_target_online)
						src << "You cannot whisper <i>[whisper]</i> because they're no longer online or the character doesn't exist."

				else if(src.likeaclone)
					if(src.client.channel == "Local")
						var/mob/clone = src.likeaclone
						view(clone) << ffilter("\icon[V] \icon[R] <font color='[clone.namecolor]'>[clone.name]</font>: <font color='[clone.chatcolor]'>[html_encode(msg)]</font>")
					else
						src << "Clones can only speak within the say channel."

				else
					switch(src.client.channel)
						if("Local")
							view() << ffilter("\icon[role] \icon[V] \icon[R] <font color='[src.namecolor]'>[src.name]</font>: <font color='[src.chatcolor]'>[html_encode(msg)]</font>")

						if("Village")
							for(var/mob/M in TotalPlayers)
								if(src.village == M.village || M.admin)
									M << ffilter("<font color='yellow'>\[V]</font> \icon[V] \icon[R] <font color='[src.namecolor]'>[src.name]</font>: <font color='[src.chatcolor]'>[html_encode(msg)]</font>")

						if("Squad")
							if(src.Squad)
								for(var/mob/M in TotalPlayers)
									if(M.ckey == src.Squad.Leader || src.Squad.Members.Find(M.ckey))
										M << ffilter("<font color='white'>\[S]</font> \icon[V] \icon[R] <font color='[src.namecolor]'>[src.name]</font>: <font color='[src.chatcolor]'>[html_encode(msg)]</font>")
							else
								src << "You cannot speak in the squad channel because you are not currently in a squad."

						if("Faction")
							if(src.Faction)
								var/Faction/F = src.Faction
								for(var/mob/M in TotalPlayers)
									if(src.Faction == M.Faction || M.admin)
										M << ffilter("<font color='[F.color]'>\[F] [F.name]</font> \icon[V] \icon[R] <font color='[src.namecolor]'>[src.name]</font>: <font color='[src.chatcolor]'> [html_encode(msg)]</font>")

							else
								src << "You cannot speak in the faction channel because you are not currently in a faction."

						if("Global")
							if(worldmute)
								src << "You cannot speak in the global channel because it is currently muted."
							else
								world << ffilter("<font color='red'>\[G]</font> \icon[V] \icon[R] <font color='[src.namecolor]'>[src.name]</font>: <font color='[src.chatcolor]'>[html_encode(msg)]</font>")

				if(message_trim)
					src << "Your message was longer than 1000 characters and has been trimmed."
					src << "The following text was trimmed:"
					src << message_trim

	proc
		DamageOverlay(damage, color, outline=1)
			var/obj/O = locate() in damage_number_pool
			if(O)
				damage_number_pool-=O
				O.loc=src.loc
			else
				O=new(src.loc)

			O.layer = EFFECTS_LAYER
			O.maptext_width = 128
			O.maptext_height = 128
			O.pixel_y = 70
			O.pixel_x = (src.bound_width - O.maptext_width) / 2 + src.bound_x
			O.maptext = "<span style=\"-dm-text-outline: [outline]px black; color: [color]; font-family: 'Open Sans'; font-weight: bold; text-align: center; vertical-align: bottom;\">[damage]</span>"
			O.alpha = 255

			sleep(1)
			animate(O, alpha = 0, pixel_y = 102, time = 5)

			spawn(15)
				O.loc=null
				damage_number_pool += O
