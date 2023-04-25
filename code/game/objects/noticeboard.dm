/obj/noticeboard

//attaching papers!!
/obj/noticeboard/attackby(var/obj/item/weapon/O as obj, var/mob/user as mob)
	if (istype(O, /obj/item/weapon/paper))
		if (src.notices < 5)
			O.add_fingerprint(user)
			src.add_fingerprint(user)
			user.drop_item()
			O.loc = src
			src.notices++
			src.icon_state = text("nboard0[]", src.notices) //update sprite
			user << "\blue Я прикрепляю бумагу к доске объявлений."
		else
			user << "\red Если я прикреплю бумагу к этой доске объявлений, то её никто не заметит. Не дела."

/obj/noticeboard/attack_hand(user as mob)
	var/dat = "<B>Доска объявлений</B><BR>"
	for(var/obj/item/weapon/paper/P in src)
		dat += text("<A href='?src=\ref[];read=\ref[]'>[]</A> <A href='?src=\ref[];write=\ref[]'>Write</A> <A href='?src=\ref[];remove=\ref[]'>Убрать</A><BR>", src, P, P.name, src, P, src, P)
	user << browse("<HEAD><TITLE>Объявления</TITLE></HEAD>[dat]","window=noticeboard")
	onclose(user, "noticeboard")


/obj/noticeboard/Topic(href, href_list)
	..()
	usr.machine = src
	if (href_list["remove"])
		if ((usr.stat || usr.restrained())) //For when a player is handcuffed while they have the notice window open
			usr << "\red Не могу, пока мои руки скованы."
			return
		var/obj/item/P = locate(href_list["remove"])
		if ((P && P.loc == src))
			P.loc = get_turf(src) //dump paper on the floor because you're a clumsy fuck
			P.layer = 20
			P.add_fingerprint(usr)
			src.add_fingerprint(usr)
			src.notices--
			src.icon_state = text("nboard0[]", src.notices)

	if(href_list["write"])
		if ((usr.stat || usr.restrained())) //For when a player is handcuffed while they have the notice window open
			usr << "\red Не могу, пока мои руки скованы."
			return
		var/obj/item/P = locate(href_list["write"])

		if((P && P.loc == src)) //if the paper's on the board
			if (istype(usr.r_hand, /obj/item/weapon/pen)) //and you're holding a pen
				src.add_fingerprint(usr)
				P.attackby(usr.r_hand, usr) //then do ittttt
			else
				if (istype(usr.l_hand, /obj/item/weapon/pen)) //check other hand for pen
					src.add_fingerprint(usr)
					P.attackby(usr.l_hand, usr)
				else
					usr << "\red А ручку бы!"

	if (href_list["read"])
		var/obj/item/weapon/paper/P = locate(href_list["read"])
		if ((P && P.loc == src))
			if (!( istype(usr, /mob/living/carbon/human) ))
				usr << browse(text("<HTML><HEAD><TITLE>[]</TITLE></HEAD><BODY><TT>[]</TT></BODY></HTML>", P.name, Ellipsis(P.info)), text("window=[]", P.name))
				onclose(usr, "[P.name]")
			else
				usr << browse(text("<HTML><HEAD><TITLE>[]</TITLE></HEAD><BODY><TT>[]</TT></BODY></HTML>", P.name, P.info), text("window=[]", P.name))
				onclose(usr, "[P.name]")
	return
