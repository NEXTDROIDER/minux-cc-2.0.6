-- checks user membership of group
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
tempgroupmember = _G.isgroupmember
-- attempt create
auth.checkgroup(groupname, username)
if _G.isgroupmember == true then
	print("User is a member")
else
	print("User is not a member")
end

-- reset values
_G.isgroupmember = tempgroupmember
groupname = nil
username = nil
tempgroupmember = nil