#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
///make sure we never have more than one world object

if (instance_number(object_index) > 1)
    instance_destroy();

gameclosing=0
closingvol=1
closingk=0
#define Alarm_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
///pause current music when it's done fading out

sound_pause(global.currentMusic);
#define Alarm_1
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
///return to previous window position/size (after using display_reset)

if (!window_get_fullscreen())
{
    window_set_position(global.windowXPrev,global.windowYPrev);
    window_set_size(global.windowWidthPrev,global.windowHeightPrev);
}
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
///closing animation
if (gameclosing)
{
    closingvol=max(0,closingvol*0.9);
    global.volumeLevel = closingvol*global.volumeLevel;
    sound_global_volume(global.volumeLevel);
    if (closingvol<=0.025) game_end();

    closingk=!closingk
    if (closingk)
    {
        window_set_region_scale(1,1);
        window_set_region_size(view_wview[0],ceil(view_hview[0]*sqr(closingvol)),1);
        window_center();
    }

    draw_clear(merge_color(0,$ffffff,1-closingvol));
    window_set_color(merge_color(0,$ffffff,1-closingvol));
    screen_refresh();

    exit;
}
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
///game checks


//set linear interpolation depending on what the current smoothing setting is
texture_set_interpolation(global.smoothingMode);

if (global.gameStarted)
{
    //handle pausing
    if (global.pauseDelay <= 0) //check if pause delay is active
    {
        if (scrButtonCheckPressed(global.pauseButton))
        {
            if (!global.gamePaused)  //game currently not paused, pause the game
            {
                if (instance_exists(objPlayer) && !global.noPause)
                {
                    global.gamePaused = true;  //set the game to paused
                    global.pauseDelay = global.pauseDelayLength; //set pause delay

                    instance_deactivate_all(true);  //deactivate everything

                    global.pauseBg = background_create_from_screen(0,0,view_wview[0],view_hview[0],0,0); //create screenshot background
                }
            }
            else    //game currently paused, unpause the game
            {
                global.gamePaused = false;  //set the game to unpaused
                global.pauseDelay = global.pauseDelayLength;     //set pause delay

                instance_activate_all();    //reactivate objects

                if (background_exists(global.pauseBg))
                    background_delete(global.pauseBg);         //delete the pause background

                scrSaveConfig();    //save config in case volume levels were changed

                io_clear(); //clear input states to prevent possible pause strats/exploits
            }
        }
    }
    else
    {
        global.pauseDelay -= 1;
    }

    if (!global.gamePaused) //check if the game is currently paused
    {
        if (scrButtonCheckPressed(global.restartButton))
        {
            //stop death sound/music
            if global.deathSound!="" sound_stop(global.deathSound);
            if global.gameOverMusic!="" sound_stop(global.gameOverMusic);

            //resume room music
            //if global.currentMusic!="" sound_resume(global.currentMusic);

            ///return to old gain if music is being faded out
            if (global.musicFading)
            {
                global.musicFading = false;
                if global.currentMusic!="" sound_volume(global.currentMusic,global.currentGain);
                alarm[0] = -1;   //reset alarm that pauses music
            }

            scrSaveGame(false); //save death/time
            scrLoadGame(false); //load the game
        }

        if ((global.timeWhenDead || instance_exists(objPlayer)) && (global.timeWhenClear || !global.gameClear))  //increment timer
        {
            global.timeMicro += 1;
            global.time += global.timeMicro div 50;
            global.timeMicro = global.timeMicro mod 50;
        }
    }
    else    //game is paused, check for volume controls
    {
        if (scrButtonCheck(global.upButton))
        {
            if (global.volumeLevel < 100)
                global.volumeLevel += 1;
        }
        else if (scrButtonCheck(global.downButton))
        {
            if (global.volumeLevel > 0)
                global.volumeLevel -= 1;
        }

        sound_global_volume(global.volumeLevel/100);  //set master gain
    }

    scrSetRoomCaption();    //keep caption updated
}
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
///debug keys

if (global.debugMode && global.gameStarted && !global.gamePaused)
{
    if (keyboard_check(vk_tab))             //drags player with mouse
    {
        with (objPlayer)
        {
            x = mouse_x;
            y = mouse_y;
        }
    }
    if (keyboard_check_pressed(vk_backspace))   //toggles debug overlay
    {
        global.debugOverlay = !global.debugOverlay;
    }
    if (keyboard_check_pressed(vk_insert))  //saves game
    {
        with (objPlayer)
        {
            scrSaveGame(true);
            sound_play("sndItem");
        }
    }
    if (keyboard_check_pressed(vk_delete))  //toggles showing the hitbox
    {
        global.debugShowHitbox = !global.debugShowHitbox;
    }
    if (keyboard_check_pressed(vk_home))    //toggles god mode
    {
        global.debugNoDeath = !global.debugNoDeath;
    }
    if (keyboard_check_pressed(vk_end))     //toggles infinite jump
    {
        global.debugInfJump = !global.debugInfJump;
    }
    if (keyboard_check_pressed(vk_pageup) && room != room_last)  //goes to next room
    {
        with (objPlayer)
            instance_destroy();

        room_goto_next();
    }
    if (keyboard_check_pressed(vk_pagedown) && room != room_first)    //goes to previous room
    {
        with (objPlayer)
            instance_destroy();

        room_goto_previous();
    }
}

if (global.debugVisuals)
{
    with (objPlayer)    //sets appearance of the player to show god mode/infinite jump
    {
        if (global.debugNoDeath)     //makes player slightly transparent when god mode is on
            image_alpha = 0.7;
        else
            image_alpha = 1;

        if (global.debugInfJump)     //makes player turn blue when infinite jump is on
            image_blend = c_blue;
        else
            image_blend = c_white;
    }
}
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
///function keys

