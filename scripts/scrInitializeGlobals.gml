///initializes all global variables needed for the game

scrSetGlobalOptions();       //initialize global game options

global.savenum = 1;
global.difficulty = 0;  //0 = medium, 1 = hard, 2 = very hard, 3 = impossible
global.death = 0;
global.time = 0;
global.timeMicro = 0;
global.saveRoom = "";
global.savePlayerX = 0;
global.savePlayerY = 0;
global.grav = 1;
global.saveGrav = 1;
global.dotkid = 0;
global.saveDotkid = 0;
global.playerSkin = 1;

var i;
for (i = global.secretItemTotal-1; i >= 0; i-=1)
{
    global.secretItem[i] = false;
    global.saveSecretItem[i] = false;
}

var i;
for (i = global.bossItemTotal-1; i >= 0; i-=1)
{
    global.bossItem[i] = false;
    global.saveBossItem[i] = false;
}

global.gameClear = false;
global.saveGameClear = false;

var i;
for (i = 99; i >= 0; i-=1)
{
    global.trigger[i] = false;
}

global.gameStarted = false;     //determines whether the game is in progress (enables saving, restarting, etc.)
global.noPause = false;         //sets whether or not to allow pausing (useful for bosses to prevent desync)
global.autosave = false;        //keeps track of whether or not to autosave the next time the player is created
global.noDeath = false;         //keeps track of whether to give the player god mode
global.infJump = false;         //keeps track of whether to give the player infinite jump

global.gamePaused = false;      //keeps track of whether the game is paused or not
global.pauseBg = -1;       //stores the screen surface when the game is paused
global.pauseDelay = 0;      //sets pause delay so that the player can't quickly pause buffer

global.currentMusicID = "";  //keeps track of what song the current music is
global.currentMusic = "";    //keeps track of current main music instance
global.deathSound = "";     //keeps track of death sound when the player dies
global.musicFading = false;     //keeps track of whether the music is being currently faded out
global.currentGain = 0;     //keeps track of current track gain when a song is being faded out

global.menuSelectPrev[0] = 0;     //keeps track of the previously selected option when navigating away from the difficulty menu
global.menuSelectPrev[1] = 0;     //keeps track of the previously selected option when navigating away from the options menu

//get the default window size
global.windowWidth = view_wview[0];
global.windowHeight = view_hview[0];

//keeps track of previous window position/size when display_reset is used for setting vsync
global.windowXPrev = 0;
global.windowYPrev = 0;
global.windowWidthPrev = 0;
global.windowHeightPrev = 0;

global.inFocus = 1;    //keeps track of whether the game window is in focus

randomize();    //make sure the game starts with a random seed for RNG
