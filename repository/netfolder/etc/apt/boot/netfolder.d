-- 3rd party addon launcher
-- netfolder-server system settings
completion = require "cc.shell.completion"
netcomplete = completion.build({ completion.choice, { "getfile", "putfile", "list", "delete", "getfolder", "putfolder"}}, { completion.dirOrFile, true } , completion.dirOrFile )
shell.setCompletionFunction("bin/netfolder.sh",netcomplete) 