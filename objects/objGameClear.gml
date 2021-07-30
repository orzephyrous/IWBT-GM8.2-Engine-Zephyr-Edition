#define Collision_objPlayer
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
///set game to clear and autosave when touched

if (!global.gameClear)
{
    global.gameClear = true;
    scrSaveGame(true);
}
