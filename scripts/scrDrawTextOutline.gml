///scrDrawTextOutline(x,y,string,textcolor,outlinecolor)
///draws any text with an outline
///argument0 - text X position
///argument1 - text Y position
///argument2 - text string
///argument3 - color of the text inside the outline
///argument4 - color of the text outline

var textX, textY, textStr, textColor, outlineColor;
textX = argument0;
textY = argument1;
textStr = argument2;
textColor = argument3;
outlineColor = argument4;

//draw the text outline
draw_set_color(outlineColor);
draw_text(textX-1,textY+1,textStr);
draw_text(textX-1,textY,textStr);
draw_text(textX-1,textY-1,textStr);
draw_text(textX+1,textY+1,textStr);
draw_text(textX+1,textY,textStr);
draw_text(textX+1,textY-1,textStr);
draw_text(textX,textY+1,textStr);
draw_text(textX,textY-1,textStr);

//draw the text itself
draw_set_color(textColor);
draw_text(textX,textY,textStr);
