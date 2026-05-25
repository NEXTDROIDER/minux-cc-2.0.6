-- Sonata Web Browser
-- For ComputerCraft  by Missooni ♥
-- Some functions require Minux OS by shorun_qualtec
-- Free to edit / repackage for other projects. ^^
-- Not for use in training AI

local x, y
local termX, termY = term.getSize()
termX = termX-1
termY = termY-1
local siteHeight = 0

local cfgDir = "/usr/sonata/"..login.."/browser.cfg"
local defDir = "/usr/sonata/"..login.."/defaults.cfg"
local bDir = "/usr/sonata/"..login.."/local/"
local homeDir = bDir.."home.html"
local bkmkDir = bDir.."bookmarks.html"
local downloadDir = minux.printline(cfgDir, 14)
if not downloadDir then
	downloadDir = "/home/"..login.."/downloads/"
end
if not fs.isDir(downloadDir) then
	fs.makeDir(downloadDir)
end
local specialInTab = minux.printline(cfgDir, 21)
local specialAction = minux.printline(cfgDir, 24)
if specialInTab ~= "false" and specialAction ~= "true" then specialInTab = "true" end
if specialAction ~= "run" and specialAction ~= "download" and specialAction ~= "run" then specialAction = "run" end 

local body
local title
local currentSite
local prevSite
local function showPg(url, urlFile)
	currentSite = url
	local taggedTbl = {}
	local isScript
	local function readCache()
		-- Store the page as a table...
		local htmlTbl = {}
		siteHeight = 0
		if url:match("file://(.*)") then
			htmlTbl = minux.readtable(urlFile)
		else
			htmlTbl = minux.readtable("/temp/sonata/cache/"..urlFile)
		end
		for k, v in pairs(htmlTbl) do
			siteHeight = siteHeight + 1
			if isScript then v = v.."\n" end
			table.insert(taggedTbl, v)
			if k ~= 1 then
			htmlTbl[1] = htmlTbl[1]..v
			htmlTbl[k] = nil
			end
			if v:find("<script>") then isScript = true end
			if v:find("</script>") then isScript = nil end
		end
		-- Then turn it into a single string.
		body = htmlTbl[1]:match("<body.*>.*</body>")
		title = htmlTbl[1]:match("<title>(.*)</title>")
		if not title then title = "" end
		if not body and not htmlTbl[1] then body = "<br>" end
	end
	readCache()
	
	local patternTbl = {
	["<br>"] = "\n",
	["</br>"] = "\n",
	}

	local charTbl = {
	["%-"] = "%%%-",
	["%("] = "%%%(",
	["%)"] = "%%%)",
	["%."] = "%%%.",
	["%%"] = "%%%%",
	["%+"] = "%%%+",
	["%*"] = "%%%*",
	["%?"] = "%%%?",
	["%["] = "%%%[",
	["%^"] = "%%%^",
	["%$"] = "%%%$",
	}

	local charArray = "[%^%$%(%)%%%.%[%]%*%+%-%?]"

	local knownTags = {
	['<br>'] = "</br>",
	['<a href=".-"'] = "</a>",
	["<a href='.-'"] = "</a>",
	['<b>'] = "</b>",
	['<u>'] = "</u>",
	['<i>'] = "</i>",
	['<script>'] = "</script>",
	}


