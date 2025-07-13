vim.g.mapleader = " "
local set = vim.keymap.set

set("n", "<C-s>", ":w<CR>", { desc = "Save file", noremap = true, silent = true })
set("i", "<C-s>", "<cmd>:w<CR>", { desc = "Save file", noremap = true, silent = true })

-- window management
set("n", "<leader>sv", "<C-w>v", { desc = "Split window vertically" })     -- split window vertically
set("n", "<leader>sh", "<C-w>s", { desc = "Split window horizontally" })   -- split window horizontally
set("n", "<leader>se", "<C-w>=", { desc = "Make splits equal size" })      -- make split windows equal width & height
set("n", "<leader>sq", "<cmd>close<CR>", { desc = "Close current split" }) -- close current split window
set("n", "<Esc>", "<cmd>nohlsearch<CR>", { desc = "Clear search with esc" })


set("n", "<C-Left>", "<cmd>vertical resize -5<CR>", { desc = "Make the window smaller by 5 columns" })
set("n", "<C-Right>", "<cmd>vertical resize +5<CR>", { desc = "Make the window bigger by 5 columns" })
set('n', '<C-up>', '<cmd>resize +5<CR>', { noremap = true, silent = true })
set('n', '<C-down>', '<cmd>resize -5<CR>', { noremap = true, silent = true })

set("n", "<C-a>", "ggVG", { desc = "select all everything inside current file" })

set("t", "<Esc><Esc>", "<C-\\><C-n>", { desc = "Go into the normal mode in terminal mode" })

set("v", "J", ":m '>+1<CR>gv=gv")
set("v", "K", ":m '<-2<CR>gv=gv")

set("n", "<C-d>", "<C-d>zz")
set("n", "<C-u>", "<C-u>zz")

set("n", "n", "nzzzv")
set("n", "N", "Nzzzv")

set("x", ">", ">gv")
set("x", "<", "<gv")

set("x", "<leader>p", "\"_dP", { desc = "When pasting over selected it sends it to the void register" })

-- Copy Full File-Path
set("n", "<leader>yp", function()
    local path = vim.fn.expand("%:p")
    vim.fn.setreg("+", path)
    print("file:", path)
end)

set("n", "<F5>", function()
    if vim.bo.filetype == "java" then
        local home = vim.fn.expand("~")
        local cmd = string.format(
            [[pwsh -NoProfile -Command "mvn clean package -DskipTestscd; if (Test-Path '%s\\Tomcat\\webapps\\api.war') { Remove-Item -Force '%s\\Tomcat\\webapps\\api.war' } Copy-Item 'SignoSoftServer\target\SignoSoftServer.war' '%s\\Tomcat\\webapps\\api.war'"]],
            home, home, home
        )
        vim.cmd("!" .. cmd)
    end
    if vim.bo.filetype == "cpp" then
        vim.cmd("!cd " .. vim.fn.getcwd() .. "\\build && cmake --build . && main.exe")
    end
end, { noremap = true, silent = true })

-- set("n", "<F5>", function()
-- 	if vim.bo.filetype == "cpp" then
-- 		vim.cmd("!cd " .. vim.fn.getcwd() .. "\\build && cmake --build . && main.exe")
-- 	end
-- end, { noremap = true, silent = true })

vim.api.nvim_create_autocmd("FileType", {
    pattern = { "sql", "mysql", "pgsql", "plsql" },
    callback = function()
        set("v", "x", ":DB<CR>", { buffer = true, silent = true })
    end
})

vim.api.nvim_create_autocmd("FileType", {
    pattern = "lua",
    callback = function()
        set("n", "<leader>x", "<cmd>.lua<CR>", { desc = "Execute the current line", buffer = true, silent = true })
        set("n", "<leader><leader>x", "<cmd>source %<CR>",
            { desc = "Execute the current file", buffer = true, silent = true })
    end
})
-- very cool remap
set("n", "j", function()
    local count = vim.v.count

    if count == 0 then
        return "gj"
    else
        return "j"
    end
end, { expr = true })

set("n", "k", function()
    local count = vim.v.count

    if count == 0 then
        return "gk"
    else
        return "k"
    end
end, { expr = true })
