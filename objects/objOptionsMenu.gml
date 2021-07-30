#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
select = global.menuSelectPrev[1];

xSelector = 124;
ySelector = 132;
xSeperation = 550;
ySeperation = 48;

optionsNum = 7; //sets number of separate options available

if (!global.controllerEnabled)  //remove controller settings menu if controllers are disabled
{
    optionsNum -= 1;
    ySelector += 32;
}

strSelect[0] = "Music";
strSelect[1] = "Volume Level";
strSelect[2] = "Screen Mode";
strSelect[3] = "Smoothing Mode";
strSelect[4] = "Vsync";
strSelect[5] = "Set Keyboard Controls";
//strSelect[6] = "Controller Options";

playerIndex = 0;
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
//animate player sprite
playerIndex = (playerIndex + 1/5) mod 4;

if (scrButtonCheckPressed(global.menuUpButton))
{
    sound_play(global.menuSound);
    select -= 1;
    if(select < 0)
        select = optionsNum-1;
}
else if (scrButtonCheckPressed(global.menuDownButton))
{
    sound_play(global.menuSound);
    select += 1;
    if(select > optionsNum-1)
        select = 0;
}
else if (scrButtonCheckPressed(global.menuBackButton))
{
    //save changes and go back
    scrSaveConfig();
    global.menuSelectPrev[1] = 0;
    room_goto(rMenu);
    exit;
}
else if (scrButtonCheckPressed(global.menuAcceptButton))
{
    if (select == 0)    //toggle mute music
    {
        scrToggleMusic();
    }
    else if (select == 2)   //toggle fullscreen
    {
        global.fullscreenMode = !global.fullscreenMode;

        window_set_fullscreen(global.fullscreenMode);
    }
    else if (select == 3)   //toggle smoothing mode
    {
        global.smoothingMode = !global.smoothingMode;
    }
    else if (select == 4)   //toggle vsync mode
    {
        global.vsyncMode = !global.vsyncMode;

        scrSetVsync();
    }
    else if (select == 5)   //go to the keyboard controls menu
    {
        scrSaveConfig();    //save changes
        global.menuSelectPrev[1] = select;
        instance_create(x,y,objKeyboardControlsMenu);
        instance_destroy();
        exit;
    }
    else if (select == 6)   //go to the controller options menu
    {
        scrSaveConfig();    //save changes
        global.menuSelectPrev[1] = select;
        instance_create(x,y,objControllerMenu);
        instance_destroy();
        exit;
    }
}


if (select == 1)
{
    if (scrButtonCheck(global.menuRightButton))  //raise volume
    {
        if (global.volumeLevel < 100)
            global.volumeLevel += 1;

        sound_global_volume(global.volumeLevel/100);  //set master gain
    }
    else if (scrButtonCheck(global.menuLeftButton))  //lower volume
    {
        if (global.volumeLevel > 0)
            global.volumeLevel -= 1;

        sound_global_volume(global.volumeLevel/100);  //set master gain
    }
}
#define Draw_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
draw_set_color(c_black);
draw_set_font(fDefault30);
draw_set_halign(fa_left);

var i;
for(i = 0; i < optionsNum; i+=1)
    draw_text(xSelector,ySelector+(ySeperation*i),strSelect[i]);

draw_set_halign(fa_right);

if (global.muteMusic)
    draw_text(xSelector+xSeperation,ySelector,"Off");
else
    draw_text(xSelector+xSeperation,ySelector,"On");

draw_text(xSelector+xSeperation,ySelector+ySeperation,string(global.volumeLevel) + "%");

if (global.fullscreenMode)
    draw_text(xSelector+xSeperation,ySelector+(ySeperation*2),"Fullscreen");
else
    draw_text(xSelector+xSeperation,ySelector+(ySeperation*2),"Windowed");

if (global.smoothingMode)
    draw_text(xSelector+xSeperation,ySelector+(ySeperation*3),"On");
else
    draw_text(xSelector+xSeperation,ySelector+(ySeperation*3),"Off");

if (global.vsyncMode)
    draw_text(xSelector+xSeperation,ySelector+(ySeperation*4),"On");
else
    draw_text(xSelector+xSeperation,ySelector+(ySeperation*4),"Off");

draw_sprite(sprPlayerIdle,playerIndex,xSelector-16,ySelector+(ySeperation*select)+26);

scrDrawButtonInfo(false);
