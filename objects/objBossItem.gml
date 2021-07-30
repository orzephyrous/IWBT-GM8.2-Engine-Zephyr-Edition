#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
//set in creation code
itemNum = 0;
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if (global.bossItem[itemNum])    //destroy self if item already obtained
    instance_destroy();
#define Collision_objPlayer
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
global.bossItem[itemNum] = true;
sound_play("sndBlockChange");
instance_destroy();
