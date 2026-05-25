-- 3rd party addon launcher
-- dhcp-server system settings
completion = require "cc.shell.completion"
completetablaserv = completion.build({ completion.choice, { "status", "start", "stop"} })
shell.setCompletionFunction("bin/tablature-server.sh", completetablaserv)
