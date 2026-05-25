-- sysmon config, used to configure sysmon
-- catch and filter incomming arguments
args = { ... }
if _G.admin ~= true and _G.owner ~= _G.login then
    print("Not admin or owner, access denied!")
    return false
end

if args[1] == "refresh" then
    minux.debug("config:refresh","sysmon")
    local tmprefresh = tonumber(args[2])
    if tmprefresh == nil then
        print("invalid refresh data, must be number")
        minux.debug("config:refresh:nil","sysmon")
        return false
    elseif tmprefresh == 0 then
        print("setting this to 0 would cause a loop")
        print("i'm afraid i can't let you do that!")
        minux.debug("config:refresh:0","sysmon")
        return false
    else
        minux.debug("config:refresh:"..tmprefresh,"sysmon")
        local tmpsetting = {}
        if fs.exists("/usr/sysmon/settings.cfg") then
            tmpsetting = minux.readtable("/usr/sysmon/settings.cfg")
        end
        tmpsetting[1] = tmprefresh
        minux.writetable("/usr/sysmon/settings.cfg",tmpsetting)
        return true
    end
elseif args[1] == "sysdel" then
    minux.debug("config:del","sysmon")
    if args[2] == nil or args[2] == false then
        print("invalid system data, must be ID")
        minux.debug("config:del:nil","sysmon")
        return false
    elseif fs.exists("/usr/sysmon/systems/"..args[2]..".sys") then
        fs.delete("/usr/sysmon/systems/"..args[2]..".sys")
        print("system deleted")
        minux.debug("config:del:"..args[2],"sysmon")
        return true
    else
        print("system doesn't exist")
        minux.debug("config:del:noexist","sysmon")
        return false
    end
elseif args[1] == "sysadd" then
    minux.debug("config:addsys","sysmon")
    if args[2] == nil or args[2] == false then
        print("invalid system name")
        minux.debug("config:add:name:nil","sysmon")
        return false
    elseif args[3] == false or args[3] == nil then
        print("invalid system ID")
        minux.debug("config:add:ID:nil","sysmon")
        return false
    elseif fs.exists("/usr/sysmon/systems/"..args[3]..".sys") == true then
        print("System exists")
        minux.debug("config:add:exist","sysmon")
        return false
    else
        print("adding system")
        local sysdata = {args[3], args[2]}
        minux.writetable("/usr/sysmon/systems/"..args[3]..".sys",sysdata)
        minux.debug("config:add:"..args[2],"sysmon")
        return true
    end
else
    print("invalid argument")
    return false
end
