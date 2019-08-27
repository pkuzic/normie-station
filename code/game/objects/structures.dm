obj/structure
	icon = 'structures.dmi'

	girder
		icon_state = "girder"
		anchored = 1
		density = 1
		var/state = 0

		displaced
			icon_state = "displaced"
			anchored = 0

		reinforced
			icon_state = "reinforced"
			state = 2

/obj/structure/girder/attackby(obj/item/weapon/W as obj, mob/user as mob)
	if(istype(W, /obj/item/weapon/wrench) && state == 0 && anchored && !istype(src,/obj/structure/girder/displaced))
		playsound(src.loc, 'Ratchet.ogg', 100, 1)
		var/turf/T = get_turf(user)
		user << "\blue Сейчас разбираю балку."
		sleep(40)
		if(get_turf(user) == T)
			user << "\blue Ты разбираешь балку!"
			new /obj/item/weapon/sheet/metal(get_turf(src))
			del(src)

	else if(istype(W, /obj/item/weapon/screwdriver) && state == 2 && istype(src,/obj/structure/girder/reinforced))
		playsound(src.loc, 'Screwdriver.ogg', 100, 1)
		var/turf/T = get_turf(user)
		user << "\blue Теперь откручиваю опорные стойки..."
		sleep(40)
		if(get_turf(user) == T)
			user << "\blue Ты откручиваешь опорные стойки!"
			state = 1

	else if(istype(W, /obj/item/weapon/wirecutters) && istype(src,/obj/structure/girder/reinforced) && state == 1)
		playsound(src.loc, 'Wirecutter.ogg', 100, 1)
		var/turf/T = get_turf(user)
		user << "\blue Убираю опорные стойки..."
		sleep(40)
		if(get_turf(user) == T)
			user << "\blue Ты убираешь опорные стойки!"
			new/obj/structure/girder( src.loc )
			del(src)

	else if(istype(W, /obj/item/weapon/crowbar) && state == 0 && anchored )
		playsound(src.loc, 'Crowbar.ogg', 100, 1)
		var/turf/T = get_turf(user)
		user << "\blue Сейчас смещаю балки..."
		sleep(40)
		if(get_turf(user) == T)
			user << "\blue Ты смещаешь балки!"
			new/obj/structure/girder/displaced( src.loc )
			del(src)

	else if(istype(W, /obj/item/weapon/wrench) && state == 0 && !anchored )
		playsound(src.loc, 'Ratchet.ogg', 100, 1)
		var/turf/T = get_turf(user)
		user << "\blue Наконец креплю балки..."
		sleep(40)
		if(get_turf(user) == T)
			user << "\blue Ты закрепл&#255;ешь балки!"
			new/obj/structure/girder( src.loc )
			del(src)

	else if((istype(W, /obj/item/weapon/sheet/metal)) && (W:amount >= 2))
		var/turf/T = get_turf(user)
		user << "\blue Вот теперь добавлю обшивочку..."
		sleep(40)
		if (W && get_turf(user) == T)
			user << "\blue Ты добавл&#255;ешь обшивку!"
			var/turf/Tsrc = get_turf(src)
			Tsrc.ReplaceWithWall()
			W:amount -= 2
			if(W:amount <= 0)
				del(W)
			del(src)
		return

	else if (istype(W, /obj/item/weapon/sheet/r_metal))
		var/turf/T = get_turf(user)
		if (src.icon_state == "reinforced") //Time to finalize!
			user << "\blue Сейчас заканчиваю усиленную стену...."
			sleep(50)
			if(W && get_turf(user) == T)
				user << "\blue Стена усилена!"
				var/turf/Tsrc = get_turf(src)
				Tsrc.ReplaceWithRWall()
				W:amount--
				if (W:amount <= 0)
					del(W)
				del(src)
				return
		else
			user << "\blue Сейчас укрепл&#255;ю балочки..."
			sleep(60)
			user << "\blue Балки усилены!"
			new/obj/structure/girder/reinforced( src.loc )
			del(src)
			return
	else
		..()