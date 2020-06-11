mob/player
	var/SayUp
	see_in_dark=3
	New()
		..()
		if(!src.client)src.beAI()
	verb
		Winsay()
			set hidden=1
			if(Muted)
				src<<"You're muted!"
				return
			if(SayUp)
				SayUp=0
				winset(usr, null, {"
				MainWindow.InputChild.focus      = "false";
				MainWindow.InputChild.is-visible      = "false";
				"})
				winset(src, null, {"
				MainWindow.MapChild.focus      = "true";
				"})
				return
			winset(usr, null, {"
				MainWindow.InputChild.focus      = "true";
				InputPanel.ChatInput.focus = true;
				MainWindow.InputChild.is-visible      = "true";
			"})
			SayUp=1
	verb
		ChatBox()
			set hidden=1
			if(src.chatbox)
				src.chatbox=0
				winset(usr, null, {"
					MainWindow.OutputChild.focus      = "false";
					MainWindow.OutputChild.is-visible      = "false";
				"})
			else
				if(!src.chatbox)
					src.chatbox=1
					winset(usr, null, {"
						MainWindow.OutputChild.focus      = "true";
						MainWindow.OutputChild.is-visible      = "true";
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
