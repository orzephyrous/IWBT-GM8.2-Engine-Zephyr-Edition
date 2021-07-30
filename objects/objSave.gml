#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
image_speed = 0;
canSave = true;
grav = 1;       //sets which player gravity this save works with

if (global.difficulty > 1)  //destroy if on a higher difficulty than hard
    instance_destroy();
#define Alarm_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
canSave = true;
#define Collision_objPlayer
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if (scrButtonCheckPressed(global.shootButton))  //save if player is touching the save and shooting
{
    event_user(0);
}
#define Collision_objBullet
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_user(0);  //save the game
#define Other_7
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
image_index = 0;
image_speed = 0;
#define Other_10
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
///save the game

if (canSave && instance_exists(objPlayer) && global.grav == grav)
{
    if (!((objPlayer.x < 0 || objPlayer.x > room_width || objPlayer.y < 0 || objPlayer.y > room_height) && global.edgeDeath))  //make sure the player isn't saving outside the room to prevent save locking
    {
        canSave = false;    //make it so that the player can't save again immediately
        alarm[0] = 30;  //set alarm so the player can save again
        image_index = 1;
        image_speed = 0.017;
        sound_play("sndSave");
        scrSaveGame(true);
    }
}
