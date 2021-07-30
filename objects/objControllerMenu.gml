#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
/*
select = 0;
xSelector = 120;
ySelector = 24;
xSeperation = 560;
ySeperation = 40;

settingButton = false;     //sets whether or not a button is getting set
resetPrompt = false;    //shows the message that controls were reset

strSelect[0] = "Controller Index";
strSelect[1] = "Left Button";
strSelect[2] = "Right Button";
strSelect[3] = "Up Button";
strSelect[4] = "Down Button";
strSelect[5] = "Jump Button";
strSelect[6] = "Shoot Button";
strSelect[7] = "Restart Button";
strSelect[8] = "Skip Button";
strSelect[9] = "Suicide Button";
strSelect[10] = "Pause Button";
strSelect[11] = "Reset Controls";

//get current controls
strButton[0] = string(global.controllerIndex);
strButton[1] = scrGetControllerBind(global.leftButton[1]);
strButton[2] = scrGetControllerBind(global.rightButton[1]);
strButton[3] = scrGetControllerBind(global.upButton[1]);
strButton[4] = scrGetControllerBind(global.downButton[1]);
strButton[5] = scrGetControllerBind(global.jumpButton[1]);
strButton[6] = scrGetControllerBind(global.shootButton[1]);
strButton[7] = scrGetControllerBind(global.restartButton[1]);
strButton[8] = scrGetControllerBind(global.skipButton[1]);
strButton[9] = scrGetControllerBind(global.suicideButton[1]);
strButton[10] = scrGetControllerBind(global.pauseButton[1]);
strButton[11] = "";

if (strButton[0] == "-1") strButton[0] = "Disabled";

playerIndex = 0;
#define Alarm_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
/*resetPrompt = false;
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
/*
//animate player sprite
playerIndex = (playerIndex + 1/5) mod 4;

if (!settingButton)
{
    if (scrButtonCheckPressed(global.menuUpButton))
    {
        sound_play(global.menuSound);
        select -= 1;
        if(select < 0)
            select = 11;
    }
    else if (scrButtonCheckPressed(global.menuDownButton))
    {
        sound_play(global.menuSound);
        select += 1;
        if(select > 11)
            select = 0;
    }
    else if (scrButtonCheckPressed(global.menuBackButton))
    {
        scrSaveConfig();    //save changes
        instance_create(x,y,objOptionsMenu);
        instance_destroy();
    }
    else if (scrButtonCheckPressed(global.menuAcceptButton))
    {
        if (select != 0)
        {
            if (select != 11)
            {
                settingButton = true;
            }
            else
            {
                //default controls
                global.leftButton[1] = gp_padl;
                global.rightButton[1] = gp_padr;
                global.upButton[1] = gp_padu;
                global.downButton[1] = gp_padd;
                global.jumpButton[1] = gp_face1;
                global.shootButton[1] = gp_face3;
                global.restartButton[1] = gp_face4;
                global.skipButton[1] = gp_face2;
                global.suicideButton[1] = gp_select;
                global.pauseButton[1] = gp_start;

                resetPrompt = true;
                alarm[0] = 60;
            }
        }
    }

    //change controller index
    if (select == 0)
    {
        if (scrButtonCheckPressed(global.menuRightButton))
        {
            global.controllerIndex += 1;
            if (global.controllerIndex > 11)
                global.controllerIndex = -1;
        }
        else if (scrButtonCheckPressed(global.menuLeftButton))
        {
            global.controllerIndex -= 1;
            if (global.controllerIndex < -1)
                global.controllerIndex = 11;
        }
    }
}
else
{
    var buttonChange;
    buttonChange = scrAnyControllerButton();
    if (buttonChange != -1)  //check if a button is being pressed and if it is, store that button
    {
        if (select == 1) {global.leftButton[1] = buttonChange;}
        else if (select == 2) {global.rightButton[1] = buttonChange;}
        else if (select == 3) {global.upButton[1] = buttonChange;}
        else if (select == 4) {global.downButton[1] = buttonChange;}
        else if (select == 5) {global.jumpButton[1] = buttonChange;}
        else if (select == 6) {global.shootButton[1] = buttonChange;}
        else if (select == 7) {global.restartButton[1] = buttonChange;}
        else if (select == 8) {global.skipButton[1] = buttonChange;}
        else if (select == 9) {global.suicideButton[1] = buttonChange;}
        else if (select == 10) {global.pauseButton[1] = buttonChange;}

        settingButton = false;
    }
    else if (keyboard_check_pressed(vk_anykey))    //check if a keybord key was pressed, exit prompt
    {
        settingButton = false;
    }
}

//update controls
strButton[0] = string(global.controllerIndex);
strButton[1] = scrGetControllerBind(global.leftButton[1]);
strButton[2] = scrGetControllerBind(global.rightButton[1]);
strButton[3] = scrGetControllerBind(global.upButton[1]);
strButton[4] = scrGetControllerBind(global.downButton[1]);
strButton[5] = scrGetControllerBind(global.jumpButton[1]);
strButton[6] = scrGetControllerBind(global.shootButton[1]);
strButton[7] = scrGetControllerBind(global.restartButton[1]);
strButton[8] = scrGetControllerBind(global.skipButton[1]);
strButton[9] = scrGetControllerBind(global.suicideButton[1]);
strButton[10] = scrGetControllerBind(global.pauseButton[1]);
strButton[11] = "";

if (strButton[0] == "-1") strButton[0] = "Disabled";
#define Draw_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
/*
draw_set_color(c_black);
draw_set_font(fDefault24);

var i;
for(i = 0; i < 12; i += 1)
{
    draw_set_halign(fa_left);
    draw_text(xSelector,ySelector+i*ySeperation+32,strSelect[i]);

    draw_set_halign(fa_right);

    if(i == select)
    {
        draw_sprite(sprPlayerIdle,playerIndex,xSelector-20,ySelector+i*ySeperation+52);

        if (settingButton) //button prompt
        {
            draw_text(xSelector+xSeperation,ySelector+i*ySeperation+32,"Press button to set");
        }
    }

    if (!settingButton || i != select)    //shows current button
    {
        draw_text(xSelector+xSeperation,ySelector+i*ySeperation+32,strButton[i]);
    }

    if (resetPrompt && i == 11) //reset controls prompt
    {
        draw_text(xSelector+xSeperation,ySelector+i*ySeperation+32,"Controls reset!");
    }
}

if (global.controllerIndex != -1)
{
    draw_set_color(c_maroon);
    draw_set_font(fDefault12);
    draw_set_halign(fa_left);

    var controllerText = "Current controller: ";

    if (gamepad_is_connected(global.controllerIndex))//say what type of controller is connected (i.e. Xbox, Playstation)
    {
        controllerText += gamepad_get_description(global.controllerIndex);
    }
    else
    {
        controllerText += "None";
    }

    draw_text(xSelector+2,ySelector+(12)*ySeperation+34,controllerText);

    draw_set_color(c_black);
}

scrDrawButtonInfo(false);
