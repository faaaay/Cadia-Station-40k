
/*
UltraMarines
*/

/mob/living/carbon/human/whitelisted/um/leader
	name = "Captain Helis Dallicus"
	real_name = "Captain Helis Dallicus"
	universal_speak = 1
	gender = "male"
	health = 250
	status_flags = 0
	factions = list("imperium")

/mob/living/carbon/human/whitelisted/um/leader/New()
	..()

	var/obj/item/device/radio/headset/R = new /obj/item/device/radio/headset/headset_cent
	R.set_frequency(1441)
	equip_to_slot_or_del(R, slot_ears)
	qdel(src.wear_suit) //Get rid of normal marine armor for this to even work.
	qdel(src.shoes)
	equip_to_slot_or_del(new /obj/item/clothing/glasses/night, slot_glasses)
	equip_to_slot_or_del(new /obj/item/clothing/suit/armor/umpowerarmor/captain, slot_wear_suit)
	equip_to_slot_or_del(new /obj/item/clothing/shoes/magboots/um/captain, slot_shoes)
	equip_to_slot_or_del(new /obj/item/clothing/mask/breath/marine, slot_wear_mask)
	equip_to_slot_or_del(new /obj/item/clothing/head/helmet/umpowerhelmet/captain, slot_head)
	equip_to_slot_or_del(new /obj/item/weapon/tank/oxygen/umback, slot_back)
	equip_to_slot_or_del(new /obj/item/weapon/gun/projectile/sbolter, slot_r_hand)



/mob/living/carbon/human/whitelisted/um/leader/CanPass(atom/A, mob/target)
	if(istype(A) && A.pass_flags == PASSULTRA)
		return 1
	if(istype(src) && src.density == 0)
		return prob(99)
	else
		return prob(2)

/mob/living/carbon/human/whitelisted/um/leader/Life()
	..()
	if(iscarbon(src))
		var/mob/living/carbon/C = src
		C.handcuffed = initial(C.handcuffed)
		if(C.reagents)
			for(var/datum/reagent/R in C.reagents.reagent_list)
				//C.reagents.clear_reagents()
				C.reagents.remove_all_type(/datum/reagent/toxin, 1*REM, 0, 2)
				C.adjustToxLoss(-2)
	for(var/datum/disease/D in viruses)
		D.cure(0)


/mob/living/carbon/human/whitelisted/um
	name = "Unknown"
	real_name = "Unknown"
	universal_speak = 1
	gender = "male"
	maxHealth = 250
	health = 250
	status_flags = 0
	factions = list("imperium")//new

/mob/living/carbon/human/whitelisted/um/CanPass(atom/A, mob/target)
	if(istype(A) && A.pass_flags == PASSULTRA)
		return 1
	if(istype(src) && src.density == 0)
		return prob(99)
	else
		return prob(2)

