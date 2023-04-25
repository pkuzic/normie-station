/* Title goes for medal name that should be in byond hub, ex - http://www.byond.com/games/Nikie/AnimusStationMedals
Announce goes for announcement to everybody - 0, or only to player and admins - 1
If end_show var is set to 1, the medal will be added to list of medals that will be announced to everybody
after the round end (after escape phase). You don't need to use it on medals such as "Newborn",
but on those like "Lights out" or "I bring darkness!", since those will spoil the gamemode, or smth
&quot; is a "
*/

var/global/list/end_round_medals

/mob/proc/unlock_medal(title, announce, end_show)
	spawn()
		if(config.medal_hub && config.medal_password)
			if(ismob(src) && src.key)
				if(world.SetMedal(title, src, config.medal_hub, config.medal_password) == 1)
					if(announce)
						world << "<font color=olive><b>[src.key] награждается достижением — &quot;[title]&quot;.</b></font>"
					if(!announce)
						src << "<font color=olive><b>Я получаю достижение — &quot;[title]&quot;!</b></font>"
						message_admins("<b>[src.key]</b> награждается достижением — <b>&quot;[title]&quot;</b>.")
					if(end_show)
						world.add_to_end_medals(title, src.key)

/client/proc/unlock_medal_client(title, announce, end_show) // If src is not a mob (client in starting screen)
	spawn()
		if(config.medal_hub && config.medal_password)
			if(!ismob(src) && src.key)
				if(world.SetMedal(title, src, config.medal_hub, config.medal_password) == 1)
					if(announce)
						world << "<font color=olive><b>[src.key] награждается достижением — &quot;[title]&quot;.</b></font>"
					if(!announce)
						src << "<font color=olive><b>Я получаю достижение — &quot;[title]&quot;!</b></font>"
						message_admins("<b>[src.key]</b> награждается достижением — <b>&quot;[title]&quot;</b>")
					if(end_show)
						world.add_to_end_medals(title, src.key)

/world/proc/announce_end_medals()
	if(end_round_medals.len)
		world << "<b>Достижения, полученные в процессе игры:</b>"
		world << "<li>[end_round_medals]</li>"
	else
		world << "<font color=olive><b>Никто не получил &quot;достижений&quot; в процессе игры!</b></font>"

/world/proc/add_to_end_medals(title, key)
	if(title && key)
		if(!end_round_medals.len) // check is for proper
			end_round_medals += "    [title] у [key]"
		else
			end_round_medals += "    <br>[title] у [key]"

/world/proc/newborn_medal(client/client)
	spawn()
		if(config.medal_hub && config.medal_password)
			if(client.key)
				if(world.GetMedal("Новорожденный", client, config.medal_hub, config.medal_password) == 1)
					if(world.SetMedal("Старое поколение", client, config.medal_hub, config.medal_password) == 1)
						world << "<font color=olive><b>[client.key] награждается достижением — &quot;Старое поколение&quot;.</b></font>"
				else
					if(world.SetMedal("Новое поколение", client, config.medal_hub, config.medal_password) == 1)
						world << "<font color=olive><b>[client.key] награждается достижением — &quot;Новое поколение&quot;.</b></font>"

/client/verb/cmd_medals()
	set category = "OOC"
	set name = "Достижения"

	world.hub = config.medal_hub // they say it can be null, but then it won't work
	world.hub_password = config.medal_password

	if(!config.medal_hub || !config.medal_password)
		src << "The medal hub configuration is not set!"
		return

	src << "Получаю информацию о достижениях..."

	var/medal
	var/pMedals = world.GetMedal(medal, usr, config.medal_hub) // medal, who, hub // param_Medals
	var/lMedals = params2list(pMedals) // making them a list // list_Medals

	var/medal_got // For output
	var/medal_count = 0 // For counting
	src << "<b>Достижения:</b>" // First line
	for (medal_got in lMedals)
		src << "<li>            [medal_got]</li>" // leaving alot of        spaces and showing the medal
		medal_count++ // then counting it

	src << "<b>У меня [medal_count] достижений.</b>" // and then showing amount of medals
