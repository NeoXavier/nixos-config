local ls = require("luasnip")

ls.config.set_config({
    history = true,
    updateevents = "TextChanged,TextChangedI",
    enable_autosnippets = true,
    ext_opts = {
        [require("luasnip.util.types").choiceNode] = {
            active = {
                virt_text = {{ "●", "Comment" }},
            },
        },
    },
})

---- Keymaps
--vim.keymap.set({"i", "s"}, "<leader>p", function()
    --if ls.expand_or_jumpable() then
        --ls.expand()
    --end
--end)

vim.keymap.set({"i", "s"}, "<M-l>", function()
    if ls.jumpable(1) then
        ls.jump(1)
    end
end)

vim.keymap.set({"i", "s"}, "<M-h>", function()
    if ls.jumpable(-1) then
        ls.jump(-1)
    end
end)

vim.keymap.set({"i", "s"}, "<M-j>", function()
    if ls.choice_active() then
        ls.change_choice(1)
    end
end)

vim.keymap.set({"i", "s"}, "<M-k>", function()
    if ls.choice_active() then
        ls.change_choice(-1)
    end
end)
