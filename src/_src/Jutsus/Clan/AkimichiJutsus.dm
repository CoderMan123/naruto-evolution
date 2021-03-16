mob
	proc
		GreenPill()
			if(firing)return
			if(src.firing==0 && src.canattack==1)
				for(var/obj/Jutsus/GreenPill/J in src.JutsusLearnt)
					if(src.PreJutsu(J))
						if(src.ingpill==1) return
						if(loc.loc:Safe!=1) src.LevelStat("Ninjutsu",rand(5,10))
						src.strength+=15
						src.DealDamage(src.maxhealth/5,src,"black")
						src.ingpill=1
						spawn(200)
							src.ingpill=0
							src<<"\green Your Green Pill Effect wears off..."
							src.strength-=15

		YellowPill()
			if(firing)return
			if(src.firing==0 && src.canattack==1)
				for(var/obj/Jutsus/YellowPill/J in src.JutsusLearnt)
					if(src.PreJutsu(J))
						if(src.inypill==1) return
						if(loc.loc:Safe!=1) src.LevelStat("Ninjutsu",rand(5,10))
						src.strength+=25
						src.DealDamage(src.maxhealth/3.5,src,"black")
						src.inypill=1
						spawn(200)
							src.inypill=0
							src<<"\yellow Your Yellow Pill Effect wears off..."
							src.strength-=25

		RedPill()
			if(firing)return
			if(src.firing==0 && src.canattack==1)
				for(var/obj/Jutsus/RedPill/J in src.JutsusLearnt)
					if(src.PreJutsu(J))
						if(src.inrpill==1) return
						if(loc.loc:Safe!=1) src.LevelStat("Ninjutsu",rand(5,10))
						src.strength+=40
						src.DealDamage(src.maxhealth/2.4,src,"black")
						src.inrpill=1
						src.JutsuCoolSlot(J)
						spawn(200)
							src.inrpill=0
							src<<"\red Your Red Pill Effect wears off..."
							src.strength-=40

		HumanBulletTank()
			if(firing)return
			if(src.firing==0 && src.canattack==1)
				for(var/obj/Jutsus/HumanBulletTank/J in src.JutsusLearnt)
					if(src.PreJutsu(J))
						if(src.inboulder==1) return
						if(loc.loc:Safe!=1) src.LevelStat("strength",rand(9,11))
						flick("jutsu",src)
						var/iicon
						src.canattack=0
						src.firing=1
						iicon=src.icon
						src.icon='AkimichiBullet.dmi'
						src.overlays=0
						src.inboulder=1
						spawn(100)
							src.canattack=1
							src.firing=0
							src.inboulder=0
							src.icon=iicon
							src.RestoreOverlays()

		CalorieControl()
			if(firing)return
			if(src.firing==0 && src.canattack==1)
				for(var/obj/Jutsus/CalorieControl/J in src.JutsusLearnt)
					if(src.PreJutsu(J))
						if(src.incalorie==1) return
						if(loc.loc:Safe!=1) src.LevelStat("strength",rand(15,30))
						flick("jutsu",src)
						if(J.level==1) J.damage=10
						if(J.level==2) J.damage=20
						if(J.level==3) J.damage=30
						if(J.level==4) J.damage=40
						if(J.level<4) if(loc.loc:Safe!=1) J.exp+=rand(5,10); J.Levelup()
						src.strength+=J.damage
						src.underlays+='AkimichiWings.dmi'
						src.incalorie=1
						spawn(300)
							src.strength-=J.damage
							src.incalorie=0
							src.underlays-='AkimichiWings.dmi'
