///stops any music currently playing

global.currentMusicID = "";

if (global.currentMusic != "") sound_stop(global.currentMusic);

global.currentMusic = ""
