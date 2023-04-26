/obj
	//var/datum/module/mod		//not used
	var/m_amt = 0	// metal
	var/g_amt = 0	// glass
	var/w_amt = 0	// waster amounts
	var/global/tagcnum = 0
	var/explosionstrength = 0
	var/spawnchance = null 	//If this is defined, this is the percent chance that this object will spawn.  Checked in New().  Intended to be defined on the map, for some randomness in item placement.

	var/list/NetworkNumber = list( )
	var/list/Networks = list( )

	animate_movement = 2

	proc
		handle_internal_lifeform(mob/lifeform_inside_me, breath_request)
			//Return: (NONSTANDARD)
			//		null if object handles breathing logic for lifeform
			//		datum/air_group to tell lifeform to process using that breath return
			//DEFAULT: Take air from turf to give to have mob process
			if(breath_request>0)
				return remove_air(breath_request)
			else
				return null

		initialize()

	New()
		src.tag = "obj[++tagcnum]"
		if(spawnchance)
			if(prob(100-spawnchance))
				del src





/obj/item/policetaperoll
	name = "рулон ленты"
	desc = "Рулон ленты, позволяющий ограждать зону от нежелательной публики."

	nominative = "рулон ленты"
	genitive = "рулона ленты"
	dative = "рулону ленты"
	accusative = "рулон ленты"
	instrumentative = "рулоном ленты"
	prepositive = "рулоне ленты"

	icon = 'policetape.dmi'
	icon_state = "rollstart"
	flags = FPRINT
	var/tapestartx = 0
	var/tapestarty = 0
	var/tapestartz = 0
	var/tapeendx = 0
	var/tapeendy = 0
	var/tapeendz = 0

/obj/item/policetape
	name = "лента"

	nominative = "лента"
	genitive = "ленты"
	dative = "ленте"
	accusative = "ленту"
	instrumentative = "лентой"
	prepositive = "о ленте"

	desc = "Оградительная лента."
	icon = 'policetape.dmi'
	anchored = 1
	density = 1
	throwpass = 1
	req_access = list(access_security)

/obj/blob
	icon = 'blob.dmi'
	icon_state = "bloba0"
	var/health = 30
	density = 1
	opacity = 0
	anchored = 1

/obj/blob/idle
	name = "блоб"

	nominative = "блоб"
	genitive = "блоба"
	dative = "блобу"
	accusative = "блоб"
	instrumentative = "блобом"
	prepositive = "блобе"

	desc = "Выглядит пугающе."
	icon_state = "blobidle0"

/obj/mark
	var/mark = ""
	icon = 'mark.dmi'
	icon_state = "blank"
	anchored = 1
	layer = 99
	mouse_opacity = 0

/obj/admins
	name = "admins"
	var/rank = null
	var/owner = null
	var/state = 1
	//state = 1 for playing : default
	//state = 2 for observing

/obj/bhole
	name = "Чёрная дыра"
	icon = 'objects.dmi'

	nominative = "чёрная дыра"
	genitive = "чёрной дыры"
	dative = "чёрной дыре"
	accusative = "чёрную дыру"
	instrumentative = "чёрной дырой"
	prepositive = "чёрной дыре"

	icon_state = "bhole2"
	opacity = 0
	density = 0
	anchored = 1
	var/datum/effects/system/harmless_smoke_spread/smoke




/obj/beam
	name = "Луч"

	nominative = "луч"
	genitive = "луча"
	dative = "лучу"
	accusative = "луч"
	instrumentative = "лучом"
	prepositive = "луче"

/obj/beam/a_laser
	name = "Лазер"

	nominative = "лазер"
	genitive = "лазера"
	dative = "лазеру"
	accusative = "лазер"
	instrumentative = "лазером"
	prepositive = "лазере"

	icon = 'projectiles.dmi'
	icon_state = "laser"
	density = 1
	var/yo = null
	var/xo = null
	var/current = null
	var/life = 50.0
	anchored = 1.0
	flags = TABLEPASS

