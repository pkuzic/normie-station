var/list/titles = list()

datum/title/
	var/jobname
	var/list/title = list()

datum/title/doctor
	jobname = "Врач"
	title = list("Врач", "Вирусолог", "Хирург")

datum/title/scientist
	jobname = "Учёный"
	title = list("Учёный", "Аномалист")

datum/title/detective
	jobname = "Судмедэксперт"
	title = list("Судмедэксперт", "Детектив")

datum/title/New()
	titles += src

proc/setuptitles()
	new /datum/title/doctor()
	new /datum/title/scientist()
	new /datum/title/detective()

proc/HasTitles(job)
	for(var/datum/title/A in titles)
		if(A.jobname == job)
			return 1
	return 0
