-- netlib testing app, listen for input, then respond with the appropriate function
-- run when this file is launched directly, used for testing and debugging.

_G.netlisten = true
print("listen protocol active")
while _G.netlisten == true do
    local listenclient, listendata = rednet.receive(30)
    if listendata == "ping" then
        local tempdata = netlib.getping(listenclient)
        if tempdata == true then listendata = "true"
        else listendata = "false" end
        print("ping:id:"..listenclient.."-"..listendata)
    elseif listendata == "sendstring" then
        local tempdata = netlib.getstring(listenclient)
        if tempdata == false then tempdata = "false" end
        print("listenstring:id:"..listenclient.."-"..tempdata)
    elseif listendata == "sendtable" then
        tempdata = {}
        tempdata = netlib.gettable(listenclient)
        if tempdata[1] == nil then
            print("sendtable:id:"..listenclient.."-false")
        else
            print("sendtable:id:"..listenclient.."-true")
            local count = 1
            while tempdata[count] ~= nil do
                print(tempdata[count])
                count = count + 1
            end
        end
    end
end
