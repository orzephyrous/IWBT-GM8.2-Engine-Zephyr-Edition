#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
frozen = false; //sets if the player can move or not

jump = 8.5 * global.grav; //set how fast the player jumps
jump2 = 7 * global.grav; //sets how fast the player double jumps
gravity = 0.4 * global.grav; //player gravity

djump = 1; //allow the player to double jump as soon as he spawns
maxSpeed = 3;   //max horizontal speed
maxVspeed = 9;  //max vertical speed
image_speed = 0.2; //initial speed of animation
onPlatform = false; //sets if player is currently standing on a platform

xScale = 1; //sets the direction the player is facing (1 is facing right, -1 is facing left)

scrSetPlayerMask(); //set the player's hitbox

if (global.difficulty == 0 && global.gameStarted)   //create the player's bow
    instance_create(x,y,objBow);

if (global.autosave) //save the game if currently set to autosave
{
    scrSaveGame(true);
    global.autosave = false;
}
#define Destroy_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
//when the player is destroyed, also destroy the bow
with (objBow)
    instance_destroy();
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
//check left/right button presses
var L, R, h;
L = (scrButtonCheck(global.leftButton) || (global.directionalTapFix && scrButtonCheckPressed(global.leftButton)));
R = (scrButtonCheck(global.rightButton) || (global.directionalTapFix && scrButtonCheckPressed(global.rightButton)));

h = 0;

if (!frozen)    //don't move if frozen
{
    if (R)
        h = 1;
    else if (L)
        h = -1;
}

var slipBlockTouching;
slipBlockTouching = instance_place(x,y+(1*global.grav),objSlipBlock);   //check if on a slip block

//vine checks
var notOnBlock, onVineL, onVineR;
notOnBlock = (place_free(x,y+(global.grav)));
onVineL = (place_meeting(x-1,y,objWalljumpL) && notOnBlock);
onVineR = (place_meeting(x+1,y,objWalljumpR) && notOnBlock);

if (h != 0)  //player is moving
{
    if (!onVineR && !onVineL)   //make sure not currently touching a vine
    {
        xScale = h;
    }
    if ((h == -1 && !onVineR) || (h == 1 && !onVineL))
    {
        if (slipBlockTouching == noone) //not touching a slip block, move immediately at full speed
        {
            hspeed = maxSpeed * h;
        }
        else    //touching a slip block, use acceleration
        {
            hspeed += (slipBlockTouching.slip) * h;

            if (abs(hspeed) > maxSpeed)
                hspeed = maxSpeed * h;
        }

        sprite_index = sprPlayerRunning;
        image_speed = 0.5;
    }
}
else    //player is not moving
{
    if (slipBlockTouching == noone) //not touching a slip block, stop immediately
        hspeed = 0;
    else    //touching a slip block, slow down
    {
        if (hspeed > 0)
        {
            hspeed -= slipBlockTouching.slip;

            if (hspeed <= 0)
                hspeed = 0;
        }
        else if (hspeed < 0)
        {
            hspeed += slipBlockTouching.slip;

            if (hspeed >= 0)
                hspeed = 0;
        }
    }

    sprite_index = sprPlayerIdle;
    image_speed = 0.2;
}


if (!onPlatform)    //check if standing on a platform
{
    if((vspeed * global.grav) < -0.05) {sprite_index = sprPlayerJump;}
    else if((vspeed * global.grav) > 0.05) {sprite_index = sprPlayerFall;}
}
else
{
    if (!place_meeting(x,y+(4*global.grav),objPlatform)) {onPlatform = false;}
}

var slideBlockTouching;
slideBlockTouching = instance_place(x,y+(global.grav),objSlideBlock);   //check if on a slide block

if (slideBlockTouching != noone)    //on a slide block, start moving with it
    hspeed += slideBlockTouching.h;

if (abs(vspeed) > maxVspeed) {vspeed = sign(vspeed)*maxVspeed;} //check if moving vertically faster than max speed

if (!frozen)    //check if frozen before doing anything
{
    if (scrButtonCheckPressed(global.shootButton))
        scrPlayerShoot();
    if (scrButtonCheckPressed(global.jumpButton))
        scrPlayerJump();
    if (scrButtonCheckReleased(global.jumpButton))
        scrPlayerVJump();
    if (scrButtonCheckPressed(global.suicideButton))
        scrKillPlayer();
}

if (global.adAlign && place_meeting(x,y+(global.grav),objBlock) && !frozen)  // A/D align
{
    if (scrButtonCheckPressed(global.alignLeftButton)) {hspeed -= 1;}
    if (scrButtonCheckPressed(global.alignRightButton)) {hspeed += 1;}
}


//walljumps

