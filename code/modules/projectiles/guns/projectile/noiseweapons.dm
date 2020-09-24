/obj/item/weapon/gun/projectile/blastmaster
	name = "Blastmaster"
	icon_state = "Blastmaster"
	item_state = "Blastmaster"
	desc = "Hear our dirge and dispair!"
	origin_tech = "combat=5;materials=2"
	w_class = 5
	var/projectiles_per_shot = 4
	var/deviation = 0.7
	var/projectile
	var/projectiles = 1000000
	var/cooldown = 1
	projectile = /obj/item/projectile/noise