local wezterm = require("wezterm")

return {
	enable_wayland = false,
	font_size = 14.0,
	font = wezterm.font("FantasqueSansM Nerd Font", { weight = "Regular" }),
	font_rules = {
		{
			intensity = "Bold",
			italic = false,
			font = wezterm.font("FantasqueSansM Nerd Font", { weight = "Regular" }),
		},
		{
			intensity = "Bold",
			italic = true,
			font = wezterm.font("FantasqueSansM Nerd Font", { weight = "Regular", italic = true }),
		},
	},
	colors = {
		background = "#222222",
		foreground = "#f0f0f0",
		cursor_bg = "#f0f0f0",
		cursor_fg = "#222222",
		cursor_border = "#f0f0f0",
		selection_bg = "#3a3a3a",
		selection_fg = "#f0f0f0",
		ansi = {
			"#2e2e2e",
			"#c06060",
			"#90a959",
			"#f2ae49",
			"#6a9fb5",
			"#aa759f",
			"#75b5aa",
			"#d0d0d0",
		},
		brights = {
			"#4e4e4e",
			"#d18f8f",
			"#a7bd68",
			"#ffcc66",
			"#82b3c9",
			"#c69ac6",
			"#9ad1b4",
			"#f0f0f0",
		},
	},
	window_padding = {
		left = 8,
		right = 8,
		top = 6,
		bottom = 6,
	},
	window_background_opacity = 0.95,
	text_background_opacity = 1.0,

	enable_tab_bar = false,
	use_fancy_tab_bar = false,
	hide_tab_bar_if_only_one_tab = true,

	default_cursor_style = "SteadyBar",
}
