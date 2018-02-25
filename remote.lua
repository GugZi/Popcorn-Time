local kb = libs.keyboard;
local server = libs.server;
local ps = libs.ps;
local win = libs.win;

local skiptimeval = 1;
local skiptime = 100;
local volChangeAmount = 10;

--@help Launch Popcorn Time application
actions.launch = function()
	if OS_WINDOWS then
		os.start("D:\\Program Files (Media)\\Popcorn-Time\\Popcorn-Time.exe"); 
	elseif OS_OSX then
		os.script("tell application \"popcorn time\" to activate");
	end
end

--@help Focus Popcorn-Time application
actions.switch = function()
	if OS_WINDOWS then
		local hwnd = win.window("Popcorn-Time.exe");
		if (hwnd == 0) then actions.launch(); end
		win.switchtowait("Popcorn-Time.exe");
	end
end

function switchVideoSource(src)
	actions.switch();
	if( src == "movies" ) then kb.stroke("ctrl", "1") end
	if( src == "tv") then kb.stroke("ctrl", "2") end
	if( src == "anime" ) then kb.stroke("ctrl", "3") end
	if( src == "favorite" ) then kb.stroke("b") end
end

function increaseVolume()
	if volChangeAmount == 10 then
		kb.stroke("up");
	end
end

function decreaseVolume()
	if volChangeAmount == 10 then
		kb.stroke("down");
	end
end

function muteVolume()
	kb.stroke("m");
end

function toggleFullscreen()
	kb.stroke("f");
end

function increaseCoverSize()
	kb.stroke("ctrl", "oem_plus");
end

function decreaseCoverSize()
	kb.stroke("ctrl", "oem_minus");
end

function doSearch(searchterm)
	--Open search bar
	kb.stroke("ctrl", "f"); 

	--Clear last search
	kb.stroke("ctrl", "a");
	kb.stroke("delete");

	--Do search
	kb.text(searchterm);
	kb.stroke("enter");
end

function clearsearch()
	--Open search bar
	kb.stroke("ctrl", "f"); 

	--Clear last search
	kb.stroke("ctrl", "a");
	kb.stroke("delete");

	--Finish
	kb.stroke("enter");
end

function back()
	kb.stroke("esc");
end

function select()
	kb.press("space");
end

function changeQuality()
	kb.press("q");
end

function setFavorites()
	kb.press("f");
end

function offsetSubsplus01()
    kb.stroke("h");
end

function offsetSubsplus1()
    kb.stroke("shift", "h");
end

function offsetSubsplus5()
    kb.stroke("ctrl", "h");
end

function offsetSubsminus01()
    kb.stroke("g");
end

function offsetSubsminus1()
    kb.stroke("shift", "g");
end

function offsetSubsminus5()
    kb.stroke("ctrl", "g");
end

-- Handle video source changes
actions.switchtomovies = function()
	actions.switch();
	switchVideoSource("movies");
end

actions.switchtotv = function()
	actions.switch();
	switchVideoSource("tv");
end

actions.switchtoanime = function()
	actions.switch();
	switchVideoSource("anime");
end

actions.switchtofavorite = function()
	actions.switch();
	switchVideoSource("favorite");
end

-- Handle simple control functions
actions.playpause = function() -- Pause / Play
	actions.switch();
	kb.stroke("space");
end

actions.skiptimetoggle = function() -- Skip timer toggle
	actions.switch();
	skiptimeval = skiptimeval + 1;

	if skiptimeval == 4 then skiptimeval = 1 end

	if skiptimeval == 1 then
		layout.skiptime.text = "10s";
	elseif skiptimeval == 2 then
		layout.skiptime.text = "1min";
	elseif skiptimeval == 3 then
		layout.skiptime.text = "10min";	
	end
end

actions.skipbackward = function() -- Skip backwards
	actions.switch();
	if skiptimeval == 1 then
		kb.stroke("left");
	elseif skiptimeval == 2 then
		kb.stroke("shift", "left");
	elseif skiptimeval == 3 then
		kb.stroke("ctrl", "left")
	end
end

actions.skipforward = function() -- Skip forwards
	actions.switch();
	if skiptimeval == 1 then
		kb.stroke("right");
	elseif skiptimeval == 2 then
		kb.stroke("shift", "right");
	elseif skiptimeval == 3 then
		kb.stroke("ctrl", "right")
	end
end

actions.moveleft = function()
	actions.switch();
	kb.stroke("left");
end

actions.moveright = function()
	actions.switch();
	kb.stroke("right");
end

actions.moveup = function()
	actions.switch();
	kb.stroke("up");
end

actions.movedown = function()
	actions.switch();
	kb.stroke("down");
end

actions.search = function()
	actions.switch();
	server.update({id = "go", type="input", ontap="doSearch", title="Search"});
end

actions.doSearch = doSearch;
actions.goback = back;
actions.select = select;
actions.clearsearch = clearsearch;
actions.switchvideosource = switchVideoSource;
actions.changequality = changeQuality;
actions.setfavorites = setFavorites;
actions.volumeup = increaseVolume;
actions.volumedown = decreaseVolume;
actions.volumemute = muteVolume;
actions.togglefullscreen = toggleFullscreen;

actions.offsetsubsplus01 = offsetSubsplus01;
actions.offsetsubsplus1 = offsetSubsplus1;
actions.offsetsubsplus5 = offsetSubsplus5;
actions.offsetsubsminus01 = offsetSubsminus01;
actions.offsetsubsminus1 = offsetSubsminus1;
actions.offsetsubsminus5 = offsetSubsminus5;

print("Popcorn Time Remote Loaded...");