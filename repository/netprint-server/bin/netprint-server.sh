-- netprint server controller script
args = { ... }
local cmd1 = args[1]
local cmd2 = args[2]
-- stop server
if cmd1 == "stop" then
    _G.netprintrunning = false
    return true
end
--start server
if cmd1 == "start" then
    shell.openTab("/etc/server.sys")
    return true
end
--catch invalid input
print("invalid input")