/obj/beam/i_beam
	name = "Инфракрасный луч"

	nominative = "инфракрасный луч"
	genitive = "инфракрасного луча"
	dative = "инфракрасному лучу"
	accusative = "инфракрасный луч"
	instrumentative = "инфракрасным лучом"
	prepositive = "инфракрасном луче"

	icon = 'projectiles.dmi'
	icon_state = "ibeam"
	var/obj/beam/i_beam/next = null
	var/obj/item/device/infra/master = null
	var/limit = null
	var/visible = 0.0
	var/left = null
	anchored = 1.0
	flags = TABLEPASS


/obj/bedsheetbin
	name = "Бельевая корзина"
	desc = "Корзина для хранения белья."

	nominative = "бельевая корзина"
	genitive = "бельевой корзины"
	dative = "бельевой корзине"
	accusative = "бельевую корзину"
	instrumentative = "бельевой корзиной"
	prepositive = "бельевой корзине"

	icon = 'items.dmi'
	icon_state = "bedbin"
	var/amount = 23.0
	anchored = 1.0

/obj/begin
	name = "begin"

	nominative = "begin"
	genitive = "begin"
	dative = "begin"
	accusative = "begin"
	instrumentative = "begin"
	prepositive = "begin"

	icon = 'stationobjs.dmi'
	icon_state = "begin"
	anchored = 1.0

/obj/bullet
	name = "Пуля"

	nominative = "пуля"
	genitive = "пули"
	dative = "пуле"
	accusative = "пулю"
	instrumentative = "пулей"
	prepositive = "пуле"

	icon = 'projectiles.dmi'
	icon_state = "bullet"
	density = 1
	var/yo = null
	var/xo = null
	var/current = null
	anchored = 1.0
	flags = TABLEPASS

/obj/bullet/weakbullet


/obj/bullet/electrode
	name = "Электрод"

	nominative = "электрод"
	genitive = "электрода"
	dative = "электроду"
	accusative = "электрод"
	instrumentative = "электродом"
	prepositive = "электроде"

	icon_state = "spark"

/obj/bullet/teleshot
	name = "Телевыстрел"

	nominative = "телевыстрел"
	genitive = "телевыстрела"
	dative = "телевыстрелу"
	accusative = "телевыстрел"
	instrumentative = "телевыстрелом"
	prepositive = "телевыстреле"

	icon_state = "spark"
	var/failchance = 5
	var/obj/item/target = null

/obj/bullet/cbbolt
	name = "Арбалетный болт"

	nominative = "арбалетный болт"
	genitive = "арбалетного болта"
	dative = "арбалетному болту"
	accusative = "арбалетный болт"
	instrumentative = "арбалетным болтом"
	prepositive = "арбалетном болте"

	icon_state = "cbbolt"

/obj/datacore
	name = "datacore"

	nominative = "datacore"
	genitive = "datacore"
	dative = "datacore"
	accusative = "datacore"
	instrumentative = "datacore"
	prepositive = "datacore"

	var/list/medical = list(  )
	var/list/general = list(  )
	var/list/security = list(  )

/obj/equip_e
	name = "equip e"

	nominative = "equip e"
	genitive = "equip e"
	dative = "equip e"
	accusative = "equip e"
	instrumentative = "equip e"
	prepositive = "equip e"

	var/mob/source = null
	var/s_loc = null
	var/t_loc = null
	var/obj/item/item = null
	var/place = null

/obj/equip_e/human
	name = "человек"

	nominative = "человек"
	genitive = "человека"
	dative = "человеку"
	accusative = "человека"
	instrumentative = "человеком"
	prepositive = "человеке"

	var/mob/living/carbon/human/target = null

/obj/equip_e/monkey
	name = "обезьяна"

	nominative = "обезьяна"
	genitive = "обезьяны"
	dative = "обезьяне"
	accusative = "обезьяну"
	instrumentative = "обезьяной"
	prepositive = "обезьяне"

	var/mob/living/carbon/monkey/target = null

/obj/grille
	desc = "Кусок металла с равномерно расположенными отверстиями в виде сетки. Блокирует крупные объекты, но пропускает мелкие предметы, газ или энергетические лучи.."
	name = "решётка"

	nominative = "решётка"
	genitive = "решётки"
	dative = "решётке"
	accusative = "решётку"
	instrumentative = "решёткой"
	prepositive = "решётке"

	icon = 'structures.dmi'
	icon_state = "grille"
	density = 1
	layer = 2.9
	var/health = 10.0
	var/destroyed = 0.0
	anchored = 1.0
	flags = FPRINT | CONDUCT
	pressure_resistance = 5*ONE_ATMOSPHERE

