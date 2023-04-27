#define REGULATE_RATE 5

/obj/item/weapon/smokebomb
	name = "Дымовая граната"

	nominative = "граната"
	genitive = "гранаты"
	dative = "гранате"
	accusative = "гранату"
	instrumentative = "гранатой"
	prepositive = "гранате"

	icon = 'grenade.dmi'
	icon_state = "flashbang"
	var/state = null
	var/det_time = 20.0
	w_class = 2.0
	item_state = "flashbang"
	throw_speed = 4
	throw_range = 20
	flags = FPRINT | TABLEPASS | ONBELT | USEDELAY
	var/datum/effects/system/bad_smoke_spread/smoke

/obj/item/weapon/incendiarygrenade
	name = "Зажигательная граната"

	nominative = "граната"
	genitive = "гранаты"
	dative = "гранате"
	accusative = "гранату"
	instrumentative = "гранатой"
	prepositive = "гранате"

	icon = 'grenade.dmi'
	icon_state = "flashbang"
	var/state = null
	var/firestrength = 100
	var/det_time = 20.0
	w_class = 2.0
	item_state = "flashbang"
	throw_speed = 4
	throw_range = 20
	flags =  FPRINT | TABLEPASS | CONDUCT | ONBELT

/obj/item/weapon/mustardbomb
	name = "Граната с горчичным газом"

	nominative = "граната"
	genitive = "гранаты"
	dative = "гранате"
	accusative = "гранату"
	instrumentative = "гранатой"
	prepositive = "гранате"

	icon = 'grenade.dmi'
	icon_state = "flashbang"
	var/state = null
	var/det_time = 40.0
	w_class = 2.0
	item_state = "flashbang"
	throw_speed = 4
	throw_range = 20
	flags =  FPRINT | TABLEPASS | CONDUCT | ONBELT
	var/datum/effects/system/mustard_gas_spread/mustard_gas

/obj/item/weapon/smokebomb/New()
	..()
	src.smoke = new /datum/effects/system/bad_smoke_spread/
	src.smoke.attach(src)
	src.smoke.set_up(10, 0, usr.loc)

/obj/item/weapon/mustardbomb/New()
	..()
	src.mustard_gas = new /datum/effects/system/mustard_gas_spread/
	src.mustard_gas.attach(src)
	src.mustard_gas.set_up(5, 0, usr.loc)

/obj/item/weapon/smokebomb/attackby(obj/item/weapon/W as obj, mob/user as mob)
	if (istype(W, /obj/item/weapon/screwdriver))
		if (src.det_time == 60)
			src.det_time = 20
			user.show_message("\blue Я [usr.gender == MALE ? "установил" : "установила"] таймер взрыва на <b>две</b> секунды.")
		else
			src.det_time = 60
			user.show_message("\blue Я [usr.gender == MALE ? "установил" : "установила"] таймер взрыва на <b>шесть</b> секунд.")
		src.add_fingerprint(user)
	return

/obj/item/weapon/incendiarygrenade/attackby(obj/item/weapon/W as obj, mob/user as mob)
	if (istype(W, /obj/item/weapon/screwdriver))
		if (src.det_time == 60)
			src.det_time = 30
			user.show_message("\blue Я [usr.gender == MALE ? "установил" : "установила"] таймер взрыва на <b>две</b> секунды.")
		else
			src.det_time = 60
			user.show_message("\blue Я [usr.gender == MALE ? "установил" : "установила"] таймер взрыва на <b>шесть</b> секунд.")
		src.add_fingerprint(user)
	return

/obj/item/weapon/smokebomb/afterattack(atom/target as mob|obj|turf|area, mob/user as mob)
	if (user.equipped() == src)
		if (!( src.state ))
			//user << "\red You prime the smoke bomb! [det_time/10] seconds!"
			user << "\red <b>Пора бросать</b>!"
			src.state = 1
			src.icon_state = "flashbang1"
			playsound(src.loc, 'armbomb.ogg', 75, 1, -3)
			spawn( src.det_time )
				prime()
				return
		user.dir = get_dir(user, target)
		user.drop_item()
		var/t = (isturf(target) ? target : target.loc)
		walk_towards(src, t, 3)
		src.add_fingerprint(user)
	return

/obj/item/weapon/incendiarygrenade/afterattack(atom/target as mob|obj|turf|area, mob/user as mob)
	if (user.equipped() == src)
		if (!( src.state ))
			//user << "\red You prime the incendiary grenade! [det_time/10] seconds!"
			user << "\red <b>Пора бросать</b>!"
			src.state = 1
			src.icon_state = "flashbang1"
			playsound(src.loc, 'armbomb.ogg', 75, 1, -3)
			spawn( src.det_time )
				prime()
				return
		user.dir = get_dir(user, target)
		user.drop_item()
		var/t = (isturf(target) ? target : target.loc)
		walk_towards(src, t, 3)
		src.add_fingerprint(user)
	return

