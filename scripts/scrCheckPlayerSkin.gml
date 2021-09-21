///Check inputs that change the player's skin

if (scrButtonCheckPressed(global.skinButton1) && global.playerSkin != 1)
    global.playerSkin = 1;

if (scrButtonCheckPressed(global.skinButton2) && global.playerSkin != 2)
    global.playerSkin = 2;
