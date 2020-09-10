//Librarians energy reserve code here

/mob/living/carbon/human/whitelisted
	var/Psy = 0
	var/maxPsy = 0
	var/Psy_rate = 20

/mob/living/carbon/human/whitelisted/Stat()
	..()
	if(maxPs>0)
		stat(null, "Psy: [Psy]/[maxPsy]")

/mob/living/carbon/human/whitelisted/Life()
	if(Psy < maxPsy)
		Psy = min(Psy+Psy_rate, maxPsy)

/mob/living/carbon/human/whitelisted/verb/imprison(var/mob/living/carbon/T in oview(7))
	if(maxPsy<=0)
		return
	set name = "Imprison (300)"
	set desc = "Uses your psychic abilities to imprison someone in their own mental barriers."
	set category = "Spells"
	if(Psy>=300)
		Psy-=300
		if(!T)
			var/list/victims = list()
			for(var/mob/living/carbon/C in oview(7))
				victims += C
			T = input(src, "Who should we imprison?") as null|anything in victims
		if(T)
			if(!istype(T))
				src << "\red We only imprison living beings!"
				return
			src << "We psychically imprison [T]"
			visible_message("\green <B>[src]'s eyes glow green!</B>")
			for(var/turf/W in orange(10,T)) //Their entire view so they can't see outside the walls around them.
				if(get_dist(T,W) > 2)
					var/obj/effect/turf_projection/prison = project_turf(T,W) //Makes a ring of hallucinated walls around you.
					prison.lifetime = 600
		else
			src << "\blue You cannot imprison nothing!"
	else
		src << "\red You need more psy!"

/mob/living/carbon/human/whitelisted/verb/haunt(var/mob/living/carbon/T in oview(7))
	if(maxPsy<=0)
		return
	set name = "Haunt"
	set desc = "Projects disturbing sounds to the victim."
	set category = "Spells"

	if(!T)
		var/list/victims = list()
		for(var/mob/living/carbon/human/C in oview(7))
			victims += C
		T = input(src, "Who should we haunt?") as null|anything in victims
	if(T)
		if(!istype(T))
			src << "\red We only haunt people!"
			return
		src << "We haunt [T]"
		playsound(T.loc, pick('sound/hallucinations/behind_you1.ogg',\
			'sound/hallucinations/behind_you2.ogg',\
			'sound/hallucinations/i_see_you1.ogg',\
			'sound/hallucinations/i_see_you2.ogg',\
			'sound/hallucinations/im_here1.ogg',\
			'sound/hallucinations/im_here2.ogg',\
			'sound/hallucinations/look_up1.ogg',\
			'sound/hallucinations/look_up2.ogg',\
			'sound/hallucinations/over_here1.ogg',\
			'sound/hallucinations/over_here2.ogg',\
			'sound/hallucinations/over_here3.ogg',\
			'sound/hallucinations/turn_around1.ogg',\
			'sound/hallucinations/turn_around2.ogg',\
			), 50, 1, -3)
	else
		src << "\blue You cannot haunt nothing!"