/obj/item
	name = "Предмет"

	nominative = "предмет"
	genitive = "предмета"
	dative = "предмету"
	accusative = "предмет"
	instrumentative = "предметом"
	prepositive = "о предмете"

	icon = 'items.dmi'
	var/icon_old = null
	var/abstract = 0.0
	var/force = null
	var/item_state = null
	var/damtype = "brute"
	var/throwforce = 10
	var/r_speed = 1.0
	var/health = null
	var/burn_point = null
	var/burning = null
	var/hitsound = null
	var/w_class = 3.0
	var/captured_by_securitron = 0
	flags = FPRINT | TABLEPASS
	pressure_resistance = 50
	var/obj/item/master = null

/obj/item/device
	icon = 'device.dmi'

/obj/item/device/detective_scanner
	name = "Сканер"
	desc = "Используется для сканирования объектов на наличие ДНК и отпечатков пальцев."

	nominative = "сканер"
	genitive = "сканера"
	dative = "сканеру"
	accusative = "сканер"
	instrumentative = "сканером"
	prepositive = "сканере"

	icon_state = "forensic0"
	var/amount = 20.0
	var/printing = 0.0
	w_class = 2.0
	item_state = "electronic"
	flags = FPRINT | TABLEPASS | ONBELT | CONDUCT | USEDELAY


/obj/item/device/flash
	name = "Ослепитель"
	desc = "И кто придумал настолько примитивное и глупое название подобной вещи?"

	nominative = "ослепитель"
	genitive = "ослепителя"
	dative = "ослепителю"
	accusative = "ослепитель"
	instrumentative = "ослепителем"
	prepositive = "ослепителе"


	icon_state = "flash"
	var/l_time = 1.0
	var/shots = 5.0
	throwforce = 5
	w_class = 1.0
	throw_speed = 4
	throw_range = 10
	flags = FPRINT | TABLEPASS| CONDUCT
	item_state = "electronic"
	var/status = 1

/obj/item/device/flashlight
	name = "Фонарь"
	desc = "Ручной аварийный свет."

	nominative = "фонарь"
	genitive = "фонаря"
	dative = "фонарю"
	accusative = "фонарь"
	instrumentative = "фонарем"
	prepositive = "фонаре"

	icon_state = "flight0"
	var/on = 0
	w_class = 2
	item_state = "flight"
	flags = FPRINT | ONBELT | TABLEPASS | CONDUCT
	m_amt = 50
	g_amt = 20

/obj/item/device/healthanalyzer
	name = "Анализатор здоровья"

	desc = "Ручной сканер тела, способный дать оценку состояния здоровья субъекта."

	nominative = "анализатор здоровья"
	genitive = "анализатора здоровья"
	dative = "анализатору здоровья"
	accusative = "анализатор здоровья"
	instrumentative = "анализатором здоровья"
	prepositive = "анализаторе здоровья"

	icon_state = "health"
	item_state = "analyzer"
	flags = FPRINT | ONBELT | TABLEPASS | CONDUCT
	throwforce = 3
	w_class = 1.0
	throw_speed = 5
	throw_range = 10
	m_amt = 200

/obj/item/device/igniter
	name = "Поджигатель"
	desc = "Маленькое электронное приспособление, способное выдать искру."

	nominative = "поджигатель"
	genitive = "поджигателя"
	dative = "поджигателю"
	accusative = "поджигателя"
	instrumentative = "поджигателем"
	prepositive = "поджигателе"


	icon_state = "igniter"
	var/status = 1.0
	flags = FPRINT | TABLEPASS| CONDUCT
	item_state = "electronic"
	m_amt = 100
	throwforce = 5
	w_class = 1.0
	throw_speed = 3
	throw_range = 10


/obj/item/device/infra
	name = "Инфракрасный луч"
	desc = "Излучает видимый или невидимый луч, реагирующий на контакт."

	nominative = "инфракрасный луч"
	genitive = "инфракрасного луча"
	dative = "инфракрасному лучу"
	accusative = "инфракрасный луч"
	instrumentative = "инфракрасным лучом"
	prepositive = "инфракрасном луче"

	icon_state = "infrared0"
	var/obj/beam/i_beam/first = null
	var/state = 0.0
	var/visible = 0.0
	flags = FPRINT | TABLEPASS| CONDUCT
	w_class = 2.0
	item_state = "electronic"
	m_amt = 150

