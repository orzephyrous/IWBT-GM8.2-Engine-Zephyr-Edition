#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
trg = 0;
spd = 0; //used for most movement options

//Movement - use only one (or none)
//Move without stopping
h = 0;
v = 0;
//or
dir = 0;
bounce = false;

//Move to position
xto = -1;
yto = -1;
movetoEase = "none" //"in", "out" or "inout"

//Follow path
path = -1;
action = path_action_stop;
absolute = true;
position = 0;

//Gravity
grav = 0;
gravdir = 270;


//Additional effects - use any of these together
snd = "";

//Fade in/out
fadeType = "none"; //"in" or "out"
fadeTime = 30;
fadeEase = "none"; //"in", "out" or "inout"

//Stretch
xscale = undefined;
yscale = undefined;
scaleTime = 20;
scaleEase = "none"; //"in", "out" or "inout"


//Internal
movetoT = 0;
moveToDuration = 0;
fadeT = 0;
mask = 0;
scaleT = 0;
xscalestart = 0;
yscalestart = 0;

_hspeed = 0;
_vspeed = 0;
_gravity = 0;
_gravity_direction = 0;
_speed = 0;
_direction = 0;

type = "";
init = false;
inst = -1;
triggered = false;
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
hspeed = _hspeed;
vspeed = _vspeed;
gravity = _gravity;
gravity_direction = _gravity_direction;

if (!instance_exists(inst))
{
    instance_destroy();
    exit;
}

if (!init)
{
    event_user(0);
    init = true;
}

if (!triggered && global.trigger[trg])
{
    switch(type)
    {
        case "move":
            hspeed = h;
            vspeed = v;
            break;

        case "moveto":
            xstart = x;
            ystart = y;
            movetoDuration = point_distance(x, y, xto, yto) / spd;
            break;

        case "path":
            path_start(path, spd, action, absolute);
            path_position = position;
            break;

        case "grav":
            gravity = grav;
            gravity_direction = gravdir;

        case "dir":
            direction = dir;
            speed = spd;
            break;

        default:
            break;
    }

    if (doSound)
    {
        sound_play(snd);
    }

    if (doFade && fadeType == "in")
    {
        inst.mask_index = mask;
    }

    if (doStretch)
    {
        xscalestart = image_xscale;
        yscalestart = image_yscale;
    }

    triggered = true;
}

if (triggered)
{
    if(type == "moveto")
    {
        movetoT += 1;
        var f,tx,ty;
        f = clamp(movetoT / movetoDuration, 0, 1);
        f = scrEaseValue(f, movetoEase)

        tx = lerp(xstart, xto, f);
        ty = lerp(ystart, yto, f);
        hspeed = tx - x;
        vspeed = ty - y;
    }
    else if (bounce)
    {
        with(inst)
        {
            if (!place_free(x + other.hspeed, y))
            {
                other.hspeed *= -1;
            }
            if (!place_free(x, y + other.vspeed))
            {
                other.vspeed *= -1;
            }
        }
    }

    if (doFade)
    {
        fadeT += 1;
        var f;
        f = clamp(fadeT / fadeTime, 0, 1);
        f = scrEaseValue(f, fadeEase);

        if (fadeType == "out")
        {
            f = 1 - f;
            if (f <= 0)
            {
                instance_destroy_id(inst);
                instance_destroy();
            }
        }
        image_alpha = f;
    }

    if (doStretch)
    {
        scaleT += 1;
        var f;
        f = clamp(scaleT / scaleTime, 0, 1);
        f = scrEaseValue(f, scaleEase);
        if (!is_undefined(xscale))
        {
            image_xscale = lerp(xscalestart, xscale, f);
        }
        if (!is_undefined(yscale))
        {
            image_yscale = lerp(yscalestart, yscale, f);
        }
    }
}

motion_add(gravity_direction, gravity);
x += hspeed;
y += vspeed;

_hspeed = hspeed;
_vspeed = vspeed;
_gravity = gravity;
_gravity_direction = gravity_direction;

hspeed = 0;
vspeed = 0;
gravity = 0;
gravity_direction = 0;

event_user(1);
#define Other_10
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
///Init

if (h != 0 || v != 0)
{
    type = "move";
}
else if (xto != -1 || yto != -1)
{
    type = "moveto";
}
else if (path != -1)
{
    type = "path";
}
else if (grav != 0)
{
    type = "grav";
}
else if (spd != 0)
{
    type = "dir";
}
else
{
    type = "none";
}

doSound = (snd != "");
doFade = (fadeType != "none");
doStretch = (!is_undefined(xscale) || !is_undefined(yscale));

if (fadeType == "in")
{
    mask = inst.mask_index;

    inst.mask_index = sprEmpty;
    inst.image_alpha = 0;
}
#define Other_11
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
///Move affected instance

if (!instance_exists(inst))
{
    instance_destroy();
    exit;
}

if (!triggered) //Follow assigned instance until the trigger is active
{
    x = inst.x;
    y = inst.y;

    if (doStretch)
    {
        image_xscale = inst.image_xscale;
        image_yscale = inst.image_yscale;
    }
}
else
{
    if (type != "none")
    {
        inst.hspeed = x - inst.x;
        inst.vspeed = y - inst.y;
    }

    if (doFade)
    {
        inst.image_alpha = image_alpha;
        if (fadeType == "in")
        {
            inst.mask_index = mask_index;
        }
    }

    if (doStretch)
    {
        if (!is_undefined(xscale))
        {
            inst.image_xscale = image_xscale;
        }
        if (!is_undefined(yscale))
        {
            inst.image_yscale = image_yscale;
        }
    }
}
