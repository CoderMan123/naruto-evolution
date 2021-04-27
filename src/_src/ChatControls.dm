mob
	see_in_dark=3
	New()
		..()
		if(!src.client)src.beAI()
	verb
		ChatBox()
			set hidden=1
			if(winget(src, "Main.OutputChild", "is-visible") == "false")
				winset(src, null, {"
					Main.OutputChild.focus = "true";
					Main.OutputChild.is-visible = "true";
				"})
			else
				winset(src, null, {"
					Main.OutputChild.focus = "false";
					Main.OutputChild.is-visible = "false";
				"})


mob/var/tmp/checkcuss
proc
	symbol(length as num)
		var/T
		for(var/i = 0,i < length,i++)
			T += "*"
			//T += pick("!","@","#","$","%","^","&","*")
		return T
mob
	proc
		ffilter(msg as text)
			var/txt = lowertext(msg)
			var/a
			var/out
			for(var/cuss in Badwords)
				if(findtext(txt,"[cuss]"))
					for(var/i = 1, i <= length(txt))
						a = copytext(msg, i , i+length(cuss))
						if(lowertext(a) == "[cuss]")
							a = symbol(length(cuss))
							i+= length(cuss)
							out += "[a]"
							usr.checkcuss = 1
						else
							out += copytext(msg, i, i+1)
							i ++
					msg = out
					txt = lowertext(msg)
					out = ""
			return msg
proc
	Filter(msg as text)
		var/txt = lowertext(msg)
		var/a
		var/out
		for(var/cuss in Badwords)
			if(findtext(txt,"[cuss]"))
				for(var/i = 1, i <= length(txt))
					a = copytext(msg, i , i+length(cuss))
					if(lowertext(a) == "[cuss]")
						a = symbol(length(cuss))
						i+= length(cuss)
						out += "[a]"
					else
						out += copytext(msg, i, i+1)
						i ++
				msg = out
				txt = lowertext(msg)
				out = ""
		return msg
