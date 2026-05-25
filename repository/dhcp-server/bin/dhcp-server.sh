--dhcp server controller script
args = {...}
command = args[1]
etc = args[2]

if command == "auth" and etc ~= nil then
	print("authentication server set to "..etc)
	file = fs.open("/usr/dhcp-server/auth.cfg","w")
	file.writeLine("AUTHCONF")
	file.writeLine(etc)
	file.close()
elseif command == "status" then
	if _G.dhcpenabled == true then
		print("dhcp server running")
	else
		print("dhcp server offline")
	end
elseif command == "start" then
	if _G.dhcpenabled == true then
		print("dhcp server already running")
	else
		shell.openTab("/etc/server.sys")
	end
elseif command == "stop" then
	if _G.dhcpenabled == true then
		print("dhcp server stopping")
		_G.dhcpenabled = false
	else
		print("dhcp server not running")
	end
else 
	print("Use man dhcp-server for more information")
end