#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
alpha = 0.1;
image_alpha = alpha;
count = 1000;
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
image_alpha = alpha;
count += 1;
fraction = 1-(count-10)/20;
fraction = clamp(fraction,0,1);

image_alpha += (1-alpha)*fraction;
#define Collision_objBullet
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
with other instance_destroy()
count = 0
