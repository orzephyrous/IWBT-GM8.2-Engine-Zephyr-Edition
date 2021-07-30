///gets which song is supposed to be playing for the current room and plays it

var roomSong;

switch (room)                       //determines which song to play
{
    case rTitle:                    //add rooms here, if you have several rooms that play the same song they can be put together
    case rMenu:
    case rOptions:
    case rSampleRoom:
        roomSong = "musCarpeDiem";
        break;                      //make sure to always put a break after setting the song
    default:                        //default option in case the room does not have a song set
        roomSong = "";
        break;
}

if (roomSong != "")
    scrPlayMusic(roomSong,true); //play the song for the current room
