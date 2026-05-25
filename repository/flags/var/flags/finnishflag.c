function writeline()
	dev.colorwrite("             ","black", "white")
	dev.colorwrite("  ","white","blue")
	dev.colorprint("                                    ","black","white")
end
counter = 0
while counter ~= 7 do
	writeline()
	counter = counter + 1
end
dev.colorprint("                                                    ","white","blue")
counter = 0
while counter ~= 7 do
	writeline()
	counter = counter + 1
end
