#define Collision_objPlayer
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
with (objPlayer)
{
    djump = 1;
    if ((vspeed * global.grav) > 2) {vspeed = 2 * global.grav;}
}
