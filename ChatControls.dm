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
				SayBoxChild.focus      = "false";
				SayBoxChild.is-visible      = "false";
				"})
				winset(src, null, {"
				MainWindow.Maplink.focus      = "true";
				"})
				return
			winset(usr, null, {"
				SayBoxChild.focus      = "true";
				SayBoxChild.is-visible      = "true";
			"})
			SayUp=1
	verb
		ChatBox()
			set hidden=1
			if(src.chatbox)
				src.chatbox=0
				winset(usr, null, {"
					ChatOut.focus      = "false";
					ChatOut.is-visible      = "false";
				"})
			else
				if(!src.chatbox)
					src.chatbox=1
					winset(usr, null, {"
						ChatOut.focus      = "true";
						ChatOut.is-visible      = "true";
					"})

mob/player
	verb
		say(msg as text)
			set hidden=1
			switch(village)
				if("Hidden Sand")
					namecolor="#f4a460"
				if("Hidden Leaf")
					namecolor="green"
				if("Hidden Mist")
					namecolor="cyan"
				if("Hidden Sound")
					namecolor="#7B68EE"
				if("Hidden Rock")
					namecolor="#EF7121"
				if("Seven Swordsmen")
					namecolor="#c0c0c0"
				if("Missing-Nin")
					namecolor="white"
				if("Akatsuki")
					namecolor="#dc143c"
				if("Anbu Root")
					namecolor="#31ff4d"
			var/lengtext = length(msg)
			SayUp=0
			winset(src, null, {"
				SayBoxChild.focus      = "false";
				SayBoxChild.is-visible      = "false";
			"})
			winset(src, null, {"
				MainWindow.Maplink.focus      = "true";
			"})
			if(Muted) return
			if(lengtext>300) return
			if(lengtext > 10 && !usr.admin)
				var/caps = 0
				for(var/i=1 to lengtext)
					var/l = text2ascii(msg,i)
					if(l > 64 && l < 93) caps ++
					if(l==32||l==255) lengtext --
				var/percent = 20
				switch(lengtext)
					if(0 to 3)percent = 100
					if(4 to 7)percent = 80
					if(8 to 11)percent = 60
					if(12 to 15)percent = 30
				if((100 * (caps / lengtext)) > percent)msg = lowertext(msg)
			if(findtext(msg,lowertext("/World"))==1)
				usr.WorldAddy()
				return
		//	if(findtext(msg,"/NameColor")==1)
		//		usr.ChangeNameColor()
		//		return
		//	if(findtext(msg,"/ChatColor")==1)
		//		usr.ChangeTextColor()
		//		return
			if(findtext(msg,lowertext("/Mute"))==1)
				usr.Vote_Mute()
				return
			if(findtext(msg,lowertext("/Help"))==1)
				usr.Help()
				return
			if(findtext(msg,lowertext("/Stuck"))==1)
				if(usr.xplock==1)
					usr<<"You can't do that now..."
					return
				usr.Stuck()
				return
			if(findtext(msg,lowertext("/Boot"))==1)
				usr.Vote_Boot()
				return
			if(!usr.likeaclone)
				if(msg)
					if(Channel=="Say")
						if(usr.admin) view(usr)<<"<font color=[usr.namecolor]>([usr.name]): </Font><font color=[usr.chatcolor]>[html_encode(msg)]</Font>"
						else view(usr)<<("<font color=[usr.namecolor]>([usr.name]): </Font><font color=[usr.chatcolor]>[html_encode(msg)]</Font>")
					if(Channel=="World")
						if(worldmute==1)
							return
						if(usr.admin)
							world<<"<font color=red>World-</font><font color=[usr.namecolor]>([usr.name]): </Font><font color=[usr.chatcolor]>[html_encode(msg)]</Font>"
						else
							world<<ffilter("<font color=red>World-</font><font color=[usr.namecolor]>([usr.name]): </Font><font color=[usr.chatcolor]>[html_encode(msg)]</Font>")
					if(Channel=="Squad")
						if(!Squad) return
						for(var/i in Squad.Members)
							var/mob/M=getOwner(i)
							if(!M) continue
							if(usr.admin) M<<"<font color=white>Radio-</font><font color=[usr.namecolor]>([usr.name]): </Font><font color=[usr.chatcolor]>[html_encode(msg)]</Font>"
							else M<<ffilter("<font color=white>Radio-</font><font color=[usr.namecolor]>([usr.name]): </Font><font color=[usr.chatcolor]>[html_encode(msg)]</Font>")
						var/mob/player/Leader=getOwner(Squad.Leader)
						if(usr.admin) Leader<<"<font color=white>Radio-</font><font color=[usr.namecolor]>([usr.name]): </Font><font color=[usr.chatcolor]>[html_encode(msg)]</Font>"
						else Leader<<ffilter("<font color=white>Radio-</font><font color=[usr.namecolor]>([usr.name]): </Font><font color=[usr.chatcolor]>[html_encode(msg)]</Font>")
					if(Channel=="Village")
						for(var/mob/player/M in world) if(M.village==src.village||M.admin)
							if(usr.admin) M<<"<font color=yellow>[src.village]-[src.rank]-</font><font color=[usr.namecolor]>([usr.name]): </Font><font color=[usr.chatcolor]>[html_encode(msg)]</Font>"
							else M<<ffilter("<font color=yellow>[src.village]-[src.rank]-</font><font color=[usr.namecolor]>([usr.name]): </Font><font color=[usr.chatcolor]>[html_encode(msg)]</Font>")
					if(Channel=="Faction")
						var/Faction/faction=getFaction(src.Faction)
						if(!faction) return
						for(var/mob/player/p in world)
							var/t
							if(getFaction(p.Faction) == getFaction(src.Faction)) t=1
							if(p.admin || t)
								p << ffilter("<font color = [faction.color]><b>[faction.name]-</b></font><font color=[usr.namecolor]>([usr.name]):</Font><font color=[usr.chatcolor]> [html_encode(msg)]</font>")
					if(Channel=="Whisper")
						var/Quotation=findtext(msg,"-",2)
						if(!Quotation) return
						var/Person=copytext(msg,2,Quotation)
						var/Message=copytext(msg,Quotation)
						var/mob/t
						for(var/mob/player/M in world)if(Person==M.name)t=M
						if(t)
							src<<"<b><u>You whisper:</u></b> [Message]"
							t<<"<b><u>[src] whispers:</u></b> [Message]"
						else
							src<<"Unable to find: [Person]"
							return
			else
				if(msg&&Channel=="Say")
					var/mob/SC = usr.likeaclone
					if(usr.admin) view(SC)<<"<b><font color=[usr.namecolor]>([usr.name]): </Font><font color=[usr.chatcolor]>[html_encode(msg)]</Font>"
					else view(SC)<<ffilter("<font color=[usr.namecolor]>([usr.name]): </Font><font color=[usr.chatcolor]>[html_encode(msg)]</Font>")


		ChangeChannel()
			set hidden=1
			if(Channel=="Say")
				Channel="Whisper"
				src<<"Now speaking in: [Channel]. Type a name in dashes, and then your message.."
				src<<"Example: -Username- Message"
				return
			if(Channel=="World") // World i think that that will work, but if it doenst u gotta bring it down again, if it doenst, i think i know what to do....kk
				Channel="Say"
				src<<"Now speaking in: [Channel]"
				return
			if(Squad && Channel=="Village") // Squad  Squad AND Channel is Village
				Channel="Squad"
				src<<"Now speaking in: [Channel]"
				return
			if(Channel=="Village" || Channel=="Squad") // Say -- Village or Squad
				Channel="World"
				src<<"Now speaking in: [Channel]"
				return
			if(Faction && getFaction(src.Faction))
				if(Channel=="Whisper") // Village
					Channel="Faction"
					src<<"Now speaking in: [Channel]"
					return
			if(village)
				if(Channel=="Whisper" || Channel=="Faction") // Village Village AND Channel is World
					Channel="Village"
					src<<"Now speaking in: [Channel]"
					return

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
