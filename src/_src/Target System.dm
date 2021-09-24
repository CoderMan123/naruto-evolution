#define TARGET_MOB 0


image
	Target
		var/mob/owner
		New(var/mob/M)
			if(!M || !istype(M)) del(src)
			src.owner = M
			src.icon = 'target.dmi'
			src.icon_state = "targetred"
			src.overlays = null
			src.underlays = null
			src.layer = 99
			src.pixel_x=16
			src.pixel_y=5
mob/verb/Target_A_Mob()
	set hidden=1
	var/Train=0
	for(var/obj/Training/T in orange(1))Train=1
	if(Train)return
	//for(var/mob/M in oview(src))if(M.Attacked==src&&!target_mob==M)src.Target_Atom(M)
	for(var/mob/M in oview(src))

		if(istype(loc,/turf/Arena))//If you're in the arena, and your trying to tab target a person, it will only target your opponent.
			if(M.key)//This makes it so clones are still targettable.
				if(M!=opponent)
					continue

		if(target_mob==M) continue
		if(M==src.puppets[1]) continue
		if(M.Owner==src) continue
		if(istype(M, /mob/training)) continue
		if(M.village == src.village) continue
		src.Target_Atom(M)
		return

mob/verb/Target_An_Ally()
	set hidden=1
	var/Train=0
	for(var/obj/Training/T in orange(1))Train=1
	if(Train)return
	//for(var/mob/M in oview(src))if(M.Attacked==src&&!target_mob==M)src.Target_Atom(M)
	for(var/mob/M in oview(src))

		if(istype(loc,/turf/Arena))//If you're in the arena, and your trying to tab target a person, it will only target your opponent.
			if(M.key)//This makes it so clones are still targettable.
				if(M!=opponent)
					continue

		if(target_mob==M) continue
		if(M==src.puppets[1]) continue
		if(M.Owner==src) continue
		if(istype(M, /mob/training)) continue
		if(M.village != src.village) continue
		src.Target_Atom(M)
		return

mob/var/tmp
	mob/target_mob
	image/Target/target_mob_image
mob/verb/Untarget_pplz()
	set hidden=1
	usr.Target_Remove()
mob/proc
	Target_Remove()
		if(src.target_mob)src.target_mob = null
		if(target_mob_image)del(src.target_mob_image)
	Target_ReAdd()
		if(!Target_Get())return
		if(client)
			if(!client.images.Find(src.target_mob_image))
				src.target_mob_image = new(src)
				src << src.target_mob_image
				src.target_mob_image.loc = target_mob
	Target_Atom(var/atom/movable/A)
		if(istype(A,/mob/npc/) && !istype(A, /mob/npc/combat))return
		if(istype(A, /mob/training/untargetable)) return
		if(istype(A,src.puppets[1]))return
		if(istype(A,/mob/Untargettable/))return
		if(src.target_mob==A)return
		if(!istype(A)||!(A in view(100)))return

		//if(istype(loc,/turf/Arena)&& A!=opponent) return

		if(ismob(A))
			src.Target_Remove()
			if(client)
				if(!client.images.Find(src.target_mob_image))
					src.target_mob_image = new(src)
					src.target_mob_image.loc = A
					src << src.target_mob_image
			src.target_mob = A

	Target_Get()
		if(!src.target_mob) return 0
		for(var/mob/m in view(100))
			if(m == src.target_mob)
				return src.target_mob
		src.Target_Remove(TARGET_MOB)
		return 0

atom/movable/Click()
	//if(!istype(src,/obj/HUD))
	if(usr.Target_Get()==src)
		usr.Target_Remove()
		..()
		return
	if(ismob(src))usr.Target_Atom(src)
	..()

turf
	Click()
		//if(!istype(src,/obj/HUD))
		for(var/mob/m in range(0, src))
			if(m.client || istype(m, /mob/summonings) || istype(m, /mob/jutsus) || istype(m, /mob/training))
				if(usr.Target_Get()==m)
					usr.Target_Remove()
					break
				else usr.Target_Atom(m)
		..()

/*	Entered(atom/movable/a)
		..()
		if(istype(a, /client) || istype(a, /mob/summonings) || istype(a, /mob/jutsus) || istype(a, /mob/training))
			src.mouse_over_pointer = /obj/cursors/target*/

/*	Exited(atom/movable/a)
		..()
		if(istype(a, /client) || istype(a, /mob/summonings) || istype(a, /mob/jutsus) || istype(a, /mob/training))
			if(!locate(/client) in src.loc && !locate(/mob/summonings) in src.loc && !locate(/mob/jutsus) in src.loc && !locate(/mob/training) in src.loc)
				src.mouse_over_pointer = MOUSE_INACTIVE_POINTER*/

obj/var/mob/owner=null
obj/projectiles/var
	speed=0
	atom/target=null