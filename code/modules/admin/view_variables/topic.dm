
/client/proc/view_var_Topic(href, href_list, hsrc)
	//This should all be moved over to datum/admins/Topic() or something ~Carn
	if( (usr.client != src) || !src.holder )
		return
	if(href_list["Vars"])
		debug_variables(locate(href_list["Vars"]))

	//~CARN: for renaming mobs (updates their name, real_name, mind.name, their ID/PDA and datacore records).
	else if(href_list["rename"])
		var/mob/M = locate(href_list["rename"])
		if(!istype(M))
			to_chat(usr, "This can only be used on instances of type /mob")
			return

		var/new_name = sanitize(input(usr,"What would you like to name this mob?","Input a name",M.real_name) as text|null, 30)
		if(!new_name || !M)	return

		message_admins("Admin [key_name_admin(usr)] renamed [key_name_admin(M)] to [new_name].")
		M.real_name = new_name
		M.name = M.real_name
		href_list["datumrefresh"] = href_list["rename"]

	else if(href_list["varnameedit"] && href_list["datumedit"])
		var/D = locate(href_list["datumedit"])
		if(!istype(D,/datum) && !istype(D,/client))
			to_chat(usr, "This can only be used on instances of types /client or /datum")
			return

		modify_variables(D, href_list["varnameedit"], 1)

	else if(href_list["varnamechange"] && href_list["datumchange"])
		var/D = locate(href_list["datumchange"])
		if(!istype(D,/datum) && !istype(D,/client))
			to_chat(usr, "This can only be used on instances of types /client or /datum")
			return

		modify_variables(D, href_list["varnamechange"], 0)

	else if(href_list["varnamemass"] && href_list["datummass"])
		return
		/*var/atom/A = locate(href_list["datummass"])
		if(!istype(A))
			to_chat(usr, "This can only be used on instances of type /atom")
			return

		cmd_mass_modify_object_variables(A, href_list["varnamemass"])*/

	else if(href_list["delthis"])
		var/obj/O = locate(href_list["delthis"])
		if(!isobj(O))
			to_chat(usr, "This can only be used on instances of type /obj")
			return
		cmd_admin_delete(O)

	else if(href_list["delall"])
		var/obj/O = locate(href_list["delall"])
		if(!isobj(O))
			to_chat(usr, "This can only be used on instances of type /obj")
			return

		var/action_type = alert("Strict type ([O.type]) or type and all subtypes?",,"Strict type","Type and subtypes","Cancel")
		if(action_type == "Cancel" || !action_type)
			return

		if(alert("Are you really sure you want to delete all objects of type [O.type]?",,"Yes","No") != "Yes")
			return

		if(alert("Second confirmation required. Delete?",,"Yes","No") != "Yes")
			return

		var/O_type = O.type
		switch(action_type)
			if("Strict type")
				var/i = 0
				for(var/obj/Obj in world)
					if(Obj.type == O_type)
						i++
						qdel(Obj)
				if(!i)
					to_chat(usr, "No objects of this type exist")
					return
				log_admin("[key_name(usr)] deleted all objects of type [O_type] ([i] objects deleted)")
				message_admins("<span class='notice'>[key_name(usr)] deleted all objects of type [O_type] ([i] objects deleted)</span>")
			if("Type and subtypes")
				var/i = 0
				for(var/obj/Obj in world)
					if(istype(Obj,O_type))
						i++
						qdel(Obj)
				if(!i)
					to_chat(usr, "No objects of this type exist")
					return
				log_admin("[key_name(usr)] deleted all objects of type or subtype of [O_type] ([i] objects deleted)")
				message_admins("<span class='notice'>[key_name(usr)] deleted all objects of type or subtype of [O_type] ([i] objects deleted)</span>")

	if(href_list["datumrefresh"])
		var/datum/DAT = locate(href_list["datumrefresh"])
		if(istype(DAT, /datum) || istype(DAT, /client))
			debug_variables(DAT)

	return
