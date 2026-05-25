-- tries to create a new group
args = {...}
local groupname = args[1]
-- error catching
if groupname == nil or groupname == "" then
	print("Group name:")
	groupname = read()
end
if groupname == "" or groupname == nil then print("invalid input") return 0 end

-- attempt create
auth.groupadd(groupname)

-- reset values
groupname = nil