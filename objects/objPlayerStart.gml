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
    instance_create(x+17,y+23,objPlayer);
    if (autosave && (room != rInit && room != rMenu && room != rTitle && room != rOptions && room != rDifficultySelect))
    {
        scrSaveGame(true);  //autosave
    }
}
