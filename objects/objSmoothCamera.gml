#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
//place this object next to where player starts in the room and set the view to follow this object

snapDiv = 4; //determines how fast the camera snaps to the player (higher numbers follow the player slower), can be changed in creation code

if (instance_exists(objPlayer))
{
    x = objPlayer.x;
    y = objPlayer.y;
}
#define Step_2
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if (instance_exists(objPlayer))
{
    x += (objPlayer.x - x) / snapDiv;
    y += (objPlayer.y - y) / snapDiv;
}
