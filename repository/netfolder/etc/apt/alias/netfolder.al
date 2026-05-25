-- netfolder client startup settings
if fs.exists("/bin/netfolder.sh") then shell.setAlias("netfolder" , "/bin/netfolder.sh") end
os.loadAPI("/etc/api/netfolder")