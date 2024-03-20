hs.loadSpoon("ReloadConfiguration")
spoon.ReloadConfiguration:start()

hs.hotkey.bind({"shift"}, "space", function()
    io.popen('source "${HOME}/.zprofile" && kitty sling')
end)
