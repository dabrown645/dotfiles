local wezterm = require("wezterm")
local smart_splits = wezterm.plugin.require("https://github.com/mrjones2014/smart-splits.nvim")
local act = wezterm.action
local config = wezterm.config_builder()
-- you can put the rest of your Wezterm config here
--
config.warn_about_missing_glyphs = false

-- Screen configuration
-- config.color_scheme = "kanagawabones"
-- config.color_scheme = "Catppuccin Mocha"
config.color_scheme = "tokyonight"

config.use_fancy_tab_bar = true
config.hide_tab_bar_if_only_one_tab = true
config.window_background_opacity = 1.0
config.initial_rows = 47
config.initial_cols = 120
-- config.font = wezterm.font("Cascadia Code")
config.font = wezterm.font("FiraCode Nerd Font")
-- config.font = wezterm.font("Jetbrains Mono")
config.font_size = 11

-- Key configuration
-- Config LEADER
config.leader = { key = "Space", mods = "CTRL", timeout_milliseconds = 2000 }

config.keys = {
  -- Show tab navigation
  { key = "t", mods = "LEADER", action = act.ShowTabNavigator },
  -- spitting screen
  { key = "-", mods = "LEADER", action = act.SplitVertical({ domain = "CurrentPaneDomain" }) },
  { key = "=", mods = "LEADER", action = act.SplitHorizontal({ domain = "CurrentPaneDomain" }) },
  -- Toggle zome on a pane
  { key = "m", mods = "LEADER", action = act.TogglePaneZoomState },
  -- Rotate panes
  { key = "r", mods = "LEADER", action = act.RotatePanes("Clockwise") },
  -- Open WezTerm config file quickly
  {
    key = ",",
    mods = "CMD",
    action = act.SpawnCommandInNewTab({
      cwd = os.getenv("WEZTERM_CONFIG_DIR"),
      args = { "nvim", os.getenv("WEZTERM_CONFIG_FILE") },
    }),
  },
}

smart_splits.apply_to_config(config, {
  -- the default config is here, if you'd like to use the default keys,
  -- you can omit this configuration table parameter and just use
  -- smart_splits.apply_to_config(config)

  -- directional keys to use in order of: left, down, up, right
  direction_keys = { "h", "j", "k", "l" },
  -- modifier keys to combine with direction_keys
  modifiers = {
    move = "CTRL", -- modifier to use for pane movement, e.g. CTRL+h to move left
    resize = "META", -- modifier to use for pane resize, e.g. META+h to resize to the left
  },
})

--return out module table
return config
