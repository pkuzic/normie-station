/obj/table/ex_act(severity)

	switch(severity)
		if(1.0)
			//SN src = null
			qdel(src)
			return
		if(2.0)
			if (prob(50))
				//SN src = null
				qdel(src)
				return
		if(3.0)
			if (prob(25))
				src.density = 0
		else
	return
/obj/table/throwpass = 1
/obj/table/blob_act()

	if(prob(50))
		new /obj/item/weapon/table_parts( src.loc )
		qdel(src)

/obj/table/hand_p(mob/user as mob)

	return src.attack_paw(user)
	return

/obj/table/attack_paw(mob/user as mob)
	if ((usr.mutations & 8))
		usr << text("\blue Ты уничтожаешь стол.")
		for(var/mob/O in oviewers())
			if ((O.client && !( O.blinded )))
				O << text("\red <b>[]</b> уничтожает стол.", usr)
		if(istype(src, /obj/table/reinforced))
			new /obj/item/weapon/table_parts/reinforced( src.loc )
		else
			new /obj/item/weapon/table_parts( src.loc )
		src.density = 0
		qdel(src)
	if (!( locate(/obj/table, user.loc) ))
		step(user, get_dir(user, src))
		if (user.loc == src.loc)
			user.layer = TURF_LAYER
			for(var/mob/M in viewers(user, null))
				M.show_message("Обезь&#255;нка пр&#255;четс&#255; под столом!", 1)
				//Foreach goto(69)
	return

/obj/table/attack_alien(mob/user as mob)
	if(istype(user, /mob/living/carbon/alien/larva))
		if (!( locate(/obj/table, user.loc) ))
			step(user, get_dir(user, src))
			if (user.loc == src.loc)
				user.layer = TURF_LAYER
				for(var/mob/M in viewers(user, null))
					M.show_message("Личинка инопланет&#255;нина пр&#255;четс&#255; под столом!", 1)
	return

/obj/table/attack_hand(mob/user as mob)
	if ((usr.mutations & 8))
		usr << text("\blue Ты разрушаешь стол.")
		for(var/mob/O in oviewers())
			if ((O.client && !( O.blinded )))
				O << text("\red <b>[]</b> разрушает стол.", usr)
		if(istype(src, /obj/table/reinforced))
			new /obj/item/weapon/table_parts/reinforced( src.loc )
		else
			new /obj/item/weapon/table_parts( src.loc )
		src.density = 0
		qdel(src)
	if (usr.mutations & mSmallsize)
		step(user, get_dir(user, src))
		if (user.loc == src.loc)
			user.layer = TURF_LAYER
			for(var/mob/M in viewers(user, null))
				M.show_message("Человек пр&#255;четс&#255; под столом!", 1)
				//Foreach goto(69)
	return



/obj/table/CanPass(atom/movable/mover, turf/target, height=0, air_group=0)
	if(air_group || (height==0)) return 1

	if ((mover.flags & 2 || istype(mover, /obj/meteor)) )
		return 1
	else
		return 0

/obj/table/MouseDrop_T(obj/O as obj, mob/user as mob)

	if ((!( istype(O, /obj/item/weapon) ) || user.equipped() != O))
		return
	user.drop_item()
	if (O.loc != src.loc)
		step(O, get_dir(O, src))
	return

/obj/table/attackby(obj/item/weapon/W as obj, mob/user as mob)
	if (istype(W, /obj/item/weapon/grab) && get_dist(src,user)<2)
		var/obj/item/weapon/grab/G = W
		if(G.state<2)
			user << "\red Нужно схватить покрепче!"
			return
		G.affecting.loc = src.loc
		G.affecting.weakened = 5
		for(var/mob/O in viewers(world.view, src))
			if (O.client)
				O << text("\red <b>[]</b> кладет <b>[]</b> на стол.", G.assailant, G.affecting)
		qdel(W)
		return

	if (istype(W, /obj/item/weapon/wrench))
		user << "\blue Сейчас разбираю стол..."
		playsound(src.loc, 'Ratchet.ogg', 50, 1)
		var/T = user.loc
		sleep(50)
		if(!(user.loc == T && user.equipped() == W)) //if they moved away or lost the wrench STOP
			return
		new /obj/item/weapon/table_parts( src.loc )
		playsound(src.loc, 'Deconstruct.ogg', 50, 1)
		//SN src = null
		qdel(src)
		return
	user.drop_item()
	if(W && W.loc && !W.is_module)	W.loc = src.loc
	return

/obj/table/reinforced/attackby(obj/item/weapon/W as obj, mob/user as mob)

	if (istype(W, /obj/item/weapon/grab) && get_dist(src,user)<2)
		var/obj/item/weapon/grab/G = W
		if(G.state<2)
			user << "\red Нужно схватить покрепче!"
			return
		G.affecting.loc = src.loc
		G.affecting.weakened = 5
		for(var/mob/O in viewers(world.view, src))
			if (O.client)
				O << text("\red <b>[]</b> кладет <b>[]</b> на стол.", G.assailant, G.affecting)
		qdel(W)
		return

	if (istype(W, /obj/item/weapon/weldingtool))
		if(src.status == 2)
			user << "\blue Сейчас ослабл&#255;ю усиленный стол..."
			playsound(src.loc, 'Welder.ogg', 50, 1)
			sleep(50)
			user << "\blue Стол ослаблен."
			src.status = 1
		else
			user << "\blue Теперь усиливаю стол..."
			playsound(src.loc, 'Welder.ogg', 50, 1)
			sleep(50)
			user << "\blue Стол усилен."
			src.status = 2
		return

	if (istype(W, /obj/item/weapon/wrench))
		if(src.status == 1)
			user << "\blue Теперь разбираю усиленный стол..."
			playsound(src.loc, 'Ratchet.ogg', 50, 1)
			sleep(50)
			new /obj/item/weapon/table_parts/reinforced( src.loc )
			playsound(src.loc, 'Deconstruct.ogg', 50, 1)
			qdel(src)
			return
	user.drop_item()
	if(W && W.loc && !W.is_module)	W.loc = src.loc
	return

/obj/rack/ex_act(severity)
	switch(severity)
		if(1.0)
			qdel(src)
			return
		if(2.0)
			if (prob(50))
				qdel(src)
				return
		if(3.0)
			if (prob(25))
				src.icon_state = "rackbroken"
				src.density = 0
		else
	return

/obj/rack/blob_act()
	if(prob(50))
		qdel(src)
		return
	else if(prob(50))
		src.icon_state = "rackbroken"
		src.density = 0
		return

/obj/rack/CanPass(atom/movable/mover, turf/target, height=0, air_group=0)
	if(air_group || (height==0)) return 1

	if (mover.flags & 2)
		return 1
	else
		return 0

/obj/rack/MouseDrop_T(obj/O as obj, mob/user as mob)
	if ((!( istype(O, /obj/item/weapon) ) || user.equipped() != O))
		return
	user.drop_item()
	if (O.loc != src.loc)
		step(O, get_dir(O, src))
	return

/obj/rack/attackby(obj/item/weapon/W as obj, mob/user as mob)
	if (istype(W, /obj/item/weapon/wrench))
		new /obj/item/weapon/rack_parts( src.loc )
		playsound(src.loc, 'Ratchet.ogg', 50, 1)
		//SN src = null
		qdel(src)
		return
	user.drop_item()
	if(W && W.loc && !W.is_module)	W.loc = src.loc
	return

/obj/rack/meteorhit(obj/O as obj)
	if(prob(75))
		qdel(src)
		return
	else
		src.icon_state = "rackbroken"
		src.density = 0
	return