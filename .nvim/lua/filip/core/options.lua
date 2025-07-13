vim.cmd("let g:netrw_liststyle = 3")

local opt = vim.opt

opt.relativenumber = true
opt.number = true
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1
vim.g.undotree_DiffCommand = "FC"

-- tabs & indentation
opt.tabstop = 4       -- 4 spaces for tabs (prettier default)
opt.shiftwidth = 4    -- 2 spaces for indent width
opt.expandtab = false -- expand tab to spaces
opt.softtabstop = 4
opt.autoindent = true -- copy indent from current line when starting new one
opt.breakindent = true

-- line wrapping
opt.wrap = true
opt.linebreak = true

-- search settings
opt.ignorecase = true -- ignore case when searching
opt.smartcase = true  -- if you include mixed case in your search, assumes you want case-sensitive
opt.scrolloff = 8
-- cursor line
opt.cursorline = true -- highlight the current cursor line

-- appearance

-- turn on termguicolors for nightfly colorscheme to work
-- (have to use iterm2 or any other true color terminal)
opt.termguicolors = true
opt.background = "dark" -- colorschemes that can be light or dark will be made dark
opt.signcolumn = "yes"  -- show sign column so that text doesn't shif
opt.updatetime = 300
vim.o.lazyredraw = true
opt.timeoutlen = 300
-- backspace
opt.backspace = "indent,eol,start" -- allow backspace on indent, end of line or insert mode start position

-- clipboard
opt.clipboard:append("unnamedplus") -- use system clipboard as default register

-- split windows
opt.splitright = true -- split vertical window to the right
opt.splitbelow = true -- split horizontal window to the bottom

opt.inccommand = 'split'
opt.wildmode = "longest:full,full" -- Command-line completion mode
opt.more = true
opt.swapfile = false
opt.undofile = true
opt.shada = { "'10", "<0", "s10", "h" }

vim.api.nvim_create_autocmd('TextYankPost', {
	desc = 'Highlight when yanking (copying) text',
	group = vim.api.nvim_create_augroup('kickstart-highlight-yank', { clear = true }),
	callback = function()
		vim.highlight.on_yank()
	end,
})

-- vim.api.nvim_create_autocmd("FileType", {
-- 	pattern = "json",
-- 	callback = function()
-- 		vim.bo.shiftwidth = 2
-- 		vim.bo.tabstop = 2
-- 		vim.softtabstop = 2
-- 	end
-- })

vim.api.nvim_create_autocmd("FileType", {
	pattern = "*",
	callback = function()
		vim.opt.formatoptions = "jql"
	end,
})
--
-- local projectFile = vim.fn.filereadable(vim.fn.getcwd() .. '/project.godot')
-- if projectFile > 0 then
-- 	vim.fn.serverstart("127.0.0.1:6666")
-- end
