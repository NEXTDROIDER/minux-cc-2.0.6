args = {...}
if args[1] == "start" then
loop = true
end
term.clear()
time=os.date()
print(time)
if monitor ~= nil then
monitor.clear()
monitor.setCursorPos(1,1)
minux.monitorprint(time)
monitor.setTextColor(colors.yellow)
end

while loop == true do
	term.clear()
	time = os.date()
	term.setCursorPos(1,1)
	print(time)
	if monitor ~= nil then
	monitor.setCursorPos(1,1) 
	minux.monitorprint(time)
	end
	os.sleep(1)
end
