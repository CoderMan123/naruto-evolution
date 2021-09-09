mob
	var/tmp/shielded=0
	var/tmp/Gates
	var/tmp/GateTime
	var/tmp/GateStopped
	var/tmp/mystical_palms=0//Probably should add a technique for this.
	proc
		gatestop()
			if(Gates)
				src.GateStopped = 1
				src.Gates = null
				src.GateTime = 0
				src.healthregenmod=1
				ResetBase()
				//src.icon ='WhiteMBase.dmi'
				for(var/obj/Jutsus/EightGates/J in src.jutsus)
					while(J.Excluded)
						sleep(1)
					J.Excluded = 1
					spawn(250)
						J.Excluded = 0
						src.GateStopped = 0
					view(src)<<output("<font color=[colour2html("red")]><b>[src] looks exhausted! They can't use gates for 25 seconds!","Action.Output")
				for(var/obj/O in LinkFollowers)
					if(O)
						del(O)
		CSstop()
			src.CS=0
			src.icon_state=riconstate
			for(var/obj/O in LinkFollowers)if(O)del(O)
		CMs()
			//src.cm=0
			src.icon_state=riconstate
			for(var/obj/O in LinkFollowers)if(O)del(O)

		// Check if gates can be used and pass the jutsu's level.
		Gates()
			for(var/obj/Jutsus/EightGates/J in src.jutsus)
				if(src.PreJutsu(J))
					src.GatesIncrease(J.level)

		// Check which gate they're in and go up if possible.
		GatesIncrease(var/GateLevel)
			if(!GateStopped)
				if(!src.Gates && GateLevel >= 1)
					spawn()
						src.GateLoop()
					src.ActivateGate(1)
				else
					if(GateLevel < 2)
						src.gatestop()
						return
					if(src.Gates == 1 && GateLevel >= 2)
						src.ActivateGate(2)
					else
						if(GateLevel < 3)
							src.gatestop()
							return
						if(src.Gates == 2 && GateLevel >= 3)
							src.ActivateGate(3)
						else
							if(GateLevel < 4)
								src.gatestop()
								return
							if(src.Gates == 3 && GateLevel >= 4)
								src.ActivateGate(4)
							else
								if(GateLevel < 5)
									src.gatestop()
									return
								if(src.Gates == 4 && GateLevel >= 5)
									src.ActivateGate(5)
								else
									if(src.Gates == 5)
										src.gatestop()
										return
							/*else                                  // activating these is up to you
								if(src.Gates == 5 && GateLevel >= 6)
									src.ActivateGate(6)
								else
									if(src.Gates == 6 && GateLevel >= 7)
										src.ActivateGate(7)
									else
										if(src.Gates == 7 && GateLevel >= 8)
											src.ActivateGate(8)*/

		GateLoop()
			while(src.Gates && src.GateTime && !GateStopped)
//				src.DealDamage((src.maxhealth * 0.004) * src.Gates, src, "black")
				src.healthregenmod=0
				sleep(10)
				if(src.Gates && src.GateTime && !GateStopped)
					src.GateTime --
			//src << output("gatestop check","Action.Output")
			if(!GateStopped)
				//src << output("gatestop looped","Action.Output")
				src.gatestop()

		// Define what each gate does here.
		ActivateGate(var/GateNum)
			src.GateTime = 100
			switch(GateNum)
				if(1)
					var/obj/O2 = new/obj
					O2.loc=src.loc
					O2.icon = 'Dust.dmi'
					O2.layer=MOB_LAYER+1
					O2.pixel_x=-34
					O2.icon_state="smoke"
					spawn(5)
						if(O2)
							del(O2)
				if(2)
					var/obj/O = new/obj
					O.loc=loc
					O.linkfollow(src)
					var/obj/O2 = new/obj
					O2.loc=loc
					O2.icon = 'Dust.dmi'
					O2.pixel_x = -34
					O2.layer = MOB_LAYER+1
					O2.icon_state = "smoke2"
					spawn(5)
						if(O2)
							del(O2)
				if(3)
					src.icon = 'Gate Base.dmi'
					var/obj/O2 = new/obj
					O2.loc=loc
					O2.layer=MOB_LAYER+1
					O2.pixel_x=-34
					O2.icon = 'Dust.dmi'
					O2.icon_state="smoke3"
					spawn(5)
						if(O2)
							del(O2)
				if(4)
					var/obj/O = new/obj
					O.layer = MOB_LAYER-1
					O.icon = 'gate green aura.dmi'
					O.loc = loc
					O.pixel_x = -16
					O.linkfollow(src)
					var/obj/O2 = new/obj
					O2.icon = 'Dust.dmi'
					O2.layer = MOB_LAYER+1
					O2.pixel_x = -34
					O2.loc = loc
					O2.icon_state = "smoke3"
					spawn(5)
						if(O2)
							del(O2)
				if(5)
					var/obj/O = new/obj
					O.layer = MOB_LAYER+1
					O.icon = 'gate 3 effect.dmi'
					O.loc = loc
					O.pixel_x = -16
					O.linkfollow(src)
					var/obj/O2 = new/obj
					O2.icon = 'Dust.dmi'
					O2.pixel_x = -34
					O2.layer = MOB_LAYER+1
					O2.loc = loc
					O2.icon_state = "smokemax"
					spawn(5)
						if(O2)
							del(O2)
				//if(6) // adding these 3 are up to you
				//if(7)
				//if(8)
			src.Gates = GateNum
			src.DealDamage((src.maxhealth * 0.01) * src.Gates, src, "maroon")

