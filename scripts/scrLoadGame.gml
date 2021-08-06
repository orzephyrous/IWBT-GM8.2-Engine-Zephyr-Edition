///scrLoadGame(loadfile)
///loads the game
///argument0 - sets whether or not to read the save file when loading the game

var loadFile;
loadFile = argument0;

//only load save data from the save file if the script is currently set to (we should only need to load these on first load because the game stores them afterwards)
if (loadFile)
{
    //load the save map
    var saveMap;

    saveMap = ds_map_create();
    b = buffer_create();
    buffer_load(b,"save"+string(global.savenum));
    if (global.password!="") buffer_rc4(b,global.password);
    ds_map_read(saveMap,buffer_read_hex(b,buffer_get_size(b)));
    buffer_destroy(b);

    var saveValid;
    saveValid = true;   //keeps track of whether or not the save being loaded is valid

    if (saveMap != -1)  //check if the save map loaded correctly
    {
        global.death = ds_map_find_value(saveMap,"death");
        global.time = ds_map_find_value(saveMap,"time");
        global.timeMicro = ds_map_find_value(saveMap,"timeMicro");

        global.difficulty = ds_map_find_value(saveMap,"difficulty");
        global.saveRoom = ds_map_find_value(saveMap,"saveRoom");
        global.savePlayerX = ds_map_find_value(saveMap,"savePlayerX");
        global.savePlayerY = ds_map_find_value(saveMap,"savePlayerY");
        global.saveGrav = ds_map_find_value(saveMap,"saveGrav");

        if (is_string(global.saveRoom))   //check if the saved room loaded properly
        {
            variable_local_set(global.saveRoom, -1); //used to determine whether the resource name exists
            saveValid = execute_string("if (" + global.saveRoom + " != -1) { if (!room_exists(" + global.saveRoom + ")) return false; else return true; } else { return false; }");  //check if the room index in the save is valid
        }
        else
        {
            saveValid = false;
        }

        var i;
        for (i = 0; i < global.secretItemTotal; i+=1)
        {
            global.saveSecretItem[i] = ds_map_find_value(saveMap,"saveSecretItem["+string(i)+"]");
        }

        var i;
        for (i = 0; i < global.bossItemTotal; i+=1)
        {
            global.saveBossItem[i] = ds_map_find_value(saveMap,"saveBossItem["+string(i)+"]");
        }

        global.saveGameClear = ds_map_find_value(saveMap,"saveGameClear");

        //destroy the map
        ds_map_destroy(saveMap);
    }
    else
    {
        //save map didn't load correctly, set the save to invalid
        saveValid = false;
    }

    if (!saveValid) //check if the save is invalid
    {
        //save is invalid, restart the game

        show_message("Save invalid!");

        scrRestartGame();

        exit;
    }
}

//set game variables and set the player's position

with (objPlayer) //destroy player if it exists
    instance_destroy();

global.gameStarted = true;  //sets game in progress (enables saving, restarting, etc.)
global.noPause = false;     //disable no pause mode
global.autosave = false;    //disable autosaving since we're loading the game

global.grav = global.saveGrav;

var i;
for (i = 0; i < global.secretItemTotal; i+=1)
{
    global.secretItem[i] = global.saveSecretItem[i];
}

var i;
for (i = 0; i < global.bossItemTotal; i+=1)
{
    global.bossItem[i] = global.saveBossItem[i];
}

global.gameClear = global.saveGameClear;

instance_create(global.savePlayerX,global.savePlayerY,objPlayer);

execute_string("room_goto("+global.saveRoom+");");
