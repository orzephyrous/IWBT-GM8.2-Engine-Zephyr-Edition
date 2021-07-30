#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if (scrButtonCheckPressed(global.menuAcceptButton))
{
    sound_play(global.menuSound);
    room_goto(rMenu);
}
