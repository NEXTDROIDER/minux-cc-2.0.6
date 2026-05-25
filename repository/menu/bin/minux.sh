-- base UI package
-- error catcher, prevent crashing a system when set as default UI
local errormode = false
local errortype = false
if _G.validlogin == false then print("Not logged in!") errormode = true errortype = "login" end
if errormode == true then
	print("Cannot load menu")
	print("Error:E:211:"..errortype)
	print("")
	print("type 'bash' to start minux shell")
	print("type 'craftos' to start vanilla")
	print("anything else to exit")
	input = read()
	if input == "bash" then shell.run("/etc/minux-main/workspace/shell.lua")
	elseif input == "craftos" then shell.run("/rom/programs/shell.lua")
	else return false
	end
end
errormode = nil
errortype = nil

-- we begin building the menu
minux.debug("Launching menu", "minux")
local menuactive = true
while menuactive == true do
	local title = "Minux V:".._G.version.." U-".._G.login
	local choices = {}
	if pocket or turtle then
		choices = {"bash prompt","favorites" , "exe list" , "file explorer"," ", "APT software manager","system manuals" , "settings","users/auth", " ","lock session", "switch user", "shut down", "reboot"}
	else 
		choices = {"Bash command prompt/shell","favorites/shortcuts - user created /ubin", "exe list - installed programs /gbin" , "file explorer - exe's are in /gbin" , " ", "APT software manager/downloader","display manuals - help files and info","local system settings and options","AUTH user/group configuration"," ","lock the current session","switch to another user","shut down the computer", "reboot computer or exit menu"}
	end
	local actions = {}

	actions[1] = function()
	minux.debug("menu:Starting shell" , "minux")
	os.run({},"/etc/minux-main/workspace/shell.lua")
	end
	actions[2] = function()
	shell.run("/etc/minux-main/menu/favorites.sys")
	end
	actions[3] = function()
	shell.run("/etc/minux-main/menu/programs.sys")
	end
	actions[4] = function()
	if fs.exists("/bin/minex.sh") == false then apt.install("minex") end
	shell.run("/bin/minex.sh")
	end
	actions[5] = function()
	end
	actions[6] = function()
	minux.debug("menu:software manager" , "minux")
	shell.run("/etc/minux-main/menu/soft.sys")
	end	
	actions[7] = function()
	minux.debug("menu:manuals","minux")
	shell.run("/gbin/man.exe")
	end
	actions[8] = function()
	minux.debug("menu:configuration menu" , "minux")
	shell.run("/etc/minux-main/menu/config.sys")
	end
	actions[9] = function()
	minux.debug("menu:network menu" , "minux")
	shell.run("/etc/minux-main/menu/auth.sys")
	end
	actions[10] = function()
	end
	actions[11] = function()
	minux.debug("menu:lock" , "minux")
	minux.lock()
	end	
	actions[12] = function()
	term.clear()
	term.setCursorPos(1,1)
	minux.debug("menu:switchuser" , "minux")
	local tmpdt = _G.login
	shell.run("/bin/login.sh")
	if tmpdt == _G.login then
		print("user change failed, hit enter to continue")
		read()
	end
	end	
	actions[13] = function()
	minux.debug("menu:shutdown" , "minux")
	minux.halt()
	end
	actions[14] = function()
	minux.debug("menu:reboot/exit" , "minux")
	if minux.getconfig("ui") == "menu" then
		minux.restart()
	end
	menuactive = false
	end
	menu.menuOptions(title, choices, actions)
end
term.clear()
term.setCursorPos(1,1)
print("Exiting menu")
