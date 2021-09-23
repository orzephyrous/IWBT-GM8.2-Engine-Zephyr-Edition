///scrSaveGame(saveposition)
///saves the game
///argument0 - sets whether the game should save the player's current location or just save the deaths/time

var savePosition;
savePosition = argument0;

//save the player's current location variables if the script is currently set to (we don't want to save the player's location if we're just updating death/time)
if (savePosition)
{
    global.saveRoom = room_get_name(room);
    global.savePlayerX = objPlayer.x;
    global.savePlayerY = objPlayer.y;
    global.savePlayerXscale = objPlayer.xScale;
    global.saveGrav = global.grav;
    global.saveDotkid = global.dotkid;
    global.saveSkin = global.playerSkin;

    //check if player is saving inside of a wall or in the ceiling when the player's position is floored to prevent save locking
    with (objPlayer)
    {
        if (!place_free(floor(global.savePlayerX),global.savePlayerY))
        {
            global.savePlayerX += 1;
        }

        if (!place_free(global.savePlayerX,floor(global.savePlayerY)))
        {
            global.savePlayerY += 1;
        }

        if (!place_free(floor(global.savePlayerX),floor(global.savePlayerY)))
        {
            global.savePlayerX += 1;
            global.savePlayerY += 1;
        }
    }

    //floor player position to match standard engine behavior
    global.savePlayerX = floor(global.savePlayerX);
    global.savePlayerY = floor(global.savePlayerY);

    var i;
    for (i = 0; i < global.secretItemTotal; i+=1)
    {
        global.saveSecretItem[i] = global.secretItem[i];
    }

    var i;
    for (i = 0; i < global.bossItemTotal; i+=1)
    {
        global.saveBossItem[i] = global.bossItem[i];
    }

    global.saveGameClear = global.gameClear;
}

//create a map for save data
var saveMap;
saveMap = ds_map_create();

ds_map_add(saveMap,"death",global.death);
ds_map_add(saveMap,"time",global.time);
ds_map_add(saveMap,"timeMicro",global.timeMicro);

ds_map_add(saveMap,"difficulty",global.difficulty);
ds_map_add(saveMap,"saveRoom",global.saveRoom);
ds_map_add(saveMap,"savePlayerX",global.savePlayerX);
ds_map_add(saveMap,"savePlayerY",global.savePlayerY);
ds_map_add(saveMap,"savePlayerXscale",global.savePlayerXscale);
ds_map_add(saveMap,"saveGrav",global.saveGrav);
ds_map_add(saveMap,"saveDotkid",global.saveDotkid);
ds_map_add(saveMap,"saveSkin",global.saveSkin)

var i;
for (i = 0; i < global.secretItemTotal; i+=1)
{
    ds_map_add(saveMap,"saveSecretItem["+string(i)+"]",global.saveSecretItem[i]);
}

var i;
for (i = 0; i < global.bossItemTotal; i+=1)
{
    ds_map_add(saveMap,"saveBossItem["+string(i)+"]",global.saveBossItem[i]);
}

ds_map_add(saveMap,"saveGameClear",global.saveGameClear);

var b;
b = buffer_create();

buffer_write_hex(b,ds_map_write(saveMap));
if (global.password != "") buffer_rc4(b,global.password);
buffer_save(b,"save"+string(global.savenum));

buffer_destroy(b);

//destroy the map
ds_map_destroy(saveMap);
