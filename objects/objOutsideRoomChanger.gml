#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
//this warp only activates when the player leaves the room, it can be used on the edges of rooms for smoother room transitions

event_inherited();

autosave = false;
//can be changed in creation code
smoothTransition = false;   //sets whether the player wraps around the screen for a smooth transition to the next room (this requires the room sizes to be the same)
#define Collision_objPlayer
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if (other.x < 0 || other.x > room_width || other.y < 0 || other.y > room_height)  //check if player has left the room
{
    if (!smoothTransition)  //not using smooth transition, use default warp
    {
        event_inherited();
    }
    else        //using smooth transition, wrap around the screen then warp
    {
        if (other.x < 0)
        {
            other.x += room_width;
        }
        if (other.x > room_width)
        {
            other.x -= room_width;
        }
        if (other.y < 0)
        {
            other.y += room_height;
        }
        if (other.y > room_height)
        {
            other.y -= room_height;
        }

        room_goto(roomTo);
    }
}
