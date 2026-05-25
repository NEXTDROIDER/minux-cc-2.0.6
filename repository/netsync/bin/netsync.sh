-- netsync controller file
args = { ... }
command = args[1]
option = args[2]
extra = args[3]
local reply = false
-- set command
if command == "set" and option == "autosync" and extra == "enabled" then reply = netsync.setconfig(option,extra)
elseif command == "set" and option == "autosync" and extra == "disabled" then reply = netsync.setconfig(option,extra)
elseif command == "set" and option == "autodelete" and extra == "disabled" then reply = netsync.setconfig(option,extra)
elseif command == "set" and option == "autodelete" and extra == "enabled" then reply = netsync.setconfig(option,extra)
elseif command == "set" and option == "nfserver" and extra ~= nil then reply = netsync.setconfig(option,extra)
elseif command == "set" and option == "serverpath" and extra ~= nil then reply = netsync.setconfig(option,extra)
elseif command == "set" and option == "localpath" and extra ~= nil then reply = netsync.setconfig(option,extra)
-- reset config
elseif command == "reset" then reply = netsync.reset()
elseif netsync.getconfig("nfserver") == false then print("No netfolder server known, set one first.") return false
-- list sync file
elseif command == "list" then shell.run("less /home/".._G.login.."/netsync/synclist.db") return true
-- add sync templates
elseif command == "add" and option == "template" then
    local templatefile = "/usr/netsync/template/"..extra..".ls"
    if extra == "settings" then netsync.add("/home/".._G.login.."/minux-config/settings.cfg") return true
    elseif extra == "colour" or extra == "color" then netsync.add("/home/".._G.login.."/minux-config/bashcolours.cfg") return true
    elseif extra == "sonata" then netsync.add("/usr/sonata/".._G.login.."/local/") return true
    elseif fs.exists(templatefile) then
        local template = minux.readtable(templatefile)
        local tmpcount = 1
        while template[tmpcount] ~= nil do
            netsync.add(template[tmpcount])
            tmpcount = tmpcount + 1
        end
        return true
    else
        print("no such template")
        return false
    end
-- add command
elseif command == "add" and fs.exists(option) == true then reply = netsync.add(option)
-- del sync templates
elseif command == "del" and option == "template" then
    local templatefile = "/usr/netsync/template/"..extra..".ls"
    if extra == "settings" then netsync.del("/home/".._G.login.."/minux-config/settings.cfg") return true
    elseif extra == "colour" or extra == "color" then netsync.del("/home/".._G.login.."/minux-config/bashcolours.cfg") return true
    elseif extra == "sonata" then netsync.del("/usr/sonata/".._G.login.."/local/") return true
    elseif fs.exists(templatefile) then
        local template = minux.readtable(templatefile)
        local tmpcount = 1
        while template[tmpcount] ~= nil do
            netsync.del(template[tmpcount])
            tmpcount = tmpcount + 1
        end
        return true
    else
        print("no such template")
        return false
    end
-- del command
elseif command == "del" then reply = netsync.del(option)
elseif command == "load" then reply = netsync.load()
elseif command == "save" then reply = netsync.save()
-- if invalid
else print("Invalid input, try 'man netsync'") return false
end
-- user feedback
print("netsync:"..command)
if reply == true then
    print("Operation complete.")
    return true
else
    print("Operation failed.")
    return false
end
