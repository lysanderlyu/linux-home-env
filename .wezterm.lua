-- Pull in the wezterm API
local wezterm = require 'wezterm'

-- This will hold the configuration.
local config = wezterm.config_builder()

-- This is where you actually apply your config choices.
-- config.front_end = "WebGpu"
config.front_end = "OpenGL"
config.max_fps = 180
config.animation_fps = 180

-- For example, changing the initial geometry for new windows:
config.initial_cols = 150
config.initial_rows = 35

-- or, changing the font size and color scheme.
config.font_size = 13
-- config.color_scheme = 'Dimmed Monokai (Gogh)'
config.color_scheme = 'DotGov'
config.default_prog = { 'wsl.exe'}

local act = wezterm.action
config.mouse_bindings = {
  -- Right click: copy if selection, otherwise paste
  {
    event = { Down = { streak = 1, button = 'Right' } },
    mods = 'NONE',
    action = act.Multiple {
      act.CopyTo 'ClipboardAndPrimarySelection',
      act.ClearSelection,
      act.PasteFrom 'Clipboard',
    },
  },
}

-- Alt + number to activate specific tab
config.keys = {
  -- New tab
  { key = 't', mods = 'CTRL', action = act.SpawnTab 'CurrentPaneDomain' },

  { key = '1', mods = 'ALT', action = act.ActivateTab(0) },
  { key = '2', mods = 'ALT', action = act.ActivateTab(1) },
  { key = '3', mods = 'ALT', action = act.ActivateTab(2) },
  { key = '4', mods = 'ALT', action = act.ActivateTab(3) },
  { key = '5', mods = 'ALT', action = act.ActivateTab(4) },
  { key = '6', mods = 'ALT', action = act.ActivateTab(5) },
  { key = '7', mods = 'ALT', action = act.ActivateTab(6) },
  { key = '8', mods = 'ALT', action = act.ActivateTab(7) },
  { key = '9', mods = 'ALT', action = act.ActivateTab(8) },
}

-- Finally, return the configuration to wezterm:
return config
