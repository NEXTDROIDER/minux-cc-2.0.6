-- progdor autocomplete function script
progcompletion = require "cc.shell.completion"
progcomplete = progcompletion.build({ completion.choice, { "-pb", "-PB", "-dd", "-e", "-s" , "-r", "-t", "-S", "-a", "-c", "-m", "-i", "-o" } },{ completion.dirOrFile, true }, { completion.dirOrFile, true })
shell.setCompletionFunction("bin/progdor.sh", progcomplete)
