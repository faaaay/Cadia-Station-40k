/obj/structure/girder
	icon_state = "girder"
	anchored = 1
	density = 1
	layer = 2
	var/state = 0

	attackby(obj/item/W as obj, mob/user as mob)
		add_fingerprint(user)
		if(istype(W, /obj/item/turretblueprint) && state == 0)
			if(anchored && !istype(src,/obj/structure/girder/displaced))
				playsound(src.loc, 'sound/items/Deconstruct.ogg', 100, 1)
				user << "<span class='notice'>Now assembling scafold...</span>"
				if(do_after(user,40))
					if(!src) return
					user << "<span class='notice'>You assembled the scafold!</span>"
					new /obj/structure/girder/construction(get_turf(src))
					qdel(W)
					qdel(src)
			else if(!anchored)
				user << "<span class='notice'>You will need to anchor this first...</span>"
				return

		if(istype(W, /obj/item/weapon/snowshovel/ig970) && state == 0)
			playsound(src.loc, 'sound/items/Ratchet.ogg', 100, 1)
			user << "<span class='notice'>Now building fortifications...</span>"
			if(do_after(user,40))
				if(!src) return
				user << "<span class='notice'>You construct fortifications!</span>"
				var/obj/structure/barricade/metal/B = new /obj/structure/barricade/metal(get_turf(src))
				B.dir = user.dir
				qdel(src)

		if(istype(W, /obj/item/weapon/wrench) && state == 0)
			if(anchored && !istype(src,/obj/structure/girder/displaced))
				playsound(src.loc, 'sound/items/Ratchet.ogg', 100, 1)
				user << "<span class='notice'>Now disassembling the girder...</span>"
				if(do_after(user,40))
					if(!src) return
					user << "<span class='notice'>You dissasembled the girder!</span>"
					new /obj/item/stack/sheet/metal(get_turf(src))
					qdel(src)
			else if(!anchored)
				playsound(src.loc, 'sound/items/Ratchet.ogg', 100, 1)
				user << "<span class='notice'>Now securing the girder...</span>"
				if(do_after(user, 40))
					user << "<span class='notice'>You secured the girder!</span>"
					var/obj/structure/girder/G = new (loc)
					transfer_fingerprints_to(G)
					qdel(src)

		else if(istype(W, /obj/item/weapon/pickaxe/plasmacutter))
			user << "<span class='notice'>Now slicing apart the girder...</span>"
			if(do_after(user,30))
				if(!src) return
				user << "<span class='notice'>You slice apart the girder!</span>"
				new /obj/item/stack/sheet/metal(get_turf(src))
				qdel(src)

		else if(istype(W, /obj/item/weapon/pickaxe/diamonddrill))
			user << "<span class='notice'>You drill through the girder!</span>"
			new /obj/item/stack/sheet/metal(get_turf(src))
			qdel(src)

		else if(istype(W, /obj/item/weapon/screwdriver) && state == 2 && istype(src,/obj/structure/girder/reinforced))
			playsound(src.loc, 'sound/items/Screwdriver.ogg', 100, 1)
			user << "<span class='notice'>Now unsecuring support struts...</span>"
			if(do_after(user,40))
				if(!src) return
				user << "<span class='notice'>You unsecured the support struts!</span>"
				state = 1

		else if(istype(W, /obj/item/weapon/wirecutters) && istype(src,/obj/structure/girder/reinforced) && state == 1)
			playsound(src.loc, 'sound/items/Wirecutter.ogg', 100, 1)
			user << "<span class='notice'>Now removing support struts...</span>"
			if(do_after(user,40))
				if(!src) return
				user << "<span class='notice'>You removed the support struts!</span>"
				var/obj/structure/girder/G = new (loc)
				transfer_fingerprints_to(G)
				qdel(src)

		else if(istype(W, /obj/item/weapon/crowbar) && state == 0 && anchored )
			playsound(src.loc, 'sound/items/Crowbar.ogg', 100, 1)
			user << "<span class='notice'>Now dislodging the girder...</span>"
			if(do_after(user, 40))
				if(!src) return
				user << "<span class='notice'>You dislodged the girder!</span>"
				var/obj/structure/girder/displaced/D = new (loc)
				transfer_fingerprints_to(D)
				qdel(src)

		else if(istype(W, /obj/item/stack/sheet))

			var/obj/item/stack/sheet/S = W
			switch(S.type)

				if(/obj/item/stack/sheet/metal, /obj/item/stack/sheet/metal/cyborg)
					if(!anchored)
						if(S.amount < 2)
							user << "<span class='warning'>You need at least two sheets to create a false wall.</span>"
							return
						S.use(2)
						user << "<span class='notice'>You create a false wall! Push on it to open or close the passage.</span>"
						var/obj/structure/falsewall/F = new (loc)
						transfer_fingerprints_to(F)
						qdel(src)
					else
						if(S.amount < 2) return ..()
						user << "<span class='notice'>Now adding plating...</span>"
						if (do_after(user,40))
							if(!src || !S || S.amount < 2) return
							S.use(2)
							user << "<span class='notice'>You added the plating!</span>"
							var/turf/Tsrc = get_turf(src)
							var/obj/effect/fake_floor/faketurf = locate(/obj/effect/fake_floor) in Tsrc
							if(faketurf)
								var/obj/effect/fake_floor/fake_wall/newwall = new /obj/effect/fake_floor/fake_wall(Tsrc)
								if(faketurf.area)
									faketurf.area.add_turf(newwall)
								qdel(faketurf)
							else
								if(!Tsrc) return //Better that than throwing an error. How does this even happen though?
								Tsrc.ChangeTurf(/turf/simulated/wall)
								for(var/turf/simulated/wall/X in Tsrc.loc)
									if(X)	transfer_fingerprints_to(X)
							qdel(src)
						return

				if(/obj/item/stack/sheet/plasteel)
					if(!anchored)
						if(S.amount < 2)
							user << "<span class='warning'>You need at least two sheets to create a false wall.</span>"
							return
						S.use(2)
						user << "<span class='notice'>You create a false wall! Push on it to open or close the passage.</span>"
						var/obj/structure/falsewall/reinforced/FW = new (loc)
						transfer_fingerprints_to(FW)
						qdel(src)
					else
						if (src.icon_state == "reinforced") //I cant believe someone would actually write this line of code...
							if(S.amount < 1) return ..()
							user << "<span class='notice'>Now finalising reinforced wall...</span>"
							if(do_after(user, 50))
								if(!src || !S || S.amount < 1) return
								S.use(1)
								user << "<span class='notice'>Wall fully reinforced!</span>"
								var/turf/Tsrc = get_turf(src)
								var/obj/effect/fake_floor/faketurf = locate(/obj/effect/fake_floor) in Tsrc
								if(faketurf)
									var/obj/effect/fake_floor/fake_wall/r_wall/newwall = new /obj/effect/fake_floor/fake_wall/r_wall(Tsrc)
									if(faketurf.area)
										faketurf.area.add_turf(newwall)
									qdel(faketurf)
								else
									if(!Tsrc) return
									Tsrc.ChangeTurf(/turf/simulated/wall/r_wall)
									for(var/turf/simulated/wall/r_wall/X in Tsrc.loc)
										if(X)	transfer_fingerprints_to(X)
								qdel(src)
							return
						else
							if(S.amount < 1) return ..()
							user << "<span class='notice'>Now reinforcing girders...</span>"
							if (do_after(user,60))
								if(!src || !S || S.amount < 1) return
								S.use(1)
								user << "<span class='notice'>Girders reinforced!</span>"
								var/obj/structure/girder/reinforced/R = new (loc)
								transfer_fingerprints_to(R)
								qdel(src)
							return

			if(S.sheettype)
				var/M = S.sheettype
				if(!anchored)
					if(S.amount < 2)
						user << "<span class='warning'>You need at least two sheets to create a false wall.</span>"
						return
					S.use(2)
					user << "<span class='notice'>You create a false wall! Push on it to open or close the passage.</span>"
					var/F = text2path("/obj/structure/falsewall/[M]")
					var/obj/structure/FW = new F (loc)
					transfer_fingerprints_to(FW)
					qdel(src)
				else
					if(S.amount < 2) return ..()
					user << "<span class='notice'>Now adding plating...</span>"
					if (do_after(user,40))
						if(!src || !S || S.amount < 2) return
						S.use(2)
						user << "<span class='notice'>You added the plating!</span>"
						var/turf/Tsrc = get_turf(src)
						Tsrc.ChangeTurf(text2path("/turf/simulated/wall/mineral/[M]"))
						for(var/turf/simulated/wall/mineral/X in Tsrc.loc)
							if(X)	transfer_fingerprints_to(X)
						qdel(src)
					return

			add_hiddenprint(usr)

		//else if(istype(W, /obj/item/pipe))
		//	var/obj/item/pipe/P = W
		//	if (P.pipe_type in list(0, 1, 5))	//simple pipes, simple bends, and simple manifolds.
		//		user.drop_item()
		//		P.loc = src.loc
		//		user << "<span class='notice'>You fit the pipe into the [src]!</span>"
		else
			..()


	blob_act()
		if(prob(40))
			qdel(src)


	ex_act(severity)
		switch(severity)
			if(1.0)
				qdel(src)
				return
			if(2.0)
				if (prob(30))
					var/remains = pick(/obj/item/stack/rods,/obj/item/stack/sheet/metal)
					new remains(loc)
					qdel(src)
				return
			if(3.0)
				if (prob(5))
					var/remains = pick(/obj/item/stack/rods,/obj/item/stack/sheet/metal)
					new remains(loc)
					qdel(src)
				return
			else
		return