/obj/item/device/infra_sensor
	name = "Инфракрасный сенсор"
	desc = "Ищет инфракрасные лучи в пределах видимости."

	nominative = "инфракрасный сенсор"
	genitive = "инфракрасного сенсора"
	dative = "инфракрасному сенсору"
	accusative = "инфракрасный сенсор"
	instrumentative = "инфракрасным сенсором"
	prepositive = "инфракрасном сенсоре"

	icon_state = "infra_sensor"
	var/passive = 1.0
	flags = FPRINT | TABLEPASS| CONDUCT
	item_state = "electronic"
	m_amt = 150

/obj/item/device/t_scanner
	name = "Т-лучевой сканер"
	desc = "Излучатель терагерцового излучения, используемый для обнаружения объектов под полом, таких как кабели и трубы."

	nominative = "т-лучевой сканер"
	genitive = "т-лучевого сканера"
	dative = "т-лучевому сканеру"
	accusative = "т-лучевой сканер"
	instrumentative = "т-лучевым сканером"
	prepositive = "о т-лучевом сканере"

	icon_state = "t-ray0"
	var/on = 0
	flags = FPRINT|ONBELT|TABLEPASS
	w_class = 2
	item_state = "electronic"
	m_amt = 150

/obj/item/device/multitool //would need to get rid of this thing. might make a good plush toy for engineers
	name = "Мультитул"
	desc = "Многофункциональный инструмент"

	nominative = "мультитул"
	genitive = "мультитула"
	dative = "мультитулу"
	accusative = "мультитул"
	instrumentative = "мультитулом"
	prepositive = "мультитуле"

	icon_state = "multitool"
	flags = FPRINT | TABLEPASS| CONDUCT
	force = 5.0
	w_class = 2.0
	throwforce = 5.0
	throw_range = 15
	throw_speed = 3
	m_amt = 50
	g_amt = 20

// So far, its functionality is found only in code/game/machinery/doors/airlock.dm
/obj/item/device/hacktool //same - get rid of this one
	name = "Хактул"
	desc = "Предмет сомнительного происхождения, из него торчат провода и антенны."

	nominative = "хактул"
	genitive = "хактула"
	dative = "хактулу"
	accusative = "хактул"
	instrumentative = "хактулом"
	prepositive = "хактуле"

	icon_state = "hacktool"
	flags = FPRINT | TABLEPASS | CONDUCT
	var/in_use = 0
	force = 5.0
	w_class = 2.0
	throwforce = 5.0
	throw_range = 15
	throw_speed = 3
	m_amt = 60
	g_amt = 20

/obj/item/device/prox_sensor
	name = "Датчик приближения"

	nominative = "датчик приближения"
	genitive = "датчика приближения"
	dative = "датчику приближения"
	accusative = "датчик приближения"
	instrumentative = "датчиком приближения"
	prepositive = "датчике приближения"

	icon_state = "motion0"
	var/state = 0.0
	var/timing = 0.0
	var/time = null
	flags = FPRINT | TABLEPASS| CONDUCT
	w_class = 2.0
	item_state = "electronic"
	m_amt = 300


/obj/item/device/timer
	name = "Таймер"

	nominative = "таймер"
	genitive = "таймера"
	dative = "таймеру"
	accusative = "таймер"
	instrumentative = "таймером"
	prepositive = "таймере"

	icon_state = "timer0"
	item_state = "electronic"
	var/timing = 0.0
	var/time = null
	flags = FPRINT | TABLEPASS| CONDUCT
	w_class = 2.0
	m_amt = 100


/obj/landmark
	name = "landmark"
	icon = 'screen1.dmi'
	icon_state = "x2"
	anchored = 1.0




/*/obj/landmark/ptarget
	name = "portal target"
	icon = 'screen1.dmi'
	icon_state = "x2"
	anchored = 1.0
	var/t_id*/

/obj/landmark/derelict
	name = "Derelict Info Node"

	nodamage
		icon_state = "blocked"

	noblast
		icon_state = "blocked"

	o2crate
	o2canister
	metal
	glass


