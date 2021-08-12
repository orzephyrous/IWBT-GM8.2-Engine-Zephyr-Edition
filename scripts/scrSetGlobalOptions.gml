///sets configurable global options

global.debugMode = false;       //enables debug keys (check objWorld step to see all of them), make sure to set this to "false" before releasing your game
global.debugVisuals = true;    //enables changing the color/alpha of player when infjump/god mode are toggled, make sure to disable this if you want to change the player's image_alpha or image_blend
global.debugOverlay = false;    //enables showing the debug text overlay (shows player location, align, etc.)
global.debugNoDeath = false;    //enables god mode (toggle with Home key)
global.debugInfJump = false;    //enables infinite jump (toggle with End key)
global.debugShowHitbox = false; //enables showing the player's hitbox (toggle with Del key)

global.roomCaptionDef = "I Wanna Be The GM8.2 Engine Zephyr Edition v0.1.0 α";  //sets default window caption (only works with the Professional version of Studio)
global.roomCaptionLast = global.roomCaptionDef;
room_caption = global.roomCaptionDef;

global.password = "OTZephyr";  //sets save encryption password, can be changed to anything, should be set to something unique and hard to predict (like setting a password)

global.startRoom = rSampleRoom;    //sets which room to begin with

global.menuMode = 1;            //sets whether to use a warp room or a menu for selecting the game's difficulty (0 = warp room, 1 = menu)
global.menuSound = "sndJump";     //sets what sound to use for navigating the main menu
global.adAlign = false;             //sets whether or not to enable A/D align
global.timeWhenDead = true;        //sets whether or not to count the in-game timer when the player is dead
global.timeWhenClear = false;    //sets whether or not to count the in-game timer when game is cleared
global.edgeDeath = true;           //sets whether to kill the player when he leaves the boundaries of the room
global.pauseDelayLength = 40;   //sets the delay in frames in which the player can pause/unpause the game (can be set to 0 to disable pause delay)
global.delayBow = false;            //sets whether to delay the player bow's movement by a frame or not (most engines have the bow lagging behind the player by a frame, so set this to "true" to make the bow look like it does in other engines)
global.directionalTapFix = false;    //sets whether to change the behavior of tapping left/right for less than 1 frame (by default the player does not move when this happens, enabling this always moves the player for 1 frame when left/right is tapped)
global.playerAnimationFix = false;  //sets whether to fix the weird player animation inconsistencies when moving around
global.alignShow = true;    //sets whether to show player's y align when pressing global.alignShowButton
global.bowAdvanced = true;    //sets whether to change bow color when player loses double jump

global.secretItemTotal = 8;     //sets how many secret items for the game to save/load
global.bossItemTotal = 8;       //sets how many boss items for the game to save/load
global.autosaveSecretItems = false; //sets whether to save secret items immediately when you grab them or if you have to hit a save

global.closingAnimation = true;    //sets whether to have a animation when game ends
