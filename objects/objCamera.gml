#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
leaveRoom = false;  //sets whether the camera can follow the player outside of the room's boundaries

event_user(0);  //snap view to the player
#define Step_2
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_user(0);  //snap view to the player
#define Other_10
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
///snap view to the section of the room that the player's in

if(instance_exists(objPlayer))
{
    var xFollow, yFollow;
    xFollow = objPlayer.x;
    yFollow = objPlayer.y;

    if (!leaveRoom)
    {
        xFollow = clamp(xFollow,0,room_width-1);
        yFollow = clamp(yFollow,0,room_height-1);
    }

    view_xview[0] = floor(xFollow/view_wview[0])*view_wview[0];
    view_yview[0] = floor(yFollow/view_hview[0])*view_hview[0];
}
