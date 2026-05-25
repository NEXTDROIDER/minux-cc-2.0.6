-- auth client program
args = {...}
local command1 = args[1]
local command2 = args[2]
local command3 = args[3]

-- adding and deleting users
if command1 == "adduser" and command3 ~= nil then
	auth.useradd(command2,command3)
elseif command1 == "addadmin" and command3 ~= nil then
	auth.useradd(command2,command3,"ADM")
elseif command1 == "deluser" then
	auth.userdel(command2, command3)
elseif command1 == "setpass" and command3 ~= nil then
	auth.setpass(command2,command3)
elseif command1 == "setowner" and command3 ~= nil then
	auth.setowner(command2,command3)
elseif command1 == "setowner" and command2 ~= nil then
	auth.setowner(command2)
elseif command1 == "delowner" then
	auth.delowner()
else shell.run("/etc/minux-main/menu/auth.sys")
end
