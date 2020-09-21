/mob/living/carbon/human/ork/nob
	name = "Ork Nob"
	icon = 'icons/mob/ork.dmi'
	caste = "s"
	maxHealth = 300
	health = 300
	storedwaagh = 300
	max_waagh = 500
	icon_state = "ork"
	waagh_rate = 10
	base_icon_state = "ork"


/mob/living/carbon/human/ork/nob/New()
	create_reagents(100)
	equip_to_slot_or_del(new /obj/item/clothing/shoes/ork, slot_shoes)
	equip_to_slot_or_del(new /obj/item/clothing/under/rank/ork/under, slot_w_uniform)
	equip_to_slot_or_del(new /obj/item/clothing/gloves/ork, slot_gloves)
	equip_to_slot_or_del(new /obj/item/clothing/head/soft/orkhat, slot_head)
	equip_to_slot_or_del(new /obj/item/device/flashlight/orklite, slot_r_store)
	if(name == "ork nob")
		name = text("ork nob ([rand(1, 1000)])")
	real_name = name
	verbs.Add(/mob/living/carbon/human/ork/nob/verb/waagh, /mob/living/carbon/human/ork/nob/verb/nobscav)
	..()

/mob/living/carbon/human/ork/nob/handle_regular_hud_updates()
	..() //-Yvarov

	if (healths)
		if (stat != 2)
			switch(health)
				if(125 to INFINITY)
					healths.icon_state = "health0"
				if(100 to 125)
					healths.icon_state = "health1"
				if(75 to 100)
					healths.icon_state = "health2"
				if(25 to 75)
					healths.icon_state = "health3"
				if(0 to 25)
					healths.icon_state = "health4"
				else
					healths.icon_state = "health5"
		else
			healths.icon_state = "health6"

/mob/living/carbon/human/ork/nob/movement_delay()
	. = ..()
	. += 1

/mob/living/carbon/human/ork/nob/verb/evolve()
	set name = "Evolve (500)"
	set desc = "Maybe now you DA boss?!?!?."
	set category = "Ork"

	if(powerc(500))
		// Queen check
		var/no_warboss = 1
		for(var/mob/living/carbon/human/ork/warboss/Q in living_mob_list)
			if(!Q.key || !Q.getorgan(/obj/item/organ/brain))
				continue
			no_warboss = 0

		if(no_warboss)
			adjustToxLoss(-500)
			src << "\green HA! NOW YOU DA BOSS!!"
			for(var/mob/O in viewers(src, null))
				O.show_message(text("\green <B>[src] IS NOW DA BOSS! YOU LISTEN TO HIM!</B>"), 1)
			var/mob/living/carbon/human/ork/warboss/new_xeno = new (loc)
			mind.transfer_to(new_xeno)
			for(var/obj/item/W in src) //Lets not delete everything... This is a lot easier than re-equipping it on the new mob though.
				src.unEquip(W)
			qdel(src)
		else
			src << "<span class='notice'>I don't think tha boss will like that.</span>"
	return