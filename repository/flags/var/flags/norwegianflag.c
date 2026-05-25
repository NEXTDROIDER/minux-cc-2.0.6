function writeline()
	dev.colorwrite("             ","black", "red")
	dev.colorwrite(" ","white","white")
	dev.colorwrite("  ","white", "blue")
	dev.colorwrite(" ","white", "white")
	dev.colorprint("                                  ","black","red")
end
counter = 0
while counter ~= 6 do
	writeline()
	counter = counter + 1
end
dev.colorwrite("              ","white","white")
dev.colorwrite("  ","white","blue")
dev.colorprint("                                   ","white","white")
dev.colorprint("                                                    ","white","blue")
dev.colorwrite("              ","white","white")
dev.colorwrite("  ","white","blue")
dev.colorprint("                                    ","white","white")
counter = 0
while counter ~= 6 do
	writeline()
	counter = counter + 1
end