/obj/structure/girder/displaced
	icon_state = "displaced"
	anchored = 0

/obj/structure/girder/reinforced
	icon_state = "reinforced"
	state = 2

/obj/structure/cultgirder
	icon= 'icons/obj/cult.dmi'
	icon_state= "cultgirder"
	anchored = 1
	density = 1
	layer = 2

	attackby(obj/item/W as obj, mob/user as mob)
		if(istype(W, /obj/item/weapon/wrench))
			playsound(src.loc, 'sound/items/Ratchet.ogg', 100, 1)
			user << "<span class='notice'>Now disassembling the girder...</span>"
			if(do_after(user,40))
				user << "<span class='notice'>You dissasembled the girder!</span>"
				var/obj/effect/decal/remains/human/R = new (get_turf(src))
				transfer_fingerprints_to(R)
				qdel(src)

		else if(istype(W, /obj/item/weapon/pickaxe/plasmacutter))
			user << "<span class='notice'>Now slicing apart the girder...</span>"
			if(do_after(user,30))
				user << "<span class='notice'>You slice apart the girder!</span>"
				var/obj/effect/decal/remains/human/R = new (get_turf(src))
				transfer_fingerprints_to(R)
				qdel(src)

		else if(istype(W, /obj/item/weapon/pickaxe/diamonddrill))
			user << "<span class='notice'>You drill through the girder!</span>"
			if(do_after(user, 5))
				var/obj/effect/decal/remains/human/R = new (get_turf(src))
				transfer_fingerprints_to(R)
				qdel(src)

	blob_act()
		if(prob(40))
			qdel(src)


	ex_act(severity)
		switch(severity)
			if(1.0)
				qdel(src)
				return
			if(2.0)
				if (prob(30))
					new /obj/effect/decal/remains/human(loc)
					qdel(src)
				return
			if(3.0)
				if (prob(5))
					new /obj/effect/decal/remains/human(loc)
					qdel(src)
				return
			else
		return

