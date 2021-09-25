#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
//set [key], trg, [des], [snd] in creation code

key = -1;
trg = 0;
snd = "";
des = true;
#define Collision_objPlayer
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if (key != -1) keyed = global.trigger[key];
else keyed = 1;

if (keyed)
{
    global.trigger[trg] = true;    //set trigger when touched by player
    if (snd != "") sound_play(snd);
    if (des) instance_destroy();
}
#define Other_4
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if (key != -1) global.trigger[key] = false;    //reset the key trigger
global.trigger[trg] = false;    //reset the trigger
