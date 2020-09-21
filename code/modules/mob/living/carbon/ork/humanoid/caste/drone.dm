/mob/living/carbon/human/ork/oddboy
	name = "Ork Mekboy"
	caste = "d"
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
	src.name = text("Ork Oddboy ([rand(1, 1000)])")
	src.real_name = src.name
	verbs.Add(/mob/living/carbon/human/ork/oddboy/verb/waagh,/mob/living/carbon/human/ork/nob/verb/oddscav)
	..()

/mob/living/carbon/human/ork/oddboy/movement_delay()
	. = ..()
	. += 1

/mob/living/carbon/human/ork/verb/plantt()
	set name = "Da Waaaagh banna! (100)"
	set desc = "Plants some ork weeds"
	set category = "Ork"

	if(powerc(100))
		adjustToxLoss(-100)
		for(var/mob/O in viewers(src, null))
			O.show_message(text("\green <B>If it's a Waaagh [src] wants, it's a WAAAAAGH he'll get!</B>"), 1)
		new /obj/structure/human/ork/waagh/node(loc)
		playsound(loc, 'sound/voice/workwork.ogg', 75, 0)
	return

//for mekboys
/mob/living/carbon/human/ork/proc/buildit()
	set name = "Build Stuff (75)"
	set desc = "Time to build stuff!"
	set category = "Ork"

	if(powerc(75))
		var/choice = input("Choose what you wish to build.","Construct building") as null|anything in list("Door","Wall","Window","Pile-o-guns") //would do it through typesof but then the player choice would have the type path and we don't want the internal workings to be exposed ICly - Urist
		if(!choice || !powerc(75))	return
		adjustToxLoss(-75)
		src << "\green You construct a [choice]."
		for(var/mob/O in viewers(src, null))
			O.show_message(text("\red <B>[src] starts building something!</B>"), 1)
		switch(choice)
			if("Door")
				new /obj/structure/mineral_door/ork(loc)
			if("Wall")
				new /obj/structure/human/ork/construction/wall(loc)
			if("Window")
				new /obj/structure/human/ork/construction/window(loc)
			if("Pile-o-guns")
				var/announce = pick('sound/voice/gretpilo.ogg','sound/voice/gretpilo2.ogg')
				playsound(loc, announce, 75, 0)
				makegunpile()

	return

/mob/living/carbon/human/ork/proc/makegunpilee(mob/user as mob)
	new /obj/structure/closet/ork/piloguns(src.loc)