if (keyboard_check_pressed(vk_escape) || (keyboard_check_pressed(vk_alt) && keyboard_check_pressed(vk_f4)))
{
    event_user(1);    //game ends
}

if (keyboard_check_pressed(vk_f2))
{
    scrRestartGame();
    exit;
}

if (keyboard_check_pressed(vk_f4) && !global.gamePaused)    //toggle fullscreen mode
{
    global.fullscreenMode = !global.fullscreenMode;

    window_set_fullscreen(global.fullscreenMode);

    scrSaveConfig();    //save fullscreen setting
}

if (keyboard_check_pressed(vk_f5) && !global.gamePaused)    //reset window size
{
    scrResetWindowSize();
}

if (keyboard_check(vk_control) && keyboard_check_pressed(ord("M")) && !global.gamePaused)
{
    //toggle mute music setting
    scrToggleMusic();

    scrSaveConfig();    //save mute setting
}

if keyboard_check_pressed(vk_f9)
{
    //screen capture
    screen_num = 1
    while true
    {
        filename = "screenshot_"+string(screen_num)+".png";
        if !file_exists(filename)
        {
            screen_save(filename);
            break;
        }
        else
        {
            screen_num += 1;
        }
    }
}
#define Other_2
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
///initialize everything

//load music in "data"
scrLoadMusic();

//initialize all variables
scrInitializeGlobals();

//load the current config file, sets default config if it doesn't exist
scrLoadConfig();

room_goto_next();
#define Other_4
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
///room checks

if (!instance_exists(objPlayMusic))  //make sure the play music object isn't in the current room
    scrGetMusic();  //find and play the proper music for the current room

room_speed = 50;    //make sure game is running at the correct frame rate
scrSetRoomCaption();    //make sure window caption stays updated
#define Other_10
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
///fade current music out
global.musicFading = true;
sound_fade(global.currentMusic,0,50);                       //fade out music over 1 second

alarm[0] = 50;  //pause music when it's done fading
#define Other_11
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
/// closing animation
if (!gameclosing)
{
    gameclosing = 1;
    if (global.closingAnimation && !window_get_fullscreen())
    {
        window_set_showborder(0);
        set_automatic_draw(0);
        set_synchronization(0);
        instance_deactivate_all(1);
    } else {
        game_end();
    }
}
#define Draw_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
///draw debug overlay

if (global.debugOverlay)
{
    draw_set_color(c_black);
    draw_set_halign(fa_left);
    draw_set_font(fDefault12);

    var drawX, drawY, drawAlign;
    drawX = 0;
    drawY = 0;
    drawAlign = 0;
    if (instance_exists(objPlayer))
    {
        drawX = objPlayer.x;
        drawY = objPlayer.y;
        drawAlign = objPlayer.x mod 3;
    }

    scrDrawTextOutline(20,20,"X: "+string(drawX),c_black,c_white);
    scrDrawTextOutline(20,40,"Y: "+string(drawY),c_black,c_white);
    scrDrawTextOutline(20,60,"Align: "+string(drawAlign),c_black,c_white);
    scrDrawTextOutline(20,80,"Room name: "+room_get_name(room),c_black,c_white);
    scrDrawTextOutline(20,100,"Room number: "+string(room),c_black,c_white);
    scrDrawTextOutline(20,120,"God mode: "+string(global.debugNoDeath),c_black,c_white);
    scrDrawTextOutline(20,140,"Infinite jump: "+string(global.debugInfJump),c_black,c_white);
    scrDrawTextOutline(20,160,"FPS: "+string(fps),c_black,c_white);
    scrDrawTextOutline(20,180,"Real FPS: "+string(fps_real),c_black,c_white);
}
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
///draw pause screen

if (global.gamePaused)  //check if game is paused to draw the pause screen
{
    draw_clear(c_black);

    if (background_exists(global.pauseBg))       //check if surface exists before drawing it
        draw_background(global.pauseBg,0,0);

    draw_set_color(c_black);
    draw_set_alpha(0.4);

    draw_rectangle(view_xview[0],view_yview[0],view_xview[0]+view_wview[0],view_yview[0]+view_hview[0],0);    //darken the paused screen

    draw_set_alpha(1);

    draw_set_color(c_white);

    draw_set_halign(fa_center);
    draw_set_font(fDefault30);

    //draw_text(view_xview[0] + (view_wview[0]/2),view_yview[0] + (view_hview[0]/2) - 24,"PAUSE");
    draw_sprite(sprPause, -1, view_xview[0] + view_wview[0]/2, view_yview[0] + view_hview[0]/2)

    draw_set_halign(fa_left);
    draw_set_font(fDefault18);

    var t,timeText;
    t = global.time;
    timeText = string(t div 3600) + ":";
    t = t mod 3600;
    timeText += string(t div 600);
    t = t mod 600;
    timeText += string(t div 60) + ":";
    t = t mod 60;
    timeText += string(t div 10);
    t = t mod 10;
    timeText += string(floor(t));

    draw_text(view_xview[0] + 20,view_yview[0] + 516,"Volume: " + string(global.volumeLevel) + "%");
    draw_text(view_xview[0] + 20,view_yview[0] + 541,"Deaths: " + string(global.death));
    draw_text(view_xview[0] + 20,view_yview[0] + 566,"Time: " + timeText);
}
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
///draw debug mode text when we're on the title screen

if (global.debugMode && room == rTitle)
{
    draw_set_color(c_red);
    draw_set_font(fDefault12);
    draw_set_halign(fa_left);

    draw_text(34,34,"Debug mode");
}