// I commented out the old gate procs instead of deleting them, just in case you want them for something.
/*		Gate_1()
			if(move&&src.gates[1])
				src.gatestop()
				return
			if(move&&!src.gates[1])
				usr.DealDamage(health/10,src,"black")
				src.gates[1]=1
				var/obj/O2 = new/obj
				O2.loc=src.loc
				O2.icon = 'Dust.dmi'
				O2.layer=MOB_LAYER+1
				O2.pixel_x=-34
				O2.icon_state="smoke"
				spawn(5)del(O2)
				spawn(300)if(src&&!src.gates[2])src.gatestop()
		Gate_2()
			if(move&&src.gates[2])
				src.gatestop()
				return
			if(src.move==1)
				if(!src.gates[2] && src.gates[1])
					usr.DealDamage(health/10,src,"black")
					src.gates[2]=1
					var/obj/O = new/obj
					O.loc=loc
					O.linkfollow(src)
					var/obj/O2 = new/obj
					O2.loc=loc
					O2.icon = 'Dust.dmi'
					O2.pixel_x=-34
					O2.layer=MOB_LAYER+1
					O2.icon_state="smoke2"
					spawn(5)if(O2)del(O2)
					spawn(300)
						if(!src.gates[3])
							if(O)del(O)
							if(src)src.gatestop()
		Gate_3()
			if(move&&src.gates[3])
				src.gatestop()
				return
			if(src.move==1)
				if(!src.gates[3] && src.gates[2])
					usr.DealDamage(health/10,src,"black")
					src.gates[3]=1
					var/k = src.icon
					src.icon = 'Gate Base.dmi'
					var/obj/O2 = new/obj
					O2.loc=loc
					O2.layer=MOB_LAYER+1
					O2.pixel_x=-34
					O2.icon = 'Dust.dmi'
					O2.icon_state="smoke3"
					spawn(5)if(O2)del(O2)
					spawn(300)if(src)
						src.icon = k
						if(!src.gates[4])
							src.gatestop()
		Gate_4()
			if(move&&src.gates[4])
				src.gatestop()
				return
			if(src.move==1)
				if(!src.gates[4] && src.gates[3])
					usr.DealDamage(health/10,src,"black")
					src.gates[4]=1
					var/obj/O = new/obj
					O.layer=MOB_LAYER-1
					O.icon = 'gate green aura.dmi'
					O.loc=loc
					O.pixel_x=-16
					O.linkfollow(src)
					var/obj/O2 = new/obj
					O2.icon = 'Dust.dmi'
					O2.layer=MOB_LAYER+1
					O2.pixel_x=-34
					O2.loc=loc
					O2.icon_state="smoke3"
					spawn(5)if(O2)del(O2)
					spawn(300)
						if(!src.gates[5])
							if(O)del(O)
							if(src)src.gatestop()
		Gate_5()
			if(move&&src.gates[5])
				src.gatestop()
				return
			if(src.move==1)
				if(!src.gates[5] && src.gates[4])
					usr.DealDamage(health/10,src,"black")
					src.gates[5]=1
					var/obj/O = new/obj
					O.layer=MOB_LAYER+1
					O.icon = 'gate 3 effect.dmi'
					O.loc=loc
					O.pixel_x=-16
					O.linkfollow(src)
					var/obj/O2 = new/obj
					O2.icon = 'Dust.dmi'
					O2.pixel_x=-34
					O2.layer=MOB_LAYER+1
					O2.loc=loc
					O2.icon_state="smokemax"
					spawn(5)if(O2)del(O2)
					spawn(300)
						if(O)del(O)
						if(src)src.gatestop()
*/
