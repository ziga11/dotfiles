return {
    "nvim-treesitter/nvim-treesitter",
    branch = "master",
    build = ":TSUpdate",
    config = function(_, opts)
        local configs = require("nvim-treesitter.configs")
        configs.setup(opts)
    end,
    opts = {
        ensure_installed = {
            "bash", "c", "html", "lua", "luadoc", "markdown", "vim", "vimdoc",
            "javascript", "typescript", "tsx", "jsdoc", "go",
        },
        auto_install = true,
        highlight = {
            enable = true,
            additional_vim_regex_highlighting = false,
            disable = { "latex" },
        },
        indent = { enable = true },
    },
}
