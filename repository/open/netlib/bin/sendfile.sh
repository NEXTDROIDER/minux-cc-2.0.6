-- minux netlib sendfile
-- written by shorun
args = { ... }
target = args[1]
file = args[2]
target = tonumber(target)

-- catch bad input and return feedback
if file == nil then print("No file") return false end
if target == nil then print ("no target id") return false end
if fs.exists(file) == false or fs.isDir(file) then print("this is not a valid file") return false end

-- read the file
local tempfile = fs.open(file,"r")
local filedata = tempfile.readAll()
tempfile.close()

-- send the file
attempt = 0
keepalive = true
while attempt ~= 3 and keepalive == true do
    local reply = netlib.sendstring(target, filedata)
    attempt = attempt + 1
    if reply == true then
        print("File sent!")
        return true
    end
end
print("file not sent")
return false
