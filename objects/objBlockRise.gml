#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if (yspeed == 0 && instance_exists(objPlayer))
{
    if (place_meeting(x,y-objPlayer.vspeed-(global.grav),objPlayer))
        yspeed = -2;    //touching the player, start rising
}

event_inherited();  //movement checks