/obj/landmark/alterations
	name = "alterations"
	nopath
		invisibility = 101
		name = "Bot No-Path"

/obj/laser
	name = "Лазер"

	nominative = "лазер"
	genitive = "лазера"
	dative = "лазеру"
	accusative = "лазер"
	instrumentative = "лазером"
	prepositive = "лазере"

	icon = 'projectiles.dmi'
	var/damage = 0.0
	var/range = 10.0

/obj/lattice
	desc = "Легкая опорная решетка."
	name = "Решётка"

	nominative = "решётка"
	genitive = "решётки"
	dative = "решётке"
	accusative = "решётку"
	instrumentative = "решёткой"
	prepositive = "решётке"

	icon = 'structures.dmi'
	icon_state = "lattice"
	density = 0
	anchored = 1.0
	layer = 2
	//	flags = 64.0

/obj/list_container
	name = "list container"

/obj/list_container/mobl
	name = "mobl"
	var/master = null

	var/list/container = list(  )

/obj/m_tray
	name = "Погребальный поднос"

	nominative = "погребальный поднос"
	genitive = "погребального подноса"
	dative = "погребальному подносу"
	accusative = "погребальный поднос"
	instrumentative = "погребальным подносом"
	prepositive = "погребальном подносе"

	icon = 'stationobjs.dmi'
	icon_state = "morguet"
	density = 1
	layer = 2.0
	var/obj/morgue/connected = null
	anchored = 1.0

/obj/c_tray
	name = "Крематорный поднос"

	nominative = "крематорный поднос"
	genitive = "крематорного подноса"
	dative = "крематорному подносу"
	accusative = "крематорный поднос"
	instrumentative = "крематорным подносом"
	prepositive = "крематорном подносе"

	icon = 'stationobjs.dmi'
	icon_state = "cremat"
	density = 1
	layer = 2.0
	var/obj/crematorium/connected = null
	anchored = 1.0

/obj/manifest
	name = "manifest"
	icon = 'screen1.dmi'
	icon_state = "x"

/obj/morgue
	name = "Камера морга"

	nominative = "крематорный поднос"
	genitive = "крематорного подноса"
	dative = "крематорному подносу"
	accusative = "крематорный поднос"
	instrumentative = "крематорным подносом"
	prepositive = "крематорном подносе"

	icon = 'stationobjs.dmi'
	icon_state = "morgue1"
	density = 1
	var/obj/m_tray/connected = null
	anchored = 1.0

/obj/crematorium
	name = "Камера крематория"

	nominative = "камера крематория"
	genitive = "камеры крематория"
	dative = "камере крематория"
	accusative = "камеру крематория"
	instrumentative = "камерой крематория"
	prepositive = "камере крематория"

	icon = 'stationobjs.dmi'
	icon_state = "crema1"
	density = 1
	var/obj/c_tray/connected = null
	anchored = 1.0
	var/cremating = 0
	var/id = 1
	var/locked = 0

/obj/mine
	name = "Мина"
	desc = "Что будет, если наступить?"

	nominative = "мина"
	genitive = "мины"
	dative = "мине"
	accusative = "мину"
	instrumentative = "миной"
	prepositive = "мине"

	density = 1
	anchored = 1
	layer = 3
	icon = 'weapons.dmi'
	icon_state = "uglymine"
	var/triggerproc = "explode" //name of the proc thats called when the mine is triggered
	var/triggered = 0

/*/obj/mine/dnascramble
	name = "Radiation Mine"
	icon_state = "uglymine"
	triggerproc = "triggerrad"

	nominative = "мина"
	genitive = "мины"
	dative = "мине"
	accusative = "мину"
	instrumentative = "миной"
	prepositive = "мине"

/obj/mine/plasma
	name = "Plasma Mine"
	icon_state = "uglymine"
	triggerproc = "triggerplasma"

	nominative = "мина"
	genitive = "мины"
	dative = "мине"
	accusative = "мину"
	instrumentative = "миной"
	prepositive = "мине"

/obj/mine/kick
	name = "Kick Mine"
	icon_state = "uglymine"
	triggerproc = "triggerkick"

	nominative = "мина"
	genitive = "мины"
	dative = "мине"
	accusative = "мину"
	instrumentative = "миной"
	prepositive = "мине"

/obj/mine/n2o
	name = "N2O Mine"
	icon_state = "uglymine"
	triggerproc = "triggern2o"

/obj/mine/stun
	name = "Stun Mine"
	icon_state = "uglymine"
	triggerproc = "triggerstun"

	nominative = "мина"
	genitive = "мины"
	dative = "мине"
	accusative = "мину"
	instrumentative = "миной"
	prepositive = "мине"*/

