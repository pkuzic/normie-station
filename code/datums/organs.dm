/datum/organ
	var/name = "organ"
	var/mob/living/owner = null

/datum/organ/external
	name = "external"
	var/icon_name = null

	var/damage_state = "00"
	var/brute_dam = 0
	var/burn_dam = 0
	var/bandaged = 0
	var/max_damage = 0
	var/wound_size = 0
	var/max_size = 0
	var/critical = 0
	var/perma_dmg = 0
	var/bleeding = 0
	var/perma_injury = 0
	var/broken = 0
	var/destroyed
	var/min_broken_damage = 30

	var/damage_msg = "\red Я чувствую сильную боль!"
	process()
		if(broken == 0)
			perma_dmg = 0
		if(brute_dam > min_broken_damage)
			if(broken == 0)
				var/dmgmsg = "<b>[damage_msg]</b> в <b>[display_name]</b>"
				owner << dmgmsg
				for(var/mob/M in viewers(owner))
					if(M != owner)
						M.show_message("\red Я слышу громкий треск, исходящий из <b>[owner.name]</b>!")
				broken = 1
				wound = "broken" //Randomise in future
			// Uncomment for broken bones to matter
		perma_injury = brute_dam + burn_dam
		//	brute_dam = 0
		//	burn_dam = 0
		return
		//return

	var/open = 0
	var/display_name
	var/clean = 1
	var/stage = 0
	var/wound = 0
	var/split = 0

/datum/organ/external/chest
	name = "грудь"

	nominative = "грудь" //кто? что? лестница
	genitive = "груди" //кого? чего? лестницы
	dative = "груди"  //кому?  чему? лестнице
	accusative = "грудь" //кого? что?
	instrumentative = "грудью" //кем? чем? лестницей
	prepositive = "груди" //о ком? о чем? лестнице

	icon_name = "chest"
	max_damage = 150
	min_broken_damage = 75
	display_name = "грудь"
	var/datum/organ/internal/heart
	var/datum/organ/internal/lung
	var/datum/organ/internal/intestines
/datum/organ/external/groin
	name = "пах"

	nominative = "пах" //кто? что? лестница
	genitive = "паха" //кого? чего? лестницы
	dative = "паху"  //кому?  чему? лестнице
	accusative = "пах" //кого? что?
	instrumentative = "пахом" //кем? чем? лестницей
	prepositive = "пахе" //о ком? о чем? лестнице

	icon_name = "groin"
	max_damage = 115
	min_broken_damage = 70
	display_name = "groin"
/datum/organ/external/head
	name = "голова"

	nominative = "голова" //кто? что? лестница
	genitive = "головы" //кого? чего? лестницы
	dative = "груди"  //кому?  чему? лестнице
	accusative = "грудь" //кого? что?
	instrumentative = "грудью" //кем? чем? лестницей
	prepositive = "груди" //о ком? о чем? лестнице

	icon_name = "head"
	max_damage = 125
	min_broken_damage = 70
	display_name = "голова"
	var/datum/organ/external/eye_r
	var/datum/organ/external/eye_l
	var/datum/organ/internal/brain
/datum/organ/external/l_arm
	name = "левая рука"

	nominative = "левая рука" //кто? что? лестница
	genitive = "левой руки" //кого? чего? лестницы
	dative = "левой руке"  //кому?  чему? лестнице
	accusative = "левой руки" //кого? что?
	instrumentative = "левой рукой" //кем? чем? лестницей
	prepositive = "левой руке" //о ком? о чем? лестнице

	icon_name = "l_arm"
	max_damage = 75
	min_broken_damage = 60
	display_name = "левая рука"