/obj/structure/girder/construction						//one
	desc = "The blueprints call for five lengths of wire."
	icon_state = "scafold"
	anchored = 1
	density = 1
	layer = 2

/obj/structure/girder/construction/attackby(obj/item/W as obj, mob/user as mob)
	if(istype(W, /obj/item/stack/cable_coil))
		var/obj/item/stack/cable_coil/CC = W
		if (CC.amount < 5)
			user << "<span class='notice'>You need at least 5 in the stack to do this.</span>"
			return
		user << "<span class='notice'>Now adding wire...</span>"
		playsound(src.loc, 'sound/items/Deconstruct.ogg', 100, 1)
		if(do_after(user,40))
			user << "<span class='notice'>You added wires.</span>"
			new /obj/structure/girder/construction2(get_turf(src))
			qdel(src)
			CC.use(5)
	else
		user << "<span class='notice'>You may want to re-read the description.</span>"

/obj/structure/girder/construction2						//two
	desc = "The blueprints call for ten sheets of metal."
	icon_state = "scafold2"
	anchored = 1
	density = 1
	layer = 2

/obj/structure/girder/construction2/attackby(obj/item/W as obj, mob/user as mob)
	if(istype(W, /obj/item/stack/sheet/metal))
		var/obj/item/stack/cable_coil/ME = W
		if (ME.amount < 10)
			user << "<span class='notice'>You need at least 10 in the stack to do this.</span>"
			return
		playsound(src.loc, 'sound/items/Deconstruct.ogg', 100, 1)
		user << "<span class='notice'>Now adding metal...</span>"
		if(do_after(user,40))
			user << "<span class='notice'>You added metal.</span>"
			new /obj/structure/girder/construction3(get_turf(src))
			qdel(src)
			ME.use(10)
	else
		user << "<span class='notice'>You may want to re-read the description.</span>"

