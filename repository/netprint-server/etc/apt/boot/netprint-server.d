-- 3rd party addon launcher
-- netfolder-server system settings
completion = require "cc.shell.completion"
completeprintserv = completion.build({ completion.choice, { "start", "stop"} })
shell.setCompletionFunction("bin/netprint-server.sh", completeprintserv)
