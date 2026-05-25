if fs.exists("/etc/ldris/ldris.lua") == false then
	print("This is a 3rd party application")
	print("All credits go to 'LLDestroier' on CC forums")
	print("press enter to install")
	input = read()
	shell.run("wget https://github.com/LDDestroier/CC/raw/refs/heads/master/ldris2.lua /etc/ldris/ldris.lua")
end
shell.run("/etc/ldris/ldris.lua")
