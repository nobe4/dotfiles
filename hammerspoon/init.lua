hs.loadSpoon("ReloadConfiguration")
spoon.ReloadConfiguration:start()

local kitty = os.getenv("HOME") .. "/Applications/kitty.app/Contents/MacOS/kitty"

local slingFilter = hs.window.filter.new(false):setAppFilter("kitty", { allowTitles = "sling" })
slingFilter:subscribe(hs.window.filter.windowCreated, function(win)
	win:centerOnScreen(nil, true)
	win:raise()
	win:focus()
end)

hs.hotkey.bind({ "shift" }, "space", function()
	hs.task.new(kitty, nil, {"--single-instance", "--instance-group", "sling", "--title", "sling", "/bin/zsh", "-l", "-c", "sling" }):start()
end)
