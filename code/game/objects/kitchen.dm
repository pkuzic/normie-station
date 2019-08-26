/obj/kitchenspike/attack_paw(mob/user as mob)
	return src.attack_hand(usr)

/obj/kitchenspike/attackby(obj/item/weapon/grab/G as obj, mob/user as mob)
	if(!istype(G, /obj/item/weapon/grab))
		return
	if(!istype(G.affecting, /mob/living/carbon/monkey))
		user << "\red Слишком велико для шипа, надо бы чего поменьше!"
		return

	if(src.occupied == 0)
		src.icon_state = "spikebloody"
		src.occupied = 1
		src.meat = 5
		var/mob/dead/observer/newmob
		for(var/mob/O in viewers(src, null))
			O.show_message(text("\red <b>[user]</b> насаживает <b>[G.affecting]</b> на шип, таким образом убивая!"))
		if (G.affecting.client)
			newmob = new/mob/dead/observer(G.affecting)
			G.affecting:client:mob = newmob
			newmob:client:eye = newmob
		del(G.affecting)
		del(G)

	else
		user << "\red На шипе и без того обезьяна, сначала бы собрать её мясо!"

/obj/kitchenspike/attack_hand(mob/user as mob)
	if(..())
		return
	if(src.occupied)
		if(src.meat > 1)
			src.meat--
			new /obj/item/weapon/reagent_containers/food/snacks/monkeymeat( src.loc )
			usr << "Ты снимаешь мясо с обезьяны."
		else if(src.meat == 1)
			src.meat--
			new /obj/item/weapon/reagent_containers/food/snacks/monkeymeat(src.loc)
			usr << "Ты снимаешь последний кусок мяса с обезьяны!"
			src.icon_state = "spike"
			src.occupied = 0


