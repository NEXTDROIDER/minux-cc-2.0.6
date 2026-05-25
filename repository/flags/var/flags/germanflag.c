-- horizontal stripe flags

function drawline(color)
	dev.colorprint("                                                    ","white",color)
end
counter = 0
while counter ~= 6 do
	drawline("black")
	counter = counter + 1
end

counter = 0
while counter ~= 5 do
	drawline("red")
	counter = counter + 1
end

counter = 0
while counter ~= 6 do
	drawline("yellow")
	counter = counter + 1
end
