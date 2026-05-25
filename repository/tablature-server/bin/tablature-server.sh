-- tablature server controller script
args = { ... }

if args[1] == "stop" then
    if _G.tablaturerunning == true then
        print("stopping server")
        _G.tablaturerunning = false
    else
        print("Tablature server is not running")
    end
elseif args[1] == "start" then
    if _G.tablaturerunning == true then
        print("Tablature server is already running")
    else
        print("Starting Tablature server")
        shell.openTab("/etc/server.sys")
    end
elseif args[1] == "status" then
    if _G.tablaturerunning == true then
        print("Tablature server is running")
    else
        print("Tablature server is not running")
    end
end