/obj/overlay
	name = "overlays"

/obj/projection
	name = "Projection"
	anchored = 1.0

/obj/rack
	name = "Стойка"

	nominative = "стойка"
	genitive = "стойки"
	dative = "стойке"
	accusative = "стойку"
	instrumentative = "стойкой"
	prepositive = "стойке"

	icon = 'objects.dmi'
	icon_state = "rack"
	density = 1
	flags = FPRINT
	anchored = 1.0

/obj/screen
	name = "Экран"

	nominative = "экран"
	genitive = "экрана"
	dative = "экрану"
	accusative = "экран"
	instrumentative = "экраном"
	prepositive = "экране"

	icon = 'screen1.dmi'
	layer = 20.0
	var/id = 0.0
	var/obj/master

/obj/screen/close
	name = "close"
	master = null

/obj/screen/grab
	name = "grab"
	master = null

/obj/screen/storage
	name = "storage"
	master = null

/obj/screen/zone_sel
	name = "Damage Zone"
	icon = 'zone_sel.dmi'
	icon_state = "blank"
	var/selecting = "chest"
	screen_loc = "EAST+1,NORTH"

/obj/shut_controller
	name = "shut controller"
	var/moving = null
	var/list/parts = list(  )

/obj/landmark/start
	name = "start"
	icon = 'screen1.dmi'
	icon_state = "x"
	anchored = 1.0

/obj/stool
	name = "Стул"

	nominative = "стул"
	genitive = "стула"
	dative = "стулу"
	accusative = "стул"
	instrumentative = "стулом"
	prepositive = "стуле"

	icon = 'objects.dmi'
	icon_state = "stool"
	flags = FPRINT
	anchored = 1.0
	pressure_resistance = 3*ONE_ATMOSPHERE

/obj/stool/barstool
	name = "Барный стул"

	nominative = "барный стул"
	genitive = "барного стула"
	dative = "барному стулу"
	accusative = "барный стул"
	instrumentative = "барным стулом"
	prepositive = "барном стуле"

	icon_state = "barstool"

/obj/stool/bed
	name = "Кровать"

	nominative = "кровать"
	genitive = "кровати"
	dative = "кровати"
	accusative = "кровать"
	instrumentative = "кроватью"
	prepositive = "кровати"

	icon_state = "bed"
	var/list/buckled_mobs = list(  )

/obj/stool/chair
	name = "Стул"

	nominative = "стул"
	genitive = "стула"
	dative = "стулу"
	accusative = "стул"
	instrumentative = "стулом"
	prepositive = "стуле"

	icon_state = "chair"
	var/status = 0.0
	var/list/buckled_mobs = list(  )

/obj/stool/chair/e_chair
	name = "Электрический стул"
	desc = "Страшный сон несправедливо приговоренного."

	nominative = "электрический стул"
	genitive = "электрического стула"
	dative = "электрическому стулу"
	accusative = "электрический стул"
	instrumentative = "электрическим стулом"
	prepositive = "электрическом стуле"

	icon_state = "e_chair0"
	var/atom/movable/overlay/overl = null
	var/on = 0.0
	var/obj/item/assembly/shock_kit/part1 = null
	var/last_time = 1.0

/obj/stool/chair/comfy
	name = "Кресло"

	nominative = "кресло"
	genitive = "кресла"
	dative = "креслу"
	accusative = "кресло"
	instrumentative = "креслом"
	prepositive = "кресле"

/obj/stool/chair/comfy/brown
	icon_state = "comfychair_brown"

/obj/stool/chair/comfy/beige
	icon_state = "comfychair_beige"

/obj/stool/chair/comfy/teal
	icon_state = "comfychair_teal"

/obj/stool/chair/comfy/black
	icon_state = "comfychair_black"

/obj/stool/chair/comfy/lime
	icon_state = "comfychair_lime"

