///Check inputs that change the player's skin
if (!global.skinEnabled) exit;

if (scrButtonCheckPressed(global.skinButton1) && global.playerSkin != 1)
{
    global.playerSkin = 1;
    sound_play("sndSkinChange");
}
if (scrButtonCheckPressed(global.skinButton2) && global.playerSkin != 2)
{
    global.playerSkin = 2;
    sound_play("sndSkinChange");
}
