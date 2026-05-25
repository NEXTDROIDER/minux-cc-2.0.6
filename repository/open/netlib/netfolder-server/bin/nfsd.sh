-- netfolder server side launcher
args = {...}
command = args[1]
setfolder = args[2]

--catch errors
if command == nil or command == "" then
	print("nfsd:no input")
	return 0
end

-- process requests
-- first one is a simple test
if command == "status" then
	if _G.netfolderserver == true then print("Server is live!")
	else print("Server Offline") 
	end
elseif command == "start" then
	print("Starting Netfolder-Server")
	_G.netfolderserver = true
	shell.openTab("/etc/netfolder-server/listen.sys")
elseif command == "stop" then
	print("Stopping server, this might take a while")
	_G.netfolderserver = false
elseif command == "rootfolder" and setfolder ~= nil then
	if fs.exists(setfolder) == false then
		print("Folder not found")
		return 0
	end
	print("setting root folder")
	tempfile = fs.open("/usr/netfolder-server/root.db" , "w")
	tempfile.writeLine(setfolder)
	tempfile.close()
	_G.netfolderroot = setfolder
else
	print("nfsd:Invalid input")
end