/datum/organ/external/l_foot
	name = "левая ступня"

	nominative = "левая ступня" //кто? что? лестница
	genitive = "левой ступни" //кого? чего? лестницы
	dative = "левой ступне"  //кому?  чему? лестнице
	accusative = "левую ступню" //кого? что?
	instrumentative = "левой ступней" //кем? чем? лестницей
	prepositive = "левой ступне" //о ком? о чем? лестнице

	icon_name = "l_foot"
	max_damage = 40
	min_broken_damage = 40
	display_name = "тевая ступня"
/datum/organ/external/l_hand
	name = "левая ладонь"

	nominative = "левая ладонь" //кто? что? лестница
	genitive = "левой ладони" //кого? чего? лестницы
	dative = "левой ладони"  //кому?  чему? лестнице
	accusative = "левую ладонь" //кого? что?
	instrumentative = "левой ладонью" //кем? чем? лестницей
	prepositive = "левой ладони" //о ком? о чем? лестнице

	icon_name = "l_hand"
	max_damage = 40
	min_broken_damage = 40
	display_name = "левая ладонь"
/datum/organ/external/l_leg
	name = "левая нога"

	nominative = "левая нога" //кто? что? лестница
	genitive = "левой ноги" //кого? чего? лестницы
	dative = "левой ноге"  //кому?  чему? лестнице
	accusative = "левую ногу" //кого? что?
	instrumentative = "левой ногой" //кем? чем? лестницей
	prepositive = "левой ноге" //о ком? о чем? лестнице

	icon_name = "l_leg"
	max_damage = 75
	min_broken_damage = 60
	display_name = "левая нога"
/datum/organ/external/r_arm
	name = "правая рука"

	nominative = "правая рука" //кто? что? лестница
	genitive = "правой руки" //кого? чего? лестницы
	dative = "правой руке"  //кому?  чему? лестнице
	accusative = "праврй руки" //кого? что?
	instrumentative = "правой рукой" //кем? чем? лестницей
	prepositive = "правой руке" //о ком? о чем? лестнице

	icon_name = "r_arm"
	max_damage = 75
	min_broken_damage = 60
	display_name = "правая рука"
/datum/organ/external/r_foot
	name = "правая ступня"

	nominative = "правая ступня" //кто? что? лестница
	genitive = "правой ступни" //кого? чего? лестницы
	dative = "правой ступне"  //кому?  чему? лестнице
	accusative = "правую ступню" //кого? что?
	instrumentative = "правой ступней" //кем? чем? лестницей
	prepositive = "правой ступне" //о ком? о чем? лестнице

	icon_name = "r_foot"
	max_damage = 40
	min_broken_damage = 40
	display_name = "правая ступня"
/datum/organ/external/r_hand
	name = "правая ладонь"

	nominative = "правая ладонь" //кто? что? лестница
	genitive = "правой ладони" //кого? чего? лестницы
	dative = "правой ладони"  //кому?  чему? лестнице
	accusative = "правую ладонь" //кого? что?
	instrumentative = "правой ладонью" //кем? чем? лестницей
	prepositive = "правой ладони" //о ком? о чем? лестнице

	icon_name = "r_hand"
	max_damage = 40
	min_broken_damage = 40
	display_name = "правая ладонь"

/datum/organ/external/r_leg
	name = "правая нога"

	nominative = "правая нога" //кто? что? лестница
	genitive = "правой ноги" //кого? чего? лестницы
	dative = "правой ноге"  //кому?  чему? лестнице
	accusative = "правой ноги" //кого? что?
	instrumentative = "правой ногой" //кем? чем? лестницей
	prepositive = "правой ноге" //о ком? о чем? лестнице

	icon_name = "r_leg"
	max_damage = 75
	min_broken_damage = 60
	display_name = "правая нога"

/datum/organ/internal
	name = "внутренние"

/datum/organ/internal/blood_vessels
	name = "кровеносные сосуды"

	nominative = "кровеносные сосуды" //кто? что? лестница
	genitive = "кровеносных сосудов" //кого? чего? лестницы
	dative = "кровеносным сосудам"  //кому?  чему? лестнице
	accusative = "кровеносные сосуды" //кого? что?
	instrumentative = "кровеносными сосудами" //кем? чем? лестницей
	prepositive = "кровеносных сосудах" //о ком? о чем? лестнице

	var/heart = null
	var/lungs = null
	var/kidneys = null

