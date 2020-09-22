/*
Research Director
*/
/datum/job/rd
	title = "Lord Inquisitor, Ordo Xenos"
	flag = RD
	department_head = list("Ordo Xenos")
	department_flag = MEDSCI
	faction = "Station"
	total_positions = 1
	spawn_positions = 1
	supervisors = "The Ordo Xenos"
	selection_color = "#ffddff"
	req_admin_notify = 1
	minimal_player_age = 7

	default_id = /obj/item/weapon/card/id/inquisitor
	default_pda = /obj/item/device/pda/heads/rd
	default_headset = /obj/item/device/radio/headset/heads/rd
	default_satchel = /obj/item/weapon/storage/backpack/satchel
	default_backpack = /obj/item/weapon/storage/backpack/satchel

	access = list()
	minimal_access = list()

/datum/job/rd/equip_items(var/mob/living/carbon/human/H)
	H.verbs += /mob/living/carbon/human/proc/renderaid									 //This is how we get the verb!
	H.equip_to_slot_or_del(new /obj/item/clothing/shoes/sneakers/brown(H), slot_shoes)
	H.equip_to_slot_or_del(new /obj/item/clothing/under/rank/research_director(H), slot_w_uniform)
	H.equip_to_slot_or_del(new /obj/item/clothing/suit/armor/LIOX(H), slot_wear_suit)
	H.equip_to_slot_or_del(new /obj/item/clothing/gloves/lordinquisitor(H), slot_gloves)
	H.equip_to_slot_or_del(new /obj/item/device/laser_pointer(H), slot_l_store)
	H.equip_to_slot_or_del(new /obj/item/clothing/head/liox(H), slot_head)
	H.equip_to_slot_or_del(new /obj/item/weapon/gun/projectile/automatic/bpistol(H), slot_l_hand)
	H.faction = "Inquisitor"


	if(H.backbag != 1)
		H.equip_to_slot_or_del(new /obj/item/weapon/melee/telebaton(H), slot_in_backpack)
		H.equip_to_slot_or_del(new /obj/item/weapon/paper/liox(H), slot_in_backpack)

/datum/job/rd/get_access()
	return get_all_accesses()
/*
Scientist
*/
/datum/job/scientist
	title = "Scientist"
	flag = SCIENTIST
	department_head = list("Ordo Xenos Inquisitor")
	department_flag = MEDSCI
	faction = "Station"
	total_positions = 5
	spawn_positions = 3
	supervisors = "The Ordo Xenos Inquisitor"
	selection_color = "#ffeeff"

	default_pda = /obj/item/device/pda/toxins
	default_headset = /obj/item/device/radio/headset/headset_sci
	default_satchel = /obj/item/weapon/storage/backpack/satchel_tox

	access = list(access_robotics, access_tox, access_tox_storage, access_research, access_xenobiology, access_mineral_storeroom)
	minimal_access = list(access_tox, access_tox_storage, access_research, access_xenobiology, access_mineral_storeroom)

/datum/job/scientist/equip_items(var/mob/living/carbon/human/H)
	H.verbs += /mob/living/carbon/human/proc/renderaid									 //This is how we get the verb!
	H.equip_to_slot_or_del(new /obj/item/clothing/under/rank/scientist(H), slot_w_uniform)
	H.equip_to_slot_or_del(new /obj/item/clothing/shoes/sneakers/white(H), slot_shoes)
	H.equip_to_slot_or_del(new /obj/item/clothing/suit/science2(H), slot_wear_suit)

/*
Roboticist
*/
/datum/job/roboticist
	title = "Cybernetica Acolyte"
	flag = ROBOTICIST
	department_head = list("Magos")  //Was the Ordo Xenos Inquisitor but now Magos.
	department_flag = MEDSCI
	faction = "Station"
	total_positions = 2
	spawn_positions = 1
	supervisors = "Magos, Ordo Xenos Inquisitor"
	selection_color = "#ffeeff"

	default_pda = /obj/item/device/pda/roboticist
	default_headset = /obj/item/device/radio/headset/headset_rob //Has engineering comms.
	default_satchel = /obj/item/weapon/storage/backpack/satchel_robo

	access = list(access_robotics, access_tech_storage, access_morgue, access_research, access_tox, access_mineral_storeroom, access_engine, access_eva, access_engine_equip, access_maint_tunnels, access_construction, access_atmospherics)
	minimal_access = list(access_robotics, access_tech_storage, access_morgue, access_research,access_mineral_storeroom, access_engine, access_eva, access_engine_equip, access_maint_tunnels, access_construction, access_atmospherics)

/datum/job/roboticist/equip_items(var/mob/living/carbon/human/H)
	H.verbs += /mob/living/carbon/human/proc/renderaid									 //This is how we get the verb!
	H.equip_to_slot_or_del(new /obj/item/clothing/under/rank/roboticist(H), slot_w_uniform)
	H.equip_to_slot_or_del(new /obj/item/clothing/shoes/sneakers/black(H), slot_shoes)
	H.equip_to_slot_or_del(new /obj/item/clothing/suit/labcoat/science(H), slot_wear_suit)
	H.equip_to_slot_or_del(new /obj/item/clothing/gloves/cybernetica(H), slot_gloves)
	H.equip_to_slot_or_del(new /obj/item/weapon/paper/roboto(H), slot_in_backpack)

	spawn(10)
		var/augmentchoice = input(H, "Select an augmented location.","Augment selection") as null|anything in list("Head", "Chest", "Left Arm", "Right Arm", "Left Leg", "Right Leg")
		switch(augmentchoice)  //Based on the IG weapon selection code.
			if("Head")
				H.organs -= H.getlimb(/obj/item/organ/limb/head)  //Doesn't put it on the ground as this presumably happened already on a forge world.
				H.organs += new /obj/item/organ/limb/robot/head()
			if("Chest")
				H.organs -= H.getlimb(/obj/item/organ/limb/chest)
				H.organs += new /obj/item/organ/limb/robot/chest()
			if("Left Arm")
				H.organs -= H.getlimb(/obj/item/organ/limb/l_arm)
				H.organs += new /obj/item/organ/limb/robot/l_arm()
			if("Right Arm")
				H.organs -= H.getlimb(/obj/item/organ/limb/r_arm)
				H.organs += new /obj/item/organ/limb/robot/r_arm()
			if("Left Leg")
				H.organs -= H.getlimb(/obj/item/organ/limb/l_leg)
				H.organs += new /obj/item/organ/limb/robot/l_leg()
			if("Right Leg")
				H.organs -= H.getlimb(/obj/item/organ/limb/r_leg)
				H.organs += new /obj/item/organ/limb/robot/r_leg()
		H.update_damage_overlays(0)
		H.update_augments()