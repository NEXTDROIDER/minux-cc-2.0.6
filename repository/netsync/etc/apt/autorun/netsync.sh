-- netsync system settings
if netsync.getconfig("nfserver") ~= false then
    netsync.checksettings()
    if netsync.getconfig("autosync") == true then
        print("Loading netsync profile...")
        netsync.load()
    end
end
