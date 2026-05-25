args = {...}
local templogin = args[1]
local temppass = args[2]

minux.debug("mask.sh:called","auth")
if templogin == "remove" then auth.unmask()
if temppass == nil then
	write("Password:")
	temppass = read("*")
elseif temppass ~= nil then auth.mask(templogin, temppass)
else
	print("mask.sh:Invalid input, try either 'username password' or 'unmask'")
end
