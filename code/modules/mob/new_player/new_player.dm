mob/new_player/proc/forcestart()
	set name = "forcestart"
	set hidden = 1
	ready = 1 //Should be a global variable instead
mob/new_player
	anchored = 1

	var/datum/preferences/preferences
	var/ready = 0
	var/readiness

	invisibility = 101

	density = 0
	stat = 2
	canmove = 0

	anchored = 1	//  don't get pushed around
	var/sound/startup = null

	Login()
		..()
		src.verbs += /mob/new_player/proc/forcestart
		//unlock_medal("First Timer", 0, "Welcome!", "easy")
		world.newborn_medal(src)

		if(!preferences)
			preferences = new

		if(!mind)
			mind = new
			mind.key = key
			mind.current = src
		/*if (join_motd)
			src.client.showmotd()*/
		spawn(25)
			//new_player_panel()
			ShowChoices(src)
		src << "<b></b>"
		var/starting_loc = pick(newplayer_start)
		loc = starting_loc
		sight |= SEE_TURFS
		var/list/watch_locations = list()
		for(var/obj/landmark/landmark in world)
			if(landmark.tag == "landmark*new_player")
				watch_locations += landmark.loc

		if(watch_locations.len>0)
			loc = pick(watch_locations)

		if(!preferences.savefile_load(src,0,1))
			ShowChoices(src)

		startup = sound('lobby_music.ogg', volume = 40)
		spawn(25)
			src << startup

	//	src << sound('main.ogg', 0, 0, 0, 35)


	Logout()
		ready = 0
		..()
		return

	/*
	proc
		new_player_panel()
			set src = usr

			var/output = {"
			<head>
				<meta charset="UTF-8">
			</head

			<HR><B>Добро пожаловать!</B><BR><HR>"}

			/*
			var/readiness
			if(ready) readiness = "<B>Готов</B>"
			else readiness = "<B>Не готов</B>"
			output += "Готовность: [readiness]<br>"
			//output += "<br><a href='byond://?src=\ref[src];show_preferences=1'>Настроить персонажа</A><BR><BR>"
			//if(istester(key))
			if(!ticker || ticker.current_state <= GAME_STATE_PREGAME)
				if(!ready)
					output += "<a href='byond://?src=\ref[src];ready=1'>Объявить готовность</A><BR>"
				else
					output += "<a href='byond://?src=\ref[src];ready=0'>Отменить готовность</A><BR>"
			else
				//output += "<a href='byond://?src=\ref[src];manifest=1'>Изучить список экипажа</A><BR><BR>"
				output += "<a href='byond://?src=\ref[src];late_join=1'>Присоединиться к игре!</A><BR>"
			*/
			//The game is for playing, not for watching
			//output += "<BR><a href='byond://?src=\ref[src];observe=1'>Наблюдать</A><BR>"

			if(!ticker || ticker.current_state <= GAME_STATE_PREGAME)
				src << browse(output,"window=playersetup;size=250x233;can_close=0")
			else
				src << browse(output,"window=playersetup;size=250x233;can_close=0") // Adding the "View the Crew Manifest" option to the size of the window
				// A nice interface makes for an appealing game :D
	*/
	Stat()
		..()

		statpanel("Лобби")
		if(client.statpanel=="Лобби" && ticker)
			if(ticker.hide_mode)
				stat("Режим:", "Секрет")
			else
				stat("Режим:", "[master_mode]")

			if(ticker.current_state == GAME_STATE_PREGAME)
				stat("Время до старта:", ticker.pregame_timeleft)

		statpanel("Лобби")
		if(client.statpanel=="Лобби" && ticker)
			if(ticker.current_state == GAME_STATE_PREGAME)
				for(var/mob/new_player/player in world)
					stat("[player.key]", (player.ready)?("(готов)"):(null))

	Topic(href, href_list[])
		/*if(href_list["show_preferences"])
			preferences.ShowChoices(src)
			return 1
		*/
		/*if(href_list["closemotd"])
			src << browse(null,"window=motd;")*/
		if(href_list["ready"])
			if (config.invite_only)
				if(!invite_isallowed(src))
					src << "\blue Попасть в игру можно лишь по приглашению"
					return

			if(!ready)
				//if(alert(src,"Are you sure want to be ready? This will lock-in your preferences.","Player Setup","Yes","No") == "Yes")
				ready = 1
			else if(ready)
				//if(alert(src,"Are you dont want to be ready? This will un-lock your preferences.","Player Setup","Yes","No") == "Yes")
				ready = 0

		/*if(href_list["observe"])
			if(alert(src,"Are you sure you wish to observe? You will not be able to play this round!","Player Setup","Yes","No") == "Yes")
				var/mob/dead/observer/observer = new()

				close_spawn_windows()
				startup.status = SOUND_PAUSED
				src << startup
				var/obj/O = locate("landmark*Observer-Start")
				src << "\blue Ïåðåìåùàåìñ&#255;."
				observer.loc = O.loc
				observer.key = key
				if(preferences.be_random_name)
					preferences.randomize_name()
				observer.name = preferences.real_name
				observer.real_name = observer.name


				del(src)
				return 1*/

		if(href_list["late_join"])
			//LateChoices()
			if (!enter_allowed)
				usr << "\blue Вход в игру заблокирован!"
				return
			if (config.invite_only)
				if(!invite_isallowed(src))
					src << "\blue Попасть в игру можно лишь по приглашению"
					return
			startup.status = SOUND_PAUSED
			src << startup
			AttemptLateSpawn("Unassigned", -1)

		/*if(href_list["manifest"])
			ViewManifest()*/

