-- minux netlib getfile
-- written by shorun
args = { ... }
target = args[1]
file = args[2]
target = tonumber(target)

-- catch bad input and return feedback
if file == nil then print("No file") return false end
if target == nil then print ("no target id") return false end
if fs.exists(file) == true or fs.isDir(file) then print("this already exists") return false end

-- receive the file in a string
local gotfile = false
while gotfile == false do
    temp, data = rednet.receive()
    if data ~= nil and temp == target then
        local reply = netlib.getstring(target)
-- write the string in a file
        if reply ~= nil and reply ~= false then
            local tempfile = fs.open(file,"w")
            tempfile.write(reply)
            tempfile.close()
            return true
        end
    end
end


