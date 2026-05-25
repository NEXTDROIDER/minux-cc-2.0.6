-- simple script to copy a floppy disk
print("Copydisk v1.0")

-- if no disk drive, abort now
if _G.diskside == "NONE" then
	print("Searching for disk drive")
	shell.run("/boot/hardware/diskdrive")
end
if _G.diskside == "NONE" then
	print("No disk drive detected")
	return 0
end

-- cleanup of temp dir, just in case.
if fs.exists("/temp/copydisk/diskcontents") then fs.delete("/temp/copydisk/diskcontents") end
print("insert the disk to copy, then hit enter.")
print("hold ctrl+t to terminate")
read()
print("Reading content...")
local disklabel = disk.getLabel(_G.diskside)
fs.copy("/disk/" , "/temp/copydisk/diskcontents/")
print("insert an empty disk, then hit enter.")
read()
shell.run("cp /temp/copydisk/diskcontents/* /disk")
disk.setLabel(_G.diskside , disklabel)
fs.delete("/temp/copydisk/diskcontents")
disklabel = nil