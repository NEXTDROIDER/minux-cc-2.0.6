-- does a dhcp lookup and prints
args = {...}
local target = args[1]
-- error catching
if target == nil or target == "" then print("useradd:invalid input") return 0 end

-- do the actual lookup, then print the results.
dhcp.lookup(target)
print("Name:".._G.lookupname)
print("ID:".._G.lookupid)
print("OWNER:".._G.lookupowner)