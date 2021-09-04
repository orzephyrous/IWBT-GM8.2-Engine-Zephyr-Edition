# Notes for playing online

## Brief

Since GM8.1 have various versions, iwpo only covers the most common version. So if you drag a gm82 game executable onto iwpo.exe, the output online version will be corrupted. Therefore, decompiling the online version executable and compiling it again is necessary.

However, iwpo can't indentify yoyoyo-based engines in gm8.x correctly, causing shared saves disable at all time because the save/load gml codes are not injected. Thus, some minor modifications are needed for the online version to work normally.

Moreover, because of the existence of gm82snd, external sound effects are recommended, which means moving the online save/chatbox sfx to "data" folder.

## Install

### iwpo 1.1.6

Download I wanna play online 1.1.6 [here](https://iwpo.dappermink.com/).

Source code of iwpo [here](https://gitlab.com/i-wanna-play-online).

### GM8Decompiler

GM8Decompiler repository [here](https://github.com/OpenGMK/GM8Decompiler).

### (httpdll2.3)

Download the latest httpdll2.3 from [Maarten Baert's website](https://www.maartenbaert.be/game-maker-dlls/http-dll-2/).

This will be unnecessary when gm82net includes the httpdll function names.

## Instructions

- Create game executable in GameMaker8.2 (e.g. from game.gm82, create game.exe)

- Create the online version of the game (Drag and drop game.exe onto iwpo.exe, then a corrupted online version, game_online.exe, will be generated)

- Decompile the online version (Drag and drop game_online.exe onto gm8decompiler.exe, then a .gm81 project, game_online.gm81 will be generated)

- Open the .gm81 project with GameMaker8.2 and do the following modifications

  - if the gm82net version you have does not include the function names of httpdll2.3, better exclude gm82net and include httpdll2.3 and change the save/load codes in scrSaveGame, scrLoadGame, objDifficultyMenu-Create, using buffer functions from httpdll2.3

  ```
  buffer_save() -> buffer_write_to_file()
  buffer_load() -> buffer_read_from_file()
  buffer_rc4() -> buffer_rc4_crypt()
  buffer_get_size() -> buffer_get_length()
  ```
  
  - save the 2 sound effects (\__ONLINE_sndSaved and __ONLINE_sndChatbox) to "data" folder and delete them in Sounds, change the input of sound_play functions to strings in Objects-objWorld-End Step, e.g.
  
  ```
  sound_play("__ONLINE_sndSaved");
  sound_play("__ONLINE_sndChatbox");
  ```
  
  - add the following to the end of scripts-scrSaveGame
  
  ```
  /// ONLINE
  // objWorld: The name of the world object
  // objPlayer: The name of the player object
  // : The name of the player2 object if it exists
  if (savePosition)
  {
  	if(!objWorld.__ONLINE_race)
      {
          if(room != rDifficultySelect)
          {
              buffer_clear(objWorld.__ONLINE_buffer);
              __ONLINE_p = objPlayer;
              if(instance_exists(__ONLINE_p))
              {
                  buffer_write_uint8(objWorld.__ONLINE_buffer, 5);
                  buffer_write_uint8(objWorld.__ONLINE_buffer, global.grav);
                  buffer_write_int32(objWorld.__ONLINE_buffer, __ONLINE_p.x);
                  buffer_write_float64(objWorld.__ONLINE_buffer, __ONLINE_p.y);
                  buffer_write_int16(objWorld.__ONLINE_buffer, room);
                  socket_write_message(objWorld.__ONLINE_socket, objWorld.__ONLINE_buffer);
              }
          }
      }
  }
  ```
  
  - add the following to the end of scripts-scrLoadGame
  
  ```
  /// ONLINE
  // objWorld: The name of the world object
  // objPlayer: The name of the player object
  // : The name of the player2 object if it exists
  if(objWorld.__ONLINE_sSaved)
  {
      if(room_exists(objWorld.__ONLINE_sRoom))
      {
          __ONLINE_p = objPlayer;
          
          if(global.grav != objWorld.__ONLINE_sGravity)
          {
              scrFlipGrav();
          }
          __ONLINE_p = objPlayer;
          __ONLINE_p.x = objWorld.__ONLINE_sX;
          __ONLINE_p.y = objWorld.__ONLINE_sY;
          room_goto(objWorld.__ONLINE_sRoom);
      }
      objWorld.__ONLINE_sSaved = false;
  }
  ```
  
  - In objects-objWorld-Create, the server can be changed by changing line 13, 40, 66 of the ONLINE codes. The `if` statement that starts on line 16 is unnecessary, only the stuffs in `else` matters.
  - In objects-objWorld-End Step,change line 153 to `buffer_write_float32(__ONLINE_buffer, __ONLINE_p.image_xscale*__ONLINE_p.xScale)` and line 154 to `buffer_write_float32(__ONLINE_buffer, __ONLINE_p.image_yscale*global.grav)`; delete line 77-82, 114-116 because they're for yuuutu games.
  - In objects-objWorld-Game End, only the following 3 lines are necessary:
  
  ```
  buffer_destroy(__ONLINE_buffer);
  socket_destroy(__ONLINE_socket);
  udpsocket_destroy(__ONLINE_udpsocket);
  ```
  
  - Tick "Run Create events before instance creation code" in Game Settings-Code Options otherwise warps in v0.1.0 will be corrupted.
  - Create executable for a normal online version.

