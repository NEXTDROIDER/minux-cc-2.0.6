-- lockdoor, standalone door password program using local auth
-- if you don't want to use local auth, try "passdoor"
-- checking requirements
if minux.getconfig("login") == "disabled" then
    print("lockdoor requires local authenthication to be enabled")
    print("aborting")
    read()
    return false
elseif minux.getconfig("encrypt") == "disabled" then print("Warning:password encryption disabled!") end
if fs.exists("/usr/lockdoor/side.cfg") == false then
    print("lockdoor not configured, starting configuration")
    print("hit enter to proceed")
    read()
    shell.run("/etc/lockdoor/config.sh")
end
-- loading configuration
local sidefile = fs.open("/usr/lockdoor/side.cfg","r")
local side = sidefile.readLine()
sidefile.close()
local timefile = fs.open("/usr/lockdoor/time.cfg","r")
local tdata = tonumber(timefile.readLine())
timefile.close()
-- starting lock
_G.lockdoor = true
rs.setOutput(side,false)
while _G.lockdoor == true do
    term.clear()
    print("The way is shut")
    print("speak friend, and enter!")
    write("name:")
    local lname = read()
    write("pass:")
    local lpsw = read("*")
    print("verifying")
    minux.login(lname,lpsw)
    if _G.validlogin == true then
        _G.lockdoor = false
        rs.setOutput(side,true)
        print("lock opened, terminate program now to close")
        sleep(tdata)
        _G.lockdoor = true
        rs.setOutput(side,false)
    else
        print("Access denied")
        sleep(3)
    end
end
