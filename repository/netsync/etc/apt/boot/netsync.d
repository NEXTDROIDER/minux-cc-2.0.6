-- netsync system settings
completion = require "cc.shell.completion"
completensync = completion.build({ completion.choice, { "load", "save","reset","add","del","set","list" } })
shell.setCompletionFunction("bin/netsync.sh", completensync)
-- end netsync system settings
