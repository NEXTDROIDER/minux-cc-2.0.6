-- lockdoor config program
print("how long should the door be open?")
write("time:")
local tdata = read()
local timefile = fs.open("/usr/lockdoor/time.cfg","w")
timefile.writeLine(tdata)
timefile.close()
local title = "Lockdoor configuration, side choser."
local choices = {}
choices = {"top", "bottom","left","right","front","back"}
local actions = {}
actions[1] = function()
    local sidefile = fs.open("/usr/lockdoor/side.cfg","w")
    sidefile.writeLine("top")
    sidefile.close()
end
actions[2] = function()
    local sidefile = fs.open("/usr/lockdoor/side.cfg","w")
    sidefile.writeLine("bottom")
    sidefile.close()
end
actions[3] = function()
    local sidefile = fs.open("/usr/lockdoor/side.cfg","w")
    sidefile.writeLine("left")
    sidefile.close()
end
actions[4] = function()
    local sidefile = fs.open("/usr/lockdoor/side.cfg","w")
    sidefile.writeLine("right")
    sidefile.close()
end
actions[5] = function()
    local sidefile = fs.open("/usr/lockdoor/side.cfg","w")
    sidefile.writeLine("front")
    sidefile.close()
end
actions[6] = function()
    local sidefile = fs.open("/usr/lockdoor/side.cfg","w")
    sidefile.writeLine("back")
    sidefile.close()
end
menu.menuOptions(title, choices, actions)
print("done!")
