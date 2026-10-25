return {
    "lervag/vimtex",
    lazy = false,
    init = function()
        vim.g.vimtex_view_method = "zathura"

        -- This suppresses the "Compilation started/finished" messages in the echo area
        vim.g.vimtex_echo_ignore_msgs = {
            "Internal error: g:vimtex_compiler_callback",
            "VimTeX: All targets are up to date",
        }
        vim.g.vimtex_quickfix_mode = 0

        vim.g.vimtex_view_method = "zathura"
        vim.g.vimtex_fold_enabled = 1
        vim.api.nvim_create_autocmd("FileType", {
            pattern = { "tex", "latex" },
            callback = function()
                vim.opt_local.foldmethod = "expr"
                vim.opt_local.foldexpr = "vimtex#fold#level(v:lnum)"
            end,
        })
    end
}
