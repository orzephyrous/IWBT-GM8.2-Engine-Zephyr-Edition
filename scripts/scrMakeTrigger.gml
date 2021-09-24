///scrMakeTrigger(trg)
//Use this to make any object triggerable. Check objTriggerManager Create event for options.
//Use example:
//with(scrMakeTrigger(1))
//{
//    h = 5;
//}

trgInst = instance_create(x, y, objTriggerManager)
trgInst.inst = id;
with(trgInst)
{
    trg = argument0;
}

return trgInst;
