#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
image_speed = 0;
canSave = true;
grav = 1;       //sets which player gravity this save works with

if (global.difficulty > 2)  //destroy if on a higher difficulty than very hard
    instance_destroy();

sprite_index = sprSave;
