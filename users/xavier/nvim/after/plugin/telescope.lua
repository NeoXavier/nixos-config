local builtin = require('telescope.builtin')

vim.keymap.set('n', '<leader>?', require('telescope.builtin').oldfiles, { desc = '[?] Find recently opened files' })
vim.keymap.set('n', '<leader>fb', require('telescope.builtin').buffers, { desc = '[F]ind existing [B]uffers' })
vim.keymap.set('n', '<leader>/', function()
    -- You can pass additional configuration to telescope to change theme, layout, etc.
    require('telescope.builtin').current_buffer_fuzzy_find(require('telescope.themes').get_dropdown {
        winblend = 10,
        previewer = false,
    })
end, { desc = '[/] Fuzzily search in current buffer]' })

vim.keymap.set('n', '<leader>ff', function()
    require('telescope.builtin').find_files({})
end, { desc = '[F]ind [F]iles' })
vim.keymap.set('n', '<leader>sh', require('telescope.builtin').help_tags, { desc = '[S]earch [H]elp' })
vim.keymap.set('n', '<leader>sw', require('telescope.builtin').grep_string, { desc = '[S]earch current [W]ord' })
vim.keymap.set('n', '<leader>lg', require('telescope.builtin').live_grep, { desc = '[L]ive [G]rep' })
vim.keymap.set('n', '<leader>sd', require('telescope.builtin').diagnostics, { desc = '[S]earch [D]iagnostics' })

vim.keymap.set('n', '<leader>ps', function()
	builtin.grep_string({ search = vim.fn.input("Grep > ") })
end)

vim.keymap.set('n', "<C-p>", "<cmd>Telescope<CR>")
vim.keymap.set('n', "<leader>gf", function()
    require('telescope.builtin').git_files()
end)
vim.keymap.set('n', "<leader>vr", function()
    require('plugin.telescope').search_dotfiles()
end)

--nnoremap("<leader>fg", function()
--require('telescope.builtin').grep_string({ search = vim.fn.input("Grep For > ")})
--end)
--nnoremap("<Leader>lg", function()
--require('telescope.builtin').live_grep()
--end)

--nnoremap("<leader>pw", function()
--require('telescope.builtin').grep_string { search = vim.fn.expand("<cword>") }
--end)
--nnoremap("<leader>gc", function()
--require('theprimeagen.telescope').git_branches()
--end)
--nnoremap("<leader>gw", function()
--require('telescope').extensions.git_worktree.git_worktrees()
--end)
--nnoremap("<leader>gm", function()
--require('telescope').extensions.git_worktree.create_git_worktree()
--end)
--nnoremap("<leader>td", function()
--require('theprimeagen.telescope').dev()
--end)
