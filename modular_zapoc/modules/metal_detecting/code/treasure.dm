#define LOOT_TYPE_GENERIC "generic" // Randomly generated, random price

#define LOOT_TYPE_FAKE "fake" // Randomly generated, can't sell
#define LOOT_TYPE_FAKE_COST_MAX 5
#define LOOT_TYPE_CHEAP "cheap" // Randomly generated, low price
#define LOOT_TYPE_CHEAP_COST_MAX 250
#define LOOT_TYPE_MEDIUM "medium" // Randomly generated, medium price
#define LOOT_TYPE_MEDIUM_COST_MAX 500
#define LOOT_TYPE_RICH "rich" // Randomly generated, high price
#define LOOT_TYPE_RICH_COST_MAX 1000
#define LOOT_TYPE_ULTRARICH "ultra" // Randomly generated, ultrahigh price
#define LOOT_TYPE_ULTRARICH_COST_MAX 2500

#define LOOT_TYPE_BOOK "book" // Ancient books, how exciting!
#define LOOT_TYPE_FOSSIL "fossil" // Your bones.
#define LOOT_TYPE_SHERD "sherd" // Pottery etc.
#define LOOT_TYPE_ARCHEO "archeology" // Books, fossils, sherds

#define LOOT_TYPE_SUPERNATURAL_GENERIC "supernatural" // Any supernatural stuff
#define LOOT_TYPE_KINDRED "kindred" // Vampire stuff
#define LOOT_TYPE_ARTIFACT "artifact" // i.e. odious chalice, mummywrap fetish, etc.
#define LOOT_TYPE_FERA "fera" // Fera stuff

#define LOOT_TYPE_OMNI "omni" // Anything

/obj/item/treasure
	name = "treasure"
	icon_state = "skub"
	desc = "Yarrrrr. If ye' be seein' this, anchor yerself at port an' fill th' ears of a code monkey with yer tale!"
	var/loot_type = LOOT_TYPE_GENERIC

/obj/item/treasure/Initialize()
	. = ..()
	name = generate_treasure_name()
//	desc = generate_treasure_desc() // Rimworld art desc core eventually
	cost = generate_treasure_cost()

/obj/item/treasure/proc/generate_treasure_name()
	var/t_adj = pick(GLOB.treasure_adjectives)
	var/t_noun = pick(GLOB.treasure_nouns)
	var/t_obj = pick(GLOB.trasure_objects)

	var/generated_name = name

	if(prob(25))
		generated_name = "[t_adj] [t_noun] [t_obj]"
	else if(prob(33))
		generated_name = "[t_adj] [t_obj]"
	else if(prob(50))
		generated_name = "[t_noun] [t_obj]"
	else
		generated_name = "[t_obj]"
	if(prob(50))
		generated_name = "\proper[generated_name]"

	return generated_name

/obj/item/treasure/proc/generate_treasure_cost()
	var/generated_cost
	switch(loot_type)
		if(LOOT_TYPE_GENERIC)
			generated_cost = rand(0, LOOT_TYPE_ULTRARICH_COST_MAX)
		if(LOOT_TYPE_FAKE)
			generated_cost = rand(0, LOOT_TYPE_FAKE_COST_MAX)
		if(LOOT_TYPE_CHEAP)
			generated_cost = rand(LOOT_TYPE_FAKE_COST_MAX, LOOT_TYPE_CHEAP_COST_MAX)
		if(LOOT_TYPE_MEDIUM)
			generated_cost = rand(LOOT_TYPE_CHEAP_COST_MAX, LOOT_TYPE_MEDIUM_COST_MAX)
		if(LOOT_TYPE_RICH)
			generated_cost = rand(LOOT_TYPE_MEDIUM_COST_MAX, LOOT_TYPE_RICH_COST_MAX)
		if(LOOT_TYPE_ULTRARICH)
			generated_cost = rand(LOOT_TYPE_RICH_COST_MAX, LOOT_TYPE_ULTRARICH_COST_MAX)

	return generated_cost

/obj/item/treasure/fake
	loot_type = LOOT_TYPE_FAKE

/obj/item/treasure/cheap
	loot_type = LOOT_TYPE_CHEAP

/obj/item/treasure/medium
	loot_type = LOOT_TYPE_MEDIUM

/obj/item/treasure/rich
	loot_type = LOOT_TYPE_RICH

/obj/item/treasure/ultrarich
	loot_type = LOOT_TYPE_ULTRARICH
