return {
	{
		"folke/tokyonight.nvim",
		enabled = true,
		priority = 1000, -- make sure to load this before all the other start plugins
		config = function()
			local bg = "#011628"
			local bg_dark = "#011423"
			local bg_highlight = "#143652"
			local bg_search = "#0A64AC"
			local bg_visual = "#275378"
			local fg = "#CBE0F0"
			local fg_dark = "#B4D0E9"
			local fg_gutter = "#627E97"
			local border = "#547998"

			require("tokyonight").setup({
				style = "night",
				-- transparent = true,
				on_colors = function(colors)
					colors.bg = bg
					colors.bg_dark = bg_dark
					colors.bg_float = bg_dark
					colors.bg_highlight = bg_highlight
					colors.bg_popup = bg_dark
					colors.bg_search = bg_search
					colors.bg_sidebar = bg_dark
					colors.bg_statusline = bg_dark
					colors.bg_visual = bg_visual
					colors.border = border
					colors.fg = fg
					colors.fg_dark = fg_dark
					colors.fg_float = fg
					colors.fg_gutter = fg_gutter
					colors.fg_sidebar = fg_dark
				end,
			})

			-- load the colorscheme here
			vim.cmd([[colorscheme tokyonight]])
		end,
	},
	{
		"rose-pine/neovim",
		enabled = false,
		name = "rose-pine",
		priority = 1000,
		config = function()
			require("rose-pine").setup({
				-- disable_background = true,
			})
			vim.cmd("colorscheme rose-pine")
			-- Highlight Tree-sitter types differently
			-- vim.api.nvim_set_hl(0, "@lsp.type.class", { fg = "#569CD6" })
			vim.api.nvim_set_hl(0, "@lsp.type.enum", { fg = "#D19A66" })
		end
	}
}
