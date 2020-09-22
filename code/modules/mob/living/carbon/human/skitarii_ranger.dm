 //very big WIP testing ideas with
/mob/living/carbon/human/skitarii_ranger
	name = "Unknown"
	real_name = "Unknown"
	universal_speak = 1
	gender = "male"
	maxHealth = 150
	health = 150
	status_flags = 0
	factions = list("imperium")//new

/mob/living/carbon/human/skitarii_ranger/New()
	..()
	immunetofire = 1
	sleep (5)
	var/obj/item/device/radio/headset/R = new /obj/item/device/radio/headset/headset_eng
	R.set_frequency(1459)
	equip_to_slot_or_del(R, slot_ears)

	var/rndname = "Sy-Gex([rand(123, 789)])"

	name = "[rndname]"
	real_name = "[rndname]"

/mob/living/carbon/human/skitarii_ranger/Life()
	..()
	if(iscarbon(src))
		var/mob/living/carbon/C = src
		C.handcuffed = initial(C.handcuffed)
		icon = 'icons/mob/skitarii.dmi'
		icon_state = "skitarii-ranger"