/obj/structure/girder/construction3						//three
	desc = "The blueprints call for a power cell."
	icon_state = "scafold3"
	anchored = 1
	density = 1
	layer = 2

/obj/structure/girder/construction3/attackby(obj/item/W as obj, mob/user as mob)
	if(istype(W, /obj/item/weapon/stock_parts/cell))
		playsound(src.loc, 'sound/items/Deconstruct.ogg', 100, 1)
		user << "<span class='notice'>Now adding power cell...</span>"
		if(do_after(user,40))
			user << "<span class='notice'>You added a power cell.</span>"
			new /obj/structure/girder/construction4(get_turf(src))
			qdel(W)
			qdel(src)
	else
		user << "<span class='notice'>You may want to re-read the description.</span>"

/obj/structure/girder/construction4						//four
	desc = "The blueprints call for a Plasma Pistol, A Lasgun, A Taser or a Glock 9mm."
	icon_state = "scafold4"
	anchored = 1
	density = 1
	layer = 2

/obj/structure/girder/construction4/attackby(obj/item/W as obj, mob/user as mob)
	if(istype(W, /obj/item/weapon/gun/projectile/automatic/deagle/glock))		//glock
		user << "<span class='notice'>Now adding a glock...</span>"
		if(do_after(user,40))
			user << "<span class='notice'>You added a glock.</span>"
			new /obj/structure/spiderturretbox/projectile(get_turf(src))
			qdel(W)
			qdel(src)
	if(istype(W, /obj/item/weapon/gun/projectile/automatic/lasgun))		//secretly three different types of lasguns for bayonet purposes
		user << "<span class='notice'>Now adding a Lasgun...</span>"
		if(do_after(user,40))
			user << "<span class='notice'>You added a Lasgun.</span>"
			new /obj/structure/spiderturretbox/lasgun(get_turf(src))
			qdel(W)
			qdel(src)
	if(istype(W, /obj/item/weapon/gun/projectile/automatic/lasgun))		//type B
		user << "<span class='notice'>Now adding a Lasgun...</span>"
		if(do_after(user,40))
			user << "<span class='notice'>You added a Lasgun.</span>"
			new /obj/structure/spiderturretbox/lasgun(get_turf(src))
			qdel(W)
			qdel(src)
	if(istype(W, /obj/item/weapon/gun/projectile/automatic/lasgunc))		//type C
		user << "<span class='notice'>Now adding a Lasgun...</span>"
		if(do_after(user,40))
			user << "<span class='notice'>You added a Lasgun.</span>"
			new /obj/structure/spiderturretbox/lasgun(get_turf(src))
			qdel(W)
			qdel(src)
	if(istype(W, /obj/item/weapon/gun/energy/plasma) && !istype(W, /obj/item/weapon/gun/energy/plasma/arcrifle))	//plasma. No limitless Skitarii turrets.
		user << "<span class='notice'>Now adding a Plasma Pistol...</span>"
		if(do_after(user,40))
			user << "<span class='notice'>You added a Plasma Pistol.</span>"
			new /obj/structure/spiderturretbox/plasma(get_turf(src))
			qdel(W)
			qdel(src)
	if(istype(W, /obj/item/weapon/gun/energy/taser))		//taser
		user << "<span class='notice'>Now adding a Taser...</span>"
		if(do_after(user,40))
			user << "<span class='notice'>You added a Taser.</span>"
			new /obj/structure/spiderturretbox/taser(get_turf(src))
			qdel(W)
			qdel(src)
	else
		user << "<span class='notice'>You may want to re-read the description.</span>"
