#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
///autosave or not at the beginning of a room
autosave = 1;
#define Other_4
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if (!instance_exists(objPlayer))
{
    if (autosave && global.difficulty < 3 && (room != rInit && room != rMenu && room != rTitle && room != rOptions && room != rDifficultySelect))
    {
        global.autosave = true;  //autosave
    }
    instance_create(x + 17, y + 23, objPlayer);
}
