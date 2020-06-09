obj
	letters
		icon='Letters.dmi'
		layer=MOB_LAYER
atom
	var/tmp/list/Names=list()
	var/colorz=rgb(0,0,0)
	var/list/FactionName=list()
	proc
		Name(text as text)
			var/colors
			if(ismob(src))
				var/mob/M=src
				switch(M.village)
					if("Hidden Sand")colors="#f4a460"
					if("Hidden Leaf")colors="green"
					if("Missing-Nin")colors="white"
					if("Akatsuki")colors="#dc143c"
					if("Seven Swordsmen")colors="#C0C0C0"
					if("Anbu Root")colors="#31ff4d"
					if("Hidden Sound")colors="#7B68EE"
					if("Hidden Mist")colors="#00FFFF"
					if("Hidden Rock")colors="#EF7121"
				//if(M.admin)colors="#FFFF00"
			if(length(text)>=21)
				text=copytext(text,1,21)
				text+="..."
			var/list/letters=list()
			var/CX
			var/OOE=(length(text))
			if(OOE%2==0)CX+=11-((length(text))/2*1)
			else CX+=12-((length(text))/2*1)
			for(var/a=1, a<length(text)+1, a++)
				letters+=copytext(text,a,a+1)
			for(var/X in letters)
				if(Names.len)
					if(Names["[X]-[CX]-[colors]"])
						src.overlays+=Names["[X]-[CX]-[colors]"]
						CX+=6
						continue
				var/obj/letters/O=new/obj/letters
				O.icon_state=X
				O.pixel_x=CX
				O.pixel_y=-25
				O.icon=O.icon-src.colorz
				if(colors)
					var/icon/I = new(O.icon)
					I.Blend(colors, ICON_MULTIPLY)
					O.icon=I
				src.Names["[X]-[CX]-[colors]"]=O
				CX+=6
				src.overlays+=O
			if(!ismob(src)) return
			var/Faction/faction=getFaction(src:Faction)
			if(faction&&faction.color)Faction("[faction.name]",faction.color)
		Faction(text as text, colors)
			text=Filter(html_encode(text))
			if(length(text)>=21)
				text=copytext(text,1,21)
				text+="..."
			var/list/letters=list()
			var/CX
			var/OOE=(length(text))
			if(OOE%2==0)CX+=11-((length(text))/2*1)
			else CX+=12-((length(text))/2*1)
			for(var/a=1, a<length(text)+1, a++)
				letters+=copytext(text,a,a+1)
			for(var/X in letters)
				if(FactionName.len)
					if(FactionName["[X]-[CX]-[colors]"])
						src.overlays+=FactionName["[X]-[CX]-[colors]"]
						CX+=6
						continue
				var/obj/letters/O=new/obj/letters
				O.icon_state=X
				O.pixel_x=CX
				O.pixel_y=-37
				O.icon=O.icon-src.colorz
				if(colors)
					var/icon/I = new(O.icon)
					I.Blend(colors, ICON_MULTIPLY)
					O.icon=I
				src.FactionName["[X]-[CX]-[colors]"]=O
				CX+=6
				src.overlays+=O
