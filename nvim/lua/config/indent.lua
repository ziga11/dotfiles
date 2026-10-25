local indent_group = vim.api.nvim_create_augroup("IndentSettings", { clear = true })

vim.api.nvim_create_autocmd("FileType", {
    pattern = { "json", "html", "lua", "sh", "py", "typescriptreact", "javascriptreact", "sql", },
    group = indent_group,
    callback = function()
        vim.opt_local.shiftwidth = 4
        vim.opt_local.tabstop = 4
    end,
})

vim.api.nvim_create_autocmd("FileType", {
    pattern = { "xml", "yaml", "dart" },
    group = indent_group,
    callback = function()
        vim.opt_local.shiftwidth = 2
        vim.opt_local.tabstop = 2
    end,
})
