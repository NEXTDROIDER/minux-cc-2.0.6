--cryptofolder minux launcher
-- all credits for cryptofolder go to "Mensh123"

--dhcp server controller script
args = {...}
command = args[1]
command2 = args[2]
command3 = args[3]
print("Cryptofolder was created by 'Mensh123'")
print("CryptoNet was created by 'SiliconSloth'")
print("great thanks and all credits to them'")
shell.run("cd /etc/cryptofolder")

-- installation
if fs.exists("/etc/cryptofolder/cryptofolder.lua") == false then
	print("This is a 3rd party application, see the manual for more information")
	print("hit enter to continue")
	read()
	shell.run("/etc/cryptofolder/install.sys")
end

-- operation
if command == "server" and command2 ~= nil and command3 ~= nil then shell.openTab("/etc/cryptofolder/cryptofolder.lua "..command2.." "..command3)
elseif command == "update" then shell.run("/etc/cryptofolder/install.sys")
elseif command == "client" then shell.run("/etc/cryptofolder/cryptofolder-explorer.lua "..command2)
elseif command == "config" then shell.trun("/etc/cryptofolder/cryptofolder-config-generator.lua")
else print("Invalid input") end