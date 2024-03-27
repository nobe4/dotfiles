hs.loadSpoon("ReloadConfiguration")
spoon.ReloadConfiguration:start()

hs.hotkey.bind({ "shift" }, "space", function()
	-- create a new kitty OS window
	local app = hs.application.get("kitty")
	if app then
		app:selectMenuItem({ "Shell", "New OS Window" })
	else
		hs.application.launchOrFocus("kitty")
	end
	app = hs.application.get("kitty")

	app:activate()
	app:focusedWindow():centerOnScreen(nil, true)

	hs.eventtap.keyStrokes("clear ; sling ; kitty @ close-window --self", app)
	hs.eventtap.keyStroke({}, "return")
end)
