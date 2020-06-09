mob
	proc
		FireMask()
			if(firing)return
			if(src.firing==0 && src.canattack==1)
				for(var/obj/Jutsus/FireMask/J in src.JutsusLearnt)
					if(src.PreJutsu(J))
						if(loc.loc:Safe!=1) src.LevelStat("Ninjutsu",rand(9,13))
						var/obj/Projectiles/Effects/firemask/A=new/obj/Projectiles/Effects/firemask(src.loc)
						A.dir=src.dir
						var/obj/Jutsus/AFireBall/la=new/obj/Jutsus/AFireBall()
						A.Owner=src
						src.JutsusLearnt+=la
						la.damage=300
						src.AFire_Ball()
						del(la)
						spawn(150)
							del(A)

		WindMask()
			if(firing)return
			if(src.firing==0 && src.canattack==1)
				for(var/obj/Jutsus/WindMask/J in src.JutsusLearnt)
					if(src.PreJutsu(J))
						if(loc.loc:Safe!=1) src.LevelStat("Ninjutsu",rand(7,11))
						var/obj/Projectiles/Effects/windmask/A=new/obj/Projectiles/Effects/windmask(src.loc)
						A.dir=src.dir
						var/obj/Jutsus/Sickle_Weasel_Technique/la=new/obj/Jutsus/Sickle_Weasel_Technique()
						A.Owner=src
						src.JutsusLearnt+=la
						la:damage=src.ninjutsu*5+src.strength*5
						src.Sickle_Weasel_Technique()
						del(la)
						spawn(150)
							del(A)

		LightningMask()
			if(firing)return
			if(src.firing==0 && src.canattack==1)
				for(var/obj/Jutsus/LightningMask/J in src.JutsusLearnt)
					if(src.PreJutsu(J))
						if(loc.loc:Safe!=1) src.LevelStat("Ninjutsu",rand(14,17))
						var/obj/Projectiles/Effects/lightningmask/A=new/obj/Projectiles/Effects/lightningmask(src.loc)
						A.Owner=src
						A.dir=src.dir
						var/obj/Jutsus/Kirin/la=new/obj/Jutsus/Kirin()
						src.JutsusLearnt+=la
						la.damage=src.ninjutsu*8
						src.Kirin()
						del(la)
						spawn(150)
							del(A)

		EarthMask()
			if(firing)return
			if(src.firing==0 && src.canattack==1)
				for(var/obj/Jutsus/EarthMask/J in src.JutsusLearnt)
					if(src.PreJutsu(J))
						if(loc.loc:Safe!=1) src.LevelStat("Ninjutsu",rand(7,11))
						var/obj/Projectiles/Effects/earthmask/A=new/obj/Projectiles/Effects/earthmask(src.loc)
						A.dir=src.dir
						var/obj/Jutsus/Mud_Dragon_Projectile/la=new/obj/Jutsus/Mud_Dragon_Projectile()
						A.Owner=src
						src.JutsusLearnt+=la
						la.damage=6
						src.Mud_Dragon_Projectile()
						del(la)
						spawn(150)
							del(A)
