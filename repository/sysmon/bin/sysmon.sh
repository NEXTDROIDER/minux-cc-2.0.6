-- first, look up the requirements to launch, read debug for more details
minux.debug("looking for monitor","sysmon")
if _G.monitor == nil then
    print("no monitor found")
    minux.debug("no monitor detected, aborting launch","sysmon")
    return false
end

if fs.exists("/usr/sysmon/systems/") == false then
    print("no systems folder found, create systems first")
    return false
end

minux.debug("loading settings file","sysmon")
if fs.exists("/usr/sysmon/settings.cfg") == false then
    print("settings file not found, run config first")
    return false
end

minux.debug("settings file found, checking..","sysmon")
local monsettings = {}
monsettings = minux.readtable("/usr/sysmon/settings.cfg")
local refreshtrigger = tonumber(monsettings[1])
if refreshtrigger == nil then
    print("refresh is not a number, invalid config","sysmon")
    return false
elseif refreshtrigger == 0 then
    print("refresh set to 0")
    print("i can't let you do that!")
    return false
end

minux.debug("looking for system files","sysmon")
local syslist = {}
local sysdata = {}
local syscount = 1
local datacount = 1
local sysname = nil
-- list the systems
syslist = fs.list("/usr/sysmon/systems/")
if syslist[syscount] == nil then
    print("no system file found, add systems first")
    minux.debug("no system file found, aborting","sysmon")
    return false
end

-- read the computer files
while syslist[syscount] ~= nil do
    minux.debug("found:"..syslist[syscount],"sysmon")
    sysdata[datacount] = minux.readtable("/usr/sysmon/systems/"..syslist[syscount])
    local tempdata = {}
    tempdata = sysdata[datacount]
-- adjust ID to number
    if tempdata ~= false and tempdata[1] ~= nil then
        tempdata[1] = tonumber(tempdata[1])
        minux.debug("stored","sysmon")
        sysdata[datacount] = tempdata
        datacount = datacount + 1
    else
        minux.debug("data false/nil","sysmon")
    end
    syscount = syscount + 1
end
print("files read, starting monitor.")
minux.debug("launching monitor","sysmon")

-- reset crash handler because we never reboot
minux.setconfig("crashhandler","disabled")

-- build the screen and ping the systems.
local refresh = true
local rebuild = false
local refreshcount = refreshtrigger
local sysreply = {}
monitor.clear()
while refresh == true do
    monitor.setCursorPos(1,1)
    minux.monitorprint(os.date())
    rebuild = true
    syscount = 1
    if refreshcount == refreshtrigger then
        print("refresh rate:"..refreshtrigger)
        minux.monitorprint("refresh rate:"..refreshtrigger)
        while sysdata[syscount] ~= nil do
            local tempdata = sysdata[syscount]
            minux.debug("pinging:"..tempdata[1],"sysmon")
            sysreply[syscount] = netlib.ping(tempdata[1])
            if sysreply[syscount] == true then
                minux.monitorprint("Name:"..tempdata[2].." ID:"..tempdata[1].." Online!")
            else
                minux.monitorprint("Name:"..tempdata[2].." ID:"..tempdata[1].." Offline")
            end
            syscount = syscount + 1
        end
        refreshcount = 0
    else
        refreshcount = refreshcount + 1
    end
    os.sleep(1)
end
