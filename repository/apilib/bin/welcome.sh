args = { ... }
local welcomefile = args[1]

local reply = apilib.changewelcome(welcomefile)
if reply == true then print("Welcome file changed")
else print("change failed") end