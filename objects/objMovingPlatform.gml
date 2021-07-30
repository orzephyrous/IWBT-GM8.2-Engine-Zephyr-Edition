#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited();

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
        if (!place_free(x+hspeed,y)) {hspeed = -hspeed;}

        if (!place_free(x,y+vspeed+yspeed))
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

    with (instance_place(x,y-(2*global.grav),objPlayer))
    {
        y += other.vspeed + other.yspeed;
        if (place_free(x+other.hspeed,y)) x += other.hspeed;
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
