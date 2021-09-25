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
#define Collision_objBlock
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
///snap to the block
move_contact_solid(direction,speed);

speed = 0;
gravity = 0;
#define Collision_objPlatform
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
///do nothing
#define Other_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
instance_destroy();
