mob
	proc
		Death_Ruling_Possesion_Blood()
			for(var/obj/Jutsus/Death_Ruling_Possesion_Blood/J in src.jutsus)

				var/checks=0
				for(var/obj/O in src.loc)
					if(O.icon == 'blood effects.dmi'&&O.Owner)
						checks=O
						break
				if(checks==0)
					src << output("This jutsu requires you to be standing on blood.","Action.Output")
					return
				if(src.PreJutsu(J))
					if(loc.loc:Safe!=1) src.LevelStat("Defence",((J.maxcooltime*3/10)*jutsustatexp))
					var/obj/JashinSymbol/O=new(src)
					O.Owner=src
					O.JashinConnected=checks:Owner

		Immortality()
			for(var/obj/Jutsus/Immortality/J in src.jutsus)
				if(src.PreJutsu(J))
					if(src.needkill) return
					if(loc.loc:Safe!=1) src.LevelStat("Defence",((J.maxcooltime*3/10)*jutsustatexp))
					if(J.level<4) if(loc.loc:Safe!=1) J.exp+=jutsumastery*(J.maxcooltime/20); J.Levelup()
					src.needkill=1
					src << output("<b>Kill someone within twenty seconds and you will be awarded with immortality for a short amount of time.","Action.Output")
					var/sactimer = 20
					while(needkill==1 && sactimer>=1)
						sleep(10)
						sactimer--
						if(src)
							if(src.needkill==2)
								var/immortime = (75*J.level)/10
								view(src) << output("<b>Jashin accepted your sacrifice! You're immortal for the next [immortime] seconds! ","Action.Output")
								src.immortal = 1
								src.JashinSacrifices++
								spawn(immortime*10)
									src << output("<b>Your immortality has worn off.","Action.Output")
									src.immortal=0
									src.needkill=0
							if(sactimer==0)
								src << output("<b>You couldn't make a sacrifice in time..","ActionPanel.Output")
								src.needkill=0

		Immortal()
			for(var/obj/Jutsus/Immortal/J in src.jutsus)

				if(src.needkill)
					src << output("You are using Immortality already. This jutsu will only be available once Immortality wears off.","Action.Output")
					return
				if(src.PreJutsu(J))
					if(loc.loc:Safe!=1) src.LevelStat("Defence",((J.maxcooltime*3/10)*jutsustatexp))
					if(src.JashinSacrifices>=50)
						src.immortal=1
						src << output("<b>Glory to Jashin! You gain 15 seconds of Immortality!","Action.Output")
						spawn(150)
							src << output("<b>Your immortality has worn off.","Action.Output")
							src.immortal=0
					else
						src << output("<b>The Jashin god needs more Sacrifices. You currently have [JashinSacrifices] of them. Once you reach 50, the jutsu will become available.","Action.Output")
