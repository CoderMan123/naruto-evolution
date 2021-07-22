obj/Symbols
	Squad
		New(mob/M, var/ckey)
			if(M && M.client)
				var/squad/squad = M.GetSquad()
				if(squad && squad.leader[ckey]) src.icon = 'Squad-Leader.png'
	Village
		New(mob/M)
			src.loc=null
			if(M && M.client)
				switch(M.village)
					if("Hidden Sand") src.icon = 'Sand.png'
					if("Hidden Leaf") src.icon = 'Leaf.png'
					if("Hidden Mist") src.icon = 'Missing-Nin.png'
					if("Hidden Sound") src.icon = 'Missing-Nin.png'
					if("Hidden Rock") src.icon = 'Missing-Nin.png'
					if("Seven Swordsmen") src.icon = 'Missing-Nin.png'
					if("Missing-Nin") src.icon = 'Missing-Nin.png'
					if("Akatsuki") src.icon = 'Akatsuki.png'
					if("Anbu Root") src.icon = 'Missing-Nin.png'
			..()
	Rank
		New(mob/M)
			src.loc=null
			if(M && M.client)
				switch(M.rank)
					if("Academy Student") src.icon = 'Academy-Student.png'
					if("Genin") src.icon = 'Genin.png'
					if("Chuunin") src.icon = 'Chuunin.png'
					if("Jonin") src.icon = 'Jonin.png'
					if("Anbu") src.icon = 'Anbu.png'
					if("Kage") src.icon = 'Kage.png'
			..()

	Squad
		New()
			..()
			src.loc=null
			src.icon = 'Squad-Leader.png'

	Role
		New(mob/M)
			if(M && M.client)
				if(M.ckey in administrators) src.icon = 'Administrator.png'
				else if(M.ckey in moderators) src.icon = 'Moderator.png'
				//if("Trainee") src.icon = null
				//if("Community Manager") src.icon = null
				//if("Event Manager") src.icon = null
				//if("Pixel Artist") src.icon = null
				//if("Programmer") src.icon = null
			..()