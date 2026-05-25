-- pixeltank launcher,this launches either the installer or the actual game as made by the developer.
-- visit https://forums.computercraft.cc/index.php?topic=589.0

if fs.exists("/tank.lua") then shell.run("/tank.lua")
else shell.run("/etc/pixeltank/installer.sys") end