/mob/living/carbon/human/whitelisted/um/New()
	..()
	var/obj/item/device/radio/headset/R = new /obj/item/device/radio/headset/headset_cent
	R.set_frequency(1441)
	equip_to_slot_or_del(R, slot_ears)
	var/namelist = list ("Roman", "Tias", "Tiberias", "Lukas", "Sabius", "Augustus", "Crasius", "Gabriel", "Achilles", "Benedictus", "Cadmus", "Cephas", "Diodorus", "Erastus", "Drusus", "Fabius", "Ferox", "Marcus")
	var/rndname = pick(namelist)

	name = "Brother [rndname]"
	real_name = "Brother [rndname]"
	equip_to_slot_or_del(new /obj/item/clothing/under/color/black, slot_w_uniform)
	equip_to_slot_or_del(new /obj/item/clothing/glasses/night, slot_glasses)
	equip_to_slot_or_del(new /obj/item/clothing/suit/armor/umpowerarmor, slot_wear_suit)
	equip_to_slot_or_del(new /obj/item/clothing/shoes/magboots/um, slot_shoes)
	equip_to_slot_or_del(new /obj/item/clothing/gloves/um, slot_gloves)
	equip_to_slot_or_del(new /obj/item/weapon/tank/oxygen/umback, slot_back)
	equip_to_slot_or_del(new /obj/item/clothing/mask/breath/marine, slot_wear_mask)
	var/obj/item/weapon/card/id/W = new
	W.icon_state = "umcard"
	W.access = get_all_accesses()
	W.access += get_centcom_access("UltraMarine")
	W.assignment = "Tactical UltraMarine"
	W.registered_name = real_name
	W.update_label()
	equip_to_slot_or_del(W, slot_wear_id)
	spawn(20)
		var/loadoutweapon = input("Loadout.","Choose your Primary weapon!") as null|anything in list("Bolter", "Plasma gun", "Las-Cannon")
		switch(loadoutweapon)
			if("Bolter")
				equip_to_slot_or_del(new /obj/item/ammo_box/magazine/boltermag, slot_r_store)
				equip_to_slot_or_del(new /obj/item/ammo_box/magazine/boltermag, slot_l_store)
				equip_to_slot_or_del(new /obj/item/weapon/gun/projectile/automatic/bolter, slot_s_store)
				sleep(10)
				regenerate_icons()
				rename_self("[name]")

			if("Plasma Gun")
				equip_to_slot_or_del(new /obj/item/weapon/gun/energy/plasma/rifle, slot_s_store)
				sleep(10)
				regenerate_icons()
				rename_self("[name]")

			if("Las-Cannon")
				equip_to_slot_or_del(new /obj/item/weapon/gun/projectile/automatic/lascannon, slot_l_hand)
				equip_to_slot_or_del(new /obj/item/ammo_box/magazine/lascannonmag, slot_r_store)
				equip_to_slot_or_del(new /obj/item/ammo_box/magazine/lascannonmag, slot_l_store)
				sleep(10)
				regenerate_icons()
				rename_self("[name]")
	spawn(20)
		var/loadoutsecond = input("Loadout.","Choose your Secondary weapon!") as null|anything in list("Chainsword", "Powerknife", "Plasma Pistol")
		switch(loadoutsecond)
			if("Chainsword")
				equip_to_slot_or_del(new /obj/item/weapon/chainsword/ultramarine_chainsword, slot_belt)
				regenerate_icons()

			if("Powerknife")
				equip_to_slot_or_del(new /obj/item/weapon/powersword/pknife, slot_belt)
				regenerate_icons()

			if("Plasma Pistol")
				equip_to_slot_or_del(new /obj/item/weapon/gun/energy/plasma/pistol, slot_belt)
				regenerate_icons()

	spawn(20)
		var/loadouthelmet = input("Loadout.","Choose your helmet!") as null|anything in list("Tactical", "Devastator", "Veteran", "For tah emparah")
		switch(loadouthelmet)
			if("Tactical")
				equip_to_slot_or_del(new /obj/item/clothing/head/helmet/umpowerhelmet, slot_head)
				equip_to_slot_or_del(new /obj/item/clothing/glasses/night, slot_glasses)
				regenerate_icons()

			if("Devastator")
				equip_to_slot_or_del(new /obj/item/clothing/head/helmet/umpowerhelmet/devastator, slot_head)
				equip_to_slot_or_del(new /obj/item/clothing/glasses/night, slot_glasses)
				regenerate_icons()

			if("Veteran")
				equip_to_slot_or_del(new /obj/item/clothing/head/helmet/umpowerhelmet/vet, slot_head)
				equip_to_slot_or_del(new /obj/item/clothing/glasses/night, slot_glasses)
				regenerate_icons()

			if("For tah emparah")
				qdel(src.head)
											//this is a new experimental choose your own loadout build
	/*spawn(20)
				var/obj/item/weapon/card/id/W = new
				W.icon_state = "umcard"
				W.access = get_all_accesses()
				W.access += get_centcom_access("UltraMarine")
				W.assignment = "Tactical UltraMarine"
				W.registered_name = real_name
				W.update_label()
				equip_to_slot_or_del(W, slot_wear_id)
				sleep(10)
				regenerate_icons()
				rename_self("[name]") *///if needed we can review old gits and get old system back 

/mob/living/carbon/human/whitelisted/um/Life()
	..()
	if(iscarbon(src))
		var/mob/living/carbon/C = src
		C.handcuffed = initial(C.handcuffed)
		if(C.reagents)
			C.reagents.remove_all_type(/datum/reagent/toxin, 1*REM, 0, 2)
			C.adjustToxLoss(-2)
			/*
			for(var/datum/reagent/R in C.reagents.reagent_list)
				C.reagents.clear_reagents()
			*/
	for(var/datum/disease/D in viruses)
		if(!istype(D, /datum/disease/plague)) //...this one can infect marines.
			D.cure(0)