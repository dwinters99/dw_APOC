/obj/item/storage/ashtray
	name = "ashtray"
	desc = "A small bowl for holding and disposing of smokestuffs."
	icon = 'modular_zapoc/modules/apoc_decor/icons/ashtray.dmi'
	icon_state = "ashtray"
	resistance_flags = FIRE_PROOF
	drop_sound = 'sound/items/handling/drinkglass_drop.ogg'
	pickup_sound =  'sound/items/handling/drinkglass_pickup.ogg'
	color = "#303030"
	grid_width = 1 GRID_BOXES
	grid_height = 1 GRID_BOXES
	storage_max_columns = 4
	storage_max_rows = 4

/obj/item/storage/fancy/update_icon_state()
	. = ..()
	var/datum/component/storage/STR = GetComponent(/datum/component/storage)
	var/overlay_half = "[initial(icon_state)]_overlay-half"
	var/overlay_full = "[initial(icon_state)]_overlay-full"

	cut_overlay(list(overlay_half, overlay_full))

	if(contents.len >= STR.max_items/2)
		add_overlay(overlay_half)
	else if(contents.len == STR.max_items)
		add_overlay(overlay_full)

/obj/item/storage/ashtray/ComponentInitialize()
	. = ..()
	var/datum/component/storage/STR = GetComponent(/datum/component/storage)
	STR.max_items = 16
	STR.max_w_class = WEIGHT_CLASS_TINY
	STR.set_holdable(
		list(
			/obj/item/match,
			/obj/item/cigbutt,
			/obj/item/clothing/mask/cigarette,
			/obj/item/rollingpaper
			), list(/obj/item/clothing/mask/cigarette/pipe))

/obj/item/storage/ashtray/attack_self(mob/user)
	. = ..()
	user.visible_message(span_notice("[user] dumps [src] out onto the ground."), \
		span_notice("You dump [src] out onto the ground."))
	if(contents.len > 8)
		new /obj/effect/decal/cleanable/ash/large(get_turf(user))
	else if (contents.len)
		new /obj/effect/decal/cleanable/ash(get_turf(user))
	else
		return

	emptyStorage()
