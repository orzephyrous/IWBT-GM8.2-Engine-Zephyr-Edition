#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
//get the bullet's direction based off the direction the player is facing

var bulletDir;
if (instance_exists(objPlayer))
    bulletDir = objPlayer.xScale;
else
    bulletDir = 1;

//set the bullet's speed
hspeed = bulletDir * 16;

alarm[0] = 40;
#define Alarm_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
instance_destroy();
#define Collision_objBlock
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
instance_destroy();
#define Collision_objSaveBlocker
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
instance_destroy();
#define Collision_objBlockDynamic
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
instance_destroy();
