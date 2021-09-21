//kills the player

if (instance_exists(objPlayer) && (!global.noDeath && !global.debugNoDeath))
{
    if (global.gameStarted) //normal death
    {
        global.deathSound = "sndDeath";
        sound_play("sndDeath");

        with (objPlayer)
        {
            instance_create(x,y+8*global.grav*global.dotkid,objBloodEmitter);
            instance_destroy();
        }

        instance_create(0,0,objGameOver);

        global.death += 1; //increment deaths

        scrSaveGame(false); //save death/time
    }
    else    //death in the difficulty select room, restart the room
    {
        with(objPlayer)
            instance_destroy();

        room_restart();
    }
}
