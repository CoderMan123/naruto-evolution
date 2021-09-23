obj/Symbols
	exp_lock
		icon = 'Padlock.png'
		pixel_x = 48
		pixel_y = 66

	Squad
		New(mob/M, var/ckey)
			if(M && M.client)
				var/squad/squad = M.GetSquad()
				if(squad && squad.leader[ckey]) src.icon = 'Squad-Leader.png'
	Village
		New(mob/M)
			src.loc=null
			if(M)
				switch(M.village)
					if(VILLAGE_LEAF) src.icon = 'Leaf.png'
					if(VILLAGE_SAND) src.icon = 'Sand.png'
					if(VILLAGE_ROCK) src.icon = 'Missing-Nin.png'
					if(VILLAGE_MIST) src.icon = 'Missing-Nin.png'
					if(VILLAGE_SOUND) src.icon = 'Missing-Nin.png'
					if(VILLAGE_MISSING_NIN) src.icon = 'Missing-Nin.png'
					if(VILLAGE_AKATSUKI) src.icon = 'Akatsuki.png'
					if("Seven Swordsmen") src.icon = 'Missing-Nin.png'
					if("Anbu Root") src.icon = 'Missing-Nin.png'
			..()
	Rank
		New(mob/M)
			src.loc=null
			if(M && M.rank)
				switch(M.rank)
					if(RANK_ACADEMY_STUDENT) src.icon = 'Academy-Student.png'
					if(RANK_GENIN) src.icon = 'Genin.png'
					if(RANK_CHUUNIN) src.icon = 'Chuunin.png'
					if(RANK_JOUNIN) src.icon = 'Jonin.png'
					if(RANK_ANBU) src.icon = 'Anbu.png'
					if(RANK_HOKAGE) src.icon = 'Kage.png'
					if(RANK_KAZEKAGE) src.icon = 'Kage.png'
			..()

	Squad
		New()
			..()
			src.loc=null
			src.icon = 'Squad-Leader.png'

	Role
		New(mob/M)
			src.loc=null
			if(M && M.client)
				if(M.ckey in administrators) src.icon = 'Administrator.png'
				else if(M.ckey in moderators) src.icon = 'Moderator.png'
				//if("Trainee") src.icon = null
				//if("Community Manager") src.icon = null
				//if("Event Manager") src.icon = null
				//if("Pixel Artist") src.icon = null
				//if("Programmer") src.icon = null
			..()

	missions
		intel_scroll
			pixel_y = 80
			leaf
				pixel_x = 20
				icon = 'overhead_icons.dmi'
				icon_state = "leafintel"
			sand
				pixel_x = 28
				icon = 'overhead_icons.dmi'
				icon_state = "sandintel"
