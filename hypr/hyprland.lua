-- `hl` is available by hyprland.
---@diagnostic disable: undefined-global

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

local terminal = "kitty"

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
			active_border   = "rgb(878988)", -- c9
			inactive_border = "rgb(1d1f21)", -- c1
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

-- TODO: check how xkb works and how to configure keymappings better
hl.config({
	input = {
		kb_layout    = "eu",
		follow_mouse = 1,
		sensitivity  = 1, -- -1.0 - 1.0, 0 means no modification.
	},

	binds = {
		allow_workspace_cycles   = true,
		workspace_back_and_forth = true,
	},

	ecosystem = {
		no_donation_nag = true,
	},
})

---------------------
---- KEYBINDINGS ----
---------------------

local leader = "SUPER"

hl.bind(leader .. " + SPACE", hl.dsp.exec_cmd("rofi -show"))

-- bind = $leader, T, exec, kitty > /tmp/kitty.log 2> /tmp/kitty.err.log

hl.bind(leader .. " + q", hl.dsp.exec_cmd('notify "TODO leader-q" -t 1000'))
hl.bind(leader .. " + w", hl.dsp.exec_cmd('notify "TODO leader-w" -t 1000'))
hl.bind(leader .. " + f", hl.dsp.exec_cmd('notify "TODO leader-f" -t 1000'))
hl.bind(leader .. " + p", hl.dsp.exec_cmd('notify "TODO leader-p" -t 1000'))
hl.bind(leader .. " + g", hl.dsp.exec_cmd('notify "TODO leader-g" -t 1000'))

hl.bind(leader .. " + a", hl.dsp.exec_cmd('notify "TODO leader-a" -t 1000'))
hl.bind(leader .. " + r", hl.dsp.exec_cmd('notify "TODO leader-r" -t 1000'))
hl.bind(leader .. " + s", hl.dsp.exec_cmd('notify "TODO leader-s" -t 1000'))
hl.bind(leader .. " + t", hl.dsp.exec_cmd('notify "TODO leader-t" -t 1000'))
hl.bind(leader .. " + d", hl.dsp.exec_cmd('notify "TODO leader-d" -t 1000'))

-- ctrl+insert/shift+insert are standard copy/paste shortcuts
hl.bind(leader .. " + z", hl.dsp.send_shortcut({ mods = "CTRL", key = "z" }))
hl.bind(leader .. " + x", hl.dsp.send_shortcut({ mods = "CTRL", key = "x" }))
hl.bind(leader .. " + c", hl.dsp.send_shortcut({ mods = "CTRL", key = "Insert" }))
hl.bind(leader .. " + v", hl.dsp.send_shortcut({ mods = "SHIFT", key = "Insert" }))

-- Right hand
hl.bind(leader .. " + h", hl.dsp.focus({ workspace = "-1" }))
hl.bind(leader .. " + n", hl.dsp.window.float({ action = "toggle" }))
hl.bind(leader .. " + e", hl.dsp.window.fullscreen({ mode = "maximized" }))
hl.bind(leader .. " + i", hl.dsp.focus({ workspace = "+1" }))
hl.bind(leader .. " + o", hl.dsp.exec_cmd('notify "TODO leader-o" -t 1000'))

hl.bind(leader .. " + j", hl.dsp.window.move({ workspace = "-1" }))
hl.bind(leader .. " + l", hl.dsp.exec_cmd('notify "TODO leader-l" -t 1000'))
hl.bind(leader .. " + u", hl.dsp.exec_cmd('notify "TODO leader-u" -t 1000'))
hl.bind(leader .. " + y", hl.dsp.window.move({ workspace = "+1" }))
hl.bind(leader .. " + apostrophe", hl.dsp.exec_cmd("loginctl lock-session"))

hl.bind(leader .. " + k", hl.dsp.window.close())
hl.bind(leader .. " + m", hl.dsp.exec_cmd('notify "TODO leader-m" -t 1000'))
hl.bind(leader .. " + comma", hl.dsp.exec_cmd('notify "TODO leader-, " -t 1000'))

hl.bind(leader .. " + period", hl.dsp.exec_cmd('notify "TODO leader-." -t 1000'))
hl.bind(leader .. " + return", hl.dsp.exec_cmd(terminal))

-- TODO: check how to use environment-variables, or add the PATH.
hl.bind("XF86Launch5",
	hl.dsp.exec_cmd('/home/nobe4/dev/nobe4/dotfiles/bin/$(printf "screenshot\\nscreenrecord" | rofi -dmenu)'))
hl.bind("F11", hl.dsp.exec_cmd("/home/nobe4/dev/nobe4/dotfiles/bin/commands/emoji --rofi"))

-- Move/resize windows with leader + LMB/RMB and dragging
hl.bind(leader .. " + mouse:272", hl.dsp.window.drag(), { mouse = true })
hl.bind(leader .. " + mouse:273", hl.dsp.window.resize(), { mouse = true })

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
