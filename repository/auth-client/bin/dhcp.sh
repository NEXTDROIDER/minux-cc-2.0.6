args = {...}
local command = args[1]
local etc = args[2]

if command == "renew" then
	shell.run("/boot/network/dhcp.sys")
elseif command == "register" then
	local temp, temp2 = dhcp.register(etc)
	if temp == true then print("system registered")
	elseif temp == "exists" then print("system already exists")
	elseif temp == "false" then print("Error:"..temp2)
	end
elseif command == "unregister" then
	local temp, temp2 = dhcp.unregister(etc)
	if temp == true then print("system unregistered")
	elseif temp == "noexist" then print("system doesn't exists")
	elseif temp == "false" then print("Error:"..temp2)
	end
elseif command == "lookup" then
	dhcp.lookup(etc)
	print("results for :"..etc)
	print("id:".._G.lookupid)
	print("name:".._G.lookupname)
	print("owner:".._G.lookupowner)
elseif command == "list" then
	local dnslist = {}
	dnslist = dhcp.dnslist()
	local listend = false
	local listcount = 1
	if dnslist == false or dnslist == nil then
		print("failed to retrieve list")
		return false
	end
	print("DHCP:".._G.server)
	print("AUTH:".._G.authserver)
	while listend == false do
		if dnslist[listcount] == nil then
			listend = true
		else
			print(dnslist[listcount])
			listcount = listcount + 1
		end
	end
else
	print("Invalid input, use 'man dhcp'")
end
