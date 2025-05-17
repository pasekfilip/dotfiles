return {
	"aznhe21/actions-preview.nvim",
	config = function()
		vim.keymap.set({ "v", "n" }, "<leader>la", require("actions-preview").code_actions,
			{ desc = "Preview code actions" })
	end,
}
