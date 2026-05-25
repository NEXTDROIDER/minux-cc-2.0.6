<?php
//-----------------------------------------------------
// Minux APT -> MAP/PDR packer by Missooni ♥ Progdor2/Auto-extraction code by LDDestroier
//-----------------------------------------------------
$packs = [];
$id = $_GET["id"];

foreach(scandir('.') as $packname) {
	if (is_dir($packname) && $packname != "." && $packname != "..") {
		$packs[] = $packname;
	}
}

function getDirContents($dir, &$results = array()) {
    $files = scandir($dir);

    foreach ($files as $key => $value) {
        $path = realpath($dir . DIRECTORY_SEPARATOR . $value);
        if (!is_dir($path)) {
            $results[] = $path;
        } else if ($value != "." && $value != "..") {
            getDirContents($path, $results);
			if (!is_dir($path)) {  $results[] = $path;  }
        }
    }

    return $results;
}

function servePack(&$id) {
	$knownTypes = array(
		1	=>	"pdr",
		2	=>	"map",
	);
	$packType = $_GET["type"];
	if (!isset($packType) || !in_array($packType, $knownTypes)) {	$packType = "map";	}
	if ($packType != "map") {
	$pdrPack = "{
  mainFile = false,
  compressed = false,
  data = {
";
  }		else	{
	$pdrPack = "{\\
  mainFile = false,\\
  compressed = false,\\
  data = {\\
";
  }

	$clean = $_GET["clean"];
	foreach (getDirContents($id) as $key => $value) {
		$splitDir = explode($id . "/", $value, 2);
		$fileDir = $splitDir[1];
		$Vdata = file_get_contents($value);
		$Vdata = str_replace('\\', '\\\\', $Vdata);
		$Vdata = str_replace(array("\n", "\r"), "\\\n", $Vdata);
		$Vdata = str_replace('"', '\\"', $Vdata);
		if (isset($clean)) {
			if ($packType != "map") {
				$Vdata = preg_replace('(--(.*))', "\\", $Vdata);
			}	else	{
				$Vdata = preg_replace('(--(.*))', "\\\\", $Vdata);
			}
			$Vdata = preg_replace('/(r?\n\\\\){2,}/', "\n\\\\", $Vdata);
		}
		if ($packType != "map") {
			$pdrPack = $pdrPack . "    [ \"" . $fileDir . "\" ] = \"";
			$pdrPack = $pdrPack . $Vdata . "\",
";
		}	else	{
			$pdrPack = $pdrPack . "    [ \\\"" . $fileDir . "\\\" ] = \\\"";
			$pdrPack = $pdrPack . str_replace("\\", "\\\\\\", $Vdata) . "\\\",\\
";
		}	
	}
		if ($packType != "map") {
			$pdrPack = $pdrPack . "	},
}";
		}	else	{
			$pdrPack = $pdrPack . "	},\\
}";
		}
		if ($packType == "map") {
			$pdrPack = "local tArg = {...}
local selfDelete = false -- if true, deletes extractor after running
local file
local outputPath = tArg[1] and shell.resolve(tArg[1]) or shell.getRunningProgram()
local safeColorList = {[colors.white] = true,[colors.lightGray] = true,[colors.gray] = true,[colors.black] = true}
local stc = function(color) if (term.isColor() or safeColorList[color]) then term.setTextColor(color) end end
local choice = function()
	local input = \"yn\"
	write(\"[\")
	for a = 1, #input do
		write(input:sub(a,a):upper())
		if a < #input then
			write(\",\")
		end
	end
	print(\"]?\")
	local evt,char
	repeat
		evt,char = os.pullEvent(\"char\")
	until string.find(input:lower(),char:lower())
	if verbose then
		print(char:upper())
	end
	local pos = string.find(input:lower(), char:lower())
	return pos, char:lower()
end
local archive = textutils.unserialize(\"" . $pdrPack . "\")
if fs.isReadOnly(outputPath) then
	error(\"Output path is read-only. Abort.\")
elseif fs.getFreeSpace(outputPath) <= #archive then
	error(\"Insufficient space. Abort.\")
end

if fs.exists(outputPath) and fs.combine(\"\", outputPath) ~= \"\" then
	fs.delete(outputPath)
end
if selfDelete or (fs.combine(\"\", outputPath) == shell.getRunningProgram()) then
	fs.delete(shell.getRunningProgram())
end
for name, contents in pairs(archive.data) do
	stc(colors.lightGray)
	write(\"'\" .. name .. \"'...\")
	if contents == true then -- indicates empty directory
		fs.makeDir(fs.combine(outputPath, name))
	else
		file = fs.open(fs.combine(outputPath, name), \"w\")
		if file then
			file.write(contents)
			file.close()
		end
	end
	if file then
		stc(colors.green)
		print(\"good\")
	else
		stc(colors.red)
		print(\"fail\")
	end
end
stc(colors.white)
write(\"Unpacked to '\")
stc(colors.yellow)
write(outputPath .. \"/\")
stc(colors.white)
print(\"'.\")
";
	}
	echo $pdrPack;
}

if (isset($id) && in_array($id, $packs)) {
	servePack($id);
}	else	{
	http_response_code(403);
	die('Pack was not specified or does not exist.');
}