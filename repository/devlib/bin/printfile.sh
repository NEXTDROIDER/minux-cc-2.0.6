args = {...}
local userinput = args[1]
local printname = args[2]
local filename = shell.resolve( userinput , printname)

if filename == nil then print("needs a file") return false end
if printname == nil then print("needs a print name") return false end

if fs.exists(filename) == false then
	print("File not found")
	return false
elseif fs.isDir(filename) == true then
	print("cannot print folders")
	return false
else
	dev.prepfile(filename)
	if fs.exists("/temp/devlib/prepfile.tmp") == true then
		dev.printfile("/temp/devlib/prepfile.tmp", printname)
	else
		minux.debug("printfile:E:no prepfile found!","dev")
		print("Error, no printfile!")
		return false
	end
	return true
end
