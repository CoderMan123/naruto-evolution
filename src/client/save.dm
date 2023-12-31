client/var/savefile_version = 1

client
	proc/Save()
		var/savefile/F = new("[SAVEFILE_CLIENT]/[copytext(src.ckey, 1, 2)]/[src.ckey].sav")
		#ifdef DEBUG_SAVEFILE
		text2file("[time2text(world.realtime, "YYYY/MM/DD hh:mm:ss")] (Write)<br />", LOG_CLIENT_SAVES)
		text2file("\[O]: [F]...<br />", LOG_CLIENT_SAVES)
		#endif
		if(src.Write(F)) return 1
		else return 0

	proc/Load()
		var/savefile/F = new("[SAVEFILE_CLIENT]/[copytext(src.ckey, 1, 2)]/[src.ckey].sav")
		#ifdef DEBUG_SAVEFILE
		text2file("[time2text(world.realtime, "YYYY/MM/DD hh:mm:ss")] (Read)<br />", LOG_CLIENT_SAVES)
		text2file("\[O]: [F]...<br />", LOG_CLIENT_SAVES)
		#endif
		if(src.Read(F)) return 1
		else return 0


	proc/Write(savefile/F)
		if(src)
			var/list/exclude = list("gender")
			for(var/v in src.vars)
				if(issaved(src.vars[v]))
					if(initial(src.vars[v]) == src.vars[v])
						F.dir.Remove(v)
						#ifdef DEBUG_SAVEFILE
						text2file("\[W]: \[RM]: \[initial()]:  [v] = [src.vars[v]]<br />", LOG_CLIENT_SAVES)
						#endif
					else if(exclude.Find(v))
						F.dir.Remove(v)
						#ifdef DEBUG_SAVEFILE
						text2file("\[W]: \[RM]: \[exclude.Find()]:  [v] = [src.vars[v]]<br />", LOG_CLIENT_SAVES)
						#endif
					else
						F[v] << src.vars[v]
						#ifdef DEBUG_SAVEFILE
						text2file("\[W]: [v] = [src.vars[v]]<br />", LOG_CLIENT_SAVES)
						#endif
				else
					F.dir.Remove(v)
					#ifdef DEBUG_SAVEFILE
					text2file("\[W]: \[RM]: \[!issaved()]:  [v] = [src.vars[v]]<br />", LOG_CLIENT_SAVES)
					#endif

			F["savefile_version"] << savefile_version
			#ifdef DEBUG_SAVEFILE
			text2file("\[C]: [F]<br /><br />", LOG_CLIENT_SAVES)
			#endif

		else
			#ifdef DEBUG_SAVEFILE
			text2file("\[E]: \[W]: null client when attempting to write to savefile.<br />", LOG_CLIENT_SAVES)
			text2file("\[C]: [F]<br /><br />", LOG_CLIENT_SAVES)
			#endif
			return 0
		..()


	proc/Read(savefile/F)
		if(src)
			var/list/exclude = list("gender")
			if(fexists("[F]"))
				for(var/v in src.vars)
					if(issaved(src.vars[v]))
						if(!isnull(F[v]))
							F[v] >> src.vars[v]
							#ifdef DEBUG_SAVEFILE
							text2file("\[R]: [v] = [src.vars[v]]<br />", LOG_CLIENT_SAVES)
							#endif
						else if(exclude.Find(v))
							F.dir.Remove(v)
							#ifdef DEBUG_SAVEFILE
							text2file("\[R]: \[RM]: \[exclude.Find()]:  [v] = [src.vars[v]]<br />", LOG_CLIENT_SAVES)
							#endif
						else
							F.dir.Remove(v)
							#ifdef DEBUG_SAVEFILE
							text2file("\[R]: \[RM]: \[isnull()]:  [v] = [src.vars[v]]<br />", LOG_CLIENT_SAVES)
							#endif

				#ifdef DEBUG_SAVEFILE
				text2file("\[C]: [F]<br /><br />", LOG_CLIENT_SAVES)
				#endif
			else
				#ifdef DEBUG_SAVEFILE
				text2file("\[E]: \[R]: A client savefile doesn't exist.<br />", LOG_CLIENT_SAVES)
				#endif
				return 0
		else
			#ifdef DEBUG_SAVEFILE
			text2file("\[E]: \[R]: null client when attempting to read from savefile.<br />", LOG_CLIENT_SAVES)
			text2file("\[C]: [F]<br /><br />", LOG_CLIENT_SAVES)
			#endif
			return 0
		..()
		winset(src, "Settings-Audio.BGM", "value = '[src.sound_level_bgm]'")
		winset(src, "Settings-Audio.SFX", "value = '[src.sound_level_sfx]'")