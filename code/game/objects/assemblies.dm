/obj/item/device/transfer_valve
	icon = 'assemblies.dmi'
	name = "перепускной клапан бака" // because that's what it is exadv1 and don't you dare change it

	nominative = "перепускной клапан бака" //кто? что? лестница
	genitive = "перепускного клапана бака" //кого? чего? лестницы
	dative = "перепускному клапану бака"  //кому?  чему? лестнице
	accusative = "перепускного клапана бака" //кого? что?
	instrumentative = "перепускным клапаном бака" //кем? чем? лестницей
	prepositive = "пропускном клапаном бака" //о ком? о чем? лестнице

	icon_state = "valve_1"
	desc = "Регулирует транспортировку воздуха между двумя баками."
	var/obj/item/weapon/tank/tank_one
	var/obj/item/weapon/tank/tank_two
	var/obj/item/device/attached_device
	var/mob/attacher = "Unknown"
	var/valve_open = 0
	var/toggle = 1


	attackby(obj/item/item, mob/user)
		if(istype(item, /obj/item/weapon/tank))
			if(tank_one && tank_two)
				user << "\red И без того два бака соединены, нужно отсоединить хоть один!"
				return

			if(!tank_one)
				tank_one = item
				user.drop_item()
				item.loc = src
				user << "\blue Я присоединяю бак к перепускному клапану."
			else if(!tank_two)
				tank_two = item
				user.drop_item()
				item.loc = src
				user << "\blue Я присоединяю бак к перепускному клапану."

			update_icon()

		else if(istype(item, /obj/item/device/radio/signaler) || istype(item, /obj/item/device/timer) || istype(item, /obj/item/device/infra) || istype(item, /obj/item/device/prox_sensor))
			if(attached_device)
				user << "\red И без того устройство присоединено к клапану, нужно сначала его отсоединить!"
				return

			attached_device = item
			user.drop_item()
			item.loc = src
			user << "\blue Я присоединяю <b>[item.accusative]</b> к контрольной панели клапана."
			item.master = src

			bombers += "<b>[key_name(user)]</b> присоединяет <b>[item.accusative]</b> к перепускному клапану."
			message_admins("<b>[key_name_admin(user)]</b> присоединяет <b>[item.accusative]</b> к перепускному клапану.")
			attacher = key_name(user)



		return


	attack_self(mob/user as mob)
		user.machine = src
		var/dat = {"<B> Свойства клапана: </B>
		<BR> <B> Первый бак:</B> [tank_one] [tank_one.nominative ? "<A href='?src=\ref[src];tankone=1'>Отсоединить</A>" : ""]
		<BR> <B> Второй бак:</B> [tank_two] [tank_two.nominative ? "<A href='?src=\ref[src];tanktwo=1'>Отсоединить</A>" : ""]
		<BR> <B> Подсоединенное устройство:</B> [attached_device.nominative ? "<A href='?src=\ref[src];device=1'>[attached_device]</A>" : "Отсутствует"] [attached_device ? "<A href='?src=\ref[src];rem_device=1'>Отсоединить</A>" : ""]
		<BR> <B> Статус пропускного клапана: </B> [ valve_open ? "<A href='?src=\ref[src];open=1'>Закрыт</A> <B>Открыт</B>" : "<B>Закрыт</B> <A href='?src=\ref[src];open=1'>Открыт</A>"]"}

		user << browse(dat, "window=trans_valve;size=600x300")
		onclose(user, "trans_valve")
		return


	Topic(href, href_list)
		..()
		if (usr.stat|| usr.restrained())
			return
		if (src.loc == usr)
			if(href_list["tankone"])
				tank_one.loc = get_turf(src)
				tank_one = null
				update_icon()
			if(href_list["tanktwo"])
				tank_two.loc = get_turf(src)
				tank_two = null
				update_icon()
			if(href_list["open"])
				toggle_valve()
			if(href_list["rem_device"])
				attached_device.loc = get_turf(src)
				attached_device = null
				update_icon()
			if(href_list["device"])
				attached_device.attack_self(usr)

			src.attack_self(usr)

			src.add_fingerprint(usr)
			return

	receive_signal(signal)
		if(toggle)
			toggle = 0
			toggle_valve()
			spawn(50) // To stop a signal being spammed from a proxy sensor constantly going off or whatever
				toggle = 1

	process()

	proc
		update_icon()
			src.overlays = new/list()
			src.underlays = new/list()
			if(!tank_one && !tank_two && !attached_device)
				icon_state = "valve_1"
				return
			icon_state = "valve"
			var/tank_one_icon = ""
			var/tank_two_icon = ""
			if(tank_one)
				tank_one_icon = tank_one.icon_state
			if(tank_two)
				tank_two_icon = tank_two.icon_state
			if(tank_one)
				var/icon/I = new(src.icon, icon_state = "[tank_one_icon]")
				//var/obj/overlay/tank_one_overlay = new
				//tank_one_overlay.icon = src.icon
				//tank_one_overlay.icon_state = tank_one_icon
				src.underlays += I
			if(tank_two)
				var/icon/J = new(src.icon, icon_state = "[tank_two_icon]")
				//I.Flip(EAST) this breaks the perspective!
				J.Shift(WEST, 13)
				//var/obj/underlay/tank_two_overlay = new
				//tank_two_overlay.icon = I
				src.underlays += J
			if(attached_device)
				var/icon/K = new(src.icon, icon_state = "device")
				//var/obj/overlay/device_overlay = new
				//device_overlay.icon = src.icon
				//device_overlay.icon_state = device_icon
				src.overlays += K

		/*
		Exadv1: I know this isn't how it's going to work, but this was just to check
		it explodes properly when it gets a signal (and it does).
		*/

		toggle_valve()
			src.valve_open = !valve_open
			if(valve_open && (tank_one && tank_two))
				var/turf/bombturf = get_turf(src)
				var/bombarea = bombturf.loc.name

				bombers += "Клапан бомбы открыт в <b>[bombarea]</b>, присоединил устройство ко клапану: <b>[attacher]</b>. Последние отпечатки: <b>[src.fingerprintslast]</b>"
				message_admins("Клапан бомбы открыт в <b>[bombarea]</b>, присоединил устройство ко клапану: <b>[attacher]</b>. Последние отпечатки: <b>[src.fingerprintslast]</b>")

				var/datum/gas_mixture/temp
				temp = tank_one.air_contents.remove_ratio(1)

				tank_two.air_contents.volume = tank_two.air_contents.volume + tank_one.air_contents.volume
				tank_two.air_contents.merge(temp)
				spawn(20) // In case one tank bursts
					src.update_icon()


		// this doesn't do anything but the timer etc. expects it to be here
		// eventually maybe have it update icon to show state (timer, prox etc.) like old bombs
		c_state()
			return
