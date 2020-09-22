 //very big WIP testing ideas with these boys - it seems to be much easier to get them functioning as humans rather than silicon as that entails a whole lot of craziness. Really need to make them unable to wear anything but give them base armor/biotic weps
/mob/living/carbon/human/skitarii_ranger
	name = "Unknown"
	real_name = "Unknown"
	universal_speak = 1
	gender = "male"
	maxHealth = 150
	health = 150
	status_flags = 0
	factions = list("imperium")//new
	var/isempty = 0

/mob/living/carbon/human/skitarii_ranger/New()
	..()
	immunetofire = 1
	spawn(5) 
		if(!src.ckey)
			isempty = 1 //Then the larva can be possessed by any ghost.
			request_player()
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

//Procs for grabbing players.
/mob/living/carbon/human/skitarii_ranger/proc/request_player()
	for(var/mob/dead/observer/O in player_list)
		if(jobban_isbanned(O, "Syndicate"))
			continue
		if(O.client)
			if(O.client.prefs.be_special & BE_ALIEN)
				question(O.client)

/mob/living/carbon/human/skitarii_ranger/proc/question(var/client/C)
	spawn(0)
		if(!C)	return
		var/response = alert(C, "An agent of the Adpetus Mechanicus needs a player. Are you interested?", "Skitarii Ranger", "Yes", "No", "Never for this round")
		if(!C || ckey)
			return
		if(response == "Yes")
			transfer_personality(C)
		else if (response == "Never for this round")
			C.prefs.be_special ^= BE_ALIEN

/mob/living/carbon/human/skitarii_ranger/proc/transfer_personality(var/client/candidate)

	if(!candidate)
		return

	isempty = 0
	src.mind = candidate.mob.mind
	src.ckey = candidate.ckey
	if(src.mind)
		src.mind.assigned_role = "imperium"

