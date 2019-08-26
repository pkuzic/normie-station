/obj/item/temperature_expose(datum/gas_mixture/air, exposed_temperature, exposed_volume)
	if(exposed_temperature >= 1643 && m_amt)
		var/obj/item/weapon/meltedmetal/S = new(src.loc)
		S.desc = "Похоже, что это напоминает [src.nominative]."
		S.m_amt = src.m_amt
		for(var/mob/M in viewers(5, S))
			M << "\red [src.nominative] расплавляется."
		del(src)
	else if(exposed_temperature >= 1650 && g_amt)
		var/obj/item/weapon/meltedmetal/S = new(src.loc)
		S.desc = "Похоже, что это напоминает [src.nominative]."
		S.g_amt = src.g_amt
		for(var/mob/M in viewers(5, S))
			M << "\red [src.nominative] расплавляется."
		del(src)
/obj/item/weapon/paper/temperature_expose(datum/gas_mixture/air, exposed_temperature, exposed_volume)
	if(exposed_temperature >= 373.15)
		for(var/mob/M in viewers(5, src))
			M << "\red [src.nominative] сгорает до тла."
		del(src)
/obj/item/weapon/bedsheet/ex_act(severity)
	if (severity <= 2)
		del(src)
		return
	return
/obj/item/weapon/pipesegment/
	name = "сегмент трубы"

	nominative = "сегмент трубы"
	genitive = "сегмента трубы"
	dative = "сегменту трубы"
	accusative = "сегмент трубы"
	instrumentative = "сегментом трубы"
	prepositive = "сегменте трубы"

	desc = "Используется для аварийной починки труб."
	icon = 'pipes.dmi'
	icon_state = "exposed"
	m_amt = 50
/obj/item/weapon/bedsheet/attack_self(mob/user as mob)
	user.drop_item()
	src.layer = 5
	add_fingerprint(user)
	return
/obj/item/weapon/cane
	name = "трость"

	nominative = "трость" //Кто? Что? (есть)
	genitive = "трости" //Кого? Чего? (нет)
	dative = "трости"  //Кому? Чему? (дам)
	accusative = "трость" //Кого? Что? (вижу)
	instrumentative = "тростью" //Кем? Чем? (горжусь)
	prepositive = "трости" //О ком? О чем? (думаю)

	desc = "Незаменимый друг и верный товарищ каждого хромого человека."
	icon = 'items.dmi'
	icon_state = "cane"
	m_amt = 5

/obj/item/weapon/meltedmetal
	name = "разрушенный металл"

	nominative = "разрушенный металл" //Кто? Что? (есть)
	genitive = "разрушенного металла" //Кого? Чего? (нет)
	dative = "разрушенному металлу"  //Кому? Чему? (дам)
	accusative = "разрушенный металл" //Кого? Что? (вижу)
	instrumentative = "разрушенным металлом" //Кем? Чем? (горжусь)
	prepositive = "разрушенном металле" //О ком? О чем? (думаю)

	desc = "Это случится и со мной."
	icon = 'chemical.dmi'
	icon_state = "molten"
	m_amt = 0
/obj/item/weapon/meltedglass
	name = "разбитое стекло"

	nominative = "разбитое стекло" //Кто? Что? (есть)
	genitive = "разбитого стекла" //Кого? Чего? (нет)
	dative = "разбитому стеклу"  //Кому? Чему? (дам)
	accusative = "разбитое стекло" //Кого? Что? (вижу)
	instrumentative = "разбитым стеклом" //Кем? Чем? (горжусь)
	prepositive = "разбитом стекле" //О ком? О чем? (думаю)

	desc = "Разбитые надежды."
	icon = 'chemical.dmi'
	icon_state = "molten"
	m_amt = 0
/obj/item/weapon/meltedmetal/temperature_expose()
	return
/obj/item/weapon/meltedglass/temperature_expose()
	return
/obj/item/weapon/handcuffs/attack(mob/M as mob, mob/user as mob)
	if ((usr.mutations & 16) && prob(50))
		usr << "\red Да как же этим пользоваться?!"
		if (istype(M, /mob/living/carbon/human))
			var/obj/equip_e/human/O = new /obj/equip_e/human(  )
			O.source = user
			O.target = user
			O.item = user.equipped()
			O.s_loc = user.loc
			O.t_loc = user.loc
			O.place = "handcuff"
			M.requests += O
			spawn( 0 )
				O.process()
				return
		return
	if (!(istype(usr, /mob/living/carbon/human) || ticker) && ticker.mode.name != "monkey")
		usr << "\red Я недостаточно [usr.gender == 1 ? "ловок" : "ловка"] для этого!"
		return
	if (istype(M, /mob/living/carbon/human))
		var/obj/equip_e/human/O = new /obj/equip_e/human(  )
		O.source = user
		O.target = M
		O.item = user.equipped()
		O.s_loc = user.loc
		O.t_loc = M.loc
		O.place = "handcuff"
		M.requests += O
		spawn( 0 )
			playsound(src.loc, 'handcuffs.ogg', 30, 1, -2)
			O.process()
			return
	else
		var/obj/equip_e/monkey/O = new /obj/equip_e/monkey(  )
		O.source = user
		O.target = M
		O.item = user.equipped()
		O.s_loc = user.loc
		O.t_loc = M.loc
		O.place = "handcuff"
		M.requests += O
		spawn( 0 )
			playsound(src.loc, 'handcuffs.ogg', 30, 1, -2)
			O.process()
			return
	return



