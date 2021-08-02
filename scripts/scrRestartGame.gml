///restarts the game

if (background_exists(global.pauseBg))
    background_delete(global.pauseBg);  //delete pause background in case the game is currently paused

if instance_exists(objPlayer) instance_destroy_id(objPlayer);
scrInitializeGlobals();
scrLoadConfig();
room_goto(rTitle);
//game_restart();
