mob
	var/tmp
		inJC1=0
		inJC2=0
		inJC3=0
		inJC4=0
		inJC5=0
		inJC6=0
		inJC7=0
		inJC8=0
		inJC9=0

	proc
		Jin_Cloak1()
			if(src.firing==0 && src.canattack==1)
				for(var/obj/Jutsus/Jin_Cloak1/J in src.jutsus)
					if(src.PreJutsu(J))
						if(loc.loc:Safe!=1) src.LevelStat("Ninjutsu",rand(5,10))
						src.PlayAudio('Skill_MashHit.wav', output = AUDIO_HEARERS)
						src.icon='JC1.dmi'
						src.ninjutsu+=35
						src.defence+=35
						src.inJC1=1
						src.DealDamage(1000, src, "HealGreen", 1)
						spawn(400)
							src.ninjutsu-=35
							src.defence-=35
							src.DealDamage(2000,src,"black")
							src.inJC1=0
							ResetBase()
							//src.icon='WhiteMBase.dmi'
							src<<"Your Chakra Cloak wears off."
		Jin_Cloak2()
			if(src.firing==0 && src.canattack==1)
				for(var/obj/Jutsus/Jin_Cloak2/J in src.jutsus)
					if(src.PreJutsu(J))
						if(loc.loc:Safe!=1) src.LevelStat("Ninjutsu",rand(5,10))
						src.PlayAudio('Skill_MashHit.wav', output = AUDIO_HEARERS)
						src.icon='JC2.dmi'
						src.ninjutsu+=35
						src.agility+=35
						src.inJC2=1
						src.DealDamage(1000, src, "HealGreen", 1)
						spawn(400)
							src.ninjutsu-=35
							src.agility-=35
							src.DealDamage(2000,src,"black")
							src.inJC2=0
							ResetBase()
							//src.icon='WhiteMBase.dmi'
							src<<"Your Chakra Cloak wears off."
		Jin_Cloak3()
			if(src.firing==0 && src.canattack==1)
				for(var/obj/Jutsus/Jin_Cloak3/J in src.jutsus)
					if(src.PreJutsu(J))
						if(loc.loc:Safe!=1) src.LevelStat("Ninjutsu",rand(5,10))
						src.PlayAudio('Skill_MashHit.wav', output = AUDIO_HEARERS)
						src.icon='JC3.dmi'
						src.defence+=50
						src.inJC3=1
						src.DealDamage(1000, src, "HealGreen", 1)
						spawn(400)
							src.defence-=50
							src.DealDamage(2000,src,"black")
							src.inJC3=0
							ResetBase()
							//src.icon='WhiteMBase.dmi'
							src<<"Your Chakra Cloak wears off."
		Jin_Cloak4()
			if(src.firing==0 && src.canattack==1)
				for(var/obj/Jutsus/Jin_Cloak4/J in src.jutsus)
					if(src.PreJutsu(J))
						if(loc.loc:Safe!=1) src.LevelStat("Ninjutsu",rand(5,10))
						src.PlayAudio('Skill_MashHit.wav', output = AUDIO_HEARERS)
						src.icon='JC4.dmi'
						src.strength+=50
						src.inJC4=1
						src.DealDamage(1000, src, "HealGreen", 1)
						spawn(400)
							src.strength-=50
							src.DealDamage(2000,src,"black")
							src.inJC4=0
							ResetBase()
							//src.icon='WhiteMBase.dmi'
							src<<"Your Chakra Cloak wears off."
		Jin_Cloak5()
			if(src.firing==0 && src.canattack==1)
				for(var/obj/Jutsus/Jin_Cloak5/J in src.jutsus)
					if(src.PreJutsu(J))
						if(loc.loc:Safe!=1) src.LevelStat("Ninjutsu",rand(5,10))
						src.PlayAudio('Skill_MashHit.wav', output = AUDIO_HEARERS)
						src.icon='JC5.dmi'
						src.strength+=35
						src.agility+=35
						src.inJC5=1
						src.DealDamage(1000, src, "HealGreen", 1)
						spawn(400)
							src.strength-=35
							src.agility-=35
							src.DealDamage(2000,src,"black")
							src.inJC5=0
							ResetBase()
							//src.icon='WhiteMBase.dmi'
							src<<"Your Chakra Cloak wears off."
		Jin_Cloak6()
			if(src.firing==0 && src.canattack==1)
				for(var/obj/Jutsus/Jin_Cloak6/J in src.jutsus)
					if(src.PreJutsu(J))
						if(loc.loc:Safe!=1) src.LevelStat("Ninjutsu",rand(5,10))
						src.PlayAudio('Skill_MashHit.wav', output = AUDIO_HEARERS)
						src.icon='JC6.dmi'
						src.ninjutsu+=50
						src.inJC6=1
						src.DealDamage(1000, src, "HealGreen", 1)
						spawn(400)
							src.ninjutsu-=50
							src.DealDamage(2000,src,"black")
							src.inJC6=0
							ResetBase()
							//src.icon='WhiteMBase.dmi'
							src<<"Your Chakra Cloak wears off."
		Jin_Cloak7()
			if(src.firing==0 && src.canattack==1)
				for(var/obj/Jutsus/Jin_Cloak7/J in src.jutsus)
					if(src.PreJutsu(J))
						if(loc.loc:Safe!=1) src.LevelStat("Ninjutsu",rand(5,10))
						src.PlayAudio('Skill_MashHit.wav', output = AUDIO_HEARERS)
						src.icon='JC7.dmi'
						src.strength+=35
						src.agility+=35
						src.inJC7=1
						src.DealDamage(1000, src, "HealGreen", 1)
						spawn(400)
							src.strength-=35
							src.agility-=35
							src.DealDamage(2000,src,"black")
							src.inJC7=0
							ResetBase()
							//src.icon='WhiteMBase.dmi'
							src<<"Your Chakra Cloak wears off."
		Jin_Cloak8()
			if(src.firing==0 && src.canattack==1)
				for(var/obj/Jutsus/Jin_Cloak8/J in src.jutsus)
					if(src.PreJutsu(J))
						if(loc.loc:Safe!=1) src.LevelStat("Ninjutsu",rand(5,10))
						src.PlayAudio('Skill_MashHit.wav', output = AUDIO_HEARERS)
						src.icon='JC8.dmi'
						src.strength+=50
						src.inJC8=1
						src.DealDamage(1000, src, "HealGreen", 1)
						spawn(400)
							src.strength-=50
							src.DealDamage(2000,src,"black")
							src.inJC8=0
							ResetBase()
							//src.icon='WhiteMBase.dmi'
							src<<"Your Chakra Cloak wears off."
		Jin_Cloak9()
			if(src.firing==0 && src.canattack==1)
				for(var/obj/Jutsus/Jin_Cloak9/J in src.jutsus)
					if(src.PreJutsu(J))
						if(loc.loc:Safe!=1) src.LevelStat("Ninjutsu",rand(5,10))
						src.PlayAudio('Skill_MashHit.wav', output = AUDIO_HEARERS)
						src.icon='JC9.dmi'
						src.strength+=35
						src.ninjutsu+=35
						src.inJC9=1
						src.DealDamage(1000, src, "HealGreen", 1)
						spawn(400)
							src.strength-=35
							src.ninjutsu-=35
							src.DealDamage(2000,src,"black")
							src.inJC9=0
							ResetBase()
							//src.icon='WhiteMBase.dmi'
							src<<"Your Chakra Cloak wears off."
