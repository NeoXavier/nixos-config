local actions = require("telescope.actions")
local trouble = require("trouble.providers.telescope")

require("telescope").setup({
    defaults = {
        file_sorter = require("telescope.sorters").get_fzy_sorter,
        prompt_prefix = " >",
        color_devicons = true,
        file_previewer = require("telescope.previewers").vim_buffer_cat.new,
        grep_previewer = require("telescope.previewers").vim_buffer_vimgrep.new,
        qflist_previewer = require("telescope.previewers").vim_buffer_qflist.new,
        mappings = {
            i = {
                ["<C-x>"] = false,
                ["<C-q>"] = actions.send_to_qflist,
                ["<CR>"] = actions.select_default,
                ["<C-t>"] = trouble.open_with_trouble,
            },
            n = { ["<C-t>"] = trouble.open_with_trouble },
        },
        --vimgrep_arguments = {
            --'rg',
            --'--color=never',
            --'--no-heading',
            --'--with-filename',
            --'--line-number',
            --'--column',
            --'--smart-case',
            --'--hidden',
        --},
    },
    --[[
	extensions = {
		fzy_native = {
			override_generic_sorter = false,
			override_file_sorter = true,
		},
	},
    ]]
})

--require("telescope").load_extension("git_worktree")
-- require("telescope").load_extension("fzy_native")

local M = {}

function M.reload_modules()
    -- Because TJ gave it to me.  Makes me happpy.  Put it next to his other
    -- awesome things.
    local lua_dirs = vim.fn.glob("./lua/*", 0, 1)
    for _, dir in ipairs(lua_dirs) do
        dir = string.gsub(dir, "./lua/", "")
        require("plenary.reload").reload_module(dir)
    end
end

M.search_dotfiles = function()
    require("telescope.builtin").find_files({
        prompt_title = "< VimRC >",
        cwd = vim.env.DOTFILES,
        hidden = true,
    })
end

M.git_branches = function()
    require("telescope.builtin").git_branches({
        attach_mappings = function(_, map)
            map("i", "<c-d>", actions.git_delete_branch)
            map("n", "<c-d>", actions.git_delete_branch)
            return true
        end,
    })
end

return M
