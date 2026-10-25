return {
    {
        'akinsho/toggleterm.nvim',
        version = "*",
        config = function()
            require("toggleterm").setup({
                open_mapping = [[<C-t>]],
                direction = 'vertical',
                size = function(term)
                    return vim.o.columns * 0.5
                end,
                insert_mappings = true,
                terminal_mappings = true,

                auto_scroll = false,
            })
        end,
    }
}
