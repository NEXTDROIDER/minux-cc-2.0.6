function writeline()
	dev.colorwrite("             ","black", "red")
	dev.colorwrite("  ","white","green")
	dev.colorprint("                                    ","black","red")
end
counter = 0
while counter ~= 7 do
	writeline()
	counter = counter + 1
end
dev.colorprint("                                                    ","white","green")
counter = 0
while counter ~= 7 do
	writeline()
	counter = counter + 1
end
