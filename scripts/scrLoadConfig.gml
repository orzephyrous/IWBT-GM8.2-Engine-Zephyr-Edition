///loads config settings, sets default config if it doesn't exist

ini_open("config.ini");

//settings
global.muteMusic = ini_read_real("Settings", "Mute_music", false);

global.volumeLevel = clamp(floor(ini_read_real("Settings", "Volume_level", 100)), 0, 100);
sound_global_volume(global.volumeLevel / 100);

global.fullscreenMode = ini_read_real("Settings", "Fullscreen_mode", false);
window_set_fullscreen(global.fullscreenMode);

global.smoothingMode = ini_read_real("Settings", "Smoothing_mode", false);

global.vsyncMode = ini_read_real("Settings", "Vsync_mode", false);
if (global.vsyncMode)   //only need to set vsync mode if it's on since it's off by default
    scrSetVsync();

//keyboard controls
global.leftButton[0] = ini_read_real("Controls", "Left", vk_left);
global.rightButton[0] = ini_read_real("Controls", "Right", vk_right);
global.upButton[0] = ini_read_real("Controls", "Up", vk_up);
global.downButton[0] = ini_read_real("Controls", "Down", vk_down);
global.jumpButton[0] = ini_read_real("Controls", "Jump", vk_shift);
global.shootButton[0] = ini_read_real("Controls", "Shoot", ord("Z"));
global.restartButton[0] = ini_read_real("Controls", "Restart", ord("R"));
global.skipButton[0] = ini_read_real("Controls", "Skip", ord("S"));
global.suicideButton[0] = ini_read_real("Controls", "Suicide", ord("Q"));
global.pauseButton[0] = ini_read_real("Controls", "Pause", ord("P"));
global.alignLeftButton[0] = ini_read_real("Controls", "Align_left", ord("A"));
global.alignRightButton[0] = ini_read_real("Controls", "Align_right", ord("D"));

//the key to show y-align
global.alignShowButton[0] = ord("V");

//menu keys (not rebindable)
global.menuLeftButton[0] = vk_left;
global.menuRightButton[0] = vk_right;
global.menuUpButton[0] = vk_up;
global.menuDownButton[0] = vk_down;
global.menuAcceptButton[0] = vk_shift;
global.menuBackButton[0] = ord("Z");
global.menuOptionsButton[0] = vk_enter;
global.menuDeleteButton[0] = vk_delete;

//skin number keys
global.skinButton1[0] = ord("1");
global.skinButton2[0] = ord("2");

ini_close();

scrSaveConfig();    //save config in case something changed
