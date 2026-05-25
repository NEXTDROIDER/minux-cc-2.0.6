-- tries to add a user to a group.
args = {...}
local groupname = args[1]
local username = args[2]
-- error catching
if groupname == nil or groupname == "" then
	print("Group name:")
	groupname = read()
end
if username == nil or groupname == "" then
	print("user name:")
	username = read()
end
if username == "" or username == nil or groupname == nil or groupname == "" then print("invalid input") return 0 end

-- attempt create
auth.joingroup(groupname, username)

-- reset values
groupname = nil
username = nil