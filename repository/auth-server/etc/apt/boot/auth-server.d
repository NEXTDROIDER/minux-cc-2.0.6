-- 3rd party addon launcher
-- auth-server system settings
completion = require "cc.shell.completion"
completeauthserv = completion.build({ completion.choice, { "status", "start", "stop", "adduser", "deluser", "addadmin", "encrypt" } })
shell.setCompletionFunction("bin/auth-server.sh", completeauthserv)
