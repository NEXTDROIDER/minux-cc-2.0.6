-- thanks to coppertj for showing how it's done

args = { ... }
if args[1] == nil then
    print("what song to play???")
    return 0
end
local dfpwm = require("cc.audio.dfpwm")
local speaker = peripheral.find("speaker")
local filepath = shell.resolve( args[1] )
local cycle = 0

-- open file
if fs.exists(filepath) then
    songfile = fs.open(filepath, "rb")
else
    print("file not found")
    return false
end

-- play the actual song
local song = songfile.read(1024*16)
while song ~= nil do
    local songdecoder = dfpwm.make_decoder()
    local playdata = songdecoder(song)
    speaker.playAudio(playdata)
    os.pullEvent("speaker_audio_empty")
    song = songfile.read(1024*16)
end
songfile.close()
print("done")
