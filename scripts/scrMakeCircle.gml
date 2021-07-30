///scrMakeCircle(x,y,angle,numprojectiles,speed,obj)
///spawns a ring of projectiles
///argument0 - spawn X
///argument1 - spawn Y
///argument2 - starting angle
///argument3 - number of projectiles to spawn
///argument4 - speed
///argument5 - projectile to spawn

var spawnX, spawnY, spawnAngle, spawnNum, spawnSpeed, spawnObj, a;
spawnX = argument0;
spawnY = argument1;
spawnAngle = argument2;
spawnNum = argument3;
spawnSpeed = argument4;
spawnObj = argument5;

var i;
for (i = 0; i < spawnNum; i += 1)
{
    a = instance_create(spawnX,spawnY,spawnObj);
    a.speed = spawnSpeed;
    a.direction = spawnAngle + i * (360 / spawnNum);
}
