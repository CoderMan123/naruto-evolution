mob
	proc
		GreenPill()
			for(var/obj/Jutsus/GreenPill/J in src.jutsus)
				if(src.PreJutsu(J))
					if(src.ingpill==1) return
					if(loc.loc:Safe!=1) src.LevelStat(SPECIALIZATION_TAIJUTSU,((J.maxcooltime*3/10)*jutsustatexp))
					src.taijutsu+=15
					src.DealDamage(src.maxhealth/5,src,"black")
					src.ingpill=1
					spawn(200)
						src.ingpill=0
						src<<"\green Your Green Pill Effect wears off..."
						src.taijutsu-=15

		YellowPill()
			for(var/obj/Jutsus/YellowPill/J in src.jutsus)
				if(src.PreJutsu(J))
					if(src.inypill==1) return
					if(loc.loc:Safe!=1) src.LevelStat(SPECIALIZATION_TAIJUTSU,((J.maxcooltime*3/10)*jutsustatexp))
					src.taijutsu+=25
					src.DealDamage(src.maxhealth/3.5,src,"black")
					src.inypill=1
					spawn(200)
						src.inypill=0
						src<<"\yellow Your Yellow Pill Effect wears off..."
						src.taijutsu-=25

		RedPill()
			for(var/obj/Jutsus/RedPill/J in src.jutsus)
				if(src.PreJutsu(J))
					if(src.inrpill==1) return
					if(loc.loc:Safe!=1) src.LevelStat(SPECIALIZATION_TAIJUTSU,((J.maxcooltime*3/10)*jutsustatexp))
					src.taijutsu+=40
					src.DealDamage(src.maxhealth/2.4,src,"black")
					src.inrpill=1
					src.JutsuCoolSlot(J)
					spawn(200)
						src.inrpill=0
						src<<"\red Your Red Pill Effect wears off..."
						src.taijutsu-=40

		HumanBulletTank()
			for(var/obj/Jutsus/HumanBulletTank/J in src.jutsus)
				if(src.PreJutsu(J))
					if(src.inboulder==1) return
					if(loc.loc:Safe!=1) src.LevelStat(SPECIALIZATION_TAIJUTSU,((J.maxcooltime*3/20)*jutsustatexp))
					if(loc.loc:Safe!=1) src.LevelStat("Ninjutsu",((J.maxcooltime*3/20)*jutsustatexp))
					if(J.level==1) J.damage=((jutsudamage*J.Sprice)/2.5)*1.3
					if(J.level==2) J.damage=((jutsudamage*J.Sprice)/2)*1.3
					if(J.level==3) J.damage=((jutsudamage*J.Sprice)/1.5)*1.3
					if(J.level==4) J.damage=(jutsudamage*J.Sprice)*1.3
					if(loc.loc:Safe!=1) J.exp+=jutsumastery*(J.maxcooltime/20); J.Levelup()
					flick("jutsu",src)

					var/state/cant_attack/humanbullettank1 = new()
					var/state/cant_move/humanbullettank2 = new()
					AddState(src, humanbullettank1, -1)
					AddState(src, humanbullettank2, -1)

					src.icon='AkimichiBullet.dmi'
					src.overlays=0
					src.inboulder=1
					var/i=0
					var/lastloc
					for(i=0,i<100,i++)
						lastloc = src.loc
						step(src,src.dir)
						sleep(0.5)
						for(var/mob/M in orange(1,src))
							if(M == src) continue
							if(M.dead) continue
							if(src.loc == lastloc) continue
							M.DealDamage(round((src.ninjutsu / 300)+(src.taijutsu / 300)*2*J.damage)/12,src,"NinBlue")
							if(M.henge==4||M.henge==5)M.HengeUndo()
							M.icon_state="dead"
							Bind(M, 5)
							spawn(5)
								if(M||!M.dead)
									M.icon_state=""
					src.inboulder=0
					RemoveState(src, humanbullettank1, STATE_REMOVE_REF)
					RemoveState(src, humanbullettank2, STATE_REMOVE_REF)
					src.RestoreOverlays()
					src.ResetBase()

		CalorieControl()
			for(var/obj/Jutsus/CalorieControl/J in src.jutsus)
				if(src.PreJutsu(J))
					if(src.incalorie==1) return
					if(loc.loc:Safe!=1) src.LevelStat(SPECIALIZATION_TAIJUTSU,((J.maxcooltime*3/10)*jutsustatexp))
					flick("jutsu",src)
					if(J.level==1) J.damage=10
					if(J.level==2) J.damage=20
					if(J.level==3) J.damage=30
					if(J.level==4) J.damage=40
					if(J.level<4) if(loc.loc:Safe!=1) J.exp+=jutsumastery*(J.maxcooltime/20); J.Levelup()
					src.taijutsu+=J.damage
					src.underlays+='AkimichiWings.dmi'
					src.incalorie=1
					spawn(300)
						src.taijutsu-=J.damage
						src.incalorie=0
						src.underlays-='AkimichiWings.dmi'

		SuperMultiSizeTechnique()//multisizestuff
			for(var/obj/Jutsus/SuperMultiSizeTechnique/J in src.jutsus)
				if(src.inrpill==1 || src.incalorie==1)
					if(src.PreJutsu(J))
						if(loc.loc:Safe!=1) src.LevelStat(SPECIALIZATION_TAIJUTSU,((J.maxcooltime*3/10)*jutsustatexp))
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
						Bind(src, 20)
						src.SetName(src.name)
						spawn(20)
							if(!src||src.dead)continue
							src.icon_state=""

