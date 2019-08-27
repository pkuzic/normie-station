client
	Topic(href, href_list, hsrc)
		switch(href_list["_src_"])
			if("vars")		return view_var_Topic(href,href_list,hsrc)
		..()

/mob/proc/Delete(atom/A in view())
	set category = "Debug"
	switch (alert("Are you sure you wish to delete \the [A.name] at ([A.x],[A.y],[A.z]) ?", "Admin Delete Object","Yes","No"))
		if("Yes")
			log_admin("[usr.key] deleted [A.name] at ([A.x],[A.y],[A.z])")
