if fs.exists("/etc/syncedaudio/player.sh") then
    shell.run("/etc/syncedaudio/player.sh")
else
    print("Synced_audioplayer installation script")
    print("----------------------------")
    print("This program is developed by 'GroupXyz'")
    print("All credits and rights belong to them")
    print("more information can be found in the manual file.")
    print("----------------------------")
    print("Hit enter to install, or ctrl+t to abort")
    read()
    shell.run("pastebin get https://pastebin.com/qb7qj169 /etc/syncedaudio/player.sh")
    shell.run("/etc/syncedaudio/player.sh")
end
