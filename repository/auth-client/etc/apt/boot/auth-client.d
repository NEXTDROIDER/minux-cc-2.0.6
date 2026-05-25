-- 3rd party addon launcher
-- auth-client autocomplete
completion = require "cc.shell.completion"
completeauth = completion.build({ completion.choice, { "addadmin", "adduser", "deluser", "setpass" , "setowner", "delowner" } })
completeauthgroup = completion.build({ completion.choice, { "adduser", "deluser", "makegroup", "delgroup" } })
completedhcp = completion.build({ completion.choice, { "lookup", "renew", "register", "unregister", "list" } })

shell.setCompletionFunction("bin/auth-client.sh", completeauth)
shell.setCompletionFunction("bin/auth-group.sh", completeauthgroup)
shell.setCompletionFunction("bin/dhcp.sh", completedhcp)
-- auth client end