/obj/item/weapon/incendiarygrenade/attack_paw(mob/user as mob)
	return src.attack_hand(user)

/obj/item/weapon/incendiarygrenade/attack_hand()
	walk(src, null, null)
	..()
	return

/obj/item/weapon/smokebomb/attack_paw(mob/user as mob)
	return src.attack_hand(user)

/obj/item/weapon/smokebomb/attack_hand()
	walk(src, null, null)
	..()
	return

/obj/item/weapon/smokebomb/proc/prime()
	playsound(src.loc, 'smoke.ogg', 50, 1, -3)
	spawn(0)
		src.smoke.start()
		sleep(10)
		src.smoke.start()
		sleep(10)
		src.smoke.start()
		sleep(10)
		src.smoke.start()

	for(var/obj/blob/B in view(8,src))
		var/damage = round(30/(get_dist(B,src)+1))
		B.health -= damage
		B.update()
	sleep(80)
	del(src)
	return

/obj/item/weapon/incendiarygrenade/proc/prime()
	playsound(src.loc, 'bamf.ogg', 75, 1, -2)
	var/turf/T = src.loc
	var/turf/Tx1 = src.x + 1
	var/turf/Txm1 = src.x - 1
	var/turf/Ty1 = src.y + 1
	var/turf/Tym1 = src.y - 1
	for(var/turf/simulated/floor/target_tile in list(T,Tx1,Txm1,Ty1,Tym1))
		//if(target_tile.parent)// && target_tile.parent.group_processing)
			//target_tile.parent.suspend_group_processing()

		var/datum/gas_mixture/napalm = new
		var/datum/gas/volatile_fuel/fuel = new

		fuel.moles = 15
		napalm.trace_gases += fuel

		target_tile.assume_air(napalm)

		spawn target_tile.hotspot_expose(SPARK_TEMP, 400)

	for(var/obj/blob/B in view(8,src))
		var/damage = round(30/(get_dist(B,src)+1))
		B.health -= damage
		B.update()

	sleep(10)
	del(src)
	return


/obj/item/weapon/smokebomb/attack_self(mob/user as mob)
	if (!src.state)
		//user << "\red You prime the smoke bomb! [det_time/10] seconds!"
		user << "\red <b>Пора бросать</b>!"

		src.state = 1
		src.icon_state = "flashbang1"
		add_fingerprint(user)
		spawn( src.det_time )
			prime()
			return
	return

/obj/item/weapon/incendiarygrenade/attack_self(mob/user as mob)
	if (!src.state)
		//user << "\red You prime the incendiary grenade! [det_time/10] seconds!"
		user << "\red <b>Пора бросать</b>!"

		src.state = 1
		src.icon_state = "flashbang1"
		add_fingerprint(user)
		spawn( src.det_time )
			prime()
			return
	return





/obj/item/weapon/mustardbomb/attackby(obj/item/weapon/W as obj, mob/user as mob)
	if (istype(W, /obj/item/weapon/screwdriver))
		if (src.det_time == 80)
			src.det_time = 40
			user.show_message("\blue Я [usr.gender == MALE ? "установил" : "установила"] таймер взрыва на <b>четыре</b> секунды.")
			//src.desc = "It is set to detonate in 4 seconds."
		else
			src.det_time = 80
			user.show_message("\blue Я [usr.gender == MALE ? "установил" : "установила"] таймер взрыва на <b>восемь</b> секунд.")
			//src.desc = "It is set to detonate in 8 seconds."
		src.add_fingerprint(user)
	return

/obj/item/weapon/mustardbomb/afterattack(atom/target as mob|obj|turf|area, mob/user as mob)
	if (user.equipped() == src)
		if (!( src.state ))
			//user << "\red You prime the mustard gas bomb! [det_time/10] seconds!"
			src.state = 1
			src.icon_state = "flashbang1"
			playsound(src.loc, 'armbomb.ogg', 75, 1, -3)
			spawn( src.det_time )
				prime()
				return
		user.dir = get_dir(user, target)
		user.drop_item()
		var/t = (isturf(target) ? target : target.loc)
		walk_towards(src, t, 3)
		src.add_fingerprint(user)
	return

/obj/item/weapon/mustardbomb/attack_paw(mob/user as mob)
	return src.attack_hand(user)

/obj/item/weapon/mustardbomb/attack_hand()
	walk(src, null, null)
	..()
	return

/obj/item/weapon/mustardbomb/proc/prime()
	playsound(src.loc, 'smoke.ogg', 50, 1, -3)
	spawn(0)
		src.mustard_gas.start()
		sleep(10)
		src.mustard_gas.start()
		sleep(10)
		src.mustard_gas.start()
		sleep(10)
		src.mustard_gas.start()

	for(var/obj/blob/B in view(8,src))
		var/damage = round(30/(get_dist(B,src)+1))
		B.health -= damage
		B.update()
	sleep(100)
	del(src)
	return