/datum/organ/internal/brain
	name = "мозг"

	nominative = "мозг" //кто? что? лестница
	genitive = "мозга" //кого? чего? лестницы
	dative = "мозгу"  //кому?  чему? лестнице
	accusative = "мозг" //кого? что?
	instrumentative = "мозгом" //кем? чем? лестницей
	prepositive = "мозгах" //о ком? о чем? лестнице

	var/head = null

/datum/organ/internal/excretory
	name = "excretory"
	var/excretory = 7.0
	var/blood_vessels = null

/datum/organ/internal/heart
	name = "сердце"

	nominative = "сердце" //кто? что? лестница
	genitive = "сердца" //кого? чего? лестницы
	dative = "сердцу"  //кому?  чему? лестнице
	accusative = "сердца" //кого? что?
	instrumentative = "сердцем" //кем? чем? лестницей
	prepositive = "сердце" //о ком? о чем? лестнице

/datum/organ/internal/immune_system
	name = "иммунная система"

	nominative = "иммунная система" //кто? что? лестница
	genitive = "иммунной системе" //кого? чего? лестницы
	dative = "иммунной системе"  //кому?  чему? лестнице
	accusative = "иммунную систему" //кого? что? лестницу
	instrumentative = "иммунной системой" //кем? чем? лестницей
	prepositive = "иммунной системе" //о ком? о чем? лестнице

	var/blood_vessels = null
	var/isys = null

/datum/organ/internal/intestines
	name = "кишки"

	nominative = "кишки" //кто? что? лестница
	genitive = "кишок" //кого? чего? лестницы
	dative = "кишкам"  //кому?  чему? лестнице
	accusative = "кишок" //кого? что? лестницу
	instrumentative = "кишками" //кем? чем? лестницей
	prepositive = "кишках" //о ком? о чем? лестнице

	var/intestines = 3.0
	var/blood_vessels = null

/datum/organ/internal/liver
	name = "liver"

	nominative = "печень" //кто? что? лестница
	genitive = "печени" //кого? чего? лестницы
	dative = "печени"  //кому?  чему? лестнице
	accusative = "печень" //кого? что? лестницу
	instrumentative = "печенью" //кем? чем? лестницей
	prepositive = "печени" //о ком? о чем? лестнице

	var/intestines = null
	var/blood_vessels = null

/datum/organ/internal/lungs
	name = "лёгкие"

	nominative = "лёгкие" //кто? что? лестница
	genitive = "лёгких" //кого? чего? лестницы
	dative = "лёгким"  //кому?  чему? лестнице
	accusative = "лёгкие" //кого? что? лестницу
	instrumentative = "лёгкими" //кем? чем? лестницей
	prepositive = "лёгких" //о ком? о чем? лестнице

	var/lungs = 3.0
	var/throat = null
	var/blood_vessels = null

/datum/organ/internal/stomach
	name = "желудок"

	nominative = "желудок" //кто? что? лестница
	genitive = "желудка" //кого? чего? лестницы
	dative = "желудку"  //кому?  чему? лестнице
	accusative = "желудок" //кого? что? лестницу
	instrumentative = "желудком" //кем? чем? лестницей
	prepositive = "желудке" //о ком? о чем? лестнице

	var/intestines = null

/datum/organ/internal/throat
	name = "throat"

	nominative = "горло" //кто? что? лестница
	genitive = "горла" //кого? чего? лестницы
	dative = "горлу"  //кому?  чему? лестнице
	accusative = "горло" //кого? что? лестницу
	instrumentative = "горлом" //кем? чем? лестницей
	prepositive = "горле" //о ком? о чем? лестнице

	var/lungs = null
	var/stomach = null