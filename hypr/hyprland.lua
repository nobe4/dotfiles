-- `hl` is available by hyprland.
---@diagnostic disable: undefined-global

local terminal = "kitty"
local leader = "SUPER"

-- normally not needed
hl.on("hyprland.start", function()
	hl.exec_cmd("waybar")
end)

-- See https://wiki.hypr.land/Configuring/Basics/Monitors/
hl.monitor({
	output   = "",
	mode     = "preferred",
	position = "auto",
	scale    = "auto",
})

hl.monitor({
	output   = "DP-1",
	mode     = "preferred",
	position = "auto",
	scale    = 2,
})


-- Environment variables are set in ~/.config/uwsm/env

-- TODO
-- See https://wiki.hypr.land/Configuring/Advanced-and-Cool/Permissions/

-----------------------
---- LOOK AND FEEL ----
-----------------------

hl.config({
	general = {
		gaps_in     = 0,
		gaps_out    = 0,

		border_size = 2,

		col         = {
			active_border   = "rgb(7a7a7a)", -- c9
			inactive_border = "rgb(101010)", -- c1
		},

		layout      = "dwindle",

		snap        = {
			enabled = true,
		},
	},

	decoration = {
		blur   = { enabled = false },
		shadow = { enabled = false },
	},

	animations = {
		enabled = false,
	},
})

hl.config({
	dwindle = {
		preserve_split = true,
	},
})

hl.config({
	misc = {
		force_default_wallpaper  = 0,
		disable_hyprland_logo    = true,
		disable_splash_rendering = false,
	},
})

---------------
---- INPUT ----
---------------

hl.config({
	input = {
		kb_layout            = "eu",
		kb_options           = "caps:escape",
		follow_mouse         = 1,
		sensitivity          = 1,
		resolve_binds_by_sym = true,
	},

	binds = {
		allow_workspace_cycles   = true,
		workspace_back_and_forth = true,
	},

	ecosystem = {
		no_donation_nag = true,
	},
})

-- Onboard apple keyboards are colemak.
hl.device({
	name       = "apple-inc.-apple-internal-keyboard-/-trackpad",
	kb_layout  = "us",
	kb_variant = "colemak",
})

hl.device({
	name        = "apple-inc.-apple-internal-keyboard-/-trackpad-1",
	sensitivity = 0,
})

---------------------
---- KEYBINDINGS ----
---------------------

local lead = function(key, command, opts)
	hl.bind(leader .. " + " .. key, command, opts)
end

lead("SPACE", hl.dsp.exec_cmd("rofi -show"))

-- bind = $leader, T, exec, kitty > /tmp/kitty.log 2> /tmp/kitty.err.log

lead("q", hl.dsp.exec_cmd('notify "TODO leader-q" -t 1000'))
lead("w", hl.dsp.exec_cmd('notify "TODO leader-w" -t 1000'))
lead("f", hl.dsp.exec_cmd('notify "TODO leader-f" -t 1000'))
lead("p", hl.dsp.exec_cmd('notify "TODO leader-p" -t 1000'))
lead("g", hl.dsp.exec_cmd('notify "TODO leader-g" -t 1000'))

lead("a", hl.dsp.exec_cmd('notify "TODO leader-a" -t 1000'))
lead("r", hl.dsp.exec_cmd('notify "TODO leader-r" -t 1000'))
lead("s", hl.dsp.exec_cmd('notify "TODO leader-s" -t 1000'))
lead("t", hl.dsp.exec_cmd('notify "TODO leader-t" -t 1000'))
lead("d", hl.dsp.exec_cmd('notify "TODO leader-d" -t 1000'))

-- ctrl+insert/shift+insert are standard copy/paste shortcuts
lead("z", hl.dsp.send_shortcut({ mods = "CTRL", key = "z" }))
lead("x", hl.dsp.send_shortcut({ mods = "CTRL", key = "x" }))
lead("c", hl.dsp.send_shortcut({ mods = "CTRL", key = "Insert" }))
lead("v", hl.dsp.send_shortcut({ mods = "SHIFT", key = "Insert" }))

-- Right hand
lead("h", hl.dsp.focus({ workspace = "-1" }))
lead("n", hl.dsp.window.float({ action = "toggle" }))
lead("e", hl.dsp.window.fullscreen({ mode = "maximized" }))
lead("i", hl.dsp.focus({ workspace = "+1" }))
lead("o", hl.dsp.exec_cmd('notify "TODO leader-o" -t 1000'))

lead("j", hl.dsp.window.move({ workspace = "-1" }))
lead("l", hl.dsp.exec_cmd('notify "TODO leader-l" -t 1000'))
lead("u", hl.dsp.exec_cmd('notify "TODO leader-u" -t 1000'))
lead("y", hl.dsp.window.move({ workspace = "+1" }))
lead("apostrophe", hl.dsp.exec_cmd("loginctl lock-session"))

