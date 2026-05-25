-- auth group editor program
args = {...}
local command1 = args[1]
local command2 = args[2]
local command3 = args[3]

-- running trough input
if command1 == "makegroup" and command2 ~= nil then
	shell.run("/etc/auth-client/addgroup.sys "..command2)
elseif command1 == "delgroup" and command2 ~= nil then
	shell.run("/etc/auth-client/delgroup.sys "..command2)
elseif command1 == "adduser" and command3 ~= nil then
	shell.run("/etc/auth-client/gadduser.sys "..command2.." "..command3)
elseif command1 == "deluser" and command3 ~= nil then
	shell.run("/etc/auth-client/gdeluser.sys "..command2.." "..command3)
else print("invalid input, try 'man auth-group'")
end