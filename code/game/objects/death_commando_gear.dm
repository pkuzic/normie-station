/obj/beam/a_laser/pulse_laser
	name = "импульсная пушка"

	nominative = "пушка импульсного лазера" //Кто? Что? (есть)
	genitive = "пушки импульсного лазера" //Кого? Чего? (нет)
	dative = "пушке импульсного лазера"  //Кому? Чему? (дам)
	accusative = "пушку импульсного лазера" //Кого? Что? (вижу)
	instrumentative = "пушкой импульсного лазера" //Кем? Чем? (горжусь)
	prepositive = "пушке импульсного лазера" //О ком? О чем? (думаю)

	desc = "Выглядит достаточно внушительно."

	icon_state = "u_laser"

	Bump(atom/A)
		spawn()
			if(A)
				A.bullet_act(PROJECTILE_PULSE)
			del(src)