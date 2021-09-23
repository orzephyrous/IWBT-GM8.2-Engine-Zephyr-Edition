#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
///Initialize variables
old_left = bbox_left;
old_right = bbox_right;
old_top = bbox_top;
old_bottom = bbox_bottom;

inst = noone;

draw = 0;
#define Step_1
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
///Set old boundary variables for this frame's collision

old_left = bbox_left;
old_right = bbox_right;
old_top = bbox_top;
old_bottom = bbox_bottom;
#define Other_10
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
///Carry instance

with(objBlockDynamic) solid = false;

if (inst != noone)
{
    if (collision_rectangle(old_left, old_top - global.grav, old_right, old_bottom - global.grav, inst, true, true))
    {
        var carryX,carryY;
        carryX = mean(bbox_left, bbox_right) - mean(old_left, old_right);
        carryY = bbox_top - inst.bbox_bottom - 1;
        with(inst)
        {
            if (carryX != 0)
            {
                if (place_free(x + carryX, y))
                {
                    x += carryX;
                }
                else
                {
                    move_contact_solid(180 * (carryX < 0), abs(carryX));
                }
            }
            if (carryY > 0)
            {
                if (place_free(x, y + carryY))
                {
                    y += carryY;
                }
                else
                {
                    move_contact_solid(270, carryY);
                }
            }
        }
    }
}

with(objBlockDynamic) solid = true;
#define Other_11
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
///Push instance

with(objBlockDynamic) solid = false;

if (inst != noone)
{
    if (place_meeting(x, y, inst))
    {
        var moveX,moveY;
        moveX = 0
        moveY = 0;

        //Push horizontally
        if (inst.bbox_bottom - (inst.y - inst.yold) >= old_top && inst.bbox_top - (inst.y - inst.yold) <= old_bottom)
        {
            if (inst.bbox_left - (inst.x - inst.xold) >= old_right)
            {
                moveX = bbox_right - inst.bbox_left + 1;
                moveX += ((inst.x + moveX) mod 2 == 1.5);
            }
            else if (inst.bbox_right - (inst.x - inst.xold) <= old_left)
            {
                moveX = bbox_left - inst.bbox_right - 1;
                moveX -= ((inst.x + moveX) mod 2 == 0.5);
            }
            if (moveX != 0)
            {
                with(inst)
                {
                    if (place_free(x + moveX, y))
                    {
                        x += moveX;
                    }
                }
            }
        }

        //Push vertically
        if (inst.bbox_right - (inst.x - inst.xold) >= old_left && inst.bbox_left - (inst.x - inst.xold) <= old_right)
        {
            if (inst.bbox_top - (inst.y - inst.yold) >= old_bottom)
            {
                moveY = bbox_bottom - inst.bbox_top + 1;
                moveY += ((inst.y + moveY) mod 2 == 1.5);
            }
            else if (inst.bbox_bottom - (inst.y - inst.yold) <= old_top)
            {
                moveY = bbox_top - inst.bbox_bottom - 1;
                moveY -= ((inst.y + moveY) mod 2 == 0.5);
            }
            if (moveY != 0)
            {
                with(inst)
                {
                    if (place_free(x, y + moveY))
                    {
                        y += moveY;
                    }
                }
            }
        }
    }
}

with(objBlockDynamic) solid = true;