/*		if(href_list["SelectedJob"])
			if (!enter_allowed)
				usr << "\blue There is an administrative lock on entering the game!"
				return

			if (config.invite_only)
				if(!invite_isallowed(src))
					src << "\blue This is an invite only game"
					return

			startup.status = SOUND_PAUSED
			src << startup

			switch(href_list["SelectedJob"])
				if ("1")
					AttemptLateSpawn("Captain", captainMax)
				if ("2")
					AttemptLateSpawn("Head of Security", hosMax)
				if ("3")
					AttemptLateSpawn("Head of Personnel", hopMax)
				if ("4")
					AttemptLateSpawn("Engineer", engineerMax)
				if ("5")
					AttemptLateSpawn("Barman", barmanMax)
				if ("6")
					AttemptLateSpawn("Scientist", scientistMax)
				if ("7")
					AttemptLateSpawn("Chemist", chemistMax)
				if ("8")
					AttemptLateSpawn("Geneticist", geneticistMax)
				if ("9")
					AttemptLateSpawn("Security Officer", securityMax)
				if ("10")
					AttemptLateSpawn("Medical Doctor", doctorMax)
				if ("11")
					AttemptLateSpawn("Atmospheric Technician", atmosMax)
				if ("12")
					AttemptLateSpawn("Detective", detectiveMax)
				if ("13")
					AttemptLateSpawn("Counselor", CounselorMax)
				if ("14")
					AttemptLateSpawn("Janitor", janitorMax)
				if ("15")
					AttemptLateSpawn("Clown", clownMax)
				if ("16")
					AttemptLateSpawn("Chef", chefMax)
				if ("17")
					AttemptLateSpawn("Roboticist", roboticsMax)
				if ("18")
					AttemptLateSpawn("Unassigned", -1)
				if ("19")
					AttemptLateSpawn("Quartermaster", cargoMax)
				if ("20")
					AttemptLateSpawn("Research Director", directorMax)
				if ("21")
					AttemptLateSpawn("Chief Engineer", chiefMax)
				if ("22")
					AttemptLateSpawn("Archaeologist", archaeologistMax)
				if ("23")
					AttemptLateSpawn("Chief Medical Officer", cmoMax)
				if ("24")
					AttemptLateSpawn("Virologist", virologistMax)
				if ("25")
					AttemptLateSpawn("Surgeon", surgeonMax)
				if ("26")
					AttemptLateSpawn("Anomalist", anomalistMax)
//				if ("007")
//					AttemptLateSpawn("Hydroponist", hydroponicsMax)
*/

		if(!ready && href_list["preferences"])
			process_link(src, href_list)
		else if(!href_list["late_join"])
			ShowChoices(src)

	proc/IsJobavailable(rank, maxAllowed)
		if((countJob(rank) < maxAllowed || maxAllowed == -1) && !jobban_isbanned(src,rank))
			return 1
		else
			return 0

	proc/AttemptLateSpawn(rank, maxAllowed)
		if(IsJobavailable(rank, maxAllowed))
			var/mob/living/carbon/human/character = create_character()

			character.Equip_Rank(rank, joined_late=1)

			//add to manifest
			for(var/datum/data/record/t in data_core.general)
				if((t.fields["name"] == character.real_name) && (t.fields["rank"] == "Unassigned"))
					t.fields["rank"] = rank

			if (ticker.current_state == GAME_STATE_PLAYING)
				if(rank == "Unassigned")
					radioalert("Уведомление о прибытии", "[character.real_name] [character.gender == 1 ? "прибыл" : "прибыла"] на судно.")	//unassigneds are not special
				else
					radioalert("Уведомление о прибытии", "[rank] [character.real_name] [character.gender == 1 ? "прибыл" : "прибыла"] на судно.")	//oh no engineers

				/*for (var/mob/living/silicon/ai/A in world) // Use this if we want to revert to the AI announcing new arrivals
					if (!A.stat)
						A.say("[character.real_name] has signed up as [rank].")*/

			var/starting_loc = pick(latejoin)
			character.loc = starting_loc
			ticker.mode.latespawn(character)
			del(src)

		else
			src << alert("Роль [rank] недоступна. Стоит попробовать другую.")

// This fxn creates positions for unassigned people based on existing positions. This could be more elegant.
/*	proc/LateChoices()
		var/dat = "<html><body>"
		dat += "Choose from the following open positions:<br>"
/*
		if (IsJobavailable("Captain",captainMax))
			dat += "<a href='byond://?src=\ref[src];SelectedJob=1'>Captain</a><br>"

		if (IsJobavailable("Head of Security",hosMax))
			dat += "<a href='byond://?src=\ref[src];SelectedJob=2'>Head of Security</a><br>"

		if (IsJobavailable("Head of Personnel",hopMax))
			dat += "<a href='byond://?src=\ref[src];SelectedJob=3'>Head of Personnel</a><br>"

		if (IsJobavailable("Research Director",directorMax))
			dat += "<a href='byond://?src=\ref[src];SelectedJob=20'>Research Director</a><br>"

		if (IsJobavailable("Chief Engineer",chiefMax))
			dat += "<a href='byond://?src=\ref[src];SelectedJob=21'>Chief Engineer</a><br>"

		if (IsJobavailable("Engineer",engineerMax))
			dat += "<a href='byond://?src=\ref[src];SelectedJob=4'>Engineer</a><br>"
*/
		if (IsJobavailable("Barman",barmanMax))
			dat += "<a href='byond://?src=\ref[src];SelectedJob=5'>Barman</a><br>"
/*
		if (IsJobavailable("Scientist",scientistMax))
			dat += "<a href='byond://?src=\ref[src];SelectedJob=6'>Scientist</a><br>"

		if (IsJobavailable("Chemist",chemistMax))
			dat += "<a href='byond://?src=\ref[src];SelectedJob=7'>Chemist</a><br>"

		if (IsJobavailable("Geneticist",geneticistMax))
			dat += "<a href='byond://?src=\ref[src];SelectedJob=8'>Geneticist</a><br>"

		if (IsJobavailable("Security Officer",securityMax))
			dat += "<a href='byond://?src=\ref[src];SelectedJob=9'>Security Officer</a><br>"

		if (IsJobavailable("Medical Doctor",doctorMax))
			dat += "<a href='byond://?src=\ref[src];SelectedJob=10'>Medical Doctor</a><br>"

		if (IsJobavailable("Atmospheric Technician",atmosMax))
			dat += "<a href='byond://?src=\ref[src];SelectedJob=11'>Atmospheric Technician</a><br>"

		if (IsJobavailable("Detective",detectiveMax))
			dat += "<a href='byond://?src=\ref[src];SelectedJob=12'>Detective</a><br>"
*/
		if (IsJobavailable("Counselor",CounselorMax))
			dat += "<a href='byond://?src=\ref[src];SelectedJob=13'>Counselor</a><br>"

		if (IsJobavailable("Janitor",janitorMax))
			dat += "<a href='byond://?src=\ref[src];SelectedJob=14'>Janitor</a><br>"
/*
		if (IsJobavailable("Clown",clownMax))
			dat += "<a href='byond://?src=\ref[src];SelectedJob=15'>Clown</a><br>"

		if (IsJobavailable("Chef",chefMax))
			dat += "<a href='byond://?src=\ref[src];SelectedJob=16'>Chef</a><br>"

		if (IsJobavailable("Roboticist",roboticsMax))
			dat += "<a href='byond://?src=\ref[src];SelectedJob=17'>Roboticist</a><br>"

		if (IsJobavailable("Quartermaster",cargoMax))
			dat += "<a href='byond://?src=\ref[src];SelectedJob=19'>Quartermaster</a><br>"

//		if (IsJobavailable("Hydroponist",hydroponicsMax))
//			dat += "<a href='byond://?src=\ref[src];SelectedJob=22'>Hydroponist</a><br>"
*/
		if (!jobban_isbanned(src,"Unassigned"))
			dat += "<a href='byond://?src=\ref[src];SelectedJob=18'>Unassigned</a><br>"

		src << browse(dat, "window=latechoices;size=300x640;can_close=0")
*/

