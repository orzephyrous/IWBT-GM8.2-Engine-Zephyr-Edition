#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
refreshJump = 1;
#define Collision_objPlayer
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if (!global.dotkid)
{
    scrToggleDotkid();
    other.y -= 8*global.grav;
}

if (refreshJump) objPlayer.djump = 1;

instance_destroy();
