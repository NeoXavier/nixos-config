-- Page up and down while cursor remains at the center
vim.keymap.set("n", "<C-d>", "<C-d>zz")
vim.keymap.set("n", "<C-u>", "<C-u>zz")

-- Moving chunks of code
vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv")
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv")

-- Join without moving cursor
vim.keymap.set("n", "J", "mzJ`z`")

-- Search terms to stay in the middle of screen
vim.keymap.set("n", "n", "nzzzv")
vim.keymap.set("n", "N", "Nzzzv")

-- Paste, removed text goes into void register
vim.keymap.set("x", "<leader>p", "\"_dP")
-- Delete to void register
vim.keymap.set("n", "<leader>d", "\"_d")
vim.keymap.set("v", "<leader>d", "\"_d")

-- next greatest remap ever : asbjornHaland
-- Yank to system clipboard
vim.keymap.set("n", "<leader>y", "\"+y")
vim.keymap.set("v", "<leader>y", "\"+y")
vim.keymap.set("n", "<leader>Y", "\"+Y")

-- Unmap Q
vim.keymap.set("n", "Q", "<nop>")

-- Replace current word
vim.keymap.set("n", "<leader>s", [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]])

-- Formatting
--vim.keymap.set("n", "<leader>f", "<cmd>LspZeroFormat<CR>")
--vim.keymap.set("v", "<leader>f", "<cmd>LspZeroFormat<CR>")
vim.keymap.set("n", "<leader>f", vim.lsp.buf.format)
vim.keymap.set("v", "<leader>f", vim.lsp.buf.format)

-- Split windows
vim.keymap.set("n", "<C-w><Bar>", ":vsplit<CR>")
vim.keymap.set("n", "<C-w>_", ":split<CR>")

-- Jump buffers
vim.keymap.set("n", "<leader><Tab>", "<cmd>bn<CR>")
vim.keymap.set("n", "<leader><S-Tab>", "<cmd>bp<CR>")
vim.keymap.set("n", "<leader>bd", "<cmd>bdelete<CR>")

-- Move cursor in insert mode
-- vim.keymap.set("i", "<C-l>", "<Right>")
-- vim.keymap.set("i", "<C-h>", "<Left>")

-- Open netrw
vim.keymap.set("n", "<leader>o", vim.cmd.Ex)

--Fugitive
vim.keymap.set("n", "<leader>gs", vim.cmd.Git)

-- Undo tree
vim.keymap.set("n", "<leader>u", vim.cmd.UndotreeToggle)

-- Quickfix navigation
vim.keymap.set("n", "<C-j>", "<cmd>cnext<CR>zz")
vim.keymap.set("n", "<C-k>", "<cmd>cprev<CR>zz")

-- Trouble navigation
vim.keymap.set("n", "]d", function() require("trouble").next({skip_groups = true, jump = true}) end)
vim.keymap.set("n", "[d", function() require("trouble").previous({skip_groups = true, jump = true}) end)

-- Symbols Outline
vim.keymap.set("n", "<leader>so", vim.cmd.SymbolsOutline)


