#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if (!visible && distance_to_object(objPlayer) <= 1)
{
    sound_play("sndBlockChange");
    visible = true;
}
