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
		if(target_mob==M) continue
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
		if(istype(A,/mob/NPC/))return
		if(src.target_mob==A)return
		if(!istype(A)||!(A in view()))return
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
/*
mob
	Click()
	proc
		Target(mob/M)
			if(src.enemy_marker)del(src.enemy_marker)
			src.enemy_marker=image(src.tcc,M)
			src<<src.enemy_marker
		UnTarget()
			if(src.enemy_marker)del(src.enemy_marker)
obj
	var/mob/owner = null
	Effects
		Target
			icon='target.dmi'
			mouse_opacity=0
			icon_state="targetred"
			layer=9999
			pixel_y=16
	projectiles
		var
			speed = 0
			atom/target = null
mob
	var
		tmp
			tcc=new/obj/Effects/Target
			enemy_marker=0
mob
	var
		tmp
			targetwho="All"
			target
mob
	verb
		TargetWho()
			set hidden=1
			if(usr.targetwho=="Players")
				usr.targetwho="Monsters"
				usr << output("<font color=green><i>Now targeting [targetwho]","actionoutput")
			else
				if(usr.targetwho=="Monsters")
					usr.targetwho="All"
					usr << output("<font color=red><i>Now targeting [targetwho]","actionoutput")
				else
					if(usr.targetwho=="All")
						usr.targetwho="None"
						usr << output("<font color=black><i>Now targeting [targetwho]","actionoutput")
					else
						if(usr.targetwho=="None")
							usr.targetwho="Players"
							usr << output("<font color=white><i>Now targeting [targetwho]","actionoutput")
mob/player
	proc
		TargetMob()
			src.target=null
			if(src.targetwho=="Players")
				for(var/mob/Clones/M in oview(src))
					if(M.Owner==src)continue
					else
						if(M.dead==0&&M.Owner<>src&&M.icon_state<>"blank")
							if(M.fightlayer==src.fightlayer)
								src.target=M
								src.dir = get_dir(src,M)
						break
				for(var/mob/player/M in oview(src))
					if(M.dead)continue
					else
						if(M.dead==0&&M.icon_state<>"blank")
							if(M.fightlayer==src.fightlayer)
								src.target=M
								src.dir = get_dir(src,M)
						break
			if(src.targetwho=="Monsters")
				for(var/mob/Monsters/M in oview(src))
					if(M.dead)continue
					else
						if(M.dead==0&&M.icon_state<>"blank")
							if(M.fightlayer==src.fightlayer)
								src.target=M
								src.dir = get_dir(src,M)
						break
			if(src.targetwho=="All")
				for(var/mob/M in oview(src))
					if(istype(M,/mob/NPC))
						..()
					else
						if(M.dead||M.Owner==src)continue
						else
							if(M.dead==0&&M.Owner<>src&&M.icon_state<>"blank")
								if(M.fightlayer==src.fightlayer)
									src.target=M
									src.dir = get_dir(src,M)
							break
			if(src.targetwho=="None")
				src.target=null
				..()
*/