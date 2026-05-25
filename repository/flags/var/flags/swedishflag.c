function writeline()
	dev.colorwrite("             ","black", "blue")
	dev.colorwrite("  ","white","yellow")
	dev.colorprint("                                    ","black","blue")
end
counter = 0
while counter ~= 7 do
	writeline()
	counter = counter + 1
end
dev.colorprint("                                                    ","white","yellow")
counter = 0
while counter ~= 7 do
	writeline()
	counter = counter + 1
end
