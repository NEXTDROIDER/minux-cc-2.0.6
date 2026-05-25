if fs.exists("/usr/lockdoor/side.cfg") then
    _G.lockdoor = true
    while _G.lockdoor == true do
        shell.run("/bin/lockdoor.sh")
    end
end
