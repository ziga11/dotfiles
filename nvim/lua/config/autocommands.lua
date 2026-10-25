vim.api.nvim_create_autocmd("TextYankPost", {
    desc = "Highlight when yanking (copying) text",
    group = vim.api.nvim_create_augroup("kickstart-highlight-yank", { clear = true }),
    callback = function()
        vim.highlight.on_yank()
    end,
})

vim.api.nvim_create_autocmd('FileType', {
    pattern = { '<filetype>' },
    callback = function() vim.treesitter.start() end,
})

vim.api.nvim_create_autocmd("FileType", {
    pattern = { "tex", "plaintex" },
    callback = function()
        vim.g.vimtex_fold_enabled = 1

        vim.opt_local.foldmethod = "expr"
        vim.opt_local.foldexpr = "vimtex#fold#level(v:lnum)"

        vim.opt_local.foldlevelstart = -1

        vim.opt_local.viewoptions:append("folds")
        vim.api.nvim_create_autocmd({ "BufWinLeave" }, {
            buffer = 0,
            command = "mkview"
        })
        vim.api.nvim_create_autocmd({ "BufWinEnter" }, {
            buffer = 0,
            command = "silent! loadview"
        })
    end,
})

vim.api.nvim_create_autocmd({ "BufEnter", "BufWinEnter", "WinEnter" }, {
    pattern = "term://*",
    callback = function()
        vim.schedule(function()
            if vim.api.nvim_get_mode().mode ~= 't' then
                vim.cmd("startinsert")
            end
        end)
    end,
})

local function set_tmux_flag(on)
    if not vim.env.TMUX or not vim.env.TMUX_PANE then return end
    local cmd = { 'tmux', 'set-option', '-p', '-t', vim.env.TMUX_PANE }
    if not on then table.insert(cmd, '-u') end
    table.insert(cmd, '@in_toggleterm')
    if on then table.insert(cmd, '1') end
    vim.fn.jobstart(cmd)
end

local group = vim.api.nvim_create_augroup('TmuxToggletermFlag', { clear = true })

vim.api.nvim_create_autocmd({ 'BufEnter', 'WinEnter', 'TermEnter', 'FileType' }, {
    group = group,
    callback = function()
        set_tmux_flag(vim.bo.filetype == 'toggleterm')
    end,
})

vim.api.nvim_create_autocmd({ 'VimLeave', 'VimSuspend' }, {
    group = group,
    callback = function() set_tmux_flag(false) end,
})
