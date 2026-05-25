-- pixeltank launcher,this launches either the installer or the actual game as made by the developer.
-- visit https://forums.computercraft.cc/index.php?topic=452.0

if fs.exists("/TETRA.lua") then shell.run("/TETRA.lua")
else shell.run("/etc/tetra/installer.sys") end