/obj/item/weapon/extinguisher/New()
	var/datum/reagents/R = new/datum/reagents(50)
	reagents = R
	R.my_atom = src
	R.add_reagent("water", 50)

/obj/item/weapon/extinguisher/examine()
	set src in usr

	usr << text("\icon[] [] содержит ещё аж [] единиц воды!", src, src.name, src.reagents.total_volume)
	..()
	return

/obj/item/weapon/extinguisher/afterattack(atom/target, mob/user , flag)
	//TODO; Add support for reagents in water.

	if( istype(target, (/obj/reagent_dispensers/watertank || /obj/reagent_dispensers/hvwatertank)) && get_dist(src,target) <= 1)
		var/obj/o = target
		o.reagents.trans_to(src, 50)
		user << "\blue Огнетушитель заправлен"
		playsound(src.loc, 'zzzt.ogg', 50, 1, -6)
		return

	if (!safety)
		if (src.reagents.total_volume < 1)
			return

		if (world.time < src.last_use + 20)
			return

		src.last_use = world.time

		playsound(src.loc, 'spray.ogg', 75, 1, -3)

		var/direction = get_dir(src,target)

		var/turf/T = get_turf(target)
		var/turf/T1 = get_step(T,turn(direction, 90))
		var/turf/T2 = get_step(T,turn(direction, -90))

		var/list/the_targets = list(T,T1,T2)

		for(var/a=0, a<5, a++)
			spawn(0)
				var/obj/effects/water/W = new /obj/effects/water( get_turf(src) )
				var/turf/my_target = pick(the_targets)
				var/datum/reagents/R = new/datum/reagents(5)
				if(!W) return
				W.reagents = R
				R.my_atom = W
				if(!W || !src) return
				src.reagents.trans_to(W,1)
				for(var/b=0, b<5, b++)
					step_towards_3d(W,my_target)
					if(!W) return
					W.reagents.reaction(get_turf(W))
					for(var/atom/atm in get_turf(W))
						if(!W) return
						W.reagents.reaction(atm)
					if(W.loc == my_target) break
					sleep(2)

		if(istype(usr.loc, /turf/space))
			user.inertia_dir = get_dir(target, user)
			step(user, user.inertia_dir)

	else
		return ..()
	return

/obj/item/weapon/extinguisher/attack_self(mob/user as mob)
	if (safety)
		src.icon_state = "fire_extinguisher1"
		src.desc = "Предохранитель снят."
		user << "Предохранитель снят."
		safety = 0
	else
		src.icon_state = "fire_extinguisher0"
		src.desc = "На предохранителе."
		user << "На предохранителе."
		safety = 1
	return

/obj/item/weapon/pen/sleepypen/attack_paw(mob/user as mob)
	return src.attack_hand(user)
	return

/obj/item/weapon/pen/sleepypen/New()
	var/datum/reagents/R = new/datum/reagents(150)
	reagents = R
	R.my_atom = src
	R.add_reagent("stoxin", 150)
	..()
	return

/obj/item/weapon/pen/sleepypen/attack(mob/M as mob, mob/user as mob)
	if (!( istype(M, /mob) ))
		return
	if (reagents.total_volume)
		//for(var/mob/O in viewers(M, null))
		//	O.show_message(text("\red [] has been stabbed with [] by [].", M, src, user), 1)
		user << "\red Ты укалываешь [M] ручкой."
	//	if(prob(50)) // Is this the best solution? Feels a bit illogical not to feel something. //Googol: Makes the sleepy pen USELESS though
	//		M << "\red You feel a tiny prick!"
		spawn(500)
			if(M.reagents) reagents.trans_to(M, 50)
	return

/obj/item/weapon/Bump(mob/M as mob)
	spawn( 0 )
		..()
	return

/obj/manifest/New()

	src.invisibility = 101
	return

/obj/manifest/proc/manifest()
	var/dat = "<B>Список экипажа</B>:<BR>"
	for(var/mob/living/carbon/human/M in world)
		dat += text("    <B>[]</B> -  []<BR>", M.name, (istype(M.wear_id, /obj/item/weapon/card/id) ? text("[]", M.wear_id.assignment) : "Местоположение неизвестно"))
	var/obj/item/weapon/paper/P = new /obj/item/weapon/paper( src.loc )
	P.info = dat
	P.name = "бумага - 'Список экипажа'"
	//SN src = null
	del(src)
	return

