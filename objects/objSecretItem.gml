#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
//set in creation code
itemNum = 0;
#define Collision_objPlayer
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
global.secretItem[itemNum] = true;

//save the item if autosaving items is on
if (global.autosaveSecretItems)
{
    global.saveSecretItem[itemNum] = true;
    scrSaveGame(false);
}

sound_play("sndItem");
instance_destroy();
#define Other_4
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if (global.secretItem[itemNum]) //destroy self if item already obtained
    instance_destroy();
