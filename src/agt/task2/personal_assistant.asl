// personal assistant agent 

//Rules
best_option(vibrating) :- rank(0) .
best_option(natural_light) :- rank(1).
best_option(artificial_light) :- rank(2).
rank(0).


/* Task 2 Start of your solution */

@upgrade_rank
+!upgrade_rank : true <-
    ?rank(Old);
    .print("old Rank", Old);
    !get_new_rank(Old, New);
    .print("new Rank", New);
    -rank(Old);
    +rank(New).


@get_new_rank
+!get_new_rank(Old, New): true <-
    New = ( Old + 1 ) mod 3.

@enable_natural_lights
+!action_needed : best_option(natural_light) <-
    raiseBlinds;
    .print("blind raising inferred");
    !upgrade_rank.

@enable_artificial_lights
+!action_needed : best_option(artificial_light) <-
    turnOnLights;
    !upgrade_rank.
    

@enable_vibrating
+!action_needed : best_option(vibrating) <-
    setVibrationsMode;
    !upgrade_rank.



@react_to_upcoming_event_now
+upcoming_event("now"): owner_state("awake") <-
    .print("enjoy your event");
    -upcoming_event("now").

@react_to_upcoming_event_now_still_sleeping
+upcoming_event("now"): owner_state("asleep") <-
    .print("starting wake-up routine");
    !wake_up.
    

@keep_waking_up_when_event_is_upcoming
+!wake_up : owner_state("asleep") & upcoming_event("now") <-
    .print("check for best option");
    !action_needed;
    !wake_up.

+!wake_up : true <-
    .print("I am awake now, thank you").

@react_awakening
+owner_state("awake"): true <- 
    .print("awake").

@react_asleep
+owner_state("asleep"): true <-
    .print("asleep").

@react_lights_on
+lights("on"): true <-
    .print("lights on").

@react_lights_of
+lights("off"): true <-
    .print("lights off").

@react_blinds_raised
+blinds("raised"): true <-
    .print("blinds raised").

@react_blinds_lowered
+blinds("lowered"): true <-
    .print("blinds lowered").

@react_matress_idle
+mattress("idle"): true <-
    .print("mattress idle").

@react_matress_vibrating
+mattress("vibrating"): true <-
    .print("mattress vibrating").

@react_awakening_gone
-owner_state("awake"): true <- 
    .print("not awake anymore").

@react_asleep_gone
-owner_state("asleep"): true <-
    .print("not asleep anymore").

@react_lights_on_gone
-lights("on"): true <-
    .print("lights not on anymore").

@react_lights_of_gone
-lights("off"): true <-
    .print("lights not off anymore").

@react_blinds_raised_gone
-blinds("raised"): true <-
    .print("blinds note raised anymore").

@react_blinds_lowered_gone
-blinds("lowered"): true <-
    .print("blinds not lowered anymore").

@react_matress_idle_gone
-mattress("idle"): true <-
    .print("mattress not idle anymore").

@react_matress_vibrating_gone
-mattress("vibrating"): true <-
    .print("mattress not vibrating anymore").




/* Task 2 End of your solution */

/* Import behavior of agents that work in CArtAgO environments */
{ include("$jacamoJar/templates/common-cartago.asl") }