---

	-- Separate tags from strings.
	local ctp = "(%S.-)<"
	local formattedTbl = {}
	if body then
		taggedTbl = {}
		local cut = body:match(ctp)
		while cut do
			table.insert(taggedTbl, cut)
			body = body:sub(#cut+1, #body)
			cut = body:match(ctp)
		end
		
		-- Find strings in front of tags. 
		local tagStr
		local splitTbl = {}
		for k, v in pairs(taggedTbl) do 
			local add1, add2 = v:match("(<.->)(.*)")
			if add2 then
				table.insert(splitTbl, add1)
				table.insert(splitTbl, add2)
			elseif add1 then
				table.insert(splitTbl, add1)
			elseif v:match("%S") then
				table.insert(splitTbl, v)
			end
		end
		taggedTbl = splitTbl
			
		-- Remove all unknown tags/simplify HTML
		for k, v in pairs(taggedTbl) do
			if v:match("<.->") then
				known = false
				for tag1, tag2 in pairs(knownTags) do
				if known == true then break end 
				if v:find(tag1) or v:find(tag2) then
					known = true
					end
				end
				if not known then table.remove(taggedTbl, k) end
			end
		end

		-- Clear empty spaces and shorten long strings.
		for k,v in pairs(taggedTbl) do
			if v:match("<script>") then isScript = true
			elseif v:match("</script>") then isScript = false end
			if not isScript then
				if taggedTbl[k] and taggedTbl[k]:sub(2):match("^%s*$") then 
					taggedTbl[k] = v:match("%s([^%s].*)") 
				end
				if taggedTbl[k] and taggedTbl[k]:sub(-2):match("^%s*$") then 
					taggedTbl[k] = v:match("(.*[^%s])%s") 
				end
				if #v > termX and not v:match("<.->") then
					taggedTbl[k] = v:sub(1, termX-1)
					local lastSpace = taggedTbl[k]:match(".*%s()")
					if lastSpace then
						taggedTbl[k] = taggedTbl[k]:sub(1, lastSpace-1)
						table.insert(taggedTbl, k+1, v:sub(lastSpace, #v))
					else
						table.insert(taggedTbl, k+1, v:sub(termX, #v))
					end
				end
			end
		end
	else
		
	end

	-- Recreate page into a table with simple formatting.
	local printData = {}	
	local jsString = ""
	local link, isBold, isUline, isItalic, NFPdata
	local termX, termY = term.getSize()
	termX = termX-1
	termY = termY-1
	for k, v in pairs(taggedTbl) do
		printData = {
		["string"] = v,
		["link"] = link,
		["bold"] = isBold,
		["italics"] = isItalic,
		["uline"] = isUline,
		}
		if not v:match("<.->") and not isScript then
			table.insert(formattedTbl, printData)
		elseif v == "<br>" then
			table.insert(formattedTbl, {["string"] = "\n"})
		elseif v:find('<a href="(.-)"') then
			link = v:match('"(.-)"')
		elseif v:find("<a href='(.-)'") then
			link = v:match("'(.-)'")
		elseif v:match('</a>') then link = nil
		elseif v == "<b>" then isBold = true
		elseif v == "</b>" then isBold = nil
		elseif v == "<u>" then isUline = true
		elseif v == "</u>" then isUline = nil
		elseif v == "<i>" then isItalic = true
		elseif v == "</i>" then isItalic = nil
		elseif v == "<script>" then isScript = true
		elseif v == "</script>" then 
			if jsString:find("/NFP") and jsString:find("`(.*)`") then
				table.insert(formattedTbl, {["NFPdata"] = jsString:match("`(.-)`"), ["string"] = ""})
			end
			isScript = nil
			jsString = ""
		end
		if isScript then jsString = jsString..v end
	end

	-- Draw page on a window large enough to scroll.
	pageX, pageY = 2, 0
	local redirect
	local xit
	local ogTerm = term.current()
	local webPg = window.create(ogTerm, pageX, 2, termX+1, siteHeight)
	local searchBar = window.create(ogTerm, 1, 1, termX+1, 1)
	local scrollBar = window.create(ogTerm, 1, 2, 1, termY)
	searchBar.setBackgroundColor(colors.lightGray)
	searchBar.setTextColor(colors.gray)
	scrollBar.setBackgroundColor(colors.black)
	scrollBar.setTextColor(colors.lightGray)
	scrollBar.clear()
	local endOfPg
	local barHeight = 0
	local function drawScrollBar()
		if endOfPg < termY then barHeight = termY end
		for i = 1, barHeight do
			scrollBar.write("\149")
			x, y = scrollBar.getCursorPos()
			scrollBar.setCursorPos(1,y+1)
		end
	end
	local function writeSearchBar(txt, bg)
		searchBar.setCursorPos(1,1)
		if bg then term.setBackgroundColor(bg) end
		searchBar.blit("X ", "88" ,"77")
		if termX-2 > #title+#url then 
			searchBar.write(" "..txt..string.rep(" ", termX-#txt-2-#url))
			searchBar.blit(url, string.rep("0", #url) , string.rep("8", #url))
		else
			searchBar.write(" "..txt..string.rep(" ", termX-#txt-2))
		end
	end
	local function searchBarEvent()
		term.redirect(searchBar)
			writeSearchBar(" ", colors.white)
			local barField = {
			menu.formLabel(4, 1, termX-8, colors.gray, colors.white, "Enter Url...", colors.lightGray),
			}
			menu.buildForm(barField, 
			function(returns) 
				if returns[1].input:match("^%s*$") then writeSearchBar(title, colors.lightGray) elseif returns[1].input then redirect = returns[1].input end
			end, 
			termX-3, 1, 4, colors.white, colors.gray, " Go ")
			term.setBackgroundColor(colors.lightGray)
			term.redirect(webPg)
			if redirect then 
				if not redirect:match("://(.*)") then
					redirect = "https://"..redirect
				end
				if (redirect:match("https://(.*)") and not http.checkURL(redirect)) or (redirect:match("file://(.*)") and not fs.exists(redirect)) then 
					redirect = nil
					writeSearchBar("Site not found")
					os.sleep(1)
					writeSearchBar(title)	
				end
				if redirect then return redirect end
			end
	end
	writeSearchBar(title)
	term.redirect(webPg)
	local regionTbl = {}
	for i, v in ipairs(formattedTbl) do
		local sfx, pfx = "",""
		local ogBG, ogTxt
		term.setTextColor(colors.white)
		if v.italics then term.setTextColor(colors.lightGray) end
		if v.link then
			if v.link:find("apt%-i") then 
				term.setTextColor(colors.orange) pfx = "I-" 
			elseif v.link:find("apt%-s") then 
				term.setTextColor(colors.orange) pfx = "S-" 
			else term.setTextColor(colors.cyan) end
		end
		if v.bold then 
			ogBG, ogTxt = term.getBackgroundColor(), term.getTextColor()
			term.setBackgroundColor(ogTxt)
			term.setTextColor(ogBG)
		end
		if v.uline then pfx, sfx = "["..pfx,sfx.."]" end
		conString = pfx..v.string..sfx
		x, y = term.getCursorPos()
		if v.NFPdata then
			ogBG = term.getBackgroundColor()
			paintutils.drawImage(paintutils.parseImage(v.NFPdata), 1, y)
		elseif v.string ~= "\n" and not v.link then
			if x ~= 1 then 
				term.setCursorPos(1, y+1) 
				x, y = x, y+1
			end
			write(pfx..v.string..sfx)
			elseif (v.string == "\n" or v.link) then
		if v.link then 
			if termX-x < #v.string then 
				term.setCursorPos(1, y+1) 
				x, y = term.getCursorPos()
			end
			write(conString)
			table.insert(regionTbl, {
				["link"] = v.link,
				["x1"] = x,
				["y"] = y+2,
				["x2"] = x+#conString,
				["string"] = v.string,
			})
		else
				write(v.string)
		end
		end
		if ogBG then term.setBackgroundColor(ogBG) end
		if ogTxt then term.setTextColor(ogTxt) end
	end

	mX, mY = term.getCursorPos()
	endOfPg = mY
	local scrollTicks = endOfPg / termY
	local scrollStart = endOfPg - termY
	barHeight = math.floor(termY / scrollTicks)
	local moveTicks = math.floor((scrollStart/ (termY-barHeight))+0.5)
	local currentTick = 0
	local hasScrolled = 0
	local function calcScrollBar(goTo)
		local function scroll(by) 
			currentTick = pageY
			scrollBar.scroll(-by)
			hasScrolled = hasScrolled+by
		end
		if goTo == "min" then
			currentTick = 0
			scrollBar.scroll(hasScrolled)
			hasScrolled = 0
		elseif goTo == "max" then
			while pageY ~= endOfPg - termY do
				pageY = pageY + 1
				if pageY == currentTick + moveTicks then
					scroll(1)
				end
			end
		elseif pageY == currentTick + moveTicks then
			scroll(1)
		elseif pageY == currentTick - moveTicks then
			scroll(-1)
		end
	end	
	
	local function updateWindow(scroll)
		if scroll then pageY = pageY + scroll end
		webPg.reposition(pageX, -pageY+2)
		searchBar.reposition(1, 1)
		calcScrollBar()
	end

	drawScrollBar()
	while not xit and not redirect do
		event, button, x, y = os.pullEvent()
		if event == "mouse_scroll" or (event == "key" and (button == keys.up or button == keys.down)) then
		if endOfPg > termY-1 and (((button == -1 or button == keys.up) and pageY >= 1) or ((button == keys.down or button == 1) and endOfPg - pageY > termY)) then
			if button == keys.up then button = -1 elseif button == keys.down then button = 1 end
			updateWindow(button)
			end
		elseif event == "mouse_click" and y ~= 1 and x ~= 1 then
			y = y + pageY + 1
			for i, v in pairs(regionTbl) do
				if (x >= v.x1 and x <= v.x2 and y == v.y) then
				redirect = v.link
				end
			end
		elseif event == "mouse_click" and (y == 1 and x <= 2) then
			xit = true
		elseif event == "mouse_click" and (y == 1 and x >= 3) or button == keys.g then
			redirect = searchBarEvent()
		elseif button == keys.backspace and prevSite then
			redirect = prevSite
			os.sleep(0.5)
		elseif button == keys.l and url ~= "file://"..bkmkDir then
				redirect = "file://"..bkmkDir
		elseif button == keys.home then
			local siteExt = url:match("//(.*)"):match("/(.*)")
			if siteExt and siteExt ~= "" and not url:find("file://") then
			redirect = url:sub(1, url:find(siteExt)-1)
			else
			redirect = "file://"..homeDir
			end
			os.sleep(.5)
		elseif button == keys.b then
			local bkmkTitle = title
			if title == "" then bkmkTitle = url end
			local bkmkTbl = minux.readtable(bkmkDir)
			local bkmkLine = minux.findline(bkmkDir, "<a href='"..url.."'>"..title.."</a><br>")
			if bkmkLine then
				minux.removeline(bkmkDir, bkmkLine)
				writeSearchBar('Removed from bookmarks')
			else
				table.insert(bkmkTbl, 3, "<a href='"..url.."'>"..title.."</a><br>")
				minux.writetable(bkmkDir, bkmkTbl)
				writeSearchBar('Added to bookmarks')
			end
			os.sleep(1)
			writeSearchBar(title)
		elseif button == keys.pageUp and endOfPg > termY-1 then
			pageY = 0
			calcScrollBar("min")
			updateWindow()
		elseif button == keys.pageDown and endOfPg > termY-1 then
			calcScrollBar("max")
			updateWindow()
		elseif button == keys.d then
			if not fs.exists(downloadDir..urlFile) and fs.exists("/temp/sonata/cache/"..urlFile) then
				fs.copy("/temp/sonata/cache/"..urlFile, downloadDir..urlFile)
				writeSearchBar('Downloaded page')
			else
				writeSearchBar('File already exists')
			end
			os.sleep(1)
			writeSearchBar(title)
			
		elseif button == keys.q then
			xit = true
		end
	end
	term.redirect(ogTerm)
	term.clear()
	return redirect
end

-- Download the page, add the site to the cache..
local useCache = "true"
if fs.exists("usr/sonata/"..login.."/browser.cfg") then 
useCache = minux.printline("usr/sonata/"..login.."/browser.cfg", 2) 
if (useCache ~= "true" and useCache ~= "false") then useCache = "true" end
end
function getPg(url)
	local rnPg
	local siteContent
	local urlFile = url
	if url:find("%/%/") then urlFile = url:match("%/%/(.*)") end
	local hasCached
	if url:match("file://(.*)") then
		hasCached = true
	else
		hasCached = (fs.exists("/temp/sonata/cache/"..urlFile) and fs.getSize("/temp/sonata/cache/"..urlFile) > 0)
	end
	rnFile = urlFile
	if urlFile:find("%/") then 
		rnPg = urlFile:match("%/(.*)")
		rnFile = rnFile:match("(.*)%/")
	end
	if not rnPg or rnPg == "" then rnPg = "index.html" end
	if (not hasCached and useCache == "true") or useCache == "false" then
		if url:match("rni://(.*)") then
			siteContent = rnwtp.get(tonumber(rnFile), rnPg)
		elseif url:match("rnn://(.*)") then
			siteContent = rnwtp.fetch(rnFile, rnPg)
		elseif url:match("file://(.*)") then
			local readLD = fs.open(urlFile, "r")
			siteContent = readLD.readAll()
			readLD.close()
		else
			if not url:match("https://(.*)") and not currentSite then
				url = "https://"..url 
			elseif not url:match("https://(.*)") then
				if url:sub(1,1) == "/" then
					currentSite = currentSite:match("(.-)/")..currentSite:match("(//.-)/")
				end
				url = currentSite..url
			end
			httpContent = http.get(url)
			siteContent = httpContent.readAll()
			httpContent.close()
		end
	end
	if not url:match("file://(.*)") then urlFile = urlFile:gsub("%/", "%.") end
	if urlFile:sub(-1) == "." then urlFile = urlFile:sub(1, #urlFile-1) end
	local siteCache
	local readOnly = false
	if useCache == "true" then
		if hasCached then
			readOnly = true
		else
			siteCache = fs.open("/temp/sonata/cache/"..urlFile,"w")
			siteCache.write(siteContent)
			siteCache.close()
		end
	elseif not url:match("file://(.*)") then
		urlFile = "browser.cache"
		siteCache = fs.open("/temp/sonata/cache/browser.cache","w")
		siteCache.write(siteContent)
		siteCache.close()
	end
    redirect = showPg(url, urlFile)
	return redirect
end

function runBrowser(url)
	term.setCursorPos(1,1)
	term.clear()
	while url do
		url = getPg(url)
		prevSite = currentSite
	end
	local dontClear = "false"
	if fs.exists("/usr/sonata/"..login.."/browser.cfg") then 
		dontClear = minux.printline("/usr/sonata/"..login.."/browser.cfg", 8) 
		if (dontClear ~= "false" and dontClear ~= "true") then dontClear = "false" end
	end
	if dontClear == "false" then fs.delete("/temp/sonata") end
	term.setCursorPos(1,1)
	term.clear()
end

local errorTbl = {}
local ignoreErrors = minux.printline(cfgDir, 17)
if not ignoreErrors then ignoreErrors = "false" end
if not minux then table.insert(errorTbl, "Not running Minux OS") end
if modemside == "NONE" then table.insert(errorTbl, "No modem found") end
if printerside == "NONE" then table.insert(errorTbl, "No printer found") end
if not rnwtp then table.insert(errorTbl, "Missing 'rnwtp' API") end
if not dhcp then table.insert(errorTbl, "Missing 'dhcp' API") end
if not dev then table.insert(errorTbl, "Missing 'devlib' API") end
if errorTbl[1] and ignoreErrors == "false" then
	print("Errors found, Sonata may crash:")
	for k,v in pairs(errorTbl) do
		print(v)
	end
	os.pullEvent('key')
end

local args = {...}
local parseTbl = {}

local function makePage(dir, content)
	local pg = fs.open(dir, "w")
	pg.close()
	minux.insertline(dir, content)
end
if not args[1] then
	if not fs.exists(homeDir) then 
		local homeDefaultContent = [[<html>
<title>Sonata Web Browser</title>
<body>
<script>var nfp = `
                  
   000                           
  00  0           000     2     b
   00   0  00   0  0  0  222  a 
 0  00 0 0 0 0 000 0 000  2  aaa
  000   0  0 0 0 0   0 0      a 
`
//NFP
</script><br>
Customize your homepage with the command:<br>
<u><i>edit usr/sonata/user/local/home.html</i></u><br><br>
..and your config file using:<br>
<u><i>edit usr/sonata/user/browser.cfg</u></i><br><br>
<a href="file://etc/man/sonata.man">/ View the manual /</a><br>
<a href="file://]]..bkmkDir..[[">/ Bookmarked websites /</a>
</body>
</html>]]
	    makePage(homeDir, homeDefaultContent)
	end
	if not fs.exists(bkmkDir) then
		local bkmkDefaultContent = [[<html><title>Bookmarks Library</title><body>
<a href="https://sonata.minux.cc">Sonata Official Site</a><br>
</body>
</html>]]
		makePage(bkmkDir, bkmkDefaultContent)
	end
	if not fs.exists(cfgDir) then
		local cfgDefaultContent = [[Enable cache?
true

* Should Sonata re-download websites every time 
you visit them (false) or use a cache? (true)

Clear cache on PC shutdown?
false

* Should Sonata clear temporary files on shutdown 
(true) or each time the browser closes? (false)

Default download folder:
]]..downloadDir..[[


Ignore launch errors?
false

Run special files in new tab? (defaults.cfg)
* Disable if using basic PC
true

Procedure for special files? (prompt/download/run)
run]]
		makePage(cfgDir, cfgDefaultContent)
	end
	if not fs.exists(defDir) then
		local defDefaultContent = [[.nfp
/rom/programs/fun/advanced/paint.lua
.dfpwm
/bin/playsong.sh
]]
		makePage(defDir, defDefaultContent)
	end
		runBrowser("file://"..homeDir)
else
	runBrowser(args[1])
end