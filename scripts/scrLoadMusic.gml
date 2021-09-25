///load external sound assets, .wav for sfx and .ogg for bgm

//sfx (uncompressed)
sound_add_directory("data\", ".wav", 0, 1)

//music (compressed,streamed)
sound_add_directory("data\", ".ogg", 1, 1)