/obj/screen/close/DblClick()
	if (src.master)
		src.master:close(usr)
	return


/mob/attackby(obj/item/weapon/W as obj, mob/user as mob)
	if ( istype(W, /obj/item/weapon/reagent_containers/syringe) && istype(src, /mob/living/silicon/ai) ) // The cyborgs have their own attackby
		return
	var/shielded = 0
	for(var/obj/item/device/shield/S in src)
		if (S.active)
			shielded = 1
		else
	if (locate(/obj/item/weapon/grab, src))
		var/mob/safe = null
		if (istype(src.l_hand, /obj/item/weapon/grab))
			var/obj/item/weapon/grab/G = src.l_hand
			if ((G.state == 3 && get_dir(src, user) == src.dir))
				safe = G.affecting
		if (istype(src.r_hand, /obj/item/weapon/grab))
			var/obj/item/weapon/grab/G = src.r_hand
			if ((G.state == 3 && get_dir(src, user) == src.dir))
				safe = G.affecting
		if (safe)
			return safe.attackby(W, user)
	if (!shielded || (shielded && (prob(65))))
		spawn(0)
			W.attack(src, user)
			return
	return



/obj/item/weapon/teleportation_scroll/attack_self(mob/user as mob)
	user.machine = src
	var/dat = "<B>Свиток телепортации:</B><BR>"
	dat += "Количество зарядов: [src.uses]<BR>"
	dat += "<HR>"
	dat += "<B>Четыре заряда, пользуйтесь с умом:</B><BR>"
	dat += "<A href='byond://?src=\ref[src];spell_teleport=1'>Телепортация</A><BR>"
	dat += "С уважением,<br>Федерация Магов<br><br>P.S.Не забудьте взять с собой свое снаряжение, оно понадобится Вам для наложения заклинаний.<HR>"
	user << browse(dat, "window=scroll")
	onclose(user, "scroll")
	return

/obj/item/weapon/teleportation_scroll/Topic(href, href_list)
	..()
	if (usr.stat || usr.restrained())
		return
	var/mob/living/carbon/human/H = usr
	if (!( istype(H, /mob/living/carbon/human)))
		return 1
	if ((usr.contents.Find(src) || (in_range(src, usr) && istype(src.loc, /turf))))
		usr.machine = src
		if (href_list["spell_teleport"])
			if (src.uses >= 1)
				src.uses -= 1
				usr.teleportscroll()
		if (istype(src.loc, /mob))
			attack_self(src.loc)
		else
			for(var/mob/M in viewers(1, src))
				if (M.client)
					src.attack_self(M)
	return




/obj/item/brain/attack(mob/living/carbon/M as mob, mob/living/carbon/user as mob)
	if(!istype(M, /mob))
		return

	src.add_fingerprint(user)

	if(!(user.zone_sel.selecting == ("head")) || !istype(M, /mob/living/carbon/human))
		return ..()

	if(!(locate(/obj/machinery/optable, M.loc) && M.resting))
		return ..()

	var/mob/living/carbon/human/H = M
	if(istype(M, /mob/living/carbon/human) && ((H.head && H.head.flags & HEADCOVERSEYES) || (H.wear_mask && H.wear_mask.flags & MASKCOVERSEYES) || (H.glasses && H.glasses.flags & GLASSESCOVERSEYES)))
		// you can't stab someone in the eyes wearing a mask!
		user << "\blue Для начала стоит оголить голову."
		return

//since these people will be dead M != usr

	if(M:brain_op_stage == 4.0)
		for(var/mob/O in viewers(M, null))
			if(O == (user || M))
				continue
			if(M == user)
				O.show_message(text("\red <b>[user]</b> вставляет <b>[src.nominative]</b> в свою голову!"), 1)
			else
				O.show_message(text("\red <b>[user]</b> вставляет <b>[src.nominative]</b> в голову <b>[M]</b>."), 1)

		if(M != user)
			M << "\red <b>[user]</b> вставляет <b>[src.nominative]</b> в твою голову!"
			user << "\red Ты вставляешь <b>[src.nominative]</b> в голову <b>[M]</b>!"
		else
			user << "\red Ты вставляешь <b>[src.nominative]</b> в свою голову!"

		if(M.client)
			M.client.mob = new/mob/dead/observer(M)
		//a mob can't have two clients so get rid of one

		if(src.owner)
		//if the brain has an owner corpse
			if(src.owner.client)
			//if the player hasn't ghosted
				src.owner.client.mob = M
				//then put them in M
			else
			//if the player HAS ghosted
				for(var/mob/dead/observer/O in world)
					if(O.corpse == src.owner && O.client)
					//find their ghost
						O.client.mob = M
						//put their mob in M
						del(O)
						//delete thier ghost

		M:brain_op_stage = 3.0

		del(src)
	else
		..()
	return

/obj/item/weapon/stamp/attack_paw(mob/user as mob)

	return src.attack_hand(user)

/obj/item/weapon/stamp/New()

	..()
	return
