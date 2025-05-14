return {
	"kevinhwang91/nvim-ufo",
	dependencies = { 'kevinhwang91/promise-async' },
	config = function()
		require("ufo").setup();

		vim.o.foldcolumn = "0"
		vim.o.foldlevel = 99 -- Using ufo provider need a large value, feel free to decrease the value
		vim.o.foldlevelstart = 99
		vim.o.foldenable = true
	end

}
