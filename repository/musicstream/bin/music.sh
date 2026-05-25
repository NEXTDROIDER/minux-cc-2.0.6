if fs.exists("/etc/musicstream/music.sys") == false then
	print("This is a 3rd party application")
	print("All credits go to 'Terreng' on Github")
	print("it REQUIRES a speaker to function, otherwise it won't work at all")
	print("press enter to install")
	input = read()
	shell.run("pastebin get Rc1PCzLH /etc/musicstream/music.sys")
end
shell.run("/etc/musicstream/music.sys")
