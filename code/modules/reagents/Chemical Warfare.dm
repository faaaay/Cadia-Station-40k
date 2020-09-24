#define SOLID 1
#define LIQUID 2
#define GAS 3

#define REM REAGENTS_EFFECT_MULTIPLIER

//The reaction procs must ALWAYS set src = null, this detaches the proc from the object (the reagent)
//so that it can continue working when the reagent is deleted while the proc is still active.

//Tyranid
datum/reagent/toxin/tyranidkiller
	name = "Anti-Tyranid Agent"
	id = "tyranidkiller"
	description = "A lethal agent designed to force the cells of Tyranids to revert to the unordered bio-mass they are composed of. It is very powerful when delivered as an aerosol"
	color = "#30DB50"
	toxpwr = 0

datum/reagent/toxin/tyranidkiller/reaction_mob(var/mob/living/M, var/method=TOUCH, var/volume)  ///Should hopefully work on rippers too. Affects xenomorphs but that's fine as it's a counter to them in event rounds.
	if(!istype(M))	return //This is done as reaction/mob rather than on_life so that venomthropes won't eat their own reagents.
	if(istype(M, /mob/living/carbon/alien/humanoid/tyranid/venomthropes))
		if(prob(40))
			if (prob(20)) //So message isn't spammed.
				M.visible_message("\red <b> The [M] partially melts!</b>")
			M.take_organ_damage(rand(5,15),rand(5,15)) //Venomthropes with this in their blood will produce it in toxic clouds.
	else if(isalien(M) || istype(M, /mob/living/simple_animal/hostile/alien/ripper)) //Hive Fleet Ouroboris will be immune when/if hive fleet adaptations are added.
		if(prob(40))
			if (prob(20)) //So message isn't spammed.
				M.visible_message("\red <b> The [M] partially melts!</b>")
			M.take_organ_damage(rand(15,25),rand(15,25))
	return

datum/reagent/toxin/tyranidkiller/reaction_obj(var/obj/O)
	if(istype(O,/obj/structure/alien/weeds/) || istype(O,/obj/structure/mineral_door/resin) || istype(O,/obj/structure/alien) || istype(O,/obj/structure/stool/bed/nest))
		if(istype(O, /obj/structure/alien/resin/spore))
			O.visible_message("\red The [O] deflates and dissolves into biomass harmlessly!<")
		qdel(O)



/datum/chemical_reaction/tyranidkiller
	name = "Anti-Tyranid Agent"
	id = "tyranidkiller"
	result = "tyranidkiller"
	required_reagents = list("pacid" = 3, "mutagen" = 2, "pestkiller" = 5)
	result_amount = 1


//Ork
datum/reagent/toxin/orkkiller
	name = "Anti-Orkoid Agent"
	id = "orkkiller"
	description = "A lethal agent designed to kill the symbiotic fungus in Orks. It is very powerful in the Ork's but can inflict some damage when delivered as an aerosol"
	color = "#FFFFFF"
	toxpwr = 0

datum/reagent/toxin/orkkiller/reaction_mob(var/mob/living/M, var/method=TOUCH, var/volume)
	if(!istype(M))	return
	if(isork(M))
		if(prob(25))
			if (prob(20)) //So message isn't spammed.
				M.visible_message("\red <b> A small part of the [M] crumbles away into dead fungus!</b>") //Not happy with this message. Could be worded better but not sure how.
			M.take_organ_damage(rand(1,5),rand(1,5)) //Far less severe than Tyranids but Orks also need to deal with breathing it in.
	return

datum/reagent/toxin/orkkiller/on_mob_life(var/mob/living/M as mob)
	if(!M) M = holder.my_atom
	if(isork(M))
		M.take_organ_damage(rand(20,25),rand(20,25))
		M.visible_message("\red <b> Part of the [M] bursts into dead fungus and gore!</b>") //Not happy with this message. Could be worded better but not sure how.
	holder.remove_reagent(src.id, 1) //So should be fast acting and do 40-50 damage per 1u.
	..()
	return

/datum/chemical_reaction/orkkiller
	name = "Anti-Orkoid Agent"
	id = "orkkiller"
	result = "orkkiller"
	required_reagents = list("pacid" = 3, "mutagen" = 2, "weedkiller" = 5)
	result_amount = 1
