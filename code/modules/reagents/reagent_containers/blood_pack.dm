/obj/item/reagent_containers/blood
	name = "blood pack"
	desc = "Contains blood used for transfusion. Must be attached to an IV drip."
	icon = 'icons/obj/bloodpack.dmi'
	icon_state = "bloodpack"
	volume = 200
	var/blood_type = null
	var/unique_blood = null
	var/labelled = FALSE
	fill_icon_thresholds = list(10, 20, 30, 40, 50, 60, 70, 80, 90, 100)

/obj/item/reagent_containers/blood/canconsume(mob/eater, mob/user)
	return FALSE

/obj/item/reagent_containers/blood/Initialize()
	. = ..()
	if(blood_type != null)
		reagents.add_reagent(unique_blood ? unique_blood : /datum/reagent/blood, 200, list("donor"=null,"viruses"=null,"blood_DNA"=null,"blood_type"=blood_type,"resistances"=null,"trace_chem"=null))
		update_appearance()

/obj/item/reagent_containers/blood/is_drainable()
	return TRUE

/obj/item/reagent_containers/blood/update_appearance(updates)
	. = ..()
	var/percent = round((reagents?.total_volume / volume) * 100)
	switch(percent)
		if(100)
			icon_state = "blood100"
		if(75)
			icon_state = "blood75"
		if(50)
			icon_state = "blood50"
		if(25)
			icon_state = "blood25"
		if(0)
			icon_state = "blood0"
	inhand_icon_state = icon_state
	onflooricon_state = icon_state

/// Handles updating the container when the reagents change.
/obj/item/reagent_containers/blood/on_reagent_change(datum/reagents/holder, ...)
	var/datum/reagent/blood/B = holder.has_reagent(/datum/reagent/blood)
	if(B && B.data && B.data["blood_type"])
		blood_type = B.data["blood_type"]
	else
		blood_type = null
	return ..()

/obj/item/reagent_containers/blood/update_name(updates)
	. = ..()
	if(labelled)
		return
	name = "blood_pack[blood_type ? " - [blood_type]" : null]"

/obj/item/reagent_containers/blood/random
	icon_state = "random_bloodpack"

/obj/item/reagent_containers/blood/random/Initialize()
	icon_state = "bloodpack"
	blood_type = pick("A+", "A-", "B+", "B-", "O+", "O-", "L")
	return ..()

/obj/item/reagent_containers/blood/a_plus
	blood_type = "A+"

/obj/item/reagent_containers/blood/a_minus
	blood_type = "A-"

/obj/item/reagent_containers/blood/b_plus
	blood_type = "B+"

/obj/item/reagent_containers/blood/b_minus
	blood_type = "B-"

/obj/item/reagent_containers/blood/o_plus
	blood_type = "O+"

/obj/item/reagent_containers/blood/o_minus
	blood_type = "O-"

/obj/item/reagent_containers/blood/lizard
	blood_type = "L"

/obj/item/reagent_containers/blood/elite
	name = "\improper elite blood pack (full)"
	amount_of_bloodpoints = 4

/obj/item/reagent_containers/blood/elite/Initialize(mapload)
	if(mapload)
		blood_type = pick("A+", "A-", "B+", "B-", "O+", "O-", "AB+", "AB-")
	return ..()

/obj/item/reagent_containers/blood/vitae
	name = "\improper vampire vitae pack (full)"
	amount_of_bloodpoints = 4
	vitae = TRUE

/obj/item/reagent_containers/blood/vitae/Initialize(mapload)
	if(mapload)
		blood_type = pick("A+", "A-", "B+", "B-", "O+", "O-", "AB+", "AB-")
	return ..()

/obj/item/reagent_containers/blood/random

/obj/item/reagent_containers/blood/random/Initialize(mapload)
	if(mapload)
		blood_type = pick("A+", "A-", "B+", "B-", "O+", "O-", "AB+", "AB-")
	return ..()

/obj/item/reagent_containers/blood/bweedpack
	name = "\improper elite blood pack (full)"
	blood_type = null

/obj/item/reagent_containers/blood/bweedpack/Initialize(mapload)
	. = ..()
	reagents.add_reagent(/datum/reagent/drug/cannabis, 20)
	reagents.add_reagent(/datum/reagent/toxin/lipolicide, 20)
	reagents.add_reagent(/datum/reagent/blood, 160,
		list("donor" = null,
			"viruses" = null,
			"blood_DNA" = null,
			"blood_type" = pick("A+", "A-", "B+", "B-", "O+", "O-", "AB+", "AB-"),
			"resistances" = null,
			"trace_chem" = null))
	update_appearance()

/obj/item/reagent_containers/blood/cokepack
	name = "\improper elite blood pack (full)"
	blood_type = null

/obj/item/reagent_containers/blood/cokepack/Initialize(mapload)
	. = ..()
	reagents.add_reagent(/datum/reagent/drug/methamphetamine/cocaine, 15)
	reagents.add_reagent(/datum/reagent/blood, 185,
		list("donor" = null,
			"viruses" = null,
			"blood_DNA" = null,
			"blood_type" = pick("A+", "A-", "B+", "B-", "O+", "O-", "AB+", "AB-"),
			"resistances" = null,
			"trace_chem" = null))
	update_appearance()

/obj/item/reagent_containers/blood/morphpack
	name = "\improper elite blood pack (full)"
	blood_type = null

/obj/item/reagent_containers/blood/morphpack/Initialize(mapload)
	. = ..()
	reagents.add_reagent(/datum/reagent/toxin/chloralhydrate, 10)
	reagents.add_reagent(/datum/reagent/medicine/morphine, 10)
	reagents.add_reagent(/datum/reagent/blood, 180,
		list("donor" = null,
			"viruses" = null,
			"blood_DNA" = null,
			"blood_type" = pick("A+", "A-", "B+", "B-", "O+", "O-", "AB+", "AB-"),
			"resistances" = null,
			"trace_chem" = null))
	update_appearance()

/obj/item/reagent_containers/blood/methpack
	name = "\improper elite blood pack (full)"
	blood_type = null

/obj/item/reagent_containers/blood/methpack/Initialize(mapload)
	. = ..()
	reagents.add_reagent(/datum/reagent/drug/methamphetamine, 15)
	reagents.add_reagent(/datum/reagent/blood, 185,
		list("donor" = null,
			"viruses" = null,
			"blood_DNA" = null,
			"blood_type" = pick("A+", "A-", "B+", "B-", "O+", "O-", "AB+", "AB-"),
			"resistances" = null,
			"trace_chem" = null))
	update_appearance()
