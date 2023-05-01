/obj/decal/ash
	name = "Прах"

	nominative = "прах"
	genitive = "праха"
	dative = "праху"
	accusative = "прах"
	instrumentative = "прахом"
	prepositive = "прахе"

	desc = "Земля к земле, пепел к пеплу, прах к праху..."
	icon = 'objects.dmi'
	icon_state = "ash"
	anchored = 1

/obj/decal/point
	name = "Цель"

	nominative = "цель"
	genitive = "цели"
	dative = "цели"
	accusative = "цель"
	instrumentative = "целью"
	prepositive = "цели"

	icon = 'screen1.dmi'
	icon_state = "arrow"
	layer = 16.0
	anchored = 1

/obj/decal/cleanable
	var/list/random_icon_states = list()

/obj/decal/cleanable/blood
	name = "Кровь"

	nominative = "кровь"
	genitive = "крови"
	dative = "крови"
	accusative = "кровь"
	instrumentative = "кровью"
	prepositive = "крови"

	//desc = "It's red."
	density = 0
	anchored = 1
	layer = 2
	icon = 'blood.dmi'
	icon_state = "floor1"
	random_icon_states = list("floor1", "floor2", "floor3", "floor4", "floor5", "floor6", "floor7")
	var/datum/disease/virus = null
	var/datum/disease2/virus2 = null
	blood_DNA = null
	blood_type = null
	var/mob/blood_owner = null

/obj/decal/cleanable/blood/drip
	name = "Капля крови"

	nominative = "капля крови"
	genitive = "капли крови"
	dative = "капле крови"
	accusative = "каплю крови"
	instrumentative = "каплей крови"
	prepositive = "капле крови"

	//desc = "It's red."
	density = 0
	anchored = 1
	layer = 2
	icon = 'drip.dmi'
	icon_state = "1"
	blood_DNA = null
	blood_type = null
/obj/decal/cleanable/blood/splatter
	random_icon_states = list("gibbl1", "gibbl2", "gibbl3", "gibbl4", "gibbl5")

/obj/decal/cleanable/blood/tracks
	icon_state = "tracks"
	random_icon_states = null

/obj/decal/cleanable/blood/gibs //remove limbs etc. Should be purely blood
	//name = "Останки"

	/*nominative = "останки"
	genitive = "останки"
	dative = "останкам"
	accusative = "останки"
	instrumentative = "останками"
	prepositive = "останках"*/

	//desc = "Grisly..."
	density = 0
	anchored = 0
	layer = 2
	icon = 'blood.dmi'
	icon_state = "gibbl5"
	random_icon_states = list("gib1", "gib2", "gib3", "gib4", "gib5", "gib6")

/obj/decal/cleanable/blood/gibs/body
	random_icon_states = list("gibhead", "gibtorso")

/obj/decal/cleanable/blood/gibs/limb
	random_icon_states = list("gibleg", "gibarm")

/obj/decal/cleanable/blood/gibs/core
	random_icon_states = list("gibmid1", "gibmid2", "gibmid3")

/obj/decal/cleanable/robot_debris
	name = "Механические останки"

	nominative = "механические останки"
	genitive = "механических останков"
	dative = "механическим останкам"
	accusative = "механические останки"
	instrumentative = "механическими останками"
	prepositive = "механических останках"

	//desc = "Useless heap of junk."
	density = 0
	anchored = 0
	layer = 2
	icon = 'robots.dmi'
	icon_state = "gib1"
	random_icon_states = list("gib1", "gib2", "gib3", "gib4", "gib5", "gib6", "gib7")

/obj/decal/cleanable/robot_debris/limb
	random_icon_states = list("gibarm", "gibleg")

/obj/decal/cleanable/oil
	name = "Машинное масло"

	nominative = "машинное масло"
	genitive = "машинного масла"
	dative = "машинному маслу"
	accusative = "машинное масло"
	instrumentative = "машинным маслом"
	prepositive = "машинном масле"

	//desc = "It's black."
	density = 0
	anchored = 1
	layer = 2
	icon = 'oil.dmi'
	icon_state = "floor1"
	var/datum/disease/virus = null
	random_icon_states = list("floor1", "floor2", "floor3", "floor4", "floor5", "floor6", "floor7")

/obj/decal/cleanable/oil/streak
	random_icon_states = list("streak1", "streak2", "streak3", "streak4", "streak5")

/obj/decal/cleanable/generic
	name = "мусор"

	nominative = "мусор"
	genitive = "мусора"
	dative = "мусору"
	accusative = "мусор"
	instrumentative = "мусором"
	prepositive = "мусоре"

	//desc = "Someone should clean that up."
	density = 0
	anchored = 1
	layer = 2
	icon = 'objects.dmi'
	icon_state = "shards"

/obj/decal/cleanable/dirt
	name = "грязь"

	nominative = "грязь"
	genitive = "грязи"
	dative = "грязи"
	accusative = "грязь"
	instrumentative = "грязью"
	prepositive = "грязи"

	//desc = "Someone should clean that up."
	density = 0
	anchored = 1
	layer = 2
	icon = 'old_or_unused.dmi'
	icon_state = "dirt"

