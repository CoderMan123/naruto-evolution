mob
	proc
		Death_Ruling_Possesion_Blood()
			for(var/obj/Jutsus/Death_Ruling_Possesion_Blood/J in src.JutsusLearnt)

				var/checks=0
				for(var/obj/O in src.loc)
					if(O.icon == 'blood effects.dmi'&&O.Owner)
						checks=O
						break
				if(checks==0)
					src << output("This jutsu requires you to be standing on blood.","actionoutput")
					return
				if(src.PreJutsu(J))
					if(loc.loc:Safe!=1) src.LevelStat("Ninjutsu",rand(3,5))
					var/obj/JashinSymbol/O=new(src)
					O.Owner=src
					O.JashinConnected=checks:Owner

		Immortality()
			for(var/obj/Jutsus/Immortality/J in src.JutsusLearnt)
				if(src.PreJutsu(J))
					if(src.needkill) return
					if(loc.loc:Safe!=1) src.LevelStat("Ninjutsu",rand(7,9))
					if(J.level<4) if(loc.loc:Safe!=1) J.exp+=rand(2,5); J.Levelup()
					src.needkill=1
					src << output("<b>Kill someone within twenty seconds and you will be awarded with immortality for a short amount of time.","actionoutput")
					spawn(200)
						if(src)
							if(src.needkill==2)
								view(src) << output("Sacrifice to Jashin!","actionoutput")
								src.immortal = 1
								src.JashinSacrifices++
								spawn(75*J.level)
									src << output("<b>Your immortality has expired.","actionoutput")
									src.immortal=0
							src.needkill=0

		Immortal()
			for(var/obj/Jutsus/Immortal/J in src.JutsusLearnt)

				if(src.needkill)
					src << output("You are using Immortality already. This jutsu will only be available once Immortality wears off.","actionoutput")
					return
				if(src.PreJutsu(J))
					if(loc.loc:Safe!=1) src.LevelStat("Ninjutsu",rand(7,9))
					if(src.JashinSacrifices>=150)
						src.immortal=1
						src << output("<b>Jashin is pleased with your Sacrifices ! You gain fifteen seconds of Immortality instantly.","actionoutput")
						spawn(150)
							src << output("<b>Immortality wears off.","actionoutput")
							src.immortal=0
					else
						src << output("<b>The Jashin god needs more Sacrifices. You currently have [JashinSacrifices] of them. Once you reach 150, the jutsu will become available.","actionoutput")
