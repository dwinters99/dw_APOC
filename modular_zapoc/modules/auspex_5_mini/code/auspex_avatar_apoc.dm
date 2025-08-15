/mob/dead/observer/avatar/
	var/returning = FALSE // Are we recalling right now?
	var/stuck = FALSE
	var/stuck_safety = 0
	sound_environment_override = SOUND_ENVIRONMENT_DRUGGED

/mob/dead/observer/avatar/Move(NewLoc)
	var/mob/living/carbon/human/H = mind.current

	if(stuck_safety <= 10)
	if(get_dist(NewLoc, get_turf(H)) >= 23) // How are we so far away?
		to_chat(src, span_warning("Your connection to your physical form weakens, forcing to recenter yourself."))
		finalize_reenter_corpse()
		return FALSE

	if(get_dist(NewLoc, get_turf(H)) >= 22) // Skip movement if we're too far
		to_chat(src, span_warning("Your connection to your physical form weakens, preventing you from moving any further!"))
		stuck = TRUE
		stuck_safety++
		return FALSE

	stuck = FALSE

	..()

	var/dist_mod = get_dist(loc, H.loc)

//	to_chat(src, span_cult("[dist_mod]"))

	overlay_fullscreen("auspex_block", /atom/movable/screen/fullscreen/auspex, 1) // Don't change severity unless you want to make a new icon for the fullscreen!
	var/atom/movable/screen/fullscreen/S = screens["auspex_block"]

	if(dist_mod == 21) // 255 / 21 = 12.1428671429. Yeah, this is probably better.
		S.alpha = 255
	else
		S.alpha = round(dist_mod*12)


	if(prob(0.1)) // || src.loc.area.protected == TRUE) // This is for later and probably won't be implemented this way
		to_chat(src, span_warning("Your concentration lapses..."))
		if(!(SSroll.storyteller_roll(H.get_total_mentality(), difficulty = 6, mobs_to_show_output = null) == ROLL_SUCCESS))
			playsound(src, 'modular_zapoc/modules/auspex_5_mini/sound/avatar_cancel.ogg', 10, ignore_walls = TRUE) // Alert others of the peeping tom
			to_chat(src, span_boldwarning("...revealing your presence!"))
		else
			to_chat(src, span_notice("...but you manage to regain your focus."))

	if(get_turf(src) == get_turf(mind.current.loc) && returning) // Stop moving and reenter corpse if we're on top of ourselves. No effect unless reenter_corpse() is running.
		walk(src, 0)
		finalize_reenter_corpse()
		returning = FALSE


/mob/dead/observer/avatar/proc/finalize_reenter_corpse()
	var/mob/living/carbon/human/original_body = mind.current

	client.view_size.setDefault(getScreenSize(client.prefs.widescreenpref))//Let's reset so people can't become allseeing gods
	SStgui.on_transfer(src, mind.current)
	mind.current.key = key
	mind.current.client.init_verbs()
	original_body.soul_state = SOUL_PRESENT
	returning = FALSE


/mob/dead/observer/avatar/reenter_corpse()
	if(!client)
		return FALSE
	if(!mind || QDELETED(mind.current))
		to_chat(src, span_warning("You have no body."))
		return FALSE
	if(!can_reenter_corpse)
		to_chat(src, span_warning("You cannot re-enter your body."))
		return FALSE

	var/mob/living/carbon/human/original_body = mind.current
	var/turf/current_turf = get_turf(src)
	var/turf/body_turf = get_turf(original_body)

	if(isnull(body_turf) || isnull(current_turf))
		return FALSE
	if(returning) // First line in this proc tha is different than the auspex_avatar.dm version
		walk(src, 0) // Cancel recall
		to_chat(src, span_warning("You force your mind's eye to dig in it's psychic heels, cancelling the recall."))
		returning = FALSE
		return FALSE
	if(mind.current.key && mind.current.key[1] != "@")	// makes sure we don't accidentally kick any clients
		to_chat(usr, span_warning("Another consciousness is in your body...It is resisting you."))
		return FALSE
	if(!(body_turf.z == current_turf.z))
		to_chat(src, span_warning("Your physical form is on a different level of reality."))
		return FALSE
	if(!(body_turf == current_turf))
		returning = TRUE
		walk_to(src, body_turf, 0) // Start recall
		to_chat(src, span_warning("Your physical form begins to recall your mind's eye..."))
		to_chat(src, span_notice("Click Reenter corpse again to cancel."))
		SEND_SOUND(src, 'modular_zapoc/modules/auspex_5_mini/sound/avatar_cancel.ogg')
		return FALSE
	else
		finalize_reenter_corpse()

	return TRUE
