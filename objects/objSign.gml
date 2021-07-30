#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
signText = "";  //can be set in creation code

showText = false;
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if (place_meeting(x,y,objPlayer))
{
    if (scrButtonCheckPressed(global.upButton))
        showText = true;
}
else
{
    showText = false;
}
#define Draw_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
draw_self();

if (showText)
{
    draw_set_color(c_black);
    draw_set_font(fDefault12);
    draw_set_halign(fa_center);

    var yOffset;
    yOffset = string_height(signText);

    draw_text(x+(sprite_width/2),y-yOffset,signText);
}
