#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
//change these in creation code

warpX = 0;
warpY = 0;
roomTo = rTemplate;
kind = 0;
#define Collision_objPlayer
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if (warpX == 0 && warpY == 0)
{
    with(objPlayer)
        instance_destroy();
}
else
{
    objPlayer.x = warpX;
    objPlayer.y = warpY;
}

transition_kind = kind;
room_goto(roomTo);
