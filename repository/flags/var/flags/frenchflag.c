-- make a belgian flag!
-- dev.colorprint("                                                    ","black", "black")
function drawline()
	dev.colorwrite("                 ","black", "blue")
	dev.colorwrite("                 ","yellow", "white")
	dev.colorwrite("                 ","red", "red")
	print("")
end
counter = 0
while counter ~= 15 do
	drawline()
	counter = counter + 1
end
dev.colorset("green","blue")
print("             Welcome to Minux V:".._G.version.."              ")
dev.colorreset()