/obj/decal/cleanable/greenglow
	name = "Зеленая лужа"

	nominative = "зеленая лужа"
	genitive = "зеленой лужи"
	dative = "зеленой луже"
	accusative = "зеленую лужу"
	instrumentative = "зеленой лужей"
	prepositive = "зеленой луже"

	//desc = "Eerie."
	density = 0
	anchored = 1
	layer = 2
	icon = 'effects.dmi'
	icon_state = "greenglow"

/obj/decal/cleanable/cobweb
	name = "Паутина"

	nominative = "паутина"
	genitive = "паутины"
	dative = "паутине"
	accusative = "паутину"
	instrumentative = "паутиной"
	prepositive = "паутине"

	//desc = "Someone should remove that."
	density = 0
	anchored = 1
	layer = 3
	icon = 'old_or_unused.dmi'
	icon_state = "cobweb1"

/obj/decal/cleanable/molten_item
	name = "Серая масса"

	nominative = "серая масса"
	genitive = "серой массы"
	dative = "серой массе"
	accusative = "серую массу"
	instrumentative = "серой массой"
	prepositive = "серой массе"

	//desc = "huh."
	density = 0
	anchored = 1
	layer = 3
	icon = 'chemical.dmi'
	icon_state = "molten"

/obj/decal/cleanable/cobweb2
	name = "Паутина"

	nominative = "паутина"
	genitive = "паутины"
	dative = "паутине"
	accusative = "паутину"
	instrumentative = "паутиной"
	prepositive = "паутине"

	//desc = "Someone should remove that."
	density = 0
	anchored = 1
	layer = 3
	icon = 'old_or_unused.dmi'
	icon_state = "cobweb2"
/obj/decal/cleanable/water
	name = "Водяная лужа"

	nominative = "водяная лужа"
	genitive = "водяной лужи"
	dative = "водяной луже"
	accusative = "водяную лужу"
	instrumentative = "водяной лужей"
	prepositive = "водяной луже"

	//desc = "Someone could get hurt that."
	density = 0
	anchored = 1
	layer = 3
	icon = 'water.dmi'
	icon_state = "floor1"
	random_icon_states = list("floor1", "floor2")
/obj/decal/sign
	icon = 'decals.dmi'
	anchored = 1.0
	opacity = 0
	density = 0

/obj/decal/sign/bio
	//desc = "A warning sign which reads 'BIO HAZARD'"
	name = "БИОЛОГИЧЕСКАЯ ОПАСНОСТЬ"
	icon_state = "bio"

/obj/decal/sign/deck1
	//desc = "A silver sign which reads 'DECK I'"
	name = "ПЕРВАЯ ПАЛУБА"
	icon_state = "deck1"

/obj/decal/sign/deck2
	//desc = "A silver sign which reads 'DECK II'"
	name = "ВТОРАЯ ПАЛУБА"
	icon_state = "deck2"

/obj/decal/sign/deck3
	//desc = "A silver sign which reads 'DECK III'"
	name = "ТРЕТЬЯ ПАЛУБА"
	icon_state = "deck3"

/obj/decal/sign/deck4
	//desc = "A silver sign which reads 'DECK IV'"
	name = "ЧЕТВЕРТАЯ ПАЛУБА"
	icon_state = "deck4"

/obj/decal/sign/electrical
	//desc = "A warning sign which reads 'ELECTRICAL HAZARD'"
	name = "ЭЛЕКТРИЧЕСКИЙ ТОК"
	icon_state = "shock"

/obj/decal/sign/flammable
	//desc = "A warning sign which reads 'FLAMMABLE AREA'"
	name = "ОГНЕОПАСНО"
	icon_state = "fire"

/obj/decal/sign/nosmoking
	//desc = "A warning sign which reads 'NO SMOKING'"
	name = "НЕ КУРИТЬ"
	icon_state = "nosmoking"

/obj/decal/sign/securearea
	//desc = "A warning sign which reads 'SECURE AREA'"
	name = "ЗАПРЕТНАЯ ЗОНА"
	icon_state = "securearea"

/obj/decal/sign/space
	//desc = "A warning sign which reads 'SPACE DEPRESSURIZATION'"
	name = "ВЫХОД В ОТКРЫТЫЙ КОСМОС"
	icon_state = "space"

/obj/decal/sign/memetic
	//desc = "A warning sign of memetic danger, which reads 'MEMETIC DANGER, USE MESONS'."
	name = "МЕМЕТИЧЕСКАЯ ОПАСНОСТЬ."
	icon_state = "memetic"

