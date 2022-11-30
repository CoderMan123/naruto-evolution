obj
	proc
		Levelup()
			if(src.exp>=src.maxexp&&src.level<4)
				if(!src.owner) return

				if(src.name=="Transformation Jutsu")
					if(src.level==3)
						return

				var/mob/Owner=getOwner(src.owner)
				Owner.PlayAudio('level.wav', output = AUDIO_SELF)
				Owner<<output("<font color= #dda0dd>Your [src] skill has advanced a level</Font>.","Action.Output")
				src.level++
				src.exp-=src.maxexp
				src.maxexp+=30

				if(src.name=="Clone Jutsu")
					Owner<<output("<font color= #bc8f8f>Clone jutsu gained +1 max clones.</Font>.","Action.Output")
				if(src.name=="Fire Release: Fire Ball")
					Owner<<output("<font color= #bc8f8f>Your [src] skill's base damage has increased</Font>.","Action.Output")
				if(src.name=="Meteor Punch")
					Owner<<output("<font color= #bc8f8f>Your [src] skill's base damage and knockback power has increased</Font>.","Action.Output")
				if(src.name=="Fire Release: Phoenix Immortal Fire Technique")
					if(src.level==2)
						Owner<<output("<font color= #bc8f8f>Your [src] skill is now able to fire 3 projectiles</Font>.","Action.Output")
						Owner.katon=3
					if(src.level==3)
						Owner<<output("<font color= #bc8f8f>Your [src] skill's base damage has increased</Font>.","Action.Output")
						Owner<<output("<font color= #bc8f8f>Your [src] skill is now able to fire 4 projectiles</Font>.","Action.Output")
						Owner.katon=4
					if(src.level==4)
						Owner<<output("<font color= #bc8f8f>Your [src] skill is now able to fire 5 projectiles</Font>.","Action.Output")
						Owner.katon=5
				if(src.name=="Body Replacement Jutsu")
					if(src.level==4)
						var/obj/Jutsus/AdvancedBodyReplace/J=new/obj/Jutsus/AdvancedBodyReplace
						if(!J) return
						if(J.type in Owner.jutsus_learned)del(J)
						else
							if(!J) return
							Owner<<output("<font color= #bc8f8f>You learned [J.name]</Font>.","Action.Output")
							Owner.jutsus.Add(J)
							Owner.jutsus_learned.Add(J.type)
							J.Owner=Owner
				if(src.name=="Transformation Jutsu")
					if(src.level==2)Owner<<output("<font color= #bc8f8f>[src.name] can now be used to transform into objects</Font>!","Action.Output")
					if(src.level==3)Owner<<output("<font color= #bc8f8f>[src.name] can now be used to transform into almost anything</Font>!","Action.Output")

