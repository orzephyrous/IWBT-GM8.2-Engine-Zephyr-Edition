#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
//this wall disappears when a boss item is obtained

//set in creation code
itemNum = 0;
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if (global.bossItem[itemNum])  //destroy self if item has been obtained
    instance_destroy();
