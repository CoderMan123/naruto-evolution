area/var/Safe=0
area
	Entered()
		if(Safe) usr<<output("You are now entering a safe zone.","ActionPanel.Output")
		..()
	Exited()
		if(Safe) usr<<output("You are now leaving a safe zone.","ActionPanel.Output")
		..()
area/Dojo
	invisibility=99
	icon='Misc Effects.dmi'
	icon_state="dojo"
	layer=5
	var/DojoX=130
	var/DojoY=47
	var/DojoZ=2
	Entered()
		usr<<output("You have entered the dojo.","ActionPanel.Output")
		..()
area/Village
	Safe=1
	icon='Misc Effects.dmi'
	icon_state="Village"
	invisibility=99
	layer=5