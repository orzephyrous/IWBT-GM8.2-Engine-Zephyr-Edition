#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
refreshTime = 100;   //sets how many frames it takes after hitting to refresh (can use -1 to make it never refresh)
#define Alarm_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
visible = true;
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
image_yscale = global.grav;
#define Collision_objPlayer
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if (visible)
{
    with (objPlayer)
        djump = 1;

    visible = false;
    alarm[0] = refreshTime;
}
