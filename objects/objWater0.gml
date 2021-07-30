#define Collision_objPlayer
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if((objPlayer.vspeed*global.grav) > 2)
    objPlayer.vspeed = 2*global.grav;
