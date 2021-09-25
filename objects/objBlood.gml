#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
image_index = irandom(image_number - 1);
image_speed = 0;

direction = irandom(35) * 10;
speed = random(6);
gravity = (0.1 + random(0.2)) * global.grav;
_grav = 0;
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
/// snap to solid
vspeed += gravity;

if (!place_free(x + hspeed, y + vspeed))
{
    move_contact_solid(direction,speed);
    _grav = gravity;
    speed = 0;
    gravity = 0;
}

vspeed -= gravity;
#define Other_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
instance_destroy();
