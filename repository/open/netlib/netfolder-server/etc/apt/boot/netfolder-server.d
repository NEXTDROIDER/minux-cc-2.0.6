-- 3rd party addon launcher
-- netfolder-server system settings
completion = require "cc.shell.completion"
completenetserv = completion.build({ completion.choice, { "status", "start", "stop", "rootfolder"} })
shell.setCompletionFunction("bin/nfsd.sh", completenetserv)