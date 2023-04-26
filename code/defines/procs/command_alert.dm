/proc/command_alert(var/text, var/title = "", var/maintitle = "Срочное Объявление")
	world << "<h1 class='alert'>[maintitle]</h1>"

	if (title && length(title) > 0)
		world << "<h2 class='alert'>[sanitize(title)]</h2>"

	world << "<span class='alert'>[sanitize(text)]</span>"
	world << "<br>"

