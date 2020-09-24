//For all non-librarian psyker goodness, modified slightly to avoid duplicate errors with librarians

/mob/living/carbon/human/
	var/Psyk = 0
	var/maxPsyk = 0
	var/Psyk_rate = 20

/mob/living/carbon/human/Stat()
	..()
	if(maxPsyk>0)
		stat(null, "Psy: [Psyk]/[maxPsyk]")

/mob/living/carbon/human/Life()
	..()
	if(Psyk < maxPsyk)
		Psyk = min(Psyk+Psyk_rate, maxPsyk)

/mob/living/carbon/human/proc/imprisonn(var/mob/living/carbon/T in oview(7))
	set name = "Imprison (300)"
	set desc = "Uses your psychic abilities to imprison someone in their own mental barriers."
	set category = "Spells"
	if(Psyk>=300)
		Psyk-=300
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

/mob/living/carbon/human/proc/smitee(var/atom/T)
	set name = "Smite (60)"
	set desc = "Smite your foes with a psychic bolt"
	set category = "Spells"
	if(Psyk>=60)
		Psyk-=60
		if(!T)
			var/list/victims = list()
			for(var/mob/living/carbon/C in oview(7))
				victims += C
			T = input(src, "Who should we shoot?") as null|anything in victims
		if(T)
			src.visible_message("<span class='danger'>[src] projects psychic energy!", "<span class='alertalien'>You project psychic energy.</span>")
			var/turf/curloc = src.loc
			var/atom/targloc
			if(!istype(T, /turf/))
				targloc = get_turf(T)
			else
				targloc = T
			if (!targloc || !istype(targloc, /turf) || !curloc)
				return
			if (targloc == curloc)
				return
			var/obj/item/projectile/beam/mindflayer/A = new /obj/item/projectile/beam/mindflayer(src.loc)
			A.current = curloc
			A.yo = targloc.y - curloc.y
			A.xo = targloc.x - curloc.x
			A.process()
		else
			src << "\blue You cannot shoot at nothing!"
	else
		src << "\red You need more psy."

/mob/living/carbon/human/proc/quickeningg()
	set name = "Mind Over Matter (300)"
	set desc = "Use your psychich energy to stimulate reflexes to insane levels and negate all knockouts."
	set category = "Spells"
	if(dodging)
		src << "\red They are already active."
		return
	if(Psyk>=300)
		Psyk-=300
		dodging = 1
		status_flags = 0
		src << "\red Adrenaline active."
		spawn(90)
			src << "\red Adrenaline no longer active."
			dodging = 0
			status_flags = CANPARALYSE|CANPUSH
		return
	else
		src << "\red You need more psy."

/mob/living/carbon/human/proc/telepathh(mob/M as mob in orange(30,src)) //Like whisper but free, and much farther range.
	set name = "Telepathy"
	set desc = "Project your mind to others."
	set category = "Spells"

	if(stat != CONSCIOUS)
		return

	var/msg = sanitize(input("Message:", "Whisper") as text|null)
	if(msg)
		log_say("Telepathy: [key_name(src)]->[M.key] : [msg]")
		M << "<span class='noticealien'><b><i>You hear a strange voice in your head... [msg]</i></b></span>"
		src << {"<span class='noticealien'>You said: "[msg]" to [M]</span>"}
