return {
    "adibhanna/laravel.nvim",
    dependencies = {
        "MunifTanjim/nui.nvim",
        "nvim-lua/plenary.nvim",
    },
    keys = {
        {
            "<leader>la",
            function()
                require("lsp.laravel-pickers").artisan()
            end,
            desc = "Laravel Artisan picker",
        },
    },
    config = function()
        require("laravel").setup({
            notifications = true,
            debug = false,
            keymaps = true,
            sail = {
                enabled = true,
                auto_detect = true,
            },
        })

        local map = vim.keymap.set

        map("n", "<leader>la", function()
            require("lsp.laravel-pickers").artisan()
        end, { desc = "Laravel Artisan picker" })

        map("n", "<leader>lc", "<cmd>Composer<cr>", { desc = "Composer" })
        map("n", "<leader>lr", "<cmd>LaravelRoute<cr>", { desc = "Laravel Routes" })
        map("n", "<leader>lm", "<cmd>LaravelMake<cr>", { desc = "Laravel Make" })

        map("n", "<leader>Ld", function()
            require("laravel.dump").open()
        end, { desc = "Open Laravel dump viewer" })

        map("n", "<leader>Lde", function()
            require("laravel.dump").enable()
        end, { desc = "Enable dump capture" })
    end,
}
