///sets the player's mask depending on gravity flip mode and dotkid mode

if (global.dotkid == 0)
{
    if (global.grav == 1)
        mask_index = sprPlayerMask;
    else
        mask_index = sprPlayerMaskFlip;
}
else
{
    if (global.grav == 1)
        mask_index = sprDotKidMask;
    else
        mask_index = sprDotKidMaskFlip;
}
