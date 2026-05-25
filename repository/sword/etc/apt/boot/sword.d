-- 3rd party addon launcher
-- minux autocomplete function script
swordcompletion = require "cc.shell.completion"
swordcomplete = swordcompletion.build( { completion.file, many = true })
shell.setCompletionFunction("bin/sword.sh", swordcomplete)
