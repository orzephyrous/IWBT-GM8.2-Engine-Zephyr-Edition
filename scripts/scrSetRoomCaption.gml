///sets the room caption

var roomCaption;
roomCaption = global.roomCaptionDef;

if (global.gameStarted)
{
    roomCaption += " -";
    roomCaption += " Save " + string(global.savenum);
    roomCaption += " -";
    if (global.difficulty==0)
    {
        roomCaption += " Medium";
    }
    else if (global.difficulty==1)
    {
        roomCaption += " Hard";
    }
    else if (global.difficulty==2)
    {
        roomCaption += " Very Hard";
    }
    else if (global.difficulty==3)
    {
        roomCaption += " Impossible";
    }

    roomCaption += " -";
    roomCaption += " Deaths: " + string(global.death);
    roomCaption += " Time: ";

    var t;
    t = floor(global.time);

    roomCaption += string(t div 3600) + ":";
    t = t mod 3600;
    roomCaption += string(t div 600);
    t = t mod 600;
    roomCaption += string(t div 60) + ":";
    t = t mod 60;
    roomCaption += string(t div 10);
    t = t mod 10;
    roomCaption += string(t);

    if (global.gameClear) roomCaption += " - Clear!";
}

if (room_caption != global.roomCaptionLast)  //only update the caption when it changes
    room_caption = roomCaption;

global.roomCaptionLast = roomCaption;
