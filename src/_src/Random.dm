mob/var/tmp
	counting=0
mob/verb/Countdown()
	set hidden=1
//	set name = "Countdown"
	if(usr.counting)
		return
	usr.counting = 1
	view() << "<font color = yellow>[usr]:THREE"
	sleep(15)
	view() << "<font color = yellow>[usr]: TWO"
	sleep(15)
	view() << "<font color = yellow>[usr]: ONE"
	sleep(15)
	view() << "<font color = yellow>[usr]: GOOO!!!"
	sleep(20)
	usr.counting=0

turf/signleaf
	icon='Signs.dmi'
	icon_state="Leaf"
	density=1
	layer=3
	Click()
		alert(usr,"Welcome to the Hidden Leaf Village!")
turf/signsand
	icon='Signs.dmi'
	icon_state="Sand"
	density=1
	layer=3
	Click()
		alert(usr,"Hidden Sand Village: Welcome!")
turf/signmist
	icon='Signs.dmi'
	icon_state="Mist"
	density=1
	layer=3
	Click()
		alert(usr,"Hidden Mist Village: Prepare to die!")
turf/signsound
	icon='Signs.dmi'
	icon_state="Sound"
	density=1
	layer=5
	Click()
		alert(usr,"Hidden Sound Village. GET OUT!")
turf/signRock
	icon='Signs.dmi'
	icon_state="Rock"
	density=1
	layer=3
	Click()
		alert(usr,"Hidden Rock Village!")
mob
	var
		times=0
proc/MinMaxNum(var/minNum,var/maxNum,var/baseNum)
	return	min(maxNum,max(minNum,baseNum))

obj
	test
		kpuppet
			icon='Kazekage Puppet.dmi'
			icon_state="Kazekage Puppet"
			density=1


obj/Special/Squigspaper
	icon='building insides.dmi'
	icon_state="paper"
	mouse_opacity=2
	Click()
		if(get_dist(src,usr)>1) return
		usr<<"This is Squigs's paperwork. Seems like a lot of work!"

obj/Special/Map1Paper
	icon='building insides.dmi'
	icon_state="paper"
	mouse_opacity=2
	Click()
		usr<<"You shouldn't be here. Type in /stuck to leave. There is nothing on this map, and you're not able to do jutsus here. Don't waste your time. If you know how you got here please bug report it or let an admin know so it can be fixed."

mob/var
	Vkill

mob/proc
	CheckVKill()
		if(src.Vkill >= 5)
			src.Vkill = 0
			return 1

var/tmp/inuse
obj/Inventory/JutsuMastScroll
	name="Jutsu Mastery Scroll"
	icon='JMastScroll.dmi'
	icon_state=""
	layer = MOB_LAYER+1
	MouseDrop(over_object=src,src_location,over_location, src_control,over_control,params)
		if(get_dist(usr,src)<=1)
			//if(over_control == "Map.map"&&src_control=="Inventory.InvenInfo")
			if(inuse)return
			if(usr.contents.Find(src))
				src.Drop(usr)
				return


	DblClick()
		if(usr.dead) return
		if(get_dist(src,usr)>1) return
		if(!usr.contents.Find(src))
			hearers()<<output("[usr] picks up [src].","Action.Output")
			take(usr)
			return
		if(src in usr)
			MasterJutsu()
			usr.client.UpdateInventoryPanel()

	proc
		MasterJutsu()
			set name = "Master a Jutsu"
			set hidden = 1
			inuse=1
			var/obj/Jutsus/J=input("Which Jutsu would you like to master?") as obj in usr.jutsus
			if(alert("Are you sure you want to master  [J.name]?","Confirm!","No","Yes")=="Yes")
				J.exp = J.maxexp
				J.Levelup()
				J.exp = J.maxexp
				J.Levelup()
				J.exp = J.maxexp
				J.Levelup()
				J.exp = J.maxexp
				J.Levelup()
				usr.DestroyItem(src)
				inuse=0

			else
				inuse=0
				return


/*
obj/Del() // Test garbage collection.
	world<<"GC del [name]"
	..()
*/
/*
mob
	verb
		showmethemoney()
			Ryo += 5000

		TS()
			var/howmuch1=input("amp.") as num
			//var/howmuch2=input("dur") as num
			/*client.*/ScreenShake(howmuch1)//, howmuch2)
		CheckWorldXp()
			usr<<"World XP : [WorldXp]"

		Get_HostKey()
			usr << browse(HostKey)
			winset(src, null, {"
						Browser.is-visible = "true";
					"})
		Add_VKill(mob/M in world)
			M.Vkill++
			src<<output("[M]: [M.Vkill] Vkills.","Action.Output")
			CheckVKill()
		RemoveAllClothingV(mob/M in world)
			RemoveAllClothing()
		ReAddClothingV(mob/M in world)
			ReAddClothing()


*/