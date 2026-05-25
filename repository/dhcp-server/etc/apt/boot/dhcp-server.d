-- 3rd party addon launcher
-- dhcp-server system settings
completion = require "cc.shell.completion"
completedhcpserv = completion.build({ completion.choice, { "status", "start", "stop", "auth"} })
shell.setCompletionFunction("bin/dhcp-server.sh", completedhcpserv)