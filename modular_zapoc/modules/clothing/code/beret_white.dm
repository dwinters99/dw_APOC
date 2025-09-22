/obj/item/clothing/head/beret/colorable
	name = "beret"
	desc = "A beret. For bringing out your inner French."
	icon = 'modular_zapoc/modules/clothing/icons/white_beret.dmi'
	worn_icon = 'modular_zapoc/modules/clothing/icons/white_beret_worn.dmi'
	icon_state = "beret_white"
	MAP_SWITCH(greyscale_colors = "#FFFFFF", color = "#FFFFFF")
	var/original_color = "#FFFFFF"
	var/recolored = FALSE

/obj/item/clothing/head/beret/colorable/AltClick(mob/user)
	. = ..()
	recolor_prompt(user)

/obj/item/clothing/head/beret/colorable/proc/recolor_prompt(mob/user)
	if(!recolored)
		var/list/choices = list("Gray", "White", "Black", "Red", "Dark Red", "Orange", "Yellow", "Light Green", "Green", "Aquamarine", "Light Blue", "Blue", "Dark Blue", "Purple", "Pink", "Light Brown", "Brown")

		var/user_input = tgui_input_list(user, "Choose a color", "[src]", choices)
		switch(user_input)
			if("Gray")
				greyscale_colors = "#C4B8B3"
			if("White")
				greyscale_colors = "#FFFFFF"
			if("Black")
				greyscale_colors = "#3F3C40"
			if("Red")
				greyscale_colors = "#972A2A"
			if("Dark Red")
				greyscale_colors = "#7F0000"
			if("Orange")
				greyscale_colors = "#BF4900"
			if("Yellow")
				greyscale_colors = "#FFBC30"
			if("Light Green")
				greyscale_colors = "#5FAD20"
			if("Green")
				greyscale_colors = "#3E7C44"
			if("Aquamarine")
				greyscale_colors = "#91CCB8"
			if("Light Blue")
				greyscale_colors = "#76CADB"
			if("Blue")
				greyscale_colors = "#6885AD"
			if("Purple")
				greyscale_colors = "#8D008F"
			if("Pink")
				greyscale_colors = "#F2B6AA"
			if("Light Brown")
				greyscale_colors = "#BF845A"
			if("Brown")
				greyscale_colors = "#996145"

		var/confirm = tgui_alert(user, "Is this the color you want?", "[src]", list("Yes"))

		if(confirm == "Yes")
			recolored = TRUE
		else
			greyscale_colors = original_color

/obj/item/clothing/head/beret/colorable/precolored
	recolored = TRUE

/obj/item/clothing/head/beret/colorable/precolored/gray
	MAP_SWITCH(greyscale_colors = "#C4B8B3", color = "#C4B8B3")

/obj/item/clothing/head/beret/colorable/precolored/black
	MAP_SWITCH(greyscale_colors = "#3F3C40", color = "#3F3C40")

/obj/item/clothing/head/beret/colorable/precolored/red
	MAP_SWITCH(greyscale_colors = "#972A2A", color = "#972A2A")

/obj/item/clothing/head/beret/colorable/precolored/darkred
	MAP_SWITCH(greyscale_colors = "#7F0000", color = "#7F0000")

/obj/item/clothing/head/beret/colorable/precolored/orange
	MAP_SWITCH(greyscale_colors = "#BF4900", color = "#BF4900")

/obj/item/clothing/head/beret/colorable/precolored/yellow
	MAP_SWITCH(greyscale_colors = "#FFBC30", color = "#FFBC30")

/obj/item/clothing/head/beret/colorable/precolored/lightgreen
	MAP_SWITCH(greyscale_colors = "#5FAD20", color = "#5FAD20")

/obj/item/clothing/head/beret/colorable/precolored/green
	MAP_SWITCH(greyscale_colors = "#3E7C44", color = "#3E7C44")

/obj/item/clothing/head/beret/colorable/precolored/aquamarine
	MAP_SWITCH(greyscale_colors = "#91CCB8", color = "#91CCB8")

/obj/item/clothing/head/beret/colorable/precolored/lightblue
	MAP_SWITCH(greyscale_colors = "#76CADB", color = "#76CADB")

/obj/item/clothing/head/beret/colorable/precolored/blue
	MAP_SWITCH(greyscale_colors = "#6885AD", color = "#6885AD")

/obj/item/clothing/head/beret/colorable/precolored/purple
	MAP_SWITCH(greyscale_colors = "#8D008F", color = "#8D008F")

/obj/item/clothing/head/beret/colorable/precolored/pink
	MAP_SWITCH(greyscale_colors = "#F2B6AA", color = "#F2B6AA")

/obj/item/clothing/head/beret/colorable/precolored/lightbrown
	MAP_SWITCH(greyscale_colors = "#BF845A", color = "#BF845A")

/obj/item/clothing/head/beret/colorable/precolored/brown
	MAP_SWITCH(greyscale_colors = "#996145", color = "#996145")
