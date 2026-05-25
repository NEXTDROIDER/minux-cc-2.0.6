-- minux netlib ping binary
-- written by shorun
args = { ... }
target = args[1]

-- catch bad input and return feedback
if target == nil then print("No target system declared") return false end
if target == "localhost" then target = os.getComputerID() end
target = tonumber(target)

-- do the ping
print("Pinging:"..target)
local attempt = 0
local presponse
while attempt ~= 3 do
    attempt = attempt + 1
    local response = netlib.ping(target)
    if response == true then presponse = "reply!"
    else presponse = "noreply" end
    print("ping "..attempt.."/3:"..presponse)
end
