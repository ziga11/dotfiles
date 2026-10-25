return { -- Fuzzy Finder (files, lsp, etc)
    "nvim-telescope/telescope.nvim",
    event = "VimEnter",
    branch = "master",
    dependencies = {
        "nvim-lua/plenary.nvim",
        {                                             -- If encountering errors, see telescope-fzf-native README for installation instructions
            "nvim-telescope/telescope-fzf-native.nvim",
            build = "make",                           -- Command to run when the plugin is installed/updated
            cond = function()
                return vim.fn.executable("make") == 1 -- Condition to load the plugin
            end,
        },
        { "nvim-telescope/telescope-ui-select.nvim" },
        { "nvim-tree/nvim-web-devicons",            enabled = vim.g.have_nerd_font },
    },
    config = function()
        require("telescope").setup({
            defaults = {
                preview = {
                    treesitter = false,
                },
            },
            extensions = {
                ["ui-select"] = {
                    require("telescope.themes").get_dropdown(),
                },
            },
        })

        -- Safely load extensions
        pcall(require("telescope").load_extension, "fzf")
        pcall(require("telescope").load_extension, "ui-select")

        -- Key mappings for various Telescope functionalities
        local builtin = require("telescope.builtin")
        local map = vim.keymap.set
        local opts = { desc = "[S]earch" } -- Shared options for mapping descriptions
        map("n", "<leader>sh", builtin.help_tags, { desc = opts.desc .. " [H]elp" })
        map("n", "<leader>sk", builtin.keymaps, { desc = opts.desc .. " [K]eymaps" })
        map("n", "<leader>sf", builtin.find_files, { desc = opts.desc .. " [F]iles" })
        map("n", "<leader>sfl", function()
            builtin.find_files({ cwd = vim.fn.expand('%:p:h') })
        end, { desc = opts.desc .. " [F]iles (Local)" })
        map("n", "<leader>sfg", function()
            builtin.find_files({
                cwd = "~",
                hidden = true,
                no_ignore = false
            })
        end, { desc = "[S]earch [F]iles (Global/Home)" })
        map("n", "<leader>ss", builtin.builtin, { desc = opts.desc .. " [S]elect Telescope" })
        map("n", "<leader>sw", builtin.grep_string, { desc = opts.desc .. " current [W]ord" })
        map("n", "<leader>sg", builtin.live_grep, { desc = opts.desc .. " by [G]rep" })
        map("n", "<leader>sgl", function()
            builtin.live_grep({ cwd = vim.fn.expand('%:p:h') })
        end, { desc = opts.desc .. " by [G]rep (Local)" })
        map("n", "<leader>sd", builtin.diagnostics, { desc = opts.desc .. " [D]iagnostics" })
        map("n", "<leader>sr", builtin.resume, { desc = opts.desc .. " [R]esume" })
        map("n", "<leader>s.", builtin.oldfiles, { desc = opts.desc .. ' Recent Files ("." for repeat)' })
        map("n", "<leader><leader>", builtin.buffers, { desc = "[ ] Find existing buffers" })
        map("n", "<leader>/", function()
            builtin.current_buffer_fuzzy_find(require("telescope.themes").get_dropdown({
                winblend = 10,
                previewer = false,
            }))
        end, { desc = "[/] Fuzzily search in current buffer" })
        map("n", "<leader>s/", function()
            builtin.live_grep({
                grep_open_files = true,
                prompt_title = "Live Grep in Open Files",
            })
        end, { desc = "[S]earch [/] in Open Files" })
        map("n", "<leader>sn", function()
            builtin.find_files({ cwd = vim.fn.stdpath("config") })
        end, { desc = "[S]earch [N]eovim files" })
    end,
}
