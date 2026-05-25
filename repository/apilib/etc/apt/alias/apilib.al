-- apilib api's
-- apilib variables
_G.surfacepath = "/etc/apilib/surface.sys"
_G.surface = dofile(_G.surfacepath)
-- apilib alias
if fs.exists("/etc/apilib/palette.sys") then shell.setAlias("palette" , "/etc/apilib/palette.sys") end
-- apilib api
os.loadAPI("/etc/apilib/cprint")
os.loadAPI("/etc/apilib/apilib")
-- apilib alias
shell.setAlias("welcome", "/bin/welcome.sh")
-- apilib autocomplete
completion = require "cc.shell.completion"
completewelc = completion.build( { completion.file, many = true })
shell.setCompletionFunction("bin/welcome.sh", completewelc)
-- end apilib file