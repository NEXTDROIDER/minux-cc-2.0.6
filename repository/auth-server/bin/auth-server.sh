-- auth-server controller script
args = {...}
local command1 = args[1]
local command2 = args[2]
local command3 = args[3]

-- starting and stopping the server
if command1 == "start" then
	if _G.validloginenabled == true then
		print("AUTH server already running")
	else
		shell.openTab("/etc/server.sys")
	end
elseif command1 == "stop" then
	if _G.validloginenabled == true then
		print("Stopping server, this can take up to 5 seconds")
		_G.validloginenabled = false
	else
		print("AUTH server not running or already stopping")
	end
elseif command1 == "status" then
	if _G.validloginenabled == true then 
		print("AUTH server online")
	else
		print("AUTH server offline")
	end
elseif command1 == "adduser" and command2 ~= nil and command2 ~= "" and command3 ~= nil and command3 ~= "" then
	print("Running useradd for :"..command2)
	authserv.makeuser(command2,command3)
elseif command1 == "addadmin" and command2 ~= nil and command2 ~= "" and command3 ~= nil and command3 ~= "" then
	print("Running useradd for :"..command2)
	authserv.makeuser(command2,command3,"true")
elseif command1 == "deluser" and command2 ~= nil and command2 ~= "" then
	print("Running deleteuser for :"..command2)
	authserv.deluser(command2)
elseif command1 == "encrypt" then
	if command2 == "enabled" then
		if _G.authcrypt == true then
			print("already enabled")
		else
			minux.debug("AUTH-CRYPT:Generating key","minux")
			print("We need to generate a unique key, please enter a number.")
			repeat
				tempkey = read()
				if not tempkey:match("^%d+$") then
					print("Invalid, numbers only!")
				end
			until tempkey:match("^%d+$")
			_G.authkey = tonumber(tempkey)
			minux.debug("AUTH-CRYPT:encrypting user data","auth-server")
			minux.lsr("/usr/auth-server/userdata/")
			local tempfile = fs.open("/temp/ls/files.ls","r")
			local nus = tempfile.readLine()
			while nus ~= nil do
				minux.debug("AUTH-CRYPT:"..nus,"auth-server")
				local editfile = fs.open(nus,"r")
				local writefile = fs.open("/tmp/auth-server/tempfile.db","w")
				local tmpdata = "start"
				while tmpdata ~= nil do
					tmpdata = editfile.readLine()
					if tmpdata ~= "ADM" and tmpdata ~= "PSW" and tmpdata ~= nil then
						tmpdata = minux.encrypt(tmpdata,_G.authkey)
					end
					if tmpdata ~= nil then writefile.writeLine(tmpdata) end
				end
				writefile.close()
				editfile.close()
				fs.delete(nus)
				fs.move("/tmp/auth-server/tempfile.db",nus)
				nus = tempfile.readLine()
			end
			minux.debug("AUTH-CRYPT:saving key file","auth-server")
			local keyfile = fs.open("/usr/auth-server/data/crypt.db","w")
			keyfile.writeLine(_G.authkey)
			keyfile.close()
			_G.authcrypt = true
			minux.debug("AUTH-CRYPT:done","auth-server")
		end
	elseif command2 == "disabled" then
		if _G.authcrypt == true then
			minux.debug("AUTH-CRYPT:decrypting user data","minux")
			minux.lsr("/usr/auth-server/userdata/")
			local tempfile = fs.open("/temp/ls/files.ls","r")
			local nus = tempfile.readLine()
			while nus ~= nil do
				minux.debug("AUTH-CRYPT:"..nus,"auth-server")
				local editfile = fs.open(nus,"r")
				local writefile = fs.open("/tmp/auth-server/tempfile.db","w")
				local tmpdata = "start"
				while tmpdata ~= nil do
					tmpdata = editfile.readLine()
					if tmpdata ~= "ADM" and tmpdata ~= "PSW" and tmpdata ~= nil then
						tmpdata = minux.decrypt(tmpdata,_G.authkey)
					end
					if tmpdata ~= nil then writefile.writeLine(tmpdata) end
				end
				writefile.close()
				editfile.close()
				fs.delete(nus)
				fs.move("/tmp/auth-server/tempfile.db",nus)
				nus = tempfile.readLine()
			end
			fs.delete("/usr/auth-server/data/crypt.db")
			minux.debug("AUTH-CRYPT:done","minux")
			_G.authcrypt = false
			_G.authkey = 0
		else
			print("not enabled")
		end
	else
		print("invalid input")
	end
else
	print("invalid command")
end
