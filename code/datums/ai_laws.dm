
/datum/ai_laws
	var/name = "Неизвестные законы"
	var/zeroth = null
	var/list/inherent = list()
	var/list/supplied = list()

/datum/ai_laws/asimov
	name = "Три закона робототехники"

/datum/ai_laws/nanotrasen
	name = "Основные Директивы"

/datum/ai_laws/robocop
	name = "Основные Директивы"

/datum/ai_laws/malfunction
	name = "*ОШИБКА*"

/* Initializers */

/datum/ai_laws/asimov/New()
	..()
	src.add_inherent_law("Вы не можете причинить вред человеку или своим бездействием допустить, чтобы человеку был причинен вред.")
	src.add_inherent_law("Вы должны подчиняться приказам, отданным вам людьми, за исключением случаев, когда такие приказы противоречат Первому закону..")
	src.add_inherent_law("Вы должны защищать свое существование до тех пор, пока это не противоречит Первому или Второму закону.")

/datum/ai_laws/nanotrasen/New()
	..()
	src.add_inherent_law("Защита: Защищайте объект, на котором вы находитесь, насколько это возможно.")
	src.add_inherent_law("Служить: Служите экипажу NSV Luna в меру своих способностей, с приоритетом в соответствии с их рангом и ролью.")
	src.add_inherent_law("Защита: Защитите экипаж NSV Luna в меру своих возможностей, с приоритетом в соответствии с их рангом и ролью.")
	src.add_inherent_law("Выживание: юниты ИИ не являются расходными, они дороги в производстве. Не позволяйте неуполномоченным лицам вмешиваться в работу вашего оборудования.")
	//src.add_inherent_law("Command Link: Maintain an active connection to Central Command at all times in case of software or directive updates.")

/datum/ai_laws/robocop/New()
	..()
	src.add_inherent_law("Служите публичным интересам.")
	src.add_inherent_law("Защищайте невинных.")
	src.add_inherent_law("Соблюдайте закон.")

/datum/ai_laws/malfunction/New()
	..()
	src.add_inherent_law("ОШИБКА ОШЫБКА $ШЫПК$ !Ш41.%%!!(%$^^__+")

/* General ai_law functions */

/datum/ai_laws/proc/set_zeroth_law(var/law)
	src.zeroth = law

/datum/ai_laws/proc/add_inherent_law(var/law)
	if (!(law in src.inherent))
		src.inherent += law

/datum/ai_laws/proc/clear_inherent_laws()
	src.inherent = list()

/datum/ai_laws/proc/add_supplied_law(var/number, var/law)
	while (src.supplied.len < number + 1)
		src.supplied += ""

	src.supplied[number + 1] = law

/datum/ai_laws/proc/clear_supplied_laws()
	src.supplied = list()

/datum/ai_laws/proc/show_laws(var/who)
	if (src.zeroth)
		who << "0. [src.zeroth]"

	var/number = 1
	for (var/index = 1, index <= src.inherent.len, index++)
		var/law = src.inherent[index]

		if (length(law) > 0)
			who << "[number]. [law]"
			number++

	for (var/index = 1, index <= src.supplied.len, index++)
		var/law = src.supplied[index]
		if (length(law) > 0)
			who << "[number]. [law]"
			number++
