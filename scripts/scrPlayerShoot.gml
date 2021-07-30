if (instance_number(objBullet) < 4)
{
    instance_create(x,y,objBullet);
    sound_play("sndShoot");
}
