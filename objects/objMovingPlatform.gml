#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited();

carry = true;   //set the platform to carry player
bounce = true;  //set the platform to bounce against walls
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if (speed != 0 || yspeed != 0)  //make sure the platform is moving before doing collision checks
{
    if (bounce)
    {
        if (!place_free(x + hspeed, y)) {hspeed = -hspeed;}

        if (!place_free(x, y + vspeed + yspeed))
        {
            if (vspeed != 0)
            {
                yspeed = -vspeed;
                vspeed = 0;
            }
            else
            {
                vspeed = -yspeed;
                yspeed = 0;
            }
        }
    }

    with (instance_place(x, y - 2 * global.grav, objPlayer))
    {
        if (bbox_bottom <= other.bbox_top || bbox_top >= other.bbox_bottom)
        {
            if (!place_free(x, y + other.vspeed + other.yspeed))
            {
                if (global.platformMode = 1)  //squish fall
                {
                    var yy;
                    yy = other.y - (bbox_bottom - y) - 1;
                    move_contact_solid(90, y - yy); //Move against solid to not get snapped into a wall
                    vspeed = max(other.vspeed, 0);
                }
                else if (global.platformMode = 2)  //go through the ceiling
                {
                    y += other.vspeed + other.yspeed;
                    onPlatform = true;
                }
                else
                {
                    y += other.vspeed + other.yspeed
                }
            }
            if (place_free(x + other.hspeed, y) && other.carry) x += other.hspeed;
        }
    }

    y += yspeed;

    if (vspeed < 0)
    {
        yspeed = vspeed;
        vspeed = 0;
    }
    if (yspeed > 0)
    {
        vspeed = yspeed;
        yspeed = 0;
    }
}
