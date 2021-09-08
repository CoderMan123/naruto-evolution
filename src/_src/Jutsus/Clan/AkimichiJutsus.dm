mob
	proc
		GreenPill()
			if(firing)return
			if(src.firing==0 && src.canattack==1)
				for(var/obj/Jutsus/GreenPill/J in src.jutsus)
					if(src.PreJutsu(J))
						if(src.ingpill==1) return
						if(loc.loc:Safe!=1) src.LevelStat("Strength",((J.maxcooltime*3/10)*jutsustatexp))
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
				for(var/obj/Jutsus/YellowPill/J in src.jutsus)
					if(src.PreJutsu(J))
						if(src.inypill==1) return
						if(loc.loc:Safe!=1) src.LevelStat("Strength",((J.maxcooltime*3/10)*jutsustatexp))
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
				for(var/obj/Jutsus/RedPill/J in src.jutsus)
					if(src.PreJutsu(J))
						if(src.inrpill==1) return
						if(loc.loc:Safe!=1) src.LevelStat("Strength",((J.maxcooltime*3/10)*jutsustatexp))
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
				for(var/obj/Jutsus/HumanBulletTank/J in src.jutsus)
					if(src.PreJutsu(J))
						if(src.inboulder==1) return
						if(loc.loc:Safe!=1) src.LevelStat("Strength",((J.maxcooltime*3/20)*jutsustatexp))
						if(loc.loc:Safe!=1) src.LevelStat("Ninjutsu",((J.maxcooltime*3/20)*jutsustatexp))
						if(J.level==1) J.damage=((jutsudamage*J.Sprice)/2.5)*1.3
						if(J.level==2) J.damage=((jutsudamage*J.Sprice)/2)*1.3
						if(J.level==3) J.damage=((jutsudamage*J.Sprice)/1.5)*1.3
						if(J.level==4) J.damage=(jutsudamage*J.Sprice)*1.3
						if(loc.loc:Safe!=1) J.exp+=jutsumastery*(J.maxcooltime/20); J.Levelup()
						flick("jutsu",src)
						src.move=0
						src.canattack=0
						src.firing=1
						src.icon='AkimichiBullet.dmi'
						src.overlays=0
						src.inboulder=1
						var/i=0
						var/lastloc
						for(i=0,i<100,i++)
							lastloc = src.loc
							step(src,src.dir)
							sleep(30)
							for(var/mob/M in orange(1,src))
								if(M == src) continue
								if(M.dead || M.swimming) continue
								if(src.loc == lastloc) continue
								M.DealDamage(round((src.ninjutsu / 300)+(src.strength / 300)*2*J.damage)/12,src,"NinBlue")
								if(M.henge==4||M.henge==5)M.HengeUndo()
								M.icon_state="dead"
								M.move=0
								M.injutsu=1
								M.canattack=0
								spawn(5)
									if(M||!M.dead)
										M.icon_state=""
										M.move=1
										M.injutsu=0
										M.canattack=1
						src.inboulder=0
						src.canattack=1
						src.firing=0
						src.move=1
						src.RestoreOverlays()
						src.ResetBase()

		CalorieControl()
			if(firing)return
			if(src.firing==0 && src.canattack==1)
				for(var/obj/Jutsus/CalorieControl/J in src.jutsus)
					if(src.PreJutsu(J))
						if(src.incalorie==1) return
						if(loc.loc:Safe!=1) src.LevelStat("Strength",((J.maxcooltime*3/10)*jutsustatexp))
						flick("jutsu",src)
						if(J.level==1) J.damage=10
						if(J.level==2) J.damage=20
						if(J.level==3) J.damage=30
						if(J.level==4) J.damage=40
						if(J.level<4) if(loc.loc:Safe!=1) J.exp+=jutsumastery*(J.maxcooltime/20); J.Levelup()
						src.strength+=J.damage
						src.underlays+='AkimichiWings.dmi'
						src.incalorie=1
						spawn(300)
							src.strength-=J.damage
							src.incalorie=0
							src.underlays-='AkimichiWings.dmi'

		SuperMultiSizeTechnique()//multisizestuff
			if(firing)return
			if(src.firing==0 && src.canattack==1)
				for(var/obj/Jutsus/SuperMultiSizeTechnique/J in src.jutsus)
					if(src.inrpill==1 || src.incalorie==1)
						if(src.PreJutsu(J))
							if(loc.loc:Safe!=1) src.LevelStat("Strength",((J.maxcooltime*3/10)*jutsustatexp))
							if(J.level<4) if(loc.loc:Safe!=1) J.exp+=jutsumastery*(J.maxcooltime/20); J.Levelup()
							var/matrix/m = matrix()
							src.appearance_flags = PIXEL_SCALE | KEEP_TOGETHER
							m.Scale(6,6)
							m.Translate(0,176)
							src.transform = m
							src.bound_height=96
							src.bound_width=96
							src.bound_x=-32
							src.layer=MOB_LAYER+1
							src.overlays+='Dust.dmi'
							src.RestoreOverlays()
							src.multisized=1
							src.SetName(src.name)
							sleep(60+(10*J.level))
							src.appearance_flags = PIXEL_SCALE | KEEP_TOGETHER
							m.Translate(0,-176)
							m.Scale(1/6,1/6)
							src.transform = m
							src.bound_height=32
							src.bound_width=32
							src.bound_x=null
							src.layer=MOB_LAYER
							src.multisized=0
							src.RestoreOverlays()
							src.icon_state="dead"
							src.move=0
							src.injutsu=1
							src.canattack=0
							src.SetName(src.name)
							spawn(20)
								if(!src||src.dead)continue
								src.icon_state=""
								src.move=1
								src.injutsu=0
								src.canattack=1

