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
			src.pixel_y=8
mob/verb/Target_A_Mob()
	set hidden=1
	var/Train=0
	for(var/obj/Training/T in orange(1))Train=1
	if(Train)return
	for(var/mob/M in oview(src))if(M.Attacked==src&&!target_mob==M)src.Target_Atom(M)
	for(var/mob/M in oview(src))

		if(istype(loc,/turf/Arena))//If you're in the arena, and your trying to tab target a person, it will only target your opponent.
			if(M.key)//This makes it so clones are still targettable.
				if(M!=opponent)
					continue

		if(target_mob==M) continue
		if(M==src.puppets[1]) continue
		if(M.Owner==src) continue
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
		if(istype(A,/mob/npc/))return
		if(istype(A,src.puppets[1]))return
		if(istype(A,/mob/Untargettable/))return
		if(src.target_mob==A)return
		if(!istype(A)||!(A in view()))return

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
		if(!target_mob) return 0
		if(!(src.target_mob in range()))
			src.Target_Remove(TARGET_MOB)
			return 0
		return target_mob
atom/movable/Click()
	//if(!istype(src,/obj/HUD))
	if(usr.Target_Get()==src)
		usr.Target_Remove()
		..()
		return
	if(ismob(src))usr.Target_Atom(src)
	..()
obj/var/mob/owner=null
obj/projectiles/var
	speed=0
	atom/target=null