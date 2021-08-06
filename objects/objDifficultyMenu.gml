#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
//initiailze menu variables

difSelect = false;
select = global.menuSelectPrev[0];
select2 = 0;
xSeperation = 239;
str[0] = "Save 1";
str[1] = "Save 2";
str[2] = "Save 3";
warnText = false;
warnSelect = true;

appleIndex = 0;
playerIndex = 0;

//load save file values

var i;
for (i = 0; i < 3; i+=1)
{
    if (file_exists("save"+string(i+1)))  //check if current save exists
    {
        //load save data
        exists[i] = true;

        //load the save map

        var saveMap;
        saveMap = ds_map_create();
        b = buffer_create();
        buffer_load(b,"save"+string(i+1));
        if (global.password != "") buffer_rc4(b,global.password);
        ds_map_read(saveMap,buffer_read_hex(b,buffer_get_size(b)));
        buffer_destroy(b);

        if (saveMap != -1)  //check if the save map loaded correctly
        {
            death[i] = ds_map_find_value(saveMap,"death");

            time[i] = ds_map_find_value(saveMap,"time");

            difficulty[i] = ds_map_find_value(saveMap,"difficulty");

            var j;
            for (j = 0; j < 8; j+=1)
            {
                boss[j,i] = ds_map_find_value(saveMap,"saveBossItem["+string(j)+"]");
            }

            clear[i] = ds_map_find_value(saveMap,"saveGameClear");

            ds_map_destroy(saveMap);
        }
        else
        {
            //save map didn't load correctly, set the variables to the defaults
            death[i] = 0;
            time[i] = 0;
            difficulty[i] = 0;
            var j
            for (j = 0; j < 8; j+=1)
            {
                boss[j,i] = false;
            }
            clear[i] = false;
        }
    }
    else
    {
        exists[i] = false;
        death[i] = 0;
        time[i] = 0;
    }

    var t;
    t = time[i];

    timeStr[i] = string(t div 3600) + ":";
    t = t mod 3600;
    timeStr[i] += string(t div 600);
    t = t mod 600;
    timeStr[i] += string(t div 60) + ":";
    t = t mod 60;
    timeStr[i] += string(t div 10);
    t = t mod 10;
    timeStr[i] += string(floor(t));
}
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
//animate select sprites
appleIndex = (appleIndex + 1/15) mod 2;
playerIndex = (playerIndex + 1/5) mod 4;

