-- netlib testing app, listen for input, then respond with the appropriate function
-- run when this file is launched directly, used for testing and debugging.

_G.netlisten = true
print("listen protocol active")
while _G.netlisten == true do
    local listenclient, listendata = rednet.receive()
    -- if we get a ping, we pong
    if listendata == "ping" then
        local tempdata = netlib.getping(listenclient)
        if tempdata == true then listendata = "true"
        else listendata = "false" end
        print("ping:id:"..listenclient.."-"..listendata)
    -- easy string transmission
    elseif listendata == "sendstring" then
        local tempdata = netlib.getstring(listenclient)
        if tempdata == false then tempdata = "false" end
        print("listenstring:id:"..listenclient.."-"..tempdata)
    -- easy table transmission
    elseif listendata == "sendtable" then
        tempdata = {}
        tempdata = netlib.gettable(listenclient)
        if tempdata[1] == nil then
            print("sendtable:id:"..listenclient.."-false")
        else
            print("testprint a")
            print("sendtable:id:"..listenclient.."-true")
            local count = 1
            while tempdata[count] ~= nil do
                print(tempdata[count])
                count = count + 1
            end
            print("testprint b")
        end
    -- request a session ID
    elseif listendata == "getSID" then
        print("id:"..listenclient.." -getsid:"..netlib.sendsid(listenclient))
    -- open a connection
    elseif listendata == "NL:CON:OPEN" then
        print("id:"..listenclient.." -connect:"..netlib.opensocket(listenclient))
    -- close a connection
    elseif listendata == "NL:DIS:REQ" then
        print("id:"..listenclient.." -disconect:")
        netlib.closesocket(listenclient)
    elseif fs.exists("/temp/netlib/conn/"..listendata) then
        local rdata = netlib.getdata(listenclient, listendata, 3)
        if rdata == 1117 or rdata == 1118 or rdata == 1119 or rdata == 1120 or rdata == 1121 then print("Error"..rdata)
        elseif rdata == false then print ("data=false")
        else print(rdata)
        end
    end
    -- clean up old connections
    local cleanup = netlib.cleanup()
    if cleanup ~= false and cleanup ~= nil and cleanup ~= true then
        print("timeout:"..cleanup)
    end
end
