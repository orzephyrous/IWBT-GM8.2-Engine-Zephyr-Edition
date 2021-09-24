# IWBT-GM8.2-Engine-Zephyr-Edition

"I Wanna" engine developed in GameMaker 8.2, based on [IWBT studio engine yoyoyo edition v1.51](https://github.com/YoYoYoDude/YoYoYo_Engine), with some references to [renex engine](https://github.com/omicronrex/renex-engine) and YoYoYo engine verve edition. The engine is probably ready since my first game using this engine, [Weirdle 4](https://delicious-fruit.com/ratings/game_details.php?id=23474), has just been released.

## Background

GameMaker 8.2 fixed the input delay bug in GM8, making it being a better choice than Gamemaker:Studio for fangames as it opens and compiles faster (for me, at least). Therefore, I made this engine for my own IWBTG fangame projects. 

This engine just consists of the basic stuffs in fangames. Use renex engine if you want fancy features or/and gimmicks. In fact, I made this engine because I don't need those in my jtool-needle games.

## Install

### GameMaker 8.2

Download the GameMaker 8.2 installer [here](https://www.dropbox.com/s/87jc37aq3dgsp7b/gm82.7z?dl=0), run "install.bat" and there will be shortcuts on your desktop.

You can find related resources in the gm82 server: discord.gg/P2hdajXnQk

Version of extensions in this engine NOW:

GM8.2 Core 1.3.2

GM8.2 Sound 1.1.7

GM8.2 Network 1.0.2

### Engine

Download in "Releases" or download code for latest updates. Unzip then you can open the .gm82 file with gamemaker 8.2.

## Features

The engine is mostly yoyoyo, featuring (copied from yoyoyo engines readme.txt):

- Includes a main menu system with options menu
- Includes gravity flipping, waters(Catharsis water and water1,2,3) platforms (&sideway platforms), vines, jump refreshers, simple triggers and trap killers 
- Includes slopes that support any shape
- Mute/unmute music with Ctrl+M
- Stretchable window size (reset with F5)
- Pause screen that shows deaths/time with volume controls
- Includes toggleable debug keys ("Tab" to drag player to mouse, "Backspace" to toggle debug overlay, "Ins" to save, "Del" to toggle showing the hitbox, "Home" to toggle god mode, "End" to toggle infinite jump, "Page Up" to go to next room, "Page Down" to go to previous room)
- Several options for many things you might want to change for your game (such as enabling/disabling death music) in the "scrSetGlobalOptions" script

References to renex engines:

- Save encryption using buffer (set global.password in scrSetGlobalOptions)
- Optional closing animation (optional, set global.closingAnimation in scrSetGlobalOptions)
- Loading music from external folder
- Focus check (player movements disabled when the game window is not in focus)

References to verve:

- Everything solid is equal to block
- Moving block that pushes and carries player normally
- General trigger system (see the creation code of objTriggerManager and scrMakeTrigger)

New modifications:

- Optional platform squish performance (see global.platformMode in scrSetGlobalOptions)
- Dot kid available for both gravity directions (press Ctrl to toggle dot kid in debug mode)
- Optional skin system for standard player and dot kid (press 1 for default skin, 2 for white kid, and there can be more) 
- Depth of many objects are changed according to my custom (however, the suggested block tile depth is 9).
- V-string (y-align) display ("V" by default)
- Showing "Clear!" on window caption when the game is cleared
- Option to stop the timer when the game is cleared (set global.timeWhenClear in scrSetGlobalOptions)
- Option to have a different bow color when player doesn't have second jump (set global.bowAdvanced in scrSetGlobalOptions)
- Screen capture with F9 
- All audio related functions in GM:S are changed to gm82snd functions
- Sound effect for saves(sndSave, default sound effect from my Weirdle series)
- Save-block animates as in jtool
- Removes death music(musOnDeath) and changed death sound(sndDeath, also from Weirdle series)
- Removes joystick support because I can't test it (but the global buttons are still arrays so if you really need it, you can add them with gm82joy functions)

## Usage Notes

- Basically everything is the same as yoyoyo engine, but musics and sound effects are loaded externally
- GM8.2 Sound supports a lot of audio formats, but I've only tested .wav as sound effects and .ogg, .mod as bgm. Modify scrLoadGame if you want to have more formats
- As gm82snd uses fmod, the loading image is set to the fmod logo
- There are examples in scrGetMusic for how you set bgm for rooms, simply you add room name to a case and set roomSong = "name of bgm". e.g. if your bgm filename is "bgm1.ogg", and you want it to be the bgm of "roomStage1" and "roomStage2", just add codes in the switch statement like the following:

```
switch{
    ...
    case roomStage1:
    case roomStage2:
        roomSong = "bgm1";
        break;
    ...
    default:
        roomSong = "";
        break;
}
```

- You can also place an objPlayMusic object in the room and set the variable "BGM" in its creation code. If you want something to stop music, use "scrStopMusic"
- A template room (rTemplate) that has all of the correct view settings is included which can be duplicated and modified
- A sample room is included not as an example for good needle but just for me to test the engine
- If you're using slopes, it's possible that certain gimmicks such as ice blocks might not work properly with them because of how they're coded
- Game saves are stored in the same folder with the .gm82/.exe file
- Make sure to set the "global.debugMode" variable in the "scrSetGlobalOptions" script to "false" before releasing your game, otherwise debug keys will still work
- Make sure to set the "global.password" string in the "scrSetGlobalOptions" script to something unique to your game to make saves harder to modify
- Make sure to release your game with the "data" folder (where the audio files are stored)
- Making an online version is much more complicated than just draging the executable to iwpo.exe, see [po.md](po.md) for instructions.

## Acknowledgement

Thanks ebb174 for testing this engine.

## Contact

Discord: Zephyr#6056
