-- netprint client controller script
args = { ... }
local printid = tonumber(args[1])
local printfile = args[2]
local printname = args[3]
-- catch empty input
if printfile == nil or printfile == "" then
    print("invalid input, try 'printfile serverid filepath")
    return false
end
if printname == nil then
    printname = printfile
end
-- "test" option
if printfile == "-test" then
    minux.debug("netprint test","netprint")
    print("Checking server:"..printid)
    local reply = netprint.testserver(printid,3)
    if reply == true then
        print("server-reply-true")
        return true
    else
        print("server-reply-false")
        return false
    end
end
-- catch invalid file
if fs.exists(printfile) ~= true then
    print("file not found")
    return false
end
-- if we're still here, read the file then send it to print
local reply = netprint.printfile(printid,printfile,printname)
print(reply)
