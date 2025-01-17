/obj/mecha/combat/dreadnought
	desc = "A Cybernetic walker of intermediate size used by by the Chapters of the Adeptus Astartes as heavy infantry support for their Space Marine companies."
	name = "Ultra Marine Dreadnought"
	icon = 'icons/migrated/alienqueen.dmi'
	icon_state = "dread2"
	//pixel_x = -10
	bound_width = 32
	step_in = 5
	health = 1500
	deflect_chance = 50
	damage_absorption = list("brute"=0.3,"fire"=0.3,"bullet"=0.4,"laser"=0.5,"energy"=0.3,"bomb"=1)
	max_temperature = 65000
	infra_luminosity = 3
	operation_req_access = list(access_hos)
	wreckage = /obj/structure/mecha_wreckage/dreadnought
	add_req_access = 0
	internal_damage_threshold = 5
	force = 90
	max_equip = 6

/obj/mecha/combat/dreadnought/loaded/New()
	..()
	var/obj/item/mecha_parts/mecha_equipment/ME = new /obj/item/mecha_parts/mecha_equipment/weapon/ballistic/missile_rack(src)
	ME.attach(src)
	ME = new /obj/item/mecha_parts/mecha_equipment/weapon/ballistic/lmg(src)
	ME.attach(src)
	ME = new /obj/item/mecha_parts/mecha_equipment/antiproj_armor_booster(src)
	ME.attach(src)
	noescape = 1
	return

/obj/mecha/combat/dreadnought/add_cell(var/obj/item/weapon/stock_parts/cell/C=null)
	if(C)
		C.forceMove(src)
		cell = C
		return
	cell = new(src)
	cell.charge = 9999999999999999999999999999999
	cell.maxcharge = 9999999999999999999999999999999
	src.verbs -= /obj/mecha/verb/start_move_inside
	src.verbs -= /obj/mecha/verb/eject



/obj/mecha/combat/dreadnought/verb/moveferry()
	set name = "Move DropShip"
	set category = "Exosuit Interface"
	set src = usr.loc
	set popup_menu = 0

	if(usr.stat)		return
	if(usr != occupant)	return

	var/datum/shuttle_manager/s = shuttles["ferry"]
	if(istype(s)) s.move_shuttle(0,1)
	return

/obj/mecha/combat/dreadnought/CanPass(atom/movable/mover, turf/target, height=0, air_group=0) //We won't hit ourself with out own missiles!
	if(istype(mover, /obj/item/missile))
		var/obj/item/missile/M = mover
		if(M.firer == src)
			return 1
	return ..()


/obj/mecha/combat/dreadnought/verb/dreadnought_move_inside() //Based on Ork killakan verb. Marine only (unlikely to come up) plus are you sure message.
	set category = "Object"
	set name = "Enter Dreadnought"
	set src in oview(1)
	if(istype(usr, /mob/living/carbon/human/whitelisted) && !istype(usr, /mob/living/carbon/human/whitelisted/eldar))
		var/confirm = alert("If you enter the [src.name], you will be entombed in its ceramite casing until death. Are you sure?", "Enter?", "Yes", "No")
		if(confirm == "Yes")
			if(enter_after(40,usr))
				if(!src.occupant)
					move_inside(usr)
				else if(src.occupant!=usr)
					usr << "[src.occupant] has already been entombed in the dreadnought!."
	else
		usr << "\blue <B>You think [src.name] is only suitable for an Astartes.</B>"
		return