/obj/item/weapon/mustardbomb/attack_self(mob/user as mob)
	if (!src.state)
		//user << "\red You prime the mustard gas bomb! [det_time/10] seconds!"
		src.state = 1
		src.icon_state = "flashbang1"
		add_fingerprint(user)
		spawn( src.det_time )
			prime()
			return
	return

/obj/item/weapon/storage/beakerbox
	name = "Коробка для мензурок"

	nominative = "коробка"
	genitive = "коробки"
	dative = "коробке"
	accusative = "коробку"
	instrumentative = "коробкой"
	prepositive = "коробке"

	icon_state = "beaker"
	item_state = "syringe_kit"

/obj/item/weapon/storage/beakerbox/New()
	..()
	new /obj/item/weapon/reagent_containers/glass/beaker( src )
	new /obj/item/weapon/reagent_containers/glass/beaker( src )
	new /obj/item/weapon/reagent_containers/glass/beaker( src )
	new /obj/item/weapon/reagent_containers/glass/beaker( src )
	new /obj/item/weapon/reagent_containers/glass/beaker( src )
	new /obj/item/weapon/reagent_containers/glass/beaker( src )
	new /obj/item/weapon/reagent_containers/glass/beaker( src )

/obj/item/weapon/storage/pillbottlebox
	name = "Коробка для медикаментов"

	nominative = "коробка"
	genitive = "коробки"
	dative = "коробке"
	accusative = "коробку"
	instrumentative = "коробкой"
	prepositive = "коробке"

	icon_state = "pillbottle"
	item_state = "syringe_kit"

/obj/item/weapon/storage/pillbottlebox/New()
	..()
	new /obj/item/weapon/storage/pill_bottle( src )
	new /obj/item/weapon/storage/pill_bottle( src )
	new /obj/item/weapon/storage/pill_bottle( src )
	new /obj/item/weapon/storage/pill_bottle( src )
	new /obj/item/weapon/storage/pill_bottle( src )
	new /obj/item/weapon/storage/pill_bottle( src )
	new /obj/item/weapon/storage/pill_bottle( src )

/obj/item/weapon/storage/trashcan
	name = "Утилизационный бак"
	desc = "Компактный бак для утилизации отходов."

	nominative = "мусорник"
	genitive = "мусорника"
	dative = "мусорнику"
	accusative = "мусорник"
	instrumentative = "мусорником"
	prepositive = "мусорнике"

	w_class = 4.0
	anchored = 1.0
	density = 1.0
	var/processing = null
	var/locked = 1
	req_access = list(access_janitor)
	icon = 'stationobjs.dmi'
	icon_state = "trashcan"
	item_state = "syringe_kit"

/obj/item/weapon/storage/trashcan/attackby(obj/item/weapon/W as obj, mob/user as mob)

	if (src.contents.len >= 7)
		user << "\red Бак переполнен!"
		return
	if (istype(W, /obj/item/weapon/disk/nuclear))
		user << "\red Ну уж нет."
		return
	if (istype(W, /obj/item/weapon/storage/))
		return
	if (istype(W, /obj/item/weapon/grab))
		user << "\red Места маловато."
		return
	var/t
	for(var/obj/item/weapon/O in src)
		t += O.w_class
		//Foreach goto(46)
	t += W.w_class
	if (t > 30)
		user << "\red Нельзя."
		return
	user.u_equip(W)
	W.loc = src
	if ((user.client && user.s_active != src))
		user.client.screen -= W
	src.orient2hud(user)
	W.dropped(user)
	add_fingerprint(user)
	user.visible_message("\blue <b>[user]</b> кладет <b>[W.accusative]</b> в <b>[src.nominative]</b>!")

	if (src.contents.len >= 7)
		src.locked = 1
		src.icon_state = "trashcan1"
	spawn (200)
		if (src.contents.len < 7)
			src.locked = 0
			src.icon_state = "trashcan"
	return

/obj/item/weapon/storage/trashcan/attack_hand(mob/user as mob)
	if(src.allowed(usr))
		locked = !locked
	else
		user << "\red В доступе отказано."
		return
	if (src.processing)
		return
	if (src.contents.len >= 7)
		user << "\blue Я начинаю вычищать мусорник."
		var/area/A = src.loc.loc		// make sure it's in an area
		if(!A || !isarea(A))
			return
//		var/turf/T = src.loc
		A.use_power(250, EQUIP)
		src.processing = 1
		src.contents.len = 0
		src.icon_state = "trashmelt"
		if (istype(loc, /turf))
			loc:hotspot_expose(1000,10)
		sleep (60)
		src.icon_state = "trashcan"
		src.processing = 0
		return
	else
		src.icon_state = "trashcan"
		user << "\red Нельзя очищать до тех пор, пока мусорник не заполнится."
		return


