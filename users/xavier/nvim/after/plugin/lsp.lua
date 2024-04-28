local lsp = require("lsp-zero")

lsp.preset("recommended")

lsp.ensure_installed({
    'html',
    'cssls',
    'tsserver',
    'pyright'
})

lsp.configure('lua_ls', {
    settings = {
        Lua = {
            diagnostics = {
                globals = { 'vim' }
            }
        }
    }
})

lsp.configure('ltex', {
    settings = {
        ltex = {
            language = "en-GB",
            dictionary = "en",
            formatter = "latexindent",
        },
    },
})

local cmp = require('cmp')
local cmp_select = { behavior = cmp.SelectBehavior.Insert }
local cmp_mappings = lsp.defaults.cmp_mappings({
    ['<C-y>'] = cmp.mapping.confirm({ select = true }),
    ["<C-u>"] = cmp.mapping.scroll_docs(-4),
    ["<C-d>"] = cmp.mapping.scroll_docs(4),
    ["<C-n>"] = cmp.mapping.select_next_item(cmp_select),
    ["<C-p>"] = cmp.mapping.select_prev_item(cmp_select),
    ['<C-Space>'] = cmp.mapping.complete(),
})

-- disable completion with tab
-- this helps with copilot setup
cmp_mappings['<Tab>'] = nil
cmp_mappings['<S-Tab>'] = nil

local lspkind = require("lspkind")
local source_mapping = {
    buffer = "[Buffer]",
    nvim_lsp = "[LSP]",
    nvim_lua = "[Lua]",
    path = "[Path]",
}

lsp.setup_nvim_cmp({
    mapping = cmp_mappings,
    formatting = {
        format = function(entry, vim_item)
            vim_item.kind = lspkind.presets.default[vim_item.kind]
            local menu = source_mapping[entry.source.name]
            --if entry.source.name == "cmp_tabnine" then
            --if entry.completion_item.data ~= nil and entry.completion_item.data.detail ~= nil then
            --menu = entry.completion_item.data.detail .. " " .. menu
            --end
            --vim_item.kind = ""
            --end
            vim_item.menu = menu
            return vim_item
        end,
    },
    sources = {
        -- tabnine completion? yayaya
        --{ name = "cmp_tabnine" },
        { name = "nvim_lsp" },
        -- For luasnip user.
        { name = "luasnip" },
        { name = "buffer" },
    },
})

lsp.set_preferences({
    suggest_lsp_servers = false,
    sign_icons = {
        error = 'E',
        warn = 'W',
        hint = 'H',
        info = 'I'
    }
})

lsp.on_attach(function(client, bufnr)
    local opts = { buffer = bufnr, remap = false }

    if client.name == "eslint" then
        vim.cmd.LspStop('eslint')
        return
    end

    vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
    vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)
    vim.keymap.set("n", "<leader>vws", vim.lsp.buf.workspace_symbol, opts)
    vim.keymap.set("n", "<leader>vd", vim.diagnostic.open_float, opts)
    --vim.keymap.set("n", "[d", vim.diagnostic.goto_next, opts)
    --vim.keymap.set("n", "]d", vim.diagnostic.goto_prev, opts)
    vim.keymap.set("n", "<leader>vca", vim.lsp.buf.code_action, opts)
    vim.keymap.set("n", "<leader>vrr", vim.lsp.buf.references, opts)
    vim.keymap.set("n", "<leader>vrn", vim.lsp.buf.rename, opts)
    --vim.keymap.set("i", "<C-h>", vim.lsp.buf.signature_help, opts)
    -- Create a command `:Format` local to the LSP buffer
    vim.api.nvim_buf_create_user_command(bufnr, 'Format', function(_)
        if vim.lsp.buf.format then
            vim.lsp.buf.format()
        elseif vim.lsp.buf.formatting then
            vim.lsp.buf.formatting()
        end
    end, { desc = 'Format current buffer with LSP' })
end)

lsp.setup()

vim.diagnostic.config({
    virtual_text = true,
})

local opts = {
    -- whether to highlight the currently hovered symbol
    -- disable if your cpu usage is higher than you want it
    -- or you just hate the highlight
    -- default: true
    highlight_hovered_item = true,
    -- whether to show outline guides
    -- default: true
    show_guides = true,
}

require("symbols-outline").setup(opts)

local snippets_paths = function()
    --local plugins = { "friendly-snippets" }
    local paths = {}
    --local path
    local root_path = vim.env.HOME
    --local plugin_path = "/.local/share/nvim/site/pack/packer/start/"
    local custom = "/.config/nvim/mySnippets"
    local user_path
    --for _, plug in ipairs(plugins) do
        --path = root_path .. plugin_path .. plug
        --if vim.fn.isdirectory(path) ~= 0 then
            --table.insert(paths, path)
        --end
    --end

    user_path = root_path .. custom
    if vim.fn.isdirectory(user_path) ~= 0 then
        table.insert(paths, user_path)
    end

    return paths
end

require("luasnip.loaders.from_vscode").lazy_load({
    paths = "~/.config/nvim/mySnippets",
    --include = nil, -- Load all languages
    exclude = {"plaintex", "tex"},
})
