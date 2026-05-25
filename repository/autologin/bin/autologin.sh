-- minux autologin tool
args = { ... }
local login = args[1]
local psw = args[2]
-- check if current user is an admin
if _G.admin ~= true then
    print("Access denied")
    return false
end
-- check if we are using a login system
if minux.getconfig("login") == "disabled" then
    print("you do not have a login system set up!")
    return false
end
-- did we want to delete?
if login == "clear" then
    if fs.exists("/etc/apt/boot/autologin.d") then
        fs.delete("/etc/apt/boot/autologin.d")
        apt.bootbuild()
        print("auto login data cleared.")
        return true
    else
        print("no auto login data found")
        return false
    end
end
-- check credentials
if psw == nil or psw == false then
    print("invalid input")
    return false
end
print("testing login data...")
local udata = minux.checkuser(login,psw)
if udata[4] ~= true then
    print("test login failed.")
    return false
end
-- writing down file and running bootbuild
local tempfile = fs.open("/etc/apt/boot/autologin.d","w")
tempfile.writeLine("minux.login('"..login.."','"..psw.."')")
tempfile.close()
apt.bootbuild()
print("auto login configured.")
