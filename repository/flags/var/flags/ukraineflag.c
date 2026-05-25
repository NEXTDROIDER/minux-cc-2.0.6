-- horizontal stripe flags

function drawline(color)
	dev.colorprint("                                                    ","white",color)
end
counter = 0
while counter ~= 8 do
	drawline("blue")
	counter = counter + 1
end

counter = 0
while counter ~= 8 do
	drawline("yellow")
	counter = counter + 1
end

