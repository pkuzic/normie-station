/obj/multiz
	icon = 'multiz.dmi'
	density = 0
	opacity = 0
	anchored = 1
	var/istop = 1

	CanPass(obj/mover, turf/source, height, airflow)
		return airflow || !density

/obj/multiz/proc/targetZ()
	return src.z + (istop ? 1 : -1)

/obj/multiz/ladder
	icon_state = "ladderdown"
	name = "лестница"

	nominative = "лестница" //кто? что? лестница
	genitive = "лестницы" //кого? чего? лестницы
	dative = "лестнице"  //кому?  чему? лестнице
	accusative = "лестницу" //кого? что?
	instrumentative = "лестницей" //кем? чем? лестницей
	prepositive = "лестнице" //о ком? о чем? лестнице

	desc = "Шаг вверх, шаг вниз. Удивительное изобретение, позволяющее ходить туда-обратно."

/obj/multiz/ladder/New()
	..()
	if (!istop)
		icon_state = "ladderup"
	else
		icon_state = "ladderdown"

/obj/multiz/ladder/attack_paw(var/mob/M)
	return attack_hand(M)

/obj/multiz/ladder/attackby(var/W, var/mob/M)
	return attack_hand(M)

/obj/multiz/ladder/attack_hand(var/mob/M)
	M.Move(locate(src.x, src.y, targetZ()))

/obj/multiz/ladder/blob_act()
	var/newblob = 1
	for(var/obj/blob in locate(src.x, src.y, targetZ()))
		newblob = 0
	if(newblob)
		new /obj/blob(locate(src.x, src.y, targetZ()))

//Stairs.  var/dir on all four component objects should be the dir you'd walk from top to bottom
/obj/multiz/stairs
	name = "ступеньки"
	desc = "Не так удивительно, как лестница - но тоже справляется со своей функцией."

	nominative = "ступеньки" //кто? что? лестница
	genitive = "ступенек" //кого? чего? лестницы
	dative = "ступенькам"  //кому?  чему? лестнице
	accusative = "ступенек" //кого? что?
	instrumentative = "ступеньками" //кем? чем? лестницей
	prepositive = "ступеньках" //о ком? о чем? лестнице

	icon_state = "ramptop"

/obj/multiz/stairs/New()
	icon_state = istop ^ istype(src, /obj/multiz/stairs/active) ? "ramptop" : "rampbottom"

/obj/multiz/stairs/enter/bottom
	istop = 0

/obj/multiz/stairs/active
	density = 1

/obj/multiz/stairs/active/Bumped(var/atom/movable/M)
	if(istype(src, /obj/multiz/stairs/active/bottom) && !locate(/obj/multiz/stairs/enter) in M.loc)
		return //If on bottom, only let them go up stairs if they've moved to the entry tile first.
	//If it's the top, they can fall down just fine.
	if(ismob(M) && M:client)
		M:client.moving = 1
	M.Move(locate(src.x, src.y, targetZ()))
	if (ismob(M) && M:client)
		M:client.moving = 0

/obj/multiz/stairs/active/Click()
	if(!istype(usr,/mob/dead/observer))
		return ..()
	usr.client.moving = 1
	usr.Move(locate(src.x, src.y, targetZ()))
	usr.client.moving = 0
/obj/multiz/stairs/active/bottom
	istop = 0
	opacity = 1
