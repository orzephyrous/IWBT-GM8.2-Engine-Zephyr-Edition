if (instance_number(objBullet) < 4)
{
    instance_create(x,y+6*global.grav*global.dotkid,objBullet);
    sound_play("sndShoot");
}
