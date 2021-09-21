var/debug_area_counter = 0
var/debug_turf_counter = 0
var/debug_mob_counter = 0
var/debug_obj_counter = 0

area
    New()
        ..()
        debug_area_counter++
    
    Del()
        ..()
        debug_area_counter--

turf
    New()
        ..()
        debug_turf_counter++
    
    Del()
        ..()
        debug_turf_counter--

mob
    New()
        ..()
        debug_mob_counter++
    
    Del()
        ..()
        debug_mob_counter--

obj
    New()
        ..()
        debug_obj_counter++
    
    Del()
        ..()
        debug_obj_counter--