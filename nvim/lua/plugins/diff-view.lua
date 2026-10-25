return {
    "sindrets/diffview.nvim",
    dependencies = { "nvim-lua/plenary.nvim", "nvim-tree/nvim-web-devicons" },
    cmd = { "DiffviewOpen", "DiffviewClose", "DiffviewToggleFiles", "DiffviewFileHistory" },
    keys = {
        {
            "<leader>gd",
            function()
                if next(require("diffview.lib").views) == nil then
                    vim.cmd("DiffviewOpen")
                else
                    vim.cmd("DiffviewClose")
                end
            end,
            desc = "Diffview: toggle open/close",
        },
        { "<leader>gh", "<cmd>DiffviewFileHistory %<cr>", desc = "Diffview: current file history" },
        { "<leader>gH", "<cmd>DiffviewFileHistory<cr>",   desc = "Diffview: branch history" },
        { "<leader>b",  "<cmd>DiffviewToggleFiles<cr>",   desc = "Diffview: toggle file tree" },
    },
    opts = function()
        local actions = require("diffview.actions")
        return {
            view = {
                merge_tool = {
                    layout = "diff3_mixed",
                    disable_diagnostics = true,
                    winbar_info = true,
                },
            },
            file_panel = {
                listing_style = "tree",
                win_config = { position = "left", width = 35 },
            },
            keymaps = {
                view = {
                    { "n", "<leader>b", actions.toggle_files,     { desc = "Toggle file tree" } },
                    { "n", "q",         "<cmd>DiffviewClose<cr>", { desc = "Close diffview" } },
                },
                file_panel = {
                    { "n", "<leader>b", actions.toggle_files,     { desc = "Toggle file tree" } },
                    { "n", "q",         "<cmd>DiffviewClose<cr>", { desc = "Close diffview" } },
                },
            },
        }
    end,
}
