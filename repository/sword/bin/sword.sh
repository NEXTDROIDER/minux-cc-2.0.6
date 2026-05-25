args = {...}
local swordfile = args[1]

if fs.exists("/etc/sword/sword.lua") == false then
	print("This is a 3rd party application")
	print("All credits go to 'ShreksHellraiser' on CC forums")
	print("press enter to install")
	input = read()
	shell.run("wget https://pinestore.cc/d/114 /etc/sword/sword.sys")
	shell.run("cd /etc/sword/")
	shell.run("/etc/sword/sword.sys")
end

if swordfile ~= nil and swordfile ~= "" then
	shell.run("/etc/sword/sword.lua "..swordfile)
	swordfile = nil
else
	shell.run("/etc/sword/sword.lua")
end