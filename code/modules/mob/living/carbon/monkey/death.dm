/mob/living/carbon/monkey/death(gibbed)
	if(stat == 2)
		return

	if (healths)
		healths.icon_state = "health5"
	stat = 2
	canmove = 0
	if (blind)
		blind.invisibility = 101
	update_lying(90)
	var/h = hand
	hand = 0
	drop_item()
	hand = 1
	drop_item()
	hand = h

	return ..(gibbed)