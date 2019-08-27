
// Keep these two together, they *must* be defined on both
// If /client ever becomes /datum/client or similar, they can be merged
/datum/proc/get_view_variables_header()
	return "<b>[src]</b>"

/atom/get_view_variables_header()
	return {"
		<a href='?_src_=vars;datumedit=\ref[src];varnameedit=name'><b>[src]</b></a>
		<br><font size='1'>
		<a href='?_src_=vars;datumedit=\ref[src];varnameedit=dir'>[dir2text(dir)]</a>
		</font>
		"}

/mob/living/get_view_variables_header()
	return {"
		<a href='?_src_=vars;rename=\ref[src]'><b>[src]</b></a><font size='1'>
		"}

// Same for these as for get_view_variables_header() above
/datum/proc/get_view_variables_options()
	return ""

/mob/get_view_variables_options()
	return ..()

/mob/living/carbon/human/get_view_variables_options()
	return ..()

/obj/get_view_variables_options()
	return ..() + {"
		<option value='?_src_=vars;delthis=\ref[src]'>Delete instance</option>
		<option value='?_src_=vars;delall=\ref[src]'>Delete all of type</option>
		"}

/turf/get_view_variables_options()
	return ..()

/datum/proc/get_variables()
	. = vars - VV_hidden()

/datum/proc/get_variable_value(varname)
	return vars[varname]

/datum/proc/set_variable_value(varname, value)
	vars[varname] = value

/datum/proc/get_initial_variable_value(varname)
	return initial(vars[varname])

/datum/proc/make_view_variables_variable_entry(var/varname, var/value, var/hide_watch = 0)
	return {"
			(<a href='?_src_=vars;datumedit=\ref[src];varnameedit=[varname]'>E</a>)
			(<a href='?_src_=vars;datumchange=\ref[src];varnamechange=[varname]'>C</a>)
			(<a href='?_src_=vars;datummass=\ref[src];varnamemass=[varname]'>M</a>)
			"}

// No mass editing of clients
/*client/make_view_variables_variable_entry(var/varname, var/value, var/hide_watch = 0)
	return {"
			(<a href='?_src_=vars;datumedit=\ref[src];varnameedit=[varname]'>E</a>)
			(<a href='?_src_=vars;datumchange=\ref[src];varnamechange=[varname]'>C</a>)
			"}*/

// These methods are all procs and don't use stored lists to avoid VV exploits

// The following vars cannot be viewed by anyone
/datum/proc/VV_hidden()
	return list()

/datum/proc/may_edit_var(var/user, var/var_to_edit)
	if(!user)
		return FALSE
	if(!(var_to_edit in vars))
		to_chat(user, "<span class='warning'>\The [src] does not have a var '[var_to_edit]'</span>")
		return FALSE
	return TRUE
