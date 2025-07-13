-- Pull in the wezterm API
local wezterm = require "wezterm"
-- This table will hold the configuration.
local config = {}

-- In newer versions of wezterm, use the config_builder which will
-- help provide clearer error messages
if wezterm.config_builder then
	config = wezterm.config_builder()
end

config.front_end = "WebGpu"
config.max_fps = 144
config.animation_fps = 1
config.term = "xterm-256color"
config.default_cursor_style = "SteadyBlock"
config.window_background_opacity = 0.3
config.color_scheme = "Dracula"
-- config.color_scheme = "Builtin Solarized Dark"
config.font = wezterm.font("JetBrains Mono NL")
config.font_size = 16
config.window_padding = {
	left = 2,
	right = 0,
	top = 2,
	bottom = 0
}

config.freetype_load_target = "Normal"
config.freetype_render_target = "Normal"

config.window_decorations = "NONE | RESIZE"
config.default_prog = { "pwsh.exe", "-NoLogo" }
config.initial_cols = 10
config.adjust_window_size_when_changing_font_size = false

config.disable_default_key_bindings = true

-- tab bar
config.hide_tab_bar_if_only_one_tab = false
config.tab_bar_at_bottom = true
config.use_fancy_tab_bar = false
config.tab_and_split_indices_are_zero_based = true

wezterm.on('window-opacity-change', function(window)
	local overrides = window:get_config_overrides() or {}

	if not overrides.window_background_opacity then
		overrides.window_background_opacity = 1
	else
		overrides.window_background_opacity = nil
	end

	window:set_config_overrides(overrides)
end)

config.keys = {
	{
		mods = 'CTRL | SHIFT',
		key = 'd',
		action = wezterm.action.ShowDebugOverlay
	},
	{
		mods = 'CTRL | SHIFT',
		key = 'g',
		action = wezterm.action.EmitEvent 'window-opacity-change'
	},
	-- {
	-- 	key = "m",
	-- 	mods = "CTRL|SHIFT",
	-- 	action = wezterm.action.ShowLauncher,
	-- },
	{
		mods = "CTRL",
		key = "Space",
		action = wezterm.action.SendKey {
			mods = "CTRL",
			key = "Space",
		}
	},
	{
		mods = "CTRL",
		key = "Backspace",
		action = wezterm.action.SendKey {
			key = "w",
			mods = "CTRL"
		}
	},
	{
		mods = "CTRL | SHIFT",
		key = "t",
		action = wezterm.action.SpawnTab "CurrentPaneDomain",
	},
	-- {
	-- 	mods = "CTRL | SHIFT",
	-- 	key = "w",
	-- 	action = wezterm.action.CloseCurrentTab { confirm = true }
	-- },
	{
		mods = "CTRL | SHIFT",
		key = "w",
		action = wezterm.action.CloseCurrentPane { confirm = false }
	},
	{
		mods = "CTRL | SHIFT",
		key = "p",
		action = wezterm.action.ActivateTabRelative(-1)
	},
	{
		mods = "CTRL | SHIFT",
		key = "n",
		action = wezterm.action.ActivateTabRelative(1)
	},
	{
		mods = "CTRL | SHIFT",
		key = "v",
		action = wezterm.action.SplitHorizontal { domain = "CurrentPaneDomain" }
	},
	{
		mods = "CTRL | SHIFT",
		key = "-",
		action = wezterm.action.SplitVertical { domain = "CurrentPaneDomain" }
	},
	{
		mods = "CTRL | SHIFT",
		key = "h",
		action = wezterm.action.ActivatePaneDirection "Left"
	},
	{
		mods = "CTRL | SHIFT",
		key = "j",
		action = wezterm.action.ActivatePaneDirection "Down"
	},
	{
		mods = "CTRL | SHIFT",
		key = "k",
		action = wezterm.action.ActivatePaneDirection "Up"
	},
	{
		mods = "CTRL | SHIFT",
		key = "l",
		action = wezterm.action.ActivatePaneDirection "Right"
	},
	{
		mods = "CTRL | SHIFT",
		key = "LeftArrow",
		action = wezterm.action.AdjustPaneSize { "Left", 5 }
	},
	{
		mods = "CTRL | SHIFT",
		key = "RightArrow",
		action = wezterm.action.AdjustPaneSize { "Right", 5 }
	},
	{
		mods = "CTRL | SHIFT",
		key = "DownArrow",
		action = wezterm.action.AdjustPaneSize { "Down", 5 }
	},
	{
		mods = "CTRL | SHIFT",
		key = "UpArrow",
		action = wezterm.action.AdjustPaneSize { "Up", 5 }
	},
	{
		mods = "CTRL",
		key = "!",
		action = wezterm.action.IncreaseFontSize
	},
	{
		mods = "CTRL",
		key = "#",
		action = wezterm.action.DecreaseFontSize
	},

}


local current_layout_number_row = { '+', '[', '{', '(', '&' }
for i, v in ipairs(current_layout_number_row) do
	table.insert(config.keys, {
		mods = "CTRL",
		key = v,
		action = wezterm.action.ActivateTab(i - 1),
	})
end

-- --tmux restore
-- wezterm.on("save-indicator", function(window, _)
-- 	local saved_icon = " " .. "\u{eb4b}" .. "  ";
--
-- 	window:set_left_status(wezterm.format {
-- 		{ Text = saved_icon },
-- 	})
--
-- 	wezterm.sleep_ms(1500)
-- 	window:set_left_status("")
-- end)
--
return config
