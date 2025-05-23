-- Pull in the wezterm API
local wezterm = require "wezterm"

-- This table will hold the configuration.
local config = {}

-- In newer versions of wezterm, use the config_builder which will
-- help provide clearer error messages
if wezterm.config_builder then
	config = wezterm.config_builder()
end

-- local resurrect = wezterm.plugin.require("https://github.com/MLFlexer/resurrect.wezterm")

config.front_end = "OpenGL"
config.max_fps = 144
config.animation_fps = 1
config.term = "xterm-256color"
config.default_cursor_style = "SteadyBlock"
config.window_background_opacity = 0.3
config.color_scheme = "Dracula"
config.font = wezterm.font("JetBrains Mono NL")
config.font_size = 16
config.window_padding = {
	left = 1,
	right = 0,
	top = 1,
	bottom = 0
}

config.window_decorations = "NONE | RESIZE"
config.default_prog = { "C:/Program Files/PowerShell/7/pwsh.exe" }
config.initial_cols = 10
config.adjust_window_size_when_changing_font_size = false

config.disable_default_key_bindings = true

config.keys = {
	{
		key = 'v',
		mods = 'CTRL',
		action = wezterm.action.PasteFrom 'Clipboard'
	},
	-- {
	-- 	key = 'm',
	-- 	mods = 'CTRL|SHIFT',
	-- 	action = wezterm.action.PromptInputLine {
	-- 		description = wezterm.format {
	-- 			{ Attribute = { Intensity = 'Bold' } },
	-- 			{ Foreground = { AnsiColor = 'Fuchsia' } },
	-- 			{ Text = 'Enter name for new workspace' },
	-- 		},
	-- 		action = wezterm.action_callback(function(window, pane, line)
	-- 			-- line will be `nil` if they hit escape without entering anything
	-- 			-- An empty string if they just hit enter
	-- 			-- Or the actual line of text they wrote
	-- 			if line then
	-- 				window:perform_action(
	-- 					wezterm.action.SwitchToWorkspace {
	-- 						name = line,
	-- 					},
	-- 					pane
	-- 				)
	-- 			end
	-- 		end),
	-- 	},
	-- },
	-- {
	-- 	mods = "CTRL | SHIFT",
	-- 	key = "s",
	-- 	action = wezterm.action_callback(function(win, pane)
	-- 		win:perform_action(wezterm.action.EmitEvent("save-indicator"), pane)
	-- 		resurrect.state_manager.save_state(resurrect.workspace_state.get_workspace_state())
	-- 		resurrect.window_state.save_window_action()
	-- 	end),
	-- },
	-- {
	-- 	mods = "CTRL | SHIFT",
	-- 	key = "f",
	-- 	action = wezterm.action_callback(function(win, pane)
	-- 		resurrect.fuzzy_loader.fuzzy_load(win, pane, function(id, label)
	-- 			local type = string.match(id, "^([^/]+)") -- match before '/'
	-- 			id = string.match(id, "([^/]+)$") -- match after '/'
	-- 			id = string.match(id, "(.+)%..+$") -- remove file extention
	-- 			local opts = {
	-- 				relative = true,
	-- 				restore_text = true,
	-- 				on_pane_restore = resurrect.tab_state.default_on_pane_restore,
	-- 			}
	-- 			if type == "workspace" then
	-- 				local state = resurrect.state_manager.load_state(id, "workspace")
	-- 				resurrect.workspace_state.restore_workspace(state, opts)
	-- 			elseif type == "window" then
	-- 				local state = resurrect.state_manager.load_state(id, "window")
	-- 				resurrect.window_state.restore_window(pane:window(), state, opts)
	-- 			elseif type == "tab" then
	-- 				local state = resurrect.state_manager.load_state(id, "tab")
	-- 				resurrect.tab_state.restore_tab(pane:tab(), state, opts)
	-- 			end
	-- 		end)
	-- 	end),
	-- },
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

-- for i = 0, 9 do
--     -- leader + number to activate that tab
--     table.insert(config.keys, {
--         key = tostring(i),
--         mods = "LEADER",
--         action = wezterm.action.ActivateTab(i),
--     })
-- end

-- tab bar
config.hide_tab_bar_if_only_one_tab = false
config.tab_bar_at_bottom = true
config.use_fancy_tab_bar = false
config.tab_and_split_indices_are_zero_based = true

--tmux restore
wezterm.on("save-indicator", function(window, _)
	local saved_icon = " " .. "\u{eb4b}" .. "  ";

	window:set_left_status(wezterm.format {
		{ Text = saved_icon },
	})

	wezterm.sleep_ms(1500)
	window:set_left_status("")
end)

return config
