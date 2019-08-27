/mob/living/carbon/alien/larva/death(gibbed)
	if(stat == 2)
		return
	if(healths)
		healths.icon_state = "health6"
	icon_state = "larva_l"
	stat = 2

	if (!gibbed)

		canmove = 0
		if(src.client)
			blind.invisibility = 101
		update_lying(90)
		var/h = src.hand
		hand = 0
		drop_item()
		hand = 1
		drop_item()
		hand = h

	return ..(gibbed)
