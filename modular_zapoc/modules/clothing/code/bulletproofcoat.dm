/obj/item/clothing/suit/vampire
	var/can_have_armor = TRUE

/obj/item/clothing/suit/vampire/Initialize(mapload)
	. = ..()
	if(can_have_armor)
		AddComponent(/datum/component/armor_plate, _maxamount = 1, _upgrade_item = /obj/item/clothing/suit/vampire/vest, _added_armor = list(MELEE = 55, BULLET = 55, LASER = 10, ENERGY = 10, BOMB = 55, BIO = 0, RAD = 0, FIRE = 45, ACID = 10, WOUND = 25), set_armor = TRUE)
		RegisterSignal(src, COMSIG_ARMOR_PLATED, PROC_REF(upgrade_icon))


/obj/item/clothing/suit/vampire/proc/upgrade_icon(datum/source, amount, maxamount)
	SIGNAL_HANDLER

	if(amount)
		name = "armored [initial(name)]"
//icon_state = "coatvest_[base_icon_state]"
		desc = "[initial(desc)] Has a durable, lightweight vest. Slay."