mob
	proc
		LevelStat(stat, howmuch, var/bypass_exp_lock = 0)
			var/area/A=loc.loc
			if(!A) return
			if(A.Safe && !bypass_exp_lock) return
			if(src.exp_locked && !bypass_exp_lock) return

			if(src.client)
				var/database/query/query = new({"
					INSERT INTO `[db_table_character_experience]` (`timestamp`, `key`, `character`, `stat`, `[db_table_character_experience]`)
					VALUES(?, ?, ?, ?, ?)"},
					time2text(world.realtime, "YYYY-MM-DD hh:mm:ss"), src.client.ckey, src.character, stat, round(howmuch)
				)
				query.Execute(log_db)
				LogErrorDb(query)

			switch(stat)
				if("Defence") defexp += round(howmuch)
				if(SPECIALIZATION_TAIJUTSU) taijutsuexp += round(howmuch)
				if("Ninjutsu") ninexp += round(howmuch)
				if("Genjutsu") genexp += round(howmuch)
				if("Agility") agilityexp += round(howmuch)
				if("Precision") precisionexp += round(howmuch)
			Levelup()
			

		Levelup()
			if(src.xplock==1)
				src<<output("You have an Experience lock on you. This measure is used against the abusers / AFK trainers. Admin decides when this is removed.","Action.Output")
				return
			if(src.exp>=src.maxexp)
				if(src.level>=100)
					goto next
				var/obj/O = new/obj
				O.icon = 'ChakraCharge.dmi'
				O.icon_state = "3x"
				O.layer=200
				src.overlays+=O
				src.PlayAudio('levelup.wav', output = AUDIO_SELF)
				src<<output("<font color= #bc8f8f>You leveled up!</Font>.","Action.Output")
				src.level+=1

				var/database/query/query = new({"
					INSERT INTO `[db_table_character_level]` (`timestamp`, `key`, `character`, `stat`, `level`)
					VALUES(?, ?, ?, ?, ?)"},
					time2text(world.realtime, "YYYY-MM-DD hh:mm:ss"), src.client.ckey, src.character, "base", src.level
				)
				query.Execute(log_db)
				LogErrorDb(query)
				
				src.exp-=src.maxexp
				src.statpoints+=4
				src.skillpoints++
				if(src.level<=20)
					src.maxexp+=1
				if(src.level>20&&src.level<=40)
					src.maxexp+=2
				if(src.level>40&&src.level<=60)
					src.maxexp+=5
				if(src.level>60&&src.level<=80)
					src.maxexp+=7
				if(src.level>80&&src.level<=100)
					src.maxexp+=10

				if(src.client)
					spawn()
						var/squad/squad = src.GetSquad()
						if(squad)
							squad.Refresh()

				src.Levelup()
				spawn(15)
					src.overlays-=O
					O.loc = null
				next
			if(src.taijutsuexp>=src.maxtaijutsuexp)
				if(src.taijutsu>=100)
					goto next
				src.PlayAudio('level.wav', output = AUDIO_SELF)
				src<<output("<font color=TaiOrange>You leveled up Strength</Font>.","Action.Output")
				src.exp+=1
				src.taijutsu+=1

				var/database/query/query = new({"
					INSERT INTO `[db_table_character_level]` (`timestamp`, `key`, `character`, `stat`, `level`)
					VALUES(?, ?, ?, ?, ?)"},
					time2text(world.realtime, "YYYY-MM-DD hh:mm:ss"), src.client.ckey, src.character, "taijutsu", src.taijutsu
				)
				query.Execute(log_db)
				LogErrorDb(query)

				src.taijutsuexp-=src.maxtaijutsuexp
				if(src.taijutsu<=20)
					src.maxtaijutsuexp+=10+round(src.taijutsu)
				if(src.taijutsu>20&&src.taijutsu<=40)
					src.maxtaijutsuexp+=30+round(src.taijutsu)
				if(src.taijutsu>40&&src.taijutsu<=60)
					src.maxtaijutsuexp+=60+round(src.taijutsu)
				if(src.taijutsu>60&&src.taijutsu<=80)
					src.maxtaijutsuexp+=100+round(src.taijutsu)
				if(src.taijutsu>80&&src.taijutsu<=100)
					src.maxtaijutsuexp+=300+round(src.taijutsu)
				src.Levelup()
				next

			if(src.ninexp>=src.maxninexp)
				if(src.ninjutsu>=100)
					goto next
				src.PlayAudio('level.wav', output = AUDIO_SELF)
				src<<output("<font color=NinBlue>You leveled up Ninjutsu</Font>.","Action.Output")
				src.exp+=1
				src.ninjutsu+=1

				var/database/query/query = new({"
					INSERT INTO `[db_table_character_level]` (`timestamp`, `key`, `character`, `stat`, `level`)
					VALUES(?, ?, ?, ?, ?)"},
					time2text(world.realtime, "YYYY-MM-DD hh:mm:ss"), src.client.ckey, src.character, "ninjutsu", src.ninjutsu
				)
				query.Execute(log_db)
				LogErrorDb(query)

				src.ninexp-=src.maxninexp
				if(src.ninjutsu<=20)
					src.maxninexp+=10+round(src.ninjutsu)
				if(src.ninjutsu>20&&src.ninjutsu<=40)
					src.maxninexp+=30+round(src.ninjutsu)
				if(src.ninjutsu>40&&src.ninjutsu<=60)
					src.maxninexp+=60+round(src.ninjutsu)
				if(src.ninjutsu>60&&src.ninjutsu<=80)
					src.maxninexp+=100+round(src.ninjutsu)
				if(src.ninjutsu>80&&src.ninjutsu<=100)
					src.maxninexp+=300+round(src.ninjutsu)
				src.Levelup()
				next
			if(src.genexp>=src.maxgenexp)
				if(src.genjutsu>=100)
					goto next
				src.PlayAudio('level.wav', output = AUDIO_SELF)
				src<<output("<font color=blueviolet>You leveled up Genjutsu</Font>.","Action.Output")
				src.exp+=1
				src.genjutsu+=1

				var/database/query/query = new({"
					INSERT INTO `[db_table_character_level]` (`timestamp`, `key`, `character`, `stat`, `level`)
					VALUES(?, ?, ?, ?, ?)"},
					time2text(world.realtime, "YYYY-MM-DD hh:mm:ss"), src.client.ckey, src.character, "genjutsu", src.genjutsu
				)
				query.Execute(log_db)
				LogErrorDb(query)

				src.genexp-=src.maxgenexp
				if(src.genjutsu<=20)
					src.maxgenexp+=10+round(src.genjutsu)
				if(src.genjutsu>20&&src.genjutsu<=40)
					src.maxgenexp+=30+round(src.genjutsu)
				if(src.genjutsu>40&&src.genjutsu<=60)
					src.maxgenexp+=60+round(src.genjutsu)
				if(src.genjutsu>60&&src.genjutsu<=80)
					src.maxgenexp+=100+round(src.genjutsu)
				if(src.genjutsu>80&&src.genjutsu<=100)
					src.maxgenexp+=300+round(src.genjutsu)
				src.Levelup()
				next
			if(src.defexp>=src.maxdefexp)
				if(src.defence>=100)
					goto next
				src.PlayAudio('level.wav', output = AUDIO_SELF)
				src<<output("<font color=maroon>You leveled up Defence</Font>.","Action.Output")
				src.exp+=1
				src.defence++

				var/database/query/query = new({"
					INSERT INTO `[db_table_character_level]` (`timestamp`, `key`, `character`, `stat`, `level`)
					VALUES(?, ?, ?, ?, ?)"},
					time2text(world.realtime, "YYYY-MM-DD hh:mm:ss"), src.client.ckey, src.character, "defence", src.defence
				)
				query.Execute(log_db)
				LogErrorDb(query)

				src.defexp-=src.maxdefexp
				if(src.defence<=20)
					src.maxdefexp+=10+round(src.defence)
				if(src.defence>20&&src.defence<=40)
					src.maxdefexp+=30+round(src.defence)
				if(src.defence>40&&src.defence<=60)
					src.maxdefexp+=60+round(src.defence)
				if(src.defence>60&&src.defence<=80)
					src.maxdefexp+=100+round(src.defence)
				if(src.defence>80&&src.defence<=100)
					src.maxdefexp+=300+round(src.defence)
				src.Levelup()
				next
			if(src.agilityexp>=src.maxagilityexp)
				if(src.agility>=100)
					goto next
				src.PlayAudio('level.wav', output = AUDIO_SELF)
				src<<output("<font color=cornsilk>You leveled up Agility</Font>.","Action.Output")
				src.exp+=1
				src.agility++

				var/database/query/query = new({"
					INSERT INTO `[db_table_character_level]` (`timestamp`, `key`, `character`, `stat`, `level`)
					VALUES(?, ?, ?, ?, ?)"},
					time2text(world.realtime, "YYYY-MM-DD hh:mm:ss"), src.client.ckey, src.character, "agility", src.agility
				)
				query.Execute(log_db)
				LogErrorDb(query)

				src.agilityexp-=src.maxagilityexp
				if(src.agility<=20)
					src.maxagilityexp+=10+round(src.agility)
				if(src.agility>20&&src.agility<=40)
					src.maxagilityexp+=30+round(src.agility)
				if(src.agility>40&&src.agility<=60)
					src.maxagilityexp+=60+round(src.agility)
				if(src.agility>60&&src.agility<=80)
					src.maxagilityexp+=100+round(src.agility)
				if(src.agility>80&&src.agility<=100)
					src.maxagilityexp+=300+round(src.agility)
				src.Levelup()
				src.attkspeed=(8-(0.03*src.agility_total))
				next
			if(src.precisionexp>=src.maxprecisionexp)
				if(src.precision>=100)
					goto next
				src.PlayAudio('level.wav', output = AUDIO_SELF)
				src<<output("<font color=azure>You leveled up Precision</Font>.","Action.Output")
				src.exp+=1
				src.precision++

				var/database/query/query = new({"
					INSERT INTO `[db_table_character_level]` (`timestamp`, `key`, `character`, `stat`, `level`)
					VALUES(?, ?, ?, ?, ?)"},
					time2text(world.realtime, "YYYY-MM-DD hh:mm:ss"), src.client.ckey, src.character, "precision", src.precision
				)
				query.Execute(log_db)
				LogErrorDb(query)

				src.precisionexp-=src.maxprecisionexp
				if(src.precision<=20)
					src.maxprecisionexp+=10+round(src.precision)
				if(src.precision>20&&src.precision<=40)
					src.maxprecisionexp+=30+round(src.precision)
				if(src.precision>40&&src.precision<=60)
					src.maxprecisionexp+=60+round(src.precision)
				if(src.precision>60&&src.precision<=80)
					src.maxprecisionexp+=100+round(src.precision)
				if(src.precision>80&&src.precision<=100)
					src.maxprecisionexp+=300+round(src.precision)
				src.Levelup()
				next

			spawn() src.UpdateHMB()

			if(src.rank == RANK_ACADEMY_STUDENT && src.level >= 25)
				src.rank = RANK_GENIN
				switch(src.village)
					if(VILLAGE_LEAF)
						src.RecieveItem(new/obj/Inventory/Clothing/HeadWrap/LeafHeadBand)
					if(VILLAGE_SAND)
						src.RecieveItem(new/obj/Inventory/Clothing/HeadWrap/SandHeadBand)
				src.client.prompt("Your elders have deemed you a true ninja. You've become a Genin!")

			if(level>=25 && !Element2 && !prestigelevel)//prestige system
				var/Elements=list("Fire","Water","Earth","Lightning","Wind")
				var/PlayerElements=list("[src.Element]","[src.Element2]","[src.Element3]","[src.Element4]","[src.Element5]")
				src.Element2=src.CustomInput("Element Options","What secondary element would you like?.",Elements-PlayerElements)
				if(src.Element2) src.Element2=src.Element2:name
				if(src.Element=="Water"|src.Element2=="Wind")
					if(src.Element=="Wind"|src.Element2=="Water")
						src.Kekkai = "Ice"
obj
	Overlays
		Death
			DeadRight
				icon='WhiteMBase.dmi'
				icon_state="deadright"
				//pixel_x=32


mob/var/tmp/levelrate=0
mob/var
	undlvlatck=0
	overlvl=0