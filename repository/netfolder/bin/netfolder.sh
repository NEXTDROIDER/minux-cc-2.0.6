-- netfolder client side launcher
args = {...}
command = args[1]
servername = args[2]
serverpath = args[3]
localpath = args[4]
--catch errors
if command == nil or command == "" then
	print("netfolder:no input")
	return 700
end
local reply = false
-- process requests
if command == "getfile" and localpath ~= nil then
	reply = netfolder.getfile(servername,serverpath,localpath)
elseif command == "putfile" and localpath ~= nil then
	reply = netfolder.putfile(servername,serverpath,localpath)
elseif command == "putfolder" and serverpath ~= nil then
	reply = netfolder.putfolder(servername,serverpath, localpath)
elseif command == "getfolder" and serverpath ~= nil then
	reply = netfolder.getfolder(servername,serverpath, localpath)
elseif command == "delete" and serverpath ~= nil then
	reply = netfolder.delete(servername,serverpath)
elseif command == "list" and serverpath ~= nil then
	reply = netfolder.list(servername,serverpath)
else
	print("netfolder:Invalid input")
	return 700
end
-- process reply
if reply == 702 then
	print("Error 702, check system logs.")
elseif reply == 703 then
	print("Access denied")
elseif reply == 704 then
	print("File not found")
elseif reply == false then
	print("Unknown error, reply false.")
elseif reply == true then
	print("Netfolder:Accept")
elseif reply == 706 then
	print("Not a Directory")
elseif command == "list" then
	shell.run("less /temp/netfolder/list.ls")
end
