#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
image_speed = 0;
image_index = 0; // initiate color - red
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
///snap to the player before he moves this frame

event_user(0);
#define Step_2
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
///snap to the player after he moves this frame

if (!global.delayBow)   //only snap to the player if bow delay setting is off
    event_user(0);
#define Other_10
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
///stay with the player

if (instance_exists(objPlayer))
{
    x = objPlayer.x;
    y = objPlayer.y;
    image_xscale = objPlayer.xScale;

    if (global.grav == 1)   //normal
    {
        image_yscale = 1;
    }
    else    //flipped
    {
        image_yscale = -1;
        y += 1; //need to draw the sprite a pixel off when flipped
    }

    if global.bowAdvanced image_index = !objPlayer.djump;
}
else
{
    instance_destroy();
}
