return {
	{
		'akinsho/toggleterm.nvim',
		version = "*",
		keys = {
			{ "<leader>t", "<cmd>ToggleTerm<CR>" }
		},
		config = function()
			require('toggleterm').setup({
				size = 100,
				-- open_mapping = [[<C-/]],
				shading_factor = 2,
				direction = 'float', -- 'vertical' | 'horizontal' | 'tab' | 'float'
				close_on_exit = true,
				shell = 'pwsh.exe',
				on_open = function (term)
					local cwd = vim.fn.getcwd()
					vim.fn.chansend(term.job_id, "cd '" .. cwd .. "'; clear \r")
				end
			})
		end
	},
}
