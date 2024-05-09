-- NEW

vim.api.nvim_create_autocmd('LspAttach', {
    group = vim.api.nvim_create_augroup('user_lsp_attach', {clear = true}),
    callback = function(event)
        local opts = {buffer = event.buf}

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
    end,
})

local cmp = require('cmp')
local cmp_lsp = require('cmp_nvim_lsp')
local capabilities = vim.tbl_deep_extend(
    "force",
    {},
    vim.lsp.protocol.make_client_capabilities(),
    cmp_lsp.default_capabilities()
)

require('fidget').setup({})
require('mason').setup({})
require('mason-lspconfig').setup({
     ensure_installed = {
        'html',
        'cssls',
        'tsserver',
        'pyright'
    },
    
    handlers = {
        function(server_name)
            require('lspconfig')[server_name].setup({
                capabilities = lsp_capabilities,
            })
        end,
        ["lua_ls"] = function()
            local lspconfig = require('lspconfig')
            lspconfig.lua_ls.setup{
                capabilities = capabilities,
                settings = {
                    Lua = {
                        diagnostics = {
                            globals = { 'vim' }
                        }
                    }
                }
            
            }
        end,
    }
})

local cmp_select = { behavior = cmp.SelectBehavior.Insert }

cmp.setup({
    snippet = {
        expand = function(args)
            require('luasnip').lsp_expand(args.body)
        end,
    },
    mapping = cmp.mapping.preset.insert({
        ['<C-y>'] = cmp.mapping.confirm({ select = true }),
        ["<C-u>"] = cmp.mapping.scroll_docs(-4),
        ["<C-d>"] = cmp.mapping.scroll_docs(4),
        ["<C-n>"] = cmp.mapping.select_next_item(cmp_select),
        ["<C-p>"] = cmp.mapping.select_prev_item(cmp_select),
        ['<C-Space>'] = cmp.mapping.complete(),
        ['<Tab>'] = nil,
        ['<S-Tab>'] = nil,
    }),
    sources = cmp.config.sources({
        { name = "nvim_lsp" },
        { name = "luasnip" },
    },{
        { name = "buffer" },
    })
})

vim.diagnostic.config({
    -- virtual_text = true,
    float = {
        focusable = false,
        style = "minimal",
        border = "rounded",
        source = "always",
        header = "",
        prefix = "",
    },
})

local lspkind = require("lspkind")
local source_mapping = {
    buffer = "[Buffer]",
    nvim_lsp = "[LSP]",
    nvim_lua = "[Lua]",
    path = "[Path]",
}

-- lsp.setup_nvim_cmp({
--     mapping = cmp_mappings,
--     formatting = {
--         format = function(entry, vim_item)
--             vim_item.kind = lspkind.presets.default[vim_item.kind]
--             local menu = source_mapping[entry.source.name]
--             --if entry.source.name == "cmp_tabnine" then
--             --if entry.completion_item.data ~= nil and entry.completion_item.data.detail ~= nil then
--             --menu = entry.completion_item.data.detail .. " " .. menu
--             --end
--             --vim_item.kind = ""
--             --end
--             vim_item.menu = menu
--             return vim_item
--         end,
--     },
--     sources = {
--         -- tabnine completion? yayaya
--         --{ name = "cmp_tabnine" },
--         { name = "nvim_lsp" },
--         -- For luasnip user.
--         { name = "luasnip" },
--         { name = "buffer" },
--     },
-- })
--
-- lsp.set_preferences({
--     suggest_lsp_servers = false,
--     sign_icons = {
--         error = 'E',
--         warn = 'W',
--         hint = 'H',
--         info = 'I'
--     }
-- })


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
