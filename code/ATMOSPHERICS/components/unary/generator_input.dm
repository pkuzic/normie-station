/obj/machinery/atmospherics/unary/generator_input
	icon = 'heat_exchanger.dmi'
	icon_state = "intact"
	density = 1

	name = "Вход генератора"
	//desc = "Placeholder"
	nominative = "вход генератора"
	genitive = "входа генератора"
	dative = "входу генератора"
	accusative = "вход генератора"
	instrumentative = "входом генератора"
	prepositive = "входе генератора"


	var/update_cycle

	update_icon()
		if(node)
			icon_state = "intact"
		else
			icon_state = "exposed"

		return

	proc
		return_exchange_air()
			return air_contents