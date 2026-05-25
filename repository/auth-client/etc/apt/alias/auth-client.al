-- auth-client program pack
if fs.exists("/bin/auth-client.sh") then shell.setAlias("auth-client" , "/bin/auth-client.sh") end
if fs.exists("/bin/auth-group.sh") then shell.setAlias("auth-group" , "/bin/auth-group.sh") end
if fs.exists("/bin/dhcp.sh") then shell.setAlias("dhcp" , "/bin/dhcp.sh") end
if fs.exists("/bin/nslookup.sh") then shell.setAlias("nslookup" , "/bin/nslookup.sh") end
if fs.exists("/bin/groupadd.sh") then shell.setAlias("groupadd" , "/bin/groupadd.sh") end
if fs.exists("/bin/groupdel.sh") then shell.setAlias("groupdel" , "/bin/groupdel.sh") end
if fs.exists("/bin/groupcheck.sh") then shell.setAlias("groupcheck" , "/bin/groupcheck.sh") end
if fs.exists("/bin/groupjoin.sh") then shell.setAlias("groupjoin" , "/bin/groupjoin.sh") end
if fs.exists("/bin/groupleave.sh") then shell.setAlias("groupleave" , "/bin/groupleave.sh") end
if fs.exists("/bin/mask.sh") then shell.setAlias("mask" , "/bin/mask.sh") end
-- auth-client api's
os.loadAPI("/etc/api/auth")
os.loadAPI("/etc/api/dhcp")