if (onVineL || onVineR)
{
    if (onVineR)
        xScale = -1;
    else
        xScale = 1;

    vspeed = 2 * global.grav;
    sprite_index = sprPlayerSliding;
    image_speed = 1/2;

    //pressed away from the vine
    if (onVineL && scrButtonCheckPressed(global.rightButton)) || (onVineR && scrButtonCheckPressed(global.leftButton))
    {
        if (scrButtonCheck(global.jumpButton))  //jumping off vine
        {
            if (onVineR)
                hspeed = -15;
            else
                hspeed = 15;

            vspeed = -9 * global.grav;
            sound_play(sndWallJump);
            sprite_index = sprPlayerJump;
        }
        else    //moving off vine
        {
            if (onVineR)
                hspeed = -3;
            else
                hspeed = 3;

            sprite_index = sprPlayerFall;
        }
    }
}

//slopes

if (instance_exists(objSlope) && hspeed != 0)
{
    var moveLimit;
    moveLimit = abs(hspeed);    //sets how high/low the player can go to snap onto a slope, this can be increased to make the player able to run over steeper slopes (ie setting it to abs(hspeed)*2 allows the player to run over slopes twice as steep)

    var slopeCheck;
    var hTest;

    var ySlope;

    //falling onto a slope
    if (place_meeting(x+hspeed,y+vspeed+gravity,objSlope) && (vspeed+gravity)*global.grav > 0 && notOnBlock)
    {
        var xLast, yLast, hLast, vLast;
        xLast = x;
        yLast = y;
        hLast = hspeed;
        vLast = vspeed;

        vspeed += gravity;

        x += hspeed;
        hspeed = 0;

        if(!place_free(x,y+vspeed))
        {
            if (global.grav == 1)   //normal
                move_contact_solid(270,abs(vspeed));
            else    //flipped
                move_contact_solid(90,abs(vspeed));
            vspeed = 0;
        }

        y += vspeed;

        if (!place_free(x,y+(global.grav)) && place_free(x,y))  //snapped onto the slope properly
        {
            djump = 1;
            notOnBlock = false;
        }
        else    //did not snap onto the slope, return to previous position
        {
            x = xLast;
            y = yLast;
            hspeed = hLast;
            vspeed = vLast;
        }
    }

    //moving down a slope
    if (!notOnBlock)
    {
        var onSlope;
        onSlope = (place_meeting(x,y+(global.grav),objSlope));    //treat normal blocks the same as slopes if we're standing on a slope

        slopeCheck = true;
        hTest = hspeed;

        while (slopeCheck)
        {
            ySlope = 0;
            //check how far we should move down
            while ((!place_meeting(x+hTest,y-ySlope+(global.grav),objSlope) || (onSlope && !place_meeting(x+hTest,y-ySlope+(global.grav),objBlock))) && ySlope*global.grav > -floor(moveLimit*(hTest/hspeed)))
            {
                ySlope -= global.grav;
            }

            //check if we actually need to move down
            if (place_meeting(x+hTest,y-ySlope+(global.grav),objSlope) || (onSlope && place_meeting(x+hTest,y-ySlope+(global.grav),objBlock)))
            {
                if (ySlope != 0 && !place_meeting(x+hTest,y-ySlope,objBlock))
                {
                    y -= ySlope;

                    x += hTest;
                    hspeed = 0;

                    slopeCheck = false;
                }
                else
                {
                    if (hTest > 0)
                    {
                        hTest -= 1;
                        if (hTest <= 0)
                            slopeCheck = false;
                    }
                    else if (hTest < 0)
                    {
                        hTest += 1;
                        if (hTest >= 0)
                            slopeCheck = false;
                    }
                    else
                    {
                        slopeCheck = false;
                    }
                }
            }
            else
            {
                slopeCheck = false;
            }
        }
    }

    //moving up a slope
    if (place_meeting(x+hspeed,y,objSlope))
    {
        slopeCheck = true;
        hTest = hspeed;

        while (slopeCheck)
        {
            ySlope = 0;

            //check how far we have to move up
            while (place_meeting(x+hTest,y-ySlope,objSlope) && ySlope*global.grav < floor(moveLimit*(hTest/hspeed)))
            {
                ySlope += global.grav;
            }

            //check if we actually need to move up
            if (place_free(x+hTest,y-ySlope))
            {
                y -= ySlope;

                x += hTest;
                hspeed = 0;

                slopeCheck = false;
            }
            else
            {
                if (hTest > 0)
                {
                    hTest -= 1;
                    if (hTest <= 0)
                        slopeCheck = false;
                }
                else if (hTest < 0)
                {
                    hTest += 1;
                    if (hTest >= 0)
                        slopeCheck = false;
                }
                else
                {
                    slopeCheck = false;
                }
            }
        }
    }

    //set xprevious/yprevious coordinates for future solid collisions
    xprevious = x;
    yprevious = y;
}
#define Step_2
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if ((x < 0 || x > room_width || y < 0 || y > room_height) && global.edgeDeath)  //check if player has left the room
    scrKillPlayer();

