#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
//set trg in creation code

trg = 0;

image_speed = 0;
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if (place_meeting(x, y, objBullet) || (place_meeting(x, y, objPlayer) && scrButtonCheckPressed(global.shootButton)))
{
    if (image_index == 0)   //sets trigger when shot
    {
        image_index = 1;
        global.trigger[trg] = true;
    }
}
#define Other_4
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
global.trigger[trg] = false;    //reset the trigger