lead("k", hl.dsp.window.close())
lead("m", hl.dsp.exec_cmd('notify "TODO leader-m" -t 1000'))
lead("comma", hl.dsp.exec_cmd('notify "TODO leader-, " -t 1000'))

lead("period", hl.dsp.exec_cmd('notify "TODO leader-." -t 1000'))
lead("return", hl.dsp.exec_cmd(terminal))

-- Some keyboards have those
lead("Left", hl.dsp.focus({ workspace = "-1" }))
lead("Right", hl.dsp.focus({ workspace = "+1" }))

-- TODO: check how to use environment-variables, or add the PATH.
hl.bind("XF86Launch5",
		hl.dsp.exec_cmd('/home/nobe4/.config/dotfiles/bin/$(printf "screenshot\\nscreenrecord" | rofi -dmenu)'))
hl.bind("F11", hl.dsp.exec_cmd("/home/nobe4/.config/dotfiles/bin/commands/emoji --rofi"))

-- Move/resize windows with leader + LMB/RMB and dragging
lead("mouse:272", hl.dsp.window.drag(), { mouse = true })
lead("mouse:273", hl.dsp.window.resize(), { mouse = true })

-- Multimedia keys
hl.bind("XF86AudioRaiseVolume", hl.dsp.exec_cmd("wpctl set-volume -l 1 @DEFAULT_AUDIO_SINK@ 5%+"),
		{ locked = true, repeating = true })
hl.bind("XF86AudioLowerVolume", hl.dsp.exec_cmd("wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-"),
		{ locked = true, repeating = true })
hl.bind("XF86AudioMute", hl.dsp.exec_cmd("wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"), { locked = true })
hl.bind("XF86AudioPlay", hl.dsp.exec_cmd("playerctl play-pause"), { locked = true })

--------------------------------
---- WINDOWS AND WORKSPACES ----
--------------------------------

hl.window_rule({
	name  = "steam-float",
	match = { class = "^steam.*$" },
	float = true,
})

hl.window_rule({
	name     = "pavucontrol-float",
	match    = { class = "^org.pulseaudio.pavucontrol$" },
	float    = true,
	maximize = true,
})

hl.window_rule({
	name   = "1password-float",
	match  = { class = "^1password$" },
	float  = true,
	center = true,
})

hl.window_rule({
	name   = "gimp-export-image-as",
	match  = { title = "^Export Image as .*$" },
	float  = true,
	center = true,
})

hl.window_rule({
	name   = "gimp-export-image",
	match  = { class = "^gimp$", title = "^Export Image$" },
	float  = true,
	center = true,
})

hl.window_rule({
	name   = "firefox-pip",
	match  = { class = "^firefox$", title = "^Picture-in-Picture$" },
	float  = true,
	center = true,
})

hl.window_rule({
	name   = "xdg-portal-gtk",
	match  = { class = "^xdg-desktop-portal-gtk$" },
	float  = true,
	center = true,
})

hl.window_rule({
	name  = "kitty-waybar-iwctl",
	match = { class = "^kitty$", title = "^waybar-iwctl$" },
	float = true,
	size  = "900 600",
	move  = "onscreen cursor",
})

hl.window_rule({
	name  = "kitty-waybar-htop",
	match = { class = "^kitty$", title = "^waybar-htop$" },
	float = true,
	size  = "900 600",
	move  = "onscreen cursor",
})

hl.window_rule({
	name  = "kitty-weather",
	match = { class = "^kitty$", title = "^weather$" },
	float = true,
	size  = "800 620",
})

hl.window_rule({
	name           = "suppress-maximize-events",
	match          = { class = ".*" },
	suppress_event = "maximize",
})

hl.window_rule({
	name     = "fix-xwayland-drags",
	match    = {
		class      = "^$",
		title      = "^$",
		xwayland   = true,
		float      = true,
		fullscreen = false,
		pin        = false,
	},
	no_focus = true,
})

-- debug = {
--     disable_logs = false,
--     enable_stdout_logs = true,
-- }


-- https://github.com/hyprwm/Hyprland/tree/main/example/layouts
-- hl.layout.register("grid", {
-- 	recalculate = function(ctx)
-- 		local n = #ctx.targets
-- 		if n == 0 then return end
--
-- 		local cols = math.ceil(math.sqrt(n))
-- 		for i, target in ipairs(ctx.targets) do
-- 			target:place(ctx:grid_cell(i, cols))
-- 		end
-- 	end,
-- })
--
-- hl.window_rule({ match = { title = "kitty-test" }, workspace = "3 silent" })
-- hl.workspace_rule({ workspace = "3", layout = "lua:grid" })