/obj/table
	name = "Стол"

	nominative = "стол"
	genitive = "стола"
	dative = "столу"
	accusative = "стол"
	instrumentative = "столом"
	prepositive = "столе"

	icon = 'structures.dmi'
	icon_state = "table"
	density = 1
	anchored = 1.0

/obj/table/reinforced
	name = "Усиленный стол"

	nominative = "усиленный стол"
	genitive = "усиленного стола"
	dative = "усиленному столу"
	accusative = "усиленный стол"
	instrumentative = "усиленным столом"
	prepositive = "усиленном столе"

	icon_state = "reinf_table"
	var/status = 2

/obj/table/woodentable //make it burnable
	name = "деревянный стол"
	icon_state = "woodentable"

	nominative = "деревянный стол"
	genitive = "деревянного стола"
	dative = "деревянному столу"
	accusative = "деревянный стол"
	instrumentative = "деревянным столом"
	prepositive = "деревянном столе"

/obj/mopbucket
	name = "Ведро на колёсиках"
	desc = "Лучший друг уборщиков нашего времени."

	nominative = "ведро на колёсиках"
	genitive = "ведра на колёсиках"
	dative = "ведру на колёсиках"
	accusative = "ведро на колёсиках"
	instrumentative = "ведром на колёсиках"
	prepositive = "ведре на колёсиках"

	icon = 'janitor.dmi'
	icon_state = "mopbucket"
	density = 1
	flags = FPRINT
	pressure_resistance = ONE_ATMOSPHERE
	flags = FPRINT | OPENCONTAINER //removed TABLEPASS

/obj/kitchenspike
	name = "Свежеватель"

	nominative = "свежеватель"
	genitive = "свежевателя"
	dative = "свежевателю"
	accusative = "свежеватель"
	instrumentative = "свежевателем"
	prepositive = "свежевателе"

	icon = 'kitchen.dmi'
	icon_state = "spike"
	desc = "Для дальнейшей разделки туш."
	density = 1
	anchored = 1
	var/meat = 0
	var/occupied = 0

/obj/displaycase
	name = "Витрина"
	icon = 'stationobjs.dmi'
	icon_state = "glassbox1"

	nominative = "витрина"
	genitive = "витрины"
	dative = "витрине"
	accusative = "витрину"
	instrumentative = "витриной"
	prepositive = "витрине"

	density = 1
	anchored = 1
	var/health = 30
	var/occupied = 1
	var/destroyed = 0

obj/item/brain
	name = "Мозг"

	nominative = "мозг"
	genitive = "мозга"
	dative = "мозгу"
	accusative = "мозг"
	instrumentative = "мозгом"
	prepositive = "мозге"

	icon = 'surgery.dmi'
	icon_state = "brain2"
	flags = TABLEPASS
	force = 1.0
	w_class = 1.0
	throwforce = 1.0
	throw_speed = 3
	throw_range = 5

	var/mob/living/carbon/human/owner = null

/obj/item/brain/New()
	..()
	spawn(5)
		if(src.owner)
			//src.name = "Мозг [src.owner]"
			src.name = "Мозг"
			src.desc = "Сходу сложно сказать, чей это мозг. Чей-то да был."

/obj/noticeboard
	name = "Доска объявлений"

	nominative = "доска объявлений"
	genitive = "доски объявлений"
	dative = "доске объявлений"
	accusative = "доску объявлений"
	instrumentative = "доской объявлений"
	prepositive = "доске объявлений"

	icon = 'stationobjs.dmi'
	icon_state = "nboard00"
	flags = FPRINT
	desc = "Доска для размещения разнообразных объявлений - важных и не только."
	density = 0
	anchored = 1
	var/notices = 0

/*/obj/deskclutter //trash
	name = "desk clutter"
	icon = 'items.dmi'
	icon_state = "deskclutter"
	desc = "Some clutter that has accumalated over the years..."
	anchored = 1*/



/obj/item/mouse_drag_pointer = MOUSE_ACTIVE_POINTER


/obj/item/weapon/ore
	name = "Камень"

	nominative = "камень"
	genitive = "камня"
	dative = "камню"
	accusative = "камень"
	instrumentative = "камнем"
	prepositive = "камне"

	icon = 'rubble.dmi'
	icon_state = "ore"
	var/amt = 1
	var/cook = 0
	var/cook_temp = 1000
	var/cook_time = 30