-- config command tool.
args = {...}
local config = args[1]
local setting = args[2]

-- shelltype config
if config == "shell" then
	if setting == "basic" or setting == "advanced" then
		local settingline = minux.findline("/usr/door/settings.cfg","shelltype=")
		if settingline ~= false then minux.removeline("/usr/door/settings.cfg",settingline) end
		minux.insertline("/usr/door/settings.cfg","shelltype="..setting)
	end
elseif config == "toggle" then
	if setting == "enabled" or setting == "disabled" then
		local settingline = minux.findline("/usr/door/settings.cfg","toggle=")
		if settingline ~= false then minux.removeline("/usr/door/settings.cfg",settingline) end
		minux.insertline("/usr/door/settings.cfg","toggle="..setting)
	else print("invalid setting")
	end
elseif config == "side" then
	if setting == "front" or setting == "back" or setting == "left" or setting == "right" or setting == "top" or setting == "bottom" then
		local settingline = minux.findline("/usr/door/settings.cfg","side=")
		if settingline ~= false then minux.removeline("/usr/door/settings.cfg",settingline) end
		minux.insertline("/usr/door/settings.cfg","side="..setting)
	else print("invalid setting")
	end
else
-- no input means we start a menu to ask for input
	local doorconfigmenu = true
	while doorconfigmenu == true do
		local title = "Minux 'door' configuraton program."
		local choices = {"basic or multi shell mode", "set toggle mode", "set redstone output side", "exit menu"}
		local actions = {}
		
-- first option starts another menu, we build it
		actions[1] = function()
			local shelltitle = "basic or multi shell mode selection"
			local shellchoices = {"basic - starts door in main shell", "multi - starts door in multitab", "exit"}
			local shellactions = {}
			
			shellactions[1] = function()
				local settingline = minux.findline("/usr/door/settings.cfg","shelltype=")
				if settingline ~= false then minux.removeline("/usr/door/settings.cfg",settingline) end
				minux.insertline("/usr/door/settings.cfg","shelltype=basic")
				print("shelltype set to basic")
				print("hit enter to continue")
				read()					
			end
				
			shellactions[2] = function()
				local settingline = minux.findline("/usr/door/settings.cfg","shelltype=")
				if settingline ~= false then minux.removeline("/usr/door/settings.cfg",settingline) end
				minux.insertline("/usr/door/settings.cfg","shelltype=advanced")
				print("shelltype set to advanced")
				print("hit enter to continue")
				read()				
			end
			
			shellactions[3] = function()
			end	
			-- we run the menu for shell
			menu.menuOptions(shelltitle, shellchoices, shellactions)			
		end
		-- we build a menu for toggle
		actions[2] = function()
			local toggletitle = "toggle mode setting selection"
			local togglechoices = {"enabled - allows 0 to be used to toggle", "disabled - defaults 0 to 10", "exit"}
			local toggleactions = {}
			
			toggleactions[1] = function()
				local settingline = minux.findline("/usr/door/settings.cfg","toggle=")
				if settingline ~= false then minux.removeline("/usr/door/settings.cfg",settingline) end
				minux.insertline("/usr/door/settings.cfg","toggle=enabled")
				print("toggle set to enabled")
				print("hit enter to continue")
				read()
			end
				
			toggleactions[2] = function()
				local settingline = minux.findline("/usr/door/settings.cfg","toggle=")
				if settingline ~= false then minux.removeline("/usr/door/settings.cfg",settingline) end
				minux.insertline("/usr/door/settings.cfg","toggle=disabled")
				print("toggle set to disabled")
				print("hit enter to continue")
				read()				
			end
			
			toggleactions[3] = function()
			end	
			-- we run the menu for toggle
			menu.menuOptions(toggletitle, togglechoices, toggleactions)
		end
		 -- we chose the redstone side, this is a big one
		actions[3] = function()
			local sidetitle = "redstone side setting selection"
			local sidechoices = {"left", "right", "bottom", "top", "back", "front", "exit"}
			local sideactions = {}
			
			sideactions[1] = function()
				local settingline = minux.findline("/usr/door/settings.cfg","side=")
				if settingline ~= false then minux.removeline("/usr/door/settings.cfg",settingline) end
				minux.insertline("/usr/door/settings.cfg","side=left")
				print("redstone side set to left")
				print("hit enter to continue")
				read()					
			end
				
			sideactions[2] = function()
				local settingline = minux.findline("/usr/door/settings.cfg","side=")
				if settingline ~= false then minux.removeline("/usr/door/settings.cfg",settingline) end
				minux.insertline("/usr/door/settings.cfg","side=right")
				print("redstone side set to right")
				print("hit enter to continue")
				read()					
			end
			
			sideactions[3] = function()
				local settingline = minux.findline("/usr/door/settings.cfg","side=")
				if settingline ~= false then minux.removeline("/usr/door/settings.cfg",settingline) end
				minux.insertline("/usr/door/settings.cfg","side=bottom")
				print("redstone side set to bottom")
				print("hit enter to continue")
				read()					
			end

			sideactions[4] = function()
				local settingline = minux.findline("/usr/door/settings.cfg","side=")
				minux.removeline("/usr/door/settings.cfg",settingline)
				minux.insertline("/usr/door/settings.cfg","side=top")
				print("redstone side set to top")
				print("hit enter to continue")
				read()					
			end

			sideactions[5] = function()
				local settingline = minux.findline("/usr/door/settings.cfg","side=")
				if settingline ~= false then minux.removeline("/usr/door/settings.cfg",settingline) end
				minux.insertline("/usr/door/settings.cfg","side=back")
				print("redstone side set to back")
				print("hit enter to continue")
				read()					
			end

			sideactions[6] = function()
				local settingline = minux.findline("/usr/door/settings.cfg","side=")
				if settingline ~= false then minux.removeline("/usr/door/settings.cfg",settingline) end
				minux.insertline("/usr/door/settings.cfg","side=front")
				print("redstone side set to front")
				print("hit enter to continue")
				read()					
			end
			
			sideactions[7] = function()
			end	
			-- we run the menu for toggle
			menu.menuOptions(sidetitle, sidechoices, sideactions)
		end	
		-- action 4 is exit menu, we stop the while loop
		actions[4] = function()
			doorconfigmenu = false
		end	
		-- we run the main menu
		menu.menuOptions(title, choices, actions)
	end
end
