mob
	proc
		FireMask()
			for(var/obj/Jutsus/FireMask/J in src.jutsus)
				if(src.PreJutsu(J))
					if(loc.loc:Safe!=1) src.LevelStat("Ninjutsu",((J.maxcooltime*3/10)*jutsustatexp))
					var/obj/Projectiles/Effects/firemask/A=new/obj/Projectiles/Effects/firemask(src.loc)
					A.dir=src.dir
					var/obj/Jutsus/AFireBall/la = new/obj/Jutsus/AFireBall()
					A.Owner=src
					src.jutsus+=la
					la.damage=300
					src.AFire_Ball()
					del(la)
					spawn(150)
						del(A)

		WindMask()
			for(var/obj/Jutsus/WindMask/J in src.jutsus)
				if(src.PreJutsu(J))
					if(loc.loc:Safe!=1) src.LevelStat("Ninjutsu",((J.maxcooltime*3/10)*jutsustatexp))
					var/obj/Projectiles/Effects/windmask/A=new/obj/Projectiles/Effects/windmask(src.loc)
					A.dir=src.dir
					var/obj/Jutsus/Sickle_Weasel_Technique/la=new/obj/Jutsus/Sickle_Weasel_Technique()
					A.Owner=src
					src.jutsus+=la
					la.damage=la.damage+round((src.precision / 300)+(src.ninjutsu / 300)*2*J.damage)
					src.Sickle_Weasel_Technique()
					del(la)
					spawn(150)
						del(A)

		LightningMask()
			for(var/obj/Jutsus/LightningMask/J in src.jutsus)
				if(src.PreJutsu(J))
					if(loc.loc:Safe!=1) src.LevelStat("Ninjutsu",((J.maxcooltime*3/10)*jutsustatexp))
					var/obj/Projectiles/Effects/lightningmask/A=new/obj/Projectiles/Effects/lightningmask(src.loc)
					A.Owner=src
					A.dir=src.dir
					var/obj/Jutsus/Kirin/la=new/obj/Jutsus/Kirin()
					src.jutsus+=la
					la.damage=la.damage+round((src.ninjutsu / 150)*2*J.damage)
					src.Kirin()
					del(la)
					spawn(150)
						del(A)

		EarthMask()
			for(var/obj/Jutsus/EarthMask/J in src.jutsus)
				if(src.PreJutsu(J))
					if(loc.loc:Safe!=1) src.LevelStat("Ninjutsu",((J.maxcooltime*3/10)*jutsustatexp))
					var/obj/Projectiles/Effects/earthmask/A=new/obj/Projectiles/Effects/earthmask(src.loc)
					A.dir=src.dir
					var/obj/Jutsus/Mud_Dragon_Projectile/la//=new/obj/Jutsus/Mud_Dragon_Projectile()
					A.Owner=src
					src.jutsus+=la
					la.damage=la.damage+round((src.ninjutsu / 150)*2*J.damage)
					src.Mud_Dragon_Projectile()
					del(la)
					spawn(150)
						del(A)
