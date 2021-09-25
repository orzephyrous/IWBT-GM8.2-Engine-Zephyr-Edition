///sets the player's sprites, add sprite to each _spr... values
switch (global.playerSkin)
{
    case 1:
        _sprRunning = sprPlayerRunning;
        _sprIdle = sprPlayerIdle;
        _sprJump = sprPlayerJump;
        _sprFall = sprPlayerFall;
        _sprSliding = sprPlayerSliding;
        _sprDot = sprDotKid;
        _sprDotOutline = sprDotKidOutline;
        break;
    case 2:
        _sprRunning = sprPlayerRunningWhite;
        _sprIdle = sprPlayerIdleWhite;
        _sprJump = sprPlayerJumpWhite;
        _sprFall = sprPlayerFallWhite;
        _sprSliding = sprPlayerSlidingWhite;
        _sprDot = sprDotKidWhite;
        _sprDotOutline = sprDotKidOutlineWhite;
        break;
    default:
        break;
}
