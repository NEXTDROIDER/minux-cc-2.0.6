-- open is meant to request a door opening
-- this is the client side handler, the door uses "door"

args = {...}
local systemname = args[1]
local duration = args[2]

-- catch invalid input
if systemname == nil or systemname == "" then
	print ("invalid input")
	return false
elseif duration == nil or duration == "" then
	duration = "5"
end
if _G.login == nil or _G.masterpass == nil
	then print("not logged in")
	return false
end

-- who is the door?
dhcp.lookup(systemname)
if _G.lookupid == "unknown" or _G.lookupid == nil then
	print("door name not found on dhcp")
	return false
end

-- contact the door
print("dhcp:doorname:".._G.lookupname..":ID:".._G.lookupid)
local doorid = tonumber(_G.lookupid)
rednet.send(doorid , "DOOR-REQ")
local data = netlib.getstring(doorid,1)
if data ~= "DOOR-ACK" then
	print("door offline or busy")
	return false
end

--send the data
local sendtable = {}
sendtable[1] = duration
sendtable[2] = _G.login
sendtable[3] = _G.masterpass
local reply = netlib.sendtable(doorid, sendtable)
if reply == false then
	print("Sync failed")
	return false
end

-- await reply
data = netlib.getstring(doorid,2)
if data == "DOOR-DENIED" then
	print("access denied.")
elseif data == "DOOR-ACCEPT" then
	print("Accepted, door opened.")
else
	print("no reply received, check the door output")
end
