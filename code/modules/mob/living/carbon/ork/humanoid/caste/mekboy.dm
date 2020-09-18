/mob/living/carbon/human/ork/mekboy
	name = "Ork Mekboy"
	caste = "m"
	maxHealth = 200
	health = 200
	icon = 'icons/mob/ork.dmi'
	base_icon_state = "ork2"
	icon_state = "ork2"
	storedwaagh = 500
	max_waagh = 500


/mob/living/carbon/human/ork/oddboy/New()
	create_reagents(100)
	equip_to_slot_or_del(new /obj/item/clothing/shoes/ork, slot_shoes)
	equip_to_slot_or_del(new /obj/item/clothing/under/rank/ork/under, slot_w_uniform)
	equip_to_slot_or_del(new /obj/item/clothing/gloves/ork, slot_gloves)
	equip_to_slot_or_del(new /obj/item/clothing/head/soft/orkhat, slot_head)
	equip_to_slot_or_del(new /obj/item/device/flashlight/orklite, slot_r_store)
	src.name = text("Ork Mekboy ([rand(1, 1000)])")
	src.real_name = src.name
	verbs.Add(/mob/living/carbon/human/ork/oddboy/verb/waagh,/mob/living/carbon/human/ork/nob/verb/oddscav)
	..()

/mob/living/carbon/human/ork/oddboy/movement_delay()
	. = ..()
	. += 1
