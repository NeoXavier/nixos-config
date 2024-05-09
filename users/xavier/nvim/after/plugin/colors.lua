-- One dark setup
--vim.cmd.colorscheme 'onedark
--vim.cmd.colorscheme 'onedark_vivid'

-- Rose Pine Set up
-- require("rose-pine").setup({
--     variant = "moon",
--     dark_variant = 'moon',
--     --bold_vert_split = true,
--     dim_inactive_windows = false,
--     extend_background_behind_borders = true,
--
--     styles = {
--         bold = true,
--         italic = true,
--         transparency = false,
--     }
--     --disable_float_background = true,
--     --disable_background = true,
--     --dim_nc_background = true
-- })
-- vim.cmd.colorscheme('rose-pine-moon')

require("catppuccin").setup({
    flavour = "mocha",
    -- flavour = "macchiato",
    -- background = {
    --     dark = "mocha",
    -- },

})
vim.cmd.colorscheme('catppuccin')

-- vim.cmd.colorscheme('gruvbox')

-- Gruvbox Material

-- vim.g.gruvbox_material_better_performance = 1
-- vim.g.gruvbox_material_foreground = 'mix'
-- vim.g.gruvbox_material_background = 'hard'
-- vim.g.gruvbox_material_ui_contrast = 'high' -- The contrast of line numbers, indent lines, etc.
--
-- vim.cmd[[colorscheme gruvbox-material]]

