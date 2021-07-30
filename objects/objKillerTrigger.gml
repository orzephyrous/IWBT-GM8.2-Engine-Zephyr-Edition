#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
//set these in creation code
trg = 0;

v = 0;      //vspeed
h = 0;      //hspeed

dir = 0;    //direction
spd = 0;    //speed


triggered = false;
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if (!triggered && global.trigger[trg])
{
    if (v != 0 || h != 0)
    {
        vspeed = v;
        hspeed = h;
    }
    else if (spd != 0)
    {
        direction = dir;
        speed = spd;
    }

    triggered = true;
}