if (scrButtonCheckPressed(global.menuOptionsButton))
{
    global.menuSelectPrev[0] = select;
    room_goto(rOptions);
}
else
{
    if (!difSelect)
    {
        if (scrButtonCheckPressed(global.menuLeftButton))
        {
            sound_play(global.menuSound);
            select -= 1;
            if (select < 0)
                select = 2;
        }
        else if (scrButtonCheckPressed(global.menuRightButton))
        {
            sound_play(global.menuSound);
            select += 1;
            if (select > 2)
                select = 0;
        }
        else if (scrButtonCheckPressed(global.menuBackButton))
        {
            global.menuSelectPrev[0] = 0;
            room_goto(rTitle);  //go back
        }
        else if (scrButtonCheckPressed(global.menuAcceptButton))
        {
            if (global.menuMode == 0)   //use the difficulty select room to select difficulty
            {
                global.savenum = select+1;
                room_goto(rDifficultySelect);
            }
            else    //use the menu to select difficulty
            {
                sound_play(global.menuSound);
                difSelect = true;
                if (exists[select]) //check if there is a save in the current slot
                    select2 = -1;   //default to load game
                else
                    select2 = 0;    //default to medium
            }
        }
    }
    else
    {
        if (!warnText)
        {
            if (scrButtonCheckPressed(global.menuLeftButton))
            {
                sound_play(global.menuSound);
                select2 -= 1;
                if ((select2 == -1 && !exists[select]) || (select2 < -1))
                    select2 = 3;
            }
            else if (scrButtonCheckPressed(global.menuRightButton))
            {
                sound_play(global.menuSound);
                select2 += 1;
                if (select2 > 3)
                {
                    if (exists[select])
                        select2 = -1;
                    else
                        select2 = 0;
                }
            }
            else if (scrButtonCheckPressed(global.menuBackButton))
            {
                difSelect = false;
            }
            else if (scrButtonCheckPressed(global.menuAcceptButton))
            {
                global.savenum = select+1;

                if (select2 == -1)  //load game
                {
                    if (file_exists("save"+string(global.savenum)))
                        scrLoadGame(true);
                }
                else    //starts new game
                {
                    if (!file_exists("save"+string(global.savenum)))
                    {
                        global.gameStarted = true; //sets game in progress (enables saving, restarting, etc.)
                        global.autosave = true;

                        global.difficulty = select2;

                        room_goto(global.startRoom);
                    }
                    else
                    {
                        warnText = true;
                        warnSelect = true;
                    }
                }
            }
        }
        else
        {
            if (scrButtonCheckPressed(global.menuLeftButton))
            {
                sound_play(global.menuSound,);
                warnSelect = !warnSelect;
            }
            else if (scrButtonCheckPressed(global.menuRightButton))
            {
                sound_play(global.menuSound);
                warnSelect = !warnSelect;
            }
            else if (scrButtonCheckPressed(global.menuBackButton))
            {
                warnText = false;
            }
            else if (scrButtonCheckPressed(global.menuAcceptButton))
            {
                if (warnSelect)
                {
                    //start new game
                    global.gameStarted = true; //sets game in progress (enables saving, restarting, etc.)
                    global.autosave = true;

                    global.difficulty = select2;

                    if (file_exists("save"+string(global.savenum)))
                        file_delete("save"+string(global.savenum));

                    room_goto(global.startRoom);
                }
                else
                {
                    warnText = false;
                }
            }
        }
    }
}
#define Draw_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
var i;
for(i = 0; i < 3; i += 1)
{
    draw_set_color(c_black)
    draw_set_halign(fa_left)
    draw_set_valign(fa_top)
    draw_set_font(fDefault30);

    draw_text(x+i*xSeperation+2,y,str[i]);

    draw_set_font(fDefault12);

    draw_text(x+i*xSeperation+10,y+70,"Deaths: "+string(death[i]));
    draw_text(x+i*xSeperation+10,y+90,"Time: "+timeStr[i]);

    draw_set_halign(fa_center);

    if (difSelect && i == select)
    {
        if (!warnText)
        {
            if(select2==-1) draw_text(x + i*xSeperation + 65, y+49,"< Load game >");
            else if(select2==0) draw_text(x + i*xSeperation + 65, y+49,"< Medium >");
            else if(select2==1) draw_text(x + i*xSeperation + 65, y+49,"< Hard >");
            else if(select2==2) draw_text(x + i*xSeperation + 65, y+49,"< Very Hard >");
            else if(select2==3) draw_text(x + i*xSeperation + 65, y+49,"< Impossible >");
        }
        else
        {
            draw_text(x+i*xSeperation+63,y-100,"Are you sure#you want to#overwrite this save?")
            if(warnSelect) draw_text(x + i*xSeperation + 65, y+49,"< Yes >");
            else draw_text(x + i*xSeperation + 65, y+49,"< No >");
        }
    }

    if (exists[i])
    {
        if ((!difSelect) || (difSelect && i != select))
        {
            if(difficulty[i]==0){draw_text(x+i*xSeperation+65,y+49,"Medium")}
            else if(difficulty[i]==1){draw_text(x+i*xSeperation+65,y+49,"Hard")}
            else if(difficulty[i]==2){draw_text(x+i*xSeperation+65,y+49,"Very Hard")}
            else if(difficulty[i]==3){draw_text(x+i*xSeperation+65,y+49,"Impossible")}
        }

        draw_set_font(fDefault24);

        if(clear[i]){draw_text(x+i*xSeperation+63,y+215,"Clear!!")}

        if(boss[0,i]){draw_sprite(sprBossItem,-1,x+i*xSeperation+0,y+128)}
        if(boss[1,i]){draw_sprite(sprBossItem,-1,x+i*xSeperation+32,y+128)}
        if(boss[2,i]){draw_sprite(sprBossItem,-1,x+i*xSeperation+64,y+128)}
        if(boss[3,i]){draw_sprite(sprBossItem,-1,x+i*xSeperation+96,y+128)}
        if(boss[4,i]){draw_sprite(sprBossItem,-1,x+i*xSeperation+0,y+160)}
        if(boss[5,i]){draw_sprite(sprBossItem,-1,x+i*xSeperation+32,y+160)}
        if(boss[6,i]){draw_sprite(sprBossItem,-1,x+i*xSeperation+64,y+160)}
        if(boss[7,i]){draw_sprite(sprBossItem,-1,x+i*xSeperation+96,y+160)}
    }
    else
    {
        if ((!difSelect) || (difSelect && i != select))
        {
            draw_text(x+i*xSeperation+65,y+49,"No Data");
        }
    }

    if (i == select)
    {
        draw_sprite(sprCherry,appleIndex,x+i*xSeperation+5,y+310);
        draw_sprite(sprCherry,appleIndex,x+i*xSeperation+25,y+310);
        draw_sprite(sprCherry,appleIndex,x+i*xSeperation+45,y+310);
        draw_sprite(sprPlayerIdle,playerIndex,x+i*xSeperation+65,y+310);
        draw_sprite(sprCherry,appleIndex,x+i*xSeperation+85,y+310);
        draw_sprite(sprCherry,appleIndex,x+i*xSeperation+105,y+310);
        draw_sprite(sprCherry,appleIndex,x+i*xSeperation+125,y+310);
    }
}

scrDrawButtonInfo(true);
