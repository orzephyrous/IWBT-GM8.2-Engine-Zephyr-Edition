///restarts the game

if (surface_exists(global.pauseSurf))
    surface_free(global.pauseSurf);  //free pause surface in case the game is currently paused

if instance_exists(objPlayer) instance_destroy_id(objPlayer);
scrInitializeGlobals();
scrLoadConfig();
room_goto(rTitle);
//game_restart();