/*/obj/decal/sign/stairsup
	//desc = "A sign which shows an arrow pointing up stairs"
	name = "Stairs Up"
	icon_state = "sup"

/obj/decal/sign/stairsdown
	desc = "A sign which shows an arrow pointing down stairs"
	name = "Stairs Down"
	icon_state = "sdown"

/obj/decal/sign/deck/sub
	desc = "A sign which reads SUB DECK"
	name = "SUB DECK"
	part1
		icon_state = "sub0"
	part2
		icon_state = "sub1"*/

/obj/decal/sign/deck/main
	//desc = "A sign which reads MAIN DECK"
	name = "ОСНОВНАЯ ПАЛУБА"
	part1
		icon_state = "main0"
	part2
		icon_state = "main1"

/obj/decal/sign/deck/enge
	//desc = "A sign which reads ENGINEERING DECK"
	name = "ИНЖЕНЕРНАЯ ПАЛУБА"
	part1
		icon_state = "enge0"
	part2
		icon_state = "enge1"
	part3
		icon_state = "enge2"
	part4
		icon_state = "enge3"

/obj/decal/sign/deck/bridge
	//desc = "A sign which reads BRIDGE DECK"
	name = "МОСТИК"
	part1
		icon_state = "bridge0"
	part2
		icon_state = "bridge1"
	part3
		icon_state = "bridge2"

/obj/decal/sign/barsign
	icon = 'barsigns.dmi'
	icon_state = "empty"
	New()
		ChangeSign(pick("pinkflamingo", "magmasea", "limbo", "rustyaxe", "armokbar", "brokendrum"))
		return
	proc/ChangeSign(var/Text)
		src.icon_state = "[Text]"
		//ul_SetLuminosity(4)
		return

/obj/decal/signnew
	icon = 'decals-new.dmi'
	anchored = 1.0
	opacity = 0
	density = 0

/obj/decal/signnew/biohazard
	name = "БИОЛОГИЧЕСКАЯ ОПАСНОСТЬ"
	//desc = "Warning: Biological and-or toxic hazards present in this area!"
	icon_state = "biohazard"

/obj/decal/signnew/corrosives
	name = "КОРРОЗИВНЫЕ СУБСТАНЦИИ"
	//desc = "Warning: Corrosive substances prezent in this area!"
	icon_state = "corrosives"

/obj/decal/signnew/explosives
	name = "ВЗРЫВООПАСНЫЕ СУБСТАНЦИИ"
	//desc = "Warning: Explosive substances present in this area!"
	icon_state = "explosives"

/obj/decal/signnew/flammables
	name = "ЛЕГКОВОСПЛАМЕНЯЕМЫЕ СУБСТАНЦИИ"
	//desc = "Warning: Flammable substances present in this area!"
	icon_state = "flammable"

/obj/decal/signnew/laserhazard
	name = "ЛАЗЕРНАЯ ОПАСНОСТЬ"
	//desc = "Warning: High powered laser emitters operating in this area!"
	icon_state = "laser"

/obj/decal/signnew/danger
	name = "ОПАСНАЯ ЗОНА"
	//desc = "Warning: Generally hazardous area! Exercise caution."
	icon_state = "danger"

/obj/decal/signnew/magnetics
	name = "ОПАСНОЕ МАГНЕТИЧЕСКОЕ ПОЛЕ"
	//desc = "Warning: Extremely powerful magnetic fields present in this area!"
	icon_state = "magnetics"

/obj/decal/signnew/opticals
	name = "ОПТИЧЕСКАЯ ОПАСНОСТЬ"
	//desc = "Warning: Optical hazards present in this area!"
	icon_state = "optical"

/obj/decal/signnew/radiation
	name = "РАДИАЦИОННАЯ ОПАСНОСТЬ"
	//desc = "Warning: Significant levels of radiation present in this area!"
	icon_state = "radiation"

/obj/decal/signnew/secure
	name = "ЗАПРЕТНАЯ ЗОНА"
	//desc = "Warning: Secure Area! Do not enter without authorization!"
	icon_state = "secure"

/obj/decal/signnew/electrical
	name = "ЭЛЕКТРИЧЕСКАЯ ОПАСНОСТЬg"
	//desc = "Warning: Electrical hazards! Wear protective equipment."
	icon_state = "electrical"

/obj/decal/signnew/cryogenics
	name = "КРИОГЕННЫЕ ТЕМПЕРАТУРЫ"
	//desc = "Warning: Extremely low temperatures in this area."
	icon_state = "cryogenics"

/obj/decal/signnew/canisters
	name = "ГЕРМЕТИЧЕСКИЕ КАНИСТРЫ"
	//desc = "Warning: Highly pressurized canister storage."
	icon_state = "canisters"

/obj/decal/signnew/oxidants
	name = "ОКИСЛИТЕЛЬНЫЕ СУБСТАНЦИИ"
	//desc = "Warning: Oxidizing agents in this area, do not start fires!"
	icon_state = "oxidants"

/obj/decal/signnew/memetic
	name = "МЕМЕТИЧЕСКАЯ ОПАСНОСТЬ"
	d//esc = "Warning: Memetic hazard, wear meson goggles!"
	icon_state = "memetic"