/*
/obj/begin/verb/enter()
	log_game("[usr.key] entered as [usr.real_name]")

	if (ticker)
		for (var/mob/living/silicon/ai/A in world)
			if (!A.stat)
				A.say("[usr.real_name] has arrived on the station!")
				break

		usr << "<B>Game mode is [master_mode].</B>"

	var/mob/living/carbon/human/H = usr

//find spawn points for normal game modes

	if(!(ticker && ticker.mode.name == "ctf"))
		var/list/L = list()
		var/area/A = locate(/area/arrival/start)
		for(var/turf/T in A)
			L += T

		while(!L.len)
			usr << "\blue <B>You were unable to enter because the arrival shuttle has been destroyed! The game will reattempt to spawn you in 30 seconds!</B>"
			sleep(300)
			for(var/turf/T in A)
				L += T
		H << "\blue Now teleporting."
		H.loc = pick(L)

//for capture the flag

	else if(ticker && ticker.mode.name == "ctf")
		if(H.client.team == "Red")
			var/obj/R = locate("landmark*Red-Spawn")
			H << "\blue Now teleporting."
			H.loc = R.loc
		else if(H.client.team == "Green")
			var/obj/G = locate("landmark*Green-Spawn")
			H << "\blue Now teleporting."
			H.loc = G.loc

//error check

	else
		usr << "Invalid start please report this to the admins"

//add to manifest

	if(ticker)
		//add to manifest
		var/datum/data/record/G = new /datum/data/record(  )
		var/datum/data/record/M = new /datum/data/record(  )
		var/datum/data/record/S = new /datum/data/record(  )
		var/obj/item/weapon/card/id/C = H.wear_id
		if (C)
			G.fields["rank"] = C.assignment
		else
			G.fields["rank"] = "Unassigned"
		G.fields["name"] = H.real_name
		G.fields["id"] = text("[]", add_zero(num2hex(rand(1, 1.6777215E7)), 6))
		M.fields["name"] = G.fields["name"]
		M.fields["id"] = G.fields["id"]
		S.fields["name"] = G.fields["name"]
		S.fields["id"] = G.fields["id"]
		if (H.gender == "female")
			G.fields["sex"] = "Female"
		else
			G.fields["sex"] = "Male"
		G.fields["age"] = text("[]", H.age)
		G.fields["fingerprint"] = text("[]", md5(H.dna.uni_identity))
		G.fields["p_stat"] = "Active"
		G.fields["m_stat"] = "Stable"
		M.fields["b_type"] = text("[]", H.b_type)
		M.fields["mi_dis"] = "None"
		M.fields["mi_dis_d"] = "No minor disabilities have been declared."
		M.fields["ma_dis"] = "None"
		M.fields["ma_dis_d"] = "No major disabilities have been diagnosed."
		M.fields["alg"] = "None"
		M.fields["alg_d"] = "No allergies have been detected in this patient."
		M.fields["cdi"] = "None"
		M.fields["cdi_d"] = "No diseases have been diagnosed at the moment."
		M.fields["notes"] = "No notes."
		S.fields["criminal"] = "None"
		S.fields["mi_crim"] = "None"
		S.fields["mi_crim_d"] = "No minor crime convictions."
		S.fields["ma_crim"] = "None"
		S.fields["ma_crim_d"] = "No minor crime convictions."
		S.fields["notes"] = "No notes."
		for(var/obj/datacore/D in world)
			D.general += G
			D.medical += M
			D.security += S
//DNA!
		reg_dna[H.dna.unique_enzymes] = H.real_name
//Other Stuff
		if(ticker.mode.name == "Sandbox")
			H.CanBuild()

*/
/*
	say(var/message)
		message = trim(copytext(sanitize(message), 1, MAX_MESSAGE_LEN))

		if (!message)
			return

		log_say("[key] : [message]")

		if (muted)
			return

		. = say_dead(message)
*/

	var/age = 30.0
	var/b_type = "A+"

	var/occupation1 = "Без предпочтений"
	var/occupation2 = "Без предпочтений"
	var/occupation3 = "Без предпочтений"
	var/title1
	var/title2
	var/title3
	var/h_style = "Короткие волосы"
	var/f_style = "Без растительности"
	var/slotname
	var/r_hair = 0.0
	var/g_hair = 0.0
	var/b_hair = 0.0
	var/show = 1
	var/r_facial = 0.0
	var/g_facial = 0.0
	var/b_facial = 0.0
	//var/bio = "биография пишется здесь"
	var/s_tone = 0.0
	var/r_eyes = 0.0
	var/g_eyes = 0.0
	var/b_eyes = 0.0
	var/curslot = 0
	var/icon/preview_icon = null
	//var/UI = UI_B12

	New()
		randomize_name()

		..()

	proc/randomize_name()
		if (gender == MALE)
			real_name = capitalize(pick(first_names_male) + " " + capitalize(pick(last_names)))
		else
			real_name = capitalize(pick(first_names_female) + " " + capitalize(pick(last_names)))

	proc/update_preview_icon()
		del(preview_icon)

		var/g = "m"
		if (gender == MALE)
			g = "m"
		else if (gender == FEMALE)
			g = "f"

		preview_icon = new /icon('human.dmi', "body_[g]_s")

		// Skin tone
		if (s_tone >= 0)
			preview_icon.Blend(rgb(s_tone, s_tone, s_tone), ICON_ADD)
		else
			preview_icon.Blend(rgb(-s_tone,  -s_tone,  -s_tone), ICON_SUBTRACT)

		if (underwear > 0)
			preview_icon.Blend(new /icon('human.dmi', "underwear[underwear]_[g]_s"), ICON_OVERLAY)

		var/icon/eyes_s = new/icon("icon" = 'human_face.dmi', "icon_state" = "eyes_s")
		eyes_s.Blend(rgb(r_eyes, g_eyes, b_eyes), ICON_ADD)

		var/h_style_r = null
		switch(h_style)
			if("Short Hair")
				h_style_r = "hair_a"
			if("Long Hair")
				h_style_r = "hair_b"
			if("Cut Hair")
				h_style_r = "hair_c"
			if("Mohawk")
				h_style_r = "hair_d"
			if("Balding")
				h_style_r = "hair_e"
			if("Wave")
				h_style_r = "hair_f"
			if("Bedhead")
				h_style_r = "hair_bedhead"
			if("Dreadlocks")
				h_style_r = "hair_dreads"
			if("Ponytail")
				h_style_r = "hair_ponytail"
			else
				h_style_r = "bald"

		var/f_style_r = null
		switch(f_style)
			if ("Watson")
				f_style_r = "facial_watson"
			if ("Chaplin")
				f_style_r = "facial_chaplin"
			if ("Selleck")
				f_style_r = "facial_selleck"
			if ("Neckbeard")
				f_style_r = "facial_neckbeard"
			if ("Full Beard")
				f_style_r = "facial_fullbeard"
			if ("Long Beard")
				f_style_r = "facial_longbeard"
			if ("Van Dyke")
				f_style_r = "facial_vandyke"
			if ("Elvis")
				f_style_r = "facial_elvis"
			if ("Abe")
				f_style_r = "facial_abe"
			if ("Chinstrap")
				f_style_r = "facial_chin"
			if ("Hipster")
				f_style_r = "facial_hip"
			if ("Goatee")
				f_style_r = "facial_gt"
			if ("Hogan")
				f_style_r = "facial_hogan"
			else
				f_style_r = "bald"

		var/icon/hair_s = new/icon("icon" = 'human_face.dmi', "icon_state" = "[h_style_r]_s")
		hair_s.Blend(rgb(r_hair, g_hair, b_hair), ICON_ADD)

		var/icon/facial_s = new/icon("icon" = 'human_face.dmi', "icon_state" = "[f_style_r]_s")
		facial_s.Blend(rgb(r_facial, g_facial, b_facial), ICON_ADD)

		var/icon/mouth_s = new/icon("icon" = 'human_face.dmi', "icon_state" = "mouth_[g]_s")

		eyes_s.Blend(hair_s, ICON_OVERLAY)
		eyes_s.Blend(mouth_s, ICON_OVERLAY)
		eyes_s.Blend(facial_s, ICON_OVERLAY)

		preview_icon.Blend(eyes_s, ICON_OVERLAY)

		del(mouth_s)
		del(facial_s)
		del(hair_s)
		del(eyes_s)

	proc/ShowChoices(mob/user)
		update_preview_icon()
		user << browse_rsc(preview_icon, "previewicon.png")

		var/list/destructive = assistant_occupations.Copy()
		var/dat = {"
		<html>
			<head>
				<meta charset="UTF-8">
			</head

			<body>"}

		dat += "<b>Имя:</b> "
		dat += "<a href=\"byond://?src=\ref[user];preferences=1;real_name=input\"><b>[real_name]</b></a> "
		dat += "(<a href=\"byond://?src=\ref[user];preferences=1;real_name=random\">&reg;</A>) "
		dat += "(&reg; = <a href=\"byond://?src=\ref[user];preferences=1;b_random_name=1\">[be_random_name ? "Yes" : "No"]</a>)"
		dat += "<br>"

		dat += "<b>Пол:</b> <a href=\"byond://?src=\ref[user];preferences=1;gender=input\"><b>[gender == MALE ? "Male" : "Female"]</b></a><br>"
		dat += "<b>Возраст:</b> <a href='byond://?src=\ref[user];preferences=1;age=input'>[age]</a>"

		//dat += "<b>UI Style:</b> <a href=\"byond://?src=\ref[user];preferences=1;UI=input\"><b>[UI == B12 ? "B12" : "AGrey": "AGreen"]</b></a><br>" // UI CHOICES!

		dat += "<hr><b>Предпочтения</b><br>"
		if (destructive.Find(occupation1))
			dat += "\t<a href=\"byond://?src=\ref[user];preferences=1;occ=1\"><b>[occupation1]</b></a><br>"
		else
			if (jobban_isbanned(user, occupation1))
				occupation1 = "Без предпочтений"
			if (jobban_isbanned(user, occupation2))
				occupation2 = "Без предпочтений"
			if (jobban_isbanned(user, occupation3))
				occupation3 = "Без предпочтений"
			if (occupation1 != "Без предпочтений")
				dat += "\tПервый выбор: <a href=\"byond://?src=\ref[user];preferences=1;occ=1\"><b>[occupation1]</b></a><br>"
				/*if(HasTitles(occupation1))
					if(!title1)
						title1 = occupation1*/
					//dat += "\t [occupation1] Title: <a href=\"byond://?src=\ref[user];preferences=1;occ=1;showtitle=1\"><b>[title1]</b></a><br>"
				if (destructive.Find(occupation2))
					dat += "\tВторой выбор: <a href=\"byond://?src=\ref[user];preferences=1;occ=2\"><b>[occupation2]</b></a><BR>"

				else
					if (occupation2 != "No Preference")
						dat += "\tВторой выбор: <a href=\"byond://?src=\ref[user];preferences=1;occ=2\"><b>[occupation2]</b></a><BR>"
						/*if(HasTitles(occupation2))
							if(!title2)
								title2 = occupation2*/
							//dat += "\t [occupation2] Title: <a href=\"byond://?src=\ref[user];preferences=1;occ=2;showtitle=1\"><b>[title2]</b></a><br>"
						dat += "\tТретий выбор: <a href=\"byond://?src=\ref[user];preferences=1;occ=3\"><b>[occupation3]</b></a><BR	>"
						/*if(HasTitles(occupation3))
							if(!title3)
								title3 = occupation3*/
							//dat += "\t [occupation3] Title: <a href=\"byond://?src=\ref[user];preferences=1;occ=3;showtitle=1\"><b>[title3]</b></a><br>"

					else
						dat += "\tВторой выбор: <a href=\"byond://?src=\ref[user];preferences=1;occ=2\">No Preference</a><br>"
			else
				dat += "\t<a href=\"byond://?src=\ref[user];preferences=1;occ=1\">Без предпочтений</a><br>"

		dat += "<hr><table><tr><td><b>Тело</b><br>"
		dat += "Группа крови: <a href='byond://?src=\ref[user];preferences=1;b_type=input'>[b_type]</a><br>"
		dat += "Оттенок кожи: <a href='byond://?src=\ref[user];preferences=1;s_tone=input'>[-s_tone + 35]/220</a><br>"
		if (!IsGuestKey(user.key))
			dat += "Нижнее белье: <a href =\"byond://?src=\ref[user];preferences=1;underwear=1\"><b>[underwear == 1 ? "Yes" : "No"]</b></a><br>"
		dat += "</td><td><b>Предпросмотр</b><br><img src=previewicon.png height=64 width=64></td></tr></table>"

		dat += "<hr><b>Волосы</b><br>"

		dat += "<a href='byond://?src=\ref[user];preferences=1;hair=input'>Изменить цвет</a> <font face=\"fixedsys\" size=\"3\" color=\"#[num2hex(r_hair, 2)][num2hex(g_hair, 2)][num2hex(b_hair, 2)]\"><table bgcolor=\"#[num2hex(r_hair, 2)][num2hex(g_hair, 2)][num2hex(b_hair)]\"><tr><td>IM</td></tr></table></font>"
/*
		dat += " <font color=\"#[num2hex(r_hair, 2)]0000\">Red</font> - <a href='byond://?src=\ref[user];preferences=1;r_hair=input'>[r_hair]</a>"
		dat += " <font color=\"#00[num2hex(g_hair, 2)]00\">Green</font> - <a href='byond://?src=\ref[user];preferences=1;g_hair=input'>[g_hair]</a>"
		dat += " <font color=\"#0000[num2hex(b_hair, 2)]\">Blue</font> - <a href='byond://?src=\ref[user];preferences=1;b_hair=input'>[b_hair]</a><br>"
*/
		dat += "Style: <a href='byond://?src=\ref[user];preferences=1;h_style=input'>[h_style]</a>"

		dat += "<hr><b>Лицо</b><br>"

		dat += "<a href='byond://?src=\ref[user];preferences=1;facial=input'>Изменить цвет</a> <font face=\"fixedsys\" size=\"3\" color=\"#[num2hex(r_facial, 2)][num2hex(g_facial, 2)][num2hex(b_facial, 2)]\"><table bgcolor=\"#[num2hex(r_facial, 2)][num2hex(g_facial, 2)][num2hex(b_facial)]\"><tr><td>GO</td></tr></table></font>"
/*
		dat += " <font color=\"#[num2hex(r_facial, 2)]0000\">Red</font> - <a href='byond://?src=\ref[user];preferences=1;r_facial=input'>[r_facial]</a>"
		dat += " <font color=\"#00[num2hex(g_facial, 2)]00\">Green</font> - <a href='byond://?src=\ref[user];preferences=1;g_facial=input'>[g_facial]</a>"
		dat += " <font color=\"#0000[num2hex(b_facial, 2)]\">Blue</font> - <a href='byond://?src=\ref[user];preferences=1;b_facial=input'>[b_facial]</a><br>"
*/
		dat += "Стиль: <a href='byond://?src=\ref[user];preferences=1;f_style=input'>[f_style]</a>"

		dat += "<hr><b>Глаза</b><br>"
		dat += "<a href='byond://?src=\ref[user];preferences=1;eyes=input'>Изменить цвет</a> <font face=\"fixedsys\" size=\"3\" color=\"#[num2hex(r_eyes, 2)][num2hex(g_eyes, 2)][num2hex(b_eyes, 2)]\"><table bgcolor=\"#[num2hex(r_eyes, 2)][num2hex(g_eyes, 2)][num2hex(b_eyes)]\"><tr><td>KU</td></tr></table></font>"
/*
		dat += " <font color=\"#[num2hex(r_eyes, 2)]0000\">Red</font> - <a href='byond://?src=\ref[user];preferences=1;r_eyes=input'>[r_eyes]</a>"
		dat += " <font color=\"#00[num2hex(g_eyes, 2)]00\">Green</font> - <a href='byond://?src=\ref[user];preferences=1;g_eyes=input'>[g_eyes]</a>"
		dat += " <font color=\"#0000[num2hex(b_eyes, 2)]\">Blue</font> - <a href='byond://?src=\ref[user];preferences=1;b_eyes=input'>[b_eyes]</a>"
*/
		dat += "<hr>"
		if(!jobban_isbanned(user, "Синдикат"))
			dat += "<b>Быть оперативником?:</b> <a href =\"byond://?src=\ref[user];preferences=1;b_syndicate=1\"><b>[(be_syndicate ? "Да" : "Нет")]</b></a><br>"
			dat += "<b>Быть агентом?:</b> <a href =\"byond://?src=\ref[user];preferences=1;b_nuke_agent=1\"><b>[(be_nuke_agent ? "Да" : "Нет")]</b></a><br>"
			dat += "<b>Быть какой-то хуйней?:</b> <a href =\"byond://?src=\ref[user];preferences=1;b_takeover_agent=1\"><b>[(be_takeover_agent ? "Да" : "Нет")]</b></a><br>"
		else
			dat += "<b>Ты не можешь представлять Синдикат.</b>"
			be_syndicate = 0
			be_nuke_agent = 0
			be_takeover_agent = 0
		//dat += "<a href =\"byond://?src=\ref[user];preferences=1;editbio=1\">Изменить биографию</a><br>"
		//dat += "<b>Show Profile?:</b> <a href =\"byond://?src=\ref[user];preferences=1;b_syndicate=1\"><b>[(be_syndicate ? "Yes" : "No")]</b></a><br>
		dat += "<hr>"

		if (!IsGuestKey(user.key))
			if(!curslot)
				dat += "<a href='byond://?src=\ref[user];preferences=1;saveslot=1'>Сохранить Слот 1</a><br>"
			else
				dat += "<a href='byond://?src=\ref[user];preferences=1;saveslot=[curslot]'>Сохранить Слот [curslot]</a><br>"
			dat += "<a href='byond://?src=\ref[user];preferences=1;loadslot2=1'>Загрузить</a><br>"
		dat += "<a href='byond://?src=\ref[user];preferences=1;createslot=1'Создать Новый слот</a><br>"
		dat += "<a href='byond://?src=\ref[user];preferences=1;reset_all=1'>Сбросить настройки</a><br>"
		dat += "</body></html>"

		dat += "<br><hr><br>"

		if(!ticker || ticker.current_state <= GAME_STATE_PREGAME)
			if(!ready)
				dat += "<a href='byond://?src=\ref[src];ready=1'>Объявить готовность</A><BR>"
			else
				dat += "<a href='byond://?src=\ref[src];ready=0'>Отменить готовность</A><BR>"
		else
			dat += "<a href='byond://?src=\ref[src];late_join=1'>Присоединиться к игре!</A><BR>"

		user << browse(dat, "window=preferences;size=600x640;can_close=0")
	proc/loadsave(mob/user)
		var/dat = "<body>"
		dat += "<tt><center>"
		var/list/slot = list()
		var/list/slots = list()
		var/DBQuery/query = dbcon.NewQuery("SELECT `slot`,`slotname` FROM `players` WHERE ckey='[usr.ckey]'")
		if(!query.Execute())
			usr << "ERROR"
		while(query.NextRow())
			var/list/row = query.GetRowData()
			slot += row["slot"]
			var/T = row["slot"]
			var/K = row["slotname"]
			slots += row["slotname"]
			dat += "<a href='byond://?src=\ref[user];preferences=1;loadslot=[T]'>Загрузить Слот [T]([K]) </a><a href='byond://?src=\ref[user];preferences=1;removeslot=[T]'>(R)</a><br><br>"

		dat += "<a href='byond://?src=\ref[user];preferences=1;loadslot=CLOSE'>Закрыть</a><br>"
		dat += "</center></tt>"
		user << browse(dat, "window=saves;size=600x640;can_close=0")
	proc/closesave(mob/user)
		user << browse(null, "window=saves;size=600x640")
	proc/SetChoices(mob/user, occ=1)
		var/HTML = "<body>"
		HTML += "<tt><center>"
		switch(occ)
			if(1.0)
				HTML += "<b>Какая роль для тебя более желанна?</b><br><br>"
			if(2.0)
				HTML += "<b>Какой твой второй выбор?</b><br><br>"
			if(3.0)
				HTML += "<b>Какой твой третий выбор?</b><br><br>"
			else
		for(var/job in uniquelist(occupations + assistant_occupations) )
			if ((job!="AI" || config.allow_ai) && !jobban_isbanned(user, job))
				HTML += "<a href=\"byond://?src=\ref[user];preferences=1;occ=[occ];job=[job]\">[job]</a><br>"

		if(!jobban_isbanned(user, "Капитан"))
			HTML += "<a href=\"byond://?src=\ref[user];preferences=1;occ=[occ];job=Капитан\">Капитан</a><br>"
		HTML += "<br>"
		HTML += "<a href=\"byond://?src=\ref[user];preferences=1;occ=[occ];job=Без предпочтений\">\[Без предпочтений\]</a><br>"
		HTML += "<a href=\"byond://?src=\ref[user];preferences=1;occ=[occ];cancel=1\">\[Отмена\]</a>"
		HTML += "</center></tt>"

		user << browse(null, "window=preferences")
		user << browse(HTML, "window=mob_occupation;size=320x500")
		return

	proc/ShowTitle(mob/user,choice=1)
		var/HTML = "<body>"
		HTML += "<tt><center>"
		switch(choice)
			if(1.0)
				HTML += "<b>Какой титул для [occupation1]?</b><br><br>"
				for(var/datum/title/T in titles)
					if(T.jobname == occupation1)
						for(var/A in T.title)
							HTML += "<a href=\"byond://?src=\ref[user];preferences=1;occ=[choice];title=[A]\">[A]</a><br>"
			if(2.0)
				HTML += "<b>Какой титул для [occupation2]?</b><br><br>"
				for(var/datum/title/T in titles)
					if(T.jobname == occupation2)
						for(var/A in T.title)
							HTML += "<a href=\"byond://?src=\ref[user];preferences=1;occ=[choice];title=[A]\">[A]</a><br>"
			if(3.0)
				HTML += "<b>Какой титул для [occupation3]?</b><br><br>"
				for(var/datum/title/T in titles)
					if(T.jobname == occupation3)
						for(var/A in T.title)
							HTML += "<a href=\"byond://?src=\ref[user];preferences=1;occ=[choice];title=[A]\">[A]</a><br>"
		HTML += "<a href=\"byond://?src=\ref[user];preferences=1;occ=[choice];cancel=1\">\[Cancel\]</a>"
		HTML += "</center></tt>"
		user << browse(null, "window=preferences")
		user << browse(HTML, "window=mob_title;size=320x500")

	proc/SetTitle(mob/user,choice,title)
		switch(choice)
			if(1.0)
				title1 = title
			if(2.0)
				title2 = title
			if(3.0)
				title3 = title
		user << browse(null, "window=mob_title")
		ShowChoices(user)
		return
	proc/SetJob(mob/user, occ=1, job="Капитан")
		if ((!( occupations.Find(job) ) && !( assistant_occupations.Find(job) ) && job != "Капитан") && job != "Без предпочтений")
			return
		if (job=="AI" && (!config.allow_ai))
			return
		if (jobban_isbanned(user, job))
			return

		switch(occ)
			if(1.0)
				if (job == occupation1)
					user << browse(null, "window=mob_occupation")
					return
				else
					if (job == "Без предпочтений")
						occupation1 = "Без предпочтений"
						ShowChoices(user)
					else
						if (job == occupation2)
							job = occupation1
							occupation1 = occupation2
							occupation2 = job
						else
							if (job == occupation3)
								job = occupation1
								occupation1 = occupation3
								occupation3 = job
							else
								occupation1 = job
			if(2.0)
				if (job == occupation2)
					user << browse(null, "window=mob_occupation")
					ShowChoices(user)
				else
					if (job == "Без предпочтений")
						if (occupation3 != "Без предпочтений")
							occupation2 = occupation3
							occupation3 = "Без предпочтений"
						else
							occupation2 = "Без предпочтений"
					else
						if (job == occupation1)
							if (occupation2 == "Без предпочтений")
								user << browse(null, "window=mob_occupation")
								return
							job = occupation2
							occupation2 = occupation1
							occupation1 = job
						else
							if (job == occupation3)
								job = occupation2
								occupation2 = occupation3
								occupation3 = job
							else
								occupation2 = job
			if(3.0)
				if (job == occupation3)
					user << browse(null, "window=mob_occupation")
					ShowChoices(user)
				else
					if (job == "Без предпочтений")
						occupation3 = "Без предпочтений"
					else
						if (job == occupation1)
							if (occupation3 == "Без предпочтений")
								user << browse(null, "window=mob_occupation")
								return
							job = occupation3
							occupation3 = occupation1
							occupation1 = job
						else
							if (job == occupation2)
								if (occupation3 == "Без предпочтений")
									user << browse(null, "window=mob_occupation")
									return
								job = occupation3
								occupation3 = occupation2
								occupation2 = job
							else
								occupation3 = job

		user << browse(null, "window=mob_occupation")
		ShowChoices(user)

		return 1

	proc/process_link(mob/user, list/link_tags)

		if (link_tags["occ"])
			if (link_tags["cancel"])
				user << browse(null, "window=mob_occupation")
				ShowChoices(user)
			else if(link_tags["showtitle"])
				ShowTitle(user,text2num(link_tags["occ"]))
			else if(link_tags["job"])
				SetJob(user, text2num(link_tags["occ"]), link_tags["job"])
			else if(link_tags["title"])
				SetTitle(user,text2num(link_tags["occ"]),link_tags["title"])
			else
				SetChoices(user, text2num(link_tags["occ"]))

			return 1

		if (link_tags["real_name"])
			var/new_name

			switch(link_tags["real_name"])
				if("input")
					new_name = input(user, "Имя персонажа:", "Создание персонажа")  as text
					var/list/bad_characters = list("_", "'", "\"", "<", ">", ";", "[", "]", "{", "}", "|", "\\")
					for(var/c in bad_characters)
						new_name = dd_replacetext(new_name, c, "")
					if(!new_name || (new_name == "Unknown"))
						alert("Нет.")
						return
					//Prevent players from making weird names, memes, insults, cyrillic symbols (might be a better idea to allow just latin symbols) etc.

				if("random")
					if (gender == MALE)
						new_name = capitalize(pick(first_names_male) + " " + capitalize(pick(last_names)))
					else
						new_name = capitalize(pick(first_names_female) + " " + capitalize(pick(last_names)))
			if(new_name)
				if(length(new_name) >= 26)
					new_name = copytext(new_name, 1, 26)
				//arright gonna do some automatic capitalization, but only first and last words because von, van etc
				var/lastspace = 1
				while(findtext(new_name, " ", lastspace + 1))
					lastspace = findtext(new_name, " ", lastspace + 1)//find last space used later
				if(lastspace == 1)
					new_name = addtext(uppertext(copytext(new_name, 1, 2)), copytext(new_name, 2)) //they only have a one word name, might want to put an alert or something in here to tell them that we want surnames
				else
					new_name = addtext(uppertext(copytext(new_name, 1, 2)), copytext(new_name, 2, lastspace + 1), uppertext(copytext(new_name, lastspace + 1, lastspace + 2)), copytext(new_name, lastspace + 2)) //this ended up longer than expected...
				real_name = new_name

		if (link_tags["age"])
			var/new_age = input(user, "Возраст персонажа: 20-45", "Создание персонажа")  as num

			if(new_age)
				age = max(min(round(text2num(new_age)), 45), 20)

		if (link_tags["b_type"])
			var/new_b_type = input(user, "Группа крови:", "Создание персонажа")  as null|anything in list( "A+", "A-", "B+", "B-", "AB+", "AB-", "O+", "O-" )

			if (new_b_type)
				b_type = new_b_type

		if (link_tags["hair"])
			var/new_hair = input(user, "Цвет волос.", "Создание персонажа") as color
			if(new_hair)
				r_hair = hex2num(copytext(new_hair, 2, 4))
				g_hair = hex2num(copytext(new_hair, 4, 6))
				b_hair = hex2num(copytext(new_hair, 6, 8))
/*
		if (link_tags["r_hair"])
			var/new_component = input(user, "Please select red hair component: 1-255", "Character Generation")  as text

			if (new_component)
				r_hair = max(min(round(text2num(new_component)), 255), 1)

		if (link_tags["g_hair"])
			var/new_component = input(user, "Please select green hair component: 1-255", "Character Generation")  as text

			if (new_component)
				g_hair = max(min(round(text2num(new_component)), 255), 1)

		if (link_tags["b_hair"])
			var/new_component = input(user, "Please select blue hair component: 1-255", "Character Generation")  as text

			if (new_component)
				b_hair = max(min(round(text2num(new_component)), 255), 1)
*/

		if (link_tags["facial"])
			var/new_facial = input(user, "Цвет растительности на лице.", "Создание персонажа") as color
			if(new_facial)
				r_facial = hex2num(copytext(new_facial, 2, 4))
				g_facial = hex2num(copytext(new_facial, 4, 6))
				b_facial = hex2num(copytext(new_facial, 6, 8))
/*
		if (link_tags["r_facial"])
			var/new_component = input(user, "Please select red facial component: 1-255", "Character Generation")  as text

			if (new_component)
				r_facial = max(min(round(text2num(new_component)), 255), 1)

		if (link_tags["g_facial"])
			var/new_component = input(user, "Please select green facial component: 1-255", "Character Generation")  as text

			if (new_component)
				g_facial = max(min(round(text2num(new_component)), 255), 1)

		if (link_tags["b_facial"])
			var/new_component = input(user, "Please select blue facial component: 1-255", "Character Generation")  as text

			if (new_component)
				b_facial = max(min(round(text2num(new_component)), 255), 1)
*/
		if (link_tags["eyes"])
			var/new_eyes = input(user, "Цвет глаз.", "Создание персонажа") as color
			if(new_eyes)
				r_eyes = hex2num(copytext(new_eyes, 2, 4))
				g_eyes = hex2num(copytext(new_eyes, 4, 6))
				b_eyes = hex2num(copytext(new_eyes, 6, 8))
/*
		if (link_tags["r_eyes"])
			var/new_component = input(user, "Please select red eyes component: 1-255", "Character Generation")  as text

			if (new_component)
				r_eyes = max(min(round(text2num(new_component)), 255), 1)

		if (link_tags["g_eyes"])
			var/new_component = input(user, "Please select green eyes component: 1-255", "Character Generation")  as text

			if (new_component)
				g_eyes = max(min(round(text2num(new_component)), 255), 1)

		if (link_tags["b_eyes"])
			var/new_component = input(user, "Please select blue eyes component: 1-255", "Character Generation")  as text

			if (new_component)
				b_eyes = max(min(round(text2num(new_component)), 255), 1)
*/
		if (link_tags["s_tone"])
			var/new_tone = input(user, "Оттенок кожи: 1-220 (1=альбинос, 35=белый, 150=чёрный, 220=невероятно чёрный)", "Создание персонажа")  as text

			if (new_tone)
				s_tone = max(min(round(text2num(new_tone)), 220), 1)
				s_tone =  -s_tone + 35

		if (link_tags["h_style"])
			var/new_style = input(user, "Стиль волос", "Создание персонажа")  as null|anything in list( "Cut Hair", "Short Hair", "Long Hair", "Mohawk", "Balding", "Wave", "Bedhead", "Dreadlocks", "Ponytail", "Bald" )

			if (new_style)
				h_style = new_style

		if (link_tags["f_style"])
			var/new_style = input(user, "Стиль лицевой растительности", "Создание персонажа")  as null|anything in list("Watson", "Chaplin", "Selleck", "Full Beard", "Long Beard", "Neck beard", "Van Dyke", "Elvis", "Abe", "Chinstrap", "Hipster", "Goatee", "Hogan", "Shaved")

			if (new_style)
				f_style = new_style

		if (link_tags["gender"])
			if (gender == MALE)
				gender = FEMALE
			else
				gender = MALE

		/*if (link_tags["UI"])
			if (UI == UI_B12)
				UI = UI_AGrey
			else if (UI == UI_AGrey)
				UI = UI_AGreen
			else
				UI = UI_B12*/

		if (link_tags["underwear"])
			if(!IsGuestKey(user.key))
				if (underwear == 1)
					underwear = 0
				else
					underwear = 1

		if (link_tags["b_syndicate"])
			be_syndicate = !( be_syndicate )

		if (link_tags["b_nuke_agent"])
			be_nuke_agent = !( be_nuke_agent )

		if (link_tags["b_takeover_agent"])
			be_takeover_agent = !( be_takeover_agent )

		if (link_tags["b_random_name"])
			be_random_name = !be_random_name
		/*if(link_tags["editbio"])
			bio = input(usr,"Íàïèøèòå ñâîþ áèîãðàôèþ.","Áèîãðàôè&#255;",bio) as message*/
		if(!IsGuestKey(user.key))
			if(link_tags["saveslot"])
				var/slot = link_tags["saveslot"]
				//var/bio2 = dbcon.Quote(bio)
				//var/
				//Getting rid of bios. I was a fan of bios for a long time, but who the hell reads them?
				//var/DBQuery/query = dbcon.NewQuery("REPLACE INTO `players` (`ckey`,`slot`,`slotname`,`real_name`, `gender`, `ages`, `occupation1`, `occupation2`, `occupation3`,`hair_red`, `hair_green`, `hair_blue`, `facial_red`, `facial_green`, `facial_blue`, `skin_tone`, `hair_style_name`, `facial_style_name`, `eyes_red`,`eyes_green`, `eyes_blue`, `blood_type`, `be_syndicate`, `be_nuke_agent`, `be_takeover_agent`, `underwear`,`name_is_always_random`,`bios`) VALUES ('[user.ckey]','[slot]',[dbcon.Quote(slotname)] ,[dbcon.Quote(real_name)], '[lowertext(gender)]', '[age]', '[occupation1]','[occupation2]', '[occupation3]', '[r_hair]', '[g_hair]', '[b_hair]', '[r_facial]', '[g_facial]', '[b_facial]', '[s_tone]', '[h_style]', '[f_style]', '[r_eyes]', '[g_eyes]', '[b_eyes]', '[b_type]', '[be_syndicate]', '[be_nuke_agent]', '[be_takeover_agent]', '[underwear]','[be_random_name]',[bio2]);")
				var/DBQuery/query = dbcon.NewQuery("REPLACE INTO `players` (`ckey`,`slot`,`slotname`,`real_name`, `gender`, `ages`, `occupation1`, `occupation2`, `occupation3`,`hair_red`, `hair_green`, `hair_blue`, `facial_red`, `facial_green`, `facial_blue`, `skin_tone`, `hair_style_name`, `facial_style_name`, `eyes_red`,`eyes_green`, `eyes_blue`, `blood_type`, `be_syndicate`, `be_nuke_agent`, `be_takeover_agent`, `underwear`,`name_is_always_random`) VALUES ('[user.ckey]','[slot]',[dbcon.Quote(slotname)] ,[dbcon.Quote(real_name)], '[lowertext(gender)]', '[age]', '[occupation1]','[occupation2]', '[occupation3]', '[r_hair]', '[g_hair]', '[b_hair]', '[r_facial]', '[g_facial]', '[b_facial]', '[s_tone]', '[h_style]', '[f_style]', '[r_eyes]', '[g_eyes]', '[b_eyes]', '[b_type]', '[be_syndicate]', '[be_nuke_agent]', '[be_takeover_agent]', '[underwear]','[be_random_name]');")
				if(!query.Execute())
					usr << query.ErrorMsg()
					usr << "Сообщи об ошибке администрации."
				else
					usr << "Сохранено"

			else if(link_tags["loadslot"])
				var/slot = link_tags["loadslot"]
				if(slot == "CLOSE")
					closesave(user)
					return
				if(!preferences.savefile_load(user, 0,slot))
					alert(user, "Нет сохраненного профиля.")
				else
					curslot = slot
					loadsave(user)
		if(link_tags["removeslot"])
			var/slot = link_tags["removeslot"]
			if(!slot)
				return
			var/DBQuery/query = dbcon.NewQuery("DELETE FROM `players`WHERE ckey='[usr.ckey]' AND slot='[slot]'")
			if(!query.Execute())
				usr << query.ErrorMsg()
				usr << "Report this."
			else
				usr << "Слот [slot] удалён."
				loadsave(usr)
		if(link_tags["loadslot2"])
			loadsave(user)
		if(link_tags["createslot"])
			var/list/slot = list()
			var/DBQuery/querys = dbcon.NewQuery("SELECT `slot` FROM `players` WHERE ckey='[usr.ckey]'")
			if(!querys.Execute())
				usr << "ERROR"
			while(querys.NextRow())
				var/list/row = querys.GetRowData()
				slot += row["slot"]
			var/count = slot.len
			count++
			if(count > 10)
				usr << "Ты достиг лимита символов."
				return
			var/slotname = input(usr,"Придумай название профиля","Название","Стандартное")
			slotname = dbcon.Quote(slotname)
			//var/DBQuery/query = dbcon.NewQuery("REPLACE INTO `players` (`ckey`,`slot`,`slotname`,`real_name`, `gender`, `ages`, `occupation1`, `occupation2`, `occupation3`,`hair_red`, `hair_green`, `hair_blue`, `facial_red`, `facial_green`, `facial_blue`, `skin_tone`, `hair_style_name`, `facial_style_name`, `eyes_red`,`eyes_green`, `eyes_blue`, `blood_type`, `be_syndicate`, `be_nuke_agent`, `be_takeover_agent`, `underwear`,`name_is_always_random`,`bios`) VALUES ('[user.ckey]','[count]',[slotname] ,'New Char', 'MALE', '30', 'No Preference','No Preference', 'No Preference', '0', '0', '0', '0', '0', '0', '0', 'Short Hair', 'Shaved', '0', '0', '0', 'A+', '0', '0', '0', '1','0','Nothing here yet...');")
			var/DBQuery/query = dbcon.NewQuery("REPLACE INTO `players` (`ckey`,`slot`,`slotname`,`real_name`, `gender`, `ages`, `occupation1`, `occupation2`, `occupation3`,`hair_red`, `hair_green`, `hair_blue`, `facial_red`, `facial_green`, `facial_blue`, `skin_tone`, `hair_style_name`, `facial_style_name`, `eyes_red`,`eyes_green`, `eyes_blue`, `blood_type`, `be_syndicate`, `be_nuke_agent`, `be_takeover_agent`, `underwear`,`name_is_always_random`) VALUES ('[user.ckey]','[count]',[slotname] ,'New Char', 'MALE', '30', 'No Preference','No Preference', 'No Preference', '0', '0', '0', '0', '0', '0', '0', 'Short Hair', 'Shaved', '0', '0', '0', 'A+', '0', '0', '0', '1','0');")
			if(!query.Execute())
				usr << query.ErrorMsg()
				usr << "Сообщи об ошибке администрации."
			else
				usr << "Сохранено"
			if(!preferences.savefile_load(user, 0,count))
				alert(user, "Нет сохраненного профиля.")
			else
				curslot = count
				closesave(user)
		if (link_tags["reset_all"])
			gender = MALE
			randomize_name()

			age = 30
			occupation1 = "Без предпочтений"
			occupation2 = "Без предпочтений"
			occupation3 = "Без предпочтений"
			underwear = 1
			be_syndicate = 0
			be_random_name = 0
			r_hair = 0.0
			g_hair = 0.0
			b_hair = 0.0
			r_facial = 0.0
			g_facial = 0.0
			b_facial = 0.0
			h_style = "Short Hair"
			f_style = "Shaved"
			r_eyes = 0.0
			g_eyes = 0.0
			b_eyes = 0.0
			s_tone = 0.0
			b_type = "A+"


		ShowChoices(user)

	proc/copy_to(mob/living/carbon/human/character)
		if(be_random_name)
			randomize_name()
		character.real_name = real_name
		character.be_syndicate = be_syndicate

		character.gender = gender

		character.age = age
		character.b_type = b_type

		character.r_eyes = r_eyes
		character.g_eyes = g_eyes
		character.b_eyes = b_eyes

		character.r_hair = r_hair
		character.g_hair = g_hair
		character.b_hair = b_hair

		character.r_facial = r_facial
		character.g_facial = g_facial
		character.b_facial = b_facial

		character.s_tone = s_tone

		character.h_style = h_style
		character.f_style = f_style

		/*switch (UI)
			if (UI_B12)
				character.UI = 'screen1_b12.dmi'
			if (UI_AGrey)
				character.UI = 'screen1_agrey.dmi'
			if (UI_AGreen)
				character.UI = 'screen1_agreen.dmi'*/

		switch(h_style)
			if("Short Hair")
				character.hair_icon_state = "hair_a"
			if("Long Hair")
				character.hair_icon_state = "hair_b"
			if("Cut Hair")
				character.hair_icon_state = "hair_c"
			if("Mohawk")
				character.hair_icon_state = "hair_d"
			if("Balding")
				character.hair_icon_state = "hair_e"
			if("Wave")
				character.hair_icon_state = "hair_f"
			if("Bedhead")
				character.hair_icon_state = "hair_bedhead"
			if("Dreadlocks")
				character.hair_icon_state = "hair_dreads"
			if("Ponytail")
				character.hair_icon_state = "hair_ponytail"
			else
				character.hair_icon_state = "bald"


		switch(f_style)
			if ("Watson")
				character.face_icon_state = "facial_watson"
			if ("Chaplin")
				character.face_icon_state = "facial_chaplin"
			if ("Selleck")
				character.face_icon_state = "facial_selleck"
			if ("Neckbeard")
				character.face_icon_state = "facial_neckbeard"
			if ("Full Beard")
				character.face_icon_state = "facial_fullbeard"
			if ("Long Beard")
				character.face_icon_state = "facial_longbeard"
			if ("Van Dyke")
				character.face_icon_state = "facial_vandyke"
			if ("Elvis")
				character.face_icon_state = "facial_elvis"
			if ("Abe")
				character.face_icon_state = "facial_abe"
			if ("Chinstrap")
				character.face_icon_state = "facial_chin"
			if ("Hipster")
				character.face_icon_state = "facial_hip"
			if ("Goatee")
				character.face_icon_state = "facial_gt"
			if ("Hogan")
				character.face_icon_state = "facial_hogan"
			else
				character.face_icon_state = "bald"

		if (underwear == 1)
			character.underwear = pick(1,2,3,4,5)
		else
			character.underwear = 0

		character.update_face()
		character.update_body()

	proc/create_character()
		startup.status = SOUND_PAUSED
		src << startup
		var/mob/living/carbon/human/new_character = new(loc)

		close_spawn_windows()

		ticker.minds += mind	//Strumpet - Add new players' minds to the ticker list to be used for traitor objectives.

		copy_to(new_character)
		new_character.dna.ready_dna(new_character)

		mind.transfer_to(new_character)


		return new_character

	/*proc/ViewManifest()
		var/dat = "<html><body>"
		dat += "<h4>Список экипажа</h4>"
		for (var/datum/data/record/t in data_core.general)
			dat += "[t.fields["name"]] - [t.fields["rank"]]<br>"
		dat += "<br>"

		src << browse(dat, "window=manifest;size=300x420;can_close=1")*/

	Move()
		return 0

	proc/close_spawn_windows()
		src << browse(null, "window=latechoices") //closes late choices window
		src << browse(null, "window=playersetup") //closes the player setup window
		src << browse(null, "window=manifest") //closes the crew manifest window
		src << browse(null, "window=preferences") //closes the crew manifest window