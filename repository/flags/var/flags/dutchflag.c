-- horizontal stripe flags

function drawline(color)
	dev.colorprint("                                                    ","white",color)
end
counter = 0
while counter ~= 5 do
	drawline("blue")
	counter = counter + 1
end

counter = 0
while counter ~= 5 do
	drawline("white")
	counter = counter + 1
end

counter = 0
while counter ~= 5 do
	drawline("red")
	counter = counter + 1
end