//update player sprite
if (global.playerAnimationFix)
{
    //block/vine checks
    var notOnBlock, onVineR, onVineL;
    notOnBlock = (place_free(x,y+(global.grav)));
    onVineR = (place_meeting(x+1,y,objWalljumpR) && notOnBlock);
    onVineL = (place_meeting(x-1,y,objWalljumpL) && notOnBlock);

    if (!onVineR && !onVineL)   //not touching any vines
    {
        if (onPlatform || !notOnBlock)  //standing on something
        {
            //check if moving left/right
            var L,R;
            L = (scrButtonCheck(global.leftButton) || (global.directionalTapFix && scrButtonCheckPressed(global.leftButton)));
            R = (scrButtonCheck(global.rightButton) || (global.directionalTapFix && scrButtonCheckPressed(global.rightButton)));

            if ((L || R) && !frozen)
            {
                sprite_index = sprPlayerRunning;
                image_speed = 1/2;
            }
            else
            {
                sprite_index = sprPlayerIdle;
                image_speed = 1/5;
            }
        }
        else    //in the air
        {
            if ((vspeed * global.grav) < 0)
            {
                sprite_index = sprPlayerJump;
                image_speed = 1/2;
            }
            else
            {
                sprite_index = sprPlayerFall;
                image_speed = 1/2;
            }
        }
    }
    else    //touching a vine
    {
        sprite_index = sprPlayerSliding;
        image_speed = 1/2;
    }
}
#define Collision_objBlock
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if (!place_free(x+hspeed,y))
{
    if (global.grav == 1)   //normal
    {
        if(hspeed <= 0){move_contact_solid(180,abs(hspeed));}
        if(hspeed > 0){move_contact_solid(0,abs(hspeed));}
    }
    else    //flipped
    {
        if(hspeed < 0){move_contact_solid(180,abs(hspeed));}
        if(hspeed >= 0){move_contact_solid(0,abs(hspeed));}
    }
    hspeed = 0;
}

if (!place_free(x,y+vspeed))
{
    if (global.grav == 1)   //normal
    {
        if(vspeed <= 0){move_contact_solid(90,abs(vspeed));}
        if(vspeed > 0){move_contact_solid(270,abs(vspeed));djump=1;}
    }
    else    //flipped
    {
        if(vspeed <= 0){move_contact_solid(90,abs(vspeed));djump=1;}
        if(vspeed > 0){move_contact_solid(270,abs(vspeed));}
    }
    vspeed = 0;
}

if (!place_free(x+hspeed,y+vspeed)) {hspeed = 0;}
#define Collision_objPlatform
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if (global.grav == 1)   //normal
{
    if (y-vspeed/2 <= other.y)
    {
        if (other.vspeed >= 0)
        {
            y = other.y-9;
            vspeed = other.vspeed;
        }

        onPlatform = true;
        djump = 1;
    }
}
else    //flipped
{
    if (y-vspeed/2 >= other.y+other.sprite_height-1)
    {
        if (other.yspeed <= 0)
        {
            y = other.y+other.sprite_height+8;
            vspeed = other.yspeed;
        }

        onPlatform = true;
        djump = 1;
    }
}
#define Collision_objPlayerKiller
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
scrKillPlayer();
#define Draw_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
///draw the player

var drawX, drawY;
drawX = x;
drawY = y;

if (global.grav == -1)      //need to draw the player a pixel off in the y-axis when flipped for some reason
    drawY += 1;

draw_sprite_ext(sprite_index,image_index,drawX,drawY,image_xscale*xScale,image_yscale*global.grav,image_angle,image_blend,image_alpha);

//draw the player's hitbox
if (global.debugShowHitbox)
    draw_sprite_ext(mask_index,image_index,x,y,image_xscale,image_yscale,image_angle,image_blend,image_alpha*0.8);

//show y-align when pressing 'V'
if (global.alignShow && scrButtonCheck(global.alignShowButton))
{
    var ya;
    ya = y-floor(y);
    draw_set_font(fDefault12);
    draw_set_halign(fa_center);
    if (y > 64)
    {
        scrDrawTextOutline(x, y-48, string(ya), c_black, c_white);
    }
    else
    {
        scrDrawTextOutline(x, y+16, string(ya), c_black, c_white);